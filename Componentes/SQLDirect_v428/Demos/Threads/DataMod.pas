unit DataMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, SDConsts, SDCommon, SDEngine;

type
  TdmMain = class(TDataModule)
    Database: TSDDatabase;
    Database1: TSDDatabase;
    Database2: TSDDatabase;
    qryData1: TSDQuery;
    qryData2: TSDQuery;
    procedure DatabaseLogin(Database: TSDDatabase; LoginParams: TStrings);
    procedure DataCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateTestTable;
    procedure DropTestTable;
    procedure InsertData(RowCount: Integer);
  end;

var
  dmMain: TdmMain;

implementation

uses
  InsThrd, Login;

{$R *.DFM}

{ TdmMain }
procedure TdmMain.DataCreate(Sender: TObject);
begin
  Database.Connected := True;

  with Database1 do begin
    RemoteDatabase	:= Database.RemoteDatabase;
    ServerType		:= Database.ServerType;
    LoginPrompt		:= False;
  end;
  with Database2 do begin
    RemoteDatabase	:= Database.RemoteDatabase;
    ServerType		:= Database.ServerType;
    LoginPrompt		:= False;
  end;
end;

procedure TdmMain.DatabaseLogin(Database: TSDDatabase; LoginParams: TStrings);
begin
  Application.CreateForm(TLoginDlg, LoginDlg);
  LoginDlg.AssignDbValues(Database);
  with LoginDlg do try
    edUserName.Text := LoginParams.Values[szUSERNAME];
    if ShowModal = mrOk then begin
      Database.ServerType	:= TSDServerType(cbServerType.ItemIndex);
      Database.RemoteDatabase	:= edDatabase.Text;
      LoginParams.Values[szUSERNAME]	:= edUserName.Text;
      LoginParams.Values[szPASSWORD] 	:= edPassword.Text;
    end else begin
      Application.Terminate;
      Application.ProcessMessages;      
    end;
  finally
    Free;
  end;
end;

procedure TdmMain.CreateTestTable;
var
  q: TSDQuery;
begin
  q := TSDQuery.Create(Self);
  try
    q.DatabaseName := Database.DatabaseName;
    if not Database.Connected then Database.Open;
    if Database.ServerType in [stInterbase] then
      Database.StartTransaction;
    try
      q.SQL.Clear;
      case Database.ServerType of
        stSQLBase,
        stSQLServer,
        stSybase:
          q.SQL.Add('create table TEST_THRD1(FINT integer, FSTR varchar(20), FDATE datetime)');
        stDB2, stInterbase:
          q.SQL.Add('create table TEST_THRD1(FINT integer, FSTR varchar(20), FDATE timestamp)')
      else
        q.SQL.Add('create table TEST_THRD1(FINT integer, FSTR varchar(20), FDATE date)');
      end;
      q.ExecSQL;
      q.SQL.Clear;
      if Database.ServerType in [stSQLBase, stSQLServer, stSybase] then
        q.SQL.Add('create table TEST_THRD2(FINT integer, FSTR varchar(20), FDATE datetime)')
      else if Database.ServerType in [stDB2, stInterbase] then
        q.SQL.Add('create table TEST_THRD2(FINT integer, FSTR varchar(20), FDATE timestamp)')
      else
        q.SQL.Add('create table TEST_THRD2(FINT integer, FSTR varchar(20), FDATE date)');
      q.ExecSQL;

      if Database.ServerType in [stInterbase] then
        Database.Commit;
    except
      on ESDEngineError do begin
        if Database.ServerType in [stInterbase] then
          Database.Rollback;
        raise;
      end;
    end;
  finally
    q.Free;
  end;
end;

procedure TdmMain.DropTestTable;
var
  q: TSDQuery;
begin
  q := TSDQuery.Create(Self);
  try
    q.DatabaseName := Database.DatabaseName;
    if not Database.Connected then Database.Open;

    if Database.ServerType in [stInterbase] then
      Database.StartTransaction;
    try
      q.SQL.Clear;
      q.SQL.Add('drop table TEST_THRD1');
      q.ExecSQL;
      q.SQL.Clear;
      q.SQL.Add('drop table TEST_THRD2');
      q.ExecSQL;
      q.Disconnect;

      if Database.ServerType in [stInterbase] then
        Database.Commit;
    except
      on ESDEngineError do begin
        if Database.ServerType in [stInterbase] then
          Database.Rollback;
        raise;
      end;
    end;
  finally
    q.Free;
  end;
end;

procedure TdmMain.InsertData(RowCount: Integer);
var
  T1, T2: TInsertThread;
begin
  if not Database.Connected then Database.Open;

  T1 := TInsertThread.Create;
  with T1 do begin
    Database.RemoteDatabase	:= dmMain.Database.RemoteDatabase;
    Database.ServerType 	:= dmMain.Database.ServerType;
    Database.LoginPrompt := False;
    TableName	:= 'TEST_THRD1';
    IntField	:= 'FINT';
    StrField	:= 'FSTR';
    DateField	:= 'FDATE';
    RecordCount	:= RowCount;
  end;
  T2 := TInsertThread.Create;
  with T2 do begin
    Database.RemoteDatabase	:= dmMain.Database.RemoteDatabase;
    Database.ServerType		:= dmMain.Database.ServerType;
    Database.LoginPrompt := False;
    TableName	:= 'TEST_THRD2';
    IntField	:= 'FINT';
    StrField	:= 'FSTR';
    DateField	:= 'FDATE';
    RecordCount	:= RowCount;
  end;

  T1.Resume;
  T2.Resume;
end;


end.
