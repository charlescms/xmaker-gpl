{
 Classe da tabela: CALCULADOS - Definição de Campos Calculados
}

unit DCALCULADOS;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0007,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDCALCULADOS = class(TTabela)
  public
    NUMERO: TDCALCULADOSNUMERO;
    SEQUENCIA: TDCALCULADOSSEQUENCIA;
    VARIAVEIS: TDCALCULADOSVARIAVEIS;
    CODIFICACAO: TDCALCULADOSCODIFICACAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDCALCULADOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'CALCULADOS';
  Titulo           := 'Definição de Campos Calculados';
  Name             := 'DCALCULADOS';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsCALCULADOS';
  with UpdateSql do
  begin
    Name           := 'UpdSql_CALCULADOS';
    // Exclusão de Registro
    DeleteSQL.Add('delete from CALCULADOS');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into CALCULADOS');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  VARIAVEIS,');
    InsertSQL.Add('  CODIFICACAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :VARIAVEIS,');
    InsertSQL.Add('  :CODIFICACAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update CALCULADOS');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  VARIAVEIS = :VARIAVEIS,');
    ModifySQL.Add('  CODIFICACAO = :CODIFICACAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  VARIAVEIS,');
    RefreshSQL.Add('  CODIFICACAO');
    RefreshSQL.Add('from CALCULADOS');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  VARIAVEIS,');
  SqlPrincipal.Add('  CODIFICACAO');
  SqlPrincipal.Add('from CALCULADOS');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NUMERO := TDCALCULADOSNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDCALCULADOSSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  VARIAVEIS := TDCALCULADOSVARIAVEIS.Create(AOwner);
  VARIAVEIS.Valor.DataSet := Self;
  CODIFICACAO := TDCALCULADOSCODIFICACAO.Create(AOwner);
  CODIFICACAO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(VARIAVEIS);
  Campos.Add(CODIFICACAO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDCALCULADOS.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDCALCULADOS.ExclusaoCascata;
begin

end;

end.
