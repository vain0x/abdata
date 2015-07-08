// JSON 管理クラス (using abdata)

#ifndef IG_MODULECLASS_ABDATA_JSON_IMPL_AS
#define IG_MODULECLASS_ABDATA_JSON_IMPL_AS

#include "Mo/mod_array.as"
#include "Mo/strutil.as"
;#include "extendTab.as"

#include "Mo/abdata/list.as"
#include "Mo/abdata/pair.as"
#include "Mo/abdata/tnode.as"

#include "AbJson.as"
#include "MCAbJsonLexer.as"
#include "MCAbJsonParser.as"

//##############################################################################
//                  定義部 : MCAbJson
//##############################################################################
#module MCAbJson mTree

#include "AbJson.header.as"

//------------------------------------------------
// 真理値・成敗値・NULL値
//------------------------------------------------
#define true    1
#define false   0
#define success 1
#define failure 0
#define NULL    0

//##########################################################
//        構築・解体
//##########################################################
#define global abjson_new(%1)    newmod %1, MCAbJson@
#define global abjson_delete(%1) delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit
	mTree = tnodeNull
	return
	
//------------------------------------------------
// データ入力 (文字列)
// 
// @enc: Shift-JIS
//------------------------------------------------
#modfunc abjson_LoadAsText str src,  local lexer, local parser, local tklist
	abjsonLexer_new     lexer, src
	abjsonLexer_Lex     lexer,        tklist : cntToken = stat
	abjsonParser_new   parser
	abjsonParser_Parse parser, mTree, tklist,  cntToken
	return
	
//------------------------------------------------
// データ入力 (木構造 (部分木))
//------------------------------------------------
#modfunc abjson_LoadAsTree var tree
	mTree = tree
	return
	
//------------------------------------------------
// 解体
//------------------------------------------------
;#modterm
;	return
	
//##########################################################
//        動作系
//##########################################################
//------------------------------------------------
// 
//------------------------------------------------

//##########################################################
//        取得系
//##########################################################
//------------------------------------------------
// オブジェクトの取り出し
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

//##########################################################
//        デバッグ用
//##########################################################
#ifdef _DEBUG
//-------- デバッグ時 --------

//------------------------------------------------
// JSON文字列を生成する
//------------------------------------------------
#modcfunc abjson_ToJsonText
	return abjson_ToJsonText_impl( thismod, mTree, 0 )
	
#modcfunc abjson_ToJsonText_impl var nodeParent, int nest,  \
	local text, local it, local stmp, local val, local type, local node, local chd
	
	chd  = tnode_getChd(nodeParent)			// 子ノード値
	type = tnode_get(nodeParent)
	logmes strmul("    ", nest) + /*"[sub-root, type, chd] = " */ "[" + nodeParent + ", " + type + ", " + chd + "]"
;	assert
	switch ( type )
		// 構造
		
		case AbJsonNodeName_Root:
			stmp = abjson_ToJsonText_impl( thismod, chd, nest + 1 )
			swbreak
			
		case AbJsonNodeName_Object:
			stmp = "{\n"
			IterateBegin chd, list, it		// (chd : list<tnode>), (it : tnode<pair<key, val>>)
				stmp += strmul("\t", nest) + abjson_ToJsonText_impl( thismod, it, nest + 1 ) + ",\n"
			IterateEnd
			stmp += strmul("\t", nest - 1) + "}"
			swbreak
			
		case AbJsonNodeName_Pair:			// (chd : pair<tnode<key>, tnode<val>>)
			repeat pair_size(chd)
				node     = pair_get( chd, cnt )
				val(cnt) = abjson_ToJsonText_impl( thismod, node, nest + 1 )
			loop
			stmp = val(0) + " : " + val(1)
			swbreak
			
		case AbJsonNodeName_Array:
			stmp = "[\n"
			IterateBegin chd, list, it		// (chd : list<tnode>), (it : tnode<value>)
				val = abjson_ToJsonText_impl( thismod, it, nest + 1 )
				stmp += strmul("\t", nest) + val + ",\n"
			IterateEnd
			stmp += strmul("\t", nest - 1) + "]"
			swbreak
			
		// 値
			
		case AbJsonNodeName_String: return chd				// chd : str
		case AbJsonNodeName_Number: return str(chd)			// chd : double
		
		case AbJsonNodeName_Bool: 
			if ( chd ) {
				return "true"
			} else {
				return "false"
			}
			
		case AbJsonNodeName_Null: return "null"				// chd: (none)
		
		default:
			dbgout( "unknown-node: " + swthis )
			swbreak
	swend
	return stmp
	
#else
//-------- 非デバッグ時 --------

#define abjson_dbglog(%1, %2) :

#endif

#global

//##############################################################################
//                サンプル・スクリプト
//##############################################################################
#if 1

	src = {"
		{
			"name": "uedai",
			"age":  17,
			"list": [ 3, 1, 7 ],
			"obj": {
				"pt-bgn": {
					"class": "point",
					"x": 2, "y": 7
				},
				"pt-end": {
					"class": "point",
					"x": 1.0e2, "y": 83
				}
			},
			"using": true,
			"skill": null
		}
	"}
	
	abjson_new jr
	abjson_LoadAsText jr, src
	
	buf = abjson_ToJsonText( jr )
	mes buf
	stop
	
#endif

#endif
