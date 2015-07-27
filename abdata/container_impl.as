#ifndef IG_ABDATA_CONTAINER_IMPL_AS
#define IG_ABDATA_CONTAINER_IMPL_AS

#include "abheader.as"
#include "abelem.as"
#include "mod_shiftArray.as"
#include "mod_pvalptr.as"
#include "mod_swap.as"
#include "mod_ref.as"

#module abdata_con_impl mCnt, mElems, midlist
; abdata_container_impl は識別子長の限界を超えているため

#define ctype ARG_TEMP(%1) con_impl_argtmp_%1@__abdata

#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0
#define int_max 0x7FFFFFFF

#define ctype STR_ERR_OVER_RANGE(%1) "Error! [abdata コンテナ] 要素番号範囲外エラー(" + (%1) + ")"

#enum global SortMode_Ascending = 0		// 昇順
#enum global SortMode_Decending = 1

#define global containerImpl_new(%1, %2 = 0, %3 = stt_zero@) newmod %1, abdata_con_impl@, %2, %3
#define global containerImpl_delete(%1) delmod %1

//------------------------------------------------
// [i] 構築
// 
// @prm num      : num 個の要素を既に確保した状態で生成する。
// @prm vDefault : 確保する値の初期値
//------------------------------------------------
#modinit int num, var vDefault
	if ( num <= 0 ) {
		dimtype mElems, 5
		
	} else {
		repeat num
			abelem_new mElems, vDefault
			midlist(cnt) = cnt
			mCnt ++
		loop
	}
	
	return getaptr(thismod)
	
//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
#modfunc containerImpl_getv_ var result, int _i, int bRemove,  local i
	
	i = containerImpl_getRealIndex(thismod, _i)
	
	abelem_getv mElems( midlist(i) ), result
	
	if ( bRemove ) {
		containerImpl_erase thismod, i
	}
	
	return
	
#define global containerImpl_getv(%1,%2,%3=0) containerImpl_getv_ %1, %2, %3, 0
#define global containerImpl_popv(%1,%2,%3=0) containerImpl_getv_ %1, %2, %3, 1

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc containerImpl_get_ int i, int bRemove,  local tmp
	containerImpl_getv_ thismod, tmp, i, bRemove
	return tmp
	
#define global ctype containerImpl_get(%1,%2=0) containerImpl_get_(%1, %2, 0)
#define global ctype containerImpl_pop(%1,%2=0) containerImpl_get_(%1, %2, 1)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
#modfunc containerImpl_clone var vRef, int i
	abelem_clone mElems( midlist( containerImpl_getRealIndex(thismod, i) ) ), vRef
	return
	
#modfunc containerImpl_clone_abelem var ref, int i
	dup ref, mElems(midlist(i))
	return
	
//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype containerImpl_ref(%1, %2) \
	ref_ref_expr_template_2(containerImpl_ref_, %1, %2)

#modcfunc containerImpl_ref_ array ref, int i
	containerImpl_clone thismod, ref, i
	return 0
	
//------------------------------------------------
// 先頭・末尾の値の取得
// 
// @ get 処理 >> const な操作
// @ pop 処理 >> 要素は取り除かれる
//------------------------------------------------
#define global ctype containerImpl_get_front(%1)     containerImpl_get(%1, 0)
#define global ctype containerImpl_get_back(%1)      containerImpl_get(%1, -1)
#define global       containerImpl_getv_front(%1,%2) containerImpl_getv %1, %2, 0
#define global       containerImpl_getv_back(%1,%2)  containerImpl_getv %1, %2, -1
#define global ctype containerImpl_pop_front(%1)     containerImpl_pop(%1, 0)
#define global ctype containerImpl_pop_back(%1)      containerImpl_pop(%1, -1)
#define global       containerImpl_popv_front(%1,%2) containerImpl_popv %1, %2, 0
#define global       containerImpl_popv_back(%1,%2)  containerImpl_popv %1, %2, -1

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
#modcfunc containerImpl_vartype int i
	return abelem_vartype( mElems(midlist(containerImpl_getRealIndex(thismod, i))) )
	
#define global ctype containerImpl_vartype_front(%1) containerImpl_vartype(%1, 0)
#define global ctype containerImpl_vartype_back(%1)  containerImpl_vartype(%1, -1)

//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global containerImpl_set(%1,%2,%3=0) ARG_TEMP@abdata_con_impl(set) = %2 : containerImpl_setv %1, ARG_TEMP@abdata_con_impl(set), %3
#modfunc containerImpl_setv var vValue, int i,  local iv
	
	iv = midlist( containerImpl_getRealIndex(thismod, i) )
	
	// 適切に型を変換する
	abelem_changeVartype mElems(iv), vartype(vValue)
	
	abelem_setv mElems( iv ), vValue
	
	return
	
//------------------------------------------------
// 挿入
// 
// @permit (i == mCnt) : 最後尾への追加のため
// @ i が範囲外 => {
// @	( i <     0 ) => i += mCnt,
// @	( i >= mCnt ) => ([i] まで要素を自動拡張)
// @ };
//------------------------------------------------
#define global containerImpl_insert(%1,%2,%3=0) ARG_TEMP@abdata_con_impl(insert) = %2 : containerImpl_insertv %1, ARG_TEMP@abdata_con_impl(insert), %3
#modfunc containerImpl_insertv var vValue, int _i,  local i, local id
	i = _i
	if ( _i < 0 ) {
		i += mCnt
	} else : if ( _i > mCnt ) {
		logmes "abdata 要素を自動拡張 [" + mCnt + ", " + _i + "]"
		repeat _i - mCnt, mCnt
			containerImpl_insertv thismod, stt_zero@, cnt
		loop
		i = _i
	} else {
		i = _i
	}
	
	// i 番目を空ける
	stdarray_insert_room midlist, i
	
	// 新規値を追加
;	id         = GetNextAddIndex( mElems )
	abelem_new mElems, vValue
	midlist(i) = stat	;id
	mCnt ++
	
	return
	
//------------------------------------------------
// 要素の倍化
//------------------------------------------------
#modfunc containerImpl_double int _i,  local i, local temp
	i = containerImpl_getRealIndex( thismod, _i )
	
	containerImpl_getv    thismod, temp, i
	containerImpl_insertv thismod, temp, i
	return
	
//------------------------------------------------
// 先頭・最後尾への追加
//------------------------------------------------
#define global containerImpl_double_front(%1)   containerImpl_double  %1, 0
#define global containerImpl_double_back(%1)    containerImpl_double  %1, (-1)
#define global containerImpl_push_front(%1,%2)  containerImpl_insert  %1, %2, 0
#define global containerImpl_pushv_front(%1,%2) containerImpl_insertv %1, %2, 0
#define global containerImpl_push_back(%1,%2)   containerImpl_insert  %1, %2, containerImpl_size(%1)
#define global containerImpl_pushv_back(%1,%2)  containerImpl_insertv %1, %2, containerImpl_size(%1)
#define global containerImpl_push               containerImpl_push_back
#define global containerImpl_pushv              containerImpl_pushv_back
#define global containerImpl_add                containerImpl_push_back

//------------------------------------------------
// 除去
//------------------------------------------------
#modfunc containerImpl_erase int _i,  local i
	i = containerImpl_getRealIndex(thismod, _i)
	containerImpl_erase_range thismod, i, i + 1
	return
	
#define global containerImpl_erase_front(%1) containerImpl_erase %1, 0
#define global containerImpl_erase_back(%1)  containerImpl_erase %1, (-1)

#modfunc containerImpl_erase_range int lb, int ub
	if ( ub <= lb ) { return }
	repeat mCnt - ub, lb
		if ( cnt < ub ) {
			abelem_delete mElems(midlist(cnt))
		}
		midlist(cnt) = midlist(cnt + (ub - lb))
	loop
	mCnt -= (ub - lb)
	return
	
//------------------------------------------------
// 要素数の設定
// 
// @result: 元の要素数
//------------------------------------------------
#define global containerImpl_resize(%1, %2, %3) \
	containerImpl_resize_ (%1), (%2), (%3)

#modfunc containerImpl_resize_ int newlen, var initValue,  local dif
	dif = newlen - mCnt
	
	// 減少
	if ( dif < 0 ) {
		if ( newlen <= 0 ) {
			containerImpl_clear thismod
			
		} else {
			// 要素 [newlen] 以降を除去
			repeat -dif, newlen
				abelem_delete mElems( midlist(cnt) )
				midlist(cnt) = -1		// 無効要素にする
			loop
		}
		
	// 増加
	} else : if ( dif > 0 ) {
		// 新要素を dif 個生成し、末尾に追加する
		repeat dif, newlen - dif
			abelem_new mElems, initValue
			midlist(cnt) = stat	;id
		loop
	}
	
	mCnt = newlen
	return newlen - dif
	
//------------------------------------------------
// 移動
//------------------------------------------------
#modfunc containerImpl_loc_move int iSrc, int iDst
	abAssert ( containerImpl_size(thismod) >= 2 ), "move には少なくとも2要素が必要"		// 最低でも2つの要素がないと、move は意味がない
	
	stdarray_loc_move midlist, containerImpl_getRealIndex(thismod, iSrc), containerImpl_getRealIndex(thismod, iDst)
	return
	
//------------------------------------------------
// 交換
//------------------------------------------------
#modfunc containerImpl_loc_swap int iPos1, int iPos2
	abAssert ( containerImpl_size(thismod) >= 2 ), "swap には少なくとも2要素が必要"		// 最低でも2つの要素がないと、swap は意味がない
	
	stdarray_loc_swap midlist, containerImpl_getRealIndex(thismod, iPos1), containerImpl_getRealIndex(thismod, iPos2)
	return
	
#define global containerImpl_loc_swap_front(%1) containerImpl_loc_swap %1,  0,  1
#define global containerImpl_loc_swap_back(%1)  containerImpl_loc_swap %1, -2, -1

//------------------------------------------------
// 巡回
//------------------------------------------------
#modfunc containerImpl_rotateImpl int iBgn, int _iEnd, int dir,  local iEnd
	if ( _iEnd == stdarray_index_of_end ) { iEnd = containerImpl_size(thismod) } else { iEnd = _iEnd }
	stdarray_rotate_step midlist, iBgn, iEnd, dir
	return
	
#define global containerImpl_rotate(     %1, %2 = 0, %3 = stdarray_index_of_end) containerImpl_rotateImpl %1, %2, %3,  1
#define global containerImpl_rotate_back(%1, %2 = 0, %3 = stdarray_index_of_end) containerImpl_rotateImpl %1, %2, %3, -1

//------------------------------------------------
// 反転
//------------------------------------------------
#define global containerImpl_reverse(%1, %2 = 0, %3 = stdarray_index_of_end) containerImpl_reverse_ %1, %2, %3
#modfunc containerImpl_reverse_ int iBgn, int _iEnd,  local iEnd
	if ( _iEnd == stdarray_index_of_end ) { iEnd = containerImpl_size(thismod) } else { iEnd = _iEnd }
	stdarray_reverse midlist, iBgn, iEnd
	return
	
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#modfunc containerImpl_clear
	
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
#modfunc containerImpl_chain var src,  local tmp, local offset
	offset = mCnt
 	repeat containerImpl_size( src )
		containerImpl_getv       src, tmp, cnt
		containerImpl_insert thismod, tmp, cnt + offset
	loop
	return
	
//------------------------------------------------
// [i] 複写
//------------------------------------------------
#modfunc containerImpl_copy var src
	containerImpl_clear thismod
	containerImpl_chain thismod, src
	return
	
//------------------------------------------------
// [i] 交換
//------------------------------------------------
#modfunc containerImpl_swap var rhs
	containerImpl_swap_impl@abdata_con_impl rhs, mCnt, mElems, midlist
	return
	
#modfunc containerImpl_swap_impl@abdata_con_impl array lhs_cnt, array lhs_elems, array lhs_idlist
	swap_int   mCnt,    lhs_cnt
	swap_array mElems,  lhs_elems
	swap_array midlist, lhs_idlist
	return
	
//------------------------------------------------
// 辞書順比較
//------------------------------------------------
#modcfunc containerImpl_lexicographical_compare var rhs
	return containerImpl_lexicographical_compare_impl@abdata_con_impl(rhs, mCnt, mElems, midlist)
	
#modcfunc containerImpl_lexicographical_compare_impl@abdata_con_impl int lhs_size, array lhs_elems, array lhs_idlist, \
	local cmp
	
	if ( lhs_size != mCnt ) {
		return lhs_size - mCnt
	}
	repeat lhs_size
		cmp = abelem_cmp(lhs_elems(lhs_idlist(cnt)), mElems(midlist(cnt)))
		if ( cmp != 0 ) { break }
	loop
	return cmp
	
//------------------------------------------------
// 整列
// 
// @alg: (based: Merge-Sort)
// @	1. 型タイプ値で整列
// @	2. 同じ型 => 不等号による比較で整列
// @prm mode : SortMode_* (default: SortMode_Ascening)
//------------------------------------------------
#modfunc containerImpl_sort int mode,  \
	local arrTmp, local arrDst, local len, \
	local p, local p1, local e1, local p2, local e2, local sizeSegment, local sizeSegMerged, \
	local cmp
	
	len = containerImpl_size(thismod)
	dim     arrDst, len
	foreach arrDst
		arrDst(cnt) = cnt
	loop
	
	dim arrTmp, len
	
	// マージソート
	repeat
		sizeSegment = 1 << cnt		// 1, 2, 4, 8, ...
		
		// 2-Segment ごとにマージ
		repeat
			p  = sizeSegment * (cnt * 2)	// 2-Segment の先頭
			p1 = p							// lhs (left hand segment) 範囲 (先頭要素)
			e1 = p1 + sizeSegment			// 〃 (最終要素 + 1)
			p2 = e1							// rhs
			e2 = limit( p2 + sizeSegment, 0, len )
			sizeSegMerged = (e2 - p)		// マージ後の Segment サイズ
			
			if ( sizeSegMerged < sizeSegment ) { break }	// 閾値以下 => マージせず終了
			
			repeat sizeSegMerged
				if ( p2 >= e2 ) {			// rhs の取り出しが既に完了している
					arrTmp(cnt) = arrDst(p1) : p1 ++
				} else : if ( p1 >= e1 ) {	// lhs 〃
					arrTmp(cnt) = arrDst(p2) : p2 ++
				} else {
					// ?( 一致する or ( 左が小さく(真) 昇順(真) || 右が小さく(偽) 降順(偽) ) ) => lhs からとる
					cmp = abelem_cmp( mElems(arrDst(p1)), mElems(arrDst(p2)) )
					if ( cmp == 0 || ( (cmp < 0) == (mode == SortMode_Ascending) ) ) {
						arrTmp(cnt) = arrDst(p1) : p1 ++
					} else {
						arrTmp(cnt) = arrDst(p2) : p2 ++
					}
				}
			loop
			
			// マージされた配列をソース配列に貼り付け
			memcpy arrDst(p), arrTmp, sizeSegMerged * 4
		loop
		
		// マージ終了 (1つの Segment に纏まったため)
		if ( len <= sizeSegment ) { break }
	loop
	
	// idx-list を変更
	memcpy midlist, arrDst, len * 4
	
	return
	
//------------------------------------------------
// 整列済みか？
//------------------------------------------------
#modcfunc containerImpl_is_sorted int sort_mode,  local is_sorted,  local clone1, local clone2
	is_sorted = true
	repeat limit(0, mCnt - 1, int_max)
		containerImpl_clone thismod, clone1, cnt
		containerImpl_clone thismod, clone2, cnt + 1
		if ( opCompare(clone1, clone2) * (1 - 2 * sort_mode) > 0 ) {
			is_sorted = false : break
		}
	loop
	return is_sorted
	
//------------------------------------------------
// 整列済みコンテナの、下界・上界をみつける
//------------------------------------------------
#modcfunc containerImpl_lu_bound_@abdata_con_impl var value, int sort_mode, int finds_upper, \
	local lb, local ub, local mid, local mid_clone, local cmp
	
	assert containerImpl_is_sorted(thismod, sort_mode)
	lb = -1 : ub = mCnt
	repeat
		if ( (ub - lb) <= 1 ) { break }
		mid = lb + (ub - lb) / 2
		containerImpl_clone thismod, mid_clone, mid
		
		cmp = opCompare(mid_clone, value) * (1 - 2 * sort_mode)
		if ( ((finds_upper != 0) && cmp == 0) || cmp < 0 ) {
			lb = mid
		} else {
			ub = mid
		}
	loop
	return ub
	
#define global ctype containerImpl_lower_bound(%1, %2, %3 = SortMode_Ascending) containerImpl_lu_bound_@abdata_con_impl((%1), (%2), (%3), 0)
#define global ctype containerImpl_upper_bound(%1, %2, %3 = SortMode_Ascending) containerImpl_lu_bound_@abdata_con_impl((%1), (%2), (%3), 1)

#modfunc containerImpl_equal_range var value, var lb, var ub, int sort_mode
	lb = containerImpl_lower_bound(thismod, value, sort_mode)
	ub = containerImpl_upper_bound(thismod, value, sort_mode)
	return
	
//------------------------------------------------
// 整列済みコンテナの、適切な位置に要素を挿入する
//
// @param value: 挿入される要素の値
// @param can_dup (true):
// これが真なら、すでに value が含まれているときも、挿入する。
//------------------------------------------------
#define global containerImpl_sorted_insertv(%1, %2, %3 = true@abdata_con_impl, %4 = SortMode_Ascending) \
	containerImpl_sorted_insertv_@abdata_con_impl (%1), (%2), (%3), (%4)

#modfunc containerImpl_sorted_insertv_@abdata_con_impl \
	var value, int can_dup, int sort_mode,  \
	local lb, local clone
	
	lb = containerImpl_lower_bound(thismod, value, sort_mode)
	if ( can_dup == false && lb != containerImpl_size(thismod) ) {
		containerImpl_clone thismod, clone, lb
		if ( opCompare(clone, value) == 0 ) { return }
	}
	containerImpl_insertv thismod, value, lb
	return
	
//------------------------------------------------
// 整列済みコンテナから、要素を除去する
//
// @param value: 除去すべき要素の値
// @param max_count (∞): 除去される要素の個数の最大値
//------------------------------------------------
#define global containerImpl_sorted_erasev(%1, %2, %3 = int_max@abdata_con_impl, %4 = SortMode_Ascending) \
	containerImpl_sorted_erasev_@abdata_con_impl (%1), (%2), (%3), (%4)
	
#modfunc containerImpl_sorted_erasev_@abdata_con_impl \
	var value, int max_count, int sort_mode,  \
	local lb, local ub
	
	containerImpl_equal_range thismod, value, lb, ub, sort_mode
	ub = lb + limit(ub - lb, 0, max_count)
	containerImpl_erase_range thismod, lb, ub
	return
	
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#modfunc containerImpl_iter_init var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#modcfunc containerImpl_iter_next var vIt, var iterData
	iterData ++
	
	if ( containerImpl_is_valid(thismod, iterData) == false ) {
		return false
	}
	
	containerImpl_getv thismod, vIt, iterData
	return true
	
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc containerImpl_size
	return mCnt
	
#define global containerImpl_length containerImpl_size
#define global ctype containerImpl_empty(%1) ( containerImpl_size(%1) == 0 )

//------------------------------------------------
// 数え上げ
//------------------------------------------------
#modcfunc containerImpl_count var value,  local count, local ref
	repeat mCnt
		containerImpl_clone thismod, ref, cnt
		if ( ref == value ) { count ++ }
	loop
	return count

//------------------------------------------------
// 範囲チェック
//------------------------------------------------
#modcfunc containerImpl_is_valid int i
	if ( numrg(i, 0, mCnt - 1) ) {					// 有効範囲か
		if ( varuse( mElems(midlist(i)) ) ) {		// 有効な要素番号か
			return true
		}
	}
	return false
	
//------------------------------------------------
// 実際の要素番号を得る
// @private
//------------------------------------------------
#modcfunc containerImpl_getRealIndex@abdata_con_impl int _i,  local i
	i = _i
	
	// 循環参照
	if ( i < 0 ) {
		i += mCnt
	}
	
	abAssert ( 0 <= i && i < mCnt ), STR_ERR_OVER_RANGE(i)
	
	return i
	
#ifdef _DEBUG

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global containerImpl_dbglog(%1) containerImpl_dbglog_ %1, "%1"

#modfunc containerImpl_dbglog_ str _ident,  local ident
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	repeat containerImpl_size(thismod)
		logmes strf("#%2d: ", cnt) + containerImpl_get(thismod, cnt)
	loop
	
	logmes ""
	return
	
#else //defined(_DEBUG)

#define global containerImpl_dbglog(%1) :

#endif //defined(_DEBUG)
	
#global

#endif

/******
	
＠ index 管理
	すべての要素は mElems に、無ソートの状態で保持する。
	@ mElems の要素番号(idx)は変更されないので、実質的に参照(弱)として機能する。
	リスト内での要素の順序は、int配列 midlist が持つ mElems への参照の順番が表す。
	@ midlist には mElems の要素番号 (参照) を格納する。
	@ つまり、このリストの要素 [i] は mElems[ midlist[i] ] で参照できる。
	@ mElems の要素番号を「実体インデックス」(RealIndex),
	@	midlist の要素番号を「要素インデックス」(ElemIndex)という。
	
	swap や insert は、midlist の数値の順番を変更するだけで、mElems 自体は動かさないので、
	比較的軽い処理である。
	@ インデックス・ソート (index sort)
	
******/
