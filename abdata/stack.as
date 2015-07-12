// スタック - stack ( FIFO & LILO )

#ifndef IG_ABDATA_STACK_AS
#define IG_ABDATA_STACK_AS

#include "abheader.as"
#include "deque.as"

#define global Stack_ClsName "stack"
#define global stackNull dequeNull

#define global stack_make    deque_make
#define global stack_new    deque_new
#define global stack_delete deque_delete

//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global stack_getv(%1,%2=0) deque_getv %1, (-(%2) - 1)

#define global stack_peekv stack_getv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global ctype stack_get(%1,%2=0) deque_get(%1, (-(%2) - 1))

#define global stack_peek stack_get

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global stack_clone(%1,%2=0) deque_clone %1, (-(%2) - 1)

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype stack_ref(%1,%2=0) deque_ref(%1, (-(%2) - 1))

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
;#define global stack_get_front  deque_get_front
;#define global stack_getv_front deque_getv_front
;#define global stack_pop_front  deque_pop_front
;#define global stack_popv_front deque_popv_front
#define global stack_get_back   deque_get_back
#define global stack_getv_back  deque_getv_back
#define global stack_pop_back   deque_pop_back
#define global stack_popv_back  deque_popv_back

#define global stack_pop  deque_pop_back
#define global stack_popv deque_popv_back

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global stack_vartype       container_vartype_back
;#define global stack_vartype_front container_vartype_front
;#define global stack_vartype_back  container_vartype_back

//------------------------------------------------
// データ置換
//------------------------------------------------
;#define global stack_set  deque_set
;#define global stack_setv deque_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
;#define global stack_insert  deque_insert
;#define global stack_insertv deque_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global stack_double_front deque_double_front
#define global stack_double_back  deque_double_back
;#define global stack_push_front   deque_push_front
;#define global stack_pushv_front  deque_pushv_front
#define global stack_push_back    deque_push_back
#define global stack_pushv_back   deque_pushv_back

#define global stack_add         stack_push
#define global stack_push        deque_push_back
#define global stack_pushv       deque_pushv_back

//------------------------------------------------
// 除去
//------------------------------------------------
#define global stack_erase  deque_erase_back

//------------------------------------------------
// 順序操作
//------------------------------------------------
;#define global stack_loc_move        deque_loc_move
;#define global stack_loc_swap        deque_loc_swap
;#define global stack_loc_swap_front  deque_loc_swap_front
#define global stack_loc_swap_back   deque_loc_swap_back
;#define global stack_rotate      deque_rotate
;#define global stack_rotate_back deque_rotate_back
;#define global stack_reverse     deque_reverse

#define global stack_loc_swap        stack_loc_swap_back		// 一番上の2つの要素の交換

//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global stack_clear    deque_clear
#define global stack_chain    deque_chain
#define global stack_copy     deque_copy
#define global stack_swap deque_swap

//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global stack_iter_init deque_iter_init
#define global stack_iter_next deque_iter_next

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global stack_size   deque_size
#define global stack_length stack_size
#define global stack_empty  deque_empty
#define global stack_count  deque_count

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global stack_is_valid deque_is_valid

//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global stack_dbglog deque_dbglog

#endif
