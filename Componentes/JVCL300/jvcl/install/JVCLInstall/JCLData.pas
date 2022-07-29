{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JCLData.pas, released on 2004-11-05.

The Initial Developer of the Original Code is Andreas Hausladen
(Andreas dott Hausladen att gmx dott de)
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JCLData.pas,v 1.4.4.1 2005/03/16 10:56:26 obones Exp $

unit JCLData;

{$I jvcl.inc}

interface

const
  { JCLVersion specifies the string that is displayed when the JVCL Installer
    requires the user to install or compile the JCL. Changing this constant
    will only change the displayed string but not the JCL version testing
    code. }
  JCLVersion = '1.95';


  { JCLBrowsePaths specifies the JCL directories that could be found in the
    browse and source path lists. They must have a leading backslash. If the
    path does not end with a backslash, the path is compared with the end
    (EndsWith) of the browse/source path. If it ends with a backslash the
    Installer searches for it in (Pos) the browse/search path. }
  JCLBrowsePaths: array[0..1] of string = (
    '\source\common',
    '\lib\'
  );


  { JCLIdentify specifies the JCL files that must exist in an assumed JCL root
    directory found by using JCLBrowsePaths[]. The paths must start with a
    backslash. }
  JCLIdentify: array[0..0] of string = (
    '\source\common\JclBase.pas'
  );


  { JCLIdentifyOutdated specifies the JCL files that must exist in the JCL root
    directory to be accepted as a new enought JCL version. The paths must start
    with a backslash. A leading "+" means that the file must exist, a leading
    "-" means that the file must not exist. }
  JCLIdentifyOutdated: array[0..3] of string = (
     '+\source\common\JclArrayLists.pas', // 1.95
     '+\source\common\JclCompression.pas',
     '+\source\common\JclUnitVersioning.pas',
     '+\source\common\JclWideStrings.pas'
  );


implementation

end.
