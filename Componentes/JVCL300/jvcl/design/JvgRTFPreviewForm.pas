{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvgRTFPreviewEditorForm.PAS, released on 2003-01-15.

The Initial Developer of the Original Code is Andrey V. Chudin,  [chudin att yandex dott ru]
Portions created by Andrey V. Chudin are Copyright (C) 2003 Andrey V. Chudin.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvgRTFPreviewForm.pas,v 1.8 2004/07/22 07:37:58 marquardt Exp $

unit JvgRTFPreviewForm;

{$I jvcl.inc}

interface

uses
  Windows, Classes, Forms, ComCtrls, Controls, StdCtrls;

type
  TJvgRTFPreview = class(TForm)
    Rich: TRichEdit;
  public
  end;

implementation

{$R *.dfm}

end.
