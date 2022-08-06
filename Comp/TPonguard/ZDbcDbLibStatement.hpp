// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcDbLibStatement.pas' rev: 5.00

#ifndef ZDbcDbLibStatementHPP
#define ZDbcDbLibStatementHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDbLibDriver.hpp>	// Pascal unit
#include <ZDbcDbLib.hpp>	// Pascal unit
#include <ZDbcStatement.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcdblibstatement
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZDBLibStatement;
class PASCALIMPLEMENTATION TZDBLibStatement : public Zdbcstatement::TZAbstractStatement 
{
	typedef Zdbcstatement::TZAbstractStatement inherited;
	
protected:
	AnsiString FSQL;
	Zdbcdblib::_di_IZDBLibConnection FDBLibConnection;
	Zplaindblibdriver::_di_IZDBLibPlainDriver FPlainDriver;
	void *FHandle;
	Zclasses::_di_IZCollection FResults;
	virtual void __fastcall InternalExecuteStatement(AnsiString SQL);
	virtual void __fastcall FetchResults(void);
	
public:
	__fastcall TZDBLibStatement(Zdbcintfs::_di_IZConnection Connection, Classes::TStrings* Info);
	__fastcall virtual ~TZDBLibStatement(void);
	virtual bool __fastcall GetMoreResults(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
};


class DELPHICLASS TZDBLibPreparedStatementEmulated;
class PASCALIMPLEMENTATION TZDBLibPreparedStatementEmulated : public Zdbcstatement::TZEmulatedPreparedStatement 
	
{
	typedef Zdbcstatement::TZEmulatedPreparedStatement inherited;
	
protected:
	AnsiString __fastcall GetEscapeString(AnsiString Value);
	virtual AnsiString __fastcall PrepareSQLParam(int ParamIndex);
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateExecStatement();
	
public:
	__fastcall TZDBLibPreparedStatementEmulated(Zdbcintfs::_di_IZConnection Connection, AnsiString SQL, 
		Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZResultSetMetadata __fastcall GetMetaData();
public:
	#pragma option push -w-inl
	/* TZEmulatedPreparedStatement.Destroy */ inline __fastcall virtual ~TZDBLibPreparedStatementEmulated
		(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZDBLibCallableStatement;
class PASCALIMPLEMENTATION TZDBLibCallableStatement : public Zdbcstatement::TZAbstractCallableStatement 
	
{
	typedef Zdbcstatement::TZAbstractCallableStatement inherited;
	
private:
	AnsiString FSQL;
	Zdbcdblib::_di_IZDBLibConnection FDBLibConnection;
	Zplaindblibdriver::_di_IZDBLibPlainDriver FPlainDriver;
	void *FHandle;
	Zclasses::_di_IZCollection FResults;
	int FLastRowsAffected;
	virtual void __fastcall FetchResults(void);
	virtual void __fastcall FetchRowCount(void);
	
public:
	__fastcall TZDBLibCallableStatement(Zdbcintfs::_di_IZConnection Connection, AnsiString ProcName, Classes::TStrings* 
		Info);
	virtual void __fastcall RegisterOutParameter(int ParameterIndex, int SqlType);
	virtual bool __fastcall GetMoreResults(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQueryPrepared();
	virtual int __fastcall ExecuteUpdatePrepared(void);
	virtual bool __fastcall ExecutePrepared(void);
public:
	#pragma option push -w-inl
	/* TZAbstractPreparedStatement.Destroy */ inline __fastcall virtual ~TZDBLibCallableStatement(void)
		 { }
	#pragma option pop
	
};


__interface IZUpdateCount;
typedef System::DelphiInterface<IZUpdateCount> _di_IZUpdateCount;
__interface INTERFACE_UUID("{03219BB4-E07F-4A50-80CD-291FEA629697}") IZUpdateCount  : public IUnknown 
	
{
	
public:
	virtual void __fastcall SetCount(int Value) = 0 ;
	virtual int __fastcall GetCount(void) = 0 ;
};

class DELPHICLASS TZUpdateCount;
class PASCALIMPLEMENTATION TZUpdateCount : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FCount;
	
public:
	__fastcall TZUpdateCount(int ACount);
	virtual void __fastcall SetCount(int Value);
	virtual int __fastcall GetCount(void);
	__property int Count = {read=GetCount, write=SetCount, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZUpdateCount(void) { }
	#pragma option pop
	
private:
	void *__IZUpdateCount;	/* Zdbcdblibstatement::IZUpdateCount */
	
public:
	operator IZUpdateCount*(void) { return (IZUpdateCount*)&__IZUpdateCount; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcdblibstatement */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcdblibstatement;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcDbLibStatement
