{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDockVSNetStyle.pas, released on 2003-12-31.

The Initial Developer of the Original Code is luxiaoban.
Portions created by luxiaoban are Copyright (C) 2002,2003 luxiaoban.
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDockVSNetStyle.pas,v 1.51 2005/02/17 10:20:25 marquardt Exp $

unit JvDockVSNetStyle;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  Windows, Messages, Classes, Graphics, Controls, Forms, ExtCtrls,
  JvDockControlForm, JvDockSupportControl, JvDockTree, JvDockVIDStyle;

type
  TJvDockVSNETConjoinServerOption = class(TJvDockVIDConjoinServerOption)
  protected
    procedure SetDefaultSystemCaptionInfo; override;
  public
    constructor Create(ADockStyle: TJvDockBasicStyle); override;
  end;

  TJvDockVSNETTabServerOption = class(TJvDockVIDTabServerOption)
  public
    constructor Create(ADockStyle: TJvDockBasicStyle); override;
  end;

  TJvDockVSNETChannelOption = class(TJvDockBasicServerOption)
  private
    FActivePaneSize: Integer;
    FShowImage: Boolean;
    FMouseleaveHide: Boolean;
    FHideHoldTime: Integer;
    FTabColor: TColor;
    procedure SetActivePaneSize(const Value: Integer);
    procedure SetShowImage(const Value: Boolean);
    procedure SetHideHoldTime(const Value: Integer);
    procedure SetMouseleaveHide(const Value: Boolean);
  protected
    procedure ResetDockControlOption; override;
    procedure ResetDockServerOption(ADockServer: TJvDockServer); override;
    procedure ResetDockClientOption(ADockClient: TJvDockClient); override;
  public
    constructor Create(ADockStyle: TJvDockBasicStyle); override;
  published
    property ActivePaneSize: Integer read FActivePaneSize write SetActivePaneSize;
    property ShowImage: Boolean read FShowImage write SetShowImage;
    property MouseleaveHide: Boolean read FMouseleaveHide write SetMouseleaveHide default True;
    property HideHoldTime: Integer read FHideHoldTime write SetHideHoldTime;
    property TabColor: TColor read FTabColor write FTabColor default clBtnFace;
  end;

  TJvDockVSNETChannelOptionClass = class of TJvDockVSNETChannelOption;

  TJvDockVSBlock = class;
  TJvDockVSChannel = class;
  TJvDockVSNETPanel = class;
  TJvDockVSPopupPanel = class;
  TJvDockVSPopupPanelSplitter = class;

  TJvDockVSPane = class(TObject)
  private
    FBlock: TJvDockVSBlock;
    FDockForm: TForm;
    FIndex: Integer;
    FWidth: Integer;
    FActive: Boolean;
    FVisible: Boolean;
  public
    constructor Create(ABlock: TJvDockVSBlock; AForm: TForm; AWidth: Integer; AIndex: Integer); virtual;
  end;

  TJvDockBlockType = (btConjoinBlock, btTabBlock);

  TJvDockVSBlock = class(TObject)
  private
    FVSChannel: TJvDockVSChannel;
    FVSPaneList: TList;
    FActiveBlockWidth: Integer;
    FInactiveBlockWidth: Integer;
    FActiveDockControl: TWinControl;
    FBlockType: TJvDockBlockType;
    FImageList: TImageList;
    FBlockStartPos: Integer;
    function GetVSPane(Index: Integer): TJvDockVSPane;
    function GetVSPaneCount: Integer;
    procedure SetActiveDockControl(ADockControl: TWinControl);
  protected
    procedure ResetActiveBlockWidth;
    procedure AddPane(AControl: TControl; const AWidth: Integer);
    procedure DeletePane(Index: Integer);
    procedure UpdateActiveDockControl(StartIndex: Integer);
    { Pane with ActiveDockControl as FDockControl has size ActiveBlockWidth.. }
    property ActiveBlockWidth: Integer read FActiveBlockWidth write FActiveBlockWidth;
    { ..other panes have size InactiveBlockWidth }
    property InactiveBlockWidth: Integer read FInactiveBlockWidth write FInactiveBlockWidth;
    { Free Notification? }
    property ActiveDockControl: TWinControl read FActiveDockControl write SetActiveDockControl;
    property BlockType: TJvDockBlockType read FBlockType;
    { Owner }
    property VSChannel: TJvDockVSChannel read FVSChannel;
  public
    constructor Create(Owner: TJvDockVSChannel); virtual;
    destructor Destroy; override;
    procedure AddDockControl(Control: TWinControl);
    procedure RemoveDockControl(Control: TWinControl);
    function GetTotalWidth: Integer;
    property VSPaneCount: Integer read GetVSPaneCount;
    property VSPanes[Index: Integer]: TJvDockVSPane read GetVSPane;
  end;

  TJvDockChannelState = (csShow, csHide);

  TJvDockPoppupPanelAnimateStyle = (pasShow, pasHide);

  {
     TJvDockServer
       |
       |----- TJvDockVSNETPanel (4x per server)
                |
                |----- TJvDockVSChannel
                             |
                             |----    TJvDockVSPopupPanel
                             |
                             |----    TJvDockVSPopupPanelSplitter

     -------- = maintains/creates

  }

  TJvDockVSChannel = class(TCustomControl)
  private
    FAnimationStartTimer: TTimer;
    FActiveDockForm: TForm;
    FActivePane: TJvDockVSPane;
    FVSNETDockPanel: TJvDockVSNETPanel; { Owner }
    FCurrentPos: Integer;
    FDockServer: TJvDockServer;
    FBlockList: TList; { Change to TObjectList }
    FChannelWidth: Integer;
    FBlockStartOffset: Integer;
    FBlockUpOffset: Integer;
    FBlockInterval: Integer;
    FVSPopupPanel: TJvDockVSPopupPanel;
    FVSPopupPanelSplitter: TJvDockVSPopupPanelSplitter;
    FActivePaneSize: Integer;
    function GetBlockCount: Integer;
    function GetBlocks(Index: Integer): TJvDockVSBlock;
    procedure GetBlockRect(Block: TJvDockVSBlock; Index: Integer; var ARect: TRect);
    function GetDockFormWithMousePos(MousePos: TPoint): TJvDockVSPane;
    procedure SetBlockStartOffset(const Value: Integer);
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure FreeBlockList;
    procedure SetActivePaneSize(const Value: Integer);
    procedure AnimationStartTimerOnTimerHandler(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure ResetFontAngle; virtual;
    procedure ResetBlock; virtual;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetVSPopupPanelSplitterPosition;
    property ChannelWidth: Integer read FChannelWidth;
    property BlockStartOffset: Integer read FBlockStartOffset write SetBlockStartOffset;
    property BlockUpOffset: Integer read FBlockUpOffset;
    property BlockInterval: Integer read FBlockInterval;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetPaneWithControl(AControl: TControl): TJvDockVSPane;
    procedure CreateVSPopupPanel(DockStyle: TComponent);
    procedure DestroyVSPopupPanel;
    procedure ResetPosition;
    procedure AddDockControl(Control: TWinControl);
    procedure RemoveDockControl(Control: TWinControl);
    function FindDockControl(Control: TWinControl; var BlockIndex: Integer;
      var PaneIndex: Integer): Boolean;
    function FindPane(Control: TWinControl): TJvDockVSPane;
    { Slides the window into view }
    procedure PopupDockForm(Pane: TJvDockVSPane); overload;
    procedure PopupDockForm(Control: TWinControl); overload;
    { Disables auto-hide }
    procedure ShowPopupPanel(Pane: TJvDockVSPane); overload;
    procedure ShowPopupPanel(Control: TWinControl); overload;
    { Hides the window by sliding it to the edge of the form }
    procedure HidePopupPanel(Pane: TJvDockVSPane); overload;
    procedure HidePopupPanel(Control: TWinControl); overload;
    procedure HidePopupPanelWithAnimate;
    procedure ResetActivePaneWidth;
    procedure ResetPopupPanelHeight;
    procedure RemoveAllBlock;
    procedure DeleteBlock(Index: Integer);
    procedure AnimatePopupPanel(AnimateStyle: TJvDockPoppupPanelAnimateStyle);
    property DockServer: TJvDockServer read FDockServer write FDockServer;
    property BlockCount: Integer read GetBlockCount;
    property Blocks[Index: Integer]: TJvDockVSBlock read GetBlocks;
    property VSPopupPanel: TJvDockVSPopupPanel read FVSPopupPanel;
    property VSPopupPanelSplitter: TJvDockVSPopupPanelSplitter read FVSPopupPanelSplitter;
    { Free Notification? }
    property ActiveDockForm: TForm read FActiveDockForm;
    property ActivePaneSize: Integer read FActivePaneSize write SetActivePaneSize;
  end;

  TJvDockVSChannelClass = class of TJvDockVSChannel;

  TJvDockVSNetStyle = class(TJvDockVIDStyle)
  private
    FMouseleaved: Boolean;
    FTimer: TTimer;
    FDockServerList: TList;
    FCurrentTimer: Integer;
    FChannelOption: TJvDockVSNETChannelOption;
    FChannelOptionClass: TJvDockVSNETChannelOptionClass;
    procedure Timer(Sender: TObject);
    function GetChannelOption: TJvDockVSNETChannelOption;
    procedure SetChannelOption(const Value: TJvDockVSNETChannelOption);
  protected
    procedure CreateConjoinServerOption(var Option: TJvDockBasicConjoinServerOption); override;
    procedure CreateTabServerOption(var Option: TJvDockBasicTabServerOption); override;
    function DockServerWindowProc(DockServer: TJvDockServer; var Msg: TMessage): Boolean; override;
    function DockClientWindowProc(DockClient: TJvDockClient; var Msg: TMessage): Boolean; override;
    procedure AddDockBaseControl(ADockBaseControl: TJvDockBaseControl); override;
    procedure RemoveDockBaseControl(ADockBaseControl: TJvDockBaseControl); override;
    procedure CreateServerOption; override; { AfterConstruction }
    procedure FreeServerOption; override; { Destroy }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFNDEF USEJVCL}
    function GetControlName: string; override;
    {$ENDIF !USEJVCL}
    procedure SetDockFormVisible(ADockClient: TJvDockClient; AVisible: Boolean);
    procedure ShowDockForm(ADockClient: TJvDockClient); override;
    procedure HideDockForm(ADockClient: TJvDockClient); override;
    function GetDockFormVisible(ADockClient: TJvDockClient): Boolean; override;
    procedure RestoreClient(DockClient: TJvDockClient); override;
    class procedure SetAnimationInterval(const Value: Integer);
    class function GetAnimationInterval: Integer;
    class function GetAnimationStartInterval: Integer;
    class procedure SetAnimationMoveWidth(const Value: Integer);
    class function GetAnimationMoveWidth: Integer;
  published
    property ChannelOption: TJvDockVSNETChannelOption read GetChannelOption write SetChannelOption;
  end;

  TJvDockVSNETSplitter = class(TJvDockVIDSplitter);

  { A 'pure' TJvDockVSNETPanel maintains a TJvDockVSChannel (A TJvDockVSPopupPanel
    component that is a TJvDockVSNETPanel descendant does NOT, see
    TJvDockVSNETPanel.AddDockServer)
  }
  TJvDockVSNETPanel = class(TJvDockVIDPanel)
  private
    FVSChannelClass: TJvDockVSChannelClass;
    FVSChannel: TJvDockVSChannel;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure AddDockServer(ADockServer: TJvDockServer); override;
    procedure RemoveDockServer(ADockServer: TJvDockServer); override;
    procedure CustomDockDrop(Source: TJvDockDragDockObject; X, Y: Integer); override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateVSChannel(DockStyle: TComponent);
    procedure DestroyVSChannel;
    procedure DoAutoHideControl(Control: TWinControl);
    procedure DoHideControl(Control: TWinControl);
    procedure DoShowControl(Control: TWinControl);
    property VSChannel: TJvDockVSChannel read FVSChannel;
  end;

  TJvDockVSPopupPanel = class(TJvDockVSNETPanel)
  private
    FDockStyle: TComponent; {Actually of type TJvDockBasicStyle }
    FVSNETDockPanel: TJvDockVSNETPanel;
    {procedure SetVSNETDockPanel(const Value: TJvDockVSNETPanel);}
    function GetVSChannel: TJvDockVSChannel;
  protected
    function CreateDockManager: IDockManager; override;
    procedure SetParent(AParent: TWinControl); override;
  public
    // Can't put 'override' this one because signature is different!
    // But it MUST have DockStyle in the constructor now! -Wpostma!
    constructor Create(AOwner: TComponent); override; 

    procedure ShowDockPanel(MakeVisible: Boolean; Client: TControl;
      PanelSizeFrom: TJvDockSetDockPanelSizeFrom); override;
    { Dirty override; solve with virtual method? }
    property VSChannel: TJvDockVSChannel read GetVSChannel;
    { Owner }
    property VSNETDockPanel: TJvDockVSNETPanel read FVSNETDockPanel {write SetVSNETDockPanel};
    { Dock Style }
    property DockStyle: TComponent read FDockStyle write FDockStyle; {Actually of type TJvDockBasicStyle }
  end;

  TJvDockVSNETConjoinPanel = class(TJvDockVIDConjoinPanel);

  TJvDockBtnState = (bsUp, bsNormal, bsDown);

  TJvDockVSNETZone = class(TJvDockVIDZone)
  private
    FAutoHideBtnDown: Boolean;
    FAutoHideBtnState: TJvDockBtnState;
    FCloseBtnState: TJvDockBtnState;
    FVSPaneVisible: Boolean;
    procedure SetAutoHideBtnState(const Value: TJvDockBtnState);
    procedure SetCloseBtnState(const Value: TJvDockBtnState);
    procedure SetAutoHideBtnDown(const Value: Boolean);
    procedure SetVSPaneVisible(const Value: Boolean);
  protected
    procedure DoCustomSetControlName; override;
    procedure SetChildControlVisible(Client: TControl; AVisible: Boolean); override;
    property AutoHideBtnDown: Boolean read FAutoHideBtnDown write SetAutoHideBtnDown;
    property AutoHideBtnState: TJvDockBtnState read FAutoHideBtnState write SetAutoHideBtnState;
    property CloseBtnState: TJvDockBtnState read FCloseBtnState write SetCloseBtnState;
    property VSPaneVisible: Boolean read FVSPaneVisible write SetVSPaneVisible;
  public
    constructor Create(Tree: TJvDockTree); override;

  end;

  TJvDockVSNETTree = class(TJvDockVIDTree)
  private
    FAutoHideZone: TJvDockVSNETZone;
  protected
    procedure IgnoreZoneInfor(Stream: TMemoryStream); override;
    procedure BeginDrag(Control: TControl;
      Immediate: Boolean; Threshold: Integer = -1); override;
    function DoLButtonDown(var Msg: TWMMouse;
      var Zone: TJvDockZone; out HTFlag: Integer): Boolean; override;
    procedure DoLButtonUp(var Msg: TWMMouse;
      var Zone: TJvDockZone; out HTFlag: Integer); override;
    procedure DoLButtonDbClk(var Msg: TWMMouse;
      var Zone: TJvDockZone; out HTFlag: Integer); override;
    procedure DoMouseMove(var Msg: TWMMouse;
      var AZone: TJvDockZone; out HTFlag: Integer); override;
    procedure DoHideZoneChild(AZone: TJvDockZone); override;
    function GetTopGrabbersHTFlag(const MousePos: TPoint;
      out HTFlag: Integer; Zone: TJvDockZone): TJvDockZone; override;
    procedure DrawDockGrabber(Control: TControl; const ARect: TRect); override;
    procedure PaintDockGrabberRect(Canvas: TCanvas; Control: TControl;
      const ARect: TRect; PaintAlways: Boolean = False); override;
    procedure DrawCloseButton(Canvas: TCanvas; Zone: TJvDockZone;
      Left, Top: Integer); override;
    procedure DrawAutoHideButton(Zone: TJvDockZone;
      Left, Top: Integer); virtual;
    procedure GetCaptionRect(var Rect: TRect); override;
    procedure DoOtherHint(Zone: TJvDockZone;
      HTFlag: Integer; var HintStr: string); override;
    procedure CustomSaveZone(Stream: TStream;
      Zone: TJvDockZone); override;
    procedure CustomLoadZone(Stream: TStream;
      var Zone: TJvDockZone); override;
    property AutoHideZone: TJvDockVSNETZone read FAutoHideZone
      write FAutoHideZone;
  public
    constructor Create(DockSite: TWinControl; DockZoneClass: TJvDockZoneClass;
      ADockStyle: TComponent {TJvDockBasicStyle}); override;
  end;

  TJvDockVSNETTabSheet = class(TJvDockVIDTabSheet)
  private
    FOldVisible: Boolean;
    procedure SetOldVisible(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property OldVisible: Boolean read FOldVisible write SetOldVisible;
  end;

  TJvDockVSNETTabPanel = class(TJvDockTabPanel)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TJvDockVSNETTabPageControl = class(TJvDockVIDTabPageControl)
  protected
    procedure ShowControl(AControl: TControl); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TJvDockVSNETDragDockObject = class(TJvDockVIDDragDockObject);

  TJvDockVSPopupPanelSplitter = class(TCustomControl)
  private
    FVSPopupPanel: TJvDockVSPopupPanel;
    FSplitWidth: Integer;
    FActiveControl: TWinControl;
    FAutoSnap: Boolean;
    FBeveled: Boolean;
    FBrush: TBrush;
    FControl: TControl;
    FDownPos: TPoint;
    FLineDC: HDC;
    FLineVisible: Boolean;
    FMinSize: NaturalNumber;
    FMaxSize: Integer;
    FNewSize: Integer;
    FOldKeyDown: TKeyEvent;
    FOldSize: Integer;
    FPrevBrush: HBRUSH;
    FResizeStyle: TResizeStyle;
    FSplit: Integer;
    FOnCanResize: TCanResizeEvent;
    FOnMoved: TNotifyEvent;
    FOnPaint: TNotifyEvent;
    procedure AllocateLineDC;
    procedure CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
    procedure DrawLine;
    function FindControl: TControl;
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReleaseLineDC;
    procedure SetBeveled(Value: Boolean);
    procedure UpdateControlSize;
    procedure UpdateSize(X, Y: Integer);
    procedure SetVSPopupPanel(Value: TJvDockVSPopupPanel);
    function GetVSChannelAlign: TAlign;
    procedure SetSplitWidth(const Value: Integer);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function CanResize(var NewSize: Integer): Boolean; reintroduce; virtual;
    function DoCanResize(var NewSize: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure StopSizing; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas;
    { Owner of the Owner }
    property VSPopupPanel: TJvDockVSPopupPanel read FVSPopupPanel write SetVSPopupPanel;
    property SplitWidth: Integer read FSplitWidth write SetSplitWidth;
  published
    property Align default alLeft;
    property VSChannelAlign: TAlign read GetVSChannelAlign;
    property AutoSnap: Boolean read FAutoSnap write FAutoSnap default True;
    property Beveled: Boolean read FBeveled write SetBeveled default False;
    property Color;
    property Constraints;
    property MinSize: NaturalNumber read FMinSize write FMinSize default 30;
    property ParentColor;
    property ResizeStyle: TResizeStyle read FResizeStyle write FResizeStyle default rsPattern;
    property Visible;
    property OnCanResize: TCanResizeEvent read FOnCanResize write FOnCanResize;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

procedure HideAllPopupPanel(ExcludeChannel: TJvDockVSChannel);
{ Disables auto-hide for ADockWindow. If ADockWindow is not auto-hidden then
  the procedures works the same as JvDockControlForm.ShowDockForm }
procedure UnAutoHideDockForm(ADockWindow: TWinControl);

var
  DefaultVSChannelClass: TJvDockVSChannelClass = nil;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvDockVSNetStyle.pas,v $';
    Revision: '$Revision: 1.51 $';
    Date: '$Date: 2005/02/17 10:20:25 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

uses
  SysUtils, Math, {AppEvnts,}
  JvDockSupportProc, JvDockGlobals;

type
  TAnimateState = (asPopup, asHide);

  TPopupPanelAnimate = class(TTimer)
  private
    FMaxWidth: Integer;
    FCurrentWidth: Integer;
    FVSChannel: TJvDockVSChannel;
    FState: TAnimateState;
  protected
    procedure Timer; override;
    procedure OnCustomTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    { Animates the popup of the form }
    procedure PopupForm(AVSChannel: TJvDockVSChannel; MaxWidth: Integer); virtual;
    { Animates the hiding of the form }
    procedure HideForm(AVSChannel: TJvDockVSChannel; MaxWidth: Integer); virtual;
  end;

  { (ahuser) not used:
  TJvDockAppEvents = class(TApplicationEvents)
  private
    FOldOnMessage: TMessageEvent;
    procedure NewOnMessage(var Msg: TMsg; var Handled: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
  end;}

  TWinControlAccessProtected = class(TWinControl);

var
  GlobalPopupPanelAnimate: TPopupPanelAnimate = nil;
  // (ahuser) not used:
  // GlobalApplicationEvents: TJvDockAppEvents = nil;
  GlobalPopupPanelAnimateInterval: Integer = 20;
  GlobalPopupPanelAnimateMoveWidth: Integer = 20;
  GlobalPopupPanelStartAnimateInterval: Integer = 400;

//=== Local procedures =======================================================

// (p3) not used:
//  AnimateSleepTime: Integer = 500;

function PopupPanelAnimate: TPopupPanelAnimate;
begin
  if GlobalPopupPanelAnimate = nil then
    GlobalPopupPanelAnimate := TPopupPanelAnimate.Create(nil);
  Result := GlobalPopupPanelAnimate;
end;

procedure ResetChannelBlockStartOffset(Channel: TJvDockVSChannel);
var
  I: TAlign;
  LeftChannel: TJvDockVSChannel;
  CurrChannel: TJvDockVSChannel;
  OldOffset: Integer;
  LeftAlignArea: Integer;
begin
  LeftChannel := TJvDockVSNETPanel(Channel.DockServer.LeftDockPanel).VSChannel;
  if LeftChannel <> nil then
  begin
    LeftAlignArea := GetClientAlignControlArea(LeftChannel.Parent, alLeft);
    for I := alTop to alRight do
      if Assigned(Channel.DockServer.DockPanelWithAlign[I]) then
      begin
        CurrChannel := TJvDockVSNETPanel(Channel.DockServer.DockPanelWithAlign[I]).VSChannel;
        if CurrChannel.Align in [alTop, alBottom] then
        begin
          OldOffset := CurrChannel.BlockStartOffset;
          CurrChannel.BlockStartOffset := 2 + LeftAlignArea;
          if OldOffset <> CurrChannel.BlockStartOffset then
            CurrChannel.Invalidate;
        end;
      end;
  end;
end;

//=== Global procedures ======================================================

{ (ahuser) not used:
function ApplicationEvents: TJvDockAppEvents;
begin
  if GlobalApplicationEvents = nil then
    GlobalApplicationEvents := TJvDockAppEvents.Create(nil);
  Result := GlobalApplicationEvents;
end;

procedure DragControl(WinControl: TWinControl);
const
  SM = $F012;
begin
  ReleaseCapture;
  WinControl.Perform(WM_SYSCOMMAND, SM, 0);
end;
}

procedure HideAllPopupPanel(ExcludeChannel: TJvDockVSChannel);
var
  I: Integer;
  J: TAlign;
  Channel: TJvDockVSChannel;
  DockServer: TJvDockServer;
begin
  for I := 0 to JvGlobalDockManager.DockServersList.Count - 1 do
  begin
    DockServer := FindDockServer(JvGlobalDockManager.DockServersList[I]);
    if (DockServer <> nil) and (DockServer.TopDockPanel is TJvDockVSNETPanel) then
      for J := alTop to alRight do
        if Assigned(DockServer.DockPanelWithAlign[J]) then
        begin
          Channel := TJvDockVSNETPanel(DockServer.DockPanelWithAlign[J]).VSChannel;
          if (Channel <> nil) and (Channel <> ExcludeChannel) then
            Channel.HidePopupPanel(Channel.FActivePane);
        end;
  end;
end;

procedure UnAutoHideDockForm(ADockWindow: TWinControl);
var
  TmpDockWindow: TWinControl;

  procedure ShowClient(Client, DockParent: TWinControl);
  var
    ADockClient: TJvDockClient;
    I: Integer;
  begin
    if (DockParent is TJvDockableForm) and (Client <> nil) then
    begin
      with TJvDockableForm(DockParent).DockableControl do
        for I := 0 to DockClientCount - 1 do
          if DockClients[I] <> Client then
            MakeDockClientEvent(DockClients[I], True);
      if Client.HostDockSite is TJvDockCustomControl then
        TJvDockCustomControl(Client.HostDockSite).UpdateCaption(nil);
    end
    else
    begin
      ADockClient := FindDockClient(DockParent);
      if (ADockClient <> nil) and (ADockClient.DockStyle <> nil) then
      begin
        ADockClient.DockStyle.ShowDockForm(ADockClient);
        if DockParent.CanFocus then
          DockParent.SetFocus;
      end;
    end;
    if DockParent.Parent = nil then
      SetForegroundWindow(DockParent.Handle);
  end;

  function ShowDockPanel(Client: TWinControl): TWinControl;
  begin
    Result := Client;
    if Client <> nil then
      if Client.HostDockSite is TJvDockPanel then
      begin
        TJvDockPanel(Client.HostDockSite).ShowDockPanel(True, Client, sdfDockPanel);
        Result := nil;
      end;
  end;

  function ShowTabDockHost(Client: TWinControl): TWinControl;
  var
    I: Integer;
  begin
    Result := Client;
    if Client <> nil then
    begin
      ShowClient(nil, Client);
      if Client.HostDockSite is TJvDockTabPageControl then
      begin
        with TJvDockTabPageControl(Client.HostDockSite) do
          for I := 0 to Count - 1 do
            if Pages[I].Controls[0] = Client then
            begin
              Pages[I].Show;
              Break;
            end;
        if (Client.HostDockSite <> nil) and not (Client.HostDockSite is TJvDockPanel) then
        begin
          Result := Client.HostDockSite.Parent;
          ShowClient(Client, Result);
          if (Result <> nil) and (Result.HostDockSite is TJvDockTabPageControl) then
            Result := ShowTabDockHost(Result);
        end;
      end;
    end;
  end;

  function ShowConjoinDockHost(Client: TWinControl): TWinControl;
  begin
    Result := Client;
    if Client <> nil then
    begin
      ShowClient(nil, Client);
      if (Client.HostDockSite <> nil) and not (Client.HostDockSite is TJvDockPanel) then
      begin
        if Client.HostDockSite.Parent <> nil then
        begin
          Result := Client.HostDockSite.Parent;
          ShowClient(Client, Result);
          if (Result <> nil) and (Result.HostDockSite is TJvDockConjoinPanel) then
            Result := ShowConjoinDockHost(Result);
        end;
      end;
    end;
  end;

  procedure ShowPopupPanel(Client: TWinControl);
  begin
    if Client.HostDockSite is TJvDockVSPopupPanel then
      TJvDockVSPopupPanel(Client.HostDockSite).VSChannel.ShowPopupPanel(Client)
    else
    if (Client.HostDockSite <> nil) and (Client.HostDockSite.Parent <> nil) then
    begin
      if (Client.HostDockSite.Parent.HostDockSite is TJvDockVSPopupPanel) then
        TJvDockVSPopupPanel(Client.HostDockSite.Parent.HostDockSite).VSChannel.ShowPopupPanel(Client)
      else
      if Client.HostDockSite.Parent.HostDockSite is TJvDockPanel then
        Client.HostDockSite.Parent.HostDockSite.Invalidate;
    end;
  end;

begin
  TmpDockWindow := ADockWindow;
  repeat
    ADockWindow := ShowTabDockHost(ADockWindow);
    ADockWindow := ShowConjoinDockHost(ADockWindow);
    ADockWindow := ShowDockPanel(ADockWindow);
  until (ADockWindow = nil) or (ADockWindow.Parent = nil);
  ShowPopupPanel(TmpDockWindow);
end;

//=== { TJvDockAppEvents } ===================================================

{ (ahuser) not used:

constructor TJvDockAppEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldOnMessage := OnMessage;
  OnMessage := NewOnMessage;
end;

procedure TJvDockAppEvents.NewOnMessage(var Msg: TMsg; var Handled: Boolean);
var
  CurrControl: TWinControl;
  DockServer: TJvDockServer;
  VSChannel: TJvDockVSChannel;
  I: Integer;
  J: TAlign;

  function CanHide: Boolean;
  begin
    Result := False;
    CurrControl := FindControl(Msg.hwnd);
    if CurrControl = nil then
      Exit;
    repeat
      if csDesigning in CurrControl.ComponentState then
      begin
        Result := False;
        Exit;
      end;
      Result := not ((CurrControl is TJvDockVSChannel) or (CurrControl is TJvDockVSPopupPanel) or (CurrControl is
        TJvDockVSPopupPanelSplitter));
      CurrControl := CurrControl.Parent;
    until (CurrControl = nil) or not Result;
  end;

begin
  if Assigned(FOldOnMessage) then
    FOldOnMessage(Msg, Handled);
  if Msg.message = WM_LBUTTONDOWN then
    if CanHide then
      for I := 0 to Screen.CustomFormCount - 1 do
      begin
        DockServer := FindDockServer(Screen.CustomForms[I]);
        if (DockServer <> nil) and (DockServer.DockStyle is TJvDockVSNetStyle) then
        begin
          if DockServer.DockPanel[0] = nil then
            Exit;
          for J := alTop to alRight do
          begin
            VSChannel := TJvDockVSNETPanel(DockServer.DockPanelWithAlign[J]).VSChannel;
            VSChannel.HidePopupPanelWithAnimate;
          end;
        end;
      end;
end;
}

//=== { TJvDockVSBlock } =====================================================

constructor TJvDockVSBlock.Create(Owner: TJvDockVSChannel);
begin
  inherited Create;
  FVSChannel := Owner;
  FVSPaneList := TList.Create;
  FImageList := TImageList.CreateSize(16, 16);
  FInactiveBlockWidth := 24;
  FActiveBlockWidth := 24;
end;

destructor TJvDockVSBlock.Destroy;
var
  I: Integer;
begin
  FImageList.Free;
  for I := 0 to VSPaneCount - 1 do
    VSPanes[I].Free;
  FVSPaneList.Free;
  inherited Destroy;
end;

procedure TJvDockVSBlock.AddDockControl(Control: TWinControl);
var
  I, PaneWidth, FirstIndex: Integer;

  function GetPaneWidth: Integer;
  begin
    Result := 100;
    if Control = nil then
      Exit;
    case VSChannel.Align of
      alLeft, alRight:
        Result := Control.Width;
      alTop, alBottom:
        Result := Control.Height;
    end;
  end;

begin
  PaneWidth := GetPaneWidth;
  if Control is TJvDockTabHostForm then
  begin
    FBlockType := btTabBlock;
    with TJvDockTabHostForm(Control) do
    begin
      FirstIndex := FVSPaneList.Count;
      for I := 0 to DockableControl.DockClientCount - 1 do
      begin
        AddPane(PageControl.DockClients[I], PaneWidth);
        TJvDockVSNETTabSheet(PageControl.Pages[I]).OldVisible := PageControl.DockClients[I].Visible;
        if PageControl.Pages[I] <> PageControl.ActivePage then
          PageControl.DockClients[I].Visible := False;
      end;
      UpdateActiveDockControl(FirstIndex);
    end;
  end
  else
  begin
    FBlockType := btConjoinBlock;
    AddPane(Control, PaneWidth);
    ActiveDockControl := Control;
  end;
  ResetActiveBlockWidth;
end;

procedure TJvDockVSBlock.AddPane(AControl: TControl; const AWidth: Integer);
var
  Icon: TIcon;
  ADockClient: TJvDockClient;
begin
  { Dangerous? cast }
  FVSPaneList.Add(TJvDockVSPane.Create(Self, TForm(AControl), AWidth, FVSPaneList.Count));
  if not JvGlobalDockIsLoading then
  begin
    ADockClient := FindDockClient(AControl);
    if ADockClient <> nil then
      ADockClient.VSPaneWidth := AWidth;
  end;
  { Add the form icon }
  if TForm(AControl).Icon = nil then
  begin
    Icon := TIcon.Create;
    Icon.Width := 16;
    Icon.Height := 16;
    FImageList.AddIcon(Icon);
    Icon.Free;
  end
  else
    FImageList.AddIcon(TForm(AControl).Icon);
end;

procedure TJvDockVSBlock.DeletePane(Index: Integer);
var
  I: Integer;
  ActiveDockControlRemoved: Boolean;
begin
  for I := Index to FVSPaneList.Count - 2 do
    VSPanes[I + 1].FIndex := VSPanes[I].FIndex;
  ActiveDockControlRemoved := VSPanes[Index].FDockForm = Self.ActiveDockControl;
  VSPanes[Index].Free;
  FVSPaneList.Delete(Index);
  { Remove the form icon }
  if Index < FImageList.Count then
    FImageList.Delete(Index);
  if ActiveDockControlRemoved then
    UpdateActiveDockControl(Index);
end;

function TJvDockVSBlock.GetTotalWidth: Integer;
begin
  Result := (FVSPaneList.Count - 1) * FInactiveBlockWidth + FActiveBlockWidth;
end;

function TJvDockVSBlock.GetVSPane(Index: Integer): TJvDockVSPane;
begin
  Result := TJvDockVSPane(FVSPaneList[Index]);
end;

function TJvDockVSBlock.GetVSPaneCount: Integer;
begin
  Result := FVSPaneList.Count;
end;

procedure TJvDockVSBlock.RemoveDockControl(Control: TWinControl);
begin
  ResetActiveBlockWidth;
end;

procedure TJvDockVSBlock.ResetActiveBlockWidth;
var
  I: Integer;
begin
  for I := 0 to VSPaneCount - 1 do
    FActiveBlockWidth := Max(FActiveBlockWidth, Min(VSChannel.ActivePaneSize,
      TForm(VSChannel.Parent).Canvas.TextWidth(VSPanes[I].FDockForm.Caption) + InactiveBlockWidth + 10));
end;

procedure TJvDockVSBlock.SetActiveDockControl(ADockControl: TWinControl);
begin
  if FActiveDockControl <> ADockControl then
  begin
    FActiveDockControl := ADockControl;
    VSChannel.Invalidate;
  end;
end;

procedure TJvDockVSBlock.UpdateActiveDockControl(StartIndex: Integer);
var
  I: Integer;
begin
  { Start looking at position StartIndex for a visible pane }
  for I := 0 to VSPaneCount - 1 do
    if VSPanes[(I + StartIndex) mod VSPaneCount].FVisible then
    begin
      ActiveDockControl := VSPanes[(I + StartIndex) mod VSPaneCount].FDockForm;
      Break;
    end;
end;

//=== { TJvDockVSChannel } ===================================================

constructor TJvDockVSChannel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TJvDockVSNETPanel then
  begin
    FVSNETDockPanel := TJvDockVSNETPanel(AOwner);
    DockServer := FVSNETDockPanel.DockServer;
  end;
  FBlockList := TList.Create;
  FChannelWidth := 22;
  FBlockStartOffset := 2;
  FBlockUpOffset := 2;
  FBlockInterval := 13;
  Color := VSNETPageInactiveSheetColor;
  ParentFont := True;
  ActivePaneSize := MaxActivePaneWidth;
  FActiveDockForm := nil;
end;

destructor TJvDockVSChannel.Destroy;
begin
  if Assigned(GlobalPopupPanelAnimate) and (GlobalPopupPanelAnimate.FVSChannel = Self) then
  begin
    GlobalPopupPanelAnimate.Free;
    GlobalPopupPanelAnimate := nil;
  end;
  FreeBlockList;
  FAnimationStartTimer.Free;
  inherited Destroy;
end;

procedure TJvDockVSChannel.AddDockControl(Control: TWinControl);
var
  Block: TJvDockVSBlock;
begin
  if Control is TJvDockTabHostForm then
  begin
    Block := TJvDockVSBlock.Create(Self);
    Block.AddDockControl(Control);
    FBlockList.Add(Block);
  end
  else
  begin
    if (BlockCount >= 1) and (Blocks[0].BlockType = btConjoinBlock) then
      Blocks[0].AddDockControl(Control)
    else
    begin
      Block := TJvDockVSBlock.Create(Self);
      Block.AddDockControl(Control);
      FBlockList.Insert(0, Block);
    end;
  end;
  HideAllPopupPanel(Self);
  ResetPosition;
  Invalidate;
end;

procedure TJvDockVSChannel.AnimatePopupPanel(AnimateStyle: TJvDockPoppupPanelAnimateStyle);
begin
  if AnimateStyle = pasShow then
  begin
  end
  else
  if AnimateStyle = pasHide then
  begin
  end;
end;

procedure TJvDockVSChannel.AnimationStartTimerOnTimerHandler(Sender: TObject);
var
  CursorPos: TPoint;
begin
  // Show the form only if the cursor is still above the same pane
  try
    GetCursorPos(CursorPos);
    CursorPos := Self.ScreenToClient(CursorPos);
    if GetDockFormWithMousePos(Point(CursorPos.X, CursorPos.Y)) = Pointer(FAnimationStartTimer.Tag) then
      PopupDockForm(TJvDockVSPane(Pointer(FAnimationStartTimer.Tag)));
  finally
    FAnimationStartTimer.Free;
    FAnimationStartTimer := nil;
  end;
end;

procedure TJvDockVSChannel.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
end;

procedure TJvDockVSChannel.CreateVSPopupPanel(DockStyle: TComponent);
begin
  Assert(Assigned(DockStyle));
  FVSPopupPanel := TJvDockVSPopupPanel.Create(FVSNETDockPanel);

  { Channel is maintainer/Creator }
  FVSPopupPanel.FreeNotification(Self);
  FVSPopupPanel.Name := FVSNETDockPanel.Name + '_PopupPanel';
  FVSPopupPanel.Visible := False;
  if Parent is TForm then
  begin
    FVSPopupPanel.Parent := Parent;
    FVSPopupPanel.Align := alNone;
    FVSPopupPanel.BringToFront;
  end;
  FVSPopupPanelSplitter := TJvDockVSPopupPanelSplitter.Create(Parent);
  { Channel is maintainer/Creator }
  FVSPopupPanelSplitter.FreeNotification(Self);
  if Parent is TForm then
  begin
    FVSPopupPanelSplitter.Parent := Parent;
    FVSPopupPanelSplitter.Align := alNone;
    FVSPopupPanelSplitter.VSPopupPanel := VSPopupPanel;
    FVSPopupPanelSplitter.Color := clBtnFace;
    FVSPopupPanelSplitter.Visible := False;
  end;
end;

procedure TJvDockVSChannel.DeleteBlock(Index: Integer);
begin
  Blocks[Index].Free;
  FBlockList.Delete(Index);
end;

procedure TJvDockVSChannel.DestroyVSPopupPanel;
begin
  FreeAndNil(FVSPopupPanel);
  FreeAndNil(FVSPopupPanelSplitter);
end;

function TJvDockVSChannel.FindDockControl(Control: TWinControl;
  var BlockIndex: Integer; var PaneIndex: Integer): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  BlockIndex := -1;
  PaneIndex := -1;
  if Control = nil then
    Exit;
  for I := 0 to BlockCount - 1 do
  begin
    for J := 0 to Blocks[I].VSPaneCount - 1 do
      if Blocks[I].VSPanes[J].FDockForm = Control then
      begin
        BlockIndex := I;
        PaneIndex := J;
        Result := True;
        Exit;
      end;
    if Blocks[I].FBlockType = btTabBlock then
    begin
      J := 0;
      if Blocks[I].VSPanes[0].FDockForm.HostDockSite.Parent = Control then
      begin
        BlockIndex := I;
        PaneIndex := J;
        Result := True;
        Exit;
      end;
    end;
  end;
end;

function TJvDockVSChannel.FindPane(Control: TWinControl): TJvDockVSPane;
var
  I, J: Integer;
begin
  Result := nil;
  if FindDockControl(Control, I, J) then
    Result := Blocks[I].VSPanes[J];
end;

procedure TJvDockVSChannel.FreeBlockList;
var
  I: Integer;
begin
  for I := 0 to FBlockList.Count - 1 do
    Blocks[I].Free;
  FreeAndNil(FBlockList);
end;

function TJvDockVSChannel.GetBlockCount: Integer;
begin
  Result := FBlockList.Count;
end;

procedure TJvDockVSChannel.GetBlockRect(Block: TJvDockVSBlock; Index: Integer;
  var ARect: TRect);
var
  BlockWidth: Integer;
begin
  if Block.VSPanes[Index].FDockForm <> Block.FActiveDockControl then
    BlockWidth := Block.InactiveBlockWidth
  else
    BlockWidth := Block.ActiveBlockWidth;

  case Align of
    alLeft:
      begin
        ARect.Left := -1;
        ARect.Top := FCurrentPos;
        ARect.Right := Width - FBlockUpOffset;
        ARect.Bottom := ARect.Top + BlockWidth;
      end;
    alRight:
      begin
        ARect.Left := FBlockUpOffset;
        ARect.Top := FCurrentPos;
        ARect.Right := Width + 1;
        ARect.Bottom := ARect.Top + BlockWidth;
      end;
    alTop:
      begin
        ARect.Left := FCurrentPos;
        ARect.Top := -1;
        ARect.Right := ARect.Left + BlockWidth;
        ARect.Bottom := Height - FBlockUpOffset;
      end;
    alBottom:
      begin
        ARect.Left := FCurrentPos;
        ARect.Top := FBlockUpOffset;
        ARect.Right := ARect.Left + BlockWidth;
        ARect.Bottom := Height + 1;
      end;
  end;

  Inc(FCurrentPos, BlockWidth - 1);
end;

function TJvDockVSChannel.GetBlocks(Index: Integer): TJvDockVSBlock;
begin
  Result := TJvDockVSBlock(FBlockList[Index]);
end;

function TJvDockVSChannel.GetDockFormWithMousePos(MousePos: TPoint): TJvDockVSPane;
var
  I, J: Integer;
  ARect: TRect;
begin
  Result := nil;
  FCurrentPos := FBlockStartOffset;
  for I := 0 to BlockCount - 1 do
  begin
    for J := 0 to Blocks[I].VSPaneCount - 1 do
    begin
      if not Blocks[I].VSPanes[J].FVisible then
        Continue;
      GetBlockRect(Blocks[I], J, ARect);
      if PtInRect(ARect, MousePos) then
      begin
        Result := Blocks[I].VSPanes[J];
        Exit;
      end;
    end;
    Inc(FCurrentPos, FBlockInterval);
  end;
end;

function TJvDockVSChannel.GetPaneWithControl(AControl: TControl): TJvDockVSPane;
var
  I, J: Integer;
begin
  Result := nil;
  for I := 0 to BlockCount - 1 do
    for J := 0 to Blocks[I].VSPaneCount - 1 do
      if AControl = Blocks[I].VSPanes[J].FDockForm then
      begin
        Result := Blocks[I].VSPanes[J];
        Exit;
      end;
end;

procedure TJvDockVSChannel.HidePopupPanel(Pane: TJvDockVSPane);
begin
  if Pane <> nil then
  begin
    if Align in [alLeft, alRight] then
    begin
      VSPopupPanel.Width := 0;
      VSPopupPanelSplitter.Width := 0;
    end
    else
    if Align in [alTop, alBottom] then
    begin
      VSPopupPanel.Height := 0;
      VSPopupPanelSplitter.Height := 0;
    end;
    FActiveDockForm := nil;
    FActivePane := nil;
  end;
  VSPopupPanel.Visible := False;
  VSPopupPanelSplitter.Visible := False;
  FActivePane := nil;
end;

procedure TJvDockVSChannel.HidePopupPanel(Control: TWinControl);
var
  BlockIndex, PaneIndex: Integer;
begin
  FindDockControl(Control, BlockIndex, PaneIndex);
  if (BlockIndex >= 0) and (PaneIndex >= 0) then
    HidePopupPanel(Blocks[BlockIndex].VSPanes[PaneIndex]);
end;

procedure TJvDockVSChannel.HidePopupPanelWithAnimate;
begin
  if FActivePane <> nil then
    PopupPanelAnimate.HideForm(Self, FActivePane.FWidth);
end;

procedure TJvDockVSChannel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  VSPane: TJvDockVSPane;
begin
  inherited MouseDown(Button, Shift, X, Y);
  VSPane := GetDockFormWithMousePos(Point(X, Y));
  if VSPane <> nil then
  begin
    // There is not "DockFormVisible" or "Hidden" property, so we just use
    // VSPane.FDockForm.CanFocus, which seems to work fine.
    if VSPane.FDockForm.CanFocus then
    begin
      VSPane.FActive := True;
      VSPane.FDockForm.SetFocus;
    end
    else
      PopupDockForm(VSPane);
  end;
end;

procedure TJvDockVSChannel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  // Create the timer object if not existing
  if FAnimationStartTimer = nil then
  begin
    FAnimationStartTimer := TTimer.Create(nil);
    FAnimationStartTimer.OnTimer := AnimationStartTimerOnTimerHandler;
    FAnimationStartTimer.Interval := TJvDockVSNetStyle.GetAnimationStartInterval;
    FAnimationStartTimer.Enabled := True;
  end
  // Restart the timer only, if mouse is above another pane now
  else
  if GetDockFormWithMousePos(Point(X, Y)) <> Pointer(FAnimationStartTimer.Tag) then
  begin
    FAnimationStartTimer.Enabled := False;
    FAnimationStartTimer.Enabled := True;
  end;
  // Store pane under mouse in tag property of the timer
  FAnimationStartTimer.Tag := Integer(GetDockFormWithMousePos(Point(X, Y)));
end;

procedure TJvDockVSChannel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TJvDockVSChannel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FVSPopupPanel then
    begin
      FVSPopupPanel := nil;
      DestroyVSPopupPanel;
    end
    else
    if AComponent = FVSPopupPanelSplitter then
    begin
      FVSPopupPanelSplitter := nil;
      DestroyVSPopupPanel;
    end;
  end;
end;

procedure TJvDockVSChannel.Paint;
var
  I: Integer;

  procedure DrawSingleBlock(Block: TJvDockVSBlock);
  var
    DrawRect: TRect;
    I: Integer;
    OldGraphicsMode: Integer;
    VisiblePaneCount: Integer;

    procedure AdjustImagePos;
    begin
      if Align = alLeft then
      begin
        Inc(DrawRect.Left, 3);
        Inc(DrawRect.Top, 4);
      end
      else
      if Align = alTop then
      begin
        Inc(DrawRect.Left, 4);
        Inc(DrawRect.Top, 2);
      end
      else
      if Align = alRight then
      begin
        Inc(DrawRect.Left, 4);
        Inc(DrawRect.Top, 4);
      end
      else
      if Align = alBottom then
      begin
        Inc(DrawRect.Left, 4);
        Inc(DrawRect.Top, 3);
      end;
    end;

  begin
    VisiblePaneCount := 0;
    for I := 0 to Block.VSPaneCount - 1 do
    begin
      if not Block.VSPanes[I].FVisible then
        Continue;

      GetBlockRect(Block, I, DrawRect);
      Canvas.Brush.Color := (DockServer.DockStyle as TJvDockVSNetStyle).ChannelOption.TabColor;
      Canvas.FillRect(DrawRect);
      Canvas.Brush.Color := clGray;
      Canvas.FrameRect(DrawRect);

      AdjustImagePos;
      Block.FImageList.Draw(Canvas, DrawRect.Left, DrawRect.Top, I);

      if Block.ActiveDockControl = Block.VSPanes[I].FDockForm then
      begin
        if Align in [alTop, alBottom] then
          Inc(DrawRect.Left, Block.InactiveBlockWidth)
        else
        if Align in [alLeft, alRight] then
        begin
          Inc(DrawRect.Top, Block.InactiveBlockWidth);
          if Align = alLeft then
            DrawRect.Left := 15
          else
            DrawRect.Left := 20;
          DrawRect.Right := DrawRect.Left + (DrawRect.Bottom - DrawRect.Top);
        end;
        Canvas.Brush.Color := (DockServer.DockStyle as TJvDockVSNetStyle).ChannelOption.TabColor;
        Canvas.Pen.Color := clBlack;

        Dec(DrawRect.Right, 3);

        OldGraphicsMode := SetGraphicsMode(Canvas.Handle, GM_ADVANCED);
        Canvas.Brush.Style := bsClear;
        DrawText(Canvas.Handle, PChar(Block.VSPanes[I].FDockForm.Caption), -1, DrawRect, DT_END_ELLIPSIS or DT_NOCLIP);
        SetGraphicsMode(Canvas.Handle, OldGraphicsMode);
      end;
      Inc(VisiblePaneCount);
    end;
    if VisiblePaneCount > 0 then
      Inc(FCurrentPos, FBlockInterval);
  end;

begin
  inherited Paint;

  FCurrentPos := FBlockStartOffset;
  for I := 0 to BlockCount - 1 do
    DrawSingleBlock(Blocks[I]);
end;

procedure TJvDockVSChannel.PopupDockForm(Control: TWinControl);
var
  BlockIndex, PaneIndex: Integer;
begin
  FindDockControl(Control, BlockIndex, PaneIndex);
  if (BlockIndex >= 0) and (PaneIndex >= 0) then
    PopupDockForm(Blocks[BlockIndex].VSPanes[PaneIndex]);
end;

procedure TJvDockVSChannel.PopupDockForm(Pane: TJvDockVSPane);

  procedure SetSingleDockFormVisible(HostDockSite: TWinControl; AForm: TForm);
  var
    I: Integer;
  begin
    for I := 0 to HostDockSite.DockClientCount - 1 do
      HostDockSite.DockClients[I].Visible := AForm = HostDockSite.DockClients[I];
  end;

begin
  if (Pane <> nil) and (ActiveDockForm <> Pane.FDockForm) then
  begin
    HidePopupPanel(FActivePane);
    Pane.FDockForm.Visible := True;
    PopupPanelAnimate.PopupForm(Self, Pane.FWidth);
    if (Pane.FDockForm <> nil) and (Pane.FDockForm.HostDockSite.Parent is TJvDockTabHostForm) then
    begin
      FVSPopupPanel.JvDockManager.ShowSingleControl(Pane.FDockForm.HostDockSite.Parent);
      SetSingleDockFormVisible(Pane.FDockForm.HostDockSite, Pane.FDockForm);
      TJvDockTabHostForm(Pane.FDockForm.HostDockSite.Parent).Caption := Pane.FDockForm.Caption;
    end
    else
      FVSPopupPanel.JvDockManager.ShowSingleControl(Pane.FDockForm);
    FActiveDockForm := Pane.FDockForm;
    FActivePane := Pane;
    FVSPopupPanel.JvDockManager.ResetBounds(True);

    Pane.FBlock.ActiveDockControl := Pane.FDockForm;
//    Invalidate;
  end;
end;

procedure TJvDockVSChannel.RemoveAllBlock;
var
  I: Integer;
begin
  for I := BlockCount - 1 downto 0 do
    DeleteBlock(I);
  FActiveDockForm := nil;
end;

procedure TJvDockVSChannel.RemoveDockControl(Control: TWinControl);
var
  BlockIndex, PaneIndex: Integer;
begin
  VSPopupPanel.Visible := False;
  if FindDockControl(Control, BlockIndex, PaneIndex) then
  begin
    Blocks[BlockIndex].DeletePane(PaneIndex);
    if (Blocks[BlockIndex].VSPaneCount <= 0) or (Blocks[BlockIndex].FBlockType = btTabBlock) then
      DeleteBlock(BlockIndex);
  end;
  ResetPosition;
  Invalidate;
end;

procedure TJvDockVSChannel.ResetActivePaneWidth;
var
  DockClient: TJvDockClient;
begin
  if FActivePane = nil then
    Exit;

  DockClient := FindDockClient(FActivePane.FDockForm);
  if Align in [alLeft, alRight] then
    FActivePane.FWidth := VSPopupPanel.Width
  else
  if Align in [alTop, alBottom] then
    FActivePane.FWidth := VSPopupPanel.Height + VSPopupPanel.JvDockManager.GrabberSize;
  if DockClient <> nil then
    DockClient.VSPaneWidth := FActivePane.FWidth;
end;

procedure TJvDockVSChannel.ResetBlock;
var
  I: Integer;
begin
  if BlockCount > 0 then
  begin
    Blocks[0].FBlockStartPos := FBlockStartOffset;
    for I := 1 to BlockCount - 1 do
      Blocks[I].FBlockStartPos := Blocks[I - 1].FBlockStartPos + Blocks[I - 1].GetTotalWidth + FBlockInterval;
  end;
end;

procedure TJvDockVSChannel.ResetFontAngle;
var
  LogFont: TLogFont;
begin
  if Align in [alLeft, alRight] then
    if GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont) <> 0 then
    begin
      LogFont.lfEscapement := 2700;
      LogFont.lfOrientation := 2700;
      Canvas.Font.Handle := CreateFontIndirect(LogFont);
    end;
end;

procedure TJvDockVSChannel.ResetPopupPanelHeight;
begin
  if Align in [alLeft, alRight] then
  begin
    VSPopupPanel.Top := Top;
    VSPopupPanel.Height := Height;
    VSPopupPanelSplitter.Top := Top;
    VSPopupPanelSplitter.Height := Height;
  end;
end;

procedure TJvDockVSChannel.ResetPosition;
var
  I, J: Integer;
  PaneCount: Integer;
begin
  PaneCount := 0;
  for I := 0 to BlockCount - 1 do
    for J := 0 to Blocks[I].VSPaneCount - 1 do
      if Blocks[I].VSPanes[J].FVisible = True then
        Inc(PaneCount);

  Visible := PaneCount > 0;
  case Align of
    alLeft:
      begin
        Width := FChannelWidth;
        Left := GetClientAlignControlArea(Parent, Align, Self);
      end;
    alRight:
      begin
        Width := FChannelWidth;
        Left := Parent.ClientWidth - GetClientAlignControlArea(Parent, Align, Self) - FChannelWidth + 1;
      end;
    alTop:
      begin
        Height := FChannelWidth;
        Top := GetClientAlignControlArea(Parent, Align, Self);
      end;
    alBottom:
      begin
        Height := FChannelWidth;
        Top := Parent.ClientHeight - GetClientAlignControlArea(Parent, Align, Self) - FChannelWidth + 1;
      end;
  end;
end;

procedure TJvDockVSChannel.SetActivePaneSize(const Value: Integer);
begin
  if FActivePaneSize <> Value then
  begin
    FActivePaneSize := Value;
    Invalidate;
  end;
end;

procedure TJvDockVSChannel.SetBlockStartOffset(const Value: Integer);
begin
  FBlockStartOffset := Value;
end;

procedure TJvDockVSChannel.SetVSPopupPanelSplitterPosition;
begin
  case Align of
    alLeft:
      begin
        VSPopupPanelSplitter.Left := VSPopupPanel.Left + VSPopupPanel.Width;
        VSPopupPanelSplitter.Width := VSPopupPanelSplitter.SplitWidth;
        VSPopupPanelSplitter.Top := VSPopupPanel.Top;
        VSPopupPanelSplitter.Height := VSPopupPanel.Height;
      end;
    alRight:
      begin
        VSPopupPanelSplitter.Left := VSPopupPanel.Left - VSPopupPanelSplitter.SplitWidth;
        VSPopupPanelSplitter.Width := VSPopupPanelSplitter.SplitWidth;
        VSPopupPanelSplitter.Top := VSPopupPanel.Top;
        VSPopupPanelSplitter.Height := VSPopupPanel.Height;
      end;
    alTop:
      begin
        VSPopupPanelSplitter.Left := VSPopupPanel.Left;
        VSPopupPanelSplitter.Width := VSPopupPanel.Width;
        VSPopupPanelSplitter.Top := VSPopupPanel.Top + VSPopupPanel.Height;
        VSPopupPanelSplitter.Height := VSPopupPanelSplitter.SplitWidth;
      end;
    alBottom:
      begin
        VSPopupPanelSplitter.Left := VSPopupPanel.Left;
        VSPopupPanelSplitter.Width := VSPopupPanel.Width;
        VSPopupPanelSplitter.Top := VSPopupPanel.Top - VSPopupPanelSplitter.SplitWidth;
        VSPopupPanelSplitter.Height := VSPopupPanelSplitter.SplitWidth;
      end;
  end;
  VSPopupPanelSplitter.Visible := True;
  VSPopupPanelSplitter.BringToFront;
end;

procedure TJvDockVSChannel.ShowPopupPanel(Control: TWinControl);
var
  BlockIndex, PaneIndex: Integer;
begin
  FindDockControl(Control, BlockIndex, PaneIndex);
  if (BlockIndex >= 0) and (PaneIndex >= 0) then
    ShowPopupPanel(Blocks[BlockIndex].VSPanes[PaneIndex]);
end;

procedure TJvDockVSChannel.ShowPopupPanel(Pane: TJvDockVSPane);

  procedure SetControlBringToFront(Control: TWinControl; Align: TAlign);
  var
    I: Integer;
  begin
    for I := Control.ControlCount - 1 downto 0 do
      if Control.Controls[I].Visible and (Control.Controls[I].Align = Align) and
        not (Control.Controls[I] is TJvDockVSChannel) and
        not (Control.Controls[I] is TJvDockPanel) and
        not (Control.Controls[I] is TJvDockSplitter) then
        Control.Controls[I].BringToFront;
  end;

  procedure SetSingleDockFormVisible(HostDockSite: TWinControl; AForm: TForm);
  var
    I: Integer;
  begin
    for I := 0 to HostDockSite.DockClientCount - 1 do
      HostDockSite.DockClients[I].Visible := AForm = HostDockSite.DockClients[I];
  end;
var
  LShowControl: TWinControl;
begin
  if Pane <> nil then
  begin
    JvDockLockWindow(nil);
    Parent.DisableAlign;
    try
      { Auto-hide all popups of this pane }
      HidePopupPanel(FActivePane);
      Pane.FDockForm.Visible := True;
      if (Pane.FDockForm <> nil) and (Pane.FDockForm.HostDockSite.Parent is TJvDockTabHostForm) then
      begin
        FVSPopupPanel.JvDockManager.ShowSingleControl(Pane.FDockForm.HostDockSite.Parent);
        SetSingleDockFormVisible(Pane.FDockForm.HostDockSite, Pane.FDockForm);
        TJvDockTabHostForm(Pane.FDockForm.HostDockSite.Parent).Caption := Pane.FDockForm.Caption;
      end
      else
        FVSPopupPanel.JvDockManager.ShowSingleControl(Pane.FDockForm);

      FActiveDockForm := Pane.FDockForm;
      FActivePane := Pane;
      FVSPopupPanel.JvDockManager.ResetBounds(True);

      Pane.FBlock.ActiveDockControl := Pane.FDockForm;
      //Invalidate;
      VSPopupPanel.BringToFront;
      VSPopupPanelSplitter.BringToFront;
      SetControlBringToFront(Parent, Align);
      BringToFront;
      case Align of
        alLeft:
          begin
            VSPopupPanel.Width := Pane.FWidth;
            VSPopupPanel.Top := Top;
            VSPopupPanel.Height := Height;
            VSPopupPanelSplitter.Top := Top;
            VSPopupPanelSplitter.Height := Height;
            VSPopupPanelSplitter.Width := VSPopupPanelSplitter.SplitWidth;
            VSPopupPanel.Left := Left + Width + Pane.FWidth - VSPopupPanel.Width;
            VSPopupPanelSplitter.Left := VSPopupPanel.Left + VSPopupPanel.Width;
          end;
        alRight:
          begin
            VSPopupPanel.Width := Pane.FWidth;
            VSPopupPanel.Top := Top;
            VSPopupPanel.Height := Height;
            VSPopupPanelSplitter.Top := Top;
            VSPopupPanelSplitter.Height := Height;
            VSPopupPanelSplitter.Width := VSPopupPanelSplitter.SplitWidth;
            VSPopupPanel.Left := Left - Pane.FWidth;
            VSPopupPanelSplitter.Left := VSPopupPanel.Left - VSPopupPanelSplitter.SplitWidth;
          end;
        alTop:
          begin
            VSPopupPanel.Left := Left;
            VSPopupPanel.Height := Pane.FWidth;
            VSPopupPanel.Width := Width;
            VSPopupPanelSplitter.Left := Left;
            VSPopupPanelSplitter.Width := Width;
            VSPopupPanelSplitter.Height := VSPopupPanelSplitter.SplitWidth;
            VSPopupPanel.Top := Top + Height + Pane.FWidth - VSPopupPanel.Height;
            VSPopupPanelSplitter.Top := VSPopupPanel.Top + VSPopupPanel.Height;
          end;
        alBottom:
          begin
            VSPopupPanel.Left := Left;
            VSPopupPanel.Width := Width;
            VSPopupPanel.Height := Pane.FWidth;
            VSPopupPanelSplitter.Left := Left;
            VSPopupPanelSplitter.Width := Width;
            VSPopupPanelSplitter.Height := VSPopupPanelSplitter.SplitWidth;
            VSPopupPanel.Top := Top - Pane.FWidth;
            VSPopupPanelSplitter.Top := VSPopupPanel.Top - VSPopupPanelSplitter.SplitWidth;
          end;
      end;
      VSPopupPanel.Visible := True;
      VSPopupPanelSplitter.Visible := True;

      { If the form is on a tab, then show the parent of the pagecontrol
        (a TJvDockTabHostForm), otherwise show the form.
      }
      LShowControl := nil;
      case Pane.FBlock.BlockType of
        btTabBlock:
          if Pane.FDockForm.Parent is TJvDockTabSheet then
          begin
            LShowControl := TJvDockTabSheet(Pane.FDockForm.Parent).PageControl;
            if Assigned(LShowControl) then
              LShowControl := LShowControl.Parent;
          end;
        btConjoinBlock: LShowControl := Pane.FDockForm;
      end;
      if Assigned(LShowControl) then
        FVSPopupPanel.DoShowControl(LShowControl);
    finally
      Parent.EnableAlign;
      JvDockUnLockWindow;
    end;
    if ActiveDockForm <> nil then
      if ActiveDockForm.CanFocus then
        ActiveDockForm.SetFocus;
  end;
end;

//=== { TJvDockVSNETChannelOption } ==========================================

constructor TJvDockVSNETChannelOption.Create(ADockStyle: TJvDockBasicStyle);
begin
  inherited Create(ADockStyle);
  FActivePaneSize := 100;
  FShowImage := True;
  FMouseleaveHide := True;
  FHideHoldTime := 1000;
  FTabColor := clBtnFace;
end;

procedure TJvDockVSNETChannelOption.ResetDockClientOption(ADockClient: TJvDockClient);
var
  VSChannel: TJvDockVSChannel;

  procedure ResetActiveBlockSize;
  begin
    if VSChannel <> nil then
      VSChannel.ActivePaneSize := ActivePaneSize;
  end;

begin
  if ADockClient = nil then
    Exit;
  if ADockClient.ParentForm.HostDockSite is TJvDockVSPopupPanel then
    VSChannel := TJvDockVSPopupPanel(ADockClient.ParentForm.HostDockSite).VSChannel
  else
  if (ADockClient.ParentForm.HostDockSite is TJvDockVSNETTabPageControl) and
    (ADockClient.ParentForm.HostDockSite.Parent.HostDockSite is TJvDockVSPopupPanel) then
    VSChannel := TJvDockVSPopupPanel(ADockClient.ParentForm.HostDockSite.Parent.HostDockSite).VSChannel;
  ResetActiveBlockSize;
end;

procedure TJvDockVSNETChannelOption.ResetDockControlOption;
var
  I: Integer;
  ADockServer: TJvDockServer;
begin
  if DockStyle <> nil then
    for I := 0 to DockStyle.Count - 1 do
      if DockStyle.DockBaseControlLists[I] is TJvDockServer then
      begin
        ADockServer := TJvDockServer(DockStyle.DockBaseControlLists[I]);
        ResetDockServerOption(ADockServer);
      end;
end;

procedure TJvDockVSNETChannelOption.ResetDockServerOption(ADockServer: TJvDockServer);
var
  VSChannel: TJvDockVSChannel;

  procedure ResetActiveBlockSize;
  begin
    if VSChannel <> nil then
      VSChannel.ActivePaneSize := ActivePaneSize;
  end;

var
  I: TAlign;
begin
  if ADockServer <> nil then
    for I := alTop to alRight do
      if ADockServer.DockPanelWithAlign[I] <> nil then
      begin
        VSChannel := TJvDockVSNETPanel(ADockServer.DockPanelWithAlign[I]).VSChannel;
        ResetActiveBlockSize;
      end;
end;

procedure TJvDockVSNETChannelOption.SetActivePaneSize(const Value: Integer);
begin
  if FActivePaneSize <> Value then
  begin
    FActivePaneSize := Max(24, Value);
    ResetDockControlOption;
  end;
end;

procedure TJvDockVSNETChannelOption.SetHideHoldTime(const Value: Integer);
begin
  if FHideHoldTime <> Value then
    if Value < 100 then
    begin
      { (rom) disabled
      if csDesigning in DockStyle.ComponentState then
        ShowMessage('HideHoldTime cannot be less than 100');
      }
      FHideHoldTime := 100;
    end
    else
      FHideHoldTime := Value;
end;

procedure TJvDockVSNETChannelOption.SetMouseleaveHide(const Value: Boolean);
begin
  if FMouseleaveHide <> Value then
    FMouseleaveHide := Value;
end;

procedure TJvDockVSNETChannelOption.SetShowImage(const Value: Boolean);
begin
  FShowImage := Value;
end;

//=== { TJvDockVSNETConjoinServerOption } ====================================

constructor TJvDockVSNETConjoinServerOption.Create(ADockStyle: TJvDockBasicStyle);
begin
  inherited Create(ADockStyle);
  SystemInfo := True;
end;

procedure TJvDockVSNETConjoinServerOption.SetDefaultSystemCaptionInfo;
begin
  inherited SetDefaultSystemCaptionInfo;

  ActiveFont.Color := clWhite;
  ActiveFont.Style := [];

  InactiveFont.Color := clBlack;
  InactiveFont.Style := [];

  SetActiveTitleEndColor_WithoutChangeSystemInfo(ActiveTitleStartColor);
  SetInactiveTitleStartColor_WithoutChangeSystemInfo(clBtnFace);
  SetInactiveTitleEndColor_WithoutChangeSystemInfo(clBtnFace);
end;

//=== { TJvDockVSNETPanel } ==================================================

constructor TJvDockVSNETPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVSChannelClass := TJvDockVSChannel;
end;

procedure TJvDockVSNETPanel.AddDockServer(ADockServer: TJvDockServer);
begin
  { Dirty; resolve with new class? }
  if not (Self is TJvDockVSPopupPanel) and Assigned(ADockServer) then
  begin
    Assert(Assigned(ADockServer.DockStyle));
    CreateVSChannel(ADockServer.DockStyle);
  end;
end;

procedure TJvDockVSNETPanel.CreateVSChannel(DockStyle: TComponent);
begin
  if (FVSChannelClass <> nil) and
    { (rb) ??? }
    (FVSChannelClass <> TJvDockVSChannelClass(ClassType)) then
  begin
    FVSChannel := FVSChannelClass.Create(Self);
    FVSChannel.Parent := Parent;
    FVSChannel.Align := Align;
    FVSChannel.ResetFontAngle;
    FVSChannel.ResetPosition;
    FVSChannel.Visible := False;
    FVSChannel.Name := Name + '_VSChannel';
    FVSChannel.CreateVSPopupPanel(DockStyle);
    FVSChannel.FreeNotification(Self);
  end;
end;

procedure TJvDockVSNETPanel.CustomDockDrop(Source: TJvDockDragDockObject;
  X, Y: Integer);
begin
  inherited CustomDockDrop(Source, X, Y);
  VSChannel.ActiveDockForm.Perform(CM_EXIT, 0, 0);
end;

procedure TJvDockVSNETPanel.DestroyVSChannel;
begin
  FVSChannel.Free;
  FVSChannel := nil;
end;

procedure TJvDockVSNETPanel.DoAutoHideControl(Control: TWinControl);
begin
  if Align = alNone then
    DoShowControl(Control)
  else
    DoHideControl(Control);
end;

procedure TJvDockVSNETPanel.DoHideControl(Control: TWinControl);
begin
  JvDockLockWindow(nil);
  DisableAlign;
  try
    VSChannel.AddDockControl(Control);
    ShowDockPanel(VisibleDockClientCount > 1, Control, sdfDockPanel);
    Control.Dock(VSChannel.VSPopupPanel, Rect(0, 0, 0, 0));
    VSChannel.VSPopupPanel.JvDockManager.InsertControl(Control, alNone, nil);
    VSChannel.VSPopupPanel.JvDockManager.ShowSingleControl(Control);
    JvDockManager.HideControl(Control);
    ResetChannelBlockStartOffset(VSChannel);
  finally
    EnableAlign;
    JvDockUnLockWindow;
  end;
end;

procedure TJvDockVSNETPanel.DoShowControl(Control: TWinControl);
var
  Panel: TJvDockVSNETPanel;

  procedure ResetDockFormVisible;
  var
    I: Integer;
  begin
    if Control is TJvDockTabHostForm then
      with TJvDockTabHostForm(Control) do
        for I := 0 to PageControl.Count - 1 do
        begin
          PageControl.Pages[I].Visible := TJvDockVSNETTabSheet(PageControl.Pages[I]).OldVisible;
          PageControl.Pages[I].Controls[0].Visible := PageControl.Pages[I].Visible;
        end;
  end;

begin
  { Dirty; solve with virtual method? }
  if Self is TJvDockVSPopupPanel then
  begin
    Panel := TJvDockVSPopupPanel(Self).FVSNETDockPanel;

    JvDockLockWindow(nil);
    Panel.DisableAlign;
    try
      Control.Dock(Panel, Rect(0, 0, 0, 0));
      Panel.JvDockManager.ShowControl(Control);
      JvDockManager.RemoveControl(Control);
      Panel.VSChannel.RemoveDockControl(Control);
      Panel.ShowDockPanel(Panel.VisibleDockClientCount > 0, Control, sdfDockPanel);
      if (Panel.VSChannel.ActiveDockForm <> nil) and Panel.VSChannel.ActiveDockForm.CanFocus then
        Panel.VSChannel.ActiveDockForm.SetFocus;
      Panel.VSChannel.HidePopupPanel(Panel.VSChannel.FActivePane);
      ResetDockFormVisible;
      ResetChannelBlockStartOffset(Panel.VSChannel);
    finally
      Panel.EnableAlign;
      JvDockUnLockWindow;
    end;
  end;
end;

procedure TJvDockVSNETPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = VSChannel) and (Operation = opRemove) then
    FVSChannel := nil;
end;

procedure TJvDockVSNETPanel.RemoveDockServer(ADockServer: TJvDockServer);
begin
  DestroyVSChannel;
end;

procedure TJvDockVSNETPanel.Resize;
begin
  inherited Resize;
  if (Align in [alTop, alBottom]) and Assigned(DockServer) then
  begin
    if Assigned(DockServer.DockPanelWithAlign[alLeft]) then
      TJvDockVSNETPanel(DockServer.DockPanelWithAlign[alLeft]).VSChannel.ResetPopupPanelHeight;
    if Assigned(DockServer.DockPanelWithAlign[alRight]) then
      TJvDockVSNETPanel(DockServer.DockPanelWithAlign[alRight]).VSChannel.ResetPopupPanelHeight;
  end;
end;

//=== { TJvDockVSNetStyle } ==================================================

constructor TJvDockVSNetStyle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMouseleaved := True;
  DockPanelClass := TJvDockVSNETPanel;
  DockSplitterClass := TJvDockVSNETSplitter;
  ConjoinPanelClass := TJvDockVSNETConjoinPanel;
  TabDockClass := TJvDockVSNETTabPageControl;
  DockPanelTreeClass := TJvDockVSNETTree;
  DockPanelZoneClass := TJvDockVSNETZone;
  ConjoinPanelTreeClass := TJvDockVSNETTree;
  ConjoinPanelZoneClass := TJvDockVSNETZone;
  ConjoinServerOptionClass := TJvDockVSNETConjoinServerOption;
  TabServerOptionClass := TJvDockVSNETTabServerOption;
  FChannelOptionClass := TJvDockVSNETChannelOption;

  FDockServerList := TList.Create;
end;

destructor TJvDockVSNetStyle.Destroy;
begin
  { Note that RemoveDockBaseControl can be called in the inherited Destroy call.
    So we set FTimer to nil, and destroy FDockServerList after the inherited call.
  }
  FTimer.Free;
  FTimer := nil;
  inherited Destroy;
  FDockServerList.Free;
end;

procedure TJvDockVSNetStyle.AddDockBaseControl(ADockBaseControl: TJvDockBaseControl);
begin
  if ADockBaseControl = nil then
    Exit;
  if DockBaseControlList.IndexOf(ADockBaseControl) = -1 then
  begin
    inherited AddDockBaseControl(ADockBaseControl);
    ChannelOption.ResetDockControlOption;
  end;

  if ADockBaseControl is TJvDockServer then
  begin
    if FDockServerList.IndexOf(ADockBaseControl) = -1 then
      FDockServerList.Add(ADockBaseControl);
    if not Assigned(FTimer) then
    begin
      FTimer := TTimer.Create(Self);
      FTimer.Interval := 100;
      FTimer.OnTimer := Self.Timer;
      FTimer.Enabled := True;
    end;
  end;
end;

procedure TJvDockVSNetStyle.CreateConjoinServerOption(var Option: TJvDockBasicConjoinServerOption);
begin
  Option := TJvDockVSNETConjoinServerOption.Create(Self);
end;

procedure TJvDockVSNetStyle.CreateServerOption;
begin
  inherited CreateServerOption;
  if FChannelOptionClass <> nil then
    FChannelOption := FChannelOptionClass.Create(Self);
end;

procedure TJvDockVSNetStyle.CreateTabServerOption(var Option: TJvDockBasicTabServerOption);
begin
  Option := TJvDockVSNETTabServerOption.Create(Self);
end;

function TJvDockVSNetStyle.DockClientWindowProc(DockClient: TJvDockClient;
  var Msg: TMessage): Boolean;
var
  Channel: TJvDockVSChannel;
  FormRect: TRect;
  MPosTp: TPoint;
begin
  Result := inherited DockClientWindowProc(DockClient, Msg);
  case Msg.Msg of
    CM_MOUSEENTER:
      begin
        FMouseleaved := False;
      end;
    CM_MOUSELEAVE: //Fix bug on AutoHide --Dejoy.
      begin
        GetCursorPos(MPosTp);
        GetWindowRect(DockClient.ParentForm.Handle, FormRect);
        if not PtInRect(FormRect, MPosTp) then
          FMouseleaved := True;
      end;
    CM_ENTER, CM_EXIT:
      begin
        Channel := nil;
        if DockClient.ParentForm.HostDockSite is TJvDockVSPopupPanel then
          Channel := TJvDockVSPopupPanel(DockClient.ParentForm.HostDockSite).VSChannel
        else
        if DockClient.ParentForm.HostDockSite <> nil then
        begin
          if DockClient.ParentForm.HostDockSite.Parent is TJvDockVSPopupPanel then
            Channel := TJvDockVSPopupPanel(DockClient.ParentForm.HostDockSite.Parent).VSChannel
          else
          if (DockClient.ParentForm.HostDockSite.Parent <> nil) and
            (DockClient.ParentForm.HostDockSite.Parent.Parent is TJvDockVSPopupPanel) then
            Channel := TJvDockVSPopupPanel(DockClient.ParentForm.HostDockSite.Parent.Parent).VSChannel;
        end;
        if Msg.Msg = CM_EXIT then
        begin
          if Channel <> nil then
            Channel.HidePopupPanelWithAnimate;
        end
        else
        if Msg.Msg = CM_ENTER then
          HideAllPopupPanel(Channel);
      end;
  end;
end;

function TJvDockVSNetStyle.DockServerWindowProc(DockServer: TJvDockServer;
  var Msg: TMessage): Boolean;
var
  I: TAlign;
  Channel: TJvDockVSChannel;
begin
  Result := inherited DockServerWindowProc(DockServer, Msg);
  if Msg.Msg = WM_SIZE then
    for I := alTop to alRight do
    begin
      Channel := nil;
      if DockServer.DockPanelWithAlign[I] <> nil then
        Channel := TJvDockVSNETPanel(DockServer.DockPanelWithAlign[I]).VSChannel;
      if Channel <> nil then
        Channel.HidePopupPanel(Channel.FActivePane);
    end;
end;

procedure TJvDockVSNetStyle.FreeServerOption;
begin
  inherited FreeServerOption;
  FChannelOption.Free;
  FChannelOption := nil;
end;

class function TJvDockVSNetStyle.GetAnimationInterval: Integer;
begin
  Result := GlobalPopupPanelAnimateInterval;
end;

class function TJvDockVSNetStyle.GetAnimationMoveWidth: Integer;
begin
  Result := GlobalPopupPanelAnimateMoveWidth;
end;

class function TJvDockVSNetStyle.GetAnimationStartInterval: Integer;
begin
  Result := GlobalPopupPanelStartAnimateInterval;
end;

function TJvDockVSNetStyle.GetChannelOption: TJvDockVSNETChannelOption;
begin
  Result := FChannelOption;
end;

{$IFNDEF USEJVCL}
function TJvDockVSNetStyle.GetControlName: string;
begin
  Result := Format(RsDockLikeVSNETStyle, [RsDockStyleName]);
end;
{$ENDIF !USEJVCL}

function TJvDockVSNetStyle.GetDockFormVisible(ADockClient: TJvDockClient): Boolean;
var
  VSChannel: TJvDockVSChannel;
  Pane: TJvDockVSPane;
begin
  Result := True;
  if ADockClient <> nil then
  begin
    if not (ADockClient.ParentForm is TJvDockTabHostForm) and
      (ADockClient.ParentForm.HostDockSite is TJvDockVSPopupPanel) then
    begin
      VSChannel := TJvDockVSPopupPanel(ADockClient.ParentForm.HostDockSite).VSChannel;
      if VSChannel <> nil then
        Pane := VSChannel.FindPane(ADockClient.ParentForm)
      else
        Pane := nil;
      if Pane <> nil then
        Result := Pane.FVisible;
    end
    else
    if (ADockClient.ParentForm.HostDockSite <> nil) and (ADockClient.ParentForm.HostDockSite.Parent <> nil) and
      (ADockClient.ParentForm.HostDockSite.Parent.HostDockSite is TJvDockVSPopupPanel) then
    begin
      VSChannel := TJvDockVSPopupPanel(ADockClient.ParentForm.HostDockSite.Parent.HostDockSite).VSChannel;
      if VSChannel <> nil then
        Pane := VSChannel.FindPane(ADockClient.ParentForm)
      else
        Pane := nil;
      if Pane <> nil then
        Result := Pane.FVisible;
    end
    else
      Result := inherited GetDockFormVisible(ADockClient);
  end;
end;

procedure TJvDockVSNetStyle.HideDockForm(ADockClient: TJvDockClient);
begin
  inherited HideDockForm(ADockClient);
  SetDockFormVisible(ADockClient, False);
end;

procedure TJvDockVSNetStyle.RemoveDockBaseControl(
  ADockBaseControl: TJvDockBaseControl);
begin
  if ADockBaseControl = nil then
    Exit;
  if DockBaseControlList.IndexOf(ADockBaseControl) >= 0 then
  begin
    inherited RemoveDockBaseControl(ADockBaseControl);
    //ChannelOption.ResetDockControlOption;
  end;

  if ADockBaseControl is TJvDockServer then
  begin
    if FDockServerList.IndexOf(ADockBaseControl) >= 0 then
      FDockServerList.Remove(ADockBaseControl);
    if FDockServerList.Count = 0 then
    begin
      FTimer.Free;
      FTimer := nil;
    end;
  end;
end;

procedure TJvDockVSNetStyle.RestoreClient(DockClient: TJvDockClient);
begin
  if (DockClient.ParentForm.HostDockSite is TJvDockVSPopupPanel) or
    ((DockClient.ParentForm.Parent <> nil) and (DockClient.ParentForm.Parent.HostDockSite is TJvDockVSPopupPanel)) then
    Exit;
  inherited RestoreClient(DockClient);
end;

class procedure TJvDockVSNetStyle.SetAnimationInterval(const Value: Integer);
begin
  if GlobalPopupPanelAnimateInterval <> Value then
  begin
    GlobalPopupPanelAnimateInterval := Value;
    FreeAndNil(GlobalPopupPanelAnimate);
  end;
end;

class procedure TJvDockVSNetStyle.SetAnimationMoveWidth(const Value: Integer);
begin
  if GlobalPopupPanelAnimateMoveWidth <> Value then
  begin
    GlobalPopupPanelAnimateMoveWidth := Value;
    FreeAndNil(GlobalPopupPanelAnimate);
  end;
end;

procedure TJvDockVSNetStyle.SetChannelOption(const Value: TJvDockVSNETChannelOption);
begin
  { !! May be nil }
  FChannelOption.Assign(Value);
end;

procedure TJvDockVSNetStyle.SetDockFormVisible(ADockClient: TJvDockClient;
  AVisible: Boolean);
var
  VSChannel: TJvDockVSChannel;
  Pane: TJvDockVSPane;

  procedure ResetActiveControl;
  var
    I: Integer;
  begin
    if AVisible then
      Pane.FBlock.ActiveDockControl := ADockClient.ParentForm
    else
    begin
      for I := Pane.FIndex downto 0 do
        if Pane.FBlock.VSPanes[I].FVisible then
        begin
          Pane.FBlock.ActiveDockControl := Pane.FBlock.VSPanes[I].FDockForm;
          Exit;
        end;
      for I := Pane.FIndex + 1 to Pane.FBlock.VSPaneCount - 1 do
        if Pane.FBlock.VSPanes[I].FVisible then
        begin
          Pane.FBlock.ActiveDockControl := Pane.FBlock.VSPanes[I].FDockForm;
          Exit;
        end;
    end;
  end;
begin
  if ADockClient <> nil then
  begin
    VSChannel := nil;
    if not (ADockClient.ParentForm is TJvDockTabHostForm) and
      (ADockClient.ParentForm.HostDockSite is TJvDockVSPopupPanel) then
    begin
      VSChannel := TJvDockVSPopupPanel(ADockClient.ParentForm.HostDockSite).VSChannel;
      if VSChannel <> nil then
        Pane := VSChannel.FindPane(ADockClient.ParentForm)
      else
        Pane := nil;
      Pane := VSChannel.FindPane(ADockClient.ParentForm);
      if Pane <> nil then
      begin
        Pane.FVisible := AVisible;
        ResetActiveControl;
      end;
    end
    else
    if (ADockClient.ParentForm.HostDockSite <> nil) and (ADockClient.ParentForm.HostDockSite.Parent <> nil) and
      (ADockClient.ParentForm.HostDockSite.Parent.HostDockSite is TJvDockVSPopupPanel) then
    begin
      VSChannel := TJvDockVSPopupPanel(ADockClient.ParentForm.HostDockSite.Parent.HostDockSite).VSChannel;
      if VSChannel <> nil then
        Pane := VSChannel.FindPane(ADockClient.ParentForm)
      else
        Pane := nil;
      if Pane <> nil then
      begin
        Pane.FVisible := AVisible;
        ResetActiveControl;
        TJvDockVSNETTabSheet(ADockClient.ParentForm.Parent).OldVisible := AVisible;
      end;
    end;
    if VSChannel <> nil then
    begin
      VSChannel.ResetPosition;
      VSChannel.Invalidate;
    end;
  end;
end;

procedure TJvDockVSNetStyle.ShowDockForm(ADockClient: TJvDockClient);
begin
  inherited ShowDockForm(ADockClient);
  SetDockFormVisible(ADockClient, True);
end;

procedure TJvDockVSNetStyle.Timer(Sender: TObject);
var
  MPosTp: TPoint;
  ControlH: HWND;
  WControl: TWinControl;
  P: TWinControl;
  I: Integer;
  J: TAlign;
  VSChannel: TJvDockVSChannel;
begin
  if not ChannelOption.MouseleaveHide then
    Exit;
  if csDesigning in ComponentState then
    Exit;

  if (GetAsyncKeyState(VK_LBUTTON) and $8000) <> 0 then
    Exit;
  GetCursorPos(MPosTp);
  ControlH := WindowFromPoint(MPosTp);
  WControl := FindControl(ControlH);
  P := WControl;
  while P <> nil do
  begin
    if (P is TJvDockVSPopupPanel) or
      (P is TJvDockVSPopupPanelSplitter) or
      (P is TJvDockVSChannel) then
    begin
      FCurrentTimer := ChannelOption.HideHoldTime;
      Break;
    end;
    P := P.Parent;
  end;
  if (P = nil) and (FMouseleaved) then
  begin
    Dec(FCurrentTimer, 100);
    if (FCurrentTimer > 0) or (FCurrentTimer < -100) then
      Exit
    else
      FCurrentTimer := -101;
    for I := 0 to FDockServerList.Count - 1 do
      for J := alTop to alRight do
        if Assigned(TJvDockServer(FDockServerList[I]).DockPanelWithAlign[J]) then
        begin
          VSChannel := TJvDockVSNETPanel(TJvDockServer(FDockServerList[I]).DockPanelWithAlign[J]).VSChannel;
          VSChannel.HidePopupPanelWithAnimate;
        end;
  end;
end;

//=== { TJvDockVSNETTabPageControl } =========================================

constructor TJvDockVSNETTabPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TabSheetClass := TJvDockVSNETTabSheet;
  TabPanelClass := TJvDockVSNETTabPanel;
end;

procedure TJvDockVSNETTabPageControl.ShowControl(AControl: TControl);
begin
  inherited ShowControl(AControl);
end;

//=== { TJvDockVSNETTabPanel } ===============================================

constructor TJvDockVSNETTabPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TabHeight := 25;
  CaptionTopOffset := 1;
end;

//=== { TJvDockVSNETTabServerOption } ========================================

constructor TJvDockVSNETTabServerOption.Create(ADockStyle: TJvDockBasicStyle);
begin
  inherited Create(ADockStyle);
  InactiveFont.Color := VSNETPageInactiveFontColor;
  InactiveSheetColor := VSNETPageInactiveSheetColor;
  ShowTabImages := True;
end;

//=== { TJvDockVSNETTabSheet } ===============================================

constructor TJvDockVSNETTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldVisible := True;
end;

procedure TJvDockVSNETTabSheet.SetOldVisible(const Value: Boolean);
begin
  FOldVisible := Value;
end;

//=== { TJvDockVSNETTree } ===================================================

constructor TJvDockVSNETTree.Create(DockSite: TWinControl;
  DockZoneClass: TJvDockZoneClass; ADockStyle: TComponent);
begin
  inherited Create(DockSite, DockZoneClass, ADockStyle);

  // This happens in the base class TJvDockTree:
  //GrabberSize := 0;
  //if Assigned(ADockStyle) then
  //  GrabberSize := TJvDockBasicStyle(ADockStyle).GrabberSize:
  if GrabberSize <= 0 then
    GrabberSize := DefaultVSNETGrabberSize;
  ButtonHeight := 12;
  ButtonWidth := 16;
  LeftOffset := 2;
  RightOffset := 3;
  TopOffset := 4;
  BottomOffset := 3;
  ButtonSplitter := 2;
  CaptionLeftOffset := 5;
  CaptionRightOffset := 5;
end;

procedure TJvDockVSNETTree.BeginDrag(Control: TControl; Immediate: Boolean;
  Threshold: Integer);
begin
  if not (DockSite is TJvDockVSPopupPanel) then
    inherited BeginDrag(Control, Immediate, Threshold);
end;

procedure TJvDockVSNETTree.CustomLoadZone(Stream: TStream;
  var Zone: TJvDockZone);
var
  Pane: TJvDockVSPane;
  I: Integer;
  Sheet: TJvDockVSNETTabSheet;

  procedure SetPaneVisible(ChildControl: TControl; VSPaneVisible: Boolean);
  var
    ADockClient: TJvDockClient;
  begin
    if Pane <> nil then
    begin
      Pane.FVisible := VSPaneVisible;
      ADockClient := FindDockClient(Pane.FDockForm);
      if ADockClient <> nil then
        if Pane.FVisible then
        begin
          ADockClient.ParentVisible := False;
          ADockClient.ParentForm.Visible := True;
          ADockClient.MakeShowEvent;
        end
        else
          ADockClient.MakeHideEvent;
    end;
  end;

begin
  inherited CustomLoadZone(Stream, Zone);
  if Zone = nil then
    Exit;
  Stream.Read(TJvDockVSNETZone(Zone).FVSPaneVisible, SizeOf(TJvDockVSNETZone(Zone).VSPaneVisible));
  if DockSite is TJvDockVSPopupPanel then
  begin
    with TJvDockVSPopupPanel(DockSite).VSChannel, TJvDockVSNETZone(Zone) do
    begin
      if ChildControl is TJvDockTabHostForm then
      begin
        for I := 0 to TJvDockTabHostForm(ChildControl).PageControl.Count - 1 do
        begin
          Sheet := TJvDockVSNETTabSheet(TJvDockTabHostForm(ChildControl).PageControl.Pages[I]);
          Pane := FindPane(TWinControl(Sheet.Controls[0]));
          SetPaneVisible(ChildControl, Sheet.OldVisible);
        end;
      end
      else
      begin
        Pane := FindPane(ChildControl);
        SetPaneVisible(ChildControl, VSPaneVisible);
      end;
      ResetPosition;
    end;
  end;
end;

procedure TJvDockVSNETTree.CustomSaveZone(Stream: TStream;
  Zone: TJvDockZone);
var
  Pane: TJvDockVSPane;
begin
  inherited CustomSaveZone(Stream, Zone);
  if DockSite is TJvDockVSPopupPanel then
    with TJvDockVSPopupPanel(DockSite).VSChannel, TJvDockVSNETZone(Zone) do
    begin
      Pane := FindPane(ChildControl);
      if Pane <> nil then
        VSPaneVisible := Pane.FVisible;
    end;
  Stream.Write(TJvDockVSNETZone(Zone).VSPaneVisible, SizeOf(TJvDockVSNETZone(Zone).VSPaneVisible));
end;

procedure TJvDockVSNETTree.DoHideZoneChild(AZone: TJvDockZone);
var
  Form: TForm;
  ADockClient: TJvDockClient;
begin
  if (AZone <> nil) and (AZone.ChildControl <> nil) then
  begin
    if AZone.ChildControl is TJvDockTabHostForm then
    begin
      Form := TJvDockTabHostForm(AZone.ChildControl).GetActiveDockForm;
      if Form <> nil then
      begin
        ADockClient := FindDockClient(Form);
        if (ADockClient <> nil) and not ADockClient.EnableCloseButton then
          Exit
        else
          Form.Close;
      end;
    end
    else
      inherited DoHideZoneChild(AZone);
  end;
end;

procedure TJvDockVSNETTree.DoLButtonDbClk(var Msg: TWMMouse;
  var Zone: TJvDockZone; out HTFlag: Integer);
begin
  if not (DockSite is TJvDockVSPopupPanel) then
    inherited DoLButtonDbClk(Msg, Zone, HTFlag);
end;

function TJvDockVSNETTree.DoLButtonDown(var Msg: TWMMouse;
  var Zone: TJvDockZone; out HTFlag: Integer): Boolean;
begin
  Result := inherited DoLButtonDown(Msg, Zone, HTFlag);
  if Zone <> nil then
  begin
    if HTFlag = HTCLOSE then
      TJvDockVSNETZone(Zone).CloseBtnState := bsDown
    else
    if HTFlag = HTAUTOHIDE then
    begin
      AutoHideZone := TJvDockVSNETZone(Zone);
      AutoHideZone.AutoHideBtnDown := True;
      AutoHideZone.AutoHideBtnState := bsDown;
    end;
  end;
end;

procedure TJvDockVSNETTree.DoLButtonUp(var Msg: TWMMouse;
  var Zone: TJvDockZone; out HTFlag: Integer);
begin
  if CloseButtonZone <> nil then
    TJvDockVSNETZone(CloseButtonZone).CloseBtnState := bsNormal;
  inherited DoLButtonUp(Msg, Zone, HTFlag);
  if AutoHideZone <> nil then
  begin
    AutoHideZone.AutoHideBtnDown := False;
    AutoHideZone.AutoHideBtnState := bsNormal;
    if HTFlag = HTAUTOHIDE then
      if DockSite is TJvDockVSNETPanel then
        TJvDockVSNETPanel(DockSite).DoAutoHideControl(AutoHideZone.ChildControl);
    AutoHideZone := nil;
  end;
end;

procedure TJvDockVSNETTree.DoMouseMove(var Msg: TWMMouse;
  var AZone: TJvDockZone; out HTFlag: Integer);
var
  Zone: TJvDockVSNETZone;
begin
  inherited DoMouseMove(Msg, AZone, HTFlag);
  if AZone <> nil then
  begin
    Zone := TJvDockVSNETZone(AZone);
    if Zone.AutoHideBtnDown then
    begin
      if HTFlag = HTAUTOHIDE then
        Zone.AutoHideBtnState := bsDown
      else
        Zone.AutoHideBtnState := bsUp;
    end
    else
    if (HTFlag = HTAUTOHIDE) and not Zone.CloseBtnDown then
      Zone.AutoHideBtnState := bsUp
    else
      Zone.AutoHideBtnState := bsNormal;

    if Zone.CloseBtnDown then
    begin
      if HTFlag = HTCLOSE then
        Zone.CloseBtnState := bsDown
      else
        Zone.CloseBtnState := bsUp;
    end
    else
    if (HTFlag = HTCLOSE) and not Zone.AutoHideBtnDown then
      Zone.CloseBtnState := bsUp
    else
      Zone.CloseBtnState := bsNormal;
  end;
end;

procedure TJvDockVSNETTree.DoOtherHint(Zone: TJvDockZone; HTFlag: Integer;
  var HintStr: string);
begin
  inherited DoOtherHint(Zone, HTFlag, HintStr);
  if HTFlag = HTAUTOHIDE then
    HintStr := RsDockVSNETDockTreeAutoHideBtnHint;
end;

procedure TJvDockVSNETTree.DrawAutoHideButton(Zone: TJvDockZone; Left, Top: Integer);
var
  AZone: TJvDockVSNETZone;
  ColorArr: array [1..2] of TColor;
  ADockClient: TJvDockClient;
begin
  if Zone <> nil then
  begin
    ADockClient := FindDockClient(Zone.ChildControl);
    if (ADockClient <> nil) and not ADockClient.EnableCloseButton then
      Left := Left + ButtonWidth; // move the auto hide button to the Close Button's location

    AZone := TJvDockVSNETZone(Zone);
    if AZone.AutoHideBtnState <> bsNormal then
    begin
      if AZone.AutoHideBtnState = bsUp then
      begin
        ColorArr[1] := clBlack;
        if GetActiveControl = AZone.ChildControl then
          ColorArr[2] := clBtnFace
        else
          ColorArr[2] := clWhite;
      end
      else
      if AZone.AutoHideBtnState = bsDown then
      begin
        ColorArr[1] := clBtnFace;
        ColorArr[2] := clBlack;
      end;
      Canvas.Pen.Color := ColorArr[1];
      Canvas.MoveTo(Left, Top + ButtonHeight);
      Canvas.LineTo(Left + ButtonWidth, Top + ButtonHeight);
      Canvas.LineTo(Left + ButtonWidth, Top);
      Canvas.Pen.Color := ColorArr[2];
      Canvas.LineTo(Left, Top);
      Canvas.LineTo(Left, Top + ButtonHeight);
    end;

    if AZone.AutoHideBtnState = bsDown then
    begin
      Inc(Left);
      Inc(Top);
    end;

    if AZone.ChildControl = GetActiveControl then
      Canvas.Pen.Color := clWhite
    else
      Canvas.Pen.Color := clBlack;
    if DockSite.Align in [alLeft, alRight, alTop, alBottom] then
    begin
      Canvas.MoveTo(Left + 9, Top + 10);
      Canvas.LineTo(Left + 9, Top + 7);
      Canvas.MoveTo(Left + 6, Top + 7);
      Canvas.LineTo(Left + 13, Top + 7);
      Canvas.MoveTo(Left + 7, Top + 6);
      Canvas.LineTo(Left + 7, Top + 2);
      Canvas.LineTo(Left + 10, Top + 2);
      Canvas.LineTo(Left + 10, Top + 6);
      Canvas.LineTo(Left + 11, Top + 6);
      Canvas.LineTo(Left + 11, Top + 1);
    end
    else
    if DockSite.Align in [alNone] then
    begin
      Canvas.MoveTo(Left + 5, Top + 6);
      Canvas.LineTo(Left + 8, Top + 6);
      Canvas.MoveTo(Left + 8, Top + 3);
      Canvas.LineTo(Left + 8, Top + 10);
      Canvas.MoveTo(Left + 9, Top + 4);
      Canvas.LineTo(Left + 12, Top + 4);
      Canvas.LineTo(Left + 12, Top + 7);
      Canvas.LineTo(Left + 9, Top + 7);
      Canvas.LineTo(Left + 9, Top + 8);
      Canvas.LineTo(Left + 13, Top + 8);
    end;
  end;
end;

procedure TJvDockVSNETTree.DrawCloseButton(Canvas: TCanvas;
  Zone: TJvDockZone; Left, Top: Integer);
var
  DrawRect: TRect;
  AZone: TJvDockVSNETZone;
  ColorArr: array [1..2] of TColor;
  ADockClient: TJvDockClient;
  AForm: TForm;
begin
  if Zone <> nil then
  begin
    ADockClient := FindDockClient(Zone.ChildControl);
    if (ADockClient <> nil) and not ADockClient.EnableCloseButton then
      Exit;
    if Zone.ChildControl is TJvDockTabHostForm then
    begin
      AForm := TJvDockTabHostForm(Zone.ChildControl).GetActiveDockForm;
      if AForm <> nil then
      begin
        ADockClient := FindDockClient(AForm);
        if (ADockClient <> nil) and not ADockClient.EnableCloseButton then
          Exit;
      end;
    end;
    AZone := TJvDockVSNETZone(Zone);

    DrawRect.Left := Left + 6;
    DrawRect.Right := DrawRect.Left + 7;
    DrawRect.Top := Top + 3;
    DrawRect.Bottom := DrawRect.Top + 7;

    if AZone.CloseBtnState <> bsNormal then
    begin
      if AZone.CloseBtnState = bsUp then
      begin
        ColorArr[1] := clBlack;
        if GetActiveControl = AZone.ChildControl then
          ColorArr[2] := clBtnFace
        else
          ColorArr[2] := clWhite;
      end
      else
      if AZone.CloseBtnState = bsDown then
      begin
        ColorArr[1] := clBtnFace;
        ColorArr[2] := clBlack;
      end;
      Canvas.Pen.Color := ColorArr[1];
      Canvas.MoveTo(Left, Top + ButtonHeight);
      Canvas.LineTo(Left + ButtonWidth, Top + ButtonHeight);
      Canvas.LineTo(Left + ButtonWidth, Top);
      Canvas.Pen.Color := ColorArr[2];
      Canvas.LineTo(Left, Top);
      Canvas.LineTo(Left, Top + ButtonHeight);
    end;

    if AZone.CloseBtnState = bsDown then
      OffsetRect(DrawRect, 1, 1);

    if AZone.ChildControl = GetActiveControl then
      Canvas.Pen.Color := clWhite
    else
      Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(DrawRect.Left, DrawRect.Top);
    Canvas.LineTo(DrawRect.Right, DrawRect.Bottom);
    Canvas.MoveTo(DrawRect.Right - 1, DrawRect.Top);
    Canvas.LineTo(DrawRect.Left - 1, DrawRect.Bottom);
  end;
end;

procedure TJvDockVSNETTree.DrawDockGrabber(Control: TControl; const ARect: TRect);
begin
  inherited DrawDockGrabber(Control, ARect);
  if DockSite.Align <> alClient then
  begin
    DrawAutoHideButton(FindControlZone(Control),
      ARect.Right - RightOffset - 2 * ButtonWidth - ButtonSplitter,
      ARect.Top + TopOffset)
  end;
end;

procedure TJvDockVSNETTree.GetCaptionRect(var Rect: TRect);
var
  ADockClient: TJvDockClient;
begin
  if DockSite.Align = alClient then
    inherited GetCaptionRect(Rect)
  else
  begin
    Inc(Rect.Left, 2 + CaptionLeftOffset);
    ADockClient := FindDockClient(DockSite);
    Inc(Rect.Top, 1);
    if (ADockClient = nil) or ADockClient.EnableCloseButton then
      Dec(Rect.Right, 2 * ButtonWidth + ButtonSplitter + CaptionRightOffset - 1)
    else
      Dec(Rect.Right, 1 * ButtonWidth + ButtonSplitter + CaptionRightOffset - 1);
    Dec(Rect.Bottom, 2);
  end;
end;

function TJvDockVSNETTree.GetTopGrabbersHTFlag(const MousePos: TPoint;
  out HTFlag: Integer; Zone: TJvDockZone): TJvDockZone;
var
  ADockClient: TJvDockClient;
begin
  Result := inherited GetTopGrabbersHTFlag(MousePos, HTFlag, Zone);
  if Zone <> nil then
  begin
    ADockClient := FindDockClient(Zone.ChildControl);
    if (ADockClient <> nil) and not ADockClient.EnableCloseButton then
    begin
      if HTFlag = HTCLOSE then
        HTFLAG := HTAUTOHIDE;
      Exit;
    end;
  end;

  if (Zone <> nil) and (DockSite.Align <> alClient) and (HTFlag <> HTCLOSE) then
  begin
    with Zone.ChildControl do
      if PtInRect(Rect(
        Left + Width - 2 * ButtonWidth - RightOffset - ButtonSplitter,
        Top - GrabberSize + TopOffset,
        Left + Width - 1 * ButtonWidth - RightOffset - ButtonSplitter,
        Top - GrabberSize + TopOffset + ButtonHeight), MousePos) then
        HTFlag := HTAUTOHIDE;
  end;
end;

procedure TJvDockVSNETTree.IgnoreZoneInfor(Stream: TMemoryStream);
begin
  inherited IgnoreZoneInfor(Stream);
  Stream.Position := Stream.Position + 1;
end;

procedure TJvDockVSNETTree.PaintDockGrabberRect(Canvas: TCanvas;
  Control: TControl; const ARect: TRect; PaintAlways: Boolean = False);
var
  DrawRect: TRect;
begin
  inherited PaintDockGrabberRect(Canvas, Control, ARect);
  if (GetActiveControl <> Control) or PaintAlways then
  begin
    Canvas.Pen.Color := clGray;
    DrawRect := ARect;
    Inc(DrawRect.Left);
    Canvas.RoundRect(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom, 2, 2);
  end;
end;

//=== { TJvDockVSNETZone } ===================================================

constructor TJvDockVSNETZone.Create(Tree: TJvDockTree);
begin
  inherited Create(Tree);
  FAutoHideBtnState := bsNormal;
  FCloseBtnState := bsNormal;
  FVSPaneVisible := True;
end;

procedure TJvDockVSNETZone.DoCustomSetControlName;
var
  I: Integer;
  Pane: TJvDockVSPane;
  ADockClient: TJvDockClient;
begin
  inherited DoCustomSetControlName;
  if Tree.DockSite is TJvDockVSPopupPanel then
  begin
    with TJvDockVSPopupPanel(Tree.DockSite).VSChannel do
    begin
      AddDockControl(ChildControl);
      if ChildControl is TJvDockTabHostForm then
      begin
        with TJvDockTabHostForm(ChildControl).PageControl do
          for I := 0 to DockClientCount - 1 do
          begin
            Pane := FindPane(TWinControl(DockClients[I]));
            ADockClient := FindDockClient(DockClients[I]);
            if (Pane <> nil) and (ADockClient <> nil) then
              Pane.FWidth := ADockClient.VSPaneWidth;
          end;
      end
      else
      begin
        Pane := FindPane(ChildControl);
        ADockClient := FindDockClient(ChildControl);
        if (Pane <> nil) and (ADockClient <> nil) then
          Pane.FWidth := ADockClient.VSPaneWidth;
      end;
    end;
  end;
end;

procedure TJvDockVSNETZone.SetAutoHideBtnDown(const Value: Boolean);
begin
  FAutoHideBtnDown := Value;
end;

procedure TJvDockVSNETZone.SetAutoHideBtnState(const Value: TJvDockBtnState);
begin
  if FAutoHideBtnState <> Value then
  begin
    FAutoHideBtnState := Value;
    Tree.DockSite.Invalidate;
  end;
end;

procedure TJvDockVSNETZone.SetChildControlVisible(Client: TControl;
  AVisible: Boolean);
begin
  inherited SetChildControlVisible(Client, AVisible);
end;

procedure TJvDockVSNETZone.SetCloseBtnState(const Value: TJvDockBtnState);
begin
  if FCloseBtnState <> Value then
  begin
    FCloseBtnState := Value;
    Tree.DockSite.Invalidate;
  end;
end;

procedure TJvDockVSNETZone.SetVSPaneVisible(const Value: Boolean);
begin
  FVSPaneVisible := Value;
end;

//=== { TJvDockVSPane } ======================================================

constructor TJvDockVSPane.Create(ABlock: TJvDockVSBlock; AForm: TForm;
  AWidth: Integer; AIndex: Integer);
begin
  inherited Create;
  FBlock := ABlock;
  FDockForm := AForm;
  FWidth := AWidth;
  FActive := False;
  FIndex := AIndex;
  FVisible := AForm.Visible;
end;

//=== { TJvDockVSPopupPanel } ================================================

constructor TJvDockVSPopupPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TJvDockVSNETPanel then {new! WPOSTMA added.}
    FDockStyle := TJvDockVSNETPanel(AOwner).DockServer.DockStyle // Must be set before CreateDockManager is called!
  else
    FDockStyle := nil;

  DockSite := True;  {calls CreateDockManager when you do this!}
  if AOwner is TJvDockVSNETPanel then
  begin
    FVSNETDockPanel := TJvDockVSNETPanel(AOwner);
    FVSChannel := FVSNETDockPanel.VSChannel;
    DockServer := FVSNETDockPanel.DockServer;
  end;
  Anchors := [akLeft, akRight, akTop, akBottom];
  BoundsRect := Rect(0, 0, 0, 0);
end;

function TJvDockVSPopupPanel.CreateDockManager: IDockManager;
begin
  if (DockManager = nil) and DockSite and UseDockManager then
  begin
    Assert(Assigned(FDockStyle)); // Should have been set in constructor!
    Result := TJvDockVSNETTree.Create(Self, TJvDockVSNETZone, FDockStyle) as IJvDockManager
  end
  else
    Result := DockManager;
end;

function TJvDockVSPopupPanel.GetVSChannel: TJvDockVSChannel;
begin
  if FVSNETDockPanel <> nil then
    Result := FVSNETDockPanel.VSChannel
  else
    Result := nil;
end;

procedure TJvDockVSPopupPanel.SetParent(AParent: TWinControl);
begin
  // (rom) this is suspicious
  inherited SetParent(AParent);
  if AParent = nil then
    Exit;
end;

procedure TJvDockVSPopupPanel.ShowDockPanel(MakeVisible: Boolean;
  Client: TControl; PanelSizeFrom: TJvDockSetDockPanelSizeFrom);
begin
  if Align <> alNone then
    inherited ShowDockPanel(MakeVisible, Client, PanelSizeFrom);
end;

//=== { TJvDockVSPopupPanelSplitter } ========================================

constructor TJvDockVSPopupPanelSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoSnap := False;
  Align := alNone;
  Height := 0;
  Width := 0;
  FMinSize := 30;
  FResizeStyle := rsPattern;
  FOldSize := -1;
  FSplitWidth := 4;
  Anchors := [akLeft, akRight, akTop, akBottom];
end;

destructor TJvDockVSPopupPanelSplitter.Destroy;
begin
  FBrush.Free;
  inherited Destroy;
end;

procedure TJvDockVSPopupPanelSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0,
    DCX_CACHE or DCX_CLIPSIBLINGS or DCX_LOCKWINDOWUPDATE);
  if ResizeStyle = rsPattern then
  begin
    if FBrush = nil then
    begin
      FBrush := TBrush.Create;
      FBrush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
    end;
    FPrevBrush := SelectObject(FLineDC, FBrush.Handle);
  end;
end;

procedure TJvDockVSPopupPanelSplitter.CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
var
  S: Integer;
begin
  if VSChannelAlign in [alLeft, alRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;
  S := 0;
  case VSChannelAlign of
    alLeft:
      S := FControl.Width + Split;
    alRight:
      S := FControl.Width - Split;
    alTop:
      S := FControl.Height + Split;
    alBottom:
      S := FControl.Height - Split;
  end;
  NewSize := S;
  if S < FMinSize then
    NewSize := FMinSize
  else
  if S > FMaxSize then
    NewSize := FMaxSize;
  if S <> NewSize then
  begin
    if VSChannelAlign in [alRight, alBottom] then
      S := S - NewSize
    else
      S := NewSize - S;
    Inc(Split, S);
  end;
end;

function TJvDockVSPopupPanelSplitter.CanResize(var NewSize: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanResize) then
    FOnCanResize(Self, NewSize, Result);
end;

function TJvDockVSPopupPanelSplitter.DoCanResize(var NewSize: Integer): Boolean;
begin
  Result := CanResize(NewSize);
  if Result and (NewSize <= MinSize) and FAutoSnap then
    NewSize := 0;
end;

procedure TJvDockVSPopupPanelSplitter.DrawLine;
var
  P: TPoint;
begin
  FLineVisible := not FLineVisible;
  P := Point(Left, Top);
  if VSChannelAlign in [alLeft, alRight] then
    P.X := Left + FSplit
  else
    P.Y := Top + FSplit;
  with P do
    PatBlt(FLineDC, X, Y, Width, Height, PATINVERT);
end;

function TJvDockVSPopupPanelSplitter.FindControl: TControl;
begin
  Result := FVSPopupPanel;
end;

procedure TJvDockVSPopupPanelSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
  else
  if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
end;

function TJvDockVSPopupPanelSplitter.GetVSChannelAlign: TAlign;
begin
  Result := alNone;
  if (VSPopupPanel <> nil) and (VSPopupPanel.FVSNETDockPanel <> nil) then
    Result := VSPopupPanel.FVSNETDockPanel.Align;
end;

procedure TJvDockVSPopupPanelSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    FControl := FindControl;
    FDownPos := Point(X, Y);
    if Assigned(FControl) then
    begin
      if VSChannelAlign in [alLeft, alRight] then
      begin
        FMaxSize := Parent.ClientWidth - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alLeft, alRight] then
              Dec(FMaxSize, Width);
        Inc(FMaxSize, FControl.Width);
      end
      else
      begin
        FMaxSize := Parent.ClientHeight - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alTop, alBottom] then
              Dec(FMaxSize, Height);
        Inc(FMaxSize, FControl.Height);
      end;
      UpdateSize(X, Y);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;
          FOldKeyDown := TWinControlAccessProtected(FActiveControl).OnKeyDown;
          TWinControlAccessProtected(FActiveControl).OnKeyDown := FocusKeyDown;
        end;
      if ResizeStyle in [rsLine, rsPattern] then
        DrawLine;
    end;
  end;
end;

procedure TJvDockVSPopupPanelSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewSize, Split: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (ssLeft in Shift) and Assigned(FControl) then
  begin
    CalcSplitSize(X, Y, NewSize, Split);
    if DoCanResize(NewSize) then
    begin
      if ResizeStyle in [rsLine, rsPattern] then
        DrawLine;
      FNewSize := NewSize;
      FSplit := Split;
      if ResizeStyle = rsUpdate then
        UpdateControlSize;
      if ResizeStyle in [rsLine, rsPattern] then
        DrawLine;
    end;
  end;
end;

procedure TJvDockVSPopupPanelSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Assigned(FControl) then
  begin
    if ResizeStyle in [rsLine, rsPattern] then
      DrawLine;
    UpdateControlSize;
    StopSizing;
  end;
end;

procedure TJvDockVSPopupPanelSplitter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = VSPopupPanel) then
    VSPopupPanel := nil;
end;

procedure TJvDockVSPopupPanelSplitter.Paint;
var
  FrameBrush: HBRUSH;
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Color := Color;
  InflateRect(R, 2, 2);
  case VSChannelAlign of
    alLeft:
      Dec(R.Right, 2);
    alRight:
      Inc(R.Left, 3);
    alTop:
      Dec(R.Bottom, 2);
    alBottom:
      Inc(R.Top, 3);
  end;
  DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_ADJUSTRECT);
  R := ClientRect;
  if Beveled then
  begin
    if VSChannelAlign in [alLeft, alRight] then
      InflateRect(R, -1, 2)
    else
      InflateRect(R, 2, -1);
    OffsetRect(R, 1, 1);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnHighlight));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
    OffsetRect(R, -2, -2);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnShadow));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
  end;

  if csDesigning in ComponentState then
    with Canvas do
    begin
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Color := JvDockXorColor;
      Brush.Style := bsClear;
      Rectangle(0, 0, ClientWidth, ClientHeight);
    end;

  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;

procedure TJvDockVSPopupPanelSplitter.ReleaseLineDC;
begin
  if FPrevBrush <> 0 then
    SelectObject(FLineDC, FPrevBrush);
  ReleaseDC(Parent.Handle, FLineDC);
  if FBrush <> nil then
  begin
    FBrush.Free;
    FBrush := nil;
  end;
end;

procedure TJvDockVSPopupPanelSplitter.RequestAlign;
begin
  inherited RequestAlign;
  if VSChannelAlign in [alBottom, alTop] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
end;

procedure TJvDockVSPopupPanelSplitter.SetBeveled(Value: Boolean);
begin
  FBeveled := Value;
  Repaint;
end;

procedure TJvDockVSPopupPanelSplitter.SetSplitWidth(const Value: Integer);
begin
  FSplitWidth := Value;
end;

procedure TJvDockVSPopupPanelSplitter.SetVSPopupPanel(Value: TJvDockVSPopupPanel);
begin
  { Dirty }
  Assert((Value <> nil) and (Value is TJvDockVSPopupPanel));
  FVSPopupPanel := Value;
end;

procedure TJvDockVSPopupPanelSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then
      DrawLine;
    FControl := nil;
    ReleaseLineDC;
    if Assigned(FActiveControl) then
    begin
      TWinControlAccessProtected(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;

procedure TJvDockVSPopupPanelSplitter.UpdateControlSize;
begin
  if FNewSize <> FOldSize then
  begin
    case VSChannelAlign of
      alLeft:
        begin
          FControl.Width := FNewSize;
          Left := FControl.Left + FNewSize;
        end;
      alTop:
        begin
          FControl.Height := FNewSize;
          Top := FControl.Top + FNewSize;
        end;
      alRight:
        begin
          Parent.DisableAlign;
          try
            FControl.Left := FControl.Left + (FControl.Width - FNewSize);
            FControl.Width := FNewSize;
            Left := FControl.Left - Width;
          finally
            Parent.EnableAlign;
          end;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
            FControl.Top := FControl.Top + (FControl.Height - FNewSize);
            FControl.Height := FNewSize;
            Top := FControl.Top - Height;
          finally
            Parent.EnableAlign;
          end;
        end;
    end;
    FVSPopupPanel.VSChannel.ResetActivePaneWidth;
    Update;
    if Assigned(FOnMoved) then
      FOnMoved(Self);
    FOldSize := FNewSize;
  end;
end;

procedure TJvDockVSPopupPanelSplitter.UpdateSize(X, Y: Integer);
begin
  CalcSplitSize(X, Y, FNewSize, FSplit);
end;

//=== { TPopupPanelAnimate } =================================================

constructor TPopupPanelAnimate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Interval := TJvDockVSNetStyle.GetAnimationInterval;
  Enabled := False;
  FMaxWidth := 0;
  FCurrentWidth := 0;
  OnTimer := OnCustomTimer;
  FState := asPopup;
end;

procedure TPopupPanelAnimate.HideForm(AVSChannel: TJvDockVSChannel; MaxWidth: Integer);
begin
  if FVSChannel <> nil then
    Exit;
  FVSChannel := AVSChannel;
  Enabled := (FVSChannel <> nil) and (FVSChannel.ActiveDockForm <> nil);
  if FVSChannel <> nil then
  begin
    FMaxWidth := MaxWidth;
    FCurrentWidth := 0;
    FState := asHide;
  end;
end;

procedure TPopupPanelAnimate.OnCustomTimer(Sender: TObject);
begin
  // ??? no handler?
end;

procedure TPopupPanelAnimate.PopupForm(AVSChannel: TJvDockVSChannel; MaxWidth: Integer);
begin
  { Currently busy with animating? }
  if (FCurrentWidth > 0) and (FVSChannel <> nil) then
    { Dangerous, not in try..finally }
    FVSChannel.Parent.EnableAlign;
  FVSChannel := AVSChannel;
  Enabled := FVSChannel <> nil;
  if FVSChannel <> nil then
  begin
    FMaxWidth := MaxWidth;
    FCurrentWidth := 0;
    FState := asPopup;
  end;
end;

procedure TPopupPanelAnimate.Timer;
var
  SuitableWidth: Integer;

  procedure SetControlBringToFront(Control: TWinControl; Align: TAlign);
  var
    I: Integer;
  begin
    for I := Control.ControlCount - 1 downto 0 do
      if Control.Controls[I].Visible and (Control.Controls[I].Align = Align) and
        not (Control.Controls[I] is TJvDockVSChannel) and
        not (Control.Controls[I] is TJvDockPanel) and
        not (Control.Controls[I] is TJvDockSplitter) then
        Control.Controls[I].BringToFront;
  end;

begin
  inherited Timer;
  if FVSChannel <> nil then
  begin
    SuitableWidth := Min(FCurrentWidth, FMaxWidth);
    with FVSChannel do
    begin
      if FCurrentWidth = 0 then
      begin
        { Dangerous, not in try..finally }
        Parent.DisableAlign;
        VSPopupPanel.BringToFront;
        VSPopupPanelSplitter.BringToFront;
        SetControlBringToFront(Parent, Align);
        BringToFront;
      end;
      case Align of
        alLeft:
          begin
            if FState = asPopup then
            begin
              if FCurrentWidth = 0 then
              begin
                VSPopupPanel.Width := FMaxWidth;
                VSPopupPanel.Top := Top;
                VSPopupPanel.Height := Height;
                VSPopupPanelSplitter.Top := Top;
                VSPopupPanelSplitter.Height := Height;
                VSPopupPanelSplitter.Width := VSPopupPanelSplitter.SplitWidth;
              end;
              VSPopupPanel.Left := Left + Width + SuitableWidth - VSPopupPanel.Width;
            end
            else
            if FState = asHide then
              VSPopupPanel.Left := Left - FCurrentWidth;

            VSPopupPanelSplitter.Left := VSPopupPanel.Left + VSPopupPanel.Width;
          end;
        alRight:
          begin
            if FState = asPopup then
            begin
              if FCurrentWidth = 0 then
              begin
                VSPopupPanel.Width := FMaxWidth;
                VSPopupPanel.Top := Top;
                VSPopupPanel.Height := Height;
                VSPopupPanelSplitter.Top := Top;
                VSPopupPanelSplitter.Height := Height;
                VSPopupPanelSplitter.Width := VSPopupPanelSplitter.SplitWidth;
              end;
              VSPopupPanel.Left := Left - SuitableWidth;
            end
            else
            if FState = asHide then
              VSPopupPanel.Left := Left - VSPopupPanel.Width + FCurrentWidth;

            VSPopupPanelSplitter.Left := VSPopupPanel.Left - VSPopupPanelSplitter.SplitWidth;
          end;
        alTop:
          begin
            if FState = asPopup then
            begin
              if FCurrentWidth = 0 then
              begin
                VSPopupPanel.Left := Left;
                VSPopupPanel.Height := FMaxWidth;
                VSPopupPanel.Width := Width;
                VSPopupPanelSplitter.Left := Left;
                VSPopupPanelSplitter.Width := Width;
                VSPopupPanelSplitter.Height := VSPopupPanelSplitter.SplitWidth;
              end;
              VSPopupPanel.Top := Top + Height + SuitableWidth - VSPopupPanel.Height;
            end
            else
            if FState = asHide then
              VSPopupPanel.Top := Top - FCurrentWidth;

            VSPopupPanelSplitter.Top := VSPopupPanel.Top + VSPopupPanel.Height;
          end;
        alBottom:
          begin
            if FState = asPopup then
            begin
              if FCurrentWidth = 0 then
              begin
                VSPopupPanel.Left := Left;
                VSPopupPanel.Width := Width;
                VSPopupPanel.Height := FMaxWidth;
                VSPopupPanelSplitter.Left := Left;
                VSPopupPanelSplitter.Width := Width;
                VSPopupPanelSplitter.Height := VSPopupPanelSplitter.SplitWidth;
              end;
              VSPopupPanel.Top := Top - SuitableWidth;
            end
            else
            if FState = asHide then
              VSPopupPanel.Top := Top - VSPopupPanel.Height + FCurrentWidth;
            VSPopupPanelSplitter.Top := VSPopupPanel.Top - VSPopupPanelSplitter.SplitWidth;
          end;
      end;
      VSPopupPanel.Visible := True;
      VSPopupPanelSplitter.Visible := True;
    end;
    if FCurrentWidth >= FMaxWidth then
    begin
      { Dangerous, not in try..finally }
      FVSChannel.Parent.EnableAlign;
      Enabled := False;
      if FState = asHide then
        FVSChannel.HidePopupPanel(FVSChannel.FActivePane)
      else
      begin
        if FVSChannel.ActiveDockForm <> nil then
          if FVSChannel.ActiveDockForm.CanFocus then
            FVSChannel.ActiveDockForm.SetFocus;
      end;
      FVSChannel := nil;
      FCurrentWidth := 0;
      FMaxWidth := 0;
    end
    else
      Inc(FCurrentWidth, TJvDockVSNetStyle.GetAnimationMoveWidth);
  end;
end;

initialization
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}

finalization
  GlobalPopupPanelAnimate.Free;
  GlobalPopupPanelAnimate := nil;
  { (ahuser) not used:
  GlobalApplicationEvents.Free;
  GlobalApplicationEvents := nil; }
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}

end.

