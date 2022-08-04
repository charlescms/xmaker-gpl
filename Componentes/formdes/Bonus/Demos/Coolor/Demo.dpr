(*  GREATIS BONUS * TCoolorDialog             *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

program Demo;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TCoolorDialog Demo';
  Application.CreateForm(TfrmDemo, frmDemo);
  Application.Run;
end.
