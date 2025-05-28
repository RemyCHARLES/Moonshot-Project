// src/routes/reward_routes.h
#pragma once
#include <crow.h>
#include "../services/db_service.h"

void setupRewardRoutes(crow::SimpleApp& app) {
    // Get all rewards for a user
    CROW_ROUTE(app, "/users/<int>/rewards").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(db.getUserRewards(userId));
        });

    // Add a new reward for a user
    CROW_ROUTE(app, "/users/<int>/rewards").methods("POST"_method)(
        [](const crow::request& req, int userId) {
            auto body = crow::json::load(req.body);
            if (!body)
                return crow::response(400, "Invalid JSON");

            std::string reward_name = body["reward_name"].s();
            std::string earned_at = body["earned_at"].s();

            DatabaseService db;
            db.insertUserReward(userId, reward_name, earned_at);
            return crow::response(200, "Reward added");
        });
}