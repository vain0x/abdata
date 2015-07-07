// Algorithm::Iteration - 反復

#ifndef IG_ABDATA_ALGORITHM_ITERATION_AS
#define IG_ABDATA_ALGORITHM_ITERATION_AS

// 反復アルゴリズム (foreach)
// @ _continue は更新を行う。

#module abdata_iter mInst, mIterData

#define global ctype structure_name(%1) %1
#define global ctype structure_method(%1,%2) %1%2
#define ctype ARG_TEMP(%1) st_tmp_%1@abdata_iter

#define global ctype inIterMod(%1) %1@abdata_iter
#define global ctype ITER_INST_NAME(%1)      inIterMod(%1_inst)
#define global ctype ITER_INST_IDX_NAME(%1)  inIterMod(%1_inst_idx_plus_1)
#define global ctype ITER_INST_REAL(%1)      ITER_INST_NAME(%1).(ITER_INST_IDX(%1))
#define global ctype ITER_INST(%1)           iter_refInst@abdata_iter(ITER_INST_REAL(%1))
#define global ctype ITER_INST_IDX_VAR(%1)   ITER_INST_IDX_NAME(%1)
#define global ctype ITER_INST_IDX(%1)      (ITER_INST_IDX_VAR(%1) - 1)
#define global ctype ITER_DATA(%1)           iter_refData@abdata_iter(ITER_INST_REAL(%1))

// ITER_INST_NAME:     (識別子加工) 反復される変数名 → 反復子インスタンス (配列)
// ITER_INST_IDX_NAME: (識別子加工) 反復される変数名 → (↑の要素番号 + 1)
// ITER_INST_REAL:     反復子インスタンス (配列要素)

// ・反復されるインスタンスは ITER_INST() マクロで得られる。これは mInst のクローン変数。
// ・反復子の実体は、ITER_INST_NAME() マクロで加工したもの、かつ @abdata_iter になっている。
// ・実体(abdata_iter)は newmod によって配列変数になる。その要素番号は、ITER_INST_IDX() で得られ、その値は
// 実体が指すインスタンスの名前を ITER_INST_IDX_NAME() マクロで加工した名前の変数
// (これは ITER_INST_IDX_VAR() で得られる) が保存する値 - 1 である。

// ITER_INST      -> 反復子インスタンスの配列
// ITER_INST_REAL -> 反復子(abdata_iter)のインスタンス (ITER_INST に配列要素をつけたもの)
// ITER_DATA      -> mIterData のクローン変数

// 反復する変数を v とすると、ITER_INST(v), ITER_INST_IDX_VAR(v) の二つの変数が使用される。

// (memo) 構造体名のパラメータ(listなど)にマクロを使用できない (展開させるときスペースが増えてしまうバグのため)。

// @interface:
// @	sttm void .iterInit()
// @	func bool .iterNext()

//------------------------------------------------
// [@] インスタンスへの参照
// 
// @ インスタンスの型がまちまちなので、一旦代入してから使うべし。
//------------------------------------------------
#define ctype iter_refInst(%1) stt_refInst_var@abdata_iter(iter_refInst_core(%1))
#modcfunc     iter_refInst_core
	dup stt_refInst_var@abdata_iter, mInst
	return 0
	
//------------------------------------------------
// [@] 反復子情報への参照
//------------------------------------------------
#define ctype iter_refData(%1) stt_refData_var@abdata_iter(iter_refData_core(%1))
#modcfunc     iter_refData_core
	dup stt_refData_var@abdata_iter, mIterData
	return 0
	
//------------------------------------------------
// 反復子の更新 ( while の条件に使う )
// 
// @ ref (inst) 用の変数の型を合わせるために、dummy_func() をループを始める前に処理させている。
//------------------------------------------------
#define global ctype iter_next(%1, %2, %3 = it) \
	( dummy_func@abdata_iter(ITER_INST(%1)) || %2_iterNext(ITER_INST(%1), %3, ITER_DATA(%1)) )
	
#deffunc dummy_sttm@abdata_iter var x
	return
	
#defcfunc dummy_func@abdata_iter var x
	return 0
	
//------------------------------------------------
// [i] コンストラクタ
// 
// @prm inst : 対象の abdata コンテナ実体
//------------------------------------------------
#define global iter_new(%1, %2) \
	ARG_TEMP@abdata_iter(new_src) = %1 :\
	ITER_INST_IDX_VAR(%1) ++ :\
	newmod ITER_INST_NAME(%1), abdata_iter@, ARG_TEMP@abdata_iter(new_src) :\
	dummy_sttm@abdata_iter ITER_INST(%1) /* ref 用の変数の型を合わせる */ :\
	%2_iterInit ITER_INST(%1), ITER_DATA(%1)
	
#modinit var inst
	mInst     = inst
;	mIterData = ;
	return
	
//------------------------------------------------
// [i] デストラクタ
// @ いまのところ、構造名は必要でないが……。
//------------------------------------------------
#define global iter_delete(%1, %2) delmod ITER_INST_REAL(%1) : ITER_INST_IDX_VAR(%1) --
;#modterm
;	return
	
#global

//------------------------------------------------
// 公開マクロ群
//------------------------------------------------
#define global IterateBegin(%1,%2,%3=it)  %tabdata_iterate %i0 %s1 iter_new %1, %2 : IterateCnt_ = -1 : while ( iter_next(%1, %2, %3) ) : IterateCnt_ ++
#define global IterateEnd                 %tabdata_iterate wend : iter_delete %o  %o0
#define global IterateCnt_                %tabdata_iterate %p1		// 使用不可
#define global IterateCnt                 %tabdata_iterate (IterateCnt_)
#define global ctype Iterate(%1,%2,%3=it) %tabdata_iterate_2 \
	IterateBegin %1, %2, %3 : gosub *%i : IterateEnd : if 0 : *%o

//##############################################################################
//        サンプル・スクリプト
//##############################################################################
#if 0

#include "list.as"
	
	// とりあえず要素追加
	list_new obj
	repeat 10
		list_add obj, strf("#%02d value;", cnt)
	loop
	
//	＊記述方法、其の壱 ― 生 ―		// 非推奨
;	iter_new obj, list
;	while ( iter_next( obj, list, it ) )
;		mes it
;	wend
;	iter_delete obj, list
	
//	＊記述方法、其の弐 ― 汎用 ―
	IterateBegin obj, list		// structure は構造名 (ここではマクロなので置換される)。第三引数に it 変数を指定できる。
		mes it						// 変数 it が、その周回での値(データ)を表す。
	IterateEnd
	
//	＊記述方法、其の参 ― 奇妙 ―
;	Iterate( obj, list ) {
;		mes it						// 強制脱出不可能
;		return						// return が必須！ ( 忘れると一度しか実行されない )
;	}
	stop
	
#endif

#endif
