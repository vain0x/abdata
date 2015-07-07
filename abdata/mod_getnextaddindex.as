// ƒ‚ƒWƒ…[ƒ‹•Ï”‚É’Ç‰Á‚³‚ê‚é—v‘f”Ô†‚ğæ“¾

#ifndef IG_GET_NEXT_ADD_INDEX_AS
#define IG_GET_NEXT_ADD_INDEX_AS

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
