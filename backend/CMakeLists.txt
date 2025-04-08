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
cmake_minimum_required(VERSION 3.16)
project(dj_backend)

set(CMAKE_CXX_STANDARD 17)

set(OPENSSL_ROOT_DIR "/opt/homebrew/opt/openssl@3")
set(OPENSSL_INCLUDE_DIR "/opt/homebrew/opt/openssl@3/include")
set(OPENSSL_LIBRARIES "/opt/homebrew/opt/openssl@3/lib")

find_package(OpenSSL REQUIRED)

# Crow include
include_directories(${PROJECT_SOURCE_DIR}/../external/Crow/include)

# Asio include
include_directories(${PROJECT_SOURCE_DIR}/../external/asio/asio/include)

# JWT-CPP include
include_directories(${CMAKE_SOURCE_DIR}/../external/jwt-cpp/include)

# libpq and libpqxx includes from Homebrew
include_directories(/opt/homebrew/opt/libpq/include)
include_directories(/opt/homebrew/opt/libpqxx/include)
link_directories(/opt/homebrew/opt/libpq/lib)
link_directories(/opt/homebrew/opt/libpqxx/lib)

# Your source files
file(GLOB_RECURSE SOURCES "src/*.cpp")

add_executable(dj_backend ${SOURCES})

# Link pqxx and libpq
target_link_libraries(dj_backend PRIVATE pqxx pq ${OPENSSL_LIBRARIES})
target_include_directories(dj_backend PRIVATE ${OPENSSL_INCLUDE_DIR})

# Link OpenSSL
include_directories(${OPENSSL_INCLUDE_DIR})