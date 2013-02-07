cmake_minimum_required(VERSION 2.8)

include(${CMAKE_CURRENT_LIST_DIR}/remake/remake.cmake)

project(OpenNI2)

find_package(jpeg REQUIRED NO_MODULE)
find_package(usb REQUIRED)
find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)

if(MACOSX)
    add_definitions(-DMACOS)
endif()

if(LINUX AND M64)
    add_compile_flags("-fPIC")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/XnLib.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Drivers.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/OpenNI2.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Samples.cmake)

file(GLOB_RECURSE globs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
#    Samples/*.cpp
    Source/*.cpp
    ThirdParty/PSCommon/XnLib/Source/*.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/*.cpp
)

list(REMOVE_ITEM globs
    ${DummyDevice_SOURCES}
    ${OniFile_SOURCES}
    ${PS1080_SOURCES}
    ${TestDevice_SOURCES}
    ${ps3_SOURCES}
    ${win32_SOURCES}
)

set(globs_txt ${CMAKE_CURRENT_SOURCE_DIR}/globs.txt)

file(REMOVE ${globs_txt})
foreach(glob ${GLOBS})
    file(APPEND ${globs_txt} ${glob})
endforeach()
