// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcAdoUtils.pas' rev: 5.00

#ifndef ZDbcAdoUtilsHPP
#define ZDbcAdoUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcadoutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE _di_IMalloc ZAdoMalloc;
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertAdoToSqlType(short FieldType);
extern PACKAGE int __fastcall ConvertSqlTypeToAdo(Zdbcintfs::TZSQLType FieldType);
extern PACKAGE int __fastcall ConvertVariantToAdo(int VT);
extern PACKAGE int __fastcall ConvertResultSetTypeToAdo(Zdbcintfs::TZResultSetType ResultSetType);
extern PACKAGE int __fastcall ConvertResultSetConcurrencyToAdo(Zdbcintfs::TZResultSetConcurrency ResultSetConcurrency
	);
extern PACKAGE int __fastcall ConvertOleDBToAdoSchema(const GUID &OleDBSchema);
extern PACKAGE WideString __fastcall PromptDataSource(unsigned Handle, WideString InitialString);

}	/* namespace Zdbcadoutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcadoutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcAdoUtils
