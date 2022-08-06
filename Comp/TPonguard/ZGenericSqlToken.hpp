// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZGenericSqlToken.pas' rev: 5.00

#ifndef ZGenericSqlTokenHPP
#define ZGenericSqlTokenHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zgenericsqltoken
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZGenericSQLSymbolState;
class PASCALIMPLEMENTATION TZGenericSQLSymbolState : public Ztokenizer::TZSymbolState 
{
	typedef Ztokenizer::TZSymbolState inherited;
	
public:
	__fastcall TZGenericSQLSymbolState(void);
public:
	#pragma option push -w-inl
	/* TZSymbolState.Destroy */ inline __fastcall virtual ~TZGenericSQLSymbolState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZGenericSQLWordState;
class PASCALIMPLEMENTATION TZGenericSQLWordState : public Ztokenizer::TZWordState 
{
	typedef Ztokenizer::TZWordState inherited;
	
public:
	__fastcall TZGenericSQLWordState(void);
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZGenericSQLWordState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZGenericSQLQuoteState;
class PASCALIMPLEMENTATION TZGenericSQLQuoteState : public Ztokenizer::TZQuoteState 
{
	typedef Ztokenizer::TZQuoteState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
	virtual AnsiString __fastcall EncodeString(AnsiString Value, char QuoteChar);
	virtual AnsiString __fastcall DecodeString(AnsiString Value, char QuoteChar);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZGenericSQLQuoteState(void) : Ztokenizer::TZQuoteState() { }
		
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZGenericSQLQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZGenericSQLTokenizer;
class PASCALIMPLEMENTATION TZGenericSQLTokenizer : public Ztokenizer::TZTokenizer 
{
	typedef Ztokenizer::TZTokenizer inherited;
	
public:
	__fastcall TZGenericSQLTokenizer(void);
public:
	#pragma option push -w-inl
	/* TZTokenizer.Destroy */ inline __fastcall virtual ~TZGenericSQLTokenizer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zgenericsqltoken */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zgenericsqltoken;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZGenericSqlToken
