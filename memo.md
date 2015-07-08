# abdata 開発に関するメモ

## 実装
グローバル変数 abdataInsts (マクロ) が、すべてのモジュール変数の配列となる。
実際はそれへの 配列要素番号(idx)で管理する (弱参照)。

### 実装モジュール(Impl)
* container_impl
* value_impl
* pair_impl
* unor_impl

### ラッパモジュール(Wrapper)
 * container
   * list
     * tnode
   * deque
     * stack
     * queue
 * value
 * pair
 * unor

### 拡張的クラス (extra class)
* iter
