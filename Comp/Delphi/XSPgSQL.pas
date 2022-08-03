{$I XSqlDir.inc}
unit XSPgSQL {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, Registry, SyncObjs,
{$IFDEF XSQL_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  XSConsts, XSCommon;


{*******************************************************************************
*	pg_type.h - The OIDs of the built-in datatypes are defined in          *
*			system table pg_type and                               *
* 			src/include/catalog/pg_type.h in the source tree.      *
*******************************************************************************}

const
  BOOLOID    	= 16;
  BYTEAOID   	= 17;
  CHAROID    	= 18;
  NAMEOID    	= 19;
  INT8OID    	= 20;
  INT2OID    	= 21;
  INT2VECTOROID	= 22;
  INT4OID    	= 23;
  REGPROCOID 	= 24;
  TEXTOID    	= 25;
  OIDOID     	= 26;
  TIDOID     	= 27;
  XIDOID 	= 28;
  CIDOID 	= 29;
  OIDVECTOROID	= 30;
  POINTOID   	= 600;
  LSEGOID    	= 601;
  PATHOID    	= 602;
  BOXOID     	= 603;
  POLYGONOID 	= 604;
  LINEOID    	= 628;
  FLOAT4OID	= 700;
  FLOAT8OID	= 701;
  ABSTIMEOID	= 702;
  RELTIMEOID	= 703;
  TINTERVALOID	= 704;
  UNKNOWNOID  	= 705;
  CIRCLEOID   	= 718;
  CASHOID 	= 790;
  INETOID 	= 869;
  CIDROID 	= 650;
  ACLITEMSIZE	= 8;
  BPCHAROID  	= 1042;
  VARCHAROID 	= 1043;
  DATEOID    	= 1082;
  TIMEOID    	= 1083;
  TIMESTAMPOID	= 1184;
  INTERVALOID 	= 1186;
  TIMETZOID   	= 1266;
  ZPBITOID    	= 1560;
  VARBITOID   	= 1562;
  NUMERICOID  	= 1700;
	// for PostgreSQL v.7.2
  TIMESTAMPOID_v72= 1114;

{*******************************************************************************
*	postgres_ext.h - This file is only for fundamental Postgres declarations *
*******************************************************************************}

{*
 * Object ID is a fundamental type in Postgres.
 *}
type
  Oid	= Cardinal;	// object id

const
  InvalidOid	= 0;

{*
 * NAMEDATALEN is the max length for system identifiers (e.g. table names,
 * attribute names, function names, etc.)
 *
 * NOTE that databases with different NAMEDATALEN's cannot interoperate!
 *}
  NAMEDATALEN 	= 32;

{*******************************************************************************
*	libpq-fe.h - Common definition used by frontend postgres applications  ********************************************************************************}

const
  {	Application-visible enum types	}
	// enum ConnStatusType
  CONNECTION_OK 	= 0;
  CONNECTION_BAD	= 1;
  // Non-blocking mode only below here
  CONNECTION_STARTED	= 2;		// Waiting for connection to be made
  CONNECTION_MADE 	= 3;		// Connection OK; waiting to send
  CONNECTION_AWAITING_RESPONSE	= 4;	// Waiting for a response from the postmaster
  CONNECTION_AUTH_OK	= 5;		// Received authentication; waiting for backend startup
  CONNECTION_SETENV	= 6;		// Negotiating environment

	// enum PostgresPollingStatusType
  PGRES_POLLING_FAILED	= 0;
  PGRES_POLLING_READING	= 1;		// These two indicate that one may
  PGRES_POLLING_WRITING	= 2;		// use select before polling again
  PGRES_POLLING_OK	= 3;
  PGRES_POLLING_ACTIVE	= 4;		// Can call poll function immediately

	// enum ExecStatusType
  PGRES_EMPTY_QUERY	= 0;
  PGRES_COMMAND_OK	= 1;		// a query command that doesn't return anything was executed properly by the backend
  PGRES_TUPLES_OK	= 2;		// a query command that returns tuples was executed properly by the backend, PGresult contains the result tuples
  PGRES_COPY_OUT	= 3;		// Copy Out data transfer in progress
  PGRES_COPY_IN		= 4;		// Copy In data transfer in progress
  PGRES_BAD_RESPONSE	= 5;		// an unexpected response was recv'd from the backend
  PGRES_NONFATAL_ERROR	= 6;
  PGRES_FATAL_ERROR	= 7;

type
  TVoid = TSDPtr;

{* PGconn encapsulates a connection to the backend.
 * The contents of this struct are not supposed to be known to applications.
 *}
  PPGconn = TVoid;

  TConnStatusType 		= Integer;	// enum
  TPostgresPollingStatusType	= Integer;	// enum
  TExecStatusType		= Integer;	// enum
  PSSL				= TVoid;
    
{* PGresult encapsulates the result of a query (or more precisely, of a single
 * SQL command --- a query string given to PQsendQuery can contain multiple
 * commands and thus return multiple PGresult objects).
 * The contents of this struct are not supposed to be known to applications.
 *}
  PPGresult = TVoid;

{* PGnotify represents the occurrence of a NOTIFY message.
 * Ideally this would be an opaque typedef, but it's so simple that it's
 * unlikely to change.
 * NOTE: in Postgres 6.4 and later, the be_pid is the notifying backend's,
 * whereas in earlier versions it was always your own backend's PID.
 *}
  TPGnotify	= record
    szRelName: array[0..NAMEDATALEN] of Char;	// name of relation containing data
    be_pid: Integer;				// process id of backend
  end;

{* PQnoticeProcessor is the function type for the notice-message callback.
 *}
  TPQnoticeProcessor	= procedure (arg: Pointer; szMessage: TSDCharPtr); cdecl;

	{ Print options for PQprint() }
  TPQBool	= Char;

  TPQprintOpt	= record
    header,				// print output field headings and row count
    align,				// fill align the fields
    standard,				// old brain dead format
    html3,				// output html tables
    expanded,				// expand tables
    pager:	TPQBool;		// use pager for output if needed
    fieldSep,				// field separator
    tableOpt,				// insert to HTML <table ...>
    caption:	TSDCharPtr;			// HTML <caption>
    fieldName:	array[0..0] of TSDCharPtr;	// null terminated array of repalcement field names
  end;


{* ----------------
 * Structure for the conninfo parameter definitions returned by PQconndefaults
 *
 * All fields except "val" point at static strings which must not be altered.
 * "val" is either NULL or a malloc'd current-value string.  PQconninfoFree()
 * will release both the val strings and the PQconninfoOption array itself.
 * ----------------
 *}
  TPQconninfoOption	= record
    szKeyword,		// The keyword of the option
    szEnvVar,		// Fallback environment variable name
    szCompiled,		// Fallback compiled in default value
    szVal,		// Option's current value, or NULL
    szLabel,		// Label for field in connect dialog
    szDispChar:	TSDCharPtr;	// Character to display for this field in a connect dialog.
    			// Values are: "" Display entered value as is "*" Password field - hide value "D"
                        // Debug option - don't show by default
    dispsize: Integer;	// Field size in characters for dialog
  end;
{$IFDEF XSQL_CLR}
  PPQconninfoOption	= TVoid;
  PPGnotify		= TVoid;
  PPQprintOpt		= TVoid;
{$ELSE}
  PPQconninfoOption	= ^TPQconninfoOption;
  PPGnotify		= ^TPGnotify;
  PPQprintOpt		= ^TPQprintOpt;
{$ENDIF}


{* ----------------
 * PQArgBlock -- structure for PQfn() arguments
 * ----------------
 *}
  TPQArgBlock	= record
    len,
    isint:	Integer;
    IntOrPtr:	Integer;	// union {int *ptr; int	integer;} u;
  end;


{* ----------------
 * Exported functions of libpq
 * ----------------
 *}
 {$IFNDEF XSQL_CLR}
var
	// make a new client connection to the backend
  // Asynchronous (non-blocking)
  PQconnectStart: 	function(szConnInfo: TSDCharPtr): PPGconn; cdecl;
  PQconnectPoll:	function(conn: PPGconn): TPostgresPollingStatusType; cdecl;

  // Synchronous (blocking)
  PQconnectdb: 		function(szConnInfo: TSDCharPtr): PPGconn; cdecl;
  PQsetdbLogin:		function(pghost, pgport, pgoptions, pgtty, dbName, login, pwd: TSDCharPtr): PPGconn; cdecl;

  // close the current connection and free the PGconn data structure
   PQfinish:		procedure(conn: PPGconn); cdecl;

  // get info about connection options known to PQconnectdb
  PQconndefaults:	function: PPQconninfoOption; cdecl;

  // free the data structure returned by PQconndefaults()
  PQconninfoFree:	procedure(connOptions: PPQconninfoOption); cdecl;

  	// close the current connection and restablish a new one with the same parameters

  // Asynchronous (non-blocking)
  PQresetStart:	function(conn: PPGconn): Integer; cdecl;
  PQresetPoll:	function(conn: PPGconn): TPostgresPollingStatusType; cdecl;
  // Synchronous (blocking)
  PQreset:	procedure(conn: PPGconn); cdecl;

  // issue a cancel request
  PQrequestCancel:	function(conn: PPGconn): Integer; cdecl;

	// Accessor functions for PGconn objects
  PQdb:		function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQuser:	function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQpass:	function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQhost:	function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQport:	function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQtty:	function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQoptions:	function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQstatus:	function(const conn: PPGconn): TConnStatusType; cdecl;
  PQerrorMessage:function(const conn: PPGconn): TSDCharPtr; cdecl;
  PQsocket:	function(const conn: PPGconn): Integer; cdecl;
  PQbackendPID:	function(const conn: PPGconn): Integer; cdecl;
  PQclientEncoding:
  		function(const conn: PPGconn): Integer; cdecl;
  PQsetClientEncoding:
  		function(conn: PPGconn; const encoding: TSDCharPtr): Integer; cdecl;

  // Get the SSL structure associated with a connection
  PQgetssl:	function(conn: PPGconn): PSSL; cdecl;


  // Enable/disable tracing
  PQtrace:	procedure(conn: PPGconn; debug_port: Pointer); cdecl;
  PQuntrace:	procedure(conn: PPGconn); cdecl;

  // Override default notice processor
  PQsetNoticeProcessor:
  		function(conn: PPGconn; proc: TPQnoticeProcessor; arg: Pointer): TPQnoticeProcessor;


  // Simple synchronous query
  PQexec:	function(conn: PPGconn; const query: TSDCharPtr): PPGresult; cdecl;
  PQnotifies:	function(conn: PPGconn): PPGnotify; cdecl;

  // Interface for multiple-result or asynchronous queries
  PQsendQuery:	function(conn: PPGconn; const query: TSDCharPtr): Integer; cdecl;
  PQgetResult:	function(conn: PPGconn): PPGresult; cdecl;

  // Routines for managing an asychronous query
  PQisBusy: 	function(conn: PPGconn): Integer; cdecl;
  PQconsumeInput:function(conn: PPGconn): Integer; cdecl;

  // Routines for copy in/out
  PQgetline: 	function(conn: PPGconn; str: TSDCharPtr; length: Integer): Integer; cdecl;
  PQputline: 	function(conn: PPGconn; const str: TSDCharPtr): Integer; cdecl;
  PQgetlineAsync:function(conn: PPGconn; buffer: TSDCharPtr; bufsize: Integer): Integer; cdecl;
  PQputnbytes: 	function(conn: PPGconn; const buffer: TSDCharPtr; nbytes: Integer): Integer; cdecl;
  PQendcopy: 	function(conn: PPGconn): Integer; cdecl;

  // Set blocking/nonblocking connection to the backend
  PQsetnonblocking:
  		function(conn: PPGconn; arg: Integer): Integer; cdecl;
  PQisnonblocking:
  		function(const conn: PPGconn): Integer; cdecl;

  // Force the write buffer to be written (or at least try)
  PQflush:	function(conn: PPGconn): Integer; cdecl;


  	// Accessor functions for PGresult objects
  PQresultStatus:
  	 	function(const res: PPGresult): TExecStatusType; cdecl;
  PQresStatus: 	function(status: TExecStatusType): TSDCharPtr; cdecl;
  PQresultErrorMessage:
  	 	function(const res: PPGresult): TSDCharPtr; cdecl;
  PQntuples: 	function(const res: PPGresult): Integer; cdecl;
  PQnfields: 	function(const res: PPGresult): Integer; cdecl;
  PQbinaryTuples:
  	 	function(const res: PPGresult): Integer; cdecl;
  PQfname: 	function(const res: PPGresult; field_num: Integer): TSDCharPtr; cdecl;
  PQfnumber: 	function(const res: PPGresult; const field_name: TSDCharPtr): Integer; cdecl;
  PQftype: 	function(const res: PPGresult; field_num: Integer): Oid; cdecl;
  PQfsize: 	function(const res: PPGresult; field_num: Integer): Integer; cdecl;
  PQfmod: 	function(const res: PPGresult; field_num: Integer): Integer; cdecl;
  PQcmdStatus: 	function(res: PPGresult): TSDCharPtr; cdecl;
  PQoidStatus: 	function(const res: PPGresult): TSDCharPtr; cdecl;	       	// old and ugly
  PQoidValue: 	function(const res: PPGresult): Oid; cdecl;		// new and improved
  PQcmdTuples: 	function(res: PPGresult): TSDCharPtr; cdecl;
  PQgetvalue: 	function(const res: PPGresult; tup_num, field_num: Integer): TSDCharPtr; cdecl;  PQgetlength: 	function(const res: PPGresult; tup_num, field_num: Integer): Integer; cdecl;
  PQgetisnull: 	function(const res: PPGresult; tup_num, field_num: Integer): Integer; cdecl;

  // Delete a PGresult
  PQclear:	procedure(res: PPGresult); cdecl;

  // Make an empty PGresult with given status (some apps find this useful).
  //If conn is not NULL and status indicates an error, the conn's errorMessage is copied.
  PQmakeEmptyPGresult:
  		function(conn: PPGconn; status: TExecStatusType): PPGresult; cdecl;


  PQprint:	procedure(fout: Pointer; const res: PPGresult; const ps: PPQprintOpt); cdecl;


	// Large-object access routines
  lo_open: 	function(conn: PPGconn; lobjId: Oid; mode: Integer): Integer; cdecl;
  lo_close: 	function(conn: PPGconn; fd: Integer): Integer; cdecl;
  lo_read: 	function(conn: PPGconn; fd: Integer; buf: TSDCharPtr; len: Integer): Integer; cdecl;
  lo_write: 	function(conn: PPGconn; fd: Integer; buf: TSDCharPtr; len: Integer): Integer; cdecl;
  lo_lseek: 	function(conn: PPGconn; fd: Integer; offset, whence: Integer): Integer; cdecl;
  lo_creat: 	function(conn: PPGconn; mode: Integer): Oid; cdecl;
  lo_tell: 	function(conn: PPGconn; fd: Integer): Integer; cdecl;
  lo_unlink: 	function(conn: PPGconn; lobjId: Oid): Integer; cdecl;
  lo_import: 	function(conn: PPGconn; const filename: TSDCharPtr): Oid; cdecl;
  lo_export: 	function(conn: PPGconn; lobjId: Oid; const filename: TSDCharPtr): Integer; cdecl;


  // Determine length of multibyte encoded char at *s
  PQmblen:	function(const s: TSDCharPtr; encoding: Integer): Integer; cdecl;

  // Get encoding id from environment variable PGCLIENTENCODING
  PQenv2encoding:
  		function: Integer; cdecl;
{$ENDIF}

type
  ESDPgSQLError = class(ESDEngineError);

{ TIPsDatabase }
  TIPgConnInfo= packed record
    ServerType: Byte;
    PgConnPtr:	PPGconn;			// pointer to structure for communication with the PostgreSQL
  end;

  TIPgDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;

    procedure Check(pgconn: PPGconn);
    procedure CheckRes(pgres: PPGresult);
    procedure AllocHandle;
    procedure FreeHandle;
    procedure ExecCmd(const sStmt: string; CheckRslt: Boolean);
    function GetPgConnPtr: PPGconn;
  protected
    function GetHandle: TSDPtr; override;

    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;

    procedure SetAutoCommitOption(Value: Boolean); override;
    procedure SetHandle(AHandle: TSDPtr); override;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;
    function CreateSqlCommand: TISqlCommand; override;

    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function TestConnected: Boolean; override;

    property PgConnPtr: PPGconn read GetPgConnPtr;
  end;

{ TIPgCommand }
  TIPgCommand = class(TISqlCommand)
  private
    FHandle: PSDCursor;
    FRecCount,			// record count in a result set
    FCurrRec: Integer;		// the current record number (0..FRecCount-1)

    FStmt,			// w/o bind data
    FBindStmt: string;		// with bind parameter data, it's used to check whether the statement was executed
    FRowsAffected: Integer;	// number of rows affected by the last query

    function GetIsOpened: Boolean;
    function GetSqlDatabase: TIPgDatabase;
    function CnvtDateTime2SqlString(Value: TDateTime): string;
    function CnvtFloat2SqlString(Value: Double): string;
    function CnvtByteString2String(Value: string): string;
    function CnvtString2ByteString(Value: string): TSDBlobData;
    function CnvtString2EscapeString(Value: string): string;
    procedure InternalQBindParams;
    function InternalQExecute: Boolean;
  protected
    procedure Check(pgres: PPGresult);

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    procedure DoPrepare(Value: string); override;
    procedure DoExecDirect(Value: string); override;
    procedure DoExecute; override;
    procedure BindParamsBuffer; override;
    function GetHandle: PSDCursor; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    procedure InitParamList; override;
    procedure SetFieldsBuffer; override;

    property IsOpened: Boolean read GetIsOpened;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    function GetRowsAffected: Integer; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;

    property SqlDatabase: TIPgDatabase read GetSqlDatabase;
  end;


const
  DefSqlApiDLL	= 'libpq.dll';

var
  SqlApiDLL: string;

{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

{$IFDEF XSQL_CLR}

[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQconnectStart')]
function PQconnectStart(szConnInfo: TSDCharPtr): PPGconn; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQconnectPoll')]
function PQconnectPoll(conn: PPGconn): TPostgresPollingStatusType; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQconnectdb')]
function PQconnectdb(szConnInfo: TSDCharPtr): PPGconn; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQsetdbLogin')]
function PQsetdbLogin(pghost, pgport, pgoptions, pgtty, dbName, login, pwd: TSDCharPtr): PPGconn; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQfinish')]
procedure PQfinish(conn: PPGconn); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQconndefaults')]
function PQconndefaults: PPQconninfoOption; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQconninfoFree')]
procedure PQconninfoFree(connOptions: PPQconninfoOption); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQresetStart')]
function PQresetStart(conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQresetPoll')]
function PQresetPoll(conn: PPGconn): TPostgresPollingStatusType; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQreset')]
procedure PQreset(conn: PPGconn); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQrequestCancel')]
function PQrequestCancel(conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQdb')]
function PQdb(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQuser')]
function PQuser(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQpass')]
function PQpass(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQhost')]
function PQhost(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQport')]
function PQport(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQtty')]
function PQtty(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQoptions')]
function PQoptions(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQstatus')]
function PQstatus(const conn: PPGconn): TConnStatusType; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQerrorMessage')]
function PQerrorMessage(const conn: PPGconn): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQsocket')]
function PQsocket(const conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQbackendPID')]
function PQbackendPID(const conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQclientEncoding')]
function PQclientEncoding(const conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQsetClientEncoding')]
function PQsetClientEncoding(conn: PPGconn; const encoding: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetssl')]
function PQgetssl(conn: PPGconn): PSSL; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQtrace')]
procedure PQtrace(conn: PPGconn; debug_port: TVoid); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQuntrace')]
procedure PQuntrace(conn: PPGconn); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQexec')]
function PQexec(conn: PPGconn; const query: TSDCharPtr): PPGresult; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQnotifies')]
function PQnotifies(conn: PPGconn): PPGnotify; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQsendQuery')]
function PQsendQuery(conn: PPGconn; const query: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetResult')]
function PQgetResult(conn: PPGconn): PPGresult; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQisBusy')]
function PQisBusy(conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQconsumeInput')]
function PQconsumeInput(conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetline')]
function PQgetline(conn: PPGconn; str: TSDCharPtr; length: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQputline')]
function PQputline(conn: PPGconn; const str: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetlineAsync')]
function PQgetlineAsync(conn: PPGconn; buffer: TSDCharPtr; bufsize: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQputnbytes')]
function PQputnbytes(conn: PPGconn; const buffer: TSDCharPtr; nbytes: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQendcopy')]
function PQendcopy(conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQsetnonblocking')]
function PQsetnonblocking(conn: PPGconn; arg: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQisnonblocking')]
function PQisnonblocking(const conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQflush')]
function PQflush(conn: PPGconn): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQresultStatus')]
function PQresultStatus(const res: PPGresult): TExecStatusType; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQresStatus')]
function PQresStatus(status: TExecStatusType): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQresultErrorMessage')]
function PQresultErrorMessage(const res: PPGresult): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQntuples')]
function PQntuples(const res: PPGresult): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQnfields')]
function PQnfields(const res: PPGresult): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQbinaryTuples')]
function PQbinaryTuples(const res: PPGresult): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQfname')]
function PQfname(const res: PPGresult; field_num: Integer): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQfnumber')]
function PQfnumber(const res: PPGresult; const field_name: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQftype')]
function PQftype(const res: PPGresult; field_num: Integer): Oid; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQfsize')]
function PQfsize(const res: PPGresult; field_num: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQfmod')]
function PQfmod(const res: PPGresult; field_num: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQcmdStatus')]
function PQcmdStatus(res: PPGresult): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQoidStatus')]
function PQoidStatus(const res: PPGresult): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQoidValue')]
function PQoidValue(const res: PPGresult): Oid; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQcmdTuples')]
function PQcmdTuples(res: PPGresult): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetvalue')]
function PQgetvalue(const res: PPGresult; tup_num, field_num: Integer): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetlength')]
function PQgetlength(const res: PPGresult; tup_num, field_num: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQgetisnull')]
function PQgetisnull(const res: PPGresult; tup_num, field_num: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQclear')]
procedure PQclear(res: PPGresult); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQmakeEmptyPGresult')]
function PQmakeEmptyPGresult(conn: PPGconn; status: TExecStatusType): PPGresult; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQprint')]
procedure PQprint(fout: TVoid; const res: PPGresult; const ps: PPQprintOpt); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQmblen')]
function PQmblen(const s: TSDCharPtr; encoding: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'PQenv2encoding')]
function PQenv2encoding: Integer; external;

{$ENDIF}

implementation

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrFuncNotFound	= 'Function ''%s'' not found in PostgreSQL library';

const
  SDummySelect = 'select 1 from pg_class where 0=1';
  
var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;
  dwLoadedFileVer: LongInt;     // version of client DLL used

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istPostgreSQL) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIPgDatabase.Create( ADbParams );
end;

(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure SetProcAddresses;
begin
{$IFNDEF XSQL_CLR}
	// checked function availability in v.6-7.1
  @PQconnectStart	:= GetProcAddress(hSqlLibModule, 'PQconnectStart');  		// ASSERT( @PQconnectStart		<>nil, Format(SErrFuncNotFound, ['PQconnectStart']) );
  @PQconnectPoll 	:= GetProcAddress(hSqlLibModule, 'PQconnectPoll');  		// ASSERT( @PQconnectPoll 		<>nil, Format(SErrFuncNotFound, ['PQconnectPoll']) );
  @PQconnectdb   	:= GetProcAddress(hSqlLibModule, 'PQconnectdb');  		ASSERT( @PQconnectdb   		<>nil, Format(SErrFuncNotFound, ['PQconnectdb']) );
  @PQsetdbLogin  	:= GetProcAddress(hSqlLibModule, 'PQsetdbLogin');  		ASSERT( @PQsetdbLogin  		<>nil, Format(SErrFuncNotFound, ['PQsetdbLogin']) );
  @PQfinish      	:= GetProcAddress(hSqlLibModule, 'PQfinish');  			ASSERT( @PQfinish      		<>nil, Format(SErrFuncNotFound, ['PQfinish']) );
  @PQconndefaults 	:= GetProcAddress(hSqlLibModule, 'PQconndefaults');  		ASSERT( @PQconndefaults		<>nil, Format(SErrFuncNotFound, ['PQconndefaults']) );
  @PQconninfoFree 	:= GetProcAddress(hSqlLibModule, 'PQconninfoFree');  		ASSERT( @PQconninfoFree		<>nil, Format(SErrFuncNotFound, ['PQconninfoFree']) );
  @PQresetStart  	:= GetProcAddress(hSqlLibModule, 'PQresetStart');  		// ASSERT( @PQresetStart  		<>nil, Format(SErrFuncNotFound, ['PQresetStart']) );
  @PQresetPoll   	:= GetProcAddress(hSqlLibModule, 'PQresetPoll');    		// ASSERT( @PQresetPoll   		<>nil, Format(SErrFuncNotFound, ['PQresetPoll']) );
  @PQreset       	:= GetProcAddress(hSqlLibModule, 'PQreset');  			ASSERT( @PQreset       		<>nil, Format(SErrFuncNotFound, ['PQreset']) );
  @PQrequestCancel   	:= GetProcAddress(hSqlLibModule, 'PQrequestCancel');		ASSERT( @PQrequestCancel    	<>nil, Format(SErrFuncNotFound, ['PQrequestCancel']) );
  @PQdb              	:= GetProcAddress(hSqlLibModule, 'PQdb');  			ASSERT( @PQdb               	<>nil, Format(SErrFuncNotFound, ['PQdb']) );
  @PQuser            	:= GetProcAddress(hSqlLibModule, 'PQuser');  			ASSERT( @PQuser             	<>nil, Format(SErrFuncNotFound, ['PQuser']) );
  @PQpass            	:= GetProcAddress(hSqlLibModule, 'PQpass');  			ASSERT( @PQpass             	<>nil, Format(SErrFuncNotFound, ['PQpass']) );
  @PQhost            	:= GetProcAddress(hSqlLibModule, 'PQhost');  			ASSERT( @PQhost             	<>nil, Format(SErrFuncNotFound, ['PQhost']) );
  @PQport            	:= GetProcAddress(hSqlLibModule, 'PQport');  			ASSERT( @PQport             	<>nil, Format(SErrFuncNotFound, ['PQport']) );
  @PQtty             	:= GetProcAddress(hSqlLibModule, 'PQtty');  			ASSERT( @PQtty              	<>nil, Format(SErrFuncNotFound, ['PQtty']) );
  @PQoptions         	:= GetProcAddress(hSqlLibModule, 'PQoptions');  		ASSERT( @PQoptions          	<>nil, Format(SErrFuncNotFound, ['PQoptions']) );
  @PQstatus          	:= GetProcAddress(hSqlLibModule, 'PQstatus');  			ASSERT( @PQstatus           	<>nil, Format(SErrFuncNotFound, ['PQstatus']) );
  @PQerrorMessage    	:= GetProcAddress(hSqlLibModule, 'PQerrorMessage');  		ASSERT( @PQerrorMessage     	<>nil, Format(SErrFuncNotFound, ['PQerrorMessage']) );
  @PQsocket          	:= GetProcAddress(hSqlLibModule, 'PQsocket');  			ASSERT( @PQsocket           	<>nil, Format(SErrFuncNotFound, ['PQsocket']) );
  @PQbackendPID      	:= GetProcAddress(hSqlLibModule, 'PQbackendPID');  		ASSERT( @PQbackendPID       	<>nil, Format(SErrFuncNotFound, ['PQbackendPID']) );
  @PQclientEncoding  	:= GetProcAddress(hSqlLibModule, 'PQclientEncoding');  		ASSERT( @PQclientEncoding   	<>nil, Format(SErrFuncNotFound, ['PQclientEncoding']) );
  @PQsetClientEncoding	:= GetProcAddress(hSqlLibModule, 'PQsetClientEncoding');	// ASSERT( @PQsetClientEncoding	<>nil, Format(SErrFuncNotFound, ['PQsetClientEncoding']) );
  @PQtrace            	:= GetProcAddress(hSqlLibModule, 'PQtrace');  			ASSERT( @PQtrace            	<>nil, Format(SErrFuncNotFound, ['PQtrace']) );
  @PQuntrace          	:= GetProcAddress(hSqlLibModule, 'PQuntrace');  		ASSERT( @PQuntrace          	<>nil, Format(SErrFuncNotFound, ['PQuntrace']) );
  @PQsetNoticeProcessor	:= GetProcAddress(hSqlLibModule, 'PQsetNoticeProcessor');  	ASSERT( @PQsetNoticeProcessor	<>nil, Format(SErrFuncNotFound, ['PQsetNoticeProcessor']) );
  @PQexec              	:= GetProcAddress(hSqlLibModule, 'PQexec');  			ASSERT( @PQexec              	<>nil, Format(SErrFuncNotFound, ['PQexec']) );
  @PQnotifies          	:= GetProcAddress(hSqlLibModule, 'PQnotifies');  		ASSERT( @PQnotifies          	<>nil, Format(SErrFuncNotFound, ['PQnotifies']) );
  @PQsendQuery         	:= GetProcAddress(hSqlLibModule, 'PQsendQuery');  		ASSERT( @PQsendQuery         	<>nil, Format(SErrFuncNotFound, ['PQsendQuery']) );
  @PQgetResult         	:= GetProcAddress(hSqlLibModule, 'PQgetResult');  		ASSERT( @PQgetResult         	<>nil, Format(SErrFuncNotFound, ['PQgetResult']) );
  @PQisBusy            	:= GetProcAddress(hSqlLibModule, 'PQisBusy');  			ASSERT( @PQisBusy            	<>nil, Format(SErrFuncNotFound, ['PQisBusy']) );
  @PQconsumeInput      	:= GetProcAddress(hSqlLibModule, 'PQconsumeInput');  		ASSERT( @PQconsumeInput      	<>nil, Format(SErrFuncNotFound, ['PQconsumeInput']) );
  @PQgetline           	:= GetProcAddress(hSqlLibModule, 'PQgetline');  		ASSERT( @PQgetline           	<>nil, Format(SErrFuncNotFound, ['PQgetline']) );
  @PQputline           	:= GetProcAddress(hSqlLibModule, 'PQputline');  		ASSERT( @PQputline           	<>nil, Format(SErrFuncNotFound, ['PQputline']) );
  @PQgetlineAsync      	:= GetProcAddress(hSqlLibModule, 'PQgetlineAsync');  		ASSERT( @PQgetlineAsync      	<>nil, Format(SErrFuncNotFound, ['PQgetlineAsync']) );
  @PQputnbytes         	:= GetProcAddress(hSqlLibModule, 'PQputnbytes');  		ASSERT( @PQputnbytes         	<>nil, Format(SErrFuncNotFound, ['PQputnbytes']) );
  @PQendcopy           	:= GetProcAddress(hSqlLibModule, 'PQendcopy');  		ASSERT( @PQendcopy           	<>nil, Format(SErrFuncNotFound, ['PQendcopy']) );
  @PQsetnonblocking    	:= GetProcAddress(hSqlLibModule, 'PQsetnonblocking');  		// ASSERT( @PQsetnonblocking    	<>nil, Format(SErrFuncNotFound, ['PQsetnonblocking']) );
  @PQisnonblocking     	:= GetProcAddress(hSqlLibModule, 'PQisnonblocking');  		// ASSERT( @PQisnonblocking     	<>nil, Format(SErrFuncNotFound, ['PQisnonblocking']) );
  @PQflush             	:= GetProcAddress(hSqlLibModule, 'PQflush');  			// ASSERT( @PQflush             	<>nil, Format(SErrFuncNotFound, ['PQflush']) );
  @PQresultStatus      	:= GetProcAddress(hSqlLibModule, 'PQresultStatus');  		ASSERT( @PQresultStatus      	<>nil, Format(SErrFuncNotFound, ['PQresultStatus']) );
  @PQresStatus         	:= GetProcAddress(hSqlLibModule, 'PQresStatus');  		ASSERT( @PQresStatus         	<>nil, Format(SErrFuncNotFound, ['PQresStatus']) );
  @PQresultErrorMessage	:= GetProcAddress(hSqlLibModule, 'PQresultErrorMessage');  	ASSERT( @PQresultErrorMessage 	<>nil, Format(SErrFuncNotFound, ['PQresultErrorMessage']) );
  @PQntuples           	:= GetProcAddress(hSqlLibModule, 'PQntuples');  		ASSERT( @PQntuples           	<>nil, Format(SErrFuncNotFound, ['PQntuples']) );
  @PQnfields           	:= GetProcAddress(hSqlLibModule, 'PQnfields');  		ASSERT( @PQnfields           	<>nil, Format(SErrFuncNotFound, ['PQnfields']) );
  @PQbinaryTuples      	:= GetProcAddress(hSqlLibModule, 'PQbinaryTuples');  		ASSERT( @PQbinaryTuples      	<>nil, Format(SErrFuncNotFound, ['PQbinaryTuples']) );
  @PQfname             	:= GetProcAddress(hSqlLibModule, 'PQfname');  			ASSERT( @PQfname             	<>nil, Format(SErrFuncNotFound, ['PQfname']) );
  @PQfnumber           	:= GetProcAddress(hSqlLibModule, 'PQfnumber');  		ASSERT( @PQfnumber           	<>nil, Format(SErrFuncNotFound, ['PQfnumber']) );
  @PQftype             	:= GetProcAddress(hSqlLibModule, 'PQftype');  			ASSERT( @PQftype             	<>nil, Format(SErrFuncNotFound, ['PQftype']) );
  @PQfsize             	:= GetProcAddress(hSqlLibModule, 'PQfsize');  			ASSERT( @PQfsize             	<>nil, Format(SErrFuncNotFound, ['PQfsize']) );
  @PQfmod              	:= GetProcAddress(hSqlLibModule, 'PQfmod');  			ASSERT( @PQfmod              	<>nil, Format(SErrFuncNotFound, ['PQfmod']) );
  @PQcmdStatus         	:= GetProcAddress(hSqlLibModule, 'PQcmdStatus');  		ASSERT( @PQcmdStatus         	<>nil, Format(SErrFuncNotFound, ['PQcmdStatus']) );
  @PQoidStatus         	:= GetProcAddress(hSqlLibModule, 'PQoidStatus');  		ASSERT( @PQoidStatus         	<>nil, Format(SErrFuncNotFound, ['PQoidStatus']) );
  @PQoidValue          	:= GetProcAddress(hSqlLibModule, 'PQoidValue');  		ASSERT( @PQoidValue          	<>nil, Format(SErrFuncNotFound, ['PQoidValue']) );
  @PQcmdTuples         	:= GetProcAddress(hSqlLibModule, 'PQcmdTuples');  		ASSERT( @PQcmdTuples         	<>nil, Format(SErrFuncNotFound, ['PQcmdTuples']) );
  @PQgetvalue          	:= GetProcAddress(hSqlLibModule, 'PQgetvalue');  		ASSERT( @PQgetvalue          	<>nil, Format(SErrFuncNotFound, ['PQgetvalue']) );
  @PQgetlength         	:= GetProcAddress(hSqlLibModule, 'PQgetlength');  		ASSERT( @PQgetlength         	<>nil, Format(SErrFuncNotFound, ['PQgetlength']) );
  @PQgetisnull         	:= GetProcAddress(hSqlLibModule, 'PQgetisnull');  		ASSERT( @PQgetisnull         	<>nil, Format(SErrFuncNotFound, ['PQgetisnull']) );
  @PQclear             	:= GetProcAddress(hSqlLibModule, 'PQclear');  			ASSERT( @PQclear             	<>nil, Format(SErrFuncNotFound, ['PQclear']) );
  @PQmakeEmptyPGresult 	:= GetProcAddress(hSqlLibModule, 'PQmakeEmptyPGresult');  	ASSERT( @PQmakeEmptyPGresult 	<>nil, Format(SErrFuncNotFound, ['PQmakeEmptyPGresult']) );
  @PQprint             	:= GetProcAddress(hSqlLibModule, 'PQprint');  			ASSERT( @PQprint             	<>nil, Format(SErrFuncNotFound, ['PQprint']) );
  @PQmblen             	:= GetProcAddress(hSqlLibModule, 'PQmblen');  			ASSERT( @PQmblen             	<>nil, Format(SErrFuncNotFound, ['PQmblen']) );
  @PQenv2encoding      	:= GetProcAddress(hSqlLibModule, 'PQenv2encoding');  		ASSERT( @PQenv2encoding      	<>nil, Format(SErrFuncNotFound, ['PQenv2encoding']) );

  @lo_open             	:= GetProcAddress(hSqlLibModule, 'lo_open');      		ASSERT( @lo_open     		<>nil, Format(SErrFuncNotFound, ['lo_open']) );
  @lo_close            	:= GetProcAddress(hSqlLibModule, 'lo_close');      		ASSERT( @lo_close      		<>nil, Format(SErrFuncNotFound, ['lo_close']) );
  @lo_read             	:= GetProcAddress(hSqlLibModule, 'lo_read');  	    		ASSERT( @lo_read       		<>nil, Format(SErrFuncNotFound, ['lo_read']) );
  @lo_write            	:= GetProcAddress(hSqlLibModule, 'lo_write');   	   	ASSERT( @lo_write              	<>nil, Format(SErrFuncNotFound, ['lo_write']) );
  @lo_lseek            	:= GetProcAddress(hSqlLibModule, 'lo_lseek');      		ASSERT( @lo_lseek              	<>nil, Format(SErrFuncNotFound, ['lo_lseek']) );
  @lo_creat            	:= GetProcAddress(hSqlLibModule, 'lo_creat');   	   	ASSERT( @lo_creat              	<>nil, Format(SErrFuncNotFound, ['lo_creat']) );
  @lo_tell             	:= GetProcAddress(hSqlLibModule, 'lo_tell');      		ASSERT( @lo_tell               	<>nil, Format(SErrFuncNotFound, ['lo_tell']) );
  @lo_unlink           	:= GetProcAddress(hSqlLibModule, 'lo_unlink');    	  	ASSERT( @lo_unlink             	<>nil, Format(SErrFuncNotFound, ['lo_unlink']) );
  @lo_import           	:= GetProcAddress(hSqlLibModule, 'lo_import');      		ASSERT( @lo_import             	<>nil, Format(SErrFuncNotFound, ['lo_import']) );
  @lo_export           	:= GetProcAddress(hSqlLibModule, 'lo_export');     	 	ASSERT( @lo_export             	<>nil, Format(SErrFuncNotFound, ['lo_export']) );

  @PQgetssl           	:= GetProcAddress(hSqlLibModule, 'PQgetssl');
{$ENDIF}
end;

procedure ResetProcAddresses;
begin
{$IFNDEF XSQL_CLR}
  @PQconnectStart	:= nil;
  @PQconnectPoll 	:= nil;
  @PQconnectdb   	:= nil;
  @PQsetdbLogin  	:= nil;
  @PQfinish      	:= nil;
  @PQconndefaults	:= nil;
  @PQconninfoFree	:= nil;
  @PQresetStart  	:= nil;
  @PQresetPoll   	:= nil;
  @PQreset       	:= nil;
  @PQrequestCancel   	:= nil;
  @PQdb              	:= nil;
  @PQuser            	:= nil; 
  @PQpass            	:= nil; 
  @PQhost            	:= nil; 
  @PQport            	:= nil; 
  @PQtty             	:= nil; 
  @PQoptions         	:= nil; 
  @PQstatus          	:= nil; 
  @PQerrorMessage    	:= nil; 
  @PQsocket          	:= nil; 
  @PQbackendPID      	:= nil;
  @PQclientEncoding  	:= nil; 
  @PQsetClientEncoding	:= nil;
  @PQgetssl           	:= nil; 
  @PQtrace            	:= nil; 
  @PQuntrace          	:= nil;
  @PQsetNoticeProcessor	:= nil; 
  @PQexec              	:= nil; 
  @PQnotifies          	:= nil; 
  @PQsendQuery         	:= nil;
  @PQgetResult         	:= nil; 
  @PQisBusy            	:= nil; 
  @PQconsumeInput      	:= nil; 
  @PQgetline           	:= nil; 
  @PQputline           	:= nil;
  @PQgetlineAsync      	:= nil; 
  @PQputnbytes         	:= nil; 
  @PQendcopy           	:= nil; 
  @PQsetnonblocking    	:= nil;
  @PQisnonblocking     	:= nil;
  @PQflush             	:= nil;
  @PQresultStatus      	:= nil; 
  @PQresStatus         	:= nil; 
  @PQresultErrorMessage	:= nil;
  @PQntuples           	:= nil; 
  @PQnfields           	:= nil; 
  @PQbinaryTuples      	:= nil; 
  @PQfname             	:= nil; 
  @PQfnumber           	:= nil; 
  @PQftype             	:= nil; 
  @PQfsize             	:= nil; 
  @PQfmod              	:= nil; 
  @PQcmdStatus         	:= nil;
  @PQoidStatus         	:= nil; 
  @PQoidValue          	:= nil; 
  @PQcmdTuples         	:= nil; 
  @PQgetvalue          	:= nil;
  @PQgetlength         	:= nil; 
  @PQgetisnull         	:= nil;
  @PQclear             	:= nil;
  @PQmakeEmptyPGresult 	:= nil;
  @PQprint             	:= nil;
  @PQmblen             	:= nil;
  @PQenv2encoding      	:= nil;

  @lo_open             	:= nil;
  @lo_close            	:= nil;
  @lo_read             	:= nil;
  @lo_write            	:= nil;
  @lo_lseek            	:= nil;
  @lo_creat            	:= nil;
  @lo_tell             	:= nil;
  @lo_unlink           	:= nil;
  @lo_import           	:= nil;
  @lo_export           	:= nil;
{$ENDIF}
end;

procedure LoadSqlLib;
var
  sFileName:string;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      sFileName := SqlApiDLL;
      hSqlLibModule := HelperLoadLibrary( sFileName );
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [ sFileName ]);
      Inc(SqlLibRefCount);
      SetProcAddresses;
      dwLoadedFileVer := GetFileVersion(sFileName);
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
    if (SqlLibRefCount = 1) then begin
      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDLL ]);
      Dec(SqlLibRefCount);
      ResetProcAddresses;
      dwLoadedFileVer := 0;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{ TIPgDatabase }
constructor TIPgDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);
end;

destructor TIPgDatabase.Destroy;
begin
  inherited;
end;

function TIPgDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIPgCommand.Create( Self );
end;

procedure TIPgDatabase.Check(pgconn: PPGconn);
var
  E: ESDPgSQLError;
  szErrMsg: TSDCharPtr;
  sMsg: string;
begin
  ResetIdleTimeOut;
  if PQstatus( pgconn ) = CONNECTION_OK then
    Exit;
  ResetBusyState;

  szErrMsg := PQerrorMessage( pgconn );
  sMsg := HelperPtrToString( szErrMsg );

  E := ESDPgSQLError.Create(-1, -1, sMsg, 0);
  raise E;
end;

procedure TIPgDatabase.CheckRes(pgres: PPGresult);
var
  E: ESDPgSQLError;
  szErrMsg: TSDCharPtr;
  sMsg: string;
  rs: Integer;
begin
  ResetIdleTimeOut;
  rs := PQresultStatus( pgres );
  if (rs = PGRES_EMPTY_QUERY) or (rs = PGRES_COMMAND_OK) or (rs = PGRES_TUPLES_OK) then
    Exit;
  ResetBusyState;

  szErrMsg := PQresultErrorMessage( pgres );
  sMsg := HelperPtrToString( szErrMsg );

  E := ESDPgSQLError.Create(-1, -1, sMsg, 0);
  raise E;
end;

procedure TIPgDatabase.ExecCmd(const sStmt: string; CheckRslt: Boolean);
var
  res: PPGresult;
  szCmd: TSDCharPtr;
begin
{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( sStmt );
{$ELSE}
  szCmd := TSDCharPtr( sStmt );
{$ENDIF}
  res := PQexec( PgConnPtr, szCmd );
  try
    if CheckRslt then
      CheckRes( res );
  finally
    PQclear( res );
{$IFDEF XSQL_CLR}
    if Assigned( szCmd ) then
      Marshal.FreeHGlobal( szCmd );
{$ENDIF}
  end;
end;

function TIPgDatabase.GetClientVersion: LongInt;
begin
  Result := dwLoadedFileVer;
end;

function TIPgDatabase.GetServerVersion: LongInt;
begin
  Result := VersionStringToDWORD( GetVersionString );
end;

function TIPgDatabase.GetVersionString: string;
var
  res: PPGresult;
  szVer: TSDCharPtr;
  szCmd: TSDCharPtr;
  sCmd: string;
begin
  sCmd := 'select version()';
{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( sCmd );
{$ELSE}
  szCmd := TSDCharPtr( sCmd );
{$ENDIF}
  res := PQexec( PgConnPtr, szCmd);
  try
    CheckRes( res );
    szVer := PQgetvalue( res, 0, 0 );

    Result := HelperPtrToString( szVer );
  finally
    PQclear( res );
{$IFDEF XSQL_CLR}
    if Assigned( szCmd ) then
      Marshal.FreeHGlobal( szCmd );
{$ENDIF}
  end;
end;

function TIPgDatabase.GetPgConnPtr: PPGconn;
begin
  ASSERT( Assigned(FHandle), 'TIPgDatabase.GetPgConn' );
{$IFDEF XSQL_CLR}
  Result := TIPgConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIPgConnInfo) ) ).PgConnPtr;
{$ELSE}
  Result := TIPgConnInfo(FHandle^).PgConnPtr;
{$ENDIF}
end;

function TIPgDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

procedure TIPgDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF XSQL_CLR}
var
  r1, r2: TIPgConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;
{$IFDEF XSQL_CLR}
  r1 := TIPgConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIPgConnInfo) ) );
  r2 := TIPgConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIPgConnInfo) ) );
  r1.PgConnPtr := r2.PgConnPtr;
  Marshal.StructureToPtr( r1, FHandle, False );
{$ELSE}
  TIPgConnInfo(FHandle^).PgConnPtr := TIPgConnInfo(AHandle^).PgConnPtr;
{$ENDIF}
end;

procedure TIPgDatabase.AllocHandle;
var
  rec: TIPgConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TIPgDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.ServerType := Ord( istPostgreSQL );

{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIPgConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TIPgDatabase.FreeHandle;
begin
  if Assigned(FHandle) then
    FHandle := SafeReallocMem( FHandle, 0 );
end;

procedure TIPgDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
  sSrvName, sDbName, sPortNo: string;
  szUser, szPwd, szSrv, szDb, szPortNo: TSDCharPtr;
  rec: TIPgConnInfo;
begin
  LoadSqlLib;

  AllocHandle;
	// sRemoteDatabase can be equal 'srv:port:db'
  sSrvName := ExtractServerName(sRemoteDatabase);
  sDbName := ExtractDatabaseName(sRemoteDatabase);
	// gets the custom server port
  sPortNo := ExtractServerName(sDbName);
  if sPortNo = sDbName then
    sPortNo := Params.Values[szSERVERPORT];

{$IFDEF XSQL_CLR}
    rec := TIPgConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIPgConnInfo) ) );
    szSrv := Marshal.StringToHGlobalAnsi( sSrvName );
    szDb  := Marshal.StringToHGlobalAnsi( sDbName );
    if Trim(sPortNo) <> '' then
      szPortNo := Marshal.StringToHGlobalAnsi( sPortNo );
    szUser:= Marshal.StringToHGlobalAnsi( sUserName );
    szPwd := Marshal.StringToHGlobalAnsi( sPassword );
{$ELSE}
    szSrv := TSDCharPtr( sSrvName );
    szDb  := TSDCharPtr( sDbName );
    szPortNo:=TSDCharPtr( sPortNo );
    szUser:= TSDCharPtr( sUserName );
    szPwd := TSDCharPtr( sPassword );
{$ENDIF}

  try
    rec.PgConnPtr := PQsetdblogin( szSrv, szPortNo, nil, nil, szDb, szUser, szPwd );
{$IFDEF XSQL_CLR}
    Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
    TIPgConnInfo(FHandle^) := rec;
{$ENDIF}
    Check( PgConnPtr );
  finally
{$IFDEF XSQL_CLR}
    if Assigned( szSrv ) then
      Marshal.FreeHGlobal( szSrv );
    if Assigned( szDb ) then
      Marshal.FreeHGlobal( szDb );
    if Assigned( szPortNo ) then
      Marshal.FreeHGlobal( szPortNo );
    if Assigned( szUser ) then
      Marshal.FreeHGlobal( szUser );
    if Assigned( szPwd ) then
      Marshal.FreeHGlobal( szPwd );
{$ENDIF}
  end;
end;

procedure TIPgDatabase.DoDisconnect(Force: Boolean);
{$IFDEF XSQL_CLR}
var
  rec: TIPgConnInfo;
{$ENDIF}
begin
  if Assigned(FHandle) and Assigned( PgConnPtr ) then begin
    if InTransaction then
      ExecCmd( 'ROLLBACK', False );
    PQfinish( PgConnPtr );
{$IFDEF XSQL_CLR}
    rec := TIPgConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIPgConnInfo) ) );
    rec.PgConnPtr := nil;
    Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
    TIPgConnInfo(FHandle^).PgConnPtr := nil;
{$ENDIF}
  end;

  FreeHandle;
  FreeSqlLib;
end;

procedure TIPgDatabase.SetAutoCommitOption(Value: Boolean);
begin
end;

procedure TIPgDatabase.DoStartTransaction;
begin
  ExecCmd( 'BEGIN', True );
end;

procedure TIPgDatabase.DoCommit;
begin
  ExecCmd( 'COMMIT', True );
end;

procedure TIPgDatabase.DoRollback;
begin
  ExecCmd( 'ROLLBACK', True );
end;

procedure TIPgDatabase.SetTransIsolation(Value: TISqlTransIsolation);
var
  sStmt: string;
begin
  sStmt := 'SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL ';

  if Value = itiRepeatableRead then
    sStmt := sStmt + 'SERIALIZABLE'
  else
    sStmt := sStmt + 'READ COMMITTED';
  ExecCmd( sStmt, True );
end;

function TIPgDatabase.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  Result := False;
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( SDummySelect );
    if Assigned(cmd) then
      Result := True;
  finally
    cmd.Free;
  end;
end;

function TIPgDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
const
  SQueryPgStoredProcNamesFmt =
  	'select '''' as '+CAT_NAME_FIELD+', usename as '+SCH_NAME_FIELD+
        ', proname as '+PROC_NAME_FIELD+', CASE WHEN prorettype = 0 THEN 1 ELSE 2 END as '+PROC_TYPE_FIELD+
        ', pronargs as '+PROC_IN_PARAMS+', pronargs as '+ PROC_OUT_PARAMS+
        ', typname as RET_TYPE, proargtypes as ARG_TYPES'+
        ' from pg_proc, pg_shadow, pg_type st where proowner = usesysid and prorettype = st.oid %s order by usename, proname';
  SQueryPgTableNamesFmt =
  	'select '''' as '+CAT_NAME_FIELD+', usename as '+SCH_NAME_FIELD+', relname as '+TBL_NAME_FIELD+
        ', CASE relkind WHEN ''r'' THEN 1 WHEN ''v'' THEN 2 END as '+TBL_TYPE_FIELD+
        ' from pg_class, pg_user where relowner = usesysid and relkind in (''r'', ''v'') %s order by usename, relname';
  SQueryPgTableFieldNamesFmt =
  	'select '''' as '+CAT_NAME_FIELD+', usename as '+SCH_NAME_FIELD+
        ', relname as '+TBL_NAME_FIELD+', attname as '+COL_NAME_FIELD+
        ', attnum as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', typname as '+COL_TYPENAME_FIELD+
        ', CASE attlen WHEN -1 THEN (CASE atttypmod WHEN -1 THEN 0 ELSE atttypmod END) ELSE CAST(attlen as integer) END as '+COL_LENGTH_FIELD+
        ', CASE WHEN attnotnull THEN 0 ELSE 1 END as '+COL_NULLABLE_FIELD+', '''' as '+COL_DEFAULT_FIELD+
        ' from pg_class so, pg_user, pg_attribute, pg_type st '+
        'where relowner = usesysid and attrelid = so.oid and relkind in (''r'', ''v'') and'+
        '  attnum > 0 and UPPER(relname) like UPPER(''%s'') and atttypid = st.oid order by usename, relname, attnum';
	// Note, CREATE INDEX command does not have ASC/DESC sort conditions (v.7.3.2)
  SQueryPgIndexNamesFmt =
  	'select '''' as '+CAT_NAME_FIELD+', usename as '+SCH_NAME_FIELD+
        ', so.relname as '+TBL_NAME_FIELD+', si.relname as '+IDX_NAME_FIELD+
        ', attname as '+IDX_COL_NAME_FIELD+', attnum as '+IDX_COL_POS_FIELD+
        ', CASE WHEN indisunique THEN 2 ELSE 1 END + CASE WHEN indisprimary THEN 4 ELSE 0 END as '+IDX_TYPE_FIELD+
	', '''' as '+IDX_SORT_FIELD+', '''' as '+IDX_FILTER_FIELD+
        ' from pg_index, pg_class so, pg_class si, pg_shadow, pg_attribute '+
        'where indrelid = so.oid and so.relowner = usesysid and attrelid = so.oid and'+
        '  indexrelid = si.oid and UPPER(so.relname) like UPPER(''%s'') %s '+
        'order by usename, so.relname, si.relname, attnum';
  SQueryPgIndexNamesWhereFmt =
  	' (si.oid = %d and pg_attribute.attnum in (%s)) ';
  SQueryPgIndexNames1Fmt =
	'select si.oid, indkey, si.relname from pg_index, pg_class st, pg_class si'+
	' where indrelid = st.oid and indexrelid = si.oid and UPPER(st.relname) = UPPER(''%s'')';
var
  sStmt, sKeys: string;
  cmd: TISqlCommand;
  i, nId: Integer;
begin
  sStmt := '';
  case ASchemaType of
    stTables,
    stSysTables:
      begin
        if AObjectName <> '' then
          sStmt := Format(' and UPPER(relname) like UPPER(''%s'')', [AObjectName]);
        sStmt := Format(SQueryPgTableNamesFmt, [sStmt]);
      end;
    stColumns:
      sStmt := Format(SQueryPgTableFieldNamesFmt, [AObjectName] );
    stProcedures:
      begin
        if AObjectName <> '' then
          sStmt := Format(' and UPPER(proname) like UPPER(''%s'')', [AObjectName]);
        sStmt := Format(SQueryPgStoredProcNamesFmt, [sStmt]);
      end;
    stIndexes:
      begin
        sStmt := Format(SQueryPgIndexNames1Fmt, [AObjectName]);
        cmd := CreateSqlCommand;
        try
          cmd.Prepare( sStmt );
          cmd.Execute;
          sStmt := '';
          while cmd.FetchNextRow do begin
            cmd.GetFieldAsInt32(1, nId);
            cmd.GetFieldAsString(2, sKeys);
            for i:=1 to Length(sKeys) do
              if sKeys[i] = ' ' then
                sKeys[i] := ',';
            if sStmt <> '' then
              sStmt := sStmt + ' or ';
            sStmt := sStmt + Format(SQueryPgIndexNamesWhereFmt, [nId, sKeys]);
          end;
          if sStmt <> '' then
            sStmt := ' and ('+sStmt+') ';
        finally
          cmd.Free;
        end;

        sStmt := Format(SQueryPgIndexNamesFmt, [AObjectName, sStmt]);
      end;
  end;

  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( sStmt );
  except
    cmd.Free;
    raise;
  end;

  Result := cmd;
end;

{ TIPgCommand }

constructor TIPgCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FStmt		:= '';
  FBindStmt	:= '';
  FRowsAffected := -1;

  FRecCount	:= 0;
  FCurrRec	:= -1;

  FHandle 	:= nil;
end;

destructor TIPgCommand.Destroy;
begin
  Disconnect(False);

  inherited;
end;

procedure TIPgCommand.Check(pgres: PPGresult);
begin
  SqlDatabase.CheckRes( pgres );
end;

function TIPgCommand.GetHandle: PSDCursor;
begin
  Result := FHandle;
end;

function TIPgCommand.GetSqlDatabase: TIPgDatabase;
begin
  Result := (inherited SqlDatabase) as TIPgDatabase;
end;

procedure TIPgCommand.Disconnect(Force: Boolean);
begin
  // nothing
end;

procedure TIPgCommand.DoPrepare(Value: string);
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);

  FStmt		:= Value;
  FBindStmt	:= '';
end;

procedure TIPgCommand.DoExecDirect(Value: string);
var
  bResultSet: Boolean;
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);

  FStmt		:= Value;
  FBindStmt	:= '';

  bResultSet := InternalQExecute;

  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if bResultSet and (FieldDescs.Count = 0) then
    InitFieldDescs;

  SetNativeCommand(FBindStmt);
end;

procedure TIPgCommand.DoExecute;
var
  bResultSet: Boolean;
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);

  bResultSet := IsOpened;
  if not bResultSet then
    bResultSet := InternalQExecute;

  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if bResultSet and (FieldDescs.Count = 0) then begin
    InitFieldDescs;
    AllocFieldsBuffer;
    SetFieldsBuffer;
  end;

  SetNativeCommand(FBindStmt);
end;

// return True, if successful completion of a command returning data (such as a SELECT or SHOW).
function TIPgCommand.InternalQExecute: Boolean;
var
  szCmd, szRowsAffected: TSDCharPtr;
  st: Integer;
begin
  Result := False;
  FRowsAffected := -1;
	// set parameter's values
  InternalQBindParams;
{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( FBindStmt );
{$ELSE}
  szCmd := TSDCharPtr( FBindStmt );
{$ENDIF}
  try
    FHandle := PQexec( SqlDatabase.PgConnPtr, szCmd );
    Check( FHandle );
  finally
{$IFDEF XSQL_CLR}
    if Assigned( szCmd ) then
      Marshal.FreeHGlobal( szCmd );
{$ENDIF}
  end;

  st := PQresultStatus( FHandle );
	// if a command does not return data: INSERT, UPDATE
  if st = PGRES_COMMAND_OK then begin
    szRowsAffected := PQcmdTuples( FHandle );
    FRowsAffected  := StrToIntDef( HelperPtrToString( szRowsAffected ), 0 );
  end else if st = PGRES_TUPLES_OK then begin
        // return the number of rows in the query result
    FRecCount := PQntuples( FHandle );
    FCurrRec  := -1;
    Result := True;
  end;
end;

function TIPgCommand.GetIsOpened: Boolean;
begin
        // if successful completion of a command returning data (such as a SELECT or SHOW).
  Result := Assigned( FHandle ) and (PQresultStatus(FHandle) = PGRES_TUPLES_OK);
end;

function TIPgCommand.GetRowsAffected: Integer;
begin
  Result := FRowsAffected;
end;

function TIPgCommand.ResultSetExists: Boolean;
begin
  Result := True;
end;

procedure TIPgCommand.BindParamsBuffer;
begin
  // nothing
end;

procedure TIPgCommand.SetFieldsBuffer;
begin
  // nothing
end;

procedure TIPgCommand.InitParamList;
begin
  DatabaseError(SNoCapability);
end;

procedure TIPgCommand.GetOutputParams;
begin
  DatabaseError(SNoCapability);
end;


{ Convert TDateTime to string for SQL statement }
function TIPgCommand.CnvtDateTime2SqlString(Value: TDateTime): string;
  { Format date in ISO format 'yyyy-mm-dd' }
  function FormatSqlDate(Value: TDateTime): string;
  var
    Year, Month, Day: Word;
  begin
    DecodeDate(Value, Year, Month, Day);
    Result := Format('%.4d-%.2d-%.2d', [Year, Month, Day]);
  end;
  { Format time in ISO format 'hh:nn:ss' }
  function FormatSqlTime(Value: TDateTime): string;
  var
    Hour, Min, Sec, MSec: Word;
  begin
    DecodeTime(Value, Hour, Min, Sec, MSec);
    Result := Format('%.2d:%.2d:%.2d', [Hour, Min, Sec]);
  end;

begin
  if Trunc(Value) <> 0 then
    Result := FormatSqlDate(Value)
  else
    Result := '1899-12-30';

  if Frac(Value) <> 0 then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + FormatSqlTime(Value);
  end;
  Result := '''' + Result + '''';
end;

{ Convert float value to string with '.' delimiter }
function TIPgCommand.CnvtFloat2SqlString(Value: Double): string;
var
  i: Integer;
begin
  Result := FloatToStr(Value);
  if DecimalSeparator <> '.' then begin
    i := Pos(DecimalSeparator,Result);
    if i <> 0 then Result[i] := '.';
  end;
end;

{ Characters are converted as (tested with PostgreSQL 7.1)
  <'>  -> <\'>
  <$0> -> <\\000>
  <\>  -> <\\\\> 	 - it's probably this (and previous) character is converted twice
  <X>  -> <X>            - printable characters
  <X>  -> <\nnn> (octal) - non-printable characters
}
function TIPgCommand.CnvtByteString2String(Value: string): string;
  function IsPrint(Ch: Char): Boolean;
  begin
    Result := Byte(Ch) in [$20..$7E];
  end;
var
  i, j, BufSize: Integer;
begin
  BufSize := 0;

  i := 1;
  	// get size of the converted string
  while i <= Length(Value) do begin
    if Value[i] = '''' then
      BufSize := BufSize + 2
    else if Value[i] = #$00 then
      BufSize := BufSize + 5
    else if IsPrint(Value[i]) and (Value[i] <> '\') then
      BufSize := BufSize + 1
    else
      BufSize := BufSize + 4;
    Inc(i);
  end;

  SetLength( Result, BufSize );
  j := 1;
  for i:=1 to Length(Value) do begin
    if Value[i] = '''' then begin
      Result[j+0] := '\';
      Result[j+1] := '''';
      j := j + 2;
    end else if Value[i] = #$00 then begin
      Result[j+0] := '\';
      Result[j+1] := '\';
      Result[j+2] := '0';
      Result[j+3] := '0';
      Result[j+4] := '0';
      j := j + 5;
    end else if Value[i] = '\' then begin
      Result[j+0] := '\';
      Result[j+1] := '\';
      Result[j+2] := '\';
      Result[j+3] := '\';
      j := j + 4;
    end else if IsPrint(Value[i]) then begin
      Result[j+0] := Value[i];
      Inc(j);
    end else begin
      Result[j+0] := '\';
      Result[j+1] := Char( Byte('0') + ((Byte(Value[i]) and $C0) shr 6) );
      Result[j+2] := Char( Byte('0') + ((Byte(Value[i]) and $38) shr 3) );
      Result[j+3] := Char( Byte('0') + ((Byte(Value[i]) and $07)) );
      j := j + 4;
    end;
  end;
  	// in case of emergency. Below code will be executed, when size of result buffer was calculated wrong.
  while j <= Length(Result) do begin
    Result[j] := #0;
    Inc(j);
  end;

  Result := '''' + Result + '''';
end;


{ Non-printable and <\> characters are inserted as <\nnn> (octal)
  and <'> as <\'>
}
function TIPgCommand.CnvtString2ByteString(Value: string): TSDBlobData;
  function IsDigit(Ch: Char): Boolean;
  begin
    Result := AnsiChar( Ch ) in ['0'..'9'];
  end;
var
  i, j, CharCount: Integer;
begin
  CharCount := 0;
  i := 1;
  while i <= Length(Value) do begin
    if Value[i] = '\' then begin
      Inc( i );

      if i > Length(Value) then
        Break;

      	// <\\> = <\>, <\'> = <'>
      if AnsiChar( Value[i] ) in ['\', ''''] then
        Inc( CharCount )
      else if IsDigit(Value[i]) and ((i+2)<=Length(Value)) and
              IsDigit(Value[i+1]) and IsDigit(Value[i+2])
      then begin
        i := i + 2;
        Inc( CharCount );
      end else
        ASSERT(False, Format('Invalid octal number format(offset:%d) in Blob field', [i]));

    end else	// any other character
      Inc( CharCount );

    Inc( i );
  end;
	// allocate a result buffer
  SetLength( Result, CharCount );
//  FillChar( TSDCharPtr(Result)^, CharCount, $0 );
//  CurPtr := TSDCharPtr(Result);
  i := 1;
  j := 0;
  while i <= Length(Value) do begin
    if Value[i] = '\' then begin
      Inc( i );

      if i > Length(Value) then
        Break;

      	// <\\> = <\>, <\'> = <'>
      if AnsiChar( Value[i] ) in ['\', ''''] then
        Result[j] := Byte( Value[i] )
      else if IsDigit(Value[i]) and ((i+2)<=Length(Value)) and
              IsDigit(Value[i+1]) and IsDigit(Value[i+2])
      then begin
        Result[j] := 	( (Byte(Value[i])   - Byte('0')) shl 6 ) or
                	( (Byte(Value[i+1]) - Byte('0')) shl 3 ) or
                	(  Byte(Value[i+2]) - Byte('0') );
        i := i + 2
      end;
    end else	// any other character
      Result[j] := Byte( Value[i] );

    Inc( i );
    Inc( j );
  end;
  	// in case of emergency. Below code will be executed only, when size of result buffer was calculated wrong.
  while j < Length(Result) do begin
    Result[j] := 0;
    Inc(j);
  end;
end;

{ <\> and <'> are inserted as <\\> and <\'> }
function TIPgCommand.CnvtString2EscapeString(Value: string): string;
var
  i: Integer;
begin
  Result := Value;

  i := 1;
  while i <= Length(Result) do begin
    if AnsiChar( Result[i] ) in ['''', '\'] then begin
      Insert('\', Result, i);
      Inc( i );
    end;

    Inc( i );
  end;

  Result := '''' + Result + '''';
end;

procedure TIPgCommand.InternalQBindParams;
const
  ParamPrefix	= ':';
  SqlNullValue	= 'NULL';
  QuoteChar	= '"';	// for surroundings of the parameter's name, which can include, for example, spaces
var
  i: Integer;
  sFullParamName, sValue: string;
begin
  FBindStmt := FStmt;
  if not Assigned(Params) then
    Exit;

  for i:=Params.Count-1 downto 0 do begin
    	// set parameter value
    if Params[i].IsNull then begin
      sValue := SqlNullValue
    end else begin
      case Params[i].DataType of
{$IFDEF XSQL_VCL4}
        ftLargeInt,
{$ENDIF}
        ftInteger,
        ftSmallint,
        ftWord:	sValue := Params[i].AsString;
        ftBoolean:
          if Params[i].AsBoolean
          then sValue := 'TRUE' else sValue := 'FALSE'; 	// Valid literal values for the "true"/"false" state are: TRUE, 't', 'y','1'/FALSE, 'f', 'n', '0'
        ftBytes,
        ftVarBytes,
        ftBlob:
          sValue := CnvtByteString2String(Params[i].AsString);
        ftDate,
        ftTime,
        ftDateTime:	sValue := CnvtDateTime2SqlString(Params[i].AsDateTime);
        ftCurrency,
        ftFloat:	sValue := CnvtFloat2SqlString(Params[i].AsFloat);
      else
        sValue := CnvtString2EscapeString(Params[i].AsString);
      end;
    end;
	// change a parameter's name on a value of the parameter
    sFullParamName := ParamPrefix + Params[i].Name;
    if not ReplaceString( False, sFullParamName, sValue, FBindStmt ) then begin
    	// if parameter's name is enclosed in double quotation marks
      sFullParamName := Format( '%s%s%s%s', [ParamPrefix, QuoteChar, Params[i].Name, QuoteChar] );
      ReplaceString( False, sFullParamName, sValue, FBindStmt );
    end;
  end;
end;

function TIPgCommand.FetchNextRow: Boolean;
begin
  Inc( FCurrRec );
  Result := FCurrRec < FRecCount;

  if Result and (BlobFieldCount > 0) then
    FetchBlobFields;
end;

procedure TIPgCommand.CloseResultSet;
begin
  if Assigned( FHandle ) then
    PQclear( FHandle );

  FBindStmt := '';
  FHandle := nil;

  FRecCount	:= 0;
  FCurrRec	:= -1;
end;

procedure TIPgCommand.GetFieldDescs(Descs: TSDFieldDescList);
var
  Col, NumCols: Integer;
  ft: TFieldType;
  szFldName: TSDCharPtr;
  sFldName: string;
  FldSize: Integer;
  ftype: Oid;
begin
  if not IsOpened then
    InternalQExecute;

  NumCols := PQnfields( FHandle );
  for Col:=0 to NumCols-1 do begin
    szFldName := PQfname( FHandle, Col );
    sFldName := HelperPtrToString( szFldName );
    ftype := PQftype(FHandle, Col);
    ft := FieldDataType( ftype );
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [sFldName] );
	// -1 is returned if the field is variable size
    FldSize := PQfsize( FHandle, Col );
    if FldSize < 0 then
      if ft = ftString then begin
    	// it returns (4+n) bytes for char/varchar(n)
        FldSize := PQfmod( FHandle, Col );
        if FldSize >= 4 then
          FldSize := FldSize - 4 + 1;	// add byte for zero terminator
        if FldSize <= 0 then
          FldSize := dsMaxStringSize;
      end else
        FldSize := NativeDataSize(ft);  // to exclude -1 in FieldDesc.DataSize for some types, including blobs

    with Descs.AddFieldDesc do begin
      FieldName	:= sFldName;
      FieldNo	:= Col+1;
      FieldType	:= ft;
      DataType	:= ftype;
      if FldSize > 0 then
        DataSize:= FldSize
      else
        DataSize:= 0;
	// the folowing values are not undefined in PostgreSQL
      Precision	:= 0;
  	// null values are not permitted for the column (Required = True)
      Required	:= False;
    end;
  end;
end;

{ BufSize is not used for all datatypes now }
function TIPgCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  OutData: TSDPtr;
  szValue: TSDCharPtr;
  sValue: string;
  nSize: Integer;
  dtValue: TDateTime;
  dtRec: TDateTimeRec;
begin
  Result := PQgetisnull( FHandle, FCurrRec, AFieldDesc.FieldNo-1 ) = 0;
  if not Result then
    Exit;

  OutData	:= Buffer;
  szValue 	:= PQgetvalue( FHandle, FCurrRec, AFieldDesc.FieldNo-1 );
  nSize	        := PQgetlength( FHandle, FCurrRec, AFieldDesc.FieldNo-1 );
  sValue	:= HelperPtrToString( szValue, nSize );
  if RequiredCnvtFieldType(AFieldDesc.FieldType) then begin
    case AFieldDesc.FieldType of
{$IFDEF XSQL_VCL4}
    ftLargeInt:
        HelperMemWriteInt64( OutData, 0, StrToInt64Def( sValue, 0 ) );
{$ENDIF}
    ftInteger, ftSmallInt:
        HelperMemWriteInt32( OutData, 0, StrToIntDef( sValue, 0 ) );
    ftFloat:
        HelperMemWriteDouble( OutData, 0, SqlStrToFloatDef(sValue, 0) );
    ftBoolean:
        HelperMemWriteInt16( OutData, 0, Word( SqlStrToBoolean(sValue) ) );
    ftTime:
      begin
        dtValue := SqlTimeToDateTime(sValue);
        dtRec.Time := DateTimeToTimeStamp( dtValue ).Time;
        HelperMemWriteDateTimeRec( OutData, 0, dtRec );
      end;
    ftDate, ftDateTime:
      begin
        dtValue := SqlDateToDateTime(sValue);
        if AFieldDesc.FieldType in [ftDate] then
          dtRec.Date := DateTimeToTimeStamp(dtValue).Date
        else
          dtRec.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtValue) );
        HelperMemWriteDateTimeRec( OutData, 0, dtRec );
      end;
    end;	// end of case
  end else begin
    if IsBlobType(AFieldDesc.FieldType) then begin
      Result := False;
      Exit;
    end;
    if nSize > BufSize then
      nSize := BufSize;
    SafeCopyMem( szValue, OutData, nSize );
    if AFieldDesc.FieldType = ftString then begin
      if nSize = BufSize then
        Dec(nSize);
      HelperMemWriteByte( OutData, nSize, 0 );
    end;
  end;
end;

function TIPgCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  BlobSize: LongInt;
  DataPtr: TSDCharPtr;
begin
  BlobData := nil;

  BlobSize:= PQgetlength( FHandle, FCurrRec, AFieldDesc.FieldNo-1 );

  if BlobSize > 0 then begin
    DataPtr := PQgetvalue( FHandle, FCurrRec, AFieldDesc.FieldNo-1 );
    if Assigned(DataPtr) then
      if AFieldDesc.FieldType = ftMemo then begin
        SetLength(BlobData, BlobSize);
{$IFDEF XSQL_CLR}
        Marshal.Copy( DataPtr, BlobData, 0, BlobSize );
{$ELSE}
        System.Move( DataPtr^, TSDCharPtr(BlobData)^, BlobSize );
{$ENDIF}
      end else	// Blob
        BlobData := CnvtString2ByteString( HelperPtrToString( DataPtr ) );
  end;

  Result := Length(BlobData);
end;

function TIPgCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
    BOOLOID: 	// BOOLEAN|BOOL
      Result := ftBoolean;
    BYTEAOID: 	// BYTEA - variable-length string, binary values escaped
      Result := ftBlob;
    TEXTOID: 	// TEXT - variable-length string, no limit specified
      Result := ftMemo;
    CHAROID, 	// CHAR - single character
    BPCHAROID, 	// BPCHAR - char(length), blank-padded string, fixed storage length
    NAMEOID, 	// NAME - 31-character type for storing system identifiers
    VARCHAROID: // VARCHAR(?) - varchar(length), non-blank-padded string, variable storage length
      Result := ftString;
    INT8OID: 	// INT8|BIGINT - ~18 digit integer, 8-byte storage
{$IFDEF XSQL_VCL4}
      Result := ftLargeInt;
{$ELSE}
      Result := ftInteger;
{$ENDIF}
    FLOAT4OID, 	// FLOAT4 - single-precision floating point number, 4-byte storage
    FLOAT8OID, 	// FLOAT8 - double-precision floating point number, 8-byte storage
    CASHOID, 	// $d,ddd.cc, money
    NUMERICOID: // NUMERIC(x,y) - numeric(precision, decimal), arbitrary precision number
      Result := ftFloat;
    INT2OID: 	// INT2|SMALLINT - -32 thousand to 32 thousand, 2-byte storage
      Result := ftSmallInt;
    INT4OID, 	// INT4|INTEGER - -2 billion to 2 billion integer, 4-byte storage
    XIDOID, 	// transaction id
    CIDOID, 	// command identifier type, sequence in transaction id
    OIDOID: 	// OID - object identifier(oid), maximum 4 billion
      Result := ftInteger;
    DATEOID:    // DATE - ANSI SQL date
      Result := ftDate;
    TIMEOID: 	// TIME - hh:mm:ss, ANSI SQL time
      Result := ftTime;
    ABSTIMEOID, // ABSTIME - absolute, limited-range date and time (Unix system time)
    TIMESTAMPOID,// TIMESTAMP - date and time
    TIMESTAMPOID_v72,
    TIMETZOID: 	// TIME WITH TIMEZONE - hh:mm:ss, ANSI SQL time
      Result := ftDateTime;
    UNKNOWNOID, // Unknown
    INT2VECTOROID, 	// array of INDEX_MAX_KEYS int2 integers, used in system tables
    REGPROCOID, // registered procedure
    TIDOID, 	// (Block, offset), physical location of tuple
    OIDVECTOROID, 	// array of INDEX_MAX_KEYS oids, used in system tables
    POINTOID, 	// geometric point '(x, y)'
    LSEGOID, 	// geometric line segment '(pt1,pt2)'
    PATHOID, 	// geometric path '(pt1,...)'
    BOXOID, 	// geometric box '(lower left,upper right)'
    POLYGONOID, // geometric polygon '(pt1,...)'
    LINEOID, 	// geometric line '(pt1,pt2)'
    RELTIMEOID, // relative, limited-range time interval (Unix delta time)
    TINTERVALOID, // (abstime,abstime), time interval
    INTERVALOID,// @ <number> <units>, time interval
    CIRCLEOID, 	// geometric circle '(center,radius)'
	// locale specific
    INETOID, 	// IP address/netmask, host address, netmask optional
    CIDROID, 	// network IP address/netmask, network address
    829, 	// XX:XX:XX:XX:XX:XX, MAC address
    ZPBITOID, 	// BIT(?) - fixed-length bit string
    VARBITOID: 	// BIT VARING(?) - variable-length bit string
      Result := ftString;
    else
      Result := ftString;
  end;
end;

{ select buffer is not used }
function TIPgCommand.NativeDataSize(FieldType: TFieldType): Word;
begin
  Result := 0;
end;

function TIPgCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in
  	[ftInteger, {$IFDEF XSQL_VCL4}ftLargeInt,{$ENDIF} ftSmallInt,
         ftFloat,
         ftDate, ftTime, ftDateTime,
         ftBoolean];
end;


initialization
  hSqlLibModule := 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.

