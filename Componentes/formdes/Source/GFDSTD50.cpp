//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("GFDSTD50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("FDReg.pas");
USEPACKAGE("GFDLIB50.bpi");
USEUNIT("CDReg.pas");
USERES("CDReg.dcr");
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
