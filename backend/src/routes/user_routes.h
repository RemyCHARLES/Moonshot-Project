// backend/src/routes/user_routes.h
// ------------------------------------------------------------
// Beatquest – User Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines all user-related routes for registration,
// login, and authenticated session retrieval. It includes JWT-based
// authentication and uses PostgreSQL for persistence.
//
// Routes:
//   - POST /register       → Create a new user and return JWT
//   - POST /login          → Authenticate user and return JWT
//   - GET /me/sessions     → Return user’s session history (requires JWT)
//
// Dependencies:
//   - crow.h : Lightweight web server
//   - pqxx   : PostgreSQL C++ client
//   - jwt-cpp: JWT generation and decoding
// ------------------------------------------------------------

#pragma once

#include "crow.h"                       // Crow web server framework
#include "../services/db_service.h"    // DB access layer
#include <pqxx/zview>                  // PostgreSQL result processing
#include <jwt-cpp/jwt.h>               // JWT creation and decoding

// Registers user-related API endpoints
void add_user_routes(crow::SimpleApp& app) {
    // ------------------------------------------------------------
    // POST /register
    // Registers a new user (username, email, password)
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/register").methods("POST"_method)([](const crow::request& req) {
        auto body = crow::json::load(req.body);  // Parse request JSON
        if (!body)
            return crow::response(400, "Invalid JSON");

        std::string username = body["username"].s();
        std::string email = body["email"].s();
        std::string password = body["password"].s();

        try {
            DatabaseService db;
            pqxx::connection conn = db.connect();
            pqxx::work txn(conn);

            // Check if user already exists
            pqxx::result check = txn.exec_params(
                "SELECT id FROM users WHERE username = $1 OR email = $2",
                username,
                email
            );
            if (!check.empty()) {
                return crow::response(409, "User already exists");
            }

            // Insert new user
            pqxx::result result = txn.exec_params(
                "INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id",
                username,
                email,
                password
            );
            int user_id = result[0]["id"].as<int>();
            txn.commit();

            // Create JWT token
            auto token = jwt::create()
                .set_issuer("dj-app")
                .set_type("JWS")
                .set_payload_claim("user_id", jwt::claim(std::to_string(user_id)))
                .set_payload_claim("username", jwt::claim(username))
                .set_expires_at(std::chrono::system_clock::now() + std::chrono::minutes{60})
                .sign(jwt::algorithm::hs256{"your-secret-key"});

            crow::json::wvalue response;
            response["token"] = token;
            return crow::response(201, response);
        } catch (const std::exception& e) {
            return crow::response(500, std::string("Error: ") + e.what());
        }
    });

    // ------------------------------------------------------------
    // POST /login
    // Authenticates user and returns JWT + user data
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/login").methods("POST"_method)([](const crow::request& req) {
        auto body = crow::json::load(req.body);
        if (!body)
            return crow::response(400, "Invalid JSON");

        std::string username = body["username"].s();
        std::string password = body["password"].s();

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

            int user_id = r[0]["id"].as<int>();

            auto token = jwt::create()
                .set_issuer("dj-app")
                .set_type("JWS")
                .set_payload_claim("user_id", jwt::claim(std::to_string(user_id)))
                .set_payload_claim("username", jwt::claim(username))
                .set_expires_at(std::chrono::system_clock::now() + std::chrono::minutes{60})
                .sign(jwt::algorithm::hs256{"your-secret-key"});

            crow::json::wvalue response;
            response["token"] = token;
            response["user_id"] = user_id;
            response["username"] = username;
            return crow::response{response};
        } catch (const std::exception& e) {
            return crow::response(500, std::string("Error: ") + e.what());
        }
    });

    // ------------------------------------------------------------
    // GET /me/sessions
    // Returns sessions for the authenticated user
    // Requires: Bearer Token in Authorization header
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/me/sessions").methods("GET"_method)([](const crow::request& req) {
        try {
            std::string auth_header = req.get_header_value("Authorization");
            std::string token = auth_header.substr(strlen("Bearer "));
            auto decoded_token = jwt::decode(token);

            // Extract user ID from token
            int user_id = std::stoi(decoded_token.get_payload_claim("user_id").as_string());

            DatabaseService db;
            pqxx::connection conn = db.connect();
            pqxx::work txn(conn);

            // Set row-level context for PostgreSQL RLS policies
            txn.exec_params("SELECT set_config('app.current_user_id', $1, false)", std::to_string(user_id));

            pqxx::result r = txn.exec_params(
                "SELECT id, user_id, started_at FROM sessions WHERE user_id = current_setting('app.current_user_id')::int ORDER BY started_at DESC"
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
