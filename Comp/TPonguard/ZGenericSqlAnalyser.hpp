// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZGenericSqlAnalyser.pas' rev: 5.00

#ifndef ZGenericSqlAnalyserHPP
#define ZGenericSqlAnalyserHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZSelectSchema.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zgenericsqlanalyser
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZStatementSection;
class PASCALIMPLEMENTATION TZStatementSection : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FName;
	Classes::TStrings* FTokens;
	
public:
	__fastcall TZStatementSection(AnsiString Name, Classes::TStrings* Tokens);
	__fastcall virtual ~TZStatementSection(void);
	TZStatementSection* __fastcall Clone(void);
	__property AnsiString Name = {read=FName, write=FName};
	__property Classes::TStrings* Tokens = {read=FTokens};
};


__interface IZStatementAnalyser;
typedef System::DelphiInterface<IZStatementAnalyser> _di_IZStatementAnalyser;
__interface INTERFACE_UUID("{967635B6-411B-4DEF-990C-9C6C01F3DC0A}") IZStatementAnalyser  : public IUnknown 
	
{
	
public:
	virtual Classes::TStrings* __fastcall TokenizeQuery(Ztokenizer::_di_IZTokenizer Tokenizer, AnsiString 
		SQL, bool Cleanup) = 0 ;
	virtual Contnrs::TObjectList* __fastcall SplitSections(Classes::TStrings* Tokens) = 0 ;
	virtual AnsiString __fastcall ComposeTokens(Classes::TStrings* Tokens) = 0 ;
	virtual AnsiString __fastcall ComposeSections(Contnrs::TObjectList* Sections) = 0 ;
	virtual Zselectschema::_di_IZSelectSchema __fastcall DefineSelectSchemaFromSections(Contnrs::TObjectList* 
		Sections) = 0 ;
	virtual Zselectschema::_di_IZSelectSchema __fastcall DefineSelectSchemaFromQuery(Ztokenizer::_di_IZTokenizer 
		Tokenizer, AnsiString SQL) = 0 ;
};

class DELPHICLASS TZGenericStatementAnalyser;
class PASCALIMPLEMENTATION TZGenericStatementAnalyser : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Classes::TStrings* FSectionNames;
	Classes::TStrings* FSelectOptions;
	Classes::TStrings* FFromJoins;
	Classes::TStrings* FFromClauses;
	
protected:
	Classes::TStrings* __fastcall ArrayToStrings(const AnsiString * Value, const int Value_Size);
	bool __fastcall CheckForKeyword(Classes::TStrings* Tokens, int TokenIndex, Classes::TStrings* Keywords
		, AnsiString &Keyword, int &WordCount);
	Classes::TStrings* __fastcall FindSectionTokens(Contnrs::TObjectList* Sections, AnsiString Name);
	void __fastcall FillFieldRefs(Zselectschema::_di_IZSelectSchema SelectSchema, Classes::TStrings* SelectTokens
		);
	void __fastcall FillTableRefs(Zselectschema::_di_IZSelectSchema SelectSchema, Classes::TStrings* FromTokens
		);
	bool __fastcall SkipOptionTokens(Classes::TStrings* Tokens, int &TokenIndex, Classes::TStrings* Options
		);
	bool __fastcall SkipBracketTokens(Classes::TStrings* Tokens, int &TokenIndex);
	__property Classes::TStrings* SectionNames = {read=FSectionNames, write=FSectionNames};
	__property Classes::TStrings* SelectOptions = {read=FSelectOptions, write=FSelectOptions};
	__property Classes::TStrings* FromJoins = {read=FFromJoins, write=FFromJoins};
	__property Classes::TStrings* FromClauses = {read=FFromClauses, write=FFromClauses};
	
public:
	__fastcall TZGenericStatementAnalyser(void);
	__fastcall virtual ~TZGenericStatementAnalyser(void);
	Classes::TStrings* __fastcall TokenizeQuery(Ztokenizer::_di_IZTokenizer Tokenizer, AnsiString SQL, 
		bool Cleanup);
	Contnrs::TObjectList* __fastcall SplitSections(Classes::TStrings* Tokens);
	AnsiString __fastcall ComposeTokens(Classes::TStrings* Tokens);
	AnsiString __fastcall ComposeSections(Contnrs::TObjectList* Sections);
	Zselectschema::_di_IZSelectSchema __fastcall DefineSelectSchemaFromSections(Contnrs::TObjectList* Sections
		);
	Zselectschema::_di_IZSelectSchema __fastcall DefineSelectSchemaFromQuery(Ztokenizer::_di_IZTokenizer 
		Tokenizer, AnsiString SQL);
private:
	void *__IZStatementAnalyser;	/* Zgenericsqlanalyser::IZStatementAnalyser */
	
public:
	operator IZStatementAnalyser*(void) { return (IZStatementAnalyser*)&__IZStatementAnalyser; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zgenericsqlanalyser */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zgenericsqlanalyser;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZGenericSqlAnalyser
