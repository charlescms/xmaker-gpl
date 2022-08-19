// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcPostgreSql.pas' rev: 5.00

#ifndef ZDbcPostgreSqlHPP
#define ZDbcPostgreSqlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZPlainPostgreSqlDriver.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcpostgresql
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZPostgreSQLDriver;
class PASCALIMPLEMENTATION TZPostgreSQLDriver : public Zdbcconnection::TZAbstractDriver 
{
	typedef Zdbcconnection::TZAbstractDriver inherited;
	
private:
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPostgreSQL65PlainDriver;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPostgreSQL72PlainDriver;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPostgreSQL73PlainDriver;
	
protected:
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver __fastcall GetPlainDriver(AnsiString Url);
	
public:
	__fastcall TZPostgreSQLDriver(void);
	virtual Zdbcintfs::_di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info);
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols();
	virtual int __fastcall GetMajorVersion(void);
	virtual int __fastcall GetMinorVersion(void);
public:
	#pragma option push -w-inl
	/* TZAbstractDriver.Destroy */ inline __fastcall virtual ~TZPostgreSQLDriver(void) { }
	#pragma option pop
	
};


__interface IZPostgreSQLConnection;
typedef System::DelphiInterface<IZPostgreSQLConnection> _di_IZPostgreSQLConnection;
__interface INTERFACE_UUID("{8E62EA93-5A49-4F20-928A-0EA44ABCE5DB}") IZPostgreSQLConnection  : public IZConnection 
	
{
	
public:
	virtual bool __fastcall IsOidAsBlob(void) = 0 ;
	virtual AnsiString __fastcall GetTypeNameByOid(int Id) = 0 ;
	virtual Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver __fastcall GetPlainDriver(void) = 0 ;
	virtual void * __fastcall GetConnectionHandle(void) = 0 ;
	virtual int __fastcall GetServerMajorVersion(void) = 0 ;
	virtual int __fastcall GetServerMinorVersion(void) = 0 ;
};

class DELPHICLASS TZPostgreSQLConnection;
class PASCALIMPLEMENTATION TZPostgreSQLConnection : public Zdbcconnection::TZAbstractConnection 
{
	typedef Zdbcconnection::TZAbstractConnection inherited;
	
private:
	void *FHandle;
	bool FBeginRequired;
	Classes::TStrings* FTypeList;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPlainDriver;
	bool FOidAsBlob;
	AnsiString FClientCodePage;
	int FServerMajorVersion;
	int FServerMinorVersion;
	
protected:
	AnsiString __fastcall BuildConnectStr();
	void __fastcall StartTransactionSupport(void);
	void __fastcall LoadServerVersion(void);
	
public:
	__fastcall TZPostgreSQLConnection(AnsiString Url, Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver 
		PlainDriver, AnsiString HostName, int Port, AnsiString Database, AnsiString User, AnsiString Password
		, Classes::TStrings* Info);
	__fastcall virtual ~TZPostgreSQLConnection(void);
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateRegularStatement(Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreatePreparedStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall SetTransactionIsolation(Zdbcintfs::TZTransactIsolationLevel Level);
	bool __fastcall IsOidAsBlob(void);
	AnsiString __fastcall GetTypeNameByOid(int Id);
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver __fastcall GetPlainDriver();
	void * __fastcall GetConnectionHandle(void);
	int __fastcall GetServerMajorVersion(void);
	int __fastcall GetServerMinorVersion(void);
private:
	void *__IZPostgreSQLConnection;	/* Zdbcpostgresql::IZPostgreSQLConnection */
	
public:
	operator IZPostgreSQLConnection*(void) { return (IZPostgreSQLConnection*)&__IZPostgreSQLConnection; }
		
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::_di_IZDriver PostgreSQLDriver;

}	/* namespace Zdbcpostgresql */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcpostgresql;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcPostgreSql
