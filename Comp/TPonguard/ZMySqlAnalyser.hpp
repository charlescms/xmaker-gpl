// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZMySqlAnalyser.pas' rev: 5.00

#ifndef ZMySqlAnalyserHPP
#define ZMySqlAnalyserHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zmysqlanalyser
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZMySQLStatementAnalyser;
class PASCALIMPLEMENTATION TZMySQLStatementAnalyser : public Zgenericsqlanalyser::TZGenericStatementAnalyser 
	
{
	typedef Zgenericsqlanalyser::TZGenericStatementAnalyser inherited;
	
public:
	__fastcall TZMySQLStatementAnalyser(void);
public:
	#pragma option push -w-inl
	/* TZGenericStatementAnalyser.Destroy */ inline __fastcall virtual ~TZMySQLStatementAnalyser(void) { }
		
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zmysqlanalyser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zmysqlanalyser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZMySqlAnalyser
