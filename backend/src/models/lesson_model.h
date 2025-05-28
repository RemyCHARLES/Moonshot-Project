// src/models/lesson_model.h
#ifndef LESSON_MODEL_H
#define LESSON_MODEL_H

#include <string>
#include <vector>

struct PageModel {
    int step;
    std::string content;
};

inline void to_json(nlohmann::json& j, const PageModel& p) {
    j = nlohmann::json{{"step", p.step}, {"content", p.content}};
}

class LessonModel {
public:
    int id;
    std::string title;
    std::vector<PageModel> pages;
    nlohmann::json serialized_json;

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