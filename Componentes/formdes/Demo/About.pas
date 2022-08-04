(*  GREATIS FORM DESIGNER DEMO                    *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellAPI;

type
  TfrmAbout = class(TForm)
    pnlName: TPanel;
    lblDescription: TLabel;
    pnlSpace: TPanel;
    lblHomePage: TLabel;
    btnClose: TButton;
    procedure lblLinkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.DFM}

procedure TfrmAbout.lblLinkClick(Sender: TObject);
begin
  with Sender as TLabel do
    ShellExecute(Application.Handle,nil,PChar(Hint),nil,nil,SW_SHOWDEFAULT);
end;

end.
