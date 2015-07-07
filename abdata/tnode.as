// tnode - 木構造(1)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_TREE_NODE_AS
#define IG_ABSTRACT_DATA_STRUCTURE_TREE_NODE_AS

// @ tree node (tnode)
// @ メンバ { ノード値, 子データ }
// @ 子データに tnode を突っ込めば、それは実質子ノードになり、
// @	子データに list, pair などを突っ込めば複数個の子ノードを得られる。
// @ <ノード値, 子データ> にそれぞれ [0], [1] という index を割り振る (ただし外部からは使用できない)。

// @ typo が怖いので Child はすべて Chd と略す。
// @ 複数の場所から参照されうるようにするため、子→親のリンクは貼らないことにした。

// @# 実装の上では、list の wrapper 。

#include "list.as"
#include "alg_iter.as"

//##############################################################################
//                abdata::tnode<1>
//##############################################################################
;#define global tnodeInsts st_allinsts@abdata_tnode
#define global tnodeNull  listNull	;st_null@abdata_tnode

#define global TNIdx_Value  0
#define global TNIdx_Chd    1

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype tnode_size (%1) 2	// list_size
#define global ctype tnode_empty(%1) 0	// false
#define global tnode_count  tnode_size
#define global tnode_length tnode_size

//##############################################################################
//                構築・解体
//##############################################################################
//------------------------------------------------
// 構築
//------------------------------------------------
#module abdata_tnode

#define ctype ARG_TEMP(%1) st_temp_%1_arg@abdata_tnode

#define global tnode_new(%1, %2 = stt_zero@, %3 = stt_zero@) \
	ARG_TEMP@abdata_tnode(1) = (%2) :\
	ARG_TEMP@abdata_tnode(2) = (%3) :\
	tnode_newv %1, ARG_TEMP@abdata_tnode(1), ARG_TEMP@abdata_tnode(2) ://
	
#deffunc tnode_newv var self, var value, var chd
	list_new self
	tnode_resetElemsv self, value, chd
	return
	
#defcfunc new_tnode var value, var chd,   local newOne
	tnode_new newOne, value, chd
	return newOne
	
//------------------------------------------------
// 既定の2つの要素を追加する
//------------------------------------------------
#define global tnode_resetElems(%1, %2 = stt_zero@, %3 = stt_zero@) \
	ARG_TEMP@abdata_tnode(1) = (%2) :\
	ARG_TEMP@abdata_tnode(2) = (%3) :\
	tnode_resetElemsv %1, ARG_TEMP@abdata_tnode(1), ARG_TEMP@abdata_tnode(2) ://
	
#deffunc tnode_resetElemsv var self, var value, var chd
	if ( list_empty(self) == false ) { return }
	list_insertv self, value, TNIdx_Value
	list_insertv self, chd,   TNIdx_Chd
	return
	
#global

//------------------------------------------------
// 解体
//------------------------------------------------
#define global tnode_delete list_delete

//##############################################################################
//                メンバ命令・関数
//##############################################################################

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#define global tnode_getv_ list_getv
;#define global tnode_popv_ list_popv

#define global tnode_getv(%1,%2)     tnode_getv_ %1, %2, TNIdx_Value
#define global tnode_getvChd(%1,%2)  tnode_getv_ %1, %2, TNIdx_Chd

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#define global tnode_get_ list_get
;#define global tnode_pop_ list_pop

#define global ctype tnode_get(%1)     tnode_get_( %1, TNIdx_Value )
#define global ctype tnode_getChd(%1)  tnode_get_( %1, TNIdx_Chd )

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#define global tnode_clone_ list_clone

#define global tnode_clone(%1,%2)     tnode_clone_ %1, %2, TNIdx_Value
#define global tnode_cloneChd(%1,%2)  tnode_clone_ %1, %2, TNIdx_Chd

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global tnode_ref_ list_ref

#define global ctype tnode_ref(%1)     tnode_ref_( %1, TNIdx_Value )
#define global ctype tnode_refChd(%1)  tnode_ref_( %1, TNIdx_Chd )

//------------------------------------------------
// 先頭・末尾の値の取り出し
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#define global tnode_vartype_ list_vartype

#define global ctype tnode_vartype(%1)     tnode_vartype_( %1, TNIdx_Value )
#define global ctype tnode_vartypeChd(%1)  tnode_vartype_( %1, TNIdx_Chd )

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// データ置換
//------------------------------------------------
#define global tnode_set_  list_set
#define global tnode_setv_ list_setv

#define global tnode_set(%1,%2)     tnode_set_ %1, %2, TNIdx_Value
#define global tnode_setChd(%1,%2)  tnode_set_ %1, %2, TNIdx_Chd

#define global tnode_setv(%1,%2)    tnode_setv_ %1, %2, TNIdx_Value
#define global tnode_setvChd(%1,%2) tnode_setv_ %1, %2, TNIdx_Chd

//------------------------------------------------
// 挿入, 端への追加, 除去, 順序操作
//------------------------------------------------
// @ なし

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] コンテナ操作
//------------------------------------------------
#define global tnode_clear(%1) list_clear %1 : tnode_resetElems %1
#define global tnode_chain(%1,%2) logmes {"[Error!] tnode_chain %1,%2 はできません！"}
#define global tnode_copy     list_copy
#define global tnode_exchange list_exchange

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子操作
//------------------------------------------------
#define global tnode_iterInit list_iterInit
#define global tnode_iterNext list_iterNext

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#define global ctype tnode_isValid(%1, %2) ( 0 <= (%2) && (%2) < tnode_size(%1) )

//##########################################################
//        静的メンバ命令・関数
//##########################################################

//##########################################################
//        デバッグ用
//##########################################################
#module

#ifdef _DEBUG
//-------- デバッグ時 --------

//------------------------------------------------
// ノード名を再帰的に出力する
//------------------------------------------------
;#define global tnode_dbglog list_dbglog
#deffunc tnode_dbglog int self, int nest,  local thisId, local it, local stmp
	sdim stmp, nest * 2 + 512
	
	if ( nest > 0 ) {
		repeat nest - 1
			stmp += "|  "
		loop
		stmp += "|-- "
	}
	
	logmes stmp + tnode_get(self)
	
	chd = tnode_getChd(self)
	if ( chd != listNull ) {
		IterateBegin chd, list, it
			tnode_dbglog it, nest + 1
		IterateEnd
	}
	
	return
	
#else
//-------- 非デバッグ時 --------

#define tnode_dbglog(%1, %2) :

#endif

#global

//##########################################################
//        子ノード操作::拡張記法
//##########################################################
// @ tnb_* : 二分木 (chd is a pair)
// @ tnx_* : Ｘ分木 (chd is a list)

//------------------------------------------------
// 子ノードの追加 ( 命令形式 )
//------------------------------------------------
#ifdef pair_new
 #define global ctype tnb_addChd(%1, %2 = 0, %3 = stt_zero@, %4 = stt_zero@) \
	ARG_TEMP@abdata_tnode(addChd_1) = (%2)					/* ノード値 */:\
	ARG_TEMP@abdata_tnode(addChd_2) = pair_new( %3, %4 )	/* 子データになる pair を作成 */:\
	tnode_newv %1, ARG_TEMP@abdata_tnode(addChd_1), ARG_TEMP@abdata_tnode(addChd_2) ://
#endif

#ifdef list_new
 #define global tnx_addChd(%1, %2 = tnodeNull) list_add tnChd(%1), %2
#endif

//------------------------------------------------
// 子ノードの取得 ( 関数形式 )
//------------------------------------------------
#define global tnChd tnode_getChd

#ifdef pair_new
 #define global ctype tnbChd(%1,%2=0) pair_get   ( tnode_getChd(%1), %2 )
 #define global ctype tnbChdLhs(%1)   pair_getLhs( tnode_getChd(%1) )
 #define global ctype tnbChdRhs(%1)   pair_getRhs( tnode_getChd(%1) )
#endif

#ifdef list_new
 #define global ctype tnxChd(%1,%2=0) list_get( tnode_getChd(%1), %2 )
#endif

//------------------------------------------------
// 子ノードの数
//------------------------------------------------
#ifdef pair_new
 #define global ctype tnbSize(%1) pair_size( tnode_getChd(%1) )
 #define global tnbCount  tnbSize
 #define global tnbLength tnbLength
#endif

#ifdef list_new
 #define global ctype tnxSize(%1) list_size( tnode_getChd(%1) )
 #define global tnxCount  tnxSize
 #define global tnxLength tnxLength
#endif

;	tnode_new tnodeNull

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	tnode_new root, "親", new_list()
	
	for i, 0, 3
		
		tnode_new   chd, "子(" + i + ")", new_list()
		tnx_addChd root, chd
		
		repeat 5
		;	chd = list_get( tnode_getChd(root), i )
			
			tnode_new  grandChd, "孫(" + cnt + ")", new_list()
			tnx_addChd chd, grandChd
		loop
		
	next
	
	for i, 0, tnxSize(root)
	;	chd = list_get( tnode_getChd(root), i )
		repeat tnxSize( tnxChd(root, i) )
			mes tnode_get( tnxChd( tnxChd(root, i), cnt ) )
		loop
	next
	
	pos 300, 10
	tnode_dbglog root
	stop
	/*
	tnode_new  root2, "root2"
	tnx_addChd root2, tr
;	tnode_copy root2, tr
	TNode_dbglog root2
	
	TNode_addSubTree tr, tr2
	TNode_dbglog tr
	
	logmes ""
	assert
	TNode_addSubTree tr, tr2
	TNode_dbglog tr
	
	stop
	//*/
#endif

#endif
