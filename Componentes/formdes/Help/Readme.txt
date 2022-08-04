**********************************************************************
  GREATIS FORM DESIGNER HELP
  Copyright (C) 2002-2004 Greatis Software
**********************************************************************

How to install help into IDE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Delphi 4 or higher and C++ Builder 3 or higher:

1. Copy the file *.hlp and *.cnt into the help
   directory of Delphi or C++ Builder, (for example 
   C:\program files\Borland\Delphi6\help\).

2. Start Delphi or C++ Builder. 

3. From the main menu choose Help | Customize...
   The OpenHelp tool starts and opens the 
   configuration file of Delphi's online help.

4. Select the Contents tab.

5. Choose Edit | Add Files..., then locate and open *.cnt 
   files. This will merge the keywords in *.cnt file with 
   the keyword index of Delphi's or C++ Builder's help.

6. Select the Index tab.

7. Choose Edit | Add Files..., then locate and open *.hlp 
   files. This will merge the keywords in *.hlp file with 
   the keyword index of Delphi's or C++ Builder's help.

8. Select the Link tab.

9. Choose Edit | Add Files..., then locate and open again 
   your *.hlp files. This will enable context sensitive help 
   for the component.

10. Choose File | Save Project, then close the window.


Delphi 3:

1. Copy the files *.hlp and *.cnt into the help directory of 
   Delphi, (by default C:\program files\Borland\Delphi 3\help\).

2. Open Delphi3.cfg with a text editor.

3. In the 3rd-party section at the end of this file, 
   add the following line for each help file:

:Link filename.hlp

   where filename.hlp is name of your help file (f.e. formdes.hlp)

4. Save Delphi3.cfg file.

5. Delete the hidden file Delphi3.GID


Contacting Us
~~~~~~~~~~~~~
Questions? Comments? Suggestions? Bug reports? 
Don't hesitate to contact us.

www:     http://www.greatis.com
support: http://www.greatis.com/bteam.html