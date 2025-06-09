// backend/src/routes/audio_routes.h
// ------------------------------------------------------------
// Beatquest – Audio File Routes (Crow HTTP API)
// ------------------------------------------------------------
// This file defines the HTTP routes for handling audio files
// in the Beatquest application backend. It provides endpoints
// for retrieving all available audio filenames and streaming
// specific audio files directly from the PostgreSQL database.
//
// These routes are registered with a Crow HTTP server instance.
// ------------------------------------------------------------

#pragma once

#include "crow.h"                  // Crow web framework for routing and HTTP handling
#include <pqxx/pqxx>               // PostgreSQL C++ client library (libpqxx)
#include "../services/audio_service.h"  // Custom service for audio metadata

// Registers audio-related routes to the Crow application
void setupAudioRoutes(crow::SimpleApp& app) {
    // GET /audio-files
    // Returns a JSON array of all stored audio file names
    CROW_ROUTE(app, "/audio-files").methods("GET"_method)([]() {
        AudioService service;
        return crow::response(service.getAllAudioFiles());
    });

    // GET /audio-files/<filename>
    // Streams the requested audio file (MP3) from the database
    CROW_ROUTE(app, "/audio-files/<string>").methods("GET"_method)(
        [](const crow::request& req, const std::string& filename) {
            try {
                // Open PostgreSQL connection using default credentials
                pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");
                pqxx::work txn(conn);

                // Query the binary blob of the file using prepared statement
                pqxx::result r = txn.exec_params(
                    "SELECT data FROM audio_files WHERE filename = $1",
                    filename
                );

                // Handle missing file
                if (r.empty()) {
                    return crow::response(404, "Audio file not found");
                }

                // Convert binary result to string buffer for streaming
                auto blob = pqxx::binarystring(r[0][0]);

                crow::response res;
                res.set_header("Content-Type", "audio/mpeg");
                res.body = std::string(reinterpret_cast<const char*>(blob.data()), blob.size());
                res.code = 200;
                return res;
            } catch (const std::exception& e) {
                // Handle database or streaming errors
                return crow::response(500, std::string("Error: ") + e.what());
            }
        }
    );
}