(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PropList, InspCtrl, CompInsp;

type
  TMainForm = class(TForm)
    ComponentInspector: TComponentInspector;
    procedure ComponentInspectorGetValue(Sender: TObject; TheIndex: Integer;
      var Value: String);
    procedure ComponentInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure ComponentInspectorSetValue(Sender: TObject; TheIndex: Integer;
      var Value: String; var EnableDefault: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.ComponentInspectorGetValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
var
  Prop: TProperty;
begin
  if Sender is TComponentInspector then
    with TComponentInspector(Sender) do
    begin
      Prop:=Properties[TheIndex];
      if Assigned(Prop) and (Prop.PropType=TypeInfo(Boolean)) and
        (InplaceEditorType[TheIndex]<>ieCheckBox) then
        if AnsiUpperCase(Value)='TRUE' then Value:='Yes'
        else Value:='No';
    end;
end;

procedure TMainForm.ComponentInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
var
  Prop: TProperty;
begin
  if Sender is TComponentInspector then
    with TComponentInspector(Sender) do
    begin
      Prop:=Properties[TheIndex];
      if Assigned(Prop) and (Prop.PropType=TypeInfo(Boolean)) and
        (InplaceEditorType[TheIndex]<>ieCheckBox) and Assigned(Strings) then
        Strings.Text:='No'#13'Yes';
    end;
end;

procedure TMainForm.ComponentInspectorSetValue(Sender: TObject;
  TheIndex: Integer; var Value: String; var EnableDefault: Boolean);
var
  Prop: TProperty;
begin
  if Sender is TComponentInspector then
    with TComponentInspector(Sender) do
    begin
      Prop:=Properties[TheIndex];
      if Assigned(Prop) and (Prop.PropType=TypeInfo(Boolean)) and
        (InplaceEditorType[TheIndex]<>ieCheckBox) then
        if AnsiUpperCase(Value)='YES' then Value:='True'
        else Value:='False';
    end;
end;

end.
