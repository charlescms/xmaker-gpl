[TEdit]
constructor Create(AOwner: TComponent)
function GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer
procedure Clear; virtual
procedure ClearSelection
procedure ClearUndo
procedure CopyToClipboard
procedure CutToClipboard
procedure DefaultHandler(var Message)
procedure PasteFromClipboard
procedure SelectAll
procedure SetSelTextBuf(Buffer: PChar)
procedure Undo
property Anchors
property AutoSelect
property AutoSize
property BiDiMode
property BorderStyle
property CanUndo: Boolean
property CharCase
property Color
property Constraints
property Ctl3D
property DragCursor
property DragKind
property DragMode
property Enabled
property Font
property HideSelection
property ImeMode
property ImeName
property MaxLength
property Modified: Boolean
property OEMConvert
property OnChange
property OnClick
property OnDblClick
property OnDragDrop
property OnDragOver
property OnEndDock
property OnEndDrag
property OnEnter
property OnExit
property OnKeyDown
property OnKeyPress
property OnKeyUp
property OnMouseDown
property OnMouseMove
property OnMouseUp
property OnStartDock
property OnStartDrag
property ParentBiDiMode
property ParentColor
property ParentCtl3D
property ParentFont
property ParentShowHint
property PasswordChar
property PopupMenu
property ReadOnly
property SelLength: Integer
property SelStart: Integer
property SelText: string
property ShowHint
property TabOrder
property TabStop
property TabStop
property Text
property Text
property Visible
[TGroupBox]
constructor Create(AOwner: TComponent)
property Align
property Anchors
property BiDiMode
property Caption
property Color
property Constraints
property Ctl3D
property DockSite
property DragCursor
property DragKind
property DragMode
property Enabled
property Font
property OnClick
property OnDblClick
property OnDockDrop
property OnDockOver
property OnDragDrop
property OnDragOver
property OnEndDock
property OnEndDrag
property OnEnter
property OnExit
property OnGetSiteInfo
property OnMouseDown
property OnMouseMove
property OnMouseUp
property OnStartDock
property OnStartDrag
property OnUnDock
property ParentBiDiMode
property ParentColor
property ParentCtl3D
property ParentFont
property ParentShowHint
property PopupMenu
property ShowHint
property TabOrder
property TabStop
property Visible
[TLabel]
constructor Create(AOwner: TComponent)
property Align
property Alignment
property Anchors
property AutoSize
property BiDiMode
property Canvas
property Caption
property Color
property Constraints
property DragCursor
property DragKind
property DragMode
property Enabled
property FocusControl
property Font
property Layout
property OnClick
property OnDblClick
property OnDragDrop
property OnDragOver
property OnEndDock
property OnEndDrag
property OnMouseDown
property OnMouseMove
property OnMouseUp
property OnStartDock
property OnStartDrag
property ParentBiDiMode
property ParentColor
property ParentFont
property ParentShowHint
property PopupMenu
property ShowAccelChar
property ShowHint
property Transparent
property Visible
property WordWrap
[TMemo]
constructor Create(AOwner: TComponent);
destructor Destroy;
function GetControlsAlignment: TAlignment;
property CaretPos: TPoint
property Lines: TStrings
property Align;
property Alignment;
property Anchors;
property BiDiMode;
property BorderStyle;
property Color;
property Constraints;
property Ctl3D;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property HideSelection;
property ImeMode;
property ImeName;
property Lines;
property MaxLength;
property OEMConvert;
property ParentBiDiMode;
property ParentColor;
property ParentCtl3D;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ReadOnly;
property ScrollBars;
property ShowHint;
property TabOrder;
property TabStop;
property Visible;
property WantReturns;
property WantTabs;
property WordWrap;
property OnChange;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TComboBox]
constructor Create(AOwner: TComponent);
destructor Destroy;
procedure Clear;
function Focused: Boolean;
procedure SelectAll;
property CharCase: TEditCharCase
property Canvas: TCanvas
property DroppedDown: Boolean
property Items: TStrings
property ItemIndex: Integer
property SelLength: Integer
property SelStart: Integer
property SelText: string
property TabStop
property Style
property Anchors;
property BiDiMode;
property Color;
property Constraints;
property Ctl3D;
property DragCursor;
property DragKind;
property DragMode;
property DropDownCount;
property Enabled;
property Font;
property ImeMode;
property ImeName;
property ItemHeight;
property Items;
property MaxLength;
property ParentBiDiMode;
property ParentColor;
property ParentCtl3D;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property Sorted;
property TabOrder;
property TabStop;
property Text;
property Visible;
property OnChange;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnDrawItem;
property OnDropDown;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMeasureItem;
property OnStartDock;
property OnStartDrag;
[TButton]
constructor Create(AOwner: TComponent)
procedure Click
function UseRightToLeftAlignment: Boolean
property Action;
property Anchors;
property BiDiMode;
property Cancel: Boolean
property Caption;
property Constraints;
property Default: Boolean
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property ModalResult: TModalResult
property ParentBiDiMode;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property TabOrder;
property TabStop
property Visible;
property OnClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TBitBtn]
constructor Create(AOwner: TComponent)
procedure Click
function UseRightToLeftAlignment: Boolean
property Action;
property Anchors;
property BiDiMode;
property Cancel: Boolean
property Caption;
property Constraints;
property Default: Boolean
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property ModalResult: TModalResult
property ParentBiDiMode;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property TabOrder;
property TabStop
property Visible;
property OnClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TCheckBox]
constructor Create(AOwner: TComponent)
function GetControlsAlignment: TAlignment
property TabStop
property Action;
property Alignment;
property AllowGrayed;
property Anchors;
property BiDiMode;
property Caption;
property Checked;
property Color;
property Constraints;
property Ctl3D;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property ParentBiDiMode;
property ParentColor;
property ParentCtl3D;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property State;
property TabOrder;
property TabStop;
property Visible;
property OnClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TRadioButton]
constructor Create(AOwner: TComponent)
function GetControlsAlignment: TAlignment
property Action;
property Alignment: TLeftRight
property Anchors;
property BiDiMode;
property Caption;
property Checked;
property Color;
property Constraints;
property Ctl3D;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property ParentBiDiMode;
property ParentColor;
property ParentCtl3D;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property TabOrder;
property TabStop;
property Visible;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TListBox]
constructor Create(AOwner: TComponent)
destructor Destroy
procedure Clear;
function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
function ItemRect(Index: Integer): TRect;
property Canvas: TCanvas
property Items: TStrings
property ItemIndex: Integer
property SelCount: Integer
property Selected[Index: Integer]: Boolean
property TopIndex: Integer
property TabStop
property Align;
property Anchors;
property BiDiMode;
property BorderStyle;
property Color;
property Columns;
property Constraints;
property Ctl3D;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property ExtendedSelect;
property Font;
property ImeMode;
property ImeName;
property IntegralHeight;
property ItemHeight;
property Items;
property MultiSelect;
property ParentBiDiMode;
property ParentColor;
property ParentCtl3D;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property Sorted;
property Style;
property TabOrder;
property TabStop;
property TabWidth;
property Visible;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnDrawItem;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnMeasureItem;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TScrollBar]
constructor Create(AOwner: TComponent)
procedure SetParams(APosition, AMin, AMax: Integer);
property Align;
property Anchors;
property BiDiMode;
property Constraints;
property Ctl3D;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Kind: TScrollBarKind
property LargeChange: TScrollBarInc
property Max: Integer
property Min: Integer
property PageSize: Integer
property ParentBiDiMode;
property ParentCtl3D;
property ParentShowHint;
property PopupMenu;
property Position: Integer
property ShowHint;
property SmallChange: TScrollBarInc
property TabOrder;
property TabStop
property Visible;
property OnChange: TNotifyEvent
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnKeyDown;
property OnKeyPress;
property OnKeyUp;
property OnScroll: TScrollEvent
property OnStartDock;
property OnStartDrag;
[TStaticText]
constructor Create(AOwner: TComponent)
property Align;
property Alignment;
property Anchors;
property AutoSize;
property BiDiMode;
property BorderStyle;
property Caption;
property Color;
property Constraints;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property FocusControl;
property Font;
property ParentBiDiMode;
property ParentColor;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowAccelChar;
property ShowHint;
property TabOrder;
property TabStop;
property Visible;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDock;
property OnStartDrag;
[TTabControl]
constructor Create(AOwner: TComponent)
destructor Destroy
property Canvas: TCanvas
property TabStop
property DisplayRect;
property Align;
property Anchors;
property BiDiMode;
property Constraints;
property DockSite;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property HotTrack;
property Images;
property MultiLine;
property MultiSelect;
property OwnerDraw;
property ParentBiDiMode;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property RaggedRight;
property ScrollOpposite;
property ShowHint;
property Style;
property TabHeight;
property TabOrder;
property TabPosition;
property Tabs;
property TabIndex
property TabStop;
property TabWidth;
property Visible;
property OnChange;
property OnChanging;
property OnDockDrop;
property OnDockOver;
property OnDragDrop;
property OnDragOver;
property OnDrawTab;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnGetImageIndex;
property OnGetSiteInfo;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnResize;
property OnStartDock;
property OnStartDrag;
property OnUnDock;
[TTabSheet]
constructor Create(AOwner: TComponent)
destructor Destroy
property PageControl: TPageControl
property TabIndex: Integer
property BorderWidth;
property Caption;
property DragMode;
property Enabled;
property Font;
property Height
property ImageIndex: Integer
property Left
property Constraints;
property PageIndex: Integer
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property TabVisible: Boolean
property Top
property Visible
property Width
property OnDragDrop;
property OnDragOver;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnHide: TNotifyEvent
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnResize;
property OnShow: TNotifyEvent
property OnStartDrag;
[TPageControl]
constructor Create(AOwner: TComponent)
destructor Destroy
function FindNextPage(CurPage: TTabSheet; GoForward, CheckTabVisible: Boolean): TTabSheet;
procedure SelectNextPage(GoForward: Boolean);
property PageCount: Integer
property Pages[Index: Integer]: TTabSheet
property ActivePage: TTabSheet
property Align;
property Anchors;
property BiDiMode;
property Constraints;
property DockSite;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property HotTrack;
property Images;
property MultiLine;
property OwnerDraw;
property ParentBiDiMode;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property RaggedRight;
property ScrollOpposite;
property ShowHint;
property Style;
property TabHeight;
property TabOrder;
property TabPosition;
property TabStop;
property TabWidth;
property Visible;
property OnChange;
property OnChanging;
property OnDockDrop;
property OnDockOver;
property OnDragDrop;
property OnDragOver;
property OnDrawTab;
property OnEndDock;
property OnEndDrag;
property OnEnter;
property OnExit;
property OnGetImageIndex;
property OnGetSiteInfo;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnResize;
property OnStartDock;
property OnStartDrag;
property OnUnDock;
[TStatusBar]
constructor Create(AOwner: TComponent)
destructor Destroy
function ExecuteAction(Action: TBasicAction)
procedure FlipChildren(AllLevels: Boolean)
property Canvas: TCanvas
property Action;
property AutoHint: Boolean
property Align
property Anchors;
property BiDiMode;
property BorderWidth;
property Color
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font
property Constraints;
property Panels: TStatusPanels
property ParentBiDiMode;
property ParentColor
property ParentFont
property ParentShowHint;
property PopupMenu;
property ShowHint;
property SimplePanel: Boolean
property SimpleText: string
property SizeGrip: Boolean
property UseSystemFont: Boolean
property Visible;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnHint: TNotifyEvent
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnDrawPanel: TDrawPanelEvent
property OnResize;
property OnStartDock;
property OnStartDrag;
[THeaderControl]
constructor Create(AOwner: TComponent)
destructor Destroy
property Canvas: TCanvas
procedure FlipChildren(AllLevels: Boolean)
property Align
property Anchors;
property BiDiMode;
property BorderWidth;
property DragCursor;
property DragKind;
property DragMode;
property Enabled;
property Font;
property FullDrag: Boolean
property HotTrack: Boolean
property Constraints;
property Sections: THeaderSections
property ShowHint;
property Style: THeaderStyle
property ParentBiDiMode;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property Visible;
property OnDragDrop;
property OnDragOver;
property OnEndDock;
property OnEndDrag;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnDrawSection: TDrawSectionEvent
property OnSectionClick: TSectionNotifyEvent
property OnSectionResize: TSectionNotifyEvent
property OnSectionTrack: TSectionTrackEvent
property OnStartDock;
property OnStartDrag;
[TTreeNode]
constructor Create(AOwner: TTreeNodes);
destructor Destroy
function AlphaSort: Boolean;
procedure Assign(Source: TPersistent)
procedure Collapse(Recurse: Boolean);
function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
procedure Delete;
procedure DeleteChildren;
function DisplayRect(TextOnly: Boolean): TRect;
function EditText: Boolean;
procedure EndEdit(Cancel: Boolean);
procedure Expand(Recurse: Boolean);
function getFirstChild: TTreeNode;
function GetHandle: HWND;
function GetLastChild: TTreeNode;
function GetNext: TTreeNode;
function GetNextChild(Value: TTreeNode): TTreeNode;
function getNextSibling: TTreeNode;
function GetNextVisible: TTreeNode;
function GetPrev: TTreeNode;
function GetPrevChild(Value: TTreeNode): TTreeNode;
function getPrevSibling: TTreeNode;
function GetPrevVisible: TTreeNode;
function HasAsParent(Value: TTreeNode): Boolean;
function IndexOf(Value: TTreeNode): Integer;
procedure MakeVisible;
procedure MoveTo(Destination: TTreeNode; Mode: TNodeAttachMode);
property AbsoluteIndex: Integer
property Count: Integer
property Cut: Boolean
property Data: Pointer
property Deleting: Boolean
property Focused: Boolean
property DropTarget: Boolean
property Selected: Boolean
property Expanded: Boolean
property Handle: HWND
property HasChildren: Boolean
property Index: Integer
property IsVisible: Boolean
property Item[Index: Integer]: TTreeNode
property ItemId: HTreeItem
property Level: Integer
property OverlayIndex: Integer
property Owner: TTreeNodes
property Parent: TTreeNode
property SelectedIndex: Integer
property StateIndex: Integer
property Text: string
property TreeView: TCustomTreeView
[TTreeView]
constructor Create(AOwner: TComponent)
destructor Destroy
function AlphaSort: Boolean;
function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
procedure FullCollapse;
procedure FullExpand;
function GetHitTestInfoAt(X, Y: Integer): THitTests;
function GetNodeAt(X, Y: Integer): TTreeNode;
function IsEditing: Boolean;
procedure LoadFromFile(const FileName: string);
procedure LoadFromStream(Stream: TStream);
procedure SaveToFile(const FileName: string);
procedure SaveToStream(Stream: TStream);
property Canvas: TCanvas
property DropTarget: TTreeNode
property Selected: TTreeNode
property TopItem: TTreeNode
property Align;
property Anchors;
property AutoExpand;
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
property Items;
property ParentBiDiMode;
property ParentColor
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
property TabStop
property ToolTips;
property Visible;
property OnChange;
property OnChanging;
property OnClick;
property OnCollapsing;
property OnCollapsed;
property OnCompare;
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
