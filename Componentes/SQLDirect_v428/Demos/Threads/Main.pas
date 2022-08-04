unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Grids, DBGrids, SDEngine, ExtCtrls, ComCtrls;

type
  TMainFrm = class(TForm)
    dsData1: TDataSource;
    dsData2: TDataSource;
    pnlGrid: TPanel;
    grdData1: TDBGrid;
    grdData2: TDBGrid;
    pnlControl: TPanel;
    btCreateTbl: TButton;
    btDropTbl: TButton;
    btInsertData: TButton;
    btQueryData: TButton;
    lblRowCount: TLabel;
    edRowCount: TEdit;
    StatusLine: TStatusBar;
    procedure btCreateTblClick(Sender: TObject);
    procedure btDropTblClick(Sender: TObject);
    procedure btInsertDataClick(Sender: TObject);
    procedure btQueryDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ShowHint(Sender: TObject);
    procedure QueryThread1Terminate(Sender: TObject);
    procedure QueryThread2Terminate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation

uses
  DataMod;

{$R *.DFM}

procedure WaitOn;
begin
  Screen.Cursor := crHourGlass;
end;

procedure WaitOff;
begin
  Screen.Cursor := crDefault;
end;

type
  { TQueryThread }
  TQueryThread = class(TThread)
  private
    { Private declarations }
    FQuery: TSDQuery;
  protected
    procedure Execute; override;
  public
    constructor Create(AQuery: TSDQuery);
  end;

{ TQueryThread }
constructor TQueryThread.Create(AQuery: TSDQuery);
begin
  FQuery := AQuery;
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TQueryThread.Execute;
begin
  if FQuery.Active then
    FQuery.Close;
  FQuery.Open;
end;


{ TMainForm }
procedure TMainFrm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
end;

procedure TMainFrm.ShowHint(Sender: TObject);
begin
  StatusLine.SimpleText := Application.Hint;
end;

procedure TMainFrm.btCreateTblClick(Sender: TObject);
begin
  WaitOn;
  try
    dmMain.CreateTestTable;
  finally
    WaitOff;
  end;
end;

procedure TMainFrm.btDropTblClick(Sender: TObject);
begin
  WaitOn;
  try
    dmMain.DropTestTable;
  finally
    WaitOff;
  end;
end;

procedure TMainFrm.btInsertDataClick(Sender: TObject);
begin
  dmMain.InsertData( StrToIntDef(edRowCount.Text, 100) );
end;

procedure TMainFrm.QueryThread1Terminate(Sender: TObject);
begin
  dsData1.DataSet := dmMain.qryData1;
end;

procedure TMainFrm.QueryThread2Terminate(Sender: TObject);
begin
  dsData2.DataSet := dmMain.qryData2;
end;

procedure TMainFrm.btQueryDataClick(Sender: TObject);
begin
  dsData1.DataSet := nil;
  dsData2.DataSet := nil;

  with TQueryThread.Create(dmMain.qryData1) do
    OnTerminate := QueryThread1Terminate;
  with TQueryThread.Create(dmMain.qryData2) do
    OnTerminate := QueryThread2Terminate;
end;


end.
