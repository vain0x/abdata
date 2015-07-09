;#############################
%dll
abdata_queue

%author
uedai

%date
2010 07/18 (Sun)	// 最終更新 表記など、いろいろ訂正
2009 10/04 (Sun)	// 
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
queue_new
Queue 構築

%prm
self
var self : Queue を構築する変数

%inst
キュー (Queue) を構築します。

%href
new_queue
queue_new
queue_delete

%group
構築関数

;--------------------
%index
queue_delete
Queue 解体

%prm
self
inst self : キュー

%inst
キュー (Queue) を解体します。すべての要素がキューから取り除かれ、キューとして無効になります。

%href
new_queue
queue_new
queue_delete

%group
解体関数

;--------------------
%index
queue_size
Queue 要素数 [i]

%prm
(self)
inst self : キュー

%inst
キューに積まれている要素の数を返す統一関数です。

%href

%group
メンバ関数

;--------------------
html{
<!--
%index
queue_isValid
Queue オフセットが有効か

%prm
(self, offset)
inst self   : キュー
int  offset : オフセット

%inst
キューで、オフセット値 offset が有効な値かどうか調べます。要素数以上、または負数である場合、偽を返します。

オフセットは本来必要ではありませんが、queue_peek, queue_peekv で使われます。

%href

%group
メンバ関数
-->
}

;--------------------
%index
queue_push
Queue 値の追加

%prm
self, value
inst self  : キュー
any  value : 新しい要素のもつ値

%inst
キューに値を push します ( つまり、要素を末尾に追加します )。

※ queue_push_back と同じ。

%href
queue_push
queue_pushv

%group
メンバ関数::操作系

;--------------------
%index
queue_pushv
Queue 値の追加 ( 変数 )

%prm
self, vValue
inst self   : キュー
var  vValue : 新しい要素のもつ値が格納された変数

%inst
キューに新しい要素を push します ( つまり、末尾に要素を追加します )。

%href
queue_push
queue_pushv

%group
メンバ関数::操作系

;--------------------
%index
queue_peekv
Queue 値の取得 ( 変数 )

%prm
self, result, offset = 0
inst self   : キュー
var  result : 返値を格納する変数
int  offset : オフセット値

%inst
キューの要素の値を result に格納します。queue_popv とは違い、取り出した要素はキューから取り除かれません。

%href
queue_pop
queue_popv
queue_peek
queue_peekv
queue_clone
queue_ref

%group
メンバ関数::取得系

;--------------------
%index
queue_peek
Queue 値の取得

%prm
(self, offset = 0)
inst self   : キュー
int  offset : オフセット値

%inst
キューの要素の値を取得して返します。queue_pop とは違い、取り出した要素がキューから取り除かれるということはありません。

%href
queue_pop
queue_popv
queue_peek
queue_peekv
queue_clone
queue_ref

%group
メンバ関数::取得系

;--------------------
%index
queue_popv
Queue 値の取得 ( 変数 )

%prm
self, result
inst self   : キュー
var  result : 返値を格納する変数

%inst
キューの先頭の要素の値を取り出して、result に格納します。取り出した要素は、キューから取り除かれます。

%href
queue_pop
queue_popv
queue_peek
queue_peekv
queue_clone
queue_ref

%group
メンバ関数::取得系

;--------------------
%index
queue_pop
Queue 値の取得

%prm
(self)
inst self : キュー

%inst
キューの先頭の要素の値を取り出して返します。取り出された要素はキューから取り除かれます。

%href
queue_pop
queue_popv
queue_peek
queue_peekv
queue_clone
queue_ref

%group
メンバ関数::取得系

;--------------------
%index
queue_clone
Queue クローンの作成 (命令)

%prm
self, result, offset
inst self   : キュー
var  result : クローンにする変数
int  offset : オフセット量

%inst
キュー内の値のクローンを作ります。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、先頭の要素です。

%href
queue_pop
queue_popv
queue_peek
queue_peekv
queue_clone
queue_ref

%group
メンバ関数::取得系

;--------------------
%index
stack_ref
Stack クローンの作成 (関数)

%prm
(self, offset)
inst self   : スタック
int  offset : オフセット量

%inst
キュー内の値のクローンを作り、返します。これは値として正常でない場合があるため、代入文の右辺以外では使用しないでください。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

%href
queue_pop
queue_popv
queue_peek
queue_peekv
queue_clone
queue_ref

%group
メンバ関数::取得系

;--------------------
%index
queue_vartype
Queue 型の取得

%prm
(self, offset = 0)
inst self   : キュー
int  offset : オフセット( 省略時: 先頭への offset )

%inst
キューの要素の値の型を返します。

%href
queue_vartype

%group
メンバ関数::取得系

;--------------------
%index
queue_erase
Queue 要素の除去

%prm
self
inst self  : キュー

%inst
キューの先頭の要素を取り除きます。

%href
;queue_erase

%group
メンバ関数::コンテナ操作系

;--------------------
%index
queue_clear
Queue 消去 [i]

%prm
self
inst self : キュー

%inst
キューからすべての要素を取り除いて空にする統一関数です。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
queue_chain
Queue 連結 [i]

%prm
self, src
inst self : キュー
inst src  : 〃

%inst
キューに src の要素をすべて push する統一関数です。要素の順序は保たれます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
queue_copy
Queue 複写 [i]

%prm
self, src
inst self : キュー
inst src  : 〃

%inst
キューの要素をすべて src と同値にする統一関数です。もともとあった要素は、キューから取り除かれます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
queue_swap
Queue コンテナ交換 [i]

%prm
self, obj
inst self : キュー
inst obj  : 〃

%inst
self と obj のすべての要素を交換する統一関数です。それぞれの要素の順序は保たれます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
queue_dbglog
Queue デバッグ出力

%prm
self
inst self : キュー

%inst
キューのすべての要素を logmes で出力します。
文字列型に変換できない値がキューの要素に含まれる場合、この命令は途中で失敗(エラー終了)します。

この命令は、リリース時には無効になります。

%href

%group
メンバ関数::デバッグ
