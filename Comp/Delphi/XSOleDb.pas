{$I XSqlDir.inc}
unit XSOleDb {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, Registry, SyncObjs,
  ActiveX, ComObj,
{$IFDEF XSQL_VCL6}
  FmtBcd, Variants, OleDB,
{$ELSE}
  XS_OleDb_D5,          // a copy of OleDb.pas to exclude a collision with vclado50.bpl
{$ENDIF}
{$IFDEF XSQL_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  XSConsts, XSCommon;

//--------------------------------------------------------------------
// Additions to OleDb.pas
//--------------------------------------------------------------------

const
  DBPROP_SKIPROWCOUNTRESULTS = $123;

  IID_IErrorRecords:    TGUID = '{0C733A67-2A1C-11CE-ADE5-00AA0044773D}';
  IID_ISequentialStream:TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream:          TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_IStorage:         TGUID = '{0000000B-0000-0000-C000-000000000046}';
  IID_ILockBytes:       TGUID = '{0000000A-0000-0000-C000-000000000046}';

  IID_IDBSchemaRowset:  TGUID = '{0C733A7B-2A1C-11CE-ADE5-00AA0044773D}';

type
// *********************************************************************//
// Interface: IErrorRecords
// GUID:      {0C733A67-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  IErrorRecords = interface(IUnknown)
    ['{0C733A67-2A1C-11CE-ADE5-00AA0044773D}']
    function AddErrorRecord(pErrorInfo: PERRORINFO; dwLookupID: DWORD;
      pdispparams: PDISPPARAMS; const punkCustomError: IUnknown; dwDynamicErrorID: DWORD): HResult; stdcall;
    function GetBasicErrorInfo(ulRecordNum: ULONG; pErrorInfo: PERRORINFO): HResult; stdcall;
    function GetCustomErrorObject(ulRecordNum: ULONG; const riid: TGUID; out ppObject: IUnknown): HResult; stdcall;
    function GetErrorInfo(ulRecordNum: ULONG; lcid: TLCID; out ppErrorInfo: IErrorInfo): HResult; stdcall;
    function GetErrorParameters(ulRecordNum: ULONG; pdispparams: PDISPPARAMS): HResult; stdcall;
    function GetRecordCount(out pcRecords: ULONG): HResult; stdcall;
  end;

  { Safecall Version }
  IErrorRecordsSC = interface(IUnknown)
    ['{0C733A67-2A1C-11CE-ADE5-00AA0044773D}']
    function AddErrorRecord(pErrorInfo: PERRORINFO; dwLookupID: DWORD;
      pdispparams: PDISPPARAMS; const punkCustomError: IUnknown; dwDynamicErrorID: DWORD): HResult; safecall;
    function GetBasicErrorInfo(ulRecordNum: ULONG; pErrorInfo: PERRORINFO): HResult; safecall;
    function GetCustomErrorObject(ulRecordNum: ULONG; const riid: TGUID; out ppObject: IUnknown): HResult; safecall;
    function GetErrorInfo(ulRecordNum: ULONG; lcid: TLCID; out ppErrorInfo: IErrorInfo): HResult; safecall;
    function GetErrorParameters(ulRecordNum: ULONG; pdispparams: PDISPPARAMS): HResult; safecall;
    function GetRecordCount(out pcRecords: ULONG): HResult; safecall;
  end;

// *********************************************************************//
// Interface: IDBSchemaRowset
// GUID:      {0C733A7B-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  IDBSchemaRowset = interface(IUnknown)
    ['{0C733A7B-2A1C-11CE-ADE5-00AA0044773D}']
    function GetRowset(const pUnkOuter: IUnknown; const rguidSchema: TGUID;
            cRestrictions: ULONG;
            rgRestrictions: PVariantArg;
            const riid: TGUID;
            cPropertySets: ULONG;
            rgPropertySets: PDBPropSetArray;
            out pRowset: IUnknown): HResult; stdcall;
    function GetSchemas(var cSchemas: ULONG; out prgSchemas: PGUID; out prgRestrictionSupport:PULONG): HResult; stdcall;
  end;

  { Safecall Version }
  IDBSchemaRowsetSC = interface(IUnknown)
    ['{0C733A7B-2A1C-11CE-ADE5-00AA0044773D}']
    function GetRowset(const pUnkOuter: IUnknown; const rguidSchema: TGUID;
            cRestrictions: ULONG;
            rgRestrictions: PVariantArg;
            const riid: TGUID;
            cPropertySets: ULONG;
            rgPropertySets: PDBPropSetArray;
            out pRowset: IUnknown): HResult; safecall;
    function GetSchemas(var cSchemas: ULONG; out prgSchemas: PGUID; out prgRestrictionSupport:PULONG): HResult; safecall;
  end;

//--------------------------------------------------------------------
// Microsoft OLE DB Provider for SQL Server
//
// SQLOLEDB.H | Provider Specific definitions
//
//--------------------------------------------------------------------
const
        // ProgID and CLSID of Microsoft OLE DB Provider for SQL Server (SQLOLEDB)
  ProgID_SQLOLEDB = 'SQLOLEDB';
  CLSID_SQLOLEDB: TGUID = '{0C7FF16C-38E3-11d0-97AB-00C04FC2AD98}';
        // Error Lookup CLSID
  CLSID_SQLOLEDB_ERROR: TGUID = '{C0932C62-38E5-11d0-97AB-00C04FC2AD98}';
        // Enumerator CLSID
  CLSID_SQLOLEDB_ENUMERATOR: TGUID = '{DFA22B8E-E68D-11d0-97E4-00C04FC2AD98}';

        // Provider-specific Interface Ids
  IID_ISQLServerErrorInfo: TGUID= '{5CF4CA12-EF21-11D0-97E7-00C04FC2AD98}';
  IID_IRowsetFastLoad: TGUID 	= '{5CF4CA13-EF21-11D0-97E7-00C04FC2AD98}';
  IID_IUMSInitialize: TGUID     = '{5CF4CA14-EF21-11D0-97E7-00C04FC2AD98}';
  IID_ISchemaLock: TGUID        = '{4C2389FB-2511-11d4-B258-00C04F7971CE}';

  DBGUID_MSSQLXML: TGUID        = '{5d531cb2-e6ed-11d2-b252-00c04f681b71}';
  DBGUID_XPATH: TGUID           = '{ec2a4293-e898-11d2-b1b7-00c04f680c56}';
  IID_ICommandStream: TGUID     = '{0c733abf-2a1c-11ce-ade5-00aa0044773d}';
  IID_ISQLXMLHelper: TGUID      = '{d22a7678-f860-40cd-a567-1563deb46d49}';

        // Provider-specific schema rowsets
  DBSCHEMA_LINKEDSERVERS: TGUID	= '{9093caf4-2eac-11d1-9809-00c04fc2ad98}';

  CRESTRICTIONS_DBSCHEMA_LINKEDSERVERS = 1;

//----------------------------------------------------------------------------
// Provider-specific property sets
  DBPROPSET_SQLSERVERDATASOURCE: TGUID  = '{28efaee4-2d2c-11d1-9807-00c04fc2ad98}';
  DBPROPSET_SQLSERVERDATASOURCEINFO:TGUID='{df10cb94-35f6-11d2-9c54-00c04f7971d3}';
  DBPROPSET_SQLSERVERDBINIT: TGUID      = '{5cf4ca10-ef21-11d0-97e7-00c04fc2ad98}';
  DBPROPSET_SQLSERVERROWSET: TGUID 	= '{5cf4ca11-ef21-11d0-97e7-00c04fc2ad98}';
  DBPROPSET_SQLSERVERSESSION: TGUID	= '{28efaee5-2d2c-11d1-9807-00c04fc2ad98}';
  DBPROPSET_SQLSERVERCOLUMN: TGUID	= '{3b63fb5e-3fbb-11d3-9f29-00c04f8ee9dc}';
  DBPROPSET_SQLSERVERSTREAM: TGUID	= '{9f79c073-8a6d-4bca-a8a8-c9b79a9b962d}';

//----------------------------------------------------------------------------
// Provider-specific columns for IColumnsRowset
(*
  DBCOLUMN_SS_COMPFLAGS     :TDBID = {{0x627bd890,0xed54,0x11d2,{0xb9,0x94,0x0,0xc0,0x4f,0x8c,0xa8,0x2c}}, DBKIND_GUID_PROPID, (LPOLESTR)100};
  DBCOLUMN_SS_SORTID	    :TDBID = {{0x627bd890,0xed54,0x11d2,{0xb9,0x94,0x0,0xc0,0x4f,0x8c,0xa8,0x2c}}, DBKIND_GUID_PROPID, (LPOLESTR)101};
  DBCOLUMN_BASETABLEINSTANCE:TDBID = {{0x627bd890,0xed54,0x11d2,{0xb9,0x94,0x0,0xc0,0x4f,0x8c,0xa8,0x2c}}, DBKIND_GUID_PROPID, (LPOLESTR)102};
  DBCOLUMN_SS_TDSCOLLATION  :TDBID = {{0x627bd890,0xed54,0x11d2,{0xb9,0x94,0x0,0xc0,0x4f,0x8c,0xa8,0x2c}}, DBKIND_GUID_PROPID, (LPOLESTR)103};
*)


//----------------------------------------------------------------------------
// PropIds for DBPROP_INIT_GENERALTIMEOUT
  DBPROP_INIT_GENERALTIMEOUT	       = $11c;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERDATASOURCE
  SSPROP_ENABLEFASTLOAD		       = 2;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERDATASOURCEINFO
  SSPROP_UNICODELCID		       = 2;
  SSPROP_UNICODECOMPARISONSTYLE	       = 3;
  SSPROP_COLUMNLEVELCOLLATION          = 4;
  SSPROP_CHARACTERSET		       = 5;
  SSPROP_SORTORDER		       = 6;
  SSPROP_CURRENTCOLLATION	       = 7;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERDBINIT
  SSPROP_INIT_CURRENTLANGUAGE	       = 4;
  SSPROP_INIT_NETWORKADDRESS	       = 5;
  SSPROP_INIT_NETWORKLIBRARY	       = 6;
  SSPROP_INIT_USEPROCFORPREP	       = 7;
  SSPROP_INIT_AUTOTRANSLATE	       = 8;
  SSPROP_INIT_PACKETSIZE	       = 9;
  SSPROP_INIT_APPNAME		       = 10;
  SSPROP_INIT_WSID		       = 11;
  SSPROP_INIT_FILENAME		       = 12;
  SSPROP_INIT_ENCRYPT                  = 13;
  SSPROP_AUTH_REPL_SERVER_NAME	       = 14;
  SSPROP_INIT_TAGCOLUMNCOLLATION       = 15;

//-----------------------------------------------------------------------------
// Values for SSPROP_USEPROCFORPREP
  SSPROPVAL_USEPROCFORPREP_OFF	       = 0;
  SSPROPVAL_USEPROCFORPREP_ON	       = 1;
  SSPROPVAL_USEPROCFORPREP_ON_DROP     = 2;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERSESSION
  SSPROP_QUOTEDCATALOGNAMES	       = 2;
  SSPROP_ALLOWNATIVEVARIANT	       = 3;
  SSPROP_SQLXMLXPROGID		       = 4;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERROWSET
  SSPROP_MAXBLOBLENGTH		       = 8;
  SSPROP_FASTLOADOPTIONS	       = 9;
  SSPROP_FASTLOADKEEPNULLS	       = 10;
  SSPROP_FASTLOADKEEPIDENTITY	       = 11;
  SSPROP_CURSORAUTOFETCH	       = 12;
  SSPROP_DEFERPREPARE		       = 13;
  SSPROP_IRowsetFastLoad	       = 14;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERCOLUMN
  SSPROP_COL_COLLATIONNAME	       = 14;

//----------------------------------------------------------------------------
// PropIds for DBPROPSET_SQLSERVERSTREAM
  SSPROP_STREAM_MAPPINGSCHEMA    = 15;
  SSPROP_STREAM_XSL              = 16;
  SSPROP_STREAM_BASEPATH         = 17;
  SSPROP_STREAM_COMMANDTYPE      = 18;
  SSPROP_STREAM_XMLROOT          = 19;
  SSPROP_STREAM_FLAGS            = 20;
  SSPROP_STREAM_CONTENTTYPE      = 23;

//----------------------------------------------------------------------------
// Possible values for SSPROP_STREAM_FLAGS
  STREAM_FLAGS_DISALLOW_URL           =$00000001;
  STREAM_FLAGS_DISALLOW_ABSOLUTE_PATH =$00000002;
  STREAM_FLAGS_DISALLOW_QUERY         =$00000004;
  STREAM_FLAGS_DONTCACHEMAPPINGSCHEMA =$00000008;
  STREAM_FLAGS_DONTCACHETEMPLATE      =$00000010;
  STREAM_FLAGS_DONTCACHEXSL           =$00000020;
  STREAM_FLAGS_RESERVED               =$ffff0000;

        // Values for SSPROPVAL_COMMANDTYPE
  SSPROPVAL_COMMANDTYPE_REGULAR  = 21;
  SSPROPVAL_COMMANDTYPE_BULKLOAD = 22;

//-------------------------------------------------------------------
// define SQL Server Spefific Variant Type
//-------------------------------------------------------------------
  DBTYPE_SQLVARIANT  = 144;

type
// the structure returned by  ISQLServerErrorInfo::GetSQLServerInfo
  PSSErrorInfo  = ^TSSErrorInfo;
  TSSErrorInfo  = record
    pwszMessage: PWideChar;     // identical to the string returned IErrorInfo::GetDescription
    pwszServer: PWideChar;
    pwszProcedure: PWideChar;
    lNative: UINT;
    bState: Byte;
    bClass: Byte;
    wLineNumber: Word;
  end;

// *********************************************************************//
// Interface: ISQLServerErrorInfo
// GUID:      {5CF4CA12-EF21-11d0-97E7-00C04FC2AD98}
// *********************************************************************//
  ISQLServerErrorInfo = interface(IUnknown)
    ['{5CF4CA12-EF21-11d0-97E7-00C04FC2AD98}']
    function GetErrorInfo(
            out ppErrorInfo: PSSErrorInfo;
            out ppStringsBuffer: PWideChar): HResult; stdcall;
  end;
  { Safecall Version }
  ISQLServerErrorInfoSC = interface(IUnknown)
    ['{5CF4CA12-EF21-11d0-97E7-00C04FC2AD98}']
    function GetErrorInfo(
            out ppErrorInfo: PSSErrorInfo;
            out ppStringsBuffer: PWideChar): HResult; safecall;
  end;

//
// SQLOLEDB.H | Provider Specific definitions (end)
//--------------------------------------------------------------------

type
  ESDOleDbError = class(ESDEngineError);

{ TIOleDbDatabase }
  TIOleDbDatabase = class(TISqlDatabase)
  private
    FIDBInitialize: IDBInitialize;
    FIDBCreateSession: IDBCreateSession;
    FIDBCreateCommand: IDBCreateCommand;
    FITransaction: ITransactionLocal;
    FMultResultsSupported: Boolean;
    FOutputParamsReturned: LongInt;
    FIsMSSQLProv: Boolean;
    FCurSqlCmd: TISqlCommand;		// a command, which uses a database handle currently (when FIsSingleConn is True)    
    function OleDbGetDBPropValue(APropIDs: array of DBPROPID): string;
    procedure SetDBInitProps(bInitPropSet, bIntegratedAuth: Boolean);
  protected
    procedure Check(Status: HResult);
//    function GetHandle: TSDPtr; override;

    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;

    procedure SetAutoCommitOption(Value: Boolean); override;
//    procedure SetHandle(AHandle: TSDPtr); override;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;
    function CreateSqlCommand: TISqlCommand; override;

    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;    

    procedure ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll: Boolean);
    property CurSqlCmd: TISqlCommand read FCurSqlCmd;
    property DBCreateCommand: IDBCreateCommand read FIDBCreateCommand;
    property IsMSSQLProv: Boolean read FIsMSSQLProv;
    property MultResultsSupported: Boolean read FMultResultsSupported;
    property OutputParamsReturned: LongInt read FOutputParamsReturned;
  end;

{ TIOleDbCommand }
  TIOleDbCommand = class(TISqlCommand)
  private
    FICommandText: ICommandText;
    FIMultipleResults: IMultipleResults;
    FIRowAccessor,
    FIParamAccessor: IAccessor;
    FHRowAccessor,
    FHParamAccessor: HACCESSOR;
    FRowBindPtr,
    FParamBindPtr: PDBBINDING;
    FHRows: PUintArray;
    FCurrRow,                   // current fetched row in FHRows array
    FFetchedRows: UINT;         // actual number of fetched rows
    FPrefetchRows: Integer;	// number of rows requested by each call FIRowset.GetNextRows
    FRowsAffected: Integer;     // DBROWCOUNT
    FIsSingleConn: Boolean;	// True, if it's required to use a database handle always
    FIsSrvCursor: Boolean;        // if server cursor is used
    FNextResults: Boolean;
    FBlobParamsBufferOff: Integer;
    FFirstCalcFieldIdx: Integer;// first field, which is not bound. The following fields are not corresponded actual database fields
    function GetSqlDatabase: TIOleDbDatabase;
    function CnvtDBData(AFieldName: string; ADataType: TFieldType; InBuf, Buffer: TSDPtr; BufSize: Integer): Boolean;
    function CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDPtr; BufSize: Integer): TDateTimeRec;
    procedure InternalExecute(bFieldDescribe: Boolean);
    procedure InternalSpGetParams;
    procedure ReleaseRowSet;
    procedure ReleaseHRows;
    procedure SetICommandProps;
    procedure SetICommandText(Value: string);
    procedure SetICmdParameterInfo;
    function OleDbDataSourceType(FieldType: TFieldType): string;
  protected
    FIRowset: IRowset;
    procedure AcquireDBHandle;
    procedure ReleaseDBHandle;

    procedure Check(Status: HResult);
    procedure Connect; virtual;
    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; override;
    procedure AllocFieldsBuffer; override;
    procedure AllocParamsBuffer; override;
    procedure BindParamsBuffer; override;
    procedure FreeFieldsBuffer; override;
    procedure FreeParamsBuffer; override;
    procedure SetFieldsBuffer; override;
    function GetFieldsBufferSize: Integer; override;
    function GetParamsBufferSize: Integer; override;

    procedure DoExecute; override;
    procedure DoExecDirect(ACommandValue: string); override;
    procedure DoPrepare(Value: string); override;

    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    procedure InitParamList; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    function GetHandle: PSDCursor; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    procedure Execute; override;
    function GetRowsAffected: Integer; override;
    function NextResultSet: Boolean; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;

    property IsSrvCursor: Boolean read FIsSrvCursor;
    property SqlDatabase: TIOleDbDatabase read GetSqlDatabase;
  end;

{ TIOleDbSchemaCommand }
  TIOleDbSchemaCommand = class(TIOleDbCommand)
  protected
    FObjPattern: string;
    FSchemaRowsetGUID: TGUID;
    FRestrictions: PVariantArg;
    FRestrictCount: Integer;
    procedure CreateRestrictions; virtual; abstract;
    procedure DestroyRestrictions;
    procedure DoExecute; override;
    procedure DoExecDirect(Value: string); override;
    procedure DoPrepare(Value: string); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
    property ObjPattern: string read FObjPattern write FObjPattern;
    property SchemaRowsetGUID: TGUID read FSchemaRowsetGUID;
  end;

  TIOleDbSchemaTables = class(TIOleDbSchemaCommand)
  private
    FSysTables: Boolean;
    FSchName,
    FTblName: string;   // this can be used in FetchNextRow like wildcards
  protected
    procedure CreateRestrictions; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property SysTables: Boolean read FSysTables write FSysTables;
  end;

  TIOleDbSchemaColumns = class(TIOleDbSchemaCommand)
  private
    FColTypeFieldIdx,
    FColTypeNameLen,
    FColTypeNameFieldIdx: Integer;
    function GetDataTypeName(const TypeInd: Integer): string;
  protected
    procedure CreateRestrictions; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
  end;

  TIOleDbSchemaIndexes = class(TIOleDbSchemaCommand)
  private
    FIdxTypeFieldIdx,
    FIdxSortFieldIdx: Integer;
  protected
    procedure CreateRestrictions; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
  end;

  TIOleDbSchemaProcs = class(TIOleDbSchemaCommand)
  private
    FInParamsFieldIdx,
    FOutParamsFieldIdx: Integer;
  protected
    procedure CreateRestrictions; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
  end;

  TIOleDbSchemaProcParams = class(TIOleDbSchemaCommand)
  protected
    procedure CreateRestrictions; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
  end;

const
  DefSqlApiDLL	= '';

var
  SqlApiDLL: string;

{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

implementation

const
  SCantConvertFieldValueFmt     = 'Cannot convert value of field ''%s''';
  SErrErrorNotFound             = 'The system cannot find message for error number $';
  SErrDBPropsNotSupported       = 'Provider not support some database parameters';

  SSchemaGuidNotSupported       = 'Schema GUID %s not supported';

        // keywords of OLEDB connection string
  CT_PROVIDER   = 'PROVIDER=';          { Do not localize }
  CT_DATASOURCE = 'DATA SOURCE=';        { Do not localize }
  CT_INITCATALOG= 'INITIAL CATALOG=';   { Do not localize }
  CT_USERID     = 'USER ID=';           { Do not localize }
  CT_PASSWORD   = 'PASSWORD=';          { Do not localize }
  CT_USERID2    = 'UID=';               { Do not localize }
  CT_PASSWORD2  = 'PWD=';               { Do not localize }

  CT_FILENAME   = 'FILE NAME=';         { Do not localize }

var
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;


{ Whether the specified connection tags are present }
function CT_UserIDExists(const ConnStr: string): Boolean;
var
  s: string;
begin
  s := UpperCase(ConnStr);
  Result := Pos(CT_USERID, s) > 0;
        // check the second form
  if not Result then
    Result := Pos(CT_USERID2, s) > 0;
end;

function CT_PasswordExists(const ConnStr: string): Boolean;
var
  s: string;
begin
  s := UpperCase(ConnStr);
  Result := Pos(CT_PASSWORD, s) > 0;
        // check the second form
  if not Result then
    Result := Pos(CT_PASSWORD2, s) > 0;
end;

function MakeLangID(usPrimaryLanguage, usSubLanguage: Short): Word;
begin
  Result := (usSubLanguage shl 10) or usPrimaryLanguage;
end;

function MakeLCID(wLanguageID, wSortID: Word): DWORD;
begin
  Result := (wSortID shl 16) or wLanguageID;
end;

function GetWideCharBufLen(const s: string): Integer;
begin
        // CP_ACP - default to ANSI code page
  Result := MultiByteToWideChar(CP_ACP, 0, PChar(s), Length(s), nil, 0);
end;

function AllocWideChar(const s: string): PWideChar;
var
  Len: Integer;
begin
  Len := GetWideCharBufLen(s);
  Result := SysAllocStringLen(nil, Len);        // desclared in ActiveX unit
        // CP_ACP - default to ANSI code page
  MultiByteToWideChar(CP_ACP, 0, PChar(s), Length(s), Result, Len);
end;

procedure FreeWideChar(const bstr: PWideChar);
begin
  SysFreeString(bstr);
end;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
begin
  Result := TIOleDbDatabase.Create( ADbParams );
end;

procedure LoadSqlLib;
begin
  SqlLibLock.Acquire;
  try
    if SqlLibRefCount = 0 then begin
      OleCheck( CoInitialize(nil) );
      Inc(SqlLibRefCount);
    end else
      Inc(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

procedure FreeSqlLib;
begin
  if SqlLibRefCount = 0 then
    Exit;

  SqlLibLock.Acquire;
  try
    if SqlLibRefCount = 1 then begin
      CoUninitialize;
      Dec(SqlLibRefCount);
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

{ TIOleDbDatabase }

constructor TIOleDbDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FIDBInitialize := nil;
  FIDBCreateSession:= nil;
  FIDBCreateCommand:=nil;
  FITransaction := nil;
  
  FIsMSSQLProv := False;
end;

destructor TIOleDbDatabase.Destroy;
begin

  inherited;
end;

function TIOleDbDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIOleDbCommand.Create( Self );
end;

procedure TIOleDbDatabase.ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll: Boolean);
var
  ds: TISqlCommand;
begin
  if Assigned(FCurSqlCmd) and (ASqlCmd <> FCurSqlCmd) then begin
    ds := FCurSqlCmd;
    FCurSqlCmd := nil;
    try
      if IsFetchAll then
        ds.SaveResults;
    except
      FCurSqlCmd := ds;
      raise;
    end;
  end;
  FCurSqlCmd := ASqlCmd;
end;

procedure TIOleDbDatabase.Check(Status: HResult);
var
  sMsg: string;
  szMsg: PChar;
  MsgLen, nErrCode, i, j, nNativeError, nErrPos: Integer;
  pIErrorInfo, pIErrorInfo2: IErrorInfo;
  pIErrorRecords: IErrorRecords;
  pISQLErrorInfo: ISQLErrorInfo;
  pIMSSQLErrorInfo: ISQLServerErrorInfo;
  nErrRecords: ULONG;
  ws, wsSqlState: WideString;
  lcids: array[0..2] of TLCID;
  hr: HResult;
  SSErrorPtr: PSSErrorInfo;
  SSError: TSSErrorInfo;
  StringsBufferPtr: PWideChar;
begin
  ResetIdleTimeOut;

  if Succeeded(Status) then
    Exit;

  nNativeError := 0;
  nErrCode := 0;
  nErrPos := 0;
  pIErrorInfo := nil;
  pIErrorRecords:= nil;
  if Succeeded( GetErrorInfo(0, pIErrorInfo) ) and Assigned(pIErrorInfo) then begin
	// OLE DB extends the OLE Automation error model by allowing
	// Error objects to support the IErrorRecords interface; this
	// interface can expose information on multiple errors.
    if Succeeded( pIErrorInfo.QueryInterface( IID_IErrorRecords, pIErrorRecords ) ) and Assigned(pIErrorRecords) then begin
      lcids[0] := GetUserDefaultLCID;
      lcids[1] := GetSystemDefaultLCID;
      lcids[2] := MakeLCID( MakeLangID(LANG_ENGLISH, SUBLANG_DEFAULT), SORT_DEFAULT );
      pIErrorRecords.GetRecordCount( nErrRecords );
      for i:=nErrRecords-1 downto 0 do begin
        wsSqlState := '';
        nErrCode := 0;
        pISQLErrorInfo := nil;
        pIMSSQLErrorInfo:=nil;
                // get a native MS SQL Server error interface
        if IsMSSQLProv and Succeeded( pIErrorRecords.GetCustomErrorObject(i, IID_ISQLServerErrorInfo, IUnknown(pIMSSQLErrorInfo)) ) and Assigned(pIMSSQLErrorInfo) then begin
          SSErrorPtr := nil;
          StringsBufferPtr:= nil;
          try
            hr := pIMSSQLErrorInfo.GetErrorInfo(SSErrorPtr, StringsBufferPtr);
            if Succeeded(hr) and Assigned(SSErrorPtr) then begin
              SSError := SSErrorPtr^;
              nErrCode := SSError.lNative;
              nErrPos := SSError.wLineNumber;
            end;
          finally
            if Assigned(SSErrorPtr) then
              CoTaskMemFree(SSErrorPtr);
            if Assigned(StringsBufferPtr) then
              CoTaskMemFree(StringsBufferPtr);
            pIMSSQLErrorInfo := nil;
          end;
        end else if Succeeded( pIErrorRecords.GetCustomErrorObject(i, IID_ISQLErrorInfo, IUnknown(pISQLErrorInfo)) ) and Assigned(pISQLErrorInfo) then begin
          try   // use a common error interface
            pISQLErrorInfo.GetSQLInfo( wsSqlState, nErrCode );
          finally
            pISQLErrorInfo := nil;
          end;
        end;
        pIErrorInfo2 := nil;
                // save the first error code
        if nNativeError = 0 then
          nNativeError := nErrCode;

                // returns one error description in any locale
        for j:=0 to High(lcids) do begin
          pIErrorRecords.GetErrorInfo(i, lcids[j], pIErrorInfo2);
          if Assigned(pIErrorInfo2) then begin
            hr := pIErrorInfo2.GetDescription(ws);
            pIErrorInfo2 := nil;
            if Succeeded(hr) then begin
              if Length(sMsg) > 0 then
                sMsg := sMsg + CRLFString;
              if wsSqlState <> '' then
                sMsg := sMsg + 'SQLSTATE=' + OleStrToString(PWideChar(wsSqlState)) + '; ';
              sMsg := sMsg + OleStrToString(PWideChar(ws));
              Break;
            end;
          end;
        end;
      end;
    end else begin
	// The object doesn't support IErrorRecords;
      pIErrorInfo.GetDescription(ws);
      sMsg := OleStrToString(PWideChar(ws));
    end;
  end else begin
    MsgLen := FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
		nil,
		Status,
		LANG_USER_DEFAULT,
		@szMsg,
		0,
		nil);
    if MsgLen > 0 then begin
      sMsg := StrNew(szMsg);
      LocalFree( Cardinal(szMsg) );
    end else begin
      nErrCode := GetLastError;
      if nErrCode = ERROR_MR_MID_NOT_FOUND then
        sMsg := SErrErrorNotFound + IntToHex(Status, 8);
    end;
  end;
  raise ESDOleDbError.Create(Status, nNativeError, sMsg, nErrPos);
end;

procedure TIOleDbDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
  function AddTagSep(const CStr: string): string;
  var
    i: Integer;
  begin
    Result := '';
    for i:=Length(CStr) downto 1 do
      if CStr[i] <> ' ' then begin
        if CStr[i] <> ';' then
          Result := ';';
        Break;
      end;
  end;
var
  pDataInit: IDataInitialize;
  ConnStr: WideString;
  sSrvName, sDbName, s: string;
begin
  ASSERT( FIDBInitialize = nil );
  LoadSqlLib;

    	// if DSN/connection string with options
  if Pos('=', sRemoteDatabase) > 0 then begin
    ConnStr := sRemoteDatabase;
  end else begin
    sSrvName := ExtractServerName(sRemoteDatabase);
    sDbName  := ExtractDatabaseName(sRemoteDatabase);
    ConnStr := CT_PROVIDER + ProgID_SQLOLEDB + ';' + CT_DATASOURCE + sSrvName;
    FIsMSSQLProv := True;
    if sDbName <> '' then
      ConnStr := ConnStr + ';' + CT_INITCATALOG + sDbName;
  end;
        // if connection string does not contain username parameter
  if not CT_UserIDExists(ConnStr) and (sUserName <> '') then
    ConnStr := ConnStr + AddTagSep(ConnStr) + CT_USERID + sUserName;
    // if connection string does not contain password parameter
  if not CT_PasswordExists(ConnStr) and (sPassword <> '') then
    ConnStr := ConnStr + AddTagSep(ConnStr) + CT_PASSWORD + sPassword;

        // create first high-level unintialized datasource object(CoType TDataSource)
  pDataInit := CreateComObject(CLSID_DataLinks) as IDataInitialize;
        // generates a new uninitialized data source object based on the information in sConnect
  Check( pDataInit.GetDataSource(nil, CLSCTX_INPROC_SERVER,
      PWideChar(ConnStr), IID_IDBInitialize, IUnknown(FIDBInitialize)) );
  pDataInit := nil;

        //Initialize the data source object.
  SetDBInitProps( True, not CT_UserIDExists(ConnStr) );
  Check( FIDBInitialize.Initialize() );

  Check( FIDBInitialize.QueryInterface(IID_IDBCreateSession, FIDBCreateSession) );
        // create a session object and return the required interface of the session object
        // IDBCreateCommand is optional interface of session object (some provider do not support commands)
  Check( FIDBCreateSession.CreateSession(nil, IID_IDBCreateCommand, IUnknown(FIDBCreateCommand)) );

        // Is IMultipleResults supported
  FMultResultsSupported := StrToIntDef( OleDbGetDBPropValue([DBPROP_MULTIPLERESULTS]), 0 ) <> 0;
  FProcSupportsCursors  := FMultResultsSupported;       // procedures can return result set(-s)
        // check Output Parameter Availability
  FOutputParamsReturned := StrToIntDef( OleDbGetDBPropValue([DBPROP_OUTPUTPARAMETERAVAILABILITY]), 0 );
        // get Commit/Rollback behaviours
  FCursorPreservedOnCommit:=StrToIntDef( OleDbGetDBPropValue([DBPROP_PREPARECOMMITBEHAVIOR]), 0 ) = DBPROPVAL_CB_PRESERVE;
  FCursorPreservedOnRollback:=StrToIntDef( OleDbGetDBPropValue([DBPROP_PREPAREABORTBEHAVIOR]), 0 ) = DBPROPVAL_CB_PRESERVE;
  if not IsMSSQLProv then begin
    s := OleDbGetDBPropValue([DBPROP_PROVIDERFRIENDLYNAME]);
    FIsMSSQLProv := (Pos('Microsoft', s) > 0) and (Pos('SQL Server', s) > 0);
  end;
  SetDBInitProps( False, False );  
end;

procedure TIOleDbDatabase.DoDisconnect(Force: Boolean);
begin
  if Assigned(FITransaction) then
    DoRollback;
  FIDBCreateCommand := nil;
  FIDBCreateSession := nil;
  if Assigned( FIDBInitialize ) then
    FIDBInitialize.Uninitialize;
  FIDBInitialize := nil;
  FIsMSSQLProv := False;

  FreeSqlLib;
end;

// returns property value(-s) from Data Source Information group as string,
//where values are delimited using space
function TIOleDbDatabase.OleDbGetDBPropValue(APropIDs: array of DBPROPID): string;
var
  DBProperties: IDBProperties;
  PropIDSet: array[0..0] of TDBPropIDSet;
  prgPropertySets: PDBPropSet;
  PropSet: DBPropSet;
  nPropertySets: UINT;
  i: Integer;
  s: string;
begin
  Result := '';
  DBProperties := nil;
  Check( FIDBInitialize.QueryInterface(IID_IDBProperties, DBProperties) );
  try
    PropIDSet[0].rgPropertyIDs := @APropIDs;
    PropIDSet[0].cPropertyIDs  := High(APropIDs)+1;
    PropIDSet[0].guidPropertySet:=DBPROPSET_DATASOURCEINFO;
    nPropertySets := 0;
    prgPropertySets := nil;
    Check( DBProperties.GetProperties( 1, @PropIDSet, nPropertySets, prgPropertySets ) );
    ASSERT( nPropertySets = 1 );        // only one property set can be processed
    PropSet := prgPropertySets^;
    for i:=0 to PropSet.cProperties-1 do begin
      if PropSet.rgProperties^[i].dwStatus <> DBPROPSTATUS_OK then
        Continue;
      if Result <> '' then
        if PropSet.rgProperties^[i].dwPropertyID = DBPROP_DBMSVER then
          Result := Result + ' Release '
        else
          Result := Result + ' ';
      s := PropSet.rgProperties^[i].vValue;
      Result := Result + s;
    end;
        // free and clear elements of prgPropertySets^[0]
    for i:=0 to PropSet.cProperties-1 do
      VariantClear(PropSet.rgProperties^[i].vValue);
    CoTaskMemFree(PropSet.rgProperties);
        // free prgPropertySets
    CoTaskMemFree(prgPropertySets);
  finally
    DBProperties := nil;
  end;
end;

// if bInitPropSet is True then only properties of Initialization(DBPROPSET_DBINIT) properties group could be changed
// if bInitPropSet is False then other propeties group (except, Initialization) could be modified
// bIntegratedAuth means, when bInitPropSet is True
procedure TIOleDbDatabase.SetDBInitProps(bInitPropSet, bIntegratedAuth: Boolean);
const
  MaxPropCount = 20;
var
  pDBProps: IDBProperties;
  rgProperties: array[0..MaxPropCount-1] of TDBProp;
  rgPropertySets: DBPropSet;
  nProps: UINT;
  i: Integer;
  sValue: string;
  hr: HResult;
begin
  nProps := 0;
  pDBProps := nil;
  ASSERT( FIDBInitialize <> nil );
  Check( FIDBInitialize.QueryInterface(IID_IDBProperties, pDBProps) );
  try
        // initialize common property options
    for i:=0 to MaxPropCount-1 do begin
      rgProperties[i].dwOptions := DBPROPOPTIONS_REQUIRED;
      rgProperties[i].colid     := DB_NULLID;
      rgProperties[i].dwStatus  := 0;
      VariantInit( rgProperties[i].vValue );
    end;
    if bInitPropSet then begin
          // DBPROP_AUTH_INTEGRATED
      if bIntegratedAuth then begin
          // it is need to set vValue.vt = VT_BSTR, vValue.bstrVal = NULL
        rgProperties[nProps].dwPropertyID := DBPROP_AUTH_INTEGRATED;      // Integrated Security
        rgProperties[nProps].vValue       := '';                          // the default authentication service should be used
        Inc(nProps);
      end;
          // DBPROP_INIT_TIMEOUT and DBPROP_INIT_GENERALTIMEOUT
      sValue := Trim( Params.Values[szLOGINTIMEOUT] );
      if sValue <> '' then begin
        rgProperties[nProps].dwPropertyID := DBPROP_INIT_TIMEOUT;       // number of seconds
        rgProperties[nProps].vValue       := StrToIntDef(sValue, 0);
        Inc(nProps);
          // Indicates the number of seconds before a request, other than data source initialization and command execution, times out
        rgProperties[nProps].dwPropertyID := DBPROP_INIT_GENERALTIMEOUT;// number of seconds
        rgProperties[nProps].vValue       := StrToIntDef(sValue, 0);
        Inc(nProps);
      end;

      if nProps > 0 then begin
        rgPropertySets.guidPropertySet := DBPROPSET_DBINIT;
        rgPropertySets.cProperties := nProps;
        rgPropertySets.rgProperties := @rgProperties;

        hr := pDBProps.SetProperties( 1, TSDPtr(@rgPropertySets) );
        if not Succeeded( hr ) then
          if hr = DB_E_ERRORSOCCURRED then begin
            ResetIdleTimeOut;
            raise ESDOleDbError.Create(hr, hr, SErrDBPropsNotSupported + Format(' (error $%.8x in TIOleDbDatabase.SetDBInitProps)', [hr]), 0)
          end else
            Check(hr);

          // free and clear elements of rgPropertySets[]
        for i:=0 to nProps-1 do
          VariantInit( rgProperties[i].vValue );
      end;
        // set TDS packet size. It's supported for MSSQL provider only        
      sValue := Trim( Params.Values[szTDSPACKETSIZE] );
      if sValue <> '' then begin
        nProps := 0;
        rgProperties[nProps].dwPropertyID := SSPROP_INIT_PACKETSIZE;
        rgProperties[nProps].vValue       := StrToInt(sValue);
        Inc(nProps);

        rgPropertySets.guidPropertySet := DBPROPSET_SQLSERVERDBINIT;
        rgPropertySets.cProperties := nProps;
        rgPropertySets.rgProperties := @rgProperties;

        Check( pDBProps.SetProperties( 1, TSDPtr(@rgPropertySets) ) );

          // free and clear elements of rgPropertySets[]
        for i:=0 to nProps-1 do
          VariantInit( rgProperties[i].vValue );
      end;
    end else begin
          // force to use one session only (exclude implicitly spawning connections/sessions)
      if IsMSSQLProv then begin
        if IsSingleConn then begin
          nProps := 0;
          rgProperties[nProps].dwPropertyID := DBPROP_MULTIPLECONNECTIONS;
          rgProperties[nProps].vValue       := False;
          Inc(nProps);

          rgPropertySets.guidPropertySet := DBPROPSET_DATASOURCE;
          rgPropertySets.cProperties := nProps;
          rgPropertySets.rgProperties := @rgProperties;

          Check( pDBProps.SetProperties( 1, TSDPtr(@rgPropertySets) ) );

            // free and clear elements of rgPropertySets[]
          for i:=0 to nProps-1 do
            VariantInit( rgProperties[i].vValue );
        end;
      end;
    end;
  finally
    pDBProps := nil;
  end;
end;

function TIOleDbDatabase.GetClientVersion: LongInt;
begin
  Result := VersionStringToDWORD( OleDbGetDBPropValue([DBPROP_PROVIDERVER]) );
end;

function TIOleDbDatabase.GetServerVersion: LongInt;
begin
  Result := VersionStringToDWORD( OleDbGetDBPropValue([DBPROP_DBMSVER]) );
end;

function TIOleDbDatabase.GetVersionString: string;
begin
  Result := OleDbGetDBPropValue([DBPROP_DBMSNAME, DBPROP_DBMSVER]);
end;

procedure TIOleDbDatabase.DoCommit;
begin
  ASSERT( FITransaction <> nil );

	// SQL Server returns XACT_E_NOTSUPPORTED if fRetaining == TRUE
        // At general it is not necessary to start a new transaction for us
  Check( FITransaction.Commit(False, XACTTC_SYNC, 0) );
  FITransaction := nil;  
end;

procedure TIOleDbDatabase.DoRollback;
begin
  ASSERT( FITransaction <> nil );

  Check( FITransaction.Abort(nil, False, False) );
  FITransaction := nil;
end;

procedure TIOleDbDatabase.DoStartTransaction;
const
  IsolLevel: array[TISqlTransIsolation] of Integer =
  	(ISOLATIONLEVEL_READUNCOMMITTED,
         ISOLATIONLEVEL_READCOMMITTED,
         ISOLATIONLEVEL_REPEATABLEREAD
        );
begin
  ASSERT( FITransaction = nil );
  Check( FIDBCreateCommand.QueryInterface(IID_ITransactionLocal, FITransaction) );
  try
    Check( FITransaction.StartTransaction(IsolLevel[TransIsolation], 0, nil, nil) );
  except
    FITransaction := nil;
    raise;
  end;
end;

procedure TIOleDbDatabase.SetAutoCommitOption(Value: Boolean);
begin
  { nothing }
end;

procedure TIOleDbDatabase.SetTransIsolation(Value: TISqlTransIsolation);
begin
  { nothing }
end;

function TIOleDbDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;

function TIOleDbDatabase.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  Result := False;
        // DBPROP_CONNECTIONSTATUS property does not return a correct status, when a server is down 
  cmd := GetSchemaInfo(stSysTables, 'X.DUMMY');
  if Assigned(cmd) then begin
    Result := True;
    cmd.Free;
  end;
end;

function TIOleDbDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
var
  cmd: TIOleDbSchemaCommand;
begin
  cmd := nil;
  case ASchemaType of
    stTables,
    stSysTables:
    begin
      cmd := TIOleDbSchemaTables.Create(Self);
      cmd.ObjPattern := AObjectName;
      TIOleDbSchemaTables(cmd).SysTables := ASchemaType = stSysTables;
    end;
    stColumns:
    begin
      cmd := TIOleDbSchemaColumns.Create(Self);
      cmd.ObjPattern := AObjectName;
    end;
    stIndexes:
    begin
      cmd := TIOleDbSchemaIndexes.Create(Self);
      cmd.ObjPattern := AObjectName;
    end;
    stProcedures:
    begin
      cmd := TIOleDbSchemaProcs.Create(Self);
      cmd.ObjPattern := AObjectName;
    end;
    stProcedureParams:
    begin
      cmd := TIOleDbSchemaProcParams.Create(Self);
      cmd.ObjPattern := AObjectName;
    end;
  end;

  if Assigned(cmd) then
  try
    cmd.ExecDirect('');
  except
    cmd.Free;
    raise;
  end;

  Result := cmd;
end;

{ TIOleDbCommand }
constructor TIOleDbCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FICommandText := nil;
  FIMultipleResults:=nil;
  FIRowset      := nil;
  FIRowAccessor := nil;
  FRowBindPtr   := nil;
  FHRowAccessor := 0;
  FHParamAccessor:=0;
  FHRows        := nil;
  FIParamAccessor:= nil;
  FCurrRow      := 0;
  FRowsAffected := DB_COUNTUNAVAILABLE;
        // for optimization: exclude additional calls
  FPrefetchRows := SqlDatabase.PrefetchRows;
  FIsSingleConn := SqlDatabase.IsSingleConn;
	// by default IsSrvCursor = False  
  FIsSrvCursor  := UpperCase( Trim( SqlDatabase.Params.Values[szSERVERCURSOR] ) ) = STrueString;

  FFirstCalcFieldIdx := 0;
  FNextResults  := False;
end;

procedure TIOleDbCommand.Check(Status: HResult);
begin
  SqlDatabase.Check( Status );
end;

function TIOleDbCommand.GetSqlDatabase: TIOleDbDatabase;
begin
  Result := (inherited SqlDatabase) as TIOleDbDatabase;
end;

{ Marks a database handle as used by the current dataset }
procedure TIOleDbCommand.AcquireDBHandle;
begin
  if FIsSingleConn then
    SqlDatabase.ReleaseDBHandle(Self, True);
end;

{ Releases a database handle, which was used by the current dataset }
procedure TIOleDbCommand.ReleaseDBHandle;
begin
  if SqlDatabase.CurSqlCmd = Self then
    SqlDatabase.ReleaseDBHandle(nil, False);
end;

function TIOleDbCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
    DBTYPE_I2:          Result := ftSmallint;
    DBTYPE_I4:          Result := ftInteger;
    DBTYPE_R4,
    DBTYPE_R8:          Result := ftFloat;
    DBTYPE_CY:          Result := ftCurrency;
    DBTYPE_BOOL:        Result := ftBoolean;
    DBTYPE_DECIMAL,
    DBTYPE_NUMERIC:     Result := ftFloat;
    DBTYPE_UI1,
    DBTYPE_I1,
    DBTYPE_UI2:         Result := ftSmallint;
    DBTYPE_UI4:         Result := ftInteger;
    DBTYPE_UI8:         Result := {$IFDEF XSQL_VCL4} ftLargeInt {$ELSE} ftInteger {$ENDIF};
    DBTYPE_GUID:        Result := ftGuid;
    DBTYPE_DATE:        Result := ftDatetime;
    DBTYPE_BYTES:       Result := ftBytes;
    DBTYPE_WSTR,
    DBTYPE_STR:         Result := ftString;
    DBTYPE_DBDATE:      Result := ftDate;
    DBTYPE_DBTIME:      Result := ftTime;
    DBTYPE_DBTIMESTAMP: Result := ftDatetime;
  else
    Result := ftUnknown;
  end;
end;

function TIOleDbCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  { Converting from TFieldType to Program Data Type(OLEDB) }
  OleDbDataSizeMap: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, 	ftWord, 	ftBoolean
	0, SizeOf(SHORT), SizeOf(UINT), SizeOf(SHORT), SizeOf(SHORT),
	// ftFloat, 	ftCurrency, 		ftBCD, ftDate,	ftTime
        SizeOf(Double), SizeOf(Double),	0, 	0, 	0,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        0, 		0, 	0, 	SizeOf(UINT), 0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,	0,	0,   	0,	0,
        // ftTypedBinary, ftCursor
        0, 	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	SizeOf(TInt64),
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	SizeOfGuidBinary
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
{$IFDEF XSQL_VCL10},
        0,      0,      0,      0
{$ENDIF}
        );
begin
  case FieldType of
    ftDate: 	Result := SizeOf(TDBDate);
    ftTime: 	Result := SizeOf(TDBTime);
    ftDateTime:	Result := SizeOf(TDBTimeStamp);
  else
    Result := OleDbDataSizeMap[FieldType];
  end;
end;

function TIOleDbCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to C(Program) Data Type(ODBC) }
  OleDbDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean (TBooleanField.GetDataSize = 2)
	DBTYPE_STR, DBTYPE_I2, DBTYPE_I4, DBTYPE_UI2, DBTYPE_I2,
	// ftFloat, ftCurrency,   ftBCD, 	ftDate, 	ftTime
        DBTYPE_R8, DBTYPE_R8,   0, DBTYPE_DBDATE, DBTYPE_DBTIME,
        // ftDateTime, 		ftBytes, ftVarBytes, ftAutoInc, ftBlob
        DBTYPE_DBTIMESTAMP, DBTYPE_BYTES,DBTYPE_BYTES, DBTYPE_I4, DBTYPE_BYTES,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        DBTYPE_STR, 0, 0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	DBTYPE_I8,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	DBTYPE_GUID
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
{$IFDEF XSQL_VCL10},
        0,      0,      0,      0
{$ENDIF}
        );
begin
  Result := OleDbDataTypeMap[FieldType];
end;

function TIOleDbCommand.OleDbDataSourceType(FieldType: TFieldType): string;
const
  { Converting from TFieldType to Program Data Type(OLEDB) }
  OleDbDataSourceTypeMap: array[TFieldType] of string = ( '',	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean (TBooleanField.GetDataSize = 2)
	'DBTYPE_CHAR', 'DBTYPE_I2', 'DBTYPE_I4', 'DBTYPE_UI2', 'DBTYPE_I2',
	// ftFloat, ftCurrency,   ftBCD, 	ftDate, 	ftTime
        'DBTYPE_R8', 'DBTYPE_R8',   '', 'DBTYPE_DBDATE', 'DBTYPE_DBTIME',
        // ftDateTime, 		ftBytes, ftVarBytes, ftAutoInc, ftBlob
        'DBTYPE_DBTIMESTAMP', 'DBTYPE_BINARY','DBTYPE_VARBINARY', 'DBTYPE_I4', 'DBTYPE_LONGVARBINARY',
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        'DBTYPE_LONGVARCHAR', '', '',	'',	'',
        // ftTypedBinary, ftCursor
        '',	''
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        '',	'',	'DBTYPE_I8',
        // ftADT, ftArray, ftReference, ftDataSet
        '',	'',	'',	''
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        '',	'',	'',
        // ftInterface, ftIDispatch, ftGuid
        '',	'',	'DBTYPE_GUID'
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        '',      ''
{$ENDIF}
{$IFDEF XSQL_VCL10},
        '',      '',      '',      ''
{$ENDIF}
        );
begin
  Result := OleDbDataSourceTypeMap[FieldType];
end;

function TIOleDbCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := IsDateTimeType(FieldType) or (FieldType = ftGuid);
end;

procedure TIOleDbCommand.Connect;
begin
  Check( SqlDatabase.DBCreateCommand.CreateCommand(nil, IID_ICommandText, IUnknown(FICommandText)) );
end;

procedure TIOleDbCommand.Disconnect(Force: Boolean);
begin
        // release IParamAccessor before FICommandText
  FreeParamsBuffer;
  ReleaseDBHandle;
    
  FICommandText := nil;
  ReleaseRowset;
  FIMultipleResults:=nil;
end;

function TIOleDbCommand.GetHandle: PSDCursor;
begin
  Result := nil;
        // FICommandText is required in DoPrepare, but TIOleDbSchemaCommand do not use ICommandText interface at all
  if Assigned( FICommandText ) or ((Self is TIOleDbSchemaCommand) and (NativeCommand <> '')) then
    Result := Self;
end;

procedure TIOleDbCommand.CloseResultSet;
begin
  if FNextResults then begin
    ClearFieldDescs;
    Exit;
  end;

  ReleaseDBHandle;
  ReleaseRowset;
  FIMultipleResults:=nil;
end;

procedure TIOleDbCommand.DoPrepare(Value: string);
var
  pICommandPrepare: ICommandPrepare;
  hr: HResult;
begin
  AcquireDBHandle;

  SetICommandText(Value);
  SetICommandProps;

  pICommandPrepare := nil;
  try
    Check( FICommandText.QueryInterface(IID_ICommandPrepare, pICommandPrepare) );
    hr := pICommandPrepare.Prepare(0);
        // Prepare can return "Parameter Information cannot be derived from SQL statement with sub-select"
        // or "Syntax error or AV" depending on version of MSSQL provider, in case of SQL with with sub-select and a parameter placeholder
        // For example: "select F from T where F in (select F from T where F = :p)"
        // MSSQL provider returns the following "Unspecified error" (E_FAIL) in this case.
        // The same error code E_FAIL is returned, when "Connection is busy ..." or "Syntax error or AV" errors happen
    if (hr = E_FAIL) and SqlDatabase.IsMSSQLProv then begin
      SetICmdParameterInfo;
      hr := pICommandPrepare.Prepare(0);
    end;
    Check( hr );
  finally
    pICommandPrepare := nil;
  end;
end;

procedure TIOleDbCommand.SetICommandText(Value: string);
var
  guidDialect: TGUID;
  pwszCmd: PWideChar;
  sCmd: string;
begin
  if not Assigned( FICommandText ) then
    Connect;

  if CommandType = ctStoredProc then begin
    if Assigned(Params) and (Params.Count = 0) then
      InitParamList;

    sCmd := CreateProcedureCallCommand( Value, Params,
                Pos('Microsoft SQL Server', SqlDatabase.GetVersionString) = 0 );
  end else	// ctQuery
    sCmd := ReplaceParamMarkers( Value, Params );

  guidDialect := DBGUID_DEFAULT;
  pwszCmd := nil;
  try
    pwszCmd := AllocWideChar( sCmd );
    Check( FICommandText.SetCommandText({$IFNDEF XSQL_VCL6}@{$ENDIF}guidDialect, pwszCmd) );
  finally
    FreeWideChar( pwszCmd );
  end;

  SetNativeCommand(sCmd);
end;

procedure TIOleDbCommand.DoExecDirect(ACommandValue: string);
begin
  AcquireDBHandle;

  SetICommandText(ACommandValue);
  SetICommandProps;
//  SetICmdParameterInfo;

  AllocParamsBuffer;
  BindParamsBuffer;

  InternalExecute(True);
end;

procedure TIOleDbCommand.Execute;
begin
        // FIRowSet can be created in GetFieldFescs, when a statement could be not prepared by some reason (query with sub-select or schema rowset)
  if not Assigned(FIRowSet) then begin
    FreeParamsBuffer;
    AllocParamsBuffer;
    BindParamsBuffer;

    DoExecute;
  end;

  if Assigned(FIRowSet) and (FieldDescs.Count = 0) then
    InitFieldDescs;
  if FieldDescs.Count > 0 then begin
    if FieldsBuffer = nil then
      AllocFieldsBuffer;
	// it's required to set a select buffer after executing of the statement
    SetFieldsBuffer;
  end;
end;

procedure TIOleDbCommand.DoExecute;
begin
  InternalExecute(True);
end;

procedure TIOleDbCommand.InternalExecute(bFieldDescribe: Boolean);
var
  p: DBPARAMS;
  hr: HResult;
begin
  FRowsAffected := DB_COUNTUNAVAILABLE;
  if Params.Count > 0 then begin
    p.pData := ParamsBuffer;
    p.cParamSets := 1;
    p.HACCESSOR := FHParamAccessor;
  end else begin
    p.pData := nil;
    p.cParamSets := 0;
    p.HACCESSOR := 0;
  end;
        // server cursor supports only one rowset
  if (CommandType = ctStoredProc) and not IsSrvCursor then begin
        // do not execute, when the next(second or other) result set is processed
    if not FNextResults then begin
      Check( FICommandText.Execute(nil, IID_IMultipleResults, p, @FRowsAffected, PIUnknown(@FIMultipleResults)) );
      if Assigned( FIMultipleResults ) then
        repeat
          hr := FIMultipleResults.GetResult(nil, 0, IID_IRowset, @FRowsAffected, PIUnknown(@FIRowset));
          if hr = DB_S_NORESULT then
            Break;
        until Assigned(FIRowset);       // locate the first non-void result set of procedure
    end;
  end else
    Check( FICommandText.Execute(nil, IID_IRowset, p, @FRowsAffected, PIUnknown(@FIRowset)) );

  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if bFieldDescribe and (FieldDescs.Count = 0) and Assigned(FIRowset) then
    InitFieldDescs;
end;

function TIOleDbCommand.GetRowsAffected: Integer;
begin
  Result := FRowsAffected;
end;

function TIOleDbCommand.ResultSetExists: Boolean;
var
  pIColumnsInfo: IColumnsInfo;
  nColumns: UINT;
  ColInfoPtr: PDBColumnInfo;
  StringsBufferPtr: PWideChar;
begin
  Result := (CommandType = ctStoredProc) or (FieldDescs.Count > 0) or
            Assigned(FIRowset) or (Self is TIOleDbSchemaCommand);
  if Result or not Assigned(FICommandText) then
    Exit;

  Check( FICommandText.QueryInterface(IID_IColumnsInfo, pIColumnsInfo) );
  try
    if Assigned(pIColumnsInfo) then begin
      Check( pIColumnsInfo.GetColumnInfo(nColumns, ColInfoPtr, StringsBufferPtr) );
      Result := nColumns > 0;
    end;
  finally
    if Assigned(ColInfoPtr) then
      CoTaskMemFree(ColInfoPtr);
    if Assigned(StringsBufferPtr) then
      CoTaskMemFree(StringsBufferPtr);
    pIColumnsInfo := nil;
  end;
end;

procedure TIOleDbCommand.GetFieldDescs(Descs: TSDFieldDescList);
var
  pIColumnsInfo: IColumnsInfo;
  i, nColumns: UINT;
  ColInfoPtr: PDBColumnInfo;
  ColInfo: DBColumnInfo;
  StringsBufferPtr: PWideChar;
  FieldDesc: TSDFieldDesc;
  ft: TFieldType;
  sColName: string;
begin
  pIColumnsInfo := nil;
  ColInfoPtr := nil;
  StringsBufferPtr := nil;
  if Assigned(FIRowset) then
    Check( FIRowset.QueryInterface(IID_IColumnsInfo, pIColumnsInfo) )
  else if Assigned(FICommandText) and not ((CommandType = ctStoredProc) and FNextResults) then
    Check( FICommandText.QueryInterface(IID_IColumnsInfo, pIColumnsInfo) )
  else begin
    if not Assigned(FIRowset) then
      DoExecute;        // create IRowset, if TIOleDbSchemaCommand is used
    Check( FIRowset.QueryInterface(IID_IColumnsInfo, pIColumnsInfo) );
  end;
  ASSERT( pIColumnsInfo <> nil );
  try
    Check( pIColumnsInfo.GetColumnInfo(nColumns, ColInfoPtr, StringsBufferPtr) );

    if nColumns > 0 then        // to exclude 'Integer overflow', when UINT(nColumns)-1
    for i:=0 to nColumns-1 do begin
      ColInfo := DBColumnInfo( IncPtr(ColInfoPtr, i * SizeOf(ColInfo))^ );

      sColName := ColInfo.pwszName;
      ft := FieldDataType(ColInfo.wType);
      if ft = ftUnknown then
        DatabaseErrorFmt( SBadFieldType, [sColName] );
        // if the column contains very long data and the provider supports reading data through a storage interface
      if (ColInfo.dwFlags and DBCOLUMNFLAGS_ISLONG) <> 0 then
        if ft = ftString
        then ft := ftMemo
        else ft := ftBlob;

      if ft in [ftString] then
        Inc( ColInfo.ulColumnSize );     // increase buffer for null-terminator

      FieldDesc := Descs.AddFieldDesc;
      with FieldDesc do begin
        FieldName	:= sColName;
        FieldNo		:= ColInfo.iOrdinal;
        FieldType	:= ft;
        DataType	:= ColInfo.wType;
       	// it's necessary to save ColSize for varying string/byte and pseudo-blob fields
        if IsRequiredSizeTypes( ft ) //or IsPseudoBlob( FieldDesc )
        then DataSize	:= ColInfo.ulColumnSize
        else DataSize	:= NativeDataSize(FieldType);	// for SQL_INTEGER ColSize = 10 (instead of 4) (for MSSQL ODBC driver)
        Precision	:= ColInfo.bPrecision;
        Scale	        := ColInfo.bScale;
    	// if NullOk = 0 then null values are not permitted for the column (Required = True)
        Required	:= (ColInfo.dwFlags and DBCOLUMNFLAGS_ISNULLABLE) = 0;
      end;
    end;
    FFirstCalcFieldIdx := Descs.Count;
  finally
    if Assigned(ColInfoPtr) then
      CoTaskMemFree(ColInfoPtr);
    if Assigned(StringsBufferPtr) then
      CoTaskMemFree(StringsBufferPtr);
    pIColumnsInfo := nil;
  end;
end;

function TIOleDbCommand.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
var
  Year: Smallint;
  wYear, Month, Day, Hour, Min, Sec, MSec: Word;
  ptr: TSDPtr;
  t: TDBTime;
  d: TDBDate;
  ts:TDBTimeStamp;
begin
  Result := 0;

  if NativeDataSize(ADataType) > BufSize then
    DatabaseError(SInsufficientIDateTimeBufSize);
	// it's necessary for ftDate
  Hour	:= 0;
  Min	:= 0;
  Sec	:= 0;
  Year  := 0;

  if ADataType in [ftTime, ftDateTime] then
    DecodeTime(Value, Hour, Min, Sec, MSec);
  if ADataType in [ftDate, ftDateTime] then begin
    DecodeDate(Value, wYear, Month, Day);
    Year := wYear;
  end;

  ptr := Buffer;

  case ADataType of
    ftTime:
      begin
      	t.hour	:= Hour;
        t.minute:= Min;
        t.second:= Sec;
{$IFDEF XSQL_CLR}
        Marshal.StructureToPtr( t, ptr, False );
{$ELSE}
        TDBTime(ptr^)	:= t;
{$ENDIF}
        Result := SizeOf(TDBTime);
      end;
    ftDate:
      begin
        d.year	:= Year;
        d.month	:= Month;
        d.day	:= Day;
{$IFDEF XSQL_CLR}
        Marshal.StructureToPtr( d, ptr, False );
{$ELSE}
        TDBDate(ptr^)	:= d;
{$ENDIF}
        Result := SizeOf(TDBDate);
      end;
    ftDateTime:
      begin
        ts.hour		:= Hour;
        ts.minute	:= Min;
        ts.second	:= Sec;
        ts.fraction	:= MSec*1000*1000;
        ts.year		:= Year;
        ts.month	:= Month;
        ts.day		:= Day;
{$IFDEF XSQL_CLR}
        Marshal.StructureToPtr( ts, ptr, False );
{$ELSE}
        TDBTimeStamp(ptr^) := ts;
{$ENDIF}
        Result := SizeOf(TDBTimeStamp);
      end
  end;
end;

procedure TIOleDbCommand.AllocParamsBuffer;
var
  nParams: Integer;
begin
  inherited;

  if not Assigned(Params) then
    Exit;
  nParams := Params.Count;
  if nParams > 0 then begin
    FParamBindPtr := SafeReallocMem( nil, nParams * SizeOf(DBBINDING) );
    SafeInitMem( FParamBindPtr, nParams * SizeOf(DBBINDING), 0 );
  end;
end;

function TIOleDbCommand.GetParamsBufferSize: Integer;
var
  i, nBlobCount: Integer;
begin
  Result := inherited GetParamsBufferSize;
  FBlobParamsBufferOff := Result;

  if not Assigned(Params) then
    Exit;

  nBlobCount := 0;
  for i := 0 to Params.Count -1 do
    if IsBlobType(Params[i].DataType) then
      Inc(nBlobCount);
	// buffers to save pointer to data of Blobs parameters
  Result := FBlobParamsBufferOff + nBlobCount * SizeOf(TSDPtr);
end;

procedure TIOleDbCommand.FreeParamsBuffer;
var
  i, nBlobCount: Integer;
  BlobPtr: TSDPtr;
begin
  if FHParamAccessor <> 0 then
    Check( FIParamAccessor.ReleaseAccessor(FHParamAccessor, nil) );
  FHParamAccessor := 0;
  FIParamAccessor := nil;

  FParamBindPtr := SafeReallocMem( FParamBindPtr, 0 );
  if Assigned(ParamsBuffer) and Assigned(Params) then begin
    nBlobCount := 0;
          // release blob buffers, which was allocated using IMalloc
    for i:=0 to Params.Count-1 do begin
      if not IsBlobType(Params[i].DataType) then
        Continue;
      BlobPtr := HelperMemReadPtr( ParamsBuffer, FBlobParamsBufferOff + nBlobCount*SizeOf(BlobPtr) );
      CoTaskMemFree( BlobPtr );

      Inc(nBlobCount);
    end;
  end;

  inherited;
end;

procedure TIOleDbCommand.BindParamsBuffer;
var
  BindPtr: PDBBinding;
  BindDataType, nBlobCount: Integer;
  CurPtr, DataPtr: TSDValueBuffer;
  i, DataLen, nOffset, nStrLen: Integer;
  FieldInfo: TSDFieldInfo;
  BlobPtr: TSDPtr;
begin
  if not Assigned( Params ) or ( Params.Count = 0 ) then
    Exit;

  if not Assigned( ParamsBuffer ) then
    AllocParamsBuffer;

  ASSERT( FParamBindPtr <> nil );

  nOffset := 0;
  nBlobCount := 0;

  for i:=0 to Params.Count-1 do begin
    CurPtr := IncPtr( ParamsBuffer, nOffset );
    FieldInfo := GetFieldInfoStruct(CurPtr, 0);
    FieldInfo.DataSize := 0;
    BindDataType := NativeDataType(Params[i].DataType);
    DataLen := NativeParamSize( Params[i] );
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );

    if Params[i].IsNull then
      FieldInfo.FetchStatus := DBSTATUS_S_ISNULL
    else
      FieldInfo.FetchStatus := DBSTATUS_S_OK;
    FieldInfo.DataSize := DataLen;

    case Params[i].DataType of
      ftString:
        begin
          if DataLen > 0 then begin
                // in case of procedure DataLen can be more than actual length of string
            nStrLen := MinIntValue(DataLen-1, Length(Params[i].AsString));
            HelperMemWriteString( DataPtr, 0, Params[i].AsString, nStrLen );
            HelperMemWriteByte( DataPtr, nStrLen, 0 );
                // set actual length without a null-termination character (DataLen is max parameter buffer in case of procedure)
            FieldInfo.DataSize := nStrLen;
          end;
        end;
{$IFDEF XSQL_VCL5}
      ftGuid:
        if DataLen > 0 then begin
          if Params[i].AsString <> '' then
            PGUID( DataPtr )^ := StringToGuid( Params[i].AsString )
          else begin
            FieldInfo.FetchStatus := DBSTATUS_S_ISNULL;
            FieldInfo.DataSize := 0;
          end;
        end;
{$ENDIF}
      ftBytes,
      ftVarBytes:
        if DataLen > 0 then begin
          SafeInitMem( DataPtr, DataLen, 0 );
          Params[i].GetData( DataPtr );
        end;
      ftBoolean:
        if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, Ord( Params[i].AsBoolean ) );
      ftInteger,
      ftAutoInc:
        if DataLen > 0 then HelperMemWriteInt32( DataPtr, 0, Params[i].AsInteger );
      ftSmallInt:
        if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, Params[i].AsInteger );
{$IFDEF XSQL_VCL4}
      ftLargeInt:
        if DataLen > 0 then HelperMemWriteInt64( DataPtr, 0, Params[i].AsInteger );
{$ENDIF}
      ftDate, ftTime, ftDateTime:
        if DataLen > 0 then CnvtDateTime2DBDateTime(Params[i].DataType, Params[i].AsDateTime, DataPtr, NativeDataSize(Params[i].DataType));
      ftCurrency,
      ftFloat:
        if DataLen > 0 then HelperMemWriteDouble( DataPtr, 0, Params[i].AsFloat );
      else
        if not IsSupportedBlobTypes(Params[i].DataType) then
          raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
    end;

    BindPtr := IncPtr( FParamBindPtr, i * SizeOf(TDBBinding) );
    if IsBlobType(Params[i].DataType) then begin
      BindDataType   := BindDataType or DBTYPE_BYREF;
      FieldInfo.DataSize := Length( Params[i].AsString );
        // allocate blob buffer using IMalloc
      BlobPtr := CoTaskMemAlloc( FieldInfo.DataSize );
      HelperMemWriteString( BlobPtr, 0, Params[i].AsString, FieldInfo.DataSize );
      HelperMemWritePtr( ParamsBuffer, FBlobParamsBufferOff+nBlobCount*SizeOf(BlobPtr), BlobPtr );
      BindPtr^.obValue := FBlobParamsBufferOff+nBlobCount*SizeOf(BlobPtr);

      Inc(nBlobCount);
    end;
    SetFieldInfoStruct( CurPtr, 0, FieldInfo );

    BindPtr^.iOrdinal   := i+1;
    if not IsBlobType( Params[i].DataType ) then begin
      BindPtr^.obValue  := nOffset + SizeOf(TSDFieldInfo);
    end;
    BindPtr^.obLength   := nOffset + GetFieldInfoDataSizeOff;
    BindPtr^.obStatus   := nOffset + GetFieldInfoFetchStatusOff;
    BindPtr^.pTypeInfo  := nil;
    BindPtr^.pObject    := nil;
    BindPtr^.pBindExt   := nil;
    BindPtr^.dwPart     := DBPART_STATUS or DBPART_LENGTH or DBPART_VALUE;
    BindPtr^.dwMemOwner := DBMEMOWNER_CLIENTOWNED;
    BindPtr^.eParamIO   := DBPARAMIO_NOTPARAM;  // = 0
    if Params[i].ParamType in [ptInput, ptInputOutput] then
      BindPtr^.eParamIO   := DBPARAMIO_INPUT;
    if Params[i].ParamType in [ptResult, ptInputOutput, ptOutput] then
      BindPtr^.eParamIO   := BindPtr^.eParamIO or DBPARAMIO_OUTPUT;
    BindPtr^.cbMaxLen   := DataLen;     // max length of allocated parameter buffer
    BindPtr^.dwFlags    := 0;
    BindPtr^.wType      := BindDataType;
    BindPtr^.bPrecision := 0;
    BindPtr^.bScale     := 0;

    nOffset := nOffset + SizeOf(TSDFieldInfo) + DataLen;
  end;

  if not Assigned( FIParamAccessor ) then begin
    ASSERT( Assigned( FICommandText ) );
    Check( FICommandText.QueryInterface( IID_IAccessor, FIParamAccessor ) );
    try
        // create accessor to retrieve row data, when DBBindingArray was filled
      Check( FIParamAccessor.CreateAccessor(
                DBACCESSOR_PARAMETERDATA, Params.Count,
                PDBBindingArray(FParamBindPtr),
                0, FHParamAccessor, nil)
      );
    except
      FIParamAccessor := nil;
      raise;
    end;
  end;
end;

procedure TIOleDbCommand.AllocFieldsBuffer;
var
  nFields: Integer;
begin
  inherited;

  nFields := FieldDescs.Count;
  if nFields > 0 then begin
    FRowBindPtr := SafeReallocMem( nil, nFields * SizeOf(DBBINDING) );
    SafeInitMem( FRowBindPtr, nFields * SizeOf(DBBINDING), 0 );
  end;
end;

procedure TIOleDbCommand.FreeFieldsBuffer;
begin
  ReleaseHRows;
  if not FNextResults then
    ReleaseRowSet;

  FRowBindPtr := SafeReallocMem( FRowBindPtr, 0 );

  inherited;
end;

function TIOleDbCommand.GetFieldsBufferSize: Integer;
begin
  Result := inherited GetFieldsBufferSize;
end;

procedure TIOleDbCommand.SetFieldsBuffer;
var
  BindPtr: PDBBinding;
  BindDataSize: UINT;
  BindDataType: Integer;
  i, nBindFields, nFldBufOffset: Integer;
begin
  ASSERT( ((FieldDescs.Count = 0) and (FRowBindPtr = nil)) or ((FieldDescs.Count > 0) and (FRowBindPtr <> nil)) );
  nFldBufOffset := 0;
  nBindFields := 0;

  for i:=0 to FieldDescs.Count-1 do begin
    if FieldDescs[i].FieldNo <= 0 then
      Continue;

    BindDataType := NativeDataType( FieldDescs[i].FieldType );
    if BindDataType = 0 then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );
    BindDataSize := FieldDescs[i].DataSize;

    if i < FFirstCalcFieldIdx then begin
      BindPtr := IncPtr( FRowBindPtr, i * SizeOf(TDBBinding) );

      BindPtr^.iOrdinal   := nBindFields + 1;
      BindPtr^.obValue    := nFldBufOffset + SizeOf(TSDFieldInfo);
      BindPtr^.obLength   := nFldBufOffset + GetFieldInfoDataSizeOff;
      BindPtr^.obStatus   := nFldBufOffset + GetFieldInfoFetchStatusOff;
      BindPtr^.pTypeInfo  := nil;
      BindPtr^.pObject    := nil;
      BindPtr^.pBindExt   := nil;
      if IsBlobType(FieldDescs[i].FieldType) then
        BindPtr^.dwPart   := DBPART_STATUS
      else
        BindPtr^.dwPart   := DBPART_STATUS or DBPART_LENGTH or DBPART_VALUE;
      BindPtr^.dwMemOwner := DBMEMOWNER_CLIENTOWNED;
      BindPtr^.eParamIO   := DBPARAMIO_NOTPARAM;
      BindPtr^.cbMaxLen   := BindDataSize;
      BindPtr^.dwFlags    := 0;
      BindPtr^.wType      := BindDataType;
      BindPtr^.bPrecision := FieldDescs[i].Precision;
      BindPtr^.bScale     := FieldDescs[i].Scale;

      Inc(nBindFields);
    end;

    Inc( nFldBufOffset, SizeOf(TSDFieldInfo) + BindDataSize);
  end;

  if (FieldDescs.Count > 0) and not Assigned( FIRowAccessor ) then begin
    ASSERT( FIRowSet <> nil );
    Check( FIRowset.QueryInterface( IID_IAccessor, FIRowAccessor ) );
    try
        // create accessor to retrieve row data, when DBBindingArray was filled
      Check( FIRowAccessor.CreateAccessor(
                DBACCESSOR_ROWDATA, nBindFields,
                PDBBindingArray(FRowBindPtr),
                0, FHRowAccessor, nil)
      );
    except
      FIRowAccessor := nil;
      raise;
    end;
  end;
end;

function TIOleDbCommand.FetchNextRow: Boolean;
begin
  Result := False;
  if not Assigned(FIRowset) then
    Exit;
  if FCurrRow >= FFetchedRows then begin
    ReleaseHRows;
    Check( FIRowset.GetNextRows( DB_NULL_HCHAPTER, 0, FPrefetchRows, FFetchedRows, FHRows ) );
  end;

  if FFetchedRows > 0 then begin
    Check( FIRowset.GetData( FHRows[FCurrRow], FHRowAccessor, FieldsBuffer ) );

    if BlobFieldCount > 0 then
      FetchBlobFields;

    Inc( FCurrRow );
    Result := True;
  end;
  if not Result then
    ReleaseDBHandle;
end;

procedure TIOleDbCommand.ReleaseHRows;
begin
  if not Assigned( FHRows ) then
    Exit;
  ASSERT( FIRowSet <> nil );
  Check( FIRowSet.ReleaseRows( FFetchedRows, FHRows, nil, nil, nil ) );
  FCurrRow := 0;
  FFetchedRows := 0;
  CoTaskMemFree( FHRows );
  FHRows := nil;
end;

// IRowSet.ReleaseRows and FIRowAccessor.ReleaseAccessor have to be called before FIRowSet will be destroyed
procedure TIOleDbCommand.ReleaseRowSet;
begin
  ReleaseHRows;

  if FHRowAccessor <> 0 then
    Check( FIRowAccessor.ReleaseAccessor(FHRowAccessor, nil) );
  FHRowAccessor := 0;
  FIRowAccessor := nil;

  FIRowSet := nil;
end;

function TIOleDbCommand.NextResultSet: Boolean;
var
  hr: HResult;
begin
  Result := False;

  if not Assigned( FIMultipleResults ) then
    Exit;

  ReleaseRowSet;    
  FRowsAffected := DB_COUNTUNAVAILABLE;
  hr := FIMultipleResults.GetResult(nil, 0, IID_IRowset, @FRowsAffected, PIUnknown(@FIRowset));
  Check( hr );
  if Assigned( FIRowSet ) then begin
    FNextResults := True;       // it is checked in FreeFieldsBuffer
    FreeFieldsBuffer;
    Result := True;
  end;
  if hr = DB_S_NORESULT then begin
    ReleaseRowSet;
    FIMultipleResults := nil;
    
    InternalSpGetParams;
  end;
end;

procedure TIOleDbCommand.GetOutputParams;
begin
        // output parameter data is available at the time the rowset is completely released
  if SqlDatabase.OutputParamsReturned = DBPROPVAL_OA_ATROWRELEASE then begin
	// fetch all rows for the current result set
    SaveResults;
	// output buffers are not guaranteed to be set until all result sets/row counts have been processed
    if Assigned(FIRowSet) then begin
        // NextResultSet calls InternalSpGetParams too, when it is necessary
      while NextResultSet do
        ;
    end else
      InternalSpGetParams;    
  end else
    InternalSpGetParams;
    
  ReleaseDBHandle;
end;

procedure TIOleDbCommand.InternalSpGetParams;
var
  i, MaxParamSize: Integer;
  FldBuf, OutData: TSDValueBuffer;
  bIsNull: Boolean;
  FieldInfo: TSDFieldInfo;
begin
  if ParamsBuffer = nil then Exit;
	// Alloc buffer for parameter of max size, which could be bigger 255 byte
  MaxParamSize := MaxCharParamSize+1;
  OutData := SafeReallocMem(nil, MaxParamSize);

  try
    FldBuf := ParamsBuffer;
    for i := 0 to Params.Count - 1 do begin
      if Params[i].ParamType in [ptResult, ptInputOutput, ptOutput] then begin
        FieldInfo := GetFieldInfoStruct(FldBuf, 0);
                // if FieldInfo.DataSize is not assigned
        if (FieldInfo.FetchStatus <> DBSTATUS_S_ISNULL) and (FieldInfo.DataSize <= 0) then
          FieldInfo.DataSize := NativeParamSize(Params[i]);
          // DataSize has to contain length w/o null-terminator in in GetCnvtFieldData method
        if Params[i].DataType = ftString then
          Dec( FieldInfo.DataSize );
        SetFieldInfoStruct(FldBuf, 0, FieldInfo);
        bIsNull := not CnvtDBData('', Params[i].DataType, FldBuf, OutData, MaxParamSize);

        if bIsNull then
          Params[i].Clear
        else
          Params[i].SetData(OutData);
      end;
      FldBuf := IncPtr( FldBuf, NativeParamSize(Params[i]) + SizeOf(TSDFieldInfo) );
    end;
  finally
    SafeReallocMem(OutData, 0);
  end;
end;

procedure TIOleDbCommand.SetICommandProps;
const
  MaxPropCount = 20;
var
  CmdProps: ICommandProperties;
  rgProperties: array[0..MaxPropCount-1] of TDBProp;
  rgPropertySets: DBPropSet;
  nProps: UINT;
  i: Integer;
  sValue: string;
begin
  nProps := 0;
  CmdProps := nil;
  Check( FICommandText.QueryInterface(IID_ICommandProperties, CmdProps) );
  try
        // initialize common property options
    for i:=0 to MaxPropCount-1 do begin
      rgProperties[i].dwOptions := DBPROPOPTIONS_REQUIRED;
      rgProperties[i].colid     := DB_NULLID;
      VariantInit( rgProperties[i].vValue );
    end;

        // Set up the properties to get a FAST_FORWARD read-only server cursor
    if IsSrvCursor then begin
      rgProperties[nProps].dwPropertyID := DBPROP_SERVERCURSOR;
      rgProperties[nProps].vValue       := True;
      Inc(nProps);

      rgProperties[nProps].dwPropertyID := DBPROP_OTHERINSERT;
      rgProperties[nProps].vValue       := True;
      Inc(nProps);

      rgProperties[nProps].dwPropertyID := DBPROP_OTHERUPDATEDELETE;
      rgProperties[nProps].vValue       := True;
      Inc(nProps);

      rgProperties[nProps].dwPropertyID := DBPROP_OWNINSERT;
      rgProperties[nProps].vValue       := True;
      Inc(nProps);

      rgProperties[nProps].dwPropertyID := DBPROP_OWNUPDATEDELETE;
      rgProperties[nProps].vValue       := True;
      Inc(nProps);
    end;

        // DBPROP_COMMANDTIMEOUT
    sValue := Trim( SqlDatabase.Params.Values[szCMDTIMEOUT] );
    if sValue <> '' then begin
      rgProperties[nProps].dwPropertyID := DBPROP_COMMANDTIMEOUT;       // number of seconds
      rgProperties[nProps].vValue       := StrToIntDef(sValue, 0);
      Inc(nProps);
    end;
        // set on DBPROP_IMultipleResults in case of execution stored procedure
    if not IsSrvCursor and (CommandType = ctStoredProc) and SqlDatabase.MultResultsSupported then begin
      rgProperties[nProps].dwPropertyID := DBPROP_IMultipleResults;
      rgProperties[nProps].vValue       := True;
      Inc(nProps);

      rgProperties[nProps].dwPropertyID := DBPROP_SKIPROWCOUNTRESULTS;
      rgProperties[nProps].vValue       := False;
      Inc(nProps);
    end;

    if nProps > 0 then begin
      rgPropertySets.guidPropertySet := DBPROPSET_ROWSET;
      rgPropertySets.cProperties := nProps;
      rgPropertySets.rgProperties := @rgProperties;

      Check( CmdProps.SetProperties( 1, TSDPtr(@rgPropertySets) ) );

        // free and clear elements of rgPropertySets[]
      for i:=0 to nProps-1 do
        VariantInit( rgProperties[i].vValue );
    end;
        // MS SQL Server properties
    if not IsSrvCursor and SqlDatabase.IsMSSQLProv then begin
      nProps := 0;
        // turn off deferred prepare
      rgProperties[nProps].dwPropertyID := SSPROP_DEFERPREPARE;
      rgProperties[nProps].vValue       := False;
      Inc(nProps);

      rgPropertySets.guidPropertySet := DBPROPSET_SQLSERVERROWSET;
      rgPropertySets.cProperties := nProps;
      rgPropertySets.rgProperties := @rgProperties;

      Check( CmdProps.SetProperties( 1, TSDPtr(@rgPropertySets) ) );

        // free and clear elements of rgPropertySets[]
      for i:=0 to nProps-1 do
        VariantInit( rgProperties[i].vValue );
    end;
  finally
    CmdProps := nil;
  end;
end;

procedure TIOleDbCommand.SetICmdParameterInfo;

  function GetDBParamBindInfo(Buffer: TSDPtr; Index: Integer): TDBParamBindInfo;
  begin
    Result := TDBParamBindInfo( IncPtr(Buffer, Index*SizeOf(Result))^ );
  end;
  procedure SetDBParamBindInfo(Buffer: TSDPtr; Index: Integer; Value: TDBParamBindInfo);
  begin
    TDBParamBindInfo( IncPtr(Buffer, Index*SizeOf(Value))^ ) := Value;
  end;

var
  i: Integer;
  pICmdWithParams: ICommandWithParameters;
  aParamOrds: PUINT;
  aParamInfo: PDBParamBindInfo;
  pi: TDBParamBindInfo;
begin
  if not Assigned( Params ) or ( Params.Count = 0 ) then
    Exit;

  aParamOrds := SafeReallocMem(nil, Params.Count * SizeOf(UINT));
  aParamInfo := SafeReallocMem(nil, Params.Count * SizeOf(TDBParamBindInfo));

  for i:=0 to Params.Count-1 do begin
    UINT( IncPtr(aParamOrds, i*SizeOf(UINT))^ ) := i+1;
    pi := GetDBParamBindInfo( aParamInfo, i );
    pi.pwszDataSourceType := AllocWideChar( OleDbDataSourceType(Params[i].DataType) );
        // set to null for all parameters to exclude error DB_E_BADPARAMETERNAME ("Parameter name is unrecognized"),
        //when query with sub-select has some parameters with one name
    pi.pwszName       := nil;
    pi.ulParamSize    := NativeParamSize( Params[i] );
        // If nullability is unknown, this flag is set
    pi.dwFlags        := DBPARAMFLAGS_ISNULLABLE;
    if Params[i].ParamType in [ptInput, ptInputOutput] then
      pi.dwFlags        := pi.dwFlags or DBPARAMFLAGS_ISINPUT
    else if Params[i].ParamType in [ptInputOutput, ptOutput, ptResult] then
      pi.dwFlags        := pi.dwFlags or DBPARAMFLAGS_ISOUTPUT;
    if IsBlobType(Params[i].DataType) then
      pi.dwFlags        := pi.dwFlags or DBPARAMFLAGS_ISLONG;
    pi.bPrecision     := 0;
    pi.bScale         := 0;

    SetDBParamBindInfo( aParamInfo, i, pi );
  end;
        // ICommandWithParameters is used, because IID_ICommandWithParameters(OLEDB.pas) has an invalid value in D5-D9(2005)
  Check( FICommandText.QueryInterface(ICommandWithParameters, pICmdWithParams) );
  try
    if Assigned(pICmdWithParams) then
      Check( pICmdWithParams.SetParameterInfo(Params.Count, TSDPtr(aParamOrds), TSDPtr(aParamInfo)) );
  finally
    pICmdWithParams := nil;

    for i:=0 to Params.Count-1 do begin
      pi := GetDBParamBindInfo( aParamInfo, i );
      FreeWideChar( pi.pwszDataSourceType );
      FreeWideChar( pi.pwszName );
    end;
    SafeReallocMem(aParamOrds, 0);
    SafeReallocMem(aParamInfo, 0);
  end;
end;

function TIOleDbCommand.CnvtDBDateTime2DateTimeRec(ADataType: TFieldType;
  Buffer: TSDPtr; BufSize: Integer): TDateTimeRec;
var
  dtDate, dtTime: TDateTime;
  t: TDBTime;
  d: TDBDate;
  ts:TDBTimeStamp;
begin
  case ADataType of
    ftTime:
      begin
{$IFDEF XSQL_CLR}
        t := TDBTime( Marshal.PtrToStructure( Buffer, TypeOf(TDBTime) ) );
{$ELSE}
        t := TDBTime( Buffer^ );
{$ENDIF}
        dtTime := EncodeTime( t.hour, t.minute, t.second, 0 );
        Result.Time := DateTimeToTimeStamp(dtTime).Time;
      end;
    ftDate:
      begin
{$IFDEF XSQL_CLR}
        d := TDBDate( Marshal.PtrToStructure( Buffer, TypeOf(TDBDate) ) );
{$ELSE}
        d := TDBDate( Buffer^ );
{$ENDIF}
        dtDate := EncodeDate( d.year, d.month, d.day );
        Result.Date := DateTimeToTimeStamp(dtDate).Date;
      end;
    ftDateTime:
      begin
{$IFDEF XSQL_CLR}
        ts := TDBTimeStamp( Marshal.PtrToStructure( Buffer, TypeOf(TDBTimeStamp) ) );
{$ELSE}
        ts := TDBTimeStamp( Buffer^ );
{$ENDIF}
        dtTime := EncodeTime( ts.hour, ts.minute, ts.second, 0 );
    	dtDate := EncodeDate( ts.year, ts.month, ts.day );
        Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) ) +
        			ts.fraction div 1000000;	// plus milliseconds
      end
  else
    Result.DateTime := 0.0;
  end;
end;

function TIOleDbCommand.CnvtDBData(AFieldName: string; ADataType: TFieldType; InBuf, Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InData, OutData: TSDPtr;
  FieldInfo: TSDFieldInfo;
  dtDateTime: TDateTimeRec;
  nSize: Integer;
begin
  FieldInfo := GetFieldInfoStruct(InBuf, 0);
  if FieldInfo.FetchStatus = DBSTATUS_E_CANTCONVERTVALUE then
    DatabaseErrorFmt(SCantConvertFieldValueFmt, [AFieldName]);
  Result := FieldInfo.FetchStatus <> DBSTATUS_S_ISNULL;
  if not Result then
    Exit;

  nSize         := FieldInfo.DataSize;
  InData	:= IncPtr( InBuf, SizeOf(TSDFieldInfo) );
  OutData	:= Buffer;

  if RequiredCnvtFieldType(ADataType) then begin
    if IsDateTimeType(ADataType) then begin
      if Result then begin
        dtDateTime := CnvtDBDateTime2DateTimeRec(ADataType, InData, FieldInfo.DataSize);
        HelperMemWriteDateTimeRec(OutData, 0, dtDateTime);	// buffer size is SizeOf(TDateTimeRec)
      end;
    end else if ADataType = ftGuid then begin
        // GUID in binary format requires 16 bytes, in string format - 38 bytes
      GuidToCharBuffer(InData, FieldInfo.DataSize, OutData, BufSize);
    end else
      ASSERT( False, SFieldTypeNotConverted + FieldTypeNames[ADataType] + '('+AFieldName+')' );
  end else begin
    if nSize > BufSize then
      nSize := BufSize;
    SafeCopyMem( InData, OutData, nSize );
    if ADataType = ftString then begin
      if nSize = BufSize then
        Dec(nSize);
      HelperMemWriteByte( OutData, nSize, $0 );       // = PChar(OutData)[nSize] := #$0;
      if SqlDatabase.IsRTrimChar then
        StrRTrim( OutData );
    end;
  end;
end;

function TIOleDbCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf: TSDPtr;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);

  Result := CnvtDBData('', AFieldDesc.FieldType, InBuf, Buffer, BufSize);
end;

function TIOleDbCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
type
  TBlobStorage = record
    IStream: ISequentialStream;
    dwLenght: ULONG;
    dwStatus: ULONG;
  end;
var
  dbobj: TDBObject;
  dbbind:TDBBinding;
  pIBlobAccessor: IAccessor;
  hBlobAccessor: HACCESSOR;
  BlobStorage: TBlobStorage;
  nBlobSize, nReadBytes, i: Longint;
  PiecePtr: TSDValueBuffer;
begin
  Result := 0;
  PiecePtr := nil;
  pIBlobAccessor:= nil;
  hBlobAccessor := 0;

	// Set up the DBOBJECT structure.
  dbobj.dwFlags := STGM_READ;
  dbobj.iid := IID_ISequentialStream;

  BlobStorage.IStream := nil;
  BlobStorage.dwLenght:= 0;
  BlobStorage.dwStatus:= 0;

    // Create the DBBINDING, requesting a storage-object pointer from SQLOLEDB.
  dbbind.iOrdinal       := AFieldDesc.FieldNo;
  dbbind.obValue        := 0;
  dbbind.obLength       := Longint(@BlobStorage.dwLenght) - Longint(@BlobStorage);
  dbbind.obStatus       := Longint(@BlobStorage.dwStatus) - Longint(@BlobStorage);
  dbbind.pTypeInfo      := nil;
  dbbind.pObject        := @dbobj;
  dbbind.pBindExt       := nil;
  dbbind.dwPart         := DBPART_VALUE or DBPART_LENGTH or DBPART_STATUS;
  dbbind.dwMemOwner     := DBMEMOWNER_CLIENTOWNED;
  dbbind.eParamIO       := DBPARAMIO_NOTPARAM;
  dbbind.cbMaxLen       := 0;
  dbbind.dwFlags        := 0;
  dbbind.wType          := DBTYPE_IUNKNOWN;
  dbbind.bPrecision     := 0;
  dbbind.bScale         := 0;

  try
    Check( FIRowSet.QueryInterface( IID_IAccessor, pIBlobAccessor ) );
    Check( pIBlobAccessor.CreateAccessor( DBACCESSOR_ROWDATA, 1, @dbbind, 0, hBlobAccessor, nil ) );
    Check( FIRowSet.GetData( FHRows[FCurrRow], hBlobAccessor, @BlobStorage ) );
    if BlobStorage.dwStatus <> DBSTATUS_S_ISNULL then begin
      ASSERT( BlobStorage.dwStatus = DBSTATUS_S_OK );
	// When getting data through ISequentialStream, the length is either sizeof(IUnknown *)
	// or the total number of bytes that will be returned through ISequentialStream.
      if BlobStorage.dwLenght = SizeOf(IUnknown)
      then nBlobSize := 0
      else nBlobSize := BlobStorage.dwLenght;

      if nBlobSize > 0 then begin
        SetLength(BlobData, nBlobSize);
        PiecePtr := PChar(BlobData);
        Check( BlobStorage.IStream.Read(PiecePtr, nBlobSize, @nReadBytes) );
        PiecePtr := nil;        // to exclude destroying later
      end else begin
        nBlobSize := SqlDatabase.BlobPieceSize;
        PiecePtr := CoTaskMemAlloc(nBlobSize);
        repeat
          nReadBytes := 0;
          Check( BlobStorage.IStream.Read(PiecePtr, nBlobSize, @nReadBytes) );
	        // Each part is not null-terminated even for character data
          if nReadBytes > 0 then begin
            SetLength( BlobData, Length(BlobData) + nReadBytes );
            i := Length(BlobData) - nReadBytes;
{$IFDEF XSQL_CLR}
            Marshal.Copy( PiecePtr, BlobData, i, nReadBytes );
{$ELSE}
            SafeCopyMem( PiecePtr, TSDPtr(@BlobData[i]), nReadBytes );
{$ENDIF}
          end;
        until (nReadBytes <= 0) or (nReadBytes < nBlobSize);
      end;
      Result := Length(BlobData);
    end;
  finally
    BlobStorage.IStream := nil;
    if hBlobAccessor <> 0 then
      Check( pIBlobAccessor.ReleaseAccessor( hBlobAccessor, nil ) );
    hBlobAccessor := 0;
    pIBlobAccessor:= nil;
    if Assigned(PiecePtr) then
      CoTaskMemFree(PiecePtr);
  end;
end;

procedure TIOleDbCommand.InitParamList;
var
  cmd: TIOleDbSchemaProcParams;
  ParamType, ParamDataType: Smallint;
  ft: TFieldType;
  pt: TSDHelperParamType;
  sParamName: string;
begin
  cmd := TIOleDbSchemaProcParams.Create(SqlDatabase);
  try
    cmd.ObjPattern := CommandText;
    cmd.Execute;
    while cmd.FetchNextRow do begin
      pt := ptUnknown;
        // PARAMETER_NAME
      cmd.GetFieldAsString( 4, sParamName );
        // PARAMETER_TYPE
      if cmd.GetFieldAsInt16( 6, ParamType ) then
        case ParamType of
          DBPARAMTYPE_INPUT:
            pt := ptInput;
          DBPARAMTYPE_INPUTOUTPUT:
            pt := ptInputOutput;
          DBPARAMTYPE_OUTPUT:
            pt := ptOutput;
          DBPARAMTYPE_RETURNVALUE:
            pt := ptResult;
        end;
        // DATA_TYPE
      if cmd.GetFieldAsInt16( 10, ParamDataType ) then
        ft := FieldDataType(ParamDataType)
      else
        ft := ftUnknown;
      AddParam(sParamName, ft, pt);
    end;
  finally
    cmd.Free;
  end;
end;


{ TIOleDbSchemaCommand }

constructor TIOleDbSchemaCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FRestrictions := nil;
  FRestrictCount:= 0;
end;

destructor TIOleDbSchemaCommand.Destroy;
begin 
  DestroyRestrictions;

  inherited;
end;

procedure TIOleDbSchemaCommand.DestroyRestrictions;
var
  i: Integer;
  p: PVariantArg;
begin
  if not Assigned(FRestrictions) then
    Exit;
    
  for i:=0 to FRestrictCount-1 do begin
    p := PVariantArg( IncPtr(FRestrictions, i * SizeOf(TVariantArg)) );
    if (p^.vt = VT_BSTR) and Assigned(p^.bstrVal) then begin
      FreeWideChar(p^.bstrVal);
      p^.bstrVal := nil;
    end;
  end;
  FRestrictions := SafeReallocMem(FRestrictions, 0);
  FRestrictCount:= 0;
end;

procedure TIOleDbSchemaCommand.DoPrepare(Value: string);
var
  s, sSchGuid: string;
begin
  if Value <> '' then begin
    SetNativeCommand( Value );
    Exit;
  end;

  s := '';
  sSchGuid := GuidToString(SchemaRowsetGUID);
  if sSchGuid = GuidToString(DBSCHEMA_TABLES) then
    s := 'DBSCHEMA_TABLES'
  else if sSchGuid = GuidToString( DBSCHEMA_COLUMNS ) then
    s:= 'DBSCHEMA_COLUMNS'
  else if sSchGuid = GuidToString( DBSCHEMA_INDEXES ) then
    s:= 'DBSCHEMA_INDEXES'
  else if sSchGuid = GuidToString( DBSCHEMA_PROCEDURES ) then
    s:= 'DBSCHEMA_PROCEDURES'
  else if sSchGuid = GuidToString( DBSCHEMA_PROCEDURE_PARAMETERS ) then
    s:= 'DBSCHEMA_PROCEDURE_PARAMETERS'
  else
    DatabaseErrorFmt(SSchemaGuidNotSupported, [GuidToString(SchemaRowsetGUID)]);

  SetNativeCommand( Format('IDBSchemaRowset.GetRowset( %s )', [s]) );
end;

procedure TIOleDbSchemaCommand.DoExecDirect(Value: string);
begin
  DoPrepare(Value);
  DoExecute;

  InitFieldDescs;  
end;

procedure TIOleDbSchemaCommand.DoExecute;
var
  pIDBSchemaRowset: IDBSchemaRowset;
begin
        // DoExecute was called earlier, when fields were described
  if Assigned(FIRowset) then
    Exit;

  AcquireDBHandle;

  CreateRestrictions;

  Check( SqlDatabase.DBCreateCommand.QueryInterface(IID_IDBSchemaRowset, IUnknown(pIDBSchemaRowset)) );
  try
    Check( pIDBSchemaRowset.GetRowset(nil, FSchemaRowsetGUID, FRestrictCount, FRestrictions, IID_IRowset, 0, nil, IUnknown(FIRowset)) );
  finally
    pIDBSchemaRowset := nil;
  end;
end;


{ TIOleDbSchemaTables }

constructor TIOleDbSchemaTables.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);
  FSysTables := False;
  FSchemaRowsetGUID := DBSCHEMA_TABLES;
end;

procedure TIOleDbSchemaTables.CreateRestrictions;
const
  TBL_TYPE_TABLE        = 'TABLE';
  TBL_TYPE_SYSTABLE     = 'SYSTEM TABLE';
var
  i: Integer;
  p: PVariantArg;
begin
  DestroyRestrictions;

  ExtractOwnerObjNames(ObjPattern, FSchName, FTblName);
  if FSchName = '%' then
    FSchName := '';
  if FTblName = '%' then
    FTblName := '';

  FRestrictCount := 4;
  FRestrictions := SafeReallocMem(nil, FRestrictCount * SizeOf(TVariantArg));
  SafeInitMem(FRestrictions, FRestrictCount * SizeOf(TVariantArg), 0);

  for i:=0 to FRestrictCount-1 do begin
    p := PVariantArg( IncPtr(FRestrictions, i * SizeOf(TVariantArg)) );
        // TABLE_SCHEMA
    if (i = 1) and (FSchName <> '') then begin
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( FSchName )
    end else if (i = 2) and (FTblName <> '') then begin
        // TABLE_NAME
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( FTblName )
    end else if i = 3 then begin
        // TABLE_TYPE
      p^.vt := VT_BSTR;
      if SysTables then
        p^.bstrVal := AllocWideChar( TBL_TYPE_SYSTABLE )
      else
        p^.bstrVal := AllocWideChar( TBL_TYPE_TABLE );
    end else begin
      p^.vt := VT_EMPTY;
      p^.bstrVal := nil;
    end;
  end;
end;

procedure TIOleDbSchemaTables.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := OLD_FIELD_PREFIX + TBL_TYPE_FIELD;
    end;
  end;

  with Descs.AddFieldDesc do begin
    FieldName	:= TBL_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
end;

function TIOleDbSchemaTables.FetchNextRow: Boolean;
const
  CnvtFieldIdx = 3;
var
  OutBuf: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  s: string;
  v: Integer;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

{       pattern processing
  while Result do begin
    if not GetFieldAsString(FieldDescs[1].FieldNo, s) then
      Break;
    Result := s = 'tester';
    if Result then
      Break;
    Result := inherited FetchNextRow;
  end;
  if not Result then
    Exit;
}

	// set value for TBL_TYPE_FIELD field from OLD_FIELD_PREFIX + TBL_TYPE_FIELD field
  if not GetFieldAsString(FieldDescs[CnvtFieldIdx].FieldNo, s) then
    Exit;
  OutBuf := GetFieldBuffer(FieldDescs[FFirstCalcFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(OutBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := FieldDescs[FFirstCalcFieldIdx].DataSize;
  SetFieldInfoStruct(OutBuf, 0, FieldInfo);

  v := 0;
  if s = 'TABLE' then
    v := v or $1;
  if (s = 'VIEW') or (s = 'SYSTEM VIEW') then
    v := v or $2;
  if s = 'SYSTEM TABLE' then
    v := v or $4;

  HelperMemWriteInt32( OutBuf, SizeOf(TSDFieldInfo), v );
end;

{ TIOleDbSchemaColumns }
constructor TIOleDbSchemaColumns.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FSchemaRowsetGUID := DBSCHEMA_COLUMNS;
  FColTypeNameLen := 51;
  FColTypeNameFieldIdx := 0;
  FColTypeFieldIdx := 0;  
end;

procedure TIOleDbSchemaColumns.CreateRestrictions;
var
  i: Integer;
  p: PVariantArg;
  sSchName, sTblName: string;
begin
  DestroyRestrictions;

  ExtractOwnerObjNames(ObjPattern, sSchName, sTblName);
  if sSchName = '%' then
    sSchName := '';
  if sTblName = '%' then
    sTblName := '';

  FRestrictCount := 3;
  FRestrictions := SafeReallocMem(nil, FRestrictCount * SizeOf(TVariantArg));
  SafeInitMem(FRestrictions, FRestrictCount * SizeOf(TVariantArg), 0);

  for i:=0 to FRestrictCount-1 do begin
    p := PVariantArg( IncPtr(FRestrictions, i * SizeOf(TVariantArg)) );
        // TABLE_SCHEMA
    if (i = 1) and (sSchName <> '') then begin
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sSchName )
    end else if (i = 2) and (sTblName <> '') then begin
        // TABLE_NAME
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sTblName )
    end else begin
      p^.vt := VT_EMPTY;
      p^.bstrVal := nil;
    end;
  end;
end;

procedure TIOleDbSchemaColumns.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := COL_NAME_FIELD;
      7: Descs.FieldDescs[i].FieldName := COL_POS_FIELD;
      9: Descs.FieldDescs[i].FieldName := COL_DEFAULT_FIELD;
      11: Descs.FieldDescs[i].FieldName := COL_NULLABLE_FIELD;
      12: Descs.FieldDescs[i].FieldName := COL_DATATYPE_FIELD;
      14: Descs.FieldDescs[i].FieldName := COL_LENGTH_FIELD;
      16: Descs.FieldDescs[i].FieldName := COL_PREC_FIELD;
      17: Descs.FieldDescs[i].FieldName := COL_SCALE_FIELD;
    end;
  end;
	// add COL_TYPE_FIELD, COL_TYPENAME_FIELD
  with Descs.AddFieldDesc do begin
    FieldName	:= COL_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
  FColTypeFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= COL_TYPENAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= FColTypeNameLen;
    Precision	:= 0;
    Required	:= True;
  end;
  FColTypeNameFieldIdx := Descs.Count-1;
end;

function TIOleDbSchemaColumns.FetchNextRow: Boolean;
const
  ColDataTypeFieldNo    = 12;
var
  FldBuf: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  v2: SmallInt;
  v: Integer;
  sTypeName: string;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  v := 0;
    	// assign COL_TYPE_FIELD value
  FldBuf := GetFieldBuffer(FColTypeFieldIdx+1, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := FieldDescs[FColTypeFieldIdx].DataSize;
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);

  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), v );

    	// assign COL_TYPENAME_FIELD value
  if not GetFieldAsInt16(ColDataTypeFieldNo, v2) then
    Exit;       // column sort sequence is not supported

  sTypeName := GetDataTypeName(v2);
  FldBuf := GetFieldBuffer(FColTypeNameFieldIdx+1, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := Length(sTypeName) + 1;
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);

  HelperMemWriteString( FldBuf, SizeOf(TSDFieldInfo), sTypeName, Length(sTypeName) );
  HelperMemWriteByte( FldBuf, SizeOf(TSDFieldInfo) + Length(sTypeName), 0 );
end;

function TIOleDbSchemaColumns.GetDataTypeName(const TypeInd: Integer): string;
begin
  Result := '';
  case TypeInd of
    DBTYPE_I2:          Result := 'I2';
    DBTYPE_I4:          Result := 'I4';
    DBTYPE_R4:          Result := 'R4';
    DBTYPE_R8:          Result := 'R8';
    DBTYPE_CY:          Result := 'CY';
    DBTYPE_DATE:        Result := 'DATE';
    DBTYPE_BSTR:        Result := 'BSTR';
    DBTYPE_IDISPATCH:   Result := 'IDISPATCH';
    DBTYPE_ERROR:       Result := 'ERROR';
    DBTYPE_BOOL:        Result := 'BOOL';
    DBTYPE_VARIANT:     Result := 'VARIANT';
    DBTYPE_IUNKNOWN:    Result := 'IUNKNOWN';
    DBTYPE_DECIMAL:     Result := 'DECIMAL';
    DBTYPE_UI1:         Result := 'UI1';
    DBTYPE_ARRAY:       Result := 'ARRAY';
    DBTYPE_BYREF:       Result := 'BYREF';
    DBTYPE_I1:          Result := 'I1';
    DBTYPE_UI2:         Result := 'UI2';
    DBTYPE_UI4:         Result := 'UI4';
    DBTYPE_I8:          Result := 'I8';
    DBTYPE_UI8:         Result := 'UI8';
    DBTYPE_GUID:        Result := 'GUID';
    DBTYPE_VECTOR:      Result := 'VECTOR';
    DBTYPE_RESERVED:    Result := 'RESERVED';
    DBTYPE_BYTES:       Result := 'BYTES';
    DBTYPE_STR:         Result := 'STR';
    DBTYPE_WSTR:        Result := 'WSTR';
    DBTYPE_NUMERIC:     Result := 'NUMERIC';
    DBTYPE_UDT:         Result := 'UDT';
    DBTYPE_DBDATE:      Result := 'DBDATE';
    DBTYPE_DBTIME:      Result := 'DBTIME';
    DBTYPE_DBTIMESTAMP: Result := 'DBTIMESTAMP';
  end;
end;

{ TIOleDbSchemaIndexes }

constructor TIOleDbSchemaIndexes.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FSchemaRowsetGUID := DBSCHEMA_INDEXES;
  FIdxTypeFieldIdx := 0;
  FIdxSortFieldIdx := 0;
end;

procedure TIOleDbSchemaIndexes.CreateRestrictions;
var
  i: Integer;
  p: PVariantArg;
  sSchName, sTblName: string;
begin
  DestroyRestrictions;

  ExtractOwnerObjNames(ObjPattern, sSchName, sTblName);
  if sSchName = '%' then
    sSchName := '';
  if sTblName = '%' then
    sTblName := '';

  FRestrictCount := 5;
  FRestrictions := SafeReallocMem(nil, FRestrictCount * SizeOf(TVariantArg));
  SafeInitMem(FRestrictions, FRestrictCount * SizeOf(TVariantArg), 0);

  for i:=0 to FRestrictCount-1 do begin
    p := PVariantArg( IncPtr(FRestrictions, i * SizeOf(TVariantArg)) );
        // TABLE_SCHEMA
    if (i = 1) and (sSchName <> '') then begin
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sSchName )
    end else if (i = 4) and (sTblName <> '') then begin
        // TABLE_NAME
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sTblName )
    end else begin
      p^.vt := VT_EMPTY;
      p^.bstrVal := nil;
    end;
  end;
end;

procedure TIOleDbSchemaIndexes.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      6: Descs.FieldDescs[i].FieldName := IDX_NAME_FIELD;
      17: Descs.FieldDescs[i].FieldName := IDX_COL_POS_FIELD;
      18: Descs.FieldDescs[i].FieldName := IDX_COL_NAME_FIELD;
      24:Descs.FieldDescs[i].FieldName := IDX_FILTER_FIELD;
    end;
  end;

  with Descs.AddFieldDesc do begin
    FieldName	:= IDX_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
  FIdxTypeFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= IDX_SORT_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= 2;   // char + zero-terminator
    Precision	:= 0;
    Required	:= True;
  end;
  FIdxSortFieldIdx := Descs.Count-1;
end;

function TIOleDbSchemaIndexes.FetchNextRow: Boolean;
const
  IdxPrimKeyFieldNo     = 7;
  IdxUniqueFieldNo      = 8;
  IdxCollationFieldNo   = 21;
var
  FldBuf: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  b: SmallInt;
  v: Integer;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  v := 0;
	// boolean value is returned as smallint/short (2 byte)
  if GetFieldAsInt16(IdxPrimKeyFieldNo, b) and (b <> 0) then
    v := v or PrimaryIndexType;
  if GetFieldAsInt16(IdxUniqueFieldNo, b) then
    if b <> 0 then
      v := v or UniqueIndexType
    else
      v := v or NonUniqueIndexType;

    	// assign IDX_TYPE_FIELD value
  FldBuf := GetFieldBuffer(FIdxTypeFieldIdx+1, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := FieldDescs[FIdxTypeFieldIdx].DataSize;
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);

  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), v );

  if not GetFieldAsInt16(IdxCollationFieldNo, b) then
    Exit;       // column sort sequence is not supported
    	// assign IDX_SORT_FIELD value
  FldBuf := GetFieldBuffer(FIdxSortFieldIdx+1, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := 2;
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);
  if b = DB_COLLATION_ASC then
    b := Byte( AscSortOrder )
  else
    b := Byte( DescSortOrder );
  HelperMemWriteByte( FldBuf, SizeOf(TSDFieldInfo), b );
  HelperMemWriteByte( FldBuf, SizeOf(TSDFieldInfo)+1, 0 );
end;


{ TIOleDbSchemaProcs }

constructor TIOleDbSchemaProcs.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FSchemaRowsetGUID := DBSCHEMA_PROCEDURES;
  FInParamsFieldIdx := 0;
  FOutParamsFieldIdx:= 0;
end;

procedure TIOleDbSchemaProcs.CreateRestrictions;
var
  i: Integer;
  p: PVariantArg;
  sSchName, sPrcName: string;
begin
  DestroyRestrictions;

  ExtractOwnerObjNames(ObjPattern, sSchName, sPrcName);
  if sSchName = '%' then
    sSchName := '';
  if sPrcName = '%' then
    sPrcName := '';

  FRestrictCount := 3;
  FRestrictions := SafeReallocMem(nil, FRestrictCount * SizeOf(TVariantArg));
  SafeInitMem(FRestrictions, FRestrictCount * SizeOf(TVariantArg), 0);

  for i:=0 to FRestrictCount-1 do begin
    p := PVariantArg( IncPtr(FRestrictions, i * SizeOf(TVariantArg)) );
        // PROCEDURE_SCHEMA
    if (i = 1) and (sSchName <> '') then begin
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sSchName )
    end else if (i = 2) and (sPrcName <> '') then begin
        // PROCEDURE_NAME
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sPrcName )
    end else begin
      p^.vt := VT_EMPTY;
      p^.bstrVal := nil;
    end;
  end;
end;

procedure TIOleDbSchemaProcs.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := PROC_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := PROC_TYPE_FIELD;
    end;
  end;

  with Descs.AddFieldDesc do begin
    FieldName	:= PROC_IN_PARAMS;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
  FInParamsFieldIdx := Descs.Count-1;

  with Descs.AddFieldDesc do begin
    FieldName	:= PROC_OUT_PARAMS;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
  FOutParamsFieldIdx := Descs.Count-1;
end;

function TIOleDbSchemaProcs.FetchNextRow: Boolean;
const
  ProcTypeFieldNo     = 4;
var
  FldBuf: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  v2: SmallInt;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  v2 := 0;
	// get and convert a native value of PROC_TYPE_FIELD 
  if GetFieldAsInt16(ProcTypeFieldNo, v2) then begin
    if v2 = DB_PT_PROCEDURE then
      v2 := ProcedureProcType
    else if v2 = DB_PT_FUNCTION then
      v2 := FunctionProcType;
    FldBuf := GetFieldBuffer(ProcTypeFieldNo, FieldsBuffer);      
    HelperMemWriteInt16( FldBuf, SizeOf(TSDFieldInfo), v2 );
  end;
    	// assign PROC_IN_PARAMS, PROC_OUT_PARAMS value
  FldBuf := GetFieldBuffer(FInParamsFieldIdx+1, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := FieldDescs[FInParamsFieldIdx].DataSize;
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);

  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), -1 );

  FldBuf := GetFieldBuffer(FOutParamsFieldIdx+1, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := FieldDescs[FOutParamsFieldIdx].DataSize;
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);

  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), -1 );
end;


{ TIOleDbSchemaProcParams }

constructor TIOleDbSchemaProcParams.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FSchemaRowsetGUID := DBSCHEMA_PROCEDURE_PARAMETERS;
end;

procedure TIOleDbSchemaProcParams.CreateRestrictions;
var
  i: Integer;
  p: PVariantArg;
  sSchName, sPrcName: string;
begin
  DestroyRestrictions;

  ExtractOwnerObjNames(ObjPattern, sSchName, sPrcName);
  if sSchName = '%' then
    sSchName := '';
  if sPrcName = '%' then
    sPrcName := '';

  FRestrictCount := 3;
  FRestrictions := SafeReallocMem(nil, FRestrictCount * SizeOf(TVariantArg));
  SafeInitMem(FRestrictions, FRestrictCount * SizeOf(TVariantArg), 0);

  for i:=0 to FRestrictCount-1 do begin
    p := PVariantArg( IncPtr(FRestrictions, i * SizeOf(TVariantArg)) );
        // PROCEDURE_SCHEMA
    if (i = 1) and (sSchName <> '') then begin
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sSchName )
    end else if (i = 2) and (sPrcName <> '') then begin
        // PROCEDURE_NAME
      p^.vt := VT_BSTR;
      p^.bstrVal := AllocWideChar( sPrcName )
    end else begin
      p^.vt := VT_EMPTY;
      p^.bstrVal := nil;
    end;
  end;
end;


initialization
  SqlLibRefCount:= 0;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.
