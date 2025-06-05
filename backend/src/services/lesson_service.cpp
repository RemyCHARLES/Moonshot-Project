// src/services/lesson_service.cpp
#include "lesson_service.h"
#include <fstream>
#include <iostream> 
#include "json.hpp"
#include "../models/lesson_model.h"
#include "../models/page_model.h"
#include <pqxx/pqxx>

// Dans lesson_service.cpp
std::vector<LessonModel> LessonService::loadLessonsFromFile() {
    std::ifstream file("../src/assets/data/lessons.json", std::ios::binary);
    if (!file) {
        std::cerr << "[ERREUR] Impossible d’ouvrir le fichier JSON.\n";
        throw std::runtime_error("Fichier JSON introuvable.");
    }
    std::ostringstream oss;
    oss << file.rdbuf();
    std::string content = oss.str();
    nlohmann::json lessons = nlohmann::json::parse(content);

    std::vector<LessonModel> lessonList;

    for (const auto& lessonData : lessons) {
        LessonModel lesson;
        lesson.id = lessonData["id"];
        lesson.title = lessonData["title"];
        int totalPages = lessonData["pages"].size();

        nlohmann::json lesson_json;
        lesson_json["id"] = lesson.id;
        lesson_json["title"] = lesson.title;
        lesson_json["totalPages"] = totalPages;
        lesson_json["pages"] = nlohmann::json::array();

        int step = 0;
        for (const auto& page : lessonData["pages"]) {
            PageModel p;
            p.step = step++;
            // p.type = page.contains("type") ? page["type"] : "text"; // PageModel doesn't have type
            p.content = page.contains("question") ? page["question"] : page["content"];
            lesson.pages.push_back(p);

            nlohmann::json page_json;
            page_json["type"] = page.contains("type") ? page["type"] : "text";
            page_json["question"] = p.content;
            page_json["options"] = page.contains("options") ? page["options"] : nlohmann::json();
            page_json["correctIndex"] = page.contains("correctIndex") ? page["correctIndex"] : nlohmann::json();
            page_json["explanation"] = page.contains("explanation") ? page["explanation"] : nlohmann::json();
            page_json["fileA"] = page.contains("fileA") ? page["fileA"] : nlohmann::json();
            page_json["fileB"] = page.contains("fileB") ? page["fileB"] : nlohmann::json();
            page_json["initialOffsetMs"] = page.contains("initialOffsetMs") ? page["initialOffsetMs"] : nlohmann::json(nullptr);
            page_json["toleranceMs"] = page.contains("toleranceMs") ? page["toleranceMs"] : nlohmann::json(nullptr);
            page_json["successDurationMs"] = page.contains("successDurationMs") ? page["successDurationMs"] : nlohmann::json(nullptr);
            lesson_json["pages"].push_back(page_json);
        }

        lesson.serialized_json = lesson_json;
        lessonList.push_back(lesson);
    }

    return lessonList;
}

void LessonService::syncLessonsToDb(const std::vector<LessonModel>& lessons) {
    pqxx::connection conn("dbname=dj_app user=postgres");
    pqxx::work txn(conn);

    for (const auto& lesson : lessons) {
        txn.exec_params(
            "INSERT INTO lessons (id, title, position) "
            "VALUES ($1, $2, $3) "
            "ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, position = EXCLUDED.position;",
            lesson.id,
            lesson.title,
            lesson.id  // using lesson ID as position for now
        );

        // Clear existing pages for this lesson
        txn.exec_params("DELETE FROM pages WHERE lesson_id = $1;", lesson.id);

        for (const auto& page : lesson.pages) {
            const auto& page_json = lesson.serialized_json["pages"][page.step];
            txn.exec_params(
                "INSERT INTO pages (lesson_id, position, content, type) VALUES ($1, $2, $3, $4);",
                lesson.id,
                page.step,
                page_json.dump(),
                page_json["type"].get<std::string>()
            );
        }
    }

    txn.commit();
    std::cout << "✅ Leçons et pages synchronisées depuis le fichier JSON.\n";
}