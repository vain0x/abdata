;--------------------
%dll
abdata
%group
データ構造
%type
型つき辞書

;--------------------
%index
dict_new
辞書インスタンスを構築
%prm
self, vtype, size
array self:  辞書インスタンスが入る配列変数
int   vtype: 辞書の値の型の型タイプ値
int   size:  要求する初期キャパシティ
%inst
self に、新しい辞書のインスタンスを生成する。内部的には、self に newmod 命令を使う。

vtype, size については dict_init 命令を参照。

;--------------------
%index
dict_delete
辞書インスタンスを解体
%prm
self
%inst
辞書インスタンス self を解体する。内部的には、self を delmod する。

;--------------------
%index
dict_init
辞書を初期化
%prm
self, vtype, size
int   vtype [vartype_int]: 辞書の値の型の型タイプ値
int   size  [0]: 要求する初期キャパシティ
%inst
辞書の中身を全消去する。

初期化後の辞書は、値として vtype 型の値を持つ。

size が指定された場合、少なくとも size 個の要素を追加できる程度の大きさをあらかじめ確保する。(つまり、size 個まではリハッシュされない。 dict_rebuild を参照。)　dict_size や dict_capacity の値が size になるわけではない。

辞書の内部実装については dict_auto_rebuild を参照。

;--------------------
%index
dict_vartype
辞書の値の型
%prm
(self)
retunr: self が持つ値の型

;--------------------
%index
dict_capacity
辞書のルート配列の長さ
%prm
(self)
return: self のルート配列の長さ
%href
dict_auto_rebuild

;--------------------
%index
dict_size
辞書の要素数
%prm
(self)
return: 辞書が格納している要素の個数
%inst
辞書が実際に持っている要素の個数。
%href
dict_capacity

;--------------------
%index
dict_load_factor
辞書の積載率
%prm
(self, inc)
int inc [0]: 追加予定の要素の個数
return: inc 個の要素を追加した後の積載率
%inst
積載率 = dict_size / dict_capacity。
%href
dict_auto_rebuild

;--------------------
%index
dict_needs_rebuild
辞書の自動再構成が必要か？
%prm
(self, inc)
int inc [0]: 追加予定の要素の個数
return: int 個の要素を追加するために、自動再構成が必要なら真
%inst
dict_auto_rebuild の実行条件。

;--------------------
%index
dict_auto_rebuild
辞書の自動再構成
%prm
self, inc
int inc [0]: 追加予定の要素の個数
%inst
ある条件(dict_needs_rebuild)を満たしていたら、辞書の再構成(dict_rebuild)を行う。条件とは、「inc 個の要素を追加した後の辞書の積載率(dict_load_factor)が十分に高くなる」ことである。条件を満たしていなければ、何もしない。

この命令は、dict_chain などの「要素数を増やす可能性がある」命令の開始時に、自動的に実行される。スクリプトからわざわざ呼び出す必要はない。

> なぜリハッシュが必要なのか？

この辞書はオープンアドレス法のハッシュテーブルとして実装されている。
1. 辞書は、キー(文字列)にハッシュ値と呼ばれる数値を対応させ、ハッシュ値を添字として配列変数に値を格納していく。この配列変数をルート配列と呼ぶ。
2. イメージとしては、文字列 key のハッシュ値を hash(key) と表すことにすると、key に対応する値を配列要素 xs(hash(key)) に入れる。
3. ハッシュ値は、ルート配列の添字の範囲 (0, 1, ..., length - 1) に分布している必要がある。そのため、ハッシュ値はルート配列の長さに依存している。ゆえに、配列の長さが変わると、キーに対応するハッシュ値が変わる。
4. 辞書を拡大するときは、まず新しく大きな辞書を作る。その後、古い辞書の各要素を、新しい辞書に改めて挿入する。この再構成処理をリハッシュ(dict_rebuild)と呼ぶ。その後、新しい辞書の中身を古い辞書に移動すれば、古い辞書が大きくなったように見せかけられる。
5. ハッシュ値の衝突(違うキーが同じハッシュ値に対応すること)が起きたときは、ルート配列の空いている要素を使う。「空いている要素を探す」処理は時間がかかる。ゆえに、ルート配列が満杯に近づいていくにつれて、辞書の実行効率は悪くなっていく。したがって高速化のため、積載率(dict_load_factor)が十分大きくなった時点で、自動的にリハッシュ(dict_auto_rebuild)を行うようになっている。
6. ルート配列はほぼ常に20%程度の空きを含んでいるが、これは無駄ではない。

;--------------------
%index
dict_rebuild
辞書の再構成(リハッシュ)
%prm
self
%inst
dict_auto_rebuild を参照。

;--------------------
%index
dict_chain
辞書の連結(合併)
%prm
self, src, conflict_policy
var src: 連結する辞書
int conflict_policy [dict_conflict_keep]: キー衝突時のポリシー
%inst
辞書 src が持つ各要素を、self に挿入する。

src と self が同じキーがあるとき、キーが衝突するという。衝突時の挙動は conflict_policy の値にしたがう。

dict_conflict_update: src の要素で上書きする。(self が持っていたそのキーの値は消える。)
dict_conflict_keep:   self が持っている要素を残す。
dict_conflict_abort:  プログラムを異常終了(end 1)する。キー衝突が起きないと分かっているときに使う。

;--------------------
%index
dict_has_key
辞書がキーを含むか？
%prm
(self, key)
var key: キー
return: 辞書がキー key を含むなら真

;--------------------
%index
dict_insert
辞書に要素を挿入する
%prm
self, key, val, conflict_policy
var key: 挿入するキー
var val: 値
int conflict_policy [dict_conflict_keep]: キー衝突時のポリシー
%inst
辞書に、キーが key、値が val の要素を挿入する。

self が既に key を持っていたときは、conflict_policy の値にしたがう。(dict_chain を参照。)

;--------------------
%index
dict_erase
辞書から要素を除去する
%prm
self, key
var key: 除去する要素のキー
return: 除去されたなら真
%inst
辞書が持つ、キー key とその値を除去する。そのような要素が始めからなければ、何もしない。

これにより辞書が縮む(dict_capacity が小さくなる)ことはない。

;--------------------
%index
dict_try_get
辞書の要素値の取得
%prm
(self, result, key)
var result: 値を代入する変数
var key: 値を取得したい要素のキー
return: 成功したら真
%inst
辞書がキー key を持つ場合は、それに対応する値を result に代入して、true を返す。持たない場合は、false を返す。
;--------------------
%index
dict_get
辞書の要素の値
%prm
(self, key)
var key: 値を取得したい要素のキー
return: key に対応する要素の値
%inst
辞書のキー key に対応する要素の値を返す。そのような要素がなければ、エラーで終了する。
%href
dict_ref

;--------------------
%index
dict_try_dup
辞書の要素への参照
%prm
(self, ref, key)
array ref: クローン変数にする配列変数
var key: キー
return: 成功したら真
%inst
辞書がキー key を持つ場合は、ref をそれに対応する要素へのクローン変数にして、true を返す。持たない場合は、false を返す。

;--------------------
%index
dict_ref
辞書の要素の値の参照
%prm
(self, key)
var key: キー
return: key に対応する要素へのクローン
%inst
key に対応する要素へのクローンを返す。

;--------------------
%index
dict_iter_kv
辞書の要素ごとの反復
%prm
self, key, val
var key: キーへのクローンになる変数
var val: 値へのクローンになる変数
%inst
辞書が含む各要素について、dict_iter_kv_end までを繰り返し実行する。

各ループにおいて、key を要素のキーのクローンにし、val を値のクローンにする。ただし、key, val を書き換えてはいけない。

要素の順番は特に決まっていない。

ループの途中で dict_rebuild が生じると、ループが正しく行われない。そのため、dict_insert, dict_chain などの、新しい要素を追加する可能性がある命令を実行してはいけない (実際に要素を追加しない場合もダメ)。一方、要素を減らす dict_erase は問題ない。

while 文と同様に、内部で _break, _continue 命令が使用できる。また、内部から return や goto を使用しても問題ない。

;--------------------
%index
dict_iter_kv_end
dict_iter_kv の終端
%inst
dict_iter_kv から始まるループの終わりを示す。

;--------------------
%index
dict_is_subset_of
辞書が部分集合か？
%prm
(self, rhs)
self, rhs: 辞書
%inst
self のすべてのキーが rhs のキーでもあり、その値が型を含めて等しいとき、真を返す。

;--------------------
%index
dict_equals
辞書が等しいか？
%prm
(self, rhs)
self, rhs: 辞書
%inst
self と rhs に含まれるキーがすべて等しく、さらに同じキーに対する値が型を含めて等しいとき、真を返す。

;--------------------
dict_intersect_keys
辞書の共通キーの配列
%prm
self, rhs, keys
self, rhs: 辞書
array keys: キーの配列になる配列変数
return: keys の長さ
%inst
keys を、self, rhs の両方に含まれるキーからなる配列にする。

;--------------------
%index
dict_copy_to_alist
辞書の各要素を連想リストに複写
%prm
self, keys, vals
array keys: キーが書き込まれる配列
array vals: 値が書き込まれる配列
return: dict_size(self)
%inst
辞書に含まれる各キーを配列 keys にコピーし、キー keys(i) に対応する値を vals(i) にコピーする。

keys は昇順とはかぎらない。
%href
dict_chain_alist

;--------------------
%index
dict_chain_alist
辞書に連想リストを連結
%prm
self, keys, vals, len, conflict_policy
array keys: キーの配列
array vals: 値の配列
int len: keys, vals の要素数
int conflict_policy
%inst
各 i = 0, 1, ..., len - 1 について、self に要素 keys(i), vals(i) を挿入する。

conflict_policy は、self がすでに挿入されるキーを含んでいるときの処理を表す。dict_chain を参照。

keys は昇順でなくてもいい。
%href
dict_copy_to_alist
