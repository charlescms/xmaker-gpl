// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSybaseToken.pas' rev: 5.00

#ifndef ZSybaseTokenHPP
#define ZSybaseTokenHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZGenericSqlToken.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsybasetoken
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZSybaseNumberState;
class PASCALIMPLEMENTATION TZSybaseNumberState : public Ztokenizer::TZNumberState 
{
	typedef Ztokenizer::TZNumberState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZSybaseNumberState(void) : Ztokenizer::TZNumberState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSybaseNumberState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSybaseQuoteState;
class PASCALIMPLEMENTATION TZSybaseQuoteState : public Ztokenizer::TZQuoteState 
{
	typedef Ztokenizer::TZQuoteState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
	virtual AnsiString __fastcall EncodeString(AnsiString Value, char QuoteChar);
	virtual AnsiString __fastcall DecodeString(AnsiString Value, char QuoteChar);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZSybaseQuoteState(void) : Ztokenizer::TZQuoteState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSybaseQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSybaseCommentState;
class PASCALIMPLEMENTATION TZSybaseCommentState : public Ztokenizer::TZCppCommentState 
{
	typedef Ztokenizer::TZCppCommentState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZSybaseCommentState(void) : Ztokenizer::TZCppCommentState()
		 { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSybaseCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSybaseSymbolState;
class PASCALIMPLEMENTATION TZSybaseSymbolState : public Ztokenizer::TZSymbolState 
{
	typedef Ztokenizer::TZSymbolState inherited;
	
public:
	__fastcall TZSybaseSymbolState(void);
public:
	#pragma option push -w-inl
	/* TZSymbolState.Destroy */ inline __fastcall virtual ~TZSybaseSymbolState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSybaseWordState;
class PASCALIMPLEMENTATION TZSybaseWordState : public Zgenericsqltoken::TZGenericSQLWordState 
{
	typedef Zgenericsqltoken::TZGenericSQLWordState inherited;
	
public:
	__fastcall TZSybaseWordState(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSybaseWordState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSybaseTokenizer;
class PASCALIMPLEMENTATION TZSybaseTokenizer : public Ztokenizer::TZTokenizer 
{
	typedef Ztokenizer::TZTokenizer inherited;
	
public:
	__fastcall TZSybaseTokenizer(void);
public:
	#pragma option push -w-inl
	/* TZTokenizer.Destroy */ inline __fastcall virtual ~TZSybaseTokenizer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsybasetoken */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsybasetoken;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSybaseToken
