#ifndef IG_ABDATA_ARGUMENT_STACK_AS
#define IG_ABDATA_ARGUMENT_STACK_AS

// 実引数スタック
// @ 未使用。将来的にも使用する予定なし。

#module abdata_argvalue mVar, mbRef

//------------------------------------------------
// 参照で取得
//------------------------------------------------
#modfunc argvalue_dup var p2
	dup p2, mVar
	return
	
//------------------------------------------------
// 設定
//------------------------------------------------
#modfunc argvalue_set var p2
	if ( mbRef ) {
		dup mVar, p2		// 参照
	} else {
		mVar = p2			// コピー
	}
	return
	
//------------------------------------------------
// 取得
//------------------------------------------------
#modfunc argvalue_get var p2
	if ( mbRef ) {
		argvalue_dup thismod, p2
	} else {
		p2 = mVar
	}
	return
	
//------------------------------------------------
// 参照渡しか？
//------------------------------------------------
#modcfunc argvalue_isByRef
	return mbRef
	
//------------------------------------------------
// [i] コンストラクタ
//------------------------------------------------
#define global argvalue_new(%1,%2,%3=0) newmod %1, abdata_argvalue@, %2, %3
#modinit var p2, int bRef
	mbRef = bRef
	argvalue_set thismod, p2
	return
	
//------------------------------------------------
// [i] デストラクタ
//------------------------------------------------
#define global argvalue_delete(%1) delmod %1
	
#global

#module abdata_argstack mValue, mCntValue

#define VAR_TEMP stt_temp@abdata_argstack

//------------------------------------------------
// [i] コンストラクタ
//------------------------------------------------
#define global ArgStack_new(%1) newmod %1, abdata_argstack@
#modinit
	dim mCntValue		// 項目数
	return
	
#define global ArgStack_init ArgStack_new

//------------------------------------------------
// [i] デストラクタ
//------------------------------------------------
#define global argstack_delete(%1) delmod %1

//------------------------------------------------
// プッシュ
//------------------------------------------------
#define global ArgStack_push(%1,%2) VAR_TEMP@abdata_argstack = %2 : _ArgStack_pushv %1,VAR_TEMP@abdata_argstack,0
#define global ArgStack_pushv(%1,%2) _ArgStack_pushv %1,%2,1
#modfunc _ArgStack_pushv var variable, int bRef
	argvalue_new mValue,     variable,     bRef	// 新しい項目を一番後ろに作成
	mCntValue ++								// 項目数を増加
	return
	
//------------------------------------------------
// ポップ
//------------------------------------------------
#modfunc ArgStack_popv var variable
	if ( mCntValue <= 0 ) { logmes "UnderFlow (ArgStackPop)" : return }	// アンダーフローを警告
	mCntValue --								// 積まれている数を減算
	argvalue_get    mValue(mCntValue), variable	// 一番後ろの項目を取得
	argvalue_delete mValue(mCntValue)			// 取得した項目を削除
	return
	
#modcfunc ArgStack_pop
	ArgStack_popv thismod, VAR_TEMP
	return VAR_TEMP
	
//------------------------------------------------
// 取得のみ
//------------------------------------------------
#modfunc ArgStack_peekv var variable, int p2
	if ( ( mCntValue - p2 ) <= 0 || p2 < 0 ) { logmes "UnderFlow (ArgStackPeek)" : return }
	argvalue_get mValue( mCntValue - p2 - 1 ), variable
	return
	
#modcfunc ArgStack_peek int p2
	ArgStack_peekv thismod, VAR_TEMP, p2
	return VAR_TEMP
	
//------------------------------------------------
// 参照渡しか？
//------------------------------------------------
#modcfunc ArgStack_isByRef int p2
	if ( ( mCntValue - p2 ) <= 0 || p2 < 0 ) { logmes "UnderFlow (ArgStack_valIsByRef)" : return }
	return argvalue_isByRef( mValue( mCntValue - p2 - 1 ) )
	
//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#modcfunc ArgStack_n
	return mCntValue
	
#define global ArgStack_size   ArgStack_n
#define global ArgStack_count  ArgStack_n
#define global ArgStack_length ArgStack_n

// 統一関数 clear, copy, chain, exchange は未実装

#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 1

//------------------------------------------------
// 必要なマクロ
//------------------------------------------------

#define global PRM_DUMMY
#define global call(%1,%2=PRM_DUMMY) callcount ++ : ArgStack_new prmof(starg) : argc = 0 : %2: gosub %1@fcore : delmod prmof_s(starg) : callcount --
#define global callcount prmof(_count)
#define global argc prmof_s(cntargs)
;#define global ctype argv(%1) StackPeek(prmof_s(starg), argc - (%1) - 1)
#define global ctype prmof(%1) %1@_prm
#define global ctype prmof_s(%1) prmof(%1)(callcount)
;#define global ctype arg(%1) ArgStackPush prmof_s(starg), (%1) : argc ++ :
#define global ctype byVal(%1) ArgStack_push  prmof_s(starg), %1 : argc ++ :
#define global ctype byRef(%1) ArgStack_pushv prmof_s(starg), %1 : argc ++ :
callcount = -1
dim prmof(cntargs), 8

#module _prm

#defcfunc argv int p1
	if ( ( argc - p1 - 1 ) < 0 ) { return 0 }
	ArgStack_peekv prmof_s(starg), argval_core, argc - p1 - 1
	return argval_core
	
#define global ctype refarg(%1) prmof(refarg_vcore)(refarg_fcore(%1))
#defcfunc refarg_fcore int p1
	ArgStack_peekv prmof_s(starg), prmof(refarg_vcore), argc - p1 - 1
	return 0
	
#global

//------------------------------------------------
// サンプルコード
//------------------------------------------------

// 関数は、前方宣言らしきものが必要
#module
#defcfunc fact_f double p1
	call  *fact_f, byVal(p1)
	return refdval
#global

// プロトタイプ宣言っぽいものを付けてもいい(option)
#define global mesf(%1,%2=PRM_DUMMY) call *printf, byVal(%1) %2

#define global func_x(%1=0,%2=0) call *func, byVal(%1) byVal(%2)

*main
	call *func	// 省略値は 0 (int)
	call *func,   byVal("ラベル命令です") byVal(34)
	call *printf, byVal("\"%prm%\"\n\t| PI = %prm%") byVal("Hello, world!") byVal(3.14159) byVal(3)
	call *printf, byVal("[%prm%! = %prm%]") byVal(6) byVal( fact_f(6) )
	
;	mesf   "%prm% %prm% %prm% %prm% %prm%", byVal(7) byVal("*") byVal(4) byVal("=") byVal(7 * 4)
;	func_x "普通の命令みたいです", 7
	
	call     *setvar, byRef(a) byVal(3200)		// 変数の型は変えられません
	mesf "a = %prm%", byRef(a)
	stop
	
//------------------------------------------------
// サンプル命令
//------------------------------------------------
*func@fcore		// *命令名@fcore
	mes "func\t: Hello, world!"
	mes "\t| "+ argv(0)
	mes "\t| "+ argv(1)
	return
	
//------------------------------------------------
// フォーマット指定出力
//------------------------------------------------
*printf@fcore
	sdim sform
	sform = argv(0)
	index = 0
	
	// "%prm%" を、引数ごとに置き換える
	repeat argc - 1							// argc は引数の数
		n = instr(sform, index, "%prm%")
		if ( n < 0 ) { break }
		
		index += n
		sform  = strmid(sform, 0, index) + argv(cnt + 1) + strmid(sform, index + 5, strlen(sform) - (index + 5))
	loop
	
	call *func, byVal("printf から呼ばれました") byVal( fact_f(fact_f(3)) )
	mes "printf\t: "+ sform
	
	return
	
//------------------------------------------------
// 階乗を求める
//------------------------------------------------
*fact_f@fcore
	if ( 0 != argv(0) ) {
		return fact_f(argv(0) - 1) * argv(0)	// 再帰可能
	}
	return 1.0
	
//------------------------------------------------
// 変数に代入する
//------------------------------------------------
*setvar@fcore
	refarg(0) = argv(1)
	return
	
#endif
