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
    function ComponentInspectorValidateChar(Sender: TObject;
      TheIndex: Integer; var Key: Char): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

function TMainForm.ComponentInspectorValidateChar(Sender: TObject;
  TheIndex: Integer; var Key: Char): Boolean;
begin
  Result:=True;
  if Assigned(ComponentInspector.Properties[TheIndex]) then
    with ComponentInspector.Properties[TheIndex] do
      if TypeKind=tkInteger then
        Result:=
          (PropType=TypeInfo(TColor)) or
          (PropType=TypeInfo(TCursor)) or
          (Key in ['0'..'9']);
end;

end.
