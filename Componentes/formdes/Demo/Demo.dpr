(*  GREATIS FORM DESIGNER DEMO                    *)
(*  Copyright (C) 2001-2004 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

program Demo;

uses
  Forms,
  Design in 'Design.pas' {frmDesign},
  Setup in 'Setup.pas' {frmSetup},
  About in 'About.pas' {frmAbout},
  Related in 'Related.pas' {frmRelated},
  ToolForm in 'ToolForm.pas' {frmToolForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Greatis Form Designer Demo';
  Application.CreateForm(TfrmToolForm, frmToolForm);
  Application.CreateForm(TfrmDesign, frmDesign);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmRelated, frmRelated);
  Application.Run;
end.
