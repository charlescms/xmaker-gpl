{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{            Compatibility Classes and Functions          }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{            Written by Sergey Seroukhov                  }
{                                                         }
{*********************************************************}

{*********************************************************}
{ License Agreement:                                      }
{                                                         }
{ This library is free software; you can redistribute     }
{ it and/or modify it under the terms of the GNU Lesser   }
{ General Public License as published by the Free         }
{ Software Foundation; either version 2.1 of the License, }
{ or (at your option) any later version.                  }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ You should have received a copy of the GNU Lesser       }
{ General Public License along with this library; if not, }
{ write to the Free Software Foundation, Inc.,            }
{ 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA }
{                                                         }
{ The project web site is located on:                     }
{   http://www.sourceforge.net/projects/zeoslib.          }
{   http://www.zeoslib.sourceforge.net                    }
{                                                         }
{                                 Zeos Development Group. }
{*********************************************************}

unit ZCompatibility;

interface

{$I ZCore.inc}

uses
{$IFNDEF VER125BELOW}
  Contnrs,
{$ENDIF}
{$IFNDEF VER130BELOW}
  Variants,
{$ENDIF}
  Classes, SysUtils;

type

  TIntegerDynArray      = array of Integer;
  TCardinalDynArray     = array of Cardinal;
  TWordDynArray         = array of Word;
  TSmallIntDynArray     = array of SmallInt;
  TByteDynArray         = array of Byte;
  TShortIntDynArray     = array of ShortInt;
  TInt64DynArray        = array of Int64;
  TLongWordDynArray     = array of LongWord;
  TSingleDynArray       = array of Single;
  TDoubleDynArray       = array of Double;
  TBooleanDynArray      = array of Boolean;
  TStringDynArray       = array of string;
  TWideStringDynArray   = array of WideString;
  TVariantDynArray      = array of Variant;
  TObjectDynArray       = array of TObject;

  IntegerArray  = array[0..$effffff] of Integer;
  PIntegerArray = ^IntegerArray;

  PPointer              = ^Pointer;
  PByte                 = ^Byte;
  PBoolean              = ^Boolean;
  PShortInt             = ^ShortInt;
  PSmallInt             = ^SmallInt;
  PInteger              = ^Integer;
  PLongInt              = ^LongInt;
  PSingle               = ^Single;
  PDouble               = ^Double;
  PWord                 = ^Word;
  PWordBool             = ^WordBool;
  PCardinal             = ^Cardinal;
  PInt64                = ^Int64;

{$IFDEF VER125BELOW}

type

  TListNotification = (lnAdded, lnExtracted, lnDeleted);
  TListAssignOp = (laCopy, laAnd, laOr, laXor, laSrcUnique, laDestUnique);

  TListEx = class(TList)
  protected
    procedure Put(Index: Integer; Item: Pointer);
    procedure Notify(Ptr: Pointer; Action: TListNotification);
  {$IFNDEF VER125BELOW}override;{$ELSE}virtual;{$ENDIF}
  public
    function Add(Item: Pointer): Integer;
    procedure Delete(Index: Integer);
    procedure Insert(Index: Integer; Item: Pointer);
  end;

  TObjectList = class(TListEx)
  private
    FOwnsObjects: Boolean;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification);override;
    function GetItem(Index: Integer): TObject;
    procedure SetItem(Index: Integer; AObject: TObject);
  public
    constructor Create;
    constructor CreateWithMode(AOwnsObjects: Boolean);

    function Add(AObject: TObject): Integer;
    function Remove(AObject: TObject): Integer;
    function IndexOf(AObject: TObject): Integer;
    function FindInstanceOf(AClass: TClass; AExact: Boolean = True;
      AStartAt: Integer = 0): Integer;
    procedure Insert(Index: Integer; AObject: TObject);
    function First: TObject;
    function Last: TObject;

    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
    property Items[Index: Integer]: TObject read GetItem write SetItem; default;
  end;
{$ELSE}
type
  TObjectList = Contnrs.TObjectList;
{$ENDIF}

{$IFDEF VER130KBELOW}
type
  TLoginEvent = procedure(Sender: TObject; Username, Password: string) of object;
{$ENDIF}

{$IFDEF VER130KBELOW}
type
  TDBScreenCursor = (dcrDefault, dcrHourGlass, dcrSQLWait, dcrOther);

  IDBScreen = interface
    ['{29A1C508-6ADC-44CD-88DE-4F51B25D5995}']
    function GetCursor: TDBScreenCursor;
    procedure SetCursor(Cursor: TDBScreenCursor);

    property Cursor: TDBScreenCursor read GetCursor write SetCursor;
  end;

var
  LoginDialogProc: function (const ADatabaseName: string; var AUserName,
    APassword: string): Boolean;
  DBScreen: IDBScreen;

function StrToFloatDef(Str: string; Def: Extended): Extended;
{$ENDIF}

{$IFDEF VER130BELOW}
function AnsiDequotedStr(const S: string; AQuote: Char): string;
function BoolToStr(Value: Boolean): string;
function VarIsStr(const V: Variant): Boolean;
{$ENDIF}

implementation

{$IFDEF VER125BELOW}

{ TListEx }

function TListEx.Add(Item: Pointer): Integer;
begin
  Result := inherited Add(Item);
  if Item <> nil then
    Notify(Item, lnAdded);
end;

procedure TListEx.Delete(Index: Integer);
var
  Temp: Pointer;
begin
  Temp := Items[Index];
  inherited Delete(Index);
  if Temp <> nil then
    Notify(Temp, lnDeleted);
end;

procedure TListEx.Insert(Index: Integer; Item: Pointer);
begin
  inherited Insert(Index, Item);
  if Item <> nil then
    Notify(Item, lnAdded);
end;

procedure TListEx.Put(Index: Integer; Item: Pointer);
var
  Temp: Pointer;
begin
  Temp := Items[Index];
  if Item <> Temp then
  begin
    inherited Put(Index, Item);
    if Temp <> nil then
      Notify(Temp, lnDeleted);
    if Item <> nil then
      Notify(Item, lnAdded);
  end;
end;

procedure TListEx.Notify(Ptr: Pointer; Action: TListNotification);
begin
end;

{ TObjectList }

constructor TObjectList.Create;
begin
  inherited Create;
  FOwnsObjects := True;
end;

constructor TObjectList.CreateWithMode(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

function TObjectList.Add(AObject: TObject): Integer;
begin
  Result := inherited Add(AObject);
end;

function TObjectList.FindInstanceOf(AClass: TClass; AExact: Boolean;
  AStartAt: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := AStartAt to Count - 1 do
  begin
    if (AExact and (Items[I].ClassType = AClass)) or
      (not AExact and Items[I].InheritsFrom(AClass)) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TObjectList.First: TObject;
begin
  Result := TObject(inherited First);
end;

function TObjectList.GetItem(Index: Integer): TObject;
begin
  Result := inherited Items[Index];
end;

function TObjectList.IndexOf(AObject: TObject): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TObjectList.Insert(Index: Integer; AObject: TObject);
begin
  inherited Insert(Index, AObject);
end;

function TObjectList.Last: TObject;
begin
  Result := TObject(inherited Last);
end;

procedure TObjectList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if OwnsObjects then
    if Action = lnDeleted then
      TObject(Ptr).Free;
  inherited Notify(Ptr, Action);
end;

function TObjectList.Remove(AObject: TObject): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TObjectList.SetItem(Index: Integer; AObject: TObject);
begin
  inherited Items[Index] := AObject;
end;

{$ENDIF}

{$IFDEF VER130KBELOW}

function StrToFloatDef(Str: string; Def: Extended): Extended;
begin
  try
    if Str <> '' then
      Result := StrToFloat(Str)
    else Result := Def;
  except
    Result := Def;
  end;
end;

{$ENDIF}

{$IFDEF VER130BELOW}

function AnsiDequotedStr(const S: string; AQuote: Char): string;
var
  LText: PChar;
begin
  LText := PChar(S);
  Result := AnsiExtractQuotedStr(LText, AQuote);
  if Result = '' then
    Result := S;
end;

function BoolToStr(Value: Boolean): string;
begin
  if Value = True then
    Result := 'True'
  else Result := 'False';
end;

function VarIsStr(const V: Variant): Boolean;
begin
  Result := ((TVarData(V).VType and varTypeMask) = varOleStr) or
    ((TVarData(V).VType and varTypeMask) = varString);
end;
{$ENDIF}


end.

