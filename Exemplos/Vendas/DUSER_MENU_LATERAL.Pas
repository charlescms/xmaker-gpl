{
 Classe da tabela: USER_MENU_LATERAL - Opções do Menu Lateral
}

unit DUSER_MENU_LATERAL;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0011,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_MENU_LATERAL = class(TTabela)
  public
    Opcao: TDUSER_MENU_LATERAL_Opcao;
    Grupo: TDUSER_MENU_LATERAL_Grupo;
    PorSenha: TDUSER_MENU_LATERAL_PorSenha;
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

constructor TDUSER_MENU_LATERAL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_MENU_LATERAL';
  Titulo           := 'Opções do Menu Lateral';
  Name             := 'DUSER_MENU_LATERAL';
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
  Open_begin       := False;
  Versao           := 6;
  UsarGenerator    := True;
  TableType        := ttTable;
  DataSource.Name  := 'DsUSER_MENU_LATERAL';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_MENU_LATERAL';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_MENU_LATERAL');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Opcao = :OLD_Opcao');
    DeleteSQL.Add('  and Grupo = :OLD_Grupo');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_MENU_LATERAL');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Opcao,');
    InsertSQL.Add('  Grupo,');
    InsertSQL.Add('  PorSenha');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Opcao,');
    InsertSQL.Add('  :Grupo,');
    InsertSQL.Add('  :PorSenha');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_MENU_LATERAL');
    ModifySQL.Add('set');
    ModifySQL.Add('  Opcao = :Opcao,');
    ModifySQL.Add('  Grupo = :Grupo,');
    ModifySQL.Add('  PorSenha = :PorSenha');
    ModifySQL.Add('where');
    ModifySQL.Add('  Opcao = :OLD_Opcao');
    ModifySQL.Add('  and Grupo = :OLD_Grupo');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_MENU_LATERAL.Opcao AS Opcao,');
    RefreshSQL.Add('  USER_MENU_LATERAL.Grupo AS Grupo,');
    RefreshSQL.Add('  USER_MENU_LATERAL.PorSenha AS PorSenha');
    RefreshSQL.Add('from USER_MENU_LATERAL');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_MENU_LATERAL.Opcao = :OLD_Opcao');
    RefreshSQL.Add('  and USER_MENU_LATERAL.Grupo = :OLD_Grupo');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_MENU_LATERAL.Opcao AS Opcao,');
  SqlPrincipal.Add('  USER_MENU_LATERAL.Grupo AS Grupo,');
  SqlPrincipal.Add('  USER_MENU_LATERAL.PorSenha AS PorSenha');
  SqlPrincipal.Add('from USER_MENU_LATERAL');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by USER_MENU_LATERAL.Opcao,USER_MENU_LATERAL.Grupo');
  Opcao := TDUSER_MENU_LATERAL_Opcao.Create(AOwner);
  Opcao.Valor.DataSet := Self;
  Grupo := TDUSER_MENU_LATERAL_Grupo.Create(AOwner);
  Grupo.Valor.DataSet := Self;
  PorSenha := TDUSER_MENU_LATERAL_PorSenha.Create(AOwner);
  PorSenha.Valor.DataSet := Self;
  ChavePrimaria.Add(Opcao);
  ChavePrimaria.Add(Grupo);
  Campos.Add(Opcao);
  Campos.Add(Grupo);
  Campos.Add(PorSenha);
  TituloIndices.Add('Opção,Grupo');
  Indices.Add('USER_MENU_LATERAL.Opcao,USER_MENU_LATERAL.Grupo');
  Crescente.Add('S');
  TituloPrimaria := 'Opção,Grupo';
  ChPrimaria     := 'USER_MENU_LATERAL.Opcao,USER_MENU_LATERAL.Grupo';
  TituloIndice   := 'Opção,Grupo';
  ChaveIndice    := 'USER_MENU_LATERAL.Opcao,USER_MENU_LATERAL.Grupo';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_MENU_LATERAL.CriaForeignKeys;
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

function TDUSER_MENU_LATERAL.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDUSER_MENU_LATERAL.ExclusaoCascata;
begin
end;

function TDUSER_MENU_LATERAL.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_MENU_LATERAL.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_MENU_LATERAL') then
    if PTabela(TabGlobal.DUSER_MENU_LATERAL, ['Opcao','Grupo'], [Opcao.Valor.Value,Grupo.Valor.Value]) then
      Result := True;
end;

procedure TDUSER_MENU_LATERAL.CalculaCampos;
begin
end;

procedure TDUSER_MENU_LATERAL.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDUSER_MENU_LATERAL.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
var
  I: Integer;
begin
  Filtro.Clear;
  FiltroRelac.Clear;
  if Atribui then
  begin
    FiltroRelac.Add('USER_MENU_LATERAL.Grupo = :USER_GRUPOS_Grupo');
  end
  else
    for I:=0 to Campos.Count-1 do
      TAtributo(Campos[I]).Valor.OnValidate := nil;
  Grupo.Valor.ReadOnly := Atribui;
  if Atualiza then
    AtualizaSql;
end;

procedure TDUSER_MENU_LATERAL.AtribuiMestre(DataSet: TDataSet);
begin
  Grupo.Valor.Value := TabGlobal.DUSER_GRUPOS.Grupo.Valor.Value;
end;

procedure TDUSER_MENU_LATERAL.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDUSER_MENU_LATERAL.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDUSER_MENU_LATERAL.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (Opcao.SempreAtribui) and (Opcao.AutoIncremento > 0) then
      AutoIncremento('Opcao', True, Opcao.AutoIncremento);
end;

procedure TDUSER_MENU_LATERAL.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_MENU_LATERAL.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_MENU_LATERAL.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
