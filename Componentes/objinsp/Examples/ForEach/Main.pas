(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PropList, PropIntf, TypInfo, StdCtrls;

type

  TCaseFunction = function (const S: string): string;

  TfrmMain = class(TForm)
    cmpPropertyInterface: TPropertyInterface;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    btnToUpper: TButton;
    btnToLower: TButton;
    procedure btnToUpperClick(Sender: TObject);
    procedure btnToLowerClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoForEach(F: TCaseFunction);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.DoForEach(F: TCaseFunction);
var
  C,P: Integer;
  Prop: TProperty;
begin
  for C:=0 to Pred(ComponentCount) do
    with cmpPropertyInterface do
    begin
      Instance:=Self.Components[C];
      for P:=0 to Pred(Count) do
      begin
        Prop:=Properties[P];
        if Assigned(Prop) then
          with Prop do
            if TypeKind in [tkString,tkLString,tkWString] then AsString:=F(AsString);
      end;
    end;
end;

procedure TfrmMain.btnToUpperClick(Sender: TObject);
begin
  DoForEach(AnsiUpperCase);
end;

procedure TfrmMain.btnToLowerClick(Sender: TObject);
begin
  DoForEach(AnsiLowerCase);
end;

end.
