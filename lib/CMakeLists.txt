cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(xxh VERSION 1.0.0 LANGUAGES C)
add_library(xxh SHARED exports.c)
target_include_directories(xxh PRIVATE xxHash)
target_link_libraries(xxh ${CMAKE_SOURCE_DIR}/xxHash/libxxhash.a)

set_target_properties(xxh PROPERTIES
    PUBLIC_HEADER exports.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "xxh"
)