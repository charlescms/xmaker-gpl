{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvManagedThreadsReg.PAS, released on 2002-09-24.

The Initial Developer of the Original Code is Erwin Molendijk.
Portions created by Erwin Molendijk are Copyright (C) 2002 Erwin Molendijk.
All Rights Reserved.

Contributor(s):

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvManagedThreadsReg.pas,v 1.14 2005/01/29 06:36:55 marquardt Exp $

unit JvManagedThreadsReg;

{$I jvcl.inc}

interface

uses
  Classes,
  {$IFDEF USEJVCL}
  JvDsgnConsts,
  {$ENDIF USEJVCL}
  JvMTComponents;

procedure Register;

implementation

{$IFDEF MSWINDOWS}
{$R ..\Resources\JvManagedThreadsReg.dcr}
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
{$R ../Resources/JvManagedThreadsReg.dcr}
{$ENDIF UNIX}

{$IFNDEF USEJVCL}
resourcestring
  RsPaletteMTThreads = 'Jv Threading';
{$ENDIF !USEJVCL}

procedure Register;
begin
  RegisterComponents(RsPaletteMTThreads, [TJvMTManager, TJvMTThread,
    TJvMTThreadToVCL, TJvMTVCLToThread, TJvMTThreadToThread, TJvMTSection,
    TJvMTCountingSection, TJvMTMonitorSection]);
end;

end.

