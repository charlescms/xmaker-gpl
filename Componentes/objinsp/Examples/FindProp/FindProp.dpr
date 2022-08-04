(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

program FindProp;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'FindProperty Example';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
