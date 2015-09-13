#ifndef IG_MODULE_REFERENCE_AS
#define IG_MODULE_REFERENCE_AS

#module

#ifndef _cat
 #define global ctype _cat(%1,%2)%1%2//
#endif

/*
* 関数形式の dup
*
* @param index : そのまま返値となる
//*/
#defcfunc ref_dup_ctype array med, var target, int index
	dup med, target
	return index
	
/*
* 変数参照式のテンプレート
*
* @param p1:
*	関数形式マクロ。第2パラメータに媒介変数が渡される。
*	その変数を何かの参照にして 0 を返す関数に展開されるべき。
* @param p2...(n個):
*	p1 が受け取る実引数の個数。
//*/
#define global ctype ref_ref_expr_template_0(%1) \
	%t__ref  _cat(%i,@__ref)( %1(_cat(%o,@__ref)) )

#define global ctype ref_ref_expr_template_1(%1, %2 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref)) )
#define global ctype ref_ref_expr_template_2(%1, %2 = _empty, %3 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref),%3) )
#define global ctype ref_ref_expr_template_3(%1, %2 = _empty, %3 = _empty, %4 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref),%3,%4) )
#define global ctype ref_ref_expr_template_4(%1, %2 = _empty, %3 = _empty, %4 = _empty, %5 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref),%3,%4,%5) )

#ifndef ref_xs
/*
* 文字列への参照を作る関数
//*/
#define global ctype ref_xs(%1) \
	ref_ref_expr_template_1(ref_xs_@__ref, %1)

#defcfunc ref_xs_@__ref str value, array ref_med
	ref_med = value
	return 0
#endif

#ifndef ref_xd
/*
* 実数値への参照を作る関数
//*/
#define global ctype ref_xd(%1) \
	ref_ref_expr_template_1(ref_xd_@__ref, %1)
	
#defcfunc ref_xd_@__ref double value, array ref_med
	ref_med = value
	return 0
#endif

#ifndef ref_xi
/*
* 整数値への参照を作る関数
//*/
#define global ctype ref_xi(%1) \
	ref_ref_expr_template_1(ref_xi_@__ref, %1)

#defcfunc ref_xi_@__ref int value, array ref_med
	ref_med = value
	return 0
#endif

#global

#endif
