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
//---------------------------------------------------------------------------
// Includes
//---------------------------------------------------------------------------
#include "LinkOniStream.h"

//---------------------------------------------------------------------------
// LinkOniStream class
//---------------------------------------------------------------------------
#define XN_MASK_LINK_STREAM "LinkStream"

LinkOniStream::LinkOniStream(xn::PrimeClient* pSensor, OniSensorType sensorType, LinkOniDevice* pDevice) : 
	m_sensorType(sensorType),
	m_pSensor(pSensor),
	m_pDevice(pDevice),
	m_pInputStream(NULL),
	m_started(FALSE)
{
}

LinkOniStream::~LinkOniStream()
{
	destroy();
}

XnStatus LinkOniStream::Init()
{
	XnStatus nRetVal = XN_STATUS_OK;
	XnLinkStreamType linkStreamType;
	switch(m_sensorType)
	{
	case ONI_SENSOR_DEPTH:
		linkStreamType = XN_LINK_STREAM_TYPE_SHIFTS; break;
	//case ONI_SENSOR_COLOR:
	//	linkStreamType = XN_LINK_STREAM_TYPE_COLOR; break;
	case ONI_SENSOR_IR:
		linkStreamType = XN_LINK_STREAM_TYPE_IR; break;
	default:
		return XN_STATUS_BAD_PARAM;
	}
	nRetVal = m_pSensor->CreateInputStream(linkStreamType, NULL, m_streamId);
	XN_IS_STATUS_OK(nRetVal);
	
	// TODO: make sure this cast doesn't make us problems
	m_pInputStream = (xn::LinkFrameInputStream *)m_pSensor->GetInputStream(m_streamId);
	XN_VALIDATE_OUTPUT_PTR(m_pInputStream);

	m_pInputStream->GetNewFrameEvent().Register(OnNewStreamDataEventHandler, this, m_hNewDataCallback);
	XN_IS_STATUS_OK(nRetVal);

	return (XN_STATUS_OK);
}

void LinkOniStream::setServices(oni::driver::StreamServices* pStreamServices)
{
	oni::driver::StreamBase::setServices(pStreamServices);
	m_pInputStream->SetStreamServices(pStreamServices);
}

void LinkOniStream::destroy()
{
	stop();
	m_pInputStream->GetNewFrameEvent().Unregister(m_hNewDataCallback);
	m_pSensor->DestroyInputStream(m_streamId);
}

OniStatus LinkOniStream::start()
{
	if (!m_started)
	{
    	XnStatus nRetVal = m_pInputStream->Start();
		XN_IS_STATUS_OK_LOG_ERROR("Start streaming", (OniStatus)nRetVal);

		m_started = TRUE;
	}

	return ONI_STATUS_OK;
}

void LinkOniStream::stop()
{
	if (m_started)
	{
		m_started = FALSE;

		XnStatus nRetVal = m_pInputStream->Stop();
		if (nRetVal != XN_STATUS_OK)
		{
			xnLogWarning(XN_MASK_LINK_STREAM, "Failed to stop streaming: %s", xnGetStatusString(nRetVal));
			XN_ASSERT(FALSE);
		}
	}
}

OniStatus LinkOniStream::getProperty(int /*propertyId*/, void* /*data*/, int* /*pDataSize*/)
{
//	switch(propertyId)
//	{
//	default:
		return ONI_STATUS_BAD_PARAMETER;
//	}
}

OniStatus LinkOniStream::setProperty(int /*propertyId*/, const void* /*data*/, int /*dataSize*/)
{
//	switch(propertyId)
//	{
//	default:
		return ONI_STATUS_BAD_PARAMETER;
//	}
}

OniBool LinkOniStream::isPropertySupported(int /*propertyId*/)
{
	return FALSE;
}

void XN_CALLBACK_TYPE LinkOniStream::OnNewStreamDataEventHandler(const xn::NewFrameEventArgs& args, void* pCookie)
{
	LinkOniStream* pThis = (LinkOniStream*)pCookie;
	if (pThis->m_started)
	{
		pThis->getServices().addFrameRef(args.pFrame);
		pThis->raiseNewFrame(args.pFrame);
	}
}
