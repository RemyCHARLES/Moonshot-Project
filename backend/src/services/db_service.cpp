// backend/src/services/db_service.cpp
// ------------------------------------------------------------
// Beatquest – Database Service Implementation
// ------------------------------------------------------------
// This file contains all implementations for the DatabaseService class.
// It provides methods for interacting with the PostgreSQL database,
// including:
//   - Lesson and page retrieval
//   - User progress tracking
//   - Performance scoring
//   - Reward management
//   - Session handling (JWT-based)
//
// Each method connects, queries, and formats the results as JSON strings
// returned to the Crow API routes. The service also handles
// insert/update logic with proper exception handling.
//
// Dependencies: libpqxx (PostgreSQL C++ client)
// ------------------------------------------------------------

#include "db_service.h"
#include <pqxx/pqxx>
#include <iostream>

// Method to test the database connection
// Attempts to connect to the database and prints out all usernames for verification.
void test_connection() {
    try {
        pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");

        if (conn.is_open()) {
            std::cout << "✅ Connected to database: " << conn.dbname() << std::endl;

            pqxx::work txn(conn);
            // Execute a simple query to fetch all usernames
            pqxx::result r = txn.exec("SELECT username FROM users");

            std::cout << "📄 Users in DB:\n";
            for (auto row : r) {
                std::cout << " - " << row[0].c_str() << std::endl;
            }

            txn.commit();
        } else {
            std::cerr << "❌ Can't open database\n";
        }

    } catch (const std::exception &e) {
        // Catch any exceptions during connection or query execution
        std::cerr << "❌ Exception: " << e.what() << std::endl;
    }
}

// Method to connect to the database
// Establishes and returns a new connection to the PostgreSQL database.
pqxx::connection DatabaseService::connect() {
    return pqxx::connection("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");
}

// Retrieve all lessons from the 'lessons' table
// Returns a JSON string representing all lessons with their id and title.
std::string DatabaseService::getAllLessons() {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Query all lessons with id and title
        pqxx::result r = txn.exec("SELECT id, title FROM lessons");

        std::string json = "[";
        // Build JSON array from query results
        for (size_t i = 0; i < r.size(); ++i) {
            json += "{\"id\":" + std::string(r[i][0].c_str()) + ",\"title\":\"" + std::string(r[i][1].c_str()) + "\"}";
            if (i != r.size() - 1) json += ",";
        }
        json += "]";
        return json;
    } catch (const std::exception &e) {
        // Return error message in JSON format if query fails
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve a lesson by its ID
// Returns a JSON string for a single lesson identified by its ID.
std::string DatabaseService::getLessonById(int id) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Query lesson by id
        pqxx::result r = txn.exec("SELECT id, title FROM lessons WHERE id = " + std::to_string(id));

        if (r.empty()) return "{}";

        // Format result as JSON object
        std::string json = "{\"id\":" + std::string(r[0][0].c_str()) + ",\"title\":\"" + std::string(r[0][1].c_str()) + "\"}";
        return json;
    } catch (const std::exception &e) {
        // Return error message if exception occurs
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve all pages for a lesson
// Returns a JSON array string of pages belonging to a lesson, including id, type, content, and position.
std::string DatabaseService::getPagesByLessonId(int lessonId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Query pages for the specific lesson ordered by position
        pqxx::result r = txn.exec(
            "SELECT id, type, content, position FROM pages WHERE lesson_id = " + std::to_string(lessonId) + " ORDER BY position");

        std::string json = "[";
        // Build JSON array from pages data
        for (size_t i = 0; i < r.size(); ++i) {
            json += "{";
            json += "\"id\":" + std::string(r[i][0].c_str()) + ",";
            json += "\"type\":\"" + std::string(r[i][1].c_str()) + "\",";
            json += "\"content\":\"" + std::string(r[i][2].c_str()) + "\",";
            json += "\"position\":" + std::string(r[i][3].c_str());
            json += "}";
            if (i != r.size() - 1) json += ",";
        }
        json += "]";
        return json;
    } catch (const std::exception &e) {
        // Return error JSON on failure
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Insert a user reward
// Inserts a new reward record for a user with the reward name and timestamp.
void DatabaseService::insertUserReward(int userId, const std::string& rewardName, const std::string& earnedAt) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Insert reward into rewards table
        txn.exec("INSERT INTO rewards (user_id, reward_name, earned_at) VALUES (" + std::to_string(userId) + ", '" + rewardName + "', '" + earnedAt + "')");
        txn.commit();
    } catch (const std::exception &e) {
        // Log error if insertion fails
        std::cerr << "❌ Error in insertUserReward: " << e.what() << std::endl;
    }
}

// Update or insert user progress
// Upserts user progress for a lesson, marking completion status and update timestamp.
void DatabaseService::upsertUserProgress(int userId, int lessonId, bool completed, const std::string& updatedAt) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Insert or update user progress with conflict handling
        txn.exec(
            "INSERT INTO user_progress (user_id, lesson_id, completed, updated_at) "
            "VALUES (" + std::to_string(userId) + ", " + std::to_string(lessonId) + ", " + (completed ? "true" : "false") + ", '" + updatedAt + "') "
            "ON CONFLICT (user_id, lesson_id) "
            "DO UPDATE SET completed = " + (completed ? "true" : "false") + ", updated_at = '" + updatedAt + "'"
        );
        txn.commit();
    } catch (const std::exception &e) {
        // Log any errors during upsert
        std::cerr << "❌ Error in upsertUserProgress: " << e.what() << std::endl;
    }
}

// Insert a new performance record
// Inserts a new performance record for a user session, lesson, and score with timestamp.
void DatabaseService::createPerformance(int userId, int sessionId, int lessonId, int score, const std::string& timestamp) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Insert performance data into performances table
        txn.exec(
            "INSERT INTO performances (user_id, session_id, lesson_id, score, timestamp) "
            "VALUES (" + std::to_string(userId) + ", " + std::to_string(sessionId) + ", " + std::to_string(lessonId) + ", " + std::to_string(score) + ", '" + timestamp + "')"
        );
        txn.commit();
    } catch (const std::exception &e) {
        // Log errors on insertion failure
        std::cerr << "❌ Error in createPerformance: " << e.what() << std::endl;
    }
}

// Mark a lesson as completed for a user
// Inserts or updates user_progress to set completed=true and updates timestamp.
void DatabaseService::markLessonAsCompleted(int userId, int lessonId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);

        // Use parameterized query to avoid SQL injection
        txn.exec_params(
            "INSERT INTO user_progress (user_id, lesson_id, completed, updated_at) "
            "VALUES ($1, $2, true, NOW()) "
            "ON CONFLICT (user_id, lesson_id) DO UPDATE SET completed = true, updated_at = NOW();",
            userId, lessonId
        );

        // Debug log before committing transaction
        std::cout << "✅ markLessonAsCompleted: lesson_id = " << lessonId << " for user_id = " << userId << std::endl;
        txn.commit();
    } catch (const std::exception& e) {
        // Log any exceptions during update
        std::cerr << "❌ Error in markLessonAsCompleted: " << e.what() << std::endl;
    }
}

// Retrieve all lessons completed by a user
// Returns a JSON array of completed lessons with their update timestamps.
std::string DatabaseService::getCompletedLessons(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Select completed lessons for user
        pqxx::result r = txn.exec_params(
            "SELECT lesson_id, updated_at FROM user_progress WHERE user_id = $1 AND completed = true",
            userId
        );

        std::string json = "[";
        // Build JSON array from results
        for (size_t i = 0; i < r.size(); ++i) {
            json += "{";
            json += "\"lesson_id\":" + std::string(r[i][0].c_str()) + ",";
            json += "\"updated_at\":\"" + std::string(r[i][1].c_str()) + "\"";
            json += "}";
            if (i != r.size() - 1) json += ",";
        }
        json += "]";
        return json;
    } catch (const std::exception& e) {
        // Return error JSON on failure
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve user progress as a JSON object with next lesson and unlocked lessons
std::string DatabaseService::getUserProgress(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Query lessons completed by user, ordered by lesson_id
        pqxx::result r = txn.exec(
            "SELECT lesson_id FROM user_progress WHERE user_id = " + std::to_string(userId) + " AND completed = true ORDER BY lesson_id"
        );

        std::vector<int> unlocked;
        // Extract lesson ids into vector
        for (const auto& row : r) {
            unlocked.push_back(row[0].as<int>());
        }

        // Determine next lesson to unlock (one after last completed)
        int nextLesson = 1;
        if (!unlocked.empty()) {
            nextLesson = unlocked.back() + 1;
        }

        // Manually construct JSON object with nextLesson and unlockedLessons array
        std::string json = "{";
        json += "\"nextLesson\":" + std::to_string(nextLesson) + ",";
        json += "\"unlockedLessons\":[";
        for (size_t i = 0; i < unlocked.size(); ++i) {
            json += std::to_string(unlocked[i]);
            if (i != unlocked.size() - 1) json += ",";
        }
        json += "]}";

        return json;
    } catch (const std::exception &e) {
        // Return error JSON if query or processing fails
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve user rewards
// Returns a JSON array of rewards earned by the user with reward name and earned date.
std::string DatabaseService::getUserRewards(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Query rewards for the user
        pqxx::result r = txn.exec("SELECT reward_name, earned_at FROM rewards WHERE user_id = " + std::to_string(userId));

        std::string json = "[";
        // Build JSON array of rewards
        for (size_t i = 0; i < r.size(); ++i) {
            json += "{";
            json += "\"reward_name\":\"" + std::string(r[i][0].c_str()) + "\",";
            json += "\"earned_at\":\"" + std::string(r[i][1].c_str()) + "\"";
            json += "}";
            if (i != r.size() - 1) json += ",";
        }
        json += "]";
        return json;
    } catch (const std::exception &e) {
        // Return error JSON on failure
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve user performances
// Returns a JSON array of performance records including session, lesson, score, and timestamp.
std::string DatabaseService::getPerformancesByUserId(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        // Query performances for user
        pqxx::result r = txn.exec("SELECT session_id, lesson_id, score, timestamp FROM performances WHERE user_id = " + std::to_string(userId));

        std::string json = "[";
        // Build JSON array of performances
        for (size_t i = 0; i < r.size(); ++i) {
            json += "{";
            json += "\"session_id\":" + std::string(r[i][0].c_str()) + ",";
            json += "\"lesson_id\":" + std::string(r[i][1].c_str()) + ",";
            json += "\"score\":" + r[i][2].as<std::string>() + ",";
            json += "\"timestamp\":\"" + std::string(r[i][3].c_str()) + "\"";
            json += "}";
            if (i != r.size() - 1) json += ",";
        }
        json += "]";
        return json;
    } catch (const std::exception &e) {
        // Return error JSON if query fails
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve a specific page of a lesson, including type, title, and total number of pages
// Returns a JSON object for a lesson page enriched with metadata such as lesson title and total pages.
std::string DatabaseService::getLessonPage(int lessonId, int pageIndex) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);

        // Get page by lesson_id and position (pageIndex)
        pqxx::result page = txn.exec_params(
            "SELECT type, content FROM pages WHERE lesson_id = $1 AND position = $2",
            lessonId, pageIndex
        );

        if (page.empty()) return "{}";

        // Get lesson title and total page count for metadata
        pqxx::result meta = txn.exec_params(
            "SELECT title, (SELECT COUNT(*) FROM pages WHERE lesson_id = $1) FROM lessons WHERE id = $1",
            lessonId
        );

        if (meta.empty()) return "{}";

        // The content column is expected to be a JSON string; append additional metadata fields
        std::string json = page[0][1].c_str();  // content JSON
        json.pop_back(); // remove trailing }
        json += ",\"type\":\"" + std::string(page[0][0].c_str()) + "\"";
        json += ",\"lessonTitle\":\"" + std::string(meta[0][0].c_str()) + "\"";
        json += ",\"totalPages\":" + std::string(meta[0][1].c_str());
        json += "}";

        return json;

    } catch (const std::exception &e) {
        // Return error JSON on exception
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Retrieve the last unlocked lesson for a user
// Returns the last unlocked lesson ID or 1 if none found.
int DatabaseService::getLastUnlockedLesson(int userId) {
    pqxx::connection conn = connect();
    pqxx::work txn(conn);

    // Query last unlocked lesson from users table
    pqxx::result r = txn.exec_params(
        "SELECT last_unlocked_lesson FROM users WHERE id = $1",
        userId
    );

    if (r.empty()) return 1;
    return r[0][0].as<int>();
}