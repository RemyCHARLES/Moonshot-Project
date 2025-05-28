// src/routes/lesson_routes.h
#include <crow.h>
#include "../services/lesson_service.h"
#include "../services/db_service.h"

void setupLessonRoutes(crow::SimpleApp& app) {
    // Get all lessons
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
    // Get a single lesson by ID
    CROW_ROUTE(app, "/lessons/<int>").methods("GET"_method)([](const crow::request& req, int lessonId){
        std::vector<LessonModel> lessons;
        try {
            lessons = LessonService::loadLessonsFromFile();
        } catch (const std::exception& e) {
            std::cerr << "[ERREUR] Échec du chargement des leçons : " << e.what() << std::endl;
            return crow::response(500, "Erreur lors du chargement des leçons.");
        }

        auto it = std::find_if(lessons.begin(), lessons.end(), [&](const LessonModel& l) {
            return l.id == lessonId;
        });

        if (it == lessons.end()) {
            return crow::response(404, "Leçon non trouvée");
        }

        return crow::response(200, it->serialized_json.dump());
    });

    // Get all pages of a lesson
    CROW_ROUTE(app, "/lessons/<int>/pages").methods("GET"_method)([](const crow::request& req, int lessonId){
        std::vector<LessonModel> lessons;
        try {
            lessons = LessonService::loadLessonsFromFile();
        } catch (const std::exception& e) {
            std::cerr << "[ERREUR] Échec du chargement des leçons : " << e.what() << std::endl;
            return crow::response(500, "Erreur lors du chargement des leçons.");
        }

        auto it = std::find_if(lessons.begin(), lessons.end(), [&](const LessonModel& l) {
            return l.id == lessonId;
        });

        if (it == lessons.end()) {
            return crow::response(404, "Leçon non trouvée");
        }

        nlohmann::json pagesJson = nlohmann::json::array();
        for (const auto& page : it->pages) {
            pagesJson.push_back(page);
        }

        return crow::response(200, pagesJson.dump());
    });

    // Get a specific page of a lesson by lesson ID and page index
    CROW_ROUTE(app, "/lessons/<int>/page/<int>").methods("GET"_method)(
        [](const crow::request& req, int lessonId, int pageIndex){
            std::vector<LessonModel> lessons;
            try {
                lessons = LessonService::loadLessonsFromFile();
            } catch (const std::exception& e) {
                std::cerr << "[ERREUR] Échec du chargement des leçons : " << e.what() << std::endl;
                return crow::response(500, "Erreur lors du chargement des leçons.");
            }

            auto it = std::find_if(lessons.begin(), lessons.end(), [&](const LessonModel& l) {
                return l.id == lessonId;
            });

            if (it == lessons.end() || pageIndex < 0 || pageIndex >= static_cast<int>(it->pages.size())) {
                return crow::response(404, "Page non trouvée");
            }

            const auto& fullPage = it->serialized_json["pages"][pageIndex];
            nlohmann::json pageJson = fullPage;
            pageJson["lessonTitle"] = it->title;
            pageJson["totalPages"] = it->pages.size();
            return crow::response(200, pageJson.dump());
        });
}
