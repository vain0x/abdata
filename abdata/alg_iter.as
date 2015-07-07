// Algorithm::Iteration - 反復

#ifndef IG_ABSTRACT_DATA_STRUCTURE_ALGORITHM_ITERATOR_AS
#define IG_ABSTRACT_DATA_STRUCTURE_ALGORITHM_ITERATOR_AS

// 反復アルゴリズム (foreach)
// @ _continue は更新を行う。

#module abdata_iter mInst, mIterData

#define ctype ARG_TEMP(%1) stt_temp_%1@abdata_iter

#define global ctype inIterMod(%1) %1@abdata_iter
#define global ctype ITER_INST_NAME(%1)      inIterMod(%1_iter_instance)					// (識別子加工) 反復される変数名 → 反復子インスタンス (配列)
#define global ctype ITER_INST_IDX_NAME(%1)  inIterMod(%1_iter_instance_index_plus_1)		// (識別子加工) 反復される変数名 → (↑の要素番号 + 1)
#define global ctype ITER_INST_REAL(%1)      ITER_INST_NAME(%1).(ITER_INST_IDX(%1))			// 反復子インスタンス (配列要素)
#define global ctype ITER_INST(%1)           Iter_refInstance@abdata_iter(ITER_INST_REAL(%1))
#define global ctype ITER_INST_IDX_VAR(%1)   ITER_INST_IDX_NAME(%1)
#define global ctype ITER_INST_IDX(%1)      (ITER_INST_IDX_VAR(%1) - 1)
#define global ctype ITER_DATA(%1)           Iter_refIterData@abdata_iter(ITER_INST_REAL(%1))

// ・反復されるインスタンスは ITER_INST() マクロで得られる。これは mInst のクローン変数。
// ・反復子の実体は、ITER_INST_NAME() マクロで加工したもの、かつ @abdata_iter になってる。
// ・実体(abdata_iter)は newmod によって配列変数になる。その要素番号は、ITER_INST_IDX() で得られ、その値は
// 実体が指すインスタンスの名前を ITER_INST_IDX_NAME() マクロで加工した名前の変数
// (これは ITER_INST_IDX_VAR() で得られる) が保存する値 - 1 である。

// ITER_INST      -> 反復子インスタンスの配列
// ITER_INST_REAL -> 反復子(abdata_iter)のインスタンス (ITER_INST に配列要素をつけたもの)
// ITER_DATA      -> mIterData のクローン変数

// 反復する変数を v とすると、ITER_INST(v), ITER_INST_IDX_VAR(v) の二つの変数が使用される。

// @interface:
// @	sttm void .iterInit()
// @	func bool .iterNext()

//------------------------------------------------
// [@] インスタンスへの参照
// 
// @ インスタンスの型がまちまちなので、一旦代入してから使うべし。
//------------------------------------------------
#define ctype Iter_refInstance(%1) stt_refInst_var@abdata_iter.(Iter_refInstance_core(%1))
#modcfunc     Iter_refInstance_core
	dup stt_refInst_var@abdata_iter, mInst
	return 0
	
//------------------------------------------------
// [@] 反復子情報への参照
//------------------------------------------------
#define ctype Iter_refIterData(%1) stt_refIterData_var@abdata_iter.(Iter_refIterData_core(%1))
#modcfunc     Iter_refIterData_core
	dup stt_refIterData_var@abdata_iter, mIterData
	return 0
	
//------------------------------------------------
// 反復子の更新 ( while の条件に使う )
// 
// @ ref 用の変数の型を合わせるために、dummy_func() を先に処理させている。
//------------------------------------------------
#define global ctype Iter_next(%1, %2, %3 = it) \
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
#define global Iter_new(%1, %2) \
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
#define global Iter_delete(%1, %2) delmod ITER_INST_REAL(%1) : ITER_INST_IDX_VAR(%1) --
;#modterm
;	return
	
#global

//------------------------------------------------
// 公開マクロ群
//------------------------------------------------
#define global IterateBegin(%1,%2,%3=it)  %tabdata_iterate %i0 %s1 Iter_new %1, %2 : IterateCnt_ = -1 : while ( Iter_next(%1, %2, %3) ) : IterateCnt_ ++
#define global IterateEnd                 %tabdata_iterate wend : Iter_delete %o  %o0
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
	List_new slist
	repeat 10
		List_add slist, strf("#%02d value;", cnt)
	loop
	
//	＊記述方法、其の壱 ― 生 ―
;	Iter_new slist, List
;	while ( Iter_next(slist, List, it) )
;		mes it
;	wend
;	Iter_delete slist, List
	
//	＊記述方法、其の弐 ― 汎用 ―
	IterateBegin slist, List		// List は構造名。第三引数に it 変数を指定できる
		mes it						// 変数 it が、その周回での値を表す
	IterateEnd
	
//	＊記述方法、其の参 ― 奇妙 ―
;	Iterate( slist, List ) {
;		mes it						// 強制脱出不可能
;		return						// return が必須！ ( 忘れると一度しか実行されない )
;	}
	stop
	
#endif

#endif
