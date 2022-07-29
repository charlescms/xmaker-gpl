unit Atributo;

interface

uses WinTypes, WinProcs, SysUtils, StdCtrls, Classes, Controls, ExtCtrls,
     Publicas, db;

type
  TAtributo = class(TComponent)
  public
    Nome: String;
    Tipo: TTipoDado;
    Tamanho: Longint;
    TipoEdicao: TTipoEdicao;
    Titulo: String;
    Mascara: String;
    CaractereEdicao: Char;
    Ajuda: String;
    Calculado: Boolean;
    Valor: TField;
    ValorValido: TStringList;
    DescValorValido: TStringList;
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; virtual;
    function Valido(var MsgErro: string): Boolean; virtual;
    function ValorNulo(Dado: string): Boolean; virtual;
    procedure ConfiguraMascara;
    function TipoCampo: TFieldType;
    function TamanhoDado: Integer;
    function IndiceValorValido: Integer;
    procedure AtribuiIndice(Indice: Integer);
    procedure IncluiValorValido(Valor, Descricao: string);
    procedure MontaValoresValidos(Lista: TStrings);
    procedure MontaDescValoresValidos(Lista: TStrings);
    procedure IncluiValoresValidos; virtual;
    property Indice: Integer read IndiceValorValido write AtribuiIndice;
  end;

  TListaCampos = class(TList)
    function ProcuraCampoED(Campo: TAtributo): integer;
    function ProcuraControle(Controle: TWinControl): integer;
    destructor Destroy; override;
  end;

  TCampoEdicao = class
    Campo: TAtributo;
    Pagina: integer;
    Controle: TWinControl;
    Validacao: TNotifyEvent;
  end;

implementation

constructor TAtributo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ValorValido := TStringList.Create;
  DescValorValido := TStringList.Create;
end;

destructor TAtributo.Destroy;
begin
  ValorValido.Free;
  DescValorValido.Free;
  inherited Destroy;
end;

procedure TAtributo.AtribuiValorPadrao;
begin
end;

function TAtributo.Valido(var MsgErro: string): Boolean;
begin
  Result := True;
  MsgErro := '';
end;

function TAtributo.ValorNulo(Dado: string): Boolean;
begin
  case Tipo of
    tpAlfanumerico, tpMemo:
      Result := Trim(Dado) = '';
    tpInteiro, tpFracionario:
      Result := (Trim(Dado) = '') or (StrToFloat(Trim(Dado)) = 0);
    tpData:
      Result := (Trim(Dado) = '') or (StrToDate(Trim(Dado)) = 0);
    tpImagem:
      Result := False;
    else
      Result := Trim(Dado) = '';
  end;
  Result := Not Result;
end;

procedure TAtributo.ConfiguraMascara;
var
  MascaraCmp: string;
  TipoAtr: TTipoDado;
  I: Integer;
begin
  MascaraCmp := Mascara;
  TipoAtr := Tipo;
  if MascaraCmp <> '' then
  begin
    for I := 1 to Length(MascaraCmp) do
      case MascaraCmp[I] of
        '9': MascaraCmp[I] := '0';
        'Z': MascaraCmp[I] := '#';
        'X': MascaraCmp[I] := 'C';
        'x': MascaraCmp[I] := 'c';
        '-': if TipoAtr in [tpInteiro, tpFracionario] then
               MascaraCmp[I] := '#';
        '.': if TipoAtr in [tpInteiro, tpFracionario] then
               MascaraCmp[I] := ',';
        ',': if TipoAtr in [tpInteiro, tpFracionario] then
               MascaraCmp[I] := '.'
      end;
    Valor.EditMask := MascaraCmp + ';0; ';
    case TipoCampo of
      ftSmallint: TSmallintField(Valor).DisplayFormat := MascaraCmp ;
      ftInteger: TIntegerField(Valor).DisplayFormat := MascaraCmp ;
      ftFloat: TFloatField(Valor).DisplayFormat := MascaraCmp ;
    end;
  end;
end;

function TAtributo.TipoCampo: TFieldType;
begin
  case Tipo of
    tpAlfanumerico:
      Result := ftString;
    tpInteiro:
      if Tamanho < 5 then
        Result := ftSmallint
      else if Tamanho < 10 then
        Result := ftInteger
      else
        Result := ftFloat;
    tpFracionario:
      Result := ftFloat;
    tpData:
      Result := ftDate;
    tpMemo:
      Result := ftMemo;
    tpImagem:
      Result := ftBlob;
    else
      Result := ftString;
  end;
end;

function TAtributo.TamanhoDado: Integer;
begin
  case Tipo of
    tpAlfanumerico, tpMemo, tpImagem:
      Result := Tamanho;
    tpInteiro, tpFracionario:
      Result := 0;
    tpData:
      Result := 0;
    else
      Result := Tamanho;
  end;
end;

function TAtributo.IndiceValorValido: Integer;
begin
  Result := ValorValido.IndexOf(Valor.AsString);
end;

procedure TAtributo.AtribuiIndice(Indice: Integer);
begin
  if (Indice < 0) or (Indice >= ValorValido.Count) then
    Valor.Clear
  else
    Valor.AsString := ValorValido[Indice];
end;

procedure TAtributo.IncluiValorValido(Valor, Descricao: string);
begin
  ValorValido.Add(Valor);
  DescValorValido.Add(Descricao);
end;

procedure TAtributo.MontaValoresValidos(Lista: TStrings);
var
  I: Integer;
begin
  for I := 0 to ValorValido.Count - 1 do
    Lista.Add(ValorValido[I]);
end;

procedure TAtributo.MontaDescValoresValidos(Lista: TStrings);
var
  I: Integer;
begin
  for I := 0 to DescValorValido.Count - 1 do
    Lista.Add(DescValorValido[I]);
end;

procedure TAtributo.IncluiValoresValidos;
begin
end;

destructor TListaCampos.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TObject(Items[I]).Free;
  inherited Destroy;
end;

function TListaCampos.ProcuraCampoED(Campo: TAtributo): Integer;
var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I := 0 to Count - 1 do
  begin
    CampoED := TCampoEdicao(Items[I]);
    if CampoED.Campo = Campo then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TListaCampos.ProcuraControle(Controle: TWinControl): Integer;
var
  I: Integer;
  CampoED: TCampoEdicao;
begin
  for I := 0 to Count - 1 do
  begin
    CampoED := TCampoEdicao(Items[I]);
    if CampoED.Controle = Controle then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

end.
