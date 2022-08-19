{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{         Interbase Database Connectivity Classes         }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{            Written by Sergey Merkuriev                  }
{                                                         }
{*********************************************************}

{*********************************************************}
{ License Agreement:                                      }
{                                                         }
{ This library is free software; you can redistribute     }
{ it and/or modify it under the terms of the GNU Lesser   }
{ General Public License as published by the Free         }
{ Software Foundation; either version 2.1 of the License, }
{ or (at your option) any later version.                  }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ You should have received a copy of the GNU Lesser       }
{ General Public License along with this library; if not, }
{ write to the Free Software Foundation, Inc.,            }
{ 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA }
{                                                         }
{ The project web site is located on:                     }
{   http://www.sourceforge.net/projects/zeoslib.          }
{   http://www.zeoslib.sourceforge.net                    }
{                                                         }
{                                 Zeos Development Group. }
{*********************************************************}

unit ZDbcInterbase6Metadata;

interface

{$I ZDbc.inc}

uses
  Classes, SysUtils, ZSysUtils, ZDbcIntfs, ZDbcMetadata, ZTokenizer,
  ZCompatibility, ZGenericSqlAnalyser, ZDbcConnection, ZDbcInterbase6;

type

  {** Implements Interbase6 Database Metadata. }
  TZInterbase6DatabaseMetadata = class(TZAbstractDatabaseMetadata)
  private
    FSeverVersion: string;
    FIBConnection: TZInterbase6Connection;
    function StripEscape(const Pattern: string): string;
    function HasNoWildcards(const Pattern: string): boolean;
    function GetPrivilege(Privilege: string): string;
    function ConstructNameCondition(Pattern: string; Column: string): string;
    function GetSeverVersion: string;
  public
    constructor Create(Connection: TZAbstractConnection; Url: string; Info: TStrings);
    destructor Destroy; override;

    property SeverVersion: string read GetSeverVersion write FSeverVersion;

    function GetDatabaseProductName: string; override;
    function GetDatabaseProductVersion: string; override;
    function GetDriverName: string; override;
    function GetDriverMajorVersion: Integer; override;
    function GetDriverMinorVersion: Integer; override;
    function UsesLocalFilePerTable: Boolean; override;
    function SupportsMixedCaseIdentifiers: Boolean; override;
    function StoresUpperCaseIdentifiers: Boolean; override;
    function StoresLowerCaseIdentifiers: Boolean; override;
    function StoresMixedCaseIdentifiers: Boolean; override;
    function SupportsMixedCaseQuotedIdentifiers: Boolean; override;
    function StoresUpperCaseQuotedIdentifiers: Boolean; override;
    function StoresLowerCaseQuotedIdentifiers: Boolean; override;
    function StoresMixedCaseQuotedIdentifiers: Boolean; override;
    function GetSQLKeywords: string; override;
    function GetNumericFunctions: string; override;
    function GetStringFunctions: string; override;
    function GetSystemFunctions: string; override;
    function GetTimeDateFunctions: string; override;
    function GetSearchStringEscape: string; override;
    function GetExtraNameCharacters: string; override;

    function SupportsExpressionsInOrderBy: Boolean; override;
    function SupportsOrderByUnrelated: Boolean; override;
    function SupportsGroupBy: Boolean; override;
    function SupportsGroupByUnrelated: Boolean; override;
    function SupportsGroupByBeyondSelect: Boolean; override;
    function SupportsIntegrityEnhancementFacility: Boolean; override;
    function GetSchemaTerm: string; override;
    function GetProcedureTerm: string; override;
    function GetCatalogTerm: string; override;
    function GetCatalogSeparator: string; override;
    function SupportsSchemasInDataManipulation: Boolean; override;
    function SupportsSchemasInProcedureCalls: Boolean; override;
    function SupportsSchemasInTableDefinitions: Boolean; override;
    function SupportsSchemasInIndexDefinitions: Boolean; override;
    function SupportsSchemasInPrivilegeDefinitions: Boolean; override;
    function SupportsCatalogsInDataManipulation: Boolean; override;
    function SupportsCatalogsInProcedureCalls: Boolean; override;
    function SupportsCatalogsInTableDefinitions: Boolean; override;
    function SupportsCatalogsInIndexDefinitions: Boolean; override;
    function SupportsCatalogsInPrivilegeDefinitions: Boolean; override;
    function SupportsPositionedDelete: Boolean; override;
    function SupportsPositionedUpdate: Boolean; override;
    function SupportsSelectForUpdate: Boolean; override;
    function SupportsStoredProcedures: Boolean; override;
    function SupportsSubqueriesInComparisons: Boolean; override;
    function SupportsSubqueriesInExists: Boolean; override;
    function SupportsSubqueriesInIns: Boolean; override;
    function SupportsSubqueriesInQuantifieds: Boolean; override;
    function SupportsCorrelatedSubqueries: Boolean; override;
    function SupportsUnion: Boolean; override;
    function SupportsUnionAll: Boolean;  override;
    function SupportsOpenCursorsAcrossCommit: Boolean; override;
    function SupportsOpenCursorsAcrossRollback: Boolean; override;
    function SupportsOpenStatementsAcrossCommit: Boolean; override;
    function SupportsOpenStatementsAcrossRollback: Boolean; override;

    function GetMaxBinaryLiteralLength: Integer; override;
    function GetMaxCharLiteralLength: Integer; override;
    function GetMaxColumnNameLength: Integer; override;
    function GetMaxColumnsInGroupBy: Integer; override;
    function GetMaxColumnsInIndex: Integer; override;
    function GetMaxColumnsInOrderBy: Integer; override;
    function GetMaxColumnsInSelect: Integer; override;
    function GetMaxColumnsInTable: Integer; override;
    function GetMaxConnections: Integer; override;
    function GetMaxCursorNameLength: Integer; override;
    function GetMaxIndexLength: Integer; override;
    function GetMaxSchemaNameLength: Integer; override;
    function GetMaxProcedureNameLength: Integer; override;
    function GetMaxCatalogNameLength: Integer; override;
    function GetMaxRowSize: Integer; override;
    function DoesMaxRowSizeIncludeBlobs: Boolean; override;
    function GetMaxStatementLength: Integer; override;
    function GetMaxStatements: Integer; override;
    function GetMaxTableNameLength: Integer; override;
    function GetMaxTablesInSelect: Integer; override;
    function GetMaxUserNameLength: Integer; override;

    function GetDefaultTransactionIsolation: TZTransactIsolationLevel; override;
    function SupportsTransactions: Boolean; override;
    function SupportsTransactionIsolationLevel(Level: TZTransactIsolationLevel):
      Boolean; override;
    function SupportsDataDefinitionAndDataManipulationTransactions: Boolean; override;
    function SupportsDataManipulationTransactionsOnly: Boolean; override;
    function DataDefinitionCausesTransactionCommit: Boolean; override;
    function DataDefinitionIgnoredInTransactions: Boolean; override;

    function GetProcedures(Catalog: string; SchemaPattern: string;
      ProcedureNamePattern: string): IZResultSet; override;
    function GetProcedureColumns(Catalog: string; SchemaPattern: string;
      ProcedureNamePattern: string; ColumnNamePattern: string):
      IZResultSet; override;

    function GetTables(Catalog: string; SchemaPattern: string;
      TableNamePattern: string; Types: TStringDynArray): IZResultSet; override;
    function GetSchemas: IZResultSet; override;
    function GetCatalogs: IZResultSet; override;
    function GetTableTypes: IZResultSet; override;
    function GetColumns(Catalog: string; SchemaPattern: string;
      TableNamePattern: string; ColumnNamePattern: string): IZResultSet; override;
    function GetColumnPrivileges(Catalog: string; Schema: string;
      Table: string; ColumnNamePattern: string): IZResultSet; override;

    function GetTablePrivileges(Catalog: string; SchemaPattern: string;
      TableNamePattern: string): IZResultSet; override;
    function GetBestRowIdentifier(Catalog: string; Schema: string;
      Table: string; Scope: Integer; Nullable: Boolean): IZResultSet; override;
    function GetVersionColumns(Catalog: string; Schema: string;
      Table: string): IZResultSet; override;

    function GetPrimaryKeys(Catalog: string; Schema: string;
      Table: string): IZResultSet; override;
    function GetImportedKeys(Catalog: string; Schema: string;
      Table: string): IZResultSet; override;
    function GetExportedKeys(Catalog: string; Schema: string;
      Table: string): IZResultSet; override;
    function GetCrossReference(PrimaryCatalog: string; PrimarySchema: string;
      PrimaryTable: string; ForeignCatalog: string; ForeignSchema: string;
      ForeignTable: string): IZResultSet; override;

    function GetTypeInfo: IZResultSet; override;

    function GetIndexInfo(Catalog: string; Schema: string; Table: string;
      Unique: Boolean; Approximate: Boolean): IZResultSet; override;

    function SupportsResultSetType(_Type: TZResultSetType): Boolean; override;
    function SupportsResultSetConcurrency(_Type: TZResultSetType;
      Concurrency: TZResultSetConcurrency): Boolean; override;

    function GetUDTs(Catalog: string; SchemaPattern: string;
      TypeNamePattern: string; Types: TIntegerDynArray): IZResultSet; override;

    function GetTokenizer: IZTokenizer; override;
    function GetStatementAnalyser: IZStatementAnalyser; override;
  end;

implementation

uses ZMessages, ZInterbaseToken, ZDbcInterbase6Utils, ZInterbaseAnalyser;

{ TZInterbase6DatabaseMetadata }

{**
  Constructs this object and assignes the main properties.
  @param Connection a database connection object.
  @param Url a database connection url string.
  @param Info an extra connection properties.
}
constructor TZInterbase6DatabaseMetadata.Create(Connection: TZAbstractConnection;
  Url: string; Info: TStrings);
begin
  inherited Create(Connection, Url, Info);
  FIBConnection := Connection as TZInterbase6Connection;
end;

{**
  Destroys this object and cleanups the memory.
}
destructor TZInterbase6DatabaseMetadata.Destroy;
begin
  inherited Destroy;
end;

//----------------------------------------------------------------------
// First, a variety of minor information about the target database.

{**
  What's the name of this database product?
  @return database product name
}
function TZInterbase6DatabaseMetadata.GetDatabaseProductName: string;
begin
  Result := 'Interbase/Firebird';
end;

{**
  What's the version of this database product?
  @return database version
}
function TZInterbase6DatabaseMetadata.GetDatabaseProductVersion: string;
begin
  Result := '6.0+';
end;

{**
  What's the name of this JDBC driver?
  @return JDBC driver name
}
function TZInterbase6DatabaseMetadata.GetDriverName: string;
begin
  Result := 'Zeos Database Connectivity Driver for Interbase and Firebird';
end;

{**
  What's this JDBC driver's major version number?
  @return JDBC driver major version
}
function TZInterbase6DatabaseMetadata.GetDriverMajorVersion: Integer;
begin
  Result := 1;
end;

{**
  What's this JDBC driver's minor version number?
  @return JDBC driver minor version number
}
function TZInterbase6DatabaseMetadata.GetDriverMinorVersion: Integer;
begin
  Result := 0;
end;

{**
  Does the database use a file for each table?
  @return true if the database uses a local file for each table
}
function TZInterbase6DatabaseMetadata.UsesLocalFilePerTable: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case sensitive and as a result store them in mixed case?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver will always return false.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsMixedCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in upper case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.StoresUpperCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in lower case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.StoresLowerCaseIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.StoresMixedCaseIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case sensitive and as a result store them in mixed case?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver will always return true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsMixedCaseQuotedIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in upper case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.StoresUpperCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in lower case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.StoresLowerCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.StoresMixedCaseQuotedIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Gets a comma-separated list of all a database's SQL keywords
  that are NOT also SQL92 keywords.
  @return the list
}
function TZInterbase6DatabaseMetadata.GetSQLKeywords: string;
begin
  Result := 'ACTIVE,AFTER,ASCENDING,BASE_NAME,BEFORE,BLOB,' +
    'CACHE,CHECK_POINT_LENGTH,COMPUTED,CONDITIONAL,CONTAINING,' +
    'CSTRING,DATABASE,RDB$DB_KEY,DEBUG,DESCENDING,DO,ENTRY_POINT,' +
    'EXIT,FILE,FILTER,FUNCTION,GDSCODE,GENERATOR,GEN_ID,' +
    'GROUP_COMMIT_WAIT_TIME,IF,INACTIVE,INPUT_TYPE,INDEX,' +
    'LOGFILE,LOG_BUFFER_SIZE,MANUAL,MAXIMUM_SEGMENT,MERGE, MESSAGE,' +
    'MODULE_NAME,NCHAR,NUM_LOG_BUFFERS,OUTPUT_TYPE,OVERFLOW,PAGE,' +
    'PAGES,PAGE_SIZE,PARAMETER,PASSWORD,PLAN,POST_EVENT,PROTECTED,' +
    'RAW_PARTITIONS,RESERV,RESERVING,RETAIN,RETURNING_VALUES,RETURNS,' +
    'SEGMENT,SHADOW,SHARED,SINGULAR,SNAPSHOT,SORT,STABILITY,STARTS,' +
    'STARTING,STATISTICS,SUB_TYPE,SUSPEND,TRIGGER,VARIABLE,RECORD_VERSION,' +
    'WAIT,WHILE,WORK';
end;

{**
  Gets a comma-separated list of math functions.  These are the
  X/Open CLI math function names used in the JDBC function escape
  clause.
  @return the list
}
function TZInterbase6DatabaseMetadata.GetNumericFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of string functions.  These are the
  X/Open CLI string function names used in the JDBC function escape
  clause.
  @return the list
}
function TZInterbase6DatabaseMetadata.GetStringFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of system functions.  These are the
  X/Open CLI system function names used in the JDBC function escape
  clause.
  @return the list
}
function TZInterbase6DatabaseMetadata.GetSystemFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of time and date functions.
  @return the list
}
function TZInterbase6DatabaseMetadata.GetTimeDateFunctions: string;
begin
  Result := '';
end;

{**
  Gets the string that can be used to escape wildcard characters.
  This is the string that can be used to escape '_' or '%' in
  the string pattern style catalog search parameters.

  <P>The '_' character represents any single character.
  <P>The '%' character represents any sequence of zero or
  more characters.

  @return the string used to escape wildcard characters
}
function TZInterbase6DatabaseMetadata.GetSearchStringEscape: string;
begin
  Result := '\';
end;

{**
  Gets all the "extra" characters that can be used in unquoted
  identifier names (those beyond a-z, A-Z, 0-9 and _).
  @return the string containing the extra characters
}
function TZInterbase6DatabaseMetadata.GetExtraNameCharacters: string;
begin
  Result := '$';
end;

//--------------------------------------------------------------------
// Functions describing which features are supported.

{**
  Are expressions in "ORDER BY" lists supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsExpressionsInOrderBy: Boolean;
begin
  Result := False;
end;

{**
  Can an "ORDER BY" clause use columns not in the SELECT statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsOrderByUnrelated: Boolean;
begin
  Result := True;
end;

{**
  Is some form of "GROUP BY" clause supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsGroupBy: Boolean;
begin
  Result := True;
end;

{**
  Can a "GROUP BY" clause use columns not in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsGroupByUnrelated: Boolean;
begin
  Result := True;
end;

{**
  Can a "GROUP BY" clause add columns not in the SELECT
  provided it specifies all the columns in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsGroupByBeyondSelect: Boolean;
begin
  Result := True;
end;

{**
  Is the SQL Integrity Enhancement Facility supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsIntegrityEnhancementFacility: Boolean;
begin
  Result := False;
end;

{**
  What's the database vendor's preferred term for "schema"?
  @return the vendor term
}
function TZInterbase6DatabaseMetadata.GetSchemaTerm: string;
begin
  Result := '';
end;

{**
  What's the database vendor's preferred term for "procedure"?
  @return the vendor term
}
function TZInterbase6DatabaseMetadata.GetProcedureTerm: string;
begin
  Result := 'PROCEDURE';
end;

{**
  What's the database vendor's preferred term for "catalog"?
  @return the vendor term
}
function TZInterbase6DatabaseMetadata.GetCatalogTerm: string;
begin
  Result := '';
end;

{**
  What's the separator between catalog and table name?
  @return the separator string
}
function TZInterbase6DatabaseMetadata.GetCatalogSeparator: string;
begin
  Result := '';
end;

{**
  Can a schema name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSchemasInDataManipulation: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in a procedure call statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSchemasInProcedureCalls: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSchemasInTableDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in an index definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSchemasInIndexDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in a privilege definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSchemasInPrivilegeDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsCatalogsInDataManipulation: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a procedure call statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsCatalogsInProcedureCalls: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsCatalogsInTableDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in an index definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsCatalogsInIndexDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a privilege definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsCatalogsInPrivilegeDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Is positioned DELETE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsPositionedDelete: Boolean;
begin
  Result := True;
end;

{**
  Is positioned UPDATE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsPositionedUpdate: Boolean;
begin
  Result := True;
end;

{**
  Is SELECT for UPDATE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSelectForUpdate: Boolean;
begin
  Result := True;
end;

{**
  Are stored procedure calls using the stored procedure escape
  syntax supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsStoredProcedures: Boolean;
begin
  Result := True;
end;

{**
  Are subqueries in comparison expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSubqueriesInComparisons: Boolean;
begin
  Result := True;
end;

{**
  Are subqueries in 'exists' expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSubqueriesInExists: Boolean;
begin
  Result := True;
end;

{**
  Are subqueries in 'in' statements supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSubqueriesInIns: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in quantified expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsSubqueriesInQuantifieds: Boolean;
begin
  Result := True;
end;

{**
  Are correlated subqueries supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsCorrelatedSubqueries: Boolean;
begin
  Result := True;
end;

{**
  Is SQL UNION supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsUnion: Boolean;
begin
  Result := True;
end;

{**
  Is SQL UNION ALL supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsUnionAll: Boolean;
begin
  Result := True;
end;

{**
  Can cursors remain open across commits?
  @return <code>true</code> if cursors always remain open;
        <code>false</code> if they might not remain open
}
function TZInterbase6DatabaseMetadata.SupportsOpenCursorsAcrossCommit: Boolean;
begin
  Result := False;
end;

{**
  Can cursors remain open across rollbacks?
  @return <code>true</code> if cursors always remain open;
        <code>false</code> if they might not remain open
}
function TZInterbase6DatabaseMetadata.SupportsOpenCursorsAcrossRollback: Boolean;
begin
  Result := False;
end;

{**
  Can statements remain open across commits?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZInterbase6DatabaseMetadata.SupportsOpenStatementsAcrossCommit: Boolean;
begin
  Result := True;
end;

{**
  Can statements remain open across rollbacks?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZInterbase6DatabaseMetadata.SupportsOpenStatementsAcrossRollback: Boolean;
begin
  Result := True;
end;

//----------------------------------------------------------------------
// The following group of methods exposes various limitations
// based on the target database with the current driver.
// Unless otherwise specified, a result of zero means there is no
// limit, or the limit is not known.

{**
  How many hex characters can you have in an inline binary literal?
  @return max binary literal length in hex characters;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxBinaryLiteralLength: Integer;
begin
  Result := 0;
end;

{**
  What's the max length for a character literal?
  @return max literal length;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxCharLiteralLength: Integer;
begin
  Result := 1024;
end;

{**
  What's the limit on column name length?
  @return max column name length;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxColumnNameLength: Integer;
begin
  Result := 31;
end;

{**
  What's the maximum number of columns in a "GROUP BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxColumnsInGroupBy: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum number of columns allowed in an index?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxColumnsInIndex: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum number of columns in an "ORDER BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxColumnsInOrderBy: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum number of columns in a "SELECT" list?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxColumnsInSelect: Integer;
begin
  Result := 32767;
end;

{**
  What's the maximum number of columns in a table?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxColumnsInTable: Integer;
begin
  Result := 32767;
end;

{**
  How many active connections can we have at a time to this database?
  @return max number of active connections;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxConnections: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum cursor name length?
  @return max cursor name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxCursorNameLength: Integer;
begin
  Result := 31;
end;

{**
  Retrieves the maximum number of bytes for an index, including all
  of the parts of the index.
  @return max index length in bytes, which includes the composite of all
   the constituent parts of the index;
   a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxIndexLength: Integer;
begin
  Result := 198;
end;

{**
  What's the maximum length allowed for a schema name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxSchemaNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a procedure name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxProcedureNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a catalog name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxCatalogNameLength: Integer;
begin
  Result := 27;
end;

{**
  What's the maximum length of a single row?
  @return max row size in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxRowSize: Integer;
begin
  Result := 32664;
end;

{**
  Did getMaxRowSize() include LONGVARCHAR and LONGVARBINARY
  blobs?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.DoesMaxRowSizeIncludeBlobs: Boolean;
begin
  Result := False;
end;

{**
  What's the maximum length of an SQL statement?
  @return max length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxStatementLength: Integer;
begin
  Result := 640;
end;

{**
  How many active statements can we have open at one time to this
  database?
  @return the maximum number of statements that can be open at one time;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxStatements: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a table name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxTableNameLength: Integer;
begin
  Result := 31;
end;

{**
  What's the maximum number of tables in a SELECT statement?
  @return the maximum number of tables allowed in a SELECT statement;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxTablesInSelect: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum length of a user name?
  @return max user name length  in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZInterbase6DatabaseMetadata.GetMaxUserNameLength: Integer;
begin
  Result := 31;
end;

//----------------------------------------------------------------------

{**
  What's the database's default transaction isolation level?  The
  values are defined in <code>java.sql.Connection</code>.
  @return the default isolation level
  @see Connection
}
function TZInterbase6DatabaseMetadata.GetDefaultTransactionIsolation:
  TZTransactIsolationLevel;
begin
  Result := tiSerializable;
end;

{**
  Are transactions supported? If not, invoking the method
  <code>commit</code> is a noop and the isolation level is TRANSACTION_NONE.
  @return <code>true</code> if transactions are supported; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsTransactions: Boolean;
begin
  Result := True;
end;

{**
  Does this database support the given transaction isolation level?
  @param level the values are defined in <code>java.sql.Connection</code>
  @return <code>true</code> if so; <code>false</code> otherwise
  @see Connection
}
function TZInterbase6DatabaseMetadata.SupportsTransactionIsolationLevel(
  Level: TZTransactIsolationLevel): Boolean;
begin
  case Level of
    tiRepeatableRead, tiReadCommitted, tiSerializable: Result := True;
    tiReadUncommitted: Result := False;
    tiNone: Result := False; //MAY BE FIX IT
    else
      Result := False;
  end;    
end;

{**
  Are both data definition and data manipulation statements
  within a transaction supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.
  SupportsDataDefinitionAndDataManipulationTransactions: Boolean;
begin
  Result := True;
end;

{**
  Are only data manipulation statements within a transaction
  supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.
  SupportsDataManipulationTransactionsOnly: Boolean;
begin
  Result := False;
end;

{**
  Does a data definition statement within a transaction force the
  transaction to commit?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.DataDefinitionCausesTransactionCommit: Boolean;
begin
  Result := True;
end;

{**
  Is a data definition statement within a transaction ignored?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.DataDefinitionIgnoredInTransactions: Boolean;
begin
  Result := False;
end;

{**
  Gets a description of the stored procedures available in a
  catalog.

  <P>Only procedure descriptions matching the schema and
  procedure name criteria are returned.  They are ordered by
  PROCEDURE_SCHEM, and PROCEDURE_NAME.

  <P>Each procedure description has the the following columns:
   <OL>
 	<LI><B>PROCEDURE_CAT</B> String => procedure catalog (may be null)
 	<LI><B>PROCEDURE_SCHEM</B> String => procedure schema (may be null)
 	<LI><B>PROCEDURE_NAME</B> String => procedure name
   <LI> reserved for future use
   <LI> reserved for future use
   <LI> reserved for future use
 	<LI><B>REMARKS</B> String => explanatory comment on the procedure
 	<LI><B>PROCEDURE_TYPE</B> short => kind of procedure:
       <UL>
       <LI> procedureResultUnknown - May return a result
       <LI> procedureNoResult - Does not return a result
       <LI> procedureReturnsResult - Returns a result
       </UL>
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schemaPattern a schema name pattern; "" retrieves those
  without a schema
  @param procedureNamePattern a procedure name pattern
  @return <code>ResultSet</code> - each row is a procedure description
  @see #getSearchStringEscape
}
function TZInterbase6DatabaseMetadata.GetProcedures(Catalog: string;
  SchemaPattern: string; ProcedureNamePattern: string): IZResultSet;
var
  Sql: string;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetProcedures(Catalog, SchemaPattern,
    ProcedureNamePattern)  as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  ProcedureNamePattern := ConstructNameCondition(ProcedureNamePattern,
    'RDB$PROCEDURE_NAME');

  Sql := 'SELECT RDB$PROCEDURE_NAME, RDB$PROCEDURE_OUTPUTS, RDB$DESCRIPTION '+
    ' FROM RDB$PROCEDURES ';
  if ProcedureNamePattern <> '' then
    Sql := Sql + ' WHERE ' + ProcedureNamePattern;

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNull(1);
    TargetResultSet.UpdateNull(2);
    TargetResultSet.UpdateString(3, TempResultSet.GetStringByName('RDB$PROCEDURE_NAME'));
    TargetResultSet.UpdateNull(4);
    TargetResultSet.UpdateNull(5);
    TargetResultSet.UpdateNull(6);
    TargetResultSet.UpdateString(7, TempResultSet.GetStringByName('RDB$DESCRIPTION'));
    if TempResultSet.IsNullByName('RDB$PROCEDURE_OUTPUTS') then
      TargetResultSet.UpdateInt(8, Ord(prtNoResult))
    else
      TargetResultSet.UpdateInt(8, Ord(prtReturnsResult));
    TargetResultSet.InsertRow;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  A possible value for column <code>PROCEDURE_TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getProcedures</code>.
  <p> Indicates that it is not known whether the procedure returns
  a result.
}
//    int procedureResultUnknown	= 0;

{**
  A possible value for column <code>PROCEDURE_TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getProcedures</code>.
  <p> Indicates that the procedure does not return
  a result.
}
//    int procedureNoResult		= 1;

{**
  A possible value for column <code>PROCEDURE_TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getProcedures</code>.
  <p> Indicates that the procedure returns
  a result.
}
//    int procedureReturnsResult	= 2;

{**
  Gets a description of a catalog's stored procedure parameters
  and result columns.

  <P>Only descriptions matching the schema, procedure and
  parameter name criteria are returned.  They are ordered by
  PROCEDURE_SCHEM and PROCEDURE_NAME. Within this, the return value,
  if any, is first. Next are the parameter descriptions in call
  order. The column descriptions follow in column number order.

  <P>Each row in the <code>ResultSet</code> is a parameter description or
  column description with the following fields:
   <OL>
 	<LI><B>PROCEDURE_CAT</B> String => procedure catalog (may be null)
 	<LI><B>PROCEDURE_SCHEM</B> String => procedure schema (may be null)
 	<LI><B>PROCEDURE_NAME</B> String => procedure name
 	<LI><B>COLUMN_NAME</B> String => column/parameter name
 	<LI><B>COLUMN_TYPE</B> Short => kind of column/parameter:
       <UL>
       <LI> procedureColumnUnknown - nobody knows
       <LI> procedureColumnIn - IN parameter
       <LI> procedureColumnInOut - INOUT parameter
       <LI> procedureColumnOut - OUT parameter
       <LI> procedureColumnReturn - procedure return value
       <LI> procedureColumnResult - result column in <code>ResultSet</code>
       </UL>
   <LI><B>DATA_TYPE</B> short => SQL type from java.sql.Types
 	<LI><B>TYPE_NAME</B> String => SQL type name, for a UDT type the
   type name is fully qualified
 	<LI><B>PRECISION</B> int => precision
 	<LI><B>LENGTH</B> int => length in bytes of data
 	<LI><B>SCALE</B> short => scale
 	<LI><B>RADIX</B> short => radix
 	<LI><B>NULLABLE</B> short => can it contain NULL?
       <UL>
       <LI> procedureNoNulls - does not allow NULL values
       <LI> procedureNullable - allows NULL values
       <LI> procedureNullableUnknown - nullability unknown
       </UL>
 	<LI><B>REMARKS</B> String => comment describing parameter/column
   </OL>

  <P><B>Note:</B> Some databases may not return the column
  descriptions for a procedure. Additional columns beyond
  REMARKS can be defined by the database.

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schemaPattern a schema name pattern; "" retrieves those
  without a schema
  @param procedureNamePattern a procedure name pattern
  @param columnNamePattern a column name pattern
  @return <code>ResultSet</code> - each row describes a stored procedure parameter or
       column
  @see #getSearchStringEscape
}
function TZInterbase6DatabaseMetadata.GetProcedureColumns(Catalog: string;
  SchemaPattern: string; ProcedureNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
var
  Where, Sql: string;
  TypeName, SubTypeName: Integer;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetProcedureColumns(Catalog, SchemaPattern,
    ProcedureNamePattern, ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  ProcedureNamePattern := ConstructNameCondition(ProcedureNamePattern,
    'P.RDB$PROCEDURE_NAME');
  ColumnNamePattern := ConstructNameCondition(ColumnNamePattern,
    'PP.RDB$PARAMETER_NAME');

  if StrPos(PChar(SeverVersion), 'Interbase 5') <> nil then
  begin
    Sql := ' SELECT P.RDB$PROCEDURE_NAME, PP.RDB$PARAMETER_NAME, PP.RDB$PARAMETER_TYPE, ' +
      ' F.RDB$FIELD_TYPE, F.RDB$FIELD_SUB_TYPE, F.RDB$FIELD_SCALE, F.RDB$FIELD_LENGTH, ' +
  	  ' F.RDB$NULL_FLAG, PP.RDB$DESCRIPTION, F.RDB$FIELD_SCALE as RDB$FIELD_PRECISION, F.RDB$NULL_FLAG '+
      ' FROM RDB$PROCEDURES P ' +
      ' JOIN RDB$PROCEDURE_PARAMETERS PP ON P.RDB$PROCEDURE_NAME = PP.RDB$PROCEDURE_NAME ' +
      ' JOIN RDB$FIELDS F ON PP.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME ';

    Where := ProcedureNamePattern;
    if ColumnNamePattern <> '' then
    begin
      if Where = '' then
        Where := ColumnNamePattern
      else
        Where := Where + ' AND ' + ColumnNamePattern;
    end;
    if Where <> '' then
      Where := ' WHERE ' + Where;

	  Sql := Sql + Where + ' ORDER BY  P.RDB$PROCEDURE_NAME, PP.RDB$PARAMETER_TYPE desc, PP.RDB$PARAMETER_NUMBER'
  end else begin
    Sql := ' SELECT P.RDB$PROCEDURE_NAME, PP.RDB$PARAMETER_NAME, PP.RDB$PARAMETER_TYPE, ' +
      ' F.RDB$FIELD_TYPE, F.RDB$FIELD_SUB_TYPE, F.RDB$FIELD_SCALE, F.RDB$FIELD_LENGTH, ' +
  	  ' F.RDB$NULL_FLAG, PP.RDB$DESCRIPTION, F.RDB$FIELD_PRECISION, F.RDB$NULL_FLAG '+
      ' FROM RDB$PROCEDURES P ' +
      ' JOIN RDB$PROCEDURE_PARAMETERS PP ON P.RDB$PROCEDURE_NAME = PP.RDB$PROCEDURE_NAME ' +
      ' JOIN RDB$FIELDS F ON PP.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME ';

    Where := ProcedureNamePattern;
    if ColumnNamePattern <> '' then
    begin
      if Where = '' then
        Where := ColumnNamePattern
      else
        Where := Where + ' AND ' + ColumnNamePattern;
    end;
    if Where <> '' then
      Where := ' WHERE ' + Where;

	  Sql := Sql + Where + ' ORDER BY  P.RDB$PROCEDURE_NAME, PP.RDB$PARAMETER_TYPE desc, PP.RDB$PARAMETER_NUMBER';
  end;
  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while TempResultSet.Next do
  begin
    TypeName := TempResultSet.GetIntByName('RDB$FIELD_TYPE');
    SubTypeName := TempResultSet.GetIntByName('RDB$FIELD_SUB_TYPE');
    //FieldScale := TempResultSet.GetIntByName('RDB$FIELD_SCALE');

    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNull(1);    //PROCEDURE_CAT
    TargetResultSet.UpdateNull(2);    //PROCEDURE_SCHEM
    TargetResultSet.UpdateString(3, TempResultSet.GetStringByName('RDB$PROCEDURE_NAME'));    //TABLE_NAME
    TargetResultSet.UpdateString(4, TempResultSet.GetStringByName('RDB$PARAMETER_NAME'));    //COLUMN_NAME
    case TempResultSet.GetIntByName('RDB$PARAMETER_TYPE') of
      0: TargetResultSet.UpdateInt(5, 1);//ptInput
      1: TargetResultSet.UpdateInt(5, 4);//ptResult
    else
      TargetResultSet.UpdateInt(5, 0);//ptUnknown
    end;

    TargetResultSet.UpdateInt(6, Ord(ConvertInterbase6ToSqlType(TypeName, SubTypeName)));    //DATA_TYPE
    TargetResultSet.UpdateString(7, TempResultSet.GetStringByName('RDB$FIELD_TYPE'));    //TYPE_NAME
    TargetResultSet.UpdateInt(10, TempResultSet.GetIntByName('RDB$FIELD_PRECISION'));
    TargetResultSet.UpdateNull(9);    //BUFFER_LENGTH
    TargetResultSet.UpdateInt(10, TempResultSet.GetIntByName('RDB$FIELD_SCALE'));
    TargetResultSet.UpdateInt(11, 10);
    TargetResultSet.UpdateInt(12, TempResultSet.GetIntByName('RDB$NULL_FLAG'));
    TargetResultSet.UpdateString(12, TempResultSet.GetStringByName('RDB$FIELD_PRECISION'));
    TargetResultSet.InsertRow;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  Indicates that type of the column is unknown.
  A possible value for the column
  <code>COLUMN_TYPE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//    int procedureColumnUnknown = 0;

{**
  Indicates that the column stores IN parameters.
  A possible value for the column
  <code>COLUMN_TYPE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//    int procedureColumnIn = 1;

{**
  Indicates that the column stores INOUT parameters.
  A possible value for the column
  <code>COLUMN_TYPE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//    int procedureColumnInOut = 2;

{**
  Indicates that the column stores OUT parameters.
  A possible value for the column
  <code>COLUMN_TYPE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//    int procedureColumnOut = 4;
{**
  Indicates that the column stores return values.
  A possible value for the column
  <code>COLUMN_TYPE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//    int procedureColumnReturn = 5;

{**
  Indicates that the column stores results.
  A possible value for the column
  <code>COLUMN_TYPE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//    int procedureColumnResult = 3;

{**
  Indicates that <code>NULL</code> values are not allowed.
  A possible value for the column
  <code>NULLABLE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//int procedureNoNulls = 0;

{**
  Indicates that <code>NULL</code> values are allowed.
  A possible value for the column
  <code>NULLABLE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//int procedureNullable = 1;

{**
  Indicates that whether <code>NULL</code> values are allowed
  is unknown.
  A possible value for the column
  <code>NULLABLE</code>
  in the <code>ResultSet</code>
  returned by the method <code>getProcedureColumns</code>.
}
//int procedureNullableUnknown = 2;


{**
  Gets a description of tables available in a catalog.

  <P>Only table descriptions matching the catalog, schema, table
  name and type criteria are returned.  They are ordered by
  TABLE_TYPE, TABLE_SCHEM and TABLE_NAME.

  <P>Each table description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>TABLE_TYPE</B> String => table type.  Typical types are "TABLE",
 			"VIEW",	"SYSTEM TABLE", "GLOBAL TEMPORARY",
 			"LOCAL TEMPORARY", "ALIAS", "SYNONYM".
 	<LI><B>REMARKS</B> String => explanatory comment on the table
   </OL>

  <P><B>Note:</B> Some databases may not return information for
  all tables.

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schemaPattern a schema name pattern; "" retrieves those
  without a schema
  @param tableNamePattern a table name pattern
  @param types a list of table types to include; null returns all types
  @return <code>ResultSet</code> - each row is a table description
  @see #getSearchStringEscape
}
function TZInterbase6DatabaseMetadata.GetTables(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  Types: TStringDynArray): IZResultSet;
var
  BLR: IZBlob;
  Sql, RelationName, TableType: string;
  I, SystemFlag{, ViewContext}: integer;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTables(Catalog, SchemaPattern,
    TableNamePattern, Types)  as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  TableNamePattern := ConstructNameCondition(TableNamePattern,
    'a.RDB$RELATION_NAME');

  Sql := 'SELECT DISTINCT a.RDB$RELATION_NAME, b.RDB$SYSTEM_FLAG, b.RDB$VIEW_CONTEXT, a.RDB$VIEW_SOURCE ' +
    ' FROM RDB$RELATIONS a '+
    ' JOIN RDB$RELATION_FIELDS b ON a.RDB$RELATION_NAME = b.RDB$RELATION_NAME';

  if TableNamePattern <> '' then
    Sql := Sql + ' WHERE ' + TableNamePattern;

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while TempResultSet.Next do
  begin
    SystemFlag := TempResultSet.GetIntByName('RDB$SYSTEM_FLAG');
    RelationName := TempResultSet.GetStringByName('RDB$RELATION_NAME');

    if SystemFlag = 0 then
    begin
      BLR := TempResultSet.GetBlobByName('RDB$VIEW_SOURCE');
      if BLR.Length = 0 then
        TableType := 'TABLE'
      else
        TableType := 'VIEW';
    end else
      TableType := 'SYSTEM TABLE';

    for I := 0 to High(Types) do
      if Types[I] <> TableType then
        Continue;

    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNull(1);
    TargetResultSet.UpdateNull(2);
    TargetResultSet.UpdateString(3, RelationName);
    TargetResultSet.UpdateString(4, TableType);
    TargetResultSet.UpdateNull(5);
    TargetResultSet.InsertRow;
  end;
  TempResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

{**
  Gets the schema names available in this database.  The results
  are ordered by schema name.

  <P>The schema column is:
   <OL>
 	<LI><B>TABLE_SCHEM</B> String => schema name
   </OL>

  @return <code>ResultSet</code> - each row has a single String column that is a
  schema name
}
function TZInterbase6DatabaseMetadata.GetSchemas: IZResultSet;
var
  Key: string;
begin
  Key := 'get-schemas';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    Result := inherited GetSchemas as IZVirtualResultSet;
    AddResultSetToCache(Key, Result);
    Result := CloneCachedResultSet(Result);
  end;
end;

{**
  Gets the catalog names available in this database.  The results
  are ordered by catalog name.

  <P>The catalog column is:
   <OL>
 	<LI><B>TABLE_CAT</B> String => catalog name
   </OL>

  @return <code>ResultSet</code> - each row has a single String column that is a
  catalog name
}
function TZInterbase6DatabaseMetadata.GetCatalogs: IZResultSet;
var
  Key: string;
begin
  Key := 'get-catalogs';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    Result := inherited GetCatalogs  as IZVirtualResultSet;
    AddResultSetToCache(Key, Result);
    Result := CloneCachedResultSet(Result);
  end;
end;

{**
  Gets the table types available in this database.  The results
  are ordered by table type.

  <P>The table type is:
   <OL>
 	<LI><B>TABLE_TYPE</B> String => table type.  Typical types are "TABLE",
 			"VIEW",	"SYSTEM TABLE", "GLOBAL TEMPORARY",
 			"LOCAL TEMPORARY", "ALIAS", "SYNONYM".
   </OL>

  @return <code>ResultSet</code> - each row has a single String column that is a
  table type
}
function TZInterbase6DatabaseMetadata.GetTableTypes: IZResultSet;
const
  TablesTypes: array [0..2] of string = ('TABLE', 'VIEW', 'SYSTEM TABLE');

var
  I: Integer;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTableTypes  as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  for I := 0 to 2 do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(1, TablesTypes[I]);
    TargetResultSet.InsertRow;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  Gets a description of table columns available in
  the specified catalog.

  <P>Only column descriptions matching the catalog, schema, table
  and column name criteria are returned.  They are ordered by
  TABLE_SCHEM, TABLE_NAME and ORDINAL_POSITION.

  <P>Each column description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>COLUMN_NAME</B> String => column name
 	<LI><B>DATA_TYPE</B> short => SQL type from java.sql.Types
 	<LI><B>TYPE_NAME</B> String => Data source dependent type name,
   for a UDT the type name is fully qualified
 	<LI><B>COLUMN_SIZE</B> int => column size.  For char or date
 	    types this is the maximum number of characters, for numeric or
 	    decimal types this is precision.
 	<LI><B>BUFFER_LENGTH</B> is not used.
 	<LI><B>DECIMAL_DIGITS</B> int => the number of fractional digits
 	<LI><B>NUM_PREC_RADIX</B> int => Radix (typically either 10 or 2)
 	<LI><B>NULLABLE</B> int => is NULL allowed?
       <UL>
       <LI> columnNoNulls - might not allow NULL values
       <LI> columnNullable - definitely allows NULL values
       <LI> columnNullableUnknown - nullability unknown
       </UL>
 	<LI><B>REMARKS</B> String => comment describing column (may be null)
 	<LI><B>COLUMN_DEF</B> String => default value (may be null)
 	<LI><B>SQL_DATA_TYPE</B> int => unused
 	<LI><B>SQL_DATETIME_SUB</B> int => unused
 	<LI><B>CHAR_OCTET_LENGTH</B> int => for char types the
        maximum number of bytes in the column
 	<LI><B>ORDINAL_POSITION</B> int	=> index of column in table
       (starting at 1)
 	<LI><B>IS_NULLABLE</B> String => "NO" means column definitely
       does not allow NULL values; "YES" means the column might
       allow NULL values.  An empty string means nobody knows.
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schemaPattern a schema name pattern; "" retrieves those
  without a schema
  @param tableNamePattern a table name pattern
  @param columnNamePattern a column name pattern
  @return <code>ResultSet</code> - each row is a column description
  @see #getSearchStringEscape
}
function TZInterbase6DatabaseMetadata.GetColumns(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
var
  Sql, Where, ColumnName, DefaultValue: string;
  TypeName, SubTypeName, FieldScale: integer;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetColumns(Catalog, SchemaPattern,
    TableNamePattern, ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  TableNamePattern := ConstructNameCondition(TableNamePattern,
    'a.RDB$RELATION_NAME');
  ColumnNamePattern := ConstructNameCondition(ColumnNamePattern,
    'a.RDB$FIELD_NAME');

  if StrPos(PChar(SeverVersion), 'Interbase 5') <> nil then
  begin
    Sql := 'SELECT a.RDB$RELATION_NAME, a.RDB$FIELD_NAME, a.RDB$FIELD_POSITION,'+
      ' a.RDB$NULL_FLAG, b. RDB$FIELD_LENGTH, b.RDB$FIELD_SCALE, '+
      ' c.RDB$TYPE_NAME, b.RDB$FIELD_TYPE, b.RDB$FIELD_SUB_TYPE, b.RDB$DESCRIPTION,'+
      ' b.RDB$CHARACTER_LENGTH, b.RDB$FIELD_SCALE as RDB$FIELD_PRECISION,'+
      ' a.RDB$DEFAULT_SOURCE, b.RDB$DEFAULT_SOURCE as RDB$DEFAULT_SOURCE_DOMAIN'+
      ' FROM RDB$RELATION_FIELDS a'+
      ' JOIN RDB$FIELDS b ON (b.RDB$FIELD_NAME = a.RDB$FIELD_SOURCE)' +
      ' LEFT JOIN RDB$TYPES c ON b.RDB$FIELD_TYPE = c.RDB$TYPE and c.RDB$FIELD_NAME = ''RDB$FIELD_TYPE''';

    Where := TableNamePattern;
    if ColumnNamePattern <> '' then
    begin
      if Where = '' then
        Where := ColumnNamePattern
      else
        Where := Where + ' AND ' + ColumnNamePattern;
    end;
    if Where <> '' then
      Where := ' WHERE ' + Where;

    Sql := Sql + Where + ' ORDER BY a.RDB$RELATION_NAME, a.RDB$FIELD_POSITION';
  end else begin
    Sql := ' SELECT a.RDB$RELATION_NAME, a.RDB$FIELD_NAME, a.RDB$FIELD_POSITION,' +
      ' a.RDB$NULL_FLAG, a.RDB$DEFAULT_VALUE, b. RDB$FIELD_LENGTH, b.RDB$FIELD_SCALE,' +
      ' c.RDB$TYPE_NAME, b.RDB$FIELD_TYPE, b.RDB$FIELD_SUB_TYPE, b.RDB$DESCRIPTION,' +
      ' b.RDB$CHARACTER_LENGTH, b.RDB$FIELD_PRECISION,' +
      ' a.RDB$DEFAULT_SOURCE, b.RDB$DEFAULT_SOURCE as RDB$DEFAULT_SOURCE_DOMAIN' +
      ' FROM RDB$RELATION_FIELDS a ' +
      ' JOIN RDB$FIELDS b ON (b.RDB$FIELD_NAME = a.RDB$FIELD_SOURCE)' +
      ' LEFT JOIN RDB$TYPES c ON (b.RDB$FIELD_TYPE = c.RDB$TYPE and c.RDB$FIELD_NAME = ''RDB$FIELD_TYPE'')';

    Where := TableNamePattern;
    if ColumnNamePattern <> '' then
    begin
      if Where = '' then
        Where := ColumnNamePattern
      else
        Where := Where + ' AND ' + ColumnNamePattern;
    end;
    if Where <> '' then
      Where := ' WHERE ' + Where;

    Sql := Sql + Where + ' ORDER BY a.RDB$RELATION_NAME, a.RDB$FIELD_POSITION';
  end;

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TypeName := TempResultSet.GetIntByName('RDB$FIELD_TYPE');
    SubTypeName := TempResultSet.GetIntByName('RDB$FIELD_SUB_TYPE');
    FieldScale := TempResultSet.GetIntByName('RDB$FIELD_SCALE');
    ColumnName := TempResultSet.GetStringByName('RDB$FIELD_NAME');

    DefaultValue := TempResultSet.GetStringByName('RDB$DEFAULT_SOURCE');
    if DefaultValue = '' then
      DefaultValue := TempResultSet.GetStringByName('RDB$DEFAULT_SOURCE_DOMAIN');
    if StartsWith(UpperCase(DefaultValue), 'DEFAULT') then
      DefaultValue := Trim(Copy(DefaultValue,
        Length('DEFAULT') + 1, Length(DefaultValue)));

    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNull(1);    //TABLE_CAT
    TargetResultSet.UpdateNull(2);    //TABLE_SCHEM
    TargetResultSet.UpdateString(3, TempResultSet.GetStringByName('RDB$RELATION_NAME'));    //TABLE_NAME
    TargetResultSet.UpdateString(4, ColumnName);    //COLUMN_NAME
    TargetResultSet.UpdateInt(5, Ord(ConvertInterbase6ToSqlType(
      TypeName, SubTypeName)));    //DATA_TYPE
    TargetResultSet.UpdateString(6, TempResultSet.GetStringByName('RDB$TYPE_NAME'));    //TYPE_NAME
    TargetResultSet.UpdateInt(7, TempResultSet.GetIntByName('RDB$FIELD_LENGTH'));    //COLUMN_SIZE
    TargetResultSet.UpdateNull(8);    //BUFFER_LENGTH

    if FieldScale < 0 then
      TargetResultSet.UpdateInt(9, -1 * FieldScale)    //DECIMAL_DIGITS
    else
      TargetResultSet.UpdateInt(9, 0);    //DECIMAL_DIGITS

    TargetResultSet.UpdateInt(10, 10);   //NUM_PREC_RADIX

    if TempResultSet.GetIntByName('RDB$NULL_FLAG') <> 0 then
      TargetResultSet.UpdateInt(11, Ord(ntNoNulls))   //NULLABLE
    else
      TargetResultSet.UpdateInt(11, Ord(ntNullable));

    TargetResultSet.UpdateString(12, TempResultSet.GetStringByName('RDB$DESCRIPTION'));   //REMARKS
    TargetResultSet.UpdateString(13, DefaultValue);   //COLUMN_DEF
    TargetResultSet.UpdateNull(14);   //SQL_DATA_TYPE
    TargetResultSet.UpdateNull(15);   //SQL_DATETIME_SUB
    TargetResultSet.UpdateInt(16, TargetResultSet.GetInt(7));   //CHAR_OCTET_LENGTH
    TargetResultSet.UpdateInt(17, TempResultSet.GetIntByName('RDB$FIELD_POSITION') + 1);   //ORDINAL_POSITION

    if TempResultSet.IsNullByName('RDB$NULL_FLAG') then
      TargetResultSet.UpdateString(18, 'YES')   //IS_NULLABLE
    else
      TargetResultSet.UpdateString(18, 'NO');   //IS_NULLABLE

    TargetResultSet.UpdateNullByName('AUTO_INCREMENT');

    if CompareStr(ColumnName, UpperCase(ColumnName)) = 0 then
      TargetResultSet.UpdateBooleanByName('CASE_SENSITIVE', False)
    else
      TargetResultSet.UpdateBooleanByName('CASE_SENSITIVE', True);

    TargetResultSet.UpdateBooleanByName('SEARCHABLE', True);
    TargetResultSet.UpdateBooleanByName('WRITABLE', True);
    TargetResultSet.UpdateBooleanByName('DEFINITELYWRITABLE', True);
    TargetResultSet.UpdateBooleanByName('READONLY', False);

    TargetResultSet.InsertRow;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  Indicates that the column might not allow NULL values.
  A possible value for the column
  <code>NULLABLE</code>
  in the <code>ResultSet</code> returned by the method
  <code>getColumns</code>.
}
//int columnNoNulls = 0;

{**
  Indicates that the column definitely allows <code>NULL</code> values.
  A possible value for the column
  <code>NULLABLE</code>
  in the <code>ResultSet</code> returned by the method
  <code>getColumns</code>.
}
//int columnNullable = 1;

{**
  Indicates that the nullability of columns is unknown.
  A possible value for the column
  <code>NULLABLE</code>
  in the <code>ResultSet</code> returned by the method
  <code>getColumns</code>.
}
//int columnNullableUnknown = 2;

{**
  Gets a description of the access rights for a table's columns.

  <P>Only privileges matching the column name criteria are
  returned.  They are ordered by COLUMN_NAME and PRIVILEGE.

  <P>Each privilige description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>COLUMN_NAME</B> String => column name
 	<LI><B>GRANTOR</B> => grantor of access (may be null)
 	<LI><B>GRANTEE</B> String => grantee of access
 	<LI><B>PRIVILEGE</B> String => name of access (SELECT,
       INSERT, UPDATE, REFRENCES, ...)
 	<LI><B>IS_GRANTABLE</B> String => "YES" if grantee is permitted
       to grant to others; "NO" if not; null if unknown
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those without a schema
  @param table a table name
  @param columnNamePattern a column name pattern
  @return <code>ResultSet</code> - each row is a column privilege description
  @see #getSearchStringEscape
}
function TZInterbase6DatabaseMetadata.GetColumnPrivileges(Catalog: string;
  Schema: string; Table: string; ColumnNamePattern: string): IZResultSet;
var
  Sql: string;
  TableName, FieldName, Privilege, Grantor, Grantee, Grantable: string;
  TempResultSet, TempResultSet1: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetColumnPrivileges(Catalog, Schema,
    Table, ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  Table := ConstructNameCondition(Table, 'a.RDB$RELATION_NAME');
  ColumnNamePattern := ConstructNameCondition(ColumnNamePattern,
    'a.RDB$FIELD_NAME');

  Sql := 'SELECT a.RDB$USER, a.RDB$GRANTOR, a.RDB$PRIVILEGE, a.RDB$GRANT_OPTION, ' +
    ' a.RDB$RELATION_NAME, a.RDB$FIELD_NAME ' +
    ' FROM RDB$USER_PRIVILEGES a, RDB$TYPES b ' +
    ' WHERE a.RDB$OBJECT_TYPE = b.RDB$TYPE AND ';
  if Table <> '' then
    Sql := Sql + Table + ' AND ';
  if ColumnNamePattern <> '' then
    Sql := Sql + ColumnNamePattern + ' AND ';
  Sql := Sql + ' b.RDB$TYPE_NAME IN (''RELATION'', ''VIEW'', ''COMPUTED_FIELD'', ''FIELD'' ) AND ' +
    ' b.RDB$FIELD_NAME = ''RDB$OBJECT_TYPE'' ' +
    ' ORDER BY a.RDB$FIELD_NAME, a.RDB$PRIVILEGE  ' ;

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TableName := TempResultSet.GetStringByName('RDB$RELATION_NAME');
    FieldName := TempResultSet.GetStringByName('RDB$FIELD_NAME');
    Privilege := GetPrivilege(TempResultSet.GetStringByName('RDB$PRIVILEGE'));
    Grantor := TempResultSet.GetStringByName('RDB$GRANTOR');
    Grantee := TempResultSet.GetStringByName('RDB$USER');

    if Grantor = Grantee then
      Grantable := 'YES'
    else
      Grantable := 'NO';
    if FieldName = '' then
    begin
      Sql := 'SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS ' +
        ' WHERE RDB$RELATION_NAME = ''' + TableName + ''' AND ' +
        ' RDB$FIELD_NAME = ''' + ColumnNamePattern + ''' AND ';
      TempResultSet1 := GetConnection.CreateStatement.ExecuteQuery(Sql);
      while TempResultSet1.Next do
      begin
        TargetResultSet.MoveToInsertRow;
        TargetResultSet.UpdateNull(1);
        TargetResultSet.UpdateNull(2);
        TargetResultSet.UpdateString(3, TableName);
        TargetResultSet.UpdateString(4, TempResultSet1.GetString(1));
        TargetResultSet.UpdateString(5, Grantor);
        TargetResultSet.UpdateString(6, Grantee);
        TargetResultSet.UpdateString(7, Privilege);
        TargetResultSet.UpdateString(8, Grantable);
        TargetResultSet.InsertRow;
      end;
    end else begin
        TargetResultSet.MoveToInsertRow;
        TargetResultSet.UpdateNull(1);
        TargetResultSet.UpdateNull(2);
        TargetResultSet.UpdateString(3, TableName);
        TargetResultSet.UpdateString(4, FieldName);
        TargetResultSet.UpdateString(5, Grantor);
        TargetResultSet.UpdateString(6, Grantee);
        TargetResultSet.UpdateString(7, Privilege);
        TargetResultSet.UpdateString(8, Grantable);
        TargetResultSet.InsertRow;
    end;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  Gets a description of the access rights for each table available
  in a catalog. Note that a table privilege applies to one or
  more columns in the table. It would be wrong to assume that
  this priviledge applies to all columns (this may be true for
  some systems but is not true for all.)

  <P>Only privileges matching the schema and table name
  criteria are returned.  They are ordered by TABLE_SCHEM,
  TABLE_NAME, and PRIVILEGE.

  <P>Each privilige description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>GRANTOR</B> => grantor of access (may be null)
 	<LI><B>GRANTEE</B> String => grantee of access
 	<LI><B>PRIVILEGE</B> String => name of access (SELECT,
       INSERT, UPDATE, REFRENCES, ...)
 	<LI><B>IS_GRANTABLE</B> String => "YES" if grantee is permitted
       to grant to others; "NO" if not; null if unknown
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schemaPattern a schema name pattern; "" retrieves those
  without a schema
  @param tableNamePattern a table name pattern
  @return <code>ResultSet</code> - each row is a table privilege description
  @see #getSearchStringEscape
}
function TZInterbase6DatabaseMetadata.GetTablePrivileges(Catalog: string;
  SchemaPattern: string; TableNamePattern: string): IZResultSet;
var
  Sql: string;
  TableName, Privilege, Grantor, Grantee, Grantable: string;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTablePrivileges(Catalog, SchemaPattern,
    TableNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  TableNamePattern := ConstructNameCondition(TableNamePattern,
    'a.RDB$RELATION_NAME');

  Sql := 'SELECT a.RDB$USER, a.RDB$GRANTOR, a.RDB$PRIVILEGE, a.RDB$GRANT_OPTION, ' +
    ' a.RDB$RELATION_NAME ' +
    ' FROM RDB$USER_PRIVILEGES a, RDB$TYPES b ' +
    ' WHERE a.RDB$OBJECT_TYPE = b.RDB$TYPE AND ' +
    ' b.RDB$TYPE_NAME IN (''RELATION'', ''VIEW'', ''COMPUTED_FIELD'', ''FIELD'' ) AND ' +
    ' a.RDB$FIELD_NAME IS NULL ';
  if TableNamePattern <> '' then
    Sql := Sql + ' AND ' + TableNamePattern;
  Sql := Sql + ' ORDER BY a.RDB$RELATION_NAME, a.RDB$PRIVILEGE';

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TableName := TempResultSet.GetStringByName('RDB$RELATION_NAME');
    Privilege := GetPrivilege(TempResultSet.GetStringByName('RDB$PRIVILEGE'));
    Grantor := TempResultSet.GetStringByName('RDB$GRANTOR');
    Grantee := TempResultSet.GetStringByName('RDB$USER');

    if Grantor = Grantee then
      Grantable := 'YES'
    else
      Grantable := 'NO';

    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNull(1);
    TargetResultSet.UpdateNull(2);
    TargetResultSet.UpdateString(3, TableName);
    TargetResultSet.UpdateString(4, Grantor);
    TargetResultSet.UpdateString(5, Grantee);
    TargetResultSet.UpdateString(6, Privilege);
    TargetResultSet.UpdateString(7, Grantable);
    TargetResultSet.InsertRow;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  Gets a description of a table's optimal set of columns that
  uniquely identifies a row. They are ordered by SCOPE.

  <P>Each column description has the following columns:
   <OL>
 	<LI><B>SCOPE</B> short => actual scope of result
       <UL>
       <LI> bestRowTemporary - very temporary, while using row
       <LI> bestRowTransaction - valid for remainder of current transaction
       <LI> bestRowSession - valid for remainder of current session
       </UL>
 	<LI><B>COLUMN_NAME</B> String => column name
 	<LI><B>DATA_TYPE</B> short => SQL data type from java.sql.Types
 	<LI><B>TYPE_NAME</B> String => Data source dependent type name,
   for a UDT the type name is fully qualified
 	<LI><B>COLUMN_SIZE</B> int => precision
 	<LI><B>BUFFER_LENGTH</B> int => not used
 	<LI><B>DECIMAL_DIGITS</B> short	 => scale
 	<LI><B>PSEUDO_COLUMN</B> short => is this a pseudo column
       like an Oracle ROWID
       <UL>
       <LI> bestRowUnknown - may or may not be pseudo column
       <LI> bestRowNotPseudo - is NOT a pseudo column
       <LI> bestRowPseudo - is a pseudo column
       </UL>
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those without a schema
  @param table a table name
  @param scope the scope of interest; use same values as SCOPE
  @param nullable include columns that are nullable?
  @return <code>ResultSet</code> - each row is a column description
}
function TZInterbase6DatabaseMetadata.GetBestRowIdentifier(Catalog: string;
  Schema: string; Table: string; Scope: Integer; Nullable: Boolean): IZResultSet;
var
  Sql, FieldList: string;
  FieldScale, TypeName, SubTypeName: integer;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetBestRowIdentifier(Catalog, Schema,
    Table, Scope, Nullable) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  Table := ConstructNameCondition(Table, 'a.RDB$RELATION_NAME');

  Sql := ' SELECT distinct c.RDB$FIELD_NAME ' +
    ' FROM RDB$RELATION_FIELDS a ' +
    ' JOIN RDB$INDICES b ON ( a.RDB$RELATION_NAME = b.RDB$RELATION_NAME and b.RDB$UNIQUE_FLAG = 1) ' +
    ' JOIN RDB$INDEX_SEGMENTS c ON c.RDB$INDEX_NAME = b.RDB$INDEX_NAME ';
  if Table <> '' then
    Sql := Sql + ' WHERE ' + Table;
  Sql := Sql + ' ORDER BY a.RDB$RELATION_NAME, a.RDB$FIELD_NAME ';

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    if FieldList <> '' then
       FieldList := FieldList + ', ';
    FieldList := FieldList + '''' + TempResultSet.GetStringByName('RDB$FIELD_NAME') + '''';
  end;
  TempResultSet.Close;
  TempResultSet := nil;

  if StrPos(PChar(SeverVersion), 'Interbase 5') <> nil then
  begin
    Sql := 'SELECT a.RDB$RELATION_NAME, a.RDB$FIELD_NAME, a.RDB$FIELD_POSITION, ' +
      ' b. RDB$FIELD_LENGTH, b.RDB$FIELD_SCALE, c.RDB$TYPE_NAME, ' +
      ' b.RDB$FIELD_TYPE, b.RDB$FIELD_SUB_TYPE, b.RDB$CHARACTER_LENGTH, b.RDB$FIELD_SCALE as RDB$FIELD_PRECISION ' +
      ' FROM RDB$RELATION_FIELDS a, RDB$FIELDS b ' +
      ' LEFT JOIN RDB$TYPES c ON b.RDB$FIELD_TYPE = c.RDB$TYPE and c.RDB$FIELD_NAME = ''RDB$FIELD_TYPE'' ' +
      ' LEFT JOIN RDB$TYPES d ON b.RDB$FIELD_SUB_TYPE = d.RDB$TYPE and d.RDB$FIELD_NAME = ''RDB$FIELD_SUB_TYPE'' ' +
      ' WHERE a.RDB$FIELD_SOURCE = b.RDB$FIELD_NAME ';
    if Table <> '' then
      Sql := Sql + ' AND ' + Table; 
  end else begin
    Sql := 'SELECT a.RDB$RELATION_NAME, a.RDB$FIELD_NAME, a.RDB$FIELD_POSITION, ' +
      ' b. RDB$FIELD_LENGTH, b.RDB$FIELD_SCALE, c.RDB$TYPE_NAME, ' +
      ' b.RDB$FIELD_TYPE, b.RDB$FIELD_SUB_TYPE, b.RDB$CHARACTER_LENGTH, b.RDB$FIELD_PRECISION  ' +
      ' FROM RDB$RELATION_FIELDS a, RDB$FIELDS b ' +
      ' LEFT JOIN RDB$TYPES c ON b.RDB$FIELD_TYPE = c.RDB$TYPE and c.RDB$FIELD_NAME = ''RDB$FIELD_TYPE'' ' +
      ' LEFT JOIN RDB$TYPES d ON b.RDB$FIELD_SUB_TYPE = d.RDB$TYPE and d.RDB$FIELD_NAME = ''RDB$FIELD_SUB_TYPE'' ' +
      ' WHERE a.RDB$FIELD_SOURCE = b.RDB$FIELD_NAME ';
    if Table <> '' then
      Sql := Sql + ' AND ' + Table;
  end;
  if FieldList <> '' then
    Sql := Sql + ' AND a.RDB$FIELD_NAME IN (' + FieldList + ') ';
  Sql := Sql + ' ORDER BY a.RDB$RELATION_NAME, a.RDB$FIELD_POSITION ';

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TypeName := TempResultSet.GetIntByName('RDB$FIELD_TYPE');
    SubTypeName := TempResultSet.GetIntByName('RDB$FIELD_SUB_TYPE');
    FieldScale := TempResultSet.GetIntByName('RDB$FIELD_SCALE');

    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateInt(1, Ord(sbrSession));    //SCOPE
    TargetResultSet.UpdateString(2, TempResultSet.GetStringByName('RDB$FIELD_NAME'));    //COLUMN_NAME
    TargetResultSet.UpdateInt(3, Ord(ConvertInterbase6ToSqlType(TypeName, SubTypeName)));    //DATA_TYPE
    TargetResultSet.UpdateString(4, TempResultSet.GetStringByName('RDB$TYPE_NAME'));    //TYPE_NAME
    TargetResultSet.UpdateInt(5, TempResultSet.GetIntByName('RDB$FIELD_LENGTH'));    //COLUMN_SIZE
    TargetResultSet.UpdateNull(6);    //BUFFER_LENGTH
    if FieldScale < 0 then
      TargetResultSet.UpdateInt(7, -1 * FieldScale)    //DECIMAL_DIGITS
    else
      TargetResultSet.UpdateInt(7, 0);    //DECIMAL_DIGITS
    TargetResultSet.UpdateInt(8, Ord(brNotPseudo)); //PSEUDO_COLUMN
    TargetResultSet.InsertRow;
  end;

  Result := CloneCachedResultSet(Result);
end;

{**
  Indicates that the scope of the best row identifier is
  very temporary, lasting only while the
  row is being used.
  A possible value for the column
  <code>SCOPE</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getBestRowIdentifier</code>.
}
//    int bestRowTemporary   = 0;

{**
  Indicates that the scope of the best row identifier is
  the remainder of the current transaction.
  A possible value for the column
  <code>SCOPE</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getBestRowIdentifier</code>.
}
//    int bestRowTransaction = 1;

{**
  Indicates that the scope of the best row identifier is
  the remainder of the current session.
  A possible value for the column
  <code>SCOPE</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getBestRowIdentifier</code>.
}
//    int bestRowSession     = 2;

{**
  Indicates that the best row identifier may or may not be a pseudo column.
  A possible value for the column
  <code>PSEUDO_COLUMN</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getBestRowIdentifier</code>.
}
//    int bestRowUnknown	= 0;

{**
  Indicates that the best row identifier is NOT a pseudo column.
  A possible value for the column
  <code>PSEUDO_COLUMN</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getBestRowIdentifier</code>.
}
//    int bestRowNotPseudo	= 1;

{**
  Indicates that the best row identifier is a pseudo column.
  A possible value for the column
  <code>PSEUDO_COLUMN</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getBestRowIdentifier</code>.
}
//    int bestRowPseudo	= 2;

{**
  Gets a description of a table's columns that are automatically
  updated when any value in a row is updated.  They are
  unordered.

  <P>Each column description has the following columns:
   <OL>
 	<LI><B>SCOPE</B> short => is not used
 	<LI><B>COLUMN_NAME</B> String => column name
 	<LI><B>DATA_TYPE</B> short => SQL data type from java.sql.Types
 	<LI><B>TYPE_NAME</B> String => Data source dependent type name
 	<LI><B>COLUMN_SIZE</B> int => precision
 	<LI><B>BUFFER_LENGTH</B> int => length of column value in bytes
 	<LI><B>DECIMAL_DIGITS</B> short	 => scale
 	<LI><B>PSEUDO_COLUMN</B> short => is this a pseudo column
       like an Oracle ROWID
       <UL>
       <LI> versionColumnUnknown - may or may not be pseudo column
       <LI> versionColumnNotPseudo - is NOT a pseudo column
       <LI> versionColumnPseudo - is a pseudo column
       </UL>
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those without a schema
  @param table a table name
  @return <code>ResultSet</code> - each row is a column description
  @exception SQLException if a database access error occurs
}
function TZInterbase6DatabaseMetadata.GetVersionColumns(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetVersionColumns(Catalog, Schema, Table) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;

  TargetResultSet.SetConcurrency(rcUpdatable);
  TargetResultSet.MoveToInsertRow;
  TargetResultSet.UpdateNull(1);
  TargetResultSet.UpdateString(2, 'ctid');
//  TargetResultSet.UpdateInt(3, GetSQLType('tid')); //FIX IT
  TargetResultSet.UpdateString(4, 'tid');
  TargetResultSet.UpdateNull(5);
  TargetResultSet.UpdateNull(6);
  TargetResultSet.UpdateNull(7);
  TargetResultSet.UpdateInt(4, ord(vcPseudo));
  TargetResultSet.InsertRow;

  Result := CloneCachedResultSet(Result);
end;

{**
  Indicates that this version column may or may not be a pseudo column.
  A possible value for the column
  <code>PSEUDO_COLUMN</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getVersionColumns</code>.
}
//    int versionColumnUnknown	= 0;

{**
  Indicates that this version column is NOT a pseudo column.
  A possible value for the column
  <code>PSEUDO_COLUMN</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getVersionColumns</code>.
}
//    int versionColumnNotPseudo	= 1;

{**
  Indicates that this version column is a pseudo column.
  A possible value for the column
  <code>PSEUDO_COLUMN</code>
  in the <code>ResultSet</code> object
  returned by the method <code>getVersionColumns</code>.
}
//    int versionColumnPseudo	= 2;

{**
  Gets a description of a table's primary key columns.  They
  are ordered by COLUMN_NAME.

  <P>Each primary key column description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>COLUMN_NAME</B> String => column name
 	<LI><B>KEY_SEQ</B> short => sequence number within primary key
 	<LI><B>PK_NAME</B> String => primary key name (may be null)
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those
  without a schema
  @param table a table name
  @return <code>ResultSet</code> - each row is a primary key column description
  @exception SQLException if a database access error occurs
}
function TZInterbase6DatabaseMetadata.GetPrimaryKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  Sql, Key: string;
begin
  Key := Format('get-primary-keys:%s:%s:%s',
    [Catalog, Schema, Table]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    Table := ConstructNameCondition(Table, 'a.RDB$RELATION_NAME');

    Sql := ' SELECT null as TABLE_CAT, null as TABLE_SCHEM, a.RDB$RELATION_NAME as TABLE_NAME, ' +
      ' b.RDB$FIELD_NAME as COLUMN_NAME, b.RDB$FIELD_POSITION+1 as KEY_SEQ, a.RDB$INDEX_NAME as PK_NAME ' +
      ' FROM RDB$RELATION_CONSTRAINTS a ' +
      ' JOIN RDB$INDEX_SEGMENTS b ON (a.RDB$INDEX_NAME = b.RDB$INDEX_NAME) ' +
      ' WHERE  RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ';
    if Table <> '' then
      Sql := Sql + ' AND ' + Table;
    Sql := Sql + ' ORDER BY a.RDB$RELATION_NAME, b.RDB$FIELD_NAME ';

    Result := GetConnection.CreateStatement.ExecuteQuery(Sql);
    AddResultSetToCache(Key, Result);
    Result := CloneCachedResultSet(Result);
  end;
end;

{**
  Gets a description of the primary key columns that are
  referenced by a table's foreign key columns (the primary keys
  imported by a table).  They are ordered by PKTABLE_CAT,
  PKTABLE_SCHEM, PKTABLE_NAME, and KEY_SEQ.

  <P>Each primary key column description has the following columns:
   <OL>
 	<LI><B>PKTABLE_CAT</B> String => primary key table catalog
       being imported (may be null)
 	<LI><B>PKTABLE_SCHEM</B> String => primary key table schema
       being imported (may be null)
 	<LI><B>PKTABLE_NAME</B> String => primary key table name
       being imported
 	<LI><B>PKCOLUMN_NAME</B> String => primary key column name
       being imported
 	<LI><B>FKTABLE_CAT</B> String => foreign key table catalog (may be null)
 	<LI><B>FKTABLE_SCHEM</B> String => foreign key table schema (may be null)
 	<LI><B>FKTABLE_NAME</B> String => foreign key table name
 	<LI><B>FKCOLUMN_NAME</B> String => foreign key column name
 	<LI><B>KEY_SEQ</B> short => sequence number within foreign key
 	<LI><B>UPDATE_RULE</B> short => What happens to
        foreign key when primary is updated:
       <UL>
       <LI> importedNoAction - do not allow update of primary
                key if it has been imported
       <LI> importedKeyCascade - change imported key to agree
                with primary key update
       <LI> importedKeySetNull - change imported key to NULL if
                its primary key has been updated
       <LI> importedKeySetDefault - change imported key to default values
                if its primary key has been updated
       <LI> importedKeyRestrict - same as importedKeyNoAction
                                  (for ODBC 2.x compatibility)
       </UL>
 	<LI><B>DELETE_RULE</B> short => What happens to
       the foreign key when primary is deleted.
       <UL>
       <LI> importedKeyNoAction - do not allow delete of primary
                key if it has been imported
       <LI> importedKeyCascade - delete rows that import a deleted key
       <LI> importedKeySetNull - change imported key to NULL if
                its primary key has been deleted
       <LI> importedKeyRestrict - same as importedKeyNoAction
                                  (for ODBC 2.x compatibility)
       <LI> importedKeySetDefault - change imported key to default if
                its primary key has been deleted
       </UL>
 	<LI><B>FK_NAME</B> String => foreign key name (may be null)
 	<LI><B>PK_NAME</B> String => primary key name (may be null)
 	<LI><B>DEFERRABILITY</B> short => can the evaluation of foreign key
       constraints be deferred until commit
       <UL>
       <LI> importedKeyInitiallyDeferred - see SQL92 for definition
       <LI> importedKeyInitiallyImmediate - see SQL92 for definition
       <LI> importedKeyNotDeferrable - see SQL92 for definition
       </UL>
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those
  without a schema
  @param table a table name
  @return <code>ResultSet</code> - each row is a primary key column description
  @see #getExportedKeys
}
function TZInterbase6DatabaseMetadata.GetImportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  Sql: string;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := (inherited GetImportedKeys(Catalog, Schema, Table)) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  Table := ConstructNameCondition(Table, 'RELC_FOR.RDB$RELATION_NAME');

    Sql := 'SELECT ' +
	   ' RELC_PRIM.RDB$RELATION_NAME, ' +    // 1 prim.RDB$ key table name
	   ' IS_PRIM.RDB$FIELD_NAME, ' +         // 2 prim.RDB$ key column name
	   ' RELC_FOR.RDB$RELATION_NAME, ' +     // 3 foreign key table name
	   ' IS_FOR.RDB$FIELD_NAME, ' +          // 4 foreign key column name
	   ' IS_FOR.RDB$FIELD_POSITION, ' +      // 5 key sequence
	   ' REFC_PRIM.RDB$UPDATE_RULE, ' +      // 6
	   ' REFC_PRIM.RDB$DELETE_RULE, ' +      // 7
	   ' RELC_FOR.RDB$CONSTRAINT_NAME, ' +   // 8 foreign key constraint name
	   ' RELC_PRIM.RDB$CONSTRAINT_NAME ' +   // 9 primary key constraint name
	   ' FROM ' +
	   ' RDB$RELATION_CONSTRAINTS RELC_FOR, RDB$REF_CONSTRAINTS REFC_FOR, ' +
	   ' RDB$RELATION_CONSTRAINTS RELC_PRIM, RDB$REF_CONSTRAINTS REFC_PRIM, ' +
	   ' RDB$INDEX_SEGMENTS IS_PRIM,  RDB$INDEX_SEGMENTS IS_FOR ' +
	   ' WHERE ' +
	   ' RELC_FOR.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' AND ';
   if Table <> '' then
     Sql := Sql + Table + ' AND ';
	 Sql := Sql + ' RELC_FOR.RDB$CONSTRAINT_NAME = REFC_FOR.RDB$CONSTRAINT_NAME and ' +
	   ' REFC_FOR.RDB$CONST_NAME_UQ = RELC_PRIM.RDB$CONSTRAINT_NAME and ' +
	   ' RELC_PRIM.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' and ' + // useful check, anyay
	   ' RELC_PRIM.RDB$INDEX_NAME = IS_PRIM.RDB$INDEX_NAME and ' +
	   ' IS_FOR.RDB$INDEX_NAME = RELC_FOR.RDB$INDEX_NAME   and ' +
	   ' IS_PRIM.RDB$FIELD_POSITION = IS_FOR.RDB$FIELD_POSITION  and ' +
	   ' REFC_PRIM.RDB$CONSTRAINT_NAME = RELC_FOR.RDB$CONSTRAINT_NAME ' +
	   ' ORDER BY ' +
	   ' RELC_PRIM.RDB$RELATION_NAME, IS_FOR.RDB$FIELD_POSITION ';

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNullByName('PKTABLE_CAT');
    TargetResultSet.UpdateNullByName('PKTABLE_SCHEM');
    TargetResultSet.UpdateStringByName('PKTABLE_NAME', TempResultSet.GetString(1));
    TargetResultSet.UpdateStringByName('PKCOLUMN_NAME', TempResultSet.GetString(2));
    TargetResultSet.UpdateNullByName('FKTABLE_CAT');
    TargetResultSet.UpdateNullByName('FKTABLE_SCHEM');
    TargetResultSet.UpdateStringByName('FKTABLE_NAME', TempResultSet.GetString(3));
    TargetResultSet.UpdateStringByName('FKCOLUMN_NAME', TempResultSet.GetString(4));
    TargetResultSet.UpdateIntByName('KEY_SEQ', TempResultSet.GetInt(5) + 1);

    if TempResultSet.GetString(6) = 'RESTRICT' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikRestrict))
    else if TempResultSet.GetString(6) = 'NO ACTION' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikNoAction))
    else if TempResultSet.GetString(6) = 'SET DEFAULT' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikSetDefault))
    else if TempResultSet.GetString(6) = 'CASCADE' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikCascade))
    else if TempResultSet.GetString(6) = 'SET NULL' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikSetNull));

    if TempResultSet.GetString(7) = 'RESTRICT' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikRestrict))
    else if TempResultSet.GetString(7) = 'NO ACTION' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikNoAction))
    else if TempResultSet.GetString(7) = 'SET DEFAULT' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikSetDefault))
    else if TempResultSet.GetString(7) = 'CASCADE' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikCascade))
    else if TempResultSet.GetString(7) = 'SET NULL' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikSetNull));

    TargetResultSet.UpdateString(3, TempResultSet.GetString(1));
    TargetResultSet.UpdateStringByName('FK_NAME', TempResultSet.GetString(8));
    TargetResultSet.UpdateStringByName('PK_NAME', TempResultSet.GetString(9));
    TargetResultSet.UpdateNullByName('DEFERRABILITY');
    TargetResultSet.InsertRow;
  end;
  TempResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

{**
  A possible value for the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code> in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>For the column <code>UPDATE_RULE</code>,
  it indicates that
  when the primary key is updated, the foreign key (imported key)
  is changed to agree with it.
  <P>For the column <code>DELETE_RULE</code>,
  it indicates that
  when the primary key is deleted, rows that imported that key
  are deleted.
}
//    int importedKeyCascade	= 0;

{**
  A possible value for the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code> in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>For the column <code>UPDATE_RULE</code>, it indicates that
  a primary key may not be updated if it has been imported by
  another table as a foreign key.
  <P>For the column <code>DELETE_RULE</code>, it indicates that
  a primary key may not be deleted if it has been imported by
  another table as a foreign key.
}
//    int importedKeyRestrict = 1;

{**
  A possible value for the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code> in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>For the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code>,
  it indicates that
  when the primary key is updated or deleted, the foreign key (imported key)
  is changed to <code>NULL</code>.
}
//    int importedKeySetNull  = 2;

{**
  A possible value for the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code> in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>For the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code>,
  it indicates that
  if the primary key has been imported, it cannot be updated or deleted.
}
//    int importedKeyNoAction = 3;

{**
  A possible value for the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code> in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>For the columns <code>UPDATE_RULE</code>
  and <code>DELETE_RULE</code>,
  it indicates that
  if the primary key is updated or deleted, the foreign key (imported key)
  is set to the default value.
}
//    int importedKeySetDefault  = 4;

{**
  A possible value for the column <code>DEFERRABILITY</code>
  in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>Indicates deferrability.  See SQL-92 for a definition.
}
//    int importedKeyInitiallyDeferred  = 5;

{**
  A possible value for the column <code>DEFERRABILITY</code>
  in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>Indicates deferrability.  See SQL-92 for a definition.
}
//    int importedKeyInitiallyImmediate  = 6;

{**
  A possible value for the column <code>DEFERRABILITY</code>
  in the
  <code>ResultSet</code> objects returned by the methods
  <code>getImportedKeys</code>,  <code>getExportedKeys</code>,
  and <code>getCrossReference</code>.
  <P>Indicates deferrability.  See SQL-92 for a definition.
}
//    int importedKeyNotDeferrable  = 7;

{**
  Gets a description of the foreign key columns that reference a
  table's primary key columns (the foreign keys exported by a
  table).  They are ordered by FKTABLE_CAT, FKTABLE_SCHEM,
  FKTABLE_NAME, and KEY_SEQ.

  <P>Each foreign key column description has the following columns:
   <OL>
 	<LI><B>PKTABLE_CAT</B> String => primary key table catalog (may be null)
 	<LI><B>PKTABLE_SCHEM</B> String => primary key table schema (may be null)
 	<LI><B>PKTABLE_NAME</B> String => primary key table name
 	<LI><B>PKCOLUMN_NAME</B> String => primary key column name
 	<LI><B>FKTABLE_CAT</B> String => foreign key table catalog (may be null)
       being exported (may be null)
 	<LI><B>FKTABLE_SCHEM</B> String => foreign key table schema (may be null)
       being exported (may be null)
 	<LI><B>FKTABLE_NAME</B> String => foreign key table name
       being exported
 	<LI><B>FKCOLUMN_NAME</B> String => foreign key column name
       being exported
 	<LI><B>KEY_SEQ</B> short => sequence number within foreign key
 	<LI><B>UPDATE_RULE</B> short => What happens to
        foreign key when primary is updated:
       <UL>
       <LI> importedNoAction - do not allow update of primary
                key if it has been imported
       <LI> importedKeyCascade - change imported key to agree
                with primary key update
       <LI> importedKeySetNull - change imported key to NULL if
                its primary key has been updated
       <LI> importedKeySetDefault - change imported key to default values
                if its primary key has been updated
       <LI> importedKeyRestrict - same as importedKeyNoAction
                                  (for ODBC 2.x compatibility)
       </UL>
 	<LI><B>DELETE_RULE</B> short => What happens to
       the foreign key when primary is deleted.
       <UL>
       <LI> importedKeyNoAction - do not allow delete of primary
                key if it has been imported
       <LI> importedKeyCascade - delete rows that import a deleted key
       <LI> importedKeySetNull - change imported key to NULL if
                its primary key has been deleted
       <LI> importedKeyRestrict - same as importedKeyNoAction
                                  (for ODBC 2.x compatibility)
       <LI> importedKeySetDefault - change imported key to default if
                its primary key has been deleted
       </UL>
 	<LI><B>FK_NAME</B> String => foreign key name (may be null)
 	<LI><B>PK_NAME</B> String => primary key name (may be null)
 	<LI><B>DEFERRABILITY</B> short => can the evaluation of foreign key
       constraints be deferred until commit
       <UL>
       <LI> importedKeyInitiallyDeferred - see SQL92 for definition
       <LI> importedKeyInitiallyImmediate - see SQL92 for definition
       <LI> importedKeyNotDeferrable - see SQL92 for definition
       </UL>
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those
  without a schema
  @param table a table name
  @return <code>ResultSet</code> - each row is a foreign key column description
  @see #getImportedKeys
}
function TZInterbase6DatabaseMetadata.GetExportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  Sql: string;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := (inherited GetExportedKeys(Catalog, Schema, Table)) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  Table := ConstructNameCondition(Table, 'RC_PRIM.RDB$RELATION_NAME');

  Sql := ' SELECT ' +
   ' RC_PRIM.RDB$RELATION_NAME, ' +   // prim.RDB$ key table name
   ' IS_PRIM.RDB$FIELD_NAME, ' +      // prim.RDB$ key column name
   ' RC_FOR.RDB$RELATION_NAME, ' +    // foreign key table name
   ' IS_FOR.RDB$FIELD_NAME, ' +       // foreign key column name
   ' IS_FOR.RDB$FIELD_POSITION, ' +   // key sequence
   ' REFC_PRIM.RDB$UPDATE_RULE, ' +   // if update or delete rule is null, interpret as RESTRICT
   ' REFC_PRIM.RDB$DELETE_RULE, ' +
   ' RC_FOR.RDB$CONSTRAINT_NAME, ' +  // foreign key constraint name
   ' RC_PRIM.RDB$CONSTRAINT_NAME ' + // primary key constraint name
   ' FROM ' +
   ' RDB$RELATION_CONSTRAINTS RC_FOR, RDB$REF_CONSTRAINTS REFC_FOR, ' +
   ' RDB$RELATION_CONSTRAINTS RC_PRIM, RDB$REF_CONSTRAINTS REFC_PRIM, ' +
   ' RDB$INDEX_SEGMENTS IS_PRIM, RDB$INDEX_SEGMENTS IS_FOR ' +
   ' WHERE ' +
   ' RC_PRIM.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' and ';
  if Table <> '' then
    Sql := Sql + Table + ' AND ';
  Sql := Sql + ' REFC_FOR.RDB$CONST_NAME_UQ = RC_PRIM.RDB$CONSTRAINT_NAME and ' +
   ' RC_FOR.RDB$CONSTRAINT_NAME = REFC_FOR.RDB$CONSTRAINT_NAME and ' +
   ' RC_FOR.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' and ' + // useful check, anyay
   ' RC_PRIM.RDB$INDEX_NAME = IS_PRIM.RDB$INDEX_NAME and ' +
   ' IS_FOR.RDB$INDEX_NAME = RC_FOR.RDB$INDEX_NAME   and ' +
   ' IS_PRIM.RDB$FIELD_POSITION = IS_FOR.RDB$FIELD_POSITION  and ' +
   ' REFC_PRIM.RDB$CONSTRAINT_NAME = RC_FOR.RDB$CONSTRAINT_NAME ' +
   ' ORDER BY ' +
   ' RC_FOR.RDB$RELATION_NAME, IS_FOR.RDB$FIELD_POSITION ';

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(Sql);

  while TempResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNullByName('PKTABLE_CAT');
    TargetResultSet.UpdateNullByName('PKTABLE_SCHEM');
    TargetResultSet.UpdateStringByName('PKTABLE_NAME', TempResultSet.GetString(1));
    TargetResultSet.UpdateStringByName('PKCOLUMN_NAME', TempResultSet.GetString(2));
    TargetResultSet.UpdateNullByName('FKTABLE_CAT');
    TargetResultSet.UpdateNullByName('FKTABLE_SCHEM');
    TargetResultSet.UpdateStringByName('FKTABLE_NAME', TempResultSet.GetString(3));
    TargetResultSet.UpdateStringByName('FKCOLUMN_NAME', TempResultSet.GetString(4));
    TargetResultSet.UpdateIntByName('KEY_SEQ', TempResultSet.GetInt(5) + 1);

    if TempResultSet.GetString(6) = 'RESTRICT' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikRestrict))
    else if TempResultSet.GetString(6) = 'NO ACTION' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikNoAction))
    else if TempResultSet.GetString(6) = 'SET DEFAULT' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikSetDefault))
    else if TempResultSet.GetString(6) = 'CASCADE' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikCascade))
    else if TempResultSet.GetString(6) = 'SET NULL' then
      TargetResultSet.UpdateIntByName('UPDATE_RULE', ord(ikSetNull));

    if TempResultSet.GetString(7) = 'RESTRICT' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikRestrict))
    else if TempResultSet.GetString(7) = 'NO ACTION' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikNoAction))
    else if TempResultSet.GetString(7) = 'SET DEFAULT' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikSetDefault))
    else if TempResultSet.GetString(7) = 'CASCADE' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikCascade))
    else if TempResultSet.GetString(7) = 'SET NULL' then
      TargetResultSet.UpdateIntByName('DELETE_RULE', ord(ikSetNull));

    TargetResultSet.UpdateString(3, TempResultSet.GetString(1));
    TargetResultSet.UpdateStringByName('FK_NAME', TempResultSet.GetString(8));
    TargetResultSet.UpdateStringByName('PK_NAME', TempResultSet.GetString(9));
    TargetResultSet.UpdateNullByName('DEFERRABILITY');
    TargetResultSet.InsertRow;
  end;
  TempResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

{**
  Gets a description of the foreign key columns in the foreign key
  table that reference the primary key columns of the primary key
  table (describe how one table imports another's key.) This
  should normally return a single foreign key/primary key pair
  (most tables only import a foreign key from a table once.)  They
  are ordered by FKTABLE_CAT, FKTABLE_SCHEM, FKTABLE_NAME, and
  KEY_SEQ.

  <P>Each foreign key column description has the following columns:
   <OL>
 	<LI><B>PKTABLE_CAT</B> String => primary key table catalog (may be null)
 	<LI><B>PKTABLE_SCHEM</B> String => primary key table schema (may be null)
 	<LI><B>PKTABLE_NAME</B> String => primary key table name
 	<LI><B>PKCOLUMN_NAME</B> String => primary key column name
 	<LI><B>FKTABLE_CAT</B> String => foreign key table catalog (may be null)
       being exported (may be null)
 	<LI><B>FKTABLE_SCHEM</B> String => foreign key table schema (may be null)
       being exported (may be null)
 	<LI><B>FKTABLE_NAME</B> String => foreign key table name
       being exported
 	<LI><B>FKCOLUMN_NAME</B> String => foreign key column name
       being exported
 	<LI><B>KEY_SEQ</B> short => sequence number within foreign key
 	<LI><B>UPDATE_RULE</B> short => What happens to
        foreign key when primary is updated:
       <UL>
       <LI> importedNoAction - do not allow update of primary
                key if it has been imported
       <LI> importedKeyCascade - change imported key to agree
                with primary key update
       <LI> importedKeySetNull - change imported key to NULL if
                its primary key has been updated
       <LI> importedKeySetDefault - change imported key to default values
                if its primary key has been updated
       <LI> importedKeyRestrict - same as importedKeyNoAction
                                  (for ODBC 2.x compatibility)
       </UL>
 	<LI><B>DELETE_RULE</B> short => What happens to
       the foreign key when primary is deleted.
       <UL>
       <LI> importedKeyNoAction - do not allow delete of primary
                key if it has been imported
       <LI> importedKeyCascade - delete rows that import a deleted key
       <LI> importedKeySetNull - change imported key to NULL if
                its primary key has been deleted
       <LI> importedKeyRestrict - same as importedKeyNoAction
                                  (for ODBC 2.x compatibility)
       <LI> importedKeySetDefault - change imported key to default if
                its primary key has been deleted
       </UL>
 	<LI><B>FK_NAME</B> String => foreign key name (may be null)
 	<LI><B>PK_NAME</B> String => primary key name (may be null)
 	<LI><B>DEFERRABILITY</B> short => can the evaluation of foreign key
       constraints be deferred until commit
       <UL>
       <LI> importedKeyInitiallyDeferred - see SQL92 for definition
       <LI> importedKeyInitiallyImmediate - see SQL92 for definition
       <LI> importedKeyNotDeferrable - see SQL92 for definition
       </UL>
   </OL>

  @param primaryCatalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param primarySchema a schema name; "" retrieves those
  without a schema
  @param primaryTable the table name that exports the key
  @param foreignCatalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param foreignSchema a schema name; "" retrieves those
  without a schema
  @param foreignTable the table name that imports the key
  @return <code>ResultSet</code> - each row is a foreign key column description
  @see #getImportedKeys
}
function TZInterbase6DatabaseMetadata.GetCrossReference(PrimaryCatalog: string;
  PrimarySchema: string; PrimaryTable: string; ForeignCatalog: string;
  ForeignSchema: string; ForeignTable: string): IZResultSet;
{var
  Sql: string;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;}
begin
{    Sql := ' SELECT ' +
	   ' RC_PRIM.RDB$RELATION_NAME, ' +    // prim.RDB$ key table name
	   ' IS_PRIM.RDB$FIELD_NAME, ' +       // prim.RDB$ key column name
	   ' RC_FOR.RDB$RELATION_NAME, ' +     // foreign key table name
	   ' IS_FOR.RDB$FIELD_NAME, ' +        // foreign key column name
	   ' IS_FOR.RDB$FIELD_POSITION, ' +    // key sequence
	   ' REFC_PRIM.RDB$UPDATE_RULE, ' +    // if update or delete rule is null, interpret as RESTRICT
	   ' REFC_PRIM.RDB$DELETE_RULE, ' +
	   ' RC_FOR.RDB$CONSTRAINT_NAME, ' +   // foreign key constraint name
	   ' RC_PRIM.RDB$CONSTRAINT_NAME ' +  // primary key constraint name
	   ' FROM ' +
	   ' RDB$RELATION_CONSTRAINTS RC_FOR, ' +
	   ' RDB$REF_CONSTRAINTS REFC_FOR, ' +
	   ' RDB$RELATION_CONSTRAINTS RC_PRIM, ' +
	   ' RDB$REF_CONSTRAINTS REFC_PRIM, ' +
	   ' RDB$INDEX_SEGMENTS IS_PRIM, ' +
	   ' RDB$INDEX_SEGMENTS IS_FOR ' +
	   ' WHERE ' +
	   ' RC_PRIM.RDB$RELATION_NAME = ' + PrimaryTable + ' and ' +
	   ' RC_FOR.RDB$RELATION_NAME = ' + ForeignTable + ' and ' +
	   ' RC_PRIM.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' and ' +
	   ' REFC_FOR.RDB$CONST_NAME_UQ = RC_PRIM.RDB$CONSTRAINT_NAME and ' +
	   ' RC_FOR.RDB$CONSTRAINT_NAME = REFC_FOR.RDB$CONSTRAINT_NAME and ' +
	   ' RC_FOR.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' and ' + // useful check, anyay
	   ' RC_PRIM.RDB$INDEX_NAME = IS_PRIM.RDB$INDEX_NAME and ' +
	   ' IS_FOR.RDB$INDEX_NAME = RC_FOR.RDB$INDEX_NAME and ' +
	   ' IS_PRIM.RDB$FIELD_POSITION = IS_FOR.RDB$FIELD_POSITION and ' +
	   ' REFC_PRIM.RDB$CONSTRAINT_NAME = RC_FOR.RDB$CONSTRAINT_NAME ' +
	   ' order by ' +
	   ' RC_PRIM.RDB$RELATION_NAME, IS_FOR.RDB$FIELD_POSITION ';

  TempResultSet := Connection.CreateStatement.ExecuteQuery(Sql);
  TargetResultSet := (inherited GetCrossReference(PrimaryCatalog, PrimarySchema,
    PrimaryTable, ForeignCatalog, ForeignSchema, ForeignTable)) as IZVirtualResultSet;
  TargetResultSet.SetConcurrency(rcUpdatable);

  while TempResultSet.Next do
  begin
    Result.MoveToInsertRow;
    Result.UpdateNull('PKTABLE_CAT');
    Result.UpdateNull('PKTABLE_SCHEM');
    Result.UpdateString('PKTABLE_NAME', TempResultSet.GetString(1));
    Result.UpdateString('PKCOLUMN_NAME', TempResultSet.GetString(2));
    Result.UpdateNull('FKTABLE_CAT');
    Result.UpdateNull('FKTABLE_SCHEM');
    Result.UpdateString('FKTABLE_NAME', TempResultSet.GetString(3));
    Result.UpdateString('FKCOLUMN_NAME', TempResultSet.GetString(4));
    Result.UpdateInt('KEY_SEQ', TempResultSet.GetInt(5));
    Result.UpdateString('UPDATE_RULE', TempResultSet.GetString(6));
    Result.UpdateString('DELETE_RULE', TempResultSet.GetString(7));
    Result.UpdateString(3, TempResultSet.GetString(1));
    Result.UpdateString('FK_NAME', TempResultSet.GetString(8));
    Result.UpdateString('PK_NAME', TempResultSet.GetString(9));
    Result.UpdateNull('DEFERRABILITY');
    Result.InsertRow;
  end;
  TempResultSet.Close;
  TargetResultSet.SetConcurrency(rcReadOnly);
  TargetResultSet.BeforeFirst;
  Result := TargetResultSet;}
  Result := inherited GetCrossReference(PrimaryCatalog, PrimarySchema,
    PrimaryTable, ForeignCatalog, ForeignSchema, ForeignTable);
  Result := CloneCachedResultSet(Result);
end;

{**
  Gets a description of all the standard SQL types supported by
  this database. They are ordered by DATA_TYPE and then by how
  closely the data type maps to the corresponding JDBC SQL type.

  <P>Each type description has the following columns:
   <OL>
 	<LI><B>TYPE_NAME</B> String => Type name
 	<LI><B>DATA_TYPE</B> short => SQL data type from java.sql.Types
 	<LI><B>PRECISION</B> int => maximum precision
 	<LI><B>LITERAL_PREFIX</B> String => prefix used to quote a literal
       (may be null)
 	<LI><B>LITERAL_SUFFIX</B> String => suffix used to quote a literal
        (may be null)
 	<LI><B>CREATE_PARAMS</B> String => parameters used in creating
       the type (may be null)
 	<LI><B>NULLABLE</B> short => can you use NULL for this type?
       <UL>
       <LI> typeNoNulls - does not allow NULL values
       <LI> typeNullable - allows NULL values
       <LI> typeNullableUnknown - nullability unknown
       </UL>
 	<LI><B>CASE_SENSITIVE</B> boolean=> is it case sensitive?
 	<LI><B>SEARCHABLE</B> short => can you use "WHERE" based on this type:
       <UL>
       <LI> typePredNone - No support
       <LI> typePredChar - Only supported with WHERE .. LIKE
       <LI> typePredBasic - Supported except for WHERE .. LIKE
       <LI> typeSearchable - Supported for all WHERE ..
       </UL>
 	<LI><B>UNSIGNED_ATTRIBUTE</B> boolean => is it unsigned?
 	<LI><B>FIXED_PREC_SCALE</B> boolean => can it be a money value?
 	<LI><B>AUTO_INCREMENT</B> boolean => can it be used for an
       auto-increment value?
 	<LI><B>LOCAL_TYPE_NAME</B> String => localized version of type name
       (may be null)
 	<LI><B>MINIMUM_SCALE</B> short => minimum scale supported
 	<LI><B>MAXIMUM_SCALE</B> short => maximum scale supported
 	<LI><B>SQL_DATA_TYPE</B> int => unused
 	<LI><B>SQL_DATETIME_SUB</B> int => unused
 	<LI><B>NUM_PREC_RADIX</B> int => usually 2 or 10
   </OL>

  @return <code>ResultSet</code> - each row is an SQL type description
}
function TZInterbase6DatabaseMetadata.GetTypeInfo: IZResultSet;
var
  SQL: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
begin
  TargetResultSet := inherited GetTypeInfo as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  SQL := ' SELECT RDB$TYPE, RDB$TYPE_NAME FROM RDB$TYPES ' +
    ' WHERE RDB$FIELD_NAME = ''RDB$FIELD_TYPE'' ';
  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while ResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(1, ResultSet.GetString(2));
    TargetResultSet.UpdateInt(2, ord(
    ConvertInterbase6ToSqlType(ResultSet.GetInt(1), 0)));
    TargetResultSet.UpdateInt(3, 9);
    TargetResultSet.UpdateInt(7, ord(ntNoNulls));
    TargetResultSet.UpdateBoolean(8, false);
    TargetResultSet.UpdateBoolean(9, false);
    TargetResultSet.UpdateBoolean(11, false);
    TargetResultSet.UpdateBoolean(12, false);
    TargetResultSet.UpdateInt(18, 10);
    TargetResultSet.InsertRow;
  end;
  ResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

{**
  A possible value for column <code>NULLABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that a <code>NULL</code> value is NOT allowed for this
  data type.
}
//int typeNoNulls = 0;

{**
  A possible value for column <code>NULLABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that a <code>NULL</code> value is allowed for this
  data type.
}
//int typeNullable = 1;

{**
  A possible value for column <code>NULLABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that it is not known whether a <code>NULL</code> value
  is allowed for this data type.
}
//int typeNullableUnknown = 2;

{**
  A possible value for column <code>SEARCHABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that <code>WHERE</code> search clauses are not supported
  for this type.
}
//    int typePredNone = 0;

{**
  A possible value for column <code>SEARCHABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that the only <code>WHERE</code> search clause that can
  be based on this type is <code>WHERE . . .LIKE</code>.
}
//    int typePredChar = 1;

{**
  A possible value for column <code>SEARCHABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that one can base all <code>WHERE</code> search clauses
  except <code>WHERE . . .LIKE</code> on this data type.
}
//    int typePredBasic = 2;

{**
  A possible value for column <code>SEARCHABLE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getTypeInfo</code>.
  <p>Indicates that all <code>WHERE</code> search clauses can be
  based on this type.
}
//    int typeSearchable  = 3;

{**
  Gets a description of a table's indices and statistics. They are
  ordered by NON_UNIQUE, TYPE, INDEX_NAME, and ORDINAL_POSITION.

  <P>Each index column description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>NON_UNIQUE</B> boolean => Can index values be non-unique?
       false when TYPE is tableIndexStatistic
 	<LI><B>INDEX_QUALIFIER</B> String => index catalog (may be null);
       null when TYPE is tableIndexStatistic
 	<LI><B>INDEX_NAME</B> String => index name; null when TYPE is
       tableIndexStatistic
 	<LI><B>TYPE</B> short => index type:
       <UL>
       <LI> tableIndexStatistic - this identifies table statistics that are
            returned in conjuction with a table's index descriptions
       <LI> tableIndexClustered - this is a clustered index
       <LI> tableIndexHashed - this is a hashed index
       <LI> tableIndexOther - this is some other style of index
       </UL>
 	<LI><B>ORDINAL_POSITION</B> short => column sequence number
       within index; zero when TYPE is tableIndexStatistic
 	<LI><B>COLUMN_NAME</B> String => column name; null when TYPE is
       tableIndexStatistic
 	<LI><B>ASC_OR_DESC</B> String => column sort sequence, "A" => ascending,
       "D" => descending, may be null if sort sequence is not supported;
       null when TYPE is tableIndexStatistic
 	<LI><B>CARDINALITY</B> int => When TYPE is tableIndexStatistic, then
       this is the number of rows in the table; otherwise, it is the
       number of unique values in the index.
 	<LI><B>PAGES</B> int => When TYPE is  tableIndexStatisic then
       this is the number of pages used for the table, otherwise it
       is the number of pages used for the current index.
 	<LI><B>FILTER_CONDITION</B> String => Filter condition, if any.
       (may be null)
   </OL>

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schema a schema name; "" retrieves those without a schema
  @param table a table name
  @param unique when true, return only indices for unique values;
      when false, return indices regardless of whether unique or not
  @param approximate when true, result is allowed to reflect approximate
      or out of data values; when false, results are requested to be
      accurate
  @return <code>ResultSet</code> - each row is an index column description
}
function TZInterbase6DatabaseMetadata.GetIndexInfo(Catalog: string;
  Schema: string; Table: string; Unique: Boolean;
  Approximate: Boolean): IZResultSet;
var
  SQL: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
begin
  TargetResultSet := inherited GetIndexInfo(Catalog, Schema, Table, Unique,
    Approximate) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  SQL :=  ' SELECT I.RDB$RELATION_NAME, I.RDB$UNIQUE_FLAG, I.RDB$INDEX_NAME, ' +
    ' ISGMT.RDB$FIELD_POSITION,	ISGMT.RDB$FIELD_NAME, I.RDB$INDEX_TYPE, ' +
	  ' I.RDB$SEGMENT_COUNT, COUNT (DISTINCT P.RDB$PAGE_NUMBER) ' +
    ' FROM RDB$INDICES I '+
    ' JOIN  RDB$INDEX_SEGMENTS ISGMT ON I.RDB$INDEX_NAME = ISGMT.RDB$INDEX_NAME ' +
    ' JOIN  RDB$RELATIONS R ON (R.RDB$RELATION_NAME = I.RDB$RELATION_NAME) ' +
    ' JOIN  RDB$PAGES P ON (P.RDB$RELATION_ID = R.RDB$RELATION_ID AND ' +
    '                       P.RDB$PAGE_TYPE = 7 OR P.RDB$PAGE_TYPE = 6)' +
	  ' WHERE ';

  if Unique then
    SQL := Sql + ' I.RDB$UNIQUE_FLAG = 1 AND ';

  SQL := SQL + ' I.RDB$RELATION_NAME = ''' + Table + ''' '+
	   ' GROUP BY ' +
     ' I.RDB$INDEX_NAME, I.RDB$RELATION_NAME, I.RDB$UNIQUE_FLAG, ' +
     ' ISGMT.RDB$FIELD_POSITION, ISGMT.RDB$FIELD_NAME, I.RDB$INDEX_TYPE, ' +
     ' I.RDB$SEGMENT_COUNT ' +
     ' ORDER BY 2,3,4 ';

    ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while ResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNullByName('TABLE_CAT');
    TargetResultSet.UpdateNullByName('TABLE_SCHEM');
    TargetResultSet.UpdateStringByName('TABLE_NAME', ResultSet.GetStringByName('RDB$RELATION_NAME'));
    TargetResultSet.UpdateBooleanByName('NON_UNIQUE', not ResultSet.GetBooleanByName('RDB$UNIQUE_FLAG'));
    TargetResultSet.UpdateNullByName('INDEX_QUALIFIER');
    TargetResultSet.UpdateStringByName('INDEX_NAME', ResultSet.GetStringByName('RDB$INDEX_NAME'));
    TargetResultSet.UpdateIntByName('TYPE', ord(ntNoNulls));
    TargetResultSet.UpdateIntByName('ORDINAL_POSITION', ResultSet.GetIntByName('RDB$FIELD_POSITION') + 1);
    TargetResultSet.UpdateStringByName('COLUMN_NAME', ResultSet.GetStringByName('RDB$FIELD_NAME'));
    TargetResultSet.UpdateNullByName('ASC_OR_DESC');
    TargetResultSet.UpdateNullByName('CARDINALITY');
    TargetResultSet.UpdateIntByName('PAGES', ResultSet.GetIntByName('RDB$SEGMENT_COUNT'));
    TargetResultSet.UpdateNullByName('FILTER_CONDITION');
    TargetResultSet.InsertRow;
  end;
  ResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

{**
  A possible value for column <code>TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getIndexInfo</code>.
  <P>Indicates that this column contains table statistics that
  are returned in conjunction with a table's index descriptions.
}
//    short tableIndexStatistic = 0;

{**
  A possible value for column <code>TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getIndexInfo</code>.
  <P>Indicates that this table index is a clustered index.
}
//    short tableIndexClustered = 1;

{**
  A possible value for column <code>TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getIndexInfo</code>.
  <P>Indicates that this table index is a hashed index.
}
//    short tableIndexHashed    = 2;

{**
  A possible value for column <code>TYPE</code> in the
  <code>ResultSet</code> object returned by the method
  <code>getIndexInfo</code>.
  <P>Indicates that this table index is not a clustered
  index, a hashed index, or table statistics;
  it is something other than these.
}
//    short tableIndexOther     = 3;

{**
  Does the database support the given result set type?
  @param type defined in <code>java.sql.ResultSet</code>
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsResultSetType(
  _Type: TZResultSetType): Boolean;
begin
  Result := _Type = rtScrollInsensitive;
end;

{**
  Does the database support the concurrency type in combination
  with the given result set type?

  @param type defined in <code>java.sql.ResultSet</code>
  @param concurrency type defined in <code>java.sql.ResultSet</code>
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZInterbase6DatabaseMetadata.SupportsResultSetConcurrency(
  _Type: TZResultSetType; Concurrency: TZResultSetConcurrency): Boolean;
begin
  Result := (_Type = rtScrollInsensitive) and (Concurrency = rcReadOnly);
end;

{**
  Gets a description of the user-defined types defined in a particular
  schema.  Schema-specific UDTs may have type JAVA_OBJECT, STRUCT,
  or DISTINCT.

  <P>Only types matching the catalog, schema, type name and type
  criteria are returned.  They are ordered by DATA_TYPE, TYPE_SCHEM
  and TYPE_NAME.  The type name parameter may be a fully-qualified
  name.  In this case, the catalog and schemaPattern parameters are
  ignored.

  <P>Each type description has the following columns:
   <OL>
 	<LI><B>TYPE_CAT</B> String => the type's catalog (may be null)
 	<LI><B>TYPE_SCHEM</B> String => type's schema (may be null)
 	<LI><B>TYPE_NAME</B> String => type name
   <LI><B>CLASS_NAME</B> String => Java class name
 	<LI><B>DATA_TYPE</B> String => type value defined in java.sql.Types.
   One of JAVA_OBJECT, STRUCT, or DISTINCT
 	<LI><B>REMARKS</B> String => explanatory comment on the type
   </OL>

  <P><B>Note:</B> If the driver does not support UDTs, an empty
  result set is returned.

  @param catalog a catalog name; "" retrieves those without a
  catalog; null means drop catalog name from the selection criteria
  @param schemaPattern a schema name pattern; "" retrieves those
  without a schema
  @param typeNamePattern a type name pattern; may be a fully-qualified name
  @param types a list of user-named types to include (JAVA_OBJECT,
  STRUCT, or DISTINCT); null returns all types
  @return <code>ResultSet</code> - each row is a type description
}
function TZInterbase6DatabaseMetadata.GetUDTs(Catalog: string;
  SchemaPattern: string; TypeNamePattern: string;
  Types: TIntegerDynArray): IZResultSet;
begin
  raise EZSQLException.Create(SUnsupportedOperation);
end;

{**
  Gets a SQL syntax tokenizer.
  @returns a SQL syntax tokenizer object.
}
function TZInterbase6DatabaseMetadata.GetTokenizer: IZTokenizer;
begin
  if Tokenizer = nil then
    Tokenizer := TZInterbaseTokenizer.Create;
  Result := Tokenizer;
end;

{**
  Creates a statement analyser object.
  @returns a statement analyser object.
}
function TZInterbase6DatabaseMetadata.GetStatementAnalyser: IZStatementAnalyser;
begin
  if Analyser = nil then
    Analyser := TZInterbaseStatementAnalyser.Create;
  Result := Analyser;
end;

{**
  Gets a privilege name.
  @param  Interbase privilege name
  @returns a JDBC privilege name.
}
function TZInterbase6DatabaseMetadata.GetPrivilege(Privilege: string): string;
begin
  if Privilege = 'S' then
    Result := 'SELECT'
  else if Privilege = 'I' then
    Result := 'INSERT'
  else if Privilege = 'U' then
    Result := 'UPDATE'
  else if Privilege = 'D' then
    Result := 'DELETE'
  else if Privilege = 'R' then
    Result := 'REFERENCE'
end;

{**
   Takes a name patternand column name and retuen an appropriate SQL clause
    @param Pattern a sql pattren
    @parma Column a sql column name
    @return processed string for query
}
function TZInterbase6DatabaseMetadata.ConstructNameCondition(Pattern,
  Column: string): string;
const
  Spaces = '';
var
  StrippedPattern: string;
begin
  if (Length(Pattern) > 2 * 31) then
    raise EZSQLException.Create(SPattern2Long);

  if (Pattern = '%') or (Pattern = '') then Exit;

  if HasNoWildcards(Pattern) then
  begin
    StrippedPattern := StripEscape(Pattern);
    Result := Format('%s = ''%s''', [Column, StrippedPattern]);
  end
  else
  begin
    StrippedPattern := StripEscape(Pattern);
    Result := Format('%s || ''%s'' like ''%s%s%%''',
      [Column, Spaces, StrippedPattern, Spaces]);
  end;
end;

{**
   Check what pattern do not contain wildcards
   @param Pattern a sql pattern
   @return if pattern contain wildcards return true otherwise false
}
function TZInterbase6DatabaseMetadata.HasNoWildcards(
  const Pattern: string): boolean;
var
  I : integer;
  PreviousChar: string[1];
  PreviousCharWasEscape: boolean;
begin
  Result := False;
  PreviousChar := '';
  PreviousCharWasEscape := False;
  for I := 1 to Length(Pattern) do
  begin
    if not PreviousCharWasEscape and
       ((Pattern[I] = '_') or (Pattern[I] = '%')) then
     Exit;

    PreviousCharWasEscape := (Pattern[I] = '\') and (PreviousChar = '\');
    PreviousChar := Pattern[I];
  end;
  Result := True;
end;

{**
   Remove escapes from pattren string
   @param Pattern a sql pattern
   @return string without escapes
}
function TZInterbase6DatabaseMetadata.StripEscape(const Pattern: string): string;
var
  I: Integer;
  PreviousChar: string[1];
begin
  PreviousChar := '';
  for I := 1 to Length(Pattern) do
    if (Pattern <> '\') and (PreviousChar <> '\') then
    begin
      Result := Result + Pattern[I];
      PreviousChar := Pattern[I];
    end;
end;

function TZInterbase6DatabaseMetadata.GetSeverVersion: string;
begin
  if FSeverVersion = '' then
    FSeverVersion := GetVerion(FIBConnection.GetPlainDriver,
      FIBConnection.GetDBHandle);
  Result := FSeverVersion;
end;

end.

