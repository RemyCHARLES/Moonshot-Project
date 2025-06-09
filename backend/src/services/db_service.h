#ifndef DB_SERVICE_H
#define DB_SERVICE_H

// ------------------------------------------------------------
// Beatquest – Database Service Header
// ------------------------------------------------------------
// This header defines the DatabaseService class, which acts as
// the main abstraction layer between the backend logic and the
// PostgreSQL database.
//
// It exposes methods for fetching lessons, tracking user progress,
// recording performance scores, managing rewards, and authenticating
// user sessions.
//
// The actual implementations are in db_service.cpp
// ------------------------------------------------------------

#include <pqxx/pqxx>   // PostgreSQL client library
#include <string>      // For std::string

class DatabaseService {
public:
    // Establish and return a PostgreSQL database connection
    pqxx::connection connect();

    // Fetch all available lessons from the database
    std::string getAllLessons();

    // Fetch a specific lesson by its ID
    std::string getLessonById(int id);

    // Fetch all pages associated with a given lesson ID
    std::string getPagesByLessonId(int lessonId);

    // Fetch a single page from a lesson (by lesson ID and page index)
    std::string getLessonPage(int lessonId, int pageIndex);

    // Insert a reward record for a specific user
    void insertUserReward(int userId, const std::string& rewardName, const std::string& earnedAt);

    // Create or update a user's progress on a lesson
    void upsertUserProgress(int userId, int lessonId, bool completed, const std::string& updatedAt);

    // Create a performance entry for a user and session
    void createPerformance(int userId, int sessionId, int lessonId, int score, const std::string& timestamp);

    // Mark a lesson as completed for a user
    void markLessonAsCompleted(int userId, int lessonId);

    // Fetch the list of completed lessons for a given user
    std::string getCompletedLessons(int userId);

    // Fetch all progress data for a specific user
    std::string getUserProgress(int userId);

    // Fetch all rewards earned by a specific user
    std::string getUserRewards(int userId);

    // Fetch all performance records for a user
    std::string getPerformancesByUserId(int userId);

    // Return the last unlocked lesson ID for a given user
    int getLastUnlockedLesson(int userId);
};

// Simple function to test if DB connection can be established
void test_connection();

#endif