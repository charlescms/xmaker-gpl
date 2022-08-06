// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainDriver.pas' rev: 5.00

#ifndef ZPlainDriverHPP
#define ZPlainDriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplaindriver
{
//-- type declarations -------------------------------------------------------
__interface IZPlainDriver;
typedef System::DelphiInterface<IZPlainDriver> _di_IZPlainDriver;
__interface INTERFACE_UUID("{2A0CC600-B3C4-43AF-92F5-C22A3BB1BB7D}") IZPlainDriver  : public IUnknown 
	
{
	
public:
	virtual AnsiString __fastcall GetProtocol(void) = 0 ;
	virtual AnsiString __fastcall GetDescription(void) = 0 ;
	virtual void __fastcall Initialize(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zplaindriver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaindriver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainDriver
