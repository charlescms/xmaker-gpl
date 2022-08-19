// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcMySqlUtils.pas' rev: 5.00

#ifndef ZDbcMySqlUtilsHPP
#define ZDbcMySqlUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZPlainMySqlDriver.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcmysqlutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
static const Word MAXBUF = 0xffff;
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertMySQLHandleToSQLType(Zplainmysqldriver::_di_IZMySQLPlainDriver 
	PlainDriver, void * FieldHandle, int FieldFlags);
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertMySQLTypeToSQLType(AnsiString TypeName, AnsiString 
	TypeNameFull);
extern PACKAGE System::TDateTime __fastcall MySQLTimestampToDateTime(AnsiString Value);
extern PACKAGE void __fastcall CheckMySQLError(Zplainmysqldriver::_di_IZMySQLPlainDriver PlainDriver
	, void * Handle, Zdbclogging::TZLoggingCategory LogCategory, AnsiString LogMessage);

}	/* namespace Zdbcmysqlutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcmysqlutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcMySqlUtils
