{
 Classe da tabela: USER_NOMES - Tabela de Usuários
}

unit DUSER_NOMES;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0013,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_NOMES = class(TTabela)
  public
    Usuario: TDUSER_NOMES_Usuario;
    Senha: TDUSER_NOMES_Senha;
    Master: TDUSER_NOMES_Master;
    Grupo: TDUSER_NOMES_Grupo;
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

constructor TDUSER_NOMES.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_NOMES';
  Titulo           := 'Tabela de Usuários';
  Name             := 'DUSER_NOMES';
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
  DataSource.Name  := 'DsUSER_NOMES';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_NOMES';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_NOMES');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Usuario = :OLD_Usuario');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_NOMES');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Usuario,');
    InsertSQL.Add('  Senha,');
    InsertSQL.Add('  Master,');
    InsertSQL.Add('  Grupo');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Usuario,');
    InsertSQL.Add('  :Senha,');
    InsertSQL.Add('  :Master,');
    InsertSQL.Add('  :Grupo');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_NOMES');
    ModifySQL.Add('set');
    ModifySQL.Add('  Usuario = :Usuario,');
    ModifySQL.Add('  Senha = :Senha,');
    ModifySQL.Add('  Master = :Master,');
    ModifySQL.Add('  Grupo = :Grupo');
    ModifySQL.Add('where');
    ModifySQL.Add('  Usuario = :OLD_Usuario');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_NOMES.Usuario AS Usuario,');
    RefreshSQL.Add('  USER_NOMES.Senha AS Senha,');
    RefreshSQL.Add('  USER_NOMES.Master AS Master,');
    RefreshSQL.Add('  USER_NOMES.Grupo AS Grupo');
    RefreshSQL.Add('from USER_NOMES');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_NOMES.Usuario = :OLD_Usuario');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_NOMES.Usuario AS Usuario,');
  SqlPrincipal.Add('  USER_NOMES.Senha AS Senha,');
  SqlPrincipal.Add('  USER_NOMES.Master AS Master,');
  SqlPrincipal.Add('  USER_NOMES.Grupo AS Grupo');
  SqlPrincipal.Add('from USER_NOMES');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by USER_NOMES.Usuario');
  Usuario := TDUSER_NOMES_Usuario.Create(AOwner);
  Usuario.Valor.DataSet := Self;
  Senha := TDUSER_NOMES_Senha.Create(AOwner);
  Senha.Valor.DataSet := Self;
  Master := TDUSER_NOMES_Master.Create(AOwner);
  Master.Valor.DataSet := Self;
  Grupo := TDUSER_NOMES_Grupo.Create(AOwner);
  Grupo.Valor.DataSet := Self;
  ChavePrimaria.Add(Usuario);
  Campos.Add(Usuario);
  Campos.Add(Senha);
  Campos.Add(Master);
  Campos.Add(Grupo);
  TituloIndices.Add('Usuário');
  Indices.Add('USER_NOMES.Usuario');
  Crescente.Add('S');
  TituloPrimaria := 'Usuário';
  ChPrimaria     := 'USER_NOMES.Usuario';
  TituloIndice   := 'Usuário';
  ChaveIndice    := 'USER_NOMES.Usuario';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_NOMES.CriaForeignKeys;
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

function TDUSER_NOMES.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDUSER_NOMES.ExclusaoCascata;
begin
end;

function TDUSER_NOMES.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_NOMES.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_NOMES') then
    if PTabela(TabGlobal.DUSER_NOMES, ['Usuario'], [Usuario.Valor.Value]) then
      Result := True;
end;

procedure TDUSER_NOMES.CalculaCampos;
begin
end;

procedure TDUSER_NOMES.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDUSER_NOMES.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDUSER_NOMES.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDUSER_NOMES.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDUSER_NOMES.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDUSER_NOMES.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (Usuario.SempreAtribui) and (Usuario.AutoIncremento > 0) then
      AutoIncremento('Usuario', True, Usuario.AutoIncremento);
end;

procedure TDUSER_NOMES.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_NOMES.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_NOMES.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
