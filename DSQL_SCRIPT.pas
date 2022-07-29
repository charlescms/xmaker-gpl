{
 Classe da tabela: SQL_SCRIPT - Bloco de Comandos
}

unit DSQL_SCRIPT;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0018,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDSQL_SCRIPT = class(TTabela)
  public
    NUMERO: TDSQL_SCRIPTNUMERO;
    EXECUCAO: TDSQL_SCRIPTEXECUCAO;
    NOME: TDSQL_SCRIPTNOME;
    BLOCO_SQL: TDSQL_SCRIPTBLOCO_SQL;
    DESCRICAO: TDSQL_SCRIPTDESCRICAO;
    BASE: TDSQL_SCRIPTBASE;
    PARAMETROS: TDSQL_SCRIPTPARAMETROS;
    ATIVO: TDSQL_SCRIPTATIVO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDSQL_SCRIPT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'SQL_SCRIPT';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DSQL_SCRIPT';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsSQL_SCRIPT';
  with UpdateSql do
  begin
    Name           := 'UpdSql_SQL_SCRIPT';
    // Exclusão de Registro
    DeleteSQL.Add('delete from SQL_SCRIPT');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into SQL_SCRIPT');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  EXECUCAO,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  BLOCO_SQL,');
    InsertSQL.Add('  BASE,');
    InsertSQL.Add('  DESCRICAO,');
    InsertSQL.Add('  PARAMETROS,');
    InsertSQL.Add('  ATIVO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :EXECUCAO,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :BLOCO_SQL,');
    InsertSQL.Add('  :BASE,');
    InsertSQL.Add('  :DESCRICAO,');
    InsertSQL.Add('  :PARAMETROS,');
    InsertSQL.Add('  :ATIVO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update SQL_SCRIPT');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  EXECUCAO = :EXECUCAO,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  BLOCO_SQL = :BLOCO_SQL,');
    ModifySQL.Add('  BASE = :BASE,');
    ModifySQL.Add('  DESCRICAO = :DESCRICAO,');
    ModifySQL.Add('  PARAMETROS = :PARAMETROS,');
    ModifySQL.Add('  ATIVO = :ATIVO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  EXECUCAO,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  BLOCO_SQL,');
    RefreshSQL.Add('  BASE,');
    RefreshSQL.Add('  DESCRICAO,');
    RefreshSQL.Add('  PARAMETROS,');
    RefreshSQL.Add('  ATIVO');
    RefreshSQL.Add('from SQL_SCRIPT');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  EXECUCAO,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  BLOCO_SQL,');
  SqlPrincipal.Add('  BASE,');
  SqlPrincipal.Add('  DESCRICAO,');
  SqlPrincipal.Add('  PARAMETROS,');
  SqlPrincipal.Add('  ATIVO');
  SqlPrincipal.Add('from SQL_SCRIPT');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NOME := TDSQL_SCRIPTNOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  BLOCO_SQL := TDSQL_SCRIPTBLOCO_SQL.Create(AOwner);
  BLOCO_SQL.Valor.DataSet := Self;
  DESCRICAO := TDSQL_SCRIPTDESCRICAO.Create(AOwner);
  DESCRICAO.Valor.DataSet := Self;
  EXECUCAO := TDSQL_SCRIPTEXECUCAO.Create(AOwner);
  EXECUCAO.Valor.DataSet := Self;
  BASE := TDSQL_SCRIPTBASE.Create(AOwner);
  BASE.Valor.DataSet := Self;
  PARAMETROS := TDSQL_SCRIPTPARAMETROS.Create(AOwner);
  PARAMETROS.Valor.DataSet := Self;
  ATIVO := TDSQL_SCRIPTATIVO.Create(AOwner);
  ATIVO.Valor.DataSet := Self;
  NUMERO := TDSQL_SCRIPTNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(EXECUCAO);
  Campos.Add(NOME);
  Campos.Add(BLOCO_SQL);
  Campos.Add(DESCRICAO);
  Campos.Add(BASE);
  Campos.Add(PARAMETROS);
  Campos.Add(ATIVO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDSQL_SCRIPT.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDSQL_SCRIPT.ExclusaoCascata;
begin

end;

end.
