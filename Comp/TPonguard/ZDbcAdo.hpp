// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcAdo.pas' rev: 5.00

#ifndef ZDbcAdoHPP
#define ZDbcAdoHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainAdo.hpp>	// Pascal unit
#include <ZPlainAdoDriver.hpp>	// Pascal unit
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcado
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZAdoDriver;
class PASCALIMPLEMENTATION TZAdoDriver : public Zdbcconnection::TZAbstractDriver 
{
	typedef Zdbcconnection::TZAbstractDriver inherited;
	
private:
	Zplaindriver::_di_IZPlainDriver FAdoPlainDriver;
	
public:
	__fastcall TZAdoDriver(void);
	virtual Zdbcintfs::_di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info);
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols();
	virtual int __fastcall GetMajorVersion(void);
	virtual int __fastcall GetMinorVersion(void);
public:
	#pragma option push -w-inl
	/* TZAbstractDriver.Destroy */ inline __fastcall virtual ~TZAdoDriver(void) { }
	#pragma option pop
	
};


__interface IZAdoConnection;
typedef System::DelphiInterface<IZAdoConnection> _di_IZAdoConnection;
__interface INTERFACE_UUID("{50D1AF76-0174-41CD-B90B-4FB770EFB14F}") IZAdoConnection  : public IZConnection 
	
{
	
public:
	virtual Zplainado::_di_Connection15 __fastcall GetAdoConnection(void) = 0 ;
	virtual void __fastcall InternalExecuteStatement(AnsiString SQL) = 0 ;
	virtual void __fastcall CheckAdoError(void) = 0 ;
};

class DELPHICLASS TZAdoConnection;
class PASCALIMPLEMENTATION TZAdoConnection : public Zdbcconnection::TZAbstractConnection 
{
	typedef Zdbcconnection::TZAbstractConnection inherited;
	
private:
	void __fastcall ReStartTransactionSupport(void);
	
protected:
	Zplainado::_di_Connection15 FAdoConnection;
	Zplaindriver::_di_IZPlainDriver FPlainDriver;
	virtual Zplainado::_di_Connection15 __fastcall GetAdoConnection();
	virtual void __fastcall InternalExecuteStatement(AnsiString SQL);
	virtual void __fastcall CheckAdoError(void);
	virtual void __fastcall StartTransaction(void);
	
public:
	__fastcall TZAdoConnection(AnsiString Url, Zplaindriver::_di_IZPlainDriver PlainDriver, AnsiString 
		HostName, int Port, AnsiString Database, AnsiString User, AnsiString Password, Classes::TStrings* 
		Info);
	__fastcall virtual ~TZAdoConnection(void);
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
	void *__IZAdoConnection;	/* Zdbcado::IZAdoConnection */
	
public:
	operator IZAdoConnection*(void) { return (IZAdoConnection*)&__IZAdoConnection; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::_di_IZDriver AdoDriver;

}	/* namespace Zdbcado */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcado;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcAdo
