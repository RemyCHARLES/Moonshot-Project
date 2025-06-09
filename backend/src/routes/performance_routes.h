// src/routes/performance_routes.h
// ------------------------------------------------------------
// Beatquest – Performance Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines the API routes related to performance tracking,
// including retrieving all user performances and creating new ones.
// Performances are tracked per session and lesson, and include a score
// and timestamp.
//
// Routes:
//   - GET /users/<userId>/performances
//   - POST /performances
//
// These endpoints are essential for feedback, scoring history, and
// enabling leaderboard or analytics features.
// ------------------------------------------------------------

#pragma once

#include <crow.h>                  // Crow framework for HTTP server and routing
#include "../services/db_service.h" // Database service abstraction

// Registers performance-related routes in the Crow application
void setupPerformanceRoutes(crow::SimpleApp& app) {
    // ------------------------------------------------------------
    // GET /users/<userId>/performances
    // Fetches all performance records for a given user
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/users/<int>/performances").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;  // Initialize database service
            return crow::response(db.getPerformancesByUserId(userId));  // Query and return result
        });

    // ------------------------------------------------------------
    // POST /performances
    // Creates a new performance record with session and score
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/performances").methods("POST"_method)(
        [](const crow::request& req) {
            auto body = crow::json::load(req.body);  // Parse request body as JSON
            if (!body)
                return crow::response(400, "Invalid JSON");

            // Extract required fields from the JSON
            int user_id = body["user_id"].i();
            int session_id = body["session_id"].i();
            int lesson_id = body["lesson_id"].i();
            int score = body["score"].i();
            std::string timestamp = body["timestamp"].s();

            // Create new performance entry in the database
            DatabaseService db;
            db.createPerformance(user_id, session_id, lesson_id, score, timestamp);
            return crow::response(200, "Performance created");
        });
}