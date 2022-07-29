------------------------------------------------------------------------


  Jedi Code Library

Release 1.95.3
Build 1848
23-March-2005

------------------------------------------------------------------------

JCL release 1.95 includes major additions; thanks to the generous
donation of the Delphi Container Library (DCL) v. 0.89 code base by its
creator Jean-Philippe Bempel, the JCL now provides a set of carefully
designed container classes and interfaces, supplied by the newly added
units:

source\common\JclAbstractContainers.pas
source\common\JclAlgorithms.pas
source\common\JclArrayLists.pas
source\common\JclArraySets.pas
source\common\JclBinaryTrees.pas
source\common\JclContainerIntf.pas
source\common\JclHashMaps.pas
source\common\JclHashSets.pas
source\common\JclLinkedLists.pas
source\common\JclQueues.pas
source\common\JclStacks.pas
source\common\JclVectors.pas

Note that documentation is still in early stage and might even be
incorrect, so beware.
The installer option "Thread safe container classes allows to trade off
between speed (off) and safeness (on). If it's on, synchronization in
multithreaded applications is handled internally, otherwise it is left
to the developer.

Although this one stands out, there have been other valuable additions
like unit JclWideFormat by Rob Kennedy, the JEDI Uses Wizard and more.
CPU information code in JclSysInfo has been updated to report features
of recent CPU types.

For Delphi 2005, integrated Online Help and installer access to the
Object Repository are still not available.

As always, multiple bugs have been fixed; for detailed change logs, use
the facilities of our CVS repository at SourceForge.net
<http://sourceforge.net/projects/jcl/>, see below.


      Supported Tools

    * Delphi version 5, 6, 7, 2005/Win32
    * C++Builder version 5 & 6
    * Kylix 3

Notes:

    * Not every unit supports all tools. Look out for *.exc files in the
      tool-specific lib/ subdirectories for a list of units excluded
      from compilation.
    * Kylix 3/C++ installation is broken; the installer will fail when
      it attempts to build the packages. Since the dreaded file
      open/save dialog Kylix bug is haunting me again (wasn't it
      considered to be defeated as of Kernel 2.4.21?), I am at present
      not investigating this further.
    * *Free Pascal* <http://www.freepascal.org/> (FP) support is in the
      pipeline; this relates to the FP code branch currently under
      development (1.9.x - we will not support FP versions 1.0.x).
      Expect a JCL release providing FP support soon after this branch
      has got stable.


      JCL Distribution content

Install.bat                   - Compile and run JCL Installer (Win32)
QInstall.bat                  - Compile and run CLX version of JCL Installer (Win32)
install.sh                    - Compile and run JCL Installer (Linux)
bin                           - Common place for sample application EXE files
lib                           - Common place for compiled units.
docs                          - Readme (this file) and other documents
examples                      - JCL example applications
examples\make.bat             - Builds selected examples and tools
examples\vcl                  - JCL example applications
examples\vcl\debugextension   - JCL Debug IDE expert for using JclDebug unit
                 \dialog      - Application exception dialog replacement
                 \threadnames - IDE expert showing class names for debugged threads
                 \tools       - Tools for creating files with JCL debug information
examples\vcl\delphitools      - Collection of system tools using JCL
examples\vcl\projectanalyzer  - Project Analyzer IDE expert
examples\visclx               - JCL example applications
examples\windows              - JCL example applications
help                          - Help file
install                       - Installer source code
packages                      - JCL runtime packages and project groups
source                        - JCL source code


      Feedback

If you have any comments or suggestions we would appreciate it if you
drop us a note. There are several ways to get in contact with us:

    * Write to jcl@delphi-jedi.org <mailto:jcl@delphi-jedi.org> or to
      jcl-testing@delphi-jedi.org <mailto:jcl-testing@delphi-jedi.org>
      This email account should not be used for support requests. If you
      need support please use either the newsgroups or the mailing list.
    * If you want to keep up to date about JCL then you can join the JCL
      mailing list by going to http://www.egroups.com/group/JEDI-JCL You
      can also use this list to voice your opinion, comments or suggestions.
    * If you prefer a newsgroup over a mailing list please join us at
      news://forums.talkto.net/jedi.jcl. The newsgroup is the point
      where you can discuss the JCL with other users and with the team
      itself.


      Issue Tracking

An issue tracking tool can be accessed via ('Code Library' category):

http://homepages.borland.com/jedi/issuetracker/

The general rule is: *If you want to get a bug fixed you need to log it!*

The JEDI issue tracker is based up on the Mantis BugTracker Open Source
project. More background information about it is available on its
homepage http://mantisbt.sourceforge.net

Please be aware that you are allowed there to enter feature request and
code donations as well.


      Debug Extension for JclDebug unit

The examples\vcl\debugExtension folder contains IDE expert which assists
to insert JCL Debug information into executable files. This can be
useful when use source location routines from JclDebug unit. These
routines needs some kind of special information to be able provide
source location for given address in the process. Currently there are
four options to get it work:

   1. Generate and deploy MAP file with your executable file. The file
      is generated by the linker. It needs to be set in Project|Options
      dialog -> Linker page, Detailed checkbox.
   2. Generate and deploy JDBG file file with your executable file. This
      is binary file based on MAP file but its size is typically about
      12% of original MAP file. You can generate it by MapToJdbg tool in
      jcl\examples\vcl\tools folder. The advantage over MAP file is
      smaller size and better security of the file content because it is
      not a plain text file and it also contains a checksum.
   3. Generate Borland TD32 debug symbols. These symbols are stored
      directly in the executable file but usually adds several megabytes
      so the file is very large. The advantage is you don't have to
      deploy any other file and it is easy to generate it by checking
      Include TD32 debug info in Linker option page.
   4. Insert JCL Debug info into executable file by the IDE expert. The
      size of added data is similar to JDBG file but it will be inserted
      directly into the executable file. This is probably best option
      because it combines small size of included data and no requirement
      of deploying additional files. In case you use this option you
      need install the JclDebugIde expert.

The IDE expert will add new item to IDE Project menu. For Delphi 5, 6
and 7 it adds 'Insert JCL Debug data' check item at the end of the
Project menu. When the item is checked, everytime the project is
compiled by one of following commands: Compile, Build, Compile All
Projects, Build All Projects or Run necessary JCL debug data are
automatically inserted into the executable. Moreover, for Build and
Build All commands dialog with detailed information of size of these
data will be displayed.

You can generate those debug data for packages and libraries as well
using the expert. Each executable file in the project can use different
option from those listed above. It is not necessary to generate any
debug data for Borland runtime packages because the source location code
can use names of exported functions to get procedure or method name. To
get line number information for Borland RTL and VCL/CLX units you have
to check Use Debug DCUs checkbox in Project|Options dialog -> Compiler
tab. Unfortunately it is not possible to get line number information for
Borland runtime packages because Borland does not provide detailed MAP
files for them so you get procedure or method name only.

In case you have more than one data source for an executable file by an
accident the best one is chosen in following order:

   1. JCL Debug data in the executable file
   2. JDBG file
   3. Borland TD32 symbols
   4. MAP file
   5. Library or Borland package exports

It is also possible to insert JCL debug data programmatically to the
executable file by using MakeJclDbg command line tool in
jcl\examples\vcl\delphitools folder. You can study included makefiles
which uses this tool for building delphitools examples.

To help using JclDebug exceptional stack tracking in application simple
dialog is provided in jcl\examples\debugextension\dialog folder. The
dialog replaces standard dialog displayed by VCL or CLX application when
an unhandled exception occurs. It has additional Detailed button showing
the stack, list of loaded modules and other system information. By
adding the dialog to the application exceptional stack tracking code is
automatically initialized so you don't have to care about it. You can
also turn on logging to text file by setting the Tag property of the
dialog to '1'. There is also version for CLX (ClxExceptDlg) but it works
on Windows only. These dialogs are intended to be added to Object
Repository.

*Short description of getting the JclDebug functionality in your project:*

   1. Close all running instances of Delphi
   2. Install JCL and IDE experts by the JCL Installer
   3. Run Delphi IDE and open your project
   4. Remove any TApplication.OnException handlers from your project (if
      any).
   5. Add new Exception Dialog by selecting File | New | Other ... |
      Dialogs tab, Select 'Exception Dialog' or 'Exception Dialog with
      Send' icon, Click OK button, Save the form (use
      ExceptionDialog.pas name, for example)
   6. Check Project | Insert JCL Debug data menu item
   7. Do Project | Build


      Makefiles

In order to compile selected examples and tools by one command we
provide makefiles.

To use them, cd into the jcl/examples sub directory and at the command
prompt, type

> make

It should start to compile the covered projects using most recent
version of compiler from installed Delphi versions. All executable files
will be created in jcl/bin directory.


      Version Control

To always have access to the most recent changes in the JCL, you should
install a CVS client (we recommend TortoiseCVS and WinCVS) and download
the CVS repository files to your computer. With the CVS client, you can
update your local repository at any time.

For more instructions on how to set up CVS and use it with JVCL, see the
CVS instruction page
<http://sourceforge.net/docman/display_doc.php?docid=14033&group_id=1>.
You can also access the CVS repository via the web
<http://cvs.sourceforge.net/viewcvs.py/jcl/>.


      Downloads

Jedi Code Library: File List on SourceForge:

http://sourceforge.net/project/showfiles.php?group_id=47514


      Getting involved in JCL development

If you want to help out making JCL better or bigger or just plain
cooler, there are several ways in which you can help out. Here are some
of the things we need your help on:

    * Donate source code
    * Donate time writing help
    * Donate time writing demos
    * Donate time fixing bugs

JCL accepts donations from developers as long as the source fullfills
the requirements set up by the JEDI and JCL teams. To read more about
these requirements, visit the page http://homepages.borland.com/jedi/jcl

You can also donate your time by writing help for the source already in
JCL. We currently use Doc-o-Matic to create the finished help files but
the actual help sources are plain text files in a simple to understand
format. We can provide you with auto-generated templates with all
classes, properties, types etc already inserted. The "only" thing left
to do is fill in the actual help text for the help items. If you are
interested in writing help, contact us.

If you want to help fix bugs in JCL, go to Mantis and check the bug
report there. You can post replies as well as fixes directly in the bug
report. One of the JCL developers will pick up the report/fix and update
the CVS repository if the fix is satisfactory. If you report and fix a
lot of bugs, you might even get developer access to CVS so you can
update the JCL files directly.

