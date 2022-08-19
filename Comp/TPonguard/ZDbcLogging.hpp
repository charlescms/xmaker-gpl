// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcLogging.pas' rev: 5.00

#ifndef ZDbcLoggingHPP
#define ZDbcLoggingHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbclogging
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZLoggingCategory { lcConnect, lcDisconnect, lcTransaction, lcExecute, lcOther };
#pragma option pop

class DELPHICLASS TZLoggingEvent;
class PASCALIMPLEMENTATION TZLoggingEvent : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TZLoggingCategory FCategory;
	AnsiString FProtocol;
	AnsiString FMessage;
	int FErrorCode;
	AnsiString FError;
	System::TDateTime FTimestamp;
	
public:
	__fastcall TZLoggingEvent(TZLoggingCategory Category, AnsiString Protocol, AnsiString Msg, int ErrorCode
		, AnsiString Error);
	AnsiString __fastcall AsString();
	__property TZLoggingCategory Category = {read=FCategory, nodefault};
	__property AnsiString Protocol = {read=FProtocol};
	__property AnsiString Message = {read=FMessage};
	__property int ErrorCode = {read=FErrorCode, nodefault};
	__property AnsiString Error = {read=FError};
	__property System::TDateTime Timestamp = {read=FTimestamp};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZLoggingEvent(void) { }
	#pragma option pop
	
};


__interface IZLoggingListener;
typedef System::DelphiInterface<IZLoggingListener> _di_IZLoggingListener;
__interface INTERFACE_UUID("{53559F5F-AC22-4DDC-B2EA-45D21ADDD2D4}") IZLoggingListener  : public IUnknown 
	
{
	
public:
	virtual void __fastcall LogEvent(TZLoggingEvent* Event) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbclogging */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbclogging;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcLogging
