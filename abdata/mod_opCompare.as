#ifndef IG_MODULE_OPERATION_COMPARE_AS
#define IG_MODULE_OPERATION_COMPARE_AS

#module

//------------------------------------------------
// ˆê”Ê“I‚È”äŠr‰‰ŽZ
//------------------------------------------------
#defcfunc opCompare var lhs, var rhs
	assert vartype(lhs) == vartype(rhs)
	if ( vartype(lhs) == 2 /* vartype("str") */ ) {
		return (lhs != rhs)
	} else {
		if ( lhs < rhs ) {
			return -1
		} else {
			return (lhs > rhs)
		}
	}

#global

#endif
