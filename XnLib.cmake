target(XnLib)

append(XnLib_INCLUDES
    ThirdParty/PSCommon/XnLib/Include
)

if(WINDOWS)
    append(XnLib_INCLUDES ThirdParty/PSCommon/XnLib/Driver/Win32/Build/sys)
endif()

append(XnLib_SOURCES
    ThirdParty/PSCommon/XnLib/Source/XnDump.cpp
    ThirdParty/PSCommon/XnLib/Source/XnDumpFileWriter.cpp
    ThirdParty/PSCommon/XnLib/Source/XnErrorLogger.cpp
    ThirdParty/PSCommon/XnLib/Source/XnFiles.cpp
    ThirdParty/PSCommon/XnLib/Source/XnFPSCalculator.cpp
    ThirdParty/PSCommon/XnLib/Source/XnLib.cpp
    ThirdParty/PSCommon/XnLib/Source/XnLog.cpp
    ThirdParty/PSCommon/XnLib/Source/XnLogAndroidWriter.cpp
    ThirdParty/PSCommon/XnLib/Source/XnLogConsoleWriter.cpp
    ThirdParty/PSCommon/XnLib/Source/XnLogFileWriter.cpp
    ThirdParty/PSCommon/XnLib/Source/XnOS.cpp
    ThirdParty/PSCommon/XnLib/Source/XnOSMemoryProfiling.cpp
    ThirdParty/PSCommon/XnLib/Source/XnProfiling.cpp
    ThirdParty/PSCommon/XnLib/Source/XnScheduler.cpp
    ThirdParty/PSCommon/XnLib/Source/XnStatus.cpp
    ThirdParty/PSCommon/XnLib/Source/XnStrings.cpp
#    ThirdParty/PSCommon/XnLib/Source/XnSytmmetricMatrix3x3.cpp
    ThirdParty/PSCommon/XnLib/Source/XnThreads.cpp
    ThirdParty/PSCommon/XnLib/Source/XnUSB.cpp
    ThirdParty/PSCommon/XnLib/Source/XnVector3D.cpp
)

append(XnLib_WINDOWS_SOURCES
    ThirdParty/PSCommon/XnLib/Source/Win32/XnUSBWin32.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32CriticalSection.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Debug.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Events.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Files.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32INI.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Keyboard.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Memory.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Mutex.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Network.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32OS.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Processes.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Semaphore.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32SharedLibrary.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32SharedMemory.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Strings.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Threads.cpp
    ThirdParty/PSCommon/XnLib/Source/Win32/XnWin32Time.cpp
)

append(XnLib_UNIX_SOURCES
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxCriticalSections.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxDebug.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxEvents.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxFiles.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxINI.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxKeyboard.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxMemory.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxMutex.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxNetwork.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxPosixEvents.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxPosixNamedEvents.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxProcesses.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxSharedLibs.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxSharedMemory.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxStrings.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxSysVNamedEvents.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxThreads.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxTime.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxUSB.cpp
    ThirdParty/PSCommon/XnLib/Source/Linux/XnLinuxUSBDevice.cpp
)

set(XnLib_PS3_SOURCES
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3CriticalSections.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Events.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Files.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3INI.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Memory.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Mutex.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Network.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3SharedLibs.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Strings.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Threads.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3Time.cpp
    ThirdParty/PSCommon/XnLib/Source/PS3/XnPS3USB.cpp
)

append(XnLib_LIBS
    usb
)

build_static_library(XnLib)
