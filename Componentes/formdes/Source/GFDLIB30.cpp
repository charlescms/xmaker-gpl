//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GFDLIB30.res");
USEPACKAGE("VCL35.bpi");
USEFORMNS("FDAdd.pas", Fdadd, frmFDAdd);
USEFORMNS("FDAlign.pas", Fdalign, frmAlign);
USEFORMNS("FDAlPal.pas", Fdalpal, frmAlignmentPalette);
USEFORMNS("FDEditor.pas", Fdeditor, frmFDEditor);
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
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
