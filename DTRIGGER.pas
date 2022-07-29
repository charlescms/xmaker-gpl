{
 Classe da tabela: TRIGGER - Bloco de Comandos
}

unit DTRIGGER;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0016,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDTRIGGER = class(TTabela)
  public
    NUMERO: TDTRIGGERNUMERO;
    SEQUENCIA: TDTRIGGERSEQUENCIA;
    ATIVO: TDTRIGGERATIVO;
    NOME: TDTRIGGERNOME;
    INSTANTE_ATIVACAO: TDTRIGGERINSTANTE_ATIVACAO;
    DISPARAR: TDTRIGGERDISPARAR;
    BLOCO_SQL: TDTRIGGERBLOCO_SQL;
    DESCRICAO: TDTRIGGERDESCRICAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDTRIGGER.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'TRIGGER_I';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DTRIGGER';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsTRIGGER';
  with UpdateSql do
  begin
    Name           := 'UpdSql_TRIGGER';
    // Exclusão de Registro
    DeleteSQL.Add('delete from TRIGGER_I');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into TRIGGER_I');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  ATIVO,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  INSTANTE_ATIVACAO,');
    InsertSQL.Add('  DISPARAR,');
    InsertSQL.Add('  BLOCO_SQL,');
    InsertSQL.Add('  DESCRICAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :ATIVO,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :INSTANTE_ATIVACAO,');
    InsertSQL.Add('  :DISPARAR,');
    InsertSQL.Add('  :BLOCO_SQL,');
    InsertSQL.Add('  :DESCRICAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update TRIGGER_I');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  ATIVO = :ATIVO,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  INSTANTE_ATIVACAO = :INSTANTE_ATIVACAO,');
    ModifySQL.Add('  DISPARAR = :DISPARAR,');
    ModifySQL.Add('  BLOCO_SQL = :BLOCO_SQL,');
    ModifySQL.Add('  DESCRICAO = :DESCRICAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  ATIVO,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  INSTANTE_ATIVACAO,');
    RefreshSQL.Add('  DISPARAR,');
    RefreshSQL.Add('  BLOCO_SQL,');
    RefreshSQL.Add('  DESCRICAO');
    RefreshSQL.Add('from TRIGGER_I');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  ATIVO,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  INSTANTE_ATIVACAO,');
  SqlPrincipal.Add('  DISPARAR,');
  SqlPrincipal.Add('  BLOCO_SQL,');
  SqlPrincipal.Add('  DESCRICAO');
  SqlPrincipal.Add('from TRIGGER_I');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NOME := TDTRIGGERNOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  INSTANTE_ATIVACAO := TDTRIGGERINSTANTE_ATIVACAO.Create(AOwner);
  INSTANTE_ATIVACAO.Valor.DataSet := Self;
  DISPARAR := TDTRIGGERDISPARAR.Create(AOwner);
  DISPARAR.Valor.DataSet := Self;
  BLOCO_SQL := TDTRIGGERBLOCO_SQL.Create(AOwner);
  BLOCO_SQL.Valor.DataSet := Self;
  DESCRICAO := TDTRIGGERDESCRICAO.Create(AOwner);
  DESCRICAO.Valor.DataSet := Self;
  ATIVO := TDTRIGGERATIVO.Create(AOwner);
  ATIVO.Valor.DataSet := Self;
  NUMERO := TDTRIGGERNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDTRIGGERSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(ATIVO);
  Campos.Add(NOME);
  Campos.Add(INSTANTE_ATIVACAO);
  Campos.Add(DISPARAR);
  Campos.Add(BLOCO_SQL);
  Campos.Add(DESCRICAO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDTRIGGER.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDTRIGGER.ExclusaoCascata;
begin

end;

end.
