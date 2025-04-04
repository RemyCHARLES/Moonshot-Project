#ifndef DB_SERVICE_H
#define DB_SERVICE_H

#include <pqxx/pqxx>

class DatabaseService {
public:
    pqxx::connection connect();
};

void test_connection();

#endif