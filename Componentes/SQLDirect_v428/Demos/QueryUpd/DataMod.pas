unit DataMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, SDCommon, SDEngine;

type
  TdmData = class(TDataModule)
    Database: TSDDatabase;
    qryQuery: TSDQuery;
    qryPersons: TSDQuery;
    updPersons: TSDUpdateSQL;
    procedure DatabaseLogin(Database: TSDDatabase; LoginParams: TStrings);
    procedure qryPersonsUpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure qryPersonsUpdateRecord1(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure qryPersonsUpdateRecord2(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure qryPersonsAfterInsert(DataSet: TDataSet);
    procedure qryPersonsAfterOpen(DataSet: TDataSet);
    procedure dmDataCreate(Sender: TObject);
    procedure dmDataDestroy(Sender: TObject);
    procedure qryPersonsFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
  public
    procedure CreateTestTable;
    procedure DropTestTable;
  end;

var
  dmData: TdmData;

implementation

uses
  Login;

{$R *.DFM}

{ TdmData }
procedure TdmData.CreateTestTable;
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
        stDB2:
          q.SQL.Add('create table TEST_PERSON(ID integer, NAME char(20), SURNAME char(20), BIRTH_DATE date, NOTE clob(2G) not logged)');
        stInformix:
          q.SQL.Add('create table TEST_PERSON(ID integer, NAME char(20), SURNAME char(20), BIRTH_DATE date, NOTE text)');
        stInterbase:
          q.SQL.Add('create table TEST_PERSON(ID integer, NAME char(20), SURNAME char(20), BIRTH_DATE timestamp, NOTE blob)');
        stSQLServer, stSybase:
          q.SQL.Add('create table TEST_PERSON(ID integer, NAME char(20), SURNAME char(20), BIRTH_DATE datetime, NOTE text null)');
      else
        if (Database.ServerType = stOracle) and (Database.ServerMajor >= 8) and (Database.ClientMajor >= 8) then
          q.SQL.Add('create table TEST_PERSON(ID integer, NAME char(20), SURNAME char(20), BIRTH_DATE date, NOTE clob)')
        else
          q.SQL.Add('create table TEST_PERSON(ID integer, NAME char(20), SURNAME char(20), BIRTH_DATE date, NOTE long)');
      end;
      q.ExecSQL;
      q.SQL.Clear;
      q.SQL.Add('create unique index PKTEST_PERSON on TEST_PERSON(ID)');
      q.ExecSQL;
      q.SQL.Clear;
      q.SQL.Add('create index AK1TEST_PERSON on TEST_PERSON(SURNAME)');
      q.ExecSQL;
      q.SQL.Clear;
      q.SQL.Add('create index AK2TEST_PERSON on TEST_PERSON(NAME)');
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

procedure TdmData.DropTestTable;
var
  q: TSDQuery;
begin
  q := TSDQuery.Create(Self);
  try
    q.DatabaseName := Database.DatabaseName;
    if not Database.Connected then Database.Open;

    qryQuery.Disconnect;
    qryPersons.Disconnect;
    updPersons.Query[ukModify].Disconnect;
    updPersons.Query[ukInsert].Disconnect;
    updPersons.Query[ukDelete].Disconnect;

    if Database.ServerType in [stInterbase] then
      Database.StartTransaction;
    try
      q.SQL.Clear;
      q.SQL.Add('drop table TEST_PERSON');
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

procedure TdmData.dmDataCreate(Sender: TObject);
begin
  Database.Open;
end;

procedure TdmData.dmDataDestroy(Sender: TObject);
begin
  Database.Close;
end;

procedure TdmData.DatabaseLogin(Database: TSDDatabase; LoginParams: TStrings);
begin
  Application.CreateForm(TLoginDlg, LoginDlg);
  LoginDlg.AssignDbValues(Database);
  with LoginDlg do try
    edUserName.Text := LoginParams.Values['USER NAME'];
    if ShowModal = mrOk then begin
      Database.ServerType	:= TSDServerType(cbServerType.ItemIndex);
      Database.RemoteDatabase	:= edDatabase.Text;
      LoginParams.Values['USER NAME']	:= edUserName.Text;
      LoginParams.Values['PASSWORD'] 	:= edPassword.Text;
    end else begin
      Application.Terminate;
      Application.ProcessMessages;
    end;
  finally
    Free;
  end;
end;

procedure TdmData.qryPersonsAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('NOTE').Required := False;
end;

procedure TdmData.qryPersonsAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID').AsInteger := 0;
end;
                                            
{ It is necessary to set OnUpdateError for avoid 'Update fail' error }
procedure TdmData.qryPersonsUpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  UpdateAction := uaAbort;
end;

procedure TdmData.qryPersonsUpdateRecord1(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
var
  q: TSDQuery;
begin
  if UpdateKind = ukInsert then begin
    q := TSDQuery.Create(Self);
    try
      q.DatabaseName := Database.DatabaseName;
      q.SQL.Add('select MAX(ID)+1 from TEST_PERSON');
      q.Open;
      DataSet.Edit;
      DataSet.FieldByName('ID').AsInteger := q.Fields[0].AsInteger;
      DataSet.Post;
      q.Close;
    finally
      q.Free;
    end;
  end;
  updPersons.Apply(UpdateKind);
  UpdateAction := uaApplied;
end;

{ Example of the parameter's changing before apply }
procedure TdmData.qryPersonsUpdateRecord2(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
var
  q: TSDQuery;
begin
  if UpdateKind = ukInsert then begin
    q := TSDQuery.Create(Self);
    try
      q.DatabaseName := Database.DatabaseName;
      q.SQL.Add('select MAX(ID)+1 from TEST_PERSON');
      q.Open;
      DataSet.Edit;
      DataSet.FieldByName('ID').AsInteger := q.Fields[0].AsInteger;
      DataSet.Post;
      q.Close;
    finally
      q.Free;
    end;
  end;
	// set new value for the bind parameters
  updPersons.SetParams(UpdateKind);
  q := updPersons.Query[UpdateKind];	// get query, which will update database
// change BIRTH_DATE parameter by format string
  q.ParamByName('BIRTH_DATE').AsString := FormatDateTime( 'mm-dd-yyyy hh:nn:ss', q.ParamByName('BIRTH_DATE').AsDateTime );
// in onther case
//  q.ParamByName('BIRTH_DATE').AsString := FormatDateTime( 'dd.mm.yyyy hh:nn:ss', q.ParamByName('BIRTH_DATE').AsDateTime );
	// execute update statement
  updPersons.ExecSQL(UpdateKind);
  UpdateAction := uaApplied;
end;

procedure TdmData.qryPersonsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := DataSet.FieldByName('ID').AsInteger > 5;
end;


end.
