#ifndef __XNLINKENCODEDDATAUNIT_H__
#define __XNLINKENCODEDDATAUNIT_H__

#include "XnLinkDefs.h"
#include "XnLinkProto.h"
#include "XnLinkProtoUtils.h"
#include <XnStatus.h>

namespace xn
{

class LinkMsgEncoder
{
public:
	LinkMsgEncoder();
	virtual ~LinkMsgEncoder();

	//nMaxMsgSize includes all message headers (not link layer headers). nPacketSize is total link layer packet size, including link layer header.
	virtual XnStatus Init(XnUInt32 nMaxMsgSize, XnUInt16 nPacketSize);
	virtual void Shutdown();
	virtual void BeginEncoding(XnUInt16 nMsgType, 
	                           XnUInt16 nBasePacketID, 
							   XnUInt16 nStreamID, 
							   XnLinkFragmentation firstPacketFrag = XN_LINK_FRAG_BEGIN,
							   XnUInt16 nCID = 0);

	virtual void EncodeData(const void* pSourceData, XnUInt32 nSize);
	virtual void EndEncoding(XnLinkFragmentation lastPacketFrag = XN_LINK_FRAG_END);

	virtual const void* GetEncodedData() const;
	virtual XnUInt32 GetEncodedSize() const;
	virtual XnUInt32 GetMaxMsgSize() const;
	virtual XnUInt16 GetMaxPacketSize() const;

	//Returns the packet ID of the current packet. Only valid after encoding.
	virtual XnUInt16 GetPacketID() const;

	//This sets the packet ID of the CURRENT packet only. Only valid after encoding.
	virtual void SetPacketID(XnUInt16 nPacketID);

private:
	XnUInt32 m_nMaxMsgSize;
	XnUInt16 m_nMaxPacketSize;
	XnUInt32 m_nMaxNumPackets;
	XnUInt32 m_nBufferSize;

	/******* This points to the actual encoded data ******/
	XnUInt8* m_pOutputBuffer;
	/*****************************************************/

	union
	{
		XnUInt8* m_pCurrPacketBuffer;
		LinkPacketHeader* m_pCurrPacket;
	};
	LinkPacketHeader m_packetHeader;
	XnUInt32 m_nEncodedSize;
};

}


#endif // __XNLINKENCODEDDATAUNIT_H__