unit Power;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormCont, StdCtrls, Buttons, ExtCtrls;

type
  TFormPower = class(TForm)
    PanelButton: TPanel;
    BitBtnMagic: TBitBtn;
    LabelMagic: TLabel;
    PanelForm: TPanel;
    FormContainer: TFormContainer;
    procedure BitBtnMagicClick(Sender: TObject);
  private
  public
  end;

var
  FormPower: TFormPower;

implementation

uses Navigator, teFuse;

{$R *.DFM}

procedure TFormPower.BitBtnMagicClick(Sender: TObject);
var
  Transition: TFuseTransition;
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    Transition := TFuseTransition.Create;
    try
      Transition.Style := 8;
      FormContainer.ShowFormEx(FormContainer.CreateForm(TFormNavigator), True,
        Transition, nil, fcfaDefault);
    finally
      Transition.Free;
    end;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

end.
