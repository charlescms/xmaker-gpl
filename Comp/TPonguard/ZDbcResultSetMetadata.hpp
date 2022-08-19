// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcResultSetMetadata.pas' rev: 5.00

#ifndef ZDbcResultSetMetadataHPP
#define ZDbcResultSetMetadataHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZSelectSchema.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcresultsetmetadata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZColumnInfo;
class PASCALIMPLEMENTATION TZColumnInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	bool FAutoIncrement;
	bool FCaseSensitive;
	bool FSearchable;
	bool FCurrency;
	Zdbcintfs::TZColumnNullableType FNullable;
	bool FSigned;
	int FColumnDisplaySize;
	AnsiString FColumnLabel;
	AnsiString FColumnName;
	AnsiString FSchemaName;
	int FPrecision;
	int FScale;
	AnsiString FTableName;
	AnsiString FCatalogName;
	Zdbcintfs::TZSQLType FColumnType;
	bool FReadOnly;
	bool FWritable;
	bool FDefinitelyWritable;
	AnsiString FDefaultValue;
	
public:
	__fastcall TZColumnInfo(void);
	AnsiString __fastcall GetColumnTypeName();
	__property bool AutoIncrement = {read=FAutoIncrement, write=FAutoIncrement, nodefault};
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, nodefault};
	__property bool Searchable = {read=FSearchable, write=FSearchable, nodefault};
	__property bool Currency = {read=FCurrency, write=FCurrency, nodefault};
	__property Zdbcintfs::TZColumnNullableType Nullable = {read=FNullable, write=FNullable, nodefault};
		
	__property bool Signed = {read=FSigned, write=FSigned, nodefault};
	__property int ColumnDisplaySize = {read=FColumnDisplaySize, write=FColumnDisplaySize, nodefault};
	__property AnsiString ColumnLabel = {read=FColumnLabel, write=FColumnLabel};
	__property AnsiString ColumnName = {read=FColumnName, write=FColumnName};
	__property AnsiString SchemaName = {read=FSchemaName, write=FSchemaName};
	__property int Precision = {read=FPrecision, write=FPrecision, nodefault};
	__property int Scale = {read=FScale, write=FScale, nodefault};
	__property AnsiString TableName = {read=FTableName, write=FTableName};
	__property AnsiString CatalogName = {read=FCatalogName, write=FCatalogName};
	__property Zdbcintfs::TZSQLType ColumnType = {read=FColumnType, write=FColumnType, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property bool Writable = {read=FWritable, write=FWritable, nodefault};
	__property bool DefinitelyWritable = {read=FDefinitelyWritable, write=FDefinitelyWritable, nodefault
		};
	__property AnsiString DefaultValue = {read=FDefaultValue, write=FDefaultValue};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZColumnInfo(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZAbstractResultSetMetadata;
class PASCALIMPLEMENTATION TZAbstractResultSetMetadata : public Comobj::TContainedObject 
{
	typedef Comobj::TContainedObject inherited;
	
private:
	bool FLoaded;
	Zdbcintfs::_di_IZDatabaseMetadata FMetadata;
	Classes::TStrings* FColumnsLabels;
	AnsiString FSQL;
	Zcollections::TZHashMap* FTableColumns;
	Zselectschema::_di_IZIdentifierConvertor FIdentifierConvertor;
	Zdbcresultset::TZAbstractResultSet* FResultSet;
	
protected:
	virtual void __fastcall LoadColumn(int ColumnIndex, TZColumnInfo* ColumnInfo, Zselectschema::_di_IZSelectSchema 
		SelectSchema);
	Zdbcintfs::_di_IZResultSet __fastcall GetTableColumns(Zselectschema::TZTableRef* TableRef);
	bool __fastcall ReadColumnByRef(Zselectschema::TZFieldRef* FieldRef, TZColumnInfo* ColumnInfo);
	bool __fastcall ReadColumnByName(AnsiString FieldName, Zselectschema::TZTableRef* TableRef, TZColumnInfo* 
		ColumnInfo);
	void __fastcall ClearColumn(TZColumnInfo* ColumnInfo);
	void __fastcall LoadColumns(void);
	void __fastcall ReplaceStarColumns(Zselectschema::_di_IZSelectSchema SelectSchema);
	__property Zdbcintfs::_di_IZDatabaseMetadata MetaData = {read=FMetadata, write=FMetadata};
	__property Classes::TStrings* ColumnsLabels = {read=FColumnsLabels, write=FColumnsLabels};
	__property AnsiString SQL = {read=FSQL, write=FSQL};
	__property Zselectschema::_di_IZIdentifierConvertor IdentifierConvertor = {read=FIdentifierConvertor
		, write=FIdentifierConvertor};
	__property bool Loaded = {read=FLoaded, write=FLoaded, nodefault};
	__property Zdbcresultset::TZAbstractResultSet* ResultSet = {read=FResultSet, write=FResultSet};
	
public:
	__fastcall TZAbstractResultSetMetadata(Zdbcintfs::_di_IZDatabaseMetadata Metadata, AnsiString SQL, 
		Zdbcresultset::TZAbstractResultSet* ParentResultSet);
	__fastcall virtual ~TZAbstractResultSetMetadata(void);
	virtual int __fastcall GetColumnCount(void);
	virtual bool __fastcall IsAutoIncrement(int Column);
	virtual bool __fastcall IsCaseSensitive(int Column);
	virtual bool __fastcall IsSearchable(int Column);
	virtual bool __fastcall IsCurrency(int Column);
	virtual Zdbcintfs::TZColumnNullableType __fastcall IsNullable(int Column);
	virtual bool __fastcall IsSigned(int Column);
	virtual int __fastcall GetColumnDisplaySize(int Column);
	virtual AnsiString __fastcall GetColumnLabel(int Column);
	virtual AnsiString __fastcall GetColumnName(int Column);
	virtual AnsiString __fastcall GetSchemaName(int Column);
	virtual int __fastcall GetPrecision(int Column);
	virtual int __fastcall GetScale(int Column);
	virtual AnsiString __fastcall GetTableName(int Column);
	virtual AnsiString __fastcall GetCatalogName(int Column);
	virtual Zdbcintfs::TZSQLType __fastcall GetColumnType(int Column);
	virtual AnsiString __fastcall GetColumnTypeName(int Column);
	virtual bool __fastcall IsReadOnly(int Column);
	virtual bool __fastcall IsWritable(int Column);
	virtual bool __fastcall IsDefinitelyWritable(int Column);
	virtual AnsiString __fastcall GetDefaultValue(int Column);
private:
	void *__IZResultSetMetadata;	/* Zdbcintfs::IZResultSetMetadata */
	
public:
	operator IZResultSetMetadata*(void) { return (IZResultSetMetadata*)&__IZResultSetMetadata; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcresultsetmetadata */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcresultsetmetadata;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcResultSetMetadata
