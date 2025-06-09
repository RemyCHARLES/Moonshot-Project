// src/routes/lesson_routes.h
// ------------------------------------------------------------
// Beatquest – Lesson API Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines the HTTP API endpoints related to lessons,
// including loading all lessons, a specific lesson by ID,
// all pages in a lesson, and a specific page by index.
//
// Routes defined:
//   - GET /lessons
//   - GET /lessons/<id>
//   - GET /lessons/<id>/pages
//   - GET /lessons/<id>/page/<index>
//
// These endpoints fetch lesson content either from static files
// or via PostgreSQL when requesting individual pages.
// ------------------------------------------------------------

#include <crow.h>                     // Crow framework for routing
#include "../services/lesson_service.h"  // Service to load lesson content from files
#include "../services/db_service.h"      // Service to access lesson pages from database

// Registers all lesson-related routes in the application
void setupLessonRoutes(crow::SimpleApp& app) {
    // ------------------------------------------------------------
    // GET /lessons
    // Fetch all lessons from static file and return as JSON array
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/lessons").methods("GET"_method)([](const crow::request& req){
        std::vector<LessonModel> lessons;
        try {
            lessons = LessonService::loadLessonsFromFile();
        } catch (const std::exception& e) {
            std::cerr << "[ERREUR] Échec du chargement des leçons : " << e.what() << std::endl;
            return crow::response(500, "Erreur lors du chargement des leçons.");
        }

        nlohmann::json lessons_json = nlohmann::json::array();
        std::cout << "[INFO] Nombre de leçons chargées : " << lessons.size() << std::endl;
        for (const auto& lesson : lessons) {
            lessons_json.push_back(lesson.serialized_json);
        }
        return crow::response(200, lessons_json.dump());  // Retourner les leçons en JSON
    });

    // ------------------------------------------------------------
    // GET /lessons/<id>
    // Fetch a specific lesson by its ID from file
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/lessons/<int>").methods("GET"_method)([](const crow::request& req, int lessonId){
        std::vector<LessonModel> lessons;
        try {
            lessons = LessonService::loadLessonsFromFile();
        } catch (const std::exception& e) {
            std::cerr << "[ERREUR] Échec du chargement des leçons : " << e.what() << std::endl;
            return crow::response(500, "Erreur lors du chargement des leçons.");
        }

        // Search lesson by ID
        auto it = std::find_if(lessons.begin(), lessons.end(), [&](const LessonModel& l) {
            return l.id == lessonId;
        });

        if (it == lessons.end()) {
            return crow::response(404, "Leçon non trouvée");
        }

        return crow::response(200, it->serialized_json.dump());
    });

    // ------------------------------------------------------------
    // GET /lessons/<id>/pages
    // Return all pages for a specific lesson
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/lessons/<int>/pages").methods("GET"_method)([](const crow::request& req, int lessonId){
        std::vector<LessonModel> lessons;
        try {
            lessons = LessonService::loadLessonsFromFile();
        } catch (const std::exception& e) {
            std::cerr << "[ERREUR] Échec du chargement des leçons : " << e.what() << std::endl;
            return crow::response(500, "Erreur lors du chargement des leçons.");
        }

        // Locate the lesson
        auto it = std::find_if(lessons.begin(), lessons.end(), [&](const LessonModel& l) {
            return l.id == lessonId;
        });

        if (it == lessons.end()) {
            return crow::response(404, "Leçon non trouvée");
        }

        // Serialize all pages
        nlohmann::json pagesJson = nlohmann::json::array();
        for (const auto& page : it->pages) {
            pagesJson.push_back(page);
        }

        return crow::response(200, pagesJson.dump());
    });

    // ------------------------------------------------------------
    // GET /lessons/<id>/page/<index>
    // Fetch a specific page from a lesson via database
    // ------------------------------------------------------------
    CROW_ROUTE(app, "/lessons/<int>/page/<int>").methods("GET"_method)(
        [](const crow::request& req, int lessonId, int pageIndex){
            try {
                DatabaseService db;
                return crow::response(200, db.getLessonPage(lessonId, pageIndex));
            } catch (const std::exception& e) {
                std::cerr << "[ERREUR] Chargement de page depuis la BDD : " << e.what() << std::endl;
                return crow::response(500, "Erreur serveur");
            }
        });
}
