// 汎値型 (実装)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_valueImpl_IMPL_AS
#define IG_ABSTRACT_DATA_STRUCTURE_valueImpl_IMPL_AS

#include "mod_pvalptr.as"

//##############################################################################
//                abdata::value
//##############################################################################
#module abdata_value_impl mValue

#define global valueInsts   st_allinsts@abdata_value_impl
#define global valueNull    st_valueNull@abdata_value_impl

#define ctype ARG_TEMP(%1) st_temp_%1_arg@abdata_value_impl

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype valueImpl_size(%1)  1
#define global ctype valueImpl_empty(%1) 0
#define global valueImpl_count  valueImpl_size
#define global valueImpl_length valueImpl_size

//##########################################################
//        構築・解体
//##########################################################
#define global valueImpl_new(%1,%2 = stt_zero@) newmod %1, abdata_value_impl@, %2
#define global valueImpl_delete(%1)             delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit var vSrc
	valueImpl_setv thismod, vSrc
	return getaptr(thismod)
	
//------------------------------------------------
// 解体
//------------------------------------------------
;#modterm

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得
//------------------------------------------------
#modfunc valueImpl_getv var dst
	dst = mValue
	return
	
#modcfunc valueImpl_get
	return mValue
	
//------------------------------------------------
// 参照化
//------------------------------------------------
#modfunc valueImpl_clone var dst
	dup dst, mValue
	return
	
//------------------------------------------------
// 型の取得
//------------------------------------------------
#modcfunc valueImpl_vartype
	return vartype(mValue)
	
//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global valueImpl_set(%1, %2) ARG_TEMP@abdata_value_impl(set) = (%2) : valueImpl_setv %1, ARG_TEMP@abdata_value_impl(set)
#modfunc valueImpl_setv var src
	mValue = src
	return
	
//------------------------------------------------
// 可変長要素の拡張
//------------------------------------------------
#modfunc valueImpl_memexpand int size
	memexpand mValue, size
	return
	
//------------------------------------------------
// 要素の型を変換する
// 
// @+ 元の型と vt が同じなら変換しない。
//------------------------------------------------
#modfunc valueImpl_changeVartype int vt
	if ( vartype(mValue) != vt ) {
		dimtype mValue, vt
	}
	return
	
//##########################################################
//        雑多系
//##########################################################

//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc valueImpl_clear
	dim mValue
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc valueImpl_copy var src,  local tmp
	valueImpl_getv src,     tmp
	valueImpl_setv thismod, tmp
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global valueImpl_chain(%1, %2) "value_chain はできません。[value_chain(%1, %2)]"
;#modfunc valueImpl_chain var src
;	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc valueImpl_exchange var mv2,  local tmp
	valueImpl_getv thismod, tmp			// tmp  <- this
	valueImpl_copy thismod, mv2			// this <- mv2
	valueImpl_setv mv2,     tmp			// mv2  <- tmp
	return
	
//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc valueImpl_iterInit var iterData
	iterData = false
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc valueImpl_iterNext var vIt, var iterData
	if ( iterData == false ) {				// 初回 (のみ)
		iterData = true
		valueImpl_setv thismod, vIt
		return true
	}
	return false
	
#global

	valueImpl_new st_valueNull@abdata_value_impl
	
#endif
