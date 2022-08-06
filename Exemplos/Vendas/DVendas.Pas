{
 Classe da tabela: Vendas - Tabela de Vendas
}

unit DVendas;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0015,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDVendas = class(TTabela)
  public
    VEN_NUMERO: TDVendas_VEN_NUMERO;
    VEN_DATA: TDVendas_VEN_DATA;
    CLI_CODIGO: TDVendas_CLI_CODIGO;
    CLI_NOME: TDVendas_CLI_NOME;
    CLI_ENDERECO: TDVendas_CLI_ENDERECO;
    CLI_BAIRRO: TDVendas_CLI_BAIRRO;
    CLI_CIDADE: TDVendas_CLI_CIDADE;
    UF: TDVendas_UF;
    TELEFONE: TDVendas_TELEFONE;
    ATI_CODIGO: TDVendas_ATI_CODIGO;
    ATI_DESCRICAO: TDVendas_ATI_DESCRICAO;
    VEN_OBS_1: TDVendas_VEN_OBS_1;
    VEN_OBS_2: TDVendas_VEN_OBS_2;
    VEN_TOTAL: TDVendas_VEN_TOTAL;
    VEN_QTDE: TDVendas_VEN_QTDE;
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

constructor TDVendas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Vendas';
  Titulo           := 'Tabela de Vendas';
  Name             := 'DVendas';
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
  DataSource.Name  := 'DsVendas';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Vendas';
    // Exclusão de Registro
    DeleteSQL.Add('delete from Vendas');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  VEN_NUMERO = :OLD_VEN_NUMERO');
    // Inserção de Registro
    InsertSQL.Add('insert into Vendas');
    InsertSQL.Add('  (');
    InsertSQL.Add('  VEN_NUMERO,');
    InsertSQL.Add('  VEN_DATA,');
    InsertSQL.Add('  CLI_CODIGO,');
    InsertSQL.Add('  VEN_OBS_1,');
    InsertSQL.Add('  VEN_OBS_2,');
    InsertSQL.Add('  VEN_TOTAL,');
    InsertSQL.Add('  VEN_QTDE');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :VEN_NUMERO,');
    InsertSQL.Add('  :VEN_DATA,');
    InsertSQL.Add('  :CLI_CODIGO,');
    InsertSQL.Add('  :VEN_OBS_1,');
    InsertSQL.Add('  :VEN_OBS_2,');
    InsertSQL.Add('  :VEN_TOTAL,');
    InsertSQL.Add('  :VEN_QTDE');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update Vendas');
    ModifySQL.Add('set');
    ModifySQL.Add('  VEN_NUMERO = :VEN_NUMERO,');
    ModifySQL.Add('  VEN_DATA = :VEN_DATA,');
    ModifySQL.Add('  CLI_CODIGO = :CLI_CODIGO,');
    ModifySQL.Add('  VEN_OBS_1 = :VEN_OBS_1,');
    ModifySQL.Add('  VEN_OBS_2 = :VEN_OBS_2,');
    ModifySQL.Add('  VEN_TOTAL = :VEN_TOTAL,');
    ModifySQL.Add('  VEN_QTDE = :VEN_QTDE');
    ModifySQL.Add('where');
    ModifySQL.Add('  VEN_NUMERO = :OLD_VEN_NUMERO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Vendas.VEN_NUMERO AS VEN_NUMERO,');
    RefreshSQL.Add('  Vendas.VEN_DATA AS VEN_DATA,');
    RefreshSQL.Add('  Vendas.CLI_CODIGO AS CLI_CODIGO,');
    RefreshSQL.Add('  Clientes.CLI_NOME AS CLI_NOME,');
    RefreshSQL.Add('  Clientes.CLI_ENDERECO AS CLI_ENDERECO,');
    RefreshSQL.Add('  Clientes.CLI_BAIRRO AS CLI_BAIRRO,');
    RefreshSQL.Add('  Clientes.CLI_CIDADE AS CLI_CIDADE,');
    RefreshSQL.Add('  Clientes.UF AS UF,');
    RefreshSQL.Add('  Clientes.TELEFONE AS TELEFONE,');
    RefreshSQL.Add('  Clientes.ATI_CODIGO AS ATI_CODIGO,');
    RefreshSQL.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO,');
    RefreshSQL.Add('  Vendas.VEN_OBS_1 AS VEN_OBS_1,');
    RefreshSQL.Add('  Vendas.VEN_OBS_2 AS VEN_OBS_2,');
    RefreshSQL.Add('  Vendas.VEN_TOTAL AS VEN_TOTAL,');
    RefreshSQL.Add('  Vendas.VEN_QTDE AS VEN_QTDE');
    RefreshSQL.Add('from Vendas');
    RefreshSQL.Add('Left Outer Join Clientes on');
    RefreshSQL.Add('  Vendas.CLI_CODIGO = Clientes.CLI_CODIGO');
    RefreshSQL.Add('Left Outer Join Atividades on');
    RefreshSQL.Add('  Clientes.ATI_CODIGO = Atividades.ATI_CODIGO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Vendas.VEN_NUMERO = :OLD_VEN_NUMERO');
  end;
  TabelasExtras.Add('Clientes');
  TabelasExtras.Add('Atividades');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Vendas.VEN_NUMERO AS VEN_NUMERO,');
  SqlPrincipal.Add('  Vendas.VEN_DATA AS VEN_DATA,');
  SqlPrincipal.Add('  Vendas.CLI_CODIGO AS CLI_CODIGO,');
  SqlPrincipal.Add('  Clientes.CLI_NOME AS CLI_NOME,');
  SqlPrincipal.Add('  Clientes.CLI_ENDERECO AS CLI_ENDERECO,');
  SqlPrincipal.Add('  Clientes.CLI_BAIRRO AS CLI_BAIRRO,');
  SqlPrincipal.Add('  Clientes.CLI_CIDADE AS CLI_CIDADE,');
  SqlPrincipal.Add('  Clientes.UF AS UF,');
  SqlPrincipal.Add('  Clientes.TELEFONE AS TELEFONE,');
  SqlPrincipal.Add('  Clientes.ATI_CODIGO AS ATI_CODIGO,');
  SqlPrincipal.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO,');
  SqlPrincipal.Add('  Vendas.VEN_OBS_1 AS VEN_OBS_1,');
  SqlPrincipal.Add('  Vendas.VEN_OBS_2 AS VEN_OBS_2,');
  SqlPrincipal.Add('  Vendas.VEN_TOTAL AS VEN_TOTAL,');
  SqlPrincipal.Add('  Vendas.VEN_QTDE AS VEN_QTDE');
  SqlPrincipal.Add('from Vendas');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join Clientes on');
  FiltroExtra.Add('  Vendas.CLI_CODIGO = Clientes.CLI_CODIGO');
  FiltroExtra.Add('Left Outer Join Atividades on');
  FiltroExtra.Add('  Clientes.ATI_CODIGO = Atividades.ATI_CODIGO');
  Sql.Add('order by Vendas.VEN_NUMERO');
  VEN_NUMERO := TDVendas_VEN_NUMERO.Create(AOwner);
  VEN_NUMERO.Valor.DataSet := Self;
  VEN_DATA := TDVendas_VEN_DATA.Create(AOwner);
  VEN_DATA.Valor.DataSet := Self;
  CLI_CODIGO := TDVendas_CLI_CODIGO.Create(AOwner);
  CLI_CODIGO.Valor.DataSet := Self;
  CLI_NOME := TDVendas_CLI_NOME.Create(AOwner);
  CLI_NOME.Valor.DataSet := Self;
  CLI_ENDERECO := TDVendas_CLI_ENDERECO.Create(AOwner);
  CLI_ENDERECO.Valor.DataSet := Self;
  CLI_BAIRRO := TDVendas_CLI_BAIRRO.Create(AOwner);
  CLI_BAIRRO.Valor.DataSet := Self;
  CLI_CIDADE := TDVendas_CLI_CIDADE.Create(AOwner);
  CLI_CIDADE.Valor.DataSet := Self;
  UF := TDVendas_UF.Create(AOwner);
  UF.Valor.DataSet := Self;
  TELEFONE := TDVendas_TELEFONE.Create(AOwner);
  TELEFONE.Valor.DataSet := Self;
  VEN_OBS_1 := TDVendas_VEN_OBS_1.Create(AOwner);
  VEN_OBS_1.Valor.DataSet := Self;
  VEN_OBS_2 := TDVendas_VEN_OBS_2.Create(AOwner);
  VEN_OBS_2.Valor.DataSet := Self;
  VEN_TOTAL := TDVendas_VEN_TOTAL.Create(AOwner);
  VEN_TOTAL.Valor.DataSet := Self;
  VEN_QTDE := TDVendas_VEN_QTDE.Create(AOwner);
  VEN_QTDE.Valor.DataSet := Self;
  ATI_CODIGO := TDVendas_ATI_CODIGO.Create(AOwner);
  ATI_CODIGO.Valor.DataSet := Self;
  ATI_DESCRICAO := TDVendas_ATI_DESCRICAO.Create(AOwner);
  ATI_DESCRICAO.Valor.DataSet := Self;
  ChavePrimaria.Add(VEN_NUMERO);
  Campos.Add(VEN_NUMERO);
  Campos.Add(VEN_DATA);
  Campos.Add(CLI_CODIGO);
  Campos.Add(CLI_NOME);
  Campos.Add(CLI_ENDERECO);
  Campos.Add(CLI_BAIRRO);
  Campos.Add(CLI_CIDADE);
  Campos.Add(UF);
  Campos.Add(TELEFONE);
  Campos.Add(ATI_CODIGO);
  Campos.Add(ATI_DESCRICAO);
  Campos.Add(VEN_OBS_1);
  Campos.Add(VEN_OBS_2);
  Campos.Add(VEN_TOTAL);
  Campos.Add(VEN_QTDE);
  TituloIndices.Add('Número');
  Indices.Add('Vendas.VEN_NUMERO');
  Crescente.Add('S');
  TituloPrimaria := 'Número';
  ChPrimaria     := 'Vendas.VEN_NUMERO';
  TituloIndice   := 'Número';
  ChaveIndice    := 'Vendas.VEN_NUMERO';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDVendas.CriaForeignKeys;
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

function TDVendas.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDVendas.ExclusaoCascata;
begin
  // Exclusão em Cascata Tabela: DItens_Venda
  TabGlobal.DItens_Venda.Filtro.Clear;
  TabGlobal.DItens_Venda.Filtro.Add('Itens_Venda.VEN_NUMERO = :Vendas_VEN_NUMERO');
  TabGlobal.DItens_Venda.AtualizaSql;
  while not TabGlobal.DItens_Venda.Eof do
    if not TabGlobal.DItens_Venda.Exclui then
      TabGlobal.DItens_Venda.Next;
end;

function TDVendas.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Clientes') then
    if (UpperCase('CLI_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DClientes, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

  if UpperCase(Tabela) = UpperCase('Atividades') then
    if (UpperCase('ATI_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

end;

function TDVendas.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Clientes') then
    if PTabela(TabGlobal.DClientes, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Atividades') then
    if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Vendas') then
    if PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value]) then
      Result := True;
end;

procedure TDVendas.CalculaCampos;
begin
end;

procedure TDVendas.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
  TabGlobal.DItens_Venda.AtribuiFiltroMestre(Atribui);
end;

procedure TDVendas.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDVendas.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDVendas.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDVendas.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDVendas.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (VEN_NUMERO.SempreAtribui) and (VEN_NUMERO.AutoIncremento > 0) then
      AutoIncremento('VEN_NUMERO', True, VEN_NUMERO.AutoIncremento);
end;

procedure TDVendas.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDVendas.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDVendas.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
