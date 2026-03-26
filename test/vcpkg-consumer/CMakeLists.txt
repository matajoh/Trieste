cmake_minimum_required(VERSION 3.14)
project(trieste-vcpkg-test CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

enable_testing()

find_package(trieste CONFIG REQUIRED)

add_executable(test-find-package test_find_package.cpp)
target_link_libraries(test-find-package PRIVATE trieste::trieste)
add_test(NAME find-package COMMAND test-find-package)
