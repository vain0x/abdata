// unor - 連想配列 ( 不整列コンテナ ) (ラッパ)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_UNORDERED_WRAPPER_AS
#define IG_ABSTRACT_DATA_STRUCTURE_UNORDERED_WRAPPER_AS

#include "unor_impl.as"

//##############################################################################
//                abdata::unordered
//##############################################################################

//##############################################################################
//                構築・解体
//##############################################################################
#define global unor_new(%1)    unorImpl_new    unorInsts : %1 = stat
#define global unor_delete(%1) unorImpl_delete unorInsts(%1)

//------------------------------------------------
// 構築者
//------------------------------------------------
#module

#defcfunc new_unor  local newOne
	unor_new newOne
	return   newOne
	
#global

//------------------------------------------------
// [i] 構築
//------------------------------------------------

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
;#define global unor_getv_byIndex_(%1,%2,%3,%4) unorImpl_getv_byIndex_ unorInsts(%1), %2, %3, %4
;#define global unor_getv_(%1,%2,%3,%4) unorImpl_getv_ unorInsts(%1), %2, %3, %4
#define global unor_getv(%1,%2="",%3) unorImpl_getv unorInsts(%1), %2, %3
#define global unor_popv(%1,%2="",%3) unorImpl_popv unorInsts(%1), %2, %3

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
;#define global unor_get_(%1,%2,%3) unorImpl_get_(unorInsts(%1), %2, %3)
#define global ctype unor_get(%1,%2="") unorImpl_get(unorInsts(%1), %2)
#define global ctype unor_pop(%1,%2="") unorImpl_pop(unorInsts(%1), %2)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
;#define global unor_clone_byIndex_(%1,%2,%3) unorImpl_clone_byIndex_ unorInsts(%1), %2, %3
#define global unor_clone(%1,%2="",%3) unorImpl_clone unorInsts(%1), %2, %3

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype unor_ref(%1,%2="") unorImpl_ref(unorInsts(%1), %2)

;#define global ctype unor_ref_byIndex_(%1,%2) unorImpl_ref_byIndex_(unorInsts(%1), %2)
;#define global ctype unor_ref_(%1,%2="")      unorImpl_ref_(unorInsts(%1), %2)

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
;#define global unor_vartype_byIndex_(%1,%2) unorImpl_vartype_byIndex_(unorInsts(%1), %2)
#define global ctype unor_vartype(%1,%2="") unorImpl_vartype(unorInsts(%1), %2)
;#define global ctype unor_vartype_(%1,%2) unorImpl_vartype_(unorInsts(%1), %2)

//################################################
//        設定系
//################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global unor_set(%1,%2="",%3)  unorImpl_set  unorInsts(%1), %2, %3
#define global unor_setv(%1,%2="",%3) unorImpl_setv unorInsts(%1), %2, %3
;#define global unor_setv_byIndex_(%1,%2,%3) unorImpl_setv_byIndex_ unorInsts(%1), %2, %3

//################################################
//        操作系
//################################################
//------------------------------------------------
// 追加
// 
// @ 既存なら失敗
//------------------------------------------------
#define global unor_add(%1,%2="",%3=stt_zero@) unorImpl_add unorInsts(%1), %2, %3
#define global unor_addv(%1,%2,%3) unorImpl_addv unorInsts(%1), %2, %3

//------------------------------------------------
// 除去
// 
// @+ 存在しない要素は除去しない
//------------------------------------------------
#define global unor_remove(%1,%2) unorImpl_remove unorInsts(%1), %2
;#define global unor_remove_byIndex_(%1,%2) unorImpl_remove_byIndex_ unorInsts(%1), %2

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#define global unor_clear(%1) unorImpl_clear unorInsts(%1)

//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global unor_chain(%1,%2) unorImpl_chain unorInsts(%1), unorInsts(%2)

//------------------------------------------------
// [i] 複製
//------------------------------------------------
#define global unor_copy(%1,%2) unorImpl_copy unorInsts(%1), unorInsts(%2)

//------------------------------------------------
// [i] 交換
//------------------------------------------------
#define global unor_exchange(%1,%2) unorImpl_exchange unorInsts(%1), unorInsts(%2)

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#define global unor_iterInit(%1,%2) unorImpl_iterInit unorInsts(%1), %2

//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#define global ctype unor_iterNext(%1,%2,%3) unorImpl_iterNext( unorInsts(%1), %2, %3 )

//##########################################################
//        雑多系
//#########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype unor_size(%1)  unorImpl_size(unorInsts(%1))
#define global ctype unor_empty(%1) unorImpl_empty(unorInsts(%1))
#define global unor_count  unor_size
#define global unor_length unor_size

//------------------------------------------------
// キーの有無
//------------------------------------------------
#define global ctype unor_exists(%1,%2) unorImpl_exists(unorInsts(%1), %2)

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
;#define global ctype unor_getIndex(%1,%2,%3=0) unorImpl_getIndex@abdata_unor_impl(unorInsts(%1), %2, %3)

//------------------------------------------------
// 要素を追加する
// @private
// @result: 追加した要素の要素番号
// @ 整列状態を保っておく。
// @ 重複したキーは無視する。
//------------------------------------------------
;#define global unor_addValue(%1,%2,%3) unorImpl_addValue@abdata_unor_impl unorInsts(%1), %2, %3
;#define global unor_addValue_byIndex_(%1,%2,%3,%4) unorImpl_addValue_byIndex_@abdata_unor_impl unorInsts(%1), %2, %3, %4

//------------------------------------------------
// 要素を検索する
// @private
// @algorithm : 二分探索(binary search)
// @result :
// @	キーがある場合 => 真を返す。idx := 要素番号。
// @	キーがない場合 => 偽を返す。idx := 指定キーがあるべき要素番号。
//------------------------------------------------
#define global ctype unor_find_ex(%1,%2,%3) unorImpl_find_ex@abdata_unor_impl(unorInsts(%1), %2, %3)

//##############################################################################
//                静的メンバ命令・関数
//##############################################################################
/*
//------------------------------------------------
// ハッシュ関数
//------------------------------------------------
#defcfunc MakeHash@abdata_unor_impl str _key,  local key, local hash, local c

//*/
	
//##############################################################################
//                デバッグ用
//##############################################################################
//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global unor_dbglog(%1) unorImpl_dbglog_ unorInsts(%1), "%1"

	unor_new unorNull
	
//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	unor_new    vSt
;	unor_new    vSt
	unor_add    vSt, "str", "Hello, world!"
	unor_add    vSt, "int", 100
	unor_add    vSt, "double", M_PI
	unor_add    vSt, "日本語", "Japanese"
	unor_add    vSt, "英語",   "English"
	unor_add    vSt, "____"			// 要素の既定値は int(0)
	unor_dbglog vSt
	
	unor_set    vSt, "str", "hoge-piyo-foo-bar"
	unor_remove vSt, "____"
	unor_dbglog vSt
	
	stop
	
#endif

#endif
