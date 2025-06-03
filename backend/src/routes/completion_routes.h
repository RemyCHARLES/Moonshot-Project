// completion_routes.h
#pragma once
#include "crow.h"
#include "../services/db_service.h"

void setupCompletionRoutes(crow::SimpleApp& app) {
    CROW_ROUTE(app, "/users/<int>/completed-lessons").methods("GET"_method)(
        [](const crow::request& req, int userId) {
            DatabaseService db;
            return crow::response(200, db.getCompletedLessons(userId));
        });
}