;#############################
%dll
abdata_list

%author
uedai

%date
2009 09/02 (Wed)	// 最終更新
2009 08/31 (Mon)	// Container のラッパに変更
2009 05/xx (___)	// 作成

%ver
1.0

%type
抽象データ構造 リスト

;%group
;$(default_group)

;--------------------
%index
List_new
List 構築

%prm
self
modvar self : モジュール変数

%inst
リスト (List) を構築します。

%href
List_new
List_delete

%group
構築関数

;--------------------
%index
List_delete
List 解体

%prm
self
modvar self : モジュール変数

%inst
リストを解体します。

自動で呼び出されるため、通常、呼び出す必要はありません。

%href
List_new
List_delete

%group
解体関数

;--------------------
%index
List_dup
List 参照化

%prm
self, vRef, i
modvar self : List インスタンス
var    vRef : 参照化する変数
int    i    : 要素番号

%inst
vRef を、リストの要素 [i] の参照 ( クローン ) にします。つまり、dup 命令のような処理です。

%href
List_dup
List_ref

List_get
List_getv

List_pop
List_popv

%group
メンバ関数::取得系

;--------------------
%index
List_ref
List 参照

%prm
(self, i)
modvar self : List インスタンス
int    i    : 要素番号

%inst
リストの要素 [i] の参照を返します (擬似的に)。この関数は、代入文の左辺としてのみ使用できます。

%sample
	List_ref(i) = 10
	List_ref(i) = "string"	// 型の変換はできません

%href
List_dup
List_ref

List_get
List_getv

List_pop
List_popv

%group
メンバ関数::取得系

;--------------------
%index
List_get
List 値の取得

%prm
(self, i)
modvar self : List インスタンス
int    i    : 要素番号

%inst
リストの要素 [i] の値を返します。

※ pop 操作ではないので、要素がリストから取り除かれるということはありません。

%href
List_dup
List_ref

List_get
List_getv

List_pop
List_popv

%group
メンバ関数::取得系

;--------------------
%index
List_getv
List 値の取得 ( 変数 )

%prm
self, result, i
modvar self : List インスタンス
var result  : 戻り値を格納する変数
int i       : 要素番号

%inst
リストの要素 [i] の値を、変数 result に格納します。

※ pop 操作ではないので、要素がリストから取り除かれるということはありません。

%href
List_dup
List_ref

List_get
List_getv

List_pop
List_popv

%group
メンバ関数::取得系

;--------------------
%index
List_pop
List 値の取得

%prm
self, i
modvar self : List インスタンス
int    i    : 要素番号

%inst
リストの要素 [i] の値を取得し、返します。取り出した値はリストから取り除かれます。

%href
List_dup
List_ref

List_get
List_getv

List_pop
List_popv

List_remove

%group
メンバ関数::取得系

;--------------------
%index
List_popv
List 値の取得 ( 変数 )

%prm
self, vResult, int i
modvar self    : List インスタンス
var    vResult : 戻り値を格納する変数
int    i       : 要素番号

%inst
リストの要素 [i] の値を取得し、vResult に格納します。取り出した値はリストから取り除かれます。

%href
List_dup
List_ref

List_get
List_getv

List_pop
List_popv

List_remove

%group
メンバ関数::取得系

;--------------------
%index
List_set
List 値の変更

%prm
self, value, i = 0
modvar self  : List インスタンス
any    value : 設定する値
int    i     : 要素番号

%inst
リストの要素 [i] の値を value に変更します。

%href
List_set
List_setv

List_insert
List_insertv

List_double
List_add

%group
メンバ関数::操作系

;--------------------
%index
List_setv
List 値の変更 ( 変数 )

%prm
self, vValue, i
modvar self   : List インスタンス
var    vValue : 設定する値が格納された変数
int    i      : 要素番号

%inst
リストの要素 [i] に、vValue の値を設定します。

%href
List_set
List_setv

List_insert
List_insertv

List_double
List_add

%group
メンバ関数::操作系

;--------------------
%index
List_insert
List 要素の挿入

%prm
self, value, p3 = 0
modvar self  : List インスタンス
any    value : 挿入する要素の値
int    i     : 新たな要素の番号

%inst
リストの [i] に、新しい要素を挿入します。i を省略する ( i == 0 にする ) と、リストの先頭に追加されます。

i は他のメンバのそれと違い、「i >= List_size(...)」を許可します。この場合は、要素を末尾に追加するという、List_push_back と同じ処理になります。

%href
List_set
List_setv

List_insert
List_insertv

List_double
List_add

%group
メンバ関数::操作系

;--------------------
%index
List_insertv
List 要素の挿入 ( 変数 )

%prm
self, vValue, i
modvar self   : List インスタンス
var    vValue : 挿入する要素の値が格納された変数
int    i      : 新しい要素の番号

%inst
リストの [i] に新しい要素を挿入します。

%href
List_set
List_setv

List_insert
List_insertv

List_double
List_add

%group
メンバ関数::操作系

;--------------------
%index
List_double
List 要素の倍化

%prm
self, i
modvar self : リスト
int    i    : 要素番号

%inst
リストの [i] の要素の直後に、同じ値の要素を挿入します。

%href
List_set
List_setv

List_insert
List_insertv

List_double
List_add

%group
メンバ関数::操作系

;--------------------
%index
List_add
List 要素の追加 ( 末尾 )

%prm
self, value
modvar self  : List インスタンス
any    value : 追加する要素の値

%inst
リストの末尾に要素を追加します。

%href
List_set
List_setv

List_insert
List_insertv

List_double
List_add

%group
メンバ関数::操作系

;--------------------
%index
List_remove
List 要素の除去

%prm
self, i
modvar self : List インスタンス
int    i    : 要素番号

%inst
リストの要素 [i] をリストから取り除きます。

%href
List_remove

%group
メンバ関数::操作系

;--------------------
%index
List_move
List 要素の移動

%prm
self, from, to
modvar self : List インスタンス
int    from : 移動前の要素番号
int    to   : 移動後の要素番号

%inst
リストの要素 [from] を、[to] の位置に移動させます。

※要素値の複写は発生しないので、低コストな処理です。

%href

%group
メンバ関数::順序操作系

;--------------------
%index
List_swap
List 要素の交換

%prm
self, pos1, pos2
modvar self : List インスタンス
int    pos1 : 交換する要素番号
int    pos2 : 〃

%inst
リストの要素 [pos1] と [pos2] を交換します。

※要素値の複写は発生しないので、低コストな処理です。

%href

%group
メンバ関数::順序操作系

;--------------------
%index
List_rotate
List 要素の巡回

%prm
self
modvar self : List インスタンス

%inst
リストの要素をすべて、一つ前にずらします。つまり、先頭の要素を末尾に移動させる処理です。

%href
List_rotate
List_rotate_back

%group
メンバ関数::順序操作系

;--------------------
%index
List_rotate_back
List 要素の巡回 ( 逆回転 )

%prm
self
modvar self : List インスタンス

%inst
リストの要素をすべて、一つ後ろにずらします。つまり、末尾の要素を先頭に移動させる処理で、List_rotate の丁度逆です。

%href
List_rotate
List_rotate_back

%group
メンバ関数::順序操作系

;--------------------
%index
List_reverse
List 要素順の反転

%prm
self
modvar self : List インスタンス

%inst
リストの要素の順番を逆にします。

(ex) [1, 2, 3, 4] を反転すると [4, 3, 2, 1] になる。

%href

%group
メンバ関数::順序操作系

;--------------------
%index
List_clear
List 消去 [i]

%prm
self
modvar self : List インスタンス

%inst
すべての要素をリストから取り除く統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
List_chain
List 連結 [i]

%prm
self, mvFrom
modvar self   : List インスタンス
modvar mvFrom : 〃

%inst
リスト mvFrom に含まれるすべての要素を、self の末尾に追加する統一関数です。mvFrom の要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
List_copy
List 複写 [i]

%prm
self, mvFrom
modvar self   : List インスタンス
modvar mvFrom : 〃

%inst
リスト mvFrom を複写する統一関数です。元々あったリストは List_clear によって消去されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
List_exchange
List コンテナ交換 [i]

%prm
self, mv2
modvar self : List インスタンス
modvar mv2  : 〃

%inst
self と mv2 に含まれるすべての要素を交換します。それぞれの要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
List_iterInit
List 反復子::初期化 [i]

%prm
self, iterData
modvar self  : List インスタンス
var iterData : 反復情報

%inst
リストの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
List_iterInit
List_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
List_iterNext
List 反復子::更新 [i]

%prm
(self, vIt, iterData)
modvar self  : List インスタンス
var vIt      : 反復子
var iterData : 反復情報

%inst
リストの反復子を更新する統一関数です。戻り値が偽なら、繰り返しを実行せずに終了します。

@ alg_iter が内部で使用するだけです。

%href
List_iterInit
List_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
List_size
List 要素数 [i]

%prm
(self)
modvar self : List インスタンス

%inst
リストに含まれる要素の数を返す統一関数です。

%note
List_count, List_length と同一。

%href

%group
メンバ関数

;--------------------
%index
List_isValid
List 要素番号が有効かどうか

%prm
(self, i)
modvar self : List インスタンス
int    i    : 要素番号

%inst
リストの要素番号として i が適切かどうかを返します。
適切な番号なら true ( 0 以外 ) を、不適切なら false ( = 0 ) を返します。

%href

%group
メンバ関数

;--------------------
%index
List_dbglog
List デバッグ出力

%prm
self
modvar self : List インスタンス

%inst
リストのすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ
