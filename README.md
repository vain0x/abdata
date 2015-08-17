# abdata for HSP3
## 概要
抽象データ構造を提供するモジュールです。

## 導入方法
* [最新版](https://github.com/vain0/abdata/archive/master.zip)をダウンロードし、abdata フォルダを common フォルダの下に置く。
* スクリプトの最初のほうに次のように書く。

```hsp
#include "common/abdata/all.hsp"
```

* abdata ライブラリの全ファイルは誰でも自由に使用、再配布可能。
  * [NYSL (煮るなり焼くなり好きにしろライセンス)](http://www.kmonos.net/nysl/) に従う。

## 内容
* [abdata/all.as](abdata/all.as): すべてのヘッダを一括で \#include します。
* [sample](sample): 簡単なサンプルです。

* [abdata/backward_compatible.as](abdata/backward_compatible.as) : 古い abdata をそこそこ動かせるヘッダ。

### コンテナ
* pair: ペア
* list: リスト
* stack: スタック
* tnode: 木構造 (擬似)
* unor: 文字列からの連想配列
* abelem: 任意型の値

### コンテナの操作
以下のような関数がサポートされます。ただしコンテナによっては定義されていないこともあります。詳しい仕様は実装を参照してください。

* 構築
  * new
    * コンテナを新しく作成し、与えられた変数に代入します。
    * `newmod` とは異なり、変数は自動では配列になりません。
  * make()
    * コンテナを new して返す関数です。
* 解体
  * delete
  * 変数がもつコンテナを破棄します。
  * 自動的には破棄されないので、必要に応じて delete を呼び出してください。

* 要素数
  * size(), length()
  * 要素の数を返します。
  * 2つとも同じ関数です。
* 要素の追加
  * insert
    * 指定した位置に要素を追加します。
  * push_front, push_back
    * それぞれ先頭、末尾に要素を追加します。
* 要素の除去
  * erase
    * 指定した位置の要素を除去します。
  * pop_front, pop_back
    * それぞれ先頭、末尾の要素を除去します。
* 要素の書き換え
  * set
    * 要素の値を変更します。
  * setv
    * set と同じですが、変数しか渡せません。
    * 値のコピーが行われないので、文字列などを渡す際に無駄なコストをかけずに済みます。
* 要素の取得
  * get()
    * 要素の値を取得します。
  * getv
    * 要素の値を、与えられた変数に代入します。
  * clone
    * 与えられた変数を、要素のクローン変数にします。(`dup` 命令で作成されるようなもの。)
  * vartype()
    * 要素の値の型を返します。
* 要素の数え上げ
  * count()
    * 与えられた値を持つ要素の数を数えます。

* 完全消去
  * clear
    * コンテナからすべての要素を取り除きます。
* 連結
  * chain 連結元
    * 与えられたコンテナの各要素を連結します。
* 複写
  * copy 複写元
    * clear して chain します。
* 交換
  * swap 交換先
    * 2つのコンテナの中身をまるごと入れ替えます。
* 辞書順比較
  * lexicographical_compare()
    * 辞書順に比較する。

### アルゴリズム(algorithm)
アルゴリズムとは、abdata によって提供される各種コンテナに対して共通した処理を行うモジュールやその中の関数です。

アルゴリズム関数を提供するファイルには、接頭辞 alg_ が付いています。

* 反復アルゴリズム
  * [abdata/alg_iter.as](abdata/alg_iter.as)
  * `foreach` のようなもの。コンテナ内の各要素についてループを行います。

## 実装詳細メモ
#### abdataInsts_var
* abdata のほとんどのモジュールクラス(containerImpl や unorImpl など)のインスタンスは、この1つの配列変数の中に生成される。
* abdata を使う側では、インスタンスの代わりに、この配列の添字を用いる。
* これによりインスタンスを関数に渡したり参照のコピーを行ったりできる。代償として、GCに相当する機能がなくなってしまっている。

#### container
* 実質的に list と思ってよい。
  * list はこれのラッパ。
* インスタンスの中に abelem の配列 mElems をもつ。その要素はこの container の値を表しているが、順番は同じではない。
* メンバ変数 midlist が、container の要素と、それを表す mElems の要素への対応をもつ。
  * すなわち、container(index) <---> mElems(midlist(index)) という関係がある。
  * コメントでは container の添字と区別するため、mElems の添字を real index と呼んでいる。
  * `_loc_swap` を効率よく実装するため。

#### pair
* 要素数が常に 2 であることを除いて、container とほぼ同様。

#### unor
* STL の std::unordered ではなく、Loki::AssocVector みたいなもの。
* キーの配列 keys と値の配列 values がある。
* keys(i) と values(i) が対応している。
* keys は常に整列済みであり、重複する要素をもたない。
  * 整列済みなので2分探索を利用できる。
* 仕組み上、キーには文字列以外も使えるようにできるが、`_get()` の引数に変数を渡さなければならなくなって、不便である。

#### tnode
* 木構造のノードを表すデータ構造、のつもり。
* list のラッパで、[0] にノードの値を、[1] に子ノードのデータをもつ。
  * 要素数 2 なので pair でいい。
  * parent へのリンクがないという問題がある。
* tnb は2分木を表す。
  * 子ノードのデータとして、tnode の pair をもつ。
* tnx は、子ノードの数が固定されない木を表す。
  * 子ノードのデータとして、tnode の list をもつ。

* `child` はよく `chlid` と typo してしまうので、`chd` と略している。

## リンク
* プログラ広場 <http://prograpark.ninja-web.net/>
