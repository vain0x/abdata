;#############################
%dll
abdata_deque

%author
uedai

%date
2010 07/18 (Sun)	// 最終更新 表記の修整など、いろいろ訂正
2009 10/04 (Sun)	// 
2009 08/30 (Thu)	// 作成

%ver
1.0

%type
抽象データ構造 双方向キュー

%group
メンバ関数

%url
http://prograpark.ninja-web.net/

;--------------------
%index
new_deque
Deque 構築 (一時)

%prm
()

%inst
新しい双方向キュー (Deque) を構築し、返します。

%href
new_deque
deque_new
deque_delete

%group
構築関数

;--------------------
%index
deque_new
Deque 構築

%prm
self
inst self : モジュール変数

%inst
双方向キュー (Deque) を構築します。

%href
new_deque
deque_new
deque_delete

%group
構築関数

;--------------------
%index
deque_delete
Deque 解体

%prm
self
inst self : モジュール変数

%inst
双方向キューを解体します。

プログラムの終了時に自動で呼び出されるため、通常、呼び出す必要はありません。

%href
new_deque
deque_new
deque_delete

%group
解体関数

;--------------------
%index
deque_get_front
Deque 値の取得 ( 先頭 )

%prm
(self)
inst self : 双方向キュー

%inst
双方向キューの先頭の要素の値を返します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
deque_get_back
Deque 値の取得 ( 末尾 )

%prm
(self)
inst self : 双方向キュー

%inst
双方向キューの末尾の要素の値を返します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
deque_getv_front
Deque 値の取得 ( 先頭、変数 )

%prm
self, result
inst self   : 双方向キュー
var  result : 戻り値を格納する変数

%inst
双方向キューの先頭の要素の値を、変数 result に格納します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
deque_getv_back
Deque 値の取得 ( 末尾、変数 )

%prm
self, result
inst self   : 双方向キュー
var  result : 戻り値を格納する変数

%inst
双方向キューの末尾の要素の値を、変数 result に格納します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
deque_pop_front
Deque 値の取得 ( 先頭 )

%prm
self
inst self : 双方向キュー

%inst
双方向キューの先頭の要素の値を取得し、返します。取り出した値は双方向キューから取り除かれます。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

deque_remove

%group
メンバ関数::取得系

;--------------------
%index
deque_pop_back
Deque 値の取得 ( 末尾 )

%prm
self
inst self : 双方向キュー

%inst
双方向キューの末尾の要素の値を取得し、返します。取り出した値は双方向キューから取り除かれます。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

deque_remove

%group
メンバ関数::取得系

;--------------------
%index
deque_popv_front
Deque 値の取得 ( 先頭、変数 )

%prm
self, vResult
inst self    : 双方向キュー
var  vResult : 戻り値を格納する変数

%inst
双方向キューの先頭の要素の値を取得し、vResult に格納します。取り出した値は双方向キューから取り除かれます。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

deque_remove

%group
メンバ関数::取得系

;--------------------
%index
deque_popv_back
Deque 値の取得 ( 末尾、変数 )

%prm
self, vResult
inst self    : 双方向キュー
var  vResult : 戻り値を格納する変数

%inst
双方向キューの末尾の要素の値を取得し、vResult に格納します。取り出した値は双方向キューから取り除かれます。

%href
deque_get_front
deque_get_back
deque_getv_front
deque_getv_back

deque_pop_front
deque_pop_back
deque_popv_front
deque_popv_back

deque_remove

%group
メンバ関数::取得系

;--------------------
%index
deque_vartype
Deque 型の取得

%prm
(self, idx)
inst self : 双方向キュー
int  idx  : 要素番号

%inst
双方向キューの要素 [idx] の値の型を返します。

%href
deque_vartype
deque_vartype_front
deque_vartype_back

%group
メンバ関数::取得系

;--------------------
%index
deque_vartype_front
Deque 型の取得 ( 先頭 )

%prm
(self)
inst self : 双方向キュー

%inst
双方向キューの先頭の要素の値の型を返します。

%href
deque_vartype
deque_vartype_front
deque_vartype_back

%group
メンバ関数::取得系

;--------------------
%index
deque_vartype_back
Deque 型の取得 ( 末尾 )

%prm
(self)
inst self : 双方向キュー

%inst
双方向キューの末尾の要素の値の型を返します。

%href
deque_vartype
deque_vartype_front
deque_vartype_back

%group
メンバ関数::取得系

;--------------------
%index
deque_set
Deque 値の変更

%prm
self, value, idx = 0
inst self  : 双方向キュー
any  value : 設定する値
int  idx   : 要素番号

%inst
双方向キューの要素 [idx] の値を value に変更します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double
deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_setv
Deque 値の変更 ( 変数 )

%prm
self, vValue, idx
inst self   : 双方向キュー
var  vValue : 設定する値が格納された変数
int  idx    : 要素番号

%inst
双方向キューの要素 [idx] に、vValue の値を設定します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double
deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_insert
Deque 要素の挿入

%prm
self, value, idx = 0
inst self  : 双方向キュー
any  value : 挿入する要素の値
int  idx   : 新たな要素の番号

%inst
双方向キューの [idx] に、新しい要素を挿入します。idx を省略する ( idx == 0 にする ) と、双方向キューの先頭に追加されます。

offset は他のメンバのそれと違い、「idx >= deque_size(...)」を許可します。この場合は、要素を末尾に追加するという、deque_push_back と同じ処理になります。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double
deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_insertv
Deque 要素の挿入 ( 変数 )

%prm
self, vValue, idx
inst self   : 双方向キュー
var  vValue : 挿入する要素の値が格納された変数
int  idx    : 新しい要素の番号

%inst
双方向キューの [i] に新しい要素を挿入します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double
deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
html{
<!--
%index
deque_double
Deque 要素の倍化

%prm
self, idx
inst self : 汎用コンテナ
int  idx  : 要素番号

%inst
汎用コンテナの [idx] の要素の直後に、同じ値の要素を挿入します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

; deque_double
deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系
-->
}
;--------------------
%index
deque_double_front
Deque 要素の倍化 ( 先頭 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの先頭の要素の直前に、同じ値の要素を挿入します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

; deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_double_back
Deque 要素の倍化 ( 末尾 )

%prm
self
inst self : 汎用コンテナ

%inst
汎用コンテナの末尾の要素の直後に、同じ値の要素を挿入します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double_front
deque_double_back

deque_push
; deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_push_front
Deque 要素の追加 ( 先頭 )

%prm
self, value
inst self  : 双方向キュー
any  value : 追加する要素の値

%inst
双方向キューの先頭に要素を追加します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_push_back
Deque 要素の追加 ( 末尾 )

%prm
self, value
inst self  : 双方向キュー
any  value : 追加する要素の値

%inst
双方向キューの末尾に要素を追加します。

※ deque_add と同じ。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_pushv_front
Deque 要素の追加 ( 先頭、変数 )

%prm
self, vValue
inst self   : 双方向キュー
var  vValue : 追加する要素の値を格納した変数

%inst
双方向キューの先頭に要素を追加します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_pushv_back
Deque 要素の追加 ( 末尾、変数 )

%prm
self, vValue
inst self   : 双方向キュー
var  vValue : 追加する要素の値を格納した変数

%inst
双方向キューの末尾に要素を追加します。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_add
Deque 要素の追加 ( 末尾 )

%prm
self, value
inst self  : 双方向キュー
any  value : 追加する要素の値

%inst
双方向キューの末尾に要素を追加する、deque_push_back と同じ動作です。

%href
deque_set
deque_setv

deque_insert
deque_insertv

deque_double_front
deque_double_back

; deque_push
deque_push_front
deque_push_back
; deque_pushv
deque_pushv_front
deque_pushv_back

deque_add

%group
メンバ関数::操作系

;--------------------
%index
deque_remove_front
Deque 要素の除去 ( 先頭 )

%prm
self
inst self : 双方向キュー

%inst
双方向キューの先頭の要素を、双方向キューから取り除きます。

%href
deque_remove_front
deque_remove_back

%group
メンバ関数::操作系

;--------------------
%index
deque_remove_back
Deque 要素の除去 ( 末尾 )

%prm
self
inst self : 双方向キュー

%inst
双方向キューの末尾の要素を、双方向キューから取り除きます。

%href
deque_remove_front
deque_remove_back

%group
メンバ関数::操作系

;--------------------
%index
deque_loc_swap_front
Deque 前方要素2つの交換

%prm
self
inst self : 双方向キュー

%inst
双方向キューの先頭にある2つの要素を交換します。

%href
deque_loc_swap_front
deque_loc_swap_back
deque_rotate
deque_rotate_back
deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
deque_loc_swap_back
Deque 前方要素2つの交換

%prm
self
inst self : 双方向キュー

%inst
双方向キューの末尾にある2つの要素を交換します。

%href
deque_loc_swap_front
deque_loc_swap_back
deque_rotate
deque_rotate_back
deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
deque_rotate
Deque 要素の巡回

%prm
self
inst self : 双方向キュー

%inst
双方向キューの要素をすべて、一つ前にずらします。つまり、先頭の要素を末尾に移動させる処理です。

%href
deque_loc_swap_front
deque_loc_swap_back
deque_rotate
deque_rotate_back
deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
deque_rotate_back
Deque 要素の巡回 ( 逆回転 )

%prm
self
inst self : 双方向キュー

%inst
双方向キューの要素をすべて、一つ後ろにずらします。つまり、末尾の要素を先頭に移動させる処理で、deque_rotate の丁度逆です。

%href
deque_loc_swap_front
deque_loc_swap_back
deque_rotate
deque_rotate_back
deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
deque_reverse
Deque 要素順の反転

%prm
self
inst self : 双方向キュー

%inst
双方向キューの要素の順番を逆にします。

(ex) [1, 2, 3, 4] を反転すると [4, 3, 2, 1] になる。

%href
deque_loc_swap_front
deque_loc_swap_back
deque_rotate
deque_rotate_back
deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
deque_clear
Deque 消去 [i]

%prm
self
inst self : 双方向キュー

%inst
すべての要素を双方向キューから取り除く統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
deque_chain
Deque 連結 [i]

%prm
self, src
inst self : 双方向キュー
inst src  : 〃

%inst
双方向キュー src に含まれるすべての要素を、self の末尾に追加する統一関数です。src の要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
deque_copy
Deque 複写 [i]

%prm
self, src
inst self : 双方向キュー
inst src  : 〃

%inst
双方向キュー src を複写する統一関数です。元々あった双方向キューは deque_clear によって消去されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
deque_swap
Deque コンテナ交換 [i]

%prm
self, obj
inst self : 双方向キュー
inst obj  : 〃

%inst
self と obj に含まれるすべての要素を交換します。それぞれの要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
deque_iter_init
Deque 反復子::初期化 [i]

%prm
self, iterData
inst self     : 双方向キュー
var  iterData : 反復情報

%inst
双方向キューの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
deque_iter_init
deque_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
deque_iter_next
Deque 反復子::更新 [i]

%prm
(self, vIt, iterData)
inst self     : 双方向キュー
var  vIt      : 反復子
var  iterData : 反復情報

%inst
双方向キューの反復子を更新する統一関数です。戻り値が偽なら、繰り返しを実行せずに終了します。

@ alg_iter が内部で使用するだけです。

%href
deque_iter_init
deque_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
deque_size
Deque 要素数 [i]

%prm
(self)
inst self : 双方向キュー

%inst
双方向キューに含まれる要素の数を返す統一関数です。

%note
deque_count, deque_length と同一。

%href

%group
メンバ関数

;--------------------
html{
<!--
%index
deque_isValid
Deque 要素番号が有効かどうか

%prm
(self, idx)
inst self : 双方向キュー
int  idx  : 要素番号

%inst
双方向キューの要素番号として idx が適切かどうかを返します。
適切な番号なら true ( 0 以外 ) を、不適切なら false ( = 0 ) を返します。

%href

%group
メンバ関数
-->
}

;--------------------
%index
deque_dbglog
Deque デバッグ出力

%prm
self
inst self : 双方向キュー

%inst
双方向キューのすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ
