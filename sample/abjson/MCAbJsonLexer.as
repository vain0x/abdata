#ifndef IG_MODULECLASS_ABDATA_JSON_READER_AS
#define IG_MODULECLASS_ABDATA_JSON_READER_AS

// json 字句解析器

#include "Mo/mod_array.as"
#include "Mo/strutil.as"

#module MCAbJsonLexer mSrc, tktype, tkstr, tklen, idx, cntToken, tktypelist, tkstrlist

#include "Mo/ctype.as"
#include "AbJson.header.as"

#define global abjsonLexer_new(%1,%2) newmod %1, MCAbJsonLexer@, %2
#define global abjsonLexer_delete(%1) delmod %1

//------------------------------------------------
// 構築
//------------------------------------------------
#modinit str src
	mSrc = src
	mlen = strlen(mSrc)
	
	sdim tkstr
	dim tktype
	return
	
//------------------------------------------------
// 字句解析
//------------------------------------------------
#modfunc abjsonLexer_Lex array tklist
	dim tktypelist
	sdim tkstrlist
	
	idx      = 0
	tktype   = TkType_None
	cntToken = 0
	
	repeat
		// 最後まで取得したら終了する
		if ( mlen <= idx ) { break }
		
		// 次のトークンを取得
		abjsonLexer_Lex_GetNextToken thismod, tkstr, idx
		tktype = stat
		tklen  = strlen(tkstr)
		idx   += tklen
		
		// 無視されるトークン => 飛ばす
		if ( tktype == TkType_Blank || tktype == TkType_Comment ) {
			continue
		}
		
		if ( tktype == TkType_Error ) {
			cntToken = -1
			break
		}
		
		dbgout( strf( "#%2d[%3d]: ( %2d, '%s' )", cnt, idx, tktype, tkstr ) )
		
		// 更新
		tktypelist(cntToken) = tktype
		tkstrlist (cntToken) = tkstr
		cntToken ++
	loop
	
	tktypelist(cntToken) = TkType_Final
	tkstrlist (cntToken) = ""
	cntToken ++
	
#if _b_dbgout
	dbgout( "＠字句解析::ログ" )
	repeat cntToken
		dbgout( strf("#%2d: (tktype, tkstr) = ( %2d, %s )", cnt, tktypelist(cnt), tkstrlist(cnt) ) )
	loop
#endif
	
	tklist = new_list(), new_list()
	repeat cntToken
		list_add tklist(0), tktypelist(cnt)
		list_add tklist(1), tkstrlist(cnt)
	loop
	
	return cntToken
	
//**********************************************************
//        識別子切り出し [static]
//**********************************************************
//------------------------------------------------
// エスケープシーケンス付き切り出し
//------------------------------------------------
#define FTM_CutTokenInEsqSec(%1,%2,%3) /* %1 = オフセット, %2 = 終了条件 */\
	i = (%1) :\
	repeat :\
		c = peek(sSrc, iOffset + i) : i ++ :\
		if ( c == '\\' || IsSJIS1st(c) ) {		/* 次も確実に書き込む */\
			i ++ :\
		}\
		if ( %2 ) { break }/* 終了 */\
	loop :\
	return strmid(sSrc, iOffset, i)
	
//------------------------------------------------
// 文字列か文字定数を切り出す
//------------------------------------------------
#defcfunc CutStr_or_Char@MCAbJsonLexer var sSrc, int iOffset, int p3
	FTM_CutTokenInEsqSec 1, ( c == p3 || IsNewLine(c) || c == 0 )
	
//------------------------------------------------
// 文字列を切り出して返す
//------------------------------------------------
#define ctype CutString(%1, %2 = 0) CutStr_or_Char( %1, %2, '"' )

//------------------------------------------------
// 範囲の違う「トークン」を切り出して返す
//------------------------------------------------
#define FTM_CutToken(%1,%2=0) \
	i = iOffset :\
	repeat :\
		c = peek(sSrc, i) :\
		if ((%1) == false || c == 0) { break } \
		if (%2) { i ++ }\
		i ++ :\
	loop :\
	return strmid(sSrc, iOffset, i - iOffset)
	
//------------------------------------------------
// 空白を切り出して返す
//------------------------------------------------
#defcfunc CutBlank@MCAbJsonLexer var sSrc, int iOffset
	FTM_CutToken ( IsBlank(c) )
	
//------------------------------------------------
// 識別子を切り出して返す
//------------------------------------------------
#undef CutIdent			// @strutil
#defcfunc CutIdent@MCAbJsonLexer var sSrc, int iOffset
	FTM_CutToken ( IsIdent(c) || IsSJIS1st(c) ), IsSJIS1st(c)
	
//------------------------------------------------
// 10進数を切り出して返す
//------------------------------------------------
#defcfunc CutNum_Dgt@MCAbJsonLexer var sSrc, int iOffset
	FTM_CutToken ( IsDigit(c) || c == '_' )
	
//**********************************************************
//        字句取り出し
//**********************************************************
//------------------------------------------------
// 次のトークンを取得する
//------------------------------------------------
#modfunc abjsonLexer_Lex_GetNextToken@MCAbJsonLexer var result, int idx_,  local restype
	idx = idx_
	c = peek(mSrc, idx)
	
	// 空白 (Blank)
	if ( IsBlank(c) ) {
		result = CutBlank(mSrc, idx)
		return TkType_Blank
	}
	
	// 記号 (Sign)
	switch ( c )
		case '(': result = "(" : return TkType_ParenL
		case ')': result = ")" : return TkType_ParenR
		case '[': result = "[" : return TkType_BrkArrL
		case ']': result = "]" : return TkType_BrkArrR
		case '{': result = "{" : return TkType_BrkObjL
		case '}': result = "}" : return TkType_BrkObjR
		case ':': result = ":" : return TkType_Colon
		case ',': result = "," : return TkType_Comma
		case '.': result = "." : return TkType_Period
	swend
	
	// 整数部 (Digit)
	if ( IsDigit(c) ) {
		restype = TkType_Digit
		result  = CutNum_Dgt(mSrc, idx)
		len     = strlen(result)
		c       = peek(mSrc, idx + len)
		
		// 小数部 (Frac)
		if ( c == '.' ) {
			c2 = peek(mSrc, idx + len + 1)
			if ( IsDigit(c2) ) {
				result += "." + CutNum_Dgt(mSrc, idx + len + 1)
				len     = strlen(result)
				c       = peek(mSrc, idx + len)
				restype = TkType_Number
			}
		}
		
		// 指数部 (Exp)
		if ( c == 'e' || c == 'E' ) {
			c2 = peek(mSrc, idx + len + 1)
			if ( c2 == '+' || c2 == '-' || IsDigit(c2) ) {
				if ( IsDigit(c2) ) {
					result += "e" + CutNum_Dgt(mSrc, idx + len + 1)
				} else {
					result += strf("e%c%s", c2, CutNum_Dgt(mSrc, idx + len + 2))
				}
				restype = TkType_Number
			}
		}
		
		return restype
	}
	
	// 識別子 (Identifier)
	if ( IsIdentTop(c) || IsSJIS1st(c) ) {
		result = CutIdent(mSrc, idx)
		return TkType_Ident
	}
	
	// 文字列定数 (Single-line String Literal)
	if ( c == '\"' ) {
		result = CutString(mSrc, idx)			// 文字列を取り出す (""を含む)
		return TkType_String
	}
	
	// 謎な場合
/*
	if ( isSJIS1st(c) ) {
		logmes "ERROR! SJIS code!"
		wpoke result, 0, wpeek(mSrc, idx)	// 書き込む
		poke  result, 3, NULL
		return TkType_Error
	}
	
	// ？？？
	result = strf("%c", c)
	logmes "ERROR !! Can't Pop a Token! [ " + index + strf(" : %c : ", c) + c + " ]"
//*/
	return TkType_Error
	
#global

#endif
