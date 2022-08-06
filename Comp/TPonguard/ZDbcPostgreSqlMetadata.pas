{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{         PostgreSQL Database Connectivity Classes        }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{   Written by Sergey Seroukhov and Sergey Merkuriev      }
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

unit ZDbcPostgreSqlMetadata;

interface

{$I ZDbc.inc}

uses
  Classes, SysUtils, ZClasses, ZSysUtils, ZDbcIntfs, ZDbcMetadata,
  ZDbcResultSetMetadata, ZCompatibility, ZDbcPostgreSqlUtils,
  ZTokenizer, ZGenericSqlAnalyser, ZDbcConnection;

type

  {** Implements MySQL Database Metadata. }
  TZPostgreSQLDatabaseMetadata = class(TZAbstractDatabaseMetadata)
  private
    FDatabase: string;
  protected
    function GetColumnInfo(Table, Name: string; SQLType: TZSQLType;
      Length: Integer): TZColumnInfo;
    function GetVirtualResultSet(ColumnsInfo: TObjectList): TZVirtualResultSet;
    function HaveMinimumServerVersion(MajorVersion: Integer;
      MinorVersion: Integer): Boolean;
    function GetMaxIndexKeys: Integer;
    function GetMaxNameLength: Integer;
    function GetPostgreSQLType(Oid: Integer): string;
    function GetSQLTypeByOid(Oid: Integer): TZSQLType;
    function GetSQLTypeByName(TypeName: string): TZSQLType;
    function TableTypeSQLExpression(TableType: string; UseSchemas: Boolean):
      string;
    procedure ParseACLArray(List: TStrings; AclString: string);
    function GetPrivilegeName(Permission: char): string;
    function GetImportedExportedKeys(PrimaryCatalog, PrimarySchema,
      PrimaryTable, ForeignCatalog, ForeignSchema, ForeignTable: string):
      IZResultSet;
  public
    constructor Create(Connection: TZAbstractConnection; Url: string;
      Info: TStrings);
    destructor Destroy; override;

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
    function SupportsDataDefinitionAndDataManipulationTransactions: Boolean;
      override;
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
      TableNamePattern: string; ColumnNamePattern: string): IZResultSet;
      override;
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

uses
  Math, ZMessages, ZDbcUtils, ZPostgreSqlToken, ZDbcPostgreSql,
  ZPostgreSqlAnalyser;

{ TZMySQLDatabaseMetadata }

{**
  Constructs this object and assignes the main properties.
  @param Connection a database connection object.
  @param Url a database connection url string.
  @param Info an extra connection properties.
}
constructor TZPostgreSQLDatabaseMetadata.Create(
  Connection: TZAbstractConnection; Url: string; Info: TStrings);
var
  TempInfo: TStrings;
  Hostname, UserName, Password: string;
  Port: Integer;
begin
  inherited Create(Connection, Url, Info);

  TempInfo := TStringList.Create;
  try
    ResolveDatabaseUrl(Url, Info, HostName, Port, FDatabase,
      UserName, Password, TempInfo);
  finally
    TempInfo.Free;
  end;
end;

{**
  Destroys this object and cleanups the memory.
}
destructor TZPostgreSQLDatabaseMetadata.Destroy;
begin
  inherited Destroy;
end;

//----------------------------------------------------------------------
// First, a variety of minor information about the target database.

{**
  What's the name of this database product?
  @return database product name
}
function TZPostgreSQLDatabaseMetadata.GetDatabaseProductName: string;
begin
  Result := 'PostgreSQL';
end;

{**
  What's the version of this database product?
  @return database version
}
function TZPostgreSQLDatabaseMetadata.GetDatabaseProductVersion: string;
begin
  Result := '';
end;

{**
  What's the name of this JDBC driver?
  @return JDBC driver name
}
function TZPostgreSQLDatabaseMetadata.GetDriverName: string;
begin
  Result := 'Zeos Database Connectivity Driver for PostgreSQL';
end;

{**
  What's this JDBC driver's major version number?
  @return JDBC driver major version
}
function TZPostgreSQLDatabaseMetadata.GetDriverMajorVersion: Integer;
begin
  Result := 1;
end;

{**
  What's this JDBC driver's minor version number?
  @return JDBC driver minor version number
}
function TZPostgreSQLDatabaseMetadata.GetDriverMinorVersion: Integer;
begin
  Result := 1;
end;

{**
  Does the database use a file for each table?
  @return true if the database uses a local file for each table
}
function TZPostgreSQLDatabaseMetadata.UsesLocalFilePerTable: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case sensitive and as a result store them in mixed case?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver will always return false.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsMixedCaseIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in upper case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.StoresUpperCaseIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in lower case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.StoresLowerCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.StoresMixedCaseIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case sensitive and as a result store them in mixed case?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver will always return true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsMixedCaseQuotedIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in upper case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.StoresUpperCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in lower case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.StoresLowerCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.StoresMixedCaseQuotedIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Gets a comma-separated list of all a database's SQL keywords
  that are NOT also SQL92 keywords.
  @return the list
}
function TZPostgreSQLDatabaseMetadata.GetSQLKeywords: string;
begin
  Result := 'abort,acl,add,aggregate,append,archive,arch_store,backward,binary,change,'+
            'cluster,copy,database,delimiter,delimiters,do,extend,explain,forward,heavy,'+
            'index,inherits,isnull,light,listen,load,merge,nothing,notify,notnull,oids,'+
            'purge,rename,replace,retrieve,returns,rule,recipe,setof,stdin,stdout,store,'+
            'vacuum,verbose,version,user';
end;

{**
  Gets a comma-separated list of math functions.  These are the
  X/Open CLI math function names used in the JDBC function escape
  clause.
  @return the list
}
function TZPostgreSQLDatabaseMetadata.GetNumericFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of string functions.  These are the
  X/Open CLI string function names used in the JDBC function escape
  clause.
  @return the list
}
function TZPostgreSQLDatabaseMetadata.GetStringFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of system functions.  These are the
  X/Open CLI system function names used in the JDBC function escape
  clause.
  @return the list
}
function TZPostgreSQLDatabaseMetadata.GetSystemFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of time and date functions.
  @return the list
}
function TZPostgreSQLDatabaseMetadata.GetTimeDateFunctions: string;
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
function TZPostgreSQLDatabaseMetadata.GetSearchStringEscape: string;
begin
  Result := '\';
end;

{**
  Gets all the "extra" characters that can be used in unquoted
  identifier names (those beyond a-z, A-Z, 0-9 and _).
  @return the string containing the extra characters
}
function TZPostgreSQLDatabaseMetadata.GetExtraNameCharacters: string;
begin
  Result := '';
end;

//--------------------------------------------------------------------
// Functions describing which features are supported.

{**
  Are expressions in "ORDER BY" lists supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsExpressionsInOrderBy: Boolean;
begin
  Result := True;
end;

{**
  Can an "ORDER BY" clause use columns not in the SELECT statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsOrderByUnrelated: Boolean;
begin
  Result := HaveMinimumServerVersion(6, 4);
end;

{**
  Is some form of "GROUP BY" clause supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsGroupBy: Boolean;
begin
  Result := True;
end;

{**
  Can a "GROUP BY" clause use columns not in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsGroupByUnrelated: Boolean;
begin
  Result := HaveMinimumServerVersion(6, 4);
end;

{**
  Can a "GROUP BY" clause add columns not in the SELECT
  provided it specifies all the columns in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsGroupByBeyondSelect: Boolean;
begin
  Result := HaveMinimumServerVersion(6, 4);
end;

{**
  Is the SQL Integrity Enhancement Facility supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsIntegrityEnhancementFacility: Boolean;
begin
  Result := False;
end;

{**
  What's the database vendor's preferred term for "schema"?
  @return the vendor term
}
function TZPostgreSQLDatabaseMetadata.GetSchemaTerm: string;
begin
  Result := 'schema';
end;

{**
  What's the database vendor's preferred term for "procedure"?
  @return the vendor term
}
function TZPostgreSQLDatabaseMetadata.GetProcedureTerm: string;
begin
  Result := 'function';
end;

{**
  What's the database vendor's preferred term for "catalog"?
  @return the vendor term
}
function TZPostgreSQLDatabaseMetadata.GetCatalogTerm: string;
begin
  Result := 'database';
end;

{**
  What's the separator between catalog and table name?
  @return the separator string
}
function TZPostgreSQLDatabaseMetadata.GetCatalogSeparator: string;
begin
  Result := '.';
end;

{**
  Can a schema name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSchemasInDataManipulation: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 3);
end;

{**
  Can a schema name be used in a procedure call statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSchemasInProcedureCalls: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 3);
end;

{**
  Can a schema name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSchemasInTableDefinitions: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 3);
end;

{**
  Can a schema name be used in an index definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSchemasInIndexDefinitions: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 3);
end;

{**
  Can a schema name be used in a privilege definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSchemasInPrivilegeDefinitions: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 3);
end;

{**
  Can a catalog name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsCatalogsInDataManipulation: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a procedure call statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsCatalogsInProcedureCalls: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsCatalogsInTableDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in an index definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsCatalogsInIndexDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a privilege definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsCatalogsInPrivilegeDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Is positioned DELETE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsPositionedDelete: Boolean;
begin
  Result := False;
end;

{**
  Is positioned UPDATE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsPositionedUpdate: Boolean;
begin
  Result := False;
end;

{**
  Is SELECT for UPDATE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSelectForUpdate: Boolean;
begin
  Result := HaveMinimumServerVersion(6, 5);
end;

{**
  Are stored procedure calls using the stored procedure escape
  syntax supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsStoredProcedures: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in comparison expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSubqueriesInComparisons: Boolean;
begin
  Result := True;
end;

{**
  Are subqueries in 'exists' expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSubqueriesInExists: Boolean;
begin
  Result := True;
end;

{**
  Are subqueries in 'in' statements supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSubqueriesInIns: Boolean;
begin
  Result := True;
end;

{**
  Are subqueries in quantified expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsSubqueriesInQuantifieds: Boolean;
begin
  Result := True;
end;

{**
  Are correlated subqueries supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsCorrelatedSubqueries: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 1);
end;

{**
  Is SQL UNION supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsUnion: Boolean;
begin
  Result := True;
end;

{**
  Is SQL UNION ALL supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsUnionAll: Boolean;
begin
  Result := HaveMinimumServerVersion(7, 1);
end;

{**
  Can cursors remain open across commits?
  @return <code>true</code> if cursors always remain open;
        <code>false</code> if they might not remain open
}
function TZPostgreSQLDatabaseMetadata.SupportsOpenCursorsAcrossCommit: Boolean;
begin
  Result := False;
end;

{**
  Can cursors remain open across rollbacks?
  @return <code>true</code> if cursors always remain open;
        <code>false</code> if they might not remain open
}
function TZPostgreSQLDatabaseMetadata.SupportsOpenCursorsAcrossRollback: Boolean;
begin
  Result := False;
end;

{**
  Can statements remain open across commits?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZPostgreSQLDatabaseMetadata.SupportsOpenStatementsAcrossCommit: Boolean;
begin
  Result := True;
end;

{**
  Can statements remain open across rollbacks?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZPostgreSQLDatabaseMetadata.SupportsOpenStatementsAcrossRollback: Boolean;
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
function TZPostgreSQLDatabaseMetadata.GetMaxBinaryLiteralLength: Integer;
begin
  Result := 0;
end;

{**
  What's the max length for a character literal?
  @return max literal length;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxCharLiteralLength: Integer;
begin
  Result := 0;
end;

{**
  What's the limit on column name length?
  @return max column name length;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxColumnNameLength: Integer;
begin
  Result := getMaxNameLength;
end;

{**
  What's the maximum number of columns in a "GROUP BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxColumnsInGroupBy: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns allowed in an index?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxColumnsInIndex: Integer;
begin
  Result := GetMaxIndexKeys;
end;

{**
  What's the maximum number of columns in an "ORDER BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxColumnsInOrderBy: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns in a "SELECT" list?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxColumnsInSelect: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns in a table?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxColumnsInTable: Integer;
begin
  Result := 1600;
end;

{**
  How many active connections can we have at a time to this database?
  @return max number of active connections;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxConnections: Integer;
begin
  Result := 8192;
end;

{**
  What's the maximum cursor name length?
  @return max cursor name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxCursorNameLength: Integer;
begin
  Result := GetMaxNameLength;
end;

{**
  Retrieves the maximum number of bytes for an index, including all
  of the parts of the index.
  @return max index length in bytes, which includes the composite of all
   the constituent parts of the index;
   a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxIndexLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length allowed for a schema name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxSchemaNameLength: Integer;
begin
  Result := GetMaxNameLength;
end;

{**
  What's the maximum length of a procedure name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxProcedureNameLength: Integer;
begin
  Result := GetMaxNameLength;
end;

{**
  What's the maximum length of a catalog name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxCatalogNameLength: Integer;
begin
  Result := GetMaxNameLength;
end;

{**
  What's the maximum length of a single row?
  @return max row size in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxRowSize: Integer;
begin
  if HaveMinimumServerVersion(7, 1) then
    Result := 1073741824
  else Result := 8192;
end;

{**
  Did getMaxRowSize() include LONGVARCHAR and LONGVARBINARY
  blobs?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.DoesMaxRowSizeIncludeBlobs: Boolean;
begin
  Result := True;
end;

{**
  What's the maximum length of an SQL statement?
  @return max length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxStatementLength: Integer;
begin
  if HaveMinimumServerVersion(7, 0) then
    Result := 0
  else Result := 16348
end;

{**
  How many active statements can we have open at one time to this
  database?
  @return the maximum number of statements that can be open at one time;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxStatements: Integer;
begin
  Result := 1;
end;

{**
  What's the maximum length of a table name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxTableNameLength: Integer;
begin
  Result := GetMaxNameLength;
end;

{**
  What's the maximum number of tables in a SELECT statement?
  @return the maximum number of tables allowed in a SELECT statement;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxTablesInSelect: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a user name?
  @return max user name length  in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZPostgreSQLDatabaseMetadata.GetMaxUserNameLength: Integer;
begin
  Result := GetMaxNameLength;
end;

//----------------------------------------------------------------------

{**
  What's the database's default transaction isolation level?  The
  values are defined in <code>java.sql.Connection</code>.
  @return the default isolation level
  @see Connection
}
function TZPostgreSQLDatabaseMetadata.GetDefaultTransactionIsolation:
  TZTransactIsolationLevel;
begin
  Result := tiReadCommitted;
end;

{**
  Are transactions supported? If not, invoking the method
  <code>commit</code> is a noop and the isolation level is TRANSACTION_NONE.
  @return <code>true</code> if transactions are supported; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsTransactions: Boolean;
begin
  Result := True;
end;

{**
  Does this database support the given transaction isolation level?
  @param level the values are defined in <code>java.sql.Connection</code>
  @return <code>true</code> if so; <code>false</code> otherwise
  @see Connection
}
function TZPostgreSQLDatabaseMetadata.SupportsTransactionIsolationLevel(
  Level: TZTransactIsolationLevel): Boolean;
begin
  Result := (Level = tiSerializable) or (Level = tiReadCommitted);
end;

{**
  Are both data definition and data manipulation statements
  within a transaction supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.
  SupportsDataDefinitionAndDataManipulationTransactions: Boolean;
begin
  Result := True;
end;

{**
  Are only data manipulation statements within a transaction
  supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.
  SupportsDataManipulationTransactionsOnly: Boolean;
begin
  Result := False;
end;

{**
  Does a data definition statement within a transaction force the
  transaction to commit?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.DataDefinitionCausesTransactionCommit: Boolean;
begin
  Result := False;
end;

{**
  Is a data definition statement within a transaction ignored?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.DataDefinitionIgnoredInTransactions: Boolean;
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
function TZPostgreSQLDatabaseMetadata.GetProcedures(Catalog: string;
  SchemaPattern: string; ProcedureNamePattern: string): IZResultSet;
var
  SQL: string;
  Key: string;
begin
  Key := Format('get-procedures:%s:%s:%s',
    [Catalog, SchemaPattern, ProcedureNamePattern]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    if ProcedureNamePattern = '' then
      ProcedureNamePattern := '%';

    if HaveMinimumServerVersion(7, 3) then
    begin
      SQL := 'SELECT NULL AS PROCEDURE_CAT, n.nspname AS PROCEDURE_SCHEM, p.proname '+
        ' AS PROCEDURE_NAME, NULL AS RESERVED1, NULL AS RESERVED2, NULL AS RESERVED3, '+
        'd.description AS REMARKS, '+
        IntToStr(ProcedureReturnsResult) + ' AS PROCEDURE_TYPE '+
        ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_proc p  '+
        ' LEFT JOIN pg_catalog.pg_description d ON (p.oid=d.objoid) '+
        ' LEFT JOIN pg_catalog.pg_class c ON (d.classoid=c.oid AND c.relname=''pg_proc'') '+
        ' LEFT JOIN pg_catalog.pg_namespace pn ON (c.relnamespace=pn.oid AND pn.nspname=''pg_catalog'') '+
        ' WHERE p.pronamespace=n.oid ';
        if SchemaPattern <> '' then
          SQL := SQL + 'AND n.nspname LIKE ''' + EscapeQuotes(SchemaPattern)+''' ';
        SQL := SQL + ' AND p.proname LIKE ''' +  EscapeQuotes(ProcedureNamePattern)+
          ''' ORDER BY PROCEDURE_SCHEM, PROCEDURE_NAME ';
    end
    else if HaveMinimumServerVersion(7, 1) then
    begin
      SQL := 'SELECT NULL AS PROCEDURE_CAT, NULL AS PROCEDURE_SCHEM, p.proname AS '+
        'PROCEDURE_NAME, NULL AS RESERVED1, NULL AS RESERVED2, NULL AS RESERVED3, '
        +'d.description AS REMARKS, '+
        IntToStr(procedureReturnsResult) + ' AS PROCEDURE_TYPE FROM pg_proc p '+
        ' LEFT JOIN pg_description d ON (p.oid=d.objoid) ';
      if HaveMinimumServerVersion(7, 2) then
        SQL := SQL + ' LEFT JOIN pg_class c ON (d.classoid=c.oid AND c.relname=''pg_proc'') ';
      SQL := SQL + ' WHERE p.proname LIKE '''+EscapeQuotes(ProcedureNamePattern)+
         ''' ORDER BY PROCEDURE_NAME ';
    end
    else
    begin
      SQL := 'SELECT NULL AS PROCEDURE_CAT, NULL AS PROCEDURE_SCHEM, p.proname '+
        ' AS PROCEDURE_NAME, NULL AS RESERVED1, NULL AS RESERVED2, NULL AS RESERVED3,'+
        ' NULL AS REMARKS, '+
        IntToStr(ProcedureReturnsResult) + ' AS PROCEDURE_TYPE FROM pg_proc p '+
        ' WHERE p.proname LIKE '''+EscapeQuotes(ProcedureNamePattern)+''' '+
        ' ORDER BY PROCEDURE_NAME ';
    end;

    GetConnection.SetReadOnly(true);
    Result := GetConnection.CreateStatement.ExecuteQuery(SQL);
    AddResultSetToCache(Key, Result);
    Result := CloneCachedResultSet(Result);
  end;
end;

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
function TZPostgreSQLDatabaseMetadata.GetProcedureColumns(Catalog: string;
  SchemaPattern: string; ProcedureNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
var
  I, ReturnType, ColumnTypeOid, ArgOid: Integer;
  SQL, ReturnTypeType: string;
  ArgTypes: TStrings;
  ResultSet, ColumnsRS: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetProcedureColumns(Catalog, SchemaPattern,
    ProcedureNamePattern, ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if ColumnNamePattern = '' then
    ColumnNamePattern := '%';
  if ProcedureNamePattern = '' then
    ProcedureNamePattern := '%';

  if HaveMinimumServerVersion(7, 3) then
  begin
    SQL := 'SELECT n.nspname,p.proname,p.prorettype,p.proargtypes, t.typtype,t.typrelid '+
      ' FROM pg_catalog.pg_proc p, pg_catalog.pg_namespace n, pg_catalog.pg_type t '+
      ' WHERE p.pronamespace=n.oid AND p.prorettype=t.oid ';
    if SchemaPattern <> '' then
      SQL := SQL + ' AND n.nspname LIKE '''+EscapeQuotes(SchemaPattern)+''' ';
    SQL := SQL + ' AND p.proname LIKE '''+EscapeQuotes(ProcedureNamePattern)+
      ''' ORDER BY n.nspname, p.proname ';
  end
  else
    SQL := 'SELECT NULL AS nspname,p.proname,p.prorettype,p.proargtypes, t.typtype,t.typrelid '+
      ' FROM pg_proc p, pg_type t  WHERE p.prorettype=t.oid '+
      'AND p.proname LIKE '''+EscapeQuotes(ProcedureNamePattern)+
      ''' ORDER BY p.proname ';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);
  ArgTypes := TStringList.Create;

  while ResultSet.Next do
  begin
    ReturnType := StrToInt(ResultSet.GetStringByName('prorettype'));
    ReturnTypeType := ResultSet.GetStringByName('typtype');
    PutSplitString(ArgTypes, ResultSet.GetStringByName('proargtypes'), #10#13#9' ');

    if ReturnTypeType <> 'c' then
    begin
      TargetResultSet.MoveToInsertRow;
      TargetResultSet.UpdateNull(1);
      TargetResultSet.UpdateString(2, ResultSet.GetStringByName('nspname'));
      TargetResultSet.UpdateString(3, ResultSet.GetStringByName('proname'));
      TargetResultSet.UpdateString(4, 'returnValue');
      TargetResultSet.UpdateInt(5, Ord(pctReturn));
      TargetResultSet.UpdateInt(6, Ord(GetSQLTypeByOid(ReturnType)));
      TargetResultSet.UpdateString(7, GetPostgreSQLType(ReturnType));
      TargetResultSet.UpdateNull(8);
      TargetResultSet.UpdateNull(9);
      TargetResultSet.UpdateNull(10);
      TargetResultSet.UpdateNull(11);
      TargetResultSet.UpdateInt(12, Ord(ntNullableUnknown));
      TargetResultSet.UpdateNull(13);
      TargetResultSet.InsertRow;
    end;

    for I := 0 to ArgTypes.Count-1 do
    begin
      ArgOid := StrToInt(ArgTypes.Strings[i]);
      TargetResultSet.MoveToInsertRow;
      TargetResultSet.UpdateNull(1);
      TargetResultSet.UpdateString(2, ResultSet.GetStringByName('nspname'));
      TargetResultSet.UpdateString(3, ResultSet.GetStringByName('proname'));
      TargetResultSet.UpdateString(4, '$'+IntToStr(I));
      TargetResultSet.UpdateInt(5, Ord(pctIn));
      TargetResultSet.UpdateInt(6, Ord(GetSQLTypeByOid(ArgOid)));
      TargetResultSet.UpdateString(7, GetPostgreSQLType(ArgOid));
      TargetResultSet.UpdateNull(8);
      TargetResultSet.UpdateNull(9);
      TargetResultSet.UpdateNull(10);
      TargetResultSet.UpdateNull(11);
      TargetResultSet.UpdateInt(12, Ord(ntNullableUnknown));
      TargetResultSet.UpdateNull(13);
      TargetResultSet.InsertRow;
    end;

    if ReturnTypeType = 'c' then
    begin
      ColumnsRS := GetConnection.CreateStatement.ExecuteQuery(
        'SELECT a.attname,a.atttypid FROM pg_catalog.pg_attribute a '+
        ' WHERE a.attrelid = ' + ResultSet.GetStringByName('typrelid')+
        ' ORDER BY a.attnum');
      while ColumnsRS.Next do
      begin
        ColumnTypeOid := ColumnsRS.GetIntByName('atttypid');
        TargetResultSet.MoveToInsertRow;
        TargetResultSet.UpdateNull(1);
        TargetResultSet.UpdateString(2, ResultSet.GetStringByName('nspname'));
        TargetResultSet.UpdateString(3, ResultSet.GetStringByName('proname'));
        TargetResultSet.UpdateString(4, ColumnsRS.GetStringByName('attname'));
        TargetResultSet.UpdateInt(5, Ord(pctResultSet));
        TargetResultSet.UpdateInt(6, Ord(GetSQLTypeByOid(columnTypeOid)));
        TargetResultSet.UpdateString(7, GetPostgreSQLType(columnTypeOid));
        TargetResultSet.UpdateNull(8);
        TargetResultSet.UpdateNull(9);
        TargetResultSet.UpdateNull(10);
        TargetResultSet.UpdateNull(11);
        TargetResultSet.UpdateInt(12, Ord(ntNullableUnknown));
        TargetResultSet.UpdateNull(13);
        TargetResultSet.InsertRow;
      end;
    end;
  end;
  ArgTypes.Free;
  ResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

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
function TZPostgreSQLDatabaseMetadata.GetTables(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  Types: TStringDynArray): IZResultSet;
var
  I: Integer;
  TableType, OrderBy, SQL: string;
  UseSchemas: Boolean;
  Key, Temp: string;
begin
  Temp := '';
  for I := Low(Types) to High(Types) do
    Temp := Temp + ':' + Types[I];

  Key := Format('get-tables:%s:%s:%s%s',
    [Catalog, SchemaPattern, TableNamePattern, Temp]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    if TableNamePattern = '' then
      TableNamePattern := '%';
    if SchemaPattern = '' then
      SchemaPattern := '%';
    UseSchemas := True;

    if HaveMinimumServerVersion(7, 3) then
    begin
      SQL := ' SELECT NULL AS TABLE_CAT, n.nspname AS TABLE_SCHEM, c.relname AS TABLE_NAME,  '+
        ' CASE n.nspname LIKE ''pg\\_%'' '+
        ' WHEN true THEN CASE n.nspname '+
        '   WHEN ''pg_catalog'' THEN CASE c.relkind '+
        '     WHEN ''r'' THEN ''SYSTEM TABLE'''+
        '     WHEN ''v'' THEN ''SYSTEM VIEW'' '+
        '     WHEN ''i'' THEN ''SYSTEM INDEX'' '+
        '     ELSE NULL '+
        '     END '+
        ' WHEN ''pg_toast'' THEN CASE c.relkind '+
        '		WHEN ''r'' THEN ''SYSTEM TOAST TABLE'' '+
        '		WHEN ''i'' THEN ''SYSTEM TOAST INDEX'' '+
        '		ELSE NULL '+
        '		END '+
        '	ELSE CASE c.relkind '+
        '		WHEN ''r'' THEN ''TEMPORARY TABLE'' '+
        '		WHEN ''i'' THEN ''TEMPORARY INDEX'' '+
        '		ELSE NULL '+
        '		END '+
        '	END '+
        ' WHEN false THEN CASE c.relkind '+
        '	  WHEN ''r'' THEN ''TABLE'' '+
        '	  WHEN ''i'' THEN ''INDEX'' '+
        '	  WHEN ''S'' THEN ''SEQUENCE'' '+
        '	  WHEN ''v'' THEN ''VIEW'' '+
        '	  ELSE NULL '+
        '	  END '+
        ' ELSE NULL '+
        ' END '+
        ' AS TABLE_TYPE, d.description AS REMARKS '+
        ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_class c '+
        ' LEFT JOIN pg_catalog.pg_description d ON (c.oid = d.objoid AND d.objsubid = 0) '+
        ' LEFT JOIN pg_catalog.pg_class dc ON (d.classoid=dc.oid AND dc.relname=''pg_class'') '+
        ' LEFT JOIN pg_catalog.pg_namespace dn ON (dn.oid=dc.relnamespace AND dn.nspname=''pg_catalog'') '+
        ' WHERE c.relnamespace = n.oid ';
      if SchemaPattern <> '' then
        SQL := SQL + ' AND n.nspname LIKE '''+EscapeQuotes(SchemaPattern)+''' ';
      OrderBy := ' ORDER BY TABLE_TYPE,TABLE_SCHEM,TABLE_NAME ';
    end
    else
    begin
      UseSchemas := False;
      TableType := ' CASE c.relname LIKE ''pg\\_%'' '+
            'WHEN true THEN CASE c.relname LIKE ''pg\\_toast\\_%'' '+
            'WHEN true THEN CASE c.relkind '+
            '   WHEN ''r'' THEN ''SYSTEM TOAST TABLE'' '+
            '   WHEN ''i'' THEN ''SYSTEM TOAST INDEX'' '+
            '   ELSE NULL '+
            '   END '+
            ' WHEN false THEN CASE c.relname LIKE ''pg\\_temp\\_%'' '+
            '   WHEN true THEN CASE c.relkind '+
            '     WHEN ''r'' THEN ''TEMPORARY TABLE'' '+
            '			WHEN ''i'' THEN ''TEMPORARY INDEX'' '+
            '			ELSE NULL '+
            '			END '+
            '	 	 WHEN false THEN CASE c.relkind '+
            '		 WHEN ''r'' THEN ''SYSTEM TABLE'' '+
            '			WHEN ''v'' THEN ''SYSTEM VIEW'' '+
            '			WHEN ''i'' THEN ''SYSTEM INDEX'' '+
            '		  ELSE NULL '+
            '			END '+
            '	 	ELSE NULL '+
            '	 	END '+
            '	ELSE NULL '+
            '	END '+
            ' WHEN false THEN CASE c.relkind '+
            '	WHEN ''r'' THEN ''TABLE'' '+
            '	WHEN ''i'' THEN ''INDEX'' '+
            '	WHEN ''S'' THEN ''SEQUENCE'' '+
            '	WHEN ''v'' THEN ''VIEW'' '+
            '	ELSE NULL '+
            '	END '+
            ' ELSE NULL '+
            ' END ';
      OrderBy := ' ORDER BY TABLE_TYPE,TABLE_NAME ';
      if HaveMinimumServerVersion(7, 2) then
        SQL := 'SELECT NULL AS TABLE_CAT, NULL AS TABLE_SCHEM, c.relname AS TABLE_NAME, '+
          TableType + ' AS TABLE_TYPE, d.description AS REMARKS  '+
          ' FROM pg_class c '+
          ' LEFT JOIN pg_description d ON (c.oid=d.objoid AND d.objsubid = 0) '+
          ' LEFT JOIN pg_class dc ON (d.classoid = dc.oid AND dc.relname=''pg_class'')  '+
          ' WHERE true '
       else if HaveMinimumServerVersion(7, 1) then
         SQL := 'SELECT NULL AS TABLE_CAT, NULL AS TABLE_SCHEM, c.relname AS TABLE_NAME, '+
         TableType+' AS TABLE_TYPE, d.description AS REMARKS '+
          ' FROM pg_class c '+
          ' LEFT JOIN pg_description d ON (c.oid=d.objoid) '+
          ' WHERE true '
         else
           SQL := 'SELECT NULL AS TABLE_CAT, NULL AS TABLE_SCHEM, c.relname AS TABLE_NAME, '+
             TableType+' AS TABLE_TYPE, NULL AS REMARKS '+
                                           ' FROM pg_class c '+
                                           ' WHERE true ';
    end;

    if (Types = nil) or (High(Types) = 0) then
    begin
      SetLength(Types, 5);
      Types[0] := 'TABLE';
      Types[1] := 'VIEW';
      Types[2] := 'INDEX';
      Types[3] := 'SEQUENCE';
      Types[4] := 'TEMPORARY TABLE';
    end;

    SQL := SQL + ' AND c.relname LIKE '''+EscapeQuotes(TableNamePattern)+''' '+
      'AND (false ';
    for I := 0 to High(Types) do
      SQL := SQL + ' OR ( ' +
        TableTypeSQLExpression(Types[i], UseSchemas) + ' ) ';

    SQL := SQL + ' )' + OrderBy;

    GetConnection.SetReadOnly(True);
    Result := GetConnection.CreateStatement.ExecuteQuery(SQL);
    AddResultSetToCache(Key, Result);
    Result := CloneCachedResultSet(Result);
  end;
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
function TZPostgreSQLDatabaseMetadata.GetSchemas: IZResultSet;
var
  Key: string;
begin
  Key := 'get-schemas';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    GetConnection.SetReadOnly(True);
    if HaveMinimumServerVersion(7, 3) then
      Result := GetConnection.CreateStatement.ExecuteQuery(
       'SELECT nspname AS TABLE_SCHEM FROM pg_catalog.pg_namespace WHERE '+
       'nspname <> ''pg_toast'' AND nspname NOT LIKE ''pg\\_temp\\_%'' ORDER BY TABLE_SCHEM')
    else
      Result := GetConnection.CreateStatement.ExecuteQuery(
        'SELECT ''''::text AS TABLE_SCHEM ORDER BY TABLE_SCHEM');
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
function TZPostgreSQLDatabaseMetadata.GetCatalogs: IZResultSet;
var
  Key: string;
begin
  Key := 'get-catalogs';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    GetConnection.SetReadOnly(True);
    if HaveMinimumServerVersion(7, 3) then
      Result := GetConnection.CreateStatement.ExecuteQuery(
       'SELECT datname AS TABLE_CAT FROM pg_catalog.pg_database ORDER BY TABLE_CAT')
    else
      Result := GetConnection.CreateStatement.ExecuteQuery(
        'SELECT datname AS TABLE_CAT FROM pg_database ORDER BY TABLE_CAT');
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
function TZPostgreSQLDatabaseMetadata.GetTableTypes: IZResultSet;

const Types: array [0..9] of string = ('VIEW', 'INDEX',
  'SEQUENCE', 'SYSTEM TABLE', 'SYSTEM TOAST TABLE',
  'SYSTEM TOAST INDEX', 'SYSTEM VIEW', 'SYSTEM INDEX',
  'TEMPORARY TABLE', 'TEMPORARY INDEX');

var
  I: Integer;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTableTypes as IZVirtualResultSet;
  Result := TargetResultSet;
  if Result.Next and Result.Next then
  begin
    Result.BeforeFirst;
    Exit;
  end;
  TargetResultSet.SetConcurrency(rcUpdatable);

  for I := 0 to 9 do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(1, Types[I]);
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
function TZPostgreSQLDatabaseMetadata.GetColumns(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
const
  VARHDRSZ = 4;
var
  TypeOid, AttTypMod: Integer;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  SQL, PgType: string;
begin
  TargetResultSet := inherited GetColumns(Catalog, SchemaPattern, TableNamePattern,
    ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if TableNamePattern = '' then
    TableNamePattern := '%';

  if ColumnNamePattern = '' then
    ColumnNamePattern := '%';

  if HaveMinimumServerVersion(7, 3) then
  begin
    SQL := 'SELECT n.nspname,c.relname,a.attname,a.atttypid,a.attnotnull,'+
      'a.atttypmod,a.attlen,a.attnum,def.adsrc,dsc.description '+
      ' FROM pg_catalog.pg_namespace n '+
      ' JOIN pg_catalog.pg_class c ON (c.relnamespace = n.oid) '+
      ' JOIN pg_catalog.pg_attribute a ON (a.attrelid=c.oid) '+
      ' LEFT JOIN pg_catalog.pg_attrdef def ON (a.attrelid=def.adrelid AND a.attnum = def.adnum) '+
      ' LEFT JOIN pg_catalog.pg_description dsc ON (c.oid=dsc.objoid AND a.attnum = dsc.objsubid) '+
      ' LEFT JOIN pg_catalog.pg_class dc ON (dc.oid=dsc.classoid AND dc.relname=''pg_class'') '+
      ' LEFT JOIN pg_catalog.pg_namespace dn ON (dc.relnamespace=dn.oid AND dn.nspname=''pg_catalog'') '+
      ' WHERE a.attnum > 0 AND NOT a.attisdropped ';
    if SchemaPattern <> '' then
      SQL := SQL + ' AND n.nspname LIKE ''' + EscapeQuotes(SchemaPattern) +  ''' ';
  end
  else if HaveMinimumServerVersion(7, 2) then
    SQL := 'SELECT NULL::text AS nspname,c.relname,a.attname,a.atttypid,'+
      'a.attnotnull,a.atttypmod,a.attlen,a.attnum,def.adsrc,dsc.description '+
      ' FROM pg_class c '+
      ' JOIN pg_attribute a ON (a.attrelid=c.oid) '+
      ' LEFT JOIN pg_attrdef def ON (a.attrelid=def.adrelid AND a.attnum = def.adnum) '+
      ' LEFT JOIN pg_description dsc ON (c.oid=dsc.objoid AND a.attnum = dsc.objsubid) '+
      ' LEFT JOIN pg_class dc ON (dc.oid=dsc.classoid AND dc.relname=''pg_class'') '+
      ' WHERE a.attnum > 0 '
  else if HaveMinimumServerVersion(7, 1) then
    SQL := 'SELECT NULL::text AS nspname,c.relname,a.attname,a.atttypid,'+
      'a.attnotnull,a.atttypmod,a.attlen,a.attnum,def.adsrc,dsc.description '+
      ' FROM pg_class c '+
      ' JOIN pg_attribute a ON (a.attrelid=c.oid) '+
      ' LEFT JOIN pg_attrdef def ON (a.attrelid=def.adrelid AND a.attnum = def.adnum) '+
      ' LEFT JOIN pg_description dsc ON (a.oid=dsc.objoid) '+
      ' WHERE a.attnum > 0 '
  else
    SQL := 'SELECT NULL::text AS nspname,c.relname,a.attname,a.atttypid,'+
        'a.attnotnull,a.atttypmod,a.attlen,a.attnum,NULL AS adsrc,NULL AS description '+
        ' FROM pg_class c, pg_attribute a '+
        ' WHERE a.attrelid=c.oid AND a.attnum > 0 ';

  SQL := SQL + 'AND c.relname LIKE ''' + EscapeQuotes(TableNamePattern)+
    ''' AND a.attname LIKE ''' + EscapeQuotes(ColumnNamePattern)+
    ''' ORDER BY nspname,relname,attnum ';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while ResultSet.Next do
  begin
    AttTypMod := ResultSet.GetIntByName('atttypmod');
    TypeOid := StrToInt(ResultSet.GetStringByName('atttypid'));
    PgType := GetPostgreSQLType(TypeOid);

    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateNull(1);
    TargetResultSet.UpdateString(2, ResultSet.GetStringByName('nspname'));
    TargetResultSet.UpdateString(3, ResultSet.GetStringByName('relname'));
    TargetResultSet.UpdateString(4, ResultSet.GetStringByName('attname'));
    TargetResultSet.UpdateInt(5, Ord(GetSQLTypeByOid(TypeOid)));
    TargetResultSet.UpdateString(6, PgType);
    TargetResultSet.UpdateInt(8, 0);

    if (PgType = 'bpchar') or (PgType = 'varchar') then
    begin
      if AttTypMod <> -1 then
        TargetResultSet.UpdateInt(7, AttTypMod - 4)
      else
        TargetResultSet.UpdateInt(7, 0);
    end
    else if (PgType = 'numeric') or (PgType = 'decimal') then
    begin
      AttTypMod := ResultSet.GetInt(8) - 4;
      TargetResultSet.UpdateInt(7, (AttTypMod shr 16) and $FFFF);
      TargetResultSet.UpdateInt(9, AttTypMod and $FFFF);
      TargetResultSet.UpdateInt(10, 10);
    end
    else if (PgType = 'bit') or (PgType = 'varbit') then
    begin
      TargetResultSet.UpdateInt(7, AttTypMod);
      TargetResultSet.UpdateInt(10, 2);
    end
    else
    begin
      TargetResultSet.UpdateInt(7, ResultSet.GetIntByName('attlen'));
      TargetResultSet.UpdateInt(10, 2);
    end;

    TargetResultSet.UpdateNull(8);
    if ResultSet.GetBooleanByName('attnotnull') then
    begin
      TargetResultSet.UpdateString(18, 'NO');
      TargetResultSet.UpdateInt(11, Ord(ntNoNulls));
    end
    else
    begin
      TargetResultSet.UpdateString(18, 'YES');
      TargetResultSet.UpdateInt(11, Ord(ntNullable));
    end;
    TargetResultSet.UpdateString(12, ResultSet.GetStringByName('description'));
    TargetResultSet.UpdateString(13, ResultSet.GetStringByName('adsrc'));
    TargetResultSet.UpdateNull(14);
    TargetResultSet.UpdateNull(15);
    TargetResultSet.UpdateInt(16, TargetResultSet.GetInt(7));
    TargetResultSet.UpdateInt(17, ResultSet.GetIntByName('attnum'));

    TargetResultSet.UpdateNullByName('AUTO_INCREMENT');
    TargetResultSet.UpdateBooleanByName('CASE_SENSITIVE',
      GetIdentifierConvertor.IsCaseSensitive(
      ResultSet.GetStringByName('attname')));
    TargetResultSet.UpdateBooleanByName('SEARCHABLE', True);
    TargetResultSet.UpdateBooleanByName('WRITABLE', True);
    TargetResultSet.UpdateBooleanByName('DEFINITELYWRITABLE', True);
    TargetResultSet.UpdateBooleanByName('READONLY', False);

    TargetResultSet.InsertRow;
  end;
  ResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

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
function TZPostgreSQLDatabaseMetadata.GetColumnPrivileges(Catalog: string;
  Schema: string; Table: string; ColumnNamePattern: string): IZResultSet;
var
  I, J: Integer;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  SQL, SchemaName, TableName, Column, Owner: string;
  Privileges, Grantable, Grantee: string;
  Permissions, PermissionsExp: TStrings;
begin
  TargetResultSet := inherited GetColumnPrivileges(Catalog, Schema, Table,
    ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Table = '' then
    Table := '%';

  if ColumnNamePattern = '' then
    ColumnNamePattern := '%';

  Permissions := TStringList.Create;
  PermissionsExp := TStringList.Create;

  if HaveMinimumServerVersion(7, 3) then
  begin
    SQL := 'SELECT n.nspname,c.relname,u.usename,c.relacl,a.attname '+
      ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_class c, pg_catalog.pg_user u, pg_catalog.pg_attribute a '+
			' WHERE c.relnamespace = n.oid '+
			' AND u.usesysid = c.relowner '+
			' AND c.oid = a.attrelid '+
			' AND c.relkind = ''r'' '+
			' AND a.attnum > 0 AND NOT a.attisdropped ';
    if Schema <> '' then
      SQL := SQL + 'AND n.nspname = '''+EscapeQuotes(Schema)+''' ';
  end
  else
    SQL := 'SELECT NULL::text AS nspname,c.relname,u.usename,c.relacl,a.attname '+
  		'FROM pg_class c, pg_user u,pg_attribute a '+
			' WHERE u.usesysid = c.relowner '+
			' AND c.oid = a.attrelid '+
			' AND a.attnum > 0 '+
			' AND c.relkind = ''r'' ';

  SQL := SQL + ' AND c.relname = ''' + EscapeQuotes(Table)+
    ''' AND a.attname LIKE ''' + EscapeQuotes(ColumnNamePattern) +
    ''' ORDER BY attname ';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  try
    while ResultSet.Next do
    begin
      SchemaName := ResultSet.GetStringByName('nspname');
      TableName := ResultSet.GetStringByName('relname');
      Column := ResultSet.GetStringByName('attname');
      Owner := ResultSet.GetStringByName('usename');
      SchemaName := ResultSet.GetStringByName('nspname');
      Permissions.Clear;
      ParseACLArray(Permissions, ResultSet.GetStringByName('relacl'));
      for I := 0 to Permissions.Count-1 do
      begin
        PutSplitString(PermissionsExp, Permissions.Strings[I], '=');
        if PermissionsExp.Count < 2 then
          Continue;
        Grantee := PermissionsExp.Strings[0];
        if Grantee = '' then
          Grantee := 'PUBLIC';
        Privileges := PermissionsExp.Strings[1];
        for J := 1 to Length(Privileges) do
        begin
          if Owner = Grantee then
            Grantable := 'YES'
          else
            Grantable := 'NO';
          TargetResultSet.MoveToInsertRow;
          TargetResultSet.UpdateNull(1);
          TargetResultSet.UpdateString(2, Schema);
          TargetResultSet.UpdateString(3, Table);
          TargetResultSet.UpdateString(4, Column);
          TargetResultSet.UpdateString(5, Owner);
          TargetResultSet.UpdateString(6, Grantee);
          TargetResultSet.UpdateString(7, GetPrivilegeName(Privileges[J]));
          TargetResultSet.UpdateString(8, grantable);
          TargetResultSet.InsertRow;
        end;
      end;
    end;
  finally
    Permissions.Free;
    PermissionsExp.Free;
  end;
  ResultSet.Close;

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
function TZPostgreSQLDatabaseMetadata.GetTablePrivileges(Catalog: string;
  SchemaPattern: string; TableNamePattern: string): IZResultSet;
var
  I, J: Integer;
  ResultSet: IZResultSet;
  SQL, SchemaName, TableName, Owner: string;
  Privileges, Grantable, Grantee: string;
  Permissions, PermissionsExp: TStringList;
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTablePrivileges(Catalog, SchemaPattern,
    TableNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if TableNamePattern = '' then
    TableNamePattern := '%';

  if HaveMinimumServerVersion(7, 3) then
  begin
    SQL := 'SELECT n.nspname,c.relname,u.usename,c.relacl '+
      ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_class c, pg_catalog.pg_user u '+
			' WHERE c.relnamespace = n.oid '+
			' AND u.usesysid = c.relowner '+
			' AND c.relkind = ''r'' ';
    if SchemaPattern <> '' then
      SQL := SQL + 'AND n.nspname LIKE '''+EscapeQuotes(SchemaPattern)+''' ';
  end
  else
    SQL := 'SELECT NULL::text AS nspname,c.relname,u.usename,c.relacl '+
  		' FROM pg_class c, pg_user u '+
			' WHERE u.usesysid = c.relowner '+
			' AND c.relkind = ''r'' ';

  SQL := SQL + ' AND c.relname LIKE ''' + EscapeQuotes(TableNamePattern)+
    ''' ORDER BY nspname, relname ';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  Permissions := TStringList.Create;
  PermissionsExp := TStringList.Create;

  try
    while ResultSet.Next do
    begin
      SchemaName := ResultSet.GetStringByName('nspname');
      TableName := ResultSet.GetStringByName('relname');
      Owner := ResultSet.GetStringByName('usename');
      SchemaName := ResultSet.GetStringByName('nspname');
      Permissions.Clear;
      ParseACLArray(Permissions, ResultSet.GetStringByName('relacl'));
      Permissions.Sort;
      for I := 0 to Permissions.Count-1 do
      begin
        PutSplitString(PermissionsExp, Permissions.Strings[I], '=');
        if PermissionsExp.Count < 2 then
          Continue;
        Grantee := PermissionsExp.Strings[0];
        if Grantee = '' then
        Grantee := 'PUBLIC';
        Privileges := PermissionsExp.Strings[1];
        for J := 1 to Length(Privileges) do
        begin
          if Owner = Grantee then
            Grantable := 'YES'
          else
            Grantable := 'NO';
          TargetResultSet.MoveToInsertRow;
          TargetResultSet.UpdateNull(1);
          TargetResultSet.UpdateString(2, SchemaName);
          TargetResultSet.UpdateString(3, TableName);
          TargetResultSet.UpdateString(4, Owner);
          TargetResultSet.UpdateString(5, Grantee);
          TargetResultSet.UpdateString(6, GetPrivilegeName(Privileges[J]));
          TargetResultSet.UpdateString(7, grantable);
          TargetResultSet.InsertRow;
        end;
      end;
    end;
  finally
    Permissions.Free;
    PermissionsExp.Free;
  end;
  ResultSet.Close;

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
function TZPostgreSQLDatabaseMetadata.GetBestRowIdentifier(Catalog: string;
  Schema: string; Table: string; Scope: Integer; Nullable: Boolean): IZResultSet;
var
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  ColumnTypeOid: Integer;
  SQL, From, Where: string;
begin
  TargetResultSet := inherited GetBestRowIdentifier(Catalog, Schema, Table, Scope,
    Nullable) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if HaveMinimumServerVersion(7, 3) then
  begin
    From := ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_class ct, pg_catalog.pg_class ci,'+
      ' pg_catalog.pg_attribute a, pg_catalog.pg_index i ';
    Where := ' AND ct.relnamespace = n.oid ';
    if Schema <> '' then
      Where := Where + ' AND n.nspname = '''+EscapeQuotes(Schema)+''' ';
  end
  else
    From := ' FROM pg_class ct, pg_class ci, pg_attribute a, pg_index i ';

  SQL := 'SELECT a.attname, a.atttypid  ' + From +
    ' WHERE ct.oid=i.indrelid AND ci.oid=i.indexrelid '+
  	' AND a.attrelid=ci.oid AND i.indisprimary '+
		' AND ct.relname = '''+EscapeQuotes(Table)+''' '+
			where + ' ORDER BY a.attnum ';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while ResultSet.Next do
  begin
    ColumnTypeOid := StrToInt(ResultSet.GetStringByName('atttypid'));
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateInt(1, Scope);
    TargetResultSet.UpdateString(2, ResultSet.GetStringByName('attname'));
    TargetResultSet.UpdateInt(3, Ord(GetSQLTypeByOid(ColumnTypeOid)));
    TargetResultSet.UpdateString(4, GetPostgreSQLType(ColumnTypeOid));
    TargetResultSet.UpdateNull(5);
    TargetResultSet.UpdateNull(6);
    TargetResultSet.UpdateNull(7);
    TargetResultSet.UpdateInt(8, Ord(brNotPseudo));
    TargetResultSet.InsertRow;
  end;
  ResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

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
function TZPostgreSQLDatabaseMetadata.GetVersionColumns(Catalog: string;
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
  TargetResultSet.UpdateInt(3, Ord(GetSQLTypeByName('tid')));
  TargetResultSet.UpdateString(4, 'tid');
  TargetResultSet.UpdateNull(5);
  TargetResultSet.UpdateNull(6);
  TargetResultSet.UpdateNull(7);
  TargetResultSet.UpdateInt(4, Ord(vcPseudo));
  TargetResultSet.InsertRow;

  Result := CloneCachedResultSet(Result);
end;

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
function TZPostgreSQLDatabaseMetadata.GetPrimaryKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  SQL, Select, From, Where: string;
  Key: string;
begin
  Key := Format('get-primary-keys:%s:%s:%s',
    [Catalog, Schema, Table]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    if HaveMinimumServerVersion(7, 3) then
    begin
      Select := 'SELECT NULL AS TABLE_CAT, n.nspname AS TABLE_SCHEM, ';
      From := ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_class ct, pg_catalog.pg_class ci, pg_catalog.pg_attribute a, pg_catalog.pg_index i ';
      Where := ' AND ct.relnamespace = n.oid ';
      if Schema <> '' then
        Where := Where + ' AND n.nspname = '''+EscapeQuotes(Schema)+''' ';
    end
    else
    begin
                  Select := 'SELECT NULL AS TABLE_CAT, NULL AS TABLE_SCHEM, ';
                  From := ' FROM pg_class ct, pg_class ci, pg_attribute a, pg_index i ';
          end;
          SQL := Select + ' ct.relname AS TABLE_NAME, '+
                  ' a.attname AS COLUMN_NAME, '+
                  ' a.attnum AS KEY_SEQ, '+
                  ' ci.relname AS PK_NAME '+
                  From +
                  ' WHERE ct.oid=i.indrelid AND ci.oid=i.indexrelid '+
                  ' AND a.attrelid=ci.oid AND i.indisprimary ';
    if Table <> '' then
       SQL := SQL + ' AND ct.relname = ''' + EscapeQuotes(Table) + ''' ';
    SQL := SQL + where +	' ORDER BY table_name, pk_name, key_seq ';
    GetConnection.SetReadOnly(True);
    Result := GetConnection.CreateStatement.ExecuteQuery(SQL);
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
function TZPostgreSQLDatabaseMetadata.GetImportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
begin
  Result := GetImportedExportedKeys('', '', '', Catalog, Schema, Table);
end;

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
function TZPostgreSQLDatabaseMetadata.GetExportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
begin
  Result := GetImportedExportedKeys(Catalog, Schema, Table, '', '', '');
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
function TZPostgreSQLDatabaseMetadata.GetCrossReference(PrimaryCatalog: string;
  PrimarySchema: string; PrimaryTable: string; ForeignCatalog: string;
  ForeignSchema: string; ForeignTable: string): IZResultSet;
begin
  Result := GetImportedExportedKeys(PrimaryCatalog, PrimarySchema,
    PrimaryTable, ForeignCatalog, ForeignSchema, ForeignTable);
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
 	<LI><B>CASE_SENSITIVE</B> Boolean=> is it case sensitive?
 	<LI><B>SEARCHABLE</B> short => can you use "WHERE" based on this type:
       <UL>
       <LI> typePredNone - No support
       <LI> typePredChar - Only supported with WHERE .. LIKE
       <LI> typePredBasic - Supported except for WHERE .. LIKE
       <LI> typeSearchable - Supported for all WHERE ..
       </UL>
 	<LI><B>UNSIGNED_ATTRIBUTE</B> Boolean => is it unsigned?
 	<LI><B>FIXED_PREC_SCALE</B> Boolean => can it be a money value?
 	<LI><B>AUTO_INCREMENT</B> Boolean => can it be used for an
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
function TZPostgreSQLDatabaseMetadata.GetTypeInfo: IZResultSet;
var
  SQL: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
begin
  TargetResultSet := inherited GetTypeInfo as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if HaveMinimumServerVersion(7, 3) then
    SQL := ' SELECT typname FROM pg_catalog.pg_type '
  else
    SQL := ' SELECT typname FROM pg_type ';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  while ResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(1, ResultSet.GetString(1));
    TargetResultSet.UpdateInt(2, Ord(GetSQLTypeByName(ResultSet.GetString(1))));
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
  Gets a description of a table's indices and statistics. They are
  ordered by NON_UNIQUE, TYPE, INDEX_NAME, and ORDINAL_POSITION.

  <P>Each index column description has the following columns:
   <OL>
 	<LI><B>TABLE_CAT</B> String => table catalog (may be null)
 	<LI><B>TABLE_SCHEM</B> String => table schema (may be null)
 	<LI><B>TABLE_NAME</B> String => table name
 	<LI><B>NON_UNIQUE</B> Boolean => Can index values be non-unique?
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
function TZPostgreSQLDatabaseMetadata.GetIndexInfo(Catalog: string;
  Schema: string; Table: string; Unique: Boolean;
  Approximate: Boolean): IZResultSet;
var
  ReadOnly: Boolean;
  SQL, Select, From, Where: string;
  Key: string;
begin
  Key := Format('get-index-info:%s:%s:%s:%s:%s',
    [Catalog, Schema, Table, BoolToStr(Unique), BoolToStr(Approximate)]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    if HaveMinimumServerVersion(7, 3) then
    begin
      Select := 'SELECT NULL AS TABLE_CAT, n.nspname AS TABLE_SCHEM, ';
      From := ' FROM pg_catalog.pg_namespace n, pg_catalog.pg_class ct, pg_catalog.pg_class ci, pg_catalog.pg_index i, pg_catalog.pg_attribute a, pg_catalog.pg_am am ';
      Where := ' AND n.oid = ct.relnamespace ';
      if Schema <> '' then
        Where := Where + ' AND n.nspname = ''' + EscapeQuotes(Schema) + ''' ';
    end
    else
    begin
      Select := 'SELECT NULL AS TABLE_CAT, NULL AS TABLE_SCHEM, ';
      From := ' FROM pg_class ct, pg_class ci, pg_index i, pg_attribute a, pg_am am ';
    end;

    SQL := select +
      ' ct.relname AS TABLE_NAME, NOT i.indisunique AS NON_UNIQUE, NULL AS INDEX_QUALIFIER, ci.relname AS INDEX_NAME, '+
      ' CASE i.indisclustered '+
      ' WHEN true THEN ' + IntToStr(ord(tiClustered))+
      ' ELSE CASE am.amname '+
      '	WHEN ''hash'' THEN ' + IntToStr(ord(tiHashed))+
      '	ELSE ' + IntToStr(ord(tiOther))+
      '	END '+
      ' END AS TYPE, '+
      ' a.attnum AS ORDINAL_POSITION, '+
      ' a.attname AS COLUMN_NAME, '+
      ' NULL AS ASC_OR_DESC, '+
      ' ci.reltuples AS CARDINALITY, '+
      ' ci.relpages AS PAGES, '+
      ' NULL AS FILTER_CONDITION '+
      From+
      ' WHERE ct.oid=i.indrelid AND ci.oid=i.indexrelid AND a.attrelid=ci.oid AND ci.relam=am.oid '+
      Where+
      ' AND ct.relname = ''' + EscapeQuotes(Table) + ''' ';

    if Unique then
      SQL := SQL + ' AND i.indisunique ';
    SQL := SQL + ' ORDER BY NON_UNIQUE, TYPE, INDEX_NAME ';
    ReadOnly := GetConnection.IsReadOnly;
    try
      GetConnection.SetReadOnly(True);
      Result := GetConnection.CreateStatement().ExecuteQuery(sql);
    finally
      GetConnection.SetReadOnly(ReadOnly);
    end;
    AddResultSetToCache(Key, Result);
    Result := CloneCachedResultSet(Result);
  end;
end;

{**
  Does the database support the given result set type?
  @param type defined in <code>java.sql.ResultSet</code>
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZPostgreSQLDatabaseMetadata.SupportsResultSetType(
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
function TZPostgreSQLDatabaseMetadata.SupportsResultSetConcurrency(
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
function TZPostgreSQLDatabaseMetadata.GetUDTs(Catalog: string;
  SchemaPattern: string; TypeNamePattern: string;
  Types: TIntegerDynArray): IZResultSet;
begin
  raise EZSQLException.Create(SUnsupportedOperation);
end;

function TZPostgreSQLDatabaseMetadata.GetColumnInfo(Table, Name: string;
  SQLType: TZSQLType; Length: Integer): TZColumnInfo;
begin
  Result := TZColumnInfo.Create;
  with Result do
  begin
    TableName := Table;
    ColumnName := Name;
    ColumnType := SQLType;
    ColumnDisplaySize := Length;
  end;
end;

function TZPostgreSQLDatabaseMetadata.GetVirtualResultSet(
  ColumnsInfo: TObjectList): TZVirtualResultSet;
begin
  Result := TZVirtualResultSet.CreateWithColumns(ColumnsInfo, '');
  with Result do
  begin
    SetType(rtScrollInsensitive);
    SetConcurrency(rcUpdatable);
  end;
end;

function TZPostgreSQLDatabaseMetadata.HaveMinimumServerVersion(
  MajorVersion: Integer; MinorVersion: Integer): Boolean;
var
  PostgreSQLConnection: IZPostgreSQLConnection;
begin
  PostgreSQLConnection := GetConnection as IZPostgreSQLConnection;
  Result := (MajorVersion < PostgreSQLConnection.GetServerMajorVersion)
    or ((MajorVersion = PostgreSQLConnection.GetServerMajorVersion)
    and (MinorVersion <= PostgreSQLConnection.GetServerMinorVersion));
end;

function TZPostgreSQLDatabaseMetadata.GetMaxIndexKeys: Integer;
var
  SQL, From: string;
  ResultSet: IZResultSet;
begin
  if HaveMinimumServerVersion(7, 3) then
    From := ' pg_catalog.pg_namespace n, pg_catalog.pg_type t1, pg_catalog.pg_type t2 WHERE t1.typnamespace=n.oid AND n.nspname=''pg_catalog'' AND '
  else
    From := ' pg_type t1, pg_type t2 WHERE ';
  SQL := ' SELECT t1.typlen/t2.typlen FROM '+From+' t1.typelem=t2.oid AND t1.typname=''oidvector'' ';
  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);
  if not ResultSet.Next then
    raise Exception.Create(SUnknownError); //CHANGE IT!
  Result := ResultSet.GetInt(1);
  ResultSet.Close;
end;

function TZPostgreSQLDatabaseMetadata.GetMaxNameLength: Integer;
var
  SQL: string;
  ResultSet: IZResultSet;
begin
  if HaveMinimumServerVersion(7, 3) then
  begin
    SQL := ' SELECT t.typlen FROM pg_catalog.pg_type t, pg_catalog.pg_namespace n'+
      ' WHERE t.typnamespace=n.oid AND t.typname=''name'' AND n.nspname=''pg_catalog'' ';
  end
  else
    SQL := ' SELECT typlen FROM pg_type WHERE typname=''name'' ';
  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);
  if not ResultSet.Next then
    raise Exception.Create(SUnknownError); //CHANGE IT!
  Result := ResultSet.GetIntByName('typlen');
  ResultSet.Close;
end;

function TZPostgreSQLDatabaseMetadata.GetPostgreSQLType(Oid: Integer): string;
begin
  Result := (GetConnection as IZPostgreSQLConnection).GetTypeNameByOid(Oid);
end;

function TZPostgreSQLDatabaseMetadata.GetSQLTypeByOid(Oid: Integer): TZSQLType;
var
  PostgreSQLConnection: IZPostgreSQLConnection;
begin
  PostgreSQLConnection := GetConnection as IZPostgreSQLConnection;
  Result := PostgreSQLToSQLType(PostgreSQLConnection,
    PostgreSQLConnection.GetTypeNameByOid(Oid));
end;

function TZPostgreSQLDatabaseMetadata.GetSQLTypeByName(TypeName: string): TZSQLType;
begin
  Result := PostgreSQLToSQLType(GetConnection as IZPostgreSQLConnection,
    TypeName);
end;

function TZPostgreSQLDatabaseMetadata.TableTypeSQLExpression(TableType: string;
  UseSchemas: Boolean): string;
begin
  if UseSchemas then
  begin
    if TableType = 'TABLE' then
      Result := ' c.relkind = ''r'' AND n.nspname NOT LIKE ''pg\\_%'' '
    else if TableType = 'VIEW' then
      Result := ' c.relkind = ''v'' AND n.nspname <> ''pg_catalog'' '
    else if TableType = 'INDEX' then
      Result := ' c.relkind = ''i'' AND n.nspname NOT LIKE ''pg\\_%'' '
    else if TableType = 'SEQUENCE' then
      Result := ' c.relkind = ''S'' '
    else if TableType = 'SYSTEM TABLE' then
      Result := ' c.relkind = ''r'' AND n.nspname = ''pg_catalog'' '
    else if TableType = 'SYSTEM TOAST TABLE' then
      Result := ' c.relkind = ''r'' AND n.nspname = ''pg_toast'' '
    else if TableType = 'SYSTEM TOAST INDEX' then
      Result := ' c.relkind = ''i'' AND n.nspname = ''pg_toast'' '
    else if TableType = 'SYSTEM VIEW' then
      Result := ' c.relkind = ''v'' AND n.nspname = ''pg_catalog'' '
    else if TableType = 'SYSTEM INDEX' then
      Result := ' c.relkind = ''i'' AND n.nspname = ''pg_catalog'' '
    else if TableType = 'TEMPORARY TABLE' then
      Result := ' c.relkind = ''r'' AND n.nspname LIKE ''pg\\_temp\\_%'' '
    else if TableType = 'TEMPORARY INDEX' then
      Result := 'c.relkind = ''i'' AND n.nspname LIKE ''pg\\_temp\\_%'' ';
  end
  else
  begin
    if TableType = 'TABLE' then
      Result := ' c.relkind = ''r'' AND c.relname NOT LIKE ''pg\\_%'' '
    else if TableType = 'VIEW' then
      Result := ' c.relkind = ''v'' AND c.relname NOT LIKE ''pg\\_%'' '
    else if TableType = 'INDEX' then
      Result := ' c.relkind = ''i'' AND c.relname NOT LIKE ''pg\\_%'' '
    else if TableType = 'SEQUENCE' then
      Result := ' c.relkind = ''S'' '
    else if TableType = 'SYSTEM TABLE' then
      Result := ' c.relkind = ''r'' AND c.relname LIKE ''pg\\_%'' AND c.relname '+
        'NOT LIKE ''pg\\_toast\\_%'' AND c.relname NOT LIKE ''pg\\_temp\\_%'' '
    else if TableType = 'SYSTEM TOAST TABLE' then
      Result := ' c.relkind = ''r'' AND c.relname LIKE ''pg\\_toast\\_%'' '
    else if TableType = 'SYSTEM TOAST INDEX' then
      Result := ' c.relkind = ''i'' AND c.relname LIKE ''pg\\_toast\\_%'' '
    else if TableType = 'SYSTEM VIEW' then
      Result := 'c.relkind = ''v'' AND c.relname LIKE ''pg\\_%'''
    else if TableType = 'SYSTEM INDEX' then
      Result := ' c.relkind = ''v'' AND c.relname LIKE ''pg\\_%'' AND '+
        'c.relname NOT LIKE ''pg\\_toast\\_%'' AND c.relname '+
        'NOT LIKE ''pg\\_temp\\_%'' '
    else if TableType = 'TEMPORARY TABLE' then
      Result := ' c.relkind = ''r'' AND c.relname LIKE ''pg\\_temp\\_%'' '
    else if TableType = 'TEMPORARY INDEX' then
      Result := ' c.relkind = ''i'' AND c.relname LIKE ''pg\\_temp\\_%'' '
  end;
end;

procedure TZPostgreSQLDatabaseMetadata.ParseACLArray(List: TStrings;
  AclString: string);
var
  PrevChar: char;
  InQuotes: Boolean;
  I, BeginIndex: Integer;
begin
  if AclString = '' then
    exit;
  InQuotes := False;
  PrevChar := ' ';
  BeginIndex := 2;
  for I := BeginIndex to Length(AclString) do
  begin
    if (AclString[I] = '"') and (PrevChar <> '\' ) then
      InQuotes := not InQuotes
    else if (AclString[I] = ',') and not InQuotes then
    begin
      List.Add(Copy(AclString, BeginIndex, I - BeginIndex));
      BeginIndex := I+1;
    end;
    prevChar := AclString[I];
  end;

  // add last element removing the trailing "}"
  List.Add(Copy(AclString, BeginIndex, Length(AclString) - BeginIndex));

  // Strip out enclosing quotes, if any.
  for I := 0 to List.Count-1 do
  begin
    if (List.Strings[i][1] = '"') and
       (List.Strings[i][Length(List.Strings[i])] = '"') then
      List.Strings[i] := Copy(List.Strings[i], 2, Length(List.Strings[i])-2);
  end;
end;

function TZPostgreSQLDatabaseMetadata.GetPrivilegeName(
  Permission: char): string;
begin
 case Permission of
   'a': Result := 'INSERT';
   'r': Result := 'SELECT';
   'w': Result := 'UPDATE';
   'd': Result := 'DELETE';
   'R': Result := 'RULE';
   'x': Result := 'REFERENCES';
   't': Result := 'TRIGGER';
   'X': Result := 'EXECUTE';
   'U': Result := 'USAGE';
   'C': Result := 'CREATE';
   'T': Result := 'CREATE TEMP';
 else
   Result := 'UNKNOWN';
 end;
end;

function TZPostgreSQLDatabaseMetadata.GetImportedExportedKeys(
  PrimaryCatalog, PrimarySchema, PrimaryTable, ForeignCatalog,
  ForeignSchema, ForeignTable: string): IZResultSet;
var
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  SQL, Select, From, Where: string;
  DeleteRule, UpdateRule, Rule: string;
  FKeyName, FKeyColumn, PKeyColumn, Targs: string;
  Action, KeySequence, Advance: Integer;
  List: TStrings;
  Deferrability: Integer;
  Deferrable, InitiallyDeferred: Boolean;
begin
  TargetResultSet := inherited GetCrossReference(PrimaryCatalog, PrimarySchema,
    PrimaryTable, ForeignCatalog, ForeignSchema, ForeignTable) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if HaveMinimumServerVersion(7, 3) then
  begin
    Select := 'SELECT DISTINCT n1.nspname as pnspname,n2.nspname as fnspname, ';
    From := ' FROM pg_catalog.pg_namespace n1 '+
      ' JOIN pg_catalog.pg_class c1 ON (c1.relnamespace = n1.oid) '+
      ' JOIN pg_catalog.pg_index i ON (c1.oid=i.indrelid) ' +
      ' JOIN pg_catalog.pg_class ic ON (i.indexrelid=ic.oid) ' +
      ' JOIN pg_catalog.pg_attribute a ON (ic.oid=a.attrelid), ' +
      ' pg_catalog.pg_namespace n2 ' +
      ' JOIN pg_catalog.pg_class c2 ON (c2.relnamespace=n2.oid), ' +
      ' pg_catalog.pg_trigger t1 ' +
      ' JOIN pg_catalog.pg_proc p1 ON (t1.tgfoid=p1.oid), ' +
      ' pg_catalog.pg_trigger t2 ' +
      ' JOIN pg_catalog.pg_proc p2 ON (t2.tgfoid=p2.oid) ';
    if PrimarySchema <> ''then
      Where := Where + ' AND n1.nspname = ''' + EscapeQuotes(PrimarySchema) + ''' ';
    if ForeignSchema <> '' then
      Where := Where + ' AND n2.nspname = ''' + EscapeQuotes(ForeignSchema) + ''' ';
  end
  else
  begin
    Select := 'SELECT DISTINCT NULL::text as pnspname, NULL::text as fnspname, ';
    From := ' FROM pg_class c1 ' +
      ' JOIN pg_index i ON (c1.oid=i.indrelid) ' +
      ' JOIN pg_class ic ON (i.indexrelid=ic.oid) ' +
      ' JOIN pg_attribute a ON (ic.oid=a.attrelid), ' +
      ' pg_class c2, ' +
      ' pg_trigger t1 ' +
      ' JOIN pg_proc p1 ON (t1.tgfoid=p1.oid), ' +
      ' pg_trigger t2 ' +
      ' JOIN pg_proc p2 ON (t2.tgfoid=p2.oid) ';
  end;

  SQL := Select + 'c1.relname as prelname, ' +
    'c2.relname as frelname, ' +
    't1.tgconstrname, ' +
    'a.attnum as keyseq, ' +
    'ic.relname as fkeyname, ' +
    't1.tgdeferrable, ' +
    't1.tginitdeferred, ' +
    't1.tgnargs,t1.tgargs, ' +
    'p1.proname as updaterule, ' +
    'p2.proname as deleterule ' +
    From +
    'WHERE ' +
    // isolate the update rule
    '(t1.tgrelid=c1.oid ' +
    'AND t1.tgisconstraint ' +
    'AND t1.tgconstrrelid=c2.oid ' +
    'AND p1.proname LIKE ''RI\\_FKey\\_%\\_upd'') ' +

    'AND ' +
    // isolate the delete rule
    '(t2.tgrelid=c1.oid ' +
    'AND t2.tgisconstraint ' +
    'AND t2.tgconstrrelid=c2.oid ' +
    'AND p2.proname LIKE ''RI\\_FKey\\_%\\_del'') ' +

    'AND i.indisprimary ' +
    Where;

  if PrimaryTable <> '' then
    SQL := SQL + 'AND c1.relname=''' + EscapeQuotes(PrimaryTable) + ''' ';
  if ForeignTable <> '' then
    SQL := SQL + 'AND c2.relname=''' + escapeQuotes(ForeignTable) + ''' ';

  SQL := SQL + 'ORDER BY ';

  if PrimaryTable <> '' then
  begin
    if HaveMinimumServerVersion(7, 3) then
      SQL := SQL + 'fnspname, ';
    SQL := SQL + 'frelname';
  end else begin
    if HaveMinimumServerVersion(7, 3) then
      SQL := SQL + 'pnspname, ';
    SQL := SQL + 'prelname';
  end;

  SQL := SQL + ', keyseq';

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(SQL);

  List := TStringList.Create;

  while ResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(2, ResultSet.GetString(1));
    TargetResultSet.UpdateString(6, ResultSet.GetString(2));
    TargetResultSet.UpdateString(3, ResultSet.GetString(3));
    TargetResultSet.UpdateString(7, ResultSet.GetString(4));

    FKeyName := ResultSet.GetString(5);
    UpdateRule := ResultSet.GetString(12);
    if updateRule <> '' then
    begin
      Rule := Copy(UpdateRule, 9, Length(UpdateRule) - 12);
      Action := ord(ikNoAction);
      if (Rule = '') or (Rule = 'noaction') then
       Action := ord(ikNoAction);
      if Rule = 'cascade' then
        Action := ord(ikCascade);
      if Rule = 'setnull' then
        Action := ord(ikSetNull);
      if Rule = 'setdefault' then
        Action := ord(ikSetDefault);
      if Rule = 'restrict' then
       Action := ord(ikRestrict);
      TargetResultSet.UpdateInt(10, Action);
    end;

    DeleteRule := ResultSet.GetString(13);
    if DeleteRule <> '' then
    begin
      Rule := Copy(DeleteRule, 9, Length(DeleteRule) - 12);
      Action := ord(ikNoAction);
      if Rule = 'cascade' then
        Action := ord(ikCascade);
      if Rule = 'setnull' then
        Action := ord(ikSetNull);
      if Rule = 'setdefault' then
        Action := ord(ikSetDefault);
      if Rule = 'restrict' then
        Action := ord(ikRestrict);
      TargetResultSet.UpdateInt(11, Action);
    end;

    KeySequence := ResultSet.GetInt(6);
    Targs := ResultSet.GetString(11);

    //<unnamed>\000ww\000vv\000UNSPECIFIED\000m\000a\000n\000b\000
    //for Posthresql 7.3
    //$1\000ww\000vv\000UNSPECIFIED\000m\000a\000n\000b\000
    //$2\000ww\000vv\000UNSPECIFIED\000m\000a\000n\000b\000

    Advance := 4 + (KeySequence - 1) * 2;
    PutSplitStringEx(List, Targs, '\000');

    //PutSplitString(List, Targs, #0);
    if Advance <= List.Count-1 then
      FKeyColumn := List.Strings[Advance];
    if Advance + 1 <= List.Count-1 then
      PKeyColumn := List.Strings[Advance+1];
    TargetResultSet.UpdateString(4, PKeyColumn);
    TargetResultSet.UpdateString(8, FKeyColumn);
    TargetResultSet.UpdateString(9, ResultSet.GetString(6)); //KEY_SEQ

    if List.Strings[0] = '<unnamed>' then
      TargetResultSet.UpdateString(12, Targs) //FK_NAME
    else
      TargetResultSet.UpdateString(12, List.Strings[0]); //FK_NAME

    TargetResultSet.UpdateString(13, ResultSet.GetString(6)); //PK_ NAME

    Deferrability := ord(ikNotDeferrable);
    Deferrable := ResultSet.GetBoolean(8);
    InitiallyDeferred := ResultSet.GetBoolean(9);
    if Deferrable then
    begin
      if InitiallyDeferred then
        Deferrability := Ord(ikInitiallyDeferred)
      else
        Deferrability := Ord(ikInitiallyImmediate);
    end;
    TargetResultSet.UpdateInt(14, Deferrability);
    TargetResultSet.InsertRow;
  end;
  List.Free;
  ResultSet.Close;

  Result := CloneCachedResultSet(Result);
end;

{**
  Gets a SQL syntax tokenizer.
  @returns a SQL syntax tokenizer object.
}
function TZPostgreSQLDatabaseMetadata.GetTokenizer: IZTokenizer;
begin
  if Tokenizer = nil then
    Tokenizer := TZPostgreSQLTokenizer.Create;
  Result := Tokenizer;
end;

{**
  Creates a statement analyser object.
  @returns a statement analyser object.
}
function TZPostgreSQLDatabaseMetadata.GetStatementAnalyser: IZStatementAnalyser;
begin
  if Analyser = nil then
    Analyser := TZPostgreSQLStatementAnalyser.Create;
  Result := Analyser;
end;

end.
