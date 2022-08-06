// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSysUtils.pas' rev: 5.00

#ifndef ZSysUtilsHPP
#define ZSysUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZMessages.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsysutils
{
//-- type declarations -------------------------------------------------------
typedef int __fastcall (__closure *TZListSortCompare)(void * Item1, void * Item2);

class DELPHICLASS TZSortedList;
class PASCALIMPLEMENTATION TZSortedList : public Classes::TList 
{
	typedef Classes::TList inherited;
	
protected:
	void __fastcall QuickSort(Classes::PPointerList SortList, int L, int R, TZListSortCompare SCompare)
		;
	
public:
	HIDESBASE void __fastcall Sort(TZListSortCompare Compare);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TZSortedList(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZSortedList(void) : Classes::TList() { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString NullAsStringValue;
extern PACKAGE int __fastcall FirstDelimiter(AnsiString Delimiters, AnsiString Str);
extern PACKAGE int __fastcall LastDelimiter(AnsiString Delimiters, AnsiString Str);
extern PACKAGE bool __fastcall StartsWith(AnsiString Str, AnsiString SubStr);
extern PACKAGE bool __fastcall EndsWith(AnsiString Str, AnsiString SubStr);
extern PACKAGE Extended __fastcall SqlStrToFloatDef(AnsiString Str, Extended Def);
extern PACKAGE Extended __fastcall SqlStrToFloat(AnsiString Str);
extern PACKAGE AnsiString __fastcall BufferToStr(char * Buffer, int Length);
extern PACKAGE bool __fastcall StrToBoolEx(AnsiString Str);
extern PACKAGE bool __fastcall IsIpAddr(AnsiString Str);
extern PACKAGE Classes::TStrings* __fastcall SplitString(AnsiString Str, AnsiString Delimiters);
extern PACKAGE void __fastcall PutSplitString(Classes::TStrings* List, AnsiString Str, AnsiString Delimiters
	);
extern PACKAGE void __fastcall AppendSplitString(Classes::TStrings* List, AnsiString Str, AnsiString 
	Delimiters);
extern PACKAGE AnsiString __fastcall ComposeString(Classes::TStrings* List, AnsiString Delimiter);
extern PACKAGE AnsiString __fastcall FloatToSqlStr(Extended Value);
extern PACKAGE void __fastcall PutSplitStringEx(Classes::TStrings* List, AnsiString Str, AnsiString 
	Delimiter);
extern PACKAGE Classes::TStrings* __fastcall SplitStringEx(AnsiString Str, AnsiString Delimiter);
extern PACKAGE void __fastcall AppendSplitStringEx(Classes::TStrings* List, AnsiString Str, AnsiString 
	Delimiter);
extern PACKAGE AnsiString __fastcall BytesToStr(Zcompatibility::TByteDynArray Value);
extern PACKAGE Zcompatibility::TByteDynArray __fastcall StrToBytes(AnsiString Value);
extern PACKAGE Variant __fastcall BytesToVar(Zcompatibility::TByteDynArray Value);
extern PACKAGE Zcompatibility::TByteDynArray __fastcall VarToBytes(const Variant &Value);
extern PACKAGE WideString __fastcall VarToWideStr(const Variant &Value);
extern PACKAGE WideString __fastcall VarToWideStrDef(const Variant &Value, const WideString Default)
	;
extern PACKAGE Extended __fastcall StrToFloatDef(const AnsiString S, const Extended Default);
extern PACKAGE System::TDateTime __fastcall AnsiSQLDateToDateTime(AnsiString Value);
extern PACKAGE AnsiString __fastcall DateTimeToAnsiSQLDate(System::TDateTime Value);
extern PACKAGE AnsiString __fastcall EncodeCString(AnsiString Value);
extern PACKAGE AnsiString __fastcall DecodeCString(AnsiString Value);
extern PACKAGE AnsiString __fastcall ReplaceChar(const char Source, const char Target, const AnsiString 
	Str);

}	/* namespace Zsysutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsysutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSysUtils
