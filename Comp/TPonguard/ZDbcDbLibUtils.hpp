// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcDbLibUtils.pas' rev: 5.00

#ifndef ZDbcDbLibUtilsHPP
#define ZDbcDbLibUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcdblibutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertODBCToSqlType(short FieldType);
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertDBLibToSqlType(short FieldType);
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertDBLibTypeToSqlType(AnsiString Value);
extern PACKAGE int __fastcall ConvertSqlTypeToDBLibType(Zdbcintfs::TZSQLType FieldType);
extern PACKAGE AnsiString __fastcall ConvertSqlTypeToDBLibTypeName(Zdbcintfs::TZSQLType FieldType);
extern PACKAGE Zdbcintfs::TZColumnNullableType __fastcall ConvertDBLibNullability(Byte DBLibNullability
	);
extern PACKAGE AnsiString __fastcall PrepareSQLParameter(const Zvariant::TZVariant &Value, Zdbcintfs::TZSQLType 
	ParamType);

}	/* namespace Zdbcdblibutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcdblibutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcDbLibUtils
