{
   Programa.: RotinaEd.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit RotinaEd;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Tabs, BaseD, Db, Grids, DBGrids, Atributo, dbctrls,
  FR_DSet, FR_DBSet, Clipbrd, {$IFDEF DELPHI5}{$ELSE}Variants,{$ENDIF}
  {$I LTab.pas}
  Tabela, Menus, IniFiles, FR_Class, FR_Prntr, Printers, Calculos, JPeg,
  XLookUp, Rotinas, Publicas, Filtro, OpcRel, XDBEDit, XDBDate, XDBNum,
  {$IFDEF XSQL}
  XSEngine,
  {$ENDIF}
  RXDBCtrl, ToolEdit, DBRichEd;

type
  TConsultasSalvas = class
    CsFiltro: String;
    CsTitulo: String;
    CsOrdenacao: String;
    CsCampos: String;
    constructor Create(PFiltro, PTitulo, POrdenacao: String; ListCampos: String);
    destructor Destroy; override;
  end;

// Inicialização de Campos \\
procedure AtribuiGridEdicao(Tabela: TTabela; Grid: TDBGrid; Editavel: Boolean; EventoValidacao: TFieldNotifyEvent);
procedure AtribuiCampoEdicao(Tabela: TTabela; Campo: TAtributo;
  Pagina: Integer; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; var ListaCamposED: TListaCampos; Formulario: TForm; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiCampoDB(Componente: TComponent; Tabela: TTabela;
  Campo: TAtributo; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; ListaCamposEd: TListaCampos; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBEdit(CampoED: TXDBEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBNumEdit(CampoED: TXDBNumEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiDBNumEdit(CampoED: TRxDBCalcEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBDateEdit(CampoED: TXDBDateEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiDBDateEdit(CampoED: TDBDateEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBMemo(CampoED: TDBMemo; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiDBRichEdit(CampoED: TDBRichEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiRxDBRichEdit(CampoED: TRxDBRichEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBImage(CampoED: TDBImage; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBLookUp(CampoED: TXDBLookUp; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBComboBox(CampoED: TDBComboBox; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBRadioGroup(CampoED: TDBRadioGroup; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiXDBCheckBox(CampoED: TDBCheckBox; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
procedure AtribuiDBListBox(CampoED: TDBListBox; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
function ConverteMascara(Mascara: String; Tipo: TTipoDado): String;
// Ferramentas da Manutenção e Consulta \\
procedure Ed_Localizar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_Filtrar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_Ordenar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_OrdenarComposto(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_ApagarColuna(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_TotalizarColuna(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_CalcularMedia(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_Quantificar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
procedure Ed_Imprimir(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid; DataSource: TDataSource);
procedure Ed_SalvarConsulta(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid; Var AbaConsulta: TTabSet;
  Var ConsultasSalvas: TList);
procedure SalvaConsultasEmDisco(TabelaPrincipal: TTabela; Var ConsultasSalvas: TList; AbaConsulta: TTabSet);
procedure Ed_ExcluirConsulta(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid; Var AbaConsulta: TTabSet;
  Var ConsultasSalvas: TList);
function CalculaTamanho(Campo: TAtributo): Word;
procedure AjustaColunasConsulta(TabelaPrincipal: TTabela);
procedure InicializaConsultasSalvas(TabelaPrincipal: TTabela; Var AbaConsulta: TTabSet; Var ConsultasSalvas: TList);
procedure Ed_AbaConsulta(TabelaPrincipal: TTabela; Var AbaConsulta: TTabSet; Var ConsultasSalvas: TList; GridConsulta: TDBGrid; AtualizaRegistros: Boolean = True);
procedure AtribuiDataSourceCampos(ListaCamposEd: TListaCampos; EdDataSource: TDataSource);
procedure HabilitaCamposEdicao(ListaCamposEd: TListaCampos; Habilita: Boolean = True);
procedure CamposEdicaoReadOnly(ListaCamposEd: TListaCampos; Habilita: Boolean = True);
procedure HabilitaCamposChave(ListaCamposEd: TListaCampos);
procedure DesabilitaCamposChave(ListaCamposEd: TListaCampos);
procedure DesabilitaCamposChave_Rel(ListaCamposEd: TListaCampos; Lista_Rel: TStringList);
procedure AtribuiValores_Mestre(TabelaPrincipal: TTabela; ListaCamposEd: TListaCampos);
procedure LiberaCamposPagina(Pagina: Integer; ListaCamposEd: TListaCampos);
function CamposDadosValidos(ListaCamposEd: TListaCampos; Var ErroValidacao: Boolean): Boolean;
function RetornaAutoIncremento(TabelaPrincipal: TTabela; Campo: String; Condicao: String; Qtd: Integer = 1; Consultar: Boolean = False; SempreAtribui: Boolean = False): Variant;
procedure AtribuiAutoIncremento(TabelaPrincipal: TTabela; Campo: String;
  Componente: TComponent; Condicao: String; Editavel: Boolean);
procedure ExecutaPreValidacoes(TabelaPrincipal: TTabela; Formulario: TForm; ListaCamposEd: TListaCampos; ValoresPadrao: Boolean = False; SalvarRegistro: Boolean = False);
procedure ExecutaPreValidacoesGrid(Tabela: TTabela);
function LocalizaTabela(Nome: String): TTabela;
procedure DBGridZebrado(DBGrid: TDBGrid; const Rect: TRect; Column: TColumn; State: TGridDrawState; Condicao: Boolean; CorLinha: TColor = $00DFDF00; CorSelecao: TColor = clNavy);

implementation

uses Abertura, GridPesquisa, Pesquisa_Ed;

constructor TConsultasSalvas.Create(PFiltro, PTitulo, POrdenacao: String; ListCampos: String);
begin
  CsFiltro    := PFiltro;
  CsTitulo    := PTitulo;
  CsOrdenacao := POrdenacao;
  CsCampos    := ListCampos;
end;

destructor TConsultasSalvas.Destroy;
begin
  inherited Destroy;
end;

// Inicialização de Campos \\
procedure AtribuiGridEdicao(Tabela: TTabela; Grid: TDBGrid; Editavel: Boolean; EventoValidacao: TFieldNotifyEvent);
var
  Coluna: TDBGridColumns;
  Opcoes: TDBGridOptions;
  I, Y: Integer;
  CampoED: TAtributo;
  TabelaP: TTabela;
begin
  Opcoes := Grid.Options;
  exclude(Opcoes, dgTabs);
  if Editavel then
    include(Opcoes, dgEditing)
  else
    exclude(Opcoes, dgEditing);
  Grid.Options := Opcoes;
  Grid.ReadOnly := not Editavel;
  Tabela.AtribuiRelacionamentos;
  if Editavel then
    for I:=0 to Tabela.Campos.Count-1 do
    begin
      CampoED := TAtributo(Tabela.Campos[I]);
      CampoED.Valor.OnValidate := EventoValidacao;
      if Trim(CampoED.ChaveEstrangeira) <> '' then
        Grid.Columns[CampoED.Valor.Index].ButtonStyle := cbsEllipsis
      else if CampoED.ValorValido.Count > 0 then
      begin
        Grid.Columns[CampoED.Valor.Index].PickList.Clear;
        Grid.Columns[CampoED.Valor.Index].PickList.AddStrings(CampoED.ValorValido);
      end;
    end;
end;

procedure AtribuiCampoEdicao(Tabela: TTabela; Campo: TAtributo;
  Pagina: Integer; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; var ListaCamposED: TListaCampos; Formulario: TForm; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
var
  CampoEntrada: TCampoEdicao;
  Comp: TComponent;
  Controle: TControl;
begin
  CampoEntrada           := TCampoEdicao.Create;
  CampoEntrada.Campo     := Campo;
  if Pagina = -2 then // Localizar campo na página
  begin
    Comp := TForm(Formulario).FindComponent(Campo.Nome);
    if Comp <> Nil then
    begin
      if (TControl(Comp).Parent is TScrollBox) then
        Controle := TControl(Comp).Parent
      else
        if (TControl(Comp).Parent.Parent is TScrollBox) then
          Controle := TControl(Comp).Parent.Parent;
      if Controle <> Nil then
        CampoEntrada.Pagina := StrToIntDef(Copy(Controle.Name, 07, 02), 0)
      else
        CampoEntrada.Pagina := 0;
    end;
  end
  else
    CampoEntrada.Pagina  := Pagina;
  CampoEntrada.Validacao := EventoValidacao;
  CampoEntrada.Controle  := nil;
  ListaCamposED.Add(CampoEntrada);
  AtribuiCampoDB(TForm(Formulario).FindComponent(Campo.Nome), Tabela, Campo, EventoValidacao, EventoDrawItem, ListaCamposEd, DataSource, EventoPesquisa);
  if TForm(Formulario).FindComponent(Campo.Nome) is TDBImage then
    if TForm(Formulario).FindComponent('MenuImagem') <> Nil then
      TDBImage(TForm(Formulario).FindComponent(Campo.Nome)).PopupMenu := TPopupMenu(TForm(Formulario).FindComponent('MenuImagem'));
end;

procedure AtribuiCampoDB(Componente: TComponent; Tabela: TTabela;
  Campo: TAtributo; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; ListaCamposEd: TListaCampos; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  if Componente = nil then
    Exit;
  if Componente is TXDBEdit then
    AtribuiXDBEdit(TXDBEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TXDBNumEdit then
    AtribuiXDBNumEdit(TXDBNumEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TRxDBCalcEdit then
    AtribuiDBNumEdit(TRxDBCalcEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TXDBDateEdit then
    AtribuiXDBDateEdit(TXDBDateEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBDateEdit then
    AtribuiDBDateEdit(TDBDateEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBMemo then
    AtribuiXDBMemo(TDBMemo(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBRichEdit then
    AtribuiDBRichEdit(TDBRichEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TRxDBRichEdit then
    AtribuiRxDBRichEdit(TRxDBRichEdit(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBImage then
    AtribuiXDBImage(TDBImage(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TXDBLookUp then
    AtribuiXDBLookUp(TXDBLookUp(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBComboBox then
    AtribuiXDBComboBox(TDBComboBox(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBRadioGroup then
    AtribuiXDBRadioGroup(TDBRadioGroup(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBCheckBox then
    AtribuiXDBCheckBox(TDBCheckBox(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa)
  else if Componente is TDBListBox then
    AtribuiDBListBox(TDBListBox(Componente), Campo, Tabela, EventoValidacao, EventoDrawItem, DataSource, EventoPesquisa);
  TCampoEdicao(ListaCamposED[ListaCamposED.Count - 1]).Controle := (Componente as TWinControl);
end;

procedure AtribuiXDBEdit(CampoED: TXDBEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  try
    CampoED.DataSource := DataSource;
    CampoED.DataField  := Campo.Nome;
    CampoED.Hint       := Campo.Ajuda;
    CampoED.ShowHint   := True;
    CampoED.OnExit     := EventoValidacao;
    CampoED.EditMask   := ConverteMascara(Campo.Mascara, Campo.Tipo);
    CampoED.MaxLength  := Campo.Tamanho;
    if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
      CampoED.ReadOnly := True;
    if (Campo.Mascara = ConstStr('X',Campo.Tamanho)) or
       (Campo.Mascara = ConstStr('A',Campo.Tamanho)) then
      CampoED.CharCase := ecUpperCase
    else if (Campo.Mascara = ConstStr('x',Campo.Tamanho)) or
       (Campo.Mascara = ConstStr('a',Campo.Tamanho)) then
      CampoED.CharCase := ecLowerCase;
    if Trim(Campo.TabEstrangeira) <> '' then
    begin
      CampoED.ShowButton := True;
      CampoED.EnabledBtn := True;
      CampoED.Pesquisa   := True;
      CampoED.OnBtnClick := EventoPesquisa;
    end;
  except
    on E: Exception do
  end;
end;

procedure AtribuiXDBNumEdit(CampoED: TXDBNumEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
var
  Posicao, I, Dc: Integer;
begin
  try
    CampoED.DataSource := DataSource;
    CampoED.DataField  := Campo.Nome;
    CampoED.Hint       := Campo.Ajuda;
    CampoED.ShowHint   := True;
    CampoED.OnExit     := EventoValidacao;
    CampoED.ShowButton := False;
    CampoED.Decimals   := 0;
    if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
      CampoED.ReadOnly := True;
    Posicao            := Pos(',',Campo.Mascara);
    if Posicao > 0 then
    begin
      Dc := 0;
      for I:=Posicao+1 to Length(Campo.Mascara) do
        if Campo.Mascara[I] <> ' ' then
          Inc(Dc);
      CampoEd.Decimals := Dc;
      if Dc > 0 then
      begin
        CampoED.ShowButton := True;
        CampoED.EnabledBtn := True;
      end;
      CampoED.MaxLength := Campo.Tamanho + 1;
    end
    else if Campo.Mascara = ConstStr('9',Campo.Tamanho) then
    begin
      CampoED.ZeroLength := Campo.Tamanho;
      CampoED.MaxLength  := Campo.Tamanho;
    end;
    if Trim(Campo.TabEstrangeira) <> '' then
    begin
      CampoED.ShowButton := True;
      CampoED.EnabledBtn := True;
      CampoED.Pesquisa   := True;
      CampoED.OnBtnClick := EventoPesquisa;
    end;
  except
    on E: Exception do
  end;
end;

procedure AtribuiDBNumEdit(CampoED: TRxDBCalcEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
var
  Posicao, I, Dc: Integer;
begin
  try
    CampoED.DataSource   := DataSource;
    CampoED.DataField    := Campo.Nome;
    CampoED.Hint         := Campo.Ajuda;
    CampoED.ShowHint     := True;
    CampoED.OnExit       := EventoValidacao;
    CampoED.ButtonWidth  := 0;
    CampoED.DecimalPlaces:= 0;
    if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
      CampoED.ReadOnly := True;
    Posicao            := Pos(',',Campo.Mascara);
    if Posicao > 0 then
    begin
      Dc := 0;
      for I:=Posicao+1 to Length(Campo.Mascara) do
        if Campo.Mascara[I] <> ' ' then
          Inc(Dc);
      CampoEd.DecimalPlaces := Dc;
      if Dc > 0 then
      begin
        CampoED.ButtonWidth := 20;
      end;
      CampoED.MaxLength := Campo.Tamanho + 1;
    end
    else if Campo.Mascara = ConstStr('9',Campo.Tamanho) then
    begin
      CampoED.ZeroEmpty := False;
      CampoED.MaxLength := Campo.Tamanho;
    end;
    if Trim(Campo.TabEstrangeira) <> '' then
    begin
      CampoED.ButtonWidth   := 20;
      CampoED.OnButtonClick := EventoPesquisa;
    end;
  except
    on E: Exception do
  end;
end;

procedure AtribuiXDBDateEdit(CampoED: TXDBDateEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  try
    CampoED.DataSource := DataSource;
    CampoED.DataField  := Campo.Nome;
    CampoED.Hint       := Campo.Ajuda;
    CampoED.ShowHint   := True;
    CampoED.OnExit     := EventoValidacao;
    CampoED.BaseChar   := Campo.CaractereEdicao;
    CampoED.ShowButton := True;
    CampoED.EnabledBtn := True;
    if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
      CampoED.ReadOnly := True;
    if Trim(Campo.Mascara) <> '' then
    begin
      if Pos('9999', Campo.Mascara) > 0 then
      begin
        CampoEd.Century := True;
        CampoED.EditMask   := '!99/99/9999;1;';
      end
      else
      begin
        CampoEd.Century := False;
        CampoED.EditMask   := '!99/99/99;1;';
      end;
    end
    else
    begin
      if Pos('yyyy',Sistema.EstiloData) > 0 then
      begin
        CampoEd.Century := True;
        CampoED.EditMask   := '!99/99/9999;1;';
      end
      else
      begin
        CampoEd.Century := False;
        CampoED.EditMask   := '!99/99/99;1;';
      end;
    end;
    if Trim(Campo.TabEstrangeira) <> '' then
    begin
      CampoED.ShowButton := True;
      CampoED.EnabledBtn := True;
      CampoED.Pesquisa   := True;
      CampoED.OnBtnClick := EventoPesquisa;
    end;
  except
    on E: Exception do
  end;
end;

procedure AtribuiDBDateEdit(CampoED: TDBDateEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  try
    CampoED.DataSource := DataSource;
    CampoED.DataField  := Campo.Nome;
    CampoED.Hint       := Campo.Ajuda;
    CampoED.ShowHint   := True;
    CampoED.OnExit     := EventoValidacao;
    if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
      CampoED.ReadOnly := True;
    if Trim(Campo.Mascara) <> '' then
    begin
      if Pos('9999', Campo.Mascara) > 0 then
        CampoEd.YearDigits := dyFour
      else
        CampoEd.YearDigits := dyTwo;
    end
    else
    begin
      if Pos('yyyy',Sistema.EstiloData) > 0 then
        CampoEd.YearDigits := dyFour
      else
        CampoEd.YearDigits := dyTwo;
    end;
    if Trim(Campo.TabEstrangeira) <> '' then
      CampoED.OnButtonClick := EventoPesquisa;
  except
    on E: Exception do
  end;
end;

procedure AtribuiXDBMemo(CampoED: TDBMemo; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  CampoEd.OnExit     := EventoValidacao;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiDBRichEdit(CampoED: TDBRichEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  CampoEd.OnExit     := EventoValidacao;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiRxDBRichEdit(CampoED: TRxDBRichEdit; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  CampoEd.OnExit     := EventoValidacao;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiXDBImage(CampoED: TDBImage; Campo: TAtributo; Tabela: TTabela;
  EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  CampoEd.OnExit     := EventoValidacao;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiXDBLookUp(CampoED: TXDBLookUp; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
var
  TabelaP: TTabela;
begin
  TabelaP := LocalizaTabela(Campo.TabEstrangeira);
  if TabelaP <> nil then
    if Campo.EstiloPesquisa = 0 then
      TabelaP.CampoRelacionado(CampoEd,Campo.ChaveEstrangeira,Campo.CamposVisuais);
  TabelaP.Abrir;
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  CampoEd.OnExit     := EventoValidacao;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiXDBComboBox(CampoED: TDBComboBox; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.ItemHeight := Abs(CampoED.Font.Height) + 2;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  Campo.MontaValoresValidos(CampoED.Items);
  CampoEd.OnExit     := EventoValidacao;
  CampoEd.OnDrawItem := EventoDrawItem;
  CampoEd.Style      := csOwnerDrawFixed;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiXDBRadioGroup(CampoED: TDBRadioGroup; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  Campo.MontaValoresValidos(CampoED.Values);
  Campo.MontaDescValoresValidos(CampoED.Items);
  CampoEd.OnExit     := EventoValidacao;
  if CampoED.Items.Count > 0 then
    CampoED.ItemIndex := 0;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiXDBCheckBox(CampoED: TDBCheckBox; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource     := DataSource;
  CampoED.DataField      := Campo.Nome;
  if Campo.Tipo <> tpBoolean then
  begin
    CampoED.ValueChecked   := Campo.ValorValido[0];
    CampoED.ValueUnchecked := Campo.ValorValido[1];
  end;
  CampoED.Hint           := Campo.Ajuda;
  CampoED.ShowHint       := True;
  CampoEd.OnExit         := EventoValidacao;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

procedure AtribuiDBListBox(CampoED: TDBListBox; Campo: TAtributo;
  Tabela: TTabela; EventoValidacao: TNotifyEvent; EventoDrawItem: TDrawItemEvent; DataSource: TDataSource; EventoPesquisa: TNotifyEvent = nil);
begin
  CampoED.DataSource := DataSource;
  CampoED.DataField  := Campo.Nome;
  CampoED.ItemHeight := Abs(CampoED.Font.Height) + 2;
  CampoED.Hint       := Campo.Ajuda;
  CampoED.ShowHint   := True;
  Campo.MontaValoresValidos(CampoED.Items);
  CampoEd.OnExit     := EventoValidacao;
  CampoEd.OnDrawItem := EventoDrawItem;
  CampoEd.Style      := lbOwnerDrawFixed;
  if (Campo.Calculado) or (Campo.Extra) or (Campo.Calculado_F) then
    CampoED.ReadOnly := True;
end;

function ConverteMascara(Mascara: String; Tipo: TTipoDado): String;
var
  MascaraCmp: string;
  TipoAtr: TTipoDado;
  I: Integer;
begin
  MascaraCmp := Mascara;
  TipoAtr := Tipo;
  if MascaraCmp <> '' then
  begin
    for I := 1 to Length(MascaraCmp) do
      case MascaraCmp[I] of
        '9': MascaraCmp[I] := '0';
        'Z': MascaraCmp[I] := '#';
        'X': MascaraCmp[I] := 'C';
        'x': MascaraCmp[I] := 'c';
        'A': MascaraCmp[I] := 'C';
        'a': MascaraCmp[I] := 'c';
        '-': if TipoAtr in [tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD] then
               MascaraCmp[I] := '#';
        '.': if TipoAtr in [tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD] then
               MascaraCmp[I] := ',';
        ',': if TipoAtr in [tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD] then
               MascaraCmp[I] := '.'
      end;
    if UpperCase(MascaraCmp) = ConstStr('C',Length(MascaraCmp)) then
      MascaraCmp := ''
    else
      MascaraCmp := MascaraCmp + ';0; ';
  end;
  ConverteMascara := MascaraCmp;
end;

// Ferramentas da Manutenção e Consulta \\
procedure Ed_Localizar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
var
  I: Integer;
  ret: Boolean;
begin
  FormPesquisa_Ed := TFormPesquisa_Ed.Create(Application);
  Try
    FormPesquisa_Ed.EdCampos.Clear;
    For I:=0 to TabelaPrincipal.Campos.Count-1 do
      FormPesquisa_Ed.EdCampos.Items.Add(TAtributo(TabelaPrincipal.Campos[I]).Titulo);
    FormPesquisa_Ed.EdCampos.ItemIndex := IIF(TabelaPrincipal.Locate_Field <= FormPesquisa_Ed.EdCampos.Items.Count-1, TabelaPrincipal.Locate_Field, 0);
    FormPesquisa_Ed.EdPesquisa.Text    := TabelaPrincipal.Locate_String;
    if FormPesquisa_Ed.ShowModal = mrOk then
      if Trim(FormPesquisa_Ed.EdPesquisa.Text) <> '' then
      begin
        Sistema.Conexao_i := Time;
        if FormPesquisa_Ed.Origem.ItemIndex = 1 then
          TabelaPrincipal.First;
        ret := TabelaPrincipal.Locate(TAtributo(TabelaPrincipal.Campos[FormPesquisa_Ed.EdCampos.ItemIndex]).Valor.FieldName, FormPesquisa_Ed.EdPesquisa.Text, [loCaseInsensitive, loPartialKey]);
        TabelaPrincipal.Locate_Field  := FormPesquisa_Ed.EdCampos.ItemIndex;
        TabelaPrincipal.Locate_String := FormPesquisa_Ed.EdPesquisa.Text;
        Sistema.Conexao_f := Time;
        Atualiza_Status;
        if not ret then
          MessageDlg(FormPesquisa_Ed.EdPesquisa.Text+^M+'não localizado!',mtInformation,[mbOk],0);
      end;
  Finally
    FormPesquisa_Ed.Free;
  end;
end;

procedure Ed_Filtrar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  I: Integer;
begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'F') then
  begin
    MessageDlg('Filtragem não Permitida !',mtError,[mbOk],0);
    exit;
  end;
  FormFiltragem := TFormFiltragem.Create(Application);
  Try
    FormFiltragem.CamposSelecao.Clear;
    For I:=0 to TabelaPrincipal.Campos.Count-1 do
      FormFiltragem.CamposSelecao.Add(TabelaPrincipal.Campos[I]);
    FormFiltragem.MFiltro.Lines.Text := TabelaPrincipal.Filtro.Text;
    FormFiltragem.ShowModal;
  Finally
    if FormFiltragem.ProcessarFiltro then
    begin
      TabelaPrincipal.Filtro.Clear;
      TabelaPrincipal.Filtro.AddStrings(FormFiltragem.MFiltro.Lines);
      Sistema.Conexao_i := Time;
      TabelaPrincipal.AtualizaSql;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    end;
    FormFiltragem.Free;
  end;
end;

procedure Ed_Ordenar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  Posicao: Integer;
  I: Integer;
  NomeCampo, NomeTabela: String;
  Ok: Boolean;
begin
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Posicao := GridConsulta.Columns.Grid.SelectedIndex;
  if Posicao < 0 then
  begin
    MessageDlg('Coluna não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  if MessageDlg('Ordenar por:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    NomeCampo  := GridConsulta.Fields[Posicao].FieldName;
    NomeTabela := '';
    Ok := True;
    For I:=0 to TabelaPrincipal.Campos.Count-1 do
      if TAtributo(TabelaPrincipal.Campos[I]).Nome = NomeCampo then
      begin
        NomeTabela := TAtributo(TabelaPrincipal.Campos[I]).NomeTabela;
        NomeCampo := TAtributo(TabelaPrincipal.Campos[I]).NomeOriginal;
        Ok := not TAtributo(TabelaPrincipal.Campos[I]).Calculado;
        break;
      end;
    if (NomeTabela <> '') and (Ok) then
    begin
      TabelaPrincipal.TituloIndice:= GridConsulta.Fields[Posicao].DisplayLabel;
      if MessageDlg('Ordem Crescente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        TabelaPrincipal.ChaveIndice := NomeTabela + '.' + NomeCampo
      else
        TabelaPrincipal.ChaveIndice := NomeTabela + '.' + NomeCampo + ' DESC';
      Sistema.Conexao_i := Time;
      TabelaPrincipal.AtualizaSql;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    end
    else
      MessageDlg('Campo não localizado na tabela '+TabelaPrincipal.Titulo+' !',mtWarning,[mbOk],0);
  end;
end;

procedure Ed_OrdenarComposto(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  Posicao: Integer;
  I: Integer;
  NomeCampo, NomeTabela: String;
  Ok: Boolean;
begin
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Posicao := GridConsulta.Columns.Grid.SelectedIndex;
  if Posicao < 0 then
  begin
    MessageDlg('Coluna não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  if MessageDlg('Compor na Ordenação:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    NomeCampo  := GridConsulta.Fields[Posicao].FieldName;
    NomeTabela := '';
    Ok := True;
    For I:=0 to TabelaPrincipal.Campos.Count-1 do
      if TAtributo(TabelaPrincipal.Campos[I]).Nome = NomeCampo then
      begin
        NomeTabela := TAtributo(TabelaPrincipal.Campos[I]).NomeTabela;
        NomeCampo := TAtributo(TabelaPrincipal.Campos[I]).NomeOriginal;
        Ok := not TAtributo(TabelaPrincipal.Campos[I]).Calculado;
        break;
      end;
    if (NomeTabela <> '') and (Ok) then
    begin
      TabelaPrincipal.TituloIndice:= TabelaPrincipal.TituloIndice + ',' + GridConsulta.Fields[Posicao].DisplayLabel;
      TabelaPrincipal.ChaveIndice := TrocaString(TabelaPrincipal.ChaveIndice, ' DESC', '', [rfReplaceAll]);
      if MessageDlg('Ordem Crescente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        TabelaPrincipal.ChaveIndice := TabelaPrincipal.ChaveIndice + ',' + NomeTabela + '.' + NomeCampo
      else
        TabelaPrincipal.ChaveIndice := TabelaPrincipal.ChaveIndice + ',' + NomeTabela + '.' + NomeCampo + ' DESC';
      Sistema.Conexao_i := Time;
      TabelaPrincipal.AtualizaSql;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    end
    else
      MessageDlg('Campo não localizado na tabela '+TabelaPrincipal.Titulo+' !',mtWarning,[mbOk],0);
  end;
end;

procedure Ed_ApagarColuna(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  Posicao: Integer;
  Campo: TField;
begin
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  if GridConsulta.FieldCount <= 1 then
  begin
    MessageDlg('Operação não permitida !',mtInformation,[mbOk],0);
    exit;
  end;
  Posicao := GridConsulta.Columns.Grid.SelectedIndex;
  if Posicao < 0 then
  begin
    MessageDlg('Coluna não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  if MessageDlg('Apagar Coluna:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Campo := TabelaPrincipal.FindField(GridConsulta.Fields[Posicao].FullName);
    if Campo <> nil then
      Campo.Visible := False;
  end;
end;

procedure Ed_Quantificar(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  QtdR: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    QtdR := 0;
    Sistema.Conexao_i := Time;
    TabelaPrincipal.DisableControls;
    TabelaPrincipal.Last;
    TabelaPrincipal.First;
    QtdR := TabelaPrincipal.RecordCount;
  finally
    TabelaPrincipal.EnableControls;
    Screen.Cursor := crDefault;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  end;
  MessageDlg('Quantificação: '+IntToStr(QtdR),mtInformation,[mbOk],0);
end;

procedure Ed_TotalizarColuna(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  Posicao: Integer;
  Ok: Boolean;
  Soma: Double;
begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'T') then
  begin
    MessageDlg('Totalização não Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Posicao := GridConsulta.Columns.Grid.SelectedIndex;
  if Posicao < 0 then
  begin
    MessageDlg('Coluna não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Ok := False;
  case GridConsulta.Fields[Posicao].DataType of
    ftInteger, ftFloat, ftCurrency, ftLargeInt:
      Ok := True;
  end;
  if not Ok then
  begin
    MessageDlg('Coluna não númerica !',mtInformation,[mbOk],0);
    exit;
  end;
  if MessageDlg('Totalizar Coluna:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Soma := 0;
    Screen.Cursor := crHourGlass;
    try
      Sistema.Conexao_i := Time;
      TabelaPrincipal.DisableControls;
      TabelaPrincipal.First;
      while not TabelaPrincipal.Eof do
      begin
        case GridConsulta.Fields[Posicao].DataType of
           ftInteger, ftLargeInt:
             Soma := Soma + GridConsulta.Fields[Posicao].AsInteger;
           ftFloat:
             Soma := Soma + GridConsulta.Fields[Posicao].AsFloat;
           ftCurrency:
             Soma := Soma + GridConsulta.Fields[Posicao].AsCurrency;
        end;
        TabelaPrincipal.Next;
      end;
    finally
      TabelaPrincipal.EnableControls;
      Screen.Cursor := crDefault;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    end;
    MessageDlg('Totalização da Coluna:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+': '+MascValor(Soma, 'ZZ.ZZZ.ZZZ.ZZ9,9999'),mtInformation,[mbOk],0);
  end;
end;

procedure Ed_CalcularMedia(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid);
Var
  Posicao,QtdR: Integer;
  Ok: Boolean;
  Soma: Double;
begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'T') then
  begin
    MessageDlg('Média não Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Posicao := GridConsulta.Columns.Grid.SelectedIndex;
  if Posicao < 0 then
  begin
    MessageDlg('Coluna não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Ok := False;
  case GridConsulta.Fields[Posicao].DataType of
    ftInteger, ftFloat, ftCurrency, ftLargeInt:
      Ok := True;
  end;
  if not Ok then
  begin
    MessageDlg('Coluna não númerica !',mtInformation,[mbOk],0);
    exit;
  end;
  if MessageDlg('Calcular a Média da Coluna:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Soma := 0;
    Screen.Cursor := crHourGlass;
    try
      Sistema.Conexao_i := Time;
      QtdR := 0;
      TabelaPrincipal.DisableControls;
      TabelaPrincipal.First;
      while not TabelaPrincipal.Eof do
      begin
        case GridConsulta.Fields[Posicao].DataType of
           ftInteger, ftLargeInt:
             Soma := Soma + GridConsulta.Fields[Posicao].AsInteger;
           ftFloat:
             Soma := Soma + GridConsulta.Fields[Posicao].AsFloat;
           ftCurrency:
             Soma := Soma + GridConsulta.Fields[Posicao].AsCurrency;
        end;
        Inc(QtdR);
        TabelaPrincipal.Next;
      end;
    finally
      TabelaPrincipal.EnableControls;
      Screen.Cursor := crDefault;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    end;
    MessageDlg('Média da Coluna:'+^M+^M+GridConsulta.Fields[Posicao].DisplayName+': '+MascValor(Soma/QtdR, 'ZZ.ZZZ.ZZZ.ZZ9,9999'),mtInformation,[mbOk],0);
  end;
end;

procedure Ed_Imprimir(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid; DataSource: TDataSource);
var
  frDataSet: TfrDBDataSet;
  frImpressao: TfrReport;
  faixa: TfrBandView;
  Atrib: TfrMemoView;
  Page: TfrPage;
  Campo: TField;
  PIni: Integer;
  w, h, p: Integer;
  Ok, Totalizar, Quantificar, Sintetizar, Quebra, SubTotalizar, EditorR: Boolean;
  TitRel: String;
  LSomatoria: TStringList;
  LSomatoriaGroup: TStringList;
  LMascara: TStringList;
  LPosicao: TStringList;
  LarguraPg,AlturaPg: Integer;

  procedure ConfiguraRel;
  begin
    FormOpcRel := TFormOpcRel.Create(Application);
    with FormOpcRel do
    begin
      CQuebra.Caption := 'Quebra por: '+TabelaPrincipal.TituloIndice;
      EdTitulo.Text := TitRel;
      CB5.Checked := not Page.UseMargins;
      if Page.pgOr = poPortrait then
        RB1.Checked := True else
        RB2.Checked := True;
      ComB1.Items := Prn.PaperNames;
      ComB1.ItemIndex := Prn.GetArrayPos(Page.pgSize);
      E1.Text := ''; E2.Text := '';
      if Page.pgSize = $100 then
      begin
        E1.Text := IntToStr(Page.pgWidth div 10);
        E2.Text := IntToStr(Page.pgHeight div 10);
      end;
      E3.Text := IntToStr(Page.pgMargins.Left * 5 div 18);
      E4.Text := IntToStr(Page.pgMargins.Top * 5 div 18);
      E5.Text := IntToStr(Page.pgMargins.Right * 5 div 18);
      E6.Text := IntToStr(Page.pgMargins.Bottom * 5 div 18);
      E7.Text := IntToStr(Page.ColGap * 5 div 18);
      Edit1.Text := IntToStr(Page.ColCount);
      Ok := False;
      if ShowModal = mrOk then
      begin
        Ok := True;
        Quantificar := CQuantificar.Checked;
        Totalizar   := CTotalizar.Checked;
        Sintetizar  := CSintetizar.Checked;
        Quebra      := CQuebra.Checked;
        SubTotalizar:= CSubTotalizar.Checked;
        EditorR     := CDesigner.Checked;
        TitRel := EdTitulo.Text;
        Page.UseMargins := not CB5.Checked;
        if RB1.Checked then
          Page.pgOr := poPortrait else
          Page.pgOr := poLandscape;
        p := Prn.PaperSizes[ComB1.ItemIndex];
        w := 0; h := 0;
        if p = $100 then
          try
            w := StrToInt(E1.Text) * 10; h := StrToInt(E2.Text) * 10;
          except
            on exception do p := 9; // A4
          end;
        try
          Page.pgMargins := Rect(StrToInt(E3.Text) * 18 div 5,
                            StrToInt(E4.Text) * 18 div 5,
                            StrToInt(E5.Text) * 18 div 5,
                            StrToInt(E6.Text) * 18 div 5);
          Page.ColGap := StrToInt(E7.Text) * 18 div 5;
        except
          on exception do
          begin
            Page.pgMargins := Rect(0, 0, 0, 0);
            Page.ColGap := 0;
          end;
        end;
        Page.ColCount := StrToInt(Edit1.Text);
        Page.ChangePaper(p, w, h, Page.pgOr);
        CurPage := CurPage;
      end;
      Free;
    end;
  end;

  procedure Cabecalho;
  begin
    faixa := TfrBandView(frCreateObject(gtBand, ''));
    faixa.SetBounds(0, 30, 752, 88);
    faixa.BandType := btPageHeader;
    faixa.Dataset := 'frDataSet';
    Page.Objects.Add(faixa);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 34, 728, 80);
    Atrib.FrameTyp := 15;
    Atrib.Adjust   := 2;
    Page.Objects.Add(Atrib);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 93, 728, 0);
    Atrib.FrameTyp := 2;
    Page.Objects.Add(Atrib);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(16, 39, 120, 18);
    Atrib.Memo.Add('[Date], [Time]');
    Atrib.Adjust := 2;
    Page.Objects.Add(Atrib);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(535, 39, 204, 18);
    Atrib.Memo.Add('Página [Page#]');
    Atrib.Adjust := 1;
    Page.Objects.Add(Atrib);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 39, 728, 18);
    Atrib.Memo.Add(Sistema.EmpresaUsr);
    Atrib.Font.Name  := 'Arial';
    Atrib.Font.Size  := 10;
    Atrib.Font.Style := [fsBold];
    Atrib.Font.Color := clBlack;
    Atrib.Adjust     := 2;
    Page.Objects.Add(Atrib);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 63, 728, 18);
    Atrib.Memo.Add(TitRel);
    Atrib.Font.Name  := 'Arial';
    Atrib.Font.Size  := 10;
    Atrib.Font.Style := [fsBold];
    Atrib.Font.Color := clBlack;
    Atrib.Adjust     := 2;
    Page.Objects.Add(Atrib);
  end;

  procedure ColunasRelatorio;
  Var
    I: Integer;
  begin
    faixa := TfrBandView(frCreateObject(gtBand, ''));
    faixa.SetBounds(0, 140, 752, 20);
    faixa.BandType := btMasterData;
    faixa.Dataset := 'frDataSet';
    if Sintetizar then
      faixa.Visible := False;
    Page.Objects.Add(faixa);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 159, 728, 0);
    Atrib.FrameTyp := 2;
    Page.Objects.Add(Atrib);
    PIni := 15;
    for I := 0 to GridConsulta.Columns.Count-1 do
    begin
      Campo := GridConsulta.Columns[I].Field;
      if Campo.Visible then
      begin
        Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
        Atrib.SetBounds(PIni, 95, Campo.DisplayWidth * 7, 18);
        Atrib.Memo.Add(Campo.DisplayName);
        Atrib.Font.Name  := 'Arial';
        Atrib.Font.Size  := 09;
        Atrib.Font.Style := [fsBold];
        Atrib.Font.Color := clBlack;
        if (Campo.DataType = ftSmallint	) or
           (Campo.DataType = ftInteger  ) or
           (Campo.DataType = ftFloat    ) then
          Atrib.Adjust := (Atrib.Adjust and $FC) + 1;
        Page.Objects.Add(Atrib);

        Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
        Atrib.SetBounds(PIni, 141, Campo.DisplayWidth * 7, 16);
        Atrib.Memo.Add('[TabGlobal.'+TabelaPrincipal.Name+'."'+Campo.FullName+'"]');
        Atrib.Font.Name  := 'Arial';
        Atrib.Font.Size  := 08;
        Atrib.Font.Style := [];
        Atrib.Font.Color := clBlack;
        if (Campo.DataType = ftSmallint	) or
           (Campo.DataType = ftInteger  ) or
           (Campo.DataType = ftFloat    ) then
        begin
          Atrib.Adjust := (Atrib.Adjust and $FC) + 1;
          Atrib.Format := (Atrib.Format and $F0FFFFFF) + 1 * $01000000;
          Atrib.Format := (Atrib.Format and $FF00FFFF) + 4 * $00010000;
          Atrib.FormatStr:= Copy(Campo.EditMask,01,Length(Campo.EditMask)-04);
          LSomatoria.Add('[SUM(TabGlobal.'+TabelaPrincipal.Name+'."'+Campo.FullName+'")]');
          LSomatoriaGroup.Add('[SUM([TabGlobal.'+TabelaPrincipal.Name+'."'+Campo.FullName+'"])]');
          LMascara.Add(Atrib.FormatStr);
          LPosicao.Add(StrZero(PIni,05)+StrZero(141,05)+StrZero(Campo.DisplayWidth * 7,05)+StrZero(16,05));
        end;
        Page.Objects.Add(Atrib);
        PIni := PIni + (Campo.DisplayWidth * 7) + 08;
      end;
    end;
  end;

  procedure Quebras;
  Var
    I: Integer;
    CampoGroup: String;
    CamposCh: TStringList;
  begin
    faixa := TfrBandView(frCreateObject(gtBand, ''));
    faixa.SetBounds(0, 460, 752, 24);
    faixa.BandType := btGroupHeader;
    faixa.Dataset := 'frDataSet';
    CamposCh := TStringList.Create;
    StringToArray(TabelaPrincipal.ChaveIndice,',',CamposCh);
    CampoGroup := Trim(CamposCh[0]);
    CamposCh.Free;
    faixa.GroupCondition := 'TabGlobal.'+TabelaPrincipal.Name+'."'+CampoGroup+'"';
    Page.Objects.Add(faixa);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 460, 728, 24);
    Atrib.FrameTyp := 15;
    Atrib.Adjust   := 2;
    Page.Objects.Add(Atrib);

    Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
    Atrib.SetBounds(15, 463, 728, 16);
    Atrib.Memo.Add(TabelaPrincipal.TituloIndice+': [TabGlobal.'+TabelaPrincipal.Name+'."'+CampoGroup+'"]');
    Atrib.Font.Name  := 'Arial';
    Atrib.Font.Size  := 08;
    Atrib.Font.Style := [fsBold];
    Atrib.Font.Color := clBlack;
    Page.Objects.Add(Atrib);

    faixa := TfrBandView(frCreateObject(gtBand, ''));
    faixa.SetBounds(0, 532, 752, 40);
    faixa.BandType := btGroupFooter;
    faixa.Dataset := 'frDataSet';
    Page.Objects.Add(faixa);
    if SubTotalizar then
    begin
      for I:=0 to LSomatoria.Count-1 do
      begin
        Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
        Atrib.SetBounds(StrToInt(Copy(LPosicao[I],01,05)), 536, StrToInt(Copy(LPosicao[I],11,05)), StrToInt(Copy(LPosicao[I],16,11)));
        Atrib.Memo.Add(LSomatoriaGroup[I]);
        Atrib.Font.Name  := 'Arial';
        Atrib.Font.Size  := 08;
        Atrib.Font.Style := [];
        Atrib.Font.Color := clBlack;
        Atrib.Adjust := (Atrib.Adjust and $FC) + 1;
        Atrib.Format := (Atrib.Format and $F0FFFFFF) + 1 * $01000000;
        Atrib.Format := (Atrib.Format and $FF00FFFF) + 4 * $00010000;
        Atrib.FormatStr:= LMascara[I];
        Page.Objects.Add(Atrib);
      end;
    end;
    if SubTotalizar and Quantificar then
    begin
      Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
      Atrib.SetBounds(16, 553, 190, 16);
      Atrib.Memo.Add('** Listado(s): [Count([TabGlobal.'+TabelaPrincipal.Name+'])] Registro(s)');
      Atrib.Font.Name  := 'Arial';
      Atrib.Font.Size  := 08;
      Atrib.Font.Style := [];
      Atrib.Font.Color := clBlack;
      Page.Objects.Add(Atrib);

      Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
      Atrib.SetBounds(15, 571, 728, 0);
      Atrib.FrameTyp := 2;
      Page.Objects.Add(Atrib);
    end;
  end;

  procedure Rodape;
  Var
    I: Integer;
  begin
    faixa := TfrBandView(frCreateObject(gtBand, ''));   // Resumo
    faixa.SetBounds(0, 976, 752, 35);
    faixa.BandType := btReportSummary;
    faixa.Dataset := 'frDataSet';
    Page.Objects.Add(faixa);

    if Totalizar then
    begin
      for I:=0 to LSomatoria.Count-1 do
      begin
        Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
        Atrib.SetBounds(StrToInt(Copy(LPosicao[I],01,05)), 977, StrToInt(Copy(LPosicao[I],11,05)), StrToInt(Copy(LPosicao[I],16,11)));
        Atrib.Memo.Add(LSomatoria[I]);
        Atrib.Font.Name  := 'Arial';
        Atrib.Font.Size  := 08;
        Atrib.Font.Style := [];
        Atrib.Font.Color := clBlack;
        Atrib.Adjust := (Atrib.Adjust and $FC) + 1;
        Atrib.Format := (Atrib.Format and $F0FFFFFF) + 1 * $01000000;
        Atrib.Format := (Atrib.Format and $FF00FFFF) + 4 * $00010000;
        Atrib.FormatStr:= LMascara[I];
        Page.Objects.Add(Atrib);
      end;
    end;
    if Quantificar then
    begin
      Atrib := TfrMemoView(frCreateObject(gtMemo, ''));
      Atrib.SetBounds(16, 994, 190, 16);
      Atrib.Memo.Add('** Listado(s): [Count(TabGlobal.'+TabelaPrincipal.Name+')] Registro(s)');
      Atrib.Font.Name  := 'Arial';
      Atrib.Font.Size  := 08;
      Atrib.Font.Style := [];
      Atrib.Font.Color := clBlack;
      Page.Objects.Add(Atrib);
    end;
  end;

begin
  if ProcuraRestricao(TabelaPrincipal.NomeTabela,'L') then
  begin
    MessageDlg('Impressão não Permitida !',mtError,[mbOk],0);
    exit;
  end;
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  try
    frDataSet  := TfrDBDataSet.Create(Formulario);
    frImpressao:= TfrReport.Create(Formulario);
    LSomatoria := TStringList.Create;
    LSomatoriaGroup := TStringList.Create;
    LMascara   := TStringList.Create;
    LPosicao   := TStringList.Create;
    frDataSet.DataSource := DataSource;
    frImpressao.Dataset  := frDataSet;
    TabelaPrincipal.DisableControls;
    frImpressao.Pages.Clear;
    frImpressao.Pages.Add;
    Page := frImpressao.Pages[0];

    Quantificar := False; Totalizar   := False;
    Sintetizar  := False; Quebra      := False;
    SubTotalizar:= False; EditorR     := False;
    TitRel      := TForm(Formulario).Caption;
    ConfiguraRel;

    if Ok then
    begin
      Cabecalho;
      ColunasRelatorio;
      if Quebra then
        Quebras;
      if Quantificar or Totalizar then
        Rodape;
      if EditorR then
        frImpressao.DesignReport
      else
        frImpressao.ShowReport;
    end;
  finally
    frDataSet.Free;
    frImpressao.Free;
    LSomatoria.Free;
    LSomatoriaGroup.Free;
    LMascara.Free;
    LPosicao.Free;
    TabelaPrincipal.EnableControls;
  end;
end;

procedure Ed_SalvarConsulta(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid; Var AbaConsulta: TTabSet;
  Var ConsultasSalvas: TList);
Var
  ret: Boolean;
  SLine: String;
  CmpConsulta,Titulo: String;
  I: Integer;
begin
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  ret:=InputQuery('Salvar Consulta','Informe o título da consulta',SLine);
  if (ret) and (Trim(Sline) <> '') then
  begin
    AbaConsulta.Tabs.Add(SLine);
    CmpConsulta := '';
    for I:=0 to GridConsulta.Columns.Count-1 do
      if GridConsulta.Columns.Items[I].Visible then
        CmpConsulta := CmpConsulta + GridConsulta.Columns.Items[I].Field.FullName + ';';
    if Trim(CmpConsulta) <> '' then
      CmpConsulta := Copy(CmpConsulta,01,Length(CmpConsulta)-1);
    ConsultasSalvas.Add(TConsultasSalvas.Create(TabelaPrincipal.Filtro.Text,TabelaPrincipal.TituloIndice,TabelaPrincipal.ChaveIndice,CmpConsulta));
    AbaConsulta.TabIndex := AbaConsulta.Tabs.Count - 1;
  end;
  SalvaConsultasEmDisco(TabelaPrincipal, ConsultasSalvas, AbaConsulta);
end;

procedure SalvaConsultasEmDisco(TabelaPrincipal: TTabela; Var ConsultasSalvas: TList; AbaConsulta: TTabSet);
Var
  Cons: TConsultasSalvas;
  I,Y,Cont: Integer;
  ArqIni: TIniFile;
  LnFiltro: String;
begin
  DeleteFile(Sistema.Pasta + Sistema.Usuario + '_' + TabelaPrincipal.NomeTabela + '.Dat');
  ArqIni := TIniFile.Create(Sistema.Pasta + Sistema.Usuario + '_' + TabelaPrincipal.NomeTabela + '.Dat');
  for I := 0 to ConsultasSalvas.Count - 1 do
  begin
    Cons := TConsultasSalvas(ConsultasSalvas[I]);
    ArqIni.WriteString(IntToStr(I), 'Titulo', AbaConsulta.Tabs[I + 1]);
    Cont     := 0;
    LnFiltro := '';
    if Trim(Cons.CsFiltro) <> '' then
      for Y := 0 to Length(Cons.CsFiltro) do
      begin
        if (Cons.CsFiltro[Y] <> #10) and (Cons.CsFiltro[Y] <> #0) then
        begin
          if Cons.CsFiltro[Y] = #13 then
          begin
            ArqIni.WriteString(IntToStr(I), 'Filtro.'+IntToStr(Cont), LnFiltro);
            Inc(Cont);
            LnFiltro := '';
          end
          else
            LnFiltro := LnFiltro + Cons.CsFiltro[Y];
        end;
      end;
    if Trim(LnFiltro) <> '' then
      ArqIni.WriteString(IntToStr(I), 'Filtro.'+IntToStr(Cont), LnFiltro);
    ArqIni.WriteString(IntToStr(I), 'Titulo_Ord', Cons.CsTitulo);
    ArqIni.WriteString(IntToStr(I), 'Ordenacao', Cons.CsOrdenacao);
    ArqIni.WriteString(IntToStr(I), 'Campos', Cons.CsCampos);
  end;
  ArqIni.Free;
end;

procedure Ed_ExcluirConsulta(TabelaPrincipal: TTabela; Formulario: TForm; GridConsulta: TDBGrid; Var AbaConsulta: TTabSet;
  Var ConsultasSalvas: TList);
Var
  Posicao: Integer;
begin
  if TForm(Formulario).ActiveControl <> GridConsulta then
  begin
    MessageDlg('Consulta não selecionada !',mtInformation,[mbOk],0);
    exit;
  end;
  Posicao := AbaConsulta.TabIndex;
  if Posicao < 1 then
  begin
    MessageDlg('Consulta Principal não pode ser excluida !',mtInformation,[mbOk],0);
    exit;
  end;
  if MessageDlg('Excluir Consulta:'+^M+^M+AbaConsulta.Tabs[AbaConsulta.TabIndex]+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    TConsultasSalvas(ConsultasSalvas[Posicao - 1]).Free;
    ConsultasSalvas.Delete(Posicao - 1);
    AbaConsulta.Tabs.Delete(Posicao);
    AbaConsulta.TabIndex := Posicao - 1;
    SalvaConsultasEmDisco(TabelaPrincipal, ConsultasSalvas, AbaConsulta);
  end;
end;

function CalculaTamanho(Campo: TAtributo): Word;
var
  I, MaiorDesc, Tam: Integer;
begin
  MaiorDesc := 0;
  for I := 0 to Campo.DescValorValido.Count - 1 do
    if MaiorDesc < Length(Campo.DescValorValido[I]) then
      MaiorDesc := Length(Campo.DescValorValido[I]);
  if Campo.Tamanho < Length(Campo.Mascara) then
    Tam := Length(Campo.Mascara)
  else
    Tam := Campo.Tamanho;
  if Tam < MaiorDesc then
    Result := MaiorDesc
  else
    Result := Tam;
end;

procedure AjustaColunasConsulta(TabelaPrincipal: TTabela);
Var
  I: Integer;
  Campo: TAtributo;
begin
  for I := 0 to TabelaPrincipal.Campos.Count - 1 do
  begin
    Campo := TAtributo(TabelaPrincipal.Campos[I]);
    Campo.Valor.DisplayWidth := CalculaTamanho(Campo);
  end;
end;

procedure InicializaConsultasSalvas(TabelaPrincipal: TTabela; Var AbaConsulta: TTabSet; Var ConsultasSalvas: TList);
Var
  ArqIni: TIniFile;
  I,Y: Integer;
  Titulo,LFiltro,LTitulo,LOrdenacao,LCampos: String;
begin
  ArqIni := TIniFile.Create(Sistema.Pasta + Sistema.Usuario + '_' + TabelaPrincipal.NomeTabela + '.Dat');
  I      := 0;
  Titulo := Trim(ArqIni.ReadString(IntToStr(I), 'Titulo', ''));
  while Titulo <> '' do
  begin
    AbaConsulta.Tabs.Add(Titulo);
    Titulo := Trim(ArqIni.ReadString(IntToStr(I), 'Filtro.0', ''));
    Y      := 0;
    LFiltro:= '';
    while Titulo <> '' do
    begin
      LFiltro  := LFiltro + Titulo + #13+#10;
      Inc(Y);
      Titulo   := Trim(ArqIni.ReadString(IntToStr(I), 'Filtro.'+IntToStr(Y), ''));
    end;
    LTitulo    := ArqIni.ReadString(IntToStr(I), 'Titulo_Ord', '');
    LOrdenacao := ArqIni.ReadString(IntToStr(I), 'Ordenacao', '');
    LCampos    := ArqIni.ReadString(IntToStr(I), 'Campos', '');
    ConsultasSalvas.Add(TConsultasSalvas.Create(LFiltro,LTitulo,LOrdenacao,LCampos));
    Inc(I);
    Titulo := Trim(ArqIni.ReadString(IntToStr(I), 'Titulo', ''));
  end;
  ArqIni.Free;
end;

procedure Ed_AbaConsulta(TabelaPrincipal: TTabela; Var AbaConsulta: TTabSet; Var ConsultasSalvas: TList; GridConsulta: TDBGrid; AtualizaRegistros: Boolean = True);
Var
  I,Indice: Integer;
  Cons: TConsultasSalvas;
  CsListaCampos: TStringList;
  Campo: TField;
begin
  if AbaConsulta.TabIndex = 0 then
  begin
    if AtualizaRegistros then
    begin
      TabelaPrincipal.Filtro.Clear;
      TabelaPrincipal.TituloIndice := TabelaPrincipal.TituloPrimaria;
      TabelaPrincipal.ChaveIndice  := TabelaPrincipal.ChPrimaria;
    end;
    for I:=0 to TabelaPrincipal.Campos.Count-1 do
    begin
      Campo := TabelaPrincipal.FindField(TAtributo(TabelaPrincipal.Campos[I]).Nome);
      if Campo <> nil then
      begin
        Campo.Visible      := TAtributo(TabelaPrincipal.Campos[I]).Visible_Default;
        Campo.Index        := TAtributo(TabelaPrincipal.Campos[I]).Index_Default;
        Campo.DisplayWidth := CalculaTamanho(TabelaPrincipal.Campos[I]);
      end;
    end;
    AjustaColunasConsulta(TabelaPrincipal);
  end
  else
  begin
    Cons := TConsultasSalvas(ConsultasSalvas.Items[AbaConsulta.TabIndex-1]);
    if AtualizaRegistros then
    begin
      if Trim(Cons.CsFiltro) <> '' then
        TabelaPrincipal.Filtro.Text   := Cons.CsFiltro
      else
        TabelaPrincipal.Filtro.Text   := '';
      TabelaPrincipal.TituloIndice := Cons.CsTitulo;
      TabelaPrincipal.ChaveIndice  := Cons.CsOrdenacao;
    end;
    CsListaCampos := TStringList.Create;
    StringToArray(Cons.CsCampos,';',CsListaCampos);
    GridConsulta.Columns.Clear;
    for I:=0 to TabelaPrincipal.Fields.Count-1 do
    begin
      Campo := TabelaPrincipal.FindField(TabelaPrincipal.Fields[I].FullName);
      if Campo <> nil then
        Campo.Visible := False;
    end;
    Indice := 0;
    for I:=0 to CsListaCampos.Count-1 do
    begin
      Campo := TabelaPrincipal.FindField(CsListaCampos[I]);
      if Campo <> nil then
      begin
        Campo.Visible      := True;
        Campo.Index        := Indice;
        Inc(Indice);
      end;
    end;
    CsListaCampos.Free;
    AjustaColunasConsulta(TabelaPrincipal);
  end;
  if AtualizaRegistros then
    TabelaPrincipal.AtualizaSql;
end;

procedure AtribuiDataSourceCampos(ListaCamposEd: TListaCampos; EdDataSource: TDataSource);
Var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Controle is TXDBEdit then
      with TXDBEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TXDBNumEdit then
      with TXDBNumEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TRxDBCalcEdit then
      with TRxDBCalcEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TXDBDateEdit then
      with TXDBDateEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBDateEdit then
      with TDBDateEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBMemo then
      with TDBMemo(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBRichEdit then
      with TDBRichEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TRxDBRichEdit then
      with TRxDBRichEdit(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBImage then
      with TDBImage(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TXDBLookUp then
      with TXDBLookUp(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBComboBox then
      with TDBComboBox(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBRadioGroup then
      with TDBRadioGroup(CampoED.Controle) do
        DataSource := EdDataSource
    else if CampoED.Controle is TDBCheckBox then
      with TDBCheckBox(CampoED.Controle) do
        DataSource := EdDataSource
  end;
end;

procedure HabilitaCamposEdicao(ListaCamposEd: TListaCampos; Habilita: Boolean = True);
Var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Controle is TXDBEdit then
      with TXDBEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TXDBNumEdit then
      with TXDBNumEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TRxDBCalcEdit then
      with TRxDBCalcEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TXDBDateEdit then
      with TXDBDateEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBDateEdit then
      with TDBDateEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBMemo then
      with TDBMemo(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBRichEdit then
      with TDBRichEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TRxDBRichEdit then
      with TRxDBRichEdit(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBImage then
      with TDBImage(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TXDBLookUp then
      with TXDBLookUp(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBComboBox then
      with TDBComboBox(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBRadioGroup then
      with TDBRadioGroup(CampoED.Controle) do
        Enabled := Habilita
    else if CampoED.Controle is TDBCheckBox then
      with TDBCheckBox(CampoED.Controle) do
        Enabled := Habilita
  end;
end;

procedure CamposEdicaoReadOnly(ListaCamposEd: TListaCampos; Habilita: Boolean = True);
Var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Controle is TXDBEdit then
      with TXDBEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TXDBNumEdit then
      with TXDBNumEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TRxDBCalcEdit then
      with TRxDBCalcEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TXDBDateEdit then
      with TXDBDateEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBDateEdit then
      with TDBDateEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBMemo then
      with TDBMemo(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBRichEdit then
      with TDBRichEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TRxDBRichEdit then
      with TRxDBRichEdit(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBImage then
      with TDBImage(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TXDBLookUp then
      with TXDBLookUp(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBComboBox then
      with TDBComboBox(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBRadioGroup then
      with TDBRadioGroup(CampoED.Controle) do
        ReadOnly := Habilita
    else if CampoED.Controle is TDBCheckBox then
      with TDBCheckBox(CampoED.Controle) do
        ReadOnly := Habilita
  end;
end;

procedure HabilitaCamposChave(ListaCamposEd: TListaCampos);
Var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Pagina = -1 then
    begin
      CampoED.Controle.TabStop := True;
      if CampoED.Controle is TXDBEdit then
        with TXDBEdit(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TXDBNumEdit then
        with TXDBNumEdit(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TXDBDateEdit then
        with TXDBDateEdit(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TDBDateEdit then
        with TDBDateEdit(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TXDBLookUp then
        with TXDBLookUp(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TDBComboBox then
        with TDBComboBox(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TDBRadioGroup then
        with TDBRadioGroup(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end
      else if CampoED.Controle is TDBCheckBox then
        with TDBCheckBox(CampoED.Controle) do
        begin
          ReadOnly := False;
          Color    := clWindow;
        end;
    end;
  end;
end;

procedure DesabilitaCamposChave(ListaCamposEd: TListaCampos);
Var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Pagina = -1 then
    begin
      CampoED.Controle.TabStop := False;
      if CampoED.Controle is TXDBEdit then
        with TXDBEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TXDBNumEdit then
        with TXDBNumEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TXDBDateEdit then
        with TXDBDateEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBDateEdit then
        with TDBDateEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TXDBLookUp then
        with TXDBLookUp(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBComboBox then
        with TDBComboBox(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBRadioGroup then
        with TDBRadioGroup(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBCheckBox then
        with TDBCheckBox(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end;
    end;
  end;
end;

procedure DesabilitaCamposChave_Rel(ListaCamposEd: TListaCampos; Lista_Rel: TStringList);
Var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I:=0 to ListaCamposED.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if (CampoED.Pagina = -1) and (Lista_Rel.IndexOf(CampoED.Campo.Nome) > -1) then
    begin
      CampoED.Controle.TabStop := False;
      if CampoED.Controle is TXDBEdit then
        with TXDBEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TXDBNumEdit then
        with TXDBNumEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
          ShowButton := False;
        end
      else if CampoED.Controle is TXDBDateEdit then
        with TXDBDateEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
          ShowButton := False;
        end
      else if CampoED.Controle is TDBDateEdit then
        with TDBDateEdit(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TXDBLookUp then
        with TXDBLookUp(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBComboBox then
        with TDBComboBox(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBRadioGroup then
        with TDBRadioGroup(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end
      else if CampoED.Controle is TDBCheckBox then
        with TDBCheckBox(CampoED.Controle) do
        begin
          ReadOnly := True;
          Color    := clBtnFace;
        end;
    end;
  end;
end;

procedure AtribuiValores_Mestre(TabelaPrincipal: TTabela; ListaCamposEd: TListaCampos);
var
  I: Integer;
begin
  if Trim(TabelaPrincipal.FiltroRelac.Text) <> '' then // Atribui valores da tabela de relacionamento
  begin                                                // Mestre.
    for I:=0 to TabelaPrincipal.CamposRelac.Count-1 do
      TabelaPrincipal.Fields.FieldByName(TabelaPrincipal.CamposRelac[I]).AsVariant := TabelaPrincipal.ValoresRelac[I];
    DesabilitaCamposChave_Rel(ListaCamposEd, TabelaPrincipal.CamposRelac);
  end;
end;

procedure LiberaCamposPagina(Pagina: Integer; ListaCamposEd: TListaCampos);
var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I := 0 to ListaCamposED.Count - 1 do
  begin
    CampoED := TCampoEdicao(ListaCamposED[I]);
    if CampoED.Pagina = Pagina then
    begin
    end;
  end;
end;

function CamposDadosValidos(ListaCamposEd: TListaCampos; Var ErroValidacao: Boolean): Boolean;
var
  I: Integer;
  Campo: TCampoEdicao;
begin
  ErroValidacao := False;
  Result := True;
  for I := 0 to ListaCamposED.Count - 1 do
  begin
    Campo := TCampoEdicao(ListaCamposED[I]);
    if Assigned(Campo.Validacao) and  // (Campo.Pagina <> -1) and
       (Campo.Controle.Enabled) and (Campo.Controle.Visible) then
    begin
      Campo.Validacao(Campo.Controle);
      if ErroValidacao then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

function RetornaAutoIncremento(TabelaPrincipal: TTabela; Campo: String; Condicao: String; Qtd: Integer = 1; Consultar: Boolean = False; SempreAtribui: Boolean = False): Variant;
Var
  Query: TTabela;
begin
  Sistema.Conexao_i := Time;
  if (Trim(Condicao) = '')
     {$IFDEF XSQL}and (TabelaPrincipal.Database.ServerType in [stInterbase, stFirebird]){$ENDIF} then
  begin
    if Consultar then
      RetornaAutoIncremento := TabelaPrincipal.AutoIncremento(Campo, False, 0) + qtd
    else
    begin
      if not SempreAtribui then
        RetornaAutoIncremento := TabelaPrincipal.AutoIncremento(Campo, False, Qtd);
    end;
  end
  else
  begin
    Query := TTabela.Create(Application);
    with Query do
    begin
      DataBase     := TabelaPrincipal.DataBase;
      Transaction  := TabelaPrincipal.Transaction;
      {$IFDEF XSQL}
      DatabaseName := TabelaPrincipal.DatabaseName;
      {$ENDIF}
      SQL.Clear;
      SQL.Add('Select MAX('+Campo+')');
      SQL.Add('From '+TabelaPrincipal.NomeTabela);
      if Trim(Condicao) <> '' then
        SQL.Add(' Where '+Condicao);
      Conexao;
      Active := True;
      First;
      case Fields[0].DataType of
        ftSmallint, ftWord, ftInteger:
          RetornaAutoIncremento := Fields[0].AsInteger + Qtd;
        ftFloat, ftCurrency:
          RetornaAutoIncremento := Fields[0].AsFloat + Qtd;
        ftDate, ftDateTime:
          RetornaAutoIncremento := Fields[0].AsDateTime + Qtd;
      end;
      Active := False;
      Free;
    end;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

procedure AtribuiAutoIncremento(TabelaPrincipal: TTabela; Campo: String;
  Componente: TComponent; Condicao: String; Editavel: Boolean);
Var
  Query: TTabela;
begin
  if not TabelaPrincipal.Inclusao then
    exit;
  Sistema.Conexao_i := Time;
  if (Trim(Condicao) = '')
    {$IFDEF XSQL}and (TabelaPrincipal.Database.ServerType in [stInterbase, stFirebird]){$ENDIF} then
    TabelaPrincipal.AutoIncremento(Campo, True, 1)
  else
  begin
    Query := TTabela.Create(Application);
    with Query do
    begin
      DataBase := TabelaPrincipal.DataBase;
      Transaction := TabelaPrincipal.Transaction;
      SQL.Clear;
      SQL.Add('Select MAX('+Campo+')');
      SQL.Add(' From '+TabelaPrincipal.NomeTabela);
      if Trim(Condicao) <> '' then
        SQL.Add(' Where '+Condicao);
      Conexao;
      Active := True;
      First;
      case Fields[0].DataType of
        ftSmallint, ftWord, ftInteger:
          TabelaPrincipal.FieldByName(Campo).AsInteger := Fields[0].AsInteger + 01;
        ftFloat, ftCurrency:
          TabelaPrincipal.FieldByName(Campo).AsFloat := Fields[0].AsFloat + 01;
        ftDate, ftDateTime:
          TabelaPrincipal.FieldByName(Campo).AsDateTime := Fields[0].AsDateTime + 01;
      end;
      Active := False;
      Free;
    end;
  end;
  if Componente is TXDBNumEdit then
  begin
    TXDBNumEdit(Componente).Refresh;
    TXDBNumEdit(Componente).SelectAll;
    if not Editavel then
    begin
      TXDBNumEdit(Componente).ReadOnly := True;         // Desabilita edição do Campo
      TXDBNumEdit(Componente).Color    := clBtnFace;
      TXDBNumEdit(Componente).TabStop  := False;
    end;
  end
  else if Componente is TXDBDateEdit then
  begin
    TXDBDateEdit(Componente).Refresh;
    TXDBDateEdit(Componente).SelectAll;
    if not Editavel then
    begin
      TXDBDateEdit(Componente).ReadOnly := True;         // Desabilita edição do Campo
      TXDBDateEdit(Componente).Color    := clBtnFace;
      TXDBDateEdit(Componente).TabStop  := False;
    end;
  end
  else if Componente is TDBDateEdit then
  begin
    TDBDateEdit(Componente).Refresh;
    TDBDateEdit(Componente).SelectAll;
    if not Editavel then
    begin
      TDBDateEdit(Componente).ReadOnly := True;         // Desabilita edição do Campo
      TDBDateEdit(Componente).Color    := clBtnFace;
      TDBDateEdit(Componente).TabStop  := False;
    end;
  end;
  sistema.Conexao_f := Time;
  Atualiza_Status;
end;

procedure ExecutaPreValidacoes(TabelaPrincipal: TTabela; Formulario: TForm; ListaCamposEd: TListaCampos; ValoresPadrao: Boolean = False; SalvarRegistro: Boolean = False);
var
  I, Y: Integer;
  CampoED: TCampoEdicao;
  Valido: Boolean;
  Cor: TColor;
  Comp_Titulo: TComponent;
  Condicao, NomeControl: String;
  Atributo: TAtributo;
  RCampo: Variant;
  AtControl: TWinControl;

  function FindCurControl(Form: TForm; CurControl: TWinControl): TWinControl;
  var
    W, StartIndex: Integer;
    List: TList;
  begin
    Result := nil;
    List := TList.Create;
    try
      Form.GetTabOrderList(List);
      if Assigned(CurControl) and (List.Count > 0) then
      begin
        StartIndex := List.IndexOf(CurControl);
        if StartIndex = -1 then
          StartIndex := 0;
        W := StartIndex;
        repeat
          if W = 0 then W := List.Count;
          Dec(W);
          if W > -1 then
            CurControl := List[W];
          if CurControl.CanFocus and
            (CurControl.TabStop) then
            Result := CurControl;
        until (Result <> nil) or (W = StartIndex);
      end;
    finally
      List.Free;
    end;
  end;

begin
  if (ValoresPadrao) and (Formulario.FormStyle <> fsMDIChild) then
    TabelaPrincipal.AtribuiMestre(TabelaPrincipal);
  if (TabelaPrincipal.Inclusao) or (TabelaPrincipal.Modificacao) then
    TabelaPrincipal.CalculaCampos;
  AtControl := FindCurControl(Formulario, Formulario.ActiveControl);
  if Assigned(AtControl) then
    NomeControl := AtControl.Name
  else
    NomeControl := '';
  for I:=0 to ListaCamposEd.Count-1 do
  begin
    CampoED := TCampoEdicao(ListaCamposEd[I]);
    if (CampoED.Campo.AutoIncremento <> 0) and (not CampoED.Campo.Extra) then // Atribui autoincremento
      if (TabelaPrincipal.Inclusao) and ((CampoED.Campo.Tipo = tpInteiro) or
         (CampoED.Campo.Tipo = tpFracionario) or (CampoED.Campo.Tipo = tpData)) then
        if (ValoresPadrao) or (CampoED.Campo.SempreAtribui) then
        begin
          Condicao := '';
          if (CampoED.Pagina = -1) then // chave primária
          begin
            for Y:=0 to TabelaPrincipal.ChavePrimaria.Count-1 do
            begin
              Atributo := TAtributo(TabelaPrincipal.ChavePrimaria[Y]);
              if Atributo.Nome = CampoED.Campo.Nome then
                break
              else
                case Atributo.Valor.DataType of
                  ftSmallint, ftWord, ftInteger:
                    Condicao := Condicao + Atributo.Nome + ' = ' +IntToStr(Atributo.Valor.AsInteger) + ' AND ';
                  ftFloat, ftCurrency:
                    Condicao := Condicao + Atributo.Nome + ' = ' +FracToStr(Atributo.Valor.AsFloat) + ' AND ';
                  ftDate, ftDateTime:
                    Condicao := Condicao + Atributo.Nome + ' = ' +#39+ DataSql(Atributo.Valor.AsDateTime) +#39+ ' AND ';
                  else
                    Condicao := Condicao + Atributo.Nome + ' = ' +#39+ Atributo.Valor.AsString +#39+ ' AND ';
                end;
            end;
            if Copy(Condicao,Length(Condicao)-4,5) = ' AND ' then // sequência por chave ...
              Condicao := Copy(Condicao,01,Length(Condicao)-5);
          end;
          if (ValoresPadrao) or ((CampoED.Campo.SempreAtribui) and (SalvarRegistro)) or (Trim(Condicao) <> '') then
            CampoED.Campo.Valor.AsVariant := RetornaAutoIncremento(TabelaPrincipal,CampoED.Campo.Nome,Condicao,CampoED.Campo.AutoIncremento,(ValoresPadrao) and (Trim(Condicao) = '') and CampoED.Campo.SempreAtribui, CampoED.Campo.SempreAtribui);
        end;
    if (CampoED.Campo.PreValidacao_ativa) and (not CampoED.Campo.Extra) then
    begin
      Valido  := CampoED.Campo.PreValidacao;
      if Valido then
        Cor := clWindow
      else
        Cor := clBtnFace;
      case CampoED.Campo.Acao of
        1: begin   // invisível
             CampoED.Controle.Visible := Valido;
             Comp_Titulo := TForm(Formulario).FindComponent('Lbc'+CampoED.Controle.Name);
             if Comp_Titulo is TLabel then
               TLabel(Comp_Titulo).Visible := Valido;
           end;
        2: begin   // não editável
            if CampoED.Controle is TXDBEdit then
              with TXDBEdit(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TXDBNumEdit then
              with TXDBNumEdit(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TRxDBCalcEdit then
              with TRxDBCalcEdit(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TXDBDateEdit then
              with TXDBDateEdit(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TDBDateEdit then
              with TDBDateEdit(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TDBDateEdit then
              with TDBDateEdit(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TXDBLookUp then
              with TXDBLookUp(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TDBComboBox then
              with TDBComboBox(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
                Color    := Cor;
              end
            else if CampoED.Controle is TDBRadioGroup then
              with TDBRadioGroup(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
              end
            else if CampoED.Controle is TDBCheckBox then
              with TDBCheckBox(CampoED.Controle) do
              begin
                ReadOnly := not Valido;
                TabStop  := Valido;
              end;
           end;
      end;
      if (not Valido) and (CampoED.Campo.LimparCampo) then // limpar campo
        if (TabelaPrincipal.Inclusao) or (TabelaPrincipal.Modificacao) then
          CampoED.Campo.Clear;
    end;
    if CampoED.Campo.Extra then  // Atualiza campo extra
      if (TabelaPrincipal.Inclusao) or (TabelaPrincipal.Modificacao) then
        if TabelaPrincipal.PesquisaRelacionados(CampoED.Campo.NomeTabela,CampoED.Campo.NomeOriginal,RCampo,NomeControl) then
          if RCampo[0] <> Null then
            CampoED.Campo.Valor.AsVariant := RCampo[0];
  end;
  if Assigned(Formulario.ActiveControl) then
    Formulario.HelpFile := Formulario.ActiveControl.Name;
end;

procedure ExecutaPreValidacoesGrid(Tabela: TTabela);
var
  I, Y: Integer;
  CampoED: TAtributo;
  Valido: Boolean;
  Condicao: String;
  Atributo: TAtributo;
  RCampo: Variant;
  Chaves: TStringList;
begin
  if (Tabela.State = dsInsert) or (Tabela.State = dsEdit) then
    Tabela.CalculaCampos;
  for I:=0 to Tabela.Campos.Count-1 do
  begin
    CampoED := TAtributo(Tabela.Campos[I]);
    if (CampoED.AutoIncremento <> 0) and (not CampoED.Extra) then // Atribui autoincremento
      if (Tabela.State = dsInsert) and ((CampoED.Tipo = tpInteiro) or
         (CampoED.Tipo = tpFracionario) or (CampoED.Tipo = tpData)) then
        if (CampoED.SempreAtribui) then
        begin
          if (CampoED.Chave) then // chave primária
          begin
            if not CampoED.Valor.ReadOnly then // desabilita chave na modificação
              if Tabela.State <> dsInsert then
                CampoED.Valor.ReadOnly := True;
            Condicao := '';
            for Y:=0 to Tabela.ChavePrimaria.Count-1 do
            begin
              Atributo := TAtributo(Tabela.ChavePrimaria[Y]);
              if Atributo.Nome = CampoED.Nome then
                break
              else
                case Atributo.Valor.DataType of
                  ftSmallint, ftWord, ftInteger:
                    Condicao := Condicao + Atributo.Nome + ' = ' +IntToStr(Atributo.Valor.AsInteger) + ' AND ';
                  ftFloat, ftCurrency:
                    Condicao := Condicao + Atributo.Nome + ' = ' +FracToStr(Atributo.Valor.AsFloat) + ' AND ';
                  ftDate, ftDateTime:
                    Condicao := Condicao + Atributo.Nome + ' = ' +#39+ DataSql(Atributo.Valor.AsDateTime) +#39+ ' AND ';
                  else
                    Condicao := Condicao + Atributo.Nome + ' = ' +#39+ Atributo.Valor.AsString +#39+ ' AND ';
                end;
            end;
            if Copy(Condicao,Length(Condicao)-4,5) = ' AND ' then // sequência por chave ...
              Condicao := Copy(Condicao,01,Length(Condicao)-5);
          end;
          CampoED.Valor.AsVariant := RetornaAutoIncremento(Tabela,CampoED.Nome,Condicao,CampoED.AutoIncremento, False, CampoED.SempreAtribui);
        end;
    if (CampoED.PreValidacao_ativa) and (not CampoED.Extra) then
    begin
      Valido  := CampoED.PreValidacao;
      case CampoED.Acao of
        1: begin   // invisível
             CampoED.Valor.Visible := Valido;
           end;
        2: begin   // não editável
            CampoED.Valor.ReadOnly := not Valido;
           end;
      end;
      if (not Valido) and (CampoED.LimparCampo) then // limpar campo
        if (Tabela.State = dsInsert) or (Tabela.State = dsEdit) then
          CampoED.Clear;
    end;
    if CampoED.Extra then  // Atualiza campo extra
      if (Tabela.State = dsInsert) or (Tabela.State = dsEdit) then
        if Tabela.PesquisaRelacionados(CampoED.NomeTabela,CampoED.NomeOriginal,RCampo) then
          if RCampo[0] <> Null then
            CampoED.Valor.AsVariant := RCampo[0];
  end;
end;

function LocalizaTabela(Nome: String): TTabela;
var
  Tabela: TTabela;
  I: Integer;
begin
  Result := Nil;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if (UpperCase(Trim(Tabela.Name)) = UpperCase(Trim('D'+Nome))) or
       (UpperCase(Trim(Tabela.Name)) = UpperCase(Trim(Nome))) then
    begin
      Result := Tabela;
      Break;
    end;
  end;
end;

procedure DBGridZebrado(DBGrid: TDBGrid; const Rect: TRect; Column: TColumn; State: TGridDrawState; Condicao: Boolean; CorLinha: TColor = $00DFDF00; CorSelecao: TColor = clNavy);
begin
  with DBGrid do
    if Condicao then
    begin
      Canvas.Brush.Color := CorLinha;
      Canvas.FillRect(Rect);
      DefaultDrawDataCell(Rect,Column.Field,State);
      if gdFocused in state then
      begin
        Canvas.Brush.Color := CorSelecao;
        Canvas.FillRect(Rect);
        DefaultDrawDataCell(Rect,Column.Field,State);
      end;
    end;
end;

end.
