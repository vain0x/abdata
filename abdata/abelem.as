#ifndef IG_ABDATA_ABELEM_AS
#define IG_ABDATA_ABELEM_AS

#include "mod_pvalptr.as"
#include "mod_opCompare.as"

#module abdata_abelem mValue

#define global abelem_new(%1,%2 = stt_zero@) newmod %1, abdata_abelem@, %2
#define global abelem_delete(%1)             delmod %1

//------------------------------------------------
// \’z
//------------------------------------------------
#modinit var vSrc
	abelem_setv thismod, vSrc
	return getaptr(thismod)
	
//------------------------------------------------
// ’l‚Ìæ“¾ ( –½—ßŒ`® )
//------------------------------------------------
#modfunc abelem_getv var dst
	dst = mValue
	return
	
//------------------------------------------------
// QÆ‰» ( –½—ßŒ`® )
//------------------------------------------------
#modfunc abelem_clone var dst
	dup dst, mValue
	return
	
//------------------------------------------------
// ’l‚Ìİ’è ( •Ï” )
//------------------------------------------------
#modfunc abelem_setv var src
	mValue = src
	return
	
//------------------------------------------------
// ‰Â•Ï’·—v‘f‚ÌŠg’£
//------------------------------------------------
#modfunc abelem_memexpand int size
	memexpand mValue, size
	return
	
//------------------------------------------------
// —v‘f‚ÌŒ^‚ğæ“¾‚·‚é
//------------------------------------------------
#modcfunc abelem_vartype
	return vartype(mValue)
	
//------------------------------------------------
// —v‘f‚ÌŒ^‚ğ•ÏŠ·‚·‚é
// 
// @+ Œ³‚ÌŒ^‚Æ vt ‚ª“¯‚¶‚È‚ç•ÏŠ·‚µ‚È‚¢B
//------------------------------------------------
#modfunc abelem_changeVartype int vt
	if ( vartype(mValue) != vt ) {
		dimtype mValue, vt
	}
	return
	
//------------------------------------------------
// ”äŠr
//
// @result: ”äŠr’l { -1 (<), 0 (==), +1 (>) }
//------------------------------------------------
#modcfunc abelem_cmp var rhs,  local vt, local tmp

	vt(0) = abelem_vartype( thismod )
	vt(1) = abelem_vartype( rhs )
	
	// Œ^‚Å”äŠr
	if ( vt(0) != vt(1) ) {
		return ( vt(0) - vt(1) )
	}
	
	// ’l‚Å”äŠr
	dimtype tmp, vt(0), 2
	abelem_getv thismod, tmp(0)
	abelem_getv rhs,     tmp(1)
	
	return opCompare( tmp(0), tmp(1) )
	
#global

#endif
