// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZScriptParser.pas' rev: 5.00

#ifndef ZScriptParserHPP
#define ZScriptParserHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZTokenizer.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zscriptparser
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZDelimiterType { dtDefault, dtGo, dtSetTerm, dtEmptyLine };
#pragma option pop

class DELPHICLASS TZSQLScriptParser;
class PASCALIMPLEMENTATION TZSQLScriptParser : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FDelimiter;
	TZDelimiterType FDelimiterType;
	bool FCleanupStatements;
	Ztokenizer::_di_IZTokenizer FTokenizer;
	AnsiString FUncompletedStatement;
	Classes::TStrings* FStatements;
	int __fastcall GetStatementCount(void);
	AnsiString __fastcall GetStatement(int Index);
	
public:
	__fastcall TZSQLScriptParser(void);
	__fastcall TZSQLScriptParser(Ztokenizer::_di_IZTokenizer Tokenizer);
	__fastcall virtual ~TZSQLScriptParser(void);
	void __fastcall Clear(void);
	void __fastcall ClearCompleted(void);
	void __fastcall ClearUncompleted(void);
	void __fastcall ParseText(AnsiString Text);
	void __fastcall ParseLine(AnsiString Line);
	__property AnsiString Delimiter = {read=FDelimiter, write=FDelimiter};
	__property TZDelimiterType DelimiterType = {read=FDelimiterType, write=FDelimiterType, default=0};
	__property bool CleanupStatements = {read=FCleanupStatements, write=FCleanupStatements, default=1};
		
	__property Ztokenizer::_di_IZTokenizer Tokenizer = {read=FTokenizer, write=FTokenizer};
	__property AnsiString UncompletedStatement = {read=FUncompletedStatement};
	__property int StatementCount = {read=GetStatementCount, nodefault};
	__property AnsiString Statements[int Index] = {read=GetStatement};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zscriptparser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zscriptparser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZScriptParser
