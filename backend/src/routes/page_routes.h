#pragma once
#include <crow.h>
#include "../services/db_service.h"

void setupPageRoutes(crow::SimpleApp& app) {
    // Get all pages for a lesson
    CROW_ROUTE(app, "/lessons/<int>/pages").methods("GET"_method)(
        [](const crow::request& req, int lessonId) {
            DatabaseService db;
            return crow::response(db.getPagesByLessonId(lessonId));
        });
}