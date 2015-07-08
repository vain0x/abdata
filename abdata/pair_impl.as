#ifndef IG_ABDATA_PAIR_IMPL_AS
#define IG_ABDATA_PAIR_IMPL_AS

// ちょうど2つの要素からなるコンテナ
// 2つの要素はそれぞれ <lhs, rhs> と呼び、また、それぞれに <[0], [1]> という index を割り振る。

#include "abelem.as"
#include "mod_pvalptr.as"

#module abdata_pair_impl mValue

#define true  1
#define false 0

#define ctype ARG_TEMP(%1) pair_argtmp_%1@__abdata

//------------------------------------------------
// 要素の idx 値
//------------------------------------------------
#define global PairImplIdx_Lhs 0
#define global PairImplIdx_Rhs 1

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype pairImpl_size(%1)  2
#define global ctype pairImpl_empty(%1) 0
#define global pairImpl_count  pairImpl_size
#define global pairImpl_length pairImpl_size

//##############################################################################
//                構築・解体
//##############################################################################
//------------------------------------------------
//------------------------------------------------
#define global pairImpl_new(%1, %2 = stt_zero@, %3 = stt_zero@) \
	ARG_TEMP@abdata_pair_impl(new_lhs) = %2 :\
	ARG_TEMP@abdata_pair_impl(new_rhs) = %3 :\
	newmod %1, abdata_pair_impl@, ARG_TEMP@abdata_pair_impl(new_lhs), ARG_TEMP@abdata_pair_impl(new_rhs)
	//
	
#define global pairImpl_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit var lhs, var rhs
	abelem_new mValue, lhs
	abelem_new mValue, rhs
	return getaptr(thismod)
	
//------------------------------------------------
// [i] 解体
//------------------------------------------------

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得
//------------------------------------------------
#modfunc pairImpl_getv var vResult, int idx
	abelem_getv mValue(idx), vResult
	return
	
#modcfunc pairImpl_get int idx,  local tmp
	pairImpl_getv thismod, tmp, idx
	return tmp
	
#define global pairImpl_getvLhs(%1,%2) pairImpl_getv %1, %2, PairImplIdx_Lhs
#define global pairImpl_getvRhs(%1,%2) pairImpl_getv %1, %2, PairImplIdx_Rhs

#modfunc pairImpl_getvBoth var vResultLhs, var vResultRhs
	pairImpl_getvLhs thismod, vResultLhs
	pairImpl_getvRhs thismod, vResultRhs
	return
	
#define global ctype pairImpl_getLhs(%1) pairImpl_get(%1, PairImplIdx_Lhs)
#define global ctype pairImpl_getRhs(%1) pairImpl_get(%1, PairImplIdx_Rhs)

//------------------------------------------------
// クローンを作る
//------------------------------------------------
#modfunc pairImpl_clone var vSrc, int idx
	abelem_clone mValue(idx), vSrc
	return
	
#define global pairImpl_cloneLhs(%1,%2) pairImpl_clone %1, %2, PairImplIdx_Lhs
#define global pairImpl_cloneRhs(%1,%2) pairImpl_clone %1, %2, PairImplIdx_Rhs

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc pairImpl_vartype int idx
	return abelem_vartype( mValue(idx) )
	
#define global ctype pairImpl_vartypeLhs(%1) pairImpl_vartype(%1, PairImplIdx_Lhs)
#define global ctype pairImpl_vartypeRhs(%1) pairImpl_vartype(%1, PairImplIdx_Rhs)

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// 値の設定
// 
// @ set    => 片方
// @ assign => 両方
//------------------------------------------------
#define global pairImpl_set(%1,%2,%3 = 0) \
	ARG_TEMP@abdata_pair_impl(set) = (%2) : pairImpl_setv %1, ARG_TEMP@abdata_pair_impl(set), %3
#modfunc pairImpl_setv var dst, int idx
	abelem_setv mValue(idx), dst
	return
	
#define global pairImpl_setLhs(%1,%2) pairImpl_set %1, %2, PairImplIdx_Lhs
#define global pairImpl_setRhs(%1,%2) pairImpl_set %1, %2, PairImplIdx_Rhs

#define global pairImpl_setvLhs(%1,%2) pairImpl_setv %1, %2, PairImplIdx_Lhs
#define global pairImpl_setvRhs(%1,%2) pairImpl_setv %1, %2, PairImplIdx_Rhs

#define global pairImpl_setBoth(%1,%2,%3) \
	ARG_TEMP@abdata_pair_impl(set_lhs) = (%2) :\
	ARG_TEMP@abdata_pair_impl(set_rhs) = (%3) :\
	pairImpl_setvBoth %1, ARG_TEMP@abdata_pair_impl(set_lhs), ARG_TEMP@abdata_pair_impl(set_rhs)

#modfunc pairImpl_setvBoth var lhs, var rhs
	abelem_setv mValue(PairImplIdx_Lhs), lhs
	abelem_setv mValue(PairImplIdx_Rhs), rhs
	return
	
//------------------------------------------------
// 要素交換
// @ lhs と rhs を交換する
//------------------------------------------------
#modfunc pairImpl_loc_swap  local tmpLhs, local tmpRhs
	pairImpl_getvLhs thismod, tmpLhs
	pairImpl_getvRhs thismod, tmpRhs
	pairImpl_setvLhs thismod, tmpRhs
	pairImpl_setvRhs thismod, tmpLhs
	return
	
//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc pairImpl_clear
	repeat pairImpl_size(thismod)
		abelem_delete mValue(cnt)
	loop
	repeat pairImpl_size(thismod)
		abelem_new mValue
	loop
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc pairImpl_copy var src
	pairImpl_clear  thismod
	pairImpl_setLhs thismod, pairImpl_getLhs(src)
	pairImpl_setRhs thismod, pairImpl_getRhs(src)
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global pairImpl_chain(%1,%2) "pair_chain はできません。[pair_chain(%1, %2)]"
;#modfunc pairImpl_chain var mv_from
;	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc pairImpl_swap var mv2,  local tmp
	pairImpl_new  tmp
	pairImpl_copy tmp, thismod
	pairImpl_copy thismod, mv2
	pairImpl_copy   tmp,   tmp
	pairImpl_delete tmp
	return
	
//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc pairImpl_iterInit var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc pairImpl_iterNext var vIt, var iterData
	iterData ++
	
	if ( 0 <= iterData && iterData < pairImpl_size(thismod) ) {
		pairImpl_getv thismod, vIt, iterData
		return true
	} else {
		return false
	}
	
//##########################################################
//        雑多系
//##########################################################

//------------------------------------------------
// 
//------------------------------------------------	

//##############################################################################
//                デバッグ用
//##############################################################################
#ifdef _DEBUG

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global pairImpl_dbglog(%1) pairImpl_dbglog_ %1, "%1"

#modfunc pairImpl_dbglog_ str _ident,  local ident, local lhs, local rhs
	ident = _ident
	pairImpl_getvBoth thismod, lhs, rhs
	logmes "pair " + strtrim(ident, 0, ' ') + " = <" + lhs + ", " + rhs + ">\n"
	return
	
#else

#define global pairImpl_dbglog(%1) :

#endif
	
#global

#endif
