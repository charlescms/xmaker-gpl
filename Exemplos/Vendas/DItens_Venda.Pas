{
 Classe da tabela: Itens_Venda - Tabela de Itens da Venda
}

unit DItens_Venda;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0005,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDItens_Venda = class(TTabela)
  public
    VEN_NUMERO: TDItens_Venda_VEN_NUMERO;
    ITE_SEQUENCIA: TDItens_Venda_ITE_SEQUENCIA;
    PRO_CODIGO: TDItens_Venda_PRO_CODIGO;
    PRO_DESCRICAO: TDItens_Venda_PRO_DESCRICAO;
    ITE_QTDE: TDItens_Venda_ITE_QTDE;
    ITE_PRECO: TDItens_Venda_ITE_PRECO;
    ITE_TOTAL: TDItens_Venda_ITE_TOTAL;
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

constructor TDItens_Venda.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Itens_Venda';
  Titulo           := 'Tabela de Itens da Venda';
  Name             := 'DItens_Venda';
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
  DataSource.Name  := 'DsItens_Venda';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Itens_Venda';
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
    RefreshSQL.Add('  Produtos.PRO_DESCRICAO AS PRO_DESCRICAO,');
    RefreshSQL.Add('  Itens_Venda.ITE_QTDE AS ITE_QTDE,');
    RefreshSQL.Add('  Itens_Venda.ITE_PRECO AS ITE_PRECO');
    RefreshSQL.Add('from Itens_Venda');
    RefreshSQL.Add('Left Outer Join Produtos on');
    RefreshSQL.Add('  Itens_Venda.PRO_CODIGO = Produtos.PRO_CODIGO');
    RefreshSQL.Add('Left Outer Join Vendas on');
    RefreshSQL.Add('  Itens_Venda.VEN_NUMERO = Vendas.VEN_NUMERO');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Itens_Venda.VEN_NUMERO = :OLD_VEN_NUMERO');
    RefreshSQL.Add('  and Itens_Venda.ITE_SEQUENCIA = :OLD_ITE_SEQUENCIA');
  end;
  TabelasExtras.Add('Produtos');
  TabelasExtras.Add('Vendas');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Itens_Venda.VEN_NUMERO AS VEN_NUMERO,');
  SqlPrincipal.Add('  Itens_Venda.ITE_SEQUENCIA AS ITE_SEQUENCIA,');
  SqlPrincipal.Add('  Itens_Venda.PRO_CODIGO AS PRO_CODIGO,');
  SqlPrincipal.Add('  Produtos.PRO_DESCRICAO AS PRO_DESCRICAO,');
  SqlPrincipal.Add('  Itens_Venda.ITE_QTDE AS ITE_QTDE,');
  SqlPrincipal.Add('  Itens_Venda.ITE_PRECO AS ITE_PRECO');
  SqlPrincipal.Add('from Itens_Venda');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join Produtos on');
  FiltroExtra.Add('  Itens_Venda.PRO_CODIGO = Produtos.PRO_CODIGO');
  FiltroExtra.Add('Left Outer Join Vendas on');
  FiltroExtra.Add('  Itens_Venda.VEN_NUMERO = Vendas.VEN_NUMERO');
  Sql.Add('order by Itens_Venda.VEN_NUMERO,Itens_Venda.ITE_SEQUENCIA');
  VEN_NUMERO := TDItens_Venda_VEN_NUMERO.Create(AOwner);
  VEN_NUMERO.Valor.DataSet := Self;
  ITE_SEQUENCIA := TDItens_Venda_ITE_SEQUENCIA.Create(AOwner);
  ITE_SEQUENCIA.Valor.DataSet := Self;
  PRO_CODIGO := TDItens_Venda_PRO_CODIGO.Create(AOwner);
  PRO_CODIGO.Valor.DataSet := Self;
  PRO_DESCRICAO := TDItens_Venda_PRO_DESCRICAO.Create(AOwner);
  PRO_DESCRICAO.Valor.DataSet := Self;
  ITE_QTDE := TDItens_Venda_ITE_QTDE.Create(AOwner);
  ITE_QTDE.Valor.DataSet := Self;
  ITE_PRECO := TDItens_Venda_ITE_PRECO.Create(AOwner);
  ITE_PRECO.Valor.DataSet := Self;
  ITE_TOTAL := TDItens_Venda_ITE_TOTAL.Create(AOwner);
  ITE_TOTAL.Valor.DataSet := Self;
  ChavePrimaria.Add(VEN_NUMERO);
  ChavePrimaria.Add(ITE_SEQUENCIA);
  Campos.Add(VEN_NUMERO);
  Campos.Add(ITE_SEQUENCIA);
  Campos.Add(PRO_CODIGO);
  Campos.Add(PRO_DESCRICAO);
  Campos.Add(ITE_QTDE);
  Campos.Add(ITE_PRECO);
  Campos.Add(ITE_TOTAL);
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

procedure TDItens_Venda.CriaForeignKeys;
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

function TDItens_Venda.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDItens_Venda.ExclusaoCascata;
begin
end;

function TDItens_Venda.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Produtos') then
    if (UpperCase('PRO_CODIGO') = UpperCase(CampoFoco)) then
      if PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value], [Campo], Retorno) then
        Result := True;

end;

function TDItens_Venda.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Produtos') then
    if PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Vendas') then
    if PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('Itens_Venda') then
    if PTabela(TabGlobal.DItens_Venda, ['VEN_NUMERO','ITE_SEQUENCIA'], [VEN_NUMERO.Valor.Value,ITE_SEQUENCIA.Valor.Value]) then
      Result := True;
end;

procedure TDItens_Venda.CalculaCampos;
begin
end;

procedure TDItens_Venda.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDItens_Venda.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
var
  I: Integer;
begin
  Filtro.Clear;
  FiltroRelac.Clear;
  if Atribui then
  begin
    FiltroRelac.Add('Itens_Venda.VEN_NUMERO = :Vendas_VEN_NUMERO');
  end
  else
    for I:=0 to Campos.Count-1 do
      TAtributo(Campos[I]).Valor.OnValidate := nil;
  VEN_NUMERO.Valor.ReadOnly := Atribui;
  if Atualiza then
    AtualizaSql;
end;

procedure TDItens_Venda.AtribuiMestre(DataSet: TDataSet);
begin
  VEN_NUMERO.Valor.Value := TabGlobal.DVendas.VEN_NUMERO.Valor.Value;
end;

procedure TDItens_Venda.ProcessoDireto1(DataSet: TDataSet);
var
  QueryLc: TTabela;
  EmEdicao: Boolean;
begin
  EmEdicao := TabGlobal.DProdutos.Modificacao;
  if EmEdicao then
    TabGlobal.DProdutos.Salva;
  if not PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value], 'PRO_QUANTIDADE = PRO_QUANTIDADE - :Itens_Venda_ITE_QTDE') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DProdutos.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DProdutos.Modifica;
  EmEdicao := TabGlobal.DVendas.Modificacao;
  if EmEdicao then
    TabGlobal.DVendas.Salva;
  if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_TOTAL = VEN_TOTAL + :Itens_Venda_ITE_TOTAL') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DVendas.Modifica;
  EmEdicao := TabGlobal.DVendas.Modificacao;
  if EmEdicao then
    TabGlobal.DVendas.Salva;
  if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_QTDE = VEN_QTDE + :Itens_Venda_ITE_QTDE') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DVendas.Modifica;
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDItens_Venda.ProcessoDireto2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if Modificacao then
  begin
    EmEdicao := TabGlobal.DProdutos.Modificacao;
    if EmEdicao then
      TabGlobal.DProdutos.Salva;
    if not PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value], 'PRO_QUANTIDADE = PRO_QUANTIDADE - :Itens_Venda_ITE_QTDE') then
      MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DProdutos.Titulo, mtError, [mbOk],  0);
    if EmEdicao then
      TabGlobal.DProdutos.Modifica;
  end;
  if Modificacao then
  begin
    EmEdicao := TabGlobal.DVendas.Modificacao;
    if EmEdicao then
      TabGlobal.DVendas.Salva;
    if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_TOTAL = VEN_TOTAL + :Itens_Venda_ITE_TOTAL') then
      MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
    if EmEdicao then
      TabGlobal.DVendas.Modifica;
  end;
  if Modificacao then
  begin
    EmEdicao := TabGlobal.DVendas.Modificacao;
    if EmEdicao then
      TabGlobal.DVendas.Salva;
    if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_QTDE = VEN_QTDE + :Itens_Venda_ITE_QTDE') then
      MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
    if EmEdicao then
      TabGlobal.DVendas.Modifica;
  end;
  {$IFDEF IBX}
  Transaction.CommitRetaining;
  {$ELSE}
  {$ENDIF}
  Inclusao    := False;
  Modificacao := False;
end;

procedure TDItens_Venda.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (VEN_NUMERO.SempreAtribui) and (VEN_NUMERO.AutoIncremento > 0) then
      AutoIncremento('VEN_NUMERO', True, VEN_NUMERO.AutoIncremento);
end;

procedure TDItens_Venda.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  EmEdicao := TabGlobal.DProdutos.Modificacao;
  if EmEdicao then
    TabGlobal.DProdutos.Salva;
  if not PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value], 'PRO_QUANTIDADE = PRO_QUANTIDADE + :Itens_Venda_ITE_QTDE') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DProdutos.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DProdutos.Modifica;
  EmEdicao := TabGlobal.DVendas.Modificacao;
  if EmEdicao then
    TabGlobal.DVendas.Salva;
  if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_TOTAL = VEN_TOTAL - :Itens_Venda_ITE_TOTAL') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DVendas.Modifica;
  EmEdicao := TabGlobal.DVendas.Modificacao;
  if EmEdicao then
    TabGlobal.DVendas.Salva;
  if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_QTDE = VEN_QTDE - :Itens_Venda_ITE_QTDE') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DVendas.Modifica;
end;

procedure TDItens_Venda.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  EmEdicao := TabGlobal.DProdutos.Modificacao;
  if EmEdicao then
    TabGlobal.DProdutos.Salva;
  if not PTabela(TabGlobal.DProdutos, ['PRO_CODIGO'], [PRO_CODIGO.Valor.Value], 'PRO_QUANTIDADE = PRO_QUANTIDADE + :Itens_Venda_ITE_QTDE') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DProdutos.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DProdutos.Modifica;
  EmEdicao := TabGlobal.DVendas.Modificacao;
  if EmEdicao then
    TabGlobal.DVendas.Salva;
  if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_TOTAL = VEN_TOTAL - :Itens_Venda_ITE_TOTAL') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DVendas.Modifica;
  EmEdicao := TabGlobal.DVendas.Modificacao;
  if EmEdicao then
    TabGlobal.DVendas.Salva;
  if not PTabela(TabGlobal.DVendas, ['VEN_NUMERO'], [VEN_NUMERO.Valor.Value], 'VEN_QTDE = VEN_QTDE - :Itens_Venda_ITE_QTDE') then
    MessageDlg('Falha na atualização da Tabela: '+TabGlobal.DVendas.Titulo, mtError, [mbOk],  0);
  if EmEdicao then
    TabGlobal.DVendas.Modifica;
  ExclusaoCascata;
end;

procedure TDItens_Venda.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
