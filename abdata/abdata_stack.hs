;#############################
%dll
abdata_stack

%author
uedai

%date
2009 09/02 (Wed)	// 最終更新
2009 08/30 (Sun)	// Deque のラッパに変更
2009 08/29 (Sat)	// リファレンス作成
2008 09/0X (___)	// 作成

%ver
1.0

%type
抽象データ構造 スタック

;%group
;$(default_group)

;--------------------
%index
Stack_new
Stack 構築

%prm
self
modvar self : モジュール変数

%inst
スタック (stack) を構築します。
self がすでにモジュール型の場合、新しい要素に追加されます。

%href
Stack_new
Stack_delete

%group
構築命令

;--------------------
%index
Stack_delete
Stack 破棄

%prm
self
modvar self : モジュール変数

%inst
スタック (Stack) を破棄します。

%href
Stack_new
Stack_delete

%group
解体関数

;--------------------
%index
Stack_push
Stack に値を積む

%prm
self, value
modvar self  : スタック
any    value : 値

%inst
スタックに値を積みます。

※Stack_push_back と同じ。

%href
Stack_push
Stack_pushv
Stack_pop
Stack_popv
Stack_peek
Stack_peekv

%group
メンバ関数::操作系

;--------------------
%index
Stack_pushv
Stack 値を積む ( 変数 )

%prm
self, value
modvar self  : スタック
var    value : 変数

%inst
スタックに値を積みます。Stack_push とは違い、value には変数のみ指定できます。
変数の値を積む場合は、無駄なコピーが行われません。

%href
Stack_push
Stack_pushv
Stack_pop
Stack_popv
Stack_peek
Stack_peekv

%group
メンバ関数::操作系

;--------------------
%index
Stack_popv
Stack 値を降ろす ( 変数 )

%prm
self, vResult
modvar self : スタック
var vResult : 変数

%inst
スタックから値を下ろし、変数に格納します。

%href
Stack_push
Stack_pushv
Stack_pop
Stack_popv
Stack_peek
Stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
Stack_pop
Stack 値を降ろす

%prm
(self)
modvar self : スタック

%inst
スタックから値を降ろして返します。

%href
Stack_push
Stack_pushv
Stack_pop
Stack_popv
Stack_peek
Stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
Stack_peekv
Stack 値の取得 ( 変数 )

%prm
self, vResult, offset
modvar self : スタック
var vResult : 格納先の変数
int offset  : オフセット量

%inst
スタックから値を取得し、vResult に格納します。pop とは違い、値はスタックから取り除かれません。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

※ Stack_getv と同じ。

%href
Stack_push
Stack_pushv
Stack_pop
Stack_popv
Stack_peek
Stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
Stack_peek
Stack 値の取得

%prm
(self, offset)
modvar self : スタック
int offset  : オフセット量

%inst
スタックから値を取得し、返します。pop とは違い、取り出した値はスタックから取り除かれません。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

※ Stack_get() と同じ。

%href
Stack_push
Stack_pushv
Stack_pop
Stack_popv
Stack_peek
Stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
Stack_size
Stack 要素数 [i]

%prm
(self)
modvar self : スタック

%inst
スタックに積まれている要素の数を返します。統一関数です。

%href

%group
メンバ関数

;--------------------
%index
Stack_clear
Stack 消去 [i]

%prm
self
modvar self : スタック

%inst
スタックに積まれているすべての要素を消去し、スタックを空っぽにする統一関数です。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Stack_chain
Stack 連結 [i]

%prm
self, mv_from
modvar self   : スタック
modvar mvFrom : 〃

%inst
スタックに、mvFrom に積まれている要素をすべて積む統一関数です。Stack_pop と Stack_push を用いるため、積まれている順番は逆になります。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Stack_copy
Stack 複写 [i]

%prm
self, mv_from
modvar self   : スタック
modvar mvFrom : 〃

%inst
スタックに mvFrom のすべての要素を複写する統一関数です。それまで積まれていた要素は削除されます。また、要素の順番は mvFrom のそれと同じであることが保証されます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Stack_exchange
Stack コンテナ交換 [i]

%prm
self, mv2
modvar self : スタック
modvar mv2  : 〃

%inst
self と mv2 のスタックの内容を、そっくりそのまま入れ替える統一関数です。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
Stack_dbglog
Stack デバッグ出力

%prm
self
modvar self : スタック

%inst
スタックに積まれている要素をすべて logmes を用いて出力します。文字列型にできない要素がある場合は、その途中で失敗します。

この命令は、リリース時は無効になります。

%href

%group
メンバ関数::デバッグ
