(*  GREATIS FORM EXTRACTOR for                *)
(*  GREATIS FORM DESIGNER                     *)
(*  Copyright (C) 2002-2004 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

program DFMX;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Objs in 'Objs.pas',
  Procs in 'Procs.pas',
  About in 'About.pas' {frmAbout},
  Common in 'Common.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Greatis Form Extractor';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
