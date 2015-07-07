// ‘o•ûŒüƒŠƒ“ƒN•t‚«—v‘f

#ifndef __ABSTRACT_DATA_STRUCTURE_DOUBLE_LINK_VALUE_AS__
#define __ABSTRACT_DATA_STRUCTURE_DOUBLE_LINK_VALUE_AS__

#include "Mo/pvalptr.as"

#module DLinkValue mVal, mLinkNext, mLinkPrev

#define mv modvar DLinkValue@

#modfunc DLV_setv var p2
	mVal = p2
	return
	
#modfunc DLV_setNext int nxt
	mLinkNext = nxt
	return
	
#modfunc DLV_setPrev int prv
	mLinkPrev = prv
	return
	
#modinit var p2, int nxt, int prv
	DLV_setv     thismod, p2
	DLV_setNext  thismod, nxt
	DLV_setPrev  thismod, prv
	return getaptr(thismod)
	
#modfunc DLV_getv var p2
	p2 = mVal
	return
	
#modfunc DLV_dup var p2
	dup p2, mVal
	return
	
#defcfunc DLV_getValueType mv
	return vartype(mVal)
	
#defcfunc DLV_getNext mv
	return mLinkNext
	
#defcfunc DLV_getPrev mv
	return mLinkPrev
	
#define global DLV_new(%1,%2,%3=0,%4=0) newmod %1,DLinkValue@,%2,%3,%4
#define global DLV_delete(%1) delmod %1
	
#global

#endif
