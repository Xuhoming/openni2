find_package(OpenGL REQUIRED)

if(WINDOWS)
    set(GLUT_ROOT "${CMAKE_CURRENT_LIST_DIR}/ThirdParty/GL")
    if(M64)
        set(GLUT_LIB_NAME glut64)
    else()
        set(GLUT_LIB_NAME glut32)
    endif()
    find_path(GLUT_INCLUDE_DIR NAMES GL/glut.h PATHS ${GLUT_ROOT})
    find_library(GLUT_glut_LIBRARY NAMES ${GLUT_LIB_NAME} PATHS ${GLUT_ROOT})
    install(FILES ${GLUT_ROOT}/${GLUT_LIB_NAME}.dll DESTINATION bin)
else()
    find_package(GLUT REQUIRED)
endif()

set(openni2_samples_LIBS
    OpenNI2
    XnLib
    ${OPENGL_gl_LIBRARY}
    ${OPENGL_glu_LIBRARY}
    ${GLUT_glut_LIBRARY}
)

macro(build_openni2_sample target)
    append(${target}_INCLUDES
        Include
        Samples
        ThirdParty/PSCommon/XnLib/Include
        ThirdParty/GL
    )
    append(${target}_DEFS GLUT_NO_AUTOLINK)
    append(${target}_LIBS ${openni2_samples_LIBS})
    build_executable(${target})
    install(TARGETS ${target} DESTINATION bin)
endmacro()

INCLUDE_DIRECTORIES(Samples/common)

# Samples/Common/OniSampleUtilities.h

target(NiViewer)
append(NiViewer_SOURCES
#    Source/Tools/NiViewer/Audio.cpp
    Source/Tools/NiViewer/Capture.cpp
    Source/Tools/NiViewer/Device.cpp
    Source/Tools/NiViewer/Draw.cpp
    Source/Tools/NiViewer/Keyboard.cpp
    Source/Tools/NiViewer/Menu.cpp
    Source/Tools/NiViewer/MouseInput.cpp
    Source/Tools/NiViewer/NiViewer.cpp
)
build_openni2_sample(NiViewer)

target(MWClosestPoint)
append(MWClosestPoint_INCLUDES
    Include
)
append(MWClosestPoint_SOURCES
    Samples/MWClosestPoint/MWClosestPoint.cpp
    Samples/MWClosestPoint/MWClosestPoint.h
)
append(MWClosestPoint_LIBS ${openni2_samples_LIBS})
build_shared_library(MWClosestPoint)

target(MWClosestPointApp)
append(MWClosestPointApp_INCLUDES
    Include
    Samples/MWClosestPoint
)
append(MWClosestPointApp_SOURCES
    Samples/MWClosestPointApp/main.cpp
)
append(MWClosestPointApp_LIBS MWClosestPoint)
build_openni2_sample(MWClosestPointApp)

target(ClosestPointViewer)
append(ClosestPointViewer_SOURCES
    Samples/ClosestPointViewer/main.cpp
    Samples/ClosestPointViewer/Viewer.cpp
    Samples/ClosestPointViewer/Viewer.h
)
append(ClosestPointViewer_LIBS MWClosestPoint)
build_openni2_sample(ClosestPointViewer)

target(EventBasedRead)
append(EventBasedRead_SOURCES Samples/EventBasedRead/main.cpp)
build_openni2_sample(EventBasedRead)

target(MultiDepthViewer)
append(MultiDepthViewer_SOURCES
    Samples/MultiDepthViewer/main.cpp
    Samples/MultiDepthViewer/Viewer.cpp
    Samples/MultiDepthViewer/Viewer.h
)
build_openni2_sample(MultiDepthViewer)

target(MultiStreamRead)
append(MultiStreamRead_SOURCES
    Samples/MultipleStreamRead/main.cpp
)
build_openni2_sample(MultiStreamRead)

target(SimpleRead)
append(SimpleRead_SOURCES
    Samples/SimpleRead/main.cpp
)
build_openni2_sample(SimpleRead)

target(SimpleViewer)
append(SimpleViewer_SOURCES
    Samples/SimpleViewer/main.cpp
    Samples/SimpleViewer/Viewer.cpp
    Samples/SimpleViewer/Viewer.h
)
build_openni2_sample(SimpleViewer)
