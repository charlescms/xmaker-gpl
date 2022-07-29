{
  Classe de Tabelas
}
unit Tabela;

interface

uses
  SysUtils, StdCtrls, Forms, Dialogs, Graphics, Classes, Controls, ExtCtrls,
  IBDatabase, IBSQL, IB, Db, IBQuery, IBUpdateSQL, dbctrls, Atributo, Publicas,
  XLookUp, Variants;

type
  TTabela = class;

  TTabela = class(TIBQuery)
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
    IndexDefs      : TIndexDefs;
    DataBase       : TIBDataBase;
    UpdateSql      : TIBUpdateSQL;
    Inclusao       : Boolean;
    Modificacao    : Boolean;
    SqlPrincipal   : TStringList;
    Filtro         : String;
    FiltroRelac    : String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FormatFieldsList(Value: string): string;
    procedure DeletaTabela;
    procedure CriaTabela;
    procedure AddIndex(const Name, Fields: string; Options: TIndexOptions;
      const DescFields: string = '');
    procedure DeleteIndex(const Name: string);
    procedure DefineCampos;
    function Existe: Boolean;
    function Abrir: Boolean;
    procedure AtualizaSql;
    procedure AssociaChaveEstrangeira(CampoEdit: TComponent;
      ChaveEstrangeira: string; CamposMostrar: array of string); dynamic;
    procedure OrdenaModDBLookCombo(Sender: TObject);
    function Inclui(Campos: TListaCampos): Boolean;
    function Cancela: Boolean;
    function Modifica: Boolean;
    function Salva: Boolean;
    function PodeExcluir: Boolean; dynamic; abstract;
    procedure ExclusaoCascata; dynamic; abstract;
    function Exclui: Boolean;
    procedure OnBeforePost(DataSet: TDataSet);
  end;

function AbreTabelas(AOwner: TComponent): Boolean;
procedure FechaTabelas(AOwner: TComponent);
function ProcuraTabela(AOwner: TComponent; NomeTabela: string;
  ProcurarNomeCompleto: Boolean): TTabela;
function FormatIdentifierValue(Dialect: Integer; Value: String): String;
function DataSql(Data: TDateTime): String;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant): Boolean; overload;
// Pesquisa, Realiza cálculos e Retorna cálculos
function PTabela(TabelaPrincipal: TTabela; CalculosArray: Array of String; ExpressaoFiltro: String; var ValoresRetornar: Variant; ordenacao: String = ''): Boolean; overload;
// Pesquisa e Retorna os Valores dos Campos Desejados
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; CamposMostrar: array of String; var ValoresRetornar: Variant): Boolean; overload;
// Pesquisa e atualiza campos
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Update: String): Boolean; overload;
// Pesquisa e realiza a exclusão do registro
function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Excluir: Boolean): Boolean; overload;
function RetornaAutoIncremento(TabelaPrincipal: TTabela; Campo: String; Condicao: String): Variant;
function Localiza_ObjProjeto(Tipo: String; Numero, Padrao: Integer; V_Recurso: Boolean = True): Integer;

var
  Lst_Tabelas: TList;

implementation

uses
  FileCtrl, Rotinas, BaseD, Abertura;

function Localiza_ObjProjeto(Tipo: String; Numero, Padrao: Integer; V_Recurso: Boolean = True): Integer;
var
  I: Integer;
  Lista: TStringList;
  Retorno: Integer;
  Verificar: Boolean;
begin
  Retorno := -1;
  if V_Recurso then
    Verificar := TabGlobal_i.DPROJETO.OBJETOS_PROJETO.Conteudo = 0
  else
    Verificar := True;  
  if Verificar then
  begin
    Lista := TStringList.Create;
    for I:=0 to TabGlobal_i.DPROJETO.TABELAS_UTILIZADAS.Conteudo.Count-1 do
    begin
      StringToArray(TabGlobal_i.DPROJETO.TABELAS_UTILIZADAS.Conteudo[I], ';', Lista);
      if Lista.Count = 3 then
        if (Lista[0] = Tipo) and (Lista[1] = IntToStr(Numero)) then
        begin
          Retorno := StrToInt(Lista[2]);
          break;
        end;
    end;
    Lista.Free;
  end;
  if Retorno = -1 then
    Retorno := Padrao;
  Localiza_ObjProjeto := Retorno;
end;

function AbreTabelas(AOwner: TComponent): Boolean;
var
  I: Integer;
  Tabela: TTabela;
begin
  Result := True;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if Tabela.Owner = AOwner then
      Tabela.Abrir;
  end;
end;

procedure FechaTabelas(AOwner: TComponent);
var
  I: Integer;
  Tabela: TTabela;
begin
  if Lst_Tabelas = nil then
    Exit;
  for I := (Lst_Tabelas.Count - 1) downto 0 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if Tabela.Owner = AOwner then
    begin
      if Tabela.Active then
        Tabela.Close;
      Tabela.Free;
      Lst_Tabelas.Delete(I);
    end;
  end;
  if Lst_Tabelas.Count = 0 then
  begin
    Lst_Tabelas.Free;
    Lst_Tabelas := nil;
  end;
end;

function ProcuraTabela(AOwner: TComponent; NomeTabela: string;
  ProcurarNomeCompleto: Boolean): TTabela;
var
  I, Tam: Integer;
  Tabela: TTabela;
begin
  Result := nil;
  if ProcurarNomeCompleto then
    Tam := 99
  else
    Tam := Length(NomeTabela);
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if ((AOwner = nil) or (Tabela.Owner = AOwner)) and
       (UpperCase(NomeTabela) = UpperCase(Copy(Tabela.Name, 1, Tam))) then
    begin
      Result := Tabela;
      Break;
    end;
  end;
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
  FormatoData: string;
  DataS: String;
begin
  FormatoData     := ShortDateFormat;
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
begin
  Result := False;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
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
      case TabelaPrincipal.FieldByName(NomeCampo).DataType of
        ftSmallint, ftWord, ftInteger:
          SQL.Add(Negacao + CamposArray[I] + Operador + IntToStr(ValoresArray[I]) + ' and ');
        ftFloat, ftCurrency:
          SQL.Add(Negacao + CamposArray[I] + Operador + FloatToStr(ValoresArray[I]) + ' and ');
        ftDate, ftDateTime:
          SQL.Add(Negacao + CamposArray[I] + Operador + #39 + DataSql(ValoresArray[I]) + #39 + ' and ');
        else
          SQL.Add(Negacao + CamposArray[I] + Operador + #39 + ValoresArray[I] + #39 + ' and ');
      end;
    end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    //conexao;
    Abrir;
    if not Eof then Result := True;
    Free;
  end;
end;

function PTabela(TabelaPrincipal: TTabela; CalculosArray: Array of String; ExpressaoFiltro: String; var ValoresRetornar: Variant; ordenacao: String = ''): Boolean; overload;
var
  Tabela: TTabela;
  I: Integer;
begin
  Result := False;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
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
    if Ordenacao <> '' then
      SQL.Add('order by '+ordenacao);
    //conexao;
    if Abrir then
    begin
      ValoresRetornar := VarArrayCreate([0, Length(CalculosArray)-1], varVariant);
      for I:=0 to Length(CalculosArray)-1 do
        ValoresRetornar[I] := Fields[I].AsVariant;
      Result := True;
    end;
    Free;
  end;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; CamposMostrar: array of String; var ValoresRetornar: Variant): Boolean; overload;
var
  Tabela: TTabela;
  I: Integer;
  NomeCampo: String;
begin
  Result := False;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    SQL.Add('Select');
    for I:=0 to Length(CamposArray)-1 do
      SQL.Add(CamposArray[I] + ',');
    for I:=0 to Length(CamposMostrar)-1 do
      SQL.Add(CamposMostrar[I] + ',');
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-1);
    SQL.Add('From');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
    begin
      NomeCampo := CamposArray[I];
      if Copy(NomeCampo,01,06) = 'UPPER(' then
      begin
        NomeCampo := Copy(NomeCampo,Pos('(',NomeCampo)+1,Length(NomeCampo));
        NomeCampo := Trim(Copy(NomeCampo,01,Pos(')',NomeCampo)-1));
      end;
      case TabelaPrincipal.FieldByName(NomeCampo).DataType of
        ftSmallint, ftWord, ftInteger:
          SQL.Add(CamposArray[I] + ' = ' + IntToStr(ValoresArray[I]) + ' and ');
        ftFloat, ftCurrency:
          SQL.Add(CamposArray[I] + ' = ' + FloatToStr(ValoresArray[I]) + ' and ');
        ftDate, ftDateTime:
          SQL.Add(CamposArray[I] + ' = ' + #39 + DataSql(ValoresArray[I]) + #39 + ' and ');
        else
          SQL.Add(CamposArray[I] + ' = ' + #39 + ValoresArray[I] + #39 + ' and ');
      end;
    end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    //conexao;
    Abrir;
    if not Eof then
    begin
      ValoresRetornar := VarArrayCreate([0, Length(CamposMostrar)-1], varVariant);
      for I:=0 to Length(CamposMostrar)-1 do
        ValoresRetornar[I] := Fields[I + Length(CamposArray)].AsVariant;
      Result := True;
    end;
    Free;
  end;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Update: String): Boolean;
var
  Tabela: TTabela;
  I: Integer;
begin
  Result := False;
  if not PTabela(TabelaPrincipal, CamposArray, ValoresArray) then
    exit;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    SQL.Add('Update');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Set');
    SQL.Add(Update);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
      case TabelaPrincipal.FieldByName(CamposArray[I]).DataType of
        ftSmallint, ftWord, ftInteger:
          SQL.Add(CamposArray[I] + ' = ' + IntToStr(ValoresArray[I]) + ' and ');
        ftFloat, ftCurrency:
          SQL.Add(CamposArray[I] + ' = ' + FloatToStr(ValoresArray[I]) + ' and ');
        ftDate, ftDateTime:
          SQL.Add(CamposArray[I] + ' = ' + #39 + DataSql(ValoresArray[I]) + #39 + ' and ');
        else
          SQL.Add(CamposArray[I] + ' = ' + #39 + ValoresArray[I] + #39 + ' and ');
      end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    NomeTabela := TabelaPrincipal.NomeTabela;
    if Abrir then
    begin
      Transaction.CommitRetaining;
      Result := True;
    end;
    Free;
  end;
end;

function PTabela(TabelaPrincipal: TTabela; CamposArray: Array of String; ValoresArray: Array of Variant; Excluir: Boolean): Boolean;
var
  Tabela: TTabela;
  I: Integer;
begin
  Result := False;
  if not Excluir then
    exit;
  if not PTabela(TabelaPrincipal, CamposArray, ValoresArray) then
    exit;
  Tabela := TTabela.Create(BaseDados);
  with Tabela do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    SQL.Add('Delete');
    SQL.Add('From');
    SQL.Add(TabelaPrincipal.NomeTabela);
    SQL.Add('Where');
    for I:=0 to Length(CamposArray)-1 do
      case TabelaPrincipal.FieldByName(CamposArray[I]).DataType of
        ftSmallint, ftWord, ftInteger:
          SQL.Add(CamposArray[I] + ' = ' + IntToStr(ValoresArray[I]) + ' and ');
        ftFloat, ftCurrency:
          SQL.Add(CamposArray[I] + ' = ' + FloatToStr(ValoresArray[I]) + ' and ');
        ftDate, ftDateTime:
          SQL.Add(CamposArray[I] + ' = ' + #39 + DataSql(ValoresArray[I]) + #39 + ' and ');
        else
          SQL.Add(CamposArray[I] + ' = ' + #39 + ValoresArray[I] + #39 + ' and ');
      end;
    SQL[SQL.Count-1] := Copy(SQL[SQL.Count-1],01,Length(SQL[SQL.Count-1])-5);
    NomeTabela := TabelaPrincipal.NomeTabela;
    if Abrir then
    begin
      Transaction.CommitRetaining;
      Result := True;
    end;
    Free;
  end;
end;

procedure TTabela.OnBeforePost(DataSet: TDataSet);
begin
  {if NomeTabela = 'TABELAS' then
    FieldByName('REGERAR').AsInteger := 1
  else if (NomeTabela = 'CAMPOST') or
          (NomeTabela = 'INDICEST') or
          (NomeTabela = 'CALCULADOS') or
          (NomeTabela = 'CASCATAT') or
          (NomeTabela = 'RESTRITAT') or
          (NomeTabela = 'RELACIONA') or
          (NomeTabela = 'PROCESSOS') or
          (NomeTabela = 'TRIGGER_I') then
    PTabela(TabGlobal_i.DTabelas, ['NUMERO'], [FieldByName('NUMERO').AsInteger], 'REGERAR = 1');}
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
  DataSource.DataSet := Self;
  SqlPrincipal   := TStringList.Create;
  if Lst_Tabelas = nil then
    Lst_Tabelas := TList.Create;
  Lst_Tabelas.Add(Self);
  //BeforePost := OnBeforePost;
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
  Lst_Tabelas.Delete(Lst_Tabelas.IndexOf(Self)); // Essa instrução veio da Abertura.Pas
  inherited Destroy;
end;

function FormatIdentifier(Versao: Integer; Value: String): String;
begin
  Value := AnsiUpperCase(RetiraBrancos(Value));
  Result := Value;
end;

function TTabela.FormatFieldsList(Value: string): string;
var
  FieldName: string;
  I: Integer;
begin
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
  Query: TIBSQL;
begin
  Result := Active;
  if Result or (NomeTabela = '') then Exit;
  Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(self);
  try
    Query.Database := DataBase;
    Query.Transaction := Database.InternalTransaction;
    Query.SQL.Text :=
    'Select USER from RDB$RELATIONS where RDB$RELATION_NAME = ' +
    '''' +
    FormatIdentifier(Versao, NomeTabela) + '''';
    Query.Prepare;
    Query.ExecQuery;
    Result := not Query.EOF;
  finally
    Query.Free;
    Database.InternalTransaction.Commit;
  end;
end;

procedure TTabela.DeletaTabela;
var
  Query: TIBSQL;
begin
  CheckInactive;
  Query := TIBSQL.Create(Self);
  try
    Query.Database := Database;
    Query.SQL.Add('drop table ' +
      FormatIdentifier(Versao, NomeTabela));
    Query.Prepare;
    Query.ExecQuery;
  finally
    Query.Free;
  end;
end;

procedure TTabela.CriaTabela;
var
  FieldList: string;

  procedure InitFieldsList;
  var
    I: Integer;
  begin
    for I := 0 to FieldDefs.Count - 1 do begin
      if (I > 0) then
        FieldList := FieldList + ', ';
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
          ftInteger:
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
              if Precision > 9 then
                IBError(ibxeFieldUnsupportedType,[nil]);
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
              FieldList := FieldList +
              FormatIdentifier(Versao, Name) + ' TIMESTAMP';
          ftLargeInt:
            if (Versao = 5) then
              IBError(ibxeFieldUnsupportedType,[nil])
            else
              FieldList := FieldList +
                FormatIdentifier(Versao, Name) +
                ' Numeric(18, 0)';
          ftBlob, ftMemo:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' BLOB SUB_TYPE 1';
          ftBytes, ftVarBytes, ftGraphic..ftTypedBinary:
            FieldList := FieldList +
              FormatIdentifier(Versao, Name) +
              ' BLOB SUB_TYPE 0';
          ftUnknown, ftADT, ftArray, ftReference, ftDataSet,
          ftCursor, ftWideString, ftAutoInc:
            IBError(ibxeFieldUnsupportedType,[nil]);
          else
            IBError(ibxeFieldUnsupportedType,[nil]);
        end;
        if faRequired in Attributes then
          FieldList := FieldList + ' NOT NULL';
      end;
    end;
  end;

  procedure DefineIndicePrimario;
  begin
    IndexDefs.Clear;
    IndexDefs.Add('IdxPrimaria', UpperCase(ChaveIndice), [ixPrimary, ixUnique]);
  end;

  procedure InternalCreateTable;
  var
    I: Integer;
    Query: TIBSql;
  begin
    if (FieldList = '') then
      IBError(ibxeFieldUnsupportedType,[nil]);
    Query := TIBSql.Create(self);
    try
      Query.Database := Database;
      Query.transaction := Transaction;
      Query.SQL.Text := 'Create Table ' +
        FormatIdentifier(Versao, NomeTabela) +
        ' (' + FieldList;
      for I := 0 to IndexDefs.Count - 1 do
      with IndexDefs[I] do
        if ixPrimary in Options then
        begin
          Query.SQL.Text := Query.SQL.Text + ', CONSTRAINT ' +
            FormatIdentifier(Versao, 'I' + NomeTabela) +
            ' Primary Key (' +
            FormatFieldsList(Fields) +
            ')';
        end;
      Query.SQL.Text := Query.SQL.Text + ')';
      Query.Prepare;
      Query.ExecQuery;
    finally
      Query.Free;
    end;
  end;

  procedure InternalCreateIndex;
  var
    I: Integer;
  begin
    for I := 0 to IndexDefs.Count - 1 do
    with IndexDefs[I] do
      if not (ixPrimary in Options) then
        AddIndex(Name, Fields, Options);
  end;

begin
  CheckInactive;
  DefineCampos;
  DefineIndicePrimario;
  InitFieldsList;
  if Existe then
    DeletaTabela;
  InternalCreateTable;
  InternalCreateIndex;
end;

procedure TTabela.AddIndex(const Name, Fields: string; Options: TIndexOptions;
  const DescFields: string);
var
  Query: TIBSQL;
  FieldList: string;
begin
  FieldDefs.Update;
  if Active then
  begin
    CheckBrowseMode;
    CursorPosChanged;
  end;
  Query := TIBSQL.Create(self);
  try
    Query.Database := DataBase;
    Query.Transaction := Transaction;
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
    Query.ExecQuery;
    IndexDefs.Updated := False;
  finally
    Query.free
  end;
end;

procedure TTabela.DeleteIndex(const Name: string);
var
  Query: TIBSQL;

  procedure DeleteByIndex;
  begin
    Query := TIBSQL.Create(self);
    try
      Query.Database := DataBase;
      Query.Transaction := Transaction;
      Query.SQL.Text := 'Drop index ' +  {do not localize}
                         FormatIdentifier(Versao, Name);
      Query.Prepare;
      Query.ExecQuery;
      IndexDefs.Updated := False;
    finally
      Query.Free;
    end;
  end;

  function DeleteByConstraint: Boolean;
  begin
    Result := False;
    Query := TIBSQL.Create(self);
    try
      Query.Database := DataBase;
      Query.Transaction := Transaction;
      Query.SQL.Text := 'Select ''foo'' from RDB$RELATION_CONSTRAINTS ' +  {do not localize}
        'where RDB$RELATION_NAME = ' +   {do not localize}
        '''' +  {do not localize}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, NomeTabela)) +
        ''' ' +      {do not localize}
        ' AND RDB$CONSTRAINT_NAME = ' +  {do not localize}
        '''' +     {do not localize}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, Name)) +
        ''' ' +    {do not localize}
        'AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''';   {do not localize}
      Query.Prepare;
      Query.ExecQuery;
      if not Query.EOF then
      begin
        Query.Close;
        Query.SQL.Text := 'Alter Table ' +  {do not localize}
          FormatIdentifier(Versao, NomeTabela) +
          ' Drop Constraint ' +   {do not localize}
          FormatIdentifier(Versao, Name);
        Query.Prepare;
        Query.ExecQuery;
        IndexDefs.Updated := False;
        Result := True;
      end;
    finally
      Query.Free;
    end;
  end;

  procedure DeleteByKey;
  begin
    Query := TIBSQL.Create(self);
    try
      Query.Database := DataBase;
      Query.Transaction := Transaction;
      Query.SQL.Text := 'Select RDB$CONSTRAINT_NAME from RDB$RELATION_CONSTRAINTS ' +   {do not localize}
        'where RDB$RELATION_NAME = ' +  {do not localize}
        '''' +  {do not localize}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, NomeTabela)) +
        ''' ' +  {do not localize}
        'AND RDB$INDEX_NAME = ' +  {do not localize}
        '''' +  {do not localize}
        FormatIdentifierValue(Database.SQLDialect,
          FormatIdentifier(Versao, Name)) +
        ''' ' +    {do not localize}
        'AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'''; {do not localize}
      Query.Prepare;
      Query.ExecQuery;
      if not Query.EOF then
      begin
        Query.Close;
        Query.SQL.Text := 'Alter Table ' +  {do not localize}
          FormatIdentifier(Versao, NomeTabela) +
          ' Drop Constraint ' +  {do not localize}
          FormatIdentifier(Versao, Query.Current.ByName('RDB$CONSTRAINT_NAME').AsString); {do not localize}
        Query.Prepare;
        Query.ExecQuery;
        IndexDefs.Updated := False;
      end;
    finally
      Query.Free;
    end;
  end;

begin
  if Active then
    CheckBrowseMode;
  IndexDefs.Update;
  if (Pos('RDB$PRIMARY', Name) <> 0 ) then {do not localize} {mbcs ok}
    DeleteByKey
  else if not DeleteByConstraint then
    DeleteByIndex;
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
    if not Campo.Calculado then
      if Campo.Tipo in [tpInteiro, tpFracionario] then
        FieldDefs.Add(UpperCase(Campo.Nome), Campo.TipoCampo,
          0, (Pos(Campo.Nome, ChaveIndice) > 0))
      else
        FieldDefs.Add( UpperCase(Campo.Nome), Campo.TipoCampo,
          Campo.TamanhoDado, (Pos(Campo.Nome, ChaveIndice) > 0));
  end;
end;

function TTabela.Abrir: Boolean;
begin
  Result := True;
  try
    if not Active then
    begin
      Prepare;
      Open;
    end;
  except
    on Erro: Exception do
    begin
      Mensagem('Erro na abertura da tabela: '+NomeTabela,modErro,[modOk]);
      Result := False;
      Exit;
    end;
  end;
end;

procedure TTabela.AtualizaSql;
begin
  //Screen.Cursor := crHourGlass;
  try
    DisableControls;
    Active   := False;
    Sql.Clear;
    Sql.AddStrings(SqlPrincipal);
    if Trim(Filtro) <> '' then
      Sql.Add('         Where '+Filtro);
    if Trim(FiltroRelac) <> '' then
      if Trim(Filtro) = '' then
        Sql.Add('         Where '+FiltroRelac)
      else
        Sql.Add('            AND '+FiltroRelac);
    Sql.Add('         Order By '+ChaveIndice);
  finally
    Active := True;
    First;
    EnableControls;
    //Screen.Cursor := crDefault;
  end;
end;

procedure TTabela.AssociaChaveEstrangeira(CampoEdit: TComponent;
  ChaveEstrangeira: string; CamposMostrar: array of string);
begin
  if CampoEdit is TXDBLookUp then
  begin
    TXDBLookUp(CampoEdit).ListSource := DataSource;
    TXDBLookUp(CampoEdit).KeyField   := ChaveEstrangeira;
    TXDBLookUp(CampoEdit).ListField  := ArrayToString(CamposMostrar, ';');
    TXDBLookUp(CampoEdit).OnClickOrdenacao := OrdenaModDBLookCombo;
  end;
end;

procedure TTabela.OrdenaModDBLookCombo(Sender: TObject);
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
  try
    Insert;
    Inclusao    := True;
    Modificacao := False;
    Result      := True;
    if Campos <> nil then
      for I := 0 to Campos.Count - 1 do
      begin
        Atributo := TCampoEdicao(Campos[I]).Campo;
        if (Atributo.Valor.DataSet = Self) and (not Atributo.Calculado) then
          Atributo.AtribuiValorPadrao;
      end;
  except
    on Erro: EIBInterBaseError do
    begin
      Mensagem('Inclusão na Tabela: '+Titulo+ ^M+^M + Erro.Message, modErro, [modOk]);
      Result := False;
    end;
  end;
end;

function TTabela.Cancela: Boolean;
begin
  try
    if Inclusao or Modificacao then
    begin
      Cancel;
      if not Eof then
        Refresh;
    end;
    Inclusao    := False;
    Modificacao := False;
    Result      := True;
  except
    on Erro: EIBInterBaseError do
    begin
      Mensagem('Cancelamento na Tabela: '+Titulo+ ^M+^M + Erro.Message, modErro, [modOk]);
      Result := False;
    end;
  end;
end;

function TTabela.Modifica: Boolean;
begin
  try
    Refresh;
    Edit;
    Inclusao    := False;
    Modificacao := True;
    Result      := True;
  except
    on Erro: EIBInterBaseError do
    begin
      Mensagem('Edição na Tabela: '+Titulo+ ^M+^M + Erro.Message, modErro, [modOk]);
      Result := False;
    end;
  end;
end;

function TTabela.Salva: Boolean;
begin
  try
    Post;
    Transaction.CommitRetaining;
    Inclusao    := False;
    Modificacao := False;
    Result      := True;
  except
    on Erro: EIBInterBaseError do
    begin
      Mensagem('Gravação na Tabela: '+Titulo+ ^M+^M + Erro.Message, modErro, [modOk]);
      Result := False;
    end;
  end;
end;

function TTabela.Exclui: Boolean;
begin
  if PodeExcluir then
  begin
    try
      Refresh;
      ExclusaoCascata;
      Delete;
      Transaction.CommitRetaining;
      Inclusao    := False;
      Modificacao := False;
      Result      := True;
    except
      on Erro: EIBInterBaseError do
      begin
        Mensagem('Exclusão na Tabela: '+Titulo+ ^M+^M + Erro.Message, modErro, [modOk]);
        Result := False;
      end;
    end;
  end
  else
  begin
    Mensagem('Exclusão não Permitida !',modErro,[modOk]);
    Exclui := False;
  end;
end;

function RetornaAutoIncremento(TabelaPrincipal: TTabela; Campo: String; Condicao: String): Variant;
Var
  Query: TTabela;
begin
  Query := TTabela.Create(Application);
  with Query do
  begin
    DataBase := TabelaPrincipal.DataBase;
    Transaction := TabelaPrincipal.Transaction;
    SQL.Clear;
    SQL.Add('Select '+Campo);
    SQL.Add(' From '+TabelaPrincipal.NomeTabela);
    if Trim(Condicao) <> '' then
      SQL.Add(' Where '+Condicao);
    SQL.Add(' Order By '+Campo);
    Abrir;
    Last;
    case Fields[0].DataType of
      ftSmallint, ftWord, ftInteger:
        RetornaAutoIncremento := Fields[0].AsInteger + 01;
      ftFloat, ftCurrency:
        RetornaAutoIncremento := Fields[0].AsFloat + 01;
      ftDate, ftDateTime:
        RetornaAutoIncremento := Fields[0].AsDateTime + 01;
    end;
    Free;
  end;
end;

end.
