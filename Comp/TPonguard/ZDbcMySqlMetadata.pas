{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{           MySQL Database Connectivity Classes           }
{                                                         }
{    Copyright (c) 1999-2004 Zeos Development Group       }
{    Written by Sergey Seroukhov and Sergey Merkuriev     }
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

unit ZDbcMySqlMetadata;

interface

{$I ZDbc.inc}

uses
  Classes, SysUtils, ZClasses, ZSysUtils, ZDbcIntfs, ZDbcMetadata,
  ZDbcResultSet, ZDbcCachedResultSet, ZDbcResultSetMetadata,
  ZCompatibility, ZTokenizer, ZGenericSqlAnalyser, ZDbcConnection;

type

  {** Implements MySQL Database Metadata. }
  TZMySQLDatabaseMetadata = class(TZAbstractDatabaseMetadata)
  private
    FDatabase: string;
  protected
    procedure GetVersion(var MajorVersion, MinorVersion: integer);
  public
    constructor Create(Connection: TZAbstractConnection; Url: string; Info: TStrings);
    destructor Destroy; override;

    function GetDatabaseProductName: string; override;
    function GetDatabaseProductVersion: string; override;
    function GetDriverName: string; override;
    function GetDriverMajorVersion: Integer; override;
    function GetDriverMinorVersion: Integer; override;
    function UsesLocalFilePerTable: Boolean; override;
    function StoresMixedCaseIdentifiers: Boolean; override;
    function GetIdentifierQuoteString: string; override;
    function GetSQLKeywords: string; override;
    function GetNumericFunctions: string; override;
    function GetStringFunctions: string; override;
    function GetSystemFunctions: string; override;
    function GetTimeDateFunctions: string; override;
    function GetSearchStringEscape: string; override;
    function GetExtraNameCharacters: string; override;

    function SupportsOrderByUnrelated: Boolean; override;
    function SupportsGroupByUnrelated: Boolean; override;
    function SupportsGroupByBeyondSelect: Boolean; override;
    function SupportsIntegrityEnhancementFacility: Boolean; override;
    function GetSchemaTerm: string; override;
    function GetProcedureTerm: string; override;
    function GetCatalogTerm: string; override;
    function SupportsCatalogsInDataManipulation: Boolean; override;
    function SupportsCatalogsInTableDefinitions: Boolean; override;
    function SupportsSubqueriesInComparisons: Boolean; override;
    function SupportsUnionAll: Boolean;  override;
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
    function GetMaxCatalogNameLength: Integer; override;
    function GetMaxRowSize: Integer; override;
    function DoesMaxRowSizeIncludeBlobs: Boolean; override;
    function GetMaxStatementLength: Integer; override;
    function GetMaxStatements: Integer; override;
    function GetMaxTableNameLength: Integer; override;
    function GetMaxTablesInSelect: Integer; override;
    function GetMaxUserNameLength: Integer; override;

    function GetDefaultTransactionIsolation: TZTransactIsolationLevel; override;
    function SupportsDataDefinitionAndDataManipulationTransactions: Boolean; override;
    function SupportsDataManipulationTransactionsOnly: Boolean; override;

    function GetTables(Catalog: string; SchemaPattern: string;
      TableNamePattern: string; Types: TStringDynArray): IZResultSet; override;
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

    function GetTokenizer: IZTokenizer; override;
    function GetStatementAnalyser: IZStatementAnalyser; override;
  end;

implementation

uses
  Math, ZMessages, ZDbcUtils, ZCollections, ZDbcMySqlUtils, ZMySqlToken,
  ZMySqlAnalyser;

{ TZMySQLDatabaseMetadata }

{**
  Constructs this object and assignes the main properties.
  @param Connection a database connection object.
  @param Url a database connection url string.
  @param Info an extra connection properties.
}
constructor TZMySQLDatabaseMetadata.Create(Connection: TZAbstractConnection;
  Url: string; Info: TStrings);
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
destructor TZMySQLDatabaseMetadata.Destroy;
begin
  inherited Destroy;
end;

//----------------------------------------------------------------------
// First, a variety of minor information about the target database.

{**
  What's the name of this database product?
  @return database product name
}
function TZMySQLDatabaseMetadata.GetDatabaseProductName: string;
begin
  Result := 'MySQL';
end;

{**
  What's the version of this database product?
  @return database version
}
function TZMySQLDatabaseMetadata.GetDatabaseProductVersion: string;
begin
  Result := '3+';
end;

{**
  What's the name of this JDBC driver?
  @return JDBC driver name
}
function TZMySQLDatabaseMetadata.GetDriverName: string;
begin
  Result := 'Zeos Database Connectivity Driver for MySQL';
end;

{**
  What's this JDBC driver's major version number?
  @return JDBC driver major version
}
function TZMySQLDatabaseMetadata.GetDriverMajorVersion: Integer;
begin
  Result := 1;
end;

{**
  What's this JDBC driver's minor version number?
  @return JDBC driver minor version number
}
function TZMySQLDatabaseMetadata.GetDriverMinorVersion: Integer;
begin
  Result := 1;
end;

{**
  Does the database use a file for each table?
  @return true if the database uses a local file for each table
}
function TZMySQLDatabaseMetadata.UsesLocalFilePerTable: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.StoresMixedCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  What's the string used to quote SQL identifiers?
  This returns a space " " if identifier quoting isn't supported.
  A JDBC Compliant<sup><font size=-2>TM</font></sup>
  driver always uses a double quote character.
  @return the quoting string
}
function TZMySQLDatabaseMetadata.GetIdentifierQuoteString: string;
begin
  Result := '`';
end;

{**
  Gets a comma-separated list of all a database's SQL keywords
  that are NOT also SQL92 keywords.
  @return the list
}
function TZMySQLDatabaseMetadata.GetSQLKeywords: string;
begin
  Result := 'AUTO_INCREMENT,BINARY,BLOB,ENUM,INFILE,LOAD,MEDIUMINT,OPTION,'
    + 'OUTFILE,REPLACE,SET,TEXT,UNSIGNED,ZEROFILL';
end;

{**
  Gets a comma-separated list of math functions.  These are the
  X/Open CLI math function names used in the JDBC function escape
  clause.
  @return the list
}
function TZMySQLDatabaseMetadata.GetNumericFunctions: string;
begin
  Result := 'ABS,ACOS,ASIN,ATAN,ATAN2,BIT_COUNT,CEILING,COS,COT,DEGREES,EXP,'
    + 'FLOOR,LOG,LOG10,MAX,MIN,MOD,PI,POW,POWER,RADIANS,RAND,ROUND,SIN,SQRT,'
    + 'TAN,TRUNCATE';
end;

{**
  Gets a comma-separated list of string functions.  These are the
  X/Open CLI string function names used in the JDBC function escape
  clause.
  @return the list
}
function TZMySQLDatabaseMetadata.GetStringFunctions: string;
begin
  Result := 'ACII,CHAR,CHAR_LENGTH,CHARACTER_LENGTH,CONCAT,ELT,FIELD,'
    + 'FIND_IN_SET,INSERT,INSTR,INTERVAL,LCASE,LEFT,LENGTH,LOCATE,LOWER,LTRIM,'
    + 'MID,POSITION,OCTET_LENGTH,REPEAT,REPLACE,REVERSE,RIGHT,RTRIM,SPACE,'
    + 'SOUNDEX,SUBSTRING,SUBSTRING_INDEX,TRIM,UCASE,UPPER';
end;

{**
  Gets a comma-separated list of system functions.  These are the
  X/Open CLI system function names used in the JDBC function escape
  clause.
  @return the list
}
function TZMySQLDatabaseMetadata.GetSystemFunctions: string;
begin
  Result := 'DATABASE,USER,SYSTEM_USER,SESSION_USER,PASSWORD,ENCRYPT,'
    + 'LAST_INSERT_ID,VERSION';
end;

{**
  Gets a comma-separated list of time and date functions.
  @return the list
}
function TZMySQLDatabaseMetadata.GetTimeDateFunctions: string;
begin
  Result := 'DAYOFWEEK,WEEKDAY,DAYOFMONTH,DAYOFYEAR,MONTH,DAYNAME,MONTHNAME,'
    + 'QUARTER,WEEK,YEAR,HOUR,MINUTE,SECOND,PERIOD_ADD,PERIOD_DIFF,TO_DAYS,'
    + 'FROM_DAYS,DATE_FORMAT,TIME_FORMAT,CURDATE,CURRENT_DATE,CURTIME,'
    + 'CURRENT_TIME,NOW,SYSDATE,CURRENT_TIMESTAMP,UNIX_TIMESTAMP,FROM_UNIXTIME,'
    + 'SEC_TO_TIME,TIME_TO_SEC';
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
function TZMySQLDatabaseMetadata.GetSearchStringEscape: string;
begin
  Result := '\';
end;

{**
  Gets all the "extra" characters that can be used in unquoted
  identifier names (those beyond a-z, A-Z, 0-9 and _).
  @return the string containing the extra characters
}
function TZMySQLDatabaseMetadata.GetExtraNameCharacters: string;
begin
  Result := '';
end;

//--------------------------------------------------------------------
// Functions describing which features are supported.

{**
  Can an "ORDER BY" clause use columns not in the SELECT statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsOrderByUnrelated: Boolean;
begin
  Result := False;
end;

{**
  Can a "GROUP BY" clause use columns not in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsGroupByUnrelated: Boolean;
begin
  Result := False;
end;

{**
  Can a "GROUP BY" clause add columns not in the SELECT
  provided it specifies all the columns in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsGroupByBeyondSelect: Boolean;
begin
  Result := True;
end;

{**
  Is the SQL Integrity Enhancement Facility supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsIntegrityEnhancementFacility: Boolean;
begin
  Result := False;
end;

{**
  What's the database vendor's preferred term for "schema"?
  @return the vendor term
}
function TZMySQLDatabaseMetadata.GetSchemaTerm: string;
begin
  Result := '';
end;

{**
  What's the database vendor's preferred term for "procedure"?
  @return the vendor term
}
function TZMySQLDatabaseMetadata.GetProcedureTerm: string;
begin
  Result := '';
end;

{**
  What's the database vendor's preferred term for "catalog"?
  @return the vendor term
}
function TZMySQLDatabaseMetadata.GetCatalogTerm: string;
begin
  Result := 'Database';
end;

{**
  Can a catalog name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsCatalogsInDataManipulation: Boolean;
var
  MajorVersion: Integer;
  MinorVersion: Integer;
begin
  GetVersion(MajorVersion, MinorVersion);
  Result := ((MajorVersion = 3) and (MinorVersion >= 22)) or (MajorVersion > 3);
end;

{**
  Can a catalog name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsCatalogsInTableDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in comparison expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsSubqueriesInComparisons: Boolean;
begin
  Result := True;
end;

{**
  Is SQL UNION ALL supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsUnionAll: Boolean;
var
  MajorVersion: Integer;
  MinorVersion: Integer;
begin
  GetVersion(MajorVersion, MinorVersion);
  Result := MajorVersion >= 4;
end;

{**
  Can statements remain open across commits?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZMySQLDatabaseMetadata.SupportsOpenStatementsAcrossCommit: Boolean;
begin
  Result := False;
end;

{**
  Can statements remain open across rollbacks?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZMySQLDatabaseMetadata.SupportsOpenStatementsAcrossRollback: Boolean;
begin
  Result := False;
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
function TZMySQLDatabaseMetadata.GetMaxBinaryLiteralLength: Integer;
begin
  Result := 16777208;
end;

{**
  What's the max length for a character literal?
  @return max literal length;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxCharLiteralLength: Integer;
begin
  Result := 16777208;
end;

{**
  What's the limit on column name length?
  @return max column name length;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxColumnNameLength: Integer;
begin
  Result := 64;
end;

{**
  What's the maximum number of columns in a "GROUP BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxColumnsInGroupBy: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum number of columns allowed in an index?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxColumnsInIndex: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum number of columns in an "ORDER BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxColumnsInOrderBy: Integer;
begin
  Result := 16;
end;

{**
  What's the maximum number of columns in a "SELECT" list?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxColumnsInSelect: Integer;
begin
  Result := 256;
end;

{**
  What's the maximum number of columns in a table?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxColumnsInTable: Integer;
begin
  Result := 512;
end;

{**
  How many active connections can we have at a time to this database?
  @return max number of active connections;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxConnections: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum cursor name length?
  @return max cursor name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxCursorNameLength: Integer;
begin
  Result := 64;
end;

{**
  Retrieves the maximum number of bytes for an index, including all
  of the parts of the index.
  @return max index length in bytes, which includes the composite of all
   the constituent parts of the index;
   a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxIndexLength: Integer;
begin
  Result := 128;
end;

{**
  What's the maximum length of a catalog name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxCatalogNameLength: Integer;
begin
  Result := 32;
end;

{**
  What's the maximum length of a single row?
  @return max row size in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxRowSize: Integer;
begin
  Result := 2147483639;
end;

{**
  Did getMaxRowSize() include LONGVARCHAR and LONGVARBINARY
  blobs?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.DoesMaxRowSizeIncludeBlobs: Boolean;
begin
  Result := True;
end;

{**
  What's the maximum length of an SQL statement?
  @return max length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxStatementLength: Integer;
begin
  Result := 65531;
end;

{**
  How many active statements can we have open at one time to this
  database?
  @return the maximum number of statements that can be open at one time;
    a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxStatements: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a table name?
  @return max name length in bytes;
    a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxTableNameLength: Integer;
begin
  Result := 64;
end;

{**
  What's the maximum number of tables in a SELECT statement?
  @return the maximum number of tables allowed in a SELECT statement;
       a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxTablesInSelect: Integer;
begin
  Result := 256;
end;

{**
  What's the maximum length of a user name?
  @return max user name length  in bytes;
    a result of zero means that there is no limit or the limit is not known
}
function TZMySQLDatabaseMetadata.GetMaxUserNameLength: Integer;
begin
  Result := 16;
end;

//----------------------------------------------------------------------

{**
  What's the database's default transaction isolation level?  The
  values are defined in <code>java.sql.Connection</code>.
  @return the default isolation level
  @see Connection
}
function TZMySQLDatabaseMetadata.GetDefaultTransactionIsolation:
  TZTransactIsolationLevel;
begin
  Result := tiNone;
end;

{**
  Are both data definition and data manipulation statements
  within a transaction supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.
  SupportsDataDefinitionAndDataManipulationTransactions: Boolean;
begin
  Result := True;
end;

{**
  Are only data manipulation statements within a transaction
  supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZMySQLDatabaseMetadata.SupportsDataManipulationTransactionsOnly:
  Boolean;
begin
  case GetConnection.GetTransactionIsolation of
    tiReadUncommitted: Result := True;
    tiReadCommitted: Result := True;
    tiRepeatableRead: Result := True;
    tiSerializable: Result := True;
    else Result := False;
  end;
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
function TZMySQLDatabaseMetadata.GetTables(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  Types: TStringDynArray): IZResultSet;
var
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  TempResultSet: IZResultSet;
begin
  TargetResultSet := inherited GetTables(Catalog, SchemaPattern,
    TableNamePattern, Types) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if SchemaPattern <> '' then
    TempCatalog := SchemaPattern
  else TempCatalog := FDatabase;

  if TableNamePattern = '' then
    TableNamePattern := '%';

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(
    'SHOW TABLES FROM ' + GetIdentifierConvertor.Quote(TempCatalog)
    + ' LIKE ''' + TableNamePattern + '''');

  while TempResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(1, TempCatalog);
    TargetResultSet.UpdateString(3, TempResultSet.GetString(1));
    TargetResultSet.UpdateString(4, 'TABLE');
    TargetResultSet.InsertRow;
  end;
  TempResultSet.Close;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetCatalogs: IZResultSet;
var
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
begin
  TargetResultSet := inherited GetCatalogs as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  ResultSet := GetConnection.CreateStatement.ExecuteQuery('SHOW DATABASES');
  while ResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    TargetResultSet.UpdateString(1, ResultSet.GetString(1));
    TargetResultSet.InsertRow;
  end;
  ResultSet.Close;

  Result := CloneCachedResultSet(TargetResultSet);
end;


function TZMySQLDatabaseMetadata.GetTableTypes: IZResultSet;
var
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTableTypes as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  TargetResultSet.MoveToInsertRow;
  TargetResultSet.UpdateString(1, 'TABLE');
  TargetResultSet.InsertRow;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetColumns(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
var
  I, J: Integer;
  TargetResultSet: IZVirtualResultSet;
  Tables: IZResultSet;
  ResultSet: IZResultSet;
  MysqlType: TZSQLType;

  TempCatalog: string;
  TempStr: string;
  TempPos: Integer;

  TypeInfoList: TStrings;
  TypeInfo, TypeInfoFirst, TypeInfoSecond: string;
  Nullable, DefaultValue: string;
  ColumnSize, ColumnDecimals: Integer;
  OrdPosition: Integer;

  TableNameList: TStrings;
  TableName: string;
  TableNameLength: Integer;
begin
  TargetResultSet := inherited GetColumns(Catalog, SchemaPattern,
    TableNamePattern, ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if SchemaPattern <> '' then
    TempCatalog := SchemaPattern
  else TempCatalog := FDatabase;

  if ColumnNamePattern = '' then
    ColumnNamePattern := '%';

  TableNameLength := 0;
  TableNameList := TStringList.Create;
  TypeInfoList := TStringList.Create;

  try
    Tables := GetTables(Catalog, SchemaPattern, TableNamePattern, nil);
    while Tables.Next do
    begin
      TableName := Tables.GetStringByName('TABLE_NAME');
      TableNameList.Add(TableName);
      TableNameLength := Max(TableNameLength, Length(TableName));
    end;
    Tables.Close;

    for I := 0 to TableNameList.Count - 1 do
    begin
      OrdPosition := 1;
      TableNamePattern := TableNameList.Strings[I];

      ResultSet := GetConnection.CreateStatement.ExecuteQuery(
        'SHOW COLUMNS FROM ' + GetIdentifierConvertor.Quote(TempCatalog)
        + '.' + GetIdentifierConvertor.Quote(TableNamePattern) +
        ' LIKE ''' + ColumnNamePattern + '''');

      while ResultSet.Next do
      begin
        {initialise some variables}
        ColumnSize := 0;
        TypeInfoFirst := '';

        TargetResultSet.MoveToInsertRow;
        TargetResultSet.UpdateString(1, TempCatalog);
        TargetResultSet.UpdateString(2, '');
        TargetResultSet.UpdateString(3, TableNamePattern);
        TargetResultSet.UpdateString(4, ResultSet.GetStringByName('Field'));

        TypeInfo := ResultSet.GetStringByName('Type');

        if StrPos(PChar(TypeInfo), '(') <> nil then
        begin
          PutSplitString(TypeInfoList, TypeInfo, '()');
          TypeInfoFirst := TypeInfoList.Strings[0];
          TypeInfoSecond := TypeInfoList.Strings[1];
        end
        else
          TypeInfoFirst := TypeInfo;

        MysqlType := ConvertMySQLTypeToSQLType(TypeInfoFirst, TypeInfo);
        TargetResultSet.UpdateInt(5, Ord(MysqlType));
        TargetResultSet.UpdateString(6, TypeInfoFirst);

        TargetResultSet.UpdateInt(7, 0);
        TargetResultSet.UpdateInt(9, 0);
        { the column type is ENUM}
        if TypeInfoFirst = 'enum' then
        begin
          PutSplitString(TypeInfoList, TypeInfoSecond, ',');
          for J := 0 to TypeInfoList.Count-1 do
            ColumnSize := Max(ColumnSize, Length(TypeInfoList.Strings[J]));

          TargetResultSet.UpdateInt(7, ColumnSize);
          TargetResultSet.UpdateInt(9, 0);
        end
        else
          { the column type is decimal }
          if StrPos(PChar(TypeInfo), ',') <> nil then
          begin
            TempPos := FirstDelimiter(',', TypeInfoSecond);
            ColumnSize := StrToIntDef(Copy(TypeInfoSecond, 1, TempPos - 1), 0);
            ColumnDecimals := StrToIntDef(Copy(TypeInfoSecond, TempPos + 1,
              Length(TempStr) - TempPos), 0);
            TargetResultSet.UpdateInt(7, ColumnSize);
            TargetResultSet.UpdateInt(9, ColumnDecimals);
          end
          else
          begin
            { the column type is other }
             if TypeInfoSecond <> '' then
                ColumnSize := StrToIntDef(TypeInfoSecond, 0)
             else if LowerCase(TypeInfoFirst) = 'tinyint' then
                ColumnSize := 1
             else if LowerCase(TypeInfoFirst) = 'smallint' then
                ColumnSize := 6
             else if LowerCase(TypeInfoFirst) = 'mediumint' then
                ColumnSize := 6
             else if LowerCase(TypeInfoFirst) = 'int' then
                ColumnSize := 11
             else if LowerCase(TypeInfoFirst) = 'integer' then
                ColumnSize := 11
             else if LowerCase(TypeInfoFirst) = 'bigint' then
                ColumnSize := 25
             else if LowerCase(TypeInfoFirst) = 'int24' then
                ColumnSize := 25
             else if LowerCase(TypeInfoFirst) = 'real' then
                ColumnSize := 12
             else if LowerCase(TypeInfoFirst) = 'float' then
                ColumnSize := 12
             else if LowerCase(TypeInfoFirst) = 'decimal' then
                ColumnSize := 12
             else if LowerCase(TypeInfoFirst) = 'numeric' then
                ColumnSize := 12
             else if LowerCase(TypeInfoFirst) = 'double' then
                ColumnSize := 22
             else if LowerCase(TypeInfoFirst) = 'char' then
                ColumnSize := 1
             else if LowerCase(TypeInfoFirst) = 'varchar' then
                ColumnSize := 255
             else if LowerCase(TypeInfoFirst) = 'date' then
                ColumnSize := 10
             else if LowerCase(TypeInfoFirst) = 'time' then
                ColumnSize := 8
             else if LowerCase(TypeInfoFirst) = 'timestamp' then
                ColumnSize := 19
             else if LowerCase(TypeInfoFirst) = 'datetime' then
                ColumnSize := 19
             else if LowerCase(TypeInfoFirst) = 'tinyblob' then
                ColumnSize := 255
             else if LowerCase(TypeInfoFirst) = 'blob' then
                ColumnSize := MAXBUF
             else if LowerCase(TypeInfoFirst) = 'mediumblob' then
                ColumnSize := 16277215//may be 65535
             else if LowerCase(TypeInfoFirst) = 'longblob' then
                ColumnSize := High(Integer)//2147483657//may be 65535
             else if LowerCase(TypeInfoFirst) = 'tinytext' then
                ColumnSize := 255
             else if LowerCase(TypeInfoFirst) = 'text' then
                ColumnSize := 65535
             else if LowerCase(TypeInfoFirst) = 'mediumtext' then
                ColumnSize := 16277215 //may be 65535
             else if LowerCase(TypeInfoFirst) = 'enum' then
                ColumnSize := 255
             else if LowerCase(TypeInfoFirst) = 'set' then
                ColumnSize := 255;
            TargetResultSet.UpdateInt(7, ColumnSize);
            TargetResultSet.UpdateInt(9, 0);
          end;

        TargetResultSet.UpdateInt(8, MAXBUF);
        TargetResultSet.UpdateNull(10);

        { Sets nullable fields. }
        Nullable := ResultSet.GetStringByName('Null');
        if Nullable <> '' then
          if Nullable = 'YES' then
          begin
            TargetResultSet.UpdateInt(11, Ord(ntNullable));
            TargetResultSet.UpdateString(18, 'YES');
          end
          else
          begin
            TargetResultSet.UpdateInt(11, Ord(ntNoNulls));
            TargetResultSet.UpdateString(18, 'NO');
          end
        else
        begin
          TargetResultSet.UpdateInt(11, 0);
          TargetResultSet.UpdateString(18, 'NO');
        end;
        TargetResultSet.UpdateString(12, ResultSet.GetStringByName('Extra'));
        if not ResultSet.IsNullByName('Default') then
        begin
          DefaultValue := ResultSet.GetStringByName('Default');
          if (MysqlType in [stString, stUnicodeString, stDate, stTime,
            stTimestamp]) then
            DefaultValue := '''' + DefaultValue + ''''
          else if (MysqlType = stBoolean) and (TypeInfoFirst = 'enum') then
          begin
            if (DefaultValue = 'y') or (DefaultValue = 'Y') then
              DefaultValue := '1'
            else DefaultValue := '0';
          end;
          TargetResultSet.UpdateString(13, DefaultValue);
        end;
        TargetResultSet.UpdateNull(14);
        TargetResultSet.UpdateNull(15);
  //!!      TargetResultSet.UpdateInt(16, Result.GetInt(7));
        TargetResultSet.UpdateInt(17, OrdPosition);

        TargetResultSet.UpdateBooleanByName('AUTO_INCREMENT',
          Trim(LowerCase(ResultSet.GetStringByName('Extra'))) = 'auto_increment');
        TargetResultSet.UpdateBooleanByName('CASE_SENSITIVE',
          GetIdentifierConvertor.IsCaseSensitive(
          ResultSet.GetStringByName('Field')));
        TargetResultSet.UpdateBooleanByName('SEARCHABLE', True);
        TargetResultSet.UpdateBooleanByName('WRITABLE', True);
        TargetResultSet.UpdateBooleanByName('DEFINITELYWRITABLE', True);
        TargetResultSet.UpdateBooleanByName('READONLY', False);

        Inc(OrdPosition);
        TargetResultSet.InsertRow;
      end;
      ResultSet.Close;
    end;
  finally
    TableNameList.Free;
    TypeInfoList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetColumnPrivileges(Catalog: string;
  Schema: string; Table: string; ColumnNamePattern: string): IZResultSet;
var
  I: Integer;
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  Host, Database, Grantor, User, FullUser: string;
  AllPrivileges, ColumnName, Privilege: string;
  PrivilegesList: TStrings;
begin
  TargetResultSet := inherited GetColumnPrivileges(Catalog, Schema,
    Table, ColumnNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if Schema <> '' then
    TempCatalog := Schema
  else TempCatalog := FDatabase;

  if ColumnNamePattern = '' then
    ColumnNamePattern := '%';

  PrivilegesList := TStringList.Create;

  try
    ResultSet := GetConnection.CreateStatement.ExecuteQuery(
      'SELECT c.host, c.db, t.grantor, c.user, c.table_name,'
      + ' c.column_name, c.column_priv FROM mysql.columns_priv c,'
      + ' mysql.tables_priv t WHERE c.host=t.host AND c.db=t.db'
      + ' AND c.table_name=t.table_name AND '
      + ' c.db=''' + TempCatalog + ''' AND c.table_name=''' + Table
      + ''' AND c.column_name LIKE ''' + ColumnNamePattern + '''');

    while ResultSet.Next do
    begin
      Host := ResultSet.GetString(1);
      Database := ResultSet.GetString(2);
      Grantor := ResultSet.GetString(4);
      User := ResultSet.GetString(5);
      if User = '' then
        User := '%';
      if Host <> '' then
        FullUser := User + '@' + Host;
      ColumnName := ResultSet.GetString(6);

      AllPrivileges := ResultSet.GetString(7);
      PutSplitString(PrivilegesList, AllPrivileges, ',');

      for I := 0 to PrivilegesList.Count - 1 do
      begin
        TargetResultSet.MoveToInsertRow;
        Privilege := Trim(PrivilegesList.Strings[I]);
        TargetResultSet.UpdateString(1, Database);
        TargetResultSet.UpdateNull(2);
        TargetResultSet.UpdateString(3, Table);
        TargetResultSet.UpdateString(4, ColumnName);
        TargetResultSet.UpdateString(5, Grantor);
        TargetResultSet.UpdateString(6, FullUser);
        TargetResultSet.UpdateString(7, Privilege);
        TargetResultSet.UpdateNull(8);
        TargetResultSet.InsertRow;
      end;
    end;
    ResultSet.Close;
  finally
    PrivilegesList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetTablePrivileges(Catalog: string;
  SchemaPattern: string; TableNamePattern: string): IZResultSet;
var
  I: Integer;
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  Host, Database, Table, Grantor, User, FullUser: string;
  AllPrivileges, Privilege: string;
  PrivilegesList: TStrings;
begin
  TargetResultSet := inherited GetTablePrivileges(Catalog, SchemaPattern,
    TableNamePattern) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if SchemaPattern <> '' then
    TempCatalog := SchemaPattern
  else TempCatalog := FDatabase;

  if TableNamePattern = '' then
    TableNamePattern := '%';

  PrivilegesList := TStringList.Create;

  try
    ResultSet := GetConnection.CreateStatement.ExecuteQuery(
      'SELECT host,db,table_name,grantor,user,table_priv'
      + ' from mysql.tables_priv WHERE db=''' + TempCatalog + ''' AND '
      + 'table_name LIKE ''' + TableNamePattern + '''');

    while ResultSet.Next do
    begin
      Host := ResultSet.GetString(1);
      Database := ResultSet.GetString(2);
      Table := ResultSet.GetString(3);
      Grantor := ResultSet.GetString(4);
      User := ResultSet.GetString(5);
      if User = '' then
        User := '%';
      if Host <> '' then
        FullUser := User + '@' + Host;

      AllPrivileges := ResultSet.GetString(6);
      PutSplitString(PrivilegesList, AllPrivileges, ',');

      for I := 0 to PrivilegesList.Count-1 do
      begin
        TargetResultSet.MoveToInsertRow;
        Privilege := Trim(PrivilegesList.Strings[I]);
        TargetResultSet.UpdateString(1, Database);
        TargetResultSet.UpdateNull(2);
        TargetResultSet.UpdateString(3, Table);
        TargetResultSet.UpdateString(4, Grantor);
        TargetResultSet.UpdateString(5, FullUser);
        TargetResultSet.UpdateString(6, Privilege);
        TargetResultSet.UpdateNull(7);
        TargetResultSet.InsertRow;
      end;
    end;
    ResultSet.Close;
  finally
    PrivilegesList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetBestRowIdentifier(Catalog: string;
  Schema: string; Table: string; Scope: Integer; Nullable: Boolean): IZResultSet;
const
  PimaryKey = 'PRI';

var
  I: Integer;
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  TypeInfoList: TStrings;
  MysqlType: TZSQLType;
  ColumnSize, ColumnDecimals: Integer;
  Key, TypeInfo, TypeInfoFirst, TypeInfoSecond: string;
begin
  TargetResultSet := inherited GetBestRowIdentifier(Catalog, Schema,
    Table, Scope, Nullable) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if Schema <> '' then
    TempCatalog := Schema
  else TempCatalog := FDatabase;

  TypeInfoList := TStringList.Create;

  try
    ResultSet := GetConnection.CreateStatement.ExecuteQuery(
      'SHOW COLUMNS FROM ' + GetIdentifierConvertor.Quote(TempCatalog)
      + '.' + GetIdentifierConvertor.Quote(Table));

    while ResultSet.Next do
    begin
      TargetResultSet.MoveToInsertRow;
      TargetResultSet.UpdateInt(1, Ord(sbrSession));
      TargetResultSet.UpdateString(2, ResultSet.GetStringByName('Field'));

      Key := UpperCase(ResultSet.GetStringByName('Key'));

      if (Key = '') or (StrLComp(PChar(Key), PimaryKey,
         Length(PimaryKey)) <> 0) then
         Continue;

      TypeInfo := ResultSet.GetStringByName('Type');
      ColumnSize := MAXBUF;
      ColumnDecimals := 0;

      if StrPos(PChar(TypeInfo), '(') <> nil then
      begin
        PutSplitString(TypeInfoList, TypeInfo, '()');
        TypeInfoFirst := TypeInfoList.Strings[0];
        TypeInfoSecond := TypeInfoList.Strings[1];
      end
      else
        TypeInfoFirst := TypeInfo;

      MysqlType := ConvertMySQLTypeToSQLType(TypeInfoFirst, TypeInfo);

      if TypeInfoFirst = 'enum' then
      begin
        ColumnSize := 0;
        PutSplitString(TypeInfoList, TypeInfoSecond, ',');
        for I := 0 to TypeInfoList.Count-1 do
         ColumnSize := Max(ColumnSize, Length(TypeInfoList.Strings[I]));
      end
      else
      begin
        if TypeInfoSecond <> '' then
        begin
          if FirstDelimiter(',', TypeInfoSecond) > 0 then
          begin
            PutSplitString(TypeInfoList, TypeInfoSecond, ',');
            ColumnSize := StrToIntDef(TypeInfoList.Strings[0], 0);
            ColumnDecimals := StrToIntDef(TypeInfoList.Strings[1], 0);
          end
          else
            ColumnSize := StrToIntDef(TypeInfoSecond, 0);
        end;
      end;

      TargetResultSet.UpdateInt(3, Ord(MysqlType));
      TargetResultSet.UpdateString(4, TypeInfo);
      TargetResultSet.UpdateInt(5, ColumnSize + ColumnDecimals);
      TargetResultSet.UpdateInt(6, ColumnSize + ColumnDecimals);
      TargetResultSet.UpdateInt(7, ColumnDecimals);
      TargetResultSet.UpdateInt(8, Ord(brNotPseudo));
      TargetResultSet.InsertRow;
    end;
    ResultSet.Close;
  finally
    TypeInfoList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetPrimaryKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  KeyType: string;
  TempCatalog: string;
  TempResultSet: IZResultSet;
  TargetResultSet: IZVirtualResultSet;
begin
  if Table = '' then
    raise Exception.Create(STableIsNotSpecified); //CHANGE IT!

  TargetResultSet := inherited GetPrimaryKeys(Catalog, Schema,
    Table) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if Schema <> '' then
    TempCatalog := Schema
  else TempCatalog := FDatabase;

  TempResultSet := GetConnection.CreateStatement.ExecuteQuery(
    'SHOW KEYS FROM ' + GetIdentifierConvertor.Quote(TempCatalog) + '.'
    + GetIdentifierConvertor.Quote(Table));

  while TempResultSet.Next do
  begin
    KeyType := UpperCase(TempResultSet.GetStringByName('Key_name'));
    KeyType := Copy(KeyType, 1, 3);
    if KeyType = 'PRI' then
    begin
      TargetResultSet.MoveToInsertRow;
      if Catalog = '' then
        TargetResultSet.UpdateNull(1)
      else
        TargetResultSet.UpdateString(1, Catalog);
      TargetResultSet.UpdateString(2, '');
      TargetResultSet.UpdateString(3, Table);
      TargetResultSet.UpdateString(4, TempResultSet.GetStringByName('Column_name'));
      TargetResultSet.UpdateString(5, TempResultSet.GetStringByName('Seq_in_index'));
      TargetResultSet.UpdateNull(6);
      TargetResultSet.InsertRow;
    end;
  end;
  TempResultSet.Close;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetImportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  I: Integer;
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  KeySeq: Integer;
  TableType, Comment, Keys: string;
  CommentList, KeyList: TStrings;
begin
  if Table = '' then
    raise Exception.Create(STableIsNotSpecified); //CHANGE IT!

  TargetResultSet := inherited GetImportedKeys(Catalog, Schema,
    Table) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if Schema <> '' then
    TempCatalog := Schema
  else TempCatalog := FDatabase;

  KeyList := TStringList.Create;
  CommentList := TStringList.Create;

  try
    ResultSet := GetConnection.CreateStatement.ExecuteQuery(
      'SHOW TABLE STATUS FROM ' + GetIdentifierConvertor.Quote(TempCatalog)
      + ' LIKE ''' + Table + '''');

    while ResultSet.Next do
    begin
      TableType := ResultSet.GetStringByName('Type');
      if (TableType <> '') and (LowerCase(TableType) = 'innodb') then
      begin
        Comment := ResultSet.GetStringByName('Comment');
        if Comment <> '' then
        begin
          PutSplitString(CommentList, Comment, ';');
          KeySeq := 0;

          if CommentList.Count > 4 then
            for I := 0 to CommentList.Count-1 do
            begin
              Keys := CommentList.Strings[1];
              TargetResultSet.MoveToInsertRow;
              PutSplitString(KeyList, Keys, '() /');

              if Catalog = '' then
                TargetResultSet.UpdateNull(5)
              else
                TargetResultSet.UpdateString(5, Catalog);

              TargetResultSet.UpdateNull(6);// FKTABLE_SCHEM
              TargetResultSet.UpdateString(7, Table); // FKTABLE_NAME
              TargetResultSet.UpdateString(8, KeyList.Strings[0]); // FKCOLUMN_NAME

              TargetResultSet.UpdateString(1, KeyList.Strings[2]); // PKTABLE_CAT
              TargetResultSet.UpdateNull(2); // PKTABLE_SCHEM
              TargetResultSet.UpdateString(3, KeyList.Strings[3]); // PKTABLE_NAME
              TargetResultSet.UpdateString(4, KeyList.Strings[4]); // PKCOLUMN_NAME
              TargetResultSet.UpdateInt(9, KeySeq); // KEY_SEQ
              TargetResultSet.UpdateInt(10, ord(ikSetDefault)); // UPDATE_RULE
              TargetResultSet.UpdateInt(11, ord(ikSetDefault)); // DELETE_RULE
              TargetResultSet.UpdateNull(12); // FK_NAME
              TargetResultSet.UpdateNull(13); // PK_NAME
              TargetResultSet.UpdateInt(14, ord(ikSetDefault)); // DEFERRABILITY
              Inc(KeySeq);
              TargetResultSet.InsertRow;
            end;
        end;
      end;
    end;
    ResultSet.Close;
  finally
    KeyList.Free;
    CommentList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetExportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  I: Integer;
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  KeySeq: Integer;
  TableType, Comment, Keys: string;
  CommentList, KeyList: TStrings;
begin
  if Table = '' then
    raise Exception.Create(STableIsNotSpecified); //CHANGE IT!

  TargetResultSet := inherited GetExportedKeys(Catalog, Schema,
    Table) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if Schema <> '' then
    TempCatalog := Schema
  else TempCatalog := FDatabase;

  KeyList := TStringList.Create;
  CommentList := TStringList.Create;

  try
    ResultSet := GetConnection.CreateStatement.ExecuteQuery(
      'SHOW TABLE STATUS FROM ' + GetIdentifierConvertor.Quote(TempCatalog));

    while ResultSet.Next do
    begin
      TableType := ResultSet.GetStringByName('Type');
      if (TableType <> '') and (LowerCase(TableType) = 'innodb') then
      begin
        Comment := ResultSet.GetStringByName('Comment');
        if Comment <> '' then
        begin
          PutSplitString(CommentList, Comment, ';');
          KeySeq := 0;
          if CommentList.Count > 4 then
            for I := 0 to CommentList.Count-1 do
            begin
              Keys := CommentList.Strings[1];
              TargetResultSet.MoveToInsertRow;
              PutSplitString(KeyList, Keys, '() /');

              if Catalog = '' then
                TargetResultSet.UpdateNull(5)
              else
                TargetResultSet.UpdateString(5, Catalog);

              TargetResultSet.UpdateNull(6);// FKTABLE_SCHEM
              TargetResultSet.UpdateString(7, ResultSet.GetStringByName('Name')); // FKTABLE_NAME
              TargetResultSet.UpdateString(8, KeyList.Strings[0]); // PKTABLE_CAT

              TargetResultSet.UpdateString(1, KeyList.Strings[2]); // PKTABLE_CAT
              TargetResultSet.UpdateNull(2); // PKTABLE_SCHEM
              TargetResultSet.UpdateString(3, Table); // PKTABLE_NAME
              TargetResultSet.UpdateInt(9, KeySeq); // KEY_SEQ

              TargetResultSet.UpdateInt(10, Ord(ikSetDefault)); // UPDATE_RULE
              TargetResultSet.UpdateInt(11, Ord(ikSetDefault)); // DELETE_RULE
              TargetResultSet.UpdateNull(12); // FK_NAME
              TargetResultSet.UpdateNull(13); // PK_NAME
              TargetResultSet.UpdateInt(14, Ord(ikSetDefault)); // DEFERRABILITY
              Inc(KeySeq);
              TargetResultSet.InsertRow;
            end;
        end;
      end;
    end;
    ResultSet.Close;
  finally
    KeyList.Free;
    CommentList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetCrossReference(PrimaryCatalog: string;
  PrimarySchema: string; PrimaryTable: string; ForeignCatalog: string;
  ForeignSchema: string; ForeignTable: string): IZResultSet;
var
  I: Integer;
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
  KeySeq: Integer;
  TableType, Comment, Keys: string;
  CommentList, KeyList: TStrings;
begin
  if PrimaryTable = '' then
    raise Exception.Create(STableIsNotSpecified); //CHANGE IT!

  TargetResultSet := inherited GetCrossReference(PrimaryCatalog, PrimarySchema,
    PrimaryTable, ForeignCatalog, ForeignSchema, ForeignTable)
    as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if ForeignCatalog <> '' then
    TempCatalog := ForeignCatalog
  else TempCatalog := FDatabase;

  KeyList := TStringList.Create;
  CommentList := TStringList.Create;

  try
    ResultSet := GetConnection.CreateStatement.ExecuteQuery(
      'SHOW TABLE STATUS FROM ' + GetIdentifierConvertor.Quote(TempCatalog));

    while ResultSet.Next do
    begin
      TableType := ResultSet.GetStringByName('Type');
      if (TableType <> '') and (LowerCase(TableType) = 'innodb') then
      begin
        Comment := ResultSet.GetStringByName('Comment');
        if Comment = '' then
        begin
          PutSplitString(CommentList, Comment, ';');
          KeySeq := 0;
          if CommentList.Count > 4 then
            for I := 0 to CommentList.Count-1 do
            begin
              Keys := CommentList.Strings[1];
              TargetResultSet.MoveToInsertRow;
              PutSplitString(KeyList, Keys, '() /');

              if ForeignCatalog = '' then
                TargetResultSet.UpdateNull(5)
              else
                TargetResultSet.UpdateString(5, ForeignCatalog);

              if ForeignSchema = '' then
                TargetResultSet.UpdateNull(6) // FKTABLE_SCHEM
              else
                TargetResultSet.UpdateString(6, ForeignSchema);

              if ForeignTable <> ResultSet.GetStringByName('Name') then
                Continue
              else
                TargetResultSet.UpdateString(7, ResultSet.GetStringByName('Name')); // FKTABLE_NAME

              TargetResultSet.UpdateString(8, KeyList.Strings[0]); // PKTABLE_CAT

              TargetResultSet.UpdateString(1, KeyList.Strings[2]); // PKTABLE_CAT
              if PrimarySchema = '' then
                TargetResultSet.UpdateNull(2) // PKTABLE_SCHEM
              else
                TargetResultSet.UpdateString(2, PrimarySchema); // PKTABLE_SCHEM

              if PrimaryTable = KeyList.Strings[3] then
                Continue;

              TargetResultSet.UpdateString(3, PrimaryTable); // PKTABLE_NAME
              TargetResultSet.UpdateString(4, KeyList.Strings[4]); // PKCOLUMN_NAME
              TargetResultSet.UpdateInt(9, KeySeq); // KEY_SEQ
              TargetResultSet.UpdateInt(10, Ord(ikSetDefault)); // UPDATE_RULE
              TargetResultSet.UpdateInt(11, Ord(ikSetDefault)); // DELETE_RULE
              TargetResultSet.UpdateNull(12); // FK_NAME
              TargetResultSet.UpdateNull(13); // PK_NAME
              TargetResultSet.UpdateInt(14, Ord(ikSetDefault)); // DEFERRABILITY
              Inc(KeySeq);
              TargetResultSet.InsertRow;
            end;
        end;
      end;
    end;
    ResultSet.Close;
  finally
    KeyList.Free;
    CommentList.Free;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
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
function TZMySQLDatabaseMetadata.GetTypeInfo: IZResultSet;
var
  TargetResultSet: IZVirtualResultSet;
begin
  TargetResultSet := inherited GetTypeInfo as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  with TargetResultSet do
  begin
    { mysql BIT - zeos Byte }
    MoveToInsertRow;
    UpdateString(1, 'BIT');
    UpdateInt(2, ord(stByte)); // ZeosLib Data type
    UpdateInt(3, 1); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7,  ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'BIT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql BOOL - zeos Byte }
    MoveToInsertRow;
    UpdateString(1, 'BOOL');
    UpdateInt(2, ord(stByte)); // ZeosLib Data type
    UpdateInt(3, 1); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'BOOL'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql TINYINT - zeos Short }
    MoveToInsertRow;
    UpdateString(1, 'TINYINT');
    UpdateInt(2, ord(stShort)); // ZeosLib Data type
    UpdateInt(3, 3); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M)] [UNSIGNED] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'true'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'TINYINT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql BIGINT - zeos BigDecimal }
    MoveToInsertRow;
    UpdateString(1, 'BIGINT');
    UpdateInt(2, ord(stBigDecimal)); // ZeosLib Data type
    UpdateInt(3, 19); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M)] [UNSIGNED] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'true'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'BIGINT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql MEDIUMBLOB - zeos BinaryStream }
    MoveToInsertRow;
    UpdateString(1, 'MEDIUMBLOB');
    UpdateInt(2, ord(stBinaryStream)); // ZeosLib Data type
    UpdateInt(3, 16777215); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'MEDIUMBLOB'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql LONG VARBINARY - zeos BinaryStream }
    MoveToInsertRow;
    UpdateString(1, 'LONG VARBINARY');
    UpdateInt(2, ord(stBinaryStream)); // ZeosLib Data type
    UpdateInt(3, 16777215); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'LONG VARBINARY'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql LONGBLOB - zeos BinaryStream }
    MoveToInsertRow;
    UpdateString(1, 'LONGBLOB');
    UpdateInt(2, ord(stBinaryStream)); // ZeosLib Data type
    UpdateInt(3, MAXBUF); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'LONGBLOB'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql BLOB - zeos BinaryStream }
    MoveToInsertRow;
    UpdateString(1, 'BLOB');
    UpdateInt(2, ord(stBinaryStream)); // ZeosLib Data type
    UpdateInt(3, 65535); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'BLOB'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql TINYBLOB - zeos BinaryStream }
    MoveToInsertRow;
    UpdateString(1, 'TINYBLOB');
    UpdateInt(2, ord(stBinaryStream)); // ZeosLib Data type
    UpdateInt(3, 255); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'TINYBLOB'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql VARBINARY - zeos Bytes }
    MoveToInsertRow;
    UpdateString(1, 'VARBINARY');
    UpdateInt(2, ord(stBytes)); // ZeosLib Data type
    UpdateInt(3, 255); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '(M)'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'VARBINARY'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql BINARY - zeos Bytes }
    MoveToInsertRow;
    UpdateString(1, 'BINARY');
    UpdateInt(2, ord(stBinaryStream)); // ZeosLib Data type
    UpdateInt(3, 255); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '(M)'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'true'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'BINARY'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql LONG VARCHAR - zeos String }
    MoveToInsertRow;
    UpdateString(1, 'LONG VARCHAR');
    UpdateInt(2, ord(stString)); // ZeosLib Data type
    UpdateInt(3, 16777215); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'LONG VARCHAR'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql MEDIUMTEXT - zeos AsciiStream }
    MoveToInsertRow;
    UpdateString(1, 'MEDIUMTEXT');
    UpdateInt(2, ord(stAsciiStream)); // ZeosLib Data type
    UpdateInt(3, 16777215); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'MEDIUMTEXT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql LONGTEXT - zeos AsciiStream }
    MoveToInsertRow;
    UpdateString(1, 'LONGTEXT');
    UpdateInt(2, ord(stAsciiStream)); // ZeosLib Data type
    UpdateInt(3, 2147483647); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'LONGTEXT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql TEXT - zeos AsciiStream }
    MoveToInsertRow;
    UpdateString(1, 'TEXT');
    UpdateInt(2, ord(stAsciiStream)); // ZeosLib Data type
    UpdateInt(3, 65535); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'TEXT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql TINYTEXT - zeos AsciiStream }
    MoveToInsertRow;
    UpdateString(1, 'TINYTEXT');
    UpdateInt(2, ord(stAsciiStream)); // ZeosLib Data type
    UpdateInt(3, 255); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'TINYTEXT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql CHAR - zeos String }
    MoveToInsertRow;
    UpdateString(1, 'CHAR');
    UpdateInt(2, ord(stAsciiStream)); // ZeosLib Data type
    UpdateInt(3, 255); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, '(M)'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'CHAR'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql NUMERIC - zeos BigDecimal }
    MoveToInsertRow;
    UpdateString(1, 'NUMERIC');
    UpdateInt(2, ord(stBigDecimal)); // ZeosLib Data type
    UpdateInt(3, 17); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M[,D])] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'NUMERIC'); // Locale Type Name
    UpdateInt(14, 308); // Minimum Scale
    UpdateInt(15, 308); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql DECIMAL - zeos BigDecimal }
    MoveToInsertRow;
    UpdateString(1, 'DECIMAL');
    UpdateInt(2, ord(stBigDecimal)); // ZeosLib Data type
    UpdateInt(3, 17); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M[,D])] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'DECIMAL'); // Locale Type Name
    UpdateInt(14, -308); // Minimum Scale
    UpdateInt(15, 308); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql INTEGER - zeos Integer }
    MoveToInsertRow;
    UpdateString(1, 'INTEGER');
    UpdateInt(2, ord(stInteger)); // ZeosLib Data type
    UpdateInt(3, 10); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M)] [UNSIGNED] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'true'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'INTEGER'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql INT - zeos Integer }
    MoveToInsertRow;
    UpdateString(1, 'INT');
    UpdateInt(2, ord(stInteger)); // ZeosLib Data type
    UpdateInt(3, 10); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M)] [UNSIGNED] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'true'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'INT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql MEDIUMINT - zeos Integer }
    MoveToInsertRow;
    UpdateString(1, 'MEDIUMINT');
    UpdateInt(2, ord(stInteger)); // ZeosLib Data type
    UpdateInt(3, 7); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M)] [UNSIGNED] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'true'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'MEDIUMINT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql SMALLINT - zeos Integer }
    MoveToInsertRow;
    UpdateString(1, 'SMALLINT');
    UpdateInt(2, ord(stInteger)); // ZeosLib Data type
    UpdateInt(3, 5); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M)] [UNSIGNED] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'true'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'SMALLINT'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql DOUBLE - zeos Double }
    MoveToInsertRow;
    UpdateString(1, 'DOUBLE');
    UpdateInt(2, ord(stDouble)); // ZeosLib Data type
    UpdateInt(3, 17); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M,D)] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'DOUBLE'); // Locale Type Name
    UpdateInt(14, -308); // Minimum Scale
    UpdateInt(15, 308); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql FLOAT - zeos Float }
    MoveToInsertRow;
    UpdateString(1, 'FLOAT');
    UpdateInt(2, ord(stFloat)); // ZeosLib Data type
    UpdateInt(3, 10); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M,D)] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'FLOAT'); // Locale Type Name
    UpdateInt(14, -38); // Minimum Scale
    UpdateInt(15, 38); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql DOUBLE PRECISION - zeos Double }
    MoveToInsertRow;
    UpdateString(1, 'DOUBLE');
    UpdateInt(2, ord(stDouble)); // ZeosLib Data type
    UpdateInt(3, 17); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M,D)] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'DOUBLE'); // Locale Type Name
    UpdateInt(14, -308); // Minimum Scale
    UpdateInt(15, 308); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql REAL - zeos Double }
    MoveToInsertRow;
    UpdateString(1, 'REAL');
    UpdateInt(2, ord(stDouble)); // ZeosLib Data type
    UpdateInt(3, 10); // Precision
    UpdateString(4, ''); // Literal Prefix
    UpdateString(5, ''); // Literal Suffix
    UpdateString(6, '[(M,D)] [ZEROFILL]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'true'); // Auto Increment
    UpdateString(13, 'REAL'); // Locale Type Name
    UpdateInt(14, -308); // Minimum Scale
    UpdateInt(15, 308); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql VARCHAR - zeos String }
    MoveToInsertRow;
    UpdateString(1, 'VARCHAR');
    UpdateInt(2, ord(stString)); // ZeosLib Data type
    UpdateInt(3, 255); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, '(M)'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'VARCHAR'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql ENUM - zeos String }
    MoveToInsertRow;
    UpdateString(1, 'ENUM');
    UpdateInt(2, ord(stString)); // ZeosLib Data type
    UpdateInt(3, 65535); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, '(M)'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'ENUM'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql SET - zeos String }
    MoveToInsertRow;
    UpdateString(1, 'SET');
    UpdateInt(2, ord(stString)); // ZeosLib Data type
    UpdateInt(3, 64); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, '(M)'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'SET'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql DATE - zeos Date }
    MoveToInsertRow;
    UpdateString(1, 'DATE');
    UpdateInt(2, ord(stDate)); // ZeosLib Data type
    UpdateInt(3, 0); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'DATE'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql TIME - zeos Time }
    MoveToInsertRow;
    UpdateString(1, 'TIME');
    UpdateInt(2, ord(stDate)); // ZeosLib Data type
    UpdateInt(3, 0); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'TIME'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql DATETIME - zeos TIMESTAMP }
    MoveToInsertRow;
    UpdateString(1, 'DATETIME');
    UpdateInt(2, ord(stTimestamp)); // ZeosLib Data type
    UpdateInt(3, 0); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, ''); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'DATETIME'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;

    { mysql TIMESTAMP - zeos TIMESTAMP }
    MoveToInsertRow;
    UpdateString(1, 'TIMESTAMP');
    UpdateInt(2, ord(stTimestamp)); // ZeosLib Data type
    UpdateInt(3, 0); // Precision
    UpdateString(4, ''''); // Literal Prefix
    UpdateString(5, ''''); // Literal Suffix
    UpdateString(6, '[(M)]'); // Create Params
    UpdateInt(7, ord(ntNullable)); // Nullable
    UpdateString(8, 'false'); // Case Sensitive
    UpdateInt(9, TypeSearchable); // Searchable
    UpdateString(10, 'false'); // Unsignable
    UpdateString(11, 'false'); // Fixed Prec Scale
    UpdateString(12, 'false'); // Auto Increment
    UpdateString(13, 'TIMESTAMP'); // Locale Type Name
    UpdateInt(14, 0); // Minimum Scale
    UpdateInt(15, 0); // Maximum Scale
    UpdateInt(16, 0); // SQL Data Type (not used)
    UpdateInt(17, 0); // SQL DATETIME SUB (not used)
    UpdateInt(18, 10); // NUM_PREC_RADIX (2 or 10)
    InsertRow;
  end;

  Result := CloneCachedResultSet(TargetResultSet);
end;

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
function TZMySQLDatabaseMetadata.GetIndexInfo(Catalog: string;
  Schema: string; Table: string; Unique: Boolean;
  Approximate: Boolean): IZResultSet;
var
  TempCatalog: string;
  TargetResultSet: IZVirtualResultSet;
  ResultSet: IZResultSet;
begin
  if Table = '' then
    raise Exception.Create(STableIsNotSpecified); //CHANGE IT!

  TargetResultSet := inherited GetIndexInfo(Catalog, Schema, Table, Unique,
    Approximate) as IZVirtualResultSet;
  Result := TargetResultSet;
  if IsResultSetCached(Result) then Exit;
  TargetResultSet.SetConcurrency(rcUpdatable);

  if Catalog <> '' then
    TempCatalog := Catalog
  else if Schema <> '' then
    TempCatalog := Schema
  else TempCatalog := FDatabase;

  ResultSet := GetConnection.CreateStatement.ExecuteQuery(
    'SHOW INDEX FROM ' + GetIdentifierConvertor.Quote(TempCatalog) + '.'
    + GetIdentifierConvertor.Quote(Table));

  while ResultSet.Next do
  begin
    TargetResultSet.MoveToInsertRow;
    if Catalog = '' then
      TargetResultSet.UpdateNull(2)
    else
      TargetResultSet.UpdateString(1, Catalog);
    TargetResultSet.UpdateNull(2);
    TargetResultSet.UpdateString(3, ResultSet.GetStringByName('Table'));
    if ResultSet.GetIntByName('Non_unique') = 0 then
      TargetResultSet.UpdateString(4, 'true')
    else
      TargetResultSet.UpdateString(4, 'false');
    TargetResultSet.UpdateNull(5);
    TargetResultSet.UpdateString(6, ResultSet.GetStringByName('Key_name'));
    TargetResultSet.UpdateInt(7, Ord(tiOther));
    TargetResultSet.UpdateInt(8, ResultSet.GetIntByName('Seq_in_index'));
    TargetResultSet.UpdateString(9, ResultSet.GetStringByName('Column_name'));
    TargetResultSet.UpdateString(10, ResultSet.GetStringByName('Collation'));
    TargetResultSet.UpdateString(11, ResultSet.GetStringByName('Cardinality'));
    TargetResultSet.UpdateInt(12, 0);
    TargetResultSet.UpdateNull(13);
    TargetResultSet.InsertRow;
  end;
  ResultSet.Close;

  Result := CloneCachedResultSet(TargetResultSet);
end;

{**
  Gets the MySQL version info.
  @param MajorVesion the major version of MySQL server.
  @param MinorVersion the minor version of MySQL server.
}
procedure TZMySQLDatabaseMetadata.GetVersion(var MajorVersion,
  MinorVersion: Integer);
var
  VersionList: TStrings;
  ResultSet: IZResultSet;
begin
  ResultSet := GetConnection.CreateStatement.ExecuteQuery('SELECT VERSION()');
  VersionList := SplitString(ResultSet.GetString(1), '.-');
  if VersionList.Count >= 2 then
  begin
    MajorVersion := StrToIntDef(VersionList.Strings[0], 0);
    MinorVersion := StrToIntDef(VersionList.Strings[1], 0);
  end;
  ResultSet.Close;
  VersionList.Free;
end;

{**
  Gets a SQL syntax tokenizer.
  @returns a SQL syntax tokenizer object.
}
function TZMySQLDatabaseMetadata.GetTokenizer: IZTokenizer;
begin
  if Tokenizer = nil then
    Tokenizer := TZMySQLTokenizer.Create;
  Result := Tokenizer;
end;

{**
  Creates a statement analyser object.
  @returns a statement analyser object.
}
function TZMySQLDatabaseMetadata.GetStatementAnalyser: IZStatementAnalyser;
begin
  if Analyser = nil then
    Analyser := TZMySQLStatementAnalyser.Create;
  Result := Analyser;
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
function TZMySQLDatabaseMetadata.GetVersionColumns(Catalog, Schema,
  Table: string): IZResultSet;
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

  Result := CloneCachedResultSet(TargetResultSet);
end;

end.

