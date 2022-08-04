unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TMainFrm = class(TForm)
    btQueryTest: TButton;
    StatusLine: TStatusBar;
    btUpdate: TButton;
    btCreateTestTbl: TButton;
    btDropTestTbl: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure btQueryTestClick(Sender: TObject);
    procedure btCreateTestTblClick(Sender: TObject);
    procedure btDropTestTblClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation

uses
  QryTest, DataMod, UpdTest;

{$R *.DFM}

{ TMainFrm }
procedure TMainFrm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
end;

procedure TMainFrm.ShowHint(Sender: TObject);
begin
  if (Length(Application.Hint) = 0) and Assigned(dmData) then
    with dmData.Database do
      Application.Hint :=
    	Format('Client Version=%d.%d; Server Version=%d.%d; %s',
    		[ClientMajor, ClientMinor, ServerMajor, ServerMinor, Version] );

  StatusLine.SimpleText := Application.Hint;
end;

procedure TMainFrm.btQueryTestClick(Sender: TObject);
begin
  Application.CreateForm(TQueryTestFrm, QueryTestFrm);
  with QueryTestFrm do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainFrm.btCreateTestTblClick(Sender: TObject);
begin
  dmData.CreateTestTable;
end;

procedure TMainFrm.btDropTestTblClick(Sender: TObject);
begin
  dmData.DropTestTable;
end;

procedure TMainFrm.btUpdateClick(Sender: TObject);
begin
  with dmData do
    if not Database.Connected then Database.Open;

  Application.CreateForm(TUpdateTestFrm, UpdateTestFrm);
  with UpdateTestFrm do try
    ShowModal;
  finally
    Free;
  end;
end;

end.
