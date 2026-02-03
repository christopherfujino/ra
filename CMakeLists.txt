# Ubuntu 25.10
cmake_minimum_required(VERSION 3.31)

project(my_great_project VERSION 0.1)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)

add_compile_options(-Wall -Werror -Wpedantic -Wextra)

add_executable(main main.cpp)

target_link_libraries(main PRIVATE lib readline)

add_library(lib SHARED)

target_sources(
  lib

  PUBLIC
  FILE_SET CXX_MODULES
  FILES
    lib/lib.cpp
    lib/card.cpp
  )
