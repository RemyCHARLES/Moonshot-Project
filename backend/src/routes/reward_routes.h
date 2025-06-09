// src/routes/reward_routes.h
// ------------------------------------------------------------
// Beatquest – Reward Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines the API endpoints for managing user rewards
// such as badges, achievements, or unlockable items.
//
// Routes:
//   - GET /users/<userId>/rewards     → Get all rewards for a user
//   - POST /users/<userId>/rewards    → Add a new reward for a user
//
// These routes support the gamification system by enabling dynamic
// assignment and retrieval of earned progress incentives.
// ------------------------------------------------------------

#pragma once

#include <crow.h>                  // Crow framework for routing
#include "../services/db_service.h" // Database access abstraction

// Registers reward-related routes to the Crow app
void setupRewardRoutes(crow::SimpleApp& app) {
    // ------------------------------------------------------------
    // GET /users/<int>/rewards
    // Returns all rewards assigned to a specific user
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/users/<int>/rewards").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;                       // Instantiate DB service
            return crow::response(db.getUserRewards(userId));  // Fetch rewards
        });

    // ------------------------------------------------------------
    // POST /users/<int>/rewards
    // Adds a new reward (e.g., badge) for the user
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/users/<int>/rewards").methods("POST"_method)(
        [](const crow::request& req, int userId) {
            auto body = crow::json::load(req.body);   // Parse incoming JSON
            if (!body)
                return crow::response(400, "Invalid JSON");  // Reject if malformed

            std::string reward_name = body["reward_name"].s();  // Reward identifier
            std::string earned_at = body["earned_at"].s();      // Timestamp or event date

            DatabaseService db;                          // DB connection
            db.insertUserReward(userId, reward_name, earned_at);  // Insert reward into DB
            return crow::response(200, "Reward added");   // Confirm success
        });
}