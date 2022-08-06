// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcCachedResultSet.pas' rev: 5.00

#ifndef ZDbcCachedResultSetHPP
#define ZDbcCachedResultSetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbccachedresultset
{
//-- type declarations -------------------------------------------------------
__interface IZCachedResolver;
typedef System::DelphiInterface<IZCachedResolver> _di_IZCachedResolver;
__interface IZCachedResultSet;
typedef System::DelphiInterface<IZCachedResultSet> _di_IZCachedResultSet;
__interface INTERFACE_UUID("{546ED716-BB88-468C-8CCE-D7111CF5E1EF}") IZCachedResolver  : public IUnknown 
	
{
	
public:
	virtual void __fastcall CalculateDefaults(_di_IZCachedResultSet Sender, Zdbccache::TZRowAccessor* RowAccessor
		) = 0 ;
	virtual void __fastcall PostUpdates(_di_IZCachedResultSet Sender, Zdbccache::TZRowUpdateType UpdateType
		, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor) = 0 ;
};

__interface INTERFACE_UUID("{BAF24A92-C8CE-4AB4-AEBC-3D4A9BCB0946}") IZCachedResultSet  : public IZResultSet 
	
{
	
public:
	virtual _di_IZCachedResolver __fastcall GetResolver(void) = 0 ;
	virtual void __fastcall SetResolver(_di_IZCachedResolver Resolver) = 0 ;
	virtual bool __fastcall IsCachedUpdates(void) = 0 ;
	virtual void __fastcall SetCachedUpdates(bool Value) = 0 ;
	virtual bool __fastcall IsPendingUpdates(void) = 0 ;
	virtual void __fastcall PostUpdates(void) = 0 ;
	virtual void __fastcall CancelUpdates(void) = 0 ;
	virtual void __fastcall RevertRecord(void) = 0 ;
	virtual void __fastcall MoveToInitialRow(void) = 0 ;
};

class DELPHICLASS TZAbstractCachedResultSet;
class PASCALIMPLEMENTATION TZAbstractCachedResultSet : public Zdbcresultset::TZAbstractResultSet 
{
	typedef Zdbcresultset::TZAbstractResultSet inherited;
	
private:
	bool FCachedUpdates;
	Classes::TList* FRowsList;
	Classes::TList* FInitialRowsList;
	Classes::TList* FCurrentRowsList;
	Zdbccache::TZRowBuffer *FSelectedRow;
	Zdbccache::TZRowBuffer *FUpdatedRow;
	Zdbccache::TZRowBuffer *FInsertedRow;
	Zdbccache::TZRowAccessor* FRowAccessor;
	Zdbccache::TZRowAccessor* FNewRowAccessor;
	Zdbccache::TZRowAccessor* FOldRowAccessor;
	int FNextRowIndex;
	_di_IZCachedResolver FResolver;
	
protected:
	__fastcall TZAbstractCachedResultSet(AnsiString SQL, Zdbcintfs::_di_IZStatement Statement);
	void __fastcall CheckAvailable(void);
	void __fastcall CheckUpdatable(void);
	virtual void __fastcall Open(void);
	int __fastcall GetNextRowIndex(void);
	virtual void __fastcall CalculateRowDefaults(Zdbccache::TZRowAccessor* RowAccessor);
	virtual void __fastcall PostRowUpdates(Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* 
		NewRowAccessor);
	int __fastcall LocateRow(Classes::TList* RowsList, int RowIndex);
	Zdbccache::PZRowBuffer __fastcall AppendRow(Zdbccache::PZRowBuffer Row);
	void __fastcall PrepareRowForUpdates(void);
	__property bool CachedUpdates = {read=FCachedUpdates, write=FCachedUpdates, nodefault};
	__property Classes::TList* RowsList = {read=FRowsList, write=FRowsList};
	__property Classes::TList* InitialRowsList = {read=FInitialRowsList, write=FInitialRowsList};
	__property Classes::TList* CurrentRowsList = {read=FCurrentRowsList, write=FCurrentRowsList};
	__property Zdbccache::PZRowBuffer SelectedRow = {read=FSelectedRow, write=FSelectedRow};
	__property Zdbccache::PZRowBuffer UpdatedRow = {read=FUpdatedRow, write=FUpdatedRow};
	__property Zdbccache::PZRowBuffer InsertedRow = {read=FInsertedRow, write=FInsertedRow};
	__property Zdbccache::TZRowAccessor* RowAccessor = {read=FRowAccessor, write=FRowAccessor};
	__property Zdbccache::TZRowAccessor* OldRowAccessor = {read=FOldRowAccessor, write=FOldRowAccessor}
		;
	__property Zdbccache::TZRowAccessor* NewRowAccessor = {read=FNewRowAccessor, write=FNewRowAccessor}
		;
	__property int NextRowIndex = {read=FNextRowIndex, write=FNextRowIndex, nodefault};
	__property _di_IZCachedResolver Resolver = {read=FResolver, write=FResolver};
	
public:
	__fastcall TZAbstractCachedResultSet(Contnrs::TObjectList* ColumnsInfo, AnsiString SQL);
	__fastcall virtual ~TZAbstractCachedResultSet(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall IsNull(int ColumnIndex);
	virtual char * __fastcall GetPChar(int ColumnIndex);
	virtual AnsiString __fastcall GetString(int ColumnIndex);
	virtual WideString __fastcall GetUnicodeString(int ColumnIndex);
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
	virtual bool __fastcall RowUpdated(void);
	virtual bool __fastcall RowInserted(void);
	virtual bool __fastcall RowDeleted(void);
	virtual void __fastcall UpdateNull(int ColumnIndex);
	virtual void __fastcall UpdateBoolean(int ColumnIndex, bool Value);
	virtual void __fastcall UpdateByte(int ColumnIndex, Shortint Value);
	virtual void __fastcall UpdateShort(int ColumnIndex, short Value);
	virtual void __fastcall UpdateInt(int ColumnIndex, int Value);
	virtual void __fastcall UpdateLong(int ColumnIndex, __int64 Value);
	virtual void __fastcall UpdateFloat(int ColumnIndex, float Value);
	virtual void __fastcall UpdateDouble(int ColumnIndex, double Value);
	virtual void __fastcall UpdateBigDecimal(int ColumnIndex, Extended Value);
	virtual void __fastcall UpdatePChar(int ColumnIndex, char * Value);
	virtual void __fastcall UpdateString(int ColumnIndex, AnsiString Value);
	virtual void __fastcall UpdateUnicodeString(int ColumnIndex, WideString Value);
	virtual void __fastcall UpdateBytes(int ColumnIndex, Zcompatibility::TByteDynArray Value);
	virtual void __fastcall UpdateDate(int ColumnIndex, System::TDateTime Value);
	virtual void __fastcall UpdateTime(int ColumnIndex, System::TDateTime Value);
	virtual void __fastcall UpdateTimestamp(int ColumnIndex, System::TDateTime Value);
	virtual void __fastcall UpdateAsciiStream(int ColumnIndex, Classes::TStream* Value);
	virtual void __fastcall UpdateUnicodeStream(int ColumnIndex, Classes::TStream* Value);
	virtual void __fastcall UpdateBinaryStream(int ColumnIndex, Classes::TStream* Value);
	virtual void __fastcall InsertRow(void);
	virtual void __fastcall UpdateRow(void);
	virtual void __fastcall DeleteRow(void);
	virtual void __fastcall CancelRowUpdates(void);
	virtual void __fastcall MoveToInsertRow(void);
	virtual void __fastcall MoveToCurrentRow(void);
	virtual int __fastcall CompareRows(int Row1, int Row2, Zcompatibility::TIntegerDynArray ColumnIndices
		, Zcompatibility::TBooleanDynArray ColumnDirs);
	_di_IZCachedResolver __fastcall GetResolver();
	void __fastcall SetResolver(_di_IZCachedResolver Resolver);
	bool __fastcall IsCachedUpdates(void);
	void __fastcall SetCachedUpdates(bool Value);
	virtual bool __fastcall IsPendingUpdates(void);
	virtual void __fastcall PostUpdates(void);
	virtual void __fastcall CancelUpdates(void);
	virtual void __fastcall RevertRecord(void);
	virtual void __fastcall MoveToInitialRow(void);
protected:
	#pragma option push -w-inl
	/* TZAbstractResultSet.Create */ inline __fastcall TZAbstractCachedResultSet(Zdbcintfs::_di_IZStatement 
		Statement, AnsiString SQL, Comobj::TContainedObject* Metadata) : Zdbcresultset::TZAbstractResultSet(
		Statement, SQL, Metadata) { }
	#pragma option pop
	
private:
	void *__IZCachedResultSet;	/* Zdbccachedresultset::IZCachedResultSet */
	
public:
	operator IZCachedResultSet*(void) { return (IZCachedResultSet*)&__IZCachedResultSet; }
	
};


class DELPHICLASS TZCachedResultSet;
class PASCALIMPLEMENTATION TZCachedResultSet : public TZAbstractCachedResultSet 
{
	typedef TZAbstractCachedResultSet inherited;
	
private:
	Zdbcintfs::_di_IZResultSet FResultSet;
	
protected:
	virtual void __fastcall Open(void);
	virtual bool __fastcall Fetch(void);
	virtual void __fastcall FetchAll(void);
	__property Zdbcintfs::_di_IZResultSet ResultSet = {read=FResultSet, write=FResultSet};
	
public:
	__fastcall TZCachedResultSet(Zdbcintfs::_di_IZResultSet ResultSet, AnsiString SQL, _di_IZCachedResolver 
		Resolver);
	__fastcall virtual ~TZCachedResultSet(void);
	virtual void __fastcall Close(void);
	virtual Zdbcintfs::_di_IZResultSetMetadata __fastcall GetMetaData();
	virtual bool __fastcall IsAfterLast(void);
	virtual bool __fastcall IsLast(void);
	virtual void __fastcall AfterLast(void);
	virtual bool __fastcall Last(void);
	virtual bool __fastcall MoveAbsolute(int Row);
protected:
	#pragma option push -w-inl
	/* TZAbstractCachedResultSet.CreateWithStatement */ inline __fastcall TZCachedResultSet(AnsiString 
		SQL, Zdbcintfs::_di_IZStatement Statement) : TZAbstractCachedResultSet(SQL, Statement) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TZAbstractCachedResultSet.CreateWithColumns */ inline __fastcall TZCachedResultSet(Contnrs::TObjectList* 
		ColumnsInfo, AnsiString SQL) : TZAbstractCachedResultSet(ColumnsInfo, SQL) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbccachedresultset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbccachedresultset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcCachedResultSet
