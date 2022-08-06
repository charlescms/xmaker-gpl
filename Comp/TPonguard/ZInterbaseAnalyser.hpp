// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZInterbaseAnalyser.pas' rev: 5.00

#ifndef ZInterbaseAnalyserHPP
#define ZInterbaseAnalyserHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zinterbaseanalyser
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZInterbaseStatementAnalyser;
class PASCALIMPLEMENTATION TZInterbaseStatementAnalyser : public Zgenericsqlanalyser::TZGenericStatementAnalyser 
	
{
	typedef Zgenericsqlanalyser::TZGenericStatementAnalyser inherited;
	
public:
	#pragma option push -w-inl
	/* TZGenericStatementAnalyser.Create */ inline __fastcall TZInterbaseStatementAnalyser(void) : Zgenericsqlanalyser::TZGenericStatementAnalyser(
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZGenericStatementAnalyser.Destroy */ inline __fastcall virtual ~TZInterbaseStatementAnalyser(void
		) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zinterbaseanalyser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zinterbaseanalyser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZInterbaseAnalyser
