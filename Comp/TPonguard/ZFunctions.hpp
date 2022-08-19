// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZFunctions.pas' rev: 5.00

#ifndef ZFunctionsHPP
#define ZFunctionsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZExpression.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zfunctions
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZFunctionsList;
class PASCALIMPLEMENTATION TZFunctionsList : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Zclasses::_di_IZCollection FFunctions;
	
protected:
	__property Zclasses::_di_IZCollection Functions = {read=FFunctions, write=FFunctions};
	
public:
	__fastcall TZFunctionsList(void);
	__fastcall virtual ~TZFunctionsList(void);
	int __fastcall GetCount(void);
	AnsiString __fastcall GetName(int Index);
	Zexpression::_di_IZFunction __fastcall GetFunction(int Index);
	void __fastcall Add(Zexpression::_di_IZFunction Func);
	void __fastcall Remove(AnsiString Name);
	int __fastcall FindByName(AnsiString Name);
	void __fastcall Clear(void);
private:
	void *__IZFunctionsList;	/* Zexpression::IZFunctionsList */
	
public:
	operator IZFunctionsList*(void) { return (IZFunctionsList*)&__IZFunctionsList; }
	
};


class DELPHICLASS TZAbstractFunction;
class PASCALIMPLEMENTATION TZAbstractFunction : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
protected:
	AnsiString FName;
	int __fastcall CheckParamsCount(Zexpression::TZExecutionStack* Stack, int ExpectedCount);
	
public:
	AnsiString __fastcall GetName();
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager) = 0 ;
	__property AnsiString Name = {read=GetName};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZAbstractFunction(void) : System::TInterfacedObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAbstractFunction(void) { }
	#pragma option pop
	
private:
	void *__IZFunction;	/* Zexpression::IZFunction */
	
public:
	operator IZFunction*(void) { return (IZFunction*)&__IZFunction; }
	
};


class DELPHICLASS TZTimeFunction;
class PASCALIMPLEMENTATION TZTimeFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZTimeFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZTimeFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZEmptyFunction;
class PASCALIMPLEMENTATION TZEmptyFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZEmptyFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZEmptyFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMinFunction;
class PASCALIMPLEMENTATION TZMinFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZMinFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMinFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZMaxFunction;
class PASCALIMPLEMENTATION TZMaxFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZMaxFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMaxFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZIIFFunction;
class PASCALIMPLEMENTATION TZIIFFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZIIFFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZIIFFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSUMFunction;
class PASCALIMPLEMENTATION TZSUMFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZSUMFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSUMFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZEFunction;
class PASCALIMPLEMENTATION TZEFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZEFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZEFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZPIFunction;
class PASCALIMPLEMENTATION TZPIFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZPIFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPIFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZRndFunction;
class PASCALIMPLEMENTATION TZRndFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZRndFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZRndFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZAbsFunction;
class PASCALIMPLEMENTATION TZAbsFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZAbsFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAbsFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZAcosFunction;
class PASCALIMPLEMENTATION TZAcosFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZAcosFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAcosFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZAsinFunction;
class PASCALIMPLEMENTATION TZAsinFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZAsinFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAsinFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZAtanFunction;
class PASCALIMPLEMENTATION TZAtanFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZAtanFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAtanFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZCeilFunction;
class PASCALIMPLEMENTATION TZCeilFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZCeilFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZCeilFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZFloorFunction;
class PASCALIMPLEMENTATION TZFloorFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZFloorFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZFloorFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZCosFunction;
class PASCALIMPLEMENTATION TZCosFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZCosFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZCosFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSinFunction;
class PASCALIMPLEMENTATION TZSinFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZSinFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSinFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZTanFunction;
class PASCALIMPLEMENTATION TZTanFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZTanFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZTanFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpFunction;
class PASCALIMPLEMENTATION TZExpFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZExpFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZLogFunction;
class PASCALIMPLEMENTATION TZLogFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZLogFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZLogFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZLog10Function;
class PASCALIMPLEMENTATION TZLog10Function : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZLog10Function(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZLog10Function(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZRoundFunction;
class PASCALIMPLEMENTATION TZRoundFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZRoundFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZRoundFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSqrFunction;
class PASCALIMPLEMENTATION TZSqrFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZSqrFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSqrFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZUpperFunction;
class PASCALIMPLEMENTATION TZUpperFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZUpperFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZUpperFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZLowerFunction;
class PASCALIMPLEMENTATION TZLowerFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZLowerFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZLowerFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZConcatFunction;
class PASCALIMPLEMENTATION TZConcatFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZConcatFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZConcatFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSubStrFunction;
class PASCALIMPLEMENTATION TZSubStrFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZSubStrFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSubStrFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZStrPosFunction;
class PASCALIMPLEMENTATION TZStrPosFunction : public TZAbstractFunction 
{
	typedef TZAbstractFunction inherited;
	
public:
	__fastcall TZStrPosFunction(void);
	virtual Zvariant::TZVariant __fastcall Execute(Zexpression::TZExecutionStack* Stack, Zvariant::_di_IZVariantManager 
		VariantManager);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZStrPosFunction(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZDefaultFunctionsList;
class PASCALIMPLEMENTATION TZDefaultFunctionsList : public TZFunctionsList 
{
	typedef TZFunctionsList inherited;
	
public:
	__fastcall TZDefaultFunctionsList(void);
public:
	#pragma option push -w-inl
	/* TZFunctionsList.Destroy */ inline __fastcall virtual ~TZDefaultFunctionsList(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zfunctions */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zfunctions;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZFunctions
