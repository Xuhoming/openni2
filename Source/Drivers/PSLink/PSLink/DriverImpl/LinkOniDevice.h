/*****************************************************************************
*                                                                            *
*  OpenNI 2.x Alpha                                                          *
*  Copyright (C) 2012 PrimeSense Ltd.                                        *
*                                                                            *
*  This file is part of OpenNI.                                              *
*                                                                            *
*  Licensed under the Apache License, Version 2.0 (the "License");           *
*  you may not use this file except in compliance with the License.          *
*  You may obtain a copy of the License at                                   *
*                                                                            *
*      http://www.apache.org/licenses/LICENSE-2.0                            *
*                                                                            *
*  Unless required by applicable law or agreed to in writing, software       *
*  distributed under the License is distributed on an "AS IS" BASIS,         *
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  *
*  See the License for the specific language governing permissions and       *
*  limitations under the License.                                            *
*                                                                            *
*****************************************************************************/
#ifndef __LINK_ONI_DEVICE_H__
#define __LINK_ONI_DEVICE_H__

//---------------------------------------------------------------------------
// Includes
//---------------------------------------------------------------------------
#include <Driver/OniDriverAPI.h>
#include <XnLib.h>
#include "LinkOniDepthStream.h"
#include "LinkOniIRStream.h"
//#include "LinkOniColorStream.h"

#include <PrimeClient.h>

//---------------------------------------------------------------------------
// Types
//---------------------------------------------------------------------------

class LinkOniStream;
class LinkOniDriver;

class LinkOniDevice :
	public oni::driver::DeviceBase
{
public:
	LinkOniDevice(const char* uri, oni::driver::DriverServices& driverServices, LinkOniDriver* pDriver);
	virtual ~LinkOniDevice();

	XnStatus Init();
	void     Destroy();

	OniDeviceInfo* GetInfo() { return &m_info; }

	OniStatus getSensorInfoList(OniSensorInfo** pSensors, int* numSensors);

	oni::driver::StreamBase* createStream(OniSensorType sensorType);
	void destroyStream(oni::driver::StreamBase* pStream);

	virtual OniStatus getProperty(int propertyId, void* data, int* pDataSize);
	virtual OniStatus setProperty(int propertyId, const void* data, int dataSize);
	virtual OniBool isPropertySupported(int propertyId);
	virtual void notifyAllProperties();

	virtual OniStatus invoke(int commandId, void* data, int dataSize);
	virtual OniBool isCommandSupported(int commandId);

	//virtual OniStatus EnableFrameSync(LinkOniStream** pStreams, int streamCount);
	//virtual void DisableFrameSync();

	//virtual OniBool isImageRegistrationModeSupported(OniImageRegistrationMode mode);

	xn::PrimeClient* GetSensor() 
	{ 
		return m_pSensor;
	}

	LinkOniDriver* GetDriver()
	{
		return m_pDriver;
	}

private:
	XN_DISABLE_COPY_AND_ASSIGN(LinkOniDevice)

	XnStatus readSupportedModesFromStream(XnStreamInfo &info, xnl::Array<XnStreamVideoMode> &aSupportedModes);
	XnStatus FillSupportedVideoModes();

	OniDeviceInfo m_info;
	// the device we wrap
	xn::PrimeClient* m_pSensor;

	XnBool m_didReset;

	// what we supply
	int m_numSensors;
	OniSensorInfo m_sensors[10];

	oni::driver::DriverServices& m_driverServices;
	
	LinkOniDriver* m_pDriver;
};

#endif // __LINK_ONI_DEVICE_H__
