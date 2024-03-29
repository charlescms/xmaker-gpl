{
 Classe da tabela: CAMPOST - Defini��o de Campos de Tabelas
}

unit DCAMPOST;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0005,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDCAMPOST = class(TTabela)
  public
    NUMERO: TDCAMPOSTNUMERO;
    SEQUENCIA: TDCAMPOSTSEQUENCIA;
    NOME: TDCAMPOSTNOME;
    NOME_FISICO: TDCAMPOSTNOME_FISICO;
    TIPO_FISICO: TDCAMPOSTTIPO_FISICO;
    TIPO: TDCAMPOSTTIPO;
    TAMANHO: TDCAMPOSTTAMANHO;
    EDICAO: TDCAMPOSTEDICAO;
    MASCARA: TDCAMPOSTMASCARA;
    TITULO_C: TDCAMPOSTTITULO_C;
    AJUDA: TDCAMPOSTAJUDA;
    PADRAO: TDCAMPOSTPADRAO;
    VALIDACAO: TDCAMPOSTVALIDACAO;
    VALIDOS: TDCAMPOSTVALIDOS;
    DESCRICAO: TDCAMPOSTDESCRICAO;
    CHAVE: TDCAMPOSTCHAVE;
    CALCULADO: TDCAMPOSTCALCULADO;
    CALCULADO_FORMULA: TDCAMPOSTCALCULADO_FORMULA;
    AUTOINCREMENTO: TDCAMPOSTAUTOINCREMENTO;
    SEMPRE_ATRIBUI: TDCAMPOSTSEMPRE_ATRIBUI;
    INVISIVEL: TDCAMPOSTINVISIVEL;
    PRE_VALIDACAO: TDCAMPOSTPRE_VALIDACAO;
    TIPO_PRE_VALIDACAO: TDCAMPOSTTIPO_PRE_VALIDACAO;
    LIMPAR_CAMPO: TDCAMPOSTLIMPAR_CAMPO;
    MSG_ERRO: TDCAMPOSTMSG_ERRO;
    TAB_ESTRANGEIRA: TDCAMPOSTTAB_ESTRANGEIRA;
    CAMPO_CHAVE: TDCAMPOSTCAMPO_CHAVE;
    CAMPOS_VISUAIS: TDCAMPOSTCAMPOS_VISUAIS;
    ESTILO_CHAVE: TDCAMPOSTESTILO_CHAVE;
    FILTRO_MESTRE: TDCAMPOSTFILTRO_MESTRE;
    ACAO_PESQUISA: TDCAMPOSTACAO_PESQUISA;
    INDICE_CONSULTA: TDCAMPOSTINDICE_CONSULTA;
    EXTRA: TDCAMPOSTEXTRA;
    TAB_EXTRA: TDCAMPOSTTAB_EXTRA;
    CAMPO_EXTRA: TDCAMPOSTCAMPO_EXTRA;
    TAB_PESQUISA: TDCAMPOSTTAB_PESQUISA;
    NAO_VIRTUAL: TDCAMPOSTNAO_VIRTUAL;
    SQL_EXTRA: TDCAMPOSTSQL_EXTRA;
    SEM_INSERT: TDCAMPOSTSEM_INSERT;
    VALIDA_ONEXIT: TDCAMPOSTVALIDA_ONEXIT;
    SQL_EXTRA_INSERT: TDCAMPOSTSQL_EXTRA_INSERT;
    VARIAVEIS: TDCAMPOSTVARIAVEIS;
    CODIFICACAO: TDCAMPOSTCODIFICACAO;
    DDCALCULADOS: TTabela;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas, Abertura;

constructor TDCAMPOST.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'CAMPOST';
  Titulo           := 'Defini��o de Campos de Tabelas';
  Name             := 'DCAMPOST';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsCAMPOST';
  with UpdateSql do
  begin
    Name           := 'UpdSql_CAMPOST';
    // Exclus�o de Registro
    DeleteSQL.Add('delete from CAMPOST');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    DeleteSQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Inser��o de Registro
    InsertSQL.Add('insert into CAMPOST');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  SEQUENCIA,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  NOME_FISICO,');
    InsertSQL.Add('  TIPO_FISICO,');
    InsertSQL.Add('  TIPO,');
    InsertSQL.Add('  TAMANHO,');
    InsertSQL.Add('  EDICAO,');
    InsertSQL.Add('  MASCARA,');
    InsertSQL.Add('  TITULO_C,');
    InsertSQL.Add('  AJUDA,');
    InsertSQL.Add('  PADRAO,');
    InsertSQL.Add('  VALIDACAO,');
    InsertSQL.Add('  VALIDOS,');
    InsertSQL.Add('  DESCRICAO,');
    InsertSQL.Add('  CHAVE,');
    InsertSQL.Add('  CALCULADO,');
    InsertSQL.Add('  AUTOINCREMENTO,');
    InsertSQL.Add('  SEMPRE_ATRIBUI,');
    InsertSQL.Add('  INVISIVEL,');
    InsertSQL.Add('  PRE_VALIDACAO,');
    InsertSQL.Add('  TIPO_PRE_VALIDACAO,');
    InsertSQL.Add('  LIMPAR_CAMPO,');
    InsertSQL.Add('  MSG_ERRO,');
    InsertSQL.Add('  TAB_ESTRANGEIRA,');
    InsertSQL.Add('  CAMPO_CHAVE,');
    InsertSQL.Add('  CAMPOS_VISUAIS,');
    InsertSQL.Add('  ESTILO_CHAVE,');
    InsertSQL.Add('  FILTRO_MESTRE,');
    InsertSQL.Add('  ACAO_PESQUISA,');
    InsertSQL.Add('  INDICE_CONSULTA,');
    InsertSQL.Add('  EXTRA,');
    InsertSQL.Add('  TAB_EXTRA,');
    InsertSQL.Add('  CAMPO_EXTRA,');
    InsertSQL.Add('  TAB_PESQUISA,');
    InsertSQL.Add('  NAO_VIRTUAL,');
    InsertSQL.Add('  SQL_EXTRA,');
    InsertSQL.Add('  SEM_INSERT,');
    InsertSQL.Add('  VALIDA_ONEXIT,');
    InsertSQL.Add('  SQL_EXTRA_INSERT,');
    InsertSQL.Add('  VARIAVEIS,');
    InsertSQL.Add('  CODIFICACAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :SEQUENCIA,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :NOME_FISICO,');
    InsertSQL.Add('  :TIPO_FISICO,');
    InsertSQL.Add('  :TIPO,');
    InsertSQL.Add('  :TAMANHO,');
    InsertSQL.Add('  :EDICAO,');
    InsertSQL.Add('  :MASCARA,');
    InsertSQL.Add('  :TITULO_C,');
    InsertSQL.Add('  :AJUDA,');
    InsertSQL.Add('  :PADRAO,');
    InsertSQL.Add('  :VALIDACAO,');
    InsertSQL.Add('  :VALIDOS,');
    InsertSQL.Add('  :DESCRICAO,');
    InsertSQL.Add('  :CHAVE,');
    InsertSQL.Add('  :CALCULADO,');
    InsertSQL.Add('  :AUTOINCREMENTO,');
    InsertSQL.Add('  :SEMPRE_ATRIBUI,');
    InsertSQL.Add('  :INVISIVEL,');
    InsertSQL.Add('  :PRE_VALIDACAO,');
    InsertSQL.Add('  :TIPO_PRE_VALIDACAO,');
    InsertSQL.Add('  :LIMPAR_CAMPO,');
    InsertSQL.Add('  :MSG_ERRO,');
    InsertSQL.Add('  :TAB_ESTRANGEIRA,');
    InsertSQL.Add('  :CAMPO_CHAVE,');
    InsertSQL.Add('  :CAMPOS_VISUAIS,');
    InsertSQL.Add('  :ESTILO_CHAVE,');
    InsertSQL.Add('  :FILTRO_MESTRE,');
    InsertSQL.Add('  :ACAO_PESQUISA,');
    InsertSQL.Add('  :INDICE_CONSULTA,');
    InsertSQL.Add('  :EXTRA,');
    InsertSQL.Add('  :TAB_EXTRA,');
    InsertSQL.Add('  :CAMPO_EXTRA,');
    InsertSQL.Add('  :TAB_PESQUISA,');
    InsertSQL.Add('  :NAO_VIRTUAL,');
    InsertSQL.Add('  :SQL_EXTRA,');
    InsertSQL.Add('  :SEM_INSERT,');
    InsertSQL.Add('  :VALIDA_ONEXIT,');
    InsertSQL.Add('  :SQL_EXTRA_INSERT,');
    InsertSQL.Add('  :VARIAVEIS,');
    InsertSQL.Add('  :CODIFICACAO');
    InsertSQL.Add('  )');
    // Modifica��o de Registro
    ModifySQL.Add('update CAMPOST');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  SEQUENCIA = :SEQUENCIA,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  NOME_FISICO = :NOME_FISICO,');
    ModifySQL.Add('  TIPO_FISICO = :TIPO_FISICO,');
    ModifySQL.Add('  TIPO = :TIPO,');
    ModifySQL.Add('  TAMANHO = :TAMANHO,');
    ModifySQL.Add('  EDICAO = :EDICAO,');
    ModifySQL.Add('  MASCARA = :MASCARA,');
    ModifySQL.Add('  TITULO_C = :TITULO_C,');
    ModifySQL.Add('  AJUDA = :AJUDA,');
    ModifySQL.Add('  PADRAO = :PADRAO,');
    ModifySQL.Add('  VALIDACAO = :VALIDACAO,');
    ModifySQL.Add('  VALIDOS = :VALIDOS,');
    ModifySQL.Add('  DESCRICAO = :DESCRICAO,');
    ModifySQL.Add('  CHAVE = :CHAVE,');
    ModifySQL.Add('  CALCULADO = :CALCULADO,');
    ModifySQL.Add('  AUTOINCREMENTO = :AUTOINCREMENTO,');
    ModifySQL.Add('  SEMPRE_ATRIBUI = :SEMPRE_ATRIBUI,');
    ModifySQL.Add('  INVISIVEL = :INVISIVEL,');
    ModifySQL.Add('  PRE_VALIDACAO = :PRE_VALIDACAO,');
    ModifySQL.Add('  TIPO_PRE_VALIDACAO = :TIPO_PRE_VALIDACAO,');
    ModifySQL.Add('  LIMPAR_CAMPO = :LIMPAR_CAMPO,');
    ModifySQL.Add('  MSG_ERRO = :MSG_ERRO,');
    ModifySQL.Add('  TAB_ESTRANGEIRA = :TAB_ESTRANGEIRA,');
    ModifySQL.Add('  CAMPO_CHAVE = :CAMPO_CHAVE,');
    ModifySQL.Add('  CAMPOS_VISUAIS = :CAMPOS_VISUAIS,');
    ModifySQL.Add('  ESTILO_CHAVE = :ESTILO_CHAVE,');
    ModifySQL.Add('  FILTRO_MESTRE = :FILTRO_MESTRE,');
    ModifySQL.Add('  ACAO_PESQUISA = :ACAO_PESQUISA,');
    ModifySQL.Add('  INDICE_CONSULTA = :INDICE_CONSULTA,');
    ModifySQL.Add('  EXTRA = :EXTRA,');
    ModifySQL.Add('  TAB_EXTRA = :TAB_EXTRA,');
    ModifySQL.Add('  CAMPO_EXTRA = :CAMPO_EXTRA,');
    ModifySQL.Add('  TAB_PESQUISA = :TAB_PESQUISA,');
    ModifySQL.Add('  NAO_VIRTUAL = :NAO_VIRTUAL,');
    ModifySQL.Add('  SQL_EXTRA = :SQL_EXTRA,');
    ModifySQL.Add('  SEM_INSERT = :SEM_INSERT,');
    ModifySQL.Add('  VALIDA_ONEXIT = :VALIDA_ONEXIT,');
    ModifySQL.Add('  SQL_EXTRA_INSERT = :SQL_EXTRA_INSERT,');
    ModifySQL.Add('  VARIAVEIS = :VARIAVEIS,');
    ModifySQL.Add('  CODIFICACAO = :CODIFICACAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    ModifySQL.Add('  and SEQUENCIA = :OLD_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  SEQUENCIA,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  NOME_FISICO,');
    RefreshSQL.Add('  TIPO_FISICO,');
    RefreshSQL.Add('  TIPO,');
    RefreshSQL.Add('  TAMANHO,');
    RefreshSQL.Add('  EDICAO,');
    RefreshSQL.Add('  MASCARA,');
    RefreshSQL.Add('  TITULO_C,');
    RefreshSQL.Add('  AJUDA,');
    RefreshSQL.Add('  PADRAO,');
    RefreshSQL.Add('  VALIDACAO,');
    RefreshSQL.Add('  VALIDOS,');
    RefreshSQL.Add('  DESCRICAO,');
    RefreshSQL.Add('  CHAVE,');
    RefreshSQL.Add('  CALCULADO,');
    RefreshSQL.Add('  AUTOINCREMENTO,');
    RefreshSQL.Add('  SEMPRE_ATRIBUI,');
    RefreshSQL.Add('  INVISIVEL,');
    RefreshSQL.Add('  PRE_VALIDACAO,');
    RefreshSQL.Add('  TIPO_PRE_VALIDACAO,');
    RefreshSQL.Add('  LIMPAR_CAMPO,');
    RefreshSQL.Add('  MSG_ERRO,');
    RefreshSQL.Add('  TAB_ESTRANGEIRA,');
    RefreshSQL.Add('  CAMPO_CHAVE,');
    RefreshSQL.Add('  CAMPOS_VISUAIS,');
    RefreshSQL.Add('  ESTILO_CHAVE,');
    RefreshSQL.Add('  FILTRO_MESTRE,');
    RefreshSQL.Add('  ACAO_PESQUISA,');
    RefreshSQL.Add('  INDICE_CONSULTA,');
    RefreshSQL.Add('  EXTRA,');
    RefreshSQL.Add('  TAB_EXTRA,');
    RefreshSQL.Add('  CAMPO_EXTRA,');
    RefreshSQL.Add('  TAB_PESQUISA,');
    RefreshSQL.Add('  NAO_VIRTUAL,');
    RefreshSQL.Add('  SQL_EXTRA,');
    RefreshSQL.Add('  SEM_INSERT,');
    RefreshSQL.Add('  VALIDA_ONEXIT,');
    RefreshSQL.Add('  SQL_EXTRA_INSERT,');
    RefreshSQL.Add('  VARIAVEIS,');
    RefreshSQL.Add('  CODIFICACAO');
    RefreshSQL.Add('from CAMPOST');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
    RefreshSQL.Add('  and SEQUENCIA = :SEQUENCIA');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  SEQUENCIA,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  NOME_FISICO,');
  SqlPrincipal.Add('  TIPO_FISICO,');
  SqlPrincipal.Add('  TIPO,');
  SqlPrincipal.Add('  TAMANHO,');
  SqlPrincipal.Add('  EDICAO,');
  SqlPrincipal.Add('  MASCARA,');
  SqlPrincipal.Add('  TITULO_C,');
  SqlPrincipal.Add('  AJUDA,');
  SqlPrincipal.Add('  PADRAO,');
  SqlPrincipal.Add('  VALIDACAO,');
  SqlPrincipal.Add('  VALIDOS,');
  SqlPrincipal.Add('  DESCRICAO,');
  SqlPrincipal.Add('  CHAVE,');
  SqlPrincipal.Add('  CALCULADO,');
  SqlPrincipal.Add('  AUTOINCREMENTO,');
  SqlPrincipal.Add('  SEMPRE_ATRIBUI,');
  SqlPrincipal.Add('  INVISIVEL,');
  SqlPrincipal.Add('  PRE_VALIDACAO,');
  SqlPrincipal.Add('  TIPO_PRE_VALIDACAO,');
  SqlPrincipal.Add('  LIMPAR_CAMPO,');
  SqlPrincipal.Add('  MSG_ERRO,');
  SqlPrincipal.Add('  TAB_ESTRANGEIRA,');
  SqlPrincipal.Add('  CAMPO_CHAVE,');
  SqlPrincipal.Add('  CAMPOS_VISUAIS,');
  SqlPrincipal.Add('  ESTILO_CHAVE,');
  SqlPrincipal.Add('  FILTRO_MESTRE,');
  SqlPrincipal.Add('  ACAO_PESQUISA,');
  SqlPrincipal.Add('  INDICE_CONSULTA,');
  SqlPrincipal.Add('  EXTRA,');
  SqlPrincipal.Add('  TAB_EXTRA,');
  SqlPrincipal.Add('  CAMPO_EXTRA,');
  SqlPrincipal.Add('  TAB_PESQUISA,');
  SqlPrincipal.Add('  NAO_VIRTUAL,');
  SqlPrincipal.Add('  SQL_EXTRA,');
  SqlPrincipal.Add('  SEM_INSERT,');
  SqlPrincipal.Add('  VALIDA_ONEXIT,');
  SqlPrincipal.Add('  SQL_EXTRA_INSERT,');
  SqlPrincipal.Add('  VARIAVEIS,');
  SqlPrincipal.Add('  CODIFICACAO');
  SqlPrincipal.Add('from CAMPOST');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO,SEQUENCIA');
  NUMERO := TDCAMPOSTNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  SEQUENCIA := TDCAMPOSTSEQUENCIA.Create(AOwner);
  SEQUENCIA.Valor.DataSet := Self;
  NOME := TDCAMPOSTNOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  NOME_FISICO := TDCAMPOSTNOME_FISICO.Create(AOwner);
  NOME_FISICO.Valor.DataSet := Self;
  TIPO := TDCAMPOSTTIPO.Create(AOwner);
  TIPO.Valor.DataSet := Self;
  TIPO_FISICO := TDCAMPOSTTIPO_FISICO.Create(AOwner);
  TIPO_FISICO.Valor.DataSet := Self;
  CHAVE := TDCAMPOSTCHAVE.Create(AOwner);
  CHAVE.Valor.DataSet := Self;
  TAMANHO := TDCAMPOSTTAMANHO.Create(AOwner);
  TAMANHO.Valor.DataSet := Self;
  AUTOINCREMENTO := TDCAMPOSTAUTOINCREMENTO.Create(AOwner);
  AUTOINCREMENTO.Valor.DataSet := Self;
  SEMPRE_ATRIBUI := TDCAMPOSTSEMPRE_ATRIBUI.Create(AOwner);
  SEMPRE_ATRIBUI.Valor.DataSet := Self;
  EDICAO := TDCAMPOSTEDICAO.Create(AOwner);
  EDICAO.Valor.DataSet := Self;
  TAB_ESTRANGEIRA := TDCAMPOSTTAB_ESTRANGEIRA.Create(AOwner);
  TAB_ESTRANGEIRA.Valor.DataSet := Self;
  CALCULADO := TDCAMPOSTCALCULADO.Create(AOwner);
  CALCULADO.Valor.DataSet := Self;
  CALCULADO_FORMULA := TDCAMPOSTCALCULADO_FORMULA.Create(AOwner);
  CALCULADO_FORMULA.Valor.DataSet := Self;
  MASCARA := TDCAMPOSTMASCARA.Create(AOwner);
  MASCARA.Valor.DataSet := Self;
  TITULO_C := TDCAMPOSTTITULO_C.Create(AOwner);
  TITULO_C.Valor.DataSet := Self;
  INDICE_CONSULTA := TDCAMPOSTINDICE_CONSULTA.Create(AOwner);
  INDICE_CONSULTA.Valor.DataSet := Self;
  INVISIVEL := TDCAMPOSTINVISIVEL.Create(AOwner);
  INVISIVEL.Valor.DataSet := Self;
  AJUDA := TDCAMPOSTAJUDA.Create(AOwner);
  AJUDA.Valor.DataSet := Self;
  PADRAO := TDCAMPOSTPADRAO.Create(AOwner);
  PADRAO.Valor.DataSet := Self;
  PRE_VALIDACAO := TDCAMPOSTPRE_VALIDACAO.Create(AOwner);
  PRE_VALIDACAO.Valor.DataSet := Self;
  TIPO_PRE_VALIDACAO := TDCAMPOSTTIPO_PRE_VALIDACAO.Create(AOwner);
  TIPO_PRE_VALIDACAO.Valor.DataSet := Self;
  LIMPAR_CAMPO := TDCAMPOSTLIMPAR_CAMPO.Create(AOwner);
  LIMPAR_CAMPO.Valor.DataSet := Self;
  VALIDACAO := TDCAMPOSTVALIDACAO.Create(AOwner);
  VALIDACAO.Valor.DataSet := Self;
  TAB_PESQUISA := TDCAMPOSTTAB_PESQUISA.Create(AOwner);
  TAB_PESQUISA.Valor.DataSet := Self;
  VALIDA_ONEXIT := TDCAMPOSTVALIDA_ONEXIT.Create(AOwner);
  VALIDA_ONEXIT.Valor.DataSet := Self;
  MSG_ERRO := TDCAMPOSTMSG_ERRO.Create(AOwner);
  MSG_ERRO.Valor.DataSet := Self;
  VALIDOS := TDCAMPOSTVALIDOS.Create(AOwner);
  VALIDOS.Valor.DataSet := Self;
  SEM_INSERT := TDCAMPOSTSEM_INSERT.Create(AOwner);
  SEM_INSERT.Valor.DataSet := Self;
  SQL_EXTRA := TDCAMPOSTSQL_EXTRA.Create(AOwner);
  SQL_EXTRA.Valor.DataSet := Self;
  SQL_EXTRA_INSERT := TDCAMPOSTSQL_EXTRA_INSERT.Create(AOwner);
  SQL_EXTRA_INSERT.Valor.DataSet := Self;
  DESCRICAO := TDCAMPOSTDESCRICAO.Create(AOwner);
  DESCRICAO.Valor.DataSet := Self;
  CAMPO_CHAVE := TDCAMPOSTCAMPO_CHAVE.Create(AOwner);
  CAMPO_CHAVE.Valor.DataSet := Self;
  CAMPOS_VISUAIS := TDCAMPOSTCAMPOS_VISUAIS.Create(AOwner);
  CAMPOS_VISUAIS.Valor.DataSet := Self;
  ESTILO_CHAVE := TDCAMPOSTESTILO_CHAVE.Create(AOwner);
  ESTILO_CHAVE.Valor.DataSet := Self;
  FILTRO_MESTRE := TDCAMPOSTFILTRO_MESTRE.Create(AOwner);
  FILTRO_MESTRE.Valor.DataSet := Self;
  ACAO_PESQUISA := TDCAMPOSTACAO_PESQUISA.Create(AOwner);
  ACAO_PESQUISA.Valor.DataSet := Self;
  EXTRA := TDCAMPOSTEXTRA.Create(AOwner);
  EXTRA.Valor.DataSet := Self;
  TAB_EXTRA := TDCAMPOSTTAB_EXTRA.Create(AOwner);
  TAB_EXTRA.Valor.DataSet := Self;
  CAMPO_EXTRA := TDCAMPOSTCAMPO_EXTRA.Create(AOwner);
  CAMPO_EXTRA.Valor.DataSet := Self;
  NAO_VIRTUAL := TDCAMPOSTNAO_VIRTUAL.Create(AOwner);
  NAO_VIRTUAL.Valor.DataSet := Self;
  VARIAVEIS := TDCAMPOSTVARIAVEIS.Create(AOwner);
  VARIAVEIS.Valor.DataSet := Self;
  CODIFICACAO := TDCAMPOSTCODIFICACAO.Create(AOwner);
  CODIFICACAO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  ChavePrimaria.Add(SEQUENCIA);
  Campos.Add(NUMERO);
  Campos.Add(SEQUENCIA);
  Campos.Add(NOME);
  Campos.Add(NOME_FISICO);
  Campos.Add(TIPO);
  Campos.Add(TIPO_FISICO);
  Campos.Add(TAMANHO);
  Campos.Add(EDICAO);
  Campos.Add(MASCARA);
  Campos.Add(TITULO_C);
  Campos.Add(AJUDA);
  Campos.Add(PADRAO);
  Campos.Add(VALIDACAO);
  Campos.Add(VALIDOS);
  Campos.Add(DESCRICAO);
  Campos.Add(CHAVE);
  Campos.Add(CALCULADO);
  Campos.Add(CALCULADO_FORMULA);
  Campos.Add(AUTOINCREMENTO);
  Campos.Add(SEMPRE_ATRIBUI);
  Campos.Add(INVISIVEL);
  Campos.Add(PRE_VALIDACAO);
  Campos.Add(TIPO_PRE_VALIDACAO);
  Campos.Add(LIMPAR_CAMPO);
  Campos.Add(MSG_ERRO);
  Campos.Add(TAB_ESTRANGEIRA);
  Campos.Add(CAMPO_CHAVE);
  Campos.Add(CAMPOS_VISUAIS);
  Campos.Add(ESTILO_CHAVE);
  Campos.Add(FILTRO_MESTRE);
  Campos.Add(ACAO_PESQUISA);
  Campos.Add(INDICE_CONSULTA);
  Campos.Add(EXTRA);
  Campos.Add(TAB_EXTRA);
  Campos.Add(CAMPO_EXTRA);
  Campos.Add(TAB_PESQUISA);
  Campos.Add(NAO_VIRTUAL);
  Campos.Add(SEM_INSERT);
  Campos.Add(SQL_EXTRA);
  Campos.Add(VALIDA_ONEXIT);
  Campos.Add(SQL_EXTRA_INSERT);
  Campos.Add(VARIAVEIS);
  Campos.Add(CODIFICACAO);
  TituloIndice   := 'N�Tab,N�Seq';
  ChaveIndice    := 'NUMERO,SEQUENCIA';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDCAMPOST.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDCAMPOST.ExclusaoCascata;
Var
  QueryP: TIBQuery;
begin
  // Exclus�o em Cascata Tabela: DCALCULADOS
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DCALCULADOS.DataBase;
  QueryP.Sql.Add('Delete From CALCULADOS');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.Sql.Add('AND (SEQUENCIA = '+IntToStr(SEQUENCIA.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Close;
  QueryP.Free;
end;

end.
