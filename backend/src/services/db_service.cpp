#include "db_service.h"
#include <pqxx/pqxx>
#include <iostream>

void test_connection() {
    try {
        pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");

        if (conn.is_open()) {
            std::cout << "✅ Connected to database: " << conn.dbname() << std::endl;

            // Let's try fetching usernames
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

pqxx::connection DatabaseService::connect() {
    pqxx::connection conn("dbname=dj_app user=dj_user password=secure_app_pw host=localhost");

    try {
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
        std::cerr << "❌ Exception in connect(): " << e.what() << std::endl;
    }
    
    return conn;
}