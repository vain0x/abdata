%dll
abdata_tree

%author
Ue-dai

%date
2009/07/07

%ver
1.1.0

%type
抽象データ型モジュール

%group
モジュールメンバ関数

;--------------------
%index
IsTnIdValid
ノードId が有効か

%prm
()

return void	: 

%inst
ツリーノードId が有効なノードを表す値であるかどうかを返します。
そうならば真値(0以外)が返り、無効な値なら偽値(0)が返ります。

;--------------------
%index
TNodeMod_new
ルートノードを作成する

%prm
p1, p2="root"
p1 = modvar	: ノードId を得る変数
p2 = str	: ノード名
return int	: 値を格納した p1 の要素番号

%inst
ツリーの一番上に当たる、ルートノードを作成します。
子ノードは、TNode_addChild 命令を使用して作成してください。
ノードの値は初期値で int 型の 0 です。

※この命令で作成される p1 は、実際には struct 型ではありませんが、
varuse が使用できない、vartype が "int" の値を返す、などの違いはありますが、
モジュール変数 modvar として扱っています。

;--------------------
%index
TNode_getv
ノードの値を取得する

%prm
p1, p2
p1 = modvar	: モジュール変数
p2 = var	: 受け取り用変数
return void	: 

%inst
ツリーノードの値を、指定した変数にコピーします。
この値が関数の戻り値として正常な場合は、代わりに
TNode_get() 関数を用いてもかまいません。
ノードの値の型は、TNode_getVarType() 関数で取得できます。

;--------------------
%index
TNode_get
ノードの値を取得する

%prm
(p1)
p1 = modvar	: モジュール変数
return any	: ノードの値

%inst
ツリーノードの値を、関数形式で取得します。
ノードの値が組み込み型(double, int, str)の場合にのみ
使用してください。

;--------------------
%index
TNode_getValueType
ノードの型を取得する

%prm
(p1)
p1 = modvar	: モジュール変数
return int	: 型タイプ値

%inst
ツリーノードが保持している値の型を返します。
返る値は、vartype() 関数が返すものと同じです。

;--------------------
%index
TNode_cntChildren
子ノードの数を取得する

%prm
(p1)
p1 = modvar	: モジュール変数
return int	: 子ノードの数

%inst
ツリーノードが所有している子ノードの数を返します。

※孫ノード以降の数は無関係です。

;--------------------
%index
TNode_isRoot
ルートノードであるか

%prm
(p1)
p1 = modvar	: モジュール変数
return bool	: ルートノードなら真、そうでないなら偽

%inst
ルートノードかどうかを調べます。

;--------------------
%index
TNode_getParent
ルートノードのIdを得る

%prm
(p1)
p1 = modvar	: モジュール変数
return int	: ルートノードId

%inst
再帰的に TNode_getParent() を用いて、そのツリーのルートノードを取得し、ノードId を得ます。

;--------------------
%index
TNode_addChild
子ノードの存在を確かめる

%prm
(p1, p2)
p1 = modvar	: 親ノードのモジュール名
p2 = str	: ノード名
return bool	: 存在したら真

%inst
指定したノード名の子ノードが存在するかどうかを調べます。
存在した場合は真( 0 以外 )が返されます。
ない場合は偽( 0 )が返ります。

この関数名は「TNode_exist's'Child」です。
exists の s が抜けないように気を付けてください。

;--------------------
%index
TNode_getChild
子ノードのId を得る

%prm
(p1, p2)
p1 = modvar	: 親ノードのモジュール変数
p2 = str	: 子ノード名
return int	: 子ノードのId

%inst
子ノードのId を返します。子ノードはルートノードと同じように使用できます。

失敗した場合は負数が返ります。

この命令は、TNChild でも代用できますが、何度も参照する場合や、
スクリプトが長くなるのが嫌な場合などに使用できます。

;--------------------
%index
TNChild
子ノードのモジュール変数

%prm
(p1, p2)
p1 = modvar	: 親ノードのモジュール変数
p2 = str	: ノード名
return modvar	: 子ノードのモジュール変数

%inst
指定したノード名の子ノードを返す関数です。
存在しない場合はエラーになる可能性が高いので、
必ず TNode_existsChild() 関数で存在を確かめておいてください。

これは、呼び出すたびに子ノードを検索するため、低速です。
何度も呼び出す場合は、一度 TNode_getChild 命令で
クローンを作成しておくことを推奨します。

注意：この関数は入れ子にできません。
　　　(例) TNChild( TNChild(m, "x"), "y" )
　　　今後対応する予定です。
注意：この関数を用いての再帰処理は行えません。

※実際には関数ではありませんが、たいした問題ではありません。

;--------------------
%index
TNParent
親ノードのモジュール変数

%prm
(p1)
p1 = modvar	: モジュール変数 ( ルートノードでないもの )
return modvar	: 親ノードのモジュール変数

%inst
指定したノードの親ノードのモジュール変数を返す関数です。

この関数は、TNChild() とは違い、あまり低速ではありません。
10回程度の参照なら、TNode_getParent をしなくても問題ありません。
( あまりに参照回数が多い場合は別ですが。 )

注意：ルートノードの親は存在しないので、その場合は int 型の 0 が返ってきます。

;--------------------
%index
TNode_clear
ノードをクリアする

%prm
p1
p1 = modvar	: モジュール変数
return void	: 

%inst
ツリーノードの値を初期化し、その子孫ノードをすべて削除します。

;--------------------
%index
TNode_delete
ノードを削除する

%prm
p1
p1 = modvar	: モジュール変数
return void	: 

%inst
ツリーノードを削除します。

また、このノードの子孫ノードも、すべて削除されます。
削除されたノードのクローンも無効になります。
無効なクローンを使用しないように気を付けてください。

;--------------------
%index
TNode_chain
ノードを連結する

%prm
p1, p2
p1 = modvar	: モジュール変数
p2 = modvar	: 連結元
return void	: 

%inst
ノードの持つ子孫ノードすべてを再帰的に複製し、追加します。

;--------------------
%index
TNode_copy
ノードを複製する

%prm
p1, p2
p1 = modvar	: モジュール変数
p2 = modvar	: 複製元
return void	: 

%inst
ノードの値と、その子ノードすべてを再帰的に複製します。

;--------------------
%index
TNode_exchange
ノードを交換する

%prm
p1, p2
p1 = modvar	: ノード1
p2 = modvar	: ノード2
return void	: 

%inst
2つのノードを交換します。

