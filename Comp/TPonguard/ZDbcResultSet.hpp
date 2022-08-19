// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcResultSet.pas' rev: 5.00

#ifndef ZDbcResultSetHPP
#define ZDbcResultSetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcresultset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZAbstractResultSet;
class PASCALIMPLEMENTATION TZAbstractResultSet : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FBuffer;
	int FRowNo;
	int FLastRowNo;
	int FMaxRows;
	bool FClosed;
	Zdbcintfs::TZFetchDirection FFetchDirection;
	int FFetchSize;
	Zdbcintfs::TZResultSetType FResultSetType;
	Zdbcintfs::TZResultSetConcurrency FResultSetConcurrency;
	Zdbcintfs::TZPostUpdatesMode FPostUpdates;
	Zdbcintfs::TZLocateUpdatesMode FLocateUpdates;
	Contnrs::TObjectList* FColumnsInfo;
	Comobj::TContainedObject* FMetadata;
	Zdbcintfs::_di_IZStatement FStatement;
	
protected:
	bool LastWasNull;
	__fastcall TZAbstractResultSet(Zdbcintfs::_di_IZStatement Statement, AnsiString SQL, Comobj::TContainedObject* 
		Metadata);
	void __fastcall RaiseUnsupportedException(void);
	void __fastcall RaiseForwardOnlyException(void);
	void __fastcall RaiseReadOnlyException(void);
	void __fastcall CheckClosed(void);
	void __fastcall CheckColumnConvertion(int ColumnIndex, Zdbcintfs::TZSQLType ResultType);
	void __fastcall CheckBlobColumn(int ColumnIndex);
	virtual void __fastcall Open(void);
	int __fastcall GetColumnIndex(AnsiString ColumnName);
	__property int RowNo = {read=FRowNo, write=FRowNo, nodefault};
	__property int LastRowNo = {read=FLastRowNo, write=FLastRowNo, nodefault};
	__property int MaxRows = {read=FMaxRows, write=FMaxRows, nodefault};
	__property bool Closed = {read=FClosed, write=FClosed, nodefault};
	__property Zdbcintfs::TZFetchDirection FetchDirection = {read=FFetchDirection, write=FFetchDirection
		, nodefault};
	__property int FetchSize = {read=FFetchSize, write=FFetchSize, nodefault};
	__property Zdbcintfs::TZResultSetType ResultSetType = {read=FResultSetType, write=FResultSetType, nodefault
		};
	__property Zdbcintfs::TZResultSetConcurrency ResultSetConcurrency = {read=FResultSetConcurrency, write=
		FResultSetConcurrency, nodefault};
	__property Zdbcintfs::_di_IZStatement Statement = {read=FStatement};
	__property Comobj::TContainedObject* Metadata = {read=FMetadata, write=FMetadata};
	
public:
	__fastcall virtual ~TZAbstractResultSet(void);
	void __fastcall SetType(Zdbcintfs::TZResultSetType Value);
	void __fastcall SetConcurrency(Zdbcintfs::TZResultSetConcurrency Value);
	virtual bool __fastcall Next(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall WasNull(void);
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
	virtual Classes::TStream* __fastcall GetAsciiStream(int ColumnIndex);
	virtual Classes::TStream* __fastcall GetUnicodeStream(int ColumnIndex);
	virtual Classes::TStream* __fastcall GetBinaryStream(int ColumnIndex);
	virtual Zdbcintfs::_di_IZBlob __fastcall GetBlob(int ColumnIndex);
	virtual Zvariant::TZVariant __fastcall GetValue(int ColumnIndex);
	virtual bool __fastcall IsNullByName(AnsiString ColumnName);
	virtual char * __fastcall GetPCharByName(AnsiString ColumnName);
	virtual AnsiString __fastcall GetStringByName(AnsiString ColumnName);
	virtual WideString __fastcall GetUnicodeStringByName(AnsiString ColumnName);
	virtual bool __fastcall GetBooleanByName(AnsiString ColumnName);
	virtual Shortint __fastcall GetByteByName(AnsiString ColumnName);
	virtual short __fastcall GetShortByName(AnsiString ColumnName);
	virtual int __fastcall GetIntByName(AnsiString ColumnName);
	virtual __int64 __fastcall GetLongByName(AnsiString ColumnName);
	virtual float __fastcall GetFloatByName(AnsiString ColumnName);
	virtual double __fastcall GetDoubleByName(AnsiString ColumnName);
	virtual Extended __fastcall GetBigDecimalByName(AnsiString ColumnName);
	virtual Zcompatibility::TByteDynArray __fastcall GetBytesByName(AnsiString ColumnName);
	virtual System::TDateTime __fastcall GetDateByName(AnsiString ColumnName);
	virtual System::TDateTime __fastcall GetTimeByName(AnsiString ColumnName);
	virtual System::TDateTime __fastcall GetTimestampByName(AnsiString ColumnName);
	virtual Classes::TStream* __fastcall GetAsciiStreamByName(AnsiString ColumnName);
	virtual Classes::TStream* __fastcall GetUnicodeStreamByName(AnsiString ColumnName);
	virtual Classes::TStream* __fastcall GetBinaryStreamByName(AnsiString ColumnName);
	virtual Zdbcintfs::_di_IZBlob __fastcall GetBlobByName(AnsiString ColumnName);
	virtual Zvariant::TZVariant __fastcall GetValueByName(AnsiString ColumnName);
	virtual Zdbcintfs::EZSQLWarning* __fastcall GetWarnings(void);
	virtual void __fastcall ClearWarnings(void);
	virtual AnsiString __fastcall GetCursorName();
	virtual Zdbcintfs::_di_IZResultSetMetadata __fastcall GetMetaData();
	virtual int __fastcall FindColumn(AnsiString ColumnName);
	virtual bool __fastcall IsBeforeFirst(void);
	virtual bool __fastcall IsAfterLast(void);
	virtual bool __fastcall IsFirst(void);
	virtual bool __fastcall IsLast(void);
	virtual void __fastcall BeforeFirst(void);
	virtual void __fastcall AfterLast(void);
	virtual bool __fastcall First(void);
	virtual bool __fastcall Last(void);
	virtual int __fastcall GetRow(void);
	virtual bool __fastcall MoveAbsolute(int Row);
	virtual bool __fastcall MoveRelative(int Rows);
	virtual bool __fastcall Previous(void);
	virtual void __fastcall SetFetchDirection(Zdbcintfs::TZFetchDirection Direction);
	virtual Zdbcintfs::TZFetchDirection __fastcall GetFetchDirection(void);
	virtual void __fastcall SetFetchSize(int Rows);
	virtual int __fastcall GetFetchSize(void);
	virtual Zdbcintfs::TZResultSetType __fastcall GetType(void);
	virtual Zdbcintfs::TZResultSetConcurrency __fastcall GetConcurrency(void);
	Zdbcintfs::TZPostUpdatesMode __fastcall GetPostUpdates(void);
	Zdbcintfs::TZLocateUpdatesMode __fastcall GetLocateUpdates(void);
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
	virtual void __fastcall UpdateValue(int ColumnIndex, const Zvariant::TZVariant &Value);
	virtual void __fastcall UpdateNullByName(AnsiString ColumnName);
	virtual void __fastcall UpdateBooleanByName(AnsiString ColumnName, bool Value);
	virtual void __fastcall UpdateByteByName(AnsiString ColumnName, Shortint Value);
	virtual void __fastcall UpdateShortByName(AnsiString ColumnName, short Value);
	virtual void __fastcall UpdateIntByName(AnsiString ColumnName, int Value);
	virtual void __fastcall UpdateLongByName(AnsiString ColumnName, __int64 Value);
	virtual void __fastcall UpdateFloatByName(AnsiString ColumnName, float Value);
	virtual void __fastcall UpdateDoubleByName(AnsiString ColumnName, double Value);
	virtual void __fastcall UpdateBigDecimalByName(AnsiString ColumnName, Extended Value);
	virtual void __fastcall UpdatePCharByName(AnsiString ColumnName, char * Value);
	virtual void __fastcall UpdateStringByName(AnsiString ColumnName, AnsiString Value);
	virtual void __fastcall UpdateUnicodeStringByName(AnsiString ColumnName, WideString Value);
	virtual void __fastcall UpdateBytesByName(AnsiString ColumnName, Zcompatibility::TByteDynArray Value
		);
	virtual void __fastcall UpdateDateByName(AnsiString ColumnName, System::TDateTime Value);
	virtual void __fastcall UpdateTimeByName(AnsiString ColumnName, System::TDateTime Value);
	virtual void __fastcall UpdateTimestampByName(AnsiString ColumnName, System::TDateTime Value);
	virtual void __fastcall UpdateAsciiStreamByName(AnsiString ColumnName, Classes::TStream* Value);
	virtual void __fastcall UpdateUnicodeStreamByName(AnsiString ColumnName, Classes::TStream* Value);
	virtual void __fastcall UpdateBinaryStreamByName(AnsiString ColumnName, Classes::TStream* Value);
	virtual void __fastcall UpdateValueByName(AnsiString ColumnName, const Zvariant::TZVariant &Value);
		
	virtual void __fastcall InsertRow(void);
	virtual void __fastcall UpdateRow(void);
	virtual void __fastcall DeleteRow(void);
	virtual void __fastcall RefreshRow(void);
	virtual void __fastcall CancelRowUpdates(void);
	virtual void __fastcall MoveToInsertRow(void);
	virtual void __fastcall MoveToCurrentRow(void);
	virtual int __fastcall CompareRows(int Row1, int Row2, Zcompatibility::TIntegerDynArray ColumnIndices
		, Zcompatibility::TBooleanDynArray ColumnDirs);
	virtual Zdbcintfs::_di_IZStatement __fastcall GetStatement();
	__property Contnrs::TObjectList* ColumnsInfo = {read=FColumnsInfo, write=FColumnsInfo};
private:
	void *__IZResultSet;	/* Zdbcintfs::IZResultSet */
	
public:
	operator IZResultSet*(void) { return (IZResultSet*)&__IZResultSet; }
	
};


class DELPHICLASS TZAbstractBlob;
class PASCALIMPLEMENTATION TZAbstractBlob : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	void *FBlobData;
	int FBlobSize;
	bool FUpdated;
	
protected:
	__property void * BlobData = {read=FBlobData, write=FBlobData};
	__property int BlobSize = {read=FBlobSize, write=FBlobSize, nodefault};
	__property bool Updated = {read=FUpdated, write=FUpdated, nodefault};
	
public:
	__fastcall TZAbstractBlob(Classes::TStream* Stream);
	__fastcall TZAbstractBlob(void * Data, int Size);
	__fastcall virtual ~TZAbstractBlob(void);
	virtual bool __fastcall IsEmpty(void);
	virtual bool __fastcall IsUpdated(void);
	virtual int __fastcall Length(void);
	virtual AnsiString __fastcall GetString();
	virtual void __fastcall SetString(AnsiString Value);
	virtual WideString __fastcall GetUnicodeString();
	virtual void __fastcall SetUnicodeString(WideString Value);
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes();
	virtual void __fastcall SetBytes(Zcompatibility::TByteDynArray Value);
	virtual Classes::TStream* __fastcall GetStream(void);
	virtual void __fastcall SetStream(Classes::TStream* Value);
	virtual void __fastcall Clear(void);
	virtual Zdbcintfs::_di_IZBlob __fastcall Clone();
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZAbstractBlob(void) : System::TInterfacedObject() { }
	#pragma option pop
	
private:
	void *__IZBlob;	/* Zdbcintfs::IZBlob */
	
public:
	operator IZBlob*(void) { return (IZBlob*)&__IZBlob; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcresultset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcresultset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcResultSet
