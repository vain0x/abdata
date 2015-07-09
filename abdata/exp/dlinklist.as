#ifndef IG_ABDATA_DOUBLE_LINKED_LIST_AS
#define IG_ABDATA_DOUBLE_LINKED_LIST_AS

// 循環双方向連結リスト
// Double linked list (circularly)

// @ すべての値はメンバ mValue が管理。
// @ 要素の順番は、DLValue の持つリンクで操作する。

#include "dlinkvalue.as"

#module abdata_dlinklist mValue, mCntValue, mTop, mLast, mIter_v, mIter_c, mbIterStart

#define mIter mIter_v(mIter_c)

#define VAR_TEMP stt_temp@abdata_dlinklist

#define global DLList_IterDataType 4

#define global DLList_new(%1)    newmod %1, abdata_dlinklist@
#define global DLList_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit
	DLList_clear thismod
	return
	
//------------------------------------------------
// [i] 解体
//------------------------------------------------

//------------------------------------------------
// 先頭に移動
//------------------------------------------------
#modfunc DLList_goTop
	mIter = mTop
	return
	
//------------------------------------------------
// 終端に移動
//------------------------------------------------
#modfunc DLList_goLast
	mIter = mLast
	return
	
//------------------------------------------------
// 反復子を p2 個戻す
//------------------------------------------------
#modfunc DLList_back int p2
	repeat p2 : mIter = DLV_getPrev( mValue(mIter) ) : loop
	return
	
//------------------------------------------------
// 反復子を p2 個進める
//------------------------------------------------
#modfunc DLList_skip int p2
	repeat p2 : mIter = DLV_getNext( mValue(mIter) ) : loop
	return
	
//------------------------------------------------
// p2 番目の要素に移動する
//------------------------------------------------
#modfunc DLList_jump int p2
	mIter = DLList_followLink(thismod, p2)
	return
	
//------------------------------------------------
// 反復子の初期化
//------------------------------------------------
#modfunc DLList_iterClear
	mIter       = mTop
	mbIterStart = true
	if ( mCntValue == 0 ) { mbIterStart = 0 }
	return
	
//------------------------------------------------
// 反復子スタックを push
//------------------------------------------------
#modfunc DLList_iterNew
	mIter_c          ++			// カウントを増加
	DLList_iterClear thismod	// 適切に初期化する
	return
	
//------------------------------------------------
// 反復子スタックを pop
//------------------------------------------------
#modfunc DLList_iterDelete
	if ( mIter_c > 0 ) {
		mIter_c --
	}
	return
	
//------------------------------------------------
// 反復子の更新 ( while の条件に使う )
//------------------------------------------------
#modcfunc DLList_iterCheck var vIt
	if ( mIter == mTop ) {
		if ( mbIterStart ) {
			mbIterStart = false
		} else {
			DLList_iterDelete thismod
			return false		// 一周した
		}
	}
	
	DLV_dup mValue(mIter), vIt				// 今指している場所を取得
	mIter = DLV_getNext( mValue(mIter) )	// 次を指定する
	return true
	
//------------------------------------------------
// 先頭にいるか？
//------------------------------------------------
#modcfunc DLList_iterIsTop
	return mIter == mTop
	
//------------------------------------------------
// 終端にいるか？
//------------------------------------------------
#modcfunc DLList_iterIsLast
	return mIter == mLast
	
//------------------------------------------------
// [i] 反復子初期化
//------------------------------------------------
#modfunc DLList_iter_init var iterData
	DLList_iterNew thismod
	return
	
//------------------------------------------------
// [i] 反復子更新
//------------------------------------------------
#modcfunc DLList_iter_next var vIt, var iterData
	return DLList_iterCheck(thismod, vIt)
	
//------------------------------------------------
// 次の要素を取得する
//------------------------------------------------
#define global DLList_getNext(%1,%2)  DLList_getSeq %1,%2,1,0
#define global DLList_peekNext(%1,%2) DLList_getSeq %1,%2,0,0

#define global ctype DLList_getNextf(%1)  DLList_getSeqf(%1,1)
#define global ctype DLList_peekNextf(%1) DLList_getSeqf(%1,0)

#define global DLList_dupNext(%1,%2,%3=1)  DLList_getSeq %1,%2,%3,1
#define global DLList_dupValue(%1,%2,%3=0) DLList_getv   %1,%2,%3,1

//------------------------------------------------
// Sequential Access 命令形式
//------------------------------------------------
#modfunc DLList_getSeq var vResult, int bMove, int bDup
	if ( bDup == 0 ) {
		DLV_getv mValue(mIter), vResult
	} else {
		DLV_dup mValue(mIter), vResult
	}
	if ( bMove ) {
		DLList_skip thismod, 1		// 次に移動する
	}
	return
	
//------------------------------------------------
// Sequential Access 関数形式
//------------------------------------------------
#modcfunc DLList_getSeqf int bMove
	DLList_getSeq thismod, VAR_TEMP, bMove, 0
	return VAR_TEMP
	
//------------------------------------------------
// Random Access 命令形式
//------------------------------------------------
#modfunc DLList_getv var p2, int p3, int bDup
	if ( bDup == 0 ) {
		DLV_getv mValue( DLList_followLink(thismod, p3) ), p2
	} else {
		DLV_dup  mValue( DLList_followLink(thismod, p3) ), p2
	}
	return
	
//------------------------------------------------
// Random Access 関数形式
//------------------------------------------------
#modcfunc DLList_get int p2
	DLList_getv thismod, VAR_TEMP, p2, 0
	return VAR_TEMP
	
//------------------------------------------------
// 今の要素を変更する
//------------------------------------------------
#define global DLList_setNow(%1,%2) VAR_TEMP@abdata_dlinklist = (%2) : DLList_setNow_var %1,VAR_TEMP@abdata_dlinklist
#modfunc DLList_setNow_var var p2
	DLV_setv mValue(mIter), p2
	return
	
//------------------------------------------------
// さきほど取得したの要素を変更する
//------------------------------------------------
#define global DLList_setBack(%1,%2) VAR_TEMP@abdata_dlinklist = (%2) : DLList_setBack_var %1,VAR_TEMP@abdata_dlinklist
#modfunc DLList_setBack_var var p2
	DLList_back   thismod, 1
	DLList_setNow thismod, p2
	DLList_skip   thismod, 1
	return
	
//------------------------------------------------
// Random Access
//------------------------------------------------
#define global DLList_set(%1,%2,%3=0) VAR_TEMP@abdata_dlinklist = (%2) : DLList_setv %1,VAR_TEMP@abdata_dlinklist,%3
#modfunc DLList_setv var p2, int p3
	DLV_setv mValue( DLList_followLink(thismod, p3) ), p2
	return
	
//------------------------------------------------
// 現在の位置に追加する
// 
// @ 次の GetSeq で取得される
//------------------------------------------------
#define global DLList_insNow(%1,%2) VAR_TEMP@abdata_dlinklist = (%2) : DLList_insNow_var %1,VAR_TEMP@abdata_dlinklist
#modfunc DLList_insNow_var var p2
	DLList_insertItem thismod, p2, mIter	// 今指している要素の前に挿入する
	DLList_skip       thismod, 1
	return
	
//------------------------------------------------
// Random Access
//------------------------------------------------
#define global DLList_insert(%1,%2,%3=-1) VAR_TEMP@abdata_dlinklist = (%2) : DLList_insertv %1,VAR_TEMP@abdata_dlinklist,%3
#modfunc DLList_insertv var vResult, int n,  local nxt
	
	// 追加される項目の次の項目を探す
	if ( n >= mCntValue || n < 0 || mCntValue <= 0 ) {
		nxt = mTop		// 最後に挿入する
		
	} else : if ( n == 0 ) {
		nxt = -1		// 先頭に挿入する
		
	} else {
		nxt = DLList_followLink(thismod, n)
	}
	
	// 挿入処理
	DLList_insertItem thismod, vResult, nxt
	return
	
//------------------------------------------------
// 次に取得する要素を削除する
//------------------------------------------------
#modfunc DLList_delNow  local prv
	prv   = DLV_getPrev( mValue(mIter) )
	DLList_removeItem thismod, mIter
	mIter = prv
	return
	
//------------------------------------------------
// さきほど getnext した要素を削除する
//------------------------------------------------
#modfunc DLList_delBack
	DLList_back   thismod, 1
	DLList_delNow thismod
	return
	
//------------------------------------------------
// Random Access
//------------------------------------------------
#modfunc DLList_remove int p2,  local now, local nxt, local prv
	
	// 削除される場所を探す
	if ( p2 >= mCntValue || p2 < 0 ) {
		now = mLast								// 最後を削除する
	} else {
		now = DLList_followLink(thismod, p2)	// p2 番目の要素を削除する
	}
	
	// 削除する
	DLList_removeItem thismod, now
	return
	
#define global DLList_cntValue !!"DLList_cntValue()は廃止。DLList_size()に移行せよ。"!!

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc DLList_size
	return mCntValue
	
#define global DLList_count  DLList_size
#define global DLList_length DLList_size
	
//------------------------------------------------
// [i] 消去
//------------------------------------------------
#modfunc DLList_clear
	dim     mValue
;	DLV_new mValue, VAR_TEMP
	mCntValue = 0		// 要素数
	mTop      = 0		// 先頭の要素番号
	mLast     = 0		// 最後の要素番号
	mIter_v   = 0		// 反復子
	mIter_c   = 0		// カウンタ
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc DLList_chain var mv_from,  local it
	// 全要素を同じ順番で挿入する
	DLList_iterNew mv_from
	
	while ( DLList_iterCheck(mv_from, it) )
		DLList_insert thismod, it, cnt
	wend
	
	DLList_iterDelete mv_from
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc DLList_copy var mv_from,  local it
	DLList_clear thismod
	DLList_chain thismod, mv_from
	return
	
//------------------------------------------------
// [i] コンテナ交換
//------------------------------------------------
#modfunc DLList_swap var mv2,  local mvTemp
	DLList_new  mvTemp
	DLList_copy mvTemp,  thismod
	DLList_copy thismod, mv2
	DLList_copy mv2,     mvTemp
	DLList_delete mvTemp
	return
	
//------------------------------------------------
// リンクを辿って n 番目の要素の番号を取得
// @private
//------------------------------------------------
#modcfunc DLList_followLink int n, local now
	now = mTop
	repeat n
		now = DLV_getNext( mValue(now) )
	loop
	return now
	
//------------------------------------------------
// 反復子に p2 回操作を加える
// @private
// @template macro
//------------------------------------------------
#define ctype FTM_DLList_iter(%1) repeat p2 : %1 : loop

//------------------------------------------------
// 先頭に追加する
// @private
//------------------------------------------------
#modfunc DLList_insTop var p2, local now
	
	// アイテムを追加する
	DLV_new mValue, p2, mTop, mLast		// 追加する
	now = stat
	
	// リンクを修整する
	DLV_setNext mValue(mLast), now
	DLV_setPrev mValue(mTop),  now
	
	mTop = now
	mCntValue ++
	return
	
//------------------------------------------------
// 項目を挿入する
// @private
// @ 挿入位置を指定する
//------------------------------------------------
#modfunc DLList_insertItem var p2, int p3, local nxt, local prv, local now
	
	if ( mCntValue > 0 ) {
		if ( p3 < 0 ) {					// 先頭に追加する
			DLList_insTop thismod, p2
			return
			
		} else : if ( p3 == mTop ) {	// 最後に追加する
			prv = mLast
			nxt = mTop
			
		} else {
			nxt = p3
			prv = DLV_getPrev( mValue(nxt) )	// 前のリンクは取得できる
		}
	} else {
		nxt = p3
		prv = 0
	}
	
	// アイテムを追加する
	DLV_new mValue, p2, nxt, prv
	now = stat
	
	// リンクを修整する
	DLV_setNext mValue(prv), now
	DLV_setPrev mValue(nxt), now
	
	if ( nxt == mTop ) {			// 最後に挿入した場合
		mLast = now
	}
	
	mCntValue ++
	return
	
//------------------------------------------------
// 項目を削除する
// @private
// @ 削除位置を指定する
//------------------------------------------------
#modfunc DLList_removeItem int now,  local nxt, local prv
	
	// 前後のリンクを保存する
	nxt = DLV_getNext( mValue(now) )
	prv = DLV_getPrev( mValue(now) )
	
	// 削除する
	DLV_delete mValue(now)
	mCntValue --
	if ( mCntValue <= 0 ) {
		mTop  = 0
		mLast = 0
		return
	}
	
	// リンクを修整する
	DLV_setNext mValue(prv), nxt
	DLV_setPrev mValue(nxt), prv
	
	if ( now == mTop  ) { mTop  = nxt }		// 先頭を削除した場合
	if ( now == mLast ) { mLast = prv }		// 最後を削除した場合
	return
	
#ifdef _DEBUG

//------------------------------------------------
// 全項目をデバッグ出力
//------------------------------------------------
#modfunc DLList_dbglog local i, local it
	logmes ""
	logmes "- DLList_allPut"
	i = 0
	DLList_iterNew thismod
	while ( DLList_iterCheck(thismod, it) )
		logmes strf("(%2d) ", i) + it
		i ++
	wend
	return
	
#else //defined(_DEBUG)

#define global DLList_dbglog(%1) :

#endif //defined(_DEBUG)

#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

#include "alg_iter.as"

#ifndef __UserDefHeader__
 #define color32(%1=0) color ((%1) & 0xFF),(((%1) >> 8) & 0xFF),(((%1) >> 16) & 0xFF)
 #define ctype RGB(%1,%2,%3) ((%1) | (%2) << 8 | (%3) << 16)
 #define ctype bturn(%1) ((%1) ^ 0xFFFFFFFF)
#endif

	randomize
	screen 0, 320, 240
	syscolor 15 : boxf
	
	font msgothic, 12
	
	pos 20, 20
	
	sdim  cmd, 64
	input cmd, , , 3
	count = 5
	
	DLList_new mDLList
	
	onkey gosub *enter
	stop
	
*enter
	objsel -1
	if (iparam != 13 || stat != 0) {
		return
	}
	
	getstr snum, cmd, 1
	
	prm = int(snum)
	c   = peek(cmd, 0)
	
	if ( snum == "" ) {
		prm = -1
	}
	
	switch c
		case '+'
			n = rnd(100)
			DLList_insert mDLList, n, prm
			
			color 255, 255, 255 : boxf 110, 20, 180, 40 : color
			pos 110, 26 : mes "insert : "+ n
			
			gosub *disp
			swbreak
			
		case '-'
			DLList_remove mDLList, prm
			gosub *disp
			swbreak
			
		case '@'
			randomize prm
			swbreak
	swend
	
	poke cmd
	objprm 0, cmd
	return
	
*disp
	if ( count == 5 ) {
		count = 0
		cref  = RGB(rnd(3) * 127 + 1, rnd(3) * 127 + 1, rnd(3) * 127 + 1)
	}
	
	color32 cref
	boxf 10 + ( 60 * count ), 45, 70 + ( 60 * count ), 230 : color32 bturn(cref)
	pos  15 + ( 60 * count ), 50
	
	/*
	i = 0
	DLList_iterNew mDLList
	while ( DLList_iterCheck(mDLList, it) )
		mes strf("(%2d) : ", i) + it
		i ++
	wend
	/*/
	IterateBegin mDLList, DLList
		mes strf("(%2d) : ", IterateCnt) + it
	IterateEnd
	//*/
	
	count ++
	return
	
#endif

#endif
