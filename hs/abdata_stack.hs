;#############################
%dll
abdata_stack

%author
uedai

%date
2010 07/18 (Sun)	// 最終更新 表記の修正, _clone などの不足していた関数の説明を追加
2009 10/04 (Sun)	// 
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
stack_make
Stack 構築 (一時)

%prm
()

%inst
新たなスタック (stack) を構築し、返します。

%href
stack_make
stack_new
stack_delete

%group
構築命令

;--------------------
%index
stack_new
Stack 構築

%prm
self
var self : 構築先の変数

%inst
スタック (stack) を構築します。

%href
stack_make
stack_new
stack_delete

%group
構築命令

;--------------------
%index
stack_delete
Stack 破棄

%prm
self
inst self : スタック

%inst
スタック (Stack) を破棄します。

%href
stack_new
stack_delete

%group
解体関数

;--------------------
%index
stack_push
Stack に値を積む

%prm
self, value
inst self  : スタック
any  value : 積む値

%inst
スタックに値を積みます。

※stack_push_back と同じ。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::操作系

;--------------------
%index
stack_pushv
Stack 値を積む ( 変数 )

%prm
self, value
inst self  : スタック
var  value : 積む値を持つ変数

%inst
スタックに値を積みます。stack_push とは違い、value には変数のみ指定できます。
変数の値を積む場合は、無駄なコピーが行われません。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::操作系

;--------------------
%index
stack_popv
Stack 値を降ろす ( 変数 )

%prm
self, vResult
inst self    : スタック
var  vResult : 格納先の変数

%inst
スタックから値を下ろし、変数に格納します。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
stack_pop
Stack 値を降ろす

%prm
(self)
inst self : スタック

%inst
スタックから値を降ろして返します。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
stack_peekv
Stack 値の取得 ( 変数 )

%prm
self, vResult, offset
inst self   : スタック
var vResult : 格納先の変数
int offset  : オフセット量

%inst
スタックから値を取得し、vResult に格納します。pop とは違い、値はスタックから取り除かれません。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

※ stack_getv と同じ。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
stack_peek
Stack 値の取得

%prm
(self, offset)
inst self  : スタック
int offset : オフセット量

%inst
スタックから値を取得し、返します。pop とは違い、取り出した値はスタックから取り除かれません。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

※ stack_get() と同じ。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
stack_clone
Stack クローンの作成 (命令)

%prm
self, result, offset
inst self   : スタック
var  result : クローンにする変数
int  offset : オフセット量

%inst
スタック上の値のクローンを作ります。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

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
スタック上の値のクローンを作り、返します。これは値として正常でない場合があるため、代入文の右辺以外では使用しないでください。

offset で、トップ以外の要素の値を得ることが可能です。offset = 0 のとき、一番上の要素です。

%href
stack_push
stack_pushv
stack_pop
stack_popv
stack_peek
stack_peekv

%group
メンバ関数::取得系

;--------------------
%index
stack_vartype
Stack 型の取得

%prm
(self)
inst self : スタック

%inst
スタックの一番上に積まれている要素の値の型を返します。

%href
;stack_vartype

%group
メンバ関数::取得系

;--------------------
%index
stack_size
Stack 要素数 [i]

%prm
(self)
inst self : スタック

%inst
スタックに積まれている要素の数を返す統一関数です。

%href

%group
メンバ関数

;--------------------
%index
stack_clear
Stack 消去 [i]

%prm
self
inst self : スタック

%inst
スタックに積まれているすべての要素を消去し、スタックを空っぽにする統一関数です。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
stack_chain
Stack 連結 [i]

%prm
self, src
inst self : スタック
inst src  : 〃

%inst
スタックに、src に積まれている要素をすべて積む統一関数です。stack_pop と stack_push を用いるため、積まれている順番は逆になります。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
stack_copy
Stack 複写 [i]

%prm
self, src
inst self : スタック
inst src  : 〃

%inst
スタックに src のすべての要素を複写する統一関数です。それまで積まれていた要素は削除されます。また、要素の順番は src のそれと同じであることが保証されます。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
stack_swap
Stack コンテナ交換 [i]

%prm
self, obj
inst self : スタック
inst obj  : 〃

%inst
self と obj のスタックの内容を、そっくりそのまま入れ替える統一関数です。

%href

%group
メンバ関数::コンテナ操作

;--------------------
%index
stack_dbglog
Stack デバッグ出力

%prm
self
inst self : スタック

%inst
スタックに積まれている要素をすべて logmes を用いて出力します。文字列型にできない要素がある場合は、その途中で失敗します。

この命令は、リリース時は無効になります。

%href

%group
メンバ関数::デバッグ
