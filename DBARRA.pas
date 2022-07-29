{
 Classe da tabela: BARRA - Definição do Menu
}

unit DBARRA;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0014,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDBARRA = class(TTabela)
  public
    NUMERO: TDBARRANUMERO;
    NIVEL_M: TDBARRANIVEL_M;
    NOME: TDBARRANOME;
    TIPO: TDBARRATIPO;
    TITULO_M: TDBARRATITULO_M;
    IMAGEM: TDBARRAIMAGEM;
    FORMULARIO: TDBARRAFORMULARIO;
    AVULSO: TDBARRAAVULSO;
    PROG_EXE: TDBARRAPROG_EXE;
    IDENTIFICACAO: TDBARRAIDENTIFICACAO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas;

constructor TDBARRA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'BARRA';
  Titulo           := 'Definição do BARRA';
  Name             := 'DBARRA';
  Database         := BaseDados.BD_Base_Projeto;
  Transaction      := BaseDados.TRS_BD_Base_Projeto;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsBARRA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_BARRA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from BARRA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into BARRA');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  NIVEL_M,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  TIPO,');
    InsertSQL.Add('  TITULO_M,');
    InsertSQL.Add('  IMAGEM,');
    InsertSQL.Add('  FORMULARIO,');
    InsertSQL.Add('  AVULSO,');
    InsertSQL.Add('  PROG_EXE,');
    InsertSQL.Add('  IDENTIFICACAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :NIVEL_M,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :TIPO,');
    InsertSQL.Add('  :TITULO_M,');
    InsertSQL.Add('  :IMAGEM,');
    InsertSQL.Add('  :FORMULARIO,');
    InsertSQL.Add('  :AVULSO,');
    InsertSQL.Add('  :PROG_EXE,');
    InsertSQL.Add('  :IDENTIFICACAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update BARRA');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  NIVEL_M = :NIVEL_M,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  TIPO = :TIPO,');
    ModifySQL.Add('  TITULO_M = :TITULO_M,');
    ModifySQL.Add('  IMAGEM = :IMAGEM,');
    ModifySQL.Add('  FORMULARIO = :FORMULARIO,');
    ModifySQL.Add('  AVULSO = :AVULSO,');
    ModifySQL.Add('  PROG_EXE = :PROG_EXE,');
    ModifySQL.Add('  IDENTIFICACAO = :IDENTIFICACAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  NIVEL_M,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  TIPO,');
    RefreshSQL.Add('  TITULO_M,');
    RefreshSQL.Add('  IMAGEM,');
    RefreshSQL.Add('  FORMULARIO,');
    RefreshSQL.Add('  AVULSO,');
    RefreshSQL.Add('  PROG_EXE,');
    RefreshSQL.Add('  IDENTIFICACAO');
    RefreshSQL.Add('from BARRA');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  NIVEL_M,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  TIPO,');
  SqlPrincipal.Add('  TITULO_M,');
  SqlPrincipal.Add('  IMAGEM,');
  SqlPrincipal.Add('  FORMULARIO,');
  SqlPrincipal.Add('  AVULSO,');
  SqlPrincipal.Add('  PROG_EXE,');
  SqlPrincipal.Add('  IDENTIFICACAO');
  SqlPrincipal.Add('from BARRA');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NUMERO := TDBARRANUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  NIVEL_M := TDBARRANIVEL_M.Create(AOwner);
  NIVEL_M.Valor.DataSet := Self;
  NOME := TDBARRANOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  TIPO := TDBARRATIPO.Create(AOwner);
  TIPO.Valor.DataSet := Self;
  TITULO_M := TDBARRATITULO_M.Create(AOwner);
  TITULO_M.Valor.DataSet := Self;
  IMAGEM := TDBARRAIMAGEM.Create(AOwner);
  IMAGEM.Valor.DataSet := Self;
  FORMULARIO := TDBARRAFORMULARIO.Create(AOwner);
  FORMULARIO.Valor.DataSet := Self;
  AVULSO := TDBARRAAVULSO.Create(AOwner);
  AVULSO.Valor.DataSet := Self;
  PROG_EXE := TDBARRAPROG_EXE.Create(AOwner);
  PROG_EXE.Valor.DataSet := Self;
  IDENTIFICACAO := TDBARRAIDENTIFICACAO.Create(AOwner);
  IDENTIFICACAO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(NIVEL_M);
  Campos.Add(NOME);
  Campos.Add(TIPO);
  Campos.Add(TITULO_M);
  Campos.Add(IMAGEM);
  Campos.Add(FORMULARIO);
  Campos.Add(AVULSO);
  Campos.Add(PROG_EXE);
  Campos.Add(IDENTIFICACAO);
  TituloIndice   := 'Número';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDBARRA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
end;

procedure TDBARRA.ExclusaoCascata;
begin

end;

end.
