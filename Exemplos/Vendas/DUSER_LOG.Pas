{
 Classe da tabela: USER_LOG - Log de Operações
}

unit DUSER_LOG;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0010,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_LOG = class(TTabela)
  public
    Usuario: TDUSER_LOG_Usuario;
    Data: TDUSER_LOG_Data;
    Hora: TDUSER_LOG_Hora;
    Tabela: TDUSER_LOG_Tabela;
    Tipo: TDUSER_LOG_Tipo;
    Comando: TDUSER_LOG_Comando;
    Estacao: TDUSER_LOG_Estacao;
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

constructor TDUSER_LOG.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_LOG';
  Titulo           := 'Log de Operações';
  Name             := 'DUSER_LOG';
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
  DataSource.Name  := 'DsUSER_LOG';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_LOG';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_LOG');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Usuario = :OLD_Usuario');
    DeleteSQL.Add('  and Data = :OLD_Data');
    DeleteSQL.Add('  and Hora = :OLD_Hora');
    DeleteSQL.Add('  and Tabela = :OLD_Tabela');
    DeleteSQL.Add('  and Tipo = :OLD_Tipo');
    DeleteSQL.Add('  and Estacao = :OLD_Estacao');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_LOG');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Usuario,');
    InsertSQL.Add('  Data,');
    InsertSQL.Add('  Hora,');
    InsertSQL.Add('  Tabela,');
    InsertSQL.Add('  Tipo,');
    InsertSQL.Add('  Comando,');
    InsertSQL.Add('  Estacao');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Usuario,');
    InsertSQL.Add('  :Data,');
    InsertSQL.Add('  :Hora,');
    InsertSQL.Add('  :Tabela,');
    InsertSQL.Add('  :Tipo,');
    InsertSQL.Add('  :Comando,');
    InsertSQL.Add('  :Estacao');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_LOG');
    ModifySQL.Add('set');
    ModifySQL.Add('  Usuario = :Usuario,');
    ModifySQL.Add('  Data = :Data,');
    ModifySQL.Add('  Hora = :Hora,');
    ModifySQL.Add('  Tabela = :Tabela,');
    ModifySQL.Add('  Tipo = :Tipo,');
    ModifySQL.Add('  Comando = :Comando,');
    ModifySQL.Add('  Estacao = :Estacao');
    ModifySQL.Add('where');
    ModifySQL.Add('  Usuario = :OLD_Usuario');
    ModifySQL.Add('  and Data = :OLD_Data');
    ModifySQL.Add('  and Hora = :OLD_Hora');
    ModifySQL.Add('  and Tabela = :OLD_Tabela');
    ModifySQL.Add('  and Tipo = :OLD_Tipo');
    ModifySQL.Add('  and Estacao = :OLD_Estacao');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_LOG.Usuario AS Usuario,');
    RefreshSQL.Add('  USER_LOG.Data AS Data,');
    RefreshSQL.Add('  USER_LOG.Hora AS Hora,');
    RefreshSQL.Add('  USER_LOG.Tabela AS Tabela,');
    RefreshSQL.Add('  USER_LOG.Tipo AS Tipo,');
    RefreshSQL.Add('  USER_LOG.Comando AS Comando,');
    RefreshSQL.Add('  USER_LOG.Estacao AS Estacao');
    RefreshSQL.Add('from USER_LOG');
    RefreshSQL.Add('Left Outer Join USER_NOMES on');
    RefreshSQL.Add('  USER_LOG.Usuario = USER_NOMES.Usuario');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_LOG.Usuario = :OLD_Usuario');
    RefreshSQL.Add('  and USER_LOG.Data = :OLD_Data');
    RefreshSQL.Add('  and USER_LOG.Hora = :OLD_Hora');
    RefreshSQL.Add('  and USER_LOG.Tabela = :OLD_Tabela');
    RefreshSQL.Add('  and USER_LOG.Tipo = :OLD_Tipo');
    RefreshSQL.Add('  and USER_LOG.Estacao = :OLD_Estacao');
  end;
  TabelasExtras.Add('USER_NOMES');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_LOG.Usuario AS Usuario,');
  SqlPrincipal.Add('  USER_LOG.Data AS Data,');
  SqlPrincipal.Add('  USER_LOG.Hora AS Hora,');
  SqlPrincipal.Add('  USER_LOG.Tabela AS Tabela,');
  SqlPrincipal.Add('  USER_LOG.Tipo AS Tipo,');
  SqlPrincipal.Add('  USER_LOG.Comando AS Comando,');
  SqlPrincipal.Add('  USER_LOG.Estacao AS Estacao');
  SqlPrincipal.Add('from USER_LOG');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join USER_NOMES on');
  FiltroExtra.Add('  USER_LOG.Usuario = USER_NOMES.Usuario');
  Sql.Add('order by ');
  Usuario := TDUSER_LOG_Usuario.Create(AOwner);
  Usuario.Valor.DataSet := Self;
  Data := TDUSER_LOG_Data.Create(AOwner);
  Data.Valor.DataSet := Self;
  Hora := TDUSER_LOG_Hora.Create(AOwner);
  Hora.Valor.DataSet := Self;
  Tabela := TDUSER_LOG_Tabela.Create(AOwner);
  Tabela.Valor.DataSet := Self;
  Tipo := TDUSER_LOG_Tipo.Create(AOwner);
  Tipo.Valor.DataSet := Self;
  Comando := TDUSER_LOG_Comando.Create(AOwner);
  Comando.Valor.DataSet := Self;
  Estacao := TDUSER_LOG_Estacao.Create(AOwner);
  Estacao.Valor.DataSet := Self;
  Campos.Add(Usuario);
  Campos.Add(Data);
  Campos.Add(Hora);
  Campos.Add(Tabela);
  Campos.Add(Tipo);
  Campos.Add(Comando);
  Campos.Add(Estacao);
  TituloPrimaria := '';
  ChPrimaria     := '';
  TituloIndice   := '';
  ChaveIndice    := '';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_LOG.CriaForeignKeys;
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

function TDUSER_LOG.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDUSER_LOG.ExclusaoCascata;
begin
end;

function TDUSER_LOG.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_LOG.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_NOMES') then
    if PTabela(TabGlobal.DUSER_NOMES, ['Usuario'], [Usuario.Valor.Value]) then
      Result := True;

end;

procedure TDUSER_LOG.CalculaCampos;
begin
end;

procedure TDUSER_LOG.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDUSER_LOG.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDUSER_LOG.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDUSER_LOG.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDUSER_LOG.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDUSER_LOG.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
end;

procedure TDUSER_LOG.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_LOG.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_LOG.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
