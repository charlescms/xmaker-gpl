
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{	Firebird API(v.1.5) Interface Unit		}
{       		                                }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDFib {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, Registry, SyncObjs,
{$IFDEF SD_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  SDConsts, SDCommon, SDInt;

type
{ TFibFunctions }
  TFibFunctions = class(TIntFunctions)
  public
    procedure SetApiCalls(ASqlLibModule: THandle); override;
  end;

  ESDFibError = class(ESDIntError);

{ TIFibDatabase }
  TIFibDatabase = class(TICustomIntDatabase)
  protected
    procedure AllocHandle(DBHandles: Boolean); override;
    procedure FreeSqlLib; override;
    procedure LoadSqlLib; override;
    function GetErrorClass: ESDEngineErrorClass; override;
  public
    function CreateSqlCommand: TISqlCommand; override;

    function GetClientVersion: LongInt; override;
  end;

{ TIFibCommand }
  TIFibCommand = class(TICustomIntCommand)
  end;

const
  DefSqlApiDLL	= 'FBCLIENT.DLL';

var
  SqlApiDLL: string;
  FibCalls: TFibFunctions;


(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

{$IFDEF SD_CLR}

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_attach_database')]
function isc_attach_database(
    status_vector            : PISC_STATUS;
    db_name_length           : Short;
    db_name                  : TSDCharPtr;
    db_handle                : PISC_DB_HANDLE;
    parm_buffer_length       : Short;
    parm_buffer              : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_default_desc')]
procedure isc_blob_default_desc(
    desc		     : PISC_BLOB_DESC;
    table_name               : TSDCharPtr;
    column_name              : TSDCharPtr); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_gen_bpb')]
function isc_blob_gen_bpb(
    status_vector            : PISC_STATUS;
    to_desc                  : PISC_BLOB_DESC;
    from_desc                : PISC_BLOB_DESC;
    bpb_buffer_length        : UShort;
    bpb_buffer               : TSDCharPtr;
    bpb_length               : PUShort): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_info')]
function isc_blob_info (
    status_vector            : PISC_STATUS;
    var blob_handle          : TISC_BLOB_HANDLE;
    item_list_buffer_length  : Short;
    item_list_buffer         : TSDCharPtr;
    result_buffer_length     : Short;
    result_buffer            : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_lookup_desc')]
function isc_blob_lookup_desc(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    trans_handle             : PISC_TR_HANDLE;
    table_name               : TSDCharPtr;
    column_name              : TSDCharPtr;
    desc                     : PISC_BLOB_DESC;
    global_column_name       : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_set_desc')]
function isc_blob_set_desc(
    status_vector            : PISC_STATUS;
    table_name               : TSDCharPtr;
    column_name              : TSDCharPtr;
    subtype,
    charset,
    segment_size             : Short;
    desc                     : PISC_BLOB_DESC): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_cancel_blob')]
function isc_cancel_blob(
    status_vector            : PISC_STATUS;
    var blob_handle          : TISC_BLOB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_cancel_events')]
function isc_cancel_events(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    event_id                 : PISC_LONG): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_close_blob')]
function isc_close_blob(
    status_vector            : PISC_STATUS;
    var blob_handle          : TISC_BLOB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_commit_retaining')]
function isc_commit_retaining(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_commit_transaction')]
function isc_commit_transaction(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_create_blob')]
function isc_create_blob(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    var blob_handle          : TISC_BLOB_HANDLE;
    blob_id                  : PISC_QUAD): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_create_blob2')]
function isc_create_blob2(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    var blob_handle          : TISC_BLOB_HANDLE;
    blob_id                  : PISC_QUAD;
    bpb_length               : Short;
    bpb_address              : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_create_database')]
function isc_create_database(
    status_vector            : PISC_STATUS;
    db_name_length           : Short;
    db_name                  : TSDCharPtr;
    db_handle                : PISC_DB_HANDLE;
    parm_buffer_length       : Short;
    parm_buffer              : TSDCharPtr;
    parm_7                   : Short): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_database_info')]
function isc_database_info(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    item_list_buffer_length  : Short;
    item_list_buffer         : TSDCharPtr;
    result_buffer_length     : Short;
    result_buffer            : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_date')]
procedure isc_decode_date(
    ib_date: 		PISC_QUAD;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_sql_date')]
procedure isc_decode_sql_date(
    ib_date: 	PISC_DATE;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_sql_time')]
procedure isc_decode_sql_time(
    ib_time: 		PISC_TIME;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_timestamp')]
procedure isc_decode_timestamp(
    ib_timestamp: 	PISC_TIMESTAMP;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_detach_database')]
function isc_detach_database(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_drop_database')]
function isc_drop_database(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_allocate_statement')]
function isc_dsql_allocate_statement(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_alloc_statement2')]
function isc_dsql_alloc_statement2(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_describe')]
function isc_dsql_describe(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_describe_bind')]
function isc_dsql_describe_bind(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_execute')]
function isc_dsql_execute(
    status_vector            : PISC_STATUS;
    tran_handle              : PISC_TR_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_execute2')]
function isc_dsql_execute2(
    status_vector            : PISC_STATUS;
    tran_handle              : PISC_TR_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    in_xsqlda,
    out_xsqlda               : PXSQLDA): ISC_STATUS;
    external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_execute_immediate')]
function isc_dsql_execute_immediate(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    length                   : UShort;
    statement                : TSDCharPtr;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_exec_immed2')]
function isc_dsql_exec_immed2(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    length                   : UShort;
    statement                : TSDCharPtr;
    dialect                  : UShort;
    in_xsqlda, out_xsqlda    : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_fetch')]
function isc_dsql_fetch(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_finish')]
function isc_dsql_finish(
    db_handle                : PISC_DB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_free_statement')]
function isc_dsql_free_statement(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    option                   : UShort): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_prepare')]
function isc_dsql_prepare(
    status_vector            : PISC_STATUS;
    tran_handle              : PISC_TR_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE;
    length                   : UShort;
    statement                : TSDCharPtr;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_set_cursor_name')]
function isc_dsql_set_cursor_name(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    cursor_name              : TSDCharPtr;
    type_reserved            : UShort): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_sql_info')]
function isc_dsql_sql_info(
    status_vector             : PISC_STATUS;
    stmt_handle               : PISC_STMT_HANDLE;
    item_length               : Short;
    items                     : TSDCharPtr;
    buffer_length             : Short;
    buffer                    : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_date')]
procedure isc_encode_date(
    	var tm_date:	TTimeDateRec;
    	ib_date:	PISC_QUAD); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_sql_date')]
procedure isc_encode_sql_date(
	var tm_date: 	TTimeDateRec;
      ib_date: 	PISC_DATE); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_sql_time')]
procedure isc_encode_sql_time(
	var tm_date: 	TTimeDateRec;
      ib_time:	PISC_TIME); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_timestamp')]
procedure isc_encode_timestamp(
	var tm_date: 	TTimeDateRec;
      ib_timestamp:	PISC_TIMESTAMP); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_event_counts')]
procedure isc_event_counts(
    status_vector             : PISC_STATUS;
    buffer_length             : Short;
    event_buffer              : TSDCharPtr;
    result_buffer             : TSDCharPtr); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_get_segment')]
function isc_get_segment(
    status_vector             : PISC_STATUS;
    var blob_handle           : TISC_BLOB_HANDLE;
    var actual_seg_length     : UShort;
    seg_buffer_length         : UShort;
    seg_buffer                : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_interprete')]
function isc_interprete(
    buffer                    : TSDCharPtr;
    var status_vector         : PISC_STATUS): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_open_blob')]
function isc_open_blob(
    status_vector             : PISC_STATUS;
    db_handle                 : PISC_DB_HANDLE;
    tran_handle               : PISC_TR_HANDLE;
    var blob_handle           : TISC_BLOB_HANDLE;
    blob_id                   : PISC_QUAD): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_open_blob2')]
function isc_open_blob2(
    status_vector             : PISC_STATUS;
    db_handle                 : PISC_DB_HANDLE;
    tran_handle               : PISC_TR_HANDLE;
    var blob_handle           : TISC_BLOB_HANDLE;
    blob_id                   : TISC_QUAD;
    bpb_length                : Short;
    bpb_buffer                : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_prepare_transaction')]
function isc_prepare_transaction(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_prepare_transaction2')]
function isc_prepare_transaction2(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE;
    msg_length		: Short;
    msg			: TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_print_sqlerror')]
procedure isc_print_sqlerror(
    sqlcode                   : Short;
    status_vector             : PISC_STATUS); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_print_status')]
function isc_print_status(
    status_vector             : PISC_STATUS): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_put_segment')]
function isc_put_segment(
    status_vector             : PISC_STATUS;
    var blob_handle           : TISC_BLOB_HANDLE;
    seg_buffer_len            : UShort;
    seg_buffer                : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_rollback_retaining')]
function isc_rollback_retaining(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_rollback_transaction')]
function isc_rollback_transaction(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_start_multiple')]
function isc_start_multiple(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE;
    db_handle_count           : Short;
    var teb_vector_address    : TISC_TEB): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_sqlcode')]
function isc_sqlcode(
    var status_vector             : PISC_STATUS): ISC_LONG; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_sql_interprete')]
procedure isc_sql_interprete(
    sql_code			: Short;
    buffer                    : TSDCharPtr;
    buffer_length             : Short); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_transaction_info')]
function isc_transaction_info(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE;
    item_list_buffer_length  : Short;
    item_list_buffer         : TSDCharPtr;
    result_buffer_length     : Short;
    result_buffer            : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_vax_integer')]
function isc_vax_integer(
    buffer                    : TSDCharPtr;
    length                    : Short): ISC_LONG; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_version')]
function isc_version(
    db_handle                 : PISC_DB_HANDLE;
    isc_arg2                  : TISC_CALLBACK;
    isc_arg3                  : PVoid): Int; external;
	// Security Functions
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_add_user')]
function isc_add_user(
    status_vector             : PISC_STATUS;
    var user_sec_data         : TUSER_SEC_DATA): Int; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_delete_user')]
function isc_delete_user(
    status_vector             : PISC_STATUS;
    var user_sec_data         : TUSER_SEC_DATA): Int; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_modify_user')]
function isc_modify_user(
    status_vector             : PISC_STATUS;
    var user_sec_data         : TUSER_SEC_DATA): Int; external;
{$ENDIF}

implementation

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';

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
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istFirebird) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIFibDatabase.Create( ADbParams );
end;

procedure LoadSqlLib;
  function GetFirebirdHome: string;
  const
    HomeKey	= 'SOFTWARE\Firebird Project\Firebird Server\Instances';
    HomeVal	= 'DefaultInstance';
  var
    rg: TRegistry;
  begin
    rg := TRegistry.Create;
    try
      rg.RootKey := HKEY_LOCAL_MACHINE;
{$IFDEF SD_VCL4}
      if rg.OpenKeyReadOnly(HomeKey) then begin
{$ELSE}
      if rg.OpenKey(HomeKey, False) then begin
{$ENDIF}
        Result := Trim( rg.ReadString(HomeVal) );
        rg.CloseKey;
      end;
    finally
      rg.Free;
    end;
  end;

var
  bUseRegHome: Boolean;
  sFileName, sBinDir: string;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      bUseRegHome := False;
      sBinDir := '';
      sFileName := SqlApiDLL;
        // try to use path from registry
      if ExtractFilePath(sFileName) = '' then begin
        sBinDir := GetFirebirdHome;
        if sBinDir <> '' then begin
          sBinDir := sBinDir + '\bin';
          sFileName := sBinDir + '\'+ sFileName;
          bUseRegHome := True;
        end;
      end;
      hSqlLibModule := HelperLoadLibrary( sFileName );
        // load without registry path
      if (hSqlLibModule = 0) and bUseRegHome then begin
        sFileName := SqlApiDLL;
        hSqlLibModule := HelperLoadLibrary( sFileName );        
      end;

      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [sFileName]);
      Inc(SqlLibRefCount);
      FibCalls.SetApiCalls( hSqlLibModule );
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
      if Windows.FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDLL ]);
      Dec(SqlLibRefCount);
      FibCalls.ClearApiCalls;
      dwLoadedFileVer := 0;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

procedure TFibFunctions.SetApiCalls(ASqlLibModule: THandle);
begin
{$IFDEF SD_CLR}
  FLibHandle := ASqlLibModule;
  isc_attach_database 		:= SDFib.isc_attach_database;
  isc_blob_default_desc   	:= SDFib.isc_blob_default_desc;
  isc_blob_gen_bpb        	:= SDFib.isc_blob_gen_bpb;
  isc_blob_info       		:= SDFib.isc_blob_info;

  isc_blob_lookup_desc 		:= SDFib.isc_blob_lookup_desc;
  isc_blob_set_desc    		:= SDFib.isc_blob_set_desc;
  isc_cancel_blob      		:= SDFib.isc_cancel_blob;
  isc_cancel_events    		:= SDFib.isc_cancel_events;

  isc_close_blob      		:= SDFib.isc_close_blob;
  isc_commit_transaction 	:= SDFib.isc_commit_transaction;
  isc_commit_retaining 		:= SDFib.isc_commit_retaining;
  isc_create_blob     		:= SDFib.isc_create_blob;
  isc_create_blob2    		:= SDFib.isc_create_blob2;
  isc_create_database           := SDFib.isc_create_database;  

  isc_database_info    		:= SDFib.isc_database_info;
  isc_detach_database 		:= SDFib.isc_detach_database;
  isc_drop_database    		:= SDFib.isc_drop_database;

  isc_dsql_allocate_statement	:= SDFib.isc_dsql_allocate_statement;
  isc_dsql_alloc_statement2   	:= SDFib.isc_dsql_alloc_statement2;
  isc_dsql_describe 		:= SDFib.isc_dsql_describe;
  isc_dsql_describe_bind 	:= SDFib.isc_dsql_describe_bind;
  isc_dsql_execute 		:= SDFib.isc_dsql_execute;
  isc_dsql_execute2 		:= SDFib.isc_dsql_execute2;
  isc_dsql_execute_immediate  	:= SDFib.isc_dsql_execute_immediate;
  isc_dsql_exec_immed2    	:= SDFib.isc_dsql_exec_immed2;
  isc_dsql_fetch 		:= SDFib.isc_dsql_fetch;
  isc_dsql_finish	    	:= SDFib.isc_dsql_finish;
  isc_dsql_free_statement 	:= SDFib.isc_dsql_free_statement;
  isc_dsql_prepare 		:= SDFib.isc_dsql_prepare;
  isc_dsql_set_cursor_name    	:= SDFib.isc_dsql_set_cursor_name;
  isc_dsql_sql_info 		:= SDFib.isc_dsql_sql_info;

  isc_event_counts	    	:= SDFib.isc_event_counts;
  isc_get_segment     		:= SDFib.isc_get_segment;
  isc_interprete      		:= SDFib.isc_interprete;
  isc_open_blob       		:= SDFib.isc_open_blob;
  isc_open_blob2      		:= SDFib.isc_open_blob2;
  isc_prepare_transaction    	:= SDFib.isc_prepare_transaction;
  isc_prepare_transaction2    	:= SDFib.isc_prepare_transaction2;
  isc_print_sqlerror	    	:= SDFib.isc_print_sqlerror;
  isc_print_status	    	:= SDFib.isc_print_status;
  isc_put_segment     		:= SDFib.isc_put_segment;

  isc_rollback_transaction 	:= SDFib.isc_rollback_transaction;
  isc_rollback_retaining 	:= SDFib.isc_rollback_retaining;
  isc_start_multiple           	:= SDFib.isc_start_multiple;
  isc_start_transaction 	:= nil;
  isc_sqlcode      		:= SDFib.isc_sqlcode;
  isc_sql_interprete		:= SDFib.isc_sql_interprete;
  isc_transaction_info	    	:= SDFib.isc_transaction_info;

  isc_vax_integer     		:= SDFib.isc_vax_integer;
  isc_version	       		:= SDFib.isc_version;

  isc_decode_date     		:= SDFib.isc_decode_date;
  isc_encode_date     		:= SDFib.isc_encode_date;
  	// IB6 date/time functions
  isc_decode_sql_date 		:= SDFib.isc_decode_sql_date;
  isc_decode_sql_time 		:= SDFib.isc_decode_sql_time;
  isc_decode_timestamp		:= SDFib.isc_decode_timestamp;
  isc_encode_sql_date 		:= SDFib.isc_encode_sql_date;
  isc_encode_sql_time 		:= SDFib.isc_encode_sql_time;
  isc_encode_timestamp		:= SDFib.isc_encode_timestamp;
	// Security Functions
  isc_add_user	  	  	:= SDFib.isc_add_user;
  isc_delete_user	    	:= SDFib.isc_delete_user;
  isc_modify_user	    	:= SDFib.isc_modify_user;
{$ELSE}
  inherited SetApiCalls(ASqlLibModule);
{$ENDIF}
end;

{ TIFibDatabase }
function TIFibDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIFibCommand.Create( Self );
end;

procedure TIFibDatabase.AllocHandle(DBHandles: Boolean);
{$IFDEF SD_CLR}
var
  rec: TIIntConnInfo;
{$ENDIF}
begin
  inherited AllocHandle(DBHandles);
{$IFDEF SD_CLR}
  rec := TIIntConnInfo( Marshal.PtrToStructure(Handle, TypeOf(TIIntConnInfo)) );
  rec.ServerType := Ord( istFirebird );
  Marshal.StructureToPtr( rec, Handle, False );
{$ELSE}
  TIIntConnInfo(Handle^).ServerType := Ord( istFirebird );
{$ENDIF}
end;

procedure TIFibDatabase.FreeSqlLib;
begin
  SDFib.FreeSqlLib;
end;

procedure TIFibDatabase.LoadSqlLib;
begin
  SDFib.LoadSqlLib;

  FApiCalls := FibCalls;
end;

function TIFibDatabase.GetErrorClass: ESDEngineErrorClass;
begin
  Result := ESDFibError;
end;

function TIFibDatabase.GetClientVersion: LongInt;
begin
  Result := dwLoadedFileVer;
end;



initialization
  hSqlLibModule	:= 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  FibCalls 	:= TFibFunctions.Create;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
  FibCalls.Free;
end.
