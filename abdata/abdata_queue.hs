;#############################
%dll
abdata_queue

%author
uedai

%date
2009 09/02 (Wed)	// 最終更新
2009 08/30 (Sun)	// Deque のラッパに変更、リファレンス作成
2009 05/10 (Sun)	// List のラッパに変更
2008 09/0X (___)	// 作成

%ver
1.0

%type
抽象データ構造 キュー

;%group
;$(default_group)

;--------------------
%index
Queue_new
Queue 構築

%prm
self
modvar self : モジュール変数

%inst
キュー (Queue) を構築します。

%href
Queue_new
Queue_delete

%group
構築関数

;--------------------
%index
Queue_delete
Queue 解体

%prm
self
modvar self : モジュール変数

%inst
キュー (Queue) を解体します。すべての要素がキューから取り除かれ、キューとして無効になります。

%href
Queue_new
Queue_delete

%group
解体関数

;--------------------
%index
Queue_size
Queue 要素数 [i]

%prm
(self)
modvar self : キュー

%inst
キューに積まれている要素の数を返す統一関数です。

%href

%group
メンバ関数

;--------------------
html{
<!--
%index
Queue_isValid
Queue オフセットが有効か

%prm
(self, i)
modvar self : キュー
int    i    : オフセット

%inst
キューで、オフセット値 i が有効かどうか調べます。要素数以上、または負数である場合、偽を返します。

オフセットは本来必要ではありませんが、Queue_peek, Queue_peekv で使われます。

%href

%group
メンバ関数
-->
}

;--------------------
%index
Queue_peekv
Queue 値の取得 ( 変数 )

%prm
self, result, i = 0
modvar self    : キュー
var    result  : 戻り値を格納する変数
int    i       : オフセット値

%inst
キューの要素の値を result に格納します。Queue_popv とは違い、取り出した要素はキューから取り除かれません。

%href
Queue_pop
Queue_popv
Queue_peek
Queue_peekv

%group
メンバ関数::取得系

;--------------------
%index
Queue_peek
Queue 値の取得

%prm
(self, i = 0)
modvar self : キュー
int    i    : オフセット値

%inst
キューの要素の値を取得して返します。Queue_pop とは違い、取り出した要素がキューから取り除かれるということはありません。

%href
Queue_pop
Queue_popv
Queue_peek
Queue_peekv

%group
メンバ関数::取得系

;--------------------
%index
Queue_popv
Queue 値の取得 ( 変数 )

%prm
self, result
modvar self   : キュー
var    result : 戻り値を格納する変数

%inst
キューの先頭の要素の値を取り出して、result に格納します。取り出した要素は、キューから取り除かれます。

%href
Queue_pop
Queue_popv
Queue_peek
Queue_peekv

%group
メンバ関数::取得系

;--------------------
%index
Queue_pop
Queue 値の取得

%prm
(self)
modvar self : キュー

%inst
キューの先頭の要素の値を取り出して返します。取り出された要素はキューから取り除かれます。

%href
Queue_pop
Queue_popv
Queue_peek
Queue_peekv

%group
メンバ関数::取得系

;--------------------
%index
Queue_push
Queue 値の追加

%prm
self, value
modvar self  : キュー
any    value : 新しい要素のもつ値

%inst
キューに値を push します ( つまり、要素を末尾に追加します )。

※ Queue_push_back と同じ。

%href
Queue_push
Queue_pushv

%group
メンバ関数::操作系

;--------------------
%index
Queue_pushv
Queue 値の追加 ( 変数 )

%prm
self, vValue
modvar self   : キュー
var    vValue : 新しい要素のもつ値が格納された変数

%inst
キューに新しい要素を push します ( つまり、末尾に要素を追加します )。

%href
Queue_push
Queue_pushv

%group
メンバ関数::操作系

;--------------------
%index
Queue_clear
Queue 消去 [i]

%prm
self
modvar self : キュー

%inst
キューからすべての要素を取り除いて空にする統一関数です。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Queue_chain
Queue 連結 [i]

%prm
self, mvFrom
modvar self   : キュー
modvar mvFrom : 〃

%inst
キューに mvFrom の要素をすべて push する統一関数です。要素の順序は保たれます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Queue_copy
Queue 複写 [i]

%prm
self, mvFrom
modvar self   : キュー
modvar mvFrom : 〃

%inst
キューの要素をすべて mvFrom と同じにする統一関数です。もともとあった要素は、キューから取り除かれます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Queue_exchange
Queue コンテナ交換 [i]

%prm
self, mv2
modvar self : キュー
modvar mv2  : 〃

%inst
self と mv2 のすべての要素を交換する統一関数です。それぞれの要素の順序は保たれます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Queue_dbglog
Queue デバッグ出力

%prm
self
modvar self : キュー

%inst
キューのすべての要素を logmes で出力します。

リリース時には無効になります。

%href

%group
メンバ関数::デバッグ
