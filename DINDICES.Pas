{
 Classe da tabela: INDICES - Definição de Índices Secundários
}

unit DINDICES;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0006,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDINDICES = class(TTabela)
  public
    TITULO_I: TDINDICESTITULO_I;
    CAMPOS: TDINDICESCAMPOS;
    CRESCENTE: TDINDICESCRESCENTE;
    NUMERO: TDINDICESNUMERO;
    SEQUENCIA: TDINDICESSEQUENCIA;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDINDICES.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'INDICES';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DINDICES';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsINDICES';
  with UpdateSql do
  begin
    Name           := 'UpdSql_INDICES';
    // Exclusão de Registro
    DeleteSQL.Add('delete from INDICES');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into INDICES');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  CAMPOS,');
    InsertSQL.Add('  TITULO_I,');
    InsertSQL.Add('  CRESCENTE');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :CAMPOS,');
    InsertSQL.Add('  :TITULO_I,');
    InsertSQL.Add('  :CRESCENTE');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update INDICES');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  CAMPOS = :CAMPOS,');
    ModifySQL.Add('  TITULO_I = :TITULO_I,');
    ModifySQL.Add('  CRESCENTE = :CRESCENTE');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  CAMPOS,');
    RefreshSQL.Add('  TITULO_I,');
    RefreshSQL.Add('  CRESCENTE');
    RefreshSQL.Add('from INDICES');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  CAMPOS,');
  SqlPrincipal.Add('  TITULO_I,');
  SqlPrincipal.Add('  CRESCENTE');
  SqlPrincipal.Add('from INDICES');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  TITULO_I := TDINDICESTITULO_I.Create(AOwner);
  TITULO_I.Valor.DataSet := Self;
  CAMPOS := TDINDICESCAMPOS.Create(AOwner);
  CAMPOS.Valor.DataSet := Self;
  CRESCENTE := TDINDICESCRESCENTE.Create(AOwner);
  CRESCENTE.Valor.DataSet := Self;
  NUMERO := TDINDICESNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDINDICESSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(CAMPOS);
  Campos.Add(TITULO_I);
  Campos.Add(CRESCENTE);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDINDICES.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDINDICES.ExclusaoCascata;
begin

end;

end.
