{
 Classe da tabela: RESTRITA - Definição de Exclusão Restrita
}

unit DRESTRITA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0009,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDRESTRITA = class(TTabela)
  public
    NUMERO: TDRESTRITANUMERO;
    SEQUENCIA: TDRESTRITASEQUENCIA;
    CODIFICACAO: TDRESTRITACODIFICACAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDRESTRITA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'RESTRITA';
  Titulo           := 'Definição de Exclusão Restrita';
  Name             := 'DRESTRITA';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsRESTRITA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_RESTRITA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from RESTRITA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into RESTRITA');
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
    ModifySQL.Add('update RESTRITA');
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
    RefreshSQL.Add('from RESTRITA');
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
  SqlPrincipal.Add('from RESTRITA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NUMERO := TDRESTRITANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDRESTRITASEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  CODIFICACAO := TDRESTRITACODIFICACAO.Create(AOwner);
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

function TDRESTRITA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDRESTRITA.ExclusaoCascata;
begin

end;

end.
