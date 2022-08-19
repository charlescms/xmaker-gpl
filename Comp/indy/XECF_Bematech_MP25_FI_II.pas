{
   Programa.: XECF_Bematech_MP25_FI_II.Pas
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit XECF_Bematech_MP25_FI_II;

interface

uses Classes, Sysutils, XECF, Windows, XECF_util;

type
  TECF_Bematech_MP25_FI_II = class(TComandos)
  private
    function BCD2Float(s: string): Currency;
    function BCD2Inteiro(s: string): Integer;
    function BCD2Date(s: string): TDateTime;
    function MontarComando(xComando: string): string;
  protected
    function GetLigada: Boolean; override;
  public
    function Executa_Comando(xComando: string; TamanhoRetorno: Integer = 0): Boolean; override;
    function Estado: TEstado; override;
    function Em_Horario_Verao: boolean; override;
    function CNPJ: String; override;
    function Inscricao_Estadual: String; override;
    function Numero_Serie: String; override;
    function Numero_Cupom: Integer; override;
    function Numero_Ultimo_Cupom: Integer; override;
    function Numero_Caixa: Integer; override;
    function Numero_Loja: Integer; override;
    function Data_Atual: TDateTime; override;
    function Data_Fiscal: TDateTime; override;
    function Contador_Reducoes: Integer; override;
    function Numero_Cancelamentos: Integer; override;
    function Total_Cancelamentos: Currency; override;
    function Total_Descontos: Currency; override;
    function Abrir_Dia: Boolean; override;
    function Abrir_Venda: Boolean; override;
    function Vender_Item: Boolean; override;
    function Cancelar_Item: Boolean; override;
    function Imp_Acrescimo_Desconto: Boolean; override;
    function Forma_Pagto(xDescricao: String; xValor: Currency): Boolean; override;
    function Fechar_Venda: Boolean; override;
    function Cancelar_Venda: Boolean; override;
    function LeituraX(xOperador: String):Boolean; override;
    function ReducaoZ(xOperador: String):Boolean; override;
    function Horario_Verao:Boolean; override;
    function Leitura_MF_Por_Data(xDe, xAte: TDateTime; xGeraArq: String = ''): Boolean; override;
    function Leitura_MF_Por_Reducao(xDe, xAte: Integer; xGeraArq: String = ''): Boolean; override;
    function Programar_Aliquotas(xPercentual: Currency; xISS: Boolean): Boolean; override;
    function Suprimento_de_Caixa(xValor: Currency): Boolean; override;
    function Sangria_de_Caixa(xValor: Currency): Boolean; override;
    function Abrir_Gaveta: Boolean; override;
  published
    property Ligada: Boolean read GetLigada;
end;

function GetTick: ULong;

implementation

function GetTick: ULong;
begin
  Result := Windows.GetTickCount;
end;

function TECF_Bematech_MP25_FI_II.BCD2Float(s: string): Currency;
var
  i: integer;
begin
  Result := 0;
  for i := 1 to Length(s) do
    Result := (Result * 100.0) + (Ord(s[i]) shr 4) and $F * 10 + Ord(s[i]) and $F;
  Result := Result / 100.0;
end;

function TECF_Bematech_MP25_FI_II.BCD2Inteiro(s: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(s) do
    Result := (Result * 100) + (Ord(s[i]) shr 4) and $F * 10 + Ord(s[i]) and $F;
end;

function TECF_Bematech_MP25_FI_II.BCD2Date(s: string): TDateTime;
begin
  Result := 0.0;
  try
    if Length(s) >= 3 then
      Result := EncodeDate(BCD2Inteiro(s[3]) +
        IIF(BCD2Inteiro(s[3]) > 30, 1900, 2000),
        BCD2Inteiro(s[2]),
        BCD2Inteiro(s[1]));

    if Length(s) >= 6 then
      Result := Result + EncodeTime(BCD2Inteiro(s[4]),
        BCD2Inteiro(s[5]),
        BCD2Inteiro(s[6]), 0);
  except
    Result := 0.0;
  end;
end;

function TECF_Bematech_MP25_FI_II.MontarComando(xComando: string): string;
var
  i, Calc, Tam: Integer;
begin
  if xComando = '' then
    Exit;
  Calc := 27;
  for i := 1 to Length(xComando) do
    Calc := Calc + ord(xComando[i]);
  Tam := Length(xComando) + 3;
  Result := #2 + Chr(Tam mod 256) + Chr(Trunc(Tam / 256)) + #27 + xComando +
    Chr(Calc mod 256) + Chr(Trunc(Calc / 256));
end;

function TECF_Bematech_MP25_FI_II.Executa_Comando(xComando: string; TamanhoRetorno: Integer = 0): Boolean;
const
  EsperaPelaECF: Integer = 10000; 
var
  Rsp: Byte;
  Com: string;
  Tick, AtualTick: LongInt;
begin
  fUltimoComando := xComando;
  fUltimoTamanhoEsperado := TamanhoRetorno;
  Com := MontarComando(xComando);
  if not Ligada then
  begin
    Tick := GetTick;
    AtualTick := GetTick;
    while ((AtualTick - Tick) < EsperaPelaECF) and not Ligada do
      AtualTick := GetTick;
    if not Ligada then
    begin
      Result := GerarErro(msg_ImpressoraDesligadaOuDesconectada);
      Exit;
    end;
  end;
  PortaSerial.Purge;
  EnviarString(Com);
  if PortaSerial.LastError <> 0 then
  begin
    Result := GerarErro(Format(msg_ErroAoEnviarComando, [DescreverErro(PortaSerial.LastError)]));
    Exit;
  end;
  Rsp := LerByte(2000); 
  if Rsp = 0 then
  begin
    Result := GerarErro(msg_NaoHouveResposta);
    Exit;
  end;
  if Rsp = 21 then // NAK
  begin
    Result := GerarErro('Erro na montagem do comando');
    Exit;
  end;
  if TamanhoRetorno > 0 then
  begin
    fUltimaResposta := LerStringTamanho(TamanhoRetorno, 2000);
    if Length(fUltimaResposta) < TamanhoRetorno then
    begin
      Result := GerarErro(msg_NaoHouveResposta);
      Exit;
    end;
  end
  else
    fUltimaResposta := '';
  while not (PortaSerial.CTS) do
    Sleep(500);
  Rsp := LerByte(2000); //ST1
  if VerificarBIT(Rsp, 7) then
  begin
    Result := GerarErro(msg_SemPapel);
    Exit;
  end;
  if VerificarBIT(Rsp, 6) then
  begin
    Result := GerarErro('Pouco papel');
    Exit;
  end;
  if VerificarBIT(Rsp, 5) then
  begin
    Result := GerarErro('Erro no relógio');
    Exit;
  end;
  if VerificarBIT(Rsp, 4) then
  begin
    Result := GerarErro('Impressora Erro');
    Exit;
  end;
  if VerificarBIT(Rsp, 3) then
  begin
    Result := GerarErro('Primeiro dado de CMD não foi ESC');
    Exit;
  end;
  if VerificarBIT(Rsp, 2) then
  begin
    Result := GerarErro('Comando inexistente');
    Exit;
  end;
  if VerificarBIT(Rsp, 1) then
  begin
    Result := GerarErro('Cupom aberto');
    Exit;
  end;
  if VerificarBIT(Rsp, 0) then
  begin
    Result := GerarErro('Número de parâmetros de CMD inválido');
    Exit;
  end;

  Rsp := LerByte(2000); //ST2
  if VerificarBIT(Rsp, 7) then
  begin
    Result := GerarErro('Tipo de parâmetro de CMD inválido');
    Exit;
  end;
  if VerificarBIT(Rsp, 6) then
  begin
    Result := GerarErro('Memória Fiscal lotada');
    Exit;
  end;
  if VerificarBIT(Rsp, 5) then
  begin
    Result := GerarErro('Erro na Memória RAM CMOS Não Volátil');
    Exit;
  end;
  if VerificarBIT(Rsp, 4) then
  begin
    Result := GerarErro('Alíquota não programada');
    Exit;
  end;
  if VerificarBIT(Rsp, 3) then
  begin
    Result := GerarErro('Capacidade de alíq. programáveis lotada');
    Exit;
  end;
  if VerificarBIT(Rsp, 2) then
  begin
    Result := GerarErro('Cancelamento não permitido');
    Exit;
  end;
  if VerificarBIT(Rsp, 1) then
  begin
    Result := GerarErro('CNPJ/IE do proprietário não programados');
    Exit;
  end;
  if VerificarBIT(Rsp, 0) then
  begin
    Result := GerarErro('Comando não executado');
    Exit;
  end;
  Result := True;
  if (xComando[1] = #$08) and (xComando[length(xComando)] = 'R') then
    fUltimaResposta := LerStringSufixo(30000, #$3);
end;

function TECF_Bematech_MP25_FI_II.GetLigada: Boolean;
begin
  Result := PortaSerial.CTS;
end;

function TECF_Bematech_MP25_FI_II.Estado: TEstado;
var
  b: byte;
  DataMovimento: TDateTime;
begin
  Result := st_Dia_Aberto;

  Executa_Comando(#35#27, 3);
  DataMovimento := BCD2Date(UltimaResposta);
  if DataMovimento = 0 then
    Result := st_Dia_Fechado;

  Executa_Comando(#$23#$11, 1);
  b := ord(UltimaResposta[1]);

  if VerificarBIT(b, 0)then
    Result := st_Venda_Aberta;
end;

function TECF_Bematech_MP25_FI_II.Em_Horario_Verao: Boolean;
var
  b: byte;
begin
  Executa_Comando(#$23#$11, 1);
  b := ord(UltimaResposta[1]);
  Result := VerificarBIT(b, 2);
end;

function TECF_Bematech_MP25_FI_II.CNPJ: String;
begin
  Executa_Comando(#35#02, 33);
  Result := Copy(UltimaResposta, 0, 18);
end;

function TECF_Bematech_MP25_FI_II.Inscricao_Estadual: String;
begin
  Executa_Comando(#35#02, 33);
  Result := Copy(UltimaResposta, 19, 15);
end;

function TECF_Bematech_MP25_FI_II.Numero_Serie: String;
begin
  Executa_Comando(#35#00, 15);
  Result := Trim(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Numero_Cupom: Integer;
begin
  Executa_Comando(#30, 3);
  Result := BCD2Inteiro(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Numero_Ultimo_Cupom: Integer;
begin
  Executa_Comando(#30, 3);
  Result := BCD2Inteiro(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Numero_Caixa: Integer;
begin
  Executa_Comando(#35#14, 2);
  Result := BCD2Inteiro(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Numero_Loja: Integer;
begin
  Executa_Comando(#35#15, 2);
  Result := BCD2Inteiro(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Data_Atual: TDateTime;
begin
  Executa_Comando(#35#23, 6);
  Result := BCD2Date(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Data_Fiscal: TDateTime;
begin
  Executa_Comando(#35#26, 6);
  Result := BCD2Date(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Contador_Reducoes: integer;
begin
  Executa_Comando(#35#09, 2);
  Result := BCD2Inteiro(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Numero_Cancelamentos: Integer;
begin
  result := 0;
  if Executa_Comando(#35#8, 2) then
    Result := BCD2Inteiro(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Total_Cancelamentos: Currency;
begin
  Executa_Comando(#35#04, 7);
  Result := BCD2Float(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Total_Descontos: Currency;
begin
  Executa_Comando(#35#05, 7);
  Result := BCD2Float(UltimaResposta);
end;

function TECF_Bematech_MP25_FI_II.Abrir_Dia: Boolean;
begin
  Result := Executa_Comando(#$06);
end;

function TECF_Bematech_MP25_FI_II.Abrir_Venda: Boolean;
begin
  Result := Executa_Comando(#$00 + LFill(CNPJ_CPF, ' ', 28));
end;

function TECF_Bematech_MP25_FI_II.Vender_Item: Boolean;
begin
  Result := True;
  Item.Total := (Item.Quantidade * Item.Valor) - Item.Desconto;
  case Item.Tres_Decimais of
    True:
      begin
        Result := Executa_Comando(
          #56 +
          LFill(Item.Codigo, '0', 13) +
          RFill(Item.Descricao, ' ', 29) +
          LFill(Item.Aliquota, '0', 2) +
          LFill(FormatFloat('#0', trunc(Item.Quantidade * 1000)), '0', 7) +
          LFill(FormatFloat('#0', trunc(Item.Valor * 1000)), '0', 8) +
          LFill(FormatFloat('#0', trunc(Item.Desconto * 100)), '0', 8)
          );
      end;
    False:
      begin
        Result := Executa_Comando(
          #$09 +
          LFill(Item.Codigo, '0', 13) +
          RFill(Item.Descricao, ' ', 29) +
          LFill(Item.Aliquota, '0', 2) +
          LFill(FormatFloat('#0', trunc(Item.Quantidade * 1000)), '0', 7) +
          LFill(FormatFloat('#0', trunc(Item.Valor * 100)), '0', 8) +
          LFill(FormatFloat('#0', trunc(Item.Desconto * 100)), '0', 8)
          );
      end;
  end;
end;

function TECF_Bematech_MP25_FI_II.Cancelar_Item: Boolean;
begin
  Result := Executa_Comando(#31 + FormatFloat('0000', Item.Sequencia));
end;

function TECF_Bematech_MP25_FI_II.Imp_Acrescimo_Desconto: Boolean;
begin
  if (Acrescimo >= Desconto) then
    Result := Executa_Comando(#32'a' + LFill(formatFloat('#0', trunc(((Acrescimo - Desconto) * 100))), '0', 14))
  else
    Result := Executa_Comando(#32'd' + LFill(formatFloat('#0', trunc(((Desconto - Acrescimo) * 100))), '0', 14));
end;

function TECF_Bematech_MP25_FI_II.Forma_Pagto(xDescricao: String; xValor: Currency): Boolean;
var
  CodFinalizadora: Integer;
begin
  Executa_Comando(#71 + RFill(xDescricao, ' ', 16), 2);
  CodFinalizadora := StrToIntDef(UltimaResposta, 0);
  Executa_Comando(#72 +
    LFill(inttostr(CodFinalizadora), '0', 2) +
    LFill(FormatFloat('#0', trunc(xValor * 100)), '0', 14)
    );
end;

function TECF_Bematech_MP25_FI_II.Fechar_Venda: Boolean;
begin
  Result := Executa_Comando(#34 + Rodape_1 + Rodape_2 + Rodape_3 + Rodape_4);
end;

function TECF_Bematech_MP25_FI_II.Cancelar_Venda: Boolean;
begin
  Result := Executa_Comando(#$0E);
end;

function TECF_Bematech_MP25_FI_II.LeituraX(xOperador: String):Boolean;
begin
  if Estado = st_Venda_Aberta then
  begin
    GerarErro('Cupom Aberto !');
    Result := False
  end
  else
    Result := Executa_Comando(#$06);
end;

function TECF_Bematech_MP25_FI_II.ReducaoZ(xOperador: String):Boolean;
begin
  if Estado = st_Venda_Aberta then
  begin
    GerarErro('Cupom Aberto !');
    Result := False
  end
  else
    Result := Executa_Comando(#$05);
end;

function TECF_Bematech_MP25_FI_II.Horario_Verao:Boolean;
begin
  if Estado = st_Venda_Aberta then
  begin
    GerarErro('Cupom Aberto !');
    Result := False
  end
  else
    Result := Executa_Comando(#$12);
end;

function TECF_Bematech_MP25_FI_II.Leitura_MF_Por_Data(xDe, xAte: TDateTime; xGeraArq: String = ''): Boolean;
var
  Arq: TextFile;
begin
  if Estado = st_Venda_Aberta then
  begin
    GerarErro('Cupom Aberto !');
    Result := False
  end
  else
  begin
    if Trim(xGeraArq) = '' then
      Result := Executa_Comando(#$08 + FormatDateTime('ddmmyy', xDe) + FormatDateTime('ddmmyy', xAte) + 'I')
    else
    begin
      Result := Executa_Comando(#$08 + FormatDateTime('ddmmyy', xDe) + FormatDateTime('ddmmyy', xAte) + 'R');
      if Result then
      begin
        AssignFile(Arq, xGeraArq);
        ReWrite(Arq);
        Write(Arq, UltimaResposta);
        CloseFile(Arq);
      end;
    end;
  end;
end;

function TECF_Bematech_MP25_FI_II.Leitura_MF_Por_Reducao(xDe, xAte: Integer; xGeraArq: String = ''): Boolean;
var
  Arq: TextFile;
begin
  if Estado = st_Venda_Aberta then
  begin
    GerarErro('Cupom Aberto !');
    Result := False
  end
  else
  begin
    if Trim(xGeraArq) = '' then
      Result := Executa_Comando(#$08 + StrZero(xDe, 6) + StrZero(xAte, 6) + 'I')
    else
    begin
      Result := Executa_Comando(#$08 + StrZero(xDe, 6) + StrZero(xAte, 6) + 'R');
      if Result then
      begin
        AssignFile(Arq, xGeraArq);
        ReWrite(Arq);
        Write(Arq, UltimaResposta);
        CloseFile(Arq);
      end;
    end;
  end;
end;

function TECF_Bematech_MP25_FI_II.Programar_Aliquotas(xPercentual: Currency; xISS: Boolean): Boolean;
begin
  Result := False;
  if xISS then
    Result := Executa_Comando(#$7+LFill(FormatFloat('#0', xPercentual*100), '0', 4)+'1')
  else
    Result := Executa_Comando(#$7+LFill(FormatFloat('#0', xPercentual*100), '0', 4)+'0');
end;

function TECF_Bematech_MP25_FI_II.Suprimento_de_Caixa(xValor: Currency): Boolean;
begin
  Result := Executa_Comando(#$19 + 'SU' + LFill(FormatFloat('#0', Trunc(xValor * 100)), '0', 14));
end;

function TECF_Bematech_MP25_FI_II.Sangria_de_Caixa(xValor: Currency): Boolean;
begin
  Result := Executa_Comando(#$19 + 'SA' + LFill(FormatFloat('#0', Trunc(xValor * 100)), '0', 14));
end;

function TECF_Bematech_MP25_FI_II.Abrir_Gaveta: Boolean;
begin
  Result := Executa_Comando(#22#$FF);
end;

end.
