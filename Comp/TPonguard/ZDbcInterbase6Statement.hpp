// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcInterbase6Statement.pas' rev: 5.00

#ifndef ZDbcInterbase6StatementHPP
#define ZDbcInterbase6StatementHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZMessages.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainInterbaseDriver.hpp>	// Pascal unit
#include <ZDbcInterbase6ResultSet.hpp>	// Pascal unit
#include <ZDbcInterbase6Utils.hpp>	// Pascal unit
#include <ZPlainInterbase6.hpp>	// Pascal unit
#include <ZDbcInterbase6.hpp>	// Pascal unit
#include <ZDbcStatement.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcinterbase6statement
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZInterbase6Statement;
class PASCALIMPLEMENTATION TZInterbase6Statement : public Zdbcstatement::TZAbstractStatement 
{
	typedef Zdbcstatement::TZAbstractStatement inherited;
	
private:
	bool FCachedBlob;
	int FStatusVector[21];
	Zdbcinterbase6::_di_IZInterbase6Connection FIBConnection;
	
protected:
	void __fastcall CheckInterbase6Error(AnsiString Sql);
	
public:
	__fastcall TZInterbase6Statement(Zdbcintfs::_di_IZConnection Connection, Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
public:
	#pragma option push -w-inl
	/* TZAbstractStatement.Destroy */ inline __fastcall virtual ~TZInterbase6Statement(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbase6PreparedStatement;
class PASCALIMPLEMENTATION TZInterbase6PreparedStatement : public Zdbcstatement::TZAbstractPreparedStatement 
	
{
	typedef Zdbcstatement::TZAbstractPreparedStatement inherited;
	
private:
	bool FCachedBlob;
	AnsiString FCursorName;
	Zdbcinterbase6utils::_di_IZParamsSQLDA FParamSQLData;
	int FStatusVector[21];
	Zdbcinterbase6::_di_IZInterbase6Connection FIBConnection;
	
protected:
	void __fastcall CheckInterbase6Error(AnsiString Sql);
	
public:
	__fastcall TZInterbase6PreparedStatement(Zdbcintfs::_di_IZConnection Connection, AnsiString SQL, Classes::TStrings* 
		Info);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQueryPrepared();
	virtual int __fastcall ExecuteUpdatePrepared(void);
	virtual bool __fastcall ExecutePrepared(void);
public:
	#pragma option push -w-inl
	/* TZAbstractPreparedStatement.Destroy */ inline __fastcall virtual ~TZInterbase6PreparedStatement(
		void) { }
	#pragma option pop
	
};


class DELPHICLASS TZInterbase6CallableStatement;
class PASCALIMPLEMENTATION TZInterbase6CallableStatement : public Zdbcstatement::TZAbstractCallableStatement 
	
{
	typedef Zdbcstatement::TZAbstractCallableStatement inherited;
	
private:
	bool FCachedBlob;
	AnsiString FCursorName;
	Zdbcinterbase6utils::_di_IZParamsSQLDA FParamSQLData;
	int FStatusVector[21];
	Zdbcinterbase6::_di_IZInterbase6Connection FIBConnection;
	
protected:
	void __fastcall CheckInterbase6Error(AnsiString Sql);
	void __fastcall FetchOutParams(Zdbcinterbase6utils::_di_IZResultSQLDA Value);
	AnsiString __fastcall GetProcedureSql(bool SelectProc);
	
public:
	__fastcall TZInterbase6CallableStatement(Zdbcintfs::_di_IZConnection Connection, AnsiString SQL, Classes::TStrings* 
		Info);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQueryPrepared();
	virtual int __fastcall ExecuteUpdatePrepared(void);
	virtual bool __fastcall ExecutePrepared(void);
public:
	#pragma option push -w-inl
	/* TZAbstractPreparedStatement.Destroy */ inline __fastcall virtual ~TZInterbase6CallableStatement(
		void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcinterbase6statement */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcinterbase6statement;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcInterbase6Statement
