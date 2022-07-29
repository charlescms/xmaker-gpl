//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("Threads4.res");
USEFORMNS("Main.pas", Main, MainFrm);
USEUNIT("InsThrd.pas");
USEFORMNS("Login.pas", Login, LoginDlg);
USEFORMNS("DataMod.pas", Datamod, dmMain); /* TDataModule: DesignClass */
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TdmMain), &dmMain);
        Application->CreateForm(__classid(TMainFrm), &MainFrm);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
