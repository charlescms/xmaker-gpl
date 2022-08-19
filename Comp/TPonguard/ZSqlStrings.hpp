// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSqlStrings.pas' rev: 5.00

#ifndef ZSqlStringsHPP
#define ZSqlStringsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZGenericSqlToken.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsqlstrings
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZSQLStatement;
class PASCALIMPLEMENTATION TZSQLStatement : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FSQL;
	DynamicArray<int >  FParamIndices;
	Classes::TStrings* FParams;
	int __fastcall GetParamCount(void);
	AnsiString __fastcall GetParamName(int Index);
	Zcompatibility::TStringDynArray __fastcall GetParamNamesArray();
	
protected:
	__fastcall TZSQLStatement(AnsiString SQL, Zcompatibility::TIntegerDynArray ParamIndices, Classes::TStrings* 
		Params);
	
public:
	__property AnsiString SQL = {read=FSQL};
	__property int ParamCount = {read=GetParamCount, nodefault};
	__property AnsiString ParamNames[int Index] = {read=GetParamName};
	__property Zcompatibility::TIntegerDynArray ParamIndices = {read=FParamIndices};
	__property Zcompatibility::TStringDynArray ParamNamesArray = {read=GetParamNamesArray};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSQLStatement(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSQLStrings;
class PASCALIMPLEMENTATION TZSQLStrings : public Classes::TStringList 
{
	typedef Classes::TStringList inherited;
	
private:
	Ztokenizer::_di_IZTokenizer FTokenizer;
	bool FParamCheck;
	Contnrs::TObjectList* FStatements;
	Classes::TStringList* FParams;
	bool FMultiStatements;
	int __fastcall GetParamCount(void);
	AnsiString __fastcall GetParamName(int Index);
	TZSQLStatement* __fastcall GetStatement(int Index);
	int __fastcall GetStatementCount(void);
	void __fastcall SetTokenizer(Ztokenizer::_di_IZTokenizer Value);
	void __fastcall SetParamCheck(bool Value);
	void __fastcall SetMultiStatements(bool Value);
	
protected:
	virtual void __fastcall Changed(void);
	int __fastcall FindParam(AnsiString ParamName);
	void __fastcall RebuildAll(void);
	
public:
	__fastcall TZSQLStrings(Ztokenizer::_di_IZTokenizer Tokenizer);
	__fastcall virtual ~TZSQLStrings(void);
	__property Ztokenizer::_di_IZTokenizer Tokenizer = {read=FTokenizer, write=SetTokenizer};
	__property bool ParamCheck = {read=FParamCheck, write=SetParamCheck, nodefault};
	__property int ParamCount = {read=GetParamCount, nodefault};
	__property AnsiString ParamNames[int Index] = {read=GetParamName};
	__property int StatementCount = {read=GetStatementCount, nodefault};
	__property TZSQLStatement* Statements[int Index] = {read=GetStatement};
	__property bool MultiStatements = {read=FMultiStatements, write=SetMultiStatements, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsqlstrings */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsqlstrings;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSqlStrings
