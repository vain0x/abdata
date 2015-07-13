#ifndef IG_ABDATA_LIST_AS
#define IG_ABDATA_LIST_AS

#include "abheader.as"
#include "container.as"

#define global listNull abdataNull

#define global List_ClsName "list"

#define global list_make    container_make
#define global list_new    container_new
#define global list_delete container_delete

//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global list_getv container_getv
#define global list_popv container_popv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global list_get container_get
#define global list_pop container_pop

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global list_clone container_clone

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global list_ref container_ref

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global list_get_front  container_get_front
#define global list_get_back   container_get_back
#define global list_getv_front container_getv_front
#define global list_getv_back  container_getv_back
#define global list_pop_front  container_pop_front
#define global list_pop_back   container_pop_back
#define global list_popv_front container_popv_front
#define global list_popv_back  container_popv_back

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global list_vartype       container_vartype
#define global list_vartype_front container_vartype_front
#define global list_vartype_back  container_vartype_back

//------------------------------------------------
// データ置換
//------------------------------------------------
#define global list_set  container_set
#define global list_setv container_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
#define global list_insert  container_insert
#define global list_insertv container_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global list_push_front  container_push_front
#define global list_push_back   container_push_back
#define global list_pushv_front container_pushv_front
#define global list_pushv_back  container_pushv_back
#define global list_push        container_push
#define global list_pushv       container_pushv
#define global list_add         container_add

//------------------------------------------------
// 除去
//------------------------------------------------
#define global list_erase       container_erase
#define global list_erase_front container_erase_front
#define global list_erase_back  container_erase_back

//------------------------------------------------
// 要素数設定
//------------------------------------------------
#define global list_resize     container_resize

//------------------------------------------------
// 順序操作
//------------------------------------------------
#define global list_loc_move        container_loc_move
#define global list_loc_swap        container_loc_swap
#define global list_rotate      container_rotate
#define global list_rotate_back container_rotate_back
#define global list_reverse     container_reverse
#define global list_sort        container_sort

//------------------------------------------------
// 整列済みリストへの操作
//------------------------------------------------
#define global list_is_sorted      container_is_sorted
#define global list_lower_bound    container_lower_bound
#define global list_upper_bound    container_upper_bound
#define global list_equal_range    container_equal_range
#define global list_sorted_insertv container_sorted_insertv
#define global list_sorted_erasev  container_sorted_erasev
#define global list_sorted_count   container_sorted_count

//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global list_clear    container_clear
#define global list_chain    container_chain
#define global list_copy     container_copy
#define global list_swap container_swap

//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global list_iter_init container_iter_init
#define global list_iter_next container_iter_next

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global list_size   container_size
#define global list_length list_size
#define global list_empty  container_empty
#define global list_count  container_count

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global list_is_valid container_is_valid

//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global list_dbglog container_dbglog

#endif
