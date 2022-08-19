// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainLoader.pas' rev: 5.00

#ifndef ZPlainLoaderHPP
#define ZPlainLoaderHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainloader
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZNativeLibraryLoader;
class PASCALIMPLEMENTATION TZNativeLibraryLoader : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<AnsiString >  FLocations;
	unsigned FHandle;
	bool FLoaded;
	
protected:
	virtual bool __fastcall LoadNativeLibrary(void);
	virtual void __fastcall FreeNativeLibrary(void);
	void * __fastcall GetAddress(char * ProcName);
	
public:
	__fastcall TZNativeLibraryLoader(const AnsiString * Locations, const int Locations_Size);
	__fastcall virtual ~TZNativeLibraryLoader(void);
	virtual bool __fastcall Load(void);
	virtual void __fastcall LoadIfNeeded(void);
	__property unsigned Handle = {read=FHandle, write=FHandle, nodefault};
	__property bool Loaded = {read=FLoaded, write=FLoaded, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zplainloader */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainloader;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainLoader
