{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{              Database Connection Component              }
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

unit ZConnection;

interface

{$I ZComponent.inc}

uses
  SysUtils, Classes, ZDbcIntfs, DB, ZCompatibility,
{$IFNDEF LINUX}
  ZDbcDbLib,
  ZDbcAdo,
{$ENDIF}
  ZDbcMySql, ZDbcPostgreSql, ZDbcInterbase6;

type

  {** Represents a component which wraps a connection to database. }
  TZConnection = class(TComponent)
  protected
    FProtocol: string;
    FHostName: string;
    FPort: Integer;
    FDatabase: string;
    FUser: string;
    FPassword: string;
    FCatalog: string;
    FProperties: TStrings;
    FAutoCommit: Boolean;
    FReadOnly: Boolean;
    FTransactIsolationLevel: TZTransactIsolationLevel;
    FConnection: IZConnection;
    FDatasets: TList;
    FLoginPrompt: Boolean;
    FStreamedConnected: Boolean;
    FExplicitTransactionCounter: Integer;
    FSQLHourGlass: Boolean;

    FBeforeConnect: TNotifyEvent;
    FBeforeDisconnect: TNotifyEvent;
    FAfterDisconnect: TNotifyEvent;
    FAfterConnect: TNotifyEvent;
    FOnCommit: TNotifyEvent;
    FOnRollback: TNotifyEvent;
    FOnLogin: TLoginEvent;

    function GetConnected: Boolean;
    procedure SetConnected(Value: Boolean);
    procedure SetProperties(Value: TStrings);
    procedure SetTransactIsolationLevel(Value: TZTransactIsolationLevel);
    procedure SetAutoCommit(Value: Boolean);

    procedure DoBeforeConnect;
    procedure DoAfterConnect;
    procedure DoBeforeDisconnect;
    procedure DoAfterDisconnect;
    procedure DoCommit;
    procedure DoRollback;

    procedure CloseAllDataSets;
    procedure UnregisterAllDataSets;

    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Loaded; override;

    property StreamedConnected: Boolean read FStreamedConnected write FStreamedConnected;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Connect; virtual;
    procedure Disconnect; virtual;

    procedure StartTransaction; virtual;
    procedure Commit; virtual;
    procedure Rollback; virtual;

    procedure RegisterDataSet(DataSet: TDataset);
    procedure UnregisterDataSet(DataSet: TDataset);

    property DbcConnection: IZConnection read FConnection;

    procedure ShowSQLHourGlass;
    procedure HideSQLHourGlass;

  published
    property Protocol: string read FProtocol write FProtocol;
    property HostName: string read FHostName write FHostName;
    property Port: Integer read FPort write FPort;
    property Database: string read FDatabase write FDatabase;
    property User: string read FUser write FUser;
    property Password: string read FPassword write FPassword;
    property Catalog: string read FCatalog write FCatalog;
    property Properties: TStrings read FProperties write SetProperties;
    property AutoCommit: Boolean read FAutoCommit write SetAutoCommit;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property TransactIsolationLevel: TZTransactIsolationLevel
      read FTransactIsolationLevel write SetTransactIsolationLevel;
    property Connected: Boolean read GetConnected write SetConnected;
    property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt
      default False;

    property BeforeConnect: TNotifyEvent
      read FBeforeConnect write FBeforeConnect;
    property AfterConnect: TNotifyEvent
      read FAfterConnect write FAfterConnect;
    property BeforeDisconnect: TNotifyEvent
      read FBeforeDisconnect write FBeforeDisconnect;
    property AfterDisconnect: TNotifyEvent
      read FAfterDisconnect write FAfterDisconnect;
    property SQLHourGlass: Boolean read FSQLHourGlass write FSQLHourGlass;
    property OnCommit: TNotifyEvent read FOnCommit write FOnCommit;
    property OnRollback: TNotifyEvent read FOnRollback write FOnRollback;
    property OnLogin: TLoginEvent read FOnLogin write FOnLogin;
  end;

implementation

uses ZMessages, ZAbstractRODataset;

var
  SqlHourGlassLock: Integer;
  CursorBackup: TDBScreenCursor;

{ TZConnection }

{**
  Constructs this component and assignes the main properties.
  @param AOwner an owner component.
}
constructor TZConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAutoCommit := True;
  FReadOnly := True;
  FTransactIsolationLevel := tiNone;
  FConnection := nil;
  FProperties := TStringList.Create;
  FDatasets := TList.Create;
  FLoginPrompt := False;
end;

{**
  Destroys this component and cleanups the memory.
}
destructor TZConnection.Destroy;
begin
  Disconnect;
  UnregisterAllDataSets;
  FProperties.Free;
  FDatasets.Free;
  inherited Destroy;
end;

{**
  This methode is required to support proper component initialization.
  Without it, the connection can start connecting before every property is loaded!
}
procedure TZConnection.Loaded;
begin
  inherited Loaded;
  try
    if FStreamedConnected then SetConnected(True);
  except
    if csDesigning in ComponentState then
    {$IFNDEF VER130BELOW}
      if Assigned(Classes.ApplicationHandleException) then
        Classes.ApplicationHandleException(ExceptObject)
      else
    {$ENDIF}  
        ShowException(ExceptObject, ExceptAddr)
    else
      raise;
  end;
end;

{**
  Gets an open connection flag.
  @return <code>True</code> if the connection is open
    or <code>False</code> otherwise.
}
function TZConnection.GetConnected: Boolean;
begin
  Result := (FConnection <> nil) and not FConnection.IsClosed;
end;

{**
  Sets a new open connection flag.
  @param Value <code>True</code> to open the connection
    and <code>False</code> to close it.
}
procedure TZConnection.SetConnected(Value: Boolean);
begin
  if (csReading in ComponentState) and Value then
    FStreamedConnected := True
  else
  begin
    if Value <> GetConnected then
    begin
      if Value then Connect
      else Disconnect;
    end;
  end;
end;

{**
  Sets a new connection properties.
  @param Value a list with new connection properties.
}
procedure TZConnection.SetProperties(Value: TStrings);
begin
  if Value <> nil then
    FProperties.Text := Value.Text
  else FProperties.Clear;
end;

{**
  Sets autocommit flag.
  @param Value <code>True</code> to turn autocommit on.
}
procedure TZConnection.SetAutoCommit(Value: Boolean);
begin
  if FAutoCommit <> Value then
  begin
    if FExplicitTransactionCounter > 0 then
      raise Exception.Create(SInvalidOperationInTrans);
    FAutoCommit := Value;
    ShowSqlhourGlass;
    try
      if FConnection <> nil then
        FConnection.SetAutoCommit(Value);
    finally
      HideSqlHourGlass
    end;
  end;
end;

{**
  Sets transact isolation level.
  @param Value a transact isolation level.
}
procedure TZConnection.SetTransactIsolationLevel(
  Value: TZTransactIsolationLevel);
begin
  if FTransactIsolationLevel <> Value then
  begin
    FTransactIsolationLevel := Value;
    ShowSqlhourGlass;
    try
      if FConnection <> nil then
        FConnection.SetTransactionIsolation(Value);
    finally
      HideSqlHourGlass
    end;
  end;
end;

{**
  Fires an event before connection open
}
procedure TZConnection.DoBeforeConnect;
begin
  if Assigned(FBeforeConnect) then
    FBeforeConnect(Self);
end;

{**
  Fires an event after connection open
}
procedure TZConnection.DoAfterConnect;
begin
  if Assigned(FAfterConnect) then
    FAfterConnect(Self);
end;

{**
  Fires an event before connection close
}
procedure TZConnection.DoBeforeDisconnect;
begin
  if Assigned(FBeforeDisconnect) then
    FBeforeDisconnect(Self);
end;

{**
  Fires an event after connection close
}
procedure TZConnection.DoAfterDisconnect;
begin
  if Assigned(FAfterDisconnect) then
    FAfterDisconnect(Self);
end;

{**
  Fires an event after transaction commit
}
procedure TZConnection.DoCommit;
begin
  if Assigned(FOnCommit) then
    FOnCommit(Self);
end;

{**
  Fires an event after transaction rollback
}
procedure TZConnection.DoRollback;
begin
  if Assigned(FOnRollback) then
    FOnRollback(Self);
end;

{**
  Establish a connection with database.
}
procedure TZConnection.Connect;
var
  Url: string;
//Local variables declared in order to preserve the original property value
//and to avoid the storage of password
  Username, Password: string;
begin
  if FConnection = nil then
  begin
    try
      DoBeforeConnect;
    except
//This is here to support aborting the Connection in BeforeConnect event without fatal errors
      on E: EAbort do
        Exit;
    end;

    UserName := FUser;
    Password := FPassword;

    if FLoginPrompt then
    begin
      { Defines user name }
      if UserName = '' then
        UserName := FProperties.Values['UID'];
      if UserName = '' then
        UserName := FProperties.Values['username'];

      { Defines user password }
      if Password = '' then
        Password := FProperties.Values['PWD'];
      if Password = '' then
        Password := FProperties.Values['password'];

      if Assigned(FOnLogin) then
        FOnLogin(Self, UserName, Password)
      else
        if Assigned(LoginDialogProc) then
        begin
          if not LoginDialogProc(FDatabase, UserName, Password) then
            Exit;
        end
        else raise Exception.Create(SLoginPromptFailure);
    end;

    if Port <> 0 then
    begin
      Url := Format('zdbc:%s://%s:%d/%s?UID=%s;PWD=%s', [FProtocol, FHostName,
        FPort, FDatabase, UserName, Password]);
    end
    else
    begin
      Url := Format('zdbc:%s://%s/%s?UID=%s;PWD=%s', [FProtocol, FHostName,
        FDatabase, UserName, Password]);
    end;

    ShowSqlHourGlass;
    try
      FConnection := DriverManager.GetConnectionWithParams(Url, FProperties);
      try
        with FConnection do
        begin
          SetAutoCommit(FAutoCommit);
          SetReadOnly(FReadOnly);
          SetCatalog(FCatalog);
          SetTransactionIsolation(FTransactIsolationLevel);
          Open;
        end;
      except
        FConnection := nil;
        raise;
      end;
    finally
      HideSqlHourGlass;
    end;

    if not FConnection.IsClosed then
      DoAfterConnect;
  end;
end;

{**
  Closes and removes the connection with database
}
procedure TZConnection.Disconnect;
begin
  if FConnection <> nil then
  begin
    DoBeforeDisconnect;

    ShowSqlHourGlass;
    try
      CloseAllDataSets;
      FConnection.Close;
      FConnection := nil;
    finally
      HideSqlHourGlass;
    end;

    DoAfterDisconnect;
  end;
end;

{**
  Commits the current transaction.
}
procedure TZConnection.StartTransaction;
begin
  if not FAutoCommit and (FExplicitTransactionCounter = 0) then
    DatabaseError('Invalid operation in non AutoCommit mode.');

  if FExplicitTransactionCounter = 0 then
    AutoCommit := False;
  Inc(FExplicitTransactionCounter);
end;

{**
  Commits the current transaction.
}
procedure TZConnection.Commit;
var
  ExplicitTran: Boolean;
begin
  if FConnection = nil then
    DatabaseError('Connection is not open yet.');
  if FAutoCommit then
    DatabaseError('Invalid operation in AutoCommit mode.');

  ExplicitTran := FExplicitTransactionCounter > 0;
  if FExplicitTransactionCounter < 2 then//when 0 then AutoCommit was turned off, when 1 StartTransaction was used
  begin
    ShowSqlHourGlass;
    try
      try
        FConnection.Commit;
      finally
        FExplicitTransactionCounter := 0;
        if ExplicitTran then
          AutoCommit := True;
      end;
    finally
      HideSqlHourGlass;
    end;
    DoCommit;
  end
  else
    Dec(FExplicitTransactionCounter);
end;

{**
  Rollbacks the current transaction.
}
procedure TZConnection.Rollback;
var
  ExplicitTran: Boolean;
begin
  if FConnection = nil then
    DatabaseError('Connection is not open yet.');
  if FAutoCommit then
    DatabaseError('Invalid operation in AutoCommit mode.');

  ExplicitTran := FExplicitTransactionCounter > 0;
  if FExplicitTransactionCounter < 2 then//when 0 then AutoCommit was turned off, when 1 StartTransaction was used
  begin
    ShowSqlHourGlass;
    try
      try
        FConnection.RollBack;
      finally
        FExplicitTransactionCounter := 0;
        if ExplicitTran then
          AutoCommit := True;
      end;
    finally
      HideSqlHourGlass;
    end;
    DoRollback;
  end
  else
    Dec(FExplicitTransactionCounter);
end;

{**
  Processes component notifications.
  @param AComponent a changed component object.
  @param Operation a component operation code.
}
procedure TZConnection.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent is TDataset) then
  begin
    UnregisterDataSet(TDataset(AComponent));
  end;
end;

{**
  Closes all registered datasets.
}
procedure TZConnection.CloseAllDataSets;
var
  I: Integer;
  Current: TDataset;
begin
  for I := 0 to FDatasets.Count - 1 do
  begin
    Current := TDataset(FDatasets[I]);
    try
      Current.Close;
    except
    end;
  end;
end;

{**
  Registers a new dataset object.
  @param DataSet a new dataset to be registered.
}
procedure TZConnection.RegisterDataSet(DataSet: TDataset);
begin
  FDatasets.Add(DataSet);
end;

{**
  Unregisters a new dataset object.
  @param DataSet a new dataset to be unregistered.
}
procedure TZConnection.UnregisterDataSet(DataSet: TDataset);
begin
  FDatasets.Remove(DataSet);
end;

{**
  Unregisters a new dataset object.
  @param DataSet a new dataset to be unregistered.
}
procedure TZConnection.UnregisterAllDataSets;
var
  I: Integer;
  Current: TZAbstractRODataset;
begin
  for I := FDatasets.Count - 1 downto 0 do
  begin
    Current := TZAbstractRODataset(FDatasets[I]);
    FDatasets.Remove(Current);
    try
      Current.Connection := nil;
    except
    end;
  end;
end;

{**
  Turn on sql hourglass cursor
}
procedure TZConnection.ShowSQLHourGlass;
begin
  if not FSqlHourGlass then
    Exit;

  if SqlHourGlassLock = 0 then
  begin
    if Assigned(DBScreen) then
    begin
      CursorBackup := DBScreen.Cursor;
      if CursorBackup <> dcrOther then
        DBScreen.Cursor := dcrSQLWait;
    end;
  end;
  Inc(SqlHourGlassLock);
end;

{**
  Turn off sql hourglass cursor
}
procedure TZConnection.HideSQLHourGlass;
begin
  if not FSqlHourGlass then
    Exit;

  if SqlHourGlassLock > 0 then
    Dec(SqlHourGlassLock);
  if SqlHourGlassLock = 0 then
  begin
    if CursorBackup <> dcrOther then
      if Assigned(DBScreen) then
        DBScreen.Cursor := CursorBackup;
  end;
end;

initialization
  SqlHourGlassLock := 0;
end.
