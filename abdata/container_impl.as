// Container Impl - 汎用コンテナ (実装)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_CONTAINER_IMPL_AS
#define IG_ABSTRACT_DATA_STRUCTURE_CONTAINER_IMPL_AS

#include "abelem.as"				// 簡易要素型
#include "mod_shiftArray.as"		// 配列操作モジュール
;#include "mod_getnextaddindex.as"	// 次に追加される要素番号
#include "mod_pvalptr.as"			// 〃

//##############################################################################
//                ContainerImpl
//##############################################################################
#module abdata_con_impl mCnt, mElems, midlist
; abdata_container_impl は識別子長の限界を超えているため

#define       VAR_TEMP stt_temp@abdata_con_impl
#define ctype ARG_TEMP(%1) stt_temp_%1_arg@abdata_con_impl

#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0

#define ctype STR_ERR_OVER_RANGE(%1) "Error! [abdata コンテナ] 要素番号範囲外エラー("+ (%1) +")"

// SortMode
#enum global SortMode_Ascending = 0		// 昇順
#enum global SortMode_Decending = 1

//##############################################################################
//                構築・解体
//##############################################################################
#define global ContainerImpl_new(%1, %2 = 0, %3 = stt_zero@) \
	newmod %1, abdata_con_impl@, %2, %3
#define global ContainerImpl_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit int num, var vDefault
	
	// メンバ変数の初期化
	abelem_new mElems, vDefault
	midlist = 0
	mCnt    = 0
	
	// コンストラクト処理
	if ( num <= 0 ) {
		abelem_delete mElems(0)
		
	} else {
		// 連続確保
		repeat num
			abelem_new mElems, vDefault
			midlist(cnt) = cnt
			mCnt ++
		loop
	}
	
	return getaptr(thismod)
	
//------------------------------------------------
// 構築者
//------------------------------------------------
;#deffunc new_Container array mvArr_Container
;	ContainerImpl_new mvArr_Container
;	return
	
//------------------------------------------------
// [i] 解体
//------------------------------------------------
#modterm
;	ContainerImpl_clear thismod
	return
	
//------------------------------------------------
// 解体者
//------------------------------------------------
;#deffunc delete_Container var mvContainer
;	ContainerImpl_delete mvContainer
;	return
	
//##############################################################################
//                メンバ命令・関数
//##############################################################################

//################################################
//        取得系
//################################################
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#modfunc ContainerImpl_getv_ var result, int _i, int bRemove,  local i
	
	i = ContainerImpl_getRealIndex(thismod, _i)
	
	abelem_getv mElems( midlist(i) ), result
	
	if ( bRemove ) {
		ContainerImpl_remove thismod, i
	}
	
	return
	
#define global ContainerImpl_getv(%1,%2,%3=0) ContainerImpl_getv_ %1, %2, %3, 0
#define global ContainerImpl_popv(%1,%2,%3=0) ContainerImpl_getv_ %1, %2, %3, 1

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc ContainerImpl_get_ int i, int bRemove,  local tmp
	ContainerImpl_getv_ thismod, tmp, i, bRemove
	return tmp
	
#define global ctype ContainerImpl_get(%1,%2=0) ContainerImpl_get_(%1, %2, 0)
#define global ctype ContainerImpl_pop(%1,%2=0) ContainerImpl_get_(%1, %2, 1)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc ContainerImpl_clone var vRef, int i
	abelem_clone mElems( midlist( ContainerImpl_getRealIndex(thismod, i) ) ), vRef
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype ContainerImpl_ref(%1,%2=0) ARG_TEMP@abdata_con_impl(ref)( ContainerImpl_ref_(%1,%2) )
#modcfunc ContainerImpl_ref_ int i
	ContainerImpl_clone thismod, ARG_TEMP@abdata_con_impl(ref), i
	return 0
	
//------------------------------------------------
// 先頭・末尾の値の取得
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global ctype ContainerImpl_get_front(%1)     ContainerImpl_get(%1, 0)
#define global ctype ContainerImpl_get_back(%1)      ContainerImpl_get(%1, -1)
#define global       ContainerImpl_getv_front(%1,%2) ContainerImpl_getv %1, %2, 0
#define global       ContainerImpl_getv_back(%1,%2)  ContainerImpl_getv %1, %2, -1
#define global ctype ContainerImpl_pop_front(%1)     ContainerImpl_pop(%1, 0)
#define global ctype ContainerImpl_pop_back(%1)      ContainerImpl_pop(%1, -1)
#define global       ContainerImpl_popv_front(%1,%2) ContainerImpl_popv %1, %2, 0
#define global       ContainerImpl_popv_back(%1,%2)  ContainerImpl_popv %1, %2, -1

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc ContainerImpl_vartype int i
	return abelem_vartype( mElems(midlist(ContainerImpl_getRealIndex(thismod, i))) )
	
#define global ctype ContainerImpl_vartype_front(%1) ContainerImpl_vartype(%1, 0)
#define global ctype ContainerImpl_vartype_back(%1)  ContainerImpl_vartype(%1, -1)

//################################################
//        設定系
//################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global ContainerImpl_set(%1,%2,%3=0) ARG_TEMP@abdata_con_impl(set) = %2 : ContainerImpl_setv %1, ARG_TEMP@abdata_con_impl(set), %3
#modfunc ContainerImpl_setv var vValue, int i,  local iv
	
	iv = midlist( ContainerImpl_getRealIndex(thismod, i) )
	
	// 適切に型を変換する
	abelem_changeVartype mElems(iv), vartype(vValue)
	
	abelem_setv mElems( iv ), vValue
	
	return
	
//################################################
//        操作系
//################################################
//------------------------------------------------
// 挿入
// 
// @permit (i == mCnt) : 最後尾への追加のため
// @ i が範囲外 => {
// @	( i <     0 ) => i += mCnt,
// @	( i >= mCnt ) => i := mCnt,
// @ };
//------------------------------------------------
#define global ContainerImpl_insert(%1,%2,%3=0) ARG_TEMP@abdata_con_impl(insert) = %2 : ContainerImpl_insertv %1, ARG_TEMP@abdata_con_impl(insert), %3
#modfunc ContainerImpl_insertv var vValue, int _i,  local i, local id
	
	if ( _i < 0 ) {
		i = _i + mCnt
	} else : if ( _i > mCnt ) {
		i = mCnt
	} else {
		i = _i
	}
	
	// i 番目を空ける
	ArrayInsert midlist, i
	
	// 新規値を追加
;	id         = GetNextAddIndex( mElems )
	abelem_new mElems, vValue
	midlist(i) = stat	;id
	mCnt ++
	
	return
	
//------------------------------------------------
// 要素の倍化
//------------------------------------------------
#modfunc ContainerImpl_double int _i,  local i, local temp
	i = ContainerImpl_getRealIndex( thismod, _i )
	
	ContainerImpl_getv    thismod, temp, i
	ContainerImpl_insertv thismod, temp, i
	return
	
//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global ContainerImpl_double_front(%1)   ContainerImpl_double  %1, 0
#define global ContainerImpl_double_back(%1)    ContainerImpl_double  %1, (-1)
#define global ContainerImpl_push_front(%1,%2)  ContainerImpl_insert  %1, %2, 0
#define global ContainerImpl_pushv_front(%1,%2) ContainerImpl_insertv %1, %2, 0
#define global ContainerImpl_push_back(%1,%2)   ContainerImpl_insert  %1, %2, ContainerImpl_size(%1)
#define global ContainerImpl_pushv_back(%1,%2)  ContainerImpl_insertv %1, %2, ContainerImpl_size(%1)
#define global ContainerImpl_push               ContainerImpl_push_back
#define global ContainerImpl_pushv              ContainerImpl_pushv_back
#define global ContainerImpl_add                ContainerImpl_push_back

//------------------------------------------------
// 除去
//------------------------------------------------
#modfunc ContainerImpl_remove int _i,  local i, local ivRemoved
	
	i         = ContainerImpl_getRealIndex(thismod, _i)
	ivRemoved = midlist(i)
	
	// i 番目を詰める ( 実質的除去 )
	ArrayRemove midlist, i
	midlist( length(midlist) - 1 ) = -1		// 残骸を無効要素にする
	mCnt --
	
	// mElems の方も解放
	abelem_delete mElems( ivRemoved )
	return
	
#define global ContainerImpl_remove_front(%1) ContainerImpl_remove %1, 0
#define global ContainerImpl_remove_back(%1)  ContainerImpl_remove %1, (-1)

//------------------------------------------------
// 移動
//------------------------------------------------
#modfunc ContainerImpl_move int iSrc, int iDst
	if ( ContainerImpl_size(thismod) < 2 ) {		// 最低でも2つの要素がないと、move は意味がない
		return
	}
	
	ArrayMove midlist, ContainerImpl_getRealIndex(thismod, iSrc), ContainerImpl_getRealIndex(thismod, iDst)
	return
	
//------------------------------------------------
// 交換
//------------------------------------------------
#modfunc ContainerImpl_swap int iPos1, int iPos2
	if ( ContainerImpl_size(thismod) < 2 ) {		// 最低でも2つの要素がないと、swap は意味がない
		return
	}
	
	ArraySwap midlist, ContainerImpl_getRealIndex(thismod, iPos1), ContainerImpl_getRealIndex(thismod, iPos2)
	return
	
#define global ContainerImpl_swap_front(%1) ContainerImpl_swap %1,  0,  1
#define global ContainerImpl_swap_back(%1)  ContainerImpl_swap %1, -2, -1

//------------------------------------------------
// 巡回
//------------------------------------------------
#modfunc ContainerImpl_rotate int step
	ArrayRotate midlist, step
	return
	
//------------------------------------------------
// 巡回 ( 逆回転 )
//------------------------------------------------
#modfunc ContainerImpl_rotate_back
	ArrayRotateBack midlist
	return
	
//------------------------------------------------
// 反転
//------------------------------------------------
#modfunc ContainerImpl_reverse
	ArrayReverse midlist, ContainerImpl_size(thismod)
	return
	
//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc ContainerImpl_clear
	
	// 全要素を解放する
	foreach mElems
		abelem_delete mElems(cnt)
	loop
	
	// 番号リストを初期化
	dim midlist
	mCnt = 0
	
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc ContainerImpl_chain var src,  local tmp
 	repeat ContainerImpl_size( src )
		ContainerImpl_getv       src, tmp, cnt
		ContainerImpl_insert thismod, tmp, cnt
	loop
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc ContainerImpl_copy var src
	ContainerImpl_clear thismod
	ContainerImpl_chain thismod, src
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc ContainerImpl_exchange var obj2,  local tmp
	ContainerImpl_new  tmp
	ContainerImpl_copy tmp,  thismod
	ContainerImpl_copy thismod, obj2
	ContainerImpl_copy obj2,    tmp
	ContainerImpl_delete tmp
	return
	
//------------------------------------------------
// 整列
// 
// @alg: (based: Merge-Sort)
// @	1. 型タイプ値で整列
// @	2. 同じ型 => 不等号による比較で整列
// @prm mode : SortMode_* (default: SortMode_Ascening)
//------------------------------------------------
#modfunc ContainerImpl_sort int mode,  local arrTmp, local arrDst, local len, local p, local p1, local e1, local p2, local e2, local sizeSegment, local sizeSegMerged, local cmp
	len = ContainerImpl_size(thismod)
	dim     arrDst, len
	foreach arrDst
		arrDst(cnt) = cnt
	loop
	
	dim arrTmp, len
	
	// マージソート
	repeat
		sizeSegment = 1 << cnt		// 1, 2, 4, 8, ...
		
		// 2-Segment ごとにマージ
		repeat
			p  = sizeSegment * (cnt * 2)	// 2-Segment の先頭
			p1 = p							// lhs (left hand segment) 範囲 (先頭要素)
			e1 = p1 + sizeSegment			// 〃 (最終要素 + 1)
			p2 = e1							// rhs
			e2 = limit( p2 + sizeSegment, 0, len )
			sizeSegMerged = (e2 - p)		// マージ後の Segment サイズ
			
			if ( sizeSegMerged < sizeSegment ) { break }	// 閾値以下 => マージせず終了
			
			repeat sizeSegMerged
				if ( p2 >= e2 ) {			// rhs の取り出しが既に完了している
					arrTmp(cnt) = arrDst(p1) : p1 ++
				} else : if ( p1 >= e1 ) {	// lhs 〃
					arrTmp(cnt) = arrDst(p2) : p2 ++
				} else {
					// ?( 一致する or ( 左が小さく(真) 昇順(真) || 右が小さく(偽) 降順(偽) ) ) => lhs からとる
					cmp = ContainerImpl_opCmpElem( thismod, arrDst(p1), arrDst(p2) )
					if ( cmp == 0 || ( (cmp < 0) == (mode == SortMode_Ascending) ) ) {
						arrTmp(cnt) = arrDst(p1) : p1 ++
					} else {
						arrTmp(cnt) = arrDst(p2) : p2 ++
					}
				}
			loop
			
			// マージされた配列をソース配列に貼り付け
			memcpy arrDst(p), arrTmp, sizeSegMerged * 4
		loop
		
		// マージ終了 (1つの Segment に纏まったため)
		if ( len <= sizeSegment ) { break }
	loop
	
	// idx-list を変更
	memcpy midlist, arrDst, len * 4
	
	return
	
//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc ContainerImpl_iterInit var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc ContainerImpl_iterNext var vIt, var iterData
	iterData ++
	
	if ( ContainerImpl_isValid(thismod, iterData) == false ) {
		return false
	}
	
	ContainerImpl_getv thismod, vIt, iterData
	return true
	
//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc ContainerImpl_size
	return mCnt
	
#define global ContainerImpl_count  ContainerImpl_size
#define global ContainerImpl_length ContainerImpl_size
#define global ctype ContainerImpl_empty(%1) ( ContainerImpl_size(%1) == 0 )

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#modcfunc ContainerImpl_isValid int i
	if ( numrg(i, 0, mCnt - 1) ) {					// 有効範囲か
		if ( varuse( mElems(midlist(i)) ) ) {		// 有効な要素番号か
			return true
		}
	}
	return false
	
//------------------------------------------------
// 実際の要素番号を得る
// @private
//------------------------------------------------
#modcfunc ContainerImpl_getRealIndex@abdata_con_impl int _i,  local i
	i = _i
	
	// 循環参照
	if ( i < 0 ) {
		i += mCnt
	}
	
	if ( i < 0 || i >= mCnt ) {
		logmes STR_ERR_OVER_RANGE(i)
		return mCnt - 1
	}
	
	return i
	
//##########################################################
//        演算
//##########################################################
//------------------------------------------------
// 要素比較
//------------------------------------------------
#modcfunc ContainerImpl_opCmpElem int idxLhs, int idxRhs,  local vt, local tmp

	vt(0) = abelem_vartype( mElems(idxLhs) )
	vt(1) = abelem_vartype( mElems(idxRhs) )
	
	// 型で比較
	if ( vt(0) != vt(1) ) {
		return ( vt(0) - vt(1) )
	}
	
	// 値で比較
	dimtype tmp, vt(0), 2
	abelem_getv mElems(idxLhs), tmp(0)
	abelem_getv mElems(idxRhs), tmp(1)
	
	return opCompare( tmp(0), tmp(1) )
	
//##############################################################################
//                静的メンバ命令・関数
//##############################################################################
//------------------------------------------------
// 一般的な比較演算
// 
// @(condition): lhs, rhs の型は一致する
//------------------------------------------------
#defcfunc opCompare@abdata_con_impl var lhs, var rhs
	if ( vartype(lhs) == 2 /* vartype("str") */ ) {
		return (lhs != rhs)
	} else {
		if ( lhs < rhs ) {
			return -1
		} else : if ( lhs > rhs ) {
			return 1
		} else {
			return 0
		}
	}
	
//##############################################################################
//                デバッグ用
//##############################################################################
#ifdef _DEBUG

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global ContainerImpl_dbglog(%1) ContainerImpl_dbglog_ %1, "%1"

#modfunc ContainerImpl_dbglog_ str _ident,  local ident
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	repeat ContainerImpl_size(thismod)
		logmes strf("#%2d: ", cnt) + ContainerImpl_get(thismod, cnt)
	loop
	
	logmes ""
	return
	
#else

#define global ContainerImpl_dbglog(%1) :

#endif
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	ContainerImpl_new    vSt
	ContainerImpl_add    vSt, "Hello, world!"
	ContainerImpl_add    vSt, 100
	ContainerImpl_add    vSt, M_PI
	ContainerImpl_dbglog vSt
	ContainerImpl_move   vSt, 1, 2
	ContainerImpl_dbglog vSt
	
	ContainerImpl_insert vSt, 0x7FFFFFFF, 0
	ContainerImpl_dbglog vSt
	
	ContainerImpl_reverse vSt
	ContainerImpl_dbglog  vSt
	
	// 整列
	ContainerImpl_add    vSt, 39
	ContainerImpl_add    vSt, 18782
	ContainerImpl_add    vSt, 2943
	ContainerImpl_add    vSt, "ABCD包囲網"
	ContainerImpl_add    vSt, "Extra Strings"
	ContainerImpl_add    vSt, sqrt(2)
	ContainerImpl_add    vSt, sqrt(8)
	ContainerImpl_add    vSt, sqrt(3)
	ContainerImpl_dbglog vSt
	
	ContainerImpl_sort   vSt, SortMode_Decending
	ContainerImpl_dbglog vSt
	
	stop
	
#endif

#endif

/******
	
*	"index 管理"
	midlist $array[$int] に、mElems の要素番号である数値(ID)を代入しておく。
	※実際のデータは abdata_abelem の配列である mElems メンバに保存される。
	swap や move、inseart などは、これを使えば簡単かつ軽快にできる。
	
******/
