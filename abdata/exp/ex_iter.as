// iter - 反復子 (実装)

#ifndef IG_ABDATA_EXTRA_ITER_IMPL_AS
#define IG_ABDATA_EXTRA_ITER_IMPL_AS

// 不完全

#module abdata_iter_impl mInst, mIt, mIterData
;, mbReversed

#define ctype ARG_TEMP(%1) stt_temp_%1@abdata_iter_impl

//------------------------------------------------
// 真理値・成敗値・NULL値
//------------------------------------------------
#define true    1
#define false   0
#define success 1
#define failure 0
#define NULL    0

#define global iterImpl_new(%1,%2) newmod %1, abdata_iter_impl@ : iterImpl_clear %1, %2
#define global iterImpl_delete(%1) delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit var inst
	mInst = inst
	return
	
//------------------------------------------------
// 実体の取得
//------------------------------------------------
#define global iterImpl_getInstance(%1) ARG_TEMP@abdata_iter_impl(inst)(iterImpl_getInstanceCore(%1, ARG_TEMP@abdata_iter_impl(inst))
#modcfunc iterImpl_getInstanceCore var dst
	dup dst, mInst
	return 0
	
//------------------------------------------------
// 値の取得
//------------------------------------------------
#modfunc iterImpl_getv var dst
	dst = mIt
	return
	
#modcfunc iterImpl_get
	return mIt
	
//------------------------------------------------
// 値の型の取得
//------------------------------------------------
#modcfunc iterImpl_vartype
	return vartype(mIt)
	
//------------------------------------------------
// データの取得
//------------------------------------------------
#modfunc iterImpl_getvData var dst
	dst = mIterData
	return
	
#modcfunc iterImpl_getData
	return mIterData
	
//------------------------------------------------
// 値の設定
//------------------------------------------------
#define global iterImpl_set(%1, %2) ARG_TEMP@abdata_iter_impl(set) = (%2) : iterImpl_setv %1, ARG_TEMP@abdata_iter_impl(set)
#modfunc iterImpl_setv var src
	mIt = src
	return
	
//------------------------------------------------
// データの設定
//------------------------------------------------
#define global iterImpl_setData(%1, %2) ARG_TEMP@abdata_iter_impl(setData) = (%2) : iterImpl_sevData %1, ARG_TEMP@abdata_iter_impl(setData)
#modfunc iterImpl_setvData var src
	mIterData = src
	return
	
#modfunc iterImpl_incData
	mIterData ++
	return
	
//------------------------------------------------
// 実体へのアクセスの準備
//------------------------------------------------
#define global       iterImpl_initAccess(%1)  dummy_sttm@abdata_iter_impl  clone_getInstance(%1)
#define global ctype iterImpl_initAccessf(%1) dummy_func@abdata_iter_impl( clone_getInstance(%1) )

//------------------------------------------------
// 前後へ移動
//------------------------------------------------
#define global iterImpl_prev(%1, %2) iterImpl_initAccess %1 : %2_iterPrev iterImpl_getInstance(%1), %1
#define global iterImpl_next(%1, %2) iterImpl_initAccess %1 : %2_iterNext iterImpl_getInstance(%1), %1

//------------------------------------------------
// [i] 初期化
//------------------------------------------------
#define global iterImpl_clear(%1, %2) iterImpl_initAccess %1 : %2_iterInit iterImpl_getInstance(%1), iterImpl_getInitVar(%1)

//------------------------------------------------
// ダミー命令・関数
//------------------------------------------------
#deffunc dummy_sttm@abdata_iter_impl var x
	return
	
#defcfunc dummy_func@abdata_iter_impl var x
	return 0
	
#global

#endif
