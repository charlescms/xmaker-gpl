//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("ObjInspCB5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("InspReg.pas");
USERES("InspReg.dcr");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vcljpg50.bpi");
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
