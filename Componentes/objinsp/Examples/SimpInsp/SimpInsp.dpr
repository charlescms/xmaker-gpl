(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

program SimpInsp;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Image in 'Image.pas' {ImageForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TInspector Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TImageForm, ImageForm);
  Application.Run;
end.
