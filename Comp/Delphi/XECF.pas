{
   Programa.: XECF.Pas
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit XECF;

interface

uses Classes, Sysutils, SynaSer, SynaUtil;

const
  msg_ImpressoraDesligadaOuDesconectada = '800|Impressora Desligada ou Desconectada !';
  msg_ErroAoEnviarComando = '801|Erro ao enviar comando: %s';
  msg_NaoHouveResposta = '802|Não Houve resposta ao envio';
  msg_SemPapel = '803|Impressora sem papel';

  msg_ErroGravarDispositivo = '900|Erro ao gravar no dispositivo de saida.';
  msg_ComandoNaoImplementado = '901|Comando não implementado nesta ecf (%s)';

type
  TModelo = (ecf_Nenhuma, ecf_Bematech_MP20_FI_II,
             ecf_Bematech_MP25_FI_II, ecf_Bematech_MP40_FI_II, ecf_Sweda, ecf_Daruma_FS345,
             ecf_Urano_1EFC);
  TEstado = (st_Dia_Aberto, st_Dia_Fechado, st_Venda_Aberta, st_Sem_Papel);

  TEventoDeErro = procedure (aNumero: Integer; Mensagem: string; var Repetir: Boolean) of object;

  TItem_Venda = class
  public
    Codigo: String;
    Descricao: String;
    Unidade: String;
    Valor: Currency;
    Quantidade: Real;
    Total: Currency;
    Desconto: Currency;
    Tres_Decimais: Boolean;
    Aliquota: String;
    Sequencia: Integer;
  end;

  TComandos = class(TComponent)
  private
    fErro: TEventoDeErro;
    fItem: TItem_Venda;
    fCNPJ_CPF: String;
    fDesconto: Currency;
    fAcrescimo: Currency;
    fRodape_1: String;
    fRodape_2: String;
    fRodape_3: String;
    fRodape_4: String;
    procedure SetCNPJ_CPF(Value: String);
    procedure SetDesconto(Value: Currency);
    procedure SetAcrescimo(Value: Currency);
    procedure SetRodape_1(Value: String);
    procedure SetRodape_2(Value: String);
    procedure SetRodape_3(Value: String);
    procedure SetRodape_4(Value: String);
  protected
    fUltimoComando: string;
    fUltimoTamanhoEsperado: Integer;
    fUltimaResposta: string;
    fPortaSerial: TBlockSerial;
    function GetLigada: Boolean; virtual;
    function GetUltimoComando: string; virtual;
    function GetUltimoTamanhoEsperado: Integer; virtual;
    function GetUltimaResposta: string; virtual;
    function GetPortaSerial: TBlockSerial;
    function GetErroProc: TEventoDeErro; virtual;
    procedure SetErroProc(const Value: TEventoDeErro); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Executa_Comando(xComando: string; TamanhoRetorno: Integer = 0): Boolean; dynamic; abstract;
    function Estado: TEstado; dynamic; abstract;
    function Em_Horario_Verao: boolean; dynamic; abstract;
    function CNPJ: String; dynamic; abstract;
    function Inscricao_Estadual: String; dynamic; abstract;
    function Numero_Serie: String; dynamic; abstract;
    function Numero_Cupom: Integer; dynamic; abstract;
    function Numero_Ultimo_Cupom: Integer; dynamic; abstract;
    function Numero_Caixa: Integer; dynamic; abstract;
    function Numero_Loja: Integer; dynamic; abstract;
    function Data_Atual: TDateTime; dynamic; abstract;
    function Data_Fiscal: TDateTime; dynamic; abstract;
    function Contador_Reducoes: Integer; dynamic; abstract;
    function Numero_Cancelamentos: Integer; dynamic; abstract;
    function Total_Cancelamentos: Currency; dynamic; abstract;
    function Total_Descontos: Currency; dynamic; abstract;
    function Abrir_Dia: Boolean; dynamic; abstract;
    function Abrir_Venda: Boolean; dynamic; abstract;
    function Vender_Item: Boolean; dynamic; abstract;
    function Cancelar_Item: Boolean; dynamic; abstract;
    function Imp_Acrescimo_Desconto: Boolean; dynamic; abstract;
    function Forma_Pagto(xDescricao: String; xValor: Currency): Boolean; dynamic; abstract;
    function Fechar_Venda: Boolean; dynamic; abstract;
    function Cancelar_Venda: Boolean; dynamic; abstract;
    function LeituraX(xOperador: String):Boolean; dynamic; abstract;
    function ReducaoZ(xOperador: String):Boolean; dynamic; abstract;
    function Horario_Verao:Boolean; dynamic; abstract;
    function Leitura_MF_Por_Data(xDe: TDateTime; xAte: TDateTime; xGeraArq: String = ''): Boolean; dynamic; abstract;
    function Leitura_MF_Por_Reducao(xDe: Integer; xAte: Integer; xGeraArq: String = ''): Boolean; dynamic; abstract;
    function Programar_Aliquotas(xPercentual: Currency; xISS: Boolean): Boolean; dynamic; abstract;
    function Suprimento_de_Caixa(xValor: Currency): Boolean; dynamic; abstract;
    function Sangria_de_Caixa(xValor: Currency): Boolean; dynamic; abstract;
    function Abrir_Gaveta: Boolean; dynamic; abstract;
    function GerarErro(aMensagem:string): Boolean; virtual;
    function DescreverErro(aErro: Integer): string;
    property PortaSerial: TBlockSerial read GetPortaSerial;
    procedure EnviarString(aExpressao: string);
    function LerByte(TimeOut: integer = 0): Byte;
    function LerStringTamanho(aTamanho: integer; TimeOut: integer = 0): string;
    function VerificarBIT(aByte: Byte; aNumeroDoBit: integer): Boolean;
    function LerStringSufixo(TimeOut: integer = 0; aSufixo: string = #13#10): string;
  published
    property OnErro:TEventoDeErro read GetErroProc write SetErroProc;
    property UltimoComandoEnviado: string read GetUltimoComando;
    property UltimoTamanhoEsperado: Integer read GetUltimoTamanhoEsperado;
    property UltimaResposta: string read GetUltimaResposta;
    property Ligada: Boolean read GetLigada;
    property Item: TItem_Venda read fItem;
    property CNPJ_CPF: String read fCNPJ_CPF write SetCNPJ_CPF;
    property Desconto: Currency read FDesconto write SetDesconto;
    property Acrescimo: Currency read FAcrescimo write SetAcrescimo;
    property Rodape_1: String read fRodape_1 write SetRodape_1;
    property Rodape_2: String read fRodape_2 write SetRodape_2;
    property Rodape_3: String read fRodape_3 write SetRodape_3;
    property Rodape_4: String read fRodape_4 write SetRodape_4;
  end;

  TXECF = class(TComponent)
  private
    fModelo: TModelo;
    fComando: TComandos;
    fPorta: String;
    fVelocidade: Integer;
    fDataBits: Byte;
    fParidade: Char;
    fStopBits: Integer;
    fSoftFlow: Boolean;
    fHardFlow: Boolean;
    fPooling: Integer;
    procedure Ativar;
    procedure Desativar;
    function GetECF: TComandos;
    procedure SetModelo(const Value: TModelo);
    procedure SetPorta(Value: String);
    procedure SetVelocidade(Value: Integer);
    procedure SetDataBits(Value: Byte);
    procedure SetParidade(Value: Char);
    procedure SetStopBits(Value: Integer);
    procedure SetSoftFlow(Value: Boolean);
    procedure SetHardFlow(Value: Boolean);
    procedure SetPooling(Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Comando: TComandos read GetECF;
    property DataBits: Byte read fDataBits write SetDataBits default 7;
    property Modelo: TModelo read FModelo write SetModelo;
    property Paridade: Char read fParidade write SetParidade;
    property Pooling: Integer read fPooling write SetPooling default 1000;
    property Porta: String read fPorta write SetPorta;
    property StopBits: Integer read fStopBits write SetStopBits;
    property Velocidade: Integer read fVelocidade write SetVelocidade default 9600;
    property SoftFlow: Boolean read fSoftFlow write SetSoftFlow default False;
    property HardFlow: Boolean read fHardFlow write SetHardFlow default False;
end;

procedure Register;

implementation

uses XECF_Bematech_MP20_FI_II, XECF_Bematech_MP25_FI_II, XECF_Bematech_MP40_FI_II, XECF_Daruma_FS345;

// Componente: TXECF ...

constructor TXECF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModelo := ecf_Bematech_MP20_FI_II;
  fComando := TECF_Bematech_MP20_FI_II.Create(Self);
  fDataBits := 8;
  fParidade := 'N';
  fPooling := 1000;
  fPorta := 'COM2';
  fStopBits := 0;
  fVelocidade := 9600;
  fSoftFlow := False;
  fHardFlow := True;
  Ativar;
end;

destructor TXECF.Destroy;
begin
  if Assigned(fComando) then
  begin
    Desativar;
    fComando.Free;
  end;
  inherited;
end;

procedure TXECF.Ativar;
begin
  if Assigned(fComando) then
  begin
    fComando.fPortaSerial.Connect(fPorta);
    fComando.fPortaSerial.Config(fVelocidade, fDatabits, fParidade, fStopBits, fSoftFlow, fHardFlow);
  end;  
end;

procedure TXECF.Desativar;
begin
  if Assigned(fComando) then
    fComando.fPortaSerial.CloseSocket;
end;

function TXECF.GetECF: TComandos;
begin
  if not Assigned(fComando) then
    raise Exception.Create('Impressora Fiscal não está configurada !');
  Result := fComando;
end;

procedure TXECF.SetModelo(const Value: TModelo);
begin
  if fModelo <> Value then
  begin
    if Assigned(fComando) then
      fComando.Free;
    case Value of
      ecf_Nenhuma:
        fComando := Nil;
      ecf_Bematech_MP20_FI_II:
        fComando := TECF_Bematech_MP20_FI_II.Create(Self);
      ecf_Bematech_MP25_FI_II:
        fComando := TECF_Bematech_MP25_FI_II.Create(Self);
      ecf_Bematech_MP40_FI_II:
        fComando := TECF_Bematech_MP40_FI_II.Create(Self);
      ecf_Sweda:
        fComando := Nil; //TECF_Sweda.Create(Self);
      ecf_Daruma_FS345:
        fComando := TECF_Daruma_FS345.Create(Self);
      ecf_Urano_1EFC:
        fComando := Nil; //TECF_Urano_1EFC.Create(Self);
    else
      fComando := Nil;
    end;
    fModelo := Value;
    if Assigned(fComando) then
    begin
      Desativar;
      Ativar;
    end; 
  end;
end;

procedure TXECF.SetPorta(Value: String);
begin
  fPorta := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetVelocidade(Value: Integer);
begin
  fVelocidade := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetDataBits(Value: Byte);
begin
  fDataBits := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetParidade(Value: Char);
begin
  fParidade := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetStopBits(Value: Integer);
begin
  fStopBits := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetSoftFlow(Value: Boolean);
begin
  fSoftFlow := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetHardFlow(Value: Boolean);
begin
  fHardFlow := Value;
  Desativar;
  Ativar;
end;

procedure TXECF.SetPooling(Value: Integer);
begin
  fPooling := Value;
  Desativar;
  Ativar;
end;

// Componente: TComandos ...

constructor TComandos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fPortaSerial := TBlockSerial.Create;
  fItem := TItem_Venda.Create;
  fCNPJ_CPF := '';
  fDesconto := 0;
  fAcrescimo:= 0;
  fRodape_1 := '';
  fRodape_2 := '';
  fRodape_3 := '';
  fRodape_4 := '';
end;

destructor TComandos.Destroy;
begin
  if Assigned(fPortaSerial) then
    fPortaSerial.Free;
  if Assigned(fItem) then
    fItem.Free;
  inherited;
end;

function TComandos.GetUltimoComando: string;
begin
  Result := fUltimoComando;
end;

function TComandos.GetUltimoTamanhoEsperado: Integer;
begin
  Result := fUltimoTamanhoEsperado;
end;

function TComandos.GetUltimaResposta: string;
begin
  Result := fUltimaResposta;
end;

function TComandos.GetLigada: Boolean;
begin
  fUltimoComando := '';
  GerarErro(format(msg_ComandoNaoImplementado,['Ligada']));
  Result := False;
end;

function TComandos.GerarErro(aMensagem:string): Boolean;
var
  Repetir: boolean;
  Num: Integer;
  Msg: string;
begin
  Msg := copy(aMensagem,pos('|',aMensagem)+1, 255);
  Num := StrToIntDef(copy(aMensagem, 1, pos('|',aMensagem)-1),-1);
  if Assigned(fErro) and (UltimoComandoEnviado <> '') then
  begin
    Repetir := False;
    fErro(Num, Msg, Repetir);
  end
  else
  begin
    Repetir := False;
    raise Exception.Create(Msg);
  end;
  if Repetir then
    Result := Executa_Comando(UltimoComandoEnviado, UltimoTamanhoEsperado)
  else
    Result := False;
end;

function TComandos.DescreverErro(aErro: Integer): string;
begin
  Result:= '';
  case aErro of
    sOK:               Result := 'OK';
    ErrAlreadyOwned:   Result := 'Porta em uso por outro processo';
    ErrAlreadyInUse:   Result := 'Instância já em uso';
    ErrWrongParameter: Result := 'Erro de parâmetros na chamada';
    ErrPortNotOpen:    Result := 'Dispositivo ainda não está conectado';
    ErrNoDeviceAnswer: Result := 'Nenhuma resposta do dispositivo detectada';
    ErrMaxBuffer:      Result := 'Tamanho máximo do buffer atingido';
    ErrTimeout:        Result := 'Timeout durante a operação';
    ErrNotRead:        Result := 'Leitura dos dados falhou';
    ErrFrame:          Result := 'Receive framing error';
    ErrOverrun:        Result := 'Receive Overrun Error';
    ErrRxOver:         Result := 'Fila de recepção sobrecarregada';
    ErrRxParity:       Result := 'Recebido erro de Paridade';
    ErrTxFull:         Result := 'Fila de envio está cheia';
  end;
end;

function TComandos.GetPortaSerial: TBlockSerial;
begin
  Result := fPortaSerial;
end;

procedure TComandos.EnviarString(aExpressao: string);
begin
  PortaSerial.SendString(aExpressao);
end;

function TComandos.LerByte(TimeOut: integer): Byte;
begin
  Result := PortaSerial.RecvByte(TimeOut);
end;

function TComandos.LerStringTamanho(aTamanho, TimeOut: integer): string;
begin
  Result := PortaSerial.RecvBufferStr(aTamanho, TimeOut);
end;

function TComandos.VerificarBIT(aByte: Byte; aNumeroDoBit: integer): Boolean;
begin
  Result := (aByte and (1 shl (aNumeroDoBit mod 8))) <> 0;
end;

function TComandos.LerStringSufixo(TimeOut: integer; aSufixo: string): string;
begin
  Result := PortaSerial.RecvTerminated(TimeOut, aSufixo);
  if PortaSerial.LastError = 0 then
    Result := result + aSufixo;
end;

function TComandos.GetErroProc: TEventoDeErro;
begin
  Result := fErro;
end;

procedure TComandos.SetErroProc(const Value: TEventoDeErro);
begin
  fErro := Value;
end;

procedure TComandos.SetCNPJ_CPF(Value: String);
begin
  fCNPJ_CPF := Value;
end;

procedure TComandos.SetDesconto(Value: Currency);
begin
  fDesconto := Value;
end;

procedure TComandos.SetAcrescimo(Value: Currency);
begin
  fAcrescimo := Value;
end;

procedure TComandos.SetRodape_1(Value: String);
begin
  fRodape_1 := Value;
end;

procedure TComandos.SetRodape_2(Value: String);
begin
  fRodape_2 := Value;
end;

procedure TComandos.SetRodape_3(Value: String);
begin
  fRodape_3 := Value;
end;

procedure TComandos.SetRodape_4(Value: String);
begin
  fRodape_4 := Value;
end;

procedure Register;
begin
  RegisterComponents('X-Maker', [TXECF]);
end;

end.
