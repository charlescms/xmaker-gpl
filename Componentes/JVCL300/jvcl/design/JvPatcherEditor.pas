{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvPatcherEditor.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse att buypin dott com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvPatcherEditor.pas,v 1.17 2004/12/25 09:02:34 marquardt Exp $

unit JvPatcherEditor;

{$I jvcl.inc}

interface

uses
  SysUtils, Classes, Controls, Forms,
  {$IFDEF COMPILER6_UP}
  DesignEditors, DesignIntf,
  {$ELSE}
  DsgnIntf,
  {$ENDIF COMPILER6_UP}
  JvPatchForm;

type
  TJvPatcherProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

implementation

uses
  JvDsgnConsts;

function TJvPatcherProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paSortList];
end;

procedure TJvPatcherProperty.Edit;
var
  Dlg: TPatchFrm;
  Res: TStringList;
begin
  Res := TStringList(GetOrdValue);
  Dlg := TPatchFrm.Create(Application);
  Dlg.LoadFromStr(Res);
  try
    if Dlg.ShowModal = mrOk then
    begin
      Res.Assign(Dlg.SetFromStr);
      SetOrdValue(Integer(Res));
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TJvPatcherProperty.SetValue(const Value: string);
begin
  inherited SetValue(Value);
  if Value = '' then
    TStrings(GetOrdValue).Clear;
end;

function TJvPatcherProperty.GetValue: string;
begin
  if TStrings(GetOrdValue).Count = 0 then
    Result := RsNone
  else
  if TStrings(GetOrdValue).Count > 4 then // first four items are filenames and file sizes
    Result := RsDiff
  else
    Result := RsEqual;
end;

end.

