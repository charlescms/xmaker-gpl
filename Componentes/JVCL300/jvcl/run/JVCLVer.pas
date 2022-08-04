{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JVCLVer.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Joe Doe .
Portions created by Joe Doe are Copyright (C) 1999 Joe Doe.
Portions created by XXXX Corp. are Copyright (C) 1998, 1999 XXXX Corp.
All Rights Reserved.

Contributor(s): 
  Michael Beck [mbeck att bigfoot dott com].
  Hofi

Last Modified: 2004-10-19

Changes:
2004-10-10:
  * Added by Hofi
      JVCL_VERSION
        Helps conditional compiling in BCB.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JVCLVer.pas,v 1.13 2005/02/17 10:19:57 marquardt Exp $

unit JVCLVer;

{$I jvcl.inc}

interface

{$IFDEF UNITVERSIONING}
uses
  JclUnitVersioning;
{$ENDIF UNITVERSIONING}

{$IFDEF VCL}
const
  JVCL_VERSION = 300;
  JVCL_VERSIONSTRING = '3.00';
{$ENDIF VCL}
{$IFDEF VisualCLX}
const
  JVCL_VERSIONSTRING = '1.00';
{$ENDIF VisualCLX}

type
  TJVCLAboutInfo = (JVCLAbout);

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JVCLVer.pas,v $';
    Revision: '$Revision: 1.13 $';
    Date: '$Date: 2005/02/17 10:19:57 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

