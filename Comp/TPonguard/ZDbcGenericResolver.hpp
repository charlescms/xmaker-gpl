// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcGenericResolver.pas' rev: 5.00

#ifndef ZDbcGenericResolverHPP
#define ZDbcGenericResolverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZSelectSchema.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZVariant.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcgenericresolver
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZResolverParameter;
class PASCALIMPLEMENTATION TZResolverParameter : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int FColumnIndex;
	AnsiString FColumnName;
	Zdbcintfs::TZSQLType FColumnType;
	bool FNewValue;
	AnsiString FDefaultValue;
	
public:
	__fastcall TZResolverParameter(int ColumnIndex, AnsiString ColumnName, Zdbcintfs::TZSQLType ColumnType
		, bool NewValue, AnsiString DefaultValue);
	__property int ColumnIndex = {read=FColumnIndex, write=FColumnIndex, nodefault};
	__property AnsiString ColumnName = {read=FColumnName, write=FColumnName};
	__property Zdbcintfs::TZSQLType ColumnType = {read=FColumnType, write=FColumnType, nodefault};
	__property bool NewValue = {read=FNewValue, write=FNewValue, nodefault};
	__property AnsiString DefaultValue = {read=FDefaultValue, write=FDefaultValue};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZResolverParameter(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZGenericCachedResolver;
class PASCALIMPLEMENTATION TZGenericCachedResolver : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Zdbcintfs::_di_IZConnection FConnection;
	Zdbcintfs::_di_IZResultSetMetadata FMetadata;
	Zdbcintfs::_di_IZDatabaseMetadata FDatabaseMetadata;
	Zselectschema::_di_IZIdentifierConvertor FIdentifierConvertor;
	Contnrs::TObjectList* FInsertColumns;
	Contnrs::TObjectList* FUpdateColumns;
	Contnrs::TObjectList* FWhereColumns;
	bool FCalcDefaults;
	bool FWhereAll;
	bool FUpdateAll;
	
protected:
	void __fastcall CopyResolveParameters(Contnrs::TObjectList* FromList, Contnrs::TObjectList* ToList)
		;
	AnsiString __fastcall ComposeFullTableName(AnsiString Catalog, AnsiString Schema, AnsiString Table)
		;
	AnsiString __fastcall DefineTableName();
	void __fastcall DefineCalcColumns(Contnrs::TObjectList* Columns, Zdbccache::TZRowAccessor* RowAccessor
		);
	void __fastcall DefineInsertColumns(Contnrs::TObjectList* Columns);
	void __fastcall DefineUpdateColumns(Contnrs::TObjectList* Columns, Zdbccache::TZRowAccessor* OldRowAccessor
		, Zdbccache::TZRowAccessor* NewRowAccessor);
	void __fastcall DefineWhereKeyColumns(Contnrs::TObjectList* Columns);
	void __fastcall DefineWhereAllColumns(Contnrs::TObjectList* Columns);
	virtual bool __fastcall CheckKeyColumn(int ColumnIndex);
	void __fastcall FillStatement(Zdbcintfs::_di_IZPreparedStatement Statement, Contnrs::TObjectList* Params
		, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor);
	__property Zdbcintfs::_di_IZConnection Connection = {read=FConnection, write=FConnection};
	__property Zdbcintfs::_di_IZResultSetMetadata Metadata = {read=FMetadata, write=FMetadata};
	__property Zdbcintfs::_di_IZDatabaseMetadata DatabaseMetadata = {read=FDatabaseMetadata, write=FDatabaseMetadata
		};
	__property Zselectschema::_di_IZIdentifierConvertor IdentifierConvertor = {read=FIdentifierConvertor
		, write=FIdentifierConvertor};
	__property Contnrs::TObjectList* InsertColumns = {read=FInsertColumns};
	__property Contnrs::TObjectList* UpdateColumns = {read=FUpdateColumns};
	__property Contnrs::TObjectList* WhereColumns = {read=FWhereColumns};
	__property bool CalcDefaults = {read=FCalcDefaults, write=FCalcDefaults, nodefault};
	__property bool WhereAll = {read=FWhereAll, write=FWhereAll, nodefault};
	__property bool UpdateAll = {read=FUpdateAll, write=FUpdateAll, nodefault};
	
public:
	__fastcall TZGenericCachedResolver(Zdbcintfs::_di_IZStatement Statement, Zdbcintfs::_di_IZResultSetMetadata 
		Metadata);
	__fastcall virtual ~TZGenericCachedResolver(void);
	AnsiString __fastcall FormWhereClause(Contnrs::TObjectList* Columns, Zdbccache::TZRowAccessor* OldRowAccessor
		);
	AnsiString __fastcall FormInsertStatement(Contnrs::TObjectList* Columns, Zdbccache::TZRowAccessor* 
		NewRowAccessor);
	AnsiString __fastcall FormUpdateStatement(Contnrs::TObjectList* Columns, Zdbccache::TZRowAccessor* 
		OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor);
	AnsiString __fastcall FormDeleteStatement(Contnrs::TObjectList* Columns, Zdbccache::TZRowAccessor* 
		OldRowAccessor);
	virtual AnsiString __fastcall FormCalculateStatement(Contnrs::TObjectList* Columns);
	void __fastcall CalculateDefaults(Zdbccachedresultset::_di_IZCachedResultSet Sender, Zdbccache::TZRowAccessor* 
		RowAccessor);
	virtual void __fastcall PostUpdates(Zdbccachedresultset::_di_IZCachedResultSet Sender, Zdbccache::TZRowUpdateType 
		UpdateType, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor);
private:
		
	void *__IZCachedResolver;	/* Zdbccachedresultset::IZCachedResolver */
	
public:
	operator IZCachedResolver*(void) { return (IZCachedResolver*)&__IZCachedResolver; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcgenericresolver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcgenericresolver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcGenericResolver
