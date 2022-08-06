unit Pesquisa_Ed;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Messages;

type
  TFormPesquisa_Ed = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    EdPesquisa: TEdit;
    Label1: TLabel;
    EdCampos: TComboBox;
    Label2: TLabel;
    Origem: TRadioGroup;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPesquisa_Ed: TFormPesquisa_Ed;

implementation

{$R *.DFM}

procedure TFormPesquisa_Ed.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
    begin
      Key := #0;
      {Atua como a tecla TAB}
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

end.
