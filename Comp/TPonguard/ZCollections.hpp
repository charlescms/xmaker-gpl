// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZCollections.pas' rev: 5.00

#ifndef ZCollectionsHPP
#define ZCollectionsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zcollections
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZIterator;
class PASCALIMPLEMENTATION TZIterator : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Zclasses::_di_IZCollection FCollection;
	int FCurrentIndex;
	
public:
	__fastcall TZIterator(const Zclasses::_di_IZCollection Col);
	bool __fastcall HasNext(void);
	_di_IUnknown __fastcall Next();
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZIterator(void) { }
	#pragma option pop
	
private:
	void *__IZIterator;	/* Zclasses::IZIterator */
	
public:
	operator IZIterator*(void) { return (IZIterator*)&__IZIterator; }
	
};


typedef _di_IUnknown TZInterfaceList[134217727];

typedef _di_IUnknown *PZInterfaceList;

class DELPHICLASS TZCollection;
class PASCALIMPLEMENTATION TZCollection : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	_di_IUnknown *FList;
	int FCount;
	int FCapacity;
	
protected:
	/*         class method */ static void __fastcall Error(TMetaClass* vmt, const AnsiString Msg, int 
		Data);
	void __fastcall Grow(void);
	void __fastcall SetCapacity(int NewCapacity);
	void __fastcall SetCount(int NewCount);
	
public:
	__fastcall TZCollection(void);
	__fastcall virtual ~TZCollection(void);
	virtual _di_IUnknown __fastcall Clone();
	virtual AnsiString __fastcall ToString();
	_di_IUnknown __fastcall Get(int Index);
	void __fastcall Put(int Index, const _di_IUnknown Item);
	int __fastcall IndexOf(const _di_IUnknown Item);
	int __fastcall GetCount(void);
	Zclasses::_di_IZIterator __fastcall GetIterator();
	_di_IUnknown __fastcall First();
	_di_IUnknown __fastcall Last();
	int __fastcall Add(const _di_IUnknown Item);
	void __fastcall Insert(int Index, const _di_IUnknown Item);
	int __fastcall Remove(const _di_IUnknown Item);
	void __fastcall Exchange(int Index1, int Index2);
	void __fastcall Delete(int Index);
	void __fastcall Clear(void);
	bool __fastcall Contains(const _di_IUnknown Item);
	bool __fastcall ContainsAll(const Zclasses::_di_IZCollection Col);
	bool __fastcall AddAll(const Zclasses::_di_IZCollection Col);
	bool __fastcall RemoveAll(const Zclasses::_di_IZCollection Col);
	__property int Count = {read=GetCount, nodefault};
	__property _di_IUnknown Items[int Index] = {read=Get, write=Put/*, default*/};
private:
	void *__IZCollection;	/* Zclasses::IZCollection */
	
public:
	operator IZClonnable*(void) { return (IZClonnable*)&__IZCollection; }
	operator IZCollection*(void) { return (IZCollection*)&__IZCollection; }
	
};


class DELPHICLASS TZUnmodifiableCollection;
class PASCALIMPLEMENTATION TZUnmodifiableCollection : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Zclasses::_di_IZCollection FCollection;
	void __fastcall RaiseException(void);
	
public:
	__fastcall TZUnmodifiableCollection(Zclasses::_di_IZCollection Collection);
	__fastcall virtual ~TZUnmodifiableCollection(void);
	virtual _di_IUnknown __fastcall Clone();
	virtual AnsiString __fastcall ToString();
	_di_IUnknown __fastcall Get(int Index);
	void __fastcall Put(int Index, const _di_IUnknown Item);
	int __fastcall IndexOf(const _di_IUnknown Item);
	int __fastcall GetCount(void);
	Zclasses::_di_IZIterator __fastcall GetIterator();
	_di_IUnknown __fastcall First();
	_di_IUnknown __fastcall Last();
	int __fastcall Add(const _di_IUnknown Item);
	void __fastcall Insert(int Index, const _di_IUnknown Item);
	int __fastcall Remove(const _di_IUnknown Item);
	void __fastcall Exchange(int Index1, int Index2);
	void __fastcall Delete(int Index);
	void __fastcall Clear(void);
	bool __fastcall Contains(const _di_IUnknown Item);
	bool __fastcall ContainsAll(const Zclasses::_di_IZCollection Col);
	bool __fastcall AddAll(const Zclasses::_di_IZCollection Col);
	bool __fastcall RemoveAll(const Zclasses::_di_IZCollection Col);
	__property int Count = {read=GetCount, nodefault};
	__property _di_IUnknown Items[int Index] = {read=Get, write=Put/*, default*/};
private:
	void *__IZCollection;	/* Zclasses::IZCollection */
	
public:
	operator IZClonnable*(void) { return (IZClonnable*)&__IZCollection; }
	operator IZCollection*(void) { return (IZCollection*)&__IZCollection; }
	
};


class DELPHICLASS TZHashMap;
class PASCALIMPLEMENTATION TZHashMap : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Zclasses::_di_IZCollection FKeys;
	Zclasses::_di_IZCollection FReadOnlyKeys;
	Zclasses::_di_IZCollection FValues;
	Zclasses::_di_IZCollection FReadOnlyValues;
	
public:
	__fastcall TZHashMap(void);
	__fastcall virtual ~TZHashMap(void);
	virtual _di_IUnknown __fastcall Clone();
	_di_IUnknown __fastcall Get(const _di_IUnknown Key);
	void __fastcall Put(const _di_IUnknown Key, const _di_IUnknown Value);
	Zclasses::_di_IZCollection __fastcall GetKeys();
	Zclasses::_di_IZCollection __fastcall GetValues();
	int __fastcall GetCount(void);
	bool __fastcall Remove(_di_IUnknown Key);
	void __fastcall Clear(void);
	__property int Count = {read=GetCount, nodefault};
	__property Zclasses::_di_IZCollection Keys = {read=GetKeys};
	__property Zclasses::_di_IZCollection Values = {read=GetValues};
private:
	void *__IZHashMap;	/* Zclasses::IZHashMap */
	
public:
	operator IZClonnable*(void) { return (IZClonnable*)&__IZHashMap; }
	operator IZHashMap*(void) { return (IZHashMap*)&__IZHashMap; }
	
};


class DELPHICLASS TZStack;
class PASCALIMPLEMENTATION TZStack : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Zclasses::_di_IZCollection FValues;
	
public:
	__fastcall TZStack(void);
	__fastcall virtual ~TZStack(void);
	virtual _di_IUnknown __fastcall Clone();
	virtual AnsiString __fastcall ToString();
	_di_IUnknown __fastcall Peek();
	_di_IUnknown __fastcall Pop();
	void __fastcall Push(_di_IUnknown Value);
	int __fastcall GetCount(void);
	__property int Count = {read=GetCount, nodefault};
private:
	void *__IZStack;	/* Zclasses::IZStack */
	
public:
	operator IZClonnable*(void) { return (IZClonnable*)&__IZStack; }
	operator IZStack*(void) { return (IZStack*)&__IZStack; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zcollections */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zcollections;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZCollections
