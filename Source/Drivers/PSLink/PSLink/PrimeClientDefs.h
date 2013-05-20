#ifndef __PRIMECLIENTDEFS_H__
#define __PRIMECLIENTDEFS_H__

#ifdef PRIMECLIENT_EXPORTS
#define XN_PRIME_CLIENT_CPP_API XN_API_EXPORT
#else
#define XN_PRIME_CLIENT_CPP_API XN_API_IMPORT
#endif

//---------------------------------------------------------------------------
// Macros for working with properties
//---------------------------------------------------------------------------
#define EXACT_PROP_SIZE(size, type) \
	if ((size_t)size != sizeof(type)) return ONI_STATUS_BAD_PARAMETER;
#define EXACT_PROP_SIZE_DO(size, type) \
	if ((size_t)size != sizeof(type)) 

#define ENSURE_PROP_SIZE(size, minType) \
	if (((size_t)size < sizeof(minType)) || ((size != 1) && (size != 2) && (size != 4) && (size != 8))) return ONI_STATUS_BAD_PARAMETER;
#define ENSURE_PROP_SIZE_DO(size, minType) \
	if (((size_t)size < sizeof(minType)) || ((size != 1) && (size != 2) && (size != 4) && (size != 8))) 

#define ASSIGN_PROP_VALUE_INT(pDst, dstSize, value)  \
	if     (dstSize == 8) *(int64_t*)pDst = (int64_t)(value); \
	else if(dstSize == 4) *(int*)    pDst = (int)    (value); \
	else if(dstSize == 2) *(short*)  pDst = (short)  (value); \
	else if(dstSize == 1) *(char*)   pDst = (char)   (value); 

#define ASSIGN_PROP_VALUE_FLOAT(pDst, dstSize, value)  \
	if     (dstSize == 8) *(XnDouble*)pDst = (XnDouble)(value); \
	else if(dstSize == 4) *(XnFloat*) pDst = (XnFloat) (value);


#endif // __PRIMECLIENTDEFS_H__
