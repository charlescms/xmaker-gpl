unit Estrutur;

interface

uses SysUtils, Classes, Publicas, Atributo, db, graphics, IBCustomDataSet;

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

implementation

uses StdCtrls, ExtCtrls, Rotinas;

constructor TTipoAlfanumerico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Valor := TIBStringField.Create(AOwner);
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

  function ValorIndice(Indice: Integer): string;
  begin
    if (Indice < 0) or (Indice >= ValorValido.Count) then
      Result := ''
    else
      Result := ValorValido[Indice];
  end;

begin
  {if Campo is TSCLookupCombo then
    DadoInt := TSCLookupCombo(Campo).Value
  else if Campo is TGetString then
    DadoInt := TGetString(Campo).Value
  else if Campo is TComboBox then
    DadoInt := TComboBox(Campo).Text
  else if Campo is TRadioGroup then
    DadoInt := ValorIndice(TRadioGroup(Campo).ItemIndex)
  else if Campo is TCheckBox then
    DadoInt := ValorIndice(Ord(not TCheckBox(Campo).Checked))
  else
    DadoInt := '';}
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

  function ValorIndice(Indice: Integer): Double;
  begin
    if (Indice < 0) or (Indice >= ValorValido.Count) then
      Result := 0
    else
      Result := StrToFloat(ValorValido[Indice]);
  end;

begin
  {if Campo is TSCLookupCombo then
    try
      DadoInt := StrToFloat(TSCLookupCombo(Campo).Value);
    except
      DadoInt := 0;
    end
  else if Campo is TGetNumber then
    DadoInt := TGetNumber(Campo).Value
  else if Campo is TComboBox then
    try
      DadoInt := StrToFloat(TComboBox(Campo).Text);
    except
      DadoInt := 0;
    end
  else if Campo is TRadioGroup then
    DadoInt := ValorIndice(TRadioGroup(Campo).ItemIndex)
  else if Campo is TCheckBox then
    DadoInt := ValorIndice(Ord(not TCheckBox(Campo).Checked))
  else
    DadoInt := 0;}
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

  function ValorIndice(Indice: Integer): Integer;
  begin
    if (Indice < 0) or (Indice >= ValorValido.Count) then
      Result := 0
    else
      Result := StrToInt(ValorValido[Indice]);
  end;

begin
  {if Campo is TSCLookupCombo then
    try
      DadoInt := StrToInt(TSCLookupCombo(Campo).Value);
    except
      DadoInt := 0;
    end
  else if Campo is TGetNumber then
    DadoInt := Trunc(TGetNumber(Campo).Value)
  else if Campo is TComboBox then
    try
      DadoInt := StrToInt(TComboBox(Campo).Text);
    except
      DadoInt := 0;
    end
  else if Campo is TRadioGroup then
    DadoInt := ValorIndice(TRadioGroup(Campo).ItemIndex)
  else if Campo is TCheckBox then
    DadoInt := ValorIndice(Ord(not TCheckBox(Campo).Checked))
  else
    DadoInt := 0;}
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

  function ValorIndice(Indice: Integer): Longint;
  begin
    if (Indice < 0) or (Indice >= ValorValido.Count) then
      Result := 0
    else
      Result := StrToInt(ValorValido[Indice]);
  end; 

begin
  {if Campo is TSCLookupCombo then
    try
      DadoInt := StrToInt(TSCLookupCombo(Campo).Value);
    except
      DadoInt := 0;
    end
  else if Campo is TGetNumber then
    DadoInt := Trunc(TGetNumber(Campo).Value)
  else if Campo is TComboBox then
    try
      DadoInt := StrToInt(TComboBox(Campo).Text);
    except
      DadoInt := 0;
    end
  else if Campo is TRadioGroup then
    DadoInt := ValorIndice(TRadioGroup(Campo).ItemIndex)
  else if Campo is TCheckBox then
    DadoInt := ValorIndice(Ord(not TCheckBox(Campo).Checked))
  else
    DadoInt := 0;}
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
var
  Aux: string;

  function ValorIndice(Indice: Integer): TDateTime;
  begin
    if (Indice < 0) or (Indice >= ValorValido.Count) then
      Result := 0
    else
      Result := StrToDate(ValorValido[Indice]);
  end;

begin
  {if Campo is TSCLookupCombo then
  begin
    Aux := TSCLookupCombo(Campo).Value;
    if DATAVALIDA(Aux) then
      DadoInt := StrToDate(Aux)
    else
    begin
      MsgErro := Format('Campo Inválido !', [Titulo]);
      Result := False;
      Exit;
    end;
  end
  else if Campo is TGetString then
  begin
    Aux := TGetString(Campo).Value;
    if DATAVALIDA(Aux) then
      DadoInt := StrToDate(Copy(Aux, 1, 2) + '/' +
        Copy(Aux, 3, 2) + '/' + Copy(Aux, 5, 4))
    else
    begin
      MsgErro := Format('Campo Inválido !', [Titulo]);
      Result := False;
      Exit;
    end;
  end
  else if Campo is TComboBox then
    DadoInt := StrToDate(TComboBox(Campo).Text)
  else if Campo is TRadioGroup then
    DadoInt := ValorIndice(TRadioGroup(Campo).ItemIndex)
  else if Campo is TCheckBox then
    DadoInt := ValorIndice(Ord(not TCheckBox(Campo).Checked))
  else
    DadoInt := 0;}
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

end.

