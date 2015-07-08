;#############################
%dll
abdata_unor

%author
uedai

%date
2010 07/18 (Sun)	// 最終更新 表記など、いろいろ訂正
2009 10/04 (Sun)	// 
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
new_unor
Unor 構築 (一時)

%prm
()

%inst
新しく連想配列 (Unordered) を構築し、返します。

%href
new_unor
unor_new
unor_delete

%group
構築関数

;--------------------
%index
unor_new
Unor 構築

%prm
self
var self : インスタンスを格納する変数

%inst
連想配列を構築します。

%href
new_unor
unor_new
unor_delete

%group
構築関数

;--------------------
%index
unor_delete
Unor 解体

%prm
self
inst self : 連想配列

%inst
連想配列を解体します。

この関数はプログラム終了時、自動で呼び出されるため、通常、呼び出す必要はありません。

%href
new_unor
unor_new
unor_delete

%group
解体関数

;--------------------
%index
unor_get
Unor 値の取得

%prm
(self, key = "")
inst self : 連想配列
str  key  : キー

%inst
指定キーに関連づけられている要素の値を取得します。

キーがない場合、int(0) の値との組として追加します。

%href
unor_get
unor_getv
unor_pop
unor_popv
unor_clone
unor_ref

%group
メンバ関数::取得系

;--------------------
%index
unor_getv
Unor 値の取得 ( 変数 )

%prm
self, key = "", vResult
inst self    : 連想配列
str  key     : キー
var  vResult : 値を格納する変数

%inst
指定キーに関連づけられている要素の値を vResult に格納します。

キーがない場合、int(0) の値との組として追加します。

%href
unor_get
unor_getv
unor_pop
unor_popv
unor_clone
unor_ref

%group
メンバ関数::取得系

;--------------------
%index
unor_pop
Unor 値の取り出し

%prm
(self, key = "")
inst self : 連想配列
str  key  : キー

%inst
指定キーに関連づけられている要素の値を取り出して返します。その要素とキーの組は削除されます。

キーがない場合、int(0) の値との組として追加します。

%href
unor_get
unor_getv
unor_pop
unor_popv
unor_clone
unor_ref

%group
メンバ関数::取得系

;--------------------
%index
unor_popv
Unor 値の取り出し ( 変数 )

%prm
self, key = "", vResult
inst self    : 連想配列
str  key     : キー
var  vResult : 値を格納する変数

%inst
指定キーに関連づけられている要素の値を取り出して返します。その要素とキーの組は削除されます。

キーがない場合、int(0) の値との組として追加します。

%href
unor_get
unor_getv
unor_pop
unor_popv
unor_clone
unor_ref

%group
メンバ関数::取得系

;--------------------
%index
unor_clone
Unor 要素のクローン化 ( 変数 )

%prm
self, key, vRef
inst self : 連想配列
str  key  : キー
var  vRef : クローンにする変数

%inst
vRef を指定キーに関連づけられている要素のクローンにします。

キーがない場合、int(0) の値との組として追加します。

%href
unor_get
unor_getv
unor_pop
unor_popv
unor_clone
unor_ref

%group
メンバ関数::取得系

;--------------------
%index
unor_ref
Unor 参照

%prm
(self, key = "")
inst self : 連想配列
str  key  : キー

%inst
指定キーに関連づけられている要素のクローンを返します。

キーがない場合、int(0) の値との組として追加します。

%sample
	
	unor_new unor
	unor_add unor, "key", "Hello, world!"
	mes unor_ref(unor, "key")
	stop
	
%href
unor_get
unor_getv
unor_pop
unor_popv
unor_clone
unor_ref

%group
メンバ関数::取得系

;--------------------
%index
unor_vartype
Unor 型の取得

%prm
(self, key = "")
inst self : 連想配列
str  key  : キー

%inst
指定キーに関連づけられている要素の値の型を返します。

%href
;unor_vartype

%group
メンバ関数::取得系

;--------------------
%index
unor_add
Unor 要素の追加

%prm
self, key = "", value = 0
inst self  : 連想配列
str  key   : 追加するキー
any  value : 追加する要素の値

%inst
連想配列に、key のキーを持つ要素を追加します。

そのキーがすでに存在する場合、この命令は無視されます。
※この、キーが既存の場合の動作について、ご意見募集中です。ゆえに、仕様変更される可能性が非常に高いため、依存しないことを推奨します。

%href
unor_add
unor_addv

unor_set
unor_setv

%group
メンバ関数::操作系

;--------------------
%index
unor_addv
Unor 要素の追加 ( 変数 )

%prm
self, key, vValue
inst self   : 連想配列
str  key    : 追加するキー
var  vValue : 追加する要素の値を格納した変数

%inst
連想配列に、key のキーを持つ要素を追加します。

そのキーがすでに存在する場合、この命令は無視されます。
※この動作について、ご意見募集中です。ゆえに、仕様変更される可能性が非常に高いため、依存しないことを推奨します。

%href
unor_add
unor_addv

unor_set
unor_setv

%group
メンバ関数::操作系

;--------------------
%index
unor_set
Unor 値の設定

%prm
self, key = "", value
inst self  : 連想配列
str  key   : キー
any  value : 設定する値

%inst
指定キーに関連づけられている要素の値を value に変更します。キーがない場合は、追加されます。

%href
unor_add
unor_addv

unor_set
unor_setv

%group
メンバ関数::操作系

;--------------------
%index
unor_setv
Unor 値の設定 ( 変数 )

%prm
self, key, vValue
inst self   : 連想配列
str  key    : キー
var  vValue : 値を格納している変数

%inst
指定キーに関連づけられている要素の値を vValue の値に変更します。キーがない場合は、追加されます。

%href
unor_add
unor_addv

unor_set
unor_setv

%group
メンバ関数::操作系

;--------------------
%index
unor_remove
Unor 要素の削除

%prm
self, key
inst self : 連想配列
str  key  : キー

%inst
連想配列から、key のキーと、その値のペアを削除します。

そのキーが存在しない場合、この命令は無視されます。

%href

%group
メンバ関数::操作系

;--------------------
%index
unor_clear
Unor 消去 [i]

%prm
self
inst self : 連想配列

%inst
連想配列からすべての要素を取り除き、空にする統一関数です。

%href
unor_clear
unor_chain
unor_copy
unor_swap

%group
メンバ関数::コンテナ操作系

;--------------------
%index
unor_chain
Unor 結合 [i]

%prm
self, src
inst self : 連想配列
inst src  : 〃

%inst
連想配列 self に、連想配列 src が持つすべての要素を追加する統一関数です。

※self と src がともに持つキーの要素の扱いは、unor_add と同様です。

%href
unor_clear
unor_chain
unor_copy
unor_swap

%group
メンバ関数::コンテナ操作系

;--------------------
%index
unor_copy
Unor 複写 [i]

%prm
self, src
inst self : 連想配列
inst src  : 〃

%inst
連想配列 self を src と同じキーと要素を持つようにする統一関数です。元々 self にあったすべての要素は取り除かれます。

%href
unor_clear
unor_chain
unor_copy
unor_swap

%group
メンバ関数::コンテナ操作系

;--------------------
%index
unor_swap
Unor コンテナ交換 [i]

%prm
self, obj
inst self : 連想配列
inst obj  : 〃

%inst
2つの連想配列 self, obj の内容をすべて入れ替える統一関数です。

%href
unor_clear
unor_chain
unor_copy
unor_swap

%group
メンバ関数::コンテナ操作系

;--------------------
%index
unor_iterInit
Unor 反復子::初期化 [i]

%prm
self, iterData
inst self     : 連想配列
var  iterData : 反復子情報

%inst
連想配列の反復子を初期化する統一関数です。

%href
unor_iterInit
unor_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
unor_iterNext
Unor 反復子::更新 [i]

%prm
(self, vIt, iterData)
inst self     : 連想配列
var  vIt      : it 変数
var  iterData : 反復子情報

%inst
連想配列の反復子を更新する統一関数です。

it 変数 vIt には、キーの文字列が格納されます。

%href
unor_iterInit
unor_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
unor_size
Unor 要素数 [i]

%prm
(self)
inst self : 連想配列

%inst
連想配列に含まれる要素の数を返す統一関数です。

unor_count を推奨しておきます。

%note
unor_count, unor_length と同じ。

%href

%group
メンバ関数

;--------------------
%index
unor_exists
Unor キーの有無

%prm
(self, key)
inst self : 連想配列
str  key  : キー

%inst
指定キーが存在するかどうかを返します。存在する場合は真 (!= 0) を、存在しない場合は偽 (= 0) を返します。

%href

%group
メンバ関数

;--------------------
%index
unor_dbglog
Unor デバッグ出力

%prm
self
inst self : 連想配列

%inst
連想配列に含まれるすべての要素を logmes で出力します。

%href

%group
メンバ関数::デバッグ系
