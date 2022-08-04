(*  GREATIS FORM EXTRACTOR for                *)
(*  GREATIS FORM DESIGNER                     *)
(*  Copyright (C) 2002-2004 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

unit Procs;

interface

uses Windows, Classes, SysUtils, Forms, Objs, Controls;

const
  NL = #13#10;
  NL2 = NL+NL;
  Header =
    'unit %sUnit;'+NL2+
    'interface'+NL2+
    'uses'+NL+
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;'+NL2+
    'type'+NL+
    '  %s = class(TForm)';
  Footer =
    '  private'+NL+
    '    { Private declarations }'+NL+
    '  public'+NL+
    '    { Public declarations }'+NL+
    '  end;'+NL2+
    'var'+NL+
    '  %s: %s;'+NL2+
    'implementation'+NL2+
    '{$R *.DFM}'+NL2+
    'end.';

type
  TLineType = (ltData,ltObject,ltItem,ltEnd,ltLeft,ltTop,ltWidth,ltHeight,ltClientWidth,ltClientHeight);

function LineType(S: string): TLineType;
function LineObject(S: string): string;
function ObjectName(S: string): string;
function ObjectType(S: string): string;
function ObjectVar(S: string): string;
procedure CreatePreview(DFM: TStrings; Panel: TWinControl);
procedure ShowError;

implementation

function ObjectName(S: string): string;
begin
  Result:=Copy(S,1,Pred(Pos(':',S)));
end;

function ObjectType(S: string): string;
begin
  if Pos(':',S)<>0 then Result:=Copy(S,Pos(':',S)+2,Length(S))
  else Result:=Copy(S,Succ(Pos(' ',S)),Length(S));
end;

function ObjectVar(S: string): string;
begin
  Result:=ObjectType(S);
  if (Length(Result)<>0) and (UpperCase(Result[1])='T') then Delete(Result,1,1)
  else Result:=Result+'Var';
end;

function LineType(S: string): TLineType;
begin
  S:=TrimLeft(S);
  if (Pos('object ',S)=1) or (Pos('inherited ',S)=1) then Result:=ltObject
  else
    if S='item' then Result:=ltItem
    else
      if (S='end') or (S='end>') then Result:=ltEnd
      else
        if Pos('Left = ',S)=1 then Result:=ltLeft
        else
          if Pos('Top = ',S)=1 then Result:=ltTop
          else
            if Pos('Width = ',S)=1 then Result:=ltWidth
            else
              if Pos('Height = ',S)=1 then Result:=ltHeight
              else
                if Pos('ClientWidth = ',S)=1 then Result:=ltClientWidth
                else
                  if Pos('ClientHeight = ',S)=1 then Result:=ltClientHeight
                  else Result:=ltData;
end;

function DataPos(S: string): Integer;
begin
  Result:=Length(S);
  while Result>1 do
    if S[Result]=' ' then
    begin
      Inc(Result);
      Exit;
    end
    else Dec(Result);
end;

function LineInt(S: string): Integer;
begin
  try
    Result:=StrToInt(Copy(S,DataPos(S),Length(S)));
  except
    Result:=0;
  end;
end;

function LineObject(S: string): string;
begin
  S:=Trim(S);
  if Pos('object ',S)=1 then Result:=Copy(S,Succ(Length('object ')),Length(S))
  else
    if Pos('inherited ',S)=1 then Result:=Copy(S,Succ(Length('inherited ')),Length(S))
    else Result:='';
end;

procedure CreatePreview(DFM: TStrings; Panel: TWinControl);
var
  i,ItemCount: Integer;
  AC: TAbstractComponent;
begin
  if DFM.Count>0 then
    with TParentStack.Create do
    try
      ItemCount:=0;
      Panel.DestroyComponents;
      Add(Panel);
      for i:=0 to Pred(DFM.Count) do
      begin
        with Last do
          case LineType(DFM[i]) of
            ltObject:
              if i=0 then Panel.Hint:=LineObject(DFM[i])
              else
              begin
                AC:=TAbstractComponent.Create(Last);
                AC.Hint:=LineObject(DFM[i]);
                if ObjectType(DFM[i])='TTabSheet' then AC.Align:=alClient;
                Push(AC);
              end;
            ltItem: Inc(ItemCount);
            ltEnd:
              if ItemCount>0 then Dec(ItemCount)
              else
              begin
                AC:=TAbstractComponent(Pop);
                if (Assigned(AC)) and (ObjectType(Hint)<>'TMenuItem') then
                  with AC do
                  begin
                    Caption:=ObjectName(Hint);
                    Hint:=Format(
                      '%s    Left: %d  Top: %d   Width: %d  Height: %d',
                      [Hint,Left,Top,Width,Height]);
                    if AC=Panel then
                    begin
                      Left:=0;
                      Top:=0;
                    end;
                    Parent:=Last;
                  end;
              end;
            ltLeft: Left:=LineInt(DFM[i]);
            ltTop: Top:=LineInt(DFM[i]);
            ltClientWidth: Panel.Width:=LineInt(DFM[i]);
            ltClientHeight: Panel.Height:=LineInt(DFM[i]);
            ltWidth: Width:=LineInt(DFM[i]);
            ltHeight: Height:=LineInt(DFM[i]);
          end;
      end;
    finally
      Free;
    end;
end;

procedure ShowError;
var
  C: array[Byte] of Char;
begin
  FormatMessage(
    FORMAT_MESSAGE_FROM_SYSTEM,
    nil,
    GetLastError,
    LOCALE_USER_DEFAULT,
    C,
    SizeOf(C),
    nil);
  with Application do
    MessageBox(C,PChar(Title),MB_ICONERROR or MB_OK);
end;

end.
