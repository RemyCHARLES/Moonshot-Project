#include "crow.h"
#include "services/db_service.h"
#include "routes/user_routes.h"

int main() {
    // Test DB connection
    test_connection();

    // Create API app
    crow::SimpleApp app;

    // Root route
    CROW_ROUTE(app, "/")([] {
        return "🎧 Welcome to the DJ Backend API!";
    });

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

    // Register user routes
    add_user_routes(app);

    std::cout << "🚀 Starting API server on port 18080..." << std::endl;
    app.port(18080).multithreaded().run();
}