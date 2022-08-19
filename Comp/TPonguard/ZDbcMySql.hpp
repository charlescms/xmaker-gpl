// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcMySql.pas' rev: 5.00

#ifndef ZDbcMySqlHPP
#define ZDbcMySqlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZPlainMySqlDriver.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcmysql
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZMySQLDriver;
class PASCALIMPLEMENTATION TZMySQLDriver : public Zdbcconnection::TZAbstractDriver 
{
	typedef Zdbcconnection::TZAbstractDriver inherited;
	
private:
	Zplainmysqldriver::_di_IZMySQLPlainDriver FMySQL320PlainDriver;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FMySQL323PlainDriver;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FMySQL40PlainDriver;
	
protected:
	Zplainmysqldriver::_di_IZMySQLPlainDriver __fastcall GetPlainDriver(AnsiString Url);
	
public:
	__fastcall TZMySQLDriver(void);
	virtual Zdbcintfs::_di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info);
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols();
	virtual int __fastcall GetMajorVersion(void);
	virtual int __fastcall GetMinorVersion(void);
public:
	#pragma option push -w-inl
	/* TZAbstractDriver.Destroy */ inline __fastcall virtual ~TZMySQLDriver(void) { }
	#pragma option pop
	
};


__interface IZMySQLConnection;
typedef System::DelphiInterface<IZMySQLConnection> _di_IZMySQLConnection;
__interface INTERFACE_UUID("{68E33DD3-4CDC-4BFC-8A28-E9F2EE94E457}") IZMySQLConnection  : public IZConnection 
	
{
	
public:
	virtual Zplainmysqldriver::_di_IZMySQLPlainDriver __fastcall GetPlainDriver(void) = 0 ;
	virtual void * __fastcall GetConnectionHandle(void) = 0 ;
};

class DELPHICLASS TZMySQLConnection;
class PASCALIMPLEMENTATION TZMySQLConnection : public Zdbcconnection::TZAbstractConnection 
{
	typedef Zdbcconnection::TZAbstractConnection inherited;
	
private:
	AnsiString FCatalog;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FPlainDriver;
	void *FHandle;
	AnsiString FClientCodePage;
	
public:
	__fastcall TZMySQLConnection(AnsiString Url, Zplainmysqldriver::_di_IZMySQLPlainDriver PlainDriver, 
		AnsiString HostName, int Port, AnsiString Database, AnsiString User, AnsiString Password, Classes::TStrings* 
		Info);
	__fastcall virtual ~TZMySQLConnection(void);
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateRegularStatement(Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreatePreparedStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall SetCatalog(AnsiString Catalog);
	virtual AnsiString __fastcall GetCatalog();
	virtual void __fastcall SetTransactionIsolation(Zdbcintfs::TZTransactIsolationLevel Level);
	virtual void __fastcall SetAutoCommit(bool AutoCommit);
	Zplainmysqldriver::_di_IZMySQLPlainDriver __fastcall GetPlainDriver();
	void * __fastcall GetConnectionHandle(void);
private:
	void *__IZMySQLConnection;	/* Zdbcmysql::IZMySQLConnection */
	
public:
	operator IZMySQLConnection*(void) { return (IZMySQLConnection*)&__IZMySQLConnection; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::_di_IZDriver MySQLDriver;

}	/* namespace Zdbcmysql */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcmysql;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcMySql
