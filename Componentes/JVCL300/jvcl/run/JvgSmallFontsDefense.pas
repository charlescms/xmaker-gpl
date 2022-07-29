{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvgSmallFontsDefense.PAS, released on 2003-01-15.

The Initial Developer of the Original Code is Andrey V. Chudin,  [chudin att yandex dott ru]
Portions created by Andrey V. Chudin are Copyright (C) 2003 Andrey V. Chudin.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].
Burov Dmitry, translation of russian text.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Description:
  Prevents your apps from BIG fonts.

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvgSmallFontsDefense.pas,v 1.21 2005/02/17 10:21:21 marquardt Exp $

unit JvgSmallFontsDefense;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  Windows, Messages, SysUtils, Classes, Graphics,
  {$IFDEF USEJVCL}
  Controls, Forms, Dialogs, Grids,
  JvComponent;
  {$ELSE}
  Controls, Forms, Dialogs, Grids;
  {$ENDIF USEJVCL}

type
  TglSmallFontsDefenseOption = (fdoExcludeGrids);
  TglSmallFontsDefenseOptions = set of TglSmallFontsDefenseOption;

  {$IFDEF USEJVCL}
  TJvgSmallFontsDefense = class(TJvComponent)
  {$ELSE}
  TJvgSmallFontsDefense = class(TComponent)
  {$ENDIF USEJVCL}
  private
    FOptions: TglSmallFontsDefenseOptions;
    procedure UpdateFonts(Control: TWinControl);
    procedure SetOptions(const Value: TglSmallFontsDefenseOptions);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Options: TglSmallFontsDefenseOptions read FOptions write SetOptions default [];
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvgSmallFontsDefense.pas,v $';
    Revision: '$Revision: 1.21 $';
    Date: '$Date: 2005/02/17 10:21:21 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

uses
  {$IFDEF USEJVCL}
  JvResources, JvConsts,
  {$ENDIF USEJVCL}
  JvgUtils;

{$IFNDEF USEJVCL}
resourcestring
  RsTJvgSmallFontsDefenseCannotBeUsedWi = 'TJvgSmallFontsDefense cannot be used with large fonts.';
{$ENDIF !USEJVCL}

constructor TJvgSmallFontsDefense.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [];
end;

procedure TJvgSmallFontsDefense.Loaded;
begin
  inherited Loaded;
  if Owner is TForm then
    (Owner as TForm).Scaled := False;
  if csDesigning in ComponentState then
    if not IsSmallFonts then
      ShowMessage(RsTJvgSmallFontsDefenseCannotBeUsedWi);
end;

procedure TJvgSmallFontsDefense.SetOptions(const Value: TglSmallFontsDefenseOptions);
begin
  FOptions := Value;
  if Owner is TCustomForm then
    UpdateFonts(Owner as TCustomForm);
end;

type
  TControlAccessProtected = class(TControl);

procedure TJvgSmallFontsDefense.UpdateFonts(Control: TWinControl);
var
  I: Integer;

  procedure UpdateFont(Font: TFont);
  begin
    if SameText(Font.Name, 'MS Sans Serif') then
      Font.Name := 'Arial';
  end;

begin
  if IsSmallFonts then
    Exit;
  if (fdoExcludeGrids in Options) and (Control is TCustomGrid) then
    Exit;
  UpdateFont(TControlAccessProtected(Control).Font);
  with Control do
    for I := 0 to ControlCount - 1 do
    begin
      UpdateFont(TControlAccessProtected(Controls[I]).Font);
      if Controls[I] is TWinControl then
        UpdateFonts(Controls[I] as TWinControl);
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

