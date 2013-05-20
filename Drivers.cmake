macro(build_openni2_device target)
    append(${target}_INCLUDES
        Include
        ThirdParty/PSCommon/XnLib/Include
    )
    append(${target}_LIBS XnLib)
    build_module(${target})
    if(MACOSX)
        set_property(TARGET ${target} PROPERTY SUFFIX .dylib)
    endif()
    # lipo ${input} -create -output ${output}
    install(TARGETS ${target} DESTINATION bin/OpenNI2/Drivers)
endmacro()

if(WINDOWS)
    set(KINECTSDK_DIR $ENV{KINECTSDK10_DIR} CACHE PATH "Kinect SDK Directory")
    if(KINECTSDK_DIR)
        append(Kinect_INCLUDES "${KINECTSDK_DIR}/inc")
        if(M64)
            append(Kinect_LIBS "${KINECTSDK_DIR}/lib/amd64/Kinect10.lib")
        else()
            append(Kinect_LIBS "${KINECTSDK_DIR}/lib/x86/Kinect10.lib")
        endif()
        target(Kinect)
        append(Kinect_SOURCES
            Source/Drivers/Kinect/BaseKinectStream.cpp
            Source/Drivers/Kinect/ColorKinectStream.cpp
            Source/Drivers/Kinect/DepthKinectStream.cpp
            Source/Drivers/Kinect/IRKinectStream.cpp
            Source/Drivers/Kinect/KinectDevice.cpp
            Source/Drivers/Kinect/KinectDriver.cpp
            Source/Drivers/Kinect/KinectStreamImpl.cpp
        )
        build_openni2_device(Kinect)
    endif()
endif()

target(DummyDevice)
set(DummyDevice_SOURCES  Source/Drivers/DummyDevice/DummyDevice.cpp)
build_openni2_device(DummyDevice)

target(OniFile)
append(OniFile_SOURCES
    Source/Drivers/OniFile/DataRecords.cpp
    Source/Drivers/OniFile/Formats/XnCodec.cpp
    Source/Drivers/OniFile/Formats/XnStreamCompression.cpp
    Source/Drivers/OniFile/PlayerCodecFactory.cpp
    Source/Drivers/OniFile/PlayerDevice.cpp
    Source/Drivers/OniFile/PlayerDriver.cpp
    Source/Drivers/OniFile/PlayerNode.cpp
    Source/Drivers/OniFile/PlayerSource.cpp
    Source/Drivers/OniFile/PlayerStream.cpp
)
append(OniFile_LIBS jpeg)
build_openni2_device(OniFile)

target(PS1080)
append(PS1080_INCLUDES
    Source/Drivers/PS1080/Include
    Source/Drivers/PS1080
    Source/DepthUtils
)
append(PS1080_SOURCES
    Source/Drivers/PS1080/Core/XnBuffer.cpp
    Source/Drivers/PS1080/Core/XnCore.cpp
    Source/Drivers/PS1080/Core/XnCoreStatus.cpp
    Source/Drivers/PS1080/Core/XnIOFileStream.cpp
    Source/Drivers/PS1080/Core/XnIONetworkStream.cpp
    Source/Drivers/PS1080/DDK/XnActualGeneralProperty.cpp
    Source/Drivers/PS1080/DDK/XnActualIntProperty.cpp
    Source/Drivers/PS1080/DDK/XnActualPropertiesHash.cpp
    Source/Drivers/PS1080/DDK/XnActualRealProperty.cpp
    Source/Drivers/PS1080/DDK/XnActualStringProperty.cpp
    Source/Drivers/PS1080/DDK/XnAudioStream.cpp
    Source/Drivers/PS1080/DDK/XnCodecFactory.cpp
    Source/Drivers/PS1080/DDK/XnDDK.cpp
    Source/Drivers/PS1080/DDK/XnDDKStatus.cpp
    Source/Drivers/PS1080/DDK/XnDepthStream.cpp
    Source/Drivers/PS1080/DDK/XnDeviceBase.cpp
    Source/Drivers/PS1080/DDK/XnDeviceModule.cpp
    Source/Drivers/PS1080/DDK/XnDeviceModuleHolder.cpp
    Source/Drivers/PS1080/DDK/XnDeviceStream.cpp
    Source/Drivers/PS1080/DDK/XnFrameBufferManager.cpp
    Source/Drivers/PS1080/DDK/XnFrameStream.cpp
    Source/Drivers/PS1080/DDK/XnGeneralProperty.cpp
    Source/Drivers/PS1080/DDK/XnImageStream.cpp
    Source/Drivers/PS1080/DDK/XnIntProperty.cpp
    Source/Drivers/PS1080/DDK/XnIntPropertySynchronizer.cpp
    Source/Drivers/PS1080/DDK/XnIRStream.cpp
    Source/Drivers/PS1080/DDK/XnPixelStream.cpp
    Source/Drivers/PS1080/DDK/XnProperty.cpp
    Source/Drivers/PS1080/DDK/XnPropertySet.cpp
    Source/Drivers/PS1080/DDK/XnRealProperty.cpp
    Source/Drivers/PS1080/DDK/XnShiftToDepth.cpp
    Source/Drivers/PS1080/DDK/XnShiftToDepthStreamHelper.cpp
    Source/Drivers/PS1080/DDK/XnStreamingStream.cpp
    Source/Drivers/PS1080/DDK/XnStringProperty.cpp
    Source/Drivers/PS1080/DriverImpl/XnExportedOniDriver.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniColorStream.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniDepthStream.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniDevice.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniDriver.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniIRStream.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniMapStream.cpp
    Source/Drivers/PS1080/DriverImpl/XnOniStream.cpp
    Source/Drivers/PS1080/Formats/XnCodecs.cpp
    Source/Drivers/PS1080/Formats/XnFormats.cpp
    Source/Drivers/PS1080/Formats/XnFormatsMirror.cpp
    Source/Drivers/PS1080/Formats/XnFormatsStatus.cpp
    Source/Drivers/PS1080/Formats/XnStreamCompression.cpp
    Source/Drivers/PS1080/Sensor/Bayer.cpp
    Source/Drivers/PS1080/Sensor/Uncomp.cpp
    Source/Drivers/PS1080/Sensor/XnAudioProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnBayerImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnCmosInfo.cpp
    Source/Drivers/PS1080/Sensor/XnDataProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnDataProcessorHolder.cpp
    Source/Drivers/PS1080/Sensor/XnDepthProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnDeviceEnumeration.cpp
    Source/Drivers/PS1080/Sensor/XnDeviceSensorInit.cpp
    Source/Drivers/PS1080/Sensor/XnDeviceSensorIO.cpp
    Source/Drivers/PS1080/Sensor/XnDeviceSensorProtocol.cpp
    Source/Drivers/PS1080/Sensor/XnFirmwareCommands.cpp
    Source/Drivers/PS1080/Sensor/XnFirmwareInfo.cpp
    Source/Drivers/PS1080/Sensor/XnFirmwareStreams.cpp
    Source/Drivers/PS1080/Sensor/XnFrameStreamProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnGeneralDebugProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnGMCDebugProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnHostProtocol.cpp
    Source/Drivers/PS1080/Sensor/XnImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnIRProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnJpegImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnJpegToRGBImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnNesaDebugProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnPacked11DepthProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnPacked12DepthProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnPassThroughImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnPSCompressedDepthProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnPSCompressedImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnSensor.cpp
    Source/Drivers/PS1080/Sensor/XnSensorAudioStream.cpp
    Source/Drivers/PS1080/Sensor/XnSensorDepthStream.cpp
    Source/Drivers/PS1080/Sensor/XnSensorFirmware.cpp
    Source/Drivers/PS1080/Sensor/XnSensorFirmwareParams.cpp
    Source/Drivers/PS1080/Sensor/XnSensorFixedParams.cpp
    Source/Drivers/PS1080/Sensor/XnSensorFPS.cpp
    Source/Drivers/PS1080/Sensor/XnSensorImageStream.cpp
    Source/Drivers/PS1080/Sensor/XnSensorIRStream.cpp
    Source/Drivers/PS1080/Sensor/XnSensorStreamHelper.cpp
    Source/Drivers/PS1080/Sensor/XnStreamProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnTecDebugProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnUncompressedBayerProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnUncompressedDepthProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnUncompressedYUYVtoRGBImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnUncompressedYUV422toRGBImageProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnWavelengthCorrectionDebugProcessor.cpp
    Source/Drivers/PS1080/Sensor/XnWholePacketProcessor.cpp
    Source/Drivers/PS1080/Sensor/YUV.cpp

    Source/DepthUtils/DepthUtils.cpp
    Source/DepthUtils/DepthUtilsImpl.cpp
)
append(PS1080_LIBS jpeg)
if(WINDOWS)
    append(PS1080_LIBS wsock32 setupapi)
endif()
build_openni2_device(PS1080)

target(TestDevice)
append(TestDevice_SOURCES Source/Drivers/TestDevice/TestDevice.cpp)
build_openni2_device(TestDevice)
