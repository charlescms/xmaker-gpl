{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{                 ADO Specific Utilities                  }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{            Written by Janos Fegyverneki                 }
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

unit ZDbcAdoUtils;

interface

{$I ZDbc.inc}

uses Windows, Classes, SysUtils, ActiveX, ZDbcIntfs;

{**
  Converts a Ado native types into ZDBC SQL types.
  @param FieldType dblibc native field type.
  @return a SQL undepended type.
}
function ConvertAdoToSqlType(FieldType: SmallInt): TZSQLType;

{**
  Converts a Zeos type into ADO types.
  @param FieldType zeos field type.
  @return a ADO datatype.
}
function ConvertSqlTypeToAdo(FieldType: TZSQLType): Integer;

{**
  Converts a Variant type into ADO types.
  @param VT Variant datatype.
  @return a ADO datatype.
}
{$IFDEF VER130BELOW}
function ConvertVariantToAdo(VT: Integer): Integer;
{$ELSE}
function ConvertVariantToAdo(VT: TVarType): Integer;
{$ENDIF}

{**
  Converts a TZResultSetType type into ADO cursor type.
  @param ResultSetType.
  @return a ADO cursor type.
}
function ConvertResultSetTypeToAdo(ResultSetType: TZResultSetType): Integer;

{**
  Converts a TZResultSetConcurrency type into ADO lock type.
  @param ResultSetConcurrency.
  @return a ADO lock type.
}
function ConvertResultSetConcurrencyToAdo(ResultSetConcurrency: TZResultSetConcurrency): Integer;

{**
  Converts a OLEDB schema guid into ADO schema ID usable with OpenSchema.
  @param OleDBSchema schema guid.
  @return a ADO schema id.
}
function ConvertOleDBToAdoSchema(OleDBSchema: TGUID): Integer;

{**
  Brings up the ADO connection string builder dialog.
}
function PromptDataSource(Handle: THandle; InitialString: WideString): WideString;

{$IFDEF VER125BELOW}
const
  CLSID_DATALINKS: TGUID = '{2206CDB2-19C1-11D1-89E0-00C04FD7A829}'; {DataLinks}
  DBSCHEMA_ASSERTIONS: TGUID = '{C8B52210-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_CATALOGS: TGUID = '{C8B52211-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_CHARACTER_SETS: TGUID = '{C8B52212-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_COLLATIONS: TGUID = '{C8B52213-5CF3-11CE-ADE5-00AA0044773D}';              
  DBSCHEMA_COLUMNS: TGUID = '{C8B52214-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_CHECK_CONSTRAINTS: TGUID = '{C8B52215-5CF3-11CE-ADE5-00AA0044773D}';       
  DBSCHEMA_CONSTRAINT_COLUMN_USAGE: TGUID = '{C8B52216-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_CONSTRAINT_TABLE_USAGE: TGUID = '{C8B52217-5CF3-11CE-ADE5-00AA0044773D}';  
  DBSCHEMA_KEY_COLUMN_USAGE: TGUID = '{C8B52218-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_REFERENTIAL_CONSTRAINTS: TGUID = '{C8B52219-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_TABLE_CONSTRAINTS: TGUID = '{C8B5221A-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_COLUMN_DOMAIN_USAGE: TGUID = '{C8B5221B-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_INDEXES: TGUID = '{C8B5221E-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_COLUMN_PRIVILEGES: TGUID = '{C8B52221-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_TABLE_PRIVILEGES: TGUID = '{C8B52222-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_USAGE_PRIVILEGES: TGUID = '{C8B52223-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_PROCEDURES: TGUID = '{C8B52224-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_SCHEMATA: TGUID = '{C8B52225-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_SQL_LANGUAGES: TGUID = '{C8B52226-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_STATISTICS: TGUID = '{C8B52227-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_TABLES: TGUID = '{C8B52229-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_TRANSLATIONS: TGUID = '{C8B5222A-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_PROVIDER_TYPES: TGUID = '{C8B5222C-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_VIEWS: TGUID = '{C8B5222D-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_VIEW_COLUMN_USAGE: TGUID = '{C8B5222E-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_VIEW_TABLE_USAGE: TGUID = '{C8B5222F-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_PROCEDURE_PARAMETERS: TGUID = '{C8B522B8-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_FOREIGN_KEYS: TGUID = '{C8B522C4-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_PRIMARY_KEYS: TGUID = '{C8B522C5-5CF3-11CE-ADE5-00AA0044773D}';
  DBSCHEMA_PROCEDURE_COLUMNS: TGUID = '{C8B522C9-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_CUBES: TGUID = '{C8B522D8-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_DIMENSIONS: TGUID = '{C8B522D9-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_HIERARCHIES: TGUID = '{C8B522DA-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_LEVELS: TGUID = '{C8B522DB-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_MEASURES: TGUID = '{C8B522DC-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_PROPERTIES: TGUID = '{C8B522DD-5CF3-11CE-ADE5-00AA0044773D}';
  MDSCHEMA_MEMBERS: TGUID = '{C8B522DE-5CF3-11CE-ADE5-00AA0044773D}';
  DBPROPSET_TRUSTEE: TGUID = '{C8B522E1-5CF3-11CE-ADE5-00AA0044773D}';

  DBCOLUMNFLAGS_ISBOOKMARK = $00000001;     
  {$EXTERNALSYM DBCOLUMNFLAGS_ISBOOKMARK}
  DBCOLUMNFLAGS_MAYDEFER = $00000002;
  {$EXTERNALSYM DBCOLUMNFLAGS_MAYDEFER}     
  DBCOLUMNFLAGS_WRITE = $00000004;          
  {$EXTERNALSYM DBCOLUMNFLAGS_WRITE}        
  DBCOLUMNFLAGS_WRITEUNKNOWN = $00000008;   
  {$EXTERNALSYM DBCOLUMNFLAGS_WRITEUNKNOWN} 
  DBCOLUMNFLAGS_ISFIXEDLENGTH = $00000010;  
  {$EXTERNALSYM DBCOLUMNFLAGS_ISFIXEDLENGTH}
  DBCOLUMNFLAGS_ISNULLABLE = $00000020;     
  {$EXTERNALSYM DBCOLUMNFLAGS_ISNULLABLE}   
  DBCOLUMNFLAGS_MAYBENULL = $00000040;      
  {$EXTERNALSYM DBCOLUMNFLAGS_MAYBENULL}    
  DBCOLUMNFLAGS_ISLONG = $00000080;         
  {$EXTERNALSYM DBCOLUMNFLAGS_ISLONG}       
  DBCOLUMNFLAGS_ISROWID = $00000100;        
  {$EXTERNALSYM DBCOLUMNFLAGS_ISROWID}      
  DBCOLUMNFLAGS_ISROWVER = $00000200;       
  {$EXTERNALSYM DBCOLUMNFLAGS_ISROWVER}     
  DBCOLUMNFLAGS_CACHEDEFERRED = $00001000;  
  {$EXTERNALSYM DBCOLUMNFLAGS_CACHEDEFERRED}

  MAXBOUND = 65535; { High bound for arrays }
  DB_E_NOTPREPARED = HResult($80040E4A);


type
  DBCOLUMNFLAGS = LongWord;
  DBPARAMFLAGS = LongWord;
  DBTYPE = Word;
  DBPROPID = LongWord;
  DBPROPSTATUS = LongWord;
  DBPROPOPTIONS = LongWord;

  PDBIDName = ^TDBIDName;
  DBIDNAME = record            
    case Integer of            
      0: (pwszName: PWideChar);
      1: (ulPropid: LongWord);
  end;                         
  TDBIDName = DBIDNAME;
                               
  PDBIDGuid = ^TDBIDGuid;      
  DBIDGUID = record            
    case Integer of            
      0: (guid: TGUID);        
      1: (pguid: ^TGUID);      
  end;                         
  TDBIDGuid = DBIDGUID;        
  
  PPDBID = ^PDBID;     
  PDBID = ^DBID;       
  DBID = packed record 
    uGuid: DBIDGUID;
    eKind: LongWord;
    uName: DBIDNAME;   
  end;                 
  TDBID = DBID;        

  PDBColumnInfo = ^TDBColumnInfo;
  DBCOLUMNINFO = packed record
    pwszName: PWideChar;         
    pTypeInfo: ITypeInfo;
    iOrdinal: LongWord;
    dwFlags: DBCOLUMNFLAGS;
    ulColumnSize: LongWord;
    wType: DBTYPE;
    bPrecision: Byte;
    bScale: Byte;
    columnid: DBID;
  end;
  TDBColumnInfo = DBCOLUMNINFO;  

  PDBIDArray = ^TDBIDArray;
  TDBIDArray = array[0..MAXBOUND] of TDBID;

  PUintArray = ^TUintArray;               
  TUintArray = array[0..MAXBOUND] of LongWord;

  PDBParamInfo = ^TDBParamInfo;                         
  DBPARAMINFO = packed record                           
    dwFlags: DBPARAMFLAGS;
    iOrdinal: LongWord;
    pwszName: PWideChar;
    pTypeInfo: ITypeInfo;                               
    ulParamSize: LongWord;
    wType: DBTYPE;                                      
    bPrecision: Byte;                                   
    bScale: Byte;                                       
  end;
  TDBParamInfo = DBPARAMINFO;

  PDBParamInfoArray = ^TDBParamInfoArray;               
  TDBParamInfoArray = array[0..MAXBOUND] of DBPARAMINFO;

  PDBParamBindInfo = ^TDBParamBindInfo;                          
  DBPARAMBINDINFO = packed record                                
    pwszDataSourceType: PWideChar;                               
    pwszName: PWideChar;                                         
    ulParamSize: LongWord;
    dwFlags: DBPARAMFLAGS;                                       
    bPrecision: Byte;                                            
    bScale: Byte;                                                
  end;                                                           
  TDBParamBindInfo = DBPARAMBINDINFO;

  PDBParamBindInfoArray = ^TDBParamBindInfoArray;
  TDBParamBindInfoArray = array[0..MAXBOUND] of TDBParamBindInfo;

  PDBProp = ^TDBProp;                          
  DBPROP = packed record                       
    dwPropertyID: DBPROPID;                    
    dwOptions: DBPROPOPTIONS;
    dwStatus: DBPROPSTATUS;                    
    colid: DBID;                               
    vValue: OleVariant;                        
  end;                                         
  TDBProp = DBPROP;                            

  PDBPropArray = ^TDBPropArray;
  TDBPropArray = array[0..MAXBOUND] of TDBProp;

  PDBPropSet = ^TDBPropSet;
  DBPROPSET = packed record      
    rgProperties: PDBPropArray;  
    cProperties: LongWord;           
    guidPropertySet: TGUID;      
  end;                           
  TDBPropSet = DBPROPSET;        

  IColumnsInfo = interface(IUnknown)
    ['{0C733A11-2A1C-11CE-ADE5-00AA0044773D}']
    function GetColumnInfo(var pcColumns: LongWord; out prgInfo: PDBColumnInfo;
      out ppStringsBuffer: PWideChar): HResult; stdcall;
    function MapColumnIDs(cColumnIDs: LongWord; rgColumnIDs: PDBIDArray;
      rgColumns: PUintArray): HResult; stdcall;
  end;

  ICommandWithParameters = interface(IUnknown)                                          
    ['{0C733A64-2A1C-11CE-ADE5-00AA0044773D}']                                          
    function GetParameterInfo(var pcParams: LongWord; out prgParamInfo: PDBPARAMINFO;
      ppNamesBuffer: PPOleStr): HResult; stdcall;                                       
    function MapParameterNames(cParamNames: LongWord; rgParamNames: POleStrList;
      rgParamOrdinals: PUintArray): HResult; stdcall;                                   
    function SetParameterInfo(cParams: LongWord; rgParamOrdinals: PUintArray;               
      rgParamBindInfo: PDBParamBindInfoArray): HResult; stdcall;                        
  end;                                                                                  

  ICommandPrepare = interface(IUnknown)                      
    ['{0C733A26-2A1C-11CE-ADE5-00AA0044773D}']
    function Prepare(cExpectedRuns: LongWord): HResult; stdcall;
    function Unprepare: HResult; stdcall;
  end;

  IDataInitialize = interface(IUnknown)
    ['{2206CCB1-19C1-11D1-89E0-00C04FD7A829}']
    function GetDataSource(const pUnkOuter: IUnknown; dwClsCtx: DWORD;
      pwszInitializationString: POleStr; const riid: TIID;
      var DataSource: IUnknown): HResult; stdcall;
    function GetInitializationString(const DataSource: IUnknown;
      fIncludePassword: Boolean; out pwszInitString: POleStr): HResult; stdcall;
    function CreateDBInstance(const clsidProvider: TGUID;
      const pUnkOuter: IUnknown; dwClsCtx: DWORD; pwszReserved: POleStr;
      riid: TIID; var DataSource: IUnknown): HResult; stdcall;
    function CreateDBInstanceEx(const clsidProvider: TGUID;
      const pUnkOuter: IUnknown; dwClsCtx: DWORD; pwszReserved: POleStr;
      pServerInfo: PCoServerInfo; cmq: ULONG; rgmqResults: PMultiQI): HResult; stdcall;
    function LoadStringFromStorage(pwszFileName: POleStr;
      out pwszInitializationString: POleStr): HResult; stdcall;
    function WriteStringToStorage(pwszFileName, pwszInitializationString: POleStr;
      dwCreationDisposition: DWORD): HResult; stdcall;
  end;
  
type
  DBPROMPTOPTIONS = LongWord;
  DBSOURCETYPE = DWORD;
  PDBSOURCETYPE = ^DBSOURCETYPE;

  IDBPromptInitialize = interface(IUnknown)
    ['{2206CCB0-19C1-11D1-89E0-00C04FD7A829}']
    function PromptDataSource(const pUnkOuter: IUnknown; hWndParent: HWND;
      dwPromptOptions: DBPROMPTOPTIONS; cSourceTypeFilter: ULONG;
      rgSourceTypeFilter: PDBSOURCETYPE; pszProviderFilter: POleStr;
      const riid: TIID; var DataSource: IUnknown): HResult; stdcall;
    function PromptFileName(hWndParent: HWND; dwPromptOptions: DBPROMPTOPTIONS;
      pwszInitialDirectory, pwszInitialFile: POleStr;
      var ppwszSelectedFile: POleStr): HResult; stdcall;
  end;

const
  DBPROMPTOPTIONS_NONE = 0;
  {$EXTERNALSYM DBPROMPTOPTIONS_NONE}
  DBPROMPTOPTIONS_WIZARDSHEET = $1;
  {$EXTERNALSYM DBPROMPTOPTIONS_WIZARDSHEET}
  DBPROMPTOPTIONS_PROPERTYSHEET = $2;
  {$EXTERNALSYM DBPROMPTOPTIONS_PROPERTYSHEET}
  DBPROMPTOPTIONS_BROWSEONLY = $8;
  {$EXTERNALSYM DBPROMPTOPTIONS_BROWSEONLY}
  DBPROMPTOPTIONS_DISABLE_PROVIDER_SELECTION = $10;
  {$EXTERNALSYM DBPROMPTOPTIONS_DISABLE_PROVIDER_SELECTION}

{$ENDIF}

var
{**
  Required to free memory allocated by oledb
}
  ZAdoMalloc: IMalloc;

implementation

uses
  ComObj, {$IFNDEF VER125BELOW}OleDB, {$ENDIF}
  ZCompatibility, ZSysUtils, ZPlainAdo;

{**
  Converts a Ado native types into ZDBC SQL types.
  @param FieldType dblibc native field type.
  @return a SQL undepended type.
}
function ConvertAdoToSqlType(FieldType: SmallInt): TZSQLType;
begin
  case FieldType of
    adChar, adVarChar, adBSTR: Result := stString;
    adWChar, adVarWChar: Result := stUnicodeString;
    adBoolean: Result := stBoolean;
//Bug #889223, bug with tinyint on mssql
//    adTinyInt, adUnsignedTinyInt: Result := stByte;
    adTinyInt, adUnsignedTinyInt: Result := stShort;
    adSmallInt, adUnsignedSmallInt: Result := stShort;
    adInteger, adUnsignedInt: Result := stInteger;
    adBigInt, adUnsignedBigInt: Result := stLong;
    adSingle: Result := stDouble;
    adDouble: Result := stDouble;
    adDecimal: Result := stBigDecimal;
    adNumeric, adVarNumeric: Result := stBigDecimal;
    adCurrency: Result := stBigDecimal;
    adDBDate: Result := stDate;
    adDBTime: Result := stTime;
    adDate, adDBTimeStamp, adFileTime: Result := stTimestamp;
    adLongVarChar: Result := stAsciiStream;
    adLongVarWChar: Result := stUnicodeStream;
    adBinary, adVarBinary, adLongVarBinary: Result := stBinaryStream;
    adGUID: Result := stString;

    adEmpty, adError, AdArray, adChapter, adIDispatch, adIUnknown,
    adPropVariant, adUserDefined, adVariant: Result := stString;
  else
    Result := stString;
  end;
end;

{**
  Converts a Zeos type into ADO types.
  @param FieldType zeos field type.
  @return a ADO datatype.
}
function ConvertSqlTypeToAdo(FieldType: TZSQLType): Integer;
begin
  case FieldType of
    stString: Result := adVarChar;
    stUnicodeString: Result := adVarWChar;
    stBoolean: Result := adBoolean;
    stByte: Result := adTinyInt;
    stShort: Result := adSmallInt;
    stInteger: Result := adInteger;
    stLong: Result := adBigInt;
    stBigDecimal: Result := adDecimal;
    stFloat: Result := adSingle;
    stDouble: Result := adDouble;
    stDate: Result := adDBDate;
    stTime: Result := adDBTime;
    stTimestamp: Result := adDBTimeStamp;
    stBytes: Result := adVarBinary;
    stAsciiStream: Result := adLongVarChar;
    stUnicodeStream: Result := adLongVarWChar;
    stBinaryStream: Result := adLongVarBinary;
  else
    Result := adEmpty;
  end;
end;

{**
  Converts a Variant type into ADO types.
  @param VT Variant datatype.
  @return a ADO datatype.
}
{$IFDEF VER130BELOW}
function ConvertVariantToAdo(VT: Integer): Integer;
{$ELSE}
function ConvertVariantToAdo(VT: TVarType): Integer;
{$ENDIF}
begin
  case VT and varTypeMask of
    varEmpty: Result := adEmpty;
    varNull: Result := adVarChar;
    varSmallint: Result := adSmallInt;
    varInteger: Result := adInteger;
    varSingle: Result := adSingle;
    varDouble: Result := adDouble;
    varCurrency: Result := adCurrency;
    varDate: Result := adDBTimeStamp;
    varOleStr: Result := adVarWChar;
    varDispatch: Result := adIDispatch;
    varError: Result := adError;
    varBoolean: Result := adBoolean;
    varVariant: Result := adVariant;
    varUnknown: Result := adIUnknown;
{$IFNDEF VER130BELOW}
    varShortInt: Result := adTinyInt;
{$ENDIF}
    varByte: if (VT and varArray) <> 0 then Result := adLongVarBinary else Result := adUnsignedTinyInt;
{$IFNDEF VER130BELOW}
    varWord: Result := adUnsignedSmallInt;
    varLongWord: Result := adUnsignedInt;
    varInt64: Result := adBigInt;
{$ENDIF}
{$IFNDEF VER125BELOW}
    varStrArg: Result := adWChar;
{$ENDIF}
    varString: Result := adVarChar;
    varAny: Result := adEmpty;
  else
    Result := adEmpty;
  end;
end;


{**
  Converts a TZResultSetType type into ADO cursor type.
  @param ResultSetType.
  @return a ADO cursor type.
}
function ConvertResultSetTypeToAdo(ResultSetType: TZResultSetType): Integer;
begin
  case ResultSetType of
    rtForwardOnly: Result := adOpenForwardOnly;
    rtScrollInsensitive: Result := adOpenStatic;
    rtScrollSensitive: Result := adOpenDynamic;
  else
    Result := -1;//adOpenUnspecified;
  end
end;

{**
  Converts a TZResultSetConcurrency type into ADO lock type.
  @param ResultSetConcurrency.
  @return a ADO lock type.
}
function ConvertResultSetConcurrencyToAdo(ResultSetConcurrency: TZResultSetConcurrency): Integer;
begin
  case ResultSetConcurrency of
    rcReadOnly: Result := adLockReadOnly;
    rcUpdatable: Result := adLockOptimistic;
  else
    Result := -1;//adLockUnspecified;
  end
end;

{**
  Converts a OLEDB schema guid into ADO schema ID usable with OpenSchema.
  @param OleDBSchema schema guid.
  @return a ADO schema id.
}
function ConvertOleDBToAdoSchema(OleDBSchema: TGUID): Integer;
begin
  Result := -1;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_ASSERTIONS) then Result := 0;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_CATALOGS) then Result := 1;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_CHARACTER_SETS) then Result := 2;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_COLLATIONS) then Result := 3;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_COLUMNS) then Result := 4;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_CHECK_CONSTRAINTS) then Result := 5;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_CONSTRAINT_COLUMN_USAGE) then Result := 6;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_CONSTRAINT_TABLE_USAGE) then Result := 7;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_KEY_COLUMN_USAGE) then Result := 8;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_REFERENTIAL_CONSTRAINTS) then Result := 9;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_TABLE_CONSTRAINTS) then Result := 10;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_COLUMN_DOMAIN_USAGE) then Result := 11;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_INDEXES) then Result := 12;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_COLUMN_PRIVILEGES) then Result := 13;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_TABLE_PRIVILEGES) then Result := 14;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_USAGE_PRIVILEGES) then Result := 15;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_PROCEDURES) then Result := 16;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_SCHEMATA) then Result := 17;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_SQL_LANGUAGES) then Result := 18;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_STATISTICS) then Result := 19;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_TABLES) then Result := 20;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_TRANSLATIONS) then Result := 21;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_PROVIDER_TYPES) then Result := 22;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_VIEWS) then Result := 23;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_VIEW_COLUMN_USAGE) then Result := 24;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_VIEW_TABLE_USAGE) then Result := 25;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_PROCEDURE_PARAMETERS) then Result := 26;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_FOREIGN_KEYS) then Result := 27;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_PRIMARY_KEYS) then Result := 28;
  if IsEqualGuid(OleDBSchema, DBSCHEMA_PROCEDURE_COLUMNS) then Result := 29;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_CUBES) then Result := 32;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_DIMENSIONS) then Result := 33;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_HIERARCHIES) then Result := 34;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_LEVELS) then Result := 35;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_MEASURES) then Result := 36;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_PROPERTIES) then Result := 37;
  if IsEqualGuid(OleDBSchema, MDSCHEMA_MEMBERS) then Result := 38;
  if IsEqualGuid(OleDBSchema, DBPROPSET_TRUSTEE) then Result := 39;
end;

{**
  Brings up the ADO connection string builder dialog.
}
function PromptDataSource(Handle: THandle; InitialString: WideString): WideString;
var
  DataInit: IDataInitialize;
  DBPrompt: IDBPromptInitialize;
  DataSource: IUnknown;
  InitStr: PWideChar;
begin
  Result := InitialString;
  DataInit := CreateComObject(CLSID_DataLinks) as IDataInitialize;
  if InitialString <> '' then
    DataInit.GetDataSource(nil, CLSCTX_INPROC_SERVER,
      PWideChar(InitialString), IUnknown, DataSource);
  DBPrompt := CreateComObject(CLSID_DataLinks) as IDBPromptInitialize;
  if Succeeded(DBPrompt.PromptDataSource(nil, Handle,
    DBPROMPTOPTIONS_PROPERTYSHEET, 0, nil, nil, IUnknown, DataSource)) then
  begin
    InitStr := nil;
    DataInit.GetInitializationString(DataSource, True, InitStr);
    Result := InitStr;
  end;
end;

initialization
  OleCheck(CoGetMalloc(1, ZAdoMalloc));
finalization
  ZAdoMalloc := nil;
end.


