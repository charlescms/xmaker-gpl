{
    Project: X-Maker 5 Open Source
    Licenses: Open-Souce GPL (readme-gpl-3.0.txt)
    Original author: http://www.xmaker.com.br - Alberto Henrique
}
unit Princ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, ImgList, Menus, IniFiles, Tabnotbk, FileCtrl,
  StdCtrls, SynEditPrint, SynEditPrintTypes, Buttons, SynEdit,
  SynEditTypes, db, jpeg, IBQuery, XBanner, XPMenu, ShellApi,
  CheckLst, Grids, XDate, XNum, Mask, XEdit, DBGrids, DBCtrls, IBSQL,
  TeeProcs, TeEngine, Chart, MPlayer, OleCtnrs, DBCGrids, DBChart,
  Outline, Tabs, DBLookup, ColorGrd, Gauges, Spin, DirOutln, Calendar,
  XLabel3D, XLookUp, XDBEdit, XDBNum, XDBDate, ToolEdit, CurrEdit, RXCtrls,
  RxCombos, RXClock, Animate, GIFCtrl, RXSwitch, RXDice, RXDBCtrl, RxLookup,
  RxRichEd, DBRichEd, RxDBComb, JvComponent, JvPageList,
  JvExControls, JvTabBar, JvDialogs, JvExStdCtrls, Appevnts, extdlgs,
  RxLogin, IBTable, IBStoredProc, IBDataBase, IBUpdateSQL, IBCustomDataSet,
  IBDatabaseInfo, IBSQLMonitor, IBEvents, IBExtract, IBConnectionBroker,
  IBDatabaseINI, IBScript, IBFilterDialog, FR_View, FR_Desgn, FR_E_HTM,
  FR_E_CSV, FR_E_RTF, FR_E_TXT, FR_RRect, FR_Chart, FR_BarC, FR_Shape,
  FR_ChBox, FR_Rich, FR_OLE, FR_DSet, FR_DBSet, FR_Class, QrTee, QRExport,
  QRPrntr, QuickRpt, Qrctrls, ADODB, SMDBGrid, ActnList, IB, OgProExe,
  OnGuard, OgNetWrk;

type
  TFormPrincipal = class(TForm)
    ListaImagem: TImageList;
    PopMenuReabrirProjeto: TPopupMenu;
    PrintDialog: TPrintDialog;
    SynEditPrint: TSynEditPrint;
    TimeSplash: TTimer;
    MenuXMaker: TMainMenu;
    PopMenuArquivo: TMenuItem;
    NovoProjeto: TMenuItem;
    AbrirProjeto: TMenuItem;
    FecharProjeto: TMenuItem;
    N1: TMenuItem;
    SalvarArquivo: TMenuItem;
    SalvarComoArquivo: TMenuItem;
    FecharArquivo: TMenuItem;
    N2: TMenuItem;
    Imprimir: TMenuItem;
    N3: TMenuItem;
    Sair: TMenuItem;
    PopMenuEditar: TMenuItem;
    Recortar: TMenuItem;
    Copiar: TMenuItem;
    Colar: TMenuItem;
    Desfazer: TMenuItem;
    Refazer: TMenuItem;
    SelecionarTudo: TMenuItem;
    ModoSelecao: TMenuItem;
    N5: TMenuItem;
    Localizar: TMenuItem;
    Proximo: TMenuItem;
    Substituir: TMenuItem;
    N6: TMenuItem;
    Posicionar: TMenuItem;
    PopMenuExibir: TMenuItem;
    BarradeFerramentas: TMenuItem;
    BrArquivo: TMenuItem;
    BrProjeto: TMenuItem;
    BrFontes: TMenuItem;
    BrAssistente: TMenuItem;
    DiarioProjeto: TMenuItem;
    Calendario: TMenuItem;
    Calculadora: TMenuItem;
    PopMenuProjeto: TMenuItem;
    DadosGenericos: TMenuItem;
    Tabelas: TMenuItem;
    Formularios: TMenuItem;
    Relatorios: TMenuItem;
    MenuPrincipal: TMenuItem;
    PopMenuFontes: TMenuItem;
    Regerar: TMenuItem;
    Compilar: TMenuItem;
    Executar: TMenuItem;
    PopMenuConfiguracoes: TMenuItem;
    Delphi50: TMenuItem;
    Delphi60: TMenuItem;
    Delphi70: TMenuItem;
    N7: TMenuItem;
    CorEditor: TMenuItem;
    CamposPredefinidos: TMenuItem;
    PopMenuJanelas: TMenuItem;
    Cascata: TMenuItem;
    Horizontal: TMenuItem;
    Vertical: TMenuItem;
    MinimizaTodas: TMenuItem;
    Organizaricones: TMenuItem;
    PopMenuAjuda: TMenuItem;
    Conteudo: TMenuItem;
    HelpDelphi: TMenuItem;
    N4: TMenuItem;
    Sobre: TMenuItem;
    Texto: TSynEdit;
    Texto2: TSynEdit;
    StatusBarPrincipal: TStatusBar;
    Divisao_Form: TMenuItem;
    Alinhamento: TMenuItem;
    Tamanho: TMenuItem;
    Enviarparafrente: TMenuItem;
    Enviarparatras: TMenuItem;
    TabOrder: TMenuItem;
    ImageList: TImageList;
    ImageList1: TImageList;
    BrHistorico: TMenuItem;
    PnSuperior: TPanel;
    ControlBarMenu: TControlBar;
    ToolBarArquivo: TToolBar;
    BtnNovoProjeto: TToolButton;
    BtnAbrirProjeto: TToolButton;
    BtnFecharProjeto: TToolButton;
    ToolButton3: TToolButton;
    BtnSalvarArquivo: TToolButton;
    ToolBarProjeto: TToolBar;
    BtnDadosGenericos: TToolButton;
    BtnTabelas: TToolButton;
    BtnFormularios: TToolButton;
    BtnRelatorios: TToolButton;
    BtnMenuPrincipal: TToolButton;
    ToolBarFontes: TToolBar;
    BtnCompilar: TToolButton;
    BtnExecutar: TToolButton;
    BtnDelphi: TToolButton;
    BtnDiario: TToolButton;
    JvTabBar_Paleta: TJvTabBar;
    PnTabBar: TPanel;
    ControlBarPaleta: TControlBar;
    Paleta: TJvPageList;
    Tab_Padrao: TJvStandardPage;
    Tab_Adicional: TJvStandardPage;
    Tab_Win32: TJvStandardPage;
    Tab_Sistema: TJvStandardPage;
    Tab_Tabelas: TJvStandardPage;
    Tab_Dialogos: TJvStandardPage;
    Tab_Win31: TJvStandardPage;
    Tab_XMaker: TJvStandardPage;
    Tab_RxControles: TJvStandardPage;
    Tab_RxTabelas: TJvStandardPage;
    N8: TMenuItem;
    OpcoesdeLayout: TMenuItem;
    Comentar: TMenuItem;
    Descomentar: TMenuItem;
    JvModernTabBarPainter1: TJvModernTabBarPainter;
    BtnUnits: TToolButton;
    BtnForms: TToolButton;
    DialogAbrirProjeto: TJvOpenDialog;
    Delphi: TMenuItem;
    Delphi2005: TMenuItem;
    PnFundo: TPanel;
    JvTabBar_Assistente: TJvTabBar;
    BarraAssistente: TPanel;
    ListAssistente: TListView;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Separacao: TSplitter;
    BarraHistorico: TPanel;
    ListaProjetos: TListView;
    Panel7: TPanel;
    Panel5: TPanel;
    Panel1: TPanel;
    PnIdentificacao: TPanel;
    Image_Registro: TImage;
    LbRegistro: TLabel;
    XBanner: TLabel;
    Modelos: TMenuItem;
    PaletaAlinhamento: TMenuItem;
    Tab_IBX: TJvStandardPage;
    Tab_FreeReport: TJvStandardPage;
    Tab_QuickReport: TJvStandardPage;
    Tab_ADO: TJvStandardPage;
    DialogSalvarProjeto: TJvSaveDialog;
    DialogSalvarUnit: TJvSaveDialog;
    SalvarComoModelo: TMenuItem;
    PopExe: TPopupMenu;
    EXE_Projeto: TMenuItem;
    EXE_Adapter: TMenuItem;
    Firebird1: TMenuItem;
    IBConsole1: TMenuItem;
    UsurioMaster1: TMenuItem;
    ImageList_Paleta: TImageList;
    Delphi2006: TMenuItem;
    Tab_OnGuard: TJvStandardPage;
    Selecionar: TMenuItem;
    LbBeta: TLabel;
    TimerBeta: TTimer;
    ExibirCaixadeMensagem: TMenuItem;
    TurboDelphi1: TMenuItem;
    TimerFormulario: TTimer;
    N9: TMenuItem;
    Visitenossosite1: TMenuItem;
    procedure sbtPaletteButtonClick(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BarradeFerramentasClick(Sender: TObject);
    procedure BrArquivoClick(Sender: TObject);
    procedure BrProjetoClick(Sender: TObject);
    procedure BrFontesClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
    procedure BtnAbrirProjetoClick(Sender: TObject);
    procedure BtnNovoProjetoClick(Sender: TObject);
    procedure BtnFecharProjetoClick(Sender: TObject);
    procedure BtnDadosGenericosClick(Sender: TObject);
    procedure Delphi50Click(Sender: TObject);
    procedure Delphi60Click(Sender: TObject);
    procedure BtnDelphiClick(Sender: TObject);
    procedure RecortarClick(Sender: TObject);
    procedure CopiarClick(Sender: TObject);
    procedure ColarClick(Sender: TObject);
    procedure DesfazerClick(Sender: TObject);
    procedure BtnSalvarArquivoClick(Sender: TObject);
    procedure LocalizarClick(Sender: TObject);
    procedure SubstituirClick(Sender: TObject);
    procedure PosicionarClick(Sender: TObject);
    procedure HelpDelphiClick(Sender: TObject);
    procedure ConteudoClick(Sender: TObject);
    procedure BtnTabelasClick(Sender: TObject);
    procedure BtnMenuPrincipalClick(Sender: TObject);
    procedure BtnCompilarClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
    procedure BtnFecharArquivoClick(Sender: TObject);
    procedure ProximoClick(Sender: TObject);
    procedure SelecionarTudoClick(Sender: TObject);
    procedure DiarioProjetoClick(Sender: TObject);
    procedure SobreClick(Sender: TObject);
    procedure CamposPredefinidosClick(Sender: TObject);
    procedure BtnFormulariosClick(Sender: TObject);
    procedure CorEditorClick(Sender: TObject);
    procedure RefazerClick(Sender: TObject);
    procedure RegerarClick(Sender: TObject);
    procedure BrAssistenteClick(Sender: TObject);
    procedure ModoSelecaoClick(Sender: TObject);
    procedure Delphi70Click(Sender: TObject);
    procedure CalendarioClick(Sender: TObject);
    procedure CalculadoraClick(Sender: TObject);
    procedure TimeSplashTimer(Sender: TObject);
    procedure CascataClick(Sender: TObject);
    procedure HorizontalClick(Sender: TObject);
    procedure VerticalClick(Sender: TObject);
    procedure MinimizaTodasClick(Sender: TObject);
    procedure OrganizariconesClick(Sender: TObject);
    procedure XBannerClick(Sender: TObject);
    procedure ListAssistenteClick(Sender: TObject);
    procedure ListaProjetosClick(Sender: TObject);
    procedure ListaProjetosSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListAssistenteSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BrHistoricoClick(Sender: TObject);
    procedure ControlBarPaletaResize(Sender: TObject);
    procedure ComentarClick(Sender: TObject);
    procedure DescomentarClick(Sender: TObject);
    procedure JvTabBar_AssistenteTabClosed(Sender: TObject; Item: TJvTabBarItem);
    procedure BtnUnitsClick(Sender: TObject);
    procedure BtnFormsClick(Sender: TObject);
    procedure Delphi2005Click(Sender: TObject);
    procedure EnviarparafrenteClick(Sender: TObject);
    procedure EnviarparatrasClick(Sender: TObject);
    procedure AlinhamentoClick(Sender: TObject);
    procedure TamanhoClick(Sender: TObject);
    procedure TabOrderClick(Sender: TObject);
    procedure JvTabBar_AssistenteTabSelected(Sender: TObject;
      Item: TJvTabBarItem);
    procedure FormResize(Sender: TObject);
    procedure OpcoesdeLayoutClick(Sender: TObject);
    procedure ModelosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaletaAlinhamentoClick(Sender: TObject);
    procedure SalvarComoArquivoClick(Sender: TObject);
    procedure EXE_ProjetoClick(Sender: TObject);
    procedure EXE_AdapterClick(Sender: TObject);
    procedure IBConsole1Click(Sender: TObject);
    procedure UsurioMaster1Click(Sender: TObject);
    procedure Delphi2006Click(Sender: TObject);
    procedure SelecionarClick(Sender: TObject);
    procedure TimerBetaTimer(Sender: TObject);
    procedure ExibirCaixadeMensagemClick(Sender: TObject);
    procedure TurboDelphi1Click(Sender: TObject);
    procedure TimerFormularioTimer(Sender: TObject);
    procedure Visitenossosite1Click(Sender: TObject);
    procedure AdquirirProdutos1Click(Sender: TObject);
    procedure VideoaulaClick(Sender: TObject);
  protected
    //procedure OnGetMinMaxInfo(var msg : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  private
    { Private declarations }
    SearchOptions: TSynSearchOptions;
    MultiSubst: String;
    FechouSplash: Boolean;
    NrBanner: Integer;
    RegerarModulos: Boolean;
    TipoFormulario: Integer;
    ListaNomeProj: TStringList;
    procedure ReabrirOnClick(Sender: TObject);
    procedure Reabrir;
    procedure DefineCompilador;
    procedure AtualizarVersao(Versao: String);
    procedure AtualizaCampoProjeto;
    procedure Tabelas_Interna;
  public
    { Public declarations }
    FecharForm: Boolean;
    LNomesReservados1: String;
    LNomesReservados2: String;
    S_Barra_Hist: Boolean;
    ComponentClass: TComponentClass;
    function HabilitaProjeto(Arquivo: String): Boolean;
    procedure Botoes(Valor: Boolean);
    procedure CopiaFontes;
    function NomeProjValido(Nome: String): Boolean;
    procedure FechaJanelasFilhas;
  end;

type
  imagem_principal = function: PChar;
  imagem_secundaria = function: PChar;
  imagem_compartilhada = function: Boolean;

var
  FormPrincipal: TFormPrincipal;
  IniFile : TIniFile;
  Arqini  : String;
  SearchText : String;
  SearchOption:TSynSearchOptions;
  MenuXP: TXPMenu;
  p_imagem_principal: imagem_principal = Nil;
  p_imagem_secundaria: imagem_secundaria = Nil;
  p_imagem_compartilhada: imagem_compartilhada = Nil;

implementation

{$R *.DFM}

uses Rotinas, DGeneric, PrDelphi, RichEdit, ObjMenu,
     Gera_01, GeraF, Compila, Diario, Sobre,
     Aguarde, CampoPre, Formular, env_opt, find, Replace,
     Based, Abertura, Abertura_p, Tabela, Calend, Calculad, Splash,
     Estrutura_Bd, FDesigner, FrmCompile, FormsProj, DefModelos, FDCmpPal, ObjInsp,
     UsrFirebird, Estrutura_Case, BetaTeste, Formularios;

{procedure TFormPrincipal.OnGetMinMaxInfo(var msg : TWMGetMinMaxInfo);
var
  r : TRect;
  style : Longint;
begin
  inherited;
  if (FormEntradaDados <> Nil) then
  begin
    r := ControlBarInsp.BoundsRect;
    style := GetWindowLong(Self.Handle, GWL_STYLE);
    AdjustWindowRect(r, style, TRUE);
    msg.MinMaxInfo^.ptMaxTrackSize.x := Screen.Width;
    msg.MinMaxInfo^.ptMaxTrackSize.y := r.bottom - r.top + 2;
  end;
end;}

procedure TFormPrincipal.SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPrincipal.sbtPaletteButtonClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: begin
           ComponentClass:=(Sender as TPaletteButton).ComponentClass;
           if Assigned(ComponentClass) then FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.PlaceComponentClass(ComponentClass)
           else FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.CancelPlacing;
         end;
    end;
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
var
  x,y     : string;
  visivel,scomp : string;
  Handle : THandle;

  function Converte(S: String): String;
  var
    I: Integer;
    S1: String;
  begin
    S1 := '';
    for I:=1 to Length(S) do
    begin
      case S[I] of
        'A' : S1 := S1 + '0';
        'B' : S1 := S1 + '1';
        'C' : S1 := S1 + '2';
        'D' : S1 := S1 + '3';
        'E' : S1 := S1 + '4';
        'F' : S1 := S1 + '5';
        'G' : S1 := S1 + '6';
        'H' : S1 := S1 + '7';
        'I' : S1 := S1 + '8';
        'J' : S1 := S1 + '9';
      else
        if (S[I] >= '0') and (S[I] <= '9') then
          S1 := S1 + '#'
        else if ((S[I] >= 'A') and (S[I] <= 'Z')) or (S[I] = '-') then
          S1 := S1 + S[I]
        else
          S1 := S1 + ' ';
      end;
    end;
    Converte := S1;
  end;

  procedure MakeBitmaps;
  begin
    Paleta.ActivePageIndex := 0;
    CreatePalette(Tab_Padrao,[TMainMenu, TPopupMenu, TLabel, TEdit, TMemo, TButton, TCheckBox,
                              TRadioButton, TListBox, TComboBox, TScrollBar, TGroupBox,
                              TRadioGroup, TPanel, TGauge, TColorGrid, TSpinButton, TSpinEdit, TActionList], sbtPaletteButtonClick);
    CreatePalette(Tab_Adicional,[TBitBtn, TSpeedButton, TMaskEdit, TStringGrid, TDrawGrid, TImage,
                                 TShape, TBevel, TScrollBox, TCheckListBox, TSplitter, TStaticText,
                                 TControlBar, TApplicationEvents, TChart, TDirectoryOutLine,
                                 TCalendar, TScroller], sbtPaletteButtonClick);
    CreatePalette(Tab_Win32,[TTabControl, TPageControl, TRichEdit, TTrackBar, TProgressBar,
                             TUpDown, THotKey, TAnimate, TDateTimePicker, TMonthCalendar,
                             TTreeView, TListView, TheaderControl, TStatusBar, TToolBar,
                             TCoolBar, TPageScroller], sbtPaletteButtonClick);
    CreatePalette(Tab_Sistema,[TTimer, TPaintBox, TMediaPlayer, TOleContainer], sbtPaletteButtonClick);
    CreatePalette(Tab_Tabelas,[TDataSource, TDBGrid, TDBNavigator, TDBText, TDBEdit, TDBMemo,
                               TDBImage, TDBListBox, TDBComboBox, TDBCheckBox, TDBRadioGroup,
                               TDBLookupListBox, TDBLookupComboBox, TDBRichEdit, TDBCtrlGrid,
                               TDBChart], sbtPaletteButtonClick);
    CreatePalette(Tab_IBX,[TIBTable, TIBQuery, TIBStoredProc, TIBDatabase, TIBTransaction, TIBUpdateSQL,
                           TIBDataSet, TIBSQL, TIBDatabaseInfo, TIBSQLMonitor, TIBEvents, TIBExtract], sbtPaletteButtonClick);
    CreatePalette(Tab_ADO,[TADOConnection, TADOCommand, TADODataSet, TADOTable, TADOQuery,
                           TADOStoredProc, TRDSConnection], sbtPaletteButtonClick);
    CreatePalette(Tab_Dialogos,[TOpenDialog, TSaveDialog, TOpenPictureDialog, TSavePictureDialog,
                                TFontDialog, TColorDialog, TPrintDialog, TPrinterSetupDialog,
                                TFindDialog, TReplaceDialog, TRXLoginDialog], sbtPaletteButtonClick);
    CreatePalette(Tab_Win31,[TTabSet, TOutLine, TTabbedNotebook, TNotebook, THeader,
                             TFileListBox, TDirectoryListBox, TDriveComboBox, TFilterComboBox,
                             TDBLookupList, TDBLookupCombo], sbtPaletteButtonClick);
    CreatePalette(Tab_XMaker,[TXDateEdit, TXNumEdit, TXEdit, TXDBDateEdit, TXDBNumEdit, TXDBEdit,
                              TXDBLookup, TXBanner, TXLabel3D, TSMDBGrid], sbtPaletteButtonClick);

    CreatePalette(Tab_OnGuard,[TOgMakeKeys, TOgMakeCodes, TOgDateCode, TOgDaysCode, TOgNetCode,
                               TOgRegistrationCode, TOgSerialNumberCode, TOgSpecialCode,
                               TOgUsageCode, TOgProtectExe], sbtPaletteButtonClick);

    CreatePalette(Tab_RXControles,[TComboEdit, TFileNameEdit, TDirectoryEdit, TDateEdit,
                                   TRXCalcEdit, TCurrencyEdit, TTextListBox, TRxCheckListBox,
                                   TFontComboBox, TRxRichEdit,
                                   TRxGIFAnimator, TRxSwitch, TRxDice], sbtPaletteButtonClick);
    CreatePalette(Tab_RXTabelas,[TRxDBGrid, TRxDBLookupList, TRxDBLookupCombo,
                                 TDBDateEdit, TRxDBCalcEdit, TRxDBRichEdit,
                                 TRxDBComboBox], sbtPaletteButtonClick);
    CreatePalette(Tab_FreeReport,[TfrReport, TfrCompositeReport, TfrDBDataSet, TfrUserDataSet,
                                  TfrOleObject, TfrRichObject, TfrCheckBoxObject, TfrShapeObject,
                                  TfrBarCodeObject, TfrChartObject, TfrRoundRectObject, TfrTextExport,
                                  TfrRTFExport, TfrCSVExport, TfrHTMExport, TfrDesigner, TfrPreview], sbtPaletteButtonClick);
    CreatePalette(Tab_QuickReport, [TQuickRep, TQRSubDetail, TQRStringsBand, TQRBand, TQRChildBand,
                                    TQRGroup, TQRLabel, TQRDBText, TQRExpr, TQRSysData, TQRMemo,
                                    TQRExprMemo, TQRRichText, TQRDBRichText, TQRShape, TQRImage,
                                    TQRDBImage, TQRCompositeReport, TQRPreview, TQRTextFilter,
                                    TQRCSVFilter, TQRHTMLFilter, TQRChart], sbtPaletteButtonClick);
  end;

begin
  MakeBitmaps;
  Lista_Find_G := TStringList.Create;
  Lista_Subst_G := TStringList.Create;
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
    //XPContainers := [xccToolbar, xccCoolbar, xccControlbar];
    XPContainers := [];
    //XPControls := [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar];
    XPControls := [xcMainMenu, xcPopupMenu];
    Active := True;
  end;
  ListaNomeProj := TStringList.Create;
  NrBanner := 1;
  FechouSplash := False;
  FecharForm := False;
  Projeto.PastaGerador := ExtractFilePath(Application.ExeName);
  Projeto.PastaGerador := DiretorioComBarra(Projeto.PastaGerador);
  Projeto.VersaoGerador:= '5.0';
  Projeto.VersaoGerador_v := '05';
  Projeto.ReleaseGerador := 'R04';
  Projeto.Beta_Versao    := '';
  Projeto.Beta_Release   := '';
  LbBeta.Visible := Trim(Projeto.Beta_Versao) <> '';
  if FREDT then
    Application.Title := 'X-Maker '+IIF(Trim(Projeto.Beta_Versao)<>'',Projeto.Beta_Versao,Projeto.VersaoGerador)+' Free'
  else
    Application.Title := 'X-Maker '+IIF(Trim(Projeto.Beta_Versao)<>'',Projeto.Beta_Versao,Projeto.VersaoGerador)+' Pro';
  Application.OnHint := ShowHint;

  Projeto.Registro_usr := Space(17);
  C_RGT_USR            := Space(34);
  C_CRACK              := True;
  Projeto.UsoemRede    := True;

  {if (not FREDT) then
  begin
    Projeto.UsoemRede := False;
    if FileExists(Projeto.PastaGerador + 'XMaker.dll') then
    begin
      Handle := LoadLibrary (PChar(Projeto.PastaGerador + 'XMaker.dll'));
      Win32Check(Handle <> 0);
      try
        @p_imagem_principal := GetProcAddress(Handle, 'imagem_principal');
        Win32Check(@p_imagem_principal <> nil);
        Projeto.Registro_usr := Converte(Trim(p_imagem_principal));

        @p_imagem_secundaria := GetProcAddress(Handle, 'imagem_secundaria');
        Win32Check(@p_imagem_secundaria <> nil);
        C_RGT_USR := Converte(Trim(p_imagem_secundaria));

        @p_imagem_compartilhada := GetProcAddress(Handle, 'imagem_compartilhada');
        Win32Check(@p_imagem_compartilhada <> nil);
        Projeto.UsoemRede := p_imagem_compartilhada;
      except
        FreeLibrary (Handle);
        Handle := 0;
        raise;
      end;
    end
    else
    begin
      Projeto.Registro_usr := ConstStr('#',17);
      C_RGT_USR            := ConstStr('*',34);
    end;
  end;}
  Projeto.UsoemRede := True;
  Projeto.Registro_usr := 'Versão Open Source-';

  {scomp := C_RGT_USR[01]+C_RGT_USR[03]+C_RGT_USR[05]+C_RGT_USR[07]+C_RGT_USR[09]+
           C_RGT_USR[11]+C_RGT_USR[13]+C_RGT_USR[15]+C_RGT_USR[17]+C_RGT_USR[19]+
           C_RGT_USR[21]+C_RGT_USR[23]+C_RGT_USR[25]+C_RGT_USR[27]+C_RGT_USR[29]+
           C_RGT_USR[31]+C_RGT_USR[33];

  if not FREDT then
  begin
    Projeto.Registro_usr := Trim(Projeto.Registro_usr);
    c_rgt_usr := Trim(c_rgt_usr);
    scomp := Trim(scomp);
  end;
  if Projeto.Registro_usr <> scomp then
    C_CRACK := True
  else
    C_CRACK := False;
  if not FREDT then
    if Projeto.Registro_usr[Length(Projeto.Registro_usr)-1] +
       Projeto.Registro_usr[Length(Projeto.Registro_usr)] <> Projeto.VersaoGerador_v then
      C_CRACK := True;
  if (not C_CRACK) and (not FREDT) then
    if Projeto.Registro_usr[15] = '-' then  // CNPJ
    begin
      if not VCNPJ(Copy(Projeto.Registro_usr,01,14)) then
        C_CRACK := True;
    end
    else                                    // CPF
    begin
      if not VCPF(Copy(Projeto.Registro_usr,01,11)) then
        C_CRACK := True;
    end;}
  C_CRACK := False;

  if FREDT then
  begin
    TituloXMaker := 'X-Maker '+IIF(Trim(Projeto.Beta_Versao)<>'',Projeto.Beta_Versao,Projeto.VersaoGerador)+', Gerador de Aplicativos em Delphi - FREE EDITION';
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%1', 'Free Edition', [rfReplaceAll, rfIgnoreCase]);
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%4', 'Free Edition', [rfReplaceAll, rfIgnoreCase]);
  end
  else
  begin
    TituloXMaker := 'X-Maker '+IIF(Trim(Projeto.Beta_Versao)<>'',Projeto.Beta_Versao,Projeto.VersaoGerador)+', Gerador de Aplicativos em Delphi - PROFESSIONAL ( '+Copy(Projeto.Registro_usr,01,Pos('-',Projeto.Registro_usr)-1)+' )';
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%1', Copy(Projeto.Registro_usr,01,Pos('-',Projeto.Registro_usr)-1), [rfReplaceAll, rfIgnoreCase]);
    if not Projeto.UsoemRede then
      LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%4', 'Individual', [rfReplaceAll, rfIgnoreCase])
    else
      LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%4', 'Corporativo', [rfReplaceAll, rfIgnoreCase]);
  end;
  if Trim(Projeto.Beta_Versao) <> '' then
  begin
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%2', Projeto.Beta_Versao, [rfReplaceAll, rfIgnoreCase]);
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%3', Projeto.Beta_Release, [rfReplaceAll, rfIgnoreCase]);
  end
  else
  begin
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%2', Projeto.VersaoGerador, [rfReplaceAll, rfIgnoreCase]);
    LbRegistro.Caption := TrocaString(LbRegistro.Caption, '%3', Projeto.ReleaseGerador, [rfReplaceAll, rfIgnoreCase]);
  end;

  Caption := TituloXMaker;
  ArqIni  := Projeto.PastaGerador; //DiretorioComBarra(DirWindows);
  //ToolBarMenuPrincipal.Align := alTop;
  //ToolBarMenuPrincipal.AutoSize := True;
  if FileExists(ArqIni + 'XMAKER.INI') then
  begin
    IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
    Visivel := IniFile.readstring('BARRA_4', 'Arquivo.Visivel', '');
    if Visivel = 'True' then
    begin
      Y := IniFile.readstring('BARRA_4', 'Arquivo.Top', '');
      X := IniFile.readstring('BARRA_4', 'Arquivo.Left', '');
      ToolBarArquivo.Height := StrToInt(IniFile.readstring('BARRA_4', 'Arquivo.Height', ''));
      ToolBarArquivo.Width  := StrToInt(IniFile.readstring('BARRA_4', 'Arquivo.Width', ''));
      ToolBarArquivo.Top    := StrToInt(Y);
      ToolBarArquivo.Left   := StrToInt(X);
    end
    else
      if Trim(Visivel) <> '' then
        ToolBarArquivo.Visible := False;

    Visivel := IniFile.readstring('BARRA_4', 'Projeto.Visivel', '');
    if Visivel = 'True' then
    begin
      Y := IniFile.readstring('BARRA_4', 'Projeto.Top', '');
      X := IniFile.readstring('BARRA_4', 'Projeto.Left', '');
      ToolBarProjeto.Height := StrToInt(IniFile.readstring('BARRA_4', 'Projeto.Height', ''));
      ToolBarProjeto.Width  := StrToInt(IniFile.readstring('BARRA_4', 'Projeto.Width', ''));
      ToolBarProjeto.Top    := StrToInt(Y);
      ToolBarProjeto.Left   := StrToInt(X);
    end
    else
      if Trim(Visivel) <> '' then
        ToolBarProjeto.Visible := False;

    Visivel := IniFile.readstring('BARRA_4', 'Fontes.Visivel', '');
    if Visivel = 'True' then
    begin
      Y := IniFile.readstring('BARRA_4', 'Fontes.Top', '');
      X := IniFile.readstring('BARRA_4', 'Fontes.Left', '');
      ToolBarFontes.Height := StrToInt(IniFile.readstring('BARRA_4', 'Fontes.Height', ''));
      ToolBarFontes.Width  := StrToInt(IniFile.readstring('BARRA_4', 'Fontes.Width', ''));
      ToolBarFontes.Top    := StrToInt(Y);
      ToolBarFontes.Left   := StrToInt(X);
    end
    else
      if Trim(Visivel) <> '' then
        ToolBarFontes.Visible := False;

    Visivel := IniFile.readstring('BARRA_4', 'Assistente.Visivel', '');
    if Visivel = 'True' then
      BarraAssistente.Visible := True
    else
      if Trim(Visivel) <> '' then
        BarraAssistente.Visible := False;

    Visivel := IniFile.readstring('BARRA_4', 'Historico.Visivel', 'True');
    if Visivel = 'True' then
      ListaProjetos.Visible := True // BarraHistorico
    else
      if Trim(Visivel) <> '' then
        ListaProjetos.Visible := False;
    S_Barra_Hist := ListaProjetos.Visible; // BarraHistorico
    Projeto.usr_firebird := Inifile.ReadString('FIREBIRD', 'usuario', 'SYSDBA');
    Projeto.pwd_firebird := Inifile.ReadString('FIREBIRD', 'senha', 'masterkey');
    Reabrir;
    IniFile.Free;
  end;

  JvTabBar_Assistente.Tabs[0].Visible := BarraAssistente.Visible;
  JvTabBar_Assistente.Tabs[1].Visible := ListaProjetos.Visible;  // BarraHistorico
  if (not JvTabBar_Assistente.Tabs[0].Visible) and
     (not JvTabBar_Assistente.Tabs[1].Visible) then
    JvTabBar_Assistente.Visible := False
  else
    JvTabBar_Assistente.Visible := True;

  LNomesReservados1 := 'Projeto|Dicionar|Abertura|Acesso|AgEdit|Agenda|Aguarde|Ambiente' +
                       '|Atributo|Backup|Based|BatePapo|CabIntf|CabSTComps|CabSTConsts' +
                       '|Calculad|Calend|CfgEmp|CTabelas|DAO_TLb|EdGrp|EdUsr|Estrutur' +
                       '|Extras|Filtro|Interno|LTab|OpAcesso|Princ|Publicas' +
                       '|Restaura|RotinaEd|Rotinas|SelEmp|Senhas|Sobre|Splash' +
                       '|Tabela|Validar|Adapter|Campo_Adapter|Emp_Adapter|';
  LNomesReservados1 := UpperCase(LNomesReservados1);

  LNomesReservados2 := 'NomeTabela|Titulo|Versao|Campos|ChavePrimaria|TituloPrimaria|ChPrimaria' +
                       '|TituloIndice|ChaveIndice|TituloIndices|Indices|Crescente|Inclusao|Modificacao' +
                       '|SqlPrincipal|Filtro|FiltroRelac|Local|';
  LNomesReservados2 := UpperCase(LNomesReservados2);

  ExibirCaixadeMensagem.Checked := False;
  if Trim(Projeto.Beta_Versao) <> '' then
  begin
    IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
    if IniFile.Readbool('MENSAGEM', 'Habilitado', True) then
    begin
      TimerBeta.Enabled := True;
      ExibirCaixadeMensagem.Checked := True;
    end;
    IniFile.Free;
  end;
  //if not FileExists(Projeto.PastaGerador + 'Doc\VideoAula.html') then
  //  Videoaula.Visible := False;
end;

procedure TFormPrincipal.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBarPrincipal.SimplePanel := True;
    StatusBarPrincipal.SimpleText := Application.Hint;
  end
  else StatusBarPrincipal.SimplePanel := False;
end;

procedure TFormPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FormDesigner_Net <> nil then
  begin
    Mensagem('Feche a definição do formulário !',modInformacao,[modOk]);
    Action := caNone;
    exit;
  end;
  FechaJanelasFilhas;
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  if ToolBarArquivo.Visible then
  begin
    IniFile.WriteString('BARRA_4', 'Arquivo.Visivel', 'True');
    IniFile.WriteString('BARRA_4', 'Arquivo.Top' , IntToStr(ToolBarArquivo.Top));
    IniFile.WriteString('BARRA_4', 'Arquivo.Left', IntToStr(ToolBarArquivo.Left));
    IniFile.WriteString('BARRA_4', 'Arquivo.Height' , IntToStr(ToolBarArquivo.Height));
    IniFile.WriteString('BARRA_4', 'Arquivo.Width', IntToStr(ToolBarArquivo.Width));
  end
  else
    IniFile.WriteString('BARRA_4', 'Arquivo.Visivel', 'False');

  if ToolBarProjeto.Visible then
  begin
    IniFile.WriteString('BARRA_4', 'Projeto.Visivel', 'True');
    IniFile.WriteString('BARRA_4', 'Projeto.Top' , IntToStr(ToolBarProjeto.Top));
    IniFile.WriteString('BARRA_4', 'Projeto.Left', IntToStr(ToolBarProjeto.Left));
    IniFile.WriteString('BARRA_4', 'Projeto.Height' , IntToStr(ToolBarProjeto.Height));
    IniFile.WriteString('BARRA_4', 'Projeto.Width', IntToStr(ToolBarProjeto.Width));
  end
  else
    IniFile.WriteString('BARRA_4', 'Projeto.Visivel', 'False');

  if ToolBarFontes.Visible then
  begin
    IniFile.WriteString('BARRA_4', 'Fontes.Visivel', 'True');
    IniFile.WriteString('BARRA_4', 'Fontes.Top' , IntToStr(ToolBarFontes.Top));
    IniFile.WriteString('BARRA_4', 'Fontes.Left', IntToStr(ToolBarFontes.Left));
    IniFile.WriteString('BARRA_4', 'Fontes.Height' , IntToStr(ToolBarFontes.Height));
    IniFile.WriteString('BARRA_4', 'Fontes.Width', IntToStr(ToolBarFontes.Width));
  end
  else
    IniFile.WriteString('BARRA_4', 'Fontes.Visivel', 'False');

  if BarraAssistente.Visible then
    IniFile.WriteString('BARRA_4', 'Assistente.Visivel', 'True')
  else
    IniFile.WriteString('BARRA_4', 'Assistente.Visivel', 'False');

  if S_Barra_Hist then
    IniFile.WriteString('BARRA_4', 'Historico.Visivel', 'True')
  else
    IniFile.WriteString('BARRA_4', 'Historico.Visivel', 'False');

  if BtnFecharProjeto.Enabled then
    BtnFecharProjetoClick(Self);
  Lista_Find_G.Free;
  Lista_Subst_G.Free;
  IniFile.Free;
  ListaNomeProj.Free;
  MenuXP.Free;
  Action := caFree;
end;

procedure TFormPrincipal.BarradeFerramentasClick(Sender: TObject);
begin
  BrArquivo.Checked    := ToolBarArquivo.Visible ;
  BrProjeto.Checked    := ToolBarProjeto.Visible ;
  BrFontes.Checked     := ToolBarFontes.Visible ;
  if FormDesigner_Net = Nil then
  begin
    BrAssistente.Checked := BarraAssistente.Visible;
    BrHistorico.Checked  := S_Barra_Hist;
  end;
end;

procedure TFormPrincipal.BrArquivoClick(Sender: TObject);
begin
  BrArquivo.Checked  := not BrArquivo.Checked;
  ToolBarArquivo.Visible := BrArquivo.Checked;
end;

procedure TFormPrincipal.BrProjetoClick(Sender: TObject);
begin
  BrProjeto.Checked  := not BrProjeto.Checked;
  ToolBarProjeto.Visible := BrProjeto.Checked;
end;

procedure TFormPrincipal.BrFontesClick(Sender: TObject);
begin
  BrFontes.Checked  := not BrFontes.Checked;
  ToolBarFontes.Visible := BrFontes.Checked;
end;

procedure TFormPrincipal.ImprimirClick(Sender: TObject);
var
  AFont: TFont;
  Edit: TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    Edit := FormDesigner_Net.CurrentEdit;
    if assigned(Edit) then
      if PrintDialog.Execute then
      begin
        AFont := TFont.Create;
        with SynEditPrint.Header do begin
          Add('Página: $PAGENUM$ de $PAGECOUNT$', nil, taRightJustify, 1);
          Add('$TITLE$', nil, taLeftJustify, 1);
          AFont.Assign(DefaultFont);
          AFont.Size := 6;
          Add('Data: $DATE$. Hora: $TIME$', AFont, taRightJustify, 2);
        end;
        AFont.Free;
        SynEditPrint.SynEdit := Edit;
        SynEditPrint.Title   := Edit.Filename;
        SynEditPrint.Print;
      end;
  end;
end;

procedure TFormPrincipal.BtnAbrirProjetoClick(Sender: TObject);
begin
  if FormDesigner_Net <> nil then
  begin
    Mensagem('Feche a definição do formulário !',modInformacao,[modOk]);
    exit;
  end;
  DialogAbrirProjeto.FileName := '';
  DialogAbrirProjeto.InitialDir := Projeto.PastaGerador + 'Projetos\';
  DialogAbrirProjeto.DefaultExt := '*.mpj';
  DialogAbrirProjeto.Filter := 'Projeto X-Maker (*.mpj)|*.mpj';
  if DialogAbrirProjeto.Execute then
  begin
    if FileExists(DialogAbrirProjeto.FileName) then
    begin
      if not NomeProjValido(DialogAbrirProjeto.FileName) then
        exit;
      HabilitaProjeto(DialogAbrirProjeto.FileName);
    end
    else
      Mensagem('Projeto não Encontrado !',ModAdvertencia,[ModOk]);
  end;
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
end;

function TFormPrincipal.NomeProjValido(Nome: String): Boolean;
var
  Caracter, TipoChar: String;
  CharInvalido : Boolean;
  I: Integer;
  NomeF: String;
begin
  NomeF  := Nome;
  Result := True;
  Nome   := Trim(ExtractFileName(UpperCase(Nome)));
  Nome   := TrocaString(Nome,'.MPJ','',[rfReplaceAll]);
  if Pos(UpperCase(Nome)+'|',LNomesReservados1) > 0 then
  begin
    Mensagem('Nome de Projeto Inválido !'+^M+^M+Nome+' ( Reservado ) ...',modErro,[modOk]);
    Result := False;
  end
  else
  begin
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
    if CharInvalido then
    begin
      Mensagem('Caracter Inválido no Nome: '+ #39 + TipoChar + #39,ModErro,[ModOk]);
      Result := False;
    end
    else
      if Pos(' ', NomeF) > 0 then                                                                                                                       
        Mensagem('Para evitar erro de associação de ícone ao projeto não utilize'+^M+'espaço(s) na pasta ou nome do projeto !'+^M+^M+'Projeto: '+NomeF , modAdvertencia, [modOk]);
  end;
end;

procedure TFormPrincipal.BtnNovoProjetoClick(Sender: TObject);
begin
  if FormDesigner_Net <> nil then
  begin
    Mensagem('Feche a definição do formulário !',modInformacao,[modOk]);
    exit;
  end;
  ForceDirectories(Projeto.PastaGerador+'Projetos');
  ChDir(Projeto.PastaGerador+'Projetos');

  DialogSalvarProjeto.DefaultExt := '*.mpj';
  DialogSalvarProjeto.Filter := 'Projeto X-Maker (*.mpj)|*.mpj';
  DialogSalvarProjeto.InitialDir := Projeto.PastaGerador+'Projetos';
  if DialogSalvarProjeto.Execute then
  begin
    if not FileExists(DialogSalvarProjeto.FileName) then
    begin
      if not NomeProjValido(DialogSalvarProjeto.FileName) then
        exit;
      Projeto.Nome := DialogSalvarProjeto.FileName;
      IniFile := TInifile.Create(Projeto.Nome);
      IniFile.WriteString('XMAKER', 'Versao', Projeto.VersaoGerador);
      IniFile.Free;
    end
    else
      if not NomeProjValido(DialogSalvarProjeto.FileName) then
        exit;
    HabilitaProjeto(DialogSalvarProjeto.FileName);
    FormDadosGenericos := TFormDadosGenericos.Create(Application);
    Try
      FormDadosGenericos.ShowModal;
    Finally
      FormDadosGenericos.Free;
    end;
    if TabGlobal_i.DPROJETO.Active then
      DefineCompilador;
  end;
  DialogSalvarProjeto.InitialDir := '';
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
end;

procedure TFormPrincipal.BtnFecharProjetoClick(Sender: TObject);
begin
  if FormDesigner_Net <> nil then
  begin
    Mensagem('Feche a definição do formulário !',modInformacao,[modOk]);
    exit;
  end;
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  IniFile.WriteBool('FORMULARIOS', 'RxLib', Projeto.RXLib);

  TabGlobal_i.FecharTabelas;
  BaseDados.FechaBase;

  Projeto.Nome         := '';
  Projeto.Pasta        := '';
  Projeto.Dicionario   := '';
  Projeto.Servidor_Pro := '';
  Projeto.Pasta_projeto:= '';
  Projeto.Servidor_Dic := '';
  Projeto.RXLib        := False;
  StrCompTree          := '';
  StrCompImFundo       := '';
  StrCompImSplash      := '';
  DiarioProjeto.Enabled   := False;
  BtnDiario.Enabled       := False;
  FecharProjeto.Enabled   := False;
  OpcoesdeLayout.Enabled  := False;
  DadosGenericos.Enabled  := False;
  Tabelas.Enabled         := False;
  Formularios.Enabled     := False;
  Relatorios.Enabled      := False;
  MenuPrincipal.Enabled   := False;
  ReGerar.Enabled         := False;
  Compilar.Enabled        := False;
  Executar.Enabled        := False;
  BtnFecharProjeto.Enabled       := False;
  BtnDadosGenericos.Enabled      := False;
  //ListAssistente.Enabled         := False;
  //ListAssistente.Color           := clBtnFace;
  BtnTabelas.Enabled             := False;
  BtnFormularios.Enabled         := False;
  BtnRelatorios.Enabled          := False;
  BtnMenuPrincipal.Enabled       := False;
  BtnCompilar.Enabled            := False;
  BtnExecutar.Enabled            := False;
  EXE_Projeto.Caption            := 'Projeto';

  ListaProjetos.Visible  := True;  // BarraHistorico
  JvTabBar_Assistente.Tabs[1].Visible := ListaProjetos.Visible;  // BarraHistorico
  BtnNovoProjeto.Enabled  := True;
  BtnAbrirProjeto.Enabled := True;
  NovoProjeto.Enabled     := True;
  AbrirProjeto.Enabled    := True;
  FormPrincipal.Caption   := TituloXMaker;
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  TabGlobal.Free_Tabelas_Proj;
end;

procedure TFormPrincipal.BtnDadosGenericosClick(Sender: TObject);
begin
  FormDadosGenericos := TFormDadosGenericos.Create(Application);
  Try
    FormDadosGenericos.ShowModal;
  Finally
    FormDadosGenericos.Free;
  end;
  if TabGlobal_i.DPROJETO.Active then
    DefineCompilador;
end;

procedure TFormPrincipal.Reabrir;
var
  mnuItem: TMenuItem;
  i,y,t: Integer;
  NFile : string;
  Achou: Boolean;
  Posicao: string;
begin
  ListaProjetos.Items.Clear;
  PopMenuReabrirProjeto.Items.Clear;
  ListaNomeProj.Clear;
  ListaProjetos.Items.Add;
  ListaProjetos.Items[0].Caption := 'Novo Projeto ...';
  ListaProjetos.Items[0].ImageIndex := 0;
  t := 0;
  for I := 0 to 35 do
  begin
    if I < 10 then
      Posicao := StrZero(I,01)
    else
      Posicao := Chr(65 + I - 10);
    NFile := Trim(IniFile.readstring('PROJETOS', Posicao, ''));
    if NFile <> '' then
    begin
      Achou := False;
      for Y:=0 to ListaNomeProj.Count-1 do
        if UpperCase(ListaNomeProj[Y]) = UpperCase(NFile) then
          achou := True;
      if (FileExists(NFile)) and (not Achou) then
      begin
        if t < 10 then
          Posicao := StrZero(t,01)
        else
          Posicao := Chr(65 + t - 10);
        if t = 10 then
        begin
          mnuItem := NewItem('-', 0, False, True,
                             Nil, 0, 'mnuFile_divisao');
          PopMenuReabrirProjeto.Items.Add(mnuItem);
        end;
        ListaNomeProj.Add(NFile);
        mnuItem := NewItem(Posicao+' '+NFile, 0, False, True,
                   ReabrirOnClick, 0, 'mnuFile' + IntToStr(t));
        PopMenuReabrirProjeto.Items.Add(mnuItem);
        ListaProjetos.Items.Add;
        ListaProjetos.Items[ListaProjetos.Items.Count-1].Caption := Copy(ExtractFileName(NFile),01,Pos('.',ExtractFileName(NFile))-1);
        ListaProjetos.Items[ListaProjetos.Items.Count-1].ImageIndex := 1;
        inc(t);
      end;
    end;
  end;
end;

procedure TFormPrincipal.ReabrirOnClick(Sender: TObject);
var
  AFileName: String;
begin
  AFileName := Copy(TMenuItem(Sender).Caption,03,Length(TMenuItem(Sender).Caption)-2);
  AFileName := Trim(AFileName);
  if FileExists(AFileName) then
  begin
    if not NomeProjValido(AFileName) then
      exit;
    HabilitaProjeto(AFileName);
  end
  else
    Mensagem('Projeto não Encontrado !',ModAdvertencia,[ModOk]);
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
end;

procedure TFormPrincipal.Tabelas_Interna;

  procedure Grava_Tabela(Nome, Titulo: String);
  begin
    TabGlobal_i.DTABELAS.Inclui(Nil);
    TabGlobal_i.DTABELAS.NUMERO.Conteudo        := RetornaAutoIncremento(TabGlobal_i.DTABELAS, 'NUMERO', '');
    TabGlobal_i.DTABELAS.NOME.Conteudo          := Nome;
    TabGlobal_i.DTABELAS.TITULO_T.Conteudo      := Titulo;
    TabGlobal_i.DTABELAS.BASE.Conteudo          := 1;
    TabGlobal_i.DTABELAS.GLOBAL.Conteudo        := 1;
    TabGlobal_i.DTABELAS.ABRIR_TABELA.Conteudo  := 0;
    TabGlobal_i.DTABELAS.USE_GENERATOR.Conteudo := 1;
    TabGlobal_i.DTABELAS.Salva;
  end;

  procedure Grava_Campo(Sequencia: Integer; Nome, Titulo: String; Tipo, Tamanho, Chave: Integer; AutoIncremento: Integer = 0);
  begin
    TabGlobal_i.DCAMPOST.Inclui(Nil);
    TabGlobal_i.DCAMPOST.NUMERO.Conteudo      := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
    TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo   := Sequencia;
    TabGlobal_i.DCAMPOST.NOME.Conteudo        := Nome;
    TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo := 1;
    TabGlobal_i.DCAMPOST.TIPO.Conteudo        := Tipo;
    TabGlobal_i.DCAMPOST.TAMANHO.Conteudo     := Tamanho;
    TabGlobal_i.DCAMPOST.EDICAO.Conteudo      := 1;
    TabGlobal_i.DCAMPOST.TITULO_C.Conteudo    := Titulo;
    TabGlobal_i.DCAMPOST.CHAVE.Conteudo       := Chave;
    TabGlobal_i.DCAMPOST.CALCULADO.Conteudo   := 0;
    TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo := AutoIncremento;
    TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo := 1;
    TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo      := 0;
    TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo   := 0;
    TabGlobal_i.DCAMPOST.VALIDA_ONEXIT.Conteudo  := 1;
    TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo:= Sequencia-1;
    TabGlobal_i.DCAMPOST.Salva;
  end;

  procedure Grava_Relacionamento(Sequencia: Integer; Titulo, Chave_1, Chave_2, Tabela: String; Tipo: Integer);
  begin
    TabGlobal_i.DRELACIONA.Inclui(Nil);
    TabGlobal_i.DRELACIONA.NUMERO.Conteudo          := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
    TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo       := Sequencia;
    TabGlobal_i.DRELACIONA.ATIVO.Conteudo           := 1;
    TabGlobal_i.DRELACIONA.KEY_SQL.Conteudo         := 0;
    TabGlobal_i.DRELACIONA.TITULO_I.Conteudo        := Titulo;
    TabGlobal_i.DRELACIONA.TIPO.Conteudo            := Tipo;
    TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo  := Chave_1;
    TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo  := Chave_2;
    TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo := Tabela;
    TabGlobal_i.DRELACIONA.Salva;
  end;

begin
  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_NOMES', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_NOMES', 'Tabela de Usuários');

    Grava_Campo(1, 'Usuario', 'Usuário', 1, 20, 1);
    Grava_Campo(2, 'Senha', 'Senha', 1, 20, 0);
    Grava_Campo(3, 'Master', 'Master', 1, 1, 0);
    Grava_Campo(4, 'Grupo', 'Grupo', 1, 4, 0);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_GRUPOS', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_GRUPOS', 'Tabela de Grupos');

    Grava_Campo(1, 'Grupo', 'Grupo', 1, 4, 1);
    Grava_Campo(2, 'Descricao', 'Descrição', 1, 20, 0);

    Grava_Relacionamento(1, 'Menu Lateral', 'Grupo', 'Grupo', 'USER_MENU_LATERAL', 3);
    Grava_Relacionamento(2, 'Menu Superior', 'Grupo', 'Grupo', 'USER_MENU_SUPERIOR', 3);
    Grava_Relacionamento(3, 'Barra Ferramentas', 'Grupo', 'Grupo', 'USER_BARRA_F', 3);
    Grava_Relacionamento(4, 'Permissões em Tabelas', 'Grupo', 'Grupo', 'USER_TABELAS', 3);
    Grava_Relacionamento(5, 'Usuários', 'Grupo', 'Grupo', 'USER_NOMES', 2);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_MENU_LATERAL', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_MENU_LATERAL', 'Opções do Menu Lateral');

    Grava_Campo(1, 'Opcao', 'Opção', 2, 9, 1);
    Grava_Campo(2, 'Grupo', 'Grupo', 1, 4, 1);
    Grava_Campo(3, 'PorSenha', 'Por Senha', 1, 1, 0);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_MENU_SUPERIOR', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_MENU_SUPERIOR', 'Opções do Menu Superior');

    Grava_Campo(1, 'Opcao', 'Opção', 2, 9, 1);
    Grava_Campo(2, 'Grupo', 'Grupo', 1, 4, 1);
    Grava_Campo(3, 'PorSenha', 'Por Senha', 1, 1, 0);
    Grava_Campo(4, 'Invisivel', 'Invisivel', 1, 1, 0);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_BARRA_F', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_BARRA_F', 'Opções da Barra de Ferramentas');

    Grava_Campo(1, 'Opcao', 'Opção', 2, 9, 1);
    Grava_Campo(2, 'Grupo', 'Grupo', 1, 4, 1);
    Grava_Campo(3, 'PorSenha', 'Por Senha', 1, 1, 0);
    Grava_Campo(4, 'Invisivel', 'Invisivel', 1, 1, 0);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_TABELAS', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_TABELAS', 'Permissões em Tabelas');

    Grava_Campo(1, 'Tabela_Obj', 'Tabela', 1, 40, 1);
    Grava_Campo(2, 'Grupo', 'Grupo', 1, 4, 1);
    Grava_Campo(3, 'Cerceado', 'Cerceado', 1, 20, 0);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_LOG', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_LOG', 'Log de Operações');

    Grava_Campo(1, 'Usuario', 'Usuário', 1, 20, 0);
    Grava_Campo(2, 'Data', 'Data', 4, 8, 0);
    Grava_Campo(3, 'Hora', 'Hora', 1, 8, 0);
    Grava_Campo(4, 'Tabela', 'Tabela', 1, 80, 0);
    Grava_Campo(5, 'Tipo', 'Tipo de Operação', 1, 30, 0);
    Grava_Campo(6, 'Comando', 'Comando', 5, 1, 0);
    Grava_Campo(7, 'Estacao', 'Estação', 1, 40, 0);

    Grava_Relacionamento(1, 'Usuários', 'Usuario', 'Usuario', 'USER_NOMES', 1);
  end;

  TabGlobal_i.DTABELAS.First;
  if not TabGlobal_i.DTABELAS.Locate('NOME', 'USER_AGENDA', [loCaseInsensitive]) then
  begin
    Grava_Tabela('USER_AGENDA', 'Agenda de Telefones');

    Grava_Campo(1, 'Sequencia', 'Sequência', 2, 5, 1, 1);
    Grava_Campo(2, 'Usuario', 'Usuário', 1, 20, 0);
    Grava_Campo(3, 'Nome', 'Nome', 1, 50, 0);
    Grava_Campo(4, 'Telefone', 'Telefone', 1, 50, 0);
    Grava_Campo(5, 'Complemento', 'Tabela', 5, 1, 0);
    Grava_Campo(6, 'Compartilhado', 'Compartilhado', 2, 1, 0);

    Grava_Relacionamento(1, 'Usuários', 'Usuario', 'Usuario', 'USER_NOMES', 1);
  end;
end;

procedure TFormPrincipal.AtualizaCampoProjeto;
var
  Query: TIBQuery;
  Query_1: TIBSQL;
  Existe: Boolean;

  function Altera_Tipo_SQL(Banco: Integer; Tabela, Campo: String; NovoTipo: TFieldType; SQL, SQL_Update, Campo_Delete: String; Tamanho: Integer = 0): Boolean;
  var
    portamanho: Boolean;
  begin
    Result := False;
    Existe := False;
    Query_1 := TIBSQL.Create(self);
    try
      if Banco = 0 then
      begin
        Query_1.Database := BaseDados.BD_Base_Projeto;
        Query_1.Transaction := BaseDados.TRS_BD_Base_Projeto;
      end
      else if Banco = 1 then
      begin
        Query_1.Database := BaseDados.BD_Base_Dicionario;
        Query_1.Transaction := BaseDados.TRS_BD_Base_Dicionario;
      end;
      Query_1.SQL.Text :=
       'Select USER from RDB$RELATIONS where RDB$RELATION_NAME = ' +
       '''' +
       Tabela + '''';
      Query_1.Prepare;
      Query_1.ExecQuery;
      Existe := not Query_1.EOF;
    finally
      Query_1.Free;
    end;
    if Existe then
    begin
      Query := TIBQuery.Create(Self);
      try
        if Banco = 0 then
        begin
          Query.Database := BaseDados.BD_Base_Projeto;
          Query.Transaction := BaseDados.TRS_BD_Base_Projeto;
        end
        else if Banco = 1 then
        begin
          Query.Database := BaseDados.BD_Base_Dicionario;
          Query.Transaction := BaseDados.TRS_BD_Base_Dicionario;
        end;
        Query.SQL.Clear;
        Query.SQL.Add('Select First 1 * From '+Tabela);
        Query.Open;
        portamanho := False;
        if Tamanho > 0 then
        begin
          if (Query.FindField(Campo) <> Nil) and
             (Query.FindField(Campo).Size <> tamanho) then
            portamanho := True;
        end;
        if (Query.FindField(Campo) <> Nil) and
           ((Query.FindField(Campo).DataType <> NovoTipo) or portamanho) then
        begin
          Query.Close;
          Query.SQL.Clear;
          Query.SQL.Add(SQL);
          Query.ExecSQL;
          Query.Transaction.CommitRetaining;
          if Trim(SQL_Update) <> '' then
          begin
            Query.Close;
            Query.SQL.Clear;
            Query.SQL.Add(SQL_Update);
            Query.ExecSQL;
            Query.Transaction.CommitRetaining;
            Result := True;
          end;
          if Trim(Campo_Delete) <> '' then
          begin
            Query.Close;
            Query.SQL.Clear;
            Query.SQL.Add('ALTER TABLE ' + Tabela + ' Drop ' + Campo_Delete);
            Query.ExecSQL;
            Query.Transaction.CommitRetaining;
          end;
        end
        else
          Query.Close;
      finally
        Query.Free;
      end;
    end;
  end;

  function Processa_SQL(Banco: Integer; Tabela, Campo: String; SQL, SQL_UPDATE: String): Boolean;
  begin
    Existe := False;
    Query_1 := TIBSQL.Create(self);
    try
      if Banco = 0 then
      begin
        Query_1.Database := BaseDados.BD_Base_Projeto;
        Query_1.Transaction := BaseDados.TRS_BD_Base_Projeto;
      end
      else if Banco = 1 then
      begin
        Query_1.Database := BaseDados.BD_Base_Dicionario;
        Query_1.Transaction := BaseDados.TRS_BD_Base_Dicionario;
      end;
      Query_1.SQL.Text :=
       'Select USER from RDB$RELATIONS where RDB$RELATION_NAME = ' +
       '''' +
       Tabela + '''';
      Query_1.Prepare;
      Query_1.ExecQuery;
      Existe := not Query_1.EOF;
    finally
      Query_1.Free;
    end;
    if Existe then
    begin
      Query := TIBQuery.Create(Self);
      try
        if Banco = 0 then
        begin
          Query.Database := BaseDados.BD_Base_Projeto;
          Query.Transaction := BaseDados.TRS_BD_Base_Projeto;
        end
        else if Banco = 1 then
        begin
          Query.Database := BaseDados.BD_Base_Dicionario;
          Query.Transaction := BaseDados.TRS_BD_Base_Dicionario;
        end;
        Query.SQL.Clear;
        Query.SQL.Add('Select First 1 * From '+Tabela);
        Query.Open;
        if Query.FindField(Campo) = Nil then
        begin
          Query.Close;
          Query.SQL.Clear;
          Query.SQL.Add(SQL);
          Query.ExecSQL;
          Query.Transaction.CommitRetaining;
          if Trim(SQL_Update) <> '' then
          begin
            Query.Close;
            Query.SQL.Clear;
            Query.SQL.Add(SQL_Update);
            Query.ExecSQL;
            Query.Transaction.CommitRetaining;
          end;
          Processa_SQL := True;
        end
        else
          Query.Close;
      finally
        Query.Free;
      end;
    end;
  end;

  procedure Transfere_Calculos;
  begin
    Query := TIBQuery.Create(Self);
    Query_1 := TIBSQL.Create(self);
    try
      Query.Database := BaseDados.BD_Base_Dicionario;
      Query.Transaction := BaseDados.TRS_BD_Base_Dicionario;
      Query_1.Database := BaseDados.BD_Base_Dicionario;
      Query_1.Transaction := BaseDados.TRS_BD_Base_Dicionario;
      Query_1.SQL.Text := 'Select * from CALCULADOS';
      Query_1.Prepare;
      Query_1.ExecQuery;
      while not Query_1.EOF do
      begin
        Query.Close;
        Query.SQL.Text := 'Select * From Campost Where Numero = '+Query_1.FieldByName('NUMERO').AsString +
                                                 ' and Sequencia = ' + Query_1.FieldByName('SEQUENCIA').AsString;
        Query.Prepare;
        Query.Open;
        if not Query.Eof then
        begin
          Query.Close;
          Query.SQL.Clear;
          Query.SQL.Add('Update Campost');
          Query.SQl.Add('set VARIAVEIS = :VARIAVEIS, CODIFICACAO = :CODIFICACAO');
          Query.SQl.Add('Where Numero = '+Query_1.FieldByName('NUMERO').AsString);
          Query.SQL.Add(' and Sequencia = ' + Query_1.FieldByName('SEQUENCIA').AsString);
          Query.Prepare;
          Query.ParamByName('VARIAVEIS').AsString := Query_1.FieldByName('VARIAVEIS').AsString;
          Query.ParamByName('CODIFICACAO').AsString := Query_1.FieldByName('CODIFICACAO').AsString;
          Query.ExecSQL;
        end;
        Query_1.Next;
      end;
      Query_1.Close;
      Query.Close;
    finally
      Query_1.Free;
      Query.Free;
    end;
  end;

begin
  try
    Processa_SQL(1, 'TABELAS', 'NOME_INTERNO', 'ALTER TABLE TABELAS ADD NOME_INTERNO VARCHAR(20)', '');
    Processa_SQL(0, 'PROJETO', 'MODELO', 'ALTER TABLE PROJETO ADD MODELO INTEGER', '');
    Processa_SQL(0, 'PROJETO', 'TABELAS_UTILIZADAS', 'ALTER TABLE PROJETO ADD TABELAS_UTILIZADAS BLOB SUB_TYPE 1, ADD OBJETOS_PROJETO SMALLINT', '');
    Processa_SQL(0, 'FORMULARIO', 'MODELO', 'ALTER TABLE FORMULARIO ADD MODELO VARCHAR(80)', '');
    Processa_SQL(1, 'TABELAS', 'GLOBAL', 'ALTER TABLE TABELAS ADD GLOBAL SMALLINT', 'UPDATE TABELAS SET GLOBAL = 1');
    Processa_SQL(1, 'TABELAS', 'ABRIR_TABELA', 'ALTER TABLE TABELAS ADD ABRIR_TABELA SMALLINT', 'UPDATE TABELAS SET ABRIR_TABELA = 1');
    Processa_SQL(1, 'TABELAS', 'USE_GENERATOR', 'ALTER TABLE TABELAS ADD USE_GENERATOR SMALLINT', 'UPDATE TABELAS SET USE_GENERATOR = 1');
    Processa_SQL(1, 'PROCESSOS', 'AVULSO', 'ALTER TABLE PROCESSOS ADD AVULSO BLOB SUB_TYPE 1', '');
    Processa_SQL(1, 'PROCESSOS', 'AVULSO_VAR', 'ALTER TABLE PROCESSOS ADD AVULSO_VAR BLOB SUB_TYPE 1', '');
    Processa_SQL(0, 'RELATORIO', 'SQL', 'ALTER TABLE RELATORIO ADD SQL BLOB SUB_TYPE 1, ADD SQL_ATIVO SMALLINT', 'UPDATE RELATORIO SET SQL_ATIVO = 0');
    Processa_SQL(0, 'PROJETO', 'CONTROLE_ACESSO_INTERNO', 'ALTER TABLE PROJETO ADD CONTROLE_ACESSO_INTERNO SMALLINT', 'UPDATE PROJETO SET CONTROLE_ACESSO_INTERNO = 0');
    Processa_SQL(1, 'CAMPOST', 'NOME_FISICO', 'ALTER TABLE CAMPOST ADD NOME_FISICO VARCHAR(100)', '');
    Processa_SQL(1, 'CAMPOST', 'TIPO_FISICO', 'ALTER TABLE CAMPOST ADD TIPO_FISICO SMALLINT', '');
    Processa_SQL(1, 'CAMPOST', 'SQL_EXTRA', 'ALTER TABLE CAMPOST ADD SQL_EXTRA VARCHAR(100), ADD SEM_INSERT SMALLINT', 'UPDATE CAMPOST SET SEM_INSERT = 0');
    Processa_SQL(1, 'CAMPOST', 'VALIDA_ONEXIT', 'ALTER TABLE CAMPOST ADD VALIDA_ONEXIT SMALLINT', 'UPDATE CAMPOST SET VALIDA_ONEXIT = 1');
    Processa_SQL(1, 'CAMPOST', 'SQL_EXTRA_INSERT', 'ALTER TABLE CAMPOST ADD SQL_EXTRA_INSERT VARCHAR(100)', '');
    if Processa_SQL(1, 'CAMPOST', 'VARIAVEIS', 'ALTER TABLE CAMPOST ADD VARIAVEIS BLOB SUB_TYPE 1, ADD CODIFICACAO BLOB SUB_TYPE 1', '') then
      Transfere_Calculos;
    Processa_SQL(1, 'PROCESSOS', 'ATIVO', 'ALTER TABLE PROCESSOS ADD ATIVO SMALLINT;', 'UPDATE PROCESSOS SET ATIVO = 1');
    Processa_SQL(1, 'RELACIONA', 'ATIVO', 'ALTER TABLE RELACIONA ADD ATIVO SMALLINT', 'UPDATE RELACIONA SET ATIVO = 1');
    Processa_SQL(1, 'RELACIONA', 'KEY_SQL', 'ALTER TABLE RELACIONA ADD KEY_SQL SMALLINT', 'UPDATE RELACIONA SET KEY_SQL = 0');
    if Altera_Tipo_SQL(1, 'CAMPOST', 'VALIDOS', ftMemo, 'ALTER TABLE CAMPOST ADD VALIDOS_tmp BLOB SUB_TYPE 1', 'UPDATE CAMPOST SET VALIDOS_tmp = VALIDOS', '') then
      if Altera_Tipo_SQL(1, 'CAMPOST', 'VALIDOS', ftMemo, 'ALTER TABLE CAMPOST DROP VALIDOS', 'ALTER TABLE CAMPOST ADD VALIDOS BLOB SUB_TYPE 1', '') then
        Altera_Tipo_SQL(1, 'CAMPOST', 'VALIDOS', ftString, 'UPDATE CAMPOST SET VALIDOS = VALIDOS_tmp', '', 'VALIDOS_tmp');
    if Altera_Tipo_SQL(1, 'CAMPOST', 'DESCRICAO', ftMemo, 'ALTER TABLE CAMPOST ADD DESCRICAO_tmp BLOB SUB_TYPE 1', 'UPDATE CAMPOST SET DESCRICAO_tmp = DESCRICAO', '') then
      if Altera_Tipo_SQL(1, 'CAMPOST', 'DESCRICAO', ftMemo, 'ALTER TABLE CAMPOST DROP DESCRICAO', 'ALTER TABLE CAMPOST ADD DESCRICAO BLOB SUB_TYPE 1', '') then
        Altera_Tipo_SQL(1, 'CAMPOST', 'DESCRICAO', ftString, 'UPDATE CAMPOST SET DESCRICAO = DESCRICAO_tmp', '', 'DESCRICAO_tmp');
    if Altera_Tipo_SQL(1, 'CAMPOST', 'TAB_ESTRANGEIRA', ftString, 'ALTER TABLE CAMPOST ADD TAB_ESTRANGEIRA_tmp VARCHAR(30)', 'UPDATE CAMPOST SET TAB_ESTRANGEIRA_tmp = TAB_ESTRANGEIRA', '', 30) then
      if Altera_Tipo_SQL(1, 'CAMPOST', 'TAB_ESTRANGEIRA', ftString, 'ALTER TABLE CAMPOST DROP TAB_ESTRANGEIRA', 'ALTER TABLE CAMPOST ADD TAB_ESTRANGEIRA VARCHAR(30)', '', 30) then
        Altera_Tipo_SQL(1, 'CAMPOST', 'TAB_ESTRANGEIRA', ftString, 'UPDATE CAMPOST SET TAB_ESTRANGEIRA = TAB_ESTRANGEIRA_tmp', '', 'TAB_ESTRANGEIRA_tmp', 20);
  except
    on Erro: Exception do
      Mensagem('Erro: '+Erro.Message,modErro,[modOk]);
  end;
end;

procedure TFormPrincipal.AtualizarVersao(Versao: String);
var
  I, Y, QtLinhas, Seq, Nivel: Integer;
  NForm : String;
  ListaVinculo: TStringList;
  ListaVinculo2: TStringList;
  Query: TIBQuery;
  Passar: Boolean;

  procedure AtualizaFonte(Nome: String);
  begin
    if FileExists(Projeto.Pasta + Nome + '.Dcu' ) then
      DeleteFile(Projeto.Pasta + Nome + '.Dcu');
    if FileExists(Projeto.Pasta + Nome + '.Pas' ) then
      DeleteFile(Projeto.Pasta + Nome + '.Pas');
    if FileExists(Projeto.Pasta + Nome + '.Dfm' ) then
      DeleteFile(Projeto.Pasta + Nome + '.Dfm');
  end;

begin
  Passar := False;
  ListaVinculo  := TStringList.Create;
  ListaVinculo2 := TStringList.Create;
  if (Versao = '1.0') or (Versao = '1.1') then
  begin
    Query := TIBQuery.Create(Self);

    Query.Database := BaseDados.BD_Base_Dicionario;
    Query.Transaction := BaseDados.TRS_BD_Base_Dicionario;
    Query.SQL.Text := 'ALTER TABLE BDADOS ADD HOST_NAME VARCHAR(30)';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.SQL.Text := 'ALTER TABLE BDADOS ADD ARQUIVO1 VARCHAR(30)';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.SQL.Text := 'UPDATE BDADOS SET ARQUIVO1 = ARQUIVO';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.SQL.Text := 'ALTER TABLE BDADOS DROP ARQUIVO';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.SQL.Text := 'ALTER TABLE BDADOS ADD ARQUIVO VARCHAR(30)';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.SQL.Text := 'UPDATE BDADOS SET ARQUIVO = ARQUIVO1';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.SQL.Text := 'ALTER TABLE BDADOS DROP ARQUIVO1';
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;
    Query.Free;
    IniFile.WriteString('XMAKER', 'Versao', Projeto.VersaoGerador);
    Passar := True;
  end;
  if (Versao = '1.2') or (Passar) then
  begin
    ForceDirectories(Projeto.Pasta+'Copia');
    ChDir(Projeto.Pasta);
    if FileExists(Projeto.Pasta + 'Tabela.Pas') then
    begin
      CopiaArquivo(Projeto.Pasta + 'Tabela.Pas', Projeto.Pasta + 'Copia\Tabela.Pas');
      DeleteFile(Projeto.Pasta + 'Tabela.Pas');
    end;
    if FileExists(Projeto.Pasta + 'Abertura.Pas') then
    begin
      CopiaArquivo(Projeto.Pasta + 'Abertura.Pas', Projeto.Pasta + 'Copia\Abertura.Pas');
      DeleteFile(Projeto.Pasta + 'Abertura.Pas');
    end;
    if FileExists(Projeto.Pasta + 'Rotinas.Pas') then
    begin
      CopiaArquivo(Projeto.Pasta + 'Rotinas.Pas', Projeto.Pasta + 'Copia\Rotinas.Pas');
      DeleteFile(Projeto.Pasta + 'Rotinas.Pas');
    end;
    RegerarModulos := True;
    IniFile.WriteString('XMAKER', 'Versao', Projeto.VersaoGerador);
    Passar := True;
  end;
  if (Versao = '1.3') or (Versao = '2.0') or (Versao = '2.1') or (Passar) then
  begin
    FormAguarde := TFormAguarde.Create(Application);
    FormAguarde.Caption := 'Aguarde! Atualizando projeto ...';
    FormAguarde.Show;
    FormAguarde.GaugeProcesso.Min := 0;
    FormAguarde.GaugeProcesso.Max := 11;
    FormAguarde.GaugeProcesso.Position := 0;

    Query := TIBQuery.Create(Self);
    try
      Query.Database := BaseDados.BD_Base_Projeto;
      Query.Transaction := BaseDados.TRS_BD_Base_Projeto;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE PROJETO ADD BDCONEXAO SMALLINT,');
      Query.SQL.Add('                    ADD SELECIONAR_EMP SMALLINT,');
      Query.SQL.Add('                    ADD MENUXP SMALLINT,');
      Query.SQL.Add('                    ADD DEIXAR_NA_SENHA SMALLINT');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('UPDATE PROJETO SET BDCONEXAO = 1,');
      Query.SQL.Add('                   SELECIONAR_EMP = 0,');
      Query.SQL.Add('                   MENUXP = 0,');
      Query.SQL.Add('                   DEIXAR_NA_SENHA = 0');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE MENU ADD IDENTIFICACAO SMALLINT');
      Query.ExecSQL;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('UPDATE MENU SET IDENTIFICACAO = NUMERO - 1');
      Query.ExecSQL;
      Query.Transaction.CommitRetaining;

      Query.Database := BaseDados.BD_Base_Dicionario;
      Query.Transaction := BaseDados.TRS_BD_Base_Dicionario;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE BDADOS ADD BDADOS SMALLINT,');
      Query.SQL.Add('                   ADD PADRAO SMALLINT');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Text := 'UPDATE BDADOS SET PADRAO = 1';
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE TABELAS ADD FILTRO_INICIAL BLOB SUB_TYPE TEXT SEGMENT SIZE 80,');
      Query.SQL.Add('                    ADD FILTRO_MESTRE BLOB SUB_TYPE TEXT SEGMENT SIZE 80,');
      Query.SQL.Add('                    ADD ORDEM_INICIAL VARCHAR(300),');
      Query.SQL.Add('                    ADD ORDEM_DECRESCENTE SMALLINT,');
      Query.SQL.Add('                    ADD NOME_INTERNO VARCHAR(20)');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Text := 'UPDATE TABELAS SET ORDEM_DECRESCENTE = 0';
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE CAMPOST ADD AUTOINCREMENTO SMALLINT,');
      Query.SQL.Add('                    ADD SEMPRE_ATRIBUI SMALLINT,');
      Query.SQL.Add('                    ADD INVISIVEL SMALLINT,');
      Query.SQL.Add('                    ADD PRE_VALIDACAO VARCHAR(300),');
      Query.SQL.Add('                    ADD TIPO_PRE_VALIDACAO SMALLINT,');
      Query.SQL.Add('                    ADD LIMPAR_CAMPO SMALLINT,');
      Query.SQL.Add('                    ADD MSG_ERRO VARCHAR(100),');
      Query.SQL.Add('                    ADD TAB_ESTRANGEIRA VARCHAR(20),');
      Query.SQL.Add('                    ADD CAMPO_CHAVE VARCHAR(40),');
      Query.SQL.Add('                    ADD CAMPOS_VISUAIS VARCHAR(300),');
      Query.SQL.Add('                    ADD ESTILO_CHAVE SMALLINT,');
      Query.SQL.Add('                    ADD FILTRO_MESTRE BLOB SUB_TYPE TEXT SEGMENT SIZE 80,');
      Query.SQL.Add('                    ADD ACAO_PESQUISA SMALLINT,');
      Query.SQL.Add('                    ADD INDICE_CONSULTA SMALLINT,');
      Query.SQL.Add('                    ADD EXTRA SMALLINT,');
      Query.SQL.Add('                    ADD TAB_EXTRA VARCHAR(20),');
      Query.SQL.Add('                    ADD CAMPO_EXTRA VARCHAR(40),');
      Query.SQL.Add('                    ADD VALIDOS1 VARCHAR(300),');
      Query.SQL.Add('                    ADD DESCRICAO1 VARCHAR(300),');
      Query.SQL.Add('                    ADD TAB_PESQUISA VARCHAR(20),');
      Query.SQL.Add('                    ADD NAO_VIRTUAL SMALLINT');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('UPDATE CAMPOST SET AUTOINCREMENTO = 0,');
      Query.SQL.Add('                   SEMPRE_ATRIBUI = 0,');
      Query.SQL.Add('                   INVISIVEL = 0,');
      Query.SQL.Add('                   TIPO_PRE_VALIDACAO = 1,');
      Query.SQL.Add('                   LIMPAR_CAMPO = 0,');
      Query.SQL.Add('                   EXTRA = 0,');
      Query.SQL.Add('                   INDICE_CONSULTA = SEQUENCIA - 1,');
      Query.SQL.Add('                   ESTILO_CHAVE = 0,');
      Query.SQL.Add('                   VALIDOS1 = VALIDOS,');
      Query.SQL.Add('                   DESCRICAO1 = DESCRICAO,');
      Query.SQL.Add('                   NAO_VIRTUAL = 0');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE CAMPOST DROP VALIDOS,');
      Query.SQL.Add('                    DROP DESCRICAO');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE CAMPOST ADD VALIDOS VARCHAR(300),');
      Query.SQL.Add('                    ADD DESCRICAO VARCHAR(300)');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('UPDATE CAMPOST SET VALIDOS = VALIDOS1,');
      Query.SQL.Add('                   DESCRICAO = DESCRICAO1');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      Query.SQL.Clear;
      Query.SQL.Add('ALTER TABLE CAMPOST DROP VALIDOS1,');
      Query.SQL.Add('                    DROP DESCRICAO1');
      Query.ExecSQL;
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
      Query.Transaction.CommitRetaining;

      IniFile.WriteString('XMAKER', 'Versao', Projeto.VersaoGerador);
    Finally
      Query.Free;
      FormAguarde.Free;
    end;
    ForceDirectories(Projeto.Pasta+'Copia');
    ChDir(Projeto.Pasta);
    AtualizaFonte('Abertura');
    AtualizaFonte('Ambiente');
    AtualizaFonte('Atributo');
    AtualizaFonte('Backup');
    AtualizaFonte('BaseD');
    AtualizaFonte('Campo_Adapter');
    AtualizaFonte('CfgEmp');
    AtualizaFonte('Emp_Adapter');
    AtualizaFonte('Estrutur');
    AtualizaFonte('GridPesquisa');
    AtualizaFonte('Princ_Adapter');
    AtualizaFonte('Publicas');
    AtualizaFonte('Restaura');
    AtualizaFonte('RotinaEd');
    AtualizaFonte('Rotinas');
    AtualizaFonte('SelEmp');
    AtualizaFonte('Tabela');
    AtualizaFonte('Princ');
    AtualizaFonte('Interno');
    AtualizaFonte('EdGrp');
    AtualizaFonte('Acesso');
    RegerarModulos := True;
  end
  else
    IniFile.WriteString('XMAKER', 'Versao', Projeto.VersaoGerador);
  ListaVinculo.Free;
  ListaVinculo2.Free;
end;

function TFormPrincipal.HabilitaProjeto(Arquivo: String): Boolean;
var
  I : Integer;
  ExisteReAbrir,Achou : Boolean;
  VersaoG: String;
  AtualizaVersao: String;
  Posicao, Posicao2: String;
begin
  Projeto.Adapter := False;
  AtualizaVersao := '';
  IniFile := TInifile.Create(Arquivo);
  VersaoG := IniFile.readstring('XMAKER', 'Versao', '');
  if VersaoG <> Projeto.VersaoGerador then
  begin
    if VersaoG = '' then
    begin
       Mensagem('Arquivo não é de Projeto do X-Maker !',ModAdvertencia,[ModOk]);
       Result := False;
       IniFile.Free;
       abort;
    end
    else if VersaoG > Projeto.VersaoGerador then
    begin
       Mensagem('O Projeto pertence a uma versão posterir a atual'+ ^M +
                'adquira a versão atual, para abertura do mesmo !',ModInformacao,[ModOk]);
       Result := False;
       IniFile.Free;
       abort;
    end
    else if (VersaoG < Projeto.VersaoGerador) then
    begin
       if Mensagem('O Projeto pertence a uma versão anterior a atual.'+ ^M +
                   'Prosseguir e atualizar o projeto ?               ',ModConfirmacao,[ModSim, ModNao]) = mrNo then
       begin
         Result := False;
         IniFile.Free;
         abort;
       end
       else
         AtualizaVersao := Trim(VersaoG);
    end;
  end;

  Projeto.Nome     := Arquivo;
  Projeto.Pasta    := DiretorioComBarra(ExtractFilePath(Projeto.Nome));
  if Projeto.UsoemRede then
  begin
    Projeto.Servidor_Pro := IniFile.ReadString('PROJETO', 'Servidor_Pro', '');
    Projeto.Servidor_Dic := IniFile.ReadString('PROJETO', 'Servidor_Dic', '');
    Projeto.Pasta_projeto:= IniFile.ReadString('PROJETO', 'Pasta_pro', '');
  end;
  if IniFile.readstring('PROJETO', 'Dicionario', '') = '1' then
  begin
    Projeto.Dicionario     := IniFile.readstring('PROJETO', 'Localizacao', '');
    Projeto.Dicionario_Hab := True;
  end
  else
  begin
    Projeto.Dicionario     := Projeto.Pasta;
    Projeto.Dicionario_Hab := False;
  end;
  Projeto.ArquivoMenu    := Projeto.Pasta + ExtractFileName(Projeto.Nome);
  Projeto.ArquivoMenu    := Copy(Projeto.ArquivoMenu,01,Length(Projeto.ArquivoMenu)-03)+'Mnu';
  ArqDefBarra            := Copy(Projeto.ArquivoMenu,01,Length(Projeto.ArquivoMenu)-03)+'Bar';
  Projeto.ArquivoForm    := Copy(Projeto.ArquivoMenu,01,Length(Projeto.ArquivoMenu)-03)+'For';
  Projeto.ArquivoProj    := Projeto.Pasta + ExtractFileName(Projeto.Nome);
  Projeto.ArquivoProj    := Copy(Projeto.ArquivoProj,01,Length(Projeto.ArquivoProj)-03)+'Dpr';
  Projeto.Posicao_BD     := 0;
  Projeto.Posicao_FD     := 0;
  Projeto.Posicao_VR     := 0;
  Projeto.Posicao_IT     := 0;
  Projeto.Formulario_Ult := '';

  try
    Screen.Cursor := crHourGlass;
    BaseDados.ConectaBase(Projeto.Pasta + 'Projeto.Pro', 0);
    BaseDados.ConectaBase(Projeto.Dicionario + 'Dicionar.Dic', 1);
  except
    if (Trim(Projeto.Servidor_Pro) <> '') or
       (Trim(Projeto.Servidor_Dic) <> '') then
      Mensagem('Erro na abertura do projeto !'+^M+^M+'Verifique se o servidor está disponível ...',modErro,[modOk])
    else if Projeto.Dicionario_hab then
      Mensagem('Erro na abertura do projeto !'+^M+^M+'Verifique se a pasta do dicionário está disponível ...',modErro,[modOk])
    else
      Mensagem('Erro na abertura do projeto !',modErro,[modOk]);
    BaseDados.BD_Base_Projeto.Close;
    BaseDados.BD_Base_Dicionario.Close;
    Screen.Cursor := crDefault;
    Exit;
  end;
  Screen.Cursor := crDefault;

  ListaProjetos.Visible    := False;  // BarraHistorico
  JvTabBar_Assistente.Tabs[1].Visible := ListaProjetos.Visible;  // BarraHistorico
  BtnNovoProjeto.Enabled    := False;
  BtnAbrirProjeto.Enabled   := False;
  NovoProjeto.Enabled       := False;
  AbrirProjeto.Enabled      := False;

  RegerarModulos := False;
  if AtualizaVersao <> '' then
    AtualizarVersao(AtualizaVersao);
  AtualizaCampoProjeto;
  TabGlobal_i.AbrirTabelas;
  Tabelas_Interna;
  TabGlobal_i.DPROJETO.First;

  FecharProjeto.Enabled     := True;
  DiarioProjeto.Enabled     := True;
  BtnDiario.Enabled         := True;
  DadosGenericos.Enabled    := True;
  Tabelas.Enabled           := True;
  Formularios.Enabled       := True;
  Relatorios.Enabled        := True;
  MenuPrincipal.Enabled     := True;
  ReGerar.Enabled           := True;
  Compilar.Enabled          := True;
  Executar.Enabled          := True;
  BtnFecharProjeto.Enabled  := True;
  BtnDadosGenericos.Enabled := True;
  //ListAssistente.Enabled    := True;
  //ListAssistente.Color      := clWindow;
  BtnTabelas.Enabled        := True;
  BtnFormularios.Enabled    := True;
  BtnRelatorios.Enabled     := True;
  BtnMenuPrincipal.Enabled  := True;
  BtnCompilar.Enabled       := True;
  BtnExecutar.Enabled       := True;
  EXE_Projeto.Caption       := ExtractFileName(Projeto.ArquivoProj);
  EXE_Projeto.Caption       := Copy(EXE_Projeto.Caption, 01, Pos('.', EXE_Projeto.Caption)-1);
  if Trim(EXE_Projeto.Caption) = '' then
    EXE_Projeto.Caption := 'Projeto';

  Projeto.Titulo     := IniFile.ReadString('PROJETO', 'Titulo', '');
  StrCompTree        := '';
  StrCompImFundo     := '';
  StrCompImSplash    := '';

  IniFile.Free;

  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  Projeto.RXLib := IniFile.ReadBool('FORMULARIOS', 'RxLib', False);
  ExisteReabrir := False;
  for I := 0 to 35 do
  begin
    if I < 10 then
      Posicao := StrZero(I,01)
    else
      Posicao := Chr(65 + I - 10);
    if UpperCase(IniFile.readstring('PROJETOS', Posicao, '')) = UpperCase(Projeto.Nome) then
      ExisteReabrir := True;
  end;
  if not (UpperCase(IniFile.readstring('PROJETOS', StrZero(0,01), '')) = UpperCase(Projeto.Nome)) then
  begin
    if not ExisteReabrir then
    begin
      for I := 35 downto 1 do
      begin
        if I < 10 then
          Posicao := StrZero(I,01)
        else
          Posicao := Chr(65 + I - 10);
        if I-1 < 10 then
          Posicao2 := StrZero(I-1,01)
        else
          Posicao2 := Chr(65 + I - 1 - 10);
        IniFile.WriteString('PROJETOS', Posicao,
                IniFile.readstring('PROJETOS', Posicao2, '') );
      end;
    end
    else
    begin
      Achou := False;
      for I := 35 downto 1 do
      begin
        if I < 10 then
          Posicao := StrZero(I,01)
        else
          Posicao := Chr(65 + I - 10);
        if I-1 < 10 then
          Posicao2 := StrZero(I-1,01)
        else
          Posicao2 := Chr(65 + I - 1 - 10);
        if UpperCase(IniFile.readstring('PROJETOS', Posicao, '')) = UpperCase(Projeto.Nome) then
          Achou := True;
        if Achou then
          IniFile.WriteString('PROJETOS', Posicao,
                 IniFile.readstring('PROJETOS', Posicao2, '') );
      end;
      if not Achou then
      begin
        for I := 35 downto 1 do
        begin
          if I < 10 then
            Posicao := StrZero(I,01)
          else
            Posicao := Chr(65 + I - 10);
          if I-1 < 10 then
            Posicao2 := StrZero(I-1,01)
          else
            Posicao2 := Chr(65 + I - 1 - 10);
          IniFile.WriteString('PROJETOS', Posicao,
                 IniFile.readstring('PROJETOS', Posicao2, '') );
        end;
      end;
    end;
  end;
  IniFile.WriteString('PROJETOS', '0', Projeto.Nome);
  Reabrir;
  IniFile.Free;
  Busca_PastaFontes(TabGlobal_i.DPROJETO.MODELO.Conteudo);
  DefineCompilador;
  FormPrincipal.Caption := 'X-Maker '+IIF(Trim(Projeto.Beta_Versao)<>'',Projeto.Beta_Versao,Projeto.VersaoGerador)+', [ '+Projeto.Nome+' ]';
  ForceDirectories(Projeto.Pasta+'Imagens');
  ChDir(Projeto.Pasta);
  CopiaFontes;
  if RegerarModulos then
  begin
    Screen.Cursor := crHourGlass;
    Gera_BaseDados;
    Gera_CTabelas(True);
    Gera_CCalculos;
    Gera_Abertura;
    Gera_Adapter;
    Screen.Cursor := crDefault;
    RegerarModulos := False;
  end;

  TabGlobal.Ini_Tabelas_proj;

  Result := True;
end;

procedure TFormPrincipal.CopiaFontes;
begin
  if not FileExists(Projeto.Pasta + 'Splash.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Splash.Pas', Projeto.Pasta + 'Splash.Pas');
  if not FileExists(Projeto.Pasta + 'Splash.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Splash.Dfm', Projeto.Pasta + 'Splash.Dfm');
  if not FileExists(Projeto.Pasta + 'Rotinas.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Rotinas.Pas', Projeto.Pasta + 'Rotinas.Pas');
  if not FileExists(Projeto.Pasta + 'RotinaEd.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'RotinaEd.Pas', Projeto.Pasta + 'RotinaEd.Pas');
  if not FileExists(Projeto.Pasta + 'Extras.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Extras.Pas', Projeto.Pasta + 'Extras.Pas');
  if not FileExists(Projeto.Pasta + 'Interno.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Interno.Pas', Projeto.Pasta + 'Interno.Pas');
  if not FileExists(Projeto.Pasta + 'Publicas.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Publicas.Pas', Projeto.Pasta + 'Publicas.Pas');
  if not FileExists(Projeto.Pasta + 'Validac.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Validar.Pas', Projeto.Pasta + 'Validar.Pas');
  if not FileExists(Projeto.Pasta + 'Princ.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Princ.Pas', Projeto.Pasta + 'Princ.Pas');
  if not FileExists(Projeto.Pasta + 'Princ.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Princ.Dfm', Projeto.Pasta + 'Princ.Dfm');
  if not FileExists(Projeto.Pasta + 'Princ.Res') then
    CopiaArquivo(Projeto.PastaFontes + 'Princ.Res', Projeto.Pasta + 'Princ.Res');
  if not FileExists(Projeto.Pasta + 'Calend.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Calend.Pas', Projeto.Pasta + 'Calend.Pas');
  if not FileExists(Projeto.Pasta + 'Calend.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Calend.Dfm', Projeto.Pasta + 'Calend.Dfm');
  if not FileExists(Projeto.Pasta + 'Calculad.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Calculad.Pas', Projeto.Pasta + 'Calculad.Pas');
  if not FileExists(Projeto.Pasta + 'Calculad.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Calculad.Dfm', Projeto.Pasta + 'Calculad.Dfm');
  if not FileExists(Projeto.Pasta + 'Acesso.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Acesso.Pas', Projeto.Pasta + 'Acesso.Pas');
  if not FileExists(Projeto.Pasta + 'Acesso.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Acesso.Dfm', Projeto.Pasta + 'Acesso.Dfm');
  if not FileExists(Projeto.Pasta + 'Senhas.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Senhas.Pas', Projeto.Pasta + 'Senhas.Pas');
  if not FileExists(Projeto.Pasta + 'Senhas.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Senhas.Dfm', Projeto.Pasta + 'Senhas.Dfm');
  if not FileExists(Projeto.Pasta + 'Sobre.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Sobre.Pas', Projeto.Pasta + 'Sobre.Pas');
  if not FileExists(Projeto.Pasta + 'Sobre.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Sobre.Dfm', Projeto.Pasta + 'Sobre.Dfm');
  if not FileExists(Projeto.Pasta + 'Tabela.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Tabela.Pas', Projeto.Pasta + 'Tabela.Pas');
  if not FileExists(Projeto.Pasta + 'BaseD.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'BaseD.Pas', Projeto.Pasta + 'BaseD.Pas');
  if not FileExists(Projeto.Pasta + 'BaseD.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'BaseD.Dfm', Projeto.Pasta + 'BaseD.Dfm');
  if not FileExists(Projeto.Pasta + 'BaseD.Dti') then
    CopiaArquivo(Projeto.PastaFontes + 'BaseD.Dti', Projeto.Pasta + 'BaseD.Dti');
  if not FileExists(Projeto.Pasta + 'CfgEmp.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'CfgEmp.Pas', Projeto.Pasta + 'CfgEmp.Pas');
  if not FileExists(Projeto.Pasta + 'CfgEmp.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'CfgEmp.Dfm', Projeto.Pasta + 'CfgEmp.Dfm');
  if not FileExists(Projeto.Pasta + 'CfgEmp.Res') then
    CopiaArquivo(Projeto.PastaFontes + 'CfgEmp.Res', Projeto.Pasta + 'CfgEmp.Res');
  if not FileExists(Projeto.Pasta + 'SelEmp.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'SelEmp.Pas', Projeto.Pasta + 'SelEmp.Pas');
  if not FileExists(Projeto.Pasta + 'SelEmp.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'SelEmp.Dfm', Projeto.Pasta + 'SelEmp.Dfm');
  if not FileExists(Projeto.Pasta + 'Estrutur.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Estrutur.Pas', Projeto.Pasta + 'Estrutur.Pas');
  if not FileExists(Projeto.Pasta + 'Atributo.Pas') then
     CopiaArquivo(Projeto.PastaFontes + 'Atributo.Pas', Projeto.Pasta + 'Atributo.Pas');
  if not FileExists(Projeto.Pasta + 'Adapter.Dpr') then
    CopiaArquivo(Projeto.PastaFontes + 'Adapter.Dpr', Projeto.Pasta + 'Adapter.Dpr');
  if not FileExists(Projeto.Pasta + 'Adapter.Res') then
    CopiaArquivo(Projeto.PastaFontes + 'Adapter.Res', Projeto.Pasta + 'Adapter.Res');
  if not FileExists(Projeto.Pasta + 'Princ_Adapter.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Princ_Adapter.Pas', Projeto.Pasta + 'Princ_Adapter.Pas');
  if not FileExists(Projeto.Pasta + 'Princ_Adapter.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Princ_Adapter.Dfm', Projeto.Pasta + 'Princ_Adapter.Dfm');
  if not FileExists(Projeto.Pasta + 'Campo_Adapter.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Campo_Adapter.Pas', Projeto.Pasta + 'Campo_Adapter.Pas');
  if not FileExists(Projeto.Pasta + 'Campo_Adapter.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Campo_Adapter.Dfm', Projeto.Pasta + 'Campo_Adapter.Dfm');
  if not FileExists(Projeto.Pasta + 'Emp_Adapter.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Emp_Adapter.Pas', Projeto.Pasta + 'Emp_Adapter.Pas');
  if not FileExists(Projeto.Pasta + 'Emp_Adapter.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Emp_Adapter.Dfm', Projeto.Pasta + 'Emp_Adapter.Dfm');
  if not FileExists(Projeto.Pasta + 'Agenda.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Agenda.Pas', Projeto.Pasta + 'Agenda.Pas');
  if not FileExists(Projeto.Pasta + 'Agenda.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Agenda.Dfm', Projeto.Pasta + 'Agenda.Dfm');
  if not FileExists(Projeto.Pasta + 'AgEdit.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'AgEdit.Pas', Projeto.Pasta + 'AgEdit.Pas');
  if not FileExists(Projeto.Pasta + 'AgEdit.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'AgEdit.Dfm', Projeto.Pasta + 'AgEdit.Dfm');
  if not FileExists(Projeto.Pasta + 'EdUsr.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'EdUsr.Pas', Projeto.Pasta + 'EdUsr.Pas');
  if not FileExists(Projeto.Pasta + 'EdUsr.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'EdUsr.Dfm', Projeto.Pasta + 'EdUsr.Dfm');
  if not FileExists(Projeto.Pasta + 'EdGrp.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'EdGrp.Pas', Projeto.Pasta + 'EdGrp.Pas');
  if not FileExists(Projeto.Pasta + 'EdGrp.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'EdGrp.Dfm', Projeto.Pasta + 'EdGrp.Dfm');
  if not FileExists(Projeto.Pasta + 'Ambiente.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Ambiente.Pas', Projeto.Pasta + 'Ambiente.Pas');
  if not FileExists(Projeto.Pasta + 'Ambiente.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Ambiente.Dfm', Projeto.Pasta + 'Ambiente.Dfm');
  if not FileExists(Projeto.Pasta + 'Filtro.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Filtro.Pas', Projeto.Pasta + 'Filtro.Pas');
  if not FileExists(Projeto.Pasta + 'Filtro.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Filtro.Dfm', Projeto.Pasta + 'Filtro.Dfm');
  if not FileExists(Projeto.Pasta + 'GridPesquisa.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'GridPesquisa.Pas', Projeto.Pasta + 'GridPesquisa.Pas');
  if not FileExists(Projeto.Pasta + 'GridPesquisa.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'GridPesquisa.Dfm', Projeto.Pasta + 'GridPesquisa.Dfm');
  if not FileExists(Projeto.Pasta + 'CTabelas.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'CTabelas.Pas', Projeto.Pasta + 'CTabelas.Pas');
  if not FileExists(Projeto.Pasta + 'LTab.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'LTab.Pas', Projeto.Pasta + 'LTab.Pas');
  if not FileExists(Projeto.Pasta + 'LTab.Inc') then
    CopiaArquivo(Projeto.PastaFontes + 'LTab.Inc', Projeto.Pasta + 'LTab.Inc');
  if not FileExists(Projeto.Pasta + 'BatePapo.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'BatePapo.Pas', Projeto.Pasta + 'BatePapo.Pas');
  if not FileExists(Projeto.Pasta + 'BatePapo.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'BatePapo.Dfm', Projeto.Pasta + 'BatePapo.Dfm');
  if not FileExists(Projeto.Pasta + 'Backup.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Backup.Pas', Projeto.Pasta + 'Backup.Pas');
  if not FileExists(Projeto.Pasta + 'Backup.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Backup.Dfm', Projeto.Pasta + 'Backup.Dfm');
  if not FileExists(Projeto.Pasta + 'Restaura.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Restaura.Pas', Projeto.Pasta + 'Restaura.Pas');
  if not FileExists(Projeto.Pasta + 'Restaura.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Restaura.Dfm', Projeto.Pasta + 'Restaura.Dfm');
  if not FileExists(Projeto.Pasta + 'CabIntF.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'CabIntF.Pas', Projeto.Pasta + 'CabIntF.Pas');
  if not FileExists(Projeto.Pasta + 'CabStComps.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'CabStComps.Pas', Projeto.Pasta + 'CabStComps.Pas');
  if not FileExists(Projeto.Pasta + 'CabStConsts.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'CabStConsts.Pas', Projeto.Pasta + 'CabStConsts.Pas');
  if not FileExists(Projeto.Pasta + 'CabiNet.Dll') then
    CopiaArquivo(Projeto.PastaFontes + 'CabiNet.Dll', Projeto.Pasta + 'CabiNet.Dll');
  if not FileExists(Projeto.Pasta + 'Aguarde.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Aguarde.Pas', Projeto.Pasta + 'Aguarde.Pas');
  if not FileExists(Projeto.Pasta + 'Aguarde.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Aguarde.Dfm', Projeto.Pasta + 'Aguarde.Dfm');
  if not FileExists(Projeto.Pasta + 'Abertura.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Abertura.Pas', Projeto.Pasta + 'Abertura.Pas');
  if not FileExists(Projeto.Pasta + 'Abertura.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Abertura.Dfm', Projeto.Pasta + 'Abertura.Dfm');
  if not FileExists(Projeto.Pasta + 'Fr_View.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Fr_View.Pas', Projeto.Pasta + 'Fr_View.Pas');
  if not FileExists(Projeto.Pasta + 'Fr_View.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Fr_View.Dfm', Projeto.Pasta + 'Fr_View.Dfm');
  if not FileExists(Projeto.Pasta + 'Fr_NetUtils.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Fr_NetUtils.Pas', Projeto.Pasta + 'Fr_NetUtils.Pas');
  if not FileExists(Projeto.Pasta + 'Fr_Progress.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Fr_Progress.Pas', Projeto.Pasta + 'Fr_Progress.Pas');
  if not FileExists(Projeto.Pasta + 'Fr_Progress.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Fr_Progress.Dfm', Projeto.Pasta + 'Fr_Progress.Dfm');
  if not FileExists(Projeto.Pasta + 'FR_Export_email.pas') then
    CopiaArquivo(Projeto.PastaFontes + 'FR_Export_email.pas', Projeto.Pasta + 'FR_Export_email.pas');
  if not FileExists(Projeto.Pasta + 'FR_Export_email.dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'FR_Export_email.dfm', Projeto.Pasta + 'FR_Export_email.dfm');
  if not FileExists(Projeto.Pasta + 'FR_SMTP.pas') then
    CopiaArquivo(Projeto.PastaFontes + 'FR_SMTP.pas', Projeto.Pasta + 'FR_SMTP.pas');
  if not FileExists(Projeto.Pasta + 'Fr.Inc') then
    CopiaArquivo(Projeto.PastaFontes + 'Fr.Inc', Projeto.Pasta + 'Fr.Inc');
  if not FileExists(Projeto.Pasta + 'OpcRel.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'OpcRel.Pas', Projeto.Pasta + 'OpcRel.Pas');
  if not FileExists(Projeto.Pasta + 'OpcRel.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'OpcRel.Dfm', Projeto.Pasta + 'OpcRel.Dfm');
  if not FileExists(Projeto.Pasta + 'Pesquisa_Ed.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'Pesquisa_Ed.Pas', Projeto.Pasta + 'Pesquisa_Ed.Pas');
  if not FileExists(Projeto.Pasta + 'Pesquisa_Ed.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'Pesquisa_Ed.Dfm', Projeto.Pasta + 'Pesquisa_Ed.Dfm');
  if not FileExists(Projeto.Pasta + 'LogOperacoes.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'LogOperacoes.Pas', Projeto.Pasta + 'LogOperacoes.Pas');
  if not FileExists(Projeto.Pasta + 'LogOperacoes.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'LogOperacoes.Dfm', Projeto.Pasta + 'LogOperacoes.Dfm');
  if not FileExists(Projeto.Pasta + 'LogProcura.Pas') then
    CopiaArquivo(Projeto.PastaFontes + 'LogProcura.Pas', Projeto.Pasta + 'LogProcura.Pas');
  if not FileExists(Projeto.Pasta + 'LogProcura.Dfm') then
    CopiaArquivo(Projeto.PastaFontes + 'LogProcura.Dfm', Projeto.Pasta + 'LogProcura.Dfm');
end;

procedure TFormPrincipal.DefineCompilador;
begin
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 1 then
  begin
    Projeto.Compilador     := IniFile.ReadString('LINGUAGEM', 'Delphi50.Compilador', '');
    Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi50.Help', '');
    Projeto.Parametro      := IniFile.ReadString('LINGUAGEM', 'Delphi50.Parametros', '');
    BtnDelphi.ImageIndex   := 11;
  end
  else if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 2 then
  begin
    Projeto.Compilador     := IniFile.ReadString('LINGUAGEM', 'Delphi60.Compilador', '');
    Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi60.Help', '');
    Projeto.Parametro      := IniFile.ReadString('LINGUAGEM', 'Delphi60.Parametros', '');
    BtnDelphi.ImageIndex   := 77;
  end
  else if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 3 then
  begin
    Projeto.Compilador     := IniFile.ReadString('LINGUAGEM', 'Delphi70.Compilador', '');
    Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi70.Help', '');
    Projeto.Parametro      := IniFile.ReadString('LINGUAGEM', 'Delphi70.Parametros', '');
    BtnDelphi.ImageIndex   := 84;
  end
  else if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 4 then
  begin
    Projeto.Compilador     := IniFile.ReadString('LINGUAGEM', 'Delphi2005.Compilador', '');
    Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi2005.Help', '');
    Projeto.Parametro      := IniFile.ReadString('LINGUAGEM', 'Delphi2005.Parametros', '');
    BtnDelphi.ImageIndex   := 112;
  end
  else if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 5 then
  begin
    Projeto.Compilador     := IniFile.ReadString('LINGUAGEM', 'Delphi2006.Compilador', '');
    Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi2006.Help', '');
    Projeto.Parametro      := IniFile.ReadString('LINGUAGEM', 'Delphi2006.Parametros', '');
    BtnDelphi.ImageIndex   := 112;
  end
  else if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 6 then
  begin
    Projeto.Compilador     := IniFile.ReadString('LINGUAGEM', 'TurboDelphi2006.Compilador', '');
    Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'TurboDelphi2006.Help', '');
    Projeto.Parametro      := IniFile.ReadString('LINGUAGEM', 'TurboDelphi2006.Parametros', '');
    BtnDelphi.ImageIndex   := 112;
  end;
  IniFile.Free;
end;

procedure TFormPrincipal.Delphi50Click(Sender: TObject);
begin
  FormDelphi := TFormDelphi.Create(Application);
  Try
    FormDelphi.Caption := 'Parâmetros de Compilação do Projeto [ Delphi 5.0 ]';
    FormDelphi.LbLinguagem.Caption := 'Delphi 5.0';
    FormDelphi.ShowModal;
  Finally
    FormDelphi.Free;
  end;
end;

procedure TFormPrincipal.Delphi60Click(Sender: TObject);
begin
  FormDelphi := TFormDelphi.Create(Application);
  Try
    FormDelphi.Caption := 'Parâmetros de Compilação do Projeto [ Delphi 6.0 ]';
    FormDelphi.LbLinguagem.Caption := 'Delphi 6.0';
    FormDelphi.ShowModal;
  Finally
    FormDelphi.Free;
  end;
end;

procedure TFormPrincipal.BtnDelphiClick(Sender: TObject);
var
  ExeDelphi : String;
begin
  ExeDelphi := ExtractFilePath(Projeto.Compilador)+'Delphi32.Exe';
  if FileExists(ExeDelphi) then
  begin
    ExeDelphi := '"'+ExtractFilePath(Projeto.Compilador)+'Delphi32.Exe" "' + Projeto.ArquivoProj+'"';
    WinExec(PChar(ExeDelphi),SW_MAXIMIZE);
  end
  else
  begin
    ExeDelphi := ExtractFilePath(Projeto.Compilador)+'bds.exe';
    if FileExists(ExeDelphi) then
    begin
      ExeDelphi := '"'+ExtractFilePath(Projeto.Compilador)+'bds.exe" "' + Projeto.ArquivoProj+'"';
      WinExec(PChar(ExeDelphi),SW_MAXIMIZE);
    end
    else
      Mensagem('Delphi não Localizado !',ModAdvertencia,[ModOk]);
  end;
end;

procedure TFormPrincipal.RecortarClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           FormDesigner_Net.CurrentEdit.CutToClipboard;
         end;
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.CutToClipboard;
    end;
  end;
end;

procedure TFormPrincipal.CopiarClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           FormDesigner_Net.CurrentEdit.CopyToClipboard;
         end;
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.CopyToClipboard;
    end;
  end;
end;

procedure TFormPrincipal.ColarClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           FormDesigner_Net.CurrentEdit.PasteFromClipboard;
         end;
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.PasteFromClipboard;
    end;
  end;
end;

procedure TFormPrincipal.DesfazerClick(Sender: TObject);
var
  Edit : TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if assigned(Edit) then
             Edit.Undo;
         end;
    end;
  end;
end;

procedure TFormPrincipal.BtnSalvarArquivoClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    if FormDesigner_Net.Possui_DFM then
    begin
      if FormDesigner_Net.CurrentForm_Avulso <> Nil then
      begin
        FormDesigner_Net.CurrentForm_Avulso.Index := FormDesigner_Net.Indice;
        FormDesigner_Net.CurrentForm_Avulso.SalvarFormulario;
      end;
    end
    else
    begin
      if FormDesigner_Net.CurrentEdit <> Nil then
      begin
        FormDesigner_Net.CurrentEdit.Lines.SaveToFile(FormDesigner_Net.CurrentEdit.FileName);
        FormDesigner_Net.CurrentEdit.Modified := False;
      end;  
    end;
  end;
end;

procedure TFormPrincipal.LocalizarClick(Sender: TObject);
var
  OldBlockBegin: TPoint;
  OldBlockEnd: TPoint;
  Achou: Boolean;
  Edit: TMyMwCustomEdit_F;
  Item: TJvTabBarItem;
begin
  MultiSubst := '';
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if not assigned(Edit) then
             exit;
         end;
    else
      exit;
    end;
  end
  else
    exit;
  Achou := True;
  with Edit do
  begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd   := BlockEnd;
    SetSelWord;
    frmFind.cbFindText.Text := SelText;
    BlockBegin := OldBlockBegin;
    BlockEnd   := OldBlockEnd;
    if frmFind.ShowModal=mrOk then
    begin
      SearchOptions := [];
      if frmFind.cbMatchCase.Checked then
        include( SearchOptions, ssoMatchCase );
      if frmFind.cbWholeWord.Checked then
        include( SearchOptions, ssoWholeWord );
      if frmFind.rbBackward.Checked then
        include( SearchOptions, ssoBackwards );
      if frmFind.rbSelectedOnly.Checked then
        include( SearchOptions, ssoSelectedOnly );
      if frmFind.rbEntireScope.Checked then
        include( SearchOptions, ssoEntireScope );

      if SearchReplace(frmFind.cbFindText.Text, '', SearchOptions ) = 0 then
      begin
        if frmFind.EmTodos.Checked then
          Achou := False
        else
          Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
      end;
    end;
  end;
  if not Achou then
  begin
    if FormDesigner_Net.TabForms.SelectedTab.Index + 01 <= FormDesigner_Net.TabForms.Tabs.Count-1 then
    begin
      //FormDesigner_Net.TabForms.SelectedTab.Index := FormDesigner_Net.TabForms.SelectedTab.Index + 01;
      item := FormDesigner_Net.TabForms.Tabs[FormDesigner_Net.TabForms.SelectedTab.Index + 01];
      item.Selected := True;
      FormDesigner_Net.TabFormsTabSelected(Self, item);
      FormDesigner_Net.CurrentPage(0);
      Edit := FormDesigner_Net.CurrentEdit;
      Edit.CaretX := 0;
      Edit.CaretY := 0;
      ProximoClick(Self);
    end
    else
      Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
  end;
end;

procedure TFormPrincipal.SubstituirClick(Sender: TObject);
var
  ReplaceText:string;
  OldBlockBegin: TPoint;
  OldBlockEnd: TPoint;
  Achou: Boolean;
  Edit: TMyMwCustomEdit_F;
  Item: TJvTabBarItem;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if not assigned(Edit) then
             exit;
         end;
    else
      exit;
    end;
  end
  else
    exit;
  Achou := True;
  with Edit do
  begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd   := BlockEnd;
    SetSelWord;
    frmReplace.cbFindText.Text := FormDesigner_Net.CurrentEdit.SelText;
    BlockBegin := OldBlockBegin;
    BlockEnd   := OldBlockEnd;
    if frmReplace.ShowModal=mrOk then begin
      ReplaceText:= frmReplace.cbReplace.Text;
      SearchOptions := [];
      if frmReplace.cbMatchCase.Checked then
        include( SearchOptions, ssoMatchCase );
      if frmReplace.cbWholeWord.Checked then
        include( SearchOptions, ssoWholeWord );
      if frmReplace.rbBackward.Checked then
        include( SearchOptions, ssoBackwards );
      if frmReplace.rbSelectedOnly.Checked then
        include( SearchOptions, ssoSelectedOnly );
      if frmReplace.rbEntireScope.Checked then
        include( SearchOptions, ssoEntireScope );
      include( SearchOptions, ssoReplaceAll );
      include( SearchOptions, ssoPrompt );
      if frmReplace.EmTodos.Checked then
      begin
        frmFind.cbFindText.Text := frmReplace.cbFindText.Text;
        frmFind.EmTodos.Checked := True;
        MultiSubst := ReplaceText;
      end;
      if SearchReplace(frmReplace.cbFindText.Text, ReplaceText, SearchOptions ) = 0 then
      begin
        if frmReplace.EmTodos.Checked then
          Achou := False
        else
          Mensagem(frmReplace.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
      end;
    end;
  end;
  if not Achou then
  begin
    if FormDesigner_Net.TabForms.SelectedTab.Index + 01 <= FormDesigner_Net.TabForms.Tabs.Count-1 then
    begin
      //FormDesigner_Net.TabForms.SelectedTab.Index := FormDesigner_Net.TabForms.SelectedTab.Index + 01;
      item := FormDesigner_Net.TabForms.Tabs[FormDesigner_Net.TabForms.SelectedTab.Index + 01];
      item.Selected := True;
      FormDesigner_Net.TabFormsTabSelected(Self, item);
      FormDesigner_Net.CurrentPage(0);
      Edit := FormDesigner_Net.CurrentEdit;
      Edit.CaretX := 0;
      Edit.CaretY := 0;
      frmFind.cbFindText.Text := frmReplace.cbFindText.Text;
      frmFind.EmTodos.Checked := True;
      MultiSubst := ReplaceText;
      ProximoClick(Self);
    end
    else
      Mensagem(frmReplace.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
  end;
end;

procedure TFormPrincipal.PosicionarClick(Sender: TObject);
var
  SLine: string;
  CurLine,NewLine: integer;
  Edit: TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if not assigned(Edit) then
             exit;
         end;
    else
      exit;
    end;
  end
  else
    exit;
  if InputQuery('Posicionar...','Ir para Linha: ',SLine) then
  begin
    CurLine:= 0;
    Edit.SetFocus;
    NewLine:=StrToIntDef(SLine,CurLine);
    Edit.CaretY:= NewLine;
  end;
end;

procedure TFormPrincipal.HelpDelphiClick(Sender: TObject);
begin
  if Pos('.pdf', LowerCase(Projeto.AjudaLinguagem)) > 0 then
    ShellExecute(0, nil, pchar(Projeto.AjudaLinguagem), nil, nil, SW_MAXIMIZE)
  else
  begin
    Application.HelpFile := Projeto.AjudaLinguagem;
    Application.HelpCommand(HELP_FINDER, 0);
  end;
end;

procedure TFormPrincipal.ConteudoClick(Sender: TObject);
begin
  ChamaAjuda;
end;

procedure TFormPrincipal.BtnTabelasClick(Sender: TObject);
begin
  FormDB_Case := TFormDB_Case.Create(Application);
  Try
    FormDB_Case.ShowModal;
  Finally
    FormDB_Case.Free;
  end;

  {FormEstruturas := TFormEstruturas.Create(Application);
  Try
    FormEstruturas.ShowModal;
  Finally
    FormEstruturas.Free;
  end;}
end;

procedure TFormPrincipal.BtnMenuPrincipalClick(Sender: TObject);
begin
  FormMenuObject := TFormMenuObject.Create(Application);
  Try
    FormMenuObject.ShowModal;
  Finally
    FormMenuObject.Free;
  end;
end;

procedure TFormPrincipal.BtnCompilarClick(Sender: TObject);
begin
  FormCompilar := TFormCompilar.Create(Application);
  Try
    FormCompilar.ShowModal;
  Finally
    FormCompilar.Free;
  end;
end;

procedure TFormPrincipal.BtnExecutarClick(Sender: TObject);
var Comando : String;
begin
  if Projeto.Adapter then
    comando := Projeto.Pasta + 'Adapter.Exe'
  else
    comando := Projeto.Pasta + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-3) + 'Exe';
  if fileExists(Comando) then
  begin
    if Projeto.Adapter then
      WinExec(Pchar(Comando), SW_NORMAL)
    else
      WinExec(Pchar(Comando), SW_MAXIMIZE);
  end
  else
  begin
    Mensagem('Executável não Encontrado !'+^M+Comando,ModAdvertencia,[ModOk]);
    abort;
  end;
end;

procedure TFormPrincipal.BtnFecharArquivoClick(Sender: TObject);
begin
  FormDesigner_Net.FechaForm(FormDesigner_Net.CurrentPage);
end;

procedure TFormPrincipal.ProximoClick(Sender: TObject);
var
  Edit: TMyMwCustomEdit_F;
  Item: TJvTabBarItem;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if not assigned(Edit) then
             exit;
         end;
    else
      exit;
    end;
  end
  else
    exit;
  exclude( SearchOptions, ssoEntireScope );
  if Edit.SearchReplace(frmFind.cbFindText.Text, MultiSubst, SearchOptions ) = 0 then
  begin
    if frmFind.EmTodos.Checked then
    begin
      if FormDesigner_Net.TabForms.SelectedTab.Index + 01 <= FormDesigner_Net.TabForms.Tabs.Count-1 then
      begin
        item := FormDesigner_Net.TabForms.Tabs[FormDesigner_Net.TabForms.SelectedTab.Index + 01];
        item.Selected := True;
        FormDesigner_Net.TabFormsTabSelected(Self, item);
        FormDesigner_Net.CurrentPage(0);
        Edit := FormDesigner_Net.CurrentEdit;
        Edit.CaretX := 0;
        Edit.CaretY := 0;
        ProximoClick(Self);
      end
      else
        Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
    end
    else
      Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
  end;
end;

procedure TFormPrincipal.SelecionarTudoClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           FormDesigner_Net.CurrentEdit.SelectAll;
         end;
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.SelectAll;
    end;
  end;
end;

procedure TFormPrincipal.DiarioProjetoClick(Sender: TObject);
begin
  FormDiario := TFormDiario.Create(Application);
  Try
    FormDiario.ShowModal;
  Finally
    FormDiario.Free;
  end;
end;

procedure TFormPrincipal.SobreClick(Sender: TObject);
begin
  FormSobre := TFormSobre.Create(Application);
  Try
    FormSobre.ShowModal;
  Finally
    FormSobre.Free;
  end;
end;

procedure TFormPrincipal.CamposPredefinidosClick(Sender: TObject);
begin
  FormCamposPredefinidos := TFormCamposPredefinidos.Create(Application);
  Try
    FormCamposPredefinidos.ShowModal;
  Finally
    FormCamposPredefinidos.Free;
  end;
end;

procedure TFormPrincipal.BtnFormulariosClick(Sender: TObject);
begin
  if TControl(Sender).Tag = 1000 then
    TipoFormulario := 0
  else if TControl(Sender).Tag = 2000 then
    TipoFormulario := 1;
  if TipoFormulario = 0 then
  begin
    if (FormDesigner_Net <> Nil) then
      exit;
  end;
  FormForms := TFormForms.Create(Application);
  Try
    if TipoFormulario = 0 then
    begin
      FormForms.Definicao_Relatorios := False;
      FormForms.Caption := 'Definição de Formulários';
      FormForms.XBanner.Caption := 'Definição de Formulários';
      FormForms.XBanner.ColorFor  := clHighlight;
      FormForms.XBanner1.ColorFor := clHighlight;
      FormForms.XBanner1.ColorOf  := clHighlight;
    end
    else if TipoFormulario = 1 then
    begin
      FormForms.Definicao_Relatorios := True;
      FormForms.TreeTipos1.Items[6].Selected := True;
      FormForms.Caption := 'Definição de Relatórios/Gráficos/Etiquetas';
      FormForms.XBanner.Caption := 'Definição de Relatórios';
      FormForms.XBanner.ColorFor  := clGreen;
      FormForms.XBanner1.ColorFor := clGreen;
      FormForms.XBanner1.ColorOf  := clGreen;
    end;
    FormForms.ShowModal;
  Finally
    FormForms.Free;
  end;
  {FormFormularios := TFormFormularios.Create(Application);
  Try
    if TipoFormulario = 0 then
    begin
      with FormFormularios do
      begin
        XBanner.Caption := 'Definição de Formulários';
        XBanner.ColorFor  := clHighlight;
        XBanner1.ColorFor := clHighlight;
        XBanner1.ColorOf  := clHighlight;
        Tipo := 1;
        HelpContext := 200;
        BtnFechar.HelpContext := 200;
        BthAjudaTabela.HelpContext := 200;
        BtnConfirma.HelpContext := 200;
        GridForm.HelpContext := 200;
        EdNome.HelpContext := 200;
        ComboTipo.HelpContext := 200;
        EdTitulo.HelpContext := 200;
        ComboTabela.HelpContext := 200;
        EdLocalizar.HelpContext := 200;
      end;
    end
    else
    begin
      with FormFormularios do
      begin
        XBanner.Caption := 'Definição de Relatórios';
        XBanner.ColorFor  := clGreen;
        XBanner1.ColorFor := clGreen;
        XBanner1.ColorOf  := clGreen;
        Tipo := 2;
        HelpContext := 250;
        BtnFechar.HelpContext := 250;
        BthAjudaTabela.HelpContext := 250;
        BtnConfirma.HelpContext := 250;
        GridForm.HelpContext := 250;
        EdNome.HelpContext := 250;
        ComboTipo.HelpContext := 250;
        EdTitulo.HelpContext := 250;
        ComboTabela.HelpContext := 250;
        EdLocalizar.HelpContext := 250;
      end;
    end;
    FormFormularios.ShowModal;
  Finally
    FormFormularios.Free;
  end;}
end;

procedure TFormPrincipal.CorEditorClick(Sender: TObject);
var
  Edit: TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    Edit := FormDesigner_Net.CurrentEdit;
    if not assigned(Edit) then
      exit;
  end;
  if frmEnvOpts.ShowModal = mrOk then
    FormDesigner_Net.StoreSettings;
  Edit.Invalidate;
end;

procedure TFormPrincipal.RefazerClick(Sender: TObject);
var
  Edit : TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if assigned(Edit) then
             Edit.Redo;
         end;
    end;
  end;
end;

procedure TFormPrincipal.RegerarClick(Sender: TObject);
begin
  FormGerarFontes := TFormGerarFontes.Create(Application);
  Try
    FormGerarFontes.ShowModal;
  Finally
    FormGerarFontes.Free;
  end;
end;

procedure TFormPrincipal.BrAssistenteClick(Sender: TObject);
begin
  if FormDesigner_Net = Nil then
  begin
    BrAssistente.Checked  := not BrAssistente.Checked;
    BarraAssistente.Visible := BrAssistente.Checked;
    JvTabBar_Assistente.Tabs[0].Visible := BarraAssistente.Visible;
    if (not JvTabBar_Assistente.Tabs[0].Visible) and
       (not JvTabBar_Assistente.Tabs[1].Visible) then
      JvTabBar_Assistente.Visible := False
    else
      JvTabBar_Assistente.Visible := True;
    FormResize(Self);
  end;
end;

procedure TFormPrincipal.Botoes(Valor: Boolean);
begin
  //BtnFecharArquivo.Enabled := Valor;
  FecharArquivo.Enabled    := Valor;
  Recortar.Enabled         := Valor;
  Colar.Enabled            := Valor;
  Copiar.Enabled           := Valor;
  BtnSalvarArquivo.Enabled := Valor;
  //BtnSalvarTodos.Enabled   := Valor;
  SalvarArquivo.Enabled    := Valor;
  SalvarComoArquivo.Enabled:= Valor;
  SalvarComoModelo.Enabled := Valor;
  Localizar.Enabled        := Valor;
  CorEditor.Enabled        := Valor;
  Proximo.Enabled          := Valor;
  Substituir.Enabled       := Valor;
  Posicionar.Enabled       := Valor;
  Comentar.Enabled         := Valor;
  Descomentar.Enabled      := Valor;
  Desfazer.Enabled         := Valor;
  Refazer.Enabled          := Valor;
  SelecionarTudo.Enabled   := Valor;
  Selecionar.Enabled       := Valor;
  Imprimir.Enabled         := Valor;
  ModoSelecao.Enabled      := Valor;
  Divisao_Form.Enabled     := Valor;
  Tamanho.Enabled          := Valor;
  Alinhamento.Enabled      := Valor;
  PaletaAlinhamento.Enabled:= Valor;
  EnviarParaFrente.Enabled := Valor;
  EnviarParaTras.Enabled   := Valor;
  TabOrder.Enabled         := Valor;
  OpcoesdeLayout.Enabled   := Valor;

  Recortar.OnClick       := RecortarClick;
  Colar.OnClick          := ColarClick;
  Copiar.OnClick         := CopiarClick;
  SelecionarTudo.OnClick := SelecionarTudoClick;
end;

procedure TFormPrincipal.ModoSelecaoClick(Sender: TObject);
var
  Edit : TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    Edit := FormDesigner_Net.CurrentEdit;
    if assigned(Edit) then
    begin
      if Edit.SelectionMode = smNormal then
        Edit.SelectionMode := smColumn
      else if Edit.SelectionMode = smColumn then
        Edit.SelectionMode := smLine
      else if Edit.SelectionMode = smLine then
        Edit.SelectionMode := smNormal;
    end;
  end;
end;

procedure TFormPrincipal.Delphi70Click(Sender: TObject);
begin
  FormDelphi := TFormDelphi.Create(Application);
  Try
    FormDelphi.Caption := 'Parâmetros de Compilação do Projeto [ Delphi 7.0 ]';
    FormDelphi.LbLinguagem.Caption := 'Delphi 7.0';
    FormDelphi.ShowModal;
  Finally
    FormDelphi.Free;
  end;
end;

procedure TFormPrincipal.CalendarioClick(Sender: TObject);
begin
  if FormCalendario = Nil then
  begin
    FormCalendario := TFormCalendario.Create(Application);
    Try
      FormCalendario.ShowModal;
    Finally
      FormCalendario.Free;
    end;
  end;
end;

procedure TFormPrincipal.CalculadoraClick(Sender: TObject);
begin
  if FormCalculadora = Nil then
  begin
    FormCalculadora := TFormCalculadora.Create(Application);
    Try
      FormCalculadora.ShowModal;
    Finally
      FormCalculadora.Free;
    end;
  end;
end;

procedure TFormPrincipal.TimeSplashTimer(Sender: TObject);
begin
  if not FechouSplash then
  begin
    FormSplash.Free;
    FechouSplash := True;
    TimeSplash.Interval := 10000;
    TimeSplash.Enabled := False;
  end;
end;

procedure TFormPrincipal.CascataClick(Sender: TObject);
begin
  FormPrincipal.Cascade;
end;

procedure TFormPrincipal.HorizontalClick(Sender: TObject);
begin
  FormPrincipal.TileMode := tbHorizontal;
  FormPrincipal.Tile;
end;

procedure TFormPrincipal.VerticalClick(Sender: TObject);
begin
  FormPrincipal.TileMode := tbVertical;
  FormPrincipal.Tile;
end;

procedure TFormPrincipal.MinimizaTodasClick(Sender: TObject);
var
  I: Integer;
begin
  for I := FormPrincipal.MDIChildCount - 1 downto 0 do
    FormPrincipal.MDIChildren[I].WindowState := wsMinimized;
end;

procedure TFormPrincipal.OrganizariconesClick(Sender: TObject);
begin
  FormPrincipal.ArrangeIcons;
end;

procedure TFormPrincipal.FechaJanelasFilhas;
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
  if (FormDesigner_Net <> Nil) then
    FormDesigner_Net.Close;
end;

procedure TFormPrincipal.XBannerClick(Sender: TObject);
begin
  ShellExecute(0, nil, pchar('http://www.xmaker.com.br'), nil, nil, SW_MAXIMIZE);
  XBanner.Font.Color := $004B7EDE;
end;

procedure TFormPrincipal.ListAssistenteClick(Sender: TObject);
begin
  if not BtnFecharProjeto.Enabled then
  begin
    Mensagem('Nenhum Projeto Aberto !',modAdvertencia,[modOk]);
    exit;
  end;
  if ListAssistente.Selected <> nil then
    case ListAssistente.Selected.Index of
      0: BtnDadosGenericosClick(Self);
      1: BtnTabelasClick(Self);
      2: begin TipoFormulario := 0; BtnFormulariosClick(Self) end;
      3: begin TipoFormulario := 1; BtnFormulariosClick(Self) end;
      4: BtnMenuPrincipalClick(Self);
      5: BtnCompilarClick(Self);
    end;
end;

procedure TFormPrincipal.ListaProjetosClick(Sender: TObject);
var
  AFileName: String;
begin
  if ListaProjetos.Selected <> nil then
    case ListaProjetos.Selected.Index of
      0: BtnNovoProjetoClick(Self);
    else
    begin
      AFileName := ListaNomeProj[ListaProjetos.Selected.Index-1];
      if FileExists(AFileName) then
      begin
        if not NomeProjValido(AFileName) then
          exit;
        HabilitaProjeto(AFileName);
      end
      else
        Mensagem('Projeto não Encontrado !',ModAdvertencia,[ModOk]);
      end;
    end;
end;

procedure TFormPrincipal.ListaProjetosSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  P: TPoint;
begin
  if (ListaProjetos.Selected <> nil) then
  begin
    if ListaProjetos.Selected.Index = 0 then
      ListaProjetos.Hint := 'Criar novo projeto ...'
    else
      ListaProjetos.Hint := ListaNomeProj[ListaProjetos.Selected.Index-1];
    GetCursorPos(P);
    Application.ActivateHint(P);
  end;
end;

procedure TFormPrincipal.ListAssistenteSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  P: TPoint;
begin
  if (ListAssistente.Selected <> nil) then
  begin
    case ListAssistente.Selected.Index of
      0: ListAssistente.Hint := 'Definição das Propriedades do Projeto';
      1: ListAssistente.Hint := 'Definição de Tabelas, Campos e Banco de Dados do Projeto';
      2: ListAssistente.Hint := 'Definição de Formulários do Projeto';
      3: ListAssistente.Hint := 'Definição de Relatórios e Gráficos do Projeto';
      4: ListAssistente.Hint := 'Definição do Menu Principal do Projeto';
      5: ListAssistente.Hint := 'Compilação & Execução';
    end;
    GetCursorPos(P);
    Application.ActivateHint(P);
  end;
end;

procedure TFormPrincipal.BrHistoricoClick(Sender: TObject);
begin
  if FormDesigner_Net = Nil then
  begin
    BrHistorico.Checked  := not BrHistorico.Checked;
    S_Barra_Hist := BrHistorico.Checked;
    if BtnFecharProjeto.Enabled then
      ListaProjetos.Visible := False  // BarraHistorico
    else
      ListaProjetos.Visible := BrHistorico.Checked;
    JvTabBar_Assistente.Tabs[1].Visible := ListaProjetos.Visible;
    if (not JvTabBar_Assistente.Tabs[0].Visible) and
       (not JvTabBar_Assistente.Tabs[1].Visible) then
      JvTabBar_Assistente.Visible := False
    else
      JvTabBar_Assistente.Visible := True;
    FormResize(Self);
  end;
end;

procedure TFormPrincipal.ControlBarPaletaResize(Sender: TObject);
begin
  PnTabBar.Left := 11;
  PnTabBar.Width := ControlBarPaleta.Width - 21;
end;

procedure TFormPrincipal.ComentarClick(Sender: TObject);
var
  Edit: TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if not assigned(Edit) then
             exit;
         end;
    else
      exit;
    end;
  end
  else
    exit;
  if Trim(Edit.SelText) <> '' then
    Edit.SelText := '{' + Edit.SelText + '}';
end;

procedure TFormPrincipal.DescomentarClick(Sender: TObject);
var
  x_sel: String;
  i: Integer;
  Edit: TMyMwCustomEdit_F;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      0: begin
           Edit := FormDesigner_Net.CurrentEdit;
           if not assigned(Edit) then
             exit;
         end;
    else
      exit;
    end;
  end
  else
    exit;
  with Edit do
    if SelText <> '' then
    begin
      x_sel := Trim(SelText);
      if (x_sel[1] = '{') and (x_sel[Length(x_sel)] = '}' ) then
      begin
        x_sel := TrocaString(SelText,'{','',[]);
        for i:=length(x_sel) downto 1 do
          if x_sel[i] = '}' then
          begin
            x_sel := Copy(x_sel,1,i-1) + Copy(x_sel,i+1,length(x_sel));
            break;
          end;
        SelText := x_sel;
      end;
    end;
end;

procedure TFormPrincipal.JvTabBar_AssistenteTabClosed(Sender: TObject;
  Item: TJvTabBarItem);
begin
  case Item.Tag of
    10: BrAssistenteClick(Self);
    11: BrHistoricoClick(Self);
  end;
end;

procedure TFormPrincipal.BtnUnitsClick(Sender: TObject);
var
  x_nome: String;
begin
  FormsProjeto := TFormsProjeto.Create(Application);
  Try
    FormsProjeto.Tipo := 1;
    if (FormsProjeto.ShowModal = mrOk) and (FormsProjeto.Lista.ItemIndex > -1) and
       (Trim(FormsProjeto.EdPesquisa.Text) <> '') then
    begin
      x_nome := FormsProjeto.Lista.Items[FormsProjeto.Lista.ItemIndex];
      if FormDesigner_Net = Nil then
        ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
      TabGlobal_i.DFORMULARIO.Filtro := 'Upper(NOME) = '+#39+UpperCase(x_nome)+#39;
      TabGlobal_i.DFORMULARIO.AtualizaSQL;
      if TabGlobal_i.DFORMULARIO.Eof then
        FormDesigner_Net.AbreForm(x_nome, 5, True)
      else
        FormDesigner_Net.AbreForm(x_nome, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
      TabGlobal_i.DFORMULARIO.Filtro := '';
      TabGlobal_i.DFORMULARIO.AtualizaSQL;
    end;
  Finally
    FormsProjeto.Free;
  end;
end;

procedure TFormPrincipal.BtnFormsClick(Sender: TObject);
var
  x_nome: String;
begin
  FormsProjeto := TFormsProjeto.Create(Application);
  Try
    FormsProjeto.Tipo := 2;
    if BtnFecharProjeto.Enabled then
      FormsProjeto.BtnModelos.Visible := True
    else
      FormsProjeto.BtnModelos.Visible := False;
    if (FormsProjeto.ShowModal = mrOk) and (FormsProjeto.Lista.ItemIndex > -1) and
       (Trim(FormsProjeto.EdPesquisa.Text) <> '') then
    begin
      x_nome := FormsProjeto.Lista.Items[FormsProjeto.Lista.ItemIndex];
      if FormDesigner_Net = Nil then
        ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
      TabGlobal_i.DFORMULARIO.Filtro := 'Upper(NOME) = '+#39+UpperCase(x_nome)+#39;
      TabGlobal_i.DFORMULARIO.AtualizaSQL;
      if TabGlobal_i.DFORMULARIO.Eof then
        FormDesigner_Net.AbreForm(x_nome, 5, True)
      else
        FormDesigner_Net.AbreForm(x_nome, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
      TabGlobal_i.DFORMULARIO.Filtro := '';
      TabGlobal_i.DFORMULARIO.AtualizaSQL;
    end;
  Finally
    FormsProjeto.Free;
  end;
end;

procedure TFormPrincipal.Delphi2005Click(Sender: TObject);
begin
  FormDelphi := TFormDelphi.Create(Application);
  Try
    FormDelphi.Caption := 'Parâmetros de Compilação do Projeto [ Delphi 2005 ]';
    FormDelphi.LbLinguagem.Caption := 'Delphi 2005';
    FormDelphi.ShowModal;
  Finally
    FormDelphi.Free;
  end;
end;

procedure TFormPrincipal.EnviarparafrenteClick(Sender: TObject);
var
  I: Integer;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: for I:=0 to FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.ControlCount-1 do
           FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.Controls[I].BringToFront;
    end;
  end;
end;

procedure TFormPrincipal.EnviarparatrasClick(Sender: TObject);
var
  I: Integer;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: for I:=0 to FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.ControlCount-1 do
           FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.Controls[I].SendToBack;
    end;
  end;
end;

procedure TFormPrincipal.AlinhamentoClick(Sender: TObject);
var
  I: Integer;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.AlignDialog;
    end;
  end;
end;

procedure TFormPrincipal.TamanhoClick(Sender: TObject);
var
  I: Integer;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.SizeDialog;
    end;
  end;
end;

procedure TFormPrincipal.TabOrderClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.TabOrderDialog;
    end;
  end;
end;

procedure TFormPrincipal.JvTabBar_AssistenteTabSelected(Sender: TObject;
  Item: TJvTabBarItem);
begin
  if Item <> Nil then
    case Item.Tag of
      10: if ListAssistente.Visible then ListAssistente.SetFocus;
      11: if ListaProjetos.Visible then ListaProjetos.SetFocus;
    end;
end;

procedure TFormPrincipal.FormResize(Sender: TObject);
begin
  XBanner.Left := Image_Registro.Width - 160;
  LbBeta.Left  := Image_Registro.Width - 225;
end;

procedure TFormPrincipal.OpcoesdeLayoutClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    OpcoesdeLayout.Checked := not OpcoesdeLayout.Checked;
    if OpcoesdeLayout.Checked then
      FormObjInsp.Show
    else
      FormObjInsp.Close;
  end;
end;

procedure TFormPrincipal.ModelosClick(Sender: TObject);
begin
  FormDefModelos := TFormDefModelos.Create(Application);
  Try
    FormDefModelos.ShowModal;
  Finally
    FormDefModelos.Free;
  end;
end;

procedure TFormPrincipal.PaletaAlinhamentoClick(Sender: TObject);
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.ShowAlignmentPalette;
    end;
  end;
end;

procedure TFormPrincipal.SalvarComoArquivoClick(Sender: TObject);
var
  Substituir: Boolean;
begin
  if FormDesigner_Net <> Nil then
  begin
    if TMenuItem(Sender).Tag = 0 then
      DialogSalvarUnit.InitialDir := Projeto.Pasta
    else
      DialogSalvarUnit.InitialDir := Projeto.PastaFontes;
    if DialogSalvarUnit.Execute then
    begin
      if FormDesigner_Net.Possui_DFM then
      begin
        if FormDesigner_Net.CurrentForm_Avulso <> Nil then
        begin
          Substituir := True;
          if FileExists(DialogSalvarUnit.FileName) then
            if Mensagem('Substituir o arquivo ?' + ^M + ^M + DialogSalvarUnit.FileName, ModConfirmacao, [ModSim, ModNao]) <> mrYes then
              Substituir := False;
          if Substituir then
          begin
            FormDesigner_Net.CurrentEdit.FileName := DialogSalvarUnit.FileName;
            FormDesigner_Net.CurrentEdit.FileName_dfm := TrocaString(DialogSalvarUnit.FileName, '.Pas', '.Dfm', [rfReplaceAll, rfIgnoreCase]);
            FormDesigner_Net.CurrentEdit.FileName_txt := TrocaString(DialogSalvarUnit.FileName, '.Pas', '.txt', [rfReplaceAll, rfIgnoreCase]);
            FormDesigner_Net.CurrentForm_Avulso.Index := FormDesigner_Net.Indice;
            if TMenuItem(Sender).Tag = 0 then
              FormDesigner_Net.Nome_Unit;
            FormDesigner_Net.CurrentForm_Avulso.SalvarFormulario;
            FormDesigner_Net.FechaForm(FormDesigner_Net.Indice);
            FormDesigner_Net.TabForms.SelectedTab.Free;
            FormDesigner_Net.AbreForm(DialogSalvarUnit.FileName, 5, False);
          end;
        end;
      end
      else
      begin
        if FormDesigner_Net.CurrentEdit <> Nil then
        begin
          Substituir := True;
          if FileExists(DialogSalvarUnit.FileName) then
            if Mensagem('Substituir o arquivo ?' + ^M + ^M + DialogSalvarUnit.FileName, ModConfirmacao, [ModSim, ModNao]) <> mrYes then
              Substituir := False;
          if Substituir then
          begin
            FormDesigner_Net.CurrentEdit.FileName := DialogSalvarUnit.FileName;
            FormDesigner_Net.Nome_Unit;
            FormDesigner_Net.CurrentEdit.Lines.SaveToFile(FormDesigner_Net.CurrentEdit.FileName);
            FormDesigner_Net.CurrentEdit.Modified := False;
            FormDesigner_Net.FechaForm(FormDesigner_Net.Indice);
            FormDesigner_Net.TabForms.SelectedTab.Free;
            FormDesigner_Net.AbreForm(DialogSalvarUnit.FileName, 5, False);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFormPrincipal.EXE_ProjetoClick(Sender: TObject);
begin
  Projeto.Adapter := False;
  BtnExecutarClick(Self);
end;

procedure TFormPrincipal.EXE_AdapterClick(Sender: TObject);
begin
  Projeto.Adapter := True;
  BtnExecutarClick(Self);
end;

procedure TFormPrincipal.IBConsole1Click(Sender: TObject);
var
  ExeIBConsole: String;
begin
  ExeIBConsole := Projeto.PastaGerador + 'Firebird\IBConsole.exe';
  if FileExists(ExeIBConsole) then
    WinExec(PChar(ExeIBConsole),SW_NORMAL)
  else
    Mensagem('Utilitário "IBConsole" não encontrado!' + ^M + ^M + ExeIBConsole, modAdvertencia, [modOk]);  
end;

procedure TFormPrincipal.UsurioMaster1Click(Sender: TObject);
begin
  FormUsrFirebird := TFormUsrFirebird.Create(Application);
  Try
    FormUsrFirebird.ShowModal;
  Finally
    FormUsrFirebird.Free;
  end;
end;

procedure TFormPrincipal.Delphi2006Click(Sender: TObject);
begin
  FormDelphi := TFormDelphi.Create(Application);
  Try
    FormDelphi.Caption := 'Parâmetros de Compilação do Projeto [ Delphi 2006 ]';
    FormDelphi.LbLinguagem.Caption := 'Delphi 2006';
    FormDelphi.ShowModal;
  Finally
    FormDelphi.Free;
  end;
end;

procedure TFormPrincipal.SelecionarClick(Sender: TObject);
var
  I: Integer;
begin
  if FormDesigner_Net <> Nil then
  begin
    case FormDesigner_Net.CurrentPage of
      1: FormDesigner_Net.CurrentForm_Avulso.cmpFormDesigner.Select;
    end;
  end;
end;

procedure TFormPrincipal.TimerBetaTimer(Sender: TObject);
begin
  TimerBeta.Enabled := False;
  FormBetaTeste := TFormBetaTeste.Create(Application);
  Try
    if FileExists(ArqIni + 'leiame.rtf') then
      FormBetaTeste.Texto.Lines.LoadFromFile(ArqIni + 'leiame.rtf');
    FormBetaTeste.ShowModal;
  Finally
    if FormBetaTeste.EdMostrar.Checked then
    begin
      IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
      IniFile.Writebool('MENSAGEM', 'Habilitado', False);
      IniFile.Free;
    end;
    FormBetaTeste.Free;
  end;
end;

procedure TFormPrincipal.ExibirCaixadeMensagemClick(Sender: TObject);
begin
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  ExibirCaixadeMensagem.Checked := not ExibirCaixadeMensagem.Checked;
  IniFile.Writebool('MENSAGEM', 'Habilitado', ExibirCaixadeMensagem.Checked);
  IniFile.Free;
end;

procedure TFormPrincipal.TurboDelphi1Click(Sender: TObject);
begin
  FormDelphi := TFormDelphi.Create(Application);
  Try
    FormDelphi.Caption := 'Parâmetros de Compilação do Projeto [ Turbo Delphi 2006 ]';
    FormDelphi.LbLinguagem.Caption := 'Turbo Delphi 2006';
    FormDelphi.ShowModal;
  Finally
    FormDelphi.Free;
  end;
end;

procedure TFormPrincipal.TimerFormularioTimer(Sender: TObject);
begin
  TimerFormulario.Enabled := False;
  BtnFormulariosClick(BtnFormularios);
end;

procedure TFormPrincipal.Visitenossosite1Click(Sender: TObject);
begin
  ShellExecute(0, nil, pchar('http://www.xmaker.com.br'), nil, nil, SW_MAXIMIZE);
end;

procedure TFormPrincipal.AdquirirProdutos1Click(Sender: TObject);
begin
  ShellExecute(0, nil, pchar('http://www.xmaker.com.br/loja'), nil, nil, SW_MAXIMIZE);
end;

procedure TFormPrincipal.VideoaulaClick(Sender: TObject);
begin
  ChamaAjuda('Vídeo-aula do X-Maker', 'Doc\VideoAula.html');
end;

end.
