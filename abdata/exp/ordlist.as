#ifndef IG_ABDATA_ORDLIST_AS
#define IG_ABDATA_ORDLIST_AS

#include "abelem.as"			// 要素型
#include "mod_shiftArray.as"	// 配列操作モジュール

#include "alg_iter.as"
#include "value.as"

// 整列済みリスト(ordered list)
// @ 順序や要素型に自由が利かないリスト
// @ 探索が最適化できる
// @ key や value 引数が var なので、使いづらい

#module abdata_ordlist mCnt, mElems, midlist, mVartype

#define VAR_TEMP stt_temp@abdata_ordlist
#define HSPVAR_TYPE_STR 2

#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0

#define global Ordlist_new(%1,%2) newmod %1, abdata_ordlist@, %2
#define global Ordlist_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
//------------------------------------------------
#modinit int vt
	
	// メンバ変数の初期化
	midlist  = 0
	mCnt     = 0
	mVartype = vt
	
	abelem_new    mElems
	abelem_delete mElems
	
	return
	
//------------------------------------------------
// 構築者
//------------------------------------------------
;#deffunc CreateOrdlist array self
;	Ordlist_new self
;	return
	
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#modfunc Ordlist_getv_ var result, var key, int bRemove
	
	Ordlist_getv_byIndex thismod, Ordlist_getIndex(thismod, key), result
	
	return
	
#modfunc Ordlist_getv_byIndex@abdata_ordlist var result, int i, int bRemove
	
	abelem_getv mElems( midlist(i) ), result
	
	if ( bRemove ) {
		Ordlist_remove_byIndex thismod, i
	}
	
	return
	
#define global Ordlist_getv(%1,%2) Ordlist_getv_ %1, %2, 0
#define global Ordlist_popv(%1,%2) Ordlist_getv_ %1, %2, 1

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc Ordlist_get_ var key, int bRemove
	Ordlist_getv_ thismod, VAR_TEMP, key, bRemove
	return VAR_TEMP
	
#define global ctype Ordlist_get(%1,%2) Ordlist_get_(%1, %2, 0)
#define global ctype Ordlist_pop(%1,%2) Ordlist_get_(%1, %2, 1)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc Ordlist_dup var vRef, var key
	abelem_dup mElems( midlist( Ordlist_getIndex(thismod, key) ) ), vRef
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype Ordlist_ref(%1,%2) VAR_TEMP@abdata_ordlist( Ordlist_ref_(%1,%2) )
#modcfunc Ordlist_ref_ var key
	Ordlist_dup thismod, VAR_TEMP, key
	return 0
	
//------------------------------------------------
// 型タイプ値
//------------------------------------------------
#modcfunc Ordlist_vartype
	return mVartype
	
//------------------------------------------------
// 要素の追加
//------------------------------------------------
#define global Ordlist_add(%1,%2) VAR_TEMP@abdata_ordlist = %2 : Ordlist_addv %1, VAR_TEMP@abdata_ordlist

#modfunc Ordlist_addv var vValue
	
	if ( vartype(vValue) != mVartype ) { return }
	
	VAR_TEMP = Ordlist_getIndex( thismod, vValue )
	
	return
	
#modfunc Ordlist_addv_byIndex@abdata_ordlist var vValue, int i
	
	// [i] を空ける
	stdarray_insert_room midlist, i
	
	// 要素を追加
	abelem_new mElems, vValue
	midlist(i) = stat
	mCnt ++
	
	return
	
//------------------------------------------------
// 要素の倍化
//------------------------------------------------
#define global Ordlist_double Ordlist_addv

//------------------------------------------------
// 除去
//------------------------------------------------
#modfunc Ordlist_remove var key
	
	Ordlist_remove_byIndex thismod, Ordlist_getIndex(thismod, key)
	
	return
	
#modfunc Ordlist_remove_byIndex@abdata_ordlist int i,  local ivRemoved
	
	ivRemoved = midlist(i)
	
	// i 番目を詰める ( 実質的除去 )
	stdarray_erase midlist, i
	midlist( length(midlist) - 1 ) = -1		// 残骸を無効要素にする
	mCnt --
	
	// mElems の方も解放
	abelem_delete mElems( ivRemoved )
	
	return
	
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc Ordlist_clear
	
	// 全要素を解放する
	foreach mElems
		abelem_delete mElems(cnt)
	loop
	
	// 番号リストを初期化
	dim midlist
	mCnt = 0
	
	return
	
//------------------------------------------------
// [i] 連結
//------------------------------------------------
#modfunc Ordlist_chain var src
	
	IterateBegin src, Ordlist, VAR_TEMP
		Ordlist_addv thismod, VAR_TEMP
	IterateEnd
	
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc Ordlist_copy var src
	Ordlist_clear thismod
	Ordlist_chain thismod, src
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc Ordlist_swap var mv2,  local mvTemp
	
	if ( Ordlist_vartype(thismod) != Ordlist_vartype(mv2) ) {
		return
	}
	
	Ordlist_new  mvTemp,  Ordlist_vartype(thismod)
	Ordlist_copy mvTemp,  thismod
	Ordlist_copy thismod, mv2
	Ordlist_copy mv2,     mvTemp
	Ordlist_delete mvTemp
	
	return
	
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc Ordlist_iter_init var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc Ordlist_iter_next var vIt, var iterData,  local idx
	iterData ++
	
	if ( iterData >= mCnt ) {
		return false
	}
	
	Ordlist_getv_byIndex thismod, vIt, iterData
	
	return true
	
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc Ordlist_size
	return mCnt
	
#define global ctype Ordlist_empty(%1) ( Ordlist_size(%1) == 0 )
#define global Ordlist_count  Ordlist_size
#define global Ordlist_length Ordlist_size

//------------------------------------------------
// キーの有無
//------------------------------------------------
#modcfunc Ordlist_exists var key,  local idx
	return ( Ordlist_getIndex(thismod, key, true) >= 0 )
	
//------------------------------------------------
// 値の要素番号を得る
// @private
// @prm bNoAdd : key が存在しないときでも要素を追加しない。
//------------------------------------------------
#modcfunc Ordlist_getIndex@abdata_ordlist var key, int bNoAdd,  local idx
	
	Ordlist_find_ex thismod, key, idx
	if ( stat == false ) {			// key がなかった
		if ( bNoAdd ) {
			idx = -1
		} else {
			Ordlist_addv_byIndex thismod, key, idx
		}
	}
	
	return idx
	
//------------------------------------------------
// 値を検索する
// @private
//------------------------------------------------
#modfunc Ordlist_find_ex@abdata_ordlist var key, var idx, int bNoAdd,  local size, local iMin, local iMax, local nCmp, local bExists, local vTemp
	
	size = Ordlist_size(thismod)
	iMin = 0
	iMax = size
	idx  = size / 2
	
	bExists = false
	
	repeat
		if ( iMin == iMax ) {
			idx = iMin		// 一致した値
			break
		}
		
		Ordlist_getv_byIndex thismod, vTemp, idx
		
		if ( mVartype == HSPVAR_TYPE_STR ) {
			nCmp = ( vTemp != key )
		} else {
			nCmp = ( vTemp - key )
		}
		
		if ( nCmp == 0 ) {
			bExists = true
			break
			
		} else : if ( nCmp > 0 ) {
			iMax = idx
			
		} else /* : if ( nCmp < 0 ) */ {
			iMin = idx + 1
		}
		
		// 残りの中央にフォーカス
		idx = ( iMin + iMax ) / 2
	loop
	
	return bExists
	
#ifdef _DEBUG

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global Ordlist_dbglog(%1) Ordlist_dbglog_ %1, "%1"

#modfunc Ordlist_dbglog_ str _ident,  local ident
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	IterateBegin thismod, Ordlist, VAR_TEMP
		logmes VAR_TEMP
	IterateEnd
	
	logmes ""
	return
	
#else //defined(_DEBUG)

#define global Ordlist_dbglog(%1) :

#endif //defined_DEBUG)

#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	Ordlist_new    vSt, vartype("str")
	Ordlist_add    vSt, "hello, world!"
	Ordlist_add    vSt, "string"
	Ordlist_add    vSt, "double"
	Ordlist_dbglog vSt			// 昇順で出力される ( 'd' < 'h' < 's' )
	
	stop
	
#endif

#endif
