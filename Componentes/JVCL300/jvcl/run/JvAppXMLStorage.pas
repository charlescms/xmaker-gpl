{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvAppXMLStorage.pas, released on 2003-12-06.

The Initial Developer of the Original Code is Olivier Sannier
Portions created by Olivier Sannier are Copyright (C) 2003 Olivier Sannier
All Rights Reserved.

Contributor(s):
  Marcel Bestebroer

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvAppXMLStorage.pas,v 1.51 2005/02/27 16:57:57 jfudickar Exp $

unit JvAppXMLStorage;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  {$IFDEF HAS_UNIT_LIBC}
  Libc,
  {$ENDIF HAS_UNIT_LIBC}
  Classes,
  JvAppStorage, JvPropertyStore, JvSimpleXml;

type
  TJvCustomAppXMLStorage = class;
  TJvAppXMLStorageOptions = class(TJvAppStorageOptions)
  private
    FWhiteSpaceReplacement: string;
    FStorage: TJvCustomAppXMLStorage;
    function GetAutoEncodeEntity: Boolean;
    function GetAutoEncodeValue: Boolean;
    procedure SetAutoEncodeEntity(const Value: Boolean);
    procedure SetAutoEncodeValue(const Value: Boolean);
    function GetAutoIndent: Boolean;
    procedure SetAutoIndent(const Value: Boolean);
  protected
    procedure SetWhiteSpaceReplacement(const Value: string);
  public
    constructor Create; override;
  published
    property WhiteSpaceReplacement: string read FWhiteSpaceReplacement write SetWhiteSpaceReplacement;
    property AutoEncodeValue: Boolean read GetAutoEncodeValue write SetAutoEncodeValue;
    property AutoEncodeEntity: Boolean read GetAutoEncodeEntity write SetAutoEncodeEntity;
    property AutoIndent: Boolean read GetAutoIndent write SetAutoIndent;
  end;

  // This is the base class for an in memory XML file storage
  // There is at the moment only one derived class that simply
  // allows to flush into a disk file.
  // But there may be a new descendent that stores into a
  // database field, if anyone is willing to write such
  // a class (nothing much is involved, use the AsString property).
  TJvCustomAppXMLStorage = class(TJvCustomAppMemoryFileStorage)
  private
    function GetStorageOptions : TJvAppXMLStorageOptions;
    procedure SetStorageOptions (Value: TJvAppXMLStorageOptions);
  protected
    FXml: TJvSimpleXML;

    class function GetStorageOptionsClass: TJvAppStorageOptionsClass; override;

    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;

    function EnsureNoWhiteSpaceInNodeName(NodeName: string): string;

    function DefaultExtension: string; override;

    function GetOnDecodeValue: TJvSimpleXMLEncodeEvent;
    function GetOnEncodeValue: TJvSimpleXMLEncodeEvent;
    procedure SetOnDecodeValue(const Value: TJvSimpleXMLEncodeEvent);
    procedure SetOnEncodeValue(const Value: TJvSimpleXMLEncodeEvent);

    function GetRootNodeName: string;
    procedure SetRootNodeName(const Value: string);
    // Returns the last node in path, if it exists.
    // Returns nil in all other cases
    // If StartNode is nil, then FXML.Root is used as a
    // starting point for Path
    function GetNodeFromPath(Path: string; StartNode: TJvSimpleXmlElem = nil): TJvSimpleXmlElem;
    // Reads the \ separated Key string and returns the last created node
    function CreateAndSetNode(Key: string): TJvSimpleXmlElem;
    procedure EnumFolders(const Path: string; const Strings: TStrings;
      const ReportListAsValue: Boolean = True); override;
    procedure EnumValues(const Path: string; const Strings: TStrings;
      const ReportListAsValue: Boolean = True); override;
    function IsFolderInt(const Path: string; ListIsValue: Boolean = True): Boolean; override;
    procedure SplitKeyPath(const Path: string; out Key, ValueName: string); override;
    function PathExistsInt(const Path: string): Boolean; override;
    function ValueStoredInt(const Path: string): Boolean; override;
    procedure DeleteValueInt(const Path: string); override;
    procedure DeleteSubTreeInt(const Path: string); override;
    function DoReadBoolean(const Path: string; Default: Boolean): Boolean; override;
    procedure DoWriteBoolean(const Path: string; Value: Boolean); override;
    function DoReadInteger(const Path: string; Default: Integer): Integer; override;
    procedure DoWriteInteger(const Path: string; Value: Integer); override;
    function DoReadFloat(const Path: string; Default: Extended): Extended; override;
    procedure DoWriteFloat(const Path: string; Value: Extended); override;
    function DoReadString(const Path: string; const Default: string): string; override;
    procedure DoWriteString(const Path: string; const Value: string); override;
    function DoReadBinary(const Path: string; Buf: Pointer; BufSize: Integer): Integer; override;
    procedure DoWriteBinary(const Path: string; Buf: Pointer; BufSize: Integer); override;

    property Xml: TJvSimpleXML read FXml;
    property RootNodeName: string read GetRootNodeName write SetRootNodeName;
    property OnEncodeValue: TJvSimpleXMLEncodeEvent read GetOnEncodeValue write SetOnEncodeValue;
    property OnDecodeValue: TJvSimpleXMLEncodeEvent read GetOnDecodeValue write SetOnDecodeValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property StorageOptions: TJvAppXMLStorageOptions read GetStorageOptions write SetStorageOptions;
  end;

  // This class handles the flushing into a disk file
  // and publishes a few properties for them to be
  // used by the user in the IDE
  TJvAppXMLFileStorage = class(TJvCustomAppXMLStorage)
  public
    procedure Flush; override;
    procedure Reload; override;
    property Xml;
    property AsString;
  published
    property AutoFlush;
    property AutoReload;
    property FileName;
    property Location;
    property RootNodeName;
    property SubStorages;
    property OnGetFileName;
    property OnEncodeValue;
    property OnDecodeValue;
  end;

procedure StorePropertyStoreToXmlFile(APropertyStore: TJvCustomPropertyStore;
  const AFileName: string; const AAppStoragePath: string = '');
procedure LoadPropertyStoreFromXmlFile(APropertyStore: TJvCustomPropertyStore;
  const AFileName: string; const AAppStoragePath: string = '');

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvAppXMLStorage.pas,v $';
    Revision: '$Revision: 1.51 $';
    Date: '$Date: 2005/02/27 16:57:57 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, TypInfo,
  JclStrings,
  JvJCLUtils, JvTypes, JvConsts, JvResources;

const
  cNullDigit = '0';
  cCount = 'Count';
  cEmptyPath = 'EmptyPath';

//=== { TJvAppXMLStorageOptions } ============================================

constructor TJvAppXMLStorageOptions.Create;
begin
  inherited Create;
  FWhiteSpaceReplacement := '';  // to keep the original behaviour
end;

function TJvAppXMLStorageOptions.GetAutoEncodeEntity: Boolean;
begin
  Result := sxoAutoEncodeEntity in FStorage.Xml.Options;
end;

function TJvAppXMLStorageOptions.GetAutoEncodeValue: Boolean;
begin
  Result := sxoAutoEncodeValue in FStorage.Xml.Options;
end;

function TJvAppXMLStorageOptions.GetAutoIndent: Boolean;
begin
  Result := sxoAutoIndent in FStorage.Xml.Options;
end;

procedure TJvAppXMLStorageOptions.SetAutoEncodeEntity(
  const Value: Boolean);
begin
  if Value then
    FStorage.Xml.Options := FStorage.Xml.Options + [sxoAutoEncodeEntity]
  else
    FStorage.Xml.Options := FStorage.Xml.Options - [sxoAutoEncodeEntity];
end;

procedure TJvAppXMLStorageOptions.SetAutoEncodeValue(const Value: Boolean);
begin
  if Value then
    FStorage.Xml.Options := FStorage.Xml.Options + [sxoAutoEncodeValue]
  else
    FStorage.Xml.Options := FStorage.Xml.Options - [sxoAutoEncodeValue];
end;

procedure TJvAppXMLStorageOptions.SetAutoIndent(const Value: Boolean);
begin
  if Value then
    FStorage.Xml.Options := FStorage.Xml.Options + [sxoAutoIndent]
  else
    FStorage.Xml.Options := FStorage.Xml.Options - [sxoAutoIndent];
end;

procedure TJvAppXMLStorageOptions.SetWhiteSpaceReplacement(const Value: string);
begin
  if Value <> FWhiteSpaceReplacement then
    if StrContainsChars(Value, AnsiWhiteSpace, True) then
      raise EJVCLException.CreateRes(@RsEWhiteSpaceReplacementCannotContainSpaces)
    else
      FWhiteSpaceReplacement := Value;
end;

//=== { TJvCustomAppXMLStorage } =============================================

constructor TJvCustomAppXMLStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  (StorageOptions as TJvAppXMLStorageOptions).FStorage := Self;
  FXml := TJvSimpleXml.Create(nil);
  FXml.Options := [sxoAutoIndent];
  // (rom) should probably be a resourcestring
  RootNodeName := 'Configuration';
end;

destructor TJvCustomAppXMLStorage.Destroy;
begin
  inherited Destroy;
  // delete after the inherited call, see comment in
  // the base class, TJvCustomMemoryFileAppStorage
  FXml.Free;
end;

class function TJvCustomAppXMLStorage.GetStorageOptionsClass: TJvAppStorageOptionsClass;
begin
  Result := TJvAppXMLStorageOptions;
end;

function TJvCustomAppXMLStorage.EnsureNoWhiteSpaceInNodeName(NodeName: string): string;
var
  J, K: Integer;
  WSRLength: Integer;
  InsertIndex: Integer;
  WhiteSpaceCount: Integer;
  FixedNodeName: string;
  WhiteSpaceReplacement: string;
begin
  WhiteSpaceReplacement := TJvAppXMLStorageOptions(StorageOptions).WhiteSpaceReplacement;
  if StrContainsChars(NodeName, AnsiWhiteSpace, False) then
  begin
    WSRLength := Length(WhiteSpaceReplacement);
    case WSRLength of
      0:
        raise EJVCLException.CreateRes(@RsENodeNameCannotContainSpaces);
      1:
        NodeName := StrReplaceChars(NodeName, AnsiWhiteSpace, WhiteSpaceReplacement[1]);
      else
        begin
          WhiteSpaceCount := StrCharsCount(NodeName, AnsiWhiteSpace);
          SetLength(FixedNodeName, Length(NodeName) + WhiteSpaceCount*(WSRLength - 1));
          InsertIndex := 1;
          for J := 1 to Length(NodeName) do
          begin
            if NodeName[J] in AnsiWhiteSpace then
            begin
              // if we have a white space then we replace it with the WSR string
              for K := 1 to WSRLength do
              begin
                FixedNodeName[InsertIndex] := WhiteSpaceReplacement[K];
                Inc(InsertIndex);
              end;
            end
            else
            begin
              // else we simply copy the character
              FixedNodeName[InsertIndex] := NodeName[J];
              Inc(InsertIndex);
            end;
          end;
          NodeName := FixedNodeName;
        end;
    end;
  end;
  Result := NodeName;
end;

procedure TJvCustomAppXMLStorage.SetRootNodeName(const Value: string);
begin
  if Value = '' then
    raise EPropertyError.CreateRes(@RsENodeCannotBeEmpty)
  else
  begin
    Xml.Root.Name := EnsureNoWhiteSpaceInNodeName(Value);
    Root := Value;
  end;
end;

procedure TJvCustomAppXMLStorage.SplitKeyPath(const Path: string; out Key, ValueName: string);
begin
  inherited SplitKeyPath(Path, Key, ValueName);
  ValueName := EnsureNoWhiteSpaceInNodeName(ValueName);
  if Key = '' then
    Key := Path;
end;

function TJvCustomAppXMLStorage.ValueStoredInt(const Path: string): Boolean;
var
  Section: string;
  Key: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, Section, Key);
  Result := False;
  Node := GetNodeFromPath(Section);
  if Assigned(Node) then
    Result := Assigned(Node.Items.ItemNamed[Key]);
end;

procedure TJvCustomAppXMLStorage.DeleteValueInt(const Path: string);
var
  Node: TJvSimpleXmlElem;
  Section: string;
  Key: string;
begin
  if ValueStored(Path) then
  begin
    ReloadIfNeeded;
    SplitKeyPath(Path, Section, Key);
    Node := GetNodeFromPath(Section);
    if Assigned(Node) then
      Node.Items.Delete(Key);
    FlushIfNeeded;
  end;
end;

procedure TJvCustomAppXMLStorage.DeleteSubTreeInt(const Path: string);
var
  TopNode: string;
  Node: TJvSimpleXmlElem;
  Parent: TJvSimpleXmlElem;
  Name: string;
begin
  ReloadIfNeeded;
  TopNode := GetAbsPath(Path);
  if TopNode = '' then
    TopNode := Path;
  Node := GetNodeFromPath(TopNode);
  if Assigned(Node) then
  begin
    Name := Node.Name;
    Parent := Node.Parent;
    if Assigned(Parent) then
      Parent.Items.Delete(Name)
    else
      Node.Clear;
    FlushIfNeeded;
  end;
end;

function TJvCustomAppXMLStorage.DoReadInteger(const Path: string; Default: Integer): Integer;
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  if Assigned(Node) and Assigned(Node.Items.ItemNamed[ValueName]) then
  begin
    try
      Result := Node.Items.ItemNamed[ValueName].IntValue;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end;
  end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
end;

procedure TJvCustomAppXMLStorage.DoWriteInteger(const Path: string; Value: Integer);
var
  ParentPath: string;
  ValueName: string;
  ANode: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  ANode := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ANode.Items.ItemNamed[ValueName].IntValue := Value;
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.DoReadFloat(const Path: string; Default: Extended): Extended;
var
  ParentPath: string;
  ValueName: string;
  StrValue: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  if Assigned(Node) and Assigned(Node.Items.ItemNamed[ValueName]) then
  begin
    try
      StrValue := Node.Items.ItemNamed[ValueName].Value;
      // Result := StrToFloat(StrValue);
      if BinStrToBuf(StrValue, @Result, SizeOf(Result)) <> SizeOf(Result) then
        Result := Default;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end;
  end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
end;

procedure TJvCustomAppXMLStorage.DoWriteFloat(const Path: string; Value: Extended);
var
  ParentPath: string;
  ValueName: string;
  ANode: TJvSimpleXmlElem;
  //Buffer: Extended;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  ANode := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
//  ANode.Items.ItemNamed[ValueName].Value := FloatToStr(Value);
  ANode.Items.ItemNamed[ValueName].Value := BufToBinStr(@Value, SizeOf(Value));
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.DoReadString(const Path: string; const Default: string): string;
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  if Assigned(Node) and Assigned(Node.Items.ItemNamed[ValueName]) then
    try
      Result := Node.Items.ItemNamed[ValueName].Value;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
end;

procedure TJvCustomAppXMLStorage.DoWriteString(const Path: string; const Value: string);
var
  ParentPath: string;
  ValueName: string;
  ANode: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  ANode := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ANode.Items.ItemNamed[ValueName].Value := Value;
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.DoReadBinary(const Path: string; Buf: Pointer; BufSize: Integer): Integer;
var
  Value: string;
begin
  ReloadIfNeeded;
  Value := DoReadString(Path, '');
  Result := BinStrToBuf(Value, Buf, BufSize);
end;

procedure TJvCustomAppXMLStorage.DoWriteBinary(const Path: string; Buf: Pointer; BufSize: Integer);
begin
  ReloadIfNeeded;
  DoWriteString(Path, BufToBinStr(Buf, BufSize));
  FlushIfNeeded;
end;

procedure TJvCustomAppXMLStorage.EnumFolders(const Path: string;
  const Strings: TStrings; const ReportListAsValue: Boolean);
var
  RefPath: string;
  I: Integer;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  RefPath := GetAbsPath(Path);
  if RefPath = '' then
    RefPath := cEmptyPath;

  Node := GetNodeFromPath(RefPath);

  if Node <> nil then
  begin
    Strings.BeginUpdate;
    try
      Strings.Clear;
      for I := 0 to Node.Items.Count - 1 do
        Strings.Add(Node.Items[I].Name);
    finally
      Strings.EndUpdate;
    end;
  end
  else
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [RefPath]);
end;

procedure TJvCustomAppXMLStorage.EnumValues(const Path: string;
  const Strings: TStrings; const ReportListAsValue: Boolean);
var
  PathIsList: Boolean;
  RefPath: string;
  I: Integer;
  Node: TJvSimpleXmlElem;
  Name: string;
begin
  ReloadIfNeeded;
  PathIsList := ReportListAsValue and ListStored(Path);
  RefPath := GetAbsPath(Path);
  if RefPath = '' then
    RefPath := cEmptyPath;

  Node := GetNodeFromPath(RefPath);

  if Node <> nil then
  begin
    Strings.BeginUpdate;
    try
      Strings.Clear;
      for I := 0 to Node.Items.Count - 1 do
      begin
        Name := Node.Items[I].Name;
        if (not PathIsList or (not AnsiSameText(cCount, Name) and
          not NameIsListItem(Name))) then
          Strings.Add(Name);
      end;
    finally
      Strings.EndUpdate;
    end;
  end
  else
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [RefPath]);
end;

function TJvCustomAppXMLStorage.IsFolderInt(const Path: string;
  ListIsValue: Boolean): Boolean;
var
  RefPath: string;
  ValueNames: TStrings;
  I: Integer;
  Node: TJvSimpleXmlElem;
  Name: string;
begin
  ReloadIfNeeded;
  RefPath := GetAbsPath(Path);
  if RefPath = '' then
    RefPath := cEmptyPath;

  Node := GetNodeFromPath(RefPath);
  Result := False;
  if Assigned(Node) and ListIsValue and
    Assigned(Node.Items.ItemNamed[cCount]) then
  begin
    ValueNames := TStringList.Create;
    try
      I := 0;
      repeat
        Name := Node.Items[I].Name;
        Result := not AnsiSameText(cCount, Name) and not NameIsListItem(Name);
        Inc(I);
      until (I = Node.Items.Count) or Result;
    finally
      ValueNames.Free;
    end;
  end;
end;

function TJvCustomAppXMLStorage.GetRootNodeName: string;
begin
  Result := Xml.Root.Name;
end;

function TJvCustomAppXMLStorage.CreateAndSetNode(Key: string): TJvSimpleXmlElem;
begin
  Xml.Options := Xml.Options + [sxoAutoCreate];
  Result := GetNodeFromPath(Key);
  Xml.Options := Xml.Options - [sxoAutoCreate];
end;

function TJvCustomAppXMLStorage.GetNodeFromPath(Path: string; StartNode: TJvSimpleXmlElem = nil): TJvSimpleXmlElem;
var
  NodeList: TStringList;
  I: Integer;
  Node: TJvSimpleXmlElem;
  NodeName: string;
begin
  Result := nil;

  ReloadIfNeeded;
  NodeList := TStringList.Create;
  if StartNode <> nil then
    Node := StartNode
  else
    Node := Xml.Root;

  try
    try
      StrToStrings(Path, '\', NodeList, False);
      for I := 0 to NodeList.Count - 1 do
      begin
        // Node names cannot have spaces in them so we replace
        // those spaces by the replacement string. If there is
        // no such string, we trigger an exception as the XML
        // standard doesn't allow spaces in node names
        NodeName := EnsureNoWhiteSpaceInNodeName(NodeList[I]);

        // If the name is the same as the root AND the first in 
        if not ((I = 0) and (NodeName = Xml.Root.Name)) then
          if Assigned(Node.Items.ItemNamed[NodeName]) then
            Node := Node.Items.ItemNamed[NodeName]
          else
            Exit;
      end;
    finally
      NodeList.Free;
    end;
  except
    Node := nil;
  end;
  Result := Node;
end;

function TJvCustomAppXMLStorage.PathExistsInt(const Path: string): Boolean;
var
  SubKey: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  Result := False;
  SplitKeyPath(Path, SubKey, ValueName);
  Node := GetNodeFromPath(SubKey);
  if Assigned(Node) then
    Result := Assigned(Node.Items.ItemNamed[ValueName]);
end;

function TJvCustomAppXMLStorage.DoReadBoolean(const Path: string;
  Default: Boolean): Boolean;
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  if Assigned(Node) and Assigned(Node.Items.ItemNamed[ValueName]) then
    try
      Result := Node.Items.ItemNamed[ValueName].BoolValue;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
end;

procedure TJvCustomAppXMLStorage.DoWriteBoolean(const Path: string;
  Value: Boolean);
var
  ParentPath: string;
  ValueName: string;
  ANode: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  ANode := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ANode.Items.ItemNamed[ValueName].BoolValue := Value;
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.GetAsString: string;
begin
  Result := Xml.SaveToString;
end;

procedure TJvCustomAppXMLStorage.SetAsString(const Value: string);
begin
  Xml.LoadFromString(Value);
end;

function TJvCustomAppXMLStorage.DefaultExtension: string;
begin
  Result := 'xml';
end;

function TJvCustomAppXMLStorage.GetOnDecodeValue: TJvSimpleXMLEncodeEvent;
begin
  Result := FXml.OnDecodeValue;
end;

function TJvCustomAppXMLStorage.GetOnEncodeValue: TJvSimpleXMLEncodeEvent;
begin
  Result := FXml.OnEncodeValue;
end;

procedure TJvCustomAppXMLStorage.SetOnDecodeValue(
  const Value: TJvSimpleXMLEncodeEvent);
begin
  FXml.OnDecodeValue := Value;
end;

procedure TJvCustomAppXMLStorage.SetOnEncodeValue(
  const Value: TJvSimpleXMLEncodeEvent);
begin
  FXml.OnEncodeValue := Value;
end;

function TJvCustomAppXMLStorage.GetStorageOptions : TJvAppXMLStorageOptions;
begin
  Result := TJvAppXMLStorageOptions(inherited StorageOptions);
end;

procedure TJvCustomAppXMLStorage.SetStorageOptions (Value: TJvAppXMLStorageOptions);
begin
  (Inherited StorageOptions).Assign(Value);
end;

//=== { TJvAppXMLFileStorage } ===============================================

procedure TJvAppXMLFileStorage.Flush;
var
  Path: string;
begin
  if (FullFileName <> '') and not ReadOnly and not (csDesigning in ComponentState) then
  begin
    Path := ExtractFilePath(FullFileName);
    if Path <> '' then
      ForceDirectories(Path);
    Xml.SaveToFile(FullFileName);
  end;
end;

procedure TJvAppXMLFileStorage.Reload;
begin
  if not IsUpdating and not (csDesigning in ComponentState) then
  begin
    inherited Reload;
    if FileExists(FullFileName) then
      Xml.LoadFromFile(FullFileName)
    else // file may have disappeared. If so, clear the root element
      Xml.Root.Clear;
  end;
end;

//=== { Common procedures } ==================================================

procedure StorePropertyStoreToXmlFile(APropertyStore: TJvCustomPropertyStore;
  const AFileName: string; const AAppStoragePath: string = '');
var
  AppStorage: TJvAppXMLFileStorage;
  SaveAppStorage: TJvCustomAppStorage;
  SaveAppStoragePath: string;
begin
  if not Assigned(APropertyStore) then
    Exit;
  AppStorage := TJvAppXMLFileStorage.Create(nil);
  try
    AppStorage.Location := flCustom;
    AppStorage.FileName := AFileName;
    SaveAppStorage := APropertyStore.AppStorage;
    SaveAppStoragePath := APropertyStore.AppStoragePath;
    try
      APropertyStore.AppStoragePath := AAppStoragePath;
      APropertyStore.AppStorage := AppStorage;
      APropertyStore.StoreProperties;
    finally
      APropertyStore.AppStoragePath := SaveAppStoragePath;
      APropertyStore.AppStorage := SaveAppStorage;
    end;
  finally
    AppStorage.Free;
  end;
end;

procedure LoadPropertyStoreFromXmlFile(APropertyStore: TJvCustomPropertyStore;
  const AFileName: string; const AAppStoragePath: string = '');
var
  AppStorage: TJvAppXMLFileStorage;
  SaveAppStorage: TJvCustomAppStorage;
  SaveAppStoragePath: string;
begin
  if not Assigned(APropertyStore) then
    Exit;
  AppStorage := TJvAppXMLFileStorage.Create(nil);
  try
    AppStorage.Location := flCustom;
    AppStorage.FileName := AFileName;
    SaveAppStorage := APropertyStore.AppStorage;
    SaveAppStoragePath := APropertyStore.AppStoragePath;
    try
      APropertyStore.AppStoragePath := AAppStoragePath;
      APropertyStore.AppStorage := AppStorage;
      APropertyStore.LoadProperties;
    finally
      APropertyStore.AppStoragePath := SaveAppStoragePath;
      APropertyStore.AppStorage := SaveAppStorage;
    end;
  finally
    AppStorage.Free;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

