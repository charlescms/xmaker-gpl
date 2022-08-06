// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZExprParser.pas' rev: 5.00

#ifndef ZExprParserHPP
#define ZExprParserHPP

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

namespace Zexprparser
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZExpressionTokenType { ttUnknown, ttLeftBrace, ttRightBrace, ttLeftSquareBrace, ttRightSquareBrace, 
	ttPlus, ttMinus, ttStar, ttSlash, ttProcent, ttPower, ttEqual, ttNotEqual, ttMore, ttLess, ttEqualMore, 
	ttEqualLess, ttAnd, ttOr, ttXor, ttIs, ttNull, ttNot, ttLike, ttNotLike, ttIsNull, ttIsNotNull, ttComma, 
	ttUnary, ttFunction, ttVariable, ttConstant };
#pragma option pop

class DELPHICLASS TZParseError;
class PASCALIMPLEMENTATION TZParseError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall TZParseError(const AnsiString Msg) : Sysutils::Exception(Msg
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall TZParseError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall TZParseError(int Ident)/* overload */ : Sysutils::Exception(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall TZParseError(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall TZParseError(const AnsiString Msg, int AHelpContext) : 
		Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall TZParseError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall TZParseError(int Ident, int AHelpContext)/* overload */
		 : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall TZParseError(System::PResStringRec ResStringRec, 
		const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZParseError(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionToken;
class PASCALIMPLEMENTATION TZExpressionToken : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TZExpressionTokenType FTokenType;
	#pragma pack(push, 1)
	Zvariant::TZVariant FValue;
	#pragma pack(pop)
	
	
public:
	__fastcall TZExpressionToken(TZExpressionTokenType TokenType, const Zvariant::TZVariant &Value);
	__property TZExpressionTokenType TokenType = {read=FTokenType, write=FTokenType, nodefault};
	__property Zvariant::TZVariant Value = {read=FValue, write=FValue};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZExpressionToken(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZExpressionParser;
class PASCALIMPLEMENTATION TZExpressionParser : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Ztokenizer::_di_IZTokenizer FTokenizer;
	AnsiString FExpression;
	Contnrs::TObjectList* FInitialTokens;
	int FTokenIndex;
	Contnrs::TObjectList* FResultTokens;
	Classes::TStrings* FVariables;
	bool __fastcall HasMoreTokens(void);
	TZExpressionToken* __fastcall GetToken(void);
	TZExpressionToken* __fastcall GetNextToken(void);
	void __fastcall ShiftToken(void);
	bool __fastcall CheckTokenTypes(const TZExpressionTokenType * TokenTypes, const int TokenTypes_Size
		);
	void __fastcall TokenizeExpression(void);
	void __fastcall SyntaxAnalyse(void);
	void __fastcall SyntaxAnalyse1(void);
	void __fastcall SyntaxAnalyse2(void);
	void __fastcall SyntaxAnalyse3(void);
	void __fastcall SyntaxAnalyse4(void);
	void __fastcall SyntaxAnalyse5(void);
	void __fastcall SyntaxAnalyse6(void);
	
public:
	__fastcall TZExpressionParser(Ztokenizer::_di_IZTokenizer Tokenizer);
	__fastcall virtual ~TZExpressionParser(void);
	void __fastcall Parse(AnsiString Expression);
	void __fastcall Clear(void);
	__property Ztokenizer::_di_IZTokenizer Tokenizer = {read=FTokenizer, write=FTokenizer};
	__property AnsiString Expression = {read=FExpression, write=Parse};
	__property Contnrs::TObjectList* ResultTokens = {read=FResultTokens};
	__property Classes::TStrings* Variables = {read=FVariables};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zexprparser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zexprparser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZExprParser
