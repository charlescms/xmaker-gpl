/******************************************************************

                       JEDI-VCL Demo

 Copyright (C) 2004 Project JEDI

 Original author: Olivier Sannier (obones att altern dott org)

 You may retrieve the latest version of this file at the JEDI-JVCL
 home page, located at http://jvcl.sourceforge.net

 The contents of this file are used with permission, subject to
 the Mozilla Public License Version 1.1 (the "License"); you may
 not use this file except in compliance with the License. You may
 obtain a copy of the License at
 http://www.mozilla.org/MPL/MPL-1_1Final.html

 Software distributed under the License is distributed on an
 "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 implied. See the License for the specific language governing
 rights and limitations under the License.

******************************************************************/
// $Id: MainForm.cpp,v 1.3 2004/06/15 10:43:10 obones Exp $
//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MainForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "JvSimpleXml"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::btnLoadClick(TObject *Sender)
{
  if (OpenDialog1->Execute())
    reXML->Lines->LoadFromFile(OpenDialog1->FileName);
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::btnValidateClick(TObject *Sender)
{
  sbResults->Panels->Items[0]->Text = "Validating...";
  sbResults->Update();
  Screen->Cursor = crHourGlass;
  try
  {
    try
    {
      JvSimpleXml1->LoadFromString(reXML->Lines->Text);
      sbResults->Panels->Items[0]->Text = "No errors encountered in XML";
    }
    catch (Exception &E)
    {
        sbResults->Panels->Items[0]->Text = E.Message;
    }
  }
  __finally
  {
    Screen->Cursor = crDefault;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::reXMLChange(TObject *Sender)
{
  btnValidate->Enabled = (reXML->GetTextLen() > 0);
}
//---------------------------------------------------------------------------
