//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("GFDLIB50.res");
USEPACKAGE("vcl50.bpi");
USEFORMNS("FDEditor.pas", Fdeditor, frmFDEditor);
USEFORMNS("FDAdd.pas", Fdadd, frmFDAdd);
USEFORMNS("FDAlign.pas", Fdalign, frmAlign);
USEFORMNS("FDAlPal.pas", Fdalpal, frmAlignmentPalette);
USEUNIT("FDMain.pas");
USEFORMNS("FDSize.pas", Fdsize, frmSize);
USEFORMNS("FDTab.pas", Fdtab, frmTabOrder);
USEUNIT("FDCmpPal.pas");
USEUNIT("CtrlDes.pas");
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
