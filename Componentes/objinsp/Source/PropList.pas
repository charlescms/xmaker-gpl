(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.041                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit PropList;

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE VARIANTS}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE VARIANTS}
{$ENDIF}
{$IFDEF VER170}
  {$DEFINE VARIANTS}
{$ENDIF}
{$IFDEF VER180}
  {$DEFINE VARIANTS}
{$ENDIF}

interface

uses Windows, Classes, SysUtils,
  {$IFDEF VARIANTS}
  Variants,
  {$ENDIF}
  TypInfo, Graphics, Controls, Forms, Menus;

resourcestring
  strPropListInvalidValue = 'Invalid property value. %s';

const

  tkOrdinals = [tkInteger,tkChar,tkEnumeration,tkSet,tkClass,tkWChar];
  tkChars = [tkChar,tkWChar];
  tkStrings = [tkString,tkLString,tkWString];

type

  EPropertyException = class(Exception);

  TPropertyList = class;
  TProperty = class;

  TGetPropertyValue = function(AInstance: TPersistent; Prop: TProperty): string;
  TSetPropertyValue = procedure(AInstance: TPersistent; Prop: TProperty; Value: string);

  TCustomPropData = class
  public
    InstanceType: TClass;
    PropName: string;
    PropType: PTypeInfo;
    Descendants: Boolean;
    GetProc: TGetPropertyValue;
    SetProc: TSetPropertyValue;
  constructor Create(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
  end;

  TProperty = class
  private
    FOwner: TPropertyList;
    FRoot: TComponent;
    FInstance: TPersistent;
    FPropInfo: PPropInfo;
    FTypeData: PTypeData;
    FProperties: TPropertyList;
    FPropData: TCustomPropData;
    // internal property access methods
    function GetEmulated: Boolean;
    function GetCustom: Boolean;
    function GetOwnerProperty: TProperty;
    function GetLevel: Integer;
    // propinfo properties access methods
    function GetPropType: PTypeInfo;
    function GetGetProc: Pointer;
    function GetSetProc: Pointer;
    function GetIsStored: Boolean;
    function GetIndex: SmallInt;
    function GetDefault: LongInt;
    function GetNameIndex: SmallInt;
    function GetName: ShortString;
    function GetFullName: string;
    function GetTypeName: string;
    function GetTypeKind: TTypeKind;
    // properties for ordinal and set types
    function GetOrdType: TOrdType;
    function GetMinValue: Longint;
    function GetMaxValue: Longint;
    // property for set types
    function GetCompType: PTypeInfo;
    // properties for enumeration types
    function GetBaseType: PTypeInfo;
    function GetEnumCount: Integer;
    function GetEName(Value: Integer): string;
    function GetEValue(Value: string): Integer;
    // property for float types
    function GetFloatType: TFloatType;
    // property for short string types
    function GetMaxLength: Byte;
    // properties for class types
    function GetClassType: TClass;
    function GetParentInfo: PTypeInfo;
    function GetUnitName: ShortString;
    // properties for method types
    function GetMethodKind: TMethodKind;
    function GetParamCount: Integer;
    function GetParamFlags(Index: Integer): TParamFlags;
    function GetParamName(Index: Integer): ShortString;
    function GetParamType(Index: Integer): ShortString;
    function GetParameter(Index: Integer): ShortString;
    function GetResultType: ShortString;
    function GetMethodDeclaration: string;
    // properties for interface type
    function GetIntfParent: PTypeInfo;
    function GetIntfFlags: TIntfFlags;
    function GetGUID: TGUID;
    function GetIntfUnit: ShortString;
    {$IFNDEF VERSION3}
    // properties for Int64 type
    function GetMinInt64Value: Int64;
    function GetMaxInt64Value: Int64;
    {$ENDIF}
    // value access methods
    function GetAsFloat: Extended;
    procedure SetAsFloat(const Value: Extended);
    function GetAsMethod: TMethod;
    procedure SetAsMethod(const Value: TMethod);
    function GetAsInteger: Longint;
    procedure SetAsInteger(const Value: Longint);
    function GetAsChar: Char;
    procedure SetAsChar(const Value: Char);
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const Value: Boolean);
    function GetAsObject: TObject;
    procedure SetAsObject(const Value: TObject);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const Value: TDateTime);
    function GetAsDate: TDate;
    procedure SetAsDate(const Value: TDate);
    function GetAsTime: TTime;
    procedure SetAsTime(const Value: TTime);
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function GetAsVariant: Variant;
    procedure SetAsVariant(const Value: Variant);
    {$IFNDEF VERSION3}
    function GetAsInterface: IUnknown;
    procedure SetAsInterface(const Value: IUnknown);
    {$ENDIF}
  public
    constructor Create(AOwner: TPropertyList; ARoot,AInstance: TComponent; APropInfo: PPropInfo; APropData: TCustomPropData); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TProperty);
    function CreatePropertyList: TPropertyList; virtual;
    function DisplayValue: string; virtual;
    function GetStringValue: string; virtual;
    procedure SetStringValue(const Value: string); virtual;
    procedure ValuesList(const Values: TStrings); virtual;
    function IsCompatibleObject(AObject: TObject): Boolean;
    function IsCompatibleType(ATypeInfo: PTypeInfo): Boolean;
    function IsType(ATypeInfo: PTypeInfo): Boolean;
    function IsCompatible(P: TProperty): Boolean;
    // internal properties
    property Emulated: Boolean read GetEmulated;
    property Custom: Boolean read GetCustom;
    property Owner: TPropertyList read FOwner;
    property OwnerProperty: TProperty read GetOwnerProperty;
    property Level: Integer read GetLevel;
    // main properties
    property Root: TComponent read FRoot write FRoot;
    property Instance: TPersistent read FInstance write FInstance;
    // propinfo properties
    property TypeData: PTypeData read FTypeData;
    property PropType: PTypeInfo read GetPropType;
    property GetProc: Pointer read GetGetProc;
    property SetProc: Pointer read GetSetProc;
    property IsStored: Boolean read GetIsStored;
    property Index: SmallInt read GetIndex;
    property Default: Integer read GetDefault;
    property NameIndex: SmallInt read GetNameIndex;
    property Name: ShortString read GetName;
    property FullName: string read GetFullName;
    property TypeName: string read GetTypeName;
    property TypeKind: TTypeKind read GetTypeKind;
    // properties for ordinal types
    property OrdType: TOrdType read GetOrdType;
    property MinValue: Longint read GetMinValue;
    property MaxValue: Longint read GetMaxValue;
    // properties for enumeration types
    property BaseType: PTypeInfo read GetBaseType;
    property EnumCount: Integer read GetEnumCount;
    property Names[Index: Integer]: string read GetEName;
    property Values[Index: string]: Integer read GetEValue;
    // properties for set types
    property CompType: PTypeInfo read GetCompType;
    // property for float types
    property FloatType: TFloatType read GetFloatType;
    // property for short string types
    property MaxLength: Byte read GetMaxLength;
    // properties for class types
    property PropClassType: TClass read GetClassType;
    property ParentInfo: PTypeInfo read GetParentInfo;
    property UnitName: ShortString read GetUnitName;
    property Properties: TPropertyList read FProperties;
    // properties for method types
    property MethodKind: TMethodKind read GetMethodKind;
    property ParamCount: Integer read GetParamCount;
    property ParamFlags[Index: Integer]: TParamFlags read GetParamFlags;
    property ParamNames[Index: Integer]: ShortString read GetParamName;
    property ParamTypes[Index: Integer]: ShortString read GetParamType;
    property Parameters[Index: Integer]: ShortString read GetParameter;
    property ResultType: ShortString read GetResultType;
    property MethodDeclaration: string read GetMethodDeclaration;
    // properties for interface type
    property IntfParent: PTypeInfo read GetIntfParent;
    property IntfFlags: TIntfFlags read GetIntfFlags;
    property GUID: TGUID read GetGUID;
    property IntfUnit: ShortString read GetIntfUnit;
    {$IFNDEF VERSION3}
    // properties for Int64 type
    property MinInt64Value: Int64 read GetMinInt64Value;
    property MaxInt64Value: Int64 read GetMaxInt64Value;
    {$ENDIF}
    // value access properties
    property AsFloat: Extended read GetAsFloat write SetAsFloat;
    property AsMethod: TMethod read GetAsMethod write SetAsMethod;
    property AsInteger: Longint read GetAsInteger write SetAsInteger;
    property AsChar: Char read GetAsChar write SetAsChar;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property AsTime: TTime read GetAsTime write SetAsTime;
    property AsString: string read GetAsString write SetAsString;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    {$IFNDEF VERSION3}
    property AsInterface: IUnknown read GetAsInterface write SetAsInterface;
    {$ENDIF}
  end;

  TCompareMethod = function (P1,P2: TProperty): Integer of object;

  TPropertyList = class
  private
    FOwner: TProperty;
    FProperties: TList;
    FRoot: TComponent;
    FInstance: TComponent;
    function GetOwnerList: TPropertyList;
    function GetLevel: Integer;
    function GetCount: Integer;
    function GetProperty(AIndex: Integer): TProperty;
    procedure SetRoot(const Value: TComponent);
    procedure SetInstance(const Value: TComponent);
    procedure Clear;
    procedure Sort;
  public
    constructor Create(AOwner: TProperty); virtual;
    destructor Destroy; override;
    function CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty; virtual;
    procedure AddEmulated(P: TProperty); virtual;
    procedure Update; virtual;
    function Compare(P1,P2: TProperty): Integer; virtual;
    function Filter(P: TProperty): Boolean; virtual;
    function IndexOf(const Item: TProperty): Integer;
    function IndexOfName(const Name: string): Integer;
    function FindProperty(const Name: string): TProperty;
    property OwnerList: TPropertyList read GetOwnerList;
    property Level: Integer read GetLevel;
    property Properties[Index: Integer]: TProperty read GetProperty; default;
    property Count: Integer read GetCount;
    property Owner: TProperty read FOwner;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read FInstance write SetInstance;
  end;

procedure RegisterCustomProperty(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
function RegisteredProperty(AInstanceType: TClass; APropName: string): Boolean;
procedure UnregisterCustomProperty(AInstanceType: TClass; APropName: string);
procedure UnregisterCustomProperties;

implementation

// variant internal functions

const
  VariantNames: array[0..12] of TIdentMapEntry = (
    (Value: varEmpty; Name: 'Unassigned'),
    (Value: varNull; Name: 'Null'),
    (Value: varSmallint; Name: 'Smallint'),
    (Value: varInteger; Name: 'Integer'),
    (Value: varSingle; Name: 'Single'),
    (Value: varDouble; Name: 'Double'),
    (Value: varCurrency;  Name: 'Currency'),
    (Value: varDate; Name: 'Date'),
    (Value: varOleStr; Name: 'OleStr'),
    (Value: varBoolean; Name: 'Boolean'),
    (Value: varUnknown; Name: 'Unknown'),
    (Value: varByte; Name: 'Byte'),
    (Value: varString; Name: 'String'));

function VariantName(AType: Integer): string;
begin
  IntToIdent(AType,Result,VariantNames);
end;

function VariantType(AName: string): Integer;
begin
  IdentToInt(AName,Result,VariantNames);
end;

const
  ModalResults: array[mrNone..mrYesToAll] of TIdentMapEntry = (
    (Value: 0; Name: 'mrNone'),
    (Value: mrOk; Name: 'mrOk'),
    (Value: mrCancel; Name: 'mrCancel'),
    (Value: mrAbort; Name: 'mrAbort'),
    (Value: mrRetry; Name: 'mrRetry'),
    (Value: mrIgnore; Name: 'mrIgnore'),
    (Value: mrYes; Name: 'mrYes'),
    (Value: mrNo; Name: 'mrNo'),
    (Value: mrAll; Name: 'mrAll'),
    (Value: mrNoToAll; Name: 'mrNoToAll'),
    (Value: mrYesToAll; Name: 'mrYesToAll'));

function ModalResultToIdent(ModalResult: Integer; var Ident: string): Boolean;
begin
  Result:=IntToIdent(ModalResult,Ident,ModalResults);
end;

function IdentToModalResult(const Ident: string; var ModalResult: Integer): Boolean;
begin
  Result:=IdentToInt(Ident,ModalResult,ModalResults);
end;

function ModalResultToString(ModalResult: TModalResult): string;
begin
  if not IntToIdent(ModalResult,Result,ModalResults) then Result:=IntToStr(ModalResult);
end;

function StringToModalResult(Ident: string): Integer;
begin
  if not IdentToInt(Ident,Result,ModalResults) then Result:=StrToInt(Ident);
end;

constructor TCustomPropData.Create(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
begin
  inherited Create;
  InstanceType:=AInstanceType;
  PropName:=APropName;
  PropType:=APropType;
  Descendants:=ADescendants;
  GetProc:=AGetProc;
  SetProc:=ASetProc;
end;

type
  TCustomPropertiesList = class(TList)
    function GetPropertyData(AInstanceType: TClass; APropName: string): TCustomPropData;
    function FindProperty(AInstanceType: TClass; APropName: string): TCustomPropData;
  end;

function TCustomPropertiesList.GetPropertyData(AInstanceType: TClass; APropName: string): TCustomPropData;
var
  i: Integer;
  AType: TClass;
begin
  Result:=nil;
  APropName:=AnsiUpperCase(APropName);
  AType:=AInstanceType;
  while Assigned(AType) do
  begin
    for i:=0 to Pred(Count) do
      with TCustomPropData(Items[i]) do
        if (AType=InstanceType) and
          (APropName=AnsiUpperCase(PropName)) and
          ((AType=AInstanceType) or Descendants) then
        begin
          Result:=Items[i];
          Exit;
        end;
    AType:=AType.ClassParent;
  end;
end;

function TCustomPropertiesList.FindProperty(AInstanceType: TClass; APropName: string): TCustomPropData;
var
  i: Integer;
begin
  Result:=nil;
  APropName:=AnsiUpperCase(APropName);
  for i:=0 to Pred(Count) do
    with TCustomPropData(Items[i]) do
      if (AInstanceType=InstanceType) and (APropName=AnsiUpperCase(PropName)) then
      begin
        Result:=Items[i];
        Break;
      end;
end;

var
  CustomProperties: TCustomPropertiesList;

procedure RegisterCustomProperty(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
begin
  with CustomProperties do
    if not Assigned(FindProperty(AInstanceType,APropName)) then
      Add(TCustomPropData.Create(AInstanceType,APropName,APropType,ADescendants,AGetProc,ASetProc));
end;

function RegisteredProperty(AInstanceType: TClass; APropName: string): Boolean;
begin
  Result:=Assigned(CustomProperties.GetPropertyData(AInstanceType,APropName));
end;

procedure UnregisterCustomProperty(AInstanceType: TClass; APropName: string);
var
  P: TCustomPropData;
begin
  with CustomProperties do
  begin
    P:=FindProperty(AInstanceType,APropName);
    if Assigned(P) then
    begin
      Delete(IndexOf(P));
      P.Free;
    end;
  end;
end;

procedure UnregisterCustomProperties;
var
  i: Integer;
begin
  with CustomProperties do
  begin
    for i:=0 to Pred(Count) do TObject(Items[i]).Free;
    Clear;
  end;
end;

function TProperty.GetEmulated: Boolean;
begin
  Result:=not Assigned(FPropInfo);
end;

function TProperty.GetCustom: Boolean;
begin
  Result:=Assigned(FPropData);
end;

function TProperty.GetOwnerProperty: TProperty;
begin
  if Assigned(Owner) then Result:=Owner.Owner
  else Result:=nil;
end;

function TProperty.GetLevel: Integer;
var
  P: TProperty;
begin
  Result:=0;
  P:=OwnerProperty;
  while Assigned(P) do
  begin
    Inc(Result);
    P:=P.OwnerProperty;
  end;
end;

function TProperty.GetPropType: PTypeInfo;
begin
  if Emulated then
    if Custom then Result:=FPropData.PropType
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkSet: Result:=TypeInfo(Boolean);
        else Result:=nil;
        end
      else Result:=nil
  else Result:=FPropInfo.PropType^;
end;

function TProperty.GetGetProc: Pointer;
begin
  if Emulated then Result:=nil
  else Result:=FPropInfo.GetProc;
end;

function TProperty.GetSetProc: Pointer;
begin
  if Emulated then Result:=nil
  else Result:=FPropInfo.SetProc;
end;

function TProperty.GetIsStored: Boolean;
begin
  if Emulated then Result:=False
  else Result:=Assigned(FPropInfo.StoredProc);
end;

function TProperty.GetIndex: SmallInt;
begin
  if Emulated then Result:=0
  else Result:=FPropInfo.Index;
end;

function TProperty.GetDefault: LongInt;
begin
  if Emulated then Result:=0
  else Result:=FPropInfo.Default;
end;

function TProperty.GetNameIndex: SmallInt;
begin
  if Emulated then Result:=0
  else Result:=FPropInfo.NameIndex;
end;

function TProperty.GetName: ShortString;
begin
  if Emulated then
    if Custom then Result:=FPropData.PropName
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkVariant: Result:='Type';
          tkSet: Result:=GetEnumName(OwnerProperty.CompType,Owner.IndexOf(Self))
        else Result:=''
        end
      else Result:=''
  else Result:=FPropInfo.Name;
end;

function TProperty.GetFullName: string;
var
  OP: TProperty;
begin
  Result:=Name;
  OP:=OwnerProperty;
  while Assigned(OP) do
  begin
    Result:=OP.Name+'.'+Result;
    OP:=OP.OwnerProperty;
  end;
end;

function TProperty.GetTypeName: string;
begin
  Result:=PropType.Name;
end;

function TProperty.GetTypeKind: TTypeKind;
begin
  if Emulated then
    if Custom then Result:=FPropData.PropType.Kind
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkSet: Result:=tkEnumeration;
        else Result:=tkUnknown;
        end
      else Result:=tkUnknown
  else Result:=PropType.Kind;
end;

function TProperty.GetOrdType: TOrdType;
begin
  if TypeKind in [tkInteger,tkChar,tkWChar,tkEnumeration,tkSet] then
    Result:=FTypeData.OrdType
  else Result:=TOrdType(0);
end;

function TProperty.GetMinValue: Longint;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      case OwnerProperty.TypeKind of
        tkSet: Result:=Integer(Low(Boolean));
      else Result:=0;
      end
    else Result:=0
  else
    case TypeKind of
      tkInteger,tkChar,tkEnumeration: Result:=FTypeData.MinValue;
      tkSet: Result:=GetTypeData(CompType).MinValue;
    else Result:=0;
    end;
end;

function TProperty.GetMaxValue: Longint;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      case OwnerProperty.TypeKind of
        tkSet: Result:=Integer(High(Boolean));
      else Result:=0;
      end
    else Result:=0
  else
    case TypeKind of
      tkInteger,tkChar,tkEnumeration: Result:=FTypeData.MaxValue;
      tkSet: Result:=GetTypeData(CompType).MaxValue;
    else Result:=0;
    end;
end;

function TProperty.GetBaseType: PTypeInfo;
begin
  if TypeKind=tkEnumeration then Result:=FTypeData.BaseType^
  else Result:=nil;
end;

function TProperty.GetEnumCount: Integer;
begin
  if TypeKind=tkEnumeration then Result:=Succ(MaxValue-MinValue)
  else Result:=0;
end;

function TProperty.GetEName(Value: Integer): string;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      case OwnerProperty.TypeKind of
        tkSet: Result:=GetEnumName(TypeInfo(Boolean),Value);
      else Result:='';
      end
    else Result:=''
  else
    if TypeKind=tkEnumeration then Result:=GetEnumName(PropType,Value)
    else Result:='';
end;

function TProperty.GetEValue(Value: string): Integer;
begin
  if TypeKind=tkEnumeration then Result:=GetEnumValue(PropType,Value)
  else Result:=0;
end;

function TProperty.GetCompType: PTypeInfo;
begin
  if TypeKind=tkSet then Result:=FTypeData.CompType^
  else Result:=nil;
end;

function TProperty.GetFloatType: TFloatType;
begin
  if TypeKind=tkFloat then Result:=FTypeData.FloatType
  else Result:=TFloatType(0);
end;

function TProperty.GetMaxLength: Byte;
begin
  if TypeKind=tkString then Result:=FTypeData.MaxLength
  else Result:=0;
end;

function TProperty.GetClassType: TClass;
begin
  if TypeKind=tkClass then Result:=FTypeData.ClassType
  else Result:=nil;
end;

function TProperty.GetParentInfo: PTypeInfo;
begin
  if TypeKind=tkClass then Result:=FTypeData.ParentInfo^
  else Result:=nil;
end;

function TProperty.GetUnitName: ShortString;
begin
  if TypeKind=tkClass then Result:=FTypeData.UnitName
  else Result:='';
end;

function TProperty.GetMethodKind: TMethodKind;
begin
  if TypeKind=tkMethod then Result:=FTypeData.MethodKind
  else Result:=TMethodKind(0);
end;

function TProperty.GetParamCount: Integer;
begin
  if TypeKind=tkMethod then Result:=FTypeData.ParamCount
  else Result:=0;
end;

function TProperty.GetParamFlags(Index: Integer): TParamFlags;
var
  P: PByte;
  i: Integer;
begin
  Result:=[];
  if TypeKind=tkMethod then
  begin
    P:=PByte(@FTypeData.ParamList);
    for i:=0 to Pred(ParamCount) do
    begin
      if i=Index then
      begin
        Result:=TParamFlags(P^);
        Break;
      end;
      Inc(P);
      Inc(P,Succ(P^));
      Inc(P,Succ(P^));
    end;
  end;
end;

function TProperty.GetParamName(Index: Integer): ShortString;
var
  P: PByte;
  i: Integer;
begin
  Result:='';
  if TypeKind=tkMethod then
  begin
    P:=PByte(@FTypeData.ParamList);
    for i:=0 to Pred(ParamCount) do
    begin
      Inc(P);
      if i=Index then
      begin
        Result:=PShortString(P)^;
        Break;
      end;
      Inc(P,Succ(P^));
      Inc(P,Succ(P^));
    end;
  end;
end;

function TProperty.GetParamType(Index: Integer): ShortString;
var
  P: PByte;
  i: Integer;
begin
  Result:='';
  if TypeKind=tkMethod then
  begin
    P:=PByte(@FTypeData.ParamList);
    for i:=0 to Pred(ParamCount) do
    begin
      Inc(P);
      Inc(P,Succ(P^));
      if i=Index then
      begin
        Result:=PShortString(P)^;
        Break;
      end;
      Inc(P,Succ(P^));
    end;
  end;
end;

function TProperty.GetParameter(Index: Integer): ShortString;
begin
  if TypeKind=tkMethod then
  begin
    Result:='';
    if pfVar in ParamFlags[Index] then Result:=Result+'var ';
    if pfConst in ParamFlags[Index] then Result:=Result+'const ';
    if pfArray in ParamFlags[Index] then Result:=Result+'array of ';
    Result:=Result+ParamNames[Index]+': '+ParamTypes[Index];
  end
  else Result:='';
end;

function TProperty.GetResultType: ShortString;
var
  P: PByte;
  i: Integer;
begin
  if (TypeKind=tkMethod) and (MethodKind=mkFunction) then
  begin
    P:=PByte(@FTypeData.ParamList);
    for i:=0 to Pred(ParamCount) do
    begin
      Inc(P);
      Inc(P,Succ(P^));
      Inc(P,Succ(P^));
    end;
    Result:=PShortString(P)^;
  end
  else Result:='';
end;

function TProperty.GetMethodDeclaration: string;
var
  i: Integer;
begin
  if TypeKind=tkMethod then
  begin
    if MethodKind=mkProcedure then Result:='procedure'
    else Result:='function';
    if ParamCount>0 then
    begin
      Result:=Result+' (';
      for i:=0 to Pred(ParamCount) do
      begin
        Result:=Result+Parameters[i];
        if i<Pred(ParamCount) then Result:=Result+'; '
        else Result:=Result+')';
      end;
    end;
    if MethodKind=mkFunction then Result:=Result+': '+ResultType;
    Result:=Result+' of object;'
  end
  else Result:='';
end;

function TProperty.GetIntfParent: PTypeInfo;
begin
  if TypeKind=tkInterface then Result:=FTypeData.IntfParent^
  else Result:=nil;
end;

function TProperty.GetIntfFlags: TIntfFlags;
begin
  if TypeKind=tkInterface then Result:=FTypeData.IntfFlags
  else Result:=[];
end;

function TProperty.GetGUID: TGUID;
begin
  if TypeKind=tkInterface then Result:=FTypeData.GUID
  else FillChar(Result,SizeOf(Result),0);
end;

function TProperty.GetIntfUnit: ShortString;
begin
  if TypeKind=tkInterface then Result:=FTypeData.IntfUnit
  else Result:='';
end;

{$IFNDEF VERSION3}

function TProperty.GetMinInt64Value: Int64;
begin
  if TypeKind=tkInt64 then Result:=FTypeData.MinInt64Value
  else Result:=0;
end;

function TProperty.GetMaxInt64Value: Int64;
begin
  if TypeKind=tkInt64 then Result:=FTypeData.MaxInt64Value
  else Result:=0;
end;

{$ENDIF}

function TProperty.GetAsFloat: Extended;
begin
  if TypeKind=tkFloat then Result:=GetFloatProp(Instance,FPropInfo)
  else Result:=0;
end;

procedure TProperty.SetAsFloat(const Value: Extended);
begin
  if TypeKind=tkFloat then SetFloatProp(Instance,FPropInfo,Value);
end;

function TProperty.GetAsMethod: TMethod;
begin
  if TypeKind=tkMethod then Result:=GetMethodProp(Instance,FPropInfo)
  else FillChar(Result,SizeOf(Result),0);
end;

procedure TProperty.SetAsMethod(const Value: TMethod);
begin
  if TypeKind=tkMethod then SetMethodProp(Instance,FPropInfo,Value);
end;

function TProperty.GetAsInteger: Longint;
begin
  if TypeKind in tkOrdinals then Result:=GetOrdProp(Instance,FPropInfo)
  else Result:=0;
end;

procedure TProperty.SetAsInteger(const Value: Longint);
begin
  if TypeKind in tkOrdinals then SetOrdProp(Instance,FPropInfo,Value);
end;

function TProperty.GetAsChar: Char;
begin
  if TypeKind in tkChars then Result:=Char(AsInteger)
  else Result:=#0;
end;

procedure TProperty.SetAsChar(const Value: Char);
begin
  if TypeKind in tkChars then AsInteger:=Ord(Value);
end;

function TProperty.GetAsBoolean: Boolean;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      Result:=OwnerProperty.AsInteger and (1 shl Owner.IndexOf(Self)) <> 0
    else Result:=False
  else
    if TypeKind in tkOrdinals then Result:=AsInteger<>0
    else Result:=False;
end;

procedure TProperty.SetAsBoolean(const Value: Boolean);
begin
  if Emulated and not Custom then
  begin
    if Assigned(OwnerProperty) then
      if Value then
        OwnerProperty.AsInteger:=OwnerProperty.AsInteger or 1 shl Owner.IndexOf(Self)
      else
        OwnerProperty.AsInteger:=OwnerProperty.AsInteger and not (1 shl Owner.IndexOf(Self));
  end
  else
    if TypeKind in tkOrdinals then AsInteger:=Longint(Value);
end;

function TProperty.GetAsObject: TObject;
begin
  if Custom then Result:=TObject(StrToInt(GetStringValue))
  else
    if TypeKind=tkClass then Result:=TObject(GetOrdProp(Instance,FPropInfo))
    else Result:=nil;
end;

procedure TProperty.SetAsObject(const Value: TObject);
begin
  if TypeKind=tkClass then SetOrdProp(Instance,FPropInfo,Longint(Value));
end;

function TProperty.GetAsDateTime: TDateTime;
begin
  Result:=AsFloat;
end;

procedure TProperty.SetAsDateTime(const Value: TDateTime);
begin
  AsFloat:=Value;
end;

function TProperty.GetAsDate: TDate;
begin
  Result:=Int(AsFloat);
end;

procedure TProperty.SetAsDate(const Value: TDate);
begin
  AsFloat:=Int(Value);
end;

function TProperty.GetAsTime: TTime;
begin
  Result:=Frac(AsFloat);
end;

procedure TProperty.SetAsTime(const Value: TTime);
begin
  AsFloat:=Frac(Value);
end;

function TProperty.GetAsString: string;
begin
  Result:=GetStringValue;
end;

procedure TProperty.SetAsString(const Value: string);
begin
  if AsString<>Value then SetStringValue(Value);
end;

{$IFDEF VERSION3}
{$DEFINE NOGETPROPVALUE}
{$ENDIF}
{$IFDEF VERSION4}
{$DEFINE NOGETPROPVALUE}
{$ENDIF}

function TProperty.GetAsVariant: Variant;
begin
  {$IFNDEF NOGETPROPVALUE}
  Result:=GetPropValue(Instance,Name,False);
  {$ELSE}
  if TypeKind=tkVariant then Result:=GetVariantProp(Instance,FPropInfo)
  else FillChar(Result,SizeOf(Result),0);
  {$ENDIF}
end;

procedure TProperty.SetAsVariant(const Value: Variant);
begin
  if TypeKind=tkVariant then SetVariantProp(Instance,FPropInfo,Value);
end;

{$IFNDEF VERSION3}

function GetInterfaceProperty(Instance: TObject; PropInfo: PPropInfo): IUnknown;
type
  TInterfaceGetProc = function: IUnknown of object;
  TInterfaceIndexedGetProc = function(Index: Integer): IUnknown of object;
var
  P: ^IUnknown;
  M: TMethod;
  Getter: Longint;
begin
  Getter:=Longint(PropInfo^.GetProc);
  if (Getter and $FF000000)=$FF000000 then
  begin
    P:=Pointer(Integer(Instance)+(Getter and $00FFFFFF));
    Result:=P^;
  end
  else
  begin
    if (Getter and $FF000000)=$FE000000 then
      M.Code:=Pointer(PInteger(PInteger(Instance)^+SmallInt(Getter))^)
    else M.Code:=Pointer(Getter);
    M.Data:=Instance;
    if PropInfo^.Index=Integer($80000000) then Result:=TInterfaceGetProc(M)()
    else Result:=TInterfaceIndexedGetProc(M)(PropInfo^.Index);
  end;
end;

procedure SetInterfaceProperty(Instance: TObject; PropInfo: PPropInfo;
  const Value: IUnknown);
type
  TInterfaceSetProc = procedure(const Value: IUnknown) of object;
  TInterfaceIndexedSetProc = procedure (Index: Integer; const Value: IUnknown) of object;
var
  P: ^IUnknown;
  M: TMethod;
  Setter: Longint;
begin
  Setter:=Longint(PropInfo^.SetProc);
  if (Setter and $FF000000)=$FF000000 then
  begin
    P:=Pointer(Integer(Instance)+(Setter and $00FFFFFF));
    P^:=Value;
  end
  else
  begin
    if (Setter and $FF000000)=$FE000000 then
      M.Code:=Pointer(PInteger(PInteger(Instance)^+SmallInt(Setter))^)
    else M.Code:=Pointer(Setter);
    M.Data:=Instance;
    if PropInfo^.Index=Integer($80000000) then TInterfaceSetProc(M)(Value)
    else TInterfaceIndexedSetProc(M)(PropInfo^.Index,Value);
  end;
end;

function TProperty.GetAsInterface: IUnknown;
begin
  Result:=GetInterfaceProperty(Instance,FPropInfo)
end;

procedure TProperty.SetAsInterface(const Value: IUnknown);
begin
  SetInterfaceProperty(Instance,FPropInfo,Value);
end;

{$ENDIF}

constructor TProperty.Create(AOwner: TPropertyList; ARoot,AInstance: TComponent; APropInfo: PPropInfo; APropData: TCustomPropData);
begin
  inherited Create;
  FOwner:=AOwner;
  FRoot:=ARoot;
  FProperties:=CreatePropertyList;
  FProperties.FRoot:=ARoot;
  FInstance:=AInstance;
  FPropInfo:=APropInfo;
  if Emulated then FPropData:=APropData
  else FTypeData:=GetTypeData(PropType);
  if Custom then FTypeData:=GetTypeData(FPropData.PropType);
  case TypeKind of
    tkVariant: FProperties.AddEmulated(Self);
    tkSet: FProperties.AddEmulated(Self);
    tkClass:
      if not IsType(TypeInfo(TComponent)) then FProperties.Instance:=TComponent(AsObject);
  end;
end;

destructor TProperty.Destroy;
begin
  FProperties.Free;
  inherited;
end;

procedure TProperty.Assign(Source: TProperty);
begin
  FRoot:=Source.FRoot;
  FInstance:=Source.FInstance;
  FPropInfo:=Source.FPropInfo;
  FTypeData:=Source.FTypeData;
  FPropData:=Source.FPropData;
end;

function TProperty.CreatePropertyList: TPropertyList;
begin
  Result:=TPropertyList.Create(Self);
end;

function TProperty.DisplayValue: string;
begin
  if TypeKind=tkClass then
    if Assigned(AsObject) then
      if AsObject is TMenuItem then Result:='(Menu)'
      else
        if AsObject is TComponent then Result:=TComponent(AsObject).Name
        else
          if (AsObject is TGraphic) and TGraphic(AsObject).Empty or
            (AsObject is TPicture) and not Assigned(TPicture(AsObject).Graphic) then
              Result:='(None)'
          else Result:='('+AsObject.ClassName+')'
    else Result:=''
  else Result:=AsString;
end;

function TProperty.GetStringValue: string;
var
  i: Integer;
  Val: Longint;
  {$IFNDEF VERSION3}
  Obj: IUnknown;
  {$ENDIF}
begin
  if Emulated then
    if Custom then Result:=FPropData.GetProc(Instance,Self)
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkVariant: Result:=VariantName(TVarData(OwnerProperty.AsVariant).VType);
          tkSet: Result:=GetEnumName(TypeInfo(Boolean),Integer(AsBoolean));
        else Result:='';
        end
      else Result:=''
  else
    case TypeKind of
      tkString,tkLString,tkWString: Result:=GetStrProp(Instance,FPropInfo);
      tkChar,tkWChar: Result:=AsChar;
      tkInteger:
        if PropType=TypeInfo(TCursor) then Result:=CursorToString(AsInteger)
        else
          if PropType=TypeInfo(TColor) then Result:=ColorToString(AsInteger)
          else
            if PropType=TypeInfo(TShortCut) then
            begin
              Result:=ShortCutToText(AsInteger);
              if Result='' then Result:='(None)';
            end
            else
              if PropType=TypeInfo(TModalResult) then Result:=ModalResultToString(AsInteger)
              else
                if (PropType<>TypeInfo(TFontCharset)) or not CharsetToIdent(AsInteger,Result) then
                  Result:=IntToStr(AsInteger);
      tkVariant:
        if VarType(AsVariant)<>varNull then Result:=AsVariant
        else Result:='';
      tkEnumeration: Result:=Names[AsInteger];
      tkSet:
      begin
        Result:='[';
        Val:=AsInteger;
        for i:=MinValue to MaxValue do
        begin
          if Val and 1 <> 0 then Result:=Result+GetEnumName(CompType,i)+',';
          Val:=Val shr 1;
        end;
        if Result[Length(Result)]=',' then Delete(Result,Length(Result),1);
        Result:=Result+']';
      end;
      tkFloat:
        if PropType=TypeInfo(TDateTime) then
          if AsFloat<>0 then Result:=DateTimeToStr(AsDateTime)
          else Result:=''
        else
          if PropType=TypeInfo(TDate) then
            if AsFloat<>0 then Result:=DateToStr(AsDate)
            else Result:=''
          else
            if PropType=TypeInfo(TTime) then
              if AsFloat<>0 then Result:=TimeToStr(AsTime)
              else Result:=''
            else Result:=FloatToStr(AsFloat);
      {$IFNDEF VERSION3}
      tkInterface:
      begin
        Result:='';
        if Assigned(Root) then
          with Root do
            for i:=0 to Pred(ComponentCount) do
            begin
              Obj:=nil;
              if (Components[i].GetInterface(GUID,Obj)) and (Obj=AsInterface) then
                Result:=Components[i].Name;
            end;
      end;
      {$ENDIF}
      tkClass:
        if IsType(TypeInfo(TComponent)) then
        begin
          if Assigned(AsObject) then Result:=TComponent(AsObject).Name
          else Result:='';
        end
        else Result:=IntToStr(Integer(AsObject));
      tkMethod:
        if Assigned(FRoot) then Result:=FRoot.MethodName(AsMethod.Code)
        else Result:='';
    else Result:='';
    end;
end;

procedure TProperty.SetStringValue(const Value: string);
var
  Val,Enum: string;
  P,Result,V: Integer;
  M: TMethod;
  VV: Variant;
  {$IFNDEF VERSION3}
  Comp: TComponent;
  Obj: IUnknown;
  {$ENDIF}
begin
  try
    if Emulated then
    begin
      if Custom then FPropData.SetProc(Instance,Self,Value)
      else
        if Assigned(OwnerProperty) then
          case OwnerProperty.TypeKind of
            tkVariant:
            begin
              VV:=OwnerProperty.AsVariant;
              TVarData(VV).VType:=VariantType(Value);
              OwnerProperty.AsVariant:=VV;
            end;
            tkSet: AsBoolean:=GetEnumValue(TypeInfo(Boolean),Value)<>0;
          end;
    end
    else
      case TypeKind of
        tkString,tkLString,tkWString: SetStrProp(Instance,FPropInfo,Value);
        tkChar,tkWChar:
          if Length(Value)>0 then AsChar:=Value[1]
          else AsChar:=#0;
        tkInteger:
          if PropType=TypeInfo(TCursor) then AsInteger:=StringToCursor(Value)
          else
            if PropType=TypeInfo(TColor) then AsInteger:=StringToColor(Value)
            else
              if PropType=TypeInfo(TModalResult) then AsInteger:=StringToModalResult(Value)
              else
                if PropType=TypeInfo(TShortCut) then AsInteger:=TextToShortCut(Value)
                else
                  if (PropType=TypeInfo(TFontCharset)) and IdentToCharset(Value,Result) then
                    AsInteger:=Result
                  else AsInteger:=StrToInt(Value);
        tkVariant: AsVariant:=Value;
        tkEnumeration:
        begin
          V:=Values[Value];
          if (V>=MinValue) and (V<=MaxValue) then AsInteger:=V
          else raise Exception.Create('');
        end;
        tkSet:
          if Length(Value)>2 then
          begin
            Val:=Value;
            if Val[1]='[' then Delete(Val,1,1);
            if Val[Length(Val)]=']' then Delete(Val,Length(Val),1);
            Result:=0;
            repeat
              P:=Pos(',',Val);
              if (P=0) and (Val<>'') then Enum:=Val
              else Enum:=Copy(Val,1,Pred(P));
              Delete(Val,1,P);
              V:=GetEnumValue(CompType,Enum);
              if V=0 then V:=1
              else V:=V shl 1;
              Result:=Result or V;
            until P=0;
            AsInteger:=Result;
          end;
        tkFloat:
        if PropType=TypeInfo(TDateTime) then AsDateTime:=StrToDateTime(Value)
        else
          if PropType=TypeInfo(TDate) then AsDate:=StrToDate(Value)
          else
            if PropType=TypeInfo(TTime) then AsTime:=StrToTime(Value)
            else AsFloat:=StrToFloat(Value);
        tkClass:
          if not IsType(TypeInfo(TMenuItem)) then
            if IsType(TypeInfo(TComponent)) then
            begin
              if Assigned(FRoot) then
                AsObject:=FRoot.FindComponent(Value);
            end
            else AsObject:=TObject(StrToInt(Value));
        {$IFNDEF VERSION3}
        tkInterface:
          if Assigned(FRoot) then
          begin
            Comp:=FRoot.FindComponent(Value);
            if Assigned(Comp) then
            begin
              Obj:=nil;
              if Comp.GetInterface(GUID,Obj) then AsInterface:=Obj;
            end;
          end;
        {$ENDIF}
        tkMethod:
          if Assigned(FRoot) then
          begin
            M.Code:=FRoot.MethodAddress(Value);
            M.Data:=FRoot;
            AsMethod:=M;
          end;
      end;
  except
    on E: Exception do
      raise EPropertyException.CreateFmt(strPropListInvalidValue,[E.Message]);
  end;
end;

procedure TProperty.ValuesList(const Values: TStrings);

{$IFDEF VER150}
{$DEFINE SYSCOLOR}
{$ENDIF}
{$IFDEF VER170}
{$DEFINE SYSCOLOR}
{$ENDIF}

const
  {$IFDEF SYSCOLOR}
  SysColor = clSystemColor;
  {$ELSE}
  SysColor = $80000000;
  {$ENDIF}
var
  i: Integer;
  S: string;
  {$IFNDEF VERSION3}
  Obj: IUnknown;
  {$ENDIF}
begin
  if Assigned(Values) then
    with Values do
    begin
      Clear;
      if Emulated and Assigned(OwnerProperty) and (OwnerProperty.TypeKind=tkVariant) then
        for i:=0 to High(VariantNames) do Add(VariantName(VariantNames[i].Value))
      else
        case TypeKind of
          tkString,tkLString,tkWString:
            if PropType=TypeInfo(TFontName) then Assign(Screen.Fonts);
          tkEnumeration: for i:=MinValue to MaxValue do Add(Self.Names[i]);
          tkInteger:
            if PropType=TypeInfo(TColor) then
            begin
              Add(ColorToString(clBlack));
              Add(ColorToString(clMaroon));
              Add(ColorToString(clGreen));
              Add(ColorToString(clOlive));
              Add(ColorToString(clNavy));
              Add(ColorToString(clPurple));
              Add(ColorToString(clTeal));
              Add(ColorToString(clGray));
              Add(ColorToString(clSilver));
              Add(ColorToString(clRed));
              Add(ColorToString(clLime));
              Add(ColorToString(clYellow));
              Add(ColorToString(clBlue));
              Add(ColorToString(clFuchsia));
              Add(ColorToString(clAqua));
              Add(ColorToString(clWhite));
              for i:=0 to 32 do
                if ColorToIdent(TColor(DWORD(i) or SysColor),S) then Add(S);
            end
            else
              if PropType=TypeInfo(TCursor) then
              begin
                for i:=0 downto -32 do
                  if CursorToIdent(i,S) then Add(S);
              end
              else
                if PropType=TypeInfo(TFontCharset) then
                begin
                  for i:=Low(TFontCharset) to High(TFontCharset) do
                    if CharsetToIdent(i,S) then Add(S);
                end
                else
                  if PropType=TypeInfo(TFontName) then
                  begin
                    for i:=Low(TFontCharset) to High(TFontCharset) do
                      if CharsetToIdent(i,S) then Add(S);
                  end
                  else
                    if PropType=TypeInfo(TShortCut) then
                    begin
                      Add('(None)');
                      for i:=Ord('A') to Ord('Z') do Add(ShortCutToText(ShortCut(i,[ssCtrl])));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(i));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(ShortCut(i,[ssCtrl])));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(ShortCut(i,[ssShift])));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(ShortCut(i,[ssCtrl,ssShift])));
                      Add(ShortCutToText(VK_INSERT));
                      Add(ShortCutToText(ShortCut(VK_INSERT,[ssShift])));
                      Add(ShortCutToText(ShortCut(VK_INSERT,[ssCtrl])));
                      Add(ShortCutToText(VK_DELETE));
                      Add(ShortCutToText(ShortCut(VK_DELETE,[ssShift])));
                      Add(ShortCutToText(ShortCut(VK_DELETE,[ssCtrl])));
                      Add(ShortCutToText(ShortCut(VK_BACK,[ssAlt])));
                      Add(ShortCutToText(ShortCut(VK_BACK,[ssAlt,ssShift])));
                    end
                    else
                      if PropType=TypeInfo(TModalResult) then
                      begin
                        for i:=mrNone to mrYesToAll do
                          if ModalResultToIdent(i,S) then Add(S);
                      end;
          tkClass:
            if Assigned(FRoot) then
              with FRoot do
                for i:=0 to Pred(ComponentCount) do
                  if IsCompatibleObject(Components[i]) then
                    with Components[i] do
                      if Name<>'' then Add(Name);
          {$IFNDEF VERSION3}
          tkInterface:
            if Assigned(FRoot) then
              with FRoot do
                for i:=0 to Pred(ComponentCount) do
                begin
                  Obj:=nil;
                  if Components[i].GetInterface(GUID,Obj) then
                    with Components[i] do
                      if Name<>'' then Add(Name);
                end;
          {$ENDIF}
      end;
    end;
end;

function TProperty.IsCompatibleObject(AObject: TObject): Boolean;
begin
  Result:=IsCompatibleType(AObject.ClassInfo);
end;

function TProperty.IsCompatibleType(ATypeInfo: PTypeInfo): Boolean;
begin
  Result:=False;
  if TypeKind=tkClass then
    while Assigned(ATypeInfo) do
    begin
      Result:=ATypeInfo=PropType;
      if Result then Break;
      with GetTypeData(ATypeInfo)^ do
        if Assigned(ParentInfo) then ATypeInfo:=ParentInfo^
        else ATypeInfo:=nil;
    end;
end;

function TProperty.IsType(ATypeInfo: PTypeInfo): Boolean;
var
  ITypeInfo: PTypeInfo;
begin
  Result:=False;
  ITypeInfo:=PropType;
  if TypeKind=tkClass then
    while Assigned(ITypeInfo) do
    begin
      Result:=ITypeInfo=ATypeInfo;
      if Result then Break;
      with GetTypeData(ITypeInfo)^ do
        if Assigned(ParentInfo) then ITypeInfo:=ParentInfo^
        else ITypeInfo:=nil;
    end;
end;

function TProperty.IsCompatible(P: TProperty): Boolean;
begin
  Result:=Assigned(P) and (FTypeData=P.TypeData);
end;

function TPropertyList.GetOwnerList: TPropertyList;
begin
  if Assigned(Owner) then Result:=Owner.Owner
  else Result:=nil;
end;

function TPropertyList.GetLevel: Integer;
var
  P: TPropertyList;
begin
  Result:=0;
  P:=OwnerList;
  while Assigned(P) do
  begin
    Inc(Result);
    P:=P.OwnerList;
  end;
end;

function TPropertyList.GetProperty(AIndex: Integer): TProperty;
begin
  with FProperties do
    if (AIndex>=0) and (AIndex<Count) then Result:=TProperty(Items[AIndex])
    else Result:=nil;
end;

function TPropertyList.GetCount: Integer;
begin
  Result:=FProperties.Count;
end;

procedure TPropertyList.SetRoot(const Value: TComponent);
begin
  if FRoot<>Value then
  begin
    FRoot:=Value;
    Update;
  end;
end;

procedure TPropertyList.SetInstance(const Value: TComponent);
begin
  if FInstance<>Value then
  begin
    FInstance:=Value;
    Update;
  end;
end;

procedure TPropertyList.Clear;
var
  i: Integer;
begin
  for i:=0 to Pred(Count) do Properties[i].Free;
  FProperties.Clear;
end;

procedure QuickSort(SortList: PPointerList; L,R: Integer; Compare: TCompareMethod);
var
  I,J: Integer;
  P,T: Pointer;
begin
  repeat
    I:=L;
    J:=R;
    P:=SortList^[(L+R) shr 1];
    repeat
      while Compare(SortList^[I],P)<0 do Inc(I);
      while Compare(SortList^[J],P)>0 do Dec(J);
      if I<=J then
      begin
        T:=SortList^[I];
        SortList^[I]:=SortList^[J];
        SortList^[J]:=T;
        Inc(I);
        Dec(J);
      end;
    until I>J;
    if L<J then QuickSort(SortList,L,J,Compare);
    L:=I;
  until I>=R;
end;

procedure TPropertyList.Sort;
begin
  with FProperties do
    if Assigned(List) and (Count>0) then
      QuickSort(List,0,Pred(Count),Compare);
end;

constructor TPropertyList.Create(AOwner: TProperty);
begin
  inherited Create;
  FOwner:=AOwner;
  FProperties:=TList.Create;
end;

destructor TPropertyList.Destroy;
begin
  Clear;
  FProperties.Free;
  inherited;
end;

function TPropertyList.CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty;
begin
  Result:=TProperty.Create(Self,FRoot,FInstance,APropInfo,nil);
end;

procedure TPropertyList.AddEmulated(P: TProperty);
var
  i: Integer;
begin
  with P do
    case TypeKind of
      tkVariant:
        Self.FProperties.Add(TProperty.Create(Self,nil,nil,nil,nil));
      tkSet:
        for i:=MinValue to MaxValue do
          Self.FProperties.Add(TProperty.Create(Self,nil,nil,nil,nil));
    end;
end;

procedure TPropertyList.Update;

  procedure EnumProperties(const Instance: TPersistent);
  var
    Props: PPropList;
    i,Count: Integer;
    Prop: TProperty;
    PropData: TCustomPropData;
  begin
    if Assigned(Instance) then
    begin
      GetMem(Props,GetTypeData(Instance.ClassInfo).PropCount*SizeOf(PPropInfo));
      try
        Count:=GetPropList(Instance.ClassInfo,tkAny,Props);
        for i:=0 to Pred(Count) do
        begin
          if not Assigned(OwnerList) then PropData:=CustomProperties.GetPropertyData(Instance.ClassType,Props[i].Name)
          else PropData:=nil;
          if Assigned(PropData) then Prop:=CreateProperty(nil,PropData)
          else Prop:=CreateProperty(Props[i],nil);
          if Filter(Prop) then FProperties.Add(Prop)
          else Prop.Free
        end;
        if not Assigned(OwnerList) then
          with CustomProperties do
            for i:=0 to Pred(Count) do
              with TCustomPropData(Items[i]) do
                if not Assigned(Self.FindProperty(PropName)) then
                begin
                  PropData:=GetPropertyData(Instance.ClassType,PropName);
                  if Assigned(PropData) then
                  begin
                    Prop:=CreateProperty(nil,PropData);
                    if Filter(Prop) then FProperties.Add(Prop)
                    else Prop.Free
                  end;
                end;
      finally
        FreeMem(Props);
      end;
    end;
  end;

begin
  Clear;
  if Assigned(FInstance) and (FInstance.ClassInfo<>nil) then
  begin
    EnumProperties(FInstance);
    Sort;
  end;
end;

function TPropertyList.Compare(P1,P2: TProperty): Integer;
begin
  if Level>0 then Result:=OwnerList.Compare(P1,P2)
  else Result:=CompareStr(P1.Name,P2.Name);
end;

function TPropertyList.Filter(P: TProperty): Boolean;
begin
  Result:=True;
end;

function TPropertyList.IndexOf(const Item: TProperty): Integer;
begin
  Result:=FProperties.IndexOf(Item);
end;

function TPropertyList.IndexOfName(const Name: string): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Pred(Count) do
    if Properties[i].Name=Name then
    begin
      Result:=i;
      Break;
    end;
end;

function TPropertyList.FindProperty(const Name: string): TProperty;

  function DoFindProperty(Name: string; PropertyList: TPropertyList): TProperty;
  var
    P: Integer;
    S: string;
  begin
    if Name<>'' then
      with PropertyList do
      begin
        P:=Pos('.',Name);
        if P=0 then S:=Name
        else S:=Copy(Name,1,Pred(P));
        Result:=Properties[IndexOfName(S)];
        if Assigned(Result) and (P<>0) then
        begin
          Delete(Name,1,P);
          Result:=DoFindProperty(Name,Result.Properties);
        end;
      end
      else Result:=nil;
  end;

begin
  Result:=DoFindProperty(Name,Self);
end;

initialization
  CustomProperties:=TCustomPropertiesList.Create;
finalization
  UnregisterCustomProperties;
  CustomProperties.Free;
end.
