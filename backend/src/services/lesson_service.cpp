// src/services/lesson_service.cpp
#include "lesson_service.h"
#include <fstream>
#include <iostream> 
#include "json.hpp"
#include "../models/lesson_model.h"

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

        for (const auto& page : lessonData["pages"]) {
            PageModel p;
            p.step = 0;
            p.content = page.contains("question") ? page["question"] : page["content"];
            lesson.pages.push_back(p);

            nlohmann::json page_json;
            page_json["type"] = page.contains("type") ? page["type"] : "text";
            page_json["question"] = p.content;
            page_json["options"] = page.contains("options") ? page["options"] : nlohmann::json();
            page_json["correctIndex"] = page.contains("correctIndex") ? page["correctIndex"] : nlohmann::json();
            page_json["explanation"] = page.contains("explanation") ? page["explanation"] : nlohmann::json();
            lesson_json["pages"].push_back(page_json);
        }

        lesson.serialized_json = lesson_json;
        lessonList.push_back(lesson);
    }

    return lessonList;
}