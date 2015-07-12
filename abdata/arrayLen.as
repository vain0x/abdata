#ifndef IG_ABDATA_ARRAY_LEN_AS
#define IG_ABDATA_ARRAY_LEN_AS

// 長さ指定つきの1次元標準配列

#include "mod_opCompare.as"

#module arrayLen

#define true 1
#define false 0
#define int_max 0x7FFFFFFF
	
#defcfunc arrayLen_is_valid_len array self, int len
	return (0 <= len && len <= length(self))
	
/**
* arrayLen の消去
//*/
#deffunc arrayLen_clear array self, var len
	dim self
	len = 0
	return
	
/**
* arrayLen の複写
//*/
#deffunc arrayLen_copy array self, var len, array target, int target_len
	arrayLen_clear self, len
	arrayLen_chain self, len, target, target_len
	return
	
/**
* arrayLen の連結
//*/
#deffunc arrayLen_chain array self, var len, array target, int target_len
	repeat target_len
		self(len + cnt) = target(cnt)
	loop
	len += target_len
	return
	
/**
* arrayLen の交換
//*/
#deffunc arrayLen_swap array self, var len, array target, var target_len, \
	local tmp, local tmp_len
	
	arrayLen_copy tmp, tmp_len,       self, len
	arrayLen_copy self, len,          target, target_len
	arrayLen_copy target, target_len, tmp, tmp_len
	return
	
/**
* arrayLen の、idx 番目を空ける (初期化なし)
//*/
#deffunc arrayLen_insert_no_init array self, var len, int idx
	assert arrayLen_is_valid_len(self, len)
	assert idx >= 0
	if( idx < len ) {
		repeat len - idx
			self(len - cnt) = self(len - cnt - 1)
		loop
		len ++
	} else {
		self(idx) = self(0)
		len += idx - len + 1
	}
	return
	
/**
* arrayLen の、[lb, ub) 番目の要素を除去する
//*/
#deffunc arrayLen_erase_range array self, var len, int lb, int ub
	assert arrayLen_is_valid_len(self, len)
	assert 0 <= lb && lb <= len
	assert 0 <= ub && ub <= len
	repeat len - ub
		self(lb + cnt) = self(ub + cnt)
	loop
	len -= ub - lb
	return
	
/**
* arrayLen が、昇順に整列済みであるか否か
*
* つまり self(0) <= self(1) <= ... となっていること。
*
* @param self: 対象の配列
* @param len: self の長さ
//*/
#defcfunc arrayLen_is_sorted array self, int len,  local is_sorted
	assert arrayLen_is_valid_len(self, len)
	is_sorted = true
	repeat limit(0, len - 1, int_max)
		if ( opCompare(self(cnt), self(cnt + 1)) > 0 ) {
			is_sorted = false : break
		}
	loop
	return is_sorted
	
/**
* 整列済み arrayLen の、下界をみつける
*
* @param self: 対象の配列
* @param len: self の長さ
* @param value: 探す値
* @return i:
*	もし self(i) == value となる要素があれば、その最小の i が返る。
*	それがなければ、self(i) > value となる最小の i が返る。
*	それもなければ、len が返る。
//*/
#defcfunc arrayLen_lower_bound array self, int len, var value, \
	local lb, local ub, local mid, local cmp
	
	assert arrayLen_is_sorted(self, len)
	
	lb = -1 : ub = len
	repeat
		if ( (ub - lb) <= 1 ) { break }
		mid = lb + (ub - lb) / 2
		if ( opCompare(self(mid), value) < 0 ) {
			lb = mid
		} else {
			ub = mid
		}
	loop
	return ub
	
/**
* 整列済み arrayLen の、上界をみつける
*
* @param value: 探す値
* @return i:
*	self(k) > value となる要素があれば、そのような k の最小値が返る。
*	なければ、len が返る。
//*/
#defcfunc arrayLen_upper_bound array self, int len, var value, \
	local lb, local ub, local mid, local cmp
	
	assert arrayLen_is_sorted(self, len)
	
	lb = -1 : ub = len
	repeat
		if ( (ub - lb) <= 1 ) { break }
		mid = lb + (ub - lb) / 2
		if ( opCompare(self(mid), value) <= 0 ) {
			lb = mid
		} else {
			ub = mid
		}
	loop
	return ub
	
/**
* 整列済み arrayLen の、ある値を含む区間をみつける
*
* 「(lb <= k && k < ub) をみたすすべての k について、self(k) == value」となるような、lb, ub がみつかる。
*
* @param value: 探す値
* @param lb, ub
*	arrayLen_lower_bound, _upper_bound の値が代入される。
//*/
#deffunc arrayLen_equal_range array self, int len, var value, var lb, var ub
	lb = arrayLen_lower_bound(self, len, value)
	ub = arrayLen_upper_bound(self, len, value)
	return
	
/**
* 整列済み arrayLen が含む、ある値の個数を返す
*
* @param value: 探す値
//*/
#defcfunc arrayLenSorted_count array self, int len, var value,  local lb, local ub
	lb = arrayLen_lower_bound(self, len, value)
	if ( lb != len ) : if ( self(lb) == value ) {
		ub = arrayLen_upper_bound(self, len, value)
		return ub - lb
	}
	return 0
	
/**
* 整列済み arrayLen の、適切な位置に要素を挿入する
*
* @param value: 挿入される要素の値
* @param can_dup (true):
*	これが真なら、すでに value が含まれているときも、挿入する。
* @return n:
*	挿入された要素の個数
//*/
#define global arrayLenSorted_insert_v(%1, %2, %3, %4 = true@arrayLen) \
	_arrayLenSorted_insert_v@arrayLen (%1), (%2), (%3), (%4)

#deffunc _arrayLenSorted_insert_v@arrayLen \
	array self, var len, var value, int can_dup,  local lb
	
	lb = arrayLen_lower_bound(self, len, value)
	if ( can_dup == false && lb != len ) {
		if ( self(lb) == value ) { return 0 }
	}
	arrayLen_insert_no_init self, len, lb
	self(lb) = value
	return 1
	
/**
* 整列済み arrayLen から、要素を除去する
*
* @param value: 除去すべき要素の値
* @param max_count (∞): 除去される要素の個数の最大値
* @return n:
*	除去された要素の個数
//*/
#define global arrayLenSorted_erase_v(%1, %2, %3, %4 = int_max@arrayLen) \
	_arrayLenSorted_erase_v@arrayLen (%1), (%2), (%3), (%4)
	
#deffunc _arrayLenSorted_erase_v@arrayLen \
	array self, var len, var value, int max_count,  local ran
	
	arrayLen_equal_range self, len, value, ran(0), ran(1)
	ran(1) = ran(0) + limit(ran(1) - ran(0), 0, max_count)
	arrayLen_erase_range self, len, ran(0), ran(1)
	return ran(1) - ran(0)
	
#global

#endif
