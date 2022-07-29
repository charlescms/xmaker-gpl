{
 Classe da tabela: TABELAS - Definição de Tabelas
}

unit DTABELAS;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0004,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDTABELAS = class(TTabela)
  public
    NUMERO: TDTABELASNUMERO;
    NOME: TDTABELASNOME;
    TITULO_T: TDTABELASTITULO_T;
    BASE: TDTABELASBASE;
    FILTRO_INICIAL: TDTABELASFILTRO_INICIAL;
    FILTRO_MESTRE: TDTABELASFILTRO_MESTRE;
    ORDEM_INICIAL: TDTABELASORDEM_INICIAL;
    ORDEM_DECRESCENTE: TDTABELASORDEM_DECRESCENTE;
    NOME_INTERNO: TDTABELASNOME_INTERNO;
    GLOBAL: TDTABELASGLOBAL;
    ABRIR_TABELA: TDTABELASABRIR_TABELA;
    USE_GENERATOR: TDTABELASUSE_GENERATOR;
    //REGERAR: TDTABELASREGERAR;
    DDCAMPOST: TTabela;
    DDINDICEST: TTabela;
    DDCASCATAT: TTabela;
    DDRESTRITAT: TTabela;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas, Abertura;

constructor TDTABELAS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'TABELAS';
  Titulo           := 'Definição de Tabelas';
  Name             := 'DTABELAS';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsTABELAS';
  with UpdateSql do
  begin
    Name           := 'UpdSql_TABELAS';
    // Exclusão de Registro
    DeleteSQL.Add('delete from TABELAS');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into TABELAS');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  TITULO_T,');
    InsertSQL.Add('  BASE,');
    InsertSQL.Add('  FILTRO_INICIAL,');
    InsertSQL.Add('  FILTRO_MESTRE,');
    InsertSQL.Add('  ORDEM_INICIAL,');
    InsertSQL.Add('  ORDEM_DECRESCENTE,');
    InsertSQL.Add('  NOME_INTERNO,');
    InsertSQL.Add('  GLOBAL,');
    InsertSQL.Add('  ABRIR_TABELA,');
    InsertSQL.Add('  USE_GENERATOR');
    //InsertSQL.Add('  REGERAR');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :TITULO_T,');
    InsertSQL.Add('  :BASE,');
    InsertSQL.Add('  :FILTRO_INICIAL,');
    InsertSQL.Add('  :FILTRO_MESTRE,');
    InsertSQL.Add('  :ORDEM_INICIAL,');
    InsertSQL.Add('  :ORDEM_DECRESCENTE,');
    InsertSQL.Add('  :NOME_INTERNO,');
    InsertSQL.Add('  :GLOBAL,');
    InsertSQL.Add('  :ABRIR_TABELA,');
    InsertSQL.Add('  :USE_GENERATOR');
    //InsertSQL.Add('  :REGERAR');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update TABELAS');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  TITULO_T = :TITULO_T,');
    ModifySQL.Add('  BASE = :BASE,');
    ModifySQL.Add('  FILTRO_INICIAL = :FILTRO_INICIAL,');
    ModifySQL.Add('  FILTRO_MESTRE = :FILTRO_MESTRE,');
    ModifySQL.Add('  ORDEM_INICIAL = :ORDEM_INICIAL,');
    ModifySQL.Add('  ORDEM_DECRESCENTE = :ORDEM_DECRESCENTE,');
    ModifySQL.Add('  NOME_INTERNO = :NOME_INTERNO,');
    ModifySQL.Add('  GLOBAL = :GLOBAL,');
    ModifySQL.Add('  ABRIR_TABELA = :ABRIR_TABELA,');
    ModifySQL.Add('  USE_GENERATOR = :USE_GENERATOR');
    //ModifySQL.Add('  REGERAR = :REGERAR');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  TITULO_T,');
    RefreshSQL.Add('  BASE,');
    RefreshSQL.Add('  FILTRO_INICIAL,');
    RefreshSQL.Add('  FILTRO_MESTRE,');
    RefreshSQL.Add('  ORDEM_INICIAL,');
    RefreshSQL.Add('  ORDEM_DECRESCENTE,');
    RefreshSQL.Add('  NOME_INTERNO,');
    RefreshSQL.Add('  GLOBAL,');
    RefreshSQL.Add('  ABRIR_TABELA,');
    RefreshSQL.Add('  USE_GENERATOR');
    //RefreshSQL.Add('  REGERAR');
    RefreshSQL.Add('from TABELAS');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  TITULO_T,');
  SqlPrincipal.Add('  BASE,');
  SqlPrincipal.Add('  FILTRO_INICIAL,');
  SqlPrincipal.Add('  FILTRO_MESTRE,');
  SqlPrincipal.Add('  ORDEM_INICIAL,');
  SqlPrincipal.Add('  ORDEM_DECRESCENTE,');
  SqlPrincipal.Add('  NOME_INTERNO,');
  SqlPrincipal.Add('  GLOBAL,');
  SqlPrincipal.Add('  ABRIR_TABELA,');
  SqlPrincipal.Add('  USE_GENERATOR');
  //SqlPrincipal.Add('  REGERAR');
  SqlPrincipal.Add('from TABELAS');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NOME := TDTABELASNOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  NOME_INTERNO := TDTABELASNOME_INTERNO.Create(AOwner);
  NOME_INTERNO.Valor.DataSet := Self;
  TITULO_T := TDTABELASTITULO_T.Create(AOwner);
  TITULO_T.Valor.DataSet := Self;
  BASE := TDTABELASBASE.Create(AOwner);
  BASE.Valor.DataSet := Self;
  FILTRO_INICIAL := TDTABELASFILTRO_INICIAL.Create(AOwner);
  FILTRO_INICIAL.Valor.DataSet := Self;
  FILTRO_MESTRE := TDTABELASFILTRO_MESTRE.Create(AOwner);
  FILTRO_MESTRE.Valor.DataSet := Self;
  ORDEM_INICIAL := TDTABELASORDEM_INICIAL.Create(AOwner);
  ORDEM_INICIAL.Valor.DataSet := Self;
  GLOBAL := TDTABELASGLOBAL.Create(AOwner);
  GLOBAL.Valor.DataSet := Self;
  ABRIR_TABELA := TDTABELASABRIR_TABELA.Create(AOwner);
  ABRIR_TABELA.Valor.DataSet := Self;
  USE_GENERATOR := TDTABELASUSE_GENERATOR.Create(AOwner);
  USE_GENERATOR.Valor.DataSet := Self;
  //REGERAR := TDTABELASREGERAR.Create(AOwner);
  //REGERAR.Valor.DataSet := Self;
  NUMERO := TDTABELASNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  ORDEM_DECRESCENTE := TDTABELASORDEM_DECRESCENTE.Create(AOwner);
  ORDEM_DECRESCENTE.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(NOME);
  Campos.Add(TITULO_T);
  Campos.Add(BASE);
  Campos.Add(FILTRO_INICIAL);
  Campos.Add(FILTRO_MESTRE);
  Campos.Add(ORDEM_INICIAL);
  Campos.Add(ORDEM_DECRESCENTE);
  Campos.Add(NOME_INTERNO);
  Campos.Add(GLOBAL);
  Campos.Add(ABRIR_TABELA);
  Campos.Add(USE_GENERATOR);
  //Campos.Add(REGERAR);
  TituloIndice   := 'Número';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDTABELAS.PodeExcluir: Boolean;
Var
  QueryP: TIBQuery;
begin
  PodeExcluir := True;
  //Integridade Referencial Tabela: DFORMULARIO
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DFORMULARIO.DataBase;
  QueryP.SQL.Text := 'Select TABELA From FORMULARIO Where '+ '(TABELA = '+IntToStr(NUMERO.Conteudo) +')';
  QueryP.Open;
  QueryP.First;
  if Not QueryP.Eof then
  begin
    Mensagem('Registro está ligado a tabela: '+TabGlobal_i.DFORMULARIO.Titulo,modErro,[modOk]);
    PodeExcluir := False;
  end;
  QueryP.Close;
  QueryP.Free;
end;

procedure TDTABELAS.ExclusaoCascata;
Var
  QueryP: TIBQuery;
begin
  // Exclusão em Cascata Tabela: DCAMPOS
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DCAMPOST.DataBase;
  QueryP.Sql.Add('Delete From CAMPOST');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DINDICES
  QueryP.DataBase := TabGlobal_i.DINDICEST.DataBase;
  QueryP.Sql.Add('Delete From INDICEST');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DCASCATA
  QueryP.DataBase := TabGlobal_i.DCASCATAT.DataBase;
  QueryP.Sql.Add('Delete From CASCATAT');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DRESTRITA
  QueryP.DataBase := TabGlobal_i.DRESTRITAT.DataBase;
  QueryP.Sql.Add('Delete From RESTRITAT');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DRELACIONA
  QueryP.DataBase := TabGlobal_i.DRELACIONA.DataBase;
  QueryP.Sql.Add('Delete From RELACIONA');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DPROCESSOS
  QueryP.DataBase := TabGlobal_i.DPROCESSOS.DataBase;
  QueryP.Sql.Add('Delete From PROCESSOS');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DCALCULADOS
  QueryP.DataBase := TabGlobal_i.DCALCULADOS.DataBase;
  QueryP.Sql.Add('Delete From CALCULADOS');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  // Exclusão em Cascata Tabela: DTRIGGER
  QueryP.DataBase := TabGlobal_i.DTRIGGER.DataBase;
  QueryP.Sql.Add('Delete From TRIGGER_I');
  QueryP.Sql.Add('  Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Sql.Clear;

  QueryP.Close;
  QueryP.Free;
end;

end.
