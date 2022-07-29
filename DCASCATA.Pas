{
 Classe da tabela: CASCATA - Definição de Exclusão em Cascata
}

unit DCASCATA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0008,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDCASCATA = class(TTabela)
  public
    NUMERO: TDCASCATANUMERO;
    SEQUENCIA: TDCASCATASEQUENCIA;
    CODIFICACAO: TDCASCATACODIFICACAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDCASCATA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'CASCATA';
  Titulo           := 'Definição de Exclusão em Cascata';
  Name             := 'DCASCATA';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsCASCATA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_CASCATA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from CASCATA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into CASCATA');
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
    ModifySQL.Add('update CASCATA');
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
    RefreshSQL.Add('from CASCATA');
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
  SqlPrincipal.Add('from CASCATA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NUMERO := TDCASCATANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDCASCATASEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  CODIFICACAO := TDCASCATACODIFICACAO.Create(AOwner);
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

function TDCASCATA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDCASCATA.ExclusaoCascata;
begin

end;

end.
