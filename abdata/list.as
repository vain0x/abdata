// List - リスト

#ifndef __ABSTRACT_DATA_STRUCTURE_LIST_AS__
#define __ABSTRACT_DATA_STRUCTURE_LIST_AS__

#include "container.as"

//##############################################################################
//                List
//##############################################################################

// @abdata_list という使い方はできない ( @abdata_container に置換されない )
#define global abdata_list abdata_container

//##############################################################################
//                構築・解体
//##############################################################################

#define global List_new    Container_new
#define global List_delete Container_delete

//------------------------------------------------
// [i] 構築
//------------------------------------------------
//------------------------------------------------
// [i] 解体
//------------------------------------------------

//##############################################################################
//                メンバ命令・関数
//##############################################################################

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global List_getv Container_getv
#define global List_popv Container_popv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global List_get Container_get
#define global List_pop Container_pop

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global List_dup Container_dup

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global List_ref Container_ref

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
;#define global List_get_front  Container_get_front
;#define global List_get_back   Container_get_back
;#define global List_getv_front Container_getv_front
;#define global List_getv_back  Container_getv_back
;#define global List_pop_front  Container_pop_front
;#define global List_pop_back   Container_pop_back
;#define global List_popv_front Container_popv_front
;#define global List_popv_back  Container_popv_back

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// データ置換
//------------------------------------------------
#define global List_set  Container_set
#define global List_setv Container_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
#define global List_insert  Container_insert
#define global List_insertv Container_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
;#define global List_push_front  Container_push_front
;#define global List_push_back   Container_push_back
;#define global List_pushv_front Container_pushv_front
;#define global List_pushv_back  Container_pushv_back
;#define global List_push        Container_push
;#define global List_pushv       Container_pushv
#define global List_add         Container_add

//------------------------------------------------
// 除去
//------------------------------------------------
#define global List_remove       Container_remove
;#define global List_remove_front Container_remove_front
;#define global List_remove_back  Container_remove_back

//------------------------------------------------
// 順序操作
//------------------------------------------------
#define global List_move        Container_move
#define global List_swap        Container_swap
#define global List_rotate      Container_rotate
#define global List_rotate_back Container_rotate_back
#define global List_reverse     Container_reverse

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global List_clear    Container_clear
#define global List_chain    Container_chain
#define global List_copy     Container_copy
#define global List_exchange Container_exchange

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global List_iterInit Container_iterInit
#define global List_iterNext Container_iterNext

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global List_size   Container_size
#define global List_count  List_size
#define global List_length List_size
#define global List_n      List_size

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global List_isValid Container_isValid

//##########################################################
//        静的メンバ命令・関数
//##########################################################

//##########################################################
//        デバッグ用
//##########################################################
//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global List_dbglog Container_dbglog

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	List_new    list
	List_add    list, "Hello, world!"
	List_add    list, 100
	List_add    list, M_PI
	List_dbglog list
	
	List_move   list, 1, 2
	List_dbglog list
	
	List_insert list, 0x7FFFFFFF, 0
	List_dbglog list
	
	List_reverse list
	List_dbglog  list
	
	stop
	
#endif

#endif
