#ifndef _ONI_SENSOR_H_
#define _ONI_SENSOR_H_

#include "OniCommon.h"
#include "OniFrameManager.h"
#include "OniDriverHandler.h"
#include <Driver/OniDriverTypes.h>
#include <XnOSCpp.h>
#include <XnList.h>
#include <XnEvent.h>
#include <XnErrorLogger.h>

ONI_NAMESPACE_IMPLEMENTATION_BEGIN

/** Contains stuff that is common to several streams created on the same sensor */
class Sensor
{
public:
	Sensor(xnl::ErrorLogger& errorLogger, FrameManager& frameManager, const DriverHandler& driverHandler);
	~Sensor();

	void setDriverStream(void* streamHandle);
	OniStatus setFrameBufferAllocator(OniFrameAllocBufferCallback alloc, OniFrameFreeBufferCallback free, void* pCookie);
	void setRequiredFrameSize(int requiredFrameSize);
	OniFrame* acquireFrame();

	xnl::Event1Arg<OniFrame*>::Interface& newFrameEvent() { return m_newFrameEvent; }
	void* streamHandle() const { return m_streamHandle; }

	int m_streamCount;
	int m_startedStreamCount;
	xnl::CriticalSection m_refCountCS;

private:
	XN_DISABLE_COPY_AND_ASSIGN(Sensor);
	void resetFrameAllocator();

	// frame buffer management
	void* allocFrameBufferFromPool(int size);
	void releaseFrameBufferToPool(void* pBuffer);
	void releaseAllFrames();

	static void* ONI_CALLBACK_TYPE allocFrameBufferFromPoolCallback(int size, void* pCookie);
	static void ONI_CALLBACK_TYPE releaseFrameBufferToPoolCallback(void* pBuffer, void* pCookie);
	static void ONI_CALLBACK_TYPE freeFrameBufferMemoryCallback(void* pBuffer, void* pCookie);
	static void ONI_CALLBACK_TYPE frameBackToPoolCallback(OniFrameInternal* pFrame, void* pCookie);

	static void ONI_CALLBACK_TYPE newFrameCallback(void* streamHandle, OniFrame* pFrame, void* pCookie);

	xnl::ErrorLogger& m_errorLogger;
	FrameManager& m_frameManager;
	const DriverHandler& m_driverHandler;

	xnl::Event1Arg<OniFrame*> m_newFrameEvent;
	void* m_streamHandle;

	int m_requiredFrameSize;

	// following members are for the frame buffer pool that is used by default
	xnl::CriticalSection m_framesCS;
	xnl::List<void*> m_allFrameBuffers;
	xnl::List<void*> m_availableFrameBuffers;
	xnl::List<OniFrameInternal*> m_currentStreamFrames;

	// following members point to current allocation functions
	OniFrameAllocBufferCallback m_allocFrameBufferCallback;
	OniFrameFreeBufferCallback m_freeFrameBufferCallback;
	void* m_frameBufferAllocatorCookie;
};

ONI_NAMESPACE_IMPLEMENTATION_END

#endif //_ONI_SENSOR_H_