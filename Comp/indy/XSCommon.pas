{$I XSqlDir.inc}
unit XSCommon {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, Messages, Forms,
  SysUtils, Classes,
  Db, TypInfo,
{$IFDEF XSQL_VCL5}
  DbCommon,
{$ENDIF}
{$IFDEF XSQL_VCL6}
  FmtBcd, Variants, StrUtils,
{$ENDIF}
{$IFDEF XSQL_CLR}
  System.Text, System.Runtime.InteropServices,
{$ENDIF}
  XSConsts;

const
  MAXFIELDNAMELEN	= 50;	// max field name length, which is stored by XSQLConnect components
  DEFMAXCHARPARAMLEN	= 255;	// default maximum size of a buffer for string parameters
  DEFMAXFIELDSTRINGSIZE	= 255;	// default max size of a string field, it's equal or less dsMaxStringSize

  DEF_BLOB_PIECE_SIZE 	= $7FF0;// default size of read/write blob piece, which must be less < $8000 (32768), for example, for SQLBase. To exclude an alignment problems size is ended by 0
  MAX_BCDFIELD_PREC	= 20;
  MAX_BCDFIELD_SCALE	= 4;

  MAX_INTFIELD_PREC	= 10;	// 10 is limit in BDE for ftInteger
  MAX_SINTFIELD_PREC	= 5;	// 5 is limit in BDE for ftSmallInt


  { Field status codes (see TSDFieldInfo.FetchStatus) }
  indTRUNC	= -2;                   { Value has been truncated }
  indNULL	= -1;                   { Value is NULL }
  indVALUE	= 0;

  { BLOB subtypes }
  fldstUNKNOWN	= $00;
  fldstMEMO	= $10;              	{ Text Memo }
  fldstBINARY	= $11;              	{ Binary data }
  fldstHMEMO	= $12;              	{ CLOB }
  fldstHBINARY	= $13;              	{ BLOB }
  fldstHCFILE	= $14;              	{ CFILE }
  fldstHBFILE	= $15;              	{ BFILE }

  ServerDelimiters	= ':@';		{ server delimiters for TXSQLDatabase.RemoteDatabase property }

        // = TGuidField.Size, it include 36 characters and 2 brackets. ODBC uses escape sequences for GUID literals: {xxx...xxx}
  SizeOfGuidString = 38;
  SizeOfGuidBinary = 16;        // guid in a binary format = SizeOf(TGUID)
  
type
{$IFDEF XSQL_CLR}
  PInteger      = IntPtr;
  PLongInt      = IntPtr;
  TSDPtr        = IntPtr;
  TSDCharPtr    = IntPtr;
  TSDObjectPtr  = TObject;
  TSDValueBuffer= IntPtr;
  TSDRecordBuffer=IntPtr;
{$ELSE}
  TBytes        = array of Byte;
  TObjectList   = TList;
  TSDPtr        = Pointer;
  TSDCharPtr    = PChar;
  TSDObjectPtr  = Pointer;
  TSDValueBuffer= PChar;
  TSDRecordBuffer=PChar;
{$ENDIF}

{$IFDEF XSQL_D4}
  TInt64        = Int64;   { 64 bit signed  }
{$ELSE}
  TInt64        = Comp;    { 64 bit signed - Delphi 3 has Comp type for a 64-bit integer }
{$ENDIF}

  PDateTimeRec = ^TDateTimeRec;
  
	{ Cursor types }
  PSDCursor	= TSDPtr;

  TSDEResult	= SmallInt;         // result of the C/API-functions

  TSDBlobData 		= TBytes;
  TSDBlobDataArray 	= array[0..0] of TSDBlobData;
  PSDBlobDataArray 	= ^TSDBlobDataArray;

	// internal transaction isolation types. It corresponds to TSDTransIsolation
  TISqlTransIsolation	= (itiDirtyRead, itiReadCommitted, itiRepeatableRead);
       // it is equal to TSDServerType (SDEngine unit is invisible for the current unit)
  TISqlServerType = (istSQLBase, istOracle, istSQLServer, istSybase,
  		   istDB2, istInformix, istODBC, istInterbase, istFirebird,
                   istMySQL, istPostgreSQL {$IFDEF DEBUG_OLEDB}, istOLEDB{$ENDIF});
const
  ServerTypeNames: array[TISqlServerType] of string = ('SQLBase', 'Oracle', 'SQLServer', 'Sybase',
  		   'DB2', 'Informix', 'ODBC', 'Interbase', 'Firebird',
                   'MySQL', 'PostgreSQL' {$IFDEF DEBUG_OLEDB}, 'OLEDB' {$ENDIF});
	// helper library to convert stdcall callback to cdecl callback functions, which is not supported by Delphi 8
        // it is used MS SQLServer and Oracle8 connections
  CLRHelperDLL  = 'SQLDIRHN.DLL';
  
type
//  TSDFieldDescList 	= class;

  TISqlDatabase 	= class;
  TISqlCommand 		= class;

  TInitSqlDatabaseProc	= function (ADbParams: TStrings): TISqlDatabase;
        // the variable record, where the first byte is ServerType (TISqlServerType),
        //other fields depend from connection type and declared in the corresponded units
  TSDHandleRec	= record
    SrvType: Byte;
//  further fields, which depends from server connection
  end;

  PSDHandleRec	= ^TSDHandleRec;

  TSDSchemaType = (stTables, stSysTables, stProcedures, stColumns,
    	stProcedureParams, stIndexes, stPackages);

  TXSQLDatabaseParam = (spMaxBindName, spMaxClientName, spMaxConnectString,
  	spMaxDatabaseName, spMaxErrorMessage, spMaxErrorText, spMaxExtErrorMessage,
        spMaxJoinedTables, spLongIdentifiers, spShortIdentifiers,
        spMaxUserName, spMaxPasswordString, spMaxServerName,
        spMaxFieldName, spMaxTableName, spMaxSPName, spMaxFullTableName, spMaxFullSPName);


  ESDSqlLibError = class(EDatabaseError);

{ ESDEngineError }

  ESDEngineError = class(EDatabaseError)
  private
    FNativeError,
    FErrorCode,
    FErrorPos: LongInt;
  public
    constructor Create(AErrorCode, ANativeError: LongInt; const Msg: string; AErrorPos: LongInt);
    constructor CreateDefPos(AErrorCode, ANativeError: LongInt; const Msg: string); virtual;
    property ErrorCode:   LongInt read FErrorCode;
    property NativeError: LongInt read FNativeError;
    property ErrorPos: LongInt read FErrorPos;
  end;

  ESDEngineErrorClass = class of ESDEngineError;

{	abstract server API	}

{ In contrast to abstract methods empty methods with unconditional asserts }
{ show what method is called, but is not overrided }

//  TISqlDatabaseClass = class of TISqlDatabase;
  TISqlCommandClass = class of TISqlCommand;

{ TISqlDatabase }

  { property Commands[] - purposes: set autocommit for SQLBase ???
  }

  TISqlDatabase = class(TObject)
  private
    FAcquiredHandle: Boolean;			// if a Handle is not belonged to the current object; it has to be set in SetHandle method
    FIsEnableBCD: Boolean;
    FIsRTrimChar: Boolean;		        // whether to trim trailing spaces in the output of CHAR datatype ?
    FIsSingleConn: Boolean;		        // Whether or not a szSINGLECONN parameter is set on (a database Handle is used for activated TISqlCommand)
    FMaxFieldNameLen: Integer;
    FMaxStringSize: Integer;			// max size of a string field (TStringField), if field size is more then it will be TBlob/MemoField
    FBlobPieceSize: Integer;                    // size of Blob piece, when it is used to read/write Blob value
    FPrefetchRows: Integer; 			// it's possible to add TSDDataSet.PrefetchRows to override this value
    FDbParams: TStrings;
    FTransIsolation: TISqlTransIsolation;
    FInTransaction: Boolean;
    FResetBusyState: TNotifyEvent;
    FResetIdleTimeOut: TNotifyEvent;
  protected
    FAutoCommitDef: Boolean;			// whether autocommit option is present in TXSQLDatabase.Params
    FAutoCommit	  : Boolean;
    FCursorPreservedOnCommit,
    FCursorPreservedOnRollback: Boolean;	// whether a server preserves all cursor in the same position after COMMIT, ROLLBACK
    FTransSupported: Boolean;			// default, True
    FProcSupportsCursor: Boolean;		// procedure supports cursor parameters (default, False)
    FProcSupportsCursors: Boolean;		// procedure can return one or more result sets (default, False)
    procedure DoResetBusyState; virtual;
    procedure DoResetIdleTimeOut; virtual;

    procedure DoConnect(const sDatabaseName, sUserName, sPassword: string); virtual; abstract;
    procedure DoDisconnect(Force: Boolean); virtual; abstract;

    procedure DoCommit; virtual; abstract;
    procedure DoRollback; virtual; abstract;
    procedure DoStartTransaction; virtual; abstract;

    function GetHandle: TSDPtr; virtual;
    procedure SetAutoCommitOption(Value: Boolean); virtual;
    procedure SetHandle(AHandle: TSDPtr); virtual;
  public
    constructor Create(ADbParams: TStrings); virtual;
    destructor Destroy; override;

    function CreateSqlCommand: TISqlCommand; virtual; abstract;

    function GetAutoIncSQL: string; virtual;
    function GetClientVersion: LongInt; virtual; abstract;
    function GetServerVersion: LongInt; virtual; abstract;
    function GetVersionString: string; virtual; abstract;
    procedure GetStoredProcNames(List: TStrings); virtual;
    procedure GetTableNames(Pattern: string; SystemTables: Boolean; List: TStrings); virtual;
    procedure GetFieldNames(const TableName: string; List: TStrings); virtual;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; virtual;

    procedure Connect(const sDatabaseName, sUserName, sPassword: string); virtual;
    procedure Disconnect(Force: Boolean); virtual;
    function TestConnected: Boolean; virtual; abstract;

    procedure Commit; virtual;
    procedure Rollback; virtual;
    procedure StartTransaction; virtual;

    function ParamValue(Value: TXSQLDatabaseParam): Integer; virtual;
    procedure SetTransIsolation(Value: TISqlTransIsolation); virtual;
    function SPDescriptionsAvailable: Boolean; virtual;

    procedure ResetBusyState;
    procedure ResetIdleTimeOut;

    property AcquiredHandle: Boolean read FAcquiredHandle;
    property AutoCommit: Boolean read FAutoCommit;
    property AutoCommitDef: Boolean read FAutoCommitDef;
    property IsEnableBCD: Boolean read FIsEnableBCD;
    property IsRTrimChar: Boolean read FIsRTrimChar;
    property IsSingleConn: Boolean read FIsSingleConn;
    property Handle: TSDPtr read GetHandle write SetHandle;
    property BlobPieceSize: Integer read FBlobPieceSize;
    property CursorPreservedOnCommit: Boolean read FCursorPreservedOnCommit;
    property CursorPreservedOnRollback: Boolean read FCursorPreservedOnRollback;
    property InTransaction: Boolean read FInTransaction;
    property MaxFieldNameLen: Integer read FMaxFieldNameLen;
    property MaxStringSize: Integer read FMaxStringSize;
    property PrefetchRows: Integer read FPrefetchRows;
    property Params: TStrings read FDbParams;
    property ProcSupportsCursor: Boolean read FProcSupportsCursor;
    property ProcSupportsCursors: Boolean read FProcSupportsCursors;
    property TransIsolation: TISqlTransIsolation read FTransIsolation write FTransIsolation;
    property TransSupported: Boolean read FTransSupported;
    property OnResetBusyState: TNotifyEvent read FResetBusyState write FResetBusyState;
    property OnResetIdleTimeOut: TNotifyEvent read FResetIdleTimeOut write FResetIdleTimeOut;
  end;

{ TSDBufferList }

  TSDBufferList = class
  private
    FList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function StringToPtr(S: string): TSDPtr;
  end;

  { TSDFieldDescList }
  TSDFieldDesc = class(TObject) // converted from a record for compatibility with D8
  public
    FieldName: string[MAXFIELDNAMELEN];	// Field name or alias (for example, <select F as Alias...>)
    FieldNo : Integer;			// Field number (=i+1, where i=0,1,..)
    FieldType: TFieldType;		// Field type (ftInteger...), which is equal TField.DataType
    DataType: SmallInt;			// Native field type (can be negative)
    DataSize: Integer;			// Native size in bytes (with null-termnator for string), i.e. size for select buffer (for string types, including zero-terminator). This value can exceed 32KB.
    Offset: Integer;			// for blob fields: indicates position in a blob array inside a select buffer
    Precision: SmallInt;		// total number of digits
    Scale: SmallInt;                    // digits after point for BCD
    Required: Boolean;			// is not Null
  end;

  TSDFieldDescList = class(TList)
  private
    function GetFieldDescs(Index: Integer): TSDFieldDesc;
//    function GetPFieldDescs(Index: Integer): PSDFieldDesc;
  public
    destructor Destroy; override;
    procedure Clear; {$IFDEF XSQL_VCL4} override; {$ENDIF} {$IFDEF XSQL_C3} override; {$ENDIF}
    function AddFieldDesc: TSDFieldDesc;
    procedure ArrangeFieldNames;
    function FieldDescByName(const AFieldName: string): TSDFieldDesc;
    function FieldDescByNumber(AFieldNo: Integer): TSDFieldDesc;
    property FieldDescs[Index: Integer]: TSDFieldDesc read GetFieldDescs; default;
//    property PFieldDescs[Index: Integer]: PSDFieldDesc read GetPFieldDescs;
  end;

  	// it's used in select buffer
  TSDFieldInfo = packed record          // ??? -> TSDFieldDataInfo
    FetchStatus:Longint;		{ Fetch Status Code of field (sometimes, signed 16-bit) }
    DataSize: 	Longint;		{ Length of the data received (for Oracle, it uses for BLOB-field) }
  end;
  PSDFieldInfo = ^TSDFieldInfo;

  TIntArray	= array of Integer;

{$IFDEF XSQL_VCL4}
  TSDHelperParam  	= TParam;
  TSDHelperParams  	= TParams;
  TSDHelperParamType  	= TParamType;
{$ELSE}
  TSDParam  	= class;
  TSDParams  	= class;
  TSDParamType	= (ptUnknown, ptInput, ptOutput, ptInputOutput, ptResult);

  TSDHelperParam  	= TSDParam;
  TSDHelperParams  	= TSDParams;
  TSDHelperParamType  	= TSDParamType;
{$ENDIF}

{ TISqlCommand - union of command and cursor interfaces }
  // add method to send a message to monitor component
  TSDCommandType = (ctQuery, ctTable, ctStoredProc);
  	// if SaveRes is True, it is necessary to call FetchAll or GetResults methods
  TSDReleaseHandleEvent = procedure(SaveRes: Boolean) of object;

  TISqlCommand = class(TObject)
  private
    FCommandType: TSDCommandType;
    FCommandText: string;		// an original SQL command
    FNativeCommand: string;		// modified SQL command, which is sent to a database, i.e. the command is prepared
    FBlobFieldCount: Integer;
    FFieldDescs: TSDFieldDescList;
    FParamsRef: TSDHelperParams;	// it's a reference to TParams component, which does not belong to the current component (could not be destroyed)
    FParamsBuffer: TSDRecordBuffer;	// bind buffer
    FFieldsBuffer: TSDRecordBuffer;	// select buffer
    FBlobCacheOffs: Integer;           	// offset to blob data in a select buffer
    FFieldBufOffs: TIntArray;		// Offsets to field's buffer in a select buffer FFieldsBuffer
    FMaxCharParamSize: Integer;
    FBufList: TSDBufferList;            // list of memory buffers (now it is used in D8 implementation)

    FSqlDatabase: TISqlDatabase;
    FReleaseHandle: TSDReleaseHandleEvent;	// release handle, which is acquired from TISqlDatabase (MSS, Sybase, ODBC)
    function GetFieldBufOffs(Index: Integer): Integer; 	// Index is equal (FieldNo-1)
    function GetPrepared: Boolean;
    function GetSqlDatabase: TISqlDatabase;
    procedure SetParamsRef(Value: TSDHelperParams);
  protected
    procedure AddParam(AParamName: string; ADataType: TFieldType; AParamType: TSDHelperParamType);
    function GetFieldBuffer(AFieldNo: Integer; SelBuf: TSDPtr): TSDPtr;
  protected	// virtual methods
    procedure DoReleaseHandle(SaveRes: Boolean); virtual;

    procedure AllocParamsBuffer; virtual;
    procedure AllocFieldsBuffer; virtual;
    procedure BindParamsBuffer; virtual;
    procedure FreeParamsBuffer; virtual;
    procedure FreeFieldsBuffer; virtual;
    procedure SetFieldsBuffer; virtual;

    procedure DoPrepare(ACommandValue: string); virtual; abstract;
    procedure DoExecDirect(ACommandValue: string); virtual; abstract;
    procedure DoExecute; virtual; abstract;

    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; virtual;
    procedure InitParamList; virtual;
    procedure ClearFieldDescs;

    procedure FetchBlobFields; virtual;
    function FieldDataType(ExtDataType: Integer): TFieldType; virtual;
    function FieldDescByName(const AFieldName: string): TSDFieldDesc;
    procedure GetFieldDescs(Descs: TSDFieldDescList); virtual;
    function GetFieldsBuffer: TSDRecordBuffer; virtual;
    function GetFieldsBufferSize: Integer; virtual;
    function GetHandle: PSDCursor; virtual;
    function GetParamsBufferSize: Integer; virtual;
    function NativeDataSize(FieldType: TFieldType): Word; virtual;
    function NativeDataType(FieldType: TFieldType): Integer; virtual;
    function NativeParamSize(Param: TSDHelperParam): Integer;
    procedure ParseFieldNames(const theSelect: string; FldInfo: TStrings);
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; virtual;
    procedure SetCommandText(Value: string);
    procedure SetNativeCommand(Value: string);

    property BufList: TSDBufferList read FBufList;
    property NativeCommand: string read FNativeCommand;
    property ParamsBuffer: TSDRecordBuffer read FParamsBuffer;
    property FieldsBuffer: TSDRecordBuffer read GetFieldsBuffer;
    property FieldBufOffs[Index: Integer]: Integer read GetFieldBufOffs;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); virtual;
    destructor Destroy; override;
    procedure SaveResults;
	// command interface
    procedure CloseResultSet; virtual;
    procedure Disconnect(Force: Boolean); virtual;
    procedure InitNewCommand; virtual;
    procedure ExecDirect(ACommandValue: string); virtual;
    procedure Execute; virtual;
    function GetAutoIncValue: Integer; virtual;     
    function GetRowsAffected: Integer; virtual;
    function NextResultSet: Boolean; virtual;
    procedure Prepare(ACommandValue: string); virtual;
    function ResultSetExists: Boolean; virtual;
	// cursor interface
    function FetchNextRow: Boolean; virtual;
    procedure InitFieldDescs; virtual;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; virtual;
    function GetBlobValue(AFieldDesc: TSDFieldDesc): TSDBlobData;
    procedure GetOutputParams; virtual;

    procedure PutBlobValue(AFieldDesc: TSDFieldDesc; sBlobValue: TSDBlobData);
    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; virtual;
    function WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint; virtual;
    function WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint; virtual;

	// cursor interface
{
    function GetFieldDouble(AFieldNo: Word; Value: Pointer): Boolean;
    function GetFieldLong(AFieldNo: Word; Value: Pointer): Boolean;
    function GetFieldShort(AFieldNo: Word; Value: Pointer): Boolean;
    function GetFieldString(AFieldNo: Word; Value: Pointer): Boolean; }
{$IFDEF XSQL_VCL4}
    function GetFieldAsInt64(AFieldNo: Word; var Value: TInt64): Boolean;
{$ENDIF}
    function GetFieldAsInt16(AFieldNo: Word; var Value: SmallInt): Boolean;
    function GetFieldAsInt32(AFieldNo: Word; var Value: LongInt): Boolean;
    function GetFieldAsFloat(AFieldNo: Word; var Value: Double): Boolean;
    function GetFieldAsString(AFieldNo: Word; var Value: string): Boolean;

    property BlobCacheOffs: Integer read FBlobCacheOffs;
    property BlobFieldCount: Integer read FBlobFieldCount;
    property CommandType: TSDCommandType read FCommandType write FCommandType;
    property CommandText: string read FCommandText;
    property FieldDescs: TSDFieldDescList read FFieldDescs;
    property Handle: PSDCursor read GetHandle;
//    property NativeHandle: PSDCursor read GetNativeHandle; implement later
    property MaxCharParamSize: Integer read FMaxCharParamSize;
    property Params: TSDHelperParams read FParamsRef write SetParamsRef;
    property Prepared: Boolean read GetPrepared;
    property SqlDatabase: TISqlDatabase read GetSqlDatabase;
    property OnReleaseHandle: TSDReleaseHandleEvent read FReleaseHandle write FReleaseHandle;
  end;

{$IFNDEF XSQL_VCL4}		{ for Delphi 3 & C++ Builder 3 }

{ TSDParam }

  TSDParam = class(TPersistent)
  private
    FParamList: TSDParams;
    FData: Variant;
    FName: string;
    FDataType: TFieldType;
    FNull: Boolean;
    FBound: Boolean;
    FParamType: TSDParamType;
    procedure InitValue;
  protected
    procedure AssignParam(Param: TSDParam);
    procedure AssignTo(Dest: TPersistent); override;
    function GetAsBCD: Currency;
    function GetAsBoolean: Boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: Double;
    function GetAsInteger: Longint;
    function GetAsMemo: string;
    function GetAsString: string;
    function GetAsVariant: Variant;
    function GetParamName: string;
    function IsEqual(Value: TSDParam): Boolean;
    procedure SetAsBCD(Value: Currency);
    procedure SetAsBlob(Value: TBlobData);
    procedure SetAsBoolean(Value: Boolean);
    procedure SetAsCurrency(Value: Double);
    procedure SetAsDate(Value: TDateTime);
    procedure SetAsDateTime(Value: TDateTime);
    procedure SetAsFloat(Value: Double);
    procedure SetAsInteger(Value: Longint);
    procedure SetAsMemo(const Value: string);
    procedure SetAsSmallInt(Value: LongInt);
    procedure SetAsString(const Value: string);
    procedure SetAsTime(Value: TDateTime);
    procedure SetAsVariant(Value: Variant);
    procedure SetAsWord(Value: LongInt);
    procedure SetDataType(Value: TFieldType);
    procedure SetParamName(const Value: string);
    procedure SetText(const Value: string);
  public
    constructor Create(AParamList: TSDParams; AParamType: TSDParamType);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignField(Field: TField);
    procedure AssignFieldValue(Field: TField; const Value: Variant);
    procedure Clear;
    procedure GetData(Buffer: Pointer);
    function GetDataSize: Integer;
    procedure SetData(Buffer: Pointer);
    procedure SetBlobData(Buffer: Pointer; Size: Integer);
    procedure LoadFromFile(const FileName: string; BlobType: TBlobType);
    procedure LoadFromStream(Stream: TStream; BlobType: TBlobType);
    property Name: string read GetParamName write SetParamName;
    property DataType: TFieldType read FDataType write SetDataType;
    property AsBCD: Currency read GetAsBCD write SetAsBCD;
    property AsBlob: TBlobData read GetAsString write SetAsBlob;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsCurrency: Double read GetAsFloat write SetAsCurrency;
    property AsDate: TDateTime read GetAsDateTime write SetAsDate;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: LongInt read GetAsInteger write SetAsInteger;
    property AsMemo: string read GetAsMemo write SetAsMemo;
    property AsString: string read GetAsString write SetAsString;
    property AsSmallInt: LongInt read GetAsInteger write SetAsSmallInt;
    property AsTime: TDateTime read GetAsDateTime write SetAsTime;
    property AsWord: LongInt read GetAsInteger write SetAsWord;
    property IsNull: Boolean read FNull;
    property ParamType: TSDParamType read FParamType write FParamType;
    property Bound: Boolean read FBound write FBound;
    property Text: string read GetAsString write SetText;
    property Value: Variant read GetAsVariant write SetAsVariant;
  end;

{ TSDParams }

  TSDParams = class(TPersistent)
  private
    FItems: TList;
    function GetParam(Index: Word): TSDParam;
    function GetParamValue(const ParamName: string): Variant;
    function GetVersion: Word;
    procedure ReadBinaryData(Stream: TStream);
    procedure SetParamValue(const ParamName: string; const Value: Variant);
    procedure WriteBinaryData(Stream: TStream);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignValues(Value: TSDParams);
    procedure AddParam(Value: TSDParam);
    procedure RemoveParam(Value: TSDParam);
    function CreateParam(FldType: TFieldType; const ParamName: string; ParamType: TSDParamType): TSDParam;
    function Count: Integer;
    procedure Clear;
    procedure GetParamList(List: TList; const ParamNames: string);
    function IsEqual(Value: TSDParams): Boolean;
    function ParamByName(const Value: string): TSDParam;
    property Items[Index: Word]: TSDParam read GetParam; default;
    property ParamValues[const ParamName: string]: Variant read GetParamValue write SetParamValue;
  end;
{$ENDIF}	{ for Delphi 3 & C++ Builder }

{$IFDEF XSQL_VCL5}	{ for Delphi 5 & above }

{ TSDExprParser }

  TSDExprParser = class(TExprParser)
  private
    FDataSet: TDataSet;
    FFilteredFields: TStringList;
    function GetLiteralStart(StartPtr: Integer): Word;
    function GetNodeOperator(NodePtr: Integer): TCANOperator;
    function GetNodeValue(StartPos, NodePos: Integer): Variant;
    function GetUnaryNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetBinaryNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetCompareNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetConstNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetFieldNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetFuncNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetListNodeValue(StartPtr, NodePtr: Integer): Variant;
    function GetOpInValue(V1, V2: Variant): Variant;
    function GetOpLikeValue(V1, V2: Variant): Variant;
    function FieldByName(const FieldName: string): TField;
  public
    constructor Create(DataSet: TDataSet; const Text: string;
      Options: TFilterOptions; ParserOptions: TParserOptions;
      const FieldName: string; DepFields: TBits; FieldMap: TFieldMap);
    destructor Destroy; override;
    function CalcBooleanValue: Boolean;
    function CalcVariantValue: Variant;
    procedure ClearFields;
  end;
{$ENDIF}	{ for Delphi 5 & above }

{$IFNDEF XSQL_VCL5}	{ for TBCDField support }
type
  PBcd = ^TBcd;
  TBcd  = packed record
    Precision: Byte;                        { 1..64 }
    SignSpecialPlaces: Byte;                { Sign:1, Special:1, Places:6 }
    Fraction: packed array [0..31] of Byte; { BCD Nibbles, 00..99 per Byte, high Nibble 1st }
  end;

function CurrToBCD(Curr: Currency; var BCD: TBcd; Precision, Decimals: Integer): Boolean;
function BCDToCurr(const BCD: TBcd; var Curr: Currency): Boolean;
{$ENDIF}


function GetAppName: string;
function GetHostName: string;
function GetFileVersion(const FileName: string): LongInt;
function GetModuleFileNameStr(hModule: HINST): string;
function GetMajorVer(Ver: LongInt): Word;
function GetMinorVer(Ver: LongInt): Word;
function MakeVerValue( MajorVer, MinorVer: Word ): Integer;
procedure ReadFileVersInfo(const FileName: string; var ProductName, VersStr: string);
function VersionStringToDWORD(const VerStr: AnsiString): LongInt;
function GetSqlLibParamName(ServerTypeCode: Integer): string;
function GetXSQLConnectVersion: string;

function ExtractLibName(const LibNames: string; Sep: Char; var Pos: Integer): string;
function ExtractStoredProcName(const sFullProcName: string): string;
{ functions to parsing TXSQLDatabase.RemoteDatabase property. They're used in SDMss.pas, SDMySQL.pas }
function ExtractServerName(const sRemoteDatabase: string): string;
function ExtractDatabaseName(const sRemoteDatabase: string): string;
function ExtractOwnerObjNames(const AFullObjName: string; var AOwnerName, AObjName: string): Boolean;

function IsBlobType(FieldType: TFieldType): Boolean;
function IsDateTimeType(FieldType: TFieldType): Boolean;
function IsNumericType(FieldType: TFieldType): Boolean;
function IsSupportedBlobTypes(FieldType: TFieldType): Boolean;
function IsRequiredSizeTypes(FieldType: TFieldType): Boolean;

{ it is used in SDMss and SDSyb units for convert binary type to hex string }
function CnvtVarBytesToHexString(Value: Variant): string;
{ ------- The following functions are used in SDMySQL and SDPgSQL units ------ }
function SqlDateToDateTime(Value: string): TDateTime;
function SqlTimeToDateTime(Value: string): TDateTime;
function SqlStrToFloatDef(Value: AnsiString; Default: Double): Double;
function SqlStrToBoolean(Value: AnsiString): Boolean;
{ ------- The previous functions are used in SDMySQL and SDPgSQL units ------- }

procedure GuidToCharBuffer(SrcBuf: TSDValueBuffer; SrcBufLen: Integer; DstBuf: TSDValueBuffer; DstBufLen: Integer);

{ For compatibility with all Delphi version: exclude using of Math unit }
function MaxIntValue(A, B: Integer): Integer;
function MinIntValue(A, B: Integer): Integer;

{ String-processing functions }

function IsNameDelimiter(C: Char): Boolean;
function IsLiteral(C: Char): Boolean;

function IsOldPrefixExists(const AParamName, OldPrefix: string): Boolean;
{ Locates the position of a sub-string within a string like AnsiPos, but AnsiTextPos is case-insensitive }
function LocateText(const Substr, S: AnsiString): Integer;
function StripLiterals(const Str: string): string;
function RepeatChar(Ch: Char; S: string): string;
{ Replaces OldStr (as word, separated delimiters) and returns True when the replacing is successful }
function ReplaceString( Once: Boolean; OldStr, NewStr: string; var ResultStr: string ): Boolean;
function StrFindFromPos(const Substr, S: string; StartPos: Integer): Integer;

{$IFDEF XSQL_CLR}
function StrNew( S: TSDCharPtr ): TSDCharPtr;
{$ENDIF}
procedure StrRTrim( S: TSDCharPtr );
{$IFNDEF XSQL_CLR temporary, D8}
        // it is not used while
procedure MoveString(SrcStr: string; SrcPos: Integer; var DestStr: string; DestPos, Count : Integer);
{$ENDIF}

function CompareVar(V1, V2: Variant; CaseInsensitive: Boolean): Integer;
function VarIsEqual(AVar1, AVar2: Variant; CaseInsensitive, PartialKey, AtStartOnly: Boolean): Boolean;
function VarIsStrType(const AValue: Variant): Boolean;

{ Can query SQL returns an updatable(live) result set ? Return a table name or an empty string. }
function IsLiveQuery(const SQL: string): string;
{ Is SELECT statetement ? }
function IsSelectQuery(const SQL: string): Boolean;
procedure CreateParamsFromSQL(List: TSDHelperParams; const SQL: string; ParamPrefix: Char);
{$IFDEF XSQL_VCL4}
function GenerateSQL(UpdateStatus: TUpdateStatus; UpdateMode: TUpdateMode;
	const TableName: string; FieldInfo: TStrings; Fields: TFields; QuoteIdent: Boolean): string;
{$ENDIF}
function ContainsLikeWildcards(const s: string): Boolean;
function ExtractColumnName(const AFieldInfo: string): string;
procedure ParseTableFieldsFromSQL(const theSelect: string; const FieldList: TStrings; FldInfo, TblInfo: TStrings);
function QuoteIdentifier(AName: string; UseQuote: Boolean): string;
function CreateProcedureCallCommand( AProcName: string; AParams: TSDHelperParams; IsMSSQL: Boolean ): string;
function ReplaceParamMarkers( OldStmt: string; AParams: TSDHelperParams): string;

function GetFieldInfoDataSizeOff: Integer;
function GetFieldInfoFetchStatusOff: Integer;
function GetFieldInfoStruct(Buffer: TSDPtr; Offset: Integer): TSDFieldInfo;
function GetFieldBlobData(RecBuf: TSDRecordBuffer; ABlobCacheOffs, AFieldOffset: Integer): TSDBlobData;
function GetFieldBlobDataSize(RecBuf: TSDRecordBuffer; ABlobCacheOffs, AFieldOffset: Integer): Integer;
procedure SetFieldBlobData(RecBuf: TSDRecordBuffer; ABlobCacheOffs, AFieldOffset: Integer; Value: TSDBlobData);
procedure SetFieldInfoStruct(Buffer: TSDPtr; Offset: Integer; Value: TSDFieldInfo);

function HelperLoadLibrary(ALibFileName: string): HMODULE;

function HelperMemReadByte(const Ptr: TSDPtr; Offset: Integer): Byte;
function HelperMemReadInt16(const Ptr: TSDPtr; Offset: Integer): Smallint;
function HelperMemReadInt32(const Ptr: TSDPtr; Offset: Integer): Integer;
function HelperMemReadInt64(const Ptr: TSDPtr; Offset: Integer): TInt64;
function HelperMemReadDateTimeRec(const Ptr: TSDPtr; Offset: Integer): TDateTimeRec;
function HelperMemReadDouble(const Ptr: TSDPtr; Offset: Integer): Double;
function HelperMemReadPtr(const Ptr: TSDPtr; Offset: Integer): TSDPtr;
function HelperMemReadSingle(const Ptr: TSDPtr; Offset: Integer): Single;
procedure HelperMemWriteByte(const Ptr: TSDPtr; Offset: Integer; Value: Byte);
procedure HelperMemWriteInt16(const Ptr: TSDPtr; Offset: Integer; Value: Smallint);
procedure HelperMemWriteInt32(const Ptr: TSDPtr; Offset, Value: Integer);
procedure HelperMemWriteInt64(const Ptr: TSDPtr; Offset: Integer; Value: TInt64);
procedure HelperMemWriteDateTimeRec(const Ptr: TSDPtr; Offset: Integer; Value: TDateTimeRec);
procedure HelperMemWriteDouble(const Ptr: TSDPtr; Offset: Integer; Value: Double);
procedure HelperMemWriteGuid(const Ptr: TSDPtr; Offset: Integer; Value: TGUID);
procedure HelperMemWritePtr(const Ptr: TSDPtr; Offset: Integer; Value: TSDPtr);
procedure HelperMemWriteString(const Ptr: TSDPtr; Offset: Integer; Value: string; Count: Integer);
function HelperPtrToString(const Ptr: TSDPtr; Len: Integer = -1): string;
procedure HelperAssignParamValue(AParam: TSDHelperParam; Value: TDateTimeRec);
function HelperCurrToBCD(Curr: Currency; BCDPtr: TSDPtr; Precision: Integer = 32; Decimals: Integer = 4): Boolean;

function HelperCompareStr(const S1, S2: string): Integer;
function HelperCompareText(const S1, S2: string): Integer;

function IncPtr(const ptr: TSDPtr; Delta: Integer): TSDPtr;
function SafeReallocMem(const OldPtr: TSDPtr; Size: Integer): TSDPtr;
procedure SafeCopyMem(Src, Dest: TSDPtr; Count: Integer);
procedure SafeInitMem(Buffer: TSDPtr; Count: Integer; InitByte: Byte);


implementation


const
  DateTimeTypes		= [ftDate, ftTime, ftDateTime];
  NumericTypes		= [ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency,
                                ftBCD, ftAutoInc {$IFDEF XSQL_VCL4}, ftLargeInt{$ENDIF}];
  { Field types with changable size (require size defining) }
  RequiredSizeTypes	= [{ftBCD,} ftBytes, ftVarBytes, ftString, ftParadoxOle, ftDBaseOle,
                                ftTypedBinary];
  {   in DB.pas : TBlobType = ftBlob..ftTypedBinary; (D3-4, CB3-4),
                  TBlobType = ftBlob..ftOraClob (D5) includes not valid blob types (for example, ftCursor)  }
  BlobTypes		=
  	[ftBlob..ftTypedBinary] {$IFDEF XSQL_VCL5} + [ftOraBlob, ftOraClob] {$ENDIF};
  SupportedBlobTypes	=
        [ftBlob, ftMemo {$IFDEF XSQL_VCL5}, ftOraBlob, ftOraClob{$ENDIF}];

const
  Delimiters = [' ', #$0A, #$0D];

// If AParamName is prefixed with OldPrefix
function IsOldPrefixExists(const AParamName, OldPrefix: string): Boolean;
begin
        // exclude case, when a parameter name is equal 'OLD_' or other OldPrefix value
  Result := (CompareText( AParamName, OldPrefix ) <> 0) and
            (CompareText( Copy(AParamName, 1, Length(OldPrefix)), OldPrefix ) = 0);
end;

function IsSelectQuery(const SQL: string): Boolean;
var
  i, s: Integer;
  substr: string;
begin
  Result := False;
  s := 1;
  while (s <= Length(SQL)) and (AnsiChar(SQL[s]) in Delimiters) do
    Inc(s);
  substr := SQL_TOKEN_Select;
  for i:=0 to Length(substr)-1 do begin
    if ((s+i) > Length(SQL)) or (UpCase(SQL[s+i]) <> substr[i+1]) then
      Break;
      	// end of cycle
    if i = (Length(substr)-1) then
      Result := True;
  end;
end;

{ query must be a single table(which is returned as the result) SELECT statement
w/o aggregate SQL functions, <group by> and <union> clauses. When the query is not live, function returns an empty string }
function IsLiveQuery(const SQL: string): string;
{$IFNDEF XSQL_VCL5}
begin
  Result := '';
end;
{$ELSE}
const
  SInnerJoin = 'INNER JOIN ';       { do not localize }
  SOuterJoin = 'OUTER JOIN ';       { do not localize }

  ForbiddenSQLTokens = [stGroupBy, stUnion, stPlan];

  function IsGroupSQLFunc(const Str: string): Boolean;
  var
    s: string;
    i: Integer;
  begin
    Result := False;
    s := UpperCase(Str);
    i := Pos('(', s);   // to exclude recognition, for example, COUNT or COUNTRY column name as COUNT(*) function (which has to written without a space before '(' first bracket)
    if i > 0 then
      SetLength(s, i-1)
    else
      Exit;
    s := Trim(s);
    Result :=
    	(Pos('AVG', s) = 1) or
    	(Pos('COUNT', s) = 1) or
    	(Pos('MAX', s) = 1) or
    	(Pos('STDDEV', s) = 1) or   	// Oracle function
    	(Pos('SUM', s) = 1);
  end;
	// if a table separator exists in FROM section
  function NextTableExists(const Str: AnsiString): Boolean;
  var
    i: Integer;
  begin
    i := 1;
    while (i <= Length(Str)) and (Str[i] in Delimiters) do
      Inc(i);
    Result := (i <= Length(Str)) and (Str[i] = ',');
  end;

  function NextSQLTokenEx(const SQL: string; var p: Integer; out Token: string; CurSection: TSQLToken): TSQLToken;
{$IFDEF XSQL_CLR}
  begin
    Result := NextSQLToken(SQL, p, Token, CurSection);
{$ELSE}
  var
    pCur, pStart: PChar;
  begin
    pStart := PChar(SQL);
    pCur := pStart + p - 1;
    Result := NextSQLToken(pCur, Token, CurSection);
    p := pCur - pStart + 1;
{$ENDIF}
  end;

var
  Start: Integer;
  sTable, Token, sTemp: string;
  SQLToken, CurSection: TSQLToken;
  bFirstFromSect: Boolean;
begin
  Result := '';
  	// in case of non-SELECT statement (for example, procedure call)
  if not IsSelectQuery(SQL) then
    Exit;

  sTable := '';
  Start := 1;
  CurSection := stUnknown;
  	// locate first FROM section
  repeat
    SQLToken := NextSQLTokenEx(SQL, Start, Token, CurSection);
    if SQLToken in SQLSections then CurSection := SQLToken;
    if SQLToken in ForbiddenSQLTokens then
      Break;
    if (CurSection = stSelect) and (SQLToken = stFieldName) and IsGroupSQLFunc(Token) then
      Break;
  until SQLToken in [stEnd, stFrom];
  if SQLToken = stFrom then
    bFirstFromSect := True
  else
    Exit;

  repeat
    SQLToken := NextSQLTokenEx(SQL, Start, Token, CurSection);
	// SQL section is changed, Token is equal, for example, 'select', 'from' and other
    if SQLToken in SQLSections then begin
        // if the first FROM section ends
      if bFirstFromSect and (CurSection = stFrom) and (CurSection <> SQLToken) then
        bFirstFromSect := False;
      CurSection := SQLToken
    end else if (CurSection = stFrom) and (SQLToken in [stTableName, stValue]) and bFirstFromSect then begin
    	// stValue is returned if TableNames contain quote chars
      if sTable = '' then	// to exclude an alias adding (for example, TABLE1 as ALIAS1) or table adding from nested subqueries ('..WHERE EXISTS()')
        sTable := Token;
      	// if owner name is present, then add that
      while (SQL[Start] = '.') and not (SQLToken in [stEnd]) do begin
        SQLToken := NextSqlTokenEx(SQL, Start, Token, CurSection);
        sTable := sTable + '.' + Token;
      end;
      sTemp := Copy(SQL, Start, Length(SQL)-Start+1);
      	// if the next table exists in the FROM list
      if NextTableExists( sTemp ) then
        Break;
	// check inner/outer join clauses
      if (Pos(sTemp, SInnerJoin) > 0) or
         (Pos(sTemp, SOuterJoin) > 0)
      then
        Break;
    end;
  until (SQLToken in [stEnd] + ForbiddenSQLTokens);
	// if forbidden SQL tokens are not found
  if SQLToken in [stEnd] then
    Result := Trim(sTable);
end;
{$ENDIF}

procedure MoveString(SrcStr: string; SrcPos: Integer; var DestStr: string; DestPos, Count : Integer);
var
  i, DestLen: Integer;
begin
  DestLen := Length(DestStr);
  if DestLen < (DestPos + Count - 1) then
    SetLength(DestStr, DestPos + Count - 1);
  for i:=0 to Count-1 do
    DestStr[DestPos+i] := SrcStr[SrcPos+i];
end;

{ Parse SQL-statement and create instances of TSDParam }
procedure CreateParamsFromSQL(List: TSDHelperParams; const SQL: string; ParamPrefix: Char);
var
  CurPos, StartPos, Len: Integer;
  CurChar: Char;
  Literal: Char;	// #0, when the current character is not quoted, else it's equal the last significant quote
  EmbeddedLiteral: Boolean;
  s, sName: string;
begin
  S := SQL;
  Len := Length(S);
  if Len = 0 then
    Exit;
  CurPos := 1;
  Literal := #0;	// #0 - not inside a quoted string
  EmbeddedLiteral := False;
  repeat
    CurChar := S[CurPos];
    	// Is it parameter name ?
    if (CurChar = ParamPrefix) and not Boolean(Literal) and
       (CurPos < Len) and (S[CurPos + 1] <> ParamPrefix)
    then begin
      StartPos := CurPos;
        // locate end of parameter name
      while (CurChar <> #0) and (CurPos <= Len) and
            (Boolean(Literal) or not IsNameDelimiter(CurChar))
      do begin
        Inc(CurPos);
        if CurPos > Len then
          Break;
        CurChar := S[CurPos];
        if IsLiteral(CurChar) then begin
		// To process a quote, which is inside a parameter name like :"param's name"
          if not Boolean(Literal) then
            Literal := CurChar
          else if Literal = CurChar then	// the quoted string has to be finished by the same quote character
            Literal := #0;
            	// if a parameter name is quoted
          if CurPos = StartPos + 1 then EmbeddedLiteral := True;
        end;
      end;

      if EmbeddedLiteral then begin
        sName := StripLiterals( Copy(S, StartPos + 1, CurPos - StartPos - 1) );
        EmbeddedLiteral := False;
      end else
        sName := Copy(S, StartPos + 1, CurPos - StartPos - 1);
      if Assigned(List) then begin
{$IFDEF XSQL_VCL4}
        TParam(List.Add).Name := sName;
        List.ParamByName(sName).ParamType := ptInput;
{$ELSE}
        List.CreateParam(ftUnknown, sName, ptInput);
{$ENDIF}
      end;
    end else if (CurChar = ParamPrefix) and not Boolean(Literal) and (CurPos < Len) and (S[CurPos + 1] = ParamPrefix) then
        // remove one colon (ParamPrefix), which happens twice
      Delete(S, CurPos, 1)
    else if IsLiteral(CurChar) then begin
	// To process a quote, which is inside a quoted string like "param's :name"
      if not Boolean(Literal) then
        Literal := CurChar
      else if Literal = CurChar then
        Literal := #0;
    end;

    Inc(CurPos);
  until (CurChar = #0) or (CurPos > Len);
end;

// AFieldInfo = "FieldAlias=[Owner.]Table.Column"
function ExtractColumnName(const AFieldInfo: string): string;
var
  i: Integer;
begin
  Result := AFieldInfo;
  for i:=Length(Result) downto 1 do
    if Result[i] = '.' then begin
      Result := Copy(Result, i+1, Length(Result)-i);
      Break;
    end;
end;

{$IFDEF XSQL_VCL4}
{ TO-DO: Generates SELECT statement, when UpdateStatus=usUnmodified
  Function will return an empty string, if all modified values are equal it's old value.
FieldInfo.Strings[i] = "FieldAlias=[Owner.]Table.Column"
}
function GenerateSQL(UpdateStatus: TUpdateStatus; UpdateMode: TUpdateMode;
	const TableName: string; FieldInfo: TStrings; Fields: TFields; QuoteIdent: Boolean): string;
const
	// SQL tokens
  stSelectFmt	= 'select %s from %s';
  stInsertFmt	= 'insert into %s(%s) values(%s)';
  stDeleteFmt	= 'delete from %s %s';
  stUpdateFmt	= 'update %s set %s %s';
  stWhere	= 'where ';
  stAndOp 	= ' and';
  SetIndent	= '  ';
  vt_decimal    = $0E;  // it is unknown type for Delphi variant
var
  bIsModified: Boolean;
  sFields, sRealField, sKeys, sTable: string;
  i: Integer;
begin
  Result := '';
  sFields := '';
  sKeys := '';

  for i:=0 to Fields.Count-1 do begin
  	// only physical fields can be added in SQL statement
    if Fields[i].FieldKind <> fkData then
      Continue;
  	// update only modified fields.
        //Blobs are tested separately VarIsEqual(CompareString) can work incorrectly witn binaries, for example, in Wine.
        //However this code can't define, when blob was modified and new value is equal old one.
    if Fields[i] is TBlobField then
      bIsModified := TBlobField( Fields[i] ).Modified or (Fields[i].NewValue <> Fields[i].OldValue)
    else begin
{$IFNDEF XSQL_CLR}        // varUnknown - Indeclared identifier in D8
      if (Fields[i].DataType = ftLargeInt) and
         ((VarType( Fields[i].NewValue ) in [varUnknown, vt_decimal]) or
          (VarType( Fields[i].OldValue ) in [varUnknown, vt_decimal])
         )
      then      // in this case, impossible to get a variant('Unknown type: 14') value
        bIsModified := True
      else
{$ENDIF}
        bIsModified := not VarIsEqual(Fields[i].NewValue, Fields[i].OldValue, False, False, True);
    end;
    sRealField := ExtractColumnName( FieldInfo.Values[Fields[i].FieldName] );
    case UpdateStatus of
    usUnmodified:
      begin
        if sFields <> '' then sFields := sFields + ', ';
        sFields := sFields + QuoteIdentifier(sRealField, QuoteIdent);
        	// add a field alias, when it is necessary
        if sRealField <> Fields[i].FieldName then
          sFields := sFields + ' as ' + Fields[i].FieldName;
      end;
    usModified:
      if bIsModified then begin
        if sFields <> '' then sFields := sFields + ', ';
        if Fields[i].IsNull then
          sFields := sFields + Format( '%s%s = NULL', [SetIndent, QuoteIdentifier(sRealField, QuoteIdent)] )
        else
          sFields := sFields + Format( '%s%s = :%s', [SetIndent, QuoteIdentifier(sRealField, QuoteIdent), Fields[i].FieldName] );
      end;
    usInserted:
      if bIsModified then begin
        if sFields <> '' then sFields := sFields + ', ';
        sFields := sFields + QuoteIdentifier(sRealField, QuoteIdent);
        if sKeys <> '' then sKeys := sKeys + ', ';
        if Fields[i].IsNull then
          sKeys := sKeys + 'NULL'
        else
          sKeys := sKeys + ':' + Fields[i].FieldName;
      end;
    end;
    	// change WHERE clause for SELECT, UPDATE and DELETE statements
	// if all columns are used to locate the modified record or
      //upWhereChanged and upWhereKeyOnly use index fields. In any case, exclude Blob columns in WHERE clause
    if (UpdateStatus in [usUnmodified, usModified, usDeleted]) and not Fields[i].IsBlob and
       ( (UpdateMode = upWhereAll) or
         ((UpdateMode = upWhereChanged) and bIsModified) or
         ((UpdateMode = upWhereChanged) and (UpdateStatus in [usUnmodified])) or
         Fields[i].IsIndexField
       )
    then begin
      if sKeys <> ''
      then sKeys := sKeys + stAndOp;
      if Fields[i].OldValue = Null then
        sKeys := sKeys + Format( '%s%s is NULL', [SetIndent, QuoteIdentifier(sRealField, QuoteIdent)] )
      else
        sKeys := sKeys + Format( '%s%s = :OLD_%s', [SetIndent, QuoteIdentifier(sRealField, QuoteIdent), Fields[i].FieldName] )
    end;
  end;

  sTable := QuoteIdentifier(TableName, QuoteIdent);
  if (UpdateStatus in [usUnmodified, usModified, usDeleted]) and (sKeys <> '') then
    sKeys := stWhere + sKeys;
  case UpdateStatus of
    usUnmodified:
      if sKeys <> '' then
        Result := Format(stSelectFmt, [sFields, sTable + ' ' + sKeys]);
    usModified:
    	// if field's values are not modified (for example, new value is equal old one), Result will empty
      if sFields <> '' then
        Result := Format(stUpdateFmt, [sTable, sFields, sKeys]);
    usDeleted:
      Result := Format(stDeleteFmt, [sTable, sKeys]);
    usInserted:
      Result := Format(stInsertFmt, [sTable, sFields, sKeys]);
  end;
end;
{$ENDIF}

{ Insert repetable char Ch into string S: if find Ch then insert Ch after one }
function RepeatChar(Ch: Char; S: string): string;
var
  i: Integer;
begin
  i := 1;
  Result := S;
  while i <= Length(Result) do begin
    if Result[i] = Ch then begin
      Insert( Ch, Result, i+1 );
      Inc(i);
    end;
    Inc(i);
  end;
end;

// if UseQuote = True, bracket identifier(-es) in double quotes
function QuoteIdentifier(AName: string; UseQuote: Boolean): string;
var
  i: Integer;
begin
        // process a point delimiter OWNER.TABLE -> "OWNER"."TABLE"
  if UseQuote then begin
    Result := AName;
    i := 1;
    while i <= Length(Result) do begin
      if Result[i] = '.' then begin
        Insert( '"', Result, i );
        Inc(i);
        if (i + 1) <= Length(Result) then begin
          Insert( '"', Result, i + 1 );
          Inc(i);
        end;
      end;
      Inc(i);
    end;
    Result := '"' + Result + '"';
  end else
    Result := AName;
end;

// create ODBC command to call procedure (OLEDB uses ODBC syntax too)
function CreateProcedureCallCommand( AProcName: string; AParams: TSDHelperParams; IsMSSQL: Boolean ): string;
const
  ODBCParamMarker	= '?';
var
  i: Integer;
  sParams, sResult: string;
begin
  sParams := '';
  sResult := '';
  if Assigned(AParams) then for i:=0 to AParams.Count-1 do begin
    if AParams[i].ParamType in [ptResult] then
      sResult := ODBCParamMarker + '=';
    if not (AParams[i].ParamType in [ptInput, ptInputOutput, ptOutput]) then
      Continue;

    if Length(sParams) > 0 then
      sParams := sParams + ', ';
    sParams := sParams + ODBCParamMarker;
  end;
  	// ODBC driver for MSSQL (v.2000.81.x) returns error, when procedure w/o parameters is called with empty brackets as 'CALL PROC()'
  if IsMSSQL or (sParams <> '') then
    sParams := '(' + sParams + ')';
  Result := Format( '{%sCALL %s%s}', [sResult, AProcName, sParams] );
end;

// replace parameter names with prefix ':' on ODBC/OLEDB place holder '?'
function ReplaceParamMarkers( OldStmt: string; AParams: TSDHelperParams): string;
const
  ParamPrefix	= ':';
  ParamMarker	= '?';
var
  i, ParamPos: Integer;
  sFullParamName: string;
begin
  Result := OldStmt;
  if not Assigned(AParams) then
    Exit;
  for i:=0 to AParams.Count-1 do begin
    sFullParamName := ParamPrefix + AParams[i].Name;
    ParamPos := LocateText( sFullParamName, Result );
    if ParamPos = 0 then begin
        // check for quoted parameter names
      sFullParamName := ParamPrefix + '"'+AParams[i].Name+'"';
      ParamPos := LocateText( sFullParamName, Result );
      if ParamPos = 0 then
        Continue;
    end;
  	// remove parameter name with prefix(':')
    Delete( Result, ParamPos, Length(sFullParamName) );
  	// set parameter marker
    Insert( ParamMarker, Result, ParamPos );
  end;
end;

{$IFDEF XSQL_CLR}
// Returns nnumber of characters in a string excluding null terminator
function StrLen( S: TSDCharPtr ): Integer;
const
  ZS	= $00;
begin
  Result := 0;
  if not Assigned( S ) then
    Exit;
        // get string length
  while HelperMemReadByte( S, Result ) <> ZS do
    Inc(Result);
end;

function StrNew( S: TSDCharPtr ): TSDCharPtr;
var
  i: Integer;
begin
  Result := nil;
  i := StrLen( S );
  if i = 0 then
    Exit;
  Inc(i);	// size with null terminator
  Result := SafeReallocMem(nil, i);
  SafeCopyMem(S, Result, i);
end;
{$ENDIF}

{ Removes trailing spaces }
procedure StrRTrim( S: TSDCharPtr );
const
  SP	= $20;
  ZS	= $00;
var
  i: Integer;
begin
{$IFDEF XSQL_CLR}
  if not Assigned( S ) then
    Exit;
        // get string length
  i := StrLen( S );
  Dec(i);	// offset of the last char
  while i >= 0 do begin
    if HelperMemReadByte( S, i ) = SP then
      HelperMemWriteByte( S, i, ZS )
    else
      Break;
    Dec(i);
  end;
{$ELSE}
  i := -1;
  if AnsiStrComp(S, '') <> 0 then
    i := StrLen( S ) - 1;

  while i >= 0 do begin
    if S[i] = Char( SP ) then
      S[i] := Char( ZS )
    else
      Break;
    Dec( i );
  end;
{$ENDIF}
end;

{ Parse statement utility (later move to SDEngine or other common unit), it'll be useful for macro support }
// AnsiChar(..) is used to exclude Delphi 8 error "WideChar reduced to byte char in set expression"
function IsNameDelimiter(C: Char): Boolean;
begin
        // '(', ')' was added to correctly parse macro name like 'call %cProcName(10)'
        // '=' was added to correctly parse parameter name like ':param=1'
  Result := AnsiChar(C) in [' ', ',', ';', '(', ')', '=', #13, #10];
end;

function IsLiteral(C: Char): Boolean;
begin
  Result := AnsiChar(C) in ['''', '"'];
end;

function StripLiterals(const Str: string): string;
var
  Len: Integer;
begin
  Result := Str;
  Len := Length(Result);
  if (Len >= 1) and IsLiteral( Result[1] ) then
    Result := Copy( Result, 2, Length(Result)-1 );
  Len := Length(Result);
  if IsLiteral( Result[Len] ) then
    SetLength( Result, Len-1 );
end;

// AnsiString is used to exclude 'deprecate warning' in D8, 9
function LocateText(const Substr, S: AnsiString): Integer;
begin
        // Pos works with single-byte character sets in contrast to AnsiPos
  Result := AnsiPos( AnsiUpperCase(Substr), AnsiUpperCase(S) );
end;

function StrFindFromPos(const Substr, S: string; StartPos: Integer): Integer;
var
  Str: string;
begin
  if StartPos > 1 then
  	// Copy returns empty string when StartPos > Length(S)
    Str := Copy(S, StartPos, Length(S) - StartPos + 1)
  else begin
    Str := S;
    StartPos := 1;
  end;
  Result := LocateText( Substr, Str );
  if Result > 0 then
    Result := StartPos + (Result - 1);	// return an index of Pascal string
end;

{ Returns False, when nothing is changed. Once parameter specifies only one changing }
function ReplaceString( Once: Boolean; OldStr, NewStr: string; var ResultStr: string ): Boolean;
var
  i, FoundPos, Literals: Integer;
  bFound: Boolean;
begin
  Result := False;

  repeat
    FoundPos := 0;
    repeat
    	// pass the first char of the similar string, which was found earlier
      if FoundPos > 0 then Inc(FoundPos);
      FoundPos := StrFindFromPos( OldStr, ResultStr, FoundPos );
    	// check whether OldStr at the end of ResultStr or has a delimiter after itself
      bFound :=
    	(FoundPos > 0) and
    	((Length(ResultStr) = FoundPos + Length(OldStr) - 1) or
          IsNameDelimiter( ResultStr[FoundPos + Length(OldStr)] )
        );

      if bFound then begin
        Literals := 0;
        for i := 1 to FoundPos - 1 do
          if IsLiteral(ResultStr[i]) then Inc(Literals);
        bFound := Literals mod 2 = 0;	// OldStr has not to be quoted
        if bFound then begin
          Delete( ResultStr, FoundPos, Length(OldStr) );
          Insert( NewStr, ResultStr, FoundPos );
          FoundPos := FoundPos + Length(NewStr) - 1;
          Result := True;
          if Once then
            Exit;
        end;
      end;
    until FoundPos = 0;
  until not bFound;

end;


{----------------------- END OF UTILITY FUNCTIONS/PROCEDURES ------------------}

function IsBlobType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in BlobTypes;
end;

function IsSupportedBlobTypes(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in SupportedBlobTypes;
end;

function IsRequiredSizeTypes(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in RequiredSizeTypes;
end;

function IsDateTimeType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in DateTimeTypes;
end;

function IsNumericType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in NumericTypes;
end;

function GetAppName: string;
begin
  Result := ExtractFileName( Application.ExeName );
end;

function GetComputerNameStr: AnsiString;
var
  nSize: {$IFDEF XSQL_VCL4}Cardinal{$ELSE}Integer{$ENDIF};
{$IFNDEF XSQL_CLR}
  szCompName: PChar;
begin
  Result := '';
  nSize := MAX_COMPUTERNAME_LENGTH + 1;
  szCompName := StrAlloc( nSize );
  try
    if GetComputerName(szCompName, nSize) then
      if nSize > 0 then
        Result := StrPas(szCompName);
  finally
    StrDispose( szCompName );
  end;
{$ELSE}
  sb: StringBuilder;
begin
  Result := '';
  nSize := MAX_COMPUTERNAME_LENGTH + 1;
  sb := StringBuilder.Create(nSize);
  if GetComputerName(sb, nSize) and (nSize > 0) then
    Result := sb.ToString;
{$ENDIF}
end;

function GetModuleFileNameStr(hModule: HINST): string;
var
  nSize: Integer;
{$IFNDEF XSQL_CLR}
  szLib: array[0..MAX_PATH] of Char;
begin
  nSize := GetModuleFileName(hModule, szLib, MAX_PATH);
  if nSize > 0 then begin
    szLib[nSize] := #$00;
    SetString(Result, szLib, nSize);
  end else begin
    nSize := GetLastError;
    raise Exception.CreateFmt('System error %d', [nSize]);
  end;
{$ELSE}
  sb: StringBuilder;
begin
  Result := '';
  nSize := MAX_PATH + 1;
  sb := StringBuilder.Create(nSize);
  try
    nSize := Windows.GetModuleFileName(hModule, sb, MAX_PATH);
    if nSize > 0 then
      Result := sb.ToString
    else begin
        // in Delphi 8 IDE GetModuleFileName returns an empty string and GetLastError returns 0
      nSize := GetLastError;
      raise Exception.CreateFmt('System error %d', [nSize]);
    end;
  finally
    sb.Free;
  end;
{$ENDIF}
end;

function GetHostName: string;
begin
  Result := GetComputerNameStr;
end;

function GetXSQLConnectVersion: string;
begin
  Result := SXSQLConnectVersion;
end;

{ Returns a parameter name for the specified server }
function GetSqlLibParamName(ServerTypeCode: Integer): string;
var
  s: string;
  st: TISqlServerType;
begin
  Result := '';
  s := '';
  for st:=Low(ServerTypeNames) to High(ServerTypeNames) do
    if Ord(st) = ServerTypeCode then begin
      s := ServerTypeNames[st];
      Break;
    end;
  if s <> '' then
    Result := Format(szAPILIBRARY_FMT, [s]);
end;

function ExtractLibName(const LibNames: string; Sep: Char; var Pos: Integer): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(LibNames)) and (LibNames[I] <> Sep) do
    Inc(I);
  Result := Trim( Copy(LibNames, Pos, I - Pos) );
  if (I <= Length(LibNames)) and (LibNames[I] = Sep) then
    Inc(I);
  Pos := I;
end;

{
  Extracts only stored procedure name(with owner) from full name ( <owner.procname;group_no> )
  Used by SDMss and SDSyb units
}
function ExtractStoredProcName(const sFullProcName: string): string;
var
  i: Integer;
begin
  Result := sFullProcName;

  i := Pos(';', Result);
	// if group number separator (;) found
  if i > 0 then
    Result := Copy( Result, 1, i-1 );
end;

{ functions to parsing TXSQLDatabase.RemoteDatabase property. They're used in SDMss.pas, SDMySQL.pas }
function ExtractServerName(const sRemoteDatabase: string): string;
var
  i: Integer;
begin
  Result := sRemoteDatabase;
	// looking delimiter
  i := 1;
  while i <= Length(Result) do begin
    if IsDelimiter(ServerDelimiters, Result, i) then
      Break;
    Inc(i);
  end;
	// extract substring before delimiter
  if i <= Length(Result) then
    Result := Copy(Result, 1, i-1);
end;

function ExtractDatabaseName(const sRemoteDatabase: string): string;
var
  i: Integer;
begin
  Result := '';
	// looking delimiter
  i := 1;
  while i <= Length(sRemoteDatabase) do begin
    if IsDelimiter(ServerDelimiters, sRemoteDatabase, i) then
      Break;
    Inc(i);
  end;
	// extract substring after delimiter
  if i < Length(sRemoteDatabase) then begin
    Result := Copy(sRemoteDatabase, i+1, Length(sRemoteDatabase)-i);
    	// exclude repeated delimiters, in case of presence    
    while Length(Result) > 0 do
      if IsDelimiter(ServerDelimiters, Result, 1) then begin
        if Length(Result) = 1 then
          Result := ''
        else
          Result := Copy(Result, 2, Length(Result)-1)
      end else
        Break;
  end;
end;

// if s contains wildcards for LIKE operator, only '%' wildcard is checked. If one '_' wildcard is used, then IB6.5 does not return correct rows
function ContainsLikeWildcards(const s: string): Boolean;
begin
  Result := Pos('%', s) > 0;
end;

{ Splits AFullObjName on owner and object names, which are separated by point.
Returns False if an owner value is empty. In case of empty Owner or Obj value,
it is replaced by '%' to use with LIKE predicat }
function ExtractOwnerObjNames(const AFullObjName: string; var AOwnerName, AObjName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  i := Pos('.', AFullObjName);
  if i >= 0 then begin
    AOwnerName := Copy(AFullObjName, 0, i-1);
    AObjName := Copy(AFullObjName, i+1, Length(AFullObjName)-i);
    Result := True;
  end else
    AObjName := AFullObjName;

  if Trim(AOwnerName) = '' then
    AOwnerName := '%';
  if Trim(AObjName) = '' then
    AObjName := '%';
end;

{ Returns file version, which is encrypted in integer number }
function GetFileVersion(const FileName: string): LongInt;
type
  TTransTable = array[0..0,0..1] of Word;
var
  bOk: Boolean;
  InfoSize, Len: DWORD;
  lpInfoData: TBytes;
  pFileInfo: TSDPtr;
{$IFDEF XSQL_CLR}
  FileInfo: TVSFixedFileInfo;
  dwVer: DWORD;
{$ELSE}
  pTransTable: ^TTransTable;
  szStringValue: PChar;
  sLangCharSet: string;
{$ENDIF}
begin
  Result := 0;
  InfoSize := GetFileVersionInfoSize( {$IFDEF XSQL_CLR}FileName{$ELSE}PChar(FileName){$ENDIF}, Len );
  if InfoSize <= 0 then
    Exit;

  SetLength(lpInfoData, InfoSize);
  try
    bOk := GetFileVersionInfo( {$IFDEF XSQL_CLR}FileName{$ELSE}PChar(FileName){$ENDIF}, 0, InfoSize, lpInfoData );
    bOk := bOk and VerQueryValue( lpInfoData, '\', pFileInfo, Len );
    if not bOk then
      Exit;
{$IFDEF XSQL_CLR}
    FileInfo := TVSFixedFileInfo(Marshal.PtrToStructure(pFileInfo, TypeOf(TVSFixedFileInfo)));
    dwVer := FileInfo.dwFileVersionMS;
    Result:= MakeVerValue(dwVer shr 16, dwVer and $FFFF);
{$ELSE}
    if VerQueryValue(lpInfoData, '\VarFileInfo\Translation', Pointer(pTransTable), Len) then
      sLangCharSet := IntToHex(pTransTable^[0,0], 4) + IntToHex(pTransTable^[0,1], 4);
    if VerQueryValue(lpInfoData, PChar('\StringFileInfo\'+sLangCharSet+'\FileVersion'), Pointer(szStringValue), Len) then
      Result := VersionStringToDWORD(StrPas(szStringValue));
{$ENDIF}
  finally
    SetLength(lpInfoData, 0);
  end;
end;

procedure ReadFileVersInfo(const FileName: string; var ProductName, VersStr: string);
type
  TTransTable = array[0..0,0..1] of Word;
var
  bOk: Boolean;
  InfoSize, Len: DWORD;
  lpInfoData: TBytes;
  pFileInfo: TSDPtr;
  FileInfo: TVSFixedFileInfo;
{$IFDEF XSQL_CLR}
  pTransTable: TSDPtr;
{$ELSE}
  pTransTable: ^TTransTable;
{$ENDIF}
  sBeta, sLangCharSet, sSubBlock: string;
  szStringValue: TSDCharPtr;
begin
  sBeta := '';
  InfoSize := GetFileVersionInfoSize( {$IFDEF XSQL_CLR}FileName{$ELSE}PChar(FileName){$ENDIF}, Len );

  if InfoSize <= 0 then Exit;

  SetLength(lpInfoData, InfoSize);
  try
    bOk := GetFileVersionInfo( {$IFDEF XSQL_CLR}FileName{$ELSE}PChar(FileName){$ENDIF}, 0, InfoSize, lpInfoData );
    bOk := bOk and VerQueryValue( lpInfoData, '\', pFileInfo, Len );

    if not bOk then Exit;

{$IFDEF XSQL_CLR}
    FileInfo := TVSFixedFileInfo( Marshal.PtrToStructure(pFileInfo, TypeOf(TVSFixedFileInfo)) );
{$ELSE}
    FileInfo := TVSFixedFileInfo( pFileInfo^ );
{$ENDIF}
    if (FileInfo.dwFileFlags and VS_FF_PRERELEASE) <> 0 then
      sBeta := 'beta';

    VersStr := Format('%d.%d.%d%s',
    	[FileInfo.dwFileVersionMS shr 16,
         FileInfo.dwFileVersionMS and $0000FFFF,
	 FileInfo.dwFileVersionLS shr 16,
         sBeta
        ]);
{$IFDEF XSQL_CLR}
    if VerQueryValue(lpInfoData, '\VarFileInfo\Translation', TSDPtr(pTransTable), Len) then
      sLangCharSet := IntToHex( HelperMemReadInt16(pTransTable, 0), 4) + IntToHex( HelperMemReadInt16(pTransTable, SizeOf(Word)), 4);
{$ELSE}
    if VerQueryValue(lpInfoData, '\VarFileInfo\Translation', TSDPtr(pTransTable), Len) then
      sLangCharSet := IntToHex(pTransTable^[0,0], 4) + IntToHex(pTransTable^[0,1], 4);
{$ENDIF}
    sSubBlock := '\StringFileInfo\'+sLangCharSet+'\ProductName';
    if VerQueryValue(lpInfoData, {$IFDEF XSQL_CLR}sSubBlock{$ELSE}PChar(sSubBlock){$ENDIF}, TSDPtr(szStringValue), Len) then
      ProductName := {$IFDEF XSQL_CLR}Marshal.PtrToStringAuto( szStringValue ){$ELSE}szStringValue{$ENDIF};	// it is necessary to PtrToStringAuto for Dephi 8 (PtrToStringAnsi converts only the first symbol)
  finally
    SetLength(lpInfoData, 0);
  end;
end;


{$IFNDEF XSQL_CLR}

{ Case-sensitive }
function ContainsStr(const AStr, ASubStr: string): Boolean;
begin
{$IFDEF XSQL_VCL6}
  Result := AnsiContainsStr(AStr, ASubStr);
{$ELSE}
  Result := AnsiPos(ASubStr, AStr) > 0;
{$ENDIF}
end;

{ Case-insensitive }
function ContainsText(const AStr, ASubStr: string): Boolean;
begin
{$IFDEF XSQL_VCL6}
  Result := AnsiContainsText(AStr, ASubStr);
{$ELSE}
  Result := AnsiPos(AnsiUpperCase(ASubStr), AnsiUpperCase(AStr)) > 0;
{$ENDIF}
end;

{$ENDIF}

// It is necessary to use one call in D8(where Ansi.. functions are deprecated) and D4-7 implementation
function HelperCompareStr(const S1, S2: string): Integer;
begin
{$IFDEF XSQL_CLR}
  Result := CompareStr(S1, S2);
{$ELSE}
  Result := AnsiCompareStr(S1, S2);
{$ENDIF}
end;

function HelperCompareText(const S1, S2: string): Integer;
begin
{$IFDEF XSQL_CLR}
  Result := CompareText(S1, S2);
{$ELSE}
  Result := AnsiCompareText(S1, S2);
{$ENDIF}
end;

function VarIsStrType(const AValue: Variant): Boolean;
begin
  case VarType(AValue) of
{$IFDEF XSQL_CLR}
    varChar,
{$ELSE}
    varOleStr,
{$ENDIF}
    varString: Result := True;
  else
    Result := False;
  end
end;

// compares or contains using options, where S2 can be pattern, when PartialKey is True
function CompareTextExt(const S1, S2: string; CaseInsensitive, PartialKey, AtStartOnly: Boolean): Integer;
var
  MinLen: Integer;	// partial key length
  bRes: Boolean;
begin
  if not PartialKey then
    if CaseInsensitive
    then Result := HelperCompareText( S1, S2 )
    else Result := HelperCompareStr( S1, S2 )
  else        	// partial compare
    if AtStartOnly then begin
      if Length(S2) < Length(S1)
      then MinLen := Length(S2)
      else MinLen := Length(S1);
      if MinLen > 0 then begin
        if CaseInsensitive then
          if Length(S1) < Length(S2)
          then Result := HelperCompareText( S1, S2 )
          else Result := HelperCompareText( Copy(S1, 1, MinLen), Copy(S2, 1, MinLen) )
        else
          if Length(S1) < Length(S2)
          then Result := HelperCompareStr( S1, S2 )
          else Result := HelperCompareStr( Copy(S1, 1, MinLen), Copy(S2, 1, MinLen) );
      end else begin
              // if (MinLen = 0) , then compare string lengths
        if Length(S1) < Length(S2) then
          Result := -1
        else if Length(S1) > Length(S2) then
          Result := 1
        else
          Result := 0;
      end;
    end else begin
      if CaseInsensitive
      then bRes := ContainsText( S1, S2 )
      else bRes := ContainsStr( S1, S2 );
      if bRes
      then Result := 0
      else Result := -1;
    end
end;

// compare variants
function CompareVar(V1, V2: Variant; CaseInsensitive: Boolean): Integer;
var
  i: Integer;
begin
  	// if one value from two is null then exit
  if VarIsNull(V1) then begin
    if VarIsNull(V2) then begin
      Result := 0;
      Exit;
    end else if not VarIsNull(V2) then begin
      Result := -1;
      Exit;
    end
  end else if VarIsNull(V2) then begin
    Result := 1;
    Exit;
  end;

  if ((VarType(V1) and not varTypeMask) <> varArray) and
     ((VarType(V2) and not varTypeMask) <> varArray)
  then begin			// V1 and V2 are not arrays
    if VarIsStrType(V1) and VarIsStrType(V2) then
      Result := CompareTextExt(V1, V2, CaseInsensitive, False, True)
    else
      if V1 = V2 then
        Result := 0
      else if V1 > V2 then
        Result := 1
      else
        Result := -1;
  end else begin        // V1, V2 are not arrays
    Result := 0;
    for i:= VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do begin
      Result := CompareVar(V1[i], V2[i], CaseInsensitive);
      if Result <> 0 then
        Break;
    end;
  end;
end;

{ comparison values of the following types: Variant or Array of Variant,
 where V2 is key value, which can be coincided partially with V1 if PartialKey is True.
 If AtStart is True, substring V2 is looking at the beginning of V1, else it'll be looking in any part of V1 }
function VarIsEqual(AVar1, AVar2: Variant; CaseInsensitive, PartialKey, AtStartOnly: Boolean): Boolean;
var
  i: Integer;
  V1, V2: Variant;
begin
  Result := False;
  	// if one value from two is null then exit
  if (VarIsNull(AVar1) and not VarIsNull(AVar2)) or
     (VarIsNull(AVar2) and not VarIsNull(AVar1))
  then
    Exit;
  if not VarIsArray(AVar1) and not VarIsArray(AVar2) then begin	// AVar1 and AVar2 are not arrays
    V1 := AVar1;
    V2 := AVar2;
    if PartialKey then begin
      if not VarIsStrType(V1) then
        VarCast(V1, V1, varString);
      if not VarIsStrType(V2) then
        VarCast(V2, V2, varString);
    end;
    if VarIsStrType(V1) and VarIsStrType(V2) then
      Result := CompareTextExt(V1, V2, CaseInsensitive, PartialKey, AtStartOnly) = 0
    else
      Result := V1 = V2
  end else begin			// AVar1 and AVar2 are arrays
    if VarArrayHighBound(AVar1, 1) <> VarArrayHighBound(AVar2, 1) then
      Exit;     // arrays have different size
    Result := True;
    for i:= VarArrayLowBound(AVar1, 1) to VarArrayHighBound(AVar1, 1) do begin
      V1 := AVar1[i];
      V2 := AVar2[i];
      if PartialKey then begin
        if not VarIsStrType(V1) then
          VarCast(V1, V1, varString);
        if not VarIsStrType(V2) then
          VarCast(V2, V2, varString);
      end;
      if VarIsStrType(V1) and VarIsStrType(V2) then
        Result := Result and (CompareTextExt(V1, V2, CaseInsensitive, PartialKey, AtStartOnly) = 0)
      else
        Result := Result and (V1 = V2);
      if not Result then
        Break;
    end;
  end;
end;

{ ------- The following functions are used in SDMySQL and SDPgSQL units ------ }

{ To avoid using Math unit for compatibility with all Delphi version (maybe, Math unit isn't included with some Delphi version) }
function Max(A, B: Integer): Integer;
begin
  if A >= B then
    Result := A
  else
    Result := B;
end;

function MaxIntValue(A, B: Integer): Integer;
begin
  Result := Max(A, B);
end;

function MinIntValue(A, B: Integer): Integer;
begin
  if A <= B then
    Result := A
  else
    Result := B;
end;


{ Define last day of a month }
function LastDay(Month, Year: Word): Word;
begin
  Result := 30;
  case Month of
    1,3,5,7,8,10,12:
      Result := 31;
    2: begin
        Result := 28;
        if IsLeapYear(Year) then
          Inc(Result);
      end;
  end;
end;

function GetMajorVer(Ver: LongInt): Word;
begin
  Result := HiWord(Ver);
end;

function GetMinorVer(Ver: LongInt): Word;
begin
  Result := LoWord(Ver);
end;

{ Pack version number in 4 byte (DOUBLE WORD) }
function MakeVerValue( MajorVer, MinorVer: Word ): Integer;
begin
  Result := MakeLong( MinorVer, MajorVer );
end;

{ find first digits in the string sInit and convert them to number }
function VersionStringToDWORD(const VerStr: AnsiString): LongInt;
const
  DigitSet = ['0'..'9'];
var
  i: Integer;
  HVer, LVer: LongInt;
  sVer: AnsiString;
begin
  HVer := 0;
  LVer := 0;
  i := 1;
  sVer := VerStr;
  	// find first digit
  while (i <= Length(sVer)) and not(sVer[i] in DigitSet) do
    Inc(i);
  if i > 1 then
    Delete(sVer, 1, i-1);
    	// find major version number
  for i:=1 to Length(sVer) do
    if not(sVer[i] in ['0'..'9']) then begin
      HVer := StrToIntDef( Copy(sVer, 1, i-1), 0 );
      Delete(sVer, 1, i);
      Break;
    end;
    	// find next digit group
  i := 1;
  while (i <= Length(sVer)) and not(sVer[i] in DigitSet) do
    Inc(i);
  if i > 1 then
    Delete(sVer, 1, i-1);
    	// find minor version number
  for i:=1 to Length(sVer) do
    if not(sVer[i] in ['0'..'9']) then begin
      LVer := StrToIntDef( Copy(sVer, 1, i-1), 0 );
      sVer := '';
      Break;
    end;
	// if digits follow till the end of the string
  if sVer <> '' then
    LVer := StrToIntDef(sVer, 0);
  Result := MakeVerValue( HVer, LVer );
end;

{ Convert SQL Date (YYYY-MM-DD HH:NN:SS) to TDateTime with constant date part }
function SqlDateToDateTime(Value: string): TDateTime;
var
  Year, Month, Day, Hour, Min, Sec: Word;
  Temp: string;
begin
  Temp  := Value;
  Year  := StrToIntDef(Copy(Temp, 1, 4), 1);
  Year  := MaxIntValue(Year, 1);
  Month := StrToIntDef(Copy(Temp, 6, 2), 1);
  Month := MinIntValue(MaxIntValue(Month, 1), 12);
  Day   := StrToIntDef(Copy(Temp, 9, 2), 1);
  Day   := MinIntValue(MaxIntValue(Day, 1), LastDay(Month, Year));
  Result := EncodeDate(Year, Month, Day);

  if Length(Temp) > 11 then begin
    Temp := Copy(Temp, 12, 8);
    Hour := StrToIntDef(Copy(Temp, 1, 2), 0);
    Hour := MinIntValue(MaxIntValue(Hour, 0), 23);
    Min  := StrToIntDef(Copy(Temp, 4, 2), 0);
    Min  := MinIntValue(MaxIntValue(Min, 0), 59);
    Sec  := StrToIntDef(Copy(Temp, 7, 2), 0);
    Sec  := MinIntValue(MaxIntValue(Sec, 0), 59);
	// if date value is before "12/30/1899 12:00", then Result < 0
    if Result >= 0 then
      Result := Result + EncodeTime(Hour, Min, Sec, 0)
    else
      Result := Result - EncodeTime(Hour, Min, Sec, 0);    
  end;
end;

{ Convert SQL Time (YYYY-MM-DD HH:NN:SS) to TDateTime
 Any part of date could be equal zero or out of range, because it's need additional processing }
function SqlTimeToDateTime(Value: string): TDateTime;
var
  Year, Month, Day, Hour, Min, Sec: Word;
  Temp: string;
begin
  Temp   := Value;
  Result := 0;
  	// if date part is present
  if Length(Temp) >= 10 then begin
    Year  := StrToIntDef(Copy(Temp, 1, 4), 1);
    Year := Max(Year, 1);
    Month := StrToIntDef(Copy(Temp, 6, 2), 1);
    Month := MinIntValue(MaxIntValue(Month, 1), 12);
    Day   := StrToIntDef(Copy(Temp, 9, 2), 1);
    Day   := MinIntValue(MaxIntValue(Day, 1), LastDay(Month, Year));

    Result := EncodeDate(Year, Month, Day);
    Temp := Copy(Temp, 12, 8);
  end;
  if Length(Temp) >= 8 then begin
    Hour := StrToIntDef(Copy(Temp, 1, 2), 0);
    Hour := MinIntValue(MaxIntValue(Hour, 0), 23);
    Min  := StrToIntDef(Copy(Temp, 4, 2), 0);
    Min  := MinIntValue(MaxIntValue(Min, 0), 59);
    Sec  := StrToIntDef(Copy(Temp, 7, 2), 0);
    Sec  := MinIntValue(MaxIntValue(Sec, 0), 59);
	// if date value is before "12/30/1899 12:00", then Result < 0
    if Result >= 0 then
      Result := Result + EncodeTime(Hour, Min, Sec, 0)
    else
      Result := Result - EncodeTime(Hour, Min, Sec, 0);
  end;
end;

{ Convert string value to float with '.'(Delphi) delimiter with default value }
function SqlStrToFloatDef(Value: AnsiString; Default: Double): Double;
var
  i, Len: Integer;
begin
  i := 1;
  Len := Length(Value);
  while (i <= Len) and (Value[i] <> #0) do begin
  	// change decimal delimiter to one, which is recognized by Delphi
    if (Value[i] in ['.',',']) and
       (Value[i] <> DecimalSeparator) and
       (Length(DecimalSeparator) > 0)
    then
{$IFDEF XSQL_CLR}
      Value[i] := AnsiChar(DecimalSeparator[1]);
{$ELSE}
      Value[i] := DecimalSeparator;
{$ENDIF}
    Inc(i);
  end;
  if Value <> '' then
    try
      Result := StrToFloat(Value);
    except
      Result := Default;
    end
  else
    Result := 0;
end;

{ Check valid literal values for the "true" state (from PostreSQL docs)  }
function SqlStrToBoolean(Value: AnsiString): Boolean;
begin
  Result :=
    (AnsiCompareText(Value, 'true') = 0) or
    (AnsiCompareText(Value, 'yes') = 0 ) or
    ((Length(Value) = 1) and (Value[1] in ['1', 'y', 'Y', 't', 'T']));
end;

{ ------- The previous functions are used in SDMySQL and SDPgSQL units ------ }

{ it is used in SDMss and SDSyb units for convert binary/blob type to hex string. Binary/varbinary value could be pased as array }
function CnvtVarBytesToHexString(Value: Variant): string;
var
  i, MaxIndex, k, Len: Integer;
  b: Byte;
  sValue, sHexValue: string;
  bStr: Boolean;
{$IFDEF XSQL_CLR}
  sb: StringBuilder;   // s[i] := .. is less efficient code in Delphi 8 for NET
{$ENDIF}
begin
  bStr := VarIsStrType(Value);
  if bStr then begin
    sValue := VarToStr( Value );
    i := 1;
    MaxIndex := Length( sValue );
  end else begin
    MaxIndex := VarArrayHighBound(Value, 1);
    i := VarArrayLowBound(Value, 1);
  end;
  if MaxIndex = 0 then begin
    Result := 'NULL';
    Exit;
  end;

  Len := 2 + 2*(MaxIndex - i + 1);
{$IFDEF XSQL_CLR}
  sb := StringBuilder.Create(Len);
  sb.Chars[0] := '0';   // index stats from 0
  sb.Chars[1] := '1';
{$ELSE}
  SetLength(Result, Len);
  Result[1] := '0';
  Result[2] := 'x';
{$ENDIF}
  k := 3;
  while i <= MaxIndex do begin
    if bStr then
      b := Ord(sValue[i])
    else
      b := Value[i];
    sHexValue := Format('%.2x', [b]);
    ASSERT( k <= Len );
{$IFDEF XSQL_CLR}
    sb.Chars[k-1] := sHexValue[1];
    sb.Chars[k-2] := sHexValue[2];
{$ELSE}
    Result[k]   := sHexValue[1];
    Result[k+1] := sHexValue[2];
{$ENDIF}
    Inc(i);
    k := k + 2;
  end;
{$IFDEF XSQL_CLR}
    Result := sb.ToString;
{$ENDIF}
end;

// Returns a hexademical value from the specified position (0<=n<=7).
//Integer value(32bit) has 8 hexademical digits. When n = 0,
//then returned right digit, i.e. 'F' for value $0345A5CF, and '0' for n=7.
function HexDigit(v, n: Integer): Byte;
begin
  case n of
    0: Result := v;
    1: Result := v shr 4;
    2: Result := v shr 8;
    3: Result := v shr 12;
    4: Result := v shr 16;
    5: Result := v shr 20;
    6: Result := v shr 24;
    7: Result := v shr 28;
  else
    raise ERangeError.Create('Byte number has to be in 0-7 range ');
  end;
  Result := $0000000F and Result;
end;

// Returns char for hexademical digits, where 0<=n<=7
function HexDigitChar(v, n: Integer): Char;
const
  ArrHexDigits: array[0..$F] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
  Result := ArrHexDigits[ HexDigit(v, n) ];
end;

// Convert from binary GUID (it requires 16bytes) to character(38bytes) format
//This function is about 2 times more quickly than the following code: <s := GUIDToString(GuidVal); StrLCopy(GuidBuf, PChar(s), 38);>
procedure GuidToCharBuffer(SrcBuf: TSDValueBuffer; SrcBufLen: Integer; DstBuf: TSDValueBuffer; DstBufLen: Integer);
{$IFDEF XSQL_CLR}
begin
  ASSERT( False, 'GuidToCharBuffer is not implemented for .NET' );
end;
{$ELSE}
var
  i: Integer;
  b: Byte;
begin
  ASSERT( (SrcBufLen >= SizeOfGuidBinary) and (DstBufLen >= SizeOfGuidString) );
  i := 0;
  DstBuf[i] := '{';
  Inc(i);
        // 4 hex number (in reverse order)
  b := Byte( SrcBuf[3] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[2] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[1] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[0] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
        // 2 hex number (in reverse order)
  DstBuf[i] := '-';
  Inc(i);
  b := Byte( SrcBuf[5] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[4] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
        // 2 hex number (in reverse order)
  DstBuf[i] := '-';
  Inc(i);
  b := Byte( SrcBuf[7] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[6] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
        // 2 hex number
  DstBuf[i] := '-';
  Inc(i);
  b := Byte( SrcBuf[8] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[9] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
        // 6 hex number
  DstBuf[i] := '-';
  Inc(i);
  b := Byte( SrcBuf[10] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[11] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[12] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[13] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[14] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);
  b := Byte( SrcBuf[15] );
  DstBuf[i] := HexDigitChar(b, 1);
  Inc(i);
  DstBuf[i] := HexDigitChar(b, 0);
  Inc(i);

  DstBuf[i] := '}';
end;
{$ENDIF}

(*
	Processes theSelect and returns field info in FldInfo.
For example: FldInfo.Strings[i] = "FieldName=[Owner.]Table.Column",
             TblInfo.Strings[i] = "Alias=TableName"
where
	FieldName (column heading) is equal Field[i].FieldName,
        Column - a really column name in table with name <Table>

        FieldList is a list of Field[i].FieldName or FieldDescs[i].FieldName.
        It's required, for example, in case of <select * from>

Syntax:
SELECT [ALL|DISTINCT|field_list]
	[FROM table_name[,table_name2]]
	[WHERE ...]
	[GROUP BY ...]
	[ORDER BY ...]
where
	field_list	= {table_name | view_name | table_alias}.* | * |field[, field]
        	field	= column_name | column_name AS heading | heading=column_name | expression
        table_name	= simple_table_name | derived_table | joined_table
        	simple_table_name = [[database.]owner.]{table|view}[[AS]alias_name]
                derived_table	= (select_statement) [AS] alias_name
                joined_table	= {table1 CROSS JOIN table2 | table1 [join_type] JOIN table2 ON search_conditions}
                	join_type = {INNER | LEFT [OUTER] | RIGHT [OUTER] | FULL [OUTER]}

*)
procedure ParseTableFieldsFromSQL(const theSelect: string; const FieldList: TStrings; FldInfo, TblInfo: TStrings);
const
  Literals	= ['''', '"', '`'];
  ItemDelimiters= [','];
  NameDelimiters= [' ', ',', ';', ')', #$00, #$0A, #$0D];
  WordDelimiters= [' ', #$0A, #$0D];
  SepEq	        = '=';
  SepAS	        = 'AS';
  SepSpace	= ' ';
  SepAlias      = '.';
  AllColsSign   = '*';

  kwSelect 	= 1;
  kwAll		= 2;
  kwDistinct	= 3;
  kwFrom	= 4;
  KeyWords: array[1..9] of AnsiString = (
  		'SELECT', 'ALL', 'DISTINCT', 'FROM',
                'WHERE', 'ORDER', 'GROUP', 'HAVING', 'UNION');
  jwJoin	= 1;
  jwOn		= 2;
  JoinWords: array[1..7] of AnsiString = (
  		'JOIN', 'ON', 'LEFT', 'RIGHT',
                'INNER', 'OUTER', 'FULL');

  function IsKeyWord(const S: AnsiString): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i:=Low(KeyWords) to High(KeyWords) do
      if UpperCase(S) = UpperCase(KeyWords[i]) then begin
        Result := True;
        Break;
      end;
  end;

  function IsJoinWord(const S: AnsiString): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i:=Low(JoinWords) to High(JoinWords) do
      if AnsiUpperCase(S) = AnsiUpperCase(JoinWords[i]) then begin
        Result := True;
        Break;
      end;
  end;

  procedure SkipBlanks( Stmt: AnsiString; var i: Integer );
  begin
    while (i <= Length(Stmt)) and (Stmt[i] in NameDelimiters) do
      Inc(i);
  end;

  function StripLiterals(Str: AnsiString): AnsiString;
  var
    Len: Word;
  begin
    Result := Str;
    Len := Length(Str);
    if (Len > 0) and (Str[1] in Literals) then
      Result := Copy( Str, 2, Len-1 );
    Len := Length(Result);
    if (Len > 0) and (Result[Len] in Literals) then
      Result := Copy( Result, 1, Len-1 );
  end;

  function GetCurWord( Stmt: AnsiString; var i: Integer ): string;
  var
    StartPos: Integer;
    Quoted: Boolean;
  begin
    StartPos := i;
    Quoted := False;
        	// while not NameDelimiter
    while i <= Length(Stmt) do begin
      if not Quoted and (Stmt[i] in NameDelimiters) then
        Break;
      Quoted := Quoted xor (Stmt[i] in Literals);
      Inc(i);
    end;
    Result := Copy(Stmt, StartPos, i-StartPos);
       	// it's necessary to pass spaces before real delimiters (for example, ',')
    while (i <= Length(Stmt)) and (Stmt[i] in WordDelimiters) do
      Inc(i);
  end;
	// Cols.Strings[i] must be: Heading=[Alias.]ColumnName (as since Heading is unique in query)
  procedure ParseFieldItem( FieldItem: AnsiString; Cols: TStrings );
  var
    i, n: Integer;
    sHeading, sColName, sUniqueName: string;
  begin
    if (FieldItem = AllColsSign) or (AnsiPos(AllColsSign, FieldItem) > 0) then begin
      for i:=0 to FieldList.Count-1 do
        Cols.Values[FieldList[i]] := FieldList[i];
    end else begin
      i := 1;
      while (i <= Length(FieldItem)) and
      	    not(FieldItem[i] in NameDelimiters + [SepEq]) do
        Inc(i);
	// may be column name is first
      sColName := Copy( FieldItem, 1, i-1 );
      if i > Length(FieldItem) then
        sHeading := sColName
      else begin
        SkipBlanks( FieldItem, i );
        if FieldItem[i] = SepEq then begin		// Heading = ColumnName
          Inc(i);
          SkipBlanks( FieldItem, i );
          sHeading := sColName;
          sColName := GetCurWord( FieldItem, i );
        end else begin
          sHeading := GetCurWord( FieldItem, i );
          SkipBlanks( FieldItem, i );
          if UpperCase(sHeading) = SepAS then		// if   ColumnName AS Heading
            sHeading := GetCurWord( FieldItem, i );    	// else ColumnName Heading
        end;
      end;
	// if sHeading is equal sColName (for example T1.COL1), then sHeading must be equal COL1
      i := Length(sHeading);
      while (i > 0) and (sHeading[i] <> '.') do Dec(i);
      if i > 0 then
        sHeading := Copy(sHeading, i+1, Length(sHeading)-i);
      sHeading := StripLiterals(sHeading);
	// if the column heading(sHeading) exists in Cols list
      n := 0;
      sUniqueName := sHeading;
      while Cols.IndexOfName( sUniqueName ) >= 0 do begin
        Inc( n );
        sUniqueName := Format( '%s_%d', [sHeading, n] );
      end;
      	// if sHeading <> sUniqueName
      if n > 0 then
        sHeading := sUniqueName;

      Cols.Values[sHeading] := sColName;
    end;
  end;

  function ParseSelectList( Stmt: AnsiString; var i: Integer; Cols: TStrings ): string;
  var
    sWord, CurSentence: string;
  begin
    CurSentence := '';

    while i <= Length(Stmt) do begin
      SkipBlanks( Stmt, i );
      sWord := GetCurWord( Stmt, i );
      if Length(sWord) <= 0 then
        Break;
      if IsKeyWord(sWord) then begin
        if (UpperCase(sWord) <> KeyWords[kwAll]) and
           (UpperCase(sWord) <> KeyWords[kwDistinct])
        then
          Break;
      end else begin
        if (Length(CurSentence) > 0) and (sWord <> SepAlias) then
          CurSentence := CurSentence + ' ';
        CurSentence := CurSentence + sWord;
        if Stmt[i] in ItemDelimiters then begin
          ParseFieldItem( CurSentence, Cols );
          CurSentence := '';
        end;

      end;
    end;
    if Length(CurSentence) > 0 then
      ParseFieldItem( CurSentence, Cols );
    if Length(sWord) > 0 then
      Result := sWord;		// return the last passed word
  end;
	// stored in ATblList as the following: AliasName=TableName (as since AliasName is unique in query)
  procedure ParseTableItem(const AItem: AnsiString; ATblList: TStrings);
  var
    i: Integer;
    tbl, alias: AnsiString;
  begin
    i := 1;
    	// untill not blank or delimiter
    while (i <= Length(AItem)) and not(AItem[i] in NameDelimiters) do Inc(i);
    tbl := Copy(AItem, 1, i-1);

    SkipBlanks( AItem, i );
    if i > Length(AItem)
    then alias	:= tbl
    else alias := Copy(AItem, i, Length(AItem)-i+1);
    ATblList.Values[AnsiUpperCase(alias)] := tbl;
  end;

  function ParseFromClause( Stmt: AnsiString; var i: Integer; Tbls: TStrings ): string;
  var
    sWord, CurSentence: string;
    bJoinON: Boolean;
  begin
    CurSentence := '';
    bJoinON	:= False;

    while i <= Length(Stmt) do begin
      SkipBlanks( Stmt, i );
      sWord := GetCurWord( Stmt, i );
      if Length(sWord) <= 0 then
        Break;
      if IsKeyWord(sWord) then
        Break
      else begin
        if not IsJoinWord(sWord) then begin
          if Length(CurSentence) > 0 then
            CurSentence := CurSentence + ' ';
          CurSentence := CurSentence + sWord;
        end;

        if ( (i <= Length(Stmt)) and (Stmt[i] in ItemDelimiters) ) or IsJoinWord(sWord) then begin
          if Length(CurSentence) > 0 then
            if not bJoinON then
              ParseTableItem( CurSentence, Tbls );
          CurSentence := '';
        	// if search conditions(ON) in JOIN operator, then set flag
          bJoinON := IsJoinWord(sWord) and (UpperCase(sWord) = JoinWords[jwOn]);
        end;

      end;
    end;
    if Length(CurSentence) > 0 then
      if not bJoinON then
        ParseTableItem( CurSentence, Tbls );
    if Length(sWord) > 0 then
      Result := sWord;	// return the last passed word
  end;
	// Heading=[Alias.]ColumnName + Alias=TableName -> TableName.ColumnName
  procedure ProcessColumnInfo(AColList, ATblList, AColInfo: TStrings);
  var
    i, j, ColPos, SepPos: Integer;
    sColName, sAlias, sTblName: string;
  begin
    AColInfo.Clear;

    for i:=0 to FieldList.Count-1 do begin
      ColPos := AColList.IndexOfName(FieldList[i]);
      if ColPos < 0 then Continue;
    	// returns [Alias.]ColName from "Heading=[Alias.]ColumnName"
      sColName := AColList.Values[AColList.Names[ColPos]];
      j := Length(sColName);
      while (j > 0) and (sColName[j] <> SepAlias) do
        Dec(j);
      SepPos := j;
    	// if sColName = ColumnName (w/o Alias), else sColName = Alias.ColumnName
      if SepPos = 0 then begin
        if ATblList.Count > 0
        then sTblName := ATblList.Values[ ATblList.Names[0] ]
        else sTblName := '';
      end else begin
      	// extract Alias from "Alias.ColumnName"
        sAlias := Copy(sColName, 1, SepPos-1);
      	// extract ColName from "Alias.ColumnName"
        sColName:= Copy(sColName, SepPos+1, Length(sColName)-SepPos);

        j := ATblList.IndexOfName(sAlias);
    		// if alias founded
        if j >= 0 then
          sTblName := ATblList.Values[ ATblList.Names[j] ]
        else
          sTblName := sAlias;
      end;
    	// saves as FieldName=Table.Column
      AColInfo.Values[FieldList[i]] := Format('%s.%s', [sTblName, sColName]);
    end;
  end;

var
  CurPos: Integer;
  CurWord: string;
  ColList, TblList: TStrings;

begin
  ASSERT( Assigned(FieldList) and (FieldList.Count > 0) );

  FldInfo.Clear;
  TblInfo.Clear;

  ColList := TStringList.Create;
  TblList := TStringList.Create;

  try
    CurPos := 1;
    CurWord := '';

    while (CurPos <= Length(theSelect)) do begin
      CurWord := GetCurWord( theSelect, CurPos );
      if (Length(CurWord) <= 0) then begin
        Inc(CurPos);	// move to the following symbol, if the current one is a delimiter
        Continue;
      end;
      if UpperCase(CurWord) = KeyWords[kwSelect] then
	// stored in column info in string list as: Heading=[Alias.]ColumnName
        CurWord := ParseSelectList( theSelect, CurPos, ColList );
      if UpperCase(CurWord) = KeyWords[kwFrom] then
	// stored in table info in string list as: TableName=AliasName
        CurWord := ParseFromClause( theSelect, CurPos, TblList );
    end;

	// Fields[i].FieldName = Heading -> [Alias.]ColName -> TableName = TableName.ColName
    ProcessColumnInfo( ColList, TblList, FldInfo );

    TblInfo.Assign( TblList );
  finally
    ColList.Free;
    TblList.Free;
  end;
end;


{ ESDEngineError }
constructor ESDEngineError.Create(AErrorCode, ANativeError: LongInt; const Msg: string; AErrorPos: LongInt);
begin
  inherited Create(Msg);
  FErrorCode := AErrorCode;
  FNativeError := ANativeError;
  FErrorPos := AErrorPos;
end;

constructor ESDEngineError.CreateDefPos(AErrorCode, ANativeError: LongInt; const Msg: string);
begin
  inherited Create(Msg);
  FErrorCode := AErrorCode;
  FNativeError := ANativeError;
  FErrorPos := -1;
end;


{ TISqlDatabase }

constructor TISqlDatabase.Create(ADbParams: TStrings);
begin
  inherited Create;

  FAcquiredHandle		:= False;
  FCursorPreservedOnCommit	:= True;
  FCursorPreservedOnRollback	:= True;
  FTransSupported		:= True;
  FInTransaction		:= False;
  FProcSupportsCursor		:= False;
  FProcSupportsCursors		:= False;

  FDbParams := TStringList.Create;
  FDbParams.Assign(ADbParams);

	// by default AutoCommit = False
  FAutoCommitDef:= Trim( Params.Values[szAUTOCOMMIT] ) = '';
  FAutoCommit 	:= UpperCase( Trim( Params.Values[szAUTOCOMMIT] ) ) = STrueString;
	// by default IsEnableBCD = False
  FIsEnableBCD := UpperCase( Trim( Params.Values[szENABLEBCD] ) ) = STrueString;
	// by default IsRTrimChar = True
  FIsRTrimChar := not(UpperCase( Trim( Params.Values[szRTRIMCHAROUTPUT] ) ) = SFalseString);
	// by default IsSingleConn = False
  FIsSingleConn := UpperCase( Trim( Params.Values[szSINGLECONN] ) ) = STrueString;

  FMaxFieldNameLen	:= StrToIntDef( Trim( Params.Values[szMAXFIELDNAMELEN] ), XSCommon.MAXFIELDNAMELEN );
  FMaxStringSize	:= StrToIntDef( Trim( Params.Values[szMAXSTRINGSIZE] ), XSCommon.DEFMAXFIELDSTRINGSIZE );
  FBlobPieceSize	:= StrToIntDef( Trim( Params.Values[szBLOBPIECESIZE] ), XSCommon.DEF_BLOB_PIECE_SIZE );
  FPrefetchRows		:= StrToIntDef( Trim( Params.Values[szPREFETCHROWS] ), 1 );
end;

{ Do not call Disconnect here to avoid errors, when a shared handle was used by this object }
destructor TISqlDatabase.Destroy;
begin
  FDbParams.Free;

  inherited;
end;

procedure TISqlDatabase.Connect(const sDatabaseName, sUserName, sPassword: string);
begin
  try
    DoConnect(sDatabaseName, sUserName, sPassword);
  except
    DoDisconnect(False);	// to free all handles

    raise;
  end;
end;

procedure TISqlDatabase.Disconnect(Force: Boolean);
begin
  DoDisconnect(Force);
end;

{ set off autocommit when it's necessary: explicit transaction }
procedure TISqlDatabase.StartTransaction;
begin
  if AutoCommit then
    SetAutoCommitOption(False);

  DoStartTransaction;

  FInTransaction := True;
end;

{ set on autocommit when it's necessary: explicit transaction is finished }
procedure TISqlDatabase.Commit;
begin
  DoCommit;

  if AutoCommit then
    SetAutoCommitOption(True);

  FInTransaction := False;
end;

procedure TISqlDatabase.Rollback;
begin
  DoRollback;

  if AutoCommit then
    SetAutoCommitOption(True);

  FInTransaction := False;
end;

{ It's necessary to call after the each network trip/database API call, except an error processing.
It marks that a database connection still active }
procedure TISqlDatabase.ResetIdleTimeOut;
begin
  DoResetIdleTimeOut;
end;

procedure TISqlDatabase.ResetBusyState;
begin
  DoResetBusyState;
end;

procedure TISqlDatabase.DoResetIdleTimeOut;
begin
  if Assigned(FResetIdleTimeOut) then FResetIdleTimeOut(Self);
end;

procedure TISqlDatabase.DoResetBusyState;
begin
  if Assigned(FResetBusyState) then FResetBusyState(Self);
end;


{ There are dummy methods }

{ Returns SQL statement, which will return a result set with one field at least.
  The first field will be used to get autoincrement value. }
function TISqlDatabase.GetAutoIncSQL: string;
begin
  Result := ''; 	// by default
end;

function TISqlDatabase.GetHandle: TSDPtr;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.GetHandle']) );
  Result := nil;
end;

{ procedure must load API library, if it isn't loaded }
procedure TISqlDatabase.SetHandle(AHandle: TSDPtr);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.SetHandle']) );
end;

{ AObjectName can be an object name or a pattern for object names, it depends from ASchemaType.
Returned TISqlCommand has to be executed. Nil is returned in case of an error or unsupported query. }
function TISqlDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
begin
  Result := nil;
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.GetSchemaInfo']) );
end;

procedure TISqlDatabase.GetStoredProcNames(List: TStrings);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.GetStoredProcNames']) );
end;

{ It's used in TXSQLStoredProc.DescriptionsAvailable method and when TXSQLStoredProc.Params property is clicked in Object Inspector }
function TISqlDatabase.SPDescriptionsAvailable: Boolean;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.SPDescriptionsAvailable']) );
  Result := False;
end;

procedure TISqlDatabase.GetTableNames(Pattern: string; SystemTables: Boolean; List: TStrings);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.GetTableNames']) );
end;

{ It's used in UpdateSQL Editor }
procedure TISqlDatabase.GetFieldNames(const TableName: string; List: TStrings);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.GetTableFieldNames']) );
end;

function TISqlDatabase.ParamValue(Value: TXSQLDatabaseParam): Integer;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.ParamValue']) );
  Result := -1;
end;

{ Used to set on/off autocommit, when a transaction is activated/disactivated }
procedure TISqlDatabase.SetAutoCommitOption(Value: Boolean);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.SetAutoCommitOption']) );
end;

procedure TISqlDatabase.SetTransIsolation(Value: TISqlTransIsolation);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlDatabase.SetTransIsolation']) );
end;


{ TISqlCommand - interface between public components and native access.
 - has a reference to TISqlDatabase
 - performs processing of SQL statements (prepare, execute, fetch);
 - field values are returned by this object in Delphi(TField) format;
 - does not account for preserving  a result set after Commit/Rollback, which do high-level components like TSDDataSet
 }
constructor TISqlCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create;

  FCommandType	:= ctQuery;
  FSqlDatabase	:= ASqlDatabase;
  FParamsBuffer	:= nil;
  FFieldsBuffer := nil;
  FFieldBufOffs := nil;

  FFieldDescs	:= TSDFieldDescList.Create;
  FBufList      := TSDBufferList.Create;
  FParamsRef 	:= nil;

  FMaxCharParamSize := StrToIntDef( SqlDatabase.Params.Values[szMAXCHARPARAMLEN], DEFMAXCHARPARAMLEN );
end;

destructor TISqlCommand.Destroy;
begin
  Disconnect(True);

  if Assigned( FParamsBuffer ) then
    FreeParamsBuffer;
  if Assigned( FFieldsBuffer ) then
    FreeFieldsBuffer;

	// FieldsBuffer can depend from the current FieldDescs
  if Assigned( FFieldDescs ) then
    FFieldDescs.Free;
  if Assigned( FBufList ) then
    FBufList.Free;

  inherited;
end;

{ The corresponded dataset stores results of the command, the dataset has to call FetchAll or GetResults it's methods}
procedure TISqlCommand.SaveResults;
begin
  DoReleaseHandle(True);
end;

procedure TISqlCommand.DoReleaseHandle(SaveRes: Boolean);
begin
  if Assigned(FReleaseHandle) then FReleaseHandle(SaveRes);
end;

{ Size of parameter's buffer for binding }
function TISqlCommand.NativeParamSize(Param: TSDHelperParam): Integer;
begin
  with Param do
          // TParam.GetDataSize do not support ftGuid (raise an exception)
    if RequiredCnvtFieldType(DataType) {$IFDEF XSQL_VCL5} or (DataType = ftGuid){$ENDIF} then
      Result := NativeDataSize(DataType)
    else if IsBlobType(DataType) then
      Result := 0
    else begin
        // TParam.GetDataSize raises an exception for ftLargeInt parameter
      if DataType = ftLargeInt then
        Result := SizeOf(TInt64)
      else
        Result := GetDataSize;
        // TParam.GetDataSize for ftString returns actual size of the current value plus byte for null-terminator(D5+).
	// The below code is necessary for output and result parameters to return a string up MinStrParamSize size
      if CommandType = ctStoredProc then
        if (DataType in [ftBytes, ftVarBytes, ftString]) and (Result < (FMaxCharParamSize+1)) then
          Result := FMaxCharParamSize+1;		// with zero-terminator
    end;
end;

function TISqlCommand.GetParamsBufferSize: Integer;
var
  i, NumBytes: Integer;
begin
  Result := 0;
  if not Assigned(Params) then
    Exit;
  NumBytes := 0;
  for i := 0 to Params.Count - 1 do
    with Params[i] do begin
      if DataType = ftUnknown then
        DatabaseErrorFmt( SNoParameterDataType, [Name] );
      if ParamType = ptUnknown then
        DatabaseErrorFmt( SNoParameterType, [Name] );
      Inc(NumBytes, SizeOf(TSDFieldInfo) + NativeParamSize(Params[i]));
    end;
  Result := NumBytes;
end;

{ Disposes and Allocates memory for bind(parameters) buffer }
procedure TISqlCommand.AllocParamsBuffer;
var
  nSize: Integer;
begin
  if Assigned( FParamsBuffer ) then
    FreeParamsBuffer;

  nSize := GetParamsBufferSize;
  if nSize = 0 then
    Exit;
  	// allocate memory for bind(parameter) buffer
  FParamsBuffer := SafeReAllocMem(nil, nSize);
  SafeInitMem(FParamsBuffer, nSize, 0);
end;

procedure TISqlCommand.FreeParamsBuffer;
begin
  if Assigned( FParamsBuffer ) then
    FParamsBuffer := SafeReAllocMem(FParamsBuffer, 0);
end;

{ Calculates a size of select buffer, count of blobs and fills FFieldBufOffs. It's called in AllocFieldsBuffer. }
function TISqlCommand.GetFieldsBufferSize: Integer;
var
  i, BlobsCount: Integer;
begin
  Result := 0;
  BlobsCount := 0;
	// Allocate and fill up FFieldBufOffs array, which must contain FieldDescs.Count items(-1 omitted fields)
  SetLength( FFieldBufOffs, FieldDescs.Count );
  for i:=0 to FieldDescs.Count-1 do
    FFieldBufOffs[i] := -1;

  for i:=0 to FieldDescs.Count-1 do begin
    	// FieldNo property starts from 1
    FFieldBufOffs[FieldDescs[i].FieldNo-1] := Result;

    if IsBlobType( FieldDescs[i].FieldType ) then begin
      FieldDescs.FieldDescs[i].Offset := BlobsCount;	// set Offset value for a blob field
      Inc(BlobsCount);
    end else
      FieldDescs.FieldDescs[i].Offset := -1;

    Inc( Result , SizeOf(TSDFieldInfo) + FieldDescs[i].DataSize );
  end;

  Self.FBlobCacheOffs := Result;
  Inc( Result, Self.BlobFieldCount * SizeOf(Pointer) );
end;

{ Allocates memory for data, which selects from a database }
procedure TISqlCommand.AllocFieldsBuffer;
var
  nSize: Integer;
begin
  if Assigned( FFieldsBuffer ) then
    FreeFieldsBuffer;

  nSize := GetFieldsBufferSize;
  if nSize = 0 then
    Exit;
  	// allocate memory for select buffer
  FFieldsBuffer := SafeReAllocMem(nil, nSize);
  SafeInitMem(FFieldsBuffer, nSize, 0);
end;

function TISqlCommand.GetFieldsBuffer: TSDRecordBuffer;
begin
  Result := FFieldsBuffer;
end;

//  Gets a blob value from a select buffer FFieldsBuffer, which has an array of
// pointers at FBlobCacheOffs that point to the actual Blob cache buffers.
// AFieldDesc.Offset is the index into the array.
function TISqlCommand.GetBlobValue(AFieldDesc: TSDFieldDesc): TSDBlobData;
begin
  ASSERT( Assigned(FFieldsBuffer) );
  Result := GetFieldBlobData( FFieldsBuffer, FBlobCacheOffs, AFieldDesc.Offset );
end;

// Sets a blob value in a select buffer FFieldsBuffer
procedure TISqlCommand.PutBlobValue(AFieldDesc: TSDFieldDesc; sBlobValue: TSDBlobData);
begin
  ASSERT( Assigned(FFieldsBuffer) );
  SetFieldBlobData( FFieldsBuffer, FBlobCacheOffs, AFieldDesc.Offset, sBlobValue);
end;

{ Fetches and places data of blob fields to a select buffer }
procedure TISqlCommand.FetchBlobFields;
var
  i, BlobSize: Integer;
  sBlob: TSDBlobData;
begin
  for i:=0 to FieldDescs.Count-1 do
    if IsBlobType( FieldDescs[i].FieldType ) then begin
      try
        BlobSize := ReadBlob(FieldDescs[i], sBlob);
        if BlobSize > 0 then
          PutBlobValue(FieldDescs[i], sBlob)
        else
          PutBlobValue(FieldDescs[i], nil);
      finally
        SetLength(sBlob, 0);    // ASSERTION on D8: sBlob := nil;	// it's need in case of exceptions in ReadBlob call
      end;
    end;
end;

{ Frees the select buffer }
procedure TISqlCommand.FreeFieldsBuffer;
begin
  if Assigned( FFieldsBuffer ) then
    FFieldsBuffer := SafeReAllocMem(FFieldsBuffer, 0);

	// resets field's offsets in the record buffer
  if Assigned( FFieldBufOffs ) then begin
    SetLength( FFieldBufOffs, 0 );
    FFieldBufOffs := nil;
  end;
end;

function TISqlCommand.GetFieldBufOffs(Index: Integer): Integer;
begin
  Result := FFieldBufOffs[Index];
end;

function TISqlCommand.GetPrepared: Boolean;
begin
  Result := Trim( FNativeCommand ) <> '';
end;

function TISqlCommand.GetSqlDatabase: TISqlDatabase;
begin
  ASSERT( Assigned(FSqlDatabase) );

  Result := FSqlDatabase;
end;

procedure TISqlCommand.SetParamsRef(Value: TSDHelperParams);
begin
  if FParamsRef <> Value then
    FParamsRef := Value;
end;

function TISqlCommand.FieldDescByName(const AFieldName: string): TSDFieldDesc;
begin
  Result := FFieldDescs.FieldDescByName( AFieldName );
end;

{ ------------ It's dummy methods ------------------ }

{ It's equal to closing a cursor in other implementations.
It's required to call explicitly in case of an incomplete fetch of the result set (MSSQL & Sybase) or,
for example, in case of using a cursor parameter (Oracle) }
procedure TISqlCommand.CloseResultSet;
begin
end;

{ Places data in Buffer in Delphi format from FieldsBuffer (select buffer) for the specified field.
Returns TRUE if field data is NOT NULL. Buffer is allocated by the called procedure. }
function TISqlCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.GetCnvtFieldData']) );
  Result := False;
end;

function TISqlCommand.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.CnvtDateTime2DBDateTime']) );
  Result := 0;
end;

procedure TISqlCommand.Disconnect;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.Disconnect']) );
end;

function TISqlCommand.GetFieldBuffer(AFieldNo: Integer; SelBuf: TSDPtr): TSDPtr;
begin
  ASSERT( AFieldNo > 0 );				// Field.FieldNo starts from 1
  ASSERT( FFieldBufOffs <> nil );
  ASSERT( FFieldBufOffs[AFieldNo-1] >= 0 );		// offset must be 0 or more

  Result := TSDPtr(Integer(SelBuf) + FFieldBufOffs[AFieldNo-1]);
end;

function TISqlCommand.GetFieldAsInt32(AFieldNo: Word; var Value: LongInt): Boolean;
var
  fd: TSDFieldDesc;
{$IFDEF XSQL_CLR}
  p: TSDPtr;
{$ENDIF}
begin
  fd := FieldDescs.FieldDescByNumber(AFieldNo);
  ASSERT( SizeOf(Value) >= fd.DataSize );
  Value := 0;
{$IFDEF XSQL_CLR}
  p := SafeReallocMem(nil, SizeOf(Value));
  try
    Result := GetCnvtFieldData(fd, p, SizeOf(Value));
    Value := Marshal.ReadInt32(p);
  finally
    SafeReallocMem(p, 0);
  end;
{$ELSE}
  Result := GetCnvtFieldData(fd, @Value, SizeOf(Value));
{$ENDIF}
end;

function TISqlCommand.GetFieldAsInt16(AFieldNo: Word; var Value: SmallInt): Boolean;
var
  fd: TSDFieldDesc;
{$IFDEF XSQL_CLR}
  p: TSDPtr;
{$ENDIF}
begin
  fd := FieldDescs.FieldDescByNumber(AFieldNo);
  ASSERT( SizeOf(Value) >= fd.DataSize );
  Value := 0;
{$IFDEF XSQL_CLR}
  p := SafeReallocMem(nil, SizeOf(Value));
  try
    Result := GetCnvtFieldData(fd, p, SizeOf(Value));
    Value := Marshal.ReadInt16(p);
  finally
    SafeReallocMem(p, 0);
  end;
{$ELSE}
  Result := GetCnvtFieldData(fd, @Value, SizeOf(Value));
{$ENDIF}
end;

function TISqlCommand.GetFieldAsFloat(AFieldNo: Word; var Value: Double): Boolean;
var
  fd: TSDFieldDesc;
{$IFDEF XSQL_CLR}
  p: TSDPtr;
{$ENDIF}
begin
  fd := FieldDescs.FieldDescByNumber(AFieldNo);
  ASSERT( SizeOf(Value) >= fd.DataSize );
  Value := 0;
{$IFDEF XSQL_CLR}
  p := SafeReallocMem(nil, SizeOf(Value));
  try
    Result := GetCnvtFieldData(fd, p, SizeOf(Value));
    Value := Marshal.ReadInt64(p);
  finally
    SafeReallocMem(p, 0);
  end;
{$ELSE}
  Result := GetCnvtFieldData(fd, @Value, SizeOf(Value));
{$ENDIF}
end;

{$IFDEF XSQL_VCL4}
function TISqlCommand.GetFieldAsInt64(AFieldNo: Word; var Value: TInt64): Boolean;
var
  fd: TSDFieldDesc;
{$IFDEF XSQL_CLR}
  p: TSDPtr;
{$ENDIF}
begin
  fd := FieldDescs.FieldDescByNumber(AFieldNo);
  ASSERT( SizeOf(Value) >= fd.DataSize );
  Value := 0;
{$IFDEF XSQL_CLR}
  p := SafeReallocMem(nil, SizeOf(Value));
  try
    Result := GetCnvtFieldData(fd, p, SizeOf(Value));
    Value := Marshal.ReadInt64(p);
  finally
    SafeReallocMem(p, 0);
  end;
{$ELSE}
  Result := GetCnvtFieldData(fd, @Value, SizeOf(Value));
{$ENDIF}
end;
{$ENDIF}

function TISqlCommand.GetFieldAsString(AFieldNo: Word; var Value: string): Boolean;
var
  fd: TSDFieldDesc;
  i: Integer;
  b: TSDBlobData;
{$IFDEF XSQL_CLR}
  p: TSDPtr;
{$ENDIF}
begin
  b := nil;
  fd := FieldDescs.FieldDescByNumber(AFieldNo);
  if IsBlobType(fd.FieldType) then begin
    b := GetBlobValue(fd);
    SetLength(Value, Length(b));
    for i := 0 to Length(b) do
      Value[i+1] := Char( b[i] );
    Result := Length(Value) > 0;
    Exit;
  end;
{$IFDEF XSQL_CLR}
  p := SafeReallocMem(nil, fd.DataSize);
  SafeInitMem(p, fd.DataSize, 0);
  try
    Result := GetCnvtFieldData(fd, p, fd.DataSize);
    Value := Marshal.PtrToStringAnsi(p);
  finally
    SafeReallocMem(p, 0);
  end;
{$ELSE}
  SetLength(Value, fd.DataSize);
        // FillChar is replaced (it is not supported by Delphi 8). At general, GetCnvtFieldData has to set a null terminator.
  for i:=1 to fd.DataSize do
    Value[i] := #00;
  Result := GetCnvtFieldData(fd, TSDPtr(PChar(Value)), fd.DataSize);      // fd.DataSize has to include a space for null-terminator
{$ENDIF}
        // set actual length for the string Value
  i := 0;
  while ((i+1) <= Length(Value)) and (Value[i+1] <> #00) do
    Inc(i);
  SetLength(Value, i);
end;

{ Returns False, if field is null
function TISqlCommand.GetFieldString(AFieldNo: Word; Value: Pointer): Boolean;
begin
  Result := GetCnvtFieldData(FieldDescs.FieldDescByNumber(AFieldNo), Value);
end;
}

procedure TISqlCommand.ParseFieldNames(const theSelect: string; FldInfo: TStrings);
var
  FldList, TblInfo: TStrings;
  i: Integer;
begin
  TblInfo := TStringList.Create;
  FldList := TStringList.Create;
  try
    for i:=0 to FieldDescs.Count-1 do
      FldList.Add(FieldDescs[i].FieldName);
    ParseTableFieldsFromSQL( theSelect, FldList, FldInfo, TblInfo );
  finally
    TblInfo.Free;
    FldList.Free;
  end;
end;

{ Initialize FieldDescs structure. It has to be called after Prepare or Execute phase (in DoPrepare or DoExecute),
which depends from a descendent of TISqlCommand, or directly from InternalInitFieldDefs(OpenCursor(True)) }
procedure TISqlCommand.InitFieldDescs;
var
  Descs: TSDFieldDescList;
  i: Integer;
begin
  Descs := TSDFieldDescList.Create;
  try
    GetFieldDescs( Descs );
	// exclude empty and duplicate names
    Descs.ArrangeFieldNames;
	// calculate and assign FieldNo and Offset values
    FBlobFieldCount := 0;
    for i:=0 to Descs.Count-1 do begin
      Descs.FieldDescs[i].FieldNo := i+1;
      if IsBlobType( Descs[i].FieldType ) then begin
        Descs.FieldDescs[i].Offset := FBlobFieldCount;
        Inc( FBlobFieldCount );
      end;
    end;
  finally
  	// it's need here to exclude a memory leak when GetFieldDescs( Descs ) raises an exception
    ClearFieldDescs;
    FFieldDescs.Free;
    FFieldDescs := Descs;
  end;
end;

procedure TISqlCommand.ClearFieldDescs;
begin
	// dispose a select buffer, which appropriated the current FieldDescs
  if FieldDescs.Count > 0 then
    FreeFieldsBuffer;

  FieldDescs.Clear;
end;

procedure TISqlCommand.GetFieldDescs(Descs: TSDFieldDescList);
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.GetFieldDescs']) );
end;

function TISqlCommand.FetchNextRow: Boolean;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.FetchNextRow']) );
  Result := False;
end;

function TISqlCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.FieldDataType']) );
  Result := ftUnknown;
end;

{ Can returns 0 for a datatype with variable size, for example, string or blob }
function TISqlCommand.NativeDataSize(FieldType: TFieldType): Word;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.NativeDataSize']) );
  Result := 0;
end;

function TISqlCommand.NativeDataType(FieldType: TFieldType): Integer;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.NativeDataType']) );
  Result := 0;
end;

{ Returns True if field type requires converting from internal database format }
function TISqlCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.RequiredCnvtFieldType']) );
  Result := False;
end;

function TISqlCommand.GetHandle: PSDCursor;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.GetHandle']) );
  Result := nil;
end;

function TISqlCommand.ResultSetExists: Boolean;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.ResultSetExists']) );
  Result := False;
end;

procedure TISqlCommand.SetFieldsBuffer;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.SetFieldsBuffer']) );
end;

function TISqlCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.ReadBlob']) );
  Result := 0;
end;

function TISqlCommand.WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.WriteBlob']) );
  Result := 0;
end;

function TISqlCommand.WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.WriteBlobByName']) );
  Result := 0;
end;

{ Saves a statement, which was sent to the server really }
procedure TISqlCommand.SetNativeCommand(Value: string);
begin
  if Value <> FNativeCommand then
    FNativeCommand := Value;
end;

{ When CommandText is changed, NativeCommand is reset, i.e. the command has to be prepared }
procedure TISqlCommand.SetCommandText(Value: string);
begin
  if Value <> FCommandText then begin
    FCommandText := Value;
    FNativeCommand := '';
  end;
end;

procedure TISqlCommand.BindParamsBuffer;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.BindParamsBuffer']) );
end;

{		 Query methods			}

{ The method returns:
 -1, when it is impossible to get autoincrement value at command level. The separate SQL statement could be used in this case.
 0, when the statement does not generate autoincrement value or the table does not contain an autoincrement column;
 >0, an autoincrement value is returned
 Result is integer, because TAutoIncField stores integer value
}
function TISqlCommand.GetAutoIncValue: Integer;
begin
  Result := -1;
end;

function TISqlCommand.GetRowsAffected: Integer;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.GetRowsAffected']) );
  Result := -1;
end;

{ It is similar to unprepare. }
procedure TISqlCommand.InitNewCommand;
begin
  FNativeCommand := '';
end;

{ Prepare does the following:
 - disposes a field(select) buffer, after that it's possible to define
 the first execute call from the following one.
 - prepares a SQL command
 - NativeCommand has to be set to the actual prepared command (in DoPrepare, if prepare phase is supported), i.e. NativeCommand <> '' is equal Prepared state.
 - DoPrepare calls InitFieldDescs if it's supported after prepare

The method is called when TSDDataSet descendent is prepared. If TSDDataSet descendent is unprepared,
 TISqlCommand is disconnected (not destroyed).
 }
procedure TISqlCommand.Prepare(ACommandValue: string);
begin
  if Prepared then
    Exit;

  if Assigned(FieldsBuffer) then
    FreeFieldsBuffer;

  SetCommandText(ACommandValue);

  DoPrepare( ACommandValue );
end;

// ExecDirect could be used in Open or ExecSQL, when Prepare call was passed (dbfPrepared is absent ???)
procedure TISqlCommand.ExecDirect(ACommandValue: string);
begin
  if Assigned(FieldsBuffer) then
    FreeFieldsBuffer;

  SetCommandText(ACommandValue);
        // DoExecDirect has to call AllocParamsBuffer, BindParamsBuffer and InitFieldDescs itself,
        // because before Handle could be undefined
  DoExecDirect(ACommandValue);
      // here field definition has to be known in any case
  if (FieldDescs.Count > 0) and not Assigned( FieldsBuffer ) then begin
    AllocFieldsBuffer;
    SetFieldsBuffer;
  end;
end;

{ Execute does the following:
 - disposes the previous allocated parameter (bind) buffer;
 - allocates and sets parameter (bind) buffer (parameter's values can be modified between Prepare and Execute);
 - allocate and sets (if it was not allocated and set in the previous Execute call) field (select) buffer;
 - executes a SQL statement.

 In case of repeated call (Prepare, Execute, Execute) it isn't necessary to allocate and set select buffer
 }
procedure TISqlCommand.Execute;
begin
        // Alloc/BindParamsBuffer could be called earlier for some servers. NOTE, Alloc... will free old bind buffer in this case. 
  AllocParamsBuffer;
  BindParamsBuffer;

  if (FieldDescs.Count > 0) and not Assigned( FFieldsBuffer ) then begin
    AllocFieldsBuffer;
    SetFieldsBuffer;
  end;

  DoExecute;
end;

	// StoredProc methods

procedure TISqlCommand.AddParam(AParamName: string; ADataType: TFieldType; AParamType: TSDHelperParamType);
begin
{$IFDEF XSQL_VCL4}
  with TParam(Params.Add) do begin
    ParamType := AParamType;
    DataType := ADataType;
    Name := AParamName;
  end;
{$ELSE}
  Params.CreateParam( ADataType, AParamName, AParamType);
{$ENDIF}
end;

{ Gets parameter descriptions of a stored procedure and fills Params property }
procedure TISqlCommand.InitParamList;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.InitParamList']) );
end;

procedure TISqlCommand.GetOutputParams;
begin
  ASSERT( False, Format(SFuncNotImplemented, ['TISqlCommand.GetOutputParams']) );
end;

function TISqlCommand.NextResultSet: Boolean;
begin
  Result := False;
end;


{ TSDFieldDescList }
destructor TSDFieldDescList.Destroy;
begin
  Clear;

  inherited;
end;

procedure TSDFieldDescList.Clear;
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    FieldDescs[i].Free;

  inherited Clear;
end;

function TSDFieldDescList.AddFieldDesc: TSDFieldDesc;
begin
  Result := TSDFieldDesc.Create;
  Add(Result);
end;

{ Excludes empty and duplicate names }
procedure TSDFieldDescList.ArrangeFieldNames;
var
  i, j, nDuplicates: Integer;
  sName, sFieldName: string;
begin
  for i:=0 to Count-1 do begin
    sFieldName := FieldDescs[i].FieldName;
    	// if a field name is empty
    if Length(sFieldName) = 0 then
      sFieldName := Format('COLUMN%d', [i+1]);

    nDuplicates := 0;
    sName := sFieldName;
    	// check from the current item to the first one
    j := i-1;
    while j >= 0 do begin
    	// check the previous field names
      if CompareText(sName, FieldDescs[j].FieldName) = 0 then begin
        Inc( nDuplicates );
        sName := Format( '%s_%d', [sFieldName, nDuplicates] );
        j := i-1;	// start again
      end else
        Dec(j);
    end;
  	// in case of duplicated or changed field name, store the changed name in FieldDesc structure
    if CompareText(FieldDescs[i].FieldName, sName) <> 0 then
      FieldDescs[i].FieldName := sName;
  end;
end;

function TSDFieldDescList.GetFieldDescs(Index: Integer): TSDFieldDesc;
begin
  ASSERT( Index < Count );
  ASSERT( Items[Index] <> nil );

  Result := TSDFieldDesc( Items[Index] );
end;

{
function TSDFieldDescList.GetPFieldDescs(Index: Integer): PSDFieldDesc;
begin
  ASSERT( Index < Count );

  Result := PSDFieldDesc( Items[Index] );
end;
}

function TSDFieldDescList.FieldDescByName(const AFieldName: string): TSDFieldDesc;
var
  i: Integer;
begin
  Result := nil;
  i := 0;
  while i < Count do begin
    if UpperCase(FieldDescs[i].FieldName) = UpperCase( AFieldName ) then begin
      Result := FieldDescs[i];
      Exit;
    end;
    Inc(i);
  end;

  DatabaseErrorFmt( SFieldDescNotFound, [AFieldName] );
end;

function TSDFieldDescList.FieldDescByNumber(AFieldNo: Integer): TSDFieldDesc;
var
  i: Integer;
begin
  Result := nil;
  if (AFieldNo > 0) and (AFieldNo <= Count) and
     (FieldDescs[AFieldNo-1].FieldNo = AFieldNo)
  then begin
    Result := FieldDescs[AFieldNo-1];
    Exit;
  end;
	// in case of exception: this code is nonexecutable usually
  for i:=0 to Count-1 do
    if FieldDescs[i].FieldNo = AFieldNo then begin
      Result := FieldDescs[i];
      Break;
    end else if i = (Count-1) then
      DatabaseErrorFmt( SFieldDescNotFound, ['FieldNo='+IntToStr(AFieldNo)] );
end;


{$IFNDEF XSQL_VCL4}

{*******************************************************************************
					TSDParam
*******************************************************************************}
constructor TSDParam.Create(AParamList: TSDParams; AParamType: TSDParamType);
begin
  if AParamList <> nil then AParamList.AddParam(Self);
  FName := '';
  DataType := ftUnknown;
  FParamType := AParamType;
  FBound := False;
  FNull := True;
end;

destructor TSDParam.Destroy;
begin
  if FParamList <> nil then FParamList.RemoveParam(Self);
end;

function TSDParam.IsEqual(Value: TSDParam): Boolean;
begin
  Result :=
  	(VarType(FData) = VarType(Value.FData)) and
    	(FData = Value.FData) and (Name = Value.Name) and
    	(DataType = Value.DataType) and (IsNull = Value.IsNull) and
    	(Bound = Value.Bound) and (ParamType = Value.ParamType);
end;

procedure TSDParam.SetDataType(Value: TFieldType);
begin
  FData := 0;
  FDataType := Value;
end;

procedure TSDParam.SetParamName(const Value: string);
begin
  FName := Value;
end;

function TSDParam.GetParamName: string;
begin
  Result := FName;
end;

function TSDParam.GetDataSize: Integer;
begin
  case DataType of
    ftString,
    ftMemo:     Result := Length(AsString) + 1;		// in Delphi 3: VarToStr(FData) returns '0'(and Length(FData)=1) in case of empty string
    ftBoolean: 	Result := SizeOf(WordBool);
    ftBCD,
    ftDateTime,
    ftCurrency,
    ftFloat: 	Result := SizeOf(Double);
    ftTime,
    ftDate,
    ftInteger: 	Result := SizeOf(LongInt);
    ftSmallint: Result := SizeOf(Integer);
    ftWord: 	Result := SizeOf(Word);
    ftBlob,
    ftGraphic..ftDBaseOLE: Result := Length(FData);
  else
    if DataType = ftUnknown
    then DatabaseErrorFmt(SUnknownFieldType, [Name])
    else DatabaseErrorFmt(SBadFieldType, [Name]);
    Result := 0;
  end;
end;

procedure TSDParam.GetData(Buffer: Pointer);
begin
  case DataType of
    ftUnknown: 	DatabaseErrorFmt(SUnknownFieldType, [FName]);
    ftString,
    ftMemo: 	StrMove(Buffer, PChar(string(FData)), Length(FData) + 1);
    ftSmallint: Integer(Buffer^) := FData;
    ftWord: 	Word(Buffer^) := FData;
    ftInteger: 	LongInt(Buffer^) := FData;
	{ DateTime fields stored in Buffer as TDateTimeRec }
    ftTime: 	Integer(Buffer^) := DateTimeToTimeStamp(AsDateTime).Time;
    ftDate: 	Integer(Buffer^) := DateTimeToTimeStamp(AsDateTime).Date;
    ftDateTime: Double(Buffer^)  := TimeStampToMSecs(DateTimeToTimeStamp(AsDateTime));
    ftBCD,
    ftCurrency,
    ftFloat: 	Double(Buffer^) := FData;
    ftBoolean: 	WordBool(Buffer^) := FData;
    ftBlob,
    ftGraphic..ftTypedBinary: Move(PChar(string(FData))^, Buffer^, Length(FData));
  else
    DatabaseError( Format(SBadFieldType, [FName]) );
  end;
end;

procedure TSDParam.SetBlobData(Buffer: Pointer; Size: Integer);
var
  DataStr: string;
begin
  SetLength(DataStr, Size);
  Move(Buffer^, PChar(DataStr)^, Size);
  AsBlob := DataStr;
end;

procedure TSDParam.SetData(Buffer: Pointer);
var
  TimeStamp: TTimeStamp;
begin
  case DataType of
    ftUnknown:	DatabaseError( Format(SUnknownFieldType, [FName]) );
    ftString:	AsString := StrPas(Buffer);
    ftWord:	AsWord := Integer(Buffer^);
    ftSmallint:	AsSmallInt := Integer(Buffer^);
    ftInteger: 	AsInteger := Integer(Buffer^);
	{ DateTime fields received from Buffer as TDateTimeRec }
    ftTime:
      begin
        TimeStamp.Time := LongInt(Buffer^);
        TimeStamp.Date := DateDelta;
        AsTime := TimeStampToDateTime(TimeStamp);
      end;
    ftDate:
      begin
        TimeStamp.Time := 0;
        TimeStamp.Date := Integer(Buffer^);
        AsDate := TimeStampToDateTime(TimeStamp);
      end;
    ftDateTime:
      begin
        TimeStamp.Time := 0;
        TimeStamp.Date := Integer(Buffer^);
        AsDateTime := TimeStampToDateTime(MSecsToTimeStamp(Double(Buffer^)));
      end;
    ftBCD: 	AsBCD := Double(Buffer^);
    ftCurrency: AsCurrency := Double(Buffer^);
    ftFloat: 	AsFloat := Double(Buffer^);
    ftBoolean: 	AsBoolean := WordBool(Buffer^);
  else
    DatabaseError( Format(SBadFieldType, [FName]) );
  end;
end;

procedure TSDParam.SetText(const Value: string);
begin
  InitValue;
  if DataType = ftUnknown then DataType := ftString;
  FData := Value;
  case DataType of
    ftDateTime, ftTime, ftDate: FData := VarToDateTime(FData);
    ftBCD: FData := Currency(FData);
    ftCurrency, ftFloat: FData := Single(FData);
    ftInteger, ftSmallInt, ftWord: FData := Integer(FData);
    ftBoolean: FData := Boolean(FData);
  end;
end;

procedure TSDParam.Assign(Source: TPersistent);
begin
  if Source is TSDParam then
    AssignParam(TSDParam(Source))
  else if Source is TField then
    AssignField(TField(Source))
  else
    inherited Assign(Source);
end;

procedure TSDParam.AssignTo(Dest: TPersistent);
begin
  if Dest is TField then
    TField(Dest).Value := FData
  else
    inherited AssignTo(Dest);
end;

procedure TSDParam.AssignParam(Param: TSDParam);
begin
  if Param <> nil then begin
    DataType := Param.DataType;
    if Param.IsNull then Clear
    else begin
      InitValue;
      FData := Param.FData;
    end;
    FBound := Param.Bound;
    Name := Param.Name;
    if ParamType = ptUnknown then FParamType := Param.ParamType;
  end;
end;

procedure TSDParam.AssignField(Field: TField);
begin
  if Field <> nil then begin
    if (Field.DataType = ftMemo) and (Field.Size > 255)
    then DataType := ftString
    else DataType := Field.DataType;
    if Field.IsNull then Clear
    else begin
      InitValue;
      FData := Field.Value;
    end;
    FBound := True;
    Name := Field.FieldName;
  end;
end;

procedure TSDParam.AssignFieldValue(Field: TField; const Value: Variant);
begin
  if Field <> nil then begin
    if (Field.DataType = ftMemo) and (Field.Size > 255)
    then DataType := ftString
    else DataType := Field.DataType;
    if VarIsNull(Value) then Clear
    else begin
      InitValue;
      FData := Value;
    end;
    FBound := True;
  end;
end;

procedure TSDParam.Clear;
begin
  FNull := True;
  FData := 0;
end;

procedure TSDParam.InitValue;
begin
  FBound := True;
  FNull := False;
end;

procedure TSDParam.LoadFromFile(const FileName: string; BlobType: TBlobType);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream, BlobType);
  finally
    Stream.Free;
  end;
end;

procedure TSDParam.LoadFromStream(Stream: TStream; BlobType: TBlobType);
var
  DataStr: string;
  Len: Integer;
begin
  with Stream do begin
    InitValue;
    FDataType := BlobType;
    Len := Size;
    SetLength(DataStr, Len);
    ReadBuffer(Pointer(DataStr)^, Len);
    FData := DataStr;
  end;
end;

function TSDParam.GetAsBoolean: Boolean;
begin
  Result := FData;
end;

procedure TSDParam.SetAsBoolean(Value: Boolean);
begin
  InitValue;
  DataType := ftBoolean;
  FData := Value;
end;

function TSDParam.GetAsFloat: Double;
begin
  Result := FData;
end;

procedure TSDParam.SetAsFloat(Value: Double);
begin
  InitValue;
  DataType := ftFloat;
  FData := Value;
end;

function TSDParam.GetAsBCD: Currency;
begin
  Result := FData;
end;

procedure TSDParam.SetAsBCD(Value: Currency);
begin
  InitValue;
  FData := Value;
  FDataType := ftBCD;
end;

procedure TSDParam.SetAsCurrency(Value: Double);
begin
  SetAsFloat(Value);
  FDataType := ftCurrency;
end;

function TSDParam.GetAsInteger: Longint;
begin
  Result := FData;
end;

procedure TSDParam.SetAsInteger(Value: Longint);
begin
  InitValue;
  DataType := ftInteger;
  FData := Value;
end;

procedure TSDParam.SetAsWord(Value: LongInt);
begin
  SetAsInteger(Value);
  FDataType := ftWord;
end;

procedure TSDParam.SetAsSmallInt(Value: LongInt);
begin
  SetAsInteger(Value);
  FDataType := ftSmallint;
end;

function TSDParam.GetAsString: string;
begin
  if not IsNull then
    case DataType of
      ftBoolean:
        if FData then Result := STextTrue
        else Result := STextFalse;
      ftDateTime,
      ftDate,
      ftTime:	Result := VarFromDateTime(FData)
    else
      Result := FData;
    end
  else
    Result := ''
end;

procedure TSDParam.SetAsString(const Value: string);
begin
  InitValue;
  DataType := ftString;
  FData := Value;
end;

function TSDParam.GetAsMemo: string;
begin
  Result := FData;
end;

procedure TSDParam.SetAsMemo(const Value: string);
begin
  InitValue;
  DataType := ftMemo;
  FData := Value;
end;

procedure TSDParam.SetAsBlob(Value: TBlobData);
begin
  InitValue;
  DataType := ftBlob;
  FData := Value;
end;

procedure TSDParam.SetAsDate(Value: TDateTime);
begin
  InitValue;
  DataType := ftDate;
  FData := Value;
end;

procedure TSDParam.SetAsTime(Value: TDateTime);
begin
  InitValue;
  FDataType := ftTime;
  FData := Value;
end;

procedure TSDParam.SetAsDateTime(Value: TDateTime);
begin
  InitValue;
  FDataType := ftDateTime;
  FData := Value;
end;

function TSDParam.GetAsDateTime: TDateTime;
begin
  if IsNull
  then Result := 0
  else Result := VarToDateTime(FData);
end;

procedure TSDParam.SetAsVariant(Value: Variant);
begin
  InitValue;
  case VarType(Value) of
    varSmallint:DataType := ftSmallInt;
    varInteger:	DataType := ftInteger;
    varCurrency:DataType := ftBCD;
    varSingle,
    varDouble: 	DataType := ftFloat;
    varDate: 	DataType := ftDateTime;
    varBoolean:	DataType := ftBoolean;
    varString:	DataType := ftString;
  else
    DataType := ftUnknown;
  end;
  FData := Value;
end;

function TSDParam.GetAsVariant: Variant;
begin
  Result := FData;
end;


{*******************************************************************************
					TSDParams
*******************************************************************************}
constructor TSDParams.Create;
begin
  FItems := TList.Create;
end;

destructor TSDParams.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

procedure TSDParams.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TSDParams then begin
    Clear;
    for I := 0 to TSDParams(Source).Count - 1 do
      with TSDParam.Create(Self, ptUnknown) do
        AssignParam(TSDParams(Source)[I]);
  end else
    inherited Assign(Source);
end;

procedure TSDParams.AssignTo(Dest: TPersistent);
begin
  if Dest is TSDParams
  then TSDParams(Dest).Assign(Self)
  else inherited AssignTo(Dest);
end;

procedure TSDParams.AssignValues(Value: TSDParams);
var
  I, J: Integer;
begin
  for I := 0 to Count - 1 do
    for J := 0 to Value.Count - 1 do
      if Items[I].Name = Value[J].Name then begin
        Items[I].AssignParam(Value[J]);
        Break;
      end;
end;

procedure TSDParams.AddParam(Value: TSDParam);
begin
  FItems.Add(Value);
  Value.FParamList := Self;
end;

procedure TSDParams.RemoveParam(Value: TSDParam);
begin
  FItems.Remove(Value);
  Value.FParamList := nil;
end;

function TSDParams.CreateParam(FldType: TFieldType; const ParamName: string; ParamType: TSDParamType): TSDParam;
begin
  Result := TSDParam.Create(Self, ParamType);
  with Result do begin
    Name := ParamName;
    DataType :=  FldType;
  end;
end;

function TSDParams.Count: Integer;
begin
  Result := FItems.Count;
end;

procedure TSDParams.Clear;
begin
  while FItems.Count > 0 do TSDParam(FItems.Last).Free;
end;

function TSDParams.IsEqual(Value: TSDParams): Boolean;
var
  I: Integer;
begin
  Result := Count = Value.Count;
  if Result then
    for I := 0 to Count - 1 do begin
      Result := Items[I].IsEqual(Value.Items[I]);
      if not Result then Break;
    end
end;

function TSDParams.GetParam(Index: Word): TSDParam;
begin
  Result := ParamByName(TSDParam(FItems[Index]).Name);
end;

function TSDParams.ParamByName(const Value: string): TSDParam;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FItems.Count - 1 do begin
    Result := FItems[I];
    if AnsiCompareText(Result.Name, Value) = 0 then Exit;
  end;
  DatabaseError( Format(SParameterNotFound, [Value]) );
end;

procedure TSDParams.DefineProperties(Filer: TFiler);

  function WriteData: Boolean;
  begin
    if Filer.Ancestor <> nil
    then Result := not IsEqual(TSDParams(Filer.Ancestor))
    else Result := Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadBinaryData, WriteBinaryData, WriteData);
end;

procedure TSDParams.ReadBinaryData(Stream: TStream);
var
  I, Temp, NumItems: Integer;
  Buffer: array[0..2047] of Char;
  TempStr: string;
  Version: Word;
begin
  Clear;
  with Stream do begin
    ReadBuffer(Version, SizeOf(Version));
    if Version > 2 then DatabaseError(SInvalidVersion);
    NumItems := 0;
    if Version = 2
    then ReadBuffer(NumItems, SizeOf(NumItems))
    else ReadBuffer(NumItems, 2);
    for I := 0 to NumItems - 1 do
      with TSDParam.Create(Self, ptUnknown) do begin
        Temp := 0;
        if Version = 2
        then ReadBuffer(Temp, SizeOf(Temp))
        else ReadBuffer(Temp, 1);
        SetLength(TempStr, Temp);
        ReadBuffer(PChar(TempStr)^, Temp);
        Name := TempStr;
        ReadBuffer(FParamType, SizeOf(FParamType));
        ReadBuffer(FDataType, SizeOf(FDataType));
        if DataType <> ftUnknown then begin
          Temp := 0;
          if Version = 2
          then ReadBuffer(Temp, SizeOf(Temp))
          else ReadBuffer(Temp, 2);
          ReadBuffer(Buffer, Temp);
          if DataType in [ftBlob, ftGraphic..ftDBaseOLE]
          then SetBlobData(@Buffer, Temp)
          else SetData(@Buffer);
        end;
        ReadBuffer(FNull, SizeOf(FNull));
        ReadBuffer(FBound, SizeOf(FBound));
      end;
  end;
end;

procedure TSDParams.WriteBinaryData(Stream: TStream);
var
  I: Integer;
  Temp: SmallInt;
  Buffer: array[0..2047] of Char;
  Version: Word;
begin
  with Stream do begin
    Version := GetVersion;
    WriteBuffer(Version, SizeOf(Version));
    Temp := Count;
    WriteBuffer(Temp, SizeOf(Temp));
    for I := 0 to Count - 1 do
      with Items[I] do begin
        Temp := Length(FName);
        WriteBuffer(Temp, 1);
        WriteBuffer(PChar(FName)^, Length(FName));
        WriteBuffer(FParamType, SizeOf(FParamType));
        WriteBuffer(FDataType, SizeOf(FDataType));
        if (DataType <> ftUnknown) then begin
          if GetDataSize > SizeOf(Buffer) then
            DatabaseErrorFmt(SParamTooBig, [Name, SizeOf(Buffer)]);
          Temp := GetDataSize;
          GetData(@Buffer);
          WriteBuffer(Temp, SizeOf(Temp));
          WriteBuffer(Buffer, Temp);
        end;
        WriteBuffer(FNull, SizeOf(FNull));
        WriteBuffer(FBound, SizeOf(FBound));
      end;
  end;
end;

function TSDParams.GetVersion: Word;
begin
  Result := 1;
end;

function TSDParams.GetParamValue(const ParamName: string): Variant;
var
  I: Integer;
  Params: TList;
begin
  if Pos(';', ParamName) <> 0 then begin
    Params := TList.Create;
    try
      GetParamList(Params, ParamName);
      Result := VarArrayCreate([0, Params.Count - 1], varVariant);
      for I := 0 to Params.Count - 1 do
        Result[I] := TSDParam(Params[I]).Value;
    finally
      Params.Free;
    end;
  end else
    Result := ParamByName(ParamName).Value
end;

procedure TSDParams.SetParamValue(const ParamName: string; const Value: Variant);
var
  I: Integer;
  Params: TList;
begin
  if Pos(';', ParamName) <> 0 then begin
    Params := TList.Create;
    try
      GetParamList(Params, ParamName);
      for I := 0 to Params.Count - 1 do
        TSDParam(Params[I]).Value := Value[I];
    finally
      Params.Free;
    end;
  end else
    ParamByName(ParamName).Value := Value;
end;

procedure TSDParams.GetParamList(List: TList; const ParamNames: string);
var
  Pos: Integer;
begin
  Pos := 1;
  while Pos <= Length(ParamNames) do
    List.Add(ParamByName(ExtractFieldName(ParamNames, Pos)));
end;
{$ENDIF}


{ The below functions are used in TSDExprParser }

{$IFDEF XSQL_CLR}
function VarToDateTime(const V: Variant): TDateTime;
begin
  Result := VarAsType(V, varDate);      // also it is possible to use assigning only
end;
{$ENDIF}

{ Returns a date part of a datetime value }
function VarToDate(V: Variant): TDateTime;
begin
  Result := 0.0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  Result := Trunc( VarToDateTime( V ) );
end;

{ Returns a time part of a datetime value }
function VarToTime(V: Variant): TDateTime;
begin
  Result := 0.0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  Result := VarToDateTime( V );
  Result := Result - Trunc( Result );
end;

{ Returns a year from a datetime value }
function VarToYear(V: Variant): Word;
var
  y, m, d: Word;
begin
  Result := 0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  DecodeDate(VarToDateTime( V ), y, m, d);
  Result := y;
end;

{ Returns a month from a datetime value }
function VarToMonth(V: Variant): Word;
var
  y, m, d: Word;
begin
  Result := 0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  DecodeDate(VarToDateTime( V ), y, m, d);
  Result := m;
end;

{ Returns a day from a datetime value }
function VarToDay(V: Variant): Word;
var
  y, m, d: Word;
begin
  Result := 0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  DecodeDate(VarToDateTime( V ), y, m, d);
  Result := d;
end;

{ Returns hours from a datetime value }
function VarToHour(V: Variant): Word;
var
  h, m, s, ms: Word;
begin
  Result := 0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  DecodeTime(VarToDateTime( V ), h, m, s, ms);
  Result := h;
end;

{ Returns minutes from a datetime value }
function VarToMinute(V: Variant): Word;
var
  h, m, s, ms: Word;
begin
  Result := 0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  DecodeTime(VarToDateTime( V ), h, m, s, ms);
  Result := m;
end;

{ Returns seconds from a datetime value }
function VarToSecond(V: Variant): Word;
var
  h, m, s, ms: Word;
begin
  Result := 0;
  if VarIsEmpty(V) or VarIsNull(V) then
    Exit;

  DecodeTime(VarToDateTime( V ), h, m, s, ms);
  Result := s;
end;

{ TSDExprParser }
{$IFDEF XSQL_VCL5}
constructor TSDExprParser.Create(DataSet: TDataSet; const Text: string;
  Options: TFilterOptions; ParserOptions: TParserOptions;
  const FieldName: string; DepFields: TBits; FieldMap: TFieldMap);
begin
  inherited Create(DataSet, Text, Options, ParserOptions, FieldName, DepFields, FieldMap);
  FDataSet := DataSet;
  FFilteredFields := TStringList.Create;
  FFilteredFields.Sorted := True;
end;

destructor TSDExprParser.Destroy;
begin
  FFilteredFields.Free;

  inherited;
end;

function TSDExprParser.CalcBooleanValue: Boolean;
begin
  Result := WordBool(CalcVariantValue);
end;

function TSDExprParser.FieldByName(const FieldName: string): TField;
var
  i: Integer;
begin
  if FFilteredFields.Find(FieldName, i) then
    Result := TField( FFilteredFields.Objects[i] )
  else begin
    Result := FDataSet.FieldByName(FieldName);
    FFilteredFields.AddObject(FieldName, Result);
  end;
end;

function TSDExprParser.GetNodeOperator(NodePtr: Integer): TCANOperator;
begin   // FilterData = array of Byte
{$IFDEF XSQL_CLR}
  Result := TCANOperator( BitConverter.ToInt32(FilterData, NodePtr + 4) );
{$ELSE}
  Result := TCANOperator(PInteger(@FilterData[NodePtr + 4])^);
{$ENDIF}
end;

function TSDExprParser.GetLiteralStart(StartPtr: Integer): Word;
begin
{$IFDEF XSQL_CLR}
  Result := BitConverter.ToInt16( FilterData, StartPtr+8 );
{$ELSE}
  Result := PWord( @FilterData[StartPtr + 8] )^;
{$ENDIF}
end;

{ Header of FilterData buffer
  CANExpr   = packed record             // Expression Tree
    iVer            : Word;             //  Version tag of expression.
    iTotalSize      : Word;             //  Size of this structure
    iNodes          : Word;             //  Number of nodes
    iNodeStart      : Word;             //  Starting offet of Nodes in this
    iLiteralStart   : Word;             //  Starting offset of Literals in this
  end;
  CANHdr = packed record                // Header part common to all nodes
    nodeClass       : NODEClass;
    canOp           : CANOp;
  end;
}

{ Parse CANUnary structure.
  CANUnary = packed record              // Unary Node
    nodeClass       : NODEClass;
    canOp           : CANOp;
    iOperand1       : Word;             // Byte offset of Operand node
  end;	}
function TSDExprParser.GetUnaryNodeValue(StartPtr, NodePtr: Integer): Variant;
var
  p1, OpOff: Integer;
  v1: Variant;
begin
  Result := Null;
{$IFDEF XSQL_CLR}
  OpOff := BitConverter.ToInt16( FilterData, StartPtr + NodePtr + CANHDRSIZE + 0 );
{$ELSE}
  OpOff := PWord(@FilterData[StartPtr + NodePtr + CANHDRSIZE + 0])^;
{$ENDIF}
  p1 := StartPtr + CANEXPRSIZE + OpOff;
  case GetNodeOperator(NodePtr) of
    coISBLANK,
    coNOTBLANK:
      begin
        v1 := GetNodeValue(StartPtr, p1);
        Result := VarIsEmpty(v1) or VarIsNull(v1);
        if GetNodeOperator(NodePtr) = coNOTBLANK then
          Result := not Result;
      end;
    coNOT:
      Result := not WordBool( GetNodeValue(StartPtr, p1) );
    coMINUS:
      Result := -GetNodeValue(StartPtr, p1);
    coUPPER:
      Result := UpperCase( VarToStr( GetNodeValue(StartPtr, p1) ) );
    coLOWER:
      Result := LowerCase( VarToStr( GetNodeValue(StartPtr, p1) ) );
  else
    DatabaseError(SExprIncorrect);
  end;
end;

{ Parse CANBinary structure.
  CANBinary = packed record             // Binary Node
    nodeClass       : NODEClass;
    canOp           : CANOp;
    iOperand1       : Word;             // Byte offset of Op1
    iOperand2       : Word;             // Byte offset of Op2
  end;	}
function TSDExprParser.GetBinaryNodeValue(StartPtr, NodePtr: Integer): Variant;
var
  p1, p2, OpOff1, OpOff2: Integer;
begin
  Result := Null;
{$IFDEF XSQL_CLR}
  OpOff1 := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 0 );
  OpOff2 := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 2 );
{$ELSE}
  OpOff1 := PWord(@FilterData[NodePtr + CANHDRSIZE + 0])^;
  OpOff2 := PWord(@FilterData[NodePtr + CANHDRSIZE + 2])^;
{$ENDIF}
  p1 := StartPtr + CANEXPRSIZE + OpOff1;
  p2 := StartPtr + CANEXPRSIZE + OpOff2;
  case GetNodeOperator(NodePtr) of
    coEQ:
      Result := GetNodeValue(StartPtr, p1) = GetNodeValue(StartPtr, p2);
    coNE:
      Result := GetNodeValue(StartPtr, p1) <> GetNodeValue(StartPtr, p2);
    coGT:
      Result := GetNodeValue(StartPtr, p1) > GetNodeValue(StartPtr, p2);
    coLT:
      Result := GetNodeValue(StartPtr, p1) < GetNodeValue(StartPtr, p2);
    coGE:
      Result := GetNodeValue(StartPtr, p1) >= GetNodeValue(StartPtr, p2);
    coLE:
      Result := GetNodeValue(StartPtr, p1) <= GetNodeValue(StartPtr, p2);
    coAND:
      Result := WordBool( GetNodeValue(StartPtr, p1) ) and WordBool( GetNodeValue(StartPtr, p2) );
    coOR:
      Result := WordBool( GetNodeValue(StartPtr, p1) ) or WordBool( GetNodeValue(StartPtr, p2) );
    coADD:
      Result := GetNodeValue(StartPtr, p1) + GetNodeValue(StartPtr, p2);
    coSUB:
      Result := GetNodeValue(StartPtr, p1) - GetNodeValue(StartPtr, p2);
    coMUL:
      Result := GetNodeValue(StartPtr, p1) * GetNodeValue(StartPtr, p2);
    coDIV:
      Result := GetNodeValue(StartPtr, p1) / GetNodeValue(StartPtr, p2);
    coMOD, coREM:
      Result := GetNodeValue(StartPtr, p1) mod GetNodeValue(StartPtr, p2);
    coLIKE:     // FSTR like 'AAA' (Extended compare Node is executed with asterisk)
      Result := GetOpLikeValue( GetNodeValue(StartPtr, p1), GetNodeValue(StartPtr, p2) );
    coIN:
      Result := GetOpInValue( GetNodeValue(StartPtr, p1), GetNodeValue(StartPtr, p2) );
    coAssign:
      Result := GetNodeValue(StartPtr, p1);
  else
    DatabaseError(SExprIncorrect);
  end;
end;

{ Parse CANCompare structure.
  CANCompare = packed record            // Extended compare Node (text fields) (*): for example: FSTR like 'AAA*'
    nodeClass       : NODEClass;
    canOp           : CANOp;            // canLIKE, canEQ
    bCaseInsensitive : WordBool;        // 3 val: UNKNOWN = "fastest", "native"
    iPartialLen     : Word;             // Partial fieldlength (0 is full length)
    iOperand1       : Word;             // Byte offset of Op1
    iOperand2       : Word;             // Byte offset of Op2
  end;	}
function TSDExprParser.GetCompareNodeValue(StartPtr, NodePtr: Integer): Variant;
var
  p1, p2, OpOff1, OpOff2: Integer;
  v1, v2: Variant;
  iOpType: TCANOperator;
  bCaseSens: WordBool;
  iPartLen: Word;
begin
  Result := Null;
  iOpType := GetNodeOperator(NodePtr);
{$IFDEF XSQL_CLR}
  bCaseSens := WordBool( BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 0 ) );
  iPartLen := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 2 );
  OpOff1 := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 4 );
  OpOff2 := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 6 );
{$ELSE}
  bCaseSens:= not WordBool(PWord(@FilterData[NodePtr + CANHDRSIZE + 0])^);
  iPartLen := PWord(@FilterData[NodePtr + CANHDRSIZE + 2])^;
  OpOff1 := PWord(@FilterData[NodePtr + CANHDRSIZE + 4])^;
  OpOff2 := PWord(@FilterData[NodePtr + CANHDRSIZE + 6])^;
{$ENDIF}
  p1 := StartPtr + CANEXPRSIZE + OpOff1;
  p2 := StartPtr + CANEXPRSIZE + OpOff2;
  v1 := GetNodeValue(StartPtr, p1);
  v2 := GetNodeValue(StartPtr, p2);

  if VarIsNull(v1) <> VarIsNull(v2) then begin
    Result := iOpType = coNE;
    Exit;
  end else if VarIsNull(v1) then begin	// VarIsNull(v2) is null too
    Result := iOpType in [coEQ, coGE, coLE, coLIKE];
    Exit;
  end;
	// when v1 and v2 are not equal Null
  if not bCaseSens then begin
    v1 := AnsiUpperCase( AnsiString(v1) );
    v2 := AnsiUpperCase( AnsiString(v2) );
  end;
  if iPartLen > 0 then begin
    v1 := Copy(v1, 1, iPartLen);
    v2 := Copy(v2, 1, iPartLen);
  end;

  case iOpType of
    coEQ: Result := v1 = v2;
    coNE: Result := v1 <> v2;
    coLIKE: Result := GetOpLikeValue(v1, v2);
  else
    DatabaseError(SExprIncorrect);
  end;
end;

{ Parse CANConst structure.
  CANConst = packed record              // Constant
    nodeClass       : NODEClass;
    canOp           : CANOp;
    iType           : Word;             // Constant type.
    iSize           : Word;             // Constant size. (in bytes)
    iOffset         : Word;             // Offset in the literal pool.
  end;	}
function TSDExprParser.GetConstNodeValue(StartPtr, NodePtr: Integer): Variant;
var
  DataType: TFieldType;
  p: TSDPtr;
  s: string;
  Curr: Currency;
  TimeStamp: TTimeStamp;
{$IFDEF XSQL_CLR}
  Off: Integer;
{$ENDIF}
begin
  Result := Null;
  if GetNodeOperator(NodePtr) = coCONST2 then begin
{$IFDEF XSQL_CLR}
    DataType := TFieldType( BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 0 ) );
    Off := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 4 );
    Off := StartPtr + GetLiteralStart(StartPtr) + Off;
    s := BitConverter.ToString( FilterData, Off );
{$ELSE}
    DataType := TFieldType( PWord(@FilterData[NodePtr + CANHDRSIZE + 0])^ );
    p := PChar(@FilterData[0]) + StartPtr + GetLiteralStart(StartPtr) + PWord(@FilterData[NodePtr + CANHDRSIZE + 4])^;
    s := PChar(p);
{$ENDIF}
    case DataType of
      ftBoolean:
       {$IFDEF XSQL_CLR}
        Result := WordBool( BitConverter.ToInt16(FilterData, Off) );
       {$ELSE}
        Result := WordBool(PWord(p)^);
       {$ENDIF}
      ftSmallInt, ftWord:
        {$IFDEF XSQL_CLR}
        Result := BitConverter.ToInt16(FilterData, Off);
        {$ELSE}
        Result := PWord(p)^;
        {$ENDIF}
      ftInteger, ftAutoInc:
        {$IFDEF XSQL_CLR}
        Result := BitConverter.ToInt32(FilterData, Off);
        {$ELSE}
        Result := PInteger(p)^;
        {$ENDIF}
      ftFloat, ftCurrency:
        {$IFDEF XSQL_CLR}
        Result := BitConverter.ToDouble(FilterData, Off);
        {$ELSE}
        Result := PDouble(p)^;
        {$ENDIF}
      ftString, ftWideString, ftFixedChar, ftGuid:
        Result := s;    // string(p);
      ftDate:
        begin
        {$IFDEF XSQL_CLR}
          TimeStamp.Date := BitConverter.ToInt32(FilterData, Off);
        {$ELSE}
          TimeStamp.Date := PInteger(p)^;
        {$ENDIF}
          TimeStamp.Time := 0;
          Result := TimeStampToDateTime(TimeStamp);
        end;
      ftTime:
        begin
          TimeStamp.Date := 0;
        {$IFDEF XSQL_CLR}
          TimeStamp.Time := BitConverter.ToInt32(FilterData, Off);
        {$ELSE}
          TimeStamp.Time := PInteger(p)^;
        {$ENDIF}
          Result := TimeStampToDateTime(TimeStamp);
        end;
      ftDateTime:
        begin
        {$IFDEF XSQL_CLR}
          TimeStamp := MSecsToTimeStamp( BitConverter.ToInt64(FilterData, Off) );
        {$ELSE}
          TimeStamp := MSecsToTimeStamp( Double( Pointer(p)^ ) );
        {$ENDIF}
          Result := TimeStampToDateTime(TimeStamp);
        end;
      ftBCD:
        begin
        {$IFDEF XSQL_CLR}
          Curr := TBcd(Marshal.PtrToStructure(p, TypeOf(TBCD)));
{
         ! the second variant !
          B: TBytes
          SetLength(B, SizeOfTBcd);
          Marshal.Copy(Data, B, 0, Length(B));
          Qry.Params[i].AsBcd := TBcd.FromBytes(B);
 }
        {$ELSE}
          BCDToCurr(PBCD(p)^, Curr);
        {$ENDIF}
          Result := Curr;
        end;

    else
      DatabaseError(SExprIncorrect);
    end;
  end else
    DatabaseError(SExprIncorrect);
end;

{ Parse CANField structure
  CANField = packed record              // Field
    nodeClass       : NODEClass;
    canOp           : CANOp;
    iFieldNum       : Word;
    iNameOffset     : Word;             // Name offset in Literal pool
  end;	}
function TSDExprParser.GetFieldNodeValue(StartPtr, NodePtr: Integer): Variant;
var
{$IFNDEF XSQL_CLR}
  p: PChar;
{$ENDIF}
  s: string;
begin
  Result := Null;
  if GetNodeOperator(NodePtr) = coFIELD2 then begin
{$IFDEF XSQL_CLR}
    s := BitConverter.ToString( FilterData, StartPtr + GetLiteralStart(StartPtr) + BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 2 ) );
{$ELSE}
    p := PChar(@FilterData[0]) + StartPtr + GetLiteralStart(StartPtr) + PWord(@FilterData[NodePtr + CANHDRSIZE + 2])^;
    s := p;
{$ENDIF}
    Result := FieldByName(s).Value;
  end else
    DatabaseError(SExprIncorrect);
end;

{ Parse CANFunc structure
  CANFunc = packed record               // Function
    nodeClass       : NODEClass;
    canOp           : CANOp;
    iNameOffset     : Word;             // Name offset in Literal pool
    iElemOffset     : Word;             // Offset of first List Element in Node pool
  end;	}
function TSDExprParser.GetFuncNodeValue(StartPtr, NodePtr: Integer): Variant;
var
  p: Integer;
  sFunc: string;
  v: Variant;
  p1, p2: Integer;
begin
  Result := Null;
{$IFDEF XSQL_CLR}
  p := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 0 );
  p := StartPtr + GetLiteralStart(StartPtr) + p;
  sFunc := BitConverter.ToString( FilterData, p );
  p := BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 2 );
{$ELSE}
  p := StartPtr + GetLiteralStart(StartPtr) + PWord(@FilterData[NodePtr + CANHDRSIZE + 0])^;
  sFunc := AnsiUpperCase( PChar(@FilterData[0]) + p );
  p := PWord(@FilterData[NodePtr + CANHDRSIZE + 2])^;
{$ENDIF}
  if Trim(sFunc) = '' then
    DatabaseErrorFmt(SExprExpected, [sFunc]);
	// get an offset to the first List Element (function parameter)
  p := StartPtr + CANEXPRSIZE + p;

  if sFunc = 'GETDATE' then
    Result := Now
  else if sFunc = 'DATE' then
    Result := VarToDate( GetNodeValue(StartPtr, p) )
  else if sFunc = 'TIME' then
    Result := VarToTime( GetNodeValue(StartPtr, p) )
  else if sFunc = 'SUBSTRING' then begin
    v := GetNodeValue(StartPtr, p);
    p1 := 1;
    p2 := 0;
    if not VarIsNull(v[1]) and (VarType(v[1]) in [varSmallInt, varInteger, varSingle, varDouble]) then
      p1 := v[1];
    if not VarIsNull(v[2]) and (VarType(v[2]) in [varSmallInt, varInteger, varSingle, varDouble]) then
      p2 := v[2];
    Result := Copy(v[0], p1, p2);
  end else if sFunc = 'TRIM' then
    Result := Trim( VarToStr( GetNodeValue(StartPtr, p) ) )
  else if sFunc = 'TRIMLEFT' then
    Result := TrimLeft( VarToStr( GetNodeValue(StartPtr, p) ) )
  else if sFunc = 'TRIMRIGHT' then
    Result := TrimRight( VarToStr( GetNodeValue(StartPtr, p) ) )
  else if sFunc = 'LOWER' then
    Result := LowerCase( VarToStr( GetNodeValue(StartPtr, p) ) )
  else if sFunc = 'UPPER' then
    Result := UpperCase( VarToStr( GetNodeValue(StartPtr, p) ) )
  else if sFunc = 'DAY' then
    Result := VarToDay( GetNodeValue(StartPtr, p) )
  else if sFunc = 'MONTH' then
    Result := VarToMonth( GetNodeValue(StartPtr, p) )
  else if sFunc = 'YEAR' then
    Result := VarToYear( GetNodeValue(StartPtr, p) )
  else if sFunc = 'HOUR' then
    Result := VarToHour( GetNodeValue(StartPtr, p) )
  else if sFunc = 'MINUTE' then
    Result := VarToMinute( GetNodeValue(StartPtr, p) )
  else if sFunc = 'SECOND' then
    Result := VarToSecond( GetNodeValue(StartPtr, p) )
  else
    DatabaseErrorFmt(SExprExpected, [sFunc]);
end;

{ Parse CANListElem structure
  CANListElem = packed record           // List Element
    nodeClass       : NODEClass;
    canOp           : CANOp;
    iOffset         : Word;             // Arg offset in Node pool
    iNextOffset     : Word;             // Offset in Node pool of next ListElem or 0 if end of list
  end;	}
function TSDExprParser.GetListNodeValue(StartPtr, NodePtr: Integer): Variant;
var
  p: Integer;
  v: Variant;
  i, j: Integer;
  iNodeClass: NODEClass;        // 4 byte
begin
  if GetNodeOperator(NodePtr) <> coLISTELEM2 then
    DatabaseError(SExprIncorrect);
	// Create VarArray for ListElements Values
{$IFDEF XSQL_CLR}
  Result := VarArrayCreate ([0, 50], varObject);
  p := StartPtr + CANEXPRSIZE + BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 0 );
{$ELSE}
  Result := VarArrayCreate ([0, 50], varVariant);
  p := StartPtr + CANEXPRSIZE + PWord(@FilterData[NodePtr + CANHDRSIZE + 0])^;
{$ENDIF}
  i := 0;	// the current element in array Result
  repeat
    v := GetNodeValue(StartPtr, p);
    	// expand/insert an array V inside an array Result
    if VarIsArray(v) then begin
      j := 0;
      while not VarIsEmpty( v[j] ) do begin
        Result[i] := v[j];
        Inc(i);
        Inc(j);
      end;
    end else begin
      Result[i] := v;
      Inc(i);
    end;
{$IFDEF XSQL_CLR}
    p := StartPtr + CANEXPRSIZE + BitConverter.ToInt16( FilterData, NodePtr + CANHDRSIZE + 2*i );
    iNodeClass := NODEClass( BitConverter.ToInt32( FilterData, p ) );
{$ELSE}
    p := StartPtr + CANEXPRSIZE + PWord(@FilterData[NodePtr + CANHDRSIZE + SizeOf(Word)*i])^;
    iNodeClass := NODEClass(PInteger(PChar(@FilterData[0]) + p)^);
{$ENDIF}
  until iNodeClass <> nodeLISTELEM;

  if i = 1 then
    if VarIsNull( Result[0] ) then
      Result := Null
    else	// the following line: <Result := Result[0]> will raise AV.
      Result := VarAsType( Result[0], VarType(Result[0]) );
end;

{ if V1 in V2 }
function TSDExprParser.GetOpInValue(V1, V2: Variant): Variant;
var
  i, Num: Integer;
begin
  Result := False;
  if VarIsArray(V2) then begin
    Num := VarArrayHighBound(V2, 1);
    for i:=0 to Num do begin
      if VarIsEmpty( V2[i] ) then
        Break;
      Result := V1 = V2[i];
      if Result then
        Break;
    end;
  end else
    Result := V1 = V2;
end;

{ if V1 like V2 }
function TSDExprParser.GetOpLikeValue(V1, V2: Variant): Variant;
var
  s: string;
  i: Integer;
  PartialKey: Boolean;
begin
  s := V2;
  PartialKey := not (foNoPartialCompare in FDataSet.FilterOptions);
  if PartialKey then begin
    i := Pos( FilterWildcard, s );
    if i > 0 then
      s := Copy(s, 1, i - 1);   // copy without wildcard
  end;
  Result := VarIsEqual(v1, s, foCaseInsensitive in FDataSet.FilterOptions, PartialKey, True);
end;

{ Returns a value of an expression of the node.
  Parameters:
    StartPtr is a pointer to CANExpr structure (begin of the FilterData);
    NodePtr is a pointer to the current CANNode structure }
function TSDExprParser.GetNodeValue(StartPos, NodePos: Integer): Variant;
var
  iNodeClass: NODEClass;
begin
  Result := Null;
{$IFDEF XSQL_CLR}
  iNodeClass := NODEClass( BitConverter.ToInt32( FilterData, StartPos + NodePos ) );
{$ELSE}
  iNodeClass := NODEClass( PInteger(@FilterData[StartPos + NodePos])^ );  //  iNodeType := NODEClass(PInteger(@NodePtr[0])^);
{$ENDIF}
  case iNodeClass of
//    nodeNULL:   Result := Null;
    nodeUNARY:  Result := GetUnaryNodeValue(StartPos, NodePos);
    nodeBINARY: Result := GetBinaryNodeValue(StartPos, NodePos);
    nodeCOMPARE:Result := GetCompareNodeValue(StartPos, NodePos);
    nodeFIELD:	Result := GetFieldNodeValue(StartPos, NodePos);
    nodeCONST:  Result := GetConstNodeValue(StartPos, NodePos);
    nodeFUNC:   Result := GetFuncNodeValue(StartPos, NodePos);
    nodeLISTELEM: Result := GetListNodeValue(StartPos, NodePos);
  else
    DatabaseError(SExprIncorrect);
  end;
end;

function TSDExprParser.CalcVariantValue: Variant;
var
  StartPos, NodePos: Integer;
  iExprVer: Word;
begin
{$IFDEF XSQL_CLR}
  iExprVer := BitConverter.ToInt16( FilterData, 0 );
{$ELSE}
  iExprVer := PWord( @FilterData[0] )^;
{$ENDIF}
  if iExprVer <> CANEXPRVERSION then
    DatabaseErrorFmt(SExprBadVersion, [IntToStr(iExprVer)]);
  StartPos := 0;
{$IFDEF XSQL_CLR}
  NodePos := StartPos + BitConverter.ToInt16( FilterData, 6 );
{$ELSE}
  NodePos := StartPos + PWord( @FilterData[6] )^;
{$ENDIF}
	// pointer to FilterData and the first node
  Result := GetNodeValue(StartPos, NodePos);
end;

procedure TSDExprParser.ClearFields;
begin
  FFilteredFields.Clear;
end;
{$ENDIF}	{IFDEF XSQL_VCL5}

{ TSDBufferList }

constructor TSDBufferList.Create;
begin
  inherited;
  FList := TList.Create;
end;

destructor TSDBufferList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

procedure TSDBufferList.Clear;
var
  i: Integer;
  p: TSDPtr;
begin
  if not Assigned(FList) then
    Exit;
  i := FList.Count - 1;
  while i >= 0 do begin
    p := TSDPtr( FList[i] );
    if Assigned(p) then begin
{$IFDEF XSQL_CLR}
      Marshal.FreeHGlobal(p);
{$ELSE}
      StrDispose(PChar(p));
{$ENDIF}
     end;
     FList.Remove(p);
     Dec(i);
  end;
end;

function TSDBufferList.StringToPtr(S: string): TSDPtr;
begin
{$IFDEF XSQL_CLR}
  Result := Marshal.StringToHGlobalAnsi(S);
{$ELSE}
  Result := StrNew(PChar(S));
{$ENDIF}
  FList.Add(Result);
end;

function GetFieldInfoStruct(Buffer: TSDPtr; Offset: Integer): TSDFieldInfo;
begin
{$IFDEF XSQL_CLR}
  Result := TSDFieldInfo( Marshal.PtrToStructure( TSDPtr(Longint(Buffer) + Offset), TypeOf(TSDFieldInfo) ) );
{$ELSE}
  Result := PSDFieldInfo( IncPtr( Buffer, Offset ) )^;
{$ENDIF}
end;

procedure SetFieldInfoStruct(Buffer: TSDPtr; Offset: Integer; Value: TSDFieldInfo);
begin
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( Value, TSDPtr(Longint(Buffer) + Offset), False );
{$ELSE}
  PSDFieldInfo( IncPtr( Buffer, Offset ) )^ := Value;
{$ENDIF}
end;

function GetFieldInfoDataSizeOff: Integer;
begin
  Result := SizeOf(TSDFieldInfo) div 2;
end;

function GetFieldInfoFetchStatusOff: Integer;
begin
  Result := 0;
end;


//  Gets/sets a blob value from the specified record buffer RecBuf, which has an array of
// pointers at ABlobCacheOffs that point to the actual Blob cache buffers.
// AFieldOffset is the index into the array.
function GetFieldBlobData(RecBuf: TSDRecordBuffer; ABlobCacheOffs, AFieldOffset: Integer): TSDBlobData;
{$IFDEF XSQL_CLR}
var
  BlobPtr: TSDValueBuffer;
  BlobSize: Integer;
{$ENDIF}
begin
  ASSERT( Assigned(RecBuf) );
{$IFDEF XSQL_CLR}
  BlobPtr := Marshal.ReadIntPtr( RecBuf, ABlobCacheOffs + AFieldOffset * SizeOf(BlobPtr) );
  if Assigned(BlobPtr) then begin
    BlobSize := Marshal.ReadInt32( BlobPtr, 0 );
    if BlobSize > 0 then begin
      SetLength(Result, BlobSize);
      Marshal.Copy( TSDPtr(Longint(BlobPtr) + SizeOf(BlobSize)), Result, 0, BlobSize );
    end;
  end;
{$ELSE}
  Result := PSDBlobDataArray(RecBuf + ABlobCacheOffs)[AFieldOffset];
{$ENDIF}
end;

function GetFieldBlobDataSize(RecBuf: TSDRecordBuffer; ABlobCacheOffs, AFieldOffset: Integer): Integer;
{$IFDEF XSQL_CLR}
var
  BlobPtr: TSDValueBuffer;
{$ENDIF}
begin
  ASSERT( Assigned(RecBuf) );
{$IFDEF XSQL_CLR}
  Result := 0;
  BlobPtr := Marshal.ReadIntPtr( RecBuf, ABlobCacheOffs + AFieldOffset * SizeOf(BlobPtr) );
  if Assigned(BlobPtr) then
    Result := Marshal.ReadInt32( BlobPtr, 0 );
{$ELSE}
  Result := Length( PSDBlobDataArray(RecBuf + ABlobCacheOffs)[AFieldOffset] );
{$ENDIF}
end;

procedure SetFieldBlobData(RecBuf: TSDRecordBuffer; ABlobCacheOffs, AFieldOffset: Integer; Value: TSDBlobData);
{$IFDEF XSQL_CLR}
var
  BlobPtr: TSDValueBuffer;
  BlobSize: Integer;
{$ENDIF}
begin
  ASSERT( Assigned(RecBuf) );
{$IFDEF XSQL_CLR}
  BlobSize := Length(Value);
  BlobPtr := Marshal.ReadIntPtr( RecBuf, ABlobCacheOffs + AFieldOffset * SizeOf(BlobPtr) );
  if Assigned(BlobPtr) then
    Marshal.FreeHGlobal(BlobPtr);
  if BlobSize > 0 then begin
    BlobPtr := Marshal.AllocHGlobal( SizeOf(BlobSize) + BlobSize );
    Marshal.WriteInt32( BlobPtr, 0, BlobSize );
    Marshal.Copy( Value, 0, TSDPtr(Longint(BlobPtr) + SizeOf(BlobSize)), BlobSize );
  end else
    BlobPtr := nil;
  Marshal.WriteIntPtr( RecBuf, ABlobCacheOffs + AFieldOffset * SizeOf(BlobPtr), BlobPtr );
{$ELSE}
  PSDBlobDataArray(RecBuf + ABlobCacheOffs)[AFieldOffset] := Value;
{$ENDIF}
end;

function HelperMemReadByte(const Ptr: TSDPtr; Offset: Integer): Byte;
begin
{$IFDEF XSQL_CLR}
  Result := Marshal.ReadByte(Ptr, Offset);
{$ELSE}
  Result := Byte(TSDPtr(Longint(Ptr) + Offset)^);
{$ENDIF}
end;

procedure HelperMemWriteByte(const Ptr: TSDPtr; Offset: Integer; Value: Byte);
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteByte(Ptr, Offset, Value);
{$ELSE}
  Byte(TSDPtr(Longint(Ptr) + Offset)^) := Value;
{$ENDIF}
end;

// Offset is byte-offset
function HelperMemReadInt16(const Ptr: TSDPtr; Offset: Integer): Smallint;
begin
{$IFDEF XSQL_CLR}
  Result := Marshal.ReadInt16(Ptr, Offset);
{$ELSE}
  Result := Smallint(TSDPtr(Longint(Ptr) + Offset)^);
{$ENDIF}
end;

procedure HelperMemWriteInt16(const Ptr: TSDPtr; Offset: Integer; Value: Smallint);
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteInt16(Ptr, Offset, Value);
{$ELSE}
  Smallint(TSDPtr(Longint(Ptr) + Offset)^) := Value;
{$ENDIF}
end;

// Offset is calculated in byte
function HelperMemReadInt32(const Ptr: TSDPtr; Offset: Integer): Longint;
begin
{$IFDEF XSQL_CLR}
  Result := Marshal.ReadInt32(Ptr, Offset);
{$ELSE}
  Result := Longint(TSDPtr(Longint(Ptr) + Offset)^);
{$ENDIF}
end;

procedure HelperMemWriteInt32(const Ptr: TSDPtr; Offset, Value: Longint);
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteInt32(Ptr, Offset, Value);
{$ELSE}
  Longint(TSDPtr(Longint(Ptr) + Offset)^) := Value;
{$ENDIF}
end;

function HelperMemReadInt64(const Ptr: TSDPtr; Offset: Integer): TInt64;
begin
{$IFDEF XSQL_CLR}
  Result := Marshal.ReadInt64(Ptr, Offset);
{$ELSE}
  Result := TInt64(TSDPtr(Longint(Ptr) + Offset)^);
{$ENDIF}
end;

procedure HelperMemWriteInt64(const Ptr: TSDPtr; Offset: Integer; Value: TInt64);
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteInt64(Ptr, Offset, Value);
{$ELSE}
  TInt64(TSDPtr(Longint(Ptr) + Offset)^) := Value;
{$ENDIF}
end;

function HelperMemReadDouble(const Ptr: TSDPtr; Offset: Integer): Double;
begin
{$IFDEF XSQL_CLR}
  Result := BitConverter.Int64BitsToDouble(Marshal.ReadInt64(Ptr));
{$ELSE}
  Result := Double(TSDPtr(Longint(Ptr) + Offset)^);
{$ENDIF}
end;

procedure HelperMemWriteDouble(const Ptr: TSDPtr; Offset: Integer; Value: Double);
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteInt64(Ptr, Offset, BitConverter.DoubleToInt64Bits(Value));
{$ELSE}
  Double(TSDPtr(Longint(Ptr) + Offset)^) := Value;
{$ENDIF}
end;

function HelperMemReadSingle(const Ptr: TSDPtr; Offset: Integer): Single;
{$IFDEF XSQL_CLR}
var
  TempBytes: TBytes;
begin
  SetLength(TempBytes, SizeOf(Result));
  Marshal.Copy(Ptr, TempBytes, 0, SizeOf(Result));
  Result := BitConverter.ToSingle(TempBytes, 0);
{$ELSE}
begin
  Result := Single(TSDPtr(Longint(Ptr) + Offset)^);
{$ENDIF}
end;

function HelperMemReadPtr(const Ptr: TSDPtr; Offset: Integer): TSDPtr;
begin
  Result := TSDPtr( HelperMemReadInt32( Ptr, Offset ) );
end;

procedure HelperMemWritePtr(const Ptr: TSDPtr; Offset: Integer; Value: TSDPtr);
begin
  HelperMemWriteInt32( Ptr, Offset, LongInt(Value) );
end;

// Returns True, if convertion is successful. BcdPtr has to points to buffer with size 34 byte(SizeOfTBCD = 34)
function HelperCurrToBCD(Curr: Currency; BCDPtr: TSDPtr; Precision: Integer = 32; Decimals: Integer = 4): Boolean;
{$IFDEF XSQL_CLR}
var
  TempBcd: TBcd;
  TempBytes: TBytes;
begin
  TempBcd := TBcd.Create(Curr, Precision, Decimals);
  TempBytes := TBcd.ToBytes(TempBcd);
  Marshal.Copy(TempBytes, 0, BcdPtr, SizeOfTBcd);
  Result := True;
{$ELSE}
begin
  Result := CurrToBCD(Curr, TBcd(BCDPtr^), Precision, Decimals);
{$ENDIF}
end;

function HelperMemReadDateTimeRec(const Ptr: TSDPtr; Offset: Integer): TDateTimeRec;
begin
{$IFDEF XSQL_CLR}
  Result := TDateTimeRec( Marshal.PtrToStructure( TSDPtr(Longint(Ptr) + Offset), TypeOf(TDateTimeRec) ) );
{$ELSE}
  Result := TDateTimeRec( TSDPtr(Longint(Ptr) + Offset)^ );
{$ENDIF}
end;

procedure HelperMemWriteDateTimeRec(const Ptr: TSDPtr; Offset: Integer; Value: TDateTimeRec);
begin
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr(Value, TSDPtr(Longint(Ptr) + Offset), False);
{$ELSE}
  TDateTimeRec( TSDPtr(Longint(Ptr) + Offset)^ ) := Value;
{$ENDIF}
end;

procedure HelperMemWriteGuid(const Ptr: TSDPtr; Offset: Integer; Value: TGUID);
begin
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr(Value, TSDPtr(Longint(Ptr) + Offset), False);
{$ELSE}
  TGUID( TSDPtr(Longint(Ptr) + Offset)^ ) := Value;
{$ENDIF}
end;

{ zero-terminator has to be included in Value or has to be set later }
procedure HelperMemWriteString(const Ptr: TSDPtr; Offset: Integer; Value: string; Count: Integer);
{$IFDEF XSQL_CLR}
var
  i: Integer;
begin
  i := 0;
  while i < Count do begin
    if (i+1) > Length(Value) then begin
      Marshal.WriteByte(Ptr, Offset + i, 0);
      Break;
    end else
      Marshal.WriteByte(Ptr, Offset + i, Byte(Value[i+1]));
    Inc(i);
  end;
{$ELSE}
begin
  StrMove( TSDPtr(Longint(Ptr) + Offset), PChar(Value), Count);
{$ENDIF}
end;

function HelperPtrToString(const Ptr: TSDPtr; Len: Integer = -1): string;
begin
{$IFDEF XSQL_CLR}
  if Len >= 0 then
    Result := Marshal.PtrToStringAnsi(Ptr, Len)
  else
    Result := Marshal.PtrToStringAnsi(Ptr);
{$ELSE}
  Result := PChar(Ptr);
  if (Len >= 0) and (Length(Result) > Len) then
    SetLength( Result, Len );
{$ENDIF}
end;

// it is possible to override procedure for other value types
procedure HelperAssignParamValue(AParam: TSDHelperParam; Value: TDateTimeRec);
var
  Buf: TSDValueBuffer;
begin
{$IFDEF XSQL_CLR}
  Buf := SafeReallocMem( nil, SizeOf(Value) );
  try
    SafeInitMem( Buf, SizeOf(Value), 0 );
    HelperMemWriteDouble( Buf, 0, Value.DateTime );
    AParam.SetData( Buf );
  finally
    SafeReallocMem( Buf, 0 );
  end;
{$ELSE}
  Buf := @Value;
  AParam.SetData( Buf );
{$ENDIF}
end;

function IncPtr(const ptr: TSDPtr; Delta: Integer): TSDPtr;
begin
  Result := TSDPtr( Longint(ptr) + Delta );
end;

function SafeReallocMem(const OldPtr: TSDPtr; Size: Integer): TSDPtr;
begin
  Result := nil;
  if Size > 0 then begin
{$IFDEF XSQL_CLR}
    if Assigned(OldPtr) then
      Result := Marshal.ReAllocHGlobal(OldPtr, TSDPtr(Size))
    else
      Result := Marshal.AllocHGlobal(Size);
{$ELSE}
    if Assigned(OldPtr) then begin
      Result := OldPtr;
      ReAllocMem(Result, Size);
    end else
      ReAllocMem(Result, Size);
{$ENDIF}
  end else begin
    if Assigned(OldPtr) then
{$IFDEF XSQL_CLR}
      Marshal.FreeHGlobal(OldPtr);
{$ELSE}
      FreeMem(OldPtr)
{$ENDIF}
  end;
end;

procedure SafeCopyMem(Src, Dest: TSDPtr; Count: Integer);
{$IFDEF XSQL_CLR}
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    Marshal.WriteByte( Dest, i, Marshal.ReadByte(Src, i) );
{$ELSE}
begin
  System.Move(Src^, Dest^, Count);
{$ENDIF}
end;

procedure SafeInitMem(Buffer: TSDPtr; Count: Integer; InitByte: Byte);
{$IFDEF XSQL_CLR}
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
     Marshal.WriteByte(Buffer, i, InitByte);
{$ELSE}
begin
  FillChar(Buffer^, Count, InitByte);
{$ENDIF}
end;

function HelperLoadLibrary(ALibFileName: string): HMODULE;
begin
{$IFDEF XSQL_CLR}
  Result := LoadLibrary( ALibFileName );
{$ELSE}
  Result := LoadLibrary( PChar(ALibFileName) );
{$ENDIF}
end;

{$IFNDEF XSQL_VCL5}
function CurrToBCD(Curr: Currency; var BCD: TBcd; Precision, Decimals: Integer): Boolean;
const
  Power10: array[0..3] of Single = (10000, 1000, 100, 10);
var
  Digits: array[0..63] of Byte;
asm
        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,EAX
        XCHG    ECX,EDX
        MOV     [ESI].TBcd.Precision,CL
        MOV     [ESI].TBcd.SignSpecialPlaces,DL
@@1:    SUB     EDX,4
        JE      @@3
        JA      @@2
        FILD    Curr
        FDIV    Power10.Single[EDX*4+16]
        FISTP   Curr
        JMP     @@3
@@2:    DEC     ECX
        MOV     Digits.Byte[ECX],0
        DEC     EDX
        JNE     @@2
@@3:    MOV     EAX,Curr.Integer[0]
        MOV     EBX,Curr.Integer[4]
        OR      EBX,EBX
        JNS     @@4
        NEG     EBX
        NEG     EAX
        SBB     EBX,0
        OR      [ESI].TBcd.SignSpecialPlaces,80H
@@4:    MOV     EDI,10
@@5:    MOV     EDX,EAX
        OR      EDX,EBX
        JE      @@7
        XOR     EDX,EDX
        OR      EBX,EBX
        JE      @@6
        XCHG    EAX,EBX
        DIV     EDI
        XCHG    EAX,EBX
@@6:    DIV     EDI
@@7:    MOV     Digits.Byte[ECX-1],DL
        DEC     ECX
        JNE     @@5
        OR      EAX,EBX
        MOV     AL,0
        JNE     @@9
        MOV     CL,[ESI].TBcd.Precision
        INC     ECX
        SHR     ECX,1
@@8:    MOV     AX,Digits.Word[ECX*2-2]
        SHL     AL,4
        OR      AL,AH
        MOV     [ESI].TBcd.Fraction.Byte[ECX-1],AL
        DEC     ECX
        JNE     @@8
        MOV     AL,1
@@9:    POP     EDI
        POP     ESI
        POP     EBX
end;

function BCDToCurr(const BCD: TBcd; var Curr: Currency): Boolean;
const
  FConst10: Single = 10;
  CWNear: Word = $133F;
var
  CtrlWord: Word;
  Temp: Integer;
  Digits: array[0..63] of Byte;
asm
        PUSH    EBX
        PUSH    ESI
        MOV     EBX,EAX
        MOV     ESI,EDX
        MOV     AL,0
        MOVZX   EDX,[EBX].TBcd.Precision
        OR      EDX,EDX
        JE      @@8
        LEA     ECX,[EDX+1]
        SHR     ECX,1
@@1:    MOV     AL,[EBX].TBcd.Fraction.Byte[ECX-1]
        MOV     AH,AL
        SHR     AL,4
        AND     AH,0FH
        MOV     Digits.Word[ECX*2-2],AX
        DEC     ECX
        JNE     @@1
        XOR     EAX,EAX
@@2:    MOV     AL,Digits.Byte[ECX]
        OR      AL,AL
        JNE     @@3
        INC     ECX
        CMP     ECX,EDX
        JNE     @@2
        FLDZ
        JMP     @@7
@@3:    MOV     Temp,EAX
        FILD    Temp
@@4:    INC     ECX
        CMP     ECX,EDX
        JE      @@5
        FMUL    FConst10
        MOV     AL,Digits.Byte[ECX]
        MOV     Temp,EAX
        FIADD   Temp
        JMP     @@4
@@5:    MOV     AL,[EBX].TBcd.SignSpecialPlaces
        OR      AL,AL
        JNS     @@6
        FCHS
@@6:    AND     EAX,3FH
        SUB     EAX,4
        NEG     EAX
        CALL    FPower10
@@7:    FSTCW   CtrlWord
        FLDCW   CWNear
        FISTP   [ESI].Currency
        FSTSW   AX
        NOT     AL
        AND     AL,1
        FCLEX
        FLDCW   CtrlWord
        FWAIT
@@8:    POP     ESI
        POP     EBX
end;
{$ENDIF}	{IFNDEF XSQL_VCL5}

end.
