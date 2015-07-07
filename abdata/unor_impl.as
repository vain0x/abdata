// unor - 連想配列 ( 不整列コンテナ ) (実装)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_UNORDERED_IMPL_AS
#define IG_ABSTRACT_DATA_STRUCTURE_UNORDERED_IMPL_AS

#include "list.as"
#include "alg_iter.as"
#include "mod_pvalptr.as"

//##############################################################################
//                abdata::unordered
//##############################################################################
#module abdata_unor_impl mlistKey, mlistValue

#define global unorInsts st_allinsts@abdata_unor_impl
#define global unorNull  st_unorNull@abdata_unor_impl 

#define ctype ARG_TEMP(%1) st_temp_%1_arg@abdata_unor_impl
;#define MAX_HASH 53

#define ctype operate_strcmp(%1,%2,%3) ( (%1) != (%3) %2 0 )
#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0

// @ mlistKey   := key のリスト。この添字は mlistValue と共通する。
// @ mlistValue := val のリスト。この添字は mlistKey   と共通する。
// @ unor の要素番号 := mlistKey, mlistValue で共通する添字。要素を追加するごとに変化することも考えられる。
// @	内部では、_getIndex() で取得する。
// @ key := 要素を特定するための、特定の文字列。str 型に限る。同じ文字列のキーは、1つの Unor に、高々1つ存在する。

//##############################################################################
//                構築・解体
//##############################################################################
#define global unorImpl_new(%1)    newmod %1, abdata_unor_impl@
#define global unorImpl_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit
	// メンバ変数の初期化
	list_new mlistKey
	list_new mlistValue
	
	return getaptr(thismod)
	
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
#modfunc unorImpl_getv_byIndex_ int i, var result, int bRemove
	list_getv mlistValue, result, i
	
	if ( bRemove ) {
		unorImpl_remove_byIndex_ thismod, i
	}
	return
	
#modfunc unorImpl_getv_ str key, var result, int bRemove
	unorImpl_getv_byIndex_ thismod, unorImpl_getIndex(thismod, key), result, bRemove
	return
	
#define global unorImpl_getv(%1,%2="",%3) unorImpl_getv_ %1, %2, %3, 0
#define global unorImpl_popv(%1,%2="",%3) unorImpl_getv_ %1, %2, %3, 1

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc unorImpl_get_ str key, int bRemove,  local tmp
	unorImpl_getv_ thismod, key, tmp, bRemove
	return tmp
	
#define global ctype unorImpl_get(%1,%2="") unorImpl_get_(%1, %2, 0)
#define global ctype unorImpl_pop(%1,%2="") unorImpl_get_(%1, %2, 1)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc unorImpl_clone_byIndex_ int i, var vRef
	list_clone mlistValue, i, vRef
	return
	
#modfunc unorImpl_clone str key, var vRef
	unorImpl_clone_byIndex_ thismod, unorImpl_getIndex( thismod, key ), vRef
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype unorImpl_ref(%1,%2="") ARG_TEMP@abdata_unor_impl(ref)( unorImpl_ref_(%1,%2) )
#modcfunc unorImpl_ref_byIndex_ int i
	unorImpl_clone thismod, i, ARG_TEMP@abdata_unor_impl(ref)
	return 0
	
#modcfunc unorImpl_ref_ str key
	return unorImpl_ref_byIndex_( thismod, unorImpl_getIndex(thismod, key) )
	
//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc unorImpl_vartype_byIndex_ int i
	return list_vartype( mlistValue, i )
	
#define global ctype unorImpl_vartype(%1,%2="") unorImpl_vartype_(%1, %2)
#modcfunc unorImpl_vartype_ str key
	return unorImpl_vartype_byIndex_( thismod, unorImpl_getIndex(thismod, key) )
	
//################################################
//        設定系
//################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global unorImpl_set(%1,%2="",%3) ARG_TEMP@abdata_unor_impl(set) = %3 : unorImpl_setv %1, %2, ARG_TEMP@abdata_unor_impl(set)

#modfunc unorImpl_setv str key, var vValue
	unorImpl_setv_byIndex_ thismod, unorImpl_getIndex(thismod, key), vValue
	return
	
#modfunc unorImpl_setv_byIndex_ int i, var vValue
	list_setv mlistValue, vValue, i
	return
	
//################################################
//        操作系
//################################################
//------------------------------------------------
// 追加
// 
// @ 既存なら失敗
//------------------------------------------------
#define global unorImpl_add(%1,%2="",%3=stt_zero@) ARG_TEMP@abdata_unor_impl(add) = %3 : unorImpl_addv %1, %2, ARG_TEMP@abdata_unor_impl(add)

#modfunc unorImpl_addv str key, var vValue
	unorImpl_addValue thismod, key, vValue
	return
	
//------------------------------------------------
// 除去
// 
// @+ 存在しない要素は除去しない
//------------------------------------------------
#modfunc unorImpl_remove str key,  local i
	
	i = unorImpl_getIndex(thismod, key, true)
	if ( i < 0 ) { return }
	
	unorImpl_remove_byIndex_ thismod, i
	return
	
#modfunc unorImpl_remove_byIndex_ int i
	list_remove mlistKey,   i
	list_remove mlistValue, i
	return
	
//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc unorImpl_clear
	list_clear mlistKey
	list_clear mlistValue
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc unorImpl_chain var src,  local it
	
	IterateBegin src, unorImpl, it
		unorImpl_add thismod, it, unorImpl_get(src, it)
	IterateEnd
	
	return
	
//------------------------------------------------
// [i] 複製
//------------------------------------------------
#modfunc unorImpl_copy var src
	unorImpl_clear thismod
	unorImpl_chain thismod, src
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc unorImpl_exchange var obj,  local tmp
	unorImpl_new  tmp
	unorImpl_copy tmp, thismod
	unorImpl_copy thismod, obj
	unorImpl_copy obj, tmp
	unorImpl_delete tmp
	return
	
//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc unorImpl_iterInit var iterData
	list_iterInit mlistKey, iterData
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc unorImpl_iterNext var vIt, var iterData
	return list_iterNext( mlistKey, vIt, iterData )
	
//################################################
//        雑多系
//################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc unorImpl_size
	return list_size( mlistKey )
	
#define global unorImpl_count  unorImpl_size
#define global unorImpl_length unorImpl_size
#define global ctype unorImpl_empty(%1) ( unorImpl_size(%1) == 0 )

//------------------------------------------------
// キーの有無
//------------------------------------------------
#modcfunc unorImpl_exists str key
	return ( unorImpl_getIndex( thismod, key, true ) >= 0 )
	
//------------------------------------------------
// 実際の要素番号を得る
// @private
// @result:
// @	?(bNoAdd == false) =>
// @		ある場合 => キーがある要素番号
// @		ない場合 => 新規追加し、その番号を返す。
// @		=>> 常に有効な要素番号を返す。
// @	else =>
// @		ある場合 => キーがある要素番号
// @		ない場合 => 負数
//------------------------------------------------
#modcfunc unorImpl_getIndex@abdata_unor_impl str key, int bNoAdd,  local idx
	
	unorImpl_find_ex thismod, key, idx
	if ( stat ) {
		return idx
	}
	
	// 新規に追加する
	if ( bNoAdd == false ) {
		unorImpl_addValue_byIndex_ thismod, idx, key, stt_zero@
		return stat
	}
	
	return -1
	
//------------------------------------------------
// 要素を追加する
// @private
// @result: 追加した要素の要素番号
// @ 整列状態を保っておく。
// @ 重複したキーは無視する。
//------------------------------------------------
#modfunc unorImpl_addValue@abdata_unor_impl str key, var vValue,  local idx
	
	unorImpl_find_ex thismod, key, idx
	if ( stat ) {		// キーは既存
		return idx
	}
	
	unorImpl_addValue_byIndex_ thismod, idx, key, vValue
	
	return idx
	
#modfunc unorImpl_addValue_byIndex_@abdata_unor_impl int idx, str key, var vValue
	list_insert  mlistKey,      key, idx
	list_insertv mlistValue, vValue, idx
	return idx
	
//------------------------------------------------
// 要素を検索する
// @private
// @algorithm : 二分探索(binary search)
// @result :
// @	キーがある場合 => 真を返す。idx := 要素番号。
// @	キーがない場合 => 偽を返す。idx := 指定キーがあるべき要素番号。
//------------------------------------------------
#modfunc unorImpl_find_ex@abdata_unor_impl str key, var idx,  local size, local iMin, local iMax, local nCmp, local bExists
	
	size = unorImpl_size(thismod)
	iMin = 0
	iMax = size
	idx  = size / 2
	
	bExists = false
	
	repeat
		if ( iMin == iMax ) {
			idx = iMin		// 一致した値
			break
		}
		
		nCmp = ( list_get(mlistKey, idx) != key )
		
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
/*
//------------------------------------------------
// ハッシュ関数
// @private
// @result:
// @	max := MAX_HASH - 1
// @	min := 0
// @	(key == "") => 0
//------------------------------------------------
#defcfunc MakeHash@abdata_unor_impl str _key,  local key, local hash, local c
	if ( _key == "" ) { return 0 }
	
	key = _key
	
	repeat strlen(key) - 1
		hash += wpeek(key, cnt) << ( cnt \ 4 )
	loop
	
	return abs( hash \ MAX_HASH )
//*/
	
//##############################################################################
//                デバッグ用
//##############################################################################
#ifdef _DEBUG

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global unorImpl_dbglog(%1) unorImpl_dbglog_ %1, "%1"

#modfunc unorImpl_dbglog_ str _ident,  local ident, local it
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	IterateBegin thismod, unorImpl, it
		logmes strf("%s\t: %s", it, unorImpl_get(thismod, it))
	IterateEnd
	
	logmes ""
	return
	
#else

#define global unorImpl_dbglog(%1) :

#endif
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	unorImpl_new    vSt
	unorImpl_add    vSt, "str", "Hello, world!"
	unorImpl_add    vSt, "int", 100
	unorImpl_add    vSt, "double", M_PI
	unorImpl_add    vSt, "日本語", "Japanese"
	unorImpl_add    vSt, "英語",   "English"
	unorImpl_add    vSt, "____"			// 要素の既定値は int(0)
	unorImpl_dbglog vSt
	
	unorImpl_set    vSt, "str", "hoge-piyo-foo-bar"
	unorImpl_remove vSt, "____"
	unorImpl_dbglog vSt
	
	stop
	
#endif

#endif

/******
	
	mlistKey, mlistValue の要素番号が同じ要素が、キーと要素の組になる。
	mlistKey は常に整列している。そのため、find_ex のような二分探索による絞り込みが可能。
	
******/
