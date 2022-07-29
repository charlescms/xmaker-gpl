(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.003                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDDsgn;

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
  Classes, FDMain, FDEditor;

type
  TFormDesignerEditor = class(TComponentEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

implementation

function TFormDesignerEditor.GetVerbCount: Integer;
begin
  Result:=1;
end;

function TFormDesignerEditor.GetVerb(Index: Integer): string;
begin
  Result:='Control &lists editor...';
end;

procedure TFormDesignerEditor.ExecuteVerb(Index: Integer);
begin
  if EditLists(Component as TCustomFormDesigner,ltLocked) then Designer.Modified;
end;

end.
