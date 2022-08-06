unit ShakeExec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  teShake, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TFormShakeExec = class(TForm)
    Panel: TPanel;
    ImageTest: TImage;
    BitBtnExecute: TBitBtn;
    EditMilliseconds: TEdit;
    Label1: TLabel;
    UpDownMilliseconds: TUpDown;
    procedure BitBtnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Transition: TShakeTransition;
  public
  end;

var
  FormShakeExec: TFormShakeExec;

implementation

uses
  TransEff;

{$R *.DFM}

procedure TFormShakeExec.BitBtnExecuteClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    Transition.Milliseconds := UpDownMilliseconds.Position;

    Transition.Prepare(Panel, Rect(9, 9, 354, 201));
    Transition.Execute;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormShakeExec.FormCreate(Sender: TObject);
begin
  Transition := TShakeTransition.Create;
  Transition.Milliseconds := 5000;
  ImageTest.Picture.Bitmap.LoadFromFile(
    ExtractFilePath(Application.ExeName) + 'Shipping.bmp');
end;

end.
