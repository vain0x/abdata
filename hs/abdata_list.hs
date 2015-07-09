;#############################
%dll
abdata_list

%author
uedai

%date
2011 01/09 (Sun)	// Insert の idx が要素数を超えている場合の仕様の変更
2010 07/18 (Sun)	// 最終更新 表記など、いろいろ訂正
2009 10/04 (Sun)	// 
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
new_list
List 構築 (一時)

%prm
()

%inst
新しくリスト (List) を構築し、返します。

%href
new_list
list_new
list_delete

%group
構築関数

;--------------------
%index
list_new
List 構築

%prm
self
var self : インスタンスを格納する変数

%inst
リスト (List) を構築します。

%href
new_list
list_new
list_delete

%group
構築関数

;--------------------
%index
list_delete
List 解体

%prm
self
inst self : List インスタンス

%inst
リスト (List) を解体します。

この関数はプログラム終了時に自動で呼び出されるため、通常、呼び出す必要はありません。

%href
new_list
list_new
list_delete

%group
解体関数

;--------------------
%index
list_clone
List クローン化

%prm
self, vRef, idx
inst self : List インスタンス
var  vRef : クローン化する変数
int  idx  : 要素番号

%inst
vRef を、リストの要素 [idx] のクローンにします。

dup 命令のような処理です。

%href
list_clone
list_ref

list_get
list_getv

list_pop
list_popv

%group
メンバ関数::取得系

;--------------------
%index
list_ref
List 参照

%prm
(self, i)
inst self : List インスタンス
int  idx  : 要素番号

%inst
リストの要素 [idx] の参照を返します (擬似的に)。この関数は、代入文の左辺としてのみ使用できます。

%sample
	list_ref(idx) = 10
//	list_ref(idx) = "string"	// 型の変換はできません

%href
list_clone
list_ref

list_get
list_getv

list_pop
list_popv

%group
メンバ関数::取得系

;--------------------
%index
list_get
List 値の取得

%prm
(self, idx)
inst self : List インスタンス
int  idx  : 要素番号

%inst
リストの要素 [idx] の値を返します。

※ pop 操作ではないので、要素がリストから取り除かれるということはありません。

%href
list_clone
list_ref

list_get
list_getv

list_pop
list_popv

%group
メンバ関数::取得系

;--------------------
%index
list_getv
List 値の取得 ( 変数 )

%prm
self, result, idx
inst self : List インスタンス
var result  : 返値を格納する変数
int idx     : 要素番号

%inst
リストの要素 [idx] の値を、変数 result に格納します。

※ pop 操作ではないので、要素がリストから取り除かれるということはありません。

%href
list_clone
list_ref

list_get
list_getv

list_pop
list_popv

%group
メンバ関数::取得系

;--------------------
%index
list_pop
List 値の取得

%prm
self, idx
inst self : List インスタンス
int  idx  : 要素番号

%inst
リストの要素 [idx] の値を取得し、返します。取り出した値はリストから取り除かれます。

%href
list_clone
list_ref

list_get
list_getv

list_pop
list_popv

list_remove

%group
メンバ関数::取得系

;--------------------
%index
list_popv
List 値の取得 ( 変数 )

%prm
self, vResult, int idx
inst self    : List インスタンス
var  vResult : 返値を格納する変数
int  idx     : 要素番号

%inst
リストの要素 [idx] の値を取得し、vResult に格納します。取り出した値はリストから取り除かれます。

%href
list_clone
list_ref

list_get
list_getv

list_pop
list_popv

list_remove

%group
メンバ関数::取得系

;--------------------
%index
list_vartype
List 型の取得

%prm
(self, idx)
inst self : リスト
int  idx  : 要素番号

%inst
リストの要素 [idx] の値の型を返します。

%href
;list_vartype

%group
メンバ関数::取得系

;--------------------
%index
list_set
List 値の変更

%prm
self, value, idx = 0
inst self  : List インスタンス
any  value : 設定する値
int  idx   : 要素番号

%inst
リストの要素 [idx] の値を value に変更します。

%href
list_set
list_setv

list_insert
list_insertv

list_double
list_add

%group
メンバ関数::操作系

;--------------------
%index
list_setv
List 値の変更 ( 変数 )

%prm
self, vValue, idx
inst self   : List インスタンス
var  vValue : 設定する値が格納された変数
int  idx    : 要素番号

%inst
リストの要素 [idx] に、vValue の値を設定します。

%href
list_set
list_setv

list_insert
list_insertv

list_double
list_add

%group
メンバ関数::操作系

;--------------------
%index
list_insert
List 要素の挿入

%prm
self, value, idx = 0
inst self  : List インスタンス
any  value : 挿入する要素の値
int  idx   : 新たな要素の番号

%inst
リストの [idx] に、新しい要素を挿入します。idx を省略する ( idx == 0 にする ) と、リストの先頭に追加されます。

idx は他のメンバのそれと違い、「idx >= list_size(...)」を許可します。この場合は、要素 [idx] に値を設定するために、要素を自動で生成します。

%href
list_set
list_setv

list_insert
list_insertv

list_double
list_add

%group
メンバ関数::操作系

;--------------------
%index
list_insertv
List 要素の挿入 ( 変数 )

%prm
self, vValue, idx
inst self   : List インスタンス
var  vValue : 挿入する要素の値が格納された変数
int  idx    : 新しい要素の番号

%inst
リストの [idx] に新しい要素を挿入します。

%href
list_set
list_setv

list_insert
list_insertv

list_double
list_add

%group
メンバ関数::操作系

;--------------------
%index
list_double
List 要素の倍化

%prm
self, idx
inst self : リスト
int  idx  : 要素番号

%inst
リストの [idx] の要素の直後に、同じ値の要素を挿入します。

%href
list_set
list_setv

list_insert
list_insertv

list_double
list_add

%group
メンバ関数::操作系

;--------------------
%index
list_add
List 要素の追加 ( 末尾 )

%prm
self, value
inst self  : List インスタンス
any  value : 追加する要素の値

%inst
リストの末尾に要素を追加します。

%href
list_set
list_setv

list_insert
list_insertv

list_double
list_add

%group
メンバ関数::操作系

;--------------------
%index
list_remove
List 要素の除去

%prm
self, idx
inst self : List インスタンス
int  idx  : 要素番号

%inst
リストの要素 [i] をリストから取り除きます。

%href
list_remove

%group
メンバ関数::操作系

;--------------------
%index
list_loc_move
List 要素の移動

%prm
self, from, to
inst self : List インスタンス
int  from : 移動前の要素番号
int  to   : 移動後の要素番号

%inst
リストの要素 [from] を、[to] の位置に移動させます。

※要素値の複写は発生しないので、低コストな処理です。

%href

%group
メンバ関数::順序操作系

;--------------------
%index
list_loc_swap
List 要素の交換

%prm
self, pos1, pos2
inst self : List インスタンス
int  pos1 : 交換する要素番号
int  pos2 : 〃

%inst
リストの要素 [pos1] と [pos2] を交換します。

※要素値の複写は発生しないので、低コストな処理です。

%href

%group
メンバ関数::順序操作系

;--------------------
%index
list_rotate
List 要素の巡回

%prm
self
inst self : List インスタンス

%inst
リストの要素をすべて、一つ前にずらします。つまり、先頭の要素を末尾に移動させる処理です。

%href
list_rotate
list_rotate_back

%group
メンバ関数::順序操作系

;--------------------
%index
list_rotate_back
List 要素の巡回 ( 逆回転 )

%prm
self
inst self : List インスタンス

%inst
リストの要素をすべて、一つ後ろにずらします。つまり、末尾の要素を先頭に移動させる処理で、list_rotate の丁度逆です。

%href
list_rotate
list_rotate_back

%group
メンバ関数::順序操作系

;--------------------
%index
list_reverse
List 要素順の反転

%prm
self
inst self : List インスタンス

%inst
リストの要素の順番を逆にします。

(ex) [1, 2, 3, 4] を反転すると [4, 3, 2, 1] になる。

%href

%group
メンバ関数::順序操作系

;--------------------
%index
list_clear
List 消去 [i]

%prm
self
inst self : List インスタンス

%inst
すべての要素をリストから取り除く統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
list_chain
List 連結 [i]

%prm
self, src
inst self : List インスタンス
inst src  : 〃

%inst
リスト src に含まれるすべての要素を、self の末尾に追加する統一関数です。src の要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
list_copy
List 複写 [i]

%prm
self, src
inst self : List インスタンス
inst src  : 〃

%inst
リスト src を self に複写する統一関数です。元々あったリストは list_clear によって消去されます。

%href
list_clear
list_chain

%group
メンバ関数::コンテナ操作系

;--------------------
%index
list_swap
List コンテナ交換 [i]

%prm
self, obj
inst self : List インスタンス
inst obj   : 〃

%inst
self と obj に含まれるすべての要素を交換します。それぞれの要素の順番は維持されます。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
list_iter_init
List 反復子::初期化 [i]

%prm
self, iterData
inst self     : List インスタンス
var  iterData : 反復情報

%inst
リストの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
list_iter_init
list_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
list_iter_next
List 反復子::更新 [i]

%prm
(self, vIt, iterData)
inst self    : List インスタンス
var vIt      : 反復子
var iterData : 反復情報

%inst
リストの反復子を更新する統一関数です。この返値が偽なら、次の反復を行わずに終了します。

@ alg_iter が内部で使用するだけです。

%href
list_iter_init
list_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
list_size
List 要素数 [i]

%prm
(self)
inst self : List インスタンス

%inst
リストに含まれる要素の数を返す統一関数です。

%note
list_count, list_length と同一。

%href

%group
メンバ関数

;--------------------
%index
list_isValid
List 要素番号が有効かどうか

%prm
(self, idx)
inst self : List インスタンス
int  idx  : 要素番号

%inst
リストの要素番号として idx が適切かどうかを返します。
適切な番号なら true ( 0 以外 ) を、不適切なら false ( = 0 ) を返します。

%href

%group
メンバ関数

;--------------------
%index
list_dbglog
List デバッグ出力

%prm
self
inst self : List インスタンス

%inst
リストのすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ
