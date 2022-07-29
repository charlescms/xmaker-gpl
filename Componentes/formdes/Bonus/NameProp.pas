(*  GREATIS BONUS * NameProp                  *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit NameProp;

interface

{$IFDEF VER140}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER150}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER170}
{$DEFINE NEWDSGNINTF}
{$ENDIF}

uses
  {$IFDEF NEWDSGNINTF}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  Classes, Forms, Controls, SysUtils, Dialogs, Registry;

type
  TNameProperty=class(TComponentNameProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation

uses NPEdit;

const
  RegName = 'SOFTWARE\Greatis';
  RegSecName = 'NameProp';
  OptionsSecName = RegSecName+'\Options';
  PrefixesSecName = RegSecName+'\Prefixes';
  HistorySecName = RegSecName+'\History';
  MaxHistory=100;

var
  List,History: TStringList;

procedure TNameProperty.Edit;
var
  S: TCaption;
  Idx: Integer;
  Ancestor: TClass;
begin
  with TfrmNameEditor.Create(Application) do
  try
    lsbPrefixes.Items.Assign(List);
    cmbName.Items.Assign(History);
    cmbName.MaxLength:=GetEditLimit;

    if TComponent(GetComponent(0)).Owner<>nil then
      S:=TComponent(GetComponent(0)).Owner.Name+'.'
    else S:='';
    Caption:=S+TComponent(GetComponent(0)).Name+'.'+GetName;

    S:=GetComponent(0).ClassName;
    NativeType:=S;

    with List do
    begin
      Idx:=IndexOf(Copy(S,2,Pred(Length(S))));
      if Idx<>-1 then
      begin
        lblPrefix.Caption:=TPrefix(Objects[Idx]);
        lblClassName.Caption:=S;
        ComponentType:=S;
      end
      else
      begin
        Ancestor:=GetComponent(0).ClassType;
        repeat
          Ancestor:=Ancestor.ClassParent;
          S:=Ancestor.ClassName;
          Idx:=IndexOf(Copy(S,2,Pred(Length(S))));
        until not Assigned(Ancestor) or (Idx<>-1);

        if Idx=-1 then
        begin
          lblPrefix.Caption:='obj';
          lblClassName.Caption:='Derived from TObject';
          ComponentType:='TObject';
        end
        else
        begin
          lblPrefix.Caption:=TPrefix(Objects[Idx]);
          lblClassName.Caption:='Derived from '+S;
          ComponentType:=S;
        end;
      end;
    end;

    S:=TComponent(GetComponent(0)).Name;
    if Copy(S,1,3)=lblPrefix.Caption then
      cmbName.Text:=Copy(S,4,Length(S)-3);

    if ShowModal=mrOK then
    begin
      SetValue(lblPrefix.Caption+cmbName.Text);
      with cmbName.Items,cmbName do
      begin
        if (Count>0) and (IndexOf(Text)<>-1) then Move(IndexOf(Text),0)
        else Insert(0,Text);
        if Count>MaxHistory then Delete(Pred(Count));
      end;
    end;
    List.Assign(lsbPrefixes.Items);
    History.Assign(cmbName.Items);
  finally
    Free;
  end;
end;

function TNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=inherited GetAttributes+[paDialog];
end;

procedure CreateList;
var
  i: Integer;
  L: TStringList;
begin
  List:=TStringList.Create;
  L:=TStringList.Create;
  with TRegIniFile.Create(RegName) do
  try
    ReadSectionValues(PrefixesSecName,L);
    for i:=0 to Pred(L.Count) do
      List.AddObject(L.Names[i],Pointer(TPrefix(L.Values[L.Names[i]])));
  finally
    L.Free;
    Free;
  end;
end;

procedure FreeList;
var
  i: Integer;
begin
  with TRegIniFile.Create(RegName) do
  try
    with List do
    try
      for i:=0 to Pred(Count) do
        WriteString(PrefixesSecName,Strings[i],TPrefix(Objects[i]));
    finally
      Free;
    end;
  finally
    Free;
  end;
end;

procedure ReadConfig;
var
  i,Cnt: Integer;
begin
  with TRegIniFile.Create(RegName) do
  try
    WriteString(RegSecName,'@Name','Component Name Property Editor');
    WriteString(RegSecName,'@Path','');
    WriteString(RegSecName,'@Version','3');
    DlgLeft:=ReadInteger(OptionsSecName,'DlgLeft',200);
    DlgTop:=ReadInteger(OptionsSecName,'DlgTop',140);
    Cnt:=ReadInteger(HistorySecName,'Count',0);
    History:=TStringList.Create;
    for i:=1 to Cnt do
      History.Add(ReadString(HistorySecName,IntToStr(i),''));
  finally
    Free;
  end;
end;

procedure WriteConfig;
var
  i: Integer;
begin
  with TRegIniFile.Create(RegName) do
  try
    WriteInteger(OptionsSecName,'DlgLeft',DlgLeft);
    WriteInteger(OptionsSecName,'DlgTop',DlgTop);
    WriteInteger(HistorySecName,'Count',History.Count);
    for i:=1 to History.Count do
      WriteString(HistorySecName,IntToStr(i),History[Pred(i)]);
  finally
    Free;
  end;
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TComponentName),TComponent,'Name',TNameProperty);
end;

initialization
  CreateList;
  ReadConfig;
finalization
  WriteConfig;
  FreeList;
end.
