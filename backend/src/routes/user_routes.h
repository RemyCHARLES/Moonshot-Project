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
}
