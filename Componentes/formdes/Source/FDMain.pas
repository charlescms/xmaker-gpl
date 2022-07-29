(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.455                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, IniFiles, AXCtrls, Clipbrd, ExtCtrls, CommCtrl, ComCtrls, StdCtrls;

type

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

  TGrabPositions = set of TGrabPosition;

  TGrabMode = (gmMiddle,gmInside,gmOutside);

  TCustomFormDesigner = class;

  // container component for non-visual components
  TComponentContainer = class(TCustomControl)
  private
    FDesigner: TCustomFormDesigner;
    FComponent: TComponent;
    FBitmap: TBitmap;
    FCaption: TStaticText;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor CreateWithComponent(AOwner,AComponent: TComponent; ADesigner: TCustomFormDesigner);
    destructor Destroy; override;
    procedure UpdateContainer;
    property Component: TComponent read FComponent write FComponent;
  end;

  // special reader class
  TFDReader = class(TReader)
  private
    Designer: TCustomFormDesigner;
  protected
    function Error(const Message: string): Boolean; override;
    procedure SetName(Component: TComponent; var Name: string); override;
  public
    constructor Create(AStream: TStream; ADesigner: TCustomFormDesigner);
  end;

  // resize handle
  TGrabHandle = class(TCustomControl)
  private
    FPosition: TGrabPosition;
    FRect: TRect;
    FLocked: Boolean;
    procedure SetPosition(Value: TGrabPosition);
    procedure SetRect(Value: TRect);
    procedure SetLocked(Value: Boolean);
    procedure UpdateCoords;
    procedure SetArrowCursor;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Position: TGrabPosition read FPosition write SetPosition;
    property Rect: TRect read FRect write SetRect;
    property Locked: Boolean read FLocked write SetLocked;
  end;

  // resize handles group
  TGrabHandles = class(TComponent)
  private
    FItems: array[TGrabPosition] of TGrabHandle;
    FControl: TControl;
    FVisible: Boolean;
    FEnabled: Boolean;
    procedure SetControl(Value: TControl);
    procedure SetVisible(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    function GetParentForm: TCustomForm;
    function GetDesigner: TCustomFormDesigner;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update(MustHide: Boolean);
    procedure BringToFront;
    function FindHandle(AHandle: HWND): TGrabPosition;
    function FindHandleControl(AHandle: HWND): TGrabHandle;
    function IsGrabHandle(AControl: TControl): Boolean;
    property Control: TControl read FControl write SetControl;
    property Visible: Boolean read FVisible write SetVisible;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property ParentForm: TCustomForm read GetParentForm;
    property Designer: TCustomFormDesigner read GetDesigner;
  end;

  // type for controls list editor
  TListType = (ltLocked,ltProtected,ltTransparent);

  // mode type for LockedControls and ProtectedControls
  TChildrenMode = (cmNone,cmNormal,cmRecurse);

  // type for protect mode
  TProtectMode = (pmUnselect,pmLockKeyboard);

  // message processing type
  TMessageProcessor = (mpEvent,mpHook);

  // internal type for mouse action
  TMouseAction = (maNone,maDragging,maSelecting);

  // internal type for hint window offset
  THintMode = (hmCustom,hmMove,hmSize);

  // grab type for DrawGrab procedure
  TGrabType = (gtNormal,gtMulti,gtLocked);

  // align mode for AlignControls procedure
  TAlignMode = (amNoChange,amLeftTop,amCenters,amRightBottom,amSpace,amWindowCenter);

  // size mode for SizeControls procedure
  TSizeMode = (smNoChange,smToSmallest,smToLargest,smValue);

  // alignment palette modes
  TAlignmentPaletteOption = (apAutoShow,apStayOnTop,apShowHints,apFlatButtons);
  TAlignmentPaletteOptions = set of TAlignmentPaletteOption;

  // DFM formats
  TDFMFormat = (dfmBinary,dfmText);

  // edit behaviour
  TEditBehaviour = (ebDefault,ebTransparent,ebLocked,ebProtected);

  // alignment lines
  TLinePosition = (lpLeft,lpTop,lpRight,lpBottom);
  TLinePositions = set of TLinePosition;

  // TCustomFormDesigner event types
  TControlNotifyEvent = procedure(Sender: TObject; TheControl: TControl) of object;
  TComponentNotifyEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  TLoadSaveEvent = procedure(Sender: TObject; TheControl: TControl; IniFile: TIniFile) of object;
  TDesignerMessageEvent = procedure(Sender: TObject; var Msg: TMsg) of object;
  TMoveLimitEvent = procedure(Sender: TObject; TheControl: TControl; var LimitRect: TRect) of object;
  TSizeLimitEvent = procedure(Sender: TObject; TheControl: TControl; var MinSize,MaxSize: TPoint) of object;
  TCustomizeGrabsEvent = procedure(Sender: TObject; var VisibleGrabs,EnabledGrabs: TGrabPositions) of object;
  TComponentTextEvent = procedure(Sender: TObject; TheComponent: TComponent; var Text: string) of object;
  TComponentBitmapEvent = procedure(Sender: TObject; TheComponent: TComponent; const Bitmap: TBitmap) of object;
  TComponentEditableEvent = procedure(Sender: TObject; TheComponent: TComponent; var Editable: Boolean) of object;
  TComponentClipboardEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  TComponentPopupEvent = procedure(Sender: TObject; var Handled: Boolean) of object;
  TComponentBehaviourEvent = procedure(Sender: TObject; TheComponent: TComponent; var Behaviour: TEditBehaviour) of object;

  // main class
  TCustomFormDesigner = class(TComponent)
  private
    { Private declarations }
    FDefaultProc: TFarProc;
    FWinProc: Pointer;
    FBkgBitmap: TBitmap;
    FForm: TCustomForm;
    FAPForm: TForm;
    FHintControl: TControl;
    FHintTimer: TTimer;
    FKeySelect: Boolean;
    FKeyMove: Boolean;
    FClearBeforeLoad: Boolean;
    FMustClear: Boolean;
    FGrabSize: Integer;
    FNormalGrabBorder: TColor;
    FNormalGrabFill: TColor;
    FMultiGrabBorder: TColor;
    FMultiGrabFill: TColor;
    FLockedGrabBorder: TColor;
    FLockedGrabFill: TColor;
    FNormalGrab: TBitmap;
    FMultiGrab: TBitmap;
    FLockedGrab: TBitmap;
    FHintWindow: THintWindow;
    FCanvas: TCanvas;
    FClickPos: TPoint;
    FDefaultColor: TColor;
    FActive: Boolean;
    FMessageProcessor: TMessageProcessor;
    FLockCounter: Integer;
    FSynchroLockCounter: Integer;
    FWaiting: Boolean;
    FPlacedComponent: TComponent;
    FControls: TList;
    FDesignControl: TWinControl;
    FSelectControl: TWinControl;
    FMenuControl: TControl;
    FGrabHandles: TGrabHandles;
    {$IFDEF GFDADVANCEDGRID}
    FGridStepX: Integer;
    FGridStepY: Integer;
    {$ELSE}
    FGridStep: Integer;
    {$ENDIF}
    FSnapToGrid: Boolean;
    FDisplayGrid: Boolean;
    FDesignerColor: TColor;
    FGridColor: TColor;
    FPopupMenu: TPopupMenu;
    FLockedControls: TStrings;
    FLockedInverse: Boolean;
    FLockChildren: TChildrenMode;
    FProtectedControls: TStrings;
    FProtectedInverse: Boolean;
    FProtectChildren: TChildrenMode;
    FProtectMode: TProtectMode;
    FTransparentControls: TStrings;
    FTransparentInverse: Boolean;
    FTransparentChildren: TChildrenMode;
    FShowMoveSizeHint: Boolean;
    FShowComponentHint: Boolean;
    FAlignmentPalette: TAlignmentPaletteOptions;
    FMouseAction: TMouseAction;
    FDragPoint: TPoint;
    FDragRect: TRect;
    FSelectRect: TRect;
    FSelectCounter: Integer;
    FDragHandle: TGrabPosition;
    FShowNonVisual: Boolean;
    FShowComponentCaptions: Boolean;
    FMultiSelect: Boolean;
    FModified: Boolean;
    FEnableAxisDrag: Boolean;
    FGrabMode: TGrabMode;
    FAlignmentEntireForm: Boolean;
    FAlignmentLines: TLinePositions;
    FAlignmentColorLeft: TColor;
    FAlignmentColorTop: TColor;
    FAlignmentColorRight: TColor;
    FAlignmentColorBottom: TColor;
    FOnMoveSizeControl: TControlNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnLoadControl: TLoadSaveEvent;
    FOnSaveControl: TLoadSaveEvent;
    FOnSelectControl: TControlNotifyEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnControlDblClick: TControlNotifyEvent;
    FOnAddControl: TControlNotifyEvent;
    FOnDeleteControl: TControlNotifyEvent;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FOnMessage: TDesignerMessageEvent;
    FOnMoveLimit: TMoveLimitEvent;
    FOnSizeLimit: TSizeLimitEvent;
    FOnReadError: TReaderError;
    FOnCustomizeGrabs: TCustomizeGrabsEvent;
    FOnComponentHint: TComponentTextEvent;
    FOnComponentCaption: TComponentTextEvent;
    FOnComponentBitmap: TComponentBitmapEvent;
    FOnComponentEditable: TComponentEditableEvent;
    FOnCopyComponent: TComponentClipboardEvent;
    FOnPasteComponent: TComponentClipboardEvent;
    FOnContextPopup: TComponentPopupEvent;
    FOnEditBehaviour: TComponentBehaviourEvent;
    FOnPlaceComponent: TComponentNotifyEvent;
    // properties access methods
    function GetControlCount: Integer;
    function GetLocked: Boolean;
    function GetSynchroLocked: Boolean;
    function GetParentForm: TCustomForm;
    procedure SetParentForm(const Value: TCustomForm);
    function GetFormData: string;
    procedure SetFormData(const Value: string);
    procedure SetActive(Value: Boolean);
    procedure SetMessageProcessor(Value: TMessageProcessor);
    function GetControl: TControl;
    procedure SetControl(Value: TControl);
    function GetControlByIndex(Index: Integer): TControl;
    function GetComponent: TComponent;
    procedure SetComponent(Value: TComponent);
    function GetComponentByIndex(Index: Integer): TComponent;
    {$IFDEF GFDADVANCEDGRID}
    procedure SetGridStepX(Value: Integer);
    procedure SetGridStepY(Value: Integer);
    {$ELSE}
    procedure SetGridStep(Value: Integer);
    {$ENDIF}
    procedure SetDisplayGrid(Value: Boolean);
    procedure SetDesignerColor(Value: TColor);
    procedure SetGridColor(Value: TColor);
    procedure SetLockedControls(Value: TStrings);
    procedure SetLockedInverse(Value: Boolean);
    procedure SetLockChildren(Value: TChildrenMode);
    procedure SetProtectedControls(Value: TStrings);
    procedure SetProtectedInverse(Value: Boolean);
    procedure SetProtectChildren(Value: TChildrenMode);
    procedure SetProtectMode(Value: TProtectMode);
    procedure SetTransparentControls(Value: TStrings);
    procedure SetTransparentInverse(Value: Boolean);
    procedure SetTransparentChildren(Value: TChildrenMode);
    procedure SetMoveSizeHint(Value: Boolean);
    procedure SetComponentHint(Value: Boolean);
    procedure SetGrabSize(Value: Integer);
    procedure SetAlignmentPalette(Value: TAlignmentPaletteOptions);
    procedure SetNormalGrabBorder(Value: TColor);
    procedure SetNormalGrabFill(Value: TColor);
    procedure SetMultiGrabBorder(Value: TColor);
    procedure SetMultiGrabFill(Value: TColor);
    procedure SetLockedGrabBorder(Value: TColor);
    procedure SetLockedGrabFill(Value: TColor);
    procedure SetShowNonVisual(const Value: Boolean);
    procedure SetShowComponentCaptions(const Value: Boolean);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetDesignControl(const Value: TWinControl);
    procedure SetGrabMode(const Value: TGrabMode);
    // internal methods
    procedure ApplicationIdle(Sender: TObject; var Done: Boolean);
    procedure ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
    procedure TimerEvent(Sender: TObject);
    procedure StartTimer(AInterval: Integer);
    procedure StopTimer;
    procedure DrawDragRects;
    procedure DrawSelectRect;
    procedure DrawMultiSelect(AControl: TControl);
    function InTheList(List: TStrings; AControl: TControl): Boolean;
    procedure UpdateGrid;
    procedure ShowHint(AHint: string; Mode: THintMode);
    procedure HideHint;
    function GetControlsOrigin: TPoint;
    function CheckParent(AControl: TControl; DisableLocked: Boolean): Boolean;
    procedure SetArrowCursor;
    function ValidControl(AControl: TControl): Boolean;
    procedure CreateContainers;
    procedure DestroyContainers;
    procedure UpdateContainers;
    function InParentForm(WND: HWND): Boolean;
    {$IFDEF TFDTRIAL}
    procedure ShowTrialWarning;
    {$ENDIF}
    // event handler for TStringList.OnChange
    procedure ListChange(Sender: TObject);
    // the new window procedure
    procedure WinProc(var Message: TMessage);
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MessageProc(var Msg: TMSG); virtual;
    procedure DoMoveSizeControl; virtual;
    procedure DoChange; virtual;
    procedure DoSelectControl(AControl: TControl); virtual;
    procedure DoSelectionChange; virtual;
    procedure DoAddControl(AControl: TControl); virtual;
    procedure DoDeleteControl(AControl: TControl); virtual;
    function GetEditBehaviour(AControl: TControl): TEditBehaviour; virtual;
    {$IFDEF TFD1COMPATIBLE}
    property OnDragControl: TControlNotifyEvent read FOnMoveSizeControl write FOnMoveSizeControl;
    {$ELSE}
    property OnMoveSizeControl: TControlNotifyEvent read FOnMoveSizeControl write FOnMoveSizeControl;
    {$ENDIF}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnLoadControl: TLoadSaveEvent read FOnLoadControl write FOnLoadControl;
    property OnSaveControl: TLoadSaveEvent read FOnSaveControl write FOnSaveControl;
    property OnSelectControl: TControlNotifyEvent read FOnSelectControl write FOnSelectControl;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnControlDblClick: TControlNotifyEvent read FOnControlDblClick write FOnControlDblClick;
    property OnAddControl: TControlNotifyEvent read FOnAddControl write FOnAddControl;
    property OnDeleteControl: TControlNotifyEvent read FOnDeleteControl write FOnDeleteControl;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMessage: TDesignerMessageEvent read FOnMessage write FOnMessage;
    property OnMoveLimit: TMoveLimitEvent read FOnMoveLimit write FOnMoveLimit;
    property OnSizeLimit: TSizeLimitEvent read FOnSizeLimit write FOnSizeLimit;
    property OnReadError: TReaderError read FOnReadError write FOnReadError;
    property OnCustomizeGrabs: TCustomizeGrabsEvent read FOnCustomizeGrabs write FOnCustomizeGrabs;
    property OnComponentHint: TComponentTextEvent read FOnComponentHint write FOnComponentHint;
    property OnComponentCaption: TComponentTextEvent read FOnComponentCaption write FOnComponentCaption;
    property OnComponentBitmap: TComponentBitmapEvent read FOnComponentBitmap write FOnComponentBitmap;
    property OnComponentEditable: TComponentEditableEvent read FOnComponentEditable write FOnComponentEditable;
    property OnCopyComponent: TComponentClipboardEvent read FOnCopyComponent write FOnCopyComponent;
    property OnPasteComponent: TComponentClipboardEvent read FOnPasteComponent write FOnPasteComponent;
    property OnContextPopup: TComponentPopupEvent read FOnContextPopup write FOnContextPopup;
    property OnEditBehaviour: TComponentBehaviourEvent read FOnEditBehaviour write FOnEditBehaviour;
    property OnPlaceComponent: TComponentNotifyEvent read FOnPlaceComponent write FOnPlaceComponent;
  public
    { Public declarations }
    procedure ClearForm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; virtual;
    procedure CreateObjects;
    procedure DestroyObjects;
    function IsLocked(AControl: TControl): Boolean;
    function IsProtected(AControl: TControl): Boolean;
    function IsTransparent(AControl: TControl): Boolean;
    function FindNextControl(GoForward: Boolean): TControl;
    function ControlAtPos(AParent: TWinControl; P: TPoint): TControl;
    function FindWinControl(Wnd: DWORD): TWinControl;
    function FindComponentContainer(AComponent: TComponent): TComponentContainer;
    procedure SaveToFile(FileName: string);
    procedure LoadFromFile(FileName: string);
    procedure SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
    procedure LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
    procedure SaveComponentToStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat);
    function LoadComponentFromStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat): TComponent;
    procedure SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
    procedure LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
    function CanCopy: Boolean;
    function CanPaste: Boolean;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    function GetComponentProperties(AComponent: TComponent): string;
    procedure SetComponentProperties(AComponent: TComponent; Props: string);
    procedure AlignToGrid(TheControl: TControl);
    function EditControlLists(DefaultList: TListType): Boolean;
    function AlignDialog: Boolean;
    function SizeDialog: Boolean;
    function TabOrderDialog: Boolean;
    procedure ShowAlignmentPalette;
    procedure HideAlignmentPalette;
    procedure AlignControls(Hor,Ver: TAlignMode);
    procedure SizeControls(WMode: TSizeMode; WValue: Integer; HMode: TSizeMode; HValue: Integer);
    procedure Lock;
    procedure Unlock;
    procedure SynchroLock;
    procedure SynchroUnlock;
    procedure LeaveMouseAction;
    procedure AddControl(AControl: TControl);
    procedure DeleteControl(AControl: TControl);
    procedure AddComponent(AComponent: TComponent);
    procedure DeleteComponent(AComponent: TComponent);
    procedure SelectAll;
    procedure UnselectAll;
    procedure ClearControls;
    function ControlIndex(AControl: TControl): Integer;
    procedure DrawGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType); virtual;
    procedure UpdateGrabs;
    procedure PlaceComponentClass(AComponentClass: TComponentClass);
    procedure PlaceComponentClassName(AClassName: TComponentName);
    procedure CancelPlacing;
    function GetComponentHint(AComponent: TComponent): string; virtual;
    function GetComponentCaption(AComponent: TComponent): string;
    property Modified: Boolean read FModified write FModified;
    property ControlCount: Integer read GetControlCount;
    property Locked: Boolean read GetLocked;
    property SynchroLocked: Boolean read GetSynchroLocked;
    property MouseAction: TMouseAction read FMouseAction;
    property Active: Boolean read FActive write SetActive;
    property MessageProcessor: TMessageProcessor read FMessageProcessor write SetMessageProcessor default mpEvent;
    property Control: TControl read GetControl write SetControl;
    property Controls[Index: Integer]: TControl read GetControlByIndex;
    property Component: TComponent read GetComponent write SetComponent;
    property Components[Index: Integer]: TComponent read GetComponentByIndex;
    property ParentForm: TCustomForm read GetParentForm write SetParentForm;
    property AlignmentPaletteForm: TForm read FAPForm;
    property MenuControl: TControl read FMenuControl;
    property FormData: string read GetFormData write SetFormData;
    property ClearBeforeLoad: Boolean read FClearBeforeLoad write FClearBeforeLoad default True;
    {$IFDEF TFD1COMPATIBLE}
    property FixedControls: TStrings read FLockedControls write SetLockedControls;
    property FixedInverse: Boolean read FLockedInverse write SetLockedInverse;
    property FixChildren: TChildrenMode read FLockChildren write SetLockChildren;
    {$ELSE}
    property LockedControls: TStrings read FLockedControls write SetLockedControls;
    property LockedInverse: Boolean read FLockedInverse write SetLockedInverse default False;
    property LockChildren: TChildrenMode read FLockChildren write SetLockChildren default cmNone;
    {$ENDIF}
    property ProtectedControls: TStrings read FProtectedControls write SetProtectedControls;
    property ProtectedInverse: Boolean read FProtectedInverse write SetProtectedInverse default False;
    property ProtectChildren: TChildrenMode read FProtectChildren write SetProtectChildren default cmNone;
    property ProtectMode: TProtectMode read FProtectMode write SetProtectMode default pmUnselect;
    property TransparentControls: TStrings read FTransparentControls write SetTransparentControls;
    property TransparentInverse: Boolean read FTransparentInverse write SetTransparentInverse default False;
    property TransparentChildren: TChildrenMode read FTransparentChildren write SetTransparentChildren default cmNone;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu default nil;
    {$IFDEF GFDADVANCEDGRID}
    property GridStepX: Integer read FGridStepX write SetGridStepX default 8;
    property GridStepY: Integer read FGridStepY write SetGridStepY default 8;
    {$ELSE}
    property GridStep: Integer read FGridStep write SetGridStep default 8;
    {$ENDIF}
    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid default False;
    property DisplayGrid: Boolean read FDisplayGrid write SetDisplayGrid default False;
    property DesignerColor: TColor read FDesignerColor write SetDesignerColor default clNone;
    property GridColor: TColor read FGridColor write SetGridColor default clNone;
    property ShowMoveSizeHint: Boolean read FShowMoveSizeHint write SetMoveSizeHint default True;
    property ShowComponentHint: Boolean read FShowComponentHint write SetComponentHint default False;
    property GrabSize: Integer read FGrabSize write SetGrabSize default 5;
    property AlignmentPalette: TAlignmentPaletteOptions read FAlignmentPalette write SetAlignmentPalette default [apStayOnTop,apShowHints];
    property NormalGrabBorder: TColor read FNormalGrabBorder write SetNormalGrabBorder default clBlack;
    property NormalGrabFill: TColor read FNormalGrabFill write SetNormalGrabFill default clBlack;
    property MultiGrabBorder: TColor read FMultiGrabBorder write SetMultiGrabBorder default clGray;
    property MultiGrabFill: TColor read FMultiGrabFill write SetMultiGrabFill default clGray;
    property LockedGrabBorder: TColor read FLockedGrabBorder write SetLockedGrabBorder default clBlack;
    property LockedGrabFill: TColor read FLockedGrabFill write SetLockedGrabFill default clGray;
    property KeySelect: Boolean read FKeySelect write FKeySelect default True;
    property KeyMove: Boolean read FKeyMove write FKeyMove default True;
    property ShowNonVisual: Boolean read FShowNonVisual write SetShowNonVisual default True;
    property ShowComponentCaptions: Boolean read FShowComponentCaptions write SetShowComponentCaptions default False;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default True;
    property DesignControl: TWinControl read FDesignControl write SetDesignControl;
    property EnableAxisDrag: Boolean read FEnableAxisDrag write FEnableAxisDrag default False;
    property GrabMode: TGrabMode read FGrabMode write SetGrabMode default gmMiddle;
    property AlignmentEntireForm: Boolean read FAlignmentEntireForm write FAlignmentEntireForm default False;
    property AlignmentLines: TLinePositions read FAlignmentLines write FAlignmentLines default [];
    property AlignmentColorLeft: TColor read FAlignmentColorLeft write FAlignmentColorLeft default clGray;
    property AlignmentColorTop: TColor read FAlignmentColorTop write FAlignmentColorTop default clGray;
    property AlignmentColorRight: TColor read FAlignmentColorRight write FAlignmentColorRight default clGray;
    property AlignmentColorBottom: TColor read FAlignmentColorBottom write FAlignmentColorBottom default clGray;
  end;

  TFormDesigner = class(TCustomFormDesigner)
  published
    { Published declarations }
    property ClearBeforeLoad;
    property MessageProcessor;
    {$IFDEF TFD1COMPATIBLE}
    property FixedControls;
    property FixedInverse;
    property FixChildren;
    {$ELSE}
    property LockedControls;
    property LockedInverse;
    property LockChildren;
    {$ENDIF}
    property ProtectedControls;
    property ProtectedInverse;
    property ProtectChildren;
    property ProtectMode;
    property TransparentControls;
    property TransparentInverse;
    property TransparentChildren;
    property PopupMenu;
    {$IFDEF GFDADVANCEDGRID}
    property GridStepX;
    property GridStepY;
    {$ELSE}
    property GridStep;
    {$ENDIF}
    property SnapToGrid;
    property DisplayGrid;
    property DesignerColor;
    property GridColor;
    property ShowMoveSizeHint;
    property ShowComponentHint;
    property GrabSize;
    property AlignmentPalette;
    property NormalGrabBorder;
    property NormalGrabFill;
    property MultiGrabBorder;
    property MultiGrabFill;
    property LockedGrabBorder;
    property LockedGrabFill;
    property KeySelect;
    property KeyMove;
    property ShowNonVisual;
    property ShowComponentCaptions;
    property MultiSelect;
    property DesignControl;
    property EnableAxisDrag;
    property GrabMode;
    property AlignmentEntireForm;
    property AlignmentLines;
    property AlignmentColorLeft;
    property AlignmentColorTop;
    property AlignmentColorRight;
    property AlignmentColorBottom;
    {$IFDEF TFD1COMPATIBLE}
    property OnDragControl;
    {$ELSE}
    property OnMoveSizeControl;
    {$ENDIF}
    property OnChange;
    property OnLoadControl;
    property OnSaveControl;
    property OnSelectControl;
    property OnSelectionChange;
    property OnAddControl;
    property OnDeleteControl;
    property OnControlDblClick;
    property OnActivate;
    property OnDeactivate;
    property OnKeyDown;
    property OnKeyUp;
    property OnMessage;
    property OnMoveLimit;
    property OnSizeLimit;
    property OnReadError;
    property OnCustomizeGrabs;
    property OnComponentHint;
    property OnComponentCaption;
    property OnComponentBitmap;
    property OnComponentEditable;
    property OnCopyComponent;
    property OnPasteComponent;
    property OnContextPopup;
    property OnEditBehaviour;
    property OnPlaceComponent;
  end;

  // exception class for TCustomFormDesigner
  EFormDesigner = class(Exception);

function Designing: Boolean;

implementation

{$R FDMAIN.RES}
{$IFNDEF FDNOSTDICONS}
{$R STD.RES}
{$ENDIF}

{$BOOLEVAL OFF}
{$RANGECHECKS OFF}

{$IFDEF VER100}
{$DEFINE NOFRAMES}
{$DEFINE NOMOUSEWHEEL}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER110}
{$DEFINE NOFRAMES}
{$DEFINE NOMOUSEWHEEL}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE NOFRAMES}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER125}
{$DEFINE NOFRAMES}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER130}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}

{$IFNDEF VER150}
{$DEFINE NOCSSUBCOMPONENT}
{$ENDIF}
//{$IFNDEF VER170}
//{$DEFINE NOCSSUBCOMPONENT}
//{$ENDIF}

uses FDEditor, FDAlign, FDSize, FDAlPal, FDTab;

var
  SavedApplicationMessage: TMessageEvent = nil;
  SavedApplicationIdle: TIdleEvent = nil;
  Designers: TList;
  HookID: HHook = 0;
const
  WM_SECONDARYPAINT = WM_USER + 1000;
  BufSize = 2048;

function HookProc(Code,WParam,LParam: Integer): LResult; stdcall;
var
  i,ILockCounter: Integer;
begin
  if Assigned(Designers) then
    for i:=0 to Pred(Designers.Count) do
      with TCustomFormDesigner(Designers[i]) do
      begin
        ILockCounter:=FLockCounter;
        try
          MessageProc(PMsg(LParam)^);
        finally
          if FLockCounter>ILockCounter then FLockCounter:=ILockCounter;
          if Locked then
            case PMsg(LParam)^.Message of
              WM_LBUTTONUP,WM_NCLBUTTONUP,WM_RBUTTONUP,WM_NCRBUTTONUP:
              begin
                Unlock;
                MessageProc(PMsg(LParam)^);
              end;
            end;
        end;
      end;
  Result:=CallNextHookEx(HookID,Code,WParam,LParam);
end;

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
        begin
          FComponent.DesignInfo:=Left+Top shl 16;
          UpdateContainer;
        end;
      end;
    else inherited;
    end;
end;

constructor TComponentContainer.CreateWithComponent(AOwner,AComponent: TComponent; ADesigner: TCustomFormDesigner);
begin
  inherited Create(AOwner);
  FDesigner:=ADesigner;
  FComponent:=AComponent;
  FBitmap:=TBitmap.Create;
  with FBitmap do
  begin
    if Assigned(FDesigner) and Assigned(FDesigner.OnComponentBitmap) then
      FDesigner.OnComponentBitmap(FDesigner,FComponent,FBitmap)
    else Handle:=LoadBitmap(HInstance,PChar(AnsiUpperCase(AComponent.ClassName)));
    if Handle=0 then Handle:=LoadBitmap(HInstance,'CONTAINER');
    Transparent:=True;
  end;
  Visible:=Assigned(FComponent);
  Width:=28;
  Height:=28;
  ShowHint:=True;
  with FComponent do
    if HandleAllocated then
      SetWindowPos(Handle,0,LoWord(DesignInfo),HiWord(DesignInfo),0,0,SWP_NOSIZE or SWP_NOZORDER)
    else
    begin
      Left:=LoWord(DesignInfo);
      Top:=HiWord(DesignInfo);
    end;
  FCaption:=TStaticText.Create(Self);
  UpdateContainer;
  with FCaption do
  begin
    if Assigned(FDesigner) and FDesigner.ShowComponentCaptions then
      FCaption.Parent:=AOwner as TWinControl;
    Alignment:=taCenter;
  end;
  Parent:=AOwner as TWinControl;
end;

destructor TComponentContainer.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TComponentContainer.UpdateContainer;
begin
  with FCaption do
  begin
    if Assigned(FDesigner) then Caption:=FDesigner.GetComponentCaption(FComponent)
    else Caption:='';
    Top:=Self.Top+Self.Height+2;
    Left:=(Self.Left)+Self.Width div 2-Width div 2;
  end;
end;

{ TFDReader }

function TFDReader.Error(const Message: string): Boolean;
begin
  Result:=True;
  if Assigned(Designer) and Assigned(Designer.FOnReadError) then
    Designer.FOnReadError(Self,Message,Result);
end;

procedure TFDReader.SetName(Component: TComponent; var Name: string);

  procedure RenameComponent(AComponent: TComponent);
  var
    Index: Integer;
    AName: string;
  begin
    Index:=1;
    if Name<>'' then
    begin
      AName:=Name;
      while Assigned(AComponent.Owner.FindComponent(AName)) do
      begin
        Inc(Index);
        AName:=Copy(AComponent.ClassName,2,Length(AComponent.ClassName))+IntToStr(Index);
      end;
      try
        AComponent.Name:=AName;
      except
        AComponent.Name:='';
      end;
      with AComponent do
        for Index:=0 to Pred(ComponentCount) do RenameComponent(Components[Index]);
    end;
  end;

begin
  if Assigned(Component) and Assigned(Component.Owner) and Assigned(Designer) and Assigned(Designer.ParentForm) then
    RenameComponent(Component);
end;

constructor TFDReader.Create(AStream: TStream; ADesigner: TCustomFormDesigner);
begin
  inherited Create(AStream,BufSize);
  Designer:=ADesigner;
end;

{ TGrabHandle }

constructor TGrabHandle.Create(AOwner: TComponent);
begin
  inherited;
  with (Owner as TGrabHandles).Designer do
  begin
    Width:=FGrabSize;
    Height:=FGrabSize;
  end;
  ControlStyle:=ControlStyle+[csReplicatable];
end;

procedure TGrabHandle.Paint;
begin
  if Assigned(Parent) then
    with Canvas,(Owner as TGrabHandles).Designer do
      if FLocked then Draw(Self.Width-FGrabSize,Self.Height-FGrabSize,FLockedGrab)
      else Draw(Self.Width-FGrabSize,Self.Height-FGrabSize,FNormalGrab);
end;

procedure TGrabHandle.WndProc(var Msg: TMessage);
begin
  inherited;
  if not FLocked then
    case Msg.Msg of
      CM_MOUSEENTER: Screen.Cursor:=crDefault;
      CM_MOUSELEAVE: SetArrowCursor;
    end;
end;

procedure TGrabHandle.SetPosition(Value: TGrabPosition);
begin
  if Value<>FPosition then
  begin
    FPosition:=Value;
    Cursor:=GetGrabCursor(FPosition);
    UpdateCoords;
  end;
end;

procedure TGrabHandle.SetRect(Value: TRect);
begin
  FRect:=Value;
  UpdateCoords;
end;

procedure TGrabHandle.SetLocked(Value: Boolean);
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
  R: TRect;
begin
  if Assigned(Parent) then
    with (Owner as TGrabHandles).Designer do
    begin
      case FGrabMode of
        gmInside:
        begin
          case FPosition of
            gpLeftTop,gpLeftMiddle,gpLeftBottom: ALeft:=FRect.Left;
            gpMiddleTop,gpMiddleBottom: ALeft:=(FRect.Left+FRect.Right-FGrabSize) div 2;
            gpRightTop,gpRightMiddle,gpRightBottom: ALeft:=Pred(FRect.Right-FGrabSize);
          else ALeft:=0;
          end;
          case FPosition of
            gpLeftTop,gpMiddleTop,gpRightTop: ATop:=FRect.Top;
            gpLeftMiddle,gpRightMiddle: ATop:=(FRect.Top+FRect.Bottom-FGrabSize) div 2;
            gpLeftBottom,gpMiddleBottom,gpRightBottom: ATop:=Pred(FRect.Bottom-FGrabSize);
          else ATop:=0;
          end;
        end;
        gmOutside:
        begin
          case FPosition of
            gpLeftTop,gpLeftMiddle,gpLeftBottom: ALeft:=FRect.Left-FGrabSize;
            gpMiddleTop,gpMiddleBottom: ALeft:=(FRect.Left+FRect.Right-FGrabSize) div 2;
            gpRightTop,gpRightMiddle,gpRightBottom: ALeft:=Pred(FRect.Right);
          else ALeft:=0;
          end;
          case FPosition of
            gpLeftTop,gpMiddleTop,gpRightTop: ATop:=FRect.Top-FGrabSize;
            gpLeftMiddle,gpRightMiddle: ATop:=(FRect.Top+FRect.Bottom-FGrabSize) div 2;
            gpLeftBottom,gpMiddleBottom,gpRightBottom: ATop:=Pred(FRect.Bottom);
          else ATop:=0;
          end;
        end;
      else
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
      end;
      R:=Classes.Rect(ALeft,ATop,ALeft+FGrabSize,ATop+FGrabSize);
      IntersectRect(R,R,Parent.ClientRect);
      with R do SetWindowPos(Handle,0,Left,Top,Right-Left,Bottom-Top,SWP_NOZORDER);
    end;
end;

procedure TGrabHandle.SetArrowCursor;
begin
  {$IFNDEF STDCURSORS}
  Screen.Cursor:=crArrow;
  {$ELSE}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;

{ TGrabHandles }

procedure TGrabHandles.SetControl(Value: TControl);
begin
  FControl:=Value;
  if FEnabled then Update(False);
end;

procedure TGrabHandles.SetVisible(Value: Boolean);
var
  GP: TGrabPosition;
begin
  if Value<>FVisible then
  begin
    FVisible:=Value;
    for GP:=Succ(Low(GP)) to High(GP) do
      FItems[GP].Visible:=FEnabled and FVisible;
  end;
end;

procedure TGrabHandles.SetEnabled(Value: Boolean);
begin
  FEnabled:=Value;
  Visible:=FEnabled and FVisible;
end;

function TGrabHandles.GetParentForm: TCustomForm;
begin
  if Assigned(Designer) then Result:=Designer.ParentForm
  else Result:=nil;
end;

function TGrabHandles.GetDesigner: TCustomFormDesigner;
begin
  if Assigned(Owner) then Result:=Owner as TCustomFormDesigner
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
      Parent:=Designer.ParentForm;
    end;
  end;
  FEnabled:=True;
end;

procedure TGrabHandles.Update(MustHide: Boolean);
var
  GP: TGrabPosition;
  VisibleGrabs,EnabledGrabs: TGrabPositions;
begin
  if Designer.Active then
  begin
    VisibleGrabs:=[Low(TGrabPosition)..High(TGrabPosition)];
    EnabledGrabs:=VisibleGrabs;
    if Assigned(Designer.FOnCustomizeGrabs) then
      Designer.FOnCustomizeGrabs(Designer,VisibleGrabs,EnabledGrabs);
    Application.ProcessMessages;
    FVisible:=
      FEnabled and
      Assigned(FControl) and
      // test FControl.Visible and
      not Designer.IsProtected(FControl) and
      (Designer.ControlCount<=1);
    for GP:=Succ(Low(GP)) to High(GP) do
      if Assigned(FItems[GP]) then
        with FItems[GP] do
          if Assigned(FControl) then
          begin
            if MustHide then Visible:=False;
            Parent:=FControl.Parent;
            Rect:=FControl.BoundsRect;
            Locked:=Designer.IsLocked(FControl);
            Visible:=FVisible and (GP in VisibleGrabs);
            Enabled:=GP in EnabledGrabs;
            if FVisible then BringToFront;
          end
          else
          try
            Visible:=False;
            Parent:=Designer.ParentForm;
          except
          end;
    Application.ProcessMessages;
  end;
end;

procedure TGrabHandles.BringToFront;
var
  GP: TGrabPosition;
begin
  for GP:=Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) then FItems[GP].BringToFront;
end;

function TGrabHandles.FindHandle(AHandle: HWND): TGrabPosition;
var
  GP: TGrabPosition;
begin
  Result:=gpNone;
  for GP:=Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) and (FItems[GP].Handle=AHandle) then
    begin
      Result:=GP;
      Break;
    end;
end;

function TGrabHandles.FindHandleControl(AHandle: HWND): TGrabHandle;
var
  GP: TGrabPosition;
begin
  GP:=FindHandle(AHandle);
  if GP<>gpNone then Result:=FItems[GP]
  else Result:=nil;
end;

function TGrabHandles.IsGrabHandle(AControl: TControl): Boolean;
var
  GP: TGrabPosition;
begin
  Result:=False;
  for GP:=Succ(Low(GP)) to High(GP) do
    if FItems[GP]=AControl then
    begin
      Result:=True;
      Break;
    end;
end;

{ TCustomFormDesigner }

constructor TCustomFormDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLockedControls:=TStringList.Create;
  TStringList(FLockedControls).OnChange:=ListChange;
  FProtectedControls:=TStringList.Create;
  TStringList(FProtectedControls).OnChange:=ListChange;
  FTransparentControls:=TStringList.Create;
  FControls:=TList.Create;
  FAlignmentPalette:=[apStayOnTop,apShowHints];
  FGrabSize:=5;
  FClearBeforeLoad:=True;
  FMultiGrabBorder:=clGray;
  FMultiGrabFill:=clGray;
  FLockedGrabFill:=clGray;
  {$IFDEF GFDADVANCEDGRID}
  FGridStepX:=8;
  FGridStepY:=8;
  {$ELSE}
  FGridStep:=8;
  {$ENDIF}
  FDesignerColor:=clNone;
  FGridColor:=clNone;
  FShowMoveSizeHint:=True;
  FKeySelect:=True;
  FKeyMove:=True;
  {$IFDEF TFDTRIAL}
  if not (csDesigning in ComponentState) then
    MessageBox(
      0,
      'Currently you are using a trial version of Greatis Form Designer with some functional limitations.'#13+
      'To obtain a fully-functional component please visit http://www.greatis.com/formdesbuy.htm',
      'Greatis Form Designer - Trial Version',
      MB_OK or MB_ICONEXCLAMATION);
  {$ENDIF}
  FShowNonVisual:=True;
  FShowComponentCaptions:=False;
  FMultiSelect:=True;
  FAlignmentColorLeft:=clGray;
  FAlignmentColorTop:=clGray;
  FAlignmentColorRight:=clGray;
  FAlignmentColorBottom:=clGray;
  if csDesigning in ComponentState then CreateObjects;
end;

destructor TCustomFormDesigner.Destroy;
begin
  if csDesigning in ComponentState then DestroyObjects
  else Active:=False;
  FLockedControls.Free;
  FTransparentControls.Free;
  FProtectedControls.Free;
  FControls.Free;
  FControls:=nil;
  inherited;
end;

procedure TCustomFormDesigner.CreateObjects;
begin
  FAPForm:=TfrmAlignmentPalette.Create(Self);
  FLockedGrab:=TBitmap.Create;
  FMultiGrab:=TBitmap.Create;
  FNormalGrab:=TBitmap.Create;
  FHintWindow:=THintWindow.Create(Self);
  FHintWindow.Color:=clInfoBk;
  FCanvas:=TCanvas.Create;
  FHintTimer:=TTimer.Create(Self);
  FHintTimer.Enabled:=False;
  FHintTimer.OnTimer:=TimerEvent;
  FBkgBitmap:=TBitmap.Create;
  UpdateGrid;
end;

procedure TCustomFormDesigner.DestroyObjects;

  procedure FreeAndNil(var Obj: TObject);
  begin
    if Assigned(Obj) then Obj.Free;
    Obj:=nil;
  end;

begin
  FreeAndNil(TObject(FHintWindow));
  FreeAndNil(TObject(FCanvas));
  FreeAndNil(TObject(FLockedGrab));
  FreeAndNil(TObject(FMultiGrab));
  FreeAndNil(TObject(FNormalGrab));
  FreeAndNil(TObject(FBkgBitmap));
end;

procedure TCustomFormDesigner.Update;
var
  i: Integer;
begin
  UpdateGrabs;
  UpdateContainers;
  if ControlCount>1 then
    for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i]);
end;

function TCustomFormDesigner.IsLocked(AControl: TControl): Boolean;
begin
  if ValidControl(AControl) then
    if AControl=ParentForm then Result:=True
    else
      case GetEditBehaviour(AControl) of
        ebDefault:
        begin
          case FLockChildren of
            cmNormal: Result:=InTheList(FLockedControls,AControl) or InTheList(FLockedControls,AControl.Parent);
            cmRecurse:
              repeat
                Result:=InTheList(FLockedControls,AControl);
                if Result then Break
                else
                  if ValidControl(AControl) then AControl:=AControl.Parent
                  else AControl:=nil;
              until (AControl=nil) or (AControl=ParentForm);
          else Result:=InTheList(FLockedControls,AControl);
          end;
          Result:=Result xor FLockedInverse;
        end;
        ebLocked: Result:=True;
      else Result:=False;
      end
  else Result:=False;
end;

function TCustomFormDesigner.IsProtected(AControl: TControl): Boolean;

  function IsTopLevel(AControl: TControl): Boolean;
  var
    i: Integer;
  begin
    Result:=False;
    if Assigned(AControl) then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
          if Components[i]=AControl then
          begin
            Result:=True;
            Exit;
          end;
  end;

  function FindTopLevel(AControl: TControl): TControl;
  begin
    Result:=nil;
    while Assigned(AControl) do
    begin
      if IsTopLevel(AControl) then
      begin
        Result:=AControl;
        Exit;
      end;
      AControl:=AControl.Parent;
    end;
  end;

begin
  if ValidControl(AControl) then
    case GetEditBehaviour(AControl) of
      ebDefault:
      begin
        if Assigned(FDesignControl) then
        begin
          Result:=True;
          while Assigned(AControl.Parent) do
          begin
            AControl:=AControl.Parent;
            if AControl=FDesignControl then
            begin
              Result:=False;
              Exit;
            end;
          end;
        end
        else
        begin
          AControl:=FindTopLevel(AControl);
          if not Assigned(AControl) or (AControl=ParentForm) then Result:=True
          else
          begin
            case FProtectChildren of
              cmNormal: Result:=InTheList(FProtectedControls,AControl) or InTheList(FProtectedControls,AControl.Parent);
              cmRecurse:
                repeat
                  Result:=InTheList(FProtectedControls,AControl);
                  if Result then Break
                  else
                    if ValidControl(AControl) then AControl:=AControl.Parent
                    else AControl:=nil;
                until (AControl=nil) or (AControl=ParentForm);
            else Result:=InTheList(FProtectedControls,AControl);
            end;
            Result:=Result xor FProtectedInverse;
          end;
        end;
      end;
      ebProtected: Result:=True;
    else Result:=False;
    end
  else Result:=False;
end;

function TCustomFormDesigner.IsTransparent(AControl: TControl): Boolean;
begin
  if ValidControl(AControl) then
    case GetEditBehaviour(AControl) of
      ebDefault:
        if AControl=ParentForm then Result:=True
        else
        begin
          case FTransparentChildren of
            cmNormal: Result:=InTheList(FTransparentControls,AControl) or InTheList(FTransparentControls,AControl.Parent);
            cmRecurse:
              repeat
                Result:=InTheList(FTransparentControls,AControl);
                if Result then Break
                else
                  if ValidControl(AControl) then AControl:=AControl.Parent
                  else AControl:=nil;
              until (AControl=nil) or (AControl=ParentForm);
          else Result:=InTheList(FTransparentControls,AControl);
          end;
          Result:=Result xor FTransparentInverse;
        end;
      ebTransparent: Result:=True;
    else Result:=False;
    end
  else Result:=False;
end;

function TCustomFormDesigner.GetControlCount: Integer;
begin
  if Assigned(FControls) then Result:=FControls.Count
  else Result:=0;
end;

function TCustomFormDesigner.GetLocked: Boolean;
begin
  Result:=FLockCounter>0;
end;

function TCustomFormDesigner.GetSynchroLocked: Boolean;
begin
  Result:=FSynchroLockCounter>0;
end;

function TCustomFormDesigner.GetParentForm: TCustomForm;
begin
  if Assigned(FForm) then Result:=FForm
  else
    if Assigned(Owner) and (Owner is TCustomForm) then Result:=TCustomForm(Owner)
    else Result:=nil;
end;

procedure TCustomFormDesigner.SetParentForm(const Value: TCustomForm);
begin
  if FForm<>Value then
  begin
    if not (csDesigning in ComponentState) then LeaveMouseAction;
    if Assigned(FDefaultProc) then SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FDefaultProc));
    {$IFNDEF NOREMOVENOTIFICATION}
    if Assigned(FForm) then FForm.RemoveFreeNotification(Self);
    {$ENDIF}
    if Assigned(FForm) then FForm.Invalidate;
    FForm:=Value;
    if Assigned(FForm) then FForm.Invalidate;
    if Assigned(FForm) then FForm.FreeNotification(Self);
    if Assigned(FWinProc) then SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FWinProc));
  end;
end;

function TCustomFormDesigner.GetFormData: string;
var
  StringStream: TStringStream;
begin
  StringStream:=TStringStream.Create('');
  try
    SaveToStream(StringStream,dfmText);
    Result:=StringStream.DataString;
  finally
    StringStream.Free;
  end;
end;

procedure TCustomFormDesigner.SetFormData(const Value: string);
var
  StringStream: TStringStream;
begin
  StringStream:=TStringStream.Create(Value);
  try
    LoadFromStream(StringStream,dfmText);
  finally
    StringStream.Free;
  end;
end;

type
  TDesignAccessComponent = class(TComponent)
  public
    procedure SetDesigningPublic(Value: Boolean);
  end;

procedure TDesignAccessComponent.SetDesigningPublic(Value: Boolean);
begin
  {$IFNDEF GFDNOCSDESIGNING}
  SetDesigning(Value);
  {$ENDIF}
end;

procedure TCustomFormDesigner.SetActive(Value: Boolean);

var
  i: Integer;

  function ParentFormOK: Boolean;
  begin
    Result:=Assigned(ParentForm) and ParentForm.HandleAllocated;
  end;

begin
  if Value<>FActive then
  begin
    if Value then
    begin
      CreateObjects;
      if Assigned(Owner) then
        if Owner is TCustomForm then
        begin
          FGrabHandles:=TGrabHandles.Create(Self);
          Control:=nil;
          UpdateGrabs;
          if Assigned(ParentForm) then ParentForm.ActiveControl:=nil;
        end
        else raise EFormDesigner.Create('Owner of TFormDesigner must be TCustomForm descendant.')
      else raise EFormDesigner.Create('TFormDesigner has no parent window.');
      if Assigned(Designers) then
        with Designers do
          if IndexOf(Self)=-1 then Add(Self);
      if MessageProcessor=mpEvent then
      begin
        if Designers.Count=1 then
        begin
          if not Assigned(SavedApplicationMessage) then SavedApplicationMessage:=Application.OnMessage;
          Application.OnMessage:=ApplicationMessage;
        end
      end
      else
        if HookID=0 then HookID:=SetWindowsHookEx(WH_GETMESSAGE,HookProc,HInstance,GetCurrentThreadID);
      if Assigned(Designers) and (Designers.Count=1) then
      begin
        if not Assigned(SavedApplicationIdle) then SavedApplicationIdle:=Application.OnIdle;
        Application.OnIdle:=ApplicationIdle;
      end;
      if ParentFormOK then
        with ParentForm do
        begin
          {$IFNDEF GFDENABLEAUTORANGE}
          DisableAutoRange;
          {$ENDIF}
          FDefaultColor:=Color;
          Invalidate;
        end;
      Update;
      CreateContainers;
      if apAutoShow in FAlignmentPalette then ShowAlignmentPalette;
    end
    else
    begin
      Designers.Remove(Self);
      Application.OnIdle:=SavedApplicationIdle;
      if MessageProcessor=mpEvent then
      begin
        if Designers.Count=0 then Application.OnMessage:=SavedApplicationMessage;
      end
      else
        if not Assigned(Designers) or (Designers.Count=0) then
        begin
          UnhookWindowsHookEx(HookID);
          HookID:=0;
        end;
      if not (csDestroying in ComponentState) then
      begin
        FAPForm.Hide;
        LeaveMouseAction;
        if ParentFormOK then ParentForm.Color:=FDefaultColor;
        Control:=nil;
        if Assigned(FGrabHandles) then
        begin
          FGrabHandles.Free;
          FGrabHandles:=nil;
        end;
        DestroyContainers;
      end;
      if ParentFormOK then
        with ParentForm do
        begin
          {$IFNDEF GFDENABLEAUTORANGE}
          EnableAutoRange;
          {$ENDIF}
          Color:=FDefaultColor;
          Invalidate;
        end;
      DestroyObjects;
    end;
    FActive:=Value;
    if ParentFormOK then
      with ParentForm do
      begin
        for i:=0 to Pred(ComponentCount) do
          if (Components[i] is TControl) and not IsProtected(TControl(Components[i])) then
          begin
            TDesignAccessComponent(Components[i]).SetDesigningPublic(FActive);
            if (Components[i] is TWinControl) and
              TWinControl(Components[i]).HandleAllocated then
              with TWinControl(Components[i]) do
                if FActive then
                  {$IFNDEF GFDHIDEINVISIBLE}
                  ShowWindow(Handle,SW_SHOW)
                  {$ENDIF}
                else
                  if not Visible then ShowWindow(Handle,SW_HIDE);
          end;
      end;
    if FActive then
    begin
      if ParentFormOK then
        FDefaultProc:=TFarProc(GetWindowLong(ParentForm.Handle,GWL_WNDPROC));
      FWinProc:=MakeObjectInstance(WinProc);
      SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FWinProc));
      FModified:=False;
    end
    else
    begin
      if ParentFormOK and Assigned(FDefaultProc) then
        SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FDefaultProc));
      if Assigned(FWinProc) then FreeObjectInstance(FWinProc);
      FDefaultProc:=nil;
      FWinProc:=nil;
    end;
    Screen.Cursor:=crDefault;
    if ParentFormOK then ParentForm.Invalidate;
    if FActive then
    begin
      if Assigned(FOnActivate) then FOnActivate(Self);
    end
    else
    begin
      if Assigned(FOnDeactivate) then FOnDeactivate(Self);
    end;
  end;
end;

procedure TCustomFormDesigner.SetMessageProcessor(Value: TMessageProcessor);
begin
  if FActive then EFormDesigner.Create('Cannot change message processor when TFormDesigner is active')
  else
    if Value<>FMessageProcessor then FMessageProcessor:=Value;
end;

{$IFDEF GFDADVANCEDGRID}

procedure TCustomFormDesigner.SetGridStepX(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStepX then
  begin
    FGridStepX:=Value;
    UpdateGrid;
  end;
end;

procedure TCustomFormDesigner.SetGridStepY(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStepY then
  begin
    FGridStepY:=Value;
    UpdateGrid;
  end;
end;

{$ELSE}

procedure TCustomFormDesigner.SetGridStep(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStep then
  begin
    FGridStep:=Value;
    UpdateGrid;
  end;
end;

{$ENDIF}
procedure TCustomFormDesigner.SetDisplayGrid(Value: Boolean);
begin
  if Value<>FDisplayGrid then
  begin
    FDisplayGrid:=Value;
    if Assigned(ParentForm) then ParentForm.Invalidate;
  end;
end;

procedure TCustomFormDesigner.SetDesignerColor(Value: TColor);
begin
  if Value<>FDesignerColor then
  begin
    FDesignerColor:=Value;
    UpdateGrid;
  end;
end;

procedure TCustomFormDesigner.SetGridColor(Value: TColor);
begin
  if Value<>FGridColor then
  begin
    FGridColor:=Value;
    UpdateGrid;
  end;
end;

procedure TCustomFormDesigner.SetMoveSizeHint(Value: Boolean);
begin
  if Value<>FShowMoveSizeHint then
  begin
    FShowMoveSizeHint:=Value;
    if not FShowMoveSizeHint then HideHint;
  end;
end;

procedure TCustomFormDesigner.SetComponentHint(Value: Boolean);
begin
  if Value<>FShowComponentHint then
  begin
    FShowComponentHint:=Value;
    if not FShowComponentHint then HideHint;
  end;
end;

procedure TCustomFormDesigner.SetGrabSize(Value: Integer);
begin
  if Value<3 then Value:=3;
  if Value>32 then Value:=32;
  if Value<>FGrabSize then
  begin
    FGrabSize:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetAlignmentPalette(Value: TAlignmentPaletteOptions);
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

procedure TCustomFormDesigner.SetNormalGrabBorder(Value: TColor);
begin
  if Value<>FNormalGrabBorder then
  begin
    FNormalGrabBorder:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetNormalGrabFill(Value: TColor);
begin
  if Value<>FNormalGrabFill then
  begin
    FNormalGrabFill:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetMultiGrabBorder(Value: TColor);
begin
  if Value<>FMultiGrabBorder then
  begin
    FMultiGrabBorder:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetMultiGrabFill(Value: TColor);
begin
  if Value<>FMultiGrabFill then
  begin
    FMultiGrabFill:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetLockedGrabBorder(Value: TColor);
begin
  if Value<>FLockedGrabBorder then
  begin
    FLockedGrabBorder:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetLockedGrabFill(Value: TColor);
begin
  if Value<>FLockedGrabFill then
  begin
    FLockedGrabFill:=Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetShowNonVisual(const Value: Boolean);
begin
  if Value<>FShowNonVisual then
  begin
    FShowNonVisual:=Value;
    if FShowNonVisual then CreateContainers
    else DestroyContainers;
  end;
end;

procedure TCustomFormDesigner.SetShowComponentCaptions(const Value: Boolean);
begin
  if Value<>FShowComponentCaptions then
  begin
    FShowComponentCaptions:=Value;
    if not (csDesigning in ComponentState) then
    begin
      DestroyContainers;
      if FShowNonVisual then CreateContainers;
    end;
  end;
end;

procedure TCustomFormDesigner.SetMultiSelect(const Value: Boolean);
begin
  if Value<>FMultiSelect then
  begin
    FMultiSelect:=Value;
    UnselectAll;
  end;
end;

procedure TCustomFormDesigner.SetDesignControl(const Value: TWinControl);
begin
  FDesignControl:=Value;
  if Assigned(FDesignControl) and FActive then LeaveMouseAction;
end;

procedure TCustomFormDesigner.SetGrabMode(const Value: TGrabMode);
begin
  if Value<>FGrabMode then
  begin
    FGrabMode:=Value;
    if Assigned(FGrabHandles) then FGrabHandles.Update(False);
  end;
end;

function TCustomFormDesigner.GetControl: TControl;
begin
  if Assigned(FControls) then
    with FControls do
      if Count>0 then Result:=FControls[0]
      else Result:=nil
  else Result:=nil;
end;

procedure TCustomFormDesigner.SetControl(Value: TControl);
begin
  {$IFDEF TFDTRIAL}
  if ValidControl(Value) and (Value.Parent<>ParentForm) then
  begin
    Control:=nil;
    ShowTrialWarning;
    Exit;
  end;
  {$ENDIF}
  if Value=ParentForm then Value:=nil;
  if (Value<>Control) and not IsTransparent(Value) and not IsProtected(Value) then
  begin
    with FControls do
      while Count>0 do DeleteControl(Controls[0]);
    if Value<>ParentForm then AddControl(Value);
    if ValidControl(Control) and Assigned(ParentForm) then ParentForm.ActiveControl:=nil;
    Application.ProcessMessages;
    if not ValidControl(Control) then
    begin
      if Assigned(FOnSelectControl) then FOnSelectControl(Self,Control);
      DoSelectionChange;
    end;
  end;
end;

function TCustomFormDesigner.GetControlByIndex(Index: Integer): TControl;
begin
  with FControls do
    if (Index>=0) and (Index<Count) then Result:=FControls[Index]
    else
    begin
      Result:=nil;
      EFormDesigner.Create('Index of Controls array is out or range.');
    end;
end;

function TCustomFormDesigner.GetComponent: TComponent;
begin
  Result:=Control;
  if Result is TComponentContainer then Result:=TComponentContainer(Result).Component;
end;

procedure TCustomFormDesigner.SetComponent(Value: TComponent);
begin
  if Value is TControl then Control:=TControl(Value)
  else Control:=FindComponentContainer(Value);
end;

function TCustomFormDesigner.GetComponentByIndex(Index: Integer): TComponent;
begin
  Result:=Controls[Index];
  if Result is TComponentContainer then Result:=TComponentContainer(Result).Component;
end;

procedure TCustomFormDesigner.SetLockedControls(Value: TStrings);
begin
  FLockedControls.Assign(Value);
  if FActive and IsLocked(Control) then Control:=nil;
end;

procedure TCustomFormDesigner.SetLockedInverse(Value: Boolean);
begin
  if Value<>FLockedInverse then
  begin
    FLockedInverse:=Value;
    if FActive and IsLocked(Control) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.SetLockChildren(Value: TChildrenMode);
begin
  if Value<>FLockChildren then
  begin
    FLockChildren:=Value;
    if FActive and IsLocked(Control) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.SetProtectedControls(Value: TStrings);
begin
  FProtectedControls.Assign(Value);
  if FActive and IsProtected(Control) then Control:=nil;
end;

procedure TCustomFormDesigner.SetProtectedInverse(Value: Boolean);
begin
  if Value<>FProtectedInverse then
  begin
    FProtectedInverse:=Value;
    if FActive and IsProtected(Control) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.SetProtectChildren(Value: TChildrenMode);
begin
  if Value<>FProtectChildren then
  begin
    FProtectChildren:=Value;
    if FActive and IsProtected(Control) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.SetProtectMode(Value: TProtectMode);
begin
  if Value<>FProtectMode then
  begin
    FProtectMode:=Value;
    if FActive and (ProtectMode=pmUnselect) and
      Assigned(ParentForm) and (ParentForm.ActiveControl<>nil) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.SetTransparentControls(Value: TStrings);
begin
  FTransparentControls.Assign(Value);
  if FActive and IsTransparent(Control) then Control:=nil;
end;

procedure TCustomFormDesigner.SetTransparentInverse(Value: Boolean);
begin
  if Value<>FTransparentInverse then
  begin
    FTransparentInverse:=Value;
    if FActive and IsTransparent(Control) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.SetTransparentChildren(Value: TChildrenMode);
begin
  if Value<>FTransparentChildren then
  begin
    FTransparentChildren:=Value;
    if FActive and IsTransparent(Control) then Control:=nil;
  end;
end;

procedure TCustomFormDesigner.DrawSelectRect;
var
  SR: TRect;
begin
  if Assigned(ParentForm) then
    with FCanvas do
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
        ReleaseDC(0,FCanvas.Handle);
        FCanvas.Handle:=0;
      end;
    end;
end;

procedure TCustomFormDesigner.DrawDragRects;

var
  i: Integer;
  DR: TRect;
  Offset: TPoint;
  FAlignRect: TRect;
  FormColor: TColor;

  function Max(X1,X2: Integer): Integer;
  begin
    if X1>X2 then Result:=X1
    else Result:=X2;
  end;

  function Min(X1,X2: Integer): Integer;
  begin
    if X1<X2 then Result:=X1
    else Result:=X2;
  end;

  function GetAlignment(LP: TLinePosition; var P: TPoint): Boolean;

  var
    i: Integer;
    C: TControl;

    function FormX(Control: TControl; X: Integer): Integer;
    var
      P: TPoint;
    begin
      P.X:=X;
      P.Y:=0;
      if FAlignmentEntireForm then
        P:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(P));
      Result:=P.X;
    end;

    function FormY(Control: TControl; Y: Integer): Integer;
    var
      P: TPoint;
    begin
      P.X:=0;
      P.Y:=Y;
      if FAlignmentEntireForm then
        P:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(P));
      Result:=P.Y;
    end;

  begin
    Result:=False;
    P.X:=MaxInt;
    P.Y:=-MaxInt;
    with ParentForm do
      for i:=0 to Pred(ComponentCount) do
        if Components[i] is TControl then
        begin
          C:=TControl(Components[i]);
          if ValidControl(C) and Assigned(C.Parent) and (C.Parent.Showing) and
            (FAlignmentEntireForm or (C.Parent=Control.Parent)) then
            with C do
              case LP of
                lpLeft:
                  if FAlignRect.Left=FormX(C,Left) then
                  begin
                    P.X:=Min(P.X,FormY(C,Top));
                    P.Y:=Max(P.Y,FormY(C,Top+Height));
                    Result:=True;
                  end;
                lpTop:
                  if FAlignRect.Top=FormY(C,Top) then
                  begin
                    P.X:=Min(P.X,FormX(C,Left));
                    P.Y:=Max(P.Y,FormX(C,Left+Width));
                    Result:=True;
                  end;
                lpRight:
                  if FAlignRect.Right=FormX(C,Left+Width) then
                  begin
                    P.X:=Min(P.X,FormY(C,Top));
                    P.Y:=Max(P.Y,FormY(C,Top+Height));
                    Result:=True;
                  end;
                lpBottom:
                  if FAlignRect.Bottom=FormY(C,Top+Height) then
                  begin
                    P.X:=Min(P.X,FormX(C,Left));
                    P.Y:=Max(P.Y,FormX(C,Left+Width));
                    Result:=True;
                  end;
              end;
        end;
    if Result then
      with FAlignRect do
        case LP of
          lpLeft,lpRight:
          begin
            if P.X>Top then P.X:=Top;
            if P.Y<Bottom then P.Y:=Bottom;
          end;
          lpTop,lpBottom:
          begin
            if P.X>Left then P.X:=Left;
            if P.Y<Right then P.Y:=Right;
          end;
        end;
  end;

begin
  with FAlignRect do
  begin
    Left:=MaxInt;
    Top:=MaxInt;
    Right:=-MaxInt;
    Bottom:=-MaxInt;
  end;
  if not ValidControl(Control) then Exit;
  if Assigned(ParentForm) then
    with FCanvas do
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
        for i:=0 to Pred(ControlCount) do
        begin
          if i=0 then DR:=FDragRect
          else
          begin
            DR:=Controls[i].BoundsRect;
            OffsetRect(DR,Offset.X,Offset.Y);
          end;
          with FAlignRect do
          begin
            Left:=Min(Left,DR.Left);
            Top:=Min(Top,DR.Top);
            Right:=Max(Right,DR.Right);
            Bottom:=Max(Bottom,DR.Bottom);
          end;
          with DR do Rectangle(Left+1,Top+1,Right,Bottom);
        end;
        if FAlignmentLines<>[] then
        begin
          if FAlignmentEntireForm then
          begin
            ReleaseDC(0,FCanvas.Handle);
            FCanvas.Handle:=GetDCEx(ParentForm.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS);
          end;
          if FDesignerColor<>clNone then FormColor:=FDesignerColor
          else FormColor:=ParentForm.Color;
          FormColor:=ColorToRGB(FormColor);
          if ControlCount=1 then FAlignRect:=FDragRect;
          if FAlignmentEntireForm then
            MapWindowPoints(Control.Parent.Handle,ParentForm.Handle,FAlignRect,2);
          Pen.Width:=1;
          with FAlignRect do
          begin
            if (lpLeft in FAlignmentLines) and GetAlignment(lpLeft,Offset) then
            begin
              Pen.Color:=FAlignmentColorLeft xor FormColor;
              MoveTo(Left-2,Offset.X);
              LineTo(Left-2,Pred(Offset.Y));
            end;
            if (lpTop in FAlignmentLines) and GetAlignment(lpTop,Offset) then
            begin
              Pen.Color:=FAlignmentColorTop xor FormColor;
              MoveTo(Offset.X,Top-2);
              LineTo(Pred(Offset.Y),Top-2);
            end;
            if (lpRight in FAlignmentLines) and GetAlignment(lpRight,Offset) then
            begin
              Pen.Color:=FAlignmentColorRight xor FormColor;
              MoveTo(Right+1,Offset.X);
              LineTo(Right+1,Pred(Offset.Y));
            end;
            if (lpRight in FAlignmentLines) and GetAlignment(lpBottom,Offset) then
            begin
              Pen.Color:=FAlignmentColorBottom xor FormColor;
              MoveTo(Offset.X,Bottom+1);
              LineTo(Pred(Offset.Y),Bottom+1);
            end;
          end;
        end;
      finally
        ReleaseDC(0,FCanvas.Handle);
        FCanvas.Handle:=0;
      end;
    end;
end;

procedure TCustomFormDesigner.DrawMultiSelect(AControl: TControl);
begin
  if Assigned(FGrabHandles) and FGrabHandles.IsGrabHandle(AControl) then Exit;
  Application.ProcessMessages;
  if ValidControl(AControl) then
    if AControl is TWinControl then
      with TCanvas.Create do
      try
        Handle:=GetDC(TWinControl(AControl).Handle);        
        with Brush do
        begin
          Style:=bsSolid;
          Color:=clGray;
        end;
        with AControl.ClientRect do
        begin
          Draw(Left,Top,FMultiGrab);
          Draw(Left,Bottom-FGrabSize,FMultiGrab);
          Draw(Right-FGrabSize,0,FMultiGrab);
          Draw(Right-FGrabSize,Bottom-FGrabSize,FMultiGrab);
        end;
      finally
        ReleaseDC(TWinControl(AControl).Handle,Handle);
        Handle:=0;
        Free;
      end
    else
    begin
      with TControlCanvas.Create do
      try
        Control:=AControl;
        with Brush do
        begin
          Style:=bsSolid;
          Color:=clGray;
        end;
        with AControl.ClientRect do
        begin
          Draw(Left,Top,FMultiGrab);
          Draw(Left,Bottom-FGrabSize,FMultiGrab);
          Draw(Right-FGrabSize,Top,FMultiGrab);
          Draw(Right-FGrabSize,Bottom-FGrabSize,FMultiGrab);
        end;
      finally
        Control:=nil;
        Free;
      end;
    Application.ProcessMessages;
  end;
end;

function TCustomFormDesigner.InTheList(List: TStrings; AControl: TControl): Boolean;
var
  AName: string;
  AComponent: TComponent;
begin
  if Assigned(List) and ValidControl(AControl) then
  begin
    if AControl is TComponentContainer then
      AName:=TComponentContainer(AControl).Component.Name
    else AName:=AControl.Name;
    Result:=List.IndexOf(AName)<>-1;
    if not Result then
    begin
      AComponent:=AControl.Owner;
      while not Result and Assigned(AComponent) do
      begin
        AName:=AComponent.Name+'.'+AName;
        Result:=List.IndexOf(AName)<>-1;
        AComponent:=AComponent.Owner;
      end;
    end
  end
  else Result:=False;
end;

procedure TCustomFormDesigner.UpdateGrid;
var
  X,Y: Integer;
  BkColor,DotColor: TColor;
begin
  if Assigned(FBkgBitmap) then
    with FBkgBitmap,Canvas do
    begin
      if FDesignerColor=clNone then
        if Assigned(ParentForm) then BkColor:=ParentForm.Color
        else BkColor:=clBtnFace
      else BkColor:=FDesignerColor;
      if FGridColor=clNone then
        if Assigned(ParentForm) then DotColor:=ParentForm.Font.Color
        else DotColor:=clBlack
      else DotColor:=FGridColor;
      {$IFDEF GFDADVANCEDGRID}
      {$IFDEF GFDNOFASTGRID}
      Width:=FGridStepX;
      Height:=FGridStepY;
      {$ELSE}
      Width:=Screen.Width div FGridStepX*FGridStepX;
      Height:=Screen.Height div FGridStepY*FGridStepY;
      {$ENDIF}
      {$ELSE}
      {$IFDEF GFDNOFASTGRID}
      Width:=FGridStep;
      Height:=FGridStep;
      {$ELSE}
      Width:=Screen.Width div FGridStep*FGridStep;
      Height:=Screen.Height div FGridStep*FGridStep;
      {$ENDIF}
      {$ENDIF}
      Brush.Color:=BkColor;
      FillRect(Rect(0,0,Width,Height));
      {$IFDEF GFDADVANCEDGRID}
      for Y:=0 to Height div FGridStepY do
        for X:=0 to Width div FGridStepX do
          Pixels[X*FGridStepX,Y*FGridStepY]:=DotColor;
      {$ELSE}
      for Y:=0 to Height div FGridStep do
        for X:=0 to Width div FGridStep do
          Pixels[X*FGridStep,Y*FGridStep]:=DotColor;
      {$ENDIF}
    end;
end;

procedure TCustomFormDesigner.ShowHint(AHint: string; Mode: THintMode);
var
  R: TRect;
  P: TPoint;
  Offset: Integer;
begin
  if Assigned(FHintWindow) then
    if ((FShowMoveSizeHint and (Mode<>hmCustom)) or (FShowComponentHint and (Mode=hmCustom))) and (AHint<>'') then
      with FHintWindow do
      begin
        HideHint;
        Application.ProcessMessages;
        with Self.FControls do
          if Count>1 then
            for Offset:=0 to Pred(Count) do DrawMultiSelect(Self.Controls[Offset]);
        R:=CalcHintRect(255,AHint,nil);
        GetCursorPos(P);
        case Mode of
          hmCustom: Offset:=24;
          hmMove: Offset:=18
        else Offset:=8;
        end;
        OffsetRect(R,P.X,P.Y+Offset);
        ActivateHint(R,AHint);
      end
    else HideHint;
end;

procedure TCustomFormDesigner.HideHint;
begin
  if Assigned(FHintWindow) then FHintWindow.ReleaseHandle;
end;

function TCustomFormDesigner.GetControlsOrigin: TPoint;
var
  i: Integer;
begin
  case ControlCount of
    0: Result:=Point(0,0);
    1: with Control do Result:=Point(Left,Top);
  else
  begin
    Result:=Point(MaxInt,MaxInt);
    for i:=0 to Pred(ControlCount) do
      with Controls[i],Result do
      begin
        if Left<X then X:=Left;
        if Top<Y then Y:=Top;
      end;
  end;
  end;
end;

function TCustomFormDesigner.CheckParent(AControl: TControl; DisableLocked: Boolean): Boolean;

var
  i: Integer;

  function IsControlLocked(AControl: TControl): Boolean;
  begin
    Result:=IsLocked(AControl) and DisableLocked;
  end;

begin
  Result:=False;
  i:=0;
  while i<ControlCount do
    if (Controls[i].Parent<>AControl.Parent) or
      IsControlLocked(Controls[i]) then
    begin
      Result:=IsControlLocked(Controls[i]);
      Controls[i].Invalidate;
      DeleteControl(Controls[i]);
    end
    else Inc(i);
  if ControlCount=1 then Control.Invalidate;
end;

procedure TCustomFormDesigner.SetArrowCursor;
begin
  {$IFNDEF STDCURSORS}
  Screen.Cursor:=crArrow;
  {$ELSE}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;

procedure TCustomFormDesigner.ClearForm;
var
  i: Integer;
  OldActive: Boolean;
begin
  OldActive:=Active;
  Active:=False;
  try
    i:=0;
    if Assigned(ParentForm) then
      with ParentForm do
        while i<ComponentCount do
          if Components[i]<>Self then Components[i].Free
          else Inc(i);
  finally
    Active:=OldActive;
  end;
end;

function TCustomFormDesigner.ValidControl(AControl: TControl): Boolean;
begin
  try
    Result:=Assigned(AControl) and (AControl.ClassInfo<>nil);
    if AControl is TWinControl then
      Result:=Result and TWinControl(AControl).HandleAllocated;
  except
    Result:=False;
  end;
end;

procedure TCustomFormDesigner.CreateContainers;
var
  i: Integer;
  Editable: Boolean;
begin
  if not (csDesigning in ComponentState) then
    if FShowNonVisual then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
          if not (Components[i] is TControl) and
            not (Components[i] is TMenuItem) and
            not (Components[i] is TCustomFormDesigner) and
            not Assigned(FindComponentContainer(Components[i])) then
          begin
            Editable:=True;
            if Assigned(FOnComponentEditable) then FOnComponentEditable(Self,Components[i],Editable);
            if Editable then TComponentContainer.CreateWithComponent(ParentForm,Components[i],Self);
          end;
end;

procedure TCustomFormDesigner.DestroyContainers;
var
  i: Integer;
begin
  i:=0;
  with ParentForm do
    while i<ComponentCount do
      if Components[i] is TComponentContainer then Components[i].Free
      else Inc(i);
end;

procedure TCustomFormDesigner.UpdateContainers;
var
  i: Integer;
begin
  with ParentForm do
    for i:=0 to Pred(ComponentCount) do
      if Components[i] is TComponentContainer then
        TComponentContainer(Components[i]).UpdateContainer;
end;


function TCustomFormDesigner.InParentForm(WND: HWND): Boolean;
var
  i: Integer;
begin
  with ParentForm do
  begin
    Result:=WND=Handle;
    if not Result then
      for i:=0 to Pred(ComponentCount) do
        if (Components[i] is TWinControl) and
          TWinControl(Components[i]).HandleAllocated and
          (TWinControl(Components[i]).Handle=WND) then
        begin
          Result:=True;
          Break;
        end;
  end;
end;

{$IFDEF TFDTRIAL}
procedure TCustomFormDesigner.ShowTrialWarning;
begin
  MessageBox(
    0,
    'In the trial version of this component you can select only the controls that are parented by a form, not by another control.',
    'Greatis Form Designer - Trial Version',
    MB_OK or MB_ICONEXCLAMATION);
end;
{$ENDIF}

procedure TCustomFormDesigner.ListChange(Sender: TObject);
begin
  if not (csDesigning in ComponentState) and Active then
  try
    Update;
  except
  end;
end;

procedure TCustomFormDesigner.WinProc(var Message: TMessage);

var
  X,Y: Integer;

  function CallDefault: Integer;
  begin
    with Message do
      CallDefault:=CallWindowProc(FDefaultProc,ParentForm.Handle,Msg,wParam,lParam);
  end;

  function OnInactiveForm: Boolean;
  var
    F: TControl;
  begin
    Result:=True;
    F:=ParentForm;
    while Assigned(F) do
    begin
      if F=Screen.ActiveForm then
      begin
        Result:=False;
        Exit;
      end;
      F:=F.Parent;
    end;
  end;

  function ParentedByForm: Boolean;
  var
    C: TWinControl;
  begin
    C:=ParentForm.Parent;
    Result:=False;
    while Assigned(C) do
    begin
      if C is TCustomForm then
      begin
        Result:=True;
        Break;
      end;
      C:=C.Parent;
    end;
  end;

begin
  with Message do
    if Assigned(ParentForm) and ParentForm.HandleAllocated and Assigned(FBkgBitmap) and FDisplayGrid then
    begin
      case Msg of
        WM_ERASEBKGND:
        begin
          CallDefault;
          with ParentForm do
          begin
            for X:=0 to Pred(ControlCount) do
              with Controls[X] do
                if not (Controls[X] is TWinControl) and ((csDesigning in ComponentState) or Visible) then
                  ExcludeClipRect(Canvas.Handle,Left,Top,Left+Width,Top+Height);
            if FActive and FDisplayGrid then
              with FBkgBitmap do
                for Y:=0 to ClientHeight div Height do
                  for X:=0 to ClientWidth div Width do
                    BitBlt(ParentForm.Canvas.Handle,X*Width,Y*Height,Width,Height,Canvas.Handle,0,0,SRCCOPY);
          end;
          Result:=0;
        end;
        WM_SIZE,WM_MOVE:
        begin
          Result:=CallDefault;
          FModified:=True;
        end;
        WM_ACTIVATE:
        begin
          if LoWord(wParam)<>WA_INACTIVE then FGrabHandles.Update(False);
          Result:=CallDefault;
        end;
        WM_MOUSEACTIVATE:
          with ParentForm do
            if (Integer(wParam)=Integer(Handle)) and (LoWord(lParam)=HTCAPTION) then
              Result:=MA_NOACTIVATEANDEAT
            else Result:=CallDefault;
      else Result:=CallDefault;
      end
    end
  else Result:=CallDefault;
end;

procedure TCustomFormDesigner.Notification(AComponent: TComponent; Operation: TOperation);
var
  CC: TComponentContainer;
begin
  inherited;
  if FActive and
    (ComponentState=[]) and
    (AComponent.Owner=ParentForm) and
    not (AComponent is TComponentContainer) then FModified:=True;
  if not (csLoading in ComponentState) and (Operation=opInsert) and
    (AComponent<>Self) and (AComponent is TComponent) and (AComponent.Owner=ParentForm) and
    not (AComponent is TComponentContainer) then
    CreateContainers;
  if not (csDestroying in ComponentState) and (Operation=opRemove) then
  begin
    StopTimer;
    if AComponent is TControl then
    begin
      if ControlIndex(TControl(AComponent))<>-1 then DeleteControl(TControl(AComponent));
    end
    else
    begin
      CC:=FindComponentContainer(AComponent);
      if Assigned(CC) then
      begin
        DeleteControl(CC);
        if Assigned(FGrabHandles) then FGrabHandles.Control:=Control;
        CC.Hide;
      end;
    end;
    if Assigned(FGrabHandles) and not (csDestroying in FGrabHandles.ComponentState) then
      FGrabHandles.Control:=Control;
    if (ControlCount=1) and (AComponent=Control.Parent) then
    begin
      Control:=nil;
      LeaveMouseAction;
    end;
    if AComponent=FPopupMenu then FPopupMenu:=nil;
    if AComponent=FDesignControl then DesignControl:=nil;
    if AComponent=ParentForm then ParentForm:=nil;
  end;
end;

function TCustomFormDesigner.FindNextControl(GoForward: Boolean): TControl;

var
  i,StartIndex: Integer;
  CurControl: TControl;
  Found: Boolean;

  function ParentsVisible(Control: TControl): Boolean;
  var
    P: TWinControl;
  begin
    if ValidControl(Control) then
    begin
      Result:=True;
      P:=Control.Parent;
      while ValidControl(P) and (P<>ParentForm) do
      begin
        if not P.Visible then
        begin
          Result:=False;
          Break;
        end;
        P:=P.Parent;
      end;
    end
    else Result:=False;
  end;

begin
  Result:=nil;
  if Assigned(Control) then
  begin
    CurControl:=Control;
    if Assigned(CurControl.Owner) then
      with CurControl.Owner do
      begin
        if ValidControl(CurControl) then
          if ComponentCount>0 then
          begin
            Found:=False;
            for StartIndex:=0 to Pred(ComponentCount) do
              if Components[StartIndex]=Control then
              begin
                Found:=True;
                Break;
              end;
            if not Found then StartIndex:=-1;
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
                CurControl.Visible and
                ParentsVisible(CurControl) and
                not IsTransparent(CurControl) and
                not IsProtected(CurControl) and
                (CurControl<>Control) then Result:=CurControl;
            end;
          until (Result<>nil) or (i=StartIndex);
        end;
      end;
  end
  else Result:=ParentForm.Controls[0];
end;

function TCustomFormDesigner.ControlAtPos(AParent: TWinControl; P: TPoint): TControl;
var
  i: Integer;
  SR: TRect;
begin
  Result:=nil;
  if AParent=nil then AParent:=ParentForm;
  if Assigned(AParent) then
    with AParent do
      for i:=0 to Pred(ControlCount) do
        with Controls[i] do
        begin
          SR:=BoundsRect;
          SR.TopLeft:=ClientToScreen(SR.TopLeft);
          SR.BottomRight:=ClientToScreen(SR.BottomRight);
          if PtInRect(SR,ClientToScreen(P)) then
          begin
            Result:=Controls[i];
            Break;
          end;
        end;
end;

function TCustomFormDesigner.FindWinControl(Wnd: DWORD): TWinControl;

  procedure FindInComponent(Wnd: HWND; Component: TComponent; var Control: TWinControl);
  var
    i: Integer;
  begin
    if Assigned(Component) and not Assigned(Control) then
      if (Component is TWinControl) then
        with TWinControl(Component) do
          if HandleAllocated and
            ValidControl(Parent) and
            (Handle=Wnd) and
            {$IFNDEF NOCSSUBCOMPONENT}
            not (csSubComponent in Component.ComponentStyle) and
            {$ENDIF}
            not IsTransparent(TControl(Component))
            then Control:=TWinControl(Component)
          else
            with Component do
              for i:=Pred(ComponentCount) downto 0 do
                FindInComponent(Wnd,Components[i],Control);
  end;

begin
  Result:=nil;
  FindInComponent(Wnd,ParentForm,Result);
end;

function TCustomFormDesigner.FindComponentContainer(AComponent: TComponent): TComponentContainer;
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

procedure TCustomFormDesigner.SaveToFile(FileName: string);

var
  F: TIniFile;
  SL: TStringList;
  i: Integer;

  procedure SaveControl(AControl: TControl);
  var
    i: Integer;
  begin
    if (AControl<>ParentForm) and
      not (AControl is TGrabHandle) and
      (AControl.Name<>'') and
      ValidControl(AControl.Parent) then
    begin
      if Assigned(FOnSaveControl) then FOnSaveControl(Self,AControl,F);
      with F,AControl do
      begin
        WriteString(Name,'Class',ClassName);
        WriteString(Name,'Parent',Parent.Name);
        WriteInteger(Name,'Left',Left);
        WriteInteger(Name,'Top',Top);
        WriteInteger(Name,'Width',Width);
        WriteInteger(Name,'Height',Height);
      end;
      if AControl is TWinControl then
        with TWinControl(AControl) do
          for i:=0 to Pred(ControlCount) do SaveControl(Controls[i]);
    end;
  end;

begin
  F:=TIniFile.Create(FileName);
  try
    SL:=TStringList.Create;
    try
      F.ReadSections(SL);
      for i:=0 to Pred(SL.Count) do F.EraseSection(SL[i])
    finally
      SL.Free;
    end;
    if Assigned(FOnSaveControl) then FOnSaveControl(Self,ParentForm,F);
    if Assigned(ParentForm) then
      with ParentForm do
        for i:=0 to Pred(ControlCount) do SaveControl(Controls[i]);
  finally
    F.Free;
  end;
end;

procedure TCustomFormDesigner.LoadFromFile(FileName: string);

var
  F: TIniFile;
  i: Integer;
  SL: TStringList;

  procedure LoadControl(AName: string);
  var
    PC: TPersistentClass;
    C: TComponent;
  begin
    with F do
    begin
      PC:=GetClass(ReadString(AName,'Class',''));
      if Assigned(PC) then
      begin
        C:=TComponentClass(PC).Create(ParentForm);
        if Assigned(C) and (C is TControl) then
        begin
          with TControl(C) do
          begin
            Name:=AName;
            Left:=ReadInteger(AName,'Left',Left);
            Top:=ReadInteger(AName,'Top',Top);
            Width:=ReadInteger(AName,'Width',Width);
            Height:=ReadInteger(AName,'Height',Height);
          end;
        end;
      end;
    end;
  end;

  procedure SetParent(AName: string);
  var
    C,P: TComponent;
  begin
    if Assigned(ParentForm) then
    begin
      C:=TControl(ParentForm.FindComponent(AName));
      if Assigned(C) and (C is TControl) then
      begin
        P:=TWinControl(ParentForm.FindComponent(F.ReadString(AName,'Parent','')));
        if Assigned(P) and (P is TWinControl) then TControl(C).Parent:=TWinControl(P)
        else TControl(C).Parent:=ParentForm;
        if Assigned(FOnLoadControl) then FOnLoadControl(Self,TControl(C),F);
      end;
    end;
  end;

begin
  if Assigned(ParentForm) then
  begin
    with ParentForm do
    begin
      i:=0;
      while i<ComponentCount do
        if Components[i] is TControl then Components[i].Free
        else Inc(i);
    end;
    F:=TIniFile.Create(FileName);
    try
      SL:=TStringList.Create;
      try
        if Assigned(FOnLoadControl) then FOnLoadControl(Self,ParentForm,F);
        F.ReadSections(SL);
        for i:=0 to Pred(SL.Count) do LoadControl(SL[i]);
        for i:=0 to Pred(SL.Count) do SetParent(SL[i]);
      finally
        SL.Free;
      end;
    finally
      F.Free;
    end;
  end;
end;

procedure TCustomFormDesigner.SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
var
  Form: TCustomForm;
  Stream: TFileStream;
  TxtStream,BinStream: TMemoryStream;
  OldOwner: TComponent;
begin
  if Assigned(ParentForm) then
  begin
    Control:=nil;
    DestroyContainers;
    try
      Stream:=TFileStream.Create(FileName,fmCreate);
      BinStream:=TMemoryStream.Create;
      try
        with TWriter.Create(BinStream,BufSize) do
        try
          Form:=ParentForm;
          if Form=Owner then
          begin
            OldOwner:=Owner;
            Form.RemoveComponent(Self);
          end
          else OldOwner:=nil;
          Form.ActiveControl:=nil;
          try
            WriteRootComponent(Form);
          finally
            if Assigned(OldOwner) then OldOwner.InsertComponent(Self);
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
        {$IFDEF TFDSAVEITSELF}
        BinStream.Clear;
        with TWriter.Create(BinStream,BufSize) do
        try
          WriteRootComponent(Self);
        finally
          Free;
        end;
        BinStream.Seek(0,soFromBeginning);
        if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
        else Stream.CopyFrom(BinStream,BinStream.Size);
        {$ENDIF}
      finally
        Stream.Free;
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
    end;
  end;
end;

procedure TCustomFormDesigner.LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
var
  Stream: TFileStream;
  TxtStream,BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      if FClearBeforeLoad or FMustClear then ClearForm;
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
        with TFDReader.Create(BinStream,Self) do
        try
          ReadRootComponent(ParentForm);
        finally
          Free;
        end;
        {$IFDEF TFDSAVEITSELF}
        if Stream.Position<Stream.Size then
        begin
          BinStream.Clear;
          if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
          else BinStream.CopyFrom(Stream,Stream.Size-Stream.Position);
          BinStream.Seek(0,soFromBeginning);
          with TFDReader.Create(BinStream,Self) do
          try
            ReadRootComponent(Self);
          finally
            Free;
          end;
        end;
        {$ENDIF}
      finally
        Stream.Free;
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
    end;
    ParentForm.Invalidate;
  end;
end;

procedure TCustomFormDesigner.SaveComponentToStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat);
var
  BinStream: TMemoryStream;
begin
  if Assigned(Component) then
  begin
    BinStream:=TMemoryStream.Create;
    try
      with TWriter.Create(BinStream,BufSize) do
      try
        Root:=ParentForm;
        WriteSignature;
        WriteComponent(Component);
      finally
        Free;
      end;
      BinStream.Seek(0,soFromBeginning);
      if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
      else Stream.CopyFrom(BinStream,BinStream.Size);
    finally
      BinStream.Free;
    end;
  end;
end;

function TCustomFormDesigner.LoadComponentFromStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat): TComponent;
var
  BinStream: TMemoryStream;
begin
  BinStream:=TMemoryStream.Create;
  try
    if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
    else BinStream.CopyFrom(Stream,Stream.Size);
    BinStream.Seek(0,soFromBeginning);
    with TFDReader.Create(BinStream,Self) do
    try
      BeginReferences;
      try
        Root:=ParentForm;
        Owner:=ParentForm;
        if Assigned(DesignControl) then Parent:=DesignControl
        else Parent:=ParentForm;
        ReadSignature;
        Result:=ReadComponent(Component);
        FixupReferences;
      finally
        EndReferences;
      end;
    finally
      Free;
    end;
  finally
    BinStream.Free;
  end;
end;

procedure TCustomFormDesigner.SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
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
        with TWriter.Create(BinStream,BufSize) do
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
      if Active then CreateContainers;
    end;
  end;
end;

procedure TCustomFormDesigner.LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      if FClearBeforeLoad or FMustClear then ClearForm;
      BinStream:=TMemoryStream.Create;
      try
        if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
        else BinStream.CopyFrom(Stream,Stream.Size);
        BinStream.Seek(0,soFromBeginning);
        with TFDReader.Create(BinStream,Self) do
        try
          ReadRootComponent(ParentForm);
        finally
          Free;
        end;
      finally
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
    end;
  end;
end;

function TCustomFormDesigner.CanCopy: Boolean;
begin
  Result:=ControlCount>0;
end;

function TCustomFormDesigner.CanPaste: Boolean;
begin
  Result:=Pos('object ',Clipboard.AsText)=1;
end;

procedure TCustomFormDesigner.CopyToClipboard;
var
  i: Integer;
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ComponentList: TList;
begin
  CheckParent(Control,False);
  if (Assigned(ParentForm)) and (ControlCount>0) then
  begin
    ComponentList:=TList.Create;
    for i:=0 to Pred(ControlCount) do
      if Controls[i] is TComponentContainer then
        ComponentList.Add(TComponentContainer(Controls[i]).Component);
    DestroyContainers;
    try
      i:=0;
      while i<ControlCount do
        if ValidControl(Controls[i].Parent) and (ControlIndex(Controls[i].Parent)<>-1) then
          DeleteControl(Controls[i])
        else Inc(i);
      BinStream:=TMemoryStream.Create;
      try
        with TWriter.Create(BinStream,BufSize) do
        try
          Root:=ParentForm;
          for i:=0 to Pred(ControlCount) do
          begin
            WriteSignature;
            WriteComponent(Controls[i]);
            if Assigned(FOnCopyComponent) then
              FOnCopyComponent(Self,Controls[i]);
          end;
          with ComponentList do
            for i:=0 to Pred(Count) do
            begin
              WriteSignature;
              WriteComponent(TComponent(Items[i]));
              if Assigned(FOnCopyComponent) then
                FOnCopyComponent(Self,TComponent(Items[i]));
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
    finally
      if Active then CreateContainers;
      with ComponentList do
      begin
        for i:=0 to Pred(Count) do
          AddControl(FindComponentContainer(TComponent(Items[i])));
        Free;
      end;
    end;
  end;
end;

procedure TCustomFormDesigner.CutToClipboard;
begin
  CopyToClipboard;
  while ControlCount>0 do
  begin
    if Controls[0] is TComponentContainer then
      TComponentContainer(Controls[0]).Component.Free;
    Controls[0].Free;
  end;
end;

procedure TCustomFormDesigner.PasteFromClipboard;
var
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ParentControl: TWinControl;
  NewComponent: TComponent;
  Container: TComponentContainer;
begin
  if (Assigned(ParentForm)) and (Clipboard.AsText<>'') then
  begin
    StringStream:=TStringStream.Create(Clipboard.AsText);
    if StringStream.Size>0 then
      try
        if ValidControl(Control) then
          if Control is TWinControl then ParentControl:=TWinControl(Control)
          else ParentControl:=Control.Parent
        else ParentControl:=ParentForm;
        while ValidControl(ParentControl) and not (csAcceptsControls in ParentControl.ControlStyle) do
          ParentControl:=ParentControl.Parent;
        if not ValidControl(ParentControl) then ParentControl:=ParentForm;
        Control:=nil;
        BinStream:=TMemoryStream.Create;
        try
          while StringStream.Position<StringStream.Size do
          begin
            BinStream.Seek(0,soFromBeginning);
            ObjectTextToBinary(StringStream,BinStream);
            BinStream.Seek(0,soFromBeginning);
            with TFDReader.Create(BinStream,Self) do
            try
              BeginReferences;
              try
                Root:=ParentForm;
                Owner:=ParentForm;
                Parent:=ParentControl;
                ReadSignature;
                NewComponent:=ReadComponent(nil);
                if Assigned(FOnPasteComponent) then FOnPasteComponent(Self,NewComponent);
                if FActive then
                  if NewComponent is TControl then AddControl(TControl(NewComponent))
                  else
                  begin
                    Container:=FindComponentContainer(NewComponent);
                    if Assigned(Container) then
                    begin
                      with NewComponent do
                        SetWindowPos(Container.Handle,0,LoWord(DesignInfo),HiWord(DesignInfo),0,0,SWP_NOSIZE or SWP_NOZORDER);
                      Container.UpdateContainer;
                      AddControl(Container);
                    end;
                  end;
                FixupReferences;
              finally
                EndReferences;
              end;
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
end;

function TCustomFormDesigner.GetComponentProperties(AComponent: TComponent): string;
var
  B: TMemoryStream;
  S: TStringStream;
begin
  if Assigned(AComponent) then
  begin
    B:=TMemoryStream.Create;
    S:=TStringStream.Create('');
    try
      B.WriteComponent(AComponent);
      B.Seek(0,soFromBeginning);
      ObjectBinaryToText(B,S);
      Result:=S.DataString;
    finally
      S.Free;
      B.Free;
    end;
  end
  else Result:='';
end;

procedure TCustomFormDesigner.SetComponentProperties(AComponent: TComponent; Props: string);
var
  B: TMemoryStream;
  S: TStringStream;
begin
  if Assigned(AComponent) then
  begin
    B:=TMemoryStream.Create;
    S:=TStringStream.Create(Props);
    try
      ObjectTextToBinary(S,B);
      B.Seek(0,soFromBeginning);
      B.ReadComponent(AComponent);
    finally
      S.Free;
      B.Free;
    end;
  end;
end;

procedure TCustomFormDesigner.AlignToGrid(TheControl: TControl);
begin
  if FActive and ValidControl(TheControl) and not IsLocked(TheControl) and not IsTransparent(TheControl) and not IsProtected(TheControl) then
    with TheControl do
    begin
      {$IFDEF GFDADVANCEDGRID}
      if Left mod FGridStepX < FGridStepX div 2 then Left:=Left div FGridStepX * FGridStepX
      else Left:=Succ(Left div FGridStepX) * FGridStepX;
      if Top mod FGridStepY < FGridStepY div 2 then Top:=Top div FGridStepY * FGridStepY
      else Top:=Succ(Top div FGridStepY) * FGridStepY;
      {$ELSE}
      if Left mod FGridStep < FGridStep div 2 then Left:=Left div FGridStep * FGridStep
      else Left:=Succ(Left div FGridStep) * FGridStep;
      if Top mod FGridStep < FGridStep div 2 then Top:=Top div FGridStep * FGridStep
      else Top:=Succ(Top div FGridStep) * FGridStep;
      {$ENDIF}
      FGrabHandles.Update(False);
      if (ControlCount>1) and (ControlIndex(TheControl)<>-1) then DrawMultiSelect(TheControl);
    end;
end;

function TCustomFormDesigner.EditControlLists(DefaultList: TListType): Boolean;
begin
  Result:=EditLists(Self,DefaultList);
end;

function TCustomFormDesigner.AlignDialog: Boolean;
begin
  Result:=False;
  with TfrmAlign.Create(Application) do
  try
    Result:=ShowModal=mrOk;
    if Result then
      AlignControls(TAlignMode(rgrHorizontal.ItemIndex),TAlignMode(rgrVertical.ItemIndex));
  except
    Free;
  end;
end;

function TCustomFormDesigner.SizeDialog: Boolean;
var
  W,H: TSizeMode;

  function GetInt(S: string): Integer;
  begin
    if S='' then Result:=0
    else Result:=StrToInt(S);
  end;

begin
  Result:=False;
  with TfrmSize.Create(Application) do
  try
    Result:=ShowModal=mrOk;
    if Result then
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
  except
    Free;
  end;
end;

function TCustomFormDesigner.TabOrderDialog: Boolean;
var
  PC: TWinControl;
  i: Integer;
  List: TList;
begin
  with TfrmTabOrder.Create(Application) do
  try
    CheckParent(Control,False);
    if ValidControl(Control) then
    begin
      if Control is TWinControl then PC:=TWinControl(Control)
      else PC:=Control.Parent;
      while ValidControl(PC) and (PC.ControlCount=0) do PC:=PC.Parent;
      if not ValidControl(PC) then PC:=ParentForm;
    end
    else PC:=ParentForm;
    List:=TList.Create;
    try
      PC.GetTabOrderList(List);
      for i:=0 to Pred(List.Count) do
        if not Assigned(FGrabHandles)
          or (Assigned(FGrabHandles)
            and not FGrabHandles.IsGrabHandle(TControl(List[i])))
            and not (TControl(List[i]) is TComponentContainer) then
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
      Result:=ShowModal=mrOk;
      if Result then
        for i:=0 to Pred(Count) do
          (Objects[i] as TWinControl).TabOrder:=i;
    end;
  finally
    Free;
  end;
end;

procedure TCustomFormDesigner.ShowAlignmentPalette;
begin
  with FAPForm do
  begin
    if apStayOnTop in FAlignmentPalette then FormStyle:=fsStayOnTop
    else FormStyle:=fsNormal;
    Show;
  end;
end;

procedure TCustomFormDesigner.HideAlignmentPalette;
begin
  FAPForm.Hide;
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

procedure TCustomFormDesigner.AlignControls(Hor,Ver: TAlignMode);
var
  i,Val,Min,Max: Integer;
begin
  if FActive then
  begin
    CheckParent(Control,True);
    if ControlCount>0 then
    begin
      with TList.Create do
      try
        for i:=0 to Pred(ControlCount) do
          if not IsLocked(Controls[i]) then Add(Controls[i]);
        case Hor of
          amLeftTop:
            if ControlCount>1 then
            begin
              Sort(LeftSort);
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  Controls[i].Left:=TControl(Items[0]).Left;
            end;
          amCenters:
            if ControlCount>1 then
            begin
              Sort(LeftSort);
              Val:=TControl(Items[0]).Left;
              Sort(RightSort);
              with TControl(Items[Pred(Count)]) do Val:=(Val+Left+Width) div 2;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Left:=Val-Width div 2;
            end;
          amRightBottom:
            if ControlCount>1 then
            begin
              Sort(RightSort);
              with TControl(Items[Pred(Count)]) do Val:=Left+Width;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Left:=Val-Width;
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
            for i:=0 to Pred(ControlCount) do
              with Controls[i] do
              begin
                if Left<Min then Min:=Left;
                if Left+Width>Max then Max:=Left+Width;
              end;
            for i:=0 to Pred(ControlCount) do
              if not IsLocked(Controls[i]) then
                with Controls[i] do Left:=Left+(Val-Max+Min) div 2-Min;
          end;
        end;
        case Ver of
          amLeftTop:
            if ControlCount>1 then
            begin
              Sort(TopSort);
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  Controls[i].Top:=TControl(Items[0]).Top;
            end;
          amCenters:
            if ControlCount>1 then
            begin
              Sort(TopSort);
              Val:=TControl(Items[0]).Top;
              Sort(BottomSort);
              with TControl(Items[Pred(Count)]) do Val:=(Val+Top+Height) div 2;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Top:=Val-Height div 2;
            end;
          amRightBottom:
            if ControlCount>1 then
            begin
              Sort(BottomSort);
              with TControl(Items[Pred(Count)]) do Val:=Top+Height;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Top:=Val-Height;
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
            for i:=0 to Pred(ControlCount) do
              with Controls[i] do
              begin
                if Top<Min then Min:=Top;
                if Top+Height>Max then Max:=Top+Height;
              end;
            for i:=0 to Pred(ControlCount) do
              if not IsLocked(Controls[i]) then
                with Controls[i] do Top:=Top+(Val-Max+Min) div 2-Min;
          end;
        end;
      finally
        Free;
      end;
      if ControlCount>1 then
        for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i])
      else
      begin
        Control.Invalidate;
        FGrabHandles.Update(False);
      end;
      Application.ProcessMessages;
      DoMoveSizeControl;
      DoChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SizeControls(WMode: TSizeMode; WValue: Integer; HMode: TSizeMode; HValue: Integer);
var
  i,Val: Integer;
begin
  if FActive then
  begin
    CheckParent(Control,True);
    if ControlCount>0 then
    begin
      case WMode of
        smToSmallest:
        begin
          Val:=MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Width<Val then Val:=Width;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width:=Val;
        end;
        smToLargest:
        begin
          Val:=-MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Width>Val then Val:=Width;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width:=Val;
        end;
        smValue:
        begin
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width:=WValue;
        end;
      end;
      case HMode of
        smToSmallest:
        begin
          Val:=MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Height<Val then Val:=Height;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height:=Val;
        end;
        smToLargest:
        begin
          Val:=-MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Height>Val then Val:=Height;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height:=Val;
        end;
        smValue:
        begin
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height:=HValue;
        end;
      end;
      if ControlCount>1 then
        for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i])
      else
      begin
        Control.Invalidate;
        FGrabHandles.Update(False);
      end;
      Application.ProcessMessages;
      DoMoveSizeControl;
      DoChange;
    end;
  end;
end;

procedure TCustomFormDesigner.Lock;
begin
  Inc(FLockCounter);
end;

procedure TCustomFormDesigner.Unlock;
begin
  if FLockCounter>0 then Dec(FLockCounter);
  if GetCapture=ParentForm.Handle then ReleaseCapture;
end;

procedure TCustomFormDesigner.SynchroLock;
begin
  Inc(FSynchroLockCounter);
end;

procedure TCustomFormDesigner.SynchroUnlock;
begin
  if FSynchroLockCounter>0 then Dec(FSynchroLockCounter);
end;

procedure TCustomFormDesigner.LeaveMouseAction;
begin
  if FActive and (FMouseAction<>maNone) then
  begin
    case FMouseAction of
      maDragging: DrawDragRects;
      maSelecting: DrawSelectRect;
    end;
    ReleaseCapture;
    ClipCursor(nil);
    HideHint;
    FMouseAction:=maNone;
    if Assigned(FGrabHandles) then FGrabHandles.Visible:=ValidControl(Control);
    if ValidControl(Control) then FDragRect:=Control.BoundsRect;
  end;
end;

procedure TCustomFormDesigner.AddControl(AControl: TControl);
var
  Index: Integer;
  OldControl: TControl;
begin
  OldControl:=nil;
  if Assigned(FGrabHandles) and FGrabHandles.IsGrabHandle(AControl) then Exit;
  if ValidControl(AControl) then
  begin
    {$IFDEF TFDTRIAL}
    if ValidControl(AControl) and (AControl.Parent<>ParentForm) then
    begin
      ShowTrialWarning;
      Exit;
    end;
    {$ENDIF}
    with FControls do
    begin
      Index:=IndexOf(AControl);
      if Index=-1 then
      begin
        OldControl:=Control;
        Insert(0,AControl);
        AControl.FreeNotification(Self);
        Application.ProcessMessages;
        DoAddControl(AControl);
        DoSelectControl(AControl);
        DoSelectionChange;
      end;
      if ControlCount>1 then DrawMultiSelect(AControl)
      else AControl.Invalidate;
      if Assigned(FGrabHandles) then FGrabHandles.Control:=AControl;
      if Assigned(OldControl) then DrawMultiSelect(OldControl);
    end;
  end;
end;

procedure TCustomFormDesigner.DeleteControl(AControl: TControl);
var
  Index: Integer;
begin
  with FControls do
  begin
    Index:=IndexOf(AControl);
    if Index<>-1 then
    begin
      Delete(Index);
      {$IFNDEF NOREMOVENOTIFICATION}
      AControl.RemoveFreeNotification(Self);
      {$ENDIF}
      try
        if ValidControl(AControl.Parent) then
          if AControl is TWinControl then
            RedrawWindow(TWinControl(AControl).Handle,nil,0,RDW_INVALIDATE or RDW_ALLCHILDREN)
          else AControl.Invalidate;
      except
      end;
      if Assigned(FGrabHandles) then
        if FGrabHandles.Control=AControl then FGrabHandles.Control:=Control;
      Application.ProcessMessages;
      DoDeleteControl(AControl);
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.AddComponent(AComponent: TComponent);
begin
  AddControl(FindComponentContainer(AComponent));
end;

procedure TCustomFormDesigner.DeleteComponent(AComponent: TComponent);
begin
  DeleteControl(FindComponentContainer(AComponent));
end;

procedure TCustomFormDesigner.SelectAll;
var
  i: Integer;
begin
  SynchroLock;
  try
    if Assigned(ParentForm) then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
          if (Components[i] is TControl) and
            TControl(Components[i]).Visible and
            ValidControl(TControl(Components[i]).Parent) and
            TControl(Components[i]).Parent.Showing and
            not FGrabHandles.IsGrabHandle(TControl(Components[i])) and
            not IsProtected(TControl(Components[i])) and
            not IsTransparent(TControl(Components[i])) then AddControl(TControl(Components[i]));
  finally
    SynchroUnlock;
  end;
  DoSelectionChange;
end;

procedure TCustomFormDesigner.UnselectAll;
begin
  Control:=nil;
end;

procedure TCustomFormDesigner.ClearControls;
begin
  with FControls do
    while Count>0 do DeleteControl(Controls[0]);
end;

function TCustomFormDesigner.ControlIndex(AControl: TControl): Integer;
begin
  if Assigned(FControls) then Result:=FControls.IndexOf(AControl)
  else Result:=-1;
end;

procedure TCustomFormDesigner.DrawGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType);
begin
  with Canvas do
  begin
    case GrabType of
      gtNormal:
      begin
        Pen.Color:=FNormalGrabBorder;
        Brush.Color:=FNormalGrabFill;
      end;
      gtMulti:
      begin
        Pen.Color:=FMultiGrabBorder;
        Brush.Color:=FMultiGrabFill;
      end;
      gtLocked:
      begin
        Pen.Color:=FLockedGrabBorder;
        Brush.Color:=FLockedGrabFill;
      end;
    end;
    with R do Rectangle(Left,Top,Right,Bottom);
  end;
end;

procedure TCustomFormDesigner.UpdateGrabs;
begin
  if Assigned(FNormalGrab) then
    with FNormalGrab do
    begin
      Width:=FGrabSize;
      Height:=FGrabSize;
      DrawGrab(Canvas,Rect(0,0,FGrabSize,FGrabSize),gtNormal);
    end;
  if Assigned(FMultiGrab) then
    with FMultiGrab do
    begin
      Width:=FGrabSize;
      Height:=FGrabSize;
      DrawGrab(Canvas,Rect(0,0,FGrabSize,FGrabSize),gtMulti);
    end;
  if Assigned(FLockedGrab) then
    with FLockedGrab do
    begin
      Width:=FGrabSize;
      Height:=FGrabSize;
      DrawGrab(Canvas,Rect(0,0,FGrabSize,FGrabSize),gtLocked);
    end;
  if Assigned(FGrabHandles) then FGrabHandles.Update(True);
end;

procedure TCustomFormDesigner.PlaceComponentClass(AComponentClass: TComponentClass);
var
  CC: TComponentContainer;
begin
  Lock;
  FWaiting:=True;
  FPlacedComponent:=AComponentClass.Create(ParentForm);
  if not (FPlacedComponent is TControl) then
  begin
    CC:=FindComponentContainer(FPlacedComponent);
    if Assigned(CC) then CC.Visible:=False;
  end;
end;

procedure TCustomFormDesigner.PlaceComponentClassName(AClassName: TComponentName);
var
  CC: TComponentClass;
begin
  CC:=TComponentClass(GetClass(AClassName));
  if Assigned(CC) then PlaceComponentClass(CC);
end;

procedure TCustomFormDesigner.CancelPlacing;
begin
  FPlacedComponent.Free;
  FWaiting:=False;
  Unlock;
end;

function TCustomFormDesigner.GetComponentHint(AComponent: TComponent): string;
begin
  if Assigned(AComponent) then
  begin
    if AComponent is TComponentContainer then AComponent:=TComponentContainer(AComponent).Component;
    if Assigned(AComponent) then
    begin
      with AComponent do Result:=Format('%s: %s',[Name,ClassName]);
      if Assigned(FOnComponentHint) then FOnComponentHint(Self,AComponent,Result);
    end
    else Result:='';
  end
  else Result:='';
end;

function TCustomFormDesigner.GetComponentCaption(AComponent: TComponent): string;
begin
  if Assigned(AComponent) then
    if AComponent.Name<>'' then Result:=AComponent.Name
    else Result:=AComponent.ClassName
  else Result:='[none]';
  if Assigned(FOnComponentCaption) then FOnComponentCaption(Self,AComponent,Result);
end;

procedure TCustomFormDesigner.ApplicationIdle(Sender: TObject; var Done: Boolean);
var
  i: Integer;
  OldDesigning: Boolean;
begin
  if not (csDestroying in ParentForm.ComponentState) and (MouseAction=maNone) then
  begin
    if Assigned(ParentForm) and ParentForm.HandleAllocated then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
        begin
          if (Components[i] is TControl) and not IsProtected(TControl(Components[i])) then
          begin
            OldDesigning:=csDesigning in Components[i].ComponentState;
            if not (Components[i] is TCustomForm) then TDesignAccessComponent(Components[i]).SetDesigningPublic(FActive);
            if (OldDesigning xor (csDesigning in Components[i].ComponentState)) and (Components[i] is TControl) then
            begin
              TControl(Components[i]).Invalidate;
              ParentForm.Invalidate;
            end;
          end;
        end;
    with FControls do
      if Count>1 then
        for i:=0 to Pred(Count) do DrawMultiSelect(Controls[i]);
    if Assigned(FGrabHandles) then FGrabHandles.Update(False);
  end;
  if Assigned(ParentForm) then
    with ParentForm do
      if not IsProtected(ActiveControl) then ActiveControl:=nil;
  Done:=True;
  if Assigned(SavedApplicationIdle) then SavedApplicationIdle(Sender,Done);
end;

procedure TCustomFormDesigner.ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
var
  i,ILockCounter: Integer;
begin
  if Assigned(Designers) then
    for i:=0 to Pred(Designers.Count) do
      with TCustomFormDesigner(Designers[i]) do
      begin
        ILockCounter:=FLockCounter;
        try
          MessageProc(Msg);
        finally
          if FLockCounter>ILockCounter then FLockCounter:=ILockCounter;
          if Locked and InParentForm(Msg.hwnd) then
            case Msg.Message of
              WM_LBUTTONUP,WM_NCLBUTTONUP,WM_RBUTTONUP,WM_NCRBUTTONUP:
              begin
                Unlock;
                MessageProc(Msg);
              end;
            end;
        end;
      end;
  if Assigned(SavedApplicationMessage) then SavedApplicationMessage(Msg,Handled);
end;

procedure TCustomFormDesigner.TimerEvent(Sender: TObject);
begin
  if FShowComponentHint and (Integer(FHintTimer.Interval)=Application.HintPause) then
  begin
    ShowHint(GetComponentHint(FHintControl),hmCustom);
    FHintTimer.Interval:=Application.HintHidePause;
  end
  else
  begin
    FHintTimer.Enabled:=False;
    HideHint;
  end;
end;

procedure TCustomFormDesigner.StartTimer(AInterval: Integer);
begin
  with FHintTimer do
  begin
    Interval:=AInterval;
    Enabled:=True;
  end;
end;

procedure TCustomFormDesigner.StopTimer;
begin
  if Assigned(FHintTimer) then FHintTimer.Enabled:=False;
end;

procedure TCustomFormDesigner.MessageProc(var Msg: TMSG);

type
  TKeyType = (ktSelect,ktMove,ktFastMove,ktSize);

var
  NewControl: TControl;
  NewDrag,P,Min,Max: TPoint;
  R: TRect;
  KeyType: TKeyType;
  Key: Word;
  i: Integer;
  Handled: Boolean;
  WinControl: TWinControl;
  CC: TComponentContainer;

  procedure ProcessKey(Key: Word);
  var
    R: TRect;
    i: Integer;

    procedure GrowRect(var R: TRect; X,Y: Integer);
    begin
      Inc(R.Right,X);
      Inc(R.Bottom,Y);
    end;

    procedure CheckRect(AControl: TControl; var R: TRect);
    var
      Limit: TRect;
    begin
      if ValidControl(AControl) and ValidControl(AControl.Parent) then
        with AControl.Parent,R do
          if KeyType=ktSize then
          begin
            Min:=Point(0,0);
            Max:=Point(MaxInt,MaxInt);
            if Assigned(FOnSizeLimit) then FOnSizeLimit(Self,Control,Min,Max);
            if Right-Left<Min.X then Right:=Left+Min.X;
            if Bottom-Top<Min.Y then Bottom:=Top+Min.Y;
            if Right-Left>Max.X then Right:=Left+Max.X;
            if Bottom-Top>Max.Y then Bottom:=Top+Max.Y;
          end
          else
          begin
            Limit:=ClientRect;
            if Assigned(FOnMoveLimit) then FOnMoveLimit(Self,AControl,Limit);
            if Left<Limit.Left then OffsetRect(R,Limit.Left-Left,0);
            if Top<Limit.Top then OffsetRect(R,0,Limit.Left-Top);
            if Right>Limit.Right-FGrabSize div 2 then OffsetRect(R,Limit.Right-Right-FGrabSize div 2,0);
            if Bottom>Limit.Bottom-FGrabSize div 2 then OffsetRect(R,0,Limit.Bottom-Bottom-FGrabSize div 2);
          end;
    end;

  begin
    if KeyType=ktMove then
    begin
      i:=0;
      while i<ControlCount do
        if (Controls[i].Parent<>Control.Parent) or
          IsLocked(Controls[i]) then DeleteControl(Controls[i])
        else Inc(i);
    end;
    for i:=0 to Pred(ControlCount) do
      if ValidControl(Controls[i]) then
        with Controls[i] do
        begin
          R:=BoundsRect;
          case Key of
            VK_RIGHT:
              case KeyType of
                ktSelect: Control:=FindNextControl(True);
                ktMove: OffsetRect(R,1,0);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,FGridStepX,0);
                {$ELSE}
                ktFastMove: OffsetRect(R,FGridStep,0);
                {$ENDIF}
                ktSize: GrowRect(R,1,0);
              end;
            VK_LEFT:
              case KeyType of
                ktSelect: Control:=FindNextControl(False);
                ktMove: OffsetRect(R,-1,0);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,-FGridStepX,0);
                {$ELSE}
                ktFastMove: OffsetRect(R,-FGridStep,0);
                {$ENDIF}
                ktSize: GrowRect(R,-1,0);
              end;
            VK_UP:
              case KeyType of
                ktSelect: Control:=FindNextControl(False);
                ktMove: OffsetRect(R,0,-1);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,0,-FGridStepY);
                {$ELSE}
                ktFastMove: OffsetRect(R,0,-FGridStep);
                {$ENDIF}
                ktSize: GrowRect(R,0,-1);
              end;
            VK_DOWN:
              case KeyType of
                ktSelect: Control:=FindNextControl(True);
                ktMove: OffsetRect(R,0,1);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,0,FGridStepY);
                {$ELSE}
                ktFastMove: OffsetRect(R,0,FGridStep);
                {$ENDIF}
                ktSize: GrowRect(R,0,1);
              end;
          end;
          if (KeyType<>ktSelect) and Assigned(ParentForm) then
          begin
            CheckRect(Controls[i],R);
            if not EqualRect(BoundsRect,R) then
            begin
              BoundsRect:=R;
              if ValidControl(Controls[i]) and Assigned(Parent) then
                MapWindowPoints(Parent.Handle,ParentForm.Handle,R,2);
              if ControlCount>1 then DrawMultiSelect(Controls[i]);
              if Assigned(FGrabHandles) then FGrabHandles.Update(False);
              Application.ProcessMessages;
              DoMoveSizeControl;
            end;
          end
          else Break;
        end;
    DoChange;
  end;

  function GetMouseControl(Wnd: HWND; LParam: Integer): TControl;

  var
    Child: TControl;
    ParentPoint: TPoint;
    {$IFNDEF NOFRAMES}
    i: Integer;
    OrgWnd: HWND;
    {$ENDIF}

    function TopLevel(AOwner: TComponent; C: TControl): Boolean;
    begin
      Result:=False;
      if Assigned(C) then
        with C do
          Result:=(C.Owner=AOwner) or (Owner is TCustomForm)
          {$IFNDEF NOFRAMES}
          or (Owner is TCustomFrame)
          {$ENDIF}
          ;
    end;

    function ControlAtPos: TControl;
    var
      i: Integer;

      function FormRect(Control: TControl): TRect;
      begin
        if ValidControl(Control) and ValidControl(Control.Parent) then
        begin
          Result:=Control.BoundsRect;
          with Result do
          begin
            TopLeft:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(TopLeft));
            BottomRight:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(BottomRight));
          end;
        end
        else Result:=Rect(0,0,0,0);
      end;

    begin
      if Assigned(ParentForm) then
        with ParentForm do
        begin
          Result:=ControlAtPos(ParentPoint,True);
          if IsTransparent(Result) or not TopLevel(ParentForm,Result) then Result:=nil;
          if not ValidControl(Result) or IsTransparent(Result) then
            for i:=Pred(ComponentCount) downto 0 do
              if (Components[i] is TControl) and (ValidControl(TControl(Components[i]))) then
                if TControl(Components[i]).Visible and
                  PtInRect(FormRect(TControl(Components[i])),ParentPoint) and
                  not IsTransparent(TControl(Components[i])) and
                  TopLevel(ParentForm,TControl(Components[i])) then
                begin
                  Result:=TControl(Components[i]);
                  Break;
                end;
        end
      else Result:=nil;
    end;

    function ControlAtPoint(C: TWinControl; P: TPoint): TControl;
    var
      i: Integer;
    begin
      Result:=nil;
      with C do
        for i:=Pred(ControlCount) downto 0 do
          if PtInRect(Controls[i].BoundsRect,P) and
            ((csDesigning in Controls[i].ComponentState) or Controls[i].Visible) then
          begin
            Result:=Controls[i];
            Break;
          end;
    end;

  begin
    ParentPoint:=Point(LoWord(LParam),HiWord(LParam));
    MapWindowPoints(Wnd,ParentForm.Handle,ParentPoint,1);
    {$IFNDEF NOFRAMES}
    OrgWnd:=Wnd;
    {$ENDIF}
    if Assigned(FGrabHandles) then Result:=FGrabHandles.FindHandleControl(Wnd)
    else Result:=nil;
    if not ValidControl(Result) then
    begin
      Result:=FindWinControl(Wnd);
      if ValidControl(Result) then
      begin
        Child:=ControlAtPoint((Result as TWinControl),(Point(LoWord(LParam),HiWord(LParam))));
        if not TopLevel(ParentForm,Child) then Child:=nil;
      end
      else Child:=nil;
      if ValidControl(Child) then Result:=Child
      else
      begin
        if Result=nil then
          while (Wnd<>0) and not ValidControl(Result) do
          begin
            Wnd:=Windows.GetParent(Wnd);
            Result:=FindWinControl(Wnd);
          end;
        if Result=nil then Result:=ControlAtPos;
      end;
    end;
    {$IFNDEF NOFRAMES}
    if Result is TCustomFrame then
      with TCustomFrame(Result) do
      begin
        for i:=Pred(ComponentCount) downto 0 do
          if Components[i] is TWinControl then
            if TWinControl(Components[i]).Handle=OrgWnd then
            begin
              Result:=TControl(Components[i]);
              Break;
            end;
        if ValidControl(Result) and (Result is TWinControl) then
        begin
          Child:=(Result as TWinControl).ControlAtPos(Point(LoWord(LParam),HiWord(LParam)),True);
          if not TopLevel(Result,Child) then Child:=nil;
        end
        else Child:=nil;
        if ValidControl(Child) then Result:=Child
      end;
    {$ENDIF}
    if Assigned(FGrabHandles) and not FGrabHandles.IsGrabHandle(Result) then
    begin
      while Assigned(Result) and not TopLevel(ParentForm,Result) do Result:=Result.Parent;
      while Assigned(Result) and IsTransparent(Result) do Result:=Result.Parent;
      if Result=ParentForm then Result:=nil;
    end;
  end;

  function SelectableParent(AControl: TControl): TControl;
  begin
    if ValidControl(AControl) then
    begin
      Result:=AControl.Parent;
      while ValidControl(Result) and
        (Result<>ParentForm) and
        (IsLocked(Result) or IsTransparent(Result) or IsProtected(Result)) do
        Result:=Result.Parent;
      if Result=ParentForm then Result:=nil;
    end
    else Result:=nil;
  end;

  function NormalRect(Rect: TRect): TRect;
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

  function GetPopupParent(W: HWND): HWND;
  begin
    Result:=W;
    if Assigned(ParentForm) then
      while (W<>0) and (W<>ParentForm.Handle) and (W<>Application.Handle) do
      begin
        W:=GetParent(W);
        if (W<>0) and (W<>Application.Handle) then Result:=W;
      end;
  end;

  function IsActiveOwner: Boolean;
  var
    F: TWinControl;
  begin
    Result:=Application.Active and IsLibrary;
    if not Result then
    begin
      F:=ParentForm;
      while ValidControl(F) do
      begin
        if (Screen.ActiveForm=F) or
          (Screen.ActiveForm<>nil) and (Screen.ActiveForm.ActiveMDIChild=F) then
        begin
          Result:=True;
          Break
        end;
        F:=F.Parent;
      end;
    end;
  end;

  function FindControlHandle(C: TComponent; W: HWND): Boolean;
  var
    i: Integer;
  begin
    Result:=False;
    with C do
      for i:=0 to Pred(ComponentCount) do
        if Components[i] is TWinControl then
          with TWinControl(Components[i]) do
            if HandleAllocated and (Handle=W) then
            begin
              Result:=True;
              Break;
            end;
    if not Result then
    begin
      W:=GetParent(W);
      if (W<>0) and (W<>ParentForm.Handle) then Result:=FindControlHandle(C,W);
    end;
  end;

  function IsProtectedHandle(W: HWND): Boolean;
  var
    C: TWinControl;
  begin
    Result:=False;
    while W<>0 do
    begin
      C:=FindControl(W);
      if ValidControl(C) and IsProtected(C) then
      begin
        Result:=True;
        Break;
      end;
      W:=GetParent(W);
    end;
  end;

  function InParentForm(WND: HWND): Boolean;
  begin
    Result:=False;
    while WND<>0 do
    begin
      if WND=ParentForm.Handle then
      begin
        Result:=True;
        Exit;
      end;
      WND:=GetParent(WND);
    end;
  end;

  function InDesignControl(WND: HWND): Boolean;
  var
    C: TWinControl;
  begin
    if not Assigned(DesignControl) then Result:=InParentForm(WND)
    else
    begin
      Result:=False;
      C:=FindControl(WND);
      if Assigned(C) then
        while Assigned(C) do
        begin
          if C=DesignControl then
          begin
            Result:=True;
            Break;
          end;
          C:=C.Parent;
        end;
    end;
  end;

  function AutoName(Component: TComponent): Boolean;
  var
    i: Integer;
    CN: string;
  begin
    Result:=False;
    if Assigned(Component) then
      with ParentForm,Component do
      begin
        if (Name='') or Assigned(ParentForm.FindComponent(Name)) then
        begin
          CN:=Copy(ClassName,2,Pred(Length(ClassName)));
          for i:=1 to 32768 do
            if not Assigned(ParentForm.FindComponent(CN+IntToStr(i))) then
            begin
              Name:=CN+IntToStr(i);
              Result:=True;
              Break;
            end;
        end;
      end;
  end;

begin
  if not Assigned(DesignControl) and Assigned(ParentForm) and ParentForm.HandleAllocated then
    if GetWindowLong(ParentForm.Handle,GWL_WNDPROC)<>Integer(FWinProc) then
    begin
      SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FDefaultProc));
      FDefaultProc:=TFarProc(GetWindowLong(ParentForm.Handle,GWL_WNDPROC));
      SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FWinProc));
    end;
  if not Locked then
    if Assigned(ParentForm) and IsActiveOwner then
    begin
      Lock;
      with Msg do
        case Message of
          WM_MOVE,WM_SIZE:
            if hwnd=ParentForm.Handle then UpdateGrabs;
          CM_DEACTIVATE: LeaveMouseAction;
          WM_PAINT:
            if (hwnd<>ParentForm.Handle) and Assigned(FHintWindow) and (hwnd<>FHintWindow.Handle) and (MouseAction=maDragging) then
              Message:=0;
          WM_LBUTTONDBLCLK,WM_RBUTTONDBLCLK,WM_MBUTTONDBLCLK,
          WM_NCLBUTTONDBLCLK,WM_NCRBUTTONDBLCLK,WM_NCMBUTTONDBLCLK:
          begin
            GetCursorPos(P);
            NewControl:=GetMouseControl(hwnd,LParam);
            if (FClickPos.X=P.X) and (FClickPos.Y=P.Y) then
            begin
              if ValidControl(NewControl) and not IsProtected(NewControl) then
              begin
                if (Message=WM_LBUTTONDBLCLK) or (Message=WM_NCLBUTTONDBLCLK) then
                  if Assigned(FOnControlDblClick) then FOnControlDblClick(Self,NewControl);
                Message:=0;
              end;
              if (hwnd<>ParentForm.Handle) and not IsProtectedHandle(hwnd) and
                InParentForm(hwnd) then Message:=0;
              if not ValidControl(NewControl) and (hwnd<>ParentForm.Handle) and
                InParentForm(hwnd) then Message:=0;
              if ValidControl(Control) and (Control=NewControl) then Message:=0;
            end
            else
              if Assigned(NewControl) then Message:=0;
          end;
          WM_RBUTTONDOWN,WM_NCRBUTTONDOWN:
          begin
            NewControl:=GetMouseControl(hwnd,LParam);
            if ValidControl(NewControl) then
              if not IsProtected(NewControl) then
              begin
                {$IFDEF TFDTRIAL}
                if NewControl.Parent<>ParentForm then
                begin
                  Message:=0;
                  ShowTrialWarning;
                  Exit;
                end;
                {$ENDIF}
                FMenuControl:=NewControl;
                if ControlIndex(NewControl)=-1 then Control:=NewControl;
              end
              else FMenuControl:=nil
            else FMenuControl:=nil;
            if hwnd=ParentForm.Handle then FMenuControl:=ParentForm;
          end;
          WM_RBUTTONUP,WM_NCRBUTTONUP:
          begin
            Handled:=False;
            if Assigned(FOnContextPopup) then
              FOnContextPopup(Self,Handled);
            if not Handled and ValidControl(FMenuControl) and
              ((GetMouseControl(hwnd,LParam)=FMenuControl) or (FMenuControl=ParentForm)) then
            begin
              if Assigned(FPopupMenu) then
              begin
                GetCursorPos(NewDrag);
                with NewDrag do
                begin
                  Lock;
                  try
                    FPopupMenu.Popup(X,Y);
                  finally
                    Unlock;
                  end;
                end;
              end;
              Message:=0;
            end
            else Message:=0;
          end;
          WM_LBUTTONDOWN{,WM_NCLBUTTONDOWN}:
          begin
            if GetCapture=ParentForm.Handle then ReleaseCapture;
            GetCursorPos(FClickPos);
            HideHint;
            if not InDesignControl(hwnd) then Exit;
            if (Message=WM_NCLBUTTONDOWN) and
              ((hwnd=ParentForm.Handle) and (wParam<>HTCLIENT)) then Exit;
            if GetPopupParent(hwnd)<>ParentForm.Handle then Exit;
            if (hwnd<>ParentForm.Handle) and
              not FindControlHandle(ParentForm,hwnd) and
              (not Assigned(FGrabHandles) or not Assigned(FGrabHandles.FindHandleControl(hwnd))) then Exit;
            if TForm(ParentForm).FormStyle=fsMDIChild then SendMessage(ParentForm.Handle,WM_MDIACTIVATE,0,ParentForm.Handle);
            NewControl:=GetMouseControl(hwnd,lParam);
            if Assigned(NewControl) and (NewControl.Perform(CM_DESIGNHITTEST,wParam,lParam)<>0) then Exit;
            if FMultiSelect and (Assigned(FDesignControl) and (NewControl=FDesignControl) or
              (GetKeyState(VK_CONTROL) and $80 <> 0) or
              (hwnd=ParentForm.Handle) and not ValidControl(NewControl)) then
            begin
              FGrabHandles.Enabled:=False;
              with FSelectRect do
              begin
                GetCursorPos(TopLeft);
                BottomRight:=TopLeft;
              end;
              FSelectCounter:=0;
              if ControlCount>1 then
                while ControlCount>0 do
                begin
                  DoDeleteControl(FControls[0]);
                  TControl(FControls[0]).Invalidate;
                  FControls.Delete(0);
                end
              else
              begin
                if Assigned(Control) then DoDeleteControl(Control);
                FControls.Clear;
                DoSelectControl(Control);
                DoSelectionChange;
              end;
              FGrabHandles.Control:=nil;
              FSelectControl:=FindWinControl(hwnd);
              if not ValidControl(FSelectControl) then FSelectControl:=ParentForm
              else
                while ValidControl(FSelectControl.Parent) and
                  not (csAcceptsControls in FSelectControl.ControlStyle) do
                  FSelectControl:=FSelectControl.Parent;
              with FSelectControl,R do
              begin
                R:=ClientRect;
                TopLeft:=ClientToScreen(TopLeft);
                BottomRight:=ClientToScreen(BottomRight);
              end;
              SetCapture(ParentForm.Handle);
              ClipCursor(@R);
              FMouseAction:=maSelecting;
              ParentForm.ActiveControl:=nil;
              Message:=0;
            end
            else
            begin
              GetCursorPos(FDragPoint);
              if Assigned(FGrabHandles) then
              begin
                FDragHandle:=FGrabHandles.FindHandle(hwnd);
                if not IsProtected(NewControl) or (NewControl=FDesignControl) then FGrabHandles.Enabled:=False;
              end
              else FDragHandle:=gpNone;
              FGrabHandles.Enabled:=False;
              {$IFNDEF GFDXPTHEMES}
              Application.ProcessMessages;
              {$ENDIF}
              if FDragHandle=gpNone then
              begin
                if ValidControl(NewControl) then
                  if not IsProtected(NewControl) then
                  begin
                    {$IFDEF TFDTRIAL}
                    if NewControl.Parent<>ParentForm then
                    begin
                      Message:=0;
                      ShowTrialWarning;
                      Exit;
                    end;
                    {$ENDIF}
                    ParentForm.ActiveControl:=nil;
                    if FMultiSelect and (GetKeyState(VK_SHIFT) and $80 <> 0) then
                    begin
                      if ControlIndex(NewControl)=-1 then
                      begin
                        if ControlCount=1 then DrawMultiSelect(Control);
                        AddControl(NewControl);
                      end
                      else
                        if ControlCount>1 then
                        begin
                          DeleteControl(NewControl);
                          NewControl.Invalidate;
                          if ControlCount=1 then Control.Invalidate;
                        end;
                      if Assigned(FGrabHandles) and (FGrabHandles.Control<>Control) then
                        FGrabHandles.Control:=Control;
                      Application.ProcessMessages;
                      Message:=0;
                      Exit;
                    end
                    else
                    begin
                      if (ControlIndex(NewControl)<>-1) and (ControlCount>1) then
                      begin
                        AddControl(NewControl);
                        if CheckParent(NewControl,True) then Message:=0;
                      end
                      else
                      begin
                        if ControlCount>1 then
                          while ControlCount>0 do
                          begin
                            DoDeleteControl(FControls[0]);
                            TControl(FControls[0]).Invalidate;
                            FControls.Delete(0);
                          end;
                        if NewControl<>Control then
                        begin
                          if Assigned(Control) then DoDeleteControl(Control);
                          FControls.Clear;
                          AddControl(NewControl);
                          {
                          FControls.Add(NewControl);
                          DoAddControl(Control);
                          DoSelectControl(Control);
                          DoSelectionChange;
                          }
                        end;
                        if IsLocked(NewControl) then
                        begin
                          FGrabHandles.Control:=Control;
                          Message:=0;
                          Exit;
                        end;
                      end;
                    end;
                  end
                  else
                  begin
                    if (FProtectMode=pmUnselect) and (NewControl<>Control) then
                    begin
                      Control:=nil;
                      if NewControl is TWinControl then
                        with TWinControl(NewControl) do
                          if Showing and CanFocus then SetFocus;
                    end;
                    if NewControl=FDesignControl then Control:=nil;
                    Exit;
                  end
                else
                begin
                  if GetPopupParent(hwnd)=ParentForm.Handle then
                  begin
                    Control:=nil;
                    ParentForm.ActiveControl:=nil;
                  end;
                end;
              end
              else NewControl:=nil;
              Application.ProcessMessages;
              if ValidControl(NewControl) and not IsLocked(NewControl) or
                ValidControl(Control) and not IsLocked(Control) and (FDragHandle<>gpNone) then
              begin
                Screen.Cursor:=GetGrabCursor(FDragHandle);
                if ValidControl(Control) then
                begin
                  FDragRect:=Control.BoundsRect;
                  FGrabHandles.Control:=Control;
                  if ValidControl(Control) and ValidControl(Control.Parent) then
                  begin
                    DrawDragRects;
                    with Control.Parent,R do
                    begin
                      R:=ClientRect;
                      if Assigned(FOnMoveLimit) then FOnMoveLimit(Self,Control,R);
                      TopLeft:=ClientToScreen(TopLeft);
                      BottomRight:=ClientToScreen(BottomRight);
                    end;
                    SetCapture(ParentForm.Handle);
                    ClipCursor(@R);
                  end;
                end;
                Message:=0;
                FMouseAction:=maDragging;
                if ValidControl(Control) then
                  with Control do
                    if FDragHandle<>gpNone then Self.ShowHint(Format('%d x %d',[Width,Height]),hmSize)
                    else Self.ShowHint(Format('%d, %d',[Left,Top]),hmMove);
              end
              else Message:=0;
            end;
          end;
          WM_LBUTTONUP{,WM_NCLBUTTONUP}:
          begin
            HideHint;
            if (Message=WM_NCLBUTTONUP) and
              ((hwnd=ParentForm.Handle) or (wParam<>HTCLIENT)) then Exit;
            case MouseAction of
              maDragging:
              begin
                FMouseAction:=maNone;
                FDragHandle:=gpNone;
                DrawDragRects;
                if ControlCount>1 then
                begin
                  NewDrag.X:=FDragRect.Left-Control.Left;
                  NewDrag.Y:=FDragRect.Top-Control.Top;
                  for i:=0 to Pred(ControlCount) do
                  begin
                    R:=Controls[i].BoundsRect;
                    OffsetRect(R,NewDrag.X,NewDrag.Y);
                    if not EqualRect(R,Controls[i].BoundsRect) then
                    begin
                      Controls[i].BoundsRect:=R;
                      DrawMultiSelect(Controls[i]);
                    end;
                    Application.ProcessMessages;
                    DoMoveSizeControl;
                  end;
                  DoChange;
                end
                else
                begin
                  R:=NormalRect(FDragRect);
                  if ValidControl(Control) then
                  begin
                    if Assigned(FOnSizeLimit) then
                      with R do
                      begin
                        Min:=Point(0,0);
                        Max:=Point(MaxInt,MaxInt);
                        FOnSizeLimit(Self,Control,Min,Max);
                        if Right-Left<Min.X then Right:=Left+Min.X;
                        if Bottom-Top<Min.Y then Bottom:=Top+Min.Y;
                        if Right-Left>Max.X then Right:=Left+Max.X;
                        if Bottom-Top>Max.Y then Bottom:=Top+Max.Y;
                      end;
                    if not EqualRect(R,Control.BoundsRect) then
                    begin
                      Control.BoundsRect:=R;
                      Application.ProcessMessages;
                      DoMoveSizeControl;
                      DoChange;
                    end;
                    FDragRect:=Control.BoundsRect;
                  end;
                end;
                Application.ProcessMessages;
                Message:=0;
                if Assigned(FGrabHandles) then
                  with FGrabHandles do
                  begin
                    if FindHandle(hwnd)=gpNone then SetArrowCursor;
                    Enabled:=True;
                    Update(True);
                  end
                else SetArrowCursor;
                Application.ProcessMessages;
                if GetCapture=ParentForm.Handle then ReleaseCapture;
                ClipCursor(nil);
                SendMessage(ParentForm.Handle,WM_ERASEBKGND,0,0);
              end;
              maSelecting:
              begin
                FMouseAction:=maNone;
                DrawSelectRect;
                Lock;
                try
                  if Assigned(FSelectControl) then
                  begin
                    with FSelectControl do
                    begin
                      FSelectRect:=NormalRect(FSelectRect);
                      with FSelectRect do
                      begin
                        TopLeft:=ScreenToClient(TopLeft);
                        BottomRight:=ScreenToClient(BottomRight);
                      end;
                      for i:=0 to Pred(ControlCount) do
                        if not IsTransparent(Controls[i]) and
                          not IsProtected(Controls[i]) and
                          ((csDesigning in Controls[i].ComponentState) or Controls[i].Visible) and
                          {$IFNDEF NOCSSUBCOMPONENT}
                          not (csSubComponent in Controls[i].ComponentStyle) and
                          {$ENDIF}
                          (Controls[i].Parent.Showing) then
                        begin
                          IntersectRect(R,FSelectRect,Controls[i].BoundsRect);
                          if not IsRectEmpty(R) then
                          begin
                            with FControls do
                            begin
                              if IndexOf(Controls[i])=-1 then
                              begin
                                Insert(0,Controls[i]);
                                Application.ProcessMessages;
                                DoAddControl(Controls[i]);
                              end;
                            end;
                            DoSelectControl(Controls[i]);
                          end;
                        end;
                    end;
                    DoSelectionChange;
                    if (ControlCount=1) and Assigned(FGrabHandles) then
                      with FGrabHandles do
                      begin
                        Control:=Self.Control;
                        Enabled:=True;
                        Update(False);
                      end;
                    if Assigned(FGrabHandles) then
                      with FGrabHandles do
                      begin
                        Enabled:=True;
                        Update(False);
                      end;
                  end;
                finally
                  Unlock;
                end;
                Application.ProcessMessages;
                if ControlCount>1 then
                  for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i]);
                Message:=0;
                if GetCapture=ParentForm.Handle then ReleaseCapture;
                ClipCursor(nil);
              end;
            else
            begin
              if not IsProtected(Control) and Assigned(FGrabHandles) then
                with FGrabHandles do
                begin
                  if FindHandle(hwnd)=gpNone then SetArrowCursor;
                  if not Enabled then
                  begin
                    Enabled:=True;
                    Update(True);
                  end;
                end;
              end;
            end;
            {$IFDEF LIKE236}
            Application.ProcessMessages;
            {$ENDIF}
          end;
          WM_MOUSEMOVE,WM_NCMOUSEMOVE:
            if GetPopupParent(hwnd)=ParentForm.Handle then
            begin
              if not ValidControl(Control) and (GetCapture=ParentForm.Handle) and
                not ((Message<>WM_NCMOUSEMOVE) and (hwnd=ParentForm.Handle)) then
                  ReleaseCapture;
              if GetKeyState(VK_LBUTTON) and $80 = 0 then
              begin
                if IsProtected(GetMouseControl(hwnd,lParam)) then Screen.Cursor:=crDefault;
                LeaveMouseAction;
                NewControl:=GetMouseControl(hwnd,LParam);
                if FShowComponentHint and Assigned(NewControl) and not IsProtected(NewControl) then
                begin
                  if FHintControl<>NewControl then
                  begin
                    FHintControl:=NewControl;
                    if FHintTimer.Enabled then
                    begin
                      ShowHint(GetComponentHint(NewControl),hmCustom);
                      StartTimer(Application.HintHidePause);
                    end
                    else StartTimer(Application.HintPause)
                  end
                  else
                    if not FHintTimer.Enabled then StartTimer(Application.HintHidePause);
                end
                else
                begin
                  FHintControl:=nil;
                  StopTimer;
                  HideHint;
                end;
              end;
              case FMouseAction of
                maDragging:
                begin
                  StopTimer;
                  if GetKeyState(VK_LBUTTON) and $80 = 0 then LeaveMouseAction
                  else
                    if ValidControl(Control) then
                    begin
                      GetCursorPos(NewDrag);
                      with NewDrag do
                      begin
                        X:=X-FDragPoint.X;
                        Y:=Y-FDragPoint.Y;
                        if FEnableAxisDrag and (GetKeyState(VK_CONTROL) and $80 <> 0) then
                          if (X<>0) and (Y<>0) then
                          begin
                            if Abs(Y)>Abs(X) then X:=0
                            else Y:=0;
                          end;
                        if (FDragHandle=gpNone) and
                          FSnapToGrid and (GetKeyState(VK_MENU) and $80 = 0) then
                        begin
                          {$IFDEF GFDADVANCEDGRID}
                          X:=Round(X/FGridStepX)*FGridStepX;
                          Y:=Round(Y/FGridStepY)*FGridStepY;
                          {$ELSE}
                          X:=Round(X/FGridStep)*FGridStep;
                          Y:=Round(Y/FGridStep)*FGridStep;
                          {$ENDIF}
                        end;
                      end;
                      if ValidControl(Control) then R:=Control.BoundsRect;
                      with NewDrag do
                        case FDragHandle of
                          {$IFDEF GFD2542921}
                          gpNone: if Control.Tag<>2542921 then OffsetRect(R,X,Y);
                          {$ELSE}
                          gpNone: OffsetRect(R,X,Y);
                          {$ENDIF}
                        else
                          with R do
                          begin
                            case FDragHandle of
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
                            if FSnapToGrid and (GetKeyState(VK_MENU) and $80 = 0) then
                            begin
                              {$IFDEF GFDADVANCEDGRID}
                              if FDragHandle in [gpLeftTop,gpLeftMiddle,gpLeftBottom] then
                                Left:=Left div FGridStepX * FGridStepX;
                              if FDragHandle in [gpLeftTop,gpMiddleTop,gpRightTop] then
                                Top:=Top div FGridStepY * FGridStepY;
                              if FDragHandle in [gpRightTop,gpRightMiddle,gpRightBottom] then
                                Right:=Succ(Right div FGridStepX * FGridStepX);
                              if FDragHandle in [gpLeftBottom,gpMiddleBottom,gpRightBottom] then
                                Bottom:=Succ(Bottom div FGridStepY * FGridStepY);
                              {$ELSE}
                              if FDragHandle in [gpLeftTop,gpLeftMiddle,gpLeftBottom] then
                                Left:=Left div FGridStep * FGridStep;
                              if FDragHandle in [gpLeftTop,gpMiddleTop,gpRightTop] then
                                Top:=Top div FGridStep * FGridStep;
                              if FDragHandle in [gpRightTop,gpRightMiddle,gpRightBottom] then
                                Right:=Succ(Right div FGridStep * FGridStep);
                              if FDragHandle in [gpLeftBottom,gpMiddleBottom,gpRightBottom] then
                                Bottom:=Succ(Bottom div FGridStep * FGridStep);
                              {$ENDIF}
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
                          if FDragHandle<>gpNone then Self.ShowHint(Format('%d x %d',[Abs(Right-Left),Abs(Bottom-Top)]),hmSize)
                          else
                          begin
                            P:=GetControlsOrigin;
                            Inc(P.X,FDragRect.Left-Control.Left);
                            Inc(P.Y,FDragRect.Top-Control.Top);
                            Self.ShowHint(Format('%d, %d',[P.X,P.Y]),hmMove);
                          end;
                      end;
                    end;
                end;
                maSelecting:
                  if GetKeyState(VK_LBUTTON) and $80 = 0 then LeaveMouseAction
                  else
                  begin
                    if FSelectCounter>0 then DrawSelectRect;
                    GetCursorPos(FSelectRect.BottomRight);
                    if FSelectCounter=0 then FSelectRect.TopLeft:=FSelectRect.BottomRight;
                    if FSelectCounter>0 then DrawSelectRect;
                    Inc(FSelectCounter);
                  end;
              else
                if GetCapture=0 then
                begin
                  NewControl:=GetMouseControl(HWND,lParam);
                  if ValidControl(NewControl) then
                  begin
                    if Assigned(FGrabHandles) and (FGrabHandles.FindHandle(HWND)=gpNone) then
                      if IsProtected(NewControl) or IsTransparent(NewControl) then
                        Screen.Cursor:=crDefault
                      else SetArrowCursor
                    else
                      if Assigned(FGrabHandles) and (FGrabHandles.FindHandle(HWND)<>gpNone) then
                        Screen.Cursor:=crDefault
                      else
                        if IsLocked(NewControl) then SetArrowCursor;
                  end
                  else Screen.Cursor:=crDefault;
                end;
              end;
            end;
          WM_KEYDOWN:
            // Screen <-> ParentForm
            if ((Screen.ActiveControl=ParentForm) or (Screen.ActiveControl.Owner=ParentForm)) and
              (ProtectMode<>pmLockKeyboard) or not ValidControl(Screen.ActiveControl) or
              not IsProtected(Screen.ActiveControl) or (Screen.ActiveControl=ParentForm) or (Owner=ParentForm) then
            begin
              if GetKeyState(VK_SHIFT) and $80 <> 0 then
                if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType:=ktFastMove
                else KeyType:=ktSize
              else
                if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType:=ktMove
                else KeyType:=ktSelect;
              if (KeyType=ktSelect) and not FKeySelect then Exit;
              if (KeyType<>ktSelect) and not FKeyMove then Exit;
              case wParam of
                VK_ESCAPE:
                  if MouseAction<>maNone then LeaveMouseAction
                  else Control:=SelectableParent(Control);
                VK_TAB:
                begin
                  Control:=FindNextControl(GetKeyState(VK_SHIFT) and $80 = 0);
                  if ValidControl(Control) then Message:=0;
                end;
                VK_RIGHT,VK_LEFT,VK_UP,VK_DOWN:
                begin
                  ProcessKey(wParam);
                  if ValidControl(Control) then Message:=0;
                end;
              else
              begin
                if Assigned(FOnKeyDown) then
                begin
                  Key:=wParam;
                  FOnKeyDown(Self,Key,KeyDataToShiftState(lParam));
                  wParam:=Key;
                end;
                Exit;
              end;
              end;
            end;
          WM_KEYUP:
            case wParam of
              VK_TAB,VK_RIGHT,VK_LEFT,VK_UP,VK_DOWN: Message:=0;
            else
              if Assigned(FOnKeyUp) then
              begin
                Key:=wParam;
                FOnKeyUp(Self,Key,KeyDataToShiftState(lParam));
                wParam:=Key;
              end;
            end;
          CN_HSCROLL,CN_VSCROLL,WM_VSCROLL,WM_HSCROLL:
            FGrabHandles.Update(False);
          WM_SYSKEYDOWN,WM_SYSKEYUP:;
          {$IFNDEF NOMOUSEWHEEL}
          WM_MOUSEWHEEL: ParentForm.DefaultHandler(Msg);
          {$ENDIF}
        end // case Message of...
    end
    else
      if GetPopupParent(Msg.hwnd)<>ParentForm.Handle then Screen.Cursor:=crDefault
      else SetArrowCursor
  else
  begin
    Screen.Cursor:=crDefault;
    if FWaiting then
      with Msg,ParentForm do
        case Message of
          WM_LBUTTONDOWN:
          begin
            if GetPopupParent(hwnd)=Handle then
            begin
              Message:=0;
              if hwnd=Handle then WinControl:=ParentForm
              else
              begin
                WinControl:=FindWinControl(hwnd);
                while Assigned(WinControl) and
                  not (csAcceptsControls in WinControl.ControlStyle) do
                  WinControl:=WinControl.Parent;
              end;
              if Assigned(WinControl) and Assigned(FPlacedComponent) then
              begin
                if Assigned(FPlacedComponent) then
                  if not AutoName(FPlacedComponent) then FPlacedComponent.Free
                  else
                  begin
                    P:=Point(LoWord(lParam),HiWord(lParam));
                    MapWindowPoints(hwnd,WinControl.Handle,P,1);
                    if FPlacedComponent is TControl then
                      with TControl(FPlacedComponent) do
                      begin
                        Left:=P.X;
                        Top:=P.Y;
                        if SnapToGrid then AlignToGrid(TControl(FPlacedComponent));
                        Parent:=WinControl;
                      end
                    else
                    begin
                      CC:=FindComponentContainer(FPlacedComponent);
                      if Assigned(CC) then
                      begin
                        with CC do
                        begin
                          Left:=P.X;
                          Top:=P.Y;
                          Visible:=True;
                          ShowWindow(Handle,SW_SHOW);
                        end;
                        if SnapToGrid then AlignToGrid(CC);
                      end;
                    end;
                    Component:=FPlacedComponent;
                    if Assigned(FOnPlaceComponent) then FOnPlaceComponent(Self,Component);
                  end;
              end;
              Unlock;
            end;
          end;
        end
    else
      if Assigned(FOnMessage) and (GetPopupParent(Msg.hwnd)=ParentForm.Handle) then FOnMessage(Self,Msg);
  end;
end;

procedure TCustomFormDesigner.DoMoveSizeControl;
var
  i: Integer;
begin
  if Assigned(FOnMoveSizeControl) then
    for i:=0 to Pred(ControlCount) do FOnMoveSizeControl(Self,Controls[i]);
end;

procedure TCustomFormDesigner.DoChange;
begin
  FModified:=True;
  if not SynchroLocked and Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCustomFormDesigner.DoSelectControl(AControl: TControl);
var
  OldControl: TControl;
begin
  if AControl is TComponentContainer then
  begin
    OldControl:=AControl;
    if Assigned(TComponentContainer(AControl).Component) then
    try
      AControl:=TControl(TComponentContainer(AControl).Component);
    except
      AControl:=OldControl;
    end;
  end;
  if Assigned(FOnSelectControl) then FOnSelectControl(Self,AControl);
end;

procedure TCustomFormDesigner.DoSelectionChange;
begin
  if not SynchroLocked and Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;

procedure TCustomFormDesigner.DoAddControl(AControl: TControl);
begin
  if Assigned(FOnAddControl) then FOnAddControl(Self,AControl);
end;

procedure TCustomFormDesigner.DoDeleteControl(AControl: TControl);
begin
  if Assigned(FOnDeleteControl) then FOnDeleteControl(Self,AControl);
end;

function TCustomFormDesigner.GetEditBehaviour(AControl: TControl): TEditBehaviour;
var
  AComponent: TComponent;
begin
  Result:=ebDefault;
  if Assigned(AControl) then
  begin
    if AControl is TComponentContainer then
      AComponent:=TComponentContainer(AControl).Component
    else AComponent:=AControl;
    if Assigned(AComponent) and Assigned(FOnEditBehaviour) then
      FOnEditBehaviour(Self,AComponent,Result);
  end;
end;

function Designing: Boolean;
begin
  Result:=Assigned(Designers) and (Designers.Count>0);
end;

initialization
  Designers:=TList.Create;
finalization
  Designers.Free;
end.
