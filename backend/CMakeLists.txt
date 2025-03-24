# ====================================================================================
# Backend Setup Instructions
# ====================================================================================
# 1️⃣ Build the project:
#    rm -rf build
#    mkdir build && cd build
#    cmake ..
#    make
#
# 2️⃣ Run the backend:
#    ./dj_backend
#
# 3️⃣ Install dependencies (if missing):
#    brew install libpq libpqxx cmake
#
# 4️⃣ Troubleshooting:
#    - Ensure PostgreSQL is installed and running.
#    - Check that libpq and libpqxx are correctly linked in CMake.
#    - If encountering missing headers, ensure Homebrew libraries are in the include path.
#
# ====================================================================================
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