{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBGridEditors.PAS, released on 2004-10-06.

The Initial Developer of the Original Code is Fr�d�ric Leneuf-Magaud.
Portions created by Fr�d�ric Leneuf-Magaud are Copyright (C) 2004 Fr�d�ric Leneuf-Magaud.
All Rights Reserved.

Contributor(s): Olivier Sannier

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBGridEditors.pas,v 1.2 2004/12/25 09:02:34 marquardt Exp $

unit JvDBGridEditors;

{$I jvcl.inc}

interface

uses
  Classes, Controls, Forms,
  {$IFDEF COMPILER6_UP}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF COMPILER6_UP}
  TypInfo;

type
  TJvDBGridControlsProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;
  
implementation

uses
  JvDBGrid, JvDBGridControlsEditorForm,
  JvDsgnConsts, JvTypes;

procedure TJvDBGridControlsProperty.Edit;
var
  Dlg: TfrmJvDBGridControlsEditor;
  CloseDataset: Boolean;
begin
  CloseDataset := False;
  if TJvDBGrid(GetComponent(0)).DataSource = nil then
    raise EJVCLException.CreateRes(@RsEJvDBGridDataSourceNeeded);
  if TJvDBGrid(GetComponent(0)).DataSource.DataSet = nil then
    raise EJVCLException.CreateRes(@RsEJvDBGridDataSetNeeded);
  if not TJvDBGrid(GetComponent(0)).DataSource.DataSet.Active then
  begin
    TJvDBGrid(GetComponent(0)).DataSource.DataSet.Open;
    CloseDataset := True;
  end;

  Dlg := TfrmJvDBGridControlsEditor.Create(Application);
  try
    Dlg.JvDBGridControls.Assign(TJvDBGridControls(GetOrdValue));
    Dlg.Grid := TJvDBGrid(GetComponent(0));
    Dlg.Initialize;
    Dlg.ShowModal;
    if Dlg.ModalResult = mrOk then
    begin
      TJvDBGridControls(GetOrdValue).Assign(Dlg.JvDBGridControls);
      Modified;
    end;
  finally
    Dlg.Free;
    if CloseDataset then
      TJvDBGrid(GetComponent(0)).DataSource.DataSet.Close;
  end;
end;

function TJvDBGridControlsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TJvDBGridControlsProperty.GetValue: string;
begin
  Result := '(' + GetPropType^.Name + ')';
end;

end.
