{
 Classe da tabela: CASCATAT - Definição de Exclusão em Cascata
}

unit DCASCATAT;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0008,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDCASCATAT = class(TTabela)
  public
    NUMERO: TDCASCATATNUMERO;
    SEQUENCIA: TDCASCATATSEQUENCIA;
    CODIFICACAO: TDCASCATATCODIFICACAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDCASCATAT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'CASCATAT';
  Titulo           := 'Definição de Exclusão em Cascata';
  Name             := 'DCASCATAT';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsCASCATAT';
  with UpdateSql do
  begin
    Name           := 'UpdSql_CASCATAT';
    // Exclusão de Registro
    DeleteSQL.Add('delete from CASCATAT');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into CASCATAT');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  CODIFICACAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :CODIFICACAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update CASCATAT');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  CODIFICACAO = :CODIFICACAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  CODIFICACAO');
    RefreshSQL.Add('from CASCATAT');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  CODIFICACAO');
  SqlPrincipal.Add('from CASCATAT');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NUMERO := TDCASCATATNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDCASCATATSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  CODIFICACAO := TDCASCATATCODIFICACAO.Create(AOwner);
  CODIFICACAO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(CODIFICACAO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDCASCATAT.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDCASCATAT.ExclusaoCascata;
begin

end;

end.
