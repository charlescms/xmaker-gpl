(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.005                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit AppInsp;

{$IFDEF VER120}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
{$ENDIF}
{$IFDEF VER170}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}
{$IFDEF VER180}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Dialogs,
  {$IFDEF VERSION4}
  ActnList,
  {$ENDIF}
  PropList, InspCtrl, CompInsp;

type

  TApplicationInterface = class(TComponent)
  private
    function GetHelpFile: string;
    procedure SetHelpFile(const Value: string);
    function GetHintColor: TColor;
    procedure SetHintColor(const Value: TColor);
    function GetHintHidePause: Integer;
    procedure SetHintHidePause(const Value: Integer);
    function GetHintPause: Integer;
    procedure SetHintPause(const Value: Integer);
    function GetHintShortPause: Integer;
    procedure SetHintShortPause(const Value: Integer);
    function GetIcon: TIcon;
    procedure SetIcon(const Value: TIcon);
    function GetShowHint: Boolean;
    procedure SetShowHint(const Value: Boolean);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetUpdateFormatSettings: Boolean;
    procedure SetUpdateFormatSettings(const Value: Boolean);
    function GetUpdateMetricSettings: Boolean;
    procedure SetUpdateMetricSettings(const Value: Boolean);
    function GetOnActivate: TNotifyEvent;
    procedure SetOnActivate(const Value: TNotifyEvent);
    function GetOnDeactivate: TNotifyEvent;
    procedure SetOnDeactivate(const Value: TNotifyEvent);
    function GetOnException: TExceptionEvent;
    procedure SetOnException(const Value: TExceptionEvent);
    function GetOnHelp: THelpEvent;
    procedure SetOnHelp(const Value: THelpEvent);
    function GetOnHint: TNotifyEvent;
    procedure SetOnHint(const Value: TNotifyEvent);
    function GetOnIdle: TIdleEvent;
    procedure SetOnIdle(const Value: TIdleEvent);
    function GetOnMessage: TMessageEvent;
    procedure SetOnMessage(const Value: TMessageEvent);
    function GetOnMinimize: TNotifyEvent;
    procedure SetOnMinimize(const Value: TNotifyEvent);
    function GetOnRestore: TNotifyEvent;
    procedure SetOnRestore(const Value: TNotifyEvent);
    function GetOnShowHint: TShowHintEvent;
    procedure SetOnShowHint(const Value: TShowHintEvent);
    {$IFDEF VERSION4}
    function GetBiDiMode: TBiDiMode;
    procedure SetBiDiMode(const Value: TBiDiMode);
    function GetHintShortCuts: Boolean;
    procedure SetHintShortCuts(const Value: Boolean);
    function GetOnActionExecute: TActionEvent;
    procedure SetOnActionExecute(const Value: TActionEvent);
    function GetOnActionUpdate: TActionEvent;
    procedure SetOnActionUpdate(const Value: TActionEvent);
    function GetOnShortCut: TShortCutEvent;
    procedure SetOnShortCut(const Value: TShortCutEvent);
    {$ENDIF}
    {$IFDEF VERSION5}
    function GetBiDiKeyboard: string;
    procedure SetBiDiKeyboard(const Value: string);
    function GetNonBiDiKeyboard: string;
    procedure SetNonBiDiKeyboard(const Value: string);
    {$ENDIF}
    {$IFDEF VERSION6}
    function GetAutoDragDocking: Boolean;
    procedure SetAutoDragDocking(const Value: Boolean);
    function GetOnSettingChange: TSettingChangeEvent;
    procedure SetOnSettingChange(const Value: TSettingChangeEvent);
    {$ENDIF}
    {$IFDEF VERSION7}
    function GetOnModalBegin: TNotifyEvent;
    procedure SetOnModalBegin(const Value: TNotifyEvent);
    function GetOnModalEnd: TNotifyEvent;
    procedure SetOnModalEnd(const Value: TNotifyEvent);
    {$ENDIF}
  published
    property HelpFile: string read GetHelpFile write SetHelpFile;
    property HintColor: TColor read GetHintColor write SetHintColor;
    property HintHidePause: Integer read GetHintHidePause write SetHintHidePause;
    property HintPause: Integer read GetHintPause write SetHintPause;
    property HintShortPause: Integer read GetHintShortPause write SetHintShortPause;
    property Icon: TIcon read GetIcon write SetIcon;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property Title: string read GetTitle write SetTitle;
    property UpdateFormatSettings: Boolean read GetUpdateFormatSettings write SetUpdateFormatSettings;
    property UpdateMetricSettings: Boolean read GetUpdateMetricSettings write SetUpdateMetricSettings;
    property OnActivate: TNotifyEvent read GetOnActivate write SetOnActivate;
    property OnDeactivate: TNotifyEvent read GetOnDeactivate write SetOnDeactivate;
    property OnException: TExceptionEvent read GetOnException write SetOnException;
    property OnHelp: THelpEvent read GetOnHelp write SetOnHelp;
    property OnHint: TNotifyEvent read GetOnHint write SetOnHint;
    property OnIdle: TIdleEvent read GetOnIdle write SetOnIdle;
    property OnMessage: TMessageEvent read GetOnMessage write SetOnMessage;
    property OnMinimize: TNotifyEvent read GetOnMinimize write SetOnMinimize;
    property OnRestore: TNotifyEvent read GetOnRestore write SetOnRestore;
    property OnShowHint: TShowHintEvent read GetOnShowHint write SetOnShowHint;
    {$IFDEF VERSION4}
    property BiDiMode: TBiDiMode read GetBiDiMode write SetBiDiMode;
    property HintShortCuts: Boolean read GetHintShortCuts write SetHintShortCuts;
    property OnActionExecute: TActionEvent read GetOnActionExecute write SetOnActionExecute;
    property OnActionUpdate: TActionEvent read GetOnActionUpdate write SetOnActionUpdate;
    property OnShortCut: TShortCutEvent read GetOnShortCut write SetOnShortCut;
    {$ENDIF}
    {$IFDEF VERSION5}
    property BiDiKeyboard: string read GetBiDiKeyboard write SetBiDiKeyboard;
    property NonBiDiKeyboard: string read GetNonBiDiKeyboard write SetNonBiDiKeyboard;
    {$ENDIF}
    {$IFDEF VERSION6}
    property AutoDragDocking: Boolean read GetAutoDragDocking write SetAutoDragDocking;
    property OnSettingChange: TSettingChangeEvent read GetOnSettingChange write SetOnSettingChange;
    {$ENDIF}
    {$IFDEF VERSION7}
    property OnModalBegin: TNotifyEvent read GetOnModalBegin write SetOnModalBegin;
    property OnModalEnd: TNotifyEvent read GetOnModalEnd write SetOnModalEnd;
    {$ENDIF}
  end;

  TCustomApplicationInspector = class(TCustomComponentInspector)
  private
    FApplicationInterface: TApplicationInterface;
  protected
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
  public
    procedure CreateWnd; override;
  end;

  TApplicationInspector = class(TCustomApplicationInspector)
  published
    {$IFDEF VERSION4}
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
    property CheckBoxes;
    property PaintStyle;
    property Splitter;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property Root;
    property Mode;
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
    property OnGetEditorClass;
    property OnFilter;
    property OnCompare;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
  end;

implementation

function TApplicationInterface.GetHelpFile: string;
begin
  Result:=Application.HelpFile;
end;

procedure TApplicationInterface.SetHelpFile(const Value: string);
begin
  Application.HelpFile:=Value;
end;

function TApplicationInterface.GetHintColor: TColor;
begin
  Result:=Application.HintColor;
end;

procedure TApplicationInterface.SetHintColor(const Value: TColor);
begin
  Application.HintColor:=Value;
end;

function TApplicationInterface.GetHintPause: Integer;
begin
  Result:=Application.HintPause;
end;

procedure TApplicationInterface.SetHintPause(const Value: Integer);
begin
  Application.HintPause:=Value;
end;

function TApplicationInterface.GetHintHidePause: Integer;
begin
  Result:=Application.HintHidePause;
end;

procedure TApplicationInterface.SetHintHidePause(const Value: Integer);
begin
  Application.HintHidePause:=Value;
end;

function TApplicationInterface.GetHintShortPause: Integer;
begin
  Result:=Application.HintShortPause;
end;

procedure TApplicationInterface.SetHintShortPause(const Value: Integer);
begin
  Application.HintShortPause:=Value;
end;

function TApplicationInterface.GetIcon: TIcon;
begin
  Result:=Application.Icon;
end;

procedure TApplicationInterface.SetIcon(const Value: TIcon);
begin
  Application.Icon:=Value;
end;

function TApplicationInterface.GetShowHint: Boolean;
begin
  Result:=Application.ShowHint;
end;

procedure TApplicationInterface.SetShowHint(const Value: Boolean);
begin
  Application.ShowHint:=Value;
end;

function TApplicationInterface.GetTitle: string;
begin
  Result:=Application.Title;
end;

procedure TApplicationInterface.SetTitle(const Value: string);
begin
  Application.Title:=Value;
end;

function TApplicationInterface.GetUpdateFormatSettings: Boolean;
begin
  Result:=Application.UpdateFormatSettings;
end;

procedure TApplicationInterface.SetUpdateFormatSettings(
  const Value: Boolean);
begin
  Application.UpdateFormatSettings:=Value;
end;

function TApplicationInterface.GetUpdateMetricSettings: Boolean;
begin
  Result:=Application.UpdateMetricSettings;
end;

procedure TApplicationInterface.SetUpdateMetricSettings(
  const Value: Boolean);
begin
  Application.UpdateMetricSettings:=Value;
end;

function TApplicationInterface.GetOnActivate: TNotifyEvent;
begin
  Result:=Application.OnActivate;
end;

procedure TApplicationInterface.SetOnActivate(const Value: TNotifyEvent);
begin
  Application.OnActivate:=Value;
end;

function TApplicationInterface.GetOnDeactivate: TNotifyEvent;
begin
  Result:=Application.OnActivate;
end;

procedure TApplicationInterface.SetOnDeactivate(const Value: TNotifyEvent);
begin
  Application.OnActivate:=Value;
end;

function TApplicationInterface.GetOnException: TExceptionEvent;
begin
  Result:=Application.OnException;
end;

procedure TApplicationInterface.SetOnException(
  const Value: TExceptionEvent);
begin
  Application.OnException:=Value;
end;

function TApplicationInterface.GetOnHelp: THelpEvent;
begin
  Result:=Application.OnHelp;
end;

procedure TApplicationInterface.SetOnHelp(const Value: THelpEvent);
begin
  Application.OnHelp:=Value;
end;

function TApplicationInterface.GetOnHint: TNotifyEvent;
begin
  Result:=Application.OnHint;
end;

procedure TApplicationInterface.SetOnHint(const Value: TNotifyEvent);
begin
  Application.OnHint:=Value;
end;

function TApplicationInterface.GetOnIdle: TIdleEvent;
begin
  Result:=Application.OnIdle;
end;

procedure TApplicationInterface.SetOnIdle(const Value: TIdleEvent);
begin
  Application.OnIdle:=Value;
end;

function TApplicationInterface.GetOnMessage: TMessageEvent;
begin
  Result:=Application.OnMessage;
end;

procedure TApplicationInterface.SetOnMessage(const Value: TMessageEvent);
begin
  Application.OnMessage:=Value;
end;

function TApplicationInterface.GetOnMinimize: TNotifyEvent;
begin
  Result:=Application.OnMinimize;
end;

procedure TApplicationInterface.SetOnMinimize(const Value: TNotifyEvent);
begin
  Application.OnMinimize:=Value;
end;

function TApplicationInterface.GetOnRestore: TNotifyEvent;
begin
  Result:=Application.OnRestore;
end;

procedure TApplicationInterface.SetOnRestore(const Value: TNotifyEvent);
begin
  Application.OnRestore:=Value;
end;

function TApplicationInterface.GetOnShowHint: TShowHintEvent;
begin
  Result:=Application.OnShowHint;
end;

procedure TApplicationInterface.SetOnShowHint(const Value: TShowHintEvent);
begin
  Application.OnShowHint:=Value;
end;

{$IFDEF VERSION4}

function TApplicationInterface.GetBiDiMode: TBiDiMode;
begin
  Result:=Application.BiDiMode;
end;

procedure TApplicationInterface.SetBiDiMode(const Value: TBiDiMode);
begin
  Application.BiDiMode:=Value;
end;

function TApplicationInterface.GetHintShortCuts: Boolean;
begin
  Result:=Application.HintShortCuts;
end;

procedure TApplicationInterface.SetHintShortCuts(const Value: Boolean);
begin
  Application.HintShortCuts:=Value;
end;

function TApplicationInterface.GetOnActionExecute: TActionEvent;
begin
  Result:=Application.OnActionExecute;
end;

procedure TApplicationInterface.SetOnActionExecute(
  const Value: TActionEvent);
begin
  Application.OnActionExecute:=Value;
end;

function TApplicationInterface.GetOnActionUpdate: TActionEvent;
begin
  Result:=Application.OnActionUpdate;
end;

procedure TApplicationInterface.SetOnActionUpdate(const Value: TActionEvent);
begin
  Application.OnActionUpdate:=Value;
end;

function TApplicationInterface.GetOnShortCut: TShortCutEvent;
begin
  Result:=Application.OnShortCut;
end;

procedure TApplicationInterface.SetOnShortCut(const Value: TShortCutEvent);
begin
  Application.OnShortCut:=Value;
end;

{$ENDIF}

{$IFDEF VERSION5}

function TApplicationInterface.GetBiDiKeyboard: string;
begin
  Result:=Application.BiDiKeyboard;
end;

procedure TApplicationInterface.SetBiDiKeyboard(const Value: string);
begin
  Application.BiDiKeyboard:=Value;
end;

function TApplicationInterface.GetNonBiDiKeyboard: string;
begin
  Result:=Application.NonBiDiKeyboard;
end;

procedure TApplicationInterface.SetNonBiDiKeyboard(const Value: string);
begin
  Application.NonBiDiKeyboard:=Value;
end;

{$ENDIF}

{$IFDEF VERSION6}

function TApplicationInterface.GetAutoDragDocking: Boolean;
begin
  Result:=Application.AutoDragDocking;
end;

procedure TApplicationInterface.SetAutoDragDocking(const Value: Boolean);
begin
  Application.AutoDragDocking:=Value;
end;

function TApplicationInterface.GetOnSettingChange: TSettingChangeEvent;
begin
  Result:=Application.OnSettingChange;
end;

procedure TApplicationInterface.SetOnSettingChange(const Value: TSettingChangeEvent);
begin
  Application.OnSettingChange:=Value;
end;

{$ENDIF}

{$IFDEF VERSION7}

function TApplicationInterface.GetOnModalBegin: TNotifyEvent;
begin
  Result:=Application.OnModalBegin;
end;

procedure TApplicationInterface.SetOnModalBegin(const Value: TNotifyEvent);
begin
  Application.OnModalBegin:=Value;
end;

function TApplicationInterface.GetOnModalEnd: TNotifyEvent;
begin
  Result:=Application.OnModalEnd;
end;

procedure TApplicationInterface.SetOnModalEnd(const Value: TNotifyEvent);
begin
  Application.OnModalEnd:=Value;
end;

{$ENDIF}

function TCustomApplicationInspector.GetButtonType(TheIndex: Integer): TButtonType;
var
  P: TProperty;
begin
  P:=Properties[TheIndex];
  if Assigned(P) and (P.Name='HelpFile') then Result:=btDialog
  else Result:=inherited GetButtonType(TheIndex);
end;

function TCustomApplicationInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
var
  P: TProperty;
begin
  P:=Properties[TheIndex];
  Result:=inherited GetEnableExternalEditor(TheIndex) or Assigned(P) and (P.Name='HelpFile');
end;

function TCustomApplicationInspector.CallEditor(TheIndex: Integer): Boolean;
var
  P: TProperty;
begin
  P:=Properties[TheIndex];
  if Assigned(P) and (P.Name='HelpFile') then
    with TOpenDialog.Create(nil) do
    try
      FileName:=Properties[TheIndex].AsString;
      DefaultExt:='hlp';
      Filter:='Help Files (*.hlp)|*.hlp';
      Result:=Execute;
      if Result then Properties[TheIndex].AsString:=FileName;
    finally
      Free;
    end
  else Result:=inherited CallEditor(TheIndex);
end;

procedure TCustomApplicationInspector.CreateWnd;
begin
  inherited;
  FApplicationInterface:=TApplicationInterface.Create(Self);
  Instance:=FApplicationInterface;
end;

end.
