// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcPostgreSqlUtils.pas' rev: 5.00

#ifndef ZDbcPostgreSqlUtilsHPP
#define ZDbcPostgreSqlUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZDbcPostgreSql.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZPlainPostgreSqlDriver.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcpostgresqlutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::TZSQLType __fastcall PostgreSQLToSQLType(Zdbcpostgresql::_di_IZPostgreSQLConnection 
	Connection, AnsiString TypeName);
extern PACKAGE bool __fastcall IsNumber(Zdbcintfs::TZSQLType Value);
extern PACKAGE AnsiString __fastcall EscapeQuotes(const AnsiString Value);
extern PACKAGE AnsiString __fastcall EncodeString(AnsiString Value);
extern PACKAGE AnsiString __fastcall DecodeString(AnsiString Value);
extern PACKAGE void __fastcall CheckPostgreSQLError(Zdbcintfs::_di_IZConnection Connection, Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver 
	PlainDriver, void * Handle, Zdbclogging::TZLoggingCategory LogCategory, AnsiString LogMessage);
extern PACKAGE Word __fastcall GetMinorVersion(AnsiString Value);

}	/* namespace Zdbcpostgresqlutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcpostgresqlutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcPostgreSqlUtils
