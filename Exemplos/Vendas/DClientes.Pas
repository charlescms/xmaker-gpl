{
 Classe da tabela: Clientes - Tabela de Clientes
}

unit DClientes;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0001,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDClientes = class(TTabela)
  public
    CLI_CODIGO: TDClientes_CLI_CODIGO;
    CLI_NOME: TDClientes_CLI_NOME;
    TIPO_PESSOA: TDClientes_TIPO_PESSOA;
    CPF: TDClientes_CPF;
    CNPJ: TDClientes_CNPJ;
    CLI_ENDERECO: TDClientes_CLI_ENDERECO;
    CLI_BAIRRO: TDClientes_CLI_BAIRRO;
    CLI_CIDADE: TDClientes_CLI_CIDADE;
    UF: TDClientes_UF;
    CEP: TDClientes_CEP;
    TELEFONE: TDClientes_TELEFONE;
    TELEFONE_2: TDClientes_TELEFONE_2;
    CELULAR: TDClientes_CELULAR;
    EMAIL: TDClientes_EMAIL;
    SITE: TDClientes_SITE;
    CLI_OBS: TDClientes_CLI_OBS;
    CLI_CADASTRO: TDClientes_CLI_CADASTRO;
    ATI_CODIGO: TDClientes_ATI_CODIGO;
    ATI_DESCRICAO: TDClientes_ATI_DESCRICAO;
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

constructor TDClientes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Clientes';
  Titulo           := 'Tabela de Clientes';
  Name             := 'DClientes';
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
  DataSource.Name  := 'DsClientes';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Clientes';
    // Exclusão de Registro
    DeleteSQL.Add('delete from Clientes');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  CLI_CODIGO = :OLD_CLI_CODIGO');
    // Inserção de Registro
    InsertSQL.Add('insert into Clientes');
    InsertSQL.Add('  (');
    InsertSQL.Add('  CLI_CODIGO,');
    InsertSQL.Add('  CLI_NOME,');
    InsertSQL.Add('  TIPO_PESSOA,');
    InsertSQL.Add('  CPF,');
    InsertSQL.Add('  CNPJ,');
    InsertSQL.Add('  CLI_ENDERECO,');
    InsertSQL.Add('  CLI_BAIRRO,');
    InsertSQL.Add('  CLI_CIDADE,');
    InsertSQL.Add('  UF,');
    InsertSQL.Add('  CEP,');
    InsertSQL.Add('  TELEFONE,');
    InsertSQL.Add('  TELEFONE_2,');
    InsertSQL.Add('  CELULAR,');
    InsertSQL.Add('  EMAIL,');
    InsertSQL.Add('  SITE,');
    InsertSQL.Add('  CLI_OBS,');
    InsertSQL.Add('  CLI_CADASTRO,');
    InsertSQL.Add('  ATI_CODIGO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :CLI_CODIGO,');
    InsertSQL.Add('  :CLI_NOME,');
    InsertSQL.Add('  :TIPO_PESSOA,');
    InsertSQL.Add('  :CPF,');
    InsertSQL.Add('  :CNPJ,');
    InsertSQL.Add('  :CLI_ENDERECO,');
    InsertSQL.Add('  :CLI_BAIRRO,');
    InsertSQL.Add('  :CLI_CIDADE,');
    InsertSQL.Add('  :UF,');
    InsertSQL.Add('  :CEP,');
    InsertSQL.Add('  :TELEFONE,');
    InsertSQL.Add('  :TELEFONE_2,');
    InsertSQL.Add('  :CELULAR,');
    InsertSQL.Add('  :EMAIL,');
    InsertSQL.Add('  :SITE,');
    InsertSQL.Add('  :CLI_OBS,');
    InsertSQL.Add('  :CLI_CADASTRO,');
    InsertSQL.Add('  :ATI_CODIGO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update Clientes');
    ModifySQL.Add('set');
    ModifySQL.Add('  CLI_CODIGO = :CLI_CODIGO,');
    ModifySQL.Add('  CLI_NOME = :CLI_NOME,');
    ModifySQL.Add('  TIPO_PESSOA = :TIPO_PESSOA,');
    ModifySQL.Add('  CPF = :CPF,');
    ModifySQL.Add('  CNPJ = :CNPJ,');
    ModifySQL.Add('  CLI_ENDERECO = :CLI_ENDERECO,');
    ModifySQL.Add('  CLI_BAIRRO = :CLI_BAIRRO,');
    ModifySQL.Add('  CLI_CIDADE = :CLI_CIDADE,');
    ModifySQL.Add('  UF = :UF,');
    ModifySQL.Add('  CEP = :CEP,');
    ModifySQL.Add('  TELEFONE = :TELEFONE,');
    ModifySQL.Add('  TELEFONE_2 = :TELEFONE_2,');
    ModifySQL.Add('  CELULAR = :CELULAR,');
    ModifySQL.Add('  EMAIL = :EMAIL,');
    ModifySQL.Add('  SITE = :SITE,');
    ModifySQL.Add('  CLI_OBS = :CLI_OBS,');
    ModifySQL.Add('  CLI_CADASTRO = :CLI_CADASTRO,');
    ModifySQL.Add('  ATI_CODIGO = :ATI_CODIGO');
    ModifySQL.Add('where');
    ModifySQL.Add('  CLI_CODIGO = :OLD_CLI_CODIGO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Clientes.CLI_CODIGO AS CLI_CODIGO,');
    RefreshSQL.Add('  Clientes.CLI_NOME AS CLI_NOME,');
    RefreshSQL.Add('  Clientes.TIPO_PESSOA AS TIPO_PESSOA,');
    RefreshSQL.Add('  Clientes.CPF AS CPF,');
    RefreshSQL.Add('  Clientes.CNPJ AS CNPJ,');
    RefreshSQL.Add('  Clientes.CLI_ENDERECO AS CLI_ENDERECO,');
    RefreshSQL.Add('  Clientes.CLI_BAIRRO AS CLI_BAIRRO,');
    RefreshSQL.Add('  Clientes.CLI_CIDADE AS CLI_CIDADE,');
    RefreshSQL.Add('  Clientes.UF AS UF,');
    RefreshSQL.Add('  Clientes.CEP AS CEP,');
    RefreshSQL.Add('  Clientes.TELEFONE AS TELEFONE,');
    RefreshSQL.Add('  Clientes.TELEFONE_2 AS TELEFONE_2,');
    RefreshSQL.Add('  Clientes.CELULAR AS CELULAR,');
    RefreshSQL.Add('  Clientes.EMAIL AS EMAIL,');
    RefreshSQL.Add('  Clientes.SITE AS SITE,');
    RefreshSQL.Add('  Clientes.CLI_OBS AS CLI_OBS,');
    RefreshSQL.Add('  Clientes.CLI_CADASTRO AS CLI_CADASTRO,');
    RefreshSQL.Add('  Clientes.ATI_CODIGO AS ATI_CODIGO,');
    RefreshSQL.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO');
    RefreshSQL.Add('from Clientes');
    RefreshSQL.Add('Left Outer Join Atividades on');
    RefreshSQL.Add('  Clientes.ATI_CODIGO = Atividades.ATI_CODIGO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Clientes.CLI_CODIGO = :OLD_CLI_CODIGO');
  end;
  TabelasExtras.Add('Atividades');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Clientes.CLI_CODIGO AS CLI_CODIGO,');
  SqlPrincipal.Add('  Clientes.CLI_NOME AS CLI_NOME,');
  SqlPrincipal.Add('  Clientes.TIPO_PESSOA AS TIPO_PESSOA,');
  SqlPrincipal.Add('  Clientes.CPF AS CPF,');
  SqlPrincipal.Add('  Clientes.CNPJ AS CNPJ,');
  SqlPrincipal.Add('  Clientes.CLI_ENDERECO AS CLI_ENDERECO,');
  SqlPrincipal.Add('  Clientes.CLI_BAIRRO AS CLI_BAIRRO,');
  SqlPrincipal.Add('  Clientes.CLI_CIDADE AS CLI_CIDADE,');
  SqlPrincipal.Add('  Clientes.UF AS UF,');
  SqlPrincipal.Add('  Clientes.CEP AS CEP,');
  SqlPrincipal.Add('  Clientes.TELEFONE AS TELEFONE,');
  SqlPrincipal.Add('  Clientes.TELEFONE_2 AS TELEFONE_2,');
  SqlPrincipal.Add('  Clientes.CELULAR AS CELULAR,');
  SqlPrincipal.Add('  Clientes.EMAIL AS EMAIL,');
  SqlPrincipal.Add('  Clientes.SITE AS SITE,');
  SqlPrincipal.Add('  Clientes.CLI_OBS AS CLI_OBS,');
  SqlPrincipal.Add('  Clientes.CLI_CADASTRO AS CLI_CADASTRO,');
  SqlPrincipal.Add('  Clientes.ATI_CODIGO AS ATI_CODIGO,');
  SqlPrincipal.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO');
  SqlPrincipal.Add('from Clientes');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join Atividades on');
  FiltroExtra.Add('  Clientes.ATI_CODIGO = Atividades.ATI_CODIGO');
  Sql.Add('order by Clientes.CLI_CODIGO');
  CLI_CODIGO := TDClientes_CLI_CODIGO.Create(AOwner);
  CLI_CODIGO.Valor.DataSet := Self;
  CLI_NOME := TDClientes_CLI_NOME.Create(AOwner);
  CLI_NOME.Valor.DataSet := Self;
  CLI_CADASTRO := TDClientes_CLI_CADASTRO.Create(AOwner);
  CLI_CADASTRO.Valor.DataSet := Self;
  TIPO_PESSOA := TDClientes_TIPO_PESSOA.Create(AOwner);
  TIPO_PESSOA.Valor.DataSet := Self;
  CPF := TDClientes_CPF.Create(AOwner);
  CPF.Valor.DataSet := Self;
  CNPJ := TDClientes_CNPJ.Create(AOwner);
  CNPJ.Valor.DataSet := Self;
  CLI_ENDERECO := TDClientes_CLI_ENDERECO.Create(AOwner);
  CLI_ENDERECO.Valor.DataSet := Self;
  CLI_BAIRRO := TDClientes_CLI_BAIRRO.Create(AOwner);
  CLI_BAIRRO.Valor.DataSet := Self;
  CLI_CIDADE := TDClientes_CLI_CIDADE.Create(AOwner);
  CLI_CIDADE.Valor.DataSet := Self;
  UF := TDClientes_UF.Create(AOwner);
  UF.Valor.DataSet := Self;
  CEP := TDClientes_CEP.Create(AOwner);
  CEP.Valor.DataSet := Self;
  TELEFONE := TDClientes_TELEFONE.Create(AOwner);
  TELEFONE.Valor.DataSet := Self;
  TELEFONE_2 := TDClientes_TELEFONE_2.Create(AOwner);
  TELEFONE_2.Valor.DataSet := Self;
  CELULAR := TDClientes_CELULAR.Create(AOwner);
  CELULAR.Valor.DataSet := Self;
  EMAIL := TDClientes_EMAIL.Create(AOwner);
  EMAIL.Valor.DataSet := Self;
  SITE := TDClientes_SITE.Create(AOwner);
  SITE.Valor.DataSet := Self;
  CLI_OBS := TDClientes_CLI_OBS.Create(AOwner);
  CLI_OBS.Valor.DataSet := Self;
  ATI_CODIGO := TDClientes_ATI_CODIGO.Create(AOwner);
  ATI_CODIGO.Valor.DataSet := Self;
  ATI_DESCRICAO := TDClientes_ATI_DESCRICAO.Create(AOwner);
  ATI_DESCRICAO.Valor.DataSet := Self;
  ChavePrimaria.Add(CLI_CODIGO);
  Campos.Add(CLI_CODIGO);
  Campos.Add(CLI_NOME);
  Campos.Add(TIPO_PESSOA);
  Campos.Add(CPF);
  Campos.Add(CNPJ);
  Campos.Add(CLI_ENDERECO);
  Campos.Add(CLI_BAIRRO);
  Campos.Add(CLI_CIDADE);
  Campos.Add(UF);
  Campos.Add(CEP);
  Campos.Add(TELEFONE);
  Campos.Add(TELEFONE_2);
  Campos.Add(CELULAR);
  Campos.Add(EMAIL);
  Campos.Add(SITE);
  Campos.Add(CLI_OBS);
  Campos.Add(CLI_CADASTRO);
  Campos.Add(ATI_CODIGO);
  Campos.Add(ATI_DESCRICAO);
  TituloIndices.Add('Código');
  Indices.Add('Clientes.CLI_CODIGO');
  Crescente.Add('S');
  TituloPrimaria := 'Código';
  ChPrimaria     := 'Clientes.CLI_CODIGO';
  TituloIndices.Add('Por Nome');
  Indices.Add('Clientes.CLI_NOME');
  Crescente.Add('S');
  TituloIndice   := 'Código';
  ChaveIndice    := 'Clientes.CLI_CODIGO';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDClientes.CriaForeignKeys;
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

function TDClientes.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
  if PTabela(TabGlobal.DVendas, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value]) then
  begin
    MessageDlg('Registro está ligado a tabela: '+TabGlobal.DVendas.Titulo,mtError,[mbOk],0);
    PodeExcluir := False;
    exit;
  end;
end;

procedure TDClientes.ExclusaoCascata;
begin
end;

function TDClientes.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Atividades') then
    if (UpperCase('ATI_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

end;

function TDClientes.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Atividades') then
    if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Clientes') then
    if PTabela(TabGlobal.DClientes, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value]) then
      Result := True;
end;

procedure TDClientes.CalculaCampos;
begin
end;

procedure TDClientes.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDClientes.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDClientes.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDClientes.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDClientes.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDClientes.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (CLI_CODIGO.SempreAtribui) and (CLI_CODIGO.AutoIncremento > 0) then
      AutoIncremento('CLI_CODIGO', True, CLI_CODIGO.AutoIncremento);
end;

procedure TDClientes.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDClientes.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDClientes.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
