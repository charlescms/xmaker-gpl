// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZVariables.pas' rev: 5.00

#ifndef ZVariablesHPP
#define ZVariablesHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZExpression.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zvariables
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZVariable;
class PASCALIMPLEMENTATION TZVariable : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FName;
	#pragma pack(push, 1)
	Zvariant::TZVariant FValue;
	#pragma pack(pop)
	
	
public:
	__fastcall TZVariable(AnsiString Name, const Zvariant::TZVariant &Value);
	__property AnsiString Name = {read=FName, write=FName};
	__property Zvariant::TZVariant Value = {read=FValue, write=FValue};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZVariable(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZVariablesList;
class PASCALIMPLEMENTATION TZVariablesList : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Contnrs::TObjectList* FVariables;
	
public:
	__fastcall TZVariablesList(void);
	__fastcall virtual ~TZVariablesList(void);
	int __fastcall GetCount(void);
	AnsiString __fastcall GetName(int Index);
	Zvariant::TZVariant __fastcall GetValue(int Index);
	void __fastcall SetValue(int Index, const Zvariant::TZVariant &Value);
	Zvariant::TZVariant __fastcall GetValueByName(AnsiString Name);
	void __fastcall SetValueByName(AnsiString Name, const Zvariant::TZVariant &Value);
	void __fastcall Add(AnsiString Name, const Zvariant::TZVariant &Value);
	void __fastcall Remove(AnsiString Name);
	int __fastcall FindByName(AnsiString Name);
	void __fastcall ClearValues(void);
	void __fastcall Clear(void);
private:
	void *__IZVariablesList;	/* Zexpression::IZVariablesList */
	
public:
	operator IZVariablesList*(void) { return (IZVariablesList*)&__IZVariablesList; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zvariables */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zvariables;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZVariables
