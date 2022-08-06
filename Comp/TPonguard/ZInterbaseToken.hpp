// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZInterbaseToken.pas' rev: 5.00

#ifndef ZInterbaseTokenHPP
#define ZInterbaseTokenHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPostgreSqlToken.hpp>	// Pascal unit
#include <ZGenericSqlToken.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zinterbasetoken
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZInterbaseNumberState;
class PASCALIMPLEMENTATION TZInterbaseNumberState : public Zpostgresqltoken::TZPostgreSQLNumberState 
	
{
	typedef Zpostgresqltoken::TZPostgreSQLNumberState inherited;
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZInterbaseNumberState(void) : Zpostgresqltoken::TZPostgreSQLNumberState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZInterbaseNumberState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbaseQuoteState;
class PASCALIMPLEMENTATION TZInterbaseQuoteState : public Zgenericsqltoken::TZGenericSQLQuoteState 
{
	typedef Zgenericsqltoken::TZGenericSQLQuoteState inherited;
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZInterbaseQuoteState(void) : Zgenericsqltoken::TZGenericSQLQuoteState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZInterbaseQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbaseCommentState;
class PASCALIMPLEMENTATION TZInterbaseCommentState : public Ztokenizer::TZCCommentState 
{
	typedef Ztokenizer::TZCCommentState inherited;
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZInterbaseCommentState(void) : Ztokenizer::TZCCommentState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZInterbaseCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbaseSymbolState;
class PASCALIMPLEMENTATION TZInterbaseSymbolState : public Ztokenizer::TZSymbolState 
{
	typedef Ztokenizer::TZSymbolState inherited;
	
public:
	__fastcall TZInterbaseSymbolState(void);
public:
	#pragma option push -w-inl
	/* TZSymbolState.Destroy */ inline __fastcall virtual ~TZInterbaseSymbolState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbaseWordState;
class PASCALIMPLEMENTATION TZInterbaseWordState : public Zgenericsqltoken::TZGenericSQLWordState 
{
	typedef Zgenericsqltoken::TZGenericSQLWordState inherited;
	
public:
	__fastcall TZInterbaseWordState(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZInterbaseWordState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbaseTokenizer;
class PASCALIMPLEMENTATION TZInterbaseTokenizer : public Ztokenizer::TZTokenizer 
{
	typedef Ztokenizer::TZTokenizer inherited;
	
public:
	__fastcall TZInterbaseTokenizer(void);
public:
	#pragma option push -w-inl
	/* TZTokenizer.Destroy */ inline __fastcall virtual ~TZInterbaseTokenizer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zinterbasetoken */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zinterbasetoken;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZInterbaseToken
