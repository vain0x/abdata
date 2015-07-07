// Stack - スタック ( FIFO & LILO )

#ifndef __ABSTRACT_DATA_STRUCTURE_STACK_AS__
#define __ABSTRACT_DATA_STRUCTURE_STACK_AS__

#include "value.as"

//##################################################################################################
//                        スタック
//##################################################################################################
#module abdata_stack mValue, mCnt

#define mv modvar abdata_stack@
#define VAR_TEMP stt_temp@abdata_stack

//##############################################################################
//                コンストラクタ・デストラクタ
//##############################################################################
//------------------------------------------------
// [i] コンストラクタ
//------------------------------------------------
#define global Stack_new(%1) newmod %1,abdata_stack@
#modinit
	dim mCnt		// 要素数
	return
	
#define global Stack_init Stack_new
	
//------------------------------------------------
// [i] デストラクタ
//------------------------------------------------
#define global Stack_delete(%1) delmod %1
;#modterm
	// pop leak を取り除く (必要なし)
;	repeat  mCnt
;		value_delete mValue(cnt)
;	loop
;	return

//##############################################################################
//                メンバ関数群
//##############################################################################
//------------------------------------------------
// プッシュ
//------------------------------------------------
#define global Stack_push(%1,%2) VAR_TEMP@abdata_stack = (%2) : Stack_pushv %1, VAR_TEMP@abdata_stack
#modfunc Stack_pushv var value
	value_new mValue, value			// 新しい項目を一番後ろに作成
	mCnt ++							// 項目数を増加
	return
	
#define global Stack_push_back Stack_push

//------------------------------------------------
// ポップ
//------------------------------------------------
#modfunc Stack_popv var vResult
	if ( mCnt <= 0 ) { logmes "UnderFlow (StackPop)" : return 0 }	// アンダーフローを警告
	mCnt --								// 積まれている数を減らす
	value_getv   mValue(mCnt), vResult	// 一番後ろの項目を取得
	value_delete mValue(mCnt)			// 取得した項目を削除
	return
	
#defcfunc Stack_pop mv
	Stack_popv thismod, VAR_TEMP
	return VAR_TEMP
	
//------------------------------------------------
// 取得のみ
//------------------------------------------------
#modfunc Stack_peekv var vResult, int p2
	if ( p2 < 0 ) { return 0 }
	if ( (mCnt - p2 ) <= 0 ) { logmes "UnderFlow (StackPeek)" : return 0 }
	value_getv mValue( mCnt - p2 - 1 ), vResult
	return
	
#defcfunc Stack_peek mv, int p2
	Stack_peekv thismod, VAR_TEMP, p2
	return VAR_TEMP
	
#define global Stack_get  Stack_peek
#define global Stack_getv Stack_peekv
	
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#defcfunc Stack_size mv
	return mCnt
	
#define global Stack_n Stack_size

//##############################################################################
//                インターフェース関数群
//##############################################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc Stack_clear
	// 全要素を解放する
	foreach mValue
		value_delete mValue(cnt)
	loop
	mCnt = 0
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc Stack_chain var mv_from
	repeat Stack_size( mv_from )
		Stack_peekv  mv_from, Stack_size(mv_from) - 1 - cnt, VAR_TEMP		// 後ろから peek
		Stack_pushv  thismod, VAR_TEMP
	loop
	return
	
//------------------------------------------------
// [i] 複製
//------------------------------------------------
#modfunc Stack_copy var mv_from
	Stack_clear thismod
	Stack_chain thismod, mv_from
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc Stack_exchange var mv2, local mvTemp
	Stack_new  mvTemp
	Stack_copy mvTemp,  thismod
	Stack_copy thismod, mv2
	Stack_copy mv2,     mvTemp
	Stack_delete mvTemp
	return
	
//------------------------------------------------
// デバッグ用
//------------------------------------------------
#ifdef _DEBUG
 #modfunc Stack_dbglog
	foreach mValue
		value_getv mValue(cnt), VAR_TEMP
		logmes strf("#%2d: ", cnt) + VAR_TEMP
	loop
	return
#else
 #define global Stack_dbglog(%1) :
#endif

#global

#endif
