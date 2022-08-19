// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcPostgreSqlStatement.pas' rev: 5.00

#ifndef ZDbcPostgreSqlStatementHPP
#define ZDbcPostgreSqlStatementHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcGenericResolver.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainPostgreSqlDriver.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZDbcStatement.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcpostgresqlstatement
{
//-- type declarations -------------------------------------------------------
__interface IZPostgreSQLStatement;
typedef System::DelphiInterface<IZPostgreSQLStatement> _di_IZPostgreSQLStatement;
__interface INTERFACE_UUID("{E4FAFD96-97CC-4247-8ECC-6E0A168FAFE6}") IZPostgreSQLStatement  : public IZStatement 
	
{
	
public:
	virtual bool __fastcall IsOidAsBlob(void) = 0 ;
};

class DELPHICLASS TZPostgreSQLStatement;
class PASCALIMPLEMENTATION TZPostgreSQLStatement : public Zdbcstatement::TZAbstractStatement 
{
	typedef Zdbcstatement::TZAbstractStatement inherited;
	
private:
	void *FHandle;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPlainDriver;
	bool FOidAsBlob;
	
protected:
	Zdbcintfs::_di_IZResultSet __fastcall CreateResultSet(AnsiString SQL, void * QueryHandle);
	
public:
	__fastcall TZPostgreSQLStatement(Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver PlainDriver, Zdbcintfs::_di_IZConnection 
		Connection, Classes::TStrings* Info, void * Handle);
	__fastcall virtual ~TZPostgreSQLStatement(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
	bool __fastcall IsOidAsBlob(void);
private:
	void *__IZPostgreSQLStatement;	/* Zdbcpostgresqlstatement::IZPostgreSQLStatement */
	
public:
	operator IZPostgreSQLStatement*(void) { return (IZPostgreSQLStatement*)&__IZPostgreSQLStatement; }
	
};


class DELPHICLASS TZPostgreSQLPreparedStatement;
class PASCALIMPLEMENTATION TZPostgreSQLPreparedStatement : public Zdbcstatement::TZEmulatedPreparedStatement 
	
{
	typedef Zdbcstatement::TZEmulatedPreparedStatement inherited;
	
private:
	void *FHandle;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPlainDriver;
	
protected:
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateExecStatement();
	virtual AnsiString __fastcall PrepareSQLParam(int ParamIndex);
	
public:
	__fastcall TZPostgreSQLPreparedStatement(Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver PlainDriver
		, Zdbcintfs::_di_IZConnection Connection, AnsiString SQL, Classes::TStrings* Info, void * Handle);
		
public:
	#pragma option push -w-inl
	/* TZEmulatedPreparedStatement.Destroy */ inline __fastcall virtual ~TZPostgreSQLPreparedStatement(
		void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPostgreSQLCachedResolver;
class PASCALIMPLEMENTATION TZPostgreSQLCachedResolver : public Zdbcgenericresolver::TZGenericCachedResolver 
	
{
	typedef Zdbcgenericresolver::TZGenericCachedResolver inherited;
	
protected:
	virtual bool __fastcall CheckKeyColumn(int ColumnIndex);
public:
	#pragma option push -w-inl
	/* TZGenericCachedResolver.Create */ inline __fastcall TZPostgreSQLCachedResolver(Zdbcintfs::_di_IZStatement 
		Statement, Zdbcintfs::_di_IZResultSetMetadata Metadata) : Zdbcgenericresolver::TZGenericCachedResolver(
		Statement, Metadata) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZGenericCachedResolver.Destroy */ inline __fastcall virtual ~TZPostgreSQLCachedResolver(void) { }
		
	#pragma option pop
	
private:
	void *__IZCachedResolver;	/* Zdbccachedresultset::IZCachedResolver */
	
public:
	operator IZCachedResolver*(void) { return (IZCachedResolver*)&__IZCachedResolver; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcpostgresqlstatement */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcpostgresqlstatement;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcPostgreSqlStatement
