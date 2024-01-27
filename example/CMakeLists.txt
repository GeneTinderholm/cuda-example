cmake_minimum_required(VERSION 3.22)
project(example CUDA CXX)

set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CXX_STANDARD  17)

add_library(examplestatic STATIC library.cu)
set_target_properties(examplestatic PROPERTIES CUDA_RESOLVE_DEVICE_SYMBOLS ON)

add_library(exampleshared SHARED library.cu)

set_target_properties(examplestatic PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)


#cmake_policy(SET CMP0135 NEW)
include(FetchContent)
FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

include(GoogleTest)
add_executable(
        example_test
        exampletest.cpp
)
target_link_libraries(
        example_test
        GTest::gtest_main
        examplestatic
)

gtest_discover_tests(example_test)
