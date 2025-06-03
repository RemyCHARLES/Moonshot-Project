// src/services/lesson_service.h
#ifndef LESSON_SERVICE_H
#define LESSON_SERVICE_H

#include <vector>
#include "json.hpp"

// Include any other necessary headers (e.g., for database interaction)
#include "../models/lesson_model.h"  // Suppose you have a model for the lessons, change according to your project structure
#include "../models/page_model.h"

class LessonService {
public:
    // Method to load all lessons from the file or database
    static std::vector<LessonModel> loadLessonsFromFile();

    // Other service methods related to lessons
    static std::vector<LessonModel> getAllLessons();
    static LessonModel getLessonById(int lessonId);
    static void syncLessonsToDb(const std::vector<LessonModel>& lessons);
    static void syncPagesToDb(int lessonId, const std::vector<PageModel>& pages); 
};

#endif // LESSON_SERVICE_H