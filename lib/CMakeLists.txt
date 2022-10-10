cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(xxh_export VERSION 1.0.0 LANGUAGES C)
add_library(xxh_export SHARED exports.c)
add_executable(exports.c)

set_target_properties(xxh_export PROPERTIES
    PUBLIC_HEADER exports.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "xxh"
)