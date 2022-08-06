// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZClasses.pas' rev: 5.00

#ifndef ZClassesHPP
#define ZClassesHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zclasses
{
//-- type declarations -------------------------------------------------------
typedef IUnknown IZInterface;
;

__interface IZObject;
typedef System::DelphiInterface<IZObject> _di_IZObject;
__interface INTERFACE_UUID("{EF46E5F7-00CF-4DDA-BED0-057D6686AEE0}") IZObject  : public IUnknown 
{
	
public:
	virtual bool __fastcall Equals(const _di_IUnknown Value) = 0 ;
	virtual int __fastcall Hash(void) = 0 ;
	virtual _di_IUnknown __fastcall Clone(void) = 0 ;
	virtual AnsiString __fastcall ToString(void) = 0 ;
	virtual bool __fastcall InstanceOf(const GUID &IId) = 0 ;
};

__interface IZComparable;
typedef System::DelphiInterface<IZComparable> _di_IZComparable;
__interface INTERFACE_UUID("{04112081-F07B-4BBF-A757-817816EB67C1}") IZComparable  : public IZObject 
	
{
	
};

__interface IZClonnable;
typedef System::DelphiInterface<IZClonnable> _di_IZClonnable;
__interface INTERFACE_UUID("{ECB7F3A4-7B2E-4130-BA66-54A2D43C0149}") IZClonnable  : public IZObject 
	
{
	
};

__interface IZIterator;
typedef System::DelphiInterface<IZIterator> _di_IZIterator;
__interface INTERFACE_UUID("{D964DDD0-2308-4D9B-BD36-5810632512F7}") IZIterator  : public IZObject 
{
	
public:
	virtual bool __fastcall HasNext(void) = 0 ;
	virtual _di_IUnknown __fastcall Next(void) = 0 ;
};

__interface IZCollection;
typedef System::DelphiInterface<IZCollection> _di_IZCollection;
__interface INTERFACE_UUID("{51417C87-F992-4CAD-BC53-CF3925DD6E4C}") IZCollection  : public IZClonnable 
	
{
	
public:
	virtual _di_IUnknown __fastcall Get(int Index) = 0 ;
	virtual void __fastcall Put(int Index, const _di_IUnknown Item) = 0 ;
	virtual int __fastcall IndexOf(const _di_IUnknown Item) = 0 ;
	virtual int __fastcall GetCount(void) = 0 ;
	virtual _di_IZIterator __fastcall GetIterator(void) = 0 ;
	virtual _di_IUnknown __fastcall First(void) = 0 ;
	virtual _di_IUnknown __fastcall Last(void) = 0 ;
	virtual int __fastcall Add(const _di_IUnknown Item) = 0 ;
	virtual void __fastcall Insert(int Index, const _di_IUnknown Item) = 0 ;
	virtual int __fastcall Remove(const _di_IUnknown Item) = 0 ;
	virtual void __fastcall Exchange(int Index1, int Index2) = 0 ;
	virtual void __fastcall Delete(int Index) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	virtual bool __fastcall Contains(const _di_IUnknown Item) = 0 ;
	virtual bool __fastcall ContainsAll(const _di_IZCollection Col) = 0 ;
	virtual bool __fastcall AddAll(const _di_IZCollection Col) = 0 ;
	virtual bool __fastcall RemoveAll(const _di_IZCollection Col) = 0 ;
	__property int Count = {read=GetCount};
	__property _di_IUnknown Items[int Index] = {read=Get, write=Put/*, default*/};
};

__interface IZHashMap;
typedef System::DelphiInterface<IZHashMap> _di_IZHashMap;
__interface INTERFACE_UUID("{782C64F4-AD09-4F56-AF2B-E4193A05BBCE}") IZHashMap  : public IZClonnable 
	
{
	
public:
	virtual _di_IUnknown __fastcall Get(const _di_IUnknown Key) = 0 ;
	virtual void __fastcall Put(const _di_IUnknown Key, const _di_IUnknown Value) = 0 ;
	virtual _di_IZCollection __fastcall GetKeys(void) = 0 ;
	virtual _di_IZCollection __fastcall GetValues(void) = 0 ;
	virtual int __fastcall GetCount(void) = 0 ;
	virtual bool __fastcall Remove(_di_IUnknown Key) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	__property int Count = {read=GetCount};
	__property _di_IZCollection Keys = {read=GetKeys};
	__property _di_IZCollection Values = {read=GetValues};
};

__interface IZStack;
typedef System::DelphiInterface<IZStack> _di_IZStack;
__interface INTERFACE_UUID("{8FEA0B3F-0C02-4E70-BD8D-FB0F42D4497B}") IZStack  : public IZClonnable 
{
	
public:
	virtual _di_IUnknown __fastcall Peek(void) = 0 ;
	virtual _di_IUnknown __fastcall Pop(void) = 0 ;
	virtual void __fastcall Push(_di_IUnknown Value) = 0 ;
	virtual int __fastcall GetCount(void) = 0 ;
	__property int Count = {read=GetCount};
};

class DELPHICLASS TZAbstractObject;
class PASCALIMPLEMENTATION TZAbstractObject : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
public:
	virtual bool __fastcall Equals(const _di_IUnknown Value);
	int __fastcall Hash(void);
	virtual _di_IUnknown __fastcall Clone();
	virtual AnsiString __fastcall ToString();
	bool __fastcall InstanceOf(const GUID &IId);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZAbstractObject(void) : System::TInterfacedObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAbstractObject(void) { }
	#pragma option pop
	
private:
	void *__IZObject;	/* Zclasses::IZObject */
	
public:
	operator IZObject*(void) { return (IZObject*)&__IZObject; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zclasses */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zclasses;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZClasses
