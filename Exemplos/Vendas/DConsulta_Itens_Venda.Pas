{
 Classe da tabela: Consulta_Itens_Venda - Consulta Geral de Itens Vendidos
}

unit DConsulta_Itens_Venda;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0002,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDConsulta_Itens_Venda = class(TTabela)
  public
    VEN_NUMERO: TDConsulta_Itens_Venda_VEN_NUMERO;
    ITE_SEQUENCIA: TDConsulta_Itens_Venda_ITE_SEQUENCIA;
    PRO_CODIGO: TDConsulta_Itens_Venda_PRO_CODIGO;
    ITE_QTDE: TDConsulta_Itens_Venda_ITE_QTDE;
    ITE_PRECO: TDConsulta_Itens_Venda_ITE_PRECO;
    ITE_TOTAL: TDConsulta_Itens_Venda_ITE_TOTAL;
    VEN_DATA: TDConsulta_Itens_Venda_VEN_DATA;
    CLI_CODIGO: TDConsulta_Itens_Venda_CLI_CODIGO;
    CLI_NOME: TDConsulta_Itens_Venda_CLI_NOME;
    ATI_CODIGO: TDConsulta_Itens_Venda_ATI_CODIGO;
    ATI_DESCRICAO: TDConsulta_Itens_Venda_ATI_DESCRICAO;
    PRO_DESCRICAO: TDConsulta_Itens_Venda_PRO_DESCRICAO;
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

constructor TDConsulta_Itens_Venda.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Itens_Venda';
  Titulo           := 'Consulta Geral de Itens Vendidos';
  Name             := 'DConsulta_Itens_Venda';
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
  DataSource.Name  := 'DsConsulta_Itens_Venda';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Consulta_Itens_Venda';
    // Exclusão de Registro
    DeleteSQL.Add('delete from Itens_Venda');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  VEN_NUMERO = :OLD_VEN_NUMERO');
    DeleteSQL.Add('  and ITE_SEQUENCIA = :OLD_ITE_SEQUENCIA');
    // Inserção de Registro
    InsertSQL.Add('insert into Itens_Venda');
    InsertSQL.Add('  (');
    InsertSQL.Add('  VEN_NUMERO,');
    InsertSQL.Add('  ITE_SEQUENCIA,');
    InsertSQL.Add('  PRO_CODIGO,');
    InsertSQL.Add('  ITE_QTDE,');
    InsertSQL.Add('  ITE_PRECO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :VEN_NUMERO,');
    InsertSQL.Add('  :ITE_SEQUENCIA,');
    InsertSQL.Add('  :PRO_CODIGO,');
    InsertSQL.Add('  :ITE_QTDE,');
    InsertSQL.Add('  :ITE_PRECO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update Itens_Venda');
    ModifySQL.Add('set');
    ModifySQL.Add('  VEN_NUMERO = :VEN_NUMERO,');
    ModifySQL.Add('  ITE_SEQUENCIA = :ITE_SEQUENCIA,');
    ModifySQL.Add('  PRO_CODIGO = :PRO_CODIGO,');
    ModifySQL.Add('  ITE_QTDE = :ITE_QTDE,');
    ModifySQL.Add('  ITE_PRECO = :ITE_PRECO');
    ModifySQL.Add('where');
    ModifySQL.Add('  VEN_NUMERO = :OLD_VEN_NUMERO');
    ModifySQL.Add('  and ITE_SEQUENCIA = :OLD_ITE_SEQUENCIA');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Itens_Venda.VEN_NUMERO AS VEN_NUMERO,');
    RefreshSQL.Add('  Itens_Venda.ITE_SEQUENCIA AS ITE_SEQUENCIA,');
    RefreshSQL.Add('  Itens_Venda.PRO_CODIGO AS PRO_CODIGO,');
    RefreshSQL.Add('  Itens_Venda.ITE_QTDE AS ITE_QTDE,');
    RefreshSQL.Add('  Itens_Venda.ITE_PRECO AS ITE_PRECO,');
    RefreshSQL.Add('  Vendas.VEN_DATA AS VEN_DATA,');
    RefreshSQL.Add('  Vendas.CLI_CODIGO AS CLI_CODIGO,');
    RefreshSQL.Add('  Clientes.CLI_NOME AS CLI_NOME,');
    RefreshSQL.Add('  Clientes.ATI_CODIGO AS ATI_CODIGO,');
    RefreshSQL.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO,');
    RefreshSQL.Add('  Produtos.PRO_DESCRICAO AS PRO_DESCRICAO');
    RefreshSQL.Add('from Itens_Venda');
    RefreshSQL.Add('Left Outer Join Vendas on');
    RefreshSQL.Add('  Itens_Venda.VEN_NUMERO = Vendas.VEN_NUMERO');
    RefreshSQL.Add('Left Outer Join Clientes on');
    RefreshSQL.Add('  Vendas.CLI_CODIGO = Clientes.CLI_CODIGO');
    RefreshSQL.Add('Left Outer Join Atividades on');
    RefreshSQL.Add('  Clientes.ATI_CODIGO = Atividades.ATI_CODIGO');
    RefreshSQL.Add('Left Outer Join Produtos on');
    RefreshSQL.Add('  Itens_Venda.PRO_CODIGO = Produtos.PRO_CODIGO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Itens_Venda.VEN_NUMERO = :OLD_VEN_NUMERO');
    RefreshSQL.Add('  and Itens_Venda.ITE_SEQUENCIA = :OLD_ITE_SEQUENCIA');
  end;
  TabelasExtras.Add('Vendas');
  TabelasExtras.Add('Clientes');
  TabelasExtras.Add('Atividades');
  TabelasExtras.Add('Produtos');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Itens_Venda.VEN_NUMERO AS VEN_NUMERO,');
  SqlPrincipal.Add('  Itens_Venda.ITE_SEQUENCIA AS ITE_SEQUENCIA,');
  SqlPrincipal.Add('  Itens_Venda.PRO_CODIGO AS PRO_CODIGO,');
  SqlPrincipal.Add('  Itens_Venda.ITE_QTDE AS ITE_QTDE,');
  SqlPrincipal.Add('  Itens_Venda.ITE_PRECO AS ITE_PRECO,');
  SqlPrincipal.Add('  Vendas.VEN_DATA AS VEN_DATA,');
  SqlPrincipal.Add('  Vendas.CLI_CODIGO AS CLI_CODIGO,');
  SqlPrincipal.Add('  Clientes.CLI_NOME AS CLI_NOME,');
  SqlPrincipal.Add('  Clientes.ATI_CODIGO AS ATI_CODIGO,');
  SqlPrincipal.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO,');
  SqlPrincipal.Add('  Produtos.PRO_DESCRICAO AS PRO_DESCRICAO');
  SqlPrincipal.Add('from Itens_Venda');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join Vendas on');
  FiltroExtra.Add('  Itens_Venda.VEN_NUMERO = Vendas.VEN_NUMERO');
  FiltroExtra.Add('Left Outer Join Clientes on');
  FiltroExtra.Add('  Vendas.CLI_CODIGO = Clientes.CLI_CODIGO');
  FiltroExtra.Add('Left Outer Join Atividades on');
  FiltroExtra.Add('  Clientes.ATI_CODIGO = Atividades.ATI_CODIGO');
  FiltroExtra.Add('Left Outer Join Produtos on');
  FiltroExtra.Add('  Itens_Venda.PRO_CODIGO = Produtos.PRO_CODIGO');
  Sql.Add('order by Itens_Venda.VEN_NUMERO,Itens_Venda.ITE_SEQUENCIA');
  VEN_NUMERO := TDConsulta_Itens_Venda_VEN_NUMERO.Create(AOwner);
  VEN_NUMERO.Valor.DataSet := Self;
  ITE_SEQUENCIA := TDConsulta_Itens_Venda_ITE_SEQUENCIA.Create(AOwner);
  ITE_SEQUENCIA.Valor.DataSet := Self;
  PRO_CODIGO := TDConsulta_Itens_Venda_PRO_CODIGO.Create(AOwner);
  PRO_CODIGO.Valor.DataSet := Self;
  PRO_DESCRICAO := TDConsulta_Itens_Venda_PRO_DESCRICAO.Create(AOwner);
  PRO_DESCRICAO.Valor.DataSet := Self;
  ITE_QTDE := TDConsulta_Itens_Venda_ITE_QTDE.Create(AOwner);
  ITE_QTDE.Valor.DataSet := Self;
  ITE_PRECO := TDConsulta_Itens_Venda_ITE_PRECO.Create(AOwner);
  ITE_PRECO.Valor.DataSet := Self;
  ITE_TOTAL := TDConsulta_Itens_Venda_ITE_TOTAL.Create(AOwner);
  ITE_TOTAL.Valor.DataSet := Self;
  VEN_DATA := TDConsulta_Itens_Venda_VEN_DATA.Create(AOwner);
  VEN_DATA.Valor.DataSet := Self;
  CLI_CODIGO := TDConsulta_Itens_Venda_CLI_CODIGO.Create(AOwner);
  CLI_CODIGO.Valor.DataSet := Self;
  CLI_NOME := TDConsulta_Itens_Venda_CLI_NOME.Create(AOwner);
  CLI_NOME.Valor.DataSet := Self;
  ATI_CODIGO := TDConsulta_Itens_Venda_ATI_CODIGO.Create(AOwner);
  ATI_CODIGO.Valor.DataSet := Self;
  ATI_DESCRICAO := TDConsulta_Itens_Venda_ATI_DESCRICAO.Create(AOwner);
  ATI_DESCRICAO.Valor.DataSet := Self;
  ChavePrimaria.Add(VEN_NUMERO);
  ChavePrimaria.Add(ITE_SEQUENCIA);
  Campos.Add(VEN_NUMERO);
  Campos.Add(ITE_SEQUENCIA);
  Campos.Add(PRO_CODIGO);
  Campos.Add(ITE_QTDE);
  Campos.Add(ITE_PRECO);
  Campos.Add(ITE_TOTAL);
  Campos.Add(VEN_DATA);
  Campos.Add(CLI_CODIGO);
  Campos.Add(CLI_NOME);
  Campos.Add(ATI_CODIGO);
  Campos.Add(ATI_DESCRICAO);
  Campos.Add(PRO_DESCRICAO);
  TituloIndices.Add('Número,Seq.');
  Indices.Add('Itens_Venda.VEN_NUMERO,Itens_Venda.ITE_SEQUENCIA');
  Crescente.Add('S');
  TituloPrimaria := 'Número,Seq.';
  ChPrimaria     := 'Itens_Venda.VEN_NUMERO,Itens_Venda.ITE_SEQUENCIA';
  TituloIndice   := 'Número,Seq.';
  ChaveIndice    := 'Itens_Venda.VEN_NUMERO,Itens_Venda.ITE_SEQUENCIA';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDConsulta_Itens_Venda.CriaForeignKeys;
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

function TDConsulta_Itens_Venda.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDConsulta_Itens_Venda.ExclusaoCascata;
begin
end;

function TDConsulta_Itens_Venda.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Vendas') then
    if (UpperCase('VEN_NUMERO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], [Campo], Retorno) then
        Result := True;

  if UpperCase(Tabela) = UpperCase('Clientes') then
    if (UpperCase('CLI_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DClientes, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

  if UpperCase(Tabela) = UpperCase('Atividades') then
    if (UpperCase('ATI_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

  if UpperCase(Tabela) = UpperCase('Produtos') then
    if (UpperCase('PRO_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

end;

function TDConsulta_Itens_Venda.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Vendas') then
    if PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Clientes') then
    if PTabela(TabGlobal.DClientes, ['CLI_CODIGO'], [CLI_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Atividades') then
    if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Produtos') then
    if PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Itens_Venda') then
    if PTabela(TabGlobal.DConsulta_Itens_Venda, ['VEN_NUMERO','ITE_SEQUENCIA'], [VEN_NUMERO.Valor.Value,ITE_SEQUENCIA.Valor.Value]) then
      Result := True;
end;

procedure TDConsulta_Itens_Venda.CalculaCampos;
begin
end;

procedure TDConsulta_Itens_Venda.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDConsulta_Itens_Venda.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDConsulta_Itens_Venda.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDConsulta_Itens_Venda.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDConsulta_Itens_Venda.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDConsulta_Itens_Venda.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (VEN_NUMERO.SempreAtribui) and (VEN_NUMERO.AutoIncremento > 0) then
      AutoIncremento('VEN_NUMERO', True, VEN_NUMERO.AutoIncremento);
end;

procedure TDConsulta_Itens_Venda.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDConsulta_Itens_Venda.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDConsulta_Itens_Venda.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
