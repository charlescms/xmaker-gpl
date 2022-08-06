{
 Classe da tabela: Consulta_Clientes - Consulta Clientes
}

unit DConsulta_Clientes;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0002,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     ZAbstractRODataset, ZAbstractDataset, ZDataset, ZConnection, ZSqlMetadata,
     ZSqlUpdate,
     {$ENDIF}
     DB, Dialogs;

type
  TDConsulta_Clientes = class(TTabela)
  public
    CLI_CODIGO: TDConsulta_Clientes_CLI_CODIGO;
    CLI_NOME: TDConsulta_Clientes_CLI_NOME;
    TIPO_PESSOA: TDConsulta_Clientes_TIPO_PESSOA;
    CPF: TDConsulta_Clientes_CPF;
    CNPJ: TDConsulta_Clientes_CNPJ;
    CLI_ENDERECO: TDConsulta_Clientes_CLI_ENDERECO;
    CLI_BAIRRO: TDConsulta_Clientes_CLI_BAIRRO;
    CLI_CIDADE: TDConsulta_Clientes_CLI_CIDADE;
    UF: TDConsulta_Clientes_UF;
    CEP: TDConsulta_Clientes_CEP;
    TELEFONE: TDConsulta_Clientes_TELEFONE;
    TELEFONE_2: TDConsulta_Clientes_TELEFONE_2;
    CELULAR: TDConsulta_Clientes_CELULAR;
    EMAIL: TDConsulta_Clientes_EMAIL;
    SITE: TDConsulta_Clientes_SITE;
    CLI_OBS: TDConsulta_Clientes_CLI_OBS;
    CLI_CADASTRO: TDConsulta_Clientes_CLI_CADASTRO;
    ATI_CODIGO: TDConsulta_Clientes_ATI_CODIGO;
    constructor Create(AOwner: TComponent); override;
    function PodeExcluir: Boolean; override;
    procedure ExclusaoCascata; override;
    function PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant): Boolean; overload; override;
    function PesquisaRelacionados(Tabela: String): Boolean; overload; override;
    procedure CalculaCampos; override;
    procedure Parametros(Tabela: TTabela); override;
    procedure AtribuiRelacionamentos(Atribui: Boolean = True); override;
    procedure AtribuiFiltroMestre(Atribui: Boolean = True); override;
    procedure AtribuiMestre(DataSet: TDataSet); override;
    procedure ProcessoDireto1(DataSet: TDataSet);
    procedure ProcessoDireto2(DataSet: TDataSet);
    procedure AtualizaCalculados(DataSet: TDataSet);
    procedure ProcessoInverso1(DataSet: TDataSet);
    procedure ProcessoInverso2(DataSet: TDataSet);
  end;

implementation

uses Publicas, Validar, Rotinas, Abertura, Calculos;

constructor TDConsulta_Clientes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Clientes';
  Titulo           := 'Consulta Clientes';
  Name             := 'DConsulta_Clientes';
  Database         := BaseDados.BD_Base_Dados;
  {$IFDEF IBX}
  Transaction      := BaseDados.TRS_BD_Base_Dados;
  UpdateSql        := TIBUpdateSQL.Create(AOwner);
  {$ELSE}
  UpdateSql        := TZUpdateSQL.Create(AOwner);
  Connection       := BaseDados.BD_Base_Dados;
  {$ENDIF}
  Local            := False;
  Versao           := 6;
  DataSource.Name  := 'DsConsulta_Clientes';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Consulta_Clientes';
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
    {$IFDEF IBX}
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Clientes.CLI_CODIGO CLI_CODIGO,');
    RefreshSQL.Add('  Clientes.CLI_NOME CLI_NOME,');
    RefreshSQL.Add('  Clientes.TIPO_PESSOA TIPO_PESSOA,');
    RefreshSQL.Add('  Clientes.CPF CPF,');
    RefreshSQL.Add('  Clientes.CNPJ CNPJ,');
    RefreshSQL.Add('  Clientes.CLI_ENDERECO CLI_ENDERECO,');
    RefreshSQL.Add('  Clientes.CLI_BAIRRO CLI_BAIRRO,');
    RefreshSQL.Add('  Clientes.CLI_CIDADE CLI_CIDADE,');
    RefreshSQL.Add('  Clientes.UF UF,');
    RefreshSQL.Add('  Clientes.CEP CEP,');
    RefreshSQL.Add('  Clientes.TELEFONE TELEFONE,');
    RefreshSQL.Add('  Clientes.TELEFONE_2 TELEFONE_2,');
    RefreshSQL.Add('  Clientes.CELULAR CELULAR,');
    RefreshSQL.Add('  Clientes.EMAIL EMAIL,');
    RefreshSQL.Add('  Clientes.SITE SITE,');
    RefreshSQL.Add('  Clientes.CLI_OBS CLI_OBS,');
    RefreshSQL.Add('  Clientes.CLI_CADASTRO CLI_CADASTRO,');
    RefreshSQL.Add('  Clientes.ATI_CODIGO ATI_CODIGO');
    RefreshSQL.Add('from Clientes');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Clientes.CLI_CODIGO = :OLD_CLI_CODIGO');
    {$ENDIF}
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Clientes.CLI_CODIGO CLI_CODIGO,');
  SqlPrincipal.Add('  Clientes.CLI_NOME CLI_NOME,');
  SqlPrincipal.Add('  Clientes.TIPO_PESSOA TIPO_PESSOA,');
  SqlPrincipal.Add('  Clientes.CPF CPF,');
  SqlPrincipal.Add('  Clientes.CNPJ CNPJ,');
  SqlPrincipal.Add('  Clientes.CLI_ENDERECO CLI_ENDERECO,');
  SqlPrincipal.Add('  Clientes.CLI_BAIRRO CLI_BAIRRO,');
  SqlPrincipal.Add('  Clientes.CLI_CIDADE CLI_CIDADE,');
  SqlPrincipal.Add('  Clientes.UF UF,');
  SqlPrincipal.Add('  Clientes.CEP CEP,');
  SqlPrincipal.Add('  Clientes.TELEFONE TELEFONE,');
  SqlPrincipal.Add('  Clientes.TELEFONE_2 TELEFONE_2,');
  SqlPrincipal.Add('  Clientes.CELULAR CELULAR,');
  SqlPrincipal.Add('  Clientes.EMAIL EMAIL,');
  SqlPrincipal.Add('  Clientes.SITE SITE,');
  SqlPrincipal.Add('  Clientes.CLI_OBS CLI_OBS,');
  SqlPrincipal.Add('  Clientes.CLI_CADASTRO CLI_CADASTRO,');
  SqlPrincipal.Add('  Clientes.ATI_CODIGO ATI_CODIGO');
  SqlPrincipal.Add('from Clientes');
  Sql.AddStrings(SqlPrincipal);
  Sql.Add('order by Clientes.CLI_CODIGO');
  CLI_CODIGO := TDConsulta_Clientes_CLI_CODIGO.Create(AOwner);
  CLI_CODIGO.Valor.DataSet := Self;
  CLI_NOME := TDConsulta_Clientes_CLI_NOME.Create(AOwner);
  CLI_NOME.Valor.DataSet := Self;
  TIPO_PESSOA := TDConsulta_Clientes_TIPO_PESSOA.Create(AOwner);
  TIPO_PESSOA.Valor.DataSet := Self;
  CPF := TDConsulta_Clientes_CPF.Create(AOwner);
  CPF.Valor.DataSet := Self;
  CNPJ := TDConsulta_Clientes_CNPJ.Create(AOwner);
  CNPJ.Valor.DataSet := Self;
  CLI_ENDERECO := TDConsulta_Clientes_CLI_ENDERECO.Create(AOwner);
  CLI_ENDERECO.Valor.DataSet := Self;
  CLI_BAIRRO := TDConsulta_Clientes_CLI_BAIRRO.Create(AOwner);
  CLI_BAIRRO.Valor.DataSet := Self;
  CLI_CIDADE := TDConsulta_Clientes_CLI_CIDADE.Create(AOwner);
  CLI_CIDADE.Valor.DataSet := Self;
  UF := TDConsulta_Clientes_UF.Create(AOwner);
  UF.Valor.DataSet := Self;
  CEP := TDConsulta_Clientes_CEP.Create(AOwner);
  CEP.Valor.DataSet := Self;
  TELEFONE := TDConsulta_Clientes_TELEFONE.Create(AOwner);
  TELEFONE.Valor.DataSet := Self;
  TELEFONE_2 := TDConsulta_Clientes_TELEFONE_2.Create(AOwner);
  TELEFONE_2.Valor.DataSet := Self;
  CELULAR := TDConsulta_Clientes_CELULAR.Create(AOwner);
  CELULAR.Valor.DataSet := Self;
  EMAIL := TDConsulta_Clientes_EMAIL.Create(AOwner);
  EMAIL.Valor.DataSet := Self;
  SITE := TDConsulta_Clientes_SITE.Create(AOwner);
  SITE.Valor.DataSet := Self;
  CLI_OBS := TDConsulta_Clientes_CLI_OBS.Create(AOwner);
  CLI_OBS.Valor.DataSet := Self;
  CLI_CADASTRO := TDConsulta_Clientes_CLI_CADASTRO.Create(AOwner);
  CLI_CADASTRO.Valor.DataSet := Self;
  ATI_CODIGO := TDConsulta_Clientes_ATI_CODIGO.Create(AOwner);
  ATI_CODIGO.Valor.DataSet := Self;
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
  TituloIndices.Add('Código');
  Indices.Add('Clientes.CLI_CODIGO');
  Crescente.Add('S');
  TituloPrimaria := 'Código';
  ChPrimaria     := 'Clientes.CLI_CODIGO';
  TituloIndice   := 'Código';
  ChaveIndice    := 'Clientes.CLI_CODIGO';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

function TDConsulta_Clientes.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDConsulta_Clientes.ExclusaoCascata;
begin
end;

function TDConsulta_Clientes.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant): Boolean;
begin
  Result := False;
end;

function TDConsulta_Clientes.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Clientes') then
    if PTabela(TabGlobal.DConsulta_Clientes, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value]) then
      Result := True;
end;

procedure TDConsulta_Clientes.CalculaCampos;
begin
end;

procedure TDConsulta_Clientes.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDConsulta_Clientes.AtribuiFiltroMestre(Atribui: Boolean = True);
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
  AtualizaSql;
end;

procedure TDConsulta_Clientes.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDConsulta_Clientes.ProcessoDireto1(DataSet: TDataSet);
var
  QueryLc: TTabela;
  EmEdicao: Boolean;
begin
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  ApplyUpdates;
  CommitUpdates;
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDConsulta_Clientes.ProcessoDireto2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  ApplyUpdates;
  CommitUpdates;
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDConsulta_Clientes.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
end;

procedure TDConsulta_Clientes.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDConsulta_Clientes.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDConsulta_Clientes.Parametros(Tabela: TTabela);
var
  I, Y: Integer;
  Nome_Par: String;
begin
  with Tabela do
  begin
    if Params.FindParam('Sistema_Titulo') <> nil then
      ParamByName('Sistema_Titulo').Value := Sistema.Titulo;
    if Params.FindParam('Sistema_Versao') <> nil then
      ParamByName('Sistema_Versao').Value := Sistema.Versao;
    if Params.FindParam('Sistema_Analista') <> nil then
      ParamByName('Sistema_Analista').Value := Sistema.Analista;
    if Params.FindParam('Sistema_Programador') <> nil then
      ParamByName('Sistema_Programador').Value := Sistema.Programador;
    if Params.FindParam('Sistema_Projetista') <> nil then
      ParamByName('Sistema_Projetista').Value := Sistema.Projetista;
    if Params.FindParam('Sistema_EstiloData') <> nil then
      ParamByName('Sistema_EstiloData').Value := Sistema.EstiloData;
    if Params.FindParam('Sistema_SenhaInicial') <> nil then
      ParamByName('Sistema_SenhaInicial').Value := Sistema.SenhaInicial;
    if Params.FindParam('Sistema_Pasta') <> nil then
      ParamByName('Sistema_Pasta').Value := Sistema.Pasta;
    if Params.FindParam('Sistema_Usuario') <> nil then
      ParamByName('Sistema_Usuario').Value := Sistema.Usuario;
    if Params.FindParam('Sistema_Senha') <> nil then
      ParamByName('Sistema_Senha').Value := Sistema.Senha;
    if Params.FindParam('Sistema_Master') <> nil then
      ParamByName('Sistema_Master').Value := ConverteLogico(Sistema.Master);
    if Params.FindParam('Sistema_Grupo') <> nil then
      ParamByName('Sistema_Grupo').Value := Sistema.Grupo;
    if Params.FindParam('Sistema_NumeroUsr') <> nil then
      ParamByName('Sistema_NumeroUsr').Value := Sistema.NumeroUsr;
    if Params.FindParam('Sistema_EmpresaUsr') <> nil then
      ParamByName('Sistema_EmpresaUsr').Value := Sistema.EmpresaUsr;
    if Params.FindParam('Sistema_EnderecoUsr') <> nil then
      ParamByName('Sistema_EnderecoUsr').Value := Sistema.EnderecoUsr;
    if Params.FindParam('Sistema_BairroUsr') <> nil then
      ParamByName('Sistema_BairroUsr').Value := Sistema.BairroUsr;
    if Params.FindParam('Sistema_CidadeUsr') <> nil then
      ParamByName('Sistema_CidadeUsr').Value := Sistema.CidadeUsr;
    if Params.FindParam('Sistema_UfUsr') <> nil then
      ParamByName('Sistema_UfUsr').Value := Sistema.UfUsr;
    if Params.FindParam('Sistema_CEPUsr') <> nil then
      ParamByName('Sistema_CEPUsr').Value := Sistema.CEPUsr;
    if Params.FindParam('Sistema_CNPJUsr') <> nil then
      ParamByName('Sistema_CNPJUsr').Value := Sistema.CNPJUsr;
    if Params.FindParam('Sistema_IEUsr') <> nil then
      ParamByName('Sistema_IEUsr').Value := Sistema.IEUsr;
    if Params.FindParam('Sistema_FonesUsr') <> nil then
      ParamByName('Sistema_FonesUsr').Value := Sistema.FonesUsr;
    if Params.FindParam('Sistema_LogoUsr') <> nil then
      ParamByName('Sistema_LogoUsr').Value := Sistema.LogoUsr;
    if Params.FindParam('Data_Atual') <> nil then
      ParamByName('Data_Atual').Value := Date;
    for I:=0 to Lst_Tabelas.Count-1 do
      for Y:=0 to TTabela(Lst_Tabelas[I]).Campos.Count-1 do
      begin
        Nome_Par := Trim(Copy(TTabela(Lst_Tabelas[I]).Name,02,30) + '_' + TAtributo(TTabela(Lst_Tabelas[I]).Campos[Y]).Nome);
        if Params.FindParam(Nome_Par) <> nil then
          ParamByName(Nome_Par).Value := TTabela(Lst_Tabelas[I]).FieldValues[TAtributo(TTabela(Lst_Tabelas[I]).Campos[Y]).Nome];
      end;
  end;
end;

end.
