// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcMySqlMetadata.pas' rev: 5.00

#ifndef ZDbcMySqlMetadataHPP
#define ZDbcMySqlMetadataHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ComObj.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcMetadata.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcmysqlmetadata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZMySQLDatabaseMetadata;
class PASCALIMPLEMENTATION TZMySQLDatabaseMetadata : public Zdbcmetadata::TZAbstractDatabaseMetadata 
	
{
	typedef Zdbcmetadata::TZAbstractDatabaseMetadata inherited;
	
private:
	AnsiString FDatabase;
	
protected:
	void __fastcall GetVersion(int &MajorVersion, int &MinorVersion);
	
public:
	__fastcall TZMySQLDatabaseMetadata(Zdbcconnection::TZAbstractConnection* Connection, AnsiString Url
		, Classes::TStrings* Info);
	__fastcall virtual ~TZMySQLDatabaseMetadata(void);
	virtual AnsiString __fastcall GetDatabaseProductName();
	virtual AnsiString __fastcall GetDatabaseProductVersion();
	virtual AnsiString __fastcall GetDriverName();
	virtual int __fastcall GetDriverMajorVersion(void);
	virtual int __fastcall GetDriverMinorVersion(void);
	virtual bool __fastcall UsesLocalFilePerTable(void);
	virtual bool __fastcall StoresMixedCaseIdentifiers(void);
	virtual AnsiString __fastcall GetIdentifierQuoteString();
	virtual AnsiString __fastcall GetSQLKeywords();
	virtual AnsiString __fastcall GetNumericFunctions();
	virtual AnsiString __fastcall GetStringFunctions();
	virtual AnsiString __fastcall GetSystemFunctions();
	virtual AnsiString __fastcall GetTimeDateFunctions();
	virtual AnsiString __fastcall GetSearchStringEscape();
	virtual AnsiString __fastcall GetExtraNameCharacters();
	virtual bool __fastcall SupportsOrderByUnrelated(void);
	virtual bool __fastcall SupportsGroupByUnrelated(void);
	virtual bool __fastcall SupportsGroupByBeyondSelect(void);
	virtual bool __fastcall SupportsIntegrityEnhancementFacility(void);
	virtual AnsiString __fastcall GetSchemaTerm();
	virtual AnsiString __fastcall GetProcedureTerm();
	virtual AnsiString __fastcall GetCatalogTerm();
	virtual bool __fastcall SupportsCatalogsInDataManipulation(void);
	virtual bool __fastcall SupportsCatalogsInTableDefinitions(void);
	virtual bool __fastcall SupportsSubqueriesInComparisons(void);
	virtual bool __fastcall SupportsUnionAll(void);
	virtual bool __fastcall SupportsOpenStatementsAcrossCommit(void);
	virtual bool __fastcall SupportsOpenStatementsAcrossRollback(void);
	virtual int __fastcall GetMaxBinaryLiteralLength(void);
	virtual int __fastcall GetMaxCharLiteralLength(void);
	virtual int __fastcall GetMaxColumnNameLength(void);
	virtual int __fastcall GetMaxColumnsInGroupBy(void);
	virtual int __fastcall GetMaxColumnsInIndex(void);
	virtual int __fastcall GetMaxColumnsInOrderBy(void);
	virtual int __fastcall GetMaxColumnsInSelect(void);
	virtual int __fastcall GetMaxColumnsInTable(void);
	virtual int __fastcall GetMaxConnections(void);
	virtual int __fastcall GetMaxCursorNameLength(void);
	virtual int __fastcall GetMaxIndexLength(void);
	virtual int __fastcall GetMaxCatalogNameLength(void);
	virtual int __fastcall GetMaxRowSize(void);
	virtual bool __fastcall DoesMaxRowSizeIncludeBlobs(void);
	virtual int __fastcall GetMaxStatementLength(void);
	virtual int __fastcall GetMaxStatements(void);
	virtual int __fastcall GetMaxTableNameLength(void);
	virtual int __fastcall GetMaxTablesInSelect(void);
	virtual int __fastcall GetMaxUserNameLength(void);
	virtual Zdbcintfs::TZTransactIsolationLevel __fastcall GetDefaultTransactionIsolation(void);
	virtual bool __fastcall SupportsDataDefinitionAndDataManipulationTransactions(void);
	virtual bool __fastcall SupportsDataManipulationTransactionsOnly(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetTables(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString TableNamePattern, Zcompatibility::TStringDynArray Types);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetCatalogs();
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetColumns(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString TableNamePattern, AnsiString ColumnNamePattern);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetColumnPrivileges(AnsiString Catalog, AnsiString Schema
		, AnsiString Table, AnsiString ColumnNamePattern);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetTablePrivileges(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString TableNamePattern);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetBestRowIdentifier(AnsiString Catalog, AnsiString Schema
		, AnsiString Table, int Scope, bool Nullable);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetVersionColumns(AnsiString Catalog, AnsiString Schema
		, AnsiString Table);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetPrimaryKeys(AnsiString Catalog, AnsiString Schema, 
		AnsiString Table);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetImportedKeys(AnsiString Catalog, AnsiString Schema
		, AnsiString Table);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetExportedKeys(AnsiString Catalog, AnsiString Schema
		, AnsiString Table);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetCrossReference(AnsiString PrimaryCatalog, AnsiString 
		PrimarySchema, AnsiString PrimaryTable, AnsiString ForeignCatalog, AnsiString ForeignSchema, AnsiString 
		ForeignTable);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetTypeInfo();
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetIndexInfo(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table, bool Unique, bool Approximate);
	virtual Ztokenizer::_di_IZTokenizer __fastcall GetTokenizer();
	virtual Zgenericsqlanalyser::_di_IZStatementAnalyser __fastcall GetStatementAnalyser();
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcmysqlmetadata */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcmysqlmetadata;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcMySqlMetadata
