{
   Programa.: Filtro.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Filtro;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFormFiltragem = class(TForm)
    ListaCampos: TListBox;
    Label1: TLabel;
    Operacao: TRadioGroup;
    MFiltro: TMemo;
    Panel1: TPanel;
    BtnAjuda: TBitBtn;
    BtnOk: TBitBtn;
    BtnCancela: TBitBtn;
    Label2: TLabel;
    EdExpressao: TEdit;
    Composicao: TRadioGroup;
    BtnInserir: TBitBtn;
    BtnLimpar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    CamposSelecao: TList;
    ProcessarFiltro: Boolean;
  end;

var
  FormFiltragem: TFormFiltragem;

implementation

uses Publicas, Atributo, Tabela;

{$R *.DFM}

procedure TFormFiltragem.FormShow(Sender: TObject);
Var
  I: Integer;
begin
  if CamposSelecao.Count < 1 then
  begin
    MessageDlg('Lista de Campos vazia !',mtError,[mbOk],0);
    Close;
  end;
  ListaCampos.Items.Clear;
  for I:=0 to CamposSelecao.Count-1 do
    ListaCampos.Items.Add(TAtributo(CamposSelecao[I]).Titulo);
  ProcessarFiltro := False;
  ListaCampos.ItemIndex := 0;
  ListaCampos.SetFocus;
end;

procedure TFormFiltragem.FormCreate(Sender: TObject);
begin
  CamposSelecao := TList.Create;
end;

procedure TFormFiltragem.FormDestroy(Sender: TObject);
begin
  CamposSelecao.Free;
end;

procedure TFormFiltragem.BtnLimparClick(Sender: TObject);
begin
  MFiltro.Lines.Clear;
end;

procedure TFormFiltragem.BtnOkClick(Sender: TObject);
begin
  ProcessarFiltro := True;
  Close;
end;

procedure TFormFiltragem.BtnInserirClick(Sender: TObject);
Var
  Oper, Delimit_E,Delimit_D, Separador_E, Negacao: String;
  FormatoData: string;
  CmpF: TAtributo;
  Data: TDateTime;
begin
  CmpF := TAtributo(CamposSelecao[ListaCampos.ItemIndex]);
  if (CmpF.Tipo = tpImagem) then
  begin
    MessageDlg('Campo Imagem não podem ser filtrado !',mtError,[mbOk],0);
    ListaCampos.SetFocus;
    exit;
  end;
  if (CmpF.Calculado) then
  begin
    MessageDlg('Campo "Calculado" não pode ser filtrado !',mtError,[mbOk],0);
    ListaCampos.SetFocus;
    exit;
  end;
  if (not ((CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpMemo))) and (Operacao.ItemIndex = 6) then
  begin
    MessageDlg('Operação ''Contém'' é somente válida para campos Alfanuméricos !',mtError,[mbOk],0);
    ListaCampos.SetFocus;
    exit;
  end;
  Delimit_E := '';
  Delimit_D := '';
  Oper      := '';
  Negacao   := '';
  if (CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpData) or (CmpF.Tipo = tpMemo) then
  begin
    Delimit_E := #39;
    if (Operacao.ItemIndex <= 1) and ((CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpMemo)) then
    begin
      Oper        := ' LIKE ';
      Delimit_E   := #39;
      Delimit_D   := '%'+#39;
    end
    else
      Delimit_D := #39;
  end;
  if Operacao.ItemIndex = 0 then
  begin
    if Trim(Oper) = '' then
      Oper := ' = ';
  end
  else if Operacao.ItemIndex = 1 then
  begin
    if Trim(Oper) = '' then
      Oper := ' <> '
    else
      Negacao := ' Not ';
  end
  else if Operacao.ItemIndex = 2 then
    Oper := ' < '
  else if Operacao.ItemIndex = 3 then
    Oper := ' <= '
  else if Operacao.ItemIndex = 4 then
    Oper := ' > '
  else if Operacao.ItemIndex = 5 then
    Oper := ' >= '
  else if Operacao.ItemIndex = 6 then
  begin
    Oper        := ' LIKE ';
    Delimit_E   := #39+'%';
    Delimit_D   := '%'+#39;
  end
  else if Operacao.ItemIndex = 7 then
  begin
    Oper             := ' IS NULL ';
    Delimit_E        := '';
    Delimit_D        := '';
    EdExpressao.Text := '';
  end;
  if (CmpF.Tipo = tpData) and (Operacao.ItemIndex <> 7) then
  begin
    try
      FormatoData     := ShortDateFormat;
      ShortDateFormat := 'd/m/y';
      Data            := StrToDate(EdExpressao.Text);
      ShortDateFormat := FormatoData;
      EdExpressao.Text:= DataSql(Data);
    except
      on EConvertError do
      begin
         ShortDateFormat := FormatoData;
         MessageDlg('Data inválida !', mtError, [mbOk], 0);
         EdExpressao.SelectAll;
         EdExpressao.SetFocus;
         exit;
      end;
    end;
  end;
  Separador_E := Negacao + '(';
  if MFiltro.Lines.Count > 0 then
    if Composicao.ItemIndex = 0 then
      Separador_E := 'AND '+ Negacao + '('
    else
      Separador_E := 'OR '+Negacao + '(';
  MFiltro.Lines.Add(Separador_E + CmpF.NomeTabela + '.' + CmpF.NomeOriginal + Oper + Delimit_E + EdExpressao.Text + Delimit_D + ')');
  EdExpressao.Text := '';
  ListaCampos.SetFocus;
end;

procedure TFormFiltragem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
