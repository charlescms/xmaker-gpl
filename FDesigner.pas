unit FDesigner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, JvExControls, ExtCtrls,
  SMPanel, ToolWin, Menus, XEdit, XNum, XDate, JvTabBar,
  JvPageList, SynEdit, SynEditHighlighter, SynEditTypes, IniFiles,
  JvComponent, FrmXDesigner, ImgList, FR_Class, SynCompletionProposal;


type
  TMyMwCustomEdit_F = class(TSynEdit)
  public
    Filename: String;
    Filename_dfm: String;
    Filename_txt: String;
    LinhaErro: Integer;
    StatusBar: TStatusBar;
  end;

  TFormDesig = class(TFrmXDesig);

  TFormDesigner_Net = class(TForm)
    PnEsquerdo: TPanel;
    PnFundo: TPanel;
    PnInferior: TPanel;
    ListView_nao_visuais: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Splitter_L: TSplitter;
    PageList_Forms: TJvPageList;
    TabForms: TJvTabBar;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    JvModernTabBarPainter1: TJvModernTabBarPainter;
    PnError: TSMFramePanel;
    ListaErros: TListBox;
    PnSetas: TPanel;
    Image_seta_1: TImage;
    Image_seta_2: TImage;
    Image_seta_3: TImage;
    PnDivError: TPanel;
    PopupDesig: TPopupMenu;
    NovaPagina: TMenuItem;
    Divisao_NvPg: TMenuItem;
    Enviarparafrente: TMenuItem;
    Enviarparatras: TMenuItem;
    Dsg_N3: TMenuItem;
    Alinhamento: TMenuItem;
    Dimensoes: TMenuItem;
    TabOrder: TMenuItem;
    Dsg_N1: TMenuItem;
    Recortar: TMenuItem;
    Copiar: TMenuItem;
    Colar: TMenuItem;
    SelecionarTodos: TMenuItem;
    Dsg_N2: TMenuItem;
    Excluir: TMenuItem;
    PaletadeAlinhamento: TMenuItem;
    Bloquear: TMenuItem;
    Alinhar: TMenuItem;
    Texto_DFM: TSynEdit;
    Texto_TXT: TSynEdit;
    TreeView_Extra: TTreeView;
    ImageList1: TImageList;
    EditarRelatorio: TMenuItem;
    N1: TMenuItem;
    Propriedades: TMenuItem;
    EditarMenu: TMenuItem;
    N4: TMenuItem;
    Expresso: TMenuItem;
    Campos: TMenuItem;
    Formularios: TMenuItem;
    Comentar: TMenuItem;
    Descomentar: TMenuItem;
    Selecionar: TMenuItem;
    ListaParametros: TSynCompletionProposal;
    ListaFuncoes: TSynCompletionProposal;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SynEditSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure mwCustomEdit1StatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure mwCustomEdit1ReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure FormCreate(Sender: TObject);
    procedure TabFormsTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure TabFontes_FormsTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure ListaErrosDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListaErrosClick(Sender: TObject);
    procedure Image_seta_1Click(Sender: TObject);
    procedure TabFormsTabClosed(Sender: TObject; Item: TJvTabBarItem);
    procedure TabFormsTabClosing(Sender: TObject; Item: TJvTabBarItem;
      var AllowClose: Boolean);
    procedure EnviarparafrenteClick(Sender: TObject);
    procedure EnviarparatrasClick(Sender: TObject);
    procedure RecortarClick(Sender: TObject);
    procedure CopiarClick(Sender: TObject);
    procedure ColarClick(Sender: TObject);
    procedure SelecionarTodosClick(Sender: TObject);
    procedure ExcluirClick(Sender: TObject);
    procedure AlinhamentoClick(Sender: TObject);
    procedure DimensoesClick(Sender: TObject);
    procedure PaletadeAlinhamentoClick(Sender: TObject);
    procedure AlinharClick(Sender: TObject);
    procedure PopupDesigPopup(Sender: TObject);
    procedure NovaPaginaClick(Sender: TObject);
    procedure PnEsquerdoResize(Sender: TObject);
    procedure TreeView_ExtraDblClick(Sender: TObject);
    procedure TreeView_ExtraClick(Sender: TObject);
    procedure TabOrderClick(Sender: TObject);
    procedure EditarRelatorioClick(Sender: TObject);
    procedure PropriedadesClick(Sender: TObject);
    procedure EditarMenuClick(Sender: TObject);
    procedure TabFormsTabSelecting(Sender: TObject; Item: TJvTabBarItem;
      var AllowSelect: Boolean);
    procedure ExpressoClick(Sender: TObject);
    procedure CamposClick(Sender: TObject);
    procedure FormulariosClick(Sender: TObject);
    procedure BloquearClick(Sender: TObject);
    procedure ComentarClick(Sender: TObject);
    procedure DescomentarClick(Sender: TObject);
    procedure ListView_nao_visuaisClick(Sender: TObject);
    procedure SelecionarClick(Sender: TObject);
    procedure ListaParametrosCancelled(Sender: TObject);
    procedure ListaFuncoesCodeCompletion(var Value: String;
      Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    SearchOptionsPd: TSynSearchOptions;
    Posiciona_ObjInsp: Boolean;
    Posicao_Unit: Integer;
    Posicao_Tag: Integer;
    Finalizando: Boolean;
    Questionar: Boolean;
    Posicao_Close: Integer;
    function GetEditor(Index: integer): TMyMwCustomEdit_F;
    function GetForm_Avulso(Index: integer): TFormDesig;
    procedure Habilita_PopMenu(Value: Boolean);
    function CurrentTabForm: TJvTabBar;
    procedure Atribui_Complete;
  public
    { Public declarations }
    Shift_delete: Boolean;
    HostScroll: TScrollBox;
    Reativa_Definicao: Boolean;
    function Indice: Integer;
    property Editor[Index:integer] : TMyMwCustomEdit_F read GetEditor;
    property Form_Avulso[index: Integer]: TFormDesig read GetForm_Avulso;
    function CurrentForm_Avulso(Posicao: Integer = -1): TFormDesig;
    procedure AbreForm(Form: String; Tipo: Integer; Local: Boolean; LinhaErro: Integer = -1; MsgErro: String = '');
    procedure FechaForm(Index: integer);
    function CurrentEdit(Posicao: Integer = -1): TMyMwCustomEdit_F;
    function CurrentPage(NewIndex: Integer = -1): Integer;
    function Possui_DFM(Index: Integer = -1): Boolean;
    procedure StoreSettings;
    procedure LoadSettings;
    procedure Nome_Unit;
    procedure HabilitaBarraExtra;
  end;

var
  FormDesigner_Net: TFormDesigner_Net;

implementation

uses Abertura, Abertura_p, Rotinas, MiniEditor, Princ, BaseD, find,
  Replace, ObjInsp, FDMain, env_opt, FDSetup, MenuEdit_i, Expressao,
  CamposProj, LstForm, dbGridColunas;

{$R *.DFM}

procedure ShowInfoProc (const Name: string;
  NameType: TNameType; Flags: Byte; Param: Pointer);
var
  FlagStr: string;
begin
  FlagStr := ' ';
  if Flags and ufMainUnit <> 0 then
    FlagStr := FlagStr + 'Main Unit ';
  if Flags and ufPackageUnit <> 0 then
    FlagStr := FlagStr + 'Package Unit ';
  if Flags and ufWeakUnit <> 0 then
    FlagStr := FlagStr + 'Weak Unit ';
  if FlagStr <> ' ' then
    FlagStr := ' (' + FlagStr + ')';
  //showmessage(Name + FlagStr);
  {with Form1.TreeView1.Items do
    case NameType of
      ntContainsUnit:
        AddChild (ContNode, Name + FlagStr);
      ntRequiresPackage:
        AddChild (ReqNode, Name);
    end;}
end;

function TFormDesigner_Net.CurrentTabForm: TJvTabBar;
var
  Page: TJvStandardPage;
begin
  Page    := TJvStandardPage(PageList_Forms.Pages[PageList_Forms.ActivePageIndex]);
  Result  := TJvTabBar(Page.Controls[0]);
end;

function TFormDesigner_Net.GetEditor(Index: integer): TMyMwCustomEdit_F;
var
  Page: TJvStandardPage;
  TabBar_F: TJvTabBar;
  Panel_F: TPanel;
  PageList_F: TJvPageList;
  Page_U: TJvStandardPage;
  StatusBar_F: TStatusBar;
begin
  Page        := TJvStandardPage(PageList_Forms.Pages[index]);
  TabBar_F    := TJvTabBar(Page.Controls[0]);
  Panel_F     := TPanel(Page.Controls[1]);
  PageList_F  := TJvPageList(Page.Controls[2]);
  Page_U      := TJvStandardPage(PageList_F.Pages[0]);
  StatusBar_F := TStatusBar(Page_U.Controls[0]);
  Result      := TMyMwCustomEdit_F(Page_U.Controls[1]);
end;

function TFormDesigner_Net.GetForm_Avulso(Index: integer): TFormDesig;
var
  I: integer;
  Page: TJvStandardPage;
  TabBar_F: TJvTabBar;
  Panel_F: TPanel;
  PageList_F: TJvPageList;
  Page_U: TJvStandardPage;
  StatusBar_F: TStatusBar;
  Edit: TMyMwCustomEdit_F;
  Page_F: TJvStandardPage;
  ScrollBox_F: TScrollBox;
begin
  Page        := TJvStandardPage(PageList_Forms.Pages[index]);
  TabBar_F    := TJvTabBar(Page.Controls[0]);
  Panel_F     := TPanel(Page.Controls[1]);
  PageList_F  := TJvPageList(Page.Controls[2]);
  Page_U      := TJvStandardPage(PageList_F.Pages[0]);
  StatusBar_F := TStatusBar(Page_U.Controls[0]);
  Edit        := TMyMwCustomEdit_F(Page_U.Controls[1]);
  Page_F      := TJvStandardPage(PageList_F.Pages[1]);
  ScrollBox_F := TScrollBox(Page_F.Controls[0]);
  Result := nil;
  for I := 0 to ScrollBox_F.ControlCount-1 do
    if (ScrollBox_F.Controls[I] is TFormDesig) then
     begin
       Result := (ScrollBox_F.Controls[I] as TFormDesig);
       break;
     end;
end;

function TFormDesigner_Net.CurrentForm_Avulso(Posicao: Integer = -1): TFormDesig;
begin
  if Assigned(PageList_Forms.ActivePage) then
    if Posicao = -1 then
      Result := Form_Avulso[PageList_Forms.ActivePage.PageIndex]
    else
      Result := Form_Avulso[Posicao]
end;

procedure TFormDesigner_Net.FechaForm(Index: integer);
var
  Page: TJvStandardPage;
  TabBar_F: TJvTabBar;
  Panel_F: TPanel;
  PageList_F: TJvPageList;
  Page_U: TJvStandardPage;
  StatusBar_F: TStatusBar;
  Edit: TMyMwCustomEdit_F;
  Page_F: TJvStandardPage;
  ScrollBox_F: TScrollBox;
begin
  if Questionar then
   if CurrentEdit(Index).Modified then
     if Mensagem('Salvar '+CurrentEdit(Index).FileName +' ?',ModConfirmacao,[ModSim, ModNao]) = mrYes then
     begin
       if Possui_DFM(Index) then
         CurrentForm_Avulso(Index).VamosGravar := True
       else
         CurrentEdit(Index).Lines.SaveToFile(CurrentEdit(Index).FileName);
     end;
  Page        := TJvStandardPage(PageList_Forms.Pages[index]);
  TabBar_F    := TJvTabBar(Page.Controls[0]);
  TabBar_F.PageList := Nil;
  Panel_F     := TPanel(Page.Controls[1]);
  PageList_F  := TJvPageList(Page.Controls[2]);
  Page_U      := TJvStandardPage(PageList_F.Pages[0]);
  StatusBar_F := TStatusBar(Page_U.Controls[0]);
  Edit        := TMyMwCustomEdit_F(Page_U.Controls[1]);
  Page_F      := TJvStandardPage(PageList_F.Pages[1]);
  ScrollBox_F := TScrollBox(Page_F.Controls[0]);

  if Possui_DFM(Index) then
  begin
    CurrentForm_Avulso(Index).Index := Index;
    CurrentForm_Avulso(Index).Close;
  end;

  ListaFuncoes.RemoveEditor(Edit);
  ListaParametros.RemoveEditor(Edit);

  ScrollBox_F.Destroy;
  Page_F.Destroy;
  Edit.Destroy;
  StatusBar_F.Destroy;
  Page_U.Destroy;
  PageList_F.Destroy;
  Panel_F.Destroy;
  TabBar_F.Destroy;
  Page.Destroy;

  if not Finalizando then
  begin
    TabFormsTabSelected(Self, TabForms.SelectedTab);
    CurrentPage(1);
  end;
end;

procedure TFormDesigner_Net.FormDestroy(Sender: TObject);
begin
  FrmFind.Free;
  FrmEnvOpts.Free;
  FrmReplace.Free;
end;

procedure TFormDesigner_Net.AbreForm(Form: String; Tipo: Integer; Local: Boolean; LinhaErro: Integer = -1; MsgErro: String = '');
var
  StatusBar_F: TStatusBar;
  PageList_F: TJvPageList;
  TabBar_F: TJvTabBar;
  Panel_F: TPanel;
  Page, Page_U, Page_F: TJvStandardPage;
  Avulso: TFormDesig;
  ScrollBox: TScrollBox;
  Edit: TMyMwCustomEdit_F;
  NomePas, NomeDFM: String;

  function Tipo_TModule: Boolean;
  var
    F_Form: TSynEdit;
  begin
    F_Form := TSynEdit.Create(Self);
    with F_Form do
    begin
      Visible := False;
      Lines.LoadFromFile(NomePas);
      CaretX := 1;
      CaretY := 1;
      SearchReplace('class(TDataModule)', '', SearchOptionsPd );
      if CaretX > 1 then
        Tipo_TModule := True
      else
        Tipo_TModule := False;
      F_Form.Free;
    end;
  end;

  procedure LoadFile(const FileName: string);
  (* This bit is stolen from EditU2.pas *)
    function MatchesExtension(ext: string; light: TSynCustomHighLighter): boolean;
      var
      fext  : string;
//      idx   : integer;
      ucext : string;
      filter: string;
      p     : integer;
    begin
      Result := false;
      ucext := UpperCase(ext);
      p := Pos('.',ucext);
      if p > 0 then ucext := Copy(ucext,p+1,Length(ucext)-p);
      p := Pos('|',light.DefaultFilter);
      if p > 0 then begin
        filter := Copy(light.DefaultFilter,p+1,Length(light.DefaultFilter)-p);
        while filter <> '' do begin
          p := Pos(';',filter);
          if p = 0 then p := Length(filter)+1;
          fext := Copy(filter,1,p-1);
          filter := Copy(filter,p+1,Length(filter)-p);
          p := Pos('.',fext);
          if p > 0 then fext := Copy(fext,p+1,Length(fext)-p);
          if UpperCase(fext) = ucext then begin
(*
            idx := cbxHighlighterSelect.Items.IndexOf(light.LanguageName);
            if idx >= 0 then cbxHighlighterSelect.ItemIndex := idx;
            cbxHighlighterSelectChange(Self);
*)
            Edit.Highlighter := light;
            Result := true;
          end;
        end; //while
      end
    end; { MatchesExtension }

  var
    i  : integer;
    ext: string;
    bWasText: boolean;                                                            //mh 1999-10-04
    backCursor: TCursor;
  begin
    backCursor := Cursor;
    try
      Cursor := crHourGlass;
      Windows.SetCursor(Screen.Cursors[crHourGlass]);
      ext := UpperCase(ExtractFileExt(FileName));
      for i := 0 to BaseDados.ComponentCount-1 do
        if BaseDados.Components[i] is TSynCustomHighLighter then begin
          if MatchesExtension(ext,BaseDados.Components[i] as TSynCustomHighLighter) then break;
        end;
      //if Edit.HighLighter = dmDfmSyn1 then
      //  LoadDFMFile2Strings(aFileName, Edit.Lines, bWasText)                        //mh 1999-10-04
      //else
        Edit.Lines.LoadFromFile(FileName);
    finally
      Cursor := backCursor;
    end;
  end;
begin
  if Possui_DFM then
  begin
    CurrentForm_Avulso.cmpFormDesigner.KeySelect := False;
    CurrentForm_Avulso.cmpFormDesigner.KeyMove   := False;
    CurrentForm_Avulso.cmpFormDesigner.Active    := False;
  end;
  FormObjInsp.Atribui(Nil, True);
  Page := TJvStandardPage.Create(PageList_Forms);
  try
    Page.Parent      := PageList_Forms;
    Page.PageList    := PageList_Forms;
    Page.Caption     := '';
    PageList_Forms.ActivePage := Page;

    TabBar_F             := TJvTabBar.Create(Page);
    TabBar_F.Parent      := Page;
    TabBar_F.Align       := alBottom;
    TabBar_F.Orientation := toBottom;
    TabBar_F.CloseButton := False;
    TabBar_F.Painter     := JvModernTabBarPainter1;
    TabBar_F.AddTab('Código');
    if Local then
    begin
      NomePAS := Projeto.Pasta + Form + '.Pas';
      NomeDFM := Projeto.Pasta + Form + '.Dfm';
    end
    else
    begin
      NomePAS := Form;
      if Pos('.pas', lowercase(form)) > 0 then
        NomeDFM := TrocaString(NomePAS, '.pas', '.Dfm', [rfReplaceAll, rfIgnoreCase])
      else
        NomeDFM := '_x_x_x_x_x_x_90';
    end;

    if Tipo_TModule then
      NomeDFM := '_x_x_x_x_x_x_90';

    if FileExists(NomeDFM) then
    begin
      TabBar_F.AddTab('Formulário');
      TabBar_F.Tabs[1].Selected := True;
      Habilita_PopMenu(False);
    end
    else
    begin
      TabBar_F.Tabs[0].Selected := True;
      Habilita_PopMenu(True);
    end;

    TabBar_F.OnTabSelected := TabFontes_FormsTabSelected;

    Panel_F             := TPanel.Create(Page);
    Panel_F.Parent      := Page;
    Panel_F.BevelOuter  := bvNone;
    Panel_F.BorderStyle := bsNone;
    Panel_F.Align       := alBottom;
    Panel_F.Height      := 4;

    PageList_F        := TJvPageList.Create(Page);
    PageList_F.Parent := Page;
    PageList_F.Align  := alClient;

    Page_U           := TJvStandardPage.Create(PageList_F);
    Page_U.Parent    := PageList_F;
    Page_U.PageList  := PageList_F;
    Page_U.Caption   := '';

    if Projeto.Tabs <= 0 then Projeto.Tabs := 2;
    StatusBar_F              := TStatusBar.Create(Page_U);
    StatusBar_F.Parent       := Page_U;
    StatusBar_F.Align        := alBottom;
    StatusBar_F.Panels.Add;
    StatusBar_F.Panels[0].Alignment := taLeftJustify;
    StatusBar_F.Panels[0].Width     := 110;
    StatusBar_F.Panels.Add;
    StatusBar_F.Panels[1].Alignment := taCenter;
    StatusBar_F.Panels[1].Width     := 80;
    StatusBar_F.Panels.Add;
    StatusBar_F.Panels[2].Alignment := taLeftJustify;
    StatusBar_F.Panels[2].Width     := 50;

    Edit                     := TMyMwCustomEdit_F.Create(Page_U);
    Edit.TabWidth            := 4;
    Edit.Parent              := Page_U;
    Edit.Align               := alClient;
    Edit.MaxUndo             := 1024;
    Edit.MaxLeftChar         := 5024;
    Edit.OnSpecialLineColors := SynEditSpecialLineColors;
    Edit.OnKeyPress          := EditKeyPress;
    Edit.TabWidth            := Projeto.Tabs;
    Edit.WantTabs            := True;
    Edit.FileName            := NomePas;
    Edit.StatusBar           := StatusBar_F;
    LoadFile( NomePas );
    Edit.Modified := false;
    Edit.ClearUndo;
    Edit.Options := Edit.Options - [eoShowScrollHint];
    Edit.Options := Edit.Options - [eoSmartTabDelete];
    ListaFuncoes.AddEditor(Edit);
    ListaParametros.AddEditor(Edit);
    Atribui_Complete;

    frmEnvOpts.cbSmartTabs.Checked := False;
    frmEnvOpts.T_Tabs.Value := Projeto.Tabs;
    frmEnvOpts.AssignOptions(Edit);

    Edit.OnStatusChange := mwCustomEdit1StatusChange;
    Edit.PopupMenu      := PopupDesig; // PopMenu;
    Edit.OnReplaceText  := mwCustomEdit1ReplaceText;
    mwCustomEdit1StatusChange( Edit, [] );

    PageList_F.ActivePage := Page_U;

    Page_F           := TJvStandardPage.Create(PageList_F);
    Page_F.Parent    := PageList_F;
    Page_F.PageList  := PageList_F;
    Page_F.Caption   := '';

    TabBar_F.PageList := PageList_F;

    ScrollBox := TScrollBox.Create(Page_F);
    with ScrollBox do
    begin
      Parent      := Page_F;
      Align       := alClient;
      BorderStyle := bsNone;
      Color       := clWindow;
    end;
    HostScroll  := ScrollBox;
    if FileExists(NomeDFM) then
    begin
      Edit.FileName_dfm := NomeDFM;
      Edit.FileName_txt := TrocaString(NomeDFM, '.dfm', '.txt', [rfReplaceAll, rfIgnoreCase]);
      Avulso := TFormDesig.Create(Page);
      with Avulso do
      begin
        Caption := Form;
        Page.Tag := 1; // Avulso
        Show;
      end;
    end
    else
      Page.Tag := -1;
    if Local then
      TabForms.AddTab(Form)
    else
    begin
      Form  := ExtractFileName(Form);
      Form  := Copy(Form, 01, Pos('.', Form)-1);
      TabForms.AddTab(Form);
      TabForms.Tabs[TabForms.Tabs.Count-1].Hint := NomePAS;
    end;
    TabForms.Tabs[TabForms.Tabs.Count-1].Selected := True;
    TabForms.Tabs[TabForms.Tabs.Count-1].Tag := Posicao_Tag;
    Page.Name := 'PgForm_'+IntToStr(Posicao_Tag);
    inc(Posicao_Tag);

    if FileExists(NomeDFM) then
      CurrentForm_Avulso.Carrega_Form;
    HabilitaBarraExtra;
    if Possui_DFM then
    begin
      CurrentForm_Avulso.cmpFormDesigner.KeySelect := True;
      CurrentForm_Avulso.cmpFormDesigner.KeyMove   := True;
      CurrentForm_Avulso.cmpFormDesigner.Active    := True;
      SetFocus;
    end
    else
    begin
      FormObjInsp.Hide;
      Edit.SetFocus;
    end;
    if LinhaErro > -1 then
    begin
      PnDivError.Visible    := True;
      PnError.Visible       := True;
      ListaErros.Items.Text := msgErro;
      Edit.LinhaErro        := LinhaErro;
      Edit.CaretY           := LinhaErro;
      ListaErrosClick(Self);
    end;
  except
    on exception do
    begin
      if Assigned(Avulso) then
        Avulso.Free;
      if Assigned(ScrollBox) then
        ScrollBox.Free;
      if Assigned(Page_F) then
        Page_F.Free;
      if Assigned(Edit) then
        Edit.Free;
      if Assigned(StatusBar_F) then
        StatusBar_F.Free;
      if Assigned(Page_U) then
        Page_U.Free;
      if Assigned(PageList_F) then
        PageList_F.Free;
      if Assigned(Panel_F) then
        Panel_F.Free;
      if Assigned(TabBar_F) then
        TabBar_F.Free;
      if Assigned(Page) then
        Page.Free;
      Close;
    end;
  end;
end;

procedure TFormDesigner_Net.FormShow(Sender: TObject);
var
  i, y: Integer;
  ANode, Node, TreeNode: TTreeNode;
  Ln_Funcao, Lista_Nomes: TStringList;

  {procedure CriaPacote;
  type
    TPackageLoad = procedure;
  var
    PackageLoad: TPackageLoad;
  var
    PackageModule: HModule;
    AClass: TPersistentClass;
    ANome: String;
    Flags: Integer;
    Bpl_Units: TPackageClassesAndUnits;
    I: Integer;
  begin
    PackageModule := LoadPackage('c:\temp\pacote_d5.bpl');
    Bpl_Units := TPackageClassesAndUnits.Create(LoadPackage('c:\temp\pacote_d5.bpl'));
    PackageModule := LoadPackage('c:\temp\pacote_d5.bpl');
    if PackageModule <> 0 then
    begin
      Bpl_Units := TPackageClassesAndUnits.Create('c:\temp\pacote_d5.bpl');
      ANome := GetPackageDescription(PChar('c:\temp\pacote_d7.bpl'));
      GetPackageInfo (PackageModule, nil,
        Flags, ShowInfoProc);
      ANome := 'SUISkinDsgn';
      AClass := GetClass(ANome);
      if AClass <> nil then
        RegisterClass(AClass);
      UnloadPackage(PackageModule);
    end;
  end;}

begin
  Ln_Funcao := TStringList.Create;
  Lista_Nomes := TStringList.Create;
  TreeNode := TreeView_Extra.Items.Add(nil, 'Métodos');
  TreeNode.ImageIndex := 0;
  TreeNode.SelectedIndex := 0;
  Texto_TXT.Lines.Clear;
  Texto_DFM.Lines.Clear;
  if FileExists(Projeto.PastaGerador + 'Funcoes.Lst') then
  begin
    Texto_TXT.Lines.LoadFromFile(Projeto.PastaGerador + 'Funcoes.Lst');
    Texto_DFM.Lines.LoadFromFile(Projeto.PastaGerador + 'Funcoes.Lst');
  end;
  for I:=0 to Texto_TXT.Lines.Count-1 do
  begin
    if Trim(Texto_TXT.Lines[i]) <> '' then
    begin
      Ln_Funcao.Clear;
      StringToArray(Texto_TXT.Lines[i],'|',Ln_Funcao);
      if (Ln_Funcao.Count = 4) and (Lista_Nomes.IndexOf(Ln_Funcao[0]) < 0) then
      begin
        Lista_Nomes.Add(Ln_Funcao[0]);
        ANode := TreeView_Extra.Items.AddChild(TreeNode, Ln_Funcao[0]);
        ANode.ImageIndex := 1;
        ANode.SelectedIndex := 1;
        for Y:=0 to Texto_DFM.Lines.Count-1 do
        begin
          if Trim(Texto_DFM.Lines[Y]) <> '' then
          begin
            Ln_Funcao.Clear;
            StringToArray(Texto_DFM.Lines[Y],'|',Ln_Funcao);
            if (Ln_Funcao.Count = 4) and ((Ln_Funcao[0] = ANode.Text) or (ANode.Text = '')) then
            begin
              Node := TreeView_Extra.Items.AddChildObject(ANode, Ln_Funcao[1], TObject(Y));
              Node.ImageIndex := 2;
              Node.SelectedIndex := 2;
            end;
          end;
        end;
      end;
    end;
  end;
  Texto_DFM.Lines.Clear;
  Texto_TXT.Lines.Clear;
  Ln_Funcao.Free;
  Lista_Nomes.Free;
  TreeView_Extra.FullExpand;
  if TreeView_Extra.Items.Count > 0 then
    TreeView_Extra.Selected := TreeView_Extra.Items[0];

  Posiciona_ObjInsp := True;
  FormObjInsp := TFormObjInsp.Create(Application);
  FormObjInsp.SplitterPos := 75;
  FormObjInsp.Show;
  FormMenuEdit_i := TFormMenuEdit_i.Create(Application);
  FormMenuEdit_i.Hide;
  FormdbGridColunas := TFormdbGridColunas.Create(Application);
  FormdbGridColunas.Hide;
  FormPrincipal.Botoes(True);
  Finalizando  := False;
  Posicao_Tag  := 100;
  Posicao_Unit := 0;
  FormPrincipal.PnFundo.Visible := False;
  LoadSettings;
end;

procedure TFormDesigner_Net.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I: Integer;
begin
  Finalizando := True;
  Questionar  := True;
  for I := PageList_Forms.PageCount-1 downto 0  do
    FechaForm(I);
  FormPrincipal.PnFundo.Visible := True;
  if Assigned(FormMenuEdit_i) then
  begin
    FormMenuEdit_i.Fecha := True;
    FormMenuEdit_i.Free;
  end;
  if Assigned(FormdbGridColunas) then
  begin
    FormdbGridColunas.Fecha := True;
    FormdbGridColunas.Free;
  end;
  if Assigned(FormObjInsp) then
  begin
    FormObjInsp.Fecha := True;
    FormObjInsp.Free;
  end;
  FormPrincipal.Botoes(False);
  Action := Cafree;
  FormDesigner_Net := Nil;
  if Reativa_Definicao then
    FormPrincipal.TimerFormulario.Enabled := True;
end;

procedure TFormDesigner_Net.SynEditSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  if Line = TMyMwCustomEdit_F(Sender).LinhaErro then
  begin
    Special := TRUE;
    FG := clWhite;
    BG := clRed
  end;
end;

procedure TFormDesigner_Net.FormCreate(Sender: TObject);
begin
  FrmFind := TFrmFind.Create(Application);
  frmEnvOpts := TfrmEnvOpts.Create(Application);
  FrmReplace := TFrmReplace.Create(Application);
end;

procedure TFormDesigner_Net.mwCustomEdit1StatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  with Sender as TSynEdit do begin
    TMyMwCustomEdit_F(Sender).StatusBar.Panels[0].Text := Format('%d:%d', [CaretY, CaretX]);
    if Modified then
      TMyMwCustomEdit_F(Sender).StatusBar.Panels[1].Text := 'Modificado'
    else
      TMyMwCustomEdit_F(Sender).StatusBar.Panels[1].Text := '';
    if InsertMode then
      TMyMwCustomEdit_F(Sender).StatusBar.Panels[2].Text := 'Inserção'
    else
      TMyMwCustomEdit_F(Sender).StatusBar.Panels[2].Text := 'Subscrever'; {OverWrite}
  end;
end;

procedure TFormDesigner_Net.Habilita_PopMenu(Value: Boolean);
begin
  Enviarparafrente.Visible    := not Value;
  Enviarparatras.Visible      := not Value;
  Dsg_N3.Visible              := not Value;
  Alinhamento.Visible         := not Value;
  PaletadeAlinhamento.Visible := not Value;
  Alinhar.Visible             := not Value;
  Dimensoes.Visible           := not Value;
  TabOrder.Visible            := not Value;
  N4.Visible                  := not Value;
  Expresso.Visible            := Value;
  Campos.Visible              := Value;
  Formularios.Visible         := Value;
  Bloquear.Visible            := not Value;
  Excluir.Visible             := not Value;
  N1.Visible                  := not Value;
  Propriedades.Visible        := not Value;
  Comentar.Visible            := Value;
  Descomentar.visible         := Value;
end;

procedure TFormDesigner_Net.TabFontes_FormsTabSelected(Sender: TObject;
  Item: TJvTabBarItem);
begin
  case Item.Index of
    0: begin
         CurrentEdit.SetFocus;
         if Possui_DFM then
         begin
           CurrentForm_Avulso.cmpFormDesigner.KeySelect := False;
           CurrentForm_Avulso.cmpFormDesigner.KeyMove   := False;
           CurrentForm_Avulso.cmpFormDesigner.Active    := False;
         end;
         Habilita_PopMenu(True);
       end;
    1: begin
         if Possui_DFM then
         begin
           CurrentForm_Avulso.cmpFormDesigner.KeySelect := True;
           CurrentForm_Avulso.cmpFormDesigner.KeyMove   := True;
           CurrentForm_Avulso.cmpFormDesigner.Active    := True;
         end;
         Habilita_PopMenu(False);
       end;
  end;
end;

procedure TFormDesigner_Net.TabFormsTabSelected(Sender: TObject;
  Item: TJvTabBarItem);
var
  Comp: TComponent;
begin
  if Assigned(Item) then
  begin
    Comp := PageList_Forms.FindComponent('PgForm_'+IntToStr(Item.Tag));
    if Comp <> Nil then
    begin
      PageList_Forms.ActivePage := TJvCustomPage(Comp);
      FormObjInsp.Atribui(Nil, True);
      FormObjInsp.CB1.Items.Clear;
      if Possui_DFM then
        CurrentForm_Avulso.Atualiza_CB(True, '', '', Nil);
      if CurrentTabForm.SelectedTab <> Nil then
        TabFontes_FormsTabSelected(Self, CurrentTabForm.SelectedTab);
      //if Possui_DFM then
      //begin
      //  CurrentForm_Avulso.cmpFormDesigner.KeySelect := True;
      //  CurrentForm_Avulso.cmpFormDesigner.KeyMove   := True;
      //  CurrentForm_Avulso.cmpFormDesigner.Active    := True;
      //  Habilita_PopMenu(False);
      //end
      //else
      //  Habilita_PopMenu(True);
    end;
  end;
  HabilitaBarraExtra;
end;

procedure TFormDesigner_Net.HabilitaBarraExtra;
begin
  FormObjInsp.CB1.Items.Clear;
  if Possui_DFM then
  begin
    FormObjInsp.CB1.Items.AddStrings(FormDesigner_Net.CurrentForm_Avulso.ListaComp);
    CurrentForm_Avulso.cmpFormDesigner.UnselectAll;
  end;
  FormObjInsp.BtnFormFilho.Enabled := False;
  FormObjInsp.BtnCampo.Enabled     := False;
  FormObjInsp.BtnFormatar.Enabled  := False;
  FormObjInsp.BtnPaginas.Enabled   := False;
  FormObjInsp.BtnWinState.Enabled  := False;
  FormObjInsp.BtnPosition.Enabled  := False;
  if Possui_DFM then
  begin
    FormObjInsp.BtnPropriedades.Enabled := True;
    FormObjInsp.BtnBloquear.Enabled     := True;
    FormObjInsp.BtnOrdemTab.Enabled     := True;
    FormObjInsp.BtnWinState.Enabled     := True;
    FormObjInsp.BtnPosition.Enabled     := True;
    if (Assigned(FormDesigner_Net.CurrentForm_Avulso.FindComponent('Pagina0'))) and
       (Trim(FormDesigner_Net.CurrentForm_Avulso.NrTabela) <> '')  then
    begin
      FormObjInsp.BtnFormFilho.Enabled := True;
      FormObjInsp.BtnCampo.Enabled     := True;
      FormObjInsp.BtnFormatar.Enabled  := True;
    end;
    if Assigned(FormDesigner_Net.CurrentForm_Avulso.FindComponent('TabPaginas')) then
      FormObjInsp.BtnPaginas.Enabled := True;
    FormObjInsp.Show;
  end
  else
  begin
    FormObjInsp.BtnPropriedades.Enabled := False;
    FormObjInsp.BtnBloquear.Enabled     := False;
    FormObjInsp.BtnOrdemTab.Enabled     := False;
    FormObjInsp.Hide;
  end;
end;

procedure TFormDesigner_Net.ListaErrosDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  OffSet: Integer;
begin
  With (Control as TListBox).Canvas do
  begin
    FillRect(Rect);
    Offset:= PnSetas.width;
    TextOut(Rect.Left+Offset,
            Rect.Top,
            (Control as TListBox).Items[Index]);
  end;
end;

procedure TFormDesigner_Net.ListaErrosClick(Sender: TObject);
begin
  Image_seta_1.Visible := False;
  Image_seta_2.Visible := False;
  Image_seta_3.Visible := False;
  if ListaErros.ItemIndex = ListaErros.TopIndex then
    Image_seta_1.Visible := True
  else if ListaErros.ItemIndex = ListaErros.TopIndex + 1 then
    Image_seta_2.Visible := True
  else if ListaErros.ItemIndex = ListaErros.TopIndex + 2 then
    Image_seta_3.Visible := True
  else
    Image_seta_1.Visible := True;
end;

procedure TFormDesigner_Net.mwCustomEdit1ReplaceText(Sender: TObject;
  const ASearch, AReplace: String; Line, Column: Integer;
  var Action: TSynReplaceAction);
var
  Resposta : Integer;
begin
  Resposta := Mensagem('Substituir a ocorrência por: '+^M+^M+#39+AReplace+#39+' ?',modConfirmacao,[modSim,modNao,ModCancela,modTodos]);
  if Resposta = mrYes then
    Action := raReplace
  else if Resposta = mrNo then
    Action := raSkip
  else if Resposta = mrCancel then
    Action := raCancel
  else if Resposta = mrAll then
    Action := raReplaceAll;
end;

procedure TFormDesigner_Net.Image_seta_1Click(Sender: TObject);
begin
  ListaErros.ItemIndex := ListaErros.TopIndex + Image_Seta_1.Tag;
end;

function TFormDesigner_Net.Possui_DFM(Index: Integer = -1): Boolean;
var
  Page: TJvStandardPage;
  TabBar_F: TJvTabBar;
  //Index: Integer;
begin
  if Index = -1 then
    index := PageList_Forms.ActivePageIndex;
  if Index > -1 then
  begin
    Page     := TJvStandardPage(PageList_Forms.Pages[index]);
    TabBar_F := TJvTabBar(Page.Controls[0]);
    Possui_DFM := TabBar_F.Tabs.Count > 1;
  end
  else
    Possui_DFM := False;
end;

function TFormDesigner_Net.CurrentPage(NewIndex: Integer = -1): Integer;
var
  Page: TJvStandardPage;
  TabBar_F: TJvTabBar;
  Panel_F: TPanel;
  PageList_F: TJvPageList;
  index: Integer;
begin
  index       := PageList_Forms.ActivePageIndex;
  if index < 0 then
  begin
    Result := -1;
    exit;
  end;
  Page        := TJvStandardPage(PageList_Forms.Pages[index]);
  TabBar_F    := TJvTabBar(Page.Controls[0]);
  Panel_F     := TPanel(Page.Controls[1]);
  PageList_F  := TJvPageList(Page.Controls[2]);
  if NewIndex > -1 then
    if (NewIndex <= PageList_F.PageCount-1) and
       (NewIndex <= TabBar_F.Tabs.Count-1) then
    begin
      PageList_F.ActivePageIndex := NewIndex;
      TabBar_F.Tabs[NewIndex].Selected := True;
    end;
  CurrentPage := PageList_F.ActivePageIndex;
end;

procedure TFormDesigner_Net.Nome_Unit;
var
  Novo_Nome: String;
begin
  if Pos('.pas', LowerCase(CurrentEdit.FileName)) > 0 then
  begin
    CurrentEdit.CaretX := 1;
    CurrentEdit.CaretY := 1;
    CurrentEdit.SearchReplace('unit ', '', SearchOptionsPd );
    if Pos('unit ', CurrentEdit.SelText) > 0 then
    begin
      Novo_Nome  := ExtractFileName(CurrentEdit.FileName);
      Novo_Nome  := Copy(Novo_Nome, 01, Pos('.', Novo_Nome)-1);
      if Trim(Novo_Nome) <> '' then
        CurrentEdit.Lines[CurrentEdit.CaretY-1] := 'unit '+ Novo_Nome + ';';
    end;
  end;
end;

function TFormDesigner_Net.CurrentEdit(Posicao: Integer = -1): TMyMwCustomEdit_F;
var
  Page: TJvStandardPage;
  TabBar_F: TJvTabBar;
  Panel_F: TPanel;
  PageList_F: TJvPageList;
  Page_U: TJvStandardPage;
  StatusBar_F: TStatusBar;
  Edit: TMyMwCustomEdit_F;
  index: Integer;
begin
  if Posicao = -1 then
    index := PageList_Forms.ActivePageIndex
  else
    index := Posicao;
  if index < 0 then
  begin
    Result := Nil;
    exit;
  end;
  Page        := TJvStandardPage(PageList_Forms.Pages[index]);
  TabBar_F    := TJvTabBar(Page.Controls[0]);
  Panel_F     := TPanel(Page.Controls[1]);
  PageList_F  := TJvPageList(Page.Controls[2]);
  Page_U      := TJvStandardPage(PageList_F.Pages[0]);
  StatusBar_F := TStatusBar(Page_U.Controls[0]);
  Edit        := TMyMwCustomEdit_F(Page_U.Controls[1]);
  Result      := Edit;
end;

procedure TFormDesigner_Net.StoreSettings;
var
  INI : TINIFile;
  I,J : integer;
  ArqIni: String;
begin
  ArqIni  := Projeto.PastaGerador;
  Ini := TInifile.Create(ArqIni + 'XMAKER.INI');
  try
    INI.WriteBool( 'Editor', 'AutoIndent', frmEnvOpts.cbAutoIndent.Checked );
    INI.WriteBool( 'Editor', 'DragDropEditing', frmEnvOpts.cbDragDropEditing.Checked );
    INI.WriteBool( 'Editor', 'DropFiles', frmEnvOpts.cbDropFiles.Checked );
    INI.WriteBool( 'Editor', 'HalfPageScroll', frmEnvOpts.cbHalfPageScroll.Checked );
    INI.WriteBool( 'Editor', 'ScrollPastEol', frmEnvOpts.cbScrollPastEol.Checked );
    INI.WriteBool( 'Editor', 'TabsToSpaces', frmEnvOpts.cbTabsToSpaces.Checked );
    INI.WriteBool( 'Editor', 'SmartTabs', frmEnvOpts.cbSmartTabs.Checked );

    INI.WriteBool( 'Gutter', 'ShowLineNumbers', frmEnvOpts.cbShowLineNumbers.Checked );
  finally
    INI.Free;
  end;
end;

procedure TFormDesigner_Net.LoadSettings;
var
  INI : TINIFile;
  I,J : integer;
  Attr,ArqIni: string;
begin
  ArqIni  := Projeto.PastaGerador; //DiretorioComBarra(DirWindows);
  Ini := TInifile.Create(ArqIni + 'XMAKER.INI');
  try
    frmEnvOpts.cbAutoIndent.Checked := INI.ReadBool( 'Editor', 'AutoIndent', true );
    frmEnvOpts.cbDragDropEditing.Checked := INI.ReadBool( 'Editor', 'DragDropEditing', true );
    frmEnvOpts.cbDropFiles.Checked := INI.ReadBool( 'Editor', 'DropFiles', false );
    frmEnvOpts.cbHalfPageScroll.Checked := INI.ReadBool( 'Editor', 'HalfPageScroll', false );
    frmEnvOpts.cbScrollPastEol.Checked := INI.ReadBool( 'Editor', 'ScrollPastEol', true );
    frmEnvOpts.cbTabsToSpaces.Checked := INI.ReadBool( 'Editor', 'TabsToSpaces', true );
    frmEnvOpts.cbSmartTabs.Checked := INI.ReadBool( 'Editor', 'SmartTabs', true );

    frmEnvOpts.cbShowLineNumbers.Checked := INI.ReadBool( 'Gutter', 'ShowLineNumbers', true );
    frmEnvOpts.cbGutterVisible.Checked := boolean(strtoint('30'));
  finally
    INI.Free;
  end;
end;

procedure TFormDesigner_Net.TabFormsTabClosed(Sender: TObject;
  Item: TJvTabBarItem);
var
  Comp: TComponent;
begin
  Comp := PageList_Forms.FindComponent('PgForm_'+IntToStr(Item.Tag));
  FormObjInsp.Atribui(Nil, True);
  if Comp <> Nil then
    FechaForm(Posicao_Close);
  if TabForms.Tabs.Count <= 1 then
    Close;
end;

function TFormDesigner_Net.Indice: Integer;
var
  I: Integer;
  Comp: TComponent;
begin
  for I:=0 to TabForms.Tabs.Count-1 do
    if TabForms.Tabs[I].Selected then
      Comp := PageList_Forms.FindComponent('PgForm_'+IntToStr(TabForms.Tabs[I].Tag));
  if Comp <> Nil then
    Indice := TJvCustomPage(Comp).PageIndex
  else
    Indice := -1;  
end;

procedure TFormDesigner_Net.TabFormsTabClosing(Sender: TObject;
  Item: TJvTabBarItem; var AllowClose: Boolean);
var
  Comp: TComponent;
  Resposta: Integer;
begin
  Comp := PageList_Forms.FindComponent('PgForm_'+IntToStr(Item.Tag));
  if Comp <> Nil then
    Posicao_Close := TJvCustomPage(Comp).PageIndex;
  Questionar := False;
  if CurrentEdit.Modified then
  begin
    Resposta := Mensagem('Salvar '+CurrentEdit.FileName+'? ', ModConfirmacao, [ModSim, ModNao, ModCancela]);
    Case Resposta of
      mrYes : begin
                if Possui_DFM then
                  CurrentForm_Avulso(Posicao_Close).VamosGravar := True
                else
                  CurrentEdit.Lines.SaveToFile(CurrentEdit.FileName);
                CurrentEdit.Modified := False;
                FormObjInsp.Atribui(Nil, True);
                FechaForm(Posicao_Close);
                Item.Free;
                if TabForms.Tabs.Count = 0 then
                  Close;
              end;
      mrNo  : begin
                if Possui_DFM then
                  CurrentForm_Avulso(Posicao_Close).VamosGravar := False;
                CurrentEdit.Modified := False;
                FormObjInsp.Atribui(Nil, True);
                FechaForm(Posicao_Close);
                Item.Free;
                if TabForms.Tabs.Count = 0 then
                  Close;
              end;
    else
      begin
        AllowClose := False;
        exit;
      end;
    end;
  end;
end;

procedure TFormDesigner_Net.EnviarparafrenteClick(Sender: TObject);
begin
  FormPrincipal.EnviarparafrenteClick(Self);
end;

procedure TFormDesigner_Net.EnviarparatrasClick(Sender: TObject);
begin
  FormPrincipal.EnviarparatrasClick(Self);
end;

procedure TFormDesigner_Net.RecortarClick(Sender: TObject);
begin
  FormPrincipal.RecortarClick(Self);
end;

procedure TFormDesigner_Net.CopiarClick(Sender: TObject);
begin
  FormPrincipal.CopiarClick(Self);
end;

procedure TFormDesigner_Net.ColarClick(Sender: TObject);
begin
  FormPrincipal.ColarClick(Self);
end;

procedure TFormDesigner_Net.SelecionarTodosClick(Sender: TObject);
begin
  FormPrincipal.SelecionarTudoClick(Self);
end;

procedure TFormDesigner_Net.ExcluirClick(Sender: TObject);
var
  C: TControl;
  Delete_Ev, Confirmado: Boolean;
begin
  if FormDesigner_Net.CurrentPage = 1 then
  with CurrentForm_Avulso.cmpFormDesigner do
  begin
    if ControlCount > 0 then
    begin
      if Shift_Delete then
        Confirmado := True
      else
        if Mensagem('Excluir '+IntToStr(ControlCount)+' objeto(s) ?', ModConfirmacao,[ModSim, ModNao]) = mrYes then
          Confirmado := True
        else
          Confirmado := False;
      if Confirmado then
      begin
        if Shift_Delete then
          Delete_Ev := True
        else
          if Mensagem('Excluir evento(s) associado(s) ?', ModConfirmacao,[ModSim, ModNao]) = mrYes then
            Delete_Ev := True
          else
            Delete_Ev := False;
        while ControlCount>0 do
        begin
          C:=Controls[0];
          if C is TComponentContainer then
          begin
            if Delete_Ev then
              CurrentForm_Avulso.ExcluiObjeto(TComponentContainer(C).Component.Name);
            TComponentContainer(C).Component.Free;
          end
          else
            if Delete_Ev then
              CurrentForm_Avulso.ExcluiObjeto(C.Name);
          C.Free;
        end;
        CurrentEdit.Modified := True;
        CurrentForm_Avulso.Atualiza_CB(True, '', '', Nil);
        FormObjInsp.Atribui(Nil, True);
      end;
    end;
  end;
end;

procedure TFormDesigner_Net.AlinhamentoClick(Sender: TObject);
begin
  FormPrincipal.AlinhamentoClick(Self);
end;

procedure TFormDesigner_Net.DimensoesClick(Sender: TObject);
begin
  FormPrincipal.TamanhoClick(Self);
end;

procedure TFormDesigner_Net.PaletadeAlinhamentoClick(Sender: TObject);
begin
  FormPrincipal.PaletaAlinhamentoClick(Self);
end;

procedure TFormDesigner_Net.AlinharClick(Sender: TObject);
var
  i: Integer;
begin
  with CurrentForm_Avulso.cmpFormDesigner do
    for i:=0 to Pred(ControlCount) do
      if not IsLocked(Controls[i]) then
        AlignToGrid(Controls[i]);
end;

procedure TFormDesigner_Net.PopupDesigPopup(Sender: TObject);
begin
  NovaPagina.Visible := False;
  EditarRelatorio.Visible := False;
  EditarMenu.Visible := False;
  if FormDesigner_Net.CurrentPage = 1 then
    if CurrentForm_Avulso.cmpFormDesigner.ControlCount > 0 then
      if CurrentForm_Avulso.cmpFormDesigner.Controls[0] is TPageControl then
        NovaPagina.Visible := True
      else if CurrentForm_Avulso.cmpFormDesigner.Controls[0] is TComponentContainer then
      begin
        if TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component is TfrReport then
          EditarRelatorio.Visible := True
        else if TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component is TMainMenu then
          EditarMenu.Visible := True
        else if TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component is TPopupMenu then
          EditarMenu.Visible := True
      end;
end;

procedure TFormDesigner_Net.NovaPaginaClick(Sender: TObject);
begin
  CurrentForm_Avulso.NovaPagina;
end;

procedure TFormDesigner_Net.PnEsquerdoResize(Sender: TObject);
var
  r : TRect;
  style : Longint;
begin
  if Assigned(FormObjInsp) and Posiciona_ObjInsp then
  begin
    r := FormPrincipal.ControlBarPaleta.BoundsRect;
    style := GetWindowLong(Self.Handle, GWL_STYLE);
    AdjustWindowRect(r, style, TRUE);
    FormObjInsp.Left   := PnEsquerdo.Left + 1;
    FormObjInsp.Top    := r.bottom - r.top - 7;
    FormObjInsp.Height := PnEsquerdo.Height - 50;   // + 3
    FormObjInsp.Width  := PnEsquerdo.Width - 2;
    Posiciona_ObjInsp  := False;
    if not FormPrincipal.OpcoesdeLayout.Checked then
      FormObjInsp.Hide;
  end;
end;

procedure TFormDesigner_Net.TreeView_ExtraDblClick(Sender: TObject);
var
  Ln_Funcao: TStringList;
  Memo1: TStringList;
begin
  case CurrentPage of
    0: begin
         if TreeView_Extra.Selected <> Nil then
           if TreeView_Extra.Selected.Level = 2 then
           begin
             Ln_Funcao := TStringList.Create;
             Memo1 := TStringList.Create;
             if FileExists(Projeto.PastaGerador + 'Funcoes.Lst') then
             begin
               Memo1.LoadFromFile(Projeto.PastaGerador + 'Funcoes.Lst');
               StringToArray(Memo1[Integer(TreeView_Extra.Selected.Data)],'|',Ln_Funcao);
               CurrentEdit.SelText := Ln_Funcao[2];
             end;
             Ln_Funcao.Free;
             Memo1.Free;
           end;
       end;
  end;
end;

procedure TFormDesigner_Net.TreeView_ExtraClick(Sender: TObject);
begin
  FormObjInsp.Hide;
end;

procedure TFormDesigner_Net.TabOrderClick(Sender: TObject);
begin
  FormPrincipal.TabOrderClick(Self);
end;

procedure TFormDesigner_Net.EditarRelatorioClick(Sender: TObject);
begin
  if CurrentForm_Avulso.cmpFormDesigner.ControlCount > 0 then
    if CurrentForm_Avulso.cmpFormDesigner.Controls[0] is TComponentContainer then
      if TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component is TfrReport then
        TfrReport(TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component).DesignReport;
end;

procedure TFormDesigner_Net.PropriedadesClick(Sender: TObject);
begin
  frmFDSetup := TfrmFDSetup.Create(Application);
  Try
    frmFDSetup.ShowModal;
  Finally
    frmFDSetup.Free;
  end;
end;

procedure TFormDesigner_Net.EditarMenuClick(Sender: TObject);
begin
  if CurrentForm_Avulso.cmpFormDesigner.ControlCount > 0 then
    if CurrentForm_Avulso.cmpFormDesigner.Controls[0] is TComponentContainer then
      if TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component is TMainMenu then
      begin
        CurrentForm_Avulso.NomeMenu := TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component.Name;
        FormMenuEdit_i.MItems := TMenu(TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component).Items;
        FormMenuEdit_i.Show;
      end
      else if TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component is TPopupMenu then
      begin
        CurrentForm_Avulso.NomeMenu := TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component.Name;
        FormMenuEdit_i.MItems := TPopupMenu(TComponentContainer(CurrentForm_Avulso.cmpFormDesigner.Controls[0]).Component).Items;
        FormMenuEdit_i.Show;
      end
end;

procedure TFormDesigner_Net.TabFormsTabSelecting(Sender: TObject;
  Item: TJvTabBarItem; var AllowSelect: Boolean);
begin
  if Possui_DFM then
  begin
    CurrentForm_Avulso.cmpFormDesigner.KeySelect := False;
    CurrentForm_Avulso.cmpFormDesigner.KeyMove   := False;
    CurrentForm_Avulso.cmpFormDesigner.Active    := False;
  end;
end;

procedure TFormDesigner_Net.ExpressoClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
begin
  if FormDesigner_Net.CurrentPage = 0 then
  begin
    FormExpressao := TFormExpressao.Create(Application);
    Try
      if FormExpressao.ShowModal = mrOk then
      begin
        FormDesigner_Net.CurrentEdit.SelText  := FormExpressao.ExprMemo.Text;
        FormDesigner_Net.CurrentEdit.Modified := True;
      end;
    Finally
      FormExpressao.Free;
    end;
  end;
end;

procedure TFormDesigner_Net.CamposClick(Sender: TObject);
begin
  if FormDesigner_Net.CurrentPage = 0 then
  begin
    FormCamposProj := TFormCamposProj.Create(Application);
    Try
      FormCamposProj.Tipo := 1;
      if FormCamposProj.ShowModal = mrOk then
      begin
        if Trim(FormCamposProj.Retorno) <> '' then
        begin
          FormDesigner_Net.CurrentEdit.SelText  := FormCamposProj.Retorno;
          FormDesigner_Net.CurrentEdit.Modified := True;
        end;
      end;
    Finally
      FormCamposProj.Free;
    end;
  end;
end;

procedure TFormDesigner_Net.FormulariosClick(Sender: TObject);
var
  Tipo, I: Integer;
  Nome: String;
begin
  if FormDesigner_Net.CurrentPage = 0 then
  begin
    FormListaForm := TFormListaForm.Create(Application);
    Try
      if FormListaForm.ShowModal = mrOk then
        if FormListaForm.DatasetsLB.ItemIndex > -1 then
        begin
          Tipo := Integer(FormListaForm.DatasetsLB.Items.Objects[FormListaForm.DatasetsLB.ItemIndex]);
          Nome := FormListaForm.DatasetsLB.Items[FormListaForm.DatasetsLB.ItemIndex];
          Nome := Trim(Copy(Nome,01,Pos('-',Nome)-1));
          I := FormDesigner_Net.CurrentEdit.CaretY;
          if (TIPO = 2) or
             (TIPO = 3) or
             (TIPO = 4) or
             (TIPO = 6) or
             (TIPO = 7) then
          begin
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+0,'  Form'+Nome+' := TForm'+Nome+'.Create(Application);');
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+1,'  Try');
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+2,'    Form'+Nome+'.ShowModal;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+3,'  Finally');
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+4,'    Form'+Nome+'.Free;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+5,'  end;');
          end
          else
            FormDesigner_Net.CurrentEdit.Lines.Insert(I+0,'  ExecutaForm(TForm'+Nome+',Form'+Nome+');');
          FormDesigner_Net.CurrentEdit.Modified := True;
        end;
    Finally
      FormListaForm.Free;
    end;
  end;
end;

procedure TFormDesigner_Net.BloquearClick(Sender: TObject);
begin
  FormObjInsp.BtnBloquearClick(Self);
end;

procedure TFormDesigner_Net.ComentarClick(Sender: TObject);
begin
  FormPrincipal.ComentarClick(Self);
end;

procedure TFormDesigner_Net.DescomentarClick(Sender: TObject);
begin
  FormPrincipal.DescomentarClick(Self);
end;

procedure TFormDesigner_Net.ListView_nao_visuaisClick(Sender: TObject);
var
  I: Integer;
begin
  {if ListView_nao_visuais.Selected <> Nil then
  begin
    i := FormObjInsp.CB1.Items.IndexOf(TWinControl(ListView_nao_visuais.Selected.Data).Name + ': ' +TWinControl(ListView_nao_visuais.Selected.Data).ClassName);
    FormObjInsp.CB1.ItemIndex := I;
    CurrentForm_Avulso.CB1Click(Self);
  end;}
end;

procedure TFormDesigner_Net.SelecionarClick(Sender: TObject);
begin
  FormPrincipal.SelecionarClick(Self);
end;

procedure TFormDesigner_Net.ListaParametrosCancelled(Sender: TObject);
begin
  //ListaParametros.ItemList.Text := '';
end;

procedure TFormDesigner_Net.ListaFuncoesCodeCompletion(var Value: String;
  Shift: TShiftState; Index: Integer; EndToken: Char);
var
  Parametros: String;
begin
  Parametros := Copy(ListaFuncoes.ItemList[Index],Pos('(',ListaFuncoes.ItemList[Index])+1,Length(ListaFuncoes.ItemList[Index]));
  Parametros := Copy(Parametros,01,Pos(')',Parametros)-1);
  Parametros := TrocaString(Parametros,',',' ',[rfReplaceAll]);
  Parametros := Parametros + '  ';
  ListaParametros.Form.CurrentIndex := 0;
  if Trim(Parametros) = '' then Parametros := '*Nulo*  ';
  //ListaParametros.ItemList.Add(Parametros);
  ListaParametros.ItemList.Text := Parametros;
end;

procedure TFormDesigner_Net.Atribui_Complete;
var
  Memo1: TSynEdit;
  i: integer;
  Ln_Funcao: TStringList;
  Lista_Aux, Lista_Aux2: TStringList;
  Parametros, Linha: String;
begin
  Lista_Aux := TStringList.Create;
  Lista_Aux2 := TStringList.Create;
  Ln_Funcao := TStringList.Create;
  Memo1 := TSynEdit.Create(Self);
  Memo1.Visible := False;
  Memo1.Parent := Self;
  try
    if FileExists(Projeto.PastaGerador + 'Funcoes.Lst') then
      Memo1.Lines.LoadFromFile(Projeto.PastaGerador + 'Funcoes.Lst');
    for i:=0 to Memo1.Lines.Count-1 do
    begin
      Ln_Funcao.Clear;
      StringToArray(Memo1.Lines[i],'|',Ln_Funcao);
      if (Ln_Funcao.Count = 4) then
      begin
        Lista_Aux.Add(Ln_Funcao[1]);
        Parametros := '';
        if Pos('(',Ln_Funcao[2]) > 0 then
        begin
          Parametros := Copy(Ln_Funcao[2],Pos('(',Ln_Funcao[2]),Length(Ln_Funcao[2]));
          Parametros := Copy(Parametros,01,Pos(')',Parametros));
        end;
        Lista_Aux2.Add('function '#9''+Ln_Funcao[1]+''#9''+Parametros+' - '+Ln_Funcao[3]);
      end;
    end;
    ListaFuncoes.InsertList.Clear;
    ListaFuncoes.ItemList.Clear;
    ListaFuncoes.InsertList.AddStrings(Lista_Aux);
    ListaFuncoes.ItemList.AddStrings(Lista_Aux2);
  finally
    Lista_Aux.Free;
    Lista_Aux2.Free;
    Ln_Funcao.Free;
    Memo1.Free;
  end;
end;

procedure TFormDesigner_Net.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = ')') and (ListaParametros.ItemList.Count > 0) then
  begin
    ListaParametros.CancelCompletion;
    ListaParametros.ItemList.Text := '';
  end
  else if (Key = '(') and (ListaParametros.ItemList.Count > 0) then
    ListaParametros.ActivateCompletion
  else if (Key = ',') and (ListaParametros.ItemList.Count > 0) then
    ListaParametros.Form.CurrentIndex := ListaParametros.Form.CurrentIndex + 1
  else if (Key = '.') then
    ListaFuncoes.CancelCompletion;
end;

end.
