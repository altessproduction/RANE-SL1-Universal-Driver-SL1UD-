cmake_minimum_required(VERSION 3.20)
project(RANE_SL1_Universal_Driver VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(sl1_core
    core/src/device_info.cpp
)
target_include_directories(sl1_core PUBLIC core/include)

if(MSVC)
    target_compile_options(sl1_core PRIVATE /W4 /permissive-)
else()
    target_compile_options(sl1_core PRIVATE -Wall -Wextra -Wpedantic)
endif()

enable_testing()
add_executable(sl1_core_tests tests/core_tests.cpp)
target_link_libraries(sl1_core_tests PRIVATE sl1_core)
add_test(NAME sl1_core_tests COMMAND sl1_core_tests)

if(WIN32)
    add_subdirectory(platform/windows)
elseif(APPLE)
    message(STATUS "Core Audio adapter is not implemented yet; building shared core only.")
endif()
