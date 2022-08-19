// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZMySqlToken.pas' rev: 5.00

#ifndef ZMySqlTokenHPP
#define ZMySqlTokenHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZGenericSqlToken.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zmysqltoken
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZMySQLNumberState;
class PASCALIMPLEMENTATION TZMySQLNumberState : public Ztokenizer::TZNumberState 
{
	typedef Ztokenizer::TZNumberState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZMySQLNumberState(void) : Ztokenizer::TZNumberState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQLNumberState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMySQLQuoteState;
class PASCALIMPLEMENTATION TZMySQLQuoteState : public Ztokenizer::TZQuoteState 
{
	typedef Ztokenizer::TZQuoteState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
	virtual AnsiString __fastcall EncodeString(AnsiString Value, char QuoteChar);
	virtual AnsiString __fastcall DecodeString(AnsiString Value, char QuoteChar);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZMySQLQuoteState(void) : Ztokenizer::TZQuoteState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQLQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMySQLCommentState;
class PASCALIMPLEMENTATION TZMySQLCommentState : public Ztokenizer::TZCppCommentState 
{
	typedef Ztokenizer::TZCppCommentState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZMySQLCommentState(void) : Ztokenizer::TZCppCommentState() { }
		
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQLCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMySQLSymbolState;
class PASCALIMPLEMENTATION TZMySQLSymbolState : public Ztokenizer::TZSymbolState 
{
	typedef Ztokenizer::TZSymbolState inherited;
	
public:
	__fastcall TZMySQLSymbolState(void);
public:
	#pragma option push -w-inl
	/* TZSymbolState.Destroy */ inline __fastcall virtual ~TZMySQLSymbolState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMySQLWordState;
class PASCALIMPLEMENTATION TZMySQLWordState : public Zgenericsqltoken::TZGenericSQLWordState 
{
	typedef Zgenericsqltoken::TZGenericSQLWordState inherited;
	
public:
	__fastcall TZMySQLWordState(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQLWordState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMySQLTokenizer;
class PASCALIMPLEMENTATION TZMySQLTokenizer : public Ztokenizer::TZTokenizer 
{
	typedef Ztokenizer::TZTokenizer inherited;
	
public:
	__fastcall TZMySQLTokenizer(void);
public:
	#pragma option push -w-inl
	/* TZTokenizer.Destroy */ inline __fastcall virtual ~TZMySQLTokenizer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zmysqltoken */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zmysqltoken;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZMySqlToken
