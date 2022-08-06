{
 Classe da tabela: USER_AGENDA - Agenda de Telefones
}

unit DUSER_AGENDA;

interface

{$I Princ.inc}

uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,
     AtrL0007,
     {$IFDEF IBX}
     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,
     {$ELSE}
     XSEngine,
     {$ENDIF}
     DB, Dialogs;

type
  TDUSER_AGENDA = class(TTabela)
  public
    Sequencia: TDUSER_AGENDA_Sequencia;
    Usuario: TDUSER_AGENDA_Usuario;
    Nome: TDUSER_AGENDA_Nome;
    Telefone: TDUSER_AGENDA_Telefone;
    Complemento: TDUSER_AGENDA_Complemento;
    Compartilhado: TDUSER_AGENDA_Compartilhado;
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

constructor TDUSER_AGENDA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NomeTabela       := 'USER_AGENDA';
  Titulo           := 'Agenda de Telefones';
  Name             := 'DUSER_AGENDA';
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
  DataSource.Name  := 'DsUSER_AGENDA';
  with UpdateSql do
  begin
    Name           := 'UpdSql_USER_AGENDA';
    // Exclusão de Registro
    DeleteSQL.Add('delete from USER_AGENDA');
    DeleteSQL.Add('where');
    DeleteSQL.Add('  Sequencia = :OLD_Sequencia');
    // Inserção de Registro
    InsertSQL.Add('insert into USER_AGENDA');
    InsertSQL.Add('  (');
    InsertSQL.Add('  Sequencia,');
    InsertSQL.Add('  Usuario,');
    InsertSQL.Add('  Nome,');
    InsertSQL.Add('  Telefone,');
    InsertSQL.Add('  Complemento,');
    InsertSQL.Add('  Compartilhado');
    InsertSQL.Add('  )');
    InsertSQL.Add('values');
    InsertSQL.Add('  (');
    InsertSQL.Add('  :Sequencia,');
    InsertSQL.Add('  :Usuario,');
    InsertSQL.Add('  :Nome,');
    InsertSQL.Add('  :Telefone,');
    InsertSQL.Add('  :Complemento,');
    InsertSQL.Add('  :Compartilhado');
    InsertSQL.Add('  )');
    // Modificação de Registro
    ModifySQL.Add('update USER_AGENDA');
    ModifySQL.Add('set');
    ModifySQL.Add('  Sequencia = :Sequencia,');
    ModifySQL.Add('  Usuario = :Usuario,');
    ModifySQL.Add('  Nome = :Nome,');
    ModifySQL.Add('  Telefone = :Telefone,');
    ModifySQL.Add('  Complemento = :Complemento,');
    ModifySQL.Add('  Compartilhado = :Compartilhado');
    ModifySQL.Add('where');
    ModifySQL.Add('  Sequencia = :OLD_Sequencia');
    // Refresh de Registro
    RefreshSQL.Add('Select');
    RefreshSQL.Add('  USER_AGENDA.Sequencia AS Sequencia,');
    RefreshSQL.Add('  USER_AGENDA.Usuario AS Usuario,');
    RefreshSQL.Add('  USER_AGENDA.Nome AS Nome,');
    RefreshSQL.Add('  USER_AGENDA.Telefone AS Telefone,');
    RefreshSQL.Add('  USER_AGENDA.Complemento AS Complemento,');
    RefreshSQL.Add('  USER_AGENDA.Compartilhado AS Compartilhado');
    RefreshSQL.Add('from USER_AGENDA');
    RefreshSQL.Add('Left Outer Join USER_NOMES on');
    RefreshSQL.Add('  USER_AGENDA.Usuario = USER_NOMES.Usuario');
    RefreshSQL.Add('where');
    RefreshSQL.Add('  USER_AGENDA.Sequencia = :OLD_Sequencia');
  end;
  TabelasExtras.Add('USER_NOMES');
  UpdateObject     := UpdateSql;
    // Sql Principal
  SqlPrincipal.Add('Select');
  SqlPrincipal.Add('  USER_AGENDA.Sequencia AS Sequencia,');
  SqlPrincipal.Add('  USER_AGENDA.Usuario AS Usuario,');
  SqlPrincipal.Add('  USER_AGENDA.Nome AS Nome,');
  SqlPrincipal.Add('  USER_AGENDA.Telefone AS Telefone,');
  SqlPrincipal.Add('  USER_AGENDA.Complemento AS Complemento,');
  SqlPrincipal.Add('  USER_AGENDA.Compartilhado AS Compartilhado');
  SqlPrincipal.Add('from USER_AGENDA');
  Sql.AddStrings(SqlPrincipal);
    // Foreign Key
  FiltroExtra.Add('Left Outer Join USER_NOMES on');
  FiltroExtra.Add('  USER_AGENDA.Usuario = USER_NOMES.Usuario');
  Sql.Add('order by USER_AGENDA.Sequencia');
  Sequencia := TDUSER_AGENDA_Sequencia.Create(AOwner);
  Sequencia.Valor.DataSet := Self;
  Usuario := TDUSER_AGENDA_Usuario.Create(AOwner);
  Usuario.Valor.DataSet := Self;
  Nome := TDUSER_AGENDA_Nome.Create(AOwner);
  Nome.Valor.DataSet := Self;
  Telefone := TDUSER_AGENDA_Telefone.Create(AOwner);
  Telefone.Valor.DataSet := Self;
  Complemento := TDUSER_AGENDA_Complemento.Create(AOwner);
  Complemento.Valor.DataSet := Self;
  Compartilhado := TDUSER_AGENDA_Compartilhado.Create(AOwner);
  Compartilhado.Valor.DataSet := Self;
  ChavePrimaria.Add(Sequencia);
  Campos.Add(Sequencia);
  Campos.Add(Usuario);
  Campos.Add(Nome);
  Campos.Add(Telefone);
  Campos.Add(Complemento);
  Campos.Add(Compartilhado);
  TituloIndices.Add('Sequência');
  Indices.Add('USER_AGENDA.Sequencia');
  Crescente.Add('S');
  TituloPrimaria := 'Sequência';
  ChPrimaria     := 'USER_AGENDA.Sequencia';
  TituloIndice   := 'Sequência';
  ChaveIndice    := 'USER_AGENDA.Sequencia';
  AfterInsert    := AtribuiMestre;
  AfterPost      := ProcessoDireto1;
  AfterCancel    := ProcessoDireto2;
  BeforePost     := AtualizaCalculados;
  BeforeEdit     := ProcessoInverso1;
  BeforeDelete   := ProcessoInverso2;
end;

procedure TDUSER_AGENDA.CriaForeignKeys;
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

function TDUSER_AGENDA.PodeExcluir: Boolean;
begin
  PodeExcluir := True;
  if not Sistema.Integridade then
    exit;
end;

procedure TDUSER_AGENDA.ExclusaoCascata;
begin
end;

function TDUSER_AGENDA.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean;
begin
  Result := False;
end;

function TDUSER_AGENDA.PesquisaRelacionados(Tabela: String): Boolean;
begin
  Result := False;
  if UpperCase(Tabela) = UpperCase('USER_NOMES') then
    if PTabela(TabGlobal.DUSER_NOMES, ['Usuario'], [Usuario.Valor.Value]) then
      Result := True;

  if UpperCase(Tabela) = UpperCase('USER_AGENDA') then
    if PTabela(TabGlobal.DUSER_AGENDA, ['Sequencia'], [Sequencia.Valor.Value]) then
      Result := True;
end;

procedure TDUSER_AGENDA.CalculaCampos;
begin
end;

procedure TDUSER_AGENDA.AtribuiRelacionamentos(Atribui: Boolean = True);
begin
end;

procedure TDUSER_AGENDA.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);
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

procedure TDUSER_AGENDA.AtribuiMestre(DataSet: TDataSet);
begin
end;

procedure TDUSER_AGENDA.ProcessoDireto1(DataSet: TDataSet);
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

procedure TDUSER_AGENDA.ProcessoDireto2(DataSet: TDataSet);
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

procedure TDUSER_AGENDA.AtualizaCalculados(DataSet: TDataSet);
begin
  CalculaCampos;
  if Inclusao then
    if (Sequencia.SempreAtribui) and (Sequencia.AutoIncremento > 0) then
      AutoIncremento('Sequencia', True, Sequencia.AutoIncremento);
end;

procedure TDUSER_AGENDA.ProcessoInverso1(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
end;

procedure TDUSER_AGENDA.ProcessoInverso2(DataSet: TDataSet);
var
  EmEdicao: Boolean;
begin
  if not PodeExcluir then Abort;
  ExclusaoCascata;
end;

procedure TDUSER_AGENDA.Parametros(Tabela: TTabela);
begin
  Parametros_Padrao(Tabela);
end;

end.
