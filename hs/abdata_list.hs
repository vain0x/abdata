%dll
abdata_list
%type
抽象データ構造
%group
型なし配列

;--------------------
%index
list_make
構築
%prm
()
%inst
新しくリストを作成して、その識別ID (整数値) を返す。

作成したリストのIDは、各種 list_ 命令・関数の最初の引数に指定できる。

リストが不要になったら、なるべく list_delete 命令を呼び出すこと。

;--------------------
%index
list_from_array
構築 (配列の複製)
%prm
(rhs, len)
array rhs
int len: rhs の長さ
%inst
リストの新しいインスタンスを作成して、その識別IDを返す。

リストには rhs の最初の len 個の要素のコピーを持つ。
%href
list_make

;--------------------
%index
list_delete
破棄
%prm
self
int self
%inst
リスト self を解体する。以後、self が指すIDを使用すると「おかしな動作」が起こるので注意。

リストのすべてのインスタンスは、不要になったときに、ちょうど1回 list_delete されるのが望ましい。ただし、プログラムの終了時に list_delete を使う必要はない。

;--------------------
%index
list_size
要素数
%prm
(self)
%inst
リスト self が持つ要素の個数を返す。
%href
length

;--------------------
%index
list_regular_ix
インデックスの正規化
%prm
(self, ix)
int self
int ix: 位置
%inst
リストの ix 番目の位置を表す整数値を返す。

1. ix が0以上、list_size(self)未満なら、ix がそのまま返される。
2. ix が -list_size(self) 以上 -1 以下なら、ix + list_size(self) が返る。ようするに、最後の要素の位置を -1、その前の位置を -2、などと使用できる。
3. いずれでもない場合はエラーになる。

この関数は、「ix」という名前の引数に対して自動的に使用される。ユーザが使う必要はない。(位置を表す「i」は、上述の 1. の値しか受けつけない。)

;--------------------
%index
list_vartype
要素の型ID
%prm
(self, ix)
int self
int ix: 要素番号
%inst
リストの ix 番目の要素の値の型ID(vartype)を返す。

;--------------------
%index
list_get
値の取得
%prm
(self, ix)
inst self
int ix: 要素番号
%inst
リストの ix 番目の要素の値を返す。
%href
list_regular_ix
list_try_get

;--------------------
%index
list_try_get
値の取得
%prm
(self, result, i)
int self
var result: 値が代入される変数
int i: 要素番号
return: 成功したら真
%inst
リストの i 番目の要素の値を、変数 result に代入する。

i の値が不正なら失敗し、偽(0)が返る。

;--------------------
%index
list_try_dup
クローン変数の作成
%prm
(self, ref, i)
int self
var ref: クローン変数にする変数
int i: 要素番号
return int: 成功したなら真
%inst
リストの i 番目の要素のクローン変数にする。

クローン変数は、その要素の型が変更されたときや、self の要素数が増加したときなどに、使用できなくなる。

i の値が不正であるときには失敗し、偽(0)が返る。
%href
dup
list_try_dup

;--------------------
%index
list_ref
弱参照
%prm
(self, ix)
int self
int ix: 要素番号
return: ix 番目の要素への弱参照
%inst
リストの ix 番目の要素のクローン変数を作って返す。

特に使う必要はない。
%href
list_try_dup

;--------------------
%index
list_setv
要素の上書き
%prm
self, value, ix
int self
var value: 設定する値
int ix: 要素番号
%inst
リストの ix 番目の要素の値を value に変更する。要素の型は value の型に変更される。

;--------------------
%index
list_insertv
要素の挿入
%prm
self, value, ix
int self
var value: 挿入する値
int ix: 挿入する位置
%inst
リストの ix 番目に、新しい要素を挿入する。

ix に list_size() 以上の値を指定した場合もエラーにならない。要素数が (ix + 1) になるように、要素が挿入される。
%href
list_pushv_front
list_pushv_back

;--------------------
%index
list_pushv_front
先頭への挿入
%prm
self, value
int self
var value: 挿入する値
%inst
リストの先頭に値 value の要素を挿入する。

;--------------------
%index
list_pushv_back
末尾への挿入
%prm
self, value
int self
var value: 挿入する値
%inst
リストの末尾に値 value の要素を挿入する。

;--------------------
%index
list_erase
要素の除去
%prm
self, ix
int self
int ix: 要素番号
%inst
リストの ix 番目の要素をリストから取り除く。
%href
list_erase_range

;--------------------
%index
list_erase_range
要素の除去 (範囲)
%prm
self, ix_beg, ix_end
int self
int ix_beg, ix_end: 位置
%inst
リストの [ix_beg, ix_end) 番目の要素をリストから除去する。

;--------------------
%index
list_iter_swap
要素の交換
%prm
self, ix0, ix1
int self
int ix0, ix1: 交換する要素の位置
%inst
リストの ix0, ix1 番目の要素を交換する。

;--------------------
%index
list_iter_move
要素の移動
%prm
self, ix_src, ix_dst
int self
int ix_src: 要素の移動前の位置
int ix_dst: 要素の移動後の位置

%inst
リストの ix_src 番目の要素を、ix_dst 番目に移動させる。

;--------------------
%index
list_reverse
要素順の反転
%prm
self
int self
int ix_beg, ix_end: 要素の範囲
%inst
リストの [ix_beg, ix_end) 番目の要素の順番を逆にする。

;--------------------
%index
list_shuffle
要素順の無作為化
%prm
self
int self
int ix_beg, ix_end: 要素の範囲
%inst
リストの [ix_beg, ix_end) 番目の要素の順番を一様に無作為化する。

;--------------------
%index
list_permutate
要素順の指定
%prm
self
int self
array perm: 置換
%inst
リストの i 番目の要素を perm(i) 番目に移動させる。

配列 perm は、[0, list_size(self)) を並び替えた数列でなければいけない。list_regular_ix は適用されない。

;--------------------
%index
list_count
要素の数え上げ
%prm
(self)
int self
var val: 数える値
%inst
リストに含まれる、値が val に等しい要素の個数を返す。(型の違う値は、異なる値とみなされる。)

;--------------------
%index
list_compare
比較
%prm
(self, rhs)
int self
int rhs: リストのインスタンスID
return int: 比較値
%inst
2つのリスト self, rhs を辞書順で比較する。

違う型の値は、型ID(vartype)の小さいほうが小さい、とみなす。

返される比較値は、次のような意味をもつ整数値である。
 負 → self が rhs より小さい。
 0  → self と rhs が等しい。
 正 → self が rhs より大きい。

;--------------------
%index
list_clear
消去
%prm
self
int self
%inst
リストからすべての要素を除去する。

;--------------------
%index
list_chain
連結
%prm
self, rhs
int self
int rhs: リストのインスタンスID

%inst
リスト rhs に含まれる各要素を、self の末尾に追加する。

;--------------------
%index
list_dbglog
デバッグ出力

%prm
self
int self
%inst
リストのすべての要素を logmes で出力する。

;--------------------
%index
list_is_sorted
整列済みか？
%prm
(self, sort_mode)
int self
int sort_mode (= abdata_sort_ascending): 順序
return int: リストが整列済みなら真
%inst
リストが整列されていることを確認する。

sort_mode は次の2つのどちらか。
abdata_sort_ascending: 昇順 (小さいものが前、大きいものが後)
abdata_sort_decending: 降順 (大きいものが前、小さいものが後)
%href
list_compare
list_sort

list_equal_range
list_lb
list_ub
list_sorted_insertv
list_sorted_erasev

;--------------------
%index
list_sort
整列
%prm
self, sort_mode
int self
int sort_mode (= abdata_sort_ascending): 順序
%inst
リストを整列する。
%href
list_is_sorted

;--------------------
%index
list_equal_range
値の範囲
%prm
self, value, lb, ub, sort_mode
int self
var value
var lb, ub: 値の下界と上界
int sort_mode (= abdata_sort_ascending): 順序
%inst
arrlen_equal_range を参照。

この命令はリストが整列済み(list_is_sorted)でなければいけない。
%href
list_is_sorted

;--------------------
%index
list_sorted_insertv
整列済みの挿入
%prm
self, value, may_dup, sort_mode
int self
var value: 挿入する値
int may_dup (= true): 重複時も挿入するか？
int sort_mode (= abdata_sort_ascending): 順序
%inst
整列済み(list_is_sorted)のリストに、順序を保つように値 value を持つ要素を挿入する。

may_dup に false (= 0) を指定したとき、リストに値が value に等しい要素があるなら、要素を挿入しない。

;--------------------
%index
list_sorted_erasev
整列済みの除去
%prm
self, value, max_count, sort_mode
int self
var value: 挿入する値
int max_count (= ∞): 除去する要素数の最大
int sort_mode (= abdata_sort_ascending): 順序
%inst
整列済み(list_is_sorted)のリストから、値 value に等しい要素を除去する。

値 value に等しい要素が複数ある場合、最大で max_count 個だけ取り除く。
