#ifndef IG_PVALPTR_MODULE_AS
#define IG_PVALPTR_MODULE_AS

// pvalptr module
// ˆÚA«‚ª‚È‚¢

#module

#define sizeof_PVal 48

#defcfunc pvalptr var v,  local p
	mref p, 0
	return p
	
#defcfunc getaptr var v,  local aptr
	mref aptr, 1
	return aptr
	
#deffunc dup_pval var orig, array pval,  local p_pval, local aptr
	mref p_pval, 0
	mref aptr, 1
	dupptr pval, p_pval, sizeof_PVal
	return aptr
	
#global

#endif
