{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvMaskEdit.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse att buypin dott com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com],
                Rob den Braasem [rbraasem att xs4all dott nl],
                Oliver Giesen [ogware att gmx dott net],
                Peter Thornqvist [peter3 at sourceforge dot net].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvMaskEdit.pas,v 1.45 2005/03/06 23:04:09 remkobonte Exp $

unit JvMaskEdit;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages,
  SysUtils, Classes, Graphics, Controls, Mask, Forms,
  JvComponent, JvTypes, JvCaret, JvToolEdit, JvExMask;

type
  TJvCustomMaskEdit = class(TJvCustomComboEdit)
  private
    FHotTrack: Boolean;
    FCaret: TJvCaret;
    FEntering: Boolean;
    FLeaving: Boolean;
    FProtectPassword: Boolean;
    FLastNotifiedText: string;
    FHasLastNotifiedText: Boolean;
    FOnSetFocus: TJvFocusChangeEvent;
    FOnKillFocus: TJvFocusChangeEvent;
    procedure SetHotTrack(Value: Boolean);
    {$IFDEF VCL}
    procedure SetPasswordChar(const Value: Char);
    function GetPasswordChar: Char;
    function GetText: TCaption;
    procedure SetText(const Value: TCaption);
    {$ENDIF VCL}
  protected
    procedure CaretChanged(Sender: TObject); dynamic;
    procedure FocusKilled(NextWnd: HWND); override;
    procedure FocusSet(PrevWnd: HWND); override;
    procedure DoKillFocus(const ANextControl: TWinControl); virtual;
    procedure DoSetFocus(const APreviousControl: TWinControl); virtual;
    {$IFDEF VisualCLX}
    function GetText: TCaption; override;
    procedure SetText(const Value: TCaption); override;
    {$ENDIF VisualCLX}
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
    procedure SetCaret(const Value: TJvCaret);
    procedure NotifyIfChanged;
    procedure Change; override;
  public
    {$IFDEF VCL}
    procedure DefaultHandler(var Msg); override;
    {$ENDIF VCL}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Entering: Boolean read FEntering;
    property Leaving: Boolean read FLeaving;
  protected
    property Text: TCaption read GetText write SetText;
    {$IFDEF VCL}
    property PasswordChar: Char read GetPasswordChar write SetPasswordChar default #0;
    {$ENDIF VCL}
    // set to True to disable read/write of PasswordChar and read of Text
    property ProtectPassword: Boolean read FProtectPassword write FProtectPassword default False;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property Caret: TJvCaret read FCaret write SetCaret;
    property ShowButton default False;

    property OnSetFocus: TJvFocusChangeEvent read FOnSetFocus write FOnSetFocus;
    property OnKillFocus: TJvFocusChangeEvent read FOnKillFocus write FOnKillFocus;
  end;

  TJvMaskEdit = class(TJvCustomMaskEdit)
  published
    property Caret;
    property ClipboardCommands;
    property DisabledTextColor;
    property DisabledColor;
    property HintColor;
    property HotTrack;
    property ProtectPassword;
    property OnEnabledChanged;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;

    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property EditMask;
    property Font;
    {$IFDEF VCL}
    property Flat;
    property GroupIndex;
    property ImeMode;
    property ImeName;
    property ParentCtl3D;
    {$ENDIF VCL}
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    {$IFDEF VCL}
    property PasswordChar;
    {$ENDIF VCL}
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowButton;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VCL}
    property OnSetFocus;
    property OnKillFocus;
    {$ENDIF VCL}
    property OnStartDrag;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvMaskEdit.pas,v $';
    Revision: '$Revision: 1.45 $';
    Date: '$Date: 2005/03/06 23:04:09 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation


procedure TJvCustomMaskEdit.CaretChanged(Sender: TObject);
begin
  FCaret.CreateCaret;
end;

procedure TJvCustomMaskEdit.Change;
begin
  FLastNotifiedText := Text;
  FHasLastNotifiedText := True;
  inherited Change;
end;

constructor TJvCustomMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHotTrack := False;
  FCaret := TJvCaret.Create(Self);
  FCaret.OnChanged := CaretChanged;
  FEntering := False;
  FLeaving := False;

  ControlState := ControlState + [csCreating];
  try
    ShowButton := False; { force update }
  finally
    ControlState := ControlState - [csCreating];
  end;
end;

{$IFDEF VCL}
procedure TJvCustomMaskEdit.DefaultHandler(var Msg);
begin
  case TMessage(Msg).Msg of
    WM_CUT, WM_PASTE, EM_SETPASSWORDCHAR, WM_GETTEXT, WM_GETTEXTLENGTH:
      if not ProtectPassword then
        inherited DefaultHandler(Msg);
  else
    inherited DefaultHandler(Msg);
  end;
end;
{$ENDIF VCL}

destructor TJvCustomMaskEdit.Destroy;
begin
  FCaret.OnChanged := nil;
  FreeAndNil(FCaret);
  inherited Destroy;
end;

procedure TJvCustomMaskEdit.FocusKilled(NextWnd: HWND);
begin
  FLeaving := True;
  try
    FCaret.DestroyCaret;
    inherited FocusKilled(NextWnd);
    DoKillFocus(FindControl(NextWnd));
  finally
    FLeaving := False;
  end;
end;

procedure TJvCustomMaskEdit.DoKillFocus(const ANextControl: TWinControl);
begin
  NotifyIfChanged;
  if Assigned(FOnKillFocus) then
    FOnKillFocus(Self, ANextControl);
end;

procedure TJvCustomMaskEdit.FocusSet(PrevWnd: HWND);
begin
  FEntering := True;
  try
    inherited FocusSet(PrevWnd);
    FCaret.CreateCaret;
    DoSetFocus(FindControl(PrevWnd));
  finally
    FEntering := False;
  end;
end;

procedure TJvCustomMaskEdit.DoSetFocus(const APreviousControl: TWinControl);
begin
  if Assigned(FOnSetFocus) then
    FOnSetFocus(Self, APreviousControl);
end;

{$IFDEF VCL}
function TJvCustomMaskEdit.GetPasswordChar: Char;
begin
  Result := inherited PasswordChar;
end;
{$ENDIF VCL}

function TJvCustomMaskEdit.GetText: TCaption;
var
  Tmp: Boolean;
begin
  Tmp := ProtectPassword;
  try
    ProtectPassword := False;
    {$IFDEF VCL}
    Result := inherited Text;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    Result := inherited GetText;
    {$ENDIF VisualCLX}
  finally
    ProtectPassword := Tmp;
  end;
end;

procedure TJvCustomMaskEdit.MouseEnter(Control: TControl);
begin
  if csDesigning in ComponentState then
    Exit;
  if not MouseOver then
  begin
    if HotTrack then
      {$IFDEF VCL}
      Ctl3D := True;
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      BorderStyle := bsSingle;
      {$ENDIF VisualCLX}
    inherited MouseEnter(Control);
  end;
end;

procedure TJvCustomMaskEdit.MouseLeave(Control: TControl);
begin
  if MouseOver then
  begin
    if FHotTrack then
      {$IFDEF VCL}
      Ctl3D := False;
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      BorderStyle := bsSingle; // maybe bsNone
      {$ENDIF VisualCLX}
    inherited MouseLeave(Control);
  end;
end;

procedure TJvCustomMaskEdit.NotifyIfChanged;
begin
  if FHasLastNotifiedText and (FLastNotifiedText <> Text) then
    Change;
end;

procedure TJvCustomMaskEdit.SetCaret(const Value: TJvCaret);
begin
  FCaret.Assign(Value);
end;

procedure TJvCustomMaskEdit.SetHotTrack(Value: Boolean);
begin
  FHotTrack := Value;
  if Value then
  begin
    {$IFDEF VCL}
    Ctl3D := False;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    BorderStyle := bsSingle; // maybe bsNone
    {$ENDIF VisualCLX}
  end
  else
  begin
    {$IFDEF VCL}
    Ctl3D := True;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    BorderStyle := bsSingle;
    {$ENDIF VisualCLX}
  end;
end;

{$IFDEF VCL}
procedure TJvCustomMaskEdit.SetPasswordChar(const Value: Char);
var
  Tmp: Boolean;
begin
  Tmp := ProtectPassword;
  try
    ProtectPassword := False;
    inherited PasswordChar := Value;
  finally
    ProtectPassword := Tmp;
  end;
end;
{$ENDIF VCL}

procedure TJvCustomMaskEdit.SetText(const Value: TCaption);
begin
  {$IFDEF VCL}
  inherited Text := Value;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  inherited SetText(Value);
  {$ENDIF VisualCLX}
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
