(*  GREATIS BONUS * Form Skin                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

program Demo;

uses
  Forms,
  BmpSkin in 'BmpSkin.pas' {frmBitmapSkin},
  Main in 'Main.pas' {frmMain},
  Dialog in 'Dialog.pas' {frmDialog},
  HitAreas in 'HitAreas.pas' {frmHitAreas},
  Simple in 'Simple.pas' {frmSimple};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Greatis Form Skin Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmBitmapSkin, frmBitmapSkin);
  Application.CreateForm(TfrmDialog, frmDialog);
  Application.CreateForm(TfrmHitAreas, frmHitAreas);
  Application.CreateForm(TfrmSimple, frmSimple);
  Application.Run;
end.
