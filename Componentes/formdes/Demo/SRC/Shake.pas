unit Shake;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FormCont, ComCtrls;

type
  TFormShake = class(TForm)
    PageControl: TPageControl;
    TabSheetCode: TTabSheet;
    TabSheetExecute: TTabSheet;
    FormContainer: TFormContainer;
    MemoCode: TMemo;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormShake: TFormShake;

implementation

uses ShakeExec;

{$R *.DFM}

procedure TFormShake.FormCreate(Sender: TObject);
begin
  FormShakeExec :=
    TFormShakeExec(FormContainer.CreateForm(TFormShakeExec));
  FormContainer.ShowForm(FormShakeExec, True);
end;

end.
