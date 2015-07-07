// モジュール変数に追加される要素番号を取得

#ifndef __GET_NEXT_ADD_INDEX_AS__
#define __GET_NEXT_ADD_INDEX_AS__

#module gnai_mod

#defcfunc GetNextAddIndex array ary
	n = -1
	repeat length(ary)
		if ( varuse(ary(cnt)) == 0 ) {
			n = cnt
			break
		}
	loop
	if ( n < 0 ) {
		n = length(ary)
	}
	return n
	
#global

#endif
