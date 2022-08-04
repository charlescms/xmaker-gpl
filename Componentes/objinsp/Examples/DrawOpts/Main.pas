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
    procedure ComponentInspectorGetNameColor(Sender: TObject;
      TheIndex: Integer; var Value: TColor);
    procedure ComponentInspectorGetNameFont(Sender: TObject;
      TheIndex: Integer; const TheFont: TFont);
    procedure ComponentInspectorGetValueColor(Sender: TObject;
      TheIndex: Integer; var Value: TColor);
    procedure ComponentInspectorGetValueFont(Sender: TObject;
      TheIndex: Integer; const TheFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.ComponentInspectorGetNameColor(Sender: TObject;
  TheIndex: Integer; var Value: TColor);
begin
  with Sender as TComponentInspector do
    // standard color for highlighted item when paint style is not classic
    if (TheIndex=ItemIndex) and (PaintStyle<>psClassic) then Value:=clHighlight
    else
      case Properties[TheIndex].TypeKind of
        // light green for all char and string type properties
        tkChar,tkWChar,tkString,tkLString,tkWString: Value:=$C0FFC0;
        // light blue for number properties
        tkInteger,tkFloat: Value:=$FFC0C0;
        // pink for enumeration properties including Boolean
        tkEnumeration: Value:=$C0C0FF;
        // else use default color
      end;
end;

procedure TMainForm.ComponentInspectorGetNameFont(Sender: TObject;
  TheIndex: Integer; const TheFont: TFont);
begin
  // bold font if property has subproperties (expandable)
  with Sender as TComponentInspector do
  begin
    // standard color for highlighted item when paint style is not classic
    if (TheIndex=ItemIndex) and (PaintStyle<>psClassic) then TheFont.Color:=clHighlightText;
    if (Sender as TComponentInspector).Properties[TheIndex].Properties.Count>0 then
      TheFont.Style:=[fsBold];
  end;
end;

procedure TMainForm.ComponentInspectorGetValueColor(Sender: TObject;
  TheIndex: Integer; var Value: TColor);
begin
  // light yellow for all values
  Value:=$C0FFFF;
end;

procedure TMainForm.ComponentInspectorGetValueFont(Sender: TObject;
  TheIndex: Integer; const TheFont: TFont);
begin
  // bold font if property has subproperties (expandable)
  if (Sender as TComponentInspector).Properties[TheIndex].Properties.Count>0 then
    TheFont.Style:=[fsBold];
end;

end.
