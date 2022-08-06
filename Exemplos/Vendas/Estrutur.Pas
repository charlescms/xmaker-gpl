{
   Programa.: Estrutur.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Estrutur;

interface

{$I Princ.inc}

uses SysUtils, Classes, Publicas, Atributo, db,
    {$IFDEF DELPHI5}{$ELSE}Variants,{$ENDIF}
    {$IFDEF IBX}
    IBCustomDataSet,
    {$ENDIF}
    graphics, Controls;

type
  TTipoAlfanumerico = class(TAtributo)
  public
    DadoInt: string;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: string);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: string; virtual;
    function ValorString: string;
    function ConsultaValor: string;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: string read ConsultaValor write AtribuiValor;
  end;

  TTipoFracionario = class(TAtributo)
  public
    DadoInt: Double;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Double);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Double; virtual;
    function ValorString: string;
    function ConsultaValor: Double;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Double read ConsultaValor write AtribuiValor;
  end;

  TTipoBCD = class(TAtributo)
  public
    DadoInt: Currency;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Currency);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Currency; virtual;
    function ValorString: string;
    function ConsultaValor: Currency;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Currency read ConsultaValor write AtribuiValor;
  end;

  TTipoInteiro = class(TAtributo)
  public
    DadoInt: LongInt;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: LongInt);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: LongInt; virtual;
    function ValorString: string;
    function ConsultaValor: LongInt;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: LongInt read ConsultaValor write AtribuiValor;
  end;

  TTipoPInteiro = class(TAtributo)
  public
    DadoInt: Integer;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Integer);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Integer; virtual;
    function ValorString: string;
    function ConsultaValor: Integer;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Integer read ConsultaValor write AtribuiValor;
  end;

  TTipoData = class(TAtributo)
  public
    DadoInt: TDateTime;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TDateTime);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: TDateTime; virtual;
    function ValorString: string;
    function ConsultaValor: TDateTime;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: TDateTime read ConsultaValor write AtribuiValor;
  end;

  TTipoMemo = class(TAtributo)
  public
    DadoInt: TStringList;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TStringList);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: string; virtual;
    function ValorString: string;
    function ConsultaValor: TStringList;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: TStringList read ConsultaValor write AtribuiValor;
  end;

  TTipoImagem = class(TAtributo)
  public
    DadoInt: TBitMap;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TBitMap);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: TBitMap; virtual;
    function ValorString: string;
    function ConsultaValor: TBitMap;
    property Conteudo: TBitMap read ConsultaValor write AtribuiValor;
  end;

  TTipoString = class(TAtributo)
  public
    DadoInt: String;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: String);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: String; virtual;
    function ValorString: string;
    function ConsultaValor: String;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: String read ConsultaValor write AtribuiValor;
  end;

  TTipoSmallint = class(TAtributo)
  public
    DadoInt: Smallint;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Smallint);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Smallint; virtual;
    function ValorString: string;
    function ConsultaValor: Smallint;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Smallint read ConsultaValor write AtribuiValor;
  end;

  TTipoWord = class(TAtributo)
  public
    DadoInt: Word;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Word);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Word; virtual;
    function ValorString: string;
    function ConsultaValor: Word;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Word read ConsultaValor write AtribuiValor;
  end;

  TTipoBoolean = class(TAtributo)
  public
    DadoInt: Boolean;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Boolean);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Boolean; virtual;
    function ValorString: string;
    function ConsultaValor: Boolean;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Boolean read ConsultaValor write AtribuiValor;
  end;

  TTipoCurrency = class(TAtributo)
  public
    DadoInt: Currency;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Currency);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Currency; virtual;
    function ValorString: string;
    function ConsultaValor: Currency;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Currency read ConsultaValor write AtribuiValor;
  end;

  TTipoDate = class(TAtributo)
  public
    DadoInt: TDate;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TDate);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: TDate; virtual;
    function ValorString: string;
    function ConsultaValor: TDate;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: TDate read ConsultaValor write AtribuiValor;
  end;

  TTipoTime = class(TAtributo)
  public
    DadoInt: TTime;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TTime);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: TTime; virtual;
    function ValorString: string;
    function ConsultaValor: TTime;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: TTime read ConsultaValor write AtribuiValor;
  end;

  TTipoBytes = class(TAtributo)
  public
    DadoInt: Byte;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Byte);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Byte; virtual;
    function ValorString: string;
    function ConsultaValor: Byte;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Byte read ConsultaValor write AtribuiValor;
  end;

  TTipoAutoInc = class(TAtributo)
  public
    DadoInt: Integer;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Integer);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Integer; virtual;
    function ValorString: string;
    function ConsultaValor: Integer;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Integer read ConsultaValor write AtribuiValor;
  end;

  TTipoBlob = class(TAtributo)
  public
    DadoInt: TBlobData;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TBlobData);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: TBlobData; virtual;
    function ValorString: string;
    function ConsultaValor: TBlobData;
    property Conteudo: TBlobData read ConsultaValor write AtribuiValor;
  end;

  TTipoGraphic = class(TAtributo)
  public
    DadoInt: TGraphic;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: TGraphic);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: TGraphic; virtual;
    function ValorString: string;
    function ConsultaValor: TGraphic;
    property Conteudo: TGraphic read ConsultaValor write AtribuiValor;
  end;

  TTipoWideString = class(TAtributo)
  public
    DadoInt: WideString;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: WideString);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: WideString; virtual;
    function ValorString: Widestring;
    function ConsultaValor: WideString;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: WideString read ConsultaValor write AtribuiValor;
  end;

  TTipoLargeInt = class(TAtributo)
  public
    DadoInt: LongInt;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: LongInt);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: LongInt; virtual;
    function ValorString: String;
    function ConsultaValor: LongInt;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: LongInt read ConsultaValor write AtribuiValor;
  end;

  TTipoVariant = class(TAtributo)
  public
    DadoInt: Variant;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Variant);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Variant; virtual;
    function ValorString: String;
    function ConsultaValor: Variant;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Variant read ConsultaValor write AtribuiValor;
  end;

  TTipoInteger = class(TAtributo)
  public
    DadoInt: Integer;
    ValidacaoExt: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AtribuiValorPadrao; override;
    procedure AtribuiValor(Dado: Integer);
    function ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
    function ValorPadrao: Integer; virtual;
    function ValorString: string;
    function ConsultaValor: Integer;
    procedure GetText(Sender: TField; var Text:
      string; DisplayText: Boolean);
    property Conteudo: Integer read ConsultaValor write AtribuiValor;
  end;

implementation

uses StdCtrls, ExtCtrls, Rotinas, Validar;

constructor TTipoAlfanumerico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TStringField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoAlfanumerico.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoAlfanumerico.ValorPadrao: string;
begin
  ValorPadrao := '';
end;

procedure TTipoAlfanumerico.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoAlfanumerico.AtribuiValor(Dado: string);
begin
  Valor.AsString := Dado;
end;

function TTipoAlfanumerico.ConsultaValor: string;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoAlfanumerico.ValorString: string;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoAlfanumerico.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoAlfanumerico.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoFracionario.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TFloatField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoFracionario.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoFracionario.ValorPadrao: Double;
begin
  ValorPadrao := 0;
end;

procedure TTipoFracionario.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoFracionario.AtribuiValor(Dado: Double);
begin
  Valor.AsFloat := Dado;
end;

function TTipoFracionario.ConsultaValor: Double;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsFloat;
end;

function TTipoFracionario.ValorString: string;
begin
  if ValidacaoExt then
    Result := FloatToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoFracionario.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoFracionario.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoBCD.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF IBX}
  Valor := TIBBCDField.Create(AOwner);
  {$ELSE}
  Valor := TCurrencyField.Create(AOwner);
  {$ENDIF}
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoBCD.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoBCD.ValorPadrao: Currency;
begin
  ValorPadrao := 0;
end;

procedure TTipoBCD.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoBCD.AtribuiValor(Dado: Currency);
begin
  Valor.AsCurrency := Dado;
end;

function TTipoBCD.ConsultaValor: Currency;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsFloat;
end;

function TTipoBCD.ValorString: string;
begin
  if ValidacaoExt then
    Result := FloatToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoBCD.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoBCD.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoInteiro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TIntegerField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoInteiro.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoInteiro.ValorPadrao: LongInt;
begin
  ValorPadrao := 0;
end;

procedure TTipoInteiro.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoInteiro.AtribuiValor(Dado: LongInt);
begin
  Valor.AsInteger := Dado;
end;

function TTipoInteiro.ConsultaValor: LongInt;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoInteiro.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoInteiro.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoInteiro.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoPInteiro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TSmallintField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoPInteiro.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoPInteiro.ValorPadrao: Integer;
begin
  ValorPadrao := 0;
end;

procedure TTipoPInteiro.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoPInteiro.AtribuiValor(Dado: Integer);
begin
  Valor.AsInteger := Dado;
end;

function TTipoPInteiro.ConsultaValor: Integer;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end; 

function TTipoPInteiro.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end; 

function TTipoPInteiro.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoPInteiro.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TDateTimeField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoData.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end; 

function TTipoData.ValorPadrao: TDateTime;
begin
  ValorPadrao := 0;
end; 

procedure TTipoData.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end; 

procedure TTipoData.AtribuiValor(Dado: TDateTime);
begin
  if Dado = 0 then
    Valor.Clear
  else
    Valor.AsDateTime := Dado;
end; 

function TTipoData.ConsultaValor: TDateTime;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsDateTime;
end; 

function TTipoData.ValorString: string;
begin
  if ValidacaoExt then
    Result := DateToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoData.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoData.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end; 

constructor TTipoMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TMemoField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  DadoInt := TStringList.Create;
  IncluiValoresValidos;
end; 

destructor TTipoMemo.Destroy;
begin
  Valor.Free;
  DadoInt.Free;
  inherited Destroy;
end; 

function TTipoMemo.ValorPadrao: string;
begin
  ValorPadrao := '';
end; 

procedure TTipoMemo.AtribuiValorPadrao;
var
  Temp: TStringList;
begin
  Temp := TStringList.Create;
  if ValorPadrao <> '' then
    Temp.Add(ValorPadrao);
  (Valor as TMemoField).Assign(Temp);
  Temp.Free;
end; 

procedure TTipoMemo.AtribuiValor(Dado: TStringList);
begin
  Valor.Assign(Dado);
end; 

function TTipoMemo.ConsultaValor: TStringList;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
  begin
    DadoInt.Assign(Valor as TMemoField);
    Result := DadoInt;
  end;
end; 

function TTipoMemo.ValorString: string;
begin
  if ValidacaoExt then
    Result := DadoInt[0]
  else
    Result := Valor.AsString;
end; 

function TTipoMemo.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  if Campo is TMemo then
    DadoInt.Assign(TMemo(Campo).Lines);
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoMemo.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoImagem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TBlobField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  DadoInt := TBitMap.Create;
  IncluiValoresValidos;
end;

destructor TTipoImagem.Destroy;
begin
  Valor.Free;
  DadoInt.Free;
  inherited Destroy;
end;

function TTipoImagem.ValorPadrao: TBitMap;
begin
  ValorPadrao := nil;
end;

procedure TTipoImagem.AtribuiValorPadrao;
var
  BitMap: TBitMap;
begin
  BitMap := ValorPadrao;
  Valor.Assign(BitMap);
  BitMap.Free;
end;

procedure TTipoImagem.AtribuiValor(Dado: TBitMap);
begin
  Valor.Assign(Dado);
end;

function TTipoImagem.ConsultaValor: TBitMap;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
  begin
    DadoInt.Assign(Valor as TBlobField);
    Result := DadoInt;
  end;
end;

function TTipoImagem.ValorString: string;
begin
  Result := '';
end;

function TTipoImagem.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  if Campo is TImage then
    DadoInt := TImage(Campo).Picture.BitMap;
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

constructor TTipoString.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TStringField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoString.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoString.ValorPadrao: String;
begin
  ValorPadrao := '';
end;

procedure TTipoString.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoString.AtribuiValor(Dado: String);
begin
  Valor.AsString := Dado;
end;

function TTipoString.ConsultaValor: String;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoString.ValorString: string;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoString.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoString.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoSmallInt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TSmallIntField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoSmallInt.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoSmallInt.ValorPadrao: SmallInt;
begin
  ValorPadrao := 0;
end;

procedure TTipoSmallInt.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoSmallInt.AtribuiValor(Dado: SmallInt);
begin
  Valor.AsInteger := Dado;
end;

function TTipoSmallInt.ConsultaValor: SmallInt;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoSmallInt.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoSmallInt.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoSmallInt.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoWord.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TWordField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoWord.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoWord.ValorPadrao: Word;
begin
  ValorPadrao := 0;
end;

procedure TTipoWord.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoWord.AtribuiValor(Dado: Word);
begin
  Valor.AsInteger := Dado;
end;

function TTipoWord.ConsultaValor: Word;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoWord.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoWord.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoWord.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoBoolean.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TBooleanField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoBoolean.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoBoolean.ValorPadrao: Boolean;
begin
  ValorPadrao := False;
end;

procedure TTipoBoolean.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoBoolean.AtribuiValor(Dado: Boolean);
begin
  Valor.AsBoolean := Dado;
end;

function TTipoBoolean.ConsultaValor: Boolean;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsBoolean;
end;

function TTipoBoolean.ValorString: string;
begin
  if ValidacaoExt then
    Result := IIF(DadoInt, '0', '1')
  else
    Result := Valor.AsString;
end;

function TTipoBoolean.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoBoolean.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoCurrency.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TCurrencyField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoCurrency.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoCurrency.ValorPadrao: Currency;
begin
  ValorPadrao := 0;
end;

procedure TTipoCurrency.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoCurrency.AtribuiValor(Dado: Currency);
begin
  Valor.AsCurrency := Dado;
end;

function TTipoCurrency.ConsultaValor: Currency;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsCurrency;
end;

function TTipoCurrency.ValorString: string;
begin
  if ValidacaoExt then
    Result := FloatToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoCurrency.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoCurrency.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoDate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TDateField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoDate.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoDate.ValorPadrao: TDate;
begin
  ValorPadrao := 0;
end;

procedure TTipoDate.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoDate.AtribuiValor(Dado: TDate);
begin
  Valor.AsDateTime := Dado;
end;

function TTipoDate.ConsultaValor: TDate;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsDateTime;
end;

function TTipoDate.ValorString: string;
begin
  if ValidacaoExt then
    Result := DateToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoDate.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoDate.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoTime.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TTimeField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoTime.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoTime.ValorPadrao: TTime;
begin
  ValorPadrao := 0;
end;

procedure TTipoTime.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoTime.AtribuiValor(Dado: TTime);
begin
  Valor.AsDateTime := Dado;
end;

function TTipoTime.ConsultaValor: TTime;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsDateTime;
end;

function TTipoTime.ValorString: string;
begin
  if ValidacaoExt then
    Result := TimeToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoTime.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoTime.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoBytes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TBytesField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoBytes.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoBytes.ValorPadrao: Byte;
begin
  ValorPadrao := 0;
end;

procedure TTipoBytes.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoBytes.AtribuiValor(Dado: Byte);
begin
  Valor.AsDateTime := Dado;
end;

function TTipoBytes.ConsultaValor: Byte;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoBytes.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoBytes.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoBytes.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoAutoInc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TAutoIncField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoAutoInc.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoAutoInc.ValorPadrao: Integer;
begin
  ValorPadrao := 0;
end;

procedure TTipoAutoInc.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoAutoInc.AtribuiValor(Dado: Integer);
begin
  Valor.AsInteger := Dado;
end;

function TTipoAutoInc.ConsultaValor: Integer;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoAutoInc.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoAutoInc.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoAutoInc.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoBlob.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TBlobField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoBlob.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoBlob.ValorPadrao: TBlobData;
begin
  ValorPadrao := '';
end;

procedure TTipoBlob.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoBlob.AtribuiValor(Dado: TBlobData);
begin
  Valor.AsVariant := Dado;
end;

function TTipoBlob.ConsultaValor: TBlobData;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoBlob.ValorString: string;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoBlob.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

constructor TTipoGraphic.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TGraphicField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  DadoInt := TGraphic.Create;
  IncluiValoresValidos;
end;

destructor TTipoGraphic.Destroy;
begin
  Valor.Free;
  DadoInt.Free;
  inherited Destroy;
end;

function TTipoGraphic.ValorPadrao: TGraphic;
begin
  ValorPadrao := nil;
end;

procedure TTipoGraphic.AtribuiValorPadrao;
var
  BitMap: TGraphic;
begin
  BitMap := ValorPadrao;
  Valor.Assign(BitMap);
  BitMap.Free;
end;

procedure TTipoGraphic.AtribuiValor(Dado: TGraphic);
begin
  Valor.Assign(Dado);
end;

function TTipoGraphic.ConsultaValor: TGraphic;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
  begin
    DadoInt.Assign(Valor as TBlobField);
    Result := DadoInt;
  end;
end;

function TTipoGraphic.ValorString: string;
begin
  Result := '';
end;

function TTipoGraphic.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  if Campo is TImage then
    DadoInt := TImage(Campo).Picture.BitMap;
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

constructor TTipoWideString.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TWideStringField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoWideString.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoWideString.ValorPadrao: WideString;
begin
  ValorPadrao := '';
end;

procedure TTipoWideString.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoWideString.AtribuiValor(Dado: WideString);
begin
  Valor.AsString := Dado;
end;

function TTipoWideString.ConsultaValor: WideString;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoWideString.ValorString: WideString;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsString;
end;

function TTipoWideString.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoWideString.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoLargeInt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TLargeintField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoLargeInt.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoLargeInt.ValorPadrao: LongInt;
begin
  ValorPadrao := 0;
end;

procedure TTipoLargeInt.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoLargeInt.AtribuiValor(Dado: LongInt);
begin
  Valor.AsInteger := Dado;
end;

function TTipoLargeInt.ConsultaValor: LongInt;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoLargeInt.ValorString: String;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoLargeInt.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoLargeInt.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoVariant.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TVariantField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoVariant.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoVariant.ValorPadrao: Variant;
begin
  ValorPadrao := Null;
end;

procedure TTipoVariant.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoVariant.AtribuiValor(Dado: Variant);
begin
  Valor.AsInteger := Dado;
end;

function TTipoVariant.ConsultaValor: Variant;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsVariant;
end;

function TTipoVariant.ValorString: String;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoVariant.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoVariant.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

constructor TTipoInteger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TIntegerField.Create(AOwner);
  Valor.FieldName := Nome;
  Valor.Size := TamanhoDado;
  Valor.DisplayLabel := Titulo;
  Valor.Calculated := Calculado;
  ValidacaoExt := False;
  IncluiValoresValidos;
end;

destructor TTipoInteger.Destroy;
begin
  Valor.Free;
  inherited Destroy;
end;

function TTipoInteger.ValorPadrao: Integer;
begin
  ValorPadrao := 0;
end;

procedure TTipoInteger.AtribuiValorPadrao;
begin
  Conteudo := ValorPadrao;
end;

procedure TTipoInteger.AtribuiValor(Dado: Integer);
begin
  Valor.AsInteger := Dado;
end;

function TTipoInteger.ConsultaValor: Integer;
begin
  if ValidacaoExt then
    Result := DadoInt
  else
    Result := Valor.AsInteger;
end;

function TTipoInteger.ValorString: string;
begin
  if ValidacaoExt then
    Result := IntToStr(DadoInt)
  else
    Result := Valor.AsString;
end;

function TTipoInteger.ValidaCampo(Campo: TComponent; var MsgErro: string): Boolean;
begin
  ValidacaoExt := True;
  Result := Valido(MsgErro);
  ValidacaoExt := False;
end;

procedure TTipoInteger.GetText(Sender: TField; var Text:
  string; DisplayText: Boolean);
var
  Ind: Integer;
begin
  if DisplayText then
  begin
    Ind := Indice;
    if Ind <= -1 then
      Text := ''
    else if DescValorValido[Ind] <> '' then
      Text := DescValorValido[Ind]
    else
      Text := ValorValido[Ind];
  end
  else
    Text := Sender.AsString;
end;

end.


