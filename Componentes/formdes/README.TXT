****************************************************************
 Form Designer Pro for Delphi (3-7,2005) and C++ Builder (3-6)
 Runtime Form Designer (TFormDesigner component)
 Version 3.8 (June 16, 2005)
 Copyright (C) 2001-2005 Greatis Software
****************************************************************

TFormDesigner allows you move and resize any control on your 
form. You need not prepare your form to use TFormDesigner. 
Just place TFormDesigner into your form, set Active property 
to True and enjoy!


To install component:
~~~~~~~~~~~~~~~~~~~~~

1) Unpack component archive to any folder

2) ("x" in file names is your Delphi of C++ Builder version)

a) if you use Delphi 3-7:
  Use "File|Open..." menu item of Delphi IDE to open Form 
  Designer runtime package GFDLIBx0.DPK. In "Package..." 
  window click "Compile" button to compile packages 
  GFDLIBx0.DPK. Put compiled BPL file into directory that is 
  accessible through the search PATH (i.e. DOS "PATH" 
  environment variable; for example, in the Windows\System 
  directory). After compiling From Designer runtime package 
  you must install Form Designer design-time package into the 
  IDE. Use "File|Open..." menu item to open Form Designer 
  design-time package GFDSTDx0.DPK. In "Package..." window 
  click "Compile" button to compile the package and then click 
  "Install" button to register Form Designer component on the 
  component palette.

b) if you use Delphi 2005:
  Use "File|Open..." menu item of Delphi IDE to open Form 
  Designer runtime package GFDLIB90.bdsproj. In the Project 
  Manager window click right mouse button on the GFDLIB90.bpl. 
  Choose the Compile menu item to compile the package.
  Put compiled BPL file into directory that is 
  accessible through the search PATH (i.e. DOS "PATH" 
  environment variable; for example, in the Windows\System 
  directory). After compiling From Designer runtime package 
  you must install Form Designer design-time package into the 
  IDE. Use "File|Open..." menu item to open Form Designer 
  design-time package GFDLIB90.bdsproj. In the Project 
  Manager window click right mouse button on the GFDLIB90.bpl. 
  Choose the Compile menu item to install the package.

c) if you use C++ Builder:
  Be sure that linker option "Use dynamic RTL" is unchecked.
  Use "File|Open..." menu item of C++Builder IDE to open 
  Form Designer runtime package GFDLIBx0.BPK. Then use 
  "Project|Make..." or "Project|Build..." menu item to compile 
  package GFDLIBx0.BPK. Put compiled BPL file into directory 
  that is accessible through the search PATH (i.e. DOS "PATH" 
  environment variable; for example, in the Windows\System 
  directory). After compiling Form Designer package you must 
  install Form Designer design-time packages into the 
  C++Builder IDE. Use "Component|Install packages..." menu 
  item to open "Packages" dialog box. Then click "Add..." 
  button, locate GFDSTDx0.BPK and click "OK" to install 
  package into IDE.


New in version 3.8
~~~~~~~~~~~~~~~~~~

· OnContextPopup event for calling the custom popup 
  menu by right click on the component
· New methods and event for simple component placing
· Edit behaviour method and event for choosing the 
  component behaviour (lock, protect, transparent) 
  that can be used with or without the appropriated lists
· New GrabMode property that controls the place of the 
  grab handles around the selected control
· New axis drag feature and new EnableAxisDrag property
· Alignment lines to easy align the dragged controls


New in version 3.72
~~~~~~~~~~~~~~~~~~~

· Delphi 2005 compatibility


New in version 3.71
~~~~~~~~~~~~~~~~~~~

· Small bugs fixed


New in version 3.7
~~~~~~~~~~~~~~~~~~

· Auto-creating the component containers for the 
  non-visual components when component is added when 
  TFormDesigner is active
· ShowComponentCaptions property and OnComponentCaptions 
  event for showing and customization the captions of the 
  non-visual components
· OnComponentBitmap event for customizing the icons of the 
  non-visual components on the edited form
· OnComponentEditable event for hiding component containers 
  of some non-visual components
· Compatibility with RosySky Runtime Scripter*

* RosySky Runtime Scripter is licensed from RosySky Software 
(www.rosysky.com) and included into Greatis Runtime Fusion 
Complete


LICENSE AGREEMENTS
~~~~~~~~~~~~~~~~~~

Single User License:
A single registered copy of Form Designer can only be installed
on a single computer.

Team License:
Registered Form Designer can be installed on 10 computers.

Site License:
Registered Form Designer can be installed on all computers of 
developers' team in one company or organization.

The following actions ARE ALLOWED:
1) The distribution of the products or source codes produced 
   utilizing Form Designer.
2) The distribution of products or source codes produced 
   utilizing a modified version of Form Designer.
3) The creation and distribution of descendant components 
   in source code or compiled form.

The following actions ARE NOT ALLOWED:
1) The distribution of Form Designer, in either source or 
   compiled form.
2) The inclusion of Form Designer, in source or compiled 
   form, within other software distributions.

Form Designer is ROYALTY-FREE software.


Contacting Us
~~~~~~~~~~~~~
Questions? Comments? Suggestions? Bug reports? 
Don't hesitate to contact us.

www:     http://www.greatis.com
support: http://www.greatis.com/bteam.html