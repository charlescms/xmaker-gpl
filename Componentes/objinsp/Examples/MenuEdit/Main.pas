(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, TypInfo, StdCtrls, InspCtrl, CompInsp;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileItem: TMenuItem;
    FileExitItem: TMenuItem;
    HelpItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    ComponentInspector: TComponentInspector;
    procedure FileExitItemClick(Sender: TObject);
    procedure HelpAboutItemClick(Sender: TObject);
    procedure ShowYes(Sender: TObject);
    procedure ShowNo(Sender: TObject);
    procedure ComponentInspectorFillEventList(Sender: TObject;
      EventType: PTypeInfo; Strings: TStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.HelpAboutItemClick(Sender: TObject);
begin
  ShowMessage('Greatis Object Inspector Pro'#13'Menu Editor Example');
end;

procedure TMainForm.ShowYes(Sender: TObject);
begin
  ShowMessage('YES-YES-YES');
end;

procedure TMainForm.ShowNo(Sender: TObject);
begin
  ShowMessage('NO-NO-NO');
end;

procedure TMainForm.ComponentInspectorFillEventList(Sender: TObject;
  EventType: PTypeInfo; Strings: TStrings);
begin
  if EventType=TypeInfo(TNotifyEvent) then
    Strings.Text:='FileExitItemClick'#13#10'HelpAboutItemClick'#13#10'ShowYes'#13#10'ShowNo';
end;

end.
