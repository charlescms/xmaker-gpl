(*  GREATIS FORM DESIGNER COMPONENT PRO  *)
(*  unit version 0.00.001                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm   *)
(*  b-team@greatis.com                   *)

unit DCSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmSize = class(TForm)
    grbWidth: TGroupBox;
    rbtWNoChange: TRadioButton;
    rbtWToSmallest: TRadioButton;
    rbtWToLargest: TRadioButton;
    rbtWidth: TRadioButton;
    edtWidth: TEdit;
    grbHeight: TGroupBox;
    rbtHNoChange: TRadioButton;
    rbtHToSmallest: TRadioButton;
    rbtHToLargest: TRadioButton;
    rbtHeight: TRadioButton;
    edtHeight: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure edtKeyPress(Sender: TObject; var Key: Char);
    procedure rbtClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmSize.edtKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',Char(VK_DELETE),Char(VK_BACK)]) then
  begin
    Key:=#0;
    MessageBeep(0);
  end;
end;

procedure TfrmSize.rbtClick(Sender: TObject);
begin
  edtWidth.Enabled:=rbtWidth.Checked;
  edtHeight.Enabled:=rbtHeight.Checked;
end;

end.
