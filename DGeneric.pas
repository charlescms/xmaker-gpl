unit DGeneric;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, Buttons, IniFiles, ExtDlgs, ComCtrls, FileCtrl,
  jpeg, ToolEdit, XBanner, ShellApi, XDate;

type
  TFormDadosGenericos = class(TForm)
    OpenPictureIcone: TOpenPictureDialog;
    OpenPictureImagem: TOpenPictureDialog;
    XBanner: TXBanner;
    Panel1: TPanel;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    Panel2: TPanel;
    PageGenerico: TPageControl;
    TabPrincipal: TTabSheet;
    Label8: TLabel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    EdTitulo: TEdit;
    EdEmpresa: TEdit;
    EdAnalista1: TEdit;
    EdAnalista2: TEdit;
    EdVersao: TEdit;
    EdInicio: TXDateEdit;
    Panel4: TPanel;
    ImagemIcone: TImage;
    EdIcone: TComboEdit;
    PageControl: TPageControl;
    TabParametro: TTabSheet;
    Label10: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    EdSeculo: TCheckBox;
    EdSaida: TCheckBox;
    EdMultiplas: TCheckBox;
    EdHintBalao: TCheckBox;
    EdMenuXP: TCheckBox;
    EdAcesso: TCheckBox;
    Edit1: TEdit;
    EdSenha: TEdit;
    EdLinguagem: TComboBox;
    EdComboDriver: TComboBox;
    EdConexao: TComboBox;
    EdSelecionar: TCheckBox;
    EdMenuLateral: TCheckBox;
    EdBarraF: TCheckBox;
    EdBanner: TCheckBox;
    EdModelo: TComboBox;
    EdAcessoInterno: TCheckBox;
    TabRede: TTabSheet;
    GrupoRede: TGroupBox;
    Label16: TLabel;
    Label14: TLabel;
    EdServidor_Pro: TEdit;
    Ed_L_Projeto: TComboEdit;
    GroupBox2: TGroupBox;
    Label17: TLabel;
    EdDicionario: TCheckBox;
    Ed_L_Dicionario: TComboEdit;
    EdServidor_Dic: TEdit;
    TabApresentacao: TTabSheet;
    Label9: TLabel;
    ImagemVazia: TImage;
    Panel5: TPanel;
    ImageApresentacao: TImage;
    EdTelaApresentacao: TComboEdit;
    TabSheet1: TTabSheet;
    Label11: TLabel;
    Panel6: TPanel;
    ImagemFundo: TImage;
    EdAjustar: TCheckBox;
    EdImagemFundo: TComboEdit;
    XBanner1: TXBanner;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure EdIconeExit(Sender: TObject);
    procedure PageGenericoChange(Sender: TObject);
    procedure EdTelaApresentacaoExit(Sender: TObject);
    procedure EdImagemFundoExit(Sender: TObject);
    procedure EdAjustarClick(Sender: TObject);
    procedure EdServidorExit(Sender: TObject);
    procedure EdInicioExit(Sender: TObject);
    procedure Ed_L_DicionarioExit(Sender: TObject);
    procedure Ed_L_DicionarioButtonClick(Sender: TObject);
    procedure EdIconeButtonClick(Sender: TObject);
    procedure EdTelaApresentacaoButtonClick(Sender: TObject);
    procedure EdImagemFundoButtonClick(Sender: TObject);
    procedure EdTelaApresentacaoChange(Sender: TObject);
    procedure EdComboDriverExit(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure EdDicionarioExit(Sender: TObject);
    procedure EdAcessoExit(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Ed_L_ProjetoButtonClick(Sender: TObject);
  private
    { Private declarations }
    Dicionario_ini: String;
    Pasta_pro_ini: String;
    Dicionario_Hab_ini: Boolean;
    Servidor_Pro_ini, Servidor_Dic_ini: String;
    Base_Dados_ini: Integer;
    Conexao_ini: Integer;
  public
    { Public declarations }
  end;

var
  FormDadosGenericos: TFormDadosGenericos;
  IniFile : TIniFile;

implementation

{$R *.DFM}

uses Rotinas, Gera_01, Princ, ObjMenu, Abertura, BancoD, FrmCompile;

procedure TFormDadosGenericos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormDadosGenericos.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDadosGenericos.FormShow(Sender: TObject);
var
  Atr: String;
  I: Integer;
begin
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  if not Projeto.UsoemRede then
  begin
    EdServidor_Dic.Enabled := False;
    GrupoRede.Enabled := False;
    EdServidor_Dic.Color := clBtnFace;
    Ed_L_Projeto.Color   := clBtnFace;
    EdServidor_Pro.Color := clBtnFace;
  end;
  PageControl.ActivePageIndex := 0;
  TabGlobal_i.DPROJETO.First;
  if TabGlobal_i.DPROJETO.Eof then
  begin
    TabGlobal_i.DPROJETO.Inclui(Nil);
    TabGlobal_i.DPROJETO.NUMERO.Conteudo              := 1;
    TabGlobal_i.DPROJETO.INICIO.Conteudo              := Date;
    TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo := 1;
    TabGlobal_i.DPROJETO.CONTROLEACESSO.Conteudo      := 1;
    TabGlobal_i.DPROJETO.CONTROLE_ACESSO_INTERNO.Conteudo := 1;
    TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo           := 1;
    TabGlobal_i.DPROJETO.BDADOS.Conteudo              := 2;
    TabGlobal_i.DPROJETO.CONFIRMASAIDA.Conteudo       := 1;
    TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo           := 1;
    TabGlobal_i.DPROJETO.MENUXP.Conteudo              := 1;
    TabGlobal_i.DPROJETO.MODELO.Conteudo              := 0;
    TabGlobal_i.DPROJETO.Salva;
  end;
  TabGlobal_i.DPROJETO.First;
  PageGenerico.ActivePageIndex := 0;
  EdTitulo.Text    := TabGlobal_i.DPROJETO.TITULO_P.Conteudo;
  EdEmpresa.Text   := TabGlobal_i.DPROJETO.EMPRESA.Conteudo;
  EdAnalista1.Text := TabGlobal_i.DPROJETO.ANALISTA.Conteudo;
  EdAnalista2.Text := TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo;
  EdVersao.Text    := TabGlobal_i.DPROJETO.VERSAO_P.Conteudo;
  EdInicio.DateValue := TabGlobal_i.DPROJETO.INICIO.Conteudo;
  //if TabGlobal_i.DPROJETO.INICIO.Conteudo < StrToDate('01/01/2000') then
  //  EdInicio.Text  := DateToStr(Date)
  //else
  //  EdInicio.Text  := DateToStr(TabGlobal_i.DPROJETO.INICIO.Conteudo);
  EdModelo.Items.Clear;
  if FileExists(Projeto.PastaGerador + 'Modelos.Lst') then
    EdModelo.Items.LoadFromFile(Projeto.PastaGerador + 'Modelos.Lst');
  for I:=0 to EdModelo.Items.Count-1 do
    if Pos('~~', EdModelo.Items[I]) > 0 then
       EdModelo.Items[I] := Copy(EdModelo.Items[I], 01, Pos('~~', EdModelo.Items[I])-1);
  if EdModelo.Items.Count = 0 then
    EdModelo.Items.Add('Padrão X-Maker')
  else
    EdModelo.Items.Insert(0, 'Padrão X-Maker');
  if TabGlobal_i.DPROJETO.MODELO.Conteudo <= EdModelo.Items.Count-1 then
    EdModelo.ItemIndex := TabGlobal_i.DPROJETO.MODELO.Conteudo
  else
    EdModelo.ItemIndex := 0;  
  EdIcone.Text     := TabGlobal_i.DPROJETO.ICONE.Conteudo;
  EdTelaApresentacao.Text := TabGlobal_i.DPROJETO.APRESENTACAO.Conteudo;
  if TabGlobal_i.DPROJETO.AJUSTAR.Conteudo = 1 then
    EdAjustar.Checked := True
  else
    EdAjustar.Checked := False;
  ImagemFundo.Stretch := EdAjustar.Checked;
  EdImagemFundo.Text  := TabGlobal_i.DPROJETO.FUNDO.Conteudo;
  if TabGlobal_i.DPROJETO.FORMATODATA.Conteudo = 1 then
    EdSeculo.Checked := True
  else
    EdSeculo.Checked := False;
  if TabGlobal_i.DPROJETO.CONFIRMASAIDA.Conteudo = 1 then
    EdSaida.Checked  := True
  else
    EdSaida.Checked  := False;
  if TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo = 0 then
    EdMultiplas.Checked := False
  else
    EdMultiplas.Checked := True;
  if TabGlobal_i.DPROJETO.HINTBALAO.Conteudo = 1 then
    EdHintBalao.Checked := True
  else
    EdHintBalao.Checked := False;
  if TabGlobal_i.DPROJETO.MENUXP.Conteudo = 1 then
    EdMenuXP.Checked := True
  else
    EdMenuXP.Checked := False;
  if TabGlobal_i.DPROJETO.CONTROLEACESSO.Conteudo = 0 then
    EdAcesso.Checked     := False
  else
    EdAcesso.Checked     := True;
  if TabGlobal_i.DPROJETO.CONTROLE_ACESSO_INTERNO.Conteudo = 0 then
    EdAcessoInterno.Checked  := False
  else
    EdAcessoInterno.Checked  := True;
  if TabGlobal_i.DPROJETO.SELECIONAR_EMP.Conteudo = 0 then
    EdSelecionar.Checked     := False
  else
    EdSelecionar.Checked     := True;
  Atr := StrZero(TabGlobal_i.DPROJETO.DEIXAR_NA_SENHA.Conteudo,03);
  if Atr[1] = '0' then
    EdMenuLateral.Checked     := False
  else
    EdMenuLateral.Checked     := True;
  if Atr[2] = '0' then
    EdBarraF.Checked     := False
  else
    EdBarraF.Checked     := True;
  if Atr[3] = '0' then
    EdBanner.Checked     := False
  else
    EdBanner.Checked     := True;
  EdSenha.Text           := TabGlobal_i.DPROJETO.SENHA.Conteudo;
  if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo > 0 then
    EdLinguagem.ItemIndex  := TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo - 1
  else
    EdLinguagem.ItemIndex  := 0;
  if TabGlobal_i.DPROJETO.BDADOS.Conteudo > 0 then
    EdComboDriver.ItemIndex:= TabGlobal_i.DPROJETO.BDADOS.Conteudo - 1
  else
    EdComboDriver.ItemIndex:= 1;
  EdComboDriverExit(Self);
  if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo > EdConexao.Items.Count then
    EdConexao.ItemIndex := 0
  else
    EdConexao.ItemIndex := TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo-1;
  Base_Dados_ini := EdComboDriver.ItemIndex;
  Conexao_ini := TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo-1;
  if Projeto.Dicionario_Hab then
    EdDicionario.Checked  := True
  else
    EdDicionario.Checked  := False;
  Ed_L_Dicionario.Text := Projeto.Dicionario;
  Ed_L_Projeto.Text    := Projeto.Pasta_projeto;
  EdServidor_Pro.Text  := Projeto.Servidor_Pro;
  EdServidor_Dic.Text  := Projeto.Servidor_Dic;

  if FileExists(Projeto.Pasta + 'Imagens\' + EdIcone.Text) then
    ImagemIcone.Picture.LoadFromFile(Projeto.Pasta + 'Imagens\' + EdIcone.Text);
  if FileExists(Projeto.Pasta + 'Imagens\' + EdTelaApresentacao.Text) then
    ImageApresentacao.Picture.LoadFromFile(Projeto.Pasta + 'Imagens\' + EdTelaApresentacao.Text);
  if FileExists(Projeto.Pasta + 'Imagens\' + EdImagemFundo.Text) then
    ImagemFundo.Picture.LoadFromFile(Projeto.Pasta + 'Imagens\' + EdImagemFundo.Text);
  Dicionario_ini := Ed_L_Dicionario.Text;
  Pasta_pro_ini := Ed_L_Projeto.Text;
  Servidor_Pro_ini := EdServidor_Pro.Text;
  Servidor_Dic_ini := EdServidor_Dic.Text;
  Dicionario_Hab_ini := EdDicionario.Checked;
  EdDicionarioExit(Self);
  EdAcessoExit(Self);
  EdTitulo.SelectAll;
  EdTitulo.SetFocus;
end;

procedure TFormDadosGenericos.BtnGravarClick(Sender: TObject);
var
   Caracter, NProj: String;
   I,PosAt: Integer;
   CharInvalido : Boolean;
   Atr: String;
begin
  if C_CRACK then
  begin
    Mensagem(MSG_CRACK,ModErro,[ModOk]);
    exit;
  end;
  if not DataValida(EdInicio.Text) then
  begin
    Mensagem('Data Inválida !',modErro,[modOk]);
    EdInicio.SelectAll;
    EdInicio.SetFocus;
    exit;
  end;
  CharInvalido := False;
  if Trim(EdIcone.Text) <> '' then
  begin
    for I := 1 to Length(Trim(EdIcone.Text)) do
    begin
      Caracter := UpperCase(Copy(EdIcone.Text,I,01));
      if Caracter = ' ' then
        CharInvalido := True;
    end;
  end;
  if CharInvalido then
  begin
    PageGenerico.ActivePageIndex := 0;
    Mensagem('Nome do arquivo não pode conter espaço(s) !',ModAdvertencia,[ModOk]);
    EdIcone.SetFocus;
    exit;
  end;
  if Trim(EdConexao.Text) = '' then
  begin
    Mensagem('Necessário informar o componente de conexão !',ModAdvertencia,[ModOk]);
    EdConexao.SetFocus;
    exit;
  end;
  {if (EdComboDriver.ItemIndex = 2) and (EdLinguagem.ItemIndex = 0) then
  begin
    Mensagem('O acesso ao MySql não está disponível na versão 5.0 do Delphi !',ModAdvertencia,[ModOk]);
    EdComboDriver.ItemIndex := 1;
    EdComboDriver.SetFocus;
    exit;
  end;}
  if (EdDicionario.Checked) and (Trim(Ed_L_Dicionario.Text) = '') then
  begin
    PageGenerico.ActivePageIndex := 0;
    Mensagem('Necessário informar Pasta do Dicionário !',ModAdvertencia,[ModOk]);
    PageControl.ActivePageIndex := 1;
    Ed_L_Dicionario.SetFocus;
    exit;
  end;
  if (EdTelaApresentacao.Text = '') then
    ImageApresentacao.Picture := ImagemVazia.Picture;
  if (EdImagemFundo.Text = '') then
    ImagemFundo.Picture := ImagemVazia.Picture;
  Screen.Cursor := crHourGlass;
  IniFile := TInifile.Create(Projeto.Nome);
  if EdDicionario.Checked then
  begin
    Ed_L_Dicionario.Text := DiretorioComBarra(Ed_L_Dicionario.Text);
    IniFile.WriteString('PROJETO', 'Dicionario', '1');
    IniFile.WriteString('PROJETO', 'Localizacao', Ed_L_Dicionario.Text);
    Projeto.Dicionario := Ed_L_Dicionario.Text;
  end
  else
  begin
    IniFile.WriteString('PROJETO', 'Dicionario', '0');
    IniFile.WriteString('PROJETO', 'Localizacao', '');
    Projeto.Dicionario:= Projeto.Pasta;
  end;
  if Trim(Ed_L_Projeto.Text) <> '' then
    Ed_L_Projeto.Text := DiretorioComBarra(Ed_L_Projeto.Text);
  IniFile.WriteString('PROJETO', 'Pasta_Pro', Trim(Ed_L_Projeto.Text));
  IniFile.WriteString('PROJETO', 'Servidor_Pro', Trim(EdServidor_Pro.Text));
  IniFile.WriteString('PROJETO', 'Servidor_Dic', Trim(EdServidor_Dic.Text));
  Projeto.Servidor_Pro := Trim(EdServidor_Pro.Text);
  Projeto.Servidor_Dic := Trim(EdServidor_Dic.Text);
  IniFile.Free;

  TabGlobal_i.DPROJETO.Modifica;
  TabGlobal_i.DPROJETO.TITULO_P.Conteudo            := EdTitulo.Text;
  TabGlobal_i.DPROJETO.EMPRESA.Conteudo             := EdEmpresa.Text;
  TabGlobal_i.DPROJETO.ANALISTA.Conteudo            := EdAnalista1.Text;
  TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo         := EdAnalista2.Text;
  TabGlobal_i.DPROJETO.VERSAO_P.Conteudo            := EdVersao.Text;
  //if DataValida(EdInicio.Text) then
  //  TabGlobal_i.DPROJETO.INICIO.Conteudo            := StrToDate(EdInicio.Text);
  TabGlobal_i.DPROJETO.INICIO.Conteudo              := EdInicio.DateValue;
  TabGlobal_i.DPROJETO.ICONE.Conteudo               := EdIcone.Text;
  TabGlobal_i.DPROJETO.APRESENTACAO.Conteudo        := EdTelaApresentacao.Text;
  TabGlobal_i.DPROJETO.FUNDO.Conteudo               := EdImagemFundo.Text;
  if EdAjustar.Checked then
    TabGlobal_i.DPROJETO.AJUSTAR.Conteudo           := 1
  else
    TabGlobal_i.DPROJETO.AJUSTAR.Conteudo           := 0;
  if EdSeculo.Checked then
    TabGlobal_i.DPROJETO.FORMATODATA.Conteudo       := 1
  else
    TabGlobal_i.DPROJETO.FORMATODATA.Conteudo       := 0;
  if EdSaida.Checked then
    TabGlobal_i.DPROJETO.CONFIRMASAIDA.Conteudo     := 1
  else
    TabGlobal_i.DPROJETO.CONFIRMASAIDA.Conteudo     := 0;
  if EdMultiplas.Checked then
    TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo := 1
  else
    TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo := 0;
  if EdHintBalao.Checked then
    TabGlobal_i.DPROJETO.HINTBALAO.Conteudo         := 1
  else
    TabGlobal_i.DPROJETO.HINTBALAO.Conteudo         := 0;
  if EdMenuXP.Checked then
    TabGlobal_i.DPROJETO.MENUXP.Conteudo         := 1
  else
    TabGlobal_i.DPROJETO.MENUXP.Conteudo         := 0;
  if EdDicionario.Checked then
    TabGlobal_i.DPROJETO.DICIONARIO.Conteudo        := 1
  else
    TabGlobal_i.DPROJETO.DICIONARIO.Conteudo        := 0;
  TabGlobal_i.DPROJETO.PASTADICIONARIO.Conteudo     := Ed_L_Dicionario.Text;
  if EdAcesso.Checked then
    TabGlobal_i.DPROJETO.CONTROLEACESSO.Conteudo    := 1
  else
    TabGlobal_i.DPROJETO.CONTROLEACESSO.Conteudo    := 0;
  if EdAcessoInterno.Checked then
    TabGlobal_i.DPROJETO.CONTROLE_ACESSO_INTERNO.Conteudo    := 1
  else
    TabGlobal_i.DPROJETO.CONTROLE_ACESSO_INTERNO.Conteudo    := 0;
  if EdSelecionar.Checked then
    TabGlobal_i.DPROJETO.SELECIONAR_EMP.Conteudo    := 1
  else
    TabGlobal_i.DPROJETO.SELECIONAR_EMP.Conteudo    := 0;
  Atr := '';
  if EdMenuLateral.Checked then
    Atr := '1'
  else
    Atr := '0';
  if EdBarraF.Checked then
    Atr := Atr + '1'
  else
    Atr := Atr + '0';
  if EdBanner.Checked then
    Atr := Atr + '1'
  else
    Atr := Atr + '0';
  TabGlobal_i.DPROJETO.DEIXAR_NA_SENHA.Conteudo     := StrToIntDef(Atr,0);
  TabGlobal_i.DPROJETO.SENHA.Conteudo               := EdSenha.Text;
  TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo           := EdLinguagem.ItemIndex + 1;
  TabGlobal_i.DPROJETO.BDADOS.Conteudo              := EdComboDriver.ItemIndex + 1;
  if EdComboDriver.ItemIndex > 3 then
    TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo := 2
  else
    TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo         := EdConexao.ItemIndex + 1;
  TabGlobal_i.DPROJETO.MODELO.Conteudo := EdModelo.ItemIndex;
  TabGlobal_i.DPROJETO.Salva;
  Busca_PastaFontes(TabGlobal_i.DPROJETO.MODELO.Conteudo);
  Projeto.Dicionario_hab := EdDicionario.Checked;

  if (EdComboDriver.ItemIndex <> Base_Dados_ini) or (EdConexao.ItemIndex <> Conexao_ini) then
  begin
    TabGlobal_i.DTABELAS.First;
    Gera_BaseDados;
    Gera_CTabelas(True);
    Gera_CCalculos;
  end;

  StrCompImFundo  := ComponentToString(ImagemFundo);
  StrCompImSplash := ComponentToString(ImageApresentacao);

  // area de cricao de arquivos do sistema
  Gera_Princ_Inc;
  Gera_Princ_Res(False);
  Gera_Dpr(False);
  Gera_Publicas(False);
  Gera_Splash_Dfm(False);
  Gera_Princ(False,1);
  TabGlobal_i.DMENUSUP.First;
  if not TabGlobal_i.DMENUSUP.Eof then
  begin
    Gera_Princ_MenuSuperior;
    Gera_Princ_BarraF;
  end;  
  Screen.Cursor := crDefault;
  if (Ed_L_Dicionario.Text <> Dicionario_ini) or
     (EdServidor_Pro.Text <> Servidor_Pro_ini) or
     (EdServidor_Dic.Text <> Servidor_Dic_ini) or
     (EdDicionario.Checked <> Dicionario_Hab_ini) or
     (Ed_L_Projeto.Text <> Pasta_pro_ini) then
  begin
    NProj := Projeto.Nome;
    FormPrincipal.BtnFecharProjetoClick(Self);
    FormPrincipal.HabilitaProjeto(NProj);
  end;
  Close;
end;

procedure TFormDadosGenericos.EdIconeExit(Sender: TObject);
begin
  if (ActiveControl = BtnGravar) or (ActiveControl = BtnFechar) or
     (ActiveControl = BtnAjuda) then
    exit;
  if FileExists(EdIcone.Text) then
    ImagemIcone.Picture.LoadFromFile(EdIcone.Text);
end;

procedure TFormDadosGenericos.PageGenericoChange(Sender: TObject);
begin
  if PageGenerico.ActivePageIndex = 0 then
    EdTitulo.SetFocus
  else if PageGenerico.ActivePageIndex = 1 then
    EdTelaApresentacao.SetFocus
  else if PageGenerico.ActivePageIndex = 2 then
  begin
  end;
end;

procedure TFormDadosGenericos.EdTelaApresentacaoExit(Sender: TObject);
begin
  if (ActiveControl = BtnGravar) or (ActiveControl = BtnFechar) or
     (ActiveControl = BtnAjuda) then
    exit;
  if FileExists(EdTelaApresentacao.Text) then
    ImageApresentacao.Picture.LoadFromFile(EdTelaApresentacao.Text);
end;

procedure TFormDadosGenericos.EdImagemFundoExit(Sender: TObject);
begin
  if (ActiveControl = BtnGravar) or (ActiveControl = BtnFechar) or
     (ActiveControl = BtnAjuda) then
    exit;
  if FileExists(EdImagemFundo.Text) then
    ImagemFundo.Picture.LoadFromFile(EdImagemFundo.Text);
end;

procedure TFormDadosGenericos.EdAjustarClick(Sender: TObject);
begin
  ImagemFundo.Stretch := EdAjustar.Checked;
end;

procedure TFormDadosGenericos.EdServidorExit(Sender: TObject);
begin
  BtnGravar.SetFocus;
end;

procedure TFormDadosGenericos.EdInicioExit(Sender: TObject);
begin
  if not DataValida(EdInicio.Text) then
  begin
    Mensagem('Data Inválida !',modErro,[modOk]);
    EdInicio.SelectAll;
    EdInicio.SetFocus;
  end;
end;

procedure TFormDadosGenericos.Ed_L_DicionarioExit(Sender: TObject);
begin
  if (ActiveControl = BtnGravar) or (ActiveControl = BtnFechar) or
     (ActiveControl = BtnAjuda) then
    exit;
  BtnGravar.SetFocus;
end;

procedure TFormDadosGenericos.Ed_L_DicionarioButtonClick(Sender: TObject);
Var S: String;
begin
  S := '';
  if SelectDirectory('Selecione a Pasta', '', S) then
    Ed_L_Dicionario.Text := DiretorioCombarra(S);
end;

procedure TFormDadosGenericos.EdIconeButtonClick(Sender: TObject);
begin
  OpenPictureIcone.FileName := '';
  OpenPictureIcone.InitialDir := Projeto.PastaGerador + 'Imagem';
  if EdIcone.Text <> '' then
    OpenPictureIcone.FileName := Projeto.Pasta + 'Imagens\' + EdIcone.Text;
  if OpenPictureIcone.Execute then
  begin
    if not (FileExists(Projeto.Pasta + 'Imagens\' + ExtractFileName(OpenPictureIcone.FileName))) then
      CopiaArquivo(OpenPictureIcone.FileName,
                   Projeto.Pasta + 'Imagens\' + RetiraEspacos(ExtractFileName(OpenPictureIcone.FileName)));
    EdIcone.Text := RetiraEspacos(ExtractFileName(OpenPictureIcone.FileName));
    ImagemIcone.Picture.LoadFromFile(Projeto.Pasta + 'Imagens\' + EdIcone.Text);
  end;
  EdIcone.SetFocus;
end;

procedure TFormDadosGenericos.EdTelaApresentacaoButtonClick(
  Sender: TObject);
begin
  OpenPictureImagem.FileName := '';
  OpenPictureImagem.InitialDir := Projeto.PastaGerador + 'Imagem';
  if EdTelaApresentacao.Text <> '' then
    OpenPictureImagem.FileName := Projeto.Pasta + 'Imagens\' + EdTelaApresentacao.Text;
  if OpenPictureImagem.Execute then
  begin
    if not (FileExists(Projeto.Pasta + 'Imagens\' + ExtractFileName(OpenPictureImagem.FileName))) then
      CopiaArquivo(OpenPictureImagem.FileName,
                   Projeto.Pasta + 'Imagens\' + RetiraEspacos(ExtractFileName(OpenPictureImagem.FileName)));
    EdTelaApresentacao.Text := RetiraEspacos(ExtractFileName(OpenPictureImagem.FileName));
    ImageApresentacao.Picture.LoadFromFile(Projeto.Pasta + 'Imagens\' + EdTelaApresentacao.Text);
  end;
  EdTelaApresentacao.SetFocus;
end;

procedure TFormDadosGenericos.EdImagemFundoButtonClick(Sender: TObject);
begin
  OpenPictureImagem.FileName := '';
  OpenPictureImagem.InitialDir := Projeto.PastaGerador + 'Imagem';
  if EdImagemFundo.Text <> '' then
    OpenPictureImagem.FileName := Projeto.Pasta + 'Imagens\' + EdImagemFundo.Text;
  if OpenPictureImagem.Execute then
  begin
    if not (FileExists(Projeto.Pasta + 'Imagens\' + ExtractFileName(OpenPictureImagem.FileName))) then
      CopiaArquivo(OpenPictureImagem.FileName,
                   Projeto.Pasta + 'Imagens\' + RetiraEspacos(ExtractFileName(OpenPictureImagem.FileName)));
    EdImagemFundo.Text := RetiraEspacos(ExtractFileName(OpenPictureImagem.FileName));
    ImagemFundo.Picture.LoadFromFile(Projeto.Pasta + 'Imagens\' + EdImagemFundo.Text);
  end;
  EdImagemFundo.SetFocus;
end;

procedure TFormDadosGenericos.EdTelaApresentacaoChange(Sender: TObject);
begin
  if (EdTelaApresentacao.Text = '') then
    ImageApresentacao.Picture := ImagemVazia.Picture;
  if (EdImagemFundo.Text = '') then
    ImagemFundo.Picture := ImagemVazia.Picture;
  if (EdIcone.Text = '') then
    ImagemIcone.Picture := ImagemVazia.Picture;
end;

procedure TFormDadosGenericos.EdComboDriverExit(Sender: TObject);
var
  Posicao: Integer;
begin
{
Interbase
Firebird
SQLBase
Oracle
SQLServer
Sybase
DB2
Informix
ODBC
MySQL
PostgreSQL
OLEDB
}
{
IBX
XSQL
}
  Posicao := EdConexao.ItemIndex;
  EdConexao.Clear;
  if (EdComboDriver.ItemIndex >= 0) and (EdComboDriver.ItemIndex < 2) then
  begin
    EdConexao.Items.Add('IBX');
    EdConexao.Items.Add('XSQL');
  end
  else
    EdConexao.Items.Add('XSQL');
  if Posicao < EdConexao.Items.Count then
    EdConexao.ItemIndex := Posicao;
end;

procedure TFormDadosGenericos.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 0 then
    EdSeculo.SetFocus
  else if PageControl.ActivePageIndex = 1 then
    EdDicionario.SetFocus;
end;

procedure TFormDadosGenericos.EdDicionarioExit(Sender: TObject);
begin
  if not EdDicionario.Checked then
  begin
    Ed_L_Dicionario.ReadOnly := True;
    Ed_L_Dicionario.Color := clBtnFace;
  end
  else
  begin
    Ed_L_Dicionario.ReadOnly := False;
    Ed_L_Dicionario.Color := clWindow;
  end;
end;

procedure TFormDadosGenericos.EdAcessoExit(Sender: TObject);
begin
  if not EdAcesso.Checked then
  begin
    EdSenha.ReadOnly := True;
    EdSenha.Color := clBtnFace;
  end
  else
  begin
    EdSenha.ReadOnly := False;
    EdSenha.Color := clWindow;
  end;
end;

procedure TFormDadosGenericos.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;
end;

procedure TFormDadosGenericos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calendário
    FormPrincipal.CalendarioClick(Self)
  else if Key = VK_F6 then // Calculadora
    FormPrincipal.CalculadoraClick(Self)
  else if Key = VK_F7 then // Diário
    FormPrincipal.DiarioProjetoClick(Self)
  else if Key = VK_F1 then // Agenda
    FormPrincipal.ConteudoClick(Self);
end;

procedure TFormDadosGenericos.Ed_L_ProjetoButtonClick(Sender: TObject);
Var S: String;
begin
  S := '';
  if SelectDirectory('Selecione a Pasta', '', S) then
    Ed_L_Projeto.Text := DiretorioCombarra(S);
end;

end.
