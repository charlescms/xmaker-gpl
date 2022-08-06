// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcMySqlStatement.pas' rev: 5.00

#ifndef ZDbcMySqlStatementHPP
#define ZDbcMySqlStatementHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainMySqlDriver.hpp>	// Pascal unit
#include <ZDbcStatement.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcmysqlstatement
{
//-- type declarations -------------------------------------------------------
__interface IZMySQLStatement;
typedef System::DelphiInterface<IZMySQLStatement> _di_IZMySQLStatement;
__interface INTERFACE_UUID("{A05DB91F-1E40-46C7-BF2E-25D74978AC83}") IZMySQLStatement  : public IZStatement 
	
{
	
public:
	virtual bool __fastcall IsUseResult(void) = 0 ;
};

class DELPHICLASS TZMySQLStatement;
class PASCALIMPLEMENTATION TZMySQLStatement : public Zdbcstatement::TZAbstractStatement 
{
	typedef Zdbcstatement::TZAbstractStatement inherited;
	
private:
	void *FHandle;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FPlainDriver;
	bool FUseResult;
	Zdbcintfs::_di_IZResultSet __fastcall CreateResultSet(AnsiString SQL);
	
public:
	__fastcall TZMySQLStatement(Zplainmysqldriver::_di_IZMySQLPlainDriver PlainDriver, Zdbcintfs::_di_IZConnection 
		Connection, Classes::TStrings* Info, void * Handle);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
	bool __fastcall IsUseResult(void);
public:
	#pragma option push -w-inl
	/* TZAbstractStatement.Destroy */ inline __fastcall virtual ~TZMySQLStatement(void) { }
	#pragma option pop
	
private:
	void *__IZMySQLStatement;	/* Zdbcmysqlstatement::IZMySQLStatement */
	
public:
	operator IZMySQLStatement*(void) { return (IZMySQLStatement*)&__IZMySQLStatement; }
	
};


class DELPHICLASS TZMySQLPreparedStatement;
class PASCALIMPLEMENTATION TZMySQLPreparedStatement : public Zdbcstatement::TZEmulatedPreparedStatement 
	
{
	typedef Zdbcstatement::TZEmulatedPreparedStatement inherited;
	
private:
	void *FHandle;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FPlainDriver;
	
protected:
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateExecStatement();
	AnsiString __fastcall GetEscapeString(AnsiString Value);
	virtual AnsiString __fastcall PrepareSQLParam(int ParamIndex);
	
public:
	__fastcall TZMySQLPreparedStatement(Zplainmysqldriver::_di_IZMySQLPlainDriver PlainDriver, Zdbcintfs::_di_IZConnection 
		Connection, AnsiString SQL, Classes::TStrings* Info, void * Handle);
public:
	#pragma option push -w-inl
	/* TZEmulatedPreparedStatement.Destroy */ inline __fastcall virtual ~TZMySQLPreparedStatement(void)
		 { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcmysqlstatement */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcmysqlstatement;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcMySqlStatement
