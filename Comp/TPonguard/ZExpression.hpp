// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZExpression.pas' rev: 5.00

#ifndef ZExpressionHPP
#define ZExpressionHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zexpression
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZExpressionError;
class PASCALIMPLEMENTATION TZExpressionError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall TZExpressionError(const AnsiString Msg) : Sysutils::Exception(
		Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall TZExpressionError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall TZExpressionError(int Ident)/* overload */ : Sysutils::Exception(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall TZExpressionError(int Ident, const System::TVarRec * 
		Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall TZExpressionError(const AnsiString Msg, int AHelpContext
		) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall TZExpressionError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall TZExpressionError(int Ident, int AHelpContext)/* overload */
		 : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall TZExpressionError(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpressionError(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExecutionStack;
class PASCALIMPLEMENTATION TZExecutionStack : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<Zvariant::TZVariant >  FValues;
	int FCount;
	int FCapacity;
	Zvariant::TZVariant __fastcall GetValue(int Index);
	
public:
	__fastcall TZExecutionStack(void);
	Zvariant::TZVariant __fastcall Pop();
	Zvariant::TZVariant __fastcall Peek();
	void __fastcall Push(const Zvariant::TZVariant &Value);
	Zvariant::TZVariant __fastcall GetParameter(int Index);
	void __fastcall Swap(void);
	void __fastcall Clear(void);
	__property int Count = {read=FCount, nodefault};
	__property Zvariant::TZVariant Values[int Index] = {read=GetValue};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExecutionStack(void) { }
	#pragma option pop
	
};


__interface IZVariablesList;
typedef System::DelphiInterface<IZVariablesList> _di_IZVariablesList;
__interface INTERFACE_UUID("{F4347F46-32F3-4021-B6DB-7A39BF171275}") IZVariablesList  : public IUnknown 
	
{
	
public:
	virtual int __fastcall GetCount(void) = 0 ;
	virtual AnsiString __fastcall GetName(int Index) = 0 ;
	virtual Zvariant::TZVariant __fastcall GetValue(int Index) = 0 ;
	virtual void __fastcall SetValue(int Index, const Zvariant::TZVariant &Value) = 0 ;
	virtual Zvariant::TZVariant __fastcall GetValueByName(AnsiString Name) = 0 ;
	virtual void __fastcall SetValueByName(AnsiString Name, const Zvariant::TZVariant &Value) = 0 ;
	virtual void __fastcall Add(AnsiString Name, const Zvariant::TZVariant &Value) = 0 ;
	virtual void __fastcall Remove(AnsiString Name) = 0 ;
	virtual int __fastcall FindByName(AnsiString Name) = 0 ;
	virtual void __fastcall ClearValues(void) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	__property int Count = {read=GetCount};
	__property AnsiString Names[int Index] = {read=GetName};
	__property Zvariant::TZVariant Values[int Index] = {read=GetValue, write=SetValue};
	__property Zvariant::TZVariant NamedValues[AnsiString Index] = {read=GetValueByName, write=SetValueByName
		};
};

__interface IZFunction;
typedef System::DelphiInterface<IZFunction> _di_IZFunction;
__interface INTERFACE_UUID("{E9B3AFF9-6CD9-49C8-AB66-C8CF60ED8686}") IZFunction  : public IUnknown 
{
	
public:
	virtual AnsiString __fastcall GetName(void) = 0 ;
	virtual Zvariant::TZVariant __fastcall Execute(TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager) = 0 ;
	__property AnsiString Name = {read=GetName};
};

__interface IZFunctionsList;
typedef System::DelphiInterface<IZFunctionsList> _di_IZFunctionsList;
__interface INTERFACE_UUID("{54453054-F012-475B-84C3-7E5C46187FDB}") IZFunctionsList  : public IUnknown 
	
{
	
public:
	virtual int __fastcall GetCount(void) = 0 ;
	virtual AnsiString __fastcall GetName(int Index) = 0 ;
	virtual _di_IZFunction __fastcall GetFunction(int Index) = 0 ;
	virtual void __fastcall Add(_di_IZFunction Func) = 0 ;
	virtual void __fastcall Remove(AnsiString Name) = 0 ;
	virtual int __fastcall FindByName(AnsiString Name) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	__property int Count = {read=GetCount};
	__property AnsiString Names[int Index] = {read=GetName};
	__property _di_IZFunction Functions[int Index] = {read=GetFunction};
};

__interface IZExpression;
typedef System::DelphiInterface<IZExpression> _di_IZExpression;
__interface INTERFACE_UUID("{26F9D379-5618-446C-8999-D50FBB2F8560}") IZExpression  : public IUnknown 
	
{
	
public:
	virtual Ztokenizer::_di_IZTokenizer __fastcall GetTokenizer(void) = 0 ;
	virtual void __fastcall SetTokenizer(Ztokenizer::_di_IZTokenizer Value) = 0 ;
	virtual AnsiString __fastcall GetExpression(void) = 0 ;
	virtual void __fastcall SetExpression(AnsiString Value) = 0 ;
	virtual Zvariant::_di_IZVariantManager __fastcall GetVariantManager(void) = 0 ;
	virtual void __fastcall SetVariantManager(Zvariant::_di_IZVariantManager Value) = 0 ;
	virtual _di_IZVariablesList __fastcall GetDefaultVariables(void) = 0 ;
	virtual void __fastcall SetDefaultVariables(_di_IZVariablesList Value) = 0 ;
	virtual _di_IZFunctionsList __fastcall GetDefaultFunctions(void) = 0 ;
	virtual void __fastcall SetDefaultFunctions(_di_IZFunctionsList Value) = 0 ;
	virtual bool __fastcall GetAutoVariables(void) = 0 ;
	virtual void __fastcall SetAutoVariables(bool Value) = 0 ;
	virtual Zvariant::TZVariant __fastcall Evaluate(void) = 0 ;
	virtual Zvariant::TZVariant __fastcall Evaluate2(_di_IZVariablesList Variables) = 0 ;
	virtual Zvariant::TZVariant __fastcall Evaluate3(_di_IZVariablesList Variables, _di_IZFunctionsList 
		Functions) = 0 ;
	virtual Zvariant::TZVariant __fastcall Evaluate4(_di_IZVariablesList Variables, _di_IZFunctionsList 
		Functions, TZExecutionStack* Stack) = 0 ;
	virtual void __fastcall CreateVariables(_di_IZVariablesList Variables) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	__property Ztokenizer::_di_IZTokenizer Tokenizer = {read=GetTokenizer, write=SetTokenizer};
	__property AnsiString Expression = {read=GetExpression, write=SetExpression};
	__property Zvariant::_di_IZVariantManager VariantManager = {read=GetVariantManager, write=SetVariantManager
		};
	__property _di_IZVariablesList DefaultVariables = {read=GetDefaultVariables, write=SetDefaultVariables
		};
	__property _di_IZFunctionsList DefaultFunctions = {read=GetDefaultFunctions, write=SetDefaultFunctions
		};
	__property bool AutoVariables = {read=GetAutoVariables, write=SetAutoVariables};
};

class DELPHICLASS TZExpression;
class PASCALIMPLEMENTATION TZExpression : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Ztokenizer::_di_IZTokenizer FTokenizer;
	_di_IZVariablesList FDefaultVariables;
	_di_IZFunctionsList FDefaultFunctions;
	Zvariant::_di_IZVariantManager FVariantManager;
	System::TObject* FParser;
	bool FAutoVariables;
	Ztokenizer::_di_IZTokenizer __fastcall GetTokenizer();
	void __fastcall SetTokenizer(Ztokenizer::_di_IZTokenizer Value);
	AnsiString __fastcall GetExpression();
	void __fastcall SetExpression(AnsiString Value);
	Zvariant::_di_IZVariantManager __fastcall GetVariantManager();
	void __fastcall SetVariantManager(Zvariant::_di_IZVariantManager Value);
	_di_IZVariablesList __fastcall GetDefaultVariables();
	void __fastcall SetDefaultVariables(_di_IZVariablesList Value);
	_di_IZFunctionsList __fastcall GetDefaultFunctions();
	void __fastcall SetDefaultFunctions(_di_IZFunctionsList Value);
	bool __fastcall GetAutoVariables(void);
	void __fastcall SetAutoVariables(bool Value);
	
public:
	__fastcall TZExpression(void);
	__fastcall TZExpression(AnsiString Expression);
	__fastcall virtual ~TZExpression(void);
	Zvariant::TZVariant __fastcall Evaluate();
	Zvariant::TZVariant __fastcall Evaluate2(_di_IZVariablesList Variables);
	Zvariant::TZVariant __fastcall Evaluate3(_di_IZVariablesList Variables, _di_IZFunctionsList Functions
		);
	Zvariant::TZVariant __fastcall Evaluate4(_di_IZVariablesList Variables, _di_IZFunctionsList Functions
		, TZExecutionStack* Stack);
	void __fastcall CreateVariables(_di_IZVariablesList Variables);
	void __fastcall Clear(void);
	__property AnsiString Expression = {read=GetExpression, write=SetExpression};
	__property Zvariant::_di_IZVariantManager VariantManager = {read=GetVariantManager, write=SetVariantManager
		};
	__property _di_IZVariablesList DefaultVariables = {read=GetDefaultVariables, write=SetDefaultVariables
		};
	__property _di_IZFunctionsList DefaultFunctions = {read=GetDefaultFunctions, write=SetDefaultFunctions
		};
	__property bool AutoVariables = {read=GetAutoVariables, write=SetAutoVariables, nodefault};
private:
		
	void *__IZExpression;	/* Zexpression::IZExpression */
	
public:
	operator IZExpression*(void) { return (IZExpression*)&__IZExpression; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zexpression */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zexpression;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZExpression
