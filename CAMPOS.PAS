unit Campos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, FileCtrl, Grids;

type
  TFormCampos = class(TForm)
    PagePrincipal: TPageControl;
    TabAcesso: TTabSheet;
    TabEdicao: TTabSheet;
    TabIndices: TTabSheet;
    Bevel1: TBevel;
    ListaTabelas: TListBox;
    BtnNova: TBitBtn;
    BtnImportarTabela: TBitBtn;
    BtnFechar: TBitBtn;
    BthAjudaTabela: TBitBtn;
    Bevel2: TBevel;
    Label2: TLabel;
    EdNome: TEdit;
    EdTitulo: TEdit;
    Label3: TLabel;
    EdBanco: TComboBox;
    Label4: TLabel;
    EdChave: TCheckBox;
    GrupoCampos: TGroupBox;
    ListaCampos: TListBox;
    BtnMoveParaBaixo: TSpeedButton;
    BtnMoveParaCima: TSpeedButton;
    BtnDeletarCampo: TSpeedButton;
    Label5: TLabel;
    EdNomeCampo: TEdit;
    Label6: TLabel;
    ComboTipoCampo: TComboBox;
    Label7: TLabel;
    EdTamanhoCampo: TMaskEdit;
    Label8: TLabel;
    ComboEdicaoCampo: TComboBox;
    Label9: TLabel;
    EdMascaraCampo: TEdit;
    Label10: TLabel;
    EdTituloCampo: TEdit;
    EdAjudaCampo: TEdit;
    Label11: TLabel;
    EdValorCampo: TEdit;
    Label12: TLabel;
    ComboValidacaoCampo: TComboBox;
    Label13: TLabel;
    EdValoresCampo: TEdit;
    Label14: TLabel;
    EdDescricaoCampo: TEdit;
    Label15: TLabel;
    BtnExcluir: TBitBtn;
    BtnImportar: TBitBtn;
    BtnRetornarTabela: TBitBtn;
    BtnAjudaCampos: TBitBtn;
    BtnGravarCampo: TBitBtn;
    BtnCancelarCampo: TBitBtn;
    BtnNovoCampo: TBitBtn;
    Bevel4: TBevel;
    GroupBox1: TGroupBox;
    GridIndices: TStringGrid;
    BtnMoveIndiceParaBaixo: TSpeedButton;
    BtnMoveIndiceParaCima: TSpeedButton;
    BtnNovoIndice: TBitBtn;
    BtnExcluirIndice: TSpeedButton;
    Campos: TGroupBox;
    ListaCamposEscolha: TListBox;
    Label1: TLabel;
    EdTituloIndice: TEdit;
    GroupBox2: TGroupBox;
    ListaChave: TListBox;
    BtnInserirChave: TSpeedButton;
    BtnExcluirChave: TSpeedButton;
    BtnGravarIndice: TBitBtn;
    BtnCancelarIndice: TBitBtn;
    BtnAjudaIndice: TBitBtn;
    BtnMoveChaveParaBaixo: TSpeedButton;
    BtnMoveChaveParaCima: TSpeedButton;
    OpenGDB: TOpenDialog;
    BtnBancoDados: TBitBtn;
    BtnGravar: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure ListaTabelasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListaTabelasDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListaTabelasMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure EdNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure ListaCamposDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure EdNomeCampoExit(Sender: TObject);
    procedure PagePrincipalChange(Sender: TObject);
    procedure BtnNovaClick(Sender: TObject);
    procedure ListaTabelasDblClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnRetornarTabelaClick(Sender: TObject);
    procedure ListaCamposClick(Sender: TObject);
    procedure ListaCamposDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnNovoCampoClick(Sender: TObject);
    procedure BtnDeletarCampoClick(Sender: TObject);
    procedure BtnGravarCampoClick(Sender: TObject);
    procedure BtnCancelarCampoClick(Sender: TObject);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure GridIndicesClick(Sender: TObject);
    procedure BtnMoveIndiceParaBaixoClick(Sender: TObject);
    procedure EdBancoExit(Sender: TObject);
    procedure BtnMoveIndiceParaCimaClick(Sender: TObject);
    procedure GridIndicesDblClick(Sender: TObject);
    procedure BtnNovoIndiceClick(Sender: TObject);
    procedure BtnExcluirIndiceClick(Sender: TObject);
    procedure BtnGravarIndiceClick(Sender: TObject);
    procedure BtnInserirChaveClick(Sender: TObject);
    procedure BtnExcluirChaveClick(Sender: TObject);
    procedure ListaChaveClick(Sender: TObject);
    procedure BtnMoveChaveParaBaixoClick(Sender: TObject);
    procedure BtnMoveChaveParaCimaClick(Sender: TObject);
    procedure BtnImportarTabelaClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
    procedure BtnBancoDadosClick(Sender: TObject);
    procedure EdTituloIndiceExit(Sender: TObject);
    procedure EdNomeExit(Sender: TObject);
    procedure EdTituloExit(Sender: TObject);
    procedure EdChaveExit(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure MontaListaTabelas;
    procedure MontaListaIndices;
    procedure AtualizaComboBanco;
    procedure MontaListaCampos;
    procedure GravarTabela;
  public
    { Public declarations }
  end;

var
  FormCampos: TFormCampos;
  NrTabelas : Array[0..999] of String;
  MtzNomes : Array[0..999] of String;
  LinhaTbl : Integer;
  LinhaCmp: Integer;
  NrCampos : Array[0..999] of String;

implementation

{$R *.DFM}

uses Rotinas, Princ, Selecao, BancoD;

procedure TFormCampos.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCampos.MontaListaIndices;
var I,Y,QtIndice : Integer;
    MtzTitIndice: Array[1..16] of String;
    MtzCmpIndice: Array[1..16] of String;
begin
  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  QtIndice := 0;
  for Y := 5 to 36 do
  begin
    if Copy(FormPrincipal.Texto2.Lines[I+Y],01,08) = '  Indice' then
      if Trim(Copy(FormPrincipal.Texto2.Lines[I+Y],Pos('=',FormPrincipal.Texto2.Lines[I+Y])+2,Length(FormPrincipal.Texto2.Lines[I+Y]))) <> '' then
      begin
        Inc(QtIndice);
        MtzTitIndice[QtIndice] := Trim(Copy(FormPrincipal.Texto2.Lines[I+Y],Pos('=',FormPrincipal.Texto2.Lines[I+Y])+2,Length(FormPrincipal.Texto2.Lines[I+Y])));
        MtzCmpIndice[QtIndice] := Trim(Copy(FormPrincipal.Texto2.Lines[I+Y+1],Pos('=',FormPrincipal.Texto2.Lines[I+Y+1])+2,Length(FormPrincipal.Texto2.Lines[I+Y+1])));
      end;
  end;
  GridIndices.RowCount := QtIndice + 1;
  if QtIndice > 0 then
    GridIndices.FixedRows:= 1;
  with GridIndices do
  begin
    for Y := 1 to QtIndice do
    begin
      Cells[00,Y] := Strzero(Y,02);
      Cells[01,Y] := MtzTitIndice[Y];
      Cells[02,Y] := MtzCmpIndice[Y];
    end;
  end;
end;

procedure TFormCampos.ListaTabelasClick(Sender: TObject);
var I : Integer;
begin
  AtualizaComboBanco;
  EdChave.Enabled     := True;
  EdNome.Enabled      := True;
  EdTitulo.Enabled    := True;
  EdBanco.Enabled     := True;
  ListaCampos.Enabled      := True;
  BtnMoveParaBaixo.Enabled := True;
  BtnMoveParaCima.Enabled  := True;
  BtnNovoCampo.Enabled     := True;
  BtnDeletarCampo.Enabled  := True;
  MontaListaCampos;

  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  LinhaTbl := I;

  EdNome.Text := Trim(Copy(FormPrincipal.Texto2.Lines[I+1],Pos('=',FormPrincipal.Texto2.Lines[I+1])+2,Length(FormPrincipal.Texto2.Lines[I+1])));
  EdTitulo.Text := Trim(Copy(FormPrincipal.Texto2.Lines[I+2],Pos('=',FormPrincipal.Texto2.Lines[I+2])+2,Length(FormPrincipal.Texto2.Lines[I+2])));
  EdBanco.ItemIndex := EdBanco.Items.IndexOf(Trim(Copy(FormPrincipal.Texto2.Lines[I+3],Pos('=',FormPrincipal.Texto2.Lines[I+3])+2,Length(FormPrincipal.Texto2.Lines[I+3]))));
  if Trim(Copy(FormPrincipal.Texto2.Lines[I+4],Pos('=',FormPrincipal.Texto2.Lines[I+4])+2,Length(FormPrincipal.Texto2.Lines[I+4]))) = 'Sim' then
    EdChave.Checked := True
  else
    EdChave.Checked := False;

  GridIndices.Enabled := True;
  BtnNovoIndice.Enabled := True;
  BtnExcluirIndice.Enabled := True;
  ListaCamposEscolha.Enabled := True;
  MontaListaIndices;
end;

procedure TFormCampos.FormShow(Sender: TObject);
var I : Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  if (FileExists(Projeto.Pasta + 'Tabelas.Bds')) then
    FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'Tabelas.Bds');
  DeleteFile(Projeto.Pasta+'Gravar\Tabelas.Tbl');
  for I := 0 to 999 do
    DeleteFile(Projeto.Pasta+'Gravar\Tbl'+Strzero(I,03)+'.Cmp');
  CopiaArquivosMascara(Projeto.Pasta,Projeto.Pasta+'Gravar\','*.Cmp');
  CopiaArquivo(Projeto.Pasta+'Tabelas.Tbl',Projeto.Pasta+'Gravar\Tabelas.Tbl');
  FormPrincipal.Texto2.Lines.Clear;
  if (FileExists(Projeto.Pasta + 'Tabelas.Tbl')) then
    FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  PagePrincipal.ActivePageIndex := 0;
  MontaListaTabelas;
  with GridIndices do
  begin
    Cells[01,00] := 'Título';
    Cells[02,00] := 'Campos';
    {for I := 1 to 16 do
      Cells[00,I] := Strzero(I,02);}
  end;
  ListaTabelas.ItemIndex := 0;
  if ListaTabelas.Items.Count > 0 then
    ListaTabelasClick(Self);
  ListaTabelas.SetFocus;
end;

procedure TFormCampos.MontaListaTabelas;
var
  QtLinhas,I, QtTbl: Integer;
  Titulo: String;
begin
  for I := 0 to 999 do
  begin
    NrTabelas[I] := '';
    MtzNomes[I]  := '';
  end;
  ListaTabelas.Items.Clear;
  I := 0;
  QtTbl := 0;
  QtLinhas := FormPrincipal.Texto2.Lines.Count-1;
  while I <= QtLinhas do
  begin
    if Copy(FormPrincipal.Texto2.Lines[I],01,06) = 'Numero' then
    begin
      Titulo := Copy(FormPrincipal.Texto2.Lines[I],08,03);
      Titulo := Titulo + ' - '+Trim(Copy(FormPrincipal.Texto2.Lines[I+1],Pos('=',FormPrincipal.Texto2.Lines[I+1])+2,Length(FormPrincipal.Texto2.Lines[I+1])));
      Titulo := Titulo + ' ( '+ Trim(Copy(FormPrincipal.Texto2.Lines[I+2],Pos('=',FormPrincipal.Texto2.Lines[I+2])+2,Length(FormPrincipal.Texto2.Lines[I+2])))+ ' )';
      ListaTabelas.Items.AddObject(Titulo, Pointer(QtTbl));
      NrTabelas[QtTbl] := Copy(FormPrincipal.Texto2.Lines[I],08,03);
      MtzNomes[QtTbl]  := Trim(Copy(FormPrincipal.Texto2.Lines[I+1],Pos('=',FormPrincipal.Texto2.Lines[I+1])+2,Length(FormPrincipal.Texto2.Lines[I+1])));
      Inc(QtTbl);
    end;
    I := I + 37;
  end;
end;

procedure TFormCampos.ListaTabelasDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  bitmap : tbitmap;
  offset : integer;
begin
  with (Control as TListBox).Canvas do begin
    FillRect(Rect);
    Offset := 2;
    Bitmap:=TBitmap.Create;
    if FormPrincipal.ListaImagem <> nil then
      FormPrincipal.ListaImagem.GetBitmap(25,Bitmap);
    try
       if Bitmap <> nil then begin
         BrushCopy(Bounds(Rect.Left + 2, Rect.Top, Bitmap.Width, Bitmap.Height),
                   Bitmap,
                   Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                   clSilver); {clNavy}
         Offset := Bitmap.width + 8;
       end;
       TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index])
    finally
       Bitmap.Free;
    end;
  end;
end;

procedure TFormCampos.ListaTabelasMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := 20;
end;

procedure TFormCampos.EdNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormCampos.ListaCamposDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  bitmap : tbitmap;
  offset : integer;
begin
  with (Control as TListBox).Canvas do begin
    FillRect(Rect);
    Offset := 2;
    Bitmap:=TBitmap.Create;
    if FormPrincipal.ListaImagem <> nil then
      FormPrincipal.ListaImagem.GetBitmap(25,Bitmap);
    try
       if Bitmap <> nil then begin
         BrushCopy(Bounds(Rect.Left + 2, Rect.Top, Bitmap.Width, Bitmap.Height),
                   Bitmap,
                   Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                   clSilver); {clNavy}
         Offset := Bitmap.width + 8;
       end;
       TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index])
    finally
       Bitmap.Free;
    end;
  end;
end;

procedure TFormCampos.EdNomeCampoExit(Sender: TObject);
begin
  {EdNomeCampo.Text := UpperCase(Copy(EdNomeCampo.Text,01,01)) + Copy(EdNomeCampo.Text,02,19);}
end;

procedure TFormCampos.PagePrincipalChange(Sender: TObject);
var QtLinhas,I : Integer;
begin
  if PagePrincipal.ActivePageIndex = 0 then
  begin
    EdChave.Enabled     := False;
    EdNome.Enabled      := False;
    EdTitulo.Enabled    := False;
    EdBanco.Enabled     := False;
    ListaCampos.Enabled      := False;
    BtnMoveParaBaixo.Enabled := False;
    BtnMoveParaCima.Enabled  := False;
    BtnNovoCampo.Enabled     := False;
    BtnDeletarCampo.Enabled  := False;
    ListaCampos.Items.Clear;
    ListaCamposEscolha.Items.Clear;
    ListaChave.Items.Clear;
    GridIndices.RowCount := 1;
    GridIndices.Enabled := False;
    BtnNovoIndice.Enabled := False;
    BtnExcluirIndice.Enabled := False;
    ListaCamposEscolha.Enabled := False;
    BtnGravarIndice.Enabled := False;
    EdTituloIndice.Enabled := False;
    EdTituloIndice.Text := '';
    ListaChave.Enabled := False;
    BtnMoveIndiceParaBaixo.Enabled := False;
    BtnMoveIndiceParaCima.Enabled  := False;
    BtnNovoIndice.Enabled          := False;
    BtnExcluirIndice.Enabled       := False;
    BtnInserirChave.Enabled        := False;
    BtnExcluirChave.Enabled        := False;
    BtnMoveChaveParaBaixo.Enabled  := False;
    BtnMoveChaveParaCima.Enabled   := False;
  end;
  if PagePrincipal.ActivePageIndex = 0 then
  begin
    MontaListaTabelas;
    ListaTabelas.ItemIndex := 0;
    if ListaTabelas.Items.Count > 0 then
      ListaTabelasClick(Self);
    ListaTabelas.SetFocus;
  end
  else if PagePrincipal.ActivePageIndex = 1 then
  begin
    I := EdBanco.ItemIndex;
    AtualizaComboBanco;
    EdBanco.ItemIndex := I;
  end;
end;

procedure TFormCampos.BtnNovaClick(Sender: TObject);
var prox_tab,I : Integer;
begin
  AtualizaComboBanco;
  EdChave.Enabled     := True;
  EdNome.Enabled      := True;
  EdTitulo.Enabled    := True;
  EdBanco.Enabled     := True;
  ListaCampos.Enabled      := True;
  BtnMoveParaBaixo.Enabled := True;
  BtnMoveParaCima.Enabled  := True;
  BtnNovoCampo.Enabled     := True;
  BtnDeletarCampo.Enabled  := True;
  PagePrincipal.ActivePageIndex := 1;
  GridIndices.Enabled := True;
  BtnNovoIndice.Enabled := True;
  BtnExcluirIndice.Enabled := True;
  ListaCamposEscolha.Enabled := True;

  prox_tab := 0;
  for I := 0 to 999 do
    if NrTabelas[I] <> '' then
      prox_tab := StrToInt(NrTabelas[I]);

  LinhaTbl := FormPrincipal.Texto2.Lines.Count-1;
  FormPrincipal.Texto2.Lines.Add('Numero '+ StrZero(prox_tab+1,03));
  FormPrincipal.Texto2.Lines.Add('  Nome =');
  FormPrincipal.Texto2.Lines.Add('  Titulo =');
  FormPrincipal.Texto2.Lines.Add('  Alias =');
  FormPrincipal.Texto2.Lines.Add('  Primario = Sim');
  for I := 0 to 15 do
  begin
    FormPrincipal.Texto2.Lines.Add('  Indice =');
    FormPrincipal.Texto2.Lines.Add('  Campos =');
  end;
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');

  MontaListaTabelas;
  ListaTabelas.ItemIndex := ListaTabelas.Items.Count - 1;
  MontaListaCampos;
  EdNome.Text := '';
  EdTitulo.Text := '';
  EdBanco.ItemIndex := 0;
  EdNome.SetFocus;
end;

procedure TFormCampos.AtualizaComboBanco;
var QtLinhas,I : Integer;
    PosAnt : Integer;
begin
  QtLinhas := FormPrincipal.Texto.Lines.Count-1;
  I := 0;
  PosAnt := EdBanco.ItemIndex;
  EdBanco.Items.Clear;
  while I <= QtLinhas do
  begin
    if Copy(FormPrincipal.Texto.Lines[I],01,04) = 'Nome' then
      EdBanco.Items.Add(Trim(Copy(FormPrincipal.Texto.Lines[I],Pos('e',FormPrincipal.Texto.Lines[I])+2,Length(FormPrincipal.Texto.Lines[I]))));
    I := I + 06;
  end;
  EdBanco.ItemIndex := PosAnt;
end;

procedure TFormCampos.ListaTabelasDblClick(Sender: TObject);
var I : Integer;
begin
  if ListaTabelas.ItemIndex = -1 then
    Abort;
  PagePrincipal.ActivePageIndex := 1;
  EdNome.SetFocus;
end;

procedure TFormCampos.GravarTabela;
var I : Integer;
    Achou: Boolean;
begin
  if Trim(EdNome.Text) = '' then
  begin
    Mensagem('Necessário informar NOME !!!',ModAdvertencia,[mbOk]);
    EdNome.SetFocus;
    Abort;
  end;
  Achou := False;
  for I := 0 to 999 do
    if (MtzNomes[I] = Trim(EdNome.Text)) and (I <> ListaTabelas.ItemIndex) then
      Achou := True;
  if Achou then
  begin
    Mensagem('Nome já cadastrado !!!',ModAdvertencia,[mbOk]);
    EdNome.SetFocus;
    Abort;
  end;
  FormPrincipal.Texto2.Lines[LinhaTbl+1] := '  Nome = '+ EdNome.Text;
  FormPrincipal.Texto2.Lines[LinhaTbl+2] := '  Titulo = '+EdTitulo.Text;
  FormPrincipal.Texto2.Lines[LinhaTbl+3] := '  Alias = '+EdBanco.Text;
  if EdChave.Checked then
    FormPrincipal.Texto2.Lines[LinhaTbl+4] := '  Primario = Sim'
  else
    FormPrincipal.Texto2.Lines[LinhaTbl+4] := '  Primario = Não';
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  {PagePrincipal.ActivePageIndex := 0;
  MontaListaTabelas;
  ListaTabelas.ItemIndex := 0;
  if ListaTabelas.Items.Count > 0 then
    ListaTabelasClick(Self);
  ListaTabelas.SetFocus;}
end;

procedure TFormCampos.BtnExcluirClick(Sender: TObject);
var I : Integer;
    NrTab: String;
    PosAt: Integer;
begin
  if ListaTabelas.ItemIndex = -1 then
  begin
    Mensagem('Tabela não selecionada !',ModAdvertencia, [mbOk]);
    abort;
  end;
  PosAt := ListaTabelas.ItemIndex;
  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  if Mensagem('Excluir Tabela ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
     Abort;
  for I := 1 to 37 do
    FormPrincipal.Texto2.Lines.Delete(LinhaTbl);
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  DeleteFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  MontaListaTabelas;
  ListaTabelas.ItemIndex := PosAt;
  ListaTabelasClick(Self);
end;

procedure TFormCampos.BtnRetornarTabelaClick(Sender: TObject);
begin
  {if (EdNome.Modified) or (EdTitulo.Modified) then
  begin
    if Mensagem('Gravar Dados da Tabela ?',ModConfirmacao,[ModSim, ModNao]) = mrYes then
      BtnGravarTabelaClick(Self);
  end;}
  PagePrincipal.ActivePageIndex := 0;
  MontaListaTabelas;
  ListaTabelas.ItemIndex := 0;
  ListaTabelas.SetFocus;
end;

procedure TFormCampos.ListaCamposClick(Sender: TObject);
var I : Integer;
begin
  BtnNovoCampo.Enabled    := True;
  BtnDeletarCampo.Enabled := True;
  BtnMoveParaCima.Enabled := True;
  BtnMoveParaBaixo.Enabled := True;
  if ListaCampos.ItemIndex = 0 then
    BtnMoveParaCima.Enabled := False
  else if ListaCampos.ItemIndex = ListaCampos.Items.Count-1 then
    BtnMoveParaBaixo.Enabled := False;
  if ListaCampos.Items.Count = 1 then
  begin
    BtnMoveParaCima.Enabled := False;
    BtnMoveParaBaixo.Enabled := False;
  end;
  I := ListaCampos.ItemIndex;
  I := 11 * I +  I;
  LinhaCmp := I;
  EdNomeCampo.Text              := Trim(Copy(FormPrincipal.Texto3.Lines[I+1],Pos('=',FormPrincipal.Texto3.Lines[I+1])+2,Length(FormPrincipal.Texto3.Lines[I+1])));
  ComboTipoCampo.ItemIndex      := ComboTipoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.Texto3.Lines[I+2],Pos('=',FormPrincipal.Texto3.Lines[I+2])+2,Length(FormPrincipal.Texto3.Lines[I+2]))));
  EdTamanhoCampo.Text           := Trim(Copy(FormPrincipal.Texto3.Lines[I+3],Pos('=',FormPrincipal.Texto3.Lines[I+3])+2,Length(FormPrincipal.Texto3.Lines[I+3])));
  ComboEdicaoCampo.ItemIndex    := ComboEdicaoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.Texto3.Lines[I+4],Pos('=',FormPrincipal.Texto3.Lines[I+4])+2,Length(FormPrincipal.Texto3.Lines[I+4]))));
  EdMascaraCampo.Text           := Trim(Copy(FormPrincipal.Texto3.Lines[I+5],Pos('=',FormPrincipal.Texto3.Lines[I+5])+2,Length(FormPrincipal.Texto3.Lines[I+5])));
  EdTituloCampo.Text            := Trim(Copy(FormPrincipal.Texto3.Lines[I+6],Pos('=',FormPrincipal.Texto3.Lines[I+6])+2,Length(FormPrincipal.Texto3.Lines[I+6])));
  EdAjudaCampo.Text             := Trim(Copy(FormPrincipal.Texto3.Lines[I+7],Pos('=',FormPrincipal.Texto3.Lines[I+7])+2,Length(FormPrincipal.Texto3.Lines[I+7])));
  EdValorCampo.Text             := Trim(Copy(FormPrincipal.Texto3.Lines[I+8],Pos('=',FormPrincipal.Texto3.Lines[I+8])+2,Length(FormPrincipal.Texto3.Lines[I+8])));
  ComboValidacaoCampo.ItemIndex := ComboValidacaoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.Texto3.Lines[I+9],Pos('=',FormPrincipal.Texto3.Lines[I+9])+2,Length(FormPrincipal.Texto3.Lines[I+9]))));
  EdValoresCampo.Text           := Trim(Copy(FormPrincipal.Texto3.Lines[I+10],Pos('=',FormPrincipal.Texto3.Lines[I+10])+2,Length(FormPrincipal.Texto3.Lines[I+10])));
  EdDescricaoCampo.Text         := Trim(Copy(FormPrincipal.Texto3.Lines[I+11],Pos('=',FormPrincipal.Texto3.Lines[I+11])+2,Length(FormPrincipal.Texto3.Lines[I+11])));

  EdNomeCampo.Enabled         := False;
  BtnImportar.Enabled         := False;
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
  BtnGravarCampo.Enabled      := False;
  BtnCancelarCampo.Enabled    := False;

end;

procedure TFormCampos.ListaCamposDblClick(Sender: TObject);
begin
  BtnGravarCampo.Enabled      := True;
  BtnCancelarCampo.Enabled    := True;
  EdNomeCampo.Enabled         := True;
  BtnImportar.Enabled         := True;
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
  BtnNovoCampo.Enabled        := False;
  BtnDeletarCampo.Enabled     := False;
  BtnMoveParaBaixo.Enabled    := False;
  BtnMoveParaCima.Enabled     := False;
  EdNomeCampo.SetFocus;
end;

procedure TFormCampos.MontaListaCampos;
var
  QtLinhas,I,QtTbl : Integer;
  Titulo: String;
  NrTab: String;
begin
  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  FormPrincipal.Texto3.Lines.Clear;
  if (FileExists(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp')) then
    FormPrincipal.Texto3.Lines.LoadFromFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  for I := 0 to 999 do
    NrCampos[I] := '';
  ListaCampos.Items.Clear;
  ListaCamposEscolha.Items.Clear;
  ListaChave.Items.Clear;
  GridIndices.RowCount := 1;
  I := 0;
  QtTbl := 0;
  QtLinhas := FormPrincipal.Texto3.Lines.Count-1;
  while I <= QtLinhas do
  begin
    if Copy(FormPrincipal.Texto3.Lines[I],01,06) = 'Numero' then
    begin
      Titulo := Trim(Copy(FormPrincipal.Texto3.Lines[I+1],Pos('=',FormPrincipal.Texto3.Lines[I+1])+2,Length(FormPrincipal.Texto3.Lines[I+1])));
      ListaCampos.Items.Add(Titulo);
      ListaCamposEscolha.Items.Add(Titulo);
      NrCampos[QtTbl] := Copy(FormPrincipal.Texto3.Lines[I],08,03);
      Inc(QtTbl);
    end;
    I := I + 12;
  end;
  EdNomeCampo.Text              := '';
  ComboTipoCampo.ItemIndex      := -1;
  EdTamanhoCampo.Text           := '';
  ComboEdicaoCampo.ItemIndex    := -1;
  EdMascaraCampo.Text           := '';
  EdTituloCampo.Text            := '';
  EdAjudaCampo.Text             := '';
  EdValorCampo.Text             := '';
  ComboValidacaoCampo.ItemIndex := -1;
  EdValoresCampo.Text           := '';
  EdDescricaoCampo.Text         := '';
end;

procedure TFormCampos.FormClose(Sender: TObject;
  var Action: TCloseAction);
var I: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
  FormPrincipal.Texto3.Lines.Clear;
  DeleteFile(Projeto.Pasta+'Gravar\Tabelas.Tbl');
  for I := 0 to 999 do
    DeleteFile(Projeto.Pasta+'Gravar\Tbl'+Strzero(I,03)+'.Cmp');
end;

procedure TFormCampos.BtnNovoCampoClick(Sender: TObject);
var prox_tab,I : Integer;
    NrTab : String;
begin
  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  prox_tab := 0;
  for I := 0 to 999 do
    if NrCampos[I] <> '' then
      prox_tab := StrToInt(NrCampos[I]);
  FormPrincipal.Texto3.Lines.Add('Numero '+StrZero(prox_tab+1,03));
  FormPrincipal.Texto3.Lines.Add('  Nome = NovoCampo');
  FormPrincipal.Texto3.Lines.Add('  Tipo = Alfanumérico');
  FormPrincipal.Texto3.Lines.Add('  Tamanho = 1');
  FormPrincipal.Texto3.Lines.Add('  Edicao = Edição Padrão ( Edit )');
  FormPrincipal.Texto3.Lines.Add('  Mascara = ');
  FormPrincipal.Texto3.Lines.Add('  Titulo = ');
  FormPrincipal.Texto3.Lines.Add('  Ajuda = ');
  FormPrincipal.Texto3.Lines.Add('  Padrao = ');
  FormPrincipal.Texto3.Lines.Add('  Validacao = ');
  FormPrincipal.Texto3.Lines.Add('  Validos = ');
  FormPrincipal.Texto3.Lines.Add('  Descricao = ');
  FormPrincipal.Texto3.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  MontaListaCampos;
  ListaCampos.ItemIndex := ListaCampos.Items.Count-1;
  ListaCamposClick(Self);
  ListaCamposDblClick(Self);
end;

procedure TFormCampos.BtnDeletarCampoClick(Sender: TObject);
var I : Integer;
    NrTab : String;
    PosAt : Integer;
begin
  PosAt := ListaTabelas.ItemIndex;
  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  if ListaCampos.ItemIndex = -1 then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia, [mbOk]);
    abort;
  end;
  if Mensagem('Excluir Campo ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
     Abort;
  for I := 1 to 12 do
    FormPrincipal.Texto3.Lines.Delete(LinhaCmp);
  FormPrincipal.Texto3.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  MontaListaCampos;
  ListaTabelas.ItemIndex := PosAt;
  ListaCamposClick(Self);
end;

procedure TFormCampos.BtnGravarCampoClick(Sender: TObject);
var NrTab,Caracter,TipoChar : String;
    I: Integer;
    CharInvalido : Boolean;
begin
  I := ListaTabelas.ItemIndex;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  if Trim(EdNomeCampo.Text) = '' then
  begin
    Mensagem('Necessário informar NOME !!!',ModAdvertencia,[mbOk]);
    EdNomeCampo.SetFocus;
    Abort;
  end;
  CharInvalido := False;
  for I := 1 to Length(EdNomeCampo.Text) do
  begin
    Caracter := UpperCase(Copy(EdNomeCampo.Text,I,01));
    if not ((Caracter[1] in ['A'..'Z']) or (Caracter[1] in ['0'..'9']) or
            (Caracter = '_')) then
    begin
      CharInvalido := True;
      tipoChar := Caracter;
    end;
  end;
  Caracter := UpperCase(Copy(EdNomeCampo.Text,1,01));
  if Caracter[1] in ['0'..'9'] then
  begin
    CharInvalido := True;
    tipoChar := Caracter;
  end;
  if CharInvalido then
  begin
    Mensagem('Caracter Inválido no Nome: '+ #39 + TipoChar + #39,ModAdvertencia,[mbOk]);
    EdNomeCampo.SetFocus;
    Abort;
  end;
  for I := 0 to ListaCampos.Items.Count-1 do
    if (UpperCase(ListaCampos.Items[I]) = UpperCase(EdNomeCampo.Text)) and
      (I <> ListaCampos.ItemIndex) then
      CharInvalido := True;
  if CharInvalido then
  begin
    Mensagem('Campo já existente !!!',ModAdvertencia,[mbOk]);
    EdNomeCampo.SetFocus;
    Abort;
  end;
  if Trim(ComboTipoCampo.Text) = '' then
  begin
    Mensagem('Necessário informar TIPO DE CAMPO!!!',ModAdvertencia,[mbOk]);
    ComboTipoCampo.SetFocus;
    Abort;
  end;
  if Trim(ComboEdicaoCampo.Text) = '' then
  begin
    Mensagem('Necessário informar TIPO DE EDIÇÃO !!!',ModAdvertencia,[mbOk]);
    ComboEdicaoCampo.SetFocus;
    Abort;
  end;
  FormPrincipal.Texto3.Lines[LinhaCmp+1]  := '  Nome = '+ EdNomeCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+2]  := '  Tipo = '+ ComboTipoCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+3]  := '  Tamanho = '+ EdTamanhoCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+4]  := '  Edicao = '+ ComboEdicaoCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+5]  := '  Mascara = '+ EdMascaraCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+6]  := '  Titulo = '+ EdTituloCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+7]  := '  Ajuda = '+ EdAjudaCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+8]  := '  Padrao = '+ EdValorCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+9]  := '  Validacao = '+ ComboValidacaoCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+10] := '  Validos = '+ EdValoresCampo.Text;
  FormPrincipal.Texto3.Lines[LinhaCmp+11] := '  Descricao = '+ EdDescricaoCampo.Text;
  FormPrincipal.Texto3.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  MontaListaCampos;

  EdNomeCampo.Enabled         := False;
  BtnImportar.Enabled         := False;
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
  BtnGravarCampo.Enabled      := False;
  BtnCancelarCampo.Enabled    := False;
  {ListaCampos.SetFocus;}
  BtnNovoCampo.Enabled := True;
  BtnNovoCampo.SetFocus;
end;

procedure TFormCampos.BtnCancelarCampoClick(Sender: TObject);
begin
  EdNomeCampo.Enabled         := False;
  BtnImportar.Enabled         := False;
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
  BtnGravarCampo.Enabled      := False;
  BtnCancelarCampo.Enabled    := False;
  ListaCampos.SetFocus;
  ListaCamposClick(Self);
end;

procedure TFormCampos.BtnMoveParaBaixoClick(Sender: TObject);
var I : Integer;
    NrTab : String;
    MtzRecortar: Array[1..22] of String;
    Proximo: Integer;
begin
  I := ListaTabelas.ItemIndex;
  Proximo := ListaCampos.ItemIndex ;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  if ListaCampos.ItemIndex = -1 then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia, [mbOk]);
    abort;
  end;
  for I := 1 to 11 do
    MtzRecortar[I] := FormPrincipal.Texto3.Lines[LinhaCmp+I];
  for I := 12 to 22 do
    MtzRecortar[I] := FormPrincipal.Texto3.Lines[LinhaCmp+I+1];
  FormPrincipal.Texto3.Lines[LinhaCmp+1]  := MtzRecortar[12];
  FormPrincipal.Texto3.Lines[LinhaCmp+2]  := MtzRecortar[13];
  FormPrincipal.Texto3.Lines[LinhaCmp+3]  := MtzRecortar[14];
  FormPrincipal.Texto3.Lines[LinhaCmp+4]  := MtzRecortar[15];
  FormPrincipal.Texto3.Lines[LinhaCmp+5]  := MtzRecortar[16];
  FormPrincipal.Texto3.Lines[LinhaCmp+6]  := MtzRecortar[17];
  FormPrincipal.Texto3.Lines[LinhaCmp+7]  := MtzRecortar[18];
  FormPrincipal.Texto3.Lines[LinhaCmp+8]  := MtzRecortar[19];
  FormPrincipal.Texto3.Lines[LinhaCmp+9]  := MtzRecortar[20];
  FormPrincipal.Texto3.Lines[LinhaCmp+10] := MtzRecortar[21];
  FormPrincipal.Texto3.Lines[LinhaCmp+11] := MtzRecortar[22];

  FormPrincipal.Texto3.Lines[LinhaCmp+12+1]  := MtzRecortar[1];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+2]  := MtzRecortar[2];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+3]  := MtzRecortar[3];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+4]  := MtzRecortar[4];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+5]  := MtzRecortar[5];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+6]  := MtzRecortar[6];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+7]  := MtzRecortar[7];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+8]  := MtzRecortar[8];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+9]  := MtzRecortar[9];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+10] := MtzRecortar[10];
  FormPrincipal.Texto3.Lines[LinhaCmp+12+11] := MtzRecortar[11];

  FormPrincipal.Texto3.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  MontaListaCampos;
  ListaCampos.SetFocus;
  ListaCampos.ItemIndex := Proximo + 1;
  ListaCamposClick(Self);
end;

procedure TFormCampos.BtnMoveParaCimaClick(Sender: TObject);
var I : Integer;
    NrTab : String;
    MtzRecortar: Array[1..22] of String;
    Proximo: Integer;
begin
  I := ListaTabelas.ItemIndex;
  Proximo := ListaCampos.ItemIndex ;
  I := 36 * I +  I;
  NrTab := Copy(FormPrincipal.Texto2.Lines[I],08,03);
  if ListaCampos.ItemIndex = -1 then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia, [mbOk]);
    abort;
  end;
  for I := 1 to 11 do
    MtzRecortar[I] := FormPrincipal.Texto3.Lines[LinhaCmp+I];
  for I := 12 to 22 do
    MtzRecortar[I] := FormPrincipal.Texto3.Lines[(LinhaCmp-12)+(I-11)];
  FormPrincipal.Texto3.Lines[LinhaCmp+1]  := MtzRecortar[12];
  FormPrincipal.Texto3.Lines[LinhaCmp+2]  := MtzRecortar[13];
  FormPrincipal.Texto3.Lines[LinhaCmp+3]  := MtzRecortar[14];
  FormPrincipal.Texto3.Lines[LinhaCmp+4]  := MtzRecortar[15];
  FormPrincipal.Texto3.Lines[LinhaCmp+5]  := MtzRecortar[16];
  FormPrincipal.Texto3.Lines[LinhaCmp+6]  := MtzRecortar[17];
  FormPrincipal.Texto3.Lines[LinhaCmp+7]  := MtzRecortar[18];
  FormPrincipal.Texto3.Lines[LinhaCmp+8]  := MtzRecortar[19];
  FormPrincipal.Texto3.Lines[LinhaCmp+9]  := MtzRecortar[20];
  FormPrincipal.Texto3.Lines[LinhaCmp+10] := MtzRecortar[21];
  FormPrincipal.Texto3.Lines[LinhaCmp+11] := MtzRecortar[22];

  FormPrincipal.Texto3.Lines[LinhaCmp-12+1]  := MtzRecortar[1];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+2]  := MtzRecortar[2];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+3]  := MtzRecortar[3];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+4]  := MtzRecortar[4];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+5]  := MtzRecortar[5];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+6]  := MtzRecortar[6];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+7]  := MtzRecortar[7];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+8]  := MtzRecortar[8];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+9]  := MtzRecortar[9];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+10] := MtzRecortar[10];
  FormPrincipal.Texto3.Lines[LinhaCmp-12+11] := MtzRecortar[11];

  FormPrincipal.Texto3.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tbl'+NrTab+'.Cmp');
  MontaListaCampos;
  ListaCampos.SetFocus;
  ListaCampos.ItemIndex := Proximo -1 ;
  ListaCamposClick(Self);
end;

procedure TFormCampos.GridIndicesClick(Sender: TObject);
var PosGrid,I : Integer;
    CmpChave, Forma_cmp: String;
begin
  PosGrid := 5;
  Case GridIndices.Row of
    1: PosGrid := PosGrid + 0;
    2: PosGrid := PosGrid + 2;
    3: PosGrid := PosGrid + 4;
    4: PosGrid := PosGrid + 6;
    5: PosGrid := PosGrid + 8;
    6: PosGrid := PosGrid + 10;
    7: PosGrid := PosGrid + 12;
    8: PosGrid := PosGrid + 14;
    9: PosGrid := PosGrid + 16;
    10: PosGrid := PosGrid + 18;
    11: PosGrid := PosGrid + 20;
    12: PosGrid := PosGrid + 22;
    13: PosGrid := PosGrid + 24;
    14: PosGrid := PosGrid + 26;
    15: PosGrid := PosGrid + 28;
    16: PosGrid := PosGrid + 30;
  end;
  EdTituloIndice.Text := Trim(Copy(FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid],Pos('=',FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid])+2,Length(FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid])));
  Inc(PosGrid);
  CmpChave := Trim(Copy(FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid],Pos('=',FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid])+2,Length(FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid])));
  ListaChave.Items.Clear;
  forma_cmp := '';
  for I := 1 to Length(CmpChave) do
  begin
    if Copy(CmpChave,I,1) = ';' then
    begin
      ListaChave.Items.Add(Forma_cmp);
      Forma_cmp := '';
    end
    else
      forma_cmp := forma_cmp + Copy(CmpChave,I,1);
  end;
  if Trim(forma_cmp) <> '' then
    ListaChave.Items.Add(Forma_cmp);
  BtnGravarIndice.Enabled:= False;
  BtnMoveIndiceParaBaixo.Enabled := True;
  BtnMoveIndiceParaCima.Enabled  := True;
  BtnNovoIndice.Enabled          := True;
  BtnExcluirIndice.Enabled       := True;
  BtnInserirChave.Enabled        := False;
  BtnExcluirChave.Enabled        := False;
  EdTituloIndice.Enabled         := False;
  BtnMoveChaveParaBaixo.Enabled  := False;
  BtnMoveChaveParaCima.Enabled   := False;
  if GridIndices.Row = 1 then
    BtnMoveIndiceParaCima.Enabled  := False
  else if GridIndices.Row = GridIndices.RowCount-1 then
    BtnMoveIndiceParaBaixo.Enabled  := False;
  if GridIndices.RowCount = 1 then
  begin
    BtnMoveIndiceParaBaixo.Enabled := False;
    BtnMoveIndiceParaCima.Enabled  := False;
  end;
end;

procedure TFormCampos.BtnMoveIndiceParaBaixoClick(Sender: TObject);
var MtzRecortar: Array[1..4] of String;
    PosGrid,I : Integer;
begin
  PosGrid := 5;
  Case GridIndices.Row of
    1: PosGrid := PosGrid + 0;
    2: PosGrid := PosGrid + 2;
    3: PosGrid := PosGrid + 4;
    4: PosGrid := PosGrid + 6;
    5: PosGrid := PosGrid + 8;
    6: PosGrid := PosGrid + 10;
    7: PosGrid := PosGrid + 12;
    8: PosGrid := PosGrid + 14;
    9: PosGrid := PosGrid + 16;
    10: PosGrid := PosGrid + 18;
    11: PosGrid := PosGrid + 20;
    12: PosGrid := PosGrid + 22;
    13: PosGrid := PosGrid + 24;
    14: PosGrid := PosGrid + 26;
    15: PosGrid := PosGrid + 28;
    16: PosGrid := PosGrid + 30;
  end;
  I := PosGrid;
  MtzRecortar[1] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];
  Inc(PosGrid);
  MtzRecortar[2] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];

  Inc(PosGrid);
  MtzRecortar[3] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];
  Inc(PosGrid);
  MtzRecortar[4] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];

  PosGrid := I;
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[3];
  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[4];

  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[1];
  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[2];
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  I := GridIndices.Row + 1;
  MontaListaIndices;
  GridIndices.Row := I;
end;

procedure TFormCampos.EdBancoExit(Sender: TObject);
begin
  if ListaCampos.Items.Count = 0 then
  begin
    GrupoCampos.SetFocus;
    BtnNovoCampo.SetFocus;
  end
  else
    ListaCampos.ItemIndex := 0;
  GravarTabela;
end;

procedure TFormCampos.BtnMoveIndiceParaCimaClick(Sender: TObject);
var MtzRecortar: Array[1..4] of String;
    PosGrid,I : Integer;
begin
  PosGrid := 5;
  Case GridIndices.Row of
    1: PosGrid := PosGrid + 0;
    2: PosGrid := PosGrid + 2;
    3: PosGrid := PosGrid + 4;
    4: PosGrid := PosGrid + 6;
    5: PosGrid := PosGrid + 8;
    6: PosGrid := PosGrid + 10;
    7: PosGrid := PosGrid + 12;
    8: PosGrid := PosGrid + 14;
    9: PosGrid := PosGrid + 16;
    10: PosGrid := PosGrid + 18;
    11: PosGrid := PosGrid + 20;
    12: PosGrid := PosGrid + 22;
    13: PosGrid := PosGrid + 24;
    14: PosGrid := PosGrid + 26;
    15: PosGrid := PosGrid + 28;
    16: PosGrid := PosGrid + 30;
  end;
  I := PosGrid;
  MtzRecortar[1] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];
  Inc(PosGrid);
  MtzRecortar[2] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];

  PosGrid := PosGrid - 3;
  MtzRecortar[3] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];
  Inc(PosGrid);
  MtzRecortar[4] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid];

  PosGrid := I;
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[3];
  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[4];

  PosGrid := PosGrid - 3;
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[1];
  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := MtzRecortar[2];
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  I := GridIndices.Row - 1;
  MontaListaIndices;
  GridIndices.Row := I;
end;

procedure TFormCampos.GridIndicesDblClick(Sender: TObject);
begin
  EdTituloIndice.Enabled := True;
  ListaChave.Enabled     := True;
  BtnGravarIndice.Enabled:= True;
  BtnInserirChave.Enabled:= True;
  BtnExcluirChave.Enabled:= True;
  EdTituloIndice.SetFocus;
end;

procedure TFormCampos.BtnNovoIndiceClick(Sender: TObject);
var PosGrid,Proximo: Integer;
begin
  proximo := GridIndices.RowCount - 1;
  proximo := proximo + 1;
  if proximo > 16 then
  begin
    Mensagem('Limite Máximo de índice por Tabela: 16',ModAdvertencia, [mbOk]);
    abort;
  end;
  PosGrid := 5;
  Case Proximo of
    1: PosGrid := PosGrid + 0;
    2: PosGrid := PosGrid + 2;
    3: PosGrid := PosGrid + 4;
    4: PosGrid := PosGrid + 6;
    5: PosGrid := PosGrid + 8;
    6: PosGrid := PosGrid + 10;
    7: PosGrid := PosGrid + 12;
    8: PosGrid := PosGrid + 14;
    9: PosGrid := PosGrid + 16;
    10: PosGrid := PosGrid + 18;
    11: PosGrid := PosGrid + 20;
    12: PosGrid := PosGrid + 22;
    13: PosGrid := PosGrid + 24;
    14: PosGrid := PosGrid + 26;
    15: PosGrid := PosGrid + 28;
    16: PosGrid := PosGrid + 30;
  end;
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := '  Indice = Novo índice';
  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := '  Campos =';
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  MontaListaIndices;
  GridIndices.Row := GridIndices.RowCount - 1;
  GridIndicesDblClick(Self);
end;

procedure TFormCampos.BtnExcluirIndiceClick(Sender: TObject);
var PosGrid,I: Integer;
begin
  if Mensagem('Excluir índice ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
     Abort;
  PosGrid := 5;
  Case GridIndices.Row of
    1: PosGrid := PosGrid + 0;
    2: PosGrid := PosGrid + 2;
    3: PosGrid := PosGrid + 4;
    4: PosGrid := PosGrid + 6;
    5: PosGrid := PosGrid + 8;
    6: PosGrid := PosGrid + 10;
    7: PosGrid := PosGrid + 12;
    8: PosGrid := PosGrid + 14;
    9: PosGrid := PosGrid + 16;
    10: PosGrid := PosGrid + 18;
    11: PosGrid := PosGrid + 20;
    12: PosGrid := PosGrid + 22;
    13: PosGrid := PosGrid + 24;
    14: PosGrid := PosGrid + 26;
    15: PosGrid := PosGrid + 28;
    16: PosGrid := PosGrid + 30;
  end;
  for I := GridIndices.Row - 1 to 15 do
  begin
    if I = 15 then
    begin
      FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := '  Indice =';
      Inc(PosGrid);
      FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := '  Campos =';
      Inc(PosGrid);
    end
    else
    begin
      FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid+2];
      Inc(PosGrid);
      FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid+2];
      Inc(PosGrid);
    end;
  end;
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  MontaListaIndices;
end;

procedure TFormCampos.BtnGravarIndiceClick(Sender: TObject);
var I,PosGrid : Integer;
    FormaChave: String;
begin
  PosGrid := 5;
  Case GridIndices.Row of
    1: PosGrid := PosGrid + 0;
    2: PosGrid := PosGrid + 2;
    3: PosGrid := PosGrid + 4;
    4: PosGrid := PosGrid + 6;
    5: PosGrid := PosGrid + 8;
    6: PosGrid := PosGrid + 10;
    7: PosGrid := PosGrid + 12;
    8: PosGrid := PosGrid + 14;
    9: PosGrid := PosGrid + 16;
    10: PosGrid := PosGrid + 18;
    11: PosGrid := PosGrid + 20;
    12: PosGrid := PosGrid + 22;
    13: PosGrid := PosGrid + 24;
    14: PosGrid := PosGrid + 26;
    15: PosGrid := PosGrid + 28;
    16: PosGrid := PosGrid + 30;
  end;
  FormaChave := '';
  for I := 0 to ListaChave.Items.Count - 1 do
    FormaChave := FormaChave + ListaChave.Items[I] + ';' ;
  if Copy(FormaChave,Length(FormaChave),01) = ';' then
    FormaChave := Copy(FormaChave,01,Length(FormaChave)-1);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := '  Indice = '+EdTituloIndice.Text;
  Inc(PosGrid);
  FormPrincipal.Texto2.Lines[LinhaTbl+PosGrid] := '  Campos = '+FormaChave;
  FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
  MontaListaIndices;
  GridIndicesClick(Self);
  GridIndices.SetFocus;
end;

procedure TFormCampos.BtnInserirChaveClick(Sender: TObject);
begin
  if ListaCamposEscolha.ItemIndex <> -1 then
    ListaChave.Items.Add(ListaCamposEscolha.Items[ListaCamposEscolha.ItemIndex]);
end;

procedure TFormCampos.BtnExcluirChaveClick(Sender: TObject);
var I: Integer;
begin
  if ListaChave.ItemIndex <> -1 then
  begin
    I := ListaCamposEscolha.ItemIndex;
    ListaChave.Items.Delete(ListaChave.ItemIndex);
    ListaChave.ItemIndex := I - 1;
  end;
end;

procedure TFormCampos.ListaChaveClick(Sender: TObject);
begin
  BtnMoveChaveParaBaixo.Enabled  := True;
  BtnMoveChaveParaCima.Enabled   := True;
  if ListaChave.ItemIndex = 0 then
    BtnMoveChaveParaCima.Enabled   := False
  else if ListaChave.ItemIndex = ListaChave.Items.Count-1 then
    BtnMoveChaveParaBaixo.Enabled  := False;
  if ListaChave.Items.Count <= 1 then
  begin
    BtnMoveChaveParaBaixo.Enabled  := False;
    BtnMoveChaveParaCima.Enabled   := False;
  end;
end;

procedure TFormCampos.BtnMoveChaveParaBaixoClick(Sender: TObject);
var Item1,Item2 : String;
begin
  Item1 := ListaChave.Items[ListaChave.ItemIndex];
  Item2 := ListaChave.Items[ListaChave.ItemIndex+1];
  ListaChave.Items[ListaChave.ItemIndex]   := Item2;
  ListaChave.Items[ListaChave.ItemIndex+1] := Item1;
  ListaChave.ItemIndex := ListaChave.ItemIndex + 1;
  ListaChaveClick(Self);
end;

procedure TFormCampos.BtnMoveChaveParaCimaClick(Sender: TObject);
var Item1,Item2 : String;
begin
  Item1 := ListaChave.Items[ListaChave.ItemIndex];
  Item2 := ListaChave.Items[ListaChave.ItemIndex-1];
  ListaChave.Items[ListaChave.ItemIndex]   := Item2;
  ListaChave.Items[ListaChave.ItemIndex-1] := Item1;
  ListaChave.ItemIndex := ListaChave.ItemIndex - 1;
  ListaChaveClick(Self);
end;

procedure TFormCampos.BtnImportarTabelaClick(Sender: TObject);
var prox_tab,I,QtLinhas, NrSel, Y: Integer;
    Titulo, NrLinhaSel: String;
begin
  OpenGDB.Filter := 'Arquivo de Estrutura de Tabelas ( *.TBL )|*.TBL';
  NrSel := -1;
  if OpenGDB.Execute then
  begin
    FormPrincipal.Texto4.Lines.LoadFromFile(OpenGDB.FileName);
    FormListaEscolha := TFormListaEscolha.Create(Application);
    Try
      FormListaEscolha.ListaSelecao.Items.Clear;
      I := 0;
      QtLinhas := FormPrincipal.Texto4.Lines.Count-1;
      while I <= QtLinhas do
      begin
       if Copy(FormPrincipal.Texto4.Lines[I],01,06) = 'Numero' then
       begin
         Titulo := Trim(Copy(FormPrincipal.Texto4.Lines[I+1],Pos('=',FormPrincipal.Texto4.Lines[I+1])+2,Length(FormPrincipal.Texto4.Lines[I+1])));
         Titulo := Titulo + ' ( '+ Trim(Copy(FormPrincipal.Texto4.Lines[I+2],Pos('=',FormPrincipal.Texto4.Lines[I+2])+2,Length(FormPrincipal.Texto4.Lines[I+2])))+ ' )';
         FormListaEscolha.ListaSelecao.Items.Add(Titulo);
       end;
       I := I + 37;
      end;
      FormListaEscolha.ShowModal;
    Finally
      NrSel := FormListaEscolha.NumeroSelecao;
      FormListaEscolha.Free;
    end;
    if NrSel <> -1 then
    begin
      I := NrSel;
      I := 36 * I +  I;
      Y := I;
      NrLinhaSel := Copy(FormPrincipal.Texto4.Lines[I],08,03);
      prox_tab := 0;
      for I := 0 to 999 do
        if NrTabelas[I] <> '' then
          prox_tab := StrToInt(NrTabelas[I]);
      LinhaTbl := FormPrincipal.Texto2.Lines.Count-1;
      FormPrincipal.Texto2.Lines.Add('Numero '+ StrZero(prox_tab+1,03));
      FormPrincipal.Texto2.Lines.Add('  Nome = '+Trim(Copy(FormPrincipal.Texto2.Lines[Y+1],Pos('=',FormPrincipal.Texto2.Lines[Y+1])+2,Length(FormPrincipal.Texto2.Lines[Y+1]))));
      FormPrincipal.Texto2.Lines.Add('  Titulo = '+Trim(Copy(FormPrincipal.Texto2.Lines[Y+2],Pos('=',FormPrincipal.Texto2.Lines[Y+2])+2,Length(FormPrincipal.Texto2.Lines[Y+2]))));
      FormPrincipal.Texto2.Lines.Add('  Alias = '+Trim(Copy(FormPrincipal.Texto2.Lines[Y+3],Pos('=',FormPrincipal.Texto2.Lines[Y+3])+2,Length(FormPrincipal.Texto2.Lines[Y+3]))));
      FormPrincipal.Texto2.Lines.Add('  Primario = '+Trim(Copy(FormPrincipal.Texto2.Lines[Y+4],Pos('=',FormPrincipal.Texto2.Lines[Y+4])+2,Length(FormPrincipal.Texto2.Lines[Y+4]))));
      for I := 0 to 31 do
      begin
        FormPrincipal.Texto2.Lines.Add(FormPrincipal.Texto2.Lines[Y+5+I]);
      end;
      FormPrincipal.Texto2.Lines.SaveToFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Tbl');
      MontaListaTabelas;
      CopiaArquivo(DiretorioComBarra(ExtractFilePath(OpenGDB.FileName)) + 'Tbl'+NrLinhaSel+'.Cmp',
                   Projeto.Pasta + 'Gravar\' + 'Tbl'+StrZero(prox_tab+1,03)+'.Cmp' );

    end;
    FormPrincipal.Texto4.Lines.Clear;
  end;
end;

procedure TFormCampos.BtnImportarClick(Sender: TObject);
var I,NrSel,QtLinhas: Integer;
    Titulo: String;
begin
  FormPrincipal.Texto4.Lines.LoadFromFile(Projeto.PastaGerador + 'Campos.Tpl');
  FormListaEscolha := TFormListaEscolha.Create(Application);
  Try
    FormListaEscolha.ListaSelecao.Items.Clear;
    I := 0;
    QtLinhas := FormPrincipal.Texto4.Lines.Count-1;
    while I <= QtLinhas do
    begin
     if Copy(FormPrincipal.Texto4.Lines[I],01,06) = 'Numero' then
     begin
       Titulo := Trim(Copy(FormPrincipal.Texto4.Lines[I+1],Pos('=',FormPrincipal.Texto4.Lines[I+1])+2,Length(FormPrincipal.Texto4.Lines[I+1])));
       Titulo := Titulo + ' ( '+ Trim(Copy(FormPrincipal.Texto4.Lines[I+2],Pos('=',FormPrincipal.Texto4.Lines[I+2])+2,Length(FormPrincipal.Texto4.Lines[I+2])))+ ' )';
       FormListaEscolha.ListaSelecao.Items.Add(Titulo);
     end;
     I := I + 12;
    end;
    FormListaEscolha.ShowModal;
  Finally
    NrSel := FormListaEscolha.NumeroSelecao;
    FormListaEscolha.Free;
  end;
  if NrSel <> -1 then
  begin
    I := NrSel;
    I := 11 * I +  I;
    EdNomeCampo.Text              := Trim(Copy(FormPrincipal.texto4.Lines[I+1],Pos('=',FormPrincipal.texto4.Lines[I+1])+2,Length(FormPrincipal.texto4.Lines[I+1])));
    ComboTipoCampo.ItemIndex      := ComboTipoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.texto4.Lines[I+2],Pos('=',FormPrincipal.texto4.Lines[I+2])+2,Length(FormPrincipal.texto4.Lines[I+2]))));
    EdTamanhoCampo.Text           := Trim(Copy(FormPrincipal.texto4.Lines[I+3],Pos('=',FormPrincipal.texto4.Lines[I+3])+2,Length(FormPrincipal.texto4.Lines[I+3])));
    ComboEdicaoCampo.ItemIndex    := ComboEdicaoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.texto4.Lines[I+4],Pos('=',FormPrincipal.texto4.Lines[I+4])+2,Length(FormPrincipal.texto4.Lines[I+4]))));
    EdMascaraCampo.Text           := Trim(Copy(FormPrincipal.texto4.Lines[I+5],Pos('=',FormPrincipal.texto4.Lines[I+5])+2,Length(FormPrincipal.texto4.Lines[I+5])));
    EdTituloCampo.Text            := Trim(Copy(FormPrincipal.texto4.Lines[I+6],Pos('=',FormPrincipal.texto4.Lines[I+6])+2,Length(FormPrincipal.texto4.Lines[I+6])));
    EdAjudaCampo.Text             := Trim(Copy(FormPrincipal.texto4.Lines[I+7],Pos('=',FormPrincipal.texto4.Lines[I+7])+2,Length(FormPrincipal.texto4.Lines[I+7])));
    EdValorCampo.Text             := Trim(Copy(FormPrincipal.texto4.Lines[I+8],Pos('=',FormPrincipal.texto4.Lines[I+8])+2,Length(FormPrincipal.texto4.Lines[I+8])));
    ComboValidacaoCampo.ItemIndex := ComboValidacaoCampo.Items.IndexOf(Trim(Copy(FormPrincipal.texto4.Lines[I+9],Pos('=',FormPrincipal.texto4.Lines[I+9])+2,Length(FormPrincipal.texto4.Lines[I+9]))));
    EdValoresCampo.Text           := Trim(Copy(FormPrincipal.texto4.Lines[I+10],Pos('=',FormPrincipal.texto4.Lines[I+10])+2,Length(FormPrincipal.texto4.Lines[I+10])));
    EdDescricaoCampo.Text         := Trim(Copy(FormPrincipal.texto4.Lines[I+11],Pos('=',FormPrincipal.texto4.Lines[I+11])+2,Length(FormPrincipal.texto4.Lines[I+11])));
  end;
  FormPrincipal.Texto4.Lines.Clear;
end;

procedure TFormCampos.BtnBancoDadosClick(Sender: TObject);
begin
  FormBancoDados := TFormBancoDados.Create(Application);
  Try
    FormBancoDados.ShowModal;
  Finally
    FormBancoDados.Free;
  end;
  FormPrincipal.Texto.Lines.Clear;
  if (FileExists(Projeto.Pasta + 'Gravar\' + 'Tabelas.Bds')) then
    FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'Gravar\' + 'Tabelas.Bds');
  AtualizaComboBanco;
  EdBanco.SetFocus;
end;

procedure TFormCampos.EdTituloIndiceExit(Sender: TObject);
begin
  ListaChave.ItemIndex := 0;
end;

procedure TFormCampos.EdNomeExit(Sender: TObject);
begin
  GravarTabela;
end;

procedure TFormCampos.EdTituloExit(Sender: TObject);
begin
  GravarTabela;
end;

procedure TFormCampos.EdChaveExit(Sender: TObject);
begin
  GravarTabela;
end;

procedure TFormCampos.BtnGravarClick(Sender: TObject);
var I: Integer;
begin
  DeleteFile(Projeto.Pasta+'Tabelas.Tbl');
  for I := 0 to 999 do
    DeleteFile(Projeto.Pasta+'Tbl'+Strzero(I,03)+'.Cmp');
  CopiaArquivosMascara(Projeto.Pasta+'Gravar\',Projeto.Pasta,'*.Cmp');
  CopiaArquivo(Projeto.Pasta+'Gravar\Tabelas.Tbl',Projeto.Pasta+'Tabelas.Tbl');
  Close;
end;

end.
