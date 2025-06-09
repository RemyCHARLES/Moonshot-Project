// src/services/lesson_service.h
// ------------------------------------------------------------
// Beatquest – Lesson Service Header
// ------------------------------------------------------------
// This header defines the LessonService class responsible for:
//   - Loading lessons and their associated pages from a JSON file
//   - Accessing lesson models from memory
//   - Synchronizing lesson and page data into PostgreSQL
//
// This service supports both static content delivery and
// database-backed lesson rendering.
//
// Dependencies:
//   - nlohmann::json
//   - LessonModel and PageModel
// ------------------------------------------------------------

#ifndef LESSON_SERVICE_H
#define LESSON_SERVICE_H

#include <vector>                  // For std::vector
#include "json.hpp"               // For nlohmann::json handling
#include "../models/lesson_model.h"  // Lesson data structure
#include "../models/page_model.h"    // Page (step) data structure

class LessonService {
public:
    // Load all lessons and their pages from a static JSON file
    static std::vector<LessonModel> loadLessonsFromFile();

    // Return all lessons from memory or database (future use)
    static std::vector<LessonModel> getAllLessons();

    // Retrieve a specific lesson object by its ID
    static LessonModel getLessonById(int lessonId);

    // Push lessons and their pages into the PostgreSQL database
    static void syncLessonsToDb(const std::vector<LessonModel>& lessons);
};

#endif // LESSON_SERVICE_H