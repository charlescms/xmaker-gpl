(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PropList, InspCtrl, CompInsp, ExtCtrls, TypInfo, PropEdit;

type
  TStringPropertyEditor = class(TPropertyEditor)
  public
    function Execute: Boolean; override;
  end;

  TMainForm = class(TForm)
    ComponentInspector: TComponentInspector;
    procedure ComponentInspectorGetButtonType(Sender: TObject;
      TheIndex: Integer; var Value: TButtonType);
    procedure ComponentInspectorGetEnableExternalEditor(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure ComponentInspectorGetEditorClass(Sender: TObject;
      TheIndex: Integer; var Value: TPropertyEditorClass);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

function TStringPropertyEditor.Execute: Boolean;
var
  OldValue: string;
begin
  with Prop do
  begin
    OldValue:=AsString;
    AsString:=InputBox((Instance as TComponent).Name,Name,OldValue);
    Result:=AsString<>OldValue;
  end;
end;

procedure TMainForm.ComponentInspectorGetButtonType(Sender: TObject;
  TheIndex: Integer; var Value: TButtonType);
begin
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) then
      with Properties[TheIndex] do
        if (TypeKind in [tkString,tkWString,tkLString]) and
          (Value=btNone) then Value:=btDialog;
end;

procedure TMainForm.ComponentInspectorGetEnableExternalEditor(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) then
      with Properties[TheIndex] do
        Value:=TypeKind in [tkString,tkWString,tkLString];
end;

procedure TMainForm.ComponentInspectorGetEditorClass(Sender: TObject;
  TheIndex: Integer; var Value: TPropertyEditorClass);
begin
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) then
      with Properties[TheIndex] do
        if (TypeKind in [tkString,tkWString,tkLString]) and
          not Assigned(Value) then Value:=TStringPropertyEditor;
end;

end.
