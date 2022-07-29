{
 Classe da tabela: CONSULTA - Definição de Consultas
}

unit DCONSULTA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0015,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDCONSULTA = class(TTabela)
  public
    NUMERO: TDCONSULTANUMERO;
    TITULO_I: TDCONSULTATITULO_I;
    BASE: TDCONSULTABASE;
    NOME: TDCONSULTANOME;
    SQL_I: TDCONSULTASQL_I;
    SQL_INTERATIVO: TDCONSULTASQL_INTERATIVO;
    PARAMETROS: TDCONSULTASQL_PARAMETROS;
    TITULOS: TDCONSULTASQL_TITULOS;
    ATIVO: TDCONSULTASQL_ATIVO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDCONSULTA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'CONSULTA';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DCONSULTA';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsCONSULTA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_CONSULTA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from CONSULTA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into CONSULTA');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  TITULO_I,');
    InsertSQL.Add('  BASE,');
    InsertSQL.Add('  SQL_I,');
    InsertSQL.Add('  SQL_INTERATIVO,');
    InsertSQL.Add('  PARAMETROS,');
    InsertSQL.Add('  TITULOS,');
    InsertSQL.Add('  ATIVO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :TITULO_I,');
    InsertSQL.Add('  :BASE,');
    InsertSQL.Add('  :SQL_I,');
    InsertSQL.Add('  :SQL_INTERATIVO,');
    InsertSQL.Add('  :PARAMETROS,');
    InsertSQL.Add('  :TITULOS,');
    InsertSQL.Add('  :ATIVO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update CONSULTA');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  TITULO_I = :TITULO_I,');
    ModifySQL.Add('  BASE = :BASE,');
    ModifySQL.Add('  SQL_I = :SQL_I,');
    ModifySQL.Add('  SQL_INTERATIVO = :SQL_INTERATIVO,');
    ModifySQL.Add('  PARAMETROS = :PARAMETROS,');
    ModifySQL.Add('  TITULOS = :TITULOS,');
    ModifySQL.Add('  ATIVO = :ATIVO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  TITULO_I,');
    RefreshSQL.Add('  BASE,');
    RefreshSQL.Add('  SQL_I,');
    RefreshSQL.Add('  SQL_INTERATIVO,');
    RefreshSQL.Add('  PARAMETROS,');
    RefreshSQL.Add('  TITULOS,');
    RefreshSQL.Add('  ATIVO');
    RefreshSQL.Add('from CONSULTA');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  TITULO_I,');
  SqlPrincipal.Add('  BASE,');
  SqlPrincipal.Add('  SQL_I,');
  SqlPrincipal.Add('  SQL_INTERATIVO,');
  SqlPrincipal.Add('  PARAMETROS,');
  SqlPrincipal.Add('  TITULOS,');
  SqlPrincipal.Add('  ATIVO');
  SqlPrincipal.Add('from CONSULTA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NOME := TDCONSULTANOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  TITULO_I := TDCONSULTATITULO_I.Create(AOwner);
  TITULO_I.Valor.DataSet := Self;
  SQL_I := TDCONSULTASQL_I.Create(AOwner);
  SQL_I.Valor.DataSet := Self;
  SQL_INTERATIVO := TDCONSULTASQL_INTERATIVO.Create(AOwner);
  SQL_INTERATIVO.Valor.DataSet := Self;
  BASE := TDCONSULTABASE.Create(AOwner);
  BASE.Valor.DataSet := Self;
  PARAMETROS := TDCONSULTASQL_PARAMETROS.Create(AOwner);
  PARAMETROS.Valor.DataSet := Self;
  TITULOS := TDCONSULTASQL_TITULOS.Create(AOwner);
  TITULOS.Valor.DataSet := Self;
  ATIVO := TDCONSULTASQL_ATIVO.Create(AOwner);
  ATIVO.Valor.DataSet := Self;
  NUMERO := TDCONSULTANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(TITULO_I);
  Campos.Add(BASE);
  Campos.Add(NOME);
  Campos.Add(SQL_I);
  Campos.Add(SQL_INTERATIVO);
  Campos.Add(PARAMETROS);
  Campos.Add(TITULOS);
  Campos.Add(ATIVO);
  TituloIndice   := 'Nº.Tab.';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDCONSULTA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDCONSULTA.ExclusaoCascata;
begin

end;

end.
