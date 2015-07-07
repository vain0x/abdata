// List - リスト

#ifndef __ABSTRACT_DATA_STRUCTURE_LIST_AS__
#define __ABSTRACT_DATA_STRUCTURE_LIST_AS__

#include "value.as"					// 簡易要素型
#include "mod_shiftArray.as"		// 配列操作モジュール
#include "mod_getnextaddindex.as"	// 次に追加される要素番号

#module abdata_list midlist, mValues, mCnt

#define mv modvar abdata_list@
#define VAR_TEMP stt_temp@abdata_list

#define ctype numrg(%1,%2,%3) (((%2) <= (%1)) && ((%1) <= (%3)))
#define true  1
#define false 0

#define ctype STR_ERR_OVER_RANGE(%1) "Error! [@abdata_list] 要素番号範囲外エラー("+ (%1) +")"

//##############################################################################
//                メンバ命令・関数
//##############################################################################

#define global List_new(%1,%2=0,%3=VAR_TEMP@abdata_list) newmod %1, abdata_list@, %2, %3
#define global List_delete(%1) delmod %1

//################################################
//        雑多系
//################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#defcfunc List_size mv
	return mCnt
	
#define global List_n List_size

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#defcfunc List_isValid mv, int i
	if ( numrg(i, 0, mCnt - 1) ) {					// 有効範囲か
		if ( varuse( mValues(midlist(i)) ) ) {		// 有効な要素番号か
			return true
		}
	}
	return false
	
//################################################
//        取得系
//################################################
//------------------------------------------------
// 値返し ( 命令形式 )
//------------------------------------------------
#modfunc List_getv var result, int i
	if ( List_isValid(thismod, i) == false ) { logmes STR_ERR_OVER_RANGE(i) : return }
	value_getv mValues( midlist(i) ), result
	return
	
//------------------------------------------------
// 値返し ( 関数形式 )
//------------------------------------------------
#defcfunc List_get mv, int i
	List_getv thismod, VAR_TEMP, i
	return VAR_TEMP
	
//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc List_dup var vRef, int i
	if ( List_isValid(thismod, i) == false ) { logmes STR_ERR_OVER_RANGE(i) : return }
	value_dup mValues( midlist(i) ), vRef
	return
	
//################################################
//        設定系
//################################################
//------------------------------------------------
// データ置換
//------------------------------------------------
#define global List_set(%1,%2,%3=0) VAR_TEMP@abdata_list = %2 : List_setv %1,VAR_TEMP@abdata_list,%3
#modfunc List_setv var vValue, int i
	if ( List_isValid(thismod, i) == false ) {
		// 新規追加
		midlist( mCnt ) = GetNextAddIndex( mValues )	// 追加されるであろう番号
		value_new mValues, vValue
		mCnt ++
		
	} else {
		// 値の変更
		value_setv mValues( midlist(i) ), vValue
	}
	return
	
//################################################
//        操作系
//################################################
//------------------------------------------------
// 挿入
//------------------------------------------------
#define global List_insert(%1,%2,%3=0) VAR_TEMP@abdata_list = %2 : List_insertv %1,VAR_TEMP@abdata_list,%3
#modfunc List_insertv var vValue, int _i,  local i, local nIdx
	i = _i
	if ( i <    0 ) { i = mCnt - i }		// 循環参照
	if ( i > mCnt ) { i = mCnt }
	
	// i 番目を空ける
	ArrayInsert midlist, i
	
	// 新規値を追加
	nIdx       = GetNextAddIndex( mValues )
	value_new mValues, vValue
	midlist(i) = nIdx
	mCnt ++
	
	return
	
//------------------------------------------------
// 最後尾への追加
//------------------------------------------------
#define global List_add(%1,%2) List_set %1, %2, List_size(%1)
#define global List_push_back List_add

//------------------------------------------------
// 除去
//------------------------------------------------
#modfunc List_remove int _i,  local i, local ivRemoved
	i = _i
	if ( i < 0 ) { i += mCnt }				// 循環参照
	
	if ( List_isValid(thismod, i) == false ) { logmes STR_ERR_OVER_RANGE(i) : return }
	ivRemoved = midlist(i)
	
	// i 番目を詰める ( 実質的除去 )
	ArrayRemove midlist, i
	midlist( length(midlist) - 1 ) = -1		// 残骸を無効要素にする
	mCnt --
	
	// mValues の方も解放
	value_delete mValues( ivRemoved )
	return
	
#define global List_pop_back(%1) List_remove %1, -1

//------------------------------------------------
// 移動
//------------------------------------------------
#modfunc List_move int from, int to
	ArrayMove midlist, from, to
	return
	
//------------------------------------------------
// 交換
//------------------------------------------------
#modfunc List_swap int pos1, int pos2
	ArraySwap midlist, pos1, pos2
	return
	
//------------------------------------------------
// 巡回
//------------------------------------------------
#modfunc List_rotate
	ArrayRotate midlist
	return
	
//################################################
//        その他
//################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc List_clear
	
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
#modfunc List_chain var mv_from
	repeat List_size( mv_from )
		List_getv   mv_from, VAR_TEMP, cnt
		List_insert thismod, VAR_TEMP, cnt
	loop                          
	return
	
//------------------------------------------------
// [i] 複製
//------------------------------------------------
#modfunc List_copy var mv_from
	List_clear thismod
	List_chain thismod, mv_from
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc List_exchange var mv2,  local mvTemp
	List_new  mvTemp
	List_copy mvTemp,  thismod
	List_copy thismod, mv2
	List_copy mv2,     mvTemp
	List_delete mvTemp
	return
	
//------------------------------------------------
// [i] 繰返子初期化
//------------------------------------------------
#modfunc List_iterInit var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] 繰返子更新
//------------------------------------------------
#defcfunc List_iterNext mv, var vIt, var iterData
	iterData ++
	if ( iterData < 0 || iterData >= List_size(thismod) ) {
		return false
	}
	List_getv thismod, vIt, iterData
	return true
	
//##############################################################################
//                静的メンバ命令・関数
//##############################################################################

//##############################################################################
//                コンストラクタ・デストラクタ
//##############################################################################
//------------------------------------------------
// [i] コンストラクタ
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
// [i] デストラクタ
//------------------------------------------------
#modterm
	List_clear thismod
	return
	
//##############################################################################
//                デバッグ用
//##############################################################################
#ifdef _DEBUG

#modfunc List_dbglog
	repeat List_size(thismod)
		logmes strf("#%2d: ", cnt) + List_get(thismod, cnt)
	loop
	return

#else

#define global List_dbglog(%1) :

#endif
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

#define List_output(%1) List_dbglog %1 : logmes ""

	List_new    list
	List_add    list, "Hello, world!"
	List_add    list, 3200
	List_add    list, 3.14159265358979
	List_output list
	List_move   list, 1, 2
	List_output list
	
	List_insert list, 999999999, 0
	List_output list
	
	stop
	
#endif

#endif

/******
	
	midlist $int[] に、mValues の要素番号である数値(ID)を代入しておく。
	swap や move、inseart などは、これを使えば簡単かつ軽快にできる。
	
******/
