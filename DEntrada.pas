unit DEntrada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ToolWin, ComCtrls, ExtCtrls, Tabs, IniFiles, Grids,
  DBGrids, clipbrd, dbctrls, Spin, DsnUnit, DsnSelect, DsnSubMl,
  DsnSubGr, DsnSubDp, DsnProp, IBQuery, XDBEDit, XEdit, XLookup, XNum,
  XDate, XDBDate, XDBNum, Menus, SynEdit, Gauges, checklst, TypInfo, FileCtrl, XBanner,
  SynEditKeyCmds, Db, ColorGrd, Outline, DirOutln, Calendar, Mask,
  TeeProcs, TeEngine, Chart, OleCtnrs, MPlayer, DBCGrids, DBChart, AppEvnts,
  ExtDlgs, RxLogin, Tabnotbk, DBLookup, XLabel3D, ToolEdit, CurrEdit,
  RXCtrls, RxCombos, RXClock, Animate, GIFCtrl, RXSwitch, RXDice, RXDBCtrl,
  RxLookup, RxRichEd, DBRichEd, RxDBComb, DsnSub8, FR_E_HTM, FR_E_CSV, FR_E_RTF, FR_E_TXT,
  FR_Shape, FR_Rich, FR_OLE, FR_ChBox, FR_RRect, FR_Chart, FR_BarC, FR_DSet, FR_DBSet, FR_Class,
  FR_Desgn, IBDataBase, FR_Ctrls, FR_Dock, dbtables;


type
  TFormEntradaDados = class(TForm)
    PagePrincipal: TPageControl;
    TabManutencao: TTabSheet;
    TabConsulta: TTabSheet;
    PnSalva: TPanel;
    PnSup: TPanel;
    ShapeSup: TShape;
    TabPaginas: TTabSet;
    PnInfConsulta: TPanel;
    GridConsulta: TDBGrid;
    LbTituloForm: TLabel;
    BtnAjuda: TSpeedButton;
    BtnFechar: TSpeedButton;
    PgPagina1: TScrollBox;
    AbaConsulta: TTabSet;
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
    BarraPrincipal: TPanel;
    BtnLocalizar: TSpeedButton;
    BtnIncluir: TSpeedButton;
    BtnModificar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnPrimeiro: TSpeedButton;
    BtnAnterior: TSpeedButton;
    BtnProximo: TSpeedButton;
    BtnUltimo: TSpeedButton;
    DsnSelect: TDsnSelect;
    DsnStage0: TDsnStage;
    DsnStage1: TDsnStage;
    DsnStage2: TDsnStage;
    DsnStage3: TDsnStage;
    DsnStage4: TDsnStage;
    DsnStage5: TDsnStage;
    DsnStage6: TDsnStage;
    DsnStage7: TDsnStage;
    DsnStage8: TDsnStage;
    DsnStage9: TDsnStage;
    DsnStage10: TDsnStage;
    DsnStage_Mnt: TDsnStage;
    DsnStage_Cnt: TDsnStage;
    PopDesigner: TPopupMenu;
    Dsg_Enviarparafrente: TMenuItem;
    Dsg_Enviarparatras: TMenuItem;
    Dsg_N1: TMenuItem;
    Dsg_Recortar1: TMenuItem;
    Dsg_Copiar1: TMenuItem;
    Dsg_Colar1: TMenuItem;
    Dsg_Excluir1: TMenuItem;
    Dsg_N2: TMenuItem;
    Dsg_SelecionarTodos1: TMenuItem;
    TextoTXT: TSynEdit;
    TextoDFM: TSynEdit;
    Divisao_NvPg: TMenuItem;
    Dsg_NovaPagina: TMenuItem;
    PopPaginas: TPopupMenu;
    Tabs_NvPg: TMenuItem;
    Tabs_ExPg: TMenuItem;
    Tabs_RnPg: TMenuItem;
    Dsg_N3: TMenuItem;
    Dsg_Alinhamento_obj: TMenuItem;
    Dsg_Dimensoes_obj: TMenuItem;
    Dsg_SequnciaTabOrder1: TMenuItem;
    GradientePaint: TXBanner;
    PopConsulta: TPopupMenu;
    DataSource: TDataSource;
    DsnRegister: TDsn8Register;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure TabPaginasClick(Sender: TObject);
    procedure DsnStage0ControlCreate(Sender: TObject;
      Component: TComponent);
    procedure DsnStage0MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DsnStage0SelectQuery(Sender: TObject; Component: TComponent;
      var CanSelect: TSelectAccept);
    procedure DsnStage0MoveQuery(Sender: TObject; Component: TComponent;
      var CanMove: Boolean);
    procedure DsnSelectChangeSelected(Sender: TObject;
      Targets: TSelectedComponents; Operation: TSelectOperation);
    procedure DsnStage0DeleteQuery(Sender: TObject; Component: TComponent;
      var CanDelete: Boolean);
    procedure BtnRelac_1Click(Sender: TObject);
    procedure Dsg_EnviarparafrenteClick(Sender: TObject);
    procedure Dsg_EnviarparatrasClick(Sender: TObject);
    procedure Dsg_Recortar1Click(Sender: TObject);
    procedure Dsg_Copiar1Click(Sender: TObject);
    procedure Dsg_Colar1Click(Sender: TObject);
    procedure Dsg_Excluir1Click(Sender: TObject);
    procedure Dsg_SelecionarTodos1Click(Sender: TObject);
    procedure Dsg_NovaPaginaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Tabs_NvPgClick(Sender: TObject);
    procedure Tabs_RnPgClick(Sender: TObject);
    procedure Tabs_ExPgClick(Sender: TObject);
    procedure Dsg_Alinhamento_objClick(Sender: TObject);
    procedure Dsg_Dimensoes_objClick(Sender: TObject);
    procedure Dsg_SequnciaTabOrder1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    CompPageControl: TWinControl;
    AutoFormatacao: Boolean;
    procedure AtribuiUses(Arquivo: String);
    function CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
                             GravaFRM: Boolean; Campo: String; TipoCampo: String; AtInspector: Boolean):TComponent;
    function UniqueName(comp:TComponent; Tipo:String):string;
    procedure AtribuiCampo(Nome: String; Pagina: Integer; EChave: Boolean;
                            Linha, Coluna, Largura, Altura: Integer);
    procedure AtribuiExtras(Nome: String; Pagina: Integer; Tipo: String;
                            Linha, Coluna, Largura, Altura: Integer);
    procedure ExcluiObjeto(Nome: String; Eventos: Boolean);
    function Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
    procedure PreencheConsulta(Limpar: Boolean = false);
    procedure CreateParams(var Params : TCreateParams); override;
  public
    { Public declarations }
    SearchOptions: TSynSearchOptions;
    SearchOptionsPd: TSynSearchOptions;
    ListaEventos, ListaInvisivel, ListaDesabilitado: TStringList;
    ListaSelecaoCampos: TStringList;
    P_Titulo_DB, P_Distribuicao_DB: Integer;
    NomeObjetoAtual: String;
    TipoObjeto: String;
    InserirCampo: Boolean;
    NomeCampo,EdTitulo,EdLista: String;
    EdCampo,TpCampo,EdTamanho,EdEstilo: Integer;
    EdChave,EDBLook,Busca_ChaveEst: Boolean;
    CompBotao: Boolean;
    EdTabela: String;
    EdAlinhamento: Integer;
    EdFormRel, EdNomeTabRel: String;
    EdGridEditavel: Boolean;
    VamosGravar: Boolean;
    ObjetoAtual: TObject;
    PastaForm: String;
    NomeForm: String;
    NomeTab: String;
    NrTabela: String;
    Form_Habilitado: Boolean;
    ExcluiTodos, ExcluiTodosEv: Boolean;
    ExcluiComp: Boolean;
    Erro_Formulario: Boolean;
    ListaSelecionados: TList;
    Thread_ok: Boolean;
    Lista_CB1: TStringList;
    procedure RelacionamentoVazio;
    procedure SalvarFormulario(Index: Integer = -1);
    procedure AutoFormatar;
    procedure InserirCamposPagina(ListaSelecao: TStringList; P_Titulo, P_Distribuicao, X, Y: Integer);
    procedure AutoIncremento;
    procedure InserirCamposDB;
    procedure PageControl_NovaPagina;
    procedure AtualizaLista_CB;
    procedure AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
    procedure EditarPaginas;
    procedure Define_TabOrder;
    procedure Cria_Grid_Relacionamento;
  end;

var
  FormEntradaDados: TFormEntradaDados;
  LastControl: TWinControl;
  DesignerAtual: TControl;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01, Formular, Abertura,
     FormRel, ChaveEst, Selecao, ThObjectInsp,
     OpFormatacao, Paginas, Alinhamento, Tamanho, TabOrdem, Aguarde, ImpForm,
     GrRelac, FDesigner, ObjInsp;

procedure TFormEntradaDados.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := (Style OR WS_CHILD) AND (NOT WS_POPUP);
    WndParent := FormDesigner_Net.HostScroll.Handle;
  end;
  Parent := FormDesigner_Net.HostScroll;
end;

procedure TFormEntradaDados.FormCreate(Sender: TObject);
var
  hMenuHandle : HMENU;
begin
  Left   := 5;
  Top    := 5;
  Height := 400;
  Width  := 600;
  hMenuHandle := GetSystemMenu(Self.Handle, FALSE); //Get the handle of the Form
  if (hMenuHandle <> 0) then
  begin
    DeleteMenu(hMenuHandle, SC_MOVE, MF_BYCOMMAND); //disable moving
    //DeleteMenu(hMenuHandle, SC_SIZE, MF_BYCOMMAND); //disable resizing
    DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND); //disable Close
  end;
end;

procedure TFormEntradaDados.FormShow(Sender: TObject);
Var
  I,Y,T, Tamanho: Integer;
  InicioBloco, FinalBloco: Boolean;
  Tipo_Janela: String;
  Abas_Manutencao, NomeComp, Linha: String;
  Achou : Boolean;
  ListaPag: TStringList;
  FS , FS2:TStream;
  Ok: Boolean;
  FinalFluxo: TValueType;
  ListaTabOrder: TStringList;
  Component: TComponent;
  Data: Pointer;

  procedure Atualiza_Form;
  begin
    with FormDesigner_Net.CurrentEdit do
    begin
      CaretX := 1;
      CaretY := 1;
      SearchReplace('SalvarRegistro: Boolean;', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace('ErroValidacao: Boolean;', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Y := CaretY - 1;
          Lines.Insert(Y,'    SalvarRegistro: Boolean;');
          Modified := True;
        end;
        Y := CaretY - 1;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('  FormPrincipal.BarraPrincipal.Visible := True;', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace('  FormPrincipal.BtnLocalizar.Visible := True;', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Y := CaretY - 1;
          Lines.Insert(Y,'  FormPrincipal.BarraPrincipal.Visible := True;');
          Modified := True;
        end;
        Y := CaretY - 1;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' procedure ChamaGridPesquisa(Sender: TObject);', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace('procedure FormShow', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Y := CaretY - 1;
          Lines.Insert(Y,'    procedure ChamaGridPesquisa(Sender: TObject);');
          AtribuiUses('GridPesquisa');
          include( SearchOptionsPd, ssoBackwards );
          Data := Nil;
          ExecuteCommand(ecEditorBottom,#0,Data);
          SearchReplace('end.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            Y := CaretY - 1;
            Lines.Insert(Y,'procedure TForm'+NomeForm+'.ChamaGridPesquisa(Sender: TObject);');
            Lines.Insert(Y+01,'Var');
            Lines.Insert(Y+02,'  I: Integer;');
            Lines.Insert(Y+03,'  CampoED: TCampoEdicao;');
            Lines.Insert(Y+04,'  Campo: TAtributo;');
            Lines.Insert(Y+05,'begin');
            Lines.Insert(Y+06,'  for I:=0 to ListaCamposED.Count-1 do');
            Lines.Insert(Y+07,'  begin');
            Lines.Insert(Y+08,'    CampoED := TCampoEdicao(ListaCamposED[I]);');
            Lines.Insert(Y+09,'    if CampoED.Controle = Sender then');
            Lines.Insert(Y+10,'    begin');
            Lines.Insert(Y+11,'      Campo := CampoED.Campo;');
            Lines.Insert(Y+12,'      Break;');
            Lines.Insert(Y+13,'    end;');
            Lines.Insert(Y+14,'  end;');
            Lines.Insert(Y+15,'  if (Campo = nil) or (Campo.Valor.ReadOnly) then exit;');
            Lines.Insert(Y+16,'  FormGridPesquisa := TFormGridPesquisa.Create(Application);');
            Lines.Insert(Y+17,'  Try');
            Lines.Insert(Y+18,'    if Sender is TXDBEdit then');
            Lines.Insert(Y+19,'      FormGridPesquisa.Atalho := TXDBEdit(Sender).ClickKey');
            Lines.Insert(Y+20,'    else if Sender is TXDBNumEdit then');
            Lines.Insert(Y+21,'      FormGridPesquisa.Atalho := TXDBNumEdit(Sender).ClickKey');
            Lines.Insert(Y+22,'    else if Sender is TXDBDateEdit then');
            Lines.Insert(Y+23,'      FormGridPesquisa.Atalho := TXDBDateEdit(Sender).ClickKey;');
            Lines.Insert(Y+24,'    FormGridPesquisa.Campo  := Campo;');
            Lines.Insert(Y+25,'    if FormGridPesquisa.ShowModal = mrOk then');
            Lines.Insert(Y+26,'      ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);');
            Lines.Insert(Y+27,'  Finally');
            Lines.Insert(Y+28,'    FormGridPesquisa.Free;');
            Lines.Insert(Y+29,'  end;');
            Lines.Insert(Y+30,'end;');
            Lines.Insert(Y+31,'');
            Modified := True;
            CaretX := 1;
            CaretY := Y+3;
          end;
          exclude( SearchOptionsPd, ssoBackwards );
        end;
      end
      else
        exit;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' procedure ValidaColunaGrid(Sender: TField);', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace('procedure FormShow', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Y := CaretY - 1;
          Lines.Insert(Y,'    procedure ValidaColunaGrid(Sender: TField);');
          include( SearchOptionsPd, ssoBackwards );
          Data := Nil;
          ExecuteCommand(ecEditorBottom,#0,Data);
          SearchReplace('end.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            Y := CaretY - 1;
            Lines.Insert(Y,'procedure TForm'+NomeForm+'.ValidaColunaGrid(Sender: TField);');
            Lines.Insert(Y+01,'var');
            Lines.Insert(Y+02,'  MsgErro : String;');
            Lines.Insert(Y+03,'  I: Integer;');
            Lines.Insert(Y+04,'  Campo: TAtributo;');
            Lines.Insert(Y+05,'begin');
            Lines.Insert(Y+06,'  if AbandonandoEdicao then');
            Lines.Insert(Y+07,'    Exit;');
            Lines.Insert(Y+08,'  for I:=0 to TTabela(Sender.DataSet).Campos.Count-1 do');
            Lines.Insert(Y+09,'  begin');
            Lines.Insert(Y+10,'    Campo := TAtributo(TTabela(Sender.DataSet).Campos[I]);');
            Lines.Insert(Y+11,'    if Campo.Valor = Sender then');
            Lines.Insert(Y+12,'      Break;');
            Lines.Insert(Y+13,'  end;');
            Lines.Insert(Y+14,'  if Campo = nil then exit;');
            Lines.Insert(Y+15,'  if not Campo.Valido(MsgErro) then');
            Lines.Insert(Y+16,'    raise Exception.Create(MsgErro);');
            Lines.Insert(Y+17,'end;');
            Lines.Insert(Y+18,'');
            Modified := True;
            CaretX := 1;
            CaretY := Y+3;
          end;
          exclude( SearchOptionsPd, ssoBackwards );
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' procedure HabilitaEdicao(Valor: Boolean = true);', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace(' procedure CamposCalculados;', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Y := CaretY - 1;
          Lines.Insert(Y,'    procedure HabilitaEdicao(Valor: Boolean = true);');
          include( SearchOptionsPd, ssoBackwards );
          Data := Nil;
          ExecuteCommand(ecEditorBottom,#0,Data);
          SearchReplace('end.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            Y := CaretY - 1;
            Lines.Insert(Y,'procedure TForm'+NomeForm+'.HabilitaEdicao(Valor: Boolean = true);');
            Lines.Insert(Y+01,'var');
            Lines.Insert(Y+02,'  I: Integer;');
            Lines.Insert(Y+03,'  Comp: TComponent;');
            Lines.Insert(Y+04,'  CampoED: TCampoEdicao;');
            Lines.Insert(Y+05,'begin');
            Lines.Insert(Y+06,'  for I := 0 to 10 do');
            Lines.Insert(Y+07,'  begin');
            Lines.Insert(Y+08,'    Comp := FindComponent('+#39+'Pagina'+#39+' + IntToStr(I));');
            Lines.Insert(Y+09,'    if Comp <> nil then');
            Lines.Insert(Y+10,'      TScrollBox(Comp).Enabled := Valor;');
            Lines.Insert(Y+11,'  end;');
            Lines.Insert(Y+12,'  if Valor then');
            Lines.Insert(Y+13,'    for I:=0 to ListaCamposED.Count-1 do');
            Lines.Insert(Y+14,'    begin');
            Lines.Insert(Y+15,'      CampoED := TCampoEdicao(ListaCamposED[I]);');
            Lines.Insert(Y+16,'      if (CampoED.Controle.TabOrder = 0) and (CampoED.Controle.CanFocus) then');
            Lines.Insert(Y+17,'      begin');
            Lines.Insert(Y+18,'        CampoED.Controle.SetFocus;');
            Lines.Insert(Y+19,'        Break;');
            Lines.Insert(Y+20,'      end;');
            Lines.Insert(Y+21,'    end;');
            Lines.Insert(Y+22,'end;');
            Lines.Insert(Y+23,'');
            Modified := True;
            CaretX := 1;
            CaretY := Y+3;
          end;
          exclude( SearchOptionsPd, ssoBackwards );
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' PagePrincipal.OnChange        := PagePrincipalChange;', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace(' InicializaConsultasSalvas(TabelaPrincipal, AbaConsulta, ConsultasSalvas);', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Y := CaretY - 1;
          Lines.Insert(Y,'  PagePrincipal.OnChange        := PagePrincipalChange;');
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('.TelaManutencao;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Achou  := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if UpperCase(Lines[CaretY]) = 'BEGIN' then
          begin
            Achou := True;
            Y := CaretY;
            Lines.Insert(Y+01,'  if (TabelaPrincipal.Inclusao) or');
            Lines.Insert(Y+02,'     (TabelaPrincipal.Modificacao) then');
            Lines.Insert(Y+03,'    HabilitaEdicao');
            Lines.Insert(Y+04,'  else');
            Lines.Insert(Y+05,'    HabilitaEdicao(False);');
            Lines.Insert(Y+06,'  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);');
            Lines.Insert(Y+07,'  TabelaPrincipal.AtribuiRelacionamentos;');
          end
          else
            CaretY := CaretY + 1;
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('.TelaConsulta;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Achou  := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if UpperCase(Lines[CaretY]) = 'BEGIN' then
          begin
            Achou := True;
            Y := CaretY;
            Lines.Insert(Y+01,'  HabilitaEdicao(False);');
          end
          else
            CaretY := CaretY + 1;
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('.AtribuiValoresPadrao;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Achou  := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if UpperCase(Lines[CaretY]) = 'BEGIN' then
          begin
            Achou := True;
            Y := CaretY;
            Lines.Insert(Y+01,'  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd, True);');
            Lines.Insert(Y+02,'  TabelaPrincipal.AtribuiRelacionamentos;');
          end
          else
            CaretY := CaretY + 1;
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('.FormClose(Sender: TObject;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Achou  := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if UpperCase(Lines[CaretY]) = 'BEGIN' then
          begin
            Achou := True;
            Y := CaretY;
            Lines.Insert(Y+01,'  TabelaPrincipal.AtribuiRelacionamentos(False);');
          end
          else
            CaretY := CaretY + 1;
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('.MudaSeForUltimo;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Achou  := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if UpperCase(Lines[CaretY]) = 'BEGIN' then
          begin
            Achou := True;
            Y := CaretY;
            Lines.Insert(Y+01,'  ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);');
          end
          else
            CaretY := CaretY + 1;
        end;
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace('  AtribuiValoresPadrao;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Y := CaretY;
        Lines.Insert(Y-01,'  HabilitaEdicao;');
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' TabelaPrincipal.Modifica;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Y := CaretY;
        Lines.Insert(Y,'    HabilitaEdicao;');
      end;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' Navegando := False;', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Y := CaretY;
        Lines.Insert(Y-01,'  if Navegando then');
        Lines.Insert(Y,'    HabilitaEdicao(False);');
      end;

    end;
  end;

  procedure Exclui_Tmp;
  var I: Integer;
  begin
    for I:=0 to 12 do
    begin
      if FileExists(PastaForm + NomeForm+'Tela'+IntTostr(I)+'.Tmp') then
        DeleteFile(PastaForm + NomeForm+'Tela'+IntTostr(I)+'.Tmp');
      if FileExists(PastaForm + NomeForm+'Tela'+IntTostr(I)+'.Txt') then
        DeleteFile(PastaForm + NomeForm+'Tela'+IntTostr(I)+'.Txt');
    end;
  end;

  procedure Inicializa;
  begin
    if Trim(PastaForm) = '' then
      PastaForm := Projeto.Pasta;
    Thread_ok := True;
    //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
    PagePrincipal.ActivePageIndex := 0;

    DsnRegister.Designing   := False;
    //DsnRegister.DsnPanel    := FormPrincipal.DsnPanel_Padrao;
    //DsnRegister.ArrowButton := FormPrincipal.ArrowButton1;
    DsnRegister.Designing   := True;

    MsgSalvar          := False;
    Erro_Formulario    := False;
    ExcluiTodos        := False;
    ExcluiTodosEv      := False;
    ExcluiComp         := False;
    Form_Habilitado    := False;
    ListaEventos       := TStringList.Create;
    ListaTabOrder      := TStringList.Create;
    ListaInvisivel     := TStringList.Create;
    ListaDesabilitado  := TStringList.Create;
    ListaSelecaoCampos := TStringList.Create;
    ListaSelecionados  := TList.Create;
    Lista_CB1          := TStringList.Create;
    VamosGravar        := False;

    TabPaginas.Tabs.Add('Principal');
    TabPaginas.TabIndex := 0;
    NoManutencao.PageIndex := TabPaginas.TabIndex;
    InserirCampo := False;
    Ok := False;
    Erro_de_Classe := False;
    FormDesigner_Net.CurrentEdit.Lines.LoadFromFile(PastaForm + NomeForm + '.PAS');
    TextoDFM.Lines.LoadFromFile(PastaForm + NomeForm + '.DFM');
    InicioBloco:=False;
    FinalBloco :=False;
    Abas_Manutencao := '';
    DsnRegister.Designing:= False;
    Tipo_Janela := 'wsMaximized';
  end;

  procedure Registra_Classes;
  begin
    // Padrão
    RegisterClasses([TLABEL, TEDIT, TMEMO, TBUTTON, TCHECKBOX, TRADIOBUTTON, TLISTBOX,
                     TCOMBOBOX, TSCROLLBAR, TGROUPBOX, TRADIOGROUP, TPANEL, TGAUGE,
                     TCOLORGRID, TSPINBUTTON, TSPINEDIT, TDIRECTORYOUTLINE, TCALENDAR,
                     TSCROLLER, TTABSHEET, TTOOLBUTTON]);
    // Adicional
    RegisterClasses([TBITBTN, TSPEEDBUTTON, TMASKEDIT, TSTRINGGRID, TDRAWGRID, TIMAGE,
                     TSHAPE, TBEVEL, TSCROLLBOX, TCHECKLISTBOX, TSPLITTER, TSTATICTEXT,
                     TCONTROLBAR, TCHART]);
    // Win32
    RegisterClasses([TTABCONTROL, TPAGECONTROL, TRICHEDIT, TTRACKBAR, TPROGRESSBAR, TUPDOWN,
                     THOTKEY, TANIMATE, TDATETIMEPICKER, TMONTHCALENDAR, TTREEVIEW, TLISTVIEW,
                     THEADERCONTROL, TSTATUSBAR, TTOOLBAR, TCOOLBAR, TPAGESCROLLER, TIMAGELIST]);
    // Sistema
    RegisterClasses([TPAINTBOX, TMEDIAPLAYER, TOLECONTAINER]);
    // Tabelas
    RegisterClasses([TDBGRID, TDBNavigator, TDBText, TDBEdit, TDBMemo, TDBImage, TDBListBox,
                     TDBComboBox, TDBCheckBox, TDBRadioGroup, TDBLookupListBox, TDBLookupComboBox,
                     TDBRichEdit, TDBCtrlGrid, TDBChart, TIBDataBase, TIBTransaction]);
    // Não Visuais
    RegisterClasses([TPOPUPMENU, TAPPLICATIONEVENTS, TTIMER, TDATASOURCE, TOPENDIALOG, TSAVEDIALOG,
                     TOPENPICTUREDIALOG, TSAVEPICTUREDIALOG, TFONTDIALOG, TCOLORDIALOG, TPRINTDIALOG,
                     TPRINTERSETUPDIALOG, TFINDDIALOG, TREPLACEDIALOG, TRXLOGINDIALOG, TMAINMENU]);
    // Win 3.1
    RegisterClasses([TTabSet, TOutline, TTabbedNotebook, TNotebook, THeader, TFileListBox,
                     TDirectoryListBox, TDriveComboBox, TFilterComboBox, TDBLookupList,
                     TDBLookupCombo]);
    // X-Maker
    RegisterClasses([TXDateEdit, TXNumEdit, TXEdit, TXDBDateEdit, TXDBNumEdit, TXDBEdit,
                     TXDBLookup, TXBanner, TXLabel3D]);
    // RX Controles
    RegisterClasses([TComboEdit, TFilenameEdit, TDirectoryEdit, TDateEdit, TRXCalcEdit,
                     TCurrencyEdit, TTextListBox, TRxCheckListBox, TFontComboBox, TRxRichEdit,
                     TColorComboBox, TRichEdit, TRxClock, TRxGIFAnimator, TRxSwitch, TRxDice]);
    // RX Tabelas
    RegisterClasses([TRxDBGrid, TRxDBLookupList, TRxDBLookupCombo, TRxLookupEdit,
                     TDBDateEdit, TRxDBCalcEdit, TRxDBComboEdit, TRxDBRichEdit,
                     TRxDBComboBox, TTable]);

    // Free Report
    RegisterClasses([TfrReport, TfrDBDataSet, TfrDesigner, TfrOLEObject, TfrRichObject, TfrCheckBoxObject,
                     TfrShapeObject, TfrBarCodeObject, TfrChartObject, TfrRoundRectObject, TfrTextExport,
                     TfrRTFExport, TfrCSVExport, TfrHTMExport, TfrTBButton, TfrTBSeparator, TfrTBPanel,
                     TfrToolBar, TfrDock, TfrSpeedButton]);
  end;

begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Abrindo formulário ...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := 12;

  Exclui_Tmp;
  Inicializa;
  Registra_Classes;

  {FormObjInsp := TFormObjInsp.Create(FormEntradaDados);
  try
    FormObjInsp.SplitterPos := 75;
    IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
    I := StrToIntDef(Trim(IniFile.ReadString('PALETA', 'Top', '')),158);
    Y := StrToIntDef(Trim(IniFile.ReadString('PALETA', 'Left', '')),10);
    FormObjInsp.Top  := I;
    FormObjInsp.Left := Y;
    FormObjInsp.SplitterPos := StrToIntDef(Trim(IniFile.ReadString('PALETA', 'Splitter', '75')),75);
    IniFile.Free;
    FormObjInsp.CB1.Items.Clear;
    FormObjInsp.CB1.Items.Add('');
    FormObjInsp.Show;
  Finally
  end;}

  FormResize(Self);

  try
    for I:=0 to 12 do
    begin
      FormAguarde.GaugeProcesso.Position := I;
      TextoDFM.CaretY := 0;
      TextoDFM.CaretX := 0;
      if I < 11 then
        TextoDFM.SearchReplace('object Pagina'+IntToStr(I)+':','', SearchOptionsPd)
      else if I = 11 then
        TextoDFM.SearchReplace('object PnInfConsulta:','', SearchOptionsPd)
      else if I = 12 then
        TextoDFM.SearchReplace('object PnSalva:','', SearchOptionsPd);
      Y := TextoDFM.CaretY + 1;
      FormPrincipal.Texto.Lines.Clear;
      if Y > 2 then
      begin
        Tamanho := Pos('O',UpperCase(TextoDFM.Lines[Y-2]))-1;
        FinalBloco := False;
        InicioBloco := False;
        while not FinalBloco do
        begin
          if not InicioBloco then
            if Copy(UpperCase(Trim(TextoDFM.Lines[Y])),01,07) = 'OBJECT ' then
              InicioBloco := True;
          if UpperCase(TrimRight(TextoDFM.Lines[Y])) = Space(Tamanho) + 'END' then
          begin
            InicioBloco := False;
            FinalBloco := True;
          end;
          if InicioBloco then
          begin
            if UpperCase(Copy(Trim(TextoDFM.Lines[Y]),01,02)) = 'ON' then // é um evento
            begin
              NomeComp := Localiza_Nome(TStringList(TextoDFM.Lines),Pos('O',UpperCase(TextoDFM.Lines[Y]))-3,Y);
              NomeComp := NomeComp + ':' + Trim(Copy(Trim(TextoDFM.Lines[Y]),Pos('=',Trim(TextoDFM.Lines[Y]))+1,Length(Trim(TextoDFM.Lines[Y]))));
              FormDesigner_Net.CurrentEdit.CaretY := 0;
              FormDesigner_Net.CurrentEdit.CaretX := 0;
              FormDesigner_Net.CurrentEdit.SearchReplace(Copy(NomeComp,Pos(':',NomeComp)+1,Length(NomeComp)),'', SearchOptionsPd);
              if FormDesigner_Net.CurrentEdit.CaretY > 1 then  // vamos ver se o evento existe
                ListaEventos.Add(NomeComp);
            end
            else
            begin
              if UpperCase(Copy(Trim(TextoDFM.Lines[Y]),01,08)) = 'TABORDER' then // é um taborder
              begin
                NomeComp := Localiza_Nome(TStringList(TextoDFM.Lines),Pos('T',UpperCase(TextoDFM.Lines[Y]))-3,Y);
                if ListaTabOrder.IndexOf(NomeComp) < 0 then
                  ListaTabOrder.AddObject(NomeComp,TObject( StrToIntDef(Trim(Copy(TextoDFM.Lines[Y],Pos('=',TextoDFM.Lines[Y])+1,20)),0) ) );
              end;
              if I < 11 then
                Linha := Copy(TextoDFM.Lines[Y],15,Length(TextoDFM.Lines[Y]))
              else
                Linha := Copy(TextoDFM.Lines[Y],09,Length(TextoDFM.Lines[Y]));
              if UpperCase(Trim(Linha)) = 'VISIBLE = FALSE' then
              begin
                NomeComp := Localiza_Nome(TStringList(TextoDFM.Lines),Pos('V',UpperCase(TextoDFM.Lines[Y]))-3,Y);
                ListaInvisivel.Add(NomeComp);
                Linha := TrocaString(Linha,'False','True',[rfReplaceAll]);
              end;
              if UpperCase(Trim(Linha)) = 'ENABLED = FALSE' then
              begin
                NomeComp := Localiza_Nome(TStringList(TextoDFM.Lines),Pos('E',UpperCase(TextoDFM.Lines[Y]))-3,Y);
                ListaDesabilitado.Add(NomeComp);
                Linha := TrocaString(Linha,'False','True',[rfReplaceAll]);
              end;
              FormPrincipal.Texto.Lines.Add(Linha);
            end;
          end;
          inc(Y);
        end;
        FormPrincipal.Texto.Lines.SaveToFile(PastaForm + NomeForm + 'Tela'+IntToStr(I)+'.Txt');
        if FormPrincipal.Texto.Lines.Count > 2 then
        begin
          try
            FS2 := TFileStream.Create(PastaForm + NomeForm + 'Tela'+IntToStr(I)+'.Tmp', fmCreate);
            FinalBloco := False;
            FormPrincipal.Texto.Lines.Clear;
            while not FinalBloco do
            begin
              FS := TFileStream.Create(PastaForm + NomeForm + 'Tela'+IntToStr(I)+'.Txt', fmOpenRead);
              ObjectTextToBinary(FS, FS2);
              FS.Free;

              FormPrincipal.Texto.Lines.LoadFromFile(PastaForm + NomeForm + 'Tela'+IntToStr(I)+'.Txt');
              InicioBloco := False;
              FormPrincipal.Texto.Lines.Delete(0);
              while not InicioBloco do
              begin
                if (UpperCase(Copy(FormPrincipal.Texto.Lines[0],01,07)) = 'OBJECT ') or (FormPrincipal.Texto.Lines.Count = 0) then
                  InicioBloco := True
                else
                  FormPrincipal.Texto.Lines.Delete(0);
              end;
              FormPrincipal.Texto.Lines.SaveToFile(PastaForm + NomeForm + 'Tela'+IntToStr(I)+'.Txt');
              if FormPrincipal.Texto.Lines.Count < 3 then
                FinalBloco := True;
              FormPrincipal.Texto.Lines.Clear;
            end;
          finally
            FinalFluxo := vaNull;
            FS2.Write(FinalFluxo, SizeOf(FinalFluxo));
            FS2.Free;
          end;
          case I of
            0: DsnStage0.LoadFromFile(PastaForm + NomeForm + 'Tela0.Tmp');
            1: DsnStage1.LoadFromFile(PastaForm + NomeForm + 'Tela1.Tmp');
            2: DsnStage2.LoadFromFile(PastaForm + NomeForm + 'Tela2.Tmp');
            3: DsnStage3.LoadFromFile(PastaForm + NomeForm + 'Tela3.Tmp');
            4: DsnStage4.LoadFromFile(PastaForm + NomeForm + 'Tela4.Tmp');
            5: DsnStage5.LoadFromFile(PastaForm + NomeForm + 'Tela5.Tmp');
            6: DsnStage6.LoadFromFile(PastaForm + NomeForm + 'Tela6.Tmp');
            7: DsnStage7.LoadFromFile(PastaForm + NomeForm + 'Tela7.Tmp');
            8: DsnStage8.LoadFromFile(PastaForm + NomeForm + 'Tela8.Tmp');
            9: DsnStage9.LoadFromFile(PastaForm + NomeForm + 'Tela9.Tmp');
            10: DsnStage10.LoadFromFile(PastaForm + NomeForm + 'Tela10.Tmp');
            11: DsnStage_Cnt.LoadFromFile(PastaForm + NomeForm + 'Tela11.Tmp');
            12: DsnStage_Mnt.LoadFromFile(PastaForm + NomeForm + 'Tela12.Tmp');
          end;
        end;
        FormPrincipal.Texto.Lines.Clear;
      end;
    end;
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('  HEIGHT =','', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
      Height := StrToIntDef(Trim(Copy(TextoDFM.LineText,11,50)),413);
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('  WIDTH =','', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
      Width := StrToIntDef(Trim(Copy(TextoDFM.LineText,10,50)),587);
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('  WINDOWSTATE =','', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
      Tipo_Janela := Trim(Copy(TextoDFM.LineText, Pos('=',TextoDFM.LineText) + 1,50));
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('        TABS.STRINGS =','', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
    begin
      begin
        Achou := True;
        T := TextoDFM.CaretY;
        while Achou do
        begin
          if Copy(TextoDFM.Lines[T],01,11) = '          '+#39 then
            Abas_Manutencao := Abas_Manutencao + Trim(TextoDFM.Lines[T]) + ';'
          else
            Achou := False;
          Inc(T);
        end;
      end;
    end;
    Exclui_Tmp;

    for T:=0 to 1 do
    begin
      for I:=0 to DsnStage0.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage0.Controls[I].Name + ': ' +DsnStage0.Controls[I].ClassName);
        Component := DsnStage0.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage1.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage1.Controls[I].Name + ': ' +DsnStage1.Controls[I].ClassName);
        Component := DsnStage1.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage2.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage2.Controls[I].Name + ': ' +DsnStage2.Controls[I].ClassName);
        Component := DsnStage2.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage3.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage3.Controls[I].Name + ': ' +DsnStage3.Controls[I].ClassName);
        Component := DsnStage3.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage4.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage4.Controls[I].Name + ': ' +DsnStage4.Controls[I].ClassName);
        Component := DsnStage4.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage5.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage5.Controls[I].Name + ': ' +DsnStage5.Controls[I].ClassName);
        Component := DsnStage5.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage6.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage6.Controls[I].Name + ': ' +DsnStage6.Controls[I].ClassName);
        Component := DsnStage6.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage7.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage7.Controls[I].Name + ': ' +DsnStage7.Controls[I].ClassName);
        Component := DsnStage7.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage8.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage8.Controls[I].Name + ': ' +DsnStage8.Controls[I].ClassName);
        Component := DsnStage8.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage9.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage9.Controls[I].Name + ': ' +DsnStage9.Controls[I].ClassName);
        Component := DsnStage9.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage10.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage10.Controls[I].Name + ': ' +DsnStage10.Controls[I].ClassName);
        Component := DsnStage10.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage_Cnt.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage_Cnt.Controls[I].Name + ': ' +DsnStage_Cnt.Controls[I].ClassName);
        Component := DsnStage_Cnt.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
      for I:=0 to DsnStage_Mnt.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage_Mnt.Controls[I].Name + ': ' +DsnStage_Mnt.Controls[I].ClassName);
        Component := DsnStage_Mnt.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
    end;
    abas_manutencao := TrocaString(abas_manutencao,')','',[rfReplaceAll]);
    abas_manutencao := TrocaString(abas_manutencao,#39,'',[rfReplaceAll]);
    if abas_manutencao = '' then
      abas_manutencao := 'Principal;';
    ListaPag := TStringList.Create;
    StringToArray(abas_manutencao,';',ListaPag);
    TabPaginas.Tabs.Clear;
    for I:=0 to ListaPag.Count-1 do
      if Trim(ListaPag[I]) <> '' then
        TabPaginas.Tabs.Add(ListaPag[I]);
    ListaPag.Free;
    ListaTabOrder.Free;

    TabPaginas.TabIndex := 0;
    TabPaginasClick(Self);
    NoManutencao.PageIndex := TabPaginas.TabIndex;

    //FormDesigner_Net.ObjectInspector.Clear;
    FormObjInsp.Atribui(Nil, True);
    //FormObjInsp.CB1.ItemIndex := 0;
    DsnRegister.Designing:= True;
    Ok := True;
  Finally
    FormAguarde.Free;
  end;
  if (not Ok) or (Erro_de_Classe) then
  begin
    Mensagem('Erro de leitura do Formulário: '+NomeForm,modErro,[modOk]);
    Erro_Formulario := True;
  end;
  Form_Habilitado := True;
  Atualiza_Form;
  PreencheConsulta;
end;

procedure TFormEntradaDados.PreencheConsulta(Limpar: Boolean = False);
var
  I, Tamanho: Integer;
begin
  GridConsulta.Columns.Clear;
  if Limpar then exit;
  TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela;
  TabGlobal_i.DCAMPOST.ChaveIndice := 'INDICE_CONSULTA';
  TabGlobal_i.DCAMPOST.AtualizaSql;
  TabGlobal_i.DCAMPOST.First;
  I := 0;
  while not TabGlobal_i.DCAMPOST.Eof do
  begin
    if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
       (TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo <> 1) then
    begin
      GridConsulta.Columns.Add;
      GridConsulta.Columns[I].Title.Caption := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
      Tamanho := TabGlobal_i.DCAMPOST.Tamanho.Conteudo;
      if Tamanho < Length(TabGlobal_i.DCAMPOST.Mascara.Conteudo) then
        Tamanho := Length(TabGlobal_i.DCAMPOST.Mascara.Conteudo);
      if Tamanho < Length(TabGlobal_i.DCAMPOST.Titulo_C.Conteudo) then
        Tamanho := Length(TabGlobal_i.DCAMPOST.Titulo_C.Conteudo);
      GridConsulta.Columns[I].Width := Tamanho * 6 + 4;
      Inc(I);
    end;
    TabGlobal_i.DCAMPOST.Next;
  end;
  TabGlobal_i.DCAMPOST.ChaveIndice := TabGlobal_i.DCAMPOST.ChPrimaria;
  TabGlobal_i.DCAMPOST.AtualizaSql;
end;

procedure TFormEntradaDados.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  Resposta: Integer;
begin
  ListaEventos.Free;
  ListaInvisivel.Free;
  ListaDesabilitado.Free;
  ListaSelecaoCampos.Free;
  CompBotao := False;
  if FileExists(PastaForm + 'ChaveEst.Tmp') then
    DeleteFile(PastaForm + 'ChaveEst.Tmp');
  DsnRegister.Designing:= False;
  ListaSelecionados.Free;
  Lista_CB1.Free;

  FormPrincipal.Recortar.OnClick       := Dsg_Recortar1Click;
  FormPrincipal.Colar.OnClick          := Dsg_Colar1Click;
  FormPrincipal.Copiar.OnClick         := Dsg_Copiar1Click;
  FormPrincipal.SelecionarTudo.OnClick := Dsg_SelecionarTodos1Click;
  Projeto.Formulario_Ult               := NomeForm;
end;

procedure TFormEntradaDados.FormResize(Sender: TObject);
begin
  BtnAjuda.Left  := ShapeSup.Width - 37;
  BtnFechar.Left := ShapeSup.Width - 19;
end;

procedure TFormEntradaDados.TabPaginasClick(Sender: TObject);
begin
  if PagePrincipal.ActivePageIndex = 0 then
  begin
    NoManutencao.SetFocus;
    NoManutencao.PageIndex := TabPaginas.TabIndex;
    NoManutencao.Refresh;
  end;
  if ListaSelecionados <> Nil then
    ListaSelecionados.Clear;
  DsnRegister.ClearSelect;
  DsnRegister.Designing := False;
  if TabPaginas.TabIndex = 0 then
    DsnRegister.DsnStage := DsnStage0
  else if TabPaginas.TabIndex = 1 then
    DsnRegister.DsnStage := DsnStage1
  else if TabPaginas.TabIndex = 2 then
    DsnRegister.DsnStage := DsnStage2
  else if TabPaginas.TabIndex = 3 then
    DsnRegister.DsnStage := DsnStage3
  else if TabPaginas.TabIndex = 4 then
    DsnRegister.DsnStage := DsnStage4
  else if TabPaginas.TabIndex = 5 then
    DsnRegister.DsnStage := DsnStage5
  else if TabPaginas.TabIndex = 6 then
    DsnRegister.DsnStage := DsnStage6
  else if TabPaginas.TabIndex = 7 then
    DsnRegister.DsnStage := DsnStage7
  else if TabPaginas.TabIndex = 8 then
    DsnRegister.DsnStage := DsnStage8
  else if TabPaginas.TabIndex = 9 then
    DsnRegister.DsnStage := DsnStage9
  else if TabPaginas.TabIndex = 10 then
    DsnRegister.DsnStage := DsnStage10;
  DsnRegister.Designing := True;
end;

procedure TFormEntradaDados.AtualizaLista_CB;
var
  I, Y: Integer;
  NvLista: TStringList;
  NomeComp: String;
  Componente: TComponent;
begin
  NvLista := TStringList.Create;
  NvLista.Add('');
  for Y:=1 to FormObjInsp.CB1.Items.Count-1 do
  begin
    NomeComp := Copy(FormObjInsp.CB1.Items[Y],01,Pos(':',FormObjInsp.CB1.Items[Y])-1);
    I := 0;
    Componente := Nil;
    while I <= ComponentCount-1 do
    begin
      if Components[I].Name = NomeComp then
      begin
        Componente := Components[I];
        I := 9999;
      end;
      Inc(I);
    end;
    if Componente <> nil then
      NvLista.Add(FormObjInsp.CB1.Items[Y]);
  end;
  FormObjInsp.CB1.Items := NvLista;
  NvLista.Free;
  ExcluiComp := False;
end;

procedure TFormEntradaDados.DsnStage0ControlCreate(Sender: TObject;
  Component: TComponent);
Var
  Comp: TControl;
  ParentNome: String;
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  Comp := TControl(Component);
  ParentNome := UpperCase(Comp.Parent.ClassName);
  //Comp_Dimensao(Component, CompBotao);
  TextoDFM.Modified := True;

  if CompBotao then
  begin
    Define_Dimensoes(Comp);
    if (UpperCase(Comp.ClassName) = 'TPAGECONTROL') then
    begin
      CompPageControl := TWinControl(Comp);
      PageControl_NovaPagina;
    end
  end;

  if UpperCase(Comp.ClassName) <> 'TDSNSTAGE' then
  begin
    //FormDesigner_Net.Adiciona_CB1(Comp.Name + ': ' +Comp.ClassName);
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela + 'AND UPPER(NOME) ='+#39+UpperCase(Comp.Name)+#39 ;
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    if TabGlobal_i.DCAMPOST.Eof then
      AtribuiExtras(Comp.Name, TabPaginas.TabIndex, Comp.ClassName,
                                 Comp.Top, Comp.Left, Comp.Width, Comp.Height)
    else
    begin
      NomeCampo := TabGlobal_i.DCAMPOST.NOME.Conteudo;
      TpCampo   := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
      EdCampo   := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
      EdEstilo  := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
      EdTitulo  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
      EdLista   := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo;
      EdTamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
      if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
        EdChave := True
      else
        EdChave := False;
      Busca_ChaveEst := False;
      if UpperCase(Comp.ClassName) = 'TXDBLOOKUP' then
      begin
        EDBLook := True;
        Busca_ChaveEst := True;
      end
      else
        EDBLook := False;
      AtribuiCampo(Comp.Name, TabPaginas.TabIndex, EdChave,
                               Comp.Top, Comp.Left, Comp.Width, Comp.Height);
    end;
    FormObjInsp.Atribui(Comp, True);
    //FormDesigner_Net.ObjectInspector.InspectObject := Comp;
    SetFocus;
  end;
  TDsnStage(Sender).UpdateControl;
  CompBotao := False;
end;

procedure TFormEntradaDados.PageControl_NovaPagina;
var
  Comp2: TControl;
begin
  DsnRegister.Designing:= False;
  Comp2 := TTabSheet(CreateComponent(TTabSheet,'TTABSHEET',0,0,True,'','TTabSheet', True));
  TTabSheet(Comp2).PageControl := TPageControl(CompPageControl);
  TTabSheet(Comp2).Visible := True;
  TPageControl(CompPageControl).ActivePage := TTabSheet(Comp2);
  DsnRegister.Designing:= True;
end;

procedure TFormEntradaDados.DsnStage0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  QueryP: TIBQuery;
  Ok: Boolean;
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
  if InserirCampo then
  begin
    //if EdCampo = 9 then
    //  CreateComponent(TDBGrid,'TDBGrid',X,Y,True,NomeGrid,'Grid', True)
    if ListaSelecaoCampos.Count > 0 then
      InserirCamposPagina(ListaSelecaoCampos, P_Titulo_DB, P_Distribuicao_DB, X, Y)
    else
      DsnRegister.Designing := True;
    ListaSelecaoCampos.Clear;
    InserirCampo := False;
  end;
end;

procedure TFormEntradaDados.DsnStage0SelectQuery(Sender: TObject;
  Component: TComponent; var CanSelect: TSelectAccept);
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
end;

procedure TFormEntradaDados.DsnStage0MoveQuery(Sender: TObject;
  Component: TComponent; var CanMove: Boolean);
var
  ThreadObj: ThObjInsp;
begin
  TextoDFM.Modified := True;
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
  ObjetoAtual := Component;
  if Thread_ok then
  begin
    Thread_Ok := False;
    ThreadObj := ThObjInsp.Create(False);
    SetFocus;
  end;
end;

procedure TFormEntradaDados.DsnSelectChangeSelected(Sender: TObject;
  Targets: TSelectedComponents; Operation: TSelectOperation);
Var
  I: Integer;
begin
  ListaSelecionados.Clear;
  FormObjInsp.Atribui(Nil, True);
  //FormDesigner_Net.ObjectInspector.Clear;
  for I:=0 to Targets.Count-1 do
  begin
    ListaSelecionados.Add(Targets.Items[I]);
    if I = 0 then
      FormObjInsp.Atribui(Targets.Items[I], True);
  end;
  Dsg_NovaPagina.Visible := False;
  Divisao_NvPg.Visible := False;
  if Targets.Count = 1 then
  begin
    if Targets.Items[0] is TPageControl then
    begin
      Dsg_NovaPagina.Visible := True;
      Divisao_NvPg.Visible := True;
    end;
    SetFocus;
    ObjetoAtual := Targets.Items[0];
  end;
end;

procedure TFormEntradaDados.DsnStage0DeleteQuery(Sender: TObject;
  Component: TComponent; var CanDelete: Boolean);
Var
  Nome, Classe: String;
  Posicao: Integer;
  Resp, Resp2, I: Integer;
begin
  Nome   := TControl(Component).Name;
  Classe := TControl(Component).ClassName;
  if ExcluiTodos then
    Resp := mrYes
  else
    Resp   := Mensagem('Excluir: "'+Nome+ '" ?',ModConfirmacao,[ModSim,ModNao,ModTodos]);
  if (Resp = mrYes) or (Resp = 10) then
  begin
    Posicao := Lista_CB1.IndexOf(Nome + ': ' + Classe);
    if Posicao > -1 then
    begin
      Lista_CB1.Delete(Posicao);
      FormObjInsp.CB1.Items.Clear;
      FormObjInsp.CB1.Items.AddStrings(Lista_CB1);
    end;
    if ExcluiTodosEv then
      Resp2 := mrYes
    else
      Resp2 := Mensagem('Excluir os eventos associados ao objeto: "'+Nome+'" ?',ModConfirmacao,[ModSim,ModNao,ModTodos]);
    if (Resp2 = mrYes) or (Resp2 = 10) then
      ExcluiObjeto(Nome, True)
    else
      ExcluiObjeto(Nome, False);
    FormObjInsp.Atribui(Nil, True);
    //FormDesigner_Net.ObjectInspector.Clear;
    SetFocus;
    CanDelete := True;
    if Resp = 10 then
      ExcluiTodos := True;
    if Resp2 = 10 then
      ExcluiTodosEv := True;
    ExcluiComp := True;
  end
  else
    CanDelete := False;
end;

procedure TFormEntradaDados.BtnRelac_1Click(Sender: TObject);
var
  QueryP: TIBQuery;
  ListaForm: TStringList;
  I,Y,T: Integer;
  Achou, Ok: Boolean;
begin
  ListaForm := TStringList.Create;
  QueryP    := TIBQuery.Create(Self);
  QueryP.Database    := TabGlobal_i.DFORMULARIO.DataBase;
  QueryP.Transaction := TabGlobal_i.DFORMULARIO.Transaction;
  FormFormRel := TFormFormRel.Create(Application);
  Try
    QueryP.Sql.Text    := 'Select Numero, Nome, Titulo_F From Formulario Where Tipo = 2';
    QueryP.Open;
    FormFormRel.Lista.Items.Clear;
    QueryP.First;
    while not QueryP.Eof do
    begin
      if (Trim(QueryP.Fields[1].AsString) <> '') and
         (UpperCase(Trim(QueryP.Fields[1].AsString)) <> UpperCase(Trim(EdTabela))) then
      begin
        FormFormRel.Lista.Items.Add(Trim(QueryP.Fields[1].AsString) + ' - ' + QueryP.Fields[2].AsString);
        //FormPaleta2.PageEditor.ActivePageIndex := 0;
        with FormDesigner_Net.CurrentEdit do //TextoPas do
        begin
          CaretY := 1;
          CaretX := 1;
          SearchReplace(#39+'mnu'+Trim(QueryP.Fields[1].AsString)+#39, '', SearchOptionsPd );
          if CaretY > 1 then
            FormFormRel.Lista.Checked[FormFormRel.Lista.Items.Count-1] := True;
        end;
      end;
      QueryP.Next;
    end;
    QueryP.Close;
    FormFormRel.ShowModal;
  Finally
    Ok := FormFormRel.Relacionou;
    for I:=0 to FormFormRel.Lista.Items.Count-1 do
      if FormFormRel.Lista.Checked[I] then
        ListaForm.Add(Trim(Copy(FormFormRel.Lista.Items[I],01,Pos('-',FormFormRel.Lista.Items[I])-1)));
    FormFormRel.Free;
  end;
  if Ok then
  begin
    //FormPaleta2.PageEditor.ActivePageIndex := 0;
    with FormDesigner_Net.CurrentEdit do //TextoPas do
    begin
      CaretY := 1;
      CaretX := 1;
      SearchReplace('09-Início do Bloco Modular.', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Y := CaretY;
        Achou := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if Copy(Trim(Lines[CaretY]),01,09) = '{99-Final' then
            Achou := True
          else
            Lines.Delete(CaretY);
        end;
        T := 6000;
        for I:=0 to ListaForm.Count-1 do
        begin
          QueryP.Sql.Text := 'Select Numero, Nome, Titulo_F, Tipo From Formulario Where Nome = '+#39+ListaForm[I]+#39;
          QueryP.Open;
          if not QueryP.Eof then
          begin
            Modified := True;
            inc(T);
            Lines.Insert(Y,'  AddMenuItem(PopRelacionados, '+#39+Trim(QueryP.Fields[2].AsString)+#39+', '+#39+'mnu'+Trim(QueryP.Fields[1].AsString)+#39+', True , 0, '+IntToStr(T)+');');
            Inc(Y);
          end;
          QueryP.Close;
        end;
        for I:=0 to ListaForm.Count-1 do
          AtribuiUses(ListaForm[I]);
        for T:=0 to 1 do
        begin
          TextoDFM.CaretX := 1;
          TextoDFM.CaretY := 1;
          TextoDFM.SearchReplace(' object BtnRelac_'+Trim(IntToStr(T+1))+':', '', SearchOptionsPd);
          if TextoDFM.CaretY > 1 then
          begin
            Achou := False;
            while (not Achou) and (TextoDFM.CaretY < TextoDFM.Lines.Count-1) do
            begin
              if TrimRight(TextoDFM.Lines[TextoDFM.CaretY]) = '        end' then
              begin
                if ListaForm.Count > 0 then
                  TextoDFM.Lines.Insert(TextoDFM.CaretY-1,'          Visible = True')
                else
                  TextoDFM.Lines.Insert(TextoDFM.CaretY-1,'          Visible = False');
                Achou := True;
              end;
              if UpperCase(Copy(Trim(TextoDFM.Lines[TextoDFM.CaretY]),01,09)) = 'VISIBLE =' then
              begin
                if ListaForm.Count > 0 then
                  TextoDFM.Lines[TextoDFM.CaretY] := '          Visible = True'
                else
                  TextoDFM.Lines[TextoDFM.CaretY] := '          Visible = False';
                Achou := True;
              end;
              TextoDFM.CaretY := TextoDFM.CaretY + 1;
            end;
          end;
        end;
      end;
      CaretY := 1;
      CaretX := 1;
      SearchReplace('10-Início do Bloco Modular.', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Y := CaretY;
        Achou := False;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if Copy(Trim(Lines[CaretY]),01,09) = '{99-Final' then
            Achou := True
          else
            Lines.Delete(CaretY);
        end;
        T := 6000;
        for I:=0 to ListaForm.Count-1 do
        begin
          QueryP.Sql.Text := 'Select Numero, Nome, Titulo_F, Tipo From Formulario Where Nome = '+#39+ListaForm[I]+#39;
          QueryP.Open;
          if not QueryP.Eof then
          begin
            inc(T);
            if T = 6001 then
              Lines.Insert(Y, '  if MenuItem.Tag = '+IntToStr(T)+' then')
            else
              Lines.Insert(Y, '  else if MenuItem.Tag = '+IntToStr(T)+' then');
            Inc(Y);
            Lines.Insert(Y, '  begin');
            Inc(Y);
            if (QueryP.Fields[3].AsInteger = 2) or
               (QueryP.Fields[3].AsInteger = 3) or
               (QueryP.Fields[3].AsInteger = 4) or
               (QueryP.Fields[3].AsInteger = 6) then
            begin
              Lines.Insert(Y, '    Form'+Trim(QueryP.Fields[1].AsString)+' := TForm'+Trim(QueryP.Fields[1].AsString)+'.Create(Application);');
              Inc(Y);
              Lines.Insert(Y, '    Try');
              Inc(Y);
              Lines.Insert(Y, '      Form'+Trim(QueryP.Fields[1].AsString)+'.ShowModal;');
              Inc(Y);
              Lines.Insert(Y, '    Finally');
              Inc(Y);
              Lines.Insert(Y, '      Form'+Trim(QueryP.Fields[1].AsString)+'.Free;');
              Inc(Y);
              Lines.Insert(Y, '    end;');
            end
            else
              Lines.Insert(Y, '    ExecutaForm(TForm'+Trim(QueryP.Fields[1].AsString)+',Form'+Trim(QueryP.Fields[1].AsString)+');');
            Inc(Y);
            if I = ListaForm.Count-1 then
              Lines.Insert(Y, '  end;')
            else
              Lines.Insert(Y, '  end');
            Inc(Y);
          end;
          QueryP.Close;
        end;
      end;
    end;
  end;
  ListaForm.Free;
  QueryP.Free;
end;

procedure TFormEntradaDados.RelacionamentoVazio;
Var
  QueryP: TIBQuery;
  Ok: Boolean;
  NomeGrid: String;
begin
  {if EdFiltroRel.Count = 0 then
  begin
    FormGridRelac := TFormGridRelac.Create(Application);
    Try
      FormGridRelac.Caption := 'Relacionamento de 1xN - ( Entrada de Dados Filho )';
      FormGridRelac.EdTabela.Text := FormEntradaDados.NomeTab;
      FormGridRelac.ComboTab.Items.Clear;
      QueryP := TIBQuery.Create(Self);
      QueryP.DataBase := TabGlobal_i.DTABELAS.DataBase;
      QueryP.Sql.Text := 'Select Nome, Titulo_T, Numero From Tabelas order by Nome';
      QueryP.Open;
      QueryP.First;
      while not QueryP.Eof do
      begin
        FormGridRelac.ComboTab.Items.Add(QueryP.Fields[0].AsString+ ' - '+QueryP.Fields[1].AsString + Space(60) + StrZero(QueryP.Fields[2].AsInteger,04));
        QueryP.Next;
      end;
      QueryP.Close;
      QueryP.free;
      FormGridRelac.CamposEdTabela.Items.Clear;
      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+FormEntradaDados.NrTabela;
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
          FormGridRelac.CamposEdTabela.Items.Add(TabGlobal_i.DCAMPOST.NOME.Conteudo);
        TabGlobal_i.DCAMPOST.Next;
      end;
      FormGridRelac.ShowModal;
    Finally
      Ok := FormGridRelac.Inseriu;
      NomeGrid := FormGridRelac.NomeGrid;
      FormGridRelac.Free;
    end;
  end;}
end;

procedure TFormEntradaDados.Dsg_EnviarparafrenteClick(Sender: TObject);
begin
  FormPrincipal.EnviarparafrenteClick(Self);
end;

procedure TFormEntradaDados.Dsg_EnviarparatrasClick(Sender: TObject);
begin
  FormPrincipal.EnviarparatrasClick(Self);
end;

procedure TFormEntradaDados.Dsg_Recortar1Click(Sender: TObject);
begin
  FormPrincipal.RecortarClick(Self);
end;

procedure TFormEntradaDados.Dsg_Copiar1Click(Sender: TObject);
begin
  FormPrincipal.CopiarClick(Self);
end;

procedure TFormEntradaDados.Dsg_Colar1Click(Sender: TObject);
begin
  FormPrincipal.ColarClick(Self);
end;

procedure TFormEntradaDados.Dsg_Excluir1Click(Sender: TObject);
begin
  if FormDesigner_Net.CurrentPage = 1 then
    DsnRegister.DsnStage.Delete;
end;

procedure TFormEntradaDados.Dsg_SelecionarTodos1Click(Sender: TObject);
begin
  FormPrincipal.SelecionarTudoClick(Self);
end;

procedure TFormEntradaDados.AtribuiUses(Arquivo: String);
var
  Achou, Achou2: Boolean;
begin
  //FormPaleta2.PageEditor.ActivePage.PageIndex := 0;
  with FormDesigner_Net.CurrentEdit do
  begin
    CaretX := 1;
    CaretY := 1;
    SearchReplace('uses Publicas', '', SearchOptionsPd );
    if CaretY > 1 then
    begin
      Achou  := False;
      Achou2 := False;
      CaretY := CaretY - 1;
      while (not Achou) and (CaretY <= Lines.Count-1) do
      begin
        if Pos(Arquivo,Lines[CaretY]) > 0 then
          Achou2 := True;
        if Pos(';',Lines[CaretY]) > 0 then
          Achou := True
        else
          CaretY := CaretY + 1;
      end;
      if (Achou) and (not Achou2) then
      begin
        Lines[CaretY] := TrocaString(Lines[CaretY],';','',[rfReplaceAll]);
        Lines[CaretY] := Lines[CaretY] + ', ' +Arquivo + ';';
      end;
    end;
    CaretX := 1;
    CaretY := 1;
  end;
end;

function TFormEntradaDados.CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
                                      GravaFRM: Boolean; Campo: String; TipoCampo: String; AtInspector: Boolean):TComponent;
var
   Component:TComponent;
   Control:TControl;
   Count:Integer;
   PropList:PPropList;
   I,Position1:Integer;
   ValueStr:string;
   Info:PTypeInfo;
   Ordem: Integer;
   NomesPgs: string;
   ImageG: TImage;
   BmpRes : TBitMap;
   ResName : String;
   Ok: Boolean;
   ListaOp: TStringList;
   Largura, Altura: Integer;
begin
  Ok := True;
  if Campo <> '' then
    for I:=0 to FormObjInsp.CB1.Items.Count-1 do
      if UpperCase(Copy(FormObjInsp.CB1.Items[I],1,Pos(':',FormObjInsp.CB1.Items[I])-1)) = UpperCase(Campo) then
        Ok := False;
  if Not Ok then
  begin
    Mensagem('Componente já existe !',ModInformacao,[modOk]);
    DsnRegister.Designing:= True;
    InserirCampo := False;
    exit;
  end;
  if TabPaginas.TabIndex < 0 then
  begin
    Mensagem('Página não Selecionada !',ModInformacao,[ModOk]);
    DsnRegister.Designing:= True;
    InserirCampo := False;
    exit;
  end;
  Ordem := 0;
  Component := ComponentClass.Create(Self); // FormEntradaDados
  if Campo = '' then
  begin
    if Component is TControl then
    begin
      Control := TControl(Component);
      Control.Name:=UniqueName(Component,Tipo);
    end
    else begin
      Control.Name:=UniqueName(Component,Tipo);
    end;
  end
  else
  begin
    if Component is TControl then
    begin
      Control := TControl(Component);
      Control.Name:=Campo;
    end
    else begin
      Control.Name:=Campo;
    end;
  end;
  if Tipo <> 'TTABSHEET' then
  begin
    if TabPaginas.TabIndex = 0 then
      Control.Parent := DsnStage0
    else if TabPaginas.TabIndex = 1 then
      Control.Parent := DsnStage1
    else if TabPaginas.TabIndex = 2 then
      Control.Parent := DsnStage2
    else if TabPaginas.TabIndex = 3 then
      Control.Parent := DsnStage3
    else if TabPaginas.TabIndex = 4 then
      Control.Parent := DsnStage4
    else if TabPaginas.TabIndex = 5 then
      Control.Parent := DsnStage5
    else if TabPaginas.TabIndex = 6 then
      Control.Parent := DsnStage6
    else if TabPaginas.TabIndex = 7 then
      Control.Parent := DsnStage7
    else if TabPaginas.TabIndex = 8 then
      Control.Parent := DsnStage8
    else if TabPaginas.TabIndex = 9 then
      Control.Parent := DsnStage9
    else if TabPaginas.TabIndex = 10 then
      Control.Parent := DsnStage10;
  end
  else
    Control.Parent:=CompPageControl;
  Altura  := 21;
  if EdTamanho > 0 then
    Largura := EdTamanho * 7 + 14
  else
    Largura := 121;
  if Tipo = 'TSDBSpinEdit' then
    Largura := 58;
  if Tipo = 'TDBCheckBox' then
    TDBCheckBox(Control).Caption := EdTitulo
  else if Tipo = 'TDBRadioGroup' then
  begin
    ListaOp := TStringList.Create;
    StringToArray(EdLista,';',ListaOp);
    TDBRadioGroup(Control).TabStop := False;
    TDBRadioGroup(Control).Caption := EdTitulo;
    TDBRadioGroup(Control).Items.Clear;
    Altura  := 21 * ListaOp.Count;
    Largura := 100;
    ListaOp.Free;
  end
  else if Tipo = 'TDBGrid' then
  begin
    TDBGrid(Control).Options  := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit];
    TDBGrid(Control).ReadOnly := True;
    TDBGrid(Control).TitleFont.Color := ClBlue;
    {if EdAlinhamento = 0 then
      TDBGrid(Control).Align := alNone
    else if EdAlinhamento = 1 then
      TDBGrid(Control).Align := alTop
    else if EdAlinhamento = 2 then
      TDBGrid(Control).Align := alBottom
    else if EdAlinhamento = 3 then
      TDBGrid(Control).Align := alLeft
    else if EdAlinhamento = 4 then
      TDBGrid(Control).Align := alRight
    else if EdAlinhamento = 5 then
      TDBGrid(Control).Align := alClient;}
  end;
  if Tipo = 'TXNumEdit' then
  begin
    TXNumEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end
  else if Tipo = 'TXDateEdit' then
  begin
    TXDateEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end
  else if (Tipo = 'TXDBNumEdit') and (TpCampo = 3) then
  begin
    TXDBNumEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end
  else if Tipo = 'TXDBDateEdit' then
  begin
    TXDBDateEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end;
  if (EdCampo = 5) and (EdEstilo = 1) then
    Largura := Largura + 16;
  Control.Left   := X;
  Control.Top    := Y;
  if (TipoCampo = 'Edit') or (TipoCampo = 'RadioGroup') or
     (TipoCampo = 'SpinEdit') then
  begin
    Control.Height := Altura;
    Control.Width  := Largura;
  end;
  Control.ShowHint := True;
  Count:=GetPropList(Component.ClassInfo,tkProperties,nil);
  GetMem(PropList,Count*SizeOf(PPropList));
  GetPropList(Component.ClassInfo,tkProperties,PropList);
  FreeMem(PropList,Count*SizeOf(PPropList));
  ObjetoAtual := Control;
  NomeObjetoAtual := Control.Name;
  TipoObjeto  := Control.ClassName;
  //FormDesigner_Net.Adiciona_CB1(Control.Name + ': ' +Control.ClassName);
  if (InserirCampo) and (TipoCampo <> 'Grid') then
    AtribuiCampo(NomeCampo, TabPaginas.TabIndex, EdChave,
                  X, Y, Control.Width, Control.Height)
  else
    AtribuiExtras(Control.Name, TabPaginas.TabIndex, Control.ClassName,
                  X, Y, Control.Width, Control.Height);
  DsnRegister.Designing:= True;
  InserirCampo := False;
  CreateComponent := Control;
  if AtInspector then
    DsnSelect.Select(Control);
end;

function TFormEntradaDados.UniqueName(comp:TComponent; Tipo:String):string;
var
  S1,S2: String;
  n:integer;
begin
  S1:= Comp.ClassName;
  System.Delete(S1,1,1);
  n:=1;
  S2:=S1 + '1';
  while FindComponent(S2) <> nil do
  begin
    Inc(n);
    S2:=S1 + IntToStr(n);
  end;
  UniqueName:=S2;
end;

procedure TFormEntradaDados.AtribuiCampo(Nome: String; Pagina: Integer; EChave: Boolean;
                                     Linha, Coluna, Largura, Altura: Integer);
var I,Y,QtLinhas : Integer;
    Coord: TPoint;
    Pesquisa, ECombo, NomeComp, Titulo, Titulo2: String;
    Achou: Boolean;
    ListaChEst: TStringList;
    QueryP: TIBQuery;
    StrEvento: String;
    Data: Pointer;
begin
  with FormDesigner_Net.CurrentEdit do
  begin
    if EdCampo = 1 then
    begin
      if TpCampo = 1 then
        NomeComp := 'TXDBEdit'
      else if TpCampo = 2 then
        NomeComp := 'TXDBNumEdit'
      else if TpCampo = 3 then
        NomeComp := 'TXDBNumEdit'
      else if TpCampo = 4 then
        NomeComp := 'TXDBDateEdit'
      else if TpCampo = 5 then
        NomeComp := 'TDBMemo'
      else if TpCampo = 6 then
        NomeComp := 'TDBImage';
    end
    else if EdCampo = 2 then
      NomeComp := 'TDBComboBox'
    else if EdCampo = 3 then
      NomeComp := 'TDBRadioGroup'
    else if EdCampo = 4 then
      NomeComp := 'TDBCheckBox'
    else if EdCampo = 5 then
    begin
      if EdEstilo = 0 then
        NomeComp := 'TXDBLookUp'
      else
      begin
        if TpCampo = 1 then
          NomeComp := 'TXDBEdit'
        else if TpCampo = 2 then
          NomeComp := 'TXDBNumEdit'
        else if TpCampo = 3 then
         NomeComp := 'TXDBNumEdit'
        else if TpCampo = 4 then
          NomeComp := 'TXDBDateEdit'
        else if TpCampo = 5 then
          NomeComp := 'TDBMemo'
        else if TpCampo = 6 then
          NomeComp := 'TDBImage';
      end;
    end;
    CaretX := 1;
    CaretY := 1;
    SearchReplace(' '+Nome+': '+NomeComp, '', SearchOptionsPd );
    if CaretY <= 1 then
    begin
      CaretX := 1;
      CaretY := 1;
      SearchReplace('01-Início do Bloco Modular.', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        BlockBegin := Coord;
        BlockEnd   := Coord;
        Y := CaretY;
        FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    '+Nome+': '+NomeComp+';');
        CaretX := 1;
        FormDesigner_Net.CurrentEdit.Modified := True;
      end
      else
        Mensagem('Bloco de codificação "01", não foi encontrado !!!',modErro,[modOk]);
      CaretX := 1;
      CaretY := 1;
    end;
    Pesquisa := 'AtribuiCampoEdicao(TabGlobal.D'+NomeTab+', TabGlobal.D'+NomeTab+'.'+Nome;
    SearchReplace(Pesquisa+',', '', SearchOptionsPd );
    if CaretY <= 1 then
    begin
      // Evento não encontrado, vamos criar !
      CaretX := 1;
      CaretY := 1;
      if EdCampo = 2 then
        ECombo := Nome+'DrawItem'
      else
        ECombo := 'Nil';
      SearchReplace('06-Início do Bloco Modular.', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        BlockBegin := Coord;
        BlockEnd   := Coord;
        Y := CaretY;
        if EChave then
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  '+Pesquisa+', -1, '+Nome+'Exit, '+ECombo+', ListaCamposEd, Form'+NomeForm+', DataSource, ChamaGridPesquisa);')
        else
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  '+Pesquisa+', '+IntToStr(Pagina)+', '+Nome+'Exit, '+ECombo+', ListaCamposEd, Form'+NomeForm+', DataSource, ChamaGridPesquisa);');
        CaretX := 1;
        FormDesigner_Net.CurrentEdit.Modified := True;
      end
      else
        Mensagem('Bloco de codificação "06", não foi encontrado !!!',modErro,[modOk]);
      CaretX := 1;
      CaretY := 1;
      SearchReplace(' '+Nome+'Exit(', '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace('procedure FormShow', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          BlockBegin := Coord;
          BlockEnd   := Coord;
          Y := CaretY - 1;
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    procedure '+Nome+'Exit(Sender: TObject);');
        end;
        include( SearchOptionsPd, ssoBackwards );
        Data := Nil;
        ExecuteCommand(ecEditorBottom,#0,Data);
        SearchReplace('end.', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          //StrEvento := Nome+'Exit(Sender: TObject)';
          StrEvento := Nome+':'+Nome+'Exit';
          if ListaEventos.IndexOf(StrEvento) < 0 then
            ListaEventos.Add(StrEvento);
          BlockBegin := Coord;
          BlockEnd   := Coord;
          Y := CaretY - 1;
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'procedure TForm'+NomeForm+'.'+Nome+'Exit(Sender: TObject);');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'var MsgErro : string;');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'begin');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+3,'  if AbandonandoEdicao then');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+4,'    Exit;');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+5,'  if not TabGlobal.D'+NomeTab+'.'+Nome+'.Valido(MsgErro) then');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+6,'    ErroValidacaoCampo(MsgErro, TabGlobal.D'+NomeTab+'.'+Nome+');');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+7,'  if not SalvarRegistro then');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+8,'    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+9,'end;');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10,'');
          FormDesigner_Net.CurrentEdit.Modified := True;
          CaretX := 1;
          CaretY := Y+3;
        end;
        exclude( SearchOptionsPd, ssoBackwards );
      end;
      if ECombo <> 'Nil' then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace(' '+Nome+'DrawItem(', '', SearchOptionsPd );
        if CaretY <= 1 then
        begin
          CaretX := 1;
          CaretY := 1;
          StrEvento := Nome + ':' + Nome+'DrawItem';
          if ListaEventos.IndexOf(StrEvento) < 0 then
            ListaEventos.Add(StrEvento);
          SearchReplace('procedure FormShow', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            BlockBegin := Coord;
            BlockEnd   := Coord;
            Y := CaretY - 1;
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    procedure '+Nome+'DrawItem(Control: TWinControl; Index: Integer;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'                              Rect: TRect; State: TOwnerDrawState);');
          end;
          include( SearchOptionsPd, ssoBackwards );
          Data := Nil;
          ExecuteCommand(ecEditorBottom,#0,Data);
          SearchReplace('end.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            BlockBegin := Coord;
            BlockEnd   := Coord;
            Y := CaretY - 1;
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'procedure TForm'+NomeForm+'.'+Nome+'DrawItem(Control: TWinControl; Index: Integer;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'                                        Rect: TRect; State: TOwnerDrawState);');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'var Canvas : TCanvas;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+3,'begin');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+4,'  if Control is TDBComboBox then');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+5,'    Canvas  := (Control as TDBComboBox).Canvas');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+6,'  else');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+7,'    Canvas  := (Control as TComboBox).Canvas;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+8,'  Canvas.FillRect(Rect);');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+9,'  if TabGlobal.D'+NomeTab+'.'+Nome+'.DescValorValido[Index] = '+#39+#39+' then');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10,'    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal.D'+NomeTab+'.'+Nome+'.ValorValido[Index]))');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+11,'  else');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+12,'    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal.D'+NomeTab+'.'+Nome+'.DescValorValido[Index]));');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+13,'end;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+14,'');
            FormDesigner_Net.CurrentEdit.Modified := True;
            CaretX := 1;
            CaretY := Y+3;
          end;
          exclude( SearchOptionsPd, ssoBackwards );
        end;
      end;
    end;
  end;
  if EDBLook then
  begin
    ListaChEst := TStringList.Create;
    if Busca_ChaveEst then
    begin
      //FormPrincipal.Texto.Lines.Clear;
      //if FileExists(Projeto.Pasta + 'ChaveEst.Tmp') then
      //  FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'ChaveEst.Tmp');
      //FormPrincipal.Texto.SearchReplace('** '+Nome, '', SearchOptionsPd );
      //if FormPrincipal.Texto.CaretY > 1 then
      //begin
      //  ListaChEst.Add(FormPrincipal.Texto.Lines[FormPrincipal.Texto.CaretY]);
      //  ListaChEst.Add(FormPrincipal.Texto.Lines[FormPrincipal.Texto.CaretY+1]);
      //end;
      //FormPrincipal.Texto.Lines.Clear;
    end;
    if ListaChEst.Count = 0 then
    begin
      FormChaveEst := TFormChaveEst.Create(Application);
      Try
        FormChaveEst.EdTabela.Text := NomeTab;
        FormChaveEst.ComboTab.Items.Clear;
        //FormChaveEst.TipoExpressao := 1;
        QueryP := TIBQuery.Create(Self);
        QueryP.Database := TabGlobal_i.DTABELAS.DataBase;
        QueryP.Sql.Text := 'Select Nome, Titulo_T, Numero From Tabelas order by Nome';
        QueryP.Open;
        QueryP.First;
        while not QueryP.Eof do
        begin
          if Trim(QueryP.Fields[0].AsString) <> '' then
          begin
            Titulo := Trim(QueryP.Fields[0].AsString);
            Titulo2:= Trim(QueryP.Fields[1].AsString);
            FormChaveEst.ComboTab.Items.Add(Titulo+' - '+Titulo2+Space(80)+StrZero(QueryP.Fields[2].AsInteger,04));
          end;
          QueryP.Next;
        end;
        QueryP.Close;
        QueryP.Free;
        FormChaveEst.CamposEdTabela.Items.Clear;
        FormChaveEst.CamposEdTabela.Items.Add(Nome);
        FormChaveEst.CamposEdTabela.ItemIndex := 0;
        FormChaveEst.ShowModal;
      Finally
        ListaChEst.AddStrings(FormChaveEst.CamposRelacionados.Items);
        FormChaveEst.Free;
        FormPrincipal.Texto2.Lines.Clear;
      end;
    end;
    if ListaChEst.Count > 0 then
    begin
      //FormPaleta2.PageEditor.ActivePageIndex := 0;
      with FormDesigner_Net.CurrentEdit do
      begin
        Pesquisa := ListaChEst[0];
        SearchReplace(Pesquisa, '', SearchOptionsPd );
        if CaretY <= 1 then
        begin
          // Evento não encontrado, vamos criar !
          CaretX := 1;
          CaretY := 1;
          SearchReplace('06-Início do Bloco Modular.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            BlockBegin := Coord;
            BlockEnd   := Coord;
            Y := CaretY;
            for I:=0 to ListaChEst.Count-1 do
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+I,'  '+ListaChEst[I]);
            CaretX := 1;
            FormDesigner_Net.CurrentEdit.Modified := True;
          end
          else
            Mensagem('Bloco de codificação "06", não foi encontrado !!!',modErro,[modOk]);
          CaretX := 1;
          CaretY := 1;
        end;
      end;
    end;
    ListaChEst.Free;
    EDBLook := False;
    Busca_ChaveEst := False;
  end;
end;

procedure TFormEntradaDados.AtribuiExtras(Nome: String; Pagina: Integer; Tipo: String;
                                     Linha, Coluna, Largura, Altura: Integer);
var I,Y : Integer;
    Coord: TPoint;
    Pesquisa, ECombo, NomeComp, StrEvento: String;
    Achou: Boolean;
begin
  begin
    with FormDesigner_Net.CurrentEdit do
    begin
      if UpperCase(Tipo) = 'TDBGRID' then
      begin
        CaretX := 1;
        CaretY := 1;
        SearchReplace(' DataSource_'+Nome+': TDataSource', '', SearchOptionsPd );
        if CaretY <= 1 then
        begin
          SearchReplace('01-Início do Bloco Modular.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            BlockBegin := Coord;
            BlockEnd   := Coord;
            Y := CaretY;
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    DataSource_'+Nome+': TDataSource;');
            CaretX := 1;
            FormDesigner_Net.CurrentEdit.Modified := True;
            TextoDFM.CaretX := 1;
            TextoDFM.CaretY := 1;
            TextoDFM.SearchReplace('object DataSource:', '', SearchOptionsPd);
            if TextoDFM.CaretY > 1 then
            begin
              Achou := False;
              while (not Achou) and (TextoDFM.CaretY <= TextoDFM.Lines.Count) do
              begin
                TextoDFM.CaretY := TextoDFM.CaretY + 1;
                if TextoDFM.LineText = '  end' then
                begin
                  Achou := True;
                  Y := TextoDFM.CaretY - 1;
                  TextoDFM.Lines.Insert(Y+1,'  object DataSource_'+Nome+': TDataSource');
                  TextoDFM.Lines.Insert(Y+2,'    left = 316');
                  TextoDFM.Lines.Insert(Y+3,'    Top = 21');
                  TextoDFM.Lines.Insert(Y+4,'  end');
                  TextoDFM.Modified := True;
                end;
              end;
            end;
          end
          else
            Mensagem('Bloco de codificação "01", não foi encontrado !!!',modErro,[modOk]);
          SearchReplace('06-Início do Bloco Modular.', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            BlockBegin := Coord;
            BlockEnd   := Coord;
            Y := CaretY;
            //FormPrincipal.Texto.Lines.Clear;
            //if FileExists(Projeto.Pasta + 'ChaveEst.Tmp') then
            //  FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'ChaveEst.Tmp');
            //FormPrincipal.Texto.SearchReplace('** '+Nome, '', SearchOptionsPd );
            //if FormPrincipal.Texto.CaretY < 1 then
            //  FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  '+FormPrincipal.Texto.Lines[FormPrincipal.Texto.CaretY])
            //else
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  DataSource_'+Nome+'.DataSet := TabGlobal.D'+EdNomeTabRel+';');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'  '+Nome+'.DataSource := DataSource_'+Nome+';');
            if EdGridEditavel then
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'  AtribuiGridEdicao(TabGlobal.D'+EdNomeTabRel+', Grid_'+EdNomeTabRel+', True, ValidaColunaGrid);')
            else
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'  AtribuiGridEdicao(TabGlobal.D'+EdNomeTabRel+', Grid_'+EdNomeTabRel+', False, ValidaColunaGrid);');
            CaretX := 1;
            FormDesigner_Net.CurrentEdit.Modified := True;
          end
          else
            Mensagem('Bloco de codificação "06", não foi encontrado !!!',modErro,[modOk]);
          Pesquisa := 'procedure TForm' + NomeForm + '.';
          Pesquisa := Pesquisa + Nome + 'DblClick';
          AbrirEditor(PastaForm + NomeForm + '.PAS',Pesquisa,True);
          StrEvento := Nome+':'+Nome+'DblClick';
          if ListaEventos.IndexOf(StrEvento) < 0 then
            ListaEventos.Add(StrEvento);

          Pesquisa := 'procedure TForm' + NomeForm + '.';
          Pesquisa := Pesquisa + Nome + 'ColEnter';
          AbrirEditor(PastaForm + NomeForm + '.PAS',Pesquisa,True);
          StrEvento := Nome+':'+Nome+'ColEnter';
          if ListaEventos.IndexOf(StrEvento) < 0 then
            ListaEventos.Add(StrEvento);

          Pesquisa := 'procedure TForm' + NomeForm + '.';
          Pesquisa := Pesquisa + Nome + 'Exit';
          AbrirEditor(PastaForm + NomeForm + '.PAS',Pesquisa,True);
          StrEvento := Nome+':'+Nome+'Exit';
          if ListaEventos.IndexOf(StrEvento) < 0 then
            ListaEventos.Add(StrEvento);

          Pesquisa := 'procedure TForm' + NomeForm + '.';
          Pesquisa := Pesquisa + Nome + 'EditButtonClick';
          AbrirEditor(PastaForm + NomeForm + '.PAS',Pesquisa,True);
          StrEvento := Nome+':'+Nome+'EditButtonClick';
          if ListaEventos.IndexOf(StrEvento) < 0 then
            ListaEventos.Add(StrEvento);

          //Pesquisa := 'procedure TForm' + FormEntradaDados.NomeForm + '.';
          //Pesquisa := Pesquisa + Nome + 'Associacao';
          //AbrirEditor(Projeto.Pasta + FormEntradaDados.NomeForm + '.PAS',Pesquisa,True);
        end;
      end;
      CaretX := 1;
      CaretY := 1;
      SearchReplace(' '+Nome+': '+Tipo, '', SearchOptionsPd );
      if CaretY <= 1 then
      begin
        SearchReplace('01-Início do Bloco Modular.', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          BlockBegin := Coord;
          BlockEnd   := Coord;
          Y := CaretY;
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    '+Nome+': '+Tipo+';');
          CaretX := 1;
          FormDesigner_Net.CurrentEdit.Modified := True;
        end
        else
          Mensagem('Bloco de codificação "01", não foi encontrado !!!',modErro,[modOk]);
        CaretX := 1;
        CaretY := 1;
      end;
    end;
  end;
end;

procedure TFormEntradaDados.ExcluiObjeto(Nome: String; Eventos: Boolean);
Var
  Achou, Fim : Boolean;
  Y,P: Integer;
  LstExclusao: TStringList;
  Pesquisa, StrEvento: String;
  Qtd_Begin, Qtd_End: Integer;
  Qtd_I_Coment, Qtd_F_Coment: Integer;
begin
  begin
    with FormDesigner_Net.CurrentEdit do
    begin
      Modified := True;

      CaretX := 1;
      CaretY := 1;
      SearchReplace(' '+Nome+': ', '', SearchOptionsPd );
      if CaretY > 1 then
        lines.Delete(CaretY - 1);

      P := ListaInvisivel.IndexOf(Nome);
      if P > -1 then
        ListaInvisivel.Delete(P);

      P := ListaDesabilitado.IndexOf(Nome);
      if P > -1 then
        ListaDesabilitado.Delete(P);

      TextoDFM.CaretX := 1;
      TextoDFM.CaretY := 1;
      if TextoDFM.SearchReplace('object DataSource_'+Nome+':', '', SearchOptionsPd) > 0 then
      begin
        achou := False;
        Y     := TextoDFM.CaretY;
        while (not Achou) and (TextoDFM.CaretY <= TextoDFM.Lines.Count) do
        begin
          if TextoDFM.LineText = '  end' then
          begin
            Achou := True;
            TextoDFM.lines.Delete(Y - 1);
          end;
          TextoDFM.lines.Delete(Y - 1);
          TextoDFM.CaretY := Y + 1;
        end;
      end;

      if Eventos then
      begin
        LstExclusao := TStringList.Create;
        for Y:=0 to ListaEventos.Count-1 do
          if UpperCase(Copy(ListaEventos[Y],01,Pos(':',ListaEventos[Y])-1)) = UpperCase(Nome) then
          begin
            LstExclusao.Add(ListaEventos[Y]);
            StrEvento := Trim(Copy(ListaEventos[Y],Pos(':',ListaEventos[Y])+1,Length(ListaEventos[Y])));
            Pesquisa := RetiraBrancos('procedure ' + StrEvento + '(');
            FormDesigner_Net.CurrentEdit.CaretX := 1;
            FormDesigner_Net.CurrentEdit.CaretY := 1;
            FormDesigner_Net.CurrentEdit.SearchReplace(Pesquisa, '', SearchOptionsPd );
            if FormDesigner_Net.CurrentEdit.CaretY > 1 then
            begin
              P := FormDesigner_Net.CurrentEdit.CaretY - 1;
              Fim := false;
              while not Fim do
              begin
                if Pos(');',RetiraBrancos(FormDesigner_Net.CurrentEdit.Lines[P])) > 0 then Fim := True;
                FormDesigner_Net.CurrentEdit.Lines.Delete(P);
              end;
            end;

            Pesquisa := RetiraBrancos('procedure TForm'+NomeForm +'.'+ StrEvento + '(');
            FormDesigner_Net.CurrentEdit.CaretX := 1;
            FormDesigner_Net.CurrentEdit.CaretY := 1;
            FormDesigner_Net.CurrentEdit.SearchReplace(Pesquisa, '', SearchOptionsPd );
            if FormDesigner_Net.CurrentEdit.CaretY > 1 then
            begin
              P := FormDesigner_Net.CurrentEdit.CaretY - 1;
              Fim := false;
              Qtd_Begin := 0;
              Qtd_End := 0;
              Qtd_I_Coment := 0;
              Qtd_F_Coment := 0;
              while (not Fim) and (FormDesigner_Net.CurrentEdit.CaretY < FormDesigner_Net.CurrentEdit.Lines.Count-1) do
              begin
                //Pesquisa := Trim(UpperCase(LineText));
                //Qtd_I_Coment := Qtd_I_Coment + ContaOcorrencia('{',Pesquisa);
                //Qtd_F_Coment := Qtd_F_Coment + ContaOcorrencia('}',Pesquisa);
                //if (Qtd_I_Coment = Qtd_F_Coment) then
                //begin
                //  if (((Copy(Pesquisa,01,05) = 'BEGIN') or (Copy(Pesquisa,01,03) = 'TRY') or (Copy(Pesquisa,01,04) = 'CASE'))) and
                //     ((Pesquisa[6] = ' ') or (Pesquisa[6] = '/') or (Pesquisa[6] = '') or (Pesquisa[6] = '{')) then
                //    inc(Qtd_Begin);
                //  if (Copy(Pesquisa,01,03) = 'END') and
                //     ((Pesquisa[4] = ' ') or (Pesquisa[4] = '/') or (Pesquisa[4] = '') or (Pesquisa[4] = ';') or (Pesquisa[4] = '}')) then
                //    inc(Qtd_End);
                //end;
                //if (Qtd_Begin = Qtd_End) and (Qtd_Begin > 0) then Fim := True;
                FormDesigner_Net.CurrentEdit.Lines.Delete(P);
                Pesquisa := Trim(UpperCase(LineText));
                if (Copy(Pesquisa,01,04) = 'END.') or
                   (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORM' + UpperCase(NomeForm) + '.' ) or
                   (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORM' + UpperCase(NomeForm) + '.' ) then
                  Fim := True;
              end;
              if Trim(UpperCase(LineText)) = '' then
                FormDesigner_Net.CurrentEdit.Lines.Delete(P);
            end;
          end;
        for Y:=0 to LstExclusao.Count-1 do
        begin
          P := ListaEventos.IndexOf(LstExclusao[Y]);
          if P > -1 then
            ListaEventos.Delete(P);
        end;
        LstExclusao.Free;

        CaretX := 1;
        CaretY := 1;
        SearchReplace(' procedure '+Nome+'Associacao', '', SearchOptionsPd );
        if CaretY > 1 then
          lines.Delete(CaretY - 1);

        CaretX := 1;
        CaretY := 1;
        SearchReplace('.'+Nome+'Associacao(Associa: Boolean);', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          achou := False;
          Y     := CaretY;
          while (not achou) and (CaretY <= Lines.Count) do
          begin
            if LineText = 'end;' then
            begin
              Achou := True;
              Lines.Delete(Y - 1);
            end;
            Lines.Delete(Y - 1);
            CaretY := Y + 1;
          end;
        end;

        CaretX := 1;
        CaretY := 1;
        Achou  := True;
        while achou do
        begin
          CaretX := 1;
          CaretY := 1;
          SearchReplace(Nome+'Associacao(', '', SearchOptionsPd );
          if CaretY > 1 then
            lines.Delete(CaretY - 1)
          else
            achou := False;
        end;

        CaretX := 1;
        CaretY := 1;
        SearchReplace(', TabGlobal.D'+NomeTab+'.'+Nome+', ', '', SearchOptionsPd );
        if CaretY > 1 then
          lines.Delete(CaretY - 1);

        CaretX := 1;
        CaretY := 1;
        SearchReplace(Nome+', True, ValidaColunaGrid)', '', SearchOptionsPd );
        if CaretY > 1 then
          lines.Delete(CaretY - 1);

        CaretX := 1;
        CaretY := 1;
        SearchReplace(Nome+', False, ValidaColunaGrid)', '', SearchOptionsPd );
        if CaretY > 1 then
          lines.Delete(CaretY - 1);

        CaretX := 1;
        CaretY := 1;
        SearchReplace(' DataSource_'+Nome+': ', '', SearchOptionsPd );
        if CaretY > 1 then
          lines.Delete(CaretY - 1);

        CaretX := 1;
        CaretY := 1;
        SearchReplace(' DataSource_'+Nome+'.DataSet', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          //FormPrincipal.Texto.Lines.Clear;
          //if FileExists(Projeto.Pasta + 'ChaveEst.Tmp') then
          //  FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'ChaveEst.Tmp');
          //FormPrincipal.Texto.Lines.Add('** '+Nome);
          //FormPrincipal.Texto.Lines.Add(Copy(Lines[CaretY-1],03,500));
          //FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'ChaveEst.Tmp');
          //FormPrincipal.Texto.Lines.Clear;
          lines.Delete(CaretY - 1);
        end;

        CaretX := 1;
        CaretY := 1;
        SearchReplace(' '+Nome+'.DataSource', '', SearchOptionsPd );
        if CaretY > 1 then
          lines.Delete(CaretY - 1);

        CaretX := 1;
        CaretY := 1;
        SearchReplace('CampoRelacionado('+Nome, '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          FormPrincipal.Texto.Lines.Clear;
          //if FileExists(Projeto.Pasta + 'ChaveEst.Tmp') then
          //  FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'ChaveEst.Tmp');
          //FormPrincipal.Texto.Lines.Add('** '+Nome);
          //FormPrincipal.Texto.Lines.Add(Copy(Lines[CaretY-1],03,500));
          //FormPrincipal.Texto.Lines.Add(Copy(Lines[CaretY],03,500));
          //FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'ChaveEst.Tmp');
          //FormPrincipal.Texto.Lines.Clear;
          lines.Delete(CaretY - 1);
          lines.Delete(CaretY - 1);
        end;
      end;
    end;
  end;
end;

procedure TFormEntradaDados.AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
var I,Y,T,W,F : Integer;
    Coord: TPoint;
    Achou, Achou2: Boolean;
    Data: Pointer;
begin
  if Trim(Parametros) = '' then
    Parametros := '(Sender: TObject);';
  begin
    with FormDesigner_Net.CurrentEdit do
    begin
      CaretX := 1;
      CaretY := 1;
      SearchReplace(Pesquisa, '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        BlockBegin := Coord;
        BlockEnd   := Coord;
        CaretX := 1;
        while (UPPERCASE(TRIM(LineText)) <> 'BEGIN') or
              (CaretY > Lines.Count) do
          CaretY := CaretY + 01;
        CaretY := CaretY + 01;
      end
      else
      begin
        // Evento não encontrado, vamos criar !
        CaretX := 1;
        CaretY := 1;
        SearchReplace('procedure FormShow', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          BlockBegin := Coord;
          BlockEnd   := Coord;
          Y := CaretY - 1;
          if Pos(EdNomeTabRel+'Associacao',Pesquisa) > 0 then
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    procedure '+Copy(Pesquisa,Pos('.',Pesquisa)+1,50)+'(Associa: Boolean);')
          else
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'    procedure '+Copy(Pesquisa,Pos('.',Pesquisa)+1,50)+Parametros);
        end;
        include( SearchOptionsPd, ssoBackwards );
        Data := Nil;
        ExecuteCommand(ecEditorBottom,#0,Data);
        SearchReplace('end.', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          exclude( SearchOptionsPd, ssoBackwards );
          BlockBegin := Coord;
          BlockEnd   := Coord;
          Y := CaretY - 1;
          if Pos(EdNomeTabRel+'Associacao',Pesquisa) > 0 then
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,Pesquisa+'(Associa: Boolean);')
          else
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,Pesquisa+Parametros);
          if not Grid then
          begin
            if MemoCodificacao = Nil then
            begin
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'begin');
              if Trim(Codificacao) = '' then
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'')
              else
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'  '+Codificacao);
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+3,'end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+4,'');
            end
            else
            begin
              For F:=0 to MemoCodificacao.Count-1 do
              begin
                inc(Y);
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y,MemoCodificacao[F]);
              end;
              inc(Y);
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'');
            end;
          end
          else
          begin
            if Pos(EdNomeTabRel+'Associacao',Pesquisa) > 0 then
            begin
              //FormEntradaDados.RelacionamentoVazio;
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'begin');
              {FormDesigner_Net.CurrentEdit.Lines.Insert(Y+02,'  TabGlobal.D'+EdNomeTabRel+'.FiltroRelac.Clear;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+03,'  TabGlobal.D'+EdNomeTabRel+'.CamposRelac.Clear;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+04,'  TabGlobal.D'+EdNomeTabRel+'.ValoresRelac.Clear;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+05,'  if Associa then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+06,'  begin');
              for T:=0 to EdFiltroRel.Count -1 do
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+07+T,'    TabGlobal.D'+EdNomeTabRel+'.FiltroRelac.Add('+EdFiltroRel[T]+');');
              W := T;
              for T:=0 to EdFiltroRel.Count -1 do
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+07+T+W,'    TabGlobal.D'+EdNomeTabRel+'.CamposRelac.Add('+EdFiltroCampos[T]+');');
              W := W + T;
              for T:=0 to EdFiltroRel.Count -1 do
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+07+T+W,'    TabGlobal.D'+EdNomeTabRel+'.ValoresRelac.Add('+EdFiltroValores[T]+');');
              W := W + T;
              T := W - 1;
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+08+T,'  end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+09+T,'  TabGlobal.D'+EdNomeTabRel+'.AtualizaSql;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10+T,'end;');}
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+11+T,'');
            end
            else if Pos(EdNomeTabRel+'ColEnter',Pesquisa) > 0 then
            begin
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+02,'  if (TabGlobal.D'+EdNomeTabRel+'.State = dsInsert) and');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+03,'     (TabelaPrincipal.Inclusao) then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+04,'  begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+05,'    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+06,'    if TabelaPrincipal.PesquisaRelacionados(TabelaPrincipal.NomeTabela) then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+07,'    begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+08,'      MessageDlg('+#39+'Duplicidade - Registro já cadastrado !'+#39+',mtWarning,[mbOk],0);');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+09,'      begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10,'        TabGlobal.D'+EdNomeTabRel+'.Cancel;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+11,'        exit;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+12,'      end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+13,'    end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+14,'    if MessageDlg('+#39+'Salvar ('+#39+'+TabelaPrincipal.Titulo+'+#39+') ?'+#39+',mtConfirmation,[mbYes,mbNo],0) <> mrYes then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+15,'    begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+16,'      TabGlobal.D'+EdNomeTabRel+'.Cancel;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+17,'      exit;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+18,'    end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+19,'    if not TabelaPrincipal.Salva then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+20,'    begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+21,'      TabGlobal.D'+EdNomeTabRel+'.Cancel;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+22,'      exit;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+23,'    end');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+24,'    else');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+25,'      if not TabelaPrincipal.Modifica then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+26,'      begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+27,'        TabGlobal.D'+EdNomeTabRel+'.Cancel;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+28,'        exit;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+29,'      end');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+30,'      else');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+31,'        TabGlobal.D'+EdNomeTabRel+'.AtribuiMestre(TabGlobal.D'+EdNomeTabRel+');');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+32,'  end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+33,'  ExecutaPreValidacoesGrid(TabGlobal.D'+EdNomeTabRel+');');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+34,'  KeyPreview := False;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+35,'end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+36,'');
            end
            else if Pos(EdNomeTabRel+'Exit',Pesquisa) > 0 then
            begin
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+02,'  KeyPreview := True;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+03,'end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+04,'');
            end
            else if Pos(EdNomeTabRel+'EditButtonClick',Pesquisa) > 0 then
            begin
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'Var');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+02,'  I: Integer;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+03,'  Campo: TAtributo;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+04,'  CampoGrid: TField;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+05,'begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+06,'  CampoGrid := Grid_'+EdNomeTabRel+'.SelectedField;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+07,'  if CampoGrid = Nil then exit;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+08,'  for I:=0 to TabGlobal.D'+EdNomeTabRel+'.Campos.Count-1 do');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+09,'  begin');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10,'    Campo := TAtributo(TabGlobal.D'+EdNomeTabRel+'.Campos[I]);');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+11,'    if Campo.Valor.FieldName = CampoGrid.FieldName then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+12,'      Break;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+13,'  end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+14,'  if (Campo = nil) or (Campo.Valor.ReadOnly) then exit;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+15,'  FormGridPesquisa := TFormGridPesquisa.Create(Application);');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+16,'  Try');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+17,'    FormGridPesquisa.Atalho := VK_F8;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+18,'    FormGridPesquisa.Campo  := Campo;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+19,'    if FormGridPesquisa.ShowModal = mrOk then');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+20,'      ExecutaPreValidacoesGrid(TabGlobal.D'+EdNomeTabRel+');');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+21,'  Finally');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+22,'    FormGridPesquisa.Free;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+23,'  end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+24,'end;');
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+25,'');
            end
            else
            begin
              //FormEntradaDados.RelacionamentoVazio;
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'begin');
              if Trim(EdFormRel) <> '' then
              begin
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+02,'  if TabelaPrincipal.Inclusao then  // Garante integridade do uso em rede');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+03,'  begin                             // salva o registro PAI para depois incluir os registros FILHO');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+04,'    ExecutaPreValidacoes(TabelaPrincipal, Self, ListaCamposEd);');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+05,'    if TabelaPrincipal.PesquisaRelacionados(TabelaPrincipal.NomeTabela) then');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+06,'    begin');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+07,'      MessageDlg('+#39+'Duplicidade - Registro já cadastrado !'+#39+',mtWarning,[mbOk],0);');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+08,'      exit;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+09,'    end;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10,'    if MessageDlg('+#39+'Salvar ('+#39+'+TabelaPrincipal.Titulo+'+#39+') ?'+#39+',mtConfirmation,[mbYes,mbNo],0) <> mrYes then');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+11,'      exit;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+12,'    if not TabelaPrincipal.Salva then');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+13,'      exit');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+14,'    else');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+15,'      if not TabelaPrincipal.Modifica then');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+16,'        exit;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+17,'  end;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+18,'  Form'+EdFormRel+' := TForm'+EdFormRel+'.Create(Application);');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+19,'  Try');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+20,'    Form'+EdFormRel+'.ShowModal;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+21,'  Finally');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+22,'    Form'+EdFormRel+'.Free;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+23,'  end;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+24,'end;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+25,'');
                AtribuiUses(EdFormRel);
              end
              else
              begin
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+02,'  // Formulário de edição ...');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+03,'end;');
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+04,'');
              end;
            end;
            CaretX := 1;
            CaretY := 1;
            SearchReplace('.TelaManutencao;', '', SearchOptionsPd );
            if CaretY > 1 then
            begin
              {if Pos(EdNomeTabRel+'Associacao',Pesquisa) = 0 then
              begin
                Achou  := False;
                while (not Achou) and (CaretY <= Lines.Count-1) do
                begin
                  if UpperCase(Lines[CaretY]) = 'BEGIN' then
                  begin
                    Achou := True;
                    Y := CaretY;
                    //FormEntradaDados.RelacionamentoVazio;
                    FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'  Grid_'+EdNomeTabRel+'Associacao(True);');
                  end
                  else
                    CaretY := CaretY + 1;
                end;
              end;}
            end;
            CaretX := 1;
            CaretY := 1;
            SearchReplace('.AtribuiValoresPadrao;', '', SearchOptionsPd );
            if CaretY > 1 then
            begin
              {if Pos(EdNomeTabRel+'Associacao',Pesquisa) = 0 then
              begin
                Achou  := False;
                while (not Achou) and (CaretY <= Lines.Count-1) do
                begin
                  if TrimRight(UpperCase(Lines[CaretY])) = 'END;' then
                  begin
                    Achou := True;
                    Y := CaretY - 1;
                    FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'  Grid_'+EdNomeTabRel+'Associacao(True);');
                  end
                  else
                    CaretY := CaretY + 1;
                end;
              end;}
            end;
            CaretX := 1;
            CaretY := 1;
            SearchReplace('.FormCloseQuery(Sender:', '', SearchOptionsPd );
            if CaretY > 1 then
            begin
              {if Pos(EdNomeTabRel+'Associacao',Pesquisa) = 0 then
              begin
                Achou  := False;
                while (not Achou) and (CaretY <= Lines.Count-1) do
                begin
                  if TrimRight(UpperCase(Lines[CaretY])) = 'BEGIN' then
                  begin
                    Achou := True;
                    Y := CaretY;
                    //FormEntradaDados.RelacionamentoVazio;
                    FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'  Grid_'+EdNomeTabRel+'Associacao(False);');
                  end
                  else
                    CaretY := CaretY + 1;
                end;
              end;}
            end;
          end;
          FormDesigner_Net.CurrentEdit.Modified := True;
          CaretX := 1;
          CaretY := Y+3;
        end;
        exclude( SearchOptionsPd, ssoBackwards );
      end;
    end;
  end;
end;

function TFormEntradaDados.Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
var
  I: Integer;
  Linha: String;
begin
  if P > 0 then
    I := P
  else
    I := Texto.Count-1;
  Localiza_Nome := '';
  while I > 0 do
  begin
    Linha := UpperCase(Trim(Texto[I]));
    if (Copy(Linha,01,07) = 'OBJECT ') and
       (Pos('O',UpperCase(Texto[I]))-1 = Espaco) then
    begin
      Linha := UpperCase(Trim(Copy(Linha,08,Length(Linha))));
      Linha := Trim(Copy(Linha,01,Pos(':',Linha)-1));
      Localiza_Nome := Linha;
      I := 0;
    end
    else
      Dec(I);
  end;
end;

procedure TFormEntradaDados.SalvarFormulario(Index: Integer = -1);
var
  I,Y,Z,Qtd: Integer;
  NomesPgs, NomeComp, Prox_Linha, Linha_ev: String;
  Achou, Achou2, Reduzir: Boolean;
  FilePas, FileDfm, FileTpl: String;
  Tmp_FilePas, Tmp_FileDfm, Tmp_FileTpl: String;
  Ok: Boolean;
  Output: TMemoryStream;
  TextoTxt_C: TStringList;

begin
  MsgSalvar := False;
  FilePas := PastaForm + NomeForm + '.Pas';
  FileDfm := PastaForm + NomeForm + '.Dfm';
  Tmp_FilePas := PastaForm + 'Copia\' + NomeForm + '.Pas';
  Tmp_FileDfm := PastaForm + 'Copia\' + NomeForm + '.Dfm';
  ForceDirectories(PastaForm+'Copia');
  ChDir(PastaForm);
  if FileExists(FilePas) then
    CopiaArquivo(FilePas, Tmp_FilePas);
  if FileExists(FileDfm) then
    CopiaArquivo(FileDfm, Tmp_FileDfm);

  PagePrincipal.ActivePageIndex := 0;
  Ok := False;
  try
    FormAguarde := TFormAguarde.Create(Application);
    FormAguarde.Caption := 'Aguarde! Salvando formulário ...';
    //FormAguarde.FormStyle := fsStayOnTop;
    FormAguarde.Show;
    FormObjInsp.Atribui(Nil, True);
    //FormDesigner_Net.ObjectInspector.Clear;
    if ListaSelecionados <> Nil then
      ListaSelecionados.Clear;
    DsnRegister.ClearSelect;
    PreencheConsulta(True);
    Output:=TMemoryStream.Create;
    with OutPut do
    begin
      WriteComponentRes(PastaForm + 'Form'+NomeForm+'.Tmp', Self); // FormEntradaDados
      SaveToFile(PastaForm + 'Form'+NomeForm+'.Tmp');
      Free;
    end;
    ConvertFormOrText(PastaForm + 'Form'+NomeForm+'.Tmp',2);
    DeleteFile(PastaForm + 'Form'+NomeForm+'.Tmp');
    TextoTxt.Lines.Clear;
    if FileExists(PastaForm + 'Form'+NomeForm+'.Txt') then
      TextoTxt.Lines.LoadFromFile(PastaForm + 'Form'+NomeForm+'.Txt');
    VamosGravar := True;
    PreencheConsulta;
    I:=0;
    Y:=0;
    Achou := False;
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('OBJECT PAGEPRINCIPAL:','', SearchOptionsPd);
    Y := TextoDFM.CaretY;
    if Y > 0 then
      while not Achou do
      begin
        if Copy(UpperCase(TextoDfm.Lines[Y]),01,05) = '  END' then
          Achou := True
        else
          TextoDfm.Lines.Delete(Y);
        if Y > TextoDfm.Lines.Count-1 then Achou := True;
      end;
    I:=0; QTD:=0;
    Achou := False; Achou2 := False; Reduzir := False;
    TextoTXT.CaretY := 0;
    TextoTXT.CaretX := 0;
    TextoTXT.SearchReplace('OBJECT PAGEPRINCIPAL:','', SearchOptionsPd);
    I := TextoTXT.CaretY;
    FormAguarde.GaugeProcesso.Min := I;
    FormAguarde.GaugeProcesso.Max := TextoTxt.Lines.Count-1;
    TextoTxt_C := TStringList.Create;
    while I <= TextoTxt.Lines.Count-1 do
    begin
      FormAguarde.GaugeProcesso.Position := I;
      if (Copy(UpperCase(Trim(TextoTxt.Lines[I])),01,02) <> 'ON') and // Não grava evento
         (Copy(Trim(UpperCase(TextoTxt.Lines[I])),01,15) <> 'OBJECT DSNSTAGE') then
      begin
        if Reduzir then
          Prox_Linha := Copy(TextoTxt.Lines[I],03,Length(TextoTxt.Lines[I]))
        else
          Prox_Linha := TextoTxt.Lines[I];
        Achou2 := True;
        if (Prox_Linha = TextoDfm.Lines[Y-1]) and (UpperCase(Trim(Prox_Linha)) = 'END') then
          Achou2 := False;
        if Achou2 then
        begin
          if UpperCase(Trim(Prox_Linha)) = 'END' then
          begin
            NomeComp := Localiza_Nome(TextoTxt_C,Pos('E',UpperCase(Prox_Linha))-1);
            if Trim(NomeComp) <> '' then
            begin
              if ListaInvisivel.IndexOf(NomeComp) > -1 then
              begin
                TextoDfm.Lines.Insert(Y,Space(Pos('E',UpperCase(Prox_Linha))+1)+'Visible = False');
                inc(Y);
              end;
              if ListaDesabilitado.IndexOf(NomeComp) > -1 then
              begin
                TextoDfm.Lines.Insert(Y,Space(Pos('E',UpperCase(Prox_Linha))+1)+'Enabled = False');
                inc(Y);
              end;
              for Z:=0 to ListaEventos.Count-1 do
                if UpperCase(Copy(ListaEventos[Z],01,Pos(':',ListaEventos[Z])-1)) = NomeComp then
                begin
                  Linha_ev := ListaEventos[Z];
                  Linha_ev := Copy(Linha_ev,Pos(':',Linha_ev)+1,Length(Linha_ev));
                  Linha_ev := Copy(Linha_ev,Length(NomeComp)+1,Length(Linha_ev));
                  if Trim(Linha_ev) <> '' then
                  begin
                    FormDesigner_Net.CurrentEdit(Index).CaretY := 0;
                    FormDesigner_Net.CurrentEdit(Index).CaretX := 0;
                    FormDesigner_Net.CurrentEdit(Index).SearchReplace(NomeComp + Linha_ev,'', SearchOptionsPd);
                    if FormDesigner_Net.CurrentEdit(Index).CaretY > 1 then  // vamos ver se o evento existe
                    begin
                      Linha_ev := 'On' + Linha_ev + ' = ' + NomeComp + Linha_ev;
                      TextoDfm.Lines.Insert(Y,Space(Pos('E',UpperCase(Prox_Linha))+1)+Linha_ev);
                      TextoTxt_C.Add(Space(Pos('E',UpperCase(Prox_Linha))+1)+Linha_ev);
                      inc(Y);
                    end;
                  end;
                end;
            end;
          end;
          TextoDfm.Lines.Insert(Y,Prox_Linha);
          TextoTxt_C.Add(Prox_Linha);
          inc(Y);
        end;
      end;
      if (Qtd > 0) and (TrimRight(UpperCase(TextoTxt.Lines[I])) = Space(Qtd)+'END') then
      begin
        Reduzir := False;
        Qtd := 0;
      end;
      if Copy(Trim(UpperCase(TextoTxt.Lines[I])),01,15) = 'OBJECT DSNSTAGE' then
      begin
        Qtd := Length(Copy(TextoTxt.Lines[I],01,Pos('O',UpperCase(TextoTxt.Lines[I]))-1));
        Achou := False;
        while not Achou do
        begin
          inc(I);
          if (Copy(Trim(UpperCase(TextoTxt.Lines[I])),01,07) = 'OBJECT ') or
             (TrimRight(UpperCase(TextoTxt.Lines[I])) = Space(Qtd) + 'END') then
          begin
            Achou := True;
            Dec(I);
          end;
        end;
        Reduzir := True;
      end;
      inc(I);
      if (TrimRight(UpperCase(TextoTxt.Lines[I])) = '  END') then  // fim do PageControl
        I := TextoTxt.Lines.Count;
    end;
    TextoTxt_C.Free;
    VamosGravar := False;
    NomesPgs  := '';
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('  Height =', '', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
    begin
      Y := TextoDFM.CaretY - 1;
      TextoDFM.Lines[Y] := '  Height = '+IntToStr(Height);
    end;
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('  Width =', '', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
    begin
      Y := TextoDFM.CaretY -1;
      TextoDFM.Lines[Y] := '  Width = '+IntToStr(Width);
    end;
    {TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('  WindowState =', '', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
    begin
      Y := TextoDFM.CaretY -1;
      if FormDesigner_Net.dsg_Normal.Checked then
        TextoDFM.Lines[Y] := '  WindowState = wsNormal'
      else if FormDesigner_Net.dsg_Maximizada.Checked then
        TextoDFM.Lines[Y] := '  WindowState = wsMaximized'
      else if FormDesigner_Net.dsg_Minimizada.Checked then
        TextoDFM.Lines[Y] := '  WindowState = wsMinimized'
      else
        TextoDFM.Lines[Y] := '  WindowState = wsMaximized';
    end;}
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('Tabs.Strings', '', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
    begin
      Y := TextoDFM.CaretY;
      Achou := True;
      while Achou and (TextoDFM.CaretY <= TextoDFM.Lines.Count) do
      begin
        TextoDFM.CaretY := TextoDFM.CaretY + 1;
        if Copy(TextoDFM.LineText,01,11) = '          '+#39 then
        begin
          TextoDFM.Lines.Delete(TextoDFM.CaretY - 1);
          TextoDFM.CaretY := TextoDFM.CaretY - 1;
        end
        else
          Achou := False;
      end;
    end;
    for I := 0 to TabPaginas.Tabs.Count-1 do
    begin
      NomesPgs  := NomesPgs + TabPaginas.Tabs[I] + ';';
      if I = TabPaginas.Tabs.Count-1 then
        TextoDFM.Lines.Insert(Y,'          '+#39+TabPaginas.Tabs[I]+#39+')')
      else
        TextoDFM.Lines.Insert(Y,'          '+#39+TabPaginas.Tabs[I]+#39);
      Inc(Y);
    end;
    Y := TextoDFM.CaretY;
    Achou := False;
    while not Achou do
    begin
      TextoDFM.CaretY := TextoDFM.CaretY + 1;
      if TextoDFM.CaretYPix > TextoDFM.Lines.Count then
        Achou := True;
      if UpperCase(TrimRight(TextoDFM.LineText)) = '      END' then
      begin
        Achou := True;
        TextoDFM.Lines.Insert(TextoDFM.CaretY-1,'        OnClick = TabPaginasClick');
      end;
    end;
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := Y+1;
    TextoDFM.SearchReplace('Tabs.Strings', '', SearchOptionsPd);
    Y := TextoDFM.CaretY;
    Achou := False;
    while not Achou do
    begin
      TextoDFM.CaretY := TextoDFM.CaretY + 1;
      if TextoDFM.CaretYPix > TextoDFM.Lines.Count then
        Achou := True;
      if UpperCase(TrimRight(TextoDFM.LineText)) = '      END' then
      begin
        Achou := True;
        TextoDFM.Lines.Insert(TextoDFM.CaretY-1,'        OnClick = AbaConsultaClick');
      end;
    end;
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('object GridConsulta: TDBGrid', '', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
    begin
      Achou := False;
      while not Achou do
      begin
        TextoDFM.CaretY := TextoDFM.CaretY + 1;
        if TextoDFM.CaretYPix > TextoDFM.Lines.Count then
          Achou := True;
        if UpperCase(TrimRight(TextoDFM.LineText)) = '      END' then
        begin
          Achou := True;
          TextoDFM.Lines.Insert(TextoDFM.CaretY-1,'        OnDblClick = GridConsultaDblClick');
        end;
      end;
    end;
    FormDesigner_Net.CurrentEdit(Index).Lines.SaveToFile(PastaForm + NomeForm + '.PAS');
    TextoDfm.Lines.SaveToFile(PastaForm + NomeForm + '.DFM');
    FormDesigner_Net.CurrentEdit(Index).Modified := False;
    TextoDfm.Modified := False;
    Ok := True;
  finally
    TabPaginasClick(Self);
    FormObjInsp.CB1.ItemIndex := 0;
    FormAguarde.Free;
  end;
  if FileExists(PastaForm + 'Form'+NomeForm+'.Txt') then
    DeleteFile(PastaForm + 'Form'+NomeForm+'.Txt');
  SetFocus;
  if not Ok then
  begin
    Mensagem('Erro de Gravação do Formulário: '+NomeForm,modErro,[modOk]);
    if FileExists(Tmp_FilePas) then
      CopiaArquivo(Tmp_FilePas, FilePas);
    if FileExists(Tmp_FileDfm) then
      CopiaArquivo(Tmp_FileDfm, FileDfm);
    FormDesigner_Net.CurrentEdit(Index).Modified := False;
    TextoDfm.Modified := False;
    Close;
  end;
end;

procedure TFormEntradaDados.InserirCamposPagina(ListaSelecao: TStringList; P_Titulo, P_Distribuicao, X, Y: Integer);
Var
  I, Linha, Coluna, MaiorTitulo, OrdemTab: Integer;
  ListaOpcs: TStringList;
  TamanhoMaximo, Altura: Integer;
  UmaPagina: Boolean;
  ObjCampo: TObject;
  Ult_Linha, Ult_Coluna, Ult_Width, Ult_EdCampo, Ult_TpCampo, Th_Titulo: Integer;

  procedure AutoTela(X,Y: Integer);
  begin
    InserirCampo := True;
    if EdCampo = 1 then
    begin
      if TpCampo = 1 then
      begin
        CreateComponent(TXDBEdit,'TXDBEdit',X,Y,True,NomeCampo,'Edit', False);
        TXDBEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if TpCampo = 2 then
      begin
        CreateComponent(TXDBNumEdit,'TXDBNumEdit',X,Y,True,NomeCampo,'Edit', False);
        TXDBNumEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if TpCampo = 3 then
      begin
        CreateComponent(TXDBNumEdit,'TXDBNumEdit',X,Y,True,NomeCampo,'Edit', False);
        TXDBNumEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if TpCampo = 4 then
      begin
        CreateComponent(TXDBDateEdit,'TXDBDateEdit',X,Y,True,NomeCampo,'Edit', False);
        TXDBDateEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if TpCampo = 5 then
      begin
        CreateComponent(TDBMemo,'TDBMemo',X,Y,True,NomeCampo,'Memo', False);
        TDBMemo(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if TpCampo = 6 then
      begin
        CreateComponent(TDBImage,'TDBImage',X,Y,True,NomeCampo,'Imagem', False);
        TDBImage(ObjetoAtual).TabOrder := OrdemTab;
      end;
    end
    else if EdCampo = 2 then
    begin
      CreateComponent(TDBComboBox,'TDBComboBox',X,Y,True,NomeCampo,'ComboBox', False);
      TDBComboBox(ObjetoAtual).TabOrder := OrdemTab;
    end
    else if EdCampo = 3 then
    begin
      CreateComponent(TDBRadioGroup,'TDBRadioGroup',X,Y,True,NomeCampo,'RadioGroup', False);
      TDBRadioGroup(ObjetoAtual).TabOrder := OrdemTab;
    end
    else if EdCampo = 4 then
    begin
      CreateComponent(TDBCheckBox,'TDBCheckBox',X,Y,True,NomeCampo,'CheckBox', False);
      TDBCheckBox(ObjetoAtual).TabOrder := OrdemTab;
    end
    else if EdCampo = 5 then
    begin
      if EdEstilo = 0 then
      begin
        CreateComponent(TXDBLookUp,'TXDBLookUp',X,Y,True,NomeCampo,'LookUp', False);
        TXDBLookUp(ObjetoAtual).TabOrder := OrdemTab;
      end
      else
      begin
        if TpCampo = 1 then
        begin
          CreateComponent(TXDBEdit,'TXDBEdit',X,Y,True,NomeCampo,'Edit', False);
          TXDBEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if TpCampo = 2 then
        begin
          CreateComponent(TXDBNumEdit,'TXDBNumEdit',X,Y,True,NomeCampo,'Edit', False);
          TXDBNumEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if TpCampo = 3 then
        begin
          CreateComponent(TXDBNumEdit,'TXDBNumEdit',X,Y,True,NomeCampo,'Edit', False);
          TXDBNumEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if TpCampo = 4 then
        begin
          CreateComponent(TXDBDateEdit,'TXDBDateEdit',X,Y,True,NomeCampo,'Edit', False);
          TXDBDateEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if TpCampo = 5 then
        begin
          CreateComponent(TDBMemo,'TDBMemo',X,Y,True,NomeCampo,'Memo', False);
          TDBMemo(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if TpCampo = 6 then
        begin
          CreateComponent(TDBImage,'TDBImage',X,Y,True,NomeCampo,'Imagem', False);
          TDBImage(ObjetoAtual).TabOrder := OrdemTab;
        end;
      end;
    end;
  end;

begin
  DsnRegister.Designing := False;
  if AutoFormatacao then
  begin
    TabPaginas.Tabs.Clear;
    TabPaginas.Tabs.Add('Principal');
    TabPaginas.TabIndex := 0;
    AutoFormatacao := False;
  end;

  if P_Titulo > 0 then
    MaiorTitulo := 6
  else
  begin
    MaiorTitulo := 0;
    for I:=0 to ListaSelecao.Count-1 do
    begin
      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela + 'AND NOME = '+#39+ListaSelecao[I]+#39;
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabGlobal_i.DCAMPOST.First;
      if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EDICAO.Conteudo < 3) then
      begin
        EdTitulo  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
        if Length(EdTitulo) > MaiorTitulo then MaiorTitulo := Length(EdTitulo);
      end;
    end;
    MaiorTitulo := (MaiorTitulo * 6);
  end;

  Linha  := Y; //12;
  Coluna := X; //1;
  OrdemTab := 0;
  UmaPagina := False;
  Ult_Linha := 0;
  Ult_Coluna := 0;
  Ult_Width := 0;
  Ult_EdCampo := 0;
  Ult_TpCampo := 0;
  for I:=0 to ListaSelecao.Count-1 do
  begin
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela + 'AND NOME = '+#39+ListaSelecao[I]+#39;
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    if not (TabGlobal_i.DCAMPOST.Eof) and (not UmaPagina) then
    begin
      NomeCampo := TabGlobal_i.DCAMPOST.NOME.Conteudo;
      TpCampo   := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
      EdCampo   := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
      EdEstilo  := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
      EdTitulo  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
      EdLista   := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo;
      EdTamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
      if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
        EdChave := True
      else
        EdChave := False;
      EDBLook   := False;
      Busca_ChaveEst := False;
      Altura    := 21;
      if EdCampo = 3 then
      begin
        ListaOpcs := TStringList.Create;
        StringToArray(EdLista,';',ListaOpcs);
        Altura := Altura * ListaOpcs.Count-1;
        ListaOpcs.Free;
      end;
      if TpCampo = 5 then
        Altura := 89
      else if TpCampo = 6 then
        Altura := 105;
      if (P_Titulo > 0) and (P_Titulo < 4) then
        Inc(Altura, 14);
      TamanhoMaximo := DsnStage0.Height;
      if Linha + Altura >= TamanhoMaximo then
      begin
        if TabPaginas.Tabs.Count + 1 > 11 then
        begin
          Mensagem('Limite Máximo de Páginas: 11',ModAdvertencia,[ModOk]);
          Break;
        end;
        TabPaginas.Tabs.Add('Complemento');
        TabPaginas.TabIndex := TabPaginas.TabIndex + 1;
        Linha  := 12;
        Coluna := 1;
        OrdemTab := 0;
        Ult_Linha := 0;
        Ult_Coluna := 0;
        Ult_Width := 0;
        Ult_EdCampo := 0;
        Ult_TpCampo := 0;
      end;
      if not UmaPagina then
      begin
        if (I=0) and (Coluna <> 1) then
          Coluna := X
        else
          Coluna := (MaiorTitulo + 04);
        if (P_Titulo > 0) and (P_Titulo < 4) and ((EdCampo <> 3) and (EdCampo <> 4)) then
          Inc(Linha,14);
        AutoTela(Coluna, Linha);
        ObjCampo := ObjetoAtual;
        if (I=0) and (X <> 1) then
        begin
          if P_Titulo = 0 then
            Coluna := Coluna - MaiorTitulo - 04
          else
          begin
            Coluna := TControl(ObjCampo).Left;
            MaiorTitulo := Coluna - 04;
          end;
        end
        else
          Coluna := 1;
        if (EdCampo <> 3) and
           (EdCampo <> 4) and
           (P_Titulo < 4) then
        begin
          if (P_Titulo > 0) and (P_Titulo < 4) then
            Dec(Linha,14);
          if P_Titulo = 0 then
            CreateComponent(TLabel,'TLabel',Coluna, Linha + 4,True,'Lbc'+NomeCampo,'Label', False)
          else
            CreateComponent(TLabel,'TLabel',(MaiorTitulo + 04), Linha,True,'Lbc'+NomeCampo,'Label', False);
          TLabel(ObjetoAtual).Caption   := Trim(EdTitulo);
          if P_Titulo = 0 then
            TLabel(ObjetoAtual).Alignment := taRightJustify
          else if P_Titulo = 1 then
            TLabel(ObjetoAtual).Alignment := taLeftJustify
          else if P_Titulo = 2 then
            TLabel(ObjetoAtual).Alignment := taRightJustify
          else if P_Titulo = 3 then
            TLabel(ObjetoAtual).Alignment := taCenter;
          if P_Titulo = 0 then
            TLabel(ObjetoAtual).Width := MaiorTitulo
          else
            TLabel(ObjetoAtual).Width := TControl(ObjCampo).Width;
          if P_Titulo < 2 then
          begin
            TLabel(ObjetoAtual).AutoSize := False;
            TLabel(ObjetoAtual).AutoSize := True;
          end;
          if (P_Titulo > 0) and (P_Titulo < 4) then
            Inc(Linha,14);
        end;
        if (P_Distribuicao = 1) and (Ult_Linha > 0) and (Ult_EdCampo < 3) and (Ult_TpCampo < 5) then
        begin
          if (EdCampo <> 3) and
             (EdCampo <> 4) and
             (TpCampo < 5) and
             (P_Titulo < 4) then
          begin
            Th_Titulo := 0;
            if P_Titulo = 0 then
              Th_Titulo := TControl(ObjetoAtual).Width;
            if (Ult_Width + TControl(ObjCampo).Width + Th_Titulo) <= DsnStage0.Width then
            begin
               Linha := Ult_Linha;
               Coluna := Ult_Width;
               if (P_Titulo > 0) and (P_Titulo < 4) then
                 Dec(Linha,14);
               if P_Titulo = 0 then
               begin
                 TControl(ObjetoAtual).Top := Linha + 4;
                 TControl(ObjetoAtual).Left := Coluna;
                 Coluna := Coluna + TControl(ObjetoAtual).Width + 4;
               end
               else
               begin
                 TControl(ObjetoAtual).Top := Linha;
                 TControl(ObjetoAtual).Left := Coluna;
               end;
               if (P_Titulo > 0) and (P_Titulo < 4) then
                 Inc(Linha,14);
               TControl(ObjCampo).Top := Linha;
               TControl(ObjCampo).Left := Coluna;
            end;
          end;
        end;
        Ult_Linha := TControl(ObjCampo).Top;
        Ult_Coluna := TControl(ObjCampo).Left;
        Ult_Width := TControl(ObjCampo).Left + TControl(ObjCampo).Width + 4;
        Ult_EdCampo := EdCampo;
        Ult_TpCampo := TpCampo;
        Linha := Linha + TControl(ObjCampo).Height + 4;
        Inc(OrdemTab);
      end;
    end;
  end;
  TabPaginasClick(Self);
end;

procedure TFormEntradaDados.AutoFormatar;
Var
  I: Integer;
  ListaSelecao: TStringList;
  P_Titulo, P_Distribuicao: Integer;
  Ok: Boolean;
begin
  AutoFormatacao := False;
  Ok := (DsnStage0.ControlCount = 0) and (DsnStage6.ControlCount = 0) and
        (DsnStage1.ControlCount = 0) and (DsnStage7.ControlCount = 0) and
        (DsnStage2.ControlCount = 0) and (DsnStage8.ControlCount = 0) and
        (DsnStage3.ControlCount = 0) and (DsnStage9.ControlCount = 0) and
        (DsnStage4.ControlCount = 0) and (DsnStage10.ControlCount = 0) and
        (DsnStage5.ControlCount = 0);
  if not Ok then
  begin
    Mensagem('Página(s) não vazia(s) !',ModInformacao,[modOk]);
    exit;
  end;
  Ok := False;
  ListaSelecao := TStringList.Create;
  FormAutoForma := TFormAutoForma.Create(Application);
  try
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela;
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          FormAutoForma.FieldsLB.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(0))
        else
          FormAutoForma.FieldsLB.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(1));
      TabGlobal_i.DCAMPOST.Next;
    end;
    if FormAutoForma.FieldsLB.Items.Count > 0 then
    begin
      for I:=0 to FormAutoForma.FieldsLB.Items.Count-1 do
        FormAutoForma.FieldsLB.Selected[I] := True;
      FormAutoForma.FieldsLB.ItemIndex := 0;
    end;
    if FormAutoForma.ShowModal = mrOk then
    begin
      AutoFormatacao := True;
      Ok := True;
      P_Titulo := FormAutoForma.Titulo.ItemIndex;
      P_Distribuicao := FormAutoForma.Distribuicao.ItemIndex;
      ListaSelecao.Clear;
      for I:=0 to FormAutoForma.FieldsLB.Items.Count-1 do
        if FormAutoForma.FieldsLB.Selected[I] then
          ListaSelecao.Add(FormAutoForma.FieldsLB.Items[I]);
    end;
  finally
    FormAutoForma.Free;
  end;
  if (Ok) and (ListaSelecao.Count > 0) then
    InserirCamposPagina(ListaSelecao, P_Titulo, P_Distribuicao, 1, 12);
  ListaSelecao.Free;
end;

procedure TFormEntradaDados.AutoIncremento;
var
  NrSel,I,Y: Integer;
  Titulo,Titulo2: String;
  ListaSeq: TStringList;
  Ok, Achou, Editavel: Boolean;
  Pesquisa: String;
begin
  ListaSeq  :=TStringList.Create;
  FormListaEscolha := TFormListaEscolha.Create(Application);
  Try
    FormListaEscolha.Extra.Visible := True;
    FormListaEscolha.Extra.Caption := 'Sequêncial Editável';
    FormListaEscolha.ListaSelecao.Items.Clear;
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela+' AND (TIPO = 2 OR TIPO = 3 OR TIPO = 4)';
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
      begin
        Titulo := TabGlobal_i.DCAMPOST.NOME.Conteudo;
        Titulo2:= TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[Titulo])+Titulo2);
        ListaSeq.Add(IntToStr(TabGlobal_i.DCAMPOST.Sequencia.Conteudo));
      end;
      TabGlobal_i.DCAMPOST.Next;
    end;
    FormListaEscolha.ShowModal;
  Finally
    NrSel      := FormListaEscolha.NumeroSelecao;
    Editavel   := FormListaEscolha.Extra.Checked;
    FormListaEscolha.Free;
  end;
  if NrSel <> -1 then
  begin
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela+ ' AND SEQUENCIA = '+ListaSeq[NrSel];
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    Ok := False;
    for I:=0 to FormObjInsp.CB1.Items.Count-1 do
      if UpperCase(Copy(FormObjInsp.CB1.Items[I],1,Pos(':',FormObjInsp.CB1.Items[I])-1)) = UpperCase(TabGlobal_i.DCAMPOST.NOME.Conteudo) then
        Ok := True;
    if Ok then
    begin
      //if FormPaleta2 <> Nil then
      begin
        //FormPaleta2.PageEditor.ActivePage.PageIndex := 0;
        with FormDesigner_Net.CurrentEdit do
        begin
          CaretX := 1;
          CaretY := 1;
          SearchReplace('.AtribuiValoresPadrao;', '', SearchOptionsPd );
          if CaretY > 1 then
          begin
            Achou  := False;
            while (not Achou) and (CaretY <= Lines.Count-1) do
            begin
              if TrimRight(UpperCase(Lines[CaretY])) = 'END;' then
              begin
                Achou := True;
                Y := CaretY - 1;
                if Editavel then
                  FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'  AtribuiAutoIncremento(TabelaPrincipal, '+#39+UpperCase(TabGlobal_i.DCAMPOST.NOME.Conteudo)+#39+', '+UpperCase(TabGlobal_i.DCAMPOST.NOME.Conteudo)+', '+#39+#39+', True);')
                else
                  FormDesigner_Net.CurrentEdit.Lines.Insert(Y+01,'  AtribuiAutoIncremento(TabelaPrincipal, '+#39+UpperCase(TabGlobal_i.DCAMPOST.NOME.Conteudo)+#39+', '+UpperCase(TabGlobal_i.DCAMPOST.NOME.Conteudo)+', '+#39+#39+', False);');
              end
              else
                CaretY := CaretY + 1;
            end;
          end;
          CaretX := 1;
          CaretY := 1;
        end;
      end;
      Pesquisa := 'TForm' + NomeForm + '.';
      Pesquisa := Pesquisa + 'AtribuiValoresPadrao';
      AbrirEditor(PastaForm + NomeForm + '.PAS',Pesquisa,False);
    end
    else
      Mensagem('Campo não inserido no formulário !',ModAdvertencia,[ModOk]);
  end;
  ListaSeq.Free;
end;

procedure TFormEntradaDados.InserirCamposDB;
var
  I: Integer;
  ListaSelecao: TStringList;
  Ok: Boolean;
  P_Titulo, P_Distribuicao: Integer;
begin
  Ok := False;
  ListaSelecao := TStringList.Create;
  FormAutoForma := TFormAutoForma.Create(Application);
  try
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela;
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      Ok := True;
      for I:=0 to FormObjInsp.CB1.Items.Count-1 do
        if UpperCase(Copy(FormObjInsp.CB1.Items[I],1,Pos(':',FormObjInsp.CB1.Items[I])-1)) = UpperCase(Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)) then
          Ok := False;
      if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
         (Ok) then
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          FormAutoForma.FieldsLB.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(0))
        else
          FormAutoForma.FieldsLB.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(1));
      TabGlobal_i.DCAMPOST.Next;
    end;
    Ok := False;
    if FormAutoForma.FieldsLB.Items.Count > 0 then
    begin
      for I:=0 to FormAutoForma.FieldsLB.Items.Count-1 do
        FormAutoForma.FieldsLB.Selected[I] := True;
      FormAutoForma.FieldsLB.ItemIndex := 0;
    end;
    FormAutoForma.Caption := 'Inserir campos da tabela';
    if FormAutoForma.ShowModal = mrOk then
    begin
      AutoFormatacao := False;
      Ok := True;
      P_Titulo := FormAutoForma.Titulo.ItemIndex;
      P_Distribuicao := FormAutoForma.Distribuicao.ItemIndex;
      ListaSelecao.Clear;
      for I:=0 to FormAutoForma.FieldsLB.Items.Count-1 do
        if FormAutoForma.FieldsLB.Selected[I] then
          ListaSelecao.Add(FormAutoForma.FieldsLB.Items[I]);
    end;
  finally
    FormAutoForma.Free;
  end;
  if (Ok) and (ListaSelecao.Count > 0) then
  begin
    ListaSelecaoCampos.Clear;
    ListaSelecaoCampos.AddStrings(ListaSelecao);
    P_Titulo_DB := P_Titulo;
    P_Distribuicao_DB := P_Distribuicao;
    InserirCampo := True;
    DsnRegister.Designing:= False;
  end;
  ListaSelecao.Free;
end;

procedure TFormEntradaDados.Dsg_NovaPaginaClick(Sender: TObject);
begin
  CompPageControl := TWinControl(ObjetoAtual);
  PageControl_NovaPagina;
end;

procedure TFormEntradaDados.FormActivate(Sender: TObject);
begin
  FormPrincipal.Recortar.Enabled          := True;
  FormPrincipal.Colar.Enabled             := True;
  FormPrincipal.Copiar.Enabled            := True;
  FormPrincipal.SelecionarTudo.Enabled    := True;

  FormPrincipal.Recortar.OnClick          := Dsg_Recortar1Click;
  FormPrincipal.Colar.OnClick             := Dsg_Colar1Click;
  FormPrincipal.Copiar.OnClick            := Dsg_Copiar1Click;
  FormPrincipal.SelecionarTudo.OnClick    := Dsg_SelecionarTodos1Click;
  FormPrincipal.EnviarParaFrente.OnClick  := Dsg_EnviarparafrenteClick;
  FormPrincipal.EnviarParaTras.OnClick    := Dsg_EnviarparatrasClick;
  FormPrincipal.TabOrder.OnClick          := Dsg_SequnciaTabOrder1Click;

  FormPrincipal.Alinhamento.OnClick  := Dsg_Alinhamento_objClick;
  FormPrincipal.Tamanho.OnClick      := Dsg_Dimensoes_objClick;
end;

procedure TFormEntradaDados.EditarPaginas;
begin
  FormPaginas := TFormPaginas.Create(Application);
  try
    FormPaginas.ListPg.Items.Clear;
    FormPaginas.ListPg.Items.AddStrings(TabPaginas.Tabs);
    FormPaginas.ListPg.ItemIndex := 0;
    FormPaginas.ListPgClick(Self);
    if FormPaginas.ShowModal = mrOk then
    begin
      TextoDfm.Modified := True;
      TabPaginas.Tabs.Clear;
      TabPaginas.Tabs.AddStrings(FormPaginas.ListPg.Items);
      TabPaginas.TabIndex := 0;
      TabPaginasClick(Self);
    end;
  finally
    FormPaginas.Free;
  end;
end;

procedure TFormEntradaDados.Tabs_NvPgClick(Sender: TObject);
var
  NewString: String;
begin
  if TabPaginas.Tabs.Count = 11 then
  begin
    Mensagem('Limite Máximo de Páginas: 11',ModAdvertencia,[ModOk]);
    exit;
  end;
  NewString := 'Complemento';
  if InputQuery('Nova Página: "'+NewString+'"', 'Informe o nome da página ...', NewString) then
  begin
    TabPaginas.Tabs.Add(NewString);
    TabPaginas.TabIndex := TabPaginas.TabIndex + 1;
    TabPaginasClick(Self);
  end;
end;

procedure TFormEntradaDados.Tabs_RnPgClick(Sender: TObject);
var
  NewString: String;
  P: Integer;
begin
  P := TabPaginas.TabIndex;
  if P < 0 then exit;
  NewString := TabPaginas.Tabs[P];
  if InputQuery('Página: "'+NewString+'"', 'Informe o nome da página ...', NewString) then
  begin
    TabPaginas.Tabs[P] := NewString;
    TabPaginasClick(Self);
  end;
end;

procedure TFormEntradaDados.Tabs_ExPgClick(Sender: TObject);
var
  P: Integer;
begin
  P := TabPaginas.TabIndex;
  if (P < 1) or (P < TabPaginas.Tabs.Count-1) then
  begin
    Mensagem('A Página "'+TabPaginas.Tabs[P]+'" não pode ser excluida !',ModAdvertencia,[ModOK]);
    exit;
  end;
  if DsnRegister.DsnStage.ControlCount > 0 then
  begin
    Mensagem('A Página "'+TabPaginas.Tabs[P]+'" não está vazia !',ModAdvertencia,[ModOK]);
    exit;
  end;
  if Mensagem('Excluir a Página "'+TabPaginas.Tabs[P]+'" ?' ,ModConfirmacao,[ModSim, ModNao]) = mrno then
    exit;
  TabPaginas.Tabs.Delete(P);
  TabPaginasClick(Self);
end;

procedure TFormEntradaDados.Dsg_Alinhamento_objClick(Sender: TObject);
begin
  FormPrincipal.AlinhamentoClick(Self);
end;

procedure TFormEntradaDados.Dsg_Dimensoes_objClick(Sender: TObject);
begin
  FormPrincipal.TamanhoClick(Self);
end;

procedure TFormEntradaDados.Define_TabOrder;
var
  I, Y, PropItems: Integer;
  Component: TComponent;
  Count:Integer;
  PropList:PPropList;
  PropInfo: PPropInfo;
  Ok: Boolean;
  Conteudo: String;
begin
  FormTabOrdem := TFormTabOrdem.Create(Application);
  try
    FormTabOrdem.TabList.Clear;
    for I:=0 to DsnRegister.DsnStage.ControlCount-1 do
    begin
      Ok := False;
      Component := DsnRegister.DsnStage.Controls[I];
      PropItems:=GetPropList(Component.ClassInfo,tkProperties,nil);
      GetMem(PropList,PropItems * SizeOf(PPropInfo));
      try
        GetPropList(Component.ClassInfo,tkProperties,PropList);
        for Y:=0 to PropItems-1 do
        begin
          PropInfo:=GetPropInfo(Component.ClassInfo,PropList^[Y]^.Name);
          if Trim(UpperCase(PropList^[Y]^.Name)) = 'TABORDER' then
          begin
            Conteudo := FormObjInsp.GetPropAsString(Component,PropList[Y],False);
            Ok := True;
            Break;
          end;
        end;
      finally
        FreeMem(PropList,PropItems * SizeOf(PPropInfo));
      end;
      if Ok then
        FormTabOrdem.TabList.Items.Add(StrZero(StrToIntDef(Conteudo,0),4) + ' - ' +Component.Name);
    end;
    if FormTabOrdem.TabList.Items.Count > 0 then
      FormTabOrdem.TabList.ItemIndex := 0;
    if FormTabOrdem.ShowModal = mrOk then
    begin
      TextoDFM.Modified := True;
      for I:=0 to DsnRegister.DsnStage.ControlCount-1 do
      begin
        Component := DsnRegister.DsnStage.Controls[I];
        Ok := False;
        for Y:=0 to FormTabOrdem.TabList.Items.Count-1 do
          if Trim(Copy(FormTabOrdem.TabList.Items[Y],Pos('-',FormTabOrdem.TabList.Items[Y])+2,Length(FormTabOrdem.TabList.Items[Y]))) = Component.Name then
          begin
            Ok := True;
            Break;
          end;
        if Ok then
          SetOrdProp(Component,'TabOrder',Y);
      end;
    end;
  Finally
    FormTabOrdem.Free;
  end;
end;

procedure TFormEntradaDados.Dsg_SequnciaTabOrder1Click(Sender: TObject);
begin
  FormPrincipal.TabOrderClick(Self);
end;

procedure TFormEntradaDados.Cria_Grid_Relacionamento;
var
  NomeGrid: String;
begin
  FormGridRelac := TFormGridRelac.Create(Application);
  Try
    FormGridRelac.FieldsLB_1.Clear;
    TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+NrTabela+' AND TIPO = 3';
    TabGlobal_i.DRELACIONA.AtualizaSql;
    while not TabGlobal_i.DRELACIONA.eof do
    begin
      FormGridRelac.FieldsLB_1.Items.AddObject(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo + ' - ' + TabGlobal_i.DRELACIONA.TITULO_I.Conteudo,TObject(TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo));
      TabGlobal_i.DRELACIONA.Next;
    end;
    if FormGridRelac.ShowModal = mrOk then
      if FormGridRelac.FieldsLB_1.ItemIndex > -1 then
      begin
        EdGridEditavel := FormGridRelac.EdEdicao.Checked;
        EdFormRel := '';
        if Trim(FormGridRelac.EdFormulario.Text) <> '' then
          EdFormRel      := UpperCase(Trim(Copy(FormGridRelac.Edformulario.Text,01,Pos('-',FormGridRelac.EdFormulario.Text)-1)));
        EdNomeTabRel   := Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
        NomeGrid       := 'Grid_' + Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
        EdCampo        := 9;
        EDBLook        := False;
        DsnRegister.Designing:= False;
        CreateComponent(TDBGrid,'TDBGrid',10,10,True,NomeGrid,'Grid', True);
      end;
  Finally
    FormGridRelac.Free;
  end;
end;

procedure TFormEntradaDados.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

  procedure MoverPorSetas(Key: Word; Valor: Integer);
  var
    i, xLeft, xTop: Integer;
    CanMove: Boolean;
  begin
    for i:= 0 to DsnRegister.DsnStage.TargetsCount -1 do
    begin
      xLeft := TControl(DsnRegister.DsnStage.Targets[i]).Left;
      xTop  := TControl(DsnRegister.DsnStage.Targets[i]).Top;
      if Key = 37 then
        xLeft := xLeft-Valor
      else if Key = 38 then
        xtop  := xTop-Valor
      else if Key = 39 then
        xLeft := xLeft+Valor
      else if Key = 40 then
        xtop  := xTop+Valor;
      TControl(DsnRegister.DsnStage.Targets[i]).Left := xLeft;
      TControl(DsnRegister.DsnStage.Targets[i]).Top  := xTop;
      if i = DsnRegister.DsnStage.TargetsCount -1 then
      begin
        CanMove := True;
        DsnStage0MoveQuery(Self,DsnRegister.DsnStage.Targets[i],CanMove);
      end;
      DsnRegister.DsnStage.UpdateControl;
    end;
  end;

  procedure TamanhoPorSetas(Key: Word);
  var
    i, xHeight, xWidth: Integer;
    CanMove: Boolean;
  begin
    for i:= 0 to DsnRegister.DsnStage.TargetsCount -1 do
    begin
      xHeight := TControl(DsnRegister.DsnStage.Targets[i]).Height;
      xWidth  := TControl(DsnRegister.DsnStage.Targets[i]).Width;
      if Key = 37 then
        xWidth := xWidth-1
      else if Key = 38 then
        xHeight := xHeight-1
      else if Key = 39 then
        xWidth := xWidth+1
      else if Key = 40 then
        xHeight := xHeight+1;
      TControl(DsnRegister.DsnStage.Targets[i]).Height := xHeight;
      TControl(DsnRegister.DsnStage.Targets[i]).Width  := xWidth;
      if i = DsnRegister.DsnStage.TargetsCount -1 then
      begin
        CanMove := True;
        DsnStage0MoveQuery(Self,DsnRegister.DsnStage.Targets[i],CanMove);
      end;
      DsnRegister.DsnStage.UpdateControl;
    end;
  end;

begin
  if Key = VK_DELETE then
    DsnRegister.DsnStage.Delete
  else if Shift = ([ssShift,ssCtrl]) then
  begin
    if (Key >= 37) and (Key <= 40) then
      MoverPorSetas(Key,8);
  end
  else if Shift = ([ssCtrl]) then
  begin
    if (Key >= 37) and (Key <= 40) then
      MoverPorSetas(Key,1);
  end
  else if Shift = ([ssShift]) then
  begin
    if (Key >= 37) and (Key <= 40) then
      TamanhoPorSetas(Key);
  end;
end;

end.
