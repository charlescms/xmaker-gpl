(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.003                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit OIDsgn;

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
{$IFDEF VER180}
{$DEFINE NEWDSGNINTF}
{$ENDIF}

uses
  {$IFDEF NEWDSGNINTF}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  Classes;

type
  TOIComponentProperty = class(TComponentProperty)
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

procedure TOIComponentProperty.GetValues(Proc: TGetStrProc);
var
  P: TPersistent;
begin
  inherited;
  P:=GetComponent(0);
  if P is TComponent then Proc(Designer.GetObjectName(TComponent(P).Owner));
end;

end.
