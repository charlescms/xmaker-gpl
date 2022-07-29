(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.007                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit DBInspct;

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, DB, DBCtrls,
  DBTables, InspCtrl, StrsEdit, PicsEdit;

type

  TCustomDBInspector = class;

  TInspectorDataLink = class(TDataLink)
  private
    FInspector: TCustomDBInspector;
    procedure DataSetBeforePost(ADataSet: TDataSet);
  protected
    procedure CheckBrowseMode; override;
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(AInspector: TCustomDBInspector);
  end;

  TBlobEditorType = (beNone,beText,beImage);

  TGetBlobEditorTypeEvent = procedure(Sender: TObject; Field: TField; var BlobEditorType: TBlobEditorType) of object;

  TCustomDBInspector = class(TCustomInspector)
  private
    FMyself: Boolean;
    FDataLink: TInspectorDataLink;
    FOnGetBlobEditorType: TGetBlobEditorTypeEvent;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetReadOnlyProperty: Boolean;
    procedure SetReadOnlyProperty(Value: Boolean);
    procedure ActiveChanged;
    function ActiveDataSet: Boolean;
    function LinkedDataSet: TDataSet;
    function VisibleCount: Integer;
  protected
    procedure ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetMaxLength(TheIndex: Integer): Integer; override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetIndent: Integer; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
    function GetBlobEditor: TBlobEditorType; virtual;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnlyProperty write SetReadOnlyProperty default False;
    property OnGetBlobEditorType: TGetBlobEditorTypeEvent read FOnGetBlobEditorType write FOnGetBlobEditorType;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function VisibleIndex(TheIndex: Integer): Integer;
  end;

  TDBInspector = class(TCustomDBInspector)
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
    property PaintStyle;
    property Splitter;
    property DataSource;
    property ReadOnly;
    property OnGetNextValue;
    property OnGetButtonType;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnGetBlobEditorType;
  end;

implementation

procedure TInspectorDataLink.DataSetBeforePost(ADataSet: TDataSet);
begin
  FInspector.ApplyChanges;
end;

procedure TInspectorDataLink.CheckBrowseMode;
begin
  inherited;
  if Assigned(DataSet) and (DataSet.State=dsEdit) then FInspector.ApplyChanges;
end;

procedure TInspectorDataLink.ActiveChanged;
begin
  inherited;
  FInspector.ActiveChanged;
end;

procedure TInspectorDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(DataSet) then DataSet.BeforePost:=DataSetBeforePost;
  FInspector.Update;
end;

procedure TInspectorDataLink.LayoutChanged;
begin
  with FInspector do
  begin
    ItemCount:=VisibleCount;
    Update;
  end;
end;

procedure TInspectorDataLink.RecordChanged(Field: TField);
begin
  inherited;
  with FInspector do
    if not FMyself then Update
    else FMyself:=False;
end;

constructor TInspectorDataLink.Create(AInspector: TCustomDBInspector);
begin
  inherited Create;
  FInspector:=AInspector;
end;

function TCustomDBInspector.GetDataSource: TDataSource;
begin
  Result:=FDataLink.DataSource;
end;

procedure TCustomDBInspector.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource:=Value;
end;

function TCustomDBInspector.GetReadOnlyProperty: Boolean;
begin
  Result:=FDataLink.ReadOnly;
end;

procedure TCustomDBInspector.SetReadOnlyProperty(Value: Boolean);
begin
  FDataLink.ReadOnly:=Value;
end;

procedure TCustomDBInspector.ActiveChanged;
begin
  if ActiveDataSet then ItemCount:=VisibleCount
  else ItemCount:=0;
end;

function TCustomDBInspector.ActiveDataSet: Boolean;
begin
  with FDataLink do
    Result:=Assigned(DataSource) and Assigned(DataSource.DataSet) and DataSource.DataSet.Active;
end;

function TCustomDBInspector.LinkedDataSet: TDataSet;
begin
  Result:=FDataLink.DataSource.DataSet;
end;

function TCustomDBInspector.VisibleCount: Integer;
var
  i: Integer;
begin
  Result:=0;
  if LinkedDataSet<>nil then
    with LinkedDataSet do
      for i:=0 to Pred(FieldCount) do
        if Fields[i].Visible then Inc(Result);
end;

procedure TCustomDBInspector.ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string);
begin
  if Editing and ActiveDataSet then
    with LinkedDataSet do
      if not (State in [dsEdit,dsInsert]) and not Fields[VisibleIndex(TheIndex)].IsBlob then
      begin
        FMyself:=True;
        Edit;
      end;
  inherited;
end;

function TCustomDBInspector.GetName(TheIndex: Integer): string;
begin
  if ActiveDataSet then
    Result:=LinkedDataSet.Fields[VisibleIndex(TheIndex)].DisplayName
  else Result:='';
end;

function TCustomDBInspector.GetValue(TheIndex: Integer): string;
begin
  if ActiveDataSet then
    with LinkedDataSet.Fields[VisibleIndex(TheIndex)] do
      if IsBlob then
        if (LinkedDataSet.Fields[VisibleIndex(TheIndex)] as TBlobField).BlobSize=0 then Result:='(Blob)'
        else Result:='(BLOB)'
      else Result:=AsString
  else Result:='';
end;

procedure TCustomDBInspector.SetValue(TheIndex: Integer; const Value: string);
begin
  if ActiveDataSet then
    with LinkedDataSet do
    begin
      if not (State in [dsEdit,dsInsert]) then Edit;
      Fields[VisibleIndex(TheIndex)].AsString:=Value;
    end;
end;

function TCustomDBInspector.GetMaxLength(TheIndex: Integer): Integer;
begin
  if ActiveDataSet then
    Result:=LinkedDataSet.Fields[VisibleIndex(TheIndex)].Size
  else Result:=0;
end;

function TCustomDBInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=ReadOnly or (ActiveDataSet and LinkedDataSet.Fields[VisibleIndex(TheIndex)].IsBlob);
end;

function TCustomDBInspector.GetIndent: Integer;
begin
  Result:=0;
end;

function TCustomDBInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=True;
end;

function TCustomDBInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  case GetBlobEditor of
    beText,beImage: Result:=btDialog;
  else Result:=inherited GetButtonType(TheIndex);
  end;
end;

function TCustomDBInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  case GetBlobEditor of
    beText,beImage: Result:=True;
  else Result:=inherited GetEnableExternalEditor(TheIndex);
  end;
end;

function TCustomDBInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  case GetBlobEditor of
    beText:
      if ActiveDataSet then
        with LinkedDataSet,TfrmStrings.Create(Application) do
        try
          Strings.Assign(Fields[VisibleIndex(TheIndex)]);
          if ShowModal=mrOk then
          begin
            if not (State in [dsEdit,dsInsert]) then Edit;
            Fields[VisibleIndex(TheIndex)].Assign(Strings);
          end;
        finally
          Free;
        end;
    beImage:
      if ActiveDataSet then
        with LinkedDataSet,TfrmPicture.Create(Application) do
        try
          Picture.Assign(Fields[VisibleIndex(TheIndex)]);
          if ShowModal=mrOk then
          begin
            if not (State in [dsEdit,dsInsert]) then Edit;
            with Fields[VisibleIndex(TheIndex)] do
              if Picture.Graphic is TBitmap then Assign(Picture)
              else Clear;
          end;
        finally
          Free;
        end;
  else Result:=inherited CallEditor(TheIndex);
  end;
end;

function TCustomDBInspector.GetBlobEditor: TBlobEditorType;
begin
  Result:=beNone;
  if (ItemIndex<>-1) and ActiveDataSet then
    with LinkedDataSet,Fields[ItemIndex] do
      if IsBlob then
        if Assigned(FOnGetBlobEditorType) then FOnGetBlobEditorType(Self,Fields[ItemIndex],Result);
end;

constructor TCustomDBInspector.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink:=TInspectorDataLink.Create(Self);
end;

destructor TCustomDBInspector.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function TCustomDBInspector.VisibleIndex(TheIndex: Integer): Integer;
var
  i,V: Integer;
begin
  Result:=-1;
  V:=-1;
  if LinkedDataSet<>nil then
    with LinkedDataSet do
      for i:=0 to Pred(FieldCount) do
        if Fields[i].Visible then
        begin
          Inc(V);
          if V=TheIndex then
          begin
            Result:=i;
            Break;
          end;
        end;
end;

end.
