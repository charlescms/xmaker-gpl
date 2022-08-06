// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcIntfs.pas' rev: 5.00

#ifndef ZDbcIntfsHPP
#define ZDbcIntfsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZGenericSqlAnalyser.hpp>	// Pascal unit
#include <ZSelectSchema.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcintfs
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EZSQLThrowable;
class PASCALIMPLEMENTATION EZSQLThrowable : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
private:
	int FErrorCode;
	
public:
	__fastcall EZSQLThrowable(const AnsiString Msg);
	__fastcall EZSQLThrowable(const int ErrorCode, const AnsiString Msg);
	__property int ErrorCode = {read=FErrorCode, nodefault};
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EZSQLThrowable(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EZSQLThrowable(int Ident)/* overload */ : Sysutils::Exception(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EZSQLThrowable(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EZSQLThrowable(const AnsiString Msg, int AHelpContext)
		 : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EZSQLThrowable(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EZSQLThrowable(int Ident, int AHelpContext)/* overload */
		 : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EZSQLThrowable(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EZSQLThrowable(void) { }
	#pragma option pop
	
};


class DELPHICLASS EZSQLException;
class PASCALIMPLEMENTATION EZSQLException : public EZSQLThrowable 
{
	typedef EZSQLThrowable inherited;
	
public:
	#pragma option push -w-inl
	/* EZSQLThrowable.Create */ inline __fastcall EZSQLException(const AnsiString Msg) : EZSQLThrowable(
		Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* EZSQLThrowable.CreateWithCode */ inline __fastcall EZSQLException(const int ErrorCode, const AnsiString 
		Msg) : EZSQLThrowable(ErrorCode, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EZSQLException(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : EZSQLThrowable(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EZSQLException(int Ident)/* overload */ : EZSQLThrowable(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EZSQLException(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : EZSQLThrowable(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EZSQLException(const AnsiString Msg, int AHelpContext)
		 : EZSQLThrowable(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EZSQLException(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : EZSQLThrowable(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EZSQLException(int Ident, int AHelpContext)/* overload */
		 : EZSQLThrowable(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EZSQLException(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : EZSQLThrowable(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EZSQLException(void) { }
	#pragma option pop
	
};


class DELPHICLASS EZSQLWarning;
class PASCALIMPLEMENTATION EZSQLWarning : public EZSQLThrowable 
{
	typedef EZSQLThrowable inherited;
	
public:
	#pragma option push -w-inl
	/* EZSQLThrowable.Create */ inline __fastcall EZSQLWarning(const AnsiString Msg) : EZSQLThrowable(Msg
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* EZSQLThrowable.CreateWithCode */ inline __fastcall EZSQLWarning(const int ErrorCode, const AnsiString 
		Msg) : EZSQLThrowable(ErrorCode, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EZSQLWarning(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : EZSQLThrowable(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EZSQLWarning(int Ident)/* overload */ : EZSQLThrowable(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EZSQLWarning(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : EZSQLThrowable(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EZSQLWarning(const AnsiString Msg, int AHelpContext) : 
		EZSQLThrowable(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EZSQLWarning(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : EZSQLThrowable(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EZSQLWarning(int Ident, int AHelpContext)/* overload */
		 : EZSQLThrowable(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EZSQLWarning(System::PResStringRec ResStringRec, 
		const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : EZSQLThrowable(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EZSQLWarning(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TZSQLType { stUnknown, stBoolean, stByte, stShort, stInteger, stLong, stFloat, stDouble, stBigDecimal, 
	stString, stUnicodeString, stBytes, stDate, stTime, stTimestamp, stAsciiStream, stUnicodeStream, stBinaryStream 
	};
#pragma option pop

#pragma option push -b-
enum TZTransactIsolationLevel { tiNone, tiReadUncommitted, tiReadCommitted, tiRepeatableRead, tiSerializable 
	};
#pragma option pop

#pragma option push -b-
enum TZFetchDirection { fdForward, fdReverse, fdUnknown };
#pragma option pop

#pragma option push -b-
enum TZResultSetType { rtForwardOnly, rtScrollInsensitive, rtScrollSensitive };
#pragma option pop

#pragma option push -b-
enum TZResultSetConcurrency { rcReadOnly, rcUpdatable };
#pragma option pop

#pragma option push -b-
enum TZColumnNullableType { ntNoNulls, ntNullable, ntNullableUnknown };
#pragma option pop

#pragma option push -b-
enum TZProcedureResultType { prtUnknown, prtNoResult, prtReturnsResult };
#pragma option pop

#pragma option push -b-
enum TZProcedureColumnType { pctUnknown, pctIn, pctInOut, pctOut, pctReturn, pctResultSet };
#pragma option pop

#pragma option push -b-
enum TZBestRowIdentifier { brUnknown, brNotPseudo, brPseudo };
#pragma option pop

#pragma option push -b-
enum TZScopeBestRowIdentifier { sbrTemporary, sbrTransaction, sbrSession };
#pragma option pop

#pragma option push -b-
enum TZVersionColumn { vcUnknown, vcNotPseudo, vcPseudo };
#pragma option pop

#pragma option push -b-
enum TZImportedKey { ikCascade, ikRestrict, ikSetNull, ikNoAction, ikSetDefault, ikInitiallyDeferred, 
	ikInitiallyImmediate, ikNotDeferrable };
#pragma option pop

#pragma option push -b-
enum TZTableIndex { tiStatistic, tiClustered, tiHashed, tiOther };
#pragma option pop

#pragma option push -b-
enum TZPostUpdatesMode { poColumnsAll, poColumnsChanged };
#pragma option pop

#pragma option push -b-
enum TZLocateUpdatesMode { loWhereAll, loWhereChanged, loWhereKeyOnly };
#pragma option pop

__interface IZDriverManager;
typedef System::DelphiInterface<IZDriverManager> _di_IZDriverManager;
__interface IZConnection;
typedef System::DelphiInterface<IZConnection> _di_IZConnection;
__interface IZDriver;
typedef System::DelphiInterface<IZDriver> _di_IZDriver;
__interface INTERFACE_UUID("{8874B9AA-068A-4C0C-AE75-9DB1EA9E3720}") IZDriverManager  : public IUnknown 
	
{
	
public:
	virtual _di_IZConnection __fastcall GetConnection(AnsiString Url) = 0 ;
	virtual _di_IZConnection __fastcall GetConnectionWithParams(AnsiString Url, Classes::TStrings* Info
		) = 0 ;
	virtual _di_IZConnection __fastcall GetConnectionWithLogin(AnsiString Url, AnsiString User, AnsiString 
		Password) = 0 ;
	virtual _di_IZDriver __fastcall GetDriver(AnsiString Url) = 0 ;
	virtual void __fastcall RegisterDriver(_di_IZDriver Driver) = 0 ;
	virtual void __fastcall DeregisterDriver(_di_IZDriver Driver) = 0 ;
	virtual Zclasses::_di_IZCollection __fastcall GetDrivers(void) = 0 ;
	virtual int __fastcall GetLoginTimeout(void) = 0 ;
	virtual void __fastcall SetLoginTimeout(int Seconds) = 0 ;
	virtual void __fastcall AddLoggingListener(Zdbclogging::_di_IZLoggingListener Listener) = 0 ;
	virtual void __fastcall RemoveLoggingListener(Zdbclogging::_di_IZLoggingListener Listener) = 0 ;
	virtual void __fastcall LogMessage(Zdbclogging::TZLoggingCategory Category, AnsiString Protocol, AnsiString 
		Msg) = 0 ;
	virtual void __fastcall LogError(Zdbclogging::TZLoggingCategory Category, AnsiString Protocol, AnsiString 
		Msg, int ErrorCode, AnsiString Error) = 0 ;
};

__interface INTERFACE_UUID("{2157710E-FBD8-417C-8541-753B585332E2}") IZDriver  : public IUnknown 
{
	
public:
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols(void) = 0 ;
	virtual _di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info) = 0 ;
	virtual bool __fastcall AcceptsURL(AnsiString Url) = 0 ;
	virtual Classes::TStrings* __fastcall GetPropertyInfo(AnsiString Url, Classes::TStrings* Info) = 0 
		;
	virtual int __fastcall GetMajorVersion(void) = 0 ;
	virtual int __fastcall GetMinorVersion(void) = 0 ;
};

__interface IZStatement;
typedef System::DelphiInterface<IZStatement> _di_IZStatement;
__interface IZPreparedStatement;
typedef System::DelphiInterface<IZPreparedStatement> _di_IZPreparedStatement;
__interface IZCallableStatement;
typedef System::DelphiInterface<IZCallableStatement> _di_IZCallableStatement;
__interface IZNotification;
typedef System::DelphiInterface<IZNotification> _di_IZNotification;
__interface IZSequence;
typedef System::DelphiInterface<IZSequence> _di_IZSequence;
__interface IZDatabaseMetadata;
typedef System::DelphiInterface<IZDatabaseMetadata> _di_IZDatabaseMetadata;
__interface INTERFACE_UUID("{8EEBBD1A-56D1-4EC0-B3BD-42B60591457F}") IZConnection  : public IUnknown 
	
{
	
public:
	virtual _di_IZStatement __fastcall CreateStatement(void) = 0 ;
	virtual _di_IZPreparedStatement __fastcall PrepareStatement(AnsiString SQL) = 0 ;
	virtual _di_IZCallableStatement __fastcall PrepareCall(AnsiString SQL) = 0 ;
	virtual _di_IZStatement __fastcall CreateStatementWithParams(Classes::TStrings* Info) = 0 ;
	virtual _di_IZPreparedStatement __fastcall PrepareStatementWithParams(AnsiString SQL, Classes::TStrings* 
		Info) = 0 ;
	virtual _di_IZCallableStatement __fastcall PrepareCallWithParams(AnsiString SQL, Classes::TStrings* 
		Info) = 0 ;
	virtual _di_IZNotification __fastcall CreateNotification(AnsiString Event) = 0 ;
	virtual _di_IZSequence __fastcall CreateSequence(AnsiString Sequence, int BlockSize) = 0 ;
	virtual AnsiString __fastcall NativeSQL(AnsiString SQL) = 0 ;
	virtual void __fastcall SetAutoCommit(bool Value) = 0 ;
	virtual bool __fastcall GetAutoCommit(void) = 0 ;
	virtual void __fastcall Commit(void) = 0 ;
	virtual void __fastcall Rollback(void) = 0 ;
	virtual void __fastcall Open(void) = 0 ;
	virtual void __fastcall Close(void) = 0 ;
	virtual bool __fastcall IsClosed(void) = 0 ;
	virtual _di_IZDatabaseMetadata __fastcall GetMetadata(void) = 0 ;
	virtual Classes::TStrings* __fastcall GetParameters(void) = 0 ;
	virtual void __fastcall SetReadOnly(bool Value) = 0 ;
	virtual bool __fastcall IsReadOnly(void) = 0 ;
	virtual void __fastcall SetCatalog(AnsiString Value) = 0 ;
	virtual AnsiString __fastcall GetCatalog(void) = 0 ;
	virtual void __fastcall SetTransactionIsolation(TZTransactIsolationLevel Value) = 0 ;
	virtual TZTransactIsolationLevel __fastcall GetTransactionIsolation(void) = 0 ;
	virtual EZSQLWarning* __fastcall GetWarnings(void) = 0 ;
	virtual void __fastcall ClearWarnings(void) = 0 ;
};

__interface IZResultSet;
typedef System::DelphiInterface<IZResultSet> _di_IZResultSet;
__interface INTERFACE_UUID("{FE331C2D-0664-464E-A981-B4F65B85D1A8}") IZDatabaseMetadata  : public IUnknown 
	
{
	
public:
	virtual bool __fastcall AllProceduresAreCallable(void) = 0 ;
	virtual bool __fastcall AllTablesAreSelectable(void) = 0 ;
	virtual AnsiString __fastcall GetURL(void) = 0 ;
	virtual AnsiString __fastcall GetUserName(void) = 0 ;
	virtual bool __fastcall IsReadOnly(void) = 0 ;
	virtual bool __fastcall NullsAreSortedHigh(void) = 0 ;
	virtual bool __fastcall NullsAreSortedLow(void) = 0 ;
	virtual bool __fastcall NullsAreSortedAtStart(void) = 0 ;
	virtual bool __fastcall NullsAreSortedAtEnd(void) = 0 ;
	virtual AnsiString __fastcall GetDatabaseProductName(void) = 0 ;
	virtual AnsiString __fastcall GetDatabaseProductVersion(void) = 0 ;
	virtual AnsiString __fastcall GetDriverName(void) = 0 ;
	virtual AnsiString __fastcall GetDriverVersion(void) = 0 ;
	virtual int __fastcall GetDriverMajorVersion(void) = 0 ;
	virtual int __fastcall GetDriverMinorVersion(void) = 0 ;
	virtual bool __fastcall UsesLocalFiles(void) = 0 ;
	virtual bool __fastcall UsesLocalFilePerTable(void) = 0 ;
	virtual bool __fastcall SupportsMixedCaseIdentifiers(void) = 0 ;
	virtual bool __fastcall StoresUpperCaseIdentifiers(void) = 0 ;
	virtual bool __fastcall StoresLowerCaseIdentifiers(void) = 0 ;
	virtual bool __fastcall StoresMixedCaseIdentifiers(void) = 0 ;
	virtual bool __fastcall SupportsMixedCaseQuotedIdentifiers(void) = 0 ;
	virtual bool __fastcall StoresUpperCaseQuotedIdentifiers(void) = 0 ;
	virtual bool __fastcall StoresLowerCaseQuotedIdentifiers(void) = 0 ;
	virtual bool __fastcall StoresMixedCaseQuotedIdentifiers(void) = 0 ;
	virtual AnsiString __fastcall GetIdentifierQuoteString(void) = 0 ;
	virtual AnsiString __fastcall GetSQLKeywords(void) = 0 ;
	virtual AnsiString __fastcall GetNumericFunctions(void) = 0 ;
	virtual AnsiString __fastcall GetStringFunctions(void) = 0 ;
	virtual AnsiString __fastcall GetSystemFunctions(void) = 0 ;
	virtual AnsiString __fastcall GetTimeDateFunctions(void) = 0 ;
	virtual AnsiString __fastcall GetSearchStringEscape(void) = 0 ;
	virtual AnsiString __fastcall GetExtraNameCharacters(void) = 0 ;
	virtual bool __fastcall SupportsAlterTableWithAddColumn(void) = 0 ;
	virtual bool __fastcall SupportsAlterTableWithDropColumn(void) = 0 ;
	virtual bool __fastcall SupportsColumnAliasing(void) = 0 ;
	virtual bool __fastcall NullPlusNonNullIsNull(void) = 0 ;
	virtual bool __fastcall SupportsConvert(void) = 0 ;
	virtual bool __fastcall SupportsConvertForTypes(TZSQLType FromType, TZSQLType ToType) = 0 ;
	virtual bool __fastcall SupportsTableCorrelationNames(void) = 0 ;
	virtual bool __fastcall SupportsDifferentTableCorrelationNames(void) = 0 ;
	virtual bool __fastcall SupportsExpressionsInOrderBy(void) = 0 ;
	virtual bool __fastcall SupportsOrderByUnrelated(void) = 0 ;
	virtual bool __fastcall SupportsGroupBy(void) = 0 ;
	virtual bool __fastcall SupportsGroupByUnrelated(void) = 0 ;
	virtual bool __fastcall SupportsGroupByBeyondSelect(void) = 0 ;
	virtual bool __fastcall SupportsLikeEscapeClause(void) = 0 ;
	virtual bool __fastcall SupportsMultipleResultSets(void) = 0 ;
	virtual bool __fastcall SupportsMultipleTransactions(void) = 0 ;
	virtual bool __fastcall SupportsNonNullableColumns(void) = 0 ;
	virtual bool __fastcall SupportsMinimumSQLGrammar(void) = 0 ;
	virtual bool __fastcall SupportsCoreSQLGrammar(void) = 0 ;
	virtual bool __fastcall SupportsExtendedSQLGrammar(void) = 0 ;
	virtual bool __fastcall SupportsANSI92EntryLevelSQL(void) = 0 ;
	virtual bool __fastcall SupportsANSI92IntermediateSQL(void) = 0 ;
	virtual bool __fastcall SupportsANSI92FullSQL(void) = 0 ;
	virtual bool __fastcall SupportsIntegrityEnhancementFacility(void) = 0 ;
	virtual bool __fastcall SupportsOuterJoins(void) = 0 ;
	virtual bool __fastcall SupportsFullOuterJoins(void) = 0 ;
	virtual bool __fastcall SupportsLimitedOuterJoins(void) = 0 ;
	virtual AnsiString __fastcall GetSchemaTerm(void) = 0 ;
	virtual AnsiString __fastcall GetProcedureTerm(void) = 0 ;
	virtual AnsiString __fastcall GetCatalogTerm(void) = 0 ;
	virtual bool __fastcall IsCatalogAtStart(void) = 0 ;
	virtual AnsiString __fastcall GetCatalogSeparator(void) = 0 ;
	virtual bool __fastcall SupportsSchemasInDataManipulation(void) = 0 ;
	virtual bool __fastcall SupportsSchemasInProcedureCalls(void) = 0 ;
	virtual bool __fastcall SupportsSchemasInTableDefinitions(void) = 0 ;
	virtual bool __fastcall SupportsSchemasInIndexDefinitions(void) = 0 ;
	virtual bool __fastcall SupportsSchemasInPrivilegeDefinitions(void) = 0 ;
	virtual bool __fastcall SupportsCatalogsInDataManipulation(void) = 0 ;
	virtual bool __fastcall SupportsCatalogsInProcedureCalls(void) = 0 ;
	virtual bool __fastcall SupportsCatalogsInTableDefinitions(void) = 0 ;
	virtual bool __fastcall SupportsCatalogsInIndexDefinitions(void) = 0 ;
	virtual bool __fastcall SupportsCatalogsInPrivilegeDefinitions(void) = 0 ;
	virtual bool __fastcall SupportsPositionedDelete(void) = 0 ;
	virtual bool __fastcall SupportsPositionedUpdate(void) = 0 ;
	virtual bool __fastcall SupportsSelectForUpdate(void) = 0 ;
	virtual bool __fastcall SupportsStoredProcedures(void) = 0 ;
	virtual bool __fastcall SupportsSubqueriesInComparisons(void) = 0 ;
	virtual bool __fastcall SupportsSubqueriesInExists(void) = 0 ;
	virtual bool __fastcall SupportsSubqueriesInIns(void) = 0 ;
	virtual bool __fastcall SupportsSubqueriesInQuantifieds(void) = 0 ;
	virtual bool __fastcall SupportsCorrelatedSubqueries(void) = 0 ;
	virtual bool __fastcall SupportsUnion(void) = 0 ;
	virtual bool __fastcall SupportsUnionAll(void) = 0 ;
	virtual bool __fastcall SupportsOpenCursorsAcrossCommit(void) = 0 ;
	virtual bool __fastcall SupportsOpenCursorsAcrossRollback(void) = 0 ;
	virtual bool __fastcall SupportsOpenStatementsAcrossCommit(void) = 0 ;
	virtual bool __fastcall SupportsOpenStatementsAcrossRollback(void) = 0 ;
	virtual int __fastcall GetMaxBinaryLiteralLength(void) = 0 ;
	virtual int __fastcall GetMaxCharLiteralLength(void) = 0 ;
	virtual int __fastcall GetMaxColumnNameLength(void) = 0 ;
	virtual int __fastcall GetMaxColumnsInGroupBy(void) = 0 ;
	virtual int __fastcall GetMaxColumnsInIndex(void) = 0 ;
	virtual int __fastcall GetMaxColumnsInOrderBy(void) = 0 ;
	virtual int __fastcall GetMaxColumnsInSelect(void) = 0 ;
	virtual int __fastcall GetMaxColumnsInTable(void) = 0 ;
	virtual int __fastcall GetMaxConnections(void) = 0 ;
	virtual int __fastcall GetMaxCursorNameLength(void) = 0 ;
	virtual int __fastcall GetMaxIndexLength(void) = 0 ;
	virtual int __fastcall GetMaxSchemaNameLength(void) = 0 ;
	virtual int __fastcall GetMaxProcedureNameLength(void) = 0 ;
	virtual int __fastcall GetMaxCatalogNameLength(void) = 0 ;
	virtual int __fastcall GetMaxRowSize(void) = 0 ;
	virtual bool __fastcall DoesMaxRowSizeIncludeBlobs(void) = 0 ;
	virtual int __fastcall GetMaxStatementLength(void) = 0 ;
	virtual int __fastcall GetMaxStatements(void) = 0 ;
	virtual int __fastcall GetMaxTableNameLength(void) = 0 ;
	virtual int __fastcall GetMaxTablesInSelect(void) = 0 ;
	virtual int __fastcall GetMaxUserNameLength(void) = 0 ;
	virtual TZTransactIsolationLevel __fastcall GetDefaultTransactionIsolation(void) = 0 ;
	virtual bool __fastcall SupportsTransactions(void) = 0 ;
	virtual bool __fastcall SupportsTransactionIsolationLevel(TZTransactIsolationLevel Level) = 0 ;
	virtual bool __fastcall SupportsDataDefinitionAndDataManipulationTransactions(void) = 0 ;
	virtual bool __fastcall SupportsDataManipulationTransactionsOnly(void) = 0 ;
	virtual bool __fastcall DataDefinitionCausesTransactionCommit(void) = 0 ;
	virtual bool __fastcall DataDefinitionIgnoredInTransactions(void) = 0 ;
	virtual _di_IZResultSet __fastcall GetProcedures(AnsiString Catalog, AnsiString SchemaPattern, AnsiString 
		ProcedureNamePattern) = 0 ;
	virtual _di_IZResultSet __fastcall GetProcedureColumns(AnsiString Catalog, AnsiString SchemaPattern
		, AnsiString ProcedureNamePattern, AnsiString ColumnNamePattern) = 0 ;
	virtual _di_IZResultSet __fastcall GetTables(AnsiString Catalog, AnsiString SchemaPattern, AnsiString 
		TableNamePattern, Zcompatibility::TStringDynArray Types) = 0 ;
	virtual _di_IZResultSet __fastcall GetSchemas(void) = 0 ;
	virtual _di_IZResultSet __fastcall GetCatalogs(void) = 0 ;
	virtual _di_IZResultSet __fastcall GetTableTypes(void) = 0 ;
	virtual _di_IZResultSet __fastcall GetColumns(AnsiString Catalog, AnsiString SchemaPattern, AnsiString 
		TableNamePattern, AnsiString ColumnNamePattern) = 0 ;
	virtual _di_IZResultSet __fastcall GetColumnPrivileges(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table, AnsiString ColumnNamePattern) = 0 ;
	virtual _di_IZResultSet __fastcall GetTablePrivileges(AnsiString Catalog, AnsiString SchemaPattern, 
		AnsiString TableNamePattern) = 0 ;
	virtual _di_IZResultSet __fastcall GetBestRowIdentifier(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table, int Scope, bool Nullable) = 0 ;
	virtual _di_IZResultSet __fastcall GetVersionColumns(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table) = 0 ;
	virtual _di_IZResultSet __fastcall GetPrimaryKeys(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table) = 0 ;
	virtual _di_IZResultSet __fastcall GetImportedKeys(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table) = 0 ;
	virtual _di_IZResultSet __fastcall GetExportedKeys(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table) = 0 ;
	virtual _di_IZResultSet __fastcall GetCrossReference(AnsiString PrimaryCatalog, AnsiString PrimarySchema
		, AnsiString PrimaryTable, AnsiString ForeignCatalog, AnsiString ForeignSchema, AnsiString ForeignTable
		) = 0 ;
	virtual _di_IZResultSet __fastcall GetTypeInfo(void) = 0 ;
	virtual _di_IZResultSet __fastcall GetIndexInfo(AnsiString Catalog, AnsiString Schema, AnsiString Table
		, bool Unique, bool Approximate) = 0 ;
	virtual bool __fastcall SupportsResultSetType(TZResultSetType _Type) = 0 ;
	virtual bool __fastcall SupportsResultSetConcurrency(TZResultSetType _Type, TZResultSetConcurrency 
		Concurrency) = 0 ;
	virtual bool __fastcall SupportsBatchUpdates(void) = 0 ;
	virtual _di_IZResultSet __fastcall GetUDTs(AnsiString Catalog, AnsiString SchemaPattern, AnsiString 
		TypeNamePattern, Zcompatibility::TIntegerDynArray Types) = 0 ;
	virtual _di_IZConnection __fastcall GetConnection(void) = 0 ;
	virtual Ztokenizer::_di_IZTokenizer __fastcall GetTokenizer(void) = 0 ;
	virtual Zgenericsqlanalyser::_di_IZStatementAnalyser __fastcall GetStatementAnalyser(void) = 0 ;
	virtual Zselectschema::_di_IZIdentifierConvertor __fastcall GetIdentifierConvertor(void) = 0 ;
	virtual void __fastcall ClearCache(void) = 0 ;
};

__interface INTERFACE_UUID("{22CEFA7E-6A6D-48EC-BB9B-EE66056E90F1}") IZStatement  : public IUnknown 
	
{
	
public:
	virtual _di_IZResultSet __fastcall ExecuteQuery(AnsiString SQL) = 0 ;
	virtual int __fastcall ExecuteUpdate(AnsiString SQL) = 0 ;
	virtual void __fastcall Close(void) = 0 ;
	virtual int __fastcall GetMaxFieldSize(void) = 0 ;
	virtual void __fastcall SetMaxFieldSize(int Value) = 0 ;
	virtual int __fastcall GetMaxRows(void) = 0 ;
	virtual void __fastcall SetMaxRows(int Value) = 0 ;
	virtual void __fastcall SetEscapeProcessing(bool Value) = 0 ;
	virtual int __fastcall GetQueryTimeout(void) = 0 ;
	virtual void __fastcall SetQueryTimeout(int Value) = 0 ;
	virtual void __fastcall Cancel(void) = 0 ;
	virtual void __fastcall SetCursorName(AnsiString Value) = 0 ;
	virtual bool __fastcall Execute(AnsiString SQL) = 0 ;
	virtual _di_IZResultSet __fastcall GetResultSet(void) = 0 ;
	virtual int __fastcall GetUpdateCount(void) = 0 ;
	virtual bool __fastcall GetMoreResults(void) = 0 ;
	virtual void __fastcall SetFetchDirection(TZFetchDirection Value) = 0 ;
	virtual TZFetchDirection __fastcall GetFetchDirection(void) = 0 ;
	virtual void __fastcall SetFetchSize(int Value) = 0 ;
	virtual int __fastcall GetFetchSize(void) = 0 ;
	virtual void __fastcall SetResultSetConcurrency(TZResultSetConcurrency Value) = 0 ;
	virtual TZResultSetConcurrency __fastcall GetResultSetConcurrency(void) = 0 ;
	virtual void __fastcall SetResultSetType(TZResultSetType Value) = 0 ;
	virtual TZResultSetType __fastcall GetResultSetType(void) = 0 ;
	virtual void __fastcall SetPostUpdates(TZPostUpdatesMode Value) = 0 ;
	virtual TZPostUpdatesMode __fastcall GetPostUpdates(void) = 0 ;
	virtual void __fastcall SetLocateUpdates(TZLocateUpdatesMode Value) = 0 ;
	virtual TZLocateUpdatesMode __fastcall GetLocateUpdates(void) = 0 ;
	virtual void __fastcall AddBatch(AnsiString SQL) = 0 ;
	virtual void __fastcall ClearBatch(void) = 0 ;
	virtual Zcompatibility::TIntegerDynArray __fastcall ExecuteBatch(void) = 0 ;
	virtual _di_IZConnection __fastcall GetConnection(void) = 0 ;
	virtual Classes::TStrings* __fastcall GetParameters(void) = 0 ;
	virtual EZSQLWarning* __fastcall GetWarnings(void) = 0 ;
	virtual void __fastcall ClearWarnings(void) = 0 ;
};

__interface IZBlob;
typedef System::DelphiInterface<IZBlob> _di_IZBlob;
__interface IZResultSetMetadata;
typedef System::DelphiInterface<IZResultSetMetadata> _di_IZResultSetMetadata;
__interface INTERFACE_UUID("{990B8477-AF11-4090-8821-5B7AFEA9DD70}") IZPreparedStatement  : public IZStatement 
	
{
	
public:
	virtual _di_IZResultSet __fastcall ExecuteQueryPrepared(void) = 0 ;
	virtual int __fastcall ExecuteUpdatePrepared(void) = 0 ;
	virtual bool __fastcall ExecutePrepared(void) = 0 ;
	virtual void __fastcall SetNull(int ParameterIndex, TZSQLType SQLType) = 0 ;
	virtual void __fastcall SetBoolean(int ParameterIndex, bool Value) = 0 ;
	virtual void __fastcall SetByte(int ParameterIndex, Shortint Value) = 0 ;
	virtual void __fastcall SetShort(int ParameterIndex, short Value) = 0 ;
	virtual void __fastcall SetInt(int ParameterIndex, int Value) = 0 ;
	virtual void __fastcall SetLong(int ParameterIndex, __int64 Value) = 0 ;
	virtual void __fastcall SetFloat(int ParameterIndex, float Value) = 0 ;
	virtual void __fastcall SetDouble(int ParameterIndex, double Value) = 0 ;
	virtual void __fastcall SetBigDecimal(int ParameterIndex, Extended Value) = 0 ;
	virtual void __fastcall SetPChar(int ParameterIndex, char * Value) = 0 ;
	virtual void __fastcall SetString(int ParameterIndex, AnsiString Value) = 0 ;
	virtual void __fastcall SetUnicodeString(int ParameterIndex, WideString Value) = 0 ;
	virtual void __fastcall SetBytes(int ParameterIndex, Zcompatibility::TByteDynArray Value) = 0 ;
	virtual void __fastcall SetDate(int ParameterIndex, System::TDateTime Value) = 0 ;
	virtual void __fastcall SetTime(int ParameterIndex, System::TDateTime Value) = 0 ;
	virtual void __fastcall SetTimestamp(int ParameterIndex, System::TDateTime Value) = 0 ;
	virtual void __fastcall SetAsciiStream(int ParameterIndex, Classes::TStream* Value) = 0 ;
	virtual void __fastcall SetUnicodeStream(int ParameterIndex, Classes::TStream* Value) = 0 ;
	virtual void __fastcall SetBinaryStream(int ParameterIndex, Classes::TStream* Value) = 0 ;
	virtual void __fastcall SetBlob(int ParameterIndex, TZSQLType SQLType, _di_IZBlob Value) = 0 ;
	virtual void __fastcall SetValue(int ParameterIndex, const Zvariant::TZVariant &Value) = 0 ;
	virtual void __fastcall ClearParameters(void) = 0 ;
	virtual void __fastcall AddBatchPrepared(void) = 0 ;
	virtual _di_IZResultSetMetadata __fastcall GetMetadata(void) = 0 ;
};

__interface INTERFACE_UUID("{E6FA6C18-C764-4C05-8FCB-0582BDD1EF40}") IZCallableStatement  : public IZPreparedStatement 
	
{
	
public:
	virtual void __fastcall RegisterOutParameter(int ParameterIndex, int SQLType) = 0 ;
	virtual bool __fastcall WasNull(void) = 0 ;
	virtual bool __fastcall IsNull(int ParameterIndex) = 0 ;
	virtual char * __fastcall GetPChar(int ParameterIndex) = 0 ;
	virtual AnsiString __fastcall GetString(int ParameterIndex) = 0 ;
	virtual WideString __fastcall GetUnicodeString(int ParameterIndex) = 0 ;
	virtual bool __fastcall GetBoolean(int ParameterIndex) = 0 ;
	virtual Shortint __fastcall GetByte(int ParameterIndex) = 0 ;
	virtual short __fastcall GetShort(int ParameterIndex) = 0 ;
	virtual int __fastcall GetInt(int ParameterIndex) = 0 ;
	virtual __int64 __fastcall GetLong(int ParameterIndex) = 0 ;
	virtual float __fastcall GetFloat(int ParameterIndex) = 0 ;
	virtual double __fastcall GetDouble(int ParameterIndex) = 0 ;
	virtual Extended __fastcall GetBigDecimal(int ParameterIndex) = 0 ;
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(int ParameterIndex) = 0 ;
	virtual System::TDateTime __fastcall GetDate(int ParameterIndex) = 0 ;
	virtual System::TDateTime __fastcall GetTime(int ParameterIndex) = 0 ;
	virtual System::TDateTime __fastcall GetTimestamp(int ParameterIndex) = 0 ;
	virtual Zvariant::TZVariant __fastcall GetValue(int ParameterIndex) = 0 ;
};

__interface INTERFACE_UUID("{8F4C4D10-2425-409E-96A9-7142007CC1B2}") IZResultSet  : public IUnknown 
	
{
	
public:
	virtual bool __fastcall Next(void) = 0 ;
	virtual void __fastcall Close(void) = 0 ;
	virtual bool __fastcall WasNull(void) = 0 ;
	virtual bool __fastcall IsNull(int ColumnIndex) = 0 ;
	virtual char * __fastcall GetPChar(int ColumnIndex) = 0 ;
	virtual AnsiString __fastcall GetString(int ColumnIndex) = 0 ;
	virtual WideString __fastcall GetUnicodeString(int ColumnIndex) = 0 ;
	virtual bool __fastcall GetBoolean(int ColumnIndex) = 0 ;
	virtual Shortint __fastcall GetByte(int ColumnIndex) = 0 ;
	virtual short __fastcall GetShort(int ColumnIndex) = 0 ;
	virtual int __fastcall GetInt(int ColumnIndex) = 0 ;
	virtual __int64 __fastcall GetLong(int ColumnIndex) = 0 ;
	virtual float __fastcall GetFloat(int ColumnIndex) = 0 ;
	virtual double __fastcall GetDouble(int ColumnIndex) = 0 ;
	virtual Extended __fastcall GetBigDecimal(int ColumnIndex) = 0 ;
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(int ColumnIndex) = 0 ;
	virtual System::TDateTime __fastcall GetDate(int ColumnIndex) = 0 ;
	virtual System::TDateTime __fastcall GetTime(int ColumnIndex) = 0 ;
	virtual System::TDateTime __fastcall GetTimestamp(int ColumnIndex) = 0 ;
	virtual Classes::TStream* __fastcall GetAsciiStream(int ColumnIndex) = 0 ;
	virtual Classes::TStream* __fastcall GetUnicodeStream(int ColumnIndex) = 0 ;
	virtual Classes::TStream* __fastcall GetBinaryStream(int ColumnIndex) = 0 ;
	virtual _di_IZBlob __fastcall GetBlob(int ColumnIndex) = 0 ;
	virtual Zvariant::TZVariant __fastcall GetValue(int ColumnIndex) = 0 ;
	virtual bool __fastcall IsNullByName(AnsiString ColumnName) = 0 ;
	virtual char * __fastcall GetPCharByName(AnsiString ColumnName) = 0 ;
	virtual AnsiString __fastcall GetStringByName(AnsiString ColumnName) = 0 ;
	virtual WideString __fastcall GetUnicodeStringByName(AnsiString ColumnName) = 0 ;
	virtual bool __fastcall GetBooleanByName(AnsiString ColumnName) = 0 ;
	virtual Shortint __fastcall GetByteByName(AnsiString ColumnName) = 0 ;
	virtual short __fastcall GetShortByName(AnsiString ColumnName) = 0 ;
	virtual int __fastcall GetIntByName(AnsiString ColumnName) = 0 ;
	virtual __int64 __fastcall GetLongByName(AnsiString ColumnName) = 0 ;
	virtual float __fastcall GetFloatByName(AnsiString ColumnName) = 0 ;
	virtual double __fastcall GetDoubleByName(AnsiString ColumnName) = 0 ;
	virtual Extended __fastcall GetBigDecimalByName(AnsiString ColumnName) = 0 ;
	virtual Zcompatibility::TByteDynArray __fastcall GetBytesByName(AnsiString ColumnName) = 0 ;
	virtual System::TDateTime __fastcall GetDateByName(AnsiString ColumnName) = 0 ;
	virtual System::TDateTime __fastcall GetTimeByName(AnsiString ColumnName) = 0 ;
	virtual System::TDateTime __fastcall GetTimestampByName(AnsiString ColumnName) = 0 ;
	virtual Classes::TStream* __fastcall GetAsciiStreamByName(AnsiString ColumnName) = 0 ;
	virtual Classes::TStream* __fastcall GetUnicodeStreamByName(AnsiString ColumnName) = 0 ;
	virtual Classes::TStream* __fastcall GetBinaryStreamByName(AnsiString ColumnName) = 0 ;
	virtual _di_IZBlob __fastcall GetBlobByName(AnsiString ColumnName) = 0 ;
	virtual Zvariant::TZVariant __fastcall GetValueByName(AnsiString ColumnName) = 0 ;
	virtual EZSQLWarning* __fastcall GetWarnings(void) = 0 ;
	virtual void __fastcall ClearWarnings(void) = 0 ;
	virtual AnsiString __fastcall GetCursorName(void) = 0 ;
	virtual _di_IZResultSetMetadata __fastcall GetMetadata(void) = 0 ;
	virtual int __fastcall FindColumn(AnsiString ColumnName) = 0 ;
	virtual bool __fastcall IsBeforeFirst(void) = 0 ;
	virtual bool __fastcall IsAfterLast(void) = 0 ;
	virtual bool __fastcall IsFirst(void) = 0 ;
	virtual bool __fastcall IsLast(void) = 0 ;
	virtual void __fastcall BeforeFirst(void) = 0 ;
	virtual void __fastcall AfterLast(void) = 0 ;
	virtual bool __fastcall First(void) = 0 ;
	virtual bool __fastcall Last(void) = 0 ;
	virtual int __fastcall GetRow(void) = 0 ;
	virtual bool __fastcall MoveAbsolute(int Row) = 0 ;
	virtual bool __fastcall MoveRelative(int Rows) = 0 ;
	virtual bool __fastcall Previous(void) = 0 ;
	virtual void __fastcall SetFetchDirection(TZFetchDirection Value) = 0 ;
	virtual TZFetchDirection __fastcall GetFetchDirection(void) = 0 ;
	virtual void __fastcall SetFetchSize(int Value) = 0 ;
	virtual int __fastcall GetFetchSize(void) = 0 ;
	virtual TZResultSetType __fastcall GetType(void) = 0 ;
	virtual TZResultSetConcurrency __fastcall GetConcurrency(void) = 0 ;
	virtual TZPostUpdatesMode __fastcall GetPostUpdates(void) = 0 ;
	virtual TZLocateUpdatesMode __fastcall GetLocateUpdates(void) = 0 ;
	virtual bool __fastcall RowUpdated(void) = 0 ;
	virtual bool __fastcall RowInserted(void) = 0 ;
	virtual bool __fastcall RowDeleted(void) = 0 ;
	virtual void __fastcall UpdateNull(int ColumnIndex) = 0 ;
	virtual void __fastcall UpdateBoolean(int ColumnIndex, bool Value) = 0 ;
	virtual void __fastcall UpdateByte(int ColumnIndex, Shortint Value) = 0 ;
	virtual void __fastcall UpdateShort(int ColumnIndex, short Value) = 0 ;
	virtual void __fastcall UpdateInt(int ColumnIndex, int Value) = 0 ;
	virtual void __fastcall UpdateLong(int ColumnIndex, __int64 Value) = 0 ;
	virtual void __fastcall UpdateFloat(int ColumnIndex, float Value) = 0 ;
	virtual void __fastcall UpdateDouble(int ColumnIndex, double Value) = 0 ;
	virtual void __fastcall UpdateBigDecimal(int ColumnIndex, Extended Value) = 0 ;
	virtual void __fastcall UpdatePChar(int ColumnIndex, char * Value) = 0 ;
	virtual void __fastcall UpdateString(int ColumnIndex, AnsiString Value) = 0 ;
	virtual void __fastcall UpdateUnicodeString(int ColumnIndex, WideString Value) = 0 ;
	virtual void __fastcall UpdateBytes(int ColumnIndex, Zcompatibility::TByteDynArray Value) = 0 ;
	virtual void __fastcall UpdateDate(int ColumnIndex, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateTime(int ColumnIndex, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateTimestamp(int ColumnIndex, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateAsciiStream(int ColumnIndex, Classes::TStream* Value) = 0 ;
	virtual void __fastcall UpdateUnicodeStream(int ColumnIndex, Classes::TStream* Value) = 0 ;
	virtual void __fastcall UpdateBinaryStream(int ColumnIndex, Classes::TStream* Value) = 0 ;
	virtual void __fastcall UpdateValue(int ColumnIndex, const Zvariant::TZVariant &Value) = 0 ;
	virtual void __fastcall UpdateNullByName(AnsiString ColumnName) = 0 ;
	virtual void __fastcall UpdateBooleanByName(AnsiString ColumnName, bool Value) = 0 ;
	virtual void __fastcall UpdateByteByName(AnsiString ColumnName, Shortint Value) = 0 ;
	virtual void __fastcall UpdateShortByName(AnsiString ColumnName, short Value) = 0 ;
	virtual void __fastcall UpdateIntByName(AnsiString ColumnName, int Value) = 0 ;
	virtual void __fastcall UpdateLongByName(AnsiString ColumnName, __int64 Value) = 0 ;
	virtual void __fastcall UpdateFloatByName(AnsiString ColumnName, float Value) = 0 ;
	virtual void __fastcall UpdateDoubleByName(AnsiString ColumnName, double Value) = 0 ;
	virtual void __fastcall UpdateBigDecimalByName(AnsiString ColumnName, Extended Value) = 0 ;
	virtual void __fastcall UpdatePCharByName(AnsiString ColumnName, char * Value) = 0 ;
	virtual void __fastcall UpdateStringByName(AnsiString ColumnName, AnsiString Value) = 0 ;
	virtual void __fastcall UpdateUnicodeStringByName(AnsiString ColumnName, WideString Value) = 0 ;
	virtual void __fastcall UpdateBytesByName(AnsiString ColumnName, Zcompatibility::TByteDynArray Value
		) = 0 ;
	virtual void __fastcall UpdateDateByName(AnsiString ColumnName, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateTimeByName(AnsiString ColumnName, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateTimestampByName(AnsiString ColumnName, System::TDateTime Value) = 0 ;
		
	virtual void __fastcall UpdateAsciiStreamByName(AnsiString ColumnName, Classes::TStream* Value) = 0 
		;
	virtual void __fastcall UpdateUnicodeStreamByName(AnsiString ColumnName, Classes::TStream* Value) = 0 
		;
	virtual void __fastcall UpdateBinaryStreamByName(AnsiString ColumnName, Classes::TStream* Value) = 0 
		;
	virtual void __fastcall UpdateValueByName(AnsiString ColumnName, const Zvariant::TZVariant &Value) = 0 
		;
	virtual void __fastcall InsertRow(void) = 0 ;
	virtual void __fastcall UpdateRow(void) = 0 ;
	virtual void __fastcall DeleteRow(void) = 0 ;
	virtual void __fastcall RefreshRow(void) = 0 ;
	virtual void __fastcall CancelRowUpdates(void) = 0 ;
	virtual void __fastcall MoveToInsertRow(void) = 0 ;
	virtual void __fastcall MoveToCurrentRow(void) = 0 ;
	virtual int __fastcall CompareRows(int Row1, int Row2, Zcompatibility::TIntegerDynArray ColumnIndices
		, Zcompatibility::TBooleanDynArray ColumnDirs) = 0 ;
	virtual _di_IZStatement __fastcall GetStatement(void) = 0 ;
};

__interface INTERFACE_UUID("{47CA2144-2EA7-42C4-8444-F5154369B2D7}") IZResultSetMetadata  : public IUnknown 
	
{
	
public:
	virtual int __fastcall GetColumnCount(void) = 0 ;
	virtual bool __fastcall IsAutoIncrement(int Column) = 0 ;
	virtual bool __fastcall IsCaseSensitive(int Column) = 0 ;
	virtual bool __fastcall IsSearchable(int Column) = 0 ;
	virtual bool __fastcall IsCurrency(int Column) = 0 ;
	virtual TZColumnNullableType __fastcall IsNullable(int Column) = 0 ;
	virtual bool __fastcall IsSigned(int Column) = 0 ;
	virtual int __fastcall GetColumnDisplaySize(int Column) = 0 ;
	virtual AnsiString __fastcall GetColumnLabel(int Column) = 0 ;
	virtual AnsiString __fastcall GetColumnName(int Column) = 0 ;
	virtual AnsiString __fastcall GetSchemaName(int Column) = 0 ;
	virtual int __fastcall GetPrecision(int Column) = 0 ;
	virtual int __fastcall GetScale(int Column) = 0 ;
	virtual AnsiString __fastcall GetTableName(int Column) = 0 ;
	virtual AnsiString __fastcall GetCatalogName(int Column) = 0 ;
	virtual TZSQLType __fastcall GetColumnType(int Column) = 0 ;
	virtual AnsiString __fastcall GetColumnTypeName(int Column) = 0 ;
	virtual bool __fastcall IsReadOnly(int Column) = 0 ;
	virtual bool __fastcall IsWritable(int Column) = 0 ;
	virtual bool __fastcall IsDefinitelyWritable(int Column) = 0 ;
	virtual AnsiString __fastcall GetDefaultValue(int Column) = 0 ;
};

__interface INTERFACE_UUID("{47D209F1-D065-49DD-A156-EFD1E523F6BF}") IZBlob  : public IUnknown 
{
	
public:
	virtual bool __fastcall IsEmpty(void) = 0 ;
	virtual bool __fastcall IsUpdated(void) = 0 ;
	virtual int __fastcall Length(void) = 0 ;
	virtual AnsiString __fastcall GetString(void) = 0 ;
	virtual void __fastcall SetString(AnsiString Value) = 0 ;
	virtual WideString __fastcall GetUnicodeString(void) = 0 ;
	virtual void __fastcall SetUnicodeString(WideString Value) = 0 ;
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(void) = 0 ;
	virtual void __fastcall SetBytes(Zcompatibility::TByteDynArray Value) = 0 ;
	virtual Classes::TStream* __fastcall GetStream(void) = 0 ;
	virtual void __fastcall SetStream(Classes::TStream* Value) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	virtual _di_IZBlob __fastcall Clone(void) = 0 ;
};

__interface INTERFACE_UUID("{BF785C71-EBE9-4145-8DAE-40674E45EF6F}") IZNotification  : public IUnknown 
	
{
	
public:
	virtual AnsiString __fastcall GetEvent(void) = 0 ;
	virtual void __fastcall Listen(void) = 0 ;
	virtual void __fastcall Unlisten(void) = 0 ;
	virtual void __fastcall DoNotify(void) = 0 ;
	virtual AnsiString __fastcall CheckEvents(void) = 0 ;
	virtual _di_IZConnection __fastcall GetConnection(void) = 0 ;
};

__interface INTERFACE_UUID("{A9A54FE5-0DBE-492F-8DA6-04AC5FCE779C}") IZSequence  : public IUnknown 
{
	
public:
	virtual AnsiString __fastcall GetName(void) = 0 ;
	virtual int __fastcall GetBlockSize(void) = 0 ;
	virtual __int64 __fastcall GetNextValue(void) = 0 ;
	virtual _di_IZConnection __fastcall GetConnection(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
static const Shortint TypeSearchable = 0x3;
static const Shortint ProcedureReturnsResult = 0x2;
extern PACKAGE _di_IZDriverManager DriverManager;

}	/* namespace Zdbcintfs */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcintfs;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcIntfs
