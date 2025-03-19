#include <iostream>
#include "services/db_service.cpp"

int main() {
    DatabaseService db;
    pqxx::connection C = db.connect();
    
    if (C.is_open()) {
        std::cout << "Database connection successful!" << std::endl;
    } else {
        std::cerr << "Failed to connect to database!" << std::endl;
    }

    return 0;
}