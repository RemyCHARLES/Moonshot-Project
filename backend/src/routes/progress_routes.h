// src/routes/progress_routes.h
#pragma once
#include <crow.h>
#include "../services/db_service.h"

void setupProgressRoutes(crow::SimpleApp& app) {
    // Get progress for a user
    CROW_ROUTE(app, "/users/<int>/progress").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(db.getUserProgress(userId));
        });

    // Update or create progress
    CROW_ROUTE(app, "/users/<int>/progress").methods("POST"_method)(
        [](const crow::request& req, int userId) {
            auto body = crow::json::load(req.body);
            if (!body)
                return crow::response(400, "Invalid JSON");

            int lesson_id = body["lesson_id"].i();
            bool completed = body["completed"].b();
            std::string updated_at = body["updated_at"].s();

            DatabaseService db;
            db.upsertUserProgress(userId, lesson_id, completed, updated_at);
            return crow::response(200, "Progress updated");
        });
}