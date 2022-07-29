(*  GREATIS FORM DESIGNER COMPONENT PRO  *)
(*  unit version 0.00.085                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm   *)
(*  b-team@greatis.com                   *)

unit DCMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  Clipbrd, StdCtrls;

type

  TGrabType = (gtNormal,gtLocked,gtMulti);

  TGrabPosition = (
    gpNone,
    gpLeftTop,
    gpLeftMiddle,
    gpLeftBottom,
    gpMiddleTop,
    gpMiddleBottom,
    gpRightTop,
    gpRightMiddle,
    gpRightBottom);

  TCustomDesignerComponent = class;

  TGrabHandle = class(TCustomControl)
  private
    FPosition: TGrabPosition;
    FRect: TRect;
    FLocked: Boolean;
    procedure SetPosition(const Value: TGrabPosition);
    procedure SetRect(const Value: TRect);
    procedure SetLocked(const Value: Boolean);
    procedure UpdateCoords;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Position: TGrabPosition read FPosition write SetPosition;
    property Rect: TRect read FRect write SetRect;
    property Locked: Boolean read FLocked write SetLocked;
  end;

  TGrabHandles = class(TComponent)
  private
    FItems: array[TGrabPosition] of TGrabHandle;
    FControl: TControl;
    FVisible: Boolean;
    procedure SetControl(const Value: TControl);
    procedure SetVisible(const Value: Boolean);
    function GetDesigner: TCustomDesignerComponent;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update;
    procedure UpdateCoords;
    procedure BringToFront;
    function FindHandle(AComponent: TComponent): TGrabPosition;
    function IsGrabHandle(AComponent: TComponent): Boolean;
    property Control: TControl read FControl write SetControl;
    property Visible: Boolean read FVisible write SetVisible;
    property Designer: TCustomDesignerComponent read GetDesigner;
  end;

  {$IFDEF VER100}
  {$DEFINE DESIGNERASCLASS}
  {$ENDIF}
  {$IFDEF VER110}
  {$DEFINE DESIGNERASCLASS}
  {$ENDIF}
  {$IFDEF VER150}
  {$DEFINE DESIGNERHOOK}
  {$ENDIF}

  {$IFNDEF VER150}
  {$DEFINE NOCSSUBCOMPONENT}
  {$ENDIF}

  {$IFDEF VER100}
  {$DEFINE NOFRAMES}
  {$ENDIF}
  {$IFDEF VER110}
  {$DEFINE NOFRAMES}
  {$ENDIF}
  {$IFDEF VER120}
  {$DEFINE NOFRAMES}
  {$DEFINE NODESIGNERHOOK}
  {$ENDIF}
  {$IFDEF VER125}
  {$DEFINE NOFRAMES}
  {$DEFINE NODESIGNERHOOK}
  {$ENDIF}
  {$IFDEF VER130}
  {$DEFINE NODESIGNERHOOK}
  {$ENDIF}

  {$IFDEF DESIGNERASCLASS}
  TDesignerInterface = class(TDesigner)
  {$ELSE}
  {$IFDEF NODESIGNERHOOK}
  TDesignerInterface = class(TInterfacedObject,IDesigner)
  {$ELSE}
  TDesignerInterface = class(TInterfacedObject,IDesignerHook)
  {$ENDIF}
  {$ENDIF}
  private
    { Private declarations }
    FDesignerComponent: TCustomDesignerComponent;
    {$IFNDEF DESIGNERASCLASS}
    function GetCustomForm: TCustomForm;
    procedure SetCustomForm(Value: TCustomForm);
    function GetIsControl: Boolean;
    procedure SetIsControl(Value: Boolean);
    {$ENDIF}
    function IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean; {$IFDEF DESIGNERASCLASS} override; {$ENDIF}
    procedure PaintGrid; {$IFDEF DESIGNERASCLASS} override; {$ENDIF}
    procedure ValidateRename(AComponent: TComponent; const CurName, NewName: string); {$IFDEF DESIGNERASCLASS} override; {$ENDIF}
    {$IFDEF DESIGNERASCLASS}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$ELSE}
    procedure Notification(AnObject: TPersistent; Operation: TOperation);
    {$ENDIF}
    procedure Modified; {$IFDEF DESIGNERASCLASS} override; {$ENDIF}
    {$IFNDEF DESIGNERASCLASS}
    function UniqueName(const BaseName: string): string;
    function GetRoot: TComponent;
    property Form: TCustomForm read GetCustomForm write SetCustomForm;
    {$ENDIF}
  public
    { Public declarations }
    constructor Create(ADesignerComponent: TCustomDesignerComponent);
  end;

  TMouseAction = (maNone,maDragging,maSelecting);
  THintMode = (hmMove,hmSize);
  TComponentAttribute = (caInvalid,caEditable,caLocked,caTransparent,caProtected,caDefaultCursor,caDefaultMenu);
  TComponentAttributes = set of TComponentAttribute;
  TDFMFormat = (dfmBinary,dfmText);
  TAlignMode = (amNoChange,amLeftTop,amCenters,amRightBottom,amSpace,amWindowCenter);
  TSizeMode = (smNoChange,smToSmallest,smToLargest,smValue);
  TAlignmentPaletteOption = (apAutoShow,apStayOnTop,apShowHints,apFlatButtons);
  TAlignmentPaletteOptions = set of TAlignmentPaletteOption;

  TMessageEvent = procedure(Sender: TObject; AControl: TControl; var Message: TMessage; var Processed: Boolean) of object;
  TComponentAttributesEvent = procedure(Sender: TObject; AComponent: TComponent; var Attributes: TComponentAttributes) of object;
  TComponentEvent = procedure(Sender: TObject; AComponent: TComponent) of object;
  TComponentAllowEvent = procedure(Sender: TObject; AComponent: TComponent; var Allow: Boolean) of object;
  TChangeNameEvent = procedure(Sender: TObject; AComponent: TComponent; var AName: string) of object;
  TChangeOwnerEvent = procedure(Sender: TObject; AComponent,OldOwner: TComponent; var AOwner: TComponent) of object;
  TAlignmentPaletteEvent = procedure(Sender: TObject; Form: TForm) of object;

  TComponentContainer = class(TCustomControl)
  private
    FComponent: TComponent;
    FBitmap: TBitmap;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor CreateWithComponent(AOwner,AComponent: TComponent);
    destructor Destroy; override;
    property Component: TComponent read FComponent write FComponent;
  end;

  TCustomDesignerComponent = class(TComponent)
  private
    { Private declarations }
    FDesignTime: Boolean;
    FInternalDestroy: Boolean;
    FAPForm: TForm;
    FHintWindow: THintWindow;
    FActiveHandle: TGrabPosition;
    FMouseAction: TMouseAction;
    FDragRect: TRect;
    FDragPoint: TPoint;
    FSelectRect: TRect;
    FSelected: TList;
    FSelect: TWinControl;
    FActive: Boolean;
    FShowNonVisual: Boolean;
    FShowMoveSizeHint: Boolean;
    FAlignmentPalette: TAlignmentPaletteOptions;
    FGridStep: Integer;
    FSnapToGrid: Boolean;
    FDisplayGrid: Boolean;
    FGridColor: TColor;
    FDesignerColor: TColor;
    FGrabSize: Integer;
    FGrabHandles: TGrabHandles;
    FNormalGrabBorder: TColor;
    FNormalGrabFill: TColor;
    FLockedGrabBorder: TColor;
    FLockedGrabFill: TColor;
    FMultiGrabBorder: TColor;
    FMultiGrabFill: TColor;
    FPopupMenu: TPopupMenu;
    FOnBeforeMessage: TMessageEvent;
    FOnAfterMessage: TMessageEvent;
    FOnComponentAttributes: TComponentAttributesEvent;
    FOnDblClick: TComponentEvent;
    FOnBeforeSelect: TComponentAllowEvent;
    FOnAfterSelect: TComponentEvent;
    FOnBeforeDeselect: TComponentAllowEvent;
    FOnAfterDeselect: TComponentEvent;
    FOnBeforeDrag: TComponentAllowEvent;
    FOnAfterDrag: TComponentEvent;
    FOnChangeName: TChangeNameEvent;
    FOnChangeOwner: TChangeOwnerEvent;
    FOnShowAlignmentPalette: TAlignmentPaletteEvent;
    FOnHideAlignmentPalette: TAlignmentPaletteEvent;
    function GetControl: TControl;
    procedure SetControl(const Value: TControl);
    function GetSelectedControlCount: Integer;
    function GetSelectedControl(Index: Integer): TControl;
    function GetComponent: TComponent;
    procedure SetComponent(const Value: TComponent);
    function GetSelectedCount: Integer;
    function GetSelected(Index: Integer): TComponent;
    function GetParentForm: TCustomForm;
    procedure SetActive(const Value: Boolean);
    procedure SetShowNonVisual(const Value: Boolean);
    procedure SetAlignmentPalette(Value: TAlignmentPaletteOptions);
    procedure SetDisplayGrid(const Value: Boolean);
    procedure SetGridStep(const Value: Integer);
    procedure SetGridColor(const Value: TColor);
    procedure SetDesignerColor(const Value: TColor);
    procedure SetGrabSize(const Value: Integer);
    procedure SetNormalGrabBorder(const Value: TColor);
    procedure SetNormalGrabFill(const Value: TColor);
    procedure SetLockedGrabBorder(const Value: TColor);
    procedure SetLockedGrabFill(const Value: TColor);
    procedure SetMultiGrabBorder(const Value: TColor);
    procedure SetMultiGrabFill(const Value: TColor);
    function FindHandle(AComponent: TComponent): TGrabPosition;
    function IsGrabHandle(AComponent: TComponent): Boolean;
    procedure HideGrabs;
    procedure ShowGrabs;
    procedure ShowHint(AHint: string; Mode: THintMode);
    procedure HideHint;
    procedure DrawDragRects;
    procedure DrawSelectRect;
    procedure DrawMultiSelect(AControl: TControl);
    procedure RemoveMultiSelect(AControl: TControl);
    procedure CheckParent(MainControl: TControl);
    procedure ProcessProtected(ARoot: TComponent);
    function IsPressed(Key: Word): Boolean;
    procedure CreateContainers;
    procedure DestroyContainers;
    function SelectControl(AControl: TControl): Boolean;
    function DeselectControl(AControl: TControl): Boolean;
    procedure DeselectAllControls;
    function IsSelectedControl(AControl: TControl): Boolean;
    function IsSelectableControl(AControl: TControl): Boolean;
    function ComponentToControl(AComponent: TComponent): TControl;
    function ControlToComponent(AComponent: TComponent): TComponent;
    procedure ClearForm;
    property Control: TControl read GetControl write SetControl;
    property SelectedControlCount: Integer read GetSelectedControlCount;
    property SelectedControls[Index: Integer]: TControl read GetSelectedControl;
  protected
    procedure PaintGrid(Canvas: TCanvas; R: TRect); virtual;
    procedure PaintGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType; GrabPosition: TGrabPosition); virtual;
    function MessageProcessor(Sender: TControl; var Message: TMessage): Boolean; virtual;
    procedure NotificationProcessor(AComponent: TComponent; Operation: TOperation); virtual;
    function NameProcessor(AComponent,AOwner: TComponent; AName: string): string;
    function ComponentAttributes(AComponent: TComponent): TComponentAttributes; virtual;
    procedure DoDblClick(AControl: TControl); virtual;
    procedure DoBeforeSelect(AControl: TControl; var Allow: Boolean); virtual;
    procedure DoAfterSelect(AControl: TControl); virtual;
    procedure DoBeforeDeselect(AControl: TControl; var Allow: Boolean); virtual;
    procedure DoAfterDeselect(AControl: TControl); virtual;
    procedure DoBeforeDrag(AControl: TControl; var Allow: Boolean); virtual;
    procedure DoAfterDrag(AControl: TControl); virtual;
    procedure DoChangeName(AComponent: TComponent; var AName: string); virtual;
    procedure DoChangeOwner(AComponent,OldOwner: TComponent; var AOwner: TComponent); virtual;
    procedure DoShowAlignmentPalette(Form: TForm); virtual;
    procedure DoHideAlignmentPalette(Form: TForm); virtual;
    property ShowNonVisual: Boolean read FShowNonVisual write SetShowNonVisual default True;
    property ShowMoveSizeHint: Boolean read FShowMoveSizeHint write FShowMoveSizeHint default True;
    property GridStep: Integer read FGridStep write SetGridStep default 8;
    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid default True;
    property DisplayGrid: Boolean read FDisplayGrid write SetDisplayGrid default True;
    property GridColor: TColor read FGridColor write SetGridColor default clBlack;
    property DesignerColor: TColor read FDesignerColor write SetDesignerColor default clBtnFace;
    property GrabSize: Integer read FGrabSize write SetGrabSize default 5;
    property NormalGrabBorder: TColor read FNormalGrabBorder write SetNormalGrabBorder default clBlack;
    property NormalGrabFill: TColor read FNormalGrabFill write SetNormalGrabFill default clBlack;
    property LockedGrabBorder: TColor read FLockedGrabBorder write SetLockedGrabBorder default clBlack;
    property LockedGrabFill: TColor read FLockedGrabFill write SetLockedGrabFill default clGray;
    property MultiGrabBorder: TColor read FMultiGrabBorder write SetMultiGrabBorder default clGray;
    property MultiGrabFill: TColor read FMultiGrabFill write SetMultiGrabFill default clGray;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property OnBeforeMessage: TMessageEvent read FOnBeforeMessage write FOnBeforeMessage;
    property OnAfterMessage: TMessageEvent read FOnAfterMessage write FOnAfterMessage;
    property OnDblClick: TComponentEvent read FOnDblClick write FOnDblClick;
    property OnComponentAttributes: TComponentAttributesEvent read FOnComponentAttributes write FOnComponentAttributes;
    property OnBeforeSelect: TComponentAllowEvent read FOnBeforeSelect write FOnBeforeSelect;
    property OnAfterSelect: TComponentEvent read FOnAfterSelect write FOnAfterSelect;
    property OnBeforeDeselect: TComponentAllowEvent read FOnBeforeDeselect write FOnBeforeDeselect;
    property OnAfterDeselect: TComponentEvent read FOnAfterDeselect write FOnAfterDeselect;
    property OnBeforeDrag: TComponentAllowEvent read FOnBeforeDrag write FOnBeforeDrag;
    property OnAfterDrag: TComponentEvent read FOnAfterDrag write FOnAfterDrag;
    property OnChangeName: TChangeNameEvent read FOnChangeName write FOnChangeName;
    property OnChangeOwner: TChangeOwnerEvent read FOnChangeOwner write FOnChangeOwner;
    property OnShowAlignmentPalette: TAlignmentPaletteEvent read FOnShowAlignmentPalette write FOnShowAlignmentPalette;
    property OnHideAlignmentPalette: TAlignmentPaletteEvent read FOnHideAlignmentPalette write FOnHideAlignmentPalette;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; virtual;
    procedure LeaveMouseAction;
    function FindComponentContainer(AComponent: TComponent): TComponentContainer;
    function Select(AComponent: TComponent): Boolean;
    function Deselect(AComponent: TComponent): Boolean;
    procedure DeselectAll;
    function IsSelected(AComponent: TComponent): Boolean;
    function IsSelectable(AComponent: TComponent): Boolean;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure Delete;
    procedure SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
    procedure LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
    procedure SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
    procedure LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
    procedure AlignToGrid;
    procedure AlignControls(Hor,Ver: TAlignMode);
    procedure SizeControls(WMode: TSizeMode; WValue: Integer; HMode: TSizeMode; HValue: Integer);
    procedure AlignDialog;
    procedure SizeDialog;
    procedure ShowAlignmentPalette;
    procedure HideAlignmentPalette;
    procedure TabOrderDialog;
    procedure CreationOrderDialog;
    property Active: Boolean read FActive write SetActive default False;
    property AlignmentPalette: TAlignmentPaletteOptions read FAlignmentPalette write SetAlignmentPalette;
    property ParentForm: TCustomForm read GetParentForm;
    property Component: TComponent read GetComponent write SetComponent;
    property SelectedCount: Integer read GetSelectedCount;
    property Selected[Index: Integer]: TComponent read GetSelected;
  end;

  TDesignerComponent = class(TCustomDesignerComponent)
  published
    { Published declarations }
    property AlignmentPalette;
    property ShowNonVisual;
    property ShowMoveSizeHint;
    property GridStep;
    property SnapToGrid;
    property DisplayGrid;
    property GridColor;
    property DesignerColor;
    property GrabSize;
    property NormalGrabBorder;
    property NormalGrabFill;
    property LockedGrabBorder;
    property LockedGrabFill;
    property MultiGrabBorder;
    property MultiGrabFill;
    property PopupMenu;
    property OnBeforeMessage;
    property OnAfterMessage;
    property OnDblClick;
    property OnComponentAttributes;
    property OnBeforeSelect;
    property OnAfterSelect;
    property OnBeforeDeselect;
    property OnAfterDeselect;
    property OnBeforeDrag;
    property OnAfterDrag;
    property OnChangeName;
    property OnChangeOwner;
    property OnShowAlignmentPalette;
    property OnHideAlignmentPalette;
  end;

implementation

uses DCAlign, DCSize, DCAlPal, DCTab, DCCreate;

const
  WM_DRAWMULTISELECT = WM_USER+WM_PAINT;

function GetGrabCursor(GP: TGrabPosition): TCursor;
begin
  case GP of
    gpLeftTop,gpRightBottom: Result:=crSizeNWSE;
    gpLeftMiddle,gpRightMiddle: Result:=crSizeWE;
    gpLeftBottom,gpRightTop: Result:=crSizeNESW;
    gpMiddleTop,gpMiddleBottom: Result:=crSizeNS;
  else Result:=crArrow;
  end;
end;

{ TDesignerReader }

type
  TDesignerReader = class(TReader)
  protected
    function Error(const Message: string): Boolean; override;
  end;

function TDesignerReader.Error(const Message: string): Boolean;
begin
  Result:=True;
end;

{ TGrabHandle }

constructor TGrabHandle.Create(AOwner: TComponent);
begin
  inherited;
  with (Owner as TGrabHandles).Designer do
  begin
    Width:=FGrabSize;
    Height:=FGrabSize;
    Parent:=ParentForm;
  end;
  ControlStyle:=ControlStyle+[csReplicatable];
end;

procedure TGrabHandle.Paint;
var
  GrabType: TGrabType;
begin
  if Assigned(Parent) then
    with TGrabHandles(Owner).Designer do
    begin
      if Locked then GrabType:=gtLocked
      else GrabType:=gtNormal;
      PaintGrab(Canvas,ClientRect,GrabType,Position);
    end;
end;

procedure TGrabHandle.SetPosition(const Value: TGrabPosition);
begin
  if Value<>FPosition then
  begin
    FPosition:=Value;
    Cursor:=GetGrabCursor(FPosition);
    UpdateCoords;
  end;
end;

procedure TGrabHandle.SetRect(const Value: TRect);
begin
  if not EqualRect(FRect,Value) then
  begin
    FRect:=Value;
    UpdateCoords;
  end;
end;

procedure TGrabHandle.SetLocked(const Value: Boolean);
begin
  if Value<>FLocked then
  begin
    FLocked:=Value;
    if Visible then Invalidate;
  end;
end;

procedure TGrabHandle.UpdateCoords;
var
  ALeft,ATop: Integer;
begin
  if Assigned(Parent) then
    with (Owner as TGrabHandles).Designer do
    begin
      case FPosition of
        gpLeftTop,gpLeftMiddle,gpLeftBottom: ALeft:=FRect.Left-FGrabSize div 2;
        gpMiddleTop,gpMiddleBottom: ALeft:=(FRect.Left+FRect.Right-FGrabSize) div 2;
        gpRightTop,gpRightMiddle,gpRightBottom: ALeft:=Pred(FRect.Right-FGrabSize div 2);
      else ALeft:=0;
      end;
      case FPosition of
        gpLeftTop,gpMiddleTop,gpRightTop: ATop:=FRect.Top-FGrabSize div 2;
        gpLeftMiddle,gpRightMiddle: ATop:=(FRect.Top+FRect.Bottom-FGrabSize) div 2;
        gpLeftBottom,gpMiddleBottom,gpRightBottom: ATop:=Pred(FRect.Bottom-FGrabSize div 2);
      else ATop:=0;
      end;
      BoundsRect:=Classes.Rect(ALeft,ATop,ALeft+FGrabSize,ATop+FGrabSize);
    end;
end;

{ TGrabHandles }

procedure TGrabHandles.SetControl(const Value: TControl);
begin
  FControl:=Value;
  Update;
end;

procedure TGrabHandles.SetVisible(const Value: Boolean);
var
  GP: TGrabPosition;
begin
  if Value<>FVisible then
  begin
    FVisible:=Value;
    for GP:=Succ(Low(GP)) to High(GP) do
      with FItems[GP] do
      begin
        Visible:=FVisible;
        if Assigned(Parent) then
          if FVisible then ShowWindow(Handle,SW_SHOW)
          else ShowWindow(Handle,SW_HIDE);
      end;
  end;
end;

function TGrabHandles.GetDesigner: TCustomDesignerComponent;
begin
  if Assigned(Owner) then Result:=Owner as TCustomDesignerComponent
  else Result:=nil;
end;

constructor TGrabHandles.Create(AOwner: TComponent);
var
  GP: TGrabPosition;
begin
  inherited;
  for GP:=Succ(Low(GP)) to High(GP) do
  begin
    FItems[GP]:=TGrabHandle.Create(Self);
    with FItems[GP] do
    begin
      Position:=GP;
      Visible:=False;
    end;
  end;
end;

procedure TGrabHandles.Update;
var
  GP: TGrabPosition;
begin
  if Designer.Active then
  begin
    for GP:=Succ(Low(GP)) to High(GP) do
      if Assigned(FItems[GP]) then
        with FItems[GP] do
          if Assigned(FControl) then
          begin
            Rect:=FControl.BoundsRect;
            Parent:=FControl.Parent;
            Locked:=caLocked in Designer.ComponentAttributes(FControl);
            if FVisible then ShowWindow(Handle,SW_SHOW)
            else ShowWindow(Handle,SW_HIDE);
            if Visible then BringToFront;
          end
          else
          try
            ShowWindow(Handle,SW_HIDE);
          except
          end;
  end;
end;

procedure TGrabHandles.UpdateCoords;
var
  GP: TGrabPosition;
begin
  if Assigned(FControl) then
    for GP:=Succ(Low(GP)) to High(GP) do
      FItems[GP].Rect:=FControl.BoundsRect;
end;

procedure TGrabHandles.BringToFront;
var
  GP: TGrabPosition;
begin
  for GP:=Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) then FItems[GP].BringToFront;
end;

function TGrabHandles.FindHandle(AComponent: TComponent): TGrabPosition;
var
  GP: TGrabPosition;
begin
  Result:=gpNone;
  for GP:=Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) and (FItems[GP]=AComponent) then
    begin
      Result:=GP;
      Break;
    end;
end;

function TGrabHandles.IsGrabHandle(AComponent: TComponent): Boolean;
begin
  Result:=FindHandle(AComponent)<>gpNone;
end;

{TCustomDesignerInterface}

procedure TDesignerInterface.ValidateRename(AComponent: TComponent; const CurName, NewName: string);
begin
end;

procedure TDesignerInterface.PaintGrid;
begin
  if Assigned(FDesignerComponent) and Assigned(FDesignerComponent.ParentForm) then
    with FDesignerComponent,ParentForm do
      PaintGrid(Canvas,ClientRect);
end;

function TDesignerInterface.IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
begin
  if Assigned(FDesignerComponent) and
    not (csDestroying in FDesignerComponent.ComponentState) and
    not (csLoading in FDesignerComponent.ComponentState) and
    (FDesignerComponent.ParentForm.Showing) then
    Result:=FDesignerComponent.MessageProcessor(Sender,Message)
  else Result:=False;
end;

{$IFDEF DESIGNERASCLASS}

procedure TDesignerInterface.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Assigned(FDesignerComponent) and not (csDestroying in FDesignerComponent.ComponentState) then
    FDesignerComponent.NotificationProcessor(AComponent,Operation);
end;

{$ELSE}

function TDesignerInterface.GetCustomForm: TCustomForm;
begin
  if Assigned(FDesignerComponent) and not (csDestroying in FDesignerComponent.ComponentState) then
    Result:=FDesignerComponent.ParentForm
  else Result:=nil;
end;

procedure TDesignerInterface.SetCustomForm(Value: TCustomForm);
begin
end;

function TDesignerInterface.GetIsControl: Boolean;
begin
  Result:=False;
end;

procedure TDesignerInterface.SetIsControl(Value: Boolean);
begin
end;

procedure TDesignerInterface.Notification(AnObject: TPersistent; Operation: TOperation);
begin
  if (AnObject is TComponent) and (AnObject=FDesignerComponent) then FDesignerComponent:=nil
  else
    if Assigned(FDesignerComponent) and not (csDestroying in FDesignerComponent.ComponentState) and (AnObject is TComponent) then
      FDesignerComponent.NotificationProcessor(TComponent(AnObject),Operation);
end;

function TDesignerInterface.GetRoot: TComponent;
begin
  Result:=Form;
end;

function TDesignerInterface.UniqueName(const BaseName: string): string;
begin
  Result:=BaseName;
end;

{$ENDIF}

procedure TDesignerInterface.Modified;
begin
end;

constructor TDesignerInterface.Create(ADesignerComponent: TCustomDesignerComponent);
begin
  inherited Create;
  FDesignerComponent:=ADesignerComponent;
end;

{ TComponentContainer }

procedure TComponentContainer.Paint;
begin
  with Canvas do
  begin
    Brush.Color:=clBtnFace;
    FillRect(ClientRect);
    Pen.Color:=clBtnHighlight;
    MoveTo(0,Pred(Height));
    LineTo(0,0);
    LineTo(Width,0);
    Pen.Color:=clBtnShadow;
    MoveTo(0,Pred(Height));
    LineTo(Pred(Width),Pred(Height));
    LineTo(Pred(Width),0);
    with FBitmap do
    begin
      Handle:=LoadBitmap(HInstance,PChar(string(Component.ClassName)));
      if Handle=0 then Handle:=LoadBitmap(HInstance,'TCOMPONENT');
    end;
    Draw(2,2,FBitmap);
  end;
end;

procedure TComponentContainer.WndProc(var Msg: TMessage);
begin
  with Msg do
    case Msg of
      WM_SIZE:
      begin
        Width:=28;
        Height:=28;
      end;
      WM_MOVE:
      begin
        inherited;
        if Assigned(FComponent) then
          FComponent.DesignInfo:=Left+Top shl 16;
      end;
    else inherited;
    end;
end;

constructor TComponentContainer.CreateWithComponent(AOwner,AComponent: TComponent);
begin
  inherited Create(AOwner);
  FBitmap:=TBitmap.Create;
  with FBitmap do
  begin
    Handle:=LoadBitmap(HInstance,'CONTAINER');
    Transparent:=True;
  end;
  FComponent:=AComponent;
  Visible:=Assigned(FComponent);
  Width:=28;
  Height:=28;
  ShowHint:=True;
  with FComponent do
  begin
    Left:=LoWord(DesignInfo);
    Top:=HiWord(DesignInfo);
    Hint:=Name;
  end;
end;

destructor TComponentContainer.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

{ TCustomDesignerComponent }

function TCustomDesignerComponent.GetControl: TControl;
begin
  if SelectedControlCount>0 then Result:=SelectedControls[0]
  else Result:=nil;
end;

procedure TCustomDesignerComponent.SetControl(const Value: TControl);
var
  i: Integer;
begin
  with FSelected do
  begin
    i:=0;
    while i<Count do
      if not DeselectControl(Items[0]) then Inc(i);
    if Assigned(Value) then SelectControl(Value);
  end;
end;

function TCustomDesignerComponent.GetSelectedControlCount: Integer;
begin
  Result:=FSelected.Count;
end;

function TCustomDesignerComponent.GetSelectedControl(Index: Integer): TControl;
begin
  with FSelected do
    if (Index>=0) and (Index<Count) then Result:=FSelected[Index]
    else Result:=nil;
end;

function TCustomDesignerComponent.GetComponent: TComponent;
begin
  Result:=Control;
  if Assigned(Result) and (Result is TComponentContainer) then
    Result:=TComponentContainer(Result).Component;
end;

procedure TCustomDesignerComponent.SetComponent(const Value: TComponent);
begin
  Control:=ComponentToControl(Value);
end;

function TCustomDesignerComponent.GetSelectedCount: Integer;
begin
  Result:=SelectedControlCount;
end;

function TCustomDesignerComponent.GetSelected(Index: Integer): TComponent;
begin
  Result:=SelectedControls[Index];
  if Assigned(Result) and (Result is TComponentContainer) then
    Result:=TComponentContainer(Result).Component;
end;

function TCustomDesignerComponent.GetParentForm: TCustomForm;
var
  IOwner: TComponent;
begin
  IOwner:=Owner;
  while Assigned(IOwner) and not (IOwner is TCustomForm) do IOwner:=IOwner.Owner;
  Result:=TCustomForm(IOwner);
end;

type
  TDesignAccessComponent = class(TComponent)
  public
    procedure SetDesigningPublic(const Value: Boolean);
  end;

procedure TDesignAccessComponent.SetDesigningPublic(const Value: Boolean);
begin
  SetDesigning(Value);
end;

procedure TCustomDesignerComponent.SetActive(const Value: Boolean);
var
  i: Integer;
begin
  if FDesignTime then FActive:=Value
  else
    if Value<>FActive then
    begin
      FActive:=Value;
      if Assigned(ParentForm) then
      begin
        if FActive then
        begin
          FGrabHandles:=TGrabHandles.Create(Self);
          Update;
        end
        else
        begin
          FGrabHandles.Free;
          FGrabHandles:=nil;
        end;
        with ParentForm do
        begin
          if FActive then
          begin
            DisableAutoRange;
            if caEditable in ComponentAttributes(ActiveControl) then ActiveControl:=nil;
            for i:=0 to Pred(ComponentCount) do
              if Components[i] is TWinControl then
                with TWinControl(Components[i]) do
                begin
                  EnableWindow(Handle,True);
                  ShowWindow(Handle,SW_SHOW);
                end;
            CreateContainers;
            if apAutoShow in FAlignmentPalette then ShowAlignmentPalette;
            Designer:=TDesignerInterface.Create(Self);
          end
          else
          begin
            HideAlignmentPalette;
            for i:=0 to Pred(SelectedControlCount) do RemoveMultiSelect(SelectedControls[i]);
            FSelected.Clear;
            {$IFDEF DESIGNERASCLASS}
            Designer.Free;
            {$ENDIF}
            Designer:=nil;
            for i:=0 to Pred(ComponentCount) do
              if Components[i] is TWinControl then
                with TWinControl(Components[i]) do
                begin
                  EnableWindow(Handle,Enabled);
                  if not Visible then ShowWindow(Handle,SW_HIDE);
                end;
            DestroyContainers;
            EnableAutoRange;
            Screen.Cursor:=crDefault;
          end;
          ProcessProtected(ParentForm);
          RedrawWindow(Handle,nil,0,RDW_INVALIDATE or RDW_ERASE or RDW_ALLCHILDREN);
        end;
      end;
    end;
end;

procedure TCustomDesignerComponent.SetShowNonVisual(const Value: Boolean);
begin
  if Value<>FShowNonVisual then
  begin
    FShowNonVisual:=Value;
    if FShowNonVisual then CreateContainers
    else DestroyContainers;
  end;
end;

procedure TCustomDesignerComponent.SetAlignmentPalette(Value: TAlignmentPaletteOptions);
begin
  FAlignmentPalette:=Value;
  if Assigned(FAPForm) then
    with TfrmAlignmentPalette(FAPForm) do
    begin
      if apStayOnTop in FAlignmentPalette then FormStyle:=fsStayOnTop
      else FormStyle:=fsNormal;
      ShowHint:=apShowHints in FAlignmentPalette;
      SetFlatButtons(apFlatButtons in FAlignmentPalette);
    end;
end;

procedure TCustomDesignerComponent.SetDisplayGrid(const Value: Boolean);
begin
  if Value<>FDisplayGrid then
  begin
    FDisplayGrid:=Value;
    if Assigned(ParentForm) then ParentForm.Invalidate;
  end;
end;

procedure TCustomDesignerComponent.SetGridStep(const Value: Integer);
var
  Val: Integer;
begin
  Val:=Value;
  if Val<2 then Val:=2;
  if Val>128 then Val:=128;
  if Val<>FGridStep then
  begin
    FGridStep:=Val;
    if Assigned(ParentForm) and FActive then ParentForm.Invalidate;
  end;
end;

procedure TCustomDesignerComponent.SetGridColor(const Value: TColor);
begin
  if Value<>FGridColor then
  begin
    FGridColor:=Value;
    if FGridColor=clNone then FGridColor:=clWindowText;
    if Assigned(ParentForm) and FActive then ParentForm.Invalidate;
  end;
end;

procedure TCustomDesignerComponent.SetDesignerColor(const Value: TColor);
begin
  if Value<>FDesignerColor then
  begin
    FDesignerColor:=Value;
    if FDesignerColor=clNone then FDesignerColor:=clWindow;
    if Assigned(ParentForm) and FActive then ParentForm.Invalidate;
  end;
end;

procedure TCustomDesignerComponent.SetGrabSize(const Value: Integer);
var
  Val: Integer;
begin
  Val:=Value;
  if Val<3 then Val:=3;
  if Val>32 then Val:=32;
  if Val<>FGrabSize then FGrabSize:=Val;
end;

procedure TCustomDesignerComponent.SetNormalGrabBorder(const Value: TColor);
begin
  if Value<>FNormalGrabBorder then FNormalGrabBorder:=Value;
end;

procedure TCustomDesignerComponent.SetNormalGrabFill(const Value: TColor);
begin
  if Value<>FNormalGrabFill then FNormalGrabFill:=Value;
end;

procedure TCustomDesignerComponent.SetLockedGrabBorder(const Value: TColor);
begin
  if Value<>FLockedGrabBorder then FLockedGrabBorder:=Value;
end;

procedure TCustomDesignerComponent.SetLockedGrabFill(const Value: TColor);
begin
  if Value<>FLockedGrabFill then FLockedGrabFill:=Value;
end;

procedure TCustomDesignerComponent.SetMultiGrabBorder(const Value: TColor);
begin
  if Value<>FMultiGrabBorder then FMultiGrabBorder:=Value;
end;

procedure TCustomDesignerComponent.SetMultiGrabFill(const Value: TColor);
begin
  if Value<>FMultiGrabFill then FMultiGrabFill:=Value;
end;

function TCustomDesignerComponent.FindHandle(AComponent: TComponent): TGrabPosition;
begin
  if Assigned(FGrabHandles) then Result:=FGrabHandles.FindHandle(AComponent)
  else Result:=gpNone;
end;

function TCustomDesignerComponent.IsGrabHandle(AComponent: TComponent): Boolean;
begin
  Result:=FindHandle(AComponent)<>gpNone;
end;

procedure TCustomDesignerComponent.HideGrabs;
begin
  if Assigned(FGrabHandles) then FGrabHandles.Visible:=False;
end;

procedure TCustomDesignerComponent.ShowGrabs;
begin
  if Assigned(FGrabHandles) then FGrabHandles.Visible:=SelectedControlCount=1;
end;

procedure TCustomDesignerComponent.ShowHint(AHint: string; Mode: THintMode);
var
  R: TRect;
  P: TPoint;
  Offset: Integer;
begin
  if FShowMoveSizeHint then
    with FHintWindow do
    begin
      R:=CalcHintRect(255,AHint,nil);
      GetCursorPos(P);
      if Mode=hmMove then Offset:=18
      else Offset:=8;
      OffsetRect(R,P.X,P.Y+Offset);
      ActivateHint(R,AHint);
    end;
end;

procedure TCustomDesignerComponent.HideHint;
begin
  FHintWindow.ReleaseHandle;
end;

procedure TCustomDesignerComponent.DrawDragRects;
var
  i: Integer;
  DR: TRect;
  Offset: TPoint;
  Canvas: TCanvas;
begin
  if Assigned(ParentForm) and Assigned(Control) then
  begin
    Canvas:=TCanvas.Create;
    try
      with Canvas do
      begin
        Handle:=GetDCEx(Control.Parent.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS or DCX_PARENTCLIP);
        try
          Offset.X:=FDragRect.Left-Control.Left;
          Offset.Y:=FDragRect.Top-Control.Top;
          with Control.Parent do
          begin
            DR:=ClientRect;
            if GetParent(ParentForm.Handle)<>0 then
              MapWindowPoints(0,GetParent(ParentForm.Handle),DR,2);
          end;
          with Pen do
          begin
            Style:=psSolid;
            Mode:=pmXor;
            Width:=2;
            Color:=clGray;
          end;
          Brush.Style:=bsClear;
          for i:=0 to Pred(SelectedControlCount) do
          begin
            if i=0 then DR:=FDragRect
            else
            begin
              DR:=SelectedControls[i].BoundsRect;
              OffsetRect(DR,Offset.X,Offset.Y);
            end;
            with DR do Rectangle(Left+1,Top+1,Right,Bottom);
          end;
        finally
          ReleaseDC(0,Handle);
          Handle:=0;
        end;
      end;
    finally
      Canvas.Free;
    end;
  end;
end;

procedure TCustomDesignerComponent.DrawSelectRect;
var
  SR: TRect;
  Canvas: TCanvas;
begin
  if Assigned(ParentForm) then
  begin
    Canvas:=TCanvas.Create;
    try
      with Canvas do
      begin
        Handle:=GetDCEx(ParentForm.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS);
        try
          with Pen do
          begin
            Style:=psSolid;
            Mode:=pmXor;
            Width:=1;
            Style:=psDot;
            Color:=clWhite;
          end;
          Brush.Style:=bsClear;
          SR:=FSelectRect;
          MapWindowPoints(0,ParentForm.Handle,SR,2);
          with SR do Rectangle(Left+1,Top+1,Right,Bottom);
        finally
          ReleaseDC(0,Handle);
          Handle:=0;
        end;
      end;
    finally
      Canvas.Free;
    end;
  end;
end;

procedure TCustomDesignerComponent.DrawMultiSelect(AControl: TControl);
var
  R: TRect;
  Canvas: TCanvas;
begin
  Canvas:=TCanvas.Create;
  with Canvas do
  try
    if AControl is TWinControl then Handle:=GetDC(TWinControl(AControl).Handle)
    else Handle:=GetDC(AControl.Parent.Handle);
    R:=AControl.ClientRect;
    if not (AControl is TWinControl) then
      with AControl do OffsetRect(R,Left,Top);
    with R do
    begin
      PaintGrab(Canvas,Rect(Left,Top,Left+FGrabSize,Top+FGrabSize),gtMulti,gpLeftTop);
      PaintGrab(Canvas,Rect(Left,Bottom-FGrabSize,Left+FGrabSize,Bottom),gtMulti,gpLeftBottom);
      PaintGrab(Canvas,Rect(Right-FGrabSize,Top,Right,Top+FGrabSize),gtMulti,gpRightTop);
      PaintGrab(Canvas,Rect(Right-FGrabSize,Bottom-FGrabSize,Right,Bottom),gtMulti,gpRightBottom);
    end;
  finally
    Handle:=0;
    Free;
  end
end;

procedure TCustomDesignerComponent.RemoveMultiSelect(AControl: TControl);
var
  R: TRect;
  Rgn,Rgn2: HRGN;
begin
  if Assigned(AControl) and Assigned(AControl.Parent) then
  begin
    R:=AControl.ClientRect;
    if not (AControl is TWinControl) then
      with AControl do OffsetRect(R,Left,Top);
    with R do
    begin
      Rgn:=CreateRectRgn(Left,Top,Left+FGrabSize,Top+FGrabSize);
      try
        Rgn2:=CreateRectRgn(Left,Top,Left+FGrabSize,Top+FGrabSize);
        try
          CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
        finally
          DeleteObject(Rgn2);
        end;
        Rgn2:=CreateRectRgn(Left,Bottom-FGrabSize,Left+FGrabSize,Bottom);
        try
          CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
        finally
          DeleteObject(Rgn2);
        end;
        Rgn2:=CreateRectRgn(Right-FGrabSize,Top,Right,Top+FGrabSize);
        try
          CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
        finally
          DeleteObject(Rgn2);
        end;
        Rgn2:=CreateRectRgn(Right-FGrabSize,Bottom-FGrabSize,Right,Bottom);
        try
          CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
        finally
          DeleteObject(Rgn2);
        end;
        if AControl is TWinControl then
          InvalidateRgn(TWinControl(AControl).Handle,Rgn,True)
        else
          InvalidateRgn(AControl.Parent.Handle,Rgn,True);
      finally
        DeleteObject(Rgn);
      end;
    end;
  end;
end;

procedure TCustomDesignerComponent.CheckParent(MainControl: TControl);
var
  i: Integer;
begin
  if Assigned(MainControl) then
  begin
    i:=0;
    while i<SelectedControlCount do
      if SelectedControls[i].Parent<>MainControl.Parent then
      begin
        if not DeselectControl(SelectedControls[i]) then Inc(i);
      end
      else Inc(i);
  end;
end;

procedure TCustomDesignerComponent.ProcessProtected(ARoot: TComponent);
var
  i: Integer;
begin
  if not (ARoot is TCustomDesignerComponent) then
    TDesignAccessComponent(ARoot).SetDesigningPublic(not (caProtected in ComponentAttributes(ARoot)) and FActive);
  if ARoot is TCustomForm then
    with TCustomForm(ARoot) do
      if FActive then DisableAutoRange
      else EnableAutoRange;
  with ARoot do
    for i:=0 to Pred(ComponentCount) do ProcessProtected(Components[i]);
end;

function TCustomDesignerComponent.IsPressed(Key: Word): Boolean;
begin
  Result:=GetKeyState(Key) and $80 <> 0;
end;

procedure TCustomDesignerComponent.CreateContainers;
var
  i: Integer;
begin
  if FShowNonVisual then
    with ParentForm do
      for i:=0 to Pred(ComponentCount) do
        if not (Components[i] is TControl) and
          not (Components[i] is TMenuItem) and
          not (Components[i] is TCustomDesignerComponent) and
          (caEditable in ComponentAttributes(Components[i])) and
          not Assigned(FindComponentContainer(Components[i])) then
          TComponentContainer.CreateWithComponent(ParentForm,Components[i]).Parent:=ParentForm;
end;

procedure TCustomDesignerComponent.DestroyContainers;
var
  i: Integer;
begin
  i:=0;
  FInternalDestroy:=True;
  try
    with ParentForm do
      while i<ComponentCount do
        if Components[i] is TComponentContainer then Components[i].Free
        else Inc(i);
  finally
    FInternalDestroy:=False;
  end;
end;

function TCustomDesignerComponent.SelectControl(AControl: TControl): Boolean;
var
  E: Boolean;
  I: Integer;
  OldControl: TControl;
  CA: TComponentAttributes;
begin
  Result:=False;
  if Assigned(AControl) then
  begin
    CA:=ComponentAttributes(AControl);
    if IsSelectableControl(AControl) then
    begin
      E:=True;
      DoBeforeSelect(AControl,E);
      if E then
      begin
        OldControl:=Control;
        with FSelected do
        begin
          I:=IndexOf(AControl);
          if I=-1 then
          begin
            Insert(0,AControl);
            Result:=True;
          end
          else Move(I,0);
        end;
        if Result then
        begin
          DoAfterSelect(AControl);
          if SelectedControlCount>1 then
          begin
            DrawMultiSelect(AControl);
            DrawMultiSelect(OldControl);
          end;
          Update;
        end;
      end;
    end;
  end;
end;

function TCustomDesignerComponent.DeselectControl(AControl: TControl): Boolean;
var
  E: Boolean;
  I: Integer;
begin
  Result:=False;
  if Assigned(AControl) then
  begin
    E:=True;
    DoBeforeDeselect(AControl,E);
    if E then
    begin
      with FSelected do
      begin
        I:=IndexOf(AControl);
        if I<>-1 then
        begin
          Delete(I);
          Result:=True;
        end;
      end;
      if Result then
      begin
        DoAfterDeselect(AControl);
        if SelectedControlCount>0 then RemoveMultiSelect(AControl);
        if SelectedControlCount=1 then RemoveMultiSelect(Control);
        Update;
      end;
    end;
  end;
end;

procedure TCustomDesignerComponent.DeselectAllControls;
begin
  Control:=nil;
end;

function TCustomDesignerComponent.IsSelectedControl(AControl: TControl): Boolean;
begin
  Result:=FSelected.IndexOf(AControl)<>-1;
end;

function TCustomDesignerComponent.IsSelectableControl(AControl: TControl): Boolean;
var
  CA: TComponentAttributes;
begin
  CA:=ComponentAttributes(AControl);
  Result:=
    (caEditable in CA) and
    {$IFNDEF NOCSSUBCOMPONENT}
    not (csSubComponent in AControl.ComponentStyle) and
    {$ENDIF}
    not (caTransparent in CA) and
    not (caProtected in CA);
end;

function TCustomDesignerComponent.ComponentToControl(AComponent: TComponent): TControl;
begin
  if Assigned(AComponent) then
    if AComponent is TControl then Result:=TControl(AComponent)
    else Result:=FindComponentContainer(AComponent)
  else Result:=nil;
end;

function TCustomDesignerComponent.ControlToComponent(AComponent: TComponent): TComponent;
begin
  if Assigned(AComponent) then
    if AComponent is TComponentContainer then Result:=TComponentContainer(AComponent).Component
    else Result:=AComponent
  else Result:=nil;
end;

procedure TCustomDesignerComponent.ClearForm;
var
  OldActive: Boolean;
  i: Integer;
begin
  OldActive:=Active;
  Active:=False;
  try
    if Assigned(ParentForm) then
    begin
      i:=0;
      with ParentForm do
        while i<ComponentCount do
          if Components[i]=Self then Inc(i)
          else Components[i].Free;
    end;
  finally
    Active:=OldActive;
  end;
end;

procedure TCustomDesignerComponent.PaintGrid(Canvas: TCanvas; R: TRect);
var
  X,Y,StartY: Integer;
begin
  with ParentForm do
  begin
    X:=R.Left-GetScrollPos(Handle,SB_HORZ) mod FGridStep;
    StartY:=R.Top-GetScrollPos(Handle,SB_VERT) mod FGridStep;
  end;
  with Canvas,R do
  begin
    Brush.Color:=FDesignerColor;
    FillRect(R);
    if FDisplayGrid then
      while X<=Right do
      begin
        Y:=StartY;
        while Y<=Bottom do
        begin
          SetPixel(Handle,X,Y,FGridColor);
          Inc(Y,FGridStep);
        end;
        Inc(X,FGridStep);
      end;
  end;
end;

procedure TCustomDesignerComponent.PaintGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType; GrabPosition: TGrabPosition);
begin
  with Canvas do
  begin
    case GrabType of
      gtLocked:
      begin
        Pen.Color:=LockedGrabBorder;
        Brush.Color:=LockedGrabFill;
      end;
      gtMulti:
      begin
        Pen.Color:=MultiGrabBorder;
        Brush.Color:=MultiGrabFill;
      end;
      else
        Pen.Color:=NormalGrabBorder;
        Brush.Color:=NormalGrabFill;
    end;
    with R do Rectangle(Left,Top,Right,Bottom);
  end;
end;

type
  TPopupControl = class(TControl)
  public
    property PopupMenu;
  end;

function TCustomDesignerComponent.MessageProcessor(Sender: TControl; var Message: TMessage): Boolean;

var
  i: Integer;
  E,MS: Boolean;
  ISender: TControl;
  R: TRect;
  NewDrag: TPoint;

  function GetControlsOrigin: TPoint;
  var
    i: Integer;
  begin
    case SelectedControlCount of
      0: Result:=Point(0,0);
      1: with Control do Result:=Point(Left,Top);
    else
      Result:=Point(MaxInt,MaxInt);
      for i:=0 to Pred(SelectedControlCount) do
        with SelectedControls[i],Result do
        begin
          if Left<X then X:=Left;
          if Top<Y then Y:=Top;
        end;
    end;
  end;

  function GetFormOwned(C: TControl): TControl;
  begin
    Result:=C;
    while Assigned(Result) and (FindHandle(C)=gpNone) and (Result<>ParentForm) and (Result.Owner<>ParentForm)
      and not (Result.Owner is TCustomForm)
      and not (Result is TCustomForm)
      {$IFNDEF NOFRAMES}
      and not (Result.Owner is TCustomFrame)
      {$ENDIF}
      do Result:=TControl(Result.Owner);
  end;

  function GetNonTransparent(C: TControl): TControl;
  begin
    Result:=C;
    while Assigned(Result) and
      Assigned(Result.Parent) and
      (caTransparent in ComponentAttributes(Result)) do
      Result:=Result.Parent;
    if not Assigned(Result) then Result:=ParentForm;
  end;

  function NormalizeRect(Rect: TRect): TRect;
  begin
    with Rect do
    begin
      if Left<Right then
      begin
        Result.Left:=Left;
        Result.Right:=Right;
      end
      else
      begin
        Result.Left:=Right;
        Result.Right:=Left;
      end;
      if Top<Bottom then
      begin
        Result.Top:=Top;
        Result.Bottom:=Bottom;
      end
      else
      begin
        Result.Top:=Bottom;
        Result.Bottom:=Top;
      end;
    end;
  end;

  function FindNextControl(GoForward: Boolean): TControl;
  var
    i,StartIndex: Integer;
    CurControl: TControl;
  begin
    Result:=nil;
    CurControl:=Control;
    if Assigned(ParentForm) then
      with ParentForm do
      begin
        if Assigned(CurControl) then
          if ComponentCount>0 then
          begin
            for StartIndex:=0 to Pred(ComponentCount) do
              if Components[StartIndex]=Control then Break
          end
          else StartIndex:=-1
        else StartIndex:=-1;
        if ComponentCount>0 then
        begin
          if StartIndex=-1 then
            if GoForward then StartIndex:=Pred(ComponentCount)
            else StartIndex:=0;
          i:=StartIndex;
          repeat
            if GoForward then
            begin
              Inc(i);
              if i=ComponentCount then i:=0;
            end
            else
            begin
              if i=0 then i:=ComponentCount;
              Dec(i);
            end;
            if Components[i] is TControl then
            begin
              CurControl:=TControl(Components[i]);
              if not (CurControl is TGrabHandle) and
                IsSelectableControl(CurControl) and
                (CurControl<>Control) then Result:=CurControl;
            end;
          until (Result<>nil) or (i=StartIndex);
        end;
      end;
  end;

  procedure ProcessKey(Key: Word);

  type
    TKeyType = (ktSelect,ktMove,ktFastMove,ktSize);

  var
    R: TRect;
    i: Integer;
    E,MS: Boolean;
    KeyType: TKeyType;

    procedure GrowRect(var R: TRect; X,Y: Integer);
    begin
      Inc(R.Right,X);
      Inc(R.Bottom,Y);
    end;

  begin
    if IsPressed(VK_SHIFT) then
      if IsPressed(VK_CONTROL) then KeyType:=ktFastMove
      else KeyType:=ktSize
    else
      if IsPressed(VK_CONTROL) then KeyType:=ktMove
      else KeyType:=ktSelect;
    if KeyType=ktMove then
    begin
      i:=0;
      MS:=SelectedControlCount>1;
      while i<SelectedControlCount do
      begin
        if MS then E:=not (caLocked in ComponentAttributes(SelectedControls[i]))
        else E:=True;
        if E then DoBeforeDrag(SelectedControls[i],E);
        if not E then
        begin
          if not DeselectControl(SelectedControls[i]) then Inc(i);
        end
        else Inc(i);
      end;
    end;
    for i:=0 to Pred(SelectedControlCount) do
      with SelectedControls[i] do
      begin
        R:=BoundsRect;
        case Key of
          VK_RIGHT:
            case KeyType of
              ktSelect: Control:=FindNextControl(True);
              ktMove: OffsetRect(R,1,0);
              ktFastMove: OffsetRect(R,FGridStep,0);
              ktSize: GrowRect(R,1,0);
            end;
          VK_LEFT:
            case KeyType of
              ktSelect: Control:=FindNextControl(False);
              ktMove: OffsetRect(R,-1,0);
              ktFastMove: OffsetRect(R,-FGridStep,0);
              ktSize: GrowRect(R,-1,0);
            end;
          VK_UP:
            case KeyType of
              ktSelect: Control:=FindNextControl(False);
              ktMove: OffsetRect(R,0,-1);
              ktFastMove: OffsetRect(R,0,-FGridStep);
              ktSize: GrowRect(R,0,-1);
            end;
          VK_DOWN:
            case KeyType of
              ktSelect: Control:=FindNextControl(True);
              ktMove: OffsetRect(R,0,1);
              ktFastMove: OffsetRect(R,0,FGridStep);
              ktSize: GrowRect(R,0,1);
            end;
        end;
        if (KeyType<>ktSelect) and Assigned(ParentForm) then
        begin
          if not EqualRect(BoundsRect,R) then
          begin
            BoundsRect:=R;
            DoAfterDrag(SelectedControls[i]);
          end;
        end
        else Break;
      end;
    Update;
  end;

  function SelectableParent(AControl: TControl): TControl;
  begin
    if Assigned(AControl) then
    begin
      Result:=AControl.Parent;
      while Assigned(Result) and
        (Result<>ParentForm) and
        not IsSelectableControl(Result) and
        not (caLocked in ComponentAttributes(Result)) do Result:=Result.Parent;
      if Result=ParentForm then Result:=nil;
    end
    else Result:=nil;
  end;

begin
  MessageProcessor:=False;
  ProcessProtected(ParentForm);
  E:=False;
  if Assigned(FOnBeforeMessage) then FOnBeforeMessage(Self,Sender,Message,E);
  if not E then
  begin
    with Message do
      case Msg of
        WM_ACTIVATE: LeaveMouseAction;
        WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC,WM_SIZE,WM_MOVE:
          if (SelectedControlCount=1) and (FMouseAction=maNone) then Update;
        WM_PAINT: PostMessage(ParentForm.Handle,WM_DRAWMULTISELECT,0,0);
        WM_DRAWMULTISELECT:
          if SelectedControlCount>1 then
            for i:=0 to Pred(SelectedControlCount) do DrawMultiSelect(SelectedControls[i]);
        WM_RBUTTONDOWN,WM_RBUTTONDBLCLK:
        begin
          ISender:=GetNonTransparent(GetFormOwned(Sender));
          if IsSelectable(ISender) then
            if Assigned(ISender) and (ISender<>ParentForm) then
            begin
              if IsSelectedControl(ISender) then SelectControl(ISender)
              else Control:=ISender;
              MessageProcessor:=True;
            end
            else DeselectAllControls;
          ShowGrabs;
        end;
        WM_RBUTTONUP:
        begin
          GetCursorPos(NewDrag);
          ISender:=GetNonTransparent(GetFormOwned(Sender));
          if Assigned(ISender) and (ISender<>ParentForm) then
            if not (caDefaultMenu in ComponentAttributes(ISender)) then
            begin
              if Assigned(FPopupMenu) then
                with NewDrag do FPopupMenu.Popup(X,Y);
              MessageProcessor:=True;
            end
            else
              if Assigned(ISender) then
                with TPopupControl(ISender),NewDrag do
                  if Assigned(PopupMenu) then
                    PopupMenu.Popup(X,Y);
        end;
        WM_LBUTTONDOWN:
        begin
          FActiveHandle:=FindHandle(Sender);
          ISender:=GetNonTransparent(GetFormOwned(Sender));
          if (ISender<>ParentForm) and not IsPressed(VK_CONTROL) then
          begin
            if (caEditable in ComponentAttributes(ISender)) or (FActiveHandle<>gpNone) then
            begin
              HideGrabs;
              if FActiveHandle=gpNone then
              begin
                if IsPressed(VK_SHIFT) then
                  if IsSelectedControl(ISender) and (SelectedControlCount>1) then DeselectControl(ISender)
                  else SelectControl(ISender)
                else
                begin
                  if (SelectedControlCount<2) or not IsSelectedControl(ISender) then Control:=ISender;
                  i:=0;
                  MS:=SelectedControlCount>1;
                  while i<SelectedControlCount do
                  begin
                    if MS then E:=not (caLocked in ComponentAttributes(SelectedControls[i]))
                    else E:=True;
                    if E then DoBeforeDrag(SelectedControls[i],E);
                    if not E then
                    begin
                      if not DeselectControl(SelectedControls[i]) then Inc(i);
                    end
                    else Inc(i);
                  end;
                end;
              end
              else
              begin
                E:=True;
                DoBeforeDrag(Control,E);
                if not E then DeselectControl(Control);
              end;
              if Assigned(Control) and not IsPressed(VK_SHIFT) then
              begin
                if (SelectedControlCount<>1) or not (caLocked in ComponentAttributes(Control)) then
                begin
                  if FActiveHandle=gpNone then CheckParent(ISender);
                  Application.ProcessMessages;
                  if Assigned(Control.Parent) then
                  begin
                    with Control.Parent,R do
                    begin
                      R:=ClientRect;
                      TopLeft:=ClientToScreen(TopLeft);
                      BottomRight:=ClientToScreen(BottomRight);
                    end;
                    ClipCursor(@R);
                  end;
                  GetCursorPos(FDragPoint);
                  FDragRect:=Control.BoundsRect;
                  DrawDragRects;
                  FMouseAction:=maDragging;
                end;
              end;
            end;
          end
          else
          begin
            DeselectAllControls;
            with FSelectRect do
            begin
              GetCursorPos(TopLeft);
              BottomRight:=TopLeft;
            end;
            if not (ISender is TWinControl) then ISender:=ISender.Parent;
            FSelect:=TWinControl(ISender);
            while Assigned(FSelect) and
              not (csAcceptsControls in FSelect.ControlStyle) do
              FSelect:=FSelect.Parent;
            if not Assigned(FSelect) then FSelect:=ParentForm;
            with FSelect,R do
            begin
              R:=ClientRect;
              TopLeft:=ClientToScreen(TopLeft);
              BottomRight:=ClientToScreen(BottomRight);
            end;
            ClipCursor(@R);
            DrawSelectRect;
            FMouseAction:=maSelecting;
          end;
          if not (ISender is TWinControl) then ISender:=ISender.Parent;
          SetCapture(TWinControl(ISender).Handle);
          MessageProcessor:=True;
        end;
        WM_LBUTTONDBLCLK:
        begin
          DoDblClick(Control);
          MessageProcessor:=True;
        end;
        WM_MOUSEMOVE:
        begin
          if not IsPressed(VK_LBUTTON) then LeaveMouseAction
          else
            case FMouseAction of
              maDragging:
              begin
                if Assigned(Control) then
                begin
                  GetCursorPos(NewDrag);
                  with NewDrag do
                  begin
                    X:=X-FDragPoint.X;
                    Y:=Y-FDragPoint.Y;
                    if (FActiveHandle=gpNone) and
                      FSnapToGrid and not IsPressed(VK_MENU) then
                    begin
                      X:=Round(X/FGridStep)*FGridStep;
                      Y:=Round(Y/FGridStep)*FGridStep;
                    end;
                  end;
                  if Assigned(Control) then R:=Control.BoundsRect;
                  with NewDrag do
                    case FActiveHandle of
                      gpNone: OffsetRect(R,X,Y);
                    else
                      with R do
                      begin
                        case FActiveHandle of
                          gpLeftTop:
                          begin
                            Left:=Left+X;
                            Top:=Top+Y;
                          end;
                          gpLeftMiddle: Left:=Left+X;
                          gpLeftBottom:
                          begin
                            Left:=Left+X;
                            Bottom:=Bottom+Y;
                          end;
                          gpMiddleTop: Top:=Top+Y;
                          gpMiddleBottom: Bottom:=Bottom+Y;
                          gpRightTop:
                          begin
                            Right:=Right+X;
                            Top:=Top+Y;
                          end;
                          gpRightMiddle: Right:=Right+X;
                          gpRightBottom:
                          begin
                            Right:=Right+X;
                            Bottom:=Bottom+Y;
                          end;
                        end;
                        if FSnapToGrid and not IsPressed(VK_MENU) then
                        begin
                          if FActiveHandle in [gpLeftTop,gpLeftMiddle,gpLeftBottom] then
                            Left:=Left div FGridStep * FGridStep;
                          if FActiveHandle in [gpLeftTop,gpMiddleTop,gpRightTop] then
                            Top:=Top div FGridStep * FGridStep;
                          if FActiveHandle in [gpRightTop,gpRightMiddle,gpRightBottom] then
                            Right:=Succ(Right div FGridStep * FGridStep);
                          if FActiveHandle in [gpLeftBottom,gpMiddleBottom,gpRightBottom] then
                            Bottom:=Succ(Bottom div FGridStep * FGridStep);
                        end;
                      end;
                    end;
                  if not EqualRect(R,FDragRect) then
                  begin
                    HideHint;
                    DrawDragRects;
                    FDragRect:=R;
                    DrawDragRects;
                    with FDragRect do
                      if FActiveHandle<>gpNone then Self.ShowHint(Format('%d x %d',[Abs(Right-Left),Abs(Bottom-Top)]),hmSize)
                      else
                      begin
                        NewDrag:=GetControlsOrigin;
                        with NewDrag do
                        begin
                          Inc(X,FDragRect.Left-Control.Left);
                          Inc(Y,FDragRect.Top-Control.Top);
                          Self.ShowHint(Format('%d, %d',[X,Y]),hmMove);
                        end;
                      end;
                  end;
                end;
              end;
            maSelecting:
            begin
              DrawSelectRect;
              GetCursorPos(FSelectRect.BottomRight);
              DrawSelectRect;
            end;
          end;
          MessageProcessor:=True;
        end;
        WM_LBUTTONUP:
        begin
          ReleaseCapture;
          ClipCursor(nil);
          HideHint;
          case FMouseAction of
            maDragging:
            begin
              DrawDragRects;
              if SelectedControlCount>1 then
              begin
                NewDrag.X:=FDragRect.Left-Control.Left;
                NewDrag.Y:=FDragRect.Top-Control.Top;
                for i:=0 to Pred(SelectedControlCount) do
                begin
                  R:=SelectedControls[i].BoundsRect;
                  OffsetRect(R,NewDrag.X,NewDrag.Y);
                  SelectedControls[i].BoundsRect:=R;
                  DoAfterDrag(SelectedControls[i]);
                end;
              end
              else
              begin
                FDragRect:=NormalizeRect(FDragRect);
                if Assigned(Control) then
                begin
                  if not EqualRect(FDragRect,Control.BoundsRect) then
                  begin
                    Control.BoundsRect:=FDragRect;
                    Update;
                    DoAfterDrag(Control);
                  end;
                  FDragRect:=Control.BoundsRect;
                end;
              end;
            end;
            maSelecting:
            begin
              DrawSelectRect;
              if Assigned(FSelect) then
              begin
                with FSelect do
                begin
                  FSelectRect:=NormalizeRect(FSelectRect);
                  with FSelectRect do
                  begin
                    TopLeft:=ScreenToClient(TopLeft);
                    BottomRight:=ScreenToClient(BottomRight);
                  end;
                  for i:=0 to Pred(ControlCount) do
                    if IsSelectableControl(Controls[i]) then
                    begin
                      IntersectRect(R,FSelectRect,Controls[i].BoundsRect);
                      if not IsRectEmpty(R) then SelectControl(Controls[i]);
                    end;
                end;
              end;
            end;
          end;
          ShowGrabs;
          Update;
          FMouseAction:=maNone;
          FActiveHandle:=gpNone;
          MessageProcessor:=True;
        end;
        WM_KEYDOWN:
        begin
          case wParam of
            VK_ESCAPE:
              if FMouseAction<>maNone then LeaveMouseAction
              else Control:=SelectableParent(Control);
            VK_TAB: Control:=FindNextControl(not IsPressed(VK_SHIFT));
            VK_RIGHT,VK_LEFT,VK_UP,VK_DOWN: ProcessKey(wParam);
            VK_INSERT:
              if IsPressed(VK_CONTROL) then CopyToClipboard
              else
                if IsPressed(VK_SHIFT) then PasteFromClipboard;
            VK_DELETE:
              if IsPressed(VK_SHIFT) then CutToClipboard
              else Delete;
            Ord('C'): if IsPressed(VK_CONTROL) then CopyToClipboard;
            Ord('X'): if IsPressed(VK_CONTROL) then CutToClipboard;
            Ord('V'): if IsPressed(VK_CONTROL) then PasteFromClipboard;
          end;
          MessageProcessor:=True;
        end;
        WM_SETCURSOR:
          if not IsPressed(VK_LBUTTON) then
            with Screen do
            begin
              if Sender=ParentForm then Cursor:=crDefault
              else
              begin
                if (caDefaultCursor in ComponentAttributes(Sender)) or (caProtected in ComponentAttributes(Sender)) then
                  SetCursor(Cursors[crArrow])
                else
                  if IsGrabHandle(Sender) and not (caLocked in ComponentAttributes(Control)) then
                    SetCursor(Cursors[Sender.Cursor])
                  else
                    if Cursor=crArrow then Cursor:=crDefault
                    else SetCursor(Cursors[crArrow]);
                MessageProcessor:=True;
              end;
            end
          else MessageProcessor:=True;
        $140..354:
        begin
          MessageProcessor:=True;
          Result:=1;
        end;
        WM_COMMAND: if LParam=0 then MessageProcessor:=True;
      end;
    if Assigned(FOnAfterMessage) then FOnAfterMessage(Self,Sender,Message,Result);
  end
  else MessageProcessor:=True;
end;

procedure TCustomDesignerComponent.NotificationProcessor(AComponent: TComponent; Operation: TOperation);
begin
  if not (csDestroying in ComponentState) and (Operation=opRemove) then
  begin
    Deselect(AComponent);
    if Assigned(FindComponentContainer(AComponent)) then
    begin
      with FindComponentContainer(AComponent) do
        if not (csDestroying in ComponentState) then Free;
    end
    else
      if (AComponent is TComponentContainer) and not FInternalDestroy then
        with TComponentContainer(AComponent).Component do
          if not (csDestroying in ComponentState) then Free;
  end;
end;

function TCustomDesignerComponent.NameProcessor(AComponent,AOwner: TComponent; AName: string): string;
var
  N: Integer;
begin
  if Assigned(AOwner) and Assigned(AComponent) then
    with AOwner do
    begin
      if Assigned(FindComponent(AName)) then
      begin
        N:=0;
        repeat
          Inc(N);
          AName:=Copy(AComponent.ClassName,2,255)+IntToStr(N);
        until not Assigned(FindComponent(AName));
      end;
      DoChangeName(AComponent,AName);
      Result:=AName;
    end;
end;

function TCustomDesignerComponent.ComponentAttributes(AComponent: TComponent): TComponentAttributes;
begin
  if Assigned(AComponent) then
  begin
    if Assigned(FGrabHandles) then
      if IsGrabHandle(AComponent) then Result:=[]
      else Result:=[caEditable];
    if Assigned(FOnComponentAttributes) then FOnComponentAttributes(Self,ControlToComponent(AComponent),Result);
  end
  else Result:=[caInvalid];
end;

procedure TCustomDesignerComponent.DoDblClick(AControl: TControl);
begin
  if Assigned(FOnDblClick) then FOnDblClick(Self,ControlToComponent(AControl));
end;

procedure TCustomDesignerComponent.DoBeforeSelect(AControl: TControl; var Allow: Boolean);
begin
  if Assigned(FOnBeforeSelect) then FOnBeforeSelect(Self,ControlToComponent(AControl),Allow);
end;

procedure TCustomDesignerComponent.DoAfterSelect(AControl: TControl);
begin
  if Assigned(FOnAfterSelect) then FOnAfterSelect(Self,ControlToComponent(AControl));
end;

procedure TCustomDesignerComponent.DoBeforeDeselect(AControl: TControl; var Allow: Boolean);
begin
  if Assigned(FOnBeforeSelect) then FOnBeforeSelect(Self,ControlToComponent(AControl),Allow);
end;

procedure TCustomDesignerComponent.DoAfterDeselect(AControl: TControl);
begin
  if Assigned(FOnAfterDeselect) then FOnAfterDeselect(Self,ControlToComponent(AControl));
end;

procedure TCustomDesignerComponent.DoBeforeDrag(AControl: TControl; var Allow: Boolean);
begin
  if Assigned(FOnBeforeDrag) then FOnBeforeDrag(Self,ControlToComponent(AControl),Allow);
end;

procedure TCustomDesignerComponent.DoAfterDrag(AControl: TControl);
begin
  if Assigned(FOnAfterDrag) then FOnAfterDrag(Self,ControlToComponent(AControl));
end;

procedure TCustomDesignerComponent.DoChangeName(AComponent: TComponent; var AName: string);
begin
  if Assigned(FOnChangeName) then FOnChangeName(Self,AComponent,AName);
end;

procedure TCustomDesignerComponent.DoChangeOwner(AComponent,OldOwner: TComponent; var AOwner: TComponent);
begin
  if Assigned(FOnChangeOwner) then FOnChangeOwner(Self,AComponent,OldOwner,AOwner);
end;

procedure TCustomDesignerComponent.DoShowAlignmentPalette(Form: TForm);
begin
  if Assigned(FOnShowAlignmentPalette) then FOnShowAlignmentPalette(Self,Form);
end;

procedure TCustomDesignerComponent.DoHideAlignmentPalette(Form: TForm);
begin
  if Assigned(FOnHideAlignmentPalette) then FOnHideAlignmentPalette(Self,Form);
end;

constructor TCustomDesignerComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesignTime:=csDesigning in ComponentState;
  FAPForm:=TfrmAlignmentPalette.Create(Self);
  FSelected:=TList.Create;
  FHintWindow:=THintWindow.Create(Self);
  FHintWindow.Color:=clInfoBk;
  FShowNonVisual:=True;
  FShowMoveSizeHint:=True;
  FGridStep:=8;
  FSnapToGrid:=True;
  FGrabSize:=5;
  FDisplayGrid:=True;
  FGridColor:=clBlack;
  FDesignerColor:=clBtnFace;
  FMultiGrabBorder:=clGray;
  FMultiGrabFill:=clGray;
  FLockedGrabFill:=clGray;
end;

destructor TCustomDesignerComponent.Destroy;
begin
  FAPForm.Free;
  SetActive(False);
  FSelected.Free;
  inherited Destroy;
end;

procedure TCustomDesignerComponent.Update;
begin
  if Assigned(FGrabHandles) then
    with FGrabHandles do
      if SelectedControlCount=1 then
      begin
        Control:=Self.Control;
        BringToFront;
      end
      else Control:=nil;
end;

procedure TCustomDesignerComponent.LeaveMouseAction;
begin
  if FActive and (FMouseAction<>maNone) then
  begin
    case FMouseAction of
      maDragging: DrawDragRects;
      maSelecting: DrawSelectRect;
    end;
    ClipCursor(nil);
    ReleaseCapture;
    HideHint;
    ShowGrabs;
    FMouseAction:=maNone;
    if Assigned(Control) then FDragRect:=Control.BoundsRect;
  end;
end;

function TCustomDesignerComponent.FindComponentContainer(AComponent: TComponent): TComponentContainer;
var
  i: Integer;
begin
  Result:=nil;
  with ParentForm do
    for i:=0 to Pred(ComponentCount) do
      if (Components[i] is TComponentContainer) and
        (TComponentContainer(Components[i]).Component=AComponent) then
      begin
        Result:=TComponentContainer(Components[i]);
        Break;
      end;
end;

function TCustomDesignerComponent.Select(AComponent: TComponent): Boolean;
begin
  Result:=SelectControl(ComponentToControl(AComponent));
end;

function TCustomDesignerComponent.Deselect(AComponent: TComponent): Boolean;
begin
  Result:=DeselectControl(ComponentToControl(AComponent));
end;

procedure TCustomDesignerComponent.DeselectAll;
begin
  DeselectAllControls;
end;

function TCustomDesignerComponent.IsSelected(AComponent: TComponent): Boolean;
begin
  Result:=IsSelectedControl(ComponentToControl(AComponent));
end;

function TCustomDesignerComponent.IsSelectable(AComponent: TComponent): Boolean;
begin
  Result:=IsSelectableControl(ComponentToControl(AComponent));
end;

procedure TCustomDesignerComponent.CopyToClipboard;
var
  i: Integer;
  BinStream: TMemoryStream;
  StringStream: TStringStream;
begin
  if (Assigned(ParentForm)) and (SelectedControlCount>0) then
  begin
    i:=0;
    while i<SelectedControlCount do
      if Assigned(SelectedControls[i].Parent) and IsSelectedControl(SelectedControls[i].Parent) then
        DeselectControl(SelectedControls[i])
      else Inc(i);
    BinStream:=TMemoryStream.Create;
    try
      with TWriter.Create(BinStream,1024) do
      try
        Root:=ParentForm;
        for i:=0 to Pred(SelectedControlCount) do
        begin
          WriteSignature;
          if SelectedControls[i] is TComponentContainer then WriteComponent(TComponentContainer(SelectedControls[i]).Component)
          else WriteComponent(SelectedControls[i]);
        end;
      finally
        Free;
      end;
      BinStream.Seek(0,soFromBeginning);
      StringStream:=TStringStream.Create('');
      try
        while BinStream.Position<BinStream.Size do
          ObjectBinaryToText(BinStream,StringStream);
        Clipboard.AsText:=StringStream.DataString;
      finally
        StringStream.Free;
      end;
    finally
      BinStream.Free;
    end;
  end;
end;

procedure TCustomDesignerComponent.CutToClipboard;
begin
  CopyToClipboard;
  Delete;
end;

procedure TCustomDesignerComponent.PasteFromClipboard;

var
  i: Integer;
  Clip: string;
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ParentControl: TWinControl;
  NewComponent: TComponent;
  Editable: TList;
  ClipStrings: TStringList;

  procedure SetOwner(AComponent: TComponent);
  var
    OldOwner,NewOwner: TComponent;
  begin
    if Assigned(ParentForm) then
      with AComponent do
        if Owner<>ParentForm then
        begin
          OldOwner:=Owner;
          if Assigned(Owner) then Owner.RemoveComponent(AComponent);
          NewOwner:=ParentForm;
          DoChangeOwner(AComponent,OldOwner,NewOwner);
          NewOwner.InsertComponent(AComponent);
        end;
  end;

  procedure FillEditableList(NewComponent: TComponent);
  var
    i: Integer;
    S: string;
    C: TComponent;
  begin
    with Editable do
    begin
      Clear;
      for i:=0 to Pred(ClipStrings.Count) do
      begin
        S:=TrimLeft(ClipStrings[i]);
        if Pos('object ',S)=1 then
        begin
          System.Delete(S,1,Length('object '));
          S:=Copy(S,1,Pred(Pos(':',S)));
        end;
        C:=NewComponent.FindComponent(S);
        if Assigned(C) then Add(C);
      end;
    end;
  end;

begin
  Editable:=TList.Create;
  ClipStrings:=TStringList.Create;
  try
    Clip:=Clipboard.AsText;
    if (Assigned(ParentForm)) and (Clip<>'') then
    begin
      DeselectAll;
      ClipStrings.Text:=Clip;
      StringStream:=TStringStream.Create(Clip);
      try
        if Assigned(Control) then
          if Control is TWinControl then ParentControl:=TWinControl(Control)
          else ParentControl:=Control.Parent
        else ParentControl:=ParentForm;
        while Assigned(ParentControl) and not (csAcceptsControls in ParentControl.ControlStyle) do
          ParentControl:=ParentControl.Parent;
        if not Assigned(ParentControl) then ParentControl:=ParentForm;
        BinStream:=TMemoryStream.Create;
        try
          while StringStream.Position<StringStream.Size do
          begin
            BinStream.Seek(0,soFromBeginning);
            ObjectTextToBinary(StringStream,BinStream);
            BinStream.Seek(0,soFromBeginning);
            with TDesignerReader.Create(BinStream,1024) do
            try
              Parent:=ParentControl;
              NewComponent:=ReadRootComponent(nil);
              FillEditableList(NewComponent);
              NewComponent.Name:=NameProcessor(NewComponent,ParentForm,NewComponent.Name);
              SetOwner(NewComponent);
              for i:=0 to Pred(Editable.Count) do
                with TComponent(Editable[i]) do
                begin
                  Name:=NameProcessor(TComponent(Editable[i]),ParentForm,Name);
                  SetOwner(TComponent(Editable[i]));
                end;
              if FActive then CreateContainers;
              Select(NewComponent);
            finally
              Free;
            end;
          end;
        finally
          BinStream.Free;
        end;
      finally
        StringStream.Free;
      end;
    end;
  finally
    Editable.Free;
    ClipStrings.Free;
  end;
end;

procedure TCustomDesignerComponent.Delete;
var
  List: TList;
  i: Integer;

  function SelectedParent(AControl: Pointer): Boolean;
  var
    P: TControl;
  begin
    Result:=False;
    P:=TControl(AControl).Parent;
    with List do
      with TControl(AControl) do
        repeat
          if IndexOf(P)<>-1 then
          begin
            Result:=True;
            Break;
          end;
          P:=P.Parent;
        until not Assigned(P);
  end;

begin
  List:=TList.Create;
  with List do
  try
    while SelectedCount>0 do
    begin
      Add(Selected[0]);
      Deselect(Selected[0]);
    end;
    i:=0;
    while i<Count do
      if SelectedParent(Items[i]) then Delete(i)
      else Inc(i);
    for i:=0 to Pred(Count) do TObject(Items[i]).Free;
  finally
    Free;
  end;
end;

procedure TCustomDesignerComponent.SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
var
  Form: TCustomForm;
  Stream: TFileStream;
  TxtStream,BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      Stream:=TFileStream.Create(FileName,fmCreate);
      BinStream:=TMemoryStream.Create;
      try
        with TWriter.Create(BinStream,1024) do
        try
          Form:=ParentForm;
          Form.RemoveComponent(Self);
          Form.ActiveControl:=nil;
          try
            WriteRootComponent(Form);
          finally
            Form.InsertComponent(Self);
          end;
        finally
          Free;
        end;
        BinStream.Seek(0,soFromBeginning);
        if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
        else
        begin
          TxtStream:=TMemoryStream.Create;
          try
            ObjectBinaryToText(BinStream,TxtStream);
            TxtStream.Seek(0,soFromBeginning);
            ObjectTextToResource(TxtStream,Stream);
          finally
            TxtStream.Free;
          end;
        end;
      finally
        Stream.Free;
        BinStream.Free;
      end;
    finally
      if FActive then CreateContainers;
    end;
  end;
end;

procedure TCustomDesignerComponent.LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
var
  Stream: TFileStream;
  TxtStream,BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      ClearForm;
      Stream:=TFileStream.Create(FileName,fmOpenRead);
      BinStream:=TMemoryStream.Create;
      try
        if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
        else
        begin
          TxtStream:=TMemoryStream.Create;
          try
            ObjectResourceToText(Stream,TxtStream);
            TxtStream.Seek(0,soFromBeginning);
            ObjectTextToBinary(TxtStream,BinStream);
          finally
            TxtStream.Free;
          end;
        end;
        BinStream.Seek(0,soFromBeginning);
        ParentForm.Name:='';
        with TDesignerReader.Create(BinStream,1024) do
        try
          ReadRootComponent(ParentForm);
        finally
          Free;
        end;
      finally
        Stream.Free;
        BinStream.Free;
      end;
    finally
      if FActive then CreateContainers;
    end;
  end;
end;

procedure TCustomDesignerComponent.SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  Form: TCustomForm;
  BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      BinStream:=TMemoryStream.Create;
      try
        with TWriter.Create(BinStream,1024) do
        try
          Form:=ParentForm;
          Form.RemoveComponent(Self);
          try
            WriteRootComponent(Form);
          finally
            Form.InsertComponent(Self);
          end;
        finally
          Free;
        end;
        BinStream.Seek(0,soFromBeginning);
        if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
        else Stream.CopyFrom(BinStream,BinStream.Size);
      finally
        BinStream.Free;
      end;
    finally
      if FActive then CreateContainers;
    end;
  end;
end;

procedure TCustomDesignerComponent.LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      ClearForm;
      BinStream:=TMemoryStream.Create;
      try
        if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
        else BinStream.CopyFrom(Stream,Stream.Size);
        BinStream.Seek(0,soFromBeginning);
        with TDesignerReader.Create(BinStream,1024) do
        try
          ReadRootComponent(ParentForm);
        finally
          Free;
        end;
      finally
        BinStream.Free;
      end;
    finally
      if FActive then CreateContainers;
    end;
  end;
end;

procedure TCustomDesignerComponent.AlignToGrid;
var
  i: Integer;
begin
  for i:=0 to Pred(SelectedControlCount) do
    with SelectedControls[i] do
    begin
      if Left mod FGridStep < FGridStep div 2 then Left:=Left div FGridStep * FGridStep
      else Left:=Succ(Left div FGridStep) * FGridStep;
      if Top mod FGridStep < FGridStep div 2 then Top:=Top div FGridStep * FGridStep
      else Top:=Succ(Top div FGridStep) * FGridStep;
    end;
  Update;
end;

function LeftSort(Item1,Item2: Pointer): Integer;
begin
  if TControl(Item1).Left<TControl(Item2).Left then Result:=-1
  else
    if TControl(Item1).Left>TControl(Item2).Left then Result:=1
    else Result:=0;
end;

function RightSort(Item1,Item2: Pointer): Integer;

  function Right(Item: Pointer): Integer;
  begin
    with TControl(Item) do Result:=Left+Width;
  end;

begin
  if Right(Item1)<Right(Item2) then Result:=-1
  else
    if Right(Item1)>Right(Item2) then Result:=1
    else Result:=0;
end;

function TopSort(Item1,Item2: Pointer): Integer;
begin
  if TControl(Item1).Top<TControl(Item2).Top then Result:=-1
  else
    if TControl(Item1).Top>TControl(Item2).Top then Result:=1
    else Result:=0;
end;

function BottomSort(Item1,Item2: Pointer): Integer;

  function Bottom(Item: Pointer): Integer;
  begin
    with TControl(Item) do Result:=Top+Height;
  end;

begin
  if Bottom(Item1)<Bottom(Item2) then Result:=-1
  else
    if Bottom(Item1)>Bottom(Item2) then Result:=1
    else Result:=0;
end;

procedure TCustomDesignerComponent.AlignControls(Hor,Ver: TAlignMode);
var
  i,Val,Min,Max: Integer;
begin
  if FActive and (SelectedControlCount>0) then
  begin
    CheckParent(Control);
    with TList.Create do
    try
      for i:=0 to Pred(SelectedControlCount) do
        if not (caLocked in ComponentAttributes(SelectedControls[i])) then
          Add(SelectedControls[i]);
      case Hor of
        amLeftTop:
          if SelectedControlCount>1 then
          begin
            Sort(LeftSort);
            for i:=0 to Pred(SelectedControlCount) do
              if not (caLocked in ComponentAttributes(SelectedControls[i])) then
                SelectedControls[i].Left:=TControl(Items[0]).Left;
          end;
        amCenters:
          if SelectedControlCount>1 then
          begin
            Sort(LeftSort);
            Val:=TControl(Items[0]).Left;
            Sort(RightSort);
            with TControl(Items[Pred(Count)]) do Val:=(Val+Left+Width) div 2;
            for i:=0 to Pred(SelectedControlCount) do
              if not (caLocked in ComponentAttributes(SelectedControls[i])) then
                with SelectedControls[i] do Left:=Val-Width div 2;
          end;
        amRightBottom:
          if SelectedControlCount>1 then
          begin
            Sort(RightSort);
            with TControl(Items[Pred(Count)]) do Val:=Left+Width;
            for i:=0 to Pred(SelectedControlCount) do
              if not (caLocked in ComponentAttributes(SelectedControls[i])) then
                with SelectedControls[i] do Left:=Val-Width;
          end;
        amSpace:
          if Count>1 then
          begin
            Sort(LeftSort);
            Val:=(TControl(Items[Pred(Count)]).Left-TControl(Items[0]).Left) div Pred(Count);
            for i:=0 to Pred(Count) do
              TControl(Items[i]).Left:=TControl(Items[0]).Left+Val*i;
          end;
        amWindowCenter:
        begin
          Val:=Control.Parent.Width;
          Min:=MaxInt;
          Max:=-MaxInt;
          for i:=0 to Pred(SelectedControlCount) do
            with SelectedControls[i] do
            begin
              if Left<Min then Min:=Left;
              if Left+Width>Max then Max:=Left+Width;
            end;
          for i:=0 to Pred(SelectedControlCount) do
            if not (caLocked in ComponentAttributes(SelectedControls[i])) then
              with SelectedControls[i] do Left:=Left+(Val-Max+Min) div 2-Min;
        end;
      end;
      case Ver of
        amLeftTop:
          if SelectedControlCount>1 then
          begin
            Sort(TopSort);
            for i:=0 to Pred(SelectedControlCount) do
              if not (caLocked in ComponentAttributes(SelectedControls[i])) then
                SelectedControls[i].Top:=TControl(Items[0]).Top;
          end;
        amCenters:
          if SelectedControlCount>1 then
          begin
            Sort(TopSort);
            Val:=TControl(Items[0]).Top;
            Sort(BottomSort);
            with TControl(Items[Pred(Count)]) do Val:=(Val+Top+Height) div 2;
            for i:=0 to Pred(SelectedControlCount) do
              if not (caLocked in ComponentAttributes(SelectedControls[i])) then
                with SelectedControls[i] do Top:=Val-Height div 2;
          end;
        amRightBottom:
          if SelectedControlCount>1 then
          begin
            Sort(BottomSort);
            with TControl(Items[Pred(Count)]) do Val:=Top+Height;
            for i:=0 to Pred(SelectedControlCount) do
              if not (caLocked in ComponentAttributes(SelectedControls[i])) then
                with SelectedControls[i] do Top:=Val-Height;
          end;
        amSpace:
          if Count>1 then
          begin
            Sort(TopSort);
            Val:=(TControl(Items[Pred(Count)]).Top-TControl(Items[0]).Top) div Pred(Count);
            for i:=0 to Pred(Count) do
              TControl(Items[i]).Top:=TControl(Items[0]).Top+Val*i;
          end;
        amWindowCenter:
        begin
          Val:=Control.Parent.Height;
          Min:=MaxInt;
          Max:=-MaxInt;
          for i:=0 to Pred(SelectedControlCount) do
            with SelectedControls[i] do
            begin
              if Top<Min then Min:=Top;
              if Top+Height>Max then Max:=Top+Height;
            end;
          for i:=0 to Pred(SelectedControlCount) do
            if not (caLocked in ComponentAttributes(SelectedControls[i])) then
              with SelectedControls[i] do Top:=Top+(Val-Max+Min) div 2-Min;
        end;
      end;
    finally
      Free;
    end;
    for i:=0 to Pred(SelectedControlCount) do
      if not (caLocked in ComponentAttributes(SelectedControls[i])) then
        DoAfterDrag(SelectedControls[i]);
    Update;
  end;
end;

procedure TCustomDesignerComponent.SizeControls(WMode: TSizeMode; WValue: Integer; HMode: TSizeMode; HValue: Integer);
var
  i,Val: Integer;
begin
  if FActive and (SelectedControlCount>0) then
  begin
    CheckParent(Control);
    case WMode of
      smToSmallest:
      begin
        Val:=MaxInt;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            with SelectedControls[i] do
              if Width<Val then Val:=Width;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            SelectedControls[i].Width:=Val;
      end;
      smToLargest:
      begin
        Val:=-MaxInt;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            with SelectedControls[i] do
              if Width>Val then Val:=Width;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            SelectedControls[i].Width:=Val;
      end;
      smValue:
      begin
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            SelectedControls[i].Width:=WValue;
      end;
    end;
    case HMode of
      smToSmallest:
      begin
        Val:=MaxInt;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            with SelectedControls[i] do
              if Height<Val then Val:=Height;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            SelectedControls[i].Height:=Val;
      end;
      smToLargest:
      begin
        Val:=-MaxInt;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            with SelectedControls[i] do
              if Height>Val then Val:=Height;
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            SelectedControls[i].Height:=Val;
      end;
      smValue:
      begin
        for i:=0 to Pred(SelectedControlCount) do
          if not (caLocked in ComponentAttributes(SelectedControls[i])) then
            SelectedControls[i].Height:=HValue;
      end;
    end;
    for i:=0 to Pred(SelectedControlCount) do
      if not (caLocked in ComponentAttributes(SelectedControls[i])) then
        DoAfterDrag(SelectedControls[i]);
    Update;
  end;
end;

procedure TCustomDesignerComponent.AlignDialog;
begin
  with TfrmAlign.Create(Application) do
  try
    if ShowModal=mrOk then
      AlignControls(TAlignMode(rgrHorizontal.ItemIndex),TAlignMode(rgrVertical.ItemIndex));
  finally
    Free;
  end;
end;

procedure TCustomDesignerComponent.SizeDialog;
var
  W,H: TSizeMode;

  function GetInt(S: string): Integer;
  begin
    if S='' then Result:=0
    else Result:=StrToInt(S);
  end;

begin
  with TfrmSize.Create(Application) do
  try
    if ShowModal=mrOk then
    begin
      if rbtWNoChange.Checked then W:=smNoChange
      else
        if rbtWToSmallest.Checked then W:=smToSmallest
        else
          if rbtWToLargest.Checked then W:=smToLargest
          else W:=smValue;
      if rbtHNoChange.Checked then H:=smNoChange
      else
        if rbtHToSmallest.Checked then H:=smToSmallest
        else
          if rbtHToLargest.Checked then H:=smToLargest
          else H:=smValue;
      SizeControls(W,GetInt(edtWidth.Text),H,GetInt(edtHeight.Text));
    end;
  finally
    Free;
  end;
end;

procedure TCustomDesignerComponent.ShowAlignmentPalette;
begin
  if not FAPForm.Visible then
  begin
    DoShowAlignmentPalette(FAPForm);
    FAPForm.Show;
  end;
end;

procedure TCustomDesignerComponent.HideAlignmentPalette;
begin
  if FAPForm.Visible then
  begin
    FAPForm.Hide;
    DoHideAlignmentPalette(FAPForm);
  end;
end;

procedure TCustomDesignerComponent.TabOrderDialog;
var
  PC: TWinControl;
  i: Integer;
  List: TList;
begin
  with TfrmTabOrder.Create(Application) do
  try
    if Assigned(Control) then
    begin
      CheckParent(Control);
      if Control is TWinControl then PC:=TWinControl(Control)
      else PC:=Control.Parent;
      while Assigned(PC) and (PC.ControlCount=0) do PC:=PC.Parent;
      if not Assigned(PC) then PC:=ParentForm;
    end
    else PC:=ParentForm;
    List:=TList.Create;
    try
      PC.GetTabOrderList(List);
      for i:=0 to Pred(List.Count) do
        if not IsGrabHandle(TControl(List[i])) and
          not (TControl(List[i]) is TComponentContainer) then
          with TControl(List[i]) do
            if Parent=PC then
              lsbControls.Items.AddObject(Name+': '+ClassName,List[i]);
    finally
      List.Free;
    end;
    with lsbControls,Items do
    begin
      if Count>0 then ItemIndex:=0
      else btnOK.Enabled:=False;
      if ShowModal=mrOk then
        for i:=0 to Pred(Count) do
          (Objects[i] as TWinControl).TabOrder:=i;
    end;
  finally
    Free;
  end;
end;

procedure TCustomDesignerComponent.CreationOrderDialog;
var
  i: Integer;
begin
  with TfrmCreationOrder.Create(Application) do
  try
    with lsbComponents.Items do
    begin
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
          if not (Components[i] is TControl) and
            not (Components[i] is TMenuItem) and
            (caEditable in ComponentAttributes(Components[i])) and
            (Components[i]<>Self) then
            with Components[i] do
              AddObject(Name+': '+ClassName,ParentForm.Components[i]);
      if Count>0 then lsbComponents.ItemIndex:=0
      else btnOK.Enabled:=False;
      if ShowModal=mrOk then
        for i:=0 to Pred(Count) do TComponent(Objects[i]).ComponentIndex:=i;
    end;
  finally
    Free;
  end;
end;

end.
