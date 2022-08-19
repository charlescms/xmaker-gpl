unit SimpleWipeExec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  teSimpleWipe, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TFormSimpleWipeExec = class(TForm)
    Panel: TPanel;
    ImageTest: TImage;
    BitBtnExecute: TBitBtn;
    RadioGroupDirection: TRadioGroup;
    EditMilliseconds: TEdit;
    Label1: TLabel;
    UpDownMilliseconds: TUpDown;
    procedure BitBtnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ToggleImage: Boolean;
    Transition: TSimpleWipeTransition;
  public
  end;

var
  FormSimpleWipeExec: TFormSimpleWipeExec;

implementation

uses
  TransEff;

{$R *.DFM}

procedure TFormSimpleWipeExec.BitBtnExecuteClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    case RadioGroupDirection.ItemIndex of
      0: Transition.Direction := tedRight;
      1: Transition.Direction := tedLeft;
      2: Transition.Direction := tedDown;
      3: Transition.Direction := tedUp;
    end;
    Transition.Milliseconds := UpDownMilliseconds.Position;

    Transition.Prepare(ImageTest, ImageTest.ClientRect);
    if ToggleImage
    then ImageTest.Picture.Bitmap.LoadFromFile(
      ExtractFilePath(Application.ExeName) + 'HandShak.bmp')
    else ImageTest.Picture.Bitmap.LoadFromFile(
      ExtractFilePath(Application.ExeName) + 'Shipping.bmp');
    ToggleImage := not ToggleImage;
    Transition.Execute;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormSimpleWipeExec.FormCreate(Sender: TObject);
begin
  Transition := TSimpleWipeTransition.Create;
  ToggleImage := True;
  ImageTest.Picture.Bitmap.LoadFromFile(
    ExtractFilePath(Application.ExeName) + 'Shipping.bmp');
end;

end.
