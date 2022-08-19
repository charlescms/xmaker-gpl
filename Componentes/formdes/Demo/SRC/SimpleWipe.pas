unit SimpleWipe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FormCont, ComCtrls;

type
  TFormSimpleWipe = class(TForm)
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
  FormSimpleWipe: TFormSimpleWipe;

implementation

uses SimpleWipeExec;

{$R *.DFM}

procedure TFormSimpleWipe.FormCreate(Sender: TObject);
begin
  FormSimpleWipeExec :=
    TFormSimpleWipeExec(FormContainer.CreateForm(TFormSimpleWipeExec));
  FormContainer.ShowForm(FormSimpleWipeExec, True);
end;

end.
