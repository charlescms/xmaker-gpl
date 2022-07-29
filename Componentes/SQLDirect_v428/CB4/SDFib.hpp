// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDFib.pas' rev: 4.00

#ifndef SDFibHPP
#define SDFibHPP

#pragma delphiheader begin
#pragma option push -w-
#include <SDInt.hpp>	// Pascal unit
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdfib
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFibFunctions;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TFibFunctions : public Sdint::TIntFunctions 
{
	typedef Sdint::TIntFunctions inherited;
	
public:
	virtual void __fastcall SetApiCalls(unsigned ASqlLibModule);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TFibFunctions(void) : Sdint::TIntFunctions() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFibFunctions(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS ESDFibError;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION ESDFibError : public Sdint::ESDIntError 
{
	typedef Sdint::ESDIntError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDFibError(int AErrorCode, int ANativeError, const AnsiString 
		Msg, int AErrorPos) : Sdint::ESDIntError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDFibError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdint::ESDIntError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDFibError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdint::ESDIntError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDFibError(int Ident, Extended Dummy) : Sdint::ESDIntError(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDFibError(int Ident, const System::TVarRec * Args, 
		const int Args_Size) : Sdint::ESDIntError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDFibError(const AnsiString Msg, int AHelpContext) : 
		Sdint::ESDIntError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDFibError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdint::ESDIntError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDFibError(int Ident, int AHelpContext) : Sdint::ESDIntError(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDFibError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sdint::ESDIntError(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDFibError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TIFibDatabase;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIFibDatabase : public Sdint::TICustomIntDatabase 
{
	typedef Sdint::TICustomIntDatabase inherited;
	
protected:
	virtual void __fastcall AllocHandle(bool DBHandles);
	virtual void __fastcall FreeSqlLib(void);
	virtual void __fastcall LoadSqlLib(void);
	virtual TMetaClass* __fastcall GetErrorClass(void);
	
public:
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual int __fastcall GetClientVersion(void);
public:
	#pragma option push -w-inl
	/* TICustomIntDatabase.Create */ inline __fastcall virtual TIFibDatabase(Classes::TStrings* ADbParams
		) : Sdint::TICustomIntDatabase(ADbParams) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomIntDatabase.Destroy */ inline __fastcall virtual ~TIFibDatabase(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TIFibCommand;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIFibCommand : public Sdint::TICustomIntCommand 
{
	typedef Sdint::TICustomIntCommand inherited;
	
public:
	#pragma option push -w-inl
	/* TICustomIntCommand.Create */ inline __fastcall virtual TIFibCommand(Sdcommon::TISqlDatabase* ASqlDatabase
		) : Sdint::TICustomIntCommand(ASqlDatabase) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomIntCommand.Destroy */ inline __fastcall virtual ~TIFibCommand(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define DefSqlApiDLL "FBCLIENT.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE TFibFunctions* FibCalls;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdfib */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdfib;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDFib
