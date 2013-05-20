cmake_minimum_required(VERSION 2.8)

include(${CMAKE_CURRENT_LIST_DIR}/remake/remake.cmake)

project(OpenNI2)

find_package(jpeg REQUIRED NO_MODULE)
find_package(usb REQUIRED)

if(LINUX AND M64)
    add_compile_flags("-fPIC")
endif()

if(UNIX)
    add_compile_flags("-msse3")
endif()


# These definitions are meant for the third-party GL stuff.
if(WINDOWS)
    add_definitions(-DWIN32)
endif()
if(MACOSX)
    add_definitions(-DMACOS)
endif()
if(LINUX)
    add_definitions(-DUNIX)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/XnLib.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Drivers.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/OpenNI2.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Samples.cmake)
