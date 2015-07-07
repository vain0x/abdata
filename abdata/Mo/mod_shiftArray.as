// 配列シフトモジュール

#ifndef __MODULE_SHIFT_ARRAY_AS__
#define __MODULE_SHIFT_ARRAY_AS__

#module shift_array_mod

// 挿入 ( 的な処理 )
#deffunc ArrayInsert array arr, int idx
	
	// 挿入される場所を空ける
	for i, length(arr), idx, -1
		arr(i) = arr(i - 1)
	next
	
	return
	
// 削除 ( 的な処理 )
#deffunc ArrayRemove array arr, int idx
	
	// 削除される場所を消す ( 他の値で上書きする )
	for i, idx, length(arr) - 1
		arr(i) = arr(i + 1)
	next
	
	return
	
// 移動
#deffunc ArrayMove array arr, int from, int to,  local temp
	if ( from == to ) { return }
	
	// 移動元の値を保存する
	temp = arr(from)
	
	// 移動する
	if ( from > to ) {
		dir = -1				// 上に進むなら -1
	} else {
		dir = 1
	}
	for i, from, to, dir
		arr(i) = arr(i + dir)	// 次の場所の値を受け取る
	next
	arr(to) = temp
	
	return
	
// 交換
#deffunc ArraySwap array arr, int pos1, int pos2,  local temp
	if ( pos1 == pos2 ) { return }
	temp      = arr(pos1)
	arr(pos1) = arr(pos2)
	arr(pos2) = temp
	return
	
// 巡回
#deffunc ArrayRotate array arr,  local temp
	
	// 最初の要素の値を保存する
	temp = arr(0)
	
	// 巡回する
	for i, 0, length(arr) - 1
		arr(i) = arr(i + 1)
	next
	
	arr(length(arr) - 1) = temp		// 最初の値
	
	return
	
#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

#module
#define global output(%1,%2) _output %1, %2, "%2"
#deffunc _output str ps1, array pa2, str ps3
	mes ps1
	foreach pa2
		mes ps3 + strf("(%d) = ", cnt) + pa2(cnt)
	loop
	return
#global

	dim a, 6
	
	// 初期値を設定する
	foreach a
		a(cnt) = cnt
	loop
	
	//######## 要素の挿入 ###########################
	// 挿入先の番号
	p = 0
	
	ArrayInsert a, p
	
	// 挿入する
	a(p) = 100
	
	// 表示
	pos 20, 20
	output "Array Insert", a
	
	//######## 要素の移動 ###########################
	p = 3	// 移動元の番号
	t = 1	// 移動先の番号
	
	ArrayMove a, p, t
	
	// 表示
	pos 140, 20
	output "Array Move", a
	
	//######## 要素の交換 ###########################
	// 交換する要素２つ
	p = 4, 2
	
	ArraySwap a, p(0), p(1)
	
	// 表示
	pos 260, 20
	output "Array Swap", a
	
	//######## 要素の巡回 ###########################
	ArrayRotate a
	
	// 表示
	pos 380, 20
	output "Array Rotate", a
	
	//######## 要素の削除 ###########################
	// 削除する番号
	p = 3
	
	ArrayRemove a, p
	
	// 表示
	pos 500, 20
	output "Array Remove", a		// (5) は削除された残骸
	
	stop
	
#endif

#endif
