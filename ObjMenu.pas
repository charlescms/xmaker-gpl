unit ObjMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, StdCtrls, Menus, IniFiles, ExtCtrls, Buttons, ToolWin,
  XLookUp, Db, XBanner, XPMenu, ShellApi, XNum, Tabela, SynEdit, ImgList,
  DsnUnit, Mask, ToolEdit;

type
  TFormMenuObject = class(TForm)
    PopInserir: TPopupMenu;
    SubMenu: TMenuItem;
    Formulario: TMenuItem;
    RotinaAvulsa: TMenuItem;
    ProgramaExternoEXE: TMenuItem;
    OpenExe: TOpenDialog;
    DataSource: TDataSource;
    XBanner: TXBanner;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ControlBar: TControlBar;
    ToolBar: TToolBar;
    BtnRedefinir: TToolButton;
    TreeViewMenu: TTreeView;
    TabSheet2: TTabSheet;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    TreeViewMenu_1: TTreeView;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    TabSheet3: TTabSheet;
    ControlBar2: TControlBar;
    ToolBar2: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    TreeViewMenu_2: TTreeView;
    ToolBar3: TToolBar;
    BtnNovo: TToolButton;
    BtnDeletar: TToolButton;
    BtnModificar: TToolButton;
    ToolBar4: TToolBar;
    ToolButton7: TToolButton;
    ToolBar5: TToolBar;
    ToolButton8: TToolButton;
    TextoPAS: TSynEdit;
    TextoDFM: TSynEdit;
    EdImagem: TComboBox;
    LbID: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EdTituloKeyPress(Sender: TObject; var Key: Char);
    procedure ComboImagemMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure BtnDeletarClick(Sender: TObject);
    procedure SubMenuClick(Sender: TObject);
    procedure RotinaAvulsaClick(Sender: TObject);
    procedure TreeViewMenuChange(Sender: TObject; Node: TTreeNode);
    procedure BtnFecharClick(Sender: TObject);
    procedure TreeViewMenuKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeViewMenuDblClick(Sender: TObject);
    procedure FormularioClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnModificarClick(Sender: TObject);
    procedure ProgramaExternoEXEClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAjudaClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure EdImagem_1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnRedefinirClick(Sender: TObject);
  private
    { Private declarations }
    DsnStage0: TDsnStage;
    DsnStage1: TDsnStage;
    DsnStage2: TDsnStage;
    SearchOptions: TSynSearchOptions;
    ID: Integer;
    procedure Arvore(ComTree: Boolean);
    procedure Inserir(Tipo: Integer);
    function GravaMenu: Boolean;
    function Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
    procedure CriaComponentes(Redefinir: Boolean = False);
  public
    { Public declarations }
    TabelaPrincipal: TTabela;
    Arvore_c: TTreeView;
    Modificou: Boolean;
    Novo: Boolean;
    procedure AtualizaTree;
  end;

var
  FormMenuObject: TFormMenuObject;
  IniFile : TIniFile;
  MenuXP: TXPMenu;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01, Abertura, MiniEditor, Aguarde, EdOpMenu;

procedure TFormMenuObject.FormShow(Sender: TObject);
begin

  DsnStage0 := TDsnStage.Create(Self);
  DsnStage0.Parent := Self;
  DsnStage0.Visible := False;
  DsnStage1 := TDsnStage.Create(Self);
  DsnStage1.Parent := Self;
  DsnStage1.Visible := False;
  DsnStage2 := TDsnStage.Create(Self);
  DsnStage2.Parent := Self;
  DsnStage2.Visible := False;

  RegisterClass(TImageList);
  RegisterClass(TMainMenu);
  RegisterClass(TToolBar);
  RegisterClass(TToolButton);

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

  TabGlobal_i.DMENU.Filtro := 'IMAGEM = 80';
  TabGlobal_i.DMENU.AtualizaSql;
  TabGlobal_i.DMENU.First;
  if not TabGlobal_i.DMENU.Eof then
  begin
    TabGlobal_i.DMENU.Filtro := '';
    TabGlobal_i.DMENU.AtualizaSql;
    TabGlobal_i.DMENU.First;
    while not TabGlobal_i.DMENU.Eof do
    begin
      TabGlobal_i.DMENU.Modifica;
      if TabGlobal_i.DMENU.IMAGEM.Conteudo = 82 then
        TabGlobal_i.DMENU.IMAGEM.Conteudo := 18;
      if TabGlobal_i.DMENU.IMAGEM.Conteudo = 31 then
        TabGlobal_i.DMENU.IMAGEM.Conteudo := 7;
      if TabGlobal_i.DMENU.IMAGEM.Conteudo = 13 then
        TabGlobal_i.DMENU.IMAGEM.Conteudo := 19;
      if TabGlobal_i.DMENU.IMAGEM.Conteudo = 81 then
        TabGlobal_i.DMENU.IMAGEM.Conteudo := 17;
      if TabGlobal_i.DMENU.IMAGEM.Conteudo = 83 then
        TabGlobal_i.DMENU.IMAGEM.Conteudo := 20;
      if TabGlobal_i.DMENU.IMAGEM.Conteudo = 80 then
        TabGlobal_i.DMENU.IMAGEM.Conteudo := 16;
      TabGlobal_i.DMENU.Post;
      TabGlobal_i.DMENU.Next;
    end;
  end;

  CriaComponentes;

  Modificou := False;
  Novo      := False;
end;

procedure TFormMenuObject.CriaComponentes(Redefinir: Boolean = False);
var
  I,Y,Seq : Integer;
  FinalBloco, InicioBloco: Boolean;
  NomeComp: String;
  FS , FS2:TStream;
  FinalFluxo: TValueType;
  Comp: TComponent;
  Nivel: Integer;
  Codigo: TStringList;
  Pesquisa: String;
  InicioEvento, InicioBloco1: Integer;
  Fim, Inicio: Boolean;

  procedure CriaDinamicamente(Tipo: Integer);
  begin
    if FileExists(Projeto.Pasta + 'MenuPrincipal.Tmp') then
      DeleteFile(Projeto.Pasta + 'MenuPrincipal.Tmp');
    if FileExists(Projeto.Pasta + 'MenuPrincipal.Txt') then
      DeleteFile(Projeto.Pasta + 'MenuPrincipal.Txt');
    FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'MenuPrincipal.Txt');
    try
      FS2 := TFileStream.Create(Projeto.Pasta + 'MenuPrincipal.Tmp', fmCreate);
      FinalBloco := False;
      FormPrincipal.Texto.Lines.Clear;
      while not FinalBloco do
      begin
        FS := TFileStream.Create(Projeto.Pasta + 'MenuPrincipal.Txt', fmOpenRead);
        ObjectTextToBinary(FS, FS2);
        FS.Free;

        FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'MenuPrincipal.Txt');
        InicioBloco := False;
        FormPrincipal.Texto.Lines.Delete(0);
        while not InicioBloco do
        begin
          if (UpperCase(Copy(FormPrincipal.Texto.Lines[0],01,07)) = 'OBJECT ') or (FormPrincipal.Texto.Lines.Count = 0) then
            InicioBloco := True
          else
            FormPrincipal.Texto.Lines.Delete(0);
          end;
          FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'MenuPrincipal.Txt');
          if FormPrincipal.Texto.Lines.Count < 3 then
            FinalBloco := True;
          FormPrincipal.Texto.Lines.Clear;
      end;
    finally
      FinalFluxo := vaNull;
      FS2.Write(FinalFluxo, SizeOf(FinalFluxo));
      FS2.Free;
    end;
    if Tipo = 1 then
    begin
      if FileExists(Projeto.Pasta + 'MenuPrincipal.Tmp') then
        DsnStage0.LoadFromFile(Projeto.Pasta + 'MenuPrincipal.Tmp');
    end
    else if Tipo = 2 then
    begin
      if FileExists(Projeto.Pasta + 'MenuPrincipal.Tmp') then
        DsnStage1.LoadFromFile(Projeto.Pasta + 'MenuPrincipal.Tmp');
    end
    else if Tipo = 3 then
    begin
      if FileExists(Projeto.Pasta + 'MenuPrincipal.Tmp') then
        DsnStage2.LoadFromFile(Projeto.Pasta + 'MenuPrincipal.Tmp');
    end;
    if FileExists(Projeto.Pasta + 'MenuPrincipal.Tmp') then
      DeleteFile(Projeto.Pasta + 'MenuPrincipal.Tmp');
    if FileExists(Projeto.Pasta + 'MenuPrincipal.Txt') then
      DeleteFile(Projeto.Pasta + 'MenuPrincipal.Txt');
  end;

  procedure IncluirOpcao(Opcao: TMenuItem);
  var
    Titulo_c, Pesquisa: String;
    Z: Integer;
    InicioEvento, InicioBloco: Integer;
    Fim, Inicio: Boolean;
    Codigo: TStringList;
  begin
    Titulo_c := Opcao.Caption;
    Titulo_c := TrocaString(Titulo_c,'&','',[rfReplaceAll]);
    TabGlobal_i.DMENUSUP.Inclui(Nil);
    Inc(Seq);
    Nivel := 0;
    TextoDFM.SearchReplace('object '+Opcao.Name+': TMenuItem','', SearchOptions);
    if TextoDFM.CaretY > 1 then
    begin
      Nivel := Length(Copy(TextoDFM.Lines[TextoDFM.CaretY-1],01,Pos('o',TextoDFM.Lines[TextoDFM.CaretY-1])-5));
      if Nivel > 0 then
        Nivel := Nivel Div 2;
    end;
    TabGlobal_i.DMENUSUP.NUMERO.Conteudo   := Seq;
    TabGlobal_i.DMENUSUP.NOME.Conteudo     := Opcao.Name;
    TabGlobal_i.DMENUSUP.NIVEL_M.Conteudo  := Nivel;
    if Opcao.Count > 0 then
    begin
      TabGlobal_i.DMENUSUP.TIPO.Conteudo   := 1;
      Inc(Nivel);
    end
    else
      TabGlobal_i.DMENUSUP.TIPO.Conteudo   := 3;
    TabGlobal_i.DMENUSUP.TITULO_M.Conteudo := Titulo_c;
    TabGlobal_i.DMENUSUP.IMAGEM.Conteudo   := Opcao.ImageIndex;
    TabGlobal_i.DMENUSUP.IDENTIFICACAO.Conteudo := Opcao.Tag;
    TextoPAS.CaretY := 0;
    TextoPAS.CaretX := 0;
    TextoPAS.SearchReplace('procedure TFormPrincipal.'+Opcao.Name+'Click(Sender: TObject);','', SearchOptions);
    Codigo := TStringList.Create;
    if TextoPAS.CaretY > 1 then  // vamos ver se o evento existe
    begin
      with TextoPAS do
      begin
        InicioEvento := CaretY;
        Fim := False;
        Inicio := False;
        while (not Fim) and (CaretY < Lines.Count-1) do
        begin
          if not Inicio then
            if Pos(');',RetiraBrancos(LineText)) > 0 then
            begin
              Inicio := True;
              InicioBloco := CaretY;
              CaretY := CaretY + 01;
            end;
          if Inicio then
            Codigo.Add(LineText);
          CaretY := CaretY + 01;
          Pesquisa := Trim(UpperCase(LineText));
          if (Copy(Pesquisa,01,04) = 'END.') or
             (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORMPRINCIPAL.') or
             (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORMPRINCIPAL.' ) or
             (Copy(Pesquisa,01,04) = '{99-') then
            Fim := True;
        end;
      end;
    end;
    TabGlobal_i.DMENUSUP.PROG_EXE.Conteudo := ShortCutToText(Opcao.ShortCut);
    TBlobField(TabGlobal_i.DMENUSUP.FieldByName('AVULSO')).AsString := Codigo.Text;
    TabGlobal_i.DMENUSUP.Post;
    Codigo.Free;
    for Z:=0 to Opcao.Count-1 do
      IncluirOpcao(Opcao[Z]);
  end;

begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Lendo definições ...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := 10;
  FormAguarde.GaugeProcesso.Position := 0;

  TextoPAS.Lines.Clear;
  TextoDFM.Lines.Clear;
  FormPrincipal.Texto.Lines.Clear;

  if FileExists(Projeto.Pasta + 'Princ.Pas') then
    TextoPAS.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Pas');

  if FileExists(Projeto.Pasta + 'Princ.Dfm') then
    TextoDFM.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Dfm');
  if not Redefinir then
  begin
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('object ListaImagem: TImageList','', SearchOptions);
    Y := TextoDFM.CaretY - 1;
    if Y > 5 then
      FinalBloco := False
    else
      FinalBloco := True;
    while not FinalBloco do
    begin
      if (UpperCase(TrimRight(TextoDFM.Lines[Y])) = '  END') or
         (Y > TextoDFM.Lines.Count) then
      begin
        FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
        FinalBloco := True;
      end
      else
        FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
      inc(Y);
    end;
    CriaDinamicamente(1);
    FormPrincipal.Texto.Lines.Clear;

    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('object MenuPrincipal: TMainMenu','', SearchOptions);
    Y := TextoDFM.CaretY - 1;
    if Y > 5 then
      FinalBloco := False
    else
      FinalBloco := True;
    while not FinalBloco do
    begin
      if (UpperCase(TrimRight(TextoDFM.Lines[Y])) = '  END') or
         (Y > TextoDFM.Lines.Count) then
      begin
        FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
        FinalBloco := True;
      end
      else
      begin
        if UpperCase(Copy(Trim(TextoDFM.Lines[Y]),01,02)) <> 'ON' then // é um evento
          FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
      end;
      inc(Y);
    end;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
    CriaDinamicamente(2);
  end;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  FormMenuObject.Menu := Nil;
  FormPrincipal.Texto.Lines.Clear;

  if not Redefinir then
  begin
    TextoDFM.CaretX := 1;
    TextoDFM.CaretY := 1;
    TextoDFM.SearchReplace('object BarraFerramentas: TToolBar','', SearchOptions);
    Y := TextoDFM.CaretY - 1;
    if Y > 5 then
      FinalBloco := False
    else
      FinalBloco := True;
    while not FinalBloco do
    begin
      if (UpperCase(TrimRight(TextoDFM.Lines[Y])) = '  END') or
         (Y > TextoDFM.Lines.Count) then
      begin
        FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
        FinalBloco := True;
      end
      else
      begin
        if UpperCase(Copy(Trim(TextoDFM.Lines[Y]),01,02)) <> 'ON' then // é um evento
          FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
      end;
      inc(Y);
    end;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
    CriaDinamicamente(3);
  end;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;

  FormPrincipal.Texto.Lines.Clear;
  //TextoPAS.Lines.Clear;

  TreeViewMenu_1.Items.Clear;

  TabGlobal_i.DMENUSUP.First;
  if Redefinir then
    while not TabGlobal_i.DMENUSUP.eof do
      TabGlobal_i.DMENUSUP.Delete;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  Seq := 0;

  if TabGlobal_i.DMENUSUP.eof then
  begin
    Comp := FindComponent('MenuPrincipal');
    if Comp <> Nil then
      for I:=0 to TMainMenu(Comp).Items.Count-1 do
      begin
        Nivel := 0;
        IncluirOpcao(TMainMenu(Comp).Items[I]);
      end;
  end;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  TextoDFM.Lines.Clear;

  EdImagem.Items.Clear;
  Comp := FindComponent('ListaImagem');
  if Comp <> Nil then
  begin
    TreeViewMenu_1.Images := TCustomImageList(Comp);
    TreeViewMenu_2.Images := TCustomImageList(Comp);
    TreeViewMenu.Images := TCustomImageList(Comp);
    EdImagem.Items.Add('-1');
    for I:=0 to TreeViewMenu.Images.Count-1 do
      EdImagem.Items.Add(IntToStr(I));
  end;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;

  TabGlobal_i.DBARRA.First;
  if Redefinir then
    while not TabGlobal_i.DBARRA.eof do
      TabGlobal_i.DBARRA.Delete;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  Seq := 1;
  if TabGlobal_i.DBARRA.Eof then
  begin
    TabGlobal_i.DBARRA.Inclui(Nil);
    TabGlobal_i.DBARRA.NUMERO.Conteudo        := Seq;
    TabGlobal_i.DBARRA.NIVEL_M.Conteudo       := 0;
    TabGlobal_i.DBARRA.NOME.Conteudo          := 'Bar_1';
    TabGlobal_i.DBARRA.TIPO.Conteudo          := 3;
    TabGlobal_i.DBARRA.TITULO_M.Conteudo      := 'Barra de Ferramentas';
    TabGlobal_i.DBARRA.IMAGEM.Conteudo        := 16;
    TabGlobal_i.DBARRA.IDENTIFICACAO.Conteudo := 1;
    TabGlobal_i.DBARRA.Post;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
    Comp := FindComponent('BarraFerramentas');
    if Comp <> Nil then
      for I:=0 to TToolBar(Comp).ButtonCount-1 do
      begin
        Inc(Seq);
        TabGlobal_i.DBARRA.Inclui(Nil);
        TabGlobal_i.DBARRA.NUMERO.Conteudo        := Seq;
        TabGlobal_i.DBARRA.NIVEL_M.Conteudo       := 0;
        TabGlobal_i.DBARRA.NOME.Conteudo          := TToolBar(Comp).Buttons[I].Name;
        TabGlobal_i.DBARRA.TIPO.Conteudo          := 3;
        TabGlobal_i.DBARRA.TITULO_M.Conteudo      := TToolBar(Comp).Buttons[I].Caption;
        TabGlobal_i.DBARRA.IMAGEM.Conteudo        := TToolBar(Comp).Buttons[I].ImageIndex;
        TabGlobal_i.DBARRA.IDENTIFICACAO.Conteudo := TToolBar(Comp).Buttons[I].Tag;
        TextoPAS.CaretY := 0;
        TextoPAS.CaretX := 0;
        TextoPAS.SearchReplace('procedure TFormPrincipal.'+TToolBar(Comp).Buttons[I].Name+'Click(Sender: TObject);','', SearchOptions);
        Codigo := TStringList.Create;
        if TextoPAS.CaretY > 1 then  // vamos ver se o evento existe
        begin
          with TextoPAS do
          begin
            InicioEvento := CaretY;
            Fim := False;
            Inicio := False;
            while (not Fim) and (CaretY < Lines.Count-1) do
            begin
              if not Inicio then
                if Pos(');',RetiraBrancos(LineText)) > 0 then
                begin
                  Inicio := True;
                  InicioBloco1 := CaretY;
                  CaretY := CaretY + 01;
                end;
              if Inicio then
                Codigo.Add(LineText);
              CaretY := CaretY + 01;
              Pesquisa := Trim(UpperCase(LineText));
              if (Copy(Pesquisa,01,04) = 'END.') or
                 (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORMPRINCIPAL.') or
                 (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORMPRINCIPAL.' ) or
                 (Copy(Pesquisa,01,04) = '{99-') then
                Fim := True;
            end;
          end;
        end;
        TBlobField(TabGlobal_i.DBARRA.FieldByName('AVULSO')).AsString := Codigo.Text;
        Codigo.Free;
        TabGlobal_i.DBARRA.Post;
      end;
  end;
  TextoPas.Lines.Clear;
  TextoDfm.Lines.Clear;

  PageControl1.ActivePageIndex := 2;
  PageControl1Change(Self);
  Arvore(True);

  PageControl1.ActivePageIndex := 1;
  PageControl1Change(Self);
  Arvore(True);

  PageControl1.ActivePageIndex := 0;
  PageControl1Change(Self);
  Arvore(True);

  Arvore_c.Items[0].Selected := True;

  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  FormAguarde.Free;
end;

procedure TFormMenuObject.EdTituloKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormMenuObject.Inserir(Tipo: Integer);
var
  Nivel, I, Posicao, TipoM, PosicaoID: Integer;
  AposMenu, Achou, SubMenu, UltItem, MenuVazio, UltMenu : Boolean;
  NodeAt : Integer;
  Titulo : String;
  PosCont, Image: Integer;
  SomaID: Variant;
begin
  if Arvore_c.Selected = nil then
  begin
    Mensagem('Posição não selecionada !',ModAdvertencia, [ModOk]);
    abort;
  end;
  I        := Arvore_c.Selected.AbsoluteIndex;
  AposMenu := False;
  SubMenu  := False;
  if TabelaPrincipal.FieldByName('TIPO').AsInteger = 1 then
  begin
    SubMenu := True;
    if Mensagem('Inserir Item Dentro do '+#39+TabelaPrincipal.FieldByName('TITULO_M').AsString+#39+
       '?',ModConfirmacao,[ModSim, ModNao]) = mrYes then
      AposMenu := False
    else
      AposMenu := True;
  end;
  Posicao   := TabelaPrincipal.FieldByName('NUMERO').AsInteger;
  Nivel     := TabelaPrincipal.FieldByName('NIVEL_M').AsInteger;
  TipoM     := TabelaPrincipal.FieldByName('TIPO').AsInteger;
  MenuVazio := False;
  UltMenu   := False;
  if (SubMenu) and (not AposMenu) then
    Inc(Nivel);
  TabelaPrincipal.Next;
  if TabelaPrincipal.Eof then
  begin
    UltItem   := True;
    UltMenu   := True;
    if TipoM = 1 then
      MenuVazio := True;
  end
  else
    if TabelaPrincipal.FieldByName('NIVEL_M').AsInteger <> Nivel then
    begin
      UltItem := True;
      if (TipoM = 1) and (TabelaPrincipal.FieldByName('NIVEL_M').AsInteger < Nivel) then
        MenuVazio := True;
    end
    else
      UltItem := False;
  PosCont   := 0;
  Achou     := False;
  if (SubMenu) and (AposMenu) and (not TabelaPrincipal.Eof) then
  begin
    while (not TabelaPrincipal.Eof) and (not Achou) do
    begin
      Inc(PosCont);                                       // =
      if TabelaPrincipal.FieldByName('NIVEL_M').AsInteger <= Nivel then
      begin
        if TabelaPrincipal.FieldByName('NIVEL_M').AsInteger < Nivel then
          PosCont := 0; //Dec(PosCont);
        Posicao := TabelaPrincipal.FieldByName('NUMERO').AsInteger - 1;
        Achou   := True;
      end;
      TabelaPrincipal.Next;
    end;
    if not Achou then
    begin
      Posicao := TabelaPrincipal.FieldByName('NUMERO').AsInteger;
      UltMenu := True;
    end;
  end;
  TabelaPrincipal.Last;
  while (not TabelaPrincipal.Bof) and (TabelaPrincipal.FieldByName('NUMERO').AsInteger > Posicao) do
  begin
    TabelaPrincipal.Modifica;
    TabelaPrincipal.FieldByName('NUMERO').AsInteger := TabelaPrincipal.FieldByName('NUMERO').AsInteger + 1;
    TabelaPrincipal.Post;
    TabelaPrincipal.Prior;
    Modificou := True;
  end;
  Titulo := 'Novo ...';
  TabelaPrincipal.Last;
  PosicaoID := TabelaPrincipal.FieldByName('NUMERO').AsInteger + 1;
  if PTabela(TabelaPrincipal, ['MAX(IDENTIFICACAO)'], '', SomaID) then
    PosicaoID := SomaID[0] + 1;
  TabelaPrincipal.Inclui(Nil);
  TabelaPrincipal.FieldByName('NUMERO').AsInteger   := Posicao + 1;
  TabelaPrincipal.FieldByName('NIVEL_M').AsInteger  := Nivel;
  TabelaPrincipal.FieldByName('TITULO_M').AsString  := Titulo;
  if PageControl1.ActivePageIndex = 0 then
    TabelaPrincipal.FieldByName('NOME').AsString     := 'Menu_'+IntToStr(Posicao+1)
  else if PageControl1.ActivePageIndex = 1 then
    TabelaPrincipal.FieldByName('NOME').AsString     := 'Mnu_'+IntToStr(Posicao+1)
  else if PageControl1.ActivePageIndex = 2 then
    TabelaPrincipal.FieldByName('NOME').AsString     := 'Bar_'+IntToStr(Posicao+1);
  TabelaPrincipal.FieldByName('TIPO').AsInteger     := Tipo;
  TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger := PosicaoID;
  if Tipo = 1 then
  begin
    if PageControl1.ActivePageIndex = 0 then
      TabelaPrincipal.FieldByName('IMAGEM').AsInteger := 16
    else
      TabelaPrincipal.FieldByName('IMAGEM').AsInteger := -1;
  end
  else if Tipo = 2 then
    TabelaPrincipal.FieldByName('IMAGEM').AsInteger := 17
  else if Tipo = 3 then
    TabelaPrincipal.FieldByName('IMAGEM').AsInteger := 17
  else if Tipo = 4 then
    TabelaPrincipal.FieldByName('IMAGEM').AsInteger := 20;
  TabelaPrincipal.Post;
  Modificou := True;
  TabelaPrincipal.AtualizaSql;

  if not Achou then
    NodeAt := Arvore_c.Items.Count
  else
    NodeAt := Arvore_c.Selected.AbsoluteIndex + PosCont;
  if not AposMenu then
    NodeAt := Arvore_c.Selected.AbsoluteIndex + 1;

  if AposMenu then
  begin
    if UltMenu then
      Arvore_c.Items.AddObject(Arvore_c.Selected,Titulo,TObject(StrToInt(FloatToStr(ID))))
    else
    begin
      Arvore_c.Items[NodeAt].Selected := True;
      if PosCont > 0 then
        Arvore_c.Items.InsertObject(Arvore_c.Selected,Titulo, TObject(StrToInt(FloatToStr(ID))))
      else
      begin
        NodeAt := Arvore_c.Items.AddObject(Arvore_c.Selected,Titulo, TObject(StrToInt(FloatToStr(ID)))).AbsoluteIndex;
        //NodeAt := Arvore_c.Selected.AbsoluteIndex + 1;
      end;
    end;
  end
  else
  begin
    if UltItem then
    begin
      if SubMenu then
        Arvore_c.Items.AddChildObject(Arvore_c.Selected,Titulo,TObject(StrToInt(FloatToStr(ID))))
      else
        Arvore_c.Items.AddObject(Arvore_c.Selected,Titulo,TObject(StrToInt(FloatToStr(ID))));
    end
    else
    begin
      if MenuVazio then
        Arvore_c.Items.AddChildObject(Arvore_c.Selected,Titulo,TObject(StrToInt(FloatToStr(ID))))
      else
      begin
        Arvore_c.Items[NodeAt].Selected := True;
        Arvore_c.Items.InsertObject(Arvore_c.Selected,Titulo, TObject(StrToInt(FloatToStr(ID))));
      end;
    end;
  end;
  Arvore_c.Items[NodeAt].Selected := True;
  Image := TabelaPrincipal.FieldByName('IMAGEM').AsInteger;
  Arvore_c.Selected.ImageIndex := Image;
  Arvore_c.Selected.SelectedIndex := Image;

  Novo := True;
  TreeViewMenuDblClick(Self);
end;

procedure TFormMenuObject.arvore(ComTree: Boolean);
var
  UltNivel,Imagem,Nivel,Y,I : Integer;
  Titulo: String;
  Identif: Integer;
  NodeM : TTreeNode ;
  MtNode : Array[0..20] of TTreeNode;
  Ordem : Array[0..20] of Integer;
  SubMenu: Boolean;
  PosAt: Integer;
begin
  Screen.Cursor := crHourGlass;
  if ComTree then
    Arvore_c.Items.Clear;
  TabelaPrincipal.Filtro := '';
  TabelaPrincipal.AtualizaSql;
  TabelaPrincipal.First;
  if TabelaPrincipal.Eof then
  begin
    TabelaPrincipal.Inclui(Nil);
    TabelaPrincipal.FieldByName('NUMERO').AsInteger   := 1;
    TabelaPrincipal.FieldByName('NIVEL_M').AsInteger  := 0;
    TabelaPrincipal.FieldByName('TITULO_M').AsString  := 'Novo ...';
    TabelaPrincipal.FieldByName('TIPO').AsInteger     := 1;
    if PageControl1.ActivePageIndex = 0 then
      TabelaPrincipal.FieldByName('NOME').AsString    := 'Menu_1'
    else if PageControl1.ActivePageIndex = 1 then
      TabelaPrincipal.FieldByName('NOME').AsString    := 'Mnu_1'
    else if PageControl1.ActivePageIndex = 2 then
    begin
      TabelaPrincipal.FieldByName('NOME').AsString    := 'Bar_1';
      TabelaPrincipal.FieldByName('TITULO_M').AsString  := 'Barra de Ferramentas';
      TabelaPrincipal.FieldByName('TIPO').AsInteger     := 3;
    end;
    TabelaPrincipal.FieldByName('IMAGEM').AsInteger   := 16;
    TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger := 1;
    TabelaPrincipal.Post;
    TabelaPrincipal.First;
  end;
  Y := 0;
  while not TabelaPrincipal.Eof do
  begin
    Nivel  := TabelaPrincipal.FieldByName('NIVEL_M').AsInteger;
    Titulo := TabelaPrincipal.FieldByName('TITULO_M').AsString;
    Identif := TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger;
    if ComTree then
    begin
      Imagem := TabelaPrincipal.FieldByName('IMAGEM').AsInteger;
      //if Imagem < 1 then
      //  Imagem := 81;
      if TabelaPrincipal.FieldByName('TIPO').AsInteger = 1 then
      begin
        //Imagem := 80;
        if Nivel = 0 then
          NodeM := Arvore_c.Items.AddObject(nil, Titulo, TObject(Identif))
        else
        begin
          if (SubMenu) and (Nivel > UltNivel) then
            NodeM := Arvore_c.Items.AddChildObjectFirst(Arvore_c.Items[Arvore_c.Items.Count-1], Titulo, TObject(Identif))
          else
            if Nivel < UltNivel then
              NodeM := Arvore_c.Items.AddObject(Arvore_c.Items[Ordem[Nivel]], Titulo, TObject(Identif))
            else
              NodeM := Arvore_c.Items.AddObject(Arvore_c.Items[Arvore_c.Items.Count-1], Titulo, TObject(Identif));
        end;
        Ordem[Nivel] := Arvore_c.Items.Count-1;
        Arvore_c.Items[Arvore_c.Items.Count-1].ImageIndex    := Imagem;
        Arvore_c.Items[Arvore_c.Items.Count-1].SelectedIndex := Imagem;
        MtNode[Nivel] := NodeM;
        SubMenu := True;
        UltNivel := Nivel;
      end
      else
      begin
        if Nivel = 0 then
          Arvore_c.Items.AddChildObject(nil, Titulo, TObject(Identif))
        else
          Arvore_c.Items.AddChildObject(MtNode[Nivel-1], Titulo, TObject(Identif));
        Arvore_c.Items[Arvore_c.Items.Count-1].ImageIndex    := Imagem;
        Arvore_c.Items[Arvore_c.Items.Count-1].SelectedIndex := Imagem;
        SubMenu := False;
        UltNivel := Nivel;
      end;
    end
    else
    begin
      Inc(Y);
      TabelaPrincipal.Modifica;
      TabelaPrincipal.FieldByName('NUMERO').AsInteger := Y;
      if PageControl1.ActivePageIndex = 0 then
        TabelaPrincipal.FieldByName('NOME').AsString   := 'Menu_'+IntToStr(Y)
      else if PageControl1.ActivePageIndex = 1 then
      begin
        case TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger of
          18 : TabelaPrincipal.FieldByName('NOME').AsString := 'Manutencao';
          19 : TabelaPrincipal.FieldByName('NOME').AsString := 'Localizar';
          20 : TabelaPrincipal.FieldByName('NOME').AsString := 'Incluir';
          21 : TabelaPrincipal.FieldByName('NOME').AsString := 'Modificar';
          22 : TabelaPrincipal.FieldByName('NOME').AsString := 'Excluir';
          24 : TabelaPrincipal.FieldByName('NOME').AsString := 'Primeiro';
          25 : TabelaPrincipal.FieldByName('NOME').AsString := 'Anterior';
          26 : TabelaPrincipal.FieldByName('NOME').AsString := 'Proximo';
          27 : TabelaPrincipal.FieldByName('NOME').AsString := 'Ultimo';
          28 : TabelaPrincipal.FieldByName('NOME').AsString := 'Consulta';
          29 : TabelaPrincipal.FieldByName('NOME').AsString := 'Filtrar';
          30 : TabelaPrincipal.FieldByName('NOME').AsString := 'Ordenar';
          31 : TabelaPrincipal.FieldByName('NOME').AsString := 'OrdenarComposto';
          33 : TabelaPrincipal.FieldByName('NOME').AsString := 'ApagarColuna';
          35 : TabelaPrincipal.FieldByName('NOME').AsString := 'Quantificar';
          36 : TabelaPrincipal.FieldByName('NOME').AsString := 'TotalizarColuna';
          37 : TabelaPrincipal.FieldByName('NOME').AsString := 'CalcularMedia';
          39 : TabelaPrincipal.FieldByName('NOME').AsString := 'Imprimir';
          40 : TabelaPrincipal.FieldByName('NOME').AsString := 'SalvarConsulta';
          41 : TabelaPrincipal.FieldByName('NOME').AsString := 'ExcluirConsulta';
          42 : TabelaPrincipal.FieldByName('NOME').AsString := 'mnu_Janelas';
        else
          TabelaPrincipal.FieldByName('NOME').AsString   := 'Mnu_'+IntToStr(Y);
        end;
      end
      else if PageControl1.ActivePageIndex = 2 then
        TabelaPrincipal.FieldByName('NOME').AsString   := 'Bar_'+IntToStr(Y);
      TabelaPrincipal.Post;
    end;
    TabelaPrincipal.Next;
  end;
  if ComTree then
  begin
    Arvore_c.FullExpand;
    Arvore_c.SetFocus;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFormMenuObject.ComboImagemMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := 20;
end;

procedure TFormMenuObject.BtnDeletarClick(Sender: TObject);
var
  Nivel, Posicao: Integer;
  Achou, SubMenu : Boolean;
  Ident: Integer;
begin
  if Arvore_c.Selected = nil then
  begin
    Mensagem('Posição não selecionada !',ModAdvertencia, [ModOk]);
    abort;
  end;
  if PageControl1.ActivePageIndex = 2 then
    if Arvore_c.Selected.AbsoluteIndex = 0 then
      exit;
  if PageControl1.ActivePageIndex = 1 then
  begin
    Ident := TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger;
    if ((Ident >= 18) and (Ident <= 22)) or
       ((Ident >= 24) and (Ident <= 31)) or
       ((Ident >= 35) and (Ident <= 37)) or
       ((Ident >= 39) and (Ident <= 42)) or
       (Ident = 33) then
    begin
      Mensagem('Integridade - Opção não pode ser excluída !',ModAdvertencia,[modOk]); 
      exit;
    end;
  end;
  if not Novo then
    if Mensagem('Excluir '+TabelaPrincipal.FieldByName('TITULO_M').AsString+ ' ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
       Exit;
  if TabelaPrincipal.FieldByName('TIPO').AsInteger = 1 then
    SubMenu := True
  else
    SubMenu := False;
  Nivel   := TabelaPrincipal.FieldByName('NIVEL_M').AsInteger;
  Posicao := TabelaPrincipal.FieldByName('NUMERO').AsInteger;
  if SubMenu then
  begin
    TabelaPrincipal.First;
    Achou := False;
    while (not TabelaPrincipal.Eof) and (not Achou) do
    begin
      if (TabelaPrincipal.FieldByName('NIVEL_M').AsInteger >= Nivel) and (TabelaPrincipal.FieldByName('NUMERO').AsInteger >= Posicao) then
      begin
        TabelaPrincipal.Delete;
        if TabelaPrincipal.FieldByName('NIVEL_M').AsInteger <= Nivel then
          Achou := True;
      end
      else
        TabelaPrincipal.Next;
    end;
  end
  else
    TabelaPrincipal.Delete;

  Modificou := True;
  TabelaPrincipal.AtualizaSql;
  Arvore_c.Items.Delete(Arvore_c.Selected);
  if Arvore_c.Items.Count <= 0 then
    Arvore(True);
end;

procedure TFormMenuObject.SubMenuClick(Sender: TObject);
begin
  Inserir(1);
end;

procedure TFormMenuObject.RotinaAvulsaClick(Sender: TObject);
begin
  Inserir(3);
end;

procedure TFormMenuObject.TreeViewMenuChange(Sender: TObject;
  Node: TTreeNode);
begin
  AtualizaTree;
end;

procedure TFormMenuObject.AtualizaTree;
var
  I, C: Integer;
begin
  if Arvore_C.Selected = Nil then exit;
  I := Arvore_c.Selected.AbsoluteIndex;
  TabelaPrincipal.First;
  C := 0;
  while (not TabelaPrincipal.Eof) and (C <> I) do
  begin
    if C <> I then
    begin
      Inc(C);
      TabelaPrincipal.Next;
    end;
  end;
  ID := TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger;
  LbID.Caption := 'ID.: ' + IntToStr(ID);
end;

procedure TFormMenuObject.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMenuObject.TreeViewMenuKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then { Del }
    BtnDeletarClick(Self)
  else if Key = 45 then { Ins }
    BtnNovo.CheckMenuDropdown
  else if Key = 113 then { F2 }
    TreeViewMenuDblClick(Self);
  if Key = VK_F5 then   // Calendário
    FormPrincipal.CalendarioClick(Self)
  else if Key = VK_F6 then // Calculadora
    FormPrincipal.CalculadoraClick(Self)
  else if Key = VK_F7 then // Diário
    FormPrincipal.DiarioProjetoClick(Self)
  else if Key = VK_F1 then // Agenda
    FormPrincipal.ConteudoClick(Self);
end;

procedure TFormMenuObject.TreeViewMenuDblClick(Sender: TObject);
begin
  BtnModificarClick(Self);
end;

procedure TFormMenuObject.FormularioClick(Sender: TObject);
begin
  Inserir(2);
end;

procedure TFormMenuObject.BtnGravarClick(Sender: TObject);
begin
  if GravaMenu then
    Close;
end;

function TFormMenuObject.GravaMenu: Boolean;
Var
  I: Integer;
begin
  Result := False;
  if C_CRACK then
  begin
    Mensagem(MSG_CRACK,ModErro,[ModOk]);
    exit;
  end;
  PageControl1.ActivePageIndex := 0;
  PageControl1Change(Self);
  Arvore(False);

  PageControl1.ActivePageIndex := 1;
  PageControl1Change(Self);
  Arvore(False);

  PageControl1.ActivePageIndex := 2;
  PageControl1Change(Self);
  Arvore(False);

  Modificou     := False;
  StrCompTree   := ComponentToString(TreeViewMenu);
  Screen.Cursor := crHourGlass;
  TabGlobal_i.DMENU.Transaction.CommitRetaining;
  TabGlobal_i.DMENUSUP.Transaction.CommitRetaining;
  TabGlobal_i.DBARRA.Transaction.CommitRetaining;
  Gera_Princ(False,2);
  Gera_Princ_MenuSuperior;
  Gera_Princ_BarraF;
  StrCompTree   := ComponentToString(TreeViewMenu_1);
  Gera_Princ_TreeMenuSup;
  Screen.Cursor := crDefault;
  Result := True;
end;

procedure TFormMenuObject.BtnModificarClick(Sender: TObject);
begin
  if Arvore_c.Selected = Nil then exit;
  if PageControl1.ActivePageIndex = 2 then
    if Arvore_c.Selected.AbsoluteIndex = 0 then
      exit;

  FormEdOpMenu := TFormEdOpMenu.Create(Application);
  Try
    case PageControl1.ActivePageIndex of
      0 : begin
            FormEdOpMenu.PageControl1.ActivePageIndex := 0;
            FormEdOpMenu.TabSheet2.TabVisible := False;
            FormEdOpMenu.TabSheet3.TabVisible := False;
          end;
      1 : begin
            FormEdOpMenu.PageControl1.ActivePageIndex := 1;
            FormEdOpMenu.TabSheet1.TabVisible := False;
            FormEdOpMenu.TabSheet3.TabVisible := False;
          end;
      2 : begin
            FormEdOpMenu.PageControl1.ActivePageIndex := 2;
            FormEdOpMenu.TabSheet1.TabVisible := False;
            FormEdOpMenu.TabSheet2.TabVisible := False;
          end;
    end;
    TabelaPrincipal.Modifica;
    FormEdOpMenu.ShowModal;
  Finally
    FormEdOpMenu.Free;
  end;
end;

procedure TFormMenuObject.ProgramaExternoEXEClick(Sender: TObject);
begin
  Inserir(4);
end;

procedure TFormMenuObject.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Modificou then
  begin
    if Mensagem('Salvar Modificações ?',modConfirmacao,[modSim,modNao]) = mrYes then
    begin
      if not GravaMenu then
        Action := caNone;
    end
    else
    begin
      TabGlobal_i.DMENU.Transaction.RollbackRetaining;
      TabGlobal_i.DMENUSUP.Transaction.RollbackRetaining;
      TabGlobal_i.DBARRA.Transaction.RollbackRetaining;
    end;
  end;
  MenuXp.Free;
  DsnStage0.Free;
  DsnStage1.Free;
  DsnStage2.Free;
end;

procedure TFormMenuObject.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;
end;

procedure TFormMenuObject.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
  begin
    SubMenu.Visible := True;
    Formulario.Visible := True;
    ProgramaExternoEXE.Visible := True;
    Arvore_C := TreeViewMenu;
    TabelaPrincipal := TabGlobal_i.DMENU;
    DataSource.DataSet := TabGlobal_i.DMENU;
    TabGlobal_i.DFORMULARIO.Filtro := '';
    TabGlobal_i.DFORMULARIO.AtualizaSql;
  end
  else if PageControl1.ActivePageIndex = 1 then
  begin
    SubMenu.Visible := True;
    Formulario.Visible := False;
    ProgramaExternoEXE.Visible := False;
    Arvore_C := TreeViewMenu_1;
    TabelaPrincipal := TabGlobal_i.DMENUSUP;
    DataSource.DataSet := TabGlobal_i.DMENUSUP;
    TabGlobal_i.DFORMULARIO.Filtro := '';
    TabGlobal_i.DFORMULARIO.AtualizaSql;
  end
  else if PageControl1.ActivePageIndex = 2 then
  begin
    SubMenu.Visible := False;
    Formulario.Visible := False;
    ProgramaExternoEXE.Visible := False;
    Arvore_C := TreeViewMenu_2;
    TabelaPrincipal := TabGlobal_i.DBARRA;
    DataSource.DataSet := TabGlobal_i.DBARRA;
    TabGlobal_i.DFORMULARIO.Filtro := '';
    TabGlobal_i.DFORMULARIO.AtualizaSql;
  end;
  AtualizaTree;
end;

function TFormMenuObject.Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
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

procedure TFormMenuObject.EdImagem_1DrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  Image: TImage;
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TComboBox(Control) do
  begin
    Canvas.FillRect(ARect);
    if Items[Index] <> '-1' then
    begin
      Image := TImage.Create(Self);
      TreeViewMenu_1.Images.GetBitmap(Index-1,Image.Picture.BitMap);
      if Image <> nil then
        Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
         Image.Picture.Bitmap.TransparentColor);
      Image.Free;
    end;
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormMenuObject.BtnRedefinirClick(Sender: TObject);
begin
  if Mensagem('Redefinir Menu Superior && Barra de Ferramentas ?'+^M+^M+'O X-Maker irá ler diretamente do arquivo fonte "Princ.Pas"'
              +^M+'e as definições atuais serão substituídas.',modConfirmacao,[modSim,modNao]) = mrYes then
  begin
    CriaComponentes(True);
    Modificou := True;
  end;
end;

end.
