// backend/src/routes/page_routes.h
// ------------------------------------------------------------
// Beatquest – Lesson Page Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines the route for retrieving all pages associated
// with a specific lesson using the lesson ID. The response is pulled
// from the database via a service abstraction.
//
// Route:
//   - GET /lessons/<lessonId>/pages
//
// This endpoint supports rendering full lessons in the frontend by
// retrieving the full ordered list of steps (pages).
// ------------------------------------------------------------

#pragma once

#include <crow.h>                  // Crow framework for HTTP server and routing
#include "../services/db_service.h" // Custom database service for querying page data

// Registers the page route handler to the Crow application
void setupPageRoutes(crow::SimpleApp& app) {
    // ------------------------------------------------------------
    // GET /lessons/<lessonId>/pages
    // Returns all pages for a lesson from the database in JSON
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/lessons/<int>/pages").methods("GET"_method)(
        [](const crow::request& req, int lessonId) {
            DatabaseService db;  // Create database service instance
            // Fetch and return all pages for the lesson ID
            return crow::response(db.getPagesByLessonId(lessonId));
        });
}