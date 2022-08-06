{
   Programa.: Atributo.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Atributo;

interface

{$I Princ.inc}

uses WinTypes, WinProcs, SysUtils, StdCtrls, Classes, Controls, ExtCtrls,
     {$IFDEF DELPHI5}{$ELSE}Variants,{$ENDIF}
     Publicas, db;

type
  TAtributo = class(TComponent)
  public
    Nome: String;
    Tipo: TTipoDado;
    Tamanho: Longint;
    CasasDecimais: Longint;
    TipoEdicao: TTipoEdicao;
    TipoSQL: String;
    SQL_Extra: String;
    Titulo: String;
    Mascara: String;
    CaractereEdicao: Char;
    Ajuda: String;
    Calculado: Boolean;
    Calculado_F: Boolean;
    Valor: TField;
    ValorValido: TStringList;
    DescValorValido: TStringList;
    Chave: Boolean;
    Index: Integer;
    Index_Default: Integer;
    Visible_Default: Boolean;
    AutoIncremento: Integer;
    SempreAtribui: Boolean;
    Incremento_Auto: Boolean;
    PreValidacao_ativa: Boolean;
    Acao: Integer;
    LimparCampo: Boolean;
    MensagemErro: String;
    Extra: Boolean;
    NomeTabela: String;
    NomeOriginal: String;
    TabEstrangeira: String;
    ChaveEstrangeira: String;
    CamposVisuais: String;
    EstiloPesquisa: Integer;
    AcaoPesquisa: Integer;
    FiltroFixo: TStringList;
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; virtual;
    function Valido(var MsgErro: string; EmSaida: Boolean = True): Boolean; virtual;
    function ValorNulo(Dado: string): Boolean; virtual;
    function PreValidacao: Boolean; virtual;
    procedure Clear;
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

uses Rotinas;

constructor TAtributo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ValorValido     := TStringList.Create;
  DescValorValido := TStringList.Create;
  FiltroFixo      := TStringList.Create;
end;

destructor TAtributo.Destroy;
begin
  ValorValido.Free;
  DescValorValido.Free;
  FiltroFixo.Free;
  inherited Destroy;
end;

procedure TAtributo.AtribuiValorPadrao;
begin
end;

function TAtributo.Valido(var MsgErro: string; EmSaida: Boolean = True): Boolean;
begin
  Result := True;
  MsgErro := '';
end;

function TAtributo.ValorNulo(Dado: string): Boolean;
begin
  case Tipo of
    tpAlfanumerico, tpMemo, tpVariant, tpWideString, tpString:
      Result := Trim(Dado) = '';
    tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD:
      Result := (Trim(Dado) = '') or (StrToFloat(Trim(Dado)) = 0);
    tpData, tpDateTime, tpDate:
      Result := (Trim(Dado) = '') or (StrToDate(Trim(Dado)) = 0);
    tpTime:
      Result := (Trim(Dado) = '') or (StrToTime(Trim(Dado)) = 0);
    tpImagem, tpGraphic, tpBlob:
      Result := False;
    else
      Result := Trim(Dado) = '';
  end;
  Result := Not Result;
end;

function TAtributo.PreValidacao: Boolean;
begin
  Result := True;
end;

procedure TAtributo.Clear;
begin
  Valor.Clear;
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
        '-': if TipoAtr in [tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD] then
               MascaraCmp[I] := '#';
        '.': if TipoAtr in [tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD] then
               MascaraCmp[I] := ',';
        ',': if TipoAtr in [tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpFloat, tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpBCD] then
               MascaraCmp[I] := '.'
      end;
    if (Tipo = tpData) or (Tipo = tpDateTime) or (Tipo = TpDate) then
      Valor.EditMask := MascaraCmp + ';1; '
    else
      Valor.EditMask := MascaraCmp + ';0; ';
    case TipoCampo of
      ftSmallint: begin
                    TSmallintField(Valor).DisplayFormat := MascaraCmp;
                    TSmallintField(Valor).EditFormat := MascaraCmp;
                    Valor.EditMask := '';
                  end;
      ftInteger:  begin
                    TIntegerField(Valor).DisplayFormat := MascaraCmp;
                    TIntegerField(Valor).EditFormat := MascaraCmp;
                    Valor.EditMask := '';
                  end;
      ftLargeInt: begin
                    TLargeintField(Valor).DisplayFormat := MascaraCmp;
                    TLargeintField(Valor).EditFormat := MascaraCmp;
                    Valor.EditMask := '';
                  end;
      ftAutoInc:  begin
                    TAutoIncField(Valor).DisplayFormat := MascaraCmp;
                    TAutoIncField(Valor).EditFormat := MascaraCmp;
                    Valor.EditMask := '';
                  end;
      ftWord:     begin
                    TWordField(Valor).DisplayFormat := MascaraCmp;
                    TWordField(Valor).EditFormat := MascaraCmp;
                    Valor.EditMask := '';
                  end;
      ftCurrency: begin
                    TCurrencyField(Valor).DisplayFormat := MascaraCmp;
                    TCurrencyField(Valor).EditFormat := TrocaString(MascaraCmp,',','',[rfReplaceAll]);
                    Valor.EditMask := '';
                  end;
      ftFloat:    begin
                    TFloatField(Valor).DisplayFormat := MascaraCmp;
                    TFloatField(Valor).EditFormat := TrocaString(MascaraCmp,',','',[rfReplaceAll]);
                    Valor.EditMask := '';
                  end;
    end;
    Valor.Index := Index;
  end;
end;

function TAtributo.TipoCampo: TFieldType;
begin
  case Tipo of
    tpAlfanumerico, tpString:
      Result := ftString;
    tpInteiro:
    begin
      if Tamanho < 5 then
        Result := ftSmallint
      else if Tamanho < 10 then
        Result := ftInteger
      else
        Result := ftFloat;
    end;
    tpInteger:
      Result := ftInteger;
    tpFracionario, tpFloat:
      Result := ftFloat;
    tpBCD:
      Result := ftBCD;
    tpData, tpDate:
      Result := ftDate;
    tpMemo:
      Result := ftMemo;
    tpImagem, tpBlob:
      Result := ftBlob;
    tpSmallint:
      Result := ftSmallint;
    tpWord:
      Result := ftWord;
    tpBoolean:
      Result := ftBoolean;
    tpCurrency:
      Result := ftCurrency;
    tpTime:
      Result := ftTime;
    tpBytes:
      Result := ftBytes;
    tpAutoInc:
      Result := ftAutoInc;
    tpGraphic:
      Result := ftGraphic;
    tpWideString:
      Result := ftWideString;
    tpLargeInt:
      Result := ftLargeInt;
    tpVariant:
      Result := ftVariant;
    else
      Result := ftString;
  end;
end;

function TAtributo.TamanhoDado: Integer;
begin
  case Tipo of
    tpInteiro, tpFracionario, tpSmallint, tpInteger, tpWord, tpBoolean, tpFloat,
    tpCurrency, tpBytes, tpAutoInc, tpLargeInt, tpData, tpDate, tpDateTime, tpTime:
      Result := 0;
    tpBCD:
       {$IFDEF IBX}
       Result := CasasDecimais;
       {$ELSE}
       Result := 0;
       {$ENDIF}
    else
      Result := Tamanho;
  end;
end;

function TAtributo.IndiceValorValido: Integer;
begin
  if Tipo = tpBoolean then
    Result := ValorValido.IndexOf(IIF(IIF(Valor.Value = Null, False, Valor.Value), '1', '0'))
  else
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
