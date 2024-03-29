{
   Programa.: XMakerModelo.PAS
   Copyright: Modular Software 2006
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
    PagePrincipal: TPageControl;
    TabManutencao: TTabSheet;
    TabConsulta: TTabSheet;
    PnSalva: TPanel;
    PnSup: TPanel;
    ShapeSup: TShape;
    TabPaginas: TTabSet;
    PnInfConsulta: TPanel;
    GridConsulta: TDBGrid;
    DataSource: TDataSource;
    LbTituloForm: TLabel;
    BtnAjuda: TSpeedButton;
    BtnFechar: TSpeedButton;
    PgPagina1: TScrollBox;
    BtnSalvar: TBitBtn;
    BtnDesistir: TBitBtn;
    AbaConsulta: TTabSet;
    PopConsulta: TPopupMenu;
    mnu_Filtrar: TMenuItem;
    mnu_Ordenar: TMenuItem;
    mnu_OrdenarComposto: TMenuItem;
    N1: TMenuItem;
    mnu_ApagarColuna: TMenuItem;
    N2: TMenuItem;
    mnu_TotalizarColuna: TMenuItem;
    mnu_CalcularMedia: TMenuItem;
    N3: TMenuItem;
    mnu_Imprimir: TMenuItem;
    mnu_SalvarConsulta: TMenuItem;
    mnu_ExcluirConsulta: TMenuItem;
    NoManutencao: TNotebook;
    Pagina0: TScrollBox;
    Pagina1: TScrollBox;
    Pagina2: TScrollBox;
    Pagina3: TScrollBox;
    Pagina4: TScrollBox;
    Pagina5: TScrollBox;
    Pagina6: TScrollBox;
    Pagina7: TScrollBox;
    Pagina8: TScrollBox;
    Pagina9: TScrollBox;
    Pagina10: TScrollBox;
    mnu_Quantificar: TMenuItem;
    {01-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
    {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
    MenuImagem: TPopupMenu;
    CortarImagem: TMenuItem;
    CopiarImagem: TMenuItem;
    ColarImagem: TMenuItem;
    MnSep01: TMenuItem;
    AbrirImagem: TMenuItem;
    SalvarImagem: TMenuItem;
    DlgSalvarComoImagem: TSaveDialog;
    DlgAbrirImagem: TOpenDialog;
    BarraPrincipal: TPanel;
    Gradiente: TPaintBox;
    BtnLocalizar: TSpeedButton;
    BtnIncluir: TSpeedButton;
    BtnModificar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnPrimeiro: TSpeedButton;
    BtnAnterior: TSpeedButton;
    BtnProximo: TSpeedButton;
    BtnUltimo: TSpeedButton;
    PopRelacionados: TPopupMenu;
    BtnRelac_1: TBitBtn;
    BtnRelac_2: TBitBtn;
    {02-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
    {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnDesistirClick(Sender: TObject);
    procedure GridConsultaDblClick(Sender: TObject);
    procedure PagePrincipalChange(Sender: TObject);
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
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnRelac_1Click(Sender: TObject);
    procedure PopRelacionadosClick(Sender: TObject);
    procedure ChamaGridPesquisa(Sender: TObject);
    procedure ValidaColunaGrid(Sender: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Navegando: Boolean;
    ListaCamposED: TListaCampos; {Conter� a lista de campos em edi��o na ED}
    TituloModulo: String;
    ConsultasSalvas: TList;
    PaginaIni: Integer;
    ErroValidacao: Boolean;
    SalvarRegistro: Boolean;
    procedure StatusTabela;
    function AbreTabelas: Boolean;
    procedure MudaSeForUltimo;
    function AbandonandoEdicao: Boolean;
    procedure TelaManutencao;
    procedure TelaConsulta;
    procedure AtribuiValoresPadrao;
    procedure PosicionaNoCampo(Campo: TAtributo);
    procedure VerificaAtualizacoes;
    procedure ErroValidacaoCampo(MsgErro: String; Campo: TAtributo);
    procedure Localizar(Sender: TObject);
    procedure Incluir(Sender: TObject);
    procedure Modificar(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Primeiro(Sender: TObject);
    procedure Anterior(Sender: TObject);
    procedure Proximo(Sender: TObject);
    procedure Ultimo(Sender: TObject);
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
    procedure HabilitaEdicao(Valor: Boolean = true);
  public
    { Public declarations }
    {03-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
    {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
    TabelaPrincipal: TTabela;
    {04-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
    {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
  end;

var
  FormXMakerModelo: TFormXMakerModelo;
  LastControl: TWinControl;

implementation

{$R *.DFM}

uses Publicas, Princ, Rotinas, RotinaEd, Abertura, GridPesquisa, Interno;

procedure TFormXMakerModelo.FormShow(Sender: TObject);
Var
  I: Integer;
begin
  {05-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
  {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
  Navegando          := False;
  DataSource.DataSet := TabelaPrincipal;
  ListaCamposED      := TListaCampos.Create;
  ConsultasSalvas    := TList.Create;
  PaginaIni          := 0;
  ErroValidacao      := False;
  TabPaginas.TabIndex:= 0;
  {06-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
  {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
  CamposCalculados;
  if not AbreTabelas then exit;
  AjustaColunasConsulta(TabelaPrincipal);
  TabelaPrincipal.AtualizaSql;
  StatusTabela;
  TabelaPrincipal.First;
  FormResize(Self);
  BtnSalvar.Enabled   := False;
  BtnDesistir.Enabled := False;
  InicializaConsultasSalvas(TabelaPrincipal, AbaConsulta, ConsultasSalvas);
  PagePrincipal.ActivePageIndex := 1;
  NoManutencao.PageIndex        := 0;
  PagePrincipal.OnChange        := PagePrincipalChange;
  BtnAjuda.Visible  := False;
  BtnFechar.Visible := False;
  TelaConsulta;
  GridConsulta.SetFocus;
end;

function TFormXMakerModelo.AbreTabelas: Boolean;
begin
  {07-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
  Result := True;
  {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
end;

procedure TFormXMakerModelo.CamposCalculados;
begin
  {08-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
  {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
end;

procedure TFormXMakerModelo.HabilitaEdicao(Valor: Boolean = true);
var
  I: Integer;
  Comp: TComponent;
  CampoED: TCampoEdicao;
begin
  for I := 0 to 10 do
  begin
    Comp := FindComponent('Pagina' + IntToStr(I));
    if Comp <> nil then
      TScrollBox(Comp).Enabled := Valor;
  end;
  if Valor then
    for I:=0 to ListaCamposED.Count-1 do
    begin
      CampoED := TCampoEdicao(ListaCamposED[I]);
      if (CampoED.Controle.TabOrder = 0) and (CampoED.Controle.CanFocus) then
      begin
        CampoED.Controle.SetFocus;
        Break;
      end;
    end;
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
  if (TabelaPrincipal.Inclusao) or
     (TabelaPrincipal.Modificacao) then
    HabilitaEdicao
  else
    HabilitaEdicao(False);
  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);
  TabelaPrincipal.AtribuiRelacionamentos;

end;

procedure TFormXMakerModelo.TelaConsulta;
begin
  HabilitaEdicao(False);

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
  //TabelaPrincipal.AtribuiRelacionamentos(False); // Habilite esta op��o caso seja realmente necess�rio...
  ListaCamposED.Free;
  for I := 0 to ConsultasSalvas.Count - 1 do
    TConsultasSalvas(ConsultasSalvas[I]).Free;
  ConsultasSalvas.Free;
end;

procedure TFormXMakerModelo.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormXMakerModelo.BtnAjudaClick(Sender: TObject);
begin
  application.helpcommand(Help_Finder,HelpContext);
end;

procedure TFormXMakerModelo.StatusTabela;
begin
  LbTituloForm.Caption := TituloModulo + '- [ Ordem: '+TabelaPrincipal.TituloIndice+' ]';
end;

procedure TFormXMakerModelo.FormResize(Sender: TObject);
begin
  BtnAjuda.Left  := ShapeSup.Width - 37;
  BtnFechar.Left := ShapeSup.Width - 19;
end;

procedure TFormXMakerModelo.FormActivate(Sender: TObject);
begin
  BtnLocalizar.OnClick := Localizar;
  BtnIncluir.OnClick   := Incluir;
  BtnModificar.OnClick := Modificar;
  BtnExcluir.OnClick   := Excluir;
  BtnPrimeiro.OnClick  := Primeiro;
  BtnAnterior.OnClick  := Anterior;
  BtnProximo.OnClick   := Proximo;
  BtnUltimo.OnClick    := Ultimo;
  Gradiente.OnPaint    := FormPrincipal.GradientePaint;
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
  end
  else if Key = Chr(27) then
    Close;
end;

procedure TFormXMakerModelo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
    if Key = 76 then  // Ctrl + L -> Localizar
      Localizar(Self)
    else if Key = 73 then // Ctrl + I -> Incluir
      Incluir(Self)
    else if Key = 77 then // Ctrl + M -> Modificar
      Modificar(Self)
    else if Key = 69 then // Ctrl + E -> Excluir
      Excluir(Self);
end;

procedure TFormXMakerModelo.BtnSalvarClick(Sender: TObject);
Var
  EInclusao, Ok: Boolean;
begin
  if Not ConfirmaGravacao then
  begin
    MessageDlg('Grava��o Cancelada !',mtError,[mbOk],0);
    exit;
  end;
  SalvarRegistro := True;
  if CamposDadosValidos(ListaCamposEd, ErroValidacao) then  // Valida��es Ok ?!
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
            MessageDlg('Duplicidade - Registro j� cadastrado !',mtWarning,[mbOk],0);
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
    BtnSalvar.Enabled   := False;
    BtnDesistir.Enabled := False;
    PagePrincipal.ActivePageIndex := 1;
    TelaConsulta;
    if EInclusao then
    begin
      if not Sistema.Rede then
      begin
        TabelaPrincipal.AtualizaSql;
        StatusTabela;
      end;
      Ultimo(Self);
    end;
    ErroValidacao := False;
    GridConsulta.SetFocus;
  end;
  SalvarRegistro := False;
end;

procedure TFormXMakerModelo.BtnDesistirClick(Sender: TObject);
begin
  if TabelaPrincipal.Inclusao then
    TabelaPrincipal.ExclusaoCascata;
  TabelaPrincipal.Cancela;
  BtnSalvar.Enabled   := False;
  BtnDesistir.Enabled := False;
  ErroValidacao       := False;
  if not Navegando then
  begin
    PagePrincipal.ActivePageIndex := 1;
    TelaConsulta;
    GridConsulta.SetFocus;
  end
  else
    HabilitaEdicao(False);
  Navegando := False;
end;

procedure TFormXMakerModelo.GridConsultaDblClick(Sender: TObject);
begin
  if TabelaPrincipal.Eof then
    Incluir(Self)
  else
    Modificar(Self);
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

procedure TFormXMakerModelo.Localizar(Sender: TObject);
begin
  Ed_Localizar(TabelaPrincipal, FormXMakerModelo, GridConsulta);
end;

procedure TFormXMakerModelo.Incluir(Sender: TObject);
begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'I') then
  begin
    MessageDlg('Inclus�o n�o Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if Not ConfirmaInclusao then
  begin
    MessageDlg('Inclus�o Cancelada !',mtError,[mbOk],0);
    exit;
  end;
  if TabelaPrincipal.Inclusao then
  begin
    MessageDlg('Opera��o de Inclus�o j� Ativa !',mtError,[mbOk],0);
    exit;
  end
  else if TabelaPrincipal.Modificacao then
  begin
    MessageDlg('Opera��o de Modifica��o est� Ativa !',mtError,[mbOk],0);
    exit;
  end;
  HabilitaCamposChave(ListaCamposEd);
  PagePrincipal.ActivePageIndex := 0;
  TabPaginas.TabIndex:= 0;
  TelaManutencao;
  AntesdeIncluir;
  TabelaPrincipal.Inclui(ListaCamposED);
  BtnSalvar.Enabled   := True;
  BtnDesistir.Enabled := True;
  HabilitaEdicao;
  AtribuiValoresPadrao;
end;

procedure TFormXMakerModelo.Modificar(Sender: TObject);
begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'M') then
  begin
    MessageDlg('Modifica��o n�o Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if Not ConfirmaModificacao then
  begin
    MessageDlg('Modifica��o Cancelada !',mtError,[mbOk],0);
    exit;
  end;
  if TabelaPrincipal.Inclusao then
  begin
    MessageDlg('Opera��o de Inclus�o est� Ativa !',mtError,[mbOk],0);
    exit;
  end
  else if TabelaPrincipal.Modificacao then
  begin
    MessageDlg('Opera��o de Modifica��o j� Ativa !',mtError,[mbOk],0);
    exit;
  end;
  DesabilitaCamposChave(ListaCamposEd);
  PagePrincipal.ActivePageIndex := 0;
  TabPaginas.TabIndex:= 0;
  TelaManutencao;
  Screen.Cursor := crHourGlass;
  try
    if Sistema.Rede then
      TabelaPrincipal.Refresh;
    AntesdeModificar;
    TabelaPrincipal.Modifica;
    HabilitaEdicao;
  finally
    Screen.Cursor := crDefault;
  end;
  BtnSalvar.Enabled   := True;
  BtnDesistir.Enabled := True;
end;

procedure TFormXMakerModelo.Excluir(Sender: TObject);
begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'E') then
  begin
    MessageDlg('Exclus�o n�o Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if Not ConfirmaExclusao then
  begin
    MessageDlg('Exclus�o Cancelada !',mtError,[mbOk],0);
    exit;
  end;
  if TabelaPrincipal.Inclusao then
  begin
    MessageDlg('Opera��o de Inclus�o est� Ativa !'+^M+^M+'Clique em Desistir para Cancelar Inclus�o ...',mtError,[mbOk],0);
    exit;
  end
  else if TabelaPrincipal.Modificacao then
  begin
    MessageDlg('Opera��o de Modifica��o est� Ativa !',mtError,[mbOk],0);
    exit;
  end;
  if MessageDlg('Excluir Registro ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Screen.Cursor := crHourGlass;
    try
      if Sistema.Rede then
        TabelaPrincipal.Refresh;
      AntesdeExcluir;
      TabelaPrincipal.Exclui;
    finally
      DepoisdeExcluir;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFormXMakerModelo.Primeiro(Sender: TObject);
begin
  Navegando := True;
  VerificaAtualizacoes;
  if not ErroValidacao then
  begin
    Screen.Cursor := crHourGlass;
    try
      if Sistema.Rede then
      begin
        TabelaPrincipal.AtualizaSql;
        StatusTabela;
      end;
      TabelaPrincipal.First;
      if PagePrincipal.ActivePageIndex = 0 then
        TelaManutencao;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFormXMakerModelo.Anterior(Sender: TObject);
begin
  Navegando := True;
  VerificaAtualizacoes;
  if not ErroValidacao then
  begin
    TabelaPrincipal.Prior;
    if PagePrincipal.ActivePageIndex = 0 then
      TelaManutencao;
  end;
end;

procedure TFormXMakerModelo.Proximo(Sender: TObject);
begin
  Navegando := True;
  VerificaAtualizacoes;
  if not ErroValidacao then
  begin
    TabelaPrincipal.Next;
    if PagePrincipal.ActivePageIndex = 0 then
      TelaManutencao;
  end;
end;

procedure TFormXMakerModelo.Ultimo(Sender: TObject);
begin
  Navegando := True;
  VerificaAtualizacoes;
  if not ErroValidacao then
  begin
    try
      if Sistema.Rede then
      begin
        TabelaPrincipal.AtualizaSql;
        StatusTabela;
      end;
      TabelaPrincipal.Last;
      if TabelaPrincipal.Eof then
      begin
        TabelaPrincipal.Prior;
        TabelaPrincipal.Next;
      end;
      if PagePrincipal.ActivePageIndex = 0 then
        TelaManutencao;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFormXMakerModelo.mnu_FiltrarClick(Sender: TObject);
begin
  Ed_Filtrar(TabelaPrincipal, FormXMakerModelo, GridConsulta);
  StatusTabela;
end;

procedure TFormXMakerModelo.mnu_OrdenarClick(Sender: TObject);
begin
  Ed_Ordenar(TabelaPrincipal, FormXMakerModelo, GridConsulta);
  StatusTabela;
end;

procedure TFormXMakerModelo.mnu_OrdenarCompostoClick(Sender: TObject);
begin
  Ed_OrdenarComposto(TabelaPrincipal, FormXMakerModelo, GridConsulta);
  StatusTabela;
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

procedure TFormXMakerModelo.PagePrincipalChange(Sender: TObject);
begin
  if PagePrincipal.ActivePageIndex = 0 then
  begin
    TabPaginas.TabIndex := PaginaIni;
    TelaManutencao;
  end
  else if PagePrincipal.ActivePageIndex = 1 then
  begin
    VerificaAtualizacoes;
    if Not ErroValidacao then
    begin
      TelaConsulta;
      GridConsulta.SetFocus;
    end
    else
      PagePrincipal.ActivePageIndex := 0;
  end;
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
  PagePrincipal.ActivePageIndex := 0;
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
      MessageDlg('Formato Inv�lido !', mtError, [mbOk], 0);
      TDBImage(ActiveControl).DataSource.DataSet.Cancel;
    end;
  end
  else
    MessageDlg('�rea de Transfer�ncia n�o cont�m imagem !', mtError, [mbOk], 0);
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
  Result := (ActiveControl = BtnDesistir) or (ActiveControl = PagePrincipal);
end;

procedure TFormXMakerModelo.BtnRelac_1Click(Sender: TObject);
var
  Pt: TPoint;

  procedure AddMenuItem(Menu:TPopupMenu; ItemName:string; Name:string; Enable:Boolean; ImgIndex: Integer; Tag: Integer);
  var
    NewMenuItem: TMenuItem;
  begin
    NewMenuItem         := TMenuItem.Create(Application);
    NewMenuItem.Name    := Name;
    NewMenuItem.Caption := ItemName;
    NewMenuItem.Enabled := Enable;
    NewMenuItem.OnClick := PopRelacionadosClick;
    NewMenuItem.Tag     := Tag;
    if ImgIndex <> -1 then
      NewMenuItem.ImageIndex := ImgIndex;
    Menu.Items.Add(NewMenuItem);
  end;

begin
  PopRelacionados.Items.Clear;
  {09-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
  {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
  GetCursorPos(Pt);
  PopRelacionados.Popup(Pt.X, Pt.Y);
end;

procedure TFormXMakerModelo.PopRelacionadosClick(Sender: TObject);
var
  MenuItem: TMenuItem;
begin
  MenuItem := TMenuItem(Sender);
  {10-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
  {99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}
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

{11-In�cio do Bloco Modular. Modifica��es n�o ser�o preservadas}
{99-Final do Bloco Modular. Modifica��es n�o ser�o preservadas}

procedure TFormXMakerModelo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calend�rio
    Interno108
  else if Key = VK_F6 then // Calculadora
    Interno109
  else if Key = VK_F7 then // Agenda
    Interno110;
end;

end.
