// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcMySqlResultSet.pas' rev: 5.00

#ifndef ZDbcMySqlResultSetHPP
#define ZDbcMySqlResultSetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ComObj.hpp>	// Pascal unit
#include <ZDbcGenericResolver.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainMySqlDriver.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcmysqlresultset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZMySQLResultSetMetadata;
class PASCALIMPLEMENTATION TZMySQLResultSetMetadata : public Zdbcresultsetmetadata::TZAbstractResultSetMetadata 
	
{
	typedef Zdbcresultsetmetadata::TZAbstractResultSetMetadata inherited;
	
public:
	virtual Zdbcintfs::TZSQLType __fastcall GetColumnType(int Column);
	virtual Zdbcintfs::TZColumnNullableType __fastcall IsNullable(int Column);
public:
	#pragma option push -w-inl
	/* TZAbstractResultSetMetadata.Create */ inline __fastcall TZMySQLResultSetMetadata(Zdbcintfs::_di_IZDatabaseMetadata 
		Metadata, AnsiString SQL, Zdbcresultset::TZAbstractResultSet* ParentResultSet) : Zdbcresultsetmetadata::TZAbstractResultSetMetadata(
		Metadata, SQL, ParentResultSet) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractResultSetMetadata.Destroy */ inline __fastcall virtual ~TZMySQLResultSetMetadata(void)
		 { }
	#pragma option pop
	
};


class DELPHICLASS TZMySQLResultSet;
class PASCALIMPLEMENTATION TZMySQLResultSet : public Zdbcresultset::TZAbstractResultSet 
{
	typedef Zdbcresultset::TZAbstractResultSet inherited;
	
private:
	void *FHandle;
	void *FQueryHandle;
	void *FRowHandle;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FPlainDriver;
	bool FUseResult;
	
protected:
	virtual void __fastcall Open(void);
	
public:
	__fastcall TZMySQLResultSet(Zplainmysqldriver::_di_IZMySQLPlainDriver PlainDriver, Zdbcintfs::_di_IZStatement 
		Statement, AnsiString SQL, void * Handle, bool UseResult);
	__fastcall virtual ~TZMySQLResultSet(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall IsNull(int ColumnIndex);
	virtual char * __fastcall GetPChar(int ColumnIndex);
	virtual AnsiString __fastcall GetString(int ColumnIndex);
	virtual bool __fastcall GetBoolean(int ColumnIndex);
	virtual Shortint __fastcall GetByte(int ColumnIndex);
	virtual short __fastcall GetShort(int ColumnIndex);
	virtual int __fastcall GetInt(int ColumnIndex);
	virtual __int64 __fastcall GetLong(int ColumnIndex);
	virtual float __fastcall GetFloat(int ColumnIndex);
	virtual double __fastcall GetDouble(int ColumnIndex);
	virtual Extended __fastcall GetBigDecimal(int ColumnIndex);
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(int ColumnIndex);
	virtual System::TDateTime __fastcall GetDate(int ColumnIndex);
	virtual System::TDateTime __fastcall GetTime(int ColumnIndex);
	virtual System::TDateTime __fastcall GetTimestamp(int ColumnIndex);
	virtual Classes::TStream* __fastcall GetAsciiStream(int ColumnIndex);
	virtual Classes::TStream* __fastcall GetUnicodeStream(int ColumnIndex);
	virtual Classes::TStream* __fastcall GetBinaryStream(int ColumnIndex);
	virtual Zdbcintfs::_di_IZBlob __fastcall GetBlob(int ColumnIndex);
	virtual bool __fastcall MoveAbsolute(int Row);
	virtual bool __fastcall Next(void);
};


class DELPHICLASS TZMySQLCachedResolver;
class PASCALIMPLEMENTATION TZMySQLCachedResolver : public Zdbcgenericresolver::TZGenericCachedResolver 
	
{
	typedef Zdbcgenericresolver::TZGenericCachedResolver inherited;
	
private:
	void *FHandle;
	Zplainmysqldriver::_di_IZMySQLPlainDriver FPlainDriver;
	int FAutoColumnIndex;
	
public:
	__fastcall TZMySQLCachedResolver(Zplainmysqldriver::_di_IZMySQLPlainDriver PlainDriver, void * Handle
		, Zdbcintfs::_di_IZStatement Statement, Zdbcintfs::_di_IZResultSetMetadata Metadata);
	virtual void __fastcall PostUpdates(Zdbccachedresultset::_di_IZCachedResultSet Sender, Zdbccache::TZRowUpdateType 
		UpdateType, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor);
public:
		
	#pragma option push -w-inl
	/* TZGenericCachedResolver.Destroy */ inline __fastcall virtual ~TZMySQLCachedResolver(void) { }
	#pragma option pop
	
private:
	void *__IZCachedResolver;	/* Zdbccachedresultset::IZCachedResolver */
	
public:
	operator IZCachedResolver*(void) { return (IZCachedResolver*)&__IZCachedResolver; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcmysqlresultset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcmysqlresultset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcMySqlResultSet
