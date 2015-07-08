#ifndef IG_ABDATA_ABELEM_AS
#define IG_ABDATA_ABELEM_AS

#include "mod_pvalptr.as"
#include "mod_opCompare.as"

#module abdata_abelem mValue

#define global abelem_new(%1,%2 = stt_zero@) newmod %1, abdata_abelem@, %2
#define global abelem_delete(%1)             delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit var vSrc
	abelem_setv thismod, vSrc
	return getaptr(thismod)
	
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#modfunc abelem_getv var dst
	dst = mValue
	return
	
//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc abelem_clone var dst
	dup dst, mValue
	return
	
//------------------------------------------------
// 値の設定 ( 変数 )
//------------------------------------------------
#modfunc abelem_setv var src
	mValue = src
	return
	
//------------------------------------------------
// 可変長要素の拡張
//------------------------------------------------
#modfunc abelem_memexpand int size
	memexpand mValue, size
	return
	
//------------------------------------------------
// 要素の型を取得する
//------------------------------------------------
#modcfunc abelem_vartype
	return vartype(mValue)
	
//------------------------------------------------
// 要素の型を変換する
// 
// @+ 元の型と vt が同じなら変換しない。
//------------------------------------------------
#modfunc abelem_changeVartype int vt
	if ( vartype(mValue) != vt ) {
		dimtype mValue, vt
	}
	return
	
//------------------------------------------------
// 比較
//
// @result: 比較値 { -1 (<), 0 (==), +1 (>) }
//------------------------------------------------
#modcfunc abelem_cmp var rhs,  local vt, local tmp

	vt(0) = abelem_vartype( thismod )
	vt(1) = abelem_vartype( rhs )
	
	// 型で比較
	if ( vt(0) != vt(1) ) {
		return ( vt(0) - vt(1) )
	}
	
	// 値で比較
	dimtype tmp, vt(0), 2
	abelem_getv thismod, tmp(0)
	abelem_getv rhs,     tmp(1)
	
	return opCompare( tmp(0), tmp(1) )
	
#global

#endif
