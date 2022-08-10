unit Estrutura_Case;    // Tree_Tabelas  Insp_Tabela   Insp_Tabela   DataSource_Campo

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, InspCtrl, DBInspct, ComCtrls, Abertura, Abertura_p, DBCtrls, Grids,
  DBGrids, XBanner, Buttons, ExtCtrls, ImgList, ShellAPI, Menus, Variants;

type
  TFormDB_Case = class(TForm)
    DataSource_Tabela: TDataSource;
    DataSource_Campo: TDataSource;
    XBanner: TXBanner;
    ImageList1: TImageList;
    Panel1: TPanel;
    BtnFechar: TBitBtn;
    BthAjudaTabela: TBitBtn;
    XBanner1: TXBanner;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Tree_Tabelas: TTreeView;
    Insp_Tabela: TDBInspector;
    BtnInserir: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnImportar: TBitBtn;
    BtnHerdar: TBitBtn;
    BtnExtras: TBitBtn;
    BtnOrderm: TBitBtn;
    Insp_Banco: TDBInspector;
    BtnExcluir_Banco: TBitBtn;
    BtnInserir_Banco: TBitBtn;
    Lista_Banco: TListBox;
    DataSource_Banco: TDataSource;
    Image1: TImage;
    OpenGDB: TOpenDialog;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Inserir1: TMenuItem;
    Excluir1: TMenuItem;
    InserirTabela1: TMenuItem;
    InserirCampo1: TMenuItem;
    Excluir2: TMenuItem;
    DataSource_Indice: TDataSource;
    DataSource_Relacionamento: TDataSource;
    DataSource_Processo: TDataSource;
    Inserirndice1: TMenuItem;
    InserirIntegridade1: TMenuItem;
    InserirProcesso1: TMenuItem;
    Inserir2: TMenuItem;
    Label1: TLabel;
    DataSource_Consulta: TDataSource;
    DataSource_Trigger: TDataSource;
    DataSource_Stored: TDataSource;
    DataSource_Scripts: TDataSource;
    DataSource_Diagrama: TDataSource;
    Regerar: TCheckBox;
    StoredProcedure1: TMenuItem;
    Script1: TMenuItem;
    Consulta1: TMenuItem;
    Diagrama1: TMenuItem;
    N1: TMenuItem;
    Trigger1: TMenuItem;
    N2: TMenuItem;
    ObjetosAtivos1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Insp_TabelaGetButtonType(Sender: TObject; TheIndex: Integer;
      var Value: TButtonType);
    procedure Insp_TabelaGetValuesList(Sender: TObject; TheIndex: Integer;
      const Strings: TStrings);
    function Insp_TabelaCallEditor(Sender: TObject;
      TheIndex: Integer): Boolean;
    procedure Insp_TabelaGetBlobEditorType(Sender: TObject; Field: TField;
      var BlobEditorType: TBlobEditorType);
    procedure Insp_TabelaGetEnableExternalEditor(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Tree_TabelasChange(Sender: TObject; Node: TTreeNode);
    procedure BtnFecharClick(Sender: TObject);
    procedure BthAjudaTabelaClick(Sender: TObject);
    procedure Lista_BancoDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Insp_BancoGetButtonType(Sender: TObject; TheIndex: Integer;
      var Value: TButtonType);
    procedure Insp_BancoGetEnableExternalEditor(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure Insp_BancoGetValuesList(Sender: TObject; TheIndex: Integer;
      const Strings: TStrings);
    function Insp_BancoCallEditor(Sender: TObject;
      TheIndex: Integer): Boolean;
    procedure Lista_BancoClick(Sender: TObject);
    procedure BtnInserir_StoredClick(Sender: TObject);
    procedure BtnInserir_ScriptClick(Sender: TObject);
    procedure BtnInserir_DiagramaClick(Sender: TObject);
    procedure BtnInserir_BancoClick(Sender: TObject);
    procedure BtnExcluir_BancoClick(Sender: TObject);
    procedure BtnInserir_TabClick(Sender: TObject);
    procedure BtnInserir_CmpClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure Tree_TabelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Lista_BancoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControl1Change(Sender: TObject);
    procedure Insp_TabelaSelectItem(Sender: TObject; TheIndex: Integer);
    procedure Tree_TabelasDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Tree_TabelasDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BtnImportarClick(Sender: TObject);
    procedure BtnHerdarClick(Sender: TObject);
    procedure BtnExtrasClick(Sender: TObject);
    procedure BtnOrdermClick(Sender: TObject);
    procedure BtnInserir_IndiceClick(Sender: TObject);
    procedure BtnInserir_IntegridadeClick(Sender: TObject);
    procedure BtnInserir_ProcessoClick(Sender: TObject);
    procedure BtnInserir_ConsultaClick(Sender: TObject);
    procedure BtnInserir_TriggerClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure DataSource_BancoUpdateData(Sender: TObject);
    procedure ObjetosAtivos1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Atualiza_Listas(Base, Tabela: Boolean);
    procedure Inicializa;
    function Retorna_NrTab: Integer;
    function Retorna_NodeTab: TTreeNode;
    procedure Gravar;
  public
    { Public declarations }
    Modificou: Boolean;
    function ValidaNomeCampo(S: String; NrTabela: Integer; Posicao: Integer = -1; Tabela: Boolean = False): Boolean;
    function ValidaNomeBanco(S: String; Posicao: Integer): Boolean;
    function ValidaNomeStored(S: String; Posicao: Integer): Boolean;
    function ValidaNomeScript(S: String; Posicao: Integer): Boolean;
    procedure Apos_Valor(TheIndex: Integer);
  end;

var
  FormDB_Case: TFormDB_Case;

implementation

{$R *.DFM}

uses EdFiltro, EdOrdenacao, Rotinas, Princ, Tabela, StrEdit, Selecao, Expressao,
  VValidos, ChaveEst, MiniEditor, ImpEstr, CamposProj, TabOrdem, Aguarde,
  CamposSel, TpIns_Tabela, Relacion, EdProcessos, EdLanctos, EditorSQL,
  EdParametros, QBuilder, QBEIBX, QBuilder_SQL, BaseD, Gera_01, EdTitulos,
  ObjProjeto;

procedure TFormDB_Case.Inicializa;
begin
  TabGlobal_i.DBDADOS.NUMERO.Valor.Visible             := False;

  TabGlobal_i.DTABELAS.NUMERO.Valor.Visible            := False;
  TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Valor.Visible := False;
  //TabGlobal_i.DTABELAS.REGERAR.Valor.Visible           := False;

  TabGlobal_i.DCAMPOST.NUMERO.Valor.Visible            := False;
  TabGlobal_i.DCAMPOST.SEQUENCIA.Valor.Visible         := False;
  TabGlobal_i.DCAMPOST.DESCRICAO.Valor.Visible         := False;
  TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Valor.Visible       := False;
  TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Valor.Visible    := False;
  TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Valor.Visible      := False;
  TabGlobal_i.DCAMPOST.FILTRO_MESTRE.Valor.Visible     := False;
  TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Valor.Visible     := False;
  TabGlobal_i.DCAMPOST.TAB_EXTRA.Valor.Visible         := False;
  TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Valor.Visible       := False;
  TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Valor.Visible       := False;
  TabGlobal_i.DCAMPOST.EXTRA.Valor.Visible             := False;
  TabGlobal_i.DCAMPOST.VARIAVEIS.Valor.Visible         := False;
  TabGlobal_i.DCAMPOST.CODIFICACAO.Valor.Visible       := False;

  TabGlobal_i.DINDICEST.NUMERO.Valor.Visible           := False;
  TabGlobal_i.DINDICEST.SEQUENCIA.Valor.Visible        := False;

  TabGlobal_i.DPROCESSOS.NUMERO.Valor.Visible          := False;
  TabGlobal_i.DPROCESSOS.SEQUENCIA.Valor.Visible       := False;

  TabGlobal_i.DRELACIONA.NUMERO.Valor.Visible          := False;
  TabGlobal_i.DRELACIONA.SEQUENCIA.Valor.Visible       := False;
  TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Valor.Visible  := False;
  TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Valor.Visible  := False;
  TabGlobal_i.DRELACIONA.CAMPOS_VISUAIS.Valor.Visible  := False;
  TabGlobal_i.DRELACIONA.EDICAO_DIRETA.Valor.Visible   := False;
  TabGlobal_i.DRELACIONA.FORMULARIO.Valor.Visible      := False;
  TabGlobal_i.DRELACIONA.ATALHO.Valor.Visible          := False;

  TabGlobal_i.DPROCESSOS.NUMERO.Valor.Visible            := False;
  TabGlobal_i.DPROCESSOS.SEQUENCIA.Valor.Visible         := False;
  TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Valor.Visible        := False;
  TabGlobal_i.DPROCESSOS.CONDICAO.Valor.Visible          := False;
  TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Valor.Visible    := False;
  TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Valor.Visible   := False;
  TabGlobal_i.DPROCESSOS.QUANTIDADE.Valor.Visible        := False;
  TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Valor.Visible := False;
  TabGlobal_i.DPROCESSOS.CONDICAO_EXCLUSAO.Valor.Visible := False;
  TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Valor.Visible       := False;
  TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Valor.Visible      := False;
  TabGlobal_i.DPROCESSOS.AVULSO.Valor.Visible            := False;
  TabGlobal_i.DPROCESSOS.AVULSO_VAR.Valor.Visible        := False;

  TabGlobal_i.DCONSULTA.NUMERO.Valor.Visible             := False;

  TabGlobal_i.DTRIGGER.NUMERO.Valor.Visible              := False;
  TabGlobal_i.DTRIGGER.SEQUENCIA.Valor.Visible           := False;

  TabGlobal_i.DPROC_EXTERNA.NUMERO.Valor.Visible         := False;

  TabGlobal_i.DSQL_SCRIPT.NUMERO.Valor.Visible           := False;

  TabGlobal_i.DDIAGRAMA.NUMERO.Valor.Visible             := False;

  Atualiza_Listas(True, True);
  DataSource_Tabela.DataSet         := TabGlobal_i.DTABELAS;
  DataSource_Campo.DataSet          := TabGlobal_i.DCAMPOST;
  DataSource_Banco.DataSet          := TabGlobal_i.DBDADOS;
  DataSource_Indice.DataSet         := TabGlobal_i.DINDICEST;
  DataSource_Relacionamento.DataSet := TabGlobal_i.DRELACIONA;
  DataSource_Processo.DataSet       := TabGlobal_i.DPROCESSOS;
  DataSource_Consulta.DataSet       := TabGlobal_i.DCONSULTA;
  DataSource_Trigger.DataSet        := TabGlobal_i.DTRIGGER;
  DataSource_Stored.DataSet         := TabGlobal_i.DPROC_EXTERNA;
  DataSource_Scripts.DataSet        := TabGlobal_i.DSQL_SCRIPT;
  DataSource_Diagrama.DataSet       := TabGlobal_i.DDIAGRAMA;

  PageControl1.ActivePageIndex := 1;
  PageControl1Change(Self);
end;

procedure TFormDB_Case.FormShow(Sender: TObject);
begin
  Inicializa;
end;

procedure TFormDB_Case.Atualiza_Listas(Base, Tabela: Boolean);
var
  node, subnode, node_indice, node_relacionamento, node_processo, node_consulta,
  node_triggers, node_stored, node_script, node_diagrama: TTreeNode;
begin
  if Base then
  begin
    Lista_Banco.Items.Clear;
    TabGlobal_i.DBDADOS.ChaveIndice  := 'numero';
    TabGlobal_i.DBDADOS.Filtro       := '';
    TabGlobal_i.DBDADOS.AtualizaSql;
    while not TabGlobal_i.DBDADOS.Eof do
    begin
      if Trim(TabGlobal_i.DBDADOS.NOME.Titulo) <> '' then
        Lista_Banco.Items.AddObject(TabGlobal_i.DBDADOS.NOME.Conteudo, TabGlobal_i.DBDADOS.GetBookmark);
      TabGlobal_i.DBDADOS.Next;
    end;
    TabGlobal_i.DBDADOS.First;
  end;

  if Tabela then
  begin
    TabGlobal_i.DTABELAS.ChaveIndice      := 'nome';
    TabGlobal_i.DCAMPOST.ChaveIndice      := 'numero, sequencia';
    TabGlobal_i.DINDICEST.ChaveIndice     := 'numero, sequencia';
    TabGlobal_i.DRELACIONA.ChaveIndice    := 'numero, sequencia';
    TabGlobal_i.DPROCESSOS.ChaveIndice    := 'numero, sequencia';
    TabGlobal_i.DCONSULTA.ChaveIndice     := 'numero';
    TabGlobal_i.DTRIGGER.ChaveIndice      := 'numero, sequencia';
    TabGlobal_i.DPROC_EXTERNA.ChaveIndice := 'numero';
    TabGlobal_i.DSQL_SCRIPT.ChaveIndice   := 'numero';
    TabGlobal_i.DDIAGRAMA.ChaveIndice     := 'numero';
    TabGlobal_i.DTABELAS.Filtro      := '';
    TabGlobal_i.DCAMPOST.Filtro      := '';
    TabGlobal_i.DINDICEST.Filtro     := '';
    TabGlobal_i.DRELACIONA.Filtro    := '';
    TabGlobal_i.DPROCESSOS.Filtro    := '';
    TabGlobal_i.DCONSULTA.Filtro     := '';
    TabGlobal_i.DTRIGGER.Filtro      := '';
    TabGlobal_i.DPROC_EXTERNA.Filtro := '';
    TabGlobal_i.DSQL_SCRIPT.Filtro   := '';
    TabGlobal_i.DDIAGRAMA.Filtro     := '';
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DINDICEST.AtualizaSql;
    TabGlobal_i.DRELACIONA.AtualizaSql;
    TabGlobal_i.DPROCESSOS.AtualizaSql;
    TabGlobal_i.DCONSULTA.AtualizaSql;
    TabGlobal_i.DTRIGGER.AtualizaSql;
    TabGlobal_i.DPROC_EXTERNA.AtualizaSql;
    TabGlobal_i.DSQL_SCRIPT.AtualizaSql;
    TabGlobal_i.DDIAGRAMA.AtualizaSql;
    Tree_Tabelas.Items.BeginUpdate;
    Tree_Tabelas.Items.Clear;
    TabGlobal_i.DTABELAS.AtualizaSql;

    Node_Stored := Tree_Tabelas.Items.Add(Nil, 'Stored Procedures');
    Node_Stored.ImageIndex    := 7;
    Node_Stored.SelectedIndex := 7;

    while not TabGlobal_i.DPROC_EXTERNA.Eof do
    begin
      SubNode := Tree_Tabelas.Items.AddChildObject(Node_Stored, TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo, TabGlobal_i.DPROC_EXTERNA.GetBookmark);
      SubNode.ImageIndex    := 6;
      SubNode.SelectedIndex := 6;
      TabGlobal_i.DPROC_EXTERNA.Next;
    end;

    Node_Script := Tree_Tabelas.Items.Add(Nil, 'Scripts');
    Node_Script.ImageIndex    := 7;
    Node_Script.SelectedIndex := 7;

    while not TabGlobal_i.DSQL_SCRIPT.Eof do
    begin
      SubNode := Tree_Tabelas.Items.AddChildObject(Node_Script, TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo, TabGlobal_i.DSQL_SCRIPT.GetBookmark);
      SubNode.ImageIndex    := 14;
      SubNode.SelectedIndex := 14;
      TabGlobal_i.DSQL_SCRIPT.Next;
    end;

    Node_Consulta := Tree_Tabelas.Items.Add(Nil, 'Consultas');
    Node_Consulta.ImageIndex    := 7;
    Node_Consulta.SelectedIndex := 7;

    while not TabGlobal_i.DCONSULTA.Eof do
    begin
      SubNode := Tree_Tabelas.Items.AddChildObject(Node_Consulta, TabGlobal_i.DCONSULTA.NOME.Conteudo, TabGlobal_i.DCONSULTA.GetBookmark);
      SubNode.ImageIndex    := 8;
      SubNode.SelectedIndex := 8;
      TabGlobal_i.DCONSULTA.Next;
    end;

    Node_Diagrama := Tree_Tabelas.Items.Add(Nil, 'Diagramas');
    Node_Diagrama.ImageIndex    := 7;
    Node_Diagrama.SelectedIndex := 7;

    while not TabGlobal_i.DDIAGRAMA.Eof do
    begin
      SubNode := Tree_Tabelas.Items.AddChildObject(Node_Diagrama, TabGlobal_i.DDIAGRAMA.TITULO_I.Conteudo, TabGlobal_i.DDIAGRAMA.GetBookmark);
      SubNode.ImageIndex    := 13;
      SubNode.SelectedIndex := 13;
      TabGlobal_i.DDIAGRAMA.Next;
    end;

    while not TabGlobal_i.DTABELAS.eof do
    begin
      Node := Nil;
      Node := Tree_Tabelas.items.AddObject(Node, TabGlobal_i.DTABELAS.NOME.Conteudo, TabGlobal_i.DTABELAS.GetBookmark);
      Node.ImageIndex := 0;
      Node.SelectedIndex := 0;

      Node_Indice := Tree_Tabelas.Items.AddChild(Node, 'Indices');
      Node_Indice.ImageIndex    := 7;
      Node_Indice.SelectedIndex := 7;

      Node_relacionamento := Tree_Tabelas.Items.AddChild(Node, 'Integridades & Relacionamentos');
      Node_relacionamento.ImageIndex    := 7;
      Node_relacionamento.SelectedIndex := 7;

      Node_Processo := Tree_Tabelas.Items.AddChild(Node, 'Processos & Lançamentos');
      Node_Processo.ImageIndex    := 7;
      Node_Processo.SelectedIndex := 7;

      Node_Triggers := Tree_Tabelas.Items.AddChild(Node, 'Triggers (Bloco de Comandos)');
      Node_Triggers.ImageIndex    := 7;
      Node_Triggers.SelectedIndex := 7;

      TabGlobal_i.DINDICEST.First;
      TabGlobal_i.DINDICEST.Locate('numero', TabGlobal_i.DTABELAS.NUMERO.Conteudo, []);
      while (TabGlobal_i.DINDICEST.NUMERO.Conteudo = TabGlobal_i.DTABELAS.NUMERO.Conteudo) and (not TabGlobal_i.DINDICEST.Eof) do
      begin
        SubNode := Tree_Tabelas.Items.AddChildObject(Node_Indice, TabGlobal_i.DINDICEST.TITULO_I.Conteudo, TabGlobal_i.DINDICEST.GetBookmark);
        SubNode.ImageIndex    := 4;
        SubNode.SelectedIndex := 4;
        TabGlobal_i.DINDICEST.Next;
      end;

      TabGlobal_i.DRELACIONA.First;
      TabGlobal_i.DRELACIONA.Locate('numero', TabGlobal_i.DTABELAS.NUMERO.Conteudo, []);
      while (TabGlobal_i.DRELACIONA.NUMERO.Conteudo = TabGlobal_i.DTABELAS.NUMERO.Conteudo) and (not TabGlobal_i.DRELACIONA.Eof) do
      begin
        SubNode := Tree_Tabelas.Items.AddChildObject(Node_Relacionamento, TabGlobal_i.DRELACIONA.TITULO_I.Conteudo, TabGlobal_i.DRELACIONA.GetBookmark);
        SubNode.ImageIndex    := 5;
        SubNode.SelectedIndex := 5;
        TabGlobal_i.DRELACIONA.Next;
      end;

      TabGlobal_i.DPROCESSOS.First;
      TabGlobal_i.DPROCESSOS.Locate('numero', TabGlobal_i.DTABELAS.NUMERO.Conteudo, []);
      while (TabGlobal_i.DPROCESSOS.NUMERO.Conteudo = TabGlobal_i.DTABELAS.NUMERO.Conteudo) and (not TabGlobal_i.DPROCESSOS.Eof) do
      begin
        SubNode := Tree_Tabelas.Items.AddChildObject(Node_Processo, TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo, TabGlobal_i.DPROCESSOS.GetBookmark);
        SubNode.ImageIndex    := 12;
        SubNode.SelectedIndex := 12;
        TabGlobal_i.DPROCESSOS.Next;
      end;

      TabGlobal_i.DTRIGGER.First;
      TabGlobal_i.DTRIGGER.Locate('numero', TabGlobal_i.DTABELAS.NUMERO.Conteudo, []);
      while (TabGlobal_i.DTRIGGER.NUMERO.Conteudo = TabGlobal_i.DTABELAS.NUMERO.Conteudo) and (not TabGlobal_i.DTRIGGER.Eof) do
      begin
        SubNode := Tree_Tabelas.Items.AddChildObject(Node_Triggers, TabGlobal_i.DTRIGGER.NOME.Conteudo, TabGlobal_i.DTRIGGER.GetBookmark);
        SubNode.ImageIndex    := 9;
        SubNode.SelectedIndex := 9;
        TabGlobal_i.DTRIGGER.Next;
      end;

      TabGlobal_i.DCAMPOST.First;
      TabGlobal_i.DCAMPOST.Locate('numero', TabGlobal_i.DTABELAS.NUMERO.Conteudo, []);
      while (TabGlobal_i.DCAMPOST.NUMERO.Conteudo = TabGlobal_i.DTABELAS.NUMERO.Conteudo) and (not TabGlobal_i.DCAMPOST.Eof) do
      begin
        SubNode := Tree_Tabelas.Items.AddChildObject(Node, TabGlobal_i.DCAMPOST.NOME.Conteudo + '  ('+Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]+ ' ' +IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+')', TabGlobal_i.DCAMPOST.GetBookmark);
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          SubNode.ImageIndex := 2
        else if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
          SubNode.ImageIndex := 3
        else
          SubNode.ImageIndex := 1;
        SubNode.SelectedIndex := SubNode.ImageIndex;
        TabGlobal_i.DCAMPOST.Next;
      end;
      TabGlobal_i.DTABELAS.next;
    end;
    Tree_Tabelas.Items.Endupdate;
  end;
end;

procedure TFormDB_Case.Insp_TabelaGetButtonType(Sender: TObject;
  TheIndex: Integer; var Value: TButtonType);
begin
  // btNone,btDropDown,btUpDown,btDialog
  case Insp_Tabela.DataSource.Tag of
    10: Begin
          if (TheIndex = 1) or (TheIndex = 3) or (TheIndex = 7) or (TheIndex = 8) or (TheIndex = 9) then
            Value := btDropDown
          else if (TheIndex = 6) then
            Value := btDialog;
        end;
    20: Begin
          if (TheIndex = 2) or (TheIndex = 3) or (TheIndex = 4) or (TheIndex = 7)
             or (TheIndex = 8) or (TheIndex = 10) or (TheIndex = 15) or (TheIndex = 17)
             or (TheIndex = 19) or (TheIndex = 20) or (TheIndex = 21)
             or (TheIndex = 22) or (TheIndex = 23) or (TheIndex = 26) then
           Value := btDropDown
         else if  (TheIndex = 0) or (TheIndex = 9) or (TheIndex = 11) or (TheIndex = 12) or
                  (TheIndex = 18) or (TheIndex = 25) or (TheIndex = 27) or (TheIndex = 28) then
           Value := btDialog
        end;
    30: Begin
          if (TheIndex = 1) then
            Value := btDialog
          else if (TheIndex = 2) then
            Value := btDropDown;
        end;
    40: Begin
          if (TheIndex = 1) or (TheIndex = 3) or (TheIndex = 4) then
            Value := btDropDown
          else if (TheIndex = 2) then
            Value := btDialog;
        end;
    50: Begin
          if (TheIndex = 1) or (TheIndex = 3) then
            Value := btDropDown
          else if (TheIndex = 2) then
            Value := btDialog;
        end;
    60: Begin
          if (TheIndex = 4) or (TheIndex = 7) then
            Value := btDropDown;
        end;
    70: Begin
           if ((TheIndex >= 1) and (TheIndex <= 2)) or (TheIndex = 5) then
             Value := btDropDown;
        end;
    80: Begin
           if (TheIndex = 4) or (TheIndex = 5) then
             Value := btDropDown;
        end;
    90: Begin
           if (TheIndex = 3) or (TheIndex = 4) or (TheIndex = 6) then
             Value := btDropDown;
        end;
  end;
end;

procedure TFormDB_Case.Insp_TabelaGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
var
  I: Integer;
begin
  Strings.Clear;
  case Insp_Tabela.DataSource.Tag of
    10: Begin
          if (TheIndex = 1) then
          begin
            Strings.Add('');
            for I:=0 to Tree_Tabelas.Items.Count-1 do
              if (Tree_Tabelas.Items[I].Level = 0) and
                 (Tree_Tabelas.Items[I].Index > 3) then
                Strings.Add(Tree_Tabelas.Items[I].Text);
          end
          else if (TheIndex = 3) then
          begin
            for I:=0 to Lista_Banco.Items.Count-1 do
              Strings.Add(Lista_Banco.Items[I]);
          end
          else if (TheIndex = 7) or (TheIndex = 8) or (TheIndex = 9) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end;
        end;
    20: Begin
          if (TheIndex = 2) then
          begin
            for I:=1 to Length(Tipos_Suportados) do
              Strings.Add(Tipos_Suportados[I]);
          end
          else if (TheIndex = 3) then
            for I:=1 to Length(Tipos_Campo_Suportados) do
              Strings.Add(Tipos_Campo_Suportados[I])
          else if (TheIndex = 4) or (TheIndex = 7) or (TheIndex = 10) or
                  (TheIndex = 15) or (TheIndex = 20) or (TheIndex = 23) or
                  (TheIndex = 26) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end
          else if (TheIndex = 8) then
            for I:=1 to Length(Edicoes_Suportados) do
              Strings.Add(Edicoes_Suportados[I])
          else if (TheIndex = 17) then
          begin
            Strings.Add('');
            Strings.Add('DataAtual');
            Strings.Add('HoraAtual');
            Strings.Add('%<Macro>');
          end
          else if (TheIndex = 19) then
          begin
            Strings.Add('Invisível');
            Strings.Add('Não Editável');
          end
          else if (TheIndex = 21) then
          begin
            if FileExists(Projeto.PastaGerador + 'Validacao.Lst') then
              Strings.LoadFromFile(Projeto.PastaGerador + 'Validacao.Lst')
          end
          else if (TheIndex = 22) then
          begin
            TabGlobal_i.DRELACIONA.First;
            TabGlobal_i.DRELACIONA.Locate('numero', TabGlobal_i.DCAMPOST.NUMERO.Conteudo, []);
            Strings.Add('');
            while (not TabGlobal_i.DRELACIONA.Eof) and (TabGlobal_i.DRELACIONA.NUMERO.Conteudo = TabGlobal_i.DCAMPOST.NUMERO.Conteudo) do
            begin
              Strings.Add(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
              TabGlobal_i.DRELACIONA.Next;
            end;
          end;
        end;
    30: Begin
          if (TheIndex = 2) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end
        end;
    40: Begin
          if (TheIndex = 1) then
          begin
            for I:=1 to Length(Tipos_Relacionamento) do
              Strings.Add(Tipos_Relacionamento[I])
          end
          else if (TheIndex = 3) or (TheIndex = 4) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end
        end;
    50: Begin
          if (TheIndex = 1) then
          begin
            for I:=1 to Length(Tipos_Processo) do
              Strings.Add(Tipos_Processo[I])
          end
          else if (TheIndex = 3) or (TheIndex = 4) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end
        end;
    60: Begin
          if (TheIndex = 4) then
          begin
            for I:=0 to Lista_Banco.Items.Count-1 do
              Strings.Add(Lista_Banco.Items[I]);
          end
          else if (TheIndex = 7) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end;
        end;
    70: Begin
          if (TheIndex = 1) then
          begin
            for I:=1 to Length(Tipos_Trigger) do
              Strings.Add(Tipos_Trigger[I])
          end
          else if (TheIndex = 2) then
          begin
            for I:=1 to Length(Disparo_Trigger) do
              Strings.Add(Disparo_Trigger[I])
          end
          else if (TheIndex = 5) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end
        end;
    80: Begin
          if (TheIndex = 4) then
          begin
            for I:=0 to Lista_Banco.Items.Count-1 do
              Strings.Add(Lista_Banco.Items[I]);
          end
          else if (TheIndex = 5) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end
        end;
    90: Begin
          if (TheIndex = 3) then
          begin
            for I:=1 to Length(Tipos_Script) do
              Strings.Add(Tipos_Script[I])
          end
          else if (TheIndex = 4) then
            for I:=0 to Lista_Banco.Items.Count-1 do
              Strings.Add(Lista_Banco.Items[I])
          else if (TheIndex = 6) then
          begin
            Strings.Add('Sim');
            Strings.Add('Não');
          end;
        end;
  end;
end;

function TFormDB_Case.Insp_TabelaCallEditor(Sender: TObject;
  TheIndex: Integer): Boolean;
var
  FormFiltro: TFormFiltro;
  FormOrdenacao: TFormOrdenacao;
  ListaCmp: TStringList;
  I, Posicao: Integer;
  FormExpressao: TFormExpressao;
  OQBDialogIBX: TOQBuilderDialog;
  OQBDialogIBX_SQL: TOQBuilderDialog_SQL;
  OQBEngineIBX: TOQBEngineIBX;

  procedure Campos_PreDefinidos;
  var
    I: Integer;
    NrSel,QtLinhas: Integer;
    Titulo,Titulo2,Valor: String;
  begin
    FormPrincipal.Texto.Lines.LoadFromFile(Projeto.PastaGerador + 'Campos.Tpl');
    FormListaEscolha := TFormListaEscolha.Create(Application);
    Try
      FormListaEscolha.ListaSelecao.Items.Clear;
      I := 0;
      QtLinhas := FormPrincipal.Texto.Lines.Count-1;
      while I <= QtLinhas do
      begin
       if Copy(FormPrincipal.Texto.Lines[I],01,06) = 'Numero' then
       begin
         Titulo := Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1])));
         Titulo2:= Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2])));
         FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[Titulo])+Titulo2);
       end;
       I := I + 12;
      end;
      FormListaEscolha.ShowModal;
    Finally
      NrSel := FormListaEscolha.NumeroSelecao;
      FormListaEscolha.Free;
    end;
    if NrSel <> -1 then
    begin
      TabGlobal_i.DCAMPOST.Modifica;
      I := NrSel;
      I := 11 * I +  I;
      TabGlobal_i.DCAMPOST.NOME.Conteudo := Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1])));
      Valor := Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2])));
      if Valor = 'Alfanumérico' then
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 1
      else if Valor = 'Número Inteiro' then
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 2
      else if Valor = 'Número Fracionário' then
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 3
      else if Valor = 'Data' then
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 4
      else if Valor = 'Memo' then
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 5
      else if Valor = 'Imagem' then
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 6
      else
        TabGlobal_i.DCAMPOST.TIPO.Conteudo := 1;

      TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := StrToIntDef(Trim(Copy(FormPrincipal.Texto.Lines[I+3],Pos('=',FormPrincipal.Texto.Lines[I+3])+2,Length(FormPrincipal.Texto.Lines[I+3]))),0);
      Valor := Trim(Copy(FormPrincipal.Texto.Lines[I+4],Pos('=',FormPrincipal.Texto.Lines[I+4])+2,Length(FormPrincipal.Texto.Lines[I+4])));
      if Valor = 'Edição Padrão ( Edit )' then
        TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 1
      else if Valor = 'Lista Interna ( Combo Drop )' then
        TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 2
      else if Valor = 'Optativo ( Rádio Buttom )' then
        TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 3
      else if Valor = 'Conferência ( Check Box )' then
        TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 4
      else
        TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 1;
        
      TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := Trim(Copy(FormPrincipal.Texto.Lines[I+5],Pos('=',FormPrincipal.Texto.Lines[I+5])+2,Length(FormPrincipal.Texto.Lines[I+5])));
      TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := Trim(Copy(FormPrincipal.Texto.Lines[I+6],Pos('=',FormPrincipal.Texto.Lines[I+6])+2,Length(FormPrincipal.Texto.Lines[I+6])));
      TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := Trim(Copy(FormPrincipal.Texto.Lines[I+7],Pos('=',FormPrincipal.Texto.Lines[I+7])+2,Length(FormPrincipal.Texto.Lines[I+7])));
      TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := Trim(Copy(FormPrincipal.Texto.Lines[I+8],Pos('=',FormPrincipal.Texto.Lines[I+8])+2,Length(FormPrincipal.Texto.Lines[I+8])));
      TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := Trim(Copy(FormPrincipal.Texto.Lines[I+9],Pos('=',FormPrincipal.Texto.Lines[I+9])+2,Length(FormPrincipal.Texto.Lines[I+9])));
      TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString   := Trim(Copy(FormPrincipal.Texto.Lines[I+10],Pos('=',FormPrincipal.Texto.Lines[I+10])+2,Length(FormPrincipal.Texto.Lines[I+10])));
      TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := Trim(Copy(FormPrincipal.Texto.Lines[I+11],Pos('=',FormPrincipal.Texto.Lines[I+11])+2,Length(FormPrincipal.Texto.Lines[I+11])));
      TabGlobal_i.DCAMPOST.Salva;
    end;
    FormPrincipal.Texto.Lines.Clear;
  end;

  procedure Campos_Mascara;
  Var
    Tamanho, I, qt_parcial, YI, TY, Maximo: Integer;
    rel_pict,rel_espelho,rel_xpict,xdecimal,rel_001,rel_002,Xrel_001: String;
    laco: Boolean;
  begin
    Tamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
    FormListaEscolha := TFormListaEscolha.Create(Application);
    Try
      FormListaEscolha.ListaSelecao.Items.Clear;
      if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1) or
         (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 7) or
         (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 21) then
      begin
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['X*'])+'Aceita todos carac. maiúsculo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['x*'])+'Aceita todos carac. minúsculo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['A*'])+'Somente letras em maiúsculo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['a*'])+'Somente letras em minúsculo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['9*'])+'Somente números (0 a 9)');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99:99:99'])+'HORA');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99999-999'])+'CEP');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['999.999.999-99'])+'CPF');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99.999.999/9999-99'])+'CNPJ');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['AAA-9999'])+'Placa de Veículo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['(Z999)Z999-9999'])+'Telefone');
      end
      else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 8) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 9) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 10) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 18) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 22) then
      begin
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[ConstStr('9',Tamanho)])+'Zeros a esquerda visíveis');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[ConstStr('Z',Tamanho-1)+'9'])+'Zeros a esquerda não visíveis');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+ConstStr('9',Tamanho)])+'Zeros a esquerda visíveis');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+ConstStr('Z',Tamanho-1)+'9'])+'Zeros a esquerda não visíveis');
      end
      else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 12) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 13) then
      begin
        if tamanho = 1 then
        begin
          FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['Z'])+'Fracionário positivo');
          FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-Z'])+'Fracionário negativo');
        end
        else if tamanho = 2 then
        begin
          FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['9,9'])+'Fracionário positivo');
          FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-9,9'])+'Fracionário negativo');
        end
        else
        begin
          for Ty := 1 to 2 do
          begin
            rel_xpict  :=ConstStr('Z',tamanho-2)+'99';
            rel_espelho:='';
            maximo     := 1;
            for I:=1 to tamanho do
              if (Length(Copy(rel_xpict,1,tamanho-I)) > 0) and
                 (maximo <= 4) then
              begin
                inc(maximo);
                rel_espelho:=Copy(rel_xpict,1,tamanho-I)+','+Copy(rel_xpict,tamanho-I+1,255);
                laco := True;
                while laco do
                  if Pos(',Z',rel_espelho) > 0 then
                    rel_espelho:=TrocaString(rel_espelho,',Z',',9',[rfReplaceAll])
                  else
                    laco := False;
                xdecimal   :=Copy(rel_espelho,Pos(',',rel_espelho),255);
                xdecimal   :=TrocaString(xdecimal,'Z','9',[rfReplaceAll]);
                rel_espelho:=Copy(rel_espelho,01,Pos(',',rel_espelho)-1)+xdecimal;
                rel_002    :=Copy(rel_espelho,01,Pos(',',rel_espelho)-1);
                rel_001    :='';
                qt_parcial :=0;
                for YI:=Length(rel_002) downto 1 do
                begin
                  rel_001 := rel_001 + Copy(rel_002,YI,01);
                  Inc(qt_parcial);
                  if qt_parcial = 3 then
                  begin
                    rel_001    := rel_001 + '.';
                    qt_parcial := 0;
                  end;
                end;
                Xrel_001 := '';
                for YI:=Length(rel_001) downto 1 do
                  Xrel_001 := Xrel_001 + Copy(rel_001,YI,01);
                rel_001 := Xrel_001;
                if rel_001[1] = '.' then
                  rel_001 := Copy(rel_001,02,255);
                if copy(rel_001,Length(rel_001),01) = 'Z' then
                  rel_001 := copy(rel_001,01,Length(rel_001)-1) + '9';
                rel_espelho:=rel_001+xdecimal;
                if TY = 1 then
                  FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[rel_espelho])+'Fracionário positivo')
                else
                  FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+rel_espelho])+'Fracionário negativo');
              end;
          end;
        end;
      end
      else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 14) or
              (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 16) then
      begin
        if TabGlobal_i.DPROJETO.FORMATODATA.Conteudo = 1 then
          FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99/99/9999'])+'Formato século ativo')
        else
          FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99/99/99'])+'Formato século não ativo');
      end;
      FormListaEscolha.ShowModal;
    Finally
      if FormListaEscolha.NumeroSelecao >= 0 then
      begin
        TabGlobal_i.DCAMPOST.Modifica;
        TabGlobal_i.DCAMPOST.MASCARA.Conteudo := Trim(Copy(FormListaEscolha.ListaSelecao.Items[FormListaEscolha.NumeroSelecao],01,20));
        TabGlobal_i.DCAMPOST.Salva;
      end;
      FormListaEscolha.Free;
    end;
  end;

  procedure Campos_Validos;
  Var
    ListaValidos, ListaDescricao: TStringList;
    I: Integer;
    v_validos, v_descricao: String;
  begin
    ListaValidos  := TStringList.Create;
    ListaDescricao:= TStringList.Create;
    StringToArray(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text,';',ListaValidos, True);
    StringToArray(TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text,';',ListaDescricao, True);
    FormVlValidos := TFormVlValidos.Create(Application);
    Try
      FormVlValidos.ListaSelecao.Items.Clear;
      FormVlValidos.TamanhoCmp := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
      for I:=0 to ListaValidos.Count-1 do
      begin
        if I > ListaDescricao.Count-1 then
          ListaDescricao.Add(ListaValidos[I]);
        FormVlValidos.ListaSelecao.Items.Add(Format('%-'+IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+'s',[ListaValidos[I]])+ListaDescricao[I]);
      end;
      FormVlValidos.ShowModal;
    Finally
      if FormVlValidos.Atualizar then
      begin
        TabGlobal_i.DCAMPOST.Modifica;
        TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString   := '';
        TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := '';
        for I:=0 to FormVlValidos.ListaSelecao.Items.Count-1 do
        begin
          TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString   := TabGlobal_i.DCAMPOST.Validos.Conteudo.Text + Copy(FormVlValidos.ListaSelecao.Items[I],01,FormVlValidos.TamanhoCmp) + ';';
          TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text + Copy(FormVlValidos.ListaSelecao.Items[I],FormVlValidos.TamanhoCmp+01,255) + ';';
        end;
        if Trim(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text) <> '' then
        begin
          v_validos := TrocaString(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text, #$D, '', [rfReplaceAll]);
          v_validos := TrocaString(v_validos, #$A, '', [rfReplaceAll]);
          v_validos := Copy(v_validos,01,Length(v_validos)-1);
          v_descricao := TrocaString(TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text, #$D, '', [rfReplaceAll]);
          v_descricao := TrocaString(v_descricao, #$A, '', [rfReplaceAll]);
          v_descricao := Copy(v_descricao,01,Length(v_descricao)-1);
          TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString   := v_validos;
          TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := v_descricao;
        end;
        if Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) = '' then
          if Pos(';',TabGlobal_i.DCAMPOST.Validos.Conteudo.Text) > 0 then
            TabGlobal_i.DCAMPOST.PADRAO.Conteudo := Copy(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text,01,Pos(';',TabGlobal_i.DCAMPOST.Validos.Conteudo.Text)-1)
          else
            TabGlobal_i.DCAMPOST.PADRAO.Conteudo := TabGlobal_i.DCAMPOST.Validos.Conteudo.Text;
        TabGlobal_i.DCAMPOST.Salva;
      end;
      FormVlValidos.Free;
      ListaValidos.Free;
      ListaDescricao.Free;
    end;
  end;

  procedure Campos_ChaveEstrangeira;
  var
    xtabestrangeira, xcampochave, xcamposvisuais, xtitulo: String;
    i, seq: integer;
    Lancar: Boolean;
  begin
    FormChaveEst := TFormChaveEst.Create(Application);
    Try
      if Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo) = '' then
        Lancar := True;
      TabGlobal_i.DTABELAS.GotoBookmark(Tree_Tabelas.Selected.Parent.Data);
      FormChaveEst.EdTabela.Text      := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' + TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
      FormChaveEst.CamposEdTabela.Items.Text := NomeFisicoCampo;
      FormChaveEst.Tab_Estrangeira    := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
      FormChaveEst.Campo_Chave        := TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo;
      FormChaveEst.Campos_Visuais     := TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo;
      FormChaveEst.EdEstilo.ItemIndex := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
      FormChaveEst.EdAcao.ItemIndex   := TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Conteudo;
      FormChaveEst.Filtro_Mestre.AddStrings(TabGlobal_i.DCAMPOST.FILTRO_MESTRE.Conteudo);
      FormChaveEst.EdEstiloChange(Self);
      if FormChaveEst.ShowModal = mrOk then
      begin
        xtabestrangeira := FormChaveEst.ComboTab.Text;
        xcampochave := FormChaveEst.CamposRelacionados.Items[0];
        xcamposvisuais := '';
        for I:=0 to FormChaveEst.CamposMostrados.Items.Count-1 do
          xcamposvisuais := xcamposvisuais + FormChaveEst.CamposMostrados.Items[I]+',';
        if Copy(xcamposvisuais,Length(xcamposvisuais),01) = ',' then
          xcamposvisuais := Copy(xcamposvisuais,01,Length(xcamposvisuais)-1);
        TabGlobal_i.DCAMPOST.Modifica;
        TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo:= xtabestrangeira;
        TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo    := xcampochave;
        TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo := xcamposvisuais;
        TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo   := FormChaveEst.EdEstilo.ItemIndex;
        TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Conteudo  := FormChaveEst.EdAcao.ItemIndex;
        if FormChaveEst.EdEstilo.ItemIndex = 0 then
          TBlobField(TabGlobal_i.DCAMPOST.FieldByName('FILTRO_MESTRE')).AsString := ''
        else
          TBlobField(TabGlobal_i.DCAMPOST.FieldByName('FILTRO_MESTRE')).AsString := FormChaveEst.Filtro_Mestre.Text;
        TabGlobal_i.DCAMPOST.Salva;
        if (Lancar) and (Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo) <> '') and
           (Integer(FormChaveEst.ComboTab.Items.Objects[FormChaveEst.ComboTab.ItemIndex]) = 0) then
        begin
          if not PTabela(TabGlobal_i.DRELACIONA, ['NUMERO', 'UPPER(TAB_ESTRANGEIRA)'], [IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo), UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo))]) then
            if Mensagem('Criar Relacionamento em "Integridades && Relacionamentos" ?',modConfirmacao,[modSim,modNao]) = mrYes then
            begin
              xtitulo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
              InputQuery('Relacionamento !', 'Informe o título ...', xtitulo);
              if Trim(xtitulo) = '' then
                xtitulo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
              TabGlobal_i.DRELACIONA.DisableControls;
              TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo);
              TabGlobal_i.DRELACIONA.AtualizaSql;
              TabGlobal_i.DRELACIONA.Last;
              Seq := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo + 1;
              TabGlobal_i.DRELACIONA.EnableControls;
              TabGlobal_i.DRELACIONA.Inclui(Nil);
              TabGlobal_i.DRELACIONA.NUMERO.Conteudo     := TabGlobal_i.DCAMPOST.NUMERO.Conteudo;
              TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo  := Seq;
              TabGlobal_i.DRELACIONA.TITULO_I.Conteudo   := xtitulo;
              TabGlobal_i.DRELACIONA.TIPO.Conteudo       := 1;
              TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
              TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo := TabGlobal_i.DCAMPOST.NOME.Conteudo;
              TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo := xcampochave;
              TabGlobal_i.DRELACIONA.ATIVO.Conteudo      := 1;
              TabGlobal_i.DRELACIONA.KEY_SQL.Conteudo    := 0;
              TabGlobal_i.DRELACIONA.Salva;
              TabGlobal_i.DCAMPOST.Modifica;
              TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
              TabGlobal_i.DCAMPOST.Salva;
              TabGlobal_i.DRELACIONA.First;
              Posicao := Tree_Tabelas.Selected.AbsoluteIndex + 1;
              Atualiza_Listas(False, True);
              Tree_Tabelas.Items[Posicao].Selected := True;
              Tree_Tabelas.Items[Posicao].Expand(True);
            end;
        end;
      end;
    Finally
      FormChaveEst.Free;
    end;
  end;

  procedure Campos_Formula;
  var
    P: Integer;
    Grava: Boolean;
    exp_exemplo, exp_exemplo1: String;
  begin
    FormMiniEditor := TFormMiniEditor.Create(Application);
    Try
      FormMiniEditor.E_Cabecalho.ReadOnly := False;
      FormMiniEditor.EdVirtual.Visible    := True;
      if TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1 then
        FormMiniEditor.EdVirtual.Checked := true
      else
        FormMiniEditor.EdVirtual.Checked := false;
      P := 1;
      if (Trim(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo.Text) = '') and
         (Trim(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Text) = '') then
      begin
        //exp_exemplo := '';
        //exp_exemplo1 := '';
        //case TabGlobal_i.DCAMPOST.TIPO.Conteudo of
        //  1: begin exp_exemplo := 'I: String'; exp_exemplo1 := '+ '+#39 + 'ABC' + #39 end;
        //  2: begin exp_exemplo := 'I: Integer'; exp_exemplo1 := '+ 100' end;
        //  3: begin exp_exemplo := 'I: Double'; exp_exemplo1 := '/ 100' end;
        //  4: begin exp_exemplo := 'I: TDate'; exp_exemplo1 := '- Date' end;
        //end;
        FormMiniEditor.E_Cabecalho.Lines.Clear;
        FormMiniEditor.E_Metodo.Lines.Clear;
        //FormMiniEditor.E_Cabecalho.Lines.Add('// variáveis locais, exemplo: '+exp_exemplo+';');
        FormMiniEditor.E_Cabecalho.Lines.Add('// variáveis locais');
        FormMiniEditor.E_Cabecalho.Lines.Add('');
        FormMiniEditor.E_Metodo.Lines.Add('// a variável "Result" deverá conter o resultado da expressão');
        //FormMiniEditor.E_Metodo.Lines.Add('{ a variável "Result" deverá conter o resultado, exemplo:');
        //FormMiniEditor.E_Metodo.Lines.Add('  I := TabGlobal.D'+TabGlobal_i.DTABELAS.NOME.Conteudo+'.'+TabGlobal_i.DCAMPOST.NOME.Conteudo + '.Conteudo '+exp_exemplo1+';');
        //FormMiniEditor.E_Metodo.Lines.Add('  Result := I; }');
        FormMiniEditor.E_Metodo.Lines.Add('');
        P := 2;
      end
      else
      begin
        FormMiniEditor.E_Cabecalho.Lines.AddStrings(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo);
        FormMiniEditor.E_Metodo.Lines.AddStrings(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo);
      end;
      FormMiniEditor.ExcluirEvento.Visible := False;
      FormMiniEditor.Posicao_Y := P;
      if FormMiniEditor.ShowModal = mrOk then
      begin
        TabGlobal_i.DCAMPOST.Modifica;
        TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo.Clear;
        TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VARIAVEIS')).AsString := FormMiniEditor.E_Cabecalho.Lines.Text;
        TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Clear;
        TBlobField(TabGlobal_i.DCAMPOST.FieldByName('CODIFICACAO')).AsString := FormMiniEditor.E_Metodo.Lines.Text;
        if FormMiniEditor.EdVirtual.Checked then
          TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo := 1
        else
          TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo := 0;
        TabGlobal_i.DCAMPOST.Salva;
      end;
    Finally
      FormMiniEditor.Free;
    end;
  end;

  procedure Tabela_Relacionamento;
  var
    xtabestrangeira, xcampochave_1, xcampochave_2, parte: String;
    i: integer;
    GridCampos: TStringList;
  begin
    FormRelacionamento := TFormRelacionamento.Create(Application);
    Try
      GridCampos := TStringList.Create;
      TabGlobal_i.DTABELAS.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent.Data);
      for I:=4 to Tree_Tabelas.Selected.Parent.Parent.Count-1 do
      begin
        TabGlobal_i.DCAMPOST.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent[I].Data);
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 3 then
        begin
          if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
            GridCampos.Add(NomeFisicoCampo);
        end
        else
          GridCampos.Add(NomeFisicoCampo);
      end;
      FormRelacionamento.Tipo := TabGlobal_i.DRELACIONA.TIPO.Conteudo;
      case TabGlobal_i.DRELACIONA.TIPO.Conteudo of
        1: begin
             FormRelacionamento.Caption := 'Relacionamento';
             FormRelacionamento.CamposEdTabela.Items.AddStrings(GridCampos);
           end;
        2: begin
             FormRelacionamento.Caption := 'Exclusão Restrita';
             FormRelacionamento.CamposEdTabela.Items.AddStrings(GridCampos);
           end;
        3: begin
             //TabGlobal_i.DCAMPOST.First;
             //while not TabGlobal_i.DCAMPOST.Eof do
             //begin
             //  if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
             //    FormRelacionamento.CamposEdTabela.Items.Add(TabGlobal_i.DCAMPOST.NOME.Conteudo);
             //  TabGlobal_i.DCAMPOST.Next;
             //end;
             FormRelacionamento.Caption := 'Exclusão em Cascata';
             FormRelacionamento.CamposEdTabela.Items.AddStrings(GridCampos);
           end;
      end;
      GridCampos.Free;
      FormRelacionamento.EdTabela.Text   := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' + TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
      FormRelacionamento.Tab_Estrangeira := TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo;
      FormRelacionamento.Campo_Chave_1   := TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo;
      FormRelacionamento.Campo_Chave_2   := TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo;
      if FormRelacionamento.ShowModal = mrOk then
      begin
        xtabestrangeira := FormRelacionamento.ComboTab.Text;
        xcampochave_1 := '';
        xcampochave_2 := '';
        for I:=0 to FormRelacionamento.CamposRelacionados.Items.Count-1 do
        begin
          parte := FormRelacionamento.CamposRelacionados.Items[I];
          parte := Trim(Copy(parte,01,Pos('<',Parte)-1));
          xcampochave_1 := xcampochave_1 + parte + ';';
          parte := FormRelacionamento.CamposRelacionados.Items[I];
          parte := Trim(Copy(parte,Pos('>',Parte)+1,Length(Parte)));
          xcampochave_2 := xcampochave_2 + parte + ';';
        end;
        if Copy(xcampochave_1,Length(xcampochave_1),01) = ';' then
          xcampochave_1 := Copy(xcampochave_1,01,Length(xcampochave_1)-1);
        if Copy(xcampochave_2,Length(xcampochave_2),01) = ';' then
          xcampochave_2 := Copy(xcampochave_2,01,Length(xcampochave_2)-1);
        TabGlobal_i.DRELACIONA.Modifica;
        TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo := xtabestrangeira;
        TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo  := xcampochave_1;
        TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo  := xcampochave_2;
        TabGlobal_i.DRELACIONA.Salva;
      end;
    Finally
      FormRelacionamento.Free;
    end;
  end;

  procedure Tabela_Processo;
  var
    I: Integer;
    Lst_1, Lst_2, GridCampos: TStringList;
  begin
    GridCampos := TStringList.Create;
    TabGlobal_i.DTABELAS.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent.Data);
    for I:=4 to Tree_Tabelas.Selected.Parent.Parent.Count-1 do
    begin
      TabGlobal_i.DCAMPOST.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent[I].Data);
      GridCampos.Add(TabGlobal_i.DCAMPOST.NOME.Conteudo);
    end;
    if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 1 then
    begin
      FormProcessos := TFormProcessos.Create(Application);
      try
        FormProcessos.PR_EdTab_alvo.DataSource := Nil;
        FormProcessos.PR_EdTab_alvo.Items.Clear;
        TabGlobal_i.DRELACIONA.First;
        TabGlobal_i.DRELACIONA.Locate('numero', TabGlobal_i.DPROCESSOS.NUMERO.Conteudo, []);
        while (not TabGlobal_i.DRELACIONA.Eof) and (TabGlobal_i.DRELACIONA.NUMERO.Conteudo = TabGlobal_i.DPROCESSOS.NUMERO.Conteudo) do
        begin
          FormProcessos.PR_EdTab_alvo.Items.Add(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
          TabGlobal_i.DRELACIONA.Next;
        end;
        FormProcessos.PR_EdTab_alvo.DataSource := DataSource_Processo;
        FormProcessos.PR_EdTab_alvoExit(Self);
        TabGlobal_i.DPROCESSOS.Modifica;
        if FormProcessos.ShowModal = mrOk then
          TabGlobal_i.DPROCESSOS.Salva
        else
          TabGlobal_i.DPROCESSOS.Cancela;
      Finally
        FormProcessos.Free;
      end;
    end
    else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 2 then
    begin
      FormLanctos := TFormLanctos.Create(Application);
      try
        FormLanctos.PR_EdTab_alvo.DataSource := Nil;
        FormLanctos.PR_EdTab_alvo.Items.Clear;
        for I:=0 to Tree_Tabelas.Items.Count-1 do
          if Tree_Tabelas.Items[I].Level = 0 then
            FormLanctos.PR_EdTab_alvo.Items.Add(Tree_Tabelas.Items[I].Text);
        FormLanctos.PR_EdTab_alvo.DataSource := DataSource_Processo;
        TabGlobal_i.DPROCESSOS.Modifica;
        FormLanctos.PR_EdTab_alvoExit(Self);
        if FormLanctos.ShowModal = mrOk then
        begin
          Lst_1 := TStringList.Create;
          Lst_2 := TStringList.Create;
          for I:=0 to FormLanctos.GridCampos.Items.Count-1 do
          begin
            Lst_1.Add(FormLanctos.GridCampos.Items[I]);
            Lst_2.Add(FormLanctos.GridValores.Items[I]);
          end;
          //TabGlobal_i.DPROCESSOS.Modifica;
          TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_ALVO')).AsString := Lst_1.Text;
          TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_VALOR')).AsString := Lst_2.Text;
          TabGlobal_i.DPROCESSOS.Salva;
          Lst_1.Free;
          Lst_2.Free;
        end
        else
         TabGlobal_i.DPROCESSOS.Cancela;
      Finally
        FormLanctos.Free;
      end;
    end
    else if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo >= 3) and
            (TabGlobal_i.DPROCESSOS.TIPO.Conteudo <= 5) then
    begin
      FormMiniEditor := TFormMiniEditor.Create(Application);
      Try
        FormMiniEditor.E_Cabecalho.Visible := True;
        FormMiniEditor.E_Cabecalho.ReadOnly := False;
        FormMiniEditor.ExcluirEvento.Visible := False;
        FormMiniEditor.Posicao_Y := 1;
        FormMiniEditor.E_Cabecalho.Lines.AddStrings(TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo);
        FormMiniEditor.E_Metodo.Lines.AddStrings(TabGlobal_i.DPROCESSOS.AVULSO.Conteudo);
        if Trim(FormMiniEditor.E_Cabecalho.Lines.Text) = '' then
        begin
          FormMiniEditor.E_Cabecalho.Lines.Clear;
          FormMiniEditor.E_Cabecalho.Lines.Add('// Variáveis Locais');
          FormMiniEditor.E_Cabecalho.Lines.Add('');
        end;
        if FormMiniEditor.ShowModal = mrOk then
        begin
          TabGlobal_i.DPROCESSOS.Modifica;
          TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('AVULSO')).AsString := FormMiniEditor.E_Metodo.Lines.Text;
          TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('AVULSO_VAR')).AsString := FormMiniEditor.E_Cabecalho.Lines.Text;
          TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo := 'Avulso';
          TabGlobal_i.DPROCESSOS.Salva;
        end;
      Finally
        FormMiniEditor.Free;
      end;
    end;
    GridCampos.Free;
  end;

begin
  case Insp_Tabela.DataSource.Tag of
    10: Begin
          if TheIndex = 6 then
          begin
            FormOrdenacao := TFormOrdenacao.Create(Application);
            Try
              if TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo = 1 then
                FormOrdenacao.EdDecrescente.Checked := True
              else
                FormOrdenacao.EdDecrescente.Checked := False;
              FormOrdenacao.TabFiltro := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
              FormOrdenacao.TabNome := TabGlobal_i.DTABELAS.NOME.Conteudo;
              ListaCmp := TStringList.Create;
              StringToArray(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo,',',ListaCmp);
              for I:=0 to ListaCmp.Count-1 do
                FormOrdenacao.CamposIndices.Items.Add(ListaCmp[I]);
              ListaCmp.Free;
              if FormOrdenacao.ShowModal = mrOk then
              begin
                TabGlobal_i.DTABELAS.Modifica;
                TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo := '';
                for I:=0 to FormOrdenacao.CamposIndices.Items.Count-1 do
                  TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo := TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo + FormOrdenacao.CamposIndices.Items[I] + ',';
                if Copy(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo,Length(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo),01) = ',' then
                  TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo := Copy(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo,01,Length(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo)-1);
                if FormOrdenacao.EdDecrescente.Checked then
                  TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo := 1
                else
                  TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo := 0;
                TabGlobal_i.DTABELAS.Salva;
              end;
            Finally
              FormOrdenacao.Free;
            end;
          end
          else
          begin
            FormFiltro := TFormFiltro.Create(Application);
            Try
              FormFiltro.ExprMemo.Lines.Clear;
              if TheIndex = 4 then
                FormFiltro.ExprMemo.Lines.AddStrings(TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo)
              else if TheIndex = 5 then
                FormFiltro.ExprMemo.Lines.AddStrings(TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo);
              FormFiltro.TabFiltro := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
              FormFiltro.TabNome := TabGlobal_i.DTABELAS.NOME.Conteudo;
              if FormFiltro.ShowModal = mrOk then
              begin
                TabGlobal_i.DTABELAS.Modifica;
                if TheIndex = 4 then
                  TBlobField(TabGlobal_i.DTABELAS.FieldByName('FILTRO_INICIAL')).AsString := FormFiltro.ExprMemo.Lines.Text
                else if TheIndex = 5 then
                  TBlobField(TabGlobal_i.DTABELAS.FieldByName('FILTRO_MESTRE')).AsString := FormFiltro.ExprMemo.Lines.Text;
                TabGlobal_i.DTABELAS.Salva;
              end;
            Finally
              FormFiltro.Free;
            end;
          end;
        end;
    20: begin
          if (TheIndex = 0) then
            Campos_PreDefinidos
          else if (TheIndex = 9) then
          begin
            if TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 5 then
              Campos_ChaveEstrangeira
            else
              Mensagem('Campo não definido como chave estrangeira!', modAdvertencia, [ModOk]);
          end
          else if (TheIndex = 11) then
          begin
            if TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1 then
              Campos_Formula
            else
              Mensagem('Campo não definido como calculado!', modAdvertencia, [ModOk]);
          end
          else if (TheIndex = 12) then
            Campos_Mascara
          else if (TheIndex = 18) then
          begin
            FormExpressao := TFormExpressao.Create(Application);
            Try
              FormExpressao.ExprMemo.Text := TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo;
              if FormExpressao.ShowModal = mrOk then
              begin
                TabGlobal_i.DCAMPOST.Modifica;
                TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo := FormExpressao.ExprMemo.Text;
                TabGlobal_i.DCAMPOST.Salva;
              end;
            Finally
              FormExpressao.Free;
            end;
          end
          else if (TheIndex = 25) then
            Campos_Validos
          else if (TheIndex = 27) then
          begin
            FormListaEscolha := TFormListaEscolha.Create(Application);
            Try
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['CHARACTER SET WIN1252 COLLATE WIN_PTBR'])+'Firebird 2.x Padrão Brasileiro');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['CHARACTER SET ISO8859_1 COLLATE PT_BR'])+'Firebird 2.x Padrão Brasileiro');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['AUTO_INCREMENT'])+'MySQL - Autoincremento');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['IDENTITY(1, 1)'])+'SQLServer - Autoincremento');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['DEFAULT nextval(''nome_sequencia'')'])+'PostgreSQL - Autoincremento');
              FormListaEscolha.ShowModal;
            Finally
              if FormListaEscolha.NumeroSelecao >= 0 then
              begin
                TabGlobal_i.DCAMPOST.Modifica;
                TabGlobal_i.DCAMPOST.SQL_EXTRA.Conteudo := Trim(Copy(FormListaEscolha.ListaSelecao.Items[FormListaEscolha.NumeroSelecao],01,40));
                TabGlobal_i.DCAMPOST.Salva;
              end;
              FormListaEscolha.Free;
            end;
          end
          else if (TheIndex = 28) then
          begin
            FormListaEscolha := TFormListaEscolha.Create(Application);
            Try
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['GEN_ID("nome generator",1)'])+'Firebird - Data Atual');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['CURRENT_DATE '])+'Firebird - Data Atual');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['CURRENT_TIMESTAMP '])+'Firebird - Data/Hora Atual');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['CURRENT_TIME '])+'Firebird - Hora Atual');
              FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['GETDATE()'])+'SQLServer - Data/Hora Atual');
              FormListaEscolha.ShowModal;
            Finally
              if FormListaEscolha.NumeroSelecao >= 0 then
              begin
                TabGlobal_i.DCAMPOST.Modifica;
                TabGlobal_i.DCAMPOST.SQL_EXTRA_INSERT.Conteudo := Trim(Copy(FormListaEscolha.ListaSelecao.Items[FormListaEscolha.NumeroSelecao],01,40));
                TabGlobal_i.DCAMPOST.Salva;
              end;
              FormListaEscolha.Free;
            end;
          end;
          Insp_TabelaSelectItem(Sender, TheIndex);
        end;
    30: begin
          if (TheIndex = 1) then
          begin
            FormCamposSel := TFormCamposSel.Create(Application);
            try
              TabGlobal_i.DTABELAS.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent.Data);
              for I:=4 to Tree_Tabelas.Selected.Parent.Parent.Count-1 do
              begin
                TabGlobal_i.DCAMPOST.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent[I].Data);
                if (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 5) and
                   (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 6) and (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 19) and
                   (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 20) and (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 25) and
                   (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) then
                begin
                  if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
                    FormCamposSel.CamposOrigem.Items.AddObject(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo) + '.' + Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo),TObject(1))
                  else
                  begin
                    if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
                      FormCamposSel.CamposOrigem.Items.AddObject(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) + '.' + Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo),TObject(0))
                    else
                      FormCamposSel.CamposOrigem.Items.AddObject(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) + '.' + Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo),TObject(1));
                    end;
                  end;
              end;
              StringToArray(TabGlobal_i.DINDICEST.CAMPOST.Conteudo, ';', TStringList(FormCamposSel.CamposIndices.Items));
              if FormCamposSel.ShowModal = mrOk then
              begin
                TabGlobal_i.DINDICEST.Modifica;
                TabGlobal_i.DINDICEST.CAMPOST.Conteudo := '';
                for I:=0 to FormCamposSel.CamposIndices.Items.Count-1 do
                  TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + FormCamposSel.CamposIndices.Items[I] + ';';
                if Copy(TabGlobal_i.DINDICEST.CAMPOST.Conteudo, Length(TabGlobal_i.DINDICEST.CAMPOST.Conteudo), 1) = ';' then
                  TabGlobal_i.DINDICEST.CAMPOST.Conteudo := Copy(TabGlobal_i.DINDICEST.CAMPOST.Conteudo, 1, Length(TabGlobal_i.DINDICEST.CAMPOST.Conteudo)-1);
                TabGlobal_i.DINDICEST.Salva;
              end;
            finally
              FormCamposSel.Free;
            end;
          end;
        end;
    40: begin
          Tabela_Relacionamento;
        end;
    50: begin
          Tabela_Processo;
        end;
    60: begin
          if (TheIndex = 2) then
          begin
            FormEditorSQL := TFormEditorSQL.Create(Application);
            Try
              FormEditorSQL.Ativo.Visible := False;
              FormEditorSQL.Posicao_Y := 1;
              FormEditorSQL.E_Metodo.Lines.AddStrings(TabGlobal_i.DCONSULTA.SQL_I.Conteudo);
              FormEditorSQL.BtnEstruturas.Visible := False;
              FormEditorSQL.BtnFormularios.Visible := False;
              if FormEditorSQL.ShowModal = mrOk then
              begin
                TabGlobal_i.DCONSULTA.Modifica;
                TBlobField(TabGlobal_i.DCONSULTA.FieldByName('SQL_I')).AsString := FormEditorSQL.E_Metodo.Lines.Text;
                TabGlobal_i.DCONSULTA.Salva;
              end;
            Finally
              FormEditorSQL.Free;
            end;
          end
          else if (TheIndex = 3) then
          begin
            try
              OQBDialogIBX_SQL := TOQBuilderDialog_SQL.Create(Self);
              OQBEngineIBX := TOQBEngineIBX.Create(Self);
              OQBDialogIBX_SQL.OQBEngine := TOQBEngine(OQBEngineIBX);
              OQBEngineIBX.DatabaseName := BaseDados.BD_Base_Dicionario;
              OQBEngineIBX.SQL.Clear;
              OQBEngineIBX.SQL.AddStrings(TabGlobal_i.DCONSULTA.SQL_I.Conteudo);
              OQBDialogIBX_SQL.SQL_Layout.Clear;
              OQBDialogIBX_SQL.SQL_Layout.AddStrings(TabGlobal_i.DCONSULTA.SQL_INTERATIVO.Conteudo);
              OQBEngineIBX.UseTableAliases := False;
              if OQBDialogIBX_SQL.Execute then
              begin
                TabGlobal_i.DCONSULTA.Modifica;
                TBlobField(TabGlobal_i.DCONSULTA.FieldByName('SQL_I')).AsString := OQBEngineIBX.SQL.Text;
                TBlobField(TabGlobal_i.DCONSULTA.FieldByName('SQL_INTERATIVO')).AsString := OQBDialogIBX_SQL.SQL_Layout.Text;
                TabGlobal_i.DCONSULTA.Salva;
              end;
            finally
              OQBDialogIBX_SQL.Free;
              OQBEngineIBX.Free;
            end;
          end
          else if (TheIndex = 5) then
          begin
            FormParametros := TFormParametros.Create(Application);
            try
              FormParametros.Tabela := True;
              FormParametros.Lista_Parametros.AddStrings(TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo);
              if FormParametros.ShowModal = mrOk then
              begin
                TabGlobal_i.DCONSULTA.Modifica;
                TBlobField(TabGlobal_i.DCONSULTA.FieldByName('PARAMETROS')).AsString := FormParametros.Lista_Parametros.Text;
                TabGlobal_i.DCONSULTA.Salva;
              end;
            finally
              FormParametros.Free;
            end;
          end
          else if (TheIndex = 6) then
          begin
            FormTitulos := TFormTitulos.Create(Application);
            try
              FormTitulos.Lista_Parametros.AddStrings(TabGlobal_i.DCONSULTA.TITULOS.Conteudo);
              if FormTitulos.ShowModal = mrOk then
              begin
                TabGlobal_i.DCONSULTA.Modifica;
                TBlobField(TabGlobal_i.DCONSULTA.FieldByName('TITULOS')).AsString := FormTitulos.Lista_Parametros.Text;
                TabGlobal_i.DCONSULTA.Salva;
              end;
            finally
              FormTitulos.Free;
            end;
          end;
        end;
    70: begin
          if (TheIndex = 3) then
          begin
            FormEditorSQL := TFormEditorSQL.Create(Application);
            Try
              FormEditorSQL.Ativo.Visible := False;
              FormEditorSQL.Posicao_Y := 1;
              FormEditorSQL.E_Metodo.Lines.AddStrings(TabGlobal_i.DTRIGGER.BLOCO_SQL.Conteudo);
              if Trim(FormEditorSQL.E_Metodo.Lines.Text) = '' then
              begin
                FormEditorSQL.E_Metodo.Lines.Add('BEGIN');
                FormEditorSQL.E_Metodo.Lines.Add('');
                FormEditorSQL.E_Metodo.Lines.Add('END');
              end;
              FormEditorSQL.BtnEstruturas.Visible := False;
              FormEditorSQL.BtnFormularios.Visible := False;
              if FormEditorSQL.ShowModal = mrOk then
              begin
                TabGlobal_i.DTRIGGER.Modifica;
                TBlobField(TabGlobal_i.DTRIGGER.FieldByName('BLOCO_SQL')).AsString := FormEditorSQL.E_Metodo.Lines.Text;
                TabGlobal_i.DTRIGGER.Salva;
              end;
            Finally
              FormEditorSQL.Free;
            end;
          end
          else if (TheIndex = 4) then
          begin
            with TStrEditDlg.Create(nil) do
            begin
              Try
                Memo.Lines.AddStrings(TabGlobal_i.DTRIGGER.DESCRICAO.Conteudo);
                if ShowModal = mrOk then
                begin
                  TabGlobal_i.DTRIGGER.Modifica;
                  TBlobField(TabGlobal_i.DTRIGGER.FieldByName('DESCRICAO')).AsString := Memo.Lines.Text;
                  TabGlobal_i.DTRIGGER.Salva;
                end;
               Finally
                 Free;
               end;
            end;
          end;
        end;
    80: begin
          if (TheIndex = 1) then
          begin
            FormParametros := TFormParametros.Create(Application);
            try
              FormParametros.Tabela := False;
              FormParametros.Lista_Parametros.AddStrings(TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo);
              if FormParametros.ShowModal = mrOk then
              begin
                TabGlobal_i.DPROC_EXTERNA.Modifica;
                TBlobField(TabGlobal_i.DPROC_EXTERNA.FieldByName('PARAMETROS')).AsString := FormParametros.Lista_Parametros.Text;
                TabGlobal_i.DPROC_EXTERNA.Salva;
              end;
            finally
              FormParametros.Free;
            end;
          end
          else if (TheIndex = 2) then
          begin
            FormEditorSQL := TFormEditorSQL.Create(Application);
            Try
              FormEditorSQL.Ativo.Visible := False;
              FormEditorSQL.Posicao_Y := 1;
              FormEditorSQL.E_Metodo.Lines.AddStrings(TabGlobal_i.DPROC_EXTERNA.BLOCO_SQL.Conteudo);
              if Trim(FormEditorSQL.E_Metodo.Lines.Text) = '' then
              begin
                FormEditorSQL.E_Metodo.Lines.Add('BEGIN');
                FormEditorSQL.E_Metodo.Lines.Add('');
                FormEditorSQL.E_Metodo.Lines.Add('END');
              end;
              FormEditorSQL.BtnEstruturas.Visible := False;
              FormEditorSQL.BtnFormularios.Visible := False;
              if FormEditorSQL.ShowModal = mrOk then
              begin
                TabGlobal_i.DPROC_EXTERNA.Modifica;
                TBlobField(TabGlobal_i.DPROC_EXTERNA.FieldByName('BLOCO_SQL')).AsString := FormEditorSQL.E_Metodo.Lines.Text;
                TabGlobal_i.DPROC_EXTERNA.Salva;
              end;
            Finally
              FormEditorSQL.Free;
            end;
          end
          else if (TheIndex = 3) then
          begin
            with TStrEditDlg.Create(nil) do
            begin
              Try
                Memo.Lines.AddStrings(TabGlobal_i.DPROC_EXTERNA.DESCRICAO.Conteudo);
                if ShowModal = mrOk then
                begin
                  TabGlobal_i.DPROC_EXTERNA.Modifica;
                  TBlobField(TabGlobal_i.DPROC_EXTERNA.FieldByName('DESCRICAO')).AsString := Memo.Lines.Text;
                  TabGlobal_i.DPROC_EXTERNA.Salva;
                end;
               Finally
                 Free;
               end;
            end;
          end;
        end;
    90: begin
          if (TheIndex = 1) then
          begin
            FormEditorSQL := TFormEditorSQL.Create(Application);
            Try
              FormEditorSQL.Ativo.Visible := False;
              FormEditorSQL.Posicao_Y := 1;
              FormEditorSQL.E_Metodo.Lines.AddStrings(TabGlobal_i.DSQL_SCRIPT.BLOCO_SQL.Conteudo);
              {if Trim(FormEditorSQL.E_Metodo.Lines.Text) = '' then
              begin
                FormEditorSQL.E_Metodo.Lines.Add('BEGIN');
                FormEditorSQL.E_Metodo.Lines.Add('');
                FormEditorSQL.E_Metodo.Lines.Add('END');
              end;}
              FormEditorSQL.BtnEstruturas.Visible := False;
              FormEditorSQL.BtnFormularios.Visible := False;
              if FormEditorSQL.ShowModal = mrOk then
              begin
                TabGlobal_i.DSQL_SCRIPT.Modifica;
                TBlobField(TabGlobal_i.DSQL_SCRIPT.FieldByName('BLOCO_SQL')).AsString := FormEditorSQL.E_Metodo.Lines.Text;
                TabGlobal_i.DSQL_SCRIPT.Salva;
              end;
            Finally
              FormEditorSQL.Free;
            end;
          end
          else if (TheIndex = 2) then
          begin
            with TStrEditDlg.Create(nil) do
            begin
              Try
                Memo.Lines.AddStrings(TabGlobal_i.DSQL_SCRIPT.DESCRICAO.Conteudo);
                if ShowModal = mrOk then
                begin
                  TabGlobal_i.DSQL_SCRIPT.Modifica;
                  TBlobField(TabGlobal_i.DSQL_SCRIPT.FieldByName('DESCRICAO')).AsString := Memo.Lines.Text;
                  TabGlobal_i.DSQL_SCRIPT.Salva;
                end;
               Finally
                 Free;
               end;
            end;
          end
          else if (TheIndex = 5) then
          begin
            FormParametros := TFormParametros.Create(Application);
            try
              FormParametros.Tabela := True;
              FormParametros.Lista_Parametros.AddStrings(TabGlobal_i.DSQL_SCRIPT.PARAMETROS.Conteudo);
              if FormParametros.ShowModal = mrOk then
              begin
                TabGlobal_i.DSQL_SCRIPT.Modifica;
                TBlobField(TabGlobal_i.DSQL_SCRIPT.FieldByName('PARAMETROS')).AsString := FormParametros.Lista_Parametros.Text;
                TabGlobal_i.DSQL_SCRIPT.Salva;
              end;
            finally
              FormParametros.Free;
            end;
          end;
        end;
    100: Begin
           if (TheIndex = 1) then
           begin
             try
               OQBDialogIBX := TOQBuilderDialog.Create(Self);
               OQBEngineIBX := TOQBEngineIBX.Create(Self);
               OQBDialogIBX.OQBEngine := OQBEngineIBX;
               OQBEngineIBX.DatabaseName := BaseDados.BD_Base_Dicionario;
               OQBEngineIBX.SQL.Clear;
               OQBEngineIBX.SQL.AddStrings(TabGlobal_i.DDIAGRAMA.BLOCO.Conteudo);
               OQBEngineIBX.UseTableAliases := False;
               if OQBDialogIBX.Execute then
               begin
                 TabGlobal_i.DDIAGRAMA.Modifica;
                 TBlobField(TabGlobal_i.DDIAGRAMA.FieldByName('BLOCO')).AsString := OQBEngineIBX.SQL.Text;
                 TabGlobal_i.DDIAGRAMA.Salva;
               end;
             finally
               OQBDialogIBX.Free;
               OQBEngineIBX.Free;
             end;
           end
           else if (TheIndex = 2) then
           begin
             with TStrEditDlg.Create(nil) do
             begin
               Try
                 Memo.Lines.AddStrings(TabGlobal_i.DDIAGRAMA.DESCRICAO.Conteudo);
                 if ShowModal = mrOk then
                 begin
                   TabGlobal_i.DDIAGRAMA.Modifica;
                   TBlobField(TabGlobal_i.DDIAGRAMA.FieldByName('DESCRICAO')).AsString := Memo.Lines.Text;
                   TabGlobal_i.DDIAGRAMA.Salva;
                 end;
                Finally
                  Free;
                end;
             end;
           end;
         end;
  end;
end;

procedure TFormDB_Case.Insp_TabelaGetBlobEditorType(Sender: TObject;
  Field: TField; var BlobEditorType: TBlobEditorType);
begin
  BloBEditorType := beText;
end;

procedure TFormDB_Case.Insp_TabelaGetEnableExternalEditor(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  case Insp_Tabela.DataSource.Tag of
    10: Begin
          if (TheIndex = 6) then
            Value := True;
        end;
    20: Begin
          if (TheIndex = 0) or (TheIndex = 9) or (TheIndex = 11) or (TheIndex = 12) or
             (TheIndex = 18) or (TheIndex = 25) or (TheIndex = 27) or (TheIndex = 28) then
            Value := True;
        end;
    30: Begin
          if (TheIndex = 1) then
            Value := True;
        end;
    40: Begin
          if (TheIndex = 2) then
            Value := True;
        end;
    50: Begin
          if (TheIndex = 2) then
            Value := True;
        end;
    60: Begin
          if (TheIndex = 2) or (TheIndex = 3) or (TheIndex = 5) or (TheIndex = 6) then
            Value := True;
        end;
    70: Begin
          if (TheIndex = 3) or (TheIndex = 4) then
            Value := True;
        end;
    80: Begin
          if (TheIndex = 2) or (TheIndex = 3) then
            Value := True;
        end;
    90: Begin
          if (TheIndex = 1) or (TheIndex = 2) or (TheIndex = 5) then
            Value := True;
        end;
    100: Begin
          if (TheIndex = 0) or (TheIndex = 1) then
            Value := True;
        end;
  end;
end;

procedure TFormDB_Case.Gravar;
var
  sequencia: Variant;
  Achou, Achou1: Boolean;
begin
  try
    TabGlobal_i.DBDADOS.BeforePost := Nil;
    TabGlobal_i.DTABELAS.BeforePost := Nil;
    TabGlobal_i.DCAMPOST.BeforePost := Nil;
    TabGlobal_i.DINDICEST.BeforePost := Nil;
    TabGlobal_i.DRELACIONA.BeforePost := Nil;
    TabGlobal_i.DPROCESSOS.BeforePost := Nil;
    TabGlobal_i.DCONSULTA.BeforePost := Nil;
    TabGlobal_i.DTRIGGER.BeforePost := Nil;
    TabGlobal_i.DPROC_EXTERNA.BeforePost := Nil;
    TabGlobal_i.DSQL_SCRIPT.BeforePost := Nil;
    TabGlobal_i.DDIAGRAMA.BeforePost := Nil;
    if (TabGlobal_i.DBDADOS.State in [dsEdit,dsInsert]) then TabGlobal_i.DBDADOS.Post;
    if (TabGlobal_i.DTABELAS.State in [dsEdit,dsInsert]) then TabGlobal_i.DTABELAS.Post;
    if (TabGlobal_i.DCAMPOST.State in [dsEdit,dsInsert]) then TabGlobal_i.DCAMPOST.Post;
    if (TabGlobal_i.DINDICEST.State in [dsEdit,dsInsert]) then TabGlobal_i.DINDICEST.Post;
    if (TabGlobal_i.DRELACIONA.State in [dsEdit,dsInsert]) then TabGlobal_i.DRELACIONA.Post;
    if (TabGlobal_i.DPROCESSOS.State in [dsEdit,dsInsert]) then TabGlobal_i.DPROCESSOS.Post;
    if (TabGlobal_i.DCONSULTA.State in [dsEdit,dsInsert]) then TabGlobal_i.DCONSULTA.Post;
    if (TabGlobal_i.DTRIGGER.State in [dsEdit,dsInsert]) then TabGlobal_i.DTRIGGER.Post;
    if (TabGlobal_i.DPROC_EXTERNA.State in [dsEdit,dsInsert]) then TabGlobal_i.DPROC_EXTERNA.Post;
    if (TabGlobal_i.DSQL_SCRIPT.State in [dsEdit,dsInsert]) then TabGlobal_i.DSQL_SCRIPT.Post;
    if (TabGlobal_i.DDIAGRAMA.State in [dsEdit,dsInsert]) then TabGlobal_i.DDIAGRAMA.Post;
    TabGlobal_i.DBDADOS.Transaction.CommitRetaining;
    TabGlobal_i.DTABELAS.Transaction.CommitRetaining;
    TabGlobal_i.DCAMPOST.Transaction.CommitRetaining;
    TabGlobal_i.DINDICEST.Transaction.CommitRetaining;
    TabGlobal_i.DRELACIONA.Transaction.CommitRetaining;
    TabGlobal_i.DPROCESSOS.Transaction.CommitRetaining;
    TabGlobal_i.DCONSULTA.Transaction.CommitRetaining;
    TabGlobal_i.DTRIGGER.Transaction.CommitRetaining;
    TabGlobal_i.DPROC_EXTERNA.Transaction.CommitRetaining;
    TabGlobal_i.DSQL_SCRIPT.Transaction.CommitRetaining;
    TabGlobal_i.DDIAGRAMA.Transaction.CommitRetaining;

    PTabela(TabGlobal_i.DTABELAS, ['Count(NUMERO)'], '', Sequencia);
    if FREDT then
    begin
      if Sequencia[0] > 20 then
      begin
        Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente 20 '+^M+'Tabelas.',modAdvertencia,[ModOk]);
        Tree_Tabelas.SetFocus;
        exit;
      end;
    end;

    if C_CRACK then
    begin
      Mensagem(MSG_CRACK,ModErro,[ModOk]);
      exit;
    end;
  except
  on Erro: Exception do
    begin
      if Assigned(FormAguarde) then
        FormAguarde.Free;
      Mensagem('Erro: '+Erro.Message, modErro, [modOk]);
    end;
  end;

  if (Modificou = False) and (Regerar.Checked) then
    Modificou := True;
  if Modificou then
  begin
    try
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Analisando tabelas ...';
      FormAguarde.Show;
      FormAguarde.GaugeProcesso.Min := 0;
      if Sequencia[0] > 0 then
        FormAguarde.GaugeProcesso.Max := Sequencia[0]-1
      else
        FormAguarde.GaugeProcesso.Max := 0;
      FormAguarde.Incrementa(0);
      try
        TabGlobal_i.DTABELAS.First;
        Achou1 := False;
        while (not TabGlobal_i.DTABELAS.Eof) and (not Achou1) do
        begin
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          achou := False;
          while (not TabGlobal_i.DCAMPOST.Eof) and (not Achou) do
          begin
            if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then Achou := True;
            TabGlobal_i.DCAMPOST.Next;
          end;
          {if not Achou then
          begin
            Mensagem('Tabela: "'+TabGlobal_i.DTABELAS.NOME.Conteudo + '" está sem chave primária definida !',ModAdvertencia,[modOk]);
            Achou1 := True;
          end;}
          FormAguarde.Incrementa;
          TabGlobal_i.DTABELAS.Next;
        end;
      finally
        FormAguarde.Free;
      end;
      if Achou1 then
      begin
        Atualiza_Listas(False, True);
        Tree_Tabelas.SetFocus;
        Tree_TabelasChange(Self, Tree_Tabelas.Selected);
        exit;
      end;
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Gerando fontes ...';
      FormAguarde.Show;
      FormAguarde.GaugeProcesso.Min := 0;
      FormAguarde.GaugeProcesso.Max := 5;
      FormAguarde.Incrementa(0);
      try
        Gera_BaseDados;
        FormAguarde.Incrementa;
        Gera_CTabelas(Regerar.Checked);
        FormAguarde.Incrementa;
        Gera_CCalculos;
        FormAguarde.Incrementa;
        Gera_Abertura;
        FormAguarde.Incrementa;
        Gera_Adapter;
        FormAguarde.Incrementa;
      finally
        FormAguarde.Free;
      end;
    except
    on Erro: Exception do
      begin
        if Assigned(FormAguarde) then
          FormAguarde.Free;
        Mensagem('Erro: '+Erro.Message, modErro, [modOk]);
      end;
    end;
  end;
end;

procedure TFormDB_Case.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    Gravar;
    TabGlobal.Ini_Tabelas_Proj;
  except  
  on Erro: Exception do
    begin
      Mensagem('Erro: '+Erro.Message, modErro, [modOk]);
      Action := caFree;
    end;
  end;
end;

function TFormDB_Case.ValidaNomeBanco(S: String; Posicao: Integer): Boolean;
var
  Ok: Boolean;
begin
  Ok := True;
  if Trim(S) = '' then
  begin
    Mensagem('Necessário informar nome (Alias)!',ModAdvertencia,[modOk]);
    Ok := False;
  end;
  if (Ok) and (PTabela(TabGlobal_i.DBDADOS, ['<>numero', 'UPPER(nome)'], [Posicao, UpperCase(S)])) then
  begin
    Mensagem('Alias já Cadastrado!',ModAdvertencia,[modOk]);
    Ok := False;
  end;
  Result := Ok;
end;

function TFormDB_Case.ValidaNomeStored(S: String; Posicao: Integer): Boolean;
var
  Ok: Boolean;
begin
  Ok := True;
  if Trim(S) = '' then
  begin
    Mensagem('Necessário informar nome do objeto!',ModAdvertencia,[modOk]);
    Ok := False;
  end;
  if (Ok) and (PTabela(TabGlobal_i.DPROC_EXTERNA, ['<>numero', 'UPPER(nome)'], [Posicao, UpperCase(S)])) then
  begin
    Mensagem('Stored Procedure já Cadastrada!',ModAdvertencia,[modOk]);
    Ok := False;
  end;
  Result := Ok;
end;

function TFormDB_Case.ValidaNomeScript(S: String; Posicao: Integer): Boolean;
var
  Ok: Boolean;
begin
  Ok := True;
  if Trim(S) = '' then
  begin
    Mensagem('Necessário informar nome do objeto!',ModAdvertencia,[modOk]);
    Ok := False;
  end;
  if (Ok) and (PTabela(TabGlobal_i.DSQL_SCRIPT, ['<>numero', 'UPPER(nome)'], [Posicao, UpperCase(S)])) then
  begin
    Mensagem('Script já Cadastrado!',ModAdvertencia,[modOk]);
    Ok := False;
  end;
  Result := Ok;
end;

function TFormDB_Case.ValidaNomeCampo(S: String; NrTabela: Integer; Posicao: Integer = -1; Tabela: Boolean = False): Boolean;
var Caracter,TipoChar : String;
    I,PosAt: Integer;
    CharInvalido : Boolean;
begin
  Result := True;
  S := UpperCase(S);
  if Trim(S) = '' then Result := False;
  if Pos(S+'|',FormPrincipal.LNomesReservados2) > 0 then
  begin
    if Tabela then
      Mensagem('Nome da Tabela Inválido !'+^M+^M+S+' ( Reservado ) ...',modErro,[modOk])
    else
      Mensagem('Nome de Campo Inválido !'+^M+^M+S+' ( Reservado ) ...',modErro,[modOk]);
    Result := False;
    exit;
  end;
  CharInvalido := False;
  for I := 1 to Length(S) do
  begin
    Caracter := UpperCase(Copy(S,I,01));
    if not ((Caracter[1] in ['A'..'Z']) or (Caracter[1] in ['0'..'9']) or
            (Caracter = '_')) then
    begin
      CharInvalido := True;
      tipoChar := Caracter;
    end;
  end;
  Caracter := UpperCase(Copy(S,1,01));
  if Caracter[1] in ['0'..'9'] then
  begin
    CharInvalido := True;
    tipoChar := Caracter;
  end;
  if CharInvalido then
  begin
    Mensagem('Caracter Inválido no Nome: '+ #39 + TipoChar + #39,ModAdvertencia,[ModOk]);
    Result := False;
    exit;
  end;
  if Tabela then
  begin
    if PTabela(TabGlobal_i.DTABELAS,['<>NUMERO','UPPER(NOME)'],[Posicao,UpperCase(S)]) then
    begin
      Mensagem('Tabela já existente !!!',ModAdvertencia,[ModOk]);
      Result := False;
      exit;
    end;
  end
  else
  begin
    if PTabela(TabGlobal_i.DCAMPOST,['NUMERO','<>SEQUENCIA','UPPER(NOME)'],[NrTabela,Posicao,S]) then
    begin
      Mensagem('Campo já existente !!!',ModAdvertencia,[ModOk]);
      Result := False;
      exit;
    end;
  end;
end;

procedure TFormDB_Case.Tree_TabelasChange(Sender: TObject; Node: TTreeNode);

  procedure Posiciona_Item(Source: TDataSource);
  begin
    if (Insp_Tabela.Items.Count > 0) and
       ((Insp_Tabela.DataSource <> Source) or
        (Source = Nil)) then
      Insp_Tabela.ItemIndex := 0;
    Insp_Tabela.DataSource := Source;
  end;

begin
  if node.data <> Nil then      // campo
  begin
    if (Node.Level = 0) and (Node.Index > 3) then
    begin
      TabGlobal_i.DTABELAS.GotoBookmark(node.Data);
      Posiciona_Item(DataSource_Tabela);
      Label1.Caption := IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
    end
    else if Node.Level = 1 then
    begin
      if Node.Parent.Index = 0 then
      begin
        TabGlobal_i.DPROC_EXTERNA.GotoBookmark(node.data);
        Posiciona_Item(DataSource_Stored);
        Label1.Caption := IntToStr(TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
      end
      else if Node.Parent.Index = 1 then
      begin
        TabGlobal_i.DSQL_SCRIPT.GotoBookmark(node.data);
        Posiciona_Item(DataSource_Scripts);
        Label1.Caption := IntToStr(TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
      end
      else if Node.Parent.Index = 2 then
      begin
        TabGlobal_i.DCONSULTA.GotoBookmark(node.data);
        Posiciona_Item(DataSource_Consulta);
        Label1.Caption := IntToStr(TabGlobal_i.DCONSULTA.NUMERO.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
      end
      else if Node.Parent.Index = 3 then
      begin
        TabGlobal_i.DDIAGRAMA.GotoBookmark(node.data);
        Posiciona_Item(DataSource_Diagrama);
        Label1.Caption := IntToStr(TabGlobal_i.DDIAGRAMA.NUMERO.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
      end
      else if Node.Parent.Index > 3 then
      begin
        TabGlobal_i.DCAMPOST.GotoBookmark(node.data);
        Posiciona_Item(DataSource_Campo);
        Label1.Caption := IntToStr(TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
      end
    end
    else if Node.Level > 1 then
    begin
      case Node.Parent.Index of
        0: begin
             TabGlobal_i.DINDICEST.GotoBookmark(node.data);
             Posiciona_Item(DataSource_Indice);
             Label1.Caption := IntToStr(TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
           end;
        1: begin
             TabGlobal_i.DRELACIONA.GotoBookmark(node.data);
             Posiciona_Item(DataSource_Relacionamento);
             Label1.Caption := IntToStr(TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
           end;
        2: begin
             TabGlobal_i.DPROCESSOS.GotoBookmark(node.data);
             Posiciona_Item(DataSource_Processo);
             Label1.Caption := IntToStr(TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
           end;
        3: begin
             TabGlobal_i.DTRIGGER.GotoBookmark(node.data);
             Posiciona_Item(DataSource_Trigger);
             Label1.Caption := IntToStr(TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo) + ', ' + IntToStr(Insp_Tabela.ItemIndex);
           end;
      end;
    end;
  end
  else
  begin
    Insp_Tabela.DataSource := Nil;
    Label1.Caption := IntToStr(Insp_Tabela.ItemIndex);
  end;
end;

procedure TFormDB_Case.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDB_Case.BthAjudaTabelaClick(Sender: TObject);
begin
  ChamaAjuda;
end;

procedure TFormDB_Case.Lista_BancoDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 20;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    Canvas.BrushCopy(r, Image1.Picture.Bitmap, Rect(0, 0, 18, 20),
      Image1.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 25, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormDB_Case.Insp_BancoGetButtonType(Sender: TObject;
  TheIndex: Integer; var Value: TButtonType);
begin
  if (TheIndex = 0) or (TheIndex = 1) or (TheIndex = 4) then
    Value := btDropDown
  else if (TheIndex = 3) then
    Value := btDialog;
end;

procedure TFormDB_Case.Insp_BancoGetEnableExternalEditor(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  if (TheIndex = 3) then
    Value := True;
end;

procedure TFormDB_Case.Insp_BancoGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
var
  I: Integer;
begin
  Strings.Clear;
  if (TheIndex = 1) then
    for I:=1 to Length(Bancos_Suportados) do
      Strings.Add(Bancos_Suportados[I])
  else if (TheIndex = 0) or (TheIndex = 4) then
  begin
    Strings.Add('Sim');
    Strings.Add('Não');
  end;
end;

function TFormDB_Case.Insp_BancoCallEditor(Sender: TObject;
  TheIndex: Integer): Boolean;
begin
  if TheIndex = 3 then
  begin
    if TabGlobal_i.DBDADOS.BDADOS.Conteudo > 4 then
      OpenGDB.Filter := 'Banco de dados|*.*'
    else
      OpenGDB.Filter := 'Firebird/Interbase (*.gdb;*.fdb)|*.gdb;*.fdb';
    OpenGDB.FileName := TabGlobal_i.DBDADOS.ARQUIVO.Conteudo;
    if OpenGDB.Execute then
    begin
      TabGlobal_i.DBDADOS.Modifica;
      TabGlobal_i.DBDADOS.ARQUIVO.Conteudo := UpperCase(ExtractFileName(OpenGDB.FileName));
      if Pos('.', TabGlobal_i.DBDADOS.ARQUIVO.Conteudo) > 0 then
        TabGlobal_i.DBDADOS.ARQUIVO.Conteudo := Copy(TabGlobal_i.DBDADOS.ARQUIVO.Conteudo, 01, Pos('.', TabGlobal_i.DBDADOS.ARQUIVO.Conteudo)-1);
      TabGlobal_i.DBDADOS.Salva;
    end;
  end
  else if TheIndex = 8 then
  begin
    with TStrEditDlg.Create(nil) do
    begin
      try
        Memo.Lines := TabGlobal_i.DBDADOS.PARAMETROS.Conteudo;
        if ShowModal=mrOK then
        begin
          TabGlobal_i.DBDADOS.Modifica;
          TBlobField(TabGlobal_i.DBDADOS.FieldByName('PARAMETROS')).AsString := Memo.Lines.Text;
          TabGlobal_i.DBDADOS.Salva;
        end;
      finally
        Free;
      end;
    end;
  end;
end;

procedure TFormDB_Case.Lista_BancoClick(Sender: TObject);
begin
  if Lista_Banco.ItemIndex = -1 then
  begin
    Insp_Banco.DataSource := Nil;
    exit;
  end;
  if not Assigned(Insp_Banco.DataSource) then
    Insp_Banco.DataSource := DataSource_Banco;
  TabGlobal_i.DBDADOS.GotoBookmark(Lista_Banco.Items.Objects[Lista_Banco.ItemIndex]);
end;

procedure TFormDB_Case.Apos_Valor(TheIndex: Integer);
begin
  case TheIndex of
    0: Lista_Banco.Items[Lista_Banco.ItemIndex] := TabGlobal_i.DBDADOS.NOME.Conteudo;
    1: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DTABELAS.NOME.Conteudo;
    2: begin
         with Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex] do
         begin
           Text := TabGlobal_i.DCAMPOST.NOME.Conteudo + '  ('+Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]+ ' ' +IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+')';
           if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
             ImageIndex := 2
           else if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
             ImageIndex := 3
           else
             ImageIndex := 1;
           SelectedIndex := ImageIndex;
         end;
       end;
    3: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DINDICEST.TITULO_I.Conteudo;
    4: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DRELACIONA.TITULO_I.Conteudo;
    5: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo;
    6: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DCONSULTA.NOME.Conteudo;
    7: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DTRIGGER.NOME.Conteudo;
    8: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo;
    9: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo;
    10: Tree_Tabelas.Items[Tree_Tabelas.Selected.AbsoluteIndex].Text := TabGlobal_i.DDIAGRAMA.TITULO_I.Conteudo;
  end;
end;

procedure TFormDB_Case.BtnInserir_BancoClick(Sender: TObject);
Var
  Seq: Integer;
begin
  TabGlobal_i.DBDADOS.Last;
  Seq := TabGlobal_i.DBDADOS.NUMERO.Conteudo + 1;
  if (FREDT) and (Lista_Banco.Items.Count > 0) then
    Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente 1(um) '+^M+'Banco de Dados.',modInformacao,[ModOk])
  else
  begin
    TabGlobal_i.DBDADOS.Inclui(Nil);
    TabGlobal_i.DBDADOS.NUMERO.Conteudo    := Seq;
    TabGlobal_i.DBDADOS.PADRAO.Conteudo    := 1;
    TabGlobal_i.DBDADOS.BDADOS.Conteudo    := TabGlobal_i.DPROJETO.BDADOS.Conteudo;
    TabGlobal_i.DBDADOS.NOME.Conteudo      := 'Base_Dados';
    TabGlobal_i.DBDADOS.ARQUIVO.Conteudo   := 'BASE';
    TabGlobal_i.DBDADOS.LOGIN.Conteudo     := 0;
    if TabGlobal_i.DPROJETO.BDADOS.Conteudo <= 2 then
    begin
      TabGlobal_i.DBDADOS.USUARIO.Conteudo   := 'SYSDBA';
      TabGlobal_i.DBDADOS.SENHA.Conteudo     := 'masterkey';
    end
    else
    begin
      TabGlobal_i.DBDADOS.USUARIO.Conteudo   := 'root';
      TabGlobal_i.DBDADOS.SENHA.Conteudo     := '';
    end;
    TabGlobal_i.DBDADOS.Salva;
    Atualiza_Listas(True, False);
    Lista_Banco.ItemIndex := Lista_Banco.Items.Count-1;
    Lista_BancoClick(Self);
    Insp_Banco.ItemIndex := 2;
    Insp_Banco.SetFocus;
  end;
end;

procedure TFormDB_Case.BtnExcluir_BancoClick(Sender: TObject);
begin
  if Lista_Banco.ItemIndex = -1 then
    exit;
  if Mensagem('Excluir Banco de Dados ?'+^M+^M+TabGlobal_i.DBDADOS.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mrYes then
  begin
    if (TabGlobal_i.DBDADOS.State in [dsEdit,dsInsert]) then TabGlobal_i.DBDADOS.Post;
    if TabGlobal_i.DBDADOS.Exclui then
    begin
      Atualiza_Listas(True, False);
      if Lista_Banco.Items.Count > 0 then
        Lista_Banco.ItemIndex := 0;
      Lista_BancoClick(Self);
    end;
  end;
end;

procedure TFormDB_Case.BtnInserir_StoredClick(Sender: TObject);
var
  Seq: Integer;
  node: TTreeNode;
  Sequencia: Variant;
begin
  if Lista_Banco.Items.Count = 0 then
  begin
    Mensagem('Nenhum banco de dados foi encontrado!', modAdvertencia, [ModOk]);
    PageControl1.ActivePageIndex := 0;
    PageControl1Change(Self);
    //Lista_Banco.SetFocus;
    exit;
  end;

  if Insp_Tabela.Items.Count > 0 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DPROC_EXTERNA, ['First 1 NUMERO'], '', Sequencia, 'NUMERO DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DPROC_EXTERNA.Inclui(Nil);
  TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo := Seq;
  TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo   := '';
  TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo  := 1;
  TabGlobal_i.DPROC_EXTERNA.BASE.Conteudo   := 1;
  TabGlobal_i.DPROC_EXTERNA.Salva;

  Node := Tree_Tabelas.Items[0];
  Node := Tree_Tabelas.items.AddChildObject(Node, '', TabGlobal_i.DPROC_EXTERNA.GetBookmark);
  Node.ImageIndex := 6;
  Node.SelectedIndex := 6;

  Tree_Tabelas.Items[0].Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_ScriptClick(Sender: TObject);
var
  Seq: Integer;
  node: TTreeNode;
  Sequencia: Variant;
begin
  if Lista_Banco.Items.Count = 0 then
  begin
    Mensagem('Nenhum banco de dados foi encontrado!', modAdvertencia, [ModOk]);
    PageControl1.ActivePageIndex := 0;
    PageControl1Change(Self);
    Lista_Banco.SetFocus;
    exit;
  end;

  if Insp_Tabela.Items.Count > 0 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DSQL_SCRIPT, ['First 1 NUMERO'], '', Sequencia, 'NUMERO DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DSQL_SCRIPT.Inclui(Nil);
  TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo    := Seq;
  TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo      := '';
  TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo  := 1;
  TabGlobal_i.DSQL_SCRIPT.BASE.Conteudo      := 1;
  TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo     := 1;
  TabGlobal_i.DSQL_SCRIPT.Salva;

  for Seq := 1 to Tree_Tabelas.Items.Count-1 do
    if Tree_Tabelas.Items[Seq].Level = 0 then
    begin
      Node := Tree_Tabelas.Items[Seq];
      break;
    end;
  Node := Tree_Tabelas.items.AddChildObject(Node, '', TabGlobal_i.DSQL_SCRIPT.GetBookmark);
  Node.ImageIndex := 14;
  Node.SelectedIndex := 14;

  Tree_Tabelas.Items[1].Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_DiagramaClick(Sender: TObject);
var
  Seq: Integer;
  node, node_pai: TTreeNode;
  Sequencia: Variant;
begin
  if Lista_Banco.Items.Count = 0 then
  begin
    Mensagem('Nenhum banco de dados foi encontrado!', modAdvertencia, [ModOk]);
    PageControl1.ActivePageIndex := 0;
    PageControl1Change(Self);
    Lista_Banco.SetFocus;
    exit;
  end;

  if Insp_Tabela.Items.Count > 0 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DDIAGRAMA, ['First 1 NUMERO'], '', Sequencia, 'NUMERO DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DDIAGRAMA.Inclui(Nil);
  TabGlobal_i.DDIAGRAMA.NUMERO.Conteudo   := Seq;
  TabGlobal_i.DDIAGRAMA.TITULO_I.Conteudo := '';
  TabGlobal_i.DDIAGRAMA.Salva;

  for Seq := 1 to Tree_Tabelas.Items.Count-1 do
    if (Tree_Tabelas.Items[Seq].Level = 0) and (Tree_Tabelas.Items[Seq].Index > 2) then
    begin
      Node_pai := Tree_Tabelas.Items[Seq];
      break;
    end;
  Node := Tree_Tabelas.items.AddChildObject(Node_pai, '', TabGlobal_i.DDIAGRAMA.GetBookmark);
  Node.ImageIndex := 13;
  Node.SelectedIndex := 13;

  Node_pai.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_TabClick(Sender: TObject);
var
  Seq: Integer;
  node, node_extra: TTreeNode;
  Sequencia: Variant;
begin
  if FREDT then
  begin
    PTabela(TabGlobal_i.DTABELAS, ['Count(NUMERO)'], '', Sequencia);
    if Sequencia[0] >= 20 then
    begin
      Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente 20 '+^M+'Tabelas.',modAdvertencia,[ModOk]);
      Tree_Tabelas.SetFocus;
      exit;
    end;
  end;

  if Lista_Banco.Items.Count = 0 then
  begin
    Mensagem('Nenhum banco de dados foi encontrado!', modAdvertencia, [ModOk]);
    PageControl1.ActivePageIndex := 0;
    PageControl1Change(Self);
    Lista_Banco.SetFocus;
    exit;
  end;

  if Insp_Tabela.ItemIndex > 8 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DTABELAS, ['First 1 NUMERO'], '', Sequencia, 'NUMERO DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DTABELAS.Inclui(Nil);
  TabGlobal_i.DTABELAS.NUMERO.Conteudo        := Seq;
  TabGlobal_i.DTABELAS.NOME.Conteudo          := '';
  TabGlobal_i.DTABELAS.GLOBAL.Conteudo        := 1;
  TabGlobal_i.DTABELAS.ABRIR_TABELA.Conteudo  := 0;
  TabGlobal_i.DTABELAS.BASE.Conteudo          := 1;
  TabGlobal_i.DTABELAS.USE_GENERATOR.Conteudo := 1;
  TabGlobal_i.DTABELAS.Salva;

  Node := Nil;
  Node := Tree_Tabelas.items.AddObject(Node, TabGlobal_i.DTABELAS.NOME.Conteudo, TabGlobal_i.DTABELAS.GetBookmark);
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;

  Tree_Tabelas.Items[Tree_Tabelas.Items.Count-1].Selected := True;
  Tree_TabelasChange(Self, Tree_Tabelas.Selected);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;

  Node_Extra := Tree_Tabelas.Items.AddChild(Node, 'Indices');
  Node_Extra.ImageIndex    := 7;
  Node_Extra.SelectedIndex := 7;

  Node_Extra := Tree_Tabelas.Items.AddChild(Node, 'Integridades & Relacionamentos');
  Node_Extra.ImageIndex    := 7;
  Node_Extra.SelectedIndex := 7;

  Node_Extra := Tree_Tabelas.Items.AddChild(Node, 'Processos & Lançamentos');
  Node_Extra.ImageIndex    := 7;
  Node_Extra.SelectedIndex := 7;

  Node_Extra := Tree_Tabelas.Items.AddChild(Node, 'Triggers (Bloco de Comandos)');
  Node_Extra.ImageIndex    := 7;
  Node_Extra.SelectedIndex := 7;
end;

function TFormDB_Case.Retorna_NodeTab: TTreeNode;
var
  Node: TTreeNode;
begin
  Node := Nil;
  if Tree_Tabelas.Selected <> Nil then
  begin
    if Tree_Tabelas.Selected.Level = 0 then
      Node := Tree_Tabelas.Selected
    else if Tree_Tabelas.Selected.Level = 1 then
      Node := Tree_Tabelas.Selected.Parent
    else if Tree_Tabelas.Selected.Level = 2 then
      Node := Tree_Tabelas.Selected.Parent.Parent;
    if Node.Index < 4 then
      Node := Nil;
  end;
  Retorna_NodeTab := Node
end;

function TFormDB_Case.Retorna_NrTab: Integer;
var
  Node: TTreeNode;
begin
  Result := -999;
  if Tree_Tabelas.Selected = Nil then
    exit
  else
  begin
    if Tree_Tabelas.Selected.Level = 0 then
      Node := Tree_Tabelas.Selected
    else if Tree_Tabelas.Selected.Level = 1 then
      Node := Tree_Tabelas.Selected.Parent
    else if Tree_Tabelas.Selected.Level = 2 then
      Node := Tree_Tabelas.Selected.Parent.Parent;
    if Node.Index < 4 then
      exit;
  end;
  if Tree_Tabelas.Selected.Level = 0 then
    Result := TabGlobal_i.DTABELAS.NUMERO.Conteudo
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index > 4) then
    Result := TabGlobal_i.DCAMPOST.NUMERO.Conteudo
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index <= 4) then
  begin
    TabGlobal_i.DTABELAS.GotoBookmark(Tree_Tabelas.Selected.Parent.Data);
    Result := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
  end
  else if (Tree_Tabelas.Selected.Level = 2) then
  begin
    TabGlobal_i.DTABELAS.GotoBookmark(Tree_Tabelas.Selected.Parent.Parent.Data);
    Result := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
  end;
end;

procedure TFormDB_Case.BtnInserir_CmpClick(Sender: TObject);
var
  node: TTreeNode;
  Sequencia: Variant;
  Seq: Integer;
  NrTab: Integer;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  PTabela(TabGlobal_i.DCAMPOST, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;

  TabGlobal_i.DCAMPOST.Inclui(Nil);
  TabGlobal_i.DCAMPOST.NUMERO.Conteudo             := NrTab;
  TabGlobal_i.DCAMPOST.NOME.Conteudo               := '';
  TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo          := Seq;
  TabGlobal_i.DCAMPOST.TIPO.Conteudo               := 1;
  TabGlobal_i.DCAMPOST.EDICAO.Conteudo             := 1;
  TabGlobal_i.DCAMPOST.CHAVE.Conteudo              := 0;
  TabGlobal_i.DCAMPOST.CALCULADO.Conteudo          := 0;
  TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo     := 0;
  TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo     := 1;
  TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo          := 0;
  TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := 1;
  TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo       := 0;
  TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo    := Seq - 1;
  TabGlobal_i.DCAMPOST.EXTRA.Conteudo              := 0;
  TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo        := 1;
  TabGlobal_i.DCAMPOST.TAMANHO.Conteudo            := 1;
  TabGlobal_i.DCAMPOST.VALIDA_ONEXIT.Conteudo      := 1;
  TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo       := 1;
  TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Conteudo      := 1;
  TabGlobal_i.DCAMPOST.Salva;

  if (Tree_Tabelas.Selected.Level = 2) then
    Node := Tree_Tabelas.Selected.Parent
  else
    Node := Tree_Tabelas.Selected;
  if Tree_Tabelas.Selected.Level = 0 then
    Node := Tree_Tabelas.items.AddChildObject(Node, TabGlobal_i.DCAMPOST.NOME.Conteudo + '  ('+Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]+ ' ' +IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+')', TabGlobal_i.DCAMPOST.GetBookmark)
  else
    Node := Tree_Tabelas.Items.AddObject(Node, TabGlobal_i.DCAMPOST.NOME.Conteudo + '  ('+Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]+ ' ' +IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+')', TabGlobal_i.DCAMPOST.GetBookmark);
  Node.ImageIndex := 1;
  Node.SelectedIndex := 1;
  Node.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Tree_Tabelas.Selected);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnExcluirClick(Sender: TObject);
begin
  if Tree_Tabelas.Selected = Nil then
  begin
    Mensagem('Selecione objeto!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if (Tree_Tabelas.Selected.Level = 0) and (Tree_Tabelas.Selected.Index > 3) then
  begin
    if Mensagem('Excluir Tabela?'+^M+^M+TabGlobal_i.DTABELAS.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DTABELAS.State in [dsEdit,dsInsert]) then TabGlobal_i.DTABELAS.Post;
      if (TabGlobal_i.DCAMPOST.State in [dsEdit,dsInsert]) then TabGlobal_i.DCAMPOST.Post;
      if TabGlobal_i.DTABELAS.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 0) then
  begin
    if Mensagem('Excluir Stored Procedure?'+^M+^M+TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DPROC_EXTERNA.State in [dsEdit,dsInsert]) then TabGlobal_i.DPROC_EXTERNA.Post;
      if TabGlobal_i.DPROC_EXTERNA.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 1) then
  begin
    if Mensagem('Excluir Script?'+^M+^M+TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DSQL_SCRIPT.State in [dsEdit,dsInsert]) then TabGlobal_i.DSQL_SCRIPT.Post;
      if TabGlobal_i.DSQL_SCRIPT.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 2) then
  begin
    if Mensagem('Excluir Consulta?'+^M+^M+TabGlobal_i.DCONSULTA.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DCONSULTA.State in [dsEdit,dsInsert]) then TabGlobal_i.DCONSULTA.Post;
      if TabGlobal_i.DCONSULTA.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 3) then
  begin
    if Mensagem('Excluir Diagrama?'+^M+^M+TabGlobal_i.DDIAGRAMA.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DDIAGRAMA.State in [dsEdit,dsInsert]) then TabGlobal_i.DDIAGRAMA.Post;
      if TabGlobal_i.DDIAGRAMA.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index > 3) then
  begin
    if Mensagem('Excluir Campo?'+^M+^M+TabGlobal_i.DCAMPOST.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DCAMPOST.State in [dsEdit,dsInsert]) then TabGlobal_i.DCAMPOST.Post;
      if TabGlobal_i.DCAMPOST.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 0) then
  begin
    if Mensagem('Excluir Índice?'+^M+^M+TabGlobal_i.DINDICEST.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DINDICEST.State in [dsEdit,dsInsert]) then TabGlobal_i.DINDICEST.Post;
      if TabGlobal_i.DINDICEST.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 1) then
  begin
    if Mensagem('Excluir Integridade/Relacionamento?'+^M+^M+TabGlobal_i.DRELACIONA.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DRELACIONA.State in [dsEdit,dsInsert]) then TabGlobal_i.DRELACIONA.Post;
      if TabGlobal_i.DRELACIONA.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 2) then
  begin
    if Mensagem('Excluir Processo/Lançamento?'+^M+^M+TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DPROCESSOS.State in [dsEdit,dsInsert]) then TabGlobal_i.DPROCESSOS.Post;
      if TabGlobal_i.DPROCESSOS.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end
  else if (Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 3) then
  begin
    if Mensagem('Excluir Trigger?'+^M+^M+TabGlobal_i.DTRIGGER.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
    begin
      if (TabGlobal_i.DTRIGGER.State in [dsEdit,dsInsert]) then TabGlobal_i.DTRIGGER.Post;
      if TabGlobal_i.DTRIGGER.Exclui then
      begin
        Tree_Tabelas.Selected.Delete;
        Modificou := True;
      end;
    end;
  end;
  Tree_Tabelas.SetFocus;
end;

procedure TFormDB_Case.Tree_TabelasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    BtnExcluirClick(Self);
  if Key = VK_INSERT then
    if Tree_Tabelas.Selected <> Nil then
    begin
      if (Tree_Tabelas.Selected.Level = 0) and (Tree_Tabelas.Selected.Index > 3) then
      begin
        if Tree_Tabelas.Selected.Expanded then
          BtnInserir_CmpClick(Self)
        else
          BtnInserir_tabClick(Self);
      end
      else if ((Tree_Tabelas.Selected.Level = 0) and (Tree_Tabelas.Selected.Index = 0)) or
              ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 0)) then
        BtnInserir_StoredClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 0) and (Tree_Tabelas.Selected.Index = 1)) or
              ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 1)) then
        BtnInserir_ScriptClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 0) and (Tree_Tabelas.Selected.Index = 2)) or
              ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 2)) then
        BtnInserir_ConsultaClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 0) and (Tree_Tabelas.Selected.Index = 3)) or
              ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Parent.Index = 3)) then
        BtnInserir_DiagramaClick(Self)
      else if (Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index > 3) then
        BtnInserir_CmpClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index = 0)) or
              ((Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 0)) then
        BtnInserir_IndiceClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index = 1)) or
              ((Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 1)) then
        BtnInserir_IntegridadeClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index = 2)) or
              ((Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 2)) then
        BtnInserir_ProcessoClick(Self)
      else if ((Tree_Tabelas.Selected.Level = 1) and (Tree_Tabelas.Selected.Index = 3)) or
              ((Tree_Tabelas.Selected.Level = 2) and (Tree_Tabelas.Selected.Parent.Index = 3)) then
        BtnInserir_TriggerClick(Self)
    end;
end;

procedure TFormDB_Case.Lista_BancoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    BtnExcluir_BancoClick(Self);
  if Key = VK_INSERT then
    BtnInserir_BancoClick(Self);
end;

procedure TFormDB_Case.PageControl1Change(Sender: TObject);
begin
  Case PageControl1.ActivePageIndex of
    0: begin
         Lista_Banco.SetFocus;
         if (Lista_Banco.ItemIndex = -1) and (Lista_Banco.Items.Count > 0) then
           Lista_Banco.ItemIndex := 0;
         Lista_BancoClick(Self);  
       end;
    1: Tree_Tabelas.SetFocus;
  end;
end;

procedure TFormDB_Case.Insp_TabelaSelectItem(Sender: TObject;
  TheIndex: Integer);
begin
  case Insp_Tabela.DataSource.Tag of
    10: Begin
        end;
    20: Begin
          if (TheIndex = 9) or (TheIndex = 11) or (TheIndex = 22) or (TheIndex = 24) then
            Insp_Tabela.InplaceEdit.ReadOnly := True;
        end;
    40: Begin
          if (TheIndex = 2) then
            Insp_Tabela.InplaceEdit.ReadOnly := True;
        end;
    50: Begin
          if (TheIndex = 2) then
            Insp_Tabela.InplaceEdit.ReadOnly := True;
        end;
  end;
end;

procedure TFormDB_Case.Tree_TabelasDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node: TTreeNode;
  AddMode: TNodeAttachMode;
  NrTab, NrSeq1, NrSeq2: Integer;
  Ok: Boolean;
  I: Integer;
begin
  try
    with TTreeView(Sender) do
      if Assigned(Selected) then
      begin
        Ok := False;
        AddMode := naInsert;
        Node := DropTarget;
        if Assigned(Node) then
        begin
          if (Selected.Level > 0) and (Node.Level = 0) then
          else
          begin
            if (Selected.Level = 1) and (Node.Index > 3) then
            begin
              TabGlobal_i.DCAMPOST.GotoBookmark(node.data);
              NrTab := TabGlobal_i.DCAMPOST.NUMERO.Conteudo;
              NrSeq2 := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
              TabGlobal_i.DCAMPOST.GotoBookmark(Selected.data);
              NrSeq1 := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
              if TabGlobal_i.DCAMPOST.NUMERO.Conteudo = NrTab then
              begin
                Selected.MoveTo(Node, AddMode);
                TabGlobal_i.DCAMPOST.GotoBookmark(node.data);
                TabGlobal_i.DCAMPOST.Modifica;
                TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := -1;
                TabGlobal_i.DCAMPOST.Salva;

                TabGlobal_i.DCAMPOST.GotoBookmark(Selected.data);
                TabGlobal_i.DCAMPOST.Modifica;
                TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := NrSeq2;
                TabGlobal_i.DCAMPOST.Salva;

                TabGlobal_i.DCAMPOST.GotoBookmark(node.data);
                TabGlobal_i.DCAMPOST.Modifica;
                TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := NrSeq1;
                TabGlobal_i.DCAMPOST.Salva;

                for I:=4 to Selected.Parent.Count-1 do
                begin
                  TabGlobal_i.DCAMPOST.GotoBookmark(Selected.Parent.Item[I].data);
                  TabGlobal_i.DCAMPOST.Edit;
                  TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := (I-4+1) * (-1);
                  TabGlobal_i.DCAMPOST.Post;
                end;

                for I:=4 to Selected.Parent.Count-1 do
                begin
                  TabGlobal_i.DCAMPOST.GotoBookmark(Selected.Parent.Item[I].data);
                  TabGlobal_i.DCAMPOST.Modifica;
                  TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := I-4+1;
                  TabGlobal_i.DCAMPOST.Salva;
                end;

                TabGlobal_i.DCAMPOST.GotoBookmark(Selected.data);

                Ok := True;
              end;
            end
            else if (Selected.Level = 2) and (Node.Parent = Selected.Parent) then
            begin
              case Selected.Parent.Index of
                0: begin
                     TabGlobal_i.DINDICEST.GotoBookmark(node.data);
                     NrTab := TabGlobal_i.DINDICEST.NUMERO.Conteudo;
                     NrSeq2 := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo;
                     TabGlobal_i.DINDICEST.GotoBookmark(Selected.data);
                     NrSeq1 := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo;
                     if TabGlobal_i.DINDICEST.NUMERO.Conteudo = NrTab then
                     begin
                       Selected.MoveTo(Node, AddMode);
                       TabGlobal_i.DINDICEST.GotoBookmark(node.data);
                       TabGlobal_i.DINDICEST.Modifica;
                       TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := -1;
                       TabGlobal_i.DINDICEST.Salva;

                       TabGlobal_i.DINDICEST.GotoBookmark(Selected.data);
                       TabGlobal_i.DINDICEST.Modifica;
                       TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := NrSeq2;
                       TabGlobal_i.DINDICEST.Salva;

                       TabGlobal_i.DINDICEST.GotoBookmark(node.data);
                       TabGlobal_i.DINDICEST.Modifica;
                       TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := NrSeq1;
                       TabGlobal_i.DINDICEST.Salva;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DINDICEST.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DINDICEST.Edit;
                         TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := (I+1) * (-1);
                         TabGlobal_i.DINDICEST.Post;
                       end;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DINDICEST.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DINDICEST.Modifica;
                         TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := I+1;
                         TabGlobal_i.DINDICEST.Salva;
                       end;

                       TabGlobal_i.DINDICEST.GotoBookmark(Selected.data);

                       Ok := True;
                     end;
                   end;
                1: begin
                     TabGlobal_i.DRELACIONA.GotoBookmark(node.data);
                     NrTab := TabGlobal_i.DRELACIONA.NUMERO.Conteudo;
                     NrSeq2 := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo;
                     TabGlobal_i.DRELACIONA.GotoBookmark(Selected.data);
                     NrSeq1 := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo;
                     if TabGlobal_i.DRELACIONA.NUMERO.Conteudo = NrTab then
                     begin
                       Selected.MoveTo(Node, AddMode);
                       TabGlobal_i.DRELACIONA.GotoBookmark(node.data);
                       TabGlobal_i.DRELACIONA.Modifica;
                       TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := -1;
                       TabGlobal_i.DRELACIONA.Salva;

                       TabGlobal_i.DRELACIONA.GotoBookmark(Selected.data);
                       TabGlobal_i.DRELACIONA.Modifica;
                       TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := NrSeq2;
                       TabGlobal_i.DRELACIONA.Salva;

                       TabGlobal_i.DRELACIONA.GotoBookmark(node.data);
                       TabGlobal_i.DRELACIONA.Modifica;
                       TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := NrSeq1;
                       TabGlobal_i.DRELACIONA.Salva;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DRELACIONA.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DRELACIONA.Edit;
                         TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := (I+1) * (-1);
                         TabGlobal_i.DRELACIONA.Post;
                       end;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DRELACIONA.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DRELACIONA.Modifica;
                         TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := I+1;
                         TabGlobal_i.DRELACIONA.Salva;
                       end;

                       TabGlobal_i.DRELACIONA.GotoBookmark(Selected.data);

                       Ok := True;
                     end;
                   end;
                2: begin
                     TabGlobal_i.DPROCESSOS.GotoBookmark(node.data);
                     NrTab := TabGlobal_i.DPROCESSOS.NUMERO.Conteudo;
                     NrSeq2 := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo;
                     TabGlobal_i.DPROCESSOS.GotoBookmark(Selected.data);
                     NrSeq1 := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo;
                     if TabGlobal_i.DPROCESSOS.NUMERO.Conteudo = NrTab then
                     begin
                       Selected.MoveTo(Node, AddMode);
                       TabGlobal_i.DPROCESSOS.GotoBookmark(node.data);
                       TabGlobal_i.DPROCESSOS.Modifica;
                       TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := -1;
                       TabGlobal_i.DPROCESSOS.Salva;

                       TabGlobal_i.DPROCESSOS.GotoBookmark(Selected.data);
                       TabGlobal_i.DPROCESSOS.Modifica;
                       TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := NrSeq2;
                       TabGlobal_i.DPROCESSOS.Salva;

                       TabGlobal_i.DPROCESSOS.GotoBookmark(node.data);
                       TabGlobal_i.DPROCESSOS.Modifica;
                       TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := NrSeq1;
                       TabGlobal_i.DPROCESSOS.Salva;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DPROCESSOS.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DPROCESSOS.Edit;
                         TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := (I+1) * (-1);
                         TabGlobal_i.DPROCESSOS.Post;
                       end;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DPROCESSOS.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DPROCESSOS.Modifica;
                         TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := I+1;
                         TabGlobal_i.DPROCESSOS.Salva;
                       end;

                       TabGlobal_i.DPROCESSOS.GotoBookmark(Selected.data);

                       Ok := True;
                     end;
                   end;
                3: begin
                     TabGlobal_i.DTRIGGER.GotoBookmark(node.data);
                     NrTab := TabGlobal_i.DTRIGGER.NUMERO.Conteudo;
                     NrSeq2 := TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo;
                     TabGlobal_i.DTRIGGER.GotoBookmark(Selected.data);
                     NrSeq1 := TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo;
                     if TabGlobal_i.DTRIGGER.NUMERO.Conteudo = NrTab then
                     begin
                       Selected.MoveTo(Node, AddMode);
                       TabGlobal_i.DTRIGGER.GotoBookmark(node.data);
                       TabGlobal_i.DTRIGGER.Modifica;
                       TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo := -1;
                       TabGlobal_i.DTRIGGER.Salva;

                       TabGlobal_i.DTRIGGER.GotoBookmark(Selected.data);
                       TabGlobal_i.DTRIGGER.Modifica;
                       TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo := NrSeq2;
                       TabGlobal_i.DTRIGGER.Salva;

                       TabGlobal_i.DTRIGGER.GotoBookmark(node.data);
                       TabGlobal_i.DTRIGGER.Modifica;
                       TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo := NrSeq1;
                       TabGlobal_i.DTRIGGER.Salva;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DTRIGGER.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DTRIGGER.Edit;
                         TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo := (I+1) * (-1);
                         TabGlobal_i.DTRIGGER.Post;
                       end;

                       for I:=0 to Selected.Parent.Count-1 do
                       begin
                         TabGlobal_i.DTRIGGER.GotoBookmark(Selected.Parent.Item[I].data);
                         TabGlobal_i.DTRIGGER.Modifica;
                         TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo := I+1;
                         TabGlobal_i.DTRIGGER.Salva;
                       end;

                       TabGlobal_i.DTRIGGER.GotoBookmark(Selected.data);

                       Ok := True;
                     end;
                   end;
              end;
            end;
          end;
          if not Ok then
            Mensagem('Mova somente: campos, índices, integridades, processos e triggers de uma mesma tabela!', modAdvertencia, [ModOk]);
        end;
      end;
  finally
  end;
end;

procedure TFormDB_Case.Tree_TabelasDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TFormDB_Case.BtnImportarClick(Sender: TObject);
var
  Sequencia: Variant;
begin
  if FREDT then
  begin
    PTabela(TabGlobal_i.DTABELAS, ['Count(NUMERO)'], '', Sequencia);
    if Sequencia[0] >= 20 then
    begin
      Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente 20 '+^M+'Tabelas.',modAdvertencia,[ModOk]);
      exit;
    end;
  end;
  FormImpEstrutura := TFormImpEstrutura.Create(Application);
  try
    if FormImpEstrutura.ShowModal = mrOk then
      Atualiza_Listas(False, True);
  finally
    FormImpEstrutura.Free;
  end;
end;

procedure TFormDB_Case.BtnHerdarClick(Sender: TObject);
Var
  I, Seq, NrTab, Posicao: Integer;
  Herdou, Cancelou: Boolean;
  xnome, xmascara, xtitulo_c, xajuda, xpadrao, xvalidacao, xvalidos, xdescricao,
  xprevalidacao, xmsgerro, xtabestrangeira, xcampochave, xcamposvisuais,xnomefisico: String;
  xtipo, xtamanho, xedicao, xchave, xcalculado, xautoincremento, xinvisivel,
  xtipoprevalidacao, xlimparcampo, xseq, xsempreatribui, xindiceconsulta,xestilochave,xtipofisico: integer;
  xvariaveis, xcodificacao: TStringList;
  Sequencia: Variant;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if (Tree_Tabelas.Selected.Level = 2) then
    Posicao := Tree_Tabelas.Selected.Parent.AbsoluteIndex
  else
    Posicao := Tree_Tabelas.Selected.AbsoluteIndex;
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    FormCamposProj.Tipo := 1;
    FormCamposProj.Escolha := True;
    if FormCamposProj.ShowModal = mrOk then
    begin
      PTabela(TabGlobal_i.DCAMPOST, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
      if Sequencia[0] = Null then
        Seq := 1
      else
        Seq := Sequencia[0] + 1;
      for I:=0 to FormCamposProj.FieldsLB_S.Items.Count-1 do
        if FormCamposProj.FieldsLB_S.Checked[I] then
        begin
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+FormCamposProj.Retorno+ 'AND SEQUENCIA = '+IntToStr(Integer(FormCamposProj.FieldsLB_S.Items.Objects[I]));
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          if not TabGlobal_i.DCAMPOST.Eof then
          begin
            xvariaveis := TStringList.Create;
            xcodificacao := TStringList.Create;
            xseq       := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
            xnome      := TabGlobal_i.DCAMPOST.NOME.Conteudo;
            xtipo      := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
            xtamanho   := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
            xedicao    := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
            xmascara   := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
            xtitulo_c  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
            xajuda     := TabGlobal_i.DCAMPOST.AJUDA.Conteudo;
            xpadrao    := TabGlobal_i.DCAMPOST.PADRAO.Conteudo;
            xvalidacao := TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo;
            xvalidos   := TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text;
            xdescricao := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text;
            xchave     := TabGlobal_i.DCAMPOST.CHAVE.Conteudo;
            xcalculado := TabGlobal_i.DCAMPOST.CALCULADO.Conteudo;
            xautoincremento   := TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo;
            xsempreatribui    := TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo;
            xinvisivel        := TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo;
            xprevalidacao     := TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo;
            xtipoprevalidacao := TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo;
            xlimparcampo      := TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo;
            xmsgerro          := TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo;
            xtabestrangeira   := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            xcampochave       := TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo;
            xcamposvisuais    := TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo;
            xestilochave      := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
            xindiceconsulta   := TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo;
            xtipofisico       := TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo;
            xnomefisico       := TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo;
            xvariaveis.AddStrings(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo);
            xcodificacao.AddStrings(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo);
            herdou := False;
            cancelou := False;
            while (not Herdou) and (not Cancelou) do
            begin
              TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(NrTab) + ' AND UPPER(NOME) = '+#39+UpperCase(xnome)+#39;
              TabGlobal_i.DCAMPOST.AtualizaSql;
              if (TabGlobal_i.DCAMPOST.Eof) and (ValidaNomeCampo(xNome, NrTab)) then
                Herdou := True
              else
              begin
                if (TabGlobal_i.DCAMPOST.Eof) then
                  Cancelou := not InputQuery('Duplicidade !', 'Nome inválido, informe outro nome ...', xnome)
                else
                  Cancelou := not InputQuery('Duplicidade !', 'Nome já existente, informe outro nome ...', xnome);
                xnome := UpperCase(xnome);
              end;
            end;
            if not Cancelou then
            begin
              TabGlobal_i.DCAMPOST.Inclui(Nil);
              TabGlobal_i.DCAMPOST.NUMERO.Conteudo    := NrTab;
              TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Seq;
              TabGlobal_i.DCAMPOST.NOME.Conteudo      := xnome;
              TabGlobal_i.DCAMPOST.TIPO.Conteudo      := xtipo;
              TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := xtamanho;
              TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := xedicao;
              TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := xmascara;
              TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := xtitulo_c;
              TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := xajuda;
              TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := xpadrao;
              TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := xvalidacao;
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString   := xvalidos;
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := xdescricao;
              TabGlobal_i.DCAMPOST.CHAVE.Conteudo     := xchave;
              TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := xcalculado;
              TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo     := xautoincremento;
              TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo     := xsempreatribui;
              TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo          := xinvisivel;
              TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo      := xprevalidacao;
              TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := xtipoprevalidacao;
              TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo       := xlimparcampo;
              TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo           := xmsgerro;
              TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo    := xtabestrangeira;
              TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo        := xcampochave;
              TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo     := xcamposvisuais;
              TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo       := xestilochave;
              TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo    := Seq;
              TabGlobal_i.DCAMPOST.EXTRA.Conteudo              := 0;
              TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo        := xnomefisico;
              TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo        := xtipofisico;
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VARIAVEIS')).AsString := xvariaveis.Text;
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('CODIFICACAO')).AsString := xcodificacao.Text;
              TabGlobal_i.DCAMPOST.Salva;
              Inc(Seq);
              xvariaveis.Free;
              xcodificacao.Free;
            end;
          end;
        end;
      Atualiza_Listas(False, True);
      Tree_Tabelas.Items[Posicao].Selected := True;
      Tree_Tabelas.Items[Posicao].Expand(True);
    end;
  Finally
    FormCamposProj.Free;
    Tree_Tabelas.SetFocus;
  end;
end;

procedure TFormDB_Case.BtnExtrasClick(Sender: TObject);
Var
  I, Seq, Posicao, NrTab: Integer;
  Herdou, Cancelou: Boolean;
  xnome, xmascara, xtitulo_c, xajuda, xpadrao, xvalidacao, xvalidos, xdescricao,
  xprevalidacao, xmsgerro, xtabestrangeira, xcampochave, xcamposvisuais, xtab_extra, xcampoextra: String;
  xtipo, xtamanho, xedicao, xchave, xcalculado, xautoincremento, xinvisivel,
  xtipoprevalidacao, xlimparcampo, xseq, xsempreatribui, xindiceconsulta, xestilochave: integer;
  xvariaveis, xcodificacao: TStringList;
  Sequencia: Variant;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if (Tree_Tabelas.Selected.Level = 2) then
    Posicao := Tree_Tabelas.Selected.Parent.AbsoluteIndex
  else
    Posicao := Tree_Tabelas.Selected.AbsoluteIndex;
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(NrTab);
    TabGlobal_i.DRELACIONA.AtualizaSql;
    FormCamposProj.Ver_Extras := True;
    FormCamposProj.not_Ver_Relacionados := True;
    FormCamposProj.Extras := '';
    while not TabGlobal_i.DRELACIONA.Eof do
    begin
      if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
        FormCamposProj.Extras := FormCamposProj.Extras + TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo+';';
      TabGlobal_i.DRELACIONA.Next;
    end;
    FormCamposProj.Tipo := 1;
    FormCamposProj.Escolha := True;
    if FormCamposProj.ShowModal = mrOk then
    begin
      PTabela(TabGlobal_i.DCAMPOST, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
      if Sequencia[0] = Null then
        Seq := 1
      else
        Seq := Sequencia[0] + 1;
      for I:=0 to FormCamposProj.FieldsLB_S.Items.Count-1 do
        if FormCamposProj.FieldsLB_S.Checked[I] then
        begin
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+FormCamposProj.Retorno+ 'AND SEQUENCIA = '+IntToStr(Integer(FormCamposProj.FieldsLB_S.Items.Objects[I]));
          TabGlobal_i.DCAMPOST.AtualizaSql;
          if (not TabGlobal_i.DCAMPOST.Eof) then
          begin
            xseq       := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
            xnome      := TabGlobal_i.DCAMPOST.NOME.Conteudo;
            xcampoextra:= TabGlobal_i.DCAMPOST.NOME.Conteudo;
            xtipo      := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
            xtamanho   := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
            xedicao    := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
            xmascara   := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
            xtitulo_c  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
            xajuda     := TabGlobal_i.DCAMPOST.AJUDA.Conteudo;
            xpadrao    := TabGlobal_i.DCAMPOST.PADRAO.Conteudo;
            xvalidacao := TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo;
            xvalidos   := TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text;
            xdescricao := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text;
            //xchave     := TabGlobal_i.DCAMPOST.CHAVE.Conteudo;
            xchave := 0;
            xcalculado := TabGlobal_i.DCAMPOST.CALCULADO.Conteudo;
            //xautoincremento   := TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo;
            xautoincremento   := 0;
            xinvisivel        := TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo;
            //xprevalidacao     := TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo;
            xprevalidacao     := '';
            xtipoprevalidacao := TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo;
            //xlimparcampo      := TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo;
            xlimparcampo      := 0;
            xmsgerro          := TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo;
            xtabestrangeira   := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            xcampochave       := TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo;
            xcamposvisuais    := TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo;
            xindiceconsulta   := TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo;
            xestilochave      := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
            xtab_extra        := FormCamposProj.Retorno1;
            xsempreatribui    := 0;

            herdou := False;
            Cancelou := False;
            while (not Herdou) and (not Cancelou) do
            begin
              TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(NrTab) + ' AND UPPER(NOME) = '+#39+UpperCase(xnome)+#39;
              TabGlobal_i.DCAMPOST.AtualizaSql;
              if (TabGlobal_i.DCAMPOST.Eof) and (ValidaNomeCampo(xNome, NrTab)) then
                Herdou := True
              else
              begin
                if (TabGlobal_i.DCAMPOST.Eof) then
                  Cancelou := Not InputQuery('Duplicidade !', 'Nome inválido, informe outro nome ...', xnome)
                else
                  Cancelou := Not InputQuery('Duplicidade !', 'Nome já existente, informe outro nome ...', xnome);
                xnome := UpperCase(xnome);
              end;
            end;
            if not Cancelou then
            begin
              TabGlobal_i.DCAMPOST.Inclui(Nil);
              TabGlobal_i.DCAMPOST.NUMERO.Conteudo    := NrTab;
              TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Seq;
              TabGlobal_i.DCAMPOST.NOME.Conteudo      := xnome;
              TabGlobal_i.DCAMPOST.TIPO.Conteudo      := xtipo;
              TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := xtamanho;
              TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := xedicao;
              TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := xmascara;
              TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := xtitulo_c;
              TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := xajuda;
              TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := '';
              TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := '';
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString   := xvalidos;
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := xdescricao;
              TabGlobal_i.DCAMPOST.CHAVE.Conteudo     := xchave;
              TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := xcalculado;
              TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo     := xautoincremento;
              TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo     := xsempreatribui;
              TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo          := xinvisivel;
              TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo      := xprevalidacao;
              TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := xtipoprevalidacao;
              TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo       := xlimparcampo;
              TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo           := xmsgerro;
              TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo    := xtabestrangeira;
              TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo        := xcampochave;
              TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo     := xcamposvisuais;
              TabGlobal_i.DCAMPOST.EXTRA.Conteudo              := 1;
              TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo          := xtab_extra;
              TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo        := xcampoextra;
              TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo    := Seq;
              TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo       := xestilochave;
              TabGlobal_i.DCAMPOST.Salva;
              Inc(Seq);
            end;
          end;
        end;
      Atualiza_Listas(False, True);
      Tree_Tabelas.Items[Posicao].Selected := True;
      Tree_Tabelas.Items[Posicao].Expand(True);
    end;
  Finally
    FormCamposProj.Free;
    Tree_Tabelas.SetFocus;
  end;
end;

procedure TFormDB_Case.BtnOrdermClick(Sender: TObject);
var
  I, P, Y: Integer;
  Node: TTreeNode;

  function PCampo(S: String): Integer;
  var
    X: Integer;
    Linha: String;
  begin
    PCampo := -1;
    for X:=0 to FormTabOrdem.TabList1.Items.Count-1 do
    begin
      Linha := FormTabOrdem.TabList1.Items[X];
      Linha := Copy(Linha,Pos('-',Linha)+1,Length(Linha));
      Linha := Trim(Copy(Linha,01,Pos('(',Linha)-1));
      if Linha = S then
      begin
        PCampo := X;
        Break;
      end;
    end;
  end;

begin
  Node := Retorna_NodeTab;
  if (Node = Nil) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;

  FormTabOrdem := TFormTabOrdem.Create(Application);
  try
    FormTabOrdem.TabList.Visible := False;
    FormTabOrdem.TabList1.Visible := True;
    FormTabOrdem.TabList1.Clear;
    FormTabOrdem.LbTitulo.Caption := 'Ordem de apresentação dos campos em "Consultas"';
    FormTabOrdem.Caption := 'Apresentação dos Campos';
    FormTabOrdem.TabList1.Sorted := False;
    for I:=4 to Node.Count-1 do
    begin
      TabGlobal_i.DCAMPOST.GotoBookmark(Node.Item[I].Data);
      if TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo < 0 then
        FormTabOrdem.TabList1.Items.Add(StrZero(0,4) + ' - ' +TabGlobal_i.DCAMPOST.NOME.Conteudo + ' ( ' + TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+' )')
      else
        FormTabOrdem.TabList1.Items.Add(StrZero(TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo,4) + ' - ' +TabGlobal_i.DCAMPOST.NOME.Conteudo + ' ( ' + TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+' )');
      if TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo = 0 then
        FormTabOrdem.TabList1.Checked[FormTabOrdem.TabList1.Items.Count-1] := True
      else
        FormTabOrdem.TabList1.Checked[FormTabOrdem.TabList1.Items.Count-1] := False;
    end;
    FormTabOrdem.TabList1.Sorted := True;
    if FormTabOrdem.TabList1.Items.Count > 0 then
      FormTabOrdem.TabList1.ItemIndex := 0;
    if FormTabOrdem.ShowModal = mrOk then
    begin
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Redefinindo índices ...';
      FormAguarde.Show;
      FormAguarde.GaugeProcesso.Min := 0;
      FormAguarde.GaugeProcesso.Max := Node.Count-1;
      FormAguarde.Incrementa(0);
      for I:=0 to Node.Count-1 do
      begin
        TabGlobal_i.DCAMPOST.GotoBookmark(Node.Item[I].Data);
        Y := PCampo(TabGlobal_i.DCAMPOST.NOME.Conteudo);
        if Y > -1 then
        begin
          TabGlobal_i.DCAMPOST.Modifica;
          TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo := Y;
          if FormTabOrdem.TabList1.Checked[Y] then
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo := 0
          else
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo := 1;
          FormAguarde.Incrementa;
          TabGlobal_i.DCAMPOST.Salva;
        end;
      end;
      FormAguarde.Free;
      Tree_TabelasChange(Sender, Tree_Tabelas.Selected);
    end;
  Finally
    FormTabOrdem.Free;
    Tree_Tabelas.SetFocus;
  end;
end;

procedure TFormDB_Case.BtnInserir_IndiceClick(Sender: TObject);
var
  node: TTreeNode;
  Sequencia: Variant;
  Seq: Integer;
  NrTab: Integer;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if Insp_Tabela.ItemIndex > 2 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DINDICEST, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DINDICEST.Inclui(Nil);
  TabGlobal_i.DINDICEST.NUMERO.Conteudo     := NrTab;
  TabGlobal_i.DINDICEST.TITULO_I.Conteudo   := '';
  TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo  := Seq;
  TabGlobal_i.DINDICEST.CRESCENTE.Conteudo  := 1;
  TabGlobal_i.DINDICEST.Salva;

  if Tree_Tabelas.Selected.Level = 0 then
    Node := Tree_Tabelas.Selected.Item[0]
  else if Tree_Tabelas.Selected.Level = 1 then
    Node := Tree_Tabelas.Selected.Parent.Item[0]
  else if Tree_Tabelas.Selected.Level = 2 then
    Node := Tree_Tabelas.Selected.Parent.Parent.Item[0];
  Node := Tree_Tabelas.items.AddChildObject(Node, '', TabGlobal_i.DINDICEST.GetBookmark);
  Node.ImageIndex := 4;
  Node.SelectedIndex := 4;
  Node.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_IntegridadeClick(Sender: TObject);
var
  node: TTreeNode;
  Sequencia: Variant;
  Seq: Integer;
  NrTab: Integer;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if Insp_Tabela.ItemIndex > 2 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DRELACIONA, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DRELACIONA.Inclui(Nil);
  TabGlobal_i.DRELACIONA.NUMERO.Conteudo     := NrTab;
  TabGlobal_i.DRELACIONA.TITULO_I.Conteudo   := '';
  TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo  := Seq;
  TabGlobal_i.DRELACIONA.ATIVO.Conteudo      := 1;
  TabGlobal_i.DRELACIONA.KEY_SQL.Conteudo    := 0;
  TabGlobal_i.DRELACIONA.TIPO.Conteudo       := 1;
  TabGlobal_i.DRELACIONA.Salva;

  if Tree_Tabelas.Selected.Level = 0 then
    Node := Tree_Tabelas.Selected.Item[1]
  else if Tree_Tabelas.Selected.Level = 1 then
    Node := Tree_Tabelas.Selected.Parent.Item[1]
  else if Tree_Tabelas.Selected.Level = 2 then
    Node := Tree_Tabelas.Selected.Parent.Parent.Item[1];
  Node := Tree_Tabelas.items.AddChildObject(Node, '', TabGlobal_i.DRELACIONA.GetBookmark);
  Node.ImageIndex := 5;
  Node.SelectedIndex := 5;
  Node.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_ProcessoClick(Sender: TObject);
var
  node: TTreeNode;
  Sequencia: Variant;
  Seq: Integer;
  NrTab: Integer;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if Insp_Tabela.ItemIndex > 2 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DPROCESSOS, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DPROCESSOS.Inclui(Nil);
  TabGlobal_i.DPROCESSOS.NUMERO.Conteudo     := NrTab;
  TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo   := '';
  TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo  := Seq;
  TabGlobal_i.DPROCESSOS.ATIVO.Conteudo      := 1;
  TabGlobal_i.DPROCESSOS.TIPO.Conteudo       := 1;
  TabGlobal_i.DPROCESSOS.Salva;

  if Tree_Tabelas.Selected.Level = 0 then
    Node := Tree_Tabelas.Selected.Item[2]
  else if Tree_Tabelas.Selected.Level = 1 then
    Node := Tree_Tabelas.Selected.Parent.Item[2]
  else if Tree_Tabelas.Selected.Level = 2 then
    Node := Tree_Tabelas.Selected.Parent.Parent.Item[2];
  Node := Tree_Tabelas.items.AddChildObject(Node, '', TabGlobal_i.DPROCESSOS.GetBookmark);
  Node.ImageIndex := 12;
  Node.SelectedIndex := 12;
  Node.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_ConsultaClick(Sender: TObject);
var
  node, node_pai: TTreeNode;
  Sequencia: Variant;
  Seq: Integer;
begin
  if Lista_Banco.Items.Count = 0 then
  begin
    Mensagem('Nenhum banco de dados foi encontrado!', modAdvertencia, [ModOk]);
    PageControl1.ActivePageIndex := 0;
    PageControl1Change(Self);
    Lista_Banco.SetFocus;
    exit;
  end;

  if Insp_Tabela.ItemIndex > 2 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DCONSULTA, ['First 1 NUMERO'], '', Sequencia, 'NUMERO DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DCONSULTA.Inclui(Nil);
  TabGlobal_i.DCONSULTA.NUMERO.Conteudo    := Seq;
  TabGlobal_i.DCONSULTA.TITULO_I.Conteudo  := '';
  TabGlobal_i.DCONSULTA.NOME.Conteudo      := '';
  TabGlobal_i.DCONSULTA.BASE.Conteudo      := 1;
  TabGlobal_i.DCONSULTA.ATIVO.Conteudo     := 1;
  TabGlobal_i.DCONSULTA.Salva;

  for Seq := 1 to Tree_Tabelas.Items.Count-1 do
    if (Tree_Tabelas.Items[Seq].Level = 0) and (Tree_Tabelas.Items[Seq].Index > 1) then
    begin
      Node_pai := Tree_Tabelas.Items[Seq];
      break;
    end;
  Node := Tree_Tabelas.items.AddChildObject(Node_pai, '', TabGlobal_i.DCONSULTA.GetBookmark);
  Node.ImageIndex := 8;
  Node.SelectedIndex := 8;

  Node_pai.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserir_TriggerClick(Sender: TObject);
var
  node: TTreeNode;
  Sequencia: Variant;
  Seq: Integer;
  NrTab: Integer;
begin
  NrTab := Retorna_NrTab;
  if (NrTab = -999) then
  begin
    Mensagem('Selecione a tabela!', ModInformacao, [modOk]);
    Tree_Tabelas.SetFocus;
    exit;
  end;
  if Insp_Tabela.ItemIndex > 2 then
    Insp_Tabela.ItemIndex := 0;
  PTabela(TabGlobal_i.DTRIGGER, ['First 1 SEQUENCIA'], 'NUMERO = '+IntToStr(NrTab), Sequencia, 'SEQUENCIA DESC');
  if Sequencia[0] = Null then
    Seq := 1
  else
    Seq := Sequencia[0] + 1;
  TabGlobal_i.DTRIGGER.Inclui(Nil);
  TabGlobal_i.DTRIGGER.NUMERO.Conteudo            := NrTab;
  TabGlobal_i.DTRIGGER.NOME.Conteudo              := '';
  TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo         := Seq;
  TabGlobal_i.DTRIGGER.INSTANTE_ATIVACAO.Conteudo := 1;
  TabGlobal_i.DTRIGGER.DISPARAR.Conteudo          := 1;
  TabGlobal_i.DTRIGGER.ATIVO.Conteudo             := 1;
  TabGlobal_i.DTRIGGER.Salva;

  if Tree_Tabelas.Selected.Level = 0 then
    Node := Tree_Tabelas.Selected.Item[3]
  else if Tree_Tabelas.Selected.Level = 1 then
    Node := Tree_Tabelas.Selected.Parent.Item[3]
  else if Tree_Tabelas.Selected.Level = 2 then
    Node := Tree_Tabelas.Selected.Parent.Parent.Item[3];
  Node := Tree_Tabelas.items.AddChildObject(Node, '', TabGlobal_i.DTRIGGER.GetBookmark);
  Node.ImageIndex := 9;
  Node.SelectedIndex := 9;
  Node.Expand(True);
  Node.Selected := True;
  Tree_TabelasChange(Self, Node);
  Insp_Tabela.ItemIndex := 0;
  Insp_Tabela.SetFocus;
end;

procedure TFormDB_Case.BtnInserirClick(Sender: TObject);
begin
  FormTpIns_Tabela := TFormTpIns_Tabela.Create(Application);
  try
    if FormTpIns_Tabela.ShowModal = mrOk then
      Case FormTpIns_Tabela.Tipo of
        01: BtnInserir_StoredClick(Self);
        02: BtnInserir_ScriptClick(Self);
        03: BtnInserir_ConsultaClick(Self);
        04: BtnInserir_DiagramaClick(Self);
        10: BtnInserir_TabClick(Self);
        20: BtnInserir_CmpClick(Self);
        30: BtnInserir_IndiceClick(Self);
        40: BtnInserir_IntegridadeClick(Self);
        50: BtnInserir_ProcessoClick(Self);
        60: BtnInserir_TriggerClick(Self);
      end;
  finally
    FormTpIns_Tabela.Free;
  end;
end;

procedure TFormDB_Case.DataSource_BancoUpdateData(Sender: TObject);
begin
  Modificou := True;
end;

procedure TFormDB_Case.ObjetosAtivos1Click(Sender: TObject);
var
  I: Integer;
  Lista: TStringList;
begin
  FormObjProjeto := TFormObjProjeto.Create(Application);
  try
    if FormObjProjeto.ShowModal = mrOk then
    begin
      Lista := TStringList.Create;

      for I:=0 to FormObjProjeto.Lista_1.Items.Count-1 do
        if FormObjProjeto.Lista_1.Checked[I] then
          Lista.Add('ST;' + IntToStr(Integer(FormObjProjeto.Lista_1.Items.Objects[I])) + ';1')
        else
          Lista.Add('ST;' + IntToStr(Integer(FormObjProjeto.Lista_1.Items.Objects[I])) + ';0');

      for I:=0 to FormObjProjeto.Lista_2.Items.Count-1 do
        if FormObjProjeto.Lista_2.Checked[I] then
          Lista.Add('SC;' + IntToStr(Integer(FormObjProjeto.Lista_2.Items.Objects[I])) + ';1')
        else
          Lista.Add('SC;' + IntToStr(Integer(FormObjProjeto.Lista_2.Items.Objects[I])) + ';0');

      for I:=0 to FormObjProjeto.Lista_3.Items.Count-1 do
        if FormObjProjeto.Lista_3.Checked[I] then
          Lista.Add('CS;' + IntToStr(Integer(FormObjProjeto.Lista_3.Items.Objects[I])) + ';1')
        else
          Lista.Add('CS;' + IntToStr(Integer(FormObjProjeto.Lista_3.Items.Objects[I])) + ';0');

      for I:=0 to FormObjProjeto.Lista_4.Items.Count-1 do
        if FormObjProjeto.Lista_4.Checked[I] then
          Lista.Add('TB;' + IntToStr(Integer(FormObjProjeto.Lista_4.Items.Objects[I])) + ';1')
        else
          Lista.Add('TB;' + IntToStr(Integer(FormObjProjeto.Lista_4.Items.Objects[I])) + ';0');

      TabGlobal_i.DPROJETO.Modifica;
      TBlobField(TabGlobal_i.DPROJETO.FieldByName('TABELAS_UTILIZADAS')).AsString := Lista.Text;
      if FormObjProjeto.Habilitado.Checked then
        TabGlobal_i.DPROJETO.OBJETOS_PROJETO.Conteudo := 1
      else
        TabGlobal_i.DPROJETO.OBJETOS_PROJETO.Conteudo := 0;
      TabGlobal_i.DPROJETO.Salva;
      Lista.Free;
      Modificou := True;
    end;
  finally
    FormObjProjeto.Free;
  end;
end;

end.
