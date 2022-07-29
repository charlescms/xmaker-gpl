(*  GREATIS BONUS * TIconList                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

program ILDemo;

uses
  Forms,
  ILMain in 'ILMain.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TIconList Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
