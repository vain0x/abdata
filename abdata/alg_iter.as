// Algorithm::Iterator - 繰返子

#ifndef __ABSTRACT_DATA_STRUCTURE_ITER_AS__
#define __ABSTRACT_DATA_STRUCTURE_ITER_AS__

#module abdata_iter mInst, mIterData

#define mv modvar abdata_iter@
#define global ctype ITER_INST_NAME(%1)       IN_ITER_MODULE(%1_the_iter_instance)
#define global ctype ITER_INST_INDEX_NAME(%1) IN_ITER_MODULE(%1_the_iter_instance_index_plus_1)
#define global ctype IN_ITER_MODULE(%1) %1@abdata_iter
#define global ctype ITER_INST_REAL(%1) ITER_INST_NAME(%1).(ITER_INST_INDEX(%1))
#define global ctype ITER_INST(%1)           Iter_refInstance@abdata_iter(ITER_INST_REAL(%1))
#define global ctype ITER_INST_INDEX_VAR(%1) ITER_INST_INDEX_NAME(%1)
#define global ctype ITER_INST_INDEX(%1)    (ITER_INST_INDEX_VAR(%1) - 1)
#define global ctype ITER_DATA(%1)           Iter_refIterData@abdata_iter(ITER_INST_REAL(%1))

// ・繰返子の実体は、ITER_INST() マクロで得られる。その名前は、それが指すインスタンスの名前を
// ITER_INST_NAME() マクロで加工したもの、かつ @abdata_iter になってる。
// ・実体は newmod によって配列変数になる。その要素番号は、ITER_INST_INDEX() で得られ、その値は
// 実体が指すインスタンスの名前を ITER_INST_INDEX_NAME() マクロで加工した名前の変数
// ( これは ITER_INST_INDEX_VAR() で得られる )が保存する値 - 1 である。

// ITER_INST      -> 繰り返すコンテナのインスタンス
// ITER_INST_REAL -> 繰返子のインスタンス

//------------------------------------------------
// [@] インスタンスへの参照
//------------------------------------------------
#define ctype Iter_refInstance(%1) stt_refInst_var@abdata_iter.(Iter_refInstance_core(%1))
#defcfunc     Iter_refInstance_core mv
	dup stt_refInst_var@abdata_iter, mInst
	return 0
	
//------------------------------------------------
// [@] 繰返子情報への参照
//------------------------------------------------
#define ctype Iter_refIterData(%1) stt_refIterData_var@abdata_iter.(Iter_refIterData_core(%1))
#defcfunc     Iter_refIterData_core mv
	dup stt_refIterData_var@abdata_iter, mIterData
	return 0
	
//------------------------------------------------
// 繰返子の更新 ( while の条件に使う )
//------------------------------------------------
#define global ctype Iter_next(%1,%2,%3=it) \
	( %2_iterNext(ITER_INST(%1), %3, ITER_DATA(%1)) )

//------------------------------------------------
// [i] コンストラクタ
//------------------------------------------------
#define global Iter_new(%1,%2) ITER_INST_INDEX_VAR(%1) ++ : newmod ITER_INST_NAME(%1), abdata_iter@, %1 : %2_iterInit ITER_INST(%1), ITER_DATA(%1)
#modinit var mv_inst
	dup mInst, mv_inst
	return
	
//------------------------------------------------
// [i] デストラクタ
// @ いまのところ、構造名は必要でないが……。
//------------------------------------------------
#define global Iter_delete(%1,%2) delmod ITER_INST_REAL(%1) : ITER_INST_INDEX_VAR(%1) --
;#modterm
;	return
	
#global

#define global IterateBegin(%1,%2,%3=it)  %tabdata_iterate %i0 %s1 Iter_new %1, %2 : IterateCnt = -1 : while ( Iter_next(%1, %2, %3) ) : IterateCnt ++
#define global IterateEnd                 %tabdata_iterate wend : Iter_delete %o  %o0
#define global IterateCnt                 %tabdata_iterate %p1
#define global ctype Iterate(%1,%2,%3=it) %tabdata_iterate_2 \
	IterateBegin %1, %2, %3 : gosub *%i : IterateEnd : if 0 : *%o

#if 0

#include "list.as"
	
	// とりあえず要素追加
	List_new slist
	repeat 10
		List_push_back slist, strf("#%02d value;", cnt)
	loop
	
//	＊記述方法、其の壱 ― 生 ―
;	Iter_new slist, List
;	while ( Iter_next(slist, List, it) )
;		mes it
;	wend
;	Iter_delete slist, List
	
//	＊記述方法、其の弐 ― 汎用 ―
	IterateBegin slist, List		// List は構造名。
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
