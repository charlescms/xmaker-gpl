// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainAdoDriver.pas' rev: 5.00

#ifndef ZPlainAdoDriverHPP
#define ZPlainAdoDriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainadodriver
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZAdoPlainDriver;
class PASCALIMPLEMENTATION TZAdoPlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZAdoPlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAdoPlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZPlainDriver;	/* Zplaindriver::IZPlainDriver */
	
public:
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZPlainDriver; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zplainadodriver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainadodriver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainAdoDriver
