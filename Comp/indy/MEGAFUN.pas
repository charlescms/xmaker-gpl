
{ Titulo     : Biblioteca de Funcoes da Mega Sistemas
  Data       : 15/01/01
  Programa   : megafun.PAS
  Comentario : Funcoes }

unit megafun;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Printers, DB,
  DBTables, Forms, Classes, DbiProcs,Dialogs,Controls,stdctrls,grids,Math;
//  Graphics, Controls, StdCtrls,windows,Grids;

{ Funcao para criar N espacos }
function Spaco(N: integer): string;

{ Funcao para retornar uma String com tamanho fixo, boa para Lay-Outs}
function TamStr(dado: string; Tamanho:integer):string;

{ Funcao de codificacao de senha }
function Codifica(S: string): string;

{ Coloca zeros a esquerda }
function StrZero(N: longint; Tamanho: integer): string;

{ Reproduz um string varias vezes }
function Repl(C: string; Tamanho: integer): string;

{ Janela para quetionamento }
function Pergunta( Texto: string ): string;

{ Janela para mensagens }
procedure Mensagem( Texto: string );

{ Retorna o Dia de uma data }
function Dia( Data: TDateTime ): string;

{ Retorna o Mes de uma data }
function Mes( Data: TDateTime ): string;


{ Retorna o Dia e o Mes de uma data }
function DiaMes( Data: TDateTime ): string;

{ Retorna o Mes/Ano de uma data }
function MesAno( Data: TDateTime ): string;

{ Retorna o Ano de uma data }
function Ano( Data: TDateTime ): string;

{ Retorna o ultimo dia do mes }
function UltimoDiaDoMes( MesAno: string ): string;

{ Retorna a data no formato MM/DD/AA }
function MMDDAA( Data: string ): string;

{ Retorna a data no formato DDMMAAAA , SEM BARRAS }
function DDMMAAAA( Data: TDateTime ): string;

{ Retira os espacos em branco da direita }
function Trim( Dados: string ): string;

{ Retira os espacos em branco da direita }
function AllTrim( Dados: string ): string;

{ Verifica se a string esta vazia }
function Empty( Dados: string ): boolean;

{ Verifica se a string nao esta vazia }
function NotEmpty( Dados: string ): boolean;

{ Calcula o digito verificador }
function Digito( Dados: string ): boolean;

{ Retorna uma string com zeros a esquerda }
function Zeros( Dados: string; Tamanho: integer ): string;

{ Verifica se o CGC e' valido }
function C_G_C( Dados: string ): boolean;

{ Verifica se o CPF e' valido }
function C_P_F( Dados: string ): boolean;

{ Verifica se a Competência é Valida }
function vermesano(mmaaaa:integer) : boolean;

{ Verifica se a data é Valida }
function DataValida(StrD: string): boolean;

{ Alinha algarismos a direita }
function Transform( Conteudo: Extended; const Mascara: string ): string;

{ Funcao para formatacao de data }
function FDateTime( const Mascara: string; Conteudo: TDateTime; Nulo: boolean ): string;

{ Simula o COMMIT do Clipper}
procedure Commit(DataSet: TDBDataSet);

{ Limpa strings para serem convertidas em valores numericos }
function LimpaNumeros( const Dados: string ): string;

{ Converte alfanumerico para numerico Em STRING ex:'1234.1234/66'->'1234123466'}
function alfatonum( const Dados: string ): string;

{ Transforma mes de numeros para extenso }
function nomemes( Data: TDateTime ): string;

{ gera valor por extenso }
function extenso (valor: real): string;

{ Arredonda Tributamente }
function TBRound(valor:extended;decimals:smallint):Extended;

{ Seta ambiente de inicializacao de um programa delphi }
procedure SetaAmbiente;

{ Altera forma de entrada, ENTER = TAB , Setas tambem para
  cima e para baixo !

  OBS.: Desve ser usado no form principal a linha abaixo:

  Application.OnMessage := MudarComEnter;  }

procedure MudarcomEnter(var Msg: TMsg; var Handled: Boolean);

implementation
procedure SetaAmbiente;
begin
  ThousandSeparator := '.'; // Separador de milhares
  DecimalSeparator := ','; // Ponto decimal
  ShortDateFormat := 'dd/mm/yyyy'; // Formato de data
  DateSeparator := '/'; // Separador de data
  TimeSeparator := ':'; // Separador de hora

  // Nome abreviado para os meses
  ShortMonthNames[1] := 'Jan';
  ShortMonthNames[2] := 'Fev';
  ShortMonthNames[3] := 'Mar';
  ShortMonthNames[4] := 'Abr';
  ShortMonthNames[5] := 'Mai';
  ShortMonthNames[6] := 'Jun';
  ShortMonthNames[7] := 'Jul';
  ShortMonthNames[8] := 'Ago';
  ShortMonthNames[9] := 'Set';
  ShortMonthNames[10] := 'Out';
  ShortMonthNames[11] := 'Nov';
  ShortMonthNames[12] := 'Dez';

  // Nome dos meses por extenso
  LongMonthNames[1] := 'Janeiro';
  LongMonthNames[2] := 'Fevereiro';
  LongMonthNames[3] := 'Março';
  LongMonthNames[4] := 'Abril';
  LongMonthNames[5] := 'Maio';
  LongMonthNames[6] := 'Junho';
  LongMonthNames[7] := 'Julho';
  LongMonthNames[8] := 'Agosto';
  LongMonthNames[9] := 'Setembro';
  LongMonthNames[10] := 'Outubro';
  LongMonthNames[11] := 'Novembro';
  LongMonthNames[12] := 'Dezembro';

  // Nome abreviado dos dias da semana
  ShortDayNames[1] := 'Dom';
  ShortDayNames[2] := 'Seg';
  ShortDayNames[3] := 'Ter';
  ShortDayNames[4] := 'Qua';
  ShortDayNames[5] := 'Qui';
  ShortDayNames[6] := 'Sex';
  ShortDayNames[7] := 'Sáb';

  // Nome longo dos dias da semana
  LongDayNames[1] := 'Domingo';
  LongDayNames[2] := 'Segunda';
  LongDayNames[3] := 'Terça';
  LongDayNames[4] := 'Quarta';
  LongDayNames[5] := 'Quinta';
  LongDayNames[6] := 'Sexta';
  LongDayNames[7] := 'Sábado';

  // Valores Monetários

  CurrencyString := 'R$'; // Símbolo de valor monetário
  CurrencyFormat := 0; // Formato para valor positivo 
  // (0 = "R$1,00")
  NegCurrFormat := 2; // Formato de valor negativo
  // (2 = "R$-1,00")
  CurrencyDecimals := 2; // Número de casas decimais

end;

function TamStr(dado:string;Tamanho:integer):string;
begin
 if Length(alltrim(dado))<tamanho then
   result := alltrim(dado)+spaco(tamanho-Length(alltrim(dado)))
 else
   result:=copy(alltrim(dado),1,tamanho);
end;

procedure Commit( DataSet: TDBDataSet );
begin
  with DataSet do
  begin
    UpdateCursorPos;
    Check( dbiSaveChanges( Handle ) );
    CursorPosChanged;
  end;
end;

function LimpaNumeros( const Dados: string ): string;
var
  Contar: integer;
  Resultado: string;
begin
  Resultado := '';
  for Contar := 1 to Length( Dados ) do
  begin
    if Pos( Copy( Dados, Contar, 1 ) ,'-.0123456789' ) > 0 then
    begin
      if Copy( Dados, Contar, 1 ) = '.' then
        Resultado := Resultado + ','
      else
        Resultado := Resultado + Copy( Dados, Contar, 1 );
    end;
  end;
  if Copy( Resultado, 0, 1 ) = ',' then
    Resultado := '0' + Resultado;
  if Copy( Resultado, Length( Resultado ), 1 ) = ',' then
    Resultado := Resultado + '00';
  Result := Resultado;
end;

///
function alfatonum( const Dados: string ): string;
var
  Contar: integer;
  Resultado: string;
begin
  Resultado := '';
  for Contar := 1 to Length( Dados ) do
     if Pos( Copy( Dados, Contar, 1 ) ,'0123456789' ) > 0 then
      Resultado := Resultado + Copy( Dados, Contar, 1 );
  result:=resultado;
end;
///

function FDateTime( const Mascara: string; Conteudo: TDateTime; Nulo: boolean ): string;
begin
  if Nulo then
    Result := Spaco( 10 )
  else
    Result := FormatDateTime( Mascara, Conteudo );
end;

function Transform( Conteudo: Extended; const Mascara: string ): string;
var
  TamMascara: integer;
  Brancos: string;
  Dados: string;
begin
  TamMascara := Length( Mascara );
  Dados := FormatFloat( Mascara, Conteudo );
  if TamMascara > Length( Dados ) then
  begin
    Brancos := Spaco( TamMascara - Length( Dados ) );
    Dados := Brancos + Dados;
  end;
  Transform := Dados;
end;

function Zeros( Dados: string; Tamanho: integer ): string;
begin
  if Dados <> Spaco( Tamanho ) then
     Dados := StrZero( StrToInt( AllTrim( Dados ) ), Tamanho );
  Zeros := Dados;
end;

function Digito( Dados: string ): Boolean;
var
  iDigito: integer;
begin
  if Length( Trim( Dados ) ) = 0 then
    Dados := '0' + Spaco( Length( Dados ) - 1 );
  Dados := StrZero( StrToInt( AllTrim( Dados ) ), Length( Dados ) );
  iDigito := StrToInt( Copy( Dados, 1, Length( Dados ) - 1 ) ) mod 11;
  if iDigito = 10 then iDigito := 0;
  if iDigito <> StrToInt( Copy( Dados, Length( Dados ), 1 ) ) then
    Digito := False
  else
    Digito := True;
end;

function Trim( Dados: string ): string;
var
  Contar: integer;
begin
  for Contar := Length( Dados ) downto 1 do
  begin
    if Copy( Dados, Contar, 1 ) <> ' ' then
      Break;
    Dados := Copy( Dados, 1, Contar - 1 );
    Application.ProcessMessages;
  end;
  Trim := Dados;
end;

function AllTrim( Dados: string ): string;
var
  Contar: integer;
begin
  Dados := Trim( Dados );
  for Contar := 1 to Length( Dados ) do
  begin
    if Copy( Dados, Contar, 1 ) <> ' ' then
      Break;
    Dados := Copy( Dados, Contar + 1, Length( Dados ) - 1 );
    Application.ProcessMessages;
  end;
  AllTrim := Dados;
end;

function Empty( Dados: string ): boolean;
begin
  if ( Length( Trim( Dados ) ) = 0 ) or
    ( Trim( Dados ) = '  /  /' ) then
    Empty := True
  else
    Empty := False;
end;

function NotEmpty( Dados: string ): boolean;
begin
  if Empty( Dados ) then
    NotEmpty := False
  else
    NotEmpty := True;
end;

function MMDDAA( Data: string ): string;
var
  sDia: string;
  sMes: string;
  sAno: string;
begin
  sDia := Copy( Data, 1, 2 );
  sMes := Copy( Data, 4, 2 );
  sAno := Copy( Data, 7, 4 );
  if sDia + sMes + sAno = '        ' then
    MMDDAA := ''
  else
    MMDDAA := sMes + '/' + sDia + '/' + sAno;
end;

function DDMMAAAA( Data: TDateTime ): string;
begin
  result := dia(data)+mes(data)+ano(data);
end;


function UltimoDiaDoMes( MesAno: string ): string;
var
  sMes: string;
  sAno: string;
begin
  sMes := Copy( MesAno, 1, 2 );
  if Length( MesAno ) = 7 then
    sAno := Copy( MesAno, 4, 4 )
  else
    sAno := Copy( MesAno, 4, 2 );
  if Pos( sMes, '01 03 05 07 08 10 12' ) > 0 then
    UltimoDiaDoMes := '31'
  else
    if sMes <> '02' then
      UltimoDiaDoMes := '30'
    else
      if ( StrToInt( sAno ) mod 4 ) = 0 then
        UltimoDiaDoMes := '29'
      else
        UltimoDiaDoMes := '28';
end;

function DiaMes( Data: TDateTime ): string;
begin
  Result := Dia(Data) + '/' + Mes(Data)
end;

function Dia( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  Dia := StrZero( sDia, 2 );
end;

function Mes( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  Mes := StrZero( sMes, 2 );
end;

function MesAno( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  MesAno := StrZero( sMes, 2 ) + '/' +
    StrZero( sAno, 4 );
end;

function Ano( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  Ano := StrZero( sAno, 4 );
end;

procedure MudarComEnter(var Msg: TMsg; var Handled: Boolean);
begin
  If not ((Screen.ActiveControl is TCustomMemo) or
  (Screen.ActiveControl is TCustomGrid) or
  (Screen.ActiveForm.ClassName = 'TMessageForm')) then
  begin
  If Msg.message = WM_KEYDOWN then
  begin
  Case Msg.wParam of
  VK_RETURN,VK_DOWN : Screen.ActiveForm.Perform(WM_NextDlgCtl,0,0);
  VK_UP : Screen.ActiveForm.Perform(WM_NextDlgCtl,1,0);
  end;
  end;
  end;
end;

function DataValida(StrD: string): Boolean;
{Testa se uma data é valida}
begin
  Result := true;
  try
  StrToDate(StrD);
  except
  on EConvertError do Result:=False;
  end;
end;

function vermesano(mmaaaa:integer):boolean;
 var mesano:string;
begin
  result:=true;
  mesano:=strzero(mmaaaa,6) ;
  try
      StrToDate('01/'+copy(mesano,1,2)+
      '/'+copy(mesano,3,4));
  except
  on EConvertError do begin
     ShowMessage ('Competencia Invalida!');
     result:=false;
                      end
  end;
end;

procedure Mensagem( Texto: string );
begin
    MessageBeep(0);
    showmessage(Texto);
end;

function Pergunta( Texto: string ): string;
begin
 MessageBeep(0);
 if MessageDlg(texto,mtConfirmation, [mbyes, mbno], 0) = mrYes then
   result:= 'S'
   else
   result:= 'N';
end;

 function Spaco(N: integer): string;
 var
   I: integer;
   Dados: string;
 begin
   Dados := '';
   for I := 1 to N do
   begin
     Dados := Dados + ' ';
     Application.ProcessMessages;
   end;
   Spaco := Dados;
 end;

function Codifica(S: string): string;
var
  Cod: string;
  I: integer;
begin
  S := S + #13 + '          ';
  Cod := '';
  for I := 9 downto 1 do
    Cod := Cod + Copy( S, I, 1 );
  S := Copy( Cod, 4, 3 ) +
       Copy( Cod, 1, 3 ) +
       Copy( Cod, 7, 3 );
  Cod := '';
  for I := 1 to 9 do
  begin
    if (I mod 2) = 0 then
    begin
      if ord( S[I] ) = 255 then
        Cod := Cod + #0
      else
        Cod := Cod + chr( ord( S[I] ) + 1 );
    end
    else
    begin
      if ord( S[I] ) = 0 then
        Cod := Cod + chr( 255 )
      else
        Cod := Cod + chr( ord( S[I] ) - 1 );
    end;
  end;
  Codifica := Cod;
end;

function StrZero(N: longint; Tamanho: integer): string;
var
  Conteudo: string;
  Diferenca: longint;
begin
  Conteudo := IntToStr( N );
  Diferenca := Tamanho - Length( Conteudo );
  if Diferenca > 0 then
    Conteudo := Repl( '0', Diferenca ) + Conteudo;
  StrZero := Conteudo;
end;

function Repl(C: string; Tamanho: integer): string;
var
  Conteudo: string;
  Contar: integer;
begin
  Conteudo := '';
  for Contar := 1 to Tamanho do
  begin
    Conteudo := Conteudo + C;
    Application.ProcessMessages;
  end;
  Repl := Conteudo;
end;

function C_G_C( Dados: string ): boolean;
var
  CGC: string;
  Soma: integer;
  Contar: integer;
  Digito: integer;
begin
  try
    if Length( Dados ) > 14 then
      Dados := Copy( Dados, 1, 2 ) + Copy( Dados, 4, 3 ) +
        Copy( Dados, 8, 3 ) + Copy( Dados, 12, 4 )
        + Copy( Dados, 17, 2 );
    if Length( Trim( Dados ) ) = 0 then
    begin
      Result := True;
      exit;
    end;
    CGC := Copy( Dados, 1, 12 );
    Soma := 0;
    for Contar := 1 to 4 do
      Soma := Soma +
        StrToInt( copy( CGC, Contar, 1 ) )
        * ( 6 - Contar );
    for Contar := 1 to 8 do
      Soma := Soma + StrToInt( copy( CGC,
        Contar + 4, 1 ) ) * ( 10 - Contar );
    Digito := 11 - Soma mod 11;
    if Digito in [ 10, 11 ] then
      CGC := CGC + '0'
    else
      CGC := CGC +IntToStr( Digito );
    Soma := 0;
    for Contar := 1 to 5 do
      Soma := Soma + StrToInt( copy( CGC,
        Contar, 1 ) ) * ( 7 - Contar );
    for Contar := 1 to 8 do
      Soma := Soma + StrToInt( copy( CGC,
      Contar + 5, 1 ) ) * ( 10 - Contar );
    Digito := 11 - Soma mod 11;
    if Digito in [ 10, 11 ] then
      CGC := CGC + '0'
    else
      CGC := CGC +
        IntToStr( Digito );
    if Dados <> CGC then
      Result := false
    else
      Result := true;
  except on econverterror do
    Result := false;
  end;
end;

function C_P_F( Dados: string ): boolean;
var
  CPF: string;
  Soma: integer;
  Contar: integer;
  Digito: integer;
begin
  try
    if Length( Dados ) > 11 then
      Dados := Copy( Dados, 1, 3 ) + Copy( Dados, 5, 3 ) +
        Copy( Dados, 9, 3 ) + Copy( Dados, 13, 2 );
    if Length( Trim( Dados ) ) = 0 then
    begin
      Result := True;
      exit;
    end;
    CPF := copy( Dados, 1, 9 );
    Soma := 0;
    for Contar := 1 to 9 do
      Soma := Soma +
        StrToInt( copy( CPF, Contar, 1 ) )
        * ( 11 - Contar );
    Digito := 11 - Soma mod 11;
    if Digito in [ 10,11 ] then
      CPF:= CPF + '0'
    else
      CPF := CPF + IntToStr( Digito );
    Soma := 0;
    for Contar := 1 to 10 do
      Soma := Soma +
        StrToInt( copy( CPF, Contar, 1 ) ) *
        ( 12 - Contar );
    Digito := 11 - Soma mod 11;
    if Digito in [ 10, 11 ] then
      CPF := CPF + '0'
    else
      CPF := CPF +
        IntToStr( Digito );
    if Dados <> CPF then
      Result := false
    else
      Result := true;
  except on econverterror do
    Result := false;
  end;
end;

function nomemes( Data: TDateTime ): string;
begin
{  if mes(data)='01' then
  result:='Janeiro';
  if mes(data)='02' then
  result:='Fevereiro';
  if mes(data)='03' then
  result:='Março';
  if mes(data)='04' then
  result:='Abril';
  if mes(data)='05' then
  result:='Maio';
  if mes(data)='06' then
  result:='Junho';
  if mes(data)='07' then
  result:='Julho';
  if mes(data)='08' then
  result:='Agosto';
  if mes(data)='09' then
  result:='Setembro';
  if mes(data)='10' then
  result:='Outubro';
  if mes(data)='11' then
  result:='Novembro';
  if mes(data)='12' then
  result:='Dezembro';}
  case  strtoint(mes(data)) of
  01:result:='Janeiro';
  02:result:='Feveiro';
  03:result:='Março';
  04:result:='Abril';
  05:result:='Maio';
  06:result:='Junho';
  07:result:='Julho';
  08:result:='Agosto';
  09:result:='Setembro';
  10:result:='Outubro';
  11:result:='Novembro';
  12:result:='Dezembro';
 end;
end;

function extenso (valor: real): string;
var
Centavos, Centena, Milhar,  Texto, msg: string;      //milhao 
const
Unidades: array[1..9] of string = ('Um', 'Dois', 'Tres', 'Quatro', 'Cinco',
'Seis', 'Sete', 'Oito', 'Nove');
Dez: array[1..9] of string = ('Onze', 'Doze', 'Treze', 'Quatorze', 'Quinze',
'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
Dezenas: array[1..9] of string = ('Dez', 'Vinte', 'Trinta', 'Quarenta',
'Cinquenta', 'Sessenta', 'Setenta',
'Oitenta', 'Noventa');
Centenas: array[1..9] of string = ('Cento', 'Duzentos', 'Trezentos',
'Quatrocentos', 'Quinhentos', 'Seiscentos',
'Setecentos', 'Oitocentos', 'Novecentos');
function ifs(Expressao: Boolean; CasoVerdadeiro, CasoFalso: String): String;
begin
if Expressao
then Result:=CasoVerdadeiro
else Result:=CasoFalso;
end;
function MiniExtenso (trio: string): string;
var
Unidade, Dezena, Centena: string;
begin
Unidade:='';
Dezena:='';
Centena:='';
if (trio[2]='1') and (trio[3]<>'0') then
begin
Unidade:=Dez[strtoint(trio[3])];
Dezena:='';
end
else
begin
if trio[2]<>'0' then Dezena:=Dezenas[strtoint(trio[2])];
if trio[3]<>'0' then Unidade:=Unidades[strtoint(trio[3])];
end;
if (trio[1]='1') and (Unidade='') and (Dezena='')
then Centena:='cem'
else
if trio[1]<>'0'
then Centena:=Centenas[strtoint(trio[1])]
else Centena:='';
Result:= Centena + ifs((Centena<>'') and ((Dezena<>'') or (Unidade<>'')), ' e ', '')
+ Dezena + ifs((Dezena<>'') and (Unidade<>''),' e ', '') + Unidade;
end;
begin
if (valor>999999.99) or (valor<0) then
begin
msg:='O valor est  fora do intervalo permitido.';
msg:=msg+'O n£mero deve ser maior ou igual a zero e menor que 999.999,99.';
msg:=msg+' Se nÆo for corrigido o n£mero nÆo ser  escrito por extenso.';
showmessage(msg);
Result:='';
exit;
end;
if valor=0 then
begin
Result:='';
Exit;
end;
Texto:=formatfloat('000000.00',valor);
Milhar:=MiniExtenso(Copy(Texto,1,3));
Centena:=MiniExtenso(Copy(Texto,4,3));
Centavos:=MiniExtenso('0'+Copy(Texto,8,2));
Result:=Milhar;
if Milhar<>'' then
if copy(texto,4,3)='000' then
Result:=Result+' Mil Reais'
else
Result:=Result+' Mil, ';
//if (((copy(texto,4,2)='00') and (Milhar<>'')
//and (copy(texto,6,1)<>'0')) or (centavos=''))
//and (Centena<>'') then Result:=Result+' e ';
if (Milhar+Centena <>'') then Result:=Result+Centena;
if (Milhar='') and (copy(texto,4,3)='001') then
Result:=Result+' Real'
else
if (copy(texto,4,3)<>'000') then Result:=Result+' Reais';

if Centavos='' then
 begin
  Result:=Result+'.';
  Exit;
 end
else
 begin
  if Milhar+Centena='' then
    Result:=Centavos
  else
    Result:=Result+', e '+Centavos;
  
  if (copy(texto,8,2)='01') and (Centavos<>'') then
    Result:=Result+' Centavo.'
  else
    Result:=Result+' Centavos.';
 end;
end;

function TBRound(valor:extended;decimals:smallint):Extended;
var vm:extended;
    p,f,p2,f2:extended;
Begin
   (* Nova função de arredondamento *)
   vm:=Power(10,Decimals);
   p:=int(valor);
   { A conversão para string e depois para float evita
    erros indesejáveis. Que apareceria na comparação f2=0.5 }
   f:=StrToFloat(FloatToStr(Frac(valor)*vm));
   p2:=int(f);
   f2:=Frac(f);
   if f2>0.5 then
      p2:=p2+1
   else
      if f2=0.5 then
      if frac(p2/2)>0 then p2:=p2+1;

   p2:=p2/vm;
   result:=p+p2;
end;

{
Criando uma rotina para pegar todos os erros do programa.
Procedure MostraErro;
Begin
ShowMessage('Ocorreu algum erro!');
end;

TForm1.Create;
Begin
Application.OnException:=MostraErro;
end;

}
end.

