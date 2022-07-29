#-------------------------------------------------------------------------------
# mo file creation for JEDI Visual Component Library (and JVCLX)
#-------------------------------------------------------------------------------

!ifndef ROOT
ROOT = $(MAKEDIR)\..
!endif

MAKE = "$(ROOT)\bin\make.exe" -l+

#-------------------------------------------------------------------------------

LANGUAGES=bg de es fr it nl pl ro ru sv

#-------------------------------------------------------------------------------

default: $(LANGUAGES)


bg:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

de:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

es:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

fr:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

it:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

nl:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

pl:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

ro:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

ru:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

sv:
	echo Generating: $&
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\JVCLInstall.mo $&\LC_MESSAGES\JVCLInstall.po >NUL
	"$(DXGETTEXTDIR)\msgfmt" -o $&\LC_MESSAGES\jvcl.mo $&\LC_MESSAGES\jvcl.po >NUL

