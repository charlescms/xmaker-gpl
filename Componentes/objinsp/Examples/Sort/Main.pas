(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PropList, InspCtrl, CompInsp, ExtCtrls;

type
  TMainForm = class(TForm)
    RadioGroup: TRadioGroup;
    ComponentInspector: TComponentInspector;
    procedure ComponentInspectorCompare(Sender: TObject; Prop1,
      Prop2: TProperty; var Result: Integer);
    procedure RadioGroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.ComponentInspectorCompare(Sender: TObject; Prop1,
  Prop2: TProperty; var Result: Integer);
begin
  if RadioGroup.ItemIndex=1 then
    if Integer(Prop1.PropType)<Integer(Prop2.PropType) then Result:=-1
    else
      if Integer(Prop1.PropType)>Integer(Prop2.PropType) then Result:=1;
end;

procedure TMainForm.RadioGroupClick(Sender: TObject);
begin
  ComponentInspector.RefreshList;
end;

end.
