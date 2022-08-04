
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       SQLDirect SQLBase Server    			}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDCsbSrv {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,
{$IFDEF SD_CLR}
  System.Text, System.Runtime.InteropServices,
{$ENDIF}
  SDCommon, SDEngine, SDConsts, SDCsb, SDSrvLog;

type
  TSDSQLBaseServer = class;

	{ Server Cursor type }
  TSDSrvLoginEvent = procedure(Server: TSDSQLBaseServer; LoginParams: TStrings) of object;

  { TSDSQLBaseServer }
  TSDSQLBaseServer = class(TComponent)
  private
    FHandle: TSDPtr;
    FLoginPrompt: Boolean;
    FServerName: string;
    FStreamedConnected: Boolean;
    FParams: TStrings;
    FOnLogin: TSDSrvLoginEvent;
    procedure CheckActive;
    procedure CheckInactive;
    procedure CheckServerName;
    procedure Login(LoginParams: TStrings);
    function GetConnected: Boolean;
    function GetSrvHandle: TCSBSrvCursor;    
    procedure SetConnected(Value: Boolean);
    procedure SetParams(Value: TStrings);
    procedure SetServerName(const Value: string);
  protected
    procedure ICsbCheck(Status: TSDEResult);
    procedure ICsbLoadLib;
    procedure ICsbFreeLib;
    procedure ICsbAbortProcess(ProcessNo: Integer);
    procedure ICsbCancelRequest(CursorNo: Integer);
    procedure ICsbConnect(const AServerName, APassword: string);
    procedure ICsbCreateDatabase(const DBName: string);
    procedure ICsbDeleteDatabase(const DBName: string);
    procedure ICsbDisconnect;
    procedure ICsbGetDatabaseNames(DBNames: TStrings);
    procedure ICsbInstallDatabase(const DBName: string);
    procedure ICsbDeinstallDatabase(const DBName: string);
    procedure ICsbServerShutdown;
    procedure ICsbServerTerminate;

    procedure ICsbBackupDatabase(const DBName, BackupDir: string; Over: Boolean);
    procedure ICsbRestoreDatabase(const DBName, BackupDir: string; Over: Boolean);

    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AbortProcess(ProcessNo: Integer);
    procedure BackupDatabase(const DBName, BackupDir: string; Over: Boolean);
    procedure CancelRequest(CursorNo: Integer);
    procedure Close;
    procedure CreateDatabase(const DBName: string);
    procedure DeinstallDatabase(const DBName: string);
    procedure DeleteDatabase(const DBName: string);
    procedure GetDatabaseNames(DBNames: TStrings);
    procedure InstallDatabase(const DBName: string);
    procedure Open;
    procedure RestoreDatabase(const DBName, BackupDir: string; Over: Boolean);
    procedure Shutdown;
    procedure Terminate;
    property SrvHandle: TCSBSrvCursor read GetSrvHandle;
	//load , unload ?
  published
    property Connected: Boolean read GetConnected write SetConnected default False;
    property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt default True;
    property Params: TStrings read FParams write SetParams;
    property ServerName: string read FServerName write SetServerName;
    property OnLogin: TSDSrvLoginEvent read FOnLogin write FOnLogin;
  end;

implementation

resourcestring
  SErrInvalidSrvHandle 	= 'Invalid server handle';


{ TSDSQLBaseServer }
constructor TSDSQLBaseServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FHandle := nil;
  FLoginPrompt := True;
  FParams := TStringList.Create;
end;

destructor TSDSQLBaseServer.Destroy;
begin
  Close;

  FParams.Free;

  inherited Destroy;
end;

procedure TSDSQLBaseServer.CheckActive;
begin
  if FHandle = nil then DatabaseError(SServerClosed);
end;

procedure TSDSQLBaseServer.CheckInactive;
begin
  if FHandle <> nil then DatabaseError(SServerOpen);
end;

procedure TSDSQLBaseServer.CheckServerName;
begin
  if FServerName = '' then
    DatabaseError(SServerNameMissing);
end;

procedure TSDSQLBaseServer.Loaded;
begin
  inherited Loaded;

  try
    if FStreamedConnected then
      Open;
  except
    if csDesigning in ComponentState then
      Application.HandleException(Self)
    else
      raise;
  end;
end;

procedure TSDSQLBaseServer.GetDatabaseNames(DBNames: TStrings);
begin
  CheckActive;

  if Assigned(DBNames) then
    ICsbGetDatabaseNames(DBNames);
end;

function TSDSQLBaseServer.GetConnected: Boolean;
begin
  Result := FHandle <> nil;
end;

procedure TSDSQLBaseServer.SetConnected(Value: Boolean);
begin
  if csReading in ComponentState then
    FStreamedConnected := Value
  else
    if Value
    then Open
    else Close;
end;

procedure TSDSQLBaseServer.SetParams(Value: TStrings);
begin
  FParams.Assign(Value);
end;

procedure TSDSQLBaseServer.SetServerName(const Value: string);
begin
  if csReading in ComponentState then
    FServerName := Value
  else
    if FServerName <> Value then begin
      CheckInactive;
      FServerName := Value;
    end;
end;

procedure TSDSQLBaseServer.Login(LoginParams: TStrings);
var
  Password: string;
  LoginProc: TSDSrvLoginEvent;
begin
  LoginProc := OnLogin;
  if Assigned(LoginProc) then
    LoginProc(Self, LoginParams)
  else begin
    if not SrvLoginDialog(ServerName, Password) then
      DatabaseErrorFmt(SServerLoginError, [ServerName]);
    LoginParams.Values[szPASSWORD] := Password;
  end;
end;

procedure TSDSQLBaseServer.Open;
var
  Password: string;
  LoginParams: TStrings;
begin
  if Connected then
    Exit;
  CheckServerName;

  if LoginPrompt then begin
    LoginParams := TStringList.Create;
    try
      Login(LoginParams);
      Password := LoginParams.Values[szPASSWORD];
    finally
      LoginParams.Free;
    end;
  end else
    Password := FParams.Values[szPASSWORD];

  SetBusyState;
  try
    ICsbLoadLib;
    ICsbConnect(ServerName, Password);
  finally
    ResetBusyState;
  end;
end;

procedure TSDSQLBaseServer.Close;
begin
  if Connected then begin
    SetBusyState;
    try
      ICsbDisconnect;
      ICsbFreeLib;
    finally
      ResetBusyState;
    end;
  end;
end;

procedure TSDSQLBaseServer.AbortProcess(ProcessNo: Integer);
begin
  CheckActive;

  ICsbAbortProcess(ProcessNo);
end;

procedure TSDSQLBaseServer.CancelRequest(CursorNo: Integer);
begin
  CheckActive;

  ICsbCancelRequest(CursorNo);
end;

procedure TSDSQLBaseServer.CreateDatabase(const DBName: string);
begin
  CheckActive;

  SetBusyState;
  try
    ICsbCreateDatabase(DBName);
  finally
    ResetBusyState;
  end;
end;

procedure TSDSQLBaseServer.DeleteDatabase(const DBName: string);
begin
  CheckActive;

  SetBusyState;
  try
    ICsbDeleteDatabase(DBName);
  finally
    ResetBusyState;
  end;
end;

procedure TSDSQLBaseServer.InstallDatabase(const DBName: string);
begin
  CheckActive;

  SetBusyState;
  try
    ICsbInstallDatabase(DBName);
  finally
    ResetBusyState;
  end;
end;

procedure TSDSQLBaseServer.DeinstallDatabase(const DBName: string);
begin
  CheckActive;

  SetBusyState;
  try
    ICsbDeinstallDatabase(DBName);
  finally
    ResetBusyState;
  end;
end;

{ Makes online backup a database file and log files needed for restore all committed trabsaction }
procedure TSDSQLBaseServer.BackupDatabase(const DBName, BackupDir: string; Over: Boolean);
begin
  CheckActive;

  ICsbBackupDatabase( DBName, BackupDir, Over );
end;

{ Restores a database file and it's log files }
procedure TSDSQLBaseServer.RestoreDatabase(const DBName, BackupDir: string; Over: Boolean);
begin
  CheckActive;

  ICsbRestoreDatabase( DBName, BackupDir, Over );
end;

procedure TSDSQLBaseServer.Shutdown;
begin
  CheckActive;

  ICsbServerShutdown;
end;

procedure TSDSQLBaseServer.Terminate;
begin
  CheckActive;

  ICsbServerTerminate;
end;

{-----------------------------------------------------------------------------}
{				SQL-servers C/API calls			      }
procedure TSDSQLBaseServer.ICsbCheck(Status: TSDEResult);
begin
  if Status = 0 then
    Exit;
  ResetBusyState;
  CSBError(0, Status, -1);
end;

procedure TSDSQLBaseServer.ICsbLoadLib;
begin
  SDCsb.LoadSqlLib;
end;

procedure TSDSQLBaseServer.ICsbFreeLib;
begin
  SDCsb.FreeSqlLib;
end;

function TSDSQLBaseServer.GetSrvHandle: TCSBSrvCursor;
begin
  if not Assigned(FHandle) then
    DatabaseError(SErrInvalidSrvHandle);
{$IFDEF SD_CLR}
  Result := TCSBSrvCursor( Marshal.PtrToStructure( FHandle, TypeOf(TCSBSrvCursor) ) );
{$ELSE}
  Result := TCSBSrvCursor(FHandle^);
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbAbortProcess(ProcessNo: Integer);
begin
  ICsbCheck( SqlSab(SrvHandle, ProcessNo) );
end;

procedure TSDSQLBaseServer.ICsbCancelRequest(CursorNo: Integer);
begin
  ICsbCheck( SqlCdr(SrvHandle, CursorNo) );
end;

procedure TSDSQLBaseServer.ICsbConnect(const AServerName, APassword: string);
var
  h: TCSBSrvCursor;
  szSrv, szPwd: TSDCharPtr;
begin
  try
{$IFDEF SD_CLR}
    szSrv := Marshal.StringToHGlobalAnsi(AServerName);
    szPwd := Marshal.StringToHGlobalAnsi(APassword);
    try
{$ELSE}
    szSrv := PChar(AServerName);
    szPwd := PChar(APassword);
{$ENDIF}
    ICsbCheck( SqlCsv(h, szSrv, szPwd) );
    FHandle := SafeReallocMem( nil, SizeOf(TCSBSrvCursor) );
{$IFDEF SD_CLR}
      HelperMemWriteInt16( FHandle, 0, h );
    finally
      if Assigned( szSrv ) then Marshal.FreeHGlobal( szSrv );
      if Assigned( szPwd ) then Marshal.FreeHGlobal( szPwd );
    end;
{$ELSE}
    TCSBSrvCursor(FHandle^) := h;
{$ENDIF}
  except
    if Assigned(FHandle) then
      FHandle := SafeReallocMem(FHandle, 0);
    raise;
  end;
end;

procedure TSDSQLBaseServer.ICsbDisconnect;
begin
  if FHandle <> nil then begin
    ICsbCheck( SqlDsv( SrvHandle ) );
    FHandle := SafeReallocMem( FHandle, 0 );
  end;
end;

procedure TSDSQLBaseServer.ICsbServerShutdown;
begin
  ICsbCheck( SqlSds( SrvHandle, 1 ) );
end;

procedure TSDSQLBaseServer.ICsbServerTerminate;
begin
  ICsbCheck( SqlStm( SrvHandle ) );

  FHandle := SafeReallocMem( FHandle, 0 );
end;

procedure TSDSQLBaseServer.ICsbCreateDatabase(const DBName: string);
var
  szDb: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szDb := Marshal.StringToHGlobalAnsi( DBName );
  try
{$ELSE}
  szDb := PChar( DBName );
{$ENDIF}
  ICsbCheck( SqlCre(SrvHandle, szDb, 0) );
{$IFDEF SD_CLR}
  finally
    if Assigned( szDb ) then Marshal.FreeHGlobal( szDb );
  end;
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbDeleteDatabase(const DBName: string);
var
  szDb: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szDb := Marshal.StringToHGlobalAnsi( DBName );
  try
{$ELSE}
  szDb := PChar( DBName );
{$ENDIF}
  ICsbCheck( SqlDel(SrvHandle, szDb, 0) );
{$IFDEF SD_CLR}
  finally
    if Assigned( szDb ) then Marshal.FreeHGlobal( szDb );
  end;
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbInstallDatabase(const DBName: string);
var
  szDb: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szDb := Marshal.StringToHGlobalAnsi( DBName );
  try
{$ELSE}
  szDb := PChar( DBName );
{$ENDIF}
  ICsbCheck( SqlInd(SrvHandle, szDb, 0) );
{$IFDEF SD_CLR}
  finally
    if Assigned( szDb ) then Marshal.FreeHGlobal( szDb );
  end;
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbDeinstallDatabase(const DBName: string);
var
  szDb: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szDb := Marshal.StringToHGlobalAnsi( DBName );
  try
{$ELSE}
  szDb := PChar( DBName );
{$ENDIF}
  ICsbCheck( SqlDed(SrvHandle, szDb, 0) );
{$IFDEF SD_CLR}
  finally
    if Assigned( szDb ) then Marshal.FreeHGlobal( szDb );
  end;
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbBackupDatabase(const DBName, BackupDir: string; Over: Boolean);
var
  szDb, szDir: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szDb := Marshal.StringToHGlobalAnsi(DBName);
  szDir:= Marshal.StringToHGlobalAnsi(BackupDir);
  try
{$ELSE}
  szDb := PChar(DBName);
  szDir:= PChar(BackupDir);
{$ENDIF}
	// backup on local(client) node (local=1)
  ICsbCheck( SqlBss(SrvHandle, szDb, 0, szDir, 0, 1, Byte(Over)) );

{$IFDEF SD_CLR}
  finally
    if Assigned( szDb ) then Marshal.FreeHGlobal(szDb);
    if Assigned( szDir) then Marshal.FreeHGlobal(szDir);
  end;
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbRestoreDatabase(const DBName, BackupDir: string; Over: Boolean);
var
  szDb, szDir: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szDb := Marshal.StringToHGlobalAnsi(DBName);
  szDir:= Marshal.StringToHGlobalAnsi(BackupDir);
  try
{$ELSE}
  szDb := PChar(DBName);
  szDir:= PChar(BackupDir);
{$ENDIF}
	// restore from local(client) node (local=1)
  ICsbCheck( SqlRss(SrvHandle, szDb, 0, szDir, 0, 1, Byte(Over)) );
{$IFDEF SD_CLR}
  finally
    if Assigned( szDb ) then Marshal.FreeHGlobal(szDb);
    if Assigned( szDir) then Marshal.FreeHGlobal(szDir);
  end;
{$ENDIF}
end;

procedure TSDSQLBaseServer.ICsbGetDatabaseNames(DBNames: TStrings);
var
  szDbNames, szStr, szSrv: TSDCharPtr;
  MaxLen, Pos: Integer;
begin
  DBNames.Clear;

  MaxLen := 1000;
  szDbNames := SafeReallocMem( nil, MaxLen );
  DBNames.BeginUpdate;
  try
{$IFDEF SD_CLR}
    szSrv := Marshal.StringToHGlobalAnsi(FServerName);
{$ELSE}
    szSrv := PChar(FServerName);
{$ENDIF}
    ICsbCheck( SqlDbn(szSrv, szDbNames, MaxLen) );

    Pos := 0;
    repeat
      if Pos > 0 then
        Inc(Pos);
      szStr := IncPtr(szDbNames, Pos);	// PChar(Integer(szDbNames) + Pos);
      DBNames.Add( HelperPtrToString(szStr) );
      repeat
       Inc(Pos);
      until HelperMemReadByte( szDbNames, Pos ) = 0;	// szDbNames[Pos]=#0;
    until HelperMemReadByte( szDbNames, Pos+1 ) = 0;	// szDbNames[Pos+1]=#0;

  finally
    DBNames.EndUpdate;
    if Assigned( szDbNames ) then SafeReallocMem(nil, 0);
{$IFDEF SD_CLR}
    if Assigned( szSrv ) then Marshal.FreeHGlobal(szSrv);
{$ENDIF}
  end;
end;

end.
