{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvScrollBar.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse att buypin dott com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvScrollBar.pas,v 1.15 2005/02/17 10:20:52 marquardt Exp $

unit JvScrollBar;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  JvExStdCtrls;

type
  TJvScrollBar = class(TJvExScrollBar)
  private
    FHotTrack: Boolean;
    procedure SetHotTrack(Value: Boolean);
  protected
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property HintColor;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvScrollBar.pas,v $';
    Revision: '$Revision: 1.15 $';
    Date: '$Date: 2005/02/17 10:20:52 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation


constructor TJvScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHotTrack := False;
  // ControlStyle := ControlStyle + [csAcceptsControls];
end;

procedure TJvScrollBar.MouseEnter(Control: TControl);
begin
  if csDesigning in ComponentState then
    Exit;
  if not MouseOver then
  begin
    {$IFDEF VCL}
    if HotTrack then
      Ctl3D := True;
    {$ENDIF VCL}
    inherited MouseEnter(Control);
  end;
end;

procedure TJvScrollBar.MouseLeave(Control: TControl);
begin
  if MouseOver then
  begin
    {$IFDEF VCL}
    if HotTrack then
      Ctl3D := False;
    {$ENDIF VCL}
    inherited MouseLeave(Control);
  end;
end;

procedure TJvScrollBar.SetHotTrack(Value: Boolean);
begin
  FHotTrack := Value;
  {$IFDEF VCL}
  if FHotTrack then
    Ctl3D := False;
  {$ENDIF VCL}  
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

