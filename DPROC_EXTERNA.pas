{
 Classe da tabela: PROC_EXTERNA - Bloco de Comandos
}

unit DPROC_EXTERNA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0017,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDPROC_EXTERNA = class(TTabela)
  public
    NUMERO: TDPROC_EXTERNANUMERO;
    ATIVO: TDPROC_EXTERNAATIVO;
    NOME: TDPROC_EXTERNANOME;
    PARAMETROS: TDPROC_EXTERNAPARAMETROS;
    BLOCO_SQL: TDPROC_EXTERNABLOCO_SQL;
    DESCRICAO: TDPROC_EXTERNADESCRICAO;
    BASE: TDPROC_EXTERNABASE;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDPROC_EXTERNA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'PROC_EXTERNA';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DPROC_EXTERNA';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsPROC_EXTERNA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_PROC_EXTERNA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from PROC_EXTERNA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into PROC_EXTERNA');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  ATIVO,');
    InsertSQL.Add('  BASE,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  PARAMETROS,');
    InsertSQL.Add('  BLOCO_SQL,');
    InsertSQL.Add('  DESCRICAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :ATIVO,');
    InsertSQL.Add('  :BASE,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :PARAMETROS,');
    InsertSQL.Add('  :BLOCO_SQL,');
    InsertSQL.Add('  :DESCRICAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update PROC_EXTERNA');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  ATIVO = :ATIVO,');
    ModifySQL.Add('  BASE = :BASE,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  PARAMETROS = :PARAMETROS,');
    ModifySQL.Add('  BLOCO_SQL = :BLOCO_SQL,');
    ModifySQL.Add('  DESCRICAO = :DESCRICAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  ATIVO,');
    RefreshSQL.Add('  BASE,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  PARAMETROS,');
    RefreshSQL.Add('  BLOCO_SQL,');
    RefreshSQL.Add('  DESCRICAO');
    RefreshSQL.Add('from PROC_EXTERNA');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  ATIVO,');
  SqlPrincipal.Add('  BASE,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  PARAMETROS,');
  SqlPrincipal.Add('  BLOCO_SQL,');
  SqlPrincipal.Add('  DESCRICAO');
  SqlPrincipal.Add('from PROC_EXTERNA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NOME := TDPROC_EXTERNANOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  PARAMETROS := TDPROC_EXTERNAPARAMETROS.Create(AOwner);
  PARAMETROS.Valor.DataSet := Self;
  BLOCO_SQL := TDPROC_EXTERNABLOCO_SQL.Create(AOwner);
  BLOCO_SQL.Valor.DataSet := Self;
  DESCRICAO := TDPROC_EXTERNADESCRICAO.Create(AOwner);
  DESCRICAO.Valor.DataSet := Self;
  BASE := TDPROC_EXTERNABASE.Create(AOwner);
  BASE.Valor.DataSet := Self;
  ATIVO := TDPROC_EXTERNAATIVO.Create(AOwner);
  ATIVO.Valor.DataSet := Self;
  NUMERO := TDPROC_EXTERNANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(ATIVO);
  Campos.Add(BASE);
  Campos.Add(NOME);
  Campos.Add(PARAMETROS);
  Campos.Add(BLOCO_SQL);
  Campos.Add(DESCRICAO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDPROC_EXTERNA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDPROC_EXTERNA.ExclusaoCascata;
begin

end;

end.
