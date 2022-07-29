{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvXPCheckCtrls.PAS, released on 2004-01-01.

The Initial Developer of the Original Code is Marc Hoffman.
Portions created by Marc Hoffman are Copyright (C) 2002 APRIORI business solutions AG.
Portions created by APRIORI business solutions AG are Copyright (C) 2002 APRIORI business solutions AG
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvXPCheckCtrls.pas,v 1.21 2005/02/17 10:21:18 marquardt Exp $

unit JvXPCheckCtrls;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  Classes, Windows, Graphics, Controls,
  JvXPCore, JvXPCoreUtils;

type
  TJvXPCustomCheckControl = class(TJvXPCustomStyleControl)
  private
    FBgGradient: TBitmap;
    FBoundLines: TJvXPBoundLines;
    FChecked: Boolean;
    FCheckSize: Byte;
    FCkGradient: TBitmap;
    FHlGradient: TBitmap;
    FSpacing: Byte;
  protected
    procedure SetBoundLines(Value: TJvXPBoundLines); virtual;
    procedure SetChecked(Value: Boolean); virtual;
    procedure SetSpacing(Value: Byte); virtual;
    procedure DrawCheckSymbol(const R: TRect); virtual; abstract;
    procedure Click; override;
    procedure Paint; override;
    procedure HookResized; override;
    property BoundLines: TJvXPBoundLines read FBoundLines write SetBoundLines default [];
    property Checked: Boolean read FChecked write SetChecked default False;
    property Spacing: Byte read FSpacing write SetSpacing default 3;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TJvXPCheckbox = class(TJvXPCustomCheckControl)
  protected
    procedure DrawCheckSymbol(const R: TRect); override;
  published
    // common properties.
    property Caption;
    property Enabled;
    property TabOrder;
    property TabStop default True;
    // advanced properties.
    property BoundLines;
    property Checked;
    property Spacing;
    property ParentColor;
    property Color;
    //property BevelInner;
    //property BevelOuter;
    //property BevelWidth;
    //property BiDiMode;
    //property Ctl3D;
    //property DockSite;
    //property ParentBiDiMode;
    //property ParentCtl3D;
    //property TabOrder;
    //property TabStop;
    //property UseDockManager default True;
    property Align;
    property Anchors;
    //property AutoSize;
    property Constraints;
    {$IFDEF VCL}
    property BiDiMode;
    property DragCursor;
    property DragKind;
    property OnCanResize;
    {$ENDIF VCL}
    property DragMode;
    //property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property StyleManager;
    property Visible;
    //property OnDockDrop;
    //property OnDockOver;
    //property OnEndDock;
    //property OnGetSiteInfo;
    //property OnStartDock;
    //property OnUnDock;
    property OnClick;
    property OnConstrainedResize;
    {$IFDEF COMPILER6_UP}
    property OnContextPopup;
    {$ENDIF COMPILER6_UP}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvXPCheckCtrls.pas,v $';
    Revision: '$Revision: 1.21 $';
    Date: '$Date: 2005/02/17 10:21:18 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

//=== { TJvXPCustomCheckControl } ============================================

constructor TJvXPCustomCheckControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // set default properties.
  ControlStyle := ControlStyle - [csDoubleClicks];
  Height := 17;
  TabStop := True;
  Width := 161;

  // set custom properties.
  FBoundLines := [];
  FChecked := False;
  FCheckSize := 13;
  FSpacing := 3;

  // create ...
  FBgGradient := TBitmap.Create; // background gradient
  FCkGradient := TBitmap.Create; // clicked gradient
  FHlGradient := TBitmap.Create; // Highlight gradient
end;

destructor TJvXPCustomCheckControl.Destroy;
begin
  FBgGradient.Free;
  FCkGradient.Free;
  FHlGradient.Free;
  inherited Destroy;
end;

procedure TJvXPCustomCheckControl.Click;
begin
  // (rom) using FChecked here seemed wrong (no painting)
  Checked := not Checked;
  inherited Click;
end;

procedure TJvXPCustomCheckControl.HookResized;
begin
  // create gradient rectangles for...

  // background.
  JvXPCreateGradientRect(FCheckSize - 2, FCheckSize - 2, dxColor_Btn_Enb_BgFrom_WXP,
    dxColor_Btn_Enb_BgTo_WXP, 16, gsTop, False, FBgGradient);

  // clicked.
  JvXPCreateGradientRect(FCheckSize - 2, FCheckSize - 2, dxColor_Btn_Enb_CkFrom_WXP,
    dxColor_Btn_Enb_CkTo_WXP, 16, gsTop, True, FCkGradient);

  // highlight.
  JvXPCreateGradientRect(FCheckSize - 2, FCheckSize - 2, dxColor_Btn_Enb_HlFrom_WXP,
    dxColor_Btn_Enb_HlTo_WXP, 16, gsTop, True, FHlGradient);

  LockedInvalidate;
end;

procedure TJvXPCustomCheckControl.SetBoundLines(Value: TJvXPBoundLines);
begin
  if Value <> FBoundLines then
  begin
    FBoundLines := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomCheckControl.SetChecked(Value: Boolean);
begin
  if Value <> FChecked then
  begin
    FChecked := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomCheckControl.SetSpacing(Value: Byte);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomCheckControl.Paint;
var
  Rect: TRect;
  BoundColor: TColor;
begin
  with Canvas do
  begin
    // clear background.
    Rect := GetClientRect;
    Brush.Color := Color;
    FillRect(Rect);
    // draw designtime rect.
    if csDesigning in ComponentState then
      DrawFocusRect(Rect);

    // draw boundlines.
    if BoundLines <> [] then
    begin
      if Style.GetTheme = WindowsXP then
        BoundColor := dxColor_Btn_Enb_Border_WXP
      else
        BoundColor := dxColor_DotNetFrame;
      JvXPDrawBoundLines(Self.Canvas, BoundLines, BoundColor, Rect);
    end;

    // draw focusrect.
    if dsFocused in DrawState then
    begin
      Brush.Style := bsSolid;
      DrawFocusRect(Rect);
    end;

    // draw check symbol.
    DrawCheckSymbol(Rect);

    // draw caption.
    SetBkMode(Handle, Transparent);
    Font.Assign(Self.Font);
    {$IFDEF VCL}
    if BiDiMode = bdRightToLeft then
    begin
      Dec(Rect.Right, FCheckSize + 4 + Spacing);
      JvXPPlaceText(Self, Canvas, Caption, Font, Enabled, True, taRightJustify, True, Rect)
    end
    else
    {$ENDIF VCL}
    begin
      Inc(Rect.Left, FCheckSize + 4 + Spacing);
      JvXPPlaceText(Self, Canvas, Caption, Font, Enabled, True, taLeftJustify, True, Rect);
    end;
   end;
end;

//=== { TJvXPCheckbox } ======================================================

procedure TJvXPCheckbox.DrawCheckSymbol(const R: TRect);
var
  ClipW: Integer;
  Bitmap: TBitmap;
  Theme: TJvXPTheme;

  procedure DrawGradient(const Bitmap: TBitmap);
  begin
    {$IFDEF VCL}
    if BiDiMode = bdRightToLeft then
      BitBlt(Canvas.Handle, R.Right - 1 - FCheckSize, (ClientHeight - FCheckSize) div 2 + 1,
        FCheckSize - 2, FCheckSize - 2, Bitmap.Canvas.Handle, 0, 0, SRCCOPY)
    else
      BitBlt(Canvas.Handle, R.Left + 3, (ClientHeight - FCheckSize) div 2 + 1,
        FCheckSize - 2, FCheckSize - 2, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
      BitBlt(Canvas, R.Left + 3, (ClientHeight - FCheckSize) div 2 + 1,
        FCheckSize - 2, FCheckSize - 2, Bitmap.Canvas, 0, 0, SRCCOPY);
    {$ENDIF VisualCLX}
  end;

begin
  // get current theme.
  Theme := Style.GetTheme;

  with Canvas do
  begin
    // check for highlight.
    ClipW := Ord(dsHighlight in DrawState);

    // draw border.
    if (Theme = WindowsXP) or ((Theme = OfficeXP) and (ClipW = 0)) then
      Pen.Color := dxColor_Chk_Enb_Border_WXP
    else
      Pen.Color := dxColor_BorderLineOXP;
    {$IFDEF VCL}
    if BiDiMode = bdRightToLeft then
      Rectangle(Bounds(R.Right - 2 - FCheckSize , (ClientHeight - FCheckSize) div 2,FCheckSize, FCheckSize))
    else
    {$ENDIF VCL}
      Rectangle(Bounds(R.Left + 2, (ClientHeight - FCheckSize) div 2,FCheckSize, FCheckSize));

    // draw background.
    case Theme of
      WindowsXP:
        begin
          if not ((ClipW <> 0) and (dsClicked in DrawState)) then
          begin
            if ClipW <> 0 then
              DrawGradient(FHlGradient);
            {$IFDEF VCL}
            if BiDiMode = bdRightToLeft then
              BitBlt(Handle, R.Right - 1 - FCheckSize + ClipW, (ClientHeight - FCheckSize) div 2 + 1 +
                ClipW, FCheckSize - 2 - ClipW * 2, FCheckSize - 2 - ClipW * 2,
                FBgGradient.Canvas.Handle, 0, 0, SRCCOPY)
            else
              BitBlt(Handle, R.Left + 3 + ClipW, (ClientHeight - FCheckSize) div 2 + 1 +
                ClipW, FCheckSize - 2 - ClipW * 2, FCheckSize - 2 - ClipW * 2,
                FBgGradient.Canvas.Handle, 0, 0, SRCCOPY);
            {$ENDIF VCL}
            {$IFDEF VisualCLX}
              BitBlt(Canvas, R.Left + 3 + ClipW, (ClientHeight - FCheckSize) div 2 + 1 +
                ClipW, FCheckSize - 2 - ClipW * 2, FCheckSize - 2 - ClipW * 2,
                FBgGradient.Canvas, 0, 0, SRCCOPY);
            {$ENDIF VisualCLX}
          end
          else
            DrawGradient(FCkGradient);
        end;
      OfficeXP:
        begin
          if ClipW <> 0 then
          begin
            if not (dsClicked in DrawState) then
              Brush.Color := dxColor_BgOXP
            else
              Brush.Color := dxColor_BgCkOXP;
            {$IFDEF VCL}
            if BiDiMode = bdRightToLeft then
              FillRect(Bounds(R.Right - 1, (ClientHeight - FCheckSize) div 2 + 1,
                FCheckSize - 2, FCheckSize - 2))
            else
            {$ENDIF VCL}
              FillRect(Bounds(R.Left + 3, (ClientHeight - FCheckSize) div 2 + 1,
                FCheckSize - 2, FCheckSize - 2))
          end;
        end;
    end;

    // draw checked.
    if Checked then
    begin
      Brush.Color := clSilver;
      Pen.Color := dxColor_Btn_Enb_Border_WXP;
      Bitmap := TBitmap.Create;
      try
        Bitmap.Transparent := True;
        Bitmap.LoadFromResourceName(HInstance, 'JvXPCheckboxCHECKBOX');
        if Theme = WindowsXP then
          JvXPColorizeBitmap(Bitmap, dxColor_Chk_Enb_NmSymb_WXP)
        else
        if (dsClicked in DrawState) and (dsHighlight in DrawState) then
          JvXPColorizeBitmap(Bitmap, clWhite);
        {$IFDEF VCL}
        if BiDiMode = bdRightToLeft then
          Draw(R.Right - FCheckSize + 1, (ClientHeight - FCheckSize) div 2 + 3, Bitmap)
        else
        {$ENDIF VCL}
          Draw(FCheckSize div 2 - 1, (ClientHeight - FCheckSize) div 2 + 3, Bitmap);
      finally
        Bitmap.Free;
      end;
    end;
  end;
end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

end.


