// Container - 汎用コンテナ

#ifndef __ABSTRACT_DATA_STRUCTURE_CONTAINER_AS__
#define __ABSTRACT_DATA_STRUCTURE_CONTAINER_AS__

#include "value.as"					// 簡易要素型
#include "mod_shiftArray.as"		// 配列操作モジュール
#include "mod_getnextaddindex.as"	// 次に追加される要素番号

//##############################################################################
//                Container
//##############################################################################
#module abdata_container mCnt, mValues, midlist

#define VAR_TEMP stt_temp@abdata_container

#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0

#define ctype STR_ERR_OVER_RANGE(%1) "Error! [abdata コンテナ] 要素番号範囲外エラー("+ (%1) +")"

//##############################################################################
//                構築・解体
//##############################################################################

#define global Container_new(%1,%2=0,%3=VAR_TEMP@abdata_container) newmod %1, abdata_container@, %2, %3
#define global Container_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit int num, var vDefault
	
	// メンバ変数の初期化
	value_new mValues, vDefault
	midlist = 0
	mCnt    = 0
	
	// コンストラクト処理
	if ( num <= 0 ) {
		value_delete mValues(0)
		
	} else {
		// 連続確保
		repeat num
			value_new mValues, vDefault
			midlist(cnt) = cnt
			mCnt ++
		loop
	}
	
	return
	
//------------------------------------------------
// 構築者
//------------------------------------------------
;#deffunc CreateContainer array mvArr_Container
;	Container_new mvArr_Container
;	return
	
//------------------------------------------------
// [i] 解体
//------------------------------------------------
#modterm
;	Container_clear thismod
	return
	
//------------------------------------------------
// 解体者
//------------------------------------------------
;#deffunc DeleteContainer var mvContainer
;	Container_delete mvContainer
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
#modfunc Container_getv_ var result, int _i, int bRemove,  local i
	
	i = Container_getRealIndex(thismod, _i)
	
	value_getv mValues( midlist(i) ), result
	
	if ( bRemove ) {
		Container_remove thismod, i
	}
	return
	
#define global Container_getv(%1,%2,%3=0) Container_getv_ %1, %2, %3, 0
#define global Container_popv(%1,%2,%3=0) Container_getv_ %1, %2, %3, 1

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc Container_get_ int i, int bRemove
	Container_getv_ thismod, VAR_TEMP, i, bRemove
	return VAR_TEMP
	
#define global ctype Container_get(%1,%2=0) Container_get_(%1, %2, 0)
#define global ctype Container_pop(%1,%2=0) Container_get_(%1, %2, 1)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc Container_dup var vRef, int i
	value_dup mValues( midlist( Container_getRealIndex(thismod, i) ) ), vRef
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype Container_ref(%1,%2=0) VAR_TEMP@abdata_container( Container_ref_(%1,%2) )
#modcfunc Container_ref_ int i
	Container_dup thismod, VAR_TEMP, i
	return 0
	
//------------------------------------------------
// 先頭・末尾の値の取得
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global ctype Container_get_front(%1)     Container_get(%1, 0)
#define global ctype Container_get_back(%1)      Container_get(%1, -1)
#define global       Container_getv_front(%1,%2) Container_getv %1, %2, 0
#define global       Container_getv_back(%1,%2)  Container_getv %1, %2, -1
#define global ctype Container_pop_front(%1)     Container_pop(%1, 0)
#define global ctype Container_pop_back(%1)      Container_pop(%1, -1)
#define global       Container_popv_front(%1,%2) Container_popv %1, %2, 0
#define global       Container_popv_back(%1,%2)  Container_popv %1, %2, -1

//################################################
//        設定系
//################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global Container_set(%1,%2,%3=0) VAR_TEMP@abdata_container = %2 : Container_setv %1, VAR_TEMP@abdata_container, %3
#modfunc Container_setv var vValue, int i,  local iv
	
	iv = midlist( Container_getRealIndex(thismod, i) )
	
	// 適切に型を変換する
	value_changeVartype mValues(iv), vartype(vValue)
	
	value_setv mValues( iv ), vValue
	
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
#define global Container_insert(%1,%2,%3=0) VAR_TEMP@abdata_container = %2 : Container_insertv %1, VAR_TEMP@abdata_container, %3
#modfunc Container_insertv var vValue, int _i,  local i, local id
	
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
;	id         = GetNextAddIndex( mValues )
	value_new mValues, vValue
	midlist(i) = stat	;id
	mCnt ++
	
	return
	
//------------------------------------------------
// 要素の倍化
//------------------------------------------------
#modfunc Container_double int _i,  local i, local temp
	i = Container_getRealIndex( thismod, _i )
	
	Container_getv    thismod, temp, i
	Container_insertv thismod, temp, i
	return
	
//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global Container_double_front(%1)   Container_double  %1, 0
#define global Container_double_back(%1)    Container_double  %1, -1
#define global Container_push_front(%1,%2)  Container_insert  %1, %2, 0
#define global Container_pushv_front(%1,%2) Container_insertv %1, %2, 0
#define global Container_push_back(%1,%2)   Container_insert  %1, %2, Container_size(%1)
#define global Container_pushv_back(%1,%2)  Container_insertv %1, %2, Container_size(%1)
#define global Container_push               Container_push_back
#define global Container_pushv              Container_pushv_back
#define global Container_add                Container_push_back

//------------------------------------------------
// 除去
//------------------------------------------------
#modfunc Container_remove int _i,  local i, local ivRemoved
	
	i         = Container_getRealIndex(thismod, _i)
	ivRemoved = midlist(i)
	
	// i 番目を詰める ( 実質的除去 )
	ArrayRemove midlist, i
	midlist( length(midlist) - 1 ) = -1		// 残骸を無効要素にする
	mCnt --
	
	// mValues の方も解放
	value_delete mValues( ivRemoved )
	return
	
#define global Container_remove_front(%1) Container_remove %1, 0
#define global Container_remove_back(%1)  Container_remove %1, -1

//------------------------------------------------
// 移動
//------------------------------------------------
#modfunc Container_move int iSrc, int iDst
	if ( Container_size(thismod) < 2 ) {
		return
	}
	
	ArrayMove midlist, Container_getRealIndex(thismod, iSrc), Container_getRealIndex(thismod, iDst)
	return
	
//------------------------------------------------
// 交換
//------------------------------------------------
#modfunc Container_swap int iPos1, int iPos2
	if ( Container_size(thismod) < 2 ) {
		return
	}
	
	ArraySwap midlist, Container_getRealIndex(thismod, iPos1), Container_getRealIndex(thismod, iPos2)
	return
	
#define global Container_swap_front(%1) Container_swap %1,  0,  1
#define global Container_swap_back(%1)  Container_swap %1, -2, -1

//------------------------------------------------
// 巡回
//------------------------------------------------
#modfunc Container_rotate int step
	ArrayRotate midlist, step
	return
	
//------------------------------------------------
// 巡回 ( 逆回転 )
//------------------------------------------------
#modfunc Container_rotate_back
	ArrayRotateBack midlist
	return
	
//------------------------------------------------
// 反転
//------------------------------------------------
#modfunc Container_reverse
	ArrayReverse midlist, Container_size(thismod)
	return
	
//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc Container_clear
	
	// 全要素を解放する
	foreach mValues
		value_delete mValues(cnt)
	loop
	
	// 番号リストを初期化
	dim midlist
	mCnt = 0
	
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc Container_chain var mvFrom
	repeat Container_size( mvFrom )
		Container_getv   mvFrom,  VAR_TEMP, cnt
		Container_insert thismod, VAR_TEMP, cnt
	loop
	return
	
//------------------------------------------------
// [i] 複製
//------------------------------------------------
#modfunc Container_copy var mvFrom
	Container_clear thismod
	Container_chain thismod, mvFrom
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc Container_exchange var mv2,  local mvTemp
	Container_new  mvTemp
	Container_copy mvTemp,  thismod
	Container_copy thismod, mv2
	Container_copy mv2,     mvTemp
	Container_delete mvTemp
	return
	
//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc Container_iterInit var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc Container_iterNext var vIt, var iterData
	iterData ++
	
	if ( Container_isValid(thismod, iterData) == false ) {
		return false
	}
	
	Container_getv thismod, vIt, iterData
	return true
	
//################################################
//        雑多系
//################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc Container_size
	return mCnt
	
#define global Container_n      Container_size
#define global Container_count  Container_size
#define global Container_length Container_size

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#modcfunc Container_isValid int i
	if ( numrg(i, 0, mCnt - 1) ) {					// 有効範囲か
		if ( varuse( mValues(midlist(i)) ) ) {		// 有効な要素番号か
			return true
		}
	}
	return false
	
//------------------------------------------------
// 実際の要素番号を得る
// @private
//------------------------------------------------
#modcfunc Container_getRealIndex@abdata_container int _i,  local i
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
	
//##############################################################################
//                静的メンバ命令・関数
//##############################################################################

//##############################################################################
//                デバッグ用
//##############################################################################
#ifdef _DEBUG

#define global Container_dbglog(%1) Container_dbglog_ %1, "%1"

#modfunc Container_dbglog_ str _ident,  local ident
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	repeat Container_size(thismod)
		logmes strf("#%2d: ", cnt) + Container_get(thismod, cnt)
	loop
	
	logmes ""
	return
	
#else

#define global Container_dbglog(%1) :

#endif
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	Container_new    vSt
	Container_add    vSt, "Hello, world!"
	Container_add    vSt, 100
	Container_add    vSt, M_PI
	Container_dbglog vSt
	Container_move   vSt, 1, 2
	Container_dbglog vSt
	
	Container_insert vSt, 0x7FFFFFFF, 0
	Container_dbglog vSt
	
	Container_reverse vSt
	Container_dbglog  vSt
	
	stop
	
#endif

#endif

/******
	
	midlist $array[$int] に、mValues の要素番号である数値(ID)を代入しておく。
	※実際のデータは abdata_value の配列である mValues メンバに保存される。
	swap や move、inseart などは、これを使えば簡単かつ軽快にできる。
	
******/
