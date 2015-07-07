;#############################
%dll
abdata_deque

%author
uedai

%date
2009 09/02 (Wed)
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
Deque_new
Deque 構築

%prm
self
modvar self : モジュール変数

%inst
双方向キュー (Deque) を構築します。

%href
Deque_new
Deque_delete

%group
構築関数

;--------------------
%index
Deque_delete
Deque 解体

%prm
self
modvar self : モジュール変数

%inst
双方向キューを解体します。

自動で呼び出されるため、通常、呼び出す必要はありません。

%href
Deque_new
Deque_delete

%group
解体関数

;--------------------
%index
Deque_get_front
Deque 値の取得 ( 先頭 )

%prm
(self)
modvar self : 双方向キュー

%inst
双方向キューの先頭の要素の値を返します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Deque_get_back
Deque 値の取得 ( 末尾 )

%prm
(self)
modvar self : 双方向キュー

%inst
双方向キューの末尾の要素の値を返します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Deque_getv_front
Deque 値の取得 ( 先頭、変数 )

%prm
self, result
modvar self : 双方向キュー
var result  : 戻り値を格納する変数

%inst
双方向キューの先頭の要素の値を、変数 result に格納します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Deque_getv_back
Deque 値の取得 ( 末尾、変数 )

%prm
self, result
modvar self : 双方向キュー
var result  : 戻り値を格納する変数

%inst
双方向キューの末尾の要素の値を、変数 result に格納します。

※ pop 操作ではないので、要素が双方向キューから取り除かれるということはありません。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

%group
メンバ関数::取得系

;--------------------
%index
Deque_pop_front
Deque 値の取得 ( 先頭 )

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの先頭の要素の値を取得し、返します。取り出した値は双方向キューから取り除かれます。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

Deque_remove

%group
メンバ関数::取得系

;--------------------
%index
Deque_pop_back
Deque 値の取得 ( 末尾 )

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの末尾の要素の値を取得し、返します。取り出した値は双方向キューから取り除かれます。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

Deque_remove

%group
メンバ関数::取得系

;--------------------
%index
Deque_popv_front
Deque 値の取得 ( 先頭、変数 )

%prm
self, vResult
modvar self : 双方向キュー
var vResult : 戻り値を格納する変数

%inst
双方向キューの先頭の要素の値を取得し、vResult に格納します。取り出した値は双方向キューから取り除かれます。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

Deque_remove

%group
メンバ関数::取得系

;--------------------
%index
Deque_popv_back
Deque 値の取得 ( 末尾、変数 )

%prm
self, vResult
modvar self : 双方向キュー
var vResult : 戻り値を格納する変数

%inst
双方向キューの末尾の要素の値を取得し、vResult に格納します。取り出した値は双方向キューから取り除かれます。

%href
Deque_get_front
Deque_get_back
Deque_getv_front
Deque_getv_back

Deque_pop_front
Deque_pop_back
Deque_popv_front
Deque_popv_back

Deque_remove

%group
メンバ関数::取得系

;--------------------
%index
Deque_set
Deque 値の変更

%prm
self, value, i = 0
modvar self  : 双方向キュー
any    value : 設定する値
int    i     : 要素番号

%inst
双方向キューの要素 [i] の値を value に変更します。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_setv
Deque 値の変更 ( 変数 )

%prm
self, vValue, i
modvar self   : 双方向キュー
var    vValue : 設定する値が格納された変数
int    i      : 要素番号

%inst
双方向キューの要素 [i] に、vValue の値を設定します。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_insert
Deque 要素の挿入

%prm
self, value, p3 = 0
modvar self  : 双方向キュー
any    value : 挿入する要素の値
int    i     : 新たな要素の番号

%inst
双方向キューの [i] に、新しい要素を挿入します。i を省略する ( i == 0 にする ) と、双方向キューの先頭に追加されます。

i は他のメンバのそれと違い、「i >= Deque_size(...)」を許可します。この場合は、要素を末尾に追加するという、Deque_push_back と同じ処理になります。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_insertv
Deque 要素の挿入 ( 変数 )

%prm
self, vValue, i
modvar self   : 双方向キュー
var    vValue : 挿入する要素の値が格納された変数
int    i      : 新しい要素の番号

%inst
双方向キューの [i] に新しい要素を挿入します。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Container_double
Deque 要素の倍化

%prm
self, i
modvar self : 汎用コンテナ
int    i    : 要素番号

%inst
汎用コンテナの [i] の要素の直後に、同じ値の要素を挿入します。

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
Deque 要素の倍化 ( 先頭 )

%prm
self, i
modvar self : 汎用コンテナ
int    i    : 要素番号

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
Deque 要素の倍化 ( 末尾 )

%prm
self, i
modvar self : 汎用コンテナ
int    i    : 要素番号

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
Deque_push_front
Deque 要素の追加 ( 先頭 )

%prm
self, value
modvar self  : 双方向キュー
any    value : 追加する要素の値

%inst
双方向キューの先頭に要素を追加します。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_push_back
Deque 要素の追加 ( 末尾 )

%prm
self, value
modvar self  : 双方向キュー
any    value : 追加する要素の値

%inst
双方向キューの末尾に要素を追加します。

※ Deque_add と同じ。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_pushv_front
Deque 要素の追加 ( 先頭、変数 )

%prm
self, vValue
modvar self   : 双方向キュー
var    vValue : 追加する要素の値を格納した変数

%inst
双方向キューの先頭に要素を追加します。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_pushv_back
Deque 要素の追加 ( 末尾、変数 )

%prm
self, vValue
modvar self   : 双方向キュー
var    vValue : 追加する要素の値を格納した変数

%inst
双方向キューの末尾に要素を追加します。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_add
Deque 要素の追加 ( 末尾 )

%prm
self, value
modvar self  : 双方向キュー
any    value : 追加する要素の値

%inst
双方向キューの末尾に要素を追加する、Deque_push_back と同じ動作です。

%href
Deque_set
Deque_setv

Deque_insert
Deque_insertv

Deque_double_front
Deque_double_back

; Deque_push
Deque_push_front
Deque_push_back
; Deque_pushv
Deque_pushv_front
Deque_pushv_back

Deque_add

%group
メンバ関数::操作系

;--------------------
%index
Deque_remove_front
Deque 要素の除去 ( 先頭 )

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの先頭の要素を、双方向キューから取り除きます。

%href
Deque_remove_front
Deque_remove_back

%group
メンバ関数::操作系

;--------------------
%index
Deque_remove_back
Deque 要素の除去 ( 末尾 )

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの末尾の要素を、双方向キューから取り除きます。

%href
Deque_remove_front
Deque_remove_back

%group
メンバ関数::操作系

;--------------------
%index
Deque_swap_front
Deque 前方要素2つの交換

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの先頭にある2つの要素を交換します。

%href
Deque_swap_front
Deque_swap_back
Deque_rotate
Deque_rotate_back
Deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
Deque_swap_back
Deque 前方要素2つの交換

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの末尾にある2つの要素を交換します。

%href
Deque_swap_front
Deque_swap_back
Deque_rotate
Deque_rotate_back
Deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
Deque_rotate
Deque 要素の巡回

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの要素をすべて、一つ前にずらします。つまり、先頭の要素を末尾に移動させる処理です。

%href
Deque_swap_front
Deque_swap_back
Deque_rotate
Deque_rotate_back
Deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
Deque_rotate_back
Deque 要素の巡回 ( 逆回転 )

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの要素をすべて、一つ後ろにずらします。つまり、末尾の要素を先頭に移動させる処理で、Deque_rotate の丁度逆です。

%href
Deque_swap_front
Deque_swap_back
Deque_rotate
Deque_rotate_back
Deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
Deque_reverse
Deque 要素順の反転

%prm
self
modvar self : 双方向キュー

%inst
双方向キューの要素の順番を逆にします。

(ex) [1, 2, 3, 4] を反転すると [4, 3, 2, 1] になる。

%href
Deque_swap_front
Deque_swap_back
Deque_rotate
Deque_rotate_back
Deque_reverse

%group
メンバ関数::順序操作系

;--------------------
%index
Deque_clear
Deque 消去 [i]

%prm
self
modvar self : 双方向キュー

%inst
すべての要素を双方向キューから取り除く統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Deque_chain
Deque 連結 [i]

%prm
self, mvFrom
modvar self   : 双方向キュー
modvar mvFrom : 〃

%inst
双方向キュー mvFrom に含まれるすべての要素を、self の末尾に追加する統一関数です。mvFrom の要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Deque_copy
Deque 複写 [i]

%prm
self, mvFrom
modvar self   : 双方向キュー
modvar mvFrom : 〃

%inst
双方向キュー mvFrom を複写する統一関数です。元々あった双方向キューは Deque_clear によって消去されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Deque_exchange
Deque コンテナ交換 [i]

%prm
self, mv2
modvar self : 双方向キュー
modvar mv2  : 〃

%inst
self と mv2 に含まれるすべての要素を交換します。それぞれの要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Deque_iterInit
Deque 反復子::初期化 [i]

%prm
self, iterData
modvar self  : 双方向キュー
var iterData : 反復情報

%inst
双方向キューの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
Deque_iterInit
Deque_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
Deque_iterNext
Deque 反復子::更新 [i]

%prm
(self, vIt, iterData)
modvar self  : 双方向キュー
var vIt      : 反復子
var iterData : 反復情報

%inst
双方向キューの反復子を更新する統一関数です。戻り値が偽なら、繰り返しを実行せずに終了します。

@ alg_iter が内部で使用するだけです。

%href
Deque_iterInit
Deque_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
Deque_size
Deque 要素数 [i]

%prm
(self)
modvar self : 双方向キュー

%inst
双方向キューに含まれる要素の数を返す統一関数です。

%note
Deque_count, Deque_length と同一。

%href

%group
メンバ関数

;--------------------
html{
<!--
%index
Deque_isValid
Deque 要素番号が有効かどうか

%prm
(self, i)
modvar self : 双方向キュー
int    i    : 要素番号

%inst
双方向キューの要素番号として i が適切かどうかを返します。
適切な番号なら true ( 0 以外 ) を、不適切なら false ( = 0 ) を返します。

%href

%group
メンバ関数
-->
}

;--------------------
%index
Deque_dbglog
Deque デバッグ出力

%prm
self
modvar self : 双方向キュー

%inst
双方向キューのすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ
