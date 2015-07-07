// Algorithm::Sort 整列

#ifndef __ABSTRACT_DATA_STRUCTURE_ALGORITHM_SORT_AS__
#define __ABSTRACT_DATA_STRUCTURE_ALGORITHM_SORT_AS__

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
#define gloal abdata_sort(%1,%2,%3=SortOrder_Ascending) "未実装"
	
//##############################################################################
//        サンプル・スクリプト
//##############################################################################
#if 1

#include "Mo/Dmath.as"
#include "list.as"
	
	// とりあえず要素追加
	List_new slist
	repeat 10
		List_push_back slist, pow_i(-3, cnt)	;, strf("#%02d value;", 10 - cnt)
	loop
	
	List_dbglog slist
	logmes ""
	
	abdata_sort slist, List, SortOrder_Ascending
	
	List_dbglog slist
	
	stop
	
#endif

#endif
