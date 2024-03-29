{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http:{www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvMessageControl.pas, released on 2004-10-10

The Initial Developer of the Original Code is Andr� Snepvangers [ASnepvangers att users.sourceforge.net]
Portions created by Andr� Snepvangers are Copyright (C) 2004 Andr� Snepvangers.
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http:{jvcl.sourceforge.net

Known Issues:
  It is still possible to move the component in IDE outside the parent.
  It could also be called as a feature. Object Treeview shows the
  correct parent.
-----------------------------------------------------------------------------}
// $Id: JvMessageControl.pas,v 1.4 2005/02/17 10:20:43 marquardt Exp $

unit JvMessageControl;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  SysUtils, Classes, Windows, Messages, Controls, Forms,
  JvControlComponent;

type
  {$IFDEF UNIX}
  { from Classes }
  TWndMethod = procedure(var Message: TMessage) of object;
  {$ENDIF UNIX}

  TJvMessageControl = class(TJvCustomControlComponent)
  private
    FSavedWinProc: TWndMethod;
    FOnMessage: TWndMethod;
  protected
    procedure SetParent(const Value: TWinControl); override;
    procedure ControlWinProc(var Message: TMessage);
  public
    destructor Destroy; override;
  published
    property Active;
    property OnMessage: TWndMethod read FOnMessage write FOnMessage;
    property Parent;
  end;

{$IFNDEF USEJVCL}
procedure Register;
{$ENDIF !USEJVCL}

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvMessageControl.pas,v $';
    Revision: '$Revision: 1.4 $';
    Date: '$Date: 2005/02/17 10:20:43 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

{$IFNDEF USEJVCL}
procedure Register;
begin
  RegisterComponents('Jv Non-Visual', [TJvMessageControl]);
end;
{$ENDIF !USEJVCL}

procedure TJvMessageControl.ControlWinProc(var Message: TMessage);
begin
  if Active and Assigned(FOnMessage) then { user message/event handler installed ? }
    FOnMessage(Message);
  if Message.Result = 0 then
    FSavedWinProc(Message); { do the original stuff }
end;

procedure TJvMessageControl.SetParent(const Value: TWinControl);
var
  WasActive: Boolean;
begin
  if Value <> Parent then
  begin
    WasActive := Active;
    Active := False;
    if Assigned(Parent) then
      Parent.WindowProc := FSavedWinProc;
    inherited  SetParent(Value);
    if Assigned(Parent) then
    begin
      FSavedWinProc := Parent.WindowProc;
      Parent.WindowProc := ControlWinProc; { intercept messages }
    end;
    Active := WasActive;
  end;
end;

destructor TJvMessageControl.Destroy;
begin
  if Assigned(Parent) and not (csDestroying in Parent.ComponentState) then
    Parent.WindowProc := FSavedWinProc;
  inherited Destroy;
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
