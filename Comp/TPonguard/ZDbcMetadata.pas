{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{           Abstract Database Connectivity Classes        }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{            Written by Sergey Seroukhov                  }
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

unit ZDbcMetadata;

interface

{$I ZDbc.inc}

uses
  Classes, SysUtils, ZSysUtils, ZClasses, ZDbcIntfs, ZTokenizer,
{$IFDEF VER130BELOW}
  Comobj,
{$ENDIF}
  ZDbcResultSetMetadata, ZDbcCachedResultSet, ZDbcCache, ZCompatibility,
  ZSelectSchema, ZGenericSqlToken, ZDbcConnection, ZGenericSqlAnalyser;

const
  procedureColumnUnknown = 0;
  procedureColumnIn = 1;
  procedureColumnInOut = 2;
  procedureColumnOut = 4;
  procedureColumnReturn = 5;
  procedureColumnResult = 3;
  procedureNoNulls = 0;
  procedureNullable = 1;
  procedureNullableUnknown = 2;


type

  {** Represents a Virtual ResultSet interface. }
  IZVirtualResultSet = interface(IZCachedResultSet)
    ['{D84055AC-BCD5-40CD-B408-6F11AF000C96}']
    procedure SetType(Value: TZResultSetType);
    procedure SetConcurrency(Value: TZResultSetConcurrency);
  end;

  {** Implements Virtual ResultSet. }
  TZVirtualResultSet = class(TZAbstractCachedResultSet, IZVirtualResultSet)
  protected
    procedure CalculateRowDefaults(RowAccessor: TZRowAccessor); override;
    procedure PostRowUpdates(OldRowAccessor, NewRowAccessor: TZRowAccessor);
      override;
  public
    constructor CreateWithStatement(SQL: string; Statement: IZStatement);
    constructor CreateWithColumns(ColumnsInfo: TObjectList; SQL: string);
    destructor Destroy; override;
  end;

  {** Implements Abstract Database Metadata. }
  TZAbstractDatabaseMetadata = class(TContainedObject, IZDatabaseMetadata)
  private
    FConnection: TZAbstractConnection;
    FUrl: string;
    FInfo: TStrings;
    FTokenizer: IZTokenizer;
    FAnalyser: IZStatementAnalyser;
    FCachedResultSets: IZHashMap;
  protected
    constructor Create(ParentConnection: TZAbstractConnection; Url: string;
      Info: TStrings);

    procedure AddResultSetToCache(Key: string; ResultSet: IZResultSet);
    function GetResultSetFromCache(Key: string): IZResultSet;
    function IsResultSetCached(ResultSet: IZResultSet): Boolean;
    function CloneCachedResultSet(ResultSet: IZResultSet): IZResultSet;

    function CreateColumnInfo(Name: string; SQLType: TZSQLType;
      Length: Integer): TZColumnInfo;
    function CreateVirtualResultSet(ColumnsInfo: TObjectList):
      IZVirtualResultSet;

    property Url: string read FUrl;
    property Info: TStrings read FInfo;
    property Tokenizer: IZTokenizer read FTokenizer write FTokenizer;
    property Analyser: IZStatementAnalyser read FAnalyser write FAnalyser;
    property CachedResultSets: IZHashMap read FCachedResultSets
      write FCachedResultSets;
  public
    destructor Destroy; override;

    function AllProceduresAreCallable: Boolean; virtual;
    function AllTablesAreSelectable: Boolean; virtual;
    function GetURL: string; virtual;
    function GetUserName: string; virtual;
    function IsReadOnly: Boolean; virtual;
    function NullsAreSortedHigh: Boolean; virtual;
    function NullsAreSortedLow: Boolean; virtual;
    function NullsAreSortedAtStart: Boolean; virtual;
    function NullsAreSortedAtEnd: Boolean; virtual;
    function GetDatabaseProductName: string; virtual;
    function GetDatabaseProductVersion: string; virtual;
    function GetDriverName: string; virtual;
    function GetDriverVersion: string; virtual;
    function GetDriverMajorVersion: Integer; virtual;
    function GetDriverMinorVersion: Integer; virtual;
    function UsesLocalFiles: Boolean; virtual;
    function UsesLocalFilePerTable: Boolean; virtual;
    function SupportsMixedCaseIdentifiers: Boolean; virtual;
    function StoresUpperCaseIdentifiers: Boolean; virtual;
    function StoresLowerCaseIdentifiers: Boolean; virtual;
    function StoresMixedCaseIdentifiers: Boolean; virtual;
    function SupportsMixedCaseQuotedIdentifiers: Boolean; virtual;
    function StoresUpperCaseQuotedIdentifiers: Boolean; virtual;
    function StoresLowerCaseQuotedIdentifiers: Boolean; virtual;
    function StoresMixedCaseQuotedIdentifiers: Boolean; virtual;
    function GetIdentifierQuoteString: string; virtual;
    function GetSQLKeywords: string; virtual;
    function GetNumericFunctions: string; virtual;
    function GetStringFunctions: string; virtual;
    function GetSystemFunctions: string; virtual;
    function GetTimeDateFunctions: string; virtual;
    function GetSearchStringEscape: string; virtual;
    function GetExtraNameCharacters: string; virtual;

    function SupportsAlterTableWithAddColumn: Boolean; virtual;
    function SupportsAlterTableWithDropColumn: Boolean; virtual;
    function SupportsColumnAliasing: Boolean; virtual;
    function NullPlusNonNullIsNull: Boolean; virtual;
    function SupportsConvert: Boolean; virtual;
    function SupportsConvertForTypes(FromType: TZSQLType; ToType: TZSQLType):
      Boolean; virtual;
    function SupportsTableCorrelationNames: Boolean; virtual;
    function SupportsDifferentTableCorrelationNames: Boolean; virtual;
    function SupportsExpressionsInOrderBy: Boolean; virtual;
    function SupportsOrderByUnrelated: Boolean; virtual;
    function SupportsGroupBy: Boolean; virtual;
    function SupportsGroupByUnrelated: Boolean; virtual;
    function SupportsGroupByBeyondSelect: Boolean; virtual;
    function SupportsLikeEscapeClause: Boolean; virtual;
    function SupportsMultipleResultSets: Boolean; virtual;
    function SupportsMultipleTransactions: Boolean; virtual;
    function SupportsNonNullableColumns: Boolean; virtual;
    function SupportsMinimumSQLGrammar: Boolean; virtual;
    function SupportsCoreSQLGrammar: Boolean; virtual;
    function SupportsExtendedSQLGrammar: Boolean; virtual;
    function SupportsANSI92EntryLevelSQL: Boolean; virtual;
    function SupportsANSI92IntermediateSQL: Boolean; virtual;
    function SupportsANSI92FullSQL: Boolean; virtual;
    function SupportsIntegrityEnhancementFacility: Boolean; virtual;
    function SupportsOuterJoins: Boolean; virtual;
    function SupportsFullOuterJoins: Boolean; virtual;
    function SupportsLimitedOuterJoins: Boolean; virtual;
    function GetSchemaTerm: string; virtual;
    function GetProcedureTerm: string; virtual;
    function GetCatalogTerm: string; virtual;
    function IsCatalogAtStart: Boolean; virtual;
    function GetCatalogSeparator: string; virtual;
    function SupportsSchemasInDataManipulation: Boolean; virtual;
    function SupportsSchemasInProcedureCalls: Boolean; virtual;
    function SupportsSchemasInTableDefinitions: Boolean; virtual;
    function SupportsSchemasInIndexDefinitions: Boolean; virtual;
    function SupportsSchemasInPrivilegeDefinitions: Boolean; virtual;
    function SupportsCatalogsInDataManipulation: Boolean; virtual;
    function SupportsCatalogsInProcedureCalls: Boolean; virtual;
    function SupportsCatalogsInTableDefinitions: Boolean; virtual;
    function SupportsCatalogsInIndexDefinitions: Boolean; virtual;
    function SupportsCatalogsInPrivilegeDefinitions: Boolean; virtual;
    function SupportsPositionedDelete: Boolean; virtual;
    function SupportsPositionedUpdate: Boolean; virtual;
    function SupportsSelectForUpdate: Boolean; virtual;
    function SupportsStoredProcedures: Boolean; virtual;
    function SupportsSubqueriesInComparisons: Boolean; virtual;
    function SupportsSubqueriesInExists: Boolean; virtual;
    function SupportsSubqueriesInIns: Boolean; virtual;
    function SupportsSubqueriesInQuantifieds: Boolean; virtual;
    function SupportsCorrelatedSubqueries: Boolean; virtual;
    function SupportsUnion: Boolean; virtual;
    function SupportsUnionAll: Boolean;  virtual;
    function SupportsOpenCursorsAcrossCommit: Boolean; virtual;
    function SupportsOpenCursorsAcrossRollback: Boolean; virtual;
    function SupportsOpenStatementsAcrossCommit: Boolean; virtual;
    function SupportsOpenStatementsAcrossRollback: Boolean; virtual;

    function GetMaxBinaryLiteralLength: Integer; virtual;
    function GetMaxCharLiteralLength: Integer; virtual;
    function GetMaxColumnNameLength: Integer; virtual;
    function GetMaxColumnsInGroupBy: Integer; virtual;
    function GetMaxColumnsInIndex: Integer; virtual;
    function GetMaxColumnsInOrderBy: Integer; virtual;
    function GetMaxColumnsInSelect: Integer; virtual;
    function GetMaxColumnsInTable: Integer; virtual;
    function GetMaxConnections: Integer; virtual;
    function GetMaxCursorNameLength: Integer; virtual;
    function GetMaxIndexLength: Integer; virtual;
    function GetMaxSchemaNameLength: Integer; virtual;
    function GetMaxProcedureNameLength: Integer; virtual;
    function GetMaxCatalogNameLength: Integer; virtual;
    function GetMaxRowSize: Integer; virtual;
    function DoesMaxRowSizeIncludeBlobs: Boolean; virtual;
    function GetMaxStatementLength: Integer; virtual;
    function GetMaxStatements: Integer; virtual;
    function GetMaxTableNameLength: Integer; virtual;
    function GetMaxTablesInSelect: Integer; virtual;
    function GetMaxUserNameLength: Integer; virtual;

    function GetDefaultTransactionIsolation: TZTransactIsolationLevel; virtual;
    function SupportsTransactions: Boolean; virtual;
    function SupportsTransactionIsolationLevel(Level: TZTransactIsolationLevel):
      Boolean; virtual;
    function SupportsDataDefinitionAndDataManipulationTransactions: Boolean; virtual;
    function SupportsDataManipulationTransactionsOnly: Boolean; virtual;
    function DataDefinitionCausesTransactionCommit: Boolean; virtual;
    function DataDefinitionIgnoredInTransactions: Boolean; virtual;

    function GetProcedures(Catalog: string; SchemaPattern: string;
      ProcedureNamePattern: string): IZResultSet; virtual;
    function GetProcedureColumns(Catalog: string; SchemaPattern: string;
      ProcedureNamePattern: string; ColumnNamePattern: string):
      IZResultSet; virtual;

    function GetTables(Catalog: string; SchemaPattern: string;
      TableNamePattern: string; Types: TStringDynArray): IZResultSet; virtual;
    function GetSchemas: IZResultSet; virtual;
    function GetCatalogs: IZResultSet; virtual;
    function GetTableTypes: IZResultSet; virtual;
    function GetColumns(Catalog: string; SchemaPattern: string;
      TableNamePattern: string; ColumnNamePattern: string): IZResultSet; virtual;
    function GetColumnPrivileges(Catalog: string; Schema: string;
      Table: string; ColumnNamePattern: string): IZResultSet; virtual;

    function GetTablePrivileges(Catalog: string; SchemaPattern: string;
      TableNamePattern: string): IZResultSet; virtual;
    function GetBestRowIdentifier(Catalog: string; Schema: string;
      Table: string; Scope: Integer; Nullable: Boolean): IZResultSet; virtual;
    function GetVersionColumns(Catalog: string; Schema: string;
      Table: string): IZResultSet; virtual;

    function GetPrimaryKeys(Catalog: string; Schema: string;
      Table: string): IZResultSet; virtual;
    function GetImportedKeys(Catalog: string; Schema: string;
      Table: string): IZResultSet; virtual;
    function GetExportedKeys(Catalog: string; Schema: string;
      Table: string): IZResultSet; virtual;
    function GetCrossReference(PrimaryCatalog: string; PrimarySchema: string;
      PrimaryTable: string; ForeignCatalog: string; ForeignSchema: string;
      ForeignTable: string): IZResultSet; virtual;

    function GetTypeInfo: IZResultSet; virtual;

    function GetIndexInfo(Catalog: string; Schema: string; Table: string;
      Unique: Boolean; Approximate: Boolean): IZResultSet; virtual;

    function SupportsResultSetType(_Type: TZResultSetType): Boolean; virtual;
    function SupportsResultSetConcurrency(_Type: TZResultSetType;
      Concurrency: TZResultSetConcurrency): Boolean; virtual;
    function SupportsBatchUpdates: Boolean; virtual;

    function GetUDTs(Catalog: string; SchemaPattern: string;
      TypeNamePattern: string; Types: TIntegerDynArray): IZResultSet; virtual;

    function GetConnection: IZConnection; virtual;

    function GetTokenizer: IZTokenizer; virtual;
    function GetStatementAnalyser: IZStatementAnalyser; virtual;
    function GetIdentifierConvertor: IZIdentifierConvertor; virtual;
    procedure ClearCache; virtual;
  end;

  {** Implements a default Case Sensitive/Unsensitive identifier convertor. }
  TZDefaultIdentifierConvertor = class (TZAbstractObject,
    IZIdentifierConvertor)
  private
    FMetadata: IZDatabaseMetadata;
  protected
    property Metadata: IZDatabaseMetadata read FMetadata write FMetadata;

    function IsLowerCase(Value: string): Boolean;
    function IsUpperCase(Value: string): Boolean;
    function IsSpecialCase(Value: string): Boolean;
  public
    constructor Create(Metadata: IZDatabaseMetadata);

    function IsCaseSensitive(Value: string): Boolean;
    function IsQuoted(Value: string): Boolean;
    function Quote(Value: string): string;
    function ExtractQuote(Value: string): string;
  end;

implementation

uses ZVariant, ZCollections;

{ TZAbstractDatabaseMetadata }

{**
  Constructs this object and assignes the main properties.
  @param Connection a database connection object.
  @param Url a database connection url string.
  @param Info an extra connection properties.
}
constructor TZAbstractDatabaseMetadata.Create(
  ParentConnection: TZAbstractConnection; Url: string; Info: TStrings);
begin
  inherited Create(ParentConnection);
  FConnection := ParentConnection;
  FUrl := Url;
  FInfo := Info;
  FCachedResultSets := TZHashMap.Create;
end;

{**
  Destroys this object and cleanups the memory.
}
destructor TZAbstractDatabaseMetadata.Destroy;
begin
  FCachedResultSets.Clear;
  FCachedResultSets := nil;
  
  inherited Destroy;
end;

{**
  Retrieves the connection that produced this metadata object.
  @return the connection that produced this metadata object
}
function TZAbstractDatabaseMetadata.GetConnection: IZConnection;
begin
  Result := IZConnection(FConnection);
end;

{**
  Creates a column information object.
  @param Name the column label.
  @param SQLType an SQL type of the column.
  @param Length the length of the column.
  @return a created column information object.
}
function TZAbstractDatabaseMetadata.CreateColumnInfo(Name: string;
  SQLType: TZSQLType; Length: Integer): TZColumnInfo;
begin
  Result := TZColumnInfo.Create;
  with Result do
  begin
    ColumnLabel := Name;
    ColumnType := SQLType;
    ColumnDisplaySize := Length;
    Precision := Length;
  end;
end;

{**
  Create a virtual result set object.
  @param ColumnsInfo a collection of column description objects.
  @return a created result set.
}
function TZAbstractDatabaseMetadata.CreateVirtualResultSet(
  ColumnsInfo: TObjectList): IZVirtualResultSet;
begin
  Result := TZVirtualResultSet.CreateWithColumns(ColumnsInfo, '');
  with Result do
  begin
    SetType(rtScrollInsensitive);
    SetConcurrency(rcUpdatable);
  end;
end;

{**
  Clears all cached metadata.
}
procedure TZAbstractDatabaseMetadata.ClearCache;
begin
  FCachedResultSets.Clear;
end;

{**
  Adds resultset to the internal cache.
  @param Key a resultset unique key value.
  @param ResultSet a resultset interface.
}
procedure TZAbstractDatabaseMetadata.AddResultSetToCache(Key: string;
  ResultSet: IZResultSet);
var
  TempKey: IZAnyValue;
begin
  TempKey := TZAnyValue.CreateWithString(Key);
  FCachedResultSets.Put(TempKey, ResultSet);
end;

{**
  Gets a resultset interface from the internal cache by key.
  @param Key a resultset unique key value.
  @returns a cached resultset interface or <code>nil</code> otherwise.
}
function TZAbstractDatabaseMetadata.GetResultSetFromCache(
  Key: string): IZResultSet;
var
  TempKey: IZAnyValue;
begin
  TempKey := TZAnyValue.CreateWithString(Key);
  Result := FCachedResultSets.Get(TempKey) as IZResultSet;
  if Result <> nil then
    Result := CloneCachedResultSet(Result);
end;

{**
  Checks is the resultset stored in the internal cache.
  @param ResultSet the resultset interface.
  @returns <code>True</code> is resultset is cached.
}
function TZAbstractDatabaseMetadata.IsResultSetCached(
  ResultSet: IZResultSet): Boolean;
begin
  Result := ResultSet.Next;
  ResultSet.BeforeFirst;
end;

{**
  Clones the cached resultset.
  @param ResultSet the resultset to be cloned.
  @returns the clone of the specified resultset.
}
function TZAbstractDatabaseMetadata.CloneCachedResultSet(
  ResultSet: IZResultSet): IZResultSet;
var
  I: Integer;
  Metadata: IZResultSetMetadata;
  ColumnsInfo: TObjectList;
begin
  Result := nil;
  Metadata := ResultSet.GetMetadata;
  ColumnsInfo := TObjectList.Create;
  try
    for I := 1 to Metadata.GetColumnCount do
    begin
      ColumnsInfo.Add(CreateColumnInfo(Metadata.GetColumnLabel(I),
        Metadata.GetColumnType(I), Metadata.GetPrecision(I)));
    end;
    Result := CreateVirtualResultSet(ColumnsInfo);
  finally
    ColumnsInfo.Free;
  end;

  (Result as IZVirtualResultSet).SetConcurrency(rcUpdatable);
  ResultSet.BeforeFirst;

  while ResultSet.Next do
  begin
    Result.MoveToInsertRow;
    for I := 1 to Metadata.GetColumnCount do
    begin
      case Metadata.GetColumnType(I) of
        stBoolean:
          Result.UpdateBoolean(I, ResultSet.GetBoolean(I));
        stByte:
          Result.UpdateByte(I, ResultSet.GetByte(I));
        stShort:
          Result.UpdateShort(I, ResultSet.GetShort(I));
        stInteger:
          Result.UpdateInt(I, ResultSet.GetInt(I));
        stLong:
          Result.UpdateLong(I, ResultSet.GetLong(I));
        stFloat:
          Result.UpdateFloat(I, ResultSet.GetFloat(I));
        stDouble:
          Result.UpdateDouble(I, ResultSet.GetDouble(I));
        stBigDecimal:
          Result.UpdateBigDecimal(I, ResultSet.GetBigDecimal(I));
        stString:
          Result.UpdateString(I, ResultSet.GetString(I));
        stUnicodeString:
          Result.UpdateUnicodeString(I, ResultSet.GetUnicodeString(I));
        stBytes:
          Result.UpdateBytes(I, ResultSet.GetBytes(I));
        stDate:
          Result.UpdateDate(I, ResultSet.GetDate(I));
        stTime:
          Result.UpdateTime(I, ResultSet.GetTime(I));
        stTimestamp:
          Result.UpdateTimestamp(I, ResultSet.GetTimestamp(I));
        stAsciiStream,
        stUnicodeStream,
        stBinaryStream:
          Result.UpdateString(I, ResultSet.GetString(I));
      end;
      if ResultSet.WasNull then
        Result.UpdateNull(I);
    end;
    Result.InsertRow;
  end;

  (Result as IZVirtualResultSet).SetConcurrency(rcReadOnly);
  Result.BeforeFirst;
end;

//----------------------------------------------------------------------
// First, a variety of minor information about the target database.

{**
  Can all the procedures returned by getProcedures be called by the
  current user?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.AllProceduresAreCallable: Boolean;
begin
  Result := True;
end;

{**
  Can all the tables returned by getTable be SELECTed by the
  current user?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.AllTablesAreSelectable: Boolean;
begin
  Result := True;
end;

{**
  What's the url for this database?
  @return the url or null if it cannot be generated
}
function TZAbstractDatabaseMetadata.GetURL: string;
begin
  Result := FUrl;
end;

{**
  What's our user name as known to the database?
  @return our database user name
}
function TZAbstractDatabaseMetadata.GetUserName: string;
begin
  Result := FInfo.Values['UID'];
  if Result = '' then
    Result := FInfo.Values['username'];
end;

{**
  Is the database in read-only mode?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.IsReadOnly: Boolean;
begin
  Result := False;
end;

{**
  Are NULL values sorted high?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.NullsAreSortedHigh: Boolean;
begin
  Result := False;
end;

{**
  Are NULL values sorted low?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.NullsAreSortedLow: Boolean;
begin
  Result := False;
end;

{**
  Are NULL values sorted at the start regardless of sort order?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.NullsAreSortedAtStart: Boolean;
begin
  Result := False;
end;

{**
  Are NULL values sorted at the end regardless of sort order?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.NullsAreSortedAtEnd: Boolean;
begin
  Result := False;
end;

{**
  What's the name of this database product?
  @return database product name
}
function TZAbstractDatabaseMetadata.GetDatabaseProductName: string;
begin
  Result := '';
end;

{**
  What's the version of this database product?
  @return database version
}
function TZAbstractDatabaseMetadata.GetDatabaseProductVersion: string;
begin
  Result := '';
end;

{**
  What's the name of this JDBC driver?
  @return JDBC driver name
}
function TZAbstractDatabaseMetadata.GetDriverName: string;
begin
  Result := 'Zeos Database Connectivity Driver';
end;

{**
  What's the version of this JDBC driver?
  @return JDBC driver version
}
function TZAbstractDatabaseMetadata.GetDriverVersion: string;
begin
  Result := Format('%d.%d', [GetDriverMajorVersion, GetDriverMinorVersion]);
end;

{**
  What's this JDBC driver's major version number?
  @return JDBC driver major version
}
function TZAbstractDatabaseMetadata.GetDriverMajorVersion: Integer;
begin
  Result := 1;
end;

{**
  What's this JDBC driver's minor version number?
  @return JDBC driver minor version number
}
function TZAbstractDatabaseMetadata.GetDriverMinorVersion: Integer;
begin
  Result := 0;
end;

{**
  Does the database store tables in a local file?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.UsesLocalFiles: Boolean;
begin
  Result := True;
end;

{**
  Does the database use a file for each table?
  @return true if the database uses a local file for each table
}
function TZAbstractDatabaseMetadata.UsesLocalFilePerTable: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case sensitive and as a result store them in mixed case?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver will always return false.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsMixedCaseIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in upper case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.StoresUpperCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in lower case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.StoresLowerCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case unquoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.StoresMixedCaseIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case sensitive and as a result store them in mixed case?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver will always return true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsMixedCaseQuotedIdentifiers: Boolean;
begin
  Result := True;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in upper case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.StoresUpperCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in lower case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.StoresLowerCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  Does the database treat mixed case quoted SQL identifiers as
  case insensitive and store them in mixed case?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.StoresMixedCaseQuotedIdentifiers: Boolean;
begin
  Result := False;
end;

{**
  What's the string used to quote SQL identifiers?
  This returns a space " " if identifier quoting isn't supported.
  A JDBC Compliant<sup><font size=-2>TM</font></sup>
  driver always uses a double quote character.
  @return the quoting string
}
function TZAbstractDatabaseMetadata.GetIdentifierQuoteString: string;
begin
  Result := '"';
end;

{**
  Gets a comma-separated list of all a database's SQL keywords
  that are NOT also SQL92 keywords.
  @return the list
}
function TZAbstractDatabaseMetadata.GetSQLKeywords: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of math functions.  These are the
  X/Open CLI math function names used in the JDBC function escape
  clause.
  @return the list
}
function TZAbstractDatabaseMetadata.GetNumericFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of string functions.  These are the
  X/Open CLI string function names used in the JDBC function escape
  clause.
  @return the list
}
function TZAbstractDatabaseMetadata.GetStringFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of system functions.  These are the
  X/Open CLI system function names used in the JDBC function escape
  clause.
  @return the list
}
function TZAbstractDatabaseMetadata.GetSystemFunctions: string;
begin
  Result := '';
end;

{**
  Gets a comma-separated list of time and date functions.
  @return the list
}
function TZAbstractDatabaseMetadata.GetTimeDateFunctions: string;
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
function TZAbstractDatabaseMetadata.GetSearchStringEscape: string;
begin
  Result := '%';
end;

{**
  Gets all the "extra" characters that can be used in unquoted
  identifier names (those beyond a-z, A-Z, 0-9 and _).
  @return the string containing the extra characters
}
function TZAbstractDatabaseMetadata.GetExtraNameCharacters: string;
begin
  Result := '';
end;

//--------------------------------------------------------------------
// Functions describing which features are supported.

{**
  Is "ALTER TABLE" with add column supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsAlterTableWithAddColumn: Boolean;
begin
  Result := True;
end;

{**
  Is "ALTER TABLE" with drop column supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsAlterTableWithDropColumn: Boolean;
begin
  Result := True;
end;

{**
  Is column aliasing supported?

  <P>If so, the SQL AS clause can be used to provide names for
  computed columns or to provide alias names for columns as
  required.
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsColumnAliasing: Boolean;
begin
  Result := True;
end;

{**
  Are concatenations between NULL and non-NULL values NULL?
  For SQL-92 compliance, a JDBC technology-enabled driver will
  return <code>true</code>.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.NullPlusNonNullIsNull: Boolean;
begin
  Result := True;
end;

{**
  Is the CONVERT function between SQL types supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsConvert: Boolean;
begin
  Result := False;
end;

{**
  Is CONVERT between the given SQL types supported?
  @param fromType the type to convert from
  @param toType the type to convert to
  @return <code>true</code> if so; <code>false</code> otherwise
  @see Types
}
function TZAbstractDatabaseMetadata.SupportsConvertForTypes(
  FromType: TZSQLType; ToType: TZSQLType): Boolean;
begin
  Result := False;
end;

{**
  Are table correlation names supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsTableCorrelationNames: Boolean;
begin
  Result := True;
end;

{**
  If table correlation names are supported, are they restricted
  to be different from the names of the tables?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsDifferentTableCorrelationNames: Boolean;
begin
  Result := False;
end;

{**
  Are expressions in "ORDER BY" lists supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsExpressionsInOrderBy: Boolean;
begin
  Result := True;
end;

{**
  Can an "ORDER BY" clause use columns not in the SELECT statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsOrderByUnrelated: Boolean;
begin
  Result := True;
end;

{**
  Is some form of "GROUP BY" clause supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsGroupBy: Boolean;
begin
  Result := True;
end;

{**
  Can a "GROUP BY" clause use columns not in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsGroupByUnrelated: Boolean;
begin
  Result := True;
end;

{**
  Can a "GROUP BY" clause add columns not in the SELECT
  provided it specifies all the columns in the SELECT?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsGroupByBeyondSelect: Boolean;
begin
  Result := False;
end;

{**
  Is the escape character in "LIKE" clauses supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsLikeEscapeClause: Boolean;
begin
  Result := True;
end;

{**
  Are multiple <code>ResultSet</code> from a single execute supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsMultipleResultSets: Boolean;
begin
  Result := True;
end;

{**
  Can we have multiple transactions open at once (on different
  connections)?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsMultipleTransactions: Boolean;
begin
  Result := True;
end;

{**
  Can columns be defined as non-nullable?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsNonNullableColumns: Boolean;
begin
  Result := True;
end;

{**
  Is the ODBC Minimum SQL grammar supported?
  All JDBC Compliant<sup><font size=-2>TM</font></sup> drivers must return true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsMinimumSQLGrammar: Boolean;
begin
  Result := True;
end;

{**
  Is the ODBC Core SQL grammar supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCoreSQLGrammar: Boolean;
begin
  Result := True;
end;

{**
  Is the ODBC Extended SQL grammar supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsExtendedSQLGrammar: Boolean;
begin
  Result := True;
end;

{**
  Is the ANSI92 entry level SQL grammar supported?
  All JDBC Compliant<sup><font size=-2>TM</font></sup> drivers must return true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsANSI92EntryLevelSQL: Boolean;
begin
  Result := True;
end;

{**
  Is the ANSI92 intermediate SQL grammar supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsANSI92IntermediateSQL: Boolean;
begin
  Result := True;
end;

{**
  Is the ANSI92 full SQL grammar supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsANSI92FullSQL: Boolean;
begin
  Result := True;
end;

{**
  Is the SQL Integrity Enhancement Facility supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsIntegrityEnhancementFacility: Boolean;
begin
  Result := False;
end;

{**
  Is some form of outer join supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsOuterJoins: Boolean;
begin
  Result := True;
end;

{**
  Are full nested outer joins supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsFullOuterJoins: Boolean;
begin
  Result := True;
end;

{**
  Is there limited support for outer joins?  (This will be true
  if supportFullOuterJoins is true.)
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsLimitedOuterJoins: Boolean;
begin
  Result := True;
end;

{**
  What's the database vendor's preferred term for "schema"?
  @return the vendor term
}
function TZAbstractDatabaseMetadata.GetSchemaTerm: string;
begin
  Result := 'Schema';
end;

{**
  What's the database vendor's preferred term for "procedure"?
  @return the vendor term
}
function TZAbstractDatabaseMetadata.GetProcedureTerm: string;
begin
  Result := 'Procedure';
end;

{**
  What's the database vendor's preferred term for "catalog"?
  @return the vendor term
}
function TZAbstractDatabaseMetadata.GetCatalogTerm: string;
begin
  Result := 'Catalog';
end;

{**
  Does a catalog appear at the start of a qualified table name?
  (Otherwise it appears at the end)
  @return true if it appears at the start
}
function TZAbstractDatabaseMetadata.IsCatalogAtStart: Boolean;
begin
  Result := False;
end;

{**
  What's the separator between catalog and table name?
  @return the separator string
}
function TZAbstractDatabaseMetadata.GetCatalogSeparator: string;
begin
  Result := '.';
end;

{**
  Can a schema name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSchemasInDataManipulation: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in a procedure call statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSchemasInProcedureCalls: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSchemasInTableDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in an index definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSchemasInIndexDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a schema name be used in a privilege definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSchemasInPrivilegeDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a data manipulation statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCatalogsInDataManipulation: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a procedure call statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCatalogsInProcedureCalls: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a table definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCatalogsInTableDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in an index definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCatalogsInIndexDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Can a catalog name be used in a privilege definition statement?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCatalogsInPrivilegeDefinitions: Boolean;
begin
  Result := False;
end;

{**
  Is positioned DELETE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsPositionedDelete: Boolean;
begin
  Result := False;
end;

{**
  Is positioned UPDATE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsPositionedUpdate: Boolean;
begin
  Result := False;
end;

{**
  Is SELECT for UPDATE supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSelectForUpdate: Boolean;
begin
  Result := False;
end;

{**
  Are stored procedure calls using the stored procedure escape
  syntax supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsStoredProcedures: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in comparison expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSubqueriesInComparisons: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in 'exists' expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSubqueriesInExists: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in 'in' statements supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSubqueriesInIns: Boolean;
begin
  Result := False;
end;

{**
  Are subqueries in quantified expressions supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsSubqueriesInQuantifieds: Boolean;
begin
  Result := False;
end;

{**
  Are correlated subqueries supported?
  A JDBC Compliant<sup><font size=-2>TM</font></sup> driver always returns true.
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsCorrelatedSubqueries: Boolean;
begin
  Result := False;
end;

{**
  Is SQL UNION supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsUnion: Boolean;
begin
  Result := False;
end;

{**
  Is SQL UNION ALL supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsUnionAll: Boolean;
begin
  Result := False;
end;

{**
  Can cursors remain open across commits?
  @return <code>true</code> if cursors always remain open;
        <code>false</code> if they might not remain open
}
function TZAbstractDatabaseMetadata.SupportsOpenCursorsAcrossCommit: Boolean;
begin
  Result := False;
end;

{**
  Can cursors remain open across rollbacks?
  @return <code>true</code> if cursors always remain open;
        <code>false</code> if they might not remain open
}
function TZAbstractDatabaseMetadata.SupportsOpenCursorsAcrossRollback: Boolean;
begin
  Result := False;
end;

{**
  Can statements remain open across commits?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZAbstractDatabaseMetadata.SupportsOpenStatementsAcrossCommit: Boolean;
begin
  Result := True;
end;

{**
  Can statements remain open across rollbacks?
  @return <code>true</code> if statements always remain open;
        <code>false</code> if they might not remain open
}
function TZAbstractDatabaseMetadata.SupportsOpenStatementsAcrossRollback: Boolean;
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
function TZAbstractDatabaseMetadata.GetMaxBinaryLiteralLength: Integer;
begin
  Result := 0;
end;

{**
  What's the max length for a character literal?
  @return max literal length;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxCharLiteralLength: Integer;
begin
  Result := 0;
end;

{**
  What's the limit on column name length?
  @return max column name length;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxColumnNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns in a "GROUP BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxColumnsInGroupBy: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns allowed in an index?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxColumnsInIndex: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns in an "ORDER BY" clause?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxColumnsInOrderBy: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns in a "SELECT" list?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxColumnsInSelect: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of columns in a table?
  @return max number of columns;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxColumnsInTable: Integer;
begin
  Result := 0;
end;

{**
  How many active connections can we have at a time to this database?
  @return max number of active connections;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxConnections: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum cursor name length?
  @return max cursor name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxCursorNameLength: Integer;
begin
  Result := 0;
end;

{**
  Retrieves the maximum number of bytes for an index, including all
  of the parts of the index.
  @return max index length in bytes, which includes the composite of all
   the constituent parts of the index;
   a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxIndexLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length allowed for a schema name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxSchemaNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a procedure name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxProcedureNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a catalog name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxCatalogNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a single row?
  @return max row size in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxRowSize: Integer;
begin
  Result := 0;
end;

{**
  Did getMaxRowSize() include LONGVARCHAR and LONGVARBINARY
  blobs?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.DoesMaxRowSizeIncludeBlobs: Boolean;
begin
  Result := True;
end;

{**
  What's the maximum length of an SQL statement?
  @return max length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxStatementLength: Integer;
begin
  Result := 0;
end;

{**
  How many active statements can we have open at one time to this
  database?
  @return the maximum number of statements that can be open at one time;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxStatements: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a table name?
  @return max name length in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxTableNameLength: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum number of tables in a SELECT statement?
  @return the maximum number of tables allowed in a SELECT statement;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxTablesInSelect: Integer;
begin
  Result := 0;
end;

{**
  What's the maximum length of a user name?
  @return max user name length  in bytes;
       a result of zero means that there is no limit or the limit is not known
}
function TZAbstractDatabaseMetadata.GetMaxUserNameLength: Integer;
begin
  Result := 0;
end;

//----------------------------------------------------------------------

{**
  What's the database's default transaction isolation level?  The
  values are defined in <code>java.sql.Connection</code>.
  @return the default isolation level
  @see Connection
}
function TZAbstractDatabaseMetadata.GetDefaultTransactionIsolation:
  TZTransactIsolationLevel;
begin
  Result := tiReadCommitted;
end;

{**
  Are transactions supported? If not, invoking the method
  <code>commit</code> is a noop and the isolation level is TRANSACTION_NONE.
  @return <code>true</code> if transactions are supported; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsTransactions: Boolean;
begin
  Result := True;
end;

{**
  Does this database support the given transaction isolation level?
  @param level the values are defined in <code>java.sql.Connection</code>
  @return <code>true</code> if so; <code>false</code> otherwise
  @see Connection
}
function TZAbstractDatabaseMetadata.SupportsTransactionIsolationLevel(
  Level: TZTransactIsolationLevel): Boolean;
begin
  Result := True;
end;

{**
  Are both data definition and data manipulation statements
  within a transaction supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.
  SupportsDataDefinitionAndDataManipulationTransactions: Boolean;
begin
  Result := True;
end;

{**
  Are only data manipulation statements within a transaction
  supported?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.
  SupportsDataManipulationTransactionsOnly: Boolean;
begin
  Result := False;
end;

{**
  Does a data definition statement within a transaction force the
  transaction to commit?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.DataDefinitionCausesTransactionCommit: Boolean;
begin
  Result := True;
end;

{**
  Is a data definition statement within a transaction ignored?
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.DataDefinitionIgnoredInTransactions: Boolean;
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
function TZAbstractDatabaseMetadata.GetProcedures(Catalog: string;
  SchemaPattern: string; ProcedureNamePattern: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet:  IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-procedures:%s:%s:%s',
    [Catalog, SchemaPattern, ProcedureNamePattern]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('RESERVED1', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('RESERVED2', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('RESERVED3', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('REMARKS', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_TYPE', stShort, 0));
      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetProcedureColumns(Catalog: string;
  SchemaPattern: string; ProcedureNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-procedure-columns:%s:%s:%s:%s',
    [Catalog, SchemaPattern, ProcedureNamePattern, ColumnNamePattern]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PROCEDURE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('DATA_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PRECISION', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('LENGTH', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('SCALE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('RADIX', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('NULLABLE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('REMARKS', stString, 255));
      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetTables(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  Types: TStringDynArray): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  I: Integer;
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
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_TYPE', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('REMARKS', stString, 255));
      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
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
function TZAbstractDatabaseMetadata.GetSchemas: IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := 'get-schemas';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
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
function TZAbstractDatabaseMetadata.GetCatalogs: IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := 'get-catalogs';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
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
function TZAbstractDatabaseMetadata.GetTableTypes: IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := 'get-table-types';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_TYPE', stString, 255));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
//      TargetResultSet.MoveToInsertRow;
//      TargetResultSet.UpdateString(1, 'TABLE');
//      TargetResultSet.InsertRow;
      TargetResultSet.SetConcurrency(rcReadOnly);
      TargetResultSet.BeforeFirst;
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetColumns(Catalog: string;
  SchemaPattern: string; TableNamePattern: string;
  ColumnNamePattern: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-columns:%s:%s:%s:%s',
    [Catalog, SchemaPattern, TableNamePattern, ColumnNamePattern]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DATA_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_SIZE', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('BUFFER_LENGTH', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('DECIMAL_DIGITS', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('NUM_PREC_RADIX', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('NULLABLE', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('REMARKS', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_DEF', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('SQL_DATA_TYPE', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('SQL_DATETIME_SUB', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('CHAR_OCTET_LENGTH', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('ORDINAL_POSITION', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('IS_NULLABLE', stString, 255));

      ColumnsInfo.Add(CreateColumnInfo('AUTO_INCREMENT', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('CASE_SENSITIVE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('SEARCHABLE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('WRITABLE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('DEFINITELYWRITABLE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('READONLY', stBoolean, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetColumnPrivileges(Catalog: string;
  Schema: string; Table: string; ColumnNamePattern: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-column-privileges:%s:%s:%s:%s',
    [Catalog, Schema, Table, ColumnNamePattern]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('GRANTOR', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('GRANTEE', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PRIVILEGE', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('IS_GRANTABLE', stString, 255));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetTablePrivileges(Catalog: string;
  SchemaPattern: string; TableNamePattern: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-table-privileges:%s:%s:%s',
    [Catalog, SchemaPattern, TableNamePattern]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('GRANTOR', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('GRANTEE', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PRIVILEGE', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('IS_GRANTABLE', stString, 255));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetBestRowIdentifier(Catalog: string;
  Schema: string; Table: string; Scope: Integer; Nullable: Boolean): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-best-row-identifier:%s:%s:%s:%d:%s',
    [Catalog, Schema, Table, Scope, BoolToStr(Nullable)]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('SCOPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DATA_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_SIZE', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('BUFFER_LENGTH', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('DECIMAL_DIGITS', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('PSEUDO_COLUMN', stShort, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetVersionColumns(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-version-columns:%s:%s:%s',
    [Catalog, Schema, Table]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('SCOPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DATA_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_SIZE', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('BUFFER_LENGTH', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('DECIMAL_DIGITS', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('PSEUDO_COLUMN', stShort, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetPrimaryKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-primary-keys:%s:%s:%s',
    [Catalog, Schema, Table]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('KEY_SEQ', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('PK_NAME', stString, 255));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
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
function TZAbstractDatabaseMetadata.GetImportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-imported-keys:%s:%s:%s',
    [Catalog, Schema, Table]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKCOLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKCOLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('KEY_SEQ', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('UPDATE_RULE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('DELETE_RULE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('FK_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PK_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DEFERRABILITY', stShort, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetExportedKeys(Catalog: string;
  Schema: string; Table: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-exported-keys:%s:%s:%s',
    [Catalog, Schema, Table]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKCOLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKCOLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('KEY_SEQ', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('UPDATE_RULE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('DELETE_RULE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('FK_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PK_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DEFERRABILITY', stShort, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetCrossReference(PrimaryCatalog: string;
  PrimarySchema: string; PrimaryTable: string; ForeignCatalog: string;
  ForeignSchema: string; ForeignTable: string): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-cross-reference:%s:%s:%s:%s:%s:%s',
    [PrimaryCatalog, PrimarySchema, PrimaryTable, ForeignCatalog,
    ForeignSchema, ForeignTable]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKTABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PKCOLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKTABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('FKCOLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('KEY_SEQ', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('UPDATE_RULE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('DELETE_RULE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('FK_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('PK_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DEFERRABILITY', stShort, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetTypeInfo: IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := 'get-type-info';
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DATA_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('PRECISION', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('LITERAL_PREFIX', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('LITERAL_SUFFIX', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('CREATE_PARAMS', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('NULLABLE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('CASE_SENSITIVE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('SEARCHABLE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('UNSIGNED_ATTRIBUTE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('FIXED_PREC_SCALE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('AUTO_INCREMENT', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('LOCAL_TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('MINIMUM_SCALE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('MAXIMUM_SCALE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('SQL_DATA_TYPE', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('SQL_DATETIME_SUB', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('NUM_PREC_RADIX', stInteger, 0));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.GetIndexInfo(Catalog: string;
  Schema: string; Table: string; Unique: Boolean;
  Approximate: Boolean): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  Key: string;
begin
  Key := Format('get-index-info:%s:%s:%s:%s:%s',
    [Catalog, Schema, Table, BoolToStr(Unique), BoolToStr(Approximate)]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TABLE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TABLE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('NON_UNIQUE', stBoolean, 0));
      ColumnsInfo.Add(CreateColumnInfo('INDEX_QUALIFIER', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('INDEX_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('ORDINAL_POSITION', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('COLUMN_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('ASC_OR_DESC', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('CARDINALITY', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('PAGES', stInteger, 0));
      ColumnsInfo.Add(CreateColumnInfo('FILTER_CONDITION', stString, 255));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
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
function TZAbstractDatabaseMetadata.SupportsResultSetType(
  _Type: TZResultSetType): Boolean;
begin
  Result := True;
end;

{**
  Does the database support the concurrency type in combination
  with the given result set type?

  @param type defined in <code>java.sql.ResultSet</code>
  @param concurrency type defined in <code>java.sql.ResultSet</code>
  @return <code>true</code> if so; <code>false</code> otherwise
}
function TZAbstractDatabaseMetadata.SupportsResultSetConcurrency(
  _Type: TZResultSetType; Concurrency: TZResultSetConcurrency): Boolean;
begin
  Result := True;
end;

{**
  Indicates whether the driver supports batch updates.
  @return true if the driver supports batch updates; false otherwise
}
function TZAbstractDatabaseMetadata.SupportsBatchUpdates: Boolean;
begin
  Result := True;
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
function TZAbstractDatabaseMetadata.GetUDTs(Catalog: string;
  SchemaPattern: string; TypeNamePattern: string;
  Types: TIntegerDynArray): IZResultSet;
var
  ColumnsInfo: TObjectList;
  TargetResultSet: IZVirtualResultSet;
  I: Integer;
  Key, Temp: string;
begin
  Temp := '';
  for I := Low(Types) to High(Types) do
    Temp := Temp + ':' + IntToStr(Types[I]);
    
  Key := Format('get-udts:%s:%s:%s%s',
    [Catalog, SchemaPattern, TypeNamePattern, Temp]);
  Result := GetResultSetFromCache(Key);

  if Result = nil then
  begin
    ColumnsInfo := TObjectList.Create;
    try
      ColumnsInfo.Add(CreateColumnInfo('TYPE_CAT', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TYPE_SCHEM', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('TYPE_NAME', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('JAVA_CLASS', stString, 255));
      ColumnsInfo.Add(CreateColumnInfo('DATA_TYPE', stShort, 0));
      ColumnsInfo.Add(CreateColumnInfo('REMARKS', stString, 255));

      TargetResultSet := CreateVirtualResultSet(ColumnsInfo);
      TargetResultSet.SetConcurrency(rcReadOnly);
      Result := TargetResultSet;
      AddResultSetToCache(Key, Result);
    finally
      ColumnsInfo.Free;
    end;
  end;
end;

{**
  Creates a generic statement analyser object.
  @returns a generic statement analyser object.
}
function TZAbstractDatabaseMetadata.GetStatementAnalyser: IZStatementAnalyser;
begin
  if Analyser = nil then
    Analyser := TZGenericStatementAnalyser.Create;
  Result := Analyser;
end;

{**
  Creates a generic tokenizer object.
  @returns a created generic tokenizer object.
}
function TZAbstractDatabaseMetadata.GetTokenizer: IZTokenizer;
begin
  if Tokenizer = nil then
    Tokenizer := TZGenericSQLTokenizer.Create;
  Result := Tokenizer;
end;

{**
  Creates ab identifier convertor object.
  @returns an identifier convertor object.
}
function TZAbstractDatabaseMetadata.GetIdentifierConvertor:
  IZIdentifierConvertor;
begin
  Result := TZDefaultIdentifierConvertor.Create(Self);
end;

{ TZVirtualResultSet }

{**
  Creates this object and assignes the main properties.
  @param Statement an SQL statement object.
  @param SQL an SQL query string.
}
constructor TZVirtualResultSet.CreateWithStatement( SQL: string;
   Statement: IZStatement);
begin
  inherited CreateWithStatement(SQL, Statement);
end;

{**
  Creates this object and assignes the main properties.
  @param ColumnsInfo a columns info for cached rows.
  @param SQL an SQL query string.
}
constructor TZVirtualResultSet.CreateWithColumns(ColumnsInfo: TObjectList;
  SQL: string);
begin
  inherited CreateWithColumns(ColumnsInfo, SQL);
end;

{**
  Destroys this object and cleanups the memory.
}
destructor TZVirtualResultSet.Destroy;
begin
  inherited Destroy;
end;

{**
  Calculates column default values..
  @param RowAccessor a row accessor which contains new column values.
}
procedure TZVirtualResultSet.CalculateRowDefaults(RowAccessor: TZRowAccessor);
begin
end;

{**
  Post changes to database server.
  @param OldRowAccessor a row accessor which contains old column values.
  @param NewRowAccessor a row accessor which contains new or updated
    column values.
}
procedure TZVirtualResultSet.PostRowUpdates(OldRowAccessor,
  NewRowAccessor: TZRowAccessor);
begin
end;

{ TZDefaultIdentifierConvertor }

{**
  Constructs this default identifier convertor object.
  @param Metadata a database metadata interface.
}
constructor TZDefaultIdentifierConvertor.Create(
  Metadata: IZDatabaseMetadata);
begin
  inherited Create;
  FMetadata := Metadata;
end;

{**
  Checks is the specified string in lower case.
  @param an identifier string.
  @return <code>True</code> is the identifier string in lower case.
}
function TZDefaultIdentifierConvertor.IsLowerCase(Value: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(Value) do
  begin
    if not (Value[I] in ['a'..'z','0'..'9','_']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

{**
  Checks is the specified string in upper case.
  @param an identifier string.
  @return <code>True</code> is the identifier string in upper case.
}
function TZDefaultIdentifierConvertor.IsUpperCase(Value: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(Value) do
  begin
    if not (Value[I] in ['A'..'Z','0'..'9','_']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

{**
  Checks is the specified string in special case.
  @param an identifier string.
  @return <code>True</code> is the identifier string in mixed case.
}
function TZDefaultIdentifierConvertor.IsSpecialCase(Value: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to Length(Value) do
  begin
    if not (Value[I] in ['A'..'Z','a'..'z','0'..'9','_']) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{**
  Checks is the string case sensitive.
  @return <code>True</code> if the string case sensitive.
}
function TZDefaultIdentifierConvertor.IsCaseSensitive(Value: string): Boolean;
const
  AnsiSQLKeywords = 'insert,update,delete,select,drop,create,from,set,values,'
    + 'where,order,group,by,having,into,as,table,index,primary,key,on,is,null,'
    + 'char,varchar,integer,number';
var
  Keywords: string;
begin
  if Value = '' then
    Result := False
  else if IsSpecialCase(Value) then
    Result := True
  else if IsLowerCase(Value) then
    Result := not Metadata.StoresLowerCaseIdentifiers
  else if IsUpperCase(Value) then
    Result := not Metadata.StoresUpperCaseIdentifiers
  else
    Result := not Metadata.StoresMixedCaseIdentifiers;

  { Checks for reserved keywords. }
  if not Result then
  begin
    Keywords := ',' + AnsiSQLKeywords + ','
      + LowerCase(Metadata.GetSQLKeywords) + ',';
    Result := Pos(',' + LowerCase(Value) + ',', Keywords) > 0;
  end;
end;

{**
  Checks is the string quoted.
  @return <code>True</code> is the string quoted.
}
function TZDefaultIdentifierConvertor.IsQuoted(Value: string): Boolean;
var
  QuoteDelim: string;
begin
  QuoteDelim := Metadata.GetIdentifierQuoteString;
  Result := (QuoteDelim <> '') and (Value <> '') and (QuoteDelim[1] = Value[1]);
end;

{**
  Extracts the quote from the idenfitier string.
  @param an identifier string.
  @return a extracted and processed string.
}
function TZDefaultIdentifierConvertor.ExtractQuote(Value: string): string;
begin
  if IsQuoted(Value) then
  begin
    Result := Copy(Value, 2, Length(Value) - 2);
    if not Metadata.StoresMixedCaseQuotedIdentifiers then
    begin
      if Metadata.StoresLowerCaseQuotedIdentifiers then
        Result := LowerCase(Result)
      else if Metadata.StoresUpperCaseQuotedIdentifiers then
        Result := UpperCase(Result);
    end;
  end
  else
  begin
    Result := Value;
    if not Metadata.StoresMixedCaseIdentifiers then
    begin
      if Metadata.StoresLowerCaseIdentifiers then
        Result := LowerCase(Result)
      else if Metadata.StoresUpperCaseIdentifiers then
        Result := UpperCase(Result);
    end;
  end;
end;

{**
  Quotes the identifier string.
  @param an identifier string.
  @return a quoted string.
}
function TZDefaultIdentifierConvertor.Quote(Value: string): string;
var
  QuoteDelim: string;
begin
  Result := Value;
  if IsCaseSensitive(Value) then
  begin
    QuoteDelim := Metadata.GetIdentifierQuoteString;
    if Length(QuoteDelim) > 1 then
      Result := QuoteDelim[1] + Result + QuoteDelim[2]
    else if Length(QuoteDelim) = 1 then
      Result := QuoteDelim[1] + Result + QuoteDelim[1];
  end;
end;

end.
