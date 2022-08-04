(*  GREATIS FORM EXTRACTOR for                *)
(*  GREATIS FORM DESIGNER                     *)
(*  Copyright (C) 2002-2004 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

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
    pnlWeb: TPanel;
    lblName: TLabel;
    lblVersion: TLabel;
    procedure pnlLinkClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfrmAbout.pnlLinkClick(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(GetShortHint((Sender as TPanel).Hint)),'','',SW_SHOW);
end;

end.
