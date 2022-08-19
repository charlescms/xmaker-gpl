// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcDbLibResultSet.pas' rev: 5.00

#ifndef ZDbcDbLibResultSetHPP
#define ZDbcDbLibResultSetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDbLibDriver.hpp>	// Pascal unit
#include <ZDbcDbLib.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcGenericResolver.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
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

namespace Zdbcdblibresultset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZDBLibResultSet;
class PASCALIMPLEMENTATION TZDBLibResultSet : public Zdbcresultset::TZAbstractResultSet 
{
	typedef Zdbcresultset::TZAbstractResultSet inherited;
	
private:
	AnsiString FSQL;
	void *FHandle;
	DynamicArray<short >  DBLibColTypeCache;
	int DBLibColumnCount;
	void __fastcall CheckColumnIndex(int ColumnIndex);
	
protected:
	Zdbcdblib::_di_IZDBLibConnection FDBLibConnection;
	Zplaindblibdriver::_di_IZDBLibPlainDriver FPlainDriver;
	virtual void __fastcall Open(void);
	
public:
	__fastcall TZDBLibResultSet(Zdbcintfs::_di_IZStatement Statement, AnsiString SQL);
	__fastcall virtual ~TZDBLibResultSet(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall IsNull(int ColumnIndex);
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
	virtual Zdbcintfs::_di_IZBlob __fastcall GetBlob(int ColumnIndex);
	virtual bool __fastcall MoveAbsolute(int Row);
	virtual bool __fastcall Next(void);
};


class DELPHICLASS TZDBLibCachedResolver;
class PASCALIMPLEMENTATION TZDBLibCachedResolver : public Zdbcgenericresolver::TZGenericCachedResolver 
	
{
	typedef Zdbcgenericresolver::TZGenericCachedResolver inherited;
	
private:
	int FAutoColumnIndex;
	
public:
	__fastcall TZDBLibCachedResolver(Zdbcintfs::_di_IZStatement Statement, Zdbcintfs::_di_IZResultSetMetadata 
		Metadata);
	virtual void __fastcall PostUpdates(Zdbccachedresultset::_di_IZCachedResultSet Sender, Zdbccache::TZRowUpdateType 
		UpdateType, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor);
public:
		
	#pragma option push -w-inl
	/* TZGenericCachedResolver.Destroy */ inline __fastcall virtual ~TZDBLibCachedResolver(void) { }
	#pragma option pop
	
private:
	void *__IZCachedResolver;	/* Zdbccachedresultset::IZCachedResolver */
	
public:
	operator IZCachedResolver*(void) { return (IZCachedResolver*)&__IZCachedResolver; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcdblibresultset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcdblibresultset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcDbLibResultSet
