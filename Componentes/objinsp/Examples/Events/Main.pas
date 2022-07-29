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
    Button: TButton;
    InfoLabel: TLabel;
    procedure ComponentInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure ShowYes(Sender: TObject);
    procedure ShowNo(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.ComponentInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  with ComponentInspector.Properties[TheIndex] do
    if (TypeKind=tkMethod) and (PropType=TypeInfo(TNotifyEvent)) then
      with Strings do
      begin
        Add('ShowYes');
        Add('ShowNo');
      end;
end;

procedure TMainForm.ShowYes(Sender: TObject);
begin
  ShowMessage('YES - YES - YES');
end;

procedure TMainForm.ShowNo(Sender: TObject);
begin
  ShowMessage('NO - NO - NO');
end;

end.
