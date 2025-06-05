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
    // Test DB connection
    test_connection();

    // Auto-sync lessons from JSON file
    try {
        auto lessons = LessonService::loadLessonsFromFile();
        LessonService::syncLessonsToDb(lessons);
    } catch (const std::exception& e) {
        std::cerr << "❌ Erreur lors de la synchronisation des leçons : " << e.what() << std::endl;
    }

    // Auto-import audio files from folder
    try {
        AudioService audioService;
        audioService.importAudioFiles("../src/assets/audio");
    } catch (const std::exception& e) {
        std::cerr << "❌ Erreur lors de l'importation des fichiers audio : " << e.what() << std::endl;
    }

    // Create API app
    crow::SimpleApp app;

    // Root route
    CROW_ROUTE(app, "/")([] {
        return "🎧 Welcome to the DJ Backend API!";
    });

    char buffer[PATH_MAX];
    if (getcwd(buffer, sizeof(buffer)) != nullptr) {
        std::cout << "Répertoire courant : " << buffer << std::endl;
    }

    // DB check route
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

    // Register all route groups
    add_user_routes(app);
    setupLessonRoutes(app);
    setupProgressRoutes(app);
    setupRewardRoutes(app);
    setupPerformanceRoutes(app);
    setupCompletionRoutes(app);
    setupAudioRoutes(app);

    std::cout << "🚀 Starting API server on port 18080..." << std::endl;
    app.port(18080).multithreaded().run();
}