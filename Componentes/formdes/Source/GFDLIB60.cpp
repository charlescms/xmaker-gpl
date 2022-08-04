//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("FDTab.pas", Fdtab, frmTabOrder);
USEFORMNS("FDAlign.pas", Fdalign, frmAlign);
USEFORMNS("FDAlPal.pas", Fdalpal, frmAlignmentPalette);
USEFORMNS("FDEditor.pas", Fdeditor, frmFDEditor);
USEFORMNS("FDSize.pas", Fdsize, frmSize);
USEFORMNS("FDAdd.pas", Fdadd, frmFDAdd);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
