{
 Classe da tabela: USER_TABELAS - Permissões em Tabelas
}

unit DUSER_TABELAS;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0014,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_TABELAS = class(TTabela)
  public
    Tabela_Obj: TDUSER_TABELAS_Tabela_Obj;
    Grupo: TDUSER_TABELAS_Grupo;
    Cerceado: TDUSER_TABELAS_Cerceado;
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

constructor TDUSER_TABELAS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_TABELAS';
  Titulo           := 'Permissões em Tabelas';
  Name             := 'DUSER_TABELAS';
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
  DataSource.Name  := 'DsUSER_TABELAS';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_TABELAS';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_TABELAS');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Tabela_Obj = :OLD_Tabela_Obj');
    DeleteSQL.Add('  and Grupo = :OLD_Grupo');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_TABELAS');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Tabela_Obj,');
    InsertSQL.Add('  Grupo,');
    InsertSQL.Add('  Cerceado');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Tabela_Obj,');
    InsertSQL.Add('  :Grupo,');
    InsertSQL.Add('  :Cerceado');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_TABELAS');
    ModifySQL.Add('set');
    ModifySQL.Add('  Tabela_Obj = :Tabela_Obj,');
    ModifySQL.Add('  Grupo = :Grupo,');
    ModifySQL.Add('  Cerceado = :Cerceado');
    ModifySQL.Add('where');
    ModifySQL.Add('  Tabela_Obj = :OLD_Tabela_Obj');
    ModifySQL.Add('  and Grupo = :OLD_Grupo');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_TABELAS.Tabela_Obj AS Tabela_Obj,');
    RefreshSQL.Add('  USER_TABELAS.Grupo AS Grupo,');
    RefreshSQL.Add('  USER_TABELAS.Cerceado AS Cerceado');
    RefreshSQL.Add('from USER_TABELAS');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_TABELAS.Tabela_Obj = :OLD_Tabela_Obj');
    RefreshSQL.Add('  and USER_TABELAS.Grupo = :OLD_Grupo');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_TABELAS.Tabela_Obj AS Tabela_Obj,');
  SqlPrincipal.Add('  USER_TABELAS.Grupo AS Grupo,');
  SqlPrincipal.Add('  USER_TABELAS.Cerceado AS Cerceado');
  SqlPrincipal.Add('from USER_TABELAS');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by USER_TABELAS.Tabela_Obj,USER_TABELAS.Grupo');
  Tabela_Obj := TDUSER_TABELAS_Tabela_Obj.Create(AOwner);
  Tabela_Obj.Valor.DataSet := Self;
  Grupo := TDUSER_TABELAS_Grupo.Create(AOwner);
  Grupo.Valor.DataSet := Self;
  Cerceado := TDUSER_TABELAS_Cerceado.Create(AOwner);
  Cerceado.Valor.DataSet := Self;
  ChavePrimaria.Add(Tabela_Obj);
  ChavePrimaria.Add(Grupo);
  Campos.Add(Tabela_Obj);
  Campos.Add(Grupo);
  Campos.Add(Cerceado);
  TituloIndices.Add('Tabela,Grupo');
  Indices.Add('USER_TABELAS.Tabela_Obj,USER_TABELAS.Grupo');
  Crescente.Add('S');
  TituloPrimaria := 'Tabela,Grupo';
  ChPrimaria     := 'USER_TABELAS.Tabela_Obj,USER_TABELAS.Grupo';
  TituloIndice   := 'Tabela,Grupo';
  ChaveIndice    := 'USER_TABELAS.Tabela_Obj,USER_TABELAS.Grupo';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_TABELAS.CriaForeignKeys;
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

function TDUSER_TABELAS.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDUSER_TABELAS.ExclusaoCascata;
begin
end;

function TDUSER_TABELAS.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_TABELAS.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_TABELAS') then
    if PTabela(TabGlobal.DUSER_TABELAS, ['Tabela_Obj','Grupo'], [Tabela_Obj.Valor.Value,Grupo.Valor.Value]) then
      Result := True;
end;

procedure TDUSER_TABELAS.CalculaCampos;
begin
end;

procedure TDUSER_TABELAS.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDUSER_TABELAS.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
var
  I: Integer;
begin
  Filtro.Clear;
  FiltroRelac.Clear;
  if Atribui then
  begin
    FiltroRelac.Add('USER_TABELAS.Grupo = :USER_GRUPOS_Grupo');
  end
  else
    for I:=0 to Campos.Count-1 do
      TAtributo(Campos[I]).Valor.OnValidate := nil;
  Grupo.Valor.ReadOnly := Atribui;
  if Atualiza then
    AtualizaSql;
end;

procedure TDUSER_TABELAS.AtribuiMestre(DataSet: TDataSet);
begin
  Grupo.Valor.Value := TabGlobal.DUSER_GRUPOS.Grupo.Valor.Value;
end;

procedure TDUSER_TABELAS.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDUSER_TABELAS.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDUSER_TABELAS.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (Tabela_Obj.SempreAtribui) and (Tabela_Obj.AutoIncremento > 0) then
      AutoIncremento('Tabela_Obj', True, Tabela_Obj.AutoIncremento);
end;

procedure TDUSER_TABELAS.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_TABELAS.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_TABELAS.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
