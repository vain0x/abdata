// ”z—ñƒVƒtƒgƒ‚ƒWƒ…[ƒ‹

#ifndef IG_MODULE_SHIFT_ARRAY_AS
#define IG_MODULE_SHIFT_ARRAY_AS

#module shift_array_mod

#define true 1
#define false 0
#define global stdarray_index_of_end (-127)

//------------------------------------------------
// ”z—ñ‹æŠÔ‚Ì³‹K‰»
// @private
//------------------------------------------------
#deffunc stdarray_regularize_range@shift_array_mod array self, array range,  local tmp
	if ( range(1) == stdarray_index_of_end ) { range(1) = length(self) }
	if ( range(0) > range(1) ) {
		range(0) = range(1)
	}
	return
	
//------------------------------------------------
// ‘}“ü ( “I‚Èˆ— )
//------------------------------------------------
#deffunc stdarray_insert_room array self, int idx,  local i
	
	// ‘}“ü‚³‚ê‚éêŠ‚ğ‹ó‚¯‚é
	for i, length(self), idx, -1
		self(i) = self(i - 1)
	next
	
	return
	
//------------------------------------------------
// íœ ( “I‚Èˆ— )
//------------------------------------------------
#deffunc stdarray_erase array self, int idx,  local i
	
	// íœ‚³‚ê‚éêŠ‚ğÁ‚· ( ‘¼‚Ì’l‚Åã‘‚«‚·‚é )
	for i, idx, length(self) - 1
		self(i) = self(i + 1)
	next
	
	return
	
//------------------------------------------------
// ˆÚ“®
//------------------------------------------------
#deffunc stdarray_loc_move array self, int from, int to,  local temp, local dir, local i
	if ( from == to ) { return }
	
	// ˆÚ“®Œ³‚Ì’l‚ğ•Û‘¶‚·‚é
	temp = self(from)
	
	// ˆÚ“®‚·‚é
	if ( from > to ) {
		dir = -1				// ã‚Éi‚Ş‚È‚ç -1
	} else {
		dir = 1
	}
	for i, from, to, dir
		self(i) = self(i + dir)	// Ÿ‚ÌêŠ‚Ì’l‚ğó‚¯æ‚é
	next
	self(to) = temp
	
	return
	
//------------------------------------------------
// ŒğŠ·
//------------------------------------------------
#deffunc stdarray_loc_swap array self, int pos1, int pos2,  local temp
	if ( pos1 == pos2 ) { return }
	temp       = self(pos1)
	self(pos1) = self(pos2)
	self(pos2) = temp
	return
	
//------------------------------------------------
// „‰ñ
// 
// @prm self
// @prm step         : „‰ñ•ûŒü
// @prm [iBgn, iEnd) : „‰ñ‘ÎÛ‚Ì‹æŠÔ
//------------------------------------------------
#deffunc stdarray_rotate_step array self, int iBgn, int iEnd, int dir,  local range
	range = iBgn, iEnd
	stdarray_regularize_range self, range
	
	if ( dir >= 0 ) {
		stdarray_loc_move self, range(0), range(1) - 1
	} else {
		stdarray_loc_move self,           range(1) - 1, range(0)
	}
	return
	
// ‹t‰ñ“]
#define global stdarray_rotate(    %1, %2 = 0, %3 = stdarray_index_of_end) stdarray_rotate_step %1, %2, %3,  1
#define global stdarray_rotateBack(%1, %2 = 0, %3 = stdarray_index_of_end) stdarray_rotate_step %1, %2, %3, -1

//------------------------------------------------
// ”½“]
// 
// @prm this
// @prm [iBgn, iEnd) : ”½“]‘ÎÛ‚Ì‹æŠÔ
//------------------------------------------------
#define global stdarray_reverse(%1, %2 = 0, %3 = stdarray_index_of_end) stdarray_reverse_ %1, %2, %3
#deffunc stdarray_reverse_ array self, int iBgn, int iEnd,  local range
	range = iBgn, iEnd
	stdarray_regularize_range self, range
	
	repeat (range(1) - range(0)) / 2
		stdarray_loc_swap self, range(0) + cnt, range(1) - cnt - 1
	loop
	
	return
	
#global

#endif
