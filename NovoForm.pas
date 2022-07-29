unit NovoForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TFormNovoForm = class(TForm)
    BtnOk: TButton;
    BtnCancelar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    EdNome: TEdit;
    Label2: TLabel;
    EdTitulo: TEdit;
    Label3: TLabel;
    EdTabela: TComboBox;
    LbForm: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdNomeChange(Sender: TObject);
  private
    { Private declarations }
    Novo: Boolean;
  public
    { Public declarations }
    Tipo: Integer;
    Modelo: String;
  end;

var
  FormNovoForm: TFormNovoForm;

implementation

{$R *.DFM}

uses Formularios, Abertura, Rotinas;

procedure TFormNovoForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormNovoForm.FormShow(Sender: TObject);
begin
  Novo := False;
  TabGlobal_i.DTABELAS.ChaveIndice := 'NOME';
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
  EdTabela.Items.Clear;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    EdTabela.Items.AddObject(TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' + TabGlobal_i.DTABELAS.TITULO_T.Conteudo, TObject(TabGlobal_i.DTABELAS.NUMERO.Conteudo));
    TabGlobal_i.DTABELAS.Next;
  end;
  if (Tipo = 5) or (Tipo = 6) then
  begin
    EdTabela.Enabled := False;
    EdTabela.Color   := clBtnFace;
  end;
  EdNome.SetFocus;
end;

procedure TFormNovoForm.BtnOkClick(Sender: TObject);
var
  Seq: Integer;
begin
  if C_CRACK then
  begin
    Mensagem(MSG_CRACK,ModErro,[ModOk]);
    exit;
  end;
  EdNome.Text := UpperCase(Copy(EdNome.Text,01,01)) + Copy(EdNome.Text,02,Length(EdNome.Text));
  if not FormForms.ValidaNome(EdNome.Text, False) then
  begin
    EdNome.SelectAll;
    EdNome.SetFocus;
    exit;
  end;
  if Trim(EdTitulo.Text) = '' then
  begin
    Mensagem('Necessário informar TITULO !!!',ModAdvertencia,[ModOk]);
    EdTitulo.SetFocus;
    exit;
  end;
  if EdTabela.Enabled then
    if EdTabela.ItemIndex = -1 then
    begin
      Mensagem('Necessário informar TABELA !!!',ModAdvertencia,[ModOk]);
      EdTabela.SetFocus;
      Exit;
    end;
  TabGlobal_i.DFORMULARIO.Filtro := '';
  TabGlobal_i.DFORMULARIO.ChaveIndice := 'numero';
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  TabGlobal_i.DFORMULARIO.Last;
  Seq := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo + 1;
  TabGlobal_i.DFORMULARIO.Inclui(Nil);
  TabGlobal_i.DFORMULARIO.NUMERO.Conteudo   := Seq;
  TabGlobal_i.DFORMULARIO.NOME.Conteudo     := EdNome.Text;
  TabGlobal_i.DFORMULARIO.TIPO.Conteudo     := Tipo;
  TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo := EdTitulo.Text;
  if EdTabela.Enabled then
    TabGlobal_i.DFORMULARIO.TABELA.Conteudo := Integer(EdTabela.Items.Objects[EdTabela.ItemIndex]);
  TabGlobal_i.DFORMULARIO.MODELO.Conteudo   := Modelo;
  TabGlobal_i.DFORMULARIO.Salva;
  Novo := True;
  Close;
end;

procedure TFormNovoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Novo then
    ModalResult := mrOk;
end;

procedure TFormNovoForm.EdNomeChange(Sender: TObject);
begin
  LbForm.Caption := 'Form' + EdNome.Text;
end;

end.
