unit Rotinas;

interface

uses Forms, Classes, WinProcs, Controls, Menus, ExtCtrls, Printers, Mask,
     Graphics, Sysutils, stdctrls, XNum, XEdit, XDate, comctrls, Dialogs, DB;

function ContaOcorrencia(Substr: char; S: string): Integer;
function MascNum(N: Extended; Picture: string): string;
function ConstStr(Ch: string; N: byte): string;
function DiretorioComBarra(NomeDir: string): string;
function DiretorioSemBarra(NomeDir: string): string;
function TrocaString(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
function ArrayToString(OpenArray: array of string; Separador: char): string;
procedure StringToArray(St: string; Separador: char; Lista: TStringList; Delete_chr: Boolean = False);
function DirWindows: string;
function RetiraBrancos(Str: string): string;
procedure CriaForm(FormClass: TFormClass; var Reference);
{ Rotinas para copiar arquivos }
function CopiaArquivo(Origem, Destino: string): Boolean;
function CopiaArquivosMascara(Orig, Dest, Masc: string): Boolean;
{ Rotinas para auxiliar na impressão de relatórios }
function PadR(InStr: string; TotalLen: Integer): string;
function PadL(InStr: string; TotalLen: Integer): string;
function Center(InStr: string; TotalLen: Integer): string;
function Space(TotalLen: Integer): string;
function CommandDos: string;
function ConverteLogico(Valor: Boolean): string;
function ConverteStrToLog(Valor: String): boolean;
function RetiraHK(S: string): string;
{Validar CNPJ}
function VCNPJ(Dado: string): Boolean;
{Validar CPF}
function VCPF(Dado: string): Boolean;
function RetiraEspacos(Arquivo: String): String;
procedure ExecutaForm(FormClass: TFormClass; var Reference);
function WinExecAndWait32(FileName   : String;
                          WorkDir    : String;
                          Visibility : integer): Cardinal;
function GetDosOutput(const CommandLine:string;
                      WorkDir: String;
                      Visibility: Integer;
                      Var Linha: String;
                      Compilacao: Boolean): Cardinal;
procedure Busca_PastaFontes(Index: Integer);

type
  TTipoMsg = (ModAdvertencia, ModErro, ModInformacao, ModConfirmacao, ModPadrao);
  TTipoBtn = (ModOk, ModSim, ModNao, ModCancela, ModTodos);
  TTipoButtons = set of TTipoBtn;

function Mensagem(Const Msg: String; Tipo: TTipoMsg; Botoes: TTipoButtons): Word;
function Encript(Encript : String): string;
function Decript(Decript : String): string;
{ Coloca zeros a esquerda }
function StrZero(N: integer; Tamanho: integer): string;

{ Retorna o Dia de uma data }
function Dia( Data: TDateTime ): string;

{ Retorna o Mes de uma data }
function Mes( Data: TDateTime ): string;

{ Retorna o Mes/Ano de uma data }
function MesAno( Data: TDateTime ): string;

{ Retorna o Ano de uma data }
function Ano( Data: TDateTime ): string;

{ Retorna o ultimo dia do mes }
function UltimoDiaDoMes( MesAno: string ): string;

{ Retorna a data no formato MM/DD/AA }
function DDMMAA( Data: string ): string;

{ Retorna o Número da Tecla de Atalho }
function TeclaAtalho(Tecla: string; RetornaNumero: boolean): String;

function MontaMascara(var campo : string; mascara : string) : string;
{Validar data no formato ddmmaa ou ddmmaaaa}
function DATAVALIDA(Dado: string): Boolean;
function IIF(aExpressao: Boolean; aVerdadeiro, aFalso: Variant): Variant;
function R_DataType(S: String): TFieldType;
function P_DataType(ft: TFieldType): integer;
function DB_DataType(S: String): String;
procedure ConfiguraMascaraCampo(Campo: TField; Titulo, Mascara: String; Indice, Largura: Integer; Visivel: Boolean);
function RepeatChar(Ch: Char; S: string): string;
function AtribuiAspas(S: String): String;
procedure ChamaAjuda(Titulo: String = 'Ajuda do X-Maker'; URL: String = 'Doc\Ajuda.html');

Const FREDT = False;
      MSG_CRACK = 'Foi encontrado um problema com seu Nº de Licença de uso !'+^M+^M+'entre em contato com nosso departamento de suporte ...';
      const Bancos_Suportados: array[1..12] of String = ('Interbase', 'Firebird', 'SQLBase',
                                                         'Oracle', 'SQLServer', 'Sybase',
                                                         'DB2', 'Informix', 'ODBC',
                                                         'MySQL', 'PostgreSQL', 'OLEDB');
      const Tipos_Suportados: array[1..25] of String = ('Alfanumérico', 'Número Inteiro', 'Número Fracionário',
                                                        'Data' , 'Memo', 'Imagem',
                                                        'ftString', 'ftSmallint', 'ftInteger',
                                                        'ftWord', 'ftBoolean', 'ftFloat',
                                                        'ftCurrency', 'ftDate', 'ftTime',
                                                        'ftDateTime', 'ftBytes', 'ftAutoInc',
                                                        'ftBlob', 'ftGraphic', 'ftWideString',
                                                        'ftLargeInt', 'ftVariant', 'ftBCD', 'ftRichEdit');
      const Edicoes_Suportados: array[1..6] of String = ('Edição Padrão (Edit)',
                                                         'Lista Interna (Combo Drop)',
                                                         'Optativo (RadioGroup)',
                                                         'Conferência (CheckBox)',
                                                         'Lista Externa (Estrangeira)',
                                                         'Lista Interna (ListBox)');
      const Tipos_Campo_Suportados: array[1..18] of String = ('Auto Identificação',
                                                              'Blob',
                                                              'Char',
                                                              'Date',
                                                              'Decimal',
                                                              'Double Precision',
                                                              'Float',
                                                              'Integer',
                                                              'Numeric',
                                                              'Smallint',
                                                              'Time',
                                                              'Timestamp',
                                                              'Varchar',
                                                              'Datetime',
                                                              'Text',
                                                              'Image',
                                                              'Bit',
                                                              'Money');
      const Tipos_Relacionamento: array[1..3] of String = ('Relacionamento',
                                                           'Exclusão Restrita',
                                                           'Exclusão em Cascata');
      const Tipos_Processo: array[1..5] of String = ('Processo Direto/Inverso',
                                                     'Lançamentos',
                                                     'Processo Avulso/Direto',
                                                     'Processo Avulso/Inverso',
                                                     'Lançamentos Avulso');
      const Tipos_Trigger: array[1..2] of String = ('Antes da Atualização',
                                                    'Depois da Atualização');
      const Disparo_Trigger: array[1..3] of String = ('Inclusão',
                                                      'Modificação',
                                                      'Exclusão');
      const Tipos_Script: array[1..4] of String = ('Avulso',
                                                   'Após Criação Banco de Dados',
                                                   'Ao Inicializar Sistema',
                                                   'Ao Finalizar Sistema');

      const Datas: array[1..19] of TFieldType = (ftString, ftSmallint, ftInteger,
                                                 ftWord, ftBoolean, ftFloat,
                                                 ftCurrency, ftDate, ftTime,
                                                 ftDateTime, ftBytes, ftAutoInc,
                                                 ftBlob, ftGraphic, ftWideString,
                                                 ftLargeInt, ftVariant, ftBCD, ftBlob);
type
  TProjeto = Record
    Pasta               : string;  // DirProjeto
    Nome                : string;  // ArquivoProjeto
    ArquivoMenu         : string;
    ArquivoForm         : string;
    Titulo              : string;  // TituloProjeto
    Dicionario          : string;  // DirDicionario
    Pasta_projeto       : string;  // Pasta do Projeto
    Servidor_Pro        : string;  // Servidor (IP)
    Servidor_Dic        : string;  // Servidor (IP)
    ArquivoProj         : string;  // ArqDpr
    Compilador          : string;  // CompiladorProjeto
    Parametro           : string;  // ParametroCompilador
    AjudaLinguagem      : string;  // AjudaDelphi
    VersaoGerador       : string;  // VersaoGerador
    VersaoGerador_v     : string;
    ReleaseGerador      : string;  // ReleaseGerador
    Beta_Versao         : string;
    Beta_Release        : string;
    PastaGerador        : string;  // DirModular
    PastaFontes         : string;
    UsoemRede           : boolean;
    Tabs                : Integer; // Tamanho de um Tab
    Dicionario_hab      : boolean;
    Registro_usr        : string;
    Adapter             : boolean;
    Posicao_BD          : integer;
    Posicao_FD          : integer;
    Posicao_VR          : integer;
    Posicao_IT          : integer;
    Formulario_Ult      : String;
    Formulario_Ult_ID   : Integer;
    Relatorio_Ult       : String;
    Relatorio_Ult_ID    : Integer;
    usr_firebird        : String;
    pwd_firebird        : String;
    RXLib               : Boolean;
  end;

var
  ArqDefBarra         : string;
  PCaracter           : String;
  PSubstituir         : String;
  StrCompTree         : String;
  StrCompImFundo      : String;
  StrCompImSplash     : String;
  Erro_de_Classe      : Boolean;
  TituloXMaker        : String;
  Projeto             : TProjeto;
  C_RGT_USR           : String;
  C_CRACK             : Boolean;
  MsgSalvar           : Boolean;
  Lista_Find_G, Lista_Subst_G: TStringList;

implementation

uses DBTables {$IFDEF VER80}, Graphics {$ENDIF}, Mensagem, Princ, FrmCompile, Ajuda;

const
  FatorBloco = 32767;

function ContaOcorrencia(Substr: char; S: string): Integer;
var
  I,T: Integer;
begin
  T := 0;
  for I:=1 to Length(S) do
    if S[I] = Substr then
      Inc(T);
  ContaOcorrencia := T;
end;

function MascNum(N: Extended; Picture: string): string;
var
  St, StInt,
  StDec: string;
  NumDec, I, J: byte;
  AchouVirgula: boolean;
begin
  St := '';
  NumDec := 0;
  AchouVirgula := false;
  for I := 1 to Length(Picture) do
    case Picture[I] of
      'Z', '9': if AchouVirgula then
          Inc(NumDec);
      ',': AchouVirgula := true;
    end;
  Str(N: 1: NumDec, St);
  if NumDec > 0 then
    StInt := Copy(St, 1, Pos('.', St) - 1)
  else
    StInt := St;
  if N < 0 then
    Delete(StInt, Pos('-', St), 1)
  else
    if Pos('-', Picture) = 1 then
      Picture[1] := ' ';
  if NumDec > 0 then
  begin
    StDec := Copy(St, Pos('.', St) + 1, Length(St));
    J := 1;
    for I := Pos(',', Picture) + 1 to Length(Picture) do
      if Picture[I] in ['9', 'Z'] then
      begin
        Picture[I] := StDec[J];
        Inc(J);
      end;
    I := Pos(',', Picture) - 1;
  end
  else
    I := Length(Picture);
  J := Length(StInt);
  while I > 0 do
  begin
    if J > 0 then
    begin
      if UpCase(Picture[I]) in ['Z', '9'] then
      begin
        Picture[I] := StInt[J];
        Dec(J);
      end;
    end
    else
      if (Picture[I] <> '-') or (N >= 0) then
        case UpCase(Picture[I]) of
          '9': Picture[I] := '0';
          'Z': Picture[I] := ' ';
          '.': if I > 1 then
              if Picture[I - 1] = '9' then
                Picture[I] := '.'
              else
                Picture[I] := ' '
            else
              Picture[I] := ' ';
        end;
    Dec(I);
  end;
  MascNum := Picture;
end; {MascNum}

function ConstStr(Ch: string; N: byte): string;
var
  St: string[255];
begin
  FillChar(St, N + 1, Ch[1]);
  Result := copy(St, 1, N);
end; {ConstStr}

function DiretorioComBarra(NomeDir: string): string;
begin
  if NomeDir[Length(NomeDir)] <> '\' then
    DiretorioComBarra := NomeDir + '\'
  else
    DiretorioComBarra := NomeDir;
end; {DiretorioComBarra}

function DiretorioSemBarra(NomeDir: string): string;
begin
  if (NomeDir[Length(NomeDir)] = '\') and
  (NomeDir[Length(NomeDir) - 1] <> ':') then
    DiretorioSemBarra := Copy(NomeDir, 1, Length(NomeDir) - 1)
  else
    DiretorioSemBarra := NomeDir;
end; {DiretorioSemBarra}

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
end; {ArrayToString}

procedure StringToArray(St: string; Separador: char; Lista: TStringList; Delete_chr: Boolean = False);
var
  I: Integer;
begin
  if Delete_Chr then
  begin
    St := TrocaString(St, #$D, '', [rfReplaceAll]);
    St := TrocaString(St, #$A, '', [rfReplaceAll]);
  end;
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
end; {StringToArray}

function DirWindows: string;
var
  Dir: array[0..255] of char;
begin
  GetWindowsDirectory(Dir, 255);
  Result := StrPas(Dir);
end; {DirWindows}

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
end; {RetiraBrancos}

procedure CriaForm(FormClass: TFormClass; var Reference);
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
end; {CriaForm}

{ Rotinas para copiar arquivos }

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
  end; {Le}

  function Grava(var Reg): Boolean;
  var
    Buff: Byte absolute Reg;
  begin
    {$I-}BlockWrite(ArqDestino, Buff, TamBloco); {$I+}
    Result := IOResult = 0;
  end; {Grava}

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
end; {CopiaArquivo}

function CopiaArquivosMascara(Orig, Dest, Masc: string): Boolean;
var
  DirInfo: TSearchRec;
begin
  Result := True;
  if FindFirst(DiretorioComBarra(Orig) + Masc, faArchive, DirInfo) = 0 then
    repeat
      Result := CopiaArquivo(DiretorioComBarra(Orig) + DirInfo.Name, DiretorioComBarra(Dest) + DirInfo.Name);
    until FindNext(DirInfo) <> 0;
end; {CopiaArquivosMascara}

{ Rotinas para auxiliar na impressão de relatórios }

function PadR(InStr: string; TotalLen: Integer): string;
begin
  Result := InStr;
  while Length(Result) < TotalLen do Result := Result + ' ';
end; {PadR}

function PadL(InStr: string; TotalLen: Integer): string;
begin
  Result := InStr;
  while Length(Result) < TotalLen do Result := ' ' + Result;
end; {PadL}

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
end; {Center}

function Space(TotalLen: Integer): string;
begin
  Result := '';
  while Length(Result) < TotalLen do Result := Result + ' ';
end; {Space}

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

function MontaMascara(var campo : string; mascara : string) : string;
var a, b, c : string;
var x_p  : integer;
begin
    a := campo;
    b := campo;
    x_p := 0;
    repeat
        if  (mascara[x_p] = '-') or (mascara[x_p] = ',') or (mascara[x_p] = '.') or
            (mascara[x_p] = '(') or (mascara[x_p] = ')') or (mascara[x_p] = '/') or
            (mascara[x_p] = '\') or (mascara[x_p] = '*') or (mascara[x_p] = '|') or
            (mascara[x_p] = ':')
        then begin
            a := a;
            b := a;

            c := mascara;
            delete(c, 1, (x_p - 1));
            delete(c, 2, 20);
            delete (a, x_p, 20);
            delete (b, 1, (x_p - 1));
            a := a + c + b;
        end;
        inc(x_p);
    until (x_p > length(mascara));
    result := a;
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

function TeclaAtalho(Tecla: string; RetornaNumero:boolean): String;
var
  Teclas: array[0..109] of string;
  Posic, I : Integer;
begin
   Teclas[000] :='                    ';
   Teclas[001] :='                    ';
   Teclas[002] :='16449 Ctrl+A        ';
   Teclas[003] :='16450 Ctrl+B        ';
   Teclas[004] :='16451 Ctrl+C        ';
   Teclas[005] :='16452 Ctrl+D        ';
   Teclas[006] :='16453 Ctrl+E        ';
   Teclas[007] :='16454 Ctrl+F        ';
   Teclas[008] :='16455 Ctrl+G        ';
   Teclas[009] :='16456 Ctrl+H        ';
   Teclas[010] :='16457 Ctrl+I        ';
   Teclas[011] :='16458 Ctrl+J        ';
   Teclas[012] :='16459 Ctrl+K        ';
   Teclas[013] :='16460 Ctrl+L        ';
   Teclas[014] :='16461 Ctrl+M        ';
   Teclas[015] :='16462 Ctrl+N        ';
   Teclas[016] :='16463 Ctrl+O        ';
   Teclas[017] :='16464 Ctrl+P        ';
   Teclas[018] :='16465 Ctrl+Q        ';
   Teclas[019] :='16466 Ctrl+R        ';
   Teclas[020] :='16467 Ctrl+S        ';
   Teclas[021] :='16468 Ctrl+T        ';
   Teclas[022] :='16469 Ctrl+U        ';
   Teclas[023] :='16470 Ctrl+V        ';
   Teclas[024] :='16471 Ctrl+W        ';
   Teclas[025] :='16472 Ctrl+X        ';
   Teclas[026] :='16473 Ctrl+Y        ';
   Teclas[027] :='16474 Ctrl+Z        ';
   Teclas[028] :='49217 Ctrl+Alt+A    ';
   Teclas[029] :='49218 Ctrl+Alt+B    ';
   Teclas[030] :='49219 Ctrl+Alt+C    ';
   Teclas[031] :='49220 Ctrl+Alt+D    ';
   Teclas[032] :='49221 Ctrl+Alt+E    ';
   Teclas[033] :='49222 Ctrl+Alt+F    ';
   Teclas[034] :='49223 Ctrl+Alt+G    ';
   Teclas[035] :='49224 Ctrl+Alt+H    ';
   Teclas[036] :='49225 Ctrl+Alt+I    ';
   Teclas[037] :='49226 Ctrl+Alt+J    ';
   Teclas[038] :='49227 Ctrl+Alt+K    ';
   Teclas[039] :='49228 Ctrl+Alt+L    ';
   Teclas[040] :='49229 Ctrl+Alt+M    ';
   Teclas[041] :='49230 Ctrl+Alt+N    ';
   Teclas[042] :='49231 Ctrl+Alt+O    ';
   Teclas[043] :='49232 Ctrl+Alt+P    ';
   Teclas[044] :='49233 Ctrl+Alt+Q    ';
   Teclas[045] :='49234 Ctrl+Alt+R    ';
   Teclas[046] :='49235 Ctrl+Alt+S    ';
   Teclas[047] :='49236 Ctrl+Alt+T    ';
   Teclas[048] :='49237 Ctrl+Alt+U    ';
   Teclas[049] :='49238 Ctrl+Alt+V    ';
   Teclas[050] :='49239 Ctrl+Alt+W    ';
   Teclas[051] :='49240 Ctrl+Alt+X    ';
   Teclas[052] :='49241 Ctrl+Alt+Y    ';
   Teclas[053] :='49242 Ctrl+Alt+Z    ';
   Teclas[054] :='  112 F1            ';
   Teclas[055] :='  113 F2            ';
   Teclas[056] :='  114 F3            ';
   Teclas[057] :='  115 F4            ';
   Teclas[058] :='  116 F5            ';
   Teclas[059] :='  117 F6            ';
   Teclas[060] :='  118 F7            ';
   Teclas[061] :='  119 F8            ';
   Teclas[062] :='  120 F9            ';
   Teclas[063] :='  121 F10           ';
   Teclas[064] :='  122 F11           ';
   Teclas[065] :='  123 F12           ';
   Teclas[066] :='16496 Ctrl+F1       ';
   Teclas[067] :='16497 Ctrl+F2       ';
   Teclas[068] :='16498 Ctrl+F3       ';
   Teclas[069] :='16499 Ctrl+F4       ';
   Teclas[070] :='16500 Ctrl+F5       ';
   Teclas[071] :='16501 Ctrl+F6       ';
   Teclas[072] :='16502 Ctrl+F7       ';
   Teclas[073] :='16503 Ctrl+F8       ';
   Teclas[074] :='16504 Ctrl+F9       ';
   Teclas[075] :='16505 Ctrl+F10      ';
   Teclas[076] :='16506 Ctrl+F11      ';
   Teclas[077] :='16507 Ctrl+F12      ';
   Teclas[078] :=' 8304 Shift+F1      ';
   Teclas[079] :=' 8305 Shift+F2      ';
   Teclas[080] :=' 8306 Shift+F3      ';
   Teclas[081] :=' 8307 Shift+F4      ';
   Teclas[082] :=' 8308 Shift+F5      ';
   Teclas[083] :=' 8309 Shift+F6      ';
   Teclas[084] :=' 8310 Shift+F7      ';
   Teclas[085] :=' 8311 Shift+F8      ';
   Teclas[086] :=' 8312 Shift+F9      ';
   Teclas[087] :=' 8313 Shift+F10     ';
   Teclas[088] :=' 8314 Shift+F11     ';
   Teclas[089] :=' 8315 Shift+F12     ';
   Teclas[090] :='24688 Shift+Ctrl+F1 ';
   Teclas[091] :='24689 Shift+Ctrl+F2 ';
   Teclas[092] :='24690 Shift+Ctrl+F3 ';
   Teclas[093] :='24691 Shift+Ctrl+F4 ';
   Teclas[094] :='24692 Shift+Ctrl+F5 ';
   Teclas[095] :='24693 Shift+Ctrl+F6 ';
   Teclas[096] :='24694 Shift+Ctrl+F7 ';
   Teclas[097] :='24695 Shift+Ctrl+F8 ';
   Teclas[098] :='24696 Shift+Ctrl+F9 ';
   Teclas[099] :='24697 Shift+Ctrl+F10';
   Teclas[100] :='24698 Shift+Ctrl+F11';
   Teclas[101] :='24699 Shift+Ctrl+F12';
   Teclas[102] :='   45 Ins           ';
   Teclas[103] :=' 8237 Shift+Ins     ';
   Teclas[104] :='16429 Ctrl+Ins      ';
   Teclas[105] :='   46 Del           ';
   Teclas[106] :=' 8238 Shift+Del     ';
   Teclas[107] :='16430 Ctrl+Del      ';
   Teclas[108] :='32776 Alt+Bksp      ';
   Teclas[109] :='40968 Shift+Alt+Bksp';
   Posic := 0;
   if RetornaNumero then
   begin
     for I := 0 to 109 do
       if Trim(Copy(Teclas[I],07,14)) = Tecla then
         Posic := I;
     TeclaAtalho := Copy(Teclas[Posic],01,05);
   end
   else
   begin
     for I := 0 to 109 do
       if Trim(Copy(Teclas[I],01,05)) = Tecla then
         Posic := I;
     TeclaAtalho := Copy(Teclas[Posic],07,14);
   end;
end;

function Mensagem(Const Msg: String; Tipo: TTipoMsg; Botoes: TTipoButtons): Word;
Var
  B: TTipoBtn;
begin
  FormMensagem := TFormMensagem.Create(Application);
  Try
    FormMensagem.LbMensagem.Lines.Text := Msg;
    if Tipo = ModAdvertencia then
      FormMensagem.NrImagem := 1
    else if Tipo = ModErro then
      FormMensagem.NrImagem := 2
    else if Tipo = ModInformacao then
      FormMensagem.NrImagem := 3
    else if Tipo = ModConfirmacao then
      FormMensagem.NrImagem := 4
    else if Tipo = ModPadrao then
      FormMensagem.NrImagem := 0;
    if ModOk in Botoes then FormMensagem.Botoes[0] := True;
    if ModSim in Botoes then FormMensagem.Botoes[1] := True;
    if ModNao in Botoes then FormMensagem.Botoes[2] := True;
    if ModCancela in Botoes then FormMensagem.Botoes[3] := True;
    if ModTodos in Botoes then FormMensagem.Botoes[4] := True;
    Result := FormMensagem.ShowModal;
  Finally
    FormMensagem.Free;
  end;
end;

function CommandDos: String;
Var
  Comando,Variavel : String;
  Env     : PChar;
begin
  Env     := GetEnvironmentStrings;  
  Comando := '';
  While Env^ <> #0 do
  begin
    Variavel := StrPas(Env);
    if Copy(UpperCase(Variavel),01,07) = 'COMSPEC' then
      Comando := Copy(Variavel,Pos('=',Variavel)+1,Length(Variavel)) + ' /C ';
    Inc(Env,StrLen(Env)+1);
  end;
  Result := Comando;
end;

function ConverteStrToLog(Valor: String): Boolean;
begin
  if Valor = 'Sim' then
    Result := True
  else
    Result := False;
end;

function ConverteLogico(Valor: Boolean): string;
begin
  if Valor then
    Result := 'Sim'
  else
    Result := 'Não';
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

function DATAVALIDA(Dado: string): Boolean;
var
  SalvaFormato,
  DataExterna: string;
  DataInterna: TDateTime;
  Separador: string;
begin
  Result := True;
  Separador := DateSeparator;
  while Pos(Separador, Dado) > 0 do
    Delete(Dado, Pos(Separador, Dado), 1);
  if Length(Dado) = 6 then
    Dado := Copy(Dado, 1, 2) + Separador +
      Copy(Dado, 3, 2) + Separador + '19' +
      Copy(Dado, 5, 2)
  else
    if Length(Dado) = 8 then
      Dado := Copy(Dado, 1, 2) + Separador +
        Copy(Dado, 3, 2) + Separador +
        Copy(Dado, 5, 4)
    else
      Result := False;
  if Result then
  begin
    SalvaFormato := ShortDateFormat;
    DataInterna := 0;
    try
      ShortDateFormat := 'd' + Separador + 'm' + Separador + 'y';
      DataInterna := StrToDate(Dado);
    except
      on EConvertError do
      begin
        Result := False;
        ShortDateFormat := SalvaFormato;
      end;
    end;
    if Result then
    begin
      try
        ShortDateFormat := 'dd' + Separador + 'mm' + Separador + 'yyyy';
        DataExterna := DateToStr(DataInterna);
      except
        on EConvertError do
        begin
          Result := False;
          ShortDateFormat := SalvaFormato;
        end;
      end;
      if Result and (DataExterna <> Dado) then
        Result := False;
    end;
    ShortDateFormat := SalvaFormato;
  end;
end;

function RetiraHK(S: string): string;
begin
  while Pos('&', S) > 0 do
    Delete(S, Pos('&', S), 1);
  if Copy(S, Length(S) - 2, 3) = '...' then
    Delete(S, Length(S) - 2, 3);
  RetiraHK := S;
end;

function VCNPJ(Dado: string): Boolean;
var
  D1: array[1..12] of Byte;
  I,
  DF1,
  DF2,
  DF3,
  DF4,
  DF5,
  DF6,
  Resto1,
  Resto2,
  PrimeiroDigito,
  SegundoDigito: Integer;
begin
  Result := True;
  if Length(Dado) = 14 then
  begin
    for I := 1 to 12 do
      if Dado[I] in ['0'..'9'] then
        D1[I] := StrToInt(Dado[I])
      else
        Result := False;
    if Result then
    begin
      DF1 := 5 * D1[1] + 4 * D1[2] + 3 * D1[3] + 2 * D1[4] + 9 * D1[5] + 8 * D1[6] +
        7 * D1[7] + 6 * D1[8] + 5 * D1[9] + 4 * D1[10] + 3 * D1[11] + 2 * D1[12];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;
      DF4 := 6 * D1[1] + 5 * D1[2] + 4 * D1[3] + 3 * D1[4] + 2 * D1[5] + 9 * D1[6] +
        8 * D1[7] + 7 * D1[8] + 6 * D1[9] + 5 * D1[10] + 4 * D1[11] + 3 * D1[12] +
        2 * PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;
      if (PrimeiroDigito <> StrToInt(Dado[13])) or
        (SegundoDigito <> StrToInt(Dado[14])) then
        Result := False;
    end;
  end
  else
    if Length(Dado) <> 0 then
      Result := False;
end;

function VCPF(Dado: string): Boolean;
var
  D1: array[1..9] of Byte;
  I,
  DF1,
  DF2,
  DF3,
  DF4,
  DF5,
  DF6,
  Resto1,
  Resto2,
  PrimeiroDigito,
  SegundoDigito: Integer;
begin
  Result := True;
  if Length(Dado) = 11 then
  begin
    for I := 1 to 9 do
      if Dado[I] in ['0'..'9'] then
        D1[I] := StrToInt(Dado[I])
      else
        Result := False;
    if Result then
    begin
      DF1 := 10 * D1[1] + 9 * D1[2] + 8 * D1[3] + 7 * D1[4] + 6 * D1[5] + 5 * D1[6] +
        4 * D1[7] + 3 * D1[8] + 2 * D1[9];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;
      DF4 := 11 * D1[1] + 10 * D1[2] + 9 * D1[3] + 8 * D1[4] + 7 * D1[5] + 6 * D1[6] +
        5 * D1[7] + 4 * D1[8] + 3 * D1[9] + 2 * PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;
      if (PrimeiroDigito <> StrToInt(Dado[10])) or
        (SegundoDigito <> StrToInt(Dado[11])) then
        Result := False;
    end;
  end
  else
    if Length(Dado) <> 0 then
      Result := False;
end;

function RetiraEspacos(Arquivo: String): String;
var
  I: Integer;
  Resultado: String;
begin
  Resultado := '';
  for I:=1 to Length(Arquivo) do
    if Arquivo[I] <> ' ' then
      Resultado := Resultado + Arquivo[I];
  RetiraEspacos := Resultado;
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

function WinExecAndWait32(FileName   : String;
                          WorkDir    : String;
                          Visibility : integer): Cardinal;
var
  zAppName    : array[0..512] of char;
  zCurDir     : array[0..255] of char;
  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;
  lpMsgBuf    : String;
  Msg         : TMsg;

begin
  StrPCopy(zAppName,FileName);
  {GetDir(0,WorkDir);}
  StrPCopy(zCurDir,WorkDir);
  FillChar(StartupInfo,Sizeof(StartupInfo),#0);
  StartupInfo.cb := Sizeof(StartupInfo);

  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess( nil,
    zAppName,                      { pointer to command line string }
    nil,                           { pointer to process security attributes }
    nil,                           { pointer to thread security attributes }
    false,                         { handle inheritance flag }
    CREATE_NEW_CONSOLE or          { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil,                           { pointer to new environment block }
    zCurDir,                       { pointer to current directory name }
    StartupInfo,                   { pointer to STARTUPINFO }
    ProcessInfo) then Result := 1  { pointer to PROCESS_INF }

  else begin
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess,Result);
  end;
end;

function GetDosOutput(const CommandLine:string;
                      WorkDir: String;
                      Visibility: Integer;
                      Var Linha: String;
                      Compilacao: Boolean): Cardinal;

var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of Char;
  BytesRead: Cardinal;
  Line: String;
  CodErro: Cardinal;
begin
  Application.ProcessMessages;
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  // create pipe for standard output redirection
  CreatePipe(StdOutPipeRead, // read handle
             StdOutPipeWrite, // write handle
             @SA, // security attributes
             0 // n umber of bytes reserved for pipe - 0 default
            );
  try
    // Make child process use StdOutPipeWrite as standard out,
    // and make sure it does not show on screen.
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := Visibility; //SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect std input
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    // launch the command line compiler
    WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil,
    PChar(WorkDir), SI, PI);

    // Now that the handle has been inherited, close write to be safe.
    // We don't want to read or write to it accidentally.
    CloseHandle(StdOutPipeWrite);
    // if process could be created then handle its output
    if not WasOK then
      raise Exception.Create('Could not execute command line!')
    else
      try
        // get all output until dos app finishes
        Line := '';
        repeat
          // read block of characters (might contain carriage returns and line feeds)
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);

          // has anything been read?
          if BytesRead > 0 then
          begin
            // finish buffer to PChar
            Buffer[BytesRead] := #0;
            // combine the buffer with the rest of the last run
            Line := Line + Buffer;
            if Compilacao then
              FormCompile.HandleBuffer(Buffer);
          end;
        until not WasOK or (BytesRead = 0);
        // wait for console app to finish (should be already at this point)
        WaitForSingleObject(PI.hProcess, INFINITE);
        GetExitCodeProcess(PI.hProcess, Result);
      finally
        // Close all remaining handles
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    Linha := Line;
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure Busca_PastaFontes(Index: Integer);
var
  Lista: TStringList;
begin
  Lista := TStringList.Create;
  if FileExists(Projeto.PastaGerador + 'Modelos.Lst') then
    Lista.LoadFromFile(Projeto.PastaGerador + 'Modelos.Lst');
  if (Index <= Lista.Count-1) and (Index > -1) then
    Projeto.PastaFontes := Trim(Copy(Lista[Index], Pos('~~', Lista[Index])+2, Length(Lista[Index])))
  else
    Projeto.PastaFontes := Projeto.PastaGerador + 'Delphi\';
  if Trim(Projeto.PastaFontes) = '' then
    Projeto.PastaFontes := Projeto.PastaGerador + 'Delphi\';
  Projeto.PastaFontes := DiretorioComBarra(Projeto.PastaFontes);
  Lista.Free;
end;

function IIF(aExpressao: Boolean; aVerdadeiro, aFalso: Variant): Variant;
begin
  if aExpressao then
    Result := aVerdadeiro
  else
    Result := aFalso;
end;

function R_DataType(S: String): TFieldType;
var
  I: Integer;
begin
  R_DataType := ftUnknown;
  for I:=1 to Length(Tipos_Suportados) do
    if LowerCase(Tipos_Suportados[I]) = LowerCase(S) then
    begin
      R_DataType := Datas[I-6];
      Break;
    end;
end;

function P_DataType(ft: TFieldType): integer;
var
  I: Integer;
begin
  P_DataType := -1;
  for I:=1 to Length(Tipos_Suportados) do
    if R_DataType(Tipos_Suportados[I]) = ft then
    begin
      P_DataType := I;
      exit;
    end;
end;

function DB_DataType(S: String): String;
var
  I: Integer;
begin
  DB_DataType := 'ftUnknown';
  S := LowerCase(S);
  if S = 'blob' then
    DB_DataType := 'ftBlob'
  else if S = 'char' then
    DB_DataType := 'ftString'
  else if S = 'date' then
    DB_DataType := 'ftDate'
  else if S = 'decimal' then
    DB_DataType := 'ftFloat'
  else if S = 'double Precision' then
    DB_DataType := 'ftFloat'
  else if S = 'float' then
    DB_DataType := 'ftFloat'
  else if S = 'integer' then
    DB_DataType := 'ftInteger'
  else if S = 'numeric' then
    DB_DataType := 'ftFloat'
  else if S = 'smallint' then
    DB_DataType := 'ftInteger'
  else if S = 'time' then
    DB_DataType := 'ftTime'
  else if S = 'timestamp' then
    DB_DataType := 'ftTime'
  else if S = 'varchar' then
    DB_DataType := 'ftString'
  else if S = 'datetime' then
    DB_DataType := 'ftDateTime'
  else if S = 'text' then
    DB_DataType := 'ftString'
  else if S = 'image' then
    DB_DataType := 'ftBlob'
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
    end;
  end;
  Campo.DisplayLabel := Titulo;
  Campo.Index   := Indice;
  Campo.Visible := Visivel;
  if Largura > 0 then
    Campo.DisplayWidth := Largura;
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

function AtribuiAspas(S: String): String;
begin
  AtribuiAspas := Format('''%s''', [RepeatChar('''', S)]);
end;

procedure ChamaAjuda(Titulo: String = 'Ajuda do X-Maker'; URL: String = 'Doc\Ajuda.html');
begin
  FormAjuda := TFormAjuda.Create(Application);
  Try
    FormAjuda.Caption := Titulo;
    FormAjuda.URL := Projeto.PastaGerador + URL;
    FormAjuda.ShowModal;
  Finally
    FormAjuda.Free;
  end;
end;

end.
