//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("QueryUpd.res");
USEFORMNS("UpdTest.pas", Updtest, UpdateTestFrm);
USEFORMNS("Login.pas", Login, LoginDlg);
USEFORMNS("Main.pas", Main, MainFrm);
USEFORMNS("QryTest.pas", Qrytest, QueryTestFrm);
USEFORMNS("DataMod.pas", Datamod, dmData); /* TDataModule: DesignClass */
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TdmData), &dmData);
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
