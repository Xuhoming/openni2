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
    XnLib
    jpeg
)

build_shared_library(OpenNI2)

set_property(TARGET OpenNI2 PROPERTY LINK_INTERFACE_LIBRARIES "")

install(DIRECTORY Include/ DESTINATION include/OpenNI2)
install(TARGETS OpenNI2 EXPORT OpenNI2-exports
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)
install(FILES OpenNI2-config.cmake DESTINATION share/OpenNI2)
install(EXPORT OpenNI2-exports DESTINATION share/OpenNI2)
