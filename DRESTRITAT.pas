{
 Classe da tabela: RESTRITAT - Definição de Exclusão Restrita
}

unit DRESTRITAT;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0009,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDRESTRITAT = class(TTabela)
  public
    NUMERO: TDRESTRITATNUMERO;
    SEQUENCIA: TDRESTRITATSEQUENCIA;
    CODIFICACAO: TDRESTRITATCODIFICACAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDRESTRITAT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'RESTRITAT';
  Titulo           := 'Definição de Exclusão Restrita';
  Name             := 'DRESTRITAT';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsRESTRITAT';
  with UpdateSql do
  begin
    Name           := 'UpdSql_RESTRITAT';
    // Exclusão de Registro
    DeleteSQL.Add('delete from RESTRITAT');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into RESTRITAT');
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
    ModifySQL.Add('update RESTRITAT');
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
    RefreshSQL.Add('from RESTRITAT');
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
  SqlPrincipal.Add('from RESTRITAT');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NUMERO := TDRESTRITATNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDRESTRITATSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  CODIFICACAO := TDRESTRITATCODIFICACAO.Create(AOwner);
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

function TDRESTRITAT.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDRESTRITAT.ExclusaoCascata;
begin

end;

end.
