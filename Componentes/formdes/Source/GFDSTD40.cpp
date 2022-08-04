//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GFDSTD40.res");
USEPACKAGE("vcl40.bpi");
USEUNIT("FDReg.pas");
USERES("FDReg.dcr");
USEPACKAGE("GFDLIB40.bpi");
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
