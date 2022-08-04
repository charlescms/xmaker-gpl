(*  GREATIS FORM DESIGNER PRO                 *)
(*  Copyright (C) 2001-2002 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

program Groups;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
