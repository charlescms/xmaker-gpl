(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, InspCtrl, IniInsp;

type
  TfrmMain = class(TForm)
    IniInspector: TIniInspector;
    FileLabel: TLabel;
    Button: TButton;
    Edit: TEdit;
    OpenDialog: TOpenDialog;
    procedure ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.ButtonClick(Sender: TObject);
begin
  with OpenDialog do
    if Execute then
    begin
      Edit.Text:=FileName;
      IniInspector.FileName:=FileName;
    end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  IniInspector.FileName:=Edit.Text;
end;

end.
