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
    RadioGroup: TRadioGroup;
    ComponentInspector: TComponentInspector;
    procedure RadioGroupClick(Sender: TObject);
    procedure ComponentInspectorFilter(Sender: TObject; Prop: TProperty;
      var Result: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.RadioGroupClick(Sender: TObject);
begin
  ComponentInspector.RefreshList;
end;

procedure TMainForm.ComponentInspectorFilter(Sender: TObject; Prop: TProperty;
  var Result: Boolean);
begin
  with Prop do
    case RadioGroup.ItemIndex of
      1: Result:=TypeKind in [tkString,tkLString,tkWString];
      2: Result:=TypeKind in [tkInteger];
      3: Result:=PropType=TypeInfo(Boolean);
    end;
end;

end.
