//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "JvUIB"
#pragma link "JvComponent"
#pragma resource "*.dfm"
TMainForm *MainForm;
//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::GoClick(TObject *Sender)
{
  Query->Params->Clear();
  Word Index = Query->Params->AddInteger(623);
  Query->Open();
  Memo->Clear();
  while (!Query->Eof) {
    Memo->Lines->Add(Format("%s %s, Salary: %f",
      OPENARRAY(TVarRec, (
        Query->Fields->ByNameAsString["FIRST_NAME"],
        Query->Fields->ByNameAsString["LAST_NAME"],
        Query->Fields->ByNameAsDouble["SALARY"]))));
    Query->Next();
  };
  Query->Close(etmCommit);
}
//---------------------------------------------------------------------------
