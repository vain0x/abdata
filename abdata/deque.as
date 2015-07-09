#ifndef IG_ABDATA_DEQUE_AS
#define IG_ABDATA_DEQUE_AS

#include "container.as"

#define global Deque_ClsName "deque"
#define global dequeNull abdataNull

#define global new_deque    new_container
#define global deque_new    container_new
#define global deque_delete container_delete

//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global deque_getv container_getv
#define global deque_popv container_popv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global deque_get container_get
#define global deque_pop container_pop

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global deque_clone container_clone

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global deque_ref container_ref

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global deque_get_front  container_get_front
#define global deque_get_back   container_get_back
#define global deque_getv_front container_getv_front
#define global deque_getv_back  container_getv_back
#define global deque_pop_front  container_pop_front
#define global deque_pop_back   container_pop_back
#define global deque_popv_front container_popv_front
#define global deque_popv_back  container_popv_back

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global deque_vartype       container_vartype
#define global deque_vartype_front container_vartype_front
#define global deque_vartype_back  container_vartype_back

//------------------------------------------------
// データ置換
//------------------------------------------------
#define global deque_set  container_set
#define global deque_setv container_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
#define global deque_insert  container_insert
#define global deque_insertv container_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global deque_double_front container_double_front
#define global deque_double_back  container_double_back
#define global deque_push_front   container_push_front
#define global deque_push_back    container_push_back
#define global deque_pushv_front  container_pushv_front
#define global deque_pushv_back   container_pushv_back
#define global deque_push         container_push
#define global deque_pushv        container_pushv
#define global deque_add          container_add

//------------------------------------------------
// 除去
//------------------------------------------------
#define global deque_remove       container_remove
#define global deque_remove_front container_remove_front
#define global deque_remove_back  container_remove_back

//------------------------------------------------
// 順序操作
//------------------------------------------------
;#define global deque_loc_move        container_loc_move
;#define global deque_loc_swap        container_loc_swap
#define global deque_loc_swap_front  container_loc_swap_front
#define global deque_loc_swap_back   container_loc_swap_back
#define global deque_rotate      container_rotate
#define global deque_rotate_back container_rotate_back
#define global deque_reverse     container_reverse

//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global deque_clear    container_clear
#define global deque_chain    container_chain
#define global deque_copy     container_copy
#define global deque_swap container_swap

//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global deque_iter_init container_iter_init
#define global deque_iter_next container_iter_next

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global deque_size   container_size
#define global deque_count  deque_size
#define global deque_length deque_size
#define global deque_empty  container_empty

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global deque_isValid container_isValid

//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global deque_dbglog container_dbglog

#endif
