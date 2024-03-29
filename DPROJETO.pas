{
 Classe da tabela: PROJETO - Defini��o do Projeto
}

unit DPROJETO;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0000,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDPROJETO = class(TTabela)
  public
    NUMERO: TDPROJETONUMERO;
    TITULO_P: TDPROJETOTITULO_P;
    EMPRESA: TDPROJETOEMPRESA;
    ANALISTA: TDPROJETOANALISTA;
    PROGRAMADOR: TDPROJETOPROGRAMADOR;
    VERSAO_P: TDPROJETOVERSAO_P;
    INICIO: TDPROJETOINICIO;
    ICONE: TDPROJETOICONE;
    APRESENTACAO: TDPROJETOAPRESENTACAO;
    AJUSTAR: TDPROJETOAJUSTAR;
    FUNDO: TDPROJETOFUNDO;
    FORMATODATA: TDPROJETOFORMATODATA;
    CONFIRMASAIDA: TDPROJETOCONFIRMASAIDA;
    MULTIPLASINSTANCIAS: TDPROJETOMULTIPLASINSTANCIAS;
    HINTBALAO: TDPROJETOHINTBALAO;
    MENUXP: TDPROJETOMENUXP;
    DICIONARIO: TDPROJETODICIONARIO;
    CONTROLEACESSO: TDPROJETOCONTROLEACESSO;
    PASTADICIONARIO: TDPROJETOPASTADICIONARIO;
    SENHA: TDPROJETOSENHA;
    LINGUAGEM: TDPROJETOLINGUAGEM;
    BDADOS: TDPROJETOBDADOS;
    NSERVIDOR: TDPROJETONSERVIDOR;
    BDCONEXAO: TDPROJETOBDCONEXAO;
    SELECIONAR_EMP: TDPROJETOSELECIONAR_EMP;
    DEIXAR_NA_SENHA: TDPROJETODEIXAR_NA_SENHA;
    MODELO: TDPROJETOMODELO;
    CONTROLE_ACESSO_INTERNO: TDPROJETOCONTROLE_ACESSO_INTERNO;
    TABELAS_UTILIZADAS: TDPROJETOTABELAS_UTILIZADAS;
    OBJETOS_PROJETO: TDPROJETOOBJETOS_PROJETO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDPROJETO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'PROJETO';
  Titulo           := 'Defini��o do Projeto';
  Name             := 'DPROJETO';
  Database         := BaseDados.BD_Base_Projeto;
  Transaction      := BaseDados.TRS_BD_Base_Projeto;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsPROJETO';
  with UpdateSql do
  begin
    Name           := 'UpdSql_PROJETO';
    // Exclus�o de Registro
    DeleteSQL.Add('delete from PROJETO');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inser��o de Registro
    InsertSQL.Add('insert into PROJETO');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  TITULO_P,');
    InsertSQL.Add('  EMPRESA,');
    InsertSQL.Add('  ANALISTA,');
    InsertSQL.Add('  PROGRAMADOR,');
    InsertSQL.Add('  VERSAO_P,');
    InsertSQL.Add('  INICIO,');
    InsertSQL.Add('  ICONE,');
    InsertSQL.Add('  APRESENTACAO,');
    InsertSQL.Add('  AJUSTAR,');
    InsertSQL.Add('  FUNDO,');
    InsertSQL.Add('  FORMATODATA,');
    InsertSQL.Add('  CONFIRMASAIDA,');
    InsertSQL.Add('  MULTIPLASINSTANCIAS,');
    InsertSQL.Add('  HINTBALAO,');
    InsertSQL.Add('  MENUXP,');
    InsertSQL.Add('  DICIONARIO,');
    InsertSQL.Add('  CONTROLEACESSO,');
    InsertSQL.Add('  PASTADICIONARIO,');
    InsertSQL.Add('  SENHA,');
    InsertSQL.Add('  LINGUAGEM,');
    InsertSQL.Add('  BDADOS,');
    InsertSQL.Add('  NSERVIDOR,');
    InsertSQL.Add('  BDCONEXAO,');
    InsertSQL.Add('  SELECIONAR_EMP,');
    InsertSQL.Add('  DEIXAR_NA_SENHA,');
    InsertSQL.Add('  MODELO,');
    InsertSQL.Add('  CONTROLE_ACESSO_INTERNO,');
    InsertSQL.Add('  TABELAS_UTILIZADAS,');
    InsertSQL.Add('  OBJETOS_PROJETO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :TITULO_P,');
    InsertSQL.Add('  :EMPRESA,');
    InsertSQL.Add('  :ANALISTA,');
    InsertSQL.Add('  :PROGRAMADOR,');
    InsertSQL.Add('  :VERSAO_P,');
    InsertSQL.Add('  :INICIO,');
    InsertSQL.Add('  :ICONE,');
    InsertSQL.Add('  :APRESENTACAO,');
    InsertSQL.Add('  :AJUSTAR,');
    InsertSQL.Add('  :FUNDO,');
    InsertSQL.Add('  :FORMATODATA,');
    InsertSQL.Add('  :CONFIRMASAIDA,');
    InsertSQL.Add('  :MULTIPLASINSTANCIAS,');
    InsertSQL.Add('  :HINTBALAO,');
    InsertSQL.Add('  :MENUXP,');
    InsertSQL.Add('  :DICIONARIO,');
    InsertSQL.Add('  :CONTROLEACESSO,');
    InsertSQL.Add('  :PASTADICIONARIO,');
    InsertSQL.Add('  :SENHA,');
    InsertSQL.Add('  :LINGUAGEM,');
    InsertSQL.Add('  :BDADOS,');
    InsertSQL.Add('  :NSERVIDOR,');
    InsertSQL.Add('  :BDCONEXAO,');
    InsertSQL.Add('  :SELECIONAR_EMP,');
    InsertSQL.Add('  :DEIXAR_NA_SENHA,');
    InsertSQL.Add('  :MODELO,');
    InsertSQL.Add('  :CONTROLE_ACESSO_INTERNO,');
    InsertSQL.Add('  :TABELAS_UTILIZADAS,');
    InsertSQL.Add('  :OBJETOS_PROJETO');
    InsertSQL.Add('  )');
    // Modifica��o de Registro
    ModifySQL.Add('update PROJETO');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  TITULO_P = :TITULO_P,');
    ModifySQL.Add('  EMPRESA = :EMPRESA,');
    ModifySQL.Add('  ANALISTA = :ANALISTA,');
    ModifySQL.Add('  PROGRAMADOR = :PROGRAMADOR,');
    ModifySQL.Add('  VERSAO_P = :VERSAO_P,');
    ModifySQL.Add('  INICIO = :INICIO,');
    ModifySQL.Add('  ICONE = :ICONE,');
    ModifySQL.Add('  APRESENTACAO = :APRESENTACAO,');
    ModifySQL.Add('  AJUSTAR = :AJUSTAR,');
    ModifySQL.Add('  FUNDO = :FUNDO,');
    ModifySQL.Add('  FORMATODATA = :FORMATODATA,');
    ModifySQL.Add('  CONFIRMASAIDA = :CONFIRMASAIDA,');
    ModifySQL.Add('  MULTIPLASINSTANCIAS = :MULTIPLASINSTANCIAS,');
    ModifySQL.Add('  HINTBALAO = :HINTBALAO,');
    ModifySQL.Add('  MENUXP = :MENUXP,');
    ModifySQL.Add('  DICIONARIO = :DICIONARIO,');
    ModifySQL.Add('  CONTROLEACESSO = :CONTROLEACESSO,');
    ModifySQL.Add('  PASTADICIONARIO = :PASTADICIONARIO,');
    ModifySQL.Add('  SENHA = :SENHA,');
    ModifySQL.Add('  LINGUAGEM = :LINGUAGEM,');
    ModifySQL.Add('  BDADOS = :BDADOS,');
    ModifySQL.Add('  NSERVIDOR = :NSERVIDOR,');
    ModifySQL.Add('  BDCONEXAO = :BDCONEXAO,');
    ModifySQL.Add('  SELECIONAR_EMP = :SELECIONAR_EMP,');
    ModifySQL.Add('  DEIXAR_NA_SENHA = :DEIXAR_NA_SENHA,');
    ModifySQL.Add('  MODELO = :MODELO,');
    ModifySQL.Add('  CONTROLE_ACESSO_INTERNO = :CONTROLE_ACESSO_INTERNO,');
    ModifySQL.Add('  TABELAS_UTILIZADAS = :TABELAS_UTILIZADAS,');
    ModifySQL.Add('  OBJETOS_PROJETO = :OBJETOS_PROJETO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  TITULO_P,');
    RefreshSQL.Add('  EMPRESA,');
    RefreshSQL.Add('  ANALISTA,');
    RefreshSQL.Add('  PROGRAMADOR,');
    RefreshSQL.Add('  VERSAO_P,');
    RefreshSQL.Add('  INICIO,');
    RefreshSQL.Add('  ICONE,');
    RefreshSQL.Add('  APRESENTACAO,');
    RefreshSQL.Add('  AJUSTAR,');
    RefreshSQL.Add('  FUNDO,');
    RefreshSQL.Add('  FORMATODATA,');
    RefreshSQL.Add('  CONFIRMASAIDA,');
    RefreshSQL.Add('  MULTIPLASINSTANCIAS,');
    RefreshSQL.Add('  HINTBALAO,');
    RefreshSQL.Add('  MENUXP,');
    RefreshSQL.Add('  DICIONARIO,');
    RefreshSQL.Add('  CONTROLEACESSO,');
    RefreshSQL.Add('  PASTADICIONARIO,');
    RefreshSQL.Add('  SENHA,');
    RefreshSQL.Add('  LINGUAGEM,');
    RefreshSQL.Add('  BDADOS,');
    RefreshSQL.Add('  NSERVIDOR,');
    RefreshSQL.Add('  BDCONEXAO,');
    RefreshSQL.Add('  SELECIONAR_EMP,');
    RefreshSQL.Add('  DEIXAR_NA_SENHA,');
    RefreshSQL.Add('  MODELO,');
    RefreshSQL.Add('  CONTROLE_ACESSO_INTERNO,');
    RefreshSQL.Add('  TABELAS_UTILIZADAS,');
    RefreshSQL.Add('  OBJETOS_PROJETO');
    RefreshSQL.Add('from PROJETO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  TITULO_P,');
  SqlPrincipal.Add('  EMPRESA,');
  SqlPrincipal.Add('  ANALISTA,');
  SqlPrincipal.Add('  PROGRAMADOR,');
  SqlPrincipal.Add('  VERSAO_P,');
  SqlPrincipal.Add('  INICIO,');
  SqlPrincipal.Add('  ICONE,');
  SqlPrincipal.Add('  APRESENTACAO,');
  SqlPrincipal.Add('  AJUSTAR,');
  SqlPrincipal.Add('  FUNDO,');
  SqlPrincipal.Add('  FORMATODATA,');
  SqlPrincipal.Add('  CONFIRMASAIDA,');
  SqlPrincipal.Add('  MULTIPLASINSTANCIAS,');
  SqlPrincipal.Add('  HINTBALAO,');
  SqlPrincipal.Add('  MENUXP,');
  SqlPrincipal.Add('  DICIONARIO,');
  SqlPrincipal.Add('  CONTROLEACESSO,');
  SqlPrincipal.Add('  PASTADICIONARIO,');
  SqlPrincipal.Add('  SENHA,');
  SqlPrincipal.Add('  LINGUAGEM,');
  SqlPrincipal.Add('  BDADOS,');
  SqlPrincipal.Add('  NSERVIDOR,');
  SqlPrincipal.Add('  BDCONEXAO,');
  SqlPrincipal.Add('  SELECIONAR_EMP,');
  SqlPrincipal.Add('  DEIXAR_NA_SENHA,');
  SqlPrincipal.Add('  MODELO,');
  SqlPrincipal.Add('  CONTROLE_ACESSO_INTERNO,');
  SqlPrincipal.Add('  TABELAS_UTILIZADAS,');
  SqlPrincipal.Add('  OBJETOS_PROJETO');
  SqlPrincipal.Add('from PROJETO');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NUMERO := TDPROJETONUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  TITULO_P := TDPROJETOTITULO_P.Create(AOwner);
  TITULO_P.Valor.DataSet := Self;
  EMPRESA := TDPROJETOEMPRESA.Create(AOwner);
  EMPRESA.Valor.DataSet := Self;
  ANALISTA := TDPROJETOANALISTA.Create(AOwner);
  ANALISTA.Valor.DataSet := Self;
  PROGRAMADOR := TDPROJETOPROGRAMADOR.Create(AOwner);
  PROGRAMADOR.Valor.DataSet := Self;
  VERSAO_P := TDPROJETOVERSAO_P.Create(AOwner);
  VERSAO_P.Valor.DataSet := Self;
  INICIO := TDPROJETOINICIO.Create(AOwner);
  INICIO.Valor.DataSet := Self;
  ICONE := TDPROJETOICONE.Create(AOwner);
  ICONE.Valor.DataSet := Self;
  APRESENTACAO := TDPROJETOAPRESENTACAO.Create(AOwner);
  APRESENTACAO.Valor.DataSet := Self;
  AJUSTAR := TDPROJETOAJUSTAR.Create(AOwner);
  AJUSTAR.Valor.DataSet := Self;
  FUNDO := TDPROJETOFUNDO.Create(AOwner);
  FUNDO.Valor.DataSet := Self;
  FORMATODATA := TDPROJETOFORMATODATA.Create(AOwner);
  FORMATODATA.Valor.DataSet := Self;
  CONFIRMASAIDA := TDPROJETOCONFIRMASAIDA.Create(AOwner);
  CONFIRMASAIDA.Valor.DataSet := Self;
  MULTIPLASINSTANCIAS := TDPROJETOMULTIPLASINSTANCIAS.Create(AOwner);
  MULTIPLASINSTANCIAS.Valor.DataSet := Self;
  HINTBALAO := TDPROJETOHINTBALAO.Create(AOwner);
  HINTBALAO.Valor.DataSet := Self;
  MENUXP := TDPROJETOMENUXP.Create(AOwner);
  MENUXP.Valor.DataSet := Self;
  DICIONARIO := TDPROJETODICIONARIO.Create(AOwner);
  DICIONARIO.Valor.DataSet := Self;
  CONTROLEACESSO := TDPROJETOCONTROLEACESSO.Create(AOwner);
  CONTROLEACESSO.Valor.DataSet := Self;
  PASTADICIONARIO := TDPROJETOPASTADICIONARIO.Create(AOwner);
  PASTADICIONARIO.Valor.DataSet := Self;
  SENHA := TDPROJETOSENHA.Create(AOwner);
  SENHA.Valor.DataSet := Self;
  LINGUAGEM := TDPROJETOLINGUAGEM.Create(AOwner);
  LINGUAGEM.Valor.DataSet := Self;
  BDADOS := TDPROJETOBDADOS.Create(AOwner);
  BDADOS.Valor.DataSet := Self;
  NSERVIDOR := TDPROJETONSERVIDOR.Create(AOwner);
  NSERVIDOR.Valor.DataSet := Self;
  BDCONEXAO := TDPROJETOBDCONEXAO.Create(AOwner);
  BDCONEXAO.Valor.DataSet := Self;
  SELECIONAR_EMP := TDPROJETOSELECIONAR_EMP.Create(AOwner);
  SELECIONAR_EMP.Valor.DataSet := Self;
  DEIXAR_NA_SENHA := TDPROJETODEIXAR_NA_SENHA.Create(AOwner);
  DEIXAR_NA_SENHA.Valor.DataSet := Self;
  MODELO := TDPROJETOMODELO.Create(AOwner);
  MODELO.Valor.DataSet := Self;
  CONTROLE_ACESSO_INTERNO := TDPROJETOCONTROLE_ACESSO_INTERNO.Create(AOwner);
  CONTROLE_ACESSO_INTERNO.Valor.DataSet := Self;
  TABELAS_UTILIZADAS := TDPROJETOTABELAS_UTILIZADAS.Create(AOwner);
  TABELAS_UTILIZADAS.Valor.DataSet := Self;
  OBJETOS_PROJETO := TDPROJETOOBJETOS_PROJETO.Create(AOwner);
  OBJETOS_PROJETO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(TITULO_P);
  Campos.Add(EMPRESA);
  Campos.Add(ANALISTA);
  Campos.Add(PROGRAMADOR);
  Campos.Add(VERSAO_P);
  Campos.Add(INICIO);
  Campos.Add(ICONE);
  Campos.Add(APRESENTACAO);
  Campos.Add(AJUSTAR);
  Campos.Add(FUNDO);
  Campos.Add(FORMATODATA);
  Campos.Add(CONFIRMASAIDA);
  Campos.Add(MULTIPLASINSTANCIAS);
  Campos.Add(HINTBALAO);
  Campos.Add(MENUXP);
  Campos.Add(DICIONARIO);
  Campos.Add(CONTROLEACESSO);
  Campos.Add(PASTADICIONARIO);
  Campos.Add(SENHA);
  Campos.Add(LINGUAGEM);
  Campos.Add(BDADOS);
  Campos.Add(NSERVIDOR);
  Campos.Add(BDCONEXAO);
  Campos.Add(SELECIONAR_EMP);
  Campos.Add(DEIXAR_NA_SENHA);
  Campos.Add(MODELO);
  Campos.Add(CONTROLE_ACESSO_INTERNO);
  Campos.Add(TABELAS_UTILIZADAS);
  Campos.Add(OBJETOS_PROJETO);
  TituloIndice   := 'N�mero';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDPROJETO.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDPROJETO.ExclusaoCascata;
begin
  
end;

end.
