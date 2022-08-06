{
   Programa.: Validar.PAS
   Copyright: Modular Software 2004
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Validar;

interface

{Validar data no formato ddmmaa ou ddmmaaaa}
function DATAVALIDA(Dado: string): Boolean;
{Validar Unidade da Federação}
function VUF(Dado: string): Boolean;
{Validar CNPJ}
function VCNPJ(Dado: string): Boolean;
{Validar CPF}
function VCPF(Dado: string): Boolean;
{Validar PIS}
function VPIS(Dado: String): Boolean;
{Validar hora no formato hh(24)}
function VHORA(Dado: string): Boolean;
{Validar hora/minuto no formato hhmm(24)}
function VHORAMIN(Dado: string): Boolean;
{Validar hora/minuto/segundo no formato hhmmss(24)}
function VHORAMINSEG(Dado: string): Boolean;
{Validar se o ano da data é o mesmo do ano atual}
function ANOATUAL(Dado: string): Boolean;
{Validar se o mês da data é o mesmo do mês atual}
function MESATUAL(Dado: string): Boolean;
{Validar se o mês/ano da data é o mesmo do mês/ano atual}
function MESANOATUAL(Dado: string): Boolean;
{Validar se o mês/ano da data no formato são válidos}
function MESANOVALIDO(Dado: string): Boolean;
{Retorna uma String sem caracteres de Acento}
function RETIRAACENTO(S: string): String;
{Retorna uma String com os primeiros caracteres em maiúsculo}
function PRIMEIRASLETRASMASC(S: string): String;

implementation

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  SysUtils, ExtCtrls, DBTables, DB, DBCtrls, Grids, Dialogs, Menus;

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

function VUF(Dado: string): Boolean;
const
  Estados = 'SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO';
var
  Posicao: Integer;
begin
  Result := True;
  if Dado <> '' then
  begin
    Posicao := Pos(UpperCase(Dado), Estados);
    if (Posicao = 0) or ((Posicao mod 2) = 0) or (Length(Dado) <> 2) then
      Result := False
  end;
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

function VHORA(Dado: string): Boolean;
var
  Hora: Integer;
begin
  Result := True;
  Hora := 99;
  try
    Hora := StrToInt(Dado);
  except
    on EConvertError do
      Result := False;
  end;
  if Result and ((Hora < 0) or (Hora > 23)) then
    Result := False;
end;

function VHORAMIN(Dado: string): Boolean;
var
  Hora,
  Minuto: Integer;
begin
  Result := True;
  Hora := 99;
  Minuto := 99;
  try
    Hora := StrToInt(Copy(Dado, 1, 2));
    Minuto := StrToInt(Copy(Dado, 3, 2));
  except
    on EConvertError do
      Result := False;
  end;
  if Result and
    ((Hora < 0) or
    (Hora > 23) or
    (Minuto < 0) or
    (Minuto > 59)) then
    Result := False;
end;

function VHORAMINSEG(Dado: string): Boolean;
var
  Hora,
  Minuto,
  Segundo: Integer;
begin
  Result := True;
  Hora := 99;
  Minuto := 99;
  Segundo := 99;
  try
    Hora := StrToInt(Copy(Dado, 1, 2));
    Minuto := StrToInt(Copy(Dado, 3, 2));
    Segundo := StrToInt(Copy(Dado, 5, 2));
  except
    on EConvertError do
      Result := False;
  end;
  if Result and
    ((Hora < 0) or
    (Hora > 23) or
    (Minuto < 0) or
    (Minuto > 59) or
    (Segundo < 0) or
    (Segundo > 59)) then
    Result := False;
end;

function ANOATUAL(Dado: string): Boolean;
var
  SalvaFormato,
  DataExterna,
  Hoje: string;
  DataInterna: TDateTime;
begin
  Result := True;
  if Length(Dado) = 6 then
  begin
    Dado := Copy(Dado, 1, 2) + '/' +
      Copy(Dado, 3, 2) + '/19' +
      Copy(Dado, 5, 2)
  end
  else
    if Length(Dado) = 8 then
    begin
      Dado := Copy(Dado, 1, 2) + '/' +
        Copy(Dado, 3, 2) + '/' +
        Copy(Dado, 5, 4);
    end
    else
      Result := False;
  if Result then
  begin
    SalvaFormato := ShortDateFormat;
    DataInterna := 0;
    try
      ShortDateFormat := 'd/m/y';
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
        ShortDateFormat := 'dd/mm/yyyy';
        DataExterna := DateToStr(DataInterna);
      except
        on EConvertError do
        begin
          Result := False;
          ShortDateFormat := SalvaFormato;
        end;
      end;
      if Result then
      begin
        ShortDateFormat := 'dd/mm/yyyy';
        Hoje := DateToStr(Date);
        if (DataExterna <> Dado) or
          (Copy(Hoje, 5, 4) <> Copy(Dado, 5, 4)) then
          Result := False;
      end;
    end;
    ShortDateFormat := SalvaFormato;
  end;
end;

function MESATUAL(Dado: string): Boolean;
var
  SalvaFormato,
  DataExterna,
  Hoje: string;
  DataInterna: TDateTime;
begin
  Result := True;
  if Length(Dado) = 6 then
  begin
    Dado := Copy(Dado, 1, 2) + '/' +
      Copy(Dado, 3, 2) + '/19' +
      Copy(Dado, 5, 2)
  end
  else
    if Length(Dado) = 8 then
    begin
      Dado := Copy(Dado, 1, 2) + '/' +
        Copy(Dado, 3, 2) + '/' +
        Copy(Dado, 5, 4);
    end
    else
      Result := False;
  if Result then
  begin
    SalvaFormato := ShortDateFormat;
    DataInterna := 0;
    try
      ShortDateFormat := 'd/m/y';
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
        ShortDateFormat := 'dd/mm/yyyy';
        DataExterna := DateToStr(DataInterna);
      except
        on EConvertError do
        begin
          Result := False;
          ShortDateFormat := SalvaFormato;
        end;
      end;
      if Result then
      begin
        ShortDateFormat := 'dd/mm/yyyy';
        Hoje := DateToStr(Date);
        if (DataExterna <> Dado) or
          (Copy(Hoje, 3, 2) <> Copy(Dado, 3, 2)) then
          Result := False;
      end;
    end;
    ShortDateFormat := SalvaFormato;
  end;
end;

function MESANOATUAL(Dado: string): Boolean;
var
  SalvaFormato,
  DataExterna,
  Hoje: string;
  DataInterna: TDateTime;
begin
  Result := True;
  if Length(Dado) = 6 then
  begin
    Dado := Copy(Dado, 1, 2) + '/' +
      Copy(Dado, 3, 2) + '/19' +
      Copy(Dado, 5, 2)
  end
  else
    if Length(Dado) = 8 then
    begin
      Dado := Copy(Dado, 1, 2) + '/' +
        Copy(Dado, 3, 2) + '/' +
        Copy(Dado, 5, 4);
    end
    else
      Result := False;
  if Result then
  begin
    SalvaFormato := ShortDateFormat;
    DataInterna := 0;
    try
      ShortDateFormat := 'd/m/y';
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
        ShortDateFormat := 'dd/mm/yyyy';
        DataExterna := DateToStr(DataInterna);
      except
        on EConvertError do
        begin
          Result := False;
          ShortDateFormat := SalvaFormato;
        end;
      end;
      if Result then
      begin
        ShortDateFormat := 'dd/mm/yyyy';
        Hoje := DateToStr(Date);
        if (DataExterna <> Dado) or
          (Copy(Hoje, 3, 7) <> Copy(Dado, 3, 7)) then
          Result := False;
      end;
    end;
    ShortDateFormat := SalvaFormato;
  end;
end;

function MESANOVALIDO(Dado: string): Boolean;
begin
  Result := DATAVALIDA('01' + Dado);
end;

function VPIS(Dado: String): Boolean;
var
  I, wdv, wsoma, wm11, wdigito: Integer;
begin
  if (Dado <> '') then
  begin
     wdv := StrToIntDef(Copy(Dado, 11, 1),0);
     wsoma := 0;
     wm11 := 2;
     for I:= 1 to 10 do
     begin
        wsoma:= wsoma + wm11 * StrToIntDef(Copy(Dado, 11 - I, 1),0);
        if wm11 < 9 then
          wm11 := wm11 + 1
        else
          wm11 := 2;
     end;
     wdigito:= 11 - (wsoma mod 11);
     if wdigito > 9 then
       wdigito := 0;
     if wdv = wdigito then
       VPIS := True
     else
       VPIS := False;
  end
  else
    VPIS := True;
end;

function RETIRAACENTO(S: string): String;
const
  ComAcento = 'àáãäâÀÁÃÄÂèéëêÈÉËÊìíïîÌÍÏÎòóõöôÒÓÕÖÔùúüûÙÚÜÛçÇ';
  SemAcento = 'aaaaaAAAAAeeeeEEEEiiiiIIIIoooooOOOOOuuuuUUUUcC';
var
  I, P: Integer;
begin
  for I:=1 to Length(S) do
  begin
    P := Pos(S[I], ComAcento);
    if P > 0 then
      S[I] := SemAcento[P];
  end;
  RetiraAcento := S;
end;

function PRIMEIRASLETRASMASC(S: string): String;
var
  I: Integer;
begin
  for I:=1 to Length(S) do
  begin
    if (I = 1) or (S[I-1] = ' ') then
      S[I] := UpperCase(S[I])[1]
    else
      S[I] := LowerCase(S[I])[1]
  end;
  PRIMEIRASLETRASMASC := S;
end;

end.
