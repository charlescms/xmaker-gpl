{
 Empresa....: %EMPRESA
 Módulo.....: %MODULO
 Sistema....: %TITULO
 Data.......: %DATA
 Versão.....: %VERSAOPROJETO
 Analista...: %ANALISTA
 Programador: %PROGRAMADOR
 Criação....: %VERSAOGERADOR
}
unit Princ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, Menus, Buttons, ExtCtrls, StdCtrls, Extras, Jpeg, ImgList,
  IniFiles, XPMenu, XBanner;

type
  TFormPrincipal = class(TForm)
    ListaImagem: TImageList;
    StatusBarPrincipal: TStatusBar;
    SetupImpressora: TPrinterSetupDialog;
    MenuPrincipal: TMainMenu;
    BarraPrincipal: TPanel;
    BtnLocalizar: TSpeedButton;
    BtnIncluir: TSpeedButton;
    BtnModificar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    PnLateral1: TPanel;
    Divisor: TSplitter;
    PnOpcoes: TPanel;
    ShapeOpcoes: TShape;
    PnTitulo: TPanel;
    TreeOpcoes: TTreeView;
    PnLateral2: TPanel;
    PnImagemFundo: TPanel;
    ImagemFundo: TImage;
    BtnPrimeiro: TSpeedButton;
    BtnAnterior: TSpeedButton;
    BtnProximo: TSpeedButton;
    BtnUltimo: TSpeedButton;
    BtnMinimiza: TSpeedButton;
    {01-Início do Bloco X-Maker. Modificações não serão preservadas}
    Mnu_1: TMenuItem;
    Mnu_2: TMenuItem;
    Mnu_3: TMenuItem;
    Mnu_4: TMenuItem;
    Mnu_5: TMenuItem;
    Mnu_6: TMenuItem;
    Mnu_7: TMenuItem;
    Mnu_8: TMenuItem;
    Mnu_9: TMenuItem;
    Mnu_10: TMenuItem;
    Mnu_11: TMenuItem;
    Mnu_12: TMenuItem;
    Mnu_13: TMenuItem;
    Mnu_14: TMenuItem;
    Mnu_15: TMenuItem;
    Mnu_16: TMenuItem;
    Mnu_17: TMenuItem;
    Manutencao: TMenuItem;
    Localizar: TMenuItem;
    Incluir: TMenuItem;
    Modificar: TMenuItem;
    Excluir: TMenuItem;
    Mnu_23: TMenuItem;
    Primeiro: TMenuItem;
    Anterior: TMenuItem;
    Proximo: TMenuItem;
    Ultimo: TMenuItem;
    Consulta: TMenuItem;
    Filtrar: TMenuItem;
    Ordenar: TMenuItem;
    OrdenarComposto: TMenuItem;
    Mnu_32: TMenuItem;
    ApagarColuna: TMenuItem;
    Mnu_34: TMenuItem;
    Quantificar: TMenuItem;
    TotalizarColuna: TMenuItem;
    CalcularMedia: TMenuItem;
    Mnu_38: TMenuItem;
    Imprimir: TMenuItem;
    SalvarConsulta: TMenuItem;
    ExcluirConsulta: TMenuItem;
    mnu_Janelas: TMenuItem;
    Mnu_43: TMenuItem;
    Mnu_44: TMenuItem;
    Mnu_45: TMenuItem;
    Mnu_46: TMenuItem;
    Mnu_47: TMenuItem;
    Mnu_48: TMenuItem;
    Mnu_49: TMenuItem;
    Mnu_50: TMenuItem;
    Mnu_51: TMenuItem;
    Mnu_52: TMenuItem;
    Bar_2: TToolButton;
    Bar_3: TToolButton;
    Bar_4: TToolButton;
    Bar_5: TToolButton;
    Bar_6: TToolButton;
    Bar_7: TToolButton;
    Bar_8: TToolButton;
    Bar_9: TToolButton;
    {99-Final do Bloco X-Maker. Modificações não serão preservadas}
    PnLista1: TPanel;
    PnLista2: TPanel;
    BarraFerramentas: TToolBar;
    TreeMenuSup: TTreeView;
    procedure ShowHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject;
      var Action: TCloseAction);
    procedure PnOpcoesResize(Sender: TObject);
    procedure TreeOpcoesClick(Sender: TObject);
    procedure TreeOpcoesKeyPress(Sender: TObject; var Key: Char);
    {02-Início do Bloco X-Maker. Modificações não serão preservadas}
    procedure Mnu_2Click(Sender: TObject);
    procedure Mnu_3Click(Sender: TObject);
    procedure Mnu_5Click(Sender: TObject);
    procedure Mnu_6Click(Sender: TObject);
    procedure Mnu_7Click(Sender: TObject);
    procedure Mnu_8Click(Sender: TObject);
    procedure Mnu_10Click(Sender: TObject);
    procedure Mnu_12Click(Sender: TObject);
    procedure Mnu_13Click(Sender: TObject);
    procedure Mnu_14Click(Sender: TObject);
    procedure Mnu_15Click(Sender: TObject);
    procedure Mnu_17Click(Sender: TObject);
    procedure Mnu_43Click(Sender: TObject);
    procedure Mnu_44Click(Sender: TObject);
    procedure Mnu_45Click(Sender: TObject);
    procedure Mnu_46Click(Sender: TObject);
    procedure Mnu_47Click(Sender: TObject);
    procedure Mnu_49Click(Sender: TObject);
    procedure Mnu_50Click(Sender: TObject);
    procedure Mnu_52Click(Sender: TObject);
    procedure Bar_2Click(Sender: TObject);
    procedure Bar_4Click(Sender: TObject);
    procedure Bar_5Click(Sender: TObject);
    procedure Bar_6Click(Sender: TObject);
    procedure Bar_7Click(Sender: TObject);
    procedure Bar_9Click(Sender: TObject);
    {99-Final do Bloco X-Maker. Modificações não serão preservadas}
    procedure GradientePaint(Sender: TObject);
    procedure BtnMinimizaClick(Sender: TObject);
  private
    { Declarações Privadas }
    {10-Início do Bloco X-Maker. Modificações não serão preservadas}
    {99-Final do Bloco X-Maker. Modificações não serão preservadas}
  protected
    { Declarações Protegidas }
  public
    { Declarações Públicas }
    ErronoSistema: Boolean;
    procedure FechaJanelasFilhas;
  end;

var
  FormPrincipal: TFormPrincipal;
  HintBalao: THintDesign;
  MenuXP: TXPMenu;
  XBanner_Lateral: TXBanner;
  Gradiente: TXBanner;

implementation

{$R *.DFM}
{$R *.RES}

uses Rotinas, Publicas, Splash, Interno,
     {20-Início do Bloco X-Maker. Modificações não serão preservadas}
     {99-Final do Bloco X-Maker. Modificações não serão preservadas}
     Acesso;

procedure TFormPrincipal.ShowHint(Sender: TObject);
begin
  Atualiza_Status;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
Var
  ArqIni: TIniFile;
begin
  {
    Inicializa variáveis públicas e ambiente de trabalho
  }
  DateSeparator       := '/';
  ShortDateFormat     := Sistema.EstiloData;
  Application.OnHint  := ShowHint;
  Caption             := Sistema.Titulo;
  if not Sistema.SelecionaUsr then
  begin
    ErronoSistema       := False;
    ArqIni              := TInifile.Create(Sistema.Pasta + 'SYSEMP.DAT');
    Sistema.EmpresaUsr  := ArqIni.ReadString('EMPRESA 00', 'Nome', '');
    Sistema.EnderecoUsr := ArqIni.ReadString('EMPRESA 00', 'Endereco', '');
    Sistema.BairroUsr   := ArqIni.ReadString('EMPRESA 00', 'Bairro', '');
    Sistema.CidadeUsr   := ArqIni.ReadString('EMPRESA 00', 'Cidade', '');
    Sistema.UfUsr       := ArqIni.ReadString('EMPRESA 00', 'UF', '');
    Sistema.CEPUsr      := ArqIni.ReadString('EMPRESA 00', 'CEP', '');
    Sistema.CNPJUsr     := ArqIni.ReadString('EMPRESA 00', 'CNPJ', '');
    Sistema.IEUsr       := ArqIni.ReadString('EMPRESA 00', 'Inscricao', '');
    Sistema.FonesUsr    := ArqIni.ReadString('EMPRESA 00', 'Fones', '');
    Sistema.LogoUsr     := ArqIni.ReadString('EMPRESA 00', 'Logo', '');
    ArqIni.Free;
  end;
  if (ErronoSistema) or (Sistema.ErroFatal) then
  begin
    Close;
    exit;
  end;

  Atualiza_Status;
  {
    Ajusta Barra de Ferramentas
  }
  BtnLocalizar.Visible   := False;
  BtnIncluir.Visible     := False;
  BtnModificar.Visible   := False;
  BtnExcluir.Visible     := False;
  BtnPrimeiro.Visible    := False;
  BtnAnterior.Visible    := False;
  BtnProximo.Visible     := False;
  BtnUltimo.Visible      := False;
  Manutencao.Enabled     := False;
  Consulta.Enabled       := False;
  {
    Define o ícone da aplicação
  }
  Application.Icon.Handle := LoadIcon(HInstance, 'ICONESISTEMA');
  Application.HelpFile    := Sistema.Pasta + 'Ajuda.Hlp';
  Application.Title       := Sistema.Titulo;
  {
    Controle de acesso habilitado ?
  }
  if Sistema.ControleAcesso then
  begin
    FormAcesso := TFormAcesso.Create(Application);
    try
      try
        FormAcesso.VerificaTabelas;
      except
        MessageDlg('Acesso Negado !', mtError, [mbOk], 0);
        ErronoSistema := True;
        Exit;
      end;
      FormAcesso.SenhaInicial := Sistema.SenhaInicial;
      FormAcesso.Tentativas   := 03;
      FormAcesso.QtdTentativas:= 01;
      FormAcesso.Liberacao    := False;
      if FormAcesso.ShowModal = mrCancel then
        ErronoSistema := True;
    finally
      FormAcesso.Free;
    end;
  end;
  {
    Erro no acesso ao sistema, cancela execução
  }
  if (ErronoSistema) or (Sistema.ErroFatal) then
  begin
    Close;
    exit;
  end;
  {
    Habilita/Desabilita opções de acesso ao usuário
  }
  Sistema.Menu  := TreeOpcoes;
  {
    Hint no estilo de balão ?
  }
  if Sistema.HintBalao then
  Begin
    HintBalao  := THintDesign.Create(Self);
    with HintBalao do
    begin
      Font.Charset := DEFAULT_CHARSET;
      Font.Color := clBlack;
      Font.Height := -13;
      Font.Name := 'Arial';
      Font.Style := [];
      Color := 14548735;
      Position := hiBottomRight;
      Shadow := True;
      ShadowQuality := quLow;
      ShadowIntensity := 70;
      ShadowWidth := 4;
      Delay := 500;
      HintStyle := hiRoundrect;
      linkStyle := liArrow;
      Border := True;
      BorderColor := clBlack;
      Loaded;
    end;
  End;
  XBanner_Lateral := TXBanner.Create(Self);
  with XBanner_Lateral do
  begin
    Parent       := FormPrincipal;
    Left         := 0;
    Top          := 56;
    Width        := 20;
    Height       := 253;
    Align        := alLeft;
    Alignment    := AtaLeftJustify;
    Angle        := 90;
    Caption      := '  ' + Sistema.Titulo;
    ColorOf      := clWhite;
    ColorFor     := clBlack;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color   := clWhite;
    Font.Height  := -13;
    Font.Name    := 'MS Sans Serif';
    Font.Style   := [fsBold];
    Horizontal   := True;
    ParentFont   := False;
    ShadeLTSet   := False;
    Style3D      := A3dNormal;
    if Sistema.BannerVertical then
      Visible := True
    else
      Visible := False;
  end;
  Gradiente := TXBanner.Create(Self);
  with Gradiente do
  begin
    Parent     := BarraPrincipal;
    Align      := alClient;
    Angle      := 0;
    ColorOf    := clNavy;
    ColorFor   := 15244408;
    Horizontal := True;
    ShadeLTSet := False;
    Style3D    := A3dNormal;
    SendToBack;
  end;
  {
    Menu no estilo do Windows XP ?
  }
  if Sistema.MenuXP then
  Begin
    MenuXP  := TXPMenu.Create(Self);
    with MenuXP do
    begin
      DimLevel := 30;
      GrayLevel := 10;
      Font.Charset := DEFAULT_CHARSET;
      Font.Color := clWindowText;
      Font.Height := -11;
      Font.Name := 'Tahoma';
      Font.Style := [];
      Color := clBtnFace;
      DrawMenuBar := False;
      IconBackColor := clBtnFace;
      MenuBarColor := clBtnFace;
      SelectColor := clHighlight;
      SelectBorderColor := clHighlight;
      SelectFontColor := clWindowText;
      DisabledColor := clInactiveCaption;
      SeparatorColor := clBtnFace;
      CheckedColor := clHighlight;
      IconWidth := 24;
      DrawSelect := True;
      UseSystemColors := True;
      UseDimColor := False;
      OverrideOwnerDraw := False;
      Gradient := False;
      FlatMenu := False;
      AutoDetect := False;
      XPContainers := [xccToolbar, xccCoolbar, xccControlbar];
      XPControls := [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar];
      Active := True;
    end;
  End;
  {
    Ajusta menu principal
  }
  if Sistema.MenuVertical then
  begin
    Sistema.Menu  := TreeOpcoes;
    TreeOpcoes.FullExpand;
    if TreeOpcoes.Items.Count > 0 then
      TreeOpcoes.Items[0].Selected := True;
    TreeOpcoes.SetFocus;
  end
  else
  begin
    PnOpcoes.Visible   := False;
    Divisor.Visible    := False;
    PnLateral1.Visible := False;
    PnLateral2.Visible := False;
  end;
  if Sistema.BarraF then
    BarraFerramentas.Visible := True
  else
    BarraFerramentas.Visible := False;
  BarraPrincipal.Visible := False;  
  {
    Atualiza posicionamento dos componentes
  }
  PnOpcoesResize(Self);
end;

procedure TFormPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  Fechar: Boolean;
begin
  Fechar := True;
  if (Sistema.ConfirmaSaida) and (not ErroNoSistema) and (not Sistema.ErroFatal) then
  begin
    if MessageDlg('Finalizar Sistema ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      Action := caNone;
      Fechar := False;
    end;
  end;
  If Fechar then
  Begin
    FechaJanelasFilhas;
    if Sistema.HintBalao then
      HintBalao.Free;
    if Sistema.MenuXP then
      MenuXP.Free;
    XBanner_Lateral.Free;
    Gradiente.Free;
  End;
end;

procedure TFormPrincipal.FechaJanelasFilhas;
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
end;

procedure TFormPrincipal.PnOpcoesResize(Sender: TObject);
begin
  PnLista1.Width    := PnOpcoes.Width     - 20;
  PnLista2.Width    := PnOpcoes.Width     - 20;
  BtnMinimiza.Left  := PnTitulo.Width     - 13;
  if PnTitulo.Width <= 30 then
  begin
    BtnMinimiza.Caption := '>';
    BtnMinimiza.Hint    := 'Expande Opções de Acesso';
  end
  else
  begin
    BtnMinimiza.Caption := '<';
    BtnMinimiza.Hint    := 'Minimiza Opções de Acesso';
  end;
  TreeOpcoes.Left   := ShapeOpcoes.Left   + 01;
  TreeOpcoes.Top    := ShapeOpcoes.Top    + 01;
  TreeOpcoes.Height := ShapeOpcoes.Height - 02;
  TreeOpcoes.Width  := ShapeOpcoes.Width  - 02;
end;

procedure TFormPrincipal.TreeOpcoesClick(Sender: TObject);
begin
  {30-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
end;

procedure TFormPrincipal.TreeOpcoesKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then  // Enter
    TreeOpcoesClick(Self);
end;

procedure TFormPrincipal.GradientePaint(Sender: TObject);
var
  RGBDesde, RGBHasta, RGBDif : array[0..2] of byte;  // Cor inicial e final - diferença de cores
  contador, Vermelho, Verde, Azul : integer;
  Banda : TRect;                                     // Coordenadas do requadro a pintar
  Factor : array[0..2] of shortint;                  // +1 se gradiente é crescente e -1 caso decrescente
  FColorDesde, FColorHasta: TColor;
  FDireccion: String;
begin
  FColorDesde := $002D4373;
  FColorHasta := $00D6E3EF;
  FDireccion  := 'H';                                // V=Vertical, H=Horizontal
  RGBDesde[0]:=GetRValue(ColorToRGB(FColorDesde));
  RGBDesde[1]:=GetGValue(ColorToRGB(FColorDesde));
  RGBDesde[2]:=GetBValue(ColorToRGB(FColorDesde));
  RGBHasta[0]:=GetRValue(ColorToRGB(FColorHasta));
  RGBHasta[1]:=GetGValue(ColorToRGB(FColorHasta));
  RGBHasta[2]:=GetBValue(ColorToRGB(FColorHasta));
  with TPaintBox(Sender) do
  begin
    for contador:=0 to 2 do                          // Calculo de RGBDif[] e factor[]
    begin
      RGBDif[contador]:=Abs(RGBHasta[contador]-RGBDesde[contador]);
      If RGBHasta[contador]>RGBDesde[contador] then factor[contador]:=1 else factor[contador]:=-1;
    end;
    Canvas.Pen.Style:=psSolid;
    Canvas.Pen.Mode:=pmCopy;
    if FDireccion = 'H' then
    begin
      Banda.Left:=0;
      Banda.Right:=Width;
      for contador:=0 to 255 do
      begin
        Banda.Top:=MulDiv(contador,height,256);
        Banda.Bottom:=MulDIv(contador+1,height,256);
        Vermelho:=RGBDesde[0]+factor[0]*MulDiv(contador,RGBDif[0],255);
        Verde:=RGBDesde[1]+factor[1]*MulDiv(contador,RGBDif[1],255);
        Azul:=RGBDesde[2]+factor[2]*MulDiv(contador,RGBDif[2],255);
        Canvas.Brush.Color:=RGB(Vermelho,Verde,Azul);
        Canvas.FillRect(Banda);
      end;
    end
    else if FDireccion = 'V' then
    begin
      Banda.Top:=0;
      Banda.Bottom:=Height;
      for contador:=0 to 255 do
      begin
        Banda.Left:=MulDiv(contador,width,256);
        Banda.Right:=MulDIv(contador+1,width,256);
        Vermelho:=RGBDesde[0]+factor[0]*MulDiv(contador,RGBDif[0],255);
        Verde:=RGBDesde[1]+factor[1]*MulDiv(contador,RGBDif[1],255);
        Azul:=RGBDesde[2]+factor[2]*MulDiv(contador,RGBDif[2],255);
        Canvas.Brush.Color:=RGB(Vermelho,Verde,Azul);
        Canvas.FillRect(Banda);
      end;
    end;
  end;
end;

procedure TFormPrincipal.BtnMinimizaClick(Sender: TObject);
begin
  if BtnMinimiza.Caption = '>' then
    PnOpcoes.Width := 141
  else
    PnOpcoes.Width := 30;
  PnOpcoesResize(Self);
end;

{40-Início do Bloco X-Maker. Modificações não serão preservadas}
{99-Final do Bloco X-Maker. Modificações não serão preservadas}

{50-Início do Bloco X-Maker. Modificações não serão preservadas}
procedure TFormPrincipal.Mnu_2Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO101;
end;

procedure TFormPrincipal.Mnu_3Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO102;
end;

procedure TFormPrincipal.Mnu_5Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO103;
end;

procedure TFormPrincipal.Mnu_6Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO104;
end;

procedure TFormPrincipal.Mnu_7Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO105;
end;

procedure TFormPrincipal.Mnu_8Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO106;
end;

procedure TFormPrincipal.Mnu_10Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO107;
end;

procedure TFormPrincipal.Mnu_12Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO120;
end;

procedure TFormPrincipal.Mnu_13Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO108;
end;

procedure TFormPrincipal.Mnu_14Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO109;
end;

procedure TFormPrincipal.Mnu_15Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO110;
end;

procedure TFormPrincipal.Mnu_17Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO121;
end;

procedure TFormPrincipal.Mnu_43Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO112;
end;

procedure TFormPrincipal.Mnu_44Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO113;
end;

procedure TFormPrincipal.Mnu_45Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO114;
end;

procedure TFormPrincipal.Mnu_46Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO115;
end;

procedure TFormPrincipal.Mnu_47Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO116;
end;

procedure TFormPrincipal.Mnu_49Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO117;
end;

procedure TFormPrincipal.Mnu_50Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO118;
end;

procedure TFormPrincipal.Mnu_52Click(Sender: TObject);
begin
  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO119;
end;

procedure TFormPrincipal.Bar_2Click(Sender: TObject);
begin
  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO106;
end;

procedure TFormPrincipal.Bar_4Click(Sender: TObject);
begin
  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO108;
end;

procedure TFormPrincipal.Bar_5Click(Sender: TObject);
begin
  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO109;
end;

procedure TFormPrincipal.Bar_6Click(Sender: TObject);
begin
  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO110;
end;

procedure TFormPrincipal.Bar_7Click(Sender: TObject);
begin
  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO121;
end;

procedure TFormPrincipal.Bar_9Click(Sender: TObject);
begin
  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?
    Abort;  // acesso negado, retorna ...
  INTERNO107;
end;

{99-Final do Bloco X-Maker. Modificações não serão preservadas}

end.
