unit Form_Rel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DsnUnit, DsnSelect, DsnSubMl, DsnSubGr, DsnSubDp, ExtCtrls, IniFiles, DsnProp,
  StdCtrls, Buttons, DsnPanel, XDate, XNum, Mask, XEdit, XBanner, ComCtrls,
  CheckLst, dbctrls, Gauges, dbgrids, grids, XDBDate, XDBEdit, XDBNum, XLookUp,
  Menus, SynEdit, SynEditKeyCmds, TypInfo;

type
  TFormDialogo_Rel = class(TForm)
    DsnStage0: TDsnStage;
    DsnRegister: TDsnDpRegister;
    DsnSelect: TDsnSelect;
    DsnPanel1: TDsnPanel;
    Dpst_TLabel: TLabel;
    DsnDpstPanel: TPanel;
    ArrowButton1: TArrowButton;
    DsnLabel: TDsnButton;
    Panel1: TPanel;
    Dpst_TBitBtn: TBitBtn;
    DsnBitBtn: TDsnButton;
    Dpst_TSpeedButton: TSpeedButton;
    DsnSpeedButton: TDsnButton;
    Dpst_TListBox: TListBox;
    DsnListBox: TDsnButton;
    Dpst_TGroupBox: TGroupBox;
    DsnGroupBox: TDsnButton;
    Dpst_TRadioGroup: TRadioGroup;
    DsnRadioGroup: TDsnButton;
    Dpst_TPanel: TPanel;
    DsnPanel: TDsnButton;
    Dpst_TBevel: TBevel;
    DsnBevel: TDsnButton;
    Dpst_TCheckListBox: TCheckListBox;
    DsnCheckListBox: TDsnButton;
    Dpst_TProgressBar: TProgressBar;
    DsnProgressBar: TDsnButton;
    Dpst_TXBanner: TXBanner;
    DsnXBanner: TDsnButton;
    Dpst_TXEdit: TXEdit;
    DsnXEdit: TDsnButton;
    Dpst_TXNumEdit: TXNumEdit;
    DsnXNumEdit: TDsnButton;
    Dpst_TXDateEdit: TXDateEdit;
    DsnXDateEdit: TDsnButton;
    Dpst_TMemo: TMemo;
    DsnMemo: TDsnButton;
    Dpst_TCheckBox: TCheckBox;
    DsnCheckBox: TDsnButton;
    Dpst_TComboBox: TComboBox;
    DsnComboBox: TDsnButton;
    Dpst_TPageControl: TPageControl;
    DsnPageControl: TDsnButton;
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
    TextoTXT: TSynEdit;
    Texto_Tela: TSynEdit;
    procedure FormShow(Sender: TObject);
    procedure DsnStage0ControlCreate(Sender: TObject;
      Component: TComponent);
    procedure DsnLabelClick(Sender: TObject);
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DsnStage0DeleteQuery(Sender: TObject; Component: TComponent;
      var CanDelete: Boolean);
    procedure DsnStage0MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DsnStage0MoveQuery(Sender: TObject; Component: TComponent;
      var CanMove: Boolean);
    procedure DsnStage0SelectQuery(Sender: TObject; Component: TComponent;
      var CanSelect: TSelectAccept);
    procedure DsnSelectChangeSelected(Sender: TObject;
      Targets: TSelectedComponents; Operation: TSelectOperation);
  private
    { Private declarations }
    CompPageControl: TWinControl;
    procedure AtribuiExtras(Nome: String; Pagina: Integer; Tipo: String;
                            Linha, Coluna, Largura, Altura: Integer);
    function CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
                             GravaFRM: Boolean; Campo: String; TipoCampo: String; AtInspector: Boolean):TComponent;
    function UniqueName(comp:TComponent; Tipo:String):string;
    procedure ExcluiObjeto(Nome: String; Eventos: Boolean);
    function Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
  public
    { Public declarations }
    VamosGravar: Boolean;
    ListaEventos, ListaInvisivel, ListaDesabilitado: TStringList;
    ExcluiTodos, ExcluiTodosEv: Boolean;
    ExcluiComp: Boolean;
    Erro_Formulario: Boolean;
    ListaSelecionados: TList;
    Thread_ok: Boolean;
    CompBotao: Boolean;
    SearchOptions: TSynSearchOptions;
    SearchOptionsPd: TSynSearchOptions;
    NomeObjetoAtual: String;
    ObjetoAtual: TObject;
    TipoObjeto: String;
    NomeForm: String;
    procedure PageControl_NovaPagina;
    procedure Define_TabOrder;
    procedure AtualizaLista_CB;
    procedure AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
  end;

var
  FormDialogo_Rel: TFormDialogo_Rel;

implementation

uses ObjInsp_r, Rotinas, Abertura, TabOrdem, Princ, Relator, Gera_01, Aguarde;

{$R *.DFM}

procedure TFormDialogo_Rel.FormShow(Sender: TObject);
var
  IniFile: TIniFile;
  I, Y, T, Tamanho: Integer;
  FinalFluxo: TValueType;
  ListaTabOrder: TStringList;
  Component: TComponent;
  Data: Pointer;
  FS , FS2:TStream;
  Ok: Boolean;
  InicioBloco, FinalBloco: Boolean;
  NomeComp, Linha: String;

  procedure Registra_Classes;
  begin
    RegisterClass(TRadioButton);    RegisterClass(TDBNavigator);
    RegisterClass(TListBox);        RegisterClass(TEdit);
    RegisterClass(TImage);          RegisterClass(TShape);
    RegisterClass(TBevel);          RegisterClass(TGauge);
    RegisterClass(TProgressBar);    RegisterClass(TRichEdit);
    RegisterClass(TScrollBox);      RegisterClass(TSpeedButton);
    RegisterClass(TComboBox);       RegisterClass(TCheckBox);
    RegisterClass(TRadioGroup);     RegisterClass(TCheckListBox);
    RegisterClass(TDBMemo);         RegisterClass(TMemo);
    RegisterClass(TDBImage);        RegisterClass(TXBanner);
    RegisterClass(TDBRadioGroup);   RegisterClass(TDBCheckBox);
    RegisterClass(TDBComboBox);     RegisterClass(TButton);
    RegisterClass(TLabel);          RegisterClass(TXDateEdit);
    RegisterClass(TPanel);          RegisterClass(TGroupBox);
    RegisterClass(TBitBtn);         RegisterClass(TDBGrid);
    RegisterClass(TDBEdit);         RegisterClass(TDBText);
    RegisterClass(TDBListBox);      RegisterClass(TDBLookupListBox);
    RegisterClass(TDBRichEdit);     RegisterClass(TDBLookupComboBox);
    RegisterClass(TStringGrid);     RegisterClass(TXDBDateEdit);
    RegisterClass(TDrawGrid);       RegisterClass(TXDBEdit);
    RegisterClass(TXEdit);          RegisterClass(TXDBNumEdit);
    RegisterClass(TXNumEdit);       RegisterClass(TXDBLookUp);
    RegisterClass(TTabSheet);
  end;

  procedure Ler_Tela;
  begin
    FormRelatorio.TextoDFM.CaretY := 0;
    FormRelatorio.TextoDFM.CaretX := 0;
    FormRelatorio.TextoDFM.SearchReplace('object Selecao_1:','', SearchOptionsPd);
    Y := FormRelatorio.TextoDFM.CaretY + 1;
    I := 0;
    FormPrincipal.Texto.Lines.Clear;
    if Y > 2 then
    begin
      Tamanho := Pos('O',UpperCase(FormRelatorio.TextoDFM.Lines[Y-2]))-1;
      FinalBloco := False;
      InicioBloco := False;
      while not FinalBloco do
      begin
        if not InicioBloco then
         if Copy(UpperCase(Trim(FormRelatorio.TextoDFM.Lines[Y])),01,07) = 'OBJECT ' then
           InicioBloco := True;
        if UpperCase(TrimRight(FormRelatorio.TextoDFM.Lines[Y])) = Space(Tamanho) + 'END' then
         begin
          InicioBloco := False;
          FinalBloco := True;
        end;
        if InicioBloco then
        begin
          if UpperCase(Copy(Trim(FormRelatorio.TextoDFM.Lines[Y]),01,02)) = 'ON' then // é um evento
          begin
            NomeComp := Localiza_Nome(TStringList(FormRelatorio.TextoDFM.Lines),Pos('O',UpperCase(FormRelatorio.TextoDFM.Lines[Y]))-3,Y);
            NomeComp := NomeComp + ':' + Trim(Copy(Trim(FormRelatorio.TextoDFM.Lines[Y]),Pos('=',Trim(FormRelatorio.TextoDFM.Lines[Y]))+1,Length(Trim(FormRelatorio.TextoDFM.Lines[Y]))));
            FormRelatorio.TextoPAS.CaretY := 0;
            FormRelatorio.TextoPAS.CaretX := 0;
            FormRelatorio.TextoPAS.SearchReplace(Copy(NomeComp,Pos(':',NomeComp)+1,Length(NomeComp)),'', SearchOptionsPd);
            if FormRelatorio.TextoPAS.CaretY > 1 then  // vamos ver se o evento existe
              ListaEventos.Add(NomeComp);
          end
          else
          begin
            if UpperCase(Copy(Trim(FormRelatorio.TextoDFM.Lines[Y]),01,08)) = 'TABORDER' then // é um taborder
            begin
              NomeComp := Localiza_Nome(TStringList(FormRelatorio.TextoDFM.Lines),Pos('T',UpperCase(FormRelatorio.TextoDFM.Lines[Y]))-3,Y);
              if ListaTabOrder.IndexOf(NomeComp) < 0 then
                ListaTabOrder.AddObject(NomeComp,TObject( StrToIntDef(Trim(Copy(FormRelatorio.TextoDFM.Lines[Y],Pos('=',FormRelatorio.TextoDFM.Lines[Y])+1,20)),0) ) );
            end;
            Linha := Copy(FormRelatorio.TextoDFM.Lines[Y],05,Length(FormRelatorio.TextoDFM.Lines[Y]));
            if UpperCase(Trim(Linha)) = 'VISIBLE = FALSE' then
            begin
              NomeComp := Localiza_Nome(TStringList(FormRelatorio.TextoDFM.Lines),Pos('V',UpperCase(FormRelatorio.TextoDFM.Lines[Y]))-3,Y);
              ListaInvisivel.Add(NomeComp);
              Linha := TrocaString(Linha,'False','True',[rfReplaceAll]);
            end;
            if UpperCase(Trim(Linha)) = 'ENABLED = FALSE' then
            begin
              NomeComp := Localiza_Nome(TStringList(FormRelatorio.TextoDFM.Lines),Pos('E',UpperCase(FormRelatorio.TextoDFM.Lines[Y]))-3,Y);
              ListaDesabilitado.Add(NomeComp);
              Linha := TrocaString(Linha,'False','True',[rfReplaceAll]);
            end;
            FormPrincipal.Texto.Lines.Add(Linha);
          end;
        end;
        inc(Y);
      end;
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + NomeForm + 'Tela'+IntToStr(I)+'.Txt');
      if FormPrincipal.Texto.Lines.Count > 2 then
      begin
        try
          FS2 := TFileStream.Create(Projeto.Pasta + NomeForm + 'Tela'+IntToStr(I)+'.Tmp', fmCreate);
          FinalBloco := False;
          FormPrincipal.Texto.Lines.Clear;
          while not FinalBloco do
          begin
            FS := TFileStream.Create(Projeto.Pasta + NomeForm + 'Tela'+IntToStr(I)+'.Txt', fmOpenRead);
            ObjectTextToBinary(FS, FS2);
            FS.Free;

            FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + NomeForm + 'Tela'+IntToStr(I)+'.Txt');
            InicioBloco := False;
            FormPrincipal.Texto.Lines.Delete(0);
            while not InicioBloco do
            begin
              if (UpperCase(Copy(FormPrincipal.Texto.Lines[0],01,07)) = 'OBJECT ') or (FormPrincipal.Texto.Lines.Count = 0) then
                InicioBloco := True
              else
                FormPrincipal.Texto.Lines.Delete(0);
            end;
            FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + NomeForm + 'Tela'+IntToStr(I)+'.Txt');
            if FormPrincipal.Texto.Lines.Count < 3 then
              FinalBloco := True;
            FormPrincipal.Texto.Lines.Clear;
          end;
        finally
          FinalFluxo := vaNull;
          FS2.Write(FinalFluxo, SizeOf(FinalFluxo));
          FS2.Free;
        end;
        DsnStage0.LoadFromFile(Projeto.Pasta + NomeForm + 'Tela0.Tmp');
      end;
      FormPrincipal.Texto.Lines.Clear;
    end;
  end;

begin
  ListaSelecionados  := TList.Create;
  ListaEventos       := TStringList.Create;
  ListaInvisivel     := TStringList.Create;
  ListaDesabilitado  := TStringList.Create;
  ListaTabOrder      := TStringList.Create;
  Registra_Classes;
  DsnRegister.Designing := True;
  FormObjInsp_rel := TFormObjInsp_rel.Create(FormDialogo_Rel);
  try
    FormObjInsp_rel.SplitterPos := 75;
    IniFile := TInifile.Create(Projeto.PastaGerador + 'XMAKER.INI');
    I := StrToIntDef(Trim(IniFile.ReadString('PALETA', 'Top', '')),158);
    Y := StrToIntDef(Trim(IniFile.ReadString('PALETA', 'Left', '')),10);
    FormObjInsp_rel.Top  := I;
    FormObjInsp_rel.Left := Y;
    FormObjInsp_rel.SplitterPos := StrToIntDef(Trim(IniFile.ReadString('PALETA', 'Splitter', '75')),75);
    IniFile.Free;
    FormObjInsp_rel.CB1.Items.Clear;
    FormObjInsp_rel.CB1.Items.Add('');
    FormObjInsp_rel.Show;
  Finally
  end;
  if FileExists(Projeto.Pasta + NomeForm + 'Tela0.Tmp') then
    DeleteFile(Projeto.Pasta + NomeForm + 'Tela0.Tmp');
  if FileExists(Projeto.Pasta + NomeForm + 'Tela0.Txt') then
    DeleteFile(Projeto.Pasta + NomeForm + 'Tela0.Txt');
  Ler_Tela;
  if FileExists(Projeto.Pasta + NomeForm + 'Tela0.Tmp') then
    DeleteFile(Projeto.Pasta + NomeForm + 'Tela0.Tmp');
  if FileExists(Projeto.Pasta + NomeForm + 'Tela0.Txt') then
    DeleteFile(Projeto.Pasta + NomeForm + 'Tela0.Txt');
  for T:=0 to 1 do
  begin
    for I:=0 to DsnStage0.ControlCount -1 do
    begin
      FormObjInsp_rel.CB1.Items.Add(DsnStage0.Controls[I].Name + ': ' +DsnStage0.Controls[I].ClassName);
      Component := DsnStage0.Controls[I];
      Y := ListaTabOrder.IndexOf(Component.Name);
      if Y > -1 then
        SetOrdProp(Component,'TabOrder',Integer(ListaTabOrder.Objects[Y]));
    end;
  end;
  ListaTabOrder.Free;
  FormObjInsp_rel.Atribui(Nil, True);
  FormObjInsp_rel.CB1.ItemIndex := 0;
end;

procedure TFormDialogo_Rel.DsnStage0ControlCreate(Sender: TObject;
  Component: TComponent);
Var
  Comp: TControl;
  ParentNome: String;
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  Comp := TControl(Component);
  ParentNome := UpperCase(Comp.Parent.ClassName);
  if CompBotao then
  begin
    if UpperCase(Comp.ClassName) = 'TLABEL' then
    begin
      Comp.Height := 13;
      Comp.Width  := 45;
      TLabel(Component).Caption := 'Texto';
    end
    else if (UpperCase(Comp.ClassName) = 'TGROUPBOX') or
            (UpperCase(Comp.ClassName) = 'TRADIOGROUP') or
            (UpperCase(Comp.ClassName) = 'TPANEL') then
    begin
      Comp.Height := 105;
      Comp.Width  := 185;
    end
    else if UpperCase(Comp.ClassName) = 'TBITBTN' then
    begin
      Comp.Height := 25;
      Comp.Width  := 75;
    end
    else if UpperCase(Comp.ClassName) = 'TSPEEDBUTTON' then
    begin
      Comp.Height := 22;
      Comp.Width  := 23;
    end
    else if UpperCase(Comp.ClassName) = 'TBEVEL' then
    begin
      Comp.Height := 50;
      Comp.Width  := 50;
    end
    else if UpperCase(Comp.ClassName) = 'TEDIT' then
    begin
      Comp.Height := 21;
      Comp.Width  := 121;
      TEdit(Component).Text := '';
    end
    else if UpperCase(Comp.ClassName) = 'TXEDIT' then
    begin
      Comp.Height := 21;
      Comp.Width  := 121;
      TXEdit(Component).Text := '';
    end
    else if UpperCase(Comp.ClassName) = 'TXNUMEDIT' then
    begin
      Comp.Height := 21;
      Comp.Width  := 121;
      TXNumEdit(Component).ShowButton := True;
    end
    else if UpperCase(Comp.ClassName) = 'TXDATEEDIT' then
    begin
      Comp.Height := 21;
      Comp.Width  := 121;
      TXDateEdit(Component).ShowButton := True;
    end
    else if UpperCase(Comp.ClassName) = 'TCOMBOBOX' then
    begin
      Comp.Height := 21;
      Comp.Width  := 145;
      TComboBox(Component).Text := '';
    end
    else if UpperCase(Comp.ClassName) = 'TIMAGE' then
    begin
      Comp.Height := 94;
      Comp.Width  := 94;
      if FileExists(Projeto.PastaGerador + 'Imagem\sky.jpg') then
        TImage(Component).Picture.LoadFromFile(Projeto.PastaGerador + 'Imagem\sky.jpg');
    end
    else if (UpperCase(Comp.ClassName) = 'TLISTBOX') or
            (UpperCase(Comp.ClassName) = 'TCHECKLISTBOX') then
    begin
      Comp.Height := 97;
      Comp.Width  := 121;
    end
    else if (UpperCase(Comp.ClassName) = 'TMEMO') or
            (UpperCase(Comp.ClassName) = 'TSTRINGGRID') or
            (UpperCase(Comp.ClassName) = 'TRICHEDIT') then
    begin
      Comp.Height := 89;
      Comp.Width  := 185;
      if (UpperCase(Comp.ClassName) = 'TMEMO') then
        TMemo(Component).Lines.Clear
      else if (UpperCase(Comp.ClassName) = 'TRICHEDIT') then
        TRichEdit(Component).Lines.Clear;
    end
    else if (UpperCase(Comp.ClassName) = 'TPAGECONTROL') then
    begin
      Comp.Height := 89;
      Comp.Width  := 185;
      CompPageControl := TWinControl(Comp);
      PageControl_NovaPagina;
    end
    else if (UpperCase(Comp.ClassName) = 'TDBGRID') then
    begin
      Comp.Height := 89;
      Comp.Width  := 185;
    end
    else
    begin
      Comp.Height := 21;
      Comp.Width  := 121;
    end;
  end;
  if UpperCase(Comp.ClassName) <> 'TDSNSTAGE' then
  begin
    if FormObjInsp_rel.CB1.Items.IndexOf(Comp.Name + ': ' +Comp.ClassName) < 0 then
      FormObjInsp_rel.CB1.Items.Add(Comp.Name + ': ' +Comp.ClassName);
    AtribuiExtras(Comp.Name, 0, Comp.ClassName,
                               Comp.Top, Comp.Left, Comp.Width, Comp.Height);
    FormObjInsp_Rel.Atribui(Comp, True);
    SetFocus;
  end;
  TDsnStage(Sender).UpdateControl;
  CompBotao := False;
end;

procedure TFormDialogo_Rel.DsnLabelClick(Sender: TObject);
begin
  CompBotao := TDsnButton(Sender).Down;
end;

procedure TFormDialogo_Rel.PageControl_NovaPagina;
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

procedure TFormDialogo_Rel.AtribuiExtras(Nome: String; Pagina: Integer; Tipo: String;
                                     Linha, Coluna, Largura, Altura: Integer);
var I,Y : Integer;
    Coord: TPoint;
    Pesquisa, ECombo, NomeComp, StrEvento: String;
    Achou: Boolean;
begin
  begin
    with FormRelatorio.TextoPas do
    begin
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
          FormRelatorio.TextoPas.Lines.Insert(Y,'    '+Nome+': '+Tipo+';');
          CaretX := 1;
          FormRelatorio.TextoPas.Modified := True;
        end
        else
          Mensagem('Bloco de codificação "01", não foi encontrado !!!',modErro,[modOk]);
        CaretX := 1;
        CaretY := 1;
      end;
    end;
  end;
end;

function TFormDialogo_Rel.CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
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
    for I:=0 to FormObjInsp_rel.CB1.Items.Count-1 do
      if UpperCase(Copy(FormObjInsp_rel.CB1.Items[I],1,Pos(':',FormObjInsp_rel.CB1.Items[I])-1)) = UpperCase(Campo) then
        Ok := False;
  if Not Ok then
  begin
    Mensagem('Componente já existe !',ModInformacao,[modOk]);
    DsnRegister.Designing:= True;
    exit;
  end;
  Ordem := 0;
  Component := ComponentClass.Create(FormDialogo_Rel);
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
  Altura  := 21;
  //if EdTamanho > 0 then
  //  Largura := EdTamanho * 7 + 14
  //else
    Largura := 121;
  if Tipo = 'TSDBSpinEdit' then
    Largura := 58;
  {if Tipo = 'TDBCheckBox' then
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
  end;}
  if Tipo = 'TXNumEdit' then
  begin
    TXNumEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end
  else if Tipo = 'TXDateEdit' then
  begin
    TXDateEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end;
  {else if (Tipo = 'TXDBNumEdit') and (TpCampo = 3) then
  begin
    TXDBNumEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end
  else if Tipo = 'TXDBDateEdit' then
  begin
    TXDBDateEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end;}
  //if (EdCampo = 5) and (EdEstilo = 1) then
  //  Largura := Largura + 16;
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
  FormObjInsp_rel.CB1.Items.Add(Control.Name + ': ' +Control.ClassName);
  AtribuiExtras(Control.Name, 0, Control.ClassName,
                X, Y, Control.Width, Control.Height);
  DsnRegister.Designing:= True;
  CreateComponent := Control;
  if AtInspector then
    DsnSelect.Select(Control);
end;

function TFormDialogo_Rel.UniqueName(comp:TComponent; Tipo:String):string;
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

procedure TFormDialogo_Rel.Dsg_NovaPaginaClick(Sender: TObject);
begin
  CompPageControl := TWinControl(ObjetoAtual);
  PageControl_NovaPagina;

end;

procedure TFormDialogo_Rel.Dsg_EnviarparafrenteClick(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to DsnRegister.DsnStage.TargetsCount - 1 do
    DsnRegister.DsnStage.Targets[I].BringToFront;
  DsnRegister.DsnStage.UpdateControl;
end;

procedure TFormDialogo_Rel.Dsg_EnviarparatrasClick(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to DsnRegister.DsnStage.TargetsCount - 1 do
    DsnRegister.DsnStage.Targets[I].SendToBack;
  DsnRegister.DsnStage.UpdateControl;
end;

procedure TFormDialogo_Rel.Dsg_Alinhamento_objClick(Sender: TObject);
begin
  {FormAlinhamento := TFormAlinhamento.Create(Application);
  try
    FormAlinhamento.ShowModal;
  Finally
    FormAlinhamento.Free;
  end;
  if ListaSelecionados.Count = 1 then
    FormObjInsp_rel.Atribui(ListaSelecionados[0], True);}
end;

procedure TFormDialogo_Rel.Dsg_Dimensoes_objClick(Sender: TObject);
begin
  {FormTamanho := TFormTamanho.Create(Application);
  try
    FormTamanho.ShowModal;
  Finally
    FormTamanho.Free;
  end;
  if ListaSelecionados.Count = 1 then
    FormObjInsp_rel.Atribui(ListaSelecionados[0], True);}
end;

procedure TFormDialogo_Rel.Dsg_SequnciaTabOrder1Click(Sender: TObject);
begin
  Define_TabOrder;

end;

procedure TFormDialogo_Rel.Dsg_Recortar1Click(Sender: TObject);
begin
  DsnRegister.DsnStage.Cut;

end;

procedure TFormDialogo_Rel.Dsg_Copiar1Click(Sender: TObject);
begin
  DsnRegister.DsnStage.Copy;
end;

procedure TFormDialogo_Rel.Dsg_Colar1Click(Sender: TObject);
begin
  DsnRegister.DsnStage.Paste;

end;

procedure TFormDialogo_Rel.Dsg_SelecionarTodos1Click(Sender: TObject);
var
  I: Integer;
  Lista: TList;
begin
  if ListaSelecionados <> Nil then
    ListaSelecionados.Clear;
  DsnRegister.ClearSelect;
  Lista := TList.Create;
  for I:=0 to DsnRegister.DsnStage.ControlCount-1 do
    Lista.Add(DsnRegister.DsnStage.Controls[I]);
  DsnSelect.MultipleSelect(Lista);
  Lista.Free;
end;

procedure TFormDialogo_Rel.Dsg_Excluir1Click(Sender: TObject);
begin
  DsnRegister.DsnStage.Delete;
end;

procedure TFormDialogo_Rel.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Output: TMemoryStream;
  I,Z: Integer;
  Inicio, Final, Achou2: Boolean;
  Prox_Linha, NomeComp, Linha_ev: String;
  TextoTxt_C: TStringList;
begin
  Output:=TMemoryStream.Create;
  with OutPut do
  begin
    WriteComponentRes(Projeto.Pasta + 'Form'+NomeForm+'.Tmp',FormDialogo_Rel);
    SaveToFile(Projeto.Pasta + 'Form'+NomeForm+'.Tmp');
    Free;
  end;
  ConvertFormOrText(Projeto.Pasta + 'Form'+NomeForm+'.Tmp',2);
  DeleteFile(Projeto.Pasta + 'Form'+NomeForm+'.Tmp');
  TextoTxt.Lines.Clear;
  if FileExists(Projeto.Pasta + 'Form'+NomeForm+'.Txt') then
    TextoTxt.Lines.LoadFromFile(Projeto.Pasta + 'Form'+NomeForm+'.Txt');
  TextoTXT.CaretY := 0;
  TextoTXT.CaretX := 0;
  TextoTXT.SearchReplace('object DsnStage0:','', SearchOptionsPd);
  I := TextoTXT.CaretY;
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Salvando formulário ...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := I;
  FormAguarde.GaugeProcesso.Max := TextoTxt.Lines.Count-1;
  TextoTxt_C := TStringList.Create;
  Inicio := False;
  Final := False;
  Texto_Tela.Lines.Clear;
  Achou2 := False;
  while I <= TextoTxt.Lines.Count-1 do
  begin
    FormAguarde.GaugeProcesso.Position := I;
    if not Final then
    begin
      if not Inicio then
        if Copy(UpperCase(Trim(TextoTxt.Lines[I])),01,07) = 'OBJECT ' then
          Inicio:=True;
      if UpperCase(TrimRight(TextoTxt.Lines[I])) = '  END' then
        Final := True
      else
        if Inicio then
        begin
          Prox_Linha := TextoTxt.Lines[I];
          //Texto_Tela.Lines.Add(TextoTxt.Lines[I]);
          //if Achou2 then
          begin
            if UpperCase(Trim(Prox_Linha)) = 'END' then
            begin
              NomeComp := Localiza_Nome(TextoTxt_C,Pos('E',UpperCase(Prox_Linha))-1);
              if Trim(NomeComp) <> '' then
              begin
                if ListaInvisivel.IndexOf(NomeComp) > -1 then
                begin
                  Texto_Tela.Lines.Add(Space(Pos('E',UpperCase(Prox_Linha))+1)+'Visible = False');
                end;
                if ListaDesabilitado.IndexOf(NomeComp) > -1 then
                begin
                  Texto_Tela.Lines.Add(Space(Pos('E',UpperCase(Prox_Linha))+1)+'Enabled = False');
                end;
                for Z:=0 to ListaEventos.Count-1 do
                  if UpperCase(Copy(ListaEventos[Z],01,Pos(':',ListaEventos[Z])-1)) = NomeComp then
                  begin
                    Linha_ev := ListaEventos[Z];
                    Linha_ev := Copy(Linha_ev,Pos(':',Linha_ev)+1,Length(Linha_ev));
                    Linha_ev := Copy(Linha_ev,Length(NomeComp)+1,Length(Linha_ev));
                    if Trim(Linha_ev) <> '' then
                    begin
                      FormRelatorio.TextoPAS.CaretY := 0;
                      FormRelatorio.TextoPAS.CaretX := 0;
                      FormRelatorio.TextoPAS.SearchReplace(NomeComp + Linha_ev,'', SearchOptionsPd);
                      if FormRelatorio.TextoPAS.CaretY > 1 then  // vamos ver se o evento existe
                      begin
                        Linha_ev := 'On' + Linha_ev + ' = ' + NomeComp + Linha_ev;
                        Texto_Tela.Lines.Add(Space(Pos('E',UpperCase(Prox_Linha))+1)+Linha_ev);
                        TextoTxt_C.Add(Space(Pos('E',UpperCase(Prox_Linha))+1)+Linha_ev);
                      end;
                    end;
                  end;
              end;
            end;
            Texto_Tela.Lines.Add(TextoTxt.Lines[I]);
            TextoTxt_C.Add(Prox_Linha);
          end;
        end;
    end;
    Inc(I);
  end;
  TextoTxt_C.Free;
  if FileExists(Projeto.Pasta + 'Form'+NomeForm+'.Txt') then
    DeleteFile(Projeto.Pasta + 'Form'+NomeForm+'.Txt');
  FormRelatorio.GeraRel(True);  
  FormAguarde.Free;
  FormDialogo_Rel := Nil;
  if FormObjInsp_rel <> nil then
    FormObjInsp_rel.Close;
  DsnRegister.Designing:= False;
  ListaSelecionados.Free;
  ListaEventos.Free;
  ListaInvisivel.Free;
  ListaDesabilitado.Free;
end;

procedure TFormDialogo_Rel.Define_TabOrder;
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
            Conteudo := FormObjInsp_rel.GetPropAsString(Component,PropList[Y],False);
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
      FormRelatorio.TextoDFM.Modified := True;
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

procedure TFormDialogo_Rel.DsnStage0DeleteQuery(Sender: TObject;
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
    Posicao := FormObjInsp_rel.CB1.Items.IndexOf(Nome + ': ' + Classe);
    if Posicao > -1 then
      FormObjInsp_rel.CB1.Items.Delete(Posicao);
    if ExcluiTodosEv then
      Resp2 := mrYes
    else
      Resp2 := Mensagem('Excluir os eventos associados ao objeto: "'+Nome+'" ?',ModConfirmacao,[ModSim,ModNao,ModTodos]);
    if (Resp2 = mrYes) or (Resp2 = 10) then
      ExcluiObjeto(Nome, True)
    else
      ExcluiObjeto(Nome, False);
    FormObjInsp_rel.Atribui(Nil, True);
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

procedure TFormDialogo_Rel.ExcluiObjeto(Nome: String; Eventos: Boolean);
Var
  Achou, Fim : Boolean;
  Y,P: Integer;
  LstExclusao: TStringList;
  Pesquisa, StrEvento: String;
  Qtd_Begin, Qtd_End: Integer;
  Qtd_I_Coment, Qtd_F_Coment: Integer;
begin
  begin
    with FormRelatorio.TextoPas do
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

      FormRelatorio.TextoDFM.CaretX := 1;
      FormRelatorio.TextoDFM.CaretY := 1;
      if FormRelatorio.TextoDFM.SearchReplace('object DataSource_'+Nome+':', '', SearchOptionsPd) > 0 then
      begin
        achou := False;
        Y     := FormRelatorio.TextoDFM.CaretY;
        while (not Achou) and (FormRelatorio.TextoDFM.CaretY <= FormRelatorio.TextoDFM.Lines.Count) do
        begin
          if FormRelatorio.TextoDFM.LineText = '  end' then
          begin
            Achou := True;
            FormRelatorio.TextoDFM.lines.Delete(Y - 1);
          end;
          FormRelatorio.TextoDFM.lines.Delete(Y - 1);
          FormRelatorio.TextoDFM.CaretY := Y + 1;
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
            FormRelatorio.TextoPAS.CaretX := 1;
            FormRelatorio.TextoPAS.CaretY := 1;
            FormRelatorio.TextoPAS.SearchReplace(Pesquisa, '', SearchOptionsPd );
            if FormRelatorio.TextoPAS.CaretY > 1 then
            begin
              P := FormRelatorio.TextoPAS.CaretY - 1;
              Fim := false;
              while not Fim do
              begin
                if Pos(');',RetiraBrancos(FormRelatorio.TextoPAS.Lines[P])) > 0 then Fim := True;
                FormRelatorio.TextoPAS.Lines.Delete(P);
              end;
            end;

            Pesquisa := RetiraBrancos('procedure TForm'+NomeForm +'.'+ StrEvento + '(');
            FormRelatorio.TextoPAS.CaretX := 1;
            FormRelatorio.TextoPAS.CaretY := 1;
            FormRelatorio.TextoPAS.SearchReplace(Pesquisa, '', SearchOptionsPd );
            if FormRelatorio.TextoPAS.CaretY > 1 then
            begin
              P := FormRelatorio.TextoPAS.CaretY - 1;
              Fim := false;
              Qtd_Begin := 0;
              Qtd_End := 0;
              Qtd_I_Coment := 0;
              Qtd_F_Coment := 0;
              while (not Fim) and (FormRelatorio.TextoPAS.CaretY < FormRelatorio.TextoPAS.Lines.Count-1) do
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
                FormRelatorio.TextoPAS.Lines.Delete(P);
                Pesquisa := Trim(UpperCase(LineText));
                if (Copy(Pesquisa,01,04) = 'END.') or
                   (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORM' + UpperCase(NomeForm) + '.' ) or
                   (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORM' + UpperCase(NomeForm) + '.' ) then
                  Fim := True;
              end;
              if Trim(UpperCase(LineText)) = '' then
                FormRelatorio.TextoPAS.Lines.Delete(P);
            end;
          end;
        for Y:=0 to LstExclusao.Count-1 do
        begin
          P := ListaEventos.IndexOf(LstExclusao[Y]);
          if P > -1 then
            ListaEventos.Delete(P);
        end;
        LstExclusao.Free;
      end;
    end;
  end;
end;

procedure TFormDialogo_Rel.AtualizaLista_CB;
var
  I, Y: Integer;
  NvLista: TStringList;
  NomeComp: String;
  Componente: TComponent;
begin
  NvLista := TStringList.Create;
  NvLista.Add('');
  for Y:=1 to FormObjInsp_rel.CB1.Items.Count-1 do
  begin
    NomeComp := Copy(FormObjInsp_rel.CB1.Items[Y],01,Pos(':',FormObjInsp_rel.CB1.Items[Y])-1);
    I := 0;
    Componente := Nil;
    while I <= FormDialogo_Rel.ComponentCount-1 do
    begin
      if FormDialogo_Rel.Components[I].Name = NomeComp then
      begin
        Componente := FormDialogo_Rel.Components[I];
        I := 9999;
      end;
      Inc(I);
    end;
    if Componente <> nil then
      NvLista.Add(FormObjInsp_rel.CB1.Items[Y]);
  end;
  FormObjInsp_rel.CB1.Items := NvLista;
  NvLista.Free;
  ExcluiComp := False;
end;

procedure TFormDialogo_Rel.AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
var I,Y,T,W,F : Integer;
    Coord: TPoint;
    Achou, Achou2: Boolean;
    Data: Pointer;
begin
  if Trim(Parametros) = '' then
    Parametros := '(Sender: TObject);';
  begin
    with FormRelatorio.TextoPAS do
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
          FormRelatorio.TextoPAS.Lines.Insert(Y,'    procedure '+Copy(Pesquisa,Pos('.',Pesquisa)+1,50)+Parametros);
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
          FormRelatorio.TextoPAS.Lines.Insert(Y,Pesquisa+Parametros);
          if not Grid then
          begin
            if MemoCodificacao = Nil then
            begin
              FormRelatorio.TextoPAS.Lines.Insert(Y+1,'begin');
              if Trim(Codificacao) = '' then
                FormRelatorio.TextoPAS.Lines.Insert(Y+2,'')
              else
                FormRelatorio.TextoPAS.Lines.Insert(Y+2,'  '+Codificacao);
              FormRelatorio.TextoPAS.Lines.Insert(Y+3,'end;');
              FormRelatorio.TextoPAS.Lines.Insert(Y+4,'');
            end
            else
            begin
              For F:=0 to MemoCodificacao.Count-1 do
              begin
                inc(Y);
                FormRelatorio.TextoPAS.Lines.Insert(Y,MemoCodificacao[F]);
              end;
              inc(Y);
              FormRelatorio.TextoPAS.Lines.Insert(Y,'');
            end;
          end;
          FormRelatorio.TextoPAS.Modified := True;
          CaretX := 1;
          CaretY := Y+3;
        end;
        exclude( SearchOptionsPd, ssoBackwards );
      end;
    end;
  end;
end;

procedure TFormDialogo_Rel.DsnStage0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
end;

procedure TFormDialogo_Rel.DsnStage0MoveQuery(Sender: TObject;
  Component: TComponent; var CanMove: Boolean);
//var
//  ThreadObj: ThObjInsp;
begin
  FormRelatorio.TextoDFM.Modified := True;
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
  ObjetoAtual := Component;
  if Thread_ok then
  begin
    Thread_Ok := False;
    //ThreadObj := ThObjInsp.Create(False);
    SetFocus;
  end;
end;

procedure TFormDialogo_Rel.DsnStage0SelectQuery(Sender: TObject;
  Component: TComponent; var CanSelect: TSelectAccept);
begin
  ExcluiTodos := False;
  ExcluiTodosEv := False;
  if ExcluiComp then
    AtualizaLista_CB;
end;

procedure TFormDialogo_Rel.DsnSelectChangeSelected(Sender: TObject;
  Targets: TSelectedComponents; Operation: TSelectOperation);
Var
  I: Integer;
begin
  ListaSelecionados.Clear;
  for I:=0 to Targets.Count-1 do
    ListaSelecionados.Add(Targets.Items[I]);
  Dsg_NovaPagina.Visible := False;
  Divisao_NvPg.Visible := False;
  if Targets.Count = 1 then
  begin
    if Targets.Items[0] is TPageControl then
    begin
      Dsg_NovaPagina.Visible := True;
      Divisao_NvPg.Visible := True;
    end;
    FormObjInsp_rel.Atribui(Targets.Items[0], True);
    SetFocus;
    ObjetoAtual := Targets.Items[0];
  end
  else if Targets.Count > 1 then
    FormObjInsp_rel.Atribui(Nil, True);
end;

function TFormDialogo_Rel.Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
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

end.
