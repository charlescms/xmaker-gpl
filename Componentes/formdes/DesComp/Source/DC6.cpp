//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEFORMNS("DCTab.pas", Dctab, frmTabOrder);
USEFORMNS("DCAlPal.pas", Dcalpal, frmAlignmentPalette);
USEFORMNS("DCCreate.pas", Dccreate, frmCreationOrder);
USEFORMNS("DCSize.pas", Dcsize, frmSize);
USEFORMNS("DCAlign.pas", Dcalign, frmAlign);
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
