// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZCompatibility.pas' rev: 5.00

#ifndef ZCompatibilityHPP
#define ZCompatibilityHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zcompatibility
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<int >  TIntegerDynArray;

typedef DynamicArray<unsigned >  TCardinalDynArray;

typedef DynamicArray<Word >  TWordDynArray;

typedef DynamicArray<short >  TSmallIntDynArray;

typedef DynamicArray<Byte >  TByteDynArray;

typedef DynamicArray<Shortint >  TShortIntDynArray;

typedef DynamicArray<__int64 >  TInt64DynArray;

typedef DynamicArray<unsigned >  TLongWordDynArray;

typedef DynamicArray<float >  TSingleDynArray;

typedef DynamicArray<double >  TDoubleDynArray;

typedef DynamicArray<bool >  TBooleanDynArray;

typedef DynamicArray<AnsiString >  TStringDynArray;

typedef DynamicArray<WideString >  TWideStringDynArray;

typedef DynamicArray<Variant >  TVariantDynArray;

typedef DynamicArray<System::TObject* >  TObjectDynArray;

typedef int IntegerArray[251658240];

typedef int *PIntegerArray;

typedef void * *PPointer;

typedef Byte *PByte;

typedef bool *PBoolean;

typedef Shortint *PShortInt;

typedef short *PSmallInt;

typedef int *PInteger;

typedef int *PLongInt;

typedef float *PSingle;

typedef double *PDouble;

typedef Word *PWord;

typedef Word *PWordBool;

typedef unsigned *PCardinal;

typedef __int64 *PInt64;

typedef TObjectList TObjectList;
;

typedef void __fastcall (__closure *TLoginEvent)(System::TObject* Sender, AnsiString Username, AnsiString 
	Password);

#pragma option push -b-
enum TDBScreenCursor { dcrDefault, dcrHourGlass, dcrSQLWait, dcrOther };
#pragma option pop

__interface IDBScreen;
typedef System::DelphiInterface<IDBScreen> _di_IDBScreen;
__interface INTERFACE_UUID("{29A1C508-6ADC-44CD-88DE-4F51B25D5995}") IDBScreen  : public IUnknown 
{
	
public:
	virtual TDBScreenCursor __fastcall GetCursor(void) = 0 ;
	virtual void __fastcall SetCursor(TDBScreenCursor Cursor) = 0 ;
	__property TDBScreenCursor Cursor = {read=GetCursor, write=SetCursor};
};

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall (*LoginDialogProc)(const AnsiString ADatabaseName, AnsiString &AUserName
	, AnsiString &APassword);
extern PACKAGE _di_IDBScreen DBScreen;
extern PACKAGE Extended __fastcall StrToFloatDef(AnsiString Str, Extended Def);
extern PACKAGE AnsiString __fastcall AnsiDequotedStr(const AnsiString S, char AQuote);
extern PACKAGE AnsiString __fastcall BoolToStr(bool Value);
extern PACKAGE bool __fastcall VarIsStr(const Variant &V);

}	/* namespace Zcompatibility */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zcompatibility;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZCompatibility
