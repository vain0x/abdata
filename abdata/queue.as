// キュー - Queue ( FILO & LIFO )

#ifndef __ABSTRACT_DATA_STRUCTURE_QUEUE_AS__
#define __ABSTRACT_DATA_STRUCTURE_QUEUE_AS__

#include "list.as"

#module abdata_queue mList

#define VAR_TEMP stt_temp@abdata_queue
#define mv modvar abdata_queue@

#define ctype numrg(%1,%2,%3) (((%2) <= (%1)) && ((%1) <= (%3)))
#define true  1
#define false 0

#define ctype STR_ERR_OVER_RANGE(%1) "Error! [@abdata_queue] 要素番号範囲外エラー("+ (%1) +")"

//##############################################################################
//                メンバ命令・関数
//##############################################################################
#modfunc Queue_dupList@abdata_queue var vRefList
	dup vRefList, mList
	return
	
//################################################
//        雑多系
//################################################
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#defcfunc Queue_size mv
	return List_size( mList )
	
#define global Queue_n Queue_size

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#defcfunc Queue_isValid mv, int i
	return List_isValid(mList, i)
	
//################################################
//        取得系
//################################################
//------------------------------------------------
// 値返し ( 命令形式 )
//------------------------------------------------
#modfunc Queue_peekv var result, int i
	if ( Queue_isValid(thismod, i) == false ) { logmes STR_ERR_OVER_RANGE(i) : return }
	List_getv mList, result, i
	return
	
//------------------------------------------------
// 値返し ( 関数形式 )
//------------------------------------------------
#defcfunc Queue_peek mv, int i
	Queue_peekv thismod, VAR_TEMP, i
	return VAR_TEMP
	
//------------------------------------------------
// pop ( 命令形式 )
//------------------------------------------------
#modfunc Queue_popv var result
	List_getv   mList, result, 0
	List_remove mList,         0
	return
	
//------------------------------------------------
// pop ( 関数形式 )
//------------------------------------------------
#defcfunc Queue_pop mv
	Queue_popv thismod, VAR_TEMP
	return VAR_TEMP
	
//################################################
//        設定系
//################################################

//################################################
//        操作系
//################################################
//------------------------------------------------
// 最後尾への追加
//------------------------------------------------
#define global Queue_push(%1,%2) VAR_TEMP@abdata_queue = %2 : Queue_pushv %1,VAR_TEMP@abdata_queue
#modfunc Queue_pushv var v_value
	List_insertv mList, v_value, -1
	return
	
#define global Queue_push_back Queue_push
	
//################################################
//        その他
//################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc Queue_clear
	List_clear mList
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc Queue_chain var mv_from,  local fromList
	Queue_dupList mv_from, fromList
	List_chain    mList,   fromList
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc Queue_copy var mv_from,  local fromList
	Queue_dupList mv_from, fromList
	List_copy     mList,   fromList
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc Queue_exchange var mv2,  local fromList
	Queue_dupList mv2,   fromList
	List_exchange mList, fromList
	return
	
//################################################
//        デバッグ用
//################################################
#ifdef _DEBUG

//------------------------------------------------
// キューの内容を全部表示
//------------------------------------------------
#modfunc Queue_dbglog
	repeat Queue_size(thismod)
		logmes strf("#%2d = ", cnt) + Queue_peek( thismod, cnt )
	loop
	return
	
#else

#define global Queue_dbglog(%1) :

#endif
//##############################################################################
//                コンストラクタ・デストラクタ
//##############################################################################
//------------------------------------------------
// [i] コンストラクタ
//------------------------------------------------
#define global Queue_new(%1) newmod %1, abdata_queue@
#modinit
	List_new mList
	return
	
#define global Queue_init Queue_new
	
//------------------------------------------------
// [i] デストラクタ
//------------------------------------------------
#define global Queue_delete(%1) delmod %1
#modterm
	List_delete mList
	return
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	Queue_new q
	repeat 2
		mes "loop "+ cnt
	
		repeat 8
			Queue_push q, (1 << cnt)
		loop
		
		repeat Queue_size(q)
			mes strf("\t0x%04X", Queue_pop(q))
		loop
	loop
	
	Queue_delete q
	stop
	
#endif

#endif
