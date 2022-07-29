(*  GREATIS BONUS * THistoryEdit              *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

program HEDemo;

uses
  Forms,
  Run in 'Run.pas' {frmRun},
  HEMain in 'HEMain.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'THistoryEdit Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmRun, frmRun);
  Application.Run;
end.
