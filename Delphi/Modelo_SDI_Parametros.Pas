{
   Programa.: XMakerModelo.PAS
   Copyright: X-Maker
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit XMakerModelo;

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
  TFormXMakerModelo = class(TForm)
    AbaConsulta: TTabSet;
    AbrirImagem: TMenuItem;
    BtnDesistir: TBitBtn;
    BtnSalvar: TBitBtn;
    ColarImagem: TMenuItem;
    CopiarImagem: TMenuItem;
    CortarImagem: TMenuItem;
    DataSource: TDataSource;
    DlgAbrirImagem: TOpenDialog;
    DlgSalvarComoImagem: TSaveDialog;
    GridConsulta: TDBGrid;
    MenuImagem: TPopupMenu;
    MnSep01: TMenuItem;
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
    PnInferior: TPanel;
    SalvarImagem: TMenuItem;
    TabPaginas: TTabSet;
    PnSuperior: TPanel;
    BtnModificar: TSpeedButton;
    BtnTabela: TSpeedButton;
    Img_Tabela: TImage;
    Img_Form: TImage;
    Divisao_sup: TPanel;
    StatusBar: TStatusBar;
    Divisao_inf: TPanel;
    BtnRefresh: TSpeedButton;
    PopConsulta: TPopupMenu;
    mnu_Filtrar: TMenuItem;
    mnu_Ordenar: TMenuItem;
    mnu_OrdenarComposto: TMenuItem;
    N1: TMenuItem;
    mnu_ApagarColuna: TMenuItem;
    N2: TMenuItem;
    mnu_Quantificar: TMenuItem;
    mnu_TotalizarColuna: TMenuItem;
    mnu_CalcularMedia: TMenuItem;
    N3: TMenuItem;
    mnu_Imprimir: TMenuItem;
    mnu_SalvarConsulta: TMenuItem;
    mnu_ExcluirConsulta: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnDesistirClick(Sender: TObject);
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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabPaginasClick(Sender: TObject);
    procedure CortarImagemClick(Sender: TObject);
    procedure CopiarImagemClick(Sender: TObject);
    procedure ColarImagemClick(Sender: TObject);
    procedure AbrirImagemClick(Sender: TObject);
    procedure SalvarImagemClick(Sender: TObject);
    procedure ChamaGridPesquisa(Sender: TObject);
    procedure ValidaColunaGrid(Sender: TField);
    procedure BtnTabelaClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnModificarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure GridConsultaDblClick(Sender: TObject);
    procedure BtnRefreshClick(Sender: TObject);
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
    procedure VerificaAtualizacoes;
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
    {03-Início do Bloco X-Maker. Modificações não serão preservadas}
    {99-Final do Bloco X-Maker. Modificações não serão preservadas}
    TabelaPrincipal: TTabela;
    {04-Início do Bloco X-Maker. Modificações não serão preservadas}
    {99-Final do Bloco X-Maker. Modificações não serão preservadas}
  end;

var
  FormXMakerModelo: TFormXMakerModelo;
  LastControl: TWinControl;

implementation

{$R *.DFM}

uses Publicas, Princ, Rotinas, RotinaEd, Abertura, GridPesquisa, Interno;

procedure TFormXMakerModelo.Inicializa;
begin
  {05-Início do Bloco X-Maker. Modificações não serão preservadas}
  TabelaPrincipal    := Nil;
  TituloModulo       := 'Modelo';
  Caption            := TituloModulo;
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
  Navegando          := False;
  DataSource.DataSet := TabelaPrincipal;
  ListaCamposED      := TListaCampos.Create;
  ConsultasSalvas    := TList.Create;
  PaginaIni          := 0;
  ErroValidacao      := False;
  TabPaginas.TabIndex:= 0;
  if not TabelaPrincipal.Active then
    TabelaPrincipal.AtualizaSql;
  {06-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
  if TabelaPrincipal.Eof then
  begin
    TabelaPrincipal.Inclui(ListaCamposED);
    TabelaPrincipal.Salva;
  end;
  TabPaginas.Visible  := TabPaginas.Tabs.Count > 1;
  Divisao_inf.Visible := TabPaginas.Tabs.Count <= 1;
  CamposCalculados;
  AjustaColunasConsulta(TabelaPrincipal);
  AbaConsulta.OnClick := Nil;
  AbaConsulta.TabIndex:= 0;
  Ed_AbaConsulta(TabelaPrincipal, AbaConsulta, ConsultasSalvas, GridConsulta, False);
  AbaConsulta.OnClick := AbaConsultaClick;
  BtnSalvar.Enabled   := False;
  BtnDesistir.Enabled := False;
  InicializaConsultasSalvas(TabelaPrincipal, AbaConsulta, ConsultasSalvas);
  PageForm.PageIndex := 0;
  NoManutencao.PageIndex := 0;
  HabilitaEdicao(False);
  HabilitaBotoesEdicao(False);
  if PageForm.PageIndex = 0 then
    TelaManutencao;
end;

procedure TFormXMakerModelo.HabilitaBotoesEdicao(Valor: Boolean = True);
begin
  BtnModificar.Enabled := not Valor;
  BtnRefresh.Enabled   := not Valor;
  BtnSalvar.Enabled    := Valor;
  BtnDesistir.Enabled  := Valor;
end;

procedure TFormXMakerModelo.FormShow(Sender: TObject);
begin
  Inicializa;
end;

function TFormXMakerModelo.AbreTabelas: Boolean;
begin
  {07-Início do Bloco X-Maker. Modificações não serão preservadas}
  Result := True;
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
end;

procedure TFormXMakerModelo.FechaTabelas;
begin
  try
    if not TabelaPrincipal.Open_begin then
      TabelaPrincipal.Close;
  except
    on Erro: Exception do
    begin
      MessageDlg('Erro: ' + Erro.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TFormXMakerModelo.CamposCalculados;
begin
  {08-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
end;

procedure TFormXMakerModelo.BotoesManutencao(Habilita: Boolean);
begin
  BtnModificar.Enabled := Habilita;
  BtnTabela.Enabled    := Habilita;
  BtnRefresh.Enabled   := Habilita;
end;

procedure TFormXMakerModelo.HabilitaEdicao(Habilita: Boolean = true);
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
  for I := 0 to 10 do
  begin
    Comp := FindComponent('Pagina' + IntToStr(I));
    if Comp <> nil then
      TScrollBox(Comp).Enabled := Habilita;
  end;
  if TabelaPrincipal.Inclusao or TabelaPrincipal.Modificacao then
    BotoesManutencao(False)
  else
    BotoesManutencao(True);
  HabilitaCamposEdicao(ListaCamposED, Habilita);
  if Habilita then
    for I:=0 to ListaCamposED.Count-1 do
      if PosicionaFoco(I) then
        break;
end;

function TFormXMakerModelo.ConfirmaInclusao: Boolean;
begin
  Result := True;
end;

function TFormXMakerModelo.ConfirmaModificacao: Boolean;
begin
  Result := True;
end;

function TFormXMakerModelo.ConfirmaExclusao: Boolean;
begin
  Result := True;
end;

function TFormXMakerModelo.ConfirmaGravacao: Boolean;
begin
  Result := True;
end;

procedure TFormXMakerModelo.TelaManutencao;
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

procedure TFormXMakerModelo.TelaConsulta;
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

procedure TFormXMakerModelo.AtribuiValoresPadrao;
begin
  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd, True);
  TabelaPrincipal.AtribuiRelacionamentos;

end;

procedure TFormXMakerModelo.AntesdeSalvar;
begin

end;

procedure TFormXMakerModelo.AntesdeIncluir;
begin

end;

procedure TFormXMakerModelo.AntesdeModificar;
begin

end;

procedure TFormXMakerModelo.AntesdeExcluir;
begin

end;

procedure TFormXMakerModelo.DepoisdeIncluir;
begin

end;

procedure TFormXMakerModelo.DepoisdeModificar;
begin

end;

procedure TFormXMakerModelo.DepoisdeExcluir;
begin

end;

procedure TFormXMakerModelo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if BtnSalvar.Enabled then
    TabelaPrincipal.Cancela;
end;

procedure TFormXMakerModelo.FormClose(Sender: TObject;
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

procedure TFormXMakerModelo.StatusTabela;
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

procedure TFormXMakerModelo.FormActivate(Sender: TObject);
begin
  if TabelaPrincipal.Inclusao or TabelaPrincipal.Modificacao then
    BotoesManutencao(False)
  else
    BotoesManutencao(True);
end;

procedure TFormXMakerModelo.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormXMakerModelo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
    if Key = 76 then  // Ctrl + L -> Localizar
      BtnLocalizarClick(Self)
    else if Key = 73 then // Ctrl + I -> Incluir
      BtnIncluirClick(Self)
    else if Key = 77 then // Ctrl + M -> Modificar
      BtnModificarClick(Self)
    else if Key = 69 then // Ctrl + E -> Excluir
      BtnExcluirClick(Self);
end;

procedure TFormXMakerModelo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calendário
    Interno108
  else if Key = VK_F6 then // Calculadora
    Interno109
  else if Key = VK_F7 then // Agenda
    Interno110;
end;

procedure TFormXMakerModelo.BtnTabelaClick(Sender: TObject);
begin
  if BtnTabela.Tag = 0 then
    TelaConsulta
  else
    TelaManutencao;
  StatusTabela;
end;

procedure TFormXMakerModelo.BtnIncluirClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnModificarClick(Sender: TObject);
begin
  if TabelaPrincipal.Eof then
  begin
    TabelaPrincipal.Prior;
    TabelaPrincipal.Next;
  end;
  if TabelaPrincipal.Eof then
  begin
    MessageDlg('Registro não encontrado !',mtError,[mbOk],0);
    exit;
  end;
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'M') then
  begin
    MessageDlg('Modificação não Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if Not ConfirmaModificacao then
  begin
    MessageDlg('Modificação Cancelada !',mtError,[mbOk],0);
    exit;
  end;
  if TabelaPrincipal.Inclusao then
  begin
    MessageDlg('Operação de Inclusão está Ativa !',mtError,[mbOk],0);
    exit;
  end
  else if TabelaPrincipal.Modificacao then
  begin
    MessageDlg('Operação de Modificação já Ativa !',mtError,[mbOk],0);
    exit;
  end;
  DesabilitaCamposChave(ListaCamposEd);
  TabPaginas.TabIndex:= 0;
  TelaManutencao;
  Screen.Cursor := crHourGlass;
  try
    AntesdeModificar;
    TabelaPrincipal.Modifica;
    HabilitaEdicao;
  finally
    Screen.Cursor := crDefault;
  end;
  BtnSalvar.Enabled   := True;
  BtnDesistir.Enabled := True;
  StatusTabela;
end;

procedure TFormXMakerModelo.BtnExcluirClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnLocalizarClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnPrimeiroClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnAnteriorClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnProximoClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnUltimoClick(Sender: TObject);
begin
  //
end;

procedure TFormXMakerModelo.BtnRefreshClick(Sender: TObject);
begin
  if MessageDlg('Atualizar registros?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaPrincipal.AtualizaSql;
    if PageForm.PageIndex = 0 then
      TelaManutencao;
  end;
end;

procedure TFormXMakerModelo.BtnSalvarClick(Sender: TObject);
Var
  EInclusao, Ok: Boolean;
begin
  if Not ConfirmaGravacao then
  begin
    MessageDlg('Gravação Cancelada !',mtError,[mbOk],0);
    exit;
  end;
  SalvarRegistro := True;
  if CamposDadosValidos(ListaCamposEd, ErroValidacao) then  // Validações Ok ?!
  begin
    EInclusao := TabelaPrincipal.Inclusao;
    Screen.Cursor := crHourGlass;
    try
      Ok := False;
      if EInclusao then
        if TabelaPrincipal.PesquisaRelacionados(TabelaPrincipal.NomeTabela) then
        begin
          ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd, False, True);
          if TabelaPrincipal.PesquisaRelacionados(TabelaPrincipal.NomeTabela) then
          begin
            MessageDlg('Duplicidade - Registro já cadastrado !',mtWarning,[mbOk],0);
            exit;
          end;
        end;
      AntesdeSalvar;
      if TabelaPrincipal.Salva then
        Ok := True;
    finally
      if Ok then
        if EInclusao then
          DepoisdeIncluir
        else
          DepoisdeModificar;
      Screen.Cursor := crDefault;
    end;
    if Ok then
    begin
      BtnSalvar.Enabled   := False;
      BtnDesistir.Enabled := False;
      ErroValidacao       := False;
      TabPaginas.TabIndex := 0;
      HabilitaEdicao(False);
    end;
  end;
  SalvarRegistro := False;
  StatusTabela;
end;

procedure TFormXMakerModelo.BtnDesistirClick(Sender: TObject);
begin
  if TabelaPrincipal.Inclusao then
    TabelaPrincipal.ExclusaoCascata;
  TabelaPrincipal.Cancela;
  BtnSalvar.Enabled   := False;
  BtnDesistir.Enabled := False;
  ErroValidacao       := False;
  TabPaginas.TabIndex := 0;
  HabilitaEdicao(False);
  Navegando := False;
  StatusTabela;
end;

procedure TFormXMakerModelo.VerificaAtualizacoes;
begin
  if not BtnSalvar.Enabled then
    BtnDesistirClick(Self)
  else
    if MessageDlg('Salvar Registro ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      BtnSalvarClick(Self)
    else
      BtnDesistirClick(Self);
end;

procedure TFormXMakerModelo.mnu_FiltrarClick(Sender: TObject);
begin
  Ed_Filtrar(TabelaPrincipal, FormXMakerModelo, GridConsulta);
  StatusTabela;
  if PageForm.PageIndex = 0 then
    TelaManutencao;
end;

procedure TFormXMakerModelo.mnu_OrdenarClick(Sender: TObject);
begin
  Ed_Ordenar(TabelaPrincipal, FormXMakerModelo, GridConsulta);
  StatusTabela;
  if PageForm.PageIndex = 0 then
    TelaManutencao;
end;

procedure TFormXMakerModelo.mnu_OrdenarCompostoClick(Sender: TObject);
begin
  Ed_OrdenarComposto(TabelaPrincipal, FormXMakerModelo, GridConsulta);
  StatusTabela;
  if PageForm.PageIndex = 0 then
    TelaManutencao;
end;

procedure TFormXMakerModelo.mnu_ApagarColunaClick(Sender: TObject);
begin
  Ed_ApagarColuna(TabelaPrincipal, FormXMakerModelo, GridConsulta);
end;

procedure TFormXMakerModelo.mnu_QuantificarClick(Sender: TObject);
begin
  Ed_Quantificar(TabelaPrincipal, FormXMakerModelo, GridConsulta);
end;

procedure TFormXMakerModelo.mnu_TotalizarColunaClick(Sender: TObject);
begin
  Ed_TotalizarColuna(TabelaPrincipal, FormXMakerModelo, GridConsulta);
end;

procedure TFormXMakerModelo.mnu_CalcularMediaClick(Sender: TObject);
begin
  Ed_CalcularMedia(TabelaPrincipal, FormXMakerModelo, GridConsulta);
end;

procedure TFormXMakerModelo.mnu_ImprimirClick(Sender: TObject);
begin
  Ed_Imprimir(TabelaPrincipal, FormXMakerModelo, GridConsulta, DataSource);
end;

procedure TFormXMakerModelo.mnu_SalvarConsultaClick(Sender: TObject);
begin
  Ed_SalvarConsulta(TabelaPrincipal, FormXMakerModelo, GridConsulta, AbaConsulta, ConsultasSalvas);
end;

procedure TFormXMakerModelo.mnu_ExcluirConsultaClick(Sender: TObject);
begin
  Ed_ExcluirConsulta(TabelaPrincipal, FormXMakerModelo, GridConsulta, AbaConsulta, ConsultasSalvas);
end;

procedure TFormXMakerModelo.AbaConsultaClick(Sender: TObject);
begin
  Ed_AbaConsulta(TabelaPrincipal, AbaConsulta, ConsultasSalvas, GridConsulta);
  StatusTabela;
end;

procedure TFormXMakerModelo.TabPaginasClick(Sender: TObject);
begin
  if NoManutencao.PageIndex <> TabPaginas.TabIndex then
    NoManutencao.SetFocus;
  NoManutencao.PageIndex := TabPaginas.TabIndex;
end;

procedure TFormXMakerModelo.PosicionaNoCampo(Campo: TAtributo);
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

procedure TFormXMakerModelo.ErroValidacaoCampo(MsgErro: String; Campo: TAtributo);
begin
  MessageDlg(MsgErro, mtError, [mbOk], 0);
  ErroValidacao := True;
  PosicionaNoCampo(Campo);
end;

procedure TFormXMakerModelo.MudaSeForUltimo;
begin
  if (NoManutencao.PageIndex <> NoManutencao.Pages.Count - 1) and
     (ActiveControl = BtnSalvar) then
    if TabPaginas.TabIndex + 1 <= TabPaginas.Tabs.Count-1 then
      TabPaginas.TabIndex := TabPaginas.TabIndex + 1;
end;

procedure TFormXMakerModelo.CortarImagemClick(Sender: TObject);
begin
  if ActiveControl is TDBImage then
    TDBImage(ActiveControl).CutToClipBoard;
end;

procedure TFormXMakerModelo.CopiarImagemClick(Sender: TObject);
begin
  if ActiveControl is TDBImage then
    TDBImage(ActiveControl).CopyToClipBoard;
end;

procedure TFormXMakerModelo.ColarImagemClick(Sender: TObject);
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

procedure TFormXMakerModelo.AbrirImagemClick(Sender: TObject);
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

procedure TFormXMakerModelo.SalvarImagemClick(Sender: TObject);
begin
  if DlgSalvarComoImagem.Execute and (ActiveControl is TDBImage) then
    TDBImage(ActiveControl).Picture.SaveToFile(DlgSalvarComoImagem.FileName);
end;

function TFormXMakerModelo.AbandonandoEdicao: Boolean;
begin
  Result := (ActiveControl = BtnDesistir);
end;

procedure TFormXMakerModelo.ChamaGridPesquisa(Sender: TObject);
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

procedure TFormXMakerModelo.ValidaColunaGrid(Sender: TField);
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

{11-Início do Bloco X-Maker. Modificações não serão preservadas}
{99-Final do Bloco X-Maker. Modificações não serão preservadas}

procedure TFormXMakerModelo.GridConsultaDblClick(Sender: TObject);
begin
  BtnModificarClick(Self);
end;

end.
