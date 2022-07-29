(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, InspCtrl, CompInsp;

type
  TfrmMain = class(TForm)
    ComponentInspector: TComponentInspector;
    procedure ComponentInspectorGetButtonType(Sender: TObject;
      TheIndex: Integer; var Value: TButtonType);
    procedure ComponentInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.ComponentInspectorGetButtonType(Sender: TObject;
  TheIndex: Integer; var Value: TButtonType);
begin
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) and
      (Properties[TheIndex].Name='Caption') then Value:=btDropDown;
end;

procedure TfrmMain.ComponentInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) and
      (Properties[TheIndex].Name='Caption') then
      Strings.Text:='Caption 1'#13'Caption 2'#13'Caption 3';
end;

end.
