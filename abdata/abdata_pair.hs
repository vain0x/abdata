;#############################
%dll
abdata_pair

%author
uedai

%date
2009 09/02 (Wed)	// 最終更新
2009 04/08 (Wed)	// 作成

%ver
1.0

%type
抽象データ構造 ペア

%group
メンバ関数

%url
http://prograpark.ninja-web.net/

;--------------------
%index
Pair_new
Pair 構築

%prm
self, [value1], [value2]
modvar self : モジュール変数
any value1  : 値 first
any value2  : 値 second

%inst
ペア (Pair) を構築します。初期値は (value1, value 2) です ( 省略可 )。

%href
Pair_new
Pair_delete

%group
構築関数

;--------------------
%index
Pair_delete
Pair 解体

%prm
self
modvar self : モジュール変数

%inst
ペア (Pair) を解体します。

%href
Pair_new
Pair_delete

%group
解体関数

;--------------------
%index
Pair_set
Pair 値の変更

%prm
self, value, b = 0
modvar self  : Pair インスタンス
any    value : 値
int    b     : 0 => first, 1 => second

%inst
ペアの値の片方を value に設定します。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::操作系

;--------------------
%index
Pair_setv
Pair 値を設定 ( 変数 )

%prm
self, vValue, b
modvar self   : Pair インスタンス
var    vValue : 値が格納された変数
int    b      : 0 => first, 1 => second

%inst
ペアの片方の要素に値を設定します。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::操作系

;--------------------
%index
Pair_setFirst
Pair 値を設定[first]

%prm
self, value
modvar self  : Pair インスタンス
any    value : 設定する値

%inst
ペアの first に値を設定します。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::操作系

;--------------------
%index
Pair_setSecond
Pair 値を設定[second]

%prm
self, value
modvar self  : Pair インスタンス
any    value : 設定する値

%inst
ペアの second に値を設定します。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::操作系

;--------------------
%index
Pair_dup
Pair 要素の参照化

%prm
self, vRef, b
modvar self : Pair インスタンス
var    vRef : 参照化する変数
int    b    : 0 => first, 1 => second

%inst
vRef を、b == 0 なら first の、b == 1 なら second の参照 ( クローン ) にします。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_dupFirst
Pair 参照化[first]

%prm
self, vRef
modvar self : Pair インスタンス
var    vRef : 参照化する変数

%inst
vRef を first の参照にします。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_dupSecond
Pair 参照化[second]

%prm
self, vRef
modvar self : Pair インスタンス
var    vRef : 参照化する変数

%inst
vRef を second の参照にします。

%href
Pair_set
Pair_setv
Pair_setFirst
Pair_setSecond
Pair_dup
Pair_dupFirst
Pair_dupSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_getv
Pair 値の取得 ( 変数 )

%prm
self, vResult, b
modvar self    : Pair インスタンス
var    vResult : 値を格納する変数
int    b       : 0 => first, 1 => second

%inst
片方の要素の値を vResult に格納します。

%href
Pair_get
Pair_getv
Pair_getFirst
Pair_getSecond
Pair_getvFirst
Pair_getvSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_get
Pair 値の取得

%prm
(self, b)
modvar self : Pair インスタンス
int    b    : 0 => first, 1 => second

%inst
片方の要素の値を取得して返す。

%href
Pair_get
Pair_getv
Pair_getFirst
Pair_getSecond
Pair_getvFirst
Pair_getvSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_getvFirst
Pair 値の取得[first] ( 変数 )

%prm
self, vResult
modvar self    : Pair インスタンス
var    vResult : 戻り値を格納する変数

%inst
first の値を vResult に格納します。

%href
Pair_get
Pair_getv
Pair_getFirst
Pair_getSecond
Pair_getvFirst
Pair_getvSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_getvSecond
Pair 値の取得[second] ( 変数 )

%prm
self, vResult
modvar self    : Pair インスタンス
var    vResult : 戻り値を格納する変数

%inst
second の値を vResult に格納します。

%href
Pair_get
Pair_getv
Pair_getFirst
Pair_getSecond
Pair_getvFirst
Pair_getvSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_getFirst
Pair 値の取得[first]

%prm
(self)
modvar self : Pair インスタンス

%inst
first の値を取得して返します。

%href
Pair_get
Pair_getv
Pair_getFirst
Pair_getSecond
Pair_getvFirst
Pair_getvSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_getSecond
Pair 値の取得[second]

%prm
(self)
modvar self : Pair インスタンス

%inst
second の値を取得して返します。

%href
Pair_get
Pair_getv
Pair_getFirst
Pair_getSecond
Pair_getvFirst
Pair_getvSecond

%group
メンバ関数::取得系

;--------------------
%index
Pair_swap
Pair 要素の交換

%prm
self
modvar self : Pair インスタンス

%inst
first と second の値を交換します。

%href

%group
メンバ関数::操作系

;--------------------
%index
Pair_clear
Pair 消去 [i]

%prm
self
modvar self : Pair インスタンス

%inst
first と second を初期値( int(0) )にする統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Pair_copy
Pair 複写 [i]

%prm
self, mvFrom
modvar self   : Pair インスタンス
modvar mvFrom : 〃

%inst
self の first, second それぞれに、mvFrom の first, second を格納する統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Pair_chain
Pair 連結 [i]

%prm
self, mvFrom
modvar self   : Pair インスタンス
modvar mvFrom : 〃

%inst
Pair に統一関数「連結(chain)」はありません。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Pair_exchange
Pair コンテナ交換 [i]

%prm
self, mv2
modvar self : Pair インスタンス
modvar mv2  : 〃

%inst
self と mv2 のすべての要素を交換する統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
Pair_size
Pair 要素数 [i]

%prm
(self)
modvar self : Pair インスタンス

%inst
ペアの要素数を返す統一関数です。必ず 2 を返します。

%href

%group
メンバ関数

;--------------------
%index
Pair_iterInit
Pair 反復子::初期化

%prm
self, vIt
modvar self : Pair インスタンス
var    vIt  : 反復情報

%inst
ペアの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
Pair_iterInit
Pair_iterNext

%group
メンバ関数::反復子操作系

;--------------------
%index
Pair_iterNext
Pair 反復子::更新

%prm
(self, vIt, iterData)
modvar self  : Pair インスタンス
var vIt      : Pair の反復子
var iterData : 反復情報

%inst
ペアの反復子を更新します。戻り値が偽( false == 0 )の場合、繰り返しを行わずに終了します。

@ alg_iter が内部で使用するだけです。

%href
Pair_iterInit
Pair_iterNext

%group
メンバ関数::反復子操作系
