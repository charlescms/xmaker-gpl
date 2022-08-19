{
   Programa.: Filtro.PAS
   Copyright: X-Maker 
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
    Composicao: TRadioGroup;
    BtnInserir: TBitBtn;
    BtnLimpar: TBitBtn;
    EdExpressao: TComboBox;
    spbProcurar: TSpeedButton;
    rgCaixa: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ListaCamposClick(Sender: TObject);
    procedure spbProcurarClick(Sender: TObject);
    Function  ValidarFiltro : Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
    CamposSelecao: TList;
    ProcessarFiltro: Boolean;

  end;

var
  FormFiltragem: TFormFiltragem;
  FiltroAnterior : string;


implementation

uses Publicas, Atributo, Tabela, GridPesquisa, Windows;


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
  if not ValidarFiltro then
  begin
    Showmessage('Filtro inválido !');
    Exit;
  end;

  ProcessarFiltro := True;
  Close;
end;

procedure TFormFiltragem.BtnInserirClick(Sender: TObject);
Var
  Oper, Delimit_E,Delimit_D, Separador_E, Negacao, Valor: String;
  FormatoData: string;
  CmpF: TAtributo;
  Data: TDateTime;
  TabelaPrincipal : TTabela;
  CaixaAlta, FimCaixaAlta : String;
begin
  Valor:='';
  CmpF := TAtributo(CamposSelecao[ListaCampos.ItemIndex]);
  if {(CmpF.Tipo = tpMemo) or} (CmpF.Tipo = tpImagem) then
  begin
    MessageDlg('Campo Imagem não podem ser filtrados !',mtError,[mbOk],0);
    ListaCampos.SetFocus;
    exit;
  end;
  if (CmpF.Calculado) then
  begin
    MessageDlg('Campo "Calculado" não pode ser filtrado !',mtError,[mbOk],0);
    ListaCampos.SetFocus;
    exit;
  end;
  {if ( (CmpF.Tipo <> tpAlfanumerico) and (CmpF.Tipo <> tpMemo) ) and (Operacao.ItemIndex = 6) then}
  if (not ((CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpMemo))) and (Operacao.ItemIndex = 6) then
  begin
    MessageDlg('Operação ''Contém'' é somente válida para campos Alfanuméricos !',mtError,[mbOk],0);
    ListaCampos.SetFocus;
    exit;
  end;

  if (CmpF.Tipo = tpAlfanumerico) AND (OPERACAO.ItemIndex <> 7) and (rgCaixa.ItemIndex=0) then
  begin
      CaixaAlta := ' UPPER( ';
      FimCaixaAlta := ' ) ';
  end;

  Delimit_E := '';
  Delimit_D := '';
  Oper      := '';
  Negacao   := '';
  if (CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpData) or (CmpF.Tipo = tpMemo) then
  begin
    Delimit_E := #39;
    if (Operacao.ItemIndex <= 1) and ((CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpMemo)) then
    {if (Operacao.ItemIndex < 1) and (CmpF.Tipo = tpAlfanumerico) then}
    begin
      Oper        := ' = ';  //Xmaker5 Oper        := ' LIKE ';
      Delimit_E   := #39;
      Delimit_D   := #39;    //Xmaker5 Delimit_D   := '%'+#39;
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

  if CmpF.ValorValido.Count > 0 then
  begin
    if EdExpressao.Text<> '' then
    begin
       Valor:= CmpF.ValorValido.Strings[EdExpressao.itemindex];
    end
    else if operacao.ItemIndex <> 7 then
    begin
       Showmessage('Selecione uma opção !');
       exit;
    end;
  end
  else
      Valor := EdExpressao.Text;
  TabelaPrincipal := LocalizaTabela(nil,'D'+CmpF.NomeTabela);


//  end;

  MFiltro.Lines.Add(Separador_E + CaixaAlta + TabelaPrincipal.NomeTabela + '.' + CmpF.NomeOriginal + FimCaixaAlta + Oper + CaixaAlta + Delimit_E + Valor + Delimit_D + FimCaixaAlta + ')');
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

procedure TFormFiltragem.ListaCamposClick(Sender: TObject);
var
  CmpF: TAtributo;
  Data: TDateTime;
begin
  CmpF := TAtributo(CamposSelecao[ListaCampos.ItemIndex]);

  spbProcurar.Visible := false;
  EdExpressao.Style := csDropDown;
  EdExpressao.Items.Clear;


  if (CmpF.ValorValido.Count>0) then
  begin
    EdExpressao.Items.AddStrings(CmpF.DescValorValido);
    EdExpressao.Style := csDropDownList;
    EdExpressao.Text := 'Selecione uma opção !';
  end;

  if (CmpF.ChaveEstrangeira <> '') then
  begin
      spbProcurar.Visible := true;
      spbProcurar.Hint := 'Procurar por '+CmpF.Titulo;
  end;

end;

procedure TFormFiltragem.spbProcurarClick(Sender: TObject);
var
  CmpF: TAtributo;
  Data: TDateTime;
begin
  CmpF := TAtributo(CamposSelecao[ListaCampos.ItemIndex]);

    FormGridPesquisa := TFormGridPesquisa.Create(Application);
  Try

    FormGridPesquisa.Atalho := vk_F8;
    FormGridPesquisa.Campo  := CmpF;
    FormGridPesquisa.Avulso := true;
    FormGridPesquisa.ShowModal;
    EdExpressao.Text := FormGridPesquisa.Resultado;
  Finally
    FormGridPesquisa.Free;
  end;
end;

function TFormFiltragem.ValidarFiltro: Boolean;
var
TabelaPrincipal : TTabela;
begin
  TabelaPrincipal := LocalizaTabela(TabelaPrincipal,'D'+TAtributo(CamposSelecao[ListaCampos.ItemIndex]).NomeTabela);
  FiltroAnterior := TabelaPrincipal.Filtro.Text;
  TabelaPrincipal.Filtro.clear;
  if Trim(MFiltro.Text) <> '' then
  TabelaPrincipal.filtro.Add(MFiltro.Text + ' and (1=-1) ')
  else
  TabelaPrincipal.Filtro.Add('(1=-1)');
  Try
//    TabelaPrincipal.DisableControls;
    TabelaPrincipal.AtualizaSql();
    TabelaPrincipal.EnableControls;
    Result := true;
  except
    Result := false;
    TabelaPrincipal.Filtro.Text := FiltroAnterior;
    TabelaPrincipal.AtualizaSql();
    TabelaPrincipal.EnableControls;
  end;
  TabelaPrincipal.Filtro.Clear;
  TabelaPrincipal.Filtro.Add(FiltroAnterior);
end;

end.
