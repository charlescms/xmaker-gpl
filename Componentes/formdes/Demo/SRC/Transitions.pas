unit Transitions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, teBlend, ExtCtrls, ComCtrls, Buttons;

type
  TFormTransitions = class(TForm)
    Timer: TTimer;
    Panel: TPanel;
    PageControlTest: TPageControl;
    TabSheetMemo: TTabSheet;
    TabSheetShape: TTabSheet;
    ShapeTest: TShape;
    MemoTest: TMemo;
    BitBtnChangeShape: TBitBtn;
    TabSheetImage: TTabSheet;
    ImageTest: TImage;
    BitBtnChangeBitmap: TBitBtn;
    TabSheetControls: TTabSheet;
    GroupBoxControls: TGroupBox;
    TrackBarExample: TTrackBar;
    LabelExample: TLabel;
    ButtonExample: TButton;
    ProgressBarExample: TProgressBar;
    BitBtnExample: TBitBtn;
    CheckBoxExample: TCheckBox;
    RadioGroupExample: TRadioGroup;
    BitBtnChangeControls: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure MemoTestChange(Sender: TObject);
    procedure MemoTestKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControlTestChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure PageControlTestChange(Sender: TObject);
    procedure BitBtnChangeShapeClick(Sender: TObject);
    procedure BitBtnChangeBitmapClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnChangeControlsClick(Sender: TObject);
  private
    ToggleImage,
    ToggleControls: Boolean;
  public
    Transition: TBlendTransition;
  end;

var
  FormTransitions: TFormTransitions;

implementation

{$R *.DFM}

procedure TFormTransitions.FormShow(Sender: TObject);
begin
  Transition := TBlendTransition.Create;
  Transition.Milliseconds := 500;
end;

procedure TFormTransitions.FormHide(Sender: TObject);
begin
  Transition.Free;
  Transition := nil;
end;

procedure TFormTransitions.TimerTimer(Sender: TObject);
begin
  if not Transition.Executing then
  begin
    Timer.Enabled := False;
    if Transition.Prepared then
      Transition.UnPrepare;
  end;
end;

procedure TFormTransitions.MemoTestChange(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if Transition.Prepared then
      Transition.Execute;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormTransitions.MemoTestKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Transition.Prepare(MemoTest.Parent, MemoTest.BoundsRect) then
    Timer.Enabled := True;
end;

procedure TFormTransitions.PageControlTestChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  Transition.Prepare(PageControlTest.Parent, PageControlTest.BoundsRect);
end;

procedure TFormTransitions.PageControlTestChange(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if Transition.Prepared then
      Transition.Execute;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormTransitions.BitBtnChangeShapeClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    Transition.Prepare(ShapeTest, ShapeTest.ClientRect);

    with ShapeTest do
    begin
      case Shape of
        stEllipse    :
          begin
            Pen  .Color := clBlack;
            Pen  .Style := psSolid;
            Pen  .Width := 1;
            Brush.Color := clTeal;
            Brush.Style := bsSolid;
            Shape       := stRectangle;
          end;
        stRectangle  :
          begin
            Pen  .Color := clGreen;
            Pen  .Style := psSolid;
            Pen  .Width := 1;
            Brush.Color := clgray;
            Brush.Style := bsDiagCross;
            Shape       := stCircle;
          end;
        stCircle     :
          begin
            Pen  .Color := clWhite;
            Pen  .Style := psSolid;
            Pen  .Width := 5;
            Brush.Color := clGray;
            Brush.Style := bsSolid;
            Shape       := stRoundRect;
          end;
        stRoundRect  :
          begin
            Pen  .Color := clMaroon;
            Pen  .Style := psDot;
            Pen  .Width := 1;
            Brush.Color := clNavy;
            Brush.Style := bsBDiagonal;
            Shape       := stSquare;
          end;
        stSquare     :
          begin
            Pen  .Color := clFuchsia;
            Pen  .Style := psDash;
            Pen  .Width := 1;
            Brush.Color := clPurple;
            Brush.Style := bsCross;
            Shape       := stRoundSquare;
          end;
        stRoundSquare:
          begin
            Pen  .Color := clBlack;
            Pen  .Style := psClear;
            Pen  .Width := 1;
            Brush.Color := clRed;
            Brush.Style := bsSolid;
            Shape       := stEllipse;
          end;
      end;
    end;
    Transition.Execute;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormTransitions.BitBtnChangeBitmapClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
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

procedure TFormTransitions.FormCreate(Sender: TObject);
begin
  ToggleImage    := True;
  ToggleControls := True;
  ImageTest.Picture.Bitmap.LoadFromFile(
    ExtractFilePath(Application.ExeName) + 'Shipping.bmp');
  if Screen.PixelsPerInch > PixelsPerInch then
    MemoTest.Font.Size := 8;
  MemoTest.WordWrap := True;
end;

procedure TFormTransitions.BitBtnChangeControlsClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if ToggleControls
    then
    begin
      Transition.Prepare(LabelExample, LabelExample.ClientRect);
      with LabelExample do
      begin
        Caption := 'Goodbye';
        Font.Color := clRed;
      end;
      Transition.Execute;

      Transition.Prepare(BitBtnExample, BitBtnExample.ClientRect);
      BitBtnExample.Kind    := bkCancel;
      BitBtnExample.Caption := 'Cancel';
      Transition.Execute;

      Transition.Prepare(ButtonExample, ButtonExample.ClientRect);
      ButtonExample.Caption := 'Reaction';
      Transition.Execute;

      Transition.Prepare(CheckBoxExample, CheckBoxExample.ClientRect);
      CheckBoxExample.Checked := not CheckBoxExample.Checked;
      Transition.Execute;

      Transition.Prepare(ProgressBarExample, ProgressBarExample.ClientRect);
      ProgressBarExample.Position := 75;
      Transition.Execute;

      Transition.Prepare(TrackBarExample, TrackBarExample.ClientRect);
      TrackBarExample.Position := 7;
      Transition.Execute;

      // This one is different because the RadioGroup is going to be hidden, so we
      // have to use its parent as reference
//    Transition.Prepare(RadioGroupExample, RadioGroupExample.ClientRect); wrong!!
      Transition.Prepare(GroupBoxControls, RadioGroupExample.BoundsRect);
      RadioGroupExample.Visible := False;
      Transition.Execute;
    end
    else
    begin
      Transition.Prepare(GroupBoxControls, GroupBoxControls.ClientRect);

      with LabelExample do
      begin
        Caption := 'Hello';
        Font.Color := clBlack;
      end;
      BitBtnExample     .Kind     := bkOK;
      BitBtnExample     .Caption  := 'OK';
      ButtonExample     .Caption  := 'Action';
      CheckBoxExample   .Checked  := not CheckBoxExample.Checked;
      ProgressBarExample.Position := 25;
      TrackBarExample   .Position :=  3;
      RadioGroupExample .Visible  := True;

      Transition.Execute;
    end;

    ToggleControls := not ToggleControls;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

end.
