// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcDbLib.pas' rev: 5.00

#ifndef ZDbcDbLibHPP
#define ZDbcDbLibHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDbLibDriver.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcdblib
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZDBLibDriver;
class PASCALIMPLEMENTATION TZDBLibDriver : public Zdbcconnection::TZAbstractDriver 
{
	typedef Zdbcconnection::TZAbstractDriver inherited;
	
private:
	Zplaindblibdriver::_di_IZDBLibPlainDriver FMSSqlPlainDriver;
	Zplaindblibdriver::_di_IZDBLibPlainDriver FSybasePlainDriver;
	
public:
	__fastcall TZDBLibDriver(void);
	virtual Zdbcintfs::_di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info);
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols();
	virtual int __fastcall GetMajorVersion(void);
	virtual int __fastcall GetMinorVersion(void);
public:
	#pragma option push -w-inl
	/* TZAbstractDriver.Destroy */ inline __fastcall virtual ~TZDBLibDriver(void) { }
	#pragma option pop
	
};


__interface IZDBLibConnection;
typedef System::DelphiInterface<IZDBLibConnection> _di_IZDBLibConnection;
__interface INTERFACE_UUID("{6B0662A2-FF2A-4415-B6B0-AAC047EA0671}") IZDBLibConnection  : public IZConnection 
	
{
	
public:
	virtual Zplaindblibdriver::_di_IZDBLibPlainDriver __fastcall GetPlainDriver(void) = 0 ;
	virtual void * __fastcall GetConnectionHandle(void) = 0 ;
	virtual void __fastcall InternalExecuteStatement(AnsiString SQL) = 0 ;
	virtual void __fastcall CheckDBLibError(Zdbclogging::TZLoggingCategory LogCategory, AnsiString LogMessage
		) = 0 ;
};

class DELPHICLASS TZDBLibConnection;
class PASCALIMPLEMENTATION TZDBLibConnection : public Zdbcconnection::TZAbstractConnection 
{
	typedef Zdbcconnection::TZAbstractConnection inherited;
	
private:
	void __fastcall ReStartTransactionSupport(void);
	void __fastcall InternalSetTransactionIsolation(Zdbcintfs::TZTransactIsolationLevel Level);
	
protected:
	Zplaindblibdriver::_di_IZDBLibPlainDriver FPlainDriver;
	void *FHandle;
	virtual void __fastcall InternalExecuteStatement(AnsiString SQL);
	virtual void __fastcall InternalLogin(void);
	Zplaindblibdriver::_di_IZDBLibPlainDriver __fastcall GetPlainDriver();
	void * __fastcall GetConnectionHandle(void);
	virtual void __fastcall CheckDBLibError(Zdbclogging::TZLoggingCategory LogCategory, AnsiString LogMessage
		);
	virtual void __fastcall StartTransaction(void);
	
public:
	__fastcall TZDBLibConnection(AnsiString Url, Zplaindblibdriver::_di_IZDBLibPlainDriver PlainDriver, 
		AnsiString HostName, int Port, AnsiString Database, AnsiString User, AnsiString Password, Classes::TStrings* 
		Info);
	__fastcall virtual ~TZDBLibConnection(void);
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateRegularStatement(Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreatePreparedStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual Zdbcintfs::_di_IZCallableStatement __fastcall CreateCallableStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual AnsiString __fastcall NativeSQL(AnsiString SQL);
	virtual void __fastcall SetAutoCommit(bool AutoCommit);
	virtual void __fastcall SetTransactionIsolation(Zdbcintfs::TZTransactIsolationLevel Level);
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall SetReadOnly(bool ReadOnly);
	virtual void __fastcall SetCatalog(AnsiString Catalog);
	virtual AnsiString __fastcall GetCatalog();
	virtual Zdbcintfs::EZSQLWarning* __fastcall GetWarnings(void);
	virtual void __fastcall ClearWarnings(void);
private:
	void *__IZDBLibConnection;	/* Zdbcdblib::IZDBLibConnection */
	
public:
	operator IZDBLibConnection*(void) { return (IZDBLibConnection*)&__IZDBLibConnection; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::_di_IZDriver DBLibDriver;

}	/* namespace Zdbcdblib */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcdblib;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcDbLib
