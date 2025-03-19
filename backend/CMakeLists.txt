cmake_minimum_required(VERSION 3.10)
project(DJ_Learning_Backend)

set(CMAKE_CXX_STANDARD 17)

# Include directories for libpqxx and libpq
include_directories(/opt/homebrew/Cellar/libpqxx/7.10.0/include)
include_directories(/opt/homebrew/Cellar/libpq/17.4_1/include)  # Adjust path if needed

# Link directories for libpqxx and libpq
link_directories(/opt/homebrew/Cellar/libpqxx/7.10.0/lib)
link_directories(/opt/homebrew/Cellar/libpq/17.4_1/lib)

# Build the executable and link against libpqxx and libpq
add_executable(dj_backend src/main.cpp src/services/db_service.cpp)
target_link_libraries(dj_backend pqxx pq)