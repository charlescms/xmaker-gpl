(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

program DBDemo;

uses
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TInspector Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
