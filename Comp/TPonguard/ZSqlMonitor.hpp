// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSqlMonitor.pas' rev: 5.00

#ifndef ZSqlMonitorHPP
#define ZSqlMonitorHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsqlmonitor
{
//-- type declarations -------------------------------------------------------
typedef TZLoggingEvent TZLoggingEvent;
;

typedef void __fastcall (__closure *TZTraceEvent)(System::TObject* Sender, Zdbclogging::TZLoggingEvent* 
	Event, bool &LogTrace);

typedef void __fastcall (__closure *TZTraceLogEvent)(System::TObject* Sender, Zdbclogging::TZLoggingEvent* 
	Event);

class DELPHICLASS TZSQLMonitor;
class PASCALIMPLEMENTATION TZSQLMonitor : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool FActive;
	bool FAutoSave;
	AnsiString FFileName;
	int FMaxTraceCount;
	Contnrs::TObjectList* FTraceList;
	TZTraceEvent FOnTrace;
	TZTraceLogEvent FOnLogTrace;
	int __fastcall GetTraceCount(void);
	Zdbclogging::TZLoggingEvent* __fastcall GetTraceItem(int Index);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetMaxTraceCount(const int Value);
	void __fastcall TruncateTraceList(int Count);
	void __fastcall DoTrace(Zdbclogging::TZLoggingEvent* Event, bool &LogTrace);
	void __fastcall DoLogTrace(Zdbclogging::TZLoggingEvent* Event);
	
public:
	__fastcall virtual TZSQLMonitor(Classes::TComponent* AOwner);
	__fastcall virtual ~TZSQLMonitor(void);
	void __fastcall LogEvent(Zdbclogging::TZLoggingEvent* Event);
	void __fastcall Save(void);
	void __fastcall SaveToFile(AnsiString FileName);
	__property int TraceCount = {read=GetTraceCount, nodefault};
	__property Zdbclogging::TZLoggingEvent* TraceList[int Index] = {read=GetTraceItem};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property bool AutoSave = {read=FAutoSave, write=FAutoSave, default=0};
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property int MaxTraceCount = {read=FMaxTraceCount, write=SetMaxTraceCount, nodefault};
	__property TZTraceEvent OnTrace = {read=FOnTrace, write=FOnTrace};
	__property TZTraceLogEvent OnLogTrace = {read=FOnLogTrace, write=FOnLogTrace};
private:
	void *__IZLoggingListener;	/* Zdbclogging::IZLoggingListener */
	
public:
	operator IUnknown*(void) { return (IUnknown*)&__IZLoggingListener; }
	operator IZLoggingListener*(void) { return (IZLoggingListener*)&__IZLoggingListener; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsqlmonitor */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsqlmonitor;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSqlMonitor
