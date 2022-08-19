// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcStatement.pas' rev: 5.00

#ifndef ZDbcStatementHPP
#define ZDbcStatementHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcstatement
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<Zdbcintfs::TZSQLType >  TZSQLTypeArray;

class DELPHICLASS TZAbstractStatement;
class PASCALIMPLEMENTATION TZAbstractStatement : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FMaxFieldSize;
	int FMaxRows;
	bool FEscapeProcessing;
	int FQueryTimeout;
	int FLastUpdateCount;
	Zdbcintfs::_di_IZResultSet FLastResultSet;
	Zdbcintfs::TZFetchDirection FFetchDirection;
	int FFetchSize;
	Zdbcintfs::TZResultSetConcurrency FResultSetConcurrency;
	Zdbcintfs::TZResultSetType FResultSetType;
	Zdbcintfs::TZPostUpdatesMode FPostUpdates;
	Zdbcintfs::TZLocateUpdatesMode FLocateUpdates;
	AnsiString FCursorName;
	Classes::TStrings* FBatchQueries;
	Zdbcintfs::_di_IZConnection FConnection;
	Classes::TStrings* FInfo;
	void __fastcall SetLastResultSet(Zdbcintfs::_di_IZResultSet ResultSet);
	
protected:
	__fastcall TZAbstractStatement(Zdbcintfs::_di_IZConnection Connection, Classes::TStrings* Info);
	void __fastcall RaiseUnsupportedException(void);
	__property int MaxFieldSize = {read=FMaxFieldSize, write=FMaxFieldSize, nodefault};
	__property int MaxRows = {read=FMaxRows, write=FMaxRows, nodefault};
	__property bool EscapeProcessing = {read=FEscapeProcessing, write=FEscapeProcessing, nodefault};
	__property int QueryTimeout = {read=FQueryTimeout, write=FQueryTimeout, nodefault};
	__property int LastUpdateCount = {read=FLastUpdateCount, write=FLastUpdateCount, nodefault};
	__property Zdbcintfs::_di_IZResultSet LastResultSet = {read=FLastResultSet, write=SetLastResultSet}
		;
	__property Zdbcintfs::TZFetchDirection FetchDirection = {read=FFetchDirection, write=FFetchDirection
		, nodefault};
	__property int FetchSize = {read=FFetchSize, write=FFetchSize, nodefault};
	__property Zdbcintfs::TZResultSetConcurrency ResultSetConcurrency = {read=FResultSetConcurrency, write=
		FResultSetConcurrency, nodefault};
	__property Zdbcintfs::TZResultSetType ResultSetType = {read=FResultSetType, write=FResultSetType, nodefault
		};
	__property AnsiString CursorName = {read=FCursorName, write=FCursorName};
	__property Classes::TStrings* BatchQueries = {read=FBatchQueries};
	__property Zdbcintfs::_di_IZConnection Connection = {read=FConnection};
	__property Classes::TStrings* Info = {read=FInfo};
	
public:
	__fastcall virtual ~TZAbstractStatement(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual void __fastcall Close(void);
	virtual int __fastcall GetMaxFieldSize(void);
	virtual void __fastcall SetMaxFieldSize(int Value);
	virtual int __fastcall GetMaxRows(void);
	virtual void __fastcall SetMaxRows(int Value);
	virtual void __fastcall SetEscapeProcessing(bool Value);
	virtual int __fastcall GetQueryTimeout(void);
	virtual void __fastcall SetQueryTimeout(int Value);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall SetCursorName(AnsiString Value);
	virtual bool __fastcall Execute(AnsiString SQL);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetResultSet();
	virtual int __fastcall GetUpdateCount(void);
	virtual bool __fastcall GetMoreResults(void);
	virtual void __fastcall SetFetchDirection(Zdbcintfs::TZFetchDirection Value);
	virtual Zdbcintfs::TZFetchDirection __fastcall GetFetchDirection(void);
	virtual void __fastcall SetFetchSize(int Value);
	virtual int __fastcall GetFetchSize(void);
	virtual void __fastcall SetResultSetConcurrency(Zdbcintfs::TZResultSetConcurrency Value);
	virtual Zdbcintfs::TZResultSetConcurrency __fastcall GetResultSetConcurrency(void);
	virtual void __fastcall SetResultSetType(Zdbcintfs::TZResultSetType Value);
	virtual Zdbcintfs::TZResultSetType __fastcall GetResultSetType(void);
	void __fastcall SetPostUpdates(Zdbcintfs::TZPostUpdatesMode Value);
	Zdbcintfs::TZPostUpdatesMode __fastcall GetPostUpdates(void);
	void __fastcall SetLocateUpdates(Zdbcintfs::TZLocateUpdatesMode Value);
	Zdbcintfs::TZLocateUpdatesMode __fastcall GetLocateUpdates(void);
	virtual void __fastcall AddBatch(AnsiString SQL);
	virtual void __fastcall ClearBatch(void);
	virtual Zcompatibility::TIntegerDynArray __fastcall ExecuteBatch();
	Zdbcintfs::_di_IZConnection __fastcall GetConnection();
	Classes::TStrings* __fastcall GetParameters(void);
	virtual Zdbcintfs::EZSQLWarning* __fastcall GetWarnings(void);
	virtual void __fastcall ClearWarnings(void);
private:
	void *__IZStatement;	/* Zdbcintfs::IZStatement */
	
public:
	operator IZStatement*(void) { return (IZStatement*)&__IZStatement; }
	
};


class DELPHICLASS TZAbstractPreparedStatement;
class PASCALIMPLEMENTATION TZAbstractPreparedStatement : public TZAbstractStatement 
{
	typedef TZAbstractStatement inherited;
	
private:
	AnsiString FSQL;
	DynamicArray<Zvariant::TZVariant >  FInParamValues;
	DynamicArray<Zdbcintfs::TZSQLType >  FInParamTypes;
	int FInParamCount;
	
protected:
	__fastcall TZAbstractPreparedStatement(Zdbcintfs::_di_IZConnection Connection, AnsiString SQL, Classes::TStrings* 
		Info);
	virtual void __fastcall SetInParamCount(int NewParamCount);
	virtual void __fastcall SetInParam(int ParameterIndex, Zdbcintfs::TZSQLType SQLType, const Zvariant::TZVariant 
		&Value);
	__property AnsiString SQL = {read=FSQL, write=FSQL};
	__property Zvariant::TZVariantDynArray InParamValues = {read=FInParamValues, write=FInParamValues};
		
	__property TZSQLTypeArray InParamTypes = {read=FInParamTypes, write=FInParamTypes};
	__property int InParamCount = {read=FInParamCount, write=FInParamCount, nodefault};
	
public:
	__fastcall virtual ~TZAbstractPreparedStatement(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQueryPrepared();
	virtual int __fastcall ExecuteUpdatePrepared(void);
	virtual bool __fastcall ExecutePrepared(void);
	virtual void __fastcall SetNull(int ParameterIndex, Zdbcintfs::TZSQLType SQLType);
	virtual void __fastcall SetBoolean(int ParameterIndex, bool Value);
	virtual void __fastcall SetByte(int ParameterIndex, Shortint Value);
	virtual void __fastcall SetShort(int ParameterIndex, short Value);
	virtual void __fastcall SetInt(int ParameterIndex, int Value);
	virtual void __fastcall SetLong(int ParameterIndex, __int64 Value);
	virtual void __fastcall SetFloat(int ParameterIndex, float Value);
	virtual void __fastcall SetDouble(int ParameterIndex, double Value);
	virtual void __fastcall SetBigDecimal(int ParameterIndex, Extended Value);
	virtual void __fastcall SetPChar(int ParameterIndex, char * Value);
	virtual void __fastcall SetString(int ParameterIndex, AnsiString Value);
	virtual void __fastcall SetUnicodeString(int ParameterIndex, WideString Value);
	virtual void __fastcall SetBytes(int ParameterIndex, Zcompatibility::TByteDynArray Value);
	virtual void __fastcall SetDate(int ParameterIndex, System::TDateTime Value);
	virtual void __fastcall SetTime(int ParameterIndex, System::TDateTime Value);
	virtual void __fastcall SetTimestamp(int ParameterIndex, System::TDateTime Value);
	virtual void __fastcall SetAsciiStream(int ParameterIndex, Classes::TStream* Value);
	virtual void __fastcall SetUnicodeStream(int ParameterIndex, Classes::TStream* Value);
	virtual void __fastcall SetBinaryStream(int ParameterIndex, Classes::TStream* Value);
	virtual void __fastcall SetBlob(int ParameterIndex, Zdbcintfs::TZSQLType SQLType, Zdbcintfs::_di_IZBlob 
		Value);
	virtual void __fastcall SetValue(int ParameterIndex, const Zvariant::TZVariant &Value);
	virtual void __fastcall ClearParameters(void);
	virtual void __fastcall AddBatchPrepared(void);
	virtual Zdbcintfs::_di_IZResultSetMetadata __fastcall GetMetaData();
private:
	void *__IZPreparedStatement;	/* Zdbcintfs::IZPreparedStatement */
	
public:
	operator IZPreparedStatement*(void) { return (IZPreparedStatement*)&__IZPreparedStatement; }
	
};


class DELPHICLASS TZAbstractCallableStatement;
class PASCALIMPLEMENTATION TZAbstractCallableStatement : public TZAbstractPreparedStatement 
{
	typedef TZAbstractPreparedStatement inherited;
	
private:
	DynamicArray<Zvariant::TZVariant >  FOutParamValues;
	DynamicArray<Zdbcintfs::TZSQLType >  FOutParamTypes;
	int FOutParamCount;
	bool FLastWasNull;
	
protected:
	__fastcall TZAbstractCallableStatement(Zdbcintfs::_di_IZConnection Connection, AnsiString SQL, Classes::TStrings* 
		Info);
	virtual void __fastcall SetOutParamCount(int NewParamCount);
	virtual Zvariant::TZVariant __fastcall GetOutParam(int ParameterIndex);
	__property Zvariant::TZVariantDynArray OutParamValues = {read=FOutParamValues, write=FOutParamValues
		};
	__property TZSQLTypeArray OutParamTypes = {read=FOutParamTypes, write=FOutParamTypes};
	__property int OutParamCount = {read=FOutParamCount, write=FOutParamCount, nodefault};
	__property bool LastWasNull = {read=FLastWasNull, write=FLastWasNull, nodefault};
	
public:
	virtual void __fastcall ClearParameters(void);
	virtual void __fastcall RegisterOutParameter(int ParameterIndex, int SQLType);
	virtual bool __fastcall WasNull(void);
	virtual bool __fastcall IsNull(int ParameterIndex);
	virtual char * __fastcall GetPChar(int ParameterIndex);
	virtual AnsiString __fastcall GetString(int ParameterIndex);
	virtual WideString __fastcall GetUnicodeString(int ParameterIndex);
	virtual bool __fastcall GetBoolean(int ParameterIndex);
	virtual Shortint __fastcall GetByte(int ParameterIndex);
	virtual short __fastcall GetShort(int ParameterIndex);
	virtual int __fastcall GetInt(int ParameterIndex);
	virtual __int64 __fastcall GetLong(int ParameterIndex);
	virtual float __fastcall GetFloat(int ParameterIndex);
	virtual double __fastcall GetDouble(int ParameterIndex);
	virtual Extended __fastcall GetBigDecimal(int ParameterIndex);
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(int ParameterIndex);
	virtual System::TDateTime __fastcall GetDate(int ParameterIndex);
	virtual System::TDateTime __fastcall GetTime(int ParameterIndex);
	virtual System::TDateTime __fastcall GetTimestamp(int ParameterIndex);
	virtual Zvariant::TZVariant __fastcall GetValue(int ParameterIndex);
public:
	#pragma option push -w-inl
	/* TZAbstractPreparedStatement.Destroy */ inline __fastcall virtual ~TZAbstractCallableStatement(void
		) { }
	#pragma option pop
	
private:
	void *__IZCallableStatement;	/* Zdbcintfs::IZCallableStatement */
	
public:
	operator IZCallableStatement*(void) { return (IZCallableStatement*)&__IZCallableStatement; }
	
};


class DELPHICLASS TZEmulatedPreparedStatement;
class PASCALIMPLEMENTATION TZEmulatedPreparedStatement : public TZAbstractPreparedStatement 
{
	typedef TZAbstractPreparedStatement inherited;
	
private:
	Zdbcintfs::_di_IZStatement FExecStatement;
	Classes::TStrings* FCachedQuery;
	
protected:
	__property Zdbcintfs::_di_IZStatement ExecStatement = {read=FExecStatement, write=FExecStatement};
	__property Classes::TStrings* CachedQuery = {read=FCachedQuery, write=FCachedQuery};
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateExecStatement(void) = 0 ;
	virtual AnsiString __fastcall PrepareSQLParam(int ParamIndex) = 0 ;
	Zdbcintfs::_di_IZStatement __fastcall GetExecStatement();
	Classes::TStrings* __fastcall TokenizeSQLQuery(void);
	virtual AnsiString __fastcall PrepareSQLQuery();
	
public:
	__fastcall virtual ~TZEmulatedPreparedStatement(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL);
	virtual int __fastcall ExecuteUpdate(AnsiString SQL);
	virtual bool __fastcall Execute(AnsiString SQL);
	virtual Zdbcintfs::_di_IZResultSet __fastcall ExecuteQueryPrepared();
	virtual int __fastcall ExecuteUpdatePrepared(void);
	virtual bool __fastcall ExecutePrepared(void);
protected:
	#pragma option push -w-inl
	/* TZAbstractPreparedStatement.Create */ inline __fastcall TZEmulatedPreparedStatement(Zdbcintfs::_di_IZConnection 
		Connection, AnsiString SQL, Classes::TStrings* Info) : TZAbstractPreparedStatement(Connection, SQL
		, Info) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcstatement */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcstatement;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcStatement
