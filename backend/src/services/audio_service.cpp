// backend/src/services/audio_service.cpp
// ------------------------------------------------------------
// Beatquest – Audio Service Implementation
// ------------------------------------------------------------
// This file implements the AudioService class, responsible for:
//   - Importing binary audio files from a local directory into
//     the PostgreSQL database as BLOBs.
//   - Fetching all available audio files and returning metadata
//     as a JSON string for frontend display.
//
// The imported audio files are stored in a table `audio_files`
// with columns: id, filename, data (bytea).
//
// Dependencies:
//   - libpqxx: PostgreSQL C++ client
//   - std::filesystem: C++17 file access
//   - std::ifstream: file reading
// ------------------------------------------------------------

#include "audio_service.h"
#include "db_service.h"
#include <filesystem>     // For directory iteration
#include <pqxx/pqxx>      // For PostgreSQL operations
#include <fstream>        // For reading files as binary
#include <sstream>        // For building JSON string
#include <iostream>       // For debug output
#include <vector>
#include <iomanip>        // For std::setw formatting (optional)

namespace fs = std::filesystem;

// ------------------------------------------------------------
// importAudioFiles
// Loads all audio files from a folder and stores them in the DB
// ------------------------------------------------------------
void AudioService::importAudioFiles(const std::string& folderPath) {
    try {
        pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");
        pqxx::work txn(conn);

        for (const auto& entry : fs::directory_iterator(folderPath)) {
            if (entry.is_regular_file()) {
                std::string filePath = entry.path().string();
                std::string fileName = entry.path().filename().string();

                // Check if file already exists, delete if yes
                pqxx::result exists = txn.exec_params(
                    "SELECT id FROM audio_files WHERE filename = $1",
                    fileName
                );
                if (!exists.empty()) {
                    txn.exec_params("DELETE FROM audio_files WHERE id = $1", exists[0][0].as<int>());
                    std::cout << "🗑️ Removed old entry: " << fileName << std::endl;
                }

                // Open file as binary stream
                std::ifstream fileStream(filePath, std::ios::binary);
                if (!fileStream.is_open()) {
                    std::cerr << "❌ Failed to open file: " << fileName << std::endl;
                    continue;
                }

                // Read file content into byte vector
                std::vector<unsigned char> audioData;
                fileStream.seekg(0, std::ios::end);
                std::streamsize size = fileStream.tellg();
                fileStream.seekg(0, std::ios::beg);

                if (size > 0) {
                    audioData.resize(size);
                    fileStream.read(reinterpret_cast<char*>(audioData.data()), size);
                }

                if (audioData.empty()) {
                    std::cerr << "❌ File is empty or could not be read: " << fileName << std::endl;
                    continue;
                }

                std::cout << "📦 Read file: " << fileName << " (" << audioData.size() << " bytes)" << std::endl;

                // Insert into audio_files table as binary blob
                txn.exec_params(
                    "INSERT INTO audio_files (filename, data) VALUES ($1, $2)",
                    fileName, pqxx::binarystring(reinterpret_cast<const char*>(audioData.data()), audioData.size())
                );

                std::cout << "✅ Imported: " << fileName << std::endl;
            }
        }

        txn.commit();
    } catch (const std::exception& e) {
        std::cerr << "❌ Audio import error: " << e.what() << std::endl;
    }
}

// ------------------------------------------------------------
// getAllAudioFiles
// Returns metadata for all stored audio files in JSON format
// ------------------------------------------------------------
std::string AudioService::getAllAudioFiles() {
    try {
        pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");
        pqxx::work txn(conn);

        pqxx::result r = txn.exec("SELECT id, filename FROM audio_files");

        std::ostringstream json;
        json << "[";

        // Build JSON array of { id, filename } entries
        for (size_t i = 0; i < r.size(); ++i) {
            json << "{"
                 << "\"id\":" << r[i][0].as<int>() << ","
                 << "\"filename\":\"" << r[i][1].c_str() << "\""
                 << "}";
            if (i != r.size() - 1) json << ",";
        }

        json << "]";
        return json.str();
    } catch (const std::exception& e) {
        std::cerr << "❌ Audio fetch error: " << e.what() << std::endl;
        return "[]";
    }
}