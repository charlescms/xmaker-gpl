{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvBaseDlgEditor.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].
                Serhiy Perevoznyk [serge_perevoznyk att hotmail dott com]

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvBaseDlgEditor.pas,v 1.19 2005/03/10 09:12:59 marquardt Exp $

unit JvBaseDlgEditor;

{$I jvcl.inc}

interface

uses
  SysUtils, Classes, Windows, Messages, Graphics, Controls, Forms, Dialogs,
  TypInfo,
  {$IFDEF COMPILER6_UP}
  DesignEditors, DesignIntf,
  {$ELSE}
  DsgnIntf,
  {$ENDIF COMPILER6_UP}
  {$IFNDEF COMPILER7_UP}
  EditIntf, ToolIntf, ExptIntf,
  {$ENDIF !COMPILER7_UP}
  JvBaseDlg;

type
  TJvBaseDlgEditor = class(TDefaultEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure Edit; override;
  end;

implementation

uses
  JvDsgnConsts;

procedure TJvBaseDlgEditor.Edit;
begin
  ExecuteVerb(0);
end;

type
  // (p3) TCommonDialog.Execute is protected in D5...
  TAccessProtectedCommonDialog = class(TCommonDialog);

procedure TJvBaseDlgEditor.ExecuteVerb(Index: Integer);
begin
  if Index <> 0 then
    Exit;
  if Component is TCommonDialog then // (p3) a TJvCommonDialog is also a TCommonDialog (nowadays)
    TAccessProtectedCommonDialog(Component).Execute
  else
  if Component is TJvCommonDialogP then
    TJvCommonDialogP(Component).Execute
  else
  // (rom) to accompany TJvCommonDialogP
  if Component is TJvCommonDialogF then
    TJvCommonDialogF(Component).Execute
  else
    Exit;

  { Some properties might have changed }
  Designer.Modified;
end;

function TJvBaseDlgEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0:
      Result := RsPreviewEllipsis;
  end;
end;

function TJvBaseDlgEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.

