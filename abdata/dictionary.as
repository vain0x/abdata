// 辞書 - Dictionary

#ifndef IG_ABSTRACT_DATA_STRUCTURE_DICTIONARY_AS
#define IG_ABSTRACT_DATA_STRUCTURE_DICTIONARY_AS

// 不完全
// @ 参照が作れない。素直にハッシュ法で構築した方がいいかも。

#include "alg_iter.as"

//##############################################################################
//                  Dictionary
//##############################################################################
#module abdata_dictionary mdict

#define VAR_TEMP stt_temp@abdata_dictionary

#define true  1
#define false 0

#uselib "oleaut32.dll"
#func   SafeArrayGetElement@abdata_dictionary "SafeArrayGetElement" int, int, int

// @ Scripting.Dictionary のラッパ

//##########################################################
//        構築・解体
//##########################################################
#define global dict_new(%1)    newmod %1, abdata_dictionary@
#define global dict_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit
	newcom mdict, "Scripting.Dictionary"
	
	// プロパティ
	mdict("CompareMode") = 0		// 完全一致
	return
	
//------------------------------------------------
// [i] 解体
//------------------------------------------------
#modterm
	delcom mdict
	return
	
//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#modfunc dict_getv var vResult, str key
	
	if ( dict_exists(thismod, key) == false ) {
		vResult = 0
		
	} else {
		vResult = mdict("Item", key)
	}
	return
	
//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc dict_get str key
	dict_getv thismod, VAR_TEMP, key
	return VAR_TEMP
	
/*
//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc dict_dup var vResult, str key
	item = 
	dupptr vResult, mdict("Item", key), mdict("Item", key)
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype dict_ref(%1,%2) VAR_TEMP@abdata_dictionary( dict_ref_(%1, %2) )
#modcfunc dict_ref_ str key
	dict_dup thismod, VAR_TEMP, key
	return 0
//*/
	
//------------------------------------------------
// 型の取得
//------------------------------------------------
#modcfunc dict_vartype str key
	dict_getv thismod, VAR_TEMP, key
	return vartype( VAR_TEMP )
	
//------------------------------------------------
// キーの有無の取得
//------------------------------------------------
#modcfunc dict_exists str key
	return mdict("Exists", key)
	
//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// 値の設定
// 
// @ 未定義のキーなら追加する
// @ 引数の順序が他と違うので注意
//------------------------------------------------
#define global dict_set(%1,%2,%3) VAR_TEMP@abdata_dictionary = %3 : dict_setv %1, %2, VAR_TEMP@abdata_dictionary
#modfunc dict_setv str key, var value
	// 既存 => 変更
	if ( dict_exists(thismod, key) ) {
		mdict("Item", key) = value
		
	// 新規 => 追加
	} else {
		mdict->"Add" key, value
	}
	return
	
#define global dict_add  dict_set
#define global dict_addv dict_setv

//------------------------------------------------
// 要素の除去
//------------------------------------------------
#modfunc dict_remove str key
	mdict->"Remove" key
	return
	
//------------------------------------------------
// 
//------------------------------------------------

//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        統一関数
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc dict_size
	return mdict("Count")
	
#define global dict_count  dict_size
#define global dict_length dict_size

//------------------------------------------------
// [i] 消去
//------------------------------------------------
#modfunc dict_clear
	mdict->"RemoveAll"
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc dict_chain var mvFrom,  local it
	IterateBegin mvFrom, dict, it
		dict_add thismod, it, dict_get( mvFrom, it )
	IterateEnd
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc dict_copy var mvFrom
	dict_clear thismod
	dict_chain thismod, mvFrom
	return
	
//------------------------------------------------
// [i] コンテナ交換
//------------------------------------------------
#modfunc dict_exchange var mv2,  local mvTemp
	dict_new  mvTemp
	dict_copy mvTemp,  thismod
	dict_copy thismod, mv2
	dict_copy mv2,     mvTemp
	dict_delete mvTemp
	return
	
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc dict_iterInit var iterData
;	logmes "[Warning] dictionary では algorithm 'iterate' に対応していません。"
	iterData = -1
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc dict_iterNext var vIt, var iterData,  local keylist, local key
	iterData ++
	
	if ( iterData >= dict_size(thismod) ) {
		return false
	}
	
	// キーの配列
	keylist = mdict("Keys")
	
	// 要素の取得
	dimtype key, vartype("variant")		// 取得用 variant
	
	SafeArrayGetElement keylist("arrayptr"), varptr(iterData), varptr(key)
	
	vIt = key("value")
	
	return true
	
//------------------------------------------------
// 
//------------------------------------------------
//##########################################################
//        
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

#global

//##############################################################################
//                  サンプル・スクリプト
//##############################################################################
#if 0

	dict_new dict
	dict_add dict, "int", "整数値"
	
	mes dict_get(dict, "int")
	
	// 反復子：it はキー
	IterateBegin dict, dict
		mes ""+ it +"\t=> "+ dict_get(dict, it)
	IterateEnd
	
	stop
	
#endif

#endif
