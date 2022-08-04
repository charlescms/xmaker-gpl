{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvActnResForm.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are:
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

description :

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvActnResForm.pas,v 1.12 2005/03/10 09:12:59 marquardt Exp $

unit JvActnResForm;

{$I jvcl.inc}

interface

uses
  ActnList, ImgList, Controls,
  {$IFDEF COMPILER5}
  Forms,
  {$ENDIF COMPILER5}
  SysUtils, Classes, StdActns,
  JvActions;

type
  TJvStandardActions = class(TDataModule)
    ImageList1: TImageList;
    ActionList1: TActionList;
    JvSendMailAction1: TJvSendMailAction;
    JvWebAction1: TJvWebAction;
  public
  end;

// (rom) unused
// var
//   JvStandardActions: TJvStandardActions;

implementation

{$IFDEF VCL}
{$R *.dfm}
{$ENDIF VCL}
{$IFDEF VisualCLX}
{$R *.xfm}
{$ENDIF VisualCLX}

end.
