{
 Classe da tabela: RELACIONA - Definição de Exclusão em Cascata
}

unit DRELACIONA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0011,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDRELACIONA = class(TTabela)
  public
    NUMERO: TDRELACIONANUMERO;
    SEQUENCIA: TDRELACIONASEQUENCIA;
    ATIVO: TDRELACIONAATIVO;
    KEY_SQL: TDRELACIONAKEY_SQL;
    TITULO_I: TDRELACIONATITULO_I;
    TIPO: TDRELACIONATIPO;
    CAMPOS_CHAVE_1: TDRELACIONACAMPOS_CHAVE_1;
    TAB_ESTRANGEIRA: TDRELACIONATAB_ESTRANGEIRA;
    CAMPOS_CHAVE_2: TDRELACIONACAMPOS_CHAVE_2;
    CAMPOS_VISUAIS: TDRELACIONACAMPOS_VISUAIS;
    EDICAO_DIRETA: TDRELACIONAEDICAO_DIRETA;
    FORMULARIO: TDRELACIONAFORMULARIO;
    ATALHO: TDRELACIONAATALHO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDRELACIONA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'RELACIONA';
  Titulo           := 'Definição de Integridade/Relacionamento';
  Name             := 'DRELACIONA';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsRELACIONA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_RELACIONA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from RELACIONA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into RELACIONA');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  ATIVO,');
    InsertSQL.Add('  KEY_SQL,');
    InsertSQL.Add('  TITULO_I,');
    InsertSQL.Add('  TIPO,');
    InsertSQL.Add('  CAMPOS_CHAVE_1,');
    InsertSQL.Add('  TAB_ESTRANGEIRA,');
    InsertSQL.Add('  CAMPOS_CHAVE_2,');
    InsertSQL.Add('  CAMPOS_VISUAIS,');
    InsertSQL.Add('  EDICAO_DIRETA,');
    InsertSQL.Add('  FORMULARIO,');
    InsertSQL.Add('  ATALHO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :ATIVO,');
    InsertSQL.Add('  :KEY_SQL,');
    InsertSQL.Add('  :TITULO_I,');
    InsertSQL.Add('  :TIPO,');
    InsertSQL.Add('  :CAMPOS_CHAVE_1,');
    InsertSQL.Add('  :TAB_ESTRANGEIRA,');
    InsertSQL.Add('  :CAMPOS_CHAVE_2,');
    InsertSQL.Add('  :CAMPOS_VISUAIS,');
    InsertSQL.Add('  :EDICAO_DIRETA,');
    InsertSQL.Add('  :FORMULARIO,');
    InsertSQL.Add('  :ATALHO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update RELACIONA');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  ATIVO = :ATIVO,');
    ModifySQL.Add('  KEY_SQL = :KEY_SQL,');
    ModifySQL.Add('  TITULO_I = :TITULO_I,');
    ModifySQL.Add('  TIPO = :TIPO,');
    ModifySQL.Add('  CAMPOS_CHAVE_1 = :CAMPOS_CHAVE_1,');
    ModifySQL.Add('  TAB_ESTRANGEIRA = :TAB_ESTRANGEIRA,');
    ModifySQL.Add('  CAMPOS_CHAVE_2 = :CAMPOS_CHAVE_2,');
    ModifySQL.Add('  CAMPOS_VISUAIS = :CAMPOS_VISUAIS,');
    ModifySQL.Add('  EDICAO_DIRETA = :EDICAO_DIRETA,');
    ModifySQL.Add('  FORMULARIO = :FORMULARIO,');
    ModifySQL.Add('  ATALHO = :ATALHO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  ATIVO,');
    RefreshSQL.Add('  KEY_SQL,');
    RefreshSQL.Add('  TITULO_I,');
    RefreshSQL.Add('  TIPO,');
    RefreshSQL.Add('  CAMPOS_CHAVE_1,');
    RefreshSQL.Add('  TAB_ESTRANGEIRA,');
    RefreshSQL.Add('  CAMPOS_CHAVE_2,');
    RefreshSQL.Add('  CAMPOS_VISUAIS,');
    RefreshSQL.Add('  EDICAO_DIRETA,');
    RefreshSQL.Add('  FORMULARIO,');
    RefreshSQL.Add('  ATALHO');
    RefreshSQL.Add('from RELACIONA');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  ATIVO,');
  SqlPrincipal.Add('  KEY_SQL,');
  SqlPrincipal.Add('  TITULO_I,');
  SqlPrincipal.Add('  TIPO,');
  SqlPrincipal.Add('  CAMPOS_CHAVE_1,');
  SqlPrincipal.Add('  TAB_ESTRANGEIRA,');
  SqlPrincipal.Add('  CAMPOS_CHAVE_2,');
  SqlPrincipal.Add('  CAMPOS_VISUAIS,');
  SqlPrincipal.Add('  EDICAO_DIRETA,');
  SqlPrincipal.Add('  FORMULARIO,');
  SqlPrincipal.Add('  ATALHO');
  SqlPrincipal.Add('from RELACIONA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  TITULO_I := TDRELACIONATITULO_I.Create(AOwner);
  TITULO_I.Valor.DataSet := Self;
  TIPO := TDRELACIONATIPO.Create(AOwner);
  TIPO.Valor.DataSet := Self;
  TAB_ESTRANGEIRA := TDRELACIONATAB_ESTRANGEIRA.Create(AOwner);
  TAB_ESTRANGEIRA.Valor.DataSet := Self;
  KEY_SQL := TDRELACIONAKEY_SQL.Create(AOwner);
  KEY_SQL.Valor.DataSet := Self;
  ATIVO := TDRELACIONAATIVO.Create(AOwner);
  ATIVO.Valor.DataSet := Self;
  CAMPOS_CHAVE_1 := TDRELACIONACAMPOS_CHAVE_1.Create(AOwner);
  CAMPOS_CHAVE_1.Valor.DataSet := Self;
  CAMPOS_CHAVE_2 := TDRELACIONACAMPOS_CHAVE_2.Create(AOwner);
  CAMPOS_CHAVE_2.Valor.DataSet := Self;
  CAMPOS_VISUAIS := TDRELACIONACAMPOS_VISUAIS.Create(AOwner);
  CAMPOS_VISUAIS.Valor.DataSet := Self;
  EDICAO_DIRETA := TDRELACIONAEDICAO_DIRETA.Create(AOwner);
  EDICAO_DIRETA.Valor.DataSet := Self;
  FORMULARIO := TDRELACIONAFORMULARIO.Create(AOwner);
  FORMULARIO.Valor.DataSet := Self;
  ATALHO := TDRELACIONAATALHO.Create(AOwner);
  ATALHO.Valor.DataSet := Self;
  NUMERO := TDRELACIONANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDRELACIONASEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(ATIVO);
  Campos.Add(KEY_SQL);
  Campos.Add(TITULO_I);
  Campos.Add(TIPO);
  Campos.Add(CAMPOS_CHAVE_1);
  Campos.Add(TAB_ESTRANGEIRA);
  Campos.Add(CAMPOS_CHAVE_2);
  Campos.Add(CAMPOS_VISUAIS);
  Campos.Add(EDICAO_DIRETA);
  Campos.Add(FORMULARIO);
  Campos.Add(ATALHO);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDRELACIONA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDRELACIONA.ExclusaoCascata;
begin

end;

end.
