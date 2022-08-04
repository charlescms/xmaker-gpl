(*  GREATIS CONTROL DESIGNER             *)
(*  unit version 1.00.001                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/ctrldes.htm   *)
(*  b-team@greatis.com                   *)

unit CtrlDes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls;

type

  TMouseZone = (mzNone,mzFrame,mzLeftTop,mzCenterTop,mzRightTop,mzLeftCenter,mzRightCenter,mzLeftBottom,mzCenterBottom,mzRightBottom);
  THintMode = (hmMove,hmSize);
  TControlEvent = procedure(Sender: TObject; TheControl: TControl) of object;
  TControlAllowEvent = procedure(Sender: TObject; TheControl: TControl; var Allow: Boolean) of object;

  TCustomControlDesigner = class;

  TControlDesignerFrame = class(TCustomControl)
  private
    { Private declarations }
    FRegion: HRGN;
    FDragRect: TRect;
    FDragPoint: TPoint;
    FDragZone: TMouseZone;
    FHintWindow: THintWindow;
    FControl: TControl;
    FThickness: Integer;
    FDirectDrag: Boolean;
    FMinSize: Integer;
    FShowMoveSizeHint: Boolean;
    FBorderColor: TColor;
    FFrameColor: TColor;
    FGrabColor: TColor;
    FEnableKeys: Boolean;
    FOnAllowSelectControl: TControlAllowEvent;
    FOnSelectControl: TControlEvent;
    FOnAllowDragControl: TControlAllowEvent;
    FOnDragControl: TControlEvent;
    FOnDblClick: TNotifyEvent;
    procedure UpdateShape;
    function MouseZone(X,Y: Integer): TMouseZone;
    procedure DrawDragRect;
    procedure ShowDragHint(AHint: string);
    procedure HideDragHint;
    function GetDesigner: TCustomControlDesigner;
    procedure SetControl(const Value: TControl);
    procedure SetThickness(const Value: Integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetFrameColor(const Value: TColor);
    procedure SetGrabColor(const Value: TColor);
    procedure SetEnableKeys(const Value: Boolean);
  protected
    { Protected declarations }
    procedure CreateHandle; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdatePosition;
    property Designer: TCustomControlDesigner read GetDesigner;
    property Control: TControl read FControl write SetControl;
    property Thickness: Integer read FThickness write SetThickness;
    property DirectDrag: Boolean read FDirectDrag write FDirectDrag;
    property MinSize: Integer read FMinSize write FMinSize;
    property ShowMoveSizeHint: Boolean read FShowMoveSizeHint write FShowMoveSizeHint;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property FrameColor: TColor read FFrameColor write SetFrameColor;
    property GrabColor: TColor read FGrabColor write SetGrabColor;
    property EnableKeys: Boolean read FEnableKeys write SetEnableKeys;
    property OnAllowSelectControl: TControlAllowEvent read FOnAllowSelectControl write FOnAllowSelectControl;
    property OnSelectControl: TControlEvent read FOnSelectControl write FOnSelectControl;
    property OnAllowDragControl: TControlAllowEvent read FOnAllowDragControl write FOnAllowDragControl;
    property OnDragControl: TControlEvent read FOnDragControl write FOnDragControl;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

  TCustomControlDesigner = class(TComponent)
  private
    { Private declarations }
    FFrame: TControlDesignerFrame;
    FActive: Boolean;
    procedure SetActive(const Value: Boolean);
    function GetControl: TControl;
    procedure SetControl(const Value: TControl);
    function GetThickness: Integer;
    procedure SetThickness(const Value: Integer);
    function GetDirectDrag: Boolean;
    procedure SetDirectDrag(const Value: Boolean);
    function GetMinSize: Integer;
    procedure SetMinSize(const Value: Integer);
    function GetShowMoveSizeHint: Boolean;
    procedure SetShowMoveSizeHint(const Value: Boolean);
    function GetBorderColor: TColor;
    procedure SetBorderColor(const Value: TColor);
    function GetFrameColor: TColor;
    procedure SetFrameColor(const Value: TColor);
    function GetGrabColor: TColor;
    procedure SetGrabColor(const Value: TColor);
    function GetEnableKeys: Boolean;
    procedure SetEnableKeys(const Value: Boolean);
    function GetOnAllowSelectControl: TControlAllowEvent;
    procedure SetOnAllowSelectControl(const Value: TControlAllowEvent);
    function GetOnSelectControl: TControlEvent;
    procedure SetOnSelectControl(const Value: TControlEvent);
    function GetOnAllowDragControl: TControlAllowEvent;
    procedure SetOnAllowDragControl(const Value: TControlAllowEvent);
    function GetOnDragControl: TControlEvent;
    procedure SetOnDragControl(const Value: TControlEvent);
    function GetOnDblClick: TNotifyEvent;
    procedure SetOnDblClick(const Value: TNotifyEvent);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Update; virtual;
    property Active: Boolean read FActive write SetActive;
    property Control: TControl read GetControl write SetControl;
    property Thickness: Integer read GetThickness write SetThickness;
    property DirectDrag: Boolean read GetDirectDrag write SetDirectDrag;
    property MinSize: Integer read GetMinSize write SetMinSize;
    property ShowMoveSizeHint: Boolean read GetShowMoveSizeHint write SetShowMoveSizeHint;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property FrameColor: TColor read GetFrameColor write SetFrameColor;
    property GrabColor: TColor read GetGrabColor write SetGrabColor;
    property EnableKeys: Boolean read GetEnableKeys write SetEnableKeys;
    property OnAllowSelectControl: TControlAllowEvent read GetOnAllowSelectControl write SetOnAllowSelectControl;
    property OnSelectControl: TControlEvent read GetOnSelectControl write SetOnSelectControl;
    property OnAllowDragControl: TControlAllowEvent read GetOnAllowDragControl write SetOnAllowDragControl;
    property OnDragControl: TControlEvent read GetOnDragControl write SetOnDragControl;
    property OnDblClick: TNotifyEvent read GetOnDblClick write SetOnDblClick;
  end;

  TControlDesigner = class(TCustomControlDesigner)
  published
    { Published declarations }
    property Active;
    property Control;
    property Thickness;
    property DirectDrag;
    property MinSize;
    property ShowMoveSizeHint;
    property BorderColor;
    property FrameColor;
    property GrabColor;
    property EnableKeys;
    property OnAllowSelectControl;
    property OnSelectControl;
    property OnAllowDragControl;
    property OnDragControl;
    property OnDblClick;
  end;

procedure Register;

implementation

procedure TControlDesignerFrame.UpdateShape;
var
  R: TRect;
  RGN: HRGN;
begin
  if FRegion<>0 then DeleteObject(FRegion);
  R:=Rect(0,0,Width,Height);
  with R do FRegion:=CreateRectRgn(Left,Top,Right,Bottom);
  InflateRect(R,-FThickness,-FThickness);
  with R do RGN:=CreateRectRgn(Left,Top,Right,Bottom);
  try
    CombineRgn(FRegion,FRegion,RGN,RGN_DIFF);
  finally
    DeleteObject(RGN);
  end;
  SetWindowRgn(Handle,FRegion,True);
end;

function TControlDesignerFrame.MouseZone(X,Y: Integer): TMouseZone;
begin
  Result:=mzNone;
  if Y<=FThickness then
    if X<=FThickness then Result:=mzLeftTop
    else
      if X>=Width-FThickness then Result:=mzRightTop
      else
        if (X>=(Width-FThickness) div 2) and (X<=(Width+FThickness) div 2) then Result:=mzCenterTop
        else Result:=mzFrame
  else
    if Y>=Height-FThickness then
      if X<=FThickness then Result:=mzLeftBottom
      else
        if X>=Width-FThickness then Result:=mzRightBottom
        else
          if (X>=(Width-FThickness) div 2) and (X<=(Width+FThickness) div 2) then Result:=mzCenterBottom
          else Result:=mzFrame
    else
      if X<=FThickness then
        if (Y>=(Height-FThickness) div 2) and (Y<=(Height+FThickness) div 2) then Result:=mzLeftCenter
        else Result:=mzFrame
      else
        if X>=Width-FThickness then
          if (Y>=(Height-FThickness) div 2) and (Y<=(Height+FThickness) div 2) then Result:=mzRightCenter
          else Result:=mzFrame;
end;

procedure TControlDesignerFrame.DrawDragRect;
var
  ParentCanvas: TCanvas;
begin
  if Assigned(Parent) then
  begin
    ParentCanvas:=TCanvas.Create;
    with ParentCanvas do
    begin
      Handle:=GetDCEx(Parent.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS or DCX_PARENTCLIP);
      try
        with Pen do
        begin
          Style:=psSolid;
          Mode:=pmXor;
          Width:=2;
          Color:=clGray;
        end;
        Brush.Style:=bsClear;
        with FDragRect do Rectangle(Left+1,Top+1,Right,Bottom);
      finally
        ReleaseDC(0,ParentCanvas.Handle);
        ParentCanvas.Handle:=0;
      end;
    end;
  end;
end;

procedure TControlDesignerFrame.ShowDragHint(AHint: string);
var
  R: TRect;
  P: TPoint;
begin
  if FShowMoveSizeHint then
    with FHintWindow do
    begin
      R:=CalcHintRect(255,AHint,nil);
      GetCursorPos(P);
      OffsetRect(R,P.X,P.Y+12);
      ActivateHint(R,AHint);
    end;
end;

procedure TControlDesignerFrame.HideDragHint;
begin
  FHintWindow.ReleaseHandle;
end;

function TControlDesignerFrame.GetDesigner: TCustomControlDesigner;
begin
  if Assigned(Owner) and (Owner is TCustomControlDesigner) then
    Result:=TCustomControlDesigner(Owner)
  else Result:=nil;
end;

procedure TControlDesignerFrame.SetControl(const Value: TControl);
var
  Allow: Boolean;
begin
  if (csDesigning in ComponentState) or not Assigned(Designer) or not Designer.Active then
  begin
    FControl:=Value;
    Visible:=False;
  end
  else
  begin
    Allow:=True;
    if Assigned(Designer) and Assigned(Designer.OnAllowSelectControl) then
      Designer.OnAllowSelectControl(Designer,Value,Allow);
    if Allow then
    begin
      FControl:=Value;
      Visible:=Assigned(FControl);
      UpdatePosition;
      if Assigned(Designer) and Assigned(Designer.OnSelectControl) then
        Designer.OnSelectControl(Designer,FControl);
      if FEnableKeys and Showing and CanFocus then SetFocus;
    end;
  end;
end;

procedure TControlDesignerFrame.SetThickness(const Value: Integer);
begin
  if Value<>FThickness then
  begin
    FThickness:=Value;
    UpdatePosition;
  end;
end;

procedure TControlDesignerFrame.SetBorderColor(const Value: TColor);
begin
  if Value<>FBorderColor then
  begin
    FBorderColor:=Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetFrameColor(const Value: TColor);
begin
  if Value<>FFrameColor then
  begin
    FFrameColor:=Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetGrabColor(const Value: TColor);
begin
  if Value<>FGrabColor then
  begin
    FGrabColor:=Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetEnableKeys(const Value: Boolean);
begin
  FEnableKeys:=Value;
  if FEnableKeys and Showing and CanFocus then SetFocus;
end;

procedure TControlDesignerFrame.CreateHandle;
begin
  inherited;
  UpdatePosition;
end;

procedure TControlDesignerFrame.Paint;
var
  T: Integer;
begin
  with Canvas do
  begin
    Pen.Color:=FBorderColor;
    Brush.Color:=FFrameColor;
    Rectangle(0,0,Width,Height);
    Rectangle(Pred(FThickness),Pred(FThickness),Width-Pred(FThickness),Height-Pred(FThickness));
    Brush.Color:=FGrabColor;
    T:=FThickness;
    Rectangle((Width-T) div 2,0,(Width+T) div 2,T);
    Rectangle((Width-T) div 2,(Height-T),(Width+T) div 2,Height);
    Rectangle(0,(Height-T) div 2,T,(Height+T) div 2);
    Rectangle(Width-T,(Height-T) div 2,Width,(Height+T) div 2);
    Rectangle(0,0,T,T);
    Rectangle(Width-T,0,Width,T);
    Rectangle(0,Height-T,T,Height);
    Rectangle(Width-T,Height-T,Width,Height);
  end;
end;

procedure TControlDesignerFrame.WndProc(var Message: TMessage);
var
  P: TPoint;
  R: TRect;
  X,Y,Step: Integer;
  Shift: Boolean;
begin
  with Message do
    case Msg of
      WM_SETCURSOR:
      begin
        GetCursorPos(P);
        P:=ScreenToClient(P);
        case MouseZone(P.X,P.Y) of
          mzFrame: SetCursor(LoadCursor(0,IDC_SIZEALL));
          mzLeftTop,mzRightBottom: SetCursor(LoadCursor(0,IDC_SIZENWSE));
          mzLeftBottom,mzRightTop: SetCursor(LoadCursor(0,IDC_SIZENESW));
          mzCenterTop,mzCenterBottom: SetCursor(LoadCursor(0,IDC_SIZENS));
          mzLeftCenter,mzRightCenter: SetCursor(LoadCursor(0,IDC_SIZEWE));
        end;
      end;
      WM_LBUTTONDOWN:
      begin
        Visible:=False;
        FDragRect:=FControl.Parent.ClientRect;
        MapWindowPoints(FControl.Parent.Handle,HWND_DESKTOP,FDragRect,2);
        ClipCursor(@FDragRect);
        FDragRect:=FControl.BoundsRect;
        FDragZone:=MouseZone(lParamLo,lParamHi);
        GetCursorPos(FDragPoint);
        if not FDirectDrag then DrawDragRect;
        SetCapture(Handle);
      end;
      WM_MOUSEMOVE:
        if FDragZone<>mzNone then
        begin
          GetCursorPos(P);
          R:=FDragRect;
          with R do
          begin
            X:=P.X-FDragPoint.X;
            Y:=P.Y-FDragPoint.Y;
            case FDragZone of
              mzFrame: OffsetRect(R,X,Y);
              mzLeftTop:
              begin
                Inc(Left,X);
                Inc(Top,Y);
              end;
              mzCenterTop: Inc(Top,Y);
              mzRightTop:
              begin
                Inc(Right,X);
                Inc(Top,Y);
              end;
              mzLeftCenter: Inc(Left,X);
              mzRightCenter: Inc(Right,X);
              mzLeftBottom:
              begin
                Inc(Left,X);
                Inc(Bottom,Y);
              end;
              mzCenterBottom: Inc(Bottom,Y);
              mzRightBottom:
              begin
                Inc(Right,X);
                Inc(Bottom,Y);
              end;
            end;
            if Right-Left<FMinSize then
              case FDragZone of
                mzLeftTop,mzLeftCenter,mzLeftBottom: Left:=Right-FMinSize;
                mzRightTop,mzRightCenter,mzRightBottom: Right:=Left+FMinSize;
              end;
            if Bottom-Top<FMinSize then
              case FDragZone of
                mzLeftTop,mzCenterTop,mzRightTop: Top:=Bottom-FMinSize;
                mzLeftBottom,mzCenterBottom,mzRightBottom: Bottom:=Top+FMinSize;
              end;
            if not EqualRect(R,FDragRect) then
            begin
              HideDragHint;
              if not FDirectDrag then DrawDragRect;
              FDragRect:=R;
              GetCursorPos(FDragPoint);
              if not FDirectDrag then DrawDragRect
              else FControl.BoundsRect:=FDragRect;
              if FDragZone=mzFrame then ShowDragHint(Format('%d, %d',[Left,Top]))
              else ShowDragHint(Format('%d x %d',[Right-Left,Bottom-Top]));
            end;
          end;
        end;
      WM_LBUTTONUP:
      begin
        ClipCursor(nil);
        if GetCapture=Handle then ReleaseCapture;
        HideDragHint;
        if not FDirectDrag then
        begin
          DrawDragRect;
          Control.BoundsRect:=FDragRect;
        end;
        FDragZone:=mzNone;
        UpdatePosition;
        Visible:=Assigned(FControl);
        if Assigned(FControl) and Assigned(FOnDragControl) then FOnDragControl(Self,FControl);
      end;
      WM_LBUTTONDBLCLK:
        if Assigned(Designer) and Assigned(Designer.OnDblClick) then
          Designer.OnDblClick(Designer)
        else
          if not FDirectDrag then DrawDragRect;
      WM_NCPAINT: if FEnableKeys then SetFocus;
      CM_CHILDKEY:
        if Assigned(FControl) then
        begin
          if GetKeyState(VK_CONTROL) and $80 <> 0 then Step:=8
          else Step:=1;
          Shift:=GetKeyState(VK_SHIFT) and $80 <> 0;
          with FControl do
            case wParam of
              VK_LEFT:
                if Shift then
                begin
                  X:=Width-Step;
                  if X<FMinSize then X:=FMinSize;
                  if X<>Width then Width:=X;
                end
                else Left:=Left-Step;
              VK_RIGHT:
                if Shift then Width:=Width+Step
                else Left:=Left+Step;
              VK_UP:
                if Shift then
                begin
                  Y:=Height-Step;
                  if Y<FMinSize then Y:=FMinSize;
                  if Y<>Height then Height:=Y;
                end
                else Top:=Top-Step;
              VK_DOWN:
                if Shift then Height:=Height+Step
                else Top:=Top+Step;
            else
            begin
              inherited;
              Exit;
            end;
            end;
          UpdatePosition;
          Result:=1;
        end;
      else inherited;
    end;
end;

constructor TControlDesignerFrame.Create(AOwner: TComponent);
begin
  inherited;
  FHintWindow:=THintWindow.Create(Self);
  FHintWindow.Color:=clInfoBk;
  FThickness:=8;
  FMinSize:=8;
  FShowMoveSizeHint:=True;
  FBorderColor:=clGray;
  FGrabColor:=clWhite;
  FFrameColor:=clGray;
end;

destructor TControlDesignerFrame.Destroy;
begin
  DeleteObject(FRegion);
  inherited;
end;

procedure TControlDesignerFrame.UpdatePosition;
var
  R: TRect;
begin
  if not (csDesigning in ComponentState) and Assigned(FControl) then
  begin
    R:=FControl.BoundsRect;
    InflateRect(R,FThickness,FThickness);
    BoundsRect:=R;
    Parent:=FControl.Parent;
    BringToFront;
    UpdateShape;
  end;
end;

procedure TCustomControlDesigner.SetActive(const Value: Boolean);
begin
  FActive:=Value;
  if Assigned(FFrame) then FFrame.Visible:=FActive and not (csDesigning in ComponentState);
end;

function TCustomControlDesigner.GetControl: TControl;
begin
  if Assigned(FFrame) then Result:=FFrame.Control
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetControl(const Value: TControl);
begin
  if Assigned(FFrame) then FFrame.Control:=Value;
end;

function TCustomControlDesigner.GetThickness: Integer;
begin
  if Assigned(FFrame) then Result:=FFrame.Thickness
  else Result:=0;
end;

procedure TCustomControlDesigner.SetThickness(const Value: Integer);
begin
  if Assigned(FFrame) then FFrame.Thickness:=Value;
end;

function TCustomControlDesigner.GetDirectDrag: Boolean;
begin
  if Assigned(FFrame) then Result:=FFrame.DirectDrag
  else Result:=False;
end;

procedure TCustomControlDesigner.SetDirectDrag(const Value: Boolean);
begin
  if Assigned(FFrame) then FFrame.DirectDrag:=Value;
end;

function TCustomControlDesigner.GetMinSize: Integer;
begin
  if Assigned(FFrame) then Result:=FFrame.MinSize
  else Result:=0;
end;

procedure TCustomControlDesigner.SetMinSize(const Value: Integer);
begin
  if Assigned(FFrame) then FFrame.MinSize:=Value;
end;

function TCustomControlDesigner.GetShowMoveSizeHint: Boolean;
begin
  if Assigned(FFrame) then Result:=FFrame.ShowMoveSizeHint
  else Result:=False;
end;

procedure TCustomControlDesigner.SetShowMoveSizeHint(const Value: Boolean);
begin
  if Assigned(FFrame) then FFrame.ShowMoveSizeHint:=Value;
end;

function TCustomControlDesigner.GetBorderColor: TColor;
begin
  if Assigned(FFrame) then Result:=FFrame.BorderColor
  else Result:=clBlack;
end;

procedure TCustomControlDesigner.SetBorderColor(const Value: TColor);
begin
  if Assigned(FFrame) then FFrame.BorderColor:=Value;
end;

function TCustomControlDesigner.GetFrameColor: TColor;
begin
  if Assigned(FFrame) then Result:=FFrame.FrameColor
  else Result:=clBlack;
end;

procedure TCustomControlDesigner.SetFrameColor(const Value: TColor);
begin
  if Assigned(FFrame) then FFrame.FrameColor:=Value;
end;

function TCustomControlDesigner.GetGrabColor: TColor;
begin
  if Assigned(FFrame) then Result:=FFrame.GrabColor
  else Result:=clBlack;
end;

procedure TCustomControlDesigner.SetGrabColor(const Value: TColor);
begin
  if Assigned(FFrame) then FFrame.GrabColor:=Value;
end;

function TCustomControlDesigner.GetEnableKeys: Boolean;
begin
  if Assigned(FFrame) then Result:=FFrame.EnableKeys
  else Result:=False;
end;

procedure TCustomControlDesigner.SetEnableKeys(const Value: Boolean);
begin
  if Assigned(FFrame) then FFrame.EnableKeys:=Value;
end;

function TCustomControlDesigner.GetOnAllowSelectControl: TControlAllowEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnAllowSelectControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnAllowSelectControl(const Value: TControlAllowEvent);
begin
  if Assigned(FFrame) then FFrame.OnAllowSelectControl:=Value;
end;

function TCustomControlDesigner.GetOnSelectControl: TControlEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnSelectControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnSelectControl(const Value: TControlEvent);
begin
  if Assigned(FFrame) then FFrame.OnSelectControl:=Value;
end;

function TCustomControlDesigner.GetOnAllowDragControl: TControlAllowEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnAllowDragControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnAllowDragControl(const Value: TControlAllowEvent);
begin
  if Assigned(FFrame) then FFrame.OnAllowDragControl:=Value;
end;

function TCustomControlDesigner.GetOnDragControl: TControlEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnDragControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnDragControl(const Value: TControlEvent);
begin
  if Assigned(FFrame) then FFrame.OnDragControl:=Value;
end;

function TCustomControlDesigner.GetOnDblClick: TNotifyEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnDblClick
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnDblClick(const Value: TNotifyEvent);
begin
  if Assigned(FFrame) then FFrame.FOnDblClick:=Value;
end;

constructor TCustomControlDesigner.Create(AOwner: TComponent);
begin
  inherited;
  FFrame:=TControlDesignerFrame.Create(Self);
end;

procedure TCustomControlDesigner.Update;
begin
  if Assigned(Control) then FFrame.UpdatePosition;
end;

procedure Register;
begin
  RegisterComponents('Designers', [TControlDesigner]);
end;

end.
