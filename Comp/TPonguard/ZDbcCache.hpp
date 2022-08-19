// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcCache.pas' rev: 5.00

#ifndef ZDbcCacheHPP
#define ZDbcCacheHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbccache
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZRowUpdateType { utUnmodified, utModified, utInserted, utDeleted };
#pragma option pop

typedef Set<TZRowUpdateType, utUnmodified, utDeleted>  TZRowUpdateTypes;

#pragma pack(push, 1)
struct TZRowBuffer
{
	int Index;
	TZRowUpdateType UpdateType;
	Byte BookmarkFlag;
	Byte Columns[32768];
} ;
#pragma pack(pop)

typedef TZRowBuffer *PZRowBuffer;

typedef DynamicArray<AnsiString >  ZDbcCache__2;

typedef DynamicArray<bool >  ZDbcCache__3;

typedef DynamicArray<Zdbcintfs::TZSQLType >  ZDbcCache__4;

typedef DynamicArray<int >  ZDbcCache__5;

typedef DynamicArray<int >  ZDbcCache__6;

class DELPHICLASS TZRowAccessor;
class PASCALIMPLEMENTATION TZRowAccessor : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int FRowSize;
	int FColumnsSize;
	int FColumnCount;
	DynamicArray<AnsiString >  FColumnNames;
	DynamicArray<bool >  FColumnCases;
	DynamicArray<Zdbcintfs::TZSQLType >  FColumnTypes;
	DynamicArray<int >  FColumnLengths;
	DynamicArray<int >  FColumnOffsets;
	TZRowBuffer *FBuffer;
	bool FHasBlobs;
	int __fastcall GetColumnSize(Zdbcresultsetmetadata::TZColumnInfo* ColumnInfo);
	Zdbcintfs::_di_IZBlob __fastcall GetBlobObject(PZRowBuffer Buffer, int ColumnIndex);
	void __fastcall SetBlobObject(PZRowBuffer Buffer, int ColumnIndex, Zdbcintfs::_di_IZBlob Value);
	
protected:
	void __fastcall CheckColumnIndex(int ColumnIndex);
	void __fastcall CheckColumnConvertion(int ColumnIndex, Zdbcintfs::TZSQLType ResultType);
	
public:
	__fastcall TZRowAccessor(Contnrs::TObjectList* ColumnsInfo);
	__fastcall virtual ~TZRowAccessor(void);
	PZRowBuffer __fastcall AllocBuffer(PZRowBuffer &Buffer);
	void __fastcall InitBuffer(PZRowBuffer Buffer);
	void __fastcall CopyBuffer(PZRowBuffer SrcBuffer, PZRowBuffer DestBuffer);
	void __fastcall MoveBuffer(PZRowBuffer SrcBuffer, PZRowBuffer DestBuffer);
	void __fastcall CloneBuffer(PZRowBuffer SrcBuffer, PZRowBuffer DestBuffer);
	void __fastcall ClearBuffer(PZRowBuffer Buffer);
	void __fastcall DisposeBuffer(PZRowBuffer Buffer);
	int __fastcall CompareBuffers(PZRowBuffer Buffer1, PZRowBuffer Buffer2, Zcompatibility::TIntegerDynArray 
		ColumnIndices, Zcompatibility::TBooleanDynArray ColumnDirs);
	PZRowBuffer __fastcall Alloc(void);
	void __fastcall Init(void);
	void __fastcall CopyTo(PZRowBuffer DestBuffer);
	void __fastcall CopyFrom(PZRowBuffer SrcBuffer);
	void __fastcall MoveTo(PZRowBuffer DestBuffer);
	void __fastcall MoveFrom(PZRowBuffer SrcBuffer);
	void __fastcall CloneTo(PZRowBuffer DestBuffer);
	void __fastcall CloneFrom(PZRowBuffer SrcBuffer);
	void __fastcall Clear(void);
	void __fastcall Dispose(void);
	void * __fastcall GetColumnData(int ColumnIndex, bool &IsNull);
	int __fastcall GetColumnDataSize(int ColumnIndex);
	bool __fastcall IsNull(int ColumnIndex);
	char * __fastcall GetPChar(int ColumnIndex, bool &IsNull);
	AnsiString __fastcall GetString(int ColumnIndex, bool &IsNull);
	WideString __fastcall GetUnicodeString(int ColumnIndex, bool &IsNull);
	bool __fastcall GetBoolean(int ColumnIndex, bool &IsNull);
	Shortint __fastcall GetByte(int ColumnIndex, bool &IsNull);
	short __fastcall GetShort(int ColumnIndex, bool &IsNull);
	int __fastcall GetInt(int ColumnIndex, bool &IsNull);
	__int64 __fastcall GetLong(int ColumnIndex, bool &IsNull);
	float __fastcall GetFloat(int ColumnIndex, bool &IsNull);
	double __fastcall GetDouble(int ColumnIndex, bool &IsNull);
	Extended __fastcall GetBigDecimal(int ColumnIndex, bool &IsNull);
	Zcompatibility::TByteDynArray __fastcall GetBytes(int ColumnIndex, bool &IsNull);
	System::TDateTime __fastcall GetDate(int ColumnIndex, bool &IsNull);
	System::TDateTime __fastcall GetTime(int ColumnIndex, bool &IsNull);
	System::TDateTime __fastcall GetTimestamp(int ColumnIndex, bool &IsNull);
	Classes::TStream* __fastcall GetAsciiStream(int ColumnIndex, bool &IsNull);
	Classes::TStream* __fastcall GetUnicodeStream(int ColumnIndex, bool &IsNull);
	Classes::TStream* __fastcall GetBinaryStream(int ColumnIndex, bool &IsNull);
	Zdbcintfs::_di_IZBlob __fastcall GetBlob(int ColumnIndex, bool &IsNull);
	Zvariant::TZVariant __fastcall GetValue(int ColumnIndex);
	void __fastcall SetNotNull(int ColumnIndex);
	void __fastcall SetNull(int ColumnIndex);
	void __fastcall SetBoolean(int ColumnIndex, bool Value);
	void __fastcall SetByte(int ColumnIndex, Shortint Value);
	void __fastcall SetShort(int ColumnIndex, short Value);
	void __fastcall SetInt(int ColumnIndex, int Value);
	void __fastcall SetLong(int ColumnIndex, __int64 Value);
	void __fastcall SetFloat(int ColumnIndex, float Value);
	void __fastcall SetDouble(int ColumnIndex, double Value);
	void __fastcall SetBigDecimal(int ColumnIndex, Extended Value);
	void __fastcall SetPChar(int ColumnIndex, char * Value);
	void __fastcall SetString(int ColumnIndex, AnsiString Value);
	void __fastcall SetUnicodeString(int ColumnIndex, WideString Value);
	void __fastcall SetBytes(int ColumnIndex, Zcompatibility::TByteDynArray Value);
	void __fastcall SetDate(int ColumnIndex, System::TDateTime Value);
	void __fastcall SetTime(int ColumnIndex, System::TDateTime Value);
	void __fastcall SetTimestamp(int ColumnIndex, System::TDateTime Value);
	void __fastcall SetAsciiStream(int ColumnIndex, Classes::TStream* Value);
	void __fastcall SetUnicodeStream(int ColumnIndex, Classes::TStream* Value);
	void __fastcall SetBinaryStream(int ColumnIndex, Classes::TStream* Value);
	void __fastcall SetBlob(int ColumnIndex, Zdbcintfs::_di_IZBlob Value);
	void __fastcall SetValue(int ColumnIndex, const Zvariant::TZVariant &Value);
	__property int ColumnsSize = {read=FColumnsSize, nodefault};
	__property int RowSize = {read=FRowSize, nodefault};
	__property PZRowBuffer RowBuffer = {read=FBuffer, write=FBuffer};
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint RowHeaderSize = 0x6;

}	/* namespace Zdbccache */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbccache;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcCache
