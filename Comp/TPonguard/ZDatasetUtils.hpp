// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDatasetUtils.pas' rev: 5.00

#ifndef ZDatasetUtilsHPP
#define ZDatasetUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZExpression.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdatasetutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Ztokenizer::_di_IZTokenizer CommonTokenizer;
extern PACKAGE Db::TFieldType __fastcall ConvertDbcToDatasetType(Zdbcintfs::TZSQLType Value);
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertDatasetToDbcType(Db::TFieldType Value);
extern PACKAGE Contnrs::TObjectList* __fastcall ConvertFieldsToColumnInfo(Db::TFields* Fields);
extern PACKAGE void __fastcall FetchFromResultSet(Zdbcintfs::_di_IZResultSet ResultSet, Zcompatibility::TIntegerDynArray 
	FieldsLookupTable, Db::TFields* Fields, Zdbccache::TZRowAccessor* RowAccessor);
extern PACKAGE void __fastcall PostToResultSet(Zdbcintfs::_di_IZResultSet ResultSet, Zcompatibility::TIntegerDynArray 
	FieldsLookupTable, Db::TFields* Fields, Zdbccache::TZRowAccessor* RowAccessor);
extern PACKAGE Zcompatibility::TObjectDynArray __fastcall DefineFields(Db::TDataSet* DataSet, AnsiString 
	FieldNames, bool &OnlyDataFields);
extern PACKAGE Zcompatibility::TObjectDynArray __fastcall DefineFilterFields(Db::TDataSet* DataSet, 
	Zexpression::_di_IZExpression Expression);
extern PACKAGE void __fastcall RetrieveDataFieldsFromResultSet(Zcompatibility::TObjectDynArray FieldRefs
	, Zdbcintfs::_di_IZResultSet ResultSet, Zvariant::TZVariantDynArray &ResultValues);
extern PACKAGE void __fastcall RetrieveDataFieldsFromRowAccessor(Zcompatibility::TObjectDynArray FieldRefs
	, Zcompatibility::TIntegerDynArray FieldIndices, Zdbccache::TZRowAccessor* RowAccessor, Zvariant::TZVariantDynArray 
	&ResultValues);
extern PACKAGE void __fastcall CopyDataFieldsToVars(Zcompatibility::TObjectDynArray Fields, Zdbcintfs::_di_IZResultSet 
	ResultSet, Zexpression::_di_IZVariablesList Variables);
extern PACKAGE bool __fastcall CompareDataFields(const Zvariant::TZVariantDynArray KeyValues, const 
	Zvariant::TZVariantDynArray RowValues, bool PartialKey, bool CaseInsensitive);
extern PACKAGE void __fastcall PrepareValuesForComparison(Zcompatibility::TObjectDynArray FieldRefs, 
	Zvariant::TZVariantDynArray &DecodedKeyValues, Zdbcintfs::_di_IZResultSet ResultSet, bool PartialKey
	, bool CaseInsensitive);
extern PACKAGE bool __fastcall CompareFieldsFromResultSet(Zcompatibility::TObjectDynArray FieldRefs, 
	Zvariant::TZVariantDynArray KeyValues, Zdbcintfs::_di_IZResultSet ResultSet, bool PartialKey, bool 
	CaseInsensitive);
extern PACKAGE AnsiString __fastcall DefineKeyFields(Db::TFields* Fields);
extern PACKAGE void __fastcall DateTimeToNative(Db::TFieldType DataType, System::TDateTime Data, void * 
	Buffer);
extern PACKAGE System::TDateTime __fastcall NativeToDateTime(Db::TFieldType DataType, void * Buffer)
	;
extern PACKAGE bool __fastcall CompareKeyFields(Db::TField* Field1, Zdbcintfs::_di_IZResultSet ResultSet
	, Db::TField* Field2);
extern PACKAGE void __fastcall DefineSortedFields(Db::TDataSet* DataSet, AnsiString SortedFields, Zcompatibility::TObjectDynArray 
	&FieldRefs, Zcompatibility::TBooleanDynArray &FieldDirs, bool &OnlyDataFields);
extern PACKAGE Zcompatibility::TIntegerDynArray __fastcall CreateFieldsLookupTable(Db::TFields* Fields
	);
extern PACKAGE int __fastcall DefineFieldIndex(Zcompatibility::TIntegerDynArray FieldsLookupTable, Db::TField* 
	Field);
extern PACKAGE Zcompatibility::TIntegerDynArray __fastcall DefineFieldIndices(Zcompatibility::TIntegerDynArray 
	FieldsLookupTable, Zcompatibility::TObjectDynArray FieldRefs);
extern PACKAGE void __fastcall SplitQualifiedObjectName(AnsiString QualifiedName, AnsiString &Catalog
	, AnsiString &Schema, AnsiString &ObjectName);

}	/* namespace Zdatasetutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdatasetutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDatasetUtils
