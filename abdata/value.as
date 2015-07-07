// 簡易要素型 ( コンテナが内部で用いる )

#ifndef __ABSTRACT_DATA_STRUCTURE_VALUE_AS__
#define __ABSTRACT_DATA_STRUCTURE_VALUE_AS__

#module abdata_value mValue

//------------------------------------------------
// 参照を作る
//------------------------------------------------
#modfunc value_dup var p2
	dup p2, mValue
	return
	
//------------------------------------------------
// 値を取得
//------------------------------------------------
#modfunc value_getv var p2
	p2 = mValue
	return
	
//------------------------------------------------
// 値を設定
//------------------------------------------------
#modfunc value_setv var p2
	mValue = p2
	return
	
//------------------------------------------------
// コンストラクタ
//------------------------------------------------
#define global value_new(%1,%2) newmod %1, abdata_value@, %2
#modinit var p2
	value_setv thismod, p2
	return
	
//------------------------------------------------
// デストラクタ
//------------------------------------------------
#define global value_delete(%1) delmod %1
	
#global

#endif
