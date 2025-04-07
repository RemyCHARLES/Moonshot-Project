#pragma once
#include "crow.h"
#include "../services/db_service.h"
#include <pqxx/zview>

void add_user_routes(crow::SimpleApp& app) {
    CROW_ROUTE(app, "/register").methods("POST"_method)([](const crow::request& req) {
        auto body = crow::json::load(req.body);
        if (!body)
            return crow::response(400, "Invalid JSON");
    
        std::string username = body["username"].s();
        std::string email = body["email"].s();
        std::string password = body["password"].s();
    
        try {
            DatabaseService db;
            pqxx::connection conn = db.connect();
            pqxx::work txn(conn);
    
            txn.exec_params(
                "INSERT INTO users (username, email, password) VALUES ($1, $2, $3)",
                username,
                email,
                password
            );
    
            txn.commit();
            return crow::response(201, "User registered");
        } catch (const std::exception& e) {
            return crow::response(500, std::string("Error: ") + e.what());
        }
    });

    CROW_ROUTE(app, "/login").methods("POST"_method)([](const crow::request& req) {
        auto body = crow::json::load(req.body);
        if (!body)
            return crow::response(400, "Invalid JSON");

        std::string username = body["username"].s();
        std::string password = body["password"].s();
        std::cout << "username: " << username << ", password: " << password << std::endl;

        try {
            DatabaseService db;
            pqxx::connection conn = db.connect();
            pqxx::work txn(conn);

            pqxx::result r = txn.exec_params(
                "SELECT id FROM users WHERE username = $1 AND password = $2",
                username,
                password
            );

            if (r.empty()) {
                return crow::response(401, "Invalid credentials");
            }

            // Assuming the first row contains the user ID
            int user_id = r[0]["id"].as<int>();

            txn.exec("SET LOCAL app.current_user_id = " + txn.quote(user_id));
            txn.exec_params(
                "INSERT INTO sessions (user_id, started_at) VALUES ($1, NOW())",
                user_id
            );

            txn.exec("GRANT USAGE, SELECT ON SEQUENCE sessions_id_seq TO dj_user;");

            txn.commit();
            return crow::response(200, "Login successful");
        } catch (const std::exception& e) {
            return crow::response(500, std::string("Error: ") + e.what());
        }
    });

    CROW_ROUTE(app, "/me/sessions").methods("GET"_method)([](const crow::request& req) {
        try {
            auto url_params = crow::query_string(req.url_params);
            if (!url_params.get("user_id")) {
                return crow::response(400, "Missing user_id");
            }

            DatabaseService db;
            pqxx::connection conn = db.connect();
            pqxx::work txn(conn);

            int user_id = std::stoi(req.url_params.get("user_id"));
            pqxx::result r = txn.exec_params(
                "SELECT id, user_id, started_at FROM sessions WHERE user_id = $1 ORDER BY started_at DESC",
                user_id
            );

            crow::json::wvalue result;
            std::vector<crow::json::wvalue> sessions;

            for (const auto& row : r) {
                crow::json::wvalue session;
                session["id"] = row["id"].as<int>();
                session["user_id"] = row["user_id"].as<int>();
                session["started_at"] = row["started_at"].as<std::string>();
                sessions.push_back(session);
            }

            result["sessions"] = std::move(sessions);
            return crow::response{result};
        } catch (const std::exception& e) {
            return crow::response(500, std::string("Error: ") + e.what());
        }
    });
}
