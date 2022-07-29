unit InsThrd;

interface

uses
  Classes, SysUtils, SDEngine;

type
  TInsertThread = class(TThread)
  private
    { Private declarations }
    FRecordCount: Integer;
    FIntField: string;
    FStrField: string;
    FDateField: string;
    FTableName: string;
    FDatabase: TSDDatabase;
    FQuery: TSDQuery;
    procedure SetIntField(const Value: string);
    procedure SetStrField(const Value: string);
    procedure SetDateField(const Value: string);
    procedure SetTableName(const Value: string);
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property IntField: string write SetIntField;
    property StrField: string write SetStrField;
    property DateField: string write SetDateField;
    property TableName: string write SetTableName;
    property RecordCount: Integer write FRecordCount;
    property Database: TSDDatabase read FDatabase;
  end;


implementation


{ TInsertThread }
constructor TInsertThread.Create;
var
  i: Integer;
begin
  Inherited Create(True);
  FreeOnTerminate := True;

  FDatabase	:= TSDDatabase.Create(nil);
  FQuery	:= TSDQuery.Create(nil);

  for i:=0 to Session.DatabaseCount-1 do
    if Session.Databases[i] = FDatabase then begin
      FDatabase.DatabaseName := 'DB'+ IntToStr(i);
      Break
    end;
  FQuery.DatabaseName := FDatabase.DatabaseName;
end;

destructor TInsertThread.Destroy;
begin
  FQuery.Free;
  FDatabase.Free;

  Inherited;
end;

procedure TInsertThread.Execute;
var
  i: Integer;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Format('insert into %s(%s, %s, %s) values(:IntParam, :StrParam, :DateParam)', [FTableName, FIntField, FStrField, FDateField]));

  FQuery.Prepare;
  FDatabase.StartTransaction;
  try
    for i:=0 to FRecordCount-1 do begin
       with FQuery do begin
         Params[0].AsInteger	:= i;
         Params[1].AsString	:= FStrField + IntToStr(i);
         Params[2].AsDateTime	:= Now;
         ExecSQL;
       end;
       if (i <> 0) and ((i mod 100) = 0) then begin
         FDatabase.Commit;
         FDatabase.StartTransaction;         
       end;
    end;
    FDatabase.Commit;
  except;
    FDatabase.Rollback;
  end;
  FQuery.Disconnect;
end;

procedure TInsertThread.SetIntField(const Value: string);
begin
  if FIntField <> Value then
    FIntField := Value;
end;

procedure TInsertThread.SetStrField(const Value: string);
begin
  if FStrField <> Value then
    FStrField := Value;
end;

procedure TInsertThread.SetDateField(const Value: string);
begin
  if FDateField <> Value then
    FDateField := Value;
end;

procedure TInsertThread.SetTableName(const Value: string);
begin
  if FTableName <> Value then
    FTableName := Value;
end;


end.
