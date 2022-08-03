unit XLabel3D;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  T3DEffectShort = (A3dNormal, A3dResit, A3dRaised, A3dShadowed);
  TAlinhamento = (AtaLeftJustify, AtaCenter);

  type
  TLabelStyle = class(TPersistent)

  private
    fAngle: longint;
    FA3DEffect : T3DEffectShort;
    FhOffSet,FvOffSet : integer;
    FShadowColor,FWhiteColor,FLast : TColor;
    FShadeLTSet : boolean;
    FOnChange: TNotifyEvent;
    procedure SetAngle(Value: longint);
    procedure setStyleEffect(Value : T3DEffectShort);
    procedure SetShadowColor(Value:TColor);
    procedure SetWhiteColor(Value:TColor);
    procedure SetShadeLT(value: boolean);
    procedure SetFhOffSet(value: integer);
    procedure SetFvOffSet(value: integer);
  public
    procedure Assign(Value: TLabelStyle);
    procedure Invalidate;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Angle: longint read fAngle write SetAngle default 0;
    property AStyle3D: T3DEffectShort read FA3DEffect write setStyleEffect default A3dRaised;
    property AShadeRightBottom: TColor read FShadowColor write SetShadowColor default clGray;
    property AShadeLeftTop: TColor read FWhiteColor write SetWhiteColor default clWhite;
    property AShadeLTSet: boolean read FShadeLTSet write setShadeLT default true;
    property AHShadeOffSet: integer read FhOffSet write SetFhOffSet default 5;
    property AVShadeOffSet: integer read FvOffSet write SetFvOffSet default -5;
  end;{class}

  TXLabel3D = class(TCustomLabel)

  protected
   { Protected declarations }
    fDegToRad, fCosAngle, fSinAngle: double;
    procedure Paint; override;
  private
    FLabelStyle : TLabelStyle;
    fMyTransparent : boolean;
    FAlignment: TAlinhamento;
    procedure setLabelstyle(value:TLabelStyle);
    procedure StyleChanged(Sender: TObject);
    procedure setMyTransparent(value:boolean);
    procedure SetAlignment(Value: TAlinhamento);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Style : TLabelStyle read FLabelStyle write setLabelstyle;
    property Transparent : boolean read fMyTransparent write setMyTransparent default true;
    property Align;
    property Alignment: TAlinhamento read FAlignment write SetAlignment default AtaCenter;
    {property AutoSize;}
    property Caption;
    //property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    {property Parent;}
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    {property Transparent}
    property Visible;
    {property WordWrap; }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

constructor TXLabel3D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Transparent := true;
  AutoSize := false;
  Font.Name := 'Arial';
  Font.Style := [fsBold];
  FLabelStyle := TLabelStyle.Create;
  FLabelStyle.fAngle := 0;
  FLabelStyle.OnChange := StyleChanged;
  FLabelStyle.FShadowColor := clGray;
  FLabelStyle.FWhiteColor := clWhite;
  FLabelStyle.FA3DEffect := A3dRaised;
  FLabelStyle.FLast := clWhite;
  FLabelStyle.FhOffSet := 5;
  FLabelStyle.FvOffSet := -5;
  fDegToRad := PI / 180;
  fCosAngle := 1;
  fSinAngle := 0;
  fMyTransparent := true;
  FAlignment  := AtaCenter;
end;

procedure TXLabel3D.SetAlignment(Value: TAlinhamento);
begin
  FAlignment := Value;
  Repaint;
  Invalidate;
end;

procedure TXLabel3D.StyleChanged(Sender: TObject);
begin
  Invalidate;
end;

destructor TXLabel3D.Destroy;
begin
  inherited Destroy;
  FLabelStyle.Free;
end;

procedure TLabelStyle.SetAngle(Value: longint);
begin
  if FAngle <> Value then
  begin
    FAngle := Value;
    if (FAngle < 0) or (FAngle > 359) then
      FAngle := 0;
    Invalidate;
  end;
end;

procedure TXLabel3D.Paint;
var
  LogRec: TLOGFONT;
  OldFont,NewFont: HFONT;
  midX, midY, H, W, X, Y,OffSet1,OffSet2: integer;
  P1, P2, P3, P4: TPoint;
  temp,ColorOfParent : TColor;
  Rect : TRect;

begin
  Rect := ClientRect;
  fCosAngle := cos(FLabelStyle.fAngle * fDegToRad);
  fSinAngle := sin(FLabelStyle.fAngle * fDegToRad);
  temp := Font.Color;
  if not fMyTransparent then
    FLabelStyle.FA3DEffect := A3dNormal;
  if FLabelStyle.FA3DEffect = A3dRaised then
    begin
      OffSet1:=1;
      OffSet2:=-1;
    end
    else if FLabelStyle.FA3DEffect = A3dResit then
    begin
      OffSet1:=-1;
      OffSet2:=1;
    end
    else if FLabelStyle.FA3DEffect in [A3dNormal,A3dShadowed] then
    begin
      Offset1:=0;
      OffSet2:=0;
    end;
  with Canvas do
  begin
    Font := Self.Font;
    Brush.Style := bsClear;
    GetObject(Font.Handle, SizeOf(LogRec), @LogRec);
    LogRec.lfEscapement := FLabelStyle.fAngle*10;
    LogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;
    NewFont := CreateFontIndirect(LogRec);
    W := TextWidth(Caption);
    H := TextHeight(Caption);
    midX := Width div 2;
    midY := Height div 2;
    X := midX - trunc(W/2*fCosAngle) - trunc(H/2*fSinAngle);
    Y := midY + trunc(W/2*fSinAngle) - trunc(H/2*fCosAngle);
    if FAlignment = AtaLeftJustify then
    begin
      Case FLabelStyle.FAngle of
        0: X    := 0;
        90: Y   := Height;
        180: X  := Width;
        360: X  := 0;
        -90: Y  := 0;
        -180: X := Width;
        -360: X := 0;
      end;
    end;
    if not fMyTransparent then
    begin
      W := W+10; H := H+7;
      P1.X := midX - trunc(W/2*fCosAngle) - trunc(H/2*fSinAngle);
      P1.Y := midY + trunc(W/2*fSinAngle) - trunc(H/2*fCosAngle);
      P2.X := midX + trunc(W/2*fCosAngle) - trunc(H/2*fSinAngle);
      P2.Y := midY - trunc(W/2*fSinAngle) - trunc(H/2*fCosAngle);
      P3.X := midX + trunc(W/2*fCosAngle) + trunc(H/2*fSinAngle);
      P3.Y := midY - trunc(W/2*fSinAngle) + trunc(H/2*fCosAngle);
      P4.X := midX - trunc(W/2*fCosAngle) + trunc(H/2*fSinAngle);
      P4.Y := midY + trunc(W/2*fSinAngle) + trunc(H/2*fCosAngle);
      InValidateRect(Handle,@Rect,true);
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      Polygon([P1, P2, P3, P4]);
    end;
    {Displayin the Text stuff}
    if FLabelStyle.FA3DEffect in [A3dShadowed, A3dRaised, A3dResit] then
    begin
      if FLabelStyle.FA3DEffect <> A3dShadowed then
      begin
        Canvas.Font.Color := FLabelStyle.FWhiteColor;
        OldFont := SelectObject(Canvas.Handle,NewFont);
        TextOut(X+OffSet2, Y+OffSet2, Caption);
      end;
         {Bottom right}
      Canvas.Font.Color := FLabelStyle.FShadowColor;
      OldFont := SelectObject(Canvas.Handle,NewFont);
      if FLabelStyle.FA3DEffect in [A3dRaised, A3dResit] then
        TextOut(X+OffSet1, Y+OffSet1, Caption)
      else
        TextOut(X+FLabelStyle.FhOffSet, Y+FLabelStyle.FvOffSet, Caption);
      end;

    {Main Text}
    Canvas.Font.Color := Temp;
    OldFont := SelectObject(Canvas.Handle,NewFont);
    TextOut(X, Y, Caption);

    NewFont := SelectObject(Canvas.Handle,OldFont);
    DeleteObject(NewFont);
  end;
end;

 procedure TLabelStyle.setStyleEffect(value: T3DEffectShort);
 begin
   if FA3DEffect <> value then
   begin
     FA3DEffect := value;
     Invalidate;
   end;
 end;

procedure TLabelStyle.SetShadowColor(value: TColor);
begin
  if not (FShadowColor = value) then
  begin
     FShadowColor := value;
     Invalidate;
   end;
 end;

procedure TLabelStyle.SetWhiteColor(value: TColor);
begin
  if not (FWhiteColor = value) and (FShadeLTSet = false)  then
  begin
     FWhiteColor := value;
     Invalidate;
   end;
 end;

procedure TLabelStyle.SetShadeLT(value: boolean);
begin
  if  FShadeLTSet <> value then
  begin
    FShadeLTSet := value;
    if FShadeLTSet = true then
    begin
      FLast := FWhiteColor;
      FWhiteColor := clWhite;
    end
    else
      FWhiteColor := Flast;
   end;
   if (FShadeLTSet = true) and (FA3DEffect in [A3dResit, A3dRaised]) and (FLast<>clWhite) then
     Invalidate;
end;

procedure TLabelStyle.SetFhOffSet(value: integer);
begin
  if value<>FhOffSet then
  begin
    FhOffSet := value;
    if AStyle3D = A3DShadowed then
      Invalidate;
  end;
end;

procedure TLabelStyle.Invalidate;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure  TLabelStyle.SetFvOffSet(value: integer);
begin
  if value<>FvOffSet then
  begin
    FvOffSet := value;
    if AStyle3D = A3DShadowed then
      Invalidate;
  end;
end;

procedure TLabelStyle.Assign(Value: TLabelStyle);
begin
  Angle := Value.Angle;
  AStyle3D := Value.AStyle3D;
  AShadeRightBottom := Value.AShadeRightBottom;
  AShadeLeftTop := Value.AShadeLeftTop;
  AShadeLTSet := Value.AShadeLTSet;
  AHShadeOffSet := Value.AHShadeOffSet;
  AVShadeOffSet := Value.AVShadeOffSet;
  Invalidate;
end;

procedure TXLabel3D.setLabelstyle(value:TLabelStyle);
begin
  FLabelStyle.Assign(Value);
  Invalidate;
end;

procedure TXLabel3D.setMyTransparent(value:boolean);
var
 MyColor : TColor;
begin
  if value<>fMyTransparent then
  begin
    fMyTransparent := value;
    if fMyTransparent = False then
    begin
      MyColor := Color;
      ParentColor := True;
      Color := MyColor;
    end;
    invalidate;
  end;
end;

procedure Register;
begin
  RegisterComponents('X-Maker', [TXLabel3D]);
end;

end.
