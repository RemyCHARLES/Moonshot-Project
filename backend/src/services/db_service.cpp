#include "db_service.h"
#include <pqxx/pqxx>
#include <iostream>

// Méthode pour tester la connexion à la BDD
void test_connection() {
    try {
        pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");

        if (conn.is_open()) {
            std::cout << "✅ Connected to database: " << conn.dbname() << std::endl;

            pqxx::work txn(conn);
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
        std::cerr << "❌ Exception: " << e.what() << std::endl;
    }
}

// Méthode de connexion à la base
pqxx::connection DatabaseService::connect() {
    return pqxx::connection("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");
}

// Récupérer toutes les leçons
std::string DatabaseService::getAllLessons() {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec("SELECT id, title FROM lessons");

        std::string json = "[";
        for (size_t i = 0; i < r.size(); ++i) {
            json += "{\"id\":" + std::string(r[i][0].c_str()) + ",\"title\":\"" + std::string(r[i][1].c_str()) + "\"}";
            if (i != r.size() - 1) json += ",";
        }
        json += "]";
        return json;
    } catch (const std::exception &e) {
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Récupérer une leçon par ID
std::string DatabaseService::getLessonById(int id) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec("SELECT id, title FROM lessons WHERE id = " + std::to_string(id));

        if (r.empty()) return "{}";

        std::string json = "{\"id\":" + std::string(r[0][0].c_str()) + ",\"title\":\"" + std::string(r[0][1].c_str()) + "\"}";
        return json;
    } catch (const std::exception &e) {
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Récupérer toutes les pages d'une leçon
std::string DatabaseService::getPagesByLessonId(int lessonId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec(
            "SELECT id, type, content, position FROM pages WHERE lesson_id = " + std::to_string(lessonId) + " ORDER BY position");

        std::string json = "[";
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
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Insérer une récompense utilisateur
void DatabaseService::insertUserReward(int userId, const std::string& rewardName, const std::string& earnedAt) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        txn.exec("INSERT INTO rewards (user_id, reward_name, earned_at) VALUES (" + std::to_string(userId) + ", '" + rewardName + "', '" + earnedAt + "')");
        txn.commit();
    } catch (const std::exception &e) {
        std::cerr << "❌ Error in insertUserReward: " << e.what() << std::endl;
    }
}

// Mettre à jour ou insérer la progression utilisateur
void DatabaseService::upsertUserProgress(int userId, int lessonId, bool completed, const std::string& updatedAt) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        txn.exec(
            "INSERT INTO user_progress (user_id, lesson_id, completed, updated_at) "
            "VALUES (" + std::to_string(userId) + ", " + std::to_string(lessonId) + ", " + (completed ? "true" : "false") + ", '" + updatedAt + "') "
            "ON CONFLICT (user_id, lesson_id) "
            "DO UPDATE SET completed = " + (completed ? "true" : "false") + ", updated_at = '" + updatedAt + "'"
        );
        txn.commit();
    } catch (const std::exception &e) {
        std::cerr << "❌ Error in upsertUserProgress: " << e.what() << std::endl;
    }
}

// Créer une performance
void DatabaseService::createPerformance(int userId, int sessionId, int lessonId, int score, const std::string& timestamp) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        txn.exec(
            "INSERT INTO performances (user_id, session_id, lesson_id, score, timestamp) "
            "VALUES (" + std::to_string(userId) + ", " + std::to_string(sessionId) + ", " + std::to_string(lessonId) + ", " + std::to_string(score) + ", '" + timestamp + "')"
        );
        txn.commit();
    } catch (const std::exception &e) {
        std::cerr << "❌ Error in createPerformance: " << e.what() << std::endl;
    }
}

void DatabaseService::markLessonAsCompleted(int userId, int lessonId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);

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
        std::cerr << "❌ Error in markLessonAsCompleted: " << e.what() << std::endl;
    }
}

std::string DatabaseService::getCompletedLessons(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec_params(
            "SELECT lesson_id, updated_at FROM user_progress WHERE user_id = $1 AND completed = true",
            userId
        );

        std::string json = "[";
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
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

std::string DatabaseService::getUserProgress(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec(
            "SELECT lesson_id FROM user_progress WHERE user_id = " + std::to_string(userId) + " AND completed = true ORDER BY lesson_id"
        );

        std::vector<int> unlocked;
        for (const auto& row : r) {
            unlocked.push_back(row[0].as<int>());
        }

        int nextLesson = 1;
        if (!unlocked.empty()) {
            nextLesson = unlocked.back() + 1;
        }

        // Construction manuelle du JSON
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
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Récupérer les récompenses utilisateur
std::string DatabaseService::getUserRewards(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec("SELECT reward_name, earned_at FROM rewards WHERE user_id = " + std::to_string(userId));

        std::string json = "[";
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
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

// Récupérer les performances utilisateur
std::string DatabaseService::getPerformancesByUserId(int userId) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);
        pqxx::result r = txn.exec("SELECT session_id, lesson_id, score, timestamp FROM performances WHERE user_id = " + std::to_string(userId));

        std::string json = "[";
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
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}





// Récupérer une page de leçon spécifique avec métadonnées
std::string DatabaseService::getLessonPage(int lessonId, int pageIndex) {
    try {
        pqxx::connection conn = connect();
        pqxx::work txn(conn);

        // Get page by lesson_id and position
        pqxx::result page = txn.exec_params(
            "SELECT type, content FROM pages WHERE lesson_id = $1 AND position = $2",
            lessonId, pageIndex
        );

        if (page.empty()) return "{}";

        // Get lesson title and total page count
        pqxx::result meta = txn.exec_params(
            "SELECT title, (SELECT COUNT(*) FROM pages WHERE lesson_id = $1) FROM lessons WHERE id = $1",
            lessonId
        );

        if (meta.empty()) return "{}";

        std::string json = page[0][1].c_str();  // content JSON
        json.pop_back(); // remove trailing }
        json += ",\"type\":\"" + std::string(page[0][0].c_str()) + "\"";
        json += ",\"lessonTitle\":\"" + std::string(meta[0][0].c_str()) + "\"";
        json += ",\"totalPages\":" + std::string(meta[0][1].c_str());
        json += "}";

        return json;

    } catch (const std::exception &e) {
        return "{\"error\":\"" + std::string(e.what()) + "\"}";
    }
}

int DatabaseService::getLastUnlockedLesson(int userId) {
    pqxx::connection conn = connect();
    pqxx::work txn(conn);

    pqxx::result r = txn.exec_params(
        "SELECT last_unlocked_lesson FROM users WHERE id = $1",
        userId
    );

    if (r.empty()) return 1;
    return r[0][0].as<int>();
}