(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.005                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit InspReg;

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
  Classes, OIDsgn, PropIntf, InspCtrl, CompInsp, DBInspct, AppInsp, IniInsp,
  SColInsp;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Inspectors',[TPropertyInterface,TCommonInspector,TComponentInspector,TComponentTree,TComponentComboBox,TIniInspector,TDBInspector,TApplicationInspector,TSystemColorsInspector]);
  RegisterPropertyEditor(TypeInfo(TComponent),TPropertyInterface,'Root',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TPropertyInterface,'Instance',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TComponentInspector,'Root',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TComponentInspector,'Instance',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TComponentTree,'Root',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TComponentTree,'Instance',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TComponentComboBox,'Root',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TComponentComboBox,'Instance',TOIComponentProperty);
end;

end.
