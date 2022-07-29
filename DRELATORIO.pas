{
 Classe da tabela: RELATORIO - Definição de Relatórios / Gráficos
}

unit DRELATORIO;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0010,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDRELATORIO = class(TTabela)
  public
    NUMERO: TDRELATORIO_NUMERO;
    TIPO: TDRELATORIO_TIPO;
    SEQUENCIA: TDRELATORIO_SEQUENCIA;
    EXPRESSAO: TDRELATORIO_EXPRESSAO;
    ESPELHO_1: TDRELATORIO_ESPELHO_1;
    ESPELHO_2: TDRELATORIO_ESPELHO_2;
    SQL_P: TDRELATORIO_SQL;
    SQL_ATIVO: TDRELATORIO_SQL_ATIVO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas, Abertura;

constructor TDRELATORIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'RELATORIO';
  Titulo           := 'Definição de Relatórios / Gráficos';
  Name             := 'DRELATORIO';
  Database         := BaseDados.BD_Base_Projeto;
  Transaction      := BaseDados.TRS_BD_Base_Projeto;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsRELATORIO';
  with UpdateSql do
  begin
    Name           := 'UpdSql_RELATORIO';
    // Exclusão de Registro
    DeleteSQL.Add('delete from RELATORIO');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and TIPO = :OLD_TIPO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into RELATORIO');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  TIPO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  EXPRESSAO,');
    InsertSQL.Add('  ESPELHO_1,');
    InsertSQL.Add('  ESPELHO_2,');
    InsertSQL.Add('  SQL,');
    InsertSQL.Add('  SQL_ATIVO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :TIPO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :EXPRESSAO,');
    InsertSQL.Add('  :ESPELHO_1,');
    InsertSQL.Add('  :ESPELHO_2,');
    InsertSQL.Add('  :SQL,');
    InsertSQL.Add('  :SQL_ATIVO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update RELATORIO');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  TIPO = :TIPO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  EXPRESSAO = :EXPRESSAO,');
    ModifySQL.Add('  ESPELHO_1 = :ESPELHO_1,');
    ModifySQL.Add('  ESPELHO_2 = :ESPELHO_2,');
    ModifySQL.Add('  SQL = :SQL,');
    ModifySQL.Add('  SQL_ATIVO = :SQL_ATIVO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and TIPO = :OLD_TIPO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  TIPO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  EXPRESSAO,');
    RefreshSQL.Add('  ESPELHO_1,');
    RefreshSQL.Add('  ESPELHO_2,');
    RefreshSQL.Add('  SQL,');
    RefreshSQL.Add('  SQL_ATIVO');
    RefreshSQL.Add('from RELATORIO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :OLD_NUMERO');
    RefreshSQL.Add('  and TIPO = :OLD_TIPO');
    RefreshSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  TIPO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  EXPRESSAO,');
  SqlPrincipal.Add('  ESPELHO_1,');
  SqlPrincipal.Add('  ESPELHO_2,');
  SqlPrincipal.Add('  SQL,');
  SqlPrincipal.Add('  SQL_ATIVO');
  SqlPrincipal.Add('from RELATORIO');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,TIPO,SEQUENCIA');
  NUMERO := TDRELATORIO_NUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  TIPO := TDRELATORIO_TIPO.Create(AOwner);
  TIPO.Valor.DataSet := Self;
  SEQUENCIA := TDRELATORIO_SEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  EXPRESSAO := TDRELATORIO_EXPRESSAO.Create(AOwner);
  EXPRESSAO.Valor.DataSet := Self;
  ESPELHO_1 := TDRELATORIO_ESPELHO_1.Create(AOwner);
  ESPELHO_1.Valor.DataSet := Self;
  ESPELHO_2 := TDRELATORIO_ESPELHO_2.Create(AOwner);
  ESPELHO_2.Valor.DataSet := Self;
  SQL_P := TDRELATORIO_SQL.Create(AOwner);
  SQL_P.Valor.DataSet := Self;
  SQL_ATIVO := TDRELATORIO_SQL_ATIVO.Create(AOwner);
  SQL_ATIVO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(TIPO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(TIPO);
  Campos.Add(SEQUENCIA);
  Campos.Add(EXPRESSAO);
  Campos.Add(ESPELHO_1);
  Campos.Add(ESPELHO_2);
  Campos.Add(SQL_P);
  Campos.Add(SQL_ATIVO);
  TituloIndice   := 'Primário';
  ChaveIndice    := 'NUMERO,TIPO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDRELATORIO.PodeExcluir: Boolean;
Var
  QueryP: TIBQuery;
begin
  PodeExcluir := True;
  QueryP := TIBQuery.Create(Self);
  QueryP.Close;
  QueryP.Free;
end;

procedure TDRELATORIO.ExclusaoCascata;
Var
  QueryP: TIBQuery;
begin
  QueryP := TIBQuery.Create(Self);
  QueryP.Close;
  QueryP.Free;
end;

end.
