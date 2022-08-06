// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZExprToken.pas' rev: 5.00

#ifndef ZExprTokenHPP
#define ZExprTokenHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zexprtoken
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZExpressionNumberState;
class PASCALIMPLEMENTATION TZExpressionNumberState : public Ztokenizer::TZNumberState 
{
	typedef Ztokenizer::TZNumberState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZExpressionNumberState(void) : Ztokenizer::TZNumberState() { }
		
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpressionNumberState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionQuoteState;
class PASCALIMPLEMENTATION TZExpressionQuoteState : public Ztokenizer::TZQuoteState 
{
	typedef Ztokenizer::TZQuoteState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
	virtual AnsiString __fastcall EncodeString(AnsiString Value, char QuoteChar);
	virtual AnsiString __fastcall DecodeString(AnsiString Value, char QuoteChar);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZExpressionQuoteState(void) : Ztokenizer::TZQuoteState() { }
		
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpressionQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionCommentState;
class PASCALIMPLEMENTATION TZExpressionCommentState : public Ztokenizer::TZCppCommentState 
{
	typedef Ztokenizer::TZCppCommentState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZExpressionCommentState(void) : Ztokenizer::TZCppCommentState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpressionCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionSymbolState;
class PASCALIMPLEMENTATION TZExpressionSymbolState : public Ztokenizer::TZSymbolState 
{
	typedef Ztokenizer::TZSymbolState inherited;
	
public:
	__fastcall TZExpressionSymbolState(void);
public:
	#pragma option push -w-inl
	/* TZSymbolState.Destroy */ inline __fastcall virtual ~TZExpressionSymbolState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionWordState;
class PASCALIMPLEMENTATION TZExpressionWordState : public Ztokenizer::TZWordState 
{
	typedef Ztokenizer::TZWordState inherited;
	
public:
	__fastcall TZExpressionWordState(void);
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpressionWordState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionTokenizer;
class PASCALIMPLEMENTATION TZExpressionTokenizer : public Ztokenizer::TZTokenizer 
{
	typedef Ztokenizer::TZTokenizer inherited;
	
public:
	__fastcall TZExpressionTokenizer(void);
public:
	#pragma option push -w-inl
	/* TZTokenizer.Destroy */ inline __fastcall virtual ~TZExpressionTokenizer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zexprtoken */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zexprtoken;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZExprToken
