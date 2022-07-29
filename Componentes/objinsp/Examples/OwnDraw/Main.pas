(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PropList, InspCtrl, CompInsp, TypInfo;

type
  TMainForm = class(TForm)
    ComponentInspector: TComponentInspector;
    procedure ComponentInspectorDrawName(Sender: TObject;
      TheIndex: Integer; TheCanvas: TCanvas; TheRect: TRect);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.ComponentInspectorDrawName(Sender: TObject;
  TheIndex: Integer; TheCanvas: TCanvas; TheRect: TRect);
begin
  with Sender as TComponentInspector,TheCanvas.Font do
  begin
    case Properties[TheIndex].TypeKind of
      // green for all char and string type properties
      tkChar,tkWChar,tkString,tkLString,tkWString: Color:=clGreen;
      // navy for number properties
      tkInteger,tkFloat: Color:=clNavy;
      // maroon for enumeration properties including Boolean
      tkEnumeration: Color:=clMaroon;
    // black for other
    else Color:=clBlack;
    end;
    // bold font if property has subproperties (expandable)
    if Properties[TheIndex].Properties.Count>0 then Style:=[fsBold]
    else Style:=[];
    // calling default drawing procedure for current Canvas settings
    DrawPropertyNameDefault(TheCanvas,TheIndex,TheRect);
  end;
end;

end.
