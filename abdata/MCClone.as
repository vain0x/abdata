// (擬似)参照

#ifndef IG_MODULECLASS_CLONE_AS
#define IG_MODULECLASS_CLONE_AS

//##############################################################################
//                  定義部 : MClone
//##############################################################################
#module MCClone mElem

//------------------------------------------------
// 真理値・成敗値・NULL値
//------------------------------------------------
#define true    1
#define false   0
#define success 1
#define failure 0
#define NULL    0

//##########################################################
//        構築・解体
//##########################################################
#define global clone_new(%1)    newmod %1, MCClone@
#define global clone_delete(%1) delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit var src
	clone_setv thismod, src
	return
	
//------------------------------------------------
// 解体
//------------------------------------------------
;#modterm
;	return
	
//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 参照
//------------------------------------------------
#define global clone_get(%1) stt_get@MCClone(clone_get_core(%1, stt_get@MCClone))

#modcfunc clone_get_core array dst
	dup dst, mElem
	return 0
	
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        設定系
//##########################################################
//------------------------------------------------
// 設定
//------------------------------------------------
#modfunc clone_setv var src
	dup mElem, src
	return
	
//##########################################################
//        動作系
//##########################################################
//------------------------------------------------
// クローン化の準備
//------------------------------------------------
#define global       clone_initAccess(%1)   dummy_sttm@MCClone clone_get(%1)
#define global ctype clone_initAccessf(%1) (dummy_func@MCClone(clone_get(%1))
	
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        統一関数
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        その他
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------
//------------------------------------------------
// ダミー命令・関数
//------------------------------------------------
#deffunc dummy_sttm@MCClone var x
	return
	
#defcfunc dummy_func@MCClone var x
	return 0
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

	
	stop
	
#endif

#endif
