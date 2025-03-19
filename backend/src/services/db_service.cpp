#include <iostream>
#include <pqxx/pqxx>

class DatabaseService {
public:
    pqxx::connection connect() {
        try {
            pqxx::connection C("dbname=dj_learning user=dj_user password=2345 host=localhost port=5432");
            if (C.is_open()) {
                std::cout << "Connected to database successfully!" << std::endl;
            }
            return C;
        } catch (const std::exception &e) {
            std::cerr << "Database connection error: " << e.what() << std::endl;
            exit(1);
        }
    }
};