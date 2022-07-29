{
 Classe da tabela: INDICEST - Definição de Índices Secundários
}

unit DINDICEST;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0006,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDINDICEST = class(TTabela)
  public
    NUMERO: TDINDICESTNUMERO;
    SEQUENCIA: TDINDICESTSEQUENCIA;
    CAMPOST: TDINDICESTCAMPOST;
    TITULO_I: TDINDICESTTITULO_I;
    CRESCENTE: TDINDICESTCRESCENTE;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDINDICEST.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'INDICEST';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DINDICEST';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsINDICEST';
  with UpdateSql do
  begin
    Name           := 'UpdSql_INDICEST';
    // Exclusão de Registro
    DeleteSQL.Add('delete from INDICEST');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into INDICEST');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  CAMPOST,');
    InsertSQL.Add('  TITULO_I,');
    InsertSQL.Add('  CRESCENTE');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :CAMPOST,');
    InsertSQL.Add('  :TITULO_I,');
    InsertSQL.Add('  :CRESCENTE');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update INDICEST');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  CAMPOST = :CAMPOST,');
    ModifySQL.Add('  TITULO_I = :TITULO_I,');
    ModifySQL.Add('  CRESCENTE = :CRESCENTE');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  CAMPOST,');
    RefreshSQL.Add('  TITULO_I,');
    RefreshSQL.Add('  CRESCENTE');
    RefreshSQL.Add('from INDICEST');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  CAMPOST,');
  SqlPrincipal.Add('  TITULO_I,');
  SqlPrincipal.Add('  CRESCENTE');
  SqlPrincipal.Add('from INDICEST');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  TITULO_I := TDINDICESTTITULO_I.Create(AOwner);
  TITULO_I.Valor.DataSet := Self;
  CAMPOST := TDINDICESTCAMPOST.Create(AOwner);
  CAMPOST.Valor.DataSet := Self;
  CRESCENTE := TDINDICESTCRESCENTE.Create(AOwner);
  CRESCENTE.Valor.DataSet := Self;
  NUMERO := TDINDICESTNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDINDICESTSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(CAMPOST);
  Campos.Add(TITULO_I);
  Campos.Add(CRESCENTE);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDINDICEST.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDINDICEST.ExclusaoCascata;
begin

end;

end.
