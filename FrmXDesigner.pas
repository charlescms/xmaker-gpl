unit FrmXDesigner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FDMain, IniFiles, stdctrls, SynEdit, SynEditKeyCmds, comctrls, FR_Ctrls,
  ExtCtrls, FR_Dock, FR_DBOp, FR_Class, tabs, Menus, SynHighlighterDfm, ActnList,
  XDate, XNum, XEdit, XDBDate, XDBNum, XDBEdit, XLookup, dbctrls, db, TypInfo,
  dbgrids, RXDbCtrl, DBRichEd;

type
  TPropForm = record
    Cabecalho: String;
    Nome: String;
    Visible: String;
    FormStyle: String;
    BorderStyle: String;
    BorderIcons: String;
    WindowState: String;
    Position: String;
  end;

  TFrmXDesig = class(TForm)
    cmpFormDesigner: TFormDesigner;
    procedure FormShow(Sender: TObject);
    procedure cmpFormDesignerSelectControl(Sender: TObject;
      TheControl: TControl);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmpFormDesignerControlDblClick(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmpFormDesignerMoveSizeControl(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerPlaceComponent(Sender: TObject;
      TheComponent: TComponent);
    procedure FormDestroy(Sender: TObject);
    procedure cmpFormDesignerAddControl(Sender: TObject;
      TheControl: TControl);
    procedure CB1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmpFormDesignerReadError(Reader: TReader;
      const Message: String; var Handled: Boolean);
  private
    { Private declarations }
    EdCampo,TpCampo,EdTamanho,EdEstilo: Integer;
    NomeObjCampo,NomeCampo,EdTitulo,EdLista: String;
    ObjetoAtual: TObject;
    AutoFormatacao: Boolean;
    EdChave: Boolean;
    TabPaginas: TTabSet;
    EdGridEditavel: Boolean;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure UpdateInfo;
    procedure AtribuiUses(Arquivo: String);
    procedure AtribuiUsesComp(Classe: String; Texto: TSynEdit);
    function LerAtributo(S, Atr: String): String;
    function Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
    function CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
                             GravaFRM: Boolean; Campo: String; TipoCampo: String; AtInspector: Boolean):TComponent;
    procedure AtribuiCampo(Nome: String; Pagina: Integer; EChave: Boolean;
                            Linha, Coluna, Largura, Altura: Integer);
    procedure AtribuiExtras(Nome: String; Pagina: Integer; Tipo: String;
                            Linha, Coluna, Largura, Altura: Integer);
  public
    { Public declarations }
    PropForm: TPropForm;
    VamosGravar: Boolean;
    Index: Integer;
    EdFormRel, EdNomeTabRel: String;
    ListaEventos, ListaComp, BlocoExtra, ObjetoExtra: TStringList;
    SearchOptionsPd: TSynSearchOptions;
    NomeMenu: String;
    NrTabela: String;
    NomeTab: String;
    procedure AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
    procedure Atualiza_CB(Update: Boolean; Nome, Classe: String; Comp_CB: TComponent);
    function UniqueName(comp: TComponent): String;
    procedure NovaPagina;
    function NovoItemMenu: TMenuItem;
    procedure RedefineMenu(AItem: TMenuItem);
    procedure Carrega_Form;
    procedure SalvarFormulario;
    procedure PosicionaPagina(Index: Integer);
    procedure AutoFormatar;
    procedure InserirCamposPagina(ListaSelecao: TStringList; P_Titulo, P_Distribuicao, X, Y: Integer);
    procedure ExcluiObjeto(Nome: String);
    procedure InserirCamposDB;
    procedure Cria_Grid_Relacionamento;
    procedure Altera_WinState(Tipo: Integer);
    procedure Retorna_WinState;
    procedure Altera_Position(Tipo: Integer);
    procedure Retorna_Position;
  end;

var
  FrmXDesig: TFrmXDesig;

implementation

uses Princ, FDCmpPal, FDesigner, ObjInsp, Rotinas, Aguarde,
  Abertura, Abertura_p, OpFormatacao, GrRelac, Gera_01;

{$R *.DFM}

function Extrai_Nome(S: String): String;
var
  Retorno: String;
begin
  Retorno := UpperCase(Trim(Copy(S,08,Length(S))));
  Retorno := Trim(Copy(Retorno,01,Pos(':',Retorno)-1));
  Result := Retorno;
end;

function TFrmXDesig.Localiza_Nome(Texto: TStringList; Espaco: Integer; P: Integer = 0): String;
var
  Y: Integer;
  Linha, Retorno: String;
begin
  if P > 0 then
    Y := P
  else
    Y := Texto.Count-1;
  Retorno := '';
  while Y > 0 do
  begin
    Linha := UpperCase(Trim(Texto[Y]));
    if (Copy(Linha,01,07) = 'OBJECT ') and
       (Pos('O',UpperCase(Texto[Y]))-1 = Espaco) then
    begin
      Linha := UpperCase(Trim(Copy(Linha,08,Length(Linha))));
      Linha := Trim(Copy(Linha,01,Pos(':',Linha)-1));
      Retorno := Linha;
      Y := 0;
    end
    else
      Dec(Y);
  end;
  if Trim(Retorno) = '' then
    Retorno := PropForm.Nome;
  Localiza_Nome := Retorno;
end;

procedure TFrmXDesig.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := (Style OR WS_CHILD) AND (NOT WS_POPUP);
    WndParent := FormDesigner_Net.HostScroll.Handle;
  end;
  Parent := FormDesigner_Net.HostScroll;
end;

procedure TFrmXDesig.UpdateInfo;
begin
  if Assigned(cmpFormDesigner.Control) then
  begin
    if cmpFormDesigner.ControlCount = 1 then
    begin
      if cmpFormDesigner.Control is TComponentContainer then
        FormObjInsp.Atribui(TComponentContainer(cmpFormDesigner.Control).Component, True)
      else
        FormObjInsp.Atribui(cmpFormDesigner.Control, True)
    end
    else
      FormObjInsp.Atribui(Nil, True);
  end;
end;

procedure TFrmXDesig.FormShow(Sender: TObject);
begin
  cmpFormDesigner.Active:=True;
end;

procedure TFrmXDesig.RedefineMenu(AItem: TMenuItem);
var
  Comp: TComponent;
begin
  Comp := FindComponent(NomeMenu);
  if Assigned(Comp) then
  begin
    TMenu(Comp).Items.Clear;
    TMenu(Comp).Items.Add(AItem);
  end;
end;

function TFrmXDesig.NovoItemMenu: TMenuItem;
var
  Nome: String;
begin
  Result := TMenuItem.Create(Self);
  Nome := UniqueName(Result);
  with Result do
  begin
    Caption := Nome;
    Name    := Nome;
  end;
end;

function TFrmXDesig.LerAtributo(S, Atr: String): String;
begin
  if Pos(LowerCase(Atr) + '=', LowerCase(RetiraEspacos(S))) = 1 then
    Result := Trim(Copy(S, Pos('=', S)+1, Length(S)))
  else
    Result := '';
end;

procedure TFrmXDesig.Carrega_Form;
var
  I: Integer;
  Inicio: Boolean;
  NomeComp, Linha: String;
  Titulo: String;
  hMenuHandle : HMENU;
  bWasText: boolean;                                                            //mh 1999-10-04
begin
  Titulo := Caption;
  RegisterClasses([TTabSheet, TToolButton, TImageList, TfrSpeedButton, TfrDock, TfrToolBar,
                   TfrTBButton, TfrTBSeparator, TfrTBPanel, TfrOpenDBDialog, TAction]);
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Abrindo formulário ...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := 0;
  try
    BlocoExtra.Clear;
    ObjetoExtra.Clear;
    PropForm.Cabecalho   := '';
    PropForm.Visible     := 'False';
    PropForm.FormStyle   := 'fsNormal';
    PropForm.BorderStyle := 'bsSizeable';
    PropForm.BorderIcons := '[biSystemMenu,biMinimize,biMaximize]';
    PropForm.WindowState := 'wsNormal';
    PropForm.Position    := 'poDesigned';
    FormDesigner_Net.Texto_DFM.Lines.Clear;
    FormDesigner_Net.Texto_TXT.Lines.Clear;
    FormDesigner_Net.Texto_DFM.Lines.LoadFromFile(FormDesigner_Net.CurrentEdit.Filename_dfm);
    if Copy(Trim(FormDesigner_Net.Texto_DFM.Lines[0]), 01, 06) <> 'object' then
    begin
      FormDesigner_Net.Texto_TXT.Lines.Clear;
      LoadDFMFile2Strings(FormDesigner_Net.CurrentEdit.Filename_dfm, FormDesigner_Net.Texto_DFM.Lines, bWasText);
    end;
    Inicio := False;
    FormAguarde.GaugeProcesso.Max := FormDesigner_Net.Texto_DFM.Lines.Count-1;
    PropForm.Cabecalho := FormDesigner_Net.Texto_DFM.Lines[0];
    PropForm.Nome := Trim(PropForm.Cabecalho);
    PropForm.Nome := Trim(Copy(PropForm.Nome, Pos(':', PropForm.Nome)+1, Length(PropForm.Nome)));
    PropForm.Nome := Trim(Copy(PropForm.Nome, 2, Length(PropForm.Nome)));
    FormDesigner_Net.Texto_TXT.Lines.Add(FormDesigner_Net.Texto_DFM.Lines[0]);
    for I:=1 to FormDesigner_Net.Texto_DFM.Lines.Count-1 do
    begin
      FormAguarde.GaugeProcesso.Position := I;
      Linha := FormDesigner_Net.Texto_DFM.Lines[I];
      if not Inicio then
      begin
        if LowerCase(Copy(Trim(Linha), 01, 07)) = 'object ' then
          Inicio := True;
      end;
      if LowerCase(Copy(Trim(Linha), 01, 02)) = 'on' then
      begin
        NomeComp := Localiza_Nome(TStringList(FormDesigner_Net.Texto_DFM.Lines),Pos('O',UpperCase(Linha))-3,I);
        NomeComp := NomeComp + ':' + Trim(Copy(Trim(Linha),Pos('=',Trim(Linha))+1,Length(Trim(Linha))));
        FormDesigner_Net.CurrentEdit.CaretY := 0;
        FormDesigner_Net.CurrentEdit.CaretX := 0;
        FormDesigner_Net.CurrentEdit.SearchReplace(Copy(NomeComp,Pos(':',NomeComp)+1,Length(NomeComp)),'', SearchOptionsPd);
        if FormDesigner_Net.CurrentEdit.CaretY > 1 then  // vamos ver se o evento existe
          if ListaEventos.IndexOf(LowerCase(NomeComp)) = -1 then
            ListaEventos.Add(LowerCase(NomeComp));
        //FormDesigner_Net.Texto_TXT.Lines.Add(Linha);
      end
      else
      begin
        if not Inicio then
        begin
          if LerAtributo(Linha, 'visible') <> '' then
          begin
            FormDesigner_Net.Texto_TXT.Lines.Add('  Visible = True');
            PropForm.Visible := LerAtributo(Linha, 'visible');
          end
          else if LerAtributo(Linha, 'formstyle') <> '' then
          begin
            FormDesigner_Net.Texto_TXT.Lines.Add('  FormStyle = fsNormal');
            PropForm.FormStyle := LerAtributo(Linha, 'formstyle');
          end
          else if LerAtributo(Linha, 'borderstyle') <> '' then
          begin
            FormDesigner_Net.Texto_TXT.Lines.Add('  BorderStyle = bsSizeable');
            PropForm.BorderStyle := LerAtributo(Linha, 'borderstyle');
          end
          else if LerAtributo(Linha, 'BorderIcons') <> '' then
          begin
            FormDesigner_Net.Texto_TXT.Lines.Add('  BorderIcons = [biSystemMenu]');
            PropForm.BorderIcons := LerAtributo(Linha, 'BorderIcons');
          end
          else if LerAtributo(Linha, 'WindowState') <> '' then
          begin
            PropForm.WindowState := LerAtributo(Linha, 'windowstate');
          end
          else if LerAtributo(Linha, 'Position') <> '' then
          begin
            PropForm.Position := LerAtributo(Linha, 'position');
          end
          else
            FormDesigner_Net.Texto_TXT.Lines.Add(Linha);
        end
        else
          FormDesigner_Net.Texto_TXT.Lines.Add(Linha);
      end;
    end;
    if not Inicio then
      FormDesigner_Net.Texto_TXT.Lines.Add('end');
    FormDesigner_Net.Texto_TXT.Lines.SaveToFile(FormDesigner_Net.CurrentEdit.Filename_txt);
    cmpFormDesigner.LoadFromDFM(FormDesigner_Net.CurrentEdit.Filename_txt, TDFMFormat(Pred(2)));
    DeleteFile(FormDesigner_Net.CurrentEdit.Filename_txt);
    //listaEventos.SaveToFile('c:\teste.txt');
    FormDesigner_Net.Texto_DFM.Lines.Clear;
    FormDesigner_Net.Texto_TXT.Lines.Clear;
    BorderStyle := bsSizeable;
    BorderIcons := [biSystemMenu];
    Left       := 5;
    Top        := 5;
    Atualiza_CB(True, '', '', Nil);
    //Caption := Titulo;
    hMenuHandle := GetSystemMenu(Self.Handle, FALSE); //Get the handle of the Form
    if (hMenuHandle <> 0) then
    begin
      DeleteMenu(hMenuHandle, SC_MOVE, MF_BYCOMMAND); //disable moving
      //DeleteMenu(hMenuHandle, SC_SIZE, MF_BYCOMMAND); //disable resizing
      DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND); //disable Close
    end;
  Finally
    FormAguarde.Free;
  end;
end;

procedure TFrmXDesig.cmpFormDesignerSelectControl(Sender: TObject;
  TheControl: TControl);
var
  E: Boolean;
begin
  if Assigned(TheControl) then
    {$IFDEF TFD1COMPATIBLE}
    FormObjInsp.btnBloquear.Down:=cmpFormDesigner.FixedControls.IndexOf(TheControl.Name)<>-1;
    {$ELSE}
    FormObjInsp.btnBloquear.Down:=cmpFormDesigner.LockedControls.IndexOf(TheControl.Name)<>-1;
    {$ENDIF}
  UpdateInfo;
  E:=Assigned(cmpFormDesigner.Control);
end;

procedure TFrmXDesig.FormActivate(Sender: TObject);
begin
  ActiveControl:=nil;
  cmpFormDesigner.Update;
end;

procedure TFrmXDesig.FormCreate(Sender: TObject);
begin
  ListaEventos   := TStringList.Create;
  ListaComp      := TStringList.Create;
  BlocoExtra     := TStringList.Create;
  ObjetoExtra    := TStringList.Create;
  ListaComp.Sorted := True;
  cmpFormDesigner.PopupMenu := FormDesigner_Net.PopupDesig;
  Left   := 5;
  Top    := 5;
  Height := 370;
  Width  := 600;
end;

procedure TFrmXDesig.cmpFormDesignerControlDblClick(Sender: TObject;
  TheControl: TControl);
begin
  FormObjInsp.Posiciona_Evento;
  ActiveControl := nil;
  {if Assigned(TheControl) then
    if TheControl is TComponentContainer then
    begin
      if TComponentContainer(TheControl).Component is TfrReport then
        TfrReport(TComponentContainer(TheControl).Component).DesignReport
      else if TComponentContainer(TheControl).Component is TMainMenu then
      begin
        NomeMenu := TComponentContainer(TheControl).Component.Name;
        FormMenuEdit.MItems := TMenu(TComponentContainer(TheControl).Component).Items;
        FormMenuEdit.Show;
      end
      else if TComponentContainer(TheControl).Component is TPopupMenu then
      begin
        NomeMenu := TComponentContainer(TheControl).Component.Name;
        FormMenuEdit.MItems := TPopupMenu(TComponentContainer(TheControl).Component).Items;
        FormMenuEdit.Show;
      end
    end;}
end;

procedure TFrmXDesig.cmpFormDesignerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if FormDesigner_Net.CurrentPage = 1 then
    with FormDesigner_Net, Self do
      case Key of
        VK_DELETE:
          begin
            if Shift=[] then
              FormDesigner_Net.Shift_delete := False
            else
              FormDesigner_Net.Shift_delete := True;
           FormDesigner_Net.ExcluirClick(Self);
          end;
        VK_F11:
          FormObjInsp.Show;
      end;
end;

procedure TFrmXDesig.cmpFormDesignerMoveSizeControl(Sender: TObject;
  TheControl: TControl);
begin
  FormDesigner_Net.CurrentEdit.Modified := True;
  UpdateInfo;
end;

procedure TFrmXDesig.cmpFormDesignerPlaceComponent(Sender: TObject;
  TheComponent: TComponent);
begin
  EditMode_P(FormPrincipal.Paleta);
end;

procedure TFrmXDesig.FormDestroy(Sender: TObject);
begin
  ListaEventos.Free;
  ListaComp.Free;
  BlocoExtra.Free;
  ObjetoExtra.Free;
end;

procedure TFrmXDesig.AbrirEditor(Arquivo, Pesquisa: String; Grid: Boolean; Codificacao: String = ''; Parametros: String = ''; MemoCodificacao: TStrings = Nil);
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
        CaretY := 1;                  // procedure FormShow
        SearchReplace('private ', '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          BlockBegin := Coord;
          BlockEnd   := Coord;
          Y := CaretY - 2;
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
              FormDesigner_Net.CurrentEdit.Lines.Insert(Y+19,'    if (not CamposDadosValidos(ListaCamposEd, ErroValidacao)) or (not TabelaPrincipal.Salva) then');
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
                FormDesigner_Net.CurrentEdit.Lines.Insert(Y+12,'    if (not CamposDadosValidos(ListaCamposEd, ErroValidacao)) or (not TabelaPrincipal.Salva) then');
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

procedure TFrmXDesig.AtribuiUsesComp(Classe: String; Texto: TSynEdit);
Const
  N_Classe: Array[0..195] of String =
            ('TMainMenu', 'TPopupMenu', 'TLabel', 'TEdit', 'TMemo', 'TButton', 'TCheckBox',
             'TRadioButton', 'TListBox', 'TComboBox', 'TScrollBar', 'TGroupBox',
             'TRadioGroup', 'TPanel', 'TGauge', 'TColorGrid', 'TSpinButton', 'TSpinEdit', 'TActionList',
             'TBitBtn', 'TSpeedButton', 'TMaskEdit', 'TStringGrid', 'TDrawGrid', 'TImage',
             'TShape', 'TBevel', 'TScrollBox', 'TCheckListBox', 'TSplitter', 'TStaticText',
             'TControlBar', 'TApplicationEvents', 'TChart', 'TDirectoryOutLine',
             'TCalendar', 'TScroller',
             'TTabControl', 'TPageControl', 'TRichEdit', 'TTrackBar', 'TProgressBar',
             'TUpDown', 'THotKey', 'TAnimate', 'TDateTimePicker', 'TMonthCalendar',
             'TTreeView', 'TListView', 'TheaderControl', 'TStatusBar', 'TToolBar',
             'TCoolBar', 'TPageScroller',
             'TTimer', 'TPaintBox', 'TMediaPlayer', 'TOleContainer',
             'TDataSource', 'TDBGrid', 'TDBNavigator', 'TDBText', 'TDBEdit', 'TDBMemo',
             'TDBImage', 'TDBListBox', 'TDBComboBox', 'TDBCheckBox', 'TDBRadioGroup',
             'TDBLookupListBox', 'TDBLookupComboBox', 'TDBRichEdit', 'TDBCtrlGrid',
             'TDBChart',
             'TIBTable', 'TIBQuery', 'TIBStoredProc', 'TIBDatabase', 'TIBTransaction', 'TIBUpdateSQL',
             'TIBDataSet', 'TIBSQL', 'TIBDatabaseInfo', 'TIBSQLMonitor', 'TIBEvents', 'TIBExtract',
             'TADOConnection', 'TADOCommand', 'TADODataSet', 'TADOTable', 'TADOQuery',
             'TADOStoredProc', 'TRDSConnection',
             'TOpenDialog', 'TSaveDialog', 'TOpenPictureDialog', 'TSavePictureDialog',
             'TFontDialog', 'TColorDialog', 'TPrintDialog', 'TPrinterSetupDialog',
             'TFindDialog', 'TReplaceDialog', 'TRXLoginDialog',
             'TTabSet', 'TOutLine', 'TTabbedNotebook', 'TNotebook', 'THeader',
             'TFileListBox', 'TDirectoryListBox', 'TDriveComboBox', 'TFilterComboBox',
             'TDBLookupList', 'TDBLookupCombo',
             'TXDateEdit', 'TXNumEdit', 'TXEdit', 'TXDBDateEdit', 'TXDBNumEdit', 'TXDBEdit',
             'TXDBLookup', 'TXBanner', 'TXLabel3D', 'TSMDBGrid',
             'TComboEdit', 'TFileNameEdit', 'TDirectoryEdit', 'TDateEdit',
             'TRXCalcEdit', 'TCurrencyEdit', 'TTextListBox', 'TRxCheckListBox',
             'TFontComboBox', 'TColorComboBox', 'TRxRichEdit',
             'TRxGIFAnimator', 'TRxSwitch', 'TRxDice',
             'TRxDBGrid', 'TRxDBLookupList', 'TRxDBLookupCombo',
             'TDBDateEdit', 'TRxDBCalcEdit', 'TRxDBRichEdit',
             'TRxDBComboBox',
             'TfrReport', 'TfrCompositeReport', 'TfrDBDataSet', 'TfrUserDataSet',
             'TfrOleObject', 'TfrRichObject', 'TfrCheckBoxObject', 'TfrShapeObject',
             'TfrBarCodeObject', 'TfrChartObject', 'TfrRoundRectObject', 'TfrTextExport',
             'TfrRTFExport', 'TfrCSVExport', 'TfrHTMExport', 'TfrDesigner', 'TfrPreview',
             'TQuickRep', 'TQRSubDetail', 'TQRStringsBand', 'TQRBand', 'TQRChildBand',
             'TQRGroup', 'TQRLabel', 'TQRDBText', 'TQRExpr', 'TQRSysData', 'TQRMemo',
             'TQRExprMemo', 'TQRRichText', 'TQRDBRichText', 'TQRShape', 'TQRImage',
             'TQRDBImage', 'TQRCompositeReport', 'TQRPreview', 'TQRTextFilter',
             'TQRCSVFilter', 'TQRHTMLFilter', 'TQRChart',
             'TOgMakeKeys', 'TOgMakeCodes', 'TOgDateCode', 'TOgDaysCode', 'TOgNetCode',
             'TOgRegistrationCode', 'TOgSerialNumberCode', 'TOgSpecialCode', 'TOgUsageCode',
             'TOgProtectExe');

  N_Unit: Array[0..195] of String =
            ('menus', 'menus', 'stdctrls', 'stdctrls', 'stdctrls', 'stdctrls', 'stdctrls',
             'stdctrls', 'stdctrls', 'stdctrls', 'stdctrls', 'stdctrls',
             'extctrls', 'extctrls', 'Gauges', 'ColorGrd', 'Spin', 'Spin', 'ActnList',
             'buttons', 'buttons', 'mask', 'grids', 'grids', 'extctrls',
             'extctrls', 'extctrls', 'forms', 'checklst', 'extctrls', 'stdctrls',
             'Extctrls', 'Appevnts', 'Chart', 'DirOutln',
             'Calendar', 'tabs',
             'comctrls', 'comctrls', 'comctrls', 'comctrls', 'comctrls',
             'comctrls', 'comctrls', 'comctrls', 'comctrls', 'Comctrls',
             'comctrls', 'comctrls', 'comctrls', 'comctrls', 'comctrls',
             'comctrls', 'Comctrls',
             'extctrls', 'extctrls', 'mplayer', 'olectnrs',
             'db', 'dbgrids', 'dbctrls', 'dbctrls', 'dbctrls', 'dbctrls',
             'dbctrls', 'dbctrls', 'dbctrls', 'dbctrls', 'dbctrls',
             'dbctrls', 'dbctrls', 'dbctrls', 'dbcgrids',
             'DBChart',
             'IBTable', 'IBQuery', 'IBStoredProc', 'IBDataBase', 'IBDataBase', 'IBUpdateSQL',
             'IBCustomDataSet', 'IBSQL', 'IBDatabaseInfo', 'IBSQLMonitor', 'IBEvents', 'IBExtract',
             'ADOdb', 'ADOdb', 'ADOdb', 'ADOdb', 'ADOdb',
             'ADOdb', 'ADOdb',
             'dialogs', 'dialogs', 'extdlgs', 'extdlgs',
             'dialogs', 'dialogs', 'dialogs', 'dialogs',
             'dialogs', 'dialogs', 'RxLogin',
             'tabs', 'Outline', 'tabnotbk', 'extctrls', 'extctrls',
             'filectrl', 'filectrl', 'filectrl', 'filectrl',
             'dbctrls', 'dblookup',
             'XDate', 'XNum', 'XEdit', 'XDBDate', 'XDBNum', 'XDBEdit',
             'XLookup', 'XBanner', 'XLabel3D', 'SMDBGrid',
             'ToolEdit', 'ToolEdit', 'ToolEdit', 'ToolEdit',
             'CurrEdit', 'CurrEdit', 'RXCtrls', 'RXCtrls',
             'RxCombos', 'RxCombos', 'RxRichEd',
             'GIFCtrl', 'RXSwitch', 'RXDice',
             'RXDBCtrl', 'RxLookup', 'RxLookup',
             'RXDBCtrl', 'RXDBCtrl', 'DBRichEd',
             'RxDBComb',
             'FR_Class', 'FR_Class', 'FR_DBSet', 'FR_DSet',
             'FR_OLE', 'FR_Rich', 'FR_ChBox', 'FR_Shape',
             'FR_BarC', 'FR_Chart', 'FR_RRect', 'FR_E_TXT',
             'FR_E_RTF', 'FR_E_CSV', 'FR_E_HTM', 'FR_Desgn', 'FR_View',
             'Quickrpt', 'Quickrpt', 'Quickrpt', 'Quickrpt', 'Quickrpt',
             'Quickrpt', 'QRCTRLS', 'QRCTRLS', 'QRCTRLS', 'QRCTRLS', 'QRCTRLS',
             'QRCTRLS', 'QRCTRLS', 'QRCTRLS', 'QRCTRLS', 'QRCTRLS',
             'QRCTRLS', 'Quickrpt', 'QRPrntr', 'Quickrpt',
             'QRExport', 'QRExport', 'QRTee',
             'OnGuard', 'OnGuard', 'OnGuard', 'OnGuard', 'OgNetWrk',
             'OnGuard', 'OnGuard', 'OnGuard', 'OnGuard',
             'OgProExe');

var
  Achou, Achou2: Boolean;
  Unit_Nome: String;
  I: Integer;
begin
  Unit_Nome := '';
  for I:=0 to 195 do
    if LowerCase(N_Classe[I]) = LowerCase(Classe) then
    begin
      Unit_Nome := N_Unit[I];
      break;
    end;
  if Unit_Nome <> '' then
    with Texto do
    begin
      CaretX := 1;
      CaretY := 1;
      SearchReplace('uses', '', SearchOptionsPd );
      if CaretY > 1 then
      begin
        Achou  := False;
        Achou2 := False;
        CaretY := CaretY - 1;
        while (not Achou) and (CaretY <= Lines.Count-1) do
        begin
          if Pos(LowerCase(Unit_Nome)+',', LowerCase(RetiraEspacos(Lines[CaretY]))) > 0 then
            Achou2 := True
          else if Pos(LowerCase(Unit_Nome)+';', LowerCase(RetiraEspacos(Lines[CaretY]))) > 0 then
            Achou2 := True
          else
            if Pos(LowerCase(Unit_Nome)+' ', LowerCase(Lines[CaretY])) > 0 then
              Achou2 := True;
          if Pos(';',Lines[CaretY]) > 0 then
            Achou := True
          else
            CaretY := CaretY + 1;
        end;
        if (Achou) and (not Achou2) then
        begin
          Lines[CaretY] := TrocaString(Lines[CaretY],';','',[rfReplaceAll]);
          if Length(Lines[CaretY]) > 80 then
          begin
            Lines[CaretY] := Lines[CaretY] + ', ';
            Lines.Insert(CaretY + 1, '  ' + Unit_Nome + ';');
          end
          else
            Lines[CaretY] := Lines[CaretY] + ', ' + Unit_Nome + ';';
        end;
      end;
      CaretX := 1;
      CaretY := 1;
    end;
end;

procedure TFrmXDesig.AtribuiUses(Arquivo: String);
var
  Achou, Achou2: Boolean;
begin
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

procedure TFrmXDesig.Atualiza_CB(Update: Boolean; Nome, Classe: String; Comp_CB: TComponent);
var
  I, Y: Integer;

  procedure Add_ListView(Component: TComponent);
  begin
    if //not (Component is TControl) and
      //not (Component is TMenuItem) and
      //not (Component is TCustomFormDesigner) then
      Assigned(cmpFormDesigner.FindComponentContainer(Component)) then
    begin
      //FormDesigner_Net.ListView_nao_visuais.Items.Add;
      //Y := FormDesigner_Net.ListView_nao_visuais.Items.Count-1;
      //FormDesigner_Net.ListView_nao_visuais.Items[Y].Caption    := Component.Name;
      //FormDesigner_Net.ListView_nao_visuais.Items[Y].Data       := Component;
      //FormDesigner_Net.ListView_nao_visuais.Items[Y].ImageIndex := 1;
    end;
  end;

begin
  if Update then
  begin
    ListaComp.Clear;
    ListaComp.Add(Name + ': ' + ClassName);
    //FormDesigner_Net.ListView_nao_visuais.Items.Clear;
    for I:=0 to ComponentCount-1 do
      if (Components[I].ClassName <> 'TFormDesigner') and
         (Components[I].ClassName <> 'TComponentContainer') then
      begin
        ListaComp.Add(Components[I].Name + ': ' + Components[I].ClassName);
        Add_ListView(Components[I]);
      end;
    //FormObjInsp.ComponentTree.Root := Self;
    FormObjInsp.CB1.Items.Clear;
    FormObjInsp.CB1.Items.AddStrings(ListaComp);
    cmpFormDesigner.UnselectAll;
  end;
  if Nome <> '' then
    if FormObjInsp.CB1.Items.IndexOf(Nome + ': ' + Classe) = -1 then
    begin
      FormObjInsp.CB1.Items.Add(Nome + ': ' + Classe);
      if ListaComp.IndexOf(Nome + ': ' + Classe) = -1 then
      begin
        ListaComp.Add(Nome + ': ' + Classe);
        Add_ListView(Comp_CB);
        //FormObjInsp.ComponentTree.Root := Self;
      end;
    end;
end;

procedure TFrmXDesig.cmpFormDesignerAddControl(Sender: TObject;
  TheControl: TControl);
begin
  FormDesigner_Net.CurrentEdit.Modified := True;
  if TheControl is TComponentContainer then
    Atualiza_CB(False, TComponentContainer(TheControl).Component.Name, TComponentContainer(TheControl).Component.ClassName, TComponentContainer(TheControl).Component)
  else
    Atualiza_CB(False, TheControl.Name, TheControl.ClassName, TheControl);
end;

procedure TFrmXDesig.CB1Click(Sender: TObject);
var
  Componente: TComponent;
  Control : TControl;
  TipoComp: String;
  I: Integer;
  Container: Boolean;
begin
  if FormObjInsp.CB1.ItemIndex = -1 then
    exit;
  TipoComp := Trim(Copy(FormObjInsp.CB1.Text,Pos(':',FormObjInsp.CB1.Text)+1,Length(FormObjInsp.CB1.Text)));
  if LowerCase(TipoComp) = 'tformdesig' then
    Componente := Self
  else
  begin
    TipoComp := Trim(Copy(FormObjInsp.CB1.Text, 01, Pos(':',FormObjInsp.CB1.Text)-1));
    Componente := FindComponent(TipoComp);
  end;
  if Assigned(Componente) then
  begin
    Container := False;
    Control := TControl(Componente);
    if Assigned(cmpFormDesigner.FindComponentContainer(Componente)) then
    begin
      Control := cmpFormDesigner.FindComponentContainer(Componente);
      Control.BringToFront;
      Container := true;
    end;
    if not VamosGravar then
    begin
      cmpFormDesigner.ClearControls;
      if ((Componente is TControl) or Container) and
        (Control.Parent is TWinControl) and
        (TWinControl(Control.Parent).HandleAllocated) and
        (Control.Parent.Showing) then
        cmpFormDesigner.AddControl(Control)
      else
        FormObjInsp.Atribui(Control, True);
    end;
  end;
end;

procedure TFrmXDesig.SalvarFormulario;
var
  I, Y, P_Bloco: Integer;
  Linha, UltLinha: String;
  Inicio, Final, T_Bloco: Boolean;
  TextoTxt_C: TStringList;

  function Posicao_Insert: Integer;
  var
    P: Integer;
  begin
    Posicao_Insert := TextoTxt_C.Count-1;
    for P:=TextoTxt_C.Count-1 downto 0 do
      if LowerCase(Trim(TextoTxt_C[P])) <> 'end' then
      begin
        Posicao_Insert := P + 1;
        break;
      end;
  end;

  procedure AlteraProp;
  var
    T, Z: Integer;
    NomeComp, Linha_ev: String;
    v_prop: array[0..5] of Boolean;
    FormP: Boolean;
  begin
    For T:=1 to FormDesigner_Net.Texto_DFM.Lines.Count-1 do
    begin
      Linha := FormDesigner_Net.Texto_DFM.Lines[T];
      if LowerCase(Copy(TrimLeft(Linha), 01, 07)) = 'object ' then
        Break
      else
      begin
        if LerAtributo(Linha, 'visible') <> '' then
        begin
          FormDesigner_Net.Texto_DFM.Lines[T] := '  Visible = ' + PropForm.Visible;
          v_prop[0] := True;
        end
        else if LerAtributo(Linha, 'formstyle') <> '' then
        begin
          FormDesigner_Net.Texto_DFM.Lines[T] := '  FormStyle = ' + PropForm.FormStyle;
          v_prop[1] := True;
        end
        else if LerAtributo(Linha, 'borderstyle') <> '' then
        begin
          FormDesigner_Net.Texto_DFM.Lines[T] := '  BorderStyle = ' + PropForm.BorderStyle;
          v_prop[2] := True;
        end
        else if LerAtributo(Linha, 'BorderIcons') <> '' then
        begin
          FormDesigner_Net.Texto_DFM.Lines[T] := '  BorderIcons = ' + PropForm.BorderIcons;
          v_prop[3] := True;
        end
        else if LerAtributo(Linha, 'WindowState') <> '' then
        begin
          FormDesigner_Net.Texto_DFM.Lines[T] := '  WindowState = ' + PropForm.WindowState;
          v_prop[4] := True;
        end
        else if LerAtributo(Linha, 'Position') <> '' then
        begin
          FormDesigner_Net.Texto_DFM.Lines[T] := '  Position = ' + PropForm.Position;
          v_prop[5] := True;
        end;
      end;
    end;
    if not v_prop[1] then
      FormDesigner_Net.Texto_DFM.Lines.Insert(1, '  FormStyle = ' + PropForm.FormStyle);
    if not v_prop[5] then
      FormDesigner_Net.Texto_DFM.Lines.Insert(1, '  Position = ' + PropForm.Position);
    if not v_prop[0] then
      FormDesigner_Net.Texto_DFM.Lines.Insert(1, '  Visible = ' + PropForm.Visible);
    if not v_prop[2] then
      FormDesigner_Net.Texto_DFM.Lines.Insert(1, '  BorderStyle = ' + PropForm.BorderStyle);
    if not v_prop[3] then
      FormDesigner_Net.Texto_DFM.Lines.Insert(1, '  BorderIcons = ' + PropForm.BorderIcons);
    if not v_prop[4] then
      FormDesigner_Net.Texto_DFM.Lines.Insert(1, '  WindowState = ' + PropForm.WindowState);
    TextoTxt_C := TStringList.Create;
    T := 0;
    NomeComp := '';
    while T <= FormDesigner_Net.Texto_DFM.Lines.Count-1 do
    begin
      Linha := FormDesigner_Net.Texto_DFM.Lines[T];
      if (Copy(UpperCase(TrimLeft(Linha)), 01, 07) = 'OBJECT ') or
         (UpperCase(TrimRight(Linha)) = 'END') then
      begin
        if Trim(NomeComp) <> '' then
        begin
          for Z:=0 to ListaEventos.Count-1 do
            if UpperCase(Copy(ListaEventos[Z],01,Pos(':',ListaEventos[Z])-1)) = UpperCase(NomeComp) then
            begin
              Linha_ev := ListaEventos[Z];
              Linha_ev := Copy(Linha_ev,Pos(':',Linha_ev)+1,Length(Linha_ev));
              if not FormP then
                Linha_ev := Copy(Linha_ev,Length(NomeComp)+1,Length(Linha_ev));
              if Trim(Linha_ev) <> '' then
              begin
                FormDesigner_Net.CurrentEdit(Index).CaretY := 0;
                FormDesigner_Net.CurrentEdit(Index).CaretX := 0;
                if not FormP then
                  FormDesigner_Net.CurrentEdit(Index).SearchReplace(NomeComp + Linha_ev,'', SearchOptionsPd)
                else
                  FormDesigner_Net.CurrentEdit(Index).SearchReplace(Linha_ev,'', SearchOptionsPd);
                if FormDesigner_Net.CurrentEdit(Index).CaretY > 1 then  // vamos ver se o evento existe
                begin
                  if not FormP then
                  begin
                    Linha_ev := 'On' + Linha_ev + ' = ' + NomeComp + Linha_ev;
                    if LowerCase(Trim(TextoTxt_C[TextoTxt_C.Count-1])) = 'end' then
                      TextoTxt_C.Insert(Posicao_Insert, Space(Pos('O',UpperCase(UltLinha))+1)+Linha_ev)
                    else
                      TextoTxt_C.Add(Space(Pos('O',UpperCase(UltLinha))+1)+Linha_ev);
                  end
                  else
                  begin
                    Linha_ev := '  On' + Trim(Copy(Linha_ev, 5, Length(Linha_ev))) + ' = ' + Linha_ev;
                    TextoTxt_C.Add(Linha_ev);
                  end;
                  inc(Y);
                end;
              end;
            end;
        end;
        if T = 0 then
        begin
          NomeComp := PropForm.Nome;
          FormP := True;
        end
        else
        begin
          NomeComp := Extrai_Nome(Trim(Linha));
          FormP := False;
        end;
        UltLinha := Linha;
      end;
      TextoTxt_C.Add(Linha);
      Inc(T);
    end;
    FormDesigner_Net.Texto_DFM.Lines.Clear;
    FormDesigner_Net.Texto_DFM.Lines.AddStrings(TextoTxt_C);
    TextoTxt_C.Free;
  end;

begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Salvando formulário ...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := 0;
  try
    CopiaArquivo(FormDesigner_Net.CurrentEdit(Index).Filename_dfm, TrocaString(FormDesigner_Net.CurrentEdit(Index).Filename_dfm, '.dfm', '.~fm', [rfReplaceAll, rfIgnoreCase]));
    CopiaArquivo(FormDesigner_Net.CurrentEdit(Index).Filename, TrocaString(FormDesigner_Net.CurrentEdit(Index).Filename, '.pas', '.~as', [rfReplaceAll, rfIgnoreCase]));
    OnActivate := Nil;
    OnClose    := Nil;
    OnCreate   := Nil;
    OnDestroy  := Nil;
    OnShow     := Nil;
    cmpFormDesigner.SaveToDFM(FormDesigner_Net.CurrentEdit(Index).Filename_dfm, TDFMFormat(Pred(2)));
    OnActivate := FormActivate;
    OnClose    := FormClose;
    OnCreate   := FormCreate;
    OnDestroy  := FormDestroy;
    OnShow     := FormShow;
    FormDesigner_Net.Texto_DFM.Lines.Clear;
    FormDesigner_Net.Texto_DFM.Lines.LoadFromFile(FormDesigner_Net.CurrentEdit(Index).Filename_dfm);
    FormDesigner_Net.Texto_DFM.Lines[0] := PropForm.Cabecalho;
    AlteraProp;
    if (BlocoExtra.Count > 0) then
    begin
      FormDesigner_Net.Texto_DFM.Lines.Delete(FormDesigner_Net.Texto_DFM.Lines.Count-1);
      FormDesigner_Net.Texto_DFM.Lines.AddStrings(BlocoExtra);
      FormDesigner_Net.Texto_DFM.Lines.Add('end');
    end;
    FormDesigner_Net.Texto_DFM.Lines.SaveToFile(FormDesigner_Net.CurrentEdit(Index).Filename_dfm);
    Inicio := False;
    Final  := False;
    FormDesigner_Net.Texto_TXT.Lines.Clear;
    FormAguarde.GaugeProcesso.Max := FormDesigner_Net.CurrentEdit(Index).Lines.Count-1;
    T_Bloco := False;
    for I:=0 to FormDesigner_Net.CurrentEdit(Index).Lines.Count-1 do
    begin
      Linha := FormDesigner_Net.CurrentEdit(Index).Lines[I];
      if not T_Bloco then
        if Pos('{01-in', LowerCase(Linha)) > 0 then
          T_Bloco := True;
      if (Not Inicio) and (Not Final) then
        if Pos(LowerCase(PropForm.Nome)+'=class(', LowerCase(RetiraEspacos(Linha))) > 0 then
        begin
          FormDesigner_Net.Texto_TXT.Lines.Add(Linha);
          P_Bloco := FormDesigner_Net.Texto_TXT.Lines.Count;
          Inicio := True;
          For Y:=0 to ListaComp.Count-1 do
            if Pos('tformdesig', LowerCase(ListaComp[Y])) = 0 then
              FormDesigner_Net.Texto_TXT.Lines.Add('    ' +ListaComp[Y]+';');
          For Y:=0 to ObjetoExtra.Count-1 do
            FormDesigner_Net.Texto_TXT.Lines.Add('    ' +Trim(ObjetoExtra[Y])+';');
        end;
      if not Inicio then
        FormDesigner_Net.Texto_TXT.Lines.Add(Linha);
      if not Final then
        if (LowerCase(Copy(TrimLeft(Linha), 01, 10)) = 'procedure ') or
           (LowerCase(Copy(TrimLeft(Linha), 01, 09)) = 'function ') or
           (LowerCase(Copy(TrimLeft(Linha), 01, 07)) = 'private') or
           (LowerCase(Copy(TrimLeft(Linha), 01, 06)) = 'public') or
           (LowerCase(Copy(TrimLeft(Linha), 01, 09)) = 'protected') or
           (LowerCase(Copy(TrimLeft(Linha), 01, 04)) = 'end;') then
         begin
           if T_Bloco then
           begin
             FormDesigner_Net.Texto_TXT.Lines.Insert(P_Bloco, '    {01-Início do Bloco Modular. Modificações não serão preservadas}');
             FormDesigner_Net.Texto_TXT.Lines.Add('    {99-Final do Bloco Modular. Modificações não serão preservadas}');
           end;
           FormDesigner_Net.Texto_TXT.Lines.Add(Linha);
           Inicio := False;
           Final := True;
         end;
      FormAguarde.GaugeProcesso.Position := I;
    end;
    For Y:=0 to ListaComp.Count-1 do
      if Pos('tformdesig', LowerCase(ListaComp[Y])) = 0 then
        AtribuiUsesComp(Trim(Copy(ListaComp[Y], Pos(':',ListaComp[Y])+1, Length(ListaComp[Y]))), FormDesigner_Net.Texto_TXT);
    FormDesigner_Net.Texto_TXT.Lines.SaveToFile(FormDesigner_Net.CurrentEdit(Index).FileName);
    FormDesigner_Net.CurrentEdit(Index).Lines.LoadFromFile(FormDesigner_Net.CurrentEdit(Index).FileName);
    FormDesigner_Net.Texto_TXT.Lines.Clear;
    FormDesigner_Net.CurrentEdit(Index).Modified := False;
  Finally
    FormAguarde.Free;
  end;
end;

procedure TFrmXDesig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if VamosGravar then
    SalvarFormulario;
  cmpFormDesigner.UnselectAll;
end;

function TFrmXDesig.UniqueName(comp: TComponent): String;
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

procedure TFrmXDesig.NovaPagina;
var
  TabSheet: TTabSheet;
begin
  if cmpFormDesigner.ControlCount > 0 then
  begin
    TabSheet := TTabSheet.Create(Self);
    TabSheet.PageControl := TPageControl(cmpFormDesigner.Controls[0]);
    TabSheet.Visible := True;
    TabSheet.Name := UniqueName(TabSheet);
    TPageControl(cmpFormDesigner.Controls[0]).ActivePage := TabSheet;
    Atualiza_CB(False, TabSheet.Name, TabSheet.ClassName, TabSheet);
  end;
end;

procedure TFrmXDesig.PosicionaPagina(Index: Integer);
var
  Comp_Tab: TComponent;
begin
  Comp_Tab := FindComponent('TabPaginas');
  if Assigned(Comp_Tab) then
  begin
    if Index < TTabSet(Comp_Tab).Tabs.Count then
    begin
      TTabSet(Comp_Tab).TabIndex := Index;
      Comp_Tab := FindComponent('NoManutencao');
      if Assigned(Comp_Tab) then
        if Index < TNotebook(Comp_Tab).Pages.Count then
          TNotebook(Comp_Tab).PageIndex := Index;
    end;
  end;
end;

procedure TFrmXDesig.InserirCamposPagina(ListaSelecao: TStringList; P_Titulo, P_Distribuicao, X, Y: Integer);
Var
  I, Linha, Coluna, MaiorTitulo, OrdemTab: Integer;
  ListaOpcs: TStringList;
  TamanhoMaximo, Altura: Integer;
  UmaPagina: Boolean;
  ObjCampo: TObject;
  Ult_Linha, Ult_Coluna, Ult_Width, Ult_EdCampo, Ult_TpCampo, Th_Titulo: Integer;

  procedure AutoTela(X,Y: Integer);
  begin
    if EdCampo = 1 then
    begin
      if (TpCampo = 1) or
         (TpCampo = 7) or
         (TpCampo = 15) or
         (TpCampo = 21) or
         (TpCampo = 23) or
         (TpCampo = 11) then
      begin
        CreateComponent(TXDBEdit,'TXDBEdit',X,Y,True,NomeCampo,'Edit', False);
        //TXDBEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if (TpCampo = 2) or
              (TpCampo = 3) or
              (TpCampo = 8) or
              (TpCampo = 9) or
              (TpCampo = 10) or
              (TpCampo = 12) or
              (TpCampo = 13) or
              (TpCampo = 17) or
              (TpCampo = 18) or
              (TpCampo = 22) or
              (TpCampo = 24) then
      begin
        if Projeto.RXLib then
          CreateComponent(TRxDBCalcEdit,'TRxDBCalcEdit',X,Y,True,NomeCampo,'Edit', False)
        else
          CreateComponent(TXDBNumEdit,'TXDBNumEdit',X,Y,True,NomeCampo,'Edit', False);
        //TXDBNumEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if (TpCampo = 4) or
              (TpCampo = 14) or
              (TpCampo = 16) then
      begin
        if Projeto.RXLib then
          CreateComponent(TDBDateEdit,'TDBDateEdit',X,Y,True,NomeCampo,'Edit', False)
        else
          CreateComponent(TXDBDateEdit,'TXDBDateEdit',X,Y,True,NomeCampo,'Edit', False);
        //TXDBDateEdit(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if (TpCampo = 5) or
              (TpCampo = 19) then
      begin
        CreateComponent(TDBMemo,'TDBMemo',X,Y,True,NomeCampo,'Memo', False);
        //TDBMemo(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if (TpCampo = 6) or
              (TpCampo = 20) then
      begin
        CreateComponent(TDBImage,'TDBImage',X,Y,True,NomeCampo,'Imagem', False);
        //TDBImage(ObjetoAtual).TabOrder := OrdemTab;
      end
      else if (TpCampo = 25) then
      begin
        if Projeto.RXLib then
          CreateComponent(TRxDBRichEdit,'TRxDBRichEdit',X,Y,True,NomeCampo,'RichEdit', False)
        else
          CreateComponent(TDBRichEdit,'TDBRichEdit',X,Y,True,NomeCampo,'RichEdit', False);
      end;
    end
    else if EdCampo = 2 then
    begin
      CreateComponent(TDBComboBox,'TDBComboBox',X,Y,True,NomeCampo,'ComboBox', False);
      //TDBComboBox(ObjetoAtual).TabOrder := OrdemTab;
    end
    else if EdCampo = 3 then
    begin
      CreateComponent(TDBRadioGroup,'TDBRadioGroup',X,Y,True,NomeCampo,'RadioGroup', False);
      //TDBRadioGroup(ObjetoAtual).TabOrder := OrdemTab;
    end
    else if EdCampo = 4 then
    begin
      CreateComponent(TDBCheckBox,'TDBCheckBox',X,Y,True,NomeCampo,'CheckBox', False);
      //TDBCheckBox(ObjetoAtual).TabOrder := OrdemTab;
    end
    else if EdCampo = 5 then
    begin
      if EdEstilo = 0 then
      begin
        CreateComponent(TXDBLookUp,'TXDBLookUp',X,Y,True,NomeCampo,'LookUp', False);
        //TXDBLookUp(ObjetoAtual).TabOrder := OrdemTab;
      end
      else
      begin
        if (TpCampo = 1) or
           (TpCampo = 7) or
           (TpCampo = 15) or
           (TpCampo = 21) or
           (TpCampo = 23) or
           (TpCampo = 11) then
        begin
          CreateComponent(TXDBEdit,'TXDBEdit',X,Y,True,NomeCampo,'Edit', False);
          //TXDBEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if (TpCampo = 2) or
                (TpCampo = 3) or
                (TpCampo = 8) or
                (TpCampo = 9) or
                (TpCampo = 10) or
                (TpCampo = 12) or
                (TpCampo = 13) or
                (TpCampo = 17) or
                (TpCampo = 18) or
                (TpCampo = 22) or
                (TpCampo = 24) then
        begin
          if Projeto.RXLib then
            CreateComponent(TRxDBCalcEdit,'TRxDBCalcEdit',X,Y,True,NomeCampo,'Edit', False)
          else
            CreateComponent(TXDBNumEdit,'TXDBNumEdit',X,Y,True,NomeCampo,'Edit', False);
          //TXDBNumEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if (TpCampo = 4) or
                (TpCampo = 14) or
                (TpCampo = 16) then
        begin
          if Projeto.RXLib then
            CreateComponent(TDBDateEdit,'TDBDateEdit',X,Y,True,NomeCampo,'Edit', False)
          else
            CreateComponent(TXDBDateEdit,'TXDBDateEdit',X,Y,True,NomeCampo,'Edit', False);
          //CreateComponent(TXDBDateEdit,'TXDBDateEdit',X,Y,True,NomeCampo,'Edit', False);
          //TXDBDateEdit(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if (TpCampo = 5) or
                (TpCampo = 19) then
        begin
          CreateComponent(TDBMemo,'TDBMemo',X,Y,True,NomeCampo,'Memo', False);
          //TDBMemo(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if (TpCampo = 6) or
                (TpCampo = 20) then
        begin
          CreateComponent(TDBImage,'TDBImage',X,Y,True,NomeCampo,'Imagem', False);
          //TDBImage(ObjetoAtual).TabOrder := OrdemTab;
        end
        else if (TpCampo = 25) then
        begin
          if Projeto.RXLib then
            CreateComponent(TRxDBRichEdit,'TRxDBRichEdit',X,Y,True,NomeCampo,'RichEdit', False)
          else
            CreateComponent(TDBRichEdit,'TDBRichEdit',X,Y,True,NomeCampo,'RichEdit', False);
        end;
      end;
    end
    else if EdCampo = 6 then
    begin
      CreateComponent(TDBListBox,'TDBListBox',X,Y,True,NomeCampo,'ListBox', False);
    end;
  end;

begin
  if AutoFormatacao then
  begin
    if FindComponent('TabPaginas') <> Nil then
    begin
      TabPaginas := TTabSet(FindComponent('TabPaginas'));
      TabPaginas.Tabs.Clear;
      TabPaginas.Tabs.Add('Principal');
      TabPaginas.TabIndex := 0;
    end;
    //AutoFormatacao := False;
  end;

  if P_Titulo > 0 then
    MaiorTitulo := 6
  else
  begin
    MaiorTitulo := 0;
    for I:=0 to ListaSelecao.Count-1 do
    begin
      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela + 'AND (NOME = '+#39+ListaSelecao[I]+#39+' OR NOME_FISICO = '+#39+ListaSelecao[I]+#39+')';
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
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela + 'AND (NOME = '+#39+ListaSelecao[I]+#39+' OR NOME_FISICO = '+#39+ListaSelecao[I]+#39+')';
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    if not (TabGlobal_i.DCAMPOST.Eof) and (not UmaPagina) then
    begin
      NomeCampo := NomeFisicoCampo;
      NomeObjCampo := TabGlobal_i.DCAMPOST.NOME.Conteudo;
      TpCampo   := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
      EdCampo   := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
      EdEstilo  := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
      EdTitulo  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
      EdLista   := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text;
      EdTamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
      if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
        EdChave := True
      else
        EdChave := False;
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
      TamanhoMaximo := TControl(FindComponent('Pagina0')).Height;
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
            if (Ult_Width + TControl(ObjCampo).Width + Th_Titulo) <= TControl(FindComponent('Pagina0')).Width then
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
  if AutoFormatacao then
  begin
    AutoFormatacao := False;
    if Assigned(TabPaginas) then
      if TabPaginas.Tabs.Count > 0 then
        TabPaginas.TabIndex := 0;
  end;
end;

procedure TFrmXDesig.AutoFormatar;
Var
  I: Integer;
  ListaSelecao: TStringList;
  P_Titulo, P_Distribuicao: Integer;
  Ok: Boolean;
begin
  AutoFormatacao := False;
  Ok := True;
  for I:=0 to 10 do
    if (FindComponent('Pagina'+IntToStr(I))) <> Nil then
      if (FindComponent('Pagina'+IntToStr(I))).ComponentCount > 0 then
        Ok := False;
  if not Ok then
  begin
    Mensagem('Página(s) não vazia(s) !',ModInformacao,[modOk]);
    exit;
  end;
  Ok := False;
  ListaSelecao := TStringList.Create;
  FormAutoForma := TFormAutoForma.Create(Application);
  try
    FormAutoForma.EdRXLib.Checked := Projeto.RXLib;
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela;
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          FormAutoForma.FieldsLB.Items.AddObject(NomeFisicoCampo,TObject(0))
        else
          FormAutoForma.FieldsLB.Items.AddObject(NomeFisicoCampo,TObject(1));
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
      Projeto.RXLib := FormAutoForma.EdRXLib.Checked;
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

function TFrmXDesig.CreateComponent(ComponentClass:TComponentClass; Tipo: String; X, Y: Integer;
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
    exit;
  end;
  Ordem := 0;
  Component := ComponentClass.Create(Self); // FormEntradaDados
  if Campo = '' then
  begin
    if Component is TControl then
    begin
      Control := TControl(Component);
      Control.Name:=UniqueName(Component);
    end
    else begin
      Control.Name:=UniqueName(Component);
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
  if TabPaginas <> Nil then
  begin
    if FindComponent('Pagina'+IntToStr(TabPaginas.TabIndex)) <> Nil then
      Control.Parent := TWinControl(FindComponent('Pagina'+IntToStr(TabPaginas.TabIndex)))
    else
      Control.Parent := TWinControl(cmpFormDesigner.Controls[0]);
  end
  else
    Control.Parent := TWinControl(cmpFormDesigner.Controls[0]);
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
  else if Tipo = 'TDBListBox' then
  begin
    ListaOp := TStringList.Create;
    StringToArray(EdLista,';',ListaOp);
    //TDBListBox(Control).TabStop := False;
    TDBListBox(Control).Items.Clear;
    Altura  := 15 * ListaOp.Count;
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
  else if (Tipo = 'TRxDBCalcEdit') and (TpCampo = 3) then
  begin
    Largura := Largura + 17;
  end
  else if Tipo = 'TXDBDateEdit' then
  begin
    TXDBDateEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end
  else if Tipo = 'TDBDateEdit' then
  begin
    //TXDBDateEdit(Control).ShowButton := True;
    Largura := Largura + 17;
  end;
  if (EdCampo = 5) and (EdEstilo = 1) then
    Largura := Largura + 16;
  Control.Left   := X;
  Control.Top    := Y;
  if (TipoCampo = 'Edit') or (TipoCampo = 'RadioGroup') or
     (TipoCampo = 'SpinEdit') or (TipoCampo = 'ListBox') then
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
  Atualiza_CB(False, Control.Name, Control.ClassName, Control);
  if (TipoCampo <> 'Grid') then
    AtribuiCampo(NomeObjCampo, TabPaginas.TabIndex, EdChave,
                  X, Y, Control.Width, Control.Height)
  else
    AtribuiExtras(Control.Name, TabPaginas.TabIndex, Control.ClassName,
                  X, Y, Control.Width, Control.Height);
  CreateComponent := Control;
end;

procedure TFrmXDesig.AtribuiCampo(Nome: String; Pagina: Integer; EChave: Boolean;
                                     Linha, Coluna, Largura, Altura: Integer);
var I,Y,QtLinhas : Integer;
    Coord: TPoint;
    Pesquisa, ECombo, Titulo, Titulo2: String;
    Achou: Boolean;
    ListaChEst: TStringList;
    StrEvento: String;
    Data: Pointer;
begin
  with FormDesigner_Net.CurrentEdit do
  begin
    CaretY := 1;
    CaretX := 1;
    Pesquisa := 'AtribuiCampoEdicao(TabGlobal.D'+NomeTab+', TabGlobal.D'+NomeTab+'.'+Nome;
    SearchReplace(Pesquisa+',', '', SearchOptionsPd );
    if CaretY <= 1 then
    begin
      // Evento não encontrado, vamos criar !
      CaretX := 1;
      CaretY := 1;
      if (EdCampo = 2) or (EdCampo = 6) then
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
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  '+Pesquisa+', -1, '+Nome+'Exit, '+ECombo+', ListaCamposEd, '+PropForm.Nome+', DataSource, ChamaGridPesquisa);')
        else
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  '+Pesquisa+', -2, '+Nome+'Exit, '+ECombo+', ListaCamposEd, '+PropForm.Nome+', DataSource, ChamaGridPesquisa);');
          //FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'  '+Pesquisa+', '+IntToStr(Pagina)+', '+Nome+'Exit, '+ECombo+', ListaCamposEd, '+PropForm.Nome+', DataSource, ChamaGridPesquisa);');
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
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'procedure T'+PropForm.Nome+'.'+Nome+'Exit(Sender: TObject);');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'var MsgErro : string;');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'begin');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+3,'  if AbandonandoEdicao then');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+4,'    Exit;');
          FormDesigner_Net.CurrentEdit.Lines.Insert(Y+5,'  if not TabGlobal.D'+NomeTab+'.'+Nome+'.Valido(MsgErro, not SalvarRegistro) then');
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
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y,'procedure T'+PropForm.Nome+'.'+Nome+'DrawItem(Control: TWinControl; Index: Integer;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+1,'                                        Rect: TRect; State: TOwnerDrawState);');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+2,'var Canvas : TCanvas;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+3,'begin');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+4,'  if Control is TDBListBox then');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+5,'    Canvas  := (Control as TDBListBox).Canvas');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+6,'  else if Control is TDBComboBox then');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+7,'    Canvas  := (Control as TDBComboBox).Canvas');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+8,'  else');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+9,'    Canvas  := (Control as TComboBox).Canvas;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+10,'  Canvas.FillRect(Rect);');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+11,'  if TabGlobal.D'+NomeTab+'.'+Nome+'.DescValorValido[Index] = '+#39+#39+' then');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+12,'    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal.D'+NomeTab+'.'+Nome+'.ValorValido[Index]))');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+13,'  else');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+14,'    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal.D'+NomeTab+'.'+Nome+'.DescValorValido[Index]));');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+15,'end;');
            FormDesigner_Net.CurrentEdit.Lines.Insert(Y+16,'');
            FormDesigner_Net.CurrentEdit.Modified := True;
            CaretX := 1;
            CaretY := Y+3;
          end;
          exclude( SearchOptionsPd, ssoBackwards );
        end;
      end;
    end;
  end;
end;

procedure TFrmXDesig.ExcluiObjeto(Nome: String);
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

            Pesquisa := RetiraBrancos('procedure T'+PropForm.Nome +'.'+ StrEvento + '(');
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
                   (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE T' + UpperCase(PropForm.Nome) + '.' ) or
                   (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION T' + UpperCase(PropForm.Nome) + '.' ) then
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

procedure TFrmXDesig.InserirCamposDB;
var
  I: Integer;
  ListaSelecao: TStringList;
  Ok: Boolean;
  P_Titulo, P_Distribuicao: Integer;
begin
  TabPaginas := TTabSet(FindComponent('TabPaginas'));
  if cmpFormDesigner.ControlCount <> 1 then
  begin
    Mensagem('Selecione um objeto para destino!', modInformacao, [modOk]);
    exit;
  end;
  Ok := False;
  ListaSelecao := TStringList.Create;
  FormAutoForma := TFormAutoForma.Create(Application);
  try
    FormAutoForma.EdRXLib.Checked := Projeto.RXLib;
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTabela;
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      Ok := True;
      for I:=0 to FormObjInsp.CB1.Items.Count-1 do
        if UpperCase(Copy(FormObjInsp.CB1.Items[I],1,Pos(':',FormObjInsp.CB1.Items[I])-1)) = UpperCase(NomeFisicoCampo) then
          Ok := False;
      if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
         (Ok) then
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          FormAutoForma.FieldsLB.Items.AddObject(NomeFisicoCampo,TObject(0))
        else
          FormAutoForma.FieldsLB.Items.AddObject(NomeFisicoCampo,TObject(1));
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
      Projeto.RXLib := FormAutoForma.EdRXLib.Checked;
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
  if (Ok) and (ListaSelecao.Count >0)then
    InserirCamposPagina(ListaSelecao, P_Titulo, P_Distribuicao, 1, 1);
  ListaSelecao.Free;
end;

procedure TFrmXDesig.Cria_Grid_Relacionamento;
var
  NomeGrid: String;
begin
  TabPaginas := TTabSet(FindComponent('TabPaginas'));
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
        TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+NrTabela+' AND SEQUENCIA = '+IntToStr(Integer(FormGridRelac.FieldsLB_1.Items.Objects[FormGridRelac.FieldsLB_1.ItemIndex]));
        TabGlobal_i.DRELACIONA.AtualizaSql;
        if not TabGlobal_i.DRELACIONA.Eof then
        begin
          EdGridEditavel := FormGridRelac.EdEdicao.Checked;
          EdFormRel := '';
          if Trim(FormGridRelac.EdFormulario.Text) <> '' then
            EdFormRel    := UpperCase(Trim(Copy(FormGridRelac.Edformulario.Text,01,Pos('-',FormGridRelac.EdFormulario.Text)-1)));
          EdNomeTabRel   := Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
          NomeGrid       := 'Grid_' + Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
          EdCampo        := 9;
          CreateComponent(TDBGrid,'TDBGrid',10,10,True,NomeGrid,'Grid', True);
        end
        else
          Mensagem('Tabela não encontrada!' + ^M +^M  + FormGridRelac.FieldsLB_1.Items[FormGridRelac.FieldsLB_1.ItemIndex], ModAdvertencia, [ModOk]);
      end;
  Finally
    FormGridRelac.Free;
  end;
end;

procedure TFrmXDesig.AtribuiExtras(Nome: String; Pagina: Integer; Tipo: String;
                                     Linha, Coluna, Largura, Altura: Integer);
var I,Y : Integer;
    Coord: TPoint;
    Pesquisa, ECombo, NomeComp, StrEvento: String;
    Achou: Boolean;
    Comp: TDataSource;
begin
  begin
    if FindComponent('DataSource_'+Nome) <> Nil then
      Achou := True
    else
      Achou := False;
    with FormDesigner_Net.CurrentEdit do
    begin
      if UpperCase(Tipo) = 'TDBGRID' then
      begin
        if not Achou then
        begin
          Comp := TDataSource.Create(Self);
          Comp.Name := 'DataSource_'+Nome;
          Atualiza_CB(False, Comp.Name, Comp.ClassName, Comp);
        end;
        CaretX := 1;
        CaretY := 1;
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
        Pesquisa := 'procedure T' + PropForm.Nome + '.';
        Pesquisa := Pesquisa + Nome + 'DblClick';
        AbrirEditor(Projeto.Pasta + PropForm.Nome + '.PAS',Pesquisa,True);
        StrEvento := Nome+':'+Nome+'DblClick';
        if ListaEventos.IndexOf(StrEvento) < 0 then
          ListaEventos.Add(StrEvento);

        Pesquisa := 'procedure T' + PropForm.Nome + '.';
        Pesquisa := Pesquisa + Nome + 'ColEnter';
        AbrirEditor(Projeto.Pasta + PropForm.Nome + '.PAS',Pesquisa,True);
        StrEvento := Nome+':'+Nome+'ColEnter';
        if ListaEventos.IndexOf(StrEvento) < 0 then
          ListaEventos.Add(StrEvento);

        Pesquisa := 'procedure T' + PropForm.Nome + '.';
        Pesquisa := Pesquisa + Nome + 'Exit';
        AbrirEditor(Projeto.Pasta + PropForm.Nome + '.PAS',Pesquisa,True);
        StrEvento := Nome+':'+Nome+'Exit';
        if ListaEventos.IndexOf(StrEvento) < 0 then
          ListaEventos.Add(StrEvento);

        Pesquisa := 'procedure T' + PropForm.Nome + '.';
        Pesquisa := Pesquisa + Nome + 'EditButtonClick';
        AbrirEditor(Projeto.Pasta + PropForm.Nome + '.PAS',Pesquisa,True);
        StrEvento := Nome+':'+Nome+'EditButtonClick';
        if ListaEventos.IndexOf(StrEvento) < 0 then
          ListaEventos.Add(StrEvento);

        //Pesquisa := 'procedure TForm' + FormEntradaDados.NomeForm + '.';
        //Pesquisa := Pesquisa + Nome + 'Associacao';
        //AbrirEditor(Projeto.Pasta + FormEntradaDados.NomeForm + '.PAS',Pesquisa,True);
      end;
    end;
  end;
end;

procedure TFrmXDesig.Altera_WinState(Tipo: Integer);
begin
  case Tipo of
    0: begin
         PropForm.WindowState := 'wsNormal';
       end;
    1: begin
         PropForm.WindowState := 'wsMaximized';
       end;
    2: begin
         PropForm.WindowState := 'wsMinimized';
       end;
  end;
end;

procedure TFrmXDesig.Retorna_WinState;
begin
  with FormObjInsp do
  begin
    Normal1.Checked     := False;
    Maximizado1.Checked := False;
    Minimizado1.Checked := False;
    if LowerCase(PropForm.WindowState) = 'wsmaximized' then
      Maximizado1.Checked := True
    else if LowerCase(PropForm.WindowState) = 'wsminimized' then
      Minimizado1.Checked := True
    else
      Normal1.Checked := True;
  end;
end;

procedure TFrmXDesig.Altera_Position(Tipo: Integer);
begin
  case Tipo of
    0: begin
         PropForm.Position := 'poDesigned';
       end;
    1: begin
         PropForm.Position := 'poScreenCenter';
       end;
  end;
end;

procedure TFrmXDesig.Retorna_Position;
begin
  with FormObjInsp do
  begin
    Posicao_Padrao.Checked     := False;
    Posicao_Centralizado.Checked := False;
    if LowerCase(PropForm.Position) = 'poscreencenter' then
      Posicao_Centralizado.Checked := True
    else
      Posicao_Padrao.Checked := True;
  end;
end;

procedure TFrmXDesig.cmpFormDesignerReadError(Reader: TReader;
  const Message: String; var Handled: Boolean);
var
  Classe_Name: String;
  Bloco_Ok: Boolean;
  Nivel: Integer;
begin
  Nivel := 0;
  if Copy(LowerCase(Message), 01, 07) = 'classe ' then
  begin
    try
      Classe_Name := Trim(Copy(LowerCase(Message), 08, Length(Message)));
      Classe_Name := Trim(Copy(LowerCase(Classe_Name), 01, Pos(' n',LowerCase(Classe_Name))));
      with FormDesigner_Net.Texto_DFM do
      begin
        Lines.Clear;
        Lines.LoadFromFile(FormDesigner_Net.CurrentEdit.Filename_dfm);
        CaretX := 1;
        CaretY := 1;
        SearchReplace(Classe_Name, '', SearchOptionsPd );
        if CaretY > 1 then
        begin
          Bloco_Ok := True;
          Nivel := Length(Copy(Lines[CaretY-1], 01, Pos('o', LowerCase(Lines[CaretY-1]))-1));
          if Nivel = 2 then
            while (Bloco_Ok) and (CaretY <= Lines.Count-1) do
            begin
              if (Copy(LowerCase(Trim(Lines[CaretY-1])), 01, 07) = 'object ') and
                 (Pos(':', Lines[CaretY-1]) > 0) then
                ObjetoExtra.Add(TrocaString(Lines[CaretY-1], 'object ', '', [rfReplaceAll, rfIgnoreCase]));
              BlocoExtra.Add(Lines[CaretY-1]);
              CaretY := CaretY + 1;
              if (LowerCase(Trim(Lines[CaretY-1])) = 'end') and
                 (nivel = Length(Copy(Lines[CaretY-1], 01, Pos('e', LowerCase(Lines[CaretY-1]))-1))) then
              begin
                Bloco_Ok := False;
                BlocoExtra.Add(Lines[CaretY-1]);
              end;
            end;
        end;
        Lines.Clear;
      end;
    finally
    end;
  end;
  if Nivel <> 2 then
    Mensagem(Message, modErro, [modOk]);
end;

end.
