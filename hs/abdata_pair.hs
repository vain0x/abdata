;#############################
%dll
abdata_pair

%author
uedai

%date
2010 07/15 (Sat)	// 最終更新
2010 06/25 (Fri)	// 
2009 09/02 (Wed)	// 
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
new_pair
Pair 構築 (一時)

%prm
([lhs], [rhs])
var lhs  : 初期左値
var rhs  : 初期右値

%inst
新しくペア (Pair) を構築し、返します。初期値は <lhs, rhs> です ( 省略可 )。どちらも、初期値が省略された要素は 0 が格納されます。

%href
new_pair
pair_new
pair_delete

%group
構築関数

;--------------------
%index
pair_new
Pair 構築

%prm
self, [lhs], [lhs]
inst self : モジュール変数
any  lhs  : 初期左値
any  rhs  : 初期右値

%inst
ペア (Pair) を構築します。初期値は <lhs, rhs> です ( 省略可 )。どちらも、初期値が省略された要素は 0 が格納されます。

ペアの要素番号は、lhs, rhs の順に 0, 1 で、この値は定数 PairIdx_Lhs, PairIdx_Rhs で得られます。

%href
new_pair
pair_new
pair_delete

%group
構築関数

;--------------------
%index
pair_delete
Pair 解体

%prm
self
inst self : Pair インスタンス

%inst
ペア (Pair) を解体します。

この関数はプログラム終了時に自動で呼び出されるため、通常、呼び出す必要はありません。

%href
new_pair
pair_new
pair_delete

%group
解体関数

;--------------------
%index
pair_set
Pair 値の変更

%prm
self, value, idx
inst self  : Pair インスタンス
any  value : 値
int  idx   : 要素番号

%inst
ペアの値の片方を value に設定します。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::操作系

;--------------------
%index
pair_setv
Pair 値を設定 ( 変数 )

%prm
self, vValue, idx
inst self   : Pair インスタンス
var  vValue : 値が格納された変数
int  idx    : 要素番号

%inst
ペアの片方の要素に値を設定します。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::操作系

;--------------------
%index
pair_set_lhs
Pair 値を設定 (lhs)

%prm
self, value
inst self  : Pair インスタンス
any  value : 設定する値

%inst
ペアの lhs に値を設定します。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::操作系

;--------------------
%index
pair_set_rhs
Pair 値を設定 (lhs)

%prm
self, value
inst self  : Pair インスタンス
any  value : 設定する値

%inst
ペアの rhs に値を設定します。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::操作系

;--------------------
%index
pair_set_both
Pair 値の変更 (両方)

%prm
self, valueLhs, valueRhs
inst self     : Pair インスタンス
any  valueLhs : lhs 値
any  valueRhs : rhs 値

%inst
ペアの値を <valueLhs, valueRhs> に設定します。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::操作系

;--------------------
%index
pair_setv_both
Pair 値の変更 (両方) (変数)

%prm
self, vLhs, vRhs
inst self : Pair インスタンス
var  vLhs : lhs 値
var  vRhs : rhs 値

%inst
ペアの値を <vLhs, vRhs> それぞれの値に設定します。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::操作系

;--------------------
%index
pair_clone
Pair 要素の参照化

%prm
self, vRef, idx
inst self : Pair インスタンス
var  vRef : クローン化する変数
int  idx  : 要素番号

%inst
vRef を、片方のクローンにします。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::取得系

;--------------------
%index
pair_clone_lhs
Pair クローン化 (lhs)

%prm
self, vRef
inst self : Pair インスタンス
var  vRef : クローン化する変数

%inst
vRef を lhs のクローンにします。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::取得系

;--------------------
%index
pair_clone_rhs
Pair クローン化 (rhs)

%prm
self, vRef
inst self : Pair インスタンス
var  vRef : クローン化する変数

%inst
vRef を rhs のクローンにします。

%href
pair_set
pair_setv
pair_set_lhs
pair_set_rhs

pair_set_both
pair_setv_both

pair_clone
pair_clone_lhs
pair_clone_rhs

%group
メンバ関数::取得系

;--------------------
%index
pair_getv
Pair 値の取得 ( 変数 )

%prm
self, vResult, idx
inst self    : Pair インスタンス
var  vResult : 値を格納する変数
int  idx     : 要素番号

%inst
片方の要素の値を vResult に格納します。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_get
Pair 値の取得

%prm
(self, idx)
inst self : Pair インスタンス
int  idx  : 要素番号

%inst
片方の要素の値を取得して返す。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_getv_lhs
Pair 値の取得 (lhs) ( 変数 )

%prm
self, vResult
inst self    : Pair インスタンス
var  vResult : 返値を格納する変数

%inst
lhs の値を vResult に格納します。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_getv_rhs
Pair 値の取得 (rhs) ( 変数 )

%prm
self, vResult
inst self    : Pair インスタンス
var  vResult : 返値を格納する変数

%inst
rhs の値を vResult に格納します。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_getv_both
Pair 値の取得 (both) ( 変数 )

%prm
self, vResultLhs, vResultRhs
inst self       : Pair インスタンス
var  vResultLhs : lhs の値を格納する変数
var  vResultRhs : rhs の値を格納する変数

%inst
lhs, rhs の値をそれぞれ vResultLhs, vResultRhs に格納します。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_get_lhs
Pair 値の取得 (lhs)

%prm
(self)
inst self : Pair インスタンス

%inst
lhs の値を取得して返します。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_get_rhs
Pair 値の取得 (rhs)

%prm
(self)
inst self : Pair インスタンス

%inst
rhs の値を取得して返します。

%href
pair_get
pair_getv
pair_get_lhs
pair_get_rhs
pair_getv_lhs
pair_getv_rhs
pair_getv_both

%group
メンバ関数::取得系

;--------------------
%index
pair_vartype
Pair 型の取得

%prm
(self, idx)
inst self : Pair インスタンス
int  idx  : 要素番号

%inst
ペアの片方の要素の値の型を返します。

%href
pair_vartype
pair_vartype_lhs
pair_vartype_rhs

%group
メンバ関数::取得系

;--------------------
%index
pair_vartype_lhs
Pair 型の取得 (lhs)

%prm
(self)
inst self : ペア

%inst
ペアの要素 lhs の値の型を返します。

%href
pair_vartype
pair_vartype_lhs
pair_vartype_rhs

%group
メンバ関数::取得系

;--------------------
%index
pair_vartype_rhs
Pair 型の取得 (rhs)

%prm
(self)
inst self : ペア

%inst
ペアの要素 rhs の値の型を返します。

%href
pair_vartype
pair_vartype_lhs
pair_vartype_rhs

%group
メンバ関数::取得系

;--------------------
%index
pair_loc_swap
Pair 要素の交換

%prm
self
inst self : Pair インスタンス

%inst
lhs と rhs の値を交換します。

%href

%group
メンバ関数::操作系

;--------------------
%index
pair_clear
Pair 消去 [i]

%prm
self
inst self : Pair インスタンス

%inst
lhs と rhs を共に初期値 (int(0)) にする統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
pair_copy
Pair 複写 [i]

%prm
self, src
inst self : Pair インスタンス
inst src  : 〃

%inst
self の <lhs, rhs> それぞれに、src の <lhs, rhs> を格納する統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
pair_chain
Pair 連結 [i] [!E]

%prm
self, src
inst self : Pair インスタンス
inst src  : 〃

%inst
Pair に統一関数「連結(chain)」はありません。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
pair_swap
Pair コンテナ交換 [i]

%prm
self, obj
inst self : Pair インスタンス
inst obj  : 〃

%inst
self と obj のすべての要素を交換する統一関数です。

%href

%group
メンバ関数::コンテナ操作系

;--------------------
%index
pair_size
Pair 要素数 [i]

%prm
(self)
inst self : Pair インスタンス

%inst
ペアの要素数を返す統一関数です。
仕様上、必ず 2 を返します。

%href

%group
メンバ関数

;--------------------
%index
pair_iter_init
Pair 反復子::初期化

%prm
self, vIt
inst self : Pair インスタンス
var  vIt  : 反復情報

%inst
ペアの反復子を初期化する統一関数です。

@ alg_iter が内部で使用するだけです。

%href
pair_iter_init
pair_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
pair_iter_next
Pair 反復子::更新

%prm
(self, vIt, iterData)
inst self     : Pair インスタンス
var  vIt      : Pair の反復子
var  iterData : 反復情報

%inst
ペアの反復子を更新します。返値が偽( false == 0 )の場合、繰り返しを行わずに終了します。

@ alg_iter が内部で使用するだけです。

%href
pair_iter_init
pair_iter_next

%group
メンバ関数::反復子操作系

;--------------------
%index
PairIdx_Lhs
Pair 要素番号 定数 (lhs)

%prm

%inst
ペアの lhs の要素番号を表す定数です。

%href
;PairIdx_Lhs
PairIdx_Rhs

%group
メンバ定数::要素番号

;--------------------
%index
PairIdx_Rhs
Pair 要素番号 定数 (rhs)

%prm

%inst
ペアの rhs の要素番号を表す定数です。

%href
PairIdx_Lhs
;PairIdx_Rhs

%group
メンバ定数::要素番号
