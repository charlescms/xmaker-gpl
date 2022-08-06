{
 Classe da tabela: USER_GRUPOS - Tabela de Grupos
}

unit DUSER_GRUPOS;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0009,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_GRUPOS = class(TTabela)
  public
    Grupo: TDUSER_GRUPOS_Grupo;
    Descricao: TDUSER_GRUPOS_Descricao;
    constructor Create(AOwner: TComponent); override;
    procedure CriaForeignKeys; override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
    function PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean; overload; override;
    function PesquisaRelacionados(Tabela: String): Boolean; overload; override;
    procedure CalculaCampos; override;
    procedure Parametros(Tabela: TTabela); override;
    procedure AtribuiRelacionamentos(Atribui: Boolean = True); override;
    procedure AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True); override;
    procedure AtribuiMestre(DataSet: TDataSet); override;
    procedure ProcessoDireto1(DataSet: TDataSet);
    procedure ProcessoDireto2(DataSet: TDataSet);
    procedure AtualizaCalculados(DataSet: TDataSet);
    procedure ProcessoInverso1(DataSet: TDataSet);
    procedure ProcessoInverso2(DataSet: TDataSet);
  end;

implementation

uses Publicas, Validar, Rotinas, Abertura, Calculos, RotinaEd;

constructor TDUSER_GRUPOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_GRUPOS';
  Titulo           := 'Tabela de Grupos';
  Name             := 'DUSER_GRUPOS';
  Database         := BaseDados.BD_Base_Dados;
  {$IFDEF IBX}
  Transaction      := BaseDados.TRS_BD_Base_Dados;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  {$ELSE}
  RequestLive      := True;
  AutoRefresh      := True;
  CachedUpdates    := True;
  UpdateSql        := TXSQLUpdateSQL.Create(AOwner);
  DatabaseName     := BaseDados.BD_Base_Dados.DatabaseName;
  {$ENDIF}
  Local            := False;
  Open_begin       := False;
  Versao           := 6;
  UsarGenerator    := True;
  TableType        := ttTable;
  DataSource.Name  := 'DsUSER_GRUPOS';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_GRUPOS';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_GRUPOS');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Grupo = :OLD_Grupo');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_GRUPOS');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Grupo,');
    InsertSQL.Add('  Descricao');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Grupo,');
    InsertSQL.Add('  :Descricao');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_GRUPOS');
    ModifySQL.Add('set');
    ModifySQL.Add('  Grupo = :Grupo,');
    ModifySQL.Add('  Descricao = :Descricao');
    ModifySQL.Add('where');
    ModifySQL.Add('  Grupo = :OLD_Grupo');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_GRUPOS.Grupo AS Grupo,');
    RefreshSQL.Add('  USER_GRUPOS.Descricao AS Descricao');
    RefreshSQL.Add('from USER_GRUPOS');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_GRUPOS.Grupo = :OLD_Grupo');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_GRUPOS.Grupo AS Grupo,');
  SqlPrincipal.Add('  USER_GRUPOS.Descricao AS Descricao');
  SqlPrincipal.Add('from USER_GRUPOS');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by USER_GRUPOS.Grupo');
  Grupo := TDUSER_GRUPOS_Grupo.Create(AOwner);
  Grupo.Valor.DataSet := Self;
  Descricao := TDUSER_GRUPOS_Descricao.Create(AOwner);
  Descricao.Valor.DataSet := Self;
  ChavePrimaria.Add(Grupo);
  Campos.Add(Grupo);
  Campos.Add(Descricao);
  TituloIndices.Add('Grupo');
  Indices.Add('USER_GRUPOS.Grupo');
  Crescente.Add('S');
  TituloPrimaria := 'Grupo';
  ChPrimaria     := 'USER_GRUPOS.Grupo';
  TituloIndice   := 'Grupo';
  ChaveIndice    := 'USER_GRUPOS.Grupo';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_GRUPOS.CriaForeignKeys;
var
  Script_ForeignKeys: TSQLScript;
begin
  if ForeignKeys.Count > 0 then
  begin
    Script_ForeignKeys := TSQLScript.Create(Self);
    with Script_ForeignKeys do
    begin
      Database         := BaseDados.BD_Base_Dados;
      {$IFDEF IBX}
      Transaction      := BaseDados.TRS_BD_Base_Dados;
      with Script do
      {$ELSE}
      DatabaseName     := BaseDados.BD_Base_Dados.DatabaseName;
      with SQL do
      {$ENDIF}
      AddStrings(ForeignKeys);
      Executar;
      Free;
    end;
  end;
end;

function TDUSER_GRUPOS.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
  if PTabela(TabGlobal.DUSER_NOMES, ['Grupo'], [Grupo.Valor.Value]) then
  begin
    MessageDlg('Registro está ligado a tabela: '+TabGlobal.DUSER_NOMES.Titulo,mtError,[mbOk],0);
    PodeExcluir := False;
    exit;
  end;
end;

procedure TDUSER_GRUPOS.ExclusaoCascata;
begin
  // Exclusão em Cascata Tabela: DUSER_MENU_LATERAL
  TabGlobal.DUSER_MENU_LATERAL.Filtro.Clear;
  TabGlobal.DUSER_MENU_LATERAL.Filtro.Add('USER_MENU_LATERAL.Grupo = :USER_GRUPOS_Grupo');
  TabGlobal.DUSER_MENU_LATERAL.AtualizaSql;
  while not TabGlobal.DUSER_MENU_LATERAL.Eof do
    if not TabGlobal.DUSER_MENU_LATERAL.Exclui then
      TabGlobal.DUSER_MENU_LATERAL.Next;
  // Exclusão em Cascata Tabela: DUSER_MENU_SUPERIOR
  TabGlobal.DUSER_MENU_SUPERIOR.Filtro.Clear;
  TabGlobal.DUSER_MENU_SUPERIOR.Filtro.Add('USER_MENU_SUPERIOR.Grupo = :USER_GRUPOS_Grupo');
  TabGlobal.DUSER_MENU_SUPERIOR.AtualizaSql;
  while not TabGlobal.DUSER_MENU_SUPERIOR.Eof do
    if not TabGlobal.DUSER_MENU_SUPERIOR.Exclui then
      TabGlobal.DUSER_MENU_SUPERIOR.Next;
  // Exclusão em Cascata Tabela: DUSER_BARRA_F
  TabGlobal.DUSER_BARRA_F.Filtro.Clear;
  TabGlobal.DUSER_BARRA_F.Filtro.Add('USER_BARRA_F.Grupo = :USER_GRUPOS_Grupo');
  TabGlobal.DUSER_BARRA_F.AtualizaSql;
  while not TabGlobal.DUSER_BARRA_F.Eof do
    if not TabGlobal.DUSER_BARRA_F.Exclui then
      TabGlobal.DUSER_BARRA_F.Next;
  // Exclusão em Cascata Tabela: DUSER_TABELAS
  TabGlobal.DUSER_TABELAS.Filtro.Clear;
  TabGlobal.DUSER_TABELAS.Filtro.Add('USER_TABELAS.Grupo = :USER_GRUPOS_Grupo');
  TabGlobal.DUSER_TABELAS.AtualizaSql;
  while not TabGlobal.DUSER_TABELAS.Eof do
    if not TabGlobal.DUSER_TABELAS.Exclui then
      TabGlobal.DUSER_TABELAS.Next;
end;

function TDUSER_GRUPOS.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_GRUPOS.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_GRUPOS') then
    if PTabela(TabGlobal.DUSER_GRUPOS, ['Grupo'], [Grupo.Valor.Value]) then
      Result := True;
end;

procedure TDUSER_GRUPOS.CalculaCampos;
begin
end;

procedure TDUSER_GRUPOS.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
  TabGlobal.DUSER_MENU_LATERAL.AtribuiFiltroMestre(Atribui);
  TabGlobal.DUSER_MENU_SUPERIOR.AtribuiFiltroMestre(Atribui);
  TabGlobal.DUSER_BARRA_F.AtribuiFiltroMestre(Atribui);
  TabGlobal.DUSER_TABELAS.AtribuiFiltroMestre(Atribui);
end;

procedure TDUSER_GRUPOS.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
var
  I: Integer;
begin
  Filtro.Clear;
  FiltroRelac.Clear;
  if Atribui then
  begin
  end
  else
    for I:=0 to Campos.Count-1 do
      TAtributo(Campos[I]).Valor.OnValidate := nil;
  if Atualiza then
    AtualizaSql;
end;

procedure TDUSER_GRUPOS.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDUSER_GRUPOS.ProcessoDireto1(DataSet: TDataSet);
var
  QueryLc: TTabela;
  EmEdicao: Boolean;
begin
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDUSER_GRUPOS.ProcessoDireto2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDUSER_GRUPOS.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (Grupo.SempreAtribui) and (Grupo.AutoIncremento > 0) then
      AutoIncremento('Grupo', True, Grupo.AutoIncremento);
end;

procedure TDUSER_GRUPOS.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_GRUPOS.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_GRUPOS.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
