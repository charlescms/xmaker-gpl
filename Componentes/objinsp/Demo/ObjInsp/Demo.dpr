(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

program Demo;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Image in 'Image.pas' {ImageForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Greatis Object Inspector Pro Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TImageForm, ImageForm);
  Application.Run;
end.
