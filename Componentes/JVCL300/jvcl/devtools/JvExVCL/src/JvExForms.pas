{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExForms.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas dott Hausladen att gmx dott de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvExForms.pas,v 1.22 2005/03/09 07:24:55 marquardt Exp $

unit JvExForms;

{$I jvcl.inc}
{MACROINCLUDE JvExControls.macros}

WARNINGHEADER

interface

uses
  Windows, Messages, Graphics, Controls, Forms, ToolWin,
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  Classes, SysUtils,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JvTypes, JvThemes, JVCLVer, JvExControls;

type
  WINCONTROL_DECL_DEFAULT(ScrollingWinControl)

  WINCONTROL_DECL_DEFAULT(ScrollBox)

  WINCONTROL_DECL_DEFAULT(CustomFrame)

  WINCONTROL_DECL_DEFAULT(Frame)

  WINCONTROL_DECL_DEFAULT(ToolWindow)

  TJvExCustomForm = class(TCustomForm, IJvExControl)
  WINCONTROL_DECL
  protected
    procedure CMShowingChanged(var Msg: TMessage); message CM_SHOWINGCHANGED;
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;

  TJvExForm = class(TForm, IJvExControl)
  WINCONTROL_DECL
  protected
    procedure CMShowingChanged(var Msg: TMessage); message CM_SHOWINGCHANGED;
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvExForms.pas,v $';
    Revision: '$Revision: 1.22 $';
    Date: '$Date: 2005/03/09 07:24:55 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

const
  UISF_HIDEFOCUS = 1;
  UISF_HIDEACCEL = 2;
  UIS_SET        = 1;
  UIS_CLEAR      = 2;
  UIS_INITIALIZE = 3;

WINCONTROL_IMPL_DEFAULT(ScrollingWinControl)

WINCONTROL_IMPL_DEFAULT(ScrollBox)

WINCONTROL_IMPL_DEFAULT(CustomFrame)

WINCONTROL_IMPL_DEFAULT(Frame)

WINCONTROL_IMPL_DEFAULT(ToolWindow)

WINCONTROL_IMPL_DEFAULT(CustomForm)

constructor TJvExCustomForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  FHintColor := clDefault;
end;

procedure TJvExCustomForm.CMShowingChanged(var Msg: TMessage);
begin
  if Showing then
    SendMessage(Handle, WM_CHANGEUISTATE, UIS_INITIALIZE, 0);
  inherited;
end;

procedure TJvExCustomForm.CMDialogKey(var Msg: TCMDialogKey);
begin
  case Msg.CharCode of
    VK_LEFT..VK_DOWN, VK_TAB:
      SendMessage(Handle, WM_CHANGEUISTATE, MakeLong(UIS_CLEAR, UISF_HIDEFOCUS), 0);
    VK_MENU:
      SendMessage(Handle, WM_CHANGEUISTATE, MakeLong(UIS_CLEAR, UISF_HIDEFOCUS or UISF_HIDEACCEL), 0);
  end;
  inherited;
end;

WINCONTROL_IMPL_DEFAULT(Form)

constructor TJvExForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  FHintColor := clDefault;
end;

procedure TJvExForm.CMShowingChanged(var Msg: TMessage);
begin
  if Showing then
    SendMessage(Handle, WM_CHANGEUISTATE, UIS_INITIALIZE, 0);
  inherited;
end;

procedure TJvExForm.CMDialogKey(var Msg: TCMDialogKey);
begin
  case Msg.CharCode of
    VK_LEFT..VK_DOWN, VK_TAB:
      SendMessage(Handle, WM_CHANGEUISTATE, MakeLong(UIS_CLEAR, UISF_HIDEFOCUS), 0);
    VK_MENU:
      SendMessage(Handle, WM_CHANGEUISTATE, MakeLong(UIS_CLEAR, UISF_HIDEFOCUS or UISF_HIDEACCEL), 0);
  end;
  inherited;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
