// ”z—ñƒVƒtƒgƒ‚ƒWƒ…[ƒ‹

#ifndef __MODULE_SHIFT_ARRAY_AS__
#define __MODULE_SHIFT_ARRAY_AS__

#module shift_array_mod

//------------------------------------------------
// ‘}“ü ( “I‚Èˆ— )
//------------------------------------------------
#deffunc ArrayInsert array arr, int idx
	
	// ‘}“ü‚³‚ê‚éêŠ‚ð‹ó‚¯‚é
	for i, length(arr), idx, -1
		arr(i) = arr(i - 1)
	next
	
	return
	
//------------------------------------------------
// íœ ( “I‚Èˆ— )
//------------------------------------------------
#deffunc ArrayRemove array arr, int idx
	
	// íœ‚³‚ê‚éêŠ‚ðÁ‚· ( ‘¼‚Ì’l‚Åã‘‚«‚·‚é )
	for i, idx, length(arr) - 1
		arr(i) = arr(i + 1)
	next
	
	return
	
//------------------------------------------------
// ˆÚ“®
//------------------------------------------------
#deffunc ArrayMove array arr, int from, int to,  local temp
	if ( from == to ) { return }
	
	// ˆÚ“®Œ³‚Ì’l‚ð•Û‘¶‚·‚é
	temp = arr(from)
	
	// ˆÚ“®‚·‚é
	if ( from > to ) {
		dir = -1				// ã‚Éi‚Þ‚È‚ç -1
	} else {
		dir = 1
	}
	for i, from, to, dir
		arr(i) = arr(i + dir)	// ŽŸ‚ÌêŠ‚Ì’l‚ðŽó‚¯Žæ‚é
	next
	arr(to) = temp
	
	return
	
//------------------------------------------------
// ŒðŠ·
//------------------------------------------------
#deffunc ArraySwap array arr, int pos1, int pos2,  local temp
	if ( pos1 == pos2 ) { return }
	temp      = arr(pos1)
	arr(pos1) = arr(pos2)
	arr(pos2) = temp
	return
	
//------------------------------------------------
// „‰ñ
//------------------------------------------------
#deffunc ArrayRotate array arr, int step,  local temp
	if ( step >= 0 ) {
		ArrayMove arr, 0, length(arr) - 1
	} else {
		ArrayMove arr,    length(arr) - 1, 0
	}
	return
	
// ‹t‰ñ“]
#define global ArrayRotateBack(%1) ArrayRotate %1, -1

//------------------------------------------------
// ”½“]
//------------------------------------------------
#define global ArrayReverse(%1,%2=-1) ArrayReverse_ %1,%2
#deffunc ArrayReverse_ array arr, int _lenArray,  local lenArray
	if ( _lenArray < 0 ) {
		lenArray = length(arr)
	} else {
		lenArray = _lenArray
	}
	
	repeat lenArray / 2
		ArraySwap arr, cnt, lenArray - cnt - 1
	loop
	
	return
	
#global

//##############################################################################
//                ƒTƒ“ƒvƒ‹EƒXƒNƒŠƒvƒg
//##############################################################################
#if 0

#module
#define global output(%1,%2) _output %1, %2, "%2"
#deffunc _output str ps1, array pa2, str ps3
	mes ps1
	foreach pa2
		mes ps3 + strf("(%d) = ", cnt) + pa2(cnt)
	loop
	return
#global

	dim a, 6
	
	// ‰Šú’l‚ðÝ’è‚·‚é
	foreach a
		a(cnt) = cnt
	loop
	
	//######## —v‘f‚Ì‘}“ü ###########################
	// ‘}“üæ‚Ì”Ô†
	p = 0
	
	ArrayInsert a, p
	
	// ‘}“ü‚·‚é
	a(p) = 100
	
	// •\Ž¦
	pos 20, 20
	output "Array Insert", a
	
	//######## —v‘f‚ÌˆÚ“® ###########################
	p = 3	// ˆÚ“®Œ³‚Ì”Ô†
	t = 1	// ˆÚ“®æ‚Ì”Ô†
	
	ArrayMove a, p, t
	
	// •\Ž¦
	pos 140, 20
	output "Array Move", a
	
	//######## —v‘f‚ÌŒðŠ· ###########################
	// ŒðŠ·‚·‚é—v‘f‚Q‚Â
	p = 4, 2
	
	ArraySwap a, p(0), p(1)
	
	// •\Ž¦
	pos 260, 20
	output "Array Swap", a
	
	//######## —v‘f‚Ì„‰ñ ###########################
	ArrayRotate a
	
	// •\Ž¦
	pos 380, 20
	output "Array Rotate", a
	
	//######## —v‘f‚Ìíœ ###########################
	// íœ‚·‚é”Ô†
	p = 3
	
	ArrayRemove a, p
	
	// •\Ž¦
	pos 500, 20
	output "Array Remove", a		// (5) ‚Ííœ‚³‚ê‚½ŽcŠ[
	
	stop
	
#endif

#endif
