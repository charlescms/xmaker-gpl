(*  GREATIS BONUS * MAIN FILE                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit BonusReg;

interface

uses Classes;

procedure Register;

implementation

{$R COOLOR.DCR}
{$R FORMSKIN.DCR}
{$R HISTEDIT.DCR}
{$R ICONLIST.DCR}
{$R LIFECOMP.DCR}
{$R CLOCK.DCR}
{$R NOTIFIER.DCR}
{$R WINERROR.DCR}

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
  NameProp, Coolor, FormSkin, HistEdit, IconList, ILDesign, LifeComp, Clock,
  Notifier, WinError;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TComponentName),TComponent,'Name',TNameProperty);
  RegisterComponents('Greatis',[TCoolorDialog,TSimpleFormSkin,TBitmapFormSkin,THistoryEdit,TIconList,TLife,TClock,TNotifier,TWindowsError]);
  RegisterComponentEditor(TIconList,TIconListEditor);
end;

end.
