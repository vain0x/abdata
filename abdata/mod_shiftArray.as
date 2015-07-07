// 配列シフトモジュール

#ifndef IG_MODULE_SHIFT_ARRAY_AS
#define IG_MODULE_SHIFT_ARRAY_AS

#module shift_array_mod

#define global ArrayRangeEndDefault (-127)

//------------------------------------------------
// 配列区間の正規化 @private
// 
// @result: 反転区間か否か
//------------------------------------------------
#deffunc ArrayRangeRegularize@shift_array_mod array self, array range,  local tmp
	if ( range(1) == ArrayRangeEndDefault ) { range(1) = length(self) }
	
	if ( range(0) > range(1) ) {		// 区間が逆 => 両方 + 1 して交換
		tmp      = range(0) + 1
		range(0) = range(1) + 1
		range(1) = tmp
		return true
	} else {
		return false
	}
	
//------------------------------------------------
// 挿入 ( 的な処理 )
//------------------------------------------------
#deffunc ArrayInsert array self, int idx
	
	// 挿入される場所を空ける
	for i, length(self), idx, -1
		self(i) = self(i - 1)
	next
	
	return
	
//------------------------------------------------
// 削除 ( 的な処理 )
//------------------------------------------------
#deffunc ArrayRemove array self, int idx
	
	// 削除される場所を消す ( 他の値で上書きする )
	for i, idx, length(self) - 1
		self(i) = self(i + 1)
	next
	
	return
	
//------------------------------------------------
// 移動
//------------------------------------------------
#deffunc ArrayMove array self, int from, int to,  local temp, local dir
	if ( from == to ) { return }
	
	// 移動元の値を保存する
	temp = self(from)
	
	// 移動する
	if ( from > to ) {
		dir = -1				// 上に進むなら -1
	} else {
		dir = 1
	}
	for i, from, to, dir
		self(i) = self(i + dir)	// 次の場所の値を受け取る
	next
	self(to) = temp
	
	return
	
//------------------------------------------------
// 交換
//------------------------------------------------
#deffunc ArraySwap array self, int pos1, int pos2,  local temp
	if ( pos1 == pos2 ) { return }
	temp       = self(pos1)
	self(pos1) = self(pos2)
	self(pos2) = temp
	return
	
//------------------------------------------------
// 巡回
// 
// @prm self
// @prm step         : 巡回方向
// @prm [iBgn, iEnd) : 巡回対象の区間
//------------------------------------------------
#deffunc ArrayRotateImpl array self, int iBgn, int iEnd, int dir,  local range
	range = iBgn, iEnd
	ArrayRangeRegularize self, range
	
	if ( dir >= 0 ^ stat ) {		// 反転区間 => 逆方向に Rotate
		ArrayMove self, range(0), range(1) - 1
	} else {
		ArrayMove self,           range(1) - 1, range(0)
	}
	return
	
// 逆回転
#define global ArrayRotate(    %1, %2 = 0, %3 = ArrayRangeEndDefault) ArrayRotateImpl %1, %2, %3,  1
#define global ArrayRotateBack(%1, %2 = 0, %3 = ArrayRangeEndDefault) ArrayRotateImpl %1, %2, %3, -1

//------------------------------------------------
// 反転
// 
// @prm this
// @prm [iBgn, iEnd) : 反転対象の区間
//------------------------------------------------
#define global ArrayReverse(%1, %2 = 0, %3 = ArrayRangeEndDefault) ArrayReverse_ %1, %2, %3
#deffunc ArrayReverse_ array self, int iBgn, int iEnd,  local range
	range = iBgn, iEnd
	ArrayRangeRegularize self, range
	if ( stat ) { return }			// 反転区間 => 反転しても戻るので処理する必要なし
	
	repeat (range(1) - range(0)) / 2
		ArraySwap self, range(0) + cnt, range(1) - cnt - 1
	loop
	
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
