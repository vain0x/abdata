// queue - キュー ( FILO & LIFO )

#ifndef IG_ABSTRACT_DATA_STRUCTURE_queue_AS
#define IG_ABSTRACT_DATA_STRUCTURE_queue_AS

#include "deque.as"

//##############################################################################
//                queue
//##############################################################################

// @abdata_queue という使い方はできない ( @abdata_deque に置換されない )
#define global abdata_queue abdata_deque

//##############################################################################
//                構築・解体
//##############################################################################

#define global queue_new    deque_new
#define global queue_delete deque_delete

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
#define global queue_getv deque_getv

#define global queue_peekv queue_getv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global queue_get deque_get

#define global queue_peek queue_get

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global queue_clone deque_clone

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global queue_ref deque_ref

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global queue_get_front  deque_get_front
#define global queue_getv_front deque_getv_front
#define global queue_pop_front  deque_pop_front
#define global queue_popv_front deque_popv_front
;#define global queue_get_back   deque_get_back
;#define global queue_getv_back  deque_getv_back
;#define global queue_pop_back   deque_pop_back
;#define global queue_popv_back  deque_popv_back

#define global queue_popv deque_popv_front
#define global queue_pop  deque_pop_front

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global queue_vartype       Container_vartype_front
;#define global queue_vartype_front Container_vartype_front
;#define global queue_vartype_back  Container_vartype_back

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// データ置換
//------------------------------------------------
#define global queue_set  deque_set
#define global queue_setv deque_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
#define global queue_insert  deque_insert
#define global queue_insertv deque_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global queue_double_front deque_double_front
#define global queue_double_back  deque_double_back
;#define global queue_push_front   deque_push_front
;#define global queue_pushv_front  deque_pushv_front
#define global queue_push_back    deque_push_back
#define global queue_pushv_back   deque_pushv_back

#define global queue_add         queue_push
#define global queue_push        deque_push_back
#define global queue_pushv       deque_pushv_back

//------------------------------------------------
// 除去
//------------------------------------------------
#define global queue_remove  deque_remove_front

//------------------------------------------------
// 順序操作
//------------------------------------------------
;#define global queue_move        deque_move
;#define global queue_swap        deque_swap
;#define global queue_swap_front  deque_swap_front
;#define global queue_swap_back   deque_swap_back
;#define global queue_rotate      deque_rotate
;#define global queue_rotate_back deque_rotate_back
;#define global queue_reverse     deque_reverse

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global queue_clear    deque_clear
#define global queue_chain    deque_chain
#define global queue_copy     deque_copy
#define global queue_exchange deque_exchange

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global queue_iterInit deque_iterInit
#define global queue_iterNext deque_iterNext

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global queue_size   deque_size
#define global queue_count  queue_size
#define global queue_length queue_size
#define global queue_empty  deque_empty

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global queue_isValid deque_isValid

//##########################################################
//        静的メンバ命令・関数
//##########################################################

//##########################################################
//        デバッグ用
//##########################################################
//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global queue_dbglog deque_dbglog

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	queue_new q
//	mes queue_vartype(q)		// 要素がないので範囲外エラー
	
	repeat 2
		mes "loop "+ cnt
		
		repeat 8
			queue_push q, (1 << cnt)
		loop
		
		repeat queue_size(q)
			mes strf("\t0x%04X", queue_pop(q))
		loop
	loop
	
//	queue_delete q
	stop
	
#endif

#endif
