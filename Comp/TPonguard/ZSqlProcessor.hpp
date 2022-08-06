// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSqlProcessor.pas' rev: 5.00

#ifndef ZSqlProcessorHPP
#define ZSqlProcessorHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZScriptParser.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZConnection.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsqlprocessor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZErrorHandleAction { eaFail, eaAbort, eaSkip, eaRetry };
#pragma option pop

class DELPHICLASS TZSQLProcessor;
typedef void __fastcall (__closure *TZProcessorNotifyEvent)(TZSQLProcessor* Processor, int StatementIndex
	);

typedef void __fastcall (__closure *TZProcessorErrorEvent)(TZSQLProcessor* Processor, int StatementIndex
	, Sysutils::Exception* E, TZErrorHandleAction &ErrorHandleAction);

class PASCALIMPLEMENTATION TZSQLProcessor : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStrings* FScript;
	Zscriptparser::TZSQLScriptParser* FScriptParser;
	Zconnection::TZConnection* FConnection;
	TZProcessorNotifyEvent FBeforeExecute;
	TZProcessorNotifyEvent FAfterExecute;
	TZProcessorErrorEvent FOnError;
	void __fastcall SetScript(Classes::TStrings* Value);
	int __fastcall GetStatementCount(void);
	AnsiString __fastcall GetStatement(int Index);
	void __fastcall SetConnection(Zconnection::TZConnection* Value);
	Zscriptparser::TZDelimiterType __fastcall GetDelimiterType(void);
	void __fastcall SetDelimiterType(Zscriptparser::TZDelimiterType Value);
	AnsiString __fastcall GetDelimiter();
	void __fastcall SetDelimiter(AnsiString Value);
	
protected:
	void __fastcall CheckConnected(void);
	TZErrorHandleAction __fastcall DoOnError(int StatementIndex, Sysutils::Exception* E);
	void __fastcall DoBeforeExecute(int StatementIndex);
	void __fastcall DoAfterExecute(int StatementIndex);
	
public:
	__fastcall virtual TZSQLProcessor(Classes::TComponent* AOwner);
	__fastcall virtual ~TZSQLProcessor(void);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall LoadFromFile(AnsiString FileName);
	void __fastcall Execute(void);
	void __fastcall Parse(void);
	void __fastcall Clear(void);
	__property int StatementCount = {read=GetStatementCount, nodefault};
	__property AnsiString Statements[int Index] = {read=GetStatement};
	
__published:
	__property Classes::TStrings* Script = {read=FScript, write=SetScript};
	__property Zconnection::TZConnection* Connection = {read=FConnection, write=SetConnection};
	__property Zscriptparser::TZDelimiterType DelimiterType = {read=GetDelimiterType, write=SetDelimiterType
		, default=0};
	__property AnsiString Delimiter = {read=GetDelimiter, write=SetDelimiter};
	__property TZProcessorErrorEvent OnError = {read=FOnError, write=FOnError};
	__property TZProcessorNotifyEvent AfterExecute = {read=FAfterExecute, write=FAfterExecute};
	__property TZProcessorNotifyEvent BeforeExecute = {read=FBeforeExecute, write=FBeforeExecute};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsqlprocessor */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsqlprocessor;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSqlProcessor
