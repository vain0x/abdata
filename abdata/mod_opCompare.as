// ”äŠr‰‰ŽZ

#ifndef IG_MODULE_OPERATION_COMPARE_AS
#define IG_MODULE_OPERATION_COMPARE_AS

#module

//------------------------------------------------
// ˆê”Ê“I‚È”äŠr‰‰ŽZ
// 
// @(condition): lhs, rhs ‚ÌŒ^‚Íˆê’v‚·‚é
//------------------------------------------------
#defcfunc opCompare var lhs, var rhs
	if ( vartype(lhs) == 2 /* vartype("str") */ ) {
		return (lhs != rhs)
	} else {
		if ( lhs < rhs ) {
			return -1
		} else : if ( lhs > rhs ) {
			return 1
		} else {
			return 0
		}
	}

#global

#endif
