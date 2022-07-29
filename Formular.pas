unit Formular;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ExtDlgs, FileCtrl, Db, Grids, DBGrids,
  DBCtrls, Mask, XLookUp, IBQuery, XPMenu, ComCtrls, XBanner, ShellApi,
  IBCustomDataSet, IBDatabase, SynEdit;

type
  TFormFormularios = class(TForm)
    XBanner: TXBanner;
    DataSource: TDataSource;
    IBDatabase: TIBDatabase;
    IBTransaction: TIBTransaction;
    Panel1: TPanel;
    BtnFechar: TBitBtn;
    BthAjudaTabela: TBitBtn;
    XBanner1: TXBanner;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LbTabela: TLabel;
    LbForm: TLabel;
    BtnNovo: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnDefinir: TSpeedButton;
    Label4: TLabel;
    BtnImportar: TSpeedButton;
    Label5: TLabel;
    BtnCancelar: TBitBtn;
    EdNome: TDBEdit;
    ComboTipo: TDBComboBox;
    EdTitulo: TDBEdit;
    ComboTabela: TXDBLookUp;
    GridForm: TDBGrid;
    BtnConfirma: TBitBtn;
    EdLocalizar: TEdit;
    EdModelo: TDBComboBox;
    FileListBox1: TFileListBox;
    Texto_PAS: TSynEdit;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure EdNomeExit(Sender: TObject);
    procedure BtnConfirmaClick(Sender: TObject);
    procedure ComboTipoExit(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnDefinirClick(Sender: TObject);
    procedure EdNomeChange(Sender: TObject);
    procedure ComboTipoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure EdTituloExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdLocalizarChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BthAjudaTabelaClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
    procedure EdModeloExit(Sender: TObject);
  private
    { Private declarations }
    function ValidaNome(Nome: String; Importacao: Boolean): Boolean;
    procedure ListaModelos;
  public
    { Public declarations }
    Tipo: Integer;
  end;

var
  FormFormularios: TFormFormularios;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01, Abertura, Relator, ImpForm,
  Relator_ant, FDesigner;

procedure TFormFormularios.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormFormularios.FormShow(Sender: TObject);
var
  I, QtLinhas: Integer;
  Titulo: String;
begin
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
  if Tipo = 1 then
  begin
    TabGlobal_i.DFORMULARIO.Filtro := '(Tipo = 1) or (Tipo = 2) or (Tipo = 5) or (Tipo = 6)';
    Caption   := 'Definição de Formulários';
    ComboTipo.Items.Clear;
    ComboTipo.Items.Add('1'); ComboTipo.Items.Add('2');
    ComboTipo.Items.Add('5'); ComboTipo.Items.Add('6');
    TabSheet1.Caption := 'Formulários';
  end
  else
  begin
    TabGlobal_i.DFORMULARIO.Filtro := '(Tipo = 3) or (Tipo = 4) or (Tipo = 7)';
    Caption   := 'Definição de Relatórios e Gráficos';
    ComboTipo.Items.Clear;
    ComboTipo.Items.Add('3'); ComboTipo.Items.Add('4');
    ComboTipo.Items.Add('7');
    TabSheet1.Caption := 'Relatórios';
  end;
  TabGlobal_i.DFORMULARIO.ChaveIndice := 'nome';
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  TabGlobal_i.DTABELAS.AssociaChaveEstrangeira(ComboTabela, TabGlobal_i.DTABELAS.NUMERO.Nome,
                                  [TabGlobal_i.DTABELAS.NOME.Nome, TabGlobal_i.DTABELAS.TITULO_T.Nome]);
  DataSource.DataSet := TabGlobal_i.DFORMULARIO;
  TabGlobal_i.DFORMULARIO.First;
  if Trim(Projeto.Formulario_Ult) <> '' then
    if not TabGlobal_i.DFORMULARIO.Locate('Nome', Projeto.Formulario_Ult, [loCaseInsensitive, loPartialKey]) then
      TabGlobal_i.DFORMULARIO.First;
  LbForm.Caption    := '';
  GridForm.SetFocus;
  EdNomeChange(Self);
end;

procedure TFormFormularios.BtnEditarClick(Sender: TObject);
begin
  if TabGlobal_i.DFORMULARIO.Eof then exit;
  ListaModelos;
  TabGlobal_i.DFORMULARIO.Modifica;
  GridForm.Enabled   := False;
  EdTitulo.Enabled   := True;
  BtnNovo.Enabled    := False;
  BtnExcluir.Enabled := False;
  BtnEditar.Enabled  := False;
  BtnDefinir.Enabled := False;
  EdTitulo.SetFocus;
end;

procedure TFormFormularios.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormFormularios.ListaModelos;
var
  I, Y: Integer;
  SearchOptionsPd: TSynSearchOptions;
  NomeF: String;
  Ok: Boolean;
  MDI: Boolean;
begin
  MDI := False;
  EdModelo.Items.Clear;
  case TabGlobal_i.DFORMULARIO.Tipo.Conteudo of
    1: begin
         EdModelo.Items.Add('Modelo1');
         MDI := True;
       end;
    2: EdModelo.Items.Add('Modelo2');
    3: EdModelo.Items.Add('Modelo5');
    4: EdModelo.Items.Add('Modelo6');
    5: begin
         EdModelo.Items.Add('Modelo3');
         MDI := True;
       end;
    6: EdModelo.Items.Add('Modelo4');
    7: EdModelo.Items.Add('Modelo7');
  end;
  FileListBox1.ApplyFilePath(Projeto.PastaFontes);
  for I:=0 to FileListBox1.Items.Count-1 do
    if (FileExists(Projeto.PastaFontes + FileListBox1.Items[I])) and
       (FileExists(Projeto.PastaFontes + TrocaString(FileListBox1.Items[I], '.pas', '.dfm',[rfReplaceAll, rfIgnoreCase]))) then
    begin
      NomeF := TrocaString(FileListBox1.Items[I], '.pas', '',[rfReplaceAll, rfIgnoreCase]);
      Ok := True;
      for Y:=1 to 7 do
        if LowerCase(NomeF) = 'modelo'+IntToStr(Y) then
          Ok := False;
      if Ok then
      begin
        Texto_PAS.Lines.Clear;
        Texto_PAS.Lines.LoadFromFile(Projeto.PastaFontes + FileListBox1.Items[I]);
        Texto_PAS.CaretY := 0;
        Texto_PAS.CaretX := 0;
        Texto_PAS.SearchReplace('XMakerModelo','', SearchOptionsPd);
        if Texto_PAS.CaretY > 1 then
        begin
          Ok := True;
          Texto_PAS.Lines.Clear;
          Texto_PAS.Lines.LoadFromFile(Projeto.PastaFontes + TrocaString(FileListBox1.Items[I], '.pas', '.dfm',[rfReplaceAll, rfIgnoreCase]));
          Texto_PAS.CaretY := 0;
          Texto_PAS.CaretX := 0;
          Texto_PAS.SearchReplace('fsMDIChild','', SearchOptionsPd);
          if Texto_PAS.CaretY > 1 then
          begin
            if not MDI then
              Ok := False;
          end
          else
            if MDI then
              Ok := False;
          for Y:=0 to EdModelo.Items.Count-1 do
            if LowerCase(EdModelo.Items[Y]) = LowerCase(NomeF) then
              Ok := False;
          if Ok then
            EdModelo.Items.Add(NomeF);
        end;
        Texto_PAS.Lines.Clear;
      end;
    end;
  if EdModelo.Items.Count > 0 then
    EdModelo.ItemIndex := 0;
end;

procedure TFormFormularios.BtnNovoClick(Sender: TObject);
Var
  Seq, I: Integer;
begin
  EdModelo.Style := csDropDownList;
  LbForm.Caption      := 'Form';
  EdNome.Enabled      := True;
  ComboTipo.Enabled   := True;
  ComboTipo.Font.Color:= clWindowText;
  EdTitulo.Enabled    := True;
  ComboTabela.Enabled := True;
  EdModelo.Enabled    := True;
  BtnNovo.Enabled     := False;
  BtnExcluir.Enabled  := False;
  BtnEditar.Enabled   := False;
  BtnDefinir.Enabled  := False;
  GridForm.Enabled    := False;
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
  TabGlobal_i.DFORMULARIO.Filtro := '';
  TabGlobal_i.DFORMULARIO.ChaveIndice := 'numero';
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  TabGlobal_i.DFORMULARIO.Last;
  Seq := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo + 1;
  if Tipo = 1 then
    TabGlobal_i.DFORMULARIO.Filtro := '(Tipo = 1) or (Tipo = 2) or (Tipo = 5) or (Tipo = 6)'
  else
    TabGlobal_i.DFORMULARIO.Filtro := '(Tipo = 3) or (Tipo = 4) or (Tipo = 7)';
  if C_CRACK then
  begin
    Mensagem(MSG_CRACK,ModErro,[ModOk]);
    BtnCancelarClick(Self);
    exit;
  end;
  TabGlobal_i.DFORMULARIO.ChaveIndice := 'nome';
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  if FREDT then
  begin
    TabGlobal_i.DFORMULARIO.DisableControls;
    TabGlobal_i.DFORMULARIO.First;
    I := 0;
    while not TabGlobal_i.DFORMULARIO.eof do
    begin
      Inc(I);
      TabGlobal_i.DFORMULARIO.Next;
    end;
    TabGlobal_i.DFORMULARIO.EnableControls;
    if I > 11 then
    begin
      Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de 12 '+^M+'Formulários ...',modAdvertencia,[ModOk]);
      BtnCancelarClick(Self);
      exit;
    end;
  end;
  TabGlobal_i.DFORMULARIO.Last;
  TabGlobal_i.DFORMULARIO.Inclui(Nil);
  TabGlobal_i.DFORMULARIO.NUMERO.Conteudo := Seq;
  if Tipo = 1 then
    TabGlobal_i.DFORMULARIO.TIPO.Conteudo   := 1
  else
    TabGlobal_i.DFORMULARIO.TIPO.Conteudo   := 3;
  ListaModelos;
  EdNome.SetFocus;
end;

procedure TFormFormularios.BtnExcluirClick(Sender: TObject);
var I,Y : Integer;
begin
  if Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo) = '' then
    exit;
  if not TabGlobal_i.DFORMULARIO.PodeExcluir then
    exit;
  if Tipo = 1 then
  begin
    if Mensagem('Excluir Formulário ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
      exit;
  end
  else
  begin
    if Mensagem('Excluir Relatório ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
      exit;
  end;
  if FileExists(Projeto.Pasta + Trim(EdNome.Text) + '.PAS') then
    DeleteFile(Projeto.Pasta + Trim(EdNome.Text) + '.PAS');
  if FileExists(Projeto.Pasta + Trim(EdNome.Text) + '.DFM') then
    DeleteFile(Projeto.Pasta + Trim(EdNome.Text) + '.DFM');
  if FileExists(Projeto.Pasta + Trim(EdNome.Text) + '.TPL') then
    DeleteFile(Projeto.Pasta + Trim(EdNome.Text) + '.TPL');
  TabGlobal_i.DFORMULARIO.Exclui;
  GridForm.Refresh;
  GridForm.SetFocus;
end;

function TFormFormularios.ValidaNome(Nome: String; Importacao: Boolean): Boolean;
var Caracter,TipoChar : String;
    I: Integer;
    CharInvalido,JaExiste : Boolean;
    QueryP: TIBQuery;
begin
  Result := True;
  JaExiste := False;
  Nome := UpperCase(Copy(Nome,01,01)) + Copy(Nome,02,14);
  if TabGlobal_i.DFORMULARIO.State in dsEditModes then
    TabGlobal_i.DFORMULARIO.NOME.Conteudo := Nome;
  if Trim(Nome) = '' then
  begin
    Mensagem('Necessário informar NOME !!!',ModAdvertencia,[ModOk]);
    Result := False;
    exit;
  end;
  if (Pos(UpperCase(Nome)+'|',FormPrincipal.LNomesReservados1) > 0) or (UpperCase(Nome)+'.DPR' = UpperCase(ExtractFileName(Projeto.ArquivoProj))) then
  begin
    Mensagem('Nome Inválido !'+^M+^M+Nome+' ( Reservado ) ...',modErro,[modOk]);
    Result := False;
    exit;
  end;
  CharInvalido := False;
  for I := 1 to Length(Nome) do
  begin
    Caracter := UpperCase(Copy(Nome,I,01));
    if not ((Caracter[1] in ['A'..'Z']) or (Caracter[1] in ['0'..'9']) or
            (Caracter = '_')) then
    begin
      CharInvalido := True;
      tipoChar := Caracter;
    end;
  end;
  Caracter := UpperCase(Copy(Nome,1,01));
  if Caracter[1] in ['0'..'9'] then
  begin
    CharInvalido := True;
    tipoChar := Caracter;
  end;
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DFORMULARIO.DataBase;
  if not Importacao then
    QueryP.SQL.Text := 'Select Numero, Nome From Formulario where NUMERO <> '+IntToStr(TabGlobal_i.DFORMULARIO.NUMERO.Conteudo)+' AND UPPER(NOME) = '+#39+UpperCase(Nome)+#39
  else
    QueryP.SQL.Text := 'Select Numero, Nome From Formulario where UPPER(NOME) = '+#39+UpperCase(Nome)+#39;
  QueryP.Open;
  QueryP.First;
  JaExiste := not QueryP.Eof;
  QueryP.Close;
  QueryP.Free;
  if CharInvalido then
  begin
    Mensagem('Caracter Inválido no Nome: '+ #39 + TipoChar + #39,ModAdvertencia,[ModOk]);
    Result := False;
    Exit;
  end;
  if JaExiste then
  begin
    if Tipo = 1 then
      Mensagem('Formulário : "'+Nome+'" já cadastrado !',ModAdvertencia,[ModOk])
    else
      Mensagem('Relatório : "'+Nome+'" já cadastrado !',ModAdvertencia,[ModOk]);
    Result := False;
    Exit;
  end;
end;

procedure TFormFormularios.EdNomeExit(Sender: TObject);
begin
  if ActiveControl = BtnCancelar then exit;
  if not ValidaNome(EdNome.Text, False) then
  begin
    EdNome.SelectAll;
    EdNome.SetFocus;
    exit;
  end;
  ComboTipoExit(Self);
end;

procedure TFormFormularios.BtnConfirmaClick(Sender: TObject);
Var
  I,Atual,Y,At,NrIndex : Integer;
  Pesquisa: String;
begin
  EdModelo.Style := csSimple;
  if (not EdTitulo.Enabled) then
    Abort;
  if TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo = '' then
  begin
    Mensagem('Necessário informar TITULO !!!',ModAdvertencia,[ModOk]);
    EdTitulo.SetFocus;
    Abort;
  end;
  if ComboTipo.Text = '' then
  begin
    if Tipo = 1 then
      Mensagem('Necessário informar TIPO DE FORMULÁRIO !!!',ModAdvertencia,[ModOk])
    else
      Mensagem('Necessário informar TIPO DE RELATÓRIO !!!',ModAdvertencia,[ModOk]);
    ComboTipo.SetFocus;
    Abort;
  end;
  if (ComboTabela.Text = '') and
     (ComboTabela.Enabled) and (ComboTabela.Visible) then
  begin
    Mensagem('Necessário informar TABELA !!!',ModAdvertencia,[ModOk]);
    ComboTabela.SetFocus;
    Abort;
  end;
  EdNome.Enabled     := False;
  ComboTipo.Enabled  := False;
  ComboTipo.Font.Color:= clGrayText;
  EdTitulo.Enabled   := False;
  ComboTabela.Enabled:= False;
  EdModelo.Enabled   := False;
  BtnNovo.Enabled    := True;
  BtnExcluir.Enabled := True;
  BtnEditar.Enabled  := True;
  BtnDefinir.Enabled := True;
  Pesquisa           := EdNome.Text;
  TabGlobal_i.DFORMULARIO.MODELO.Conteudo := EdModelo.Text;
  TabGlobal_i.DFORMULARIO.Salva;
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  TabGlobal_i.DFORMULARIO.First;
  TabGlobal_i.DFORMULARIO.Locate('Nome', Pesquisa, [loCaseInsensitive, loPartialKey]);
  TabGlobal_i.DTABELAS.Filtro := 'Numero = ' + IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
  TabGlobal_i.DTABELAS.AtualizaSql;
  if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 1 then       // Entrada de Dados
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,1,True,EdModelo.Text)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 2 then  // Entrada de Dados Filho
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,2,True,EdModelo.Text)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 3 then  // Relatório
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,5,True,EdModelo.Text)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 4 then  // Gráfico
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,6,True,EdModelo.Text)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 5 then  // Avulso MDI
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,3,True,EdModelo.Text)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 6 then  // Avulso Normal
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,4,True,EdModelo.Text)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 7 then  // Etiqueta
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,7,True,EdModelo.Text);
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
  GridForm.Enabled  := True;
  GridForm.Refresh;
  GridForm.SetFocus;
end;

procedure TFormFormularios.ComboTipoExit(Sender: TObject);
begin
  if ActiveControl = BtnCancelar then exit;
  ListaModelos;
  if (ComboTipo.Text = '5') or
     (ComboTipo.Text = '6') then
  begin
    ComboTabela.Enabled := False
  end
  else
  begin
    if EdNome.Enabled then
      ComboTabela.Enabled := True;
  end;
end;

procedure TFormFormularios.BtnCancelarClick(Sender: TObject);
begin
  EdModelo.Style := csSimple;
  TabGlobal_i.DFORMULARIO.Cancela;
  EdNome.Enabled     := False;
  ComboTipo.Enabled  := False;
  ComboTipo.Font.Color:= clGrayText;
  EdTitulo.Enabled   := False;
  ComboTabela.Enabled:= False;
  EdModelo.Enabled   := False;
  GridForm.Enabled   := True;
  BtnNovo.Enabled    := True;
  BtnExcluir.Enabled := True;
  BtnEditar.Enabled  := True;
  BtnDefinir.Enabled := True;
  GridForm.Refresh;
  GridForm.SetFocus;
end;

procedure TFormFormularios.BtnDefinirClick(Sender: TObject);
begin
  if Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo) = '' then
    exit;
  Projeto.Formulario_Ult := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
  TabGlobal_i.DTABELAS.Filtro := 'Numero = ' + IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
  TabGlobal_i.DTABELAS.AtualizaSql;
  if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 1 then
  begin
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,1,False,EdModelo.Text);
    ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
    FormDesigner_Net.AbreForm(FormFormularios.EdNome.Text, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
    FormDesigner_Net.CurrentForm_Avulso.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
    FormDesigner_Net.CurrentForm_Avulso.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
    FormDesigner_Net.HabilitaBarraExtra;
    Close;
  end
  else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 2 then
  begin
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,2,False,EdModelo.Text);
    ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
    FormDesigner_Net.AbreForm(FormFormularios.EdNome.Text, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
    FormDesigner_Net.CurrentForm_Avulso.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
    FormDesigner_Net.CurrentForm_Avulso.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
    FormDesigner_Net.HabilitaBarraExtra;
    Close;
  end
  else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) or
          (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) or
          (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
  begin
    Gera_Modelo(Trim(EdNome.Text),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,5,False,EdModelo.Text);

    TabGlobal_i.DRELATORIO.Filtro := 'Numero = '+IntToStr(TabGlobal_i.DFORMULARIO.NUMERO.Conteudo)+' and Tipo = 1';
    TabGlobal_i.DRELATORIO.AtualizaSql;
    if TabGlobal_i.DRELATORIO.Eof then
    begin
      FormRelatorio := TFormRelatorio.Create(Application);
      Try
        if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) then
          FormRelatorio.Caption  := EdTitulo.Text + ' ( Relatório )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) then
          FormRelatorio.Caption  := EdTitulo.Text + ' ( Gráfico )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
          FormRelatorio.Caption  := EdTitulo.Text + ' ( Etiqueta )';
        FormRelatorio.NrFormulario := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo;
        FormRelatorio.NomeForm := EdNome.Text;
        FormRelatorio.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
        FormRelatorio.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
        FormRelatorio.Ed_Titulo.Text := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo;
        if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3 then
        begin
          FormRelatorio.Ed_Tipo.Text := 'Relatório';
          FormRelatorio.TipoRel := 1;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4 then
        begin
          FormRelatorio.Ed_Tipo.Text       := 'Gráfico';
          FormRelatorio.TipoRel := 2;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7 then
        begin
          FormRelatorio.Ed_Tipo.Text       := 'Etiqueta';
          FormRelatorio.TipoRel := 3;
        end;
        FormRelatorio.Ed_Formulario.Text   := 'Form'+EdNome.Text;
        FormRelatorio.Ed_TabPrincipal.Text := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' +TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
        FormRelatorio.NrTabela             := IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        FormRelatorio.ShowModal;
      Finally
        FormRelatorio.Free;
      end;
    end
    else
    begin
      FormRelatorio_Ant := TFormRelatorio_Ant.Create(Application);
      Try
        if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) then
          FormRelatorio_Ant.Caption  := EdTitulo.Text + ' ( Relatório )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) then
          FormRelatorio_Ant.Caption  := EdTitulo.Text + ' ( Gráfico )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
          FormRelatorio_Ant.Caption  := EdTitulo.Text + ' ( Etiqueta )';
        FormRelatorio_Ant.NrFormulario := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo;
        FormRelatorio_Ant.NomeForm := EdNome.Text;
        FormRelatorio_Ant.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
        FormRelatorio_Ant.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
        FormRelatorio_Ant.Ed_Titulo.Text := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo;
        if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3 then
        begin
          FormRelatorio_Ant.Ed_Tipo.Text := 'Relatório';
          FormRelatorio_Ant.TipoRel := 1;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4 then
        begin
          FormRelatorio_Ant.Ed_Tipo.Text       := 'Gráfico';
          FormRelatorio_Ant.TipoRel := 2;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7 then
        begin
          FormRelatorio_Ant.Ed_Tipo.Text       := 'Etiqueta';
          FormRelatorio_Ant.TipoRel := 3;
        end;
        FormRelatorio_Ant.Ed_Formulario.Text   := 'Form'+EdNome.Text;
        FormRelatorio_Ant.Ed_TabPrincipal.Text := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' +TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
        FormRelatorio_Ant.NrTabela             := IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        FormRelatorio_Ant.ShowModal;
      Finally
        FormRelatorio_Ant.Free;
      end;
    end;
  end
  else
  begin
    ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
    FormDesigner_Net.AbreForm(FormFormularios.EdNome.Text, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
    Close;
  end;
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
end;

procedure TFormFormularios.EdNomeChange(Sender: TObject);
begin
  LbForm.Caption := 'Form' + EdNome.Text;
end;

procedure TFormFormularios.ComboTipoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
    Validos: array[0..5] of string;
    Descricao: array[0..5] of string;
begin
  if Tipo = 1 then
  begin
    Validos[0] := '1'; Validos[1] := '2';
    Validos[2] := '5'; Validos[3] := '6';
    Descricao[0] := 'Entrada de Dados' ; Descricao[1] := 'Entrada de Dados Filho' ;
    Descricao[2] := 'Avulso MDI'       ; Descricao[3] := 'Avulso Normal' ;
  end
  else
  begin
    Validos[0] := '3'; Validos[1] := '4';
    Validos[2] := '7';
    Descricao[0] := 'Relatório' ; Descricao[1] := 'Gráfico';
    Descricao[2] := 'Etiqueta';
  end;
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if Descricao[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(Validos[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(Descricao[Index]));
end;

procedure TFormFormularios.EdTituloExit(Sender: TObject);
begin
  if ActiveControl = BtnCancelar then exit;
  if not EdModelo.Enabled then
    BtnConfirma.SetFocus;
end;

procedure TFormFormularios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if EdTitulo.Enabled then
  begin
    if Tipo = 1 then
      Mensagem('Formulário em Atualização !',ModInformacao,[modOk])
    else
      Mensagem('Relatório em Atualização !',ModInformacao,[modOk]);
    EdTitulo.SetFocus;
    Action := caNone;
    exit;
  end;
  TabGlobal_i.DFORMULARIO.Filtro := '';
  TabGlobal_i.DFORMULARIO.ChaveIndice := 'numero';
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  Gera_Dpr(True);
end;

procedure TFormFormularios.EdLocalizarChange(Sender: TObject);
begin
  TabGlobal_i.DFORMULARIO.Locate('Nome', EdLocalizar.Text, [loCaseInsensitive, loPartialKey]);
end;

procedure TFormFormularios.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    if BtnEditar.Enabled then
      BtnEditarClick(Self);
  end
  else if Key = VK_F11 then
  begin
    if BtnDefinir.Enabled then
      BtnDefinirClick(Self);
  end;
  if Key = VK_F5 then   // Calendário
    FormPrincipal.CalendarioClick(Self)
  else if Key = VK_F6 then // Calculadora
    FormPrincipal.CalculadoraClick(Self)
  else if Key = VK_F7 then // Diário
    FormPrincipal.DiarioProjetoClick(Self)
  else if Key = VK_F1 then // Agenda
    FormPrincipal.ConteudoClick(Self);
end;

procedure TFormFormularios.GridFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_INSERT then
    if BtnNovo.Enabled then
      BtnNovoClick(Self);
  if key = VK_DELETE then
    if BtnExcluir.Enabled then
      BtnExcluirClick(Self);
  if key = VK_F2 then
    if BtnEditar.Enabled then
      BtnEditarClick(Self);
end;

procedure TFormFormularios.BthAjudaTabelaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

procedure TFormFormularios.BtnImportarClick(Sender: TObject);
var
  xpasta, xnome, xtabela: String;
  I,Y, Seq, xnrtab: Integer;
  IBQuery1, IBQuery: TIBQuery;
begin
  xpasta := '';
  if not SelectDirectory('Selecione a Pasta', '', xpasta) then
    exit;
  xpasta := DiretorioCombarra(xpasta);
  if not fileexists(xpasta + 'Projeto.Pro') then
  begin
    Mensagem('Projeto não encontrado !',ModAdvertencia,[modOk]);
    exit;
  end;
  IBDatabase.DatabaseName := xpasta + 'Projeto.Pro';
  IBDatabase.Params.Clear;
  IBDatabase.Params.Add('USER_NAME='+Projeto.usr_firebird);
  IBDatabase.Params.Add('PASSWORD='+Projeto.pwd_firebird);
  IBDatabase.LoginPrompt := False;
  IBDatabase.Connected := True;
  if IBDatabase.TestConnected then
  begin
    IBQuery := TIBQuery.Create(Self);
    IBQuery.Database := IBDatabase;
    IBQuery.Transaction := IBTransaction;
    if Tipo = 1 then
      IBQuery.SQL.Text := 'Select * From Formulario Where Tipo = 1 or Tipo = 2 or Tipo = 5 or Tipo = 6 order By Nome'
    else
      IBQuery.SQL.Text := 'Select * From Formulario Where Tipo = 3 or Tipo = 4 or Tipo = 7 order By Nome';
    IBQuery.Open;
    IBQuery.First;
    FormImpForm := TFormImpForm.Create(Application);
    try
      FormImpForm.FieldsLB.Items.Clear;
      while not IBQuery.eof do
      begin
        FormImpForm.FieldsLB.Items.AddObject(IBQuery.FieldByName('NOME').AsString + ' - ' + IBQuery.FieldByName('TITULO_F').AsString,TObject(IBQuery.FieldByName('NUMERO').AsInteger));
        IBQuery.Next;
      end;
      IBQuery.Close;
      if Tipo = 1 then
        FormImpForm.Caption := 'Importação de Formulários'
      else
        FormImpForm.Caption := 'Importação de Relatórios';
      if FormImpForm.ShowModal = mrOk then
        for I:=0 to FormImpForm.FieldsLB.Items.Count-1 do
          if FormImpForm.FieldsLB.Checked[I] then
          begin
            IBQuery.SQL.Text := 'Select * From Formulario Where Numero = '+IntToStr(Integer(FormImpForm.FieldsLB.Items.Objects[I]));
            IBQuery.Open;
            if not IBQuery.eof then
            begin
               xnome := IBQuery.FieldByName('NOME').AsString;
               if ValidaNome(xnome, True) then
               begin
                 xnrtab := 0;
                 if (IBQuery.FieldByName('TIPO').AsInteger <> 5) and
                    (IBQuery.FieldByName('TIPO').AsInteger <> 6) then
                 begin
                   if FileExists(xpasta + xnome + '.Pas') then
                     FormPrincipal.Texto.Lines.LoadFromFile(xpasta + xnome + '.Pas');
                   for Y := 0 to FormPrincipal.texto.Lines.Count-1 do
                   begin
                     if Tipo = 1 then
                     begin
                       if Pos('  TabelaPrincipal    := TabGlobal.D',FormPrincipal.texto.Lines[Y]) > 0 then
                       begin
                         xtabela := FormPrincipal.texto.Lines[Y];
                         xtabela := Copy(xtabela,Pos('.',xtabela)+2,Length(xtabela));
                         xtabela := UpperCase(Trim(Copy(xtabela,01,Pos(';',xtabela)-1)));
                         Break;
                       end;
                     end
                     else
                     begin
                       if Pos('    DataBase := TabGlobal.D',FormPrincipal.texto.Lines[Y]) > 0 then
                       begin
                         xtabela := FormPrincipal.texto.Lines[Y];
                         xtabela := Copy(xtabela,Pos('.',xtabela)+2,Length(xtabela));
                         xtabela := UpperCase(Trim(Copy(xtabela,01,Pos('.',xtabela)-1)));
                         Break;
                       end
                       else if Pos('  QyRelatorio := D',FormPrincipal.texto.Lines[Y]) > 0 then
                       begin
                         xtabela := FormPrincipal.texto.Lines[Y];
                         xtabela := Trim(Copy(xtabela,Pos('=',xtabela)+1,Length(xtabela)-1));
                         xtabela := UpperCase(Trim(Copy(xtabela,02,Length(xtabela)-1)));
                         xtabela := Copy(xtabela,01,Length(xtabela)-1);
                         Break;
                       end;
                     end;
                   end;
                   FormPrincipal.Texto.Lines.Clear;
                   TabGlobal_i.DTABELAS.First;
                   xnrtab := -1;
                   while not TabGlobal_i.DTABELAS.Eof do
                   begin
                     if UpperCase(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)) = xtabela then
                     begin
                       xnrtab := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
                       Break;
                     end;
                     TabGlobal_i.DTABELAS.Next;
                   end;
                 end;
                 if xnrtab <> -1 then
                 begin
                   TabGlobal_i.DTABELAS.Filtro := '';
                   TabGlobal_i.DTABELAS.AtualizaSql;
                   TabGlobal_i.DFORMULARIO.Filtro := '';
                   TabGlobal_i.DFORMULARIO.ChaveIndice := 'numero';
                    TabGlobal_i.DFORMULARIO.AtualizaSql;
                   TabGlobal_i.DFORMULARIO.Last;
                   Seq := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo + 1;
                   if Tipo = 1 then
                     TabGlobal_i.DFORMULARIO.Filtro := '(Tipo = 1) or (Tipo = 2) or (Tipo = 5) or (Tipo = 6)'
                   else
                      TabGlobal_i.DFORMULARIO.Filtro := '(Tipo = 3) or (Tipo = 4) or (Tipo = 7)';
                   TabGlobal_i.DFORMULARIO.ChaveIndice := 'nome';
                   TabGlobal_i.DFORMULARIO.AtualizaSql;
                   TabGlobal_i.DFORMULARIO.Last;
                   TabGlobal_i.DFORMULARIO.Inclui(Nil);
                   TabGlobal_i.DFORMULARIO.NUMERO.Conteudo   := Seq;
                   TabGlobal_i.DFORMULARIO.NOME.Conteudo     := xnome;
                   TabGlobal_i.DFORMULARIO.TIPO.Conteudo     := IBQuery.FieldByName('TIPO').AsInteger;
                   TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo := IBQuery.FieldByName('TITULO_F').AsString;
                   TabGlobal_i.DFORMULARIO.TABELA.Conteudo   := xnrtab;
                   TabGlobal_i.DFORMULARIO.Salva;
                   if FileExists(xpasta + xnome + '.Pas') then
                     CopiaArquivo(xpasta + xnome + '.Pas', Projeto.Pasta + xnome + '.Pas');
                   if FileExists(xpasta + xnome + '.Dfm') then
                     CopiaArquivo(xpasta + xnome + '.Dfm', Projeto.Pasta + xnome + '.Dfm');
                   if Tipo = 2 then
                   begin
                     IBQuery1 := TIBQuery.Create(Self);
                     IBQuery1.Database := IBDatabase;
                     IBQuery1.Transaction := IBTransaction;
                     IBQuery1.SQL.Text := 'Select * From RELATORIO Where Numero = '+IBQuery.FieldByName('NUMERO').AsString;
                     IBQuery1.Open;
                     while not IBQuery1.eof do
                     begin
                       TabGlobal_i.DRELATORIO.Inclui(Nil);
                       TabGlobal_i.DRELATORIO.NUMERO.Conteudo    := Seq;
                       TabGlobal_i.DRELATORIO.TIPO.Conteudo      := IBQuery1.FieldByName('TIPO').AsInteger;
                       TabGlobal_i.DRELATORIO.SEQUENCIA.Conteudo := IBQuery1.FieldByName('SEQUENCIA').AsInteger;
                       TabGlobal_i.DRELATORIO.EXPRESSAO.Conteudo := IBQuery1.FieldByName('EXPRESSAO').AsString;
                       TBlobField(TabGlobal_i.DRELATORIO.FieldByName('ESPELHO_1')).AsString := TBlobField(IBQuery1.FieldByName('ESPELHO_1')).AsString;
                       TBlobField(TabGlobal_i.DRELATORIO.FieldByName('ESPELHO_2')).AsString := TBlobField(IBQuery1.FieldByName('ESPELHO_2')).AsString;
                       TabGlobal_i.DRELATORIO.Salva;
                       IBQuery1.Next;
                     end;
                     IBQuery1.Close;
                     IBQuery1.Free;
                   end;
                 end
                 else
                   Mensagem('Tabela : "'+xtabela+'" não está definida no projeto !',ModAdvertencia,[modOk]);
               end;
            end;
            IBQuery.Close;
            TabGlobal_i.DFORMULARIO.AtualizaSql;
          end;
      IBDatabase.Connected := False;
    finally
      IBQuery.Free;
      FormImpForm.Free;
    end;
  end;
end;

procedure TFormFormularios.EdModeloExit(Sender: TObject);
begin
  if ActiveControl = BtnCancelar then exit;
  BtnConfirma.SetFocus;
end;

end.
