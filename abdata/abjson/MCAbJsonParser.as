// JSON 構文解析クラス (using abdata)

#ifndef IG_MODULECLASS_ABDATA_JSON_PARSER_AS
#define IG_MODULECLASS_ABDATA_JSON_PARSER_AS

#include "Mo/mod_array.as"

#include "Mo/abdata/list.as"
#include "Mo/abdata/pair.as"
#include "Mo/abdata/tnode.as"

//##############################################################################
//                  定義部 : MCAbJsonParser
//##############################################################################
#module MCAbJsonParser tktype, tkstr, idx, cntToken, tklist

#include "Mo/ctype.as"
#include "AbJson.as"
#include "AbJson.header.as"

//------------------------------------------------
// 真理値・成敗値・NULL値
//------------------------------------------------
#define true    1
#define false   0
#define success 1
#define failure 0
#define NULL    0

//------------------------------------------------
// 定数：解析モード
//------------------------------------------------
#enum ParseMode_Final = 0
#enum ParseMode_Root
#enum ParseMode_Object
#enum ParseMode_Pair
#enum ParseMode_Array
#enum ParseMode_Value

#enum ParseMode_Complete
#enum ParseMode_
;#enum ParseMode_
;#enum ParseMode_
#enum ParseMode_MAX

//##########################################################
//        構築・解体
//##########################################################
#define global abjsonParser_new(%1)    newmod %1, MCAbJsonParser@
#define global abjsonParser_delete(%1) delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit
	dim tktype
	sdim tkstr
	return
	
//------------------------------------------------
// 解体
//------------------------------------------------
#modterm
	return
	
//##########################################################
//        動作系
//##########################################################
#define NextToken abjsonParser_NextToken thismod
#define ctype tktypelist(%1) list_get( tklist(0), (%1) )
#define ctype tkstrlist(%1)  list_get( tklist(1), (%1) )

//------------------------------------------------
// 構文解析 (JSON 構造の生成)
// 
// @alg: 再帰下降構文解析
//------------------------------------------------
#modfunc abjsonParser_Parse var result, array tklist_, int cntToken_,  local root
	tklist   = tklist_(0), tklist_(1)
	idx      = 0
	cntToken = cntToken_
	
	NextToken
	if ( tktype == TkType_Final ) { return }
	
	if ( idx >= cntToken ) { return }
	result = abjsonParser_Root( thismod )
	
	return
	
//------------------------------------------------
// 次のトークンを先読みする
//------------------------------------------------
#modfunc abjsonParser_NextToken
	if ( idx < cntToken ) {
		dbgout( strf( "NextToken[%02d]: (%d, %s)", idx, tktypelist(idx), tkstrlist(idx) ) )
		tktype = tktypelist(idx)
		tkstr  = tkstrlist(idx)
		idx ++
	} else {
		dbgout( "NextToken: Overflow" )
	}
	return
	
//**********************************************************
//        解析ルーチン
//**********************************************************
/*
// スタック方式の解析 : 未完成, 誰得
#modcfunc abjsonParser_Root  local node, local tmp
	stack_new stkMode
	stack_new stkNeed
	stack_new stkType
	stack_new stkData
	
	stack_push stkMode, ParseMode_Root
	
	repeat
		abjsonParser_ProcNext thismod, stack_peek(stkMode), stkData, stkType
		if ( stack_peek(stkMode) == ParseMode_Final ) {
			break
		}
	loop
	
	return
	
#modcfunc abjsonParser_ProcNext int mode,  local node, local tmp
	switch ( mode )
		case ParseMode_Root:
			NextToken
			switch ( tktype )
				case TkType_BrkObjL: stack_push stkNeed, TkType_Members : return ParseMode_Object
				case TkType_BrkArrL: stack_push stkNeed, TkType_Elems   : return ParseMode_Array
				default:
					return ParseMode_Value
			swend
			
		case ParseMode_Object:
			NextToken
			switch ( tktype )
				case TkType_BrkObjR: return ParseMode_Complete
				case TkType_Comma:
					NextToken
				//	fall
				default:
					stack_push stkNeed, TkType_Pair
					return ParseMode_Pair
			swend
			
		case ParseMode_Pair:
			needs = TkType_String, TkType_Colon, TkType_Value, TkType_Final
			foreach needs
				stack_push stkNeed, needs(length(needs) - cnt + 1)	// 逆順に追加
			loop
			return ParseMode_Need
			
		case ParseMode_Need:
			need = stack_pop( stkNeed )
			NextToken
			switch ( need )
				case TkType_Final: return ParseMode_Complete
				
				case TkType_String:
					tnode_new node, AbJsonNodeName_String, tkstr
					stack_push stkData, node
					swbreak
					
				case TkType_Digit:				// 整数
				case TkType_Number:				// 実数 (整数部 [+])
					tnode_new node, AbJsonNodeName_Number, double(tkstr)
					stack_push stkData, node
					swbreak
					
				case TkType_Value:
					stack_push stkNeed, tktype
					swbreak
					
				default:
					if ( tktype != need ) {
						logmes "要求通りのトークンが配置されていなかった"
					}
			swend
			return mode
			
	swend
	
/*/
//------------------------------------------------
// elem: Root
// 
// @syntax: (Object | Array | Value)
//------------------------------------------------
#modcfunc abjsonParser_Root  local node, local tmp
	switch ( tktype )
		case TkType_BrkObjL: tmp = abjsonParser_Object( thismod ) : swbreak
		case TkType_BrkArrL: tmp = abjsonParser_Array ( thismod ) : swbreak
		default:
			tmp = abjsonParser_Value( thismod )
			swbreak
	swend
	tnode_new node, AbJsonNodeName_Root, tmp
	return node
	
//------------------------------------------------
// elem: Object
// 
// @syntax: '{' Members '}'
// @	Members := Pair % ','		( a % b ⇔ (a (b a)*)? )
//------------------------------------------------
#modcfunc abjsonParser_Object  local node, local members
	dbgout( "object {" )
	NextToken		// pop '{'
	
	members = new_list()
	
	// parse Members
	repeat
		if ( tktype == TkType_BrkObjR ) { break }
		
		list_add members, abjsonParser_Pair( thismod )
		
		if ( tktype != TkType_BrkObjR && tktype != TkType_Comma ) {
			dbgout( "SyntaxError: 'Members' (need ',' or '}')" )	// error
			members = listNull
			break
		}
		if ( tktype == TkType_Comma ) { NextToken }
	loop
	tnode_new node, AbJsonNodeName_Object, members		// has List<tnode(pair)>
	
	NextToken		// pop '}'
	dbgout( "} object" )
	return node
	
//------------------------------------------------
// elem: Pair
// 
// @syntax: String ':' Value
//------------------------------------------------
#modcfunc abjsonParser_Pair  local node, local key, local val
	dbgout( "pair <" )
	
	key = abjsonParser_String( thismod )
	if ( tktype != TkType_Colon ) { dbgout( "SyntaxError: 'pair' (need ':')" ) : return tnodeNull }
	NextToken
	
	val = abjsonParser_Value( thismod )
	
	dbgout( "> pair" )
	tnode_new node, AbJsonNodeName_Pair, new_pair( key, val )
	return node
	
//------------------------------------------------
// elem: Array
// 
// @ syntax: '[' Elements ']'
// @	Elements := Value % ','
//------------------------------------------------
#modcfunc abjsonParser_Array  local node
	dbgout( "array [" )
	NextToken		// pop '['
	
	tnode_new node, AbJsonNodeName_Array, new_list()		// has List<Pair>
	
	// parse Elements
	repeat
		if ( tktype == TkType_BrkArrR ) { break }
		
		tnx_addChd node, abjsonParser_Value( thismod )
		
		if ( tktype != TkType_BrkArrR && tktype != TkType_Comma ) {
			dbgout( "SyntaxError: 'Elements' (need ',' or ']')" )	// error
			tnode_set node, listNull
			break
		}
		if ( tktype == TkType_Comma ) { NextToken }
	loop
	
	NextToken		// pop ']'
	dbgout( "] array" )
	return node
	
//------------------------------------------------
// elem: Value
// 
// @syntax: (Object | Array | Number | String | Ident)
//------------------------------------------------
#modcfunc abjsonParser_Value  local node, local tmp
	switch ( tktype )
		case TkType_BrkObjL: return abjsonParser_Object( thismod )
		case TkType_BrkArrL: return abjsonParser_Array( thismod )
		
		case TkType_Digit:												// 整数
		case TkType_Number:	return abjsonParser_Number( thismod )		// 実数 (整数部 [+])
		
		case TkType_String: return abjsonParser_String( thismod )
		case TkType_Ident:  return abjsonParser_Ident( thismod )
		
		default:
			dbgout( "unknown value: (" + tktype + ", " + tkstr + ")" )
			NextToken
			return tnodeNull
	swend
	
//------------------------------------------------
// elem: (Digit | Number)
// 
// @syntax: (略)
//------------------------------------------------
#modcfunc abjsonParser_Number  local node, local tmp
	tmp = double(tkstr)
	NextToken
	tnode_new node, AbJsonNodeName_Number, tmp
	return node
	
//------------------------------------------------
// elem: String
// 
// @syntax: '"' (any_char)* '"'
//------------------------------------------------
#modcfunc abjsonParser_String  local node
	tnode_new node, AbJsonNodeName_String, tkstr
	NextToken
	return node
	
//------------------------------------------------
// elem: Ident
// 
// @syntax: ("true" | "false" | "null")
//------------------------------------------------
#modcfunc abjsonParser_Ident  local node
	switch ( getpath(tkstr, 16) )
		xcase "true":  tnode_new node, AbJsonNodeName_Bool, true
		xcase "false": tnode_new node, AbJsonNodeName_Bool, false
		xcase "null":  tnode_new node, AbJsonNodeName_Null, null
		xdefault:
			dbgout( "UnknownIdent: " + tkstr )
			node = tnodeNull
	swend
	NextToken
	return node
	
//*/
	
//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        設定系
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        統一関数
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        その他
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 0

#endif

#endif
