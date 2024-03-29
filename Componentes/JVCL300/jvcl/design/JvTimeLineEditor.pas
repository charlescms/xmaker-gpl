{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvTimeLineEdit.PAS, released on 2002-05-26.

The Initial Developer of the Original Code is Peter Th�rnqvist [peter3 att users dott sourceforge dott net]
Portions created by Peter Th�rnqvist are Copyright (C) 2002 Peter Th�rnqvist.
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Description:
  Property editor(s) for the @link(TJvTimeLine) component

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvTimeLineEditor.pas,v 1.11 2004/07/22 07:37:58 marquardt Exp $

unit JvTimeLineEditor;

{$I jvcl.inc}

interface

uses
  {$IFDEF COMPILER6_UP}
  DesignEditors, DesignIntf;
  {$ELSE}
  DsgnIntf;
  {$ENDIF COMPILER6_UP}

type
  { a component editor that by default opens the editor for the Items property in TTimeline }
  TJvTimeLineEditor = class(TDefaultEditor)
  public
    {$IFDEF COMPILER6_UP}
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
    {$ELSE}
    procedure EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean); override;
    {$ENDIF COMPILER6_UP}
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  SysUtils,
  JvTimeLine, JvDsgnConsts;

{$IFDEF COMPILER6_UP}
procedure TJvTimeLineEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
begin
  PropName := Prop.GetName;
  if SameText(PropName, 'Items') then
  begin
    Prop.Edit;
    Continue := False;
  end;
end;
{$ELSE}
procedure TJvTimeLineEditor.EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean);
var
  PropName: string;
begin
  PropName := PropertyEditor.GetName;
  if SameText(PropName, 'Items') then
  begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;
{$ENDIF COMPILER6_UP}

procedure TJvTimeLineEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    Edit
  else
    inherited ExecuteVerb(Index);
end;

function TJvTimeLineEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := RsItemsEditorEllipsis
  else
    Result := inherited GetVerb(Index);
end;

function TJvTimeLineEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.

