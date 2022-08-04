unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FDMain, StdCtrls;

type
  TfrmMain = class(TForm)
    Button: TButton;
    cmpFormDesigner: TFormDesigner;
    procedure cmpFormDesignerMoveLimit(Sender: TObject; TheControl: TControl;
      var LimitRect: TRect);
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

procedure TfrmMain.cmpFormDesignerMoveLimit(Sender: TObject;
  TheControl: TControl; var LimitRect: TRect);
begin
  with LimitRect do
    Right:=(Left+Right) div 2;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  cmpFormDesigner.Active:=True;
end;

end.
