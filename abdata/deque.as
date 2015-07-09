#ifndef IG_ABDATA_DEQUE_AS
#define IG_ABDATA_DEQUE_AS

#include "container.as"

#define global Deque_ClsName "deque"
#define global dequeNull abdataNull

#define global new_deque    new_Container
#define global deque_new    Container_new
#define global deque_delete Container_delete

//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global deque_getv Container_getv
#define global deque_popv Container_popv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global deque_get Container_get
#define global deque_pop Container_pop

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global deque_clone Container_clone

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global deque_ref Container_ref

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global deque_get_front  Container_get_front
#define global deque_get_back   Container_get_back
#define global deque_getv_front Container_getv_front
#define global deque_getv_back  Container_getv_back
#define global deque_pop_front  Container_pop_front
#define global deque_pop_back   Container_pop_back
#define global deque_popv_front Container_popv_front
#define global deque_popv_back  Container_popv_back

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global deque_vartype       Container_vartype
#define global deque_vartype_front Container_vartype_front
#define global deque_vartype_back  Container_vartype_back

//------------------------------------------------
// データ置換
//------------------------------------------------
#define global deque_set  Container_set
#define global deque_setv Container_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
#define global deque_insert  Container_insert
#define global deque_insertv Container_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global deque_double_front Container_double_front
#define global deque_double_back  Container_double_back
#define global deque_push_front   Container_push_front
#define global deque_push_back    Container_push_back
#define global deque_pushv_front  Container_pushv_front
#define global deque_pushv_back   Container_pushv_back
#define global deque_push         Container_push
#define global deque_pushv        Container_pushv
#define global deque_add          Container_add

//------------------------------------------------
// 除去
//------------------------------------------------
#define global deque_remove       Container_remove
#define global deque_remove_front Container_remove_front
#define global deque_remove_back  Container_remove_back

//------------------------------------------------
// 順序操作
//------------------------------------------------
;#define global deque_loc_move        Container_loc_move
;#define global deque_loc_swap        Container_loc_swap
#define global deque_loc_swap_front  Container_loc_swap_front
#define global deque_loc_swap_back   Container_loc_swap_back
#define global deque_rotate      Container_rotate
#define global deque_rotate_back Container_rotate_back
#define global deque_reverse     Container_reverse

//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global deque_clear    Container_clear
#define global deque_chain    Container_chain
#define global deque_copy     Container_copy
#define global deque_swap Container_swap

//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global deque_iter_init Container_iter_init
#define global deque_iter_next Container_iter_next

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global deque_size   Container_size
#define global deque_count  deque_size
#define global deque_length deque_size
#define global deque_empty  Container_empty

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global deque_isValid Container_isValid

//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global deque_dbglog Container_dbglog

#endif
