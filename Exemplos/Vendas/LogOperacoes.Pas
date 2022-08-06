{
   Programa.: LogOperacoes.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit LogOperacoes;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Tabs, BaseD, Db, Grids, DBGrids,
  {$IFDEF DELPHI5}{$ELSE}Variants, MaskUtils,{$ENDIF}
  Atributo, dbctrls, Clipbrd, Tabela, Menus, IniFiles, Printers, Calculos,
  {$I LTab.pas}
  JPeg, XLookUp, XDBDate, Mask, XDBEdit, XDBNum, XEdit, XBanner, XDate, XNum;

type
  TFormLogOperacoes = class(TForm)
    AbaConsulta: TTabSet;
    AbrirImagem: TMenuItem;
    BtnAnterior: TSpeedButton;
    BtnLocalizar: TSpeedButton;
    BtnPrimeiro: TSpeedButton;
    BtnProximo: TSpeedButton;
    BtnRefresh: TSpeedButton;
    BtnTabela: TSpeedButton;
    BtnUltimo: TSpeedButton;
    ColarImagem: TMenuItem;
    Comando: TDBMemo;
    CopiarImagem: TMenuItem;
    CortarImagem: TMenuItem;
    Data: TXDBDateEdit;
    DataSource: TDataSource;
    Divisao_inf: TPanel;
    Divisao_sup: TPanel;
    DlgAbrirImagem: TOpenDialog;
    DlgSalvarComoImagem: TSaveDialog;
    GridConsulta: TDBGrid;
    Hora: TXDBEdit;
    LbcComando: TLabel;
    LbcData: TLabel;
    LbcHora: TLabel;
    LbcTabela: TLabel;
    LbcTipo: TLabel;
    LbcUsuario: TLabel;
    MenuImagem: TPopupMenu;
    MnSep01: TMenuItem;
    mnu_ApagarColuna: TMenuItem;
    mnu_CalcularMedia: TMenuItem;
    mnu_ExcluirConsulta: TMenuItem;
    mnu_Filtrar: TMenuItem;
    mnu_Imprimir: TMenuItem;
    mnu_Ordenar: TMenuItem;
    mnu_OrdenarComposto: TMenuItem;
    mnu_Quantificar: TMenuItem;
    mnu_SalvarConsulta: TMenuItem;
    mnu_TotalizarColuna: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    NoManutencao: TNotebook;
    PageForm: TNotebook;
    Pagina0: TScrollBox;
    Pagina1: TScrollBox;
    Pagina10: TScrollBox;
    Pagina2: TScrollBox;
    Pagina3: TScrollBox;
    Pagina4: TScrollBox;
    Pagina5: TScrollBox;
    Pagina6: TScrollBox;
    Pagina7: TScrollBox;
    Pagina8: TScrollBox;
    Pagina9: TScrollBox;
    PgPagina1: TScrollBox;
    PnSuperior: TPanel;
    PopConsulta: TPopupMenu;
    SalvarImagem: TMenuItem;
    StatusBar: TStatusBar;
    Tabela: TXDBEdit;
    TabPaginas: TTabSet;
    Tipo: TXDBEdit;
    Usuario: TXDBEdit;
    Img_Tabela: TImage;
    Img_Form: TImage;
    BtnProcuraEspecial: TSpeedButton;
    LbcEstacao: TLabel;
    Estacao: TXDBEdit;
    procedure UsuarioExit(Sender: TObject);
    procedure DataExit(Sender: TObject);
    procedure HoraExit(Sender: TObject);
    procedure TabelaExit(Sender: TObject);
    procedure TipoExit(Sender: TObject);
    procedure ComandoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnu_FiltrarClick(Sender: TObject);
    procedure mnu_OrdenarClick(Sender: TObject);
    procedure mnu_OrdenarCompostoClick(Sender: TObject);
    procedure mnu_ApagarColunaClick(Sender: TObject);
    procedure mnu_QuantificarClick(Sender: TObject);
    procedure mnu_TotalizarColunaClick(Sender: TObject);
    procedure mnu_CalcularMediaClick(Sender: TObject);
    procedure mnu_ImprimirClick(Sender: TObject);
    procedure mnu_SalvarConsultaClick(Sender: TObject);
    procedure mnu_ExcluirConsultaClick(Sender: TObject);
    procedure AbaConsultaClick(Sender: TObject);
    procedure TabPaginasClick(Sender: TObject);
    procedure CortarImagemClick(Sender: TObject);
    procedure CopiarImagemClick(Sender: TObject);
    procedure ColarImagemClick(Sender: TObject);
    procedure AbrirImagemClick(Sender: TObject);
    procedure SalvarImagemClick(Sender: TObject);
    procedure ChamaGridPesquisa(Sender: TObject);
    procedure ValidaColunaGrid(Sender: TField);
    procedure BtnTabelaClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnRefreshClick(Sender: TObject);
    procedure GridConsultaDblClick(Sender: TObject);
    procedure BtnProcuraEspecialClick(Sender: TObject);
    procedure EstacaoExit(Sender: TObject);
  private
    { Private declarations }
    Navegando: Boolean;
    ListaCamposED: TListaCampos; {Conterá a lista de campos em edição na ED}
    TituloModulo: String;
    ConsultasSalvas: TList;
    PaginaIni: Integer;
    ErroValidacao: Boolean;
    SalvarRegistro: Boolean;
    procedure Inicializa;
    procedure HabilitaBotoesEdicao(Valor: Boolean = True);
    procedure StatusTabela;
    function AbreTabelas: Boolean;
    procedure FechaTabelas;
    procedure MudaSeForUltimo;
    function AbandonandoEdicao: Boolean;
    procedure TelaManutencao;
    procedure TelaConsulta;
    procedure AtribuiValoresPadrao;
    procedure PosicionaNoCampo(Campo: TAtributo);
    procedure ErroValidacaoCampo(MsgErro: String; Campo: TAtributo);
    procedure AntesdeSalvar;
    procedure AntesdeIncluir;
    procedure AntesdeModificar;
    procedure AntesdeExcluir;
    procedure DepoisdeIncluir;
    procedure DepoisdeModificar;
    procedure DepoisdeExcluir;
    function ConfirmaInclusao: Boolean;
    function ConfirmaModificacao: Boolean;
    function ConfirmaExclusao: Boolean;
    function ConfirmaGravacao: Boolean;
    procedure CamposCalculados;
    procedure BotoesManutencao(Habilita: Boolean);
    procedure HabilitaEdicao(Habilita: Boolean = true);
  public
    { Public declarations }
    {03-Início do Bloco Modular. Modificações não serão preservadas}
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    TabelaPrincipal: TTabela;
    {04-Início do Bloco Modular. Modificações não serão preservadas}
    {99-Final do Bloco Modular. Modificações não serão preservadas}
  end;

var
  FormLogOperacoes: TFormLogOperacoes;
  LastControl: TWinControl;

implementation

{$R *.DFM}

uses Publicas, Princ, Rotinas, RotinaEd, Abertura, GridPesquisa, Interno,
  LogProcura;

procedure TFormLogOperacoes.Inicializa;
begin
  {05-Início do Bloco Modular. Modificações não serão preservadas}
  TabelaPrincipal    := TabGlobal.DUSER_LOG;
  TituloModulo       := 'Log de Operações ( Inclusões, Modificações e Exclusões )';
  Caption            := TituloModulo;
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  Navegando          := False;
  DataSource.DataSet := TabelaPrincipal;
  ListaCamposED      := TListaCampos.Create;
  ConsultasSalvas    := TList.Create;
  PaginaIni          := 0;
  ErroValidacao      := False;
  TabPaginas.TabIndex:= 0;
  if not TabelaPrincipal.Active then
    TabelaPrincipal.AtualizaSql;
  {06-Início do Bloco Modular. Modificações não serão preservadas}
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Comando, 0, ComandoExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Tipo, -1, TipoExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Tabela, -1, TabelaExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Hora, -1, HoraExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Data, -1, DataExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Estacao, -1, EstacaoExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  AtribuiCampoEdicao(TabGlobal.DUSER_LOG, TabGlobal.DUSER_LOG.Usuario, -1, UsuarioExit, Nil, ListaCamposEd, FormLogOperacoes, DataSource, ChamaGridPesquisa);
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  TabPaginas.Visible  := TabPaginas.Tabs.Count > 1;
  Divisao_inf.Visible := TabPaginas.Tabs.Count <= 1;
  CamposCalculados;
  AjustaColunasConsulta(TabelaPrincipal);
  AbaConsulta.OnClick := Nil;
  AbaConsulta.TabIndex:= 0;
  Ed_AbaConsulta(TabelaPrincipal, AbaConsulta, ConsultasSalvas, GridConsulta, False);
  AbaConsulta.OnClick := AbaConsultaClick;
  InicializaConsultasSalvas(TabelaPrincipal, AbaConsulta, ConsultasSalvas);
  PageForm.PageIndex := 0;
  NoManutencao.PageIndex := 0;
  HabilitaEdicao(False);
  HabilitaBotoesEdicao(False);
  TelaConsulta;
  StatusTabela;
end;

procedure TFormLogOperacoes.HabilitaBotoesEdicao(Valor: Boolean = True);
begin
  BtnLocalizar.Enabled := not Valor;
  BtnPrimeiro.Enabled  := not Valor;
  BtnAnterior.Enabled  := not Valor;
  BtnProximo.Enabled   := not Valor;
  BtnUltimo.Enabled    := not Valor;
  BtnRefresh.Enabled   := not Valor;
end;

procedure TFormLogOperacoes.FormShow(Sender: TObject);
begin
  Inicializa;
end;

function TFormLogOperacoes.AbreTabelas: Boolean;
begin
  {07-Início do Bloco Modular. Modificações não serão preservadas}
  Result := True;
  {99-Final do Bloco Modular. Modificações não serão preservadas}
end;

procedure TFormLogOperacoes.FechaTabelas;
begin
  try
    TabelaPrincipal.Close;
  except
    on Erro: Exception do
    begin
      MessageDlg('Erro: ' + Erro.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TFormLogOperacoes.CamposCalculados;
begin
  {08-Início do Bloco Modular. Modificações não serão preservadas}
  {99-Final do Bloco Modular. Modificações não serão preservadas}
end;

procedure TFormLogOperacoes.BotoesManutencao(Habilita: Boolean);
begin
  BtnLocalizar.Enabled := Habilita;
  BtnTabela.Enabled    := Habilita;
  BtnPrimeiro.Enabled  := Habilita;
  BtnAnterior.Enabled  := Habilita;
  BtnProximo.Enabled   := Habilita;
  BtnUltimo.Enabled    := Habilita;
  BtnRefresh.Enabled   := Habilita;
end;

procedure TFormLogOperacoes.HabilitaEdicao(Habilita: Boolean = true);
var
  I: Integer;
  Comp: TComponent;

  function PosicionaFoco(Indice: Integer): Boolean;
  var
    I: Integer;
    CampoED: TCampoEdicao;
  begin
    PosicionaFoco := False;
    for I:=0 to ListaCamposED.Count-1 do
    begin
      CampoED := TCampoEdicao(ListaCamposED[I]);
      if (CampoED.Controle.TabOrder = Indice) and (CampoED.Controle.CanFocus) and
         (CampoED.Controle.Enabled) and (CampoED.Controle.TabStop) and (CampoED.Pagina <= 0) then
      begin
        CampoED.Controle.SetFocus;
        PosicionaFoco := True;
        Break;
      end;
    end;
  end;

begin
  if TabelaPrincipal.Inclusao or TabelaPrincipal.Modificacao then
    BotoesManutencao(False)
  else
    BotoesManutencao(True);
  CamposEdicaoReadOnly(ListaCamposED, True);
  if Habilita then
    for I:=0 to ListaCamposED.Count-1 do
      if PosicionaFoco(I) then
        break;
end;

function TFormLogOperacoes.ConfirmaInclusao: Boolean;
begin
  Result := True;
end;

function TFormLogOperacoes.ConfirmaModificacao: Boolean;
begin
  Result := True;
end;

function TFormLogOperacoes.ConfirmaExclusao: Boolean;
begin
  Result := True;
end;

function TFormLogOperacoes.ConfirmaGravacao: Boolean;
begin
  Result := True;
end;

procedure TFormLogOperacoes.TelaManutencao;
begin
  AtribuiDataSourceCampos(ListaCamposEd, DataSource);
  PageForm.PageIndex := 0;
  GridConsulta.DataSource := Nil;
  if (TabelaPrincipal.Inclusao) or
     (TabelaPrincipal.Modificacao) then
    HabilitaEdicao
  else
    HabilitaEdicao(False);
  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
  TabelaPrincipal.AtribuiRelacionamentos;
  BtnTabela.Caption := 'Tabela';
  BtnTabela.Hint    := 'Visualizar registros em forma de tabela';
  BtnTabela.Glyph   := Img_Tabela.Picture.Bitmap;
  BtnTabela.Tag     := 0;
  Divisao_sup.Visible   := True;
end;

procedure TFormLogOperacoes.TelaConsulta;
begin
  AtribuiDataSourceCampos(ListaCamposEd, Nil);
  HabilitaEdicao(False);
  PageForm.PageIndex := 1;
  GridConsulta.DataSource := DataSource;
  BtnTabela.Caption := 'Formulário';
  BtnTabela.Hint    := 'Visualizar registros em forma de formulário';
  BtnTabela.Glyph   := Img_Form.Picture.Bitmap;
  BtnTabela.Tag     := 1;
  Divisao_sup.Visible   := False;
  GridConsulta.SetFocus;
end;

procedure TFormLogOperacoes.AtribuiValoresPadrao;
begin
  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd, True);
  TabelaPrincipal.AtribuiRelacionamentos;

end;

procedure TFormLogOperacoes.AntesdeSalvar;
begin

end;

procedure TFormLogOperacoes.AntesdeIncluir;
begin

end;

procedure TFormLogOperacoes.AntesdeModificar;
begin

end;

procedure TFormLogOperacoes.AntesdeExcluir;
begin

end;

procedure TFormLogOperacoes.DepoisdeIncluir;
begin

end;

procedure TFormLogOperacoes.DepoisdeModificar;
begin

end;

procedure TFormLogOperacoes.DepoisdeExcluir;
begin

end;

procedure TFormLogOperacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  I: Integer;
begin
  AbaConsulta.OnClick := Nil;
  AbaConsulta.TabIndex:= 0;
  Ed_AbaConsulta(TabelaPrincipal, AbaConsulta, ConsultasSalvas, GridConsulta, False);
  if Trim(TabelaPrincipal.FiltroRelac.Text) = '' then
    FechaTabelas;
  ListaCamposED.Free;
  for I := 0 to ConsultasSalvas.Count - 1 do
    TConsultasSalvas(ConsultasSalvas[I]).Free;
  ConsultasSalvas.Free;
end;

procedure TFormLogOperacoes.StatusTabela;
begin
  if (TabelaPrincipal.Inclusao) then
    StatusBar.Panels[0].Text := 'Operação: Incluíndo'
  else if (TabelaPrincipal.Modificacao) then
    StatusBar.Panels[0].Text := 'Operação: Modificando'
  else
    StatusBar.Panels[0].Text := 'Operação: Visualizando';
  if (Trim(TabelaPrincipal.Filtro.Text) <> '') or
     (Trim(TabelaPrincipal.FiltroRelac.Text) <> '') or
     (Trim(TabelaPrincipal.FiltroFixo.Text) <> '') then
    StatusBar.Panels[1].Text := 'Filtragem: Habilitada'
  else
    StatusBar.Panels[1].Text := 'Filtragem: Desabilitada';
  StatusBar.Panels[2].Text := 'Ordenação: '+TabelaPrincipal.TituloIndice;
  Application.ProcessMessages;
end;

procedure TFormLogOperacoes.FormActivate(Sender: TObject);
begin
  if TabelaPrincipal.Inclusao or TabelaPrincipal.Modificacao then
    BotoesManutencao(False)
  else
    BotoesManutencao(True);
end;

procedure TFormLogOperacoes.FormKeyPress(Sender: TObject; var Key: Char);
var
  ControleCampo: TWinControl;
begin
  ControleCampo := ActiveControl;
  while (ControleCampo <> nil) and (ControleCampo.Owner <> Self) do
    ControleCampo := ControleCampo.Parent;
  if Key = Chr(13) then
    begin
      Key := #0;
      {Atua como a tecla TAB}
      Perform(WM_NEXTDLGCTL, 0, 0);
      LastControl := ControleCampo;
      MudaSeForUltimo;
    end;
end;

procedure TFormLogOperacoes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
    if Key = 76 then  // Ctrl + L -> Localizar
      BtnLocalizarClick(Self)
end;

procedure TFormLogOperacoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calendário
    Interno108
  else if Key = VK_F6 then // Calculadora
    Interno109
  else if Key = VK_F7 then // Agenda
    Interno110;
end;

procedure TFormLogOperacoes.BtnTabelaClick(Sender: TObject);
begin
  if BtnTabela.Tag = 0 then
    TelaConsulta
  else
    TelaManutencao;
  StatusTabela;
end;

procedure TFormLogOperacoes.BtnLocalizarClick(Sender: TObject);
begin
  Ed_Localizar(TabelaPrincipal, FormLogOperacoes, GridConsulta);
  StatusTabela;
end;

procedure TFormLogOperacoes.BtnPrimeiroClick(Sender: TObject);
begin
  Navegando := True;
  if not ErroValidacao then
  begin
    Screen.Cursor := crHourGlass;
    try
      TabelaPrincipal.First;
    finally
      Screen.Cursor := crDefault;
      StatusTabela;
    end;
  end;
end;

procedure TFormLogOperacoes.BtnAnteriorClick(Sender: TObject);
begin
  Navegando := True;
  if not ErroValidacao then
  begin
    TabelaPrincipal.Prior;
    if TabelaPrincipal.Bof then
      MessageDlg('Início dos registros!', mtInformation, [mbOk], 0);
    StatusTabela;
  end;
end;

procedure TFormLogOperacoes.BtnProximoClick(Sender: TObject);
begin
  Navegando := True;
  if not ErroValidacao then
  begin
    TabelaPrincipal.Next;
    if TabelaPrincipal.Eof then
      MessageDlg('Final dos registros!', mtInformation, [mbOk], 0);
    StatusTabela;
  end;
end;

procedure TFormLogOperacoes.BtnUltimoClick(Sender: TObject);
begin
  Navegando := True;
  if not ErroValidacao then
  begin
    try
      TabelaPrincipal.Last;
      if TabelaPrincipal.Eof then
      begin
        TabelaPrincipal.Prior;
        TabelaPrincipal.Next;
      end;
    finally
      Screen.Cursor := crDefault;
      StatusTabela;
    end;
  end;
end;

procedure TFormLogOperacoes.BtnRefreshClick(Sender: TObject);
begin
  if MessageDlg('Atualizar registros?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    TabelaPrincipal.AtualizaSql;
end;

procedure TFormLogOperacoes.mnu_FiltrarClick(Sender: TObject);
begin
  Ed_Filtrar(TabelaPrincipal, FormLogOperacoes, GridConsulta);
  StatusTabela;
end;

procedure TFormLogOperacoes.mnu_OrdenarClick(Sender: TObject);
begin
  Ed_Ordenar(TabelaPrincipal, FormLogOperacoes, GridConsulta);
  StatusTabela;
end;

procedure TFormLogOperacoes.mnu_OrdenarCompostoClick(Sender: TObject);
begin
  Ed_OrdenarComposto(TabelaPrincipal, FormLogOperacoes, GridConsulta);
  StatusTabela;
end;

procedure TFormLogOperacoes.mnu_ApagarColunaClick(Sender: TObject);
begin
  Ed_ApagarColuna(TabelaPrincipal, FormLogOperacoes, GridConsulta);
end;

procedure TFormLogOperacoes.mnu_QuantificarClick(Sender: TObject);
begin
  Ed_Quantificar(TabelaPrincipal, FormLogOperacoes, GridConsulta);
end;

procedure TFormLogOperacoes.mnu_TotalizarColunaClick(Sender: TObject);
begin
  Ed_TotalizarColuna(TabelaPrincipal, FormLogOperacoes, GridConsulta);
end;

procedure TFormLogOperacoes.mnu_CalcularMediaClick(Sender: TObject);
begin
  Ed_CalcularMedia(TabelaPrincipal, FormLogOperacoes, GridConsulta);
end;

procedure TFormLogOperacoes.mnu_ImprimirClick(Sender: TObject);
begin
  Ed_Imprimir(TabelaPrincipal, FormLogOperacoes, GridConsulta, DataSource);
end;

procedure TFormLogOperacoes.mnu_SalvarConsultaClick(Sender: TObject);
begin
  Ed_SalvarConsulta(TabelaPrincipal, FormLogOperacoes, GridConsulta, AbaConsulta, ConsultasSalvas);
end;

procedure TFormLogOperacoes.mnu_ExcluirConsultaClick(Sender: TObject);
begin
  Ed_ExcluirConsulta(TabelaPrincipal, FormLogOperacoes, GridConsulta, AbaConsulta, ConsultasSalvas);
end;

procedure TFormLogOperacoes.AbaConsultaClick(Sender: TObject);
begin
  Ed_AbaConsulta(TabelaPrincipal, AbaConsulta, ConsultasSalvas, GridConsulta);
  StatusTabela;
end;

procedure TFormLogOperacoes.TabPaginasClick(Sender: TObject);
begin
  if NoManutencao.PageIndex <> TabPaginas.TabIndex then
    NoManutencao.SetFocus;
  NoManutencao.PageIndex := TabPaginas.TabIndex;
end;

procedure TFormLogOperacoes.PosicionaNoCampo(Campo: TAtributo);
var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  I := ListaCamposED.ProcuraCampoED(Campo);
  if I = -1 then
    Exit;
  CampoED := TCampoEdicao(ListaCamposED[I]);
  if (CampoED.Pagina <> -1) then
    TabPaginas.TabIndex := CampoED.Pagina;
  CampoED.Controle.SetFocus;
end;

procedure TFormLogOperacoes.ErroValidacaoCampo(MsgErro: String; Campo: TAtributo);
begin
  MessageDlg(MsgErro, mtError, [mbOk], 0);
  ErroValidacao := True;
  PosicionaNoCampo(Campo);
end;

procedure TFormLogOperacoes.MudaSeForUltimo;
begin
  if (NoManutencao.PageIndex <> NoManutencao.Pages.Count - 1) then
    if TabPaginas.TabIndex + 1 <= TabPaginas.Tabs.Count-1 then
      TabPaginas.TabIndex := TabPaginas.TabIndex + 1;
end;

procedure TFormLogOperacoes.CortarImagemClick(Sender: TObject);
begin
  if ActiveControl is TDBImage then
    TDBImage(ActiveControl).CutToClipBoard;
end;

procedure TFormLogOperacoes.CopiarImagemClick(Sender: TObject);
begin
  if ActiveControl is TDBImage then
    TDBImage(ActiveControl).CopyToClipBoard;
end;

procedure TFormLogOperacoes.ColarImagemClick(Sender: TObject);
begin
  if (ActiveControl is TDBImage) and Clipboard.HasFormat(CF_PICTURE) then
  begin
    (ActiveControl as TDBImage).PasteFromClipBoard;
    if TDBImage(ActiveControl).Picture.Graphic is TBitmap then
      TDBImage(ActiveControl).DataSource.DataSet.UpdateRecord
    else
    begin
      MessageDlg('Formato Inválido !', mtError, [mbOk], 0);
      TDBImage(ActiveControl).DataSource.DataSet.Cancel;
    end;
  end
  else
    MessageDlg('Área de Transferência não contém imagem !', mtError, [mbOk], 0);
end;

procedure TFormLogOperacoes.AbrirImagemClick(Sender: TObject);
var
  image_BD : TPicture;
begin
  if DlgAbrirImagem.Execute and FileExists(DlgAbrirImagem.FileName) and
    (ActiveControl is TDBImage) then
  begin
    image_BD := TPicture.Create();
    try
      image_BD.LoadFromFile(DlgAbrirImagem.FileName);
      Clipboard.Assign(image_BD);
      TDBImage(ActiveControl).PasteFromClipboard;
      Clipboard.Clear;
    finally
      image_BD.Free;
    end;
  end;
end;

procedure TFormLogOperacoes.SalvarImagemClick(Sender: TObject);
begin
  if DlgSalvarComoImagem.Execute and (ActiveControl is TDBImage) then
    TDBImage(ActiveControl).Picture.SaveToFile(DlgSalvarComoImagem.FileName);
end;

function TFormLogOperacoes.AbandonandoEdicao: Boolean;
begin
end;

procedure TFormLogOperacoes.ChamaGridPesquisa(Sender: TObject);
Var
  I: Integer;
  CampoED: TCampoEdicao;
  Campo: TAtributo;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Controle = Sender then
    begin
      Campo := CampoED.Campo;
      Break;
    end;
  end;
  if (Campo = nil) or (Campo.Valor.ReadOnly) then exit;
  FormGridPesquisa := TFormGridPesquisa.Create(Application);
  Try
    if Sender is TXDBEdit then
      FormGridPesquisa.Atalho := TXDBEdit(Sender).ClickKey
    else if Sender is TXDBNumEdit then
      FormGridPesquisa.Atalho := TXDBNumEdit(Sender).ClickKey
    else if Sender is TXDBDateEdit then
      FormGridPesquisa.Atalho := TXDBDateEdit(Sender).ClickKey;
    FormGridPesquisa.Campo  := Campo;
    FormGridPesquisa.ShowModal;
  Finally
    FormGridPesquisa.Free;
  end;
end;

procedure TFormLogOperacoes.ValidaColunaGrid(Sender: TField);
var
  MsgErro : String;
  I: Integer;
  Campo: TAtributo;
begin
  if AbandonandoEdicao then
    Exit;
  for I:=0 to TTabela(Sender.DataSet).Campos.Count-1 do
  begin
    Campo := TAtributo(TTabela(Sender.DataSet).Campos[I]);
    if Campo.Valor = Sender then
      Break;
  end;
  if Campo = nil then exit;
  if not Campo.Valido(MsgErro) then
    raise Exception.Create(MsgErro);
end;

{11-Início do Bloco Modular. Modificações não serão preservadas}
{99-Final do Bloco Modular. Modificações não serão preservadas}

procedure TFormLogOperacoes.UsuarioExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Usuario.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Usuario);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

procedure TFormLogOperacoes.DataExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Data.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Data);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

procedure TFormLogOperacoes.HoraExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Hora.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Hora);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

procedure TFormLogOperacoes.TabelaExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Tabela.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Tabela);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

procedure TFormLogOperacoes.TipoExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Tipo.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Tipo);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

procedure TFormLogOperacoes.ComandoExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Comando.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Comando);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

procedure TFormLogOperacoes.GridConsultaDblClick(Sender: TObject);
begin
  TelaManutencao;
end;

procedure TFormLogOperacoes.BtnProcuraEspecialClick(Sender: TObject);
begin
  FormLogProcura := TFormLogProcura.Create(Application);
  Try
    FormLogProcura.ShowModal;
  Finally
    FormLogProcura.Free;
  end;
end;

procedure TFormLogOperacoes.EstacaoExit(Sender: TObject);
var MsgErro : string;
begin
  if AbandonandoEdicao then
    Exit;
  if not TabGlobal.DUSER_LOG.Estacao.Valido(MsgErro, not SalvarRegistro) then
    ErroValidacaoCampo(MsgErro, TabGlobal.DUSER_LOG.Estacao);
  if not SalvarRegistro then
    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
end;

end.
