unit PopupLb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPopupListBox = class(TForm)
    procedure ListScreenDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListScreenMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Cores: Boolean;
    ListBox: TListBox;
    constructor Create(AOwner: TComponent); override;
    procedure _Deactivate(Sender: TObject);
  end;

const
  frColors: Array[0..41] of TColor =
    (clWhite, clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal,
     clGray, clSilver, clRed, clLime, clYellow, clBlue, clFuchsia,
     clAqua, clNone,
     clScrollBar, clBackground, clActiveCaption, clInactiveCaption,
     clMenu, clWindow, clWindowFrame, clMenuText, clWindowText,
     clCaptionText, clActiveBorder, clInactiveBorder, clAppWorkSpace,
     clHighlight, clHighlightText, clBtnFace, clBtnShadow, clGrayText,
     clBtnText, clInactiveCaptionText, clBtnHighlight, cl3DDkShadow,
     cl3DLight, clInfoText, clInfoBk);


implementation

{$R *.DFM}

constructor TPopupListBox.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  BorderStyle := bsNone;
//  OnDeactivate := _Deactivate;
  Cores := False;
  ListBox := TListBox.Create(Self);
  with ListBox do
  begin
    Parent := Self;
    Ctl3D := False;
    IntegralHeight := True;
    ItemHeight := 11;
    OnDrawItem := ListScreenDrawItem;
    OnMeasureItem := ListScreenMeasureItem;
  end;
end;

procedure TPopupListBox._Deactivate(Sender: TObject);
begin
//  Hide;
end;

procedure TPopupListBox.ListScreenDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  bitmap : tbitmap;
  offset : integer;
begin
  with (Control as TListBox).Canvas do begin
    FillRect(Rect);
    Offset := 2;
    Bitmap:=TBitmap.Create;
    Bitmap.Width := 12; Bitmap.Height := 12;
    if Cores then
    begin
      BitMap.Canvas.Brush.Color := frColors[Index];
      BitMap.Canvas.Pen.Color := clBtnShadow;
      BitMap.Canvas.Rectangle(0, 0, 12, 12);
    end
    else
      BitMap := nil;
    try
       if Bitmap <> nil then begin
         BrushCopy(Bounds(Rect.Left + 2, Rect.Top, Bitmap.Width, Bitmap.Height),
                   Bitmap,
                   Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                   clSilver); {clNavy}
         Offset := Bitmap.width + 8;
       end;
       if Cores then
         Offset := 24;
       TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index])
    finally
       Bitmap.Free;
    end;
  end;
end;

procedure TPopupListBox.ListScreenMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  if Cores then
    Height := 14;
end;

end.
