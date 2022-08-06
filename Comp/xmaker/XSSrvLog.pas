unit XSSrvLog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TXSSrvLoginDlg = class(TForm)
    pnlInput: TPanel;
    Label2: TLabel;
    lblServerName: TLabel;
    ServerName: TLabel;
    Bevel: TBevel;
    Password: TEdit;
    btOk: TButton;
    btCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  XSSrvLoginDlg: TXSSrvLoginDlg;

function SrvLoginDialog(const AServerName: string; var APassword: string): Boolean;

implementation

{$R *.DFM}

function SrvLoginDialog(const AServerName: string; var APassword: string): Boolean;
var
  Dlg: TXSSrvLoginDlg;
begin
  Application.CreateForm(TXSSrvLoginDlg, Dlg);
  with Dlg do try
    ServerName.Caption := AServerName;

    Result := ShowModal = mrOk;
    if Result then
      APassword := Password.Text;
  finally
    Free;
  end;
end;

end.


