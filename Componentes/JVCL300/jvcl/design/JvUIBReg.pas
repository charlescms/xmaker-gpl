{******************************************************************************}
{                        UNIFIED INTERBASE (UIB)                               }
{                                                                              }
{ Project JEDI Code Library (JCL)                                              }
{                                                                              }
{ The contents of this file are subject to the Mozilla Public License Version  }
{ 1.0 (the "License"); you may not use this file except in compliance with the }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ The Original Code is JvUIBReg.pas.                                           }
{                                                                              }
{ The Initial Developer of the Original Code is documented in the accompanying }
{ help file JCL.chm. Portions created by these individuals are Copyright (C)   }
{ 2000 of these individuals.                                                   }
{                                                                              }
{ Register Components                                                          }
{                                                                              }
{ Unit owner:    Henri Gourvest                                                }
{ Last modified: Jun 08, 2003                                                  }
{                                                                              }
{******************************************************************************}

unit JvUIBReg;

{$IFNDEF BCB}
{$I jvcl.inc}
{$ENDIF !BCB}
{$I jvuib.inc}

interface

{$IFNDEF UIBNOCOMPONENT}
procedure Register;
{$ENDIF !UIBNOCOMPONENT}

implementation

{$IFNDEF UIBNOCOMPONENT}

uses
  Classes, Controls,
  {$IFDEF USEJVCL}
  //JvDsgnConsts,
  {$ENDIF USEJVCL}
  {$IFNDEF DelphiPersonalEdition}
  JvUIBDataSet,
  {$ENDIF !DelphiPersonalEdition}
  JvUIB;

{$IFDEF MSWINDOWS}
{$R ..\Resources\JvUIBReg.dcr}
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
{$R ../Resources/JvUIBReg.dcr}
{$ENDIF UNIX}

{$IFNDEF USEJVCL}
resourcestring
  RsPaletteUIB = 'Jv UIB';
{$ENDIF !USEJVCL}

procedure Register;
begin
  {$IFDEF COMPILER7_UP}
  {$IFNDEF DelphiPersonalEdition}
  GroupDescendentsWith(TJvUIBDataSet, TControl);
  GroupDescendentsWith(TJvUIBCustomDataSet, TControl);
  {$ENDIF !DelphiPersonalEdition}
  {$ENDIF COMPILER7_UP}

  RegisterComponents('Jv UIB', [TJvUIBDatabase, TJvUIBTransaction, TJvUIBQuery,
    {$IFNDEF DelphiPersonalEdition} TJvUIBDataSet, {$ENDIF}
    TJvUIBScript, TJvUIBBackup, TJvUIBRestore]);
end;

{$ENDIF !UIBNOCOMPONENT}

end.
