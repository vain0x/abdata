## TODO
* 最大最小検索
  * min_element, max_element, minmax_element
* 整列
  * sort
    * stable_sort (merge_sort) だけでいいと思う。
* 重複除去
  * unique & erase
* 置換
  * replace
* コンテナのメンバ関数の補完
* コンテナの構造的比較
* unor の実装の改良
* より安全なテスト
* knowbug での拡張表示

## 更新履歴
### 2015/07/13 (Mon)
* ヘッダ [abdata/arrayLen.as](abdata/arrayLen.as) を追加した。
  * 標準配列とその長さをペアで管理する。
  * 2分探索アルゴリズムをサポートしている。
* `_count` 関数が、与えられた値をもつ要素の個数を数えるようになった。
  * 以前は `_size` や `_length` 関数に置換されていた。
  * std::map::count と std::count の挙動が違うので困る。
* `unor_exists()` を除去した。
  * `unor_count_key()` に置き換えられる。
* `_isValid()` を `_is_valid()` に改名した。
* pair のメンバ関数を snake_case にした。
  * ``pair(Impl)?_(getv?|setv?|clone|ref|vartype)(Lhs|Rhs|Both)``
* 破壊的変更をある程度修正する [abdata/backward_compatible.as](abdata/backward_compatible.as) を追加した。
  * `_swap` や `_count` のような上書きはどうしようもない。
  * 今後もサポートされる保証はない。
* `new_CONTAINER()` を `CONTAINER_make()` に改名した。
* 辞書順比較 `_lexicographical_compare()` を追加した。
  * container, list, pair, unor, arrayLen

### 2015/07/09 (Thu)
* mod_shiftArray も snake_case にした。

### 2015/07/08 (Wed)
* Git を導入。
* README を更新。
* 簡単なテストを追加。
* 命名規則として、識別子は基本的に snake_case にすることにした。
  * 実装詳細の識別子はめんどくさいのでそのまま残す。
* 公開される関数名をいくつか変更した。
  * remove -> erase
  * setSize -> resize
  * swap -> loc_swap
  * move -> loc_move
  * exchange -> swap
  * iterInit -> iter_init
  * iterNext -> iter_next

### 2011 04/04 (Mon)
* abAssert を追加し、要素範囲外の時には assert で止まるようにした。
* swap, move で、要素が2つ未満の時は assert で止まるようにした。

### 2011 01/09 (Sun)
* insert 時に、要素番号が最大要素数を超えている場合、要素の自動拡張を行うようにした。
  
### 2010 10/13 (Wed)
* インスタンスの実体をすべて abdataInst に格納するようにした。
* インクルードガード識別子の、abdata を示す ABSTRACT_DATA_STRUECTURE を ABDATA にした。

### 2010 10/01 (Fri)
* value を abelem に改名した。
* コンテナ value を作成した。
* コンテナ tnode を作成 (というか既に作っていたのを完成させた)。
* alg_iter で、異なるコンテナの Iterate があると、2種類目で型不一致エラーが起きるバグを修正した。
  * 参照返し関数で、媒介の変数の型が struct (MStr など) と int (list など) で食い違うことがあったのが問題だった。
  * dummy の命令・関数を挟んで、型を実体のに合わせてから使用するようにした。
* ver 1.3 としてバックアップ。

### 2010 07/21 (Wed)
* *_empty() の返値がいずれも逆だったので、修整した。

### 2010 07/19 (Mon)
* 引数の受け渡しや、一時値に VAR_TEMP を使用するのをやめた。
  * 前者は、ARG_TEMP() でその仮引数専用の変数を作り、それを介すようにし、
  * 後者は、local 変数を使用するようにした。
  * 引数を格納した VAR_TEMP が、呼び出し時の他の引数の処理中に書き換わることがあり、そうした場合、正常な値を引数に渡せない、という問題が実際に起きたため。
  * バグの修正を除いて、これによる動作の変更はない。
  * any パラメータがあれば万事解決なのに。

### 2010 07/18 (Sun)
* pair の _assign, _assignv を、_setBoth, _setvBoth に変更した。
* tree を削除した。
* 諸変更に合わせて、リファレンス (hsファイル) を修整した。

### 2010 07/17 (Sat)
* Container や Pair を Impl と Wrapper に分離し、すべての実体をモジュールの内部で管理し、その添字を利用するように変更した。
* new_Container などの、一時オブジェクトの生成関数を追加した。
* 命令形式の参照化を、dup ではなく clone にした。
* pair に pair_getvBoth を追加した。

### 2010 06/25 (Fri)
* pair の要素名を <first, second> から <lhs, rhs> に変更した。
* Container_sort, List_sort を追加。

### 2009 10/04 (Sun)
* vartype 系関数を追加。

### 2009 09/04 (Fri)
* unor のリファレンスを作成。
* ver 1.2 として公開＆バックアップ。
  * 今回はリファレンス充実。

### 2009 09/03 (Thu)
* Container_set, Container_setv で、既存の要素の型と設定する値の型が違う場合、value の型を dimtype で変換するように修整した。
* コンテナ unordered (unor) を作成した。速度に頓着しなかったので、非常に低速であると思われる。
* unor のキー検索速度を( たぶん )改善。

### 2009 09/02 (Wed)
* swap に swap_front, swap_back ( 先頭2つ、末尾2つの交換 ) を追加した。
* 要素が2つ以上ないときは、Container_swap や Container_move がなにもしない
  ように修整した。
* 要素の倍化を追加。
  * + Container_double
  * + Container_double_front
  * + Container_double_back
* deque のリファレンスを作成。

### 2009 08/31 (Mon)
* dictionary を追加。it はキーを表す、という仕様で、参照化ができない状況を打破 (?)。
  素直にハッシュ云々やって作った方が早いかもしれないが。
* List を Container に変更し、List を Container のラッパにした。
  * List が pop_back などを持つのはおかしいため。
  * また、deque を Container のラッパにし、順序操作系 swap, move などを削除。

### 2009 08/30 (Sun)
* queue のリファレンスを作成。
* 辞書 Dictionary を追加中。Keys, Items に関連する処理ができないため、反復子操作ができないという不完全な状態。
  * つまり copy, chain もできない。統一関数が実装できないのではねぇ。
* List に _front, _back 系の関数を多数追加。
  * + get_front
  * + get_back
  * + getv_front
  * + getv_back
  * + pop_front
  * + pop_back
  * + popv_front
  * + popv_back
  * + push_front
  * + push_back
  * + pushv_front
  * + pushv_back
  * + remove_front
  * + remove_back
* List で、List_set が新規要素の追加を行わないように修整。
  * insert 以外の関数で、添字の循環に対応。
  * insert は新規要素を末尾に追加するために、要素数と等しい値を許可する。
* 双方向キュー Deque を作成。
  * List のラッパとして構築。というか、list とほぼ同じ。
* 「要素数」を返す関数に、size だけでなく count、length を統一関数として追加。
* List で、remove しても内部の配列の要素数は減っていないため、反転操作で無効
  * id が有効域に現れてしまうというバグを修正。
  * ※ insert, remove でも要素数を用いるが、問題ないので修整は保留。
* Stack, Queue を Deque のラッパにした。
  * つまり、制限された List として実装される。
  * でも一部のランダムアクセスが可能……。

### 2009 08/29 (Sat)
* List に 巡回 (逆回転) (rotate_back)、反転 (revese) を追加。
* stack, list, pair のリファレンスを作成。

### 2009 07/29 (Wed)
* HSP3.2RC1リリースにつき、 ``#defcfunc ... modvar 構造名@`` のハックを `#modcfunc` にすべて修整。

### 2009 07/28 (Tue)
* Mo内フォルダのファイルを #include で結合できなかったバグを修正。
  * といっても、abdata の中に移動させただけだが。
  * なんでだろう……。

### 2009 07/11 (Sat)
* alg_iter.as を追加。IterateBegin ～ IterateEnd での画一的な反復が可能に。
* ↑に関して、反復子関係の統一関数を追加。
  * iterInit: 反復子の初期化を行う。
  * iterNext(): 反復子の更新を行う。継続なら真を返す。
* IterateBegin~End が入れ子にできなかったバグを修正。
* Pair_new が定義前に使われていたバグを修正。
* setv, getv 系関数の引数の順番を「変数, その他……」に統一。
  * List, Queue が大きく影響を受けた。
  * DLList, Pair は変化無し。
* mod_shiftArrayで、ArrayInsert すると要素が1つ消滅するという、初歩的なバグを修正。
* List で、insert すると midList の番号が midList の要素番号を指すという謎の状態になるバグを、要素配列の要素番号を指すように修正。
* ver.1.1として公開＆バックアップ。
  * でも資料不足相変わらず。

### 2009 07/09 (Thu)
* all.as を追加。
* Stack_pushvar → Stack_pushv の変更に修正し忘れがあったのを直した。
* List_valid → List_isValid と変更したが、Queue_valid → Queue_isValid は修整されていなかった。他のListラッパーも同様。
* 木構造の反復子でトラバースできるようにしようとしたが、断念。

### 2009 07/08 (Wed)
* 「＠反復子関数」を追加。
* この更新履歴を頑張って構築。
* ver.1.0 として公開＆バックアップ。
  * でもリファレンス不足。

### 2009 07/07 (Tue)
* これ(readme)を作成し、abdata をフォルダ化 (前々からの悲願)。
* 統一関数を実装。同時に、公開メンバ関数の統一的な命名規則を導入。
  * new, delete, size, clear, copy, chain, exchange
* 木構造を、インスタンスすべてを1つの静的配列で管理するように再実装。

### 2009 05/10 (Sun)
* キューをリストのラッパーとして再実装。

### 2009 05/05 (Tue) ～ 05/10 の間
* リストを作成。

### 2009 04/12 (Sun)
* 木構造を階層表現に対応させた。

### 2009 04/08 (Wed)
* ペアを作成。

### 2008 10/13 (Mon)
* 双方向連結リストを作成。
* 木構造を作成。

### 2008 09/06 (Sat)
* スタックとキューのファイルを分割。

### 不明 (2008 09/04 ～ 09/06 か？)
* スタック＋キューを作成 (StrCalcの初回版に使用した、ハズ)。
