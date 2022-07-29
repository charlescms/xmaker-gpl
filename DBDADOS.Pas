{
 Classe da tabela: BDADOS - Definição da Base de Dados
}

unit DBDADOS;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0003,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDBDADOS = class(TTabela)
  public
    NUMERO: TDBDADOSNUMERO;
    NOME: TDBDADOSNOME;
    ARQUIVO: TDBDADOSARQUIVO;
    LOGIN: TDBDADOSLOGIN;
    USUARIO: TDBDADOSUSUARIO;
    SENHA: TDBDADOSSENHA;
    PARAMETROS: TDBDADOSPARAMETROS;
    HOST_NAME: TDBDADOS_HOST_NAME;
    BDADOS: TDBDADOSBDADOS;
    PADRAO: TDBDADOSPADRAO;
    DDTABELAS: TTabela;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas, Abertura;

constructor TDBDADOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'BDADOS';
  Titulo           := 'Definição da Base de Dados';
  Name             := 'DBDADOS';
  Database         := BaseDados.BD_Base_Dicionario;
  Transaction      := BaseDados.TRS_BD_Base_Dicionario;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsBDADOS';
  with UpdateSql do
  begin
    Name           := 'UpdSql_BDADOS';
    // Exclusão de Registro
    DeleteSQL.Add('delete from BDADOS');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into BDADOS');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  ARQUIVO,');
    InsertSQL.Add('  LOGIN,');
    InsertSQL.Add('  USUARIO,');
    InsertSQL.Add('  SENHA,');
    InsertSQL.Add('  PARAMETROS,');
    InsertSQL.Add('  HOST_NAME,');
    InsertSQL.Add('  BDADOS,');
    InsertSQL.Add('  PADRAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :ARQUIVO,');
    InsertSQL.Add('  :LOGIN,');
    InsertSQL.Add('  :USUARIO,');
    InsertSQL.Add('  :SENHA,');
    InsertSQL.Add('  :PARAMETROS,');
    InsertSQL.Add('  :HOST_NAME,');
    InsertSQL.Add('  :BDADOS,');
    InsertSQL.Add('  :PADRAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update BDADOS');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  ARQUIVO = :ARQUIVO,');
    ModifySQL.Add('  LOGIN = :LOGIN,');
    ModifySQL.Add('  USUARIO = :USUARIO,');
    ModifySQL.Add('  SENHA = :SENHA,');
    ModifySQL.Add('  PARAMETROS = :PARAMETROS,');
    ModifySQL.Add('  HOST_NAME = :HOST_NAME,');
    ModifySQL.Add('  BDADOS = :BDADOS,');
    ModifySQL.Add('  PADRAO = :PADRAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  ARQUIVO,');
    RefreshSQL.Add('  LOGIN,');
    RefreshSQL.Add('  USUARIO,');
    RefreshSQL.Add('  SENHA,');
    RefreshSQL.Add('  PARAMETROS,');
    RefreshSQL.Add('  HOST_NAME,');
    RefreshSQL.Add('  BDADOS,');
    RefreshSQL.Add('  PADRAO');
    RefreshSQL.Add('from BDADOS');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  ARQUIVO,');
  SqlPrincipal.Add('  LOGIN,');
  SqlPrincipal.Add('  USUARIO,');
  SqlPrincipal.Add('  SENHA,');
  SqlPrincipal.Add('  PARAMETROS,');
  SqlPrincipal.Add('  HOST_NAME,');
  SqlPrincipal.Add('  BDADOS,');
  SqlPrincipal.Add('  PADRAO');
  SqlPrincipal.Add('from BDADOS');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  PADRAO := TDBDADOSPADRAO.Create(AOwner);
  PADRAO.Valor.DataSet := Self;
  BDADOS := TDBDADOSBDADOS.Create(AOwner);
  BDADOS.Valor.DataSet := Self;
  NOME := TDBDADOSNOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  ARQUIVO := TDBDADOSARQUIVO.Create(AOwner);
  ARQUIVO.Valor.DataSet := Self;
  LOGIN := TDBDADOSLOGIN.Create(AOwner);
  LOGIN.Valor.DataSet := Self;
  USUARIO := TDBDADOSUSUARIO.Create(AOwner);
  USUARIO.Valor.DataSet := Self;
  SENHA := TDBDADOSSENHA.Create(AOwner);
  SENHA.Valor.DataSet := Self;
  HOST_NAME := TDBDADOS_HOST_NAME.Create(AOwner);
  HOST_NAME.Valor.DataSet := Self;
  PARAMETROS := TDBDADOSPARAMETROS.Create(AOwner);
  PARAMETROS.Valor.DataSet := Self;
  NUMERO := TDBDADOSNUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(NOME);
  Campos.Add(ARQUIVO);
  Campos.Add(LOGIN);
  Campos.Add(USUARIO);
  Campos.Add(SENHA);
  Campos.Add(PARAMETROS);
  Campos.Add(HOST_NAME);
  Campos.Add(BDADOS);
  Campos.Add(PADRAO);
  TituloIndice   := 'Número';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDBDADOS.PodeExcluir: Boolean;
Var
  QueryP: TIBQuery;
begin
  PodeExcluir := True;
  //Integridade Referencial Tabela: DTABELAS
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DTABELAS.DataBase;
  QueryP.SQL.Text := 'Select BASE From Tabelas Where '+ '(BASE = '+IntToStr(NUMERO.Conteudo) +')';
  QueryP.Open;
  QueryP.First;
  if Not QueryP.Eof then
  begin
    Mensagem('Registro está ligado a tabela: '+TabGlobal_i.DTABELAS.Titulo,modErro,[modOk]);
    PodeExcluir := False;
  end;
  QueryP.Close;
  QueryP.Free;
end;

procedure TDBDADOS.ExclusaoCascata;
begin

end;

end.
