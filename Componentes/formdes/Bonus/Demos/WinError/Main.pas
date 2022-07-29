(*  GREATIS BONUS * TWindowsError             *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WinError, StdCtrls, ShellAPI;

type
  TfrmMain = class(TForm)
    cmpWindowsError: TWindowsError;
    lblPath: TLabel;
    edtPath: TEdit;
    btnRun: TButton;
    procedure btnRunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.btnRunClick(Sender: TObject);
begin
  if ShellExecute(Handle,'open',PChar(edtPath.Text),nil,nil,SW_SHOWDEFAULT)<=32 then
    cmpWindowsError.ShowError('Error when running');
end;

end.
