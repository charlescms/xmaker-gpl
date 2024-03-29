{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: MTConst.PAS, released on 2002-09-24.

The Initial Developer of the Original Code is Erwin Molendijk.
Portions created by Erwin Molendijk are Copyright (C) 2002 Erwin Molendijk.
All Rights Reserved.

Contributor(s): ______________________________________.

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvMTConsts.pas,v 1.9 2005/02/17 10:20:42 marquardt Exp $

unit JvMTConsts;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  SysUtils, Classes;

type
  TMTTicket = Integer;

type
  EMTThreadError = class(EThread);
  EMTTerminateError = class(EAbort);

type
  TMTThreadStatus =
    (tsInitializing, tsWaiting, tsRunning, tsTerminating, tsFinished);

type
  TThreadNameInfo = record
    FType: Longword;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: Longword; // thread ID (-1 indicates caller thread)
    FFlags: Longword;    // reserved for future use, must be zero
  end;

const
  MTDefaultBufferSize = 32;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvMTConsts.pas,v $';
    Revision: '$Revision: 1.9 $';
    Date: '$Date: 2005/02/17 10:20:42 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

end.
