// backend/src/routes/completion_routes.h
// ------------------------------------------------------------
// Beatquest – Completed Lessons API Routes
// ------------------------------------------------------------
// This file defines the route used to fetch all completed lessons
// for a specific user. It queries the PostgreSQL database using the
// `DatabaseService` abstraction and returns a JSON-formatted list
// of completed lesson IDs or details.
//
// Route:
//   GET /users/<userId>/completed-lessons
//
// This endpoint is essential for tracking user progress and enabling
// adaptive content or rewards.
// ------------------------------------------------------------

#pragma once

#include "crow.h"                  // Crow framework for defining HTTP routes
#include "../services/db_service.h" // Database service abstraction

// Registers the completed lessons endpoint to the Crow app
void setupCompletionRoutes(crow::SimpleApp& app) {
    // GET /users/<userId>/completed-lessons
    // Returns the completed lessons of a user in JSON format
    CROW_ROUTE(app, "/users/<int>/completed-lessons").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;  // Create DB service instance
            // Query and return completed lessons as JSON
            return crow::response(200, db.getCompletedLessons(userId));
        });
}