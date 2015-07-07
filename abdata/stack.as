// スタック - Stack ( FIFO & LILO )

#ifndef __ABSTRACT_DATA_STRUCTURE_STACK_AS__
#define __ABSTRACT_DATA_STRUCTURE_STACK_AS__

#include "deque.as"

//##############################################################################
//                Stack
//##############################################################################

// @abdata_stack という使い方はできない ( @abdata_deque に置換されない )
#define global abdata_stack abdata_deque

//##############################################################################
//                構築・解体
//##############################################################################

#define global Stack_new    Deque_new
#define global Stack_delete Deque_delete

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
#define global Stack_getv(%1,%2=0) Deque_getv %1, - (%2) - 1

#define global Stack_peekv Stack_getv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global ctype Stack_get(%1,%2=0) Deque_get(%1, - (%2) - 1)

#define global Stack_peek Stack_get

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global Stack_dup(%1,%2=0) Deque_dup %1, - (%2) - 1

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype Stack_ref(%1,%2=0) Deque_ref(%1, - (%2) - 1)

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
;#define global Stack_get_front  Deque_get_front
;#define global Stack_getv_front Deque_getv_front
;#define global Stack_pop_front  Deque_pop_front
;#define global Stack_popv_front Deque_popv_front
#define global Stack_get_back   Deque_get_back
#define global Stack_getv_back  Deque_getv_back
#define global Stack_pop_back   Deque_pop_back
#define global Stack_popv_back  Deque_popv_back

#define global Stack_popv Deque_popv_back
#define global Stack_pop  Deque_pop_back

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// データ置換
//------------------------------------------------
;#define global Stack_set  Deque_set
;#define global Stack_setv Deque_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
;#define global Stack_insert  Deque_insert
;#define global Stack_insertv Deque_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global Stack_double_front Deque_double_front
#define global Stack_double_back  Deque_double_back
;#define global Stack_push_front   Deque_push_front
;#define global Stack_pushv_front  Deque_pushv_front
#define global Stack_push_back    Deque_push_back
#define global Stack_pushv_back   Deque_pushv_back

#define global Stack_add         Stack_push
#define global Stack_push        Deque_push_back
#define global Stack_pushv       Deque_pushv_back

//------------------------------------------------
// 除去
//------------------------------------------------
#define global Stack_remove  Deque_remove_back

//------------------------------------------------
// 順序操作
//------------------------------------------------
;#define global Stack_move        Deque_move
;#define global Stack_swap        Deque_swap
;#define global Stack_swap_front  Deque_swap_front
#define global Stack_swap_back   Deque_swap_back
;#define global Stack_rotate      Deque_rotate
;#define global Stack_rotate_back Deque_rotate_back
;#define global Stack_reverse     Deque_reverse

#define global Stack_swap        Stack_swap_back

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global Stack_clear    Deque_clear
#define global Stack_chain    Deque_chain
#define global Stack_copy     Deque_copy
#define global Stack_exchange Deque_exchange

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global Stack_iterInit Deque_iterInit
#define global Stack_iterNext Deque_iterNext

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global Stack_size   Deque_size
#define global Stack_n      Stack_size
#define global Stack_count  Stack_size
#define global Stack_length Stack_size

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global Stack_isValid Deque_isValid

//##########################################################
//        静的メンバ命令・関数
//##########################################################

//##########################################################
//        デバッグ用
//##########################################################
//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global Stack_dbglog Deque_dbglog

#endif
