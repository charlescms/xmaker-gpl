{
 Classe da tabela: Produtos - Tabela de Produtos
}

unit DProdutos;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0006,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDProdutos = class(TTabela)
  public
    PRO_CODIGO: TDProdutos_PRO_CODIGO;
    PRO_DESCRICAO: TDProdutos_PRO_DESCRICAO;
    PRO_QUANTIDADE: TDProdutos_PRO_QUANTIDADE;
    PRO_MINIMO: TDProdutos_PRO_MINIMO;
    PRO_MAXIMO: TDProdutos_PRO_MAXIMO;
    PRO_CUSTO: TDProdutos_PRO_CUSTO;
    PRO_MARGEM: TDProdutos_PRO_MARGEM;
    PRO_PRECO: TDProdutos_PRO_PRECO;
    TOTAL_CUSTO: TDProdutos_TOTAL_CUSTO;
    TOTAL_VENDA: TDProdutos_TOTAL_VENDA;
    PRO_FOTO: TDProdutos_PRO_FOTO;
    FOR_CODIGO: TDProdutos_FOR_CODIGO;
    FOR_CODIGO_2: TDProdutos_FOR_CODIGO_2;
    FOR_NOME: TDProdutos_FOR_NOME;
    FOR_NOME_2: TDProdutos_FOR_NOME_2;
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

constructor TDProdutos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Produtos';
  Titulo           := 'Tabela de Produtos';
  Name             := 'DProdutos';
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
  DataSource.Name  := 'DsProdutos';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Produtos';
    // Exclusão de Registro
    DeleteSQL.Add('delete from Produtos');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  PRO_CODIGO = :OLD_PRO_CODIGO');
    // Inserção de Registro
    InsertSQL.Add('insert into Produtos');
    InsertSQL.Add('  (');
    InsertSQL.Add('  PRO_CODIGO,');
    InsertSQL.Add('  PRO_DESCRICAO,');
    InsertSQL.Add('  PRO_QUANTIDADE,');
    InsertSQL.Add('  PRO_MINIMO,');
    InsertSQL.Add('  PRO_MAXIMO,');
    InsertSQL.Add('  PRO_CUSTO,');
    InsertSQL.Add('  PRO_MARGEM,');
    InsertSQL.Add('  PRO_PRECO,');
    InsertSQL.Add('  PRO_FOTO,');
    InsertSQL.Add('  FOR_CODIGO,');
    InsertSQL.Add('  FOR_CODIGO_2');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :PRO_CODIGO,');
    InsertSQL.Add('  :PRO_DESCRICAO,');
    InsertSQL.Add('  :PRO_QUANTIDADE,');
    InsertSQL.Add('  :PRO_MINIMO,');
    InsertSQL.Add('  :PRO_MAXIMO,');
    InsertSQL.Add('  :PRO_CUSTO,');
    InsertSQL.Add('  :PRO_MARGEM,');
    InsertSQL.Add('  :PRO_PRECO,');
    InsertSQL.Add('  :PRO_FOTO,');
    InsertSQL.Add('  :FOR_CODIGO,');
    InsertSQL.Add('  :FOR_CODIGO_2');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update Produtos');
    ModifySQL.Add('set');
    ModifySQL.Add('  PRO_CODIGO = :PRO_CODIGO,');
    ModifySQL.Add('  PRO_DESCRICAO = :PRO_DESCRICAO,');
    ModifySQL.Add('  PRO_QUANTIDADE = :PRO_QUANTIDADE,');
    ModifySQL.Add('  PRO_MINIMO = :PRO_MINIMO,');
    ModifySQL.Add('  PRO_MAXIMO = :PRO_MAXIMO,');
    ModifySQL.Add('  PRO_CUSTO = :PRO_CUSTO,');
    ModifySQL.Add('  PRO_MARGEM = :PRO_MARGEM,');
    ModifySQL.Add('  PRO_PRECO = :PRO_PRECO,');
    ModifySQL.Add('  PRO_FOTO = :PRO_FOTO,');
    ModifySQL.Add('  FOR_CODIGO = :FOR_CODIGO,');
    ModifySQL.Add('  FOR_CODIGO_2 = :FOR_CODIGO_2');
    ModifySQL.Add('where');
    ModifySQL.Add('  PRO_CODIGO = :OLD_PRO_CODIGO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Produtos.PRO_CODIGO AS PRO_CODIGO,');
    RefreshSQL.Add('  Produtos.PRO_DESCRICAO AS PRO_DESCRICAO,');
    RefreshSQL.Add('  Produtos.PRO_QUANTIDADE AS PRO_QUANTIDADE,');
    RefreshSQL.Add('  Produtos.PRO_MINIMO AS PRO_MINIMO,');
    RefreshSQL.Add('  Produtos.PRO_MAXIMO AS PRO_MAXIMO,');
    RefreshSQL.Add('  Produtos.PRO_CUSTO AS PRO_CUSTO,');
    RefreshSQL.Add('  Produtos.PRO_MARGEM AS PRO_MARGEM,');
    RefreshSQL.Add('  Produtos.PRO_PRECO AS PRO_PRECO,');
    RefreshSQL.Add('  Produtos.PRO_FOTO AS PRO_FOTO,');
    RefreshSQL.Add('  Produtos.FOR_CODIGO AS FOR_CODIGO,');
    RefreshSQL.Add('  Produtos.FOR_CODIGO_2 AS FOR_CODIGO_2,');
    RefreshSQL.Add('  Fornecedores.FOR_NOME AS FOR_NOME,');
    RefreshSQL.Add('  Fornecedores_2.FOR_NOME AS FOR_NOME_2');
    RefreshSQL.Add('from Produtos');
    RefreshSQL.Add('Left Outer Join Fornecedores Fornecedores_2 on');
    RefreshSQL.Add('  Produtos.FOR_CODIGO_2 = Fornecedores_2.FOR_CODIGO');
    RefreshSQL.Add('Left Outer Join Fornecedores on');
    RefreshSQL.Add('  Produtos.FOR_CODIGO = Fornecedores.FOR_CODIGO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Produtos.PRO_CODIGO = :OLD_PRO_CODIGO');
  end;
  TabelasExtras.Add('Fornecedores_2');
  TabelasExtras.Add('Fornecedores');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Produtos.PRO_CODIGO AS PRO_CODIGO,');
  SqlPrincipal.Add('  Produtos.PRO_DESCRICAO AS PRO_DESCRICAO,');
  SqlPrincipal.Add('  Produtos.PRO_QUANTIDADE AS PRO_QUANTIDADE,');
  SqlPrincipal.Add('  Produtos.PRO_MINIMO AS PRO_MINIMO,');
  SqlPrincipal.Add('  Produtos.PRO_MAXIMO AS PRO_MAXIMO,');
  SqlPrincipal.Add('  Produtos.PRO_CUSTO AS PRO_CUSTO,');
  SqlPrincipal.Add('  Produtos.PRO_MARGEM AS PRO_MARGEM,');
  SqlPrincipal.Add('  Produtos.PRO_PRECO AS PRO_PRECO,');
  SqlPrincipal.Add('  Produtos.PRO_FOTO AS PRO_FOTO,');
  SqlPrincipal.Add('  Produtos.FOR_CODIGO AS FOR_CODIGO,');
  SqlPrincipal.Add('  Produtos.FOR_CODIGO_2 AS FOR_CODIGO_2,');
  SqlPrincipal.Add('  Fornecedores.FOR_NOME AS FOR_NOME,');
  SqlPrincipal.Add('  Fornecedores_2.FOR_NOME AS FOR_NOME_2');
  SqlPrincipal.Add('from Produtos');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join Fornecedores Fornecedores_2 on');
  FiltroExtra.Add('  Produtos.FOR_CODIGO_2 = Fornecedores_2.FOR_CODIGO');
  FiltroExtra.Add('Left Outer Join Fornecedores on');
  FiltroExtra.Add('  Produtos.FOR_CODIGO = Fornecedores.FOR_CODIGO');
  Sql.Add('order by Produtos.PRO_CODIGO');
  PRO_CODIGO := TDProdutos_PRO_CODIGO.Create(AOwner);
  PRO_CODIGO.Valor.DataSet := Self;
  PRO_DESCRICAO := TDProdutos_PRO_DESCRICAO.Create(AOwner);
  PRO_DESCRICAO.Valor.DataSet := Self;
  PRO_QUANTIDADE := TDProdutos_PRO_QUANTIDADE.Create(AOwner);
  PRO_QUANTIDADE.Valor.DataSet := Self;
  PRO_MINIMO := TDProdutos_PRO_MINIMO.Create(AOwner);
  PRO_MINIMO.Valor.DataSet := Self;
  PRO_MAXIMO := TDProdutos_PRO_MAXIMO.Create(AOwner);
  PRO_MAXIMO.Valor.DataSet := Self;
  PRO_CUSTO := TDProdutos_PRO_CUSTO.Create(AOwner);
  PRO_CUSTO.Valor.DataSet := Self;
  PRO_MARGEM := TDProdutos_PRO_MARGEM.Create(AOwner);
  PRO_MARGEM.Valor.DataSet := Self;
  PRO_PRECO := TDProdutos_PRO_PRECO.Create(AOwner);
  PRO_PRECO.Valor.DataSet := Self;
  TOTAL_CUSTO := TDProdutos_TOTAL_CUSTO.Create(AOwner);
  TOTAL_CUSTO.Valor.DataSet := Self;
  TOTAL_VENDA := TDProdutos_TOTAL_VENDA.Create(AOwner);
  TOTAL_VENDA.Valor.DataSet := Self;
  PRO_FOTO := TDProdutos_PRO_FOTO.Create(AOwner);
  PRO_FOTO.Valor.DataSet := Self;
  FOR_CODIGO := TDProdutos_FOR_CODIGO.Create(AOwner);
  FOR_CODIGO.Valor.DataSet := Self;
  FOR_NOME := TDProdutos_FOR_NOME.Create(AOwner);
  FOR_NOME.Valor.DataSet := Self;
  FOR_CODIGO_2 := TDProdutos_FOR_CODIGO_2.Create(AOwner);
  FOR_CODIGO_2.Valor.DataSet := Self;
  FOR_NOME_2 := TDProdutos_FOR_NOME_2.Create(AOwner);
  FOR_NOME_2.Valor.DataSet := Self;
  ChavePrimaria.Add(PRO_CODIGO);
  Campos.Add(PRO_CODIGO);
  Campos.Add(PRO_DESCRICAO);
  Campos.Add(PRO_QUANTIDADE);
  Campos.Add(PRO_MINIMO);
  Campos.Add(PRO_MAXIMO);
  Campos.Add(PRO_CUSTO);
  Campos.Add(PRO_MARGEM);
  Campos.Add(PRO_PRECO);
  Campos.Add(TOTAL_CUSTO);
  Campos.Add(TOTAL_VENDA);
  Campos.Add(PRO_FOTO);
  Campos.Add(FOR_CODIGO);
  Campos.Add(FOR_CODIGO_2);
  Campos.Add(FOR_NOME);
  Campos.Add(FOR_NOME_2);
  TituloIndices.Add('Produto');
  Indices.Add('Produtos.PRO_CODIGO');
  Crescente.Add('S');
  TituloPrimaria := 'Produto';
  ChPrimaria     := 'Produtos.PRO_CODIGO';
  TituloIndices.Add('Por Descrição');
  Indices.Add('Produtos.PRO_DESCRICAO');
  Crescente.Add('S');
  TituloIndice   := 'Produto';
  ChaveIndice    := 'Produtos.PRO_CODIGO';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDProdutos.CriaForeignKeys;
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

function TDProdutos.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
  if PTabela(TabGlobal.DItens_Venda, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value]) then
  begin
    MessageDlg('Registro está ligado a tabela: '+TabGlobal.DItens_Venda.Titulo,mtError,[mbOk],0);
    PodeExcluir := False;
    exit;
  end;
end;

procedure TDProdutos.ExclusaoCascata;
begin
end;

function TDProdutos.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Fornecedores') then
    if (UpperCase('FOR_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DFornecedores, ['FOR_CODIGO'], [FOR_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

  if UpperCase(Tabela) = UpperCase('Fornecedores_2') then
    if (UpperCase('FOR_CODIGO_2') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DFornecedores_2, ['FOR_CODIGO'], [FOR_CODIGO_2.Valor.Value], [Campo], Retorno) then
        Result := True;

end;

function TDProdutos.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Fornecedores') then
    if PTabela(TabGlobal.DFornecedores, ['FOR_CODIGO'], [FOR_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Fornecedores_2') then
    if PTabela(TabGlobal.DFornecedores_2, ['FOR_CODIGO'], [FOR_CODIGO_2.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Produtos') then
    if PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value]) then
      Result := True;
end;

procedure TDProdutos.CalculaCampos;
begin
end;

procedure TDProdutos.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDProdutos.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDProdutos.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDProdutos.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDProdutos.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDProdutos.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (PRO_CODIGO.SempreAtribui) and (PRO_CODIGO.AutoIncremento > 0) then
      AutoIncremento('PRO_CODIGO', True, PRO_CODIGO.AutoIncremento);
end;

procedure TDProdutos.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDProdutos.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDProdutos.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
