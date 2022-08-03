{
   Programa.: XECF_util.Pas
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit XECF_util;

interface

uses Classes, Sysutils;

function LFill(aString: string; aCaracter: Char; aTamanho: integer): string;
function RFill(aString: string; aCaracter: Char; aTamanho: integer): string;
function IIF(aExpressao: Boolean; aVerdadeiro, aFalso: Variant): Variant;
function StrZero(N: integer; Tamanho: integer): string;
function ConstStr(Ch: string; N: byte): string;

implementation

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

end.
