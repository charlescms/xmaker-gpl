// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZVariant.pas' rev: 5.00

#ifndef ZVariantHPP
#define ZVariantHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zvariant
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZVariantType { vtNull, vtBoolean, vtInteger, vtFloat, vtString, vtUnicodeString, vtDateTime, vtPointer, 
	vtInterface };
#pragma option pop

#pragma pack(push, 1)
struct TZVariant
{
	TZVariantType VType;
	bool VBoolean;
	__int64 VInteger;
	Extended VFloat;
	AnsiString VString;
	WideString VUnicodeString;
	System::TDateTime VDateTime;
	void *VPointer;
	_di_IUnknown VInterface;
} ;
#pragma pack(pop)

typedef DynamicArray<TZVariant >  TZVariantDynArray;

class DELPHICLASS EZVariantException;
class PASCALIMPLEMENTATION EZVariantException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EZVariantException(const AnsiString Msg) : Sysutils::Exception(
		Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EZVariantException(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EZVariantException(int Ident)/* overload */ : Sysutils::Exception(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EZVariantException(int Ident, const System::TVarRec 
		* Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EZVariantException(const AnsiString Msg, int AHelpContext
		) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EZVariantException(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EZVariantException(int Ident, int AHelpContext)/* overload */
		 : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EZVariantException(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EZVariantException(void) { }
	#pragma option pop
	
};


__interface IZVariantManager;
typedef System::DelphiInterface<IZVariantManager> _di_IZVariantManager;
__interface INTERFACE_UUID("{DAA373D9-1A98-4AA8-B65E-4C23167EE83F}") IZVariantManager  : public IUnknown 
	
{
	
public:
	virtual bool __fastcall IsNull(const TZVariant &Value) = 0 ;
	virtual void __fastcall SetNull(TZVariant &Value) = 0 ;
	virtual TZVariant __fastcall Convert(const TZVariant &Value, TZVariantType NewType) = 0 ;
	virtual void __fastcall Assign(const TZVariant &SrcValue, TZVariant &DstValue) = 0 ;
	virtual TZVariant __fastcall Clone(const TZVariant &Value) = 0 ;
	virtual int __fastcall Compare(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual bool __fastcall GetAsBoolean(const TZVariant &Value) = 0 ;
	virtual __int64 __fastcall GetAsInteger(const TZVariant &Value) = 0 ;
	virtual Extended __fastcall GetAsFloat(const TZVariant &Value) = 0 ;
	virtual AnsiString __fastcall GetAsString(const TZVariant &Value) = 0 ;
	virtual WideString __fastcall GetAsUnicodeString(const TZVariant &Value) = 0 ;
	virtual System::TDateTime __fastcall GetAsDateTime(const TZVariant &Value) = 0 ;
	virtual void * __fastcall GetAsPointer(const TZVariant &Value) = 0 ;
	virtual _di_IUnknown __fastcall GetAsInterface(const TZVariant &Value) = 0 ;
	virtual void __fastcall SetAsBoolean(TZVariant &Value, bool Data) = 0 ;
	virtual void __fastcall SetAsInteger(TZVariant &Value, __int64 Data) = 0 ;
	virtual void __fastcall SetAsFloat(TZVariant &Value, Extended Data) = 0 ;
	virtual void __fastcall SetAsString(TZVariant &Value, AnsiString Data) = 0 ;
	virtual void __fastcall SetAsUnicodeString(TZVariant &Value, WideString Data) = 0 ;
	virtual void __fastcall SetAsDateTime(TZVariant &Value, System::TDateTime Data) = 0 ;
	virtual void __fastcall SetAsPointer(TZVariant &Value, void * Data) = 0 ;
	virtual void __fastcall SetAsInterface(TZVariant &Value, _di_IUnknown Data) = 0 ;
	virtual TZVariant __fastcall OpAdd(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpSub(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpMul(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpDiv(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpMod(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpPow(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpAnd(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpOr(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpXor(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpNot(const TZVariant &Value) = 0 ;
	virtual TZVariant __fastcall OpNegative(const TZVariant &Value) = 0 ;
	virtual TZVariant __fastcall OpEqual(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpNotEqual(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpMore(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpLess(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpMoreEqual(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
	virtual TZVariant __fastcall OpLessEqual(const TZVariant &Value1, const TZVariant &Value2) = 0 ;
};

class DELPHICLASS TZDefaultVariantManager;
class PASCALIMPLEMENTATION TZDefaultVariantManager : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
protected:
	void __fastcall RaiseTypeMismatchError(void);
	void __fastcall RaiseUnsupportedOperation(void);
	
public:
	virtual TZVariant __fastcall Convert(const TZVariant &Value, TZVariantType NewType);
	void __fastcall Assign(const TZVariant &SrcValue, TZVariant &DstValue);
	TZVariant __fastcall Clone(const TZVariant &Value);
	int __fastcall Compare(const TZVariant &Value1, const TZVariant &Value2);
	bool __fastcall IsNull(const TZVariant &Value);
	void __fastcall SetNull(TZVariant &Value);
	bool __fastcall GetAsBoolean(const TZVariant &Value);
	__int64 __fastcall GetAsInteger(const TZVariant &Value);
	Extended __fastcall GetAsFloat(const TZVariant &Value);
	AnsiString __fastcall GetAsString(const TZVariant &Value);
	WideString __fastcall GetAsUnicodeString(const TZVariant &Value);
	System::TDateTime __fastcall GetAsDateTime(const TZVariant &Value);
	void * __fastcall GetAsPointer(const TZVariant &Value);
	_di_IUnknown __fastcall GetAsInterface(const TZVariant &Value);
	void __fastcall SetAsBoolean(TZVariant &Value, bool Data);
	void __fastcall SetAsInteger(TZVariant &Value, __int64 Data);
	void __fastcall SetAsFloat(TZVariant &Value, Extended Data);
	void __fastcall SetAsString(TZVariant &Value, AnsiString Data);
	void __fastcall SetAsUnicodeString(TZVariant &Value, WideString Data);
	void __fastcall SetAsDateTime(TZVariant &Value, System::TDateTime Data);
	void __fastcall SetAsPointer(TZVariant &Value, void * Data);
	void __fastcall SetAsInterface(TZVariant &Value, _di_IUnknown Data);
	TZVariant __fastcall OpAdd(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpSub(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpMul(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpDiv(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpMod(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpPow(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpAnd(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpOr(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpXor(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpNot(const TZVariant &Value);
	TZVariant __fastcall OpNegative(const TZVariant &Value);
	TZVariant __fastcall OpEqual(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpNotEqual(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpMore(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpLess(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpMoreEqual(const TZVariant &Value1, const TZVariant &Value2);
	TZVariant __fastcall OpLessEqual(const TZVariant &Value1, const TZVariant &Value2);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZDefaultVariantManager(void) : System::TInterfacedObject() { }
		
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZDefaultVariantManager(void) { }
	#pragma option pop
	
private:
	void *__IZVariantManager;	/* Zvariant::IZVariantManager */
	
public:
	operator IZVariantManager*(void) { return (IZVariantManager*)&__IZVariantManager; }
	
};


class DELPHICLASS TZSoftVariantManager;
class PASCALIMPLEMENTATION TZSoftVariantManager : public TZDefaultVariantManager 
{
	typedef TZDefaultVariantManager inherited;
	
public:
	virtual TZVariant __fastcall Convert(const TZVariant &Value, TZVariantType NewType);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZSoftVariantManager(void) : TZDefaultVariantManager() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSoftVariantManager(void) { }
	#pragma option pop
	
};


__interface IZAnyValue;
typedef System::DelphiInterface<IZAnyValue> _di_IZAnyValue;
__interface INTERFACE_UUID("{E81988B3-FD0E-4524-B658-B309B02F0B6A}") IZAnyValue  : public IZClonnable 
	
{
	
public:
	virtual bool __fastcall IsNull(void) = 0 ;
	virtual TZVariant __fastcall GetValue(void) = 0 ;
	virtual bool __fastcall GetBoolean(void) = 0 ;
	virtual __int64 __fastcall GetInteger(void) = 0 ;
	virtual Extended __fastcall GetFloat(void) = 0 ;
	virtual AnsiString __fastcall GetString(void) = 0 ;
	virtual WideString __fastcall GetUnicodeString(void) = 0 ;
	virtual System::TDateTime __fastcall GetDateTime(void) = 0 ;
};

class DELPHICLASS TZAnyValue;
class PASCALIMPLEMENTATION TZAnyValue : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	#pragma pack(push, 1)
	TZVariant FValue;
	#pragma pack(pop)
	
	
public:
	__fastcall TZAnyValue(const TZVariant &Value);
	__fastcall TZAnyValue(bool Value);
	__fastcall TZAnyValue(__int64 Value);
	__fastcall TZAnyValue(Extended Value);
	__fastcall TZAnyValue(AnsiString Value);
	__fastcall TZAnyValue(WideString Value);
	__fastcall TZAnyValue(System::TDateTime Value);
	bool __fastcall IsNull(void);
	TZVariant __fastcall GetValue();
	bool __fastcall GetBoolean(void);
	__int64 __fastcall GetInteger(void);
	Extended __fastcall GetFloat(void);
	AnsiString __fastcall GetString();
	WideString __fastcall GetUnicodeString();
	System::TDateTime __fastcall GetDateTime(void);
	virtual bool __fastcall Equals(const _di_IUnknown Value);
	virtual _di_IUnknown __fastcall Clone();
	virtual AnsiString __fastcall ToString();
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAnyValue(void) { }
	#pragma option pop
	
private:
	void *__IZAnyValue;	/* Zvariant::IZAnyValue */
	void *__IZComparable;	/* Zclasses::IZComparable */
	
public:
	operator IZComparable*(void) { return (IZComparable*)&__IZComparable; }
	operator IZAnyValue*(void) { return (IZAnyValue*)&__IZAnyValue; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE _di_IZVariantManager DefVarManager;
extern PACKAGE _di_IZVariantManager SoftVarManager;
extern PACKAGE TZVariant NullVariant;
extern PACKAGE Variant __fastcall EncodeVariant(const TZVariant &Value);
extern PACKAGE Variant __fastcall EncodeVariantArray(TZVariantDynArray Value);
extern PACKAGE TZVariant __fastcall DecodeVariant(const Variant &Value);
extern PACKAGE TZVariantDynArray __fastcall DecodeVariantArray(const Variant &Value);

}	/* namespace Zvariant */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zvariant;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZVariant
