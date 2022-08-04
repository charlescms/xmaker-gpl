{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvBandsReg.PAS, released on 2002-05-26.

The Initial Developer of the Original Code is John Doe.
Portions created by John Doe are Copyright (C) 2003 John Doe.
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvCmpReg.pas,v 1.34 2004/12/25 09:02:31 marquardt Exp $

unit JvCmpReg;

{$I jvcl.inc}

{$IFDEF MSWINDOWS}
{$DEFINE USEWINDOWS}
{$ENDIF MSWINDOWS}

interface

procedure Register;

implementation

uses
  Classes,
  Controls,
  {$IFDEF COMPILER6_UP}
  DesignEditors, DesignIntf,
  {$ELSE}
  DsgnIntf,
  {$ENDIF COMPILER6_UP}
  JvDsgnConsts,
  {$IFDEF USEWINDOWS}
  JvCreateProcess, JvWinHelp,
  {$ENDIF USEWINDOWS}
  JvAlarms, JvConverter, JvDataEmbedded, JvEnterTab, JvMergeManager,
  JvPageManager, JvPatchFile, JvStringHolder, JvTimeLimit,
  JvTranslator, JvPrint, JvEasterEgg, JvMouseGesture, JvLogFile,
  JvDataEmbeddedEditor, JvPatcherEditor, JvProfilerForm, JvPageManagerForm,
  JvDsgnEditors;

{$IFDEF MSWINDOWS}
{$R ..\Resources\JvCmpReg.dcr}
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
{$R ../Resources/JvCmpReg.dcr}
{$ENDIF UNIX}

procedure Register;
begin
  {$IFDEF COMPILER7_UP}
  GroupDescendentsWith(TJvDataEmbedded, TControl);
  GroupDescendentsWith(TJvComponentEmbedded, TControl);
  GroupDescendentsWith(TJvStrHolder, TControl);
  GroupDescendentsWith(TJvMultiStringHolder, TControl);
  GroupDescendentsWith(TJvPageManager, TControl);
  {$ENDIF COMPILER7_UP}

  RegisterComponents(RsPaletteNonVisual, [TJvAlarms, TJvConverter,
    TJvDataEmbedded,
    TJvEnterAsTab, TJvMergeManager, TJvPageManager, TJvPatchFile, TJvProfiler,
    TJvStrHolder, TJvMultiStringHolder, TJvTimeLimit, TJvTranslator, TJvTranslatorStrings,
    TJvPrint, TJvEasterEgg, TJvMouseGesture, TJvMouseGestureHook, TJvLogFile]);
  {$IFDEF USEWINDOWS}
  RegisterComponents(RsPaletteNonVisual, [TJvCreateProcess, TJvWinHelp]);
  {$ENDIF USEWINDOWS}

  {$IFDEF USEWINDOWS}
  RegisterPropertyEditor(TypeInfo(string), TJvCreateProcess,
    '', TJvExeNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TJvCreateProcess,
    'CurrentDirectory', TJvDirectoryProperty);
  {$ENDIF USEWINDOWS}
//  RegisterPropertyEditor(TypeInfo(TStream), TJvDataEmbedded,
//    'Data', TJvDataEmbeddedEditor);
  RegisterPropertyEditor(TypeInfo(TStrings), TJvPatchFile,
    'Differences', TJvPatcherProperty);
  RegisterPropertyEditor(TypeInfo(TList), TJvPageManager,
    'PageProxies', TJvProxyListProperty);
  RegisterPropertyEditor(TypeInfo(string), TJvPageProxy,
    'PageName', TJvPageNameProperty);
  RegisterPropertyEditor(TypeInfo(TControl), TJvPageManager,
    'PriorBtn', TJvPageBtnProperty);
  RegisterPropertyEditor(TypeInfo(TControl), TJvPageManager,
    'NextBtn', TJvPageBtnProperty);
  RegisterPropertyEditor(TypeInfo(TWinControl), TJvMergeManager,
    'MergeFrame', TJvComponentFormProperty);

  RegisterComponentEditor(TJvPageManager, TJvPageManagerEditor);
  RegisterComponentEditor(TJvStrHolder, TJvStringsEditor);
  RegisterComponentEditor(TJvDataEmbedded, TJvDataEmbeddedEditor);

  RegisterNoIcon([TJvPageProxy]);
end;

end.
