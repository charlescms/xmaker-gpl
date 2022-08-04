//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DC3.res");
USEFORMNS("DCTab.pas", Dctab, frmTabOrder);
USEFORMNS("DCAlPal.pas", Dcalpal, frmAlignmentPalette);
USEFORMNS("DCCreate.pas", Dccreate, frmCreationOrder);
USEUNIT("DCMain.pas");
USEUNIT("DCReg.pas");
USERES("DCReg.dcr");
USEFORMNS("DCSize.pas", Dcsize, frmSize);
USEFORMNS("DCAlign.pas", Dcalign, frmAlign);
USEPACKAGE("VCL35.bpi");
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
