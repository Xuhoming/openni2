append(OpenNI2_DEFS
    OPENNI2_EXPORT
)

append(OpenNI2_INCLUDES
    Include
    ThirdParty/PSCommon/XnLib/Include
    Source/Drivers/OniFile/Formats
    Source/Drivers/PS1080/Include
    Source/Drivers/PS1080/Core
    Source/Drivers/PS1080
    ThirdParty/GL
)

append(OpenNI2_SOURCES
    Source/Core/OniContext.cpp
    Source/Core/OniDataRecords.cpp
    Source/Core/OniDevice.cpp
    Source/Core/OniDeviceDriver.cpp
    Source/Core/OniDriverHandler.cpp
    Source/Core/OniRecorder.cpp
    Source/Core/OniStream.cpp
    Source/Core/OniStreamFrameHolder.cpp
    Source/Core/OniSyncedStreamsFrameHolder.cpp
    Source/Core/OpenNI.cpp

    Source/Drivers/OniFile/Formats/XnStreamCompression.cpp
)

append(OpenNI2_LIBS
    ${OPENGL_gl_LIBRARY}
    ${OPENGL_glu_LIBRARY}
    ${GLUT_glut_LIBRARY}
    XnLib
    jpeg
)

build_shared_library(OpenNI2)

install(DIRECTORY Include/ DESTINATION include/OpenNI2)
install(TARGETS OpenNI2 XnLib EXPORT OpenNI2-exports DESTINATION lib)
install(FILES OpenNI2-config.cmake DESTINATION share/OpenNI2)
install(EXPORT OpenNI2-exports DESTINATION share/OpenNI2)
