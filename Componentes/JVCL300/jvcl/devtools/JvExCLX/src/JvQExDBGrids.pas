{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExDBGrids.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas dott Hausladen att gmx dott de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvQExDBGrids.pas,v 1.3 2004/11/04 22:23:53 asnepvangers Exp $

unit JvQExDBGrids;

{$I jvcl.inc}
{MACROINCLUDE JvQExControls.macros}

WARNINGHEADER

interface

uses
  QGraphics, QControls, QForms, QExtCtrls, QDBGrids,
  Qt, QWindows, QMessages,
  Classes, SysUtils,
  JvQTypes, JvQThemes, JVCLXVer, JvQExControls;

type
  JV_CONTROL(CustomDBGrid)
  JV_CONTROL(DBGrid)

implementation

JV_CONTROL_IMPL(CustomDBGrid)
JV_CONTROL_IMPL(DBGrid)

{$DEFINE UnitName 'JvQExDBGrids.pas'}

UNITVERSION

end.
