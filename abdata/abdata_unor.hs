;#############################
%dll
abdata_unor

%author
uedai

%date
2009 09/04 (Fri)	// 最終更新
2009 09/03 (Thu)	// 作成

%ver
1.0

%type
抽象データ構造 連想配列 ( 不整列コンテナ )

%group
メンバ関数

%url
http://prograpark.ninja-web.net/

;--------------------
%index
Unor_new
Unor 構築

%prm
self
modvar self : モジュール変数

%inst
連想配列を構築します。

%href
Unor_new
Unor_delete

%group
構築関数

;--------------------
%index
Unor_delete
Unor 解体

%prm
self
modvar self : モジュール変数

%inst
連想配列を解体します。

%href
Unor_new
Unor_delete

%group
解体関数

;--------------------
%index
Unor_get
Unor 値の取得

%prm
(self, key = "")
modvar self : 連想配列
str    key  : キー

%inst
指定キーに関連づけられている要素の値を取得します。

キーがない場合、int(0) の値との組として追加します。

%href
Unor_get
Unor_getv
Unor_pop
Unor_popv
Unor_dup
Unor_ref

%group
メンバ関数::取得系

;--------------------
%index
Unor_getv
Unor 値の取得 ( 変数 )

%prm
self, key = "", vResult
modvar self    : 連想配列
str    key     : キー
var    vResult : 値を格納する変数

%inst
指定キーに関連づけられている要素の値を vResult に格納します。

キーがない場合、int(0) の値との組として追加します。

%href
Unor_get
Unor_getv
Unor_pop
Unor_popv
Unor_dup
Unor_ref

%group
メンバ関数::取得系

;--------------------
%index
Unor_pop
Unor 値の取り出し

%prm
(self, key = "")
modvar self : 連想配列
str    key  : キー

%inst
指定キーに関連づけられている要素の値を取り出して返します。その要素とキーの組は削除されます。

キーがない場合、int(0) の値との組として追加します。

%href
Unor_get
Unor_getv
Unor_pop
Unor_popv
Unor_dup
Unor_ref

%group
メンバ関数::取得系

;--------------------
%index
Unor_popv
Unor 値の取り出し ( 変数 )

%prm
self, key = "", vResult
modvar self    : 連想配列
str    key     : キー
var    vResult : 値を格納する変数

%inst
指定キーに関連づけられている要素の値を取り出して返します。その要素とキーの組は削除されます。

キーがない場合、int(0) の値との組として追加します。

%href
Unor_get
Unor_getv
Unor_pop
Unor_popv
Unor_dup
Unor_ref

%group
メンバ関数::取得系

;--------------------
%index
Unor_dup
Unor 要素の参照化 ( 変数 )

%prm
self, key, vRef
modvar self : 連想配列
str    key  : キー
var    vRef : 参照にする変数

%inst
vRef を指定キーに関連づけられている要素のクローンにします。

キーがない場合、int(0) の値との組として追加します。

%href
Unor_get
Unor_getv
Unor_pop
Unor_popv
Unor_dup
Unor_ref

%group
メンバ関数::取得系

;--------------------
%index
Unor_ref
Unor 参照

%prm
(self, key = "")
modvar self : 連想配列
key    str  : キー

%inst
指定キーに関連づけられている要素のクローンを返します。

キーがない場合、int(0) の値との組として追加します。

%sample
	
	Unor_new unor
	Unor_add unor, "key", "Hello, world!"
	mes Unor_ref(unor, "key")
	stop
	
%href
Unor_get
Unor_getv
Unor_pop
Unor_popv
Unor_dup
Unor_ref

%group
メンバ関数::取得系

;--------------------
%index
Unor_add
Unor 要素の追加

%prm
self, key = "", value = 0
modvar self  : 連想配列
str    key   : 追加するキー
any    value : 追加する要素の値

%inst
連想配列に、key のキーを持つ要素を追加します。

そのキーがすでに存在する場合、この命令は無視されます。
※この動作について、ご意見募集中です。ゆえに、仕様変更される可能性が非常に高いため、依存しないことを推奨します。

%href
Unor_add
Unor_addv

Unor_set
Unor_setv

%group
メンバ関数::操作系

;--------------------
%index
Unor_addv
Unor 要素の追加 ( 変数 )

%prm
self, key, vValue
modvar self   : 連想配列
str    key    : 追加するキー
var    vValue : 追加する要素の値を格納した変数

%inst
連想配列に、key のキーを持つ要素を追加します。

そのキーがすでに存在する場合、この命令は無視されます。
※この動作について、ご意見募集中です。ゆえに、仕様変更される可能性が非常に高いため、依存しないことを推奨します。

%href
Unor_add
Unor_addv

Unor_set
Unor_setv

%group
メンバ関数::操作系

;--------------------
%index
Unor_set
Unor 値の設定

%prm
self, key = "", value
modvar self  : 連想配列
str    key   : キー
any    value : 設定する値

%inst
指定キーに関連づけられている要素の値を value に変更します。キーがない場合は、追加されます。

%href
Unor_add
Unor_addv

Unor_set
Unor_setv

%group
メンバ関数::操作系

;--------------------
%index
Unor_setv
Unor 値の設定 ( 変数 )

%prm
self, key, vValue
modvar self   : 連想配列
str    key    : キー
var    vValue : 値を格納している変数

%inst
指定キーに関連づけられている要素の値を vValue の値に変更します。キーがない場合は、追加されます。

%href
Unor_add
Unor_addv

Unor_set
Unor_setv

%group
メンバ関数::操作系

;--------------------
%index
Unor_remove
Unor 要素の削除

%prm
self, key
modvar self : 連想配列
str    key  : キー

%inst
連想配列から、key のキーと、その値のペアを削除します。

そのキーが存在しない場合、この命令は無視されます。

%href

%group
メンバ関数::操作系

;--------------------
%index
Unor_clear
Unor 消去 [i]

%prm
self
modvar self : 連想配列

%inst
連想配列からすべての要素を取り除き、空にする統一関数です。

%href
Unor_clear
Unor_chain
Unor_copy
Unor_exchange

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Unor_chain
Unor 結合 [i]

%prm
self, mvFrom
modvar self   : 連想配列
modvar mvFrom : 〃

%inst
連想配列 self に、連想配列 mvFrom が持つすべての要素を追加する統一関数です。

※self と mvFrom がともに持つキーの要素の扱いは、Unor_add と同様です。

%href
Unor_clear
Unor_chain
Unor_copy
Unor_exchange

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Unor_copy
Unor 複写 [i]

%prm
self, mvFrom
modvar self   : 連想配列
modvar mvFrom : 〃

%inst
連想配列 self を mvFrom と同じキーと要素を持つようにする統一関数です。元々 self にあったすべての要素は取り除かれます。

%href
Unor_clear
Unor_chain
Unor_copy
Unor_exchange

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Unor_exchange
Unor コンテナ交換 [i]

%prm
self, mv2
modvar self : 連想配列
modvar mv2  : 〃

%inst
2つの連想配列 self, mv2 の内容をすべて入れ替える統一関数です。

%href
Unor_clear
Unor_chain
Unor_copy
Unor_exchange

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Unor_iterInit
Unor 反復子::初期化 [i]

%prm
self, iterData
modvar self     : 連想配列
var    iterData : 反復子情報

%inst
連想配列の反復子を初期化する統一関数です。

%href
Unor_iterInit
Unor_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
Unor_iterNext
Unor 反復子::更新 [i]

%prm
(self, vIt, iterData)
modvar self     : 連想配列
var    vIt      : it 変数
var    iterData : 反復子情報

%inst
連想配列の反復子を更新する統一関数です。

it 変数 vIt には、キーの文字列が格納されます。

%href
Unor_iterInit
Unor_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
Unor_size
Unor 要素数 [i]

%prm
(self)
modvar self : 連想配列

%inst
連想配列に含まれる要素の数を返す統一関数です。

Unor_count を推奨しておきます。

%note
Unor_count(), Unor_length() と同じ。

%href

%group
メンバ関数

;--------------------
%index
Unor_exists
Unor キーの有無

%prm
(self, key)
modvar self : 連想配列
str    key  : キー

%inst
指定キーが存在するかどうかを返します。存在する場合は真(!= 0)を、存在しない場合は偽(= 0)を返します。

%href

%group
メンバ関数

;--------------------
%index
Unor_dbglog
Unor デバッグ出力

%prm
self
modvar self : 連想配列

%inst
連想配列に含まれるすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ系
