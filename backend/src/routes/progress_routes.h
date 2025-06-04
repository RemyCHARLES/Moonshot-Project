// src/routes/progress_routes.h
#pragma once
#include <crow.h>
#include "../services/db_service.h"

void setupProgressRoutes(crow::SimpleApp& app) {
    // Get raw progress data for a user
    CROW_ROUTE(app, "/users/<int>/progress").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(db.getUserProgress(userId));
        });

    // Create or update progress for a user
    CROW_ROUTE(app, "/users/<int>/progress").methods("POST"_method)(
        [](const crow::request& req, int userId) {
            auto body = crow::json::load(req.body);
            if (!body)
                return crow::response(400, "Invalid JSON");

            int lesson_id = body["lesson_id"].i();
            DatabaseService db;
            db.markLessonAsCompleted(userId, lesson_id);
            return crow::response(200, "Lesson marked as completed");
        });

    CROW_ROUTE(app, "/users/<int>/progression").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(db.getUserProgress(userId));
        });

}