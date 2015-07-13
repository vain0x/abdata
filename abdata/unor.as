// unor - 連想配列 ( 不整列コンテナ ) (ラッパ)

#ifndef IG_ABDATA_UNOR_WRAPPER_AS
#define IG_ABDATA_UNOR_WRAPPER_AS

#include "abheader.as"
#include "unor_impl.as"

#define global Unor_ClsName "unor"
#define global unorNull abdataNull

#define global unor_new(%1)    unorImpl_new    abdataInsts_var : %1 = stat
#define global unor_delete(%1) unorImpl_delete abdataInsts(%1)

//------------------------------------------------
// 構築者
//------------------------------------------------
#module
#defcfunc unor_make  local newOne
	unor_new newOne
	return   newOne
#global

//------------------------------------------------
// 値の取得 ( 命令形式 )
//------------------------------------------------
;#define global unor_getv_byIndex_(%1,%2,%3,%4) unorImpl_getv_byIndex_ abdataInsts(%1), %2, %3, %4
;#define global unor_getv_(%1,%2,%3,%4) unorImpl_getv_ abdataInsts(%1), %2, %3, %4
#define global unor_getv(%1,%2="",%3) unorImpl_getv abdataInsts(%1), %2, %3
#define global unor_popv(%1,%2="",%3) unorImpl_popv abdataInsts(%1), %2, %3

//------------------------------------------------
// 値の取得 ( 関数形式 )
//------------------------------------------------
;#define global unor_get_(%1,%2,%3) unorImpl_get_(abdataInsts(%1), %2, %3)
#define global ctype unor_get(%1,%2="") unorImpl_get(abdataInsts(%1), %2)
#define global ctype unor_pop(%1,%2="") unorImpl_pop(abdataInsts(%1), %2)

#define global ctype unor_tryget(%1, %2 = "", %3) unorImpl_tryget(abdataInsts(%1), %2, %3)
#define global ctype unor_trypop(%1, %2 = "", %3) unorImpl_trypop(abdataInsts(%1), %2, %3)

//------------------------------------------------
// 参照化 ( 命令形式 )
//------------------------------------------------
;#define global unor_clone_byIndex_(%1,%2,%3) unorImpl_clone_byIndex_ abdataInsts(%1), %2, %3
#define global unor_clone(%1,%2="",%3) unorImpl_clone abdataInsts(%1), %2, %3

//------------------------------------------------
// 参照化 ( 関数形式 )
//------------------------------------------------
#define global ctype unor_ref(%1,%2="") unorImpl_ref(abdataInsts(%1), %2)

;#define global ctype unor_ref_byIndex_(%1,%2) unorImpl_ref_byIndex_(abdataInsts(%1), %2)
;#define global ctype unor_ref_(%1,%2="")      unorImpl_ref_(abdataInsts(%1), %2)

//------------------------------------------------
// 型の取得 ( 関数形式 )
//------------------------------------------------
;#define global unor_vartype_byIndex_(%1,%2) unorImpl_vartype_byIndex_(abdataInsts(%1), %2)
#define global ctype unor_vartype(%1,%2="") unorImpl_vartype(abdataInsts(%1), %2)
;#define global ctype unor_vartype_(%1,%2) unorImpl_vartype_(abdataInsts(%1), %2)

//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global unor_set(%1,%2="",%3)  unorImpl_set  abdataInsts(%1), %2, %3
#define global unor_setv(%1,%2="",%3) unorImpl_setv abdataInsts(%1), %2, %3
;#define global unor_setv_byIndex_(%1,%2,%3) unorImpl_setv_byIndex_ abdataInsts(%1), %2, %3

//------------------------------------------------
// 追加
// 
// @ 既存なら失敗
//------------------------------------------------
#define global unor_add(%1,%2="",%3=stt_zero@) unorImpl_add abdataInsts(%1), %2, %3
#define global unor_addv(%1,%2,%3) unorImpl_addv abdataInsts(%1), %2, %3

//------------------------------------------------
// 除去
// 
// @+ 存在しない要素は除去しない
//------------------------------------------------
#define global unor_erase(%1,%2) unorImpl_erase abdataInsts(%1), %2
;#define global unor_erase_byIndex_(%1,%2) unorImpl_erase_byIndex_ abdataInsts(%1), %2

//------------------------------------------------
// [i] 完全消去
//------------------------------------------------
#define global unor_clear(%1) unorImpl_clear abdataInsts(%1)

//------------------------------------------------
// [i] 連結
//------------------------------------------------
#define global unor_chain(%1,%2) unorImpl_chain abdataInsts(%1), abdataInsts(%2)

//------------------------------------------------
// [i] 複製
//------------------------------------------------
#define global unor_copy(%1,%2) unorImpl_copy abdataInsts(%1), abdataInsts(%2)

//------------------------------------------------
// [i] 交換
//------------------------------------------------
#define global unor_swap(%1,%2) unorImpl_swap abdataInsts(%1), abdataInsts(%2)

//------------------------------------------------
// [i] 辞書順比較
//------------------------------------------------
#define global unor_lexicographical_compare(%1, %2) \
	unorImpl_lexicographical_compare abdataInsts(%1), abdataInsts(%2)

//------------------------------------------------
// [i] 反復子::初期化
//------------------------------------------------
#define global unor_iter_init(%1,%2) unorImpl_iter_init abdataInsts(%1), %2

//------------------------------------------------
// [i] 反復子::更新
//------------------------------------------------
#define global ctype unor_iter_next(%1,%2,%3) unorImpl_iter_next( abdataInsts(%1), %2, %3 )

//------------------------------------------------
// [i] 要素数
//------------------------------------------------
#define global ctype unor_size(%1)  unorImpl_size(abdataInsts(%1))
#define global ctype unor_empty(%1) unorImpl_empty(abdataInsts(%1))
#define global unor_length unor_size

#define global ctype unor_count_key(%1, %2) unorImpl_count_key(abdataInsts(%1), %2)
#define global ctype unor_count_value(%1, %2) unorImpl_count_value(abdataInsts(%1), %2)

//------------------------------------------------
// 実際の要素番号を得る
// @private
// @result:
// @	?(bNoAdd == false) =>
// @		ある場合 => キーがある要素番号
// @		ない場合 => 新規追加し、その番号を返す。
// @		=>> 常に有効な要素番号を返す。
// @	else =>
// @		ある場合 => キーがある要素番号
// @		ない場合 => 負数
//------------------------------------------------
;#define global ctype unor_getIndex(%1,%2,%3=0) unorImpl_getIndex@abdata_unor_impl(abdataInsts(%1), %2, %3)

//------------------------------------------------
// 要素を追加する
// @private
// @result: 追加した要素の要素番号
// @ 整列状態を保っておく。
// @ 重複したキーは無視する。
//------------------------------------------------
;#define global unor_addValue(%1,%2,%3) unorImpl_addValue@abdata_unor_impl abdataInsts(%1), %2, %3
;#define global unor_addValue_byIndex_(%1,%2,%3,%4) unorImpl_addValue_byIndex_@abdata_unor_impl abdataInsts(%1), %2, %3, %4

//------------------------------------------------
// 要素を検索する
// @private
// @algorithm : 二分探索(binary search)
// @result :
// @	キーがある場合 => 真を返す。idx := 要素番号。
// @	キーがない場合 => 偽を返す。idx := 指定キーがあるべき要素番号。
//------------------------------------------------
#define global ctype unor_find_ex(%1,%2,%3) unorImpl_find_ex@abdata_unor_impl(abdataInsts(%1), %2, %3)

//------------------------------------------------
// デバッグ出力
//------------------------------------------------
#define global unor_dbglog(%1) unorImpl_dbglog_ abdataInsts(%1), "%1"

#endif
