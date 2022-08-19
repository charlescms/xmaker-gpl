{$I XSqlDir.inc}
unit XSEngine {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, Messages, SysUtils, Consts, Classes, Controls, Forms,
  Db, SyncObjs,
{$IFDEF XSQL_VCL5}
  DbCommon,
{$ENDIF}
{$IFDEF XSQL_VCL6}
  Variants, RTLConsts,
{$ENDIF}
{$IFDEF XSQL_CLR}
  Contnrs, System.Runtime.InteropServices,
{$ENDIF}
  XSConsts, XSCommon;

const
  SDE_ERR_NONE		= 0;
  SDE_ERR_UPDATEABORT	= -1;

  { TSDDataSet flags }

  dsfOpened     = 0;
  dsfPrepared   = 1;
  dsfExecSQL    = 2;
  dsfTable      = 3;
  dsfFieldList  = 4;
  dsfIndexList  = 5;
  dsfStoredProc = 6;
  dsfExecProc	= 7;
  dsfProcDesc   = 8;
  dsfProvider   = 10;

type
  TSDServerType = (stSQLBase, stOracle, stSQLServer, stSybase,
  		   stDB2, stInformix, stODBC, stInterbase, stFirebird,
                   stMySQL, stPostgreSQL, stOLEDB);

  TXSQLSession 		= class;
  TXSQLDatabase 		= class;
  TSDDataSet  		= class;
  TXSQLQuery  		= class;
  
{ ESDNoResultSet }

  ESDNoResultSet = class(EDatabaseError);

{ TSessionList }

  TXSQLSessionList = class(TObject)
  private
    FSessions: TThreadList;
    FSessionNumbers: TBits;
    procedure AddSession(ASession: TXSQLSession);
    procedure CloseAll;
    function GetCount: Integer;
    function GetSession(Index: Integer): TXSQLSession;
    function GetSessionByName(const SessionName: string): TXSQLSession;
  public
    constructor Create;
    destructor Destroy; override;
    function FindDatabase(const DatabaseName: string): TXSQLDatabase;
    function FindSession(const SessionName: string): TXSQLSession;
    procedure GetSessionNames(List: TStrings);
    function OpenSession(const SessionName: string): TXSQLSession;
    property Count: Integer read GetCount;
    property List[const SessionName: string]: TXSQLSession read GetSessionByName;
    property Sessions[Index: Integer]: TXSQLSession read GetSession; default;
  end;

{ TXSQLSession }

  TXSQLSession = class(TComponent)
  private
    FDatabases: TList;				// active or inactive database components, which have an associated SessionName
    FDefault: Boolean;
    FKeepConnections: Boolean;			// for temporary database objects in run-time
    FDBParams: TList;				// remote database parameters could be used, for example, for TXSQLDatabase with an empty Params property
    FAutoSessionName: Boolean;
    FUpdatingAutoSessionName: Boolean;
    FSessionName: string;
    FSessionNumber: Integer;
    FLockCount: Integer;

    FActive: Boolean;
    FStreamedActive: Boolean;
    FSQLHourGlass: Boolean;
    FSQLWaitCursor: TCursor;
    procedure AddDatabase(Value: TXSQLDatabase);
    procedure CheckInactive;
    procedure ClearDBParams;
    function DoFindDatabase(const DatabaseName: string; AOwner: TComponent): TXSQLDatabase;
    function DoOpenDatabase(const DatabaseName: string; AOwner: TComponent): TXSQLDatabase;
    function GetActive: Boolean;
    function GetDatabase(Index: Integer): TXSQLDatabase;
    function GetDatabaseCount: Integer;
    procedure LockSession;
    procedure MakeCurrent;
    procedure RemoveDatabase(Value: TXSQLDatabase);
    function SessionNameStored: Boolean;
    procedure SetActive(Value: Boolean);
    procedure SetAutoSessionName(Value: Boolean);
    procedure SetSessionName(const Value: string);
    procedure SetSessionNames;
    procedure StartSession(Value: Boolean);
    procedure UnlockSession;
    procedure InternalAddDatabase(const ARemoteDatabase: string; AServerType: TSDServerType; List: TStrings);
    procedure UpdateAutoSessionName;
    procedure ValidateAutoSession(AOwner: TComponent; AllSessions: Boolean);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Close;
    procedure CloseDatabase(Database: TXSQLDatabase);
    function FindDatabase(const DatabaseName: string): TXSQLDatabase;
    procedure GetDatabaseNames(List: TStrings);
    procedure GetDatabaseParams(const ARemoteDatabase: string; AServerType: TSDServerType; List: TStrings);
    procedure GetStoredProcNames(const DatabaseName: string; List: TStrings);
    procedure GetFieldNames(const DatabaseName, TableName: string; List: TStrings);
    procedure GetTableNames(const DatabaseName, Pattern: string; SystemTables: Boolean; List: TStrings);
    procedure Open;
    function OpenDatabase(const DatabaseName: string): TXSQLDatabase;
    property DatabaseCount: Integer read GetDatabaseCount;
    property Databases[Index: Integer]: TXSQLDatabase read GetDatabase;
    property SQLWaitCursor: TCursor read FSQLWaitCursor write FSQLWaitCursor;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property AutoSessionName: Boolean read FAutoSessionName write SetAutoSessionName default False;
    property KeepConnections: Boolean read FKeepConnections write FKeepConnections default True;
    property SessionName: string read FSessionName write SetSessionName stored SessionNameStored;
    property SQLHourGlass: Boolean read FSQLHourGlass write FSQLHourGlass default True;
  end;

{ TXSQLDatabase }

  TSDTransIsolation = (tiDirtyRead, tiReadCommitted, tiRepeatableRead);

  TSDDesignDBOption=(ddoIsDefaultDatabase, ddoStoreConnected{, ddoStorePassword});
  TSDDesignDBOptions = set of TSDDesignDBOption;

  TSDLoginEvent = procedure(Database: TXSQLDatabase; LoginParams: TStrings) of object;

{ TSDCustomDatabase }
{$IFNDEF XSQL_VCL5}
  TConnectChangeEvent = procedure(Sender: TObject; Connecting: Boolean) of object;
  
  TSDCustomDatabase = class(TComponent)
  private
    FDataSets: TList;
    FStreamedConnected: Boolean;	// Connected value while it's reading from stream
    FAfterConnect: TNotifyEvent;
    FAfterDisconnect: TNotifyEvent;
    FBeforeConnect: TNotifyEvent;
    FBeforeDisconnect: TNotifyEvent;
  protected
    FLoginPrompt: Boolean;  
    procedure DoConnect; virtual;
    procedure DoDisconnect; virtual;
    function GetConnected: Boolean; virtual;
    function GetDataSet(Index: Integer): TDataSet; virtual;
    function GetDataSetCount: Integer; virtual;
    procedure Loaded; override;
    procedure RegisterClient(Client: TObject; Event: TConnectChangeEvent = nil); virtual;
    procedure SetConnected(Value: Boolean); virtual;
    property StreamedConnected: Boolean read FStreamedConnected write FStreamedConnected;
    procedure UnRegisterClient(Client: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Open; virtual;
    procedure Close;
    property Connected: Boolean read GetConnected write SetConnected default False;
    property DataSets[Index: Integer]: TDataSet read GetDataSet;
    property DataSetCount: Integer read GetDataSetCount;
    property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt default False;
    property AfterConnect: TNotifyEvent read FAfterConnect write FAfterConnect;
    property BeforeConnect: TNotifyEvent read FBeforeConnect write FBeforeConnect;
    property AfterDisconnect: TNotifyEvent read FAfterDisconnect write FAfterDisconnect;
    property BeforeDisconnect: TNotifyEvent read FBeforeDisconnect write FBeforeDisconnect;
  end;
{$ELSE}
   TSDCustomDatabase = class(TCustomConnection);
{$ENDIF}

  TSDThreadTimer = class(TThread)
  private
    FDatabase: TXSQLDatabase;
    FInterval: Integer;
    FOnTimer: TNotifyEvent;
    procedure SetInterval(Value: Integer);
    procedure SetOnTimer(Value: TNotifyEvent);
  protected
    procedure Timer; dynamic;
    procedure Execute; override;
  public
    constructor Create(ADatabase: TXSQLDatabase; CreateSuspended: Boolean);
    destructor Destroy; override;
    property Interval: Integer read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
  end;

  TXSQLDatabase = class(TSDCustomDatabase)
  private
    FTransIsolation: TSDTransIsolation;
    FKeepConnection: Boolean;
    FTemporary: Boolean;
    FAcquiredHandle: Boolean;
    FParams: TStrings;
    FRefCount: Integer;			// dataset's reference count(connected dataset) to the current database
    FSession: TXSQLSession;
    FSessionName: string;
    FDatabaseName: string;

    FRemoteDatabase: string;          	// real database name on server
    FServerType: TSDServerType;		// server type
    FSqlDatabase: TISqlDatabase;
    FDesignOptions: TSDDesignDBOptions;

    FIdleTimeOut: Integer;
    FTimer: TSDThreadTimer;		// to process disconnecting when idle time has been elapsed
    FIdleTimeoutStarted: Boolean;
    FIsConnectionBusy: Boolean;		// True, in case of server long-running process (for example: a complex SQL statement is executed)

    FClientVersion: LongInt;		// client version as MajorVer.MinorVer (-1 and 0 - unloaded and undefined)
    FServerVersion: LongInt;		// server version as MajorVer.MinorVer
    FVersion: string;			// server info with full version and name

    FOnLogin: TSDLoginEvent;
    procedure CheckActive;
    procedure CheckInactive;
    procedure CheckInTransaction;
    procedure CheckNotInTransaction;
    procedure CheckDatabaseName;
    procedure CheckRemoteDatabase(var Password: string);
    procedure CheckSessionName(Required: Boolean);
    function ConnectedStored: Boolean;
    function GetHandle: PSDCursor;
    function GetIdleTimeOut: Integer;
    function GetIsSQLBased: Boolean;
    function GetInTransaction: Boolean;
    function GetVersion: string;
    function GetServerMajor: Word;
    function GetServerMinor: Word;
    function GetClientMajor: Word;
    function GetClientMinor: Word;
    procedure IdleTimerHandler(Sender: TObject);
    procedure Login(LoginParams: TStrings);
    procedure BusyStateReset(Sender: TObject);
    procedure IdleTimeOutReset(Sender: TObject);
    procedure ResetServerInfo;
    procedure SetDatabaseName(const Value: string);
    procedure SetDesignOptions(Value: TSDDesignDBOptions);    
    procedure SetHandle(Value: PSDCursor);
    procedure SetIdleTimeOut(Value: Integer);
    procedure SetKeepConnection(Value: Boolean);
    procedure SetParams(Value: TStrings);
    procedure SetRemoteDatabase(const Value: string);
    procedure SetServerType(Value: TSDServerType);
    procedure SetSessionName(const Value: string);
    procedure SetTransIsolation(Value: TSDTransIsolation);
    procedure UpdateTimer(NewTimeout: Integer);
  protected
    property SqlDatabase: TISqlDatabase read FSqlDatabase;
    property AcquiredHandle: Boolean read FAcquiredHandle;
    procedure InitSqlDatabase(const ADatabaseName, AUserName, APassword: string; AHandle: PSDCursor);
    procedure DoneSqlDatabase;
    procedure InternalClose(Force: Boolean);
  	// call server API
    procedure ISqlGetStoredProcNames(List: TStrings);
    procedure ISqlGetTableNames(Pattern: string; SystemTables: Boolean; List: TStrings);
    procedure ISqlGetFieldNames(const TableName: string; List: TStrings);
    function ISqlParamValue(Value: TXSQLDatabaseParam): Integer;
  protected
    procedure DoConnect; override;
    procedure DoDisconnect; override;
    function GetConnected: Boolean; override;
    function GetDataSet(Index: Integer): TDataSet; override;
    function GetSDDataSet(Index: Integer): TSDDataSet; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RegisterClient(Client: TObject; Event: TConnectChangeEvent = nil); override;
    procedure UnRegisterClient(Client: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyUpdates(const DataSets: array of TSDDataSet);
    procedure CloseDataSets;
    procedure Commit;
    procedure ForceClose;
    procedure GetFieldNames(const TableName: string; List: TStrings);
    procedure GetTableNames(const Pattern: string; SystemTables: Boolean; List: TStrings);
//    procedure GetProcNames(List: TStrings);
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TDataSet;
    procedure Rollback;
    procedure StartTransaction;
    function TestConnected: Boolean;
    procedure ValidateName(const Name: string);
    property DataSets[Index: Integer]: TSDDataSet read GetSDDataSet;
    property Handle: PSDCursor read GetHandle write SetHandle;
    property InTransaction: Boolean read GetInTransaction;
    property IsSQLBased: Boolean read GetIsSQLBased;
    property Session: TXSQLSession read FSession;
    property Temporary: Boolean read FTemporary write FTemporary;
    property ClientMajor: Word read GetClientMajor;
    property ClientMinor: Word read GetClientMinor;
    property ServerMajor: Word read GetServerMajor;
    property ServerMinor: Word read GetServerMinor;
    property Version: string read GetVersion;
  published
{$IFDEF XSQL_VCL5}
    property Connected stored ConnectedStored;
    property LoginPrompt default True;
{$ELSE}
    property Connected: Boolean read GetConnected write SetConnected stored ConnectedStored;
    property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt default True;
{$ENDIF}
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property DesignOptions: TSDDesignDBOptions read FDesignOptions write SetDesignOptions default [ddoStoreConnected];
    property IdleTimeOut: Integer read GetIdleTimeOut write SetIdleTimeOut;
    property KeepConnection: Boolean read FKeepConnection write SetKeepConnection default True;
    property Params: TStrings read FParams write SetParams;
    property RemoteDatabase: string read FRemoteDatabase write SetRemoteDatabase;
    property ServerType: TSDServerType read FServerType write SetServerType default stSQLBase;
    property SessionName: string read FSessionName write SetSessionName;
    property TransIsolation: TSDTransIsolation read FTransIsolation write SetTransIsolation default tiReadCommitted;
    property AfterConnect;
    property AfterDisconnect;
    property BeforeConnect;
    property BeforeDisconnect;
    property OnLogin: TSDLoginEvent read FOnLogin write FOnLogin;
  end;

{ TSDResultSet }

  PCacheRecInfo = ^TCacheRecInfo;
  TCacheRecInfo = record
    Applied: Boolean;
    CurRec: TSDRecordBuffer;
    OldRec: TSDRecordBuffer;
  end;

  TSDResultSet = class(TList)
  private
    FDataSet: TSDDataSet;
    FIsBlobs: Boolean;
    FPosition: Integer;		// current record index, zero-based
    FDeletedCount: Integer;	// number of rescords, which are marked as deleted
    FAllInCache: Boolean;
    function GetAppliedRecords(Index: Integer): Boolean;
    function GetCacheItem(Index: Integer): TCacheRecInfo;
    function GetCurRecords(Index: Integer): TSDRecordBuffer;
    function GetOldRecords(Index: Integer): TSDRecordBuffer;
    function GetUpdateStatusRecords(Index: Integer): TUpdateStatus;
    function GetFilterActivated: Boolean;
    function GetRecordCount: Integer;
    function GetIndexOfRecord(ARecNumber: Integer): Integer;
    function GetNewRecordNumber(AInsertedRecIndex: Integer): Integer;
    procedure SetAppliedRecords(Index: Integer; Value: Boolean);
    procedure SetCacheItem(Index: Integer; Value: TCacheRecInfo);
    procedure SetCurRecords(Index: Integer; Value: TSDRecordBuffer);
    procedure SetOldRecords(Index: Integer; Value: TSDRecordBuffer);
    procedure SetUpdateStatusRecords(Index: Integer; Value: TUpdateStatus);
  private
    function AddRecord(RecBuf: TSDRecordBuffer): Integer;
    procedure CopyRecBuf(const Source, Dest: TSDRecordBuffer);
    procedure ClearCacheItem(Index: Integer);
    procedure DeleteCacheItem(Index: Integer);
    function FetchRecord: Boolean;
    function GetCurrRecord: Boolean;
    function GetNextRecord: Boolean;
    function GetPriorRecord: Boolean;
    function GetRecord(Buffer: TSDRecordBuffer; GetMode: TGetMode): Boolean;
    function GotoNextRecord: Boolean;
    function IsVisibleRecord(Index: Integer): Boolean;
    function DeleteRecord(RecBuf: TSDRecordBuffer): Integer;
    function IsInsertedRecord(Index: Integer): Boolean;
    function InsertRecord(RecBuf: TSDRecordBuffer; Append, SetCurrent: Boolean): Integer;
    procedure ModifyRecord(RecBuf: TSDRecordBuffer);
    procedure ModifyBlobData(Field: TField; RecBuf: TSDRecordBuffer; const Value: TSDBlobData);
    function RecordFilter(RecBuf: TSDRecordBuffer): Boolean;
    function UpdatesCancel: Integer;
    function UpdatesCancelCurrent: Integer;
    function UpdatesCommit: Integer;
    function UpdatesPrepare: Integer;
    function UpdatesRollback: Integer;
  public
    constructor Create(ADataSet: TSDDataSet; IsBlobs: Boolean);
    destructor Destroy; override;
    procedure Clear; {$IFDEF XSQL_VCL4} override; {$ENDIF} {$IFDEF XSQL_C3} override; {$ENDIF}
    function UpdatesCommitRecord(Index: Integer): Boolean;
    procedure ExchangeRecords(Index1, Index2: Integer);
    procedure FetchAll;
    function FindNextRecord: Boolean;
    function FindPriorRecord: Boolean;
    procedure SetToBegin;
    procedure SetToEnd;
    function IndexOfRecord(RecBuf: TSDRecordBuffer): Integer;
    property AllInCache: Boolean read FAllInCache;
    property AppliedRecords[Index: Integer]: Boolean read GetAppliedRecords write SetAppliedRecords;
    property CacheItems[Index: Integer]: TCacheRecInfo read GetCacheItem write SetCacheItem;
    property CurRecords[Index: Integer]: TSDRecordBuffer read GetCurRecords write SetCurRecords; default;
    property OldRecords[Index: Integer]: TSDRecordBuffer read GetOldRecords write SetOldRecords;
    property DataSet: TSDDataSet read FDataSet;
    property UpdateStatusRecords[Index: Integer]: TUpdateStatus read GetUpdateStatusRecords write SetUpdateStatusRecords;
    property CurrentIndex: Integer read FPosition write FPosition;
    property RecordCount: Integer read GetRecordCount;
    property FilterActivated: Boolean read GetFilterActivated;
  end;

{ TSDDataSet }
  TSDRecInfo = packed record
    RecordNumber: LongInt;		// it is set after fetch from a database, starts from 0 (and = RecNo-1)
    UpdateStatus: TUpdateStatus; 	// (usUnmodified, usModified, usInserted, usDeleted)
    BookmarkFlag: TBookmarkFlag;
  end;
  PSDRecInfo = ^TSDRecInfo;

  TFieldIsNotNull = Boolean;		// 1-st byte of a field buffer
  PFieldIsNotNull = ^TFieldIsNotNull;

  TDelayedUpdCmd = (                 { Op types for Delayed Update cursor }
    DelayedUpdCommit,                { Commit the updates }
    DelayedUpdCancel,                { Cancel the updates (all record changes) }
    DelayedUpdCancelCurrent,         { Cancel the Current Rec Change }
    DelayedUpdPrepare,               { Phase1 of 2 phase commit }
    DelayedUpdRollback               { Rollback the updates, but keep the changes: Phase2 of 2 phase rollback }
  );

  TDSFlags = set of 0..15;		{ set of TSDDataSet flags}

{$IFNDEF XSQL_VCL5}	// to exclude ambiguous reference in BCB5+, when set OnUpdateRecord event handler
  TUpdateAction = (uaFail, uaAbort, uaSkip, uaRetry, uaApplied);
{$ENDIF}
{$IFNDEF XSQL_VCL4}
  TUpdateMode = (upWhereAll, upWhereChanged, upWhereKeyOnly);
{$ENDIF}
  TUpdateKinds	= set of TUpdateKind;
  TUpdateRecordTypes = set of (rtModified, rtInserted, rtDeleted, rtUnmodified);
  TUpdateErrorEvent = procedure(DataSet: TDataSet; E: EDatabaseError;
    UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction) of object;
  TUpdateRecordEvent = procedure(DataSet: TDataSet; UpdateKind: TUpdateKind;
    var UpdateAction: TUpdateAction) of object;

  TSDDataSetUpdateObject = class(TComponent)
  protected
    function GetDataSet: TSDDataSet; virtual; abstract;
    procedure SetDataSet(ADataSet: TSDDataSet); virtual; abstract;
  public
    procedure Apply(UpdateKind: TUpdateKind); virtual; abstract;
    property DataSet: TSDDataSet read GetDataSet write SetDataSet;
  end;


  TSDDataSet = class(TDataSet)
  private
    FAutoRefresh: Boolean;
    FDSFlags: TDSFlags;
    FDatabase: TXSQLDatabase;
    FDatabaseName: string;
    FSessionName: string;
    FSqlCmd: TISqlCommand;
    FRecCache: TSDResultSet;
    FFieldBufOffs: TIntArray;		// Offsets to field's buffer in a record buffer
    FClearFieldDefsOnClose: Boolean;    // if a result set was activated using OpenEmpty method and FieldDefs initializes from persistent Fields
    FCachedUpdates: Boolean;
    FCacheBlobs: Boolean;
    FUniDirectional: Boolean;
    FDetachOnFetchAll: Boolean;		// drop a server cursor, when entire result set is on client side, to minimize server resources
    FFilterBuffer: TSDRecordBuffer;
    FForceClosing: Boolean;		// hide database exceptions in this case
    FGetNextResultSet: Boolean;		// in process of getting NextResultSet
    FRecordSize: Integer;  		// record size (without additional info and BLOB-pointers)
    FRecBufSize: Integer;  		// record size with additional info
    FBlobCacheOffs: Integer;		// BLOB-cache offset in record buffer
    FRecInfoOffs: Integer; 		// TSDRecInfo offset in record buffer
    FBookmarkOffs: Integer;             // TBookmark offset in record buffer
    FEnableUpdateKinds: TUpdateKinds;	// what updates(modify, insert, delete) are enabled
    FUpdateMode: TUpdateMode;
    FUpdateObject: TSDDataSetUpdateObject;
    FUpdateRecordTypes: TUpdateRecordTypes;	// set of record types, which are visible in a dataset in CachedUpdates mode
    FOnUpdateError: TUpdateErrorEvent;
    FOnUpdateRecord: TUpdateRecordEvent;
    procedure CheckDBSessionName;
    procedure ClearBlobCache(RecBuf: TSDRecordBuffer);
    procedure DoInternalOpen(IsExec: Boolean);    
    procedure InitBlobCache(RecBuf: TSDRecordBuffer);
    function FieldIsNull(FieldBuf: TSDPtr): Boolean;
    procedure FieldSetNull(FieldBuf: TSDPtr; bNull: Boolean);
    function GetActiveRecBuf(var RecBuf: TSDRecordBuffer): Boolean;
    function GetBlobData(Field: TField; Buffer: TSDRecordBuffer): TSDBlobData;
    function GetBlobDataSize(Field: TField; Buffer: TSDRecordBuffer): Integer;
    function GetHandle: PSDCursor;
    function GetOldRecord: TSDRecordBuffer;
    function GetServerType: TSDServerType;
    function GetDBSession: TXSQLSession;
    function GetEnableUpdateKinds: TUpdateKinds;
    function GetUpdatesPending: Boolean;
    function GetUpdateRecordSet: TUpdateRecordTypes;
    procedure InitBufferPointers;
    function RecordFilter(RecBuf: TSDRecordBuffer): Boolean;
    procedure SetAutoRefresh(const Value: Boolean);
    procedure SetBlobData(Field: TField; Buffer: TSDRecordBuffer; Value: TSDBlobData);
    procedure SetDatabaseName(const Value: string);
    procedure SetDetachOnFetchAll(Value: Boolean);
    procedure SetSessionName(const Value: string);
    procedure SetEnableUpdateKinds(Value: TUpdateKinds);
    procedure SetUniDirectional(const Value: Boolean);
    procedure SetUpdateMode(const Value: TUpdateMode); virtual;
    procedure SetUpdateRecordSet(RecordTypes: TUpdateRecordTypes);
    procedure SetUpdateObject(Value: TSDDataSetUpdateObject);
  protected
    property RecCache: TSDResultSet read FRecCache;
    property SqlCmd: TISqlCommand read FSqlCmd;
  	{ The following methods use TISqlComand object }
    function ISqlCmdCreate: TISqlCommand; virtual;
    procedure ISqlCloseResultSet;
    procedure ISqlCnvtFieldData(ASqlCmd: TISqlCommand; AFieldDesc: TSDFieldDesc;
    				Buffer: TSDRecordBuffer; AField: TField);
    procedure ISqlCnvtFieldsBuffer(Buffer: TSDRecordBuffer);
    function ISqlConnected: Boolean;
    procedure ISqlDetach;
    procedure ISqlExecDirect(Value: string);
    procedure ISqlExecute;
    function ISqlFetch: Boolean;
    procedure ISqlInitFieldDefs;
    procedure ISqlPrepare(Value: string);
    function ISqlPrepared: Boolean;
    function ISqlGetRowsAffected: Integer;
    function ISqlWriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint;
    function ISqlWriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint;
  private
    procedure CacheInit;
    procedure CacheDone;
{$IFDEF XSQL_VCL4}
    function CacheTempBuffer: TSDRecordBuffer;	// it's used in BlockReadNext method only(now)
{$ENDIF}
  protected
{$IFDEF XSQL_VCL5}
    FExprFilter: TSDExprParser;
    function CreateExprFilter(const Text: string; Options: TFilterOptions): TSDExprParser;
    { IProviderSupport }
    procedure PSEndTransaction(Commit: Boolean); override;
    function PSExecuteStatement(const ASQL: string; AParams: TParams; {$IFDEF XSQL_CLR} var ResultSet: TObject {$ELSE} ResultSet: TSDPtr = nil {$ENDIF}): Integer; override;
    function PSGetQuoteChar: string; override;
    function PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError; override;
    function PSInTransaction: Boolean; override;
    function PSIsSQLBased: Boolean; override;
    function PSIsSQLSupported: Boolean; override;
    procedure PSReset; override;
    procedure PSStartTransaction; override;
    function PSUpdateRecord(UpdateKind: TUpdateKind; Delta: TDataSet): Boolean; override;
{$ENDIF}
    function AllocRecordBuffer: TSDRecordBuffer; override;
    procedure DestroySqlCommand(Force: Boolean);
    procedure ForceClose;
    procedure FreeRecordBuffer(var Buffer: TSDRecordBuffer); override;
{$IFNDEF XSQL_VCL5}
    function BCDToCurr(BCD: TSDPtr; var Curr: Currency): Boolean; override;
    function CurrToBCD(const Curr: Currency; BCD: TSDPtr; Precision, Decimals: Integer): Boolean; override;
    procedure SetDefaultFields(const Value: Boolean);
    procedure UpdateBufferCount;
{$ENDIF}
    procedure CheckCachedUpdateMode;
    procedure CheckCanModify;
    procedure CheckDatabaseName;
    procedure ClearCalcFields(Buffer: TSDRecordBuffer); override;
    procedure CloseCursor; override;
    procedure ClearFieldDefs;
    procedure CreateHandle; virtual; abstract;
    procedure DataEvent(Event: TDataEvent; Info: {$IFDEF XSQL_CLR} TObject {$ELSE} Longint {$ENDIF}); override;
    procedure DestroyHandle; virtual;
    function FindRecord(Restart, GoForward: Boolean): Boolean; override;
    procedure GetBookmarkData(Buffer: TSDRecordBuffer; {$IFDEF XSQL_CLR} var Data: TBookmark {$ELSE} Data: TSDPtr {$ENDIF}); override;
    function GetBookmarkFlag(Buffer: TSDRecordBuffer): TBookmarkFlag; override;
    function GetBufferCount: Integer;
    function GetCanModify: Boolean; override;
    function GetFieldBuffer(AFieldNo: Integer; RecBuf: TSDRecordBuffer): TSDValueBuffer;
    function GetFieldDataSize(Field: TField): Integer;
{$IFNDEF XSQL_VCL4}
    function GetFieldData(Field: TField; Buffer: TSDValueBuffer): Boolean; override;
{$ENDIF}
    function GetRecNo: Integer; override;
    function GetRecord(Buffer: TSDRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    function GetRecordCount: LongInt; override;
    function GetRecordSize: Word; override;
    function GetRecordUpdateStatus: TUpdateStatus;
    procedure SetRecordUpdateStatus(Value: TUpdateStatus);
    procedure InitRecord(Buffer: TSDRecordBuffer); override;
    procedure InitResultSet;
    procedure InternalAddRecord(Buffer: TSDPtr; Append: Boolean); override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark({$IFDEF XSQL_CLR} const {$ENDIF} Bookmark: TBookmark); override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInitRecord(Buffer: TSDRecordBuffer); override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalRefresh; override;
    procedure InternalSetToRecord(Buffer: TSDRecordBuffer); override;
    function IsCursorOpen: Boolean; override;
    procedure DoneResultSet;
    function DoLocateRecord(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions; SyncCursor, NextLocate: Boolean): Integer;
    procedure DoRefreshRecord(const ARefreshSQL: string); virtual;
    procedure DoSortRecords(AFields: array of Integer; AscOrder, CaseSensitive: array of Boolean); virtual;
    procedure LiveApplyRecord(OpMode: TUpdateStatus; const ASQL, ATableName, ARefreshSQL: string);
    procedure LiveInternalPost(IsDelete: Boolean; const ASQL, ATableName: string);
    function MapsToIndex(Fields: TList; CaseInsensitive: Boolean): Boolean;
    procedure SetConnectionState(IsBusy: Boolean);
    procedure SetBookmarkData(Buffer: TSDRecordBuffer; {$IFDEF XSQL_CLR} const Data: TBookmark {$ELSE} Data: TSDPtr {$ENDIF}); override;
    procedure SetBookmarkFlag(Buffer: TSDRecordBuffer; Value: TBookmarkFlag); override;
{$IFDEF XSQL_VCL4}
    procedure BlockReadNext; override;
    procedure SetBlockReadSize(Value: Integer); override;
{$ENDIF}
    procedure SetFieldData(Field: TField; Buffer: TSDPtr); override;
    procedure SetFilterData(const Text: string; Options: TFilterOptions);
    procedure SetFiltered(Value: Boolean); override;
    procedure SetFilterOptions(Value: TFilterOptions); override;
    procedure SetFilterText(const Value: string); override;
    procedure SetRecNo(Value: Integer); override;
    procedure OpenCursor(InfoQuery: Boolean); override;
    procedure ExecuteCursor; virtual;
    function ProcessUpdates(UpdCmd: TDelayedUpdCmd): Integer;
    function SetDSFlag(Flag: Integer; Value: Boolean): Boolean; virtual;
    procedure SetOnFilterRecord(const Value: TFilterRecordEvent); override;
    property CachedUpdates: Boolean read FCachedUpdates write FCachedUpdates;
    property DSFlags: TDSFlags read FDSFlags;
    property ServerType: TSDServerType read GetServerType;
    property UpdateMode: TUpdateMode read FUpdateMode write SetUpdateMode default upWhereAll;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Disconnect; virtual;
    procedure ApplyUpdates;
    procedure CancelUpdates;
    procedure CommitUpdates;
    procedure RollbackUpdates;
    function BookmarkValid({$IFDEF XSQL_CLR} const {$ENDIF} Bookmark: TBookmark): Boolean; override;
    function CompareBookmarks({$IFDEF XSQL_CLR} const {$ENDIF} Bookmark1, Bookmark2: TBookmark): Integer; override;
    function CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream; override;
    procedure Detach;
    procedure FetchAll;
    procedure OpenEmpty;
    function OpenDatabase: TXSQLDatabase;
    procedure CloseDatabase(Database: TXSQLDatabase);
    procedure GetFieldInfoFromSQL(const ASQL: string; FldInfo, TblInfo: TStrings);
    function GetCurrentRecord(Buffer: TSDRecordBuffer): Boolean; override;
{$IFDEF XSQL_VCL4}
    function GetFieldData(Field: TField; Buffer: TSDPtr): Boolean; overload; override;
{$ENDIF}
    function IsSequenced: Boolean; override;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean; override;
    function LocateNext(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean;
    function Lookup(const KeyFields: string; const KeyValues: Variant;
      const ResultFields: string): Variant; override;
    procedure RefreshRecord; virtual;
    procedure RefreshRecordEx(const ARefreshSQL: string); virtual;
    procedure RevertRecord;
    procedure SortRecords(AFields: array of const; AscOrder, ACaseSensitive: array of Boolean); overload;
    procedure SortRecords(const AFields, AscOrder, ACaseSensitive: string); overload;
    function UpdateStatus: TUpdateStatus; {$IFDEF XSQL_VCL4} override; {$ENDIF}
    property CacheBlobs: Boolean read FCacheBlobs write FCacheBlobs default True;
    property Database: TXSQLDatabase read FDatabase;
    property DBSession: TXSQLSession read GetDBSession;
    property EnableUpdateKinds: TUpdateKinds read GetEnableUpdateKinds write SetEnableUpdateKinds;
    property Handle: PSDCursor read GetHandle;
    property UniDirectional: Boolean read FUniDirectional write SetUniDirectional default False;
    property UpdateObject: TSDDataSetUpdateObject read FUpdateObject write SetUpdateObject;
    property UpdatesPending: Boolean read GetUpdatesPending;
    property UpdateRecordTypes: TUpdateRecordTypes read GetUpdateRecordSet write SetUpdateRecordSet;
  published
    property AutoRefresh: Boolean read FAutoRefresh write SetAutoRefresh default False;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property DetachOnFetchAll: Boolean read FDetachOnFetchAll write SetDetachOnFetchAll default False;
    property SessionName: string read FSessionName write SetSessionName;
    property OnUpdateError: TUpdateErrorEvent read FOnUpdateError write FOnUpdateError;
    property OnUpdateRecord: TUpdateRecordEvent read FOnUpdateRecord write FOnUpdateRecord;
  published
    property Active;
    property AutoCalcFields;
    property Filter;
    property Filtered;
    property FilterOptions;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
  end;

{ TXSQLQuery }

  TXSQLQuery = class(TSDDataSet)
  private
    FDataLink: TDataLink;
    FParams: TSDHelperParams;
    FPrepared: Boolean;
    FExecCmd: Boolean;          // to exclude repeated execution in ExecuteCursor after CreateHandle call
    FSQL: TStrings;
    FText: string;		// it's assigned to FSQL.Text in QueryChanged
    FParamCheck: Boolean;
    FRowsAffected: Integer;
    FRequestLive: Boolean;	// query must be single table w/o <group by> and <union> clauses
    FTableName: string;		// RequestLive mode
    FIndexFields: TStrings;	// field list of unique index
    function GetRowsAffected: Integer;
    procedure QueryChanged(Sender: TObject);
    procedure ReleaseHandle(SaveRes: Boolean);
    procedure RefreshParams;
    procedure SetDataSource(Value: TDataSource);
    procedure SetParamsFromCursor;
    procedure SetParamsList(Value: TSDHelperParams);
    procedure SetPrepareCmd(Value, GenCursor: Boolean);
    procedure SetPrepared(Value: Boolean);
    procedure SetRequestLive(Value: Boolean);
    procedure SetUpdateMode(const Value: TUpdateMode); override;
{$IFDEF XSQL_VCL4}
  private
    procedure ReadParamData(Reader: TReader);
    procedure WriteParamData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
{$ENDIF}
  protected
    function ISqlCmdCreate: TISqlCommand; override;
  protected
{$IFDEF XSQL_VCL5}
    { IProviderSupport }
    procedure PSExecute; override;
    function PSGetParams: TParams; override;
    function PSGetTableName: string; override;
    procedure PSSetCommandText(const CommandText: string); override;
    procedure PSSetParams(AParams: TParams); override;
{$ENDIF}
    procedure CreateHandle; override;
    procedure DoBeforeOpen; override;
    function GetCanModify: Boolean; override;
    function GetDataSource: TDataSource; override;
    function GetIsIndexField(Field: TField): Boolean; override;
    function GetParamsCount: Word;
    procedure InternalDelete; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    function IsExecDirect: Boolean;
    procedure ExecuteCursor; override;
    function SetDSFlag(Flag: Integer; Value: Boolean): Boolean; override;
    procedure SetQuery(Value: TStrings); virtual;
    procedure UpdateUniqueIndexInfo;
    procedure SetSqlCmd(Value: TISqlCommand);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Disconnect; override;
    procedure ExecSQL;
{$IFDEF XSQL_VCL4}
    procedure GetDetailLinkFields(MasterFields, DetailFields: TObjectList); override;
{$ENDIF}
    function ParamByName(const Value: string): TSDHelperParam;
    procedure Prepare;
    procedure UnPrepare;
    procedure RefreshRecord; override;
    property Prepared: Boolean read FPrepared write SetPrepared;
    property ParamCount: Word read GetParamsCount;
    property Text: string read FText;
    property RowsAffected: Integer read GetRowsAffected;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ParamCheck: Boolean read FParamCheck write FParamCheck default True;
    property Params: TSDHelperParams read FParams write SetParamsList {$IFDEF XSQL_VCL4} stored False {$ENDIF};
    property RequestLive: Boolean read FRequestLive write SetRequestLive default False;
    property SQL: TStrings read FSQL write SetQuery;
    property UniDirectional;
    property UpdateMode;
    property UpdateObject;
  end;

{ TXSQLMacroQuery }
  TXSQLMacroQuery = class(TXSQLQuery)
  private
    FMacroChar: Char;
    FMacros: TSDHelperParams;
    FMacrosExpanding: Boolean;
    FSQLPattern: TStrings;		// (unexpanded) statement with macros
    FSaveQueryChanged: TNotifyEvent;
    function GetMacros: TSDHelperParams;
    function GetMacroCount: Word;
    procedure PatternChanged(Sender: TObject);
    procedure QueryChanged(Sender: TObject);
    procedure CreateMacros;
    procedure SetMacroChar(const Value: Char);
    procedure SetMacros(const Value: TSDHelperParams);
{$IFDEF XSQL_VCL4}
  private
    procedure ReadMacroData(Reader: TReader);
    procedure WriteMacroData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
{$ENDIF}
  protected
    function SetDSFlag(Flag: Integer; Value: Boolean): Boolean; override;
    procedure SetQuery(Value: TStrings); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExpandMacros;
    function MacroByName(const MacroName: string): TSDHelperParam;
  published
    property MacroChar: Char read FMacroChar write SetMacroChar default DefaultQueryMacroChar;
    property MacroCount: Word read GetMacroCount;
    property Macros: TSDHelperParams read GetMacros write SetMacros {$IFDEF XSQL_VCL4} stored False {$ENDIF};
    property SQL: TStrings read FSQLPattern write SetQuery;
  end;

{ TXSQLUpdateSql }

  TXSQLUpdateSql = class(TSDDataSetUpdateObject)
  private
    FDataSet: TSDDataSet;
    FQueries: array[TUpdateStatus] of TXSQLQuery;
    FSQLText: array[TUpdateStatus] of TStrings;
    function GetSQL(StmtKind: TUpdateStatus): TStrings;
    function GetSQLIndex(Index: Integer): TStrings;
    procedure SetSQL(StmtKind: TUpdateStatus; Value: TStrings);
    procedure SetSQLIndex(Index: Integer; Value: TStrings);
  protected
    function GetDataSet: TSDDataSet; override;
    function GetQuery(UpdateKind: TUpdateKind): TXSQLQuery;
    function GetQueryEx(StmtKind: TUpdateStatus): TXSQLQuery; virtual;
    procedure SetDataSet(ADataSet: TSDDataSet); override;
    procedure SQLChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Apply(UpdateKind: TUpdateKind); override;
    procedure ExecSQL(UpdateKind: TUpdateKind);
    procedure SetParams(UpdateKind: TUpdateKind);
    property DataSet;
    property Query[UpdateKind: TUpdateKind]: TXSQLQuery read GetQuery;
    property SQL[StmtKind: TUpdateStatus]: TStrings read GetSQL write SetSQL;
    property QueryEx[StmtKind: TUpdateStatus]: TXSQLQuery read GetQueryEx;
  published
    property RefreshSQL:TStrings index 0 read GetSQLIndex write SetSQLIndex;
    property ModifySQL: TStrings index 1 read GetSQLIndex write SetSQLIndex;
    property InsertSQL: TStrings index 2 read GetSQLIndex write SetSQLIndex;
    property DeleteSQL: TStrings index 3 read GetSQLIndex write SetSQLIndex;
  end;


{ TSDBlobStream }

  TSDBlobStream = class(TStream)
  private
    FField: TBlobField;
    FDataSet: TSDDataSet;
    FBuffer: TSDRecordBuffer;    		// record buffer
    FMode: TBlobStreamMode;
    FFieldNo: Integer;
    FOpened: Boolean;
    FModified: Boolean;
    FPosition: LongInt;
    FBlobData: TSDBlobData;
    FBlobSize: LongInt;
    FCached: Boolean;		// if BLOB into memory
    FCacheSize: LongInt;
    function GetBlobSize: LongInt;
  protected
    procedure SetSize(NewSize: {$IFDEF XSQL_CLR}Int64 {$ELSE} Longint {$ENDIF}); override;
  public
    constructor Create(Field: TBlobField; Mode: TBlobStreamMode);
    destructor Destroy; override;
    function Read(var Buffer {$IFDEF XSQL_CLR} :TBytes; Offset,{$ELSE}; {$ENDIF} Count: Longint): Longint; override;
    function Write(const Buffer {$IFDEF XSQL_CLR} :TBytes; Offset,{$ELSE}; {$ENDIF} Count: Longint): Longint; override;
{$IFDEF XSQL_CLR}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
{$ELSE}
    function Seek(Offset: Longint; Origin: Word): Longint; override;
{$ENDIF}
    procedure Truncate;
  end;

{ TXSQLStoredProc }

  TXSQLStoredProc = class(TSDDataSet)
  private
    FProcName: string;
    FParams: TSDHelperParams;
    FOverLoad: Word;
    FPrepared: Boolean;
    FQueryMode: Boolean;
    FExecCmd: Boolean;          // to exclude repeated execution in ExecuteCursor after CreateHandle call    
    procedure ReleaseHandle(SaveRes: Boolean);    
    procedure SetParamsList(Value: TSDHelperParams);
{$IFDEF XSQL_VCL4}
  private
    procedure ReadParamData(Reader: TReader);
    procedure WriteParamData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
{$ENDIF}
  protected
{$IFDEF XSQL_VCL5}
    { IProviderSupport }
    procedure PSExecute; override;
    function PSGetTableName: string; override;
    function PSGetParams: TParams; override;
    procedure PSSetCommandText(const CommandText: string); override;
    procedure PSSetParams(AParams: TParams); override;
{$ENDIF}
    procedure BindParams;
    procedure CreateHandle; override;
    procedure CreateParamDesc;
    procedure CloseCursor; override;
    procedure ExecuteCursor; override;
    procedure InternalOpen; override;
    function IsExecDirect: Boolean;
    function GetParamsCount: Word;
    function SetDSFlag(Flag: Integer; Value: Boolean): Boolean; override;
    procedure SetOverLoad(Value: Word);
    procedure SetProcName(const Value: string);
    procedure SetPrepared(Value: Boolean);
    procedure SetPrepareCmd(Value, GenCursor: Boolean);
  protected
    function ISqlCmdCreate: TISqlCommand; override;
    function ISqlDescriptionsAvailable: Boolean;
    function ISqlNextResultSet: Boolean;
    procedure ISqlPrepareProc;
    procedure ISqlExecProc;
    procedure ISqlExecProcDirect;
    procedure ISqlGetResults;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Disconnect; override;
    procedure CopyParams(Value: TSDHelperParams);
    function DescriptionsAvailable: Boolean;
    procedure ExecProc;
    procedure GetResults;
    function NextResultSet: Boolean;
    function ParamByName(const Value: string): TSDHelperParam;
    procedure Prepare;
    procedure UnPrepare;
    property ParamCount: Word read GetParamsCount;
    property Prepared: Boolean read FPrepared write SetPrepared;
  published
    property StoredProcName: string read FProcName write SetProcName;
    property Overload: Word read FOverload write SetOverload default 0;
    property Params: TSDHelperParams read FParams write SetParamsList {$IFDEF XSQL_VCL4} stored False {$ENDIF};
    property UpdateObject;
  end;

{ TXSQLTable }
  TIndexDesc = record
    Name   	:string;       // Index name
    Fields	:string;       // list of all fields in the key
    DescFields	:string;       // list of descending fields
    iFldsInKey  :Word;         // Fields in the key
    bPrimary    :WordBool;     // True, if primary index
    bUnique     :WordBool;     // True, if unique keys
  end;
  TIndexDescArray = array {$IFNDEF XSQL_VCL4}[0..0]{$ENDIF} of TIndexDesc;      // Delphi 3 does not support dynamic arrays

  TXSQLTable = class(TSDDataSet)
{$IFDEF XSQL_VCL5}
  private
    FTableName: string;
    FOrderByFields: string;
    FWhereText: string;
    FFieldsIndex: Boolean; 	// FFieldsIndex is True, if IndexName is activated else IndexFieldNames is active
    FDefaultIndex: Boolean;
    FIndexDefs: TIndexDefs;
    FMasterLink: TMasterDataLink;
    FIndexName: string;
    FIndexDescs: TIndexDescArray;	// index descriptions
    FIndexFieldMap: array of Integer;	// FIndexFieldMap[Field Index in the current index] = FieldNo
    FIndexFieldCount: Integer;
    FStoreDefs: Boolean;
    FReadOnly: Boolean;
    FParams: TSDHelperParams;
    FQuoteIdent: Boolean;

    procedure CheckMasterRange;
    function FieldDefsStored: Boolean;
    function GetExists: Boolean;
    function GetIndexFieldNames: string;
    function GetIndexName: string;
    function GetFieldListWithDesc(const AFields, ADescFields: string): string;
    function GetMasterFields: string;
    function ReplaceSemicolon2Comma(const AStr: string): string;
    function IndexDefsStored: Boolean;
    procedure MasterChanged(Sender: TObject);
    procedure MasterDisabled(Sender: TObject);
    procedure RefreshParams;
    procedure ReleaseHandle(SaveRes: Boolean);
    procedure SetDataSource(Value: TDataSource);
    procedure SetIndexField(Index: Integer; Value: TField);
    procedure SetIndexDefs(Value: TIndexDefs);
    procedure SetIndexFieldNames(const Value: string);
    procedure SetIndex(const Value: string; FieldsIndex: Boolean);
    procedure SetIndexName(const Value: string);
    procedure SetMasterFields(const Value: string);
    procedure SetReadOnly(Value: Boolean);
    procedure SetTableName(const Value: string);
    procedure SetLinkRanges(MasterFields: TList);
    procedure SetParamsFromMasterDataSet;
    procedure ApplyRange;
    procedure CancelRange;
    procedure UpdateRange;
  protected
    { IProviderSupport }
{    function PSGetDefaultOrder: TIndexDef; override;
    function PSGetKeyFields: string; override;
    function PSGetTableName: string; override;
    function PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs; override;
    procedure PSSetCommandText(const CommandText: string); override;
    procedure PSSetParams(AParams: TParams); override;}
  protected
    function ISqlCmdCreate: TISqlCommand; override;
    procedure ISqlDeleteTable;
    procedure ISqlEmptyTable;

    procedure CreateHandle; override;
    procedure ExecuteCursor; override;
    procedure DataEvent(Event: TDataEvent; Info: {$IFDEF XSQL_CLR} TObject {$ELSE} Longint {$ENDIF}); override;
    procedure DoOnNewRecord; override;    
    function GenOrderBy: string;
    function GetCanModify: Boolean; override;
    function GetCurrentIndex: Integer;
    function GetDataSource: TDataSource; override;
    function GetIndexField(Index: Integer): TField;
    function GetIndexFieldCount: Integer;
    function GetIsIndexField(Field: TField): Boolean; override;
    function GetSQLText: string;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalPost; override;
    procedure InternalOpen; override;
    procedure SwitchToIndex;
    procedure ClearIndexDescs;
    procedure UpdateIndexDescs;
    procedure UpdateIndexDefs; override;
    property MasterLink: TMasterDataLink read FMasterLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateTable;
    procedure DeleteTable;
    procedure EmptyTable;
    procedure GetIndexNames(List: TStrings);
    property Exists: Boolean read GetExists;
    property IndexFieldCount: Integer read GetIndexFieldCount;
    property IndexFields[Index: Integer]: TField read GetIndexField write SetIndexField;
  published
    property DefaultIndex: Boolean read FDefaultIndex write FDefaultIndex default True;
    property FieldDefs stored FieldDefsStored;
    property IndexDefs: TIndexDefs read FIndexDefs write SetIndexDefs stored IndexDefsStored;
    property IndexFieldNames: string read GetIndexFieldNames write SetIndexFieldNames;
    property IndexName: string read GetIndexName write SetIndexName;
    property MasterFields: string read GetMasterFields write SetMasterFields;
    property MasterSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property StoreDefs: Boolean read FStoreDefs write FStoreDefs default False;
    property TableName: string read FTableName write  SetTableName;    
{$ENDIF}
  published
    property UpdateMode;
    property UpdateObject;
  end;

{ TXSQLScript }
  TXSQLScript = class(TComponent)
  private
    FSQL: TStrings;                     // statements with expanded macros
    FSQLPattern: TStrings;		// (unexpanded) statements with macros
    FParamCheck: Boolean;
    FParams: TSDHelperParams;
    FQuery: TXSQLQuery;
    FIgnoreParams: Boolean;             // parameters of query are not assigned
    FTermChar: Char;
    FMacroChar: Char;
    FMacros: TSDHelperParams;
    FMacroCheck: Boolean;             // do not parse macros
    FTransaction: Boolean;
    FBeforeExecute: TNotifyEvent;
    FAfterExecute: TNotifyEvent;
    function GetDatabase: TXSQLDatabase;
    function GetDatabaseName: string;
    function GetMacros: TSDHelperParams;
    function GetMacroCount: Word;
    function GetParamsCount: Integer;
    function GetDBSession: TXSQLSession;
    function GetSessionName: string;
    function GetText: string;
    procedure CreateMacros;
    procedure PatternChanged(Sender: TObject);
    procedure SetDatabaseName(const Value: string);
    procedure SetMacroChar(const Value: Char);
    procedure SetMacros(const Value: TSDHelperParams);
    procedure SetParamsList(const Value: TSDHelperParams);
    procedure SetQuery(const Value: TStrings);
    procedure SetSessionName(const Value: string);
{$IFDEF XSQL_VCL4}
  private
    procedure ReadParamData(Reader: TReader);
    procedure WriteParamData(Writer: TWriter);
    procedure ReadMacroData(Reader: TReader);
    procedure WriteMacroData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
{$ENDIF}
  protected
    procedure CheckExecQuery(LineNo, StatementNo: Integer);
    procedure ExecuteScript(StatementNo: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecSQL;
    procedure ExpandMacros;
    function MacroByName(const MacroName: string): TSDHelperParam;
    function ParamByName(const Value: string): TSDHelperParam;
    property DBSession: TXSQLSession read GetDBSession;
    property Database: TXSQLDatabase read GetDatabase;
    property ParamCount: Integer read GetParamsCount;
    property Text: string read GetText;
  published
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    property IgnoreParams: Boolean read FIgnoreParams write FIgnoreParams default False;
    property MacroChar: Char read FMacroChar write SetMacroChar default DefaultQueryMacroChar;
    property MacroCheck: Boolean read FMacroCheck write FMacroCheck default True;
    property MacroCount: Word read GetMacroCount;
    property Macros: TSDHelperParams read GetMacros write SetMacros {$IFDEF XSQL_VCL4} stored False {$ENDIF};
    property TermChar: Char read FTermChar write FTermChar default DefaultScriptTermChar;
    property SessionName: string read GetSessionName write SetSessionName;
    property SQL: TStrings read FSQLPattern write SetQuery;
    property ParamCheck: Boolean read FParamCheck write FParamCheck default True;
    property Params: TSDHelperParams read FParams write SetParamsList {$IFDEF XSQL_VCL4} stored False {$ENDIF};
    property Transaction: Boolean read FTransaction write FTransaction;
    property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
    property AfterExecute: TNotifyEvent read FAfterExecute write FAfterExecute;
  end;

{ Error and exception handling routines }
procedure SDEError(ErrorCode: TSDEResult);
procedure SDECheck(Status: TSDEResult);

function UpdateKindToStatus(UpdateKind: TUpdateKind): TUpdateStatus;

procedure SetBusyState;
procedure ResetBusyState;

var
  DefDatabase: TXSQLDatabase;	// default database component in design time
  Session: TXSQLSession;
  Sessions: TXSQLSessionList;

  InitSqlDatabaseProcs: array[TSDServerType] of TInitSqlDatabaseProc;

implementation

uses
  DBConsts, DBLogDlg,
{$IFDEF EVAL}SDRemind,{$ENDIF}

{$IFDEF stSQLBase}      XSCsb,{$ENDIF}
{$IFDEF stOracle}       XSOra,{$ENDIF}
{$IFDEF stSQLServer}    XSMss,{$ENDIF}
{$IFDEF stSybase}       XSSyb,{$ENDIF}
{$IFDEF stDB2}          XSDb2,{$ENDIF}
{$IFDEF stInformix}     XSInf,{$ENDIF}
{$IFDEF stODBC}         XSOdbc,{$ENDIF}
{$IFDEF stInterbase}    XSInt,{$ENDIF}
{$IFDEF stFirebird}     XSFib,{$ENDIF}
{$IFDEF stMySQL}        XSMySQL,{$ENDIF}
{$IFDEF stPostgreSQL}   XSPgSQL,{$ENDIF}
{$IFDEF stOLEDB}        XSOleDb,{$ENDIF}

{$IFDEF CLR}
  System.Text, System.Threading,
{$ENDIF}
  TypInfo;

const
  DefaultParamPrefix		= ':';
  OldFieldValuePrefix		= 'OLD_';

type

  { TBookmarkRec }
  PBookmarkRec = ^TBookmarkRec;
  TBookmarkRec = packed record		{ Bookmark structure }
    iPos   : Longint;               { Position in given order - position in the cache(FRecCache), starting from 0 }
{    iState : Integer;               { State of cursor }
//    iRecNo : Integer;               { Physical Record number }
{    iSeqNo : Integer;               { Version number of order }
{    iOrderID : Integer;             { Defines Order }
  end;

  { TDBParams - remote database parameters that stored in the Session object }
  TDBParams	= class(TObject)
    RemoteDatabase: string;
    ServerType: TSDServerType;
    Params: TStrings;
  end;

{ Busy state cursor function }
var
  BusyCount: Integer;
  SaveCursor: TCursor;
  FCSect: TRTLCriticalSection;


procedure SetBusyState;
begin
{$IFDEF XSQL_CLR}
  if Thread.CurrentThread <> MainThread then
{$ELSE}
  if GetCurrentThreadID <> MainThreadID then
{$ENDIF}
    Exit;
	// if main thread, that change cursor
  if Session.FSQLHourGlass then begin
    if BusyCount = 0 then begin
      SaveCursor := Screen.Cursor;
      Screen.Cursor := Session.FSQLWaitCursor;
    end;
    Inc(BusyCount);
  end;
end;

procedure ResetBusyState;
begin
  if Session.FSQLHourGlass then
    if BusyCount > 0 then begin
      Dec(BusyCount);
      if BusyCount = 0 then
        Screen.Cursor := SaveCursor;
    end;
end;

function UpdateKindToStatus(UpdateKind: TUpdateKind): TUpdateStatus;
begin
  Result := TUpdateStatus( Ord(UpdateKind)+1 );
end;

// Returns False if the field value differs from the parameter value
function CompareParamValue(Param: TSDHelperParam; Field: TField): Boolean;
begin
  Result := False;
  if not Assigned( Field ) then
    Exit;
  if (Param.IsNull xor Field.IsNull) or
     (Param.DataType <> Field.DataType)
  then
    Exit;
  Result := (Param.IsNull and Field.IsNull) or
            (Param.Value = Field.Value);
end;

function DateTimeRecToDateTime(DataType: TFieldType; DateTimeRec: TDateTimeRec): TDateTime;
var
  TimeStamp: TTimeStamp;
begin
  case DataType of
    ftDate:
      begin
        TimeStamp.Time := 0;
        TimeStamp.Date := DateTimeRec.Date;
      end;
    ftTime:
      begin
        TimeStamp.Time := DateTimeRec.Time;
        TimeStamp.Date := DateDelta;
      end;
    ftDateTime:
      try
        TimeStamp := MSecsToTimeStamp({$IFDEF XSQL_CLR} Trunc(DateTimeRec.DateTime) {$ELSE} DateTimeRec.DateTime {$ENDIF});
      except
        TimeStamp.Time := 0;
        TimeStamp.Date := 0;
      end;
    else
      raise Exception.Create('Unknown data type in function DateTimeRecToDateTime');
    end;
  Result := TimeStampToDateTime(TimeStamp);
end;

{ MIDAS uses '?' parameter marker, which is supported in Interbase, DB2, Informix and ODBC only.
 I.e. for some servers it is necessary to change a parameter marker from '?' to ':NAME' }
function ReplaceQuestionParamMarker(AServerType: TSDServerType; ASQL :string; AParams: TSDHelperParams): string;
var
  i: Integer;
begin
  Result := ASQL;

  if (AServerType in [stDB2, stInformix, stODBC, stInterbase]) or
     not Assigned(AParams) or (AParams.Count = 0)
  then
    Exit;
  if Pos('?', ASQL) = 0 then
    Exit;

  for i:=0 to AParams.Count-1 do begin
    if AParams[i].Name = '' then
      AParams[i].Name := IntToStr( i+1 );
      // it is necessary to change only one '?' marker per parameter
    ReplaceString( True, '?', DefaultParamPrefix + AParams[i].Name, Result);
  end;
end;

procedure SetUnknownParamTypeToInput(P: TSDHelperParams);
var
  i: Integer;
begin
  for i:=0 to P.Count-1 do
    if P[i].ParamType = ptUnknown then
      P[i].ParamType := ptInput;
end;


type

{ TXSQLQueryDataLink }
  TSDCustomQueryDataLink = {$IFDEF XSQL_VCL4} TDetailDataLink {$ELSE} TDataLink {$ENDIF};

  TXSQLQueryDataLink = class( TSDCustomQueryDataLink )
  private
    FQuery: TXSQLQuery;
  protected
    procedure ActiveChanged; override;
    procedure RecordChanged(Field: TField); override;
{$IFDEF XSQL_VCL4}
    function GetDetailDataSet: TDataSet; override;
{$ENDIF}
    procedure CheckBrowseMode; override;
  public
    constructor Create(AQuery: TXSQLQuery);
  end;


{ Utility routines }
  
function DefaultSession: TXSQLSession;
begin
  Result := XSEngine.Session;
end;

{ Error and exception handling routines }

procedure SDEError(ErrorCode: TSDEResult);
begin
  ResetBusyState;
  raise ESDEngineError.CreateDefPos(ErrorCode, ErrorCode, '');
end;

procedure SDECheck(Status: TSDEResult);
begin
  if Status <> 0 then SDEError(Status);
end;

function GetRecInfoStruct(RecBuf: TSDRecordBuffer; Offset: Integer): TSDRecInfo;
begin
{$IFDEF XSQL_CLR}
  Result := TSDRecInfo( Marshal.PtrToStructure( TSDPtr(Longint(RecBuf) + Offset), TypeOf(TSDRecInfo) ) );
{$ELSE}
  Result := PSDRecInfo( RecBuf + Offset )^;
{$ENDIF}
end;

procedure SetRecInfoStruct(RecBuf: TSDRecordBuffer; Offset: Integer; ARecInfo: TSDRecInfo); overload;
begin
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( ARecInfo, TSDPtr(Longint(RecBuf) + Offset), False );
{$ELSE}
  PSDRecInfo( RecBuf + Offset )^ := ARecInfo;
{$ENDIF}
end;

procedure SetRecInfoStruct(RecBuf: TSDRecordBuffer; Offset: Integer; ARecNumber: Longint); overload;
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteInt32( RecBuf, Offset, ARecNumber );
{$ELSE}
  PSDRecInfo( RecBuf + Offset )^.RecordNumber := ARecNumber;
{$ENDIF}
end;

procedure SetRecInfoStruct(RecBuf: TSDRecordBuffer; Offset: Integer; AValue: TUpdateStatus); overload;
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteByte( RecBuf, Offset + SizeOf(Longint), Byte( AValue ) );
{$ELSE}
  PSDRecInfo( RecBuf + Offset )^.UpdateStatus := AValue;
{$ENDIF}
end;

procedure SetRecInfoStruct(RecBuf: TSDRecordBuffer; Offset: Integer; AValue: TBookmarkFlag); overload;
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteByte( RecBuf, Offset + SizeOf(Longint) + SizeOf(Byte), Byte( AValue ) );
{$ELSE}
  PSDRecInfo( RecBuf + Offset )^.BookmarkFlag := AValue;
{$ENDIF}
end;

function GetBookmarkRecStruct(RecBuf: TSDRecordBuffer; Offset: Integer): TBookmarkRec;
begin
{$IFDEF XSQL_CLR}
  Result := TBookmarkRec( Marshal.PtrToStructure( TSDPtr(Longint(RecBuf) + Offset), TypeOf(TBookmarkRec) ) );
{$ELSE}
  Result := PBookmarkRec( RecBuf + Offset )^;
{$ENDIF}
end;

procedure SetBookmarkRecStruct(RecBuf: TSDRecordBuffer; Offset: Integer; ABookRec: TBookmarkRec); overload;
begin
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( ABookRec, TSDPtr(Longint(RecBuf) + Offset), False );
{$ELSE}
  PBookmarkRec( RecBuf + Offset )^ := ABookRec;
{$ENDIF}
end;

procedure SetBookmarkRecStruct(RecBuf: TSDRecordBuffer; Offset: Integer; APos: Longint); overload;
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteInt32( RecBuf, Offset, APos );
{$ELSE}
  PBookmarkRec( RecBuf + Offset )^.iPos := APos;
{$ENDIF}
end;


{$IFDEF XSQL_CLR}
function StrLen(APtr: TSDValueBuffer): Integer;
var
  b: Byte;
begin
  Result := 0;
  if not Assigned(APtr) then
    Exit;
  b := Marshal.ReadByte( APtr, Result );
  while b <> 0 do begin
    Inc(Result);
    b := Marshal.ReadByte( APtr, Result );
  end;
end;
{$ENDIF}

// the following procedure are necessary to exclude ambiguity with TDataSet.Insert/Delete methods
procedure DeleteSubstr(var S: string; Index, Count:Integer);
begin
  Delete(S, Index, Count);
end;

procedure InsertSubstr(Source: string; var S: string; Index: Integer);
begin
  Insert(Source, S, Index);
end;


{*******************************************************************************
				TXSQLSessionList
*******************************************************************************}
constructor TXSQLSessionList.Create;
begin
  inherited Create;
  FSessions := TThreadList.Create;
  FSessionNumbers := TBits.Create;
  InitializeCriticalSection(FCSect);
end;

destructor TXSQLSessionList.Destroy;
begin
  CloseAll;
  DeleteCriticalSection(FCSect);
  FSessionNumbers.Free;
  FSessions.Free;
  inherited Destroy;
end;

procedure TXSQLSessionList.AddSession(ASession: TXSQLSession);
var
  List: TList;
begin
  List := FSessions.LockList;
  try
    if List.Count = 0 then
      ASession.FDefault := True;
    List.Add(ASession);
  finally
    FSessions.UnlockList;
  end;
end;

procedure TXSQLSessionList.CloseAll;
var
  I: Integer;
  List: TList;
begin
  List := FSessions.LockList;
  try
    for I := List.Count-1 downto 0 do
      TXSQLSession(List[I]).Free;
    XSEngine.Session := nil;	// default session is destroyed now
  finally
    FSessions.UnlockList;
  end;
end;

function TXSQLSessionList.GetCount: Integer;
var
  List: TList;
begin
  List := FSessions.LockList;
  try
    Result := List.Count;
  finally
    FSessions.UnlockList;
  end;
end;

function TXSQLSessionList.GetSession(Index: Integer): TXSQLSession;
var
  List: TList;
begin
  List := FSessions.LockList;
  try
    Result := TXSQLSession( List[Index] );
  finally
    FSessions.UnlockList;
  end;
end;

function TXSQLSessionList.GetSessionByName(const SessionName: string): TXSQLSession;
begin
  if SessionName = '' then
    Result := Session
  else
    Result := FindSession(SessionName);
  if Result = nil then
    DatabaseErrorFmt(SInvalidSessionName, [SessionName]);
end;

function TXSQLSessionList.FindDatabase(const DatabaseName: string): TXSQLDatabase;
var
  i: Integer;
  List: TList;
begin
  Result := nil;

  List := FSessions.LockList;
  try
    for i:=0 to List.Count-1 do begin
      Result := TXSQLSession( List[i] ).FindDatabase( DatabaseName );
      if Result <> nil then
        Break;
    end;
  finally
    FSessions.UnlockList;
  end;
end;

function TXSQLSessionList.FindSession(const SessionName: string): TXSQLSession;
var
  I: Integer;
  List: TList;
begin
  if SessionName = '' then
    Result := Session
  else begin
    List := FSessions.LockList;
    try
      for I := 0 to List.Count - 1 do begin
        Result := TXSQLSession( List[I] );
        if CompareText( Result.SessionName, SessionName ) = 0 then
          Exit;
      end;
      Result := nil;
    finally
      FSessions.UnlockList;
    end;
  end;
end;

procedure TXSQLSessionList.GetSessionNames(List: TStrings);
var
  I: Integer;
  SList: TList;
begin
  List.BeginUpdate;
  try
    List.Clear;
    SList := FSessions.LockList;
    try
      for I := 0 to SList.Count - 1 do
        with TXSQLSession( SList[I] ) do
          List.Add(SessionName);
    finally
      FSessions.UnlockList;
    end;
  finally
    List.EndUpdate;
  end;
end;

function TXSQLSessionList.OpenSession(const SessionName: string): TXSQLSession;
begin
  Result := FindSession(SessionName);
  if Result = nil then begin
    Result := TXSQLSession.Create(nil);
    Result.SessionName := SessionName;
  end;
  Result.SetActive(True);
end;


{*******************************************************************************
				TXSQLSession
*******************************************************************************}
constructor TXSQLSession.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ValidateAutoSession(AOwner, False);
  FDatabases	:= TList.Create;
  FDefault	:= False;
  FDBParams	:= TList.Create;
  FKeepConnections := True;
  FSQLHourGlass := True;
  FSQLWaitCursor:= crHourGlass;
  FLockCount	:= 0;

  Sessions.AddSession(Self);
end;

destructor TXSQLSession.Destroy;
begin
  SetActive(False);
  if Assigned(Sessions) then
    Sessions.FSessions.Remove(Self);

  FDatabases.Free;
  FDatabases := nil;

  if Assigned(FDBParams) then
    ClearDBParams;
  FDBParams.Free;
  FDBParams := nil;

  inherited Destroy;
end;

procedure TXSQLSession.AddDatabase(Value: TXSQLDatabase);
begin
  FDatabases.Add(Value);
end;

procedure TXSQLSession.CheckInactive;
begin
  if Active then
    DatabaseError(SSessionActive);
end;

procedure TXSQLSession.Close;
begin
  SetActive(False);
end;

procedure TXSQLSession.Open;
begin
  SetActive(True);
end;

function TXSQLSession.GetActive: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i:=0 to DatabaseCount-1 do
    if Databases[i].Connected then begin
      Result := True;
      Break;
    end;
  if not Result then
    Result := FActive;
end;

procedure TXSQLSession.SetActive(Value: Boolean);
begin
  if csReading in ComponentState then
    FStreamedActive := Value
  else
    if Active <> Value then
      StartSession(Value);
end;

procedure TXSQLSession.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if AutoSessionName and (Operation = opInsert) then
    if AComponent is TSDDataSet then
      TSDDataSet(AComponent).FSessionName := Self.SessionName
    else if AComponent is TXSQLDatabase then
      TXSQLDatabase(AComponent).FSession := Self;
end;

procedure TXSQLSession.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  if FAutoSessionName then UpdateAutoSessionName;
end;

function TXSQLSession.SessionNameStored: Boolean;
begin
  Result := not FAutoSessionName;
end;

procedure TXSQLSession.SetAutoSessionName(Value: Boolean);
begin
  if Value <> FAutoSessionName then begin
    if Value then begin
      CheckInActive;
      ValidateAutoSession(Owner, True);
      FSessionNumber := -1;
      EnterCriticalSection(FCSect);
      try
        with Sessions do begin
          FSessionNumber := FSessionNumbers.OpenBit;
          FSessionNumbers[FSessionNumber] := True;
        end;
      finally
        LeaveCriticalSection(FCSect);
      end;
      UpdateAutoSessionName;
    end
    else begin
      if FSessionNumber > -1 then begin
        EnterCriticalSection(FCSect);
        try
          Sessions.FSessionNumbers[FSessionNumber] := False;
        finally
          LeaveCriticalSection(FCSect);
        end;
      end;
    end;
    FAutoSessionName := Value;
  end;
end;

procedure TXSQLSession.SetSessionName(const Value: string);
var
  Ses: TXSQLSession;
begin
  if FAutoSessionName and not FUpdatingAutoSessionName then
    DatabaseError(SAutoSessionActive);
  CheckInActive;
  if Value <> '' then begin
    Ses := Sessions.FindSession(Value);
    if not ((Ses = nil) or (Ses = Self)) then
      DatabaseErrorFmt(SDuplicateSessionName, [Value]);
  end;
  FSessionName := Value
end;

procedure TXSQLSession.SetSessionNames;
var
  I: Integer;
  Component: TComponent;
begin
  if Owner <> nil then
    for I := 0 to Owner.ComponentCount - 1 do begin
      Component := Owner.Components[I];
      if (Component is TXSQLDatabase) and
         (CompareText(TXSQLDatabase(Component).SessionName, Self.SessionName) <> 0)
      then
        TXSQLDatabase(Component).SessionName := Self.SessionName
      else if (Component is TSDDataSet) and
              (CompareText(TSDDataSet(Component).SessionName, Self.SessionName) <> 0)
      then
        TSDDataSet(Component).SessionName := Self.SessionName;
    end;
end;

procedure TXSQLSession.StartSession(Value: Boolean);
var
  i: Integer;
begin
  EnterCriticalSection(FCSect);
  try
    if Value then begin
      if FSessionName = '' then
        DatabaseError(SSessionNameMissing);
      if (DefaultSession <> Self) then
        DefaultSession.Active := True;
    end else begin
      for i := FDatabases.Count - 1 downto 0 do
        with TXSQLDatabase(FDatabases[i]) do
          if Temporary
          then Free
          else Close;
    end;
    FActive := Value;
  finally
    LeaveCriticalSection(FCSect);
  end;
end;

procedure TXSQLSession.CloseDatabase(Database: TXSQLDatabase);
begin
  with Database do begin
    if FRefCount <> 0 then Dec(FRefCount);
    if (FRefCount = 0) and not KeepConnection then
      if not Temporary then
        Close
      else if not (csDestroying in ComponentState) then
        Free;
  end;
end;

function TXSQLSession.FindDatabase(const DatabaseName: string): TXSQLDatabase;
var
  i: Integer;
begin
  for i := 0 to FDatabases.Count - 1 do begin
    Result := TXSQLDatabase( FDatabases[i] );
    if ((Result.DatabaseName <> '') or Result.Temporary) and
        (CompareText(Result.DatabaseName, DatabaseName) = 0)
    then
      Exit;
  end;
  Result := nil;
end;

function TXSQLSession.DoFindDatabase(const DatabaseName: string; AOwner: TComponent): TXSQLDatabase;
var
  i: Integer;
begin
  if AOwner <> nil then
    for i := 0 to FDatabases.Count - 1 do begin
      Result := TXSQLDatabase( FDatabases[i] );
      if (Result.Owner = AOwner) and
         (CompareText(Result.DatabaseName, DatabaseName) = 0)
      then
        Exit;
    end;
  Result := FindDatabase(DatabaseName);
end;

function TXSQLSession.GetDatabase(Index: Integer): TXSQLDatabase;
begin
  Result := TXSQLDatabase( FDatabases[Index] );
end;

function TXSQLSession.GetDatabaseCount: Integer;
begin
  if Assigned(FDatabases) then
    Result := FDatabases.Count
  else
    Result := 0;
end;

procedure TXSQLSession.GetDatabaseNames(List: TStrings);
var
  I: Integer;
  Names: TStringList;
begin
  Names := TStringList.Create;
  try
    Names.Sorted := True;

    for I := 0 to FDatabases.Count - 1 do
      with TXSQLDatabase(FDatabases[I]) do
        Names.Add( LowerCase(DatabaseName) );

    List.Assign(Names);
  finally
    Names.Free;
  end;
end;

procedure TXSQLSession.GetDatabaseParams(const ARemoteDatabase: string; AServerType: TSDServerType; List: TStrings);
var
  i: Integer;
  p: TDBParams;
begin
  for i:=0 to FDBParams.Count-1 do begin
    p := TDBParams( FDBParams[i] );
    if Assigned(p) and
       (p.ServerType = AServerType) and
       (CompareText(p.RemoteDatabase, ARemoteDatabase) = 0)
    then begin
      if Assigned(p.Params) then
        List.Assign(p.Params);
      Exit;
    end;
  end;
end;

{ Stores database Params to Session.FDBParams, when a database is opening.
If a database is closing, then it's params don't be removed from Session.FDBParams }
procedure TXSQLSession.InternalAddDatabase(const ARemoteDatabase: string; AServerType: TSDServerType; List: TStrings);
var
  i: Integer;
  p: TDBParams;
begin
  p := nil;
  for i:=0 to FDBParams.Count-1 do
	// if RemoteDatabase and database Params exist, then don't add,
        // but it is necessary to change Params to new values
    if Assigned( FDBParams[i] ) and
       (TDBParams(FDBParams[i]).ServerType = AServerType) and
       (CompareText( TDBParams(FDBParams[i]).RemoteDatabase, ARemoteDatabase ) = 0)
    then begin
      p := TDBParams( FDBParams[i] );
      Break;
    end;
	// if RemoteDatabase and database Params don't exist
  if not Assigned(p) then begin
    p := TDBParams.Create;
    p.RemoteDatabase	:= ARemoteDatabase;
    p.ServerType	:= AServerType;
    p.Params		:= TStringList.Create;
    FDBParams.Add(p);
  end;

  p.Params.Assign(List);
end;

procedure TXSQLSession.ClearDBParams;
var
  i: Integer;
  p: TDBParams;
begin
  for i:=FDBParams.Count-1 downto 0 do begin
    p := TDBParams( FDBParams[i] );
    if Assigned(p) then begin
      p.Params.Free;
      p.Free;
      FDBParams.Delete(i);
    end;
  end;
end;

procedure TXSQLSession.Loaded;
begin
  inherited Loaded;
  try
    if AutoSessionName then SetSessionNames;
    if FStreamedActive then SetActive(True);
  except
    if csDesigning in ComponentState then
      Application.HandleException(Self)
    else
      raise;
  end;
end;

procedure TXSQLSession.LockSession;
begin
  if FLockCount = 0 then begin
    EnterCriticalSection(FCSect);
    Inc(FLockCount);
    MakeCurrent;
  end else
    Inc(FLockCount);
end;

procedure TXSQLSession.UnLockSession;
begin
  Dec(FLockCount);
  if FLockCount = 0 then
    LeaveCriticalSection(FCSect);
end;

procedure TXSQLSession.MakeCurrent;
begin
  SetActive(True);
end;

function TXSQLSession.DoOpenDatabase(const DatabaseName: string; AOwner: TComponent): TXSQLDatabase;
var
  TempDatabase: TXSQLDatabase;
begin
  Result := nil;
  TempDatabase := nil;
  LockSession;
  try
    try
      Result := DoFindDatabase(DatabaseName, AOwner);
      if Result = nil then begin
        TempDatabase := TXSQLDatabase.Create(Self);
        TempDatabase.RemoteDatabase	:= DatabaseName;
        TempDatabase.DatabaseName	:= DatabaseName;
        TempDatabase.KeepConnection := not(csDesigning in ComponentState) and FKeepConnections;
        TempDatabase.Temporary		:= True;
        Result := TempDatabase;
      end;
      Result.Open;
      Inc(Result.FRefCount);
    except
      TempDatabase.Free;
      raise;
    end;
  finally
    UnLockSession;
  end;
end;

function TXSQLSession.OpenDatabase(const DatabaseName: string): TXSQLDatabase;
begin
  Result := DoOpenDatabase(DatabaseName, nil);
end;

procedure TXSQLSession.GetStoredProcNames(const DatabaseName: string; List: TStrings);
var
  db: TXSQLDatabase;
begin
  db := FindDatabase(DatabaseName);
  if Assigned(db) then
    db.ISqlGetStoredProcNames(List);
end;

procedure TXSQLSession.GetTableNames(const DatabaseName, Pattern: string; SystemTables: Boolean; List: TStrings);
var
  db: TXSQLDatabase;
begin
  db := FindDatabase(DatabaseName);
  if Assigned(db) then
    db.ISqlGetTableNames(Pattern, SystemTables, List);
end;

{ It's necessary for UpdateSQL Editor }
procedure TXSQLSession.GetFieldNames(const DatabaseName, TableName: string; List: TStrings);
var
  db: TXSQLDatabase;
begin
  db := FindDatabase(DatabaseName);
  if Assigned(db) then
    db.ISqlGetFieldNames(TableName, List);
end;

procedure TXSQLSession.RemoveDatabase(Value: TXSQLDatabase);
begin
	// it's necessary, when TXSQLDatabase instance is disposing after it's FSession component
  if not Assigned(FDatabases) then Exit;
  FDatabases.Remove(Value);
end;

procedure TXSQLSession.UpdateAutoSessionName;
begin
  FUpdatingAutoSessionName := True;
  try
    SessionName := Format('%s_%d', [Name, FSessionNumber + 1]);
  finally
    FUpdatingAutoSessionName := False;
  end;
  SetSessionNames;
end;

procedure TXSQLSession.ValidateAutoSession(AOwner: TComponent; AllSessions: Boolean);
var
  I: Integer;
  Component: TComponent;
begin
  if AOwner <> nil then
    for I := 0 to AOwner.ComponentCount - 1 do begin
      Component := AOwner.Components[I];
      if (Component <> Self) and (Component is TXSQLSession) then
        if AllSessions then
          DatabaseError(SAutoSessionExclusive)
        else if TXSQLSession(Component).AutoSessionName then
          DatabaseErrorFmt(SAutoSessionExists, [Component.Name]);
    end;
end;

{$IFNDEF XSQL_VCL5}

{ TSDCustomDatabase }

constructor TSDCustomDatabase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataSets := TList.Create;
end;

destructor TSDCustomDatabase.Destroy;
begin
  inherited Destroy;
  SetConnected(False);
  FDataSets.Free;
end;

procedure TSDCustomDatabase.Loaded;
begin
  inherited Loaded;

  try
    if FStreamedConnected then
      SetConnected(True);
  except
    if csDesigning in ComponentState then
      Application.HandleException(Self)
    else
      raise;
  end;
end;

procedure TSDCustomDatabase.Open;
begin
  SetConnected(True);
end;

procedure TSDCustomDatabase.Close;
begin
  SetConnected(False);
end;

function TSDCustomDatabase.GetConnected: Boolean;
begin
  Result := False;
end;

procedure TSDCustomDatabase.SetConnected(Value: Boolean);
begin
  if (csReading in ComponentState) and Value then
    FStreamedConnected := True
  else begin
    if Value = GetConnected then
      Exit;
    if Value then begin
      if Assigned(BeforeConnect) then BeforeConnect(Self);
      DoConnect;
      if Assigned(AfterConnect) then AfterConnect(Self);
    end else begin
      if Assigned(BeforeDisconnect) then BeforeDisconnect(Self);
      DoDisconnect;
      if Assigned(AfterDisconnect) then AfterDisconnect(Self);
    end;
  end;
end;

procedure TSDCustomDatabase.DoConnect;
begin
end;

procedure TSDCustomDatabase.DoDisconnect;
begin
end;

procedure TSDCustomDatabase.RegisterClient(Client: TObject; Event: TConnectChangeEvent = nil);
begin
  if Client is TDataSet then
    FDataSets.Add(Client);
end;

procedure TSDCustomDatabase.UnRegisterClient(Client: TObject);
begin
  if Client is TDataSet then
    FDataSets.Remove(Client);
end;

function TSDCustomDatabase.GetDataSet(Index: Integer): TDataSet;
begin
  Result := FDataSets[Index];
end;

function TSDCustomDatabase.GetDataSetCount: Integer;
begin
  Result := FDataSets.Count;
end;
{$ENDIF}

{*******************************************************************************
				TXSQLDatabase
*******************************************************************************}
constructor TXSQLDatabase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if FSession = nil then
    if AOwner is TXSQLSession then
      FSession := TXSQLSession(AOwner) else
      FSession := DefaultSession;
  SessionName := FSession.SessionName;
  FSession.AddDatabase(Self);

  FParams := TStringList.Create;
  FRefCount := 0;

  FTransIsolation := tiReadCommitted;
  LoginPrompt	:= True;

  FServerType	:= stSQLBase;
  FSqlDatabase	:= nil;
  FDesignOptions:= [ddoStoreConnected];
  
  FClientVersion:= 0;
  FServerVersion:= 0;
  FVersion	:= '';

  FKeepConnection := True;
  FIsConnectionBusy:= False;
end;

destructor TXSQLDatabase.Destroy;
begin
  IdleTimeOut := 0;
  
  Close;

  if DefDatabase = Self then
    DefDatabase := nil;

  if FSession <> nil then
    FSession.RemoveDatabase(Self);
  FParams.Free;

  inherited Destroy;
end;

procedure TXSQLDatabase.Loaded;
begin
  inherited Loaded;

  if ddoIsDefaultDatabase in FDesignOptions then
    DefDatabase := Self;

  if not StreamedConnected then CheckSessionName(False);
end;

procedure TXSQLDatabase.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSession) and
     (FSession <> DefaultSession)
  then begin
    Close;
    SessionName := '';
  end;
end;

procedure TXSQLDatabase.RegisterClient(Client: TObject; Event: TConnectChangeEvent = nil);
begin
  inherited;
end;

procedure TXSQLDatabase.UnRegisterClient(Client: TObject);
begin
  inherited;
end;

procedure TXSQLDatabase.ApplyUpdates(const DataSets: array of TSDDataSet);
var
  I: Integer;
  DS: TSDDataSet;
begin
  StartTransaction;
  try
    for I := 0 to High(DataSets) do begin
      DS := DataSets[I];
      if not Assigned( DS ) then
        Continue;
      if DS.Database <> Self then
        DatabaseError(Format(SUpdateWrongDB, [DS.Name, Name]));
      DS.ApplyUpdates;
    end;
    Commit;
  except
    Rollback;
	// mark records as not saved
    for I := 0 to High(DataSets) do
      if Assigned( DataSets[I] ) then
        DataSets[I].RollbackUpdates;
    raise;
  end;
  for I := 0 to High(DataSets) do
    if Assigned( DataSets[I] ) then
      DataSets[I].CommitUpdates;
end;

procedure TXSQLDatabase.CheckActive;
begin
  if not GetConnected then
    DatabaseError(SDatabaseClosed);
end;

procedure TXSQLDatabase.CheckInactive;
begin
  if GetConnected then
    if csDesigning in ComponentState then
      Close
    else
      DatabaseError(SDatabaseOpen);
end;

procedure TXSQLDatabase.CheckInTransaction;
begin
  if not InTransaction then
    DatabaseError( SNotInTransaction );
end;

procedure TXSQLDatabase.CheckNotInTransaction;
begin
  if InTransaction then
    DatabaseError( SInTransaction );
end;

procedure TXSQLDatabase.CheckDatabaseName;
begin
  if (FDatabaseName = '') and not Temporary then
    DatabaseError(SDatabaseNameMissing);
end;

{ Sets FSession property and sets on FSession.Active in case of Required is True }
procedure TXSQLDatabase.CheckSessionName(Required: Boolean);
var
  NewSession: TXSQLSession;
begin
  if Required then
    NewSession := Sessions.List[FSessionName]
  else
    NewSession := Sessions.FindSession(FSessionName);
  if (NewSession <> nil) and (NewSession <> FSession) then begin
    if (FSession <> nil) then FSession.RemoveDatabase(Self);
    FSession := NewSession;
    FSession.FreeNotification(Self);
    FSession.AddDatabase(Self);
    try
      ValidateName(FDatabaseName);
    except
      FDatabaseName := '';
      raise;
    end;
  end;
  if Required then
    FSession.Active := True;
end;

function TXSQLDatabase.ConnectedStored: Boolean;
begin
  Result := Connected and (ddoStoreConnected in FDesignOptions);
end;

procedure TXSQLDatabase.SetDesignOptions(Value: TSDDesignDBOptions);
begin
 FDesignOptions := Value;
 if ddoIsDefaultDatabase in FDesignOptions then begin
   if (DefDatabase <> nil) and (DefDatabase <> Self) then
     DefDatabase.FDesignOptions := DefDatabase.FDesignOptions - [ddoIsDefaultDatabase];
   if not (csLoading in ComponentState) then
    DefDatabase := Self
 end else
   if DefDatabase = Self then	// now the database is not default
     DefDatabase := nil;
end;

procedure TXSQLDatabase.CloseDataSets;
var
  ds: TSDDataSet;
begin
  while DataSetCount <> 0 do begin
    ds := TSDDataSet( DataSets[DataSetCount-1] );
        // ForceClose is used to process a possible hang up of connection with a server
    ds.ForceClose;
  end;
end;

procedure TXSQLDatabase.ForceClose;
begin
        // BeforeDisconnect/AfterConnect handlers are called in TCustomConnection.SetConnected, which is called in Close method
  if Assigned(BeforeDisconnect) then BeforeDisconnect(Self);
{$IFDEF XSQL_VCL5}
  SendConnectEvent(False);
{$ENDIF}
        // ForceClose will be called repeatedly for a dataset, which will produce an error,
        //when the connection is dropped
  while DataSetCount <> 0 do
    TSDDataSet( DataSets[DataSetCount-1] ).ForceClose;
  FRefCount := 0;

  InternalClose( True );

  if Assigned(AfterDisconnect) then AfterDisconnect(Self);
end;

procedure TXSQLDatabase.StartTransaction;
begin
  CheckActive;
  CheckNotInTransaction;

  FSqlDatabase.StartTransaction;
end;

procedure TXSQLDatabase.Commit;
var
  i: Integer;
begin
  CheckActive;
  CheckInTransaction;

  if Assigned(SqlDatabase) and not SqlDatabase.CursorPreservedOnCommit then begin
    for i:=0 to DataSetCount - 1 do
      if DataSets[i].Active then
        DataSets[i].FetchAll;
  end;
  SqlDatabase.Commit;
end;

{ After rollback, for example, DB2, Interbase 5, SQLBase could be destroyed }
procedure TXSQLDatabase.Rollback;
var
  i: Integer;
  bPrepared: Boolean;
begin
  CheckActive;
  CheckInTransaction;

  if Assigned(SqlDatabase) and not SqlDatabase.CursorPreservedOnRollback then
    for i:=0 to DataSetCount - 1 do begin
      bPrepared := DataSets[i].Active or
      	((DataSets[i] is TXSQLQuery) and (TXSQLQuery(DataSets[i]).Prepared)) or
        ((DataSets[i] is TXSQLStoredProc) and (TXSQLStoredProc(DataSets[i]).Prepared));
      if bPrepared then begin
        if DataSets[i].Active then begin
          DataSets[i].FetchAll;
          DataSets[i].ISqlCloseResultSet;
        end;
		// it is necessary to destroy cursor explicitly before rollback
        DataSets[i].Detach;	// dataset must stay active
      end;
    end;
  SqlDatabase.Rollback;
end;

function TXSQLDatabase.GetConnected: Boolean;
begin
  Result := FSqlDatabase <> nil;
end;

function TXSQLDatabase.GetDataSet(Index: Integer): TDataSet;
begin
  Result := inherited GetDataSet(Index) as TSDDataSet;
end;

function TXSQLDatabase.GetSDDataSet(Index: Integer): TSDDataSet;
begin
  Result := GetDataSet(Index) as TSDDataSet;
end;

function TXSQLDatabase.GetInTransaction: Boolean;
begin
  Result := False;
  if Assigned(FSqlDatabase) then
    Result := FSqlDatabase.InTransaction;
end;

function TXSQLDatabase.GetHandle: PSDCursor;
begin
  Result := nil;
  if Assigned(FSqlDatabase) then
    Result := FSqlDatabase.Handle;
end;

procedure TXSQLDatabase.SetHandle(Value: PSDCursor);
var
  HRec: TSDHandleRec;
begin
  if not Assigned(Value) then begin
    DatabaseError( SBadServerType );
    Exit;
  end;
{$IFDEF XSQL_CLR}
  HRec := TSDHandleRec( Marshal.PtrToStructure(Value, TypeOf(TSDHandleRec)) );
{$ELSE}
  HRec := PSDHandleRec(Value)^;
{$ENDIF}
	// check server type
  if (Integer(HRec.SrvType) < Ord(Low(ServerType))) or
     (Integer(HRec.SrvType) > Ord(High(ServerType)))
  then
    DatabaseError( SBadServerType );
        // cast to integer to exclude "Comparing signed and unsigned types.." compiler warning
  if Ord(ServerType) <> Integer(HRec.SrvType) then
    DatabaseErrorFmt(
    	SServerTypeMismatch,
    	[GetEnumName( TypeInfo(TSDServerType), HRec.SrvType ),
         GetEnumName( TypeInfo(TSDServerType), Ord(ServerType) )
        ]
    );

  if Connected then Close;
  if Value <> nil then begin
    CheckDatabaseName;
    CheckSessionName(True);

    InitSqlDatabase('', '', '', Value);

    FAcquiredHandle := True;
  end;
end;

function TXSQLDatabase.GetIsSQLBased: Boolean;
begin
  Result := True;
end;

procedure TXSQLDatabase.GetFieldNames(const TableName: string; List: TStrings);
begin

  ISqlGetFieldNames(TableName, List);
end;

procedure TXSQLDatabase.GetTableNames(const Pattern: string; SystemTables: Boolean; List: TStrings);
begin
  ISqlGetTableNames(Pattern, SystemTables, List);
end;

{ server info with full version and name }
function TXSQLDatabase.GetVersion: string;
begin
  if Assigned(FSqlDatabase) and (Length(FVersion) = 0) then
    FVersion := FSqlDatabase.GetVersionString;

  Result := FVersion;
end;

{ server version as MajorVer.MinorVer }
function TXSQLDatabase.GetServerMajor: Word;
begin
  if Assigned(FSqlDatabase) and (FServerVersion <= 0) then
    FServerVersion := FSqlDatabase.GetServerVersion;

  Result := GetMajorVer( FServerVersion );
end;

function TXSQLDatabase.GetServerMinor: Word;
begin
  if Assigned(FSqlDatabase) and (FServerVersion <= 0) then
    FServerVersion := FSqlDatabase.GetServerVersion;

  Result := GetMinorVer( FServerVersion );
end;

{ client version as MajorVer.MinorVer (-1 and 0 - unloaded and undefined) }
function TXSQLDatabase.GetClientMajor: Word;
begin
  if Assigned(FSqlDatabase) and (FClientVersion <= 0) then
    FClientVersion := FSqlDatabase.GetClientVersion;

  Result := GetMajorVer( FClientVersion );
end;

{ client version as MajorVer.MinorVer (-1 and 0 - unloaded and undefined) }
function TXSQLDatabase.GetClientMinor: Word;
begin
  if Assigned(FSqlDatabase) and (FClientVersion <= 0) then
    FClientVersion := FSqlDatabase.GetClientVersion;

  Result := GetMinorVer( FClientVersion );
end;

procedure TXSQLDatabase.Login(LoginParams: TStrings);
var
  UserName, Password: string;
  LoginProc: TSDLoginEvent;
begin
  LoginProc := OnLogin;
  if Assigned(LoginProc) then
    LoginProc(Self, LoginParams)
  else begin
    UserName := LoginParams.Values[szUSERNAME];
    if not LoginDialog(DatabaseName, UserName, Password) then
      DatabaseErrorFmt(SLoginError, [DatabaseName]);
    LoginParams.Values[szUSERNAME] := UserName;
    LoginParams.Values[szPASSWORD] := Password;
  end;
end;

procedure TXSQLDatabase.CheckRemoteDatabase(var Password: string);
var
  RDbParams, LoginParams: TStrings;
begin
  Password := '';

  if (RemoteDatabase = '') then begin
    DatabaseError(SRemoteDatabaseNameMissing);
    Exit;
  end;

  LoginParams := TStringList.Create;
  RDbParams := TStringList.Create;
  try
    Session.GetDatabaseParams(FRemoteDatabase, ServerType, RDbParams);

    if LoginPrompt then begin
      if FParams.Values[szUSERNAME] = '' then
        FParams.Values[szUSERNAME] := RDbParams.Values[szUSERNAME];

      LoginParams.Values[szUSERNAME] := FParams.Values[szUSERNAME];
      Login(LoginParams);

      Password := LoginParams.Values[szPASSWORD];
      FParams.Values[szUSERNAME] := LoginParams.Values[szUSERNAME];
    end else begin
      if FParams.Count > 0 then
        Password := FParams.Values[szPASSWORD]
      else begin
        FParams.Assign(RDbParams);
        Password := FParams.Values[szPASSWORD];
      end;
    end;

    if LoginPrompt then
      RDbParams.Assign(LoginParams)
    else
      RDbParams.Assign(FParams);
	// store the last parameters for the following connects
    if RDbParams.Count > 0 then
      Session.InternalAddDatabase(FRemoteDatabase, ServerType, RDbParams);
  finally
    LoginParams.Free;
    RDbParams.Free;
  end;
end;

procedure TXSQLDatabase.InitSqlDatabase(const ADatabaseName, AUserName, APassword: string; AHandle: PSDCursor);
begin
  ASSERT( FSqlDatabase = nil );

  if not Assigned( @InitSqlDatabaseProcs[ ServerType ] ) then
    DatabaseError( SNoServerType );

        // use OLEDB connection for MSSQL and szOLEDB parameter is set on
  if (ServerType = stSQLServer) and (UpperCase( Trim( Params.Values[szUSEOLEDB] ) ) = STrueString) then
    FSqlDatabase := InitSqlDatabaseProcs[ stOLEDB ](Params)
  else
    FSqlDatabase := InitSqlDatabaseProcs[ ServerType ](Params);
  if FSqlDatabase = nil then
    DatabaseError( SNoServerType );
    
  FSqlDatabase.TransIsolation	:= TISqlTransIsolation( Ord(TransIsolation) );
  FSqlDatabase.OnResetBusyState	:= BusyStateReset;
  FSqlDatabase.OnResetIdleTimeOut := IdleTimeOutReset;

  if Assigned(AHandle) then
    FSqlDatabase.Handle := AHandle
  else
    FSqlDatabase.Connect( ADatabaseName, AUserName, APassword );
end;

procedure TXSQLDatabase.DoneSqlDatabase;
begin
  if FSqlDatabase = nil then Exit;

  FSqlDatabase.Free;
  FSqlDatabase := nil;

  ResetServerInfo;
end;

procedure TXSQLDatabase.ResetServerInfo;
begin
  FVersion	:= '';
  FServerVersion:= 0;
  FClientVersion:= 0;
end;

procedure TXSQLDatabase.DoConnect;
{$IFDEF EVAL}
  procedure ShowRegReminder;
  var
    i: Integer;
  begin
    for i:=0 to Session.DatabaseCount-1 do
      if Session.Databases[i].Connected then
        Exit;
    ShowReminderBox;
  end;
{$ENDIF}
var
  DBPassword: string;
begin
  if Connected then
    Exit;
{$IFDEF EVAL}
  ShowRegReminder;
{$ENDIF}
  CheckDatabaseName;
	// here used Login method
  CheckRemoteDatabase(DBPassword);

  try
    InitSqlDatabase( RemoteDatabase, FParams.Values[szUSERNAME], DBPassword, nil );
  except
        // if connection was made and initialization raises an exception
    InternalClose(True);
    DoneSqlDatabase;
    raise;
  end;
end;

procedure TXSQLDatabase.DoDisconnect;
begin
  CloseDataSets;
  FRefCount := 0;

  InternalClose( False );
end;

procedure TXSQLDatabase.InternalClose(Force: Boolean);
begin
  if GetConnected then begin
    if not FAcquiredHandle then begin
      FSqlDatabase.Disconnect( Force );
      DoneSqlDatabase;
    end else begin
      DoneSqlDatabase;
      FAcquiredHandle := False;
    end;
  end;
end;

function TXSQLDatabase.TestConnected: Boolean;
begin
  Result := Connected;
  if Result then
    try
      Result := Assigned(SqlDatabase) and SqlDatabase.TestConnected;
      if not Result then
        ForceClose;     // if a connection is lost and TestConnected returns False silently
    except
      ForceClose;       // if a connection is lost and TestConnected raises an exception
      Result := False;
    end;
end;

procedure TXSQLDatabase.SetRemoteDatabase(const Value: string);
begin
  if FRemoteDatabase <> Value then begin
    CheckInactive;
    FRemoteDatabase := Value;
  end;
end;

procedure TXSQLDatabase.SetDatabaseName(const Value: string);
begin
  if csReading in ComponentState then
    FDatabaseName := Value
  else if FDatabaseName <> Value then begin
    CheckInactive;
    ValidateName(Value);
    FDatabaseName := Value;
  end;
end;

procedure TXSQLDatabase.SetKeepConnection(Value: Boolean);
begin
  if FKeepConnection <> Value then begin
    FKeepConnection := Value;
    if not Value and (FRefCount = 0) then
      Close;
  end;
end;

procedure TXSQLDatabase.SetParams(Value: TStrings);
begin
  FParams.Assign(Value);
end;

procedure TXSQLDatabase.SetServerType(Value: TSDServerType);
begin
  if Value <> FServerType then begin
    CheckInactive;
    FServerType := Value;
  end;
end;

procedure TXSQLDatabase.SetSessionName(const Value: string);
begin
  if csReading in ComponentState then
    FSessionName := Value
  else begin
    CheckInactive;
    if FSessionName <> Value then begin
      FSessionName := Value;
      CheckSessionName(False);
    end;
  end;
end;

procedure TXSQLDatabase.SetTransIsolation(Value: TSDTransIsolation);
begin
  if FTransIsolation = Value then Exit;

  if GetConnected then
    FSqlDatabase.SetTransIsolation( TISqlTransIsolation(Ord(Value)) );
  FTransIsolation := Value;
end;

procedure TXSQLDatabase.ValidateName(const Name: string);
var
  Database: TXSQLDatabase;
begin
  if Name <> '' then begin
    Database := Session.FindDatabase(Name);
    if (Database <> nil) and (Database <> Self) then begin
      if (not Database.Temporary) or (Database.FRefCount <> 0) then
        DatabaseErrorFmt(SDuplicateDatabaseName, [Name]);
      Database.Free;
    end;
  end;
end;

{		SQL-servers C/API calls		}
function TXSQLDatabase.ISqlParamValue(Value: TXSQLDatabaseParam): Integer;
begin
  Result := FSqlDatabase.ParamValue(Value);
end;

procedure TXSQLDatabase.ISqlGetStoredProcNames(List: TStrings);
var
  cmd: TISqlCommand;
  OwnerNo, NameNo: Integer;
  sOwner, sName: string;
begin
  SetBusyState;
  try
    if not Connected then
      Open;

    List.BeginUpdate;
    try
      List.Clear;
      cmd := FSqlDatabase.GetSchemaInfo(stProcedures, '%');
      try
        OwnerNo := cmd.FieldDescs.FieldDescByName(SCH_NAME_FIELD).FieldNo;
        NameNo := cmd.FieldDescs.FieldDescByName(PROC_NAME_FIELD).FieldNo;
        while cmd.FetchNextRow do begin
          cmd.GetFieldAsString(OwnerNo, sOwner);
          sOwner := Trim( sOwner );
          if sOwner <> '' then
            sOwner := sOwner + '.';
          cmd.GetFieldAsString(NameNo, sName);
          List.Add( sOwner + sName );
        end;
      finally
        cmd.Free;
      end;
    finally
      List.EndUpdate;
    end;

  finally
    ResetBusyState;
  end;
end;

procedure TXSQLDatabase.ISqlGetTableNames(Pattern: string; SystemTables: Boolean; List: TStrings);
var
  cmd: TISqlCommand;
  OwnerNo, NameNo: Integer;
  sOwner, sName: string;
begin
  SetBusyState;
  try
    if not Connected then
      Open;

    List.BeginUpdate;
    try
      List.Clear;
      if SystemTables then
        cmd := FSqlDatabase.GetSchemaInfo(stSysTables, Pattern)
      else
        cmd := FSqlDatabase.GetSchemaInfo(stTables, Pattern);
      try
        OwnerNo := cmd.FieldDescs.FieldDescByName(SCH_NAME_FIELD).FieldNo;
        NameNo := cmd.FieldDescs.FieldDescByName(TBL_NAME_FIELD).FieldNo;
        while cmd.FetchNextRow do begin
          cmd.GetFieldAsString(OwnerNo, sOwner);
          sOwner := Trim( sOwner );
          if sOwner <> '' then
            sOwner := sOwner + '.';
          cmd.GetFieldAsString(NameNo, sName);
          List.Add( sOwner + sName );
        end;
      finally
        cmd.Free;
      end;
    finally
      List.EndUpdate;
    end;

  finally
    ResetBusyState;
  end;
end;

procedure TXSQLDatabase.ISqlGetFieldNames(const TableName: string; List: TStrings);
var
  cmd: TISqlCommand;
  NameNo: Integer;
  s: string;
begin
  SetBusyState;
  try
    if not Connected then
      Open;

    List.BeginUpdate;
    try
      List.Clear;
      cmd := FSqlDatabase.GetSchemaInfo(stColumns, TableName);
      try
        NameNo := cmd.FieldDescs.FieldDescByName(COL_NAME_FIELD).FieldNo;
        while cmd.FetchNextRow do begin
          cmd.GetFieldAsString(NameNo, s);
          List.Add( s );
        end;
      finally
        cmd.Free;
      end;
    finally
      List.EndUpdate;
    end;
    
  finally
    ResetBusyState;
  end;
end;

{ Returns an activated(executed) dataset or nil }
function TXSQLDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TDataSet;
var
  cmd: TISqlCommand;
  q: TXSQLQuery;
begin
  Result := nil;
  SetBusyState;
  try
    if not Connected then
      Open;

    cmd := FSqlDatabase.GetSchemaInfo(ASchemaType, AObjectName);
        // cmd has to be executed already
    if Assigned(cmd) then begin
      q := TXSQLQuery.Create(Self);
      q.DatabaseName := DatabaseName;
      q.SessionName := SessionName;
      q.SetSqlCmd( cmd );

      Result := q;
    end;
  finally
    ResetBusyState;
  end;
end;

{ IdleTimer processing }

function TXSQLDatabase.GetIdleTimeOut: Integer;
begin
  Result := FIdleTimeOut;
end;

procedure TXSQLDatabase.SetIdleTimeOut(Value: Integer);
begin
  if Value <> FIdleTimeOut then begin
    if not (csDesigning in ComponentState) then
      UpdateTimer( Value );
    FIdleTimeOut := Value;
  end;
end;

procedure TXSQLDatabase.UpdateTimer(NewTimeout: Integer);
begin
  if NewTimeout > 0 then begin
    if not Assigned( FTimer ) then begin
      FTimer := TSDThreadTimer.Create(Self, True);
      FTimer.FreeOnTerminate := False;
      FTimer.OnTimer := IdleTimerHandler;
      FTimer.Interval := NewTimeout;
      FTimer.Resume;
    end else
      FTimer.Interval := NewTimeout;
  end else begin
    FTimer.Terminate;
    FTimer.WaitFor;
    FTimer.Free;
    FTimer := nil;
  end;
end;

{ The handler closes a connection, when nothing was executed during IdleTimeout }
procedure TXSQLDatabase.IdleTimerHandler(Sender: TObject);
begin
  if Connected then begin
    if FIdleTimeoutStarted then begin
      if FIsConnectionBusy then
        FIdleTimeoutStarted := False		// connection is processed at server-side
      else
        Close
    end else
      FIdleTimeoutStarted := True;              // set on an idle period
  end;
end;

procedure TXSQLDatabase.IdleTimeOutReset(Sender: TObject);
begin
  FIdleTimeOutStarted := False;
end;

procedure TXSQLDatabase.BusyStateReset(Sender: TObject);
begin
  XSEngine.ResetBusyState;
end;

(*******************************************************************************
	TSDThreadTimer - to implement TXSQLDatabase.IdleTimeOut property
*******************************************************************************)

constructor TSDThreadTimer.Create(ADatabase: TXSQLDatabase; CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);

  FDatabase := ADatabase;
  FInterval := 1000;
end;

destructor TSDThreadTimer.Destroy;
begin
  inherited Destroy;
end;

procedure TSDThreadTimer.Execute;
const
  MinInterval = 500;    // 500 milliseconds = 0,5 sec
var
  ev: TEvent;
  i: Integer;	// the variable can be negative (<=0)
begin
  ev := TEvent.Create(nil, False, False, '');
  try
    while not Terminated do begin
    	// start count down
      i := Interval;
      	// to minimize an application shutdown, it's necessary to check Terminated more often
      while not Terminated and (i > 0) do begin
        ev.WaitFor( MinInterval );
        i := i - MinInterval;
      	// timeout is broken
        if not FDatabase.FIdleTimeoutStarted  then
          Break;
      end;
      Timer;
    end;
  finally
    ev.Free;
  end;
end;

procedure TSDThreadTimer.SetInterval(Value: Integer);
begin
  if Value <> FInterval then
    FInterval := Value;
end;

procedure TSDThreadTimer.SetOnTimer(Value: TNotifyEvent);
begin
  FOnTimer := Value;
end;

procedure TSDThreadTimer.Timer;
begin
  if not Terminated and Assigned(FOnTimer) then FOnTimer(Self);
end;


(*******************************************************************************
  				TSDResultSet
*******************************************************************************)
constructor TSDResultSet.Create(ADataSet: TSDDataSet; IsBlobs: Boolean);
begin
  inherited Create;

  FDataSet := ADataSet;
  FIsBlobs := IsBlobs;
  FAllInCache := False;
  FPosition := -1;
  FDeletedCount := 0;
end;

destructor TSDResultSet.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TSDResultSet.Clear;
var
  i: Integer;
begin
  FPosition := -1;

  for i:=0 to Count-1 do
    ClearCacheItem(i);

  FDeletedCount := 0;
  FAllInCache := False;

  inherited Clear;
end;

{ Empties a cache item, but it does not remove the item }
procedure TSDResultSet.ClearCacheItem(Index: Integer);
var
  RecBuf: TSDRecordBuffer;
begin
  if Items[Index] = nil then
    Exit;

  RecBuf := CurRecords[Index];
  if Assigned( RecBuf ) then
    FDataSet.FreeRecordBuffer( RecBuf );

  RecBuf := OldRecords[Index];
  if Assigned( RecBuf ) then
    FDataSet.FreeRecordBuffer( RecBuf );

  SafeReallocMem( TSDPtr(Items[Index]), 0 );
  Items[Index] := nil;
end;

procedure TSDResultSet.SetToBegin;
begin
  FPosition := -1;
end;

procedure TSDResultSet.SetToEnd;
begin
  FPosition := Count;
end;

function TSDResultSet.GetFilterActivated: Boolean;
begin
  Result := FDataSet.Filtered;
end;

function TSDResultSet.RecordFilter(RecBuf: TSDRecordBuffer): Boolean;
begin
  Result := FDataSet.RecordFilter(RecBuf);
end;

{ Returns position of a record, which buffer is passed, in record cache }
function TSDResultSet.IndexOfRecord(RecBuf: TSDRecordBuffer): Integer;
var
  rec: TBookmarkRec;
  p: TSDPtr;
begin
  p := IncPtr( RecBuf, FDataSet.FBookmarkOffs );
{$IFDEF XSQL_CLR}
  rec := GetBookmarkRecStruct( p, 0 );
{$ELSE}
  rec := PBookmarkRec(p)^;
{$ENDIF}
  Result := rec.iPos;
end;

{ Gets the prior visible record }
function TSDResultSet.GetPriorRecord: Boolean;
begin
  Result := False;
  	// if the record was deleted, then begin from the last record in the cache
  if FPosition > Count then
    FPosition := Count;
  if FPosition >= 0 then begin
    Dec(FPosition);
    while FPosition >= 0 do begin
      if IsVisibleRecord(FPosition) then begin
        Result := True;
        Break;
      end;
      Dec(FPosition);
    end;
  end;
end;

{ Gets the current visible record, in case of necessity it will be fetched }
function TSDResultSet.GetCurrRecord: Boolean;
begin
  Result := False;
        // GetPriorRecord can set FPosition to -1, even if a result set is not empty
  if FPosition < 0 then
    FPosition := 0;
  if FPosition >= Count then
    FPosition := Count - 1;

  while (FPosition >= 0) and (FPosition < Count) do begin
    if IsVisibleRecord(FPosition) then begin
      Result := True;
      Break;
    end;
    if not GotoNextRecord then
      Break;	// the current record is last
  end;
end;

{ Gets the next visible record, in case of necessity it will be fetched }
function TSDResultSet.GetNextRecord: Boolean;
begin
  Result := False;

  repeat
    if not GotoNextRecord then
      Break;	// the current record is last

    if IsVisibleRecord(FPosition) then
      Result := True;
  until Result;
end;

{ Go to the next record in result set, in case of necessity it will be fetched }
function TSDResultSet.GotoNextRecord: Boolean;
begin
	// if the next record is in cache
  if (FPosition + 1) < Count then begin
    Inc(FPosition);
    Result := True;
  end else begin
  	// if FPosition exceeds Count, for example, the last visible rows were deleted
    if FPosition >= Count then
      FPosition := Count - 1;
        // FetchRecord returns True and increases FPosition in case of success, else
        // it returns False, if all records were fetched (all in cache).
    Result := FetchRecord;
  end;
end;

{ The following 2 methods are used by filtered dataset (with property Filtered=True) }
function TSDResultSet.FindNextRecord: Boolean;
begin
  Result := GetNextRecord;
end;

function TSDResultSet.FindPriorRecord: Boolean;
begin
  Result := False;
  while FPosition > 0 do begin
    Dec(FPosition);
    if IsVisibleRecord( FPosition ) then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TSDResultSet.FetchAll;
var
  SavePos: Integer;
begin
  if FAllInCache then Exit;

  SavePos := FPosition;
  while FetchRecord do
    ;
  FPosition := SavePos;
end;

{ Method fetchs the next record, which is cached, and increments FPosition in case of success }
function TSDResultSet.FetchRecord: Boolean;
var
  RecBuf: TSDRecordBuffer;
  NewRecPos: Integer;
{$IFDEF XSQL_CLR}
  RecInfo: TSDRecInfo;
  BookRec: TBookmarkRec;
{$ENDIF}
begin
	// if full result set is fetched or cursor was detached (offline)
  if FAllInCache or not FDataSet.ISqlConnected then begin
    Result := False;
    Exit;
  end;

  Result := FDataSet.ISqlFetch;
  if Result then begin
    RecBuf := FDataSet.AllocRecordBuffer;
    NewRecPos := Count;         // use Count, because FPosition  does not necessarily point to the end of result set
{$IFDEF XSQL_CLR}
    RecInfo := GetRecInfoStruct( RecBuf, FDataSet.FRecInfoOffs );
    BookRec := GetBookmarkRecStruct( RecBuf, FDataSet.FBookmarkOffs );
    with RecInfo do begin
      UpdateStatus := usUnmodified;
      RecordNumber := NewRecPos;
    end;
    with BookRec do
      iPos := NewRecPos;
    SetRecInfoStruct( RecBuf, FDataSet.FRecInfoOffs, RecInfo );
    SetBookmarkRecStruct( RecBuf, FDataSet.FBookmarkOffs, BookRec );
{$ELSE}
    with PSDRecInfo( RecBuf + FDataSet.FRecInfoOffs )^ do begin
      UpdateStatus := usUnmodified;
      RecordNumber := NewRecPos;
    end;
    with PBookmarkRec( RecBuf + FDataSet.FBookmarkOffs )^ do
      iPos := NewRecPos;
{$ENDIF}
    AddRecord(RecBuf);
    FPosition := NewRecPos;

	// get data from select buffer
    FDataSet.ISqlCnvtFieldsBuffer( RecBuf );
  end else
	// drop server cursor
    if FDataSet.FDetachOnFetchAll then
      FDataSet.Detach;

  FAllInCache := not Result;
end;

function TSDResultSet.GetCacheItem(Index: Integer): TCacheRecInfo;
begin
  if (Index < 0) or (Index >= Count) or not Assigned(Items[Index]) then
    DatabaseError(SRecordMissingLocally);

{$IFDEF XSQL_CLR}
  Result := TCacheRecInfo( Marshal.PtrToStructure(TSDPtr(Items[Index]), TypeOf(TCacheRecInfo)) );
{$ELSE}
  Result := PCacheRecInfo( Items[Index] )^;
{$ENDIF}
end;

procedure TSDResultSet.SetCacheItem(Index: Integer; Value: TCacheRecInfo);
begin
  if (Index < 0) or (Index >= Count) or not Assigned(Items[Index]) then
    DatabaseError(SRecordMissingLocally);

{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( Value, TSDPtr( Items[Index] ), False );
{$ELSE}
  PCacheRecInfo( Items[Index] )^ := Value;
{$ENDIF}
end;

function TSDResultSet.GetCurRecords(Index: Integer): TSDRecordBuffer;
begin
  Result := CacheItems[Index].CurRec;
end;

procedure TSDResultSet.SetCurRecords(Index: Integer; Value: TSDRecordBuffer);
var
  i: TCacheRecInfo;
begin
  i := CacheItems[Index];
  i.CurRec := Value;
  CacheItems[Index] := i;
end;

function TSDResultSet.GetOldRecords(Index: Integer): TSDRecordBuffer;
begin
  Result := CacheItems[Index].OldRec;
end;

procedure TSDResultSet.SetOldRecords(Index: Integer; Value: TSDRecordBuffer);
var
  i: TCacheRecInfo;
begin
  i := CacheItems[Index];
  i.OldRec := Value;
  CacheItems[Index] := i;
end;

function TSDResultSet.GetAppliedRecords(Index: Integer): Boolean;
begin
  ASSERT( (Index >= 0) and (Index < Count), '' );

  if Items[Index] = nil then
    Result := True
  else
    Result := CacheItems[Index].Applied;
end;

procedure TSDResultSet.SetAppliedRecords(Index: Integer; Value: Boolean);
var
  i: TCacheRecInfo;
begin
  i := CacheItems[Index];
  i.Applied := Value;
  CacheItems[Index] := i;
end;

function TSDResultSet.GetUpdateStatusRecords(Index: Integer): TUpdateStatus;
begin
  ASSERT( (Index >= 0) and (Index < Count), '' );

  if Items[Index] = nil then
    Result := usUnModified
  else
    Result := GetRecInfoStruct( CurRecords[Index], FDataSet.FRecInfoOffs ).UpdateStatus;
end;

procedure TSDResultSet.SetUpdateStatusRecords(Index: Integer; Value: TUpdateStatus);
var
  RecInfo: TSDRecInfo;
begin
  ASSERT( (Index >= 0) and (Index < Count), '' );

  if Items[Index] = nil then
    Exit;
  RecInfo := GetRecInfoStruct(CurRecords[Index], FDataSet.FRecInfoOffs);
  if RecInfo.UpdateStatus = Value then
    Exit;

  if RecInfo.UpdateStatus = usDeleted then
    Dec( FDeletedCount );
	// save update status for the required record
  RecInfo.UpdateStatus := Value;
  SetRecInfoStruct( CurRecords[Index], FDataSet.FRecInfoOffs, RecInfo );

  if Value = usDeleted then
    Inc( FDeletedCount );
end;

{ If the record is exist in cache only(not in database), then returns True }
function TSDResultSet.IsInsertedRecord(Index: Integer): Boolean;
begin
  if Items[Index] = nil then
    Result := False
  else
    Result := GetRecInfoStruct( CurRecords[Index], FDataSet.FRecInfoOffs ).BookmarkFlag = bfInserted;
end;

{ In a filter mode check what record is accessible }
function TSDResultSet.GetRecordCount: Integer;
var
  i, n: Integer;
begin
  if FDataSet.Filtered then begin
    i := 0;
    n := 0;
    while i < Count do begin
      if IsVisibleRecord(i) then
        Inc(n);
      Inc(i);
    end;
    Result := n;
  end else begin
    Result := Count - FDeletedCount;
  	// It can't be never (for checking)
    if Result < 0 then
      Result := 0;
  end;
end;

{ Copies a record buffer including Blob part }
procedure TSDResultSet.CopyRecBuf(const Source, Dest: TSDRecordBuffer);
var
  i: Integer;
  b: TSDBlobData;
begin
  b := nil;
  with FDataSet do begin
	// copy non-blob fields
    SafeCopyMem( Source, Dest, FBlobCacheOffs );
    	// copy TSDRecInfo and TBookmarkRec fields (at the end of buffer)
    SafeCopyMem( TSDPtr(Longint(Source) + FRecInfoOffs), TSDPtr(Longint(Dest) + FRecInfoOffs), FRecBufSize - FRecInfoOffs );
	// copy data of Blob fields
    if FIsBlobs then
      for i:=0 to FieldCount-1 do
        if Fields[i].IsBlob then begin
          b := GetFieldBlobData( Source, FBlobCacheOffs, Fields[i].Offset );
          SetFieldBlobData( Dest, FBlobCacheOffs, Fields[i].Offset, b );
        end;
  end;
end;

function TSDResultSet.GetRecord(Buffer: TSDRecordBuffer; GetMode: TGetMode): Boolean;
begin
  Result := False;

  case GetMode of
    gmCurrent:
      Result := GetCurrRecord;
    gmNext:
      Result := GetNextRecord;
    gmPrior:
      Result := GetPriorRecord;
  end;
  if Result then
    CopyRecBuf(CurRecords[FPosition], Buffer);
end;

{ Checks record visibility for user (for example, in TDBGrid) }
function TSDResultSet.IsVisibleRecord(Index: Integer): Boolean;
begin
  if (Index < 0) or (Index >= Count) then
    DatabaseError(SRecordMissingLocally);
    
  Result := False;
  case UpdateStatusRecords[Index] of
    usUnmodified:Result := rtUnmodified in FDataSet.FUpdateRecordTypes;
    usModified:	 Result := rtModified in FDataSet.FUpdateRecordTypes;
    usInserted:	 Result := rtInserted in FDataSet.FUpdateRecordTypes;
    usDeleted:	 Result := rtDeleted in FDataSet.FUpdateRecordTypes;
  end;

  if FilterActivated and Result then
    Result := RecordFilter(CurRecords[Index]);
end;

{ Inserts(Saves) the selected(from result set) record RecBuf to the cache }
function TSDResultSet.AddRecord(RecBuf: TSDRecordBuffer): Integer;
var
  p: TSDPtr;
  CacheItem: TCacheRecInfo;
  i: Integer;
begin
  p := SafeReallocMem(nil, SizeOf(TCacheRecInfo));
  CacheItem.CurRec := RecBuf;
  CacheItem.OldRec := nil;
  CacheItem.Applied := True;
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr(CacheItem, p, False);
{$ELSE}
  SafeCopyMem(@CacheItem, p, SizeOf(TCacheRecInfo));
{$ENDIF}
  Result := Add(p);
	// clear cache in case of necessity
  if DataSet.UniDirectional then begin
	// BufferCount is equal 1 (when the dataset is not associated with visual components) or depends from datalinks
    i := Count - DataSet.GetBufferCount - 1;
    if (i >= 0) and (Items[i] <> nil) and (UpdateStatusRecords[i] = usUnModified) then
      ClearCacheItem(i);
  end;
end;

// Return an index in the cache of the record with the specified DataSet.RecNo (TRecInfo.RecordNumber)
function TSDResultSet.GetIndexOfRecord(ARecNumber: Integer): Integer;
var
  i: Integer;
  RecInfo: TSDRecInfo;
begin
  Result := -1;
  for i:=0 to Count -1 do begin
    RecInfo := GetRecInfoStruct( CurRecords[i], DataSet.FRecInfoOffs );
    if (RecInfo.RecordNumber = ARecNumber) and (RecInfo.UpdateStatus <> usDeleted) then begin
      Result := i;
      Break;
    end;
  end;
end;

// compute TSDRecInfo.RecordNumber value for the inserted record in the specified position
function TSDResultSet.GetNewRecordNumber(AInsertedRecIndex: Integer): Integer;
var
  i: Integer;
  RecInfo: TSDRecInfo;
begin
  Result := -1;
        // find RecordNumber of the previous valid (not deleted) record
  for i:= AInsertedRecIndex - 1 downto 0 do begin
    RecInfo := GetRecInfoStruct( CurRecords[i], DataSet.FRecInfoOffs );
    if (RecInfo.RecordNumber >= 0) and (RecInfo.UpdateStatus <> usDeleted) then begin
      Result := RecInfo.RecordNumber;
      Break;
    end;
  end;
  Inc( Result );     // RecordNumber of inserted record
end;

// Frees record buffers and removes the record from the cache.
// Changes BookmarkRec.iPos and RecInfo.RecordNumber for the rest of the records
procedure TSDResultSet.DeleteCacheItem(Index: Integer);
var
  i: Integer;
  RecInfo: TSDRecInfo;
  TmpBuf: TSDRecordBuffer;
begin
  ClearCacheItem(Index);

  Delete(Index);
	// change current position for records in the cache (before deleted position)
  for i:=Index to Count-1 do begin
    TmpBuf := CurRecords[i];
    SetBookmarkRecStruct( TmpBuf, FDataSet.FBookmarkOffs, i );
    RecInfo := GetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs );
    if (RecInfo.RecordNumber > 0) and (RecInfo.UpdateStatus <> usDeleted) then
      SetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs, RecInfo.RecordNumber - 1 );
    TmpBuf := OldRecords[i];
    if TmpBuf <> nil then begin
      SetBookmarkRecStruct( TmpBuf, FDataSet.FBookmarkOffs, i );
      if (RecInfo.RecordNumber > 0) and (RecInfo.UpdateStatus <> usDeleted) then
        SetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs, RecInfo.RecordNumber - 1 );
    end;
  end;
end;

//  If a record still not exist in database, then remove it from the cache.
// Else only marks the record in the cache as deleted.
// Returns record Index in RecCache.
function TSDResultSet.DeleteRecord(RecBuf: TSDRecordBuffer): Integer;
var
  i, Idx: Integer;
  RecInfo: TSDRecInfo;
  TmpBuf: TSDRecordBuffer;
begin
  Idx := GetBookmarkRecStruct( RecBuf, DataSet.FBookmarkOffs ).iPos;
  	// if record still not in database
  if UpdateStatusRecords[Idx] = usInserted then
    DeleteCacheItem( Idx )
  else begin
  	// else mark for delete in database
    UpdateStatusRecords[Idx] := usDeleted;
    AppliedRecords[Idx] := False;
    SetRecInfoStruct( CurRecords[Idx], DataSet.FRecInfoOffs, -1 );
    if OldRecords[Idx] <> nil then
      SetRecInfoStruct( OldRecords[Idx], DataSet.FRecInfoOffs, -1 );
        // update the following record info (RecordNumber), after deleted record
    for i:=Idx + 1 to Count-1 do begin
      TmpBuf := CurRecords[i];
      RecInfo := GetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs );
      if (RecInfo.RecordNumber > 0) and (RecInfo.UpdateStatus <> usDeleted) then
        SetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs, RecInfo.RecordNumber - 1 );
      if OldRecords[i] <> nil then
        if (RecInfo.RecordNumber > 0) and (RecInfo.UpdateStatus <> usDeleted) then
          SetRecInfoStruct( OldRecords[i], DataSet.FRecInfoOffs, RecInfo.RecordNumber - 1 );
    end;
  end;
  Result := Idx;
end;

{ Adds inserted (of the user) record in the cache(in the current or end position) and returns a cache index of the inserted record }
function TSDResultSet.InsertRecord(RecBuf: TSDRecordBuffer; Append, SetCurrent: Boolean): Integer;
var
  NewBuf, TmpBuf: TSDRecordBuffer;
  p: TSDPtr;
  CacheItem: TCacheRecInfo;
  RecInfo: TSDRecInfo;
  i, RecPos, NewRecNum: Integer;
begin
        // get position of the inserted record in the cache
  RecPos := GetBookmarkRecStruct( RecBuf, DataSet.FBookmarkOffs ).iPos;
  	// if SetBookmarkData method still not called and TBookmarkRec structure still not initialized
  if RecPos < 0 then begin
    if Append then
      RecPos := Count
    else
      if FPosition >= 0
      then RecPos := FPosition
      else RecPos := 0;
  end;
        // find RecordNumber of inserted record
  NewRecNum := GetNewRecordNumber(RecPos);

  NewBuf := DataSet.AllocRecordBuffer;
  CopyRecBuf(RecBuf, NewBuf);	// copy with Blob-fields

  RecInfo := GetRecInfoStruct( NewBuf, DataSet.FRecInfoOffs );
  RecInfo.UpdateStatus := usInserted;
  RecInfo.BookmarkFlag := bfCurrent;
  RecInfo.RecordNumber := NewRecNum;
  SetRecInfoStruct( NewBuf, DataSet.FRecInfoOffs, RecInfo );

  CacheItem.CurRec := NewBuf;
  CacheItem.OldRec := nil;
  CacheItem.Applied := False;
  p := SafeReallocMem(nil, SizeOf(TCacheRecInfo));
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr(CacheItem, p, False);
{$ELSE}
  SafeCopyMem(@CacheItem, p, SizeOf(TCacheRecInfo));
{$ENDIF}

  SetBookmarkRecStruct( NewBuf, DataSet.FBookmarkOffs, RecPos );
  	// insert at the, cache in required position
  Insert( RecPos, p);
	// if new record is inserted at center of the cache, then update the following record info
  for i:= RecPos + 1 to Count-1 do begin
    TmpBuf := CurRecords[i];
    SetBookmarkRecStruct( TmpBuf, DataSet.FBookmarkOffs, i );
    RecInfo := GetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs );
    if (RecInfo.RecordNumber >= 0) and (RecInfo.UpdateStatus <> usDeleted) then
      SetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs, RecInfo.RecordNumber + 1 );
    TmpBuf := OldRecords[i];
    if TmpBuf <> nil then begin
      SetBookmarkRecStruct( TmpBuf, DataSet.FBookmarkOffs, i );
      if (RecInfo.RecordNumber >= 0) and (RecInfo.UpdateStatus <> usDeleted) then
        SetRecInfoStruct( TmpBuf, DataSet.FRecInfoOffs, RecInfo.RecordNumber + 1 );
    end;
  end;
  	// if need to set new record to current record
  if SetCurrent then
    FPosition := RecPos;
  Result := RecPos;

        // set info for the passed buffer
  SetRecInfoStruct( RecBuf, DataSet.FRecInfoOffs, Result );
  SetBookmarkRecStruct( RecBuf, DataSet.FBookmarkOffs, Result )
end;

{ It is used in dataset's SortRecords method }
procedure TSDResultSet.ExchangeRecords(Index1, Index2: Integer);
var
  CacheItemPtr: TSDPtr;
  CacheItem1, CacheItem2: TCacheRecInfo;
  RecInfo1, RecInfo2: TSDRecInfo;
  BookRec1, BookRec2: TBookmarkRec;
  UpdStatus: TUpdateStatus;
begin
  CacheItemPtr  := TSDPtr( Items[Index1] );
  Items[Index1] := Items[Index2];
  Items[Index2] := CacheItemPtr;
        // exchange TSDRecInfo and TSDBookmarkRec parts for the records
  CacheItem1    := CacheItems[Index1];
  CacheItem2    := CacheItems[Index2];

  RecInfo1 := GetRecInfoStruct( CacheItem1.CurRec, DataSet.FRecInfoOffs );
  BookRec1 := GetBookmarkRecStruct( CacheItem1.CurRec, DataSet.FBookmarkOffs );

  RecInfo2 := GetRecInfoStruct( CacheItem2.CurRec, DataSet.FRecInfoOffs );
  BookRec2 := GetBookmarkRecStruct( CacheItem2.CurRec, DataSet.FBookmarkOffs );
        // UpdateStatus has to stay with old record
  UpdStatus := RecInfo1.UpdateStatus;
  RecInfo1.UpdateStatus := RecInfo2.UpdateStatus;
  RecInfo2.UpdateStatus := UpdStatus;

  SetRecInfoStruct( CacheItem1.CurRec, DataSet.FRecInfoOffs, RecInfo2 );
  SetBookmarkRecStruct( CacheItem1.CurRec, DataSet.FBookmarkOffs, BookRec2 );
  if Assigned( CacheItem1.OldRec ) then begin
    SetRecInfoStruct( CacheItem1.OldRec, DataSet.FRecInfoOffs, RecInfo2 );
    SetBookmarkRecStruct( CacheItem1.OldRec, DataSet.FBookmarkOffs, BookRec2 );
  end;

  SetRecInfoStruct( CacheItem2.CurRec, DataSet.FRecInfoOffs, RecInfo1 );
  SetBookmarkRecStruct( CacheItem2.CurRec, DataSet.FBookmarkOffs, BookRec1 );
  if Assigned( CacheItem2.OldRec ) then begin
    SetRecInfoStruct( CacheItem2.OldRec, DataSet.FRecInfoOffs, RecInfo1 );
    SetBookmarkRecStruct( CacheItem2.OldRec, DataSet.FBookmarkOffs, BookRec1 );
  end;
end;

{ Changes the record in the cache (without blob part) }
procedure TSDResultSet.ModifyRecord(RecBuf: TSDRecordBuffer);
var
  Idx: Integer;
  Buf: TSDRecordBuffer;
begin
  Idx := GetBookmarkRecStruct( RecBuf, DataSet.FBookmarkOffs ).iPos;
  if (UpdateStatusRecords[Idx] in [usUnmodified, usModified]) and
     (OldRecords[Idx] = nil )
  then with DataSet do begin
    Buf := AllocRecordBuffer;
    OldRecords[Idx] := Buf;
    CopyRecBuf(CurRecords[Idx], OldRecords[Idx]);

    UpdateStatusRecords[Idx] := usModified;
  end;
  AppliedRecords[Idx] := False;  
  SafeCopyMem( RecBuf, CurRecords[Idx], DataSet.FBlobCacheOffs );
end;

{ Stores Blob data in the record cache for the passed record }
procedure TSDResultSet.ModifyBlobData(Field: TField; RecBuf: TSDRecordBuffer; const Value: TSDBlobData);
var
  Idx: Integer;
begin
	// if the record temporary and still not present in the cache now
  if GetRecInfoStruct( RecBuf, DataSet.FRecInfoOffs ).BookmarkFlag = bfInserted then
    Exit;
    	// get a position in a record cache
  Idx := GetBookmarkRecStruct( RecBuf, DataSet.FBookmarkOffs ).iPos;
	// If the record is only inserted and still not present in the cache. It will be in the cache after call Post method
  if Idx < 0 then
    Exit;
  if (UpdateStatusRecords[Idx] in [usUnmodified, usModified]) and
     (OldRecords[Idx] = nil )
  then
    ModifyRecord(RecBuf);
	// save new Blob-data in the current record buffer
  SetFieldBlobData( CurRecords[Idx], DataSet.FBlobCacheOffs, Field.Offset, Value );
end;

{ Cancel modifications for the current record }
function TSDResultSet.UpdatesCancelCurrent: Integer;
var
  i: Integer;
  p: TSDRecordBuffer;
begin
  i := GetBookmarkRecStruct( DataSet.ActiveBuffer, DataSet.FBookmarkOffs ).iPos;
  if not AppliedRecords[i] then begin
    if UpdateStatusRecords[i] = usModified then begin
  	// delete current record and restore data from old record buffer
      p := CacheItems[i].CurRec;
      FDataSet.FreeRecordBuffer( p );
      CurRecords[i] := OldRecords[i];
      OldRecords[i] := nil;
      AppliedRecords[i] := True;
    end else if UpdateStatusRecords[i] = usInserted then
      DeleteCacheItem(i)
    else if UpdateStatusRecords[i] = usDeleted then begin
      UpdateStatusRecords[i] := usUnmodified;
      AppliedRecords[i] := True;
    end;

  end;
  Result := SDE_ERR_NONE;
end;

{ Cancel all modifications in the cache }
function TSDResultSet.UpdatesCancel: Integer;
var
  i: Integer;
  p: TSDRecordBuffer;
begin
  i := 0;
  while i < Count do begin
    if UpdateStatusRecords[i] <> usUnmodified then
      if UpdateStatusRecords[i] = usModified then begin			// if record was modified
        p := CacheItems[i].CurRec;
        FDataSet.FreeRecordBuffer( p );
        CurRecords[i] := OldRecords[i];
        OldRecords[i] := nil;
        UpdateStatusRecords[i] := usUnmodified;
        AppliedRecords[i] := True;
      end else if UpdateStatusRecords[i] = usInserted  then begin	// if record was inserted
        DeleteCacheItem(i);
        Dec(i);
      end else if UpdateStatusRecords[i] = usDeleted  then begin	// if record was deleted
        UpdateStatusRecords[i] := usUnmodified;
        AppliedRecords[i] := True;
      end;

    Inc(i);
  end;
  Result := SDE_ERR_NONE;
end;

{ Releases buffers of the old record, which were stored in a database, and sets record status to unmodified }
function TSDResultSet.UpdatesCommitRecord(Index: Integer): Boolean;
var
  CacheItem: TCacheRecInfo;
begin
  Result := False;
  if (Index < 0) or (Index > Count) or (not AppliedRecords[Index]) then
    Exit;

  case UpdateStatusRecords[Index] of
    usModified:
      begin
        CacheItem := CacheItems[Index];
        FDataSet.FreeRecordBuffer( CacheItem.OldRec );
        CacheItems[Index] := CacheItem;
        UpdateStatusRecords[Index] := usUnmodified;
        AppliedRecords[Index] := True;
      end;
    usInserted:
      begin
        UpdateStatusRecords[Index] := usUnmodified;
        AppliedRecords[Index] := True;
      end;
    usDeleted:
      begin
        DeleteCacheItem(Index);
      end;
  end;
  Result := True;
end;

{   Commits all changes in the cache, which was successfully saved in database(UpdateStatus=unUnmodified),
i.e. if AppliedRecords[i]=True, then old record buffers is released and set UpdateStatus:=usUnmodified
}
function TSDResultSet.UpdatesCommit: Integer;
var
  i: Integer;
  nDeletedRows: Integer;	// number of deleted row before the current position
  us: TUpdateStatus;
begin
  i := 0;
  nDeletedRows := 0;
  while i < Count do begin
    if AppliedRecords[i] then begin
    	// save deleted status before UpdatesCommitRecord call, which will remove record buffer
      us := UpdateStatusRecords[i];
      if UpdatesCommitRecord(i) and (us = usDeleted) then begin
        	// the deleted row is removed from the cache
        if FDeletedCount > 0 then
          Dec(FDeletedCount);
		// how many record was deleted before the current record
        if i <= FPosition then
          Inc(nDeletedRows);

        Dec(i);
      end;
    end;
    Inc(i);
  end;
	// a cache position of the current row is changed,
        // but the current visible row is not changed
  FPosition := FPosition - nDeletedRows;
  Result := SDE_ERR_NONE;
end;

{
 Mark modifications in local cache as not saved in a database.
 If saving was successful, AppliedRecords[i]=True,
 but if transaction is rolled back, changes are actually not saved
}
function TSDResultSet.UpdatesRollback: Integer;
var
  i: Integer;
begin
  i := 0;
  while i < Count do begin
    if AppliedRecords[i] and (UpdateStatusRecords[i] <> usUnmodified) then
      AppliedRecords[i] := False;
    Inc(i);
  end;
  Result := SDE_ERR_NONE;
end;

{ Apply(save) changes in database. If saving is successful, then set AppliedRecords[i]:=True }
function TSDResultSet.UpdatesPrepare: Integer;
  function IsEnableUpdateRecord( AUpdateKinds: TUpdateKinds; Value: TUpdateStatus): Boolean;
  begin
    Result :=
    	(Value = usModified) and (ukModify in AUpdateKinds) or
    	(Value = usInserted) and (ukInsert in AUpdateKinds) or
	(Value = usDeleted) and (ukDelete in AUpdateKinds);
  end;
var
  i, j: Integer;
  UpdateAction: TUpdateAction;
  UpdateKind: TUpdateKind;
  EnableUpdKinds: TUpdateKinds;
  rtSave: TUpdateRecordTypes;
  evBeforeScroll, evAfterScroll: TDataSetNotifyEvent;
  SavePos: Integer;
  FilterState: Boolean;
  sql: TISqlCommand;
  sStmt: string;
begin
  Result := SDE_ERR_UPDATEABORT;
  DataSet.DisableControls;
  SavePos := FPosition;			// save current record position
	// store dataset's states
  rtSave := DataSet.FUpdateRecordTypes;
  FilterState := DataSet.Filtered;
  EnableUpdKinds := DataSet.EnableUpdateKinds;
  evBeforeScroll := DataSet.BeforeScroll;
  evAfterScroll	 := DataSet.AfterScroll;
  DataSet.BeforeScroll := nil;
  DataSet.AfterScroll  := nil;
  sql := nil;

  try
	// it sets ALL records visible when we go through result set (for Next, GetRecord methods),
        //else IsVisibleRecord will return False for the excluded record
    DataSet.FUpdateRecordTypes := [rtModified, rtInserted, rtDeleted, rtUnmodified];
    DataSet.Filtered		:= False;
    DataSet.First;
    while not DataSet.EOF do begin
      i := IndexOfRecord(DataSet.ActiveBuffer);
      UpdateAction := uaFail;
	// apply the record ?
      if (not AppliedRecords[i]) and
         (not ( (UpdateStatusRecords[i] in [usDeleted]) and IsInsertedRecord(i) )) and
         IsEnableUpdateRecord( EnableUpdKinds, UpdateStatusRecords[i] )
      then begin
        ASSERT( UpdateStatusRecords[i] in [usModified, usInserted, usDeleted], 'UpdateStatus out of range' );

        UpdateKind := TUpdateKind( Ord(UpdateStatusRecords[i])-1 );
        try
          if Assigned(DataSet.FOnUpdateRecord) then
            DataSet.FOnUpdateRecord(DataSet, UpdateKind, UpdateAction)
          else if Assigned(DataSet.FUpdateObject) then begin
            DataSet.FUpdateObject.Apply(UpdateKind);
            UpdateAction := uaApplied;
          end else
            DatabaseError(SUpdateImpossible);
            	// get autoincrement field
          if DataSet.AutoRefresh and (UpdateKind = ukInsert) then begin
            if not Assigned(sql) then
              sql := DataSet.ISqlCmdCreate;
            sStmt := sql.SqlDatabase.GetAutoIncSQL;
            if sStmt <> '' then begin
              sql.InitNewCommand;
        	// returns a result set with one field
              sql.Prepare(sStmt);
              sql.Execute;
              if sql.FetchNextRow then begin
			// only one field can be autoincremented
                for j:=0 to DataSet.FieldCount-1 do begin
                  if ((DataSet.Fields[j].DataType = ftAutoInc) {$IFDEF XSQL_VCL5} or (DataSet.Fields[j].AutoGenerateValue = arAutoInc) {$ENDIF})
                     //and DataSet.Fields[j].IsNull
                  then begin
                    DataSet.ISqlCnvtFieldData(sql, sql.FieldDescs[0], CurRecords[i], DataSet.Fields[j]);
                    Break;
                  end;
                end;
              end;
              sql.CloseResultSet;	// stop processing of SQL command (release connection). It is important for MSSQL, Sybase
            end;
          end;
        except
          on E: Exception do begin
            if (E is EDatabaseError) and Assigned(FDataSet.FOnUpdateError) then
              FDataSet.FOnUpdateError(FDataSet, EDatabaseError(E), UpdateKind, UpdateAction)
            else	// re-raise all other exceptions
              raise;
          end;
        end;
        if UpdateAction in [uaAbort, uaFail] then begin
          if UpdateAction = uaAbort then
            Result := SDE_ERR_UPDATEABORT;
          Exit;
        end;
        if UpdateAction = uaApplied then
          AppliedRecords[i] := True;
      end;		// end of (IF THEN) apply the record
      	// if it is not necessary to apply record again, then go to the following
      if UpdateAction <> uaRetry then begin
      	// if the next record is not cached at present, then break from cycle
        if (i + 1) >= Count then
          Break
        else
          FDataSet.Next;
      end;
    end;	// WHILE not FDataSet.EOF do
  finally
    FDataSet.BeforeScroll := evBeforeScroll;
    FDataSet.AfterScroll  := evAfterScroll;
    FDataSet.FUpdateRecordTypes := rtSave;
    if not Assigned(sql) then
      sql.Free;

    if FDataSet.Filtered <> FilterState then
      FDataSet.Filtered	:= FilterState;
    FPosition := SavePos;		// restore current record position after filter mode is restored
    FDataSet.EnableControls;
  end;
  Result := SDE_ERR_NONE;
end;


(*******************************************************************************
				TSDDataSet
*******************************************************************************)
constructor TSDDataSet.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FCachedUpdates := True;
  FCacheBlobs := True;
  FUniDirectional  := False;
  FDetachOnFetchAll:= False;
  FForceClosing	   := False;
  FGetNextResultSet:= False;
  FClearFieldDefsOnClose:= False;
  FRecordSize := 0;
  FRecBufSize := 0;
  FFieldBufOffs := nil;

  FUpdateMode		:= upWhereAll;
  FEnableUpdateKinds	:= [];
  FUpdateRecordTypes	:= [];
	// if a component is loaded in design time, this property will be overrided
  if (csDesigning in ComponentState) and Assigned(DefDatabase) then
    FDataBaseName := DefDatabase.DatabaseName;
end;

destructor TSDDataSet.Destroy;
begin
{$IFDEF XSQL_VCL5}
  FreeAndNil(FExprFilter);
{$ENDIF}
  if Assigned( FFieldBufOffs ) then begin
    SetLength( FFieldBufOffs, 0 );
    FFieldBufOffs := nil;
  end;

  if UpdateObject <> nil then
    SetUpdateObject(nil);

  inherited Destroy;
end;

procedure TSDDataSet.CheckDatabaseName;
begin
  if FDatabaseName = '' then
    DatabaseError(SDatabaseNameMissing);
end;

procedure TSDDataSet.CheckDBSessionName;
var
  S: TXSQLSession;
  Database: TXSQLDatabase;
begin
  if (SessionName <> '') and (DatabaseName <> '') then begin
    S := Sessions.FindSession(SessionName);
    if Assigned(S) and not Assigned(S.DoFindDatabase(DatabaseName, Self)) then begin
      Database := DefaultSession.DoFindDatabase(DatabaseName, Self);
      if Assigned(Database) then
        Database.CheckSessionName(True);
    end;
  end;
end;

procedure TSDDataSet.CheckCanModify;
begin
  if not CanModify then DatabaseError(SDataSetReadOnly, Self);
end;

procedure TSDDataSet.DestroyHandle;
begin
  DestroySqlCommand( FForceClosing );
end;

procedure TSDDataSet.Disconnect;
begin
  Close;
  DestroyHandle;
end;

{ Sets a result set to offline: close cursor and keep result set active }
procedure TSDDataSet.Detach;
begin
  ISqlCloseResultSet;
  ISqlDetach;   // drop a connection of TISqlCommand. FSqlCmd is not destroyed
end;


procedure TSDDataSet.ForceClose;
begin
  FForceClosing := True;
  try
    try
    	// ISqlCloseResultSet method could raise a database exception (on some server), which is need to hide
        // If a connection was dropped and Close will raise an error,
        //then the error will be hided and ForceClose will be called repeatedly for this dataset
      Close;
	// to exclude to parse and set off all flags
      if FDSFlags <> [] then begin
        FDSFlags := [dsfOpened];
      	// set off the last flag to call Disconnect and UnregisterClient methods
        SetDSFlag(dsfOpened, False);
      end;
    except
      on E: Exception do
        if not (E is ESDEngineError) then
          raise;
    end;
  finally
    FForceClosing := False;
  end;
end;

procedure TSDDataSet.DestroySqlCommand(Force: Boolean);
begin
  if FSqlCmd <> nil then begin
    FSqlCmd.Disconnect(Force);

    FSqlCmd.Free;
    FSqlCmd := nil;
  end;
end;

function TSDDataSet.GetServerType: TSDServerType;
var
  db: TXSQLDatabase;
begin
  if FDatabase <> nil then
    Result := FDatabase.FServerType
  else begin
    db := Sessions.FindDatabase(DatabaseName);
    if db = nil then
      db := Session.OpenDatabase(DatabaseName);
    Result := db.ServerType
  end;
end;

procedure TSDDataSet.CloseCursor;
begin
  SetBusyState;
  try
    ISqlCloseResultSet;
    	// do not destroy TISqlCommand, when next result set is processed or command/procedure is prepared
    if not (FGetNextResultSet or (dsfPrepared in DSFlags) or (dsfStoredProc in DSFlags)) then
      DestroyHandle;
    inherited CloseCursor;
    SetDSFlag(dsfOpened, False);
  finally
    ResetBusyState;
  end;
end;

procedure TSDDataSet.OpenCursor(InfoQuery: Boolean);
begin
  SetBusyState;
  try
    SetDSFlag(dsfOpened, True);
    if not ISqlConnected then
      CreateHandle;     // it creates and prepares or execute a command
    if not FSqlCmd.ResultSetExists then begin
        // execute statement, which cannot return a result set. For example: select * into #temp from table or call proc
      InternalOpen;
      InternalClose;

      DestroyHandle;
      ResetBusyState;
      raise ESDNoResultSet.Create(SHandleError);
    end;
    inherited OpenCursor(InfoQuery);    
  finally
    ResetBusyState;
  end;
end;

procedure TSDDataSet.ExecuteCursor;
begin
  SetConnectionState( True );
  try
    ISqlExecute;
  finally
    SetConnectionState( False );
  end;
end;

{ Marks that a statement is running on server-side }
procedure TSDDataSet.SetConnectionState(IsBusy: Boolean);
begin
  ASSERT( Assigned(Database) );

  Database.FIsConnectionBusy := IsBusy;
end;

function TSDDataSet.IsCursorOpen: Boolean;
begin
  Result := dsfOpened in DSFlags;
end;

procedure TSDDataSet.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TSDDataSet.InternalInitFieldDefs;
var
  TmpFieldDefs: TFieldDefs;
{$IFDEF XSQL_VCL4}
  fd: TFieldDef;
  s: string;
  bValue: Boolean;
{$ENDIF}
  bRequired: Boolean;
  i, fdsize: Integer;
begin
  if Active and (not FGetNextResultSet) then
    Exit;

  ClearFieldDefs;
	// initialize SqlCmd.FieldDescs structure forced, if database does not support field describing after Prepare
  if SqlCmd.FieldDescs.Count = 0 then
    ISqlInitFieldDefs;

  TmpFieldDefs := TFieldDefs.Create( Self );
  try
    for i:=0 to SqlCmd.FieldDescs.Count-1 do
      with SqlCmd.FieldDescs[i] do begin
        if IsRequiredSizeTypes( FieldType ) then begin
          fdsize := DataSize;
		// FieldDescs[i].DataSize includes space for zero-terminator, but
        	// FieldDef.Size (for string types) has to be equal string length (w/o zero-terminator).
          if (fdsize > 0) and (FieldType in [ftString]) then
            Dec(fdsize);
        end else
          fdsize := 0;
        // TBCDField.Size indicates the number digits after the decimal point
        if FieldType in [ftBCD] then
          fdsize := SqlCmd.FieldDescs[i].Scale;
{$IFDEF XSQL_VCL5}
        // TGuidField.Size has to be equal 38 bytes always
        if FieldType = ftGuid then
          fdsize := SizeOfGuidString;
{$ENDIF}
        bRequired := Required;
        // set off Required property for AutoInc fields, when AutoRefresh is on
        if AutoRefresh and (FieldType = ftAutoInc) then
          bRequired := False;
{$IFDEF XSQL_VCL4}
        fd := TFieldDef.Create(TmpFieldDefs, FieldName, FieldType, fdsize, bRequired, FieldNo);

        if FieldType in [ftBCD, ftFloat] then
          fd.Precision := Precision;
{$ELSE}
        TmpFieldDefs.Add( FieldName, FieldType, fdsize, bRequired );

        if FieldType in [ftBCD, ftFloat] then
          TmpFieldDefs.Items[TmpFieldDefs.Count-1].Precision := Precision;
{$ENDIF}
      end;
{$IFDEF XSQL_VCL4}
        // if szFIELDREQUIRED database parameter is present
    s := UpperCase( Trim( Database.Params.Values[szFIELDREQUIRED] ) );
    if s <> '' then begin
      bValue := s = STrueString;
      for i:=0 to TmpFieldDefs.Count-1 do
        TmpFieldDefs[i].Required := bValue;
    end;
{$ENDIF}
    Self.FieldDefs := TmpFieldDefs;
  finally
    TmpFieldDefs.Free;
  end;
end;

procedure TSDDataSet.ClearFieldDefs;
begin
  FieldDefs.Clear;
end;

{ It is necessary for initialization of the result set without or after execute }
procedure TSDDataSet.InitResultSet;
begin
	// private field FieldDefs.FUpdated = False if modified properties of component(DataEvent(dePropertyChanged))
  if FieldDefs.Count = 0 then InternalInitFieldDefs;
  if DefaultFields and (FieldCount = 0) then CreateFields;

	// calculates BlobFieldCount and CalcFieldsSize, field numeration (set FieldNo property)
  BindFields(True);
	// sets FFieldBufOffs, FRecordSize and other pointers in the record buffer
  InitBufferPointers;
end;

procedure TSDDataSet.DoneResultSet;
begin
  if Assigned( FFieldBufOffs ) then begin
	// resets field's offsets in the record buffer
    SetLength( FFieldBufOffs, 0 );
    FFieldBufOffs := nil;
  end;
	// resets BlobFieldCount and CalcFieldsSize
  BindFields(False);

  if DefaultFields then DestroyFields;
        // It is important when FieldDefs was generated in offline using Fields.
        //At general(online) FieldDefs order has to conform to FSqlCmd.FieldDescs order
  if FClearFieldDefsOnClose then begin
    ClearFieldDefs;
    FClearFieldDefsOnClose := False;
  end;
end;

{ IsExec is True, when a cursor has to be connected and executed. In offline mode IsExec is False. }
procedure TSDDataSet.DoInternalOpen(IsExec: Boolean);
begin
        // ??? execute cursor before request of field definitions(InitResultSet) v.4.3 ???
//  if IsExec then
//    ExecuteCursor;
	// create field definitions, fields, init record size and set select buffer
  InitResultSet;
        // create a cache object
  CacheInit;
  if IsExec then
    ExecuteCursor;

  FEnableUpdateKinds	:= [ukModify, ukInsert, ukDelete];
  FUpdateRecordTypes	:= [rtModified, rtInserted, rtUnmodified];

{$IFDEF XSQL_VCL5}
  if (Filter <> '') and not Assigned(FExprFilter) then
    FExprFilter := CreateExprFilter(Trim(Filter), FilterOptions);
{$ENDIF}
end;

procedure TSDDataSet.InternalOpen;
begin
  DoInternalOpen(True);
end;

procedure TSDDataSet.InternalClose;
begin
{$IFDEF XSQL_VCL5}
  if DefaultFields and Assigned(FExprFilter) then
    FExprFilter.ClearFields;
{$ENDIF}

  CacheDone;

  DoneResultSet;

  FEnableUpdateKinds	:= [];
  FUpdateRecordTypes	:= [];
end;

procedure TSDDataSet.OpenEmpty;
begin
{$IFNDEF XSQL_VCL5}
  DatabaseError(SNoCapability);	// because SetDefaultFields and UpdateBufferCount methods of TDataSet are not accessible in D3&4
{$ELSE}
  DoBeforeOpen;

  if FieldCount = 0 then
    SetDefaultFields(True)
  else if FieldDefs.Count = 0 then begin
    InitFieldDefsFromFields;	// create FieldDefs from persistent fields, if it's possible
    FClearFieldDefsOnClose := True;     // because persistent fields(and FieldDefs) can have different order in contrast to physical one in a statement
  end;
	// if a structure of result set is unknown, try to describe it
  if FieldDefs.Count = 0 then begin
	// assign and prepare SqlCmd property
    OpenCursor(True);
    if Assigned(SqlCmd) and Assigned(SqlCmd.Handle) then
      Detach;
  end else
    SetDSFlag(dsfOpened, True);	// after that IsCursorOpen will be equal True. It's required in UpdateBufferCount

  DoInternalOpen(False);
	// modify FBuffers, when IsCursorOpen is True
  UpdateBufferCount;

  SetState(dsBrowse);
  DoAfterOpen;
        // set property to exclude an attempt of fetch records
  FRecCache.FAllInCache := True;
{$ENDIF}
end;

{ Returns a default session, when the specified one is not found }
function TSDDataSet.GetDBSession: TXSQLSession;
begin
  if Assigned( FDatabase ) then
    Result := FDatabase.Session
  else
    Result := Sessions.FindSession(SessionName);
    
  if Result = nil then
    Result := DefaultSession;
end;

function TSDDataSet.OpenDatabase: TXSQLDatabase;
begin
  with Sessions.List[FSessionName] do
    Result := DoOpenDatabase(FDatabaseName, Self.Owner);
end;

procedure TSDDataSet.CloseDatabase(Database: TXSQLDatabase);
begin
  if Assigned(Database) then
    Database.Session.CloseDatabase(Database);
end;

procedure TSDDataSet.SetAutoRefresh(const Value: Boolean);
begin
  CheckInactive;
  FAutoRefresh := Value;
end;

procedure TSDDataSet.SetDatabaseName(const Value: string);
begin
  if csReading in ComponentState then
    FDatabaseName := Value
  else if FDatabaseName <> Value then begin
    CheckInactive;
    if FDatabase <> nil then DatabaseError(SDatabaseOpen);
    FDatabaseName := Value;
    DataEvent(dePropertyChange, {$IFDEF XSQL_CLR} nil {$ELSE} 0 {$ENDIF});
  end;
end;

procedure TSDDataSet.SetSessionName(const Value: string);
begin
  if FSessionName <> Value then begin
    CheckInactive;
    FSessionName := Value;
    DataEvent(dePropertyChange, {$IFDEF XSQL_CLR} nil {$ELSE} 0 {$ENDIF});
  end;
end;

function TSDDataSet.SetDSFlag(Flag: Integer; Value: Boolean): Boolean;
begin
  Result := Flag in FDSFlags;
  if Value then begin
    if not (Flag in FDSFlags) then begin
      if FDSFlags = [] then begin
        CheckDBSessionName;
        if Trim(DatabaseName) = '' then
          DatabaseError(SDatabaseNameMissing);
        FDatabase := OpenDatabase;
        FDatabase.RegisterClient(Self);
      end;
      Include(FDSFlags, Flag);
    end;
  end else begin
    if Flag in FDSFlags then begin
      Exclude(FDSFlags, Flag);
      if FDSFlags = [] then begin
        Disconnect;
                // for insurance, it can be nil, when SetDSFlag is called from ForceClose
        if Assigned(FDatabase) then begin
          FDatabase.UnregisterClient(Self);
          FDatabase.Session.CloseDatabase(FDatabase);
        end;
        FDatabase := nil;
      end;
    end;
  end;
end;

procedure TSDDataSet.SetDetachOnFetchAll(Value: Boolean);
begin
  if Value <> FDetachOnFetchAll then begin
    if Active then
      Detach;
    FDetachOnFetchAll := Value;
  end;
end;

procedure TSDDataSet.SetUniDirectional(const Value: Boolean);
begin
  if Value <> FUniDirectional then
    FUniDirectional := Value;
{$IFDEF XSQL_VCL6}
// ATTENTION !!! TDBGrid raises "Operation is not allowed" error in process of opening
//  inherited SetUniDirectional(Value);
{$ENDIF}
end;

procedure TSDDataSet.SetUpdateMode(const Value: TUpdateMode);
begin
  if Value <> FUpdateMode then
    FUpdateMode := Value;
end;

{ Record Cache Functions }
procedure TSDDataSet.CacheInit;
begin
  if Assigned(FRecCache) then
    CacheDone;          // in some cases it happens, for example, when detached query is refreshed
  FRecCache := TSDResultSet.Create(Self, BlobFieldCount > 0);
end;

procedure TSDDataSet.CacheDone;
begin
  if FRecCache <> nil then begin
    FRecCache.Free;
    FRecCache := nil;
  end;
end;

{$IFDEF XSQL_VCL4}
{ current record buffer in cache }
function TSDDataSet.CacheTempBuffer: TSDRecordBuffer;
begin
  Result := FRecCache.CurRecords[FRecCache.CurrentIndex];
end;
{$ENDIF}

{ Record Functions }
procedure TSDDataSet.InitBufferPointers;
var
  i: Integer;
  f: TField;
begin
  BookmarkSize := SizeOf(TBookmarkRec);
  FRecordSize := 0;
	// Allocate and fill up FFieldBufOffs array, which must contain FieldDefs.Count items(-1 for calculated and omitted fields)
  SetLength( FFieldBufOffs, FieldDefs.Count * SizeOf(Integer) );
  for i:=0 to FieldDefs.Count-1 do
    FFieldBufOffs[i] := -1;
	// FieldDefs contains a complete column's definition in contrast to Fields array
  for i:=0 to FieldDefs.Count-1 do begin
    f := FieldByNumber(FieldDefs[i].FieldNo);
    	// Skip calculated fields
    if (not Assigned(f)) or (f.Calculated) then
      Continue;
    	// Field.FieldNo starts from 1
    FFieldBufOffs[f.FieldNo-1] := FRecordSize;
    Inc( FRecordSize, SizeOf(TFieldIsNotNull) + GetFieldDataSize(f) );
  end;

//    -------------------------------------------------------------
//    | Record | CalcFields | BlobCache | TSDRecInfo | TBookmarkRec |
//     <-------------------- FRecBufSize ----------------------->
//
  FBlobCacheOffs := FRecordSize + CalcFieldsSize;
  FRecInfoOffs := FBlobCacheOffs + BlobFieldCount * SizeOf(Pointer);
  FBookmarkOffs := FRecInfoOffs + SizeOf(TSDRecInfo);
  FRecBufSize := FBookmarkOffs + BookmarkSize;
end;

function TSDDataSet.AllocRecordBuffer: TSDRecordBuffer;
begin
  Result := SafeReallocMem(nil, FRecBufSize);
  SafeInitMem(Result, FRecBufSize, 0);

  InitBlobCache(Result);
end;

procedure TSDDataSet.FreeRecordBuffer(var Buffer: TSDRecordBuffer);
begin
  ASSERT( Buffer <> nil );

//  if BlobFieldCount > 0 then
//    Finalize(PSDBlobDataArray(Buffer + FBlobCacheOffs)[0], BlobFieldCount);
  ClearBlobCache(Buffer);
  Buffer := SafeReallocMem(Buffer, 0);
end;

procedure TSDDataSet.ClearBlobCache(RecBuf: TSDRecordBuffer);
var
  i: Integer;
begin
  ASSERT( RecBuf <> nil );

  if FCacheBlobs then
    for i := 0 to BlobFieldCount - 1 do
      SetFieldBlobData(RecBuf, FBlobCacheOffs, i, nil);
end;

procedure TSDDataSet.InitBlobCache(RecBuf: TSDRecordBuffer);
{$IFDEF XSQL_CLR}
var
  i: Integer;
begin
  for i := 0 to BlobFieldCount - 1 do
    SetFieldBlobData(RecBuf, FBlobCacheOffs, i, nil);
{$ELSE}
begin
  if BlobFieldCount > 0 then
    Initialize(PSDBlobDataArray(RecBuf + FBlobCacheOffs)[0], BlobFieldCount);
{$ENDIF}
end;

// TFieldIsNotNull(FieldBuf) = False, if field is empty.
// Or Result is True, when byte value = 0 (data is empty)
function TSDDataSet.FieldIsNull(FieldBuf: TSDPtr): Boolean;
begin
{$IFDEF XSQL_CLR}
  Result := Marshal.ReadByte( FieldBuf, 0) = 0;
{$ELSE}
  Result := not PFieldIsNotNull(FieldBuf)^;
{$ENDIF}
end;

procedure TSDDataSet.FieldSetNull(FieldBuf: TSDPtr; bNull: Boolean);
begin
{$IFDEF XSQL_CLR}
  Marshal.WriteByte( FieldBuf, Byte(not bNull))
{$ELSE}
  PFieldIsNotNull(FieldBuf)^ := not bNull;
{$ENDIF}
end;

function TSDDataSet.GetActiveRecBuf(var RecBuf: TSDRecordBuffer): Boolean;
begin
  case State of
{$IFDEF XSQL_VCL4}
    dsBlockRead: RecBuf := ActiveBuffer;
{$ENDIF}
    dsBrowse: if IsEmpty then RecBuf := nil else RecBuf := ActiveBuffer;
    dsEdit,
    dsInsert: RecBuf := ActiveBuffer;
    dsCalcFields: RecBuf := CalcBuffer;
    dsFilter: RecBuf := FFilterBuffer;
    dsNewValue: RecBuf := ActiveBuffer;
    dsOldValue: RecBuf := GetOldRecord;
  else
    RecBuf := nil;
  end;
  Result := RecBuf <> nil;
end;

function TSDDataSet.GetBufferCount: Integer;
begin
  Result := BufferCount;
end;

function TSDDataSet.GetFieldDataSize(Field: TField): Integer;
begin
  if IsDateTimeType( Field.DataType ) then
    Result := SizeOf(TDateTimeRec)  // DateTime fields stored as TDateTimeRec
  else
    Result := Field.DataSize;           // DataSize includes zero-terminator for string field
end;

{ Returns pointer to the field buffer (1st byte is TFieldIsNotNull) from the record buffer RecBuf }
function TSDDataSet.GetFieldBuffer(AFieldNo: Integer; RecBuf: TSDRecordBuffer): TSDValueBuffer;
begin
  ASSERT( AFieldNo > 0 );				// Field.FieldNo starts from 1
  ASSERT( FFieldBufOffs[AFieldNo-1] >= 0 );		// offset must be 0 or more

  Result := TSDValueBuffer( Longint(RecBuf) + FFieldBufOffs[AFieldNo-1] );
end;

{ Returns field data in Buffer, if Result = True
If parameter Buffer = nil, then checks field data and if field is empty, then returns False,
else returns True and field data (if Buffer <> nil) }
function TSDDataSet.GetFieldData(Field: TField; Buffer: TSDPtr): Boolean;
const
  TempStateSet = [dsBrowse, dsEdit, dsInsert, dsCalcFields{$IFDEF XSQL_VCL4}, dsBlockRead{$ENDIF}];
var
  RecBuf: TSDRecordBuffer;
  FldBuf: TSDValueBuffer;
begin
  Result := False;
  if not GetActiveRecBuf(RecBuf) then Exit;

  ASSERT( Field <> nil );
  if Field.FieldNo > 0 then begin		// FieldNo(1,2..) can be not ordered at sequential Fields[i]
    FldBuf := GetFieldBuffer(Field.FieldNo, RecBuf);

    ASSERT( FldBuf<>nil, 'Field buffer = nil' );

  	// check IsNull only
    if Buffer = nil then begin
      Result := not FieldIsNull(FldBuf);
      Exit;                           	// field data is not required
    end;
  	// if not IsNull then return field data
    if FieldIsNull(FldBuf) then
      Exit; 			// Result is equal False

 	// Field.DataSize is overrided by the TField descendents.
      	//For TStringField it's includes a null-terminator
    SafeCopyMem( TSDPtr(Longint(FldBuf)+1), Buffer, GetFieldDataSize(Field) );
    Result := True;
  end else
        // get calculated or lookup field data
    if State in TempStateSet then begin
      FldBuf := TSDValueBuffer( Longint(RecBuf) + FRecordSize + Field.Offset );
      Result := not FieldIsNull(FldBuf);
      if Result and Assigned(Buffer) then
        SafeCopyMem( TSDPtr(Longint(FldBuf)+1), Buffer, Field.DataSize);
    end;
end;

{ Sets new data(Buffer) for field(Field). If Buffer = nil than field is cleared }
procedure TSDDataSet.SetFieldData(Field: TField; Buffer: TSDPtr);
var
  RecBuf: TSDRecordBuffer;

  procedure PutField(AField: TField; ARecBuf: TSDRecordBuffer; ABuffer: TSDValueBuffer);
  var
    FldBuf: TSDValueBuffer;
    DataLen: Integer;
  begin
    with AField do begin
      FldBuf := GetFieldBuffer(AField.FieldNo, ARecBuf);

	// Copy(assign) new value of the field
      if Assigned( ABuffer ) then begin
        if DataType = ftString then
          DataLen := StrLen(ABuffer)+1   	// copy actual data of a string
        else
          DataLen := GetFieldDataSize(AField);
        SafeCopyMem( ABuffer, TSDPtr(Longint(FldBuf)+1), DataLen );
        FieldSetNull( FldBuf, False );
      end else
        FieldSetNull( FldBuf, True );

	// Set modification flag for the record
      if GetRecInfoStruct( ARecBuf, FRecInfoOffs ).UpdateStatus = usUnmodified then
        SetRecInfoStruct( ARecBuf, FRecInfoOffs, usModified );
    end;
  end;
begin
  with Field do begin
    if not (State in dsWriteModes) then DatabaseError(SNotEditing);
    GetActiveRecBuf(RecBuf);

    if FieldNo > 0 then begin
      if State = dsCalcFields then DatabaseError(SNotEditing);
      //if ReadOnly and not (State in [dsSetKey, dsFilter]) then
      //  DatabaseErrorFmt(SFieldReadOnly, [DisplayName]);
      Validate(Buffer);
      if FieldKind <> fkInternalCalc then
        PutField(Field, RecBuf, Buffer);
    end else begin	{fkCalculated, fkLookup}
      RecBuf := TSDPtr(Longint(RecBuf) + FRecordSize + Offset);
      FieldSetNull( RecBuf, Buffer = nil );
      if Assigned(Buffer) then
        SafeCopyMem( Buffer, TSDPtr(Longint(RecBuf)+1), DataSize );
    end;
    if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
      DataEvent(deFieldChange, {$IFDEF XSQL_CLR} Field {$ELSE} Longint(Field) {$ENDIF});
  end;
end;

{$IFNDEF XSQL_VCL5}
function TSDDataSet.BCDToCurr(BCD: TSDPtr; var Curr: Currency): Boolean;
begin
  Result := XSCommon.BCDToCurr( TBcd(BCD^), Curr );
end;

function TSDDataSet.CurrToBCD(const Curr: Currency; BCD: TSDPtr; Precision, Decimals: Integer): Boolean;
begin
  Result := XSCommon.CurrToBCD( Curr, TBcd(BCD^), Precision, Decimals );
end;

{ The following 2 methods, which are required for OpenEmpty, are private in Delphi 4 and below }
procedure TSDDataSet.SetDefaultFields(const Value: Boolean);
begin
  DatabaseError(SNoCapability);
end;

procedure TSDDataSet.UpdateBufferCount;
begin
  DatabaseError(SNoCapability);
end;

{$ENDIF}

function TSDDataSet.CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream;
begin
  Result := TSDBlobStream.Create(Field as TBlobField, Mode);
end;

function TSDDataSet.GetBlobData(Field: TField; Buffer: TSDRecordBuffer): TSDBlobData;
begin
  Result := GetFieldBlobData( Buffer, FBlobCacheOffs, Field.Offset );
end;

function TSDDataSet.GetBlobDataSize(Field: TField; Buffer: TSDRecordBuffer): Integer;
begin
  Result := GetFieldBlobDataSize( Buffer, FBlobCacheOffs, Field.Offset );
end;

{ Stores a blob value in the passed record buffer and in the record cache }
procedure TSDDataSet.SetBlobData(Field: TField; Buffer: TSDRecordBuffer; Value: TSDBlobData);
var
  FldBuf: TSDValueBuffer;
begin
  if Buffer = ActiveBuffer then begin
  	// stores in the record cache
    FRecCache.ModifyBlobData(Field, Buffer, Value);
    	// stores in the passed buffer (ActiveBuffer)
    SetFieldBlobData( Buffer, FBlobCacheOffs, Field.Offset, Value );
    FldBuf := GetFieldBuffer(Field.FieldNo, Buffer);
	// Checking: if Length(Value) = 0, then IsNull:=True
    FieldSetNull( FldBuf, not(Length(Value) > 0) );
    	// mark in ActiveBuffer that the record is modified
    if GetRecordUpdateStatus = usUnmodified then
      SetRecordUpdateStatus(usModified);
  end;
end;

function TSDDataSet.GetRecNo: Integer;
var
  BufPtr: TSDRecordBuffer;
begin
  CheckActive;
  if State = dsCalcFields
  then BufPtr := CalcBuffer
  else BufPtr := ActiveBuffer;
  	// RecNo property starts from 1,..
  if IsEmpty
  then Result := 0
  else Result := GetRecInfoStruct( BufPtr, FRecInfoOffs ).RecordNumber + 1;
end;

procedure TSDDataSet.SetRecNo(Value: Integer);
var
  RecIdx: Integer;
begin
  CheckBrowseMode;

  if not Assigned(RecCache) then
    Exit;
	// FRecCache.CurrentIndex is 0-based, DataSet.RecNo starts from 1
  RecIdx := Value - 1;
  if RecIdx <> FRecCache.CurrentIndex then begin
    if (RecIdx > (FRecCache.Count-1)) and not RecCache.AllInCache then begin
      SetBusyState;
      try
        FetchAll;
      finally
        ResetBusyState;
      end;
    end;
    DoBeforeScroll;
    if CachedUpdates then
        // records, which are marked as deleted, has to be considered in cached updates mode
      FRecCache.CurrentIndex := FRecCache.GetIndexOfRecord( RecIdx )
    else
      FRecCache.CurrentIndex := RecIdx;

    Resync([rmCenter]);
    DoAfterScroll;
  end;
end;

{
  Returns the total number of record (except, deleted record with UpdateRecordTypes=rtDeleted),
  when a dataset is filtered, then return number of the filtered(visible) records.
}
function TSDDataSet.GetRecordCount: LongInt;
begin
  Result := -1;
  if UniDirectional then
    Exit;
    	// for example, after ExecSQL/ExecProc a result set is not present at all
  if not Assigned(RecCache) then
    Exit;

  SetBusyState;
  try
    if not RecCache.AllInCache then
      FetchAll;

    Result := RecCache.RecordCount;
  finally
    ResetBusyState;
  end;
end;

function TSDDataSet.GetRecord(Buffer: TSDRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
var
  Status: Boolean;
begin
  if Assigned(FRecCache)
  then Status := FRecCache.GetRecord(Buffer, GetMode)
  else Status := False;

  case Status of
    True:
      begin
        SetRecInfoStruct( Buffer, FRecInfoOffs, bfCurrent );
        GetCalcFields(Buffer);
        Result := grOK;
      end;
    False:
      if GetMode = gmPrior
      then Result := grBOF
      else Result := grEOF;
  else
    Result := grError;
  end;
end;

function TSDDataSet.GetOldRecord: TSDRecordBuffer;
var
  Idx: Integer;
begin
  Result := ActiveBuffer;
  Idx := GetBookmarkRecStruct( Result, FBookmarkOffs ).iPos;
  case GetRecInfoStruct( Result, FRecInfoOffs ).UpdateStatus of
    usInserted: Result := nil;
    usModified,
    usDeleted:
      if FRecCache.OldRecords[Idx] = nil		// modifications have not been written in cache (before call Post)
      then Result := FRecCache.CurRecords[Idx]
      else Result := FRecCache.OldRecords[Idx];
  end;
end;

function TSDDataSet.GetRecordSize: Word;
begin
  Result := FRecordSize;
end;

function TSDDataSet.GetCurrentRecord(Buffer: TSDRecordBuffer): Boolean;
begin
  if not IsEmpty and (GetBookmarkFlag(ActiveBuffer) = bfCurrent) then begin
    UpdateCursorPos;
    SafeCopyMem( ActiveBuffer, Buffer, RecordSize );
    Result := True;
  end else
    Result := False;
end;

procedure TSDDataSet.FetchAll;
begin
 	// exit, in case of non-SELECT statement
  if not Assigned(FRecCache) then
    Exit;
	// EOF is not equal FRecCache.AllInCache, for example, after Append call
  if not FRecCache.AllInCache then begin
    CheckActive;
    SetBusyState;
    try
	// CheckBrowseMode is excluded, because it sets dsBrowse mode always.
      FRecCache.FetchAll;
      if FDetachOnFetchAll then
        Detach;
    finally
      ResetBusyState;
    end;
  end;
end;

procedure TSDDataSet.InitRecord(Buffer: TSDRecordBuffer);
var
  RecInfo: TSDRecInfo;
begin
  inherited InitRecord(Buffer);
  ClearBlobCache(Buffer);
	// iPos will be changed(>-0) after adding in cache
  SetBookmarkRecStruct( Buffer, FBookmarkOffs, -1 );

  with RecInfo do begin
    UpdateStatus := TUpdateStatus(usInserted);
    BookmarkFlag := bfInserted;
    RecordNumber := -1;		// at present it is equal PBookmarkRec()^.iPos
  end;
  SetRecInfoStruct( Buffer, FRecInfoOffs, RecInfo );
end;

procedure TSDDataSet.InternalInitRecord(Buffer: TSDRecordBuffer);
var
  i: Integer;
  FieldBuf: TSDValueBuffer;
begin
  for i:=0 to FieldCount-1 do
  	// exclude fields, which have FieldNo = -1: FieldKind in [fkCalculated, fkLookup, fkAggregate]
    if Fields[i].FieldNo > 0 then begin
      FieldBuf := GetFieldBuffer(Fields[i].FieldNo, Buffer);

      ASSERT( FieldBuf<>nil, 'Field buffer = nil' );
      ASSERT( FDatabase<>nil );

      FieldSetNull( FieldBuf, True );
    end;
end;

{ Clears a buffer of calculated fields }
procedure TSDDataSet.ClearCalcFields(Buffer: TSDRecordBuffer);
begin
  inherited;

  SafeInitMem( TSDPtr(Longint(Buffer)+FRecordSize), CalcFieldsSize, 0 );
end;


{ Navigation / Editing }

// DataSet sequenced, when record count is known: all record fetched or dataset is detached 
function TSDDataSet.IsSequenced: Boolean;
begin
        // if Active and (Detached or all record fetched)
  Result := Active and ( not Assigned(SqlCmd) or (Assigned(RecCache) and RecCache.AllInCache) );
end;

function TSDDataSet.GetCanModify: Boolean;
begin
  Result := Assigned(FOnUpdateRecord) or Assigned(FUpdateObject);
end;

{ This method is used by the following public methods: AppendRecord, InsertRecord. It inserts and posts a record. }
procedure TSDDataSet.InternalAddRecord(Buffer: TSDPtr; Append: Boolean);
begin
        // record buffer will be inserted in InternalPost
  InternalPost;
        // the inserted record becomes the active record
  FRecCache.FPosition := FRecCache.RecordCount-1;
end;

{ Marks(as deleted) or deletes(if record still not in database) the record in the cache }
procedure TSDDataSet.InternalDelete;
begin
        // TDataSet does not check a possibility of delete (in contrast to Edit/Insert/Append)
  CheckCanModify;
  FRecCache.DeleteRecord(ActiveBuffer);
end;

procedure TSDDataSet.InternalFirst;
begin
  FRecCache.SetToBegin;
end;

procedure TSDDataSet.InternalLast;
begin
  SetBusyState;
  try
    FRecCache.FetchAll;
    FRecCache.SetToEnd;
  finally
    ResetBusyState;
  end;
end;

{ Modify data in cache }
procedure TSDDataSet.InternalPost;
begin
  if State = dsEdit then
    FRecCache.ModifyRecord( ActiveBuffer )
  else
    FRecCache.InsertRecord( ActiveBuffer, True, False );
end;

{ refetch records without Close/Open methods and without OnClose/OnOpen events,
NOTE: but OnBeforeScroll/OnAfterScroll handlers are called (maybe in ApplyUpdates) ??? }
procedure TSDDataSet.InternalRefresh;
var
  SavePos: Integer;
begin
  if FRecCache = nil then Exit;	// dataset is inactive
  SetBusyState;
  try
    SavePos := FRecCache.CurrentIndex;
    ISqlCloseResultSet;
    BindFields(False);	// resets BlobFieldCount and CalcFieldsSize

    FRecCache.Clear; 	// reset a record cache

	// --- reexecute and refetch ---

	// if cursor was detached, but result set is stay active
    if not ISqlConnected then
      OpenCursor(False)
    else begin 	// cursor is connected, just execute it again
      InitResultSet;
      if Self is TXSQLStoredProc then
        TXSQLStoredProc(Self).BindParams;
      ExecuteCursor;
    end;
	// fetch until the saved record
    while FRecCache.FetchRecord do
      if (SavePos+1) = FRecCache.Count then begin
        FRecCache.FPosition := SavePos;
        Break;
      end;
  finally
    ResetBusyState;
  end;
end;

procedure TSDDataSet.InternalGotoBookmark({$IFDEF XSQL_CLR} const {$ENDIF} Bookmark: TBookmark);
var
  RecPos: Integer;
begin
  RecPos := GetBookmarkRecStruct( Bookmark, 0 ).iPos;
	// There are not all records in cache
  if RecPos >= FRecCache.Count then
    FRecCache.FetchAll;
  FRecCache.FPosition := RecPos;
end;

procedure TSDDataSet.InternalSetToRecord(Buffer: TSDRecordBuffer);
begin
  InternalGotoBookmark( TSDPtr(Longint(Buffer) + FBookmarkOffs) );
end;

function TSDDataSet.GetBookmarkFlag(Buffer: TSDRecordBuffer): TBookmarkFlag;
begin
  Result := GetRecInfoStruct( Buffer, FRecInfoOffs ).BookmarkFlag;
end;

procedure TSDDataSet.SetBookmarkFlag(Buffer: TSDRecordBuffer; Value: TBookmarkFlag);
begin
  SetRecInfoStruct( Buffer, FRecInfoOffs, Value );
end;

procedure TSDDataSet.GetBookmarkData(Buffer: TSDRecordBuffer; {$IFDEF XSQL_CLR} var Data: TBookmark {$ELSE} Data: TSDPtr {$ENDIF});
begin
  SafeCopyMem( TSDPtr(Longint(Buffer) + FBookmarkOffs), Data, BookmarkSize );
end;

procedure TSDDataSet.SetBookmarkData(Buffer: TSDRecordBuffer; {$IFDEF XSQL_CLR} const Data: TBookmark {$ELSE} Data: TSDPtr {$ENDIF});
begin
  SafeCopyMem( Data, TSDPtr(Longint(Buffer) + FBookmarkOffs), BookmarkSize );
end;

function TSDDataSet.BookmarkValid({$IFDEF XSQL_CLR} const {$ENDIF} Bookmark: TBookmark): Boolean;
var
  InCacheNo: Integer;
begin
  Result := False;

  InCacheNo := GetBookmarkRecStruct( Bookmark, 0 ).iPos;
  if (InCacheNo >= FRecCache.Count) or (InCacheNo < 0) then
    Exit;
	// If row was deleted
  if FRecCache.UpdateStatusRecords[InCacheNo] = usDeleted then
    Exit;

  Result := True;
end;

function TSDDataSet.CompareBookmarks({$IFDEF XSQL_CLR} const {$ENDIF} Bookmark1, Bookmark2: TBookmark): Integer;
const
  BkmLess           = -1;             { Bkm1 < Bkm2 }
  BkmEql            = 0;              { BookMarks are exactly the same }
  BkmGtr            = 1;              { Bkm1 > Bkm2 }
  BkmKeyEql         = 2;              { Only Bkm1.key_val = Bkm2.key_val }
  RetCodes: array[Boolean, Boolean] of ShortInt = ((BkmKeyEql, BkmLess), (BkmGtr, BkmEql));
var
  Pos1, Pos2: Integer;
begin
        // Check for uninitialized bookmarks
  Result := RetCodes[Bookmark1 = nil, Bookmark2 = nil];
        // if both bookmarks are not equal nil
  if Result = BkmKeyEql then begin
    if Active then begin
      Pos1 := GetBookmarkRecStruct( Bookmark1, 0 ).iPos;
      Pos2 := GetBookmarkRecStruct( Bookmark2, 0 ).iPos;
      if Pos1 = Pos2 then
        Result := BkmEql
      else if Pos1 < Pos2 then
        Result := BkmLess
      else
        Result := BkmGtr;
    end;
        // if the dataset is not active and both bookmarks are not equal nil
    if Result = BkmKeyEql then
      Result := BkmEql;
  end;
end;

{$IFDEF XSQL_VCL4}
{ Set record count in one readed block }
procedure TSDDataSet.SetBlockReadSize(Value: Integer);

  function CanBlockRead: Boolean;
  var
    i: Integer;
  begin
    Result := (BufferCount <= 1) and (DataSetField = nil);
{$IFDEF XSQL_VCL4}
    if Result then
      for i := 0 to FieldCount - 1 do
        if (Fields[i].DataType in [ftDataSet, ftReference]) then
        begin
          Result := False;
          Break;
        end;
{$ENDIF}
  end;

begin
  if Value <> BlockReadSize then begin
    if Value > 0 then begin

      Exit;	// at preset BlockRead is not supported

      if EOF or not CanBlockRead then Exit;
      UpdateCursorPos;
      inherited;
      BlockReadNext;
    end else
      inherited;
  end;
end;

{ Read BlockReadSize record at once in cache }
procedure TSDDataSet.BlockReadNext;
begin
  MoveBy(1);

  if CalcFieldsSize > 0 then begin
    GetCalcFields( CacheTempBuffer );
  end;
  DataEvent(deDataSetScroll, {$IFDEF XSQL_CLR} TObject(Integer(-1)) {$ELSE} -1 {$ENDIF});
end;
{$ENDIF}

{ Datasource/Datalink Interaction }

procedure TSDDataSet.DataEvent(Event: TDataEvent; Info: {$IFDEF XSQL_CLR} TObject {$ELSE} Longint {$ENDIF});
begin
  inherited DataEvent(Event, Info);

  case Event of
    dePropertyChange:	ClearFieldDefs;
  end;
end;

{ Index / Ranges }

{ Checking: whether correspond the field list to any index (by field number, by field order and other.) }
function TSDDataSet.MapsToIndex(Fields: TList; CaseInsensitive: Boolean): Boolean;
begin
  Result := False;
end;

{ Filters }

{$IFDEF XSQL_VCL5}
function TSDDataSet.CreateExprFilter(const Text: string; Options: TFilterOptions): TSDExprParser;
const
  FldTypeMap: TFieldMap = ( Ord(ftUnknown),
	// ftString, ftSmallint, ftInteger, 	ftWord, 	ftBoolean
	Ord(ftString), Ord(ftSmallInt), Ord(ftInteger), Ord(ftWord), Ord(ftBoolean),
	// ftFloat, 	ftCurrency,	ftBCD, ftDate, 		ftTime
	Ord(ftFloat), Ord(ftFloat), Ord(ftBCD), Ord(ftDate), Ord(ftTime),
        // ftDateTime, ftBytes, 	ftVarBytes, ftAutoInc,  ftBlob
        Ord(ftDateTime), Ord(ftBytes), Ord(ftVarBytes), Ord(ftInteger), Ord(ftBlob),
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        Ord(ftBlob), Ord(ftBlob), Ord(ftBlob), Ord(ftBlob), Ord(ftBlob),
        // ftTypedBinary, ftCursor
        Ord(ftBlob), Ord(ftUnknown)
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        Ord(ftString),	Ord(ftString),	Ord(ftLargeInt),
        // ftADT, ftArray, ftReference, ftDataSet
        Ord(ftADT),	Ord(ftArray),	Ord(ftUnknown),	Ord(ftUnknown)
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        Ord(ftUnknown),	Ord(ftUnknown),	Ord(ftUnknown),
        // ftInterface, ftIDispatch, ftGuid
        Ord(ftUnknown),	Ord(ftUnknown),	Ord(ftUnknown)
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        Ord(ftUnknown),      Ord(ftUnknown)
{$ENDIF}
{$IFDEF XSQL_VCL10},
        Ord(ftUnknown),      Ord(ftUnknown),      Ord(ftUnknown),     Ord(ftUnknown)
{$ENDIF}
	);
begin
  Result := TSDExprParser.Create(Self, Text, Options, [poExtSyntax], '', nil, FldTypeMap);
end;
{$ENDIF}

function TSDDataSet.RecordFilter(RecBuf: TSDRecordBuffer): Boolean;
var
  Accept: Boolean;
  SaveState: TDataSetState;
begin
	// set a dataset into dsFilter mode to prevent modifications during the filtering process
  SaveState := SetTempState(dsFilter);
  FFilterBuffer := RecBuf;
  try
    Accept := True;

{$IFDEF XSQL_VCL5}
    if Assigned(FExprFilter) then
      Accept := FExprFilter.CalcBooleanValue;
{$ENDIF}

    if Accept and Assigned(OnFilterRecord) then
      OnFilterRecord(Self, Accept);
  except
    InternalHandleException;
  end;
  RestoreState(SaveState);
  Result := Accept;
end;

procedure TSDDataSet.SetFilterData(const Text: string; Options: TFilterOptions);
begin
{$IFDEF XSQL_VCL5}
  if (Filter <> Text) or (FilterOptions <> Options) then
    FreeAndNil(FExprFilter);
{$ENDIF}

  if Active then begin
    CheckBrowseMode;
{$IFDEF XSQL_VCL5}
    if (Text <> '') and not Assigned(FExprFilter) then
      FExprFilter := CreateExprFilter(Text, Options);
{$ENDIF}
  end;
  inherited SetFilterText(Text);
  inherited SetFilterOptions(Options);
  if Active and Filtered then First;
end;

procedure TSDDataSet.SetFilterOptions(Value: TFilterOptions);
begin
  SetFilterData(Filter, Value);
end;

procedure TSDDataSet.SetFilterText(const Value: string);
begin
  SetFilterData(Value, FilterOptions);
end;

procedure TSDDataSet.SetFiltered(Value: Boolean);
begin
  if Active then begin
    CheckBrowseMode;
    if Filtered <> Value then begin
      FRecCache.SetToBegin;
      inherited SetFiltered(Value);
    end;
    First;
  end else
    inherited SetFiltered(Value);
end;

procedure TSDDataSet.SetOnFilterRecord(const Value: TFilterRecordEvent);
begin
  if Active then begin
    CheckBrowseMode;
    inherited SetOnFilterRecord(Value);
    if Filtered then First;
  end else
    inherited SetOnFilterRecord(Value);
end;

function TSDDataSet.FindRecord(Restart, GoForward: Boolean): Boolean;
var
  Status: Boolean;
begin
  CheckBrowseMode;
  DoBeforeScroll;
  SetFound(False);
  UpdateCursorPos;
  CursorPosChanged;
//  if not Filtered then ActivateFilters;
  try
    if GoForward then begin
      if Restart then FRecCache.SetToBegin;
      Status := FRecCache.FindNextRecord;
    end else begin
      if Restart then FRecCache.SetToEnd;
      Status := FRecCache.FindPriorRecord;
    end;
  finally
//    if not Filtered then DeactivateFilters;
  end;
  if Status then begin
    Resync([rmExact, rmCenter]);
    SetFound(True);
  end;
  Result := Found;
  if Result then DoAfterScroll;
end;

{  Returns position of the 1-st satisfying record in the cache (FResultSet) from the begin
of the result set if NextLocate is False, else from the next position relative to the current one }

// This modified method was sent to user Cyrille BOUISSON for testing 21.10.2004
function TSDDataSet.DoLocateRecord(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions; SyncCursor, NextLocate: Boolean): Integer;
var
  SaveState: TDataSetState;
  i: Integer;
begin
  CheckBrowseMode;
  CursorPosChanged;
  Result := -1;
	// temporary turn in Filter mode
  SaveState := SetTempState( dsFilter );
  SetBusyState;
  try
    if NextLocate then
      i := RecNo	// RecNo = RecordNumber (in cache) + 1, search from the next record
    else
      i := 0;           // search from the current record
    repeat
      if not FRecCache.AllInCache and (i = FRecCache.Count) then begin
	// for avoiding fetch problem (especially, with Blob-fields)
        SetTempState( dsBrowse );
        try
          FRecCache.FetchRecord;
        finally
          RestoreState( dsFilter );
        end;
      end;
      if i < FRecCache.Count then begin
        // in filter mode field values are got from FFilterBuffer
        FFilterBuffer := FRecCache[i];
      	// if a record is visible
        if FRecCache.IsVisibleRecord(i) then begin
          if VarIsEqual(FieldValues[KeyFields], KeyValues, loCaseInsensitive in Options, loPartialKey in Options, True) then begin
            Result := i;
            Break;
          end;
        end;
      end;
      Inc(i);
    until i > FRecCache.Count;
  finally
    ResetBusyState;
    RestoreState( SaveState );
  end;
  if (Result >= 0) and SyncCursor then
    FRecCache.FPosition := Result;
end;

(* old version
function TSDDataSet.DoLocateRecord(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions; SyncCursor, NextLocate: Boolean): Integer;
var
  SaveState: TDataSetState;
  i: Integer;
begin
  CheckBrowseMode;
  CursorPosChanged;
  Result := -1;
	// temporary turn in Filter mode
  SaveState := SetTempState( dsFilter );
  SetBusyState;
  try
    if NextLocate then
      i := RecNo	// RecNo = RecordNumber (in cache) + 1, search from the next record
    else
      i := 0;           // search from the current record
    while i < FRecCache.Count do begin
        // in filter mode field values are got from FFilterBuffer
      FFilterBuffer := FRecCache[i];
      	// if a record is visible
      if FRecCache.IsVisibleRecord(i) then begin
        if VarIsEqual(FieldValues[KeyFields], KeyValues, loCaseInsensitive in Options, loPartialKey in Options, True) then begin
          Result := i;
          Break;
        end;
      end;
      Inc(i);
      if i = FRecCache.Count then begin
	// for avoiding fetch problem (especially, with Blob-fields)
        SetTempState( dsBrowse );
        try
          FRecCache.FetchAll;
        finally
          RestoreState( dsFilter );
        end;
      end;
    end;
  finally
    ResetBusyState;
    RestoreState( SaveState );
  end;
  if (Result >= 0) and SyncCursor then
    FRecCache.FPosition := Result;
end;
*)

function TSDDataSet.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
begin
  Result := False;
  DoBeforeScroll;
  if DoLocateRecord(KeyFields, KeyValues, Options, True, False) >= 0 then begin
    Resync([rmExact, rmCenter]);
    DoAfterScroll;
    Result := True;
  end;
end;

function TSDDataSet.LocateNext(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
begin
  Result := False;
  DoBeforeScroll;
  if DoLocateRecord(KeyFields, KeyValues, Options, True, True) >= 0 then begin
    Resync([rmExact, rmCenter]);
    DoAfterScroll;
    Result := True;
  end;
end;

function TSDDataSet.Lookup(const KeyFields: string; const KeyValues: Variant;
  const ResultFields: string): Variant;
var
  Pos: Integer;
begin
  Result := Null;
  Pos := DoLocateRecord(KeyFields, KeyValues, [], False, False);
  if Pos >= 0 then begin
    SetTempState(dsCalcFields);
    try
      CalculateFields(FRecCache[Pos]);
      Result := FieldValues[ResultFields];
    finally
      RestoreState(dsBrowse);
    end;
  end;
end;

// AFields: array of Integer - array of Indexes of the specified fields in Fields[]
// AscOrder, CaseSensitive has to have size as AFields array or at least 1 element
procedure TSDDataSet.DoSortRecords(AFields: array of Integer; AscOrder, CaseSensitive: array of Boolean);
  function GetRecFieldsValue(ARecIndex: Integer): Variant;
  var
    FldCount, i: Integer;
  begin
    FldCount := High(AFields);
    if FldCount >= 0 then
      Inc(FldCount)
    else
      raise Exception.Create('Invalid array in GetRecordFieldsValue');
    FFilterBuffer := FRecCache[ARecIndex];
    if FldCount = 1 then
      Result := Fields[AFields[0]].Value
    else begin
      Result := VarArrayCreate([0, FldCount-1], {$IFDEF XSQL_CLR}varObject{$ELSE}varVariant{$ENDIF});
      for i:=0 to FldCount-1 do
        Result[i] := Fields[AFields[i]].Value;
    end;
  end;

  function CmpVar(V1, V2: Variant): Integer;
  var
    i: Integer;
    bCaseSens, bAscOrder: Boolean;
  begin
    if not VarIsArray(V1) and not VarIsArray(V2) then begin	// V1 and V2 are not arrays
      Result := CompareVar(V1, V2, CaseSensitive[0]);
      if not AscOrder[0] then
        Result := (-1) * Result;
    end else begin
      Result := 0;
        // size of V1, V2 arrays has to be equal, because the both use one field set
      for i:= VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do begin
        if i > High(CaseSensitive)
        then bCaseSens := CaseSensitive[0]
        else bCaseSens := CaseSensitive[i];
        Result := CompareVar(V1[i], V2[i], bCaseSens);
        if Result <> 0 then begin
          if i > High(AscOrder)
          then bAscOrder := AscOrder[0]
          else bAscOrder := AscOrder[i];
          if not bAscOrder then
            Result := (-1) * Result;
          Break;
        end;
      end;
    end;
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, j: Integer;
    p: Variant;
  begin
    repeat
      i := L;
      j := R;
      p := GetRecFieldsValue( (L+R)shr 1 );
      repeat
        while CmpVar( GetRecFieldsValue(i), p ) < 0 do Inc(i);
        while CmpVar( GetRecFieldsValue(j), p ) > 0 do Dec(j);
        // swap
        if i <= j then begin
          if i <> j then
            FRecCache.ExchangeRecords(i, j);
          Inc(i);
          Dec(j);
        end;
      until i > j;
      if L < j then
        QuickSort(L, j);
      L := i;
    until i >= R;
  end;
var
  SaveState: TDataSetState;
  SaveRecPos: Integer;
  bSorted: Boolean;
begin
  CheckBrowseMode;
  if FRecCache.AllInCache and (FRecCache.Count <= 1) then
    Exit;
  SaveRecPos := FRecCache.FPosition;
  CursorPosChanged;

  SaveState := State;
  SetBusyState;
  bSorted := False;
  try
    FRecCache.FetchAll;
    if FRecCache.Count > 1 then begin
	// temporary turn in Filter mode
      SaveState := SetTempState( dsFilter );

      QuickSort(0, FRecCache.Count-1);
      bSorted := True;
    end;
  finally
    ResetBusyState;
    RestoreState( SaveState );
  end;
        // restore position, which ? using RecNo or actual record
  FRecCache.FPosition := SaveRecPos;
  if bSorted then begin
    FRecCache.FPosition := SaveRecPos;
    Resync([rmExact, rmCenter]);
    DoAfterScroll;
  end;
end;

// AFields - variant open array parameter, can contain FieldName values or Index in Fields[] array
procedure TSDDataSet.SortRecords(AFields: array of const; AscOrder, ACaseSensitive: array of Boolean);
var
  aFieldIndex: array of Integer;
  f: TField;
  i, FldIndex, MaxFields: Integer;
begin
  MaxFields := High(AFields) + 1;
  if MaxFields > 0 then
    SetLength( aFieldIndex, MaxFields );
  for i:=Low(AFields) to MaxFields-1 do begin
    f := nil;
    FldIndex := -1;
{$IFDEF XSQL_CLR}
    if VarIsStr( Variant(AFields[i]) ) then
      f := FindField( VarToStr( Variant(AFields[i]) ) )
    else if VarIsOrdinal( Variant(AFields[i]) ) then
      FldIndex := Integer( AFields[i] )
    else
      DatabaseErrorFmt(SFatalError, ['Invalid AFields parameter in TSDDataSet.SortRecords']);
{$ELSE}
    case AFields[i].VType of
      vtInteger:
        FldIndex := AFields[i].VInteger;
      vtChar:
        f := FindField( AFields[i].VChar );
      vtString:
        f := FindField( string(AFields[i].VString) );
      vtAnsiString:
        f := FindField( string(AFields[i].VAnsiString) );
    else
      DatabaseErrorFmt(SFatalError, ['Invalid AFields parameter in TSDDataSet.SortRecords']);
    end;
{$ENDIF}
    if Assigned(f) then
      FldIndex := f.Index;
    aFieldIndex[i] := FldIndex;
  end;
  DoSortRecords(aFieldIndex, AscOrder, ACaseSensitive);
end;

procedure TSDDataSet.SortRecords(const AFields, AscOrder, ACaseSensitive: string);
var
  aFieldIndex: array of Integer;
  aOrder, aCaseSens: array of Boolean;
  f: TField;
  i, nValue: Integer;
  sValue: string;
  bValue: Boolean;
begin
        // create field indexes array
  i := 1;
  while i <= Length(AFields) do begin
    sValue := ExtractFieldName(AFields, i);
    if sValue <> '' then begin
      SetLength( aFieldIndex, Length(aFieldIndex)+1 );
      nValue := StrToIntDef(sValue, -1);
      if nValue = -1 then begin
        f := FieldByName(sValue);
        nValue := f.Index;
      end;
      aFieldIndex[Length(aFieldIndex)-1] := nValue;
    end;
  end;
        // create aOrder array
  i := 1;
  while i <= Length(AscOrder) do begin
    sValue := UpperCase( ExtractFieldName(AscOrder, i) );
    if sValue <> '' then begin
      SetLength( aOrder, Length(aOrder)+1 );
      bValue := (sValue <> 'DESC') and (sValue <> SFalseString) and (sValue <> '0');
      aOrder[Length(aOrder)-1] := bValue;
    end;
  end;
        // create aCaseSens array
  i := 1;
  while i <= Length(ACaseSensitive) do begin
    sValue := UpperCase( ExtractFieldName(ACaseSensitive, i) );
    if sValue <> '' then begin
      SetLength( aCaseSens, Length(aCaseSens)+1 );
      bValue := (sValue <> SFalseString) and (sValue <> '0');
      aCaseSens[Length(aCaseSens)-1] := bValue;
    end;
  end;
  if Length(aOrder) = 0 then begin
    SetLength( aOrder, 1 );
    aOrder[0] := True;
  end;
  if Length(aCaseSens) = 0 then begin
    SetLength( aCaseSens, 1 );
    aCaseSens[0] := True;
  end;
  DoSortRecords(aFieldIndex, aOrder, aCaseSens);
end;

{ Cached Updates }

procedure TSDDataSet.CheckCachedUpdateMode;
begin
  if not FCachedUpdates then DatabaseError(SNoCachedUpdates);
end;

procedure TSDDataSet.ApplyUpdates;
var
  Status: Integer;
begin
  if State <> dsBrowse then Post;
  Status := ProcessUpdates(DelayedUpdPrepare);
  if Status <> SDE_ERR_NONE then
    if Status = SDE_ERR_UPDATEABORT then SysUtils.Abort
    else SDEError(Status);
end;

procedure TSDDataSet.CommitUpdates;
begin
  SDECheck( ProcessUpdates(DelayedUpdCommit) );
end;

procedure TSDDataSet.RollbackUpdates;
begin
  SDECheck( ProcessUpdates(DelayedUpdRollback) );
end;

procedure TSDDataSet.CancelUpdates;
begin
  Cancel;
  ProcessUpdates(DelayedUpdCancel);
end;

procedure TSDDataSet.RevertRecord;
var
  Status: Integer;
begin
  if State in dsEditModes then Cancel;
  Status := ProcessUpdates(DelayedUpdCancelCurrent);
  if Status <> SDE_ERR_NONE then
    SDECheck(Status);
end;

function TSDDataSet.ProcessUpdates(UpdCmd: TDelayedUpdCmd): Integer;
begin
  CheckActive;
  CheckCachedUpdateMode;
  UpdateCursorPos;
  case UpdCmd of
    DelayedUpdCancel: 		Result := FRecCache.UpdatesCancel;
    DelayedUpdCommit: 		Result := FRecCache.UpdatesCommit;
    DelayedUpdPrepare: 		Result := FRecCache.UpdatesPrepare;
    DelayedUpdCancelCurrent: 	Result := FRecCache.UpdatesCancelCurrent;
    DelayedUpdRollback: 	Result := FRecCache.UpdatesRollback;
  else
    Result := SDE_ERR_UPDATEABORT;
  end;
  Resync([]);
end;

function TSDDataSet.GetUpdatesPending: Boolean;
var
  i: Integer;
begin
  Result := False;
  if not Active then
    Exit;
        // check State and whether the current record modified to exclude to check all records in some cases 
  if (State in (dsEditModes - [dsSetKey])) and Modified then begin
    Result := True;
    Exit;
  end;
        // check all records, State is not edit and the current record is not changed
  for i:=0 to FRecCache.Count-1 do
    if GetRecInfoStruct( FRecCache[i], FRecInfoOffs ).UpdateStatus <> usUnmodified then begin
      Result := True;
      Break;
    end;
end;

function TSDDataSet.GetEnableUpdateKinds: TUpdateKinds;
begin
  if Active then begin
    CheckCachedUpdateMode;
    Result := FEnableUpdateKinds;
  end else
    Result := [];
end;

procedure TSDDataSet.SetEnableUpdateKinds(Value: TUpdateKinds);
begin
  CheckCachedUpdateMode;
  CheckActive;
  FEnableUpdateKinds := Value;
end;

function TSDDataSet.GetUpdateRecordSet: TUpdateRecordTypes;
begin
  if Active then begin
    CheckCachedUpdateMode;
    Result := FUpdateRecordTypes;
  end else
    Result := [];
end;

procedure TSDDataSet.SetUpdateRecordSet(RecordTypes: TUpdateRecordTypes);
begin
  CheckCachedUpdateMode;
  CheckBrowseMode;
  UpdateCursorPos;
  FUpdateRecordTypes := RecordTypes;
  Resync([]);
end;

procedure TSDDataSet.SetUpdateObject(Value: TSDDataSetUpdateObject);
begin
  if Value <> FUpdateObject then begin
    if Assigned(FUpdateObject) and (FUpdateObject.DataSet = Self) then
      FUpdateObject.DataSet := nil;
    FUpdateObject := Value;
    if Assigned(FUpdateObject) then begin
      { If another dataset already references this updateobject, then remove the reference }
      if Assigned(FUpdateObject.DataSet) and (FUpdateObject.DataSet <> Self) then
        FUpdateObject.DataSet.UpdateObject := nil;
      FUpdateObject.DataSet := Self;
    end;
  end;
end;

function TSDDataSet.GetRecordUpdateStatus: TUpdateStatus;
var
  BufPtr: TSDRecordBuffer;
begin
  if State = dsCalcFields
  then BufPtr := CalcBuffer
  else BufPtr := ActiveBuffer;
  Result := GetRecInfoStruct( BufPtr, FRecInfoOffs ).UpdateStatus;
end;

procedure TSDDataSet.SetRecordUpdateStatus(Value: TUpdateStatus);
var
  BufPtr: TSDRecordBuffer;
begin
  if State = dsCalcFields
  then BufPtr := CalcBuffer
  else BufPtr := ActiveBuffer;
  if Value <> GetRecInfoStruct( BufPtr, FRecInfoOffs ).UpdateStatus then
    SetRecInfoStruct( BufPtr, FRecInfoOffs, Value );
end;

function TSDDataSet.UpdateStatus: TUpdateStatus;
begin
  CheckCachedUpdateMode;
  Result := GetRecordUpdateStatus;
end;

{ handler for InternalPost/InternalDelete for live query and table }
procedure TSDDataSet.LiveInternalPost(IsDelete: Boolean; const ASQL, ATableName: string);
var
  RecIdx: Integer;
  us: TUpdateStatus;
  UseTransaction: Boolean;
begin
  RecIdx := -1;
  us := usUnmodified;
        // use transaction control, autocommit is set off and StartTransaction is not called earlier
  UseTransaction := not (Database.InTransaction or
                          (UpperCase( Trim( Database.Params.Values[szAUTOCOMMIT] ) ) = STrueString));
	// If the record was modified before deleting,
        //it is need to save record in cache to get a valid OldValue later. State = dsInsert is not happen here
  if IsDelete and (State in [dsEdit]) then
    FRecCache.ModifyRecord( ActiveBuffer );

  if IsDelete then begin
    us := GetRecordUpdateStatus;
    SetRecordUpdateStatus(usDeleted);
  end else
    RecIdx := FRecCache.IndexOfRecord(ActiveBuffer);
  try
    if UseTransaction then Database.StartTransaction;
  	// UpdateStatus method is not used to exclude an exception in CheckCachedMode
    LiveApplyRecord(GetRecordUpdateStatus, ASQL, ATableName, '');
    if UseTransaction then Database.Commit;
    if IsDelete then
      FRecCache.DeleteRecord(ActiveBuffer) 	// call code of TSDDataSet.InternalDelete, when UpdateStatus = usDelete
    else
      FRecCache.UpdatesCommitRecord(RecIdx);
  except
  	// below code could be replaced to FRecCache.UpdatesCancelCurrent call
    if IsDelete then
      SetRecordUpdateStatus(us)
    else if (State = dsInsert) and (RecIdx >= 0) then
      FRecCache.DeleteCacheItem( RecIdx );
    if UseTransaction then Database.Rollback;

    raise;
  end;
end;

{ Statement has to be prepared and FieldDescs has to be completed before using this method }
procedure TSDDataSet.GetFieldInfoFromSQL(const ASQL: string; FldInfo, TblInfo: TStrings);
var
  FldList: TStrings;
  i: Integer;
begin
  FldList := TStringList.Create;
  try
    if FieldDefs.Count = 0 then
      InitFieldDefs;
    for i:=0 to FieldDefs.Count-1 do
      FldList.Add( FieldDefs[i].Name );

    ParseTableFieldsFromSQL( ASQL, FldList, FldInfo, TblInfo );
  finally
    FldList.Free;
  end;
end;

{ Creates and executes a statement to refresh or modify an active record.
  UPDATE/INSERT statements are generated for modified fields only, i.e. that can
  be different each execution WHERE clause depends from UpdateMode property.
  INSERT doesn't depend from UpdateMode.
  upWhereChanged and upWhereKey use (and it's possible to use only in this case)
  primary(unique) index columns, if the index is missed then an exception has to be raised.

  Index info is cached in the dataset and it's used through Fields[i].IsIndexField property
}
procedure TSDDataSet.LiveApplyRecord(OpMode: TUpdateStatus; const ASQL, ATableName, ARefreshSQL: string);
{$IFNDEF XSQL_VCL4}
begin
  DatabaseError(SNoCapability);
end;
{$ELSE}
var
  fl, tl: TStrings;
  sStmt, PName, sTblName: string;
  i, RecIdx, nAutoIncID: Integer;
  FldBuf  : TSDValueBuffer;
  sql: TISqlCommand;
  Field: TField;
  Old, QuoteIdent: Boolean;
begin
  sTblName := '';

  if (OpMode = usUnmodified) and (Trim(ARefreshSQL) <> '') then
    sStmt := ARefreshSQL
  else if Assigned(UpdateObject) then
    sStmt := (UpdateObject as TXSQLUpdateSql).SQL[OpMode].Text
  else begin
    QuoteIdent := Assigned(Database) and (UpperCase( Trim( Database.Params.Values[szQUOTE_IDENT] ) ) = STrueString);
    fl := TStringList.Create;
    tl := TStringList.Create;	// will contain one table only
    try
    	// query has to be prepared and FieldDescs <> nil, before this call
      GetFieldInfoFromSQL( ASQL, fl, tl );

    { generate SQL statement, which can differs for each request (for example, different field count can modified)
     parameters: update kind, update mode, table name, field's names and aliases,
     fields value (which fields are modified) and index fields. }
      sTblName := ATableName;
      if (sTblName = '') and (tl.Count > 0) then
        sTblName := tl.Values[tl.Names[0]]; // returns a table name using the table alias
      sStmt := GenerateSQL(OpMode, UpdateMode, sTblName, fl, Fields, QuoteIdent);
    finally
      fl.Free;
      tl.Free;
    end;
  end;

  if sStmt = '' then
    if OpMode = usUnmodified then
      DatabaseError(SEmptySQLStatement)	// if resfresh SQL is not available
    else
      Exit;	// if all modified values are equal it's old value for UPDATE statement (it happens, for example, with MySQL, ODBC+ASA)
	// cache index of the current active record
  RecIdx := RecCache.IndexOfRecord(ActiveBuffer);
  sql := ISqlCmdCreate;
  try
    sql.CommandType := ctQuery;
    sql.Params := TSDHelperParams.Create {$IFDEF XSQL_VCL4} (Self) {$ENDIF};
    CreateParamsFromSQL(sql.Params, sStmt, DefaultParamPrefix);

    for i := 0 to sql.Params.Count - 1 do begin
      PName := sql.Params[i].Name;
      Old := IsOldPrefixExists( PName, OldFieldValuePrefix );
      if Old then DeleteSubstr(PName, 1, Length(OldFieldValuePrefix));
      Field := Self.FindField(PName);
      if not Assigned(Field) then Continue;
      if Old
      then sql.Params[i].AssignFieldValue(Field, Field.OldValue)
      else sql.Params[i].AssignFieldValue(Field, Field.NewValue);
    end;
        // It is need to know parameter's datatypes before prepare, to save Oracle8 BLOB/CLOB correctly
    sql.Prepare( sStmt );
    sql.Execute;
    if OpMode = usUnmodified then begin
      if not sql.FetchNextRow then
        DatabaseError(SRecordChanged);
    	// assign new values in cache (UpdateStatus is not modified in ISqlCnvtFieldData)
      for i:=0 to sql.FieldDescs.Count-1 do begin
        Field := Self.FieldByName(sql.FieldDescs[i].FieldName);
        // check this, RefreshSQL can select more field, than the result set has
        if Assigned(Field) then
          ISqlCnvtFieldData(sql, sql.FieldDescs[i], RecCache.CurRecords[RecIdx], Field);
      end;
    	// refresh record from the cache
      RecCache.CurrentIndex := RecIdx;
      Resync([rmExact]);
    end else begin
      if sql.GetRowsAffected = 0 then
        DatabaseError(SRecordChanged);

      if RecIdx >= 0 then
        FRecCache.AppliedRecords[RecIdx] := True;

        // get autoincrement fields (and fields with default values, later - it's required separate statement)
      if AutoRefresh and (OpMode = usInserted) then begin
        nAutoIncID := sql.GetAutoIncValue;
                // if impossible to get through API, use statement
        if nAutoIncID = -1 then begin
          sStmt := sql.SqlDatabase.GetAutoIncSQL;
          if sStmt <> '' then begin
            sql.InitNewCommand;
            	// returns a result set with one field
            sql.Prepare(sStmt);
            sql.Execute;
            if sql.FetchNextRow then begin
		// only one field can be autoincremented
              for i:=0 to FieldCount-1 do begin
                if ((Fields[i].DataType = ftAutoInc) {$IFDEF XSQL_VCL5}or (Fields[i].AutoGenerateValue = arAutoInc) {$ENDIF})
                   //and Fields[i].IsNull
                then begin
                  	// try to fix problem, if FieldDesc[0].FieldType <> Fields[i].DataType, in ISqlCnvtFieldData
                  ISqlCnvtFieldData(sql, sql.FieldDescs[0], RecCache.CurRecords[RecIdx], Fields[i]);
                  Break;
                end;
              end;
      		// it is not need to refresh record from the cache. Resync will be called in TDataSet.Post
            end;
            sql.CloseResultSet;
          end
        end else if nAutoIncID > 0 then begin
          for i:=0 to FieldCount-1 do begin
            if ((Fields[i].DataType = ftAutoInc) {$IFDEF XSQL_VCL5}or (Fields[i].AutoGenerateValue = arAutoInc) {$ENDIF})
               //and Fields[i].IsNull
            then begin
              FldBuf := GetFieldBuffer( Fields[i].FieldNo, RecCache.CurRecords[RecIdx] );
              HelperMemWriteInt32( FldBuf, 1, nAutoIncID );
              FieldSetNull( FldBuf, False );
              Break;
            end;
          end;
        end;
      end;
    end;
  finally
    if Assigned(sql.Params) then
      sql.Params.Free;
    sql.Free;
  end;
end;
{$ENDIF}

procedure TSDDataSet.DoRefreshRecord(const ARefreshSQL: string);
begin
  LiveApplyRecord(usUnmodified, SqlCmd.CommandText, '', ARefreshSQL);
end;

procedure TSDDataSet.RefreshRecord;
var
  s: string;
begin
  if Assigned(SqlCmd) then
    s := SqlCmd.CommandText
  else
    s := '';
  LiveApplyRecord(usUnmodified, s, '', '');
end;

procedure TSDDataSet.RefreshRecordEx(const ARefreshSQL: string);
var
  s: string;
begin
  if Assigned(SqlCmd) then
    s := SqlCmd.CommandText
  else
    s := '';
  LiveApplyRecord(usUnmodified, s, '', ARefreshSQL);
end;

{-------------------------------------------------------------------------------
			Common SQL server C/API Functions
-------------------------------------------------------------------------------}
function TSDDataSet.ISqlCmdCreate: TISqlCommand;
begin
  ASSERT( FDatabase <> nil, Format(SFatalError, ['TSDDataSet.ISqlCmdCreate']) );
  ASSERT( FDatabase.SqlDatabase <> nil, Format(SFatalError, ['TSDDataSet.ISqlCmdCreate']) );

  Result := FDatabase.SqlDatabase.CreateSqlCommand;
end;

function TSDDataSet.GetHandle: PSDCursor;
begin
  Result := nil;
  if Assigned(FSqlCmd) then
    Result := FSqlCmd.Handle;
end;

procedure TSDDataSet.ISqlInitFieldDefs;
begin
  ASSERT( Assigned(FSqlCmd) );
  FSqlCmd.InitFieldDescs;
end;

procedure TSDDataSet.ISqlPrepare(Value: string);
begin
  ASSERT( Assigned(FSqlCmd) );
  FSqlCmd.Prepare(Value);
end;

procedure TSDDataSet.ISqlExecDirect(Value: string);
begin
  ASSERT( Assigned(FSqlCmd) );
  FSqlCmd.ExecDirect(Value);
end;

procedure TSDDataSet.ISqlExecute;
begin
  ASSERT( Assigned(FSqlCmd) );
  FSqlCmd.Execute;
end;

function TSDDataSet.ISqlFetch: Boolean;
begin
  Result := False;
  if Assigned(FSqlCmd) then
    Result := FSqlCmd.FetchNextRow;
end;

function TSDDataSet.ISqlGetRowsAffected: Integer;
begin
  ASSERT( Assigned(FSqlCmd) );
  Result := FSqlCmd.GetRowsAffected;
end;

procedure TSDDataSet.ISqlCloseResultSet;
begin
  if Assigned(FSqlCmd) then
    FSqlCmd.CloseResultSet;
end;

function TSDDataSet.ISqlConnected: Boolean;
begin
  Result := Assigned(FSqlCmd) and Assigned(FSqlCmd.Handle);
end;

function TSDDataSet.ISqlPrepared: Boolean;
begin
  Result := Assigned(FSqlCmd) and FSqlCmd.Prepared;
end;

procedure TSDDataSet.ISqlDetach;
begin
  if Assigned(FSqlCmd) then begin
    FSqlCmd.Disconnect(True);
    FSqlCmd.InitNewCommand;     // command is unprepared now
  end;
end;

function TSDDataSet.ISqlWriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint;
begin
  ASSERT( Assigned(FSqlCmd) );
  Result := FSqlCmd.WriteBlob(FieldNo, Buffer, Count);
end;

function TSDDataSet.ISqlWriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint;
begin
  ASSERT( Assigned(FSqlCmd) );
  Result := FSqlCmd.WriteBlobByName(Name, Buffer, Count);
end;

{ Record conversion from internal database format to program format in Buffer(record buffer),
where Buffer - record buffer of the current dataset. }
procedure TSDDataSet.ISqlCnvtFieldsBuffer(Buffer: TSDRecordBuffer);
var
  i: Integer;
begin
  ASSERT( Assigned(FSqlCmd) );
	// copy data from internal(database) to program(required) format in Buffer
  for i:=0 to SqlCmd.FieldDescs.Count-1 do
    ISqlCnvtFieldData(SqlCmd, SqlCmd.FieldDescs[i], Buffer, nil);
end;

{ Converts and places field data
  from select buffer (FieldsBuffer of ASqlCmd) of AFieldDesc
  to record Buffer, where AField data is located.
  When AField is equal nil, it will found using FieldByNumber and AFieldDesc info.
  Blob data is moved to record Buffer, i.e. it is released in select buffer of ASqlCmd.
  The method tries to solve possible problem, when AFieldDesc.FieldType <> AField.DataType.
}
procedure TSDDataSet.ISqlCnvtFieldData(ASqlCmd: TISqlCommand; AFieldDesc: TSDFieldDesc;
					Buffer: TSDRecordBuffer; AField: TField);
var
  f: TField;
  FldBuf, ptr: TSDValueBuffer;
  nBufSize: Integer;
  IsEmpty, bCnvtToInt, bCnvtDateTime: Boolean;
  dtValue: LongInt;     // Date or Time part of datetime value
  dtDateTimeRec: TDateTimeRec;
  sBlob: TSDBlobData;
begin
  sBlob := nil;
  if Assigned(AField) then
    f := AField
  else begin
  	// When persistent fields are present (DefaultFields is equal False), but the current field is not persistent (it was added later)
    f := FieldByNumber(AFieldDesc.FieldNo);
    if not Assigned( f ) then
      Exit;
  end;
        // GetFieldBuffer returns a pointer to field buffer in record buffer(converted data)
  FldBuf := GetFieldBuffer( f.FieldNo, Buffer );
  if IsBlobType( AFieldDesc.FieldType ) then begin
    sBlob := ASqlCmd.GetBlobValue( AFieldDesc );
    	// free a reference to blob data in the select buffer
    ASqlCmd.PutBlobValue( AFieldDesc, nil );
	// reference to a record buffer of the dataset (f.Offset can be different FieldDescs[i].Offset in case of persistent fields)
    SetFieldBlobData( Buffer, FBlobCacheOffs, f.Offset, sBlob );
    IsEmpty := Length(sBlob) <= 0;
  end else begin
  	// Convert a column data, which is returned as Float/Int64 and Int16/AutoInc to Integer/AutoInc.
        //For example, when a persistent TInteger/AutoIncField are used to fetch smaller integer or similar datatypes. Also ASA returns @@IDENTITY variable as ftLargeInt, which is not implemented in D4.
    bCnvtToInt := Assigned(f) and (f.DataType <> AFieldDesc.FieldType) and
                  (f.DataType in [ftInteger, ftAutoInc]) and
                  (AFieldDesc.FieldType in [ftSmallint, ftWord, ftAutoInc, ftFloat{$IFDEF XSQL_VCL4}, ftLargeInt{$ENDIF}]);
        // TDate/TimeField (f.DataType is ftDate, ftTime) has Size=4,
        //it is necessary to convert 8 bytes(=sizeof(TDateTimeRec)) datetime value to 4 bytes value.
        //That can happens, if f is a persistent field.
    bCnvtDateTime := Assigned(f) and (f.DataType in [ftDate, ftTime]) and (f.DataType <> AFieldDesc.FieldType);
    if bCnvtToInt then begin
        // allocate maximum buffer size. It's important, when Float/Int64(8byte) -> int(4byte) is converted,
        // when AFieldDesc.DataSize > f.DataSize
      nBufSize := MaxIntValue(f.DataSize, AFieldDesc.DataSize);
      ptr := SafeReallocMem(nil, nBufSize);
      SafeInitMem(ptr, nBufSize, 0);
    end else if bCnvtDateTime then begin
      nBufSize := SizeOf(TDateTimeRec);
      ptr := SafeReallocMem(nil, nBufSize);
    end else begin
      if Assigned(f) and (f.DataType <> AFieldDesc.FieldType) and (f.DataSize <> AFieldDesc.DataSize) then
        DatabaseError(SFieldTypeNotConverted + FieldTypeNames[AFieldDesc.FieldType] + ' to ' + FieldTypeNames[f.DataType] + ' (TSDDataSet.ISqlCnvtFieldData)');
      ptr := TSDValueBuffer( IncPtr(FldBuf, 1) );
      nBufSize := AFieldDesc.DataSize;  // = f.DataSize
    end;
    try
      IsEmpty := not ASqlCmd.GetCnvtFieldData(AFieldDesc, ptr, nBufSize); // convert and place the selected non-blob field data
      if bCnvtToInt then begin
{$IFDEF XSQL_CLR}
        if AFieldDesc.FieldType = ftFloat then
          Marshal.WriteInt32( FldBuf, 1, Trunc( BitConverter.Int64BitsToDouble( Marshal.ReadInt64(ptr) ) ) )
        else if AFieldDesc.FieldType = ftLargeInt then
          Marshal.WriteInt32( FldBuf, 1, Marshal.ReadInt64(ptr) )
        else
          SafeCopyMem( ptr, IncPtr(FldBuf, 1), f.DataSize );
{$ELSE}
        if AFieldDesc.FieldType = ftFloat then
          PInt(@FldBuf[1])^ := Trunc( Double(Pointer(ptr)^) )
{$IFDEF XSQL_D4}
        else if AFieldDesc.FieldType = ftLargeInt then
          PInt(@FldBuf[1])^ := TInt64( ptr^ )          // explicitly cast to Int32
{$ENDIF}
        else // f.DataSize is data length in the converted record buffer. In this line: f.DataSize >= AFieldDesc.DataSize to avoid convertion error.
          SafeCopyMem( ptr, IncPtr(FldBuf, 1), f.DataSize );
{$ENDIF}
      end;
      if bCnvtDateTime then begin
        dtValue := 0;
        dtDateTimeRec := HelperMemReadDateTimeRec(ptr, 0);
        if f.DataType = ftDate then begin
          if AFieldDesc.FieldType = ftDate then
            dtValue := dtDateTimeRec.Date
          else
            dtValue := MSecsToTimeStamp( {$IFDEF XSQL_CLR} Trunc(dtDateTimeRec.DateTime) {$ELSE} dtDateTimeRec.DateTime {$ENDIF} ).Date;
        end else if f.DataType = ftTime then begin
          if AFieldDesc.FieldType = ftTime then
            dtValue := dtDateTimeRec.Time
          else
            dtValue := MSecsToTimeStamp( {$IFDEF XSQL_CLR} Trunc(dtDateTimeRec.DateTime) {$ELSE} dtDateTimeRec.DateTime {$ENDIF} ).Time;
        end else
          ASSERT(False, 'TSDDataSet.ISqlCnvtFieldData');
{$IFDEF XSQL_CLR}
        Marshal.WriteInt32( FldBuf, 1, dtValue );
{$ELSE}
        PInt(@FldBuf[1])^ := dtValue;
{$ENDIF}
      end;
    finally
      if bCnvtToInt or bCnvtDateTime then
        SafeReallocMem(ptr, 0);
    end;
  end;          // if IsBlobType() else ...
  FieldSetNull(FldBuf, IsEmpty);
end;


{$IFDEF XSQL_VCL5}

{ TSDDataSet.IProviderSupport }

function TSDDataSet.PSIsSQLBased: Boolean;
var
  InProvider: Boolean;
begin
  InProvider := SetDSFlag(dsfProvider, True);
  try
    Result := Database.IsSQLBased;
  finally
    SetDSFlag(dsfProvider, InProvider);
  end;
end;

function TSDDataSet.PSIsSQLSupported: Boolean;
begin
  Result := True;
end;

procedure TSDDataSet.PSReset;
begin
  inherited PSReset;

  InternalRefresh;
end;

function TSDDataSet.PSGetQuoteChar: string;
var
  InProvider: Boolean;
begin
  InProvider := SetDSFlag(dsfProvider, True);
  try
	// some servers don't support, for example, quoted table names  
    Result := '';
  finally
    SetDSFlag(dsfProvider, InProvider);
  end;
end;

function TSDDataSet.PSInTransaction: Boolean;
var
  s: TXSQLSession;
  db: TXSQLDatabase;
begin
  Result := False;
  s := Sessions.List[SessionName];
  if Assigned(s) then begin
    db := s.DoFindDatabase(DatabaseName, Owner);
    Result := Assigned(db) and db.InTransaction;
  end;
end;

procedure TSDDataSet.PSStartTransaction;
begin
  SetDSFlag(dsfProvider, True);
  try
    Database.StartTransaction;
  except
    SetDSFlag(dsfProvider, False);
    raise;
  end;
end;

procedure TSDDataSet.PSEndTransaction(Commit: Boolean);
begin
  try
    if Commit then begin
      try
        Database.Commit;
      except
        Database.Rollback;
        raise;
      end;
    end else
      Database.Rollback;
  finally
    SetDSFlag(dsfProvider, False);
  end;
end;

function TSDDataSet.PSExecuteStatement(const ASQL: string; AParams: TParams; {$IFDEF XSQL_CLR} var ResultSet: TObject {$ELSE} ResultSet: TSDPtr = nil {$ENDIF}): Integer;
var
  InProvider: Boolean;
  qryStat: TXSQLQuery;
begin
  Result := -1;
  InProvider := SetDSFlag(dsfProvider, True);
  qryStat := TXSQLQuery.Create(nil);
  try
    try
      qryStat.SessionName  := FSessionName;
      qryStat.DatabaseName := FDatabaseName;

      ASSERT( Assigned(FDatabase), Format(SFatalError, ['TSDDataSet.PSExecuteStatement']) );

      qryStat.SQL.Text := ReplaceQuestionParamMarker(FDatabase.ServerType, ASQL, AParams);
      qryStat.Params.Assign( AParams );
      SetUnknownParamTypeToInput( qryStat.Params );

      if Assigned( ResultSet ) then
        qryStat.Open
      else
        qryStat.ExecSQL;
      Result := qryStat.RowsAffected;
    except
      qryStat.Free;
      qryStat := nil;
      raise;
    end;
  finally
    SetDSFlag(dsfProvider, InProvider);
{$IFDEF XSQL_CLR}
    ResultSet := qryStat
{$ELSE}
    if Assigned( ResultSet ) then
      TDataSet( ResultSet^ ) := qryStat
    else
      qryStat.Free;
{$ENDIF}
  end;
end;

function TSDDataSet.PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError;
var
  PrevErr: Integer;
begin
  if E is ESDEngineError then begin
    if Prev <> nil
    then PrevErr := Prev.ErrorCode
    else PrevErr := 0;

    Result := EUpdateError.Create(E.Message, '', ESDEngineError(E).ErrorCode, PrevErr, E);
  end else
    Result := inherited PSGetUpdateException(E, Prev);
end;

function TSDDataSet.PSUpdateRecord(UpdateKind: TUpdateKind; Delta: TDataSet): Boolean;

  procedure AssignParams(DataSet: TDataSet; Params: TParams);
  var
    i: Integer;
    Old: Boolean;
    Param: TParam;
    PName: string;
    Field: TField;
    Value: Variant;
  begin
    for i := 0 to Params.Count - 1 do begin
      Param := Params[i];
      PName := Param.Name;
      Old := IsOldPrefixExists(PName, OldFieldValuePrefix);
      if Old then DeleteSubstr(PName, 1, Length(OldFieldValuePrefix));
      Field := DataSet.FindField(PName);
      if not Assigned(Field) then Continue;
      if Old then
        Param.AssignFieldValue(Field, Field.OldValue)
      else begin
        Value := Field.NewValue;
        if VarIsEmpty(Value) then Value := Field.OldValue;
        Param.AssignFieldValue(Field, Value);
      end;
    end;
  end;

var
{$IFNDEF XSQL_CLR}
  SQL, sTempSQL: string;
  Params: TParams;
{$ENDIF}
  UpdateAction: TUpdateAction;
begin
  Result := False;
  if Assigned(OnUpdateRecord) then begin
    UpdateAction := uaFail;
    if Assigned(FOnUpdateRecord) then begin
      FOnUpdateRecord(Delta, UpdateKind, UpdateAction);
      Result := UpdateAction = uaApplied;
    end;
  end else if Assigned(UpdateObject) and (UpdateObject is TXSQLUpdateSql) then begin
{$IFDEF XSQL_CLR}
    TXSQLUpdateSql(FUpdateObject).Dataset := Delta as TSDDataSet;
    TXSQLUpdateSql(FUpdateObject).Apply(UpdateKind);
    Result := True;
{$ELSE}
    SQL := TXSQLUpdateSql(FUpdateObject).GetSQL(UpdateKindToStatus(UpdateKind)).Text;
    if SQL <> '' then begin
      Params := TParams.Create;
      try
        sTempSQL := SQL;
        Params.ParseSQL(sTempSQL, True);
        AssignParams(Delta, Params);
        if PSExecuteStatement(SQL, Params) = 0 then
          DatabaseError(SRecordChanged);
        Result := True;
      finally
        Params.Free;
      end;
    end;
{$ENDIF}
  end;
end;

{$ENDIF}

{*******************************************************************************
				TXSQLQueryDataLink
*******************************************************************************}
constructor TXSQLQueryDataLink.Create(AQuery: TXSQLQuery);
begin
  inherited Create;
  FQuery := AQuery;
end;

procedure TXSQLQueryDataLink.ActiveChanged;
begin
  if FQuery.Active then
    FQuery.RefreshParams;
end;

{$IFDEF XSQL_VCL4}
function TXSQLQueryDataLink.GetDetailDataSet: TDataSet;
begin
  Result := FQuery;
end;
{$ENDIF}

procedure TXSQLQueryDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) and FQuery.Active then
    FQuery.RefreshParams;
end;

procedure TXSQLQueryDataLink.CheckBrowseMode;
begin
  if FQuery.Active then FQuery.CheckBrowseMode;
end;


{*******************************************************************************
				TXSQLQuery
*******************************************************************************}
constructor TXSQLQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSQL := TStringList.Create;
  TStringList(SQL).OnChange := QueryChanged;
  FParamCheck 	:= True;
  FParams := TSDHelperParams.Create {$IFDEF XSQL_VCL4} (Self) {$ENDIF};
  FDataLink := TXSQLQueryDataLink.Create(Self);
  FRequestLive	:= False;
  FExecCmd      := True;
  FIndexFields	:= TStringList.Create;
  FRowsAffected := -1;
end;

destructor TXSQLQuery.Destroy;
begin
  Destroying;
  Disconnect;
  
  if Assigned(FIndexFields) then FIndexFields.Free;
  if Assigned(FSQL) then FSQL.Free;
  if Assigned(FParams) then FParams.Free;
  if Assigned(FDataLink) then FDataLink.Free;

  inherited Destroy;
end;

procedure TXSQLQuery.Disconnect;
begin
  Close;
  UnPrepare;
  DestroyHandle;
end;

procedure TXSQLQuery.Prepare;
begin
  if Active then DatabaseError(SDataSetOpen);

  SetDSFlag(dsfPrepared, True);
  try
    SetPrepareCmd(True, False);
  except
    SetDSFlag(dsfPrepared, False);
    raise;
  end;
end;

procedure TXSQLQuery.SetPrepared(Value: Boolean);
begin
  if Value
  then Prepare
  else UnPrepare;
end;

procedure TXSQLQuery.UnPrepare;
begin
  if Active then DatabaseError(SDataSetOpen);

  SetPrepareCmd(False, False);
  SetDSFlag(dsfPrepared, False);
end;

procedure TXSQLQuery.ExecuteCursor;
begin
        // it is not necessary to execute a statement, when IsExecDirect is True
        // and the statement was executed in CreateHandle, in this case FExecCmd = False.
        // FExecCmd - is it necessary to execute statement here.
  if not FExecCmd then
    Exit;

  SetConnectionState( True );
  try
    if IsExecDirect then
      ISqlExecDirect(FText)
    else
      ISqlExecute;
  finally
    SetConnectionState( False );
  end;
end;

procedure TXSQLQuery.ExecSQL;
begin
  FRowsAffected := -1;
  CheckInActive;

  SetBusyState;
  SetDSFlag(dsfExecSQL, True);
  try
    if FDataLink.DataSource <> nil then  // to set data for statement without result set
      SetParamsFromCursor;

    SetPrepareCmd(True, False);
    SetUnknownParamTypeToInput(Params);

    ExecuteCursor;

    FRowsAffected := ISqlGetRowsAffected;
  finally
    SetDSFlag(dsfExecSQL, False);
    ResetBusyState;
  end;
end;

{ It's required to release DB handle for some connections(for example, Mss, Sybase, ODBC)}
procedure TXSQLQuery.ReleaseHandle(SaveRes: Boolean);
begin
  if Active and SaveRes then
    FetchAll;
end;

procedure TXSQLQuery.DoBeforeOpen;
begin
	// make sure that all params have a type set
  SetUnknownParamTypeToInput( Params );

  inherited;
end;

procedure TXSQLQuery.InternalOpen;
begin
  FRowsAffected := -1;

  if FDataLink.DataSource <> nil then
    SetParamsFromCursor;

  FExecCmd := not IsExecDirect;
  try
    inherited;
  finally
    FExecCmd := True;
  end;
end;

procedure TXSQLQuery.InternalPost;
begin
  inherited;

  if RequestLive then
    LiveInternalPost(False, FText, FTableName);
end;

procedure TXSQLQuery.InternalDelete;
begin
  if RequestLive then
    LiveInternalPost(True, FText, FTableName)
  else
    inherited;
end;

procedure TXSQLQuery.RefreshRecord;
begin
  LiveApplyRecord(usUnmodified, FText, FTableName, '');
end;

function TXSQLQuery.GetCanModify: Boolean;
begin
  Result := RequestLive or inherited GetCanModify;
end;

{ Query can be in a RequestLive or in CachedUpdates mode }
procedure TXSQLQuery.SetRequestLive(Value: Boolean);
begin
  CheckInactive;

  FRequestLive := Value;
  FCachedUpdates := not FRequestLive;
end;

procedure TXSQLQuery.SetUpdateMode(const Value: TUpdateMode);
begin
  CheckInactive;

  inherited SetUpdateMode(Value);
end;

// dsfOpened, dsfExecSQL are set immediately before OpenCursor or execution
function TXSQLQuery.IsExecDirect: Boolean;
begin
  Result := ((dsfOpened in DSFlags) or (dsfExecSQL in DSFlags)) and not(dsfPrepared in DSFlags);
end;

// Creates and prepares or execute command handle (FSqlCmd) in case of open a result set or field definition is requested.
// The method is called by OpenCursor (from InternalOpen and InternalRefresh).
procedure TXSQLQuery.CreateHandle;
var
  i, j: Integer;
  fl, tl: TStringList;
  bLiveQuery, bRequestLiveQuery: Boolean;
begin
        // Command has to be prepare, if Prepared is False or (Prepared is True and ISqlPrepared is False).
	// FSqlCmd(cursor) could be destroyed/unprepared after Commit/Rollback or Detach. To test call Refresh after that.
        // the same condition is checked in SetPrepareCmd. Here it is checked to exclude
  if Prepared and not(Prepared and not ISqlPrepared) then
    Exit;

      // RequestLive is meaning for select statements only
  bRequestLiveQuery := RequestLive and IsSelectQuery(Text);
  if bRequestLiveQuery then begin
    if not Assigned(UpdateObject) then begin
      // 2-nd testing, whether SQL command can return a live query
      FTableName := IsLiveQuery(Text);
      if Trim(FTableName) = '' then
        DatabaseError(STableReadOnly);
      if UpdateMode in [upWhereChanged, upWhereKeyOnly] then begin
        if FIndexFields.Count = 0 then
          UpdateUniqueIndexInfo;
        if FIndexFields.Count = 0 then
          DatabaseError(STableReadOnly);
      end;
    end;
  end;
        // set parameter values for detail dataset
  if FDataLink.DataSource <> nil then
    SetParamsFromCursor;

  SetPrepareCmd(True, True);

  try
      // check other conditions for a live (prepared or opened) query
  if bRequestLiveQuery then begin
    bLiveQuery := False;
        // SetPrepareCmd could create FieldDesc with GenCursor is true
    if SqlCmd.FieldDescs.Count = 0 then
      FSqlCmd.InitFieldDescs;
    if UpdateMode in [upWhereAll] then begin
        // a table read only if result set contains only blobs
      for i:=0 to SqlCmd.FieldDescs.Count-1 do
        if not IsBlobType( SqlCmd.FieldDescs[i].FieldType ) then begin
          bLiveQuery := True;   // not all fields are blob, which are not used as key fields to locate record for UPDATE/DELETE statements
          Break;
        end;
    end else if (UpdateMode in [upWhereKeyOnly, upWhereChanged]) then begin
        // check whether all index fields are present in the result set
      fl := TStringList.Create;
      tl := TStringList.Create;
      try
        // query has to be prepared and FieldDescs <> nil, before this call
        GetFieldInfoFromSQL( Text, fl, tl );
        for i:=0 to FIndexFields.Count-1 do begin
          bLiveQuery := False;
          for j:=0 to fl.Count-1 do
            if UpperCase(FIndexFields[i]) = UpperCase(ExtractColumnName( fl[j] )) then begin
              bLiveQuery := True;
              Break;
            end;
          if not bLiveQuery then
            Break;
        end;
      finally
        fl.Free;
        tl.Free;
      end;
    end;

    if not bLiveQuery then begin
      DestroyHandle;
      ResetBusyState;
      DatabaseError(STableReadOnly);
    end;
  end;        // if bRequestLiveQuery

  except
        // it was set in SetPrepareCmd
    FPrepared := False;
    raise;
  end;
end;

{ Changes Prepared property and actually create a command handle (FSqlCmd) and
prepare or direct execute SQL commands, when it's necessary. The command could not be
unprepared and unexecuted after CreateHandle, because ResultSetExists and field definitions will be unknown.
The method will not prepare command actually, if IsExecDirect is True. However FPrepared is set on in this case.
  Value - prepare or unprepare command;
  GenCursor is True, when CreateHandle is called        }
procedure TXSQLQuery.SetPrepareCmd(Value, GenCursor: Boolean);
begin
	// Exit, if state is not changed and not(Prepared and not ISqlPrepare),
        // i.e. command has to be prepare, if Prepared=True and ISqlPrepared=False(FSqlCmd=nil).
	// FSqlCmd(cursor) could be destroyed/unprepared after Commit/Rollback or Detach. To test call Refresh after that.
  if (Prepared = Value) and not(Prepared and not ISqlPrepared) then
    Exit;

  if Value then begin
    FRowsAffected := -1;        // the value has not be reset, when the query is unpreparing  
    if not Assigned(FSqlCmd) then
      FSqlCmd := ISqlCmdCreate;
    if Length(Text) > 1 then begin
      if IsExecDirect then begin
        if GenCursor then
          ISqlExecDirect(FText)
      end else
        ISqlPrepare( FText );
    end else
      DatabaseError(SEmptySQLStatement);
  end else begin
  	// after unprepare may be changed properties: Field(type, count)
    if DefaultFields then DestroyFields;
    if Assigned(FSqlCmd) then
      FSqlCmd.InitNewCommand;
  end;

  FPrepared := Value;
end;

function TXSQLQuery.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TXSQLQuery.SetDataSource(Value: TDataSource);
begin
  if IsLinkedTo(Value) then DatabaseError(SCircularDataLink);
  FDataLink.DataSource := Value;
end;

function TXSQLQuery.SetDSFlag(Flag: Integer; Value: Boolean): Boolean;
begin
  if (not Value) then
    if DSFlags - [Flag] = [] then
      SetPrepareCmd(False, False);
  Result := inherited SetDSFlag(Flag, Value);
end;

function TXSQLQuery.GetParamsCount: Word;
begin
  Result := FParams.Count;
end;

function TXSQLQuery.GetRowsAffected: Integer;
begin
  Result := FRowsAffected;
end;

function TXSQLQuery.ParamByName(const Value: string): TSDHelperParam;
begin
  Result := FParams.ParamByName(Value);
end;

procedure TXSQLQuery.SetParamsFromCursor;
var
  i: Integer;
  DataSet: TDataSet;
begin
  if FDataLink.DataSource <> nil then begin
    DataSet := FDataLink.DataSource.DataSet;
    if DataSet <> nil then begin
      DataSet.FieldDefs.Update;
      for i := 0 to FParams.Count - 1 do
        if not FParams[i].Bound then begin
          FParams[i].AssignField(DataSet.FieldByName(FParams[i].Name));
          FParams[i].Bound := False;
        end;
    end;
  end;
end;

procedure TXSQLQuery.SetParamsList(Value: TSDHelperParams);
begin
  FParams.AssignValues(Value);
end;

{ It is necessary to reopen the query, for example, when a master record is changed }
procedure TXSQLQuery.RefreshParams;
var
  DataSet: TDataSet;
  i: Integer;
  IsValueEqual: Boolean; // whether parameter and the corresponded field values are equal
begin
  DisableControls;
  try
    if FDataLink.DataSource <> nil then begin
    	// get a master dataset
      DataSet := FDataLink.DataSource.DataSet;
      if DataSet <> nil then
        if DataSet.Active and (DataSet.State <> dsSetKey) then begin
          IsValueEqual := not UniDirectional;
          for I := 0 to FParams.Count - 1 do begin
            if not IsValueEqual then
              Break;
            IsValueEqual := IsValueEqual and CompareParamValue( FParams[I], DataSet.FindField(FParams[I].Name) );
          end;
          	// if field values were changed or the dataset is unidirectional (else it is impossible to go to the first record)
          if not IsValueEqual then begin
            Close;
            Open;
          end;
        end;
    end;
  finally
    EnableControls;
  end;
end;

procedure TXSQLQuery.SetQuery(Value: TStrings);
begin
  if SQL.Text <> Value.Text then begin
    Disconnect;
    SQL.BeginUpdate;
    try
      SQL.Assign(Value);
    finally
      SQL.EndUpdate;
    end;
  end;
end;

procedure TXSQLQuery.QueryChanged(Sender: TObject);
var
  List: TSDHelperParams;
begin
  FText := SQL.Text;
  if not (csReading in ComponentState) then begin
    if Active then Close;
    UnPrepare;
    FIndexFields.Clear;
    if ParamCheck or (csDesigning in ComponentState) then begin
      List := TSDHelperParams.Create {$IFDEF XSQL_VCL4}(Self){$ENDIF};
      try
        CreateParamsFromSQL(List, Text, DefaultParamPrefix);
	// assign the current parameter values
        List.AssignValues(FParams);
        FParams.Clear;
        FParams.Assign(List);
      finally
        List.Free;
      end;
    end;
    DataEvent(dePropertyChange, {$IFDEF XSQL_CLR} nil {$ELSE} 0 {$ENDIF});	// FieldDefs.Updated := False - not valid
  end else
    CreateParamsFromSQL(nil, Text, DefaultParamPrefix);
end;

{$IFDEF XSQL_VCL4}
procedure TXSQLQuery.GetDetailLinkFields(MasterFields, DetailFields: TObjectList);

  function AddFieldToList(const FieldName: string; DataSet: TDataSet; List: TList): Boolean;
  var
    Field: TField;
  begin
    Field := DataSet.FindField(FieldName);
    if (Field <> nil) then
      List.Add(Field);
    Result := Field <> nil;
  end;

var
  i: Integer;
begin
  MasterFields.Clear;
  DetailFields.Clear;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    for i := 0 to Params.Count - 1 do
      if AddFieldToList(Params[i].Name, DataSource.DataSet, MasterFields) then
        AddFieldToList(Params[i].Name, Self, DetailFields);
end;

{ To avoid writing, when Params.Count = 0 }
procedure TXSQLQuery.DefineProperties(Filer: TFiler);

  function HasParamData: Boolean;
  begin
    if Filer.Ancestor <> nil
    then Result := not FParams.IsEqual(TXSQLQuery(Filer.Ancestor).FParams)
    else Result := FParams.Count > 0;
  end;

begin
  inherited DefineProperties(Filer);

  Filer.DefineProperty('ParamData', ReadParamData, WriteParamData, HasParamData);
end;

procedure TXSQLQuery.ReadParamData(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FParams);
end;

procedure TXSQLQuery.WriteParamData(Writer: TWriter);
begin
  Writer.WriteCollection(Params);
end;
{$ENDIF}

{$IFDEF XSQL_VCL5}

{ TXSQLQuery.IProviderSupport }

function TXSQLQuery.PSGetParams: TParams;
begin
  Result := Params;
end;

procedure TXSQLQuery.PSSetParams(AParams: TParams);
var
  InProvider, IsParamsEqual: Boolean;
  i: Integer;
  SavedNames: TStrings;
begin
  if Active then
    Close;

  InProvider := SetDSFlag(dsfProvider, True);
  try
    ASSERT( Assigned(FDatabase), Format(SFatalError, ['TSDDataSet.PSSetParams']) );

    SQL.Text := ReplaceQuestionParamMarker(FDatabase.ServerType, SQL.Text, AParams);
  finally
    SetDSFlag(dsfProvider, InProvider);
  end;
	//  Params.Assign(AParams) is imposible to use, because it could change parameter name, which is used to bind a value
  if AParams.Count <> 0 then begin
    Params.BeginUpdate;
    SavedNames := TStringList.Create;
    try
      IsParamsEqual := Params.Count = AParams.Count;
    	// save old parameter names
      for i:=0 to Params.Count-1 do begin
        SavedNames.Add(Params[i].Name);
        IsParamsEqual := IsParamsEqual and Assigned( AParams.FindParam(Params[i].Name) );
      end;
      Params.Clear;
      for i:=0 to AParams.Count-1 do begin
        Params.Add.Assign(AParams[i]);
	// restore an old parameter name, if IsParamsEqual = False (Count or parameter names are differed)
        if not IsParamsEqual and (i < SavedNames.Count) then
          Params[Params.Count-1].Name := SavedNames[i];
      end;

      SetUnknownParamTypeToInput(Params);
    finally
      Params.EndUpdate;
      SavedNames.Free;
    end;
  end;
end;

function TXSQLQuery.PSGetTableName: string;
begin
	// Return tablename in SQL
  Result := GetTableNameFromSQL(SQL.Text);
end;

procedure TXSQLQuery.PSExecute;
begin
  ExecSQL;
end;

procedure TXSQLQuery.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    SQL.Text := CommandText;
end;
{$ENDIF}

{-------------------------------------------------------------------------------
			SQL server C/API Functions
-------------------------------------------------------------------------------}
procedure TXSQLQuery.SetSqlCmd(Value: TISqlCommand);
begin
  Close;
  DestroySqlCommand(True);

  FSqlCmd := Value;
  SQL.Text := Value.CommandText;
  if Assigned(Value) then
  try
    Open;	// the previously executed statement(TISqlCommand) could be executed again, if dsfPrepared is set on here
  except
    FSqlCmd := nil;
    raise;
  end;
end;

function TXSQLQuery.ISqlCmdCreate: TISqlCommand;
begin
  Result := inherited ISqlCmdCreate;
  Result.CommandType := ctQuery;
  Result.Params := FParams;
  Result.OnReleaseHandle := Self.ReleaseHandle;
end;

{ Index Related }

{ Is a Field is part of the current index }
function TXSQLQuery.GetIsIndexField(Field: TField): Boolean;
begin
  Result := RequestLive and (FIndexFields.IndexOf(Field.FieldName) >= 0);
end;

{ Requests indexes for FTableName and save fields of the first unique index }
procedure TXSQLQuery.UpdateUniqueIndexInfo;
var
  ds: TDataSet;
  sIdxName, sNextIdxName: string;
begin
  ds := nil;
  sIdxName := '';
  FIndexFields.Clear;

  SetDSFlag(dsfIndexList, True);
  try
    ds := Database.GetSchemaInfo(stIndexes, FTableName);
    if Assigned(ds) then begin
      while not ds.EOF do begin
	// some servers (for example, ODBC) don't truncate trailing spaces
        sNextIdxName := TrimRight( ds.FieldByName(IDX_NAME_FIELD).AsString );
      	// check an index name to add fields of one(first) unique index only
        if ((sIdxName = '') or (sIdxName = sNextIdxName)) and
           ((ds.FieldByName(IDX_TYPE_FIELD).AsInteger and UniqueIndexType) <> 0)
        then begin
          FIndexFields.Add( TrimRight(ds.FieldByName(IDX_COL_NAME_FIELD).AsString) );
          sIdxName := sNextIdxName;
        end;
        ds.Next;
      end;
    end;
  finally
    SetDSFlag(dsfIndexList, False);
    if Assigned(ds) then
      ds.Free;
  end;
end;

{*******************************************************************************
 		TXSQLMacroQuery
*******************************************************************************}
constructor TXSQLMacroQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMacroChar := DefaultQueryMacroChar;

  FSaveQueryChanged := TStringList(inherited SQL).OnChange;
  TStringList(inherited SQL).OnChange := QueryChanged;

  FSQLPattern := TStringList.Create;
  TStringList(FSQLPattern).OnChange := PatternChanged;

  FMacros := TSDHelperParams.Create {$IFDEF XSQL_VCL4} (Self) {$ENDIF};
end;

destructor TXSQLMacroQuery.Destroy;
begin
  inherited;

  FMacros.Free;
  FSQLPattern.Free;
end;

{$IFDEF XSQL_VCL4}

procedure TXSQLMacroQuery.DefineProperties(Filer: TFiler);

  function HasMacroData: Boolean;
  begin
    if Filer.Ancestor <> nil
    then Result := not FMacros.IsEqual(TXSQLMacroQuery(Filer.Ancestor).FMacros)
    else Result := FMacros.Count > 0;
  end;

begin
  inherited DefineProperties(Filer);

  Filer.DefineProperty('MacroData', ReadMacroData, WriteMacroData, HasMacroData);
end;

procedure TXSQLMacroQuery.ReadMacroData(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FMacros);
end;

procedure TXSQLMacroQuery.WriteMacroData(Writer: TWriter);
begin
  Writer.WriteCollection(Macros);
end;

{$ENDIF}

function TXSQLMacroQuery.GetMacroCount: Word;
begin
  Result := FMacros.Count;
end;

function TXSQLMacroQuery.GetMacros: TSDHelperParams;
begin
  Result := FMacros;
end;

function TXSQLMacroQuery.MacroByName(const MacroName: string): TSDHelperParam;
begin
  Result := FMacros.ParamByName(MacroName);
end;

procedure TXSQLMacroQuery.SetMacroChar(const Value: Char);
begin
  if Value <> FMacroChar then begin
    FMacroChar := Value;
    CreateMacros;
  end;
end;

procedure TXSQLMacroQuery.SetMacros(const Value: TSDHelperParams);
begin
  FMacros.AssignValues(Value);
end;

{ Sets an unexpanded(FSQLPattern) and a real(expanded)(inherited SQL) statements }
procedure TXSQLMacroQuery.SetQuery(Value: TStrings);
begin
  if FSQLPattern.Text <> Value.Text then begin
    FSQLPattern.BeginUpdate;
    try
      FSQLPattern.Assign(Value);
    finally
      FSQLPattern.EndUpdate;
    end;
  end;

  inherited SetQuery(Value);
end;

procedure TXSQLMacroQuery.QueryChanged(Sender: TObject);
begin
  FSaveQueryChanged(Sender);
	// to exclude recursion
  if not FMacrosExpanding then
    SQL := inherited SQL;
end;

procedure TXSQLMacroQuery.PatternChanged(Sender: TObject);
begin
  CreateMacros;

  ExpandMacros;
end;

{ parses a statement for macros and fills FMacros list }
procedure TXSQLMacroQuery.CreateMacros;
var
  List: TSDHelperParams;
  i: Integer;
begin
  if not (csReading in ComponentState) then begin
    List := TSDHelperParams.Create {$IFDEF XSQL_VCL4}(Self){$ENDIF};
    try
      CreateParamsFromSQL(List, FSQLPattern.Text, FMacroChar);
	// assign the current parameter values
      List.AssignValues(FMacros);
      	// Do not change old FMacros[i].Value, else set FMacros[i].DataType to ftString and a default value,
      for i:=0 to List.Count-1 do
        if List[i].DataType = ftUnknown then
          List[i].AsString := DefaultQueryMacroExpr;

      FMacros.Clear;
      FMacros.Assign(List);
    finally
      List.Free;
    end;
  end else begin
    FMacros.Clear;
    CreateParamsFromSQL(FMacros, Text, FMacroChar);
  end;
end;

{ Expands macros and assign a real SQL text }
procedure TXSQLMacroQuery.ExpandMacros;
var
  i: Integer;
  s: string;
begin
  s := FSQLPattern.Text;
  for i:=0 to MacroCount-1 do begin
    if Macros[i].DataType = ftUnknown then
      Continue;
    ReplaceString(False, MacroChar + Macros[i].Name, Macros[i].AsString, s);
  end;
	// to exclude a recursion
  FMacrosExpanding := True;
  try
    inherited SQL.Text := s;
  finally
    FMacrosExpanding := False;
  end;
end;

function TXSQLMacroQuery.SetDSFlag(Flag: Integer; Value: Boolean): Boolean;
begin
	// the first flag will be set on before a prepare phase
  if Value and (DSFlags = []) then
    ExpandMacros;

  Result := inherited SetDSFlag(Flag, Value);
end;

{*******************************************************************************
 					TXSQLUpdateSql
*******************************************************************************}
constructor TXSQLUpdateSql.Create(AOwner: TComponent);
var
  i: TUpdateStatus;
begin
  inherited Create(AOwner);

  for i := Low(TUpdateStatus) to High(TUpdateStatus) do begin
    FSQLText[i] := TStringList.Create;
    TStringList(FSQLText[i]).OnChange := SQLChanged;
  end;
end;

destructor TXSQLUpdateSql.Destroy;
var
  i: TUpdateStatus;
begin
  if Assigned(FDataSet) and (FDataSet.UpdateObject = Self) then
    FDataSet.UpdateObject := nil;
  for i := Low(TUpdateStatus) to High(TUpdateStatus) do
    FSQLText[i].Free;

  inherited Destroy;
end;

procedure TXSQLUpdateSql.ExecSQL(UpdateKind: TUpdateKind);
begin
  with QueryEx[ UpdateKindToStatus(UpdateKind) ] do begin
    ExecSQL;
    if RowsAffected <> 1 then DatabaseError(SUpdateFailed);
  end;
end;

function TXSQLUpdateSql.GetQuery(UpdateKind: TUpdateKind): TXSQLQuery;
begin
  Result := GetQueryEx( UpdateKindToStatus(UpdateKind) );
end;

function TXSQLUpdateSql.GetQueryEx(StmtKind: TUpdateStatus): TXSQLQuery;
begin
  if not Assigned(FQueries[StmtKind]) then begin
    FQueries[StmtKind] := TXSQLQuery.Create(Self);
    FQueries[StmtKind].SQL.Assign(FSQLText[StmtKind]);

    ASSERT( FDataSet <> nil, 'Property TSDUpdateObject.DataSet = nil !!!' );

    if (FDataSet is TSDDataSet) then begin
      FQueries[StmtKind].SessionName  := TSDDataSet(FDataSet).SessionName;
      FQueries[StmtKind].DatabaseName := TSDDataSet(FDataSet).DatabaseName;
    end;
  end;
  Result := FQueries[StmtKind];
end;

function TXSQLUpdateSql.GetSQL(StmtKind: TUpdateStatus): TStrings;
begin
  Result := FSQLText[StmtKind];
end;

function TXSQLUpdateSql.GetSQLIndex(Index: Integer): TStrings;
begin
  Result := FSQLText[TUpdateStatus(Index)];
end;

function TXSQLUpdateSql.GetDataSet: TSDDataSet;
begin
  Result := FDataSet;
end;

procedure TXSQLUpdateSql.SetDataSet(ADataSet: TSDDataSet);
var
  i: TUpdateStatus;
begin
  if FDataSet = ADataSet then
    Exit;

  for i := Low(TUpdateStatus) to High(TUpdateStatus) do begin
    if Assigned(FQueries[i]) then begin
      FQueries[i].UnPrepare;
      FQueries[i].Free;
      FQueries[i] := nil;
    end;
  end;

  FDataSet := ADataSet;
end;

procedure TXSQLUpdateSql.SetSQL(StmtKind: TUpdateStatus; Value: TStrings);
begin
  FSQLText[StmtKind].Assign(Value);
end;

procedure TXSQLUpdateSql.SetSQLIndex(Index: Integer; Value: TStrings);
begin
  SetSQL(TUpdateStatus(Index), Value);
end;

procedure TXSQLUpdateSql.SQLChanged(Sender: TObject);
var
  i: TUpdateStatus;
begin
  for i := Low(TUpdateStatus) to High(TUpdateStatus) do
    if Sender = FSQLText[i] then begin
      if Assigned( FQueries[i] ) then begin
        FQueries[i].Params.Clear;
        FQueries[i].SQL.Assign( FSQLText[i] );
      end;
      Break;
    end;
end;

procedure TXSQLUpdateSql.SetParams(UpdateKind: TUpdateKind);
var
  i: Integer;
  Old: Boolean;
  Param: TSDHelperParam;
  PName: string;
  Field: TField;
begin
  if not Assigned(FDataSet) then Exit;
  with QueryEx[ UpdateKindToStatus(UpdateKind) ] do begin
    for i := 0 to Params.Count - 1 do begin
      Param := Params[i];
      PName := Param.Name;
      Old := IsOldPrefixExists(PName, OldFieldValuePrefix );
      if Old then DeleteSubstr(PName, 1, Length(OldFieldValuePrefix));
      Field := FDataSet.FindField(PName);
      if not Assigned(Field) then Continue;
      if Old
      then Param.AssignFieldValue(Field, Field.OldValue)
      else Param.AssignFieldValue(Field, Field.NewValue);
    end;
  end;
end;

procedure TXSQLUpdateSql.Apply(UpdateKind: TUpdateKind);
begin
  SetParams(UpdateKind);
  ExecSQL(UpdateKind);
end;


{*******************************************************************************
					TSDBlobStream
*******************************************************************************}
constructor TSDBlobStream.Create(Field: TBlobField; Mode: TBlobStreamMode);
begin
  inherited Create;
  FMode := Mode;
  FField := Field;
  FDataSet := FField.DataSet as TSDDataSet;
  FCached := FDataSet.FCacheBlobs;
  FFieldNo := FField.FieldNo;
  if not FDataSet.GetActiveRecBuf(FBuffer) then Exit;
  if FDataSet.State = dsFilter then
    DatabaseErrorFmt(SNoFieldAccess, [FField.DisplayName]);
  if not FField.Modified then
    if Mode = bmWrite then begin
      if FField.ReadOnly then
        DatabaseErrorFmt(SFieldReadOnly, [FField.DisplayName]);
      if not (FDataSet.State in [dsEdit, dsInsert]) then
        DatabaseError(SNotEditing);
    end;
  FOpened := True;
  FBlobSize := -1;
  if Mode = bmWrite then Truncate;
end;

destructor TSDBlobStream.Destroy;
begin
  if FOpened then
    if FModified then FField.Modified := True;
  if FModified then
  try
    FDataSet.DataEvent(deFieldChange, {$IFDEF XSQL_CLR} FField {$ELSE} Longint(FField) {$ENDIF});
  except
    FDataSet.InternalHandleException;
  end;
end;

function TSDBlobStream.GetBlobSize: Longint;
begin
  Result := 0;
  if FOpened then
    if FCached then begin
      ASSERT( FBuffer<>nil, Format(SFatalError, ['TSDBlobStream.GetBlobSize']) );

      FBlobSize := FDataSet.GetBlobDataSize(FField, FBuffer);
      Result := FBlobSize;
    end else
      Result := FBlobSize;
end;

function TSDBlobStream.Read(var Buffer {$IFDEF XSQL_CLR}: TBytes; Offset,{$ELSE}; {$ENDIF} Count: LongInt): Longint;
var
  sBlob: TSDBlobData;
begin
  Result := 0;
  sBlob := nil;
  if FOpened then begin
    if FCached then begin	// If cached field then data is copied from the record cache
      if Count > Size - FPosition
      then Result := Size - FPosition
      else Result := Count;
      if Result > 0 then begin
        sBlob := FDataSet.GetBlobData(FField, FBuffer);
{$IFDEF XSQL_CLR}
        System.Array.Copy( sBlob, FPosition, Buffer, 0, Result );
{$ELSE}
        Move( PChar(sBlob)[FPosition], Buffer, Result );
{$ENDIF}
        Inc(FPosition, Result);
      end;
    end else begin		// else data is received from the cache stream FBlobData
	// save in the record cache
      if FDataset.FCacheBlobs and
        (FMode = bmRead) and not FField.Modified and
        ((FPosition = FCacheSize) or (FPosition = 0))
      then begin
        FCacheSize := FBlobSize;
        Result := FBlobSize;
        if FCacheSize = Size then begin
          SetFieldBlobData( FBuffer, FDataSet.FBlobCacheOffs, FField.Offset, FBlobData );
          FBlobData := nil;
          FCached := True;
        end;
      end;
    end;
  end;
end;

function TSDBlobStream.Write(const Buffer {$IFDEF XSQL_CLR}: TBytes; Offset,{$ELSE}; {$ENDIF} Count: Longint): Longint;
var
  sBlob: TSDBlobData;
  DataPtr: TSDValueBuffer;
begin
  if (FMode = bmWrite) and (not FCached) then begin
        // at present FCached = True always, i.e. below code is not used 
    try
{$IFDEF XSQL_CLR}
      DataPtr := SafeReallocMem(nil, Count);
      Marshal.Copy(Buffer, 0, DataPtr, Count);
{$ELSE}
      DataPtr := @Buffer;
{$ENDIF}
      Result := FDataSet.ISqlWriteBlob(FFieldNo, DataPtr, Count);
    finally
{$IFDEF XSQL_CLR}
      SafeReallocMem(DataPtr, 0);
{$ENDIF}
    end;
  end else
    Result := Count;
	// get current blob value
  sBlob := FDataSet.GetBlobData(FField, FBuffer);
  	// increase length of blob buffer
  if (FPosition + Count) > Length(sBlob) then
    SetLength(sBlob, FPosition + Count);
    	// move new data(Buffer) in current position(FPosition)
{$IFDEF XSQL_CLR}
  System.Array.Copy( Buffer, 0, sBlob, FPosition, Count );
{$ELSE}
  Move( PChar(@Buffer)^, PChar(@sBlob[FPosition])^, Count );
{$ENDIF}
  	// save new blob value
  FDataSet.SetBlobData(FField, FBuffer, sBlob);

  Inc(FPosition, Count);
  FModified := True;
end;

procedure TSDBlobStream.SetSize(NewSize: {$IFDEF XSQL_CLR}Int64 {$ELSE} Longint {$ENDIF});
var
  sBlob: TSDBlobData;
begin
        // do nothing for non-writable streams
  if (FMode = bmWrite) and (FCached) then begin
    sBlob := FDataSet.GetBlobData(FField, FBuffer);
    SetLength(sBlob, NewSize);
        // save new blob value
    FDataSet.SetBlobData(FField, FBuffer, sBlob);
  end;
end;

{$IFDEF XSQL_CLR}
function TSDBlobStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  case Origin of
    soBeginning:FPosition := Offset;
    soCurrent:  Inc(FPosition, Offset);
    soEnd:      FPosition := GetBlobSize + Offset;
  end;
{$ELSE}
function TSDBlobStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    0: FPosition := Offset;
    1: Inc(FPosition, Offset);
    2: FPosition := GetBlobSize + Offset;
  end;
{$ENDIF}
  Result := FPosition;
end;

{ Sets in zero(begin) position. Data will be overwritten really in Write method }
procedure TSDBlobStream.Truncate;
begin
  if FOpened then begin
    FPosition := 0;
    FModified := True;

    FDataSet.SetBlobData(FField, FBuffer, nil);
  end;
end;


(*******************************************************************************
				TXSQLStoredProc
*******************************************************************************)
constructor TXSQLStoredProc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  FExecCmd      := True;
  FParams := TSDHelperParams.Create {$IFDEF XSQL_VCL4} (Self) {$ENDIF};
end;

destructor TXSQLStoredProc.Destroy;
begin
  Destroying;
  Disconnect;
  FParams.Free;

  inherited Destroy;
end;

{$IFDEF XSQL_VCL4}
procedure TXSQLStoredProc.DefineProperties(Filer: TFiler);

  function WriteData: Boolean;
  begin
    if Filer.Ancestor <> nil
    then Result := not FParams.IsEqual(TXSQLStoredProc(Filer.Ancestor).FParams)
    else Result := FParams.Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ParamData', ReadParamData, WriteParamData, WriteData);
end;

procedure TXSQLStoredProc.WriteParamData(Writer: TWriter);
begin
  Writer.WriteCollection(Params);
end;

procedure TXSQLStoredProc.ReadParamData(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(Params);
end;
{$ENDIF}

procedure TXSQLStoredProc.Disconnect;
begin
  Close;
  UnPrepare;
  DestroyHandle;
end;

procedure TXSQLStoredProc.CreateHandle;
begin
  FSqlCmd := ISqlCmdCreate;

  SetPrepareCmd(True, True);
end;

procedure TXSQLStoredProc.ExecuteCursor;
begin
        // it is not necessary to execute a statement, when IsExecDirect is True
        // and the statement was executed in CreateHandle, in this case FExecCmd = False.
        // FExecCmd - is it necessary to execute statement here.
  if not FExecCmd then
    Exit;

  SetConnectionState( True );
  try
    if IsExecDirect then
      ISqlExecProcDirect
    else
      ISqlExecProc;
  finally
    SetConnectionState( False );
  end;
end;

procedure TXSQLStoredProc.ExecProc;
begin
  CheckInActive;
  SetBusyState;
  SetDSFlag(dsfExecProc, True);
  SetConnectionState( True );
  try
    SetPrepareCmd(True, False);
    BindParams;
    ExecuteCursor;
    	// returns output parameters for MSSQL and Sybase servers. For other server it does nothing.
    ISqlGetResults;
  finally
    SetConnectionState( False );
    SetDSFlag(dsfExecProc, False);
    ResetBusyState;
  end;
end;

procedure TXSQLStoredProc.GetResults;
begin
  if not Assigned(SqlCmd) then
    Exit;
  if Active and SqlCmd.SqlDatabase.ProcSupportsCursors then
    FetchAll;
  ISqlGetResults;
end;

function TXSQLStoredProc.NextResultSet: Boolean;
var
  bSaveFlag: Boolean;
begin
  Result := ISqlNextResultSet;
  if not Result then
    Exit;

  bSaveFlag := not (dsfStoredProc in DSFlags);
  FGetNextResultSet := True;
  try
	// to preserve connection when dataset will be closed
    if bSaveFlag then
      SetDSFlag(dsfStoredProc, True);

    SetState(dsInactive);
    CloseCursor;	// to exclude triggering BeforeClose/AfterClose event
    ClearFieldDefs;	// it's necessary to initialize again

    Open;
  finally
    FGetNextResultSet := False;
	// restore a flag state
    if bSaveFlag then
      SetDSFlag(dsfStoredProc, False);
  end;
end;

procedure TXSQLStoredProc.CloseCursor;
begin
  inherited;

	// this condition is required for possibility to add persistent fields at design-time
  if not(csDesigning in ComponentState) then
    ClearFieldDefs;	// it's important for procedures, which can return some result sets
end;

procedure TXSQLStoredProc.SetProcName(const Value: string);
begin
  if not (csReading in ComponentState) then begin
    CheckInactive;
    if Value <> FProcName then begin
      FProcName := Value;
      UnPrepare;
      FParams.Clear;
    end;
  end else
    FProcName := Value;
end;

procedure TXSQLStoredProc.SetOverLoad(Value: Word);
begin
  if not (csReading in ComponentState) then begin
    CheckInactive;
    if Value <> OverLoad then begin
      FOverLoad := Value;
      UnPrepare;      
      FParams.Clear;
    end
  end else
    FOverLoad := Value;
end;

function TXSQLStoredProc.GetParamsCount: Word;
begin
  Result := FParams.Count;
end;

procedure TXSQLStoredProc.CreateParamDesc;
begin
  ISqlPrepareProc;
end;

function TXSQLStoredProc.DescriptionsAvailable: Boolean;
begin
  SetDSFlag(dsfProcDesc, True);
  try
    Result := ISqlDescriptionsAvailable;
  finally
    SetDSFlag(dsfProcDesc, False);
  end;
end;

{ It's required to release DB handle for some connections(for example, Mss, Sybase, ODBC)}
procedure TXSQLStoredProc.ReleaseHandle(SaveRes: Boolean);
begin
  if Active and SaveRes then
    FetchAll;
end;

procedure TXSQLStoredProc.InternalOpen;
begin
  BindParams;

  FExecCmd := not IsExecDirect;
  try
    inherited;
  finally
    FExecCmd := True;
  end;
end;

procedure TXSQLStoredProc.BindParams;
var
  i: Integer;
begin
  for i:=0 to ParamCount-1 do
    if Params[i].ParamType = ptOutput then
      Params[i].Clear;
end;

// dsfOpened, dsfExecProc are set immediately before OpenCursor or execution
function TXSQLStoredProc.IsExecDirect: Boolean;
begin
  Result := ((dsfOpened in DSFlags) or (dsfExecProc in DSFlags)) and not(dsfStoredProc in DSFlags);
end;

procedure TXSQLStoredProc.SetPrepareCmd(Value, GenCursor: Boolean);
begin
	// not Exit, if state is changed or (Prepared and not ISqlPrepared), i.e.
	// FSqlCmd(cursor) could be destroyed/unprepared after Commit/Rollback or Detach. To test call Refresh after that.
  if (Prepared = Value) and not(Prepared and not ISqlPrepared) then
    Exit;

  if Value then
  try
    if not Assigned(FSqlCmd) then
      FSqlCmd := ISqlCmdCreate;         // CreateHandle; was called earlier (20.03.2005), which calls SetPrepareCmd recursively

    if not FSqlCmd.Prepared then
      if IsExecDirect then begin
        if GenCursor then
          ISqlExecProcDirect;
      end else
        ISqlPrepareProc; 	// compile and get parameters(or vice versa) of stored procedure
  except
    raise;
  end
  else
    if DefaultFields then DestroyFields;

  FPrepared := Value;
end;

procedure TXSQLStoredProc.Prepare;
begin
  if Active then DatabaseError(SDataSetOpen);

  SetDSFlag(dsfStoredProc, True);
  SetPrepareCmd(True, False);
end;

procedure TXSQLStoredProc.UnPrepare;
begin
  SetPrepareCmd(False, False);
  SetDSFlag(dsfStoredProc, False);
end;

procedure TXSQLStoredProc.SetPrepared(Value: Boolean);
begin
  if Value
  then Prepare
  else UnPrepare;
end;

function TXSQLStoredProc.SetDSFlag(Flag: Integer; Value: Boolean): Boolean;
begin
  if not Value and (DSFlags - [Flag] = []) then
    SetPrepareCmd(False, False);
  Result := inherited SetDSFlag(Flag, Value);
end;

procedure TXSQLStoredProc.CopyParams(Value: TSDHelperParams);
begin
  if not Prepared and (FParams.Count = 0) then
    try
      FQueryMode := True;
      Prepare;
      Value.Assign(FParams);
    finally
      UnPrepare;
      FQueryMode := False;
    end
  else
    Value.Assign(FParams);
end;

procedure TXSQLStoredProc.SetParamsList(Value: TSDHelperParams);
begin
  CheckInactive;
  if Prepared then begin
    SetPrepareCmd(False, False);
    FParams.Assign(Value);
    SetPrepareCmd(True, False);
  end else
    FParams.Assign(Value);
end;

function TXSQLStoredProc.ParamByName(const Value: string): TSDHelperParam;
begin
  Result := FParams.ParamByName(Value);
end;

{$IFDEF XSQL_VCL5}

{ TXSQLStoredProc.IProviderSupport }

function TXSQLStoredProc.PSGetParams: TParams;
begin
  Result := Params;
end;

procedure TXSQLStoredProc.PSSetParams(AParams: TParams);
begin
  if AParams.Count > 0 then
    Params.Assign(AParams);
  Close;
end;

function TXSQLStoredProc.PSGetTableName: string;
begin
  Result := inherited PSGetTableName;
end;

procedure TXSQLStoredProc.PSExecute;
begin
  ExecProc;
end;

procedure TXSQLStoredProc.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    StoredProcName := CommandText;
end;
{$ENDIF}

{-------------------------------------------------------------------------------
			Common SQL server C/API Functions
-------------------------------------------------------------------------------}
function TXSQLStoredProc.ISqlCmdCreate: TISqlCommand;
begin
  Result := inherited ISqlCmdCreate;
  Result.CommandType := ctStoredProc;
  Result.Params := FParams;
  Result.OnReleaseHandle := Self.ReleaseHandle;
end;

function TXSQLStoredProc.ISqlDescriptionsAvailable: Boolean;
var
  db: TXSQLDatabase;
begin
	// Can not use FSqlCmd, because FSqlCmd=nil, when Prepared=False;
  if FDatabase <> nil then
    db := FDatabase
  else
    db := Session.OpenDatabase(DatabaseName);
  if not db.Connected then
    db.Open;
  ASSERT( db.FSqlDatabase<>nil, 'TXSQLStoredProc.ISqlDescriptionsAvailable: FSqlDatabase=nil' );
  Result := db.FSqlDatabase.SPDescriptionsAvailable;
end;

function TXSQLStoredProc.ISqlNextResultSet: Boolean;
begin
  Result := False;
  if Assigned(SqlCmd) then
    Result := SqlCmd.NextResultSet;
end;

procedure TXSQLStoredProc.ISqlPrepareProc;
begin
  ISqlPrepare( StoredProcName );
end;

procedure TXSQLStoredProc.ISqlExecProcDirect;
begin
  ISqlExecDirect( StoredProcName );
	// MSSQL, Sybase & ODBC require to call FetchAll before this
  if not SqlCmd.SqlDatabase.ProcSupportsCursors then
    SqlCmd.GetOutputParams;
end;

procedure TXSQLStoredProc.ISqlExecProc;
begin
  ISqlExecute;
	// MSSQL, Sybase & ODBC require to call FetchAll before this
  if not SqlCmd.SqlDatabase.ProcSupportsCursors then
    SqlCmd.GetOutputParams;
end;

procedure TXSQLStoredProc.ISqlGetResults;
begin
  if Assigned(SqlCmd) then
    SqlCmd.GetOutputParams;
end;

{ TXSQLTable }
{$IFDEF XSQL_VCL5}
constructor TXSQLTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCachedUpdates := False;
  FIndexDefs := TIndexDefs.Create(Self);
  FMasterLink := TMasterDataLink.Create(Self);
  FMasterLink.OnMasterChange := MasterChanged;
  FMasterLink.OnMasterDisable := MasterDisabled;
  FParams := TSDHelperParams.Create {$IFDEF XSQL_VCL4} (Self) {$ENDIF};

  FDefaultIndex := True;
  FIndexFieldCount := 0;
  FOrderByFields := '';
  FWhereText := '';
end;

destructor TXSQLTable.Destroy;
begin
  ClearIndexDescs;
  if Assigned(FIndexDefs) then FIndexDefs.Free;
  if Assigned(FMasterLink) then FMasterLink.Free;
  if Assigned(FParams) then FParams.Free;
  
  inherited;
end;

{ It's required to release DB handle for some connections(for example, Mss, Sybase, ODBC)}
procedure TXSQLTable.ReleaseHandle(SaveRes: Boolean);
begin
  if Active and SaveRes then
    FetchAll;
end;

function TXSQLTable.FieldDefsStored: Boolean;
begin
  Result := StoreDefs and (FieldDefs.Count > 0);
end;

function TXSQLTable.IndexDefsStored: Boolean;
begin
  Result := StoreDefs and (IndexDefs.Count > 0);
end;

function TXSQLTable.GetIndexFieldNames: string;
begin
  if FFieldsIndex then Result := FIndexName else Result := '';
end;

function TXSQLTable.GetIndexName: string;
begin
  if FFieldsIndex then Result := '' else Result := FIndexName;
end;

procedure TXSQLTable.GetIndexNames(List: TStrings);
begin
  IndexDefs.Update;
  IndexDefs.GetItemNames(List);
end;

procedure TXSQLTable.SetIndexDefs(Value: TIndexDefs);
begin
  IndexDefs.Assign(Value);
end;

function TXSQLTable.GetIsIndexField(Field: TField): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Field.FieldNo > 0 then
    for i := 0 to FIndexFieldCount - 1 do
      if FIndexFieldMap[i] = Field.FieldNo then begin
        Result := True;
        Exit;
      end;
end;

function TXSQLTable.GetIndexField(Index: Integer): TField;
var
  FieldNo: Integer;
begin
  if (Index < 0) or (Index >= FIndexFieldCount) then
    DatabaseError(SFieldIndexError, Self);
  FieldNo := FIndexFieldMap[Index];
  Result := FieldByNumber(FieldNo);
  if Result = nil then
    DatabaseErrorFmt(SIndexFieldMissing, [FieldDefs[FieldNo - 1].Name], Self);
end;

procedure TXSQLTable.SetIndexField(Index: Integer; Value: TField);
begin
  GetIndexField(Index).Assign(Value);
end;

function TXSQLTable.GetIndexFieldCount: Integer;
begin
  Result := FIndexFieldCount;
end;

procedure TXSQLTable.SetIndex(const Value: string; FieldsIndex: Boolean);
begin
  if Active then CheckBrowseMode;
  if (FIndexName <> Value) or (FFieldsIndex <> FieldsIndex) then begin
    FIndexName := Value;
    FFieldsIndex := FieldsIndex;
    if Active then begin
      Detach;

      InternalRefresh;
      Resync([]);
    end;
  end;
end;

procedure TXSQLTable.SetIndexFieldNames(const Value: string);
begin
  SetIndex(Value, Value <> '');
end;

procedure TXSQLTable.SetIndexName(const Value: string);
begin
  SetIndex(Value, False);
end;

procedure TXSQLTable.SetReadOnly(Value: Boolean);
begin
  CheckInactive;
  FReadOnly := Value;
end;

procedure TXSQLTable.SetTableName(const Value: string);
begin
  if csReading in ComponentState then
    FTableName := Value
  else if (FTableName <> Value) then begin
    CheckInactive;
    FTableName := Value;
    FOrderByFields := '';
    DataEvent(dePropertyChange, {$IFDEF XSQL_CLR} nil {$ELSE} 0 {$ENDIF});
  end;
end;

procedure TXSQLTable.UpdateIndexDefs;
const
  DeltaFieldMap = 5;
  function ExcludeAscDesc(s: string): string;
  const
    SAsc = ' ASC';
    SDesc= ' DESC';
  var
    i: Integer;
  begin
    i := Pos(SAsc, UpperCase(s));
    if i > 0 then
      DeleteSubstr(s, i, Length(SAsc));
    i := Pos(SDesc, UpperCase(s));
    if i > 0 then
      DeleteSubstr(s, i, Length(SDesc));
    Result := s;
  end;
var
  sFld, Flds: string;
  i, CurIndex, iFld: Integer;
  Opts: TIndexOptions;
begin
  SetDSFlag(dsfIndexList, True);
  try
    FieldDefs.Update;
    IndexDefs.Clear;

    for i:=Low(FIndexDescs) to High(FIndexDescs) do begin
      Opts := [];
      if FIndexDescs[i].bUnique then
        Opts := Opts + [ixUnique];
      if FIndexDescs[i].bPrimary then
        Opts := Opts + [ixPrimary];

      with IndexDefs.AddIndexDef do begin
        Name 		:= FIndexDescs[i].Name;
        Fields 		:= FIndexDescs[i].Fields;		// list of fields separated by semi-colons
        DescFields 	:= FIndexDescs[i].DescFields;           // list of fields, which are to be in descending order
        Options 	:= Opts;
      end;
    end;

    CurIndex := GetCurrentIndex;
    if CurIndex >= 0 then begin
      SetLength(FIndexFieldMap, FIndexDescs[CurIndex].iFldsInKey);
      FIndexFieldCount := FIndexDescs[CurIndex].iFldsInKey;
      Flds := FIndexDescs[CurIndex].Fields;
      i := 1;
      iFld := 0;
      while i <= Length(Flds) do begin
        sFld := ExtractFieldName(Flds, i);
        if sFld = '' then
          Break;
        FIndexFieldMap[iFld] := FieldDefs.Find(sFld).FieldNo;
        Inc(iFld);
      end;
    end else if FFieldsIndex then begin
      Flds := IndexFieldNames;
      i := 1;
      iFld := 0;
      while i <= Length(Flds) do begin
        sFld := ExtractFieldName(Flds, i);
        if sFld = '' then
          Break;
        sFld := ExcludeAscDesc(sFld);
        if iFld > High(FIndexFieldMap) then
          SetLength( FIndexFieldMap, High(FIndexFieldMap) + DeltaFieldMap );
        FIndexFieldMap[iFld] := FieldDefs.Find(sFld).FieldNo;
        Inc(iFld);
      end;
        // set the actual array size
      SetLength( FIndexFieldMap, iFld );
      FIndexFieldCount := iFld;
    end;

  finally
    SetDSFlag(dsfIndexList, False);
  end;
end;

procedure TXSQLTable.ClearIndexDescs;
begin
  SetLength(FIndexDescs, 0);
end;

procedure TXSQLTable.UpdateIndexDescs;
  procedure AddIndexDesc(const AIdxName, AFlds, ADescFlds: string; AIdxType, AFldsInKey: Integer; var AIndexDescs: TIndexDescArray);
  var
    i: Integer;
  begin
    i := Low(AIndexDescs);
    	// if the index was added, then change (add) it's properties
    while i <= High(AIndexDescs) do begin
      if (AIndexDescs[i].Name = AIdxName) and
         ((AIndexDescs[i].Fields = AFlds) or (AIndexDescs[i].Fields = '') or (AFlds = ''))
      then begin
        // when constraint(primary) row does not contain fields
        if (AIndexDescs[i].Fields <> AFlds) and (AIndexDescs[i].Fields = '') then
          AIndexDescs[i].Fields := AFlds;
        if (AIdxType and UniqueIndexType) <> 0 then
          AIndexDescs[i].bUnique := True;
        if (AIdxType and PrimaryIndexType) <> 0 then
          AIndexDescs[i].bPrimary := True;
        Break;
      end;
      Inc(i);
    end;
    	// if index was not added
    if i > High(AIndexDescs) then begin
      i := High(AIndexDescs)+1; 	// High(FIndexDescs) returns -1, when the array is empty
      SetLength(AIndexDescs, i+1);
      AIndexDescs[i].Name := AIdxName;
      AIndexDescs[i].iFldsInKey := AFldsInKey;
      AIndexDescs[i].Fields := AFlds;		// list of fields separated by semi-colons
      AIndexDescs[i].DescFields := ADescFlds; // list of fields, which are to be in descending order
      AIndexDescs[i].bUnique := (AIdxType and UniqueIndexType) <> 0;
      AIndexDescs[i].bPrimary := (AIdxType and PrimaryIndexType) <> 0;
    end;
  end;

var
  cmd: TISqlCommand;
  IdxName, IdxName2, Fld, Flds, DescFlds, SortType: string;
  IdxType, IdxType2, FldsInKey: Integer;
  IdxDescs: TIndexDescArray;
  FldDesc: TSDFieldDesc;
  bIdxType: Boolean;
  fVal: Double;
  i64: TInt64;
begin
  cmd := nil;
  ClearIndexDescs;
  SetLength(IdxDescs, 0);
  SetDSFlag(dsfIndexList, True);
  try
    IdxName := '';
    IdxType := 0;
    FldsInKey := 0;
    Flds := '';
    DescFlds := '';
    cmd := Database.SqlDatabase.GetSchemaInfo(stIndexes, TableName);
    ASSERT( cmd <> nil, 'GetSchemaInfo(stIndexes, TableName) returns nil');
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(cmd.FieldDescs.FieldDescByName(IDX_NAME_FIELD).FieldNo, IdxName2);
      FldDesc := cmd.FieldDescs.FieldDescByName(IDX_TYPE_FIELD);
      if FldDesc.FieldType in [ftFloat, ftCurrency] then begin
        bIdxType := cmd.GetFieldAsFloat(FldDesc.FieldNo, fVal);
        IdxType2 := Trunc( fVal );
{$IFDEF XSQL_VCL4}
      end else if FldDesc.FieldType in [ftLargeInt] then begin
        i64 := 0;
        bIdxType := cmd.GetFieldAsInt64(FldDesc.FieldNo, i64);
        IdxType2 := i64;
{$ENDIF}
      end else
        bIdxType := cmd.GetFieldAsInt32(FldDesc.FieldNo, IdxType2);
        // if index type value is null, it is not valid row (SQL_TABLE_STAT for ODBC)
      if (Database.ServerType = stODBC) and not bIdxType then
        Continue;
      cmd.GetFieldAsString(cmd.FieldDescs.FieldDescByName(IDX_COL_NAME_FIELD).FieldNo, Fld);
      cmd.GetFieldAsString(cmd.FieldDescs.FieldDescByName(IDX_SORT_FIELD).FieldNo, SortType);
      Fld := Trim(Fld);
      SortType := Trim(SortType);
    	// in some cases a primary key and it's (supplied) index are considered as different indexes with same name and different index types
      if (IdxName = '') or ((IdxName = IdxName2) and (IdxType = IdxType2)) then begin
        if IdxName = '' then begin
          IdxName := IdxName2;
          IdxType := IdxType2;
        end;
        	// add a field in a list of fields
        if Flds <> '' then Flds := Flds + ';';
        Flds := Flds + Fld;
        if SortType = DescSortOrder then begin
          if DescFlds <> '' then DescFlds := DescFlds + ';';
          DescFlds := DescFlds + Fld;
        end;
        Inc(FldsInKey);
      end else begin
        AddIndexDesc(IdxName, Flds, DescFlds, IdxType, FldsInKey, IdxDescs);

        IdxName := IdxName2;
        IdxType := IdxType2;
        Flds := Fld;
        if SortType = DescSortOrder then
          DescFlds := Fld;
        FldsInKey := 1;
      end;
    end;
    	// add the last index info
    if IdxName <> '' then
      AddIndexDesc(IdxName, Flds, DescFlds, IdxType, FldsInKey, IdxDescs);
    cmd.CloseResultSet;

    FIndexDescs := IdxDescs;
  finally
    if Assigned(cmd) then cmd.Free;
    SetDSFlag(dsfIndexList, False);
  end;
end;

{ Returns position of the current index in FIndexDescs array }
function TXSQLTable.GetCurrentIndex: Integer;
var
  i: Integer;
begin
  Result := -1;
  for i:=Low(FIndexDescs) to High(FIndexDescs) do begin
    if ((IndexFieldNames <> '') and (FIndexDescs[i].Fields = IndexFieldNames)) or
       ((IndexName <> '') and (FIndexDescs[i].Name = IndexName))
    then begin
      Result := i;
      Break;
    end;
  end;
end;

function TXSQLTable.GetFieldListWithDesc(const AFields, ADescFields: string): string;
var
  i, j, s: Integer;
  Fld: string;
begin
  i := 1;
  Result := AFields;
  	// add DESC clause for descending fields
  if ADescFields <> '' then
    while i <= Length(Result) do begin
      s := i;
      Fld := ExtractFieldName(Result , i);
      j:= Pos(Fld, ADescFields);
      if j > 0 then begin
        InsertSubstr(' desc', Result, s + Length(Fld));
        i := i + Length(' desc');
      end;
    end;
end;

function TXSQLTable.ReplaceSemicolon2Comma(const AStr: string): string;
var
  i: Integer;
begin
  Result := AStr;
  for i:=1 to Length(Result) do
    if Result[i] = ';' then Result[i] := ',';
end;

function TXSQLTable.GenOrderBy: string;
var
  CurIndex, i, StartPos: Integer;
  s, sWord: string;
begin
  Result := '';
  s := '';
  CurIndex := GetCurrentIndex;
  if CurIndex >= 0 then begin
    s := GetFieldListWithDesc(FIndexDescs[CurIndex].Fields, FIndexDescs[CurIndex].DescFields);
  end else
    s := IndexFieldNames;

  s := ReplaceSemicolon2Comma(s);
  if FQuoteIdent then begin
    i := 1;
    while i <= Length(s) do begin
      StartPos := i;
      while (i <= Length(s)) and not IsNameDelimiter( s[i] ) do
        Inc(i);
      sWord := UpperCase(Trim(Copy(s, StartPos, i - StartPos)));
      if (Length(sWord) > 0) and (sWord <> 'ASC') and (sWord <> 'DESC') then begin
        InsertSubstr('"', s, StartPos);
        InsertSubstr('"', s, i+1);
        i := i + 2;
      end;
      Inc(i);
    end;
  end;
  Result := s;
end;

procedure TXSQLTable.SwitchToIndex;
begin
  FOrderByFields := GenOrderBy;
end;

{ Different supported datatypes (map) and syntaxes(create/alter) could be implemented
through ini-file, TXSQLDatabase.Params or TISqlDatabase.SqlDataTypeName method.

Note. Oracle automatically creates an index to enforce a UNIQUE or PRIMARY KEY integrity constraint. (Oracle Application Developer's Guide)}
procedure TXSQLTable.CreateTable;
const
  DT_ParamMarker = '?';
  { Converting from TFieldType to Program Data Type(Oracle) }
  SqlDataTypeNameMap: array[TFieldType] of string = ( '',	// ftUnknown
	// ftString, ftSmallint, ftInteger, 	ftWord, 	ftBoolean
	'VARCHAR(?)',	'SMALLINT', 'INTEGER', 'SMALLINT', 'BOOLEAN',
	// ftFloat, 	ftCurrency, 	ftBCD, ftDate, ftTime
        'FLOAT',	'FLOAT',	'DECIMAL(?,?)', 'DATE', 'DATETIME',
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        'DATETIME', 	'', 	'', 		'', 	'LONG',
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        'LONG',		'',	'',		'',	'',
        // ftTypedBinary, ftCursor
        '',		''
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        '',	'',	'',
        // ftADT, ftArray, ftReference, ftDataSet
        '',	'',	'',	''
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        'BLOB', 'CLOB', '',
        // ftInterface, ftIDispatch, ftGuid
        '',	'',	''
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        'TIMESTAMP',      ''
{$ENDIF}
{$IFDEF XSQL_VCL10},
        '',      '',      '',      ''
{$ENDIF}
        );

  function GetCreateTableStmt: string;
  var
    i, k: Integer;
    sFld, sFlds, sFldType: string;
  begin
    Result := '';
    sFlds := '';
    for i:=0 to FieldDefs.Count-1 do begin
      sFldType := SqlDataTypeNameMap[FieldDefs[i].DataType];
      k := Pos(DT_ParamMarker, sFldType);
      if k > 0 then begin
        if FieldDefs[i].DataType = ftBCD then begin
          DeleteSubstr( sFldType, k, Length(DT_ParamMarker) );
          InsertSubstr( IntToStr(FieldDefs[i].Precision), sFldType, k );
          k := Pos(DT_ParamMarker, sFldType);
          if k > 0 then begin
            DeleteSubstr( sFldType, k, Length(DT_ParamMarker) );
            InsertSubstr( IntToStr(FieldDefs[i].Size), sFldType, k );
          end;
        end else begin	// ftString
          DeleteSubstr( sFldType, k, Length(DT_ParamMarker) );
          InsertSubstr( IntToStr(FieldDefs[i].Size), sFldType, k );
        end;
      end;
      sFld := FieldDefs[i].Name + ' ' + sFldType;
      if FieldDefs[i].Required then
        sFld := sFld + ' NOT NULL';
      if sFlds <> '' then sFlds := sFlds + ', ';
      sFlds := sFlds + sFld;
    end;

    Result := Format('create table %s(%s)', [FTableName, sFlds]);
  end;
  function GetCreatePrimaryKeyStmt(AIndexDef: TIndexDef): string;
  begin
    Result := '';
    if ixPrimary in AIndexDef.Options then begin
      Result := GetFieldListWithDesc(AIndexDef.Fields, AIndexDef.DescFields);
      Result := Format('alter table %s add PRIMARY KEY(%s)', [TableName, ReplaceSemicolon2Comma(Result)]);
    end;
  end;
  function GetCreateIndexStmt(AIndexDef: TIndexDef): string;
  var
    sUnique, sFlds: string;
  begin
    if ixPrimary in AIndexDef.Options
    then sUnique := 'UNIQUE'
    else sUnique := '';
    sFlds := ReplaceSemicolon2Comma( GetFieldListWithDesc(AIndexDef.Fields, AIndexDef.DescFields) );
    Result := Format('create %s index %s on table %s(%s)', [sUnique, AIndexDef.Name, TableName, sFlds]);
  end;
var
  cmd: TISqlCommand;
  sStmt: string;
  i: Integer;
begin
  CheckInactive;
  SetDSFlag(dsfTable, True);
  cmd := nil;
  try
    InitFieldDefsFromFields;

    cmd := inherited ISqlCmdCreate;
    cmd.CommandType := ctQuery;

    sStmt := GetCreateTableStmt;

    cmd.Prepare( sStmt );
    cmd.Execute;

    for i:=0 to IndexDefs.Count-1 do begin
      if ixPrimary in IndexDefs[i].Options then begin
        sStmt := GetCreatePrimaryKeyStmt(IndexDefs[i]);
        if sStmt <> '' then begin
          cmd.Prepare( sStmt );
          cmd.Execute;
        end;
      end;
      sStmt := GetCreateIndexStmt(IndexDefs[i]);
      if sStmt <> '' then begin
        cmd.Prepare( sStmt );
        cmd.Execute;
      end;
    end;

  finally
    if Assigned(cmd) then
      cmd.Free;
    SetDSFlag(dsfTable, False);
  end;
end;

function TXSQLTable.GetExists: Boolean;
var
  List: TStrings;
begin
  List := nil;
  Result := Active;
  if Result or (TableName = '') then
    Exit;
  SetDSFlag(dsfTable, True);
  try
    List := TStringList.Create;
    Database.GetFieldNames(TableName, List);
    Result := List.Count > 0;
  finally
    SetDSFlag(dsfTable, False);
    if Assigned(List) then List.Free;
  end;
end;

procedure TXSQLTable.DeleteTable;
begin
  CheckInactive;
  SetDSFlag(dsfTable, True);
  try
    ISqlDeleteTable;
  finally
    SetDSFlag(dsfTable, False);
  end;
end;

procedure TXSQLTable.EmptyTable;
begin
  if Active then begin
    CheckBrowseMode;
    ISqlEmptyTable;
    ClearBuffers;
    DataEvent(deDataSetChange, {$IFDEF XSQL_CLR} nil {$ELSE} 0 {$ENDIF});
  end else begin
    SetDSFlag(dsfTable, True);
    try
      ISqlEmptyTable;
    finally
      SetDSFlag(dsfTable, False);
    end;
  end;
end;

function TXSQLTable.GetCanModify: Boolean;
begin
  Result := not ReadOnly;
end;

function TXSQLTable.GetSQLText: string;
var
  s: string;
begin
  s := '';
  if FOrderByFields <> '' then
    s := ' order by '+ FOrderByFields;
  Result := 'select * from '+ QuoteIdentifier(FTableName, FQuoteIdent) + FWhereText + s;
end;

{ Creates and prepares command handle (FSqlCmd) }
procedure TXSQLTable.CreateHandle;
begin
  if FTableName = '' then DatabaseError(SNoTableName{$IFDEF XSQL_VCL4}, Self{$ENDIF});
  IndexDefs.Updated := False;

  FSqlCmd := ISqlCmdCreate;
  if not Assigned(FIndexDescs) then
    UpdateIndexDescs;

  FQuoteIdent := Assigned(Database) and (UpperCase( Trim( Database.Params.Values[szQUOTE_IDENT] ) ) = STrueString);

  SwitchToIndex;
  CheckMasterRange;
  
  ISqlPrepare( GetSQLText );
end;

procedure TXSQLTable.ExecuteCursor;
begin
  SetConnectionState( True );
  try
    ISqlExecute;
  finally
    SetConnectionState( False );
  end;
end;

procedure TXSQLTable.InternalOpen;
begin
  if FMasterLink.DataSource <> nil then
    SetParamsFromMasterDataSet;
  UpdateIndexDefs;

  inherited;
end;

procedure TXSQLTable.InternalClose;
begin
  inherited;

  FIndexFieldCount := 0;
  SetLength(FIndexFieldMap, 0);
end;

procedure TXSQLTable.InternalDelete;
var
  SaveUpdateMode: TUpdateMode;
  CurrentIndex: Integer;
begin
  CheckCanModify;
  SaveUpdateMode := UpdateMode;
  CurrentIndex := GetCurrentIndex;
  if CurrentIndex >= 0 then
    UpdateMode := upWhereKeyOnly;
  try
    LiveInternalPost(True, GetSQLText, FTableName);
  finally
    if CurrentIndex >= 0 then
      FUpdateMode := SaveUpdateMode;
  end;
end;

procedure TXSQLTable.InternalPost;
var
  CurrentIndex: Integer;
  SaveUpdateMode: TUpdateMode;
begin
  inherited;

  SaveUpdateMode := UpdateMode;
  CurrentIndex := GetCurrentIndex;
  if CurrentIndex >= 0 then
    UpdateMode := upWhereKeyOnly;
  try
    LiveInternalPost(False, GetSQLText, FTableName);
  finally
    if CurrentIndex >= 0 then
      FUpdateMode := SaveUpdateMode;
  end;
end;

procedure TXSQLTable.DataEvent(Event: TDataEvent; Info: {$IFDEF XSQL_CLR} TObject {$ELSE} Longint {$ENDIF});
begin
  inherited DataEvent(Event, Info);

  if Event = dePropertyChange then begin
    ClearIndexDescs;
    IndexDefs.Updated := False;
  end;
end;

{ Master / Detail }

procedure TXSQLTable.CheckMasterRange;
begin
  if FMasterLink.Active and (FMasterLink.Fields.Count > 0) then begin
    SetLinkRanges(FMasterLink.Fields);
//    SetCursorRange;
  end;
end;

procedure TXSQLTable.MasterChanged(Sender: TObject);
begin
  CheckBrowseMode;
  UpdateRange;
  ApplyRange;
end;

procedure TXSQLTable.MasterDisabled(Sender: TObject);
begin
  CancelRange;
end;

function TXSQLTable.GetDataSource: TDataSource;
begin
  Result := FMasterLink.DataSource;
end;

procedure TXSQLTable.SetDataSource(Value: TDataSource);
begin
  if IsLinkedTo(Value) then DatabaseError(SCircularDataLink, Self);
  FMasterLink.DataSource := Value;
end;

function TXSQLTable.GetMasterFields: string;
begin
  Result := FMasterLink.FieldNames;
end;

procedure TXSQLTable.SetMasterFields(const Value: string);
begin
  FMasterLink.FieldNames := Value;
end;

procedure TXSQLTable.DoOnNewRecord;
var
  i: Integer;
begin
  if FMasterLink.Active and (FMasterLink.Fields.Count > 0) then
    for i := 0 to FMasterLink.Fields.Count - 1 do
      IndexFields[i] := TField(FMasterLink.Fields[i]);
      
  inherited DoOnNewRecord;
end;

procedure TXSQLTable.ApplyRange;
begin
  CheckBrowseMode;
//  if SetCursorRange then First;
end;

procedure TXSQLTable.CancelRange;
begin
  CheckBrowseMode;
  UpdateCursorPos;
//  if ResetCursorRange then Resync([]);
end;

procedure TXSQLTable.UpdateRange;
begin
  SetLinkRanges(FMasterLink.Fields);
end;

procedure TXSQLTable.SetLinkRanges(MasterFields: TList);
var
  Field: TField;
  Param: TSDHelperParam;
  i, iFld: Integer;
  sDetailFields, sFldName, sParamName, sWhere: string;
begin
  FWhereText := '';
  sWhere := '';
  FParams.Clear;
        // construct WHERE clause for a detail statement
  sDetailFields := Self.MasterFields;
  i := 1;
  iFld := 0;
  while i <= Length(sDetailFields) do begin
    sFldName := ExtractFieldName(sDetailFields, i);
    if iFld >= MasterFields.Count then
      DatabaseErrorFmt(SFatalError, ['TXSQLTable.SetLinkRanges: many fields in MasterFields property.']);
    Field := TField( MasterFields[iFld] );
    sParamName := Field.FieldName;
    	// add an item in WHERE
    if sWhere <> '' then
      sWhere := sWhere + ' and ';
    sWhere := sWhere + QuoteIdentifier(sFldName, FQuoteIdent) + ' = :' + sParamName;
	// create parameters
{$IFDEF XSQL_VCL4}
    Param := TSDHelperParam(FParams.Add);
    Param.Name := sParamName;
    Param.DataType := Field.DataType;
    Param.ParamType := ptInput;
{$ELSE}
    FParams.CreateParam(Field.DataType, sParamName, ptInput);
{$ENDIF}
    Inc(iFld);
  end;

  if Trim(sWhere) <> '' then
    FWhereText := ' WHERE ' + sWhere;

	// execute a statement with new parameters
  if Active then
    RefreshParams;
end;

procedure TXSQLTable.RefreshParams;
var
  DataSet: TDataSet;
  i: Integer;
  IsValueEqual: Boolean; // whether parameter and the corresponded field values are equal
begin
  DisableControls;
  try
    if FMasterLink.DataSource <> nil then begin
    	// get a master dataset
      DataSet := FMasterLink.DataSource.DataSet;
      if DataSet <> nil then
        if DataSet.Active and (DataSet.State <> dsSetKey) then begin
          IsValueEqual := not UniDirectional;
          for i := 0 to FParams.Count - 1 do begin
            if not IsValueEqual then
              Break;
            IsValueEqual := IsValueEqual and CompareParamValue( FParams[I], DataSet.FindField(FParams[I].Name) );
          end;
          	// if field values were changed or the dataset is unidirectional (else it is impossible to go to the first record)
          if not IsValueEqual then begin
            Close;
            Open;
          end;
        end;
    end;
  finally
    EnableControls;
  end;
end;

procedure TXSQLTable.SetParamsFromMasterDataSet;
var
  i: Integer;
begin
  if not Assigned(MasterSource) or not Assigned(MasterSource.DataSet) then
    Exit;

  for i := 0 to FParams.Count - 1 do
    if not FParams[i].Bound then begin
      FParams[i].AssignField(MasterSource.DataSet.FieldByName(FParams[i].Name));
      FParams[i].Bound := False;
    end;
end;

{-------------------------------------------------------------------------------
			SQL server C/API Functions
-------------------------------------------------------------------------------}
function TXSQLTable.ISqlCmdCreate: TISqlCommand;
begin
  Result := inherited ISqlCmdCreate;
  Result.CommandType := ctQuery;
  Result.Params := FParams;
  Result.OnReleaseHandle := Self.ReleaseHandle;
end;

procedure TXSQLTable.ISqlDeleteTable;
var
  cmd: TISqlCommand;
begin
  cmd := inherited ISqlCmdCreate;
  try
    cmd.CommandType := ctQuery;
    cmd.Prepare( 'drop table '+TableName );
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

procedure TXSQLTable.ISqlEmptyTable;
var
  cmd: TISqlCommand;
begin
  cmd := inherited ISqlCmdCreate;
  try
    cmd.CommandType := ctQuery;
    cmd.Prepare( 'delete from '+TableName );
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;
{$ENDIF}     // implementation of TXSQLTable

{ TXSQLScript }

constructor TXSQLScript.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSQL := TStringList.Create;
  FSQLPattern := TStringList.Create;
  TStringList(FSQLPattern).OnChange := PatternChanged;
  FParams := TSDHelperParams.Create(Self);
  FMacros := TSDHelperParams.Create(Self);
  FQuery := TXSQLQuery.Create(Self);
  FParamCheck := True;
  FMacroChar := DefaultQueryMacroChar;
  FMacroCheck:= True;          // check wether or not macros are present
  FTermChar := DefaultScriptTermChar;
end;

destructor TXSQLScript.Destroy;
begin
  FQuery.Free;
  FSQLPattern.Free;
  FSQL.Free;
  FParams.Free;
  FMacros.Free;
  inherited Destroy;
end;

function TXSQLScript.GetDatabase: TXSQLDatabase;
begin
  Result := FQuery.Database;
end;

function TXSQLScript.GetDatabaseName: string;
begin
  Result := FQuery.DatabaseName;
end;

procedure TXSQLScript.SetDatabaseName(const Value: string);
begin
  FQuery.DatabaseName := Value;
end;

function TXSQLScript.GetSessionName: string;
begin
  Result := FQuery.SessionName;
end;

procedure TXSQLScript.SetSessionName(const Value: string);
begin
  FQuery.SessionName := Value;
end;

function TXSQLScript.GetDBSession: TXSQLSession;
begin
  Result := FQuery.DBSession;
end;

function TXSQLScript.GetMacroCount: Word;
begin
  Result := FMacros.Count;
end;

function TXSQLScript.GetMacros: TSDHelperParams;
begin
  Result := FMacros;
end;

function TXSQLScript.MacroByName(const MacroName: string): TSDHelperParam;
begin
  Result := FMacros.ParamByName(MacroName);
end;

procedure TXSQLScript.SetMacroChar(const Value: Char);
begin
  if Value <> FMacroChar then begin
    FMacroChar := Value;
    CreateMacros;
  end;
end;

procedure TXSQLScript.SetMacros(const Value: TSDHelperParams);
begin
  FMacros.AssignValues(Value);
end;

function TXSQLScript.GetText: string;
begin
  Result := FSQL.Text;
end;

function TXSQLScript.GetParamsCount: Integer;
begin
  Result := FParams.Count;
end;

procedure TXSQLScript.SetParamsList(const Value: TSDHelperParams);
begin
  FParams.AssignValues(Value);
end;

procedure TXSQLScript.SetQuery(const Value: TStrings);
begin
  TStringList(FSQLPattern).OnChange := nil;
  FSQLPattern.Assign(Value);
  PatternChanged(nil);
  TStringList(FSQLPattern).OnChange := PatternChanged;
end;

procedure TXSQLScript.PatternChanged(Sender: TObject);
var
  List: TSDHelperParams;
begin
  if not (csReading in ComponentState) then begin
    if ParamCheck or (csDesigning in ComponentState) then begin
      List := TSDHelperParams.Create(Self);
      try
        CreateParamsFromSQL(List, FSQLPattern.Text, DefaultParamPrefix);
      	// assign the current parameter values
        List.AssignValues(FParams);
        FParams.Clear;
        FParams.Assign(List);
      finally
        List.Free;
      end;
    end;
  end else
    CreateParamsFromSQL(nil, FSQLPattern.Text, DefaultParamPrefix);

  CreateMacros;
  ExpandMacros;
end;

function TXSQLScript.ParamByName(const Value: string): TSDHelperParam;
begin
  Result := FParams.ParamByName(Value);
end;

{ execute all statements }
procedure TXSQLScript.ExecSQL;
begin
  ExpandMacros;
  if FSQL.Count = 0 then DatabaseError(SEmptySQLStatement);
  FQuery.SetDSFlag(dsfExecProc, True);
  try
    if not Database.Connected then DatabaseError(SDatabaseClosed);
    if Assigned(FBeforeExecute) then FBeforeExecute(Self);
    ExecuteScript(-1);
    if Assigned(FAfterExecute) then FAfterExecute(Self);
  finally
    FQuery.SetDSFlag(dsfExecProc, False);
  end;
end;

procedure TXSQLScript.ExecuteScript(StatementNo: Integer);
var
  IsTrans, IsStmtFound: Boolean;
  CurStatNo, i, iTerm: Integer;
  s, sEnd: string;
begin
  IsTrans := FTransaction and not Database.InTransaction and (StatementNo < 0);
  try
    if IsTrans then
      Database.StartTransaction;
  except
    IsTrans := False;
  end;

  try
    CurStatNo := 0;
    IsStmtFound := False;
    sEnd := '';
    i := 0;
    FQuery.ParamCheck := ParamCheck;
    while (i < FSQL.Count) or (sEnd <> '') do begin
      FQuery.SQL.BeginUpdate;
      try
        FQuery.SQL.Clear;

        // locate one statement from a script
        while (i < FSQL.Count) or (sEnd <> '') do begin
		// the end of previous string after a terminator - this's begin of the following statement
          if sEnd <> '' then begin
            FQuery.SQL.Add(sEnd);	// at general, sEnd can contain some SQLs, which are separated by TermChar (it isn't implemented ???)
            sEnd := '';
          end;
          if i >= FSQL.Count then
            Break;
          s := Trim( FSQL[i] );
          Inc(i);
                // whether a TermChar exists at the end of string
          iTerm := Length(S);
          while (iTerm > 0) and (S[iTerm] <> FTermChar) and (AnsiChar(S[iTerm]) in [LFChar, CRChar, SPChar]) do
            Dec(iTerm);
         	// if a terminator is found
          if (iTerm > 0) and (S[iTerm] = FTermChar) then begin
            FQuery.SQL.Add( Copy(s, 1, iTerm-1) );
            sEnd := Trim( Copy(s, iTerm+1, Length(s) - iTerm) );
            Break;
          end else
            FQuery.SQL.Add( s );
        end;
      finally
        FQuery.SQL.EndUpdate;
      end;

      if FQuery.SQL.Count > 0 then begin
        if (StatementNo < 0) or (StatementNo = CurStatNo) then begin
          IsStmtFound := True;
          CheckExecQuery(I - 1, CurStatNo);
          if StatementNo = CurStatNo then
            Break;
        end;
        Inc(CurStatNo);
      end;
    end;

    if not IsStmtFound then
      DatabaseErrorFmt(SListIndexError, [-1{StatementNo}]);

    if IsTrans then Database.Commit;
  except
    if IsTrans then Database.Rollback;
    raise;
  end;
end;

procedure TXSQLScript.CheckExecQuery(LineNo, StatementNo: Integer);
var
  i: Integer;
  Param: TSDHelperParam;
{$IFNDEF XSQL_CLR}
  NewErr: EDatabaseError;
{$ENDIF}
begin
  try
    if not IgnoreParams then
      for i := 0 to FQuery.Params.Count - 1 do begin
        Param := FQuery.Params[I];
        Param.Assign(Params.ParamByName(Param.Name));
      end;
    FQuery.ExecSQL;
  except
{$IFNDEF XSQL_CLR}
        // add an event handler to replace below code
    on E: EDatabaseError do begin
      NewErr := EDatabaseError( E.NewInstance );
      NewErr.Message := E.Message + '('+ Format(SParseError, [SMsgDlgError, LineNo]) +')';
      raise NewErr;     // 'raise E' produces AV (tested with D5-D7) by some reason, because a new exception object is created
    end else
{$ENDIF}
      raise;
  end;
end;

{ parses a statement for macros and fills FMacros list }
procedure TXSQLScript.CreateMacros;
var
  List: TSDHelperParams;
  i: Integer;
begin
  if not FMacroCheck then
    Exit;
  if not (csReading in ComponentState) then begin
    List := TSDHelperParams.Create(Self);
    try
      CreateParamsFromSQL(List, FSQLPattern.Text, FMacroChar);
	// assign the current parameter values
      List.AssignValues(FMacros);
      	// Do not change old FMacros[i].Value, else set FMacros[i].DataType to ftString and a default value,
      for i:=0 to List.Count-1 do
        if List[i].DataType = ftUnknown then
          List[i].AsString := DefaultQueryMacroExpr;

      FMacros.Clear;
      FMacros.Assign(List);
    finally
      List.Free;
    end;
  end else begin
    FMacros.Clear;
    CreateParamsFromSQL(FMacros, Text, FMacroChar);
  end;
end;

{ Expands macros and assign a real SQL text }
procedure TXSQLScript.ExpandMacros;
var
  i: Integer;
  s: string;
begin
  s := FSQLPattern.Text;
  for i:=0 to MacroCount-1 do begin
    if Macros[i].DataType = ftUnknown then
      Continue;
    ReplaceString(False, MacroChar + Macros[i].Name, Macros[i].AsString, s);
  end;
  FSQL.Text := s;
end;

{$IFDEF XSQL_VCL4}
procedure TXSQLScript.DefineProperties(Filer: TFiler);

  function HasMacroData: Boolean;
  begin
    if Filer.Ancestor <> nil
    then Result := not FMacros.IsEqual(TXSQLScript(Filer.Ancestor).FMacros)
    else Result := FMacros.Count > 0;
  end;
  function HasParamData: Boolean;
  begin
    if Filer.Ancestor <> nil
    then Result := not FParams.IsEqual(TXSQLScript(Filer.Ancestor).FParams)
    else Result := FParams.Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('MacroData', ReadMacroData, WriteMacroData, HasMacroData);
  Filer.DefineProperty('ParamData', ReadParamData, WriteParamData, HasParamData);
end;

procedure TXSQLScript.ReadMacroData(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FMacros);
end;

procedure TXSQLScript.WriteMacroData(Writer: TWriter);
begin
  Writer.WriteCollection(Macros);
end;

procedure TXSQLScript.ReadParamData(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FParams);
end;

procedure TXSQLScript.WriteParamData(Writer: TWriter);
begin
  Writer.WriteCollection(Params);
end;
{$ENDIF}


procedure InitSqlVar;
var
  i: TSDServerType;
begin
  for i:=Low(TSDServerType) to High(TSDServerType) do
    InitSqlDatabaseProcs[i] := nil;

{$IFDEF stSQLBase}      InitSqlDatabaseProcs[stSQLBase]	   := XSCsb.InitSqlDatabase;{$ENDIF}
{$IFDEF stOracle}       InitSqlDatabaseProcs[stOracle]	   := XSOra.InitSqlDatabase;{$ENDIF}
{$IFDEF stSQLServer}    InitSqlDatabaseProcs[stSQLServer]  := XSMss.InitSqlDatabase;{$ENDIF}
{$IFDEF stSybase}       InitSqlDatabaseProcs[stSybase] 	   := XSSyb.InitSqlDatabase;{$ENDIF}
{$IFDEF stDB2}          InitSqlDatabaseProcs[stDB2]	   := XSDb2.InitSqlDatabase;{$ENDIF}
{$IFDEF stInformix}     InitSqlDatabaseProcs[stInformix]   := XSInf.InitSqlDatabase;{$ENDIF}
{$IFDEF stODBC}         InitSqlDatabaseProcs[stODBC]	   := XSOdbc.InitSqlDatabase;{$ENDIF}
{$IFDEF stInterbase}    InitSqlDatabaseProcs[stInterbase]  := XSInt.InitSqlDatabase;{$ENDIF}
{$IFDEF stFirebird}     InitSqlDatabaseProcs[stFirebird]   := XSFib.InitSqlDatabase;{$ENDIF}
{$IFDEF stMySQL}        InitSqlDatabaseProcs[stMySql]      := XSMySql.InitSqlDatabase;{$ENDIF}
{$IFDEF stPostgreSQL}   InitSqlDatabaseProcs[stPostgreSQL] := XSPgSql.InitSqlDatabase;{$ENDIF}
{$IFDEF stOLEDB}        InitSqlDatabaseProcs[stOLEDB]      := XSOleDb.InitSqlDatabase;{$ENDIF}

end;


initialization
  DefDatabase := nil;
  BusyCount := 0;
  InitSqlVar;
  Sessions := TXSQLSessionList.Create;
  Session := TXSQLSession.Create(nil);
  Session.SessionName := 'Default';
finalization
  Sessions.Free;
  Sessions := nil;
end.




