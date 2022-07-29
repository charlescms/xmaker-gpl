{
 Classe da tabela: DIAGRAMA - Bloco de Comandos
}

unit DDIAGRAMA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0019,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDDIAGRAMA = class(TTabela)
  public
    NUMERO: TDDIAGRAMANUMERO;
    TITULO_I: TDDIAGRAMATITULO_I;
    BLOCO: TDDIAGRAMABLOCO;
    DESCRICAO: TDDIAGRAMADESCRICAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDDIAGRAMA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'DIAGRAMA';
  Titulo           := 'Definição de Índices Secundários';
  Name             := 'DDIAGRAMA';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsDIAGRAMA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_DIAGRAMA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from DIAGRAMA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into DIAGRAMA');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  TITULO_I,');
    InsertSQL.Add('  BLOCO,');
    InsertSQL.Add('  DESCRICAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :TITULO_I,');
    InsertSQL.Add('  :BLOCO,');
    InsertSQL.Add('  :DESCRICAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update DIAGRAMA');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  TITULO_I = :TITULO_I,');
    ModifySQL.Add('  BLOCO = :BLOCO,');
    ModifySQL.Add('  DESCRICAO = :DESCRICAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  TITULO_I,');
    RefreshSQL.Add('  BLOCO,');
    RefreshSQL.Add('  DESCRICAO');
    RefreshSQL.Add('from DIAGRAMA');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  TITULO_I,');
  SqlPrincipal.Add('  BLOCO,');
  SqlPrincipal.Add('  DESCRICAO');
  SqlPrincipal.Add('from DIAGRAMA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  TITULO_I := TDDIAGRAMATITULO_I.Create(AOwner);
  TITULO_I.Valor.DataSet := Self;
  BLOCO := TDDIAGRAMABLOCO.Create(AOwner);
  BLOCO.Valor.DataSet := Self;
  DESCRICAO := TDDIAGRAMADESCRICAO.Create(AOwner);
  DESCRICAO.Valor.DataSet := Self;
  NUMERO := TDDIAGRAMANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(TITULO_I);
  Campos.Add(BLOCO);
  Campos.Add(DESCRICAO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDDIAGRAMA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDDIAGRAMA.ExclusaoCascata;
begin

end;

end.
