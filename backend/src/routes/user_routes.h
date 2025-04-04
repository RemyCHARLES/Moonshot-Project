#pragma once
#include "crow.h"
#include "../services/db_service.h"
#include <pqxx/zview>

void add_user_routes(crow::SimpleApp& app) {
    CROW_ROUTE(app, "/users").methods("POST"_method)([](const crow::request& req) {
        auto body = crow::json::load(req.body);
        if (!body) {
            return crow::response(400, "Invalid JSON");
        }

        std::string username = body["username"].s();
        std::string password = body["password"].s(); // In production: hash this!

        try {
            DatabaseService db;
            pqxx::connection conn = db.connect();
            pqxx::work txn(conn);

            txn.exec(
                pqxx::zview("INSERT INTO users (username, password) VALUES ($1, $2)"),
                pqxx::params(username, password)
            );

            txn.commit();
            return crow::response(201, "User created successfully");
        } catch (const std::exception& e) {
            return crow::response(500, std::string("Error: ") + e.what());
        }
    });
}
