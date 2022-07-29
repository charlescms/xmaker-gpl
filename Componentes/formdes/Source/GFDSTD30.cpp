//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GFDSTD30.res");
USEUNIT("FDReg.pas");
USERES("FDReg.dcr");
USEPACKAGE("VCL35.bpi");
USEUNIT("CDReg.pas");
USERES("CDReg.dcr");
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
