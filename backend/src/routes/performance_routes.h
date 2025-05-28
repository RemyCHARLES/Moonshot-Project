// src/routes/performance_routes.h
#pragma once
#include <crow.h>
#include "../services/db_service.h"

void setupPerformanceRoutes(crow::SimpleApp& app) {
    // Get all performances for a user
    CROW_ROUTE(app, "/users/<int>/performances").methods("GET"_method)([](const crow::request& req, int userId) {
        DatabaseService db;
        return crow::response(db.getPerformancesByUserId(userId));
    });

    // Create a new performance
    CROW_ROUTE(app, "/performances").methods("POST"_method)([](const crow::request& req) {
        auto body = crow::json::load(req.body);
        if (!body)
            return crow::response(400, "Invalid JSON");

        int user_id = body["user_id"].i();
        int session_id = body["session_id"].i();
        int lesson_id = body["lesson_id"].i();
        int score = body["score"].i();
        std::string timestamp = body["timestamp"].s();

        DatabaseService db;
        db.createPerformance(user_id, session_id, lesson_id, score, timestamp);
        return crow::response(200, "Performance created");
    });
}