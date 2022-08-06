{
   Programa.: Rotinas.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Rotinas;

interface

{$I Princ.inc}

uses Forms, Classes, WinProcs, Controls, Menus, ExtCtrls, Printers,
     Mask, {$IFDEF DELPHI5}{$ELSE}MaskUtils,{$ENDIF} Dialogs, Sysutils,
     Publicas, Princ, Acesso;

function ConstStr(Ch: string; N: byte): string;
function DiretorioComBarra(NomeDir: string): string;
function DiretorioSemBarra(NomeDir: string): string;
function RetiraHK(S: string): string;
function ArrayToString(OpenArray: array of string; Separador: char): string;
procedure StringToArray(St: string; Separador: char; Lista: TStringList);
function DirWindows: string;
function RetiraBrancos(Str: string): string;
procedure ExecutaForm(FormClass: TFormClass; var Reference);
function CopiaArquivo(Origem, Destino: string): Boolean;
function CopiaArquivosMascara(Orig, Dest, Masc: string): Boolean;
function PadR(InStr: string; TotalLen: Integer): string;
function PadL(InStr: string; TotalLen: Integer): string;
function Center(InStr: string; TotalLen: Integer): string;
function Space(TotalLen: Integer): string;
function DataAtual: TDateTime;
function HoraAtual: string;
function TrataGrupo(const S: String): String;
function PorExtenso(FValor: Double): String;
function Encript(Encript : String): string;
function Decript(Decript : String): string;
function StrZero(N: integer; Tamanho: integer): string;
function Dia( Data: TDateTime ): string;
function Mes( Data: TDateTime ): string;
function MesAno( Data: TDateTime ): string;
function Ano( Data: TDateTime ): string;
function UltimoDiaDoMes( MesAno: string ): string;
function DDMMAA( Data: string ): string;
function MascValor(Valor: Extended; Mascara: string): string;
function MascTexto(S, Mascara: String): string;
function TrocaString(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
function ContaOcorrencia(Substr: string; S: string): Integer;
function ProcuraRestricao(NomeTabela, Tipo: String): Boolean;
procedure DesabilitaFuncoesEd;
function FracToStr(Valor: Extended): String;
function CalcC(N1,N2: Extended;Operador: String; Decimal: Integer): Extended;
function Exponencial(N1: Extended; N2: Integer): Extended;
function StrNumerica(N: String) : Boolean;
function ConverteLogico(Valor: Boolean): string;
function ConverteStrToLog(Valor: String): boolean;
function SerialHD(FDrive:String) :String;
function VNivel: Boolean; { Libera acesso ao Módulo }
function LFill(aString: string; aCaracter: Char; aTamanho: integer): string;
function RFill(aString: string; aCaracter: Char; aTamanho: integer): string;
function IIF(aExpressao: Boolean; aVerdadeiro, aFalso: Variant): Variant;
function Envia_Email(const Server: String; const Port: Integer;const
  UserField, PasswordField, FromField, ToField, SubjectField,
  TextField, FileName, AttachName: String; ShowProgress: Boolean = True; FileLog: String = ''): String;
procedure DB_LoginConexao(Parametro: TStrings; Usuario, Senha: String);
function DB_User(Index: Integer): String;
function DifTempo(hora_i, hora_f: TTime): String;
function RepeatChar(Ch: Char; S: string): string;
procedure Atualiza_Status;
function AtribuiAspas(S: String): String;

implementation

uses FR_SMTP;

const
  FatorBloco = 32767;

function MascValor(Valor: Extended; Mascara: string): string;
var
  St, StInt,
  StDec: string;
  NumDec, I, J: byte;
  AchouVirgula: boolean;
begin
  St := '';
  NumDec := 0;
  AchouVirgula := false;
  for I := 1 to Length(Mascara) do
    case Mascara[I] of
      'Z', '9': if AchouVirgula then
          Inc(NumDec);
      ',': AchouVirgula := true;
    end;
  Str(Valor: 1: NumDec, St);
  if NumDec > 0 then
    StInt := Copy(St, 1, Pos('.', St) - 1)
  else
    StInt := St;
  if Valor < 0 then
    Delete(StInt, Pos('-', St), 1)
  else
    if Pos('-', Mascara) = 1 then
      Mascara[1] := ' ';
  if NumDec > 0 then
  begin
    StDec := Copy(St, Pos('.', St) + 1, Length(St));
    J := 1;
    for I := Pos(',', Mascara) + 1 to Length(Mascara) do
      if Mascara[I] in ['9', 'Z'] then
      begin
        Mascara[I] := StDec[J];
        Inc(J);
      end;
    I := Pos(',', Mascara) - 1;
  end
  else
    I := Length(Mascara);
  J := Length(StInt);
  while I > 0 do
  begin
    if J > 0 then
    begin
      if UpCase(Mascara[I]) in ['Z', '9'] then
      begin
        Mascara[I] := StInt[J];
        Dec(J);
      end;
    end
    else
      if (Mascara[I] <> '-') or (Valor >= 0) then
        case UpCase(Mascara[I]) of
          '9': Mascara[I] := '0';
          'Z': Mascara[I] := ' ';
          '.': if I > 1 then
              if Mascara[I - 1] = '9' then
                Mascara[I] := '.'
              else
                Mascara[I] := ' '
            else
              Mascara[I] := ' ';
        end;
    Dec(I);
  end;
  MascValor := Mascara;
end;

function MascTexto(S, Mascara: String): string;

  function ConverteMascara(Mascara: String): String;
  var
    MascaraCmp: string;
    I: Integer;
  begin
    MascaraCmp := Mascara;
    if MascaraCmp <> '' then
    begin
      for I := 1 to Length(MascaraCmp) do
        case MascaraCmp[I] of
          '9': MascaraCmp[I] := '0';
          'Z': MascaraCmp[I] := '#';
          'X': MascaraCmp[I] := 'C';
          'x': MascaraCmp[I] := 'c';
          'A': MascaraCmp[I] := 'C';
          'a': MascaraCmp[I] := 'c';
        end;
      if UpperCase(MascaraCmp) = ConstStr('C',Length(MascaraCmp)) then
        MascaraCmp := ''
      else
        MascaraCmp := MascaraCmp + ';0; ';
    end;
    ConverteMascara := MascaraCmp;
  end;

begin
  if (Trim(S) = '') or (Trim(Mascara) = '') then
  begin
    MascTexto := S;
    exit;
  end;
  Mascara := ConverteMascara(Mascara);
  MascTexto := FormatMaskText(Mascara, S);
end;

function ConstStr(Ch: string; N: byte): string;
var
  St: String;
  I: Integer;
begin
  St := '';
  For I:=0 to N-1 do
    St := St + Ch;
  Result := Copy(St, 1, N);
end;

function DiretorioComBarra(NomeDir: string): string;
begin
  if NomeDir[Length(NomeDir)] <> '\' then
    DiretorioComBarra := NomeDir + '\'
  else
    DiretorioComBarra := NomeDir;
end;

function DiretorioSemBarra(NomeDir: string): string;
begin
  if (NomeDir[Length(NomeDir)] = '\') and
  (NomeDir[Length(NomeDir) - 1] <> ':') then
    DiretorioSemBarra := Copy(NomeDir, 1, Length(NomeDir) - 1)
  else
    DiretorioSemBarra := NomeDir;
end;

function RetiraHK(S: string): string;
begin
  while Pos('&', S) > 0 do
    Delete(S, Pos('&', S), 1);
  if Copy(S, Length(S) - 2, 3) = '...' then
    Delete(S, Length(S) - 2, 3);
  RetiraHK := S;
end;

function ArrayToString(OpenArray: array of string; Separador: char): string;
var
  I: Integer;
begin
  Result := '';
  for I := Low(OpenArray) to High(OpenArray) do
  begin
    Result := Result + OpenArray[I];
    if I <> High(OpenArray) then Result := Result + Separador;
  end;
end;

procedure StringToArray(St: string; Separador: char; Lista: TStringList);
var
  I: Integer;
begin
  Lista.Clear;
  if St <> '' then
  begin
    St := St + Separador; //';';
    I := Pos(Separador, St);
    while I > 0 do
    begin
      Lista.Add(Copy(St, 1, I - 1));
      Delete(St, 1, I);
      I := Pos(Separador, St);
    end;
  end;
end;

function DirWindows: string;
var
  Dir: array[0..255] of char;
begin
  GetWindowsDirectory(Dir, 255);
  Result := StrPas(Dir);
end;

function RetiraBrancos(Str: string): string;
var
  I, Tam: integer;
begin
  Tam := Length(Str);
  I := 1;
  while (I <= Tam) and (Str[I] = ' ') do
    Inc(I);
  if I > 1 then
    Str := Copy(Str, I, 999);
  I := Length(Str);
  while (I > 0) and (Str[I] = ' ') do
    Dec(I);
  Result := Copy(Str, 1, I);
end;

procedure ExecutaForm(FormClass: TFormClass; var Reference);
begin
  Screen.Cursor := crHourGlass;
  try
    if TForm(Reference) = nil then
      Application.CreateForm(FormClass, TForm(Reference))
    else
    begin
      if TForm(Reference).WindowState = wsMinimized then
        TForm(Reference).WindowState := wsNormal;
      TForm(Reference).BringToFront;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function CopiaArquivo(Origem, Destino: string): Boolean;
var
  TamBloco, Tamanho: Longint;
  ArqOrigem, ArqDestino: file;
  Buffer: Pointer;

  function Le(var Reg): Boolean;
  var
    Buff: Byte absolute Reg;
  begin
    {$I-}BlockRead(ArqOrigem, Buff, TamBloco); {$I+}
    Result := IOResult = 0;
  end;

  function Grava(var Reg): Boolean;
  var
    Buff: Byte absolute Reg;
  begin
    {$I-}BlockWrite(ArqDestino, Buff, TamBloco); {$I+}
    Result := IOResult = 0;
  end;

begin
  Result := False;
  AssignFile(ArqOrigem, Origem);
  AssignFile(ArqDestino, Destino);
  {$I-}Reset(ArqOrigem, 1); {$I+}
  if IOResult <> 0 then
    Exit;
  {$I-}Rewrite(ArqDestino, 1); {$I+}
  if IOResult <> 0 then
  begin
    {$I-}CloseFile(ArqOrigem); {$I+}
    Exit;
  end;
  GetMem(Buffer, FatorBloco);
  Tamanho := FileSize(ArqOrigem);
  TamBloco := FatorBloco;
  while Tamanho > 0 do
  begin
    if Tamanho < FatorBloco then
      TamBloco := Tamanho;
    if not Le(Buffer^) then
      Break;
    if not Grava(Buffer^) then
      Break;
    Tamanho := Tamanho - TamBloco;
  end;
  Result := Tamanho = 0;
  {$I-}CloseFile(ArqOrigem); {$I+}
  if IOResult <> 0 then
    Result := False;
  {$I-}CloseFile(ArqDestino); {$I+}
  if IOResult <> 0 then
    Result := False;
  FreeMem(Buffer, FatorBloco);
  if not Result then
    DeleteFile(Destino);
end;

function CopiaArquivosMascara(Orig, Dest, Masc: string): Boolean;
var
  DirInfo: TSearchRec;
begin
  Result := True;
  if FindFirst(DiretorioComBarra(Orig) + Masc, faArchive, DirInfo) = 0 then
    repeat
      Result := CopiaArquivo(DiretorioComBarra(Orig) + DirInfo.Name, DiretorioComBarra(Dest) + DirInfo.Name);
    until FindNext(DirInfo) <> 0;
end;

function PadR(InStr: string; TotalLen: Integer): string;
begin
  Result := InStr;
  while Length(Result) < TotalLen do Result := Result + ' ';
end;

function PadL(InStr: string; TotalLen: Integer): string;
begin
  Result := InStr;
  while Length(Result) < TotalLen do Result := ' ' + Result;
end;

function Center(InStr: string; TotalLen: Integer): string;
var
  NumSpace: Integer;
  Temp: string;
begin
  NumSpace := (TotalLen - Length(InStr)) div 2;
  Temp := '';
  while Length(Temp) < NumSpace do Temp := Temp + ' ';
  Result := Temp + InStr + Temp;
  while Length(Result) < TotalLen do Result := Result + ' ';
end;

function DataAtual: TDateTime;
begin
  DataAtual := Date;
end;

function HoraAtual: string;
var
  Hora: string;
begin
  Hora := TimeToStr(Time);
  HoraAtual := Copy(Hora, 1, 2) + Copy(Hora, 4, 2) + Copy(Hora, 7, 2);
end;

function Space(TotalLen: Integer): string;
begin
  Result := '';
  while Length(Result) < TotalLen do Result := Result + ' ';
end;

{ escreve por extenso um numero entre 0 e 999 }
function TrataGrupo(const S: String): String;
const
  Num1a19: array [1..19] of String = (
    'UM', 'DOIS', 'TRES', 'QUATRO', 'CINCO',
    'SEIS', 'SETE', 'OITO', 'NOVE', 'DEZ',
    'ONZE', 'DOZE', 'TREZE', 'QUATORZE', 'QUINZE',
    'DEZESSEIS', 'DEZESSETE', 'DEZOITO', 'DEZENOVE');

  Num10a90: array [1..9] of String = (
    'DEZ', 'VINTE', 'TRINTA', 'QUARENTA', 'CINQUENTA',
    'SESSENTA', 'SETENTA', 'OITENTA', 'NOVENTA');

  Num100a900: array [1..9] of String = (
    'CENTO', 'DUZENTOS', 'TREZENTOS', 'QUATROCENTOS', 'QUINHENTOS',
    'SEISCENTOS', 'SETECENTOS', 'OITOCENTOS', 'NOVECENTOS');
var
  N: Integer;
  Tam: Integer;
  Aux: String;

  function Trata0a99(const S: String; N: Integer): String;
  begin
    case N of
      0:
        Result := '';
      1..19:
        Result := Num1a19[N];
      20..99:
      begin
        Result := Num10a90[Ord(S[1]) - Ord('0')];
        if S[2] <> '0' then
          Result := Result + ' E ' + Num1a19[Ord(S[2]) - Ord('0')];
      end;
    end;
  end;

  function Trata101a999(const S: String; N: Integer): String;
  var
    Aux: String[3];
  begin
    Result := Num100a900[Ord(S[1]) - Ord('0')];
    if (S[2] <> '0') or (S[3] <> '0') then
    begin
      Aux := Copy(S, 2, 2);
      Result := Result + ' E ' + Trata0a99(Aux, StrToInt(Aux));
    end;
  end;

begin
  N := StrToInt(S);
  case N of
    0..99: Result := Trata0a99(IntToStr(N), N);
    100: Result := 'CEM';
    101..999: Result := Trata101a999(S, N);
  end;
end;

function PorExtenso(FValor: Double): String;
var
  Lst: TStringList;
  I: Integer;
  Aux: String;
  Grupo: String;
  IndGrupo: Integer;
  Truncado: Longint;
begin
  Lst := nil;
  Result := '';
  try
    if FValor = 0.0 then
    begin
      Result := 'ZERO ' + 'REAIS';
      Exit;
    end;
    Lst := TStringList.Create;
    Grupo := '';
    Aux := FormatFloat('#,##0.00', FValor);

    // separa em grupos
    for I := 1 to Length(Aux) do
      if (Aux[I] = '.') or (Aux[I] = ',') then
      begin
        Lst.Add(Grupo);
        Grupo := '';
      end
      else
        Grupo := Grupo + Aux[I];
    Lst.Add(Grupo); // inclui o ultimo grupo

    // trata os bilhoes
    I := 0;
    if Lst.Count > 4 then
    begin
      Result := TrataGrupo(Lst[I]);
      if StrToInt(Lst[I]) = 1 then
        Result := Result + ' BILHAO'
      else
        Result := Result + ' BILHOES';
      Inc(I);
    end;

    // trata os milhoes
    if (Lst.Count > 3) then
    begin
      if StrToInt(Lst[I]) <> 0 then
      begin
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + TrataGrupo(Lst[I]);
        if StrToInt(Lst[I]) = 1 then
          Result := Result + ' MILHAO'
        else
          Result := Result + ' MILHOES';
      end;
      Inc(I);
    end;

    // trata os milhares
    if Lst.Count > 2 then
    begin
      if StrToInt(Lst[I]) <> 0 then
      begin
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + TrataGrupo(Lst[I]);
        Result := Result + ' MIL';
      end;
      Inc(I);
    end;

    // trata as unidades
    if StrToInt(Lst[I]) > 0 then
    begin
      if Length(Result) > 0 then
        Result := Result + ' E ';
      Result := Result + TrataGrupo(Lst[I]);
    end;
    Truncado := Trunc(FValor);
    if Truncado = 1 then
      Result := Result + ' ' + 'REAL'
    else if (Truncado = 1000000) or
            (Truncado = 10000000) or
            (Truncado = 100000000) or
            (Truncado = 1000000000) then
      Result := Result + ' DE ' + 'REAIS'
    else if Truncado <> 0 then
      Result := Result + ' ' + 'REAIS';
    Inc(I);

    // trata os centavos
    if StrToInt(Lst[I]) = 0 then
      Exit;
    if Truncado > 0 then
      {Result := Result + ', ';}
      Result := Result + ' E ';
    Result := Result + TrataGrupo(Lst[I]);
    if StrToInt(Lst[I]) = 1 then
      Result := Result + ' ' + 'CENTAVO'
    else
      Result := Result + ' ' + 'CENTAVOS';
    if Truncado = 0 then
      Result := Result + ' DE ' + 'REAL';

  finally
    // trata tipo texto
    Result := AnsiUpperCase(Result);
    if Lst <> nil then
      Lst.Free;
  end;
end;

function DDMMAA( Data: string ): string;
var
  sDia: string;
  sMes: string;
  sAno: string;
begin
  sDia := Copy( Data, 1, 2 );
  sMes := Copy( Data, 4, 2 );
  sAno := Copy( Data, 9, 2 );
  if sDia + sMes + sAno = '      ' then
    DDMMAA := ''
  else
    DDMMAA := sDia + '/' + sMes + '/' + sAno;
end;

function StrZero(N: integer; Tamanho: integer): string;
var
  Conteudo: string;
  Diferenca: Integer;
begin
  Conteudo := IntToStr( N );
  Diferenca := Tamanho - Length( Conteudo );
  if Diferenca > 0 then
    Conteudo := ConstStr( '0', Diferenca ) + Conteudo;
  StrZero := Conteudo;
end;

function UltimoDiaDoMes( MesAno: string ): string;
var
  sMes: string;
  sAno: string;
begin
  sMes := Copy( MesAno, 1, 2 );
  sAno := Copy( MesAno, 3, 4 );
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
    Copy( StrZero( sAno, 4 ), 3, 2 );
end;

function Ano( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  Ano := StrZero( sAno, 4 );
end;

function Encript(Encript : String): string;
var
  Cod: String;
  Codi_go: String;
  Qt_Expc: Integer;
  X : Integer;
  POrd: Integer;
  D: string;
begin
  Cod := Encript;
  Codi_go := '';
  Qt_Expc := Length(Encript);
  for X := QT_EXPC downto 1 do
    Codi_go := Codi_go + Copy(Cod,X,1);
  Cod:= '';
  for X := 1 TO Qt_Expc do
  begin
    D:= Copy(Codi_go,X,1);
    Pord := Ord(D[1]);
    if X/2 = INT(X/2) then
      Cod := Cod+CHR(Pord+1)
    else
      Cod := Cod+CHR(Pord-1);
  end;
  Codi_go := Cod;
  Result := Codi_go;
end;

function Decript(Decript : String): string;
var
  Cod: String;
  Codi_go: String;
  Qt_Expc: Integer;
  X : Integer;
  POrd: Integer;
  D: string;
  Resto: Integer;
begin
  Cod := Decript;
  Codi_go := '';
  Qt_Expc := Length(Decript);
  Resto := Length(Decript) mod 2;
  for X := QT_EXPC downto 1 do
    Codi_go := Codi_go + Copy(Cod,X,1);
  Cod:= '';
  for X := 1 TO Qt_Expc do
  begin
    D:= Copy(Codi_go,X,1);
    Pord := Ord(D[1]);
    if Resto > 0 then
    begin
      if not (X/2 = INT(X/2)) then
        Cod := Cod+CHR(Pord+1)
      else
        Cod := Cod+CHR(Pord-1);
    end
    else
    begin
      if X/2 = INT(X/2) then
        Cod := Cod+CHR(Pord+1)
      else
        Cod := Cod+CHR(Pord-1);
    end;
  end;
  Codi_go := Cod;
  Result := Codi_go;
end;

function TrocaString(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := UpperCase(S);
    Patt := UpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function ContaOcorrencia(Substr: string; S: string): Integer;
Var
  Retorno,I: Integer;
begin
  Retorno := 0;
  for I := 0 to Length(S)-1 do
  begin
    if S[I] = Substr then
      Inc(Retorno);
  end;
  Result := Retorno;
end;

function ProcuraRestricao(NomeTabela, Tipo: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  if Sistema.Master then
    exit;
  I := 0;
  if NomeTabela[1] <> 'D' then
    NomeTabela := 'D'+NomeTabela;
  while (I <= Sistema.OpcoesTabela.Count-1) and
        (not Result) do
  begin
    if Trim(NomeTabela) = Trim(Copy(Sistema.OpcoesTabela[I],01,20)) then
      if Pos(Tipo,Trim(Copy(Sistema.OpcoesTabela[I],21,20))) > 0 then
        Result := True;
    Inc(I);
  end;
end;

procedure DesabilitaFuncoesEd;
begin
  {
    Ajusta Janelas e Pano de Fundo
  }
  Sistema.JanelasMDI := Sistema.JanelasMDI - 01;
  if Sistema.JanelasMDI <= 0 then
    FormPrincipal.PnImagemFundo.Visible := True;
  {
    Finaliza botões da barra superior
  }
  FormPrincipal.BarraPrincipal.Visible := False;
  FormPrincipal.BtnLocalizar.Visible   := False;
  FormPrincipal.BtnIncluir.Visible     := False;
  FormPrincipal.BtnModificar.Visible   := False;
  FormPrincipal.BtnExcluir.Visible     := False;
  FormPrincipal.BtnPrimeiro.Visible    := False;
  FormPrincipal.BtnAnterior.Visible    := False;
  FormPrincipal.BtnProximo.Visible     := False;
  FormPrincipal.BtnUltimo.Visible      := False;
  {
    Finaliza Menu Manutenção
  }
  FormPrincipal.Manutencao.Enabled   := False;
  {
    Finaliza Menu Consulta
  }
  FormPrincipal.Consulta.Enabled         := False;
end;

function CalcC(N1,N2: Extended; Operador: String; Decimal: Integer): Extended;
Var Masc: String;
    I: Integer;
    Resultado: Extended;
begin
  Masc := '0.';
  for I:=0 to decimal-1 do
    Masc := Masc + '0';
  N1 := StrToFloat(FormatFloat(Masc,N1));
  N2 := StrToFloat(FormatFloat(Masc,N2));
  if Operador = '+' then
    Resultado := N1 + N2
  else if Operador = '-' then
    Resultado := N1 - N2
  else if Operador = '/' then
    Resultado := N1 / N2
  else if Operador = '*' then
    Resultado := N1 * N2;
  Result := StrToFloat(FormatFloat(Masc,Resultado));
end;

function Exponencial(N1: Extended; N2: Integer): Extended;
Var I: Integer;
    Resultado: Extended ;
begin
  Resultado := 1;
  for I:=1 to N2 do
    Resultado := Resultado * N1;
  Result := Resultado;
end;

function StrNumerica(N: String) : Boolean;
Var I: Integer;
    Ok, Resultado: Boolean;
begin
  N := Trim(N);
  Ok := False;
  Resultado := True;
  for I := 1 to Length(N) do
    case N[I] of
      '0'..'9', '.': Ok := True;
    else
      Resultado := False;
    end;
  if (Resultado) and (Ok) then
    Result := True
  else
    Result := False;
end;

function ConverteStrToLog(Valor: String): Boolean;
begin
  if Valor = 'T' then
    Result := True
  else
    Result := False;
end;

function ConverteLogico(Valor: Boolean): string;
begin
  if Valor then
    Result := 'T'
  else
    Result := 'F';
end;

Function SerialHD(FDrive:String) :String;
Var Serial:DWord;
    DirLen,Flags: DWord;
    DLabel : Array[0..11] of Char;
begin
  Try
    GetVolumeInformation(PChar(FDrive+':\'),dLabel,12,@Serial,DirLen,Flags,nil,0);
    Result := IntToHex(Serial,8);
  Except Result :='';
  end;
end;

function FracToStr(Valor: Extended): String;
begin
  Result := FloatToStr(Valor);
  Result := TrocaString(Result,',','.',[rfReplaceAll]); // Converte (,) em (.)
end;

function VNivel: Boolean; { Libera acesso ao Módulo }
begin
  Result := True;
  if (Sistema.ControleAcesso) and (not Sistema.Master) then
  begin
    FormAcesso := TFormAcesso.Create(Application);
    try
      FormAcesso.SenhaInicial := Sistema.SenhaInicial;
      FormAcesso.Tentativas   := 03;
      FormAcesso.QtdTentativas:= 01;
      FormAcesso.Liberacao    := True;
      { Vamos Pedir o Nome e Senha do Usuário Master }
      if FormAcesso.ShowModal <> mrOk then
        Result := False;
    finally
      FormAcesso.Free;
    end;
  end;
end;

function LFill(aString: string; aCaracter: Char; aTamanho: integer): string;
begin
  Result := StringOfChar(aCaracter, aTamanho - length(aString)) + aString;
end;

function RFill(aString: string; aCaracter: Char; aTamanho: integer): string;
begin
  Result := aString + StringOfChar(aCaracter, aTamanho - length(aString));
end;

function IIF(aExpressao: Boolean; aVerdadeiro, aFalso: Variant): Variant;
begin
  if aExpressao then
    Result := aVerdadeiro
  else
    Result := aFalso;
end;

function Envia_Email(const Server: String; const Port: Integer;const
  UserField, PasswordField, FromField, ToField, SubjectField,
  TextField, FileName, AttachName: String; ShowProgress: Boolean = True; FileLog: String = ''): String;
var
  FR_Mail: TFR_SMTPClient;
begin
  FR_Mail := TFR_SMTPClient.Create(nil);
  try
    FR_Mail.Host        := Server;
    FR_Mail.Port        := Port;
    FR_Mail.User        := UserField;
    FR_Mail.Password    := PasswordField;
    FR_Mail.MailFrom    := FromField;
    FR_Mail.MailTo      := ToField;
    FR_Mail.MailSubject := SubjectField;
    FR_Mail.MailText    := TextField;
    FR_Mail.MailFile    := FileName;
    FR_Mail.AttachName  := AttachName;
    FR_Mail.ShowProgress:= ShowProgress;
    FR_Mail.LogFile     := FileLog;
    FR_Mail.Open;
  finally
    Result := FR_Mail.Errors.Text;
    FR_Mail.Free;
  end;
end;

procedure DB_LoginConexao(Parametro: TStrings; Usuario, Senha: String);
var
  I: Integer;
begin
  if (Trim(Usuario) = '') and (Trim(Senha) = '') then
    exit;
  for I:=0 to Parametro.Count-1 do
    if Pos('USER NAME', Parametro[I]) > 0 then
      Parametro[I] := 'USER NAME='+Usuario
    else if Pos('USER_NAME', Parametro[I]) > 0 then
      Parametro[I] := 'USER_NAME='+Usuario
    else if Pos('USER '+#39, Parametro[I]) > 0 then
      Parametro[I] := 'USER '+#39+Usuario+#39
    else if Pos('PASSWORD '+#39, Parametro[I]) > 0 then
      Parametro[I] := 'PASSWORD '+#39+Senha+#39
    else if Pos('PASSWORD', Parametro[I]) > 0 then
      Parametro[I] := 'PASSWORD='+Senha;
end;

function DB_User(Index: Integer): String;
begin
  case Index of
    0: DB_User := 'Interbase';
    1: DB_User := 'Firebird';
    2: DB_User := 'SQLBase';
    3: DB_User := 'Oracle';
    4: DB_User := 'SQLServer';
    5: DB_User := 'Sybase';
    6: DB_User := 'DB2';
    7: DB_User := 'Informix';
    8: DB_User := 'ODBC';
    9: DB_User := 'MySQL';
    10: DB_User := 'PostgreSQL';
    11: DB_User := 'OLEDB';
  end;
end;

function DifTempo(hora_i, hora_f: TTime): String;
var
  totsegdia, hora1, hora2, final: Integer;
  resultado: String;

  function Segundos(tempo,inicio: String): Integer;
  var
    Horas, Minutos, s1, s2, Segs, Final: Integer;
  begin
    if inicio <> '' then
    begin
      Horas:=StrToInt(Copy(Tempo,01,2))-StrToInt(Copy(Inicio,1,2));
      Minutos:=StrToInt(Copy(Tempo,4,2))-StrToInt(Copy(Inicio,4,2));
      s1:=StrToInt(Copy(Tempo,7,2));
      s2:=StrToInt(Copy(Inicio,7,2));
      if s2<=s1 then
        segs:=S1-S2
      else
        segs :=S1+(60-S2);
      tempo:=FormatFloat('00',horas) + ':' + FormatFloat('00',minutos) + ':' + FormatFloat('00',segs);
    end;
    final:= StrToInt(Copy(tempo,01,2))*3600 + StrToInt(Copy(tempo,4,2))*60 +
    StrToInt(Copy(tempo,7,2));
    Segundos := final;
  end;

begin
  totsegdia:=86400; // total de segundos de 1 dia
  hora1:=segundos(TimeToStr(hora_i),'');
  hora2:=segundos(TimeToStr(hora_f),'');
  if hora2<hora1 then // mudou de dia
     hora2:=hora2+totsegdia;
  final:=hora2-hora1;
  Resultado := FormatFloat('00',Int((final div 3600) mod 24)) + ':' +
  FormatFloat('00',Int((final div 60) mod 60)) +':' +
  FormatFloat('00',Int(final mod 60));
  DifTempo := Resultado;
end;

function RepeatChar(Ch: Char; S: string): string;
var
  i: Integer;
begin
  i := 1;
  Result := S;
  while i <= Length(Result) do begin
    if Result[i] = Ch then begin
      Insert( Ch, Result, i+1 );
      Inc(i);
    end;
    Inc(i);
  end;
end;

procedure Atualiza_Status;
begin
  if Assigned(FormPrincipal) and
     Assigned(FormPrincipal.StatusBarPrincipal) then
  begin
    FormPrincipal.StatusBarPrincipal.Panels[0].Text := 'Usuário: '+Sistema.Usuario;
    FormPrincipal.StatusBarPrincipal.Panels[1].Text := Sistema.BancoDados;
    FormPrincipal.StatusBarPrincipal.Panels[2].Text := 'Empresa: '+Sistema.EmpresaUsr;
    FormPrincipal.StatusBarPrincipal.Panels[3].Text := 'Última Operação: ' + DifTempo(Sistema.Conexao_i, Sistema.Conexao_f);
    FormPrincipal.StatusBarPrincipal.Panels[4].Text := 'Estação: ' + Sistema.Estacao;
    Application.ProcessMessages;
  end;
end;

function AtribuiAspas(S: String): String;
begin
  AtribuiAspas := Format('''%s''', [RepeatChar('''', S)]);
end;

end.
