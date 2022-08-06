{
 Classe da tabela: Fornecedores - Tabela de Fornecedores
}

unit DFornecedores;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0003,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDFornecedores = class(TTabela)
  public
    FOR_CODIGO: TDFornecedores_FOR_CODIGO;
    FOR_NOME: TDFornecedores_FOR_NOME;
    FOR_ENDERECO: TDFornecedores_FOR_ENDERECO;
    FOR_BAIRRO: TDFornecedores_FOR_BAIRRO;
    FOR_CIDADE: TDFornecedores_FOR_CIDADE;
    UF: TDFornecedores_UF;
    CEP: TDFornecedores_CEP;
    TELEFONE: TDFornecedores_TELEFONE;
    TELEFONE_2: TDFornecedores_TELEFONE_2;
    CELULAR: TDFornecedores_CELULAR;
    EMAIL: TDFornecedores_EMAIL;
    SITE: TDFornecedores_SITE;
    FOR_OBS: TDFornecedores_FOR_OBS;
    FOR_CADASTRO: TDFornecedores_FOR_CADASTRO;
    constructor Create(AOwner: TComponent); override;
    procedure CriaForeignKeys; override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
    function PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean; overload; override;
    function PesquisaRelacionados(Tabela: String): Boolean; overload; override;
    procedure CalculaCampos; override;
    procedure Parametros(Tabela: TTabela); override;
    procedure AtribuiRelacionamentos(Atribui: Boolean = True); override;
    procedure AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True); override;
    procedure AtribuiMestre(DataSet: TDataSet); override;
    procedure ProcessoDireto1(DataSet: TDataSet);
    procedure ProcessoDireto2(DataSet: TDataSet);
    procedure AtualizaCalculados(DataSet: TDataSet);
    procedure ProcessoInverso1(DataSet: TDataSet);
    procedure ProcessoInverso2(DataSet: TDataSet);
  end;

implementation

uses Publicas, Validar, Rotinas, Abertura, Calculos, RotinaEd;

constructor TDFornecedores.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Fornecedores';
  Titulo           := 'Tabela de Fornecedores';
  Name             := 'DFornecedores';
  Database         := BaseDados.BD_Base_Dados;
  {$IFDEF IBX}
  Transaction      := BaseDados.TRS_BD_Base_Dados;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  {$ELSE}
  RequestLive      := True;
  AutoRefresh      := True;
  CachedUpdates    := True;
  UpdateSql        := TXSQLUpdateSQL.Create(AOwner);
  DatabaseName     := BaseDados.BD_Base_Dados.DatabaseName;
  {$ENDIF}
  Local            := False;
  Open_begin       := True;
  Versao           := 6;
  UsarGenerator    := True;
  TableType        := ttTable;
  DataSource.Name  := 'DsFornecedores';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Fornecedores';
    // Exclusão de Registro
    DeleteSQL.Add('delete from Fornecedores');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  FOR_CODIGO = :OLD_FOR_CODIGO');
    // Inserção de Registro
    InsertSQL.Add('insert into Fornecedores');
    InsertSQL.Add('  (');
    InsertSQL.Add('  FOR_CODIGO,');
    InsertSQL.Add('  FOR_NOME,');
    InsertSQL.Add('  FOR_ENDERECO,');
    InsertSQL.Add('  FOR_BAIRRO,');
    InsertSQL.Add('  FOR_CIDADE,');
    InsertSQL.Add('  UF,');
    InsertSQL.Add('  CEP,');
    InsertSQL.Add('  TELEFONE,');
    InsertSQL.Add('  TELEFONE_2,');
    InsertSQL.Add('  CELULAR,');
    InsertSQL.Add('  EMAIL,');
    InsertSQL.Add('  SITE,');
    InsertSQL.Add('  FOR_OBS,');
    InsertSQL.Add('  FOR_CADASTRO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :FOR_CODIGO,');
    InsertSQL.Add('  :FOR_NOME,');
    InsertSQL.Add('  :FOR_ENDERECO,');
    InsertSQL.Add('  :FOR_BAIRRO,');
    InsertSQL.Add('  :FOR_CIDADE,');
    InsertSQL.Add('  :UF,');
    InsertSQL.Add('  :CEP,');
    InsertSQL.Add('  :TELEFONE,');
    InsertSQL.Add('  :TELEFONE_2,');
    InsertSQL.Add('  :CELULAR,');
    InsertSQL.Add('  :EMAIL,');
    InsertSQL.Add('  :SITE,');
    InsertSQL.Add('  :FOR_OBS,');
    InsertSQL.Add('  :FOR_CADASTRO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update Fornecedores');
    ModifySQL.Add('set');
    ModifySQL.Add('  FOR_CODIGO = :FOR_CODIGO,');
    ModifySQL.Add('  FOR_NOME = :FOR_NOME,');
    ModifySQL.Add('  FOR_ENDERECO = :FOR_ENDERECO,');
    ModifySQL.Add('  FOR_BAIRRO = :FOR_BAIRRO,');
    ModifySQL.Add('  FOR_CIDADE = :FOR_CIDADE,');
    ModifySQL.Add('  UF = :UF,');
    ModifySQL.Add('  CEP = :CEP,');
    ModifySQL.Add('  TELEFONE = :TELEFONE,');
    ModifySQL.Add('  TELEFONE_2 = :TELEFONE_2,');
    ModifySQL.Add('  CELULAR = :CELULAR,');
    ModifySQL.Add('  EMAIL = :EMAIL,');
    ModifySQL.Add('  SITE = :SITE,');
    ModifySQL.Add('  FOR_OBS = :FOR_OBS,');
    ModifySQL.Add('  FOR_CADASTRO = :FOR_CADASTRO');
    ModifySQL.Add('where');
    ModifySQL.Add('  FOR_CODIGO = :OLD_FOR_CODIGO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Fornecedores.FOR_CODIGO AS FOR_CODIGO,');
    RefreshSQL.Add('  Fornecedores.FOR_NOME AS FOR_NOME,');
    RefreshSQL.Add('  Fornecedores.FOR_ENDERECO AS FOR_ENDERECO,');
    RefreshSQL.Add('  Fornecedores.FOR_BAIRRO AS FOR_BAIRRO,');
    RefreshSQL.Add('  Fornecedores.FOR_CIDADE AS FOR_CIDADE,');
    RefreshSQL.Add('  Fornecedores.UF AS UF,');
    RefreshSQL.Add('  Fornecedores.CEP AS CEP,');
    RefreshSQL.Add('  Fornecedores.TELEFONE AS TELEFONE,');
    RefreshSQL.Add('  Fornecedores.TELEFONE_2 AS TELEFONE_2,');
    RefreshSQL.Add('  Fornecedores.CELULAR AS CELULAR,');
    RefreshSQL.Add('  Fornecedores.EMAIL AS EMAIL,');
    RefreshSQL.Add('  Fornecedores.SITE AS SITE,');
    RefreshSQL.Add('  Fornecedores.FOR_OBS AS FOR_OBS,');
    RefreshSQL.Add('  Fornecedores.FOR_CADASTRO AS FOR_CADASTRO');
    RefreshSQL.Add('from Fornecedores');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Fornecedores.FOR_CODIGO = :OLD_FOR_CODIGO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Fornecedores.FOR_CODIGO AS FOR_CODIGO,');
  SqlPrincipal.Add('  Fornecedores.FOR_NOME AS FOR_NOME,');
  SqlPrincipal.Add('  Fornecedores.FOR_ENDERECO AS FOR_ENDERECO,');
  SqlPrincipal.Add('  Fornecedores.FOR_BAIRRO AS FOR_BAIRRO,');
  SqlPrincipal.Add('  Fornecedores.FOR_CIDADE AS FOR_CIDADE,');
  SqlPrincipal.Add('  Fornecedores.UF AS UF,');
  SqlPrincipal.Add('  Fornecedores.CEP AS CEP,');
  SqlPrincipal.Add('  Fornecedores.TELEFONE AS TELEFONE,');
  SqlPrincipal.Add('  Fornecedores.TELEFONE_2 AS TELEFONE_2,');
  SqlPrincipal.Add('  Fornecedores.CELULAR AS CELULAR,');
  SqlPrincipal.Add('  Fornecedores.EMAIL AS EMAIL,');
  SqlPrincipal.Add('  Fornecedores.SITE AS SITE,');
  SqlPrincipal.Add('  Fornecedores.FOR_OBS AS FOR_OBS,');
  SqlPrincipal.Add('  Fornecedores.FOR_CADASTRO AS FOR_CADASTRO');
  SqlPrincipal.Add('from Fornecedores');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by Fornecedores.FOR_CODIGO');
  FOR_CODIGO := TDFornecedores_FOR_CODIGO.Create(AOwner);
  FOR_CODIGO.Valor.DataSet := Self;
  FOR_NOME := TDFornecedores_FOR_NOME.Create(AOwner);
  FOR_NOME.Valor.DataSet := Self;
  FOR_CADASTRO := TDFornecedores_FOR_CADASTRO.Create(AOwner);
  FOR_CADASTRO.Valor.DataSet := Self;
  FOR_ENDERECO := TDFornecedores_FOR_ENDERECO.Create(AOwner);
  FOR_ENDERECO.Valor.DataSet := Self;
  FOR_BAIRRO := TDFornecedores_FOR_BAIRRO.Create(AOwner);
  FOR_BAIRRO.Valor.DataSet := Self;
  FOR_CIDADE := TDFornecedores_FOR_CIDADE.Create(AOwner);
  FOR_CIDADE.Valor.DataSet := Self;
  UF := TDFornecedores_UF.Create(AOwner);
  UF.Valor.DataSet := Self;
  CEP := TDFornecedores_CEP.Create(AOwner);
  CEP.Valor.DataSet := Self;
  TELEFONE := TDFornecedores_TELEFONE.Create(AOwner);
  TELEFONE.Valor.DataSet := Self;
  TELEFONE_2 := TDFornecedores_TELEFONE_2.Create(AOwner);
  TELEFONE_2.Valor.DataSet := Self;
  CELULAR := TDFornecedores_CELULAR.Create(AOwner);
  CELULAR.Valor.DataSet := Self;
  EMAIL := TDFornecedores_EMAIL.Create(AOwner);
  EMAIL.Valor.DataSet := Self;
  SITE := TDFornecedores_SITE.Create(AOwner);
  SITE.Valor.DataSet := Self;
  FOR_OBS := TDFornecedores_FOR_OBS.Create(AOwner);
  FOR_OBS.Valor.DataSet := Self;
  ChavePrimaria.Add(FOR_CODIGO);
  Campos.Add(FOR_CODIGO);
  Campos.Add(FOR_NOME);
  Campos.Add(FOR_ENDERECO);
  Campos.Add(FOR_BAIRRO);
  Campos.Add(FOR_CIDADE);
  Campos.Add(UF);
  Campos.Add(CEP);
  Campos.Add(TELEFONE);
  Campos.Add(TELEFONE_2);
  Campos.Add(CELULAR);
  Campos.Add(EMAIL);
  Campos.Add(SITE);
  Campos.Add(FOR_OBS);
  Campos.Add(FOR_CADASTRO);
  TituloIndices.Add('Código');
  Indices.Add('Fornecedores.FOR_CODIGO');
  Crescente.Add('S');
  TituloPrimaria := 'Código';
  ChPrimaria     := 'Fornecedores.FOR_CODIGO';
  TituloIndices.Add('Por Nome');
  Indices.Add('Fornecedores.FOR_NOME');
  Crescente.Add('S');
  TituloIndice   := 'Código';
  ChaveIndice    := 'Fornecedores.FOR_CODIGO';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDFornecedores.CriaForeignKeys;
var
  Script_ForeignKeys: TSQLScript;
begin
  if ForeignKeys.Count > 0 then
  begin
    Script_ForeignKeys := TSQLScript.Create(Self);
    with Script_ForeignKeys do
    begin
      Database         := BaseDados.BD_Base_Dados;
      {$IFDEF IBX}
      Transaction      := BaseDados.TRS_BD_Base_Dados;
      with Script do
      {$ELSE}
      DatabaseName     := BaseDados.BD_Base_Dados.DatabaseName;
      with SQL do
      {$ENDIF}
      AddStrings(ForeignKeys);
      Executar;
      Free;
    end;
  end;
end;

function TDFornecedores.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
  if PTabela(TabGlobal.DProdutos, ['FOR_CODIGO'], [FOR_CODIGO.Valor.Value]) then
  begin
    MessageDlg('Registro está ligado a tabela: '+TabGlobal.DProdutos.Titulo,mtError,[mbOk],0);
    PodeExcluir := False;
    exit;
  end;
end;

procedure TDFornecedores.ExclusaoCascata;
begin
end;

function TDFornecedores.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDFornecedores.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Fornecedores') then
    if PTabela(TabGlobal.DFornecedores, ['FOR_CODIGO'], [FOR_CODIGO.Valor.Value]) then
      Result := True;
end;

procedure TDFornecedores.CalculaCampos;
begin
end;

procedure TDFornecedores.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDFornecedores.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
var
  I: Integer;
begin
  Filtro.Clear;
  FiltroRelac.Clear;
  if Atribui then
  begin
  end
  else
    for I:=0 to Campos.Count-1 do
      TAtributo(Campos[I]).Valor.OnValidate := nil;
  if Atualiza then
    AtualizaSql;
end;

procedure TDFornecedores.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDFornecedores.ProcessoDireto1(DataSet: TDataSet);
var
  QueryLc: TTabela;
  EmEdicao: Boolean;
begin
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDFornecedores.ProcessoDireto2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDFornecedores.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (FOR_CODIGO.SempreAtribui) and (FOR_CODIGO.AutoIncremento > 0) then
      AutoIncremento('FOR_CODIGO', True, FOR_CODIGO.AutoIncremento);
end;

procedure TDFornecedores.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDFornecedores.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDFornecedores.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
