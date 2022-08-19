// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPostgreSqlAnalyser.pas' rev: 5.00

#ifndef ZPostgreSqlAnalyserHPP
#define ZPostgreSqlAnalyserHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zpostgresqlanalyser
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZPostgreSQLStatementAnalyser;
class PASCALIMPLEMENTATION TZPostgreSQLStatementAnalyser : public Zgenericsqlanalyser::TZGenericStatementAnalyser 
	
{
	typedef Zgenericsqlanalyser::TZGenericStatementAnalyser inherited;
	
public:
	__fastcall TZPostgreSQLStatementAnalyser(void);
public:
	#pragma option push -w-inl
	/* TZGenericStatementAnalyser.Destroy */ inline __fastcall virtual ~TZPostgreSQLStatementAnalyser(void
		) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zpostgresqlanalyser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zpostgresqlanalyser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPostgreSqlAnalyser
