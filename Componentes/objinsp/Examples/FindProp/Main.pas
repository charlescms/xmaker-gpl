(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PropList, PropIntf, StdCtrls;

type
  TfrmMain = class(TForm)
    cmpPropertyInterface: TPropertyInterface;
    lblValue: TLabel;
    btnValue: TButton;
    cmbValue: TComboBox;
    lblName: TLabel;
    edtName: TEdit;
    btnFind: TButton;
    procedure SetValue(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
  private
    { Private declarations }
    P: TProperty;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.SetValue(Sender: TObject);
begin
  try
    if Assigned(P) then P.AsString:=cmbValue.Text;
  except
    ShowMessage('Invalid property value');
  end;
end;

procedure TfrmMain.btnFindClick(Sender: TObject);
begin
  P:=cmpPropertyInterface.FindProperty(edtName.Text);
  with cmbValue,P do
    if Assigned(P) then
    begin
      ValuesList(Items);
      Text:=AsString;
    end
    else
    begin
      Items.Clear;
      Text:='';
    end;
  lblValue.Enabled:=Assigned(P);
  cmbValue.Enabled:=Assigned(P);
  btnValue.Enabled:=Assigned(P);
end;

end.
