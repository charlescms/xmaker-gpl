(*  GREATIS BONUS * Life                      *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

program Life;

uses
  Windows,
  Forms,
  SysUtils,
  LifeMain in 'LifeMain.pas' {frmMain},
  LifeProp in 'LifeProp.pas' {frmLifeProperties},
  About in 'About.pas' {frmAbout};

{$E scr}
{$R *.RES}
{$D SCRNSAVE Greatis Life}

var
  PS: string;

begin
  {$IFNDEF DEBUG}
  if (FindWindow('TfrmMain','Greatis Life')=0) and
     (FindWindow('TfrmLifeProperties','Greatis Life')=0) then
  {$ENDIF}
  begin
    Application.Initialize;
    Application.Title := 'Greatis Life';
    PS:=AnsiUpperCase(Copy(ParamStr(1),1,2));
    if (PS='/C') or (PS='-C') then
    begin
      Application.CreateForm(TfrmLifeProperties, frmLifeProperties);
      Application.CreateForm(TfrmAbout, frmAbout);
    end
    else
      if (PS='/S') or (PS='-S') then Application.CreateForm(TfrmMain, frmMain)
      else Exit;
    Application.Run;
  end;
end.
