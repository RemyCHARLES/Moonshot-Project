#ifndef DB_SERVICE_H
#define DB_SERVICE_H

#include <pqxx/pqxx>
#include <string>

class DatabaseService {
public:
    pqxx::connection connect();

    std::string getAllLessons();
    std::string getLessonById(int id);
    std::string getPagesByLessonId(int lessonId);

    // Function to get a specific lesson page
    std::string getLessonPage(int lessonId, int pageIndex);

    // Function to insert user reward
    void insertUserReward(int userId, const std::string& rewardName, const std::string& earnedAt);

    // Function to insert user progress
    void upsertUserProgress(int userId, int lessonId, bool completed, const std::string& updatedAt);

    // Function to create a performance
    void createPerformance(int userId, int sessionId, int lessonId, int score, const std::string& timestamp);

    // Function to mark a lesson as completed
    void markLessonAsCompleted(int userId, int lessonId);

    // Function to get completed lessons
    std::string getCompletedLessons(int userId);

    // Function to get user progress
    std::string getUserProgress(int userId);

    // Function to get user rewards
    std::string getUserRewards(int userId);

    // Function to get user performances
    std::string getPerformancesByUserId(int userId);
};

// Function to test the connection
void test_connection();

#endif