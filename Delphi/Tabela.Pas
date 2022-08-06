{
   Programa.: Tabela.PAS  -  Estrutura de Acesso
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Tabela;

interface

{$I Princ.inc}

uses
  SysUtils, StdCtrls, Forms, Dialogs, Graphics, Classes, Controls, ExtCtrls,
  Db, Publicas, dbctrls, Atributo, {$IFDEF DELPHI5}{$ELSE}Variants,{$ENDIF}
  {$IFDEF IBX}
  IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL, IBScript, IBStoredProc,
  {$ELSE}
  XSEngine, XSCommon,
  {$ENDIF}
  XLookUp;

type

  TTableType = (ttTable, ttView);

  TSQLScript = class;

  {$IFDEF IBX}
  TSQLScript = class(TIBScript)
  {$ELSE}
  TSQLScript = class(TXSQLScript)
  {$ENDIF}
  private
  public
    {$IFDEF IBX}
    DatabaseName : String;
    {$ELSE}
    DataBase     : TXSQLDatabase;
    {$ENDIF}
    NomeTrigger  : String;
    NomeTabela   : String;
    procedure Parametros; virtual;
    procedure Criar_Trigger;
    procedure Executar;
  end;

  TSQLProcedure = class;

  {$IFDEF IBX}
  TSQLProcedure = class(TIBStoredProc)
  {$ELSE}
  TSQLProcedure = class(TXSQLStoredProc)
  {$ENDIF}
  private
  public
    {$IFDEF IBX}
    DatabaseName   : String;
    {$ELSE}
    DataBase       : TXSQLDatabase;
    {$ENDIF}
    NomeProcedure: String;
    procedure Criar; dynamic; abstract;
    procedure Executar;
    procedure Parametro_Valor(Nome: String; Valor: Variant);
  end;

  TTabela = class;

  {$IFDEF IBX}
  TTabela = class(TIBQuery)
  {$ELSE}
  TTabela = class(TXSQLQuery)
  {$ENDIF}
  private

  public
    DataSource     : TDataSource;
    NomeTabela     : String;
    Titulo         : String;
    Versao         : Integer;
    Campos         : TList;
    ChavePrimaria  : TList;
    TituloPrimaria : String;
    ChPrimaria     : String;
    TituloIndice   : String;
    ChaveIndice    : String;
    TituloIndices  : TStringList;
    Indices        : TStringList;
    Crescente      : TStringList;
    IndexDefs      : TIndexDefs;
    {$IFDEF IBX}
    DataBase       : TIBDataBase;
    UpdateSql      : TIBUpdateSQL;
    DatabaseName   : String;
    {$ELSE}
    DataBase       : TXSQLDatabase;
    UpdateSql      : TXSQLUpdateSQL;
    Transaction    : String;
    SqlDialect     : Integer;
    {$ENDIF}
    UsarGenerator  : Boolean;
    TabelasExtras  : TStringList;
    FiltroExtra    : TStringList;
    FiltroFixo     : TStringList;
    Inclusao       : Boolean;
    Modificacao    : Boolean;
    SqlPrincipal   : TStringList;
    Filtro         : TStringList;
    FiltroRelac    : TStringList;
    CamposRelac    : TStringList;
    ValoresRelac   : TStringList;
    LogOldFields   : TStringList;
    ForeignKeys    : TStringList;
    {$IFDEF IBX}
    QueryExtra     : TIBQuery;
    {$ELSE}
    QueryExtra     : TXSQLQuery;
    {$ENDIF}
    Local          : Boolean;
    Open_Begin     : Boolean;
    TableType      : TTableType;
    Locate_Field   : Integer;
    Locate_String  : String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FormatFieldsList(Value: string): string;
    function InitFieldsList: String;
    procedure DeletaTabela;
    procedure CriaTabela(CriarIndices: Boolean = True);
    function AutoIncremento(Campo: String; Atribui: Boolean = True; Incremento: Integer = 1; Atualiza: Boolean = False): Integer;
    function Altera_AutoIncremento(Campo: String; Valor: Integer = 0): Boolean;
    procedure AddIndex(const Name, Fields: string; Options: TIndexOptions;
      const DescFields: string = '');
    function FindIndex(const Name: string): Boolean;
    procedure DeleteIndex(const Name: string);
    procedure DefineCampos;
    function Existe: Boolean;
    function Abrir: Boolean;
    procedure AtualizaSql(Abrir: Boolean = True);
    procedure CampoRelacionado(CampoEdit: TComponent;
      ChaveEstrangeira: string; CamposMostrar: array of string); overload; dynamic;
    procedure CampoRelacionado(CampoEdit: TComponent;
      ChaveEstrangeira: string; CamposMostrar: string); overload; dynamic;
    procedure OrdenaLookUp(Sender: TObject);
    function Inclui(Campos: TListaCampos): Boolean;
    function Cancela: Boolean;
    function Modifica: Boolean;
    function Salva: Boolean;
    procedure CriaForeignKeys; dynamic; abstract;
    function PodeExcluir: Boolean; dynamic; abstract;
    procedure ExclusaoCascata; dynamic; abstract;
    function PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''): Boolean; overload; dynamic; abstract;
    function PesquisaRelacionados(Tabela: String): Boolean; overload; dynamic; abstract;
    procedure AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True); dynamic; abstract;
    procedure AtribuiRelacionamentos(Atribui: Boolean = True); dynamic; abstract;
    procedure AtribuiMestre(DataSet: TDataSet); dynamic; abstract;
    procedure CalculaCampos; dynamic; abstract;
    procedure Parametros(Tabela: TTabela); dynamic; abstract;
    procedure Parametros_Padrao(Tabela: TTabela);
    procedure Parametro_Tipo(Nome: String; Tipo: TFieldType);
    procedure Parametro_Valor(Nome: String; Valor: Variant);
    function Exclui: Boolean;
    function LimparTabela: Boolean;
    function Indexar: Boolean;
    procedure Conexao;
    procedure ConexaoQueryExtra;
    procedure ConfiguraMascara_CS; virtual;
    function TestarConexao: Boolean;
    procedure GravarLog(Tipo: Integer; Operacao: String = ''; Comando: String = '');
    procedure Refresh;
  end;

function FormatIdentifierValue(Dialect: Integer; Value: String): String;
function DataSql(Data: TDateTime): String;
// Pesquisa
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant): Boolean; overload;
// Pesquisa, Realiza cálculos e Retorna cálculos
function PTabela(TabelaPrincipal: TTabela; CalculosArray: Array of String; ExpressaoFiltro: String; var ValoresRetornar: Variant): Boolean; overload;
// Pesquisa e Retorna os Valores dos Campos Desejados
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; CamposMostrar: array of String; var ValoresRetornar: Variant; ordenacao: String = ''): Boolean; overload;
// Pesquisa e atualiza campos
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Update: String): Boolean; overload;
// Pesquisa e realiza a exclusão do registro
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Excluir: Boolean): Boolean; overload;
function LocalizaTabela(AOwner: TComponent; NomeTabela: string): TTabela;
{$IFDEF IBX}
function FindProcedure(Database: TIBDataBase; Name: String): Boolean;
function FindTrigger(Database: TIBDataBase; Name: String): Boolean;
{$ELSE}
function FindProcedure(Database: TXSQLDatabase; Name: String): Boolean;
function FindTrigger(Database: TXSQLDatabase; Name: String): Boolean;
{$ENDIF}
procedure ConfiguraMascaraCampo(Campo: TField; Titulo, Mascara: String; Indice, Largura: Integer; Visivel: Boolean);

var
  Lst_Tabelas: TList;
  Lst_Procedures: TList;
  Lst_Triggers: TList;

implementation

uses
  FileCtrl, Rotinas, BaseD;

function QuoteIdentifier(Dialect: Integer; Value: String): String;
begin
  if Dialect = 1 then
    Value := AnsiUpperCase(Trim(Value))
  else
    Value := '"' + StringReplace (Value, '"', '""', [rfReplaceAll]) + '"';
  Result := Value;
end;

function FormatIdentifier(Versao: Integer; Value: String): String;
var
  Banco: string;
begin
  Banco := LowerCase(Trim(Copy(Sistema.BancoDados, 01, Pos(':', Sistema.BancoDados)-1)));
  if Banco = 'mysql' then
    Value := RetiraBrancos(Value)
  else
    Value := AnsiUpperCase(RetiraBrancos(Value));
  Result := Value;
end;

function FormatIdentifierValue(Dialect: Integer; Value: String): String;
begin
  Value := Trim(Value);
  if Dialect = 1 then
    Value := AnsiUpperCase(Value)
  else
  begin
    if (Value <> '') and (Value[1] = '"') then
    begin
      Delete(Value, 1, 1);
      Delete(Value, Length(Value), 1);
      Value := StringReplace (Value, '""', '"', [rfReplaceAll]);
    end
    else
      Value := AnsiUpperCase(Value);
  end;
  Result := Value;
end;

function DataSql(Data: TDateTime): String;
Var
  FormatoData, DataS, Banco: string;
begin
  Banco := LowerCase(Trim(Copy(Sistema.BancoDados, 01, Pos(':', Sistema.BancoDados)-1)));
  FormatoData     := ShortDateFormat;
  if Banco = 'mysql' then
    ShortDateFormat := 'yyyy/mm/dd'
  else
    ShortDateFormat := 'mm/dd/yyyy';
  DataS           := DateToStr(Data);
  ShortDateFormat := FormatoData;
  Result := DataS;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant): Boolean;
var
  Tabela: TTabela;
  I: Integer;
  Operador, Negacao, NomeCampo: String;
  Invalido: Boolean;
begin
  Sistema.Conexao_i := Time;
  Result := False;
  Invalido := False;
  for I:=0 to Length(ValoresArray)-1 do
    if ValoresArray[I] = Null then
    begin
      invalido := True;
      break;
    end;
  if Invalido then exit;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    {$IFDEF XSQL}
    DatabaseName := TabelaPrincipal.DatabaseName;
    {$ENDIF}
    SQL.Add('Select');
    for I:=0 to Length(CamposArray)-1 do
    begin
      if Pos(Copy(CamposArray[I],01,01),'=<>') > 0 then
      begin
        if Pos(Copy(CamposArray[I],02,01),'=<>') > 0 then
          SQL.Add(Copy(CamposArray[I],03,Length(CamposArray[I])) + ',')
        else
          SQL.Add(Copy(CamposArray[I],02,Length(CamposArray[I])) + ',');
      end
      else
        SQL.Add(CamposArray[I] + ',');
    end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-1);
    SQL.Add('From');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
    begin
      Operador := '=';
      Negacao := '';
      if Pos(Copy(CamposArray[I],01,01),'=<>') > 0 then
      begin
        Operador := Copy(CamposArray[I],01,01);
        if Pos(Copy(CamposArray[I],02,01),'=<>') > 0 then
        begin
          Operador := Operador + Copy(CamposArray[I],02,01);
          CamposArray[I] := Copy(CamposArray[I],03,Length(CamposArray[I]));
        end
        else
          CamposArray[I] := Copy(CamposArray[I],02,Length(CamposArray[I]));
        Operador := ' ' + Operador + ' ';
        if Operador = ' <> ' then
        begin
          Operador := ' = ';
          Negacao := 'Not ';
        end;
      end;
      NomeCampo := CamposArray[I];
      if Copy(NomeCampo,01,06) = 'UPPER(' then
      begin
        NomeCampo := Copy(NomeCampo,Pos('(',NomeCampo)+1,Length(NomeCampo));
        NomeCampo := Trim(Copy(NomeCampo,01,Pos(')',NomeCampo)-1));
      end;
      SQL.Add(Negacao + NomeCampo + Operador + ':' + CamposArray[I] + ' and ');
    end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    for I:=0 to Length(CamposArray)-1 do
      ParamByName(CamposArray[I]).Value := ValoresArray[I];
    Conexao;
    try
      Active := True;
      if not Eof then Result := True;
      Active := False;
    finally
      Free;
    end;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

function PTabela(TabelaPrincipal: TTabela; CalculosArray: Array of String; ExpressaoFiltro: String; var ValoresRetornar: Variant): Boolean; overload;
var
  Tabela: TTabela;
  I: Integer;
begin
  Sistema.Conexao_i := Time;
  Result := False;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    {$IFDEF XSQL}
    DatabaseName := TabelaPrincipal.DatabaseName;
    {$ENDIF}
    SQL.Add('Select');
    for I:=0 to Length(CalculosArray)-1 do
      SQL.Add(CalculosArray[I] + ',');
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-1);
    SQL.Add('From');
    SQL.Add(TabelaPrincipal.NomeTabela);
    if ExpressaoFiltro <> '' then
    begin
      SQL.Add('Where');
      SQL.Add(ExpressaoFiltro);
    end;
    Conexao;
    try
      Active := True;
      ValoresRetornar := VarArrayCreate([0, Length(CalculosArray)-1], varVariant);
      for I:=0 to Length(CalculosArray)-1 do
        ValoresRetornar[I] := Fields[I].AsVariant;
      Result := True;
      Active := False;
    finally
      Free;
    end;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; CamposMostrar: array of String; var ValoresRetornar: Variant; ordenacao: String = ''): Boolean; overload;
var
  Tabela: TTabela;
  I: Integer;
  Operador, Negacao, NomeCampo: String;
  Invalido: Boolean;
begin
  Sistema.Conexao_i := Time;
  Result := False;
  Invalido := False;
  for I:=0 to Length(ValoresArray)-1 do
    if ValoresArray[I] = Null then
    begin
      invalido := True;
      break;
    end;
  if Invalido then exit;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    {$IFDEF XSQL}
    DatabaseName := TabelaPrincipal.DatabaseName;
    {$ENDIF}
    SQL.Add('Select');
    for I:=0 to Length(CamposArray)-1 do
    begin
      if Pos(Copy(CamposArray[I],01,01),'=<>') > 0 then
      begin
        if Pos(Copy(CamposArray[I],02,01),'=<>') > 0 then
          SQL.Add(Copy(CamposArray[I],03,Length(CamposArray[I])) + ',')
        else
          SQL.Add(Copy(CamposArray[I],02,Length(CamposArray[I])) + ',');
      end
      else
        SQL.Add(CamposArray[I] + ',');
    end;
    for I:=0 to Length(CamposMostrar)-1 do
      SQL.Add(CamposMostrar[I] + ',');
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-1);
    SQL.Add('From');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
    begin
      Operador := '=';
      Negacao := '';
      if Pos(Copy(CamposArray[I],01,01),'=<>') > 0 then
      begin
        Operador := Copy(CamposArray[I],01,01);
        if Pos(Copy(CamposArray[I],02,01),'=<>') > 0 then
        begin
          Operador := Operador + Copy(CamposArray[I],02,01);
          CamposArray[I] := Copy(CamposArray[I],03,Length(CamposArray[I]));
        end
        else
          CamposArray[I] := Copy(CamposArray[I],02,Length(CamposArray[I]));
        Operador := ' ' + Operador + ' ';
        if Operador = ' <> ' then
        begin
          Operador := ' = ';
          Negacao := 'Not ';
        end;
      end;
      NomeCampo := CamposArray[I];
      if Copy(NomeCampo,01,06) = 'UPPER(' then
      begin
        NomeCampo := Copy(NomeCampo,Pos('(',NomeCampo)+1,Length(NomeCampo));
        NomeCampo := Trim(Copy(NomeCampo,01,Pos(')',NomeCampo)-1));
      end;
      SQL.Add(Negacao + NomeCampo + Operador + ':' + CamposArray[I] + ' and ');
    end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    if Trim(Ordenacao) <> '' then
      SQL.Add('order by '+Ordenacao);
    for I:=0 to Length(CamposArray)-1 do
      ParamByName(CamposArray[I]).Value := ValoresArray[I];
    Conexao;
    try
      Active := True;
      if not Eof then
      begin
        ValoresRetornar := VarArrayCreate([0, Length(CamposMostrar)-1], varVariant);
        for I:=0 to Length(CamposMostrar)-1 do
          ValoresRetornar[I] := Fields[I + Length(CamposArray)].AsVariant;
        Result := True;
      end;
      Active := False;
    finally
      Free;
    end;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Update: String): Boolean;
var
  Tabela: TTabela;
  I: Integer;
  Invalido: Boolean;
begin
  Sistema.Conexao_i := Time;
  Result := False;
  Invalido := False;
  for I:=0 to Length(ValoresArray)-1 do
    if ValoresArray[I] = Null then
    begin
      invalido := True;
      break;
    end;
  if Invalido then exit;
  if not PTabela(TabelaPrincipal, CamposArray, ValoresArray) then
    exit;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    {$IFDEF XSQL}
    DatabaseName := TabelaPrincipal.DatabaseName;
    {$ENDIF}
    SQL.Add('Update');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Set');
    SQL.Add(Update);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
      SQL.Add(CamposArray[I] + ' = ' + ':' + CamposArray[I] + ' and ');
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    for I:=0 to Length(CamposArray)-1 do
      ParamByName(CamposArray[I]).Value := ValoresArray[I];
    TabelaPrincipal.Parametros(Tabela);
    Conexao;
    try
      ExecSQL;
      {$IFDEF IBX}
      Transaction.CommitRetaining;
      {$ENDIF}
      Result := True;
    finally
      Free;
    end;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Excluir: Boolean): Boolean;
var
  Tabela: TTabela;
  I: Integer;
  Invalido: Boolean;
begin
  Sistema.Conexao_i := Time;
  Result := False;
  Invalido := False;
  for I:=0 to Length(ValoresArray)-1 do
    if ValoresArray[I] = Null then
    begin
      invalido := True;
      break;
    end;
  if Invalido then exit;
  if not Excluir then
    exit;
  if not PTabela(TabelaPrincipal, CamposArray, ValoresArray) then
    exit;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    {$IFDEF XSQL}
    DatabaseName := TabelaPrincipal.DatabaseName;
    {$ENDIF}
    SQL.Add('Delete');
    SQL.Add('From');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
      SQL.Add(CamposArray[I] + ' = ' + ':' + CamposArray[I] + ' and ');
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    NomeTabela := TabelaPrincipal.NomeTabela;
    for I:=0 to Length(CamposArray)-1 do
      ParamByName(CamposArray[I]).Value := ValoresArray[I];
    Conexao;
    try
      ExecSQL;
      {$IFDEF IBX}
      Transaction.CommitRetaining;
      {$ENDIF}
      Result := True;
    finally
      Free;
    end;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

function LocalizaTabela(AOwner: TComponent; NomeTabela: string): TTabela;
var
  I: Integer;
  Tabela: TTabela;
begin
  Result := nil;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if ((AOwner = nil) or (Tabela.Owner = AOwner)) and
       (UpperCase(NomeTabela) = UpperCase(Tabela.Name)) then
    begin
      Result := Tabela;
      Break;
    end;
  end;
end;

{$IFDEF IBX}
function FindProcedure(Database: TIBDataBase; Name: String): Boolean;
{$ELSE}
function FindProcedure(Database: TXSQLDatabase; Name: String): Boolean;
{$ENDIF}
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Lista_N: TStringList;
  I: Integer;
  Str: String;
  {$ENDIF}
begin
  if (Name = '') then Exit;
  {$IFDEF IBX}
  Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(Application);
  {$ENDIF}
  try
    {$IFDEF IBX}
    Query.Database := DataBase;
    Query.Transaction := Database.InternalTransaction;
    Query.SQL.Text :=
    'Select RDB$PROCEDURE_NAME from RDB$PROCEDURES where RDB$PROCEDURE_NAME = ' +
    '''' +
    FormatIdentifier(3, Name) + '''';
    Query.Prepare;
    Query.ExecQuery;
    Result := not Query.EOF;
    {$ELSE}
    Lista_N := TStringList.Create;
    DataBase.Session.GetStoredProcNames(Database.Databasename, Lista_N);
    for I:=0 to Lista_N.Count-1 do
    begin
      Str := UpperCase(Trim(Lista_N[I]));
      if Pos(':', Str) > 0 then
        Str := Copy(Str, Pos(':', Str)+1, Length(Str));
      if Pos('.', Str) > 0 then
        Str := Copy(Str, Pos('.', Str)+1, Length(Str));
      if Str = UpperCase(Trim(Name)) then
      begin
        Result := True;
        Break;
      end;
    end;
    Lista_N.Free;
    {$ENDIF}
  finally
    {$IFDEF IBX}
    Query.Free;
    Database.InternalTransaction.Commit;
    {$ENDIF}
  end;
end;

{$IFDEF IBX}
function FindTrigger(Database: TIBDataBase; Name: String): Boolean;
{$ELSE}
function FindTrigger(Database: TXSQLDatabase; Name: String): Boolean;
{$ENDIF}
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Lista_N: TStringList;
  I: Integer;
  Str: String;
  Script: TXSQLQuery;
  {$ENDIF}
begin
  if (Name = '') then Exit;
  {$IFDEF IBX}
  Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(Application);
  {$ENDIF}
  try
    {$IFDEF IBX}
    Query.Database := DataBase;
    Query.Transaction := Database.InternalTransaction;
    Query.SQL.Text :=
    'Select RDB$TRIGGER_NAME from RDB$TRIGGERS where RDB$TRIGGER_NAME = ' +
    '''' +
    FormatIdentifier(3, Name) + '''';
    Query.Prepare;
    Query.ExecQuery;
    Result := not Query.EOF;
    {$ELSE}
    case Database.ServerType of
      stInterbase, stFirebird:
        begin
          Script := TXSQLQuery.Create(Application);
          try
            Script.DatabaseName := Database.DatabaseName;
            Script.SQL.Text := 'Select RDB$TRIGGER_NAME from RDB$TRIGGERS where RDB$TRIGGER_NAME = ' +
                               '''' +
                               FormatIdentifier(3, Name) + '''';
            Script.Open;
            Result := not Script.EOF;
          finally
            Script.Close;
            Script.Free;
          end;
        end;
      else
        Result := True;
    end;
    {$ENDIF}
  finally
    {$IFDEF IBX}
    Query.Free;
    Database.InternalTransaction.Commit;
    {$ENDIF}
  end;
end;

procedure ConfiguraMascaraCampo(Campo: TField; Titulo, Mascara: String; Indice, Largura: Integer; Visivel: Boolean);
var

  TipoAtr: TFieldType;
  I: Integer;
begin
  TipoAtr    := Campo.DataType;
  if Mascara <> '' then
  begin
    for I := 1 to Length(Mascara) do
      case Mascara[I] of
        '9': Mascara[I] := '0';
        'Z': Mascara[I] := '#';
        'X': Mascara[I] := 'C';
        'x': Mascara[I] := 'c';
        '-': if TipoAtr in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBytes, ftAutoInc, ftLargeInt, ftBCD] then
               Mascara[I] := '#';
        '.': if TipoAtr in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBytes, ftAutoInc, ftLargeInt, ftBCD] then
               Mascara[I] := ',';
        ',': if TipoAtr in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBytes, ftAutoInc, ftLargeInt, ftBCD] then
               Mascara[I] := '.'
      end;
    if (TipoAtr = ftDateTime) or (TipoAtr = ftDate) then
      Campo.EditMask := Mascara + ';1; '
    else
      Campo.EditMask := Mascara + ';0; ';
    case TipoAtr of
      ftSmallint: begin
                    TSmallintField(Campo).DisplayFormat := Mascara;
                    TSmallintField(Campo).EditFormat := Mascara;
                    Campo.EditMask := '';
                  end;
      ftInteger:  begin
                    TIntegerField(Campo).DisplayFormat := Mascara;
                    TIntegerField(Campo).EditFormat := Mascara;
                    Campo.EditMask := '';
                  end;
      ftLargeInt: begin
                    TLargeintField(Campo).DisplayFormat := Mascara;
                    TLargeintField(Campo).EditFormat := Mascara;
                    Campo.EditMask := '';
                  end;
      ftAutoInc:  begin
                    TAutoIncField(Campo).DisplayFormat := Mascara;
                    TAutoIncField(Campo).EditFormat := Mascara;
                    Campo.EditMask := '';
                  end;
      ftWord:     begin
                    TWordField(Campo).DisplayFormat := Mascara;
                    TWordField(Campo).EditFormat := Mascara;
                    Campo.EditMask := '';
                  end;
      ftCurrency: begin
                    TCurrencyField(Campo).DisplayFormat := Mascara;
                    TCurrencyField(Campo).EditFormat := TrocaString(Mascara,',','',[rfReplaceAll]);
                    Campo.EditMask := '';
                  end;
      ftFloat:    begin
                    TFloatField(Campo).DisplayFormat := Mascara;
                    TFloatField(Campo).EditFormat := TrocaString(Mascara,',','',[rfReplaceAll]);
                    Campo.EditMask := '';
                  end;
    end;
  end;
  Campo.DisplayLabel := Titulo;
  Campo.Index   := Indice;
  Campo.Visible := Visivel;
  if Largura > 0 then
    Campo.DisplayWidth := Largura;
end;

constructor TTabela.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Campos         := TList.Create;
  ChavePrimaria  := TList.Create;
  IndexDefs      := TIndexDefs.Create(Self);
  Inclusao       := False;
  Modificacao    := False;
  DataSource     := TDataSource.Create(AOwner);
  SqlPrincipal   := TStringList.Create;
  TabelasExtras  := TStringList.Create;
  FiltroExtra    := TStringList.Create;
  FiltroFixo     := TStringList.Create;
  Filtro         := TStringList.Create;
  TituloIndices  := TStringList.Create;
  Indices        := TStringList.Create;
  Crescente      := TStringList.Create;
  CamposRelac    := TStringList.Create;
  FiltroRelac    := TStringList.Create;
  ValoresRelac   := TStringList.Create;
  LogOldFields   := TStringList.Create;
  ForeignKeys    := TStringList.Create;
  if Lst_Tabelas = nil then
    Lst_Tabelas := TList.Create;
  {$IFDEF IBX}
  QueryExtra     := TIBQuery.Create(AOwner);
  {$ELSE}
  QueryExtra     := TXSQLQuery.Create(AOwner);
  SqlDialect     := 3;
  {$ENDIF}
  Local          := True;
  UsarGenerator  := True;
  DataSource.DataSet := Self;
  TableType      := ttTable;
  Lst_Tabelas.Add(Self);
end;

destructor TTabela.Destroy;
Var
  I: Integer;
begin
  ChavePrimaria.Free;
  for I := 0 to Campos.Count - 1 do
    TObject(Campos[I]).Free;
  Campos.Free;
  UpdateSQL.Free;
  IndexDefs.Free;
  DataSource.Free;
  SqlPrincipal.Free;
  Filtro.Free;
  TituloIndices.Free;
  TabelasExtras.Free;
  FiltroExtra.Free;
  FiltroFixo.Free;
  Indices.Free;
  Crescente.Free;
  FiltroRelac.Free;
  CamposRelac.Free;
  ValoresRelac.Free;
  LogOldFields.Free;
  ForeignKeys.Free;
  QueryExtra.Free;
  Lst_Tabelas.Delete(Lst_Tabelas.IndexOf(Self)); // Essa instrução veio da Abertura.Pas
  inherited Destroy;
end;

function TTabela.FormatFieldsList(Value: string): string;
var
  FieldName: string;
  I: Integer;
begin
  Value := TrocaString(Value,NomeTabela+'.','',[rfReplaceAll, rfIgnoreCase]);
  for I:=0 to TabelasExtras.Count-1 do
    Value := TrocaString(Value,TabelasExtras[I]+'.','',[rfReplaceAll, rfIgnoreCase]);
  if Versao = 5 then
  begin
    Value := FormatIdentifier(Versao, Value);
    Result := TrocaString(Value, ';', ', ', [rfReplaceAll]);
  end
  else
  begin
    I := 1;
    Result := '';
    while I <= Length(Value) do
    begin
      FieldName := ExtractFieldName(Value, I);
      if Result = '' then
        Result := FormatIdentifier(Versao, FieldName)
      else
        Result := Result + ', ' + FormatIdentifier(Versao, FieldName);
    end;
  end;
end;

function TTabela.Existe: Boolean;
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Lista_N: TStringList;
  I: Integer;
  Str: String;
  {$ENDIF}
begin
  if TableType <> ttTable then
  begin
    Result := True;
    exit;
  end;
  Result := Active;
  if Result or (NomeTabela = '') then Exit;
  {$IFDEF IBX}
  Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(self);
  {$ENDIF}
  try
    {$IFDEF IBX}
    Query.Database := DataBase;
    Query.Transaction := Database.InternalTransaction;
    Query.SQL.Text :=
    'Select USER from RDB$RELATIONS where RDB$RELATION_NAME = ' +
    '''' +
    FormatIdentifier(Versao, NomeTabela) + '''';
    Query.Prepare;
    Query.ExecQuery;
    Result := not Query.EOF;
    {$ELSE}
    Lista_N := TStringList.Create;
    if BaseDados.ListaNomeTabelas_DB.IndexOf(DatabaseName + ':') = -1 then
    begin
      DataBase.GetTableNames('', False, Lista_N);
      BaseDados.ListaNomeTabelas_DB.Add(DatabaseName + ':');
      for I:=0 to Lista_N.Count-1 do
        BaseDados.ListaNomeTabelas_DB.Add(DatabaseName + ':' + Lista_N[I]);
    end
    else
      Lista_N.AddStrings(BaseDados.ListaNomeTabelas_DB);
    for I:=0 to Lista_N.Count-1 do
    begin
      Str := UpperCase(Trim(Lista_N[I]));
      if Pos(':', Str) > 0 then
        Str := Copy(Str, Pos(':', Str)+1, Length(Str));
      if Pos('.', Str) > 0 then
        Str := Copy(Str, Pos('.', Str)+1, Length(Str));
      if Str = UpperCase(Trim(NomeTabela)) then
      begin
        Result := True;
        Break;
      end;
    end;
    Lista_N.Free;
    {$ENDIF}
  finally
    {$IFDEF IBX}
    Query.Free;
    Database.InternalTransaction.Commit;
    {$ENDIF}
  end;
end;

function TTabela.AutoIncremento(Campo: String; Atribui: Boolean = True; Incremento: Integer = 1; Atualiza: Boolean = False): Integer;
const
  SGENSQL = 'SELECT GEN_ID(%s, %d) FROM RDB$DATABASE';  {do not localize}
var
  {$IFDEF IBX}
  sqlGen: TIBSQL;
  {$ELSE}
  sqlGen: TXSQLQuery;
  {$ENDIF}
  NomeG: String;
  Soma: Integer;
begin
  Sistema.Conexao_i := Time;
  Soma := 0;
  {$IFDEF IBX}
  sqlGen := TIBSQL.Create(Database);
  sqlGen.Transaction := Transaction;
  {$ELSE}
  sqlGen := TXSQLQuery.Create(Database);
  sqlGen.DatabaseName := DatabaseName;
  {$ENDIF}
  try
    if (UsarGenerator)
       {$IFDEF XSQL}and (Database.ServerType in [stInterbase, stFirebird]) {$ENDIF} then
    begin
      NomeG := Copy(UpperCase(NomeTabela + '_' + Campo + '_GEN'), 01, 30);
      sqlGen.SQL.Text :=
        'Select RDB$GENERATOR_NAME from RDB$GENERATORS where RDB$GENERATOR_NAME = ' +
        '''' +
      FormatIdentifier(Versao, NomeG) + '''';
      sqlGen.Prepare;
      {$IFDEF IBX}
      sqlGen.ExecQuery;
      {$ELSE}
      sqlGen.Open;
      {$ENDIF}
      if (sqlGen.EOF) or (Atualiza) then
      begin
        if (sqlGen.EOF) then
        begin
          sqlGen.Close;
          sqlGen.SQL.Text := 'CREATE GENERATOR "'+NomeG+'"';
          sqlGen.Prepare;
          {$IFDEF IBX}
          sqlGen.ExecQuery;
          {$ELSE}
          sqlGen.ExecSQL;
          {$ENDIF}
        end;
        sqlGen.Close;
        sqlGen.SQL.Text := 'Select MAX('+Campo+') From '+NomeTabela;
        sqlGen.Prepare;
        {$IFDEF IBX}
        sqlGen.ExecQuery;
        {$ELSE}
        sqlGen.Open;
        {$ENDIF}
        sqlGen.SQL.Text := 'Set Generator '+NomeG+' to ' + IntToStr(sqlGen.Fields[0].AsInteger);
        sqlGen.Close;
        sqlGen.Prepare;
        {$IFDEF IBX}
        sqlGen.ExecQuery;
        {$ELSE}
        sqlGen.ExecSQL;
        {$ENDIF}
      end;
      sqlGen.Close;

      {$IFDEF IBX}
      sqlGen.SQL.Text := Format(SGENSQL, [QuoteIdentifier(Database.SQLDialect, NomeG), Incremento]);
      sqlGen.ExecQuery;
      {$ELSE}
      sqlGen.SQL.Text := Format(SGENSQL, [QuoteIdentifier(SQLDialect, NomeG), Incremento]);
      sqlGen.Open;
      {$ENDIF}
    end
    else
    begin
      sqlGen.SQL.Text := 'Select MAX('+Campo+') From '+NomeTabela;
      sqlGen.Prepare;
      {$IFDEF IBX}
      sqlGen.ExecQuery;
      {$ELSE}
      sqlGen.Open;
      {$ENDIF}
      Soma := Incremento;
    end;
    if Atribui then
    begin
      {$IFDEF IBX}
      if FieldByName(Campo).ClassType <> TLargeIntField then
        FieldByName(Campo).AsInteger := sqlGen.Current.Vars[0].AsInt64 + Soma
      else
        TLargeIntField(FieldByName(Campo)).AsLargeInt := sqlGen.Current.Vars[0].AsInt64 + Soma;
      {$ELSE}
      if FieldByName(Campo).ClassType <> TLargeIntField then
        FieldByName(Campo).AsInteger := sqlGen.Fields[0].AsInteger + Soma
      else
        TLargeIntField(FieldByName(Campo)).AsLargeInt := sqlGen.Fields[0].AsInteger + Soma;
      {$ENDIF}
    end;
    {$IFDEF IBX}
    AutoIncremento := sqlGen.Current.Vars[0].AsInt64 + Soma;
    {$ELSE}
    AutoIncremento := sqlGen.Fields[0].AsInteger + Soma;
    {$ENDIF}
    sqlGen.Close;
  finally
    sqlGen.Free;
  end;
  Sistema.Conexao_f := Time;
  Atualiza_Status;
end;

function TTabela.Altera_AutoIncremento(Campo: String; Valor: Integer = 0): Boolean;
var
  {$IFDEF IBX}
  sqlGen: TIBSQL;
  {$ELSE}
  sqlGen: TXSQLQuery;
  {$ENDIF}
  NomeG: String;
begin
  {$IFDEF XSQL}
  if sqlGen.Database.ServerType in [stInterbase, stFirebird] then
  {$ENDIF}
  begin
    {$IFDEF IBX}
    sqlGen := TIBSQL.Create(Database);
    sqlGen.Transaction := Transaction;
    {$ELSE}
    sqlGen := TXSQLQuery.Create(Database);
    sqlGen.DatabaseName := DatabaseName;
    {$ENDIF}
    try
      Sistema.Conexao_i := Time;
      NomeG := UpperCase(NomeTabela + '_' + Campo + '_GEN');
      sqlGen.SQL.Text := 'Set Generator ' + NomeG + ' to '+IntToStr(Valor);
      sqlGen.Prepare;
      {$IFDEF IBX}
      sqlGen.ExecQuery;
      {$ELSE}
      sqlGen.ExecSQL;
      {$ENDIF}
      Altera_AutoIncremento := True;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    finally
      sqlGen.Free;
    end;
  end
  {$IFDEF XSQL}
  else
    Altera_AutoIncremento := True;
  {$ENDIF}
end;

procedure TTabela.DeletaTabela;
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Query: TXSQLQuery;
  {$ENDIF}
begin
  if TableType <> ttTable then
    exit;
  CheckInactive;
  {$IFDEF IBX}
  Query := TIBSQL.Create(Self);
  {$ELSE}
  Query := TXSQLQuery.Create(Self);
  {$ENDIF}
  try
    {$IFDEF IBX}
    Query.Database := Database;
    {$ELSE}
    Query.DatabaseName := DatabaseName;
    {$ENDIF}
    Query.SQL.Add('drop table ' +
      FormatIdentifier(Versao, NomeTabela));
    Query.Prepare;
    {$IFDEF IBX}
    Query.ExecQuery;
    {$ELSE}
    Query.ExecSQL;
    {$ENDIF}
  finally
    Query.Free;
  end;
end;

function TTabela.InitFieldsList: String;
var
  I: Integer;
  FieldList: string;

  function Campo_Def(S: String): TAtributo;
  var
    Y: Integer;
  begin
    for Y:=0 to Campos.Count-1 do
      if LowerCase(TAtributo(Campos[Y]).Nome) = LowerCase(S) then
      begin
        Campo_Def := TAtributo(Campos[Y]);
        break;
      end;
  end;

begin
  for I := 0 to FieldDefs.Count - 1 do begin
    if (I > 0) then
      FieldList := FieldList + ', ';
    if Trim(Campo_Def(FieldDefs[I].Name).TipoSQL) <> '' then
    begin
      FieldList := FieldList +
        FormatIdentifier(Versao, FieldDefs[I].Name) +
        ' ' + Campo_Def(FieldDefs[I].Name).TipoSQL;
      if faRequired in FieldDefs[I].Attributes then
        FieldList := FieldList + ' NOT NULL'
      {$IFDEF XSQL}
      else
        if (Database.ServerType in [stSQLServer]) then
          FieldList := FieldList + ' NULL';
      {$ENDIF}
    end
    else
      with FieldDefs[I] do
      begin
        case DataType of
          ftString:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' VARCHAR(' + IntToStr(Size) + ')';
          ftFixedChar:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' CHAR(' + IntToStr(Size) + ')';
          ftBoolean, ftSmallint, ftWord:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' SMALLINT';
          ftInteger {$IFDEF XSQL}, ftAutoInc{$ENDIF}:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' INTEGER';
          ftFloat, ftCurrency:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' DOUBLE PRECISION';
          ftBCD:
          begin
            if Versao = 5 then
            begin
              {$IFDEF IBX}
              if Precision > 9 then
                IBError(ibxeFieldUnsupportedType,[nil]);
              {$ENDIF}
              if Precision <= 4 then
                Precision := 9;
            end;
            if Precision <= 4 then
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' Numeric(18, 4)'
            else
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' Numeric(' + IntToStr(Precision) + ', 4)';
          end;
          ftTime:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' TIME';
          ftDate, ftDateTime:
            if (Versao = 5) then
              FieldList := FieldList +
              FormatIdentifier(Versao, Name) + ' DATE'
            else
            begin
              {$IFDEF IBX}
                FieldList := FieldList +
                FormatIdentifier(Versao, Name) + ' TIMESTAMP';
              {$ELSE}
                if (Database.ServerType in [stInterbase, stFirebird]) then
                  FieldList := FieldList +
                  FormatIdentifier(Versao, Name) + ' TIMESTAMP'
                else
                  FieldList := FieldList +
                  FormatIdentifier(Versao, Name) + ' DATETIME';
              {$ENDIF}
            end;
          ftLargeInt:
            if (Versao = 5) then
             {$IFDEF IBX}
             IBError(ibxeFieldUnsupportedType,[nil])
            {$ENDIF}
            else
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' Numeric(18, 0)';
          ftBlob, ftMemo:
            {$IFDEF IBX}
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' BLOB SUB_TYPE 1';
            {$ELSE}
            if (Database.ServerType in [stSQLServer]) then
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' TEXT'
            else
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' BLOB';
            {$ENDIF}
          ftBytes, ftVarBytes, ftGraphic..ftTypedBinary:
            {$IFDEF IBX}
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' BLOB SUB_TYPE 0';
            {$ELSE}
            if (Database.ServerType in [stSQLServer]) and
               (DataType = ftGraphic) then
            else
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' IMAGE'
            else
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' BLOB';
            {$ENDIF}
          {$IFDEF IBX}
          ftUnknown, ftADT, ftArray, ftReference, ftDataSet,
          ftCursor, ftWideString, ftAutoInc:
            IBError(ibxeFieldUnsupportedType,[nil]);
          else
            IBError(ibxeFieldUnsupportedType,[nil]);
          {$ENDIF}
        end;
        if faRequired in Attributes then
          FieldList := FieldList + ' NOT NULL'
        {$IFDEF XSQL}
        else
          if (Database.ServerType in [stSQLServer]) then
            FieldList := FieldList + ' NULL';
        {$ENDIF}
        end;
    FieldList := FieldList + ' ' + Trim(Campo_Def(FieldDefs[I].Name).SQL_Extra);
  end;
  InitFieldsList := FieldList;
end;

procedure TTabela.CriaTabela(CriarIndices: Boolean = True);
var
  FieldList: string;

  procedure DefineIndicePrimario;
  begin
    IndexDefs.Clear;
    IndexDefs.Add('IdxPrimaria', UpperCase(ChPrimaria), [ixPrimary, ixUnique]);
  end;

  procedure InternalCreateTable;
  var
    I: Integer;
    {$IFDEF IBX}
    Query: TIBSql;
    {$ELSE}
    Query: TXSQLQuery;
    {$ENDIF}
  begin
    {$IFDEF IBX}
    if (FieldList = '') then
      IBError(ibxeFieldUnsupportedType,[nil]);
    Query := TIBSql.Create(self);
    {$ELSE}
    Query := TXSQLQuery.Create(self);
    {$ENDIF}
    try
      {$IFDEF IBX}
      Query.Database := Database;
      Query.transaction := Transaction;
      if not Transaction.Active then
        Transaction.Active := True;
      {$ELSE}
      Query.DatabaseName := DatabaseName;
      {$ENDIF}
      Query.SQL.Text := 'Create Table ' +
        FormatIdentifier(Versao, NomeTabela) +
        ' (' + FieldList;
      for I := 0 to IndexDefs.Count - 1 do
      with IndexDefs[I] do
        if (ixPrimary in Options) and (Trim(FormatFieldsList(Fields)) <> '') then
        begin
          Query.SQL.Text := Query.SQL.Text + ', CONSTRAINT ' +
            FormatIdentifier(Versao, 'I' + NomeTabela) +
            ' Primary Key (' +
            FormatFieldsList(Fields) +
            ')';
        end;
      Query.SQL.Text := Query.SQL.Text + ')';
      Query.Prepare;
      {$IFDEF IBX}
      Query.ExecQuery;
      Query.Transaction.Commit;
      {$ELSE}
      Query.ExecSQL;
      {$ENDIF}
    finally
      Query.Free;
    end;
  end;

begin
  if TableType <> ttTable then
    exit;
  CheckInactive;
  DefineCampos;
  DefineIndicePrimario;
  FieldList := InitFieldsList;
  if Existe then
    DeletaTabela;
  {$IFDEF XSQL}
  DataBase.StartTransaction;
  {$ENDIF}
  InternalCreateTable;
  {$IFDEF XSQL}
  DataBase.Commit;
  {$ENDIF}
  if CriarIndices then
    Indexar;
end;

function TTabela.Indexar: Boolean;
Var
  I: Integer;
  Status_Tb: Boolean;
begin
  if TableType <> ttTable then
  begin
    Result := True;
    exit;
  end;
  Result    := True;
  Status_Tb := Active;
  try
    if not Active then
      AtualizaSql;
    for I:=0 to Indices.Count-1 do  // Deleta todos os Índices
      if FindIndex('I'+NomeTabela+IntToStr(I)) then
        DeleteIndex('I'+NomeTabela+IntToStr(I));
    Active := False;
    IndexDefs.Clear;
    if Trim(ChPrimaria) <> '' then
      IndexDefs.Add('IdxPrimaria', UpperCase(ChPrimaria), [ixPrimary, ixUnique]);
    for I:=0 to Indices.Count-1 do  // Cria todos os Índices
      if Crescente[I] = 'S' then
      begin
        AddIndex('I'+NomeTabela+IntToStr(I),Indices[I],[ixCaseInsensitive],TituloIndices[I]);
        IndexDefs.Add('I'+NomeTabela+IntToStr(I), Indices[I], [ixCaseInsensitive]);
      end
      else
      begin
        AddIndex('I'+NomeTabela+IntToStr(I),Indices[I],[ixDescending, ixCaseInsensitive],TituloIndices[I]);
        IndexDefs.Add('I'+NomeTabela+IntToStr(I), Indices[I], [ixDescending, ixCaseInsensitive]);
      end;
    Active := Status_Tb;
  except
    Result := False;
    Active := Status_Tb;
  end;
end;

procedure TTabela.AddIndex(const Name, Fields: string; Options: TIndexOptions;
  const DescFields: string);
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Query: TXSQLQuery;
  {$ENDIF}
  FieldList: string;
begin
  if TableType <> ttTable then
    exit;
  FieldDefs.Update;
  if Active then
  begin
    CheckBrowseMode;
    CursorPosChanged;
  end;
  {$IFDEF IBX}
  Query := TIBSql.Create(self);
  {$ELSE}
  Query := TXSQLQuery.Create(self);
  {$ENDIF}
  try
    {$IFDEF IBX}
    Query.Database := DataBase;
    Query.Transaction := Transaction;
    {$ELSE}
    Query.DatabaseName := DatabaseName;
    {$ENDIF}
    FieldList := FormatFieldsList(Fields);
    if (ixPrimary in Options) then
    begin
     Query.SQL.Text := 'Alter Table ' + {do not localize}
       FormatIdentifier(Versao, NomeTabela) +
       ' Add CONSTRAINT ' +   {do not localize}
       FormatIdentifier(Versao, Name)
       + ' Primary Key (' + {do not localize}
       FormatFieldsList(Fields) +
       ')';   {do not localize}
    end
    else
    if ([ixUnique, ixDescending] * Options = [ixUnique, ixDescending]) then
      Query.SQL.Text := 'Create unique Descending Index ' + {do not localize}
                        FormatIdentifier(Versao, Name) +
                        ' on ' + {do not localize}
                        FormatIdentifier(Versao, NomeTabela) +
                        ' (' + FieldList + ')' {do not localize}
    else
      if (ixUnique in Options) then
        Query.SQL.Text := 'Create unique Index ' + {do not localize}
                          FormatIdentifier(Versao, Name) +
                          ' on ' + {do not localize}
                          FormatIdentifier(Versao, NomeTabela) +
                          ' (' + FieldList + ')' {do not localize}
      else
        if (ixDescending in Options) then
          Query.SQL.Text := 'Create Descending Index ' + {do not localize}
                            FormatIdentifier(Versao, Name) +
                            ' on ' + {do not localize}
                            FormatIdentifier(Versao, NomeTabela) +
                            ' (' + FieldList + ')'  {do not localize}
        else
          Query.SQL.Text := 'Create Index ' + {do not localize}
                            FormatIdentifier(Versao, Name) +
                            ' on ' + {do not localize}
                            FormatIdentifier(Versao, NomeTabela) +
                            ' (' + FieldList + ')'; {do not localize}
    Query.Prepare;
    {$IFDEF IBX}
    Query.ExecQuery;
    {$ELSE}
    Query.ExecSQL;
    {$ENDIF}
    IndexDefs.Updated := False;
  finally
    Query.free
  end;
end;

function TTabela.FindIndex(const Name: string): Boolean;
var
  Str: String;
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ENDIF}
begin
  if TableType <> ttTable then
  begin
    Result := True;
    exit;
  end;
  {$IFDEF IBX}
  Query := TIBSql.Create(self);
  {$ENDIF}
  Result := False;
  try
    {$IFDEF IBX}
    Query.Database := DataBase;
    Query.Transaction := Transaction;
    Query.SQL.Text := 'SELECT RDB$INDEX_NAME FROM RDB$INDEX_SEGMENTS ' +
      'where RDB$INDEX_NAME = ' +
      '''' +
    FormatIdentifierValue(Database.SQLDialect,
      FormatIdentifier(Versao, Name)) +
    ''' ' ;
    Query.Prepare;
    Query.ExecQuery;
    if not Query.EOF then
      Result := True;
    {$ELSE}
    Str := Name;
    with DataBase.GetSchemaInfo(stIndexes, NomeTabela) do
      if Locate('INDEX_NAME', Str, [loCaseInsensitive]) then
        Result := True
      else
        Result := False;
    {$ENDIF}
  finally
    {$IFDEF IBX}
    Query.Free;
    {$ENDIF}
  end;
end;

procedure TTabela.DeleteIndex(const Name: string);
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Query: TXSQLQuery;
  {$ENDIF}

  procedure DeleteByIndex;
  begin
    {$IFDEF IBX}
    Query := TIBSql.Create(self);
    {$ELSE}
    Query := TXSQLQuery.Create(self);
    {$ENDIF}
    try
      {$IFDEF IBX}
      Query.Database    := DataBase;
      Query.Transaction := Transaction;
      Query.SQL.Text    := 'Drop index ' +  {do not localize}
                           FormatIdentifier(Versao, Name);
      {$ELSE}
      Query.DatabaseName := DatabaseName;
      if (Database.ServerType in [stMySql]) then
        Query.SQL.Text := 'Drop index ' +  {do not localize}
                           FormatIdentifier(Versao, Name) + ' On ' + NomeTabela
      else if (Database.ServerType in [stSQLServer]) then
        Query.SQL.Text := 'Drop index ' +  {do not localize}
                           NomeTabela + '.' + FormatIdentifier(Versao, Name)
      else
        Query.SQL.Text := 'Drop index ' +  {do not localize}
                           FormatIdentifier(Versao, Name);
      {$ENDIF}
      Query.Prepare;
      {$IFDEF IBX}
      Query.ExecQuery;
      {$ELSE}
      Query.ExecSQL;
      {$ENDIF}
      IndexDefs.Updated := False;
    finally
      Query.Free;
    end;
  end;

  function DeleteByConstraint: Boolean;
  begin
    Result := False;
    {$IFDEF IBX}
    Query := TIBSql.Create(self);
    {$ELSE}
    Query := TXSQLQuery.Create(self);
    {$ENDIF}
    try
      {$IFDEF IBX}
      Query.Database := DataBase;
      Query.Transaction := Transaction;
      {$ELSE}
      Query.DatabaseName := DatabaseName;
      {$ENDIF}
      Query.SQL.Text := 'Select ''foo'' from RDB$RELATION_CONSTRAINTS ' +  {do not localize}
        'where RDB$RELATION_NAME = ' +   {do not localize}
        '''' +  {do not localize}
        {$IFDEF IBX}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, Name)) +
        {$ELSE}
        FormatIdentifierValue(Versao - 4,
          FormatIdentifier(Versao, Name)) +
        {$ENDIF}
        ''' ' +      {do not localize}
        ' AND RDB$CONSTRAINT_NAME = ' +  {do not localize}
        '''' +     {do not localize}
        {$IFDEF IBX}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, Name)) +
        {$ELSE}
        FormatIdentifierValue(Versao - 4,
          FormatIdentifier(Versao, Name)) +
        {$ENDIF}
        ''' ' +    {do not localize}
        'AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''';   {do not localize}
      Query.Prepare;
      {$IFDEF IBX}
      Query.ExecQuery;
      {$ELSE}
      Query.ExecSQL;
      {$ENDIF}
      if not Query.EOF then
      begin
        Query.Close;
        Query.SQL.Text := 'Alter Table ' +  {do not localize}
          FormatIdentifier(Versao, NomeTabela) +
          ' Drop Constraint ' +   {do not localize}
          FormatIdentifier(Versao, Name);
        Query.Prepare;
        {$IFDEF IBX}
        Query.ExecQuery;
        {$ELSE}
        Query.ExecSQL;
        {$ENDIF}
        IndexDefs.Updated := False;
        Result := True;
      end;
    finally
      Query.Free;
    end;
  end;

  procedure DeleteByKey;
  begin
    {$IFDEF IBX}
    Query := TIBSql.Create(self);
    {$ELSE}
    Query := TXSQLQuery.Create(self);
    {$ENDIF}
    try
      {$IFDEF IBX}
      Query.Database := DataBase;
      Query.Transaction := Transaction;
      {$ELSE}
      Query.DatabaseName := DatabaseName;
      {$ENDIF}
      Query.SQL.Text := 'Select RDB$CONSTRAINT_NAME from RDB$RELATION_CONSTRAINTS ' +   {do not localize}
        'where RDB$RELATION_NAME = ' +  {do not localize}
        '''' +  {do not localize}
        {$IFDEF IBX}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, Name)) +
        {$ELSE}
        FormatIdentifierValue(Versao - 4,
          FormatIdentifier(Versao, Name)) +
        {$ENDIF}
        ''' ' +  {do not localize}
        'AND RDB$INDEX_NAME = ' +  {do not localize}
        '''' +  {do not localize}
        {$IFDEF IBX}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, Name)) +
        {$ELSE}
        FormatIdentifierValue(Versao - 4,
          FormatIdentifier(Versao, Name)) +
        {$ENDIF}
        ''' ' +    {do not localize}
        'AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'''; {do not localize}
      Query.Prepare;
      {$IFDEF IBX}
      Query.ExecQuery;
      {$ELSE}
      Query.ExecSQL;
      {$ENDIF}
      if not Query.EOF then
      begin
        Query.Close;
        Query.SQL.Text := 'Alter Table ' +  {do not localize}
          FormatIdentifier(Versao, NomeTabela) +
          ' Drop Constraint ' +  {do not localize}
          {$IFDEF IBX}
          FormatIdentifier(Versao, Query.Current.ByName('RDB$CONSTRAINT_NAME').AsString); {do not localize}
          {$ELSE}
          FormatIdentifier(Versao, Query.FieldByName('RDB$CONSTRAINT_NAME').AsString); {do not localize}
          {$ENDIF}
        Query.Prepare;
        {$IFDEF IBX}
        Query.ExecQuery;
        {$ELSE}
        Query.ExecSQL;
        {$ENDIF}
        IndexDefs.Updated := False;
      end;
    finally
      Query.Free;
    end;
  end;

begin
  if TableType <> ttTable then
    exit;
  if Active then
    CheckBrowseMode;
  IndexDefs.Update;
  {$IFDEF IBX}
  if (Pos('RDB$PRIMARY', Name) <> 0 ) then {do not localize} {mbcs ok}
    DeleteByKey
  else if not DeleteByConstraint then
    DeleteByIndex;
  {$ELSE}
  DeleteByIndex;
  {$ENDIF}
end;

procedure TTabela.DefineCampos;
var
  I: Integer;
  Campo: TAtributo;
begin
  FieldDefs.Clear;
  for I := 0 to Campos.Count - 1 do
  begin
    Campo := TAtributo(Campos[I]);
    if (not Campo.Calculado) and (not Campo.Extra) then
      if Campo.Tipo in [tpInteiro, tpFracionario] then
        FieldDefs.Add(UpperCase(Campo.Nome), Campo.TipoCampo,
          0, Campo.Chave)
      else
        FieldDefs.Add( UpperCase(Campo.Nome), Campo.TipoCampo,
          Campo.TamanhoDado, Campo.Chave);
  end;
end;

function TTabela.Abrir: Boolean;
begin
  Result := TestarConexao;
  if not Result then
    exit;
  try
    if not Active then
      AtualizaSql;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      MessageDlg('Erro na abertura da tabela: ' + Titulo + ^M + ^M + Erro.Message ,mtError,[mbOk],0);
      Result := False;
    end;
  end;
end;

procedure TTabela.AtualizaSql(Abrir: Boolean = True);
begin
  if not TestarConexao then
    exit;
  Screen.Cursor := crHourGlass;
  try
    Sistema.Conexao_i := Time;
    DisableControls;
    Active   := False;
    if SqlPrincipal.Count > 0 then
    begin
      Sql.Clear;
      Sql.AddStrings(SqlPrincipal);
      if Trim(FiltroExtra.Text) <> '' then
        Sql.AddStrings(FiltroExtra);
      if Trim(Filtro.Text) <> '' then
      begin
        Sql.Add('Where ');
        Sql.AddStrings(Filtro);
      end;
      if Trim(FiltroRelac.Text) <> '' then
      begin
        if Trim(Filtro.Text) = '' then
          Sql.Add('Where ')
        else
          Sql.Add('AND ');
        Sql.AddStrings(FiltroRelac);
      end;
      if Trim(FiltroFixo.Text) <> '' then
      begin
        if (Trim(Filtro.Text) = '') and (Trim(FiltroRelac.Text) = '') then
          Sql.Add('Where ')
        else
          Sql.Add('AND ');
        Sql.AddStrings(FiltroFixo);
      end;
      if Trim(ChaveIndice) <> '' then
        Sql.Add('Order By '+ChaveIndice);
    end;
    Prepare;
    if (SqlPrincipal.Count > 0) and
       (not Local) then
      Parametros(Self);
  finally
    if Abrir then
    begin
      Active := True;
      First;
    end;
    if TableType = ttView then
      ConfiguraMascara_CS;
    EnableControls;
    Screen.Cursor := crDefault;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  end;
end;

procedure TTabela.CampoRelacionado(CampoEdit: TComponent;
  ChaveEstrangeira: string; CamposMostrar: array of string);
begin
  if CampoEdit is TXDBLookUp then
  begin
    TXDBLookUp(CampoEdit).ListSource       := DataSource;
    TXDBLookUp(CampoEdit).KeyField         := ChaveEstrangeira;
    TXDBLookUp(CampoEdit).ListField        := ArrayToString(CamposMostrar, ';');
    TXDBLookUp(CampoEdit).OnClickOrdenacao := OrdenaLookUp;
  end;
end;

procedure TTabela.CampoRelacionado(CampoEdit: TComponent;
  ChaveEstrangeira: string; CamposMostrar: string);
begin
  if CampoEdit is TXDBLookUp then
  begin
    TXDBLookUp(CampoEdit).ListSource       := DataSource;
    TXDBLookUp(CampoEdit).KeyField         := ChaveEstrangeira;
    TXDBLookUp(CampoEdit).ListField        := CamposMostrar;
    TXDBLookUp(CampoEdit).OnClickOrdenacao := OrdenaLookUp;
  end;
end;

procedure TTabela.OrdenaLookUp(Sender: TObject);
Var
  CamposLook: TStringList;
  I: Integer;
begin
  CamposLook := TStringList.Create;
  StringToArray(TXDBLookUp(Sender).ListField, ';', CamposLook);
  if CamposLook[0] <> ChaveIndice then
  begin
    ChaveIndice := CamposLook[0];
    AtualizaSql;
  end;
  CamposLook.Free;
end;

function TTabela.Inclui(Campos: TListaCampos): Boolean;
var
  I: Integer;
  Atributo: TAtributo;
begin
  Result := TestarConexao;
  if not Result then
    exit;
  if TableType <> ttTable then
    exit;
  try
    Sistema.Conexao_i := Time;
    Append; //Insert;
    Inclusao    := True;
    Modificacao := False;
    Result      := True;
    if Campos <> nil then
      for I := 0 to Campos.Count - 1 do
      begin
        Atributo := TCampoEdicao(Campos[I]).Campo;
        if (Atributo.Valor.DataSet = Self) and (not Atributo.Calculado) and (not Atributo.Extra) then
          Atributo.AtribuiValorPadrao;
      end;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      MessageDlg('Inclusão na Tabela: '+Titulo+ ^M+^M + Erro.Message, mtError, [mbOk], 0);
      Result := False;
    end;
  end;
end;

function TTabela.Cancela: Boolean;
begin
  Result := TestarConexao;
  if not Result then
    exit;
  if TableType <> ttTable then
    exit;
  try
    Sistema.Conexao_i := Time;
    if Inclusao or Modificacao or (State in [dsEdit, dsInsert]) then
      Cancel;
    Inclusao    := False;
    Modificacao := False;
    Result      := True;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      MessageDlg('Cancelamento na Tabela: '+Titulo+ ^M+^M + Erro.Message, mtError, [mbOk], 0);
      Result := False;
    end;
  end;
end;

function TTabela.Modifica: Boolean;
var
  I: Integer;
begin
  Result := TestarConexao;
  if not Result then
    exit;
  if TableType <> ttTable then
    exit;
  try
    Sistema.Conexao_i := Time;
    Refresh;
    LogOldFields.Clear;
    for I:=0 to Campos.Count-1 do
      LogOldFields.Add(TAtributo(Campos[I]).Titulo + ' = ' +TAtributo(Campos[I]).Valor.AsString);
    Edit;
    Inclusao    := False;
    Modificacao := True;
    Result      := True;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      MessageDlg('Edição na Tabela: '+Titulo+ ^M+^M + Erro.Message, mtError, [mbOk], 0);
      Result := False;
    end;
  end;
end;

function TTabela.Salva: Boolean;
var
  xUpdateStatus: TUpdateStatus;
begin
  Result := TestarConexao;
  if not Result then
    exit;
  if TableType <> ttTable then
    exit;
  try
    Sistema.Conexao_i := Time;
    CalculaCampos;
    if UpdateStatus in [usModified, usInserted] then
    begin
      xUpdateStatus := UpdateStatus;
      Post;
      {$IFDEF IBX}
      Transaction.CommitRetaining;
      {$ENDIF}
      GravarLog(IIF(xUpdateStatus = usInserted, 1, 2));
    end;
    Inclusao    := False;
    Modificacao := False;
    Result      := True;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      MessageDlg('Gravação na Tabela: '+Titulo+ ^M+^M + Erro.Message, mtError, [mbOk], 0);
      Result := False;
    end;
  end;
end;

procedure TTabela.Parametros_Padrao(Tabela: TTabela);
var
  I, Y: Integer;
  Nome_Par: String;
begin
  with Tabela do
  begin
    Parametro_Tipo('Sistema_Titulo', ftString);
    Parametro_Valor('Sistema_Titulo', Sistema.Titulo);

    Parametro_Tipo('Sistema_Versao', ftString);
    Parametro_Valor('Sistema_Versao', Sistema.Versao);

    Parametro_Tipo('Sistema_Analista', ftString);
    Parametro_Valor('Sistema_Analista', Sistema.Analista);

    Parametro_Tipo('Sistema_Programador', ftString);
    Parametro_Valor('Sistema_Programador', Sistema.Programador);

    Parametro_Tipo('Sistema_Projetista', ftString);
    Parametro_Valor('Sistema_Projetista', Sistema.Projetista);

    Parametro_Tipo('Sistema_EstiloData', ftString);
    Parametro_Valor('Sistema_EstiloData', Sistema.EstiloData);

    Parametro_Tipo('Sistema_SenhaInicial', ftString);
    Parametro_Valor('Sistema_SenhaInicial', Sistema.SenhaInicial);

    Parametro_Tipo('Sistema_Pasta', ftString);
    Parametro_Valor('Sistema_Pasta', Sistema.Pasta);

    Parametro_Tipo('Sistema_Usuario', ftString);
    Parametro_Valor('Sistema_Usuario', Sistema.Usuario);

    Parametro_Tipo('Sistema_Senha', ftString);
    Parametro_Valor('Sistema_Senha', Sistema.Senha);

    Parametro_Tipo('Sistema_Master', ftString);
    Parametro_Valor('Sistema_Master', ConverteLogico(Sistema.Master));

    Parametro_Tipo('Sistema_Grupo', ftString);
    Parametro_Valor('Sistema_Grupo', Sistema.Grupo);

    Parametro_Tipo('Sistema_NumeroUsr', ftString);
    Parametro_Valor('Sistema_NumeroUsr', Sistema.NumeroUsr);

    Parametro_Tipo('Sistema_EnderecoUsr', ftString);
    Parametro_Valor('Sistema_EnderecoUsr', Sistema.EnderecoUsr);

    Parametro_Tipo('Sistema_BairroUsr', ftString);
    Parametro_Valor('Sistema_BairroUsr', Sistema.BairroUsr);

    Parametro_Tipo('Sistema_CidadeUsr', ftString);
    Parametro_Valor('Sistema_CidadeUsr', Sistema.CidadeUsr);

    Parametro_Tipo('Sistema_UfUsr', ftString);
    Parametro_Valor('Sistema_UfUsr', Sistema.UfUsr);

    Parametro_Tipo('Sistema_CEPUsr', ftString);
    Parametro_Valor('Sistema_CEPUsr', Sistema.CEPUsr);

    Parametro_Tipo('Sistema_CNPJUsr', ftString);
    Parametro_Valor('Sistema_CNPJUsr', Sistema.CNPJUsr);

    Parametro_Tipo('Sistema_IEUsr', ftString);
    Parametro_Valor('Sistema_IEUsr', Sistema.IEUsr);

    Parametro_Tipo('Sistema_FonesUsr', ftString);
    Parametro_Valor('Sistema_FonesUsr', Sistema.FonesUsr);

    Parametro_Tipo('Sistema_LogoUsr', ftString);
    Parametro_Valor('Sistema_LogoUsr', Sistema.LogoUsr);

    Parametro_Tipo('Sistema_Data_Atual', ftString);
    Parametro_Valor('Sistema_Data_Atual', Date);

    for I:=0 to Lst_Tabelas.Count-1 do
      for Y:=0 to TTabela(Lst_Tabelas[I]).Campos.Count-1 do
      begin
        if Assigned(TTabela(Lst_Tabelas[I]).FindField(TAtributo(TTabela(Lst_Tabelas[I]).Campos[Y]).Nome)) then
        begin
          Nome_Par := Trim(Copy(TTabela(Lst_Tabelas[I]).Name,02,30) + '_' + TAtributo(TTabela(Lst_Tabelas[I]).Campos[Y]).Nome);
          Parametro_Tipo(Nome_Par, TAtributo(TTabela(Lst_Tabelas[I]).Campos[Y]).Valor.DataType);
          Parametro_Valor(Nome_Par, TTabela(Lst_Tabelas[I]).FieldValues[TAtributo(TTabela(Lst_Tabelas[I]).Campos[Y]).Nome]);
        end;
      end;
  end;
end;

procedure TTabela.Parametro_Tipo(Nome: String; Tipo: TFieldType);
begin
  if Params.FindParam(Nome) <> nil then
    ParamByName(Nome).DataType := Tipo;
end;

procedure TTabela.Parametro_Valor(Nome: String; Valor: Variant);
begin
  if Params.FindParam(Nome) <> nil then
    ParamByName(Nome).Value := Valor;
end;

function TTabela.Exclui: Boolean;
begin
  Result := TestarConexao;
  if not Result then
    exit;
  if TableType <> ttTable then
    exit;
  if PodeExcluir then
  begin
    if Eof then
      exit;
    try
      Sistema.Conexao_i := Time;
      ExclusaoCascata;
      GravarLog(3);
      Delete;
      {$IFDEF IBX}
      Transaction.CommitRetaining;
      {$ELSE}
      Refresh;
      {$ENDIF}
      Inclusao    := False;
      Modificacao := False;
      Result      := True;
      Sistema.Conexao_f := Time;
      Atualiza_Status;
    except
      {$IFDEF IBX}
      on Erro: EIBInterBaseError do
      {$ELSE}
      on Erro: Exception do
      {$ENDIF}
      begin
        MessageDlg('Exclusão na Tabela: '+Titulo+ ^M+^M + Erro.Message, mtError, [mbOk], 0);
        Result := False;
      end;
    end;
  end
  else
    MessageDlg('Exclusão não Permitida !',mtError,[mbOk],0);
end;

function TTabela.LimparTabela: Boolean;
var
  {$IFDEF IBX}
  Query: TIBSQL;
  {$ELSE}
  Query: TXSQLQuery;
  {$ENDIF}
begin
  Result := TestarConexao;
  if not Result then
    exit;
  if TableType <> ttTable then
    exit;
  Result := False;
  if NomeTabela = '' then Exit;
  {$IFDEF IBX}
  Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(Self);
  {$ELSE}
  Query := TXSQLQuery.Create(Self);
  {$ENDIF}
  try
    Sistema.Conexao_i := Time;
    {$IFDEF IBX}
    Query.Database    := DataBase;
    Query.Transaction := Database.InternalTransaction;
    {$ELSE}
    Query.DatabaseName  := DatabaseName;
    {$ENDIF}
    Query.SQL.Text    := 'delete from '+NomeTabela;
    Query.Prepare;
    {$IFDEF IBX}
    Query.ExecQuery;
    {$ELSE}
    Query.ExecSQL;
    {$ENDIF}
    Result := Query.EOF;
    Sistema.Conexao_f := Time;
    Atualiza_Status;
  finally
    Query.Free;
    {$IFDEF IBX}
    Database.InternalTransaction.Commit;
    {$ENDIF}
  end;
end;

procedure TTabela.Conexao;
begin
  {$IFDEF XSQL}
  DatabaseName := DataBase.DatabaseName;
  {$ENDIF}
end;

procedure TTabela.ConexaoQueryExtra;
begin
  {$IFDEF IBX}
  QueryExtra.DataBase := DataBase;
  QueryExtra.Transaction := Transaction;
  {$ELSE}
  QueryExtra.DatabaseName := DatabaseName;
  {$ENDIF}
end;

procedure TTabela.ConfiguraMascara_CS;
begin
  //
end;

function TTabela.TestarConexao: Boolean;
begin
  Result := False;
  try
    if Assigned(DataBase) then
    begin
      Result := DataBase.TestConnected;
      if not Result then
        if MessageDlg('Conexão não está ativa!' + ^M + ^M + 'Ativar conexão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          DataBase.Connected := True;
          Result := DataBase.TestConnected;
        end;
    end;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      MessageDlg('Conexão não disponível!' + ^M + ^M + Erro.Message ,mtError,[mbOk],0);
      Result := False;
    end;
  end;
end;

procedure TTabela.GravarLog(Tipo: Integer; Operacao: String = ''; Comando: String = '');
var
  Script: TTabela;
  I: Integer;
  Lst_Comando: TStringList;
begin
  if UpperCase(Copy(NomeTabela, 01, 05)) = 'USER_' then
    exit;
  try
    Script := TTabela.Create(Self);
    Script.DataBase     := DataBase;
    Script.DatabaseName := DatabaseName;
    Script.Transaction  := Transaction;
    Script.TableType    := ttView;
    with Script.SQL do
    begin
      Add('insert into USER_LOG');
      Add(' (');
      Add(' Usuario,');
      Add(' Data,');
      Add(' Hora,');
      Add(' Tabela,');
      Add(' Estacao,');
      Add(' Tipo,');
      Add(' Comando');
      Add(' )');
      Add(' values');
      Add(' (');
      Add(' :Usuario,');
      Add(' :Data,');
      Add(' :Hora,');
      Add(' :Tabela,');
      Add(' :Estacao,');
      Add(' :Tipo,');
      Add(' :Comando');
      Add(' )');
    end;
    Script.Parametro_Tipo('Usuario', ftString);
    Script.Parametro_Tipo('Data', ftDate);
    Script.Parametro_Tipo('Hora', ftString);
    Script.Parametro_Tipo('Tabela', ftString);
    Script.Parametro_Tipo('Estacao', ftString);
    Script.Parametro_Tipo('Tipo', ftString);
    Script.Parametro_Tipo('Comando', ftMemo);

    Script.Parametro_Valor('Usuario', Sistema.Usuario);
    Script.Parametro_Valor('Data', Date());
    Script.Parametro_Valor('Hora', TimeToStr(Time()));
    Script.Parametro_Valor('Tabela', Titulo);
    Script.Parametro_Valor('Estacao', Sistema.Estacao);
    if Trim(Operacao) = '' then
    begin
      case Tipo of
        1: Script.Parametro_Valor('Tipo', 'Inclusão');
        2: Script.Parametro_Valor('Tipo', 'Modificação');
        3: Script.Parametro_Valor('Tipo', 'Exclusão');
      end;
    end
    else
      Script.Parametro_Valor('Tipo', Operacao);
    Lst_Comando := TStringList.Create;
    if Trim(Comando) = '' then
    begin
      if Tipo = 2 then
      begin
        Lst_Comando.Add('==== Depois da Modificação ====');
        Lst_Comando.Add('');
      end;
      for I:=0 to Campos.Count-1 do
        Lst_Comando.Add(TAtributo(Campos[I]).Titulo + ' = ' +TAtributo(Campos[I]).Valor.AsString);
      if Tipo = 2 then
      begin
        Lst_Comando.Add('');
        Lst_Comando.Add('==== Antes da Modificação ====');
        Lst_Comando.Add('');
        Lst_Comando.AddStrings(LogOldFields);
        LogOldFields.Clear;
      end;
    end
    else
      Lst_Comando.Text := Comando;
    Script.Parametro_Valor('Comando', Lst_Comando.Text);
    Script.Prepare;
    Script.ExecSQL;
    Script.Free;
    Lst_Comando.Free;
  except
    {$IFDEF IBX}
    on Erro: EIBInterBaseError do
    {$ELSE}
    on Erro: Exception do
    {$ENDIF}
    begin
      if Assigned(Script) then
        Script.Free;
      MessageDlg('Erro na gravação do Log!' + ^M + ^M + Erro.Message ,mtError,[mbOk],0);
    end;
  end;
end;

procedure TTabela.Refresh;
begin
  {$IFDEF IBX}
  DoBeforeRefresh;
  CheckBrowseMode;
  UpdateCursorPos;
  try
    InternalRefresh;
  finally
    Resync([]);
    DoAfterRefresh;
  end;
  {$ELSE}
  RefreshRecord;
  {$ENDIF}
end;

procedure TSQLScript.Parametros;
begin
  //
end;

procedure TSQLScript.Criar_Trigger;
begin
  if Trim(NomeTrigger) = '' then
    exit;
  if not FindTrigger(Database, NomeTrigger) then
    Executar;
end;

procedure TSQLScript.Executar;
begin
  Parametros;
  {$IFDEF IBX}
  ExecuteScript;
  {$ELSE}
  ExecSQL;
  {$ENDIF}
end;

procedure TSQLProcedure.Parametro_Valor(Nome: String; Valor: Variant);
begin
  Prepare;
  if Params.FindParam(Nome) <> nil then
    ParamByName(Nome).Value := Valor;
end;

procedure TSQLProcedure.Executar;
begin
  {$IFDEF IBX}
  PSExecute;
  {$ELSE}
  ExecProc;
  {$ENDIF}
end;

end.
