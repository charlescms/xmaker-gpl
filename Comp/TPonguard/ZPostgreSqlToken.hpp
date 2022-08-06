// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPostgreSqlToken.pas' rev: 5.00

#ifndef ZPostgreSqlTokenHPP
#define ZPostgreSqlTokenHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZMySqlToken.hpp>	// Pascal unit
#include <ZGenericSqlToken.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zpostgresqltoken
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZPostgreSQLNumberState;
class PASCALIMPLEMENTATION TZPostgreSQLNumberState : public Zmysqltoken::TZMySQLNumberState 
{
	typedef Zmysqltoken::TZMySQLNumberState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZPostgreSQLNumberState(void) : Zmysqltoken::TZMySQLNumberState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQLNumberState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPostgreSQLQuoteState;
class PASCALIMPLEMENTATION TZPostgreSQLQuoteState : public Zmysqltoken::TZMySQLQuoteState 
{
	typedef Zmysqltoken::TZMySQLQuoteState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZPostgreSQLQuoteState(void) : Zmysqltoken::TZMySQLQuoteState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQLQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPostgreSQLCommentState;
class PASCALIMPLEMENTATION TZPostgreSQLCommentState : public Ztokenizer::TZCppCommentState 
{
	typedef Ztokenizer::TZCppCommentState inherited;
	
public:
	virtual Ztokenizer::TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, Ztokenizer::TZTokenizer* 
		Tokenizer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZPostgreSQLCommentState(void) : Ztokenizer::TZCppCommentState(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQLCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPostgreSQLSymbolState;
class PASCALIMPLEMENTATION TZPostgreSQLSymbolState : public Ztokenizer::TZSymbolState 
{
	typedef Ztokenizer::TZSymbolState inherited;
	
public:
	__fastcall TZPostgreSQLSymbolState(void);
public:
	#pragma option push -w-inl
	/* TZSymbolState.Destroy */ inline __fastcall virtual ~TZPostgreSQLSymbolState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPostgreSQLWordState;
class PASCALIMPLEMENTATION TZPostgreSQLWordState : public Zgenericsqltoken::TZGenericSQLWordState 
{
	typedef Zgenericsqltoken::TZGenericSQLWordState inherited;
	
public:
	__fastcall TZPostgreSQLWordState(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQLWordState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPostgreSQLTokenizer;
class PASCALIMPLEMENTATION TZPostgreSQLTokenizer : public Ztokenizer::TZTokenizer 
{
	typedef Ztokenizer::TZTokenizer inherited;
	
public:
	__fastcall TZPostgreSQLTokenizer(void);
public:
	#pragma option push -w-inl
	/* TZTokenizer.Destroy */ inline __fastcall virtual ~TZPostgreSQLTokenizer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zpostgresqltoken */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zpostgresqltoken;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPostgreSqlToken
