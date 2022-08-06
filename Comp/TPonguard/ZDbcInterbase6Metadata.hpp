// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcInterbase6Metadata.pas' rev: 5.00

#ifndef ZDbcInterbase6MetadataHPP
#define ZDbcInterbase6MetadataHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ComObj.hpp>	// Pascal unit
#include <ZDbcInterbase6.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZDbcMetadata.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcinterbase6metadata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZInterbase6DatabaseMetadata;
class PASCALIMPLEMENTATION TZInterbase6DatabaseMetadata : public Zdbcmetadata::TZAbstractDatabaseMetadata 
	
{
	typedef Zdbcmetadata::TZAbstractDatabaseMetadata inherited;
	
private:
	AnsiString FSeverVersion;
	Zdbcinterbase6::TZInterbase6Connection* FIBConnection;
	AnsiString __fastcall StripEscape(const AnsiString Pattern);
	bool __fastcall HasNoWildcards(const AnsiString Pattern);
	AnsiString __fastcall GetPrivilege(AnsiString Privilege);
	AnsiString __fastcall ConstructNameCondition(AnsiString Pattern, AnsiString Column);
	AnsiString __fastcall GetSeverVersion();
	
public:
	__fastcall TZInterbase6DatabaseMetadata(Zdbcconnection::TZAbstractConnection* Connection, AnsiString 
		Url, Classes::TStrings* Info);
	__fastcall virtual ~TZInterbase6DatabaseMetadata(void);
	__property AnsiString SeverVersion = {read=GetSeverVersion, write=FSeverVersion};
	virtual AnsiString __fastcall GetDatabaseProductName();
	virtual AnsiString __fastcall GetDatabaseProductVersion();
	virtual AnsiString __fastcall GetDriverName();
	virtual int __fastcall GetDriverMajorVersion(void);
	virtual int __fastcall GetDriverMinorVersion(void);
	virtual bool __fastcall UsesLocalFilePerTable(void);
	virtual bool __fastcall SupportsMixedCaseIdentifiers(void);
	virtual bool __fastcall StoresUpperCaseIdentifiers(void);
	virtual bool __fastcall StoresLowerCaseIdentifiers(void);
	virtual bool __fastcall StoresMixedCaseIdentifiers(void);
	virtual bool __fastcall SupportsMixedCaseQuotedIdentifiers(void);
	virtual bool __fastcall StoresUpperCaseQuotedIdentifiers(void);
	virtual bool __fastcall StoresLowerCaseQuotedIdentifiers(void);
	virtual bool __fastcall StoresMixedCaseQuotedIdentifiers(void);
	virtual AnsiString __fastcall GetSQLKeywords();
	virtual AnsiString __fastcall GetNumericFunctions();
	virtual AnsiString __fastcall GetStringFunctions();
	virtual AnsiString __fastcall GetSystemFunctions();
	virtual AnsiString __fastcall GetTimeDateFunctions();
	virtual AnsiString __fastcall GetSearchStringEscape();
	virtual AnsiString __fastcall GetExtraNameCharacters();
	virtual bool __fastcall SupportsExpressionsInOrderBy(void);
	virtual bool __fastcall SupportsOrderByUnrelated(void);
	virtual bool __fastcall SupportsGroupBy(void);
	virtual bool __fastcall SupportsGroupByUnrelated(void);
	virtual bool __fastcall SupportsGroupByBeyondSelect(void);
	virtual bool __fastcall SupportsIntegrityEnhancementFacility(void);
	virtual AnsiString __fastcall GetSchemaTerm();
	virtual AnsiString __fastcall GetProcedureTerm();
	virtual AnsiString __fastcall GetCatalogTerm();
	virtual AnsiString __fastcall GetCatalogSeparator();
	virtual bool __fastcall SupportsSchemasInDataManipulation(void);
	virtual bool __fastcall SupportsSchemasInProcedureCalls(void);
	virtual bool __fastcall SupportsSchemasInTableDefinitions(void);
	virtual bool __fastcall SupportsSchemasInIndexDefinitions(void);
	virtual bool __fastcall SupportsSchemasInPrivilegeDefinitions(void);
	virtual bool __fastcall SupportsCatalogsInDataManipulation(void);
	virtual bool __fastcall SupportsCatalogsInProcedureCalls(void);
	virtual bool __fastcall SupportsCatalogsInTableDefinitions(void);
	virtual bool __fastcall SupportsCatalogsInIndexDefinitions(void);
	virtual bool __fastcall SupportsCatalogsInPrivilegeDefinitions(void);
	virtual bool __fastcall SupportsPositionedDelete(void);
	virtual bool __fastcall SupportsPositionedUpdate(void);
	virtual bool __fastcall SupportsSelectForUpdate(void);
	virtual bool __fastcall SupportsStoredProcedures(void);
	virtual bool __fastcall SupportsSubqueriesInComparisons(void);
	virtual bool __fastcall SupportsSubqueriesInExists(void);
	virtual bool __fastcall SupportsSubqueriesInIns(void);
	virtual bool __fastcall SupportsSubqueriesInQuantifieds(void);
	virtual bool __fastcall SupportsCorrelatedSubqueries(void);
	virtual bool __fastcall SupportsUnion(void);
	virtual bool __fastcall SupportsUnionAll(void);
	virtual bool __fastcall SupportsOpenCursorsAcrossCommit(void);
	virtual bool __fastcall SupportsOpenCursorsAcrossRollback(void);
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
	virtual int __fastcall GetMaxSchemaNameLength(void);
	virtual int __fastcall GetMaxProcedureNameLength(void);
	virtual int __fastcall GetMaxCatalogNameLength(void);
	virtual int __fastcall GetMaxRowSize(void);
	virtual bool __fastcall DoesMaxRowSizeIncludeBlobs(void);
	virtual int __fastcall GetMaxStatementLength(void);
	virtual int __fastcall GetMaxStatements(void);
	virtual int __fastcall GetMaxTableNameLength(void);
	virtual int __fastcall GetMaxTablesInSelect(void);
	virtual int __fastcall GetMaxUserNameLength(void);
	virtual Zdbcintfs::TZTransactIsolationLevel __fastcall GetDefaultTransactionIsolation(void);
	virtual bool __fastcall SupportsTransactions(void);
	virtual bool __fastcall SupportsTransactionIsolationLevel(Zdbcintfs::TZTransactIsolationLevel Level
		);
	virtual bool __fastcall SupportsDataDefinitionAndDataManipulationTransactions(void);
	virtual bool __fastcall SupportsDataManipulationTransactionsOnly(void);
	virtual bool __fastcall DataDefinitionCausesTransactionCommit(void);
	virtual bool __fastcall DataDefinitionIgnoredInTransactions(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetProcedures(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString ProcedureNamePattern);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetProcedureColumns(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString ProcedureNamePattern, AnsiString ColumnNamePattern);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetTables(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString TableNamePattern, Zcompatibility::TStringDynArray Types);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetSchemas();
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetCatalogs();
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetTableTypes();
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
	virtual bool __fastcall SupportsResultSetType(Zdbcintfs::TZResultSetType _Type);
	virtual bool __fastcall SupportsResultSetConcurrency(Zdbcintfs::TZResultSetType _Type, Zdbcintfs::TZResultSetConcurrency 
		Concurrency);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetUDTs(AnsiString Catalog, AnsiString SchemaPattern, 
		AnsiString TypeNamePattern, Zcompatibility::TIntegerDynArray Types);
	virtual Ztokenizer::_di_IZTokenizer __fastcall GetTokenizer();
	virtual Zgenericsqlanalyser::_di_IZStatementAnalyser __fastcall GetStatementAnalyser();
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcinterbase6metadata */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcinterbase6metadata;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcInterbase6Metadata
