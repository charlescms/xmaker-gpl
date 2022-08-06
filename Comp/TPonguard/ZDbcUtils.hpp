// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcUtils.pas' rev: 5.00

#ifndef ZDbcUtilsHPP
#define ZDbcUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString __fastcall ResolveConnectionProtocol(AnsiString Url, Zcompatibility::TStringDynArray 
	SupportedProtocols);
extern PACKAGE void __fastcall ResolveDatabaseUrl(AnsiString Url, Classes::TStrings* Info, AnsiString 
	&HostName, int &Port, AnsiString &Database, AnsiString &UserName, AnsiString &Password, Classes::TStrings* 
	ResultInfo);
extern PACKAGE bool __fastcall CheckConvertion(Zdbcintfs::TZSQLType InitialType, Zdbcintfs::TZSQLType 
	ResultType);
extern PACKAGE AnsiString __fastcall DefineColumnTypeName(Zdbcintfs::TZSQLType ColumnType);
extern PACKAGE void __fastcall RaiseSQLException(Sysutils::Exception* E);
extern PACKAGE void __fastcall CopyColumnsInfo(Contnrs::TObjectList* FromList, Contnrs::TObjectList* 
	ToList);
extern PACKAGE AnsiString __fastcall DefineStatementParameter(Zdbcintfs::_di_IZStatement Statement, 
	AnsiString ParamName, AnsiString Default);

}	/* namespace Zdbcutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcUtils
