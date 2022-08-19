// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcMetadata.pas' rev: 5.00

#ifndef ZDbcMetadataHPP
#define ZDbcMetadataHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZGenericSqlToken.hpp>	// Pascal unit
#include <ZSelectSchema.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcmetadata
{
//-- type declarations -------------------------------------------------------
__interface IZVirtualResultSet;
typedef System::DelphiInterface<IZVirtualResultSet> _di_IZVirtualResultSet;
__interface INTERFACE_UUID("{D84055AC-BCD5-40CD-B408-6F11AF000C96}") IZVirtualResultSet  : public IZCachedResultSet 
	
{
	
public:
	virtual void __fastcall SetType(Zdbcintfs::TZResultSetType Value) = 0 ;
	virtual void __fastcall SetConcurrency(Zdbcintfs::TZResultSetConcurrency Value) = 0 ;
};

class DELPHICLASS TZVirtualResultSet;
class PASCALIMPLEMENTATION TZVirtualResultSet : public Zdbccachedresultset::TZAbstractCachedResultSet 
	
{
	typedef Zdbccachedresultset::TZAbstractCachedResultSet inherited;
	
protected:
	virtual void __fastcall CalculateRowDefaults(Zdbccache::TZRowAccessor* RowAccessor);
	virtual void __fastcall PostRowUpdates(Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* 
		NewRowAccessor);
	
public:
	__fastcall TZVirtualResultSet(AnsiString SQL, Zdbcintfs::_di_IZStatement Statement);
	__fastcall TZVirtualResultSet(Contnrs::TObjectList* ColumnsInfo, AnsiString SQL);
	__fastcall virtual ~TZVirtualResultSet(void);
protected:
	#pragma option push -w-inl
	/* TZAbstractResultSet.Create */ inline __fastcall TZVirtualResultSet(Zdbcintfs::_di_IZStatement Statement
		, AnsiString SQL, Comobj::TContainedObject* Metadata) : Zdbccachedresultset::TZAbstractCachedResultSet(
		Statement, SQL, Metadata) { }
	#pragma option pop
	
private:
	void *__IZVirtualResultSet;	/* Zdbcmetadata::IZVirtualResultSet */
	
public:
	operator IZVirtualResultSet*(void) { return (IZVirtualResultSet*)&__IZVirtualResultSet; }
	
};


class DELPHICLASS TZAbstractDatabaseMetadata;
class PASCALIMPLEMENTATION TZAbstractDatabaseMetadata : public Comobj::TContainedObject 
{
	typedef Comobj::TContainedObject inherited;
	
private:
	Zdbcconnection::TZAbstractConnection* FConnection;
	AnsiString FUrl;
	Classes::TStrings* FInfo;
	Ztokenizer::_di_IZTokenizer FTokenizer;
	Zgenericsqlanalyser::_di_IZStatementAnalyser FAnalyser;
	Zclasses::_di_IZHashMap FCachedResultSets;
	
protected:
	__fastcall TZAbstractDatabaseMetadata(Zdbcconnection::TZAbstractConnection* ParentConnection, AnsiString 
		Url, Classes::TStrings* Info);
	void __fastcall AddResultSetToCache(AnsiString Key, Zdbcintfs::_di_IZResultSet ResultSet);
	Zdbcintfs::_di_IZResultSet __fastcall GetResultSetFromCache(AnsiString Key);
	bool __fastcall IsResultSetCached(Zdbcintfs::_di_IZResultSet ResultSet);
	Zdbcintfs::_di_IZResultSet __fastcall CloneCachedResultSet(Zdbcintfs::_di_IZResultSet ResultSet);
	Zdbcresultsetmetadata::TZColumnInfo* __fastcall CreateColumnInfo(AnsiString Name, Zdbcintfs::TZSQLType 
		SQLType, int Length);
	_di_IZVirtualResultSet __fastcall CreateVirtualResultSet(Contnrs::TObjectList* ColumnsInfo);
	__property AnsiString Url = {read=FUrl};
	__property Classes::TStrings* Info = {read=FInfo};
	__property Ztokenizer::_di_IZTokenizer Tokenizer = {read=FTokenizer, write=FTokenizer};
	__property Zgenericsqlanalyser::_di_IZStatementAnalyser Analyser = {read=FAnalyser, write=FAnalyser
		};
	__property Zclasses::_di_IZHashMap CachedResultSets = {read=FCachedResultSets, write=FCachedResultSets
		};
	
public:
	__fastcall virtual ~TZAbstractDatabaseMetadata(void);
	virtual bool __fastcall AllProceduresAreCallable(void);
	virtual bool __fastcall AllTablesAreSelectable(void);
	virtual AnsiString __fastcall GetURL();
	virtual AnsiString __fastcall GetUserName();
	virtual bool __fastcall IsReadOnly(void);
	virtual bool __fastcall NullsAreSortedHigh(void);
	virtual bool __fastcall NullsAreSortedLow(void);
	virtual bool __fastcall NullsAreSortedAtStart(void);
	virtual bool __fastcall NullsAreSortedAtEnd(void);
	virtual AnsiString __fastcall GetDatabaseProductName();
	virtual AnsiString __fastcall GetDatabaseProductVersion();
	virtual AnsiString __fastcall GetDriverName();
	virtual AnsiString __fastcall GetDriverVersion();
	virtual int __fastcall GetDriverMajorVersion(void);
	virtual int __fastcall GetDriverMinorVersion(void);
	virtual bool __fastcall UsesLocalFiles(void);
	virtual bool __fastcall UsesLocalFilePerTable(void);
	virtual bool __fastcall SupportsMixedCaseIdentifiers(void);
	virtual bool __fastcall StoresUpperCaseIdentifiers(void);
	virtual bool __fastcall StoresLowerCaseIdentifiers(void);
	virtual bool __fastcall StoresMixedCaseIdentifiers(void);
	virtual bool __fastcall SupportsMixedCaseQuotedIdentifiers(void);
	virtual bool __fastcall StoresUpperCaseQuotedIdentifiers(void);
	virtual bool __fastcall StoresLowerCaseQuotedIdentifiers(void);
	virtual bool __fastcall StoresMixedCaseQuotedIdentifiers(void);
	virtual AnsiString __fastcall GetIdentifierQuoteString();
	virtual AnsiString __fastcall GetSQLKeywords();
	virtual AnsiString __fastcall GetNumericFunctions();
	virtual AnsiString __fastcall GetStringFunctions();
	virtual AnsiString __fastcall GetSystemFunctions();
	virtual AnsiString __fastcall GetTimeDateFunctions();
	virtual AnsiString __fastcall GetSearchStringEscape();
	virtual AnsiString __fastcall GetExtraNameCharacters();
	virtual bool __fastcall SupportsAlterTableWithAddColumn(void);
	virtual bool __fastcall SupportsAlterTableWithDropColumn(void);
	virtual bool __fastcall SupportsColumnAliasing(void);
	virtual bool __fastcall NullPlusNonNullIsNull(void);
	virtual bool __fastcall SupportsConvert(void);
	virtual bool __fastcall SupportsConvertForTypes(Zdbcintfs::TZSQLType FromType, Zdbcintfs::TZSQLType 
		ToType);
	virtual bool __fastcall SupportsTableCorrelationNames(void);
	virtual bool __fastcall SupportsDifferentTableCorrelationNames(void);
	virtual bool __fastcall SupportsExpressionsInOrderBy(void);
	virtual bool __fastcall SupportsOrderByUnrelated(void);
	virtual bool __fastcall SupportsGroupBy(void);
	virtual bool __fastcall SupportsGroupByUnrelated(void);
	virtual bool __fastcall SupportsGroupByBeyondSelect(void);
	virtual bool __fastcall SupportsLikeEscapeClause(void);
	virtual bool __fastcall SupportsMultipleResultSets(void);
	virtual bool __fastcall SupportsMultipleTransactions(void);
	virtual bool __fastcall SupportsNonNullableColumns(void);
	virtual bool __fastcall SupportsMinimumSQLGrammar(void);
	virtual bool __fastcall SupportsCoreSQLGrammar(void);
	virtual bool __fastcall SupportsExtendedSQLGrammar(void);
	virtual bool __fastcall SupportsANSI92EntryLevelSQL(void);
	virtual bool __fastcall SupportsANSI92IntermediateSQL(void);
	virtual bool __fastcall SupportsANSI92FullSQL(void);
	virtual bool __fastcall SupportsIntegrityEnhancementFacility(void);
	virtual bool __fastcall SupportsOuterJoins(void);
	virtual bool __fastcall SupportsFullOuterJoins(void);
	virtual bool __fastcall SupportsLimitedOuterJoins(void);
	virtual AnsiString __fastcall GetSchemaTerm();
	virtual AnsiString __fastcall GetProcedureTerm();
	virtual AnsiString __fastcall GetCatalogTerm();
	virtual bool __fastcall IsCatalogAtStart(void);
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
	virtual bool __fastcall SupportsBatchUpdates(void);
	virtual Zdbcintfs::_di_IZResultSet __fastcall GetUDTs(AnsiString Catalog, AnsiString SchemaPattern, 
		AnsiString TypeNamePattern, Zcompatibility::TIntegerDynArray Types);
	virtual Zdbcintfs::_di_IZConnection __fastcall GetConnection();
	virtual Ztokenizer::_di_IZTokenizer __fastcall GetTokenizer();
	virtual Zgenericsqlanalyser::_di_IZStatementAnalyser __fastcall GetStatementAnalyser();
	virtual Zselectschema::_di_IZIdentifierConvertor __fastcall GetIdentifierConvertor();
	virtual void __fastcall ClearCache(void);
private:
	void *__IZDatabaseMetadata;	/* Zdbcintfs::IZDatabaseMetadata */
	
public:
	operator IZDatabaseMetadata*(void) { return (IZDatabaseMetadata*)&__IZDatabaseMetadata; }
	
};


class DELPHICLASS TZDefaultIdentifierConvertor;
class PASCALIMPLEMENTATION TZDefaultIdentifierConvertor : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Zdbcintfs::_di_IZDatabaseMetadata FMetadata;
	
protected:
	__property Zdbcintfs::_di_IZDatabaseMetadata Metadata = {read=FMetadata, write=FMetadata};
	bool __fastcall IsLowerCase(AnsiString Value);
	bool __fastcall IsUpperCase(AnsiString Value);
	bool __fastcall IsSpecialCase(AnsiString Value);
	
public:
	__fastcall TZDefaultIdentifierConvertor(Zdbcintfs::_di_IZDatabaseMetadata Metadata);
	bool __fastcall IsCaseSensitive(AnsiString Value);
	bool __fastcall IsQuoted(AnsiString Value);
	AnsiString __fastcall Quote(AnsiString Value);
	AnsiString __fastcall ExtractQuote(AnsiString Value);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZDefaultIdentifierConvertor(void) { }
	#pragma option pop
	
private:
	void *__IZIdentifierConvertor;	/* Zselectschema::IZIdentifierConvertor */
	
public:
	operator IZIdentifierConvertor*(void) { return (IZIdentifierConvertor*)&__IZIdentifierConvertor; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint procedureColumnUnknown = 0x0;
static const Shortint procedureColumnIn = 0x1;
static const Shortint procedureColumnInOut = 0x2;
static const Shortint procedureColumnOut = 0x4;
static const Shortint procedureColumnReturn = 0x5;
static const Shortint procedureColumnResult = 0x3;
static const Shortint procedureNoNulls = 0x0;
static const Shortint procedureNullable = 0x1;
static const Shortint procedureNullableUnknown = 0x2;

}	/* namespace Zdbcmetadata */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcmetadata;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcMetadata
