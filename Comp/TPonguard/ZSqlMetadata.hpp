// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSqlMetadata.pas' rev: 5.00

#ifndef ZSqlMetadataHPP
#define ZSqlMetadataHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZAbstractRODataset.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsqlmetadata
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZMetadataType { mdProcedures, mdProcedureColumns, mdTables, mdSchemas, mdCatalogs, mdTableTypes, 
	mdColumns, mdColumnPrivileges, mdTablePrivileges, mdBestRowIdentifier, mdVersionColumns, mdPrimaryKeys, 
	mdImportedKeys, mdExportedKeys, mdCrossReference, mdTypeInfo, mdIndexInfo, mdUserDefinedTypes };
#pragma option pop

class DELPHICLASS TZSQLMetadata;
class PASCALIMPLEMENTATION TZSQLMetadata : public Zabstractrodataset::TZAbstractRODataset 
{
	typedef Zabstractrodataset::TZAbstractRODataset inherited;
	
private:
	TZMetadataType FMetadataType;
	AnsiString FCatalog;
	AnsiString FSchema;
	AnsiString FTableName;
	AnsiString FColumnName;
	AnsiString FProcedureName;
	int FScope;
	bool FNullable;
	AnsiString FForeignCatalog;
	AnsiString FForeignSchema;
	AnsiString FForeignTableName;
	bool FUnique;
	bool FApproximate;
	AnsiString FTypeName;
	void __fastcall SetMetadataType(TZMetadataType Value);
	
protected:
	virtual Zdbcintfs::_di_IZResultSet __fastcall CreateResultSet(AnsiString SQL, int MaxRows);
	
__published:
	__property TZMetadataType MetadataType = {read=FMetadataType, write=SetMetadataType, nodefault};
	__property AnsiString Catalog = {read=FCatalog, write=FCatalog};
	__property AnsiString Schema = {read=FSchema, write=FSchema};
	__property AnsiString TableName = {read=FTableName, write=FTableName};
	__property AnsiString ColumnName = {read=FColumnName, write=FColumnName};
	__property AnsiString ProcedureName = {read=FProcedureName, write=FProcedureName};
	__property int Scope = {read=FScope, write=FScope, nodefault};
	__property bool Nullable = {read=FNullable, write=FNullable, nodefault};
	__property AnsiString ForeignCatalog = {read=FForeignCatalog, write=FForeignCatalog};
	__property AnsiString ForeignSchema = {read=FForeignSchema, write=FForeignSchema};
	__property AnsiString ForeignTableName = {read=FForeignTableName, write=FForeignTableName};
	__property bool Unique = {read=FUnique, write=FUnique, nodefault};
	__property bool Approximate = {read=FApproximate, write=FApproximate, nodefault};
	__property AnsiString TypeName = {read=FTypeName, write=FTypeName};
	__property Active ;
	__property MasterFields ;
	__property MasterSource ;
	__property IndexFieldNames ;
public:
	#pragma option push -w-inl
	/* TZAbstractRODataset.Create */ inline __fastcall virtual TZSQLMetadata(Classes::TComponent* AOwner
		) : Zabstractrodataset::TZAbstractRODataset(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractRODataset.Destroy */ inline __fastcall virtual ~TZSQLMetadata(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsqlmetadata */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsqlmetadata;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSqlMetadata
