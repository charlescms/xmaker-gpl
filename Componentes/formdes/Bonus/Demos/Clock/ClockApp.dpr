(*  GREATIS BONUS * TClock                    *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

program ClockApp;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Props in 'Props.pas' {frmClockProperties};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Greatis Clock';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmClockProperties, frmClockProperties);
  Application.Run;
end.
