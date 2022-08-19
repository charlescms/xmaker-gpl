unit Disabling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormDisabling = class(TForm)
    Panel: TPanel;
    MemoText: TMemo;
    CheckBoxGlobalDisabled: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxGlobalDisabledClick(Sender: TObject);
  private
  public
  end;

var
  FormDisabling: TFormDisabling;

implementation

{$R *.DFM}

uses Transeff;

procedure TFormDisabling.FormCreate(Sender: TObject);
begin
  CheckBoxGlobalDisabled.Checked := TEGlobalDisabled;
  if Screen.PixelsPerInch > PixelsPerInch then
    MemoText.Font.Size := 8;
  MemoText.WordWrap := True;
end;

procedure TFormDisabling.CheckBoxGlobalDisabledClick(Sender: TObject);
begin
  TEGlobalDisabled := CheckBoxGlobalDisabled.Checked;
end;

end.
