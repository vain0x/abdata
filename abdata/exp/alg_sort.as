#ifndef IG_ABDATA_ALGORITHM_SORT_AS
#define IG_ABDATA_ALGORITHM_SORT_AS

// 整列アルゴリズム
// 未実装

#include "alg_iter.as"

#module abdata_sort_mod

#global

//------------------------------------------------
// enum 整列順序
//------------------------------------------------
#enum global SortOrder_Ascending = 0	// 昇順
#enum global SortOrder_Descending		// 降順

//------------------------------------------------
// マクロ群
//------------------------------------------------
#define global abdata_sort(%1, %2, %3 = SortOrder_Ascending) !{"abdata_sort は未実装です"}!

//##############################################################################
//        サンプル・スクリプト
//##############################################################################
#if 1

#include "Mo/Dmath.as"
#include "list.as"
	
	// とりあえず要素追加
	list_new slist
	repeat 10
		List_add slist, pow_i(-3, cnt)	;, strf("#%02d value;", 10 - cnt)
	loop
	
	list_dbglog slist
	logmes ""
	
	abdata_sort slist, list, SortOrder_Ascending
	
	list_dbglog slist
	
	stop
	
#endif

#endif
