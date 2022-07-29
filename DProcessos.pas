{
 Classe da tabela: PROCESSOS - Definição de Exclusão em Cascata
}

unit DPROCESSOS;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0012,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDPROCESSOS = class(TTabela)
  public
    NUMERO: TDPROCESSOSNUMERO;
    SEQUENCIA: TDPROCESSOSSEQUENCIA;
    ATIVO: TDPROCESSOSATIVO;
    TITULO_I: TDPROCESSOSTITULO_I;
    TIPO: TDPROCESSOSTIPO;
    TAB_ALVO: TDPROCESSOSTAB_ALVO;
    CAMPO_ALVO: TDPROCESSOSCAMPO_ALVO;
    CONDICAO: TDPROCESSOSCONDICAO;
    FORMULA_DIRETA: TDPROCESSOSFORMULA_DIRETA;
    FORMULA_INVERSA: TDPROCESSOSFORMULA_INVERSA;
    QUANTIDADE: TDPROCESSOSQUANTIDADE;
    CONDICAO_INCLUSAO: TDPROCESSOSCONDICAO_INCLUSAO;
    CONDICAO_EXCLUSAO: TDPROCESSOSCONDICAO_EXCLUSAO;
    CAMPOS_ALVO: TDPROCESSOSCAMPOS_ALVO;
    CAMPOS_VALOR: TDPROCESSOSCAMPOS_VALOR;
    AVULSO: TDPROCESSOSAVULSO;
    AVULSO_VAR: TDPROCESSOSAVULSO_VAR;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDPROCESSOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'PROCESSOS';
  Titulo           := 'Definição de Processos';
  Name             := 'DPROCESSOS';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsPROCESSOS';
  with UpdateSql do
  begin
    Name           := 'UpdSql_PROCESSOS';
    // Exclusão de Registro
    DeleteSQL.Add('delete from PROCESSOS');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into PROCESSOS');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  ATIVO,');
    InsertSQL.Add('  TITULO_I,');
    InsertSQL.Add('  TIPO,');
    InsertSQL.Add('  TAB_ALVO,');
    InsertSQL.Add('  CAMPO_ALVO,');
    InsertSQL.Add('  CONDICAO,');
    InsertSQL.Add('  FORMULA_DIRETA,');
    InsertSQL.Add('  FORMULA_INVERSA,');
    InsertSQL.Add('  QUANTIDADE,');
    InsertSQL.Add('  CONDICAO_INCLUSAO,');
    InsertSQL.Add('  CONDICAO_EXCLUSAO,');
    InsertSQL.Add('  CAMPOS_ALVO,');
    InsertSQL.Add('  CAMPOS_VALOR,');
    InsertSQL.Add('  AVULSO,');
    InsertSQL.Add('  AVULSO_VAR');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :ATIVO,');
    InsertSQL.Add('  :TITULO_I,');
    InsertSQL.Add('  :TIPO,');
    InsertSQL.Add('  :TAB_ALVO,');
    InsertSQL.Add('  :CAMPO_ALVO,');
    InsertSQL.Add('  :CONDICAO,');
    InsertSQL.Add('  :FORMULA_DIRETA,');
    InsertSQL.Add('  :FORMULA_INVERSA,');
    InsertSQL.Add('  :QUANTIDADE,');
    InsertSQL.Add('  :CONDICAO_INCLUSAO,');
    InsertSQL.Add('  :CONDICAO_EXCLUSAO,');
    InsertSQL.Add('  :CAMPOS_ALVO,');
    InsertSQL.Add('  :CAMPOS_VALOR,');
    InsertSQL.Add('  :AVULSO,');
    InsertSQL.Add('  :AVULSO_VAR');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update PROCESSOS');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  ATIVO = :ATIVO,');
    ModifySQL.Add('  TITULO_I = :TITULO_I,');
    ModifySQL.Add('  TIPO = :TIPO,');
    ModifySQL.Add('  TAB_ALVO = :TAB_ALVO,');
    ModifySQL.Add('  CAMPO_ALVO = :CAMPO_ALVO,');
    ModifySQL.Add('  CONDICAO = :CONDICAO,');
    ModifySQL.Add('  FORMULA_DIRETA = :FORMULA_DIRETA,');
    ModifySQL.Add('  FORMULA_INVERSA = :FORMULA_INVERSA,');
    ModifySQL.Add('  QUANTIDADE = :QUANTIDADE,');
    ModifySQL.Add('  CONDICAO_INCLUSAO = :CONDICAO_INCLUSAO,');
    ModifySQL.Add('  CONDICAO_EXCLUSAO = :CONDICAO_EXCLUSAO,');
    ModifySQL.Add('  CAMPOS_ALVO = :CAMPOS_ALVO,');
    ModifySQL.Add('  CAMPOS_VALOR = :CAMPOS_VALOR,');
    ModifySQL.Add('  AVULSO = :AVULSO,');
    ModifySQL.Add('  AVULSO_VAR = :AVULSO_VAR');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  ATIVO,');
    RefreshSQL.Add('  TITULO_I,');
    RefreshSQL.Add('  TIPO,');
    RefreshSQL.Add('  TAB_ALVO,');
    RefreshSQL.Add('  CAMPO_ALVO,');
    RefreshSQL.Add('  CONDICAO,');
    RefreshSQL.Add('  FORMULA_DIRETA,');
    RefreshSQL.Add('  FORMULA_INVERSA,');
    RefreshSQL.Add('  QUANTIDADE,');
    RefreshSQL.Add('  CONDICAO_INCLUSAO,');
    RefreshSQL.Add('  CONDICAO_EXCLUSAO,');
    RefreshSQL.Add('  CAMPOS_ALVO,');
    RefreshSQL.Add('  CAMPOS_VALOR,');
    RefreshSQL.Add('  AVULSO,');
    RefreshSQL.Add('  AVULSO_VAR');
    RefreshSQL.Add('from PROCESSOS');
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
  SqlPrincipal.Add('  TITULO_I,');
  SqlPrincipal.Add('  TIPO,');
  SqlPrincipal.Add('  TAB_ALVO,');
  SqlPrincipal.Add('  CAMPO_ALVO,');
  SqlPrincipal.Add('  CONDICAO,');
  SqlPrincipal.Add('  FORMULA_DIRETA,');
  SqlPrincipal.Add('  FORMULA_INVERSA,');
  SqlPrincipal.Add('  QUANTIDADE,');
  SqlPrincipal.Add('  CONDICAO_INCLUSAO,');
  SqlPrincipal.Add('  CONDICAO_EXCLUSAO,');
  SqlPrincipal.Add('  CAMPOS_ALVO,');
  SqlPrincipal.Add('  CAMPOS_VALOR,');
  SqlPrincipal.Add('  AVULSO,');
  SqlPrincipal.Add('  AVULSO_VAR');
  SqlPrincipal.Add('from PROCESSOS');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  TITULO_I := TDPROCESSOSTITULO_I.Create(AOwner);
  TITULO_I.Valor.DataSet := Self;
  TIPO := TDPROCESSOSTIPO.Create(AOwner);
  TIPO.Valor.DataSet := Self;
  TAB_ALVO := TDPROCESSOSTAB_ALVO.Create(AOwner);
  TAB_ALVO.Valor.DataSet := Self;
  ATIVO := TDPROCESSOSATIVO.Create(AOwner);
  ATIVO.Valor.DataSet := Self;
  CAMPO_ALVO := TDPROCESSOSCAMPO_ALVO.Create(AOwner);
  CAMPO_ALVO.Valor.DataSet := Self;
  CONDICAO := TDPROCESSOSCONDICAO.Create(AOwner);
  CONDICAO.Valor.DataSet := Self;
  FORMULA_DIRETA := TDPROCESSOSFORMULA_DIRETA.Create(AOwner);
  FORMULA_DIRETA.Valor.DataSet := Self;
  FORMULA_INVERSA := TDPROCESSOSFORMULA_INVERSA.Create(AOwner);
  FORMULA_INVERSA.Valor.DataSet := Self;
  QUANTIDADE := TDPROCESSOSQUANTIDADE.Create(AOwner);
  QUANTIDADE.Valor.DataSet := Self;
  CONDICAO_INCLUSAO := TDPROCESSOSCONDICAO_INCLUSAO.Create(AOwner);
  CONDICAO_INCLUSAO.Valor.DataSet := Self;
  CONDICAO_EXCLUSAO := TDPROCESSOSCONDICAO_EXCLUSAO.Create(AOwner);
  CONDICAO_EXCLUSAO.Valor.DataSet := Self;
  CAMPOS_ALVO := TDPROCESSOSCAMPOS_ALVO.Create(AOwner);
  CAMPOS_ALVO.Valor.DataSet := Self;
  CAMPOS_VALOR := TDPROCESSOSCAMPOS_VALOR.Create(AOwner);
  CAMPOS_VALOR.Valor.DataSet := Self;
  AVULSO := TDPROCESSOSAVULSO.Create(AOwner);
  AVULSO.Valor.DataSet := Self;
  AVULSO_VAR := TDPROCESSOSAVULSO_VAR.Create(AOwner);
  AVULSO_VAR.Valor.DataSet := Self;
  NUMERO := TDPROCESSOSNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDPROCESSOSSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(ATIVO);
  Campos.Add(TITULO_I);
  Campos.Add(TIPO);
  Campos.Add(TAB_ALVO);
  Campos.Add(CAMPO_ALVO);
  Campos.Add(CONDICAO);
  Campos.Add(FORMULA_DIRETA);
  Campos.Add(FORMULA_INVERSA);
  Campos.Add(QUANTIDADE);
  Campos.Add(CONDICAO_INCLUSAO);
  Campos.Add(CONDICAO_EXCLUSAO);
  Campos.Add(CAMPOS_ALVO);
  Campos.Add(CAMPOS_VALOR);
  Campos.Add(AVULSO);
  Campos.Add(AVULSO_VAR);
  TituloIndice   := 'Nº.Tab.,Nº.Seq.';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDPROCESSOS.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDPROCESSOS.ExclusaoCascata;
begin

end;

end.
