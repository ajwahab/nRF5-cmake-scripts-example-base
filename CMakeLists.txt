cmake_minimum_required(VERSION 3.6)
set(CMAKE_VERBOSE_MAKEFILE ON)

set(nRF5_SDK_VERSION "nRF5_SDK_17.1.0_ddde560" CACHE STRING "nRF5 SDK")
set(nRF5_MESH_SDK_VERSION "500" CACHE STRING "nRF5 Mesh SDK version")

set(BOARD "nrf52840-mdk" CACHE STRING "Makerdiary NRF52840-MDK")
include("cmake/board/${BOARD}.cmake")

# enable to output verbose info
set(CMAKE_VERBOSE_MAKEFILE off)

set(VERSION_MAJOR 1)
set(VERSION_MINOR 0)
set(VERSION_BUGFIX 0)
set(VERSION_SUFFIX "")
set(VERSION_STRING "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_BUGFIX}${VERSION_SUFFIX}" CACHE STRING "" FORCE)

set(CMAKE_SOURCE_DIR ${CMAKE_SOURCE_DIR} CACHE STRING "" FORCE)

# Modify this to set the correct path relative to this file.
set(nRF5_cmake_path "${CMAKE_SOURCE_DIR}/nRF5-cmake-scripts/nRF5-cmake.cmake")
#if(NOT EXISTS "${nRF5_cmake_path}")
#    set(nRF5_cmake_path "${CMAKE_SOURCE_DIR}/../nRF5-cmake.cmake")
#endif()
include("${nRF5_cmake_path}")

# project() must be called after including nRF5-cmake.cmake but before calling nRF5_setup
# to ensure variables are set correctly
project(example
        VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_BUGFIX}
        LANGUAGES NONE)

message(STATUS "Configuring CMake for nRF5 SDK for ${PROJECT_NAME} ${VERSION_STRING}")
nRF5_setup()

# uncomment to enable C++
 enable_language(CXX)

if(NOT TARGET download)
    add_subdirectory("src")
#    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/config)
#    add_subdirectory("src/config")
endif()
