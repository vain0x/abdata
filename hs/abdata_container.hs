;#############################
%dll
abdata_container

%author
uedai

%date
2010 07/17 (Sat)	// 最終更新 _dup を _clone へ変更, new_Container 追加
2010 06/25 (Fri)	// Container_Sort 追加
2009 10/04 (Sun)	// 
2009 08/31 (Mon)	// 作成

%ver
1.0

%type
抽象データ構造 汎用コンテナ

%group
メンバ関数

%url
http://prograpark.ninja-web.net/

;--------------------
%index
new_Container
Container 構築 (一時)

%prm
()

%inst
汎用コンテナ (Container) を式中で構築します。

%href
new_Container
Container_new
Container_delete

%group
構築関数

;--------------------
%index
Container_new
Container 構築

%prm
self
inst self : 汎用コンテナを構築する変数

%inst
汎用コンテナ (Container) を構築します。

%href
new_Container
Container_new
Container_delete

%group
構築関数

;--------------------
%index
Container_delete
Container 解体

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナを解体します。

自動で呼び出されるため、通常、呼び出す必要はありません。

%href
new_Container
Container_new
Container_delete

%group
解体関数

;--------------------
%index
Container_clone
Container 参照化

%prm
self, vRef, i
inst self : 汎用コンテナ
var  vRef : 参照化する変数
int  i    : 要素番号

%inst
vRef を、汎用コンテナの要素 [i] の参照 ( クローン ) にします。つまり、dup 命令のような処理です。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_ref
Container 参照

%prm
(self, idx)
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの要素 [idx] の参照を返します (擬似的に)。この関数は、代入文の左辺としてのみ使用できます。

%sample
	Container_ref( idx ) = 10
	Container_ref( idx ) = "string"	// 型の変換はできません

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_get
Container 値の取得

%prm
(self, idx)
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの要素 [idx] の値を返します。

※ pop 操作ではないので、要素が汎用コンテナから取り除かれるということはありません。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_get_front
Container 値の取得 ( 先頭 )

%prm
(self)
inst self : 汎用コンテナ

%inst
汎用コンテナの先頭の要素の値を返します。

※ pop 操作ではないので、要素が汎用コンテナから取り除かれるということはありません。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_get_back
Container 値の取得 ( 末尾 )

%prm
(self)
inst self : 汎用コンテナ

%inst
汎用コンテナの末尾の要素の値を返します。

※ pop 操作ではないので、要素が汎用コンテナから取り除かれるということはありません。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_getv
Container 値の取得 ( 変数 )

%prm
self, result, idx
inst self   : 汎用コンテナ
var  result : 返値を格納する変数
int  idx    : 要素番号

%inst
汎用コンテナの要素 [idx] の値を、変数 result に格納します。

※ pop 操作ではないので、要素が汎用コンテナから取り除かれるということはありません。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_getv_front
Container 値の取得 ( 先頭、変数 )

%prm
self, result
inst self   : 汎用コンテナ
var  result : 戻り値を格納する変数

%inst
汎用コンテナの先頭の要素の値を、変数 result に格納します。

※ pop 操作ではないので、要素が汎用コンテナから取り除かれるということはありません。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_getv_back
Container 値の取得 ( 末尾、変数 )

%prm
self, result
inst self   : 汎用コンテナ
var  result : 戻り値を格納する変数

%inst
汎用コンテナの末尾の要素の値を、変数 result に格納します。

※ pop 操作ではないので、要素が汎用コンテナから取り除かれるということはありません。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Container_pop
Container 値の取得

%prm
self, idx
inst self : 汎用コンテナ
int  i    : 要素番号

%inst
汎用コンテナの要素 [idx] の値を取得し、返します。取り出した値は汎用コンテナから取り除かれます。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

Container_remove

%group
メンバ関数::取得系

;--------------------
%index
Container_pop_front
Container 値の取得 ( 先頭 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの先頭の要素の値を取得し、返します。取り出した値は汎用コンテナから取り除かれます。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

Container_remove

%group
メンバ関数::取得系

;--------------------
%index
Container_pop_back
Container 値の取得 ( 末尾 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの末尾の要素の値を取得し、返します。取り出した値は汎用コンテナから取り除かれます。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

Container_remove

%group
メンバ関数::取得系

;--------------------
%index
Container_popv
Container 値の取得 ( 変数 )

%prm
self, vResult, int idx
inst self    : 汎用コンテナ
var  vResult : 戻り値を格納する変数
int  idx     : 要素番号

%inst
汎用コンテナの要素 [idx] の値を取得し、vResult に格納します。取り出した値は汎用コンテナから取り除かれます。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

Container_remove

%group
メンバ関数::取得系

;--------------------
%index
Container_popv_front
Container 値の取得 ( 先頭、変数 )

%prm
self, vResult
inst self    : 汎用コンテナ
var  vResult : 戻り値を格納する変数

%inst
汎用コンテナの先頭の要素の値を取得し、vResult に格納します。取り出した値は汎用コンテナから取り除かれます。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

Container_remove

%group
メンバ関数::取得系

;--------------------
%index
Container_popv_back
Container 値の取得 ( 末尾、変数 )

%prm
self, vResult
inst self    : 汎用コンテナ
var  vResult : 戻り値を格納する変数

%inst
汎用コンテナの末尾の要素の値を取得し、vResult に格納します。取り出した値は汎用コンテナから取り除かれます。

%href
Container_clone
Container_ref

Container_get
Container_get_front
Container_get_back
Container_getv
Container_getv_front
Container_getv_back

Container_pop
Container_pop_front
Container_pop_back
Container_popv
Container_popv_front
Container_popv_back

Container_remove

%group
メンバ関数::取得系

;--------------------
%index
Container_vartype
Container 型の取得

%prm
(self, idx)
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの要素 [i] の値の型を返します。

%href
Container_vartype
Container_vartype_front
Container_vartype_back

%group
メンバ関数::取得系

;--------------------
%index
Container_vartype_front
Container 型の取得 ( 先頭 )

%prm
(self)
inst self : 汎用コンテナ

%inst
汎用コンテナの先頭の要素の値の型を返します。

%href
Container_vartype
Container_vartype_front
Container_vartype_back

%group
メンバ関数::取得系

;--------------------
%index
Container_vartype_back
Container 型の取得 ( 末尾 )

%prm
(self)
inst self : 汎用コンテナ

%inst
汎用コンテナの末尾の要素の値の型を返します。

%href
Container_vartype
Container_vartype_front
Container_vartype_back

%group
メンバ関数::取得系

;--------------------
%index
Container_set
Container 値の変更

%prm
self, value, idx = 0
inst self  : 汎用コンテナ
any  value : 設定する値
int  idx   : 要素番号

%inst
汎用コンテナの要素 [i] の値を value に変更します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_setv
Container 値の変更 ( 変数 )

%prm
self, vValue, idx
inst self   : 汎用コンテナ
var  vValue : 設定する値が格納された変数
int  idx    : 要素番号

%inst
汎用コンテナの要素 [idx] に、vValue の値を設定します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_insert
Container 要素の挿入

%prm
self, value, idx = 0
inst self  : 汎用コンテナ
any  value : 挿入する要素の値
int  idx   : 新たな要素の番号

%inst
汎用コンテナの [idx] に、新しい要素を挿入します。idx を省略する ( idx == 0 にする ) と、汎用コンテナの先頭に追加されます。

idx は他のメンバのそれと違い、「idx >= Container_size(...)」を許可します。この場合は、要素を末尾に追加するという、Container_push_back と同じ処理になります。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_insertv
Container 要素の挿入 ( 変数 )

%prm
self, vValue, idx
inst self   : 汎用コンテナ
var  vValue : 挿入する要素の値が格納された変数
int  idx    : 新しい要素の番号

%inst
汎用コンテナの [idx] に新しい要素を挿入します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_double
Container 要素の倍化

%prm
self, idx
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの [idx] の要素の直後に、同じ値の要素を挿入します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_double_front
Container 要素の倍化 ( 先頭 )

%prm
self, idx
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの先頭の要素の直後に、同じ値の要素を挿入します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_double_back
Container 要素の倍化 ( 末尾 )

%prm
self, idx
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの末尾の要素の直後に、同じ値の要素を挿入します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_push_front
Container 要素の追加 ( 先頭 )

%prm
self, value
inst self  : 汎用コンテナ
any  value : 追加する要素の値

%inst
汎用コンテナの先頭に要素を追加します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_push_back
Container 要素の追加 ( 末尾 )

%prm
self, value
inst self  : 汎用コンテナ
any  value : 追加する要素の値

%inst
汎用コンテナの末尾に要素を追加します。

※ Container_add と同じ。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_pushv_front
Container 要素の追加 ( 先頭、変数 )

%prm
self, vValue
inst self   : 汎用コンテナ
var  vValue : 追加する要素の値を格納した変数

%inst
汎用コンテナの先頭に要素を追加します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_pushv_back
Container 要素の追加 ( 末尾、変数 )

%prm
self, vValue
inst self   : 汎用コンテナ
var  vValue : 追加する要素の値を格納した変数

%inst
汎用コンテナの末尾に要素を追加します。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_add
Container 要素の追加 ( 末尾 )

%prm
self, value
inst self  : 汎用コンテナ
any  value : 追加する要素の値

%inst
汎用コンテナの末尾に要素を追加する、Container_push_back と同じ動作です。

%href
Container_set
Container_setv

Container_insert
Container_insertv

Container_double
Container_double_front
Container_double_back

; Container_push
Container_push_front
Container_push_back
; Container_pushv
Container_pushv_front
Container_pushv_back

Container_add

%group
メンバ関数::操作系

;--------------------
%index
Container_remove
Container 要素の除去

%prm
self, idx
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの要素 [i] を汎用コンテナから取り除きます。

%href
Container_remove
Container_remove_front
Container_remove_back

%group
メンバ関数::操作系

;--------------------
%index
Container_remove_front
Container 要素の除去 ( 先頭 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの先頭の要素を、汎用コンテナから取り除きます。

%href
Container_remove
Container_remove_front
Container_remove_back

%group
メンバ関数::操作系

;--------------------
%index
Container_remove_back
Container 要素の除去 ( 末尾 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの末尾の要素を、汎用コンテナから取り除きます。

%href
Container_remove
Container_remove_front
Container_remove_back

%group
メンバ関数::操作系

;--------------------
%index
Container_loc_move
Container 要素の移動

%prm
self, from, to
inst self : 汎用コンテナ
int  from : 移動前の要素番号
int  to   : 移動後の要素番号

%inst
汎用コンテナの要素 [from] を、[to] の位置に移動させます。

※要素値の複写は発生しないので、低コストな処理です。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_loc_swap
Container 要素の交換

%prm
self, pos1, pos2
inst self : 汎用コンテナ
int  pos1 : 交換する要素番号
int  pos2 : 〃

%inst
汎用コンテナの要素 [pos1] と [pos2] を交換します。

※要素値の複写は発生しないので、低コストな処理です。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_loc_swap_front
Container 要素の交換 ( 先頭 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの先頭の要素2つを交換します。

※要素値の複写は発生しないので、低コストな処理です。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_loc_swap_back
Container 要素の交換 ( 末尾 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの末尾の要素2つを交換します。

※要素値の複写は発生しないので、低コストな処理です。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_rotate
Container 要素の巡回

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの要素をすべて、一つ前にずらします。つまり、先頭の要素を末尾に移動させる処理です。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_rotate_back
Container 要素の巡回 ( 逆回転 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの要素をすべて、一つ後ろにずらします。つまり、末尾の要素を先頭に移動させる処理で、Container_rotate の丁度逆です。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_reverse
Container 要素順の反転

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの要素の順番を逆にします。

(ex) [1, 2, 3, 4] を反転すると [4, 3, 2, 1] になる。

%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_sort
Container 整列

%prm
self [, mode = SortMode_Ascending]
inst self : 汎用コンテナ
int  mode : SortMode_* 

%inst
汎用コンテナの要素を整列します。

SortMode_Ascending => 昇順
SortMode_Decending => 降順

※ variant など、大小比較のできない型が含まれていた場合、エラー終了するので注意すること。

(algorithm)
1. 型タイプ値の小さい方を「小さい」と判断。
2. 同じの場合、比較演算 (<, >) で判断。

(ex) [1, 3, e, "a", 2, "b", π] を整列すると ["a", "b", e, π, 1, 2, 3] になる。
%href
Container_loc_move
Container_loc_swap
Container_loc_swap_front
Container_loc_swap_back
Container_rotate
Container_rotate_back
Container_reverse
Container_sort

%group
メンバ関数::順序操作系

;--------------------
%index
Container_clear
Container 消去 [i]

%prm
self
inst self : 汎用コンテナ

%inst
すべての要素を汎用コンテナから取り除く統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Container_chain
Container 連結 [i]

%prm
self, src
inst self : 汎用コンテナ
inst src  : 〃

%inst
汎用コンテナ src に含まれるすべての要素を、self の末尾に追加する統一関数です。from の要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Container_copy
Container 複写 [i]

%prm
self, src
inst self : 汎用コンテナ
inst src  : 〃

%inst
汎用コンテナ src を複写する統一関数です。元々あった汎用コンテナは Container_clear によって消去されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Container_swap
Container コンテナ交換 [i]

%prm
self, obj2
inst self : 汎用コンテナ
inst obj2 : 〃

%inst
self と obj2 に含まれるすべての要素を交換します。それぞれの要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Container_iter_init
Container 反復子::初期化 [i]

%prm
self, iterData
inst self    : 汎用コンテナ
var iterData : 反復情報

%inst
汎用コンテナの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
Container_iter_init
Container_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
Container_iter_next
Container 反復子::更新 [i]

%prm
(self, vIt, iterData)
inst self    : 汎用コンテナ
var vIt      : 反復子
var iterData : 反復情報

%inst
汎用コンテナの反復子を更新する統一関数です。戻り値が偽なら、繰り返しを実行せずに終了します。

@ alg_iter が内部で使用するだけです。

%href
Container_iter_init
Container_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
Container_size
Container 要素数 [i]

%prm
(self)
inst self : 汎用コンテナ

%inst
汎用コンテナに含まれる要素の数を返す統一関数です。

%note
Container_count, Container_length と同一。

%href

%group
メンバ関数

;--------------------
%index
Container_isValid
Container 要素番号が有効かどうか

%prm
(self, idx)
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの要素番号として idx が適切かどうかを返します。
適切な番号なら true ( 0 以外 ) を、不適切なら false ( = 0 ) を返します。

%href

%group
メンバ関数

;--------------------
%index
Container_dbglog
Container デバッグ出力

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナのすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ
