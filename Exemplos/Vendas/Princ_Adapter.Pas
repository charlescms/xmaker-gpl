{
   Programa.: Princ_Adapter.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Princ_Adapter;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ImgList, ToolWin, ExtCtrls, {$I LTab.pas} Menus, DB, StdCtrls,
  Buttons, Grids, DBCtrls, DBGrids, ComObj, DBTables;

type
  TFormAdapter = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    ControlBarMenu: TControlBar;
    ToolBarArquivo: TToolBar;
    BtnEmpresa: TToolButton;
    BtnEditar: TToolButton;
    BtnExportar: TToolButton;
    PageControl: TPageControl;
    TabPrincipal: TTabSheet;
    TabCompl_1: TTabSheet;
    TabCompl_2: TTabSheet;
    PnEstrutura_1: TPanel;
    Estruturas_1: TTreeView;
    Panel2: TPanel;
    Splitter1: TSplitter;
    PnEstrutura_2: TPanel;
    Estruturas_2: TTreeView;
    Panel4: TPanel;
    TabCompl_3: TTabSheet;
    Estruturas: TMenuItem;
    Atualizar: TMenuItem;
    Consultar: TMenuItem;
    Importar: TMenuItem;
    N1: TMenuItem;
    Sair: TMenuItem;
    ListaImagens: TImageList;
    Panel1: TPanel;
    Panel3: TPanel;
    BtnCancelar: TBitBtn;
    Panel5: TPanel;
    LbMensagem: TLabel;
    Panel6: TPanel;
    BtnAtualizar: TBitBtn;
    BtnCancelar2: TBitBtn;
    PnPreenchimento: TPanel;
    PnTabela: TPanel;
    TabConversao: TStringGrid;
    BtnProxima: TBitBtn;
    BtnAnterior: TBitBtn;
    PnInfo: TPanel;
    Panel7: TPanel;
    ListaTabAt: TListBox;
    Instrucoes: TMemo;
    Bevel1: TBevel;
    Image1: TImage;
    Label1: TLabel;
    SelecionarEmpresa: TMenuItem;
    N2: TMenuItem;
    BtnReiniciar: TBitBtn;
    DataSource: TDataSource;
    Panel8: TPanel;
    Panel9: TPanel;
    BtnCancela3: TBitBtn;
    Grid_Consulta: TDBGrid;
    ListaTabelas: TListBox;
    DBNavigator1: TDBNavigator;
    BtnAbrir: TSpeedButton;
    Editar1: TMenuItem;
    Exportar: TMenuItem;
    PnImportacao: TPanel;
    Panel11: TPanel;
    TabConversao2: TStringGrid;
    Panel12: TPanel;
    Panel13: TPanel;
    BtnImportar: TBitBtn;
    BtnCancela4: TBitBtn;
    ListaTabelas2: TListBox;
    TabOrigem: TTable;
    EdOrigem: TEdit;
    Label3: TLabel;
    BtnLocalizar: TSpeedButton;
    OpenDialog: TOpenDialog;
    BtnVincular: TSpeedButton;
    Preservar: TCheckBox;
    Panel10: TPanel;
    EdLocalizar: TComboBox;
    Label4: TLabel;
    Processo: TProgressBar;
    procedure EstruturasClick(Sender: TObject);
    procedure AtualizarClick(Sender: TObject);
    procedure ConsultarClick(Sender: TObject);
    procedure ImportarClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximaClick(Sender: TObject);
    procedure TabConversaoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabConversaoDblClick(Sender: TObject);
    procedure BtnCancelar2Click(Sender: TObject);
    procedure SelecionarEmpresaClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure BtnAbrirClick(Sender: TObject);
    procedure BtnExportarClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnVincularClick(Sender: TObject);
    procedure BtnReiniciarClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
    procedure TabConversao2DblClick(Sender: TObject);
    procedure TabConversao2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdLocalizarClick(Sender: TObject);
  private
    { Private declarations }
    Posicao: Integer;
    ListaCampos: TStringList;
    procedure CarregarDados;
    procedure Dados_TabConversao(Sequencia: Integer);
    function Tipo_Campo(Campo: TField): String;
  public
    { Public declarations }
    {01-Início do Bloco Modular. Modificações não serão preservadas}
    DClientes : TDClientes;
    DAtividades : TDAtividades;
    DFornecedores : TDFornecedores;
    DProdutos : TDProdutos;
    DFornecedores_2 : TDFornecedores_2;
    DVendas : TDVendas;
    DItens_Venda : TDItens_Venda;
    DConsulta_Itens_Venda : TDConsulta_Itens_Venda;
    DUSER_NOMES : TDUSER_NOMES;
    DUSER_GRUPOS : TDUSER_GRUPOS;
    DUSER_MENU_LATERAL : TDUSER_MENU_LATERAL;
    DUSER_MENU_SUPERIOR : TDUSER_MENU_SUPERIOR;
    DUSER_BARRA_F : TDUSER_BARRA_F;
    DUSER_TABELAS : TDUSER_TABELAS;
    DUSER_LOG : TDUSER_LOG;
    DUSER_AGENDA : TDUSER_AGENDA;
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    procedure Iniciar;
  end;

var
  FormAdapter: TFormAdapter;

implementation

{$R *.DFM}

uses Rotinas, Publicas, Acesso, BaseD, Aguarde, Campo_Adapter, Tabela,
  Emp_Adapter, Atributo, RotinaEd;

procedure TFormAdapter.FormShow(Sender: TObject);
var
  I: Integer;
begin
  PageControl.ActivePageIndex := 0;
  ListaCampos := TStringList.Create;
  {02-Início do Bloco Modular. Modificações não serão preservadas}
  DClientes := TDClientes.Create(Self);
  DClientes.AfterInsert  := Nil;
  DClientes.AfterPost    := Nil;
  DClientes.AfterCancel  := Nil;
  DClientes.BeforePost   := Nil;
  DClientes.BeforeEdit   := Nil;
  DClientes.BeforeDelete := Nil;
  DAtividades := TDAtividades.Create(Self);
  DAtividades.AfterInsert  := Nil;
  DAtividades.AfterPost    := Nil;
  DAtividades.AfterCancel  := Nil;
  DAtividades.BeforePost   := Nil;
  DAtividades.BeforeEdit   := Nil;
  DAtividades.BeforeDelete := Nil;
  DFornecedores := TDFornecedores.Create(Self);
  DFornecedores.AfterInsert  := Nil;
  DFornecedores.AfterPost    := Nil;
  DFornecedores.AfterCancel  := Nil;
  DFornecedores.BeforePost   := Nil;
  DFornecedores.BeforeEdit   := Nil;
  DFornecedores.BeforeDelete := Nil;
  DProdutos := TDProdutos.Create(Self);
  DProdutos.AfterInsert  := Nil;
  DProdutos.AfterPost    := Nil;
  DProdutos.AfterCancel  := Nil;
  DProdutos.BeforePost   := Nil;
  DProdutos.BeforeEdit   := Nil;
  DProdutos.BeforeDelete := Nil;
  DFornecedores_2 := TDFornecedores_2.Create(Self);
  DFornecedores_2.AfterInsert  := Nil;
  DFornecedores_2.AfterPost    := Nil;
  DFornecedores_2.AfterCancel  := Nil;
  DFornecedores_2.BeforePost   := Nil;
  DFornecedores_2.BeforeEdit   := Nil;
  DFornecedores_2.BeforeDelete := Nil;
  DVendas := TDVendas.Create(Self);
  DVendas.AfterInsert  := Nil;
  DVendas.AfterPost    := Nil;
  DVendas.AfterCancel  := Nil;
  DVendas.BeforePost   := Nil;
  DVendas.BeforeEdit   := Nil;
  DVendas.BeforeDelete := Nil;
  DItens_Venda := TDItens_Venda.Create(Self);
  DItens_Venda.AfterInsert  := Nil;
  DItens_Venda.AfterPost    := Nil;
  DItens_Venda.AfterCancel  := Nil;
  DItens_Venda.BeforePost   := Nil;
  DItens_Venda.BeforeEdit   := Nil;
  DItens_Venda.BeforeDelete := Nil;
  DConsulta_Itens_Venda := TDConsulta_Itens_Venda.Create(Self);
  DConsulta_Itens_Venda.AfterInsert  := Nil;
  DConsulta_Itens_Venda.AfterPost    := Nil;
  DConsulta_Itens_Venda.AfterCancel  := Nil;
  DConsulta_Itens_Venda.BeforePost   := Nil;
  DConsulta_Itens_Venda.BeforeEdit   := Nil;
  DConsulta_Itens_Venda.BeforeDelete := Nil;
  DUSER_NOMES := TDUSER_NOMES.Create(Self);
  DUSER_NOMES.AfterInsert  := Nil;
  DUSER_NOMES.AfterPost    := Nil;
  DUSER_NOMES.AfterCancel  := Nil;
  DUSER_NOMES.BeforePost   := Nil;
  DUSER_NOMES.BeforeEdit   := Nil;
  DUSER_NOMES.BeforeDelete := Nil;
  DUSER_GRUPOS := TDUSER_GRUPOS.Create(Self);
  DUSER_GRUPOS.AfterInsert  := Nil;
  DUSER_GRUPOS.AfterPost    := Nil;
  DUSER_GRUPOS.AfterCancel  := Nil;
  DUSER_GRUPOS.BeforePost   := Nil;
  DUSER_GRUPOS.BeforeEdit   := Nil;
  DUSER_GRUPOS.BeforeDelete := Nil;
  DUSER_MENU_LATERAL := TDUSER_MENU_LATERAL.Create(Self);
  DUSER_MENU_LATERAL.AfterInsert  := Nil;
  DUSER_MENU_LATERAL.AfterPost    := Nil;
  DUSER_MENU_LATERAL.AfterCancel  := Nil;
  DUSER_MENU_LATERAL.BeforePost   := Nil;
  DUSER_MENU_LATERAL.BeforeEdit   := Nil;
  DUSER_MENU_LATERAL.BeforeDelete := Nil;
  DUSER_MENU_SUPERIOR := TDUSER_MENU_SUPERIOR.Create(Self);
  DUSER_MENU_SUPERIOR.AfterInsert  := Nil;
  DUSER_MENU_SUPERIOR.AfterPost    := Nil;
  DUSER_MENU_SUPERIOR.AfterCancel  := Nil;
  DUSER_MENU_SUPERIOR.BeforePost   := Nil;
  DUSER_MENU_SUPERIOR.BeforeEdit   := Nil;
  DUSER_MENU_SUPERIOR.BeforeDelete := Nil;
  DUSER_BARRA_F := TDUSER_BARRA_F.Create(Self);
  DUSER_BARRA_F.AfterInsert  := Nil;
  DUSER_BARRA_F.AfterPost    := Nil;
  DUSER_BARRA_F.AfterCancel  := Nil;
  DUSER_BARRA_F.BeforePost   := Nil;
  DUSER_BARRA_F.BeforeEdit   := Nil;
  DUSER_BARRA_F.BeforeDelete := Nil;
  DUSER_TABELAS := TDUSER_TABELAS.Create(Self);
  DUSER_TABELAS.AfterInsert  := Nil;
  DUSER_TABELAS.AfterPost    := Nil;
  DUSER_TABELAS.AfterCancel  := Nil;
  DUSER_TABELAS.BeforePost   := Nil;
  DUSER_TABELAS.BeforeEdit   := Nil;
  DUSER_TABELAS.BeforeDelete := Nil;
  DUSER_LOG := TDUSER_LOG.Create(Self);
  DUSER_LOG.AfterInsert  := Nil;
  DUSER_LOG.AfterPost    := Nil;
  DUSER_LOG.AfterCancel  := Nil;
  DUSER_LOG.BeforePost   := Nil;
  DUSER_LOG.BeforeEdit   := Nil;
  DUSER_LOG.BeforeDelete := Nil;
  DUSER_AGENDA := TDUSER_AGENDA.Create(Self);
  DUSER_AGENDA.AfterInsert  := Nil;
  DUSER_AGENDA.AfterPost    := Nil;
  DUSER_AGENDA.AfterCancel  := Nil;
  DUSER_AGENDA.BeforePost   := Nil;
  DUSER_AGENDA.BeforeEdit   := Nil;
  DUSER_AGENDA.BeforeDelete := Nil;
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  EdLocalizar.Items.Clear;
  for I:=0 to Lst_Tabelas.Count-1 do
    EdLocalizar.Items.Add(TTabela(Lst_Tabelas[I]).NomeTabela + ' - ' + TTabela(Lst_Tabelas[I]).Titulo);
  Iniciar;
  PageControlChange(Self);
end;

procedure TFormAdapter.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I: Integer;
  Tabela: TTabela;
begin
  ListaCampos.Free;
  for I := (Lst_Tabelas.Count - 1) downto 0 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if Tabela.Owner = Self then
    begin
      if Tabela.Active then
      begin
        {$IFDEF ZEOSLIB}
        Tabela.ApplyUpdates;
        Tabela.CommitUpdates;
        {$ENDIF}
        Tabela.Close;
      end;
      Tabela.Free;
    end;
  end;
  if (Lst_Tabelas.Count = 0) then
  begin
    Lst_Tabelas.Free;
    Lst_Tabelas := nil;
  end;
end;

procedure TFormAdapter.Iniciar;
var
  I: Integer;
  Tabela: TTabela;
begin
  ListaTabelas.Items.Clear;
  ListaTabelas2.Items.Clear;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if I = 0 then
      Tabela.Existe;
    if (Tabela.Owner = Self) and (not Tabela.Existe) then
      Tabela.CriaTabela;
    ListaTabelas.Items.Add(Tabela.NomeTabela + ' - ' + Tabela.Titulo);
    ListaTabelas2.Items.Add(Tabela.NomeTabela + ' - ' + Tabela.Titulo);
  end;
  Inicializa;
  CarregarDados;
  Posicao := -1;
  Dados_TabConversao(1);
end;

function TFormAdapter.Tipo_Campo(Campo: TField): String;
var
  Tipo: String;
begin
  case Campo.DataType of
    ftString, ftFixedChar: Tipo := 'alfanumérico';
    ftBoolean: Tipo := 'lógico';
    ftSmallint, ftWord, ftInteger, ftLargeInt: Tipo := 'número';
    ftFloat, ftCurrency, ftBCD: Tipo := 'fracionário';
    ftTime: Tipo := 'hora';
    ftDate, ftDateTime: Tipo := 'data';
    ftBlob, ftMemo: Tipo := 'memo';
    ftBytes, ftVarBytes, ftGraphic..ftTypedBinary: Tipo := 'imagem'
  else
    Tipo := 'indefinido';
  end;
  Tipo_Campo := Tipo;
end;

procedure TFormAdapter.CarregarDados;
var
  I,Y,T: Integer;
  Tabela, Tabela_e: TTabela;
  Node1, Node2: TTreeNode;
  Imagem: Integer;
  Campo: TAtributo;

  function CampoChave(Campo, Chave, NomeTabela: String): Boolean;
  var
    ListaCh: TStringList;
  begin
    Campo := UpperCase(Campo);
    Chave := UpperCase(Chave);
    ListaCh := TStringList.Create;
    StringToArray(Chave,',',ListaCh);
    CampoChave := False;
    if ListaCh.IndexOf(NomeTabela+'.'+Campo) > -1 then
      CampoChave := True;
    ListaCh.Free;
  end;

  procedure Insere_Item(Lista: TTreeView; Tabela: TTabela);
  var
    Y: Integer;
  begin
    Node1 := Lista.Items.AddChild(Nil, Tabela.NomeTabela);
    Node1.Selected := True;
    Lista.Selected.ImageIndex    := Imagem;
    Lista.Selected.SelectedIndex := Imagem;
    if Tabela.Campos.Count > 0 then
      for Y := 0 to Tabela.Campos.Count -1 do
      begin
        Campo := TAtributo(Tabela.Campos[Y]);
        Node2 := Lista.Items.AddChild(Node1, Campo.Nome + ' (' +Tipo_Campo(Campo.Valor)+', '+IntToStr(Campo.Valor.Size)+')');
        Node2.Selected := True;
        if Tabela.ChavePrimaria.IndexOf(Tabela.Campos[Y]) > -1 then
        begin
          Lista.Selected.ImageIndex    := 2;
          Lista.Selected.SelectedIndex := 2;
        end
        else
        begin
          Lista.Selected.ImageIndex    := 1;
          Lista.Selected.SelectedIndex := 1;
        end;
      end
    else
      for Y := 0 to Tabela.FieldCount -1 do
      begin
        Node2 := Lista.Items.AddChild(Node1, Tabela.Fields[Y].FieldName + ' (' +Tipo_Campo(Tabela.Fields[Y])+', '+IntToStr(Tabela.Fields[Y].Size)+')');
        Node2.Selected := True;
        if (CampoChave(Tabela.Fields[Y].FieldName,Tabela.ChPrimaria,Tabela.NomeTabela)) or
           (Tabela.Fields[Y].Required) then
        begin
          Lista.Selected.ImageIndex    := 2;
          Lista.Selected.SelectedIndex := 2;
        end
        else
        begin
          Lista.Selected.ImageIndex    := 1;
          Lista.Selected.SelectedIndex := 1;
        end;
      end;
  end;

begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde!, Inicializando Sistema...';
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := BaseDados.ListaNomeTabelas.Count;
  FormAguarde.Show;

  Estruturas_1.Items.Clear;
  Estruturas_2.Items.Clear;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    Tabela_e := TTabela.Create(Self);
    with Tabela_e do
    begin
      NomeTabela  := Tabela.NomeTabela;
      DataBase    := Tabela.DataBase;
      DatabaseName := Tabela.DatabaseName;
      Transaction := Tabela.Transaction;
      Sql.Text    := 'Select * From '+Tabela.NomeTabela;
      Conexao;
      Abrir;
    end;

    Imagem := 0;
    Insere_Item(Estruturas_1,Tabela);

    for Y := 0 to Tabela.Campos.Count-1 do
    begin
      Campo := TAtributo(Tabela.Campos[Y]);
      if (not Campo.Calculado) and
         (not Campo.Extra) then
      begin
        if Tabela_e.Fields.FindField(Campo.Nome) = Nil then  // Verifica se o campo existe
          Imagem := 3
        else
          if Tipo_Campo(Tabela_e.Fields.FindField(Campo.Nome)) <> Tipo_Campo(Campo.Valor) then
            Imagem := 3;
      end;
    end;

    Insere_Item(Estruturas_2,Tabela_e);

    Tabela_e.Close;
    Tabela_e.Free;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  end;
  if Estruturas_1.Items.Count > 0 then
    Estruturas_1.Items[0].Selected := True;
  if Estruturas_2.Items.Count > 0 then
    Estruturas_2.Items[0].Selected := True;

  FormAguarde.Free;
end;

procedure TFormAdapter.Dados_TabConversao(Sequencia: Integer);
var
  Tabela, Tabela_e: TTabela;
  I,Y,QtCalc: Integer;
  Tipo1,Tipo2: String;
  Campo: TAtributo;
begin
  inc(Posicao, Sequencia);
  if Posicao > Lst_Tabelas.Count-1 then
    Posicao := 0;

  Tabela := TTabela(Lst_Tabelas[Posicao]);
  PnTabela.Caption := 'Tabela ( '+IntToStr(Posicao+1)+'/'+IntToStr(Lst_Tabelas.Count)+' ): '+Tabela.NomeTabela + ' - ' + Tabela.Titulo;
  Tabela_e := TTabela.Create(Self);
  with Tabela_e do
  begin
    NomeTabela  := Tabela.NomeTabela;
    DataBase    := Tabela.DataBase;
    Transaction := Tabela.Transaction;
    DatabaseName := Tabela.DatabaseName;
    Sql.Text    := 'Select * From '+Tabela.NomeTabela;
    Conexao;
    Abrir;
  end;
  ListaCampos.Clear;
  for I := 0 to Tabela_e.FieldCount -1 do
    ListaCampos.Add(Tabela_e.Fields[I].FieldName + '  ('+Tipo_Campo(Tabela_e.Fields[I])+', '+IntToStr(Tabela_e.Fields[I].size)+' )');
  with TabConversao do
  begin
    ColCount := 2;
    RowCount := Tabela.FieldCount + 1;
    FixedRows := 1;
    Cells[0,0] := 'Campo';
    Cells[1,0] := 'Preencher com';
    QtCalc := 0;
    Y := -1;
    for I := 0 to Tabela.Campos.Count -1 do
    begin
      Campo := TAtributo(Tabela.Campos[I]);
      if (not Campo.Calculado) and
         (not Campo.Extra) then
      begin
        inc(Y);
        Cells[0,Y+1] := Campo.Valor.FieldName + '  ( '+Tipo_Campo(Campo.Valor)+', '+IntToStr(Campo.Valor.Size)+' )';
        if Tabela_e.FieldList.IndexOf(Campo.Valor.FieldName) >= 0 then
        begin
          Tipo1 := Tipo_Campo(Campo.Valor);
          Tipo2 := Tipo_Campo(Tabela_e.FieldByName(Campo.Valor.FieldName));
          if (Tipo1 = 'alfanumérico') and
             ((Tipo2 = 'número') or (Tipo2 = 'fracionário')) then
            Cells[1,Y+1] := 'Cast('+Campo.Valor.FieldName+' AS NUMERIC)'
          else if ((Tipo1 = 'número') or (Tipo1 = 'fracionário')) and
             (Tipo2 = 'alfanumérico') then
            Cells[1,Y+1] := 'Cast('+Campo.Valor.FieldName+' AS CHARACTER)'
          else if (Tipo1 = 'data') and
             (Tipo2 = 'alfanumérico') then
            Cells[1,Y+1] := 'Cast('+Campo.Valor.FieldName+' AS CHARACTER)'
          else if (Tipo1 = 'alfanumérico') and
             (Tipo2 = 'data') then
            Cells[1,Y+1] := 'Cast('+Campo.Valor.FieldName+' AS DATE)'
          else
            Cells[1,Y+1] := Campo.Valor.FieldName;
        end
        else
          Cells[1,Y+1] := '';
      end
      else
        Inc(QtCalc);
    end;
    RowCount := RowCount - QtCalc;
  end;
  Tabela_e.Close;
  Tabela_e.Free;
  if Posicao + 1 > Lst_Tabelas.Count-1 then
    BtnProxima.Enabled := False
  else
    BtnProxima.Enabled := True;
  if Posicao = 0 then
    BtnAnterior.Enabled := False
  else
    BtnAnterior.Enabled := True;

  if PageControl.ActivePageIndex = 1 then
    TabConversao.SetFocus;
end;

procedure TFormAdapter.BtnAtualizarClick(Sender: TObject);
var
  I: Integer;
  Tabela: TTabela;
  Nome: String;
  Query: TTabela;
begin
  if MessageDlg('Atualizar Tabela ?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;

  if not Preservar.Checked then
    if MessageDlg('Os registros não serão preservados'+^M+^M'Continuar ?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      exit;

  Screen.Cursor := crHourGlass;

  Tabela := TTabela(Lst_Tabelas[Posicao]);

  LbMensagem.Visible := True;
  LbMensagem.Caption := 'Criando a Tabela Temporária: ' + Tabela.NomeTabela + '_TEMP_';
  Application.ProcessMessages;

  Tabela.Close;

  {$IFDEF IBX}
  if Tabela.Transaction.Active then
    Tabela.Transaction.CommitRetaining;
  {$ENDIF}
  Nome := Tabela.NomeTabela;
  Tabela.NomeTabela := Nome + '_TEMP_';
  if Tabela.Existe then                  // verifica se tabela temporária existe
    Tabela.DeletaTabela;                 // se existir, então excluimos
  Tabela.NomeTabela := Nome;

  Query := TTabela.Create(Self);         // Cria a tabela temporária com a nova estrutura
  with Query do
  begin
    DataBase := Tabela.DataBase;
    Transaction := Tabela.Transaction;
    DatabaseName := Tabela.DatabaseName;
    {$IFDEF XSQL}
    DataBase.StartTransaction;
    {$ENDIF}
    QueryExtra.Sql.Clear;
    QueryExtra.Sql.Add('Create Table');
    QueryExtra.Sql.Add(Tabela.NomeTabela + '_Temp_');
    QueryExtra.Sql.Add('(');
    Tabela.DefineCampos;
    QueryExtra.Sql.Add(Tabela.InitFieldsList);
    QueryExtra.Sql.Add(')');
    ConexaoQueryExtra;
    QueryExtra.ExecSql;
  end;
  {$IFDEF IBX}
  if Query.Transaction.Active then
    Query.Transaction.CommitRetaining;
  {$ELSE}
  Query.DataBase.Commit;
  {$ENDIF}
  Query.Close;

  LbMensagem.Caption := 'Transferindo registros ...';
  Application.ProcessMessages;

  if Preservar.Checked then
  begin
    with Query do                          // Copia todos os registros para tabela temporária
    begin
      QueryExtra.Sql.Clear;
      QueryExtra.SQL.Add('INSERT INTO '+Nome + '_TEMP_ (');
      for I:=1 to TabConversao.RowCount-1 do
        if Trim(TabConversao.Cells[1,I]) <> '' then
          QueryExtra.SQL.Add(Copy(TabConversao.Cells[0,I],01,Pos('(',TabConversao.Cells[0,I])-1) + ',') ;
      QueryExtra.SQL[QueryExtra.SQL.Count-1] := Copy(QueryExtra.SQL[QueryExtra.SQL.Count-1],01,Length(QueryExtra.SQL[QueryExtra.SQL.Count-1])-1);
      QueryExtra.SQL.Add(')');
      QueryExtra.SQL.Add('Select');
      for I:=1 to TabConversao.RowCount-1 do
        if Trim(TabConversao.Cells[1,I]) <> '' then
          QueryExtra.SQL.Add(TabConversao.Cells[1,I] + ',');
      QueryExtra.SQL[QueryExtra.SQL.Count-1] := Copy(QueryExtra.SQL[QueryExtra.SQL.Count-1],01,Length(QueryExtra.SQL[QueryExtra.SQL.Count-1])-1);
      QueryExtra.SQL.Add('From '+Nome);
      ConexaoQueryExtra;
      QueryExtra.ExecSql;
    end;
    {$IFDEF IBX}
    if Query.Transaction.Active then
      Query.Transaction.CommitRetaining;
    {$ENDIF}
    Query.Close;
  end;

  LbMensagem.Caption := 'Criando a Tabela: ' + Tabela.NomeTabela;
  Application.ProcessMessages;
  Tabela.CriaTabela;                     // Recria a tabela original

  LbMensagem.Caption := 'Transferindo registros ...';
  Application.ProcessMessages;

  if Preservar.Checked then
  begin
    with Query do                          // Copia todos os dados da tabela temporária para original
    begin
      QueryExtra.Sql.Clear;
      QueryExtra.SQL.Add('INSERT INTO '+Nome + ' (');
      for I:=1 to TabConversao.RowCount-1 do
        if Trim(TabConversao.Cells[1,I]) <> '' then
          QueryExtra.SQL.Add(Copy(TabConversao.Cells[0,I],01,Pos('(',TabConversao.Cells[0,I])-1) + ',');
      QueryExtra.SQL[QueryExtra.SQL.Count-1] := Copy(QueryExtra.SQL[QueryExtra.SQL.Count-1],01,Length(QueryExtra.SQL[QueryExtra.SQL.Count-1])-1);
      QueryExtra.SQL.Add(')');
      QueryExtra.SQL.Add('Select');
      for I:=1 to TabConversao.RowCount-1 do
        if Trim(TabConversao.Cells[1,I]) <> '' then
          QueryExtra.SQL.Add(Copy(TabConversao.Cells[0,I],01,Pos('(',TabConversao.Cells[0,I])-1) + ',');
      QueryExtra.SQL[QueryExtra.SQL.Count-1] := Copy(QueryExtra.SQL[QueryExtra.SQL.Count-1],01,Length(QueryExtra.SQL[QueryExtra.SQL.Count-1])-1);
      QueryExtra.SQL.Add('From '+Nome + '_TEMP_');
      ConexaoQueryExtra;
      QueryExtra.ExecSql;
    end;
    Query.Close;
  end;

  LbMensagem.Caption := 'Excluindo Tabela Temporária: ' + Tabela.NomeTabela + '_TEMP_';
  Application.ProcessMessages;
  Tabela.NomeTabela := Nome + '_TEMP_';  // Exclui a tabela temporária
  Tabela.DeletaTabela;
  Tabela.NomeTabela := Nome;

  Query.Free;

  ListaTabAt.Items.Add(Tabela.NomeTabela + ' - ' +Tabela.Titulo);

  LbMensagem.Visible := False;
  Screen.Cursor := crDefault;
  Preservar.Checked := True;
  Dados_TabConversao(1);
end;

procedure TFormAdapter.BtnCancelar2Click(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(Self);
end;

procedure TFormAdapter.BtnReiniciarClick(Sender: TObject);
begin
  Iniciar;
end;

procedure TFormAdapter.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAdapter.BtnAnteriorClick(Sender: TObject);
begin
  Dados_TabConversao(-1);
end;

procedure TFormAdapter.BtnProximaClick(Sender: TObject);
begin
  Dados_TabConversao(1);
end;

procedure TFormAdapter.TabConversaoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 113 then { F2 }
    TabConversaoDblClick(Self);
end;

procedure TFormAdapter.TabConversao2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 113 then { F2 }
    TabConversao2DblClick(Self);
end;

procedure TFormAdapter.TabConversaoDblClick(Sender: TObject);
begin
  FormCampo_Adapter := TFormCampo_Adapter.Create(Application);
  Try
    FormCampo_Adapter.ListaCampos.Items.AddStrings(ListaCampos);
    FormCampo_Adapter.EdCampo.Text := TabConversao.Cells[0,TabConversao.Row];
    FormCampo_Adapter.EdExpressao.Text := TabConversao.Cells[1,TabConversao.Row];
    FormCampo_Adapter.Tipo := 0;
    FormCampo_Adapter.ShowModal;
  Finally
    FormCampo_Adapter.Free;
  end;
end;

procedure TFormAdapter.SelecionarEmpresaClick(Sender: TObject);
begin
  FormEmpresa_Adapter := TFormEmpresa_Adapter.Create(Application);
  Try
    FormEmpresa_Adapter.ShowModal;
  Finally
    FormEmpresa_Adapter.Free;
  end;
end;

procedure TFormAdapter.EstruturasClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(Self);
end;

procedure TFormAdapter.AtualizarClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 1;
  PageControlChange(Self);
end;

procedure TFormAdapter.ConsultarClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 2;
  PageControlChange(Self);
end;

procedure TFormAdapter.ImportarClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 3;
  PageControlChange(Self);
end;

procedure TFormAdapter.SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAdapter.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1 then
    BtnEditar.Enabled := True
  else
    BtnEditar.Enabled := False;
  if DataSource.DataSet <> Nil then
    if (DataSource.DataSet.Active) and (PageControl.ActivePageIndex = 2) then
      BtnExportar.Enabled := True
    else
      BtnExportar.Enabled := False;
  Exportar.Enabled := BtnExportar.Enabled;
end;

procedure TFormAdapter.BtnAbrirClick(Sender: TObject);
var
  Tabela: TTabela;
begin
  if ListaTabelas.ItemIndex < 0 then
  begin
    MessageDlg('Selecione uma tabela ...', mtInformation, [MbOk], 0);
    ListaTabelas.ItemIndex;
    exit;
  end;
  Tabela := TTabela(Lst_Tabelas[ListaTabelas.ItemIndex]);
  Tabela.Abrir;
  BtnExportar.Enabled := True;
  Exportar.Enabled := True;
  DataSource.DataSet := Tabela;
  Grid_Consulta.SetFocus;
end;

procedure TFormAdapter.BtnExportarClick(Sender: TObject);
var
  coluna, linha: integer;
  excel: variant;
  valor: string;
  Tabela: TTabela;
begin
  if DataSource.DataSet = Nil then
    exit;
  if MessageDlg('Exportar registros para o Excel ?',mtConfirmation, [MbYes,mbNo],0) <> mrYes then
    exit;
  Tabela := TTabela(Lst_Tabelas[ListaTabelas.ItemIndex]);
  try
    excel:=CreateOleObject('Excel.Application');
    excel.Workbooks.add(1);
  except
    Application.MessageBox ('Versão do Ms-Excel'+ 'Incompatível','Erro',MB_OK+MB_ICONEXCLAMATION);
  end;
  Tabela.First;
  try
    Linha := 0;
    Tabela.DisableControls;
    Screen.Cursor := crHourGlass;
    while not Tabela.Eof do
    begin
      for coluna:=1 to Tabela.FieldCount do
      begin
        valor := Tabela.Fields[coluna-1].AsString;
        excel.cells[linha+2,coluna] := valor;
      end;
      inc(Linha);
      Tabela.Next;
    end;
    Tabela.EnableControls;
    Screen.Cursor := crDefault;
    for coluna:=1 to Tabela.FieldCount do
    begin
      valor := Tabela.Fields[coluna-1].DisplayLabel;
      excel.cells[1,coluna] := valor;
    end;
    excel.columns.AutoFit;
    excel.visible:=true;
  except
    Application.MessageBox ('Erro de Conversão !!!','Erro',MB_OK+MB_ICONEXCLAMATION);
  end;
end;

procedure TFormAdapter.BtnLocalizarClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    EdOrigem.Text := OpenDialog.FileName;
end;

procedure TFormAdapter.TabConversao2DblClick(Sender: TObject);
begin
  FormCampo_Adapter := TFormCampo_Adapter.Create(Application);
  Try
    FormCampo_Adapter.ListaCampos.Items.AddStrings(ListaCampos);
    FormCampo_Adapter.EdCampo.Text := TabConversao2.Cells[0,TabConversao2.Row];
    FormCampo_Adapter.EdExpressao.Text := TabConversao2.Cells[1,TabConversao2.Row];
    FormCampo_Adapter.Tipo := 1;
    FormCampo_Adapter.ShowModal;
  Finally
    FormCampo_Adapter.Free;
  end;
end;

procedure TFormAdapter.BtnVincularClick(Sender: TObject);
var
  Tabela: TTabela;
  I: Integer;
  Tipo1, Tipo2: String;
begin
  if ListaTabelas2.ItemIndex < 0 then
  begin
    MessageDlg('Tabela não selecionada',mtInformation,[MbOk],0);
    ListaTabelas2.SetFocus;
    exit;
  end;
  if not FileExists(EdOrigem.Text) then
  begin
    MessageDlg('Tabela de existe: '+EdOrigem.Text,mtError,[MbOk],0);
    EdOrigem.SelectAll;
    EdOrigem.SetFocus;
    exit;
  end;
  TabOrigem.DatabaseName := DiretorioComBarra(ExtractFilePath(EdOrigem.Text));
  TabOrigem.TableName := ExtractFileName(EdOrigem.Text);
  TabOrigem.Open;

  Tabela := TTabela(Lst_Tabelas[ListaTabelas2.ItemIndex]);
  ListaCampos.Clear;
  for I := 0 to TabOrigem.FieldCount -1 do
    ListaCampos.Add(TabOrigem.Fields[I].FieldName + '  ('+Tipo_Campo(TabOrigem.Fields[I])+', '+IntToStr(TabOrigem.Fields[I].size)+' )');
  with TabConversao2 do
  begin
    ColCount := 2;
    RowCount := Tabela.FieldCount + 1;
    FixedRows := 1;
    Cells[0,0] := 'Campo';
    Cells[1,0] := 'Preencher com';
    for I := 0 to Tabela.FieldCount -1 do
    begin
      Cells[0,I+1] := Tabela.Fields[I].FieldName + '  ( '+Tipo_Campo(Tabela.Fields[I])+', '+IntToStr(Tabela.Fields[I].Size)+' )';
      if TabOrigem.FieldList.IndexOf(Tabela.Fields[I].FieldName) >= 0 then
      begin
        Tipo1 := Tipo_Campo(Tabela.Fields[I]);
        Tipo2 := Tipo_Campo(TabOrigem.FieldByName(Tabela.Fields[I].FieldName));
        if (Tipo1 = 'alfanumérico') and
           ((Tipo2 = 'número') or (Tipo2 = 'fracionário')) then
          Cells[1,I+1] := 'NumToStr('+Tabela.Fields[I].FieldName+')'
        else if ((Tipo1 = 'número') or (Tipo1 = 'fracionário')) and
           (Tipo2 = 'alfanumérico') then
          Cells[1,I+1] := 'StrToNum('+Tabela.Fields[I].FieldName+')'
        else if (Tipo1 = 'data') and
           (Tipo2 = 'alfanumérico') then
          Cells[1,I+1] := 'StrToDate('+Tabela.Fields[I].FieldName+')'
        else if (Tipo1 = 'alfanumérico') and
           (Tipo2 = 'lógico') then
          Cells[1,I+1] := 'LogToStr('+Tabela.Fields[I].FieldName+')'
        else
          Cells[1,I+1] := Tabela.Fields[I].FieldName;
      end
      else
        Cells[1,I+1] := '';
    end;
  end;
  TabOrigem.Close;
end;

procedure TFormAdapter.BtnImportarClick(Sender: TObject);
var
  Tabela: TTabela;
  I: Integer;
  Funcao,Campo: String;
begin
  if ListaTabelas2.ItemIndex < 0 then
  begin
    MessageDlg('Tabela não selecionada',mtInformation,[MbOk],0);
    ListaTabelas2.SetFocus;
    exit;
  end;
  if not FileExists(EdOrigem.Text) then
  begin
    MessageDlg('Tabela de existe: '+EdOrigem.Text,mtError,[MbOk],0);
    EdOrigem.SelectAll;
    EdOrigem.SetFocus;
    exit;
  end;
  if TabConversao2.RowCount < 0 then
  begin
    MessageDlg('Tabela não vinculada !!!',mtError,[MbOk],0);
    EdOrigem.SelectAll;
    EdOrigem.SetFocus;
    exit;
  end;
  if Trim(TabConversao2.Cells[0,0]) = '' then
  begin
    MessageDlg('Tabela não vinculada !!!',mtError,[MbOk],0);
    EdOrigem.SelectAll;
    EdOrigem.SetFocus;
    exit;
  end;
  if MessageDlg('Importar registros ?', mtConfirmation, [mbYes,mbNo], 0) <> mrYes then
    exit;
  TabOrigem.DatabaseName := DiretorioComBarra(ExtractFilePath(EdOrigem.Text));
  TabOrigem.TableName := ExtractFileName(EdOrigem.Text);
  TabOrigem.Open;
  try
    Screen.Cursor := crHourGlass;
    Processo.Visible := True;
    Processo.Position := 0;
    Processo.Min := 0;
    Processo.Max := TabOrigem.RecordCount;
    Tabela := TTabela(Lst_Tabelas[ListaTabelas2.ItemIndex]);
    Tabela.Abrir;
    TabOrigem.First;
    while not TabOrigem.Eof do
    begin
      Tabela.Insert;
      for I := 0 to Tabela.FieldCount -1 do
        if Trim(TabConversao2.Cells[1,I+1]) <> '' then
        begin
          Funcao := UpperCase(Trim(TabConversao2.Cells[1,I+1]));
          if Pos('(', Funcao) > 0 then
          begin
            Funcao := Copy(Funcao,01,Pos('(',Funcao)-1);
            Campo  := TabConversao2.Cells[1,I+1];
            Campo  := Copy(Campo,Pos('(',Campo)+1,Length(Campo));
            Campo  := Copy(Campo,01,Pos(')',Campo)-1);
            if Funcao = 'LOGTOSTR' then
              Campo := Copy(Campo,01,Pos(',',Campo)-1);
            if Funcao = 'UPPERCASE' then
              Tabela.Fields[I].AsVariant := UpperCase(TabOrigem.FieldList.FieldByName(Campo).AsVariant)
            else if Funcao = 'NUMTOSTR' then
              Tabela.Fields[I].AsVariant := FloatToStr(TabOrigem.FieldList.FieldByName(Campo).AsVariant)
            else if Funcao = 'STRTONUM' then
            begin
              case Tabela.Fields[I].DataType of
                ftSmallint, ftWord, ftInteger, ftLargeInt: Tabela.Fields[I].AsVariant := StrToInt(TabOrigem.FieldList.FieldByName(Campo).AsVariant)
              else
                Tabela.Fields[I].AsVariant := StrToFloat(TabOrigem.FieldList.FieldByName(Campo).AsVariant);
              end;
            end
            else if Funcao = 'STRTODATE' then
              Tabela.Fields[I].AsVariant := StrToDate(TabOrigem.FieldList.FieldByName(Campo).AsVariant)
            else if Funcao = 'LOGTOSTR' then
            begin
              if TabOrigem.FieldList.FieldByName(Campo).AsBoolean then
                Tabela.Fields[I].AsVariant := Copy(TabConversao2.Cells[1,I+1],Pos(',',TabConversao2.Cells[1,I+1])+1,1)
              else
                Tabela.Fields[I].AsVariant := Copy(TabConversao2.Cells[1,I+1],Pos(',',TabConversao2.Cells[1,I+1])+2,1);
            end
            else if Funcao = 'AUTOINCREMENTO' then
            begin
              Tabela.Fields[I].AsVariant := RetornaAutoIncremento(Tabela, Tabela.Fields[I].FieldName, Campo, 1);
            end
          end
          else
          begin
            if TabOrigem.FieldList.IndexOf(TabConversao2.Cells[1,I+1]) >= 0 then
              Tabela.Fields[I].AsVariant := TabOrigem.FieldList.FieldByName(TabConversao2.Cells[1,I+1]).AsVariant
            else
              Tabela.Fields[I].AsVariant := TabConversao2.Cells[1,I+1];
          end;
        end;
      Tabela.Post;
      Processo.Position := TabOrigem.Recno;
      Application.ProcessMessages;
      TabOrigem.Next;
    end;
  finally
    Tabela.Close;
    TabOrigem.Close;
    Screen.Cursor := crDefault;
    Processo.Visible := False;
    TabConversao2.ColCount := 2;
    TabConversao2.RowCount := 2;
    TabConversao2.FixedRows := 1;
    TabConversao2.Cells[0,0] := '';
    TabConversao2.Cells[0,1] := '';
    TabConversao2.Cells[1,0] := '';
    TabConversao2.Cells[1,1] := '';
    MessageDlg('Importação concluída !!!',mtInformation,[MbOk],0);
  end;
end;

procedure TFormAdapter.EdLocalizarClick(Sender: TObject);
begin
  Posicao := 0;
  Dados_TabConversao(EdLocalizar.ItemIndex);
end;

end.
