// モジュール変数に追加される要素番号を取得

#ifndef IG_GET_NEXT_ADD_INDEX_AS
#define IG_GET_NEXT_ADD_INDEX_AS

#module

#defcfunc GetNextAddIndex array ary,  local n
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
