// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSybaseAnalyser.pas' rev: 5.00

#ifndef ZSybaseAnalyserHPP
#define ZSybaseAnalyserHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsybaseanalyser
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZSybaseStatementAnalyser;
class PASCALIMPLEMENTATION TZSybaseStatementAnalyser : public Zgenericsqlanalyser::TZGenericStatementAnalyser 
	
{
	typedef Zgenericsqlanalyser::TZGenericStatementAnalyser inherited;
	
public:
	#pragma option push -w-inl
	/* TZGenericStatementAnalyser.Create */ inline __fastcall TZSybaseStatementAnalyser(void) : Zgenericsqlanalyser::TZGenericStatementAnalyser(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZGenericStatementAnalyser.Destroy */ inline __fastcall virtual ~TZSybaseStatementAnalyser(void)
		 { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsybaseanalyser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsybaseanalyser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSybaseAnalyser
