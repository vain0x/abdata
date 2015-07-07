// Container Wrapper - 汎用コンテナ (ラッパ)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_CONTAINER_WRAPPER_AS
#define IG_ABSTRACT_DATA_STRUCTURE_CONTAINER_WRAPPER_AS

#include "container_impl.as"

//##############################################################################
//                Container
//##############################################################################
#define global abdataInsts   st_allinsts@abdata_con_impl
#define global nullContainer st_nullinst@abdata_con_impl

//##############################################################################
//                構築・解体
//##############################################################################
#define global Container_new(%1, %2 = 0, %3 = stt_zero@) \
	ContainerImpl_new abdataInsts, %2, %3 : %1 = stat
#define global Container_delete(%1) ContainerImpl_delete abdataInsts(%1)

#module

#define global ctype new_Container(%1 = 0, %2 = stt_zero@) new_Container_(%1, %2)

//------------------------------------------------
// 一時コンテナ・オブジェクトの生成
//------------------------------------------------
#defcfunc new_Container_ int num, var vDefault,  local newObj
	Container_new newObj, num, vDefault
	return newObj
	
#global

//##############################################################################
//                メンバ命令・関数
//##############################################################################

//################################################
//        取得系
//################################################
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global Container_getv(%1,%2,%3=0) ContainerImpl_getv abdataInsts(%1), %2, %3
#define global Container_popv(%1,%2,%3=0) ContainerImpl_popv abdataInsts(%1), %2, %3

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global ctype Container_get(%1,%2=0) ContainerImpl_get(abdataInsts(%1), %2)
#define global ctype Container_pop(%1,%2=0) ContainerImpl_pop(abdataInsts(%1), %2)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global Container_clone(%1,%2,%3=0) ContainerImpl_clone abdataInsts(%1), %2, %3

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype Container_ref(%1,%2=0) ContainerImpl_ref(abdataInsts(%1))

//------------------------------------------------
// 先頭・末尾の値の取得
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global ctype Container_get_front(%1)     ContainerImpl_get_front(abdataInsts(%1))
#define global ctype Container_get_back(%1)      ContainerImpl_get_back(abdataInsts(%1))
#define global       Container_getv_front(%1,%2) ContainerImpl_getv_front abdataInsts(%1), %2
#define global       Container_getv_back(%1,%2)  ContainerImpl_getv_back abdataInsts(%1), %2
#define global ctype Container_pop_front(%1)     ContainerImpl_pop_front(abdataInsts(%1))
#define global ctype Container_pop_back(%1)      ContainerImpl_pop_back(abdataInsts(%1))
#define global       Container_popv_front(%1,%2) ContainerImpl_popv_front abdataInsts(%1), %2
#define global       Container_popv_back(%1,%2)  ContainerImpl_popv_back abdataInsts(%1), %2

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global ctype Container_vartype(%1,%2)    ContainerImpl_vartype(abdataInsts(%1), %2)
#define global ctype Container_vartype_front(%1) ContainerImpl_vartype_front(abdataInsts(%1))
#define global ctype Container_vartype_back(%1)  ContainerImpl_vartype_back(abdataInsts(%1))

//################################################
//        設定系
//################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global Container_set(%1,%2,%3=0)  ContainerImpl_set  abdataInsts(%1), %2, %3
#define global Container_setv(%1,%2,%3=0) ContainerImpl_setv abdataInsts(%1), %2, %3

//################################################
//        操作系
//################################################
//------------------------------------------------
// 挿入
//------------------------------------------------
#define global Container_insert(%1,%2,%3=0)  ContainerImpl_insert  abdataInsts(%1), %2, %3
#define global Container_insertv(%1,%2,%3=0) ContainerImpl_insertv abdataInsts(%1), %2, %3
//------------------------------------------------
// 要素の倍化
//------------------------------------------------
#define global Container_double(%1,%2,%3) ContainerImpl_double abdataInsts(%1), %2, %3

//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global Container_double_front(%1)   ContainerImpl_double_front abdataInsts(%1)
#define global Container_double_back(%1)    ContainerImpl_double_back abdataInsts(%1)
#define global Container_push_front(%1,%2)  ContainerImpl_push_front abdataInsts(%1), %2
#define global Container_pushv_front(%1,%2) ContainerImpl_pushv_front abdataInsts(%1), %2
#define global Container_push_back(%1,%2)   ContainerImpl_push_back abdataInsts(%1), %2
#define global Container_pushv_back(%1,%2)  ContainerImpl_pushv_back abdataInsts(%1), %2
#define global Container_push  Container_push_back
#define global Container_pushv Container_pushv_back
#define global Container_add   Container_push_back

//------------------------------------------------
// 除去
//------------------------------------------------
#define global Container_remove(%1,%2)    ContainerImpl_remove       abdataInsts(%1), %2
#define global Container_remove_front(%1) ContainerImpl_remove_front abdataInsts(%1)
#define global Container_remove_back(%1)  ContainerImpl_remove_back  abdataInsts(%1)

//------------------------------------------------
// 移動
//------------------------------------------------
#define global Container_move(%1,%2,%3) ContainerImpl_move abdataInsts(%1), %2, %3

//------------------------------------------------
// 交換
//------------------------------------------------
#define global Container_swap(%1,%2,%3) ContainerImpl_swap       abdataInsts(%1), %2, %3
#define global Container_swap_front(%1) ContainerImpl_swap_front abdataInsts(%1)
#define global Container_swap_back(%1)  ContainerImpl_swap_back  abdataInsts(%1)

//------------------------------------------------
// 巡回
//------------------------------------------------
#define global Container_rotate(%1) ContainerImpl_rotate abdataInsts(%1)

//------------------------------------------------
// 巡回 ( 逆回転 )
//------------------------------------------------
#define global Container_rotate_back(%1) ContainerImpl_rotate_back abdataInsts(%1)

//------------------------------------------------
// 反転
//------------------------------------------------
#define global Container_reverse(%1) ContainerImpl_reverse abdataInsts(%1)

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#define global Container_clear(%1) ContainerImpl_clear abdataInsts(%1)

//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global Container_chain(%1,%2) ContainerImpl_chain abdataInsts(%1), %2

//------------------------------------------------
// [i] 複写
//------------------------------------------------
#define global Container_copy(%1,%2) ContainerImpl_copy abdataInsts(%1), %2

//------------------------------------------------
// [i] 交換
//------------------------------------------------
#define global Container_exchange(%1,%2) ContainerImpl_exchange abdataInsts(%1), %2

//------------------------------------------------
// 整列
// 
// @alg: (based: Merge-Sort)
// @	1. 型タイプ値で整列
// @	2. 同じ型 => 不等号による比較で整列
// @prm mode : SortMode_* (default: SortMode_Ascening)
//------------------------------------------------
#define global Container_sort(%1,%2=SortMode_Ascending) ContainerImpl_sort abdataInsts(%1), %2

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#define global Container_iterInit(%1,%2) ContainerImpl_iterInit abdataInsts(%1), %2

//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#define global ctype Container_iterNext(%1,%2,%3) ContainerImpl_iterNext( abdataInsts(%1), %2, %3 )

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype Container_size(%1)  ContainerImpl_size (abdataInsts(%1))
#define global ctype Container_empty(%1) ContainerImpl_empty(abdataInsts(%1))
#define global Container_count  Container_size
#define global Container_length Container_size

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global ctype Container_isValid(%1,%2) ContainerImpl_isValid(abdataInsts(%1), %2)

//------------------------------------------------
// 実際の要素番号を得る
// @private
//------------------------------------------------
// #modcfunc local Container_getRealIndex int idx

//##########################################################
//        演算
//##########################################################
//------------------------------------------------
// 要素比較
//------------------------------------------------
#define global ctype Container_opCmpElem(%1,%2,%3) ContainerImpl_opCmpElem(abdataInsts(%1), %2, %3)

//##############################################################################
//                静的メンバ命令・関数
//##############################################################################
//------------------------------------------------
// 一般的な比較演算
// 
// @(condition): lhs, rhs の型は一致する
//------------------------------------------------
// #defcfunc opCompare@abdata_con_impl var lhs, var rhs

//##############################################################################
//                デバッグ用
//##############################################################################
/*
#ifdef _DEBUG
//*/

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global Container_dbglog(%1) ContainerImpl_dbglog_ abdataInsts(%1), "%1"

/*
#else

#define global Container_dbglog(%1) :

#endif
//*/

	Container_new nullContainer		// null := abdataInsts[0]
	
//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	Container_new    vSt
	Container_add    vSt, "Hello, world!"
	Container_add    vSt, 100
	Container_add    vSt, M_PI
	Container_dbglog vSt
	Container_move   vSt, 1, 2
	Container_dbglog vSt
	
	Container_insert vSt, 0x7FFFFFFF, 0
	Container_dbglog vSt
	
	Container_reverse vSt
	Container_dbglog  vSt
	
	// 整列
	Container_add    vSt, 39
	Container_add    vSt, 18782
	Container_add    vSt, 2943
	Container_add    vSt, "ABCD包囲網"
	Container_add    vSt, "Extra Strings"
	Container_add    vSt, sqrt(2)
	Container_add    vSt, sqrt(8)
	Container_add    vSt, sqrt(3)
	Container_dbglog vSt
	
	Container_sort   vSt, ;SortMode_Decending
	Container_dbglog vSt
	
	stop
	
#endif

#endif

/******
	
	すべてのインスタンスは、このモジュール内の静的変数 (配列) st_allinsts が管理する。
	インスタンスは、実際には st_allinsts の配列要素で管理し、idx を利用したモジュール関数呼び出しは、
	ContainerImpl_(modfunc) st_allinsts@...(idx), ... に変換される。
	
******/
