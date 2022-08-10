unit XBanner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  T3DEffectShort = (A3dNormal, A3dResit, A3dRaised, A3dShadowed);
  TAlinhamento = (AtaLeftJustify, AtaCenter);

  TXBanner = class(TGraphicControl)
  private
    FColorOf: TColor;
    FColorFor: TColor;
    FHorizontal: Boolean;
    FCaption: String;
    FAngle: Integer;
    FStyle3D: T3DEffectShort;
    FShadowColor,FWhiteColor,FLast : TColor;
    FShadeLTSet : boolean;
    FhOffSet,FvOffSet : integer;
    FAlignment: TAlinhamento;
    FOnPaint: TNotifyEvent;
    procedure SetCorDE(Cor: TColor);
    procedure SetCorPARA(Cor: TColor);
    procedure SetHorizontal(Value: Boolean);
    procedure SetTitulo(Value: String);
    procedure SetAngulo(Value: Integer);
    procedure SetStyle3D(Value: T3DEffectShort);
    procedure SetShadowColor(Value:TColor);
    procedure SetWhiteColor(Value:TColor);
    procedure SetFhOffSet(value: integer);
    procedure SetFvOffSet(value: integer);
    procedure SetShadeLT(value: boolean);
    procedure SetAlignment(Value: TAlinhamento);
  protected
    fDegToRad, fCosAngle, fSinAngle: double;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property Align;
    property Alignment: TAlinhamento read FAlignment write SetAlignment default AtaCenter;
    property AHShadeOffSet: integer read FhOffSet write SetFhOffSet default 5;
    property AVShadeOffSet: integer read FvOffSet write SetFvOffSet default -5;
    property Anchors;
    property Angle: Integer read FAngle write SetAngulo;
    property Caption: String read FCaption write SetTitulo;
    property Color;
    property ColorOf: TColor read FColorOf write SetCorDE;
    property ColorFor: TColor read FColorFor write SetCorPARA;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Horizontal: Boolean read FHorizontal write SetHorizontal;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShadeRightBottom: TColor read FShadowColor write SetShadowColor default clGray;
    property ShadeLeftTop: TColor read FWhiteColor write SetWhiteColor default clWhite;
    property ShadeLTSet: boolean read FShadeLTSet write setShadeLT default true;
    property ShowHint;
    property Style3D: T3DEffectShort read FStyle3D write SetStyle3D;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

constructor TXBanner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 260;
  Height := 40;

  FColorOf    := clBlue;
  FColorFor   := clWhite;
  FHorizontal := True;
  FAlignment  := AtaCenter;
  FShadowColor:= clGray;
  FWhiteColor := clWhite;

  fDegToRad := PI / 180;
  fCosAngle := 1;
  fSinAngle := 0;
  FLast     := clWhite;
  FhOffSet  := 5;
  FvOffSet  := -5;
end;

procedure TXBanner.SetCorDE(Cor: TColor);
begin
  FColorOf := Cor;
  Invalidate;
end;

procedure TXBanner.SetCorPARA(Cor: TColor);
begin
  FColorFor := Cor;
  Invalidate;
end;

procedure TXBanner.SetHorizontal(Value: Boolean);
begin
  FHorizontal := Value;
  Invalidate;
end;

procedure TXBanner.SetTitulo(Value: String);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TXBanner.SetAngulo(Value: Integer);
begin
  FAngle := Value;
  Invalidate;
end;

procedure TXBanner.SetStyle3D(Value: T3DEffectShort);
begin
  FStyle3d := Value;
  Invalidate;
end;

procedure TXBanner.SetAlignment(Value: TAlinhamento);
begin
  FAlignment := Value;
  Invalidate;
end;

procedure TXBanner.SetShadowColor(value: TColor);
begin
  if not (FShadowColor = value) then
  begin
     FShadowColor := value;
     Invalidate;
   end;
 end;

procedure TXBanner.SetWhiteColor(value: TColor);
begin
  if not (FWhiteColor = value) and (FShadeLTSet = false)  then
  begin
     FWhiteColor := value;
     Invalidate;
   end;
end;

procedure TXBanner.SetShadeLT(value: boolean);
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
   if (FShadeLTSet = true) and (FStyle3D in [A3dResit, A3dRaised]) and (FLast<>clWhite) then
     Invalidate;
end;

procedure TXBanner.SetFhOffSet(value: integer);
begin
  if value<>FhOffSet then
  begin
    FhOffSet := value;
    if FStyle3D = A3DShadowed then
      Invalidate;
  end;
end;

procedure  TXBanner.SetFvOffSet(value: integer);
begin
  if value<>FvOffSet then
  begin
    FvOffSet := value;
    if FStyle3D = A3DShadowed then
      Invalidate;
  end;
end;

procedure TXBanner.Paint;
var
  RGBDesde, RGBHasta, RGBDif : array[0..2] of byte;  // Cor inicial e final - diferença de cores
  contador, Vermelho, Verde, Azul : integer;
  Banda : TRect;                                     // Coordenadas do requadro a pintar
  Factor : array[0..2] of shortint;                  // +1 se gradiente é crescente e -1 caso decrescente

  LogRec: TLOGFONT;
  OldFont,NewFont: HFONT;
  midX, midY, H, W, X, Y,OffSet1,OffSet2: integer;
  P1, P2, P3, P4: TPoint;
  temp,ColorOfParent : TColor;
  Rect : TRect;
begin
  RGBDesde[0]:=GetRValue(ColorToRGB(FColorOf));
  RGBDesde[1]:=GetGValue(ColorToRGB(FColorOf));
  RGBDesde[2]:=GetBValue(ColorToRGB(FColorOf));
  RGBHasta[0]:=GetRValue(ColorToRGB(FColorFor));
  RGBHasta[1]:=GetGValue(ColorToRGB(FColorFor));
  RGBHasta[2]:=GetBValue(ColorToRGB(FColorFor));
  begin
    for contador:=0 to 2 do                          // Calculo de RGBDif[] e factor[]
    begin
      RGBDif[contador]:=Abs(RGBHasta[contador]-RGBDesde[contador]);
      If RGBHasta[contador]>RGBDesde[contador] then factor[contador]:=1 else factor[contador]:=-1;
    end;
    Canvas.Pen.Style:=psSolid;
    Canvas.Pen.Mode:=pmCopy;
    if FHorizontal then
    begin
      Banda.Left:=0;
      Banda.Right:=Width;
      for contador:=0 to 255 do
      begin
        Banda.Top:=MulDiv(contador,height,256);
        Banda.Bottom:=MulDIv(contador+1,height,256);
        Vermelho:=RGBDesde[0]+factor[0]*MulDiv(contador,RGBDif[0],255);
        Verde:=RGBDesde[1]+factor[1]*MulDiv(contador,RGBDif[1],255);
        Azul:=RGBDesde[2]+factor[2]*MulDiv(contador,RGBDif[2],255);
        Canvas.Brush.Color:=RGB(Vermelho,Verde,Azul);
        Canvas.FillRect(Banda);
      end;
    end
    else
    begin
      Banda.Top:=0;
      Banda.Bottom:=Height;
      for contador:=0 to 255 do
      begin
        Banda.Left:=MulDiv(contador,width,256);
        Banda.Right:=MulDIv(contador+1,width,256);
        Vermelho:=RGBDesde[0]+factor[0]*MulDiv(contador,RGBDif[0],255);
        Verde:=RGBDesde[1]+factor[1]*MulDiv(contador,RGBDif[1],255);
        Azul:=RGBDesde[2]+factor[2]*MulDiv(contador,RGBDif[2],255);
        Canvas.Brush.Color:=RGB(Vermelho,Verde,Azul);
        Canvas.FillRect(Banda);
      end;
    end;
  end;

  // Desenho do Título em 3D
  Rect := ClientRect;
  fCosAngle := cos(FAngle * fDegToRad);
  fSinAngle := sin(FAngle * fDegToRad);
  temp := Font.Color;
  if FStyle3D = A3dRaised then
    begin
      OffSet1:=1;
      OffSet2:=-1;
    end
    else if FStyle3D = A3dResit then
    begin
      OffSet1:=-1;
      OffSet2:=1;
    end
    else if FStyle3D in [A3dNormal,A3dShadowed] then
    begin
      Offset1:=0;
      OffSet2:=0;
    end;
  with Canvas do
  begin
    Font := Self.Font;
    Brush.Style := bsClear;
    GetObject(Font.Handle, SizeOf(LogRec), @LogRec);
    LogRec.lfEscapement := FAngle*10;
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
      Case FAngle of
        0: X    := 0;
        90: Y   := Height;
        180: X  := Width;
        360: X  := 0;
        -90: Y  := 0;
        -180: X := Width;
        -360: X := 0;
      end;
    end;
    {Displayin the Text stuff}
    if FStyle3D in [A3dShadowed, A3dRaised, A3dResit] then
    begin
      if FStyle3D <> A3dShadowed then
      begin
        Canvas.Font.Color := FWhiteColor;
        OldFont := SelectObject(Canvas.Handle,NewFont);
        TextOut(X+OffSet2, Y+OffSet2, Caption);
      end;
         {Bottom right}
      Canvas.Font.Color := FShadowColor;
      OldFont := SelectObject(Canvas.Handle,NewFont);
      if FStyle3D in [A3dRaised, A3dResit] then
        TextOut(X+OffSet1, Y+OffSet1, Caption)
      else
        TextOut(X+FhOffSet, Y+FvOffSet, Caption);
      end;

    {Main Text}
    Canvas.Font.Color := Temp;
    OldFont := SelectObject(Canvas.Handle,NewFont);
    TextOut(X, Y, Caption);

    NewFont := SelectObject(Canvas.Handle,OldFont);
    DeleteObject(NewFont);
  end;
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

procedure Register;
begin
  RegisterComponents('X-Maker', [TXBanner]);
end;

end.
