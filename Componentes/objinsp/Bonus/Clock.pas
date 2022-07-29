(*  GREATIS BONUS * TClock                    *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Clock;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type

  THandMode = (hmNormal,hmFilled,hmTransparent);
  THandShape = (hsRectangle,hsTrapeze,hsTriangle);

  TClock = class(TGraphicControl)
  private
    { Private declarations }
    FFaceShape: TShapeType;
    FBackColor: TColor;
    FFaceColor: TColor;
    FHandColor: TColor;
    FTime: TTime;
    FOldTime: TTime;
    FShowSeconds: Boolean;
    FHandMode: THandMode;
    FHandShape: THandShape;
    FHoursVisible: Boolean;
    procedure SetFaceShape(Value: TShapeType);
    procedure SetBackColor(Value: TColor);
    procedure SetFaceColor(Value: TColor);
    procedure SetHandColor(Value: TColor);
    procedure SetTime(Value: TTime);
    procedure SetShowSeconds(Value: Boolean);
    procedure SetHandMode(Value: THandMode);
    procedure SetHandShape(Value: THandShape);
    procedure SetHoursVisible(Value: Boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    procedure UpdateTime(DrawAll: Boolean);
    property Canvas;
  published
    { Published declarations }
    property FaceShape: TShapeType read FFaceShape write SetFaceShape;
    property BackColor: TColor read FBackColor write SetBackColor;
    property FaceColor: TColor read FFaceColor write SetFaceColor;
    property HandColor: TColor read FHandColor write SetHandColor;
    property Time: TTime read FTime write SetTime;
    property ShowSeconds: Boolean read FShowSeconds write SetShowSeconds;
    property HandMode: THandMode read FHandMode write SetHandMode;
    property HandShape: THandShape read FHandShape write SetHandShape;
    property HoursVisible: Boolean read FHoursVisible write SetHoursVisible;
    property Align;
    property PopupMenu;
    property ShowHint;
    property ParentShowHint;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

procedure TClock.SetFaceShape(Value: TShapeType);
begin
  if Value<>FFaceShape then
  begin
    FFaceShape:=Value;
    Paint;
  end;
end;

procedure TClock.SetBackColor(Value: TColor);
begin
  if Value<>FBackColor then
  begin
    FBackColor:=Value;
    Paint;
  end;
end;

procedure TClock.SetFaceColor(Value: TColor);
begin
  if Value<>FFaceColor then
  begin
    FFaceColor:=Value;
    Paint;
  end;
end;

procedure TClock.SetHandColor(Value: TColor);
begin
  if Value<>FHandColor then
  begin
    FHandColor:=Value;
    Paint;
  end;
end;

procedure TClock.SetTime(Value: TTime);
var
  OH,OM,OS,NH,NM,NS,S100: Word;
begin
  DecodeTime(Value,NH,NM,NS,S100);
  DecodeTime(FTime,OH,OM,OS,S100);
  if (NH<>OH) or (NM<>OM) or (NS<>OS) then
  begin
    FTime:=Value;
    UpdateTime(False);
  end;
end;

procedure TClock.SetShowSeconds(Value: Boolean);
begin
  if Value<>FShowSeconds then
  begin
    FShowSeconds:=Value;
    Paint;
  end;
end;

procedure TClock.SetHandMode(Value: THandMode);
begin
  if Value<>FHandMode then
  begin
    FHandMode:=Value;
    Paint;
  end;
end;

procedure TClock.SetHandShape(Value: THandShape);
begin
  if Value<>FHandShape then
  begin
    FHandShape:=Value;
    Paint;
  end;
end;

procedure TClock.SetHoursVisible(Value: Boolean);
begin
  if Value<>FHoursVisible then
  begin
    FHoursVisible:=Value;
    Paint;
  end;
end;

constructor TClock.Create(AOwner: TComponent);
begin
  inherited;
  FBackColor:=clBlack;
  FFaceColor:=clSilver;
  FHandColor:=clGray;
  FTime:=EncodeTime(9,0,0,0);
  FOldTime:=FTime;
  Width:=100;
  Height:=100;
end;

procedure TClock.Paint;
var
  Rect: TRect;
  i,Radius,CX,CY,CS,HS: Integer;
begin
  with Canvas,Rect do
  begin
    Brush.Color:=FBackColor;
    Brush.Style:=bsSolid;
    FillRect(ClientRect);
    if FFaceShape in [stSquare,stRoundSquare,stCircle] then
      if ClientWidth>ClientHeight then
      begin
        Left:=(ClientWidth-ClientHeight) div 2;
        Right:=ClientWidth-(ClientWidth-ClientHeight) div 2;
        Top:=0;
        Bottom:=ClientHeight;
      end
      else
      begin
        Top:=(ClientHeight-ClientWidth) div 2;
        Bottom:=ClientHeight-(ClientHeight-ClientWidth) div 2;
        Left:=0;
        Right:=ClientWidth;
      end
    else Rect:=ClientRect;
    Brush.Color:=FaceColor;
    Brush.Style:=bsSolid;
    Pen.Color:=FaceColor;
    case FFaceShape of
      stEllipse,stCircle: Ellipse(Left,Top,Right,Bottom);
      stRectangle,stSquare: Rectangle(Left,Top,Right,Bottom);
      stRoundRect,stRoundSquare: RoundRect(Left,Top,Right,Bottom,(Bottom-Top) div 4,(Right-Left) div 4);
    end;
    if ClientWidth>ClientHeight then CS:=ClientHeight div 30
    else CS:=ClientWidth div 30;
    Left:=ClientWidth div 2-CS;
    Right:=ClientWidth div 2+CS;
    Top:=ClientHeight div 2-CS;
    Bottom:=ClientHeight div 2+CS;
    with Brush do
      case HandMode of
        hmNormal:
        begin
          Color:=FaceColor;
          Style:=bsSolid;
        end;
        hmFilled:
        begin
          Color:=HandColor;
          Style:=bsSolid;
        end;
        hmTransparent: Brush.Style:=bsClear;
      end;
    Pen.Color:=HandColor;
    Ellipse(Left,Top,Right,Bottom);
    if FHoursVisible then
    begin
      if ClientWidth>ClientHeight then Radius:=ClientHeight div 2-CS
      else Radius:=ClientWidth div 2-CS;
      HS:=CS div 2;
      if HS<1 then HS:=1;
      for i:=0 to 11 do
      begin
        CX:=Round(Radius*Cos(Pi*i/6))+ClientWidth div 2;
        CY:=Round(Radius*Sin(Pi*i/6))+ClientHeight div 2;
        Ellipse(CX-HS,CY-HS,CX+HS,CY+HS);
      end;
    end;
  end;
  UpdateTime(True);
end;

procedure TClock.UpdateTime(DrawAll: Boolean);

var
  Center: TPoint;
  WH,HH,WM,HM,OHA,NHA,CS: Integer;
  OldHour,OldMin,OldSec,NewHour,NewMin,NewSec,Sec100: Word;

  procedure DrawSlopingRect(W,H: Integer; Minutes: Double; Erase: Boolean);
  var
    Poly: array[1..4] of TPoint;
    Angle: Double;
  begin
    Angle:=Pi*((Minutes-15)/30);
    Poly[1]:=Point(
      Round(Center.X-(W div 2)*Sin(Angle))+Round(2*CS*Cos(Angle)),
      Round(Center.Y+(W div 2)*Cos(Angle))+Round(2*CS*Sin(Angle)));
    Poly[2]:=Point(
      Round(Center.X+(W div 2)*Sin(Angle))+Round(2*CS*Cos(Angle)),
      Round(Center.Y-(W div 2)*Cos(Angle))+Round(2*CS*Sin(Angle)));
    case HandShape of
      hsTrapeze: W:=W div 2;
      hsTriangle: W:=0;
    end;
    Poly[3]:=Point(
      Round(Center.X+(W div 2)*Sin(Angle))+Round(H*Cos(Angle)),
      Round(Center.Y-(W div 2)*Cos(Angle))+Round(H*Sin(Angle)));
    Poly[4]:=Point(
      Round(Center.X-(W div 2)*Sin(Angle))+Round(H*Cos(Angle)),
      Round(Center.Y+(W div 2)*Cos(Angle))+Round(H*Sin(Angle)));
    with Canvas do
    begin
      if Erase then
      begin
        Brush.Color:=FaceColor;
        Brush.Style:=bsSolid;
        Pen.Color:=FaceColor;
      end
      else
      begin
        Brush.Color:=HandColor;
        case HandMode of
          hmNormal:
          begin
            Brush.Style:=bsSolid;
            Brush.Color:=FaceColor;
          end;
          hmFilled:
          begin
            Brush.Style:=bsSolid;
            Brush.Color:=HandColor;
          end;
          hmTransparent: Brush.Style:=bsClear;
        end;
        Pen.Color:=HandColor;
      end;
      Polygon(Poly);
    end;
  end;

begin
  with Canvas do
  begin
    Center.X:=ClientWidth div 2;
    Center.Y:=ClientHeight div 2;
    if ClientWidth>ClientHeight then
    begin
      WH:=ClientHeight div 30;
      HH:=ClientHeight div 4;
      WM:=ClientHeight div 50;
      HM:=5*ClientHeight div 12;
      CS:=ClientHeight div 30;
    end
    else
    begin
      WH:=ClientWidth div 30;
      HH:=ClientWidth div 4;
      WM:=ClientWidth div 50;
      HM:=5*ClientWidth div 12;
      CS:=ClientWidth div 30;
    end;
    DecodeTime(FOldTime,OldHour,OldMin,OldSec,Sec100);
    DecodeTime(FTime,NewHour,NewMin,NewSec,Sec100);
    OHA:=OldHour*5+OldMin div 12;
    NHA:=NewHour*5+NewMin div 12;
    if (OHA<>NHA) or DrawAll then DrawSlopingRect(WH,HH,OHA,True);
    if (OldMin<>NewMin) or DrawAll then DrawSlopingRect(WM,HM,OldMin,True);
    if FShowSeconds and (OldSec<>NewSec) or DrawAll then
      DrawSlopingRect(WM div 2,HM,OldSec,True);
    DrawSlopingRect(WH,HH,NHA,False);
    DrawSlopingRect(WM,HM,NewMin,False);
    if FShowSeconds then DrawSlopingRect(WM div 2,HM,NewSec,False);
    FOldTime:=FTime;
  end;
end;

procedure Register;
begin
  RegisterComponents('Greatis', [TClock]);
end;

end.
