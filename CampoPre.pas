unit CampoPre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, ShellApi;

type
  TFormCamposPredefinidos = class(TForm)
    GrupoCampos: TGroupBox;
    BtnNovoCampo: TSpeedButton;
    BtnDeletarCampo: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ListaCampos: TListBox;
    EdNomeCampo: TEdit;
    ComboTipoCampo: TComboBox;
    EdTamanhoCampo: TMaskEdit;
    ComboEdicaoCampo: TComboBox;
    EdTituloCampo: TEdit;
    EdAjudaCampo: TEdit;
    EdValorCampo: TEdit;
    ComboValidacaoCampo: TComboBox;
    EdDescricaoCampo: TEdit;
    BtnFechar: TBitBtn;
    BitBtn3: TBitBtn;
    BtnGravar: TBitBtn;
    EdMascaraCampo: TComboEdit;
    EdValoresCampo: TComboEdit;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListaCamposClick(Sender: TObject);
    procedure ListaCamposDblClick(Sender: TObject);
    procedure EdNomeCampoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnDeletarCampoClick(Sender: TObject);
    procedure BtnNovoCampoClick(Sender: TObject);
    procedure EdMascaraCampoButtonClick(Sender: TObject);
    procedure EdValoresCampoButtonClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    procedure MontaListaCampos;
  public
    { Public declarations }
  end;

var
  FormCamposPredefinidos: TFormCamposPredefinidos;
  LinhaCmp: Integer;
  NrCampos : Array[0..999] of String;

implementation

{$R *.DFM}

uses Rotinas, Princ, Selecao, VValidos;

procedure TFormCamposPredefinidos.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCamposPredefinidos.FormShow(Sender: TObject);
begin
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  FormPrincipal.Texto.Lines.Clear;
  if (FileExists(Projeto.PastaGerador + 'Campos.Tpl')) then
    FormPrincipal.Texto.Lines.LoadFromFile(Projeto.PastaGerador + 'Campos.Tpl');
  MontaListaCampos;
  if FileExists(Projeto.PastaGerador + 'Validacao.Lst') then
    ComboValidacaoCampo.Items.LoadFromFile(Projeto.PastaGerador + 'Validacao.Lst');
  ListaCampos.ItemIndex := 0;
  ListaCamposClick(Self);
  ListaCampos.SetFocus;
end;

procedure TFormCamposPredefinidos.MontaListaCampos;
var
  QtLinhas,I,QtTbl : Integer;
  Titulo: String;
begin
  for I := 0 to 999 do
    NrCampos[I] := '';
  ListaCampos.Items.Clear;
  I := 0;
  QtTbl := 0;
  QtLinhas := FormPrincipal.Texto.Lines.Count-1;
  while I <= QtLinhas do
  begin
    if Copy(FormPrincipal.Texto.Lines[I],01,06) = 'Numero' then
    begin
      Titulo := Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1])));
      ListaCampos.Items.Add(Titulo);
      NrCampos[QtTbl] := Copy(FormPrincipal.Texto.Lines[I],08,03);
      Inc(QtTbl);
    end;
    I := I + 12;
  end;
end;

procedure TFormCamposPredefinidos.ListaCamposClick(Sender: TObject);
var I : Integer;
begin
  I := ListaCampos.ItemIndex;
  I := 11 * I +  I;
  LinhaCmp := I;
  EdNomeCampo.Text              := Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1])));
  ComboTipoCampo.ItemIndex      := ComboTipoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2]))));
  EdTamanhoCampo.Text           := Trim(Copy(FormPrincipal.Texto.Lines[I+3],Pos('=',FormPrincipal.Texto.Lines[I+3])+2,Length(FormPrincipal.Texto.Lines[I+3])));
  ComboEdicaoCampo.ItemIndex    := ComboEdicaoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.Texto.Lines[I+4],Pos('=',FormPrincipal.Texto.Lines[I+4])+2,Length(FormPrincipal.Texto.Lines[I+4]))));
  EdMascaraCampo.Text           := Trim(Copy(FormPrincipal.Texto.Lines[I+5],Pos('=',FormPrincipal.Texto.Lines[I+5])+2,Length(FormPrincipal.Texto.Lines[I+5])));
  EdTituloCampo.Text            := Trim(Copy(FormPrincipal.Texto.Lines[I+6],Pos('=',FormPrincipal.Texto.Lines[I+6])+2,Length(FormPrincipal.Texto.Lines[I+6])));
  EdAjudaCampo.Text             := Trim(Copy(FormPrincipal.Texto.Lines[I+7],Pos('=',FormPrincipal.Texto.Lines[I+7])+2,Length(FormPrincipal.Texto.Lines[I+7])));
  EdValorCampo.Text             := Trim(Copy(FormPrincipal.Texto.Lines[I+8],Pos('=',FormPrincipal.Texto.Lines[I+8])+2,Length(FormPrincipal.Texto.Lines[I+8])));
  ComboValidacaoCampo.ItemIndex := ComboValidacaoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.Texto.Lines[I+9],Pos('=',FormPrincipal.Texto.Lines[I+9])+2,Length(FormPrincipal.Texto.Lines[I+9]))));
  EdValoresCampo.Text           := Trim(Copy(FormPrincipal.Texto.Lines[I+10],Pos('=',FormPrincipal.Texto.Lines[I+10])+2,Length(FormPrincipal.Texto.Lines[I+10])));
  EdDescricaoCampo.Text         := Trim(Copy(FormPrincipal.Texto.Lines[I+11],Pos('=',FormPrincipal.Texto.Lines[I+11])+2,Length(FormPrincipal.Texto.Lines[I+11])));

  EdNomeCampo.Enabled         := False;
  ComboTipoCampo.Enabled      := False;
  EdTamanhoCampo.Enabled      := False;
  ComboEdicaoCampo.Enabled    := False;
  EdMascaraCampo.Enabled      := False;
  EdTituloCampo.Enabled       := False;
  EdAjudaCampo.Enabled        := False;
  EdValorCampo.Enabled        := False;
  ComboValidacaoCampo.Enabled := False;
  EdValoresCampo.Enabled      := False;
  EdDescricaoCampo.Enabled    := False;
  BtnGravar.Enabled := False;
end;

procedure TFormCamposPredefinidos.ListaCamposDblClick(Sender: TObject);
begin
  BtnGravar.Enabled := True;
  EdNomeCampo.Enabled         := True;
  ComboTipoCampo.Enabled      := True;
  EdTamanhoCampo.Enabled      := True;
  ComboEdicaoCampo.Enabled    := True;
  EdMascaraCampo.Enabled      := True;
  EdTituloCampo.Enabled       := True;
  EdAjudaCampo.Enabled        := True;
  EdValorCampo.Enabled        := True;
  ComboValidacaoCampo.Enabled := True;
  EdValoresCampo.Enabled      := True;
  EdDescricaoCampo.Enabled    := True;
  EdNomeCampo.SetFocus;
end;

procedure TFormCamposPredefinidos.EdNomeCampoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;

end;

procedure TFormCamposPredefinidos.BtnGravarClick(Sender: TObject);
var Pos: Integer;
begin
  if Trim(EdNomeCampo.Text) = '' then
  begin
    Mensagem('Necessário informar NOME !!!',ModAdvertencia,[ModOk]);
    EdNomeCampo.SetFocus;
    Abort;
  end;
  Pos := ListaCampos.ItemIndex;
  FormPrincipal.Texto.Lines[LinhaCmp+1]  := '  Nome = '+ EdNomeCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+2]  := '  Tipo = '+ ComboTipoCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+3]  := '  Tamanho = '+ EdTamanhoCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+4]  := '  Edicao = '+ ComboEdicaoCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+5]  := '  Mascara = '+ EdMascaraCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+6]  := '  Titulo = '+ EdTituloCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+7]  := '  Ajuda = '+ EdAjudaCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+8]  := '  Padrao = '+ EdValorCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+9]  := '  Validacao = '+ ComboValidacaoCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+10] := '  Validos = '+ EdValoresCampo.Text;
  FormPrincipal.Texto.Lines[LinhaCmp+11] := '  Descricao = '+ EdDescricaoCampo.Text;
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.PastaGerador + 'Campos.Tpl');
  MontaListaCampos;

  EdNomeCampo.Enabled         := False;
  ComboTipoCampo.Enabled      := False;
  EdTamanhoCampo.Enabled      := False;
  ComboEdicaoCampo.Enabled    := False;
  EdMascaraCampo.Enabled      := False;
  EdTituloCampo.Enabled       := False;
  EdAjudaCampo.Enabled        := False;
  EdValorCampo.Enabled        := False;
  ComboValidacaoCampo.Enabled := False;
  EdValoresCampo.Enabled      := False;
  EdDescricaoCampo.Enabled    := False;
  BtnGravar.Enabled := False;
  ListaCampos.ItemIndex := Pos;
  ListaCamposClick(Self);
  ListaCampos.SetFocus;
end;

procedure TFormCamposPredefinidos.BtnDeletarCampoClick(Sender: TObject);
var I : Integer;
begin
  if ListaCampos.ItemIndex = -1 then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia, [ModOk]);
    abort;
  end;
  if Mensagem('Excluir Campo ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
     Abort;
  for I := 1 to 12 do
    FormPrincipal.Texto.Lines.Delete(LinhaCmp);
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.PastaGerador + 'Campos.Tpl');
  MontaListaCampos;
  ListaCampos.ItemIndex := 0;
  ListaCamposClick(Self);
  ListaCampos.SetFocus;
end;

procedure TFormCamposPredefinidos.BtnNovoCampoClick(Sender: TObject);
var prox_tab,I : Integer;
begin
  prox_tab := 0;
  for I := 0 to 999 do
    if NrCampos[I] <> '' then
      prox_tab := StrToInt(NrCampos[I]);
  FormPrincipal.Texto.Lines.Add('Numero '+StrZero(prox_tab+1,03));
  FormPrincipal.Texto.Lines.Add('  Nome = NovoCampo');
  FormPrincipal.Texto.Lines.Add('  Tipo = Alfanumérico');
  FormPrincipal.Texto.Lines.Add('  Tamanho = 1');
  FormPrincipal.Texto.Lines.Add('  Edicao = ');
  FormPrincipal.Texto.Lines.Add('  Mascara = ');
  FormPrincipal.Texto.Lines.Add('  Titulo = ');
  FormPrincipal.Texto.Lines.Add('  Ajuda = ');
  FormPrincipal.Texto.Lines.Add('  Padrao = ');
  FormPrincipal.Texto.Lines.Add('  Validacao = ');
  FormPrincipal.Texto.Lines.Add('  Validos = ');
  FormPrincipal.Texto.Lines.Add('  Descricao = ');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.PastaGerador + 'Campos.Tpl');
  MontaListaCampos;
  ListaCampos.ItemIndex := ListaCampos.Items.Count-1;
  ListaCamposClick(Self);
  ListaCamposDblClick(Self);
end;

procedure TFormCamposPredefinidos.EdMascaraCampoButtonClick(
  Sender: TObject);
Var
  Tamanho, I, qt_parcial, YI, TY, Maximo: Integer;
  rel_pict,rel_espelho,rel_xpict,xdecimal,rel_001,rel_002,Xrel_001: String;
  laco: Boolean;
begin
  Tamanho := StrToInt(Trim(EdTamanhoCampo.Text));
  FormListaEscolha := TFormListaEscolha.Create(Application);
  Try
    FormListaEscolha.ListaSelecao.Items.Clear;
    if Trim(ComboTipoCampo.Text) = 'Alfanumérico' then
    begin
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['X*'])+'Aceita todos carac. maiúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['x*'])+'Aceita todos carac. minúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['A*'])+'Somente letras em maiúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['a*'])+'Somente letras em minúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['9*'])+'Somente números (0 a 9)');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99:99:99'])+'HORA');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99999-999'])+'CEP');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['999.999.999-99'])+'CPF');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99.999.999/9999-99'])+'CNPJ');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['AAA-9999'])+'Placa de Veículo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['(Z999)Z999-9999'])+'Telefone');
    end
    else if Trim(ComboTipoCampo.Text) = 'Número Inteiro' then
    begin
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[ConstStr('9',Tamanho)])+'Zeros a esquerda visíveis');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[ConstStr('Z',Tamanho-1)+'9'])+'Zeros a esquerda não visíveis');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+ConstStr('9',Tamanho)])+'Zeros a esquerda visíveis');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+ConstStr('Z',Tamanho-1)+'9'])+'Zeros a esquerda não visíveis');
    end
    else if Trim(ComboTipoCampo.Text) = 'Número Fracionário' then
    begin
      if tamanho = 1 then
      begin
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['Z'])+'Fracionário positivo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-Z'])+'Fracionário negativo');
      end
      else if tamanho = 2 then
      begin
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['9,9'])+'Fracionário positivo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-9,9'])+'Fracionário negativo');
      end
      else
      begin
        for Ty := 1 to 2 do
        begin
          rel_xpict  :=ConstStr('Z',tamanho-2)+'99';
          rel_espelho:='';
          maximo     := 1;
          for I:=1 to tamanho do
            if (Length(Copy(rel_xpict,1,tamanho-I)) > 0) and
               (maximo <= 4) then
            begin
              inc(maximo);
              rel_espelho:=Copy(rel_xpict,1,tamanho-I)+','+Copy(rel_xpict,tamanho-I+1,255);
              laco := True;
              while laco do
                if Pos(',Z',rel_espelho) > 0 then
                  rel_espelho:=TrocaString(rel_espelho,',Z',',9',[rfReplaceAll])
                else
                  laco := False;
              xdecimal   :=Copy(rel_espelho,Pos(',',rel_espelho),255);
              xdecimal   :=TrocaString(xdecimal,'Z','9',[rfReplaceAll]);
              rel_espelho:=Copy(rel_espelho,01,Pos(',',rel_espelho)-1)+xdecimal;
              rel_002    :=Copy(rel_espelho,01,Pos(',',rel_espelho)-1);
              rel_001    :='';
              qt_parcial :=0;
              for YI:=Length(rel_002) downto 1 do
              begin
                rel_001 := rel_001 + Copy(rel_002,YI,01);
                Inc(qt_parcial);
                if qt_parcial = 3 then
                begin
                  rel_001    := rel_001 + '.';
                  qt_parcial := 0;
                end;
              end;
              Xrel_001 := '';
              for YI:=Length(rel_001) downto 1 do
                Xrel_001 := Xrel_001 + Copy(rel_001,YI,01);
              rel_001 := Xrel_001;
              if rel_001[1] = '.' then
                rel_001 := Copy(rel_001,02,255);
              if copy(rel_001,Length(rel_001),01) = 'Z' then
                rel_001 := copy(rel_001,01,Length(rel_001)-1) + '9';
              rel_espelho:=rel_001+xdecimal;
              if TY = 1 then
                FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[rel_espelho])+'Fracionário positivo')
              else
                FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+rel_espelho])+'Fracionário negativo');
            end;
        end;
      end;
    end
    else if Trim(ComboTipoCampo.Text) = 'Data' then
    begin
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99/99/9999'])+'Formato século ativo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99/99/99'])+'Formato século não ativo');
    end
    else if Trim(ComboTipoCampo.Text) = 'Memo' then
    begin
    end
    else if Trim(ComboTipoCampo.Text) = 'Imagem' then
    begin
    end;
    FormListaEscolha.ShowModal;
  Finally
    if FormListaEscolha.NumeroSelecao >= 0 then
      EdMascaraCampo.Text := Trim(Copy(FormListaEscolha.ListaSelecao.Items[FormListaEscolha.NumeroSelecao],01,20));
    FormListaEscolha.Free;
  end;
end;

procedure TFormCamposPredefinidos.EdValoresCampoButtonClick(
  Sender: TObject);
Var
  ListaValidos, ListaDescricao: TStringList;
  I: Integer;
begin
  ListaValidos  := TStringList.Create;
  ListaDescricao:= TStringList.Create;
  StringToArray(EdValoresCampo.Text,';',ListaValidos);
  StringToArray(EdDescricaoCampo.Text,';',ListaDescricao);
  FormVlValidos := TFormVlValidos.Create(Application);
  Try
    FormVlValidos.ListaSelecao.Items.Clear;
    FormVlValidos.TamanhoCmp := StrToInt(Trim(EdTamanhoCampo.Text));
    for I:=0 to ListaValidos.Count-1 do
    begin
      if I > ListaDescricao.Count-1 then
        ListaDescricao.Add(ListaValidos[I]);
      FormVlValidos.ListaSelecao.Items.Add(Format('%-'+Trim(EdTamanhoCampo.Text)+'s',[ListaValidos[I]])+ListaDescricao[I]);
    end;
    FormVlValidos.ShowModal;
  Finally
    if FormVlValidos.Atualizar then
    begin
      EdValoresCampo.Text   := '';
      EdDescricaoCampo.Text := '';
      for I:=0 to FormVlValidos.ListaSelecao.Items.Count-1 do
      begin
        EdValoresCampo.Text   := EdValoresCampo.Text + Copy(FormVlValidos.ListaSelecao.Items[I],01,FormVlValidos.TamanhoCmp) + ';';
        EdDescricaoCampo.Text := EdDescricaoCampo.Text + Copy(FormVlValidos.ListaSelecao.Items[I],FormVlValidos.TamanhoCmp+01,255) + ';';
      end;
      if Trim(EdValoresCampo.Text) <> '' then
      begin
        EdValoresCampo.Text   := Copy(EdValoresCampo.Text,01,Length(EdValoresCampo.Text)-1);
        EdDescricaoCampo.Text := Copy(EdDescricaoCampo.Text,01,Length(EdDescricaoCampo.Text)-1);
      end;
    end;
    FormVlValidos.Free;
    ListaValidos.Free;
    ListaDescricao.Free;
  end;
end;

procedure TFormCamposPredefinidos.BitBtn3Click(Sender: TObject);
begin
  ChamaAjuda;
end;

end.
