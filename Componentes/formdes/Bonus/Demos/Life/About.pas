(*  GREATIS BONUS * Life                      *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit About;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ShellAPI;

type
  TfrmAbout = class(TForm)
    pnlTop: TPanel;
    pnlCopyrigth: TPanel;
    btnClose: TButton;
    lblProduct: TLabel;
    lblWeb: TLabel;
    procedure lblLinkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.DFM}

procedure TfrmAbout.lblLinkClick(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(GetShortHint((Sender as TLabel).Hint)),'','',SW_SHOW);
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  SetForegroundWindow(Application.Handle);
end;


end.
