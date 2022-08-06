{
 Classe da tabela: USER_MENU_SUPERIOR - Opções do Menu Superior
}

unit DUSER_MENU_SUPERIOR;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0012,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_MENU_SUPERIOR = class(TTabela)
  public
    Opcao: TDUSER_MENU_SUPERIOR_Opcao;
    Grupo: TDUSER_MENU_SUPERIOR_Grupo;
    PorSenha: TDUSER_MENU_SUPERIOR_PorSenha;
    Invisivel: TDUSER_MENU_SUPERIOR_Invisivel;
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

constructor TDUSER_MENU_SUPERIOR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_MENU_SUPERIOR';
  Titulo           := 'Opções do Menu Superior';
  Name             := 'DUSER_MENU_SUPERIOR';
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
  DataSource.Name  := 'DsUSER_MENU_SUPERIOR';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_MENU_SUPERIOR';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_MENU_SUPERIOR');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Opcao = :OLD_Opcao');
    DeleteSQL.Add('  and Grupo = :OLD_Grupo');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_MENU_SUPERIOR');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Opcao,');
    InsertSQL.Add('  Grupo,');
    InsertSQL.Add('  PorSenha,');
    InsertSQL.Add('  Invisivel');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Opcao,');
    InsertSQL.Add('  :Grupo,');
    InsertSQL.Add('  :PorSenha,');
    InsertSQL.Add('  :Invisivel');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_MENU_SUPERIOR');
    ModifySQL.Add('set');
    ModifySQL.Add('  Opcao = :Opcao,');
    ModifySQL.Add('  Grupo = :Grupo,');
    ModifySQL.Add('  PorSenha = :PorSenha,');
    ModifySQL.Add('  Invisivel = :Invisivel');
    ModifySQL.Add('where');
    ModifySQL.Add('  Opcao = :OLD_Opcao');
    ModifySQL.Add('  and Grupo = :OLD_Grupo');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_MENU_SUPERIOR.Opcao AS Opcao,');
    RefreshSQL.Add('  USER_MENU_SUPERIOR.Grupo AS Grupo,');
    RefreshSQL.Add('  USER_MENU_SUPERIOR.PorSenha AS PorSenha,');
    RefreshSQL.Add('  USER_MENU_SUPERIOR.Invisivel AS Invisivel');
    RefreshSQL.Add('from USER_MENU_SUPERIOR');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_MENU_SUPERIOR.Opcao = :OLD_Opcao');
    RefreshSQL.Add('  and USER_MENU_SUPERIOR.Grupo = :OLD_Grupo');
  end;
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_MENU_SUPERIOR.Opcao AS Opcao,');
  SqlPrincipal.Add('  USER_MENU_SUPERIOR.Grupo AS Grupo,');
  SqlPrincipal.Add('  USER_MENU_SUPERIOR.PorSenha AS PorSenha,');
  SqlPrincipal.Add('  USER_MENU_SUPERIOR.Invisivel AS Invisivel');
  SqlPrincipal.Add('from USER_MENU_SUPERIOR');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  Sql.Add('order by USER_MENU_SUPERIOR.Opcao,USER_MENU_SUPERIOR.Grupo');
  Opcao := TDUSER_MENU_SUPERIOR_Opcao.Create(AOwner);
  Opcao.Valor.DataSet := Self;
  Grupo := TDUSER_MENU_SUPERIOR_Grupo.Create(AOwner);
  Grupo.Valor.DataSet := Self;
  PorSenha := TDUSER_MENU_SUPERIOR_PorSenha.Create(AOwner);
  PorSenha.Valor.DataSet := Self;
  Invisivel := TDUSER_MENU_SUPERIOR_Invisivel.Create(AOwner);
  Invisivel.Valor.DataSet := Self;
  ChavePrimaria.Add(Opcao);
  ChavePrimaria.Add(Grupo);
  Campos.Add(Opcao);
  Campos.Add(Grupo);
  Campos.Add(PorSenha);
  Campos.Add(Invisivel);
  TituloIndices.Add('Opção,Grupo');
  Indices.Add('USER_MENU_SUPERIOR.Opcao,USER_MENU_SUPERIOR.Grupo');
  Crescente.Add('S');
  TituloPrimaria := 'Opção,Grupo';
  ChPrimaria     := 'USER_MENU_SUPERIOR.Opcao,USER_MENU_SUPERIOR.Grupo';
  TituloIndice   := 'Opção,Grupo';
  ChaveIndice    := 'USER_MENU_SUPERIOR.Opcao,USER_MENU_SUPERIOR.Grupo';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_MENU_SUPERIOR.CriaForeignKeys;
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

function TDUSER_MENU_SUPERIOR.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDUSER_MENU_SUPERIOR.ExclusaoCascata;
begin
end;

function TDUSER_MENU_SUPERIOR.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_MENU_SUPERIOR.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_MENU_SUPERIOR') then
    if PTabela(TabGlobal.DUSER_MENU_SUPERIOR, ['Opcao','Grupo'], [Opcao.Valor.Value,Grupo.Valor.Value]) then
      Result := True;
end;

procedure TDUSER_MENU_SUPERIOR.CalculaCampos;
begin
end;

procedure TDUSER_MENU_SUPERIOR.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDUSER_MENU_SUPERIOR.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
var
  I: Integer;
begin
  Filtro.Clear;
  FiltroRelac.Clear;
  if Atribui then
  begin
    FiltroRelac.Add('USER_MENU_SUPERIOR.Grupo = :USER_GRUPOS_Grupo');
  end
  else
    for I:=0 to Campos.Count-1 do
      TAtributo(Campos[I]).Valor.OnValidate := nil;
  Grupo.Valor.ReadOnly := Atribui;
  if Atualiza then
    AtualizaSql;
end;

procedure TDUSER_MENU_SUPERIOR.AtribuiMestre(DataSet: TDataSet);
begin
  Grupo.Valor.Value := TabGlobal.DUSER_GRUPOS.Grupo.Valor.Value;
end;

procedure TDUSER_MENU_SUPERIOR.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDUSER_MENU_SUPERIOR.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDUSER_MENU_SUPERIOR.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (Opcao.SempreAtribui) and (Opcao.AutoIncremento > 0) then
      AutoIncremento('Opcao', True, Opcao.AutoIncremento);
end;

procedure TDUSER_MENU_SUPERIOR.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_MENU_SUPERIOR.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_MENU_SUPERIOR.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
