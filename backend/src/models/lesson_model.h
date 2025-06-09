// src/models/lesson_model.h
// -------------------------------------------
// Beatquest – Backend Data Model (Lesson)
// -------------------------------------------
// This header defines the data structures used to represent
// a lesson and its internal steps (pages) in the application.
// Lessons are composed of multiple pages, each with a step index
// and associated content (text or HTML).
//
// The `LessonModel` class is used to store and serialize a complete
// lesson object, while `PageModel` is a substructure for individual steps.
// This model is serialized and passed via JSON between the backend and frontend.
//
// Dependencies: nlohmann::json (for JSON serialization)
// -------------------------------------------

#ifndef LESSON_MODEL_H
#define LESSON_MODEL_H

#include <string>   // For std::string
#include <vector>   // For std::vector

// -------------------------------------------
// PageModel
// Represents a single step/page in a lesson
// -------------------------------------------
struct PageModel {
    int step;               // Step number (0-based index in the lesson)
    std::string content;    // Text or HTML content of the page
};

// JSON serialization for PageModel
// Converts a PageModel struct into a JSON object with keys "step" and "content"
inline void to_json(nlohmann::json& j, const PageModel& p) {
    j = nlohmann::json{{"step", p.step}, {"content", p.content}};
}

// -------------------------------------------
// LessonModel
// Represents a complete lesson, including pages
// -------------------------------------------
class LessonModel {
public:
    int id;                             // Unique identifier for the lesson
    std::string title;                  // Title of the lesson
    std::vector<PageModel> pages;       // Ordered list of pages (steps) in the lesson
    nlohmann::json serialized_json;     // Optional raw serialized version of the lesson (for caching or reuse)

    // Serializes the lesson into a JSON object
    // Includes id, title, and an array of pages
    nlohmann::json to_json() const {
        nlohmann::json j;
        j["id"] = id;
        j["title"] = title;
        j["pages"] = nlohmann::json::array();
        for (const auto& page : pages) {
            j["pages"].push_back({{"step", page.step}, {"content", page.content}});
        }
        return j;
    }
};

#endif // LESSON_MODEL_H