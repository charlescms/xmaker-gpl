(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.005                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit IniInsp;

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

interface

uses Windows, SysUtils, Classes, IniFiles, InspCtrl;

type

  TCustomIniInspector = class(TCustomInspector)
  private
    FIniFile: TIniFile;
    FFileName: TFileName;
    procedure SetFileName(const Value: TFileName);
    function ValidIndex(TheIndex: Integer): Boolean;
    function GetSection(TheIndex: Integer): string;
  protected
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetExpandState(TheIndex: Integer): TExpandState; override;
    function GetLevel(TheIndex: Integer): Integer; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    procedure Expand(TheIndex: Integer); override;
    procedure Collapse(TheIndex: Integer); override;
    property FileName: TFileName read FFileName write SetFileName;
  public
    procedure CreateWnd; override;
  end;

  TIniInspector = class(TCustomIniInspector)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property IntegralHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property FileName;
    property Splitter;
    property PaintStyle;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetInplaceEditorType;
    property OnGetMaxLength;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetReadOnly;
    property OnGetExpandState;
    property OnGetLevel;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetAutoApply;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
  end;

implementation

procedure TCustomIniInspector.SetFileName(const Value: TFileName);
var
  Buffer: array[0..1024] of Char;
  NamePart: PChar;
begin
  if Assigned(FIniFile) then
  begin
    FIniFile.Free;
    FIniFile:=nil;
  end;
  if SearchPath(nil,PChar(Value),nil,SizeOf(Buffer),Buffer,NamePart)>0 then
    FFileName:=Buffer
  else FFileName:=Value;
  if HandleAllocated then
  begin
    FIniFile:=TIniFile.Create(FFileName);
    FIniFile.ReadSections(Items);
    if Items.Count>0 then ItemIndex:=0;
  end;
end;

function TCustomIniInspector.ValidIndex(TheIndex: Integer): Boolean;
begin
  Result:=(TheIndex>=0) and (TheIndex<Items.Count);
end;

function TCustomIniInspector.GetSection(TheIndex: Integer): string;
begin
  while ValidIndex(TheIndex) and (GetLevel(TheIndex)>0) do Dec(TheIndex);
  Result:=GetName(TheIndex);
end;

procedure TCustomIniInspector.CreateWnd;
begin
  inherited;
  FIniFile:=TIniFile.Create(FFileName);
  FIniFile.ReadSections(Items);
  if Items.Count>0 then ItemIndex:=0;
end;

function TCustomIniInspector.GetName(TheIndex: Integer): string;
begin
  if ValidIndex(TheIndex) then
    if GetLevel(TheIndex)=0 then Result:=Items[TheIndex]
    else Result:=Items.Names[TheIndex]
  else Result:='';
end;

function TCustomIniInspector.GetValue(TheIndex: Integer): string;
begin
  if ValidIndex(TheIndex) then
    if GetLevel(TheIndex)=0 then Result:='(Section)'
    else
    begin
      Result:=Items[TheIndex];
      Result:=Copy(Result,Succ(Pos('=',Result)),Length(Result));
    end
  else Result:='';
end;

procedure TCustomIniInspector.SetValue(TheIndex: Integer; const Value: string);
begin
  if ValidIndex(TheIndex) and (GetLevel(TheIndex)>0) then
  begin
    FIniFile.WriteString(GetSection(TheIndex),GetName(TheIndex),Value);
    Items[TheIndex]:=GetName(TheIndex)+'='+Value;
  end;
end;

function TCustomIniInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=GetLevel(TheIndex)=0;
end;

function TCustomIniInspector.GetExpandState(TheIndex: Integer): TExpandState;
begin
  if GetLevel(TheIndex)=0 then
    if ValidIndex(Succ(TheIndex)) and (GetLevel(Succ(TheIndex))>0) then
      Result:=esCollapse
    else Result:=esExpand
  else Result:=esNone;
end;

function TCustomIniInspector.GetLevel(TheIndex: Integer): Integer;
begin
  if ValidIndex(TheIndex) then Result:=Integer(Assigned(Items.Objects[TheIndex]))
  else Result:=0;
end;

function TCustomIniInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=GetLevel(TheIndex)>0;
end;

procedure TCustomIniInspector.Expand(TheIndex: Integer);
var
  SL: TStringList;
  i: Integer;
begin
  if GetExpandState(TheIndex)=esExpand then
  begin
    SL:=TStringList.Create;
    try
      FIniFile.ReadSection(GetName(TheIndex),SL);
      for i:=0 to Pred(SL.Count) do
        Sl[i]:=SL[i]+'='+FIniFile.ReadString(GetName(TheIndex),SL[i],'');
      SL.Sorted:=Sorted;
      with Items do
      begin
        BeginUpdate;
        try
          for i:=Pred(SL.Count) downto 0 do
            InsertObject(Succ(TheIndex),SL[i],Pointer(1));
        finally
          EndUpdate;
        end;
      end;
      Invalidate;
    finally
      SL.Free;
    end;
  end;
end;

procedure TCustomIniInspector.Collapse(TheIndex: Integer);
begin
  if (GetExpandState(TheIndex)=esCollapse) and ValidIndex(Succ(TheIndex)) then
    with Items do
    begin
      BeginUpdate;
      try
        while GetLevel(Succ(TheIndex))>0 do Delete(Succ(TheIndex));
      finally
        EndUpdate;
      end;
    end;
end;

end.
