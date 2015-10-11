%dll
abdata
%group
データ構造
%type
長さつき配列



%index
arrlen_is_valid_len
「長さ」が有効な値か？
%prm
(self, len)
array self: 配列
int   len:  self の長さ？
return: len が self の長さとして有効な整数なら真



%index
arrlen_clear
初期化
%prm
self, len
array self
var   len: self の長さ
%inst
self が持っていたデータを消去する。



%index
arrlen_chain
連結
%prm
self, len, rhs, rhs_len
array self
var   len: self の長さ
array rhs: 連結する配列
int   rhs_len: 連結する長さ
%inst
self の後ろに rhs (長さ rhs_len) を連結する。

len == 0 のとき、self を rhs のコピーにする。len > 0 のときは、self と rhs の型が同じでなければいけない。



%index
arrlen_compare
辞書式順序
%prm
(self, len, rhs, rhs_len)
array self
int   len
array rhs
int   rhs_len
return: 比較値
%inst
(self, len) と (rhs, rhs_len) を辞書式順序で比較する。



%index
arrlen_insert_no_init
要素を1つ挿入する (初期化なし)
%prm
(self, len, i)
array self
var   len
int   i: 挿入する位置
%inst
self の i 番目に新しい要素を挿入する。挿入された要素は初期値を持つ。

要素番号 i がないときは、自動拡張する。



%index
arrlen_set
要素への代入
%prm
self, len, i, value
array self
var len
int i: 要素番号
var value: 代入する値
%inst
self の i 番目の要素に value を代入する。

i 番目の要素が既にあるなら、上書きされる。なければ、配列は要素数 (i + 1) になる。



%index
arrlen_erase_range
範囲内の要素を除去
%prm
(self, len, lb, ub)
array self
var len
int lb, ub: 取り除く添字の範囲
%inst
self から添字 [lb, ub) の要素を除去する。

[lb, ub) は { lb, lb + 1, lb + 2, ..., ub - 2, ub - 1 } を表す。例えば [1, 4) = { 1, 2, 3 }。



%index
arrlen_erase_many
要素を除去
%prm
(self, len, i, count)
array self
var len
int i: 除去する要素の位置
int count: 除去する要素の個数
%inst
self の i 番目から count 個の要素を除去する。
%href
arrlen_erase_range



%index
arrlen_iter_swap
要素を交換
%prm
(self, len, i0, i1)
array self
int len
int i0, i1: 交換する要素の添字
%inst
self の i0, i1 番目の2つの要素を交換する。



%index
arrlen_iter_move
要素を交換
%prm
(self, len, i_src, i_dst)
array self
int len
int i_src: 移動する要素の位置
int i_dst: 移動後の位置
%inst
self の i_src 番目の要素を、i_dst 番目に移動する。



%index
arrlen_reverse
要素を反転
%prm
(self, len, i_beg, i_end)
array self
int len
int i_beg, i_end: 位置
%inst
self の範囲 [i_beg, i_end) にある要素の順番を反転する。



%index
arrlen_is_sorted
整列済みか？
%prm
(self, len)
array self
int len
return: self が昇順に整列済みなら真
%inst
self が昇順に整列済みであるとは、すなわち self(0) <= self(1) <= ... <= self(len - 1) となること。

整列済みの配列のための特別な命令群が用意されている。
%href
arrlen_equal_range
arrlen_ord_count
arrlen_ord_insert
arrlen_ord_erase



%index
arrlen_lb
下界位置を検索
%prm
(self, len, value)
array self: 整列済み配列
int len
var value: 探す値
%href
arrlen_equal_range



%index
arrlen_ub
上界位置を検索
%prm
(self, len, value)
array self: 整列済み配列
int len
var value: 探す値
%href
arrlen_equal_range



%index
arrlen_equal_range
値の範囲を検索
%prm
self, len, value, lb, ub
array self: 整列済み配列
int len
var value: 探す値
var lb: 下界の値を代入する変数
var ub: 上界の値を代入する変数
%inst
整列済みの配列 self にある value が連続して並んでいる位置 [lb, ub) を計算する。以下に詳しく解説する。

例として次のような配列を考える。

  self = 10, 10, 20, 50, 50, 50, 90
  len  = 7

配列 self は整列済み(arrlen_is_sorted)なので、ここにある 10 や 50 のように、同じ値は必ず連続して並ぶ。

まず、仮に value = 50 が与えられた場合を考える。lb, ub というのは「50 がどこからどこまでにあるか」を表す数値になる。つまり、lb は「50 が最初にある位置」を指す番号で、ub は「50 が最後にある位置の次」を指す番号になる。

  self = 10, 10, 20, (lbの位置) 50, 50, 50, (ubの位置) 90
  lb = 3
  ub = 6

練習のため、value = 20 の場合も考えてみよう。これも同じように「self のどこからどこまでが 20 になっているか」を計算すればいい。

  self = 10, 10, (lbの位置) 20, (ubの位置) 50, 50, 50, 90
  lb = 2
  ub = 3

また、value = 90 の場合も同じような結果になるが、これは少しだけ特殊である。90 は配列 self の最後にあるので、ub = 「90 が最後にある位置の次」を指す番号は、配列の長さになる。

  self = 10, 10, 20, 50, 50, 50, (lb の位置) 90 (ubの位置)
  lb = 6
  ub = 7

最後に、value = 30 として「value が self に含まれていない」場合を考える。このときは今まで計算してきた「self のなかにある value の位置」という考え方がうまくいかない。代わりに、「self のなかに value はどこにあるべきか？」を考えよう。self が整列済みであるためには、value = 30 は「20 より後、50 より前」になければいけない。

  self = 10, 10, 20, (lbの位置) (ubの位置) 50, 50, 50, 90
  lb = 3
  ub = 3

きわどいケースの例を2つ上げて、説明を終わりにしよう。

  (探す値が、配列のすべての値より小さい場合)
  value = 0
  self  = (lbの位置) (ubの位置) 10, 10, 20, 50, 50, 50, 90
  lb = 0
  ub = 0

  (探す値が、配列のすべての値より大きい場合)
  value = 100
  self = 10, 10, 20, 50, 50, 50, 90 (lbの位置) (ubの位置)
  lb = 7
  ub = 7

----
その他

2分探索を使う。O(log len) 時間。
%href
arrlen_lb
arrlen_ub
arrlen_ord_count



%index
arrlen_sorted_count
値の個数
%prm
(self, len, value)
array self
int len
var value: 探す値
return: self のなかにある value の数
%inst
self は整列済みでなければいけない。



%index
arrlen_sorted_insert
整列済み挿入
%prm
(self, len, value, may_dup)
array self
int len
var value: 挿入する値
bool may_dup (= true): 重複時も挿入するか
return: 挿入された要素の個数
%inst
self が整列済みのままになるように、適切な位置に value を挿入する。



%index
arrlen_sorted_erase
整列済み除去
%prm
(self, len, value)
array self
int len
var value: 除去する値
int max_count (= ∞): 除去する最大個数
return: 除去された要素の個数
%inst
self から value に等しい要素を最大 max_count 個まで除去する。
