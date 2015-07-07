// pair - ペア (ラッパ)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_PAIR_WRAPPER_AS
#define IG_ABSTRACT_DATA_STRUCTURE_PAIR_WRAPPER_AS

// @ pair
// @ 2つの要素はそれぞれ <lhs, rhs> と呼び、また、それぞれに <[0], [1]> という index を割り振る。

#include "pair_impl.as"

//##############################################################################
//                abdata::pair (<lhs, rhs>)
//##############################################################################
//------------------------------------------------
// 要素の idx 値
//------------------------------------------------
#define global PairIdx_Lhs PairImplIdx_Lhs
#define global PairIdx_Rhs PairImplIdx_Rhs

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype pair_size(%1)  pairImpl_size ( pairInsts(%1) )
#define global ctype pair_empty(%1) pairImpl_empty( pairInsts(%1) )
#define global pair_count  pair_size
#define global pair_length pair_size

//##############################################################################
//                構築・解体
//##############################################################################
//------------------------------------------------
//------------------------------------------------
#define global pair_new(%1, %2 = stt_zero@, %3 = stt_zero@) \
	pairImpl_new pairInsts, %2, %3 : %1 = stat
	
#define global pair_delete(%1) pairImpl_delete pairInsts(%1)

//------------------------------------------------
// 構築者
//------------------------------------------------
#module

#define global ctype new_pair(%1 = stt_zero@, %2 = stt_zero@) new_pair_(%1, %2)
#defcfunc new_pair_ var lhs, var rhs,  local newObj
	pair_new newObj, lhs, rhs
	return newObj
	
#global

//------------------------------------------------
// [i] 構築
//------------------------------------------------

//------------------------------------------------
// [i] 解体
//------------------------------------------------

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得
//------------------------------------------------
#define global       pair_getv(%1,%2,%3=0)   pairImpl_getv pairInsts(%1), %2, %3
#define global ctype pair_get(%1,%2=0)       pairImpl_get( pairInsts(%1), %2 )
#define global ctype pair_getvLhs(%1,%2)     pairImpl_getvLhs( pairInsts(%1), %2 )
#define global ctype pair_getvRhs(%1,%2)     pairImpl_getvRhs( pairInsts(%1), %2 )
#define global       pair_getvBoth(%1,%2,%3) pairImpl_getvBoth(pairInsts(%1), %2, %3)

#define global ctype pair_getLhs(%1)         pairImpl_getLhs(pairInsts(%1))
#define global ctype pair_getRhs(%1)         pairImpl_getRhs(pairInsts(%1))

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global pair_clone(%1,%2,%3=0) pairImpl_clone    pairInsts(%1), %2, %3
#define global pair_cloneLhs(%1,%2)   pairImpl_cloneLhs pairInsts(%1), %2
#define global pair_cloneRhs(%1,%2)   pairImpl_cloneRhs pairInsts(%1), %2

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global ctype pair_vartype(%1,%2) pairImpl_vartype(pairInsts(%1), %2)
#define global ctype pair_vartypeLhs(%1) pairImpl_vartypeLhs(pairInsts(%1))
#define global ctype pair_vartypeRhs(%1) pairImpl_vartypeRhs(pairInsts(%1))

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global pair_set(%1,%2,%3=0) pairImpl_set    pairInsts(%1), %2, %3		// (%3 := idx)
#define global pair_setLhs(%1,%2)   pairImpl_setLhs pairInsts(%1), %2
#define global pair_setRhs(%1,%2)   pairImpl_setRhs pairInsts(%1), %2

#define global pair_setvLhs(%1,%2) pairImpl_setvLhs pairInsts(%1), %2
#define global pair_setvRhs(%1,%2) pairImpl_setvRhs pairInsts(%1), %2

#define global pair_setBoth(%1,%2,%3)  pairImpl_setBoth  pairInsts(%1), %2, %3
#define global pair_setvBoth(%1,%2,%3) pairImpl_setvBoth pairInsts(%1), %2, %3

//------------------------------------------------
// 要素交換
// @ lhs と rhs を交換する
//------------------------------------------------
#define global pair_swap(%1) pairImpl_swap pairInsts(%1)

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#define global pair_clear(%1) pairImpl_clear pairInsts(%1)

//------------------------------------------------
// [i] 複写
//------------------------------------------------
#define global pair_copy(%1,%2) pairImpl_copy pairInsts(%1), pairInsts(%2)

//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global pair_chain(%1,%2) "pair_chain は不可能。[pair_chain(%1, %2)]"
;#define global pair_chain(%1,%2) pairImpl_chain pairInsts(%1), pairInsts(%2)

//------------------------------------------------
// [i] 交換
//------------------------------------------------
#define global pair_exchange(%1,%2) pairImpl_exchange pairInsts(%1), pairInsts(%2)

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#define global pair_iterInit(%1,%2) pairImpl_iterInit pairInsts(%1), %2

//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#define global ctype pair_iterNext(%1,%2,%3) pairImpl_iterNext( pairInsts(%1), %2, %3 )

//##########################################################
//        雑多系
//##########################################################

//------------------------------------------------
// 
//------------------------------------------------	

//##############################################################################
//                デバッグ用
//##############################################################################
//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global pair_dbglog(%1) pairImpl_dbglog_ pairInsts(%1), "%1"

	pair_new pairNull
	
//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	pair_new     p
	pair_setBoth p, 1, 2
	pair_dbglog  p
	
	p = pairNull
	
	stop
	
#endif

#endif
