unit EdModelo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, ExtCtrls, FileCtrl;

type
  TFormEdModelo = class(TForm)
    EdTitulo: TEdit;
    LbTitulo: TLabel;
    EdPasta: TDirectoryEdit;
    LbPasta: TLabel;
    btnOk: TButton;
    btnCancela: TButton;
    Bevel1: TBevel;
    ListaFile: TFileListBox;
    EdFile: TComboBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEdModelo: TFormEdModelo;

implementation

{$R *.DFM}

procedure TFormEdModelo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

end.
