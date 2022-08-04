(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.010                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDReg;

interface

{$IFDEF VER140}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER150}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER170}
{$DEFINE NEWDSGNINTF}
{$ENDIF}

uses
  {$IFDEF NEWDSGNINTF}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  Classes, FDMain, FDEditor, FDDsgn;

procedure Register;

implementation

{$R FDREG.DCR}

procedure Register;
begin
  RegisterComponents('Designers', [TFormDesigner]);
  RegisterComponentEditor(TCustomFormDesigner,TFormDesignerEditor);
end;

end.
