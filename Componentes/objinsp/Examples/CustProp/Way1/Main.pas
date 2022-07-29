(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, InspCtrl, CompInsp, PropList;

type

  // new type for the custom property
  TColorScheme = (Normal,Flame,Grass,Sun,Moon);

  TMainForm = class(TForm)
    ComponentInspector: TComponentInspector;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure ComponentInspectorFilter(Sender: TObject; Prop: TProperty;
      var Result: Boolean);
  private
    { Private declarations }
    FColorScheme: TColorScheme;
    procedure SetColorScheme(const Value: TColorScheme);
  public
    { Public declarations }
    property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.SetColorScheme(const Value: TColorScheme);
begin
  if FColorScheme<>Value then
  begin
    FColorScheme:=Value;
    case FColorScheme of
      Normal:
      begin
        Color:=clBtnFace;
        Font.Color:=clBlack;
      end;
      Flame:
      begin
        Color:=clRed;
        Font.Color:=clYellow;
      end;
      Grass:
      begin
        Color:=clGreen;
        Font.Color:=clLime;
      end;
      Sun:
      begin
        Color:=clYellow;
        Font.Color:=clBlack;
      end;
      Moon:
      begin
        Color:=clNavy;
        Font.Color:=clAqua;
      end;
    end;
  end;
end;

function GetPropValue(AInstance: TPersistent; Prop: TProperty): string;
begin
  Result:=Prop.Names[Ord((AInstance as TMainForm).ColorScheme)];
end;

procedure SetPropValue(AInstance: TPersistent; Prop: TProperty; Value: string);
begin
  (AInstance as TMainForm).ColorScheme:=TColorScheme(Prop.Values[Value]);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  RegisterCustomProperty(TForm,'ColorScheme',TypeInfo(TColorScheme),True,GetPropValue,SetPropValue);
  ComponentInspector.RefreshList;
end;

procedure TMainForm.ComponentInspectorFilter(Sender: TObject;
  Prop: TProperty; var Result: Boolean);
begin
  Result:=Result and (Prop.PropType<>TypeInfo(TColor));
end;

end.
