unit jwComCtrls;

{$R-,T-,H+,X+}

interface

uses Messages, Windows, SysUtils, CommCtrl, Controls, Forms, Classes,
  Menus, Graphics, StdCtrls, RichEdit, ToolWin, ImgList, ExtCtrls; //ListActns;

type
  THitTest = (htAbove, htBelow, htNowhere, htOnItem, htOnButton, htOnIcon,
    htOnIndent, htOnLabel, htOnRight, htOnStateIcon, htToLeft, htToRight);
  THitTests = set of THitTest;

{ Custom draw }

  TCustomDrawTarget = (dtControl, dtItem, dtSubItem);
  TCustomDrawStage = (cdPrePaint, cdPostPaint, cdPreErase, cdPostErase);
  TCustomDrawState = set of (cdsSelected, cdsGrayed, cdsDisabled, cdsChecked,
    cdsFocused, cdsDefault, cdsHot, cdsMarked, cdsIndeterminate);

{ TjwTreeNode }

  TjwCustomTreeView = class;
  TjwTreeNodes = class;

  TNodeState = (nsCut, nsDropHilited, nsFocused, nsSelected, nsExpanded);
  TjwNodeAttachMode = (naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert);
  TAddMode = (taAddFirst, taAdd, taInsert);

  PNodeInfo = ^TNodeInfo;
  TNodeInfo = packed record
    Target: String;
    Module: String;
    ImageIndex: Integer;
    SelectedIndex: Integer;
    StateIndex: Integer;
    OverlayIndex: Integer;
    Data: Pointer;
    Count: Integer;
    Text: string[255];
  end;

  TjwTreeNodeClass = class of TjwTreeNode;
  TjwTreeNode = class(TPersistent)
  private
    FOwner: TjwTreeNodes;
    FText: string;
    FData: Pointer;
    FItemId: HTreeItem;
    FTarget: String;
    FModule: String;
    FImageIndex: TImageIndex;
    FSelectedIndex: Integer;
    FOverlayIndex: Integer;
    FStateIndex: Integer;
    FDeleting: Boolean;
    FInTree: Boolean;
    function CompareCount(CompareMe: Integer): Boolean;
    function DoCanExpand(Expand: Boolean): Boolean;
    procedure DoExpand(Expand: Boolean);
    procedure ExpandItem(Expand: Boolean; Recurse: Boolean);
    function GetAbsoluteIndex: Integer;
    function GetExpanded: Boolean;
    function GetLevel: Integer;
    function GetParent: TjwTreeNode;
    function GetChildren: Boolean;
    function GetCut: Boolean;
    function GetDropTarget: Boolean;
    function GetFocused: Boolean;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TjwTreeNode;
    function GetSelected: Boolean;
    function GetCount: Integer;
    function GetTreeView: TjwCustomTreeView;
    procedure InternalMove(ParentNode, Node: TjwTreeNode; HItem: HTreeItem;
      AddMode: TAddMode);
    function IsEqual(Node: TjwTreeNode): Boolean;
    function IsNodeVisible: Boolean;
    procedure ReadData(Stream: TStream; Info: PNodeInfo);
    procedure SetChildren(Value: Boolean);
    procedure SetCut(Value: Boolean);
    procedure SetData(Value: Pointer);
    procedure SetDropTarget(Value: Boolean);
    procedure SetItem(Index: Integer; Value: TjwTreeNode);
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetTarget(Value: String);
    procedure SetModule(Value: String);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetOverlayIndex(Value: Integer);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetSelected(Value: Boolean);
    procedure SetStateIndex(Value: Integer);
    procedure SetText(const S: string);
    procedure WriteData(Stream: TStream; Info: PNodeInfo);
  protected
    function GetState(NodeState: TNodeState): Boolean;
    procedure SetState(NodeState: TNodeState; Value: Boolean);
    procedure SetSelectedBit(Value: Boolean);
  public
    constructor Create(AOwner: TjwTreeNodes);
    destructor Destroy; override;
    function AlphaSort(ARecurse: Boolean = False): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure Collapse(Recurse: Boolean);
    function CustomSort(SortProc: TTVCompare; Data: Longint; ARecurse: Boolean = False): Boolean;
    procedure Delete;
    procedure DeleteChildren;
    function DisplayRect(TextOnly: Boolean): TRect;
    function EditText: Boolean;
    procedure EndEdit(Cancel: Boolean);
    procedure Expand(Recurse: Boolean);
    function getFirstChild: TjwTreeNode; {GetFirstChild conflicts with C++ macro}
    function GetHandle: HWND;
    function GetLastChild: TjwTreeNode;
    function GetNext: TjwTreeNode;
    function GetNextChild(Value: TjwTreeNode): TjwTreeNode;
    function getNextSibling: TjwTreeNode; {GetNextSibling conflicts with C++ macro}
    function GetNextVisible: TjwTreeNode;
    function GetPrev: TjwTreeNode;
    function GetPrevChild(Value: TjwTreeNode): TjwTreeNode;
    function getPrevSibling: TjwTreeNode; {GetPrevSibling conflicts with a C++ macro}
    function GetPrevVisible: TjwTreeNode;
    function HasAsParent(Value: TjwTreeNode): Boolean;
    function IndexOf(Value: TjwTreeNode): Integer;
    procedure MakeVisible;
    procedure MoveTo(Destination: TjwTreeNode; Mode: TjwNodeAttachMode); virtual;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    function IsFirstNode: Boolean;
    property Count: Integer read GetCount;
    property Cut: Boolean read GetCut write SetCut;
    property Data: Pointer read FData write SetData;
    property Deleting: Boolean read FDeleting;
    property Focused: Boolean read GetFocused write SetFocused;
    property DropTarget: Boolean read GetDropTarget write SetDropTarget;
    property Selected: Boolean read GetSelected write SetSelected;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Handle: HWND read GetHandle;
    property HasChildren: Boolean read GetChildren write SetChildren;
    property Target: String read FTarget write SetTarget;
    property Module: String read FModule write SetModule;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex;
    property Index: Integer read GetIndex;
    property IsVisible: Boolean read IsNodeVisible;
    property Item[Index: Integer]: TjwTreeNode read GetItem write SetItem; default;
    property ItemId: HTreeItem read FItemId;
    property Level: Integer read GetLevel;
    property OverlayIndex: Integer read FOverlayIndex write SetOverlayIndex;
    property Owner: TjwTreeNodes read FOwner;
    property Parent: TjwTreeNode read GetParent;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;
    property StateIndex: Integer read FStateIndex write SetStateIndex;
    property Text: string read FText write SetText;
    property TreeView: TjwCustomTreeView read GetTreeView;
  end;

{ TjwTreeNodes }

  PNodeCache = ^TNodeCache;
  TNodeCache = record
    CacheNode: TjwTreeNode;
    CacheIndex: Integer;
  end;

  TjwTreeNodes = class(TPersistent)
  private
    FOwner: TjwCustomTreeView;
    FUpdateCount: Integer;
    FNodeCache: TNodeCache;
    FReading: Boolean;
    procedure AddedNode(Value: TjwTreeNode);
    function GetHandle: HWND;
    function GetNodeFromIndex(Index: Integer): TjwTreeNode;
    procedure ReadData(Stream: TStream);
    procedure Repaint(Node: TjwTreeNode);
    procedure WriteData(Stream: TStream);
    procedure ClearCache;
    procedure WriteExpandedState(Stream: TStream);
    procedure ReadExpandedState(Stream: TStream);
  protected
    function AddItem(Parent, Target: HTreeItem; const Item: TTVItem;
      AddMode: TAddMode): HTreeItem;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateItem(Node: TjwTreeNode): TTVItem;
    function GetCount: Integer;
    procedure SetItem(Index: Integer; Value: TjwTreeNode);
    procedure SetUpdateState(Updating: Boolean);
    property Reading: Boolean read FReading;
  public
    constructor Create(AOwner: TjwCustomTreeView);
    destructor Destroy; override;
    function AddChildFirst(Parent: TjwTreeNode; const S: string): TjwTreeNode;
    function AddChild(Parent: TjwTreeNode; const S: string): TjwTreeNode;
    function AddChildObjectFirst(Parent: TjwTreeNode; const S: string;
      Ptr: Pointer): TjwTreeNode;
    function AddChildObject(Parent: TjwTreeNode; const S: string;
      Ptr: Pointer): TjwTreeNode;
    function AddFirst(Sibling: TjwTreeNode; const S: string): TjwTreeNode;
    function Add(Sibling: TjwTreeNode; const S: string): TjwTreeNode;
    function AddObjectFirst(Sibling: TjwTreeNode; const S: string;
      Ptr: Pointer): TjwTreeNode;
    function AddObject(Sibling: TjwTreeNode; const S: string;
      Ptr: Pointer): TjwTreeNode;
    function AddNode(Node, Relative: TjwTreeNode; const S: string;
      Ptr: Pointer; Method: TjwNodeAttachMode): TjwTreeNode;
    function AlphaSort(ARecurse: Boolean = False): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear;
    function CustomSort(SortProc: TTVCompare; Data: Longint; ARecurse: Boolean = False): Boolean;
    procedure Delete(Node: TjwTreeNode);
    procedure EndUpdate;
    function GetFirstNode: TjwTreeNode;
    function GetNode(ItemId: HTreeItem): TjwTreeNode;
    function Insert(Sibling: TjwTreeNode; const S: string): TjwTreeNode;
    function InsertObject(Sibling: TjwTreeNode; const S: string;
      Ptr: Pointer): TjwTreeNode;
    function InsertNode(Node, Sibling: TjwTreeNode; const S: string;
      Ptr: Pointer): TjwTreeNode;
    property Count: Integer read GetCount;
    property Handle: HWND read GetHandle;
    property Item[Index: Integer]: TjwTreeNode read GetNodeFromIndex; default;
    property Owner: TjwCustomTreeView read FOwner;
  end;

{ TjwCustomTreeView }

  TSortType = (stNone, stData, stText, stBoth);
  TMultiSelectStyles = (msControlSelect, msShiftSelect,
                        msVisibleOnly, msSiblingOnly);
  TMultiSelectStyle = set of TMultiSelectStyles;
  ETreeViewError = class(Exception);

  TTVChangingEvent = procedure(Sender: TObject; Node: TjwTreeNode;
    var AllowChange: Boolean) of object;
  TTVChangedEvent = procedure(Sender: TObject; Node: TjwTreeNode) of object;
  TTVEditingEvent = procedure(Sender: TObject; Node: TjwTreeNode;
    var AllowEdit: Boolean) of object;
  TTVEditedEvent = procedure(Sender: TObject; Node: TjwTreeNode; var S: string) of object;
  TTVExpandingEvent = procedure(Sender: TObject; Node: TjwTreeNode;
    var AllowExpansion: Boolean) of object;
  TTVCollapsingEvent = procedure(Sender: TObject; Node: TjwTreeNode;
    var AllowCollapse: Boolean) of object;
  TTVExpandedEvent = procedure(Sender: TObject; Node: TjwTreeNode) of object;
  TTVCompareEvent = procedure(Sender: TObject; Node1, Node2: TjwTreeNode;
    Data: Integer; var Compare: Integer) of object;
  TTVCustomDrawEvent = procedure(Sender: TjwCustomTreeView; const ARect: TRect;
    var DefaultDraw: Boolean) of object;
  TTVCustomDrawItemEvent = procedure(Sender: TjwCustomTreeView; Node: TjwTreeNode;
    State: TCustomDrawState; var DefaultDraw: Boolean) of object;
  TTVAdvancedCustomDrawEvent = procedure(Sender: TjwCustomTreeView; const ARect: TRect;
    Stage: TCustomDrawStage; var DefaultDraw: Boolean) of object;
  TTVAdvancedCustomDrawItemEvent = procedure(Sender: TjwCustomTreeView; Node: TjwTreeNode;
    State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages,
    DefaultDraw: Boolean) of object;
  TTVCreateNodeClassEvent = procedure(Sender: TjwCustomTreeView;
    var NodeClass: TjwTreeNodeClass) of object;

  TjwCustomTreeView = class(TWinControl)
  private
    FAutoExpand: Boolean;
    FBorderStyle: TBorderStyle;
    FCanvas: TCanvas;
    FCanvasChanged: Boolean;
    FDefEditProc: Pointer;
    FDragged: Boolean;
    FDragImage: TDragImageList;
    FDragNode: TjwTreeNode;
    FEditHandle: HWND;
    FEditInstance: Pointer;
    FHideSelection: Boolean;
    FHotTrack: Boolean;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FLastDropTarget: TjwTreeNode;
    FMemStream: TMemoryStream;
    FRClickNode: TjwTreeNode;
    FRightClickSelect: Boolean;
    FManualNotify: Boolean;
    FReadOnly: Boolean;
    FRowSelect: Boolean;
    FSaveIndex: Integer;
    FSaveIndent: Integer;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FShowButtons: Boolean;
    FShowLines: Boolean;
    FShowRoot: Boolean;
    FSortType: TSortType;
    FStateChanging: Boolean;
    FStateImages: TCustomImageList;
    FStateChangeLink: TChangeLink;
    FToolTips: Boolean;
    FjwTreeNodes: TjwTreeNodes;
    FWideText: WideString;
    FMultiSelect: Boolean;
    FMultiSelectStyle: TMultiSelectStyle;
    FSelections: TList;
    FSaveIndexes: TList;
    FShiftAnchor: TjwTreeNode;
    FSelecting, FSelectChanged: Boolean;
    FOurFont: Integer;
    FStockFont: Integer;
    FCreateWndRestores: Boolean;
    FOnAdvancedCustomDraw: TTVAdvancedCustomDrawEvent;
    FOnAdvancedCustomDrawItem: TTVAdvancedCustomDrawItemEvent;
    FOnCancelEdit: TTVChangedEvent;
    FOnChange: TTVChangedEvent;
    FOnChanging: TTVChangingEvent;
    FOnCollapsed: TTVExpandedEvent;
    FOnCollapsing: TTVCollapsingEvent;
    FOnCompare: TTVCompareEvent;
    FOnCustomDraw: TTVCustomDrawEvent;
    FOnCustomDrawItem: TTVCustomDrawItemEvent;
    FOnDeletion: TTVExpandedEvent;
    FOnAddition: TTVExpandedEvent;
    FOnEditing: TTVEditingEvent;
    FOnEdited: TTVEditedEvent;
    FOnExpanded: TTVExpandedEvent;
    FOnExpanding: TTVExpandingEvent;
    FOnGetImageIndex: TTVExpandedEvent;
    FOnGetSelectedIndex: TTVExpandedEvent;
    FOnCreateNodeClass: TTVCreateNodeClassEvent;
    procedure CanvasChanged(Sender: TObject);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure EditWndProc(var Message: TMessage);
    procedure DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
    procedure NodeDeselect(Index: Integer);
    procedure NodeSelect(Node: TjwTreeNode; At: Integer = 0);
    procedure FinishSelection(Node: TjwTreeNode; ShiftState: TShiftState);
    procedure ControlSelectNode(Node: TjwTreeNode);
    procedure ShiftSelectNode(Node: TjwTreeNode; Backward: Boolean; Deselect: Boolean = True);
    procedure ControlShiftSelectNode(Node: TjwTreeNode; Backward: Boolean);
    procedure SelectNode(Node: TjwTreeNode);
    function GetChangeDelay: Integer;
    function GetDropTarget: TjwTreeNode;
    function GetIndent: Integer;
    function GetNodeFromItem(const Item: TTVItem): TjwTreeNode;
    function GetSelected: TjwTreeNode;
    function GetSelectionCount: Cardinal;
    function GetSelection(Index: Integer): TjwTreeNode;
    function GetTopItem: TjwTreeNode;
    procedure ImageListChange(Sender: TObject);
    procedure SetAutoExpand(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetButtonStyle(Value: Boolean);
    procedure SetChangeDelay(Value: Integer);
    procedure SetDropTarget(Value: TjwTreeNode);
    procedure SetHideSelection(Value: Boolean);
    procedure SetHotTrack(Value: Boolean);
    procedure SetImageList(Value: HImageList; Flags: Integer);
    procedure SetIndent(Value: Integer);
    procedure SetImages(Value: TCustomImageList);
    procedure SetLineStyle(Value: Boolean);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetMultiSelectStyle(const Value: TMultiSelectStyle);
    procedure SetReadOnly(Value: Boolean);
    procedure SetRootStyle(Value: Boolean);
    procedure SetRowSelect(Value: Boolean);
    procedure SetSelected(Value: TjwTreeNode);
    procedure SetSortType(Value: TSortType);
    procedure SetStateImages(Value: TCustomImageList);
    procedure SetToolTips(Value: Boolean);
    procedure SetjwTreeNodes(Value: TjwTreeNodes);
    procedure SetTopItem(Value: TjwTreeNode);
    procedure OnChangeTimer(Sender: TObject);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
  protected
    FChangeTimer: TTimer;
    function CanEdit(Node: TjwTreeNode): Boolean; dynamic;
    function CanChange(Node: TjwTreeNode): Boolean; dynamic;
    function CanCollapse(Node: TjwTreeNode): Boolean; dynamic;
    function CanExpand(Node: TjwTreeNode): Boolean; dynamic;
    procedure Change(Node: TjwTreeNode); dynamic;
    procedure Collapse(Node: TjwTreeNode); dynamic;
    function CreateNode: TjwTreeNode; virtual;
    function CreateNodes: TjwTreeNodes; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean; virtual;
    function CustomDrawItem(Node: TjwTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean; virtual;
    procedure Delete(Node: TjwTreeNode); dynamic;
    procedure Added(Node: TjwTreeNode); dynamic;
    procedure DestroyWnd; override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure Edit(const Item: TTVItem); dynamic;
    procedure Expand(Node: TjwTreeNode); dynamic;
    function GetDragImages: TDragImageList; override;
    procedure GetImageIndex(Node: TjwTreeNode); virtual;
    procedure GetSelectedIndex(Node: TjwTreeNode); virtual;
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure WndProc(var Message: TMessage); override;
    procedure ValidateSelection;
    procedure InvalidateSelectionsRects;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    property AutoExpand: Boolean read FAutoExpand write SetAutoExpand default False;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ChangeDelay: Integer read GetChangeDelay write SetChangeDelay default 0;
    property CreateWndRestores: Boolean read FCreateWndRestores write FCreateWndRestores default True;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property Images: TCustomImageList read FImages write SetImages;
    property Indent: Integer read GetIndent write SetIndent;
    property Items: TjwTreeNodes read FjwTreeNodes write SetjwTreeNodes;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
    property MultiSelectStyle: TMultiSelectStyle read FMultiSelectStyle write SetMultiSelectStyle default [msControlSelect];
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property RightClickSelect: Boolean read FRightClickSelect write FRightClickSelect default False;
    property RowSelect: Boolean read FRowSelect write SetRowSelect default False;
    property ShowButtons: Boolean read FShowButtons write SetButtonStyle default True;
    property ShowLines: Boolean read FShowLines write SetLineStyle default True;
    property ShowRoot: Boolean read FShowRoot write SetRootStyle default True;
    property SortType: TSortType read FSortType write SetSortType default stNone;
    property StateImages: TCustomImageList read FStateImages write SetStateImages;
    property ToolTips: Boolean read FToolTips write SetToolTips default True;
    property OnAddition: TTVExpandedEvent read FOnAddition write FOnAddition;
    property OnAdvancedCustomDraw: TTVAdvancedCustomDrawEvent read FOnAdvancedCustomDraw write FOnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem: TTVAdvancedCustomDrawItemEvent read FOnAdvancedCustomDrawItem write FOnAdvancedCustomDrawItem;
    property OnCancelEdit: TTVChangedEvent read FOnCancelEdit write FOnCancelEdit;
    property OnChange: TTVChangedEvent read FOnChange write FOnChange;
    property OnChanging: TTVChangingEvent read FOnChanging write FOnChanging;
    property OnCollapsed: TTVExpandedEvent read FOnCollapsed write FOnCollapsed;
    property OnCollapsing: TTVCollapsingEvent read FOnCollapsing write FOnCollapsing;
    property OnCompare: TTVCompareEvent read FOnCompare write FOnCompare;
    property OnCustomDraw: TTVCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnCustomDrawItem: TTVCustomDrawItemEvent read FOnCustomDrawItem write FOnCustomDrawItem;
    property OnDeletion: TTVExpandedEvent read FOnDeletion write FOnDeletion;
    property OnEditing: TTVEditingEvent read FOnEditing write FOnEditing;
    property OnEdited: TTVEditedEvent read FOnEdited write FOnEdited;
    property OnExpanding: TTVExpandingEvent read FOnExpanding write FOnExpanding;
    property OnExpanded: TTVExpandedEvent read FOnExpanded write FOnExpanded;
    property OnGetImageIndex: TTVExpandedEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnGetSelectedIndex: TTVExpandedEvent read FOnGetSelectedIndex write FOnGetSelectedIndex;
    property OnCreateNodeClass: TTVCreateNodeClassEvent read FOnCreateNodeClass write FOnCreateNodeClass;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AlphaSort(ARecurse: Boolean = True): Boolean;
    function CustomSort(SortProc: TTVCompare; Data: Longint; ARecurse: Boolean = True): Boolean;
    procedure FullCollapse;
    procedure FullExpand;
    function GetHitTestInfoAt(X, Y: Integer): THitTests;
    function GetNodeAt(X, Y: Integer): TjwTreeNode;
    function IsEditing: Boolean;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    property Canvas: TCanvas read FCanvas;
    property DropTarget: TjwTreeNode read GetDropTarget write SetDropTarget;
    property Selected: TjwTreeNode read GetSelected write SetSelected;
    property TopItem: TjwTreeNode read GetTopItem write SetTopItem;

    procedure Select(Node: TjwTreeNode; ShiftState: TShiftState = []); overload; virtual;
    procedure Select(const Nodes: array of TjwTreeNode); overload; virtual;
    procedure Select(Nodes: TList); overload; virtual;
    procedure Deselect(Node: TjwTreeNode); virtual;
    //procedure Subselect(Node: TjwTreeNode; Validate: Boolean = False); virtual;
    property SelectionCount: Cardinal read GetSelectionCount;
    property Selections[Index: Integer]: TjwTreeNode read GetSelection;
    procedure ClearSelection(KeepPrimary: Boolean = False); virtual;
    function GetSelections(AList: TList): TjwTreeNode;
    function FindNextToSelect: TjwTreeNode; virtual;
  end;

  TjwTreeView = class(TjwCustomTreeView)
  published
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    property MultiSelect;
    property MultiSelectStyle;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Visible;
    property OnAddition;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    property OnCreateNodeClass;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    { Items must be published after OnGetImageIndex and OnGetSelectedIndex }
    property Items;
  end;

const
  ComCtlVersionIE3 = $00040046;
  ComCtlVersionIE4 = $00040047;
  ComCtlVersionIE401 = $00040048;
  ComCtlVersionIE5 = $00050050;

function InitCommonControl(CC: Integer): Boolean;
procedure CheckCommonControl(CC: Integer);
function GetComCtlVersion: Integer;

implementation

uses Printers, Consts, ComStrs, ActnList, StdActns; // RTLConsts, ExtActns, , Types

const
  ComCtlDllName = 'comctl32.dll';

var
  ComCtlVersion: Integer;

{ TjwTreeNode }

function InitCommonControl(CC: Integer): Boolean;
var
  ICC: TInitCommonControlsEx;
begin
  ICC.dwSize := SizeOf(TInitCommonControlsEx);
  ICC.dwICC := CC;
  Result := InitCommonControlsEx(ICC);
  if not Result then InitCommonControls;
end;

procedure CheckCommonControl(CC: Integer);
begin
  if not InitCommonControl(CC) then
    raise EComponentError.CreateRes(@SInvalidComCtl32);
end;

function DefaultTreeViewSort(Node1, Node2: TjwTreeNode; lParam: Integer): Integer; stdcall;
begin
  with Node1 do
    if Assigned(TreeView.OnCompare) then
      TreeView.OnCompare(TreeView, Node1, Node2, lParam, Result)
    else Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
end;

function GetComCtlVersion: Integer;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  if ComCtlVersion = 0 then
  begin
    // GetFileVersionInfo modifies the filename parameter data while parsing.
    // Copy the string const into a local variable to create a writeable copy.
    FileName := ComCtlDllName;
    InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
    if InfoSize <> 0 then
    begin
      GetMem(VerBuf, InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
            ComCtlVersion := FI.dwFileVersionMS;
      finally
        FreeMem(VerBuf);
      end;
    end;
  end;
  Result := ComCtlVersion;
end;

procedure SetComCtlStyle(Ctl: TWinControl; Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style := GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle then Style := Style and not Value
    else Style := Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;

procedure TreeViewError(const Msg: string);
begin
  raise ETreeViewError.Create(Msg);
end;

procedure TreeViewErrorFmt(const Msg: string; Format: array of const);
begin
  raise ETreeViewError.CreateFmt(Msg, Format);
end;

constructor TjwTreeNode.Create(AOwner: TjwTreeNodes);
begin
  inherited Create;
  FOverlayIndex := -1;
  FStateIndex := -1;
  FOwner := AOwner;
end;

destructor TjwTreeNode.Destroy;
var
  Node: TjwTreeNode;
  CheckValue: Integer;
begin
  Owner.ClearCache;
  FDeleting := True;
  if Owner.Owner <> nil then
    Owner.Owner.FSelections.Remove(Self);
  if Owner.Owner.FLastDropTarget = Self then
    Owner.Owner.FLastDropTarget := nil;
  Node := Parent;
  if (Node <> nil) and (not Node.Deleting) then
  begin
    if Node.IndexOf(Self) <> -1 then
      CheckValue := 1
    else
      CheckValue := 0;
    if Node.CompareCount(CheckValue) then
    begin
      Expanded := False;
      Node.HasChildren := False;
    end;
  end;
  if Owner.Owner <> nil then
    Owner.Owner.Delete(Self);
  if ItemId <> nil then
    TreeView_DeleteItem(Handle, ItemId);
  Data := nil;
  inherited Destroy;
end;

function TjwTreeNode.GetHandle: HWND;
begin
  Result := TreeView.Handle;
end;

function TjwTreeNode.GetTreeView: TjwCustomTreeView;
begin
  Result := Owner.Owner;
end;

function TjwTreeNode.HasAsParent(Value: TjwTreeNode): Boolean;
begin
  if Value <> Nil then
  begin
    if Parent = nil then Result := False
    else if Parent = Value then Result := True
    else Result := Parent.HasAsParent(Value);
  end
  else Result := True;
end;

procedure TjwTreeNode.SetText(const S: string);
var
  Item: TTVItem;
begin
  if not Deleting and (S <> Text) then
  begin
    FText := S;
    with Item do
    begin
      mask := TVIF_TEXT;
      hItem := ItemId;
      pszText := LPSTR_TEXTCALLBACK;
    end;
    TreeView_SetItem(Handle, Item);
    if (TreeView.SortType in [stText, stBoth]) and FInTree then
    begin
      if (Parent <> nil) then
        Parent.AlphaSort
      else
        TreeView.AlphaSort(False);
    end;
  end;
end;

procedure TjwTreeNode.SetData(Value: Pointer);
begin
  if not Deleting and (Value <> Data) then
  begin
    FData := Value;
    if (TreeView.SortType in [stData, stBoth]) and Assigned(TreeView.OnCompare)
      and (not Deleting) and FInTree then
    begin
      if Parent <> nil then
        Parent.AlphaSort
      else
        TreeView.AlphaSort(False);
    end;
  end;
end;

function TjwTreeNode.GetState(NodeState: TNodeState): Boolean;
var
  Item: TTVItem;
begin
  Result := False;
  if not Deleting then
    with Item do
    begin
      mask := TVIF_STATE;
      hItem := ItemId;
      if TreeView_GetItem(Handle, Item) then
        case NodeState of
          nsCut: Result := (state and TVIS_CUT) <> 0;
          nsFocused: Result := (state and TVIS_FOCUSED) <> 0;
          nsSelected: Result := (state and TVIS_SELECTED) <> 0;
          nsExpanded: Result := (state and TVIS_EXPANDED) <> 0;
          nsDropHilited: Result := (state and TVIS_DROPHILITED) <> 0;
        end;
    end;
end;

procedure TjwTreeNode.SetState(NodeState: TNodeState; Value: Boolean);
var
  Item: TTVItem;
begin
  if not Deleting then
  begin
    with Item do
    begin
      mask := TVIF_STATE;
      hItem := ItemId;
      case NodeState of
        nsCut: stateMask := TVIS_CUT;
        nsFocused: stateMask := TVIS_FOCUSED;
        nsSelected: stateMask := TVIS_SELECTED;
        nsExpanded: stateMask := TVIS_EXPANDED;
        nsDropHilited: stateMask := TVIS_DROPHILITED;
      end;
      if Value then
        state := stateMask and DWORD(-1)
      else
        state := DWORD(0);
    end;
    TreeView_SetItem(Handle, Item);
  end;
end;

procedure TjwTreeNode.SetTarget(Value: String);
begin
  if not Deleting and (Value <> Target) then
    FTarget := Value;
end;

procedure TjwTreeNode.SetModule(Value: String);
begin
  if not Deleting and (Value <> Module) then
    FModule := Value;
end;

procedure TjwTreeNode.SetImageIndex(Value: TImageIndex);
var
  Item: TTVItem;
begin
  if not Deleting and (Value <> ImageIndex) then
  begin
    FImageIndex := Value;
    with Item do
    begin
      mask := TVIF_IMAGE or TVIF_HANDLE;
      hItem := ItemId;
      if Assigned(TjwCustomTreeView(Owner.Owner).OnGetImageIndex) then
        iImage := I_IMAGECALLBACK
      else
        iImage := FImageIndex;
    end;
    TreeView_SetItem(Handle, Item);
  end;
end;

procedure TjwTreeNode.SetSelectedIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if not Deleting and (Value <> SelectedIndex) then
  begin
    FSelectedIndex := Value;
    with Item do
    begin
      mask := TVIF_SELECTEDIMAGE or TVIF_HANDLE;
      hItem := ItemId;
      if Assigned(TjwCustomTreeView(Owner.Owner).OnGetSelectedIndex) then
        iSelectedImage := I_IMAGECALLBACK
      else
        iSelectedImage := FSelectedIndex;
    end;
    TreeView_SetItem(Handle, Item);
  end;
end;

procedure TjwTreeNode.SetOverlayIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if not Deleting and (Value <> OverlayIndex) then
  begin
    FOverlayIndex := Value;
    with Item do
    begin
      mask := TVIF_STATE or TVIF_HANDLE;
      stateMask := TVIS_OVERLAYMASK;
      hItem := ItemId;
      state := IndexToOverlayMask(FOverlayIndex + 1);
    end;
    TreeView_SetItem(Handle, Item);
  end;
end;

procedure TjwTreeNode.SetStateIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if not Deleting and (Value <> StateIndex) then
  begin
    FStateIndex := Value;
    if Value >= 0 then Dec(Value);
    with Item do
    begin
      mask := TVIF_STATE or TVIF_HANDLE;
      stateMask := TVIS_STATEIMAGEMASK;
      hItem := ItemId;
      state := IndexToStateImageMask(Value + 1);
    end;
    TreeView_SetItem(Handle, Item);
  end;
end;

function TjwTreeNode.CompareCount(CompareMe: Integer): Boolean;
var
  Count: integer;
  Node: TjwTreeNode;
Begin
  Count := 0;
  Result := False;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Count);
    Node := Node.GetNextChild(Node);
    if Count > CompareMe then
      Exit;
  end;
  if Count = CompareMe then
    Result := True;
end;

function TjwTreeNode.DoCanExpand(Expand: Boolean): Boolean;
begin
  Result := False;
  if not Deleting then
    if HasChildren then
    begin
      if Expand then
        Result := TreeView.CanExpand(Self)
      else
        Result := TreeView.CanCollapse(Self);
    end;
end;

procedure TjwTreeNode.DoExpand(Expand: Boolean);
begin
  if not Deleting and HasChildren then
  begin
    if Expand then
      TreeView.Expand(Self)
    else
      TreeView.Collapse(Self);
  end;
end;

procedure TjwTreeNode.ExpandItem(Expand: Boolean; Recurse: Boolean);
var
  Flag: Integer;
  Node: TjwTreeNode;
begin
  if not Deleting then
    if Recurse then
    begin
      Node := Self;
      repeat
        Node.ExpandItem(Expand, False);
        Node := Node.GetNext;
      until (Node = nil) or (not Node.HasAsParent(Self));
    end
    else begin
      TreeView.FManualNotify := True;
      try
        Flag := 0;
        if Expand then
        begin
          if DoCanExpand(True) then
          begin
            Flag := TVE_EXPAND;
            DoExpand(True);
          end;
        end
        else begin
          if DoCanExpand(False) then
          begin
            Flag := TVE_COLLAPSE;
            DoExpand(False);
          end;
        end;
        if Flag <> 0 then TreeView_Expand(Handle, ItemId, Flag);
      finally
        TreeView.FManualNotify := False;
      end;
    end;
end;

procedure TjwTreeNode.Expand(Recurse: Boolean);
begin
  ExpandItem(True, Recurse);
end;

procedure TjwTreeNode.Collapse(Recurse: Boolean);
begin
  ExpandItem(False, Recurse);
end;

function TjwTreeNode.GetExpanded: Boolean;
begin
  Result := GetState(nsExpanded);
end;

procedure TjwTreeNode.SetExpanded(Value: Boolean);
begin
  if Value <> Expanded then
  begin
    if Value then
      Expand(False)
    else
      Collapse(False);
  end;
end;

function TjwTreeNode.GetSelected: Boolean;
begin
  Result := GetState(nsSelected);
end;

procedure TjwTreeNode.SetSelected(Value: Boolean);
begin
  if not Deleting and (Handle <> 0) and (ItemId <> nil) then
    if Value <> Selected then
    begin
      if Value then TreeView_SelectItem(Handle, ItemId)
      else if Selected then TreeView_SelectItem(Handle, nil);
    end
    else if (TreeView.MultiSelect) and (TreeView.FSelections.Count > 1) then
      TreeView.Select(Self, []);
end;

procedure TjwTreeNode.SetSelectedBit(Value: Boolean);
begin
  SetState(nsSelected, Value);
end;

function TjwTreeNode.GetCut: Boolean;
begin
  Result := GetState(nsCut);
end;

procedure TjwTreeNode.SetCut(Value: Boolean);
begin
  if Value <> Cut then
    SetState(nsCut, Value);
end;

function TjwTreeNode.GetDropTarget: Boolean;
begin
  Result := GetState(nsDropHilited);
end;

procedure TjwTreeNode.SetDropTarget(Value: Boolean);
begin
  if (Handle <> 0) and (ItemId <> nil) then
    if Value then
      TreeView_SelectDropTarget(Handle, ItemId)
    else if DropTarget then
      TreeView_SelectDropTarget(Handle, nil);
end;

function TjwTreeNode.GetChildren: Boolean;
var
  Item: TTVItem;
begin
  Result := False;
  if not Deleting then
  begin
    Item.mask := TVIF_CHILDREN;
    Item.hItem := ItemId;
    if TreeView_GetItem(Handle, Item) then
      Result := Item.cChildren > 0;
  end;
end;

procedure TjwTreeNode.SetFocused(Value: Boolean);
begin
  if Value <> Focused then
    SetState(nsFocused, Value);
end;

function TjwTreeNode.GetFocused: Boolean;
begin
  Result := GetState(nsFocused);
end;

procedure TjwTreeNode.SetChildren(Value: Boolean);
var
  Item: TTVItem;
begin
  if not Deleting then
  begin
    with Item do
    begin
      mask := TVIF_CHILDREN;
      hItem := ItemId;
      cChildren := Ord(Value);
    end;
    TreeView_SetItem(Handle, Item);
  end;
end;

function TjwTreeNode.GetParent: TjwTreeNode;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) then
    with FOwner do
      Result := GetNode(TreeView_GetParent(Handle, ItemId));
end;

function TjwTreeNode.GetNextSibling: TjwTreeNode;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) then
    with FOwner do
      Result := GetNode(TreeView_GetNextSibling(Handle, ItemId));
end;

function TjwTreeNode.GetPrevSibling: TjwTreeNode;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) then
    with FOwner do
      Result := GetNode(TreeView_GetPrevSibling(Handle, ItemId));
end;

function TjwTreeNode.GetNextVisible: TjwTreeNode;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) and IsVisible then
    with FOwner do
      Result := GetNode(TreeView_GetNextVisible(Handle, ItemId));
end;

function TjwTreeNode.GetPrevVisible: TjwTreeNode;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) and IsVisible then
    with FOwner do
      Result := GetNode(TreeView_GetPrevVisible(Handle, ItemId));
end;

function TjwTreeNode.GetNextChild(Value: TjwTreeNode): TjwTreeNode;
begin
  if Value <> nil then Result := Value.GetNextSibling
  else Result := nil;
end;

function TjwTreeNode.GetPrevChild(Value: TjwTreeNode): TjwTreeNode;
begin
  if Value <> nil then Result := Value.GetPrevSibling
  else Result := nil;
end;

function TjwTreeNode.GetFirstChild: TjwTreeNode;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) then
    with FOwner do
      Result := GetNode(TreeView_GetChild(Handle, ItemId));
end;

function TjwTreeNode.GetLastChild: TjwTreeNode;
var
  Node: TjwTreeNode;
begin
  Result := GetFirstChild;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetNextSibling;
    until Node = nil;
  end;
end;

function TjwTreeNode.GetNext: TjwTreeNode;
var
  NodeID, ParentID: HTreeItem;
begin
  Result := nil;
  if (Handle <> 0) and (ItemId <> nil) then
  begin
    NodeID := TreeView_GetChild(Handle, ItemId);
    if NodeID = nil then
      NodeID := TreeView_GetNextSibling(Handle, ItemId);
    ParentID := ItemId;
    while (NodeID = nil) and (ParentID <> nil) do
    begin
      ParentID := TreeView_GetParent(Handle, ParentID);
      NodeID := TreeView_GetNextSibling(Handle, ParentID);
    end;
    Result := FOwner.GetNode(NodeID);
  end;
end;

function TjwTreeNode.GetPrev: TjwTreeNode;
var
  Node: TjwTreeNode;
begin
  Result := GetPrevSibling;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetLastChild;
    until Node = nil;
  end else
    Result := Parent;
end;

function TjwTreeNode.GetAbsoluteIndex: Integer;
var
  Node: TjwTreeNode;
begin
  if Owner.FNodeCache.CacheNode = Self then
    Result := Owner.FNodeCache.CacheIndex
  else
  begin
    if IsFirstNode then
      Result := 0
    else
    begin
      Result := -1;
      Node := Self;
      while Node <> nil do
      begin
        Inc(Result);
        Node := Node.GetPrev;
      end;
    end;
  end;
end;

function TjwTreeNode.GetIndex: Integer;
var
  Node: TjwTreeNode;
begin
  Result := -1;
  Node := Self;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetPrevSibling;
  end;
end;

function TjwTreeNode.GetItem(Index: Integer): TjwTreeNode;
begin
  Result := GetFirstChild;
  while (Result <> nil) and (Index > 0) do
  begin
    Result := GetNextChild(Result);
    Dec(Index);
  end;
  if Result = nil then TreeViewError(Format(SListIndexError, [Index]));
end;

procedure TjwTreeNode.SetItem(Index: Integer; Value: TjwTreeNode);
begin
  item[Index].Assign(Value);
end;

function TjwTreeNode.IndexOf(Value: TjwTreeNode): Integer;
var
  Node: TjwTreeNode;
begin
  Result := -1;
  Node := GetFirstChild;
  while (Node <> nil) do
  begin
    Inc(Result);
    if Node = Value then Break;
    Node := GetNextChild(Node);
  end;
  if Node = nil then Result := -1;
end;

function TjwTreeNode.GetCount: Integer;
var
  Node: TjwTreeNode;
begin
  Result := 0;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetNextChild(Node);
  end;
end;

procedure TjwTreeNode.EndEdit(Cancel: Boolean);
begin
  if not Deleting then
    TreeView_EndEditLabelNow(Handle, Cancel);
end;

procedure TjwTreeNode.InternalMove(ParentNode, Node: TjwTreeNode;
  HItem: HTreeItem; AddMode: TAddMode);
var
  I: Integer;
  NodeId: HTreeItem;
  TreeViewItem: TTVItem;
  Children: Boolean;
  IsSelected: Boolean;
begin
  Owner.ClearCache;
  if (AddMode = taInsert) and (Node <> nil) then
    NodeId := Node.ItemId else
    NodeId := nil;
  Children := HasChildren;
  IsSelected := Selected;
  if (Parent <> nil) and (Parent.CompareCount(1)) then
  begin
    Parent.Expanded := False;
    Parent.HasChildren := False;
  end;
  with TreeViewItem do
  begin
    mask := TVIF_PARAM;
    hItem := ItemId;
    lParam := 0;
  end;
  TreeView_SetItem(Handle, TreeViewItem);
  with Owner do
    HItem := AddItem(HItem, NodeId, CreateItem(Self), AddMode);
  if HItem = nil then
    raise EOutOfResources.Create(sInsertError);
  for I := Count - 1 downto 0 do
    Item[I].InternalMove(Self, nil, HItem, taAddFirst);
  TreeView_DeleteItem(Handle, ItemId);
  FItemId := HItem;
  Assign(Self);
  HasChildren := Children;
  Selected := IsSelected;
end;

procedure TjwTreeNode.MoveTo(Destination: TjwTreeNode; Mode: TjwNodeAttachMode);
var
  AddMode: TAddMode;
  Node: TjwTreeNode;
  HItem: HTreeItem;
  OldOnChanging: TTVChangingEvent;
  OldOnChange: TTVChangedEvent;
begin
  if not Deleting then
  begin
    OldOnChanging := TreeView.OnChanging;
    OldOnChange := TreeView.OnChange;
    TreeView.OnChanging := nil;
    TreeView.OnChange := nil;
    try
      if (Destination = nil) or not Destination.HasAsParent(Self) then
      begin
        AddMode := taAdd;
        if (Destination <> nil) and not (Mode in [naAddChild, naAddChildFirst]) then
          Node := Destination.Parent else
          Node := Destination;
        case Mode of
          naAdd,
          naAddChild: AddMode := taAdd;
          naAddFirst,
          naAddChildFirst: AddMode := taAddFirst;
          naInsert:
            begin
              Destination := Destination.GetPrevSibling;
              if Destination = nil then AddMode := taAddFirst
              else AddMode := taInsert;
            end;
        end;
        if Node <> nil then
          HItem := Node.ItemId else
          HItem := nil;
        if (Destination <> Self) then
          InternalMove(Node, Destination, HItem, AddMode);
        Node := Parent;
        if Node <> nil then
        begin
          Node.HasChildren := True;
          Node.Expanded := True;
        end;
      end;
    finally
      TreeView.OnChanging := OldOnChanging;
      TreeView.OnChange := OldOnChange;
    end;
  end;
end;

function TjwTreeNode.IsFirstNode: Boolean;
begin
  Result := not Deleting and (Parent = nil) and (GetPrevSibling = nil);
end;

procedure TjwTreeNode.MakeVisible;
begin
  if (Handle <> 0) and (ItemId <> nil) then
    TreeView_EnsureVisible(Handle, ItemId);
end;

function TjwTreeNode.GetLevel: Integer;
var
  Node: TjwTreeNode;
begin
  Result := 0;
  Node := Parent;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.Parent;
  end;
end;

function TjwTreeNode.IsNodeVisible: Boolean;
var
  Rect: TRect;
begin
  Result := not Deleting and TreeView_GetItemRect(Handle, ItemId, Rect, True);
end;

function TjwTreeNode.EditText: Boolean;
begin
  Result := (Handle <> 0) and (ItemId <> nil) and (TreeView_EditLabel(Handle, ItemId) <> 0);
end;

function TjwTreeNode.DisplayRect(TextOnly: Boolean): TRect;
begin
  FillChar(Result, SizeOf(Result), 0);
  if not Deleting then
    TreeView_GetItemRect(Handle, ItemId, Result, TextOnly);
end;

function TjwTreeNode.AlphaSort(ARecurse: Boolean): Boolean;
begin
  Result := CustomSort(nil, 0, ARecurse);
end;

function TjwTreeNode.CustomSort(SortProc: TTVCompare; Data: Longint; ARecurse: Boolean): Boolean;
var
  SortCB: TTVSortCB;
  LNode: TjwTreeNode;
begin
  Result := False;
  if not Deleting then
  begin
    Owner.ClearCache;
    with SortCB do
    begin
      if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
      else lpfnCompare := SortProc;
      hParent := ItemId;
      lParam := Data;
    end;
    Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
    if ARecurse then
    begin
      LNode := GetFirstChild;
      while LNode <> nil do
      begin
        if LNode.HasChildren then
          LNode.CustomSort(SortProc, Data, True);
        LNode := LNode.GetNextSibling;
      end;
    end;
  end;
end;

procedure TjwTreeNode.Delete;
begin
  if not Deleting then
    Free;
end;

procedure TjwTreeNode.DeleteChildren;
begin
  Owner.ClearCache;
  if not Deleting then
    TreeView_Expand(TreeView.Handle, ItemID, TVE_COLLAPSE or TVE_COLLAPSERESET);
  HasChildren := False;
end;

procedure TjwTreeNode.Assign(Source: TPersistent);
var
  Node: TjwTreeNode;
begin
  Owner.ClearCache;
  if not Deleting and (Source is TjwTreeNode) then
  begin
    Node := TjwTreeNode(Source);
    Text := Node.Text;
    Data := Node.Data;
    ImageIndex := Node.ImageIndex;
    SelectedIndex := Node.SelectedIndex;
    StateIndex := Node.StateIndex;
    OverlayIndex := Node.OverlayIndex;
    Focused := Node.Focused;
    DropTarget := Node.DropTarget;
    Cut := Node.Cut;
    HasChildren := Node.HasChildren;
  end
  else
    inherited Assign(Source);
end;

function TjwTreeNode.IsEqual(Node: TjwTreeNode): Boolean;
begin
  Result := (Text = Node.Text) and (Data = Node.Data);
end;

procedure TjwTreeNode.ReadData(Stream: TStream; Info: PNodeInfo);
var
  I, Size, ItemCount: Integer;
  LNode: TjwTreeNode;
begin
  Owner.ClearCache;
  Stream.ReadBuffer(Size, SizeOf(Size));
  Stream.ReadBuffer(Info^, Size);
  Text := Info^.Text;
  ImageIndex := Info^.ImageIndex;
  SelectedIndex := Info^.SelectedIndex;
  StateIndex := Info^.StateIndex;
  OverlayIndex := Info^.OverlayIndex;
  Data := Info^.Data;
  ItemCount := Info^.Count;
  for I := 0 to ItemCount - 1 do
  begin
    LNode := Owner.AddChild(Self, '');
    LNode.ReadData(Stream, Info);
    Owner.Owner.Added(LNode);
  end;
end;

procedure TjwTreeNode.WriteData(Stream: TStream; Info: PNodeInfo);
var
  I, Size, L, ItemCount: Integer;
begin
  L := Length(Text);
  if L > 255 then L := 255;
  Size := SizeOf(TNodeInfo) + L - 255;
  Info^.Text := Text;
  Info^.ImageIndex := ImageIndex;
  Info^.SelectedIndex := SelectedIndex;
  Info^.OverlayIndex := OverlayIndex;
  Info^.StateIndex := StateIndex;
  Info^.Data := Data;
  ItemCount := Count;
  Info^.Count := ItemCount;
  Stream.WriteBuffer(Size, SizeOf(Size));
  Stream.WriteBuffer(Info^, Size);
  for I := 0 to ItemCount - 1 do
    Item[I].WriteData(Stream, Info);
end;

{ TjwTreeNodes }

constructor TjwTreeNodes.Create(AOwner: TjwCustomTreeView);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TjwTreeNodes.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TjwTreeNodes.GetCount: Integer;
begin
  if Owner.HandleAllocated then
    Result := TreeView_GetCount(Handle)
  else
    Result := 0;
end;

function TjwTreeNodes.GetHandle: HWND;
begin
  Result := Owner.Handle;
end;

procedure TjwTreeNodes.Delete(Node: TjwTreeNode);
begin
  Node.Delete;
end;

procedure TjwTreeNodes.Clear;
var
  LHandleAllocated: Boolean;
begin
  LHandleAllocated := Owner.HandleAllocated;
  if LHandleAllocated then
    BeginUpdate;
  try
    ClearCache;
    if Owner.HandleAllocated then
      TreeView_DeleteAllItems(Owner.Handle);
  finally
    if LHandleAllocated then
      EndUpdate;
  end;
end;

function TjwTreeNodes.AddChildFirst(Parent: TjwTreeNode; const S: string): TjwTreeNode;
begin
  Result := AddNode(nil, Parent, S, nil, naAddChildFirst);
end;

function TjwTreeNodes.AddChildObjectFirst(Parent: TjwTreeNode; const S: string;
  Ptr: Pointer): TjwTreeNode;
begin
  Result := AddNode(nil, Parent, S, Ptr, naAddChildFirst);
end;

function TjwTreeNodes.AddChild(Parent: TjwTreeNode; const S: string): TjwTreeNode;
begin
  Result := AddNode(nil, Parent, S, nil, naAddChild);
end;

function TjwTreeNodes.AddChildObject(Parent: TjwTreeNode; const S: string;
  Ptr: Pointer): TjwTreeNode;
begin
  Result := AddNode(nil, Parent, S, Ptr, naAddChild);
end;

function TjwTreeNodes.AddFirst(Sibling: TjwTreeNode; const S: string): TjwTreeNode;
begin
  Result := AddNode(nil, Sibling, S, nil, naAddFirst);
end;

function TjwTreeNodes.AddObjectFirst(Sibling: TjwTreeNode; const S: string;
  Ptr: Pointer): TjwTreeNode;
begin
  Result := AddNode(nil, Sibling, S, Ptr, naAddFirst);
end;

function TjwTreeNodes.Add(Sibling: TjwTreeNode; const S: string): TjwTreeNode;
begin
  Result := AddNode(nil, Sibling, S, nil, naAdd);
end;

function TjwTreeNodes.AddObject(Sibling: TjwTreeNode; const S: string;
  Ptr: Pointer): TjwTreeNode;
begin
  Result := AddNode(nil, Sibling, S, Ptr, naAdd);
end;

function TjwTreeNodes.Insert(Sibling: TjwTreeNode; const S: string): TjwTreeNode;
begin
  Result := AddNode(nil, Sibling, S, nil, naInsert);
end;

function TjwTreeNodes.InsertObject(Sibling: TjwTreeNode; const S: string;
  Ptr: Pointer): TjwTreeNode;
begin
  Result := AddNode(nil, Sibling, S, Ptr, naInsert);
end;

function TjwTreeNodes.InsertNode(Node, Sibling: TjwTreeNode; const S: string;
  Ptr: Pointer): TjwTreeNode;
begin
  Result := AddNode(Node, Sibling, S, Ptr, naInsert);
end;

function TjwTreeNodes.AddNode(Node, Relative: TjwTreeNode; const S: string;
  Ptr: Pointer; Method: TjwNodeAttachMode): TjwTreeNode;
const
  cAddMode: array [TjwNodeAttachMode] of TAddMode =
    (taAdd, taAddFirst, taAdd, taAddFirst, taInsert);
var
  Item, ItemId: HTreeItem;
  Parent: TjwTreeNode;
  AddMode: TAddMode;
begin
  // what are we trying to add?
  if Node = nil then
    Result := Owner.CreateNode
  else
    Result := Node;

  // ok lets try to actually add it
  try
    Item := nil;
    ItemId := nil;
    Parent := nil;
    AddMode := cAddMode[Method];
    if Relative <> nil then
      case Method of
        naAdd, naAddFirst:
          begin
            Parent := Relative.Parent;
            if Parent <> nil then
              Item := Parent.ItemId;
          end;
        naAddChild, naAddChildFirst:
          begin
            Parent := Relative;
            Item := Parent.ItemId;
          end;
        naInsert:
          begin
            Parent := Relative.Parent;
            if Parent <> nil then
              Item := Parent.ItemId;
            Relative := Relative.GetPrevSibling;
            if Relative <> nil then
              ItemId := Relative.ItemId
            else
              AddMode := taAddFirst;
          end;
      end;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, ItemId, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    if (FUpdateCount = 0) and Result.IsFirstNode then
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
    AddedNode(Parent);
    if not Reading then
      Owner.Added(Result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TjwTreeNodes.Repaint(Node: TjwTreeNode);
var
  R: TRect;
begin
  if FUpdateCount < 1 then
  begin
    while (Node <> nil) and not Node.IsVisible do
      Node := Node.Parent;
    if Node <> nil then
    begin
      R := Node.DisplayRect(False);
      InvalidateRect(Owner.Handle, @R, True);
    end;
  end;
end;

procedure TjwTreeNodes.AddedNode(Value: TjwTreeNode);
begin
  if Value <> nil then
  begin
    Value.HasChildren := True;
    Repaint(Value);
  end;
end;

function TjwTreeNodes.CreateItem(Node: TjwTreeNode): TTVItem;
begin
  Node.FInTree := True;
  with Result do
  begin
    mask := TVIF_TEXT or TVIF_PARAM or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
    lParam := Longint(Node);
    pszText := LPSTR_TEXTCALLBACK;
    iImage := I_IMAGECALLBACK;
    iSelectedImage := I_IMAGECALLBACK;
  end;
end;

function TjwTreeNodes.AddItem(Parent, Target: HTreeItem;
  const Item: TTVItem; AddMode: TAddMode): HTreeItem;
var
  InsertStruct: TTVInsertStruct;
begin
  ClearCache;
  with InsertStruct do
  begin
    hParent := Parent;
    case AddMode of
      taAddFirst:
        hInsertAfter := TVI_FIRST;
      taAdd:
        hInsertAfter := TVI_LAST;
      taInsert:
        hInsertAfter := Target;
    end;
  end;
  InsertStruct.item := Item;
  FOwner.FChangeTimer.Enabled := False;
  Result := TreeView_InsertItem(Handle, InsertStruct);
end;

function TjwTreeNodes.GetFirstNode: TjwTreeNode;
begin
  Result := GetNode(TreeView_GetRoot(Handle));
end;

function TjwTreeNodes.GetNodeFromIndex(Index: Integer): TjwTreeNode;
var
  I: Integer;
begin
  if Index < 0 then TreeViewError(sInvalidIndex);
  if (FNodeCache.CacheNode <> nil) and (Abs(FNodeCache.CacheIndex - Index) <= 1) then
  begin
    with FNodeCache do
    begin
      if Index = CacheIndex then
        Result := CacheNode
      else if Index < CacheIndex then
        Result := CacheNode.GetPrev
      else
        Result := CacheNode.GetNext;
    end;
  end
  else begin
    Result := GetFirstNode;
    I := Index;
    while (I <> 0) and (Result <> nil) do
    begin
      Result := Result.GetNext;
      Dec(I);
    end;
  end;
  if Result = nil then
    TreeViewError(sInvalidIndex);
  FNodeCache.CacheNode := Result;
  FNodeCache.CacheIndex := Index;
end;

function TjwTreeNodes.GetNode(ItemId: HTreeItem): TjwTreeNode;
var
  Item: TTVItem;
begin
  with Item do
  begin
    hItem := ItemId;
    mask := TVIF_PARAM;
  end;
  if TreeView_GetItem(Handle, Item) then
    Result := TjwTreeNode(Item.lParam)
  else
    Result := nil;
end;

procedure TjwTreeNodes.SetItem(Index: Integer; Value: TjwTreeNode);
begin
  GetNodeFromIndex(Index).Assign(Value);
end;

procedure TjwTreeNodes.BeginUpdate;
begin
  if FUpdateCount = 0 then
    SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TjwTreeNodes.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
    Owner.Refresh;
end;

procedure TjwTreeNodes.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    SetUpdateState(False);
end;

procedure TjwTreeNodes.Assign(Source: TPersistent);
var
  jwTreeNodes: TjwTreeNodes;
  MemStream: TMemoryStream;
begin
  ClearCache;
  if Source is TjwTreeNodes then
  begin
    jwTreeNodes := TjwTreeNodes(Source);
    Clear;
    MemStream := TMemoryStream.Create;
    try
      jwTreeNodes.WriteData(MemStream);
      MemStream.Position := 0;
      ReadData(MemStream);
    finally
      MemStream.Free;
    end;
  end
  else inherited Assign(Source);
end;

procedure TjwTreeNodes.DefineProperties(Filer: TFiler);

  function WriteNodes: Boolean;
  var
    I: Integer;
    Nodes: TjwTreeNodes;
  begin
    Nodes := TjwTreeNodes(Filer.Ancestor);
    if Nodes = nil then
      Result := Count > 0
    else if Nodes.Count <> Count then
      Result := True
    else
    begin
      Result := False;
      for I := 0 to Count - 1 do
      begin
        Result := not Item[I].IsEqual(Nodes[I]);
        if Result then
          Break;
      end
    end;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
end;

procedure TjwTreeNodes.ReadData(Stream: TStream);
var
  I, Count: Integer;
  NodeInfo: TNodeInfo;
  LNode: TjwTreeNode;
  LHandleAllocated: Boolean;
begin
  LHandleAllocated := Owner.HandleAllocated;
  if LHandleAllocated then
    BeginUpdate;
  FReading := True;
  try
    Clear;
    Stream.ReadBuffer(Count, SizeOf(Count));
    for I := 0 to Count - 1 do
    begin
      LNode := Add(nil, '');
      LNode.ReadData(Stream, @NodeInfo);
      Owner.Added(LNode);
    end;
  finally
    FReading := False;
    if LHandleAllocated then
      EndUpdate;
  end;
end;

procedure TjwTreeNodes.WriteData(Stream: TStream);
var
  I: Integer;
  Node: TjwTreeNode;
  NodeInfo: TNodeInfo;
begin
  I := 0;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Inc(I);
    Node := Node.GetNextSibling;
  end;
  Stream.WriteBuffer(I, SizeOf(I));
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Node.WriteData(Stream, @NodeInfo);
    Node := Node.GetNextSibling;
  end;
end;

procedure TjwTreeNodes.ReadExpandedState(Stream: TStream);
var
  ItemCount,
  Index: Integer;
  Node: TjwTreeNode;
  NodeExpanded: Boolean;
begin
  if Stream.Position < Stream.Size then
    Stream.ReadBuffer(ItemCount, SizeOf(ItemCount))
  else Exit;
  Index := 0;
  Node := GetFirstNode;
  while (Index < ItemCount) and (Node <> nil) do
  begin
    Stream.ReadBuffer(NodeExpanded, SizeOf(NodeExpanded));
    Node.Expanded := NodeExpanded;
    Inc(Index);
    Node := Node.GetNext;
  end;
end;

procedure TjwTreeNodes.WriteExpandedState(Stream: TStream);
var
  Size: Integer;
  Node: TjwTreeNode;
  NodeExpanded: Boolean;
begin
  Size := SizeOf(Boolean) * Count;
  Stream.WriteBuffer(Size, SizeOf(Size));
  Node := GetFirstNode;
  while (Node <> nil) do
  begin
    NodeExpanded := Node.Expanded;
    Stream.WriteBuffer(NodeExpanded, SizeOf(Boolean));
    Node := Node.GetNext;
  end;
end;

procedure TjwTreeNodes.ClearCache;
begin
  FNodeCache.CacheNode := nil;
end;

type
  TTreeStrings = class(TStrings)
  private
    FOwner: TjwTreeNodes;
  protected
    function Get(Index: Integer): string; override;
    function GetBufStart(Buffer: PChar; var Level: Integer): PChar;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AOwner: TjwTreeNodes);
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure LoadTreeFromStream(Stream: TStream);
    procedure SaveTreeToStream(Stream: TStream);
    property Owner: TjwTreeNodes read FOwner;
  end;

constructor TTreeStrings.Create(AOwner: TjwTreeNodes);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TTreeStrings.Get(Index: Integer): string;
const
  TabChar = #9;
var
  Level, I: Integer;
  Node: TjwTreeNode;
begin
  Result := '';
  Node := Owner.GetNodeFromIndex(Index);
  Level := Node.Level;
  for I := 0 to Level - 1 do Result := Result + TabChar;
  Result := Result + Node.Text;
end;

function TTreeStrings.GetBufStart(Buffer: PChar; var Level: Integer): PChar;
begin
  Level := 0;
  while Buffer^ in [' ', #9] do
  begin
    Inc(Buffer);
    Inc(Level);
  end;
  Result := Buffer;
end;

function TTreeStrings.GetObject(Index: Integer): TObject;
begin
  Result := Owner.GetNodeFromIndex(Index).Data;
end;

procedure TTreeStrings.PutObject(Index: Integer; AObject: TObject);
begin
  Owner.GetNodeFromIndex(Index).Data := AObject;
end;

function TTreeStrings.GetCount: Integer;
begin
  Result := Owner.Count;
end;

procedure TTreeStrings.Clear;
begin
  Owner.Clear;
end;

procedure TTreeStrings.Delete(Index: Integer);
begin
  Owner.GetNodeFromIndex(Index).Delete;
end;

procedure TTreeStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Owner.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then Owner.Owner.Refresh;
end;

function TTreeStrings.Add(const S: string): Integer;
var
  Level, OldLevel, I: Integer;
  NewStr: string;
  Node: TjwTreeNode;
begin
  Result := GetCount;
  if (Length(S) = 1) and (S[1] = Chr($1A)) then Exit;
  Node := nil;
  OldLevel := 0;
  NewStr := GetBufStart(PChar(S), Level);
  if Result > 0 then
  begin
    Node := Owner.GetNodeFromIndex(Result - 1);
    OldLevel := Node.Level;
  end;
  if (Level > OldLevel) or (Node = nil) then
  begin
    if Level - OldLevel > 1 then TreeViewError(sInvalidLevel);
  end
  else begin
    for I := OldLevel downto Level do
    begin
      Node := Node.Parent;
      if (Node = nil) and (I - Level > 0) then
        TreeViewError(sInvalidLevel);
    end;
  end;
  Owner.AddChild(Node, NewStr);
end;

procedure TTreeStrings.Insert(Index: Integer; const S: string);
begin
  with Owner do
    Insert(GetNodeFromIndex(Index), S);
end;

procedure TTreeStrings.LoadTreeFromStream(Stream: TStream);
var
  List, ListItem: TStringList;
  ANode, NextNode: TjwTreeNode;
  ALevel, i, y: Integer;
  CurrStr, CurrModule, CurrTarget: string;
  CurrImage: Integer;

  procedure StringToArray(St: string; Separador: char; Lista: TStringList);
  var
    I: Integer;
  begin
    Lista.Clear;
    if St <> '' then
    begin
      St := St + Separador; //';';
      I := Pos(Separador, St);
      while I > 0 do
      begin
        Lista.Add(Copy(St, 1, I - 1));
        System.Delete(St, 1, I);
        I := Pos(Separador, St);
      end;
    end;
  end; {StringToArray}

begin
  List := TStringList.Create;
  Owner.BeginUpdate;
  try
    try
      Clear;
      List.LoadFromStream(Stream);
      ANode := nil;
      for i := 0 to List.Count - 1 do
      begin
        CurrStr := GetBufStart(PChar(List[i]), ALevel);
        CurrModule := '';
        CurrTarget := '';
        CurrImage  := -1;
        ListItem := TStringList.Create;
        StringToArray(CurrStr, '|', ListItem);
        for Y := 0 to ListItem.Count-1 do
          case Y of
            0: CurrStr := ListItem[Y];
            1: CurrModule := ListItem[Y];
            2: CurrTarget := ListItem[Y];
            3: CurrImage := StrToIntDef(ListItem[Y],-1);
          end;
        if ANode = nil then
        begin
          ANode := Owner.AddChild(nil, CurrStr);
          ANode.FModule    := CurrModule;
          ANode.FTarget    := CurrTarget;
          ANode.ImageIndex := CurrImage;
        end
        else if ANode.Level = ALevel then
        begin
          ANode := Owner.AddChild(ANode.Parent, CurrStr);
          ANode.FModule    := CurrModule;
          ANode.FTarget    := CurrTarget;
          ANode.ImageIndex := CurrImage;
        end
        else if ANode.Level = (ALevel - 1) then
        begin
          ANode := Owner.AddChild(ANode, CurrStr);
          ANode.FModule    := CurrModule;
          ANode.FTarget    := CurrTarget;
          ANode.ImageIndex := CurrImage;
        end
        else if ANode.Level > ALevel then
        begin
          NextNode := ANode.Parent;
          while NextNode.Level > ALevel do
            NextNode := NextNode.Parent;
          ANode := Owner.AddChild(NextNode.Parent, CurrStr);
          ANode.FModule    := CurrModule;
          ANode.FTarget    := CurrTarget;
          ANode.ImageIndex := CurrImage;
        end
        else TreeViewErrorFmt(sInvalidLevelEx, [ALevel, CurrStr]);
      end;
    finally
      Owner.EndUpdate;
      List.Free;
    end;
  except
    Owner.Owner.Invalidate;  // force repaint on exception
    raise;
  end;
end;

procedure TTreeStrings.SaveTreeToStream(Stream: TStream);
const
  TabChar = #9;
  EndOfLine = #13#10;
var
  i: Integer;
  ANode: TjwTreeNode;
  NodeStr: string;
begin
  if Count > 0 then
  begin
    ANode := Owner[0];
    while ANode <> nil do
    begin
      NodeStr := '';
      for i := 0 to ANode.Level - 1 do NodeStr := NodeStr + TabChar;
      //NodeStr := NodeStr + ANode.Text + EndOfLine;
      NodeStr := NodeStr + ANode.Text + '|' + ANode.FModule + '|' + ANode.FTarget + '|' + IntToStr(ANode.ImageIndex) + EndOfLine;
      Stream.Write(Pointer(NodeStr)^, Length(NodeStr));
      ANode := ANode.GetNext;
    end;
  end;
end;

function TjwTreeNodes.AlphaSort(ARecurse: Boolean): Boolean;
begin
  Result := FOwner.AlphaSort(ARecurse);
end;

function TjwTreeNodes.CustomSort(SortProc: TTVCompare; Data: Integer; ARecurse: Boolean): Boolean;
begin
  Result := FOwner.CustomSort(SortProc, Data, ARecurse);
end;

{ TjwCustomTreeView }

constructor TjwCustomTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse] + [csDisplayDragImage, csReflector];
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FjwTreeNodes := CreateNodes;
  FBorderStyle := bsSingle;
  FShowButtons := True;
  FShowRoot := True;
  FShowLines := True;
  FHideSelection := True;
  FDragImage := TDragImageList.CreateSize(32, 32);
  FSaveIndent := -1;
  FSelections := TList.Create;
  FMultiSelect := False;
  FMultiSelectStyle := [msControlSelect];
  FChangeTimer := TTimer.Create(Self);
  FChangeTimer.Enabled := False;
  FChangeTimer.Interval := 0;
  FChangeTimer.OnTimer := OnChangeTimer;
  FCreateWndRestores := True;
  FToolTips := True;
  FEditInstance := MakeObjectInstance(EditWndProc);
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FStateChangeLink := TChangeLink.Create;
  FStateChangeLink.OnChange := ImageListChange;
end;

destructor TjwCustomTreeView.Destroy;
begin
  // the following should not be reduced to a FreeAndNil
  FjwTreeNodes.Free;
  FjwTreeNodes := nil;

  FSaveIndexes.Free;
  FSelections.Free;
  FChangeTimer.Free;
  FSaveItems.Free;
  FDragImage.Free;
  FMemStream.Free;
  FreeObjectInstance(FEditInstance);
  FImageChangeLink.Free;
  FStateChangeLink.Free;
  FCanvas.Free;
  FCanvas := nil;
  inherited Destroy;
end;

procedure TjwCustomTreeView.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  LineStyles: array[Boolean] of DWORD = (0, TVS_HASLINES);
  RootStyles: array[Boolean] of DWORD = (0, TVS_LINESATROOT);
  ButtonStyles: array[Boolean] of DWORD = (0, TVS_HASBUTTONS);
  EditStyles: array[Boolean] of DWORD = (TVS_EDITLABELS, 0);
  HideSelections: array[Boolean] of DWORD = (TVS_SHOWSELALWAYS, 0);
  DragStyles: array[TDragMode] of DWORD = (TVS_DISABLEDRAGDROP, 0);
  RTLStyles: array[Boolean] of DWORD = (0, TVS_RTLREADING);
  ToolTipStyles: array[Boolean] of DWORD = (TVS_NOTOOLTIPS, 0);
  AutoExpandStyles: array[Boolean] of DWORD = (0, TVS_SINGLEEXPAND);
  HotTrackStyles: array[Boolean] of DWORD = (0, TVS_TRACKSELECT);
  RowSelectStyles: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
begin
  InitCommonControl(ICC_TREEVIEW_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, WC_TREEVIEW);
  with Params do
  begin
    Style := Style or LineStyles[FShowLines] or BorderStyles[FBorderStyle] or
      RootStyles[FShowRoot] or ButtonStyles[FShowButtons] or
      EditStyles[FReadOnly] or HideSelections[FHideSelection] or
      DragStyles[DragMode] or RTLStyles[UseRightToLeftReading] or
      ToolTipStyles[FToolTips] or AutoExpandStyles[FAutoExpand] or
      HotTrackStyles[FHotTrack] or RowSelectStyles[FRowSelect];
    if Ctl3D and NewStyleControls and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TjwCustomTreeView.CreateWnd;
var
  I: Integer;
begin
  FStateChanging := False;
  inherited CreateWnd;
  TreeView_SetBkColor(Handle, ColorToRGB(Color));
  TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
  if FMemStream <> nil then
  begin
    Items.BeginUpdate;
    try
      Items.ReadData(FMemStream);
      Items.ReadExpandedState(FMemStream);
      FreeAndNil(FMemStream);
      SetTopItem(Items.GetNodeFromIndex(FSaveTopIndex));
      FSaveTopIndex := 0;
      if FSaveIndexes <> nil then
      begin
        for I := 0 to FSaveIndexes.Count - 1 do
          FSelections.Add(Items.GetNodeFromIndex(Integer(FSaveIndexes[I])));
        FreeAndNil(FSaveIndexes);
        ValidateSelection;
        SetSelected(Selections[0]);
      end
      else
        SetSelected(Items.GetNodeFromIndex(FSaveIndex));
      FSaveIndex := 0;
    finally
      Items.EndUpdate;
    end;
  end;
  if FSaveIndent <> -1 then
    Indent := FSaveIndent;
  if (Images <> nil) and Images.HandleAllocated then
    SetImageList(Images.Handle, TVSIL_NORMAL);
  if (StateImages <> nil) and StateImages.HandleAllocated then
    SetImageList(StateImages.Handle, TVSIL_STATE);
end;

procedure TjwCustomTreeView.DestroyWnd;
var
  Node: TjwTreeNode;
  I: Integer;
begin
  FStateChanging := True;
  if FCreateWndRestores and (Items.Count > 0) then
  begin
    FMemStream := TMemoryStream.Create;
    Items.WriteData(FMemStream);
    Items.WriteExpandedState(FMemStream);
    FMemStream.Position := 0;
    FSaveTopIndex := 0;
    FSaveIndex := 0;
    Node := GetTopItem;
    if Node <> nil then
      FSaveTopIndex := Node.AbsoluteIndex;
    Items.BeginUpdate;
    try
      if MultiSelect and (FSelections.Count > 1) then
      begin
        FSaveIndexes := TList.Create;
        for I := 0 to FSelections.Count - 1 do
          FSaveIndexes.Add(Pointer(TjwTreeNode(FSelections[I]).AbsoluteIndex));
        FSelections.Clear;
      end
      else
      begin
        Node := Selected;
        if Node <> nil then
          FSaveIndex := Node.AbsoluteIndex;
      end;
      Items.Clear;
    finally
      Items.EndUpdate;
    end;
  end;
  FSaveIndent := Indent;
  inherited DestroyWnd;
end;

procedure TjwCustomTreeView.EditWndProc(var Message: TMessage);
begin
  try
    with Message do
    begin
      case Msg of
        WM_KEYDOWN,
        WM_SYSKEYDOWN: if DoKeyDown(TWMKey(Message)) then Exit;
        WM_CHAR: if DoKeyPress(TWMKey(Message)) then Exit;
        WM_KEYUP,
        WM_SYSKEYUP: if DoKeyUp(TWMKey(Message)) then Exit;
        CN_KEYDOWN,
        CN_CHAR, CN_SYSKEYDOWN,
        CN_SYSCHAR:
          begin
            WndProc(Message);
            Exit;
          end;
      end;
      Result := CallWindowProc(FDefEditProc, FEditHandle, Msg, WParam, LParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TjwCustomTreeView.CMColorChanged(var Message: TMessage);
begin
  inherited;
  TreeView_SetBkColor(Handle, ColorToRGB(Color));
end;

procedure TjwCustomTreeView.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if FBorderStyle = bsSingle then RecreateWnd;
end;

procedure TjwCustomTreeView.CMFontChanged(var Message: TMessage);
begin
  inherited;
  TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
end;

procedure TjwCustomTreeView.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    Message.Msg := WM_SYSCOLORCHANGE;
    DefaultHandler(Message);
  end;
end;

function TjwCustomTreeView.AlphaSort(ARecurse: Boolean): Boolean;
begin
  Result := CustomSort(nil, 0, ARecurse);
end;

function TjwCustomTreeView.CustomSort(SortProc: TTVCompare; Data: Longint; ARecurse: Boolean = True): Boolean;
var
  SortCB: TTVSortCB;
  Node: TjwTreeNode;
begin
  Result := False;
  if HandleAllocated then
  begin
    with SortCB do
    begin
      if not Assigned(SortProc) then
        lpfnCompare := @DefaultTreeViewSort
      else
        lpfnCompare := SortProc;
      hParent := TVI_ROOT;
      lParam := Data;
      Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
    end;
    if ARecurse then
    begin
      Node := FjwTreeNodes.GetFirstNode;
      while Node <> nil do
      begin
        if Node.HasChildren then
          Node.CustomSort(SortProc, Data, True);
        Node := Node.GetNextSibling;
      end;
    end;
    Items.ClearCache;
  end;
end;

procedure TjwCustomTreeView.SetAutoExpand(Value: Boolean);
begin
  if FAutoExpand <> Value then
  begin
    FAutoExpand := Value;
    SetComCtlStyle(Self, TVS_SINGLEEXPAND, Value);
  end;
end;

procedure TjwCustomTreeView.SetHotTrack(Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    SetComCtlStyle(Self, TVS_TRACKSELECT, Value);
  end;
end;

procedure TjwCustomTreeView.SetRowSelect(Value: Boolean);
begin
  if FRowSelect <> Value then
  begin
    FRowSelect := Value;
    SetComCtlStyle(Self, TVS_FULLROWSELECT, Value);
  end;
end;

procedure TjwCustomTreeView.SetToolTips(Value: Boolean);
begin
  if FToolTips <> Value then
  begin
    FToolTips := Value;
    SetComCtlStyle(Self, TVS_NOTOOLTIPS, not Value);
  end;
end;

procedure TjwCustomTreeView.SetSortType(Value: TSortType);
begin
  if SortType <> Value then
  begin
    FSortType := Value;
    if ((SortType in [stData, stBoth]) and Assigned(OnCompare)) or
      (SortType in [stText, stBoth]) then
      AlphaSort;
  end;
end;

procedure TjwCustomTreeView.SetBorderStyle(Value: TBorderStyle);
begin
  if BorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TjwCustomTreeView.SetDragMode(Value: TDragMode);
begin
  if Value <> DragMode then
    SetComCtlStyle(Self, TVS_DISABLEDRAGDROP, Value = dmManual);
  inherited;
end;

procedure TjwCustomTreeView.SetButtonStyle(Value: Boolean);
begin
  if ShowButtons <> Value then
  begin
    FShowButtons := Value;
    SetComCtlStyle(Self, TVS_HASBUTTONS, Value);
  end;
end;

procedure TjwCustomTreeView.SetLineStyle(Value: Boolean);
begin
  if ShowLines <> Value then
  begin
    FShowLines := Value;
    SetComCtlStyle(Self, TVS_HASLINES, Value);
  end;
end;

procedure TjwCustomTreeView.SetRootStyle(Value: Boolean);
begin
  if ShowRoot <> Value then
  begin
    FShowRoot := Value;
    SetComCtlStyle(Self, TVS_LINESATROOT, Value);
  end;
end;

procedure TjwCustomTreeView.SetReadOnly(Value: Boolean);
begin
  if ReadOnly <> Value then
  begin
    FReadOnly := Value;
    SetComCtlStyle(Self, TVS_EDITLABELS, not Value);
  end;
end;

procedure TjwCustomTreeView.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
  begin
    FHideSelection := Value;
    SetComCtlStyle(Self, TVS_SHOWSELALWAYS, not Value);
    Invalidate;
  end;
end;

function TjwCustomTreeView.GetNodeAt(X, Y: Integer): TjwTreeNode;
var
  HitTest: TTVHitTestInfo;
begin
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    if TreeView_HitTest(Handle, HitTest) <> nil then
      Result := Items.GetNode(HitTest.hItem)
    else Result := nil;
  end;
end;

function TjwCustomTreeView.GetHitTestInfoAt(X, Y: Integer): THitTests;
var
  HitTest: TTVHitTestInfo;
begin
  Result := [];
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    TreeView_HitTest(Handle, HitTest);
    if (flags and TVHT_ABOVE) <> 0 then Include(Result, htAbove);
    if (flags and TVHT_BELOW) <> 0 then Include(Result, htBelow);
    if (flags and TVHT_NOWHERE) <> 0 then Include(Result, htNowhere);
    if (flags and TVHT_ONITEM) = TVHT_ONITEM then
      Include(Result, htOnItem)
    else
    begin
      if (flags and TVHT_ONITEM) <> 0 then Include(Result, htOnItem);
      if (flags and TVHT_ONITEMICON) <> 0 then Include(Result, htOnIcon);
      if (flags and TVHT_ONITEMLABEL) <> 0 then Include(Result, htOnLabel);
      if (flags and TVHT_ONITEMSTATEICON) <> 0 then Include(Result, htOnStateIcon);
    end;
    if (flags and TVHT_ONITEMBUTTON) <> 0 then Include(Result, htOnButton);
    if (flags and TVHT_ONITEMINDENT) <> 0 then Include(Result, htOnIndent);
    if (flags and TVHT_ONITEMRIGHT) <> 0 then Include(Result, htOnRight);
    if (flags and TVHT_TOLEFT) <> 0 then Include(Result, htToLeft);
    if (flags and TVHT_TORIGHT) <> 0 then Include(Result, htToRight);
  end;
end;

procedure TjwCustomTreeView.SetjwTreeNodes(Value: TjwTreeNodes);
begin
  Items.Assign(Value);
end;

procedure TjwCustomTreeView.SetIndent(Value: Integer);
begin
  if Value <> Indent then TreeView_SetIndent(Handle, Value);
end;

function TjwCustomTreeView.GetIndent: Integer;
begin
  Result := TreeView_GetIndent(Handle)
end;

procedure TjwCustomTreeView.FullExpand;
var
  Node: TjwTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Expand(True);
    Node := Node.GetNextSibling;
  end;
end;

procedure TjwCustomTreeView.FullCollapse;
var
  Node: TjwTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Collapse(True);
    Node := Node.GetNextSibling;
  end;
end;

procedure TjwCustomTreeView.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then FullExpand;
end;

function TjwCustomTreeView.GetTopItem: TjwTreeNode;
begin
  if HandleAllocated then
    Result := Items.GetNode(TreeView_GetFirstVisible(Handle))
  else Result := nil;
end;

procedure TjwCustomTreeView.SetTopItem(Value: TjwTreeNode);
begin
  if HandleAllocated and (Value <> nil) then
    TreeView_SelectSetFirstVisible(Handle, Value.ItemId);
end;

procedure TjwCustomTreeView.OnChangeTimer(Sender: TObject);
begin
  FChangeTimer.Enabled := False;
  Change(TjwTreeNode(FChangeTimer.Tag));
end;

function TjwCustomTreeView.GetSelected: TjwTreeNode;
begin
  if HandleAllocated then
  begin
    if FRightClickSelect and Assigned(FRClickNode) then
      Result := FRClickNode
    else
      Result := Items.GetNode(TreeView_GetSelection(Handle));
  end
  else Result := nil;
end;

procedure TjwCustomTreeView.SetSelected(Value: TjwTreeNode);
begin
  if Value <> nil then
    Value.Selected := True
  else
    TreeView_SelectItem(Handle, nil);
end;

procedure TjwCustomTreeView.SetChangeDelay(Value: Integer);
begin
  FChangeTimer.Interval := Value;
end;

function TjwCustomTreeView.GetChangeDelay: Integer;
begin
  Result := FChangeTimer.Interval;
end;

function TjwCustomTreeView.GetDropTarget: TjwTreeNode;
begin
  if HandleAllocated then
  begin
    Result := Items.GetNode(TreeView_GetDropHilite(Handle));
    if Result = nil then Result := FLastDropTarget;
  end
  else Result := nil;
end;

procedure TjwCustomTreeView.SetDropTarget(Value: TjwTreeNode);
begin
  if HandleAllocated then
    if Value <> nil then Value.DropTarget := True
    else TreeView_SelectDropTarget(Handle, nil);
end;

function TjwCustomTreeView.GetNodeFromItem(const Item: TTVItem): TjwTreeNode;
begin
  Result := nil;
  if Items <> nil then
    with Item do
      if (state and TVIF_PARAM) <> 0 then
        Result := Pointer(lParam)
      else
        Result := Items.GetNode(hItem);
end;

function TjwCustomTreeView.IsEditing: Boolean;
var
  ControlHand: HWnd;
begin
  ControlHand := TreeView_GetEditControl(Handle);
  Result := (ControlHand <> 0) and IsWindowVisible(ControlHand);
end;

procedure TjwCustomTreeView.CNNotify(var Message: TWMNotify);
var
  Node: TjwTreeNode;
  MousePos: TPoint;
  R: TRect;
  DefaultDraw, PaintImages: Boolean;
  TmpItem: TTVItem;
  LogFont: TLogFont;
begin
  with Message do
    case NMHdr^.code of
      NM_CUSTOMDRAW:
        if Assigned(FCanvas) then
          with PNMCustomDraw(NMHdr)^ do
          begin
            FCanvas.Lock;
            try
              Result := CDRF_DODEFAULT;
              if (dwDrawStage and CDDS_ITEM) = 0 then
              begin
                R := ClientRect;
                case dwDrawStage of
                  CDDS_PREPAINT:
                  begin
                    if IsCustomDrawn(dtControl, cdPrePaint) then
                    begin
                      try
                        FCanvas.Handle := hdc;
                        FCanvas.Font := Font;
                        FCanvas.Brush := Brush;
                        DefaultDraw := CustomDraw(R, cdPrePaint);
                      finally
                        FCanvas.Handle := 0;
                      end;
                      if not DefaultDraw then
                      begin
                        Result := CDRF_SKIPDEFAULT;
                        Exit;
                      end;
                    end;
                    if IsCustomDrawn(dtItem, cdPrePaint) or IsCustomDrawn(dtItem, cdPreErase) then
                      Result := Result or CDRF_NOTIFYITEMDRAW;
                    if IsCustomDrawn(dtItem, cdPostPaint) then
                      Result := Result or CDRF_NOTIFYPOSTPAINT;
                    if IsCustomDrawn(dtItem, cdPostErase) then
                      Result := Result or CDRF_NOTIFYPOSTERASE;
                  end;
                  CDDS_POSTPAINT:
                    if IsCustomDrawn(dtControl, cdPostPaint) then
                      CustomDraw(R, cdPostPaint);
                  CDDS_PREERASE:
                    if IsCustomDrawn(dtControl, cdPreErase) then
                      CustomDraw(R, cdPreErase);
                  CDDS_POSTERASE:
                    if IsCustomDrawn(dtControl, cdPostErase) then
                      CustomDraw(R, cdPostErase);
                end;
              end else
              begin
                FillChar(TmpItem, SizeOf(TmpItem), 0);
                TmpItem.hItem := HTREEITEM(dwItemSpec);
                Node := GetNodeFromItem(TmpItem);
                if Node = nil then Exit;
                case dwDrawStage of
                  CDDS_ITEMPREPAINT:
                    begin
                      // release the font we may have loaned during item drawing.
                      if (dwDrawStage and CDDS_ITEMPOSTPAINT <> 0) and
                         (FOurFont + FStockFont <> 0) then
                      begin
                        SelectObject(hdc, FStockFont);
                        DeleteObject(FOurFont);
                        FOurFont := 0;
                        FStockFont := 0;
                      end;

                      try
                        FCanvas.Handle := hdc;
                        FCanvas.Font := Font;
                        FCanvas.Brush := Brush;
                        // Unlike the list view, the tree view doesn't override the text
                        //  foreground and background colors of selected items.
                        if uItemState and CDIS_SELECTED <> 0 then
                        begin
                          FCanvas.Font.Color := clHighlightText;
                          FCanvas.Brush.Color := clHighlight;
                        end;
                        FCanvas.Font.OnChange := CanvasChanged;
                        FCanvas.Brush.OnChange := CanvasChanged;
                        FCanvasChanged := False;
                        DefaultDraw := CustomDrawItem(Node,
                          TCustomDrawState(Word(uItemState)), cdPrePaint, PaintImages);
                        if not PaintImages then
                          Result := Result or TVCDRF_NOIMAGES;
                        if not DefaultDraw then
                          Result := Result or CDRF_SKIPDEFAULT
                        else if FCanvasChanged then
                        begin
                          FCanvasChanged := False;
                          FCanvas.Font.OnChange := nil;
                          FCanvas.Brush.OnChange := nil;
                          with PNMTVCustomDraw(NMHdr)^ do
                          begin
                            clrText := ColorToRGB(FCanvas.Font.Color);
                            clrTextBk := ColorToRGB(FCanvas.Brush.Color);
                            if GetObject(FCanvas.Font.Handle, SizeOf(LogFont), @LogFont) <> 0 then
                            begin
                              FCanvas.Handle := 0;  // disconnect from hdc
                              // don't delete the stock font
                              FOurFont := CreateFontIndirect(LogFont);
                              FStockFont := SelectObject(hdc, FOurFont);
                              Result := Result or CDRF_NEWFONT;
                            end;
                          end;
                        end;
                        if IsCustomDrawn(dtItem, cdPostPaint) then
                          Result := Result or CDRF_NOTIFYPOSTPAINT;
                      finally
                        FCanvas.Handle := 0;
                      end;
                    end;
                  CDDS_ITEMPOSTPAINT:
                      if IsCustomDrawn(dtItem, cdPostPaint) then
                        CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPostPaint, PaintImages);
                  CDDS_ITEMPREERASE:
                      if IsCustomDrawn(dtItem, cdPreErase) then
                        CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPreErase, PaintImages);
                  CDDS_ITEMPOSTERASE:
                      if IsCustomDrawn(dtItem, cdPostErase) then
                        CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPostErase, PaintImages);
                end;
              end;
            finally
              FCanvas.Unlock;
            end;
          end;
      TVN_BEGINDRAG:
        begin
          FDragged := True;
          with PNMTreeView(NMHdr)^ do
            FDragNode := GetNodeFromItem(ItemNew);
        end;
      TVN_BEGINLABELEDIT:
        begin
          with PTVDispInfo(NMHdr)^ do
            if Dragging or not CanEdit(GetNodeFromItem(item)) then
              Result := 1;
          if Result = 0 then
          begin
            FEditHandle := TreeView_GetEditControl(Handle);
            FDefEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
            SetWindowLong(FEditHandle, GWL_WNDPROC, LongInt(FEditInstance));
          end;
        end;
      TVN_ENDLABELEDIT: Edit(PTVDispInfo(NMHdr)^.item);
      TVN_ITEMEXPANDING:
        if not FManualNotify then
        begin
          with PNMTreeView(NMHdr)^ do
          begin
            Node := GetNodeFromItem(ItemNew);
            if (action = TVE_EXPAND) and not CanExpand(Node) then
              Result := 1
            else if (action = TVE_COLLAPSE) and
              not CanCollapse(Node) then Result := 1;
          end;
        end;
      TVN_ITEMEXPANDED:
        if not FManualNotify then
        begin
          with PNMTreeView(NMHdr)^ do
          begin
            Node := GetNodeFromItem(itemNew);
            if (action = TVE_EXPAND) then Expand(Node)
            else if (action = TVE_COLLAPSE) then Collapse(Node);
          end;
        end;
      TVN_SELCHANGINGA, TVN_SELCHANGINGW:
        if not CanChange(GetNodeFromItem(PNMTreeView(NMHdr)^.itemNew)) then
          Result := 1;
      TVN_SELCHANGEDA, TVN_SELCHANGEDW:
        with PNMTreeView(NMHdr)^ do
          if FChangeTimer.Interval > 0 then
          with FChangeTimer do
          begin
            Enabled := False;
            Tag := Integer(GetNodeFromItem(itemNew));
            Enabled := True;
          end
          else
            Change(GetNodeFromItem(itemNew));
      TVN_DELETEITEM:
        begin
          Node := GetNodeFromItem(PNMTreeView(NMHdr)^.itemOld);
          if Node <> nil then
          begin
            Node.FItemId := nil;
            FChangeTimer.Enabled := False;
            if FStateChanging then
              Node.Delete
            else
              Items.Delete(Node);
          end;
        end;
      TVN_SETDISPINFO:
        with PTVDispInfo(NMHdr)^ do
        begin
          Node := GetNodeFromItem(item);
          if (Node <> nil) and ((item.mask and TVIF_TEXT) <> 0) then
            Node.Text := item.pszText;
        end;
      TVN_GETDISPINFO:
        with PTVDispInfo(NMHdr)^ do
        begin
          Node := GetNodeFromItem(item);
          if Node <> nil then
          begin
            if (item.mask and TVIF_TEXT) <> 0 then
              StrLCopy(item.pszText, PChar(Node.Text), item.cchTextMax - 1);
            if (item.mask and TVIF_IMAGE) <> 0 then
            begin
              GetImageIndex(Node);
              item.iImage := Node.ImageIndex;
            end;
            if (item.mask and TVIF_SELECTEDIMAGE) <> 0 then
            begin
              GetSelectedIndex(Node);
              item.iSelectedImage := Node.SelectedIndex;
            end;
          end;
        end;
      NM_RCLICK:
        begin
          FRClickNode := nil;
          GetCursorPos(MousePos);
          if RightClickSelect then
            with PointToSmallPoint(ScreenToClient(MousePos)) do
            begin
              FRClickNode := GetNodeAt(X, Y);
              Perform(WM_CONTEXTMENU, Handle, Integer(PointToSmallPoint(MousePos)));
              FRClickNode := nil;
            end
          else
            // Win95/98 eat WM_CONTEXTMENU when posted to the message queue  
            PostMessage(Handle, CN_BASE+WM_CONTEXTMENU, Handle, Integer(PointToSmallPoint(MousePos)));
          Message.Result := 1;  // tell treeview not to perform default response
        end;
    end;
end;

function TjwCustomTreeView.GetDragImages: TDragImageList;
begin
  if FDragImage.Count > 0 then
    Result := FDragImage else
    Result := nil;
end;

procedure TjwCustomTreeView.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and
    (DragMode = dmAutomatic) and (DragKind = dkDrag) then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else if Message.Msg = CN_BASE+WM_CONTEXTMENU then
    Message.Result := Perform(WM_CONTEXTMENU, Message.WParam, Message.LParam)
  else inherited WndProc(Message);
end;

procedure TjwCustomTreeView.DoStartDrag(var DragObject: TDragObject);
var
  ImageHandle: HImageList;
  DragNode: TjwTreeNode;
  P: TPoint;
begin
  inherited DoStartDrag(DragObject);
  DragNode := FDragNode;
  FLastDropTarget := nil;
  FDragNode := nil;
  if DragNode = nil then
  begin
    GetCursorPos(P);
    with ScreenToClient(P) do DragNode := GetNodeAt(X, Y);
  end;
  if DragNode <> nil then
  begin
    ImageHandle := TreeView_CreateDragImage(Handle, DragNode.ItemId);
    if ImageHandle <> 0 then
      with FDragImage do
      begin
        Handle := ImageHandle;
        SetDragImage(0, 2, 2);
      end;
  end;
end;

procedure TjwCustomTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FLastDropTarget := nil;
end;

procedure TjwCustomTreeView.CMDrag(var Message: TCMDrag);
begin
  inherited;
  with Message, DragRec^ do
    case DragMessage of
      dmDragMove:
        with ScreenToClient(Pos) do
          DoDragOver(Source, X, Y, Message.Result <> 0);
      dmDragLeave:
        begin
          TDragObject(Source).HideDragImage;
          FLastDropTarget := DropTarget;
          DropTarget := nil;
          TDragObject(Source).ShowDragImage;
        end;
      dmDragDrop: FLastDropTarget := nil;
    end;
end;

procedure TjwCustomTreeView.DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
var
  Node: TjwTreeNode;
begin
  Node := GetNodeAt(X, Y);
  if (Node <> nil) and
    ((Node <> DropTarget) or (Node = FLastDropTarget)) then
  begin
    FLastDropTarget := nil;
    TDragObject(Source).HideDragImage;
    Node.DropTarget := True;
    TDragObject(Source).ShowDragImage;
  end;
end;

procedure TjwCustomTreeView.GetImageIndex(Node: TjwTreeNode);
begin
  if Assigned(FOnGetImageIndex) then FOnGetImageIndex(Self, Node);
end;

procedure TjwCustomTreeView.GetSelectedIndex(Node: TjwTreeNode);
begin
  if Assigned(FOnGetSelectedIndex) then FOnGetSelectedIndex(Self, Node);
end;

function TjwCustomTreeView.CanChange(Node: TjwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) then FOnChanging(Self, Node, Result);
end;

procedure TjwCustomTreeView.Change(Node: TjwTreeNode);
begin
  FSelectChanged := True;
  FinishSelection(Selected, KeyDataToShiftState(0) + [ssLeft]);
  if Assigned(FOnChange) then FOnChange(Self, Node);
end;

procedure TjwCustomTreeView.Added(Node: TjwTreeNode);
begin
  if Assigned(FOnAddition) then FOnAddition(Self, Node);
end;

procedure TjwCustomTreeView.Delete(Node: TjwTreeNode);
begin
  if Assigned(FOnDeletion) then FOnDeletion(Self, Node);
end;

procedure TjwCustomTreeView.Expand(Node: TjwTreeNode);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, Node);
end;

function TjwCustomTreeView.CanExpand(Node: TjwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnExpanding) then FOnExpanding(Self, Node, Result);
end;

procedure TjwCustomTreeView.Collapse(Node: TjwTreeNode);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, Node);
end;

function TjwCustomTreeView.CanCollapse(Node: TjwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, Node, Result);
end;

function TjwCustomTreeView.CanEdit(Node: TjwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then FOnEditing(Self, Node, Result);
end;

procedure TjwCustomTreeView.Edit(const Item: TTVItem);
var
  S: string;
  Node: TjwTreeNode;
begin
  with Item do
  begin
    Node := GetNodeFromItem(Item);
    if pszText <> nil then
    begin
      S := pszText;
      Node := GetNodeFromItem(Item);
      if Assigned(FOnEdited) then FOnEdited(Self, Node, S);
      if Node <> nil then Node.Text := S;
    end
    else if Assigned(FOnCancelEdit) then FOnCancelEdit(Self, Node);
  end;
end;

function TjwCustomTreeView.CreateNode: TjwTreeNode;
var
  LClass: TjwTreeNodeClass;
begin
  LClass := TjwTreeNode;
  if Assigned(FOnCreateNodeClass) then
    FOnCreateNodeClass(Self, LClass);
  Result := LClass.Create(Items);
end;

function TjwCustomTreeView.CreateNodes: TjwTreeNodes;
begin
  Result := TjwTreeNodes.Create(Self);
end;

procedure TjwCustomTreeView.SetImageList(Value: HImageList; Flags: Integer);
begin
  if HandleAllocated then TreeView_SetImageList(Handle, Value, Flags);
end;

procedure TjwCustomTreeView.ImageListChange(Sender: TObject);
var
  ImageHandle: HImageList;
begin
  if HandleAllocated then
  begin
    if TCustomImageList(Sender).HandleAllocated then
      ImageHandle := TCustomImageList(Sender).Handle
    else
      ImageHandle := 0;
    if Sender = Images then
      SetImageList(ImageHandle, TVSIL_NORMAL)
    else if Sender = StateImages then
      SetImageList(ImageHandle, TVSIL_STATE);
  end;
end;

procedure TjwCustomTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = StateImages then StateImages := nil;
  end;
end;

procedure TjwCustomTreeView.SetImages(Value: TCustomImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Images.FreeNotification(Self);
    SetImageList(Images.Handle, TVSIL_NORMAL)
  end
  else SetImageList(0, TVSIL_NORMAL);
end;

procedure TjwCustomTreeView.SetStateImages(Value: TCustomImageList);
begin
  if StateImages <> nil then
    StateImages.UnRegisterChanges(FStateChangeLink);
  FStateImages := Value;
  if StateImages <> nil then
  begin
    StateImages.RegisterChanges(FStateChangeLink);
    StateImages.FreeNotification(Self);
    SetImageList(StateImages.Handle, TVSIL_STATE)
  end
  else SetImageList(0, TVSIL_STATE);
end;

procedure TjwCustomTreeView.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TjwCustomTreeView.LoadFromStream(Stream: TStream);
begin
  with TTreeStrings.Create(Items) do
    try
      LoadTreeFromStream(Stream);
    finally
      Free;
  end;
end;

procedure TjwCustomTreeView.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TjwCustomTreeView.SaveToStream(Stream: TStream);
begin
  with TTreeStrings.Create(Items) do
    try
      SaveTreeToStream(Stream);
    finally
      Free;
  end;
end;

procedure TjwCustomTreeView.WMContextMenu(var Message: TWMContextMenu);
var
  R: TRect;
begin
  SetFocus;
  if (Message.XPos < 0) and (Selected <> nil) then
  begin
    R := Selected.DisplayRect(True);
    Message.Pos := PointToSmallPoint(ClientToScreen(Point(R.Left, R.Bottom)));
  end;
  inherited;
  //MouseUp(mbRight, KeyboardStateToShiftState, Message.Pos.X, Message.Pos.Y);
end;

procedure TjwCustomTreeView.WMLButtonDown(var Message: TWMLButtonDown);
var
  Node: TjwTreeNode;
  MousePos: TPoint;
begin
  FDragged := False;
  FDragNode := nil;
  try
    inherited;
    if (DragMode = dmAutomatic) and (DragKind = dkDrag) then
    begin
      SetFocus;
      if not FDragged then
      begin
        GetCursorPos(MousePos);
        with PointToSmallPoint(ScreenToClient(MousePos)) do
          Perform(WM_LBUTTONUP, 0, MakeLong(X, Y));
      end
      else begin
        Node := GetNodeAt(Message.XPos, Message.YPos);
        if Node <> nil then
        begin
          Node.Focused := True;
          Node.Selected := True;
          BeginDrag(False);
        end;
      end;
    end;
  finally
    FDragNode := nil;
  end;
end;

procedure TjwCustomTreeView.WMNotify(var Message: TWMNotify);
var
  Node: TjwTreeNode;
  MaxTextLen: Integer;
  Pt: TPoint;
begin
  with Message do
    if NMHdr^.code = TTN_NEEDTEXTW then
    begin
      // Work around NT COMCTL32 problem with tool tips >= 80 characters
      GetCursorPos(Pt);
      Pt := ScreenToClient(Pt);
      Node := GetNodeAt(Pt.X, Pt.Y);
      if (Node = nil) or (Node.Text = '') or
        (PToolTipTextW(NMHdr)^.uFlags and TTF_IDISHWND = 0) then Exit;
      if (GetComCtlVersion >= ComCtlVersionIE4) and (Length(Node.Text) < 80) then
      begin
        inherited;
        Exit;
      end;
      FWideText := Node.Text;
      MaxTextLen := SizeOf(PToolTipTextW(NMHdr)^.szText) div SizeOf(WideChar);
      if Length(FWideText) >= MaxTextLen then
        SetLength(FWideText, MaxTextLen - 1);
      PToolTipTextW(NMHdr)^.lpszText := PWideChar(FWideText);
      FillChar(PToolTipTextW(NMHdr)^.szText, MaxTextLen, 0);
      Move(Pointer(FWideText)^, PToolTipTextW(NMHdr)^.szText, Length(FWideText) * SizeOf(WideChar));
      PToolTipTextW(NMHdr)^.hInst := 0;
      SetWindowPos(NMHdr^.hwndFrom, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or
        SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER);
      Result := 1;
    end
    else inherited;
end;

{ CustomDraw support }

procedure TjwCustomTreeView.CanvasChanged;
begin
  FCanvasChanged := True;
end;

function TjwCustomTreeView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  { Tree view doesn't support erase notifications }
  if Stage = cdPrePaint then
  begin
    if Target = dtItem then
      Result := Assigned(FOnCustomDrawItem) or Assigned(FOnAdvancedCustomDrawItem)
    else if Target = dtControl then
      Result := Assigned(FOnCustomDraw) or Assigned(FOnAdvancedCustomDraw) or
        Assigned(FOnCustomDrawItem) or Assigned(FOnAdvancedCustomDrawItem)
    else
      Result := False;
  end
  else
  begin
    if Target = dtItem then
      Result := Assigned(FOnAdvancedCustomDrawItem)
    else if Target = dtControl then
      Result := Assigned(FOnAdvancedCustomDraw) or Assigned(FOnAdvancedCustomDrawItem)
    else
      Result := False;
  end;
end;

function TjwCustomTreeView.CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean;
begin
  Result := True;
  if (Stage = cdPrePaint) and Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ARect, Result);
  if Assigned(FOnAdvancedCustomDraw) then FOnAdvancedCustomDraw(Self, ARect, Stage, Result);
end;

function TjwCustomTreeView.CustomDrawItem(Node: TjwTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean;
begin
  Result := True;
  PaintImages := True;
  if (Stage = cdPrePaint) and Assigned(FOnCustomDrawItem) then FOnCustomDrawItem(Self, Node, State, Result);
  if Assigned(FOnAdvancedCustomDrawItem) then FOnAdvancedCustomDrawItem(Self, Node, State, Stage, PaintImages, Result);
end;

procedure TjwCustomTreeView.ClearSelection(KeepPrimary: Boolean);
var
  I: Integer;
begin
  for I := FSelections.Count - 1 downto 1 do
    NodeDeselect(I);
  if not KeepPrimary then
    Selected := nil;
end;

procedure TjwCustomTreeView.ControlSelectNode(Node: TjwTreeNode);
var
  I: Integer;
begin
  if msControlSelect in MultiSelectStyle then
  begin
    if (Node <> Selected) and ((Node = nil) or (not Node.Deleting)) then
      Selected := Node;
    I := FSelections.IndexOf(Node);
    if I <> -1 then
      NodeDeselect(I)
    else 
      NodeSelect(Node);
  end
  else
    SelectNode(Node);
end;

procedure TjwCustomTreeView.ControlShiftSelectNode(Node: TjwTreeNode;
  Backward: Boolean);
begin
  ShiftSelectNode(Node, Backward, not (msControlSelect in MultiSelectStyle));
end;

procedure TjwCustomTreeView.DoEnter;
begin
  InvalidateSelectionsRects;
  inherited;
end;

procedure TjwCustomTreeView.DoExit;
begin
  inherited;
  InvalidateSelectionsRects;
end;

procedure TjwCustomTreeView.FinishSelection(Node: TjwTreeNode;
  ShiftState: TShiftState);
var
  LNode: TjwTreeNode;
  LBackward: Boolean;
begin
  if not FSelecting and (ssLeft in ShiftState) then
  try
    FSelecting := True;
    if not (ssShift in ShiftState) then
      FShiftAnchor := nil;

    // what to do?
    if MultiSelect and (Node <> nil) then
      if ssShift in ShiftState then
      begin

        // figure out the shift anchor
        if (FShiftAnchor = nil) and
           (FSelections.Count > 0) then
          FShiftAnchor := Selections[0];
        if FShiftAnchor = nil then
        begin
          LNode := Items.GetFirstNode;
          if not LNode.IsVisible then
            LNode := LNode.GetNextVisible;
          while LNode <> nil do
          begin
            if LNode.Focused then
            begin
              FShiftAnchor := LNode;
              Break;
            end;
            LNode := LNode.GetNextVisible;
          end;
        end;
        LBackward := (FShiftAnchor <> nil) and
                     (Node.AbsoluteIndex < FShiftAnchor.AbsoluteIndex);

        // which way do we go?
        if ssCtrl in ShiftState then
          ControlShiftSelectNode(Node, LBackward)
        else
          ShiftSelectNode(Node, LBackward);
      end
      else

      // no shift, no problem
      begin
        if ssCtrl in ShiftState then
          ControlSelectNode(Node)
        else if FSelections.IndexOf(Node) <> -1 then
        begin
          if FSelections[0] <> Node then
          begin
            FSelections.Remove(Node);
            NodeSelect(Node, 0);
          end;
        end
        else
          SelectNode(Node);
      end
    else
      SelectNode(Node);

    // all is swell?
    ValidateSelection;
  finally
    FSelecting := False;
  end;
end;

function TjwCustomTreeView.GetSelectionCount: Cardinal;
begin
  Result := FSelections.Count
end;

function TjwCustomTreeView.GetSelection(Index: Integer): TjwTreeNode;
begin
  Result := TjwTreeNode(FSelections[Index])
end;

procedure TjwCustomTreeView.InvalidateSelectionsRects;
var
  I: Integer;
  LRect: TRect;
begin
  for I := 0 to FSelections.Count - 1 do
  begin
    LRect := Selections[I].DisplayRect(False);
    InvalidateRect(Handle, @LRect, False);
  end;
end;

procedure TjwCustomTreeView.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    if FSelectChanged then
      FSelectChanged := False
    else if htOnItem in GetHitTestInfoAt(X, Y) then
      FinishSelection(Selected, Shift)
    else
      ValidateSelection;
  inherited;
end;

procedure TjwCustomTreeView.NodeDeselect(Index: Integer);
begin
  Selections[Index].SetSelectedBit(False);
  FSelections.Delete(Index);
end;

procedure TjwCustomTreeView.NodeSelect(Node: TjwTreeNode; At: Integer);
begin
  if (Node <> nil) and not Node.Deleting then
  begin
    FSelections.Insert(At, Node);
    Node.SetSelectedBit(True);
  end;
end;

procedure TjwCustomTreeView.Select(Node: TjwTreeNode; ShiftState: TShiftState);
begin
  FinishSelection(Node, ShiftState + [ssLeft]);
end;

procedure TjwCustomTreeView.SelectNode(Node: TjwTreeNode);
var
  I: Integer;
begin
  for I := FSelections.Count - 1 downto 0 do
    if Selections[I] <> Node then
      NodeDeselect(I);
  if (Node <> Selected) and ((Node = nil) or (not Node.Deleting))then
    Selected := Node;
  if (Node <> nil) and (not Node.Deleting) and
     (FSelections.Count = 0) then
    NodeSelect(Node);
end;

procedure TjwCustomTreeView.SetMultiSelect(const Value: Boolean);
begin
  if Value <> MultiSelect then
  begin
    if not Value then
      SelectNode(Selected);
    FMultiSelect := Value;
    ValidateSelection;
  end;
end;

procedure TjwCustomTreeView.SetMultiSelectStyle(const Value: TMultiSelectStyle);
begin
  if Value <> MultiSelectStyle then
  begin
    FMultiSelectStyle := Value;
    ValidateSelection;
  end;
end;

procedure TjwCustomTreeView.ShiftSelectNode(Node: TjwTreeNode; Backward,
  Deselect: Boolean);
var
  LNode: TjwTreeNode;
  LSelect, LDeselect: TList;
  I: Integer;
begin
  if (Node <> nil) and (not Node.Deleting) and (msShiftSelect in MultiSelectStyle) then
  begin
    LSelect := TList.Create;
    LDeselect := TList.Create;
    try
      LNode := FShiftAnchor;
      if LNode <> Node then
        while LNode <> nil do
        begin
          LSelect.Add(LNode);
          if Backward then
            if msVisibleOnly in MultiSelectStyle then
              LNode := LNode.GetPrevVisible
            else
              LNode := LNode.GetPrev
          else
            if msVisibleOnly in MultiSelectStyle then
              LNode := LNode.GetNextVisible
            else
              LNode := LNode.GetNext;
          if LNode = Node then
          begin
            LSelect.Add(LNode);
            Break;
          end;
        end;

      if Deselect then
      begin
        //LDeselect.Assign(FSelections, laSrcUnique, LSelect);
        if LDeselect.Count > 0 then
          for I := FSelections.Count - 1 downto 0 do
            if LDeselect.IndexOf(FSelections[I]) <> -1 then
              NodeDeselect(I);
      end;

      //LSelect.Assign(FSelections, laSrcUnique);
      for I := 0 to LSelect.Count - 1 do
        NodeSelect(TjwTreeNode(LSelect[I]));

      I := FSelections.IndexOf(Node);
      if I > 0 then
      begin
        FSelections.Delete(I);
        FSelections.Insert(0, Node);
      end
      else
        if I = -1 then
          NodeSelect(Node);
    finally
      LDeselect.Free;
      LSelect.Free;
    end;
  end
  else
    SelectNode(Node);
end;

{procedure TjwCustomTreeView.Subselect(Node: TjwTreeNode; Validate: Boolean);
begin
  if not MultiSelect then
    raise ETreeViewError.Create(SMultiSelectRequired);
  if (Node <> nil) and (not Node.Deleting) then
  begin
    if FSelections.IndexOf(Node) = -1 then
      NodeSelect(Node, 1);
    if Validate then
      ValidateSelection;
  end;
end;}

procedure TjwCustomTreeView.ValidateSelection;
var
  I: Integer;
  LPrimary, LNode: TjwTreeNode;
begin
  if FSelections.Count > 0 then
  begin
    LPrimary := Selections[0];
    for I := FSelections.Count - 1 downto 0 do
    begin
      LNode := Selections[I];
      if (LNode.Deleting) or
         ((I <> 0) and
          (not MultiSelect) or
          ((msVisibleOnly in MultiSelectStyle) and (not LNode.IsVisible)) or
          ((msSiblingOnly in MultiSelectStyle) and (LNode.Parent <> LPrimary.Parent))) then
        NodeDeselect(I)
      else if not LNode.Selected then
        LNode.SetSelectedBit(True);
    end;
  end;
end;

procedure TjwCustomTreeView.Select(const Nodes: array of TjwTreeNode);
var
  LList: TList;
  I: Integer;
begin
  LList := TList.Create;
  try
    for I := Low(Nodes) to High(Nodes) do
      if not Nodes[I].Deleting then
        LList.Add(Nodes[I]);
    Select(LList);
  finally
    LList.Free;
  end;
end;

procedure TjwCustomTreeView.Select(Nodes: TList);
var
  LSelect, LDeselect: TList;
  I: Integer;
begin
  if Nodes.Count = 0 then
    ClearSelection
  else
  begin
    LSelect := TList.Create;
    LDeselect := TList.Create;
    try
      // remove any nodes that are about to not be
      for I := Nodes.Count - 1 downto 0 do
        if TjwTreeNode(Nodes[I]).Deleting then
          Nodes.Delete(I);

      // make sure the Selected item is the first item
      if Nodes.Count > 0 then
        if Selected <> TjwTreeNode(Nodes[0]) then
          Selected := TjwTreeNode(Nodes[0]);

      // what needs to be deselected?
      //LDeselect.Assign(FSelections, laSrcUnique, Nodes);
      if LDeselect.Count > 0 then
        for I := FSelections.Count - 1 downto 0 do
          if LDeselect.IndexOf(FSelections[I]) <> -1 then
            NodeDeselect(I);

      // what needs to be selected?
      //LSelect.Assign(Nodes, laSrcUnique, FSelections);
      for I := 0 to LSelect.Count - 1 do
        NodeSelect(TjwTreeNode(LSelect[I]));

      // ok lets get the order right!
      //FSelections.Assign(Nodes);
    finally
      LDeselect.Free;
      LSelect.Free;
    end;
  end;

  // show the world what we just did
  ValidateSelection;
end;

procedure TjwCustomTreeView.Deselect(Node: TjwTreeNode);
begin
  if FSelections.IndexOf(Node) <> -1 then
    ControlSelectNode(Node);
end;

function TjwCustomTreeView.FindNextToSelect: TjwTreeNode;
var
  LNodes: TList;

  function NodeInList(ANode: TjwTreeNode): Boolean;
  begin
    // return true only if node (or one of its parents) is not in the list
    while Assigned(ANode) do
      if LNodes.IndexOf(ANode) = -1 then
        ANode := ANode.Parent
      else
        Break;
    Result := Assigned(ANode);
  end;

  function SiblingNotInList(ANode: TjwTreeNode): TjwTreeNode;
  begin
    // if a succeeding sibling of the primary is not selected then select it
    Result := ANode.GetNextSibling;
    while Assigned(Result) do
      if NodeInList(Result) then
        Result := Result.GetNextSibling
      else
        Break;

    // next didn't work, try previous instead
    if Result = nil then
    begin
      Result := ANode.GetPrevSibling;
      while Assigned(Result) do
        if NodeInList(Result) then
          Result := Result.GetPrevSibling
        else
          Break;
    end;
  end;
var
  LSelected: TjwTreeNode;
begin
  LNodes := TList.Create;
  try
    // what is selected?
    LSelected := GetSelections(LNodes);
    Result := LSelected;

    // if the selected one is really selected then continue, otherwise return it
    while Assigned(LSelected) and LSelected.Selected do
    begin
      Result := SiblingNotInList(LSelected);
      if Result = nil then
        LSelected := LSelected.Parent
      else
        Break;
      Result := LSelected;
    end;
  finally
    LNodes.Free;
  end;
end;

function TjwCustomTreeView.GetSelections(AList: TList): TjwTreeNode;
var
  I: Integer;
begin
  with AList do
  begin
    Clear;
    for I := 0 to SelectionCount - 1 do
      Add(Selections[I]);
    Result := Selected;
  end;
end;

end.
