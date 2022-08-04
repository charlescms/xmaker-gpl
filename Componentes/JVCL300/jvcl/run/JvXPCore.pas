{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvXPCore.PAS, released on 2004-01-01.

The Initial Developer of the Original Code is Marc Hoffman.
Portions created by Marc Hoffman are Copyright (C) 2002 APRIORI business solutions AG.
Portions created by APRIORI business solutions AG are Copyright (C) 2002 APRIORI business solutions AG
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvXPCore.pas,v 1.31 2005/02/17 10:21:18 marquardt Exp $

unit JvXPCore;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  Windows, Controls, Graphics, Forms, Messages, // asn: messages after controls for clx
  {$IFDEF USEJVCL}
  JvComponent,
  {$ENDIF USEJVCL}
  Classes;

const
  { color constants.

    these constants are used as default colors for descendant controls
    and may be replaced with other (common) values.

    syntax: JvXPColor_[Control]_[Enabled: Enb, Dis]_[Type]_[Theme: WXP, OXP]     }

  { button colors - WindowsXP }
  dxColor_Btn_Enb_Border_WXP   = TColor($00733800); // border line
  dxColor_Btn_Dis_Border_WXP   = TColor($00BDC7CE); // border line (disabled)
  dxColor_Btn_Enb_Edges_WXP    = TColor($00AD9E7B); // border edges
  dxColor_Btn_Dis_Edges_WXP    = TColor($00BDC7CE); // border edges (disabled)
  dxColor_Btn_Enb_BgFrom_WXP   = TColor($00FFFFFF); // background from
  dxColor_Btn_Enb_BgTo_WXP     = TColor($00E7EBEF); // background to
  dxColor_Btn_Enb_CkFrom_WXP   = TColor($00C6CFD6); // clicked from
  dxColor_Btn_Enb_CkTo_WXP     = TColor($00EBF3F7); // clicked to
  dxColor_Btn_Enb_FcFrom_WXP   = TColor($00FFE7CE); // focused from
  dxColor_Btn_Enb_FcTo_WXP     = TColor($00EF846D); // focused to
  dxColor_Btn_Enb_HlFrom_WXP   = TColor($00CEF3FF); // highlight from
  dxColor_Btn_Enb_HlTo_WXP     = TColor($000096E7); // highlight to

  { checkbox colors - WindowsXP }
  dxColor_Chk_Enb_Border_WXP   = TColor($00845118); // border line
  dxColor_Chk_Enb_NmSymb_WXP   = TColor($0021A621); // symbol normal

  { misc colors - WindowsXP }
  dxColor_Msc_Dis_Caption_WXP  = TColor($0094A6A5); // caption color (disabled)

  dxColor_DotNetFrame          = TColor($00F7FBFF); // $00E7EBEF;
  dxColor_BorderLineOXP        = TColor($00663300);
  dxColor_BgOXP                = TColor($00D6BEB5);
  dxColor_BgCkOXP              = TColor($00CC9999);

type
  TJvXPCustomStyleControl = class;

  TJvXPBoundLines = set of
   (
    blLeft,                             // left line
    blTop,                              // top line
    blRight,                            // right line
    blBottom                            // bottom line
   );

  TJvXPControlStyle = set of
   (
    csRedrawCaptionChanged,             // (default)
    csRedrawBorderChanged,              //
    csRedrawEnabledChanged,             // (default)
    csRedrawFocusedChanged,             // (default)
    csRedrawMouseDown,                  // (default)
    csRedrawMouseEnter,                 // (default)
    csRedrawMouseLeave,                 // (default)
    csRedrawMouseMove,                  //
    csRedrawMouseUp,                    // (default)
    csRedrawParentColorChanged,         // (default)
    csRedrawParentFontChanged,          //
    csRedrawPosChanged,                 //
    csRedrawResized                     //
   );

  TJvXPDrawState = set of
   (
    dsDefault,                          // default
    dsHighlight,                        // highlighted
    dsClicked,                          // clicked
    dsFocused                           // focused
   );

  TJvXPGlyphLayout =
   (
    glBottom,                           // bottom glyph
    glCenter,                           // centered glyph
    glTop                               // top glyph
   );

  TJvXPTheme =
   (
    WindowsXP,                          // WindowsXP theme
    OfficeXP                            // OfficeXP theme
   );

  { baseclass for non-focusable component descendants. }
  {$IFDEF USEJVCL}
  TJvXPCustomComponent = class(TJvComponent)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  {$ELSE}
  TJvXPCustomComponent = class(TComponent)
  private
    FVersion: string;
    procedure SetVersion(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Version: string read FVersion write SetVersion stored False;
  end;
  {$ENDIF USEJVCL}

  {$IFDEF USEJVCL}
  TJvXPWinControl = class(TJvWinControl)
  {$ELSE}
  TJvXPWinControl = class(TWinControl)
  {$ENDIF USEJVCL}
  published
    property Color;
  end;
  { baseclass for focusable control descendants. }

  {$IFDEF USEJVCL}
  TJvXPCustomControl = class(TJvCustomControl)
  {$ELSE}
  TJvXPCustomControl = class(TCustomControl)
  {$ENDIF USEJVCL}
  private
    FClicking: Boolean;
    FDrawState: TJvXPDrawState;
    FIsLocked: Boolean;
    FIsSibling: Boolean;
    FModalResult: TModalResult;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    {$IFNDEF USEJVCL}
    FVersion: string;
    procedure SetVersion(const Value: string);
    {$ENDIF !USEJVCL}
    procedure CMFocusChanged(var Msg: TMessage); message CM_FOCUSCHANGED;
    {$IFDEF VCL}
    procedure CMDialogChar(var Msg: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMBorderChanged(var Msg: TMessage); message CM_BORDERCHANGED;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Msg: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Msg: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanged(var Msg: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    {$ENDIF VCL}
  protected
    ExControlStyle: TJvXPControlStyle;
    procedure InternalRedraw; dynamic;
    procedure HookBorderChanged; dynamic;
    procedure HookEnabledChanged; dynamic;
    procedure HookFocusedChanged; dynamic;
    procedure HookMouseDown; dynamic;
    procedure HookMouseEnter; dynamic;
    procedure HookMouseLeave; dynamic;
    procedure HookMouseMove(X: Integer = 0; Y: Integer = 0); dynamic;
    procedure HookMouseUp; dynamic;
    procedure HookParentColorChanged; dynamic;
    procedure HookParentFontChanged; dynamic;
    procedure HookPosChanged; dynamic;
    procedure HookResized; dynamic;
    procedure HookTextChanged; dynamic;
    procedure BeginUpdate; dynamic;
    procedure EndUpdate; dynamic;
    procedure LockedInvalidate; dynamic;
    {$IFDEF VisualCLX}
    procedure AdjustSize; override;
    procedure BorderChanged; dynamic;
    procedure EnabledChanged; override;
    procedure TextChanged; override;
    procedure ParentColorChanged; override;
    procedure ParentFontChanged; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    function WantKey(Key: Integer; Shift: TShiftState; const KeyText: WideString): Boolean; override;
    procedure Loaded; override;
    {$ENDIF VisualCLX}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Click; override;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
    property DrawState: TJvXPDrawState read FDrawState write FDrawState;
    property IsLocked: Boolean read FIsLocked write FIsLocked;
    property IsSibling: Boolean read FIsSibling write FIsSibling;
  published
    {$IFNDEF USEJVCL}
    property Version: string read FVersion write SetVersion stored False;
    {$ENDIF !USEJVCL}
  end;

  TJvXPUnlimitedControl = class(TJvXPCustomControl)
  published
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

  TJvXPStyle = class(TPersistent)
  private
    FTheme: TJvXPTheme;
    FUseStyleManager: Boolean;
  protected
    Parent: TJvXPCustomStyleControl;
    procedure SetTheme(Value: TJvXPTheme); virtual;
    procedure SetUseStyleManager(Value: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent);
    function GetTheme: TJvXPTheme;
  published
    property Theme: TJvXPTheme read FTheme write SetTheme default WindowsXP;
    property UseStyleManager: Boolean read FUseStyleManager write SetUseStyleManager default True;
  end;

  TJvXPStyleManager = class(TJvXPCustomComponent)
  private
    FControls: TList;
    FTheme: TJvXPTheme;
    FOnThemeChanged: TNotifyEvent;
    procedure InvalidateControls;
  protected
    procedure SetTheme(Value: TJvXPTheme); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterControls(const AControls: array of TJvXPCustomControl);
    procedure UnregisterControls(const AControls: array of TJvXPCustomControl);
  published
    property Theme: TJvXPTheme read FTheme write SetTheme default WindowsXP;
    property OnThemeChanged: TNotifyEvent read FOnThemeChanged write FOnThemeChanged;
  end;

  TJvXPCustomStyleControl = class(TJvXPCustomControl)
  private
    FStyle: TJvXPStyle;
    FStyleManager: TJvXPStyleManager;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure SetStyleManager(Value: TJvXPStyleManager); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property Style: TJvXPStyle read FStyle write FStyle;
    property StyleManager: TJvXPStyleManager read FStyleManager write SetStyleManager;
  end;

  TJvXPGradientColors = 2..255;

  TJvXPGradientStyle = (gsLeft, gsTop, gsRight, gsBottom);

  TJvXPGradient = class(TPersistent)
  private
    FColors: TJvXPGradientColors;
    FDithered: Boolean;
    FEnabled: Boolean;
    FEndColor: TColor;
    FStartColor: TColor;
    FGradientStyle: TJvXPGradientStyle;
  protected
    Parent: TJvXPCustomControl;
    procedure SetDithered(Value: Boolean); virtual;
    procedure SetColors(Value: TJvXPGradientColors); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetEndColor(Value: TColor); virtual;
    procedure SetGradientStyle(Value: TJvXPGradientStyle); virtual;
    procedure SetStartColor(Value: TColor); virtual;
  public
    Bitmap: TBitmap;
    constructor Create(AOwner: TControl);
    destructor Destroy; override;
    procedure RecreateBands; virtual;
  published
    property Dithered: Boolean read FDithered write SetDithered default True;
    property Colors: TJvXPGradientColors read FColors write SetColors default 16;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property EndColor: TColor read FEndColor write SetEndColor default clSilver;
    property StartColor: TColor read FStartColor write SetStartColor default clGray;
    property Style: TJvXPGradientStyle read FGradientStyle write SetGradientStyle default gsLeft;
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvXPCore.pas,v $';
    Revision: '$Revision: 1.31 $';
    Date: '$Date: 2005/02/17 10:21:18 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

uses
  {$IFDEF USEJVCL}
  JvResources,
  {$ENDIF USEJVCL}
  JvXPCoreUtils;

{$IFDEF MSWINDOWS}
{$R ..\Resources\JvXPCore.res}
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
{$R ../Resources/JvXPCore.res}
{$ENDIF UNIX}

{$IFNDEF USEJVCL}
resourcestring
  RsCopyright = 'Design eXperience. (c) 2002 M. Hoffmann Version ';
  RsCopyright2 = 'Design eXperience II - (c) 2002 M. Hoffmann Version ';
  RsVersion = '2.0.1'; // always increase version number on new releases!
{$ENDIF !USEJVCL}

//=== { TJvXPCustomComponent } ===============================================

constructor TJvXPCustomComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF USEJVCL}
  FVersion := RsCopyright + RsVersion;
  {$ENDIF !USEJVCL}
end;

{$IFNDEF USEJVCL}
procedure TJvXPCustomComponent.SetVersion(const Value: string);
begin
  // do not enable overwriting this constant.
end;
{$ENDIF !USEJVCL}

//=== { TJvXPCustomControl } =================================================

constructor TJvXPCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque, csReplicatable];
  DoubleBuffered := True;
  ExControlStyle := [csRedrawEnabledChanged, csRedrawFocusedChanged,
    csRedrawMouseDown, csRedrawMouseEnter, csRedrawMouseLeave, csRedrawMouseUp,
    csRedrawParentColorChanged, csRedrawCaptionChanged];
  FClicking := False;
  FDrawState := [dsDefault];
  FIsLocked := False;
  FIsSibling := False;
  FModalResult := 0;
  {$IFNDEF USEJVCL}
  FVersion := RsCopyright2 + RsVersion;
  {$ENDIF !USEJVCL}
end;

{$IFNDEF USEJVCL}
procedure TJvXPCustomControl.SetVersion(const Value: string);
begin
  // disallow changing this property.
end;
{$ENDIF !USEJVCL}

procedure TJvXPCustomControl.BeginUpdate;
begin
  FIsLocked := True;
end;

procedure TJvXPCustomControl.EndUpdate;
begin
  FIsLocked := False;
  InternalRedraw;
end;

procedure TJvXPCustomControl.LockedInvalidate;
begin
  if not IsLocked then
    Invalidate;
end;

procedure TJvXPCustomControl.InternalRedraw;
begin
  if not FIsLocked then
    Invalidate;
end;

{$IFDEF VCL}

procedure TJvXPCustomControl.CMDialogChar(var Msg: TCMDialogChar);
begin
  with Msg do
  if IsAccel(CharCode, Caption) and CanFocus and
    (Focused or ((GetKeyState(VK_MENU) and $8000) <> 0)) then
  begin
    Click;
    Result := 1;
  end
  else
    inherited;
end;

procedure TJvXPCustomControl.CMBorderChanged(var Msg: TMessage);
begin
  // delegate message "BorderChanged" to hook.
  inherited;
  HookBorderChanged;
end;

procedure TJvXPCustomControl.CMEnabledChanged(var Msg: TMessage);
begin
  // delegate message "EnabledChanged" to hook.
  inherited;
  HookEnabledChanged;
end;
{$ENDIF VCL}

procedure TJvXPCustomControl.CMFocusChanged(var Msg: TMessage);
begin
  // delegate message "FocusChanged" to hook.
  inherited;
  HookFocusedChanged;
end;

{$IFDEF VCL}
procedure TJvXPCustomControl.CMMouseEnter(var Msg: TMessage);
begin
  // delegate message "MouseEnter" to hook.
  inherited;
  HookMouseEnter;
end;

procedure TJvXPCustomControl.CMMouseLeave(var Msg: TMessage);
begin
  // delegate message "MouseLeave" to hook.
  inherited;
  HookMouseLeave;
end;

procedure TJvXPCustomControl.CMParentColorChanged(var Msg: TMessage);
begin
  // delegate message "ParentColorChanged" to hook.
  inherited;
  HookParentColorChanged;
end;

procedure TJvXPCustomControl.CMParentFontChanged(var Msg: TMessage);
begin
  // delegate message "ParentFontChanged" to hook.
  inherited;
  HookParentFontChanged;
end;

procedure TJvXPCustomControl.CMTextChanged(var Msg: TMessage);
begin
  // delegate message "TextChanged" to hook.
  inherited;
  HookTextChanged;
end;

procedure TJvXPCustomControl.WMMouseMove(var Msg: TWMMouse);
begin
  // delegate message "MouseMove" to hook.
  inherited;
  HookMouseMove(Msg.XPos, Msg.YPos);
end;

procedure TJvXPCustomControl.WMSize(var Msg: TWMSize);
begin
  // delegate message "Size" to hook.
  inherited;
  HookResized;
end;

procedure TJvXPCustomControl.WMWindowPosChanged(var Msg: TWMWindowPosChanged);
begin
  // delegate message "WindowPosChanged" to hook.
  inherited;
  HookPosChanged;
end;

{$ENDIF VCL}

{$IFDEF VisualCLX}

function TJvXPCustomControl.WantKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := IsAccel(Key, Caption) and Enabled and not (ssCtrl in Shift);
  if Result then
    Click
  else
    Result := inherited WantKey(Key, Shift, KeyText);
end;

procedure TJvXPCustomControl.Loaded;
begin
  inherited Loaded;
  AdjustSize;
end;

procedure TJvXPCustomControl.BorderChanged;
begin
  // delegate message "BorderChanged" to hook.
//  inherited BorderChanged;
  HookBorderChanged;
end;

procedure TJvXPCustomControl.EnabledChanged;
begin
  // delegate message "EnabledChanged" to hook.
  inherited EnabledChanged;
  HookEnabledChanged;
end;

procedure TJvXPCustomControl.MouseEnter(AControl: TControl);
begin
  // delegate message "MouseEnter" to hook.
  inherited MouseEnter(AControl);
  HookMouseEnter;
end;

procedure TJvXPCustomControl.MouseLeave(AControl: TControl);
begin
  // delegate message "MouseLeave" to hook.
  inherited MouseLeave(AControl);
  HookMouseLeave;
end;

procedure TJvXPCustomControl.ParentColorChanged;
begin
  // delegate message "ParentColorChanged" to hook.
  inherited ParentColorChanged;
  HookParentColorChanged;
end;

procedure TJvXPCustomControl.ParentFontChanged;
begin
  // delegate message "ParentFontChanged" to hook.
  inherited ParentFontChanged;
  HookParentFontChanged;
end;

procedure TJvXPCustomControl.TextChanged;
begin
  // delegate message "TextChanged" to hook.
  inherited TextChanged;
  HookTextChanged;
end;

procedure TJvXPCustomControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  // delegate message "MouseMove" to hook.
  inherited MouseMove(Shift, X, Y);
  HookMouseMove(X, Y);
end;

procedure TJvXPCustomControl.AdjustSize;
begin
  // delegate message "Size" to hook.
  inherited AdjustSize;
  HookResized;
end;

(*
procedure TJvXPCustomControl.WMWindowPosChanged(var Msg: TWMWindowPosChanged);
begin
  // delegate message "WindowPosChanged" to hook.
  inherited;
  HookPosChanged;
end;
*)

{$ENDIF VisualCLX}

procedure TJvXPCustomControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // delegate message "MouseDown" to hook.
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    FClicking := True;
    HookMouseDown;
  end;
end;

procedure TJvXPCustomControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // delegate message "MouseUp" to hook.
  inherited MouseUp(Button, Shift, X, Y);
  if FClicking then
  begin
    FClicking := False;
    HookMouseUp;
  end;
end;

procedure TJvXPCustomControl.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if Form <> nil then
    Form.ModalResult := ModalResult;
  inherited Click;
end;

//
// hooks are used to interrupt default windows messages in an easier
// way - it's possible to override them in descendant classes.
// Beware of multiple redraw calls - if you know that the calling
// hooks always redraws the component, use the lock i.e. unlock methods
// (rom) or LockedInvalidate.

procedure TJvXPCustomControl.HookBorderChanged;
begin
  // this hook is called, if the border property was changed.
  // in that case we normaly have to redraw the control.
  if csRedrawBorderChanged in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookEnabledChanged;
begin
  // this hook is called, if the enabled property was switched.
  // in that case we normaly have to redraw the control.
  if csRedrawEnabledChanged in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookFocusedChanged;
begin
  // this hook is called, if the currently focused control was changed.
  if Focused then
    Include(FDrawState, dsFocused)
  else
  begin
    Exclude(FDrawState, dsFocused);
    Exclude(FDrawState, dsClicked);
  end;
  FIsSibling := GetParentForm(Self).ActiveControl is TJvXPCustomControl;
  if csRedrawFocusedChanged in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookMouseEnter;
begin
  // this hook is called, if the user moves (hover) the mouse over the control.
  if not (csDesigning in ComponentState) then
  begin
    Include(FDrawState, dsHighlight);
    if csRedrawMouseEnter in ExControlStyle then
      InternalRedraw;
  end;
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TJvXPCustomControl.HookMouseLeave;
begin
  // this hook is called, if the user moves the mouse away (unhover) from
  // the control.
  if not (csDesigning in ComponentState) then
  begin
    Exclude(FDrawState, dsHighlight);
    if csRedrawMouseLeave in ExControlStyle then
      InternalRedraw;
  end;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TJvXPCustomControl.HookMouseMove(X: Integer = 0; Y: Integer = 0);
begin
  // this hook is called if the user moves the mouse inside the control.
  if not (csDesigning in ComponentState) then
    if csRedrawMouseMove in ExControlStyle then
      InternalRedraw;
end;

procedure TJvXPCustomControl.HookMouseDown;
begin
  // this hook is called, if the user presses the left mouse button over the
  // controls.
  if not Focused and CanFocus then
    SetFocus;
  Include(FDrawState, dsClicked);
  if csRedrawMouseDown in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookMouseUp;
var
  CurrentPos: TPoint;
  NewControl: TWinControl;
begin
  // this hook is called, if the user releases the left mouse button.
  begin
    Exclude(FDrawState, dsClicked);
    if csRedrawMouseUp in ExControlStyle then
      InternalRedraw;

    // does the cursor is over another supported control?
    GetCursorPos(CurrentPos);
    NewControl := FindVCLWindow(CurrentPos);
    if (NewControl <> nil) and (NewControl <> Self) and
      (NewControl.InheritsFrom(TJvXPCustomControl)) then
      TJvXPCustomControl(NewControl).HookMouseEnter;
  end;
end;

procedure TJvXPCustomControl.HookParentColorChanged;
begin
  // this hook is called if, the parent color was changed.
  if csRedrawParentColorChanged in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookParentFontChanged;
begin
  // this hook is called if, the parent font was changed.
  if csRedrawParentFontChanged in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookPosChanged;
begin
  // this hook is called, if the window position was changed.
  if csRedrawPosChanged in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookResized;
begin
  // this hook is called, if the control was resized.
  if csRedrawResized in ExControlStyle then
    InternalRedraw;
end;

procedure TJvXPCustomControl.HookTextChanged;
begin
  // this hook is called, if the caption was changed.
  if csRedrawCaptionChanged in ExControlStyle then
    InternalRedraw;
end;

//=== { TJvXPStyle } =========================================================

constructor TJvXPStyle.Create(AOwner: TComponent);
begin
  inherited Create;
  Parent := TJvXPCustomStyleControl(AOwner);
  FTheme := WindowsXP;
  FUseStyleManager := True;
end;

procedure TJvXPStyle.SetTheme(Value: TJvXPTheme);
begin
  if Value <> FTheme then
  begin
    FTheme := Value;
    Parent.InternalRedraw;
  end;
end;

function TJvXPStyle.GetTheme: TJvXPTheme;
begin
  Result := FTheme;
  if FUseStyleManager and Assigned(Parent.StyleManager) then
    Result := Parent.StyleManager.Theme;
end;

procedure TJvXPStyle.SetUseStyleManager(Value: Boolean);
begin
  if Value <> FUseStyleManager then
  begin
    FUseStyleManager := Value;
    Parent.InternalRedraw;
  end;
end;

//=== { TJvXPStyleManager } ==================================================

constructor TJvXPStyleManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FControls := TList.Create;
  FTheme := WindowsXP;
end;

destructor TJvXPStyleManager.Destroy;
begin
  InvalidateControls;
  FControls.Free;
  inherited Destroy;
end;

procedure TJvXPStyleManager.InvalidateControls;
var
  I: Integer;
begin
  for I := 0 to FControls.Count - 1 do
  with TJvXPCustomControl(FControls[I]) do
    InternalRedraw;
end;

procedure TJvXPStyleManager.SetTheme(Value: TJvXPTheme);
begin
  if Value <> FTheme then
  begin
    FTheme := Value;
    if Assigned(FOnThemeChanged) then
      FOnThemeChanged(Self);
    InvalidateControls;
  end;
end;

procedure TJvXPStyleManager.RegisterControls(const AControls: array of TJvXPCustomControl);
var
  I: Integer;
begin
  for I := Low(AControls) to High(AControls) do
  if FControls.IndexOf(AControls[I]) = -1 then
    FControls.Add(AControls[I]);
end;

procedure TJvXPStyleManager.UnregisterControls(const AControls: array of TJvXPCustomControl);
var
  I: Integer;
begin
  for I := Low(AControls) to High(AControls) do
  if FControls.IndexOf(AControls[I]) <> -1 then
    FControls.Delete(FControls.IndexOf(AControls[I]));
end;

//=== { TJvXPCustomStyleControl } ============================================

constructor TJvXPCustomStyleControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStyle := TJvXPStyle.Create(Self);
  FStyleManager := nil;
end;

destructor TJvXPCustomStyleControl.Destroy;
begin
  if FStyleManager <> nil then
    FStyleManager.UnregisterControls([Self]);
  FStyle.Free;
  inherited Destroy;
end;

procedure TJvXPCustomStyleControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent is TJvXPStyleManager) and (Operation = opRemove) then
    FStyleManager := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TJvXPCustomStyleControl.SetStyleManager(Value: TJvXPStyleManager);
begin
  if Value <> FStyleManager then
  begin
    if Value <> nil then
      Value.RegisterControls([Self])
    else
      FStyleManager.UnregisterControls([Self]);
    FStyleManager := Value;
    InternalRedraw;
  end;
end;

//=== { TJvXPGradient } ======================================================

constructor TJvXPGradient.Create(AOwner: TControl);
begin
  inherited Create;
  Parent := TJvXPCustomControl(AOwner);
  Bitmap := TBitmap.Create;
  FColors := 16;
  FDithered := True;
  FEnabled := False;
  FEndColor := clSilver;
  FGradientStyle := gsLeft;
  FStartColor := clGray;
end;

destructor TJvXPGradient.Destroy;
begin
  Bitmap.Free;
  inherited Destroy;
end;

procedure TJvXPGradient.RecreateBands;
begin
  if Assigned(Bitmap) then
    JvXPCreateGradientRect(Parent.Width, Parent.Height, FStartColor, FEndColor,
      FColors, FGradientStyle, FDithered, Bitmap);
end;

procedure TJvXPGradient.SetDithered(Value: Boolean);
begin
  if FDithered <> Value then
  begin
    FDithered := Value;
    RecreateBands;
    Parent.InternalRedraw;
  end;
end;

procedure TJvXPGradient.SetColors(Value: TJvXPGradientColors);
begin
  if FColors <> Value then
  begin
    FColors := Value;
    RecreateBands;
    Parent.InternalRedraw;
  end;
end;

procedure TJvXPGradient.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Parent.InternalRedraw;
  end;
end;

procedure TJvXPGradient.SetEndColor(Value: TColor);
begin
  if FEndColor <> Value then
  begin
    FEndColor := Value;
    RecreateBands;
    Parent.InternalRedraw;
  end;
end;

procedure TJvXPGradient.SetGradientStyle(Value: TJvXPGradientStyle);
begin
  if FGradientStyle <> Value then
  begin
    FGradientStyle := Value;
    RecreateBands;
    Parent.InternalRedraw;
  end;
end;

procedure TJvXPGradient.SetStartColor(Value: TColor);
begin
  if FStartColor <> Value then
  begin
    FStartColor := Value;
    RecreateBands;
    Parent.InternalRedraw;
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

