{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudickar att oratool dott de]
All Rights Reserved.

Contributor(s):
Jens Fudickar [jens dott fudickar att oratool dott de]

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvParameterList.pas,v 1.59 2005/03/02 00:51:31 jfudickar Exp $

unit JvParameterList;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes, SysUtils, Windows, Messages,
  StdCtrls, ExtCtrls, Graphics, Forms, Controls, Dialogs, ComCtrls,
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  JvConsts, JvTypes, JvDynControlEngine, JvDynControlEngineIntf, JvDSADialogs,
  JvComponent, JvPanel, JvPropertyStore, JvAppStorage, JvAppStorageSelectList;

type
  TJvParameterList = class;
  TJvParameterListPropertyStore = class;
  TJvParameterPropertyValues = class;
  TJvParameterListSelectList = class;
  TJvBaseParameter = class;

  TJvParameterListEvent = procedure(const ParameterList: TJvParameterList; const Parameter: TJvBaseParameter) of object;

  TJvParameterListEnableDisableReason = class(TPersistent)
  private
    FRemoteParameterName: string;
    FValue: Variant;
    FIsEmpty: Boolean;
    FIsNotEmpty: Boolean;
  protected
    procedure SetAsString(Value: string);
    function GetAsString: string;
    procedure SetAsDouble(Value: Double);
    function GetAsDouble: Double;
    procedure SetAsInteger(Value: Integer);
    function GetAsInteger: Integer;
    procedure SetAsBoolean(Value: Boolean);
    function GetAsBoolean: Boolean;
    procedure SetAsDate(Value: TDateTime);
    function GetAsDate: TDateTime;
    procedure SetAsVariant(Value: Variant);
    function GetAsVariant: Variant;
    procedure SetIsEmpty(Value: Boolean);
    procedure SetIsNotEmpty(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    property AsString: string read GetAsString write SetAsString;
    property AsDouble: Double read GetAsDouble write SetAsDouble;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDate: TDateTime read GetAsDate write SetAsDate;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property IsEmpty: Boolean read FIsEmpty write SetIsEmpty;
    property IsNotEmpty: Boolean read FIsNotEmpty write SetIsNotEmpty;
    property RemoteParameterName: string read FRemoteParameterName write FRemoteParameterName;
  end;

  TJvParameterListEnableDisableReasonList = class(TStringList)
  public
    procedure Clear; override;
    procedure AddReasonVariant(const RemoteParameterName: string; Value: Variant);
    procedure AddReason(const RemoteParameterName: string; Value: Boolean); overload;
    procedure AddReason(const RemoteParameterName: string; Value: Integer); overload;
    procedure AddReason(const RemoteParameterName: string; Value: Double); overload;
    procedure AddReason(const RemoteParameterName: string; const Value: string); overload;
    procedure AddReason(const RemoteParameterName: string; Value: TDateTime); overload;
    procedure AddReasonIsEmpty(const RemoteParameterName: string);
    procedure AddReasonIsNotEmpty(const RemoteParameterName: string);
  end;

  TJvParameterPropertyValue = class(TPersistent)
  private
    FPropertyName: string;
    FPropertyValue: Variant;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property PropertyValue: Variant read FPropertyValue write FPropertyValue;
  end;

  TJvParameterPropertyValues = class(TStringList)
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; override;
    procedure AddValue(const AName: string; AValue: Variant);
  end;

  TJvBaseParameter = class(TJvComponent)
  private
    FCaption: string;
    FValue: Variant;
    FWidth: Integer;
    FHeight: Integer;
    FSearchName: string;
    FRequired: Boolean;
    FReadOnly: Boolean;
    FStoreValueToAppStorage: Boolean;
    FStoreValueCrypted: Boolean;
    FParentParameterName: string;
    FTabOrder: Integer;
    FParameterList: TJvParameterList;
    FWinControl: TWinControl;
    FJvDynControl: IJvDynControl;
    FJvDynControlData: IJvDynControlData;
    FHint: string;
    FTag: Integer;
    FColor: TColor;
    FEnabled: Boolean;
    FHelpContext: THelpContext;
    FDisableReasons: TJvParameterListEnableDisableReasonList;
    FEnableReasons: TJvParameterListEnableDisableReasonList;
    FVisible: Boolean;
    FOnEnterParameter: TJvParameterListEvent;
    FOnExitParameter: TJvParameterListEvent;
  protected
    procedure SetAsString(const Value: string); virtual;
    function GetAsString: string; virtual;
    procedure SetAsDouble(Value: Double); virtual;
    function GetAsDouble: Double; virtual;
    procedure SetAsInteger(Value: Integer); virtual;
    function GetAsInteger: Integer; virtual;
    procedure SetAsBoolean(Value: Boolean); virtual;
    function GetAsBoolean: Boolean; virtual;
    procedure SetAsDate(Value: TDateTime); virtual;
    function GetAsDate: TDateTime; virtual;
    procedure SetAsVariant(Value: Variant); virtual;
    function GetAsVariant: Variant; virtual;
    function GetParameterNameExt: string; virtual;
    function GetParameterNameBase: string;
    function GetParameterName: string;
    procedure SetWinControl(Value: TWinControl);
    function GetWinControl: TWinControl;
    function GetWinControlData: Variant; virtual;
    procedure SetWinControlData(Value: Variant); virtual;
    procedure SetSearchName(Value: string);

    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetVisible(Value: Boolean); virtual;
    function  GetHeight: Integer; virtual;
    procedure SetHeight(Value: Integer); virtual;
    function  GetWidth: Integer; virtual;
    procedure SetWidth(Value: Integer); virtual;
    procedure SetTabOrder(Value: Integer); virtual;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetDynControlEngine: TJvDynControlEngine;
    property Color: TColor read FColor write FColor;
    property JvDynControl: IJvDynControl read FJvDynControl;
    property JvDynControlData: IJvDynControlData read FJvDynControlData;
    property Value: Variant read FValue write FValue;
    property WinControl: TWinControl read GetWinControl write SetWinControl;
    procedure SetWinControlProperties; virtual;
  public
    constructor Create(AParameterList: TJvParameterList); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Validate(var AData: Variant): Boolean; virtual;
    procedure CreateWinControlOnParent(ParameterParent: TWinControl); virtual; abstract;
    property WinControlData: Variant read GetWinControlData write SetWinControlData;
    procedure GetData; virtual;
    procedure SetData; virtual;
    property ParameterList: TJvParameterList read FParameterList write FParameterList;
    property DynControlEngine: TJvDynControlEngine read GetDynControlEngine;
  published
    {the next properties implements the possibilities to read and write the data }
    property AsString: string read GetAsString write SetAsString;
    property AsDouble: Double read GetAsDouble write SetAsDouble;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDate: TDateTime read GetAsDate write SetAsDate;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    {this name is used to identify the parameter in the parameterlist,
     this value must be defined before inserting into the parameterlist }
    property SearchName: string read FSearchName write SetSearchName;
    {should this value be saved by the parameterlist }
    property StoreValueToAppStorage: Boolean read FStoreValueToAppStorage write FStoreValueToAppStorage;
    {should this value be crypted before save }
    property StoreValueCrypted: Boolean read FStoreValueCrypted write FStoreValueCrypted;
    {the searchname of the parentparameter. The parameter must be a
     descent of TJvGroupBoxParameter, TJvPanelParameter or TTabControlParamter. If the
     parent parameter is a TJvTabControlParameter, then the ParentParameterName must be
     "searchname.tabname" of the TJvTabControlParameter}
    property ParentParameterName: string read FParentParameterName write FParentParameterName;
    {Is the value required, will be checked in the validate function}
    property Required: Boolean read FRequired write FRequired;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Visible: Boolean read FVisible write SetVisible;
    {the next properties find their expressions in the same properties of TWinControl }
    property Caption: string read FCaption write FCaption;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property Hint: string read FHint write FHint;
    property Tag: Integer read FTag write FTag;
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property TabOrder: Integer read FTabOrder write SetTabOrder;
    property DisableReasons: TJvParameterListEnableDisableReasonList read FDisableReasons;
    property EnableReasons: TJvParameterListEnableDisableReasonList read FEnableReasons;
    property OnEnterParameter: TJvParameterListEvent read FOnEnterParameter write FOnEnterParameter;
    property OnExitParameter: TJvParameterListEvent read FOnExitParameter write FOnExitParameter;
  end;

  TJvParameterListMessages = class(TPersistent)
  private
    FCaption: string;
    FOkButton: string;
    FCancelButton: string;
    FHistoryLoadButton: string;
    FHistorySaveButton: string;
    FHistoryClearButton: string;
    FHistoryLoadCaption: string;
    FHistorySaveCaption: string;
    FHistoryClearCaption: string;
  public
    constructor Create;
  published
    property Caption: string read FCaption write FCaption;
    property OkButton: string read FOkButton write FOkButton;
    property CancelButton: string read FCancelButton write FCancelButton;
    property HistoryLoadButton: string read FHistoryLoadButton write FHistoryLoadButton;
    property HistorySaveButton: string read FHistorySaveButton write FHistorySaveButton;
    property HistoryClearButton: string read FHistoryClearButton write FHistoryClearButton;
    property HistoryLoadCaption: string read FHistoryLoadCaption write FHistoryLoadCaption;
    property HistorySaveCaption: string read FHistorySaveCaption write FHistorySaveCaption;
    property HistoryClearCaption: string read FHistoryClearCaption write FHistoryClearCaption;
  end;

  TJvParameterList = class(TJvComponent)
  private
    FMessages: TJvParameterListMessages;
    FIntParameterList: TStringList;
    FArrangeSettings: TJvArrangeSettings;
    FDynControlEngine: TJvDynControlEngine;
    FParameterDialog: TCustomForm;
    FWidth: Integer;
    FHeight: Integer;
    FMaxWidth: Integer;
    FMaxHeight: Integer;
    FDefaultParameterHeight: Integer;
    FDefaultParameterWidth: Integer;
    FDefaultParameterLabelWidth: Integer;
    FOkButtonVisible: Boolean;
    FCancelButtonVisible: Boolean;
    FParameterListPropertyStore: TJvParameterListPropertyStore;
    FHistoryEnabled: Boolean;
    FLastHistoryName: string;
    FParameterListSelectList: TJvParameterListSelectList;
    FOkButtonDisableReasons: TJvParameterListEnableDisableReasonList;
    FOkButtonEnableReasons: TJvParameterListEnableDisableReasonList;
    function GetIntParameterList: TStrings;
    function AddObject(const S: string; AObject: TObject): Integer;
    procedure OnOkButtonClick(Sender: TObject);
    procedure OnCancelButtonClick(Sender: TObject);
    procedure ShowParameterDialogThread;
  protected
    OkButton: TButton;
    ArrangePanel: TJvPanel;
    ScrollBox: TScrollBox;
    RightPanel: TJvPanel;
    MainPanel: TWinControl;
    HistoryPanel: TWinControl;
    BottomPanel: TWinControl;
    ButtonPanel: TWinControl;
    OrgButtonPanelWidth,
    OrgHistoryPanelWidth: Integer;
    procedure SetArrangeSettings(Value: TJvArrangeSettings);
    procedure SetAppStoragePath(const Value: string);
    function GetAppStoragePath: string;
    function GetAppStorage: TJvCustomAppStorage;
    procedure SetAppStorage(Value: TJvCustomAppStorage);

    procedure ResizeDialogAfterArrange(Sender: TObject; nLeft, nTop, nWidth, nHeight: Integer);

    procedure SetDynControlEngine(Value: TJvDynControlEngine);

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetParentByName(MainParent: TWinControl; const ASearchName: string): TWinControl;
    function GetCount: Integer;

    procedure SetParameters(Index: Integer; Value: TJvBaseParameter);
    function GetParameters(Index: Integer): TJvBaseParameter;

    function GetCurrentWidth: Integer;
    function GetCurrentHeight: Integer;

    procedure HistoryLoadClick(Sender: TObject);
    procedure HistorySaveClick(Sender: TObject);
    procedure HistoryClearClick(Sender: TObject);
    function GetEnableDisableReasonState(ADisableReasons: TJvParameterListEnableDisableReasonList;
      AEnableReasons: TJvParameterListEnableDisableReasonList): Integer;
    procedure DialogShow(Sender: TObject);
    {this procedure checks the autoscroll-property of the internal
     scrollbox. This function should only be called, after the size of
     the parent-panel has changed}
    procedure CheckScrollBoxAutoScroll;
    property IntParameterList: TStrings read GetIntParameterList;
    property ParameterDialog: TCustomForm read FParameterDialog;
    property ParameterListSelectList: TJvParameterListSelectList read FParameterListSelectList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    { Saves the data of all allowed parameters to the AppStorage }
    procedure StoreData;
    { load the data of all allowed parameters from the AppStorage }
    procedure LoadData;
    {Adds a new Parameter to the parameterlist }
    procedure AddParameter(AParameter: TJvBaseParameter);
    {returns the parameter identified by the Searchname}
    function ParameterByName(const ASearchName: string): TJvBaseParameter;
    {returns True id the parameter identified by the Searchname exists}
    function ExistsParameter(const ASearchName: string): Boolean;
    {returns the parameter identified by index-position}
    function ParameterByIndex(AIndex: Integer): TJvBaseParameter;
    {executes a dialog to enter all Parameter-Data,
     returns True when ok-button pressed}
    function ShowParameterDialog: Boolean; overload;
    {executes a dialog to enter all Parameter-Data,
     returns True when ok-button pressed
     This function can be called inside a running thread. It will synchromized
     with the main thread using SynchronizeThread.Synchronize}
    function ShowParameterDialog(SynchronizeThread: TThread): Boolean; overload;
    { Creates the ParameterDialog }
    procedure CreateParameterDialog;
    { Checks the Disable/Enable-Reason of all Parameters }
    procedure HandleEnableDisable;
    {creates the components of all parameters on any WinControl}
    procedure CreateWinControlsOnParent(ParameterParent: TWinControl);
    {Destroy the WinControls of all parameters}
    procedure DestroyWinControls;
    { reads the data of all parameters from the WinControls}
    procedure GetDataFromWinControls;
    procedure SetDataToWinControls;
    { validates the data of all parameters without filling the data into
     the parameters }
    function ValidateDataAtWinControls: Boolean;
    {deletes all Parameters from the ParameterList}
    procedure Clear;
    { count of parameters }
    property Count: Integer read GetCount;
    {returns the current height of the created main-parameter-panel}
    property CurrentWidth: Integer read GetCurrentWidth;
    {returns the current height of the created main-parameter-panel}
    property CurrentHeight: Integer read GetCurrentHeight;
    property DynControlEngine: TJvDynControlEngine read FDynControlEngine write SetDynControlEngine;
    { Property to get access to the parameters }
    property Parameters[Index: Integer]: TJvBaseParameter read GetParameters write SetParameters;
    // Enable/DisableReason for the OkButton
    property OkButtonDisableReasons: TJvParameterListEnableDisableReasonList read FOkButtonDisableReasons write
      FOkButtonDisableReasons;
    property OkButtonEnableReasons: TJvParameterListEnableDisableReasonList read FOkButtonEnableReasons write
      FOkButtonEnableReasons;
    procedure OnEnterParameterControl(Sender: TObject);
    procedure OnExitParameterControl(Sender: TObject);
    procedure OnChangeParameterControl(Sender: TObject);
    procedure OnClickParameterControl(Sender: TObject);
  published
    property ArrangeSettings: TJvArrangeSettings read FArrangeSettings write SetArrangeSettings;
    property Messages: TJvParameterListMessages read FMessages;
    {AppStoragePath for the Parameter-Storage using AppStorage}
    property AppStoragePath: string read GetAppStoragePath write SetAppStoragePath;
    {Width of the dialog. When width = 0, then the width will be calculated }
    property Width: Integer read FWidth write FWidth;
    {Height of the dialog. When height = 0, then the Height will be calculated }
    property Height: Integer read FHeight write FHeight;
    {Maximum ClientWidth of the Dialog}
    property MaxWidth: Integer read FMaxWidth write FMaxWidth default 400;
    {Maximum ClientHeight of the Dialog}
    property MaxHeight: Integer read FMaxHeight write FMaxHeight default 600;
    property DefaultParameterHeight: Integer read FDefaultParameterHeight write FDefaultParameterHeight default 0;
    property DefaultParameterWidth: Integer read FDefaultParameterWidth write FDefaultParameterWidth default 0;
    property DefaultParameterLabelWidth: Integer read FDefaultParameterLabelWidth write FDefaultParameterLabelWidth default 0;
    property OkButtonVisible: Boolean read FOkButtonVisible write FOkButtonVisible;
    property CancelButtonVisible: Boolean read FCancelButtonVisible write FCancelButtonVisible;
    property HistoryEnabled: Boolean read FHistoryEnabled write FHistoryEnabled;
    property LastHistoryName: string read FLastHistoryName write FLastHistoryName;
    property AppStorage: TJvCustomAppStorage read GetAppStorage write SetAppStorage;
  end;

  TJvParameterListSelectList = class(TJvAppStorageSelectList)
  private
    FParameterList: TJvParameterList;
  protected
    function GetDynControlEngine: TJvDynControlEngine; override;
    function GetParameterList: TJvParameterList; virtual;
    procedure SetParameterList(Value: TJvParameterList); virtual;
    function GetAppStorage: TJvCustomAppStorage; override;
    procedure SetAppStorage(Value: TJvCustomAppStorage); override;
  public
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RestoreParameterList(const ACaption: string = '');
    procedure SaveParameterList(const ACaption: string = '');
  published
    property ParameterList: TJvParameterList read GetParameterList write SetParameterList;
  end;

  TJvParameterListPropertyStore = class(TJvCustomPropertyStore)
  private
    FParameterList: TJvParameterList;
  protected
    procedure LoadData; override;
    procedure StoreData; override;
  public
    property ParameterList: TJvParameterList read FParameterList write FParameterList;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvParameterList.pas,v $';
    Revision: '$Revision: 1.59 $';
    Date: '$Date: 2005/03/02 00:51:31 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  JclStrings,
  JvParameterListParameter, JvResources;

const
  cFalse = 'FALSE';
  cTrue = 'TRUE';
  cAllowedChars: TSysCharSet =
    ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '_'];

//=== { TJvParameterListMessages } ===========================================

constructor TJvParameterListMessages.Create;
begin
  inherited Create;
  Caption := RsDialogCaption;
  OkButton := RsOkButton;
  CancelButton := RsCancelButton;
  HistoryLoadButton := RsHistoryLoadButton;
  HistorySaveButton := RsHistorySaveButton;
  HistoryClearButton := RsHistoryClearButton;
  HistoryLoadCaption := RsHistoryLoadCaption;
  HistorySaveCaption := RsHistorySaveCaption;
  HistoryClearCaption := RsHistoryClearCaption;
end;

//=== { TJvParameterListEnableDisableReason } ================================

procedure TJvParameterListEnableDisableReason.SetAsString(Value: string);
begin
  AsVariant := Value;
end;

function TJvParameterListEnableDisableReason.GetAsString: string;
begin
  Result := FValue;
end;

procedure TJvParameterListEnableDisableReason.SetAsDouble(Value: Double);
begin
  AsVariant := Value;
end;

function TJvParameterListEnableDisableReason.GetAsDouble: Double;
begin
  Result := FValue;
end;

procedure TJvParameterListEnableDisableReason.SetAsInteger(Value: Integer);
begin
  AsVariant := Value;
end;

function TJvParameterListEnableDisableReason.GetAsInteger: Integer;
begin
  Result := FValue;
end;

procedure TJvParameterListEnableDisableReason.SetAsBoolean(Value: Boolean);
begin
  if Value then
    AsVariant := cTrue
  else
    AsVariant := cFalse;
end;

function TJvParameterListEnableDisableReason.GetAsBoolean: Boolean;
var
  S: string;
begin
  S := FValue;
  Result := S = cTrue;
end;

procedure TJvParameterListEnableDisableReason.SetAsDate(Value: TDateTime);
begin
  AsVariant := VarFromDateTime(Value);
end;

function TJvParameterListEnableDisableReason.GetAsDate: TDateTime;
begin
  Result := VarToDateTime(FValue);
end;

procedure TJvParameterListEnableDisableReason.SetAsVariant(Value: Variant);
begin
  FValue := Value;
end;

function TJvParameterListEnableDisableReason.GetAsVariant: Variant;
begin
  Result := FValue;
end;

procedure TJvParameterListEnableDisableReason.SetIsEmpty(Value: Boolean);
begin
  // IsEmpty and NotIsEmtpy can both be False, in this case the Reason looks
  // for the value to activate/deactivate
  FIsEmpty := Value;
  if Value then
    IsNotEmpty := False;
end;

procedure TJvParameterListEnableDisableReason.SetIsNotEmpty(Value: Boolean);
begin
  // IsEmpty and NotIsEmtpy can both be False, in this case the Reason looks
  // for the value to activate/deactivate
  FIsNotEmpty := Value;
  if Value then
    IsEmpty := False;
end;

procedure TJvParameterListEnableDisableReason.Assign(Source: TPersistent);
begin
  if Source is TJvParameterListEnableDisableReason then
  begin
    AsVariant := TJvParameterListEnableDisableReason(Source).AsVariant;
    IsEmpty := TJvParameterListEnableDisableReason(Source).IsEmpty;
    IsNotEmpty := TJvParameterListEnableDisableReason(Source).IsNotEmpty;
    RemoteParameterName := TJvParameterListEnableDisableReason(Source).RemoteParameterName;
  end
  else
    inherited Assign(Source);
end;

//=== { TJvParameterListEnableDisableReasonList } ============================

procedure TJvParameterListEnableDisableReasonList.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Objects[I].Free;
  inherited Clear;
end;

procedure TJvParameterListEnableDisableReasonList.AddReasonVariant(const RemoteParameterName: string;
  Value: Variant);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.AsVariant := Value;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReason(const RemoteParameterName: string;
  Value: Boolean);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.AsBoolean := Value;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReason(const RemoteParameterName: string;
  Value: Integer);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.AsInteger := Value;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReason(const RemoteParameterName: string;
  Value: Double);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.AsDouble := Value;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReason(const RemoteParameterName: string;
  const Value: string);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.AsString := Value;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReason(const RemoteParameterName: string;
  Value: TDateTime);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.AsDate := Value;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReasonIsEmpty(const RemoteParameterName: string);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.IsEmpty := True;
  AddObject(RemoteParameterName, Reason);
end;

procedure TJvParameterListEnableDisableReasonList.AddReasonIsNotEmpty(const RemoteParameterName: string);
var
  Reason: TJvParameterListEnableDisableReason;
begin
  Reason := TJvParameterListEnableDisableReason.Create;
  Reason.RemoteParameterName := RemoteParameterName;
  Reason.IsNotEmpty := True;
  AddObject(RemoteParameterName, Reason);
end;

//=== { TJvParameterPropertyValues } =========================================

constructor TJvParameterPropertyValues.Create;
begin
  inherited Create;
  Sorted := True;
  Duplicates := dupIgnore;
end;

destructor TJvParameterPropertyValues.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TJvParameterPropertyValues.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Objects[I].Free;
  Inherited Clear;
end;

procedure TJvParameterPropertyValues.AddValue(const AName: string; AValue: Variant);
var
  Value: TJvParameterPropertyValue;
begin
  Value := TJvParameterPropertyValue.Create;
  Value.PropertyName := AName;
  Value.PropertyValue := AValue;
  AddObject(AName, Value);
end;

//=== { TJvBaseParameter } ===================================================

constructor TJvBaseParameter.Create(AParameterList: TJvParameterList);
begin
  inherited Create(AParameterList);
  FStoreValueToAppStorage := True;
  FStoreValueCrypted := False;
  FTabOrder := -1;
  FParameterList := AParameterList;
  FWinControl := nil;
  FJvDynControl := nil;
  FJvDynControlData := nil;
  Color := clBtnFace;
  FEnabled := True;
  FVisible := True;
  FEnableReasons := TJvParameterListEnableDisableReasonList.Create;
  FDisableReasons := TJvParameterListEnableDisableReasonList.Create;
end;

destructor TJvBaseParameter.Destroy;
begin
  FreeAndNil(FEnableReasons);
  FreeAndNil(FDisableReasons);
  inherited Destroy;
end;

procedure TJvBaseParameter.SetAsString(const Value: string);
begin
  AsVariant := Value;
end;

function TJvBaseParameter.GetAsString: string;
begin
  if VarIsNull(AsVariant) then
    Result := ''
  else
    Result := AsVariant;
end;

procedure TJvBaseParameter.SetAsDouble(Value: Double);
begin
  AsVariant := Value;
end;

function TJvBaseParameter.GetAsDouble: Double;
begin
  if AsString = '' then
    Result := 0
  else
    Result := AsVariant;
end;

procedure TJvBaseParameter.SetAsInteger(Value: Integer);
begin
  AsVariant := Value;
end;

function TJvBaseParameter.GetAsInteger: Integer;
begin
  if VarIsNull(AsVariant) then
    Result := 0
  else
    Result := AsVariant;
end;

procedure TJvBaseParameter.SetAsBoolean(Value: Boolean);
begin
  if Value then
    AsVariant := cTrue
  else
    AsVariant := cFalse;
end;

function TJvBaseParameter.GetAsBoolean: Boolean;
var
  S: string;
begin
  if VarIsNull(FValue) then
    Result := False
  else
  begin
    S := AsVariant;
    Result := UpperCase(S) = cTrue;
  end;
end;

procedure TJvBaseParameter.SetAsDate(Value: TDateTime);
begin
  AsVariant := VarFromDateTime(Value);
end;

function TJvBaseParameter.GetAsDate: TDateTime;
begin
  if VarIsNull(FValue) then
    Result := 0
  else
    Result := VarToDateTime(FValue);
end;

procedure TJvBaseParameter.SetAsVariant(Value: Variant);
begin
  FValue := Value;
  //  if Assigned(FJvDynControlData) then
  //    FJvDynControlData.Value := Value;
end;

function TJvBaseParameter.GetAsVariant: Variant;
begin
  //  if Assigned(FJvDynControlData) then
  //    Result := FJvDynControlData.Value
  //  else
  Result := FValue;
end;

procedure TJvBaseParameter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FWinControl) and (Operation = opRemove) then
  begin
    FWinControl := nil;
    FJvDynControl := nil;
    FJvDynControlData := nil;
  end;
end;

function TJvBaseParameter.GetWinControlData: Variant;
begin
  Result := Null;
  if Assigned(JvDynControlData) then
    Result := JvDynControlData.ControlValue;
end;

procedure TJvBaseParameter.SetWinControlData(Value: Variant);
begin
  if Assigned(JvDynControlData) then
    try
      JvDynControlData.ControlValue := Value;
    except
      {$IFDEF COMPILER6_UP}
      on E: EVariantTypeCastError do
        ;
      {$ELSE}
      on E: EVariantError do
        ;
      {$ENDIF COMPILER6_UP}
    end;
end;

procedure TJvBaseParameter.SetSearchName(Value: string);
begin
  FSearchName := Trim(Value);
end;

function TJvBaseParameter.GetDynControlEngine: TJvDynControlEngine;
begin
  Result := nil;
  if Assigned(ParameterList) then
    Result := ParameterList.DynControlEngine;
end;

//type
//  TWinControlAccessProtected = class(TWinControl);

procedure TJvBaseParameter.SetWinControl(Value: TWinControl);
begin
  FJvDynControl := nil;
  FWinControl := Value;
  if not Assigned(Value) then
    Exit;
  Supports(FWinControl, IJvDynControl, FJvDynControl);
  Supports(FWinControl, IJvDynControlData, FJvDynControlData);

  SetWinControlProperties;
end;

procedure TJvBaseParameter.SetWinControlProperties;
var
  IDynControlReadOnly: IJvDynControlReadOnly;
begin
  if Assigned(WinControl) then
  begin
    JvDynControl.ControlSetCaption(Caption);
    if Supports(FWinControl, IJvDynControlReadOnly, IDynControlReadOnly) then
    begin
      IDynControlReadOnly.ControlSetReadOnly(ReadOnly);
      SetEnabled(FEnabled);
    end
    else
      SetEnabled(FEnabled and not ReadOnly);
    SetVisible(FVisible);
    if FTabOrder >= 0 then
      SetTabOrder(FTabOrder);
    if FWidth > 0 then
      SetWidth(FWidth);
    if FHeight > 0 then
      SetHeight(FHeight);
    WinControl.Hint := Hint;
    WinControl.Tag := Tag;
    WinControl.HelpContext := HelpContext;
    JvDynControl.ControlSetOnEnter(ParameterList.OnExitParameterControl);
    JvDynControl.ControlSetOnExit(ParameterList.OnExitParameterControl);
    if Assigned(JvDynControlData) then
      JvDynControlData.ControlSetOnChange(ParameterList.OnChangeParameterControl);
  end;
end;

function TJvBaseParameter.GetWinControl: TWinControl;
begin
  Result := FWinControl
end;

procedure TJvBaseParameter.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  if Assigned(WinControl) then
    WinControl.Enabled := Value;
end;

procedure TJvBaseParameter.SetVisible(Value: Boolean);
begin
  FVisible := Value;
  if Assigned(WinControl) then
    WinControl.Visible := Value;
end;

function TJvBaseParameter.GetHeight: Integer;
begin
  if Assigned(ParameterList) and (FHeight <= 0) then
    Result := ParameterList.DefaultParameterHeight
  else
    Result := FHeight;
end;

procedure TJvBaseParameter.SetHeight(Value: Integer);
begin
  FHeight := Value;
  if Assigned(WinControl) then
    WinControl.Height := Value;
end;

function TJvBaseParameter.GetWidth: Integer;
begin
  if Assigned(ParameterList) and (FWidth <= 0) then
    Result := ParameterList.DefaultParameterWidth
  else
    Result := FWidth;
end;

procedure TJvBaseParameter.SetWidth(Value: Integer);
begin
  FWidth := Value;
  if Assigned(WinControl) then
    WinControl.Width := Value;
end;

procedure TJvBaseParameter.SetTabOrder(Value: Integer);
begin
  FTabOrder := Value;
  if Assigned(WinControl) then
    WinControl.TabOrder := Value;
end;

procedure TJvBaseParameter.GetData;
begin
  AsVariant := Null;
  if Assigned(WinControl) then
//    FValue := WinControlData;
    AsVariant := WinControlData;
end;

procedure TJvBaseParameter.SetData;
begin
  if Assigned(WinControl) then
//    WinControlData := FValue;
    WinControlData := AsVariant;
end;

procedure TJvBaseParameter.Assign(Source: TPersistent);
begin
  if Source is TJvBaseParameter then
  begin
    AsVariant := TJvBaseParameter(Source).AsVariant;
    Caption := TJvBaseParameter(Source).Caption;
    SearchName := TJvBaseParameter(Source).SearchName;
    Width := TJvBaseParameter(Source).Width;
    Height := TJvBaseParameter(Source).Height;
    Required := TJvBaseParameter(Source).Required;
    ParentParameterName := TJvBaseParameter(Source).ParentParameterName;
    StoreValueToAppStorage := TJvBaseParameter(Source).StoreValueToAppStorage;
    StoreValueCrypted := TJvBaseParameter(Source).StoreValueCrypted;
    TabOrder := TJvBaseParameter(Source).TabOrder;
    FParameterList := TJvBaseParameter(Source).ParameterList;
    Color := TJvBaseParameter(Source).Color;
    ReadOnly := TJvBaseParameter(Source).ReadOnly;
    Enabled := TJvBaseParameter(Source).Enabled;
    FEnableReasons.Assign(TJvBaseParameter(Source).FEnableReasons);
    FDisableReasons.Assign(TJvBaseParameter(Source).FDisableReasons);
  end
  else
    inherited Assign(Source);
end;

function TJvBaseParameter.Validate(var AData: Variant): Boolean;
begin
  if not Required or not Enabled then
    Result := True
  else
    Result := not VarIsNull(AData);
  if not Result then
    DSADialogsMessageDlg(Format(RsErrParameterMustBeEntered, [Caption]), mtError, [mbOK], 0);
end;

function TJvBaseParameter.GetParameterNameExt: string;
begin
  Result := '';
end;

function TJvBaseParameter.GetParameterNameBase: string;
begin
  Result := 'ParameterItem' + StrReplaceButChars(SearchName, cAllowedChars, '_');
end;

function TJvBaseParameter.GetParameterName: string;
begin
  Result := GetParameterNameBase + GetParameterNameExt;
end;

//=== { TJvParameterList } ===================================================

constructor TJvParameterList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMessages := TJvParameterListMessages.Create;
  FParameterListPropertyStore := TJvParameterListPropertyStore.Create(nil);
  FParameterListPropertyStore.ParameterList := Self;
  FIntParameterList := TStringList.Create;
  FDynControlEngine := DefaultDynControlEngine;
  FArrangeSettings := TJvArrangeSettings.Create(nil);
  with FArrangeSettings do
  begin
    AutoArrange := True;
    WrapControls := True;
    AutoSize := asBoth;
    DistanceVertical := 3;
    DistanceHorizontal := 3;
    BorderLeft := 5;
    BorderTop := 5;
  end;
  ScrollBox := nil;
  RightPanel := nil;
  ArrangePanel := nil;
  FMaxWidth := 600;
  FMaxHeight := 400;
  FDefaultParameterHeight := 0;
  FDefaultParameterWidth := 0;
  FDefaultParameterLabelWidth := 0;
  FOkButtonVisible := True;
  FCancelButtonVisible := True;
  FHistoryEnabled := False;
  FLastHistoryName := '';
  FParameterListSelectList := TJvParameterListSelectList.Create(Self);
  FParameterListSelectList.ParameterList := Self;
  FOkButtonDisableReasons := TJvParameterListEnableDisableReasonList.Create;
  FOkButtonEnableReasons := TJvParameterListEnableDisableReasonList.Create;
end;

destructor TJvParameterList.Destroy;
begin
  DestroyWinControls;
  FreeAndNil(FParameterListSelectList);
  FreeAndNil(FIntParameterList);
  FreeAndNil(FParameterListPropertyStore);
  FreeAndNil(FArrangeSettings);
  FreeAndNil(FMessages);
  FreeAndNil(FOkButtonDisableReasons);
  FreeAndNil(FOkButtonEnableReasons);
  inherited Destroy;
end;

function TJvParameterList.GetIntParameterList: TStrings;
begin
  Result := FIntParameterList;
end;

procedure TJvParameterList.AddParameter(AParameter: TJvBaseParameter);
begin
  AddObject(AParameter.SearchName, AParameter);
end;

function TJvParameterList.ExistsParameter(const ASearchName: string): Boolean;
begin
  Result := Assigned(ParameterByName(ASearchName));
end;

function TJvParameterList.ParameterByName(const ASearchName: string): TJvBaseParameter;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if UpperCase(Parameters[I].SearchName) = UpperCase(Trim(ASearchName)) then
    begin
      Result := Parameters[I];
      Break;
    end;
end;

function TJvParameterList.ParameterByIndex(AIndex: Integer): TJvBaseParameter;
begin
  Result := Parameters[AIndex];
end;

procedure TJvParameterList.Assign(Source: TPersistent);
begin
  if Source is TJvParameterList then
  begin
    Messages.Assign(TJvParameterList(Source).Messages);
    ArrangeSettings := TJvParameterList(Source).ArrangeSettings;
    AppStorage := TJvParameterList(Source).AppStorage;
    Width := TJvParameterList(Source).Width;
    Height := TJvParameterList(Source).Height;
    MaxWidth := TJvParameterList(Source).MaxWidth;
    MaxHeight := TJvParameterList(Source).MaxHeight;
    OkButtonVisible := TJvParameterList(Source).OkButtonVisible;
    CancelButtonVisible := TJvParameterList(Source).CancelButtonVisible;
    FIntParameterList.Assign(TJvParameterList(Source).IntParameterList);
    HistoryEnabled := TJvParameterList(Source).HistoryEnabled;
    AppStoragePath := TJvParameterList(Source).AppStoragePath;
  end
  else
    inherited Assign(Source);
end;

procedure TJvParameterList.SetAppStoragePath(const Value: string);
begin
  FParameterListPropertyStore.AppStoragePath := Value;
  if Assigned(AppStorage) then
    FParameterListSelectList.SelectPath := AppStorage.ConcatPaths([Value, RsHistorySelectPath])
end;

function TJvParameterList.GetAppStoragePath: string;
begin
  Result := FParameterListPropertyStore.AppStoragePath;
end;

function TJvParameterList.GetAppStorage: TJvCustomAppStorage;
begin
  Result := FParameterListPropertyStore.AppStorage;
end;

procedure TJvParameterList.SetAppStorage(Value: TJvCustomAppStorage);
begin
  FParameterListPropertyStore.AppStorage := Value;
  if Assigned(Value) then
    FParameterListSelectList.SelectPath := Value.ConcatPaths([FParameterListPropertyStore.AppStoragePath, RsHistorySelectPath])
end;

procedure TJvParameterList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = ScrollBox then
      ScrollBox := nil;
    if AComponent = RightPanel then
      RightPanel := nil;
    if AComponent = ArrangePanel then
      ArrangePanel := nil;
    if AComponent = FParameterListPropertyStore then
      FParameterListPropertyStore := nil;
    if AComponent = OkButton then
      OkButton := nil;
  end;
end;

procedure TJvParameterList.SetDynControlEngine(Value: TJvDynControlEngine);
begin
  FDynControlEngine := Value;
end;

procedure TJvParameterList.StoreData;
begin
  if (AppStoragePath <> '') and Assigned(AppStorage) then
    FParameterListPropertyStore.StoreData;
end;

procedure TJvParameterList.LoadData;
begin
  if (AppStoragePath <> '') and Assigned(AppStorage) then
    FParameterListPropertyStore.LoadData;
end;

procedure TJvParameterList.OnOkButtonClick(Sender: TObject);
begin
  if ValidateDataAtWinControls then
    ParameterDialog.ModalResult := mrOk;
end;

procedure TJvParameterList.OnCancelButtonClick(Sender: TObject);
begin
  ParameterDialog.ModalResult := mrCancel;
end;

procedure TJvParameterList.OnEnterParameterControl(Sender: TObject);
var
  I: Integer;
begin
  if Assigned(Sender) then
    for I := 0 to Count - 1 do
      if Parameters[I].WinControl = Sender then
      begin
        if Assigned(Parameters[I].OnEnterParameter) then
          Parameters[I].OnEnterParameter(Self, Parameters[I]);
        Break;
      end;
end;

procedure TJvParameterList.OnExitParameterControl(Sender: TObject);
var
  I: Integer;
begin
  if Assigned(Sender) then
    for I := 0 to Count - 1 do
      if Parameters[I].WinControl = Sender then
      begin
        if Assigned(Parameters[I].OnExitParameter) then
          Parameters[I].OnExitParameter(Self, Parameters[I]);
        Break;
      end;
  HandleEnableDisable;
end;

procedure TJvParameterList.OnChangeParameterControl(Sender: TObject);
begin
  HandleEnableDisable;
end;

procedure TJvParameterList.OnClickParameterControl(Sender: TObject);
begin
end;

type
  TCustomControlAccessProtected = class(TCustomControl);

procedure TJvParameterList.CreateParameterDialog;
var
  CancelButton: TWinControl;
  LoadButton, SaveButton, ClearButton: TWinControl;
  ButtonLeft: Integer;
  ITmpPanel: IJvDynControlPanel;
begin
  FreeAndNil(FParameterDialog);

  FParameterDialog := DynControlEngine.CreateForm(Messages.Caption, '');

  with TForm(ParameterDialog) do
  begin
    BorderIcons := [];
    {$IFDEF VCL}
    DefaultMonitor := dmActiveForm;
    {$ENDIF VCL}
    BorderStyle := fbsDialog;
    FormStyle := fsNormal;
    Position := poScreenCenter;
    OnShow := DialogShow;
  end;

  if Height > 0 then
    ParameterDialog.Height := Height;
  if Width > 0 then
    ParameterDialog.Width := Width;

  BottomPanel := DynControlEngine.CreatePanelControl(Self, ParameterDialog, 'BottomPanel', '', alBottom);
  if not Supports(BottomPanel, IJvDynControlPanel, ITmpPanel) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  with ITmpPanel do
    ControlSetBorder(bvNone, bvRaised, 1, bsNone, 0);

  MainPanel := DynControlEngine.CreatePanelControl(Self, ParameterDialog, 'MainPanel', '', alClient);
  if not Supports(MainPanel, IJvDynControlPanel, ITmpPanel) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  with ITmpPanel do
    ControlSetBorder(bvNone, bvRaised, 1, bsNone, 3);

  ButtonPanel := DynControlEngine.CreatePanelControl(Self, BottomPanel, 'BottonPanel', '', alRight);
  if not Supports(ButtonPanel, IJvDynControlPanel, ITmpPanel) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  with ITmpPanel do
    ControlSetBorder(bvNone, bvNone, 0, bsNone, 0);

  OkButton := DynControlEngine.CreateButton(Self, ButtonPanel, 'OkButton', Messages.OkButton, '',
    OnOkButtonClick, True, False);
  CancelButton := DynControlEngine.CreateButton(Self, ButtonPanel, 'CancelButton', Messages.CancelButton, '',
    OnCancelButtonClick, False, True);

  BottomPanel.Height := OkButton.Height + 6 + 2;

  OkButton.Top := 3;
  OkButton.Left := 3;
  OkButton.Visible := OkButtonVisible;
  OkButton.Enabled := OkButtonVisible;
  if OkButton.Visible then
    ButtonLeft := OkButton.Left + OkButton.Width + 3
  else
    ButtonLeft := 0;

  CancelButton.Top := 3;
  CancelButton.Left := ButtonLeft + 3;
  CancelButton.Visible := CancelButtonVisible;
  CancelButton.Enabled := CancelButtonVisible;
  if CancelButton.Visible then
    ButtonLeft := ButtonLeft + 3 + CancelButton.Width + 3;

  ButtonPanel.Width := ButtonLeft + 3;
  OrgButtonPanelWidth := ButtonLeft + 3;

  OkButton.Anchors := [akTop, akRight];
  CancelButton.Anchors := [akTop, akRight];

  if HistoryEnabled and (AppStoragePath <> '') then
  begin
    HistoryPanel := DynControlEngine.CreatePanelControl(Self, BottomPanel, 'HistoryPanel', '', alLeft);
    if not Supports(HistoryPanel, IJvDynControlPanel, ITmpPanel) then
      raise EIntfCastError.CreateRes(@RsEIntfCastError);
    with ITmpPanel do
      ControlSetBorder(bvNone, bvNone, 0, bsNone, 0);
    with HistoryPanel do
      Height := 25;
    LoadButton := DynControlEngine.CreateButton(Self, HistoryPanel, 'LoadButton', Messages.HistoryLoadButton, '',
      HistoryLoadClick, False, False);
    with LoadButton do
    begin
      Left := 6;
      Top := 5;
      Height := 20;
      Width := TCustomControlAccessProtected(HistoryPanel).Canvas.TextWidth(Messages.HistoryLoadButton) + 5;
      ButtonLeft := Left + Width + 5;
    end;
    SaveButton := DynControlEngine.CreateButton(Self, HistoryPanel, 'SaveButton', Messages.HistorySaveButton, '',
      HistorySaveClick, False, False);
    with SaveButton do
    begin
      Left := ButtonLeft;
      Top := 5;
      Height := 20;
      Width := TCustomControlAccessProtected(HistoryPanel).Canvas.TextWidth(Messages.HistorySaveButton) + 5;
      ButtonLeft := Left + Width + 5;
    end;
    ClearButton := DynControlEngine.CreateButton(Self, HistoryPanel, 'ClearButton', Messages.HistoryClearButton, '',
      HistoryClearClick, False, False);
    with ClearButton do
    begin
      Left := ButtonLeft;
      Top := 5;
      Height := 20;
      Width := TCustomControlAccessProtected(HistoryPanel).Canvas.TextWidth(Messages.HistoryClearButton) + 5;
      ButtonLeft := Left + Width + 5;
    end;
    HistoryPanel.Width := ButtonLeft;
    OrgHistoryPanelWidth := ButtonLeft;
  end
  else
    HistoryPanel := nil;

  CreateWinControlsOnParent(MainPanel);

  with MainPanel do
    ResizeDialogAfterArrange(nil, Left, Top, Width, Height);
end;

procedure TJvParameterList.ResizeDialogAfterArrange(Sender: TObject; nLeft, nTop, nWidth, nHeight: Integer);
begin
  if (Width <= 0) or (ArrangeSettings.AutoSize in [asWidth, asBoth]) then
    if ArrangePanel.Width > TForm(ParameterDialog).ClientWidth then
      if ArrangePanel.Width > MaxWidth then
        TForm(ParameterDialog).ClientWidth := MaxWidth
      else
        TForm(ParameterDialog).ClientWidth := ArrangePanel.Width+5
    else
      TForm(ParameterDialog).ClientWidth := ArrangePanel.Width+5;
  if Assigned(HistoryPanel) and
     (TForm(ParameterDialog).ClientWidth < HistoryPanel.Width) then
    TForm(ParameterDialog).ClientWidth := HistoryPanel.Width
  else
  if TForm(ParameterDialog).ClientWidth < ButtonPanel.Width then
    TForm(ParameterDialog).ClientWidth := ButtonPanel.Width;
  if (Height <= 0) or (ArrangeSettings.AutoSize in [asHeight, asBoth]) then
    if ArrangePanel.Height + BottomPanel.Height > TForm(ParameterDialog).ClientHeight then
      if ArrangePanel.Height + BottomPanel.Height > MaxHeight then
        TForm(ParameterDialog).ClientHeight := MaxHeight + 10
      else
        TForm(ParameterDialog).ClientHeight := ArrangePanel.Height + BottomPanel.Height + 10
    else
      TForm(ParameterDialog).ClientHeight := ArrangePanel.Height + BottomPanel.Height + 10;

  if Assigned(HistoryPanel) then
    if (OrgButtonPanelWidth + OrgHistoryPanelWidth) > BottomPanel.Width then
    begin
      ButtonPanel.Align := alBottom;
      ButtonPanel.Height := OkButton.Height + 6 + 2;
      BottomPanel.Height := ButtonPanel.Height * 2 + 1;
      HistoryPanel.Align := alClient;
    end
    else
    begin
      ButtonPanel.Align := alRight;
      ButtonPanel.Width := OrgButtonPanelWidth;
      HistoryPanel.Align := alLeft;
      HistoryPanel.Width := OrgHistoryPanelWidth;
      BottomPanel.Height := OkButton.Height + 6 + 2;
    end;
  CheckScrollBoxAutoScroll;
end;

procedure TJvParameterList.CheckScrollBoxAutoScroll;
begin
  if not Assigned(ScrollBox) then
    Exit;
  if not Assigned(ArrangePanel) then
    Exit;
  RightPanel.Visible := False;
  ScrollBox.AutoScroll := False;
  if (ArrangePanel.Width >= (TForm(ParameterDialog).ClientWidth)) or
    (ArrangePanel.Height > (TForm(ParameterDialog).ClientHeight-BottomPanel.Height))then
  begin
    RightPanel.Visible := True;
    TForm(ParameterDialog).ClientWidth := TForm(ParameterDialog).ClientWidth + RightPanel.Width+4;
    ScrollBox.AutoScroll := True;
  end;
//  if (ArrangePanel.Height > (ScrollBox.Height+3)) {OR
///  (ArrangePanel.Height > MaxHeight) }then
//    ScrollBox.AutoScroll := True;
end;

function TJvParameterList.ShowParameterDialog: Boolean;
begin
  if Count = 0 then
    EJVCLException.CreateRes(@RsENoParametersDefined);
  CreateParameterDialog;
  try
    SetDataToWinControls;
    ParameterDialog.ShowModal;
    Result := ParameterDialog.ModalResult = mrOk;
    if Result then
      GetDataFromWinControls;
  finally
    FreeAndNil(FParameterDialog);
  end;
end;

procedure TJvParameterList.ShowParameterDialogThread;
begin
  ParameterDialog.ShowModal;
end;

type
  TAccessThread = class(TThread);

function TJvParameterList.ShowParameterDialog(SynchronizeThread: TThread): Boolean;
begin
  if Count = 0 then
    EJVCLException.CreateRes(@RsENoParametersDefined);
  CreateParameterDialog;
  try
    SetDataToWinControls;
    if Assigned(SynchronizeThread) then
      TAccessThread(SynchronizeThread).Synchronize(ShowParameterDialogThread)
    else
      ParameterDialog.ShowModal;
    Result := ParameterDialog.ModalResult = mrOk;
    if Result then
      GetDataFromWinControls;
  finally
    FreeAndNil(FParameterDialog);
  end;
end;

function TJvParameterList.GetParentByName(MainParent: TWinControl; const ASearchName: string): TWinControl;
var
  Parameter: TJvBaseParameter;
  I: Integer;
begin
  Result := MainParent;
  if (Trim(ASearchName) = '') or not Assigned(MainParent) then
    Exit;
  for I := 0 to Count - 1 do
    if Parameters[I].Visible then
      if UpperCase(Parameters[I].SearchName) = UpperCase(Trim(ASearchName)) then
      begin
        Parameter := Parameters[I];
        if Parameter is TJvArrangeParameter then
        begin
          Result := TJvArrangeParameter(Parameter).ParentControl;
          Break;
        end;
      end;
      //      else
      //      if Parameters[I] is TJvTabControlParameter then
      //        for J := 0 to TJvTabControlParameter(Parameters[I]).Tabs.Count - 1 do
     //          if Uppercase(Parameters[I].SearchName + '.' + TJvTabControlParameter(Parameters[I]).Tabs[J]) = Uppercase(SearchName) then
     //          begin
     //            Result := TWinControl(TJvTabControlParameter(Parameters[I]).TabWinControls.Objects[J]);
     //            break;
     //          end   {*** IF Uppercase(TJvBaseParameter(Objects[I]).SearchName) = Uppercase(ASearchName) THEN ***}
end;

procedure TJvParameterList.HistoryLoadClick(Sender: TObject);
begin
  ParameterListSelectList.RestoreParameterList(Messages.HistoryLoadCaption);
end;

procedure TJvParameterList.HistorySaveClick(Sender: TObject);
begin
  ParameterListSelectList.SaveParameterList(Messages.HistorySaveCaption);
end;

procedure TJvParameterList.HistoryClearClick(Sender: TObject);
begin
  ParameterListSelectList.ManageSelectList(Messages.HistoryClearCaption);
end;

procedure TJvParameterList.DialogShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Parameters[I].Visible then
      if Assigned(Parameters[I].WinControl) then
        if Parameters[I].WinControl.CanFocus then
        begin
          Parameters[I].WinControl.SetFocus;
          Break;
        end;
end;

function TJvParameterList.GetEnableDisableReasonState(ADisableReasons: TJvParameterListEnableDisableReasonList;
  AEnableReasons: TJvParameterListEnableDisableReasonList): Integer;
var
  J: Integer;
  IEnable: Integer;
  Reason: TJvParameterListEnableDisableReason;
  SearchParameter: TJvBaseParameter;
  Data: Variant;
begin
  IEnable := 0;
  if AEnableReasons.Count > 0 then
  begin
    for J := 0 to AEnableReasons.Count - 1 do
    begin
      Reason := TJvParameterListEnableDisableReason(AEnableReasons.Objects[J]);
      if not Assigned(Reason) then
        Continue;
      if VarIsNull(Reason.AsVariant) then
        Continue;
      SearchParameter := ParameterByName(Reason.RemoteParameterName);
      if not Assigned(SearchParameter) then
        Continue;
      if not Assigned(SearchParameter.WinControl) then
        Continue;
      Data := SearchParameter.GetWinControlData;
      if VarIsEmpty(Data) and Reason.IsEmpty and (IEnable <> -1) then
        IEnable := 1;
      if (not VarIsEmpty(Data)) and Reason.IsNotEmpty and (IEnable <> -1) then
        IEnable := 1;
      try
        if (VarToStr(Reason.AsVariant) = VarToStr(Data)) and (IEnable <> -1) then
          IEnable := 1;
      except
      end;
    end;
    if IEnable = 0 then
      IEnable := -1;
  end;
  if ADisableReasons.Count > 0 then
  begin
    for J := 0 to ADisableReasons.Count - 1 do
    begin
      Reason := TJvParameterListEnableDisableReason(ADisableReasons.Objects[J]);
      if not Assigned(Reason) then
        Continue;
      if VarIsNull(Reason.AsVariant) then
        Continue;
      SearchParameter := ParameterByName(Reason.RemoteParameterName);
      if not Assigned(SearchParameter) then
        Continue;
      if not Assigned(SearchParameter.WinControl) then
        Continue;
      Data := SearchParameter.GetWinControlData;
      if (VarIsEmpty(Data) or (VarToStr(Data) = '')) and Reason.IsEmpty then
        IEnable := -1;
      if (not (VarIsEmpty(Data) or (VarToStr(Data) = ''))) and Reason.IsNotEmpty then
        IEnable := -1;
      try
        if VarToStr(Reason.AsVariant) = VarToStr(Data) then
          IEnable := -1;
      except
      end;
    end;
    if IEnable = 0 then
      IEnable := 1;
  end;
  Result := IEnable;
end;

procedure TJvParameterList.HandleEnableDisable;
var
  I: Integer;
  Parameter: TJvBaseParameter;
  IEnable: Integer;
begin
  for I := 0 to Count - 1 do
    if Assigned(ParameterByIndex(I).WinControl) then
    begin
      Parameter := ParameterByIndex(I);
      IEnable := GetEnableDisableReasonState(Parameter.DisableReasons, Parameter.EnableReasons);
      case IEnable of
        -1:
          Parameter.Enabled := False;
        1:
          Parameter.Enabled := True;
      end;
    end;
  if Assigned(OkButton) then
  begin
    IEnable := GetEnableDisableReasonState(OkButtonDisableReasons, OkButtonEnableReasons);
    case IEnable of
      -1:
        OkButton.Enabled := False;
      1:
        OkButton.Enabled := True;
    end;
  end;
end;

procedure TJvParameterList.CreateWinControlsOnParent(ParameterParent: TWinControl);
var
  I: Integer;
begin
  FreeAndNil(ScrollBox);
  ScrollBox := TScrollBox.Create(Self);
  ScrollBox.Parent := ParameterParent;
  with ScrollBox do
  begin
    AutoScroll := False;
    BorderStyle := bsNone;
    {$IFDEF VCL}
    {$IFDEF COMPILER6_UP}
    BevelInner := bvNone;
    BevelOuter := bvNone;
    {$ENDIF COMPILER6_UP}
    {$ENDIF VCL}
    Align := alClient;
    Width := ParameterParent.Width;
  end;
  RightPanel := TJvPanel.Create(Self);
  RightPanel.Parent := ScrollBox;
  with RightPanel do
  begin
    Align := alRight;
    BorderStyle := bsNone;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    Width := 22;       // asn: need to check this
    Visible := False;
  end;
  FreeAndNil(ArrangePanel);
  ArrangePanel := TJvPanel.Create(Self);
  ArrangePanel.Parent := ScrollBox;
  ArrangePanel.Name := 'MainArrangePanel';
  with ArrangePanel do
  begin
    Transparent := False;
    Align := alNone;
    BorderStyle := bsNone;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    Caption := '';
    Left := 0;
    Top := 0;
    OnResizeParent := ResizeDialogAfterArrange;
  end;
  ArrangePanel.ArrangeSettings := ArrangeSettings;
  case ArrangePanel.ArrangeSettings.AutoSize of
    asNone:
      ArrangePanel.ArrangeSettings.AutoSize := asHeight;
    asWidth:
      ArrangePanel.ArrangeSettings.AutoSize := asBoth;
  end;
  if (Width > 0) and (ArrangePanel.ArrangeSettings.AutoSize = asHeight) then
    ArrangePanel.Width := ScrollBox.Width - RightPanel.Width;
  if MaxWidth > 0 then
    ArrangePanel.ArrangeSettings.MaxWidth := MaxWidth - RightPanel.Width - 2;
  try
    ArrangePanel.DisableArrange;
    for I := 0 to Count - 1 do
      if Parameters[I].Visible then
      begin
        Parameters[I].CreateWinControlOnParent(
          GetParentByName(ArrangePanel, Parameters[I].ParentParameterName));
        Parameters[I].WinControlData := Parameters[I].AsVariant;
      end;
    for I := 0 to Count - 1 do
      if Parameters[I].Visible and
         (Parameters[I] is TJvArrangeParameter) then
        TJvArrangeParameter(Parameters[I]).ArrangeControls;
    HandleEnableDisable;
  finally
    ArrangePanel.EnableArrange;
  end;
  ArrangePanel.ArrangeControls;
end;


procedure TJvParameterList.DestroyWinControls;
begin
  FreeAndNil(ArrangePanel);
  FreeAndNil(ScrollBox);
end;

procedure TJvParameterList.GetDataFromWinControls;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Parameters[I].Visible then
      Parameters[I].GetData;
end;

procedure TJvParameterList.SetDataToWinControls;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Parameters[I].Visible then
      Parameters[I].SetData;
end;

function TJvParameterList.ValidateDataAtWinControls: Boolean;
var
  I: Integer;
  V: Variant;
  B: Boolean;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Parameters[I].Visible then
    begin
      V := Parameters[I].WinControlData;
      B := Parameters[I].Validate(V);
      Parameters[I].WinControlData := V;
      if not B then
      begin
        if Assigned(Parameters[I].WinControl) then
          Parameters[I].WinControl.SetFocus;
        Exit;
      end;
    end;
  Result := True;
end;

function TJvParameterList.GetCount: Integer;
begin
  Result := IntParameterList.Count;
end;

function TJvParameterList.AddObject(const S: string; AObject: TObject): Integer;
begin
  if not (AObject is TJvBaseParameter) then
    raise EJVCLException.CreateRes(@RsEAddObjectWrongObjectType);
  if TJvBaseParameter(AObject).SearchName = '' then
    raise EJVCLException.CreateRes(@RsEAddObjectSearchNameNotDefined);
  if IntParameterList.IndexOf(S) >= 0 then
    raise Exception.CreateResFmt(@RsEAddObjectDuplicateSearchNamesNotAllowed, [S]);
  TJvBaseParameter(AObject).ParameterList := Self;
  Result := IntParameterList.AddObject(S, AObject);
end;

procedure TJvParameterList.SetArrangeSettings(Value: TJvArrangeSettings);
begin
  FArrangeSettings.Assign(Value);
  if Assigned(ArrangePanel) then
    ArrangePanel.ArrangeSettings := ArrangeSettings;
end;

procedure TJvParameterList.SetParameters(Index: Integer; Value: TJvBaseParameter);
begin
  if (Index >= 0) and (Index < IntParameterList.Count) then
    IntParameterList.Objects[Index] := Value;
end;

function TJvParameterList.GetParameters(Index: Integer): TJvBaseParameter;
begin
  if (Index >= 0) and (Index < IntParameterList.Count) then
    Result := TJvBaseParameter(IntParameterList.Objects[Index])
  else
    Result := nil;
end;

function TJvParameterList.GetCurrentWidth: Integer;
begin
  if Width > 0 then
    Result := Width
  else
  if Assigned(ArrangePanel) then
    if ArrangePanel.Align in [alTop, alBottom, alClient] then
      Result := ArrangePanel.ArrangeWidth
    else
      Result := ArrangePanel.Width
  else
    Result := 0;
  if Result > MaxWidth then
    Result := MaxWidth;
end;

function TJvParameterList.GetCurrentHeight: Integer;
begin
  if Height > 0 then
    Result := Height
  else
  if Assigned(ArrangePanel) then
  begin
    if ArrangePanel.Align in [alLeft, alRight, alClient] then
      Result := ArrangePanel.ArrangeHeight
    else
      Result := ArrangePanel.Height;
  end
  else
    Result := 0;
  if Result > MaxHeight then
    Result := MaxHeight;
end;

procedure TJvParameterList.Clear;
begin
  IntParameterList.Clear;
end;

//=== { TJvParameterListPropertyStore } ======================================

procedure TJvParameterListPropertyStore.LoadData;
var
  I: Integer;
begin
  if Assigned(AppStorage) then
    with ParameterList do
      for I := 0 to ParameterList.Count - 1 do
        if not (Parameters[I] is TJvNoDataParameter) then
          with Parameters[I] do
            if StoreValueToAppStorage then
            begin
              if StoreValueCrypted then
                AppStorage.EnablePropertyValueCrypt;
              if Parameters[I] is TJvListParameter then
                with TJvListParameter(Parameters[I]) do
                  ItemIndex := AppStorage.ReadInteger(AppStorage.ConcatPaths([AppStoragePath, SearchName]), ItemIndex)
              else
                AsString := AppStorage.ReadString(AppStorage.ConcatPaths([AppStoragePath, SearchName]), AsString);
              if StoreValueCrypted then
                AppStorage.DisablePropertyValueCrypt;
            end;
end;

procedure TJvParameterListPropertyStore.StoreData;
var
  I: Integer;
begin
  if Assigned(AppStorage) then
    with ParameterList do
      for I := 0 to ParameterList.Count - 1 do
        if not (Parameters[I] is TJvNoDataParameter) then
          with Parameters[I] do
            if StoreValueToAppStorage then
            begin
              if StoreValueCrypted then
                AppStorage.EnablePropertyValueCrypt;
              if Parameters[I] is TJvListParameter then
                with TJvListParameter(Parameters[I]) do
                  AppStorage.WriteInteger(AppStorage.ConcatPaths([AppStoragePath, SearchName]), ItemIndex)
              else
                AppStorage.WriteString(AppStorage.ConcatPaths([AppStoragePath, SearchName]), AsString);
              if StoreValueCrypted then
                AppStorage.DisablePropertyValueCrypt;
            end;
end;

//=== { TJvParameterListSelectList } =========================================

function TJvParameterListSelectList.GetDynControlEngine: TJvDynControlEngine;
begin
  Result := FParameterList.DynControlEngine;
end;

function TJvParameterListSelectList.GetParameterList: TJvParameterList;
begin
  Result := FParameterList;
end;

procedure TJvParameterListSelectList.SetParameterList(Value: TJvParameterList);
begin
  FParameterList := Value;
end;

function TJvParameterListSelectList.GetAppStorage: TJvCustomAppStorage;
begin
  if Assigned(FParameterList) then
    Result := FParameterList.AppStorage
  else
    Result := nil;
end;

procedure TJvParameterListSelectList.SetAppStorage(Value: TJvCustomAppStorage);
begin
  if Assigned(FParameterList) then
    FParameterList.AppStorage := Value;
end;

procedure TJvParameterListSelectList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FParameterList) then
    FParameterList := nil;
end;

procedure TJvParameterListSelectList.RestoreParameterList(const ACaption: string = '');
var
  SavePath: string;
begin
  if not Assigned(ParameterList) then
    Exit;
  SavePath := ParameterList.AppStoragePath;
  try
    ParameterList.AppStoragePath := GetSelectListPath(sloLoad, ACaption);
    if ParameterList.AppStoragePath <> '' then
    begin
      ParameterList.LoadData;
      ParameterList.SetDataToWinControls;
    end;
  finally
    ParameterList.AppStoragePath := SavePath;
  end;
end;

procedure TJvParameterListSelectList.SaveParameterList(const ACaption: string = '');
var
  SavePath: string;
begin
  if not Assigned(ParameterList) then
    Exit;
  SavePath := ParameterList.AppStoragePath;
  try
    ParameterList.AppStoragePath := GetSelectListPath(sloStore, ACaption);
    if ParameterList.AppStoragePath <> '' then
    begin
      ParameterList.GetDataFromWinControls;
      ParameterList.StoreData;
    end;
  finally
    ParameterList.AppStoragePath := SavePath;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

