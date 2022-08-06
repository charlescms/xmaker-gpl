  RX Library 2.75 port to Delphi 6, v1.1 (by Oleg Fyodorov)
  =========================================================

TABLE OF CONTENTS
-----------------
  Overview
  Compatibility with your older code
  History
  Installation
  Help files
  Copyright Notes


Overview
--------
  This port is a non-commercial product. Feel free to distribute it as
long as all files are unmodified and kept together.

  The authors disclaim all warranties as to this software, whether express
or implied, including without limitation any implied warranties of
merchantability or fitness for a particular purpose. Use under your own
responsibility, but comments (even critique) in English (or in Russian)
are welcome.


Compatibility with your older code
-----------------------------------
  - StrUtils is renamed to rxStrUtils to avoid the names conflict with Borland's StrUtils module.
  - RxGrids.TInplaceEditStyle type is replaced with Delphi 6 TEditStyle type.


History
-------
June, 24, 2001 - version 0.9
  First version. Deprecated and platform-dependent functions are ingnored.
  Therefore rxctl6.dpk still has 90 warnings, rxdb6.dpk - 7 and rxbde6.dbk - 4.

June, 26, 2001 - version 1.0
  All deprecated calls are removed. Platform-dependent warnings are turned off.
  No more hints and warnings when compiling.
  Added TRxDBFilter. Big thanks to Nick Walter for help.

June, 27, 2001 - version 1.1
  Official RX Library 2.75 fix (from November 4, 1999) is applied.
  Big thanks to Nick Walter for reminding about that ;-)


Installation
------------
If you have Delphi 6 Professional or Personal Edition, deactivate the
conditional define {$DEFINE DCS} in the RX.INC file before compiling the
library.

Use "File\Open..." menu item of Delphi IDE to open RX' runtime
package RXCTL6.DPK. In "Package..." window click "Compile" button to
compile packages RXCTL6.DPK. After compiling repeat that for other RX
Library run-time packages RXDB6.DPK, RXBDE6.DPK. Put compiled BPL files
into directory that is accessible through the search PATH (i.e. DOS
"PATH" environment variable; for example, in the Windows\System directory).
After compiling RX run-time packages you must install RX design-time
packages into the IDE.

Use "File\Open..." menu item to open RX design-time package DCLRX6.DPK.
In "Package..." window click "Compile" button to compile the package
and then click "Install" button to register RX Library components on
the component palette. Repeat that for other RX Library design-time
packages DCLRXDB6.DPK and DCLRXBD6.DPK.

NOTE: do not save package sources in the Delphi IDE.

Help files
----------
  Native RX Library help files are available in Russian only. But there are
many third-party help files for RX Library in English, that you can easily
download and install into your Delphi 6 environment.

Copyright Notes
---------------
  RX Library is a copyright of http://www.rxlib.com team: 
    Fedor Kozhevnikov  (fkozh@iname.com)
    Igor Pavluk        (igorp@mail.com)
    Serge Korolev      (korolev@usa.net)

  Delphi 6 port made by:
    Oleg Fyodorov      (delphi@oxygensoftware.com)
                       http://www.oxygensoftware.com

