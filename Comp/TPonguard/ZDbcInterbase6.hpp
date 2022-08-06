// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcInterbase6.pas' rev: 5.00

#ifndef ZDbcInterbase6HPP
#define ZDbcInterbase6HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcGenericResolver.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZDbcInterbase6Utils.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZPlainInterbaseDriver.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZDbcUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcinterbase6
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZInterbase6Driver;
class PASCALIMPLEMENTATION TZInterbase6Driver : public Zdbcconnection::TZAbstractDriver 
{
	typedef Zdbcconnection::TZAbstractDriver inherited;
	
private:
	Zplaininterbasedriver::_di_IZInterbase6PlainDriver FInterbase6PlainDriver;
	Zplaininterbasedriver::_di_IZInterbase5PlainDriver FInterbase5PlainDriver;
	Zplaininterbasedriver::_di_IZFirebird10PlainDriver FFirebird10PlainDriver;
	Zplaininterbasedriver::_di_IZFirebird15PlainDriver FFirebird15PlainDriver;
	
protected:
	Zplaininterbasedriver::_di_IZInterbasePlainDriver __fastcall GetPlainDriver(AnsiString Url);
	
public:
	__fastcall TZInterbase6Driver(void);
	virtual Zdbcintfs::_di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info);
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols();
	virtual int __fastcall GetMajorVersion(void);
	virtual int __fastcall GetMinorVersion(void);
public:
	#pragma option push -w-inl
	/* TZAbstractDriver.Destroy */ inline __fastcall virtual ~TZInterbase6Driver(void) { }
	#pragma option pop
	
};


__interface IZInterbase6Connection;
typedef System::DelphiInterface<IZInterbase6Connection> _di_IZInterbase6Connection;
__interface INTERFACE_UUID("{E870E4FE-21EB-4725-B5D8-38B8A2B12D0B}") IZInterbase6Connection  : public IZConnection 
	
{
	
public:
	virtual Zplaininterbasedriver::PISC_DB_HANDLE __fastcall GetDBHandle(void) = 0 ;
	virtual Zplaininterbasedriver::PISC_TR_HANDLE __fastcall GetTrHandle(void) = 0 ;
	virtual Word __fastcall GetDialect(void) = 0 ;
	virtual Zplaininterbasedriver::_di_IZInterbasePlainDriver __fastcall GetPlainDriver(void) = 0 ;
	virtual void __fastcall CreateNewDatabase(AnsiString SQL) = 0 ;
};

class DELPHICLASS TZInterbase6Connection;
class PASCALIMPLEMENTATION TZInterbase6Connection : public Zdbcconnection::TZAbstractConnection 
{
	typedef Zdbcconnection::TZAbstractConnection inherited;
	
private:
	Word FDialect;
	void *FHandle;
	void *FTrHandle;
	int FStatusVector[21];
	Zplaininterbasedriver::_di_IZInterbasePlainDriver FPlainDriver;
	virtual void __fastcall StartTransaction(void);
	
public:
	__fastcall TZInterbase6Connection(AnsiString Url, Zplaininterbasedriver::_di_IZInterbasePlainDriver 
		PlainDriver, AnsiString HostName, int Port, AnsiString Database, AnsiString User, AnsiString Password
		, Classes::TStrings* Info);
	__fastcall virtual ~TZInterbase6Connection(void);
	Zplaininterbasedriver::PISC_DB_HANDLE __fastcall GetDBHandle(void);
	Zplaininterbasedriver::PISC_TR_HANDLE __fastcall GetTrHandle(void);
	Word __fastcall GetDialect(void);
	Zplaininterbasedriver::_di_IZInterbasePlainDriver __fastcall GetPlainDriver();
	void __fastcall CreateNewDatabase(AnsiString SQL);
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateRegularStatement(Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreatePreparedStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual Zdbcintfs::_di_IZCallableStatement __fastcall CreateCallableStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
private:
	void *__IZInterbase6Connection;	/* Zdbcinterbase6::IZInterbase6Connection */
	
public:
	operator IZInterbase6Connection*(void) { return (IZInterbase6Connection*)&__IZInterbase6Connection; }
		
	
};


class DELPHICLASS TZInterbase6CachedResolver;
class PASCALIMPLEMENTATION TZInterbase6CachedResolver : public Zdbcgenericresolver::TZGenericCachedResolver 
	
{
	typedef Zdbcgenericresolver::TZGenericCachedResolver inherited;
	
public:
	virtual AnsiString __fastcall FormCalculateStatement(Contnrs::TObjectList* Columns);
public:
	#pragma option push -w-inl
	/* TZGenericCachedResolver.Create */ inline __fastcall TZInterbase6CachedResolver(Zdbcintfs::_di_IZStatement 
		Statement, Zdbcintfs::_di_IZResultSetMetadata Metadata) : Zdbcgenericresolver::TZGenericCachedResolver(
		Statement, Metadata) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZGenericCachedResolver.Destroy */ inline __fastcall virtual ~TZInterbase6CachedResolver(void) { }
		
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::_di_IZDriver Interbase6Driver;

}	/* namespace Zdbcinterbase6 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcinterbase6;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcInterbase6
