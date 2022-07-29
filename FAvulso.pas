unit FAvulso;

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
  TFormAvulso = class(TForm)
    TextoTXT: TSynEdit;
    TextoDFM: TSynEdit;
    DsnStage0: TDsnStage;
    DsnRegister: TDsn8Register;
    DsnSelect: TDsnSelect;
    PopDesigner: TPopupMenu;
    Dsg_NovaPagina: TMenuItem;
    Divisao_NvPg: TMenuItem;
    Dsg_Enviarparafrente: TMenuItem;
    Dsg_Enviarparatras: TMenuItem;
    Dsg_N3: TMenuItem;
    Dsg_Alinhamento_obj: TMenuItem;
    Dsg_Dimensoes_obj: TMenuItem;
    Dsg_SequnciaTabOrder1: TMenuItem;
    Dsg_N1: TMenuItem;
    Dsg_Recortar1: TMenuItem;
    Dsg_Copiar1: TMenuItem;
    Dsg_Colar1: TMenuItem;
    Dsg_SelecionarTodos1: TMenuItem;
    Dsg_N2: TMenuItem;
    Dsg_Excluir1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DsnSelectChangeSelected(Sender: TObject;
      Targets: TSelectedComponents; Operation: TSelectOperation);
    procedure DsnStage0ControlCreate(Sender: TObject;
      Component: TComponent);
    procedure DsnStage0DeleteQuery(Sender: TObject; Component: TComponent;
      var CanDelete: Boolean);
    procedure DsnStage0MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DsnStage0MoveQuery(Sender: TObject; Component: TComponent;
      var CanMove: Boolean);
    procedure DsnStage0SelectQuery(Sender: TObject; Component: TComponent;
      var CanSelect: TSelectAccept);
    procedure Dsg_NovaPaginaClick(Sender: TObject);
    procedure Dsg_EnviarparafrenteClick(Sender: TObject);
    procedure Dsg_EnviarparatrasClick(Sender: TObject);
    procedure Dsg_Alinhamento_objClick(Sender: TObject);
    procedure Dsg_Dimensoes_objClick(Sender: TObject);
    procedure Dsg_SequnciaTabOrder1Click(Sender: TObject);
    procedure Dsg_Recortar1Click(Sender: TObject);
    procedure Dsg_Copiar1Click(Sender: TObject);
    procedure Dsg_Colar1Click(Sender: TObject);
    procedure Dsg_SelecionarTodos1Click(Sender: TObject);
    procedure Dsg_Excluir1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Erro_Formulario: Boolean;
    CompPageControl: TWinControl;
    function Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure AtribuiUses(Arquivo: String);
    procedure ExcluiObjeto(Nome: String; Eventos: Boolean);
    procedure PageControl_NovaPagina;
    function CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
                             GravaFRM: Boolean; Campo: String; TipoCampo: String; AtInspector: Boolean):TComponent;
    function UniqueName(comp:TComponent; Tipo:String):string;
  public
    { Public declarations }
    InserirCampo: Boolean;
    CompBotao: Boolean;
    ExcluiComp: Boolean;
    ObjetoAtual: TObject;
    VamosGravar: Boolean;
    PastaForm: String;
    NomeForm: String;
    NomeTab: String;
    NrTabela: String;
    ListaEventos, ListaInvisivel, ListaDesabilitado: TStringList;
    Thread_ok: Boolean;
    ListaSelecionados: TList;
    ListaSelecaoCampos: TStringList;
    SearchOptionsPd: TSynSearchOptions;
    EdFormRel, EdNomeTabRel: String;
    ExcluiTodos, ExcluiTodosEv: Boolean;
    Lista_CB1: TStringList;
    procedure AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
    procedure SalvarFormulario(Index: Integer = -1);
    procedure AtualizaLista_CB;
    procedure Define_TabOrder;
    procedure InserirCamposDB;
  end;

var
  FormAvulso: TFormAvulso;

implementation

uses Aguarde, Princ, Rotinas, FDesigner, Editor, ObjInsp, TabOrdem, ThObjectInsp,
  Abertura, Alinhamento, Tamanho, Gera_01, OpFormatacao;

{$R *.DFM}

procedure TFormAvulso.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := (Style OR WS_CHILD) AND (NOT WS_POPUP);
    WndParent := FormDesigner_Net.HostScroll.Handle;
  end;
  Parent := FormDesigner_Net.HostScroll;
end;

procedure TFormAvulso.FormCreate(Sender: TObject);
var
  hMenuHandle : HMENU;
begin
  Left   := 5;
  Top    := 5;
  Height := 10;
  Width  := 10;
  hMenuHandle := GetSystemMenu(Self.Handle, FALSE); //Get the handle of the Form
  if (hMenuHandle <> 0) then
  begin
    DeleteMenu(hMenuHandle, SC_MOVE, MF_BYCOMMAND); //disable moving
    //DeleteMenu(hMenuHandle, SC_SIZE, MF_BYCOMMAND); //disable resizing
    DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND); //disable Close
  end;
end;

procedure TFormAvulso.FormShow(Sender: TObject);
var
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

  procedure Inicializa;
  begin
    if Trim(PastaForm) = '' then
      PastaForm := Projeto.Pasta;
    Thread_ok := True;

    FormPrincipal.Paleta.ActivePageIndex := 0;

    DsnRegister.Designing   := False;
    //DsnRegister.DsnPanel    := FormPrincipal.DsnPanel_Padrao;
    //DsnRegister.ArrowButton := FormPrincipal.ArrowButton1;
    DsnRegister.Designing   := True;

    MsgSalvar          := False;
    Erro_Formulario    := False;
    //ExcluiTodos        := False;
    //ExcluiTodosEv      := False;
    ExcluiComp         := False;
    //Form_Habilitado    := False;
    ListaEventos       := TStringList.Create;
    ListaTabOrder      := TStringList.Create;
    ListaInvisivel     := TStringList.Create;
    ListaDesabilitado  := TStringList.Create;
    ListaSelecaoCampos := TStringList.Create;
    ListaSelecionados  := TList.Create;
    Lista_CB1          := TStringList.Create;
    VamosGravar        := False;

    //InserirCampo := False;
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
  Registra_Classes;

  Inicializa;

  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Abrindo formulário ...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := 0;
  try
    FormPrincipal.Texto.Lines.Clear;
    InicioBloco := False;
    FinalBloco  := False;
    for Y:=0 to TextoDFM.Lines.Count-1 do
    begin
      FormAguarde.GaugeProcesso.Position := Y;
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
        linha := TextoDFM.Lines[Y];
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
        if Copy(UpperCase(Linha),01,09) = '  OBJECT ' then
        begin
          InicioBloco := True;
          FinalBloco := False;
        end;
        if InicioBloco then
          FormPrincipal.Texto.Lines.Add(Copy(Linha,03,Length(Linha)));
        if Copy(UpperCase(Linha),01,05) = '  END' then
        begin
          FormPrincipal.Texto.Lines.SaveToFile(PastaForm + NomeForm + 'Tela1.Txt');
          try
            FS2 := TFileStream.Create(PastaForm + NomeForm + 'Tela1.Tmp', fmCreate);
            FinalBloco := False;
            FormPrincipal.Texto.Lines.Clear;
            while not FinalBloco do
            begin
              FS := TFileStream.Create(PastaForm + NomeForm + 'Tela1.Txt', fmOpenRead);
              ObjectTextToBinary(FS, FS2);
              FS.Free;

              FormPrincipal.Texto.Lines.LoadFromFile(PastaForm + NomeForm + 'Tela1.Txt');
              InicioBloco := False;
              FormPrincipal.Texto.Lines.Delete(0);
              while not InicioBloco do
              begin
              if (UpperCase(Copy(FormPrincipal.Texto.Lines[0],01,07)) = 'OBJECT ') or (FormPrincipal.Texto.Lines.Count = 0) then
                InicioBloco := True
              else
                FormPrincipal.Texto.Lines.Delete(0);
              end;
              FormPrincipal.Texto.Lines.SaveToFile(PastaForm + NomeForm + 'Tela1.Txt');
              if FormPrincipal.Texto.Lines.Count < 3 then
                FinalBloco := True;
              FormPrincipal.Texto.Lines.Clear;
            end;
          finally
            FinalFluxo := vaNull;
            FS2.Write(FinalFluxo, SizeOf(FinalFluxo));
            FS2.Free;
          end;
          DsnStage0.LoadFromFile(PastaForm + NomeForm + 'Tela1.Tmp', True);
          InicioBloco := False;
          FinalBloco := True;
        end;
      end;
    end;
    for T:=0 to 1 do
      for I:=0 to DsnStage0.ControlCount -1 do
      begin
        //FormDesigner_Net.Adiciona_CB1(DsnStage0.Controls[I].Name + ': ' +DsnStage0.Controls[I].ClassName);
        Component := DsnStage0.Controls[I];
        Y := ListaTabOrder.IndexOf(Component.Name);
        if Y > -1 then
          SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
      end;
    FormPrincipal.Texto.Lines.Clear;
    DsnRegister.Designing:= True;
    Ok := True;
  Finally
    FormAguarde.Free;
  end;
  TextoDFM.CaretY := 0;
  TextoDFM.CaretX := 0;
  TextoDFM.SearchReplace('  CLIENTHEIGHT =','', SearchOptionsPd);
  if TextoDFM.CaretY > 1 then
  begin
    ClientHeight := StrToIntDef(Trim(Copy(TextoDFM.LineText,17,50)),413);
    //Height := ClientHeight;
  end
  else
  begin
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('  HEIGHT =','', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
      Height := StrToIntDef(Trim(Copy(TextoDFM.LineText,11,50)),413);
  end;
  TextoDFM.CaretY := 0;
  TextoDFM.CaretX := 0;
  TextoDFM.SearchReplace('  CLIENTWIDTH =','', SearchOptionsPd);
  if TextoDFM.CaretY > 1 then
  begin
    ClientWidth := StrToIntDef(Trim(Copy(TextoDFM.LineText,16,50)),413);
    //Width := ClientWidth;
  end
  else
  begin
    TextoDFM.CaretY := 0;
    TextoDFM.CaretX := 0;
    TextoDFM.SearchReplace('  WIDTH =','', SearchOptionsPd);
    if TextoDFM.CaretY > 1 then
      Width := StrToIntDef(Trim(Copy(TextoDFM.LineText,11,50)),413);
  end;
  if (not Ok) or (Erro_de_Classe) then
  begin
    Mensagem('Erro de leitura do Formulário: ' + ^M + PastaForm + NomeForm + '.Pas',modErro,[modOk]);
    Erro_Formulario := True;
  end;
end;

function TFormAvulso.Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
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

procedure TFormAvulso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaEventos.Free;
  ListaInvisivel.Free;
  ListaDesabilitado.Free;
  ListaSelecaoCampos.Free;
  CompBotao := False;
  DsnRegister.Designing:= False;
  ListaSelecionados.Free;
  Lista_CB1.Free;

  if FormEditor = nil then
  begin
    FormPrincipal.Recortar.Enabled       := False;
    FormPrincipal.Colar.Enabled          := False;
    FormPrincipal.Copiar.Enabled         := False;
    FormPrincipal.SelecionarTudo.Enabled := False;
  end;

  Projeto.Formulario_Ult               := NomeForm;
end;

procedure TFormAvulso.AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
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

procedure TFormAvulso.AtribuiUses(Arquivo: String);
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

procedure TFormAvulso.SalvarFormulario(Index: Integer = -1);
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
    Output:=TMemoryStream.Create;
    with OutPut do
    begin
      WriteComponentRes(PastaForm + 'Form'+NomeForm+'.Tmp', Self);
      SaveToFile(PastaForm + 'Form'+NomeForm+'.Tmp');
      Free;
    end;
    ConvertFormOrText(PastaForm + 'Form'+NomeForm+'.Tmp',2);
    DeleteFile(PastaForm + 'Form'+NomeForm+'.Tmp');
    TextoTxt.Lines.Clear;
    if FileExists(PastaForm + 'Form'+NomeForm+'.Txt') then
      TextoTxt.Lines.LoadFromFile(PastaForm + 'Form'+NomeForm+'.Txt');
    VamosGravar := True;
    I:=0;
    Y:=0;
    Achou := False;
    TextoTxt_C := TStringList.Create;
    for Y:=1 to TextoDFM.Lines.Count-1 do
    begin                                                       
      if UpperCase(Copy(TrimRight(TextoDFM.Lines[Y]),01,09)) = '  OBJECT ' then
        if (UpperCase(Copy(Trim(TextoDFM.Lines[Y+1]),01,07)) = 'LEFT = ') then
          Achou := True
        else
          Achou := False;
      if not Achou then
      begin
        if Y = 1 then
          TextoTxt_C.Add(TextoDFM.Lines[Y-1]);
        TextoTxt_C.Add(TextoDFM.Lines[Y]);
      end;
    end;
    TextoDFM.Lines.Clear;
    TextoDFM.Lines.AddStrings(TextoTxt_C);
    Y := TextoDFM.Lines.Count;
    I:=0; QTD:=0;
    Achou := False; Achou2 := False; Reduzir := False;
    TextoTXT.CaretY := 0;
    TextoTXT.CaretX := 0;
    TextoTXT.SearchReplace('OnControlCreate = DsnStage0ControlCreate','', SearchOptionsPd);
    I := TextoTXT.CaretY;
    TextoTxt_C.Clear;
    FormAguarde.GaugeProcesso.Max := TextoTxt.Lines.Count-1;
    FormAguarde.GaugeProcesso.Min := I;
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
        Prox_Linha := Copy(TextoTxt.Lines[I],03,Length(TextoTxt.Lines[I]));
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
    Y := TextoDFM.CaretY;
    FormDesigner_Net.CurrentEdit(Index).Lines.SaveToFile(PastaForm + NomeForm + '.PAS');
    if TrimRight(UpperCase(TextoDfm.Lines[TextoDfm.Lines.Count-1])) <> 'END' then
      TextoDfm.Lines.Add('end');
    TextoDfm.Lines.SaveToFile(PastaForm + NomeForm + '.DFM');
    FormDesigner_Net.CurrentEdit(Index).Modified := False;
    TextoDfm.Modified := False;
    Ok := True;
  finally
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

procedure TFormAvulso.AtualizaLista_CB;
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

procedure TFormAvulso.DsnSelectChangeSelected(Sender: TObject;
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

procedure TFormAvulso.Define_TabOrder;
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

procedure TFormAvulso.DsnStage0ControlCreate(Sender: TObject;
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

    FormObjInsp.Atribui(Comp, True);
    //FormDesigner_Net.ObjectInspector.InspectObject := Comp;
    SetFocus;
  end;
  TDsnStage(Sender).UpdateControl;
  CompBotao := False;
end;

procedure TFormAvulso.DsnStage0DeleteQuery(Sender: TObject;
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

procedure TFormAvulso.DsnStage0MouseDown(Sender: TObject;
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
    //if ListaSelecaoCampos.Count > 0 then
    //  InserirCamposPagina(ListaSelecaoCampos, P_Titulo_DB, P_Distribuicao_DB, X, Y)
    //else
      DsnRegister.Designing := True;
    ListaSelecaoCampos.Clear;
    InserirCampo := False;
  end;
end;

procedure TFormAvulso.DsnStage0MoveQuery(Sender: TObject;
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

procedure TFormAvulso.DsnStage0SelectQuery(Sender: TObject;
  Component: TComponent; var CanSelect: TSelectAccept);
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
end;

procedure TFormAvulso.ExcluiObjeto(Nome: String; Eventos: Boolean);
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

procedure TFormAvulso.PageControl_NovaPagina;
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

function TFormAvulso.CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
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
    Control.Parent := DsnStage0
  else
    Control.Parent:=CompPageControl;
  Control.ShowHint := True;
  Count:=GetPropList(Component.ClassInfo,tkProperties,nil);
  GetMem(PropList,Count*SizeOf(PPropList));
  GetPropList(Component.ClassInfo,tkProperties,PropList);
  FreeMem(PropList,Count*SizeOf(PPropList));
  ObjetoAtual := Control;
  //NomeObjetoAtual := Control.Name;
  //TipoObjeto  := Control.ClassName;
  //FormDesigner_Net.Adiciona_CB1(Control.Name + ': ' +Control.ClassName);
  DsnRegister.Designing:= True;
  InserirCampo := False;
  CreateComponent := Control;
  if AtInspector then
    DsnSelect.Select(Control);
end;

function TFormAvulso.UniqueName(comp:TComponent; Tipo:String):string;
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

procedure TFormAvulso.Dsg_NovaPaginaClick(Sender: TObject);
begin
  CompPageControl := TWinControl(ObjetoAtual);
  PageControl_NovaPagina;

end;

procedure TFormAvulso.Dsg_EnviarparafrenteClick(Sender: TObject);
begin
  FormPrincipal.EnviarparafrenteClick(Self);
end;

procedure TFormAvulso.Dsg_EnviarparatrasClick(Sender: TObject);
begin
  FormPrincipal.EnviarparatrasClick(Self);
end;

procedure TFormAvulso.Dsg_Alinhamento_objClick(Sender: TObject);
begin
  FormPrincipal.AlinhamentoClick(Self);
end;

procedure TFormAvulso.Dsg_Dimensoes_objClick(Sender: TObject);
begin
  FormPrincipal.TamanhoClick(Self);
end;

procedure TFormAvulso.Dsg_SequnciaTabOrder1Click(Sender: TObject);
begin
  FormPrincipal.TabOrderClick(Self);

end;

procedure TFormAvulso.Dsg_Recortar1Click(Sender: TObject);
begin
  FormPrincipal.RecortarClick(Self);

end;

procedure TFormAvulso.Dsg_Copiar1Click(Sender: TObject);
begin
  FormPrincipal.CopiarClick(Self);

end;

procedure TFormAvulso.Dsg_Colar1Click(Sender: TObject);
begin
  FormPrincipal.ColarClick(Self);

end;

procedure TFormAvulso.Dsg_SelecionarTodos1Click(Sender: TObject);
begin
  FormPrincipal.SelecionarTudoClick(Self);
end;

procedure TFormAvulso.Dsg_Excluir1Click(Sender: TObject);
begin
  if FormDesigner_Net.CurrentPage = 1 then
    DsnRegister.DsnStage.Delete;
end;

procedure TFormAvulso.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFormAvulso.InserirCamposDB;
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
      //AutoFormatacao := False;
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
    //P_Titulo_DB := P_Titulo;
    //P_Distribuicao_DB := P_Distribuicao;
    InserirCampo := True;
    DsnRegister.Designing:= False;
  end;
  ListaSelecao.Free;
end;

end.
