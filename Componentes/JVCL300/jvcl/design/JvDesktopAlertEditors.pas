{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDesktopAlertEditors.PAS, released on 2005-01-08.

The Initial Developer of the Original Code is Olivier Sannier [obones att altern dott org]
Portions created by Sébastien Buysse are Copyright (C) 2005 Olivier Sannier.
All Rights Reserved.

Contributor(s): none to date.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDesktopAlertEditors.pas,v 1.2 2005/01/21 09:28:49 marquardt Exp $

unit JvDesktopAlertEditors;

{$I jvcl.inc}

interface

uses
  {$IFDEF COMPILER6_UP}
  DesignEditors, DesignIntf,
  {$ELSE}
  DsgnIntf,
  {$ENDIF COMPILER6_UP}
  JvDesktopAlert;

type
  TJvCustomDesktopAlertStyleHandlerEditor = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

//=== { TJvCustomDesktopAlertStyleHandlerEditor } ============================

function TJvCustomDesktopAlertStyleHandlerEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes
    {$IFDEF COMPILER6_UP} + [paVolatileSubProperties] {$ENDIF};
end;

end.
