// Unor - 連想配列 ( 不整列コンテナ )

#ifndef __ABSTRACT_DATA_STRUCTURE_UNORDERED_AS__
#define __ABSTRACT_DATA_STRUCTURE_UNORDERED_AS__

#include "list.as"
#include "alg_iter.as"

//##############################################################################
//                Unordered
//##############################################################################
#module abdata_unor mlistKey, mlistValue

#define VAR_TEMP stt_temp@abdata_unor
;#define MAX_HASH 53

#define ctype operate_strcmp(%1,%2,%3) ( (%1) != (%3) %2 0 )
#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0

//##############################################################################
//                構築・解体
//##############################################################################

#define global Unor_new(%1)    newmod %1, abdata_unor@
#define global Unor_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit
	
	// メンバ変数の初期化
	List_new mlistKey
	List_new mlistValue
	
	return
	
//------------------------------------------------
// [i] 解体
//------------------------------------------------

//##############################################################################
//                メンバ命令・関数
//##############################################################################

//################################################
//        取得系
//################################################
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#modfunc Unor_getv_byIndex_ int i, var result, int bRemove
	List_getv mlistValue, result, i
	
	if ( bRemove ) {
		Unor_remove_byIndex_ thismod, i
	}
	return
	
#modfunc Unor_getv_ str key, var result, int bRemove
	Unor_getv_byIndex_ thismod, Unor_getIndex(thismod, key), result, bRemove
	return
	
#define global Unor_getv(%1,%2="",%3) Unor_getv_ %1, %2, %3, 0
#define global Unor_popv(%1,%2="",%3) Unor_getv_ %1, %2, %3, 1

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc Unor_get_ str key, int bRemove
	Unor_getv_ thismod, key, VAR_TEMP, bRemove
	return VAR_TEMP
	
#define global ctype Unor_get(%1,%2="") Unor_get_(%1, %2, 0)
#define global ctype Unor_pop(%1,%2="") Unor_get_(%1, %2, 1)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc Unor_dup_byIndex_ int i, var vRef
	List_dup mlistValue, i, vRef
	return
	
#modfunc Unor_dup str key, var vRef
	Unor_dup_byIndex_ thismod, Unor_getIndex( thismod, key ), vRef
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype Unor_ref(%1,%2="") VAR_TEMP@abdata_unor( Unor_ref_(%1,%2) )
#modcfunc Unor_ref_byIndex_ int i
	Unor_dup thismod, i, VAR_TEMP
	return 0
	
#modcfunc Unor_ref_ str key
	return Unor_ref_byIndex_( thismod, Unor_getIndex(thismod, key) )
	
//################################################
//        設定系
//################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global Unor_set(%1,%2="",%3) VAR_TEMP@abdata_unor = %3 : Unor_setv %1, %2, VAR_TEMP@abdata_unor

#modfunc Unor_setv str key, var vValue
	Unor_setv_byIndex_ thismod, Unor_getIndex(thismod, key), vValue
	return
	
#modfunc Unor_setv_byIndex_ int i, var vValue
	List_setv mlistValue, vValue, i
	return
	
//################################################
//        操作系
//################################################
//------------------------------------------------
// 追加
// 
// @ 既存なら失敗
//------------------------------------------------
#define global Unor_add(%1,%2="",%3=stt_zero@) VAR_TEMP@abdata_unor = %3 : Unor_addv %1, %2, VAR_TEMP@abdata_unor

#modfunc Unor_addv str key, var vValue
	Unor_addValue thismod, key, vValue
	return
	
//------------------------------------------------
// 除去
// 
// @+ 存在しない要素は除去しない
//------------------------------------------------
#modfunc Unor_remove str key,  local i
	
	i = Unor_getIndex(thismod, key, true)
	if ( i < 0 ) { return }
	
	Unor_remove_byIndex_ thismod, i
	return
	
#modfunc Unor_remove_byIndex_ int i
	List_remove mlistKey,   i
	List_remove mlistValue, i
	return
	
//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc Unor_clear
	List_clear mlistKey
	List_clear mlistValue
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc Unor_chain var mvFrom
	
	IterateBegin mvFrom, Unor
		Unor_add thismod, it, Unor_get(mvFrom, it)
	IterateEnd
	
	return
	
//------------------------------------------------
// [i] 複製
//------------------------------------------------
#modfunc Unor_copy var mvFrom
	Unor_clear thismod
	Unor_chain thismod, mvFrom
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc Unor_exchange var mv2,  local mvTemp
	Unor_new  mvTemp
	Unor_copy mvTemp,  thismod
	Unor_copy thismod, mv2
	Unor_copy mv2,     mvTemp
	Unor_delete mvTemp
	return
	
//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc Unor_iterInit var iterData
	List_iterInit mlistKey, iterData
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc Unor_iterNext var vIt, var iterData
	return List_iterNext( mlistKey, vIt, iterData )
	
//################################################
//        雑多系
//################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc Unor_size
	return List_size( mlistKey )
	
#define global Unor_n      Unor_size
#define global Unor_count  Unor_size
#define global Unor_length Unor_size

//------------------------------------------------
// キーの有無
//------------------------------------------------
#modcfunc Unor_exists str key
	return ( Unor_getIndex( thismod, key, true ) >= 0 )
	
//------------------------------------------------
// 実際の要素番号を得る
// @private
// @result:
// @	bNoAdd == false =>
// @		ある場合 => キーがある要素番号
// @		ない場合 => 新規追加し、その番号を返す。
// @		=>> 常に有効な要素番号を返す。
// @	else:
// @		ある場合 => キーがある要素番号
// @		ない場合 => 負数
//------------------------------------------------
#modcfunc Unor_getIndex@abdata_unor str key, int bNoAdd,  local idx
	
	Unor_find_ex thismod, key, idx
	if ( stat ) {
		return idx
	}
	
	// 新規に追加する
	if ( bNoAdd == false ) {
		Unor_addValue_byIndex_ thismod, idx, key, stt_zero@
		return stat
	}
	
	return -1
	
//------------------------------------------------
// 要素を追加する
// @private
// @result: 追加した要素の要素番号
// @ 整列状態を保っておく
// @ 重複したキーは無視する
//------------------------------------------------
#modfunc Unor_addValue@abdata_unor str key, var vValue,  local idx
	
	Unor_find_ex thismod, key, idx
	if ( stat ) {		// キーは既存
		return idx
	}
	
	Unor_addValue_byIndex_ thismod, idx, key, vValue
	
	return idx
	
#modfunc Unor_addValue_byIndex_@abdata_unor int idx, str key, var vValue
	List_insert  mlistKey,      key, idx
	List_insertv mlistValue, vValue, idx
	return idx
	
//------------------------------------------------
// 要素を検索する
// @private 
// @result:
// @	キーがある場合 => 真を返す。idx := 要素番号。
// @	キーがない場合 => 偽を返す。idx := 指定キーがあるべき要素番号。
//------------------------------------------------
#modfunc Unor_find_ex@abdata_unor str key, var idx,  local size, local iMin, local iMax, local nCmp, local bExists
	
	size = Unor_size(thismod)
	iMin = 0
	iMax = size
	idx  = size / 2
	
	bExists = false
	
	repeat
		if ( iMin == iMax ) {
			idx = iMin		// 一致した値
			break
		}
		
		nCmp = ( List_get(mlistKey, idx) != key )
		
		if ( nCmp == 0 ) {
			bExists = true
			break
			
		} else : if ( nCmp > 0 ) {
			iMax = idx
			
		} else /* : if ( nCmp < 0 ) */ {
			iMin = idx + 1
		}
		
		// 残りの中央にフォーカス
		idx = ( iMin + iMax ) / 2
	loop
	
	return bExists
	
//##############################################################################
//                静的メンバ命令・関数
//##############################################################################
//------------------------------------------------
// ハッシュ関数
// @private
// @result:
// @	max := MAX_HASH - 1
// @	min := 0
// @	(key == "") => 0
//------------------------------------------------
#defcfunc MakeHash@abdata_unor str _key,  local key, local hash, local c
	if ( _key == "" ) { return 0 }
	
	key = _key
	
	repeat strlen(key) - 1
		hash += wpeek(key, cnt) << ( cnt \ 4 )
	loop
	
	return abs( hash \ MAX_HASH )
	
//##############################################################################
//                デバッグ用
//##############################################################################
#ifdef _DEBUG

#define global Unor_dbglog(%1) Unor_dbglog_ %1, "%1"

#modfunc Unor_dbglog_ str _ident,  local ident
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	IterateBegin thismod, Unor
		logmes strf("%s\t: %s", it, Unor_get(thismod, it))
	IterateEnd
	
	logmes ""
	return
	
#else

#define global Unor_dbglog(%1) :

#endif
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	Unor_new    vSt
	Unor_add    vSt, "str", "Hello, world!"
	Unor_add    vSt, "int", 100
	Unor_add    vSt, "double", M_PI
	Unor_add    vSt, "日本語", "Japanese"
	Unor_add    vSt, "英語",   "English"
	Unor_add    vSt, "____"			// 要素の既定値は int(0)
	Unor_dbglog vSt
	
	Unor_set    vSt, "str", "hoge-piyo-foo-bar"
	Unor_remove vSt, "____"
	Unor_dbglog vSt
	
	stop
	
#endif

#endif

/******
	
	mlistKey, mlistValue の要素番号が同じ要素が、キーと要素の組になる。
	mlistKey は常に整列している。そのため、find_ex のような絞り込みが可能。
	
******/
