// value - 汎値型 (ラッパ)

#ifndef IG_ABSTRACT_DATA_STRUCTURE_VALUE_WRAPPER_AS
#define IG_ABSTRACT_DATA_STRUCTURE_VALUE_WRAPPER_AS

// value

#include "value_impl.as"

//##############################################################################
//                abdata::value
//##############################################################################
#module abdata_value mValue

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype value_size(%1)  1
#define global ctype value_empty(%1) 0
#define global value_count  value_size
#define global value_length value_size

//##########################################################
//        構築・解体
//##########################################################
#define global value_new(%1, %2 = stt_zero@) valueImpl_new    valueInsts, %2 : %1 = stat
#define global value_delete(%1)              valueImpl_delete valueInsts(%1)

//------------------------------------------------
// 構築者
//------------------------------------------------
#define global ctype new_value(%1 = stt_zero@) new_value_(%1)
#defcfunc new_value_ var vSrc,  local newOne
	value_new newOne, vSrc
	return    newOne
	
//------------------------------------------------
// 解体者
//------------------------------------------------
;#modterm

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 値の取得
//------------------------------------------------
#define global       value_getv(%1, %2) valueImpl_getv valueInsts(%1), %2
#define global ctype value_get(%1)      valueImpl_get( valueInsts(%1) )

//------------------------------------------------
// 参照化
//------------------------------------------------
#define global value_clone(%1, %2) valueImpl_clone valueInsts(%1), %2

//------------------------------------------------
// 型の取得
//------------------------------------------------
#define global ctype value_vartype(%1) valueImpl_vartype( valueInsts(%1) )

//##########################################################
//        操作系
//##########################################################
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global value_set(%1, %2)  valueImpl_set  valueInsts(%1), %2
#define global value_setv(%1, %2) valueImpl_setv valueInsts(%1), %2

//------------------------------------------------
// 可変長要素の拡張
//------------------------------------------------
#define global value_memexpand(%1, %2) valueImpl_memexpand valueInsts(%1), %2

//------------------------------------------------
// 要素の型を変換する
//------------------------------------------------
#define global value_changeVartype(%1, %2) valueImpl_changeVartype valueInsts(%1), %2

//##########################################################
//        雑多系
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        コンテナ操作
//##########################################################
//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#define global value_clear(%1) valueImpl_clear valueInsts(%1)

//------------------------------------------------
// [i] 複写
//------------------------------------------------
#define global value_copy(%1, %2) valueImpl_copy valueInsts(%1), valueInsts(%2)

//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global value_chain(%1, %2) "value_chain は不可能。[value_chain(%1, %2)]"
;#define global value_chain(%1, %2) valueImpl_chain valueInsts(%1), valueInsts(%2)

//------------------------------------------------
// [i] 交換
//------------------------------------------------
#define global value_exchange(%1, %2) valueImpl_exchange valueInsts(%1), valueInsts(%2)

//##########################################################
//        反復子操作
//##########################################################
//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#define global value_iterInit(%1, %2) valueImpl_iterInit valueInsts(%1), %2

//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#define global ctype value_iterNext(%1, %2, %3) valueImpl_iterNext( valueInsts(%1), %2, %3 )

#global

//##############################################################################
//                  サンプル・スクリプト
//##############################################################################
#if 0

	a = 1
	b = "II"
	c = 3.14
	
	list = new_value(a), new_value(b), new_value(c)
	
	foreach list
		mes value_get(arr(cnt))
	loop
	
	stop
	
#endif

#endif
