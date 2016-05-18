# abdata for HSP3
## 概要
抽象データ型を提供するモジュールです。

## 導入方法
* [最新版](https://github.com/vain0/abdata/archive/master.zip)をダウンロードし、abdata フォルダを common フォルダの下に置く。
* スクリプトの最初のほうに次のように書く。

```hsp
#include "abdata/all.hsp"
```

* [hs](hs) フォルダの中身を「hsphelp」フォルダに移動すると、F1キーから各命令のヘルプが見れるようになる。

### Paket を用いた導入方法
paket.dependencies に以下のように記述して、paket install コマンドを実行する。

```
github vain0/abdata abdata/all.hsp
```

ダウンロードされたファイルのなかにある all.hsp を `#include` して使う。

* 参考: [Paket と Gist で始める簡単パッケージ管理](http://qiita.com/ue_dai/items/41f13fed6f88be7f4e7e)

## 内容
* [abdata/all.hsp](abdata/all.hsp): すべてのヘッダを一括で \#include します。
* [hs](hs): F1ヘルプ
* [test](test): テストコード

* 後方互換用
  * [abdata/backward_compatible.as](abdata/backward_compatible.as): 古い abdata をそこそこ動かせる。
  * 各種 `.as` ファイル。

### コンテナ
* arrlen: 標準の配列
* dict: 文字列をキーとする連想配列 (型固定)

* list: 配列 (型なし)
* unor: 文字列をキーとする連想配列 (型なし)

### コンテナの操作
以下のような関数がサポートされます。ただしコンテナによっては定義されていないこともあります。詳しい仕様は実装を参照してください。

関数の実際の名前は ``コンテナ名_関数名`` です。(例: `list_make()`, `unor_delete`, ...)

* 構築
  * make()
    * コンテナを新しく作成して返す関数です。
* 解体
  * delete
  * コンテナを破棄します。
  * 自動的には破棄されないので、不要になったコンテナはなるべく delete してください。
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
  * dup
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
* 辞書順比較
  * compare()
    * 辞書順に比較します。

### アルゴリズム(algorithm)
アルゴリズムとは、abdata によって提供される各種コンテナに対して共通した処理を行うモジュールやその中の関数です。

アルゴリズム関数を提供するファイルには、接頭辞 alg_ が付いています。

* 反復アルゴリズム
  * [abdata/alg_iter.hsp](abdata/alg_iter.hsp)
  * `foreach` のようなもの。コンテナ内の各要素についてループを行います。

## 実装詳細メモ
#### abdataInsts_var
* abdata のほとんどのモジュールクラス(listImpl や unorImpl など)のインスタンスは、この1つの配列変数の中に生成される。
* abdata を使う側では、インスタンスの代わりに、この配列の添字を用いる。
* これによりインスタンスを関数に渡したり参照のコピーを行ったりできる。代償として、GCに相当する機能がなくなってしまっている。

#### list
* 実装 [abdata/list.hsp](abdata/list.hsp) のコメントを参照。

#### pair
* **非推奨**
* 長さが常に 2 の list。
* 2つの abbox がそれぞれ lhs, rhs の値を持つ。

#### unor
* 実装 [abdata/unor.hsp](abdata/unor.hsp) のコメントを参照。

#### tnode
* **非推奨**
* 木構造のノードを表すデータ構造、のつもり。
* list のラッパで、[0] にノードの値を、[1] に子ノードのデータをもつ。
  * 要素数 2 なので pair でいい。
  * parent へのリンクがないという問題がある。
* tnb は2分木を表す。
  * 子ノードのデータとして、tnode の pair をもつ。
* tnx は、子ノードの数が固定されない木を表す。
  * 子ノードのデータとして、tnode の list をもつ。

* `child` はよく `chlid` と typo してしまうので、`chd` と略している。

#### arrlen
* 標準の1次元配列変数
  * モジュールクラスではない。
* 標準のものは要素数を 0 にしたり減らしたりできないので、長さを `length` の代わりに変数で持つ。

## ライセンス/License
本リポジトリに含まれるすべてのファイルは public domain とする。

## リンク
* プログラ広場 <http://prograpark.ninja-web.net/>
