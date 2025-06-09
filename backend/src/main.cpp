// backend/src/main.cpp
// ------------------------------------------------------------
// Beatquest – Backend Main Entry Point
// ------------------------------------------------------------
// This file contains the main function that initializes the
// Beatquest backend server using the Crow C++ web framework.
//
// At startup:
//   - Tests DB connectivity
//   - Loads and syncs lesson data from JSON
//   - Imports audio files into the database
//   - Registers all HTTP API routes (users, lessons, progress, etc.)
//   - Launches the API server on port 18080
//
// Dependencies: Crow, libpqxx, local service/route headers
// ------------------------------------------------------------

#include "crow.h"
#include "services/db_service.h"
#include "services/lesson_service.h"
#include "services/audio_service.h"
#include "routes/user_routes.h"
#include "routes/lesson_routes.h"
#include "routes/progress_routes.h"
#include "routes/reward_routes.h"
#include "routes/performance_routes.h"
#include "routes/completion_routes.h"
#include "routes/audio_routes.h"

int main() {
    // Step 1: Test database connectivity at launch
    test_connection();

    // Step 2: Load lessons from file and sync to PostgreSQL
    try {
        auto lessons = LessonService::loadLessonsFromFile();
        LessonService::syncLessonsToDb(lessons);
    } catch (const std::exception& e) {
        std::cerr << "❌ Error syncing lessons: " << e.what() << std::endl;
    }

    // Step 3: Import audio files from local directory into DB
    try {
        AudioService audioService;
        audioService.importAudioFiles("../src/assets/audio");
    } catch (const std::exception& e) {
        std::cerr << "❌ Error importing audio files: " << e.what() << std::endl;
    }

    // Step 4: Create Crow HTTP API app
    crow::SimpleApp app;

    // Root route for testing base connectivity
    CROW_ROUTE(app, "/")([] {
        return "🎧 Welcome to the DJ Backend API!";
    });

    // Debugging route: return DB status
    CROW_ROUTE(app, "/db-check")([] {
        DatabaseService db;
        try {
            pqxx::connection C = db.connect();
            if (C.is_open()) {
                return crow::response(200, "✅ Database connection successful!");
            } else {
                return crow::response(500, "❌ Failed to connect to the database.");
            }
        } catch (const std::exception &e) {
            return crow::response(500, std::string("❌ Exception: ") + e.what());
        }
    });

    // Display current working directory (debug)
    char buffer[PATH_MAX];
    if (getcwd(buffer, sizeof(buffer)) != nullptr) {
        std::cout << "📂 Working directory: " << buffer << std::endl;
    }

    // Step 5: Register all backend route groups
    add_user_routes(app);
    setupLessonRoutes(app);
    setupProgressRoutes(app);
    setupRewardRoutes(app);
    setupPerformanceRoutes(app);
    setupCompletionRoutes(app);
    setupAudioRoutes(app);

    // Step 6: Launch HTTP server on port 18080
    std::cout << "🚀 Starting API server on port 18080..." << std::endl;
    app.port(18080).multithreaded().run();
}