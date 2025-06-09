// src/routes/progress_routes.h
// ------------------------------------------------------------
// Beatquest – User Progress Tracking Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines API endpoints for managing and retrieving user
// progress through lessons. Progress is stored in the database and
// can be fetched or updated via HTTP requests.
//
// Routes:
//   - GET /users/<userId>/progress        → Get raw progress data
//   - POST /users/<userId>/progress       → Mark a lesson as completed
//   - GET /users/<userId>/progression     → Alias route for progress (optional)
//
// These routes support gamification and dashboard display features.
// ------------------------------------------------------------

#pragma once

#include <crow.h>                  // Crow framework for routing and request handling
#include "../services/db_service.h" // Access to database service for persistence

// Registers user progress tracking routes
void setupProgressRoutes(crow::SimpleApp& app) {
    // ------------------------------------------------------------
    // GET /users/<userId>/progress
    // Returns raw progress data for the given user
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/users/<int>/progress").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(db.getUserProgress(userId));
        });

    // ------------------------------------------------------------
    // POST /users/<int>/progress
    // Marks a specific lesson as completed for a user
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/users/<int>/progress").methods("POST"_method)(
        [](const crow::request& req, int userId) {
            auto body = crow::json::load(req.body);  // Parse request JSON
            if (!body)
                return crow::response(400, "Invalid JSON");

            int lesson_id = body["lesson_id"].i();   // Extract lesson ID
            DatabaseService db;
            db.markLessonAsCompleted(userId, lesson_id);  // Update DB
            return crow::response(200, "Lesson marked as completed");
        });

    // ------------------------------------------------------------
    // GET /users/<int>/progression
    // Duplicate route for compatibility or legacy support
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/users/<int>/progression").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(db.getUserProgress(userId));
        });
}