(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PropList, InspCtrl, CompInsp, ExtCtrls, TypInfo;

type
  TMainForm = class(TForm)
    ComponentInspector: TComponentInspector;
    procedure ComponentInspectorGetButtonType(Sender: TObject;
      TheIndex: Integer; var Value: TButtonType);
    procedure ComponentInspectorGetEnableExternalEditor(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    function ComponentInspectorCallEditor(Sender: TObject; TheIndex: Integer;
      var EnableDefault: Boolean): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

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

function TMainForm.ComponentInspectorCallEditor(Sender: TObject;
  TheIndex: Integer; var EnableDefault: Boolean): Boolean;
var
  OldValue: string;
begin
  Result:=False;
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) then
      with Properties[TheIndex] do
        if TypeKind in [tkString,tkWString,tkLString] then
        begin
          EnableDefault:=False;
          OldValue:=AsString;
          AsString:=InputBox(ComponentInspector.Instance.Name,Name,OldValue);
          Result:=AsString<>OldValue;
        end;
end;

end.
