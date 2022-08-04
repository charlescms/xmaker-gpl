{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http:{www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvQExControls.pas, released on 2004-09-21

The Initial Developer of the Original Code is Andr� Snepvangers [ASnepvangers att xs4all dot nl]
Portions created by Andr� Snepvangers are Copyright (C) 2004 Andr� Snepvangers.
All Rights Reserved.

Contributor(s): Marcel Besteboer

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http:{jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvQExControls.pas,v 1.12 2004/11/14 23:28:07 asnepvangers Exp $

unit JvQExControls;

{$I jvcl.inc}
{MACROINCLUDE JvQExControls.macros}

WARNINGHEADER

interface

uses
  Classes, SysUtils,
  QGraphics, QControls, QForms, QStdCtrls, QExtCtrls, QComCtrls,
  QMask, QClipbrd, TypInfo,
  Qt, QWindows, QMessages,
  JvQTypes, JvQThemes, JVCLXVer;

const
  CM_DENYSUBCLASSING = JvQThemes.CM_DENYSUBCLASSING;
//
//  VCL control message IDs
//
  CM_VCLBASE                = CM_BASE + 10;
  CM_ACTIVATE               = CM_VCLBASE + 0; // not connected
  CM_DEACTIVATE             = CM_VCLBASE + 1; // not connected
//  CM_GOTFOCUS               = CM_VCLBASE + 2;
//  CM_LOSTFOCUS              = CM_VCLBASE + 3;
//  CM_CANCELMODE             = CM_VCLBASE + 4;
  CM_DIALOGKEY              = CM_VCLBASE + 5;
  CM_DIALOGCHAR             = CM_VCLBASE + 6;
  CM_FOCUSCHANGED           = CM_VCLBASE + 7;
//  CM_PARENTFONTCHANGED      = CM_VCLBASE + 8; native VisualCLX message
//  CM_PARENTCOLORCHANGED     = CM_VCLBASE + 9; native VisualCLX message
  CM_HITTEST               = CM_VCLBASE + 10;
  CM_VISIBLECHANGED        = CM_VCLBASE + 11;
  CM_ENABLEDCHANGED        = CM_VCLBASE + 12;
  CM_COLORCHANGED          = CM_VCLBASE + 13;
  CM_FONTCHANGED           = CM_VCLBASE + 14;
  CM_CURSORCHANGED         = CM_VCLBASE + 15;
  CM_TEXTCHANGED           = CM_VCLBASE + 18;
  CM_MOUSEENTER            = CM_VCLBASE + 19;
  CM_MOUSELEAVE            = CM_VCLBASE + 20;
//  CM_MENUCHANGED           = CM_VCLBASE + 21;
//  CM_APPKEYDOWN            = CM_VCLBASE + 22;
//  CM_APPSYSCOMMAND         = CM_VCLBASE + 23;
//  CM_BUTTONPRESSED         = CM_VCLBASE + 24;  native VisualCLX message
  CM_SHOWINGCHANGED        = CM_VCLBASE + 25;
  CM_ENTER                 = CM_VCLBASE + 26;
  CM_EXIT                  = CM_VCLBASE + 27;
  CM_DESIGNHITTEST         = CM_VCLBASE + 28;
//  CM_ICONCHANGED           = CM_VCLBASE + 29;
//  CM_WANTSPECIALKEY        = CM_VCLBASE + 30;
//  CM_INVOKEHELP            = CM_VCLBASE + 31;
//  CM_WINDOWHOOK            = CM_VCLBASE + 32;
//  CM_RELEASE               = CM_VCLBASE + 33;
  CM_SHOWHINTCHANGED       = CM_VCLBASE + 34;
//  CM_PARENTSHOWHINTCHANGED = CM_VCLBASE + 35;  native VisualCLX message
  CM_SYSCOLORCHANGE        = CM_VCLBASE + 36;  // -> application palette changed
//  CM_FONTCHANGE            = CM_VCLBASE + 38;
//  CM_TIMECHANGE            = CM_VCLBASE + 39;
//  CM_TABSTOPCHANGED        = CM_VCLBASE + 40;
//  CM_UIACTIVATE            = CM_VCLBASE + 41;
//  CM_UIDEACTIVATE          = CM_VCLBASE + 42;
//  CM_DOCWINDOWACTIVATE     = CM_VCLBASE + 43;
//  CM_CONTROLLISTCHANGE     = CM_VCLBASE + 44;
  CM_GETDATALINK           = CM_VCLBASE + 45;
//  CM_CHILDKEY              = CM_VCLBASE + 46;
//  CM_DRAG                  = CM_VCLBASE + 47;
  CM_HINTSHOW              = CM_VCLBASE + 48;
//  CM_DIALOGHANDLE          = CM_VCLBASE + 49;
//  CM_ISTOOLCONTROL         = CM_VCLBASE + 50;
  CM_RECREATEWND           = CM_RECREATEWINDOW; // native clx message
//  CM_INVALIDATE            = CM_VCLBASE + 52;
  CM_SYSFONTCHANGED        = CM_VCLBASE + 53;   // application font changed
//  CM_CONTROLCHANGE         = CM_VCLBASE + 54;
//  CM_CHANGED               = CM_VCLBASE + 55;
//  CM_DOCKCLIENT            = CM_VCLBASE + 56;
//  CM_UNDOCKCLIENT          = CM_VCLBASE + 57;
//  CM_FLOAT                 = CM_VCLBASE + 58;
  CM_BORDERCHANGED         = CM_VCLBASE + 59;
//  CM_ACTIONUPDATE          = CM_VCLBASE + 63;
//  CM_ACTIONEXECUTE         = CM_VCLBASE + 64;
//  CM_HINTSHOWPAUSE         = CM_VCLBASE + 65;
  CM_MOUSEWHEEL            = CM_VCLBASE + 67;
//  CM_ISSHORTCUT            = CM_VCLBASE + 68;
{$IFDEF LINUX}
//  CM_RAWX11EVENT           = CM_VCLBASE + 69;
{$ENDIF}

  { CM_HITTEST }
  HTNOWHERE = 0;
  HTCLIENT = 1;

type
  { Add IJvDenySubClassing to the base class list if the control should not
    be themed by the ThemeManager (www.delphi-gems.de).
    This only works with JvExCLX derived classes. }
  IJvDenySubClassing = interface
    ['{76942BC0-2A6E-4DC4-BFC9-8E110DB7F601}']
  end;

  TDragKind = (dkDrag, dkDock);   { not implemented yet}

  {$EXTERNALSYM HWND}
  HWND = QWindows.HWND;
  {$EXTERNALSYM HDC}
  HDC = QWindows.HDC;
  {$EXTERNALSYM TJvMessage}
  TJvMessage = JvQTypes.TJvMessage;

  TAlignInfo = record
    AlignList: TList;
    ControlIndex: Integer;
    Align: TAlign;
    Scratch: Integer;
  end;

  TCMActivate      = TWMNoParams;

  TCMChanged = packed record
    Msg: Integer;
    Reserved: Integer;
    Child: TControl;
    Result: Integer;
  end;

  TCMColorChanged   = TWMNoParams;
  TCMControlChange  = TCMChanged;

  TCMControlListChange = packed record
    Msg: Integer;
    Control: TControl;
    Inserting: LongBool;
    Result: Integer;
  end;

  TCMDeactivate     = TWMNoParams;
  TCMDesignHitTest = TWMMouse;
  TCMDialogChar     = TWMChar;
  TCMDialogKey      = TWMChar;
  TCMEnabledChanged = TWMNoParams;
  TCMEnter          = TWMNoParams;
  TCMExit           = TWMNoParams;

  TCMFocusChanged = packed record
    Msg: Integer;
    Reserved: Integer;
    Sender: TWidgetControl;
    Result: Integer;
  end;

  TCMFontChanged    = TWMNoParams;
  TCMGotFocus       = TWMNoParams;

  TCMHintShow = packed record
    Msg: Cardinal;
    Reserved: Integer;
    HintInfo: PHintInfo;
    Result: Integer;
  end;

  TCMHintShowPause = packed record
    Msg: Cardinal;
    WasActive: Integer;
    Pause: PInteger;
    Result: Integer;
    pt: TPoint
  end;

  TCMHitTest        = TWMMouse;
  TCMLostFocus      = TWMNoParams;
  TCMMouseEnter     = TWMNoParams;
  TCMMouseLeave     = TWMNoParams;
  TCMTextChanged    = TWMNoParams;

type
  JV_CONTROL(Control)
  JV_WINCONTROL(WinControl)

  JV_CONTROL_BEGIN(GraphicControl)
  private
    FText: TCaption; { TControl does not save the Caption property }
  protected
    procedure PaintRequest; override;
    function GetText: TCaption; override;
    procedure SetText(const Value: TCaption); override;
  public
    function ColorToRGB(Value: TColor): TColor;
  JV_CONTROL_END(GraphicControl)

  JV_CUSTOMCONTROL(CustomControl)
  JV_WINCONTROL(FrameControl)
  JV_CUSTOMCONTROL(HintWindow)


function DoClipBoardCommands(Msg: Integer; ClipBoardCommands: TJvClipBoardCommands): Boolean;
function GetFocusedControl(Instance: TControl): TWidgetControl;
function GetFocusedWnd(Instance: TControl): QWidgetH;
function GetHintColor(Instance: TControl): TColor;
function InputKeysToDlgCodes(InputKeys: TInputKeys): Integer;
function SendAppMessage(Msg: Cardinal; WParam, LParam: Integer): Integer;
procedure WidgetControl_PaintTo(Instance: TWidgetControl; PaintDevice: QPaintDeviceH; X, Y: Integer);

var
  NewStyleControls: Boolean;

implementation

function SendAppMessage(Msg: Cardinal; WParam, LParam: Integer): Integer;
begin
  Result := SendMessage(Application.AppWidget, Msg, WParam, LParam);
end;

function GetHintColor(Instance: TControl): TColor;
var
  PI: PPropInfo;
begin
  Result := clDefault;
  while (Result = clDefault) and Assigned(Instance) do
  begin
    PI := GetPropInfo(Instance, 'HintColor');
    if PI <> nil then
      Result := TColor(GetOrdProp(Instance, PI));
    Instance := Instance.Parent;
  end;
  case Result of
  clNone, clDefault: Result := Application.HintColor;
  end;
end;

function DoClipBoardCommands(Msg: Integer; ClipBoardCommands: TJvClipBoardCommands): Boolean;
begin
  case Msg of
    WM_COPY          : Result := caCopy in ClipBoardCommands;
    WM_CUT           : Result := caCut in ClipBoardCommands;
    WM_PASTE         : Result := caPaste in ClipBoardCommands;
    WM_UNDO          : Result := caUndo in ClipBoardCommands;
  else
    Result := False;
  end;
end;

function GetFocusedControl(Instance: TControl): TWidgetControl;
var
  Form: TCustomForm;
begin
  Result := nil;
  Form := GetParentForm(Instance);
  if Assigned(Form) then
    Result := Form.FocusedControl;
end;

function GetFocusedWnd(Instance: TControl): QWidgetH;
var
  Control: TWidgetControl;
begin
  Result := nil;
  Control := GetFocusedControl(Instance);
  if Assigned(Control) then
    Result := Control.Handle ;
end;

function InputKeysToDlgCodes(InputKeys: TInputKeys): Integer;
begin
  Result := 0;
  if ikAll in InputKeys then
    inc(Result, DLGC_WANTALLKEYS);
  if ikArrows in InputKeys then
    inc(Result, DLGC_WANTARROWS);
  if ikChars in InputKeys then
    inc(Result, DLGC_WANTCHARS);
  if ikEdit in InputKeys then
    inc(Result, DLGC_HASSETSEL);
  if ikTabs in InputKeys then
    inc(Result, DLGC_WANTTAB);
  if ikButton in InputKeys then
    inc(Result, DLGC_BUTTON);
end;

procedure WidgetControl_PaintTo(Instance: TWidgetControl; PaintDevice: QPaintDeviceH; X, Y: Integer);
var
  PixMap: QPixmapH;
begin
  PixMap := QPixmap_create;
  with Instance do
    try
      ControlState := ControlState + [csPaintCopy];
      QPixmap_grabWidget(PixMap, Handle, 0, 0, Width, Height);
      Qt.BitBlt(PaintDevice, X, Y, PixMap, 0, 0, Width, Height, RasterOp_CopyROP, True);
    finally
      ControlState := ControlState - [csPaintCopy];
      QPixMap_destroy(PixMap);
    end;
end;

JV_CONTROL_IMPL(Control)

{$UNDEF CONSTRUCTOR_CODE}
{$DEFINE CONSTRUCTOR_CODE QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);}
JV_WINCONTROL_IMPL(WinControl)
JV_CUSTOMCONTROL_IMPL(CustomControl)
{$UNDEF CONSTRUCTOR_CODE}
{$DEFINE CONSTRUCTOR_CODE}

JV_WINCONTROL_IMPL(FrameControl)
JV_CUSTOMCONTROL_IMPL(HintWindow)
JV_CONTROL_IMPL(GraphicControl)

function TJvExGraphicControl.GetText: TCaption;
begin
  Result := FText;
end;

procedure TJvExGraphicControl.SetText(const Value: TCaption);
begin
  if Value <> FText then
  begin
    FText := Value;
    TextChanged;
  end;
end;

procedure TJvExGraphicControl.PaintRequest;
begin
  if not Assigned(Parent) then
    Exit;
  Canvas.Start;
  try
    Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsSolid;
    Canvas.Font.Assign(Font);
    RequiredState(Canvas, [csHandleValid, csFontValid, csBrushValid]);
    inherited PaintRequest;
  finally
    Canvas.Stop;
  end;
end;

function TJvExGraphicControl.ColorToRGB(Value: TColor): TColor;
begin
  Result := QWindows.ColorToRGB(Value, Parent);
end;

Initialization
  OutputDebugString('JvExCLX Loaded: JvQExControls.pas');

Finalization
  OutputDebugString('JvExCLX Unloaded: JvQExControls.pas');

end.

