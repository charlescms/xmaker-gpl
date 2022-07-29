(*  GREATIS BONUS * THistoryEdit              *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Run;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, HistEdit, ShellAPI;

type
  TfrmRun = class(TForm)
    lblCommand: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    btnBrowse: TButton;
    opdBrowse: TOpenDialog;
    hedCommand: THistoryEdit;
    procedure btnBrowseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRun: TfrmRun;

implementation

{$R *.DFM}

procedure TfrmRun.btnBrowseClick(Sender: TObject);
begin
  with opdBrowse do
    if Execute then hedCommand.Text:=FileName;
end;

procedure TfrmRun.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult=mrOk then
  begin
    CanClose:=ShellExecute(0,'open',PChar(hedCommand.Text),'','',SW_SHOW)>32;
    with hedCommand do
      if CanClose then AddHistory
      else
      begin
        MessageBeep(0);
        SelectAll;
        SetFocus;
      end;
  end;
end;

procedure TfrmRun.FormShow(Sender: TObject);
begin
  with hedCommand do
  begin
    SelectAll;
    SetFocus;
  end;
end;

end.
