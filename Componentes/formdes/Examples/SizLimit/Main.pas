unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FDMain, StdCtrls;

type
  TfrmMain = class(TForm)
    Button: TButton;
    cmpFormDesigner: TFormDesigner;
    procedure FormCreate(Sender: TObject);
    procedure cmpFormDesignerSizeLimit(Sender: TObject;
      TheControl: TControl; var MinSize, MaxSize: TPoint);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  cmpFormDesigner.Active:=True;
end;

procedure TfrmMain.cmpFormDesignerSizeLimit(Sender: TObject;
  TheControl: TControl; var MinSize, MaxSize: TPoint);
begin
  with MinSize do
  begin
    X:=40;
    Y:=20;
  end;
  with MaxSize do
  begin
    X:=100;
    Y:=50;
  end;
end;

end.
