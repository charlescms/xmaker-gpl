{
 Classe da tabela: Atividades - Tabela de Atividades Comerciais
}

unit DAtividades;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0000,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDAtividades = class(TTabela)
  public
    ATI_CODIGO: TDAtividades_ATI_CODIGO;
    ATI_DESCRICAO: TDAtividades_ATI_DESCRICAO;
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

constructor TDAtividades.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'Atividades';
  Titulo           := 'Tabela de Atividades Comerciais';
  Name             := 'DAtividades';
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
  DataSource.Name  := 'DsAtividades';
  with UpdateSql do
  begin
    Name           := 'UpdSql_Atividades';
    // Exclusão de Registro
    DeleteSQL.Add('delete from Atividades');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  ATI_CODIGO = :OLD_ATI_CODIGO');
    // Inserção de Registro
    InsertSQL.Add('insert into Atividades');
    InsertSQL.Add('  (');
    InsertSQL.Add('  ATI_CODIGO,');
    InsertSQL.Add('  ATI_DESCRICAO');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :ATI_CODIGO,');
    InsertSQL.Add('  :ATI_DESCRICAO');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update Atividades');
    ModifySQL.Add('set');
    ModifySQL.Add('  ATI_CODIGO = :ATI_CODIGO,');
    ModifySQL.Add('  ATI_DESCRICAO = :ATI_DESCRICAO');
    ModifySQL.Add('where');
    ModifySQL.Add('  ATI_CODIGO = :OLD_ATI_CODIGO');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  Atividades.ATI_CODIGO AS ATI_CODIGO,');
    RefreshSQL.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO');
    RefreshSQL.Add('from Atividades');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  Atividades.ATI_CODIGO = :OLD_ATI_CODIGO');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  Atividades.ATI_CODIGO AS ATI_CODIGO,');
  SqlPrincipal.Add('  Atividades.ATI_DESCRICAO AS ATI_DESCRICAO');
  SqlPrincipal.Add('from Atividades');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by Atividades.ATI_CODIGO');
  ATI_CODIGO := TDAtividades_ATI_CODIGO.Create(AOwner);
  ATI_CODIGO.Valor.DataSet := Self;
  ATI_DESCRICAO := TDAtividades_ATI_DESCRICAO.Create(AOwner);
  ATI_DESCRICAO.Valor.DataSet := Self;
  ChavePrimaria.Add(ATI_CODIGO);
  Campos.Add(ATI_CODIGO);
  Campos.Add(ATI_DESCRICAO);
  TituloIndices.Add('Código');
  Indices.Add('Atividades.ATI_CODIGO');
  Crescente.Add('S');
  TituloPrimaria := 'Código';
  ChPrimaria     := 'Atividades.ATI_CODIGO';
  TituloIndice   := 'Código';
  ChaveIndice    := 'Atividades.ATI_CODIGO';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDAtividades.CriaForeignKeys;
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

function TDAtividades.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
  if PTabela(TabGlobal.DClientes, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value]) then
  begin
    MessageDlg('Registro está ligado a tabela: '+TabGlobal.DClientes.Titulo,mtError,[mbOk],0);
    PodeExcluir := False;
    exit;
  end;
end;

procedure TDAtividades.ExclusaoCascata;
begin
end;

function TDAtividades.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDAtividades.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('Atividades') then
    if PTabela(TabGlobal.DAtividades, ['ATI_CODIGO'], [ATI_CODIGO.Valor.Value]) then
      Result := True;
end;

procedure TDAtividades.CalculaCampos;
begin
end;

procedure TDAtividades.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDAtividades.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDAtividades.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDAtividades.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDAtividades.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDAtividades.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (ATI_CODIGO.SempreAtribui) and (ATI_CODIGO.AutoIncremento > 0) then
      AutoIncremento('ATI_CODIGO', True, ATI_CODIGO.AutoIncremento);
end;

procedure TDAtividades.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDAtividades.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDAtividades.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
