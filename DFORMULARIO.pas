{
 Classe da tabela: FORMULARIO - Definição de Formulários
}

unit DFORMULARIO;

interface

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0001,
     DB, IBQuery, IBDataBase, IBUpdateSQL, Dialogs;

type
  TDFORMULARIO = class(TTabela)
  public
    NUMERO: TDFORMULARIONUMERO;
    NOME: TDFORMULARIONOME;
    TIPO: TDFORMULARIOTIPO;
    TITULO_F: TDFORMULARIOTITULO_F;
    TABELA: TDFORMULARIOTABELA;
    MODELO: TDFORMULARIOMODELO;
    DDMENU: TTabela;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
  end;

implementation

uses Publicas,
  Rotinas, Abertura;

constructor TDFORMULARIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'FORMULARIO';
  Titulo           := 'Definição de Formulários';
  Name             := 'DFORMULARIO';
  Database         := BaseDados.BD_Base_Projeto;
  Transaction      := BaseDados.TRS_BD_Base_Projeto;
  Versao           := 6;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  DataSource.Name  := 'DsFORMULARIO';
  with UpdateSql do
  begin
    Name           := 'UpdSql_FORMULARIO';
    // Exclusão de Registro
    DeleteSQL.Add('delete from FORMULARIO');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  NUMERO = :OLD_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into FORMULARIO');
    InsertSQL.Add('  (');
    InsertSQL.Add('  NUMERO,');
    InsertSQL.Add('  NOME,');
    InsertSQL.Add('  TIPO,');
    InsertSQL.Add('  TITULO_F,');
    InsertSQL.Add('  TABELA,');
    InsertSQL.Add('  MODELO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :NUMERO,');
    InsertSQL.Add('  :NOME,');
    InsertSQL.Add('  :TIPO,');
    InsertSQL.Add('  :TITULO_F,');
    InsertSQL.Add('  :TABELA,');
    InsertSQL.Add('  :MODELO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update FORMULARIO');
    ModifySQL.Add('set');
    ModifySQL.Add('  NUMERO = :NUMERO,');
    ModifySQL.Add('  NOME = :NOME,');
    ModifySQL.Add('  TIPO = :TIPO,');
    ModifySQL.Add('  TITULO_F = :TITULO_F,');
    ModifySQL.Add('  TABELA = :TABELA,');
    ModifySQL.Add('  MODELO = :MODELO');
    ModifySQL.Add('where');
    ModifySQL.Add('  NUMERO = :OLD_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  NUMERO,');
    RefreshSQL.Add('  NOME,');
    RefreshSQL.Add('  TIPO,');
    RefreshSQL.Add('  TITULO_F,');
    RefreshSQL.Add('  TABELA,');
    RefreshSQL.Add('  MODELO');
    RefreshSQL.Add('from FORMULARIO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  NUMERO = :NUMERO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  NUMERO,');
  SqlPrincipal.Add('  NOME,');
  SqlPrincipal.Add('  TIPO,');
  SqlPrincipal.Add('  TITULO_F,');
  SqlPrincipal.Add('  TABELA,');
  SqlPrincipal.Add('  MODELO');
  SqlPrincipal.Add('from FORMULARIO');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by NUMERO');
  NUMERO := TDFORMULARIONUMERO.Create(AOwner);
  NUMERO.Valor.DataSet := Self;
  NOME := TDFORMULARIONOME.Create(AOwner);
  NOME.Valor.DataSet := Self;
  TIPO := TDFORMULARIOTIPO.Create(AOwner);
  TIPO.Valor.DataSet := Self;
  TITULO_F := TDFORMULARIOTITULO_F.Create(AOwner);
  TITULO_F.Valor.DataSet := Self;
  TABELA := TDFORMULARIOTABELA.Create(AOwner);
  TABELA.Valor.DataSet := Self;
  MODELO := TDFORMULARIOMODELO.Create(AOwner);
  MODELO.Valor.DataSet := Self;
  ChavePrimaria.Add(NUMERO);
  Campos.Add(NUMERO);
  Campos.Add(NOME);
  Campos.Add(TIPO);
  Campos.Add(TITULO_F);
  Campos.Add(TABELA);
  Campos.Add(MODELO);
  TituloIndice   := 'Número';
  ChaveIndice    := 'NUMERO';
  TituloPrimaria := TituloIndice;
  ChPrimaria     := ChaveIndice;
end;

function TDFORMULARIO.PodeExcluir: Boolean;
Var
  QueryP: TIBQuery;
begin
  PodeExcluir := True;
  //Integridade Referencial Tabela: DMENU
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DMENU.DataBase;
  QueryP.SQL.Text := 'Select FORMULARIO From MENU Where '+ '(FORMULARIO = '+IntToStr(NUMERO.Conteudo) +')';
  QueryP.Open;
  QueryP.First;
  if Not QueryP.Eof then
  begin
    Mensagem('Registro está ligado a tabela: '+TabGlobal_i.DMENU.Titulo,modErro,[modOk]);
    PodeExcluir := False;
  end;
  QueryP.Close;
  QueryP.Free;
end;

procedure TDFORMULARIO.ExclusaoCascata;
Var
  QueryP: TIBQuery;
begin
  QueryP := TIBQuery.Create(Self);
  // Exclusão em Cascata Tabela: DRELATORIO
  QueryP.DataBase := TabGlobal_i.DRELATORIO.DataBase;
  QueryP.Transaction := TabGlobal_i.DRELATORIO.Transaction;
  QueryP.Sql.Clear;
  QueryP.Sql.Add('Delete From RELATORIO');
  QueryP.Sql.Add('       Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NUMERO.Conteudo) +')');
  QueryP.ExecSql;
  QueryP.Close;
  QueryP.Free;
end;

end.
