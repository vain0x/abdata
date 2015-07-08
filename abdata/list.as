// list - リスト

#ifndef IG_ABDATA_LIST_AS
#define IG_ABDATA_LIST_AS

#include "abheader.as"
#include "container.as"

//##############################################################################
//                abdata::list
//##############################################################################

#define global listNull abdataNull

#define global List_ClsName "list"

//##############################################################################
//                構築・解体
//##############################################################################

#define global new_list    new_Container
#define global list_new    Container_new
#define global list_delete Container_delete

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
#define global list_getv Container_getv
#define global list_popv Container_popv

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global list_get Container_get
#define global list_pop Container_pop

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global list_clone Container_clone

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global list_ref Container_ref

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
;#define global list_get_front  Container_get_front
;#define global list_get_back   Container_get_back
;#define global list_getv_front Container_getv_front
;#define global list_getv_back  Container_getv_back
;#define global list_pop_front  Container_pop_front
;#define global list_pop_back   Container_pop_back
;#define global list_popv_front Container_popv_front
;#define global list_popv_back  Container_popv_back

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global list_vartype       Container_vartype
;#define global list_vartype_front Container_vartype_front
;#define global list_vartype_back  Container_vartype_back

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// データ置換
//------------------------------------------------
#define global list_set  Container_set
#define global list_setv Container_setv

//------------------------------------------------
// 挿入
//------------------------------------------------
#define global list_insert  Container_insert
#define global list_insertv Container_insertv

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
;#define global list_push_front  Container_push_front
;#define global list_push_back   Container_push_back
;#define global list_pushv_front Container_pushv_front
;#define global list_pushv_back  Container_pushv_back
;#define global list_push        Container_push
;#define global list_pushv       Container_pushv
#define global list_add         Container_add

//------------------------------------------------
// 除去
//------------------------------------------------
#define global list_remove       Container_remove
;#define global list_remove_front Container_remove_front
;#define global list_remove_back  Container_remove_back

//------------------------------------------------
// 要素数設定
//------------------------------------------------
#define global list_setSize     Container_setSize

//------------------------------------------------
// 順序操作
//------------------------------------------------
#define global list_move        Container_move
#define global list_swap        Container_swap
#define global list_rotate      Container_rotate
#define global list_rotate_back Container_rotate_back
#define global list_reverse     Container_reverse
#define global list_sort        Container_sort

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global list_clear    Container_clear
#define global list_chain    Container_chain
#define global list_copy     Container_copy
#define global list_exchange Container_exchange

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global list_iterInit Container_iterInit
#define global list_iterNext Container_iterNext

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global list_size   Container_size
#define global list_count  list_size
#define global list_length list_size
#define global list_empty  Container_empty

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global list_isValid Container_isValid

//##########################################################
//        静的メンバ命令・関数
//##########################################################

//##########################################################
//        デバッグ用
//##########################################################
//------------------------------------------------
// 全要素の出力
//------------------------------------------------
#define global list_dbglog Container_dbglog

#endif
