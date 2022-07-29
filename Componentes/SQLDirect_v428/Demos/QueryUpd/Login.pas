unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, SDEngine;

type
  TLoginDlg = class(TForm)
    pnlUser: TPanel;
    pnlDatabase: TPanel;
    lblDatabase: TLabel;
    edDatabase: TEdit;
    lblServerType: TLabel;
    cbServerType: TComboBox;
    lblUserName: TLabel;
    lblPassword: TLabel;
    edUserName: TEdit;
    edPassword: TEdit;
    btOk: TBitBtn;
    btCancel: TBitBtn;
  private
    { Private declarations }
  public
    procedure AssignDbValues(ADb: TSDDatabase);
  end;

var
  LoginDlg: TLoginDlg;

implementation

uses
  TypInfo, DataMod;

{$R *.DFM}

procedure TLoginDlg.AssignDbValues(ADb: TSDDatabase);
var
  i: Integer;
  s: string;
begin
  edDatabase.Text := ADb.RemoteDatabase;
  cbServerType.Items.Clear;
  for i:=0 to Ord(High(ADb.ServerType)) do begin
    s := GetEnumName(TypeInfo(TSDServerType), i );
    cbServerType.Items.Add( Copy( s, 3, Length(s)-2 ) );
  end;
  if cbServerType.Items.Count > 0 then
    cbServerType.ItemIndex := Ord(ADb.ServerType);
end;

end.
