#pragma once

#include "crow.h"
#include <pqxx/pqxx>
#include "../services/audio_service.h"

void setupAudioRoutes(crow::SimpleApp& app) {
    CROW_ROUTE(app, "/audio-files").methods("GET"_method)([]() {
        AudioService service;
        return crow::response(service.getAllAudioFiles());
    });

    CROW_ROUTE(app, "/audio-files/<string>").methods("GET"_method)(
        [](const crow::request& req, const std::string& filename) {
            try {
                pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");
                pqxx::work txn(conn);

                pqxx::result r = txn.exec_params(
                    "SELECT data FROM audio_files WHERE filename = $1",
                    filename
                );

                if (r.empty()) {
                    return crow::response(404, "Audio file not found");
                }

                auto blob = pqxx::binarystring(r[0][0]);

                crow::response res;
                res.set_header("Content-Type", "audio/mpeg");
                res.body = std::string(reinterpret_cast<const char*>(blob.data()), blob.size());
                res.code = 200;
                return res;
            } catch (const std::exception& e) {
                return crow::response(500, std::string("Error: ") + e.what());
            }
        }
    );
}