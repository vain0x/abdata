// Tree - 木構造

#ifndef __ABSTRACT_DATA_STRUCTURE_TREE_AS__
#define __ABSTRACT_DATA_STRUCTURE_TREE_AS__

#include "Mo/pvalptr.as"
#include "Mo/mod_shiftArray.as"

/**+
 * abdata_tree
 * Abstract Data - Tree
 * @author Ue-dai
 * @date   2009/07/07
 * @ver    1.1.0
 * @type   抽象データ型モジュール
 * @group  モジュールメンバ関数
 */

/*-----------------------------------------------*
 * [History]
 * 
 * 2009/07/07 (Tue)
 * 　・copy, clear, chain を実装。
 * 　・インスタンスをすべて静的に管理するように変更
 * 　　モジュール変数は Id を保持するだけになった。
 *   ・exchange を実装。
 * 
 * 2009/04/12 (Sun)
 * 　・階層表現機能を追加。
 * 
 * 2008/10/13
 * 　・初期タイプ完成。
 * 
 *----------------------------------------------*/

//##############################################################################
//                ノード・モジュール
//##############################################################################
#module abdata_tree mValue, mName, mChildren, mIdParent, mCntChildren,  mIter_v, mIter_c

#define mv modvar abdata_tree@
#define VAR_TEMP stt_temp@abdata_tree

#define global TNID_PARENT_OF_ROOT (0x7FFFFFFF)
#define global TNID_DISABLE        (0xFFFFFFFF)

#define mIter mIter_v(mIter_c)

/**
 * ノードId がルートの親か
 * ツリーノードId がルートノードの親ノードを表す値であるかどうかを返します。
 * そうならば真値(0が返り)、通常のノードを表すなら偽値(0)が返ります。
 * 
 * @return = void
 */
#defcfunc IsTnIdParentOfRoot int tnId
	return ( tnId == TNID_PARENT_OF_ROOT )
	
/**
 * ノードId が有効か
 * ツリーノードId が有効なノードを表す値であるかどうかを返します。
 * そうならば真値(0以外)が返り、無効な値なら偽値(0)が返ります。
 * 
 * @return = void
 */
#defcfunc IsTnIdValid int tnId
	if ( tnId <= 0 || length(stt_allInsts) <= tnId ) {
		return false
	}
	return varuse(stt_allInsts(tnId))
	
/*;*
 * abdata_tree のインスタンスを得る
 * ノードId から、ツリーノードのインスタンスを取得します。
 * 
 * @prm p1 = var    : ツリーノードのクローンにする変数
 * @prm p2 = int    : ツリーノードId
 * @return = void
 */
#deffunc TNode_getInstance var vResult, int tnId, int nIdx
	stt_TNInstance_var(nIdx) = stt_allInsts(tnId)
	return
	
/*;*
 * abdata_tree のインスタンスを返す
 * ノードId から、ツリーノードのインスタンスを取得し、返します。
 * 
 * @prm p1 = int    : ツリーノード Id
 * @return = modvar : インスタンス
 */
#define global ctype TNInstance(%1,%2=0) stt_allInsts@abdata_tree(%1);stt_TNInstance_var@abdata_tree(TNInstance_core@abdata_tree(%1,%2))
#defcfunc local TNInstance_core int tnId, int nIdx
	TNode_getInstance stt_TNInstance_var, tnId, nIdx
	return nIdx
	
// ノード名を返す
#defcfunc TNodeMod_getName mv
	return mName
	
// 親ノードのId を返す
#defcfunc TNodeMod_getParent mv
	return midParent
	
// ルートノードのId を返す
#defcfunc TNodeMod_getRoot mv,  local node, local idParent
	node = thismod
	
	repeat
		idParent = TNodeMod_getParent(node)
		if ( IsTnIdParentOfRoot( idParent ) == false ) {
			break
		} else {
			TNode_getInstance node, idParent
		}
	loop
	return 
	
// 子ノードIdを追加する
#modfunc TNodeMod_addChildId int tnId
	mChildren( mCntChildren ) = tnId
	mCntChildren ++
	return mCntChildren - 1
	
// 子ノードを削除する
#modfunc TNodeMod_removeChild int nIdx
	delmod TNInstance( mChildren(nIdx) )		// 破棄
	
	ArrayRemove mChildren, nIdx
	mCntChildren --
	return
	
// 子ノードのインデックスを得る
#defcfunc TNodeMod_getChildIdx mv, str _name,  local nIdx
	nIdx = -1
	
	foreach mChildren
		if ( IsTnIdValid(mChildren(cnt)) == false ) { continue }
		if ( _name == TNodeMod_getName( TNInstance(mChildren(cnt)) ) ) {
			nIdx = cnt
			break
		}
	loop
	
	return nIdx
	
// 子ノードは存在するかどうか
#defcfunc TNodeMod_existsChild mv, str _name
	return TNodeMod_getChildIdx(thismod, _name) >= 0
	
// 子ノードのツリーIdを得る
#defcfunc TNodeMod_getChild mv, str _name,  local nIdx
	nIdx = TNodeMod_getChildIdx(thismod, _name)
	if ( nIdx >= 0 ) {
		return mChildren(nIdx)
	}
	return TNID_DISABLE
	
/**
 * ノードの値を設定する
 * ツリーノードの値を設定します。
 * 値には、どんな型でも格納できますが、
 * 代入演算子 = で正常にコピーできる型でなくてはなりません。
 * ( p2 の値は、一旦、変数にコピーされます )
 * 
 * p2 に変数を指定する場合は、TNode_setv とすることができます。
 * 変数を渡す場合は、こちらを使用した方が、無駄がなく効率的です。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @prm p2 = any	: 値
 * @return = void
 */
#define global TNode_set(%1,%2)  TNodeMod_set  TNInstance(%1), %2
#define global TNode_setv(%1,%2) TNodeMod_setv TNInstance(%1), %2

#define global TNodeMod_set(%1,%2) VAR_TEMP@abdata_tree = (%2) : TNodeMod_setv %1, VAR_TEMP@abdata_tree
#modfunc TNodeMod_setv var p2
	mValue = p2
	return
	
/**
 * ルートノードを作成する
 * ツリーの一番上に当たる、ルートノードを作成します。
 * 子ノードは、TNode_addChild 命令を使用して作成してください。
 * ノードの値は初期値で int 型の 0 です。
 * 
 * ※この命令で作成される p1 は、実際には struct 型ではありませんが、
 *   varuse が使用できない、vartype が "int" の値を返す、などの違いはありますが、
 *   モジュール変数 modvar として扱っています。
 * 
 * @prm p1 = modvar       : ノードId を得る変数
 * @prm p2 = str ("root") : ノード名
 * @return = int          : 値を格納した p1 の要素番号
 */
#define global TRoot_new(%1,%2="root") TNode_new %1, %2, TNID_PARENT_OF_ROOT
#define global TRootMod_new(%1="root") TNodeMod_new  %1, TNID_PARENT_OF_ROOT
#define global TNodeMod_new(%1,%2) newmod stt_allInsts@abdata_tree, abdata_tree@, %1, %2

#deffunc TNode_new array aryTnId, str _name, int parentId,  local id_new, local nIdx
	
	TNodeMod_new _name, parentId
	id_new = stat
	nIdx   = -1
	
	// 使われていない要素を探す
	foreach aryTnId
		if ( IsTnIdValid( aryTnId(cnt) ) == false ) {
			nIdx = cnt
			break
		}
	loop
	
	if ( nIdx < 0 ) {
		nIdx = length(aryTnId)
	}
	
	aryTnId( nIdx ) = id_new
	return nIdx
	
#define global CreateTreeRoot TRoot_new
#define global CreateTreeNode TNode_new

/**
 * ノードの値を取得する
 * ツリーノードの値を、指定した変数にコピーします。
 * この値が関数の戻り値として正常な場合は、代わりに
 * TNode_get() 関数を用いてもかまいません。
 * ノードの値の型は、TNode_getVarType() 関数で取得できます。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @prm p2 = var	: 受け取り用変数
 * @return = void
 */
#define global TNode_getv(%1,%2) TNodeMod_getv TNInstance(%1), %2
#modfunc TNodeMod_getv var p2
	p2 = mValue
	return
	
/**
 * ノードの値を取得する
 * ツリーノードの値を、関数形式で取得します。
 * ノードの値が組み込み型(double, int, str)の場合にのみ
 * 使用してください。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return = any	: ノードの値
 */
#define global ctype TNode_get(%1) TNodeMod_get(TNInstance(%1))
#defcfunc TNodeMod_get mv
	return mValue
	
/**
 * ノードの型を取得する
 * ツリーノードが保持している値の型を返します。
 * 返る値は、vartype() 関数が返すものと同じです。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return = int	: 型タイプ値
 */
#define global ctype TNode_getValueType(%1) TNodeMod_getValueType( TNInstance(%1) )
#defcfunc TNodeMod_getValueType mv
	return vartype(mValue)
	
/**
 * 子ノードの数を取得する
 * ツリーノードが所有している子ノードの数を返します。
 * 
 * ※孫ノード以降の数は無関係です。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return = int	: 子ノードの数
 * 
 * @! この数は length(mChildren) とは違うので注意
 * @  TNode_size でもＯＫです。
 */
#define global ctype TNode_cntChildren(%1) TNodeMod_cntChildren( TNInstance(%1) )
#defcfunc TNodeMod_cntChildren mv
	return mCntChildren
	
#define global TNode_size TNode_cntChildren
	
/**
 * ルートノードであるか
 * ルートノードかどうかを調べます。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return = bool	: ルートノードなら真、そうでないなら偽
 */
#define global ctype TNode_isRoot(%1) TNodeMod_isRoot( TNInstance(%1) )
#defcfunc TNodeMod_isRoot mv
	return mIdParent == TNID_PARENT_OF_ROOT
	
/**
 * 親ノードのIdを得る
 * ツリーノードの親のIdを返します。
 * ルートノードを指定した場合は、無効なID値が返ります。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @prm p2 = var	: クローンにする変数
 * @return = void
 */
#define global ctype TNode_getParent(%1) TNodeMod_getParent( TNInstance(%1) )

/**
 * ルートノードのIdを得る
 * 再帰的に TNode_getParent() を用いて、そのツリーのルートノードを取得し、ノードId を得ます。
 * 
 * @prm p1 = modvar : モジュール変数
 * @return = int    : ルートノードId
 */
#defcfunc TNode_getRoot int _thisId,  local thisId
	thisId = _thisId
	
	while ( TNode_isRoot( thisId ) == false )
		thisId = TNode_getParent( thisId )
	wend
	return thisId
	
/**
 * ノード名を取得する
 * ツリーノードのノード名を返します。
 * ノード名は、子ノードを選択する場合にのみ使用します。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return = str	: ノード名
 */
#define global ctype TNode_getName(%1) TNodeMod_getName( TNInstance(%1) )

/**
 * 子ノードを追加する
 * p1 の子ノードを新規作成します。
 * 子ノードのモジュール変数を取得するには、
 * TNode_getChild 命令を使用してください。
 * 
 * @prm p1 = modvar	: 親ノードのモジュール変数
 * @prm p2 = str	: ノード名
 * @return = int    : 作成した子ノードのノードId
 */
#define global TNode_addChild(%1,%2) TNodeMod_addChild TNInstance(%1), %2, %1

#modfunc TNodeMod_addChild str _name, int thisId,  local id_new
	TNode_new mChildren, _name, thisId
	id_new =  mChildren( stat )
	mCntChildren ++
	return id_new
	
/**
 * 子ノードの存在を確かめる
 * 指定したノード名の子ノードが存在するかどうかを調べます。
 * 存在した場合は真( 0 以外 )が返されます。
 * ない場合は偽( 0 )が返ります。
 * 
 * この関数名は「TNode_exist's'Child」です。
 * exists の s が抜けないように気を付けてください。
 * 
 * @prm p1 = modvar	: 親ノードのモジュール名
 * @prm p2 = str	: ノード名
 * @return bool		: 存在したら真
 */
#defcfunc TNode_existsChild int thisId, str _name
	return TNodeMod_existsChild(TNInstance(thisId), _name)
	
/**
 * 子ノードのId を得る
 * 子ノードのId を返します。子ノードはルートノードと同じように使用できます。
 * 
 * 失敗した場合は負数が返ります。
 * 
 * この命令は、TNChild でも代用できますが、何度も参照する場合や、
 * スクリプトが長くなるのが嫌な場合などに使用できます。
 * 
 * @prm p1 = modvar	: 親ノードのモジュール変数
 * @prm p2 = str	: 子ノード名
 * @return = int	: 子ノードのId
 */
#define global ctype TNode_getChild(%1,%2) TNodeMod_getChild( TNInstance(%1), %2 )

// 階層表現対応
#defcfunc TNode_getChildHier int _thisId, str _name,  local thisId, local sName, local stmp
	thisId = _thisId
	sName  = _name
	if ( peek(sName) == '/' ) {			// 絶対パス
		getstr sName, sName, 1
		thisId = TNode_getRoot(thisId)	// ルートノードから検索開始
	}
	repeat
		if ( instr(sName, , "/") >= 0 ) {
			getstr  stmp, sName, 0, '/'
			getstr sName, sName, strsize
			thisId = TNode_getChildHier( thisId, stmp )
		} else {
			break
		}
	loop
	return TNode_getChild( thisId, sName )
	
/**
 * 子ノードのモジュール変数
 * 指定したノード名の子ノードを返す関数です。
 * 存在しない場合はエラーになる可能性が高いので、
 * 必ず TNode_existsChild() 関数で存在を確かめておいてください。
 * 
 * これは、呼び出すたびに子ノードを検索するため、低速です。
 * 何度も呼び出す場合は、一度 TNode_getChild 命令で
 * クローンを作成しておくことを推奨します。
 * 
 * 注意：この関数は入れ子にできません。
 * 　　　(例) TNChild( TNChild(m, "x"), "y" )
 * 　　　今後対応する予定です。
 * 注意：この関数を用いての再帰処理は行えません。
 * 
 * ※実際には関数ではありませんが、たいした問題ではありません。
 * 
 * @prm p1 = modvar	: 親ノードのモジュール変数
 * @prm p2 = str	: ノード名
 * @return modvar	: 子ノードのモジュール変数
 */
#define global ctype TNChild(%1,%2) stt_tnchild_var@abdata_tree(TNChild_core@abdata_tree(%1,%2))
#defcfunc TNChild_core@abdata_tree int thisId, str _name
	TNode_getInstance stt_tnchild_var, TNode_getChild( thisId, _name )		// クローンにする
	return 0
	
// 階層表現対応 ( 低速(1/2) )
#define global ctype TNChildHier(%1,%2) stt_tnchild_var@abdata_tree(TNChildHier_core@abdata_tree(%1,%2))
#defcfunc TNChildHier_core@abdata_tree int thisId, str _name
	TNode_getInstance stt_tnchild_var, TNode_getChildHier( thisId, _name )
	return 0
	
/**
 * 親ノードのモジュール変数
 * 指定したノードの親ノードのモジュール変数を返す関数です。
 * 
 * この関数は、TNChild() とは違い、あまり低速ではありません。
 * 10回程度の参照なら、TNode_getParent をしなくても問題ありません。
 * ( あまりに参照回数が多い場合は別ですが。 )
 * 
 * 注意：ルートノードの親は存在しないので、その場合は int 型の 0 が返ってきます。
 * 
 * @prm p1 = modvar	: モジュール変数 ( ルートノードでないもの )
 * @return = modvar	: 親ノードのモジュール変数
 */
#define global ctype TNParent(%1) stt_tnparent_var@abdata_tree( TNParent_core@abdata_tree(%1) )
#defcfunc TNParent_core@abdata_tree int thisId
	TNode_getInstance stt_tnparent_var, TNode_getParent( thisId )
	return 0
	
/**
 * ノードをクリアする
 * ツリーノードの値を初期化し、その子孫ノードをすべて削除します。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return void
 */
#define global TNode_clear(%1) TNodeMod_clear TNInstance(%1)
#modfunc TNodeMod_clear
	// 子孫ノードを削除
	if ( mCntChildren ) {
		foreach mChildren
			if ( IsTnIdValid( mChildren(cnt) ) ) {
				TNode_clear mChildren(cnt)
				delmod thismod
			}
		loop
	}
	
	mValue       = 0
	mChildren    = TNID_DISABLE
	mCntChildren = 0
	mIter_v      = 0
	mIter_c      = -1
	
	return
	
/**
 * ノードを削除する
 * ツリーノードを削除します。
 * 
 * また、このノードの子孫ノードも、すべて削除されます。
 * 削除されたノードのクローンも無効になります。
 * 無効なクローンを使用しないように気を付けてください。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @return void
 */
#define global TNode_delete(%1) TNodeMod_delete TNInstance(%1)
#modfunc TNodeMod_delete
	TNode_clear thismod
	delmod      thismod
	return
	
;#modterm
;	return
	
//##########################################################
//        繰返子
//##########################################################
#define global TNode_iterNew(%1) TNodeMod_iterNew TNInstance(%1)
#modfunc TNodeMod_iterNew
	if ( mIter_c < 0 ) {
		mIter_c = 0
	} else {
		mIter_c ++
	}
	mIter = -1
	return
	
#define global TNode_iterDelete(%1) TNodeMod_iterDelete TNInstance(%1)
#modfunc TNodeMod_iterDelete
	mIter_c --
	return
	
#define global ctype TNode_iterCheck(%1,%2) TNodeMod_iterCheck(TNInstance(%1), %2)
#defcfunc TNodeMod_iterCheck mv, var vIterId
	mIter ++
	
	if ( mIter >= mCntChildren ) {
		TNodeMod_iterDelete thismod
		return false
		
	} else {
		vIterId = mChildren(mIter)
		if ( IsTnIdValid(vIterId) == false ) {
			return TNodeMod_iterCheck( thismod, vIterId )
		}
		return true
	}
	
//##########################################################
//        その他
//##########################################################
/**
 * ノードを連結する
 * ノードの持つ子孫ノードすべてを再帰的に複製し、追加します。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @prm p2 = modvar	: 連結元
 * @return = void
 */
#deffunc TNode_chain int thisId, int fromId,  local itId, local stmp, local childId, local value
	
	TNode_iterNew fromId
	while ( TNode_iterCheck(fromId, itId) )
		
		stmp = TNode_getName(itId)
		TNode_getv       itId, value
		TNode_addChild thisId, stmp			// 同名の子ノードを追加
		childId = stat
		TNode_setv     childId, value		// 保持する値をコピー
		TNode_chain    childId, itId		// 孫レベルノードを連結
		
	wend
	return
	
/**
 * ノードを複製する
 * ノードの値と、その子ノードすべてを再帰的に複製します。
 * 
 * @prm p1 = modvar	: モジュール変数
 * @prm p2 = modvar	: 複製元
 * @return = void
 */
#deffunc TNode_copy int thisId, int fromId
	TNode_clear thisId
	TNode_chain thisId, fromId
	return
	
/**
 * ノードを交換する
 * 2つのノードを交換します。
 * 
 * @prm p1 = modvar : ノード1
 * @prm p2 = modvar : ノード2
 * @return = void
 */
#deffunc TNode_exchange int thisId, int fromId, local tempId
	TRoot_new  tempId
	TNode_copy tempId, thisId
	TNode_copy thisId, fromId
	TNode_copy fromId, tempId
	TNode_delete tempId
	return
	
//------------------------------------------------
// [i] コンストラクタ
//------------------------------------------------
#modinit str _name, int _idParent
	sdim mName				// ノード名
	mIdParent = _idParent	// 親ノード
	mName     = _name
	
	TNodeMod_clear thismod
	return getaptr(thismod)
	
//##########################################################
//        デバッグ用メンバ
//##########################################################
#ifdef _DEBUG
//-------- デバッグ時 --------

// ノード名を再帰的に出力する
#deffunc TNode_dbglog int thisId, int nest,  local itId, local stmp
	if ( isTnIdValid(thisId) == false ) { return }
	
	sdim stmp, nest * 2 + 512
	
	if ( nest > 0 ) {
		repeat nest - 1
			stmp += "|  "
		loop
	}
	if ( TNode_isRoot(thisId) == false ) {
		stmp += "|-- "
	}
	
	logmes stmp + TNode_getName( thisId )
	
	TNode_iterNew thisId
	while ( TNode_iterCheck( thisId, itId ) )
		TNode_dbglog itId, nest + 1
	wend
	return
	
#else
//-------- 非デバッグ時 --------

#define TNode_dbglog(%1,%2) :

#endif

#global
TRootMod_new ""

//##############################################################################
//               サンプル・スクリプト
//##############################################################################
#if 0
	
	TRoot_new mtr
	TNode_set mtr, "親"
	
	for i, 0, 3
		name = "c"+ i
		TNode_addChild mtr, name
		TNode_set stat, TNode_get(mtr) +" - 子("+ i +")"
		
		repeat 5
			name = "cc"+ cnt
			
			mchild = TNode_getChild( mtr, "c"+ i )
			
			TNode_addChild mchild, name
			TNode_set stat, TNode_get(mchild) +" - 孫("+ cnt +")"
		loop
		
	next
	
	for i, 0,  TNode_cntChildren( mtr )
		repeat TNode_cntChildren( TNChild(mtr, "c"+ i) )
			mes TNode_get( TNChild( TNChild(mtr, "c"+ i), "cc"+ cnt) )
;			mes TNode_get( TNChildHier( mtr, "c"+ i +"/cc"+ cnt ) )		// '/' で階層表現
		loop
	next
	
	pos 300, 10
	TNode_dbglog mtr
	
	TRoot_new    mtr2, "root2"
;	TNode_chain  mtr2, mtr
	TNode_copy   mtr2, mtr
	TNode_dbglog mtr2
	
	stop

#endif

#endif
