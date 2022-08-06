// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcAdoStatement.pas' rev: 5.00

#ifndef ZDbcAdoStatementHPP
#define ZDbcAdoStatementHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZPlainAdo.hpp>	// Pascal unit
#include <ZPlainAdoDriver.hpp>	// Pascal unit
#include <ZDbcAdo.hpp>	// Pascal unit
#include <ZDbcStatement.hpp>	// Pascal unit
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcadostatement
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZAdoStatement;
class PASCALIMPLEMENTATION TZAdoStatement : public Zdbcstatement::TZAbstractCallableStatement 
{
	typedef Zdbcstatement::TZAbstractCallableStatement inherited;
	
protected:
	Zplainado::_di_Recordset15 AdoRecordSet;
	Zplaindriver::_di_IZPlainDriver FPlainDriver;
	virtual bool __fastcall GetCurrentResult(int RC);
	bool __fastcall IsSelect(const AnsiString SQL);
	
public:
	__fastcall TZAdoStatement(Zplaindriver::_di_IZPlainDriver PlainDriver, Zdbcintfs::_di_IZConnection 
		Connection, AnsiString SQL, Classes::TStrings* Info);
	__fastcall virtual ~TZAdoStatement(void);
	virtual void __fastcall Close(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
	virtual bool __fastcall GetMoreResults(void);
};


class DELPHICLASS TZAdoPreparedStatement;
class PASCALIMPLEMENTATION TZAdoPreparedStatement : public TZAdoStatement 
{
	typedef TZAdoStatement inherited;
	
protected:
	Zplainado::_di__Command FAdoCommand;
	virtual void __fastcall SetInParamCount(int NewParamCount);
	virtual void __fastcall SetInParam(int ParameterIndex, Zdbcintfs::TZSQLType SQLType, const Zvariant::TZVariant 
		&Value);
	
public:
	__fastcall TZAdoPreparedStatement(Zplaindriver::_di_IZPlainDriver PlainDriver, Zdbcintfs::_di_IZConnection 
		Connection, AnsiString SQL, Classes::TStrings* Info);
	__fastcall virtual ~TZAdoPreparedStatement(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall ClearParameters(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQueryPrepared();
	virtual int __fastcall ExecuteUpdatePrepared(void);
	virtual bool __fastcall ExecutePrepared(void);
};


class DELPHICLASS TZAdoCallableStatement;
class PASCALIMPLEMENTATION TZAdoCallableStatement : public TZAdoPreparedStatement 
{
	typedef TZAdoPreparedStatement inherited;
	
protected:
	DynamicArray<int >  FOutParamIndexes;
	virtual Zvariant::TZVariant __fastcall GetOutParam(int ParameterIndex);
	
public:
	__fastcall TZAdoCallableStatement(Zplaindriver::_di_IZPlainDriver PlainDriver, Zdbcintfs::_di_IZConnection 
		Connection, AnsiString SQL, Classes::TStrings* Info);
public:
	#pragma option push -w-inl
	/* TZAdoPreparedStatement.Destroy */ inline __fastcall virtual ~TZAdoCallableStatement(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcadostatement */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcadostatement;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcAdoStatement
