{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBActions.Pas, released on 2004-12-30.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBActions.pas,v 1.23 2005/03/13 21:58:51 jfudickar Exp $

unit JvDBActions;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF MSWINDOWS}
  Windows, ActnList, ImgList, Graphics,
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  QActnList, QWindows, QImgList, QGraphics,
  {$ENDIF UNIX}
  Forms, Controls, Classes, DB,
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  cxGridCustomTableView,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  {$IFDEF USE_3RDPARTY_SMEXPORT}
  SMEWIZ, ExportDS, SMEEngine,
  {$ENDIF USE_3RDPARTY_SMEXPORT}
  {$IFDEF USE_3RDPARTY_SMIMPORT}
  SMIWiz, SMIBase,
  {$ENDIF USE_3RDPARTY_SMIMPORT}
  JvPanel, JvDynControlEngineDB, JvDynControlEngineDBTools;

type
  TComponentClass = class of TComponent;

  TJvShowSingleRecordWindowOptions = class(TPersistent)
  private
    FDialogCaption: string;
    FPostButtonCaption: string;
    FCancelButtonCaption: string;
    FCloseButtonCaption: string;
    FBorderStyle: TFormBorderStyle;
    FPosition: TPosition;
    FTop: Integer;
    FLeft: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FArrangeConstraints: TSizeConstraints;
    FArrangeSettings: TJvArrangeSettings;
    FFieldCreateOptions: TJvCreateDBFieldsOnControlOptions;
  protected
    procedure SetArrangeSettings(Value: TJvArrangeSettings);
    procedure SetArrangeConstraints(Value: TSizeConstraints);
    procedure SetFieldCreateOptions(Value: TJvCreateDBFieldsOnControlOptions);
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetOptionsToDialog(ADialog: TJvDynControlDataSourceEditDialog);
  published
    property DialogCaption: string read FDialogCaption write FDialogCaption;
    property PostButtonCaption: string read FPostButtonCaption write FPostButtonCaption;
    property CancelButtonCaption: string read FCancelButtonCaption write FCancelButtonCaption;
    property CloseButtonCaption: string read FCloseButtonCaption write FCloseButtonCaption;
    property BorderStyle: TFormBorderStyle read FBorderStyle write FBorderStyle default bsDialog;
    property Position: TPosition read FPosition write FPosition default poScreenCenter;
    property Top: Integer read FTop write FTop default 0;
    property Left: Integer read FLeft write FLeft default 0;
    property Width: Integer read FWidth write FWidth default 640;
    property Height: Integer read FHeight write FHeight default 480;
    property ArrangeConstraints: TSizeConstraints read FArrangeConstraints write SetArrangeConstraints;
    property ArrangeSettings: TJvArrangeSettings read FArrangeSettings write SetArrangeSettings;
    property FieldCreateOptions: TJvCreateDBFieldsOnControlOptions read FFieldCreateOptions
      write SetFieldCreateOptions;
  end;

  TJvDatabaseActionList = class(TActionList)
  private
    FDataComponent: TComponent;
  protected
    procedure SetDataComponent(Value: TComponent);
  public
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property DataComponent: TComponent read FDataComponent write SetDataComponent;
  end;

  TJvDatabaseActionBaseEngine = class(TObject)
  protected
    function GetDataSource(ADataComponent: TComponent): TDataSource; virtual;
    function GetDataSet(ADataComponent: TComponent): TDataSet; virtual;
  public
    function Supports(ADataComponent: TComponent): Boolean; virtual;
    function IsActive(ADataComponent: TComponent): Boolean; virtual;
    function HasData(ADataComponent: TComponent): Boolean; virtual;
    function FieldCount(ADataComponent: TComponent): Integer; virtual;
    function RecordCount(ADataComponent: TComponent): Integer; virtual;
    function RecNo(ADataComponent: TComponent): Integer; virtual;
    function CanInsert(ADataComponent: TComponent): Boolean; virtual;
    function CanUpdate(ADataComponent: TComponent): Boolean; virtual;
    function CanDelete(ADataComponent: TComponent): Boolean; virtual;
    function Eof(ADataComponent: TComponent): Boolean; virtual;
    function Bof(ADataComponent: TComponent): Boolean; virtual;
    procedure DisableControls(ADataComponent: TComponent); virtual;
    procedure EnableControls(ADataComponent: TComponent); virtual;
    function ControlsDisabled(ADataComponent: TComponent): Boolean; virtual;
    function EditModeActive(ADataComponent: TComponent): Boolean; virtual;
    procedure First(ADataComponent: TComponent); virtual;
    procedure Last(ADataComponent: TComponent); virtual;
    procedure MoveBy(ADataComponent: TComponent; Distance: Integer); virtual;
    procedure ShowSingleRecordWindow(AOptions: TJvShowSingleRecordWindowOptions;
      ADataComponent: TComponent); virtual;
  end;

  TJvDatabaseActionBaseEngineClass = class of TJvDatabaseActionBaseEngine;

  TJvDatabaseActionDBGridEngine = class(TJvDatabaseActionBaseEngine)
  private
    FCurrentDataComponent: TComponent;
  protected
    function GetDataSource(ADataComponent: TComponent): TDataSource; override;
    procedure OnCreateDataControls(ADynControlEngineDB: TJvDynControlEngineDB;
      AParentControl: TWinControl; AFieldCreateOptions: TJvCreateDBFieldsOnControlOptions);
  public
    function Supports(ADataComponent: TComponent): Boolean; override;
    procedure ShowSingleRecordWindow(AOptions: TJvShowSingleRecordWindowOptions;
      ADataComponent: TComponent); override;
  end;

  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  TJvDatabaseActionDevExpCxGridEngine = class(TJvDatabaseActionBaseEngine)
  protected
    function GetGridView(ADataComponent: TComponent): TcxCustomGridTableView;
    function GetDataSource(ADataComponent: TComponent): TDataSource; override;
  public
    function Bof(ADataComponent: TComponent): Boolean; override;
    function RecNo(ADataComponent: TComponent): Integer; override;
    function RecordCount(ADataComponent: TComponent): Integer; override;
    function CanInsert(ADataComponent: TComponent): Boolean; override;
    function CanUpdate(ADataComponent: TComponent): Boolean; override;
    function CanDelete(ADataComponent: TComponent): Boolean; override;
    procedure First(ADataComponent: TComponent); override;
    procedure Last(ADataComponent: TComponent); override;
    procedure MoveBy(ADataComponent: TComponent; Distance: Integer); override;
    function Supports(ADataComponent: TComponent): Boolean; override;
  end;
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}

  TJvDatabaseExecuteEvent = procedure(Sender: TObject; DataEngine: TJvDatabaseActionBaseEngine;
    DataComponent: TComponent) of object;
  TJvDatabaseExecuteDataSourceEvent = procedure(Sender: TObject; DataSource: TDataSource) of object;

  TJvDatabaseBaseAction = class(TAction)
  private
    FOnExecute: TJvDatabaseExecuteEvent;
    FOnExecuteDataSource: TJvDatabaseExecuteDataSourceEvent;
    FDataEngine: TJvDatabaseActionBaseEngine;
    FDataComponent: TComponent;
  protected
    procedure SetDataComponent(Value: TComponent);
    procedure SetEnabled(Value: Boolean);
    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function EngineIsActive: Boolean;
    function EngineHasData: Boolean;
    function EngineFieldCount: Integer;
    function EngineRecordCount: Integer;
    function EngineRecNo: Integer;
    function EngineCanInsert: Boolean;
    function EngineCanUpdate: Boolean;
    function EngineCanDelete: Boolean;
    function EngineEof: Boolean;
    function EngineBof: Boolean;
    function EngineControlsDisabled: Boolean;
    function EngineEditModeActive: Boolean;
    property DataEngine: TJvDatabaseActionBaseEngine read FDataEngine;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property DataSource: TDataSource read GetDataSource;
    property DataSet: TDataSet read GetDataSet;
  published
    property OnExecute: TJvDatabaseExecuteEvent read FOnExecute write FOnExecute;
    property OnExecuteDataSource: TJvDatabaseExecuteDataSourceEvent
      read FOnExecuteDataSource write FOnExecuteDataSource;
    property DataComponent: TComponent read FDataComponent write SetDataComponent;
  end;

  TJvDatabaseSimpleAction = class(TJvDatabaseBaseAction)
  private
    FIsActive: Boolean;
    FHasData: Boolean;
    FCanInsert: Boolean;
    FCanUpdate: Boolean;
    FCanDelete: Boolean;
    FEditModeActive: Boolean;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property IsActive: Boolean read FIsActive write FIsActive default True;
    property HasData: Boolean read FHasData write FHasData default True;
    property CanInsert: Boolean read FCanInsert write FCanInsert default False;
    property CanUpdate: Boolean read FCanUpdate write FCanUpdate default False;
    property CanDelete: Boolean read FCanDelete write FCanDelete default False;
    property EditModeActive: Boolean read FEditModeActive write FEditModeActive default False;
  end;

  TJvDatabaseBaseActiveAction = class(TJvDatabaseBaseAction)
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

  TJvDatabaseBaseEditAction = class(TJvDatabaseBaseActiveAction)
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

  TJvDatabaseBaseNavigateAction = class(TJvDatabaseBaseActiveAction)
  end;

  TJvDatabaseFirstAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseLastAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabasePriorAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseNextAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabasePriorBlockAction = class(TJvDatabaseBaseNavigateAction)
  public
    FBlockSize: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property BlockSize: Integer read FBlockSize write FBlockSize default 50;
  end;

  TJvDatabaseNextBlockAction = class(TJvDatabaseBaseNavigateAction)
  private
    FBlockSize: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property BlockSize: Integer read FBlockSize write FBlockSize default 50;
  end;

  TJvDatabaseRefreshAction = class(TJvDatabaseBaseActiveAction)
  private
    FRefreshLastPosition: Boolean;
    FRefreshAsOpenClose: Boolean;
  protected
    procedure Refresh;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property RefreshLastPosition: Boolean read FRefreshLastPosition write FRefreshLastPosition default True;
    property RefreshAsOpenClose: Boolean read FRefreshAsOpenClose write FRefreshAsOpenClose default False;
  end;

  TJvDatabasePositionAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure ShowPositionDialog;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseInsertAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseOnCopyRecord = procedure(Field: TField; OldValue: Variant) of object;
  TJvDatabaseBeforeCopyRecord = procedure(DataSet: TDataSet; var RefreshAllowed: Boolean) of object;
  TJvDatabaseAfterCopyRecord = procedure(DataSet: TDataSet) of object;

  TJvDatabaseCopyAction = class(TJvDatabaseBaseEditAction)
  private
    FBeforeCopyRecord: TJvDatabaseBeforeCopyRecord;
    FAfterCopyRecord: TJvDatabaseAfterCopyRecord;
    FOnCopyRecord: TJvDatabaseOnCopyRecord;
  public
    procedure CopyRecord;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property BeforeCopyRecord: TJvDatabaseBeforeCopyRecord read FBeforeCopyRecord write FBeforeCopyRecord;
    property AfterCopyRecord: TJvDatabaseAfterCopyRecord read FAfterCopyRecord write FAfterCopyRecord;
    property OnCopyRecord: TJvDatabaseOnCopyRecord read FOnCopyRecord write FOnCopyRecord;
  end;

  TJvDatabaseEditAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseDeleteAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabasePostAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseCancelAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseSingleRecordWindowAction = class(TJvDatabaseBaseActiveAction)
  private
    FOptions: TJvShowSingleRecordWindowOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Options: TJvShowSingleRecordWindowOptions read FOptions write FOptions;
  end;

  TJvDatabaseOpenAction = class(TJvDatabaseBaseActiveAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseCloseAction = class(TJvDatabaseBaseActiveAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  {$IFDEF USE_3RDPARTY_SMEXPORT}

  TJvDatabaseSMExportOptions = class(TPersistent)
  private
    FHelpContext: THelpContext;
    FFormats: TExportFormatTypes;
    FTitle: TCaption;
    FDefaultOptionsDirectory: string;
    FKeyGenerator: string;
    FOptions: TSMOptions;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SMEWizardDlgGetCellParams(Sender: TObject; Field: TField; var Text: string;
      AFont: TFont; var Alignment: TAlignment; var Background: TColor; var CellType: TCellType);
    procedure SMEWizardDlgOnBeforeExecute(Sender: TObject);
  published
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property Formats: TExportFormatTypes read FFormats write FFormats;
    property Title: TCaption read FTitle write FTitle;
    property DefaultOptionsDirectory: string read FDefaultOptionsDirectory write FDefaultOptionsDirectory;
    property KeyGenerator: string read FKeyGenerator write FKeyGenerator;
    property Options: TSMOptions read FOptions write FOptions;
  end;

  TJvDatabaseSMExportAction = class(TJvDatabaseBaseActiveAction)
  private
    FOptions: TJvDatabaseSMExportOptions;
  protected
    procedure ExportData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Options: TJvDatabaseSMExportOptions read FOptions write FOptions;
  end;

  {$ENDIF USE_3RDPARTY_SMEXPORT}

  {$IFDEF USE_3RDPARTY_SMIMPORT}

  TJvDatabaseSMImportOptions = class(TPersistent)
  private
    FHelpContext: THelpContext;
    FFormats: TImportFormatTypes;
    FTitle: TCaption;
    FDefaultOptionsDirectory: string;
    FOptions: TSMIOptions;
    FWizardStyle: TSMIWizardStyle;
  public
    constructor Create;
  published
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property Formats: TImportFormatTypes read FFormats write FFormats;
    property Title: TCaption read FTitle write FTitle;
    property DefaultOptionsDirectory: string read FDefaultOptionsDirectory write FDefaultOptionsDirectory;
    property Options: TSMIOptions read FOptions write FOptions;
    property WizardStyle: TSMIWizardStyle read FWizardStyle write FWizardStyle;
  end;

  TJvDatabaseSMImportAction = class(TJvDatabaseBaseActiveAction)
  private
    FOptions: TJvDatabaseSMImportOptions;
  protected
    procedure ImportData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Options: TJvDatabaseSMImportOptions read FOptions write FOptions;
  end;

  {$ENDIF USE_3RDPARTY_SMIMPORT}

  TJvDatabaseActionEngineList = class(TList)
  public
    destructor Destroy; override;
    procedure RegisterEngine(AEngineClass: TJvDatabaseActionBaseEngineClass);
    function GetEngine(AComponent: TComponent): TJvDatabaseActionBaseEngine;
    function Supports(AComponent: TComponent): Boolean;
  end;

procedure RegisterActionEngine(AEngineClass: TJvDatabaseActionBaseEngineClass);

function RegisteredDatabaseActionEngineList: TJvDatabaseActionEngineList;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvDBActions.pas,v $';
    Revision: '$Revision: 1.23 $';
    Date: '$Date: 2005/03/13 21:58:51 $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, DBGrids, Grids,
  {$IFDEF HAS_UNIT_STRUTILS}
  StrUtils,
  {$ENDIF HAS_UNIT_STRUTILS}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  cxGrid, cxGridDBDataDefinitions,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  {$IFDEF USE_3RDPARTY_SMEXPORT}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEEngCx, 
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  sme2sql, IniFiles,
  {$ENDIF USE_3RDPARTY_SMEXPORT}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  cxCustomData,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  JvResources, JvParameterList, JvParameterListParameter, TypInfo;

var
  IntRegisteredActionEngineList: TJvDatabaseActionEngineList;

//=== { TJvDatabaseActionList } ==============================================

procedure TJvDatabaseActionList.SetDataComponent(Value: TComponent);
var
  I: Integer;
begin
  FDataComponent := Value;
  if FDataComponent <> nil then
    FDataComponent.FreeNotification(Self);
  for I := 0 to ActionCount - 1 do
    if Actions[I] is TJvDatabaseBaseAction then
      TJvDatabaseBaseAction(Actions[I]).DataComponent := Value;
end;

procedure TJvDatabaseActionList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FDataComponent then
      DataComponent := nil;
end;

//=== { TJvShowSingleRecordWindowOptions } ===================================

constructor TJvShowSingleRecordWindowOptions.Create;
begin
  inherited Create;
  FDialogCaption := '';
  FPostButtonCaption := RsSRWPostButtonCaption;
  FCancelButtonCaption := RsSRWCancelButtonCaption;
  FCloseButtonCaption := RsSRWCloseButtonCaption;
  FBorderStyle := bsDialog;
  FTop := 0;
  FLeft := 0;
  FWidth := 640;
  FHeight := 480;
  FPosition := poScreenCenter;
  FArrangeSettings := TJvArrangeSettings.Create(nil);
  with FArrangeSettings do
  begin
    AutoSize := asBoth;
    DistanceHorizontal := 3;
    DistanceVertical := 3;
    BorderLeft := 3;
    BorderTop := 3;
    WrapControls := True;
  end;
  FArrangeConstraints := TSizeConstraints.Create(nil);
  FArrangeConstraints.MaxHeight := 480;
  FArrangeConstraints.MaxWidth := 640;
  FFieldCreateOptions := TJvCreateDBFieldsOnControlOptions.Create;
end;

destructor TJvShowSingleRecordWindowOptions.Destroy;
begin
  FFieldCreateOptions.Free;
  FArrangeConstraints.Free;
  FArrangeSettings.Free;
  inherited Destroy;
end;

procedure TJvShowSingleRecordWindowOptions.SetArrangeSettings(Value: TJvArrangeSettings);
begin
  FArrangeSettings.Assign(Value);
end;

procedure TJvShowSingleRecordWindowOptions.SetArrangeConstraints(Value: TSizeConstraints);
begin
  FArrangeConstraints.Assign(Value);
end;

procedure TJvShowSingleRecordWindowOptions.SetFieldCreateOptions(Value: TJvCreateDBFieldsOnControlOptions);
begin
  FFieldCreateOptions.Assign(Value);
end;

procedure TJvShowSingleRecordWindowOptions.SetOptionsToDialog(ADialog: TJvDynControlDataSourceEditDialog);
begin
  if Assigned(ADialog) then
  begin
    ADialog.DialogCaption := DialogCaption;
    ADialog.PostButtonCaption := PostButtonCaption;
    ADialog.CancelButtonCaption := CancelButtonCaption;
    ADialog.CloseButtonCaption := CloseButtonCaption;
    ADialog.Position := Position;
    ADialog.BorderStyle := BorderStyle;
    ADialog.Top := Top;
    ADialog.Left := Left;
    ADialog.Width := Width;
    ADialog.Height := Height;
    ADialog.ArrangeConstraints := ArrangeConstraints;
    ADialog.ArrangeSettings := ArrangeSettings;
    ADialog.FieldCreateOptions := FieldCreateOptions;
  end;
end;

//=== { TJvDatabaseActionBaseEngine } ========================================

function TJvDatabaseActionBaseEngine.GetDataSource(ADataComponent: TComponent): TDataSource;
begin
  if Assigned(ADataComponent) and (ADataComponent is TDataSource) then
    Result := TDataSource(ADataComponent)
  else
    Result := nil;
end;

function TJvDatabaseActionBaseEngine.GetDataSet(ADataComponent: TComponent): TDataSet;
begin
  if Assigned(GetDataSource(ADataComponent)) then
    Result := GetDataSource(ADataComponent).DataSet
  else
    Result := nil;
end;

function TJvDatabaseActionBaseEngine.Supports(ADataComponent: TComponent): Boolean;
begin
  Result := Assigned(ADataComponent) and (ADataComponent is TDataSource);
end;

function TJvDatabaseActionBaseEngine.IsActive(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.Active
  else
    Result := False;
end;

function TJvDatabaseActionBaseEngine.HasData(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.RecordCount > 0
  else
    Result := False;
end;

function TJvDatabaseActionBaseEngine.FieldCount(ADataComponent: TComponent): Integer;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.FieldCount
  else
    Result := -1;
end;

function TJvDatabaseActionBaseEngine.RecordCount(ADataComponent: TComponent): Integer;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.RecordCount
  else
    Result := -1;
end;

function TJvDatabaseActionBaseEngine.RecNo(ADataComponent: TComponent): Integer;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.RecNo
  else
    Result := -1;
end;

function TJvDatabaseActionBaseEngine.CanInsert(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.CanModify
  else
    Result := False;
end;

function TJvDatabaseActionBaseEngine.CanUpdate(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.CanModify
  else
    Result := False;
end;

function TJvDatabaseActionBaseEngine.CanDelete(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.CanModify
  else
    Result := False;
end;


function TJvDatabaseActionBaseEngine.Eof(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.Eof
  else
    Result := False;
end;

function TJvDatabaseActionBaseEngine.Bof(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.Bof
  else
    Result := False;
end;

procedure TJvDatabaseActionBaseEngine.DisableControls(ADataComponent: TComponent);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    DataSet.DisableControls;
end;

procedure TJvDatabaseActionBaseEngine.EnableControls(ADataComponent: TComponent);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    DataSet.EnableControls;
end;

function TJvDatabaseActionBaseEngine.ControlsDisabled(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.ControlsDisabled
  else
    Result := False;
end;

function TJvDatabaseActionBaseEngine.EditModeActive(ADataComponent: TComponent): Boolean;
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    Result := DataSet.State in [dsInsert, dsEdit]
  else
    Result := False;
end;

procedure TJvDatabaseActionBaseEngine.First(ADataComponent: TComponent);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    DataSet.First;
end;

procedure TJvDatabaseActionBaseEngine.Last(ADataComponent: TComponent);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    DataSet.Last;
end;

procedure TJvDatabaseActionBaseEngine.MoveBy(ADataComponent: TComponent; Distance: Integer);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(ADataComponent);
  if Assigned(DataSet) then
    DataSet.MoveBy(Distance);
end;

procedure TJvDatabaseActionBaseEngine.ShowSingleRecordWindow(AOptions: TJvShowSingleRecordWindowOptions;
  ADataComponent: TComponent);
var
  Dialog: TJvDynControlDataSourceEditDialog;
begin
  Dialog := TJvDynControlDataSourceEditDialog.Create;
  try
    AOptions.SetOptionsToDialog(Dialog);
    if Dialog.DynControlEngineDB.SupportsDataComponent(ADataComponent) then
      Dialog.DataComponent := ADataComponent
    else
      Dialog.DataComponent := GetDataSource(ADataComponent);
    Dialog.ShowDialog;
  finally
    Dialog.Free;
  end;
end;

//=== { TJvDatabaseActionDBGridEngine } ======================================

function TJvDatabaseActionDBGridEngine.GetDataSource(ADataComponent: TComponent): TDataSource;
begin
  if Assigned(ADataComponent) and (ADataComponent is TCustomDBGrid) then
    Result := TCustomDBGrid(ADataComponent).DataSource
  else
    Result := nil;
end;

type
  TAccessCustomDBGrid = class(TCustomDBGrid);
  TAccessCustomControl = class(TCustomControl);

procedure TJvDatabaseActionDBGridEngine.OnCreateDataControls(ADynControlEngineDB: TJvDynControlEngineDB;
  AParentControl: TWinControl; AFieldCreateOptions: TJvCreateDBFieldsOnControlOptions);
var
  I: Integer;
  ds: TDataSource;
  Field: TField;
  LabelControl: TControl;
  Control: TWinControl;
  Column: TColumn;
begin
  if Assigned(FCurrentDataComponent) and (FCurrentDataComponent is TCustomDBGrid) then
  begin
    ds := GetDataSource(FCurrentDataComponent);
    with AFieldCreateOptions do
      for I := 0 to TAccessCustomDBGrid(FCurrentDataComponent).ColCount - 2 do
      begin
        Column := TAccessCustomDBGrid(FCurrentDataComponent).Columns[I];
        if Column.Visible or ShowInvisibleFields then
        begin
          Field := Column.Field;
          Control := ADynControlEngineDB.CreateDBFieldControl(Field, AParentControl, AParentControl, '', ds);
          if FieldDefaultWidth > 0 then
            Control.Width := FieldDefaultWidth
          else
          begin
            if UseFieldSizeForWidth then
              if Field.Size > 0 then
                Control.Width :=
                  TAccessCustomControl(AParentControl).Canvas.TextWidth('X') * Field.Size
              else
            else
              if Field.DisplayWidth > 0 then
                Control.Width :=
                  TAccessCustomControl(AParentControl).Canvas.TextWidth('X') * Field.DisplayWidth;
            if (FieldMaxWidth > 0) and (Control.Width > FieldMaxWidth) then
              Control.Width := FieldMaxWidth
            else
            if (FieldMinWidth > 0) and (Control.Width < FieldMinWidth) then
              Control.Width := FieldMinWidth;
          end;
          if UseParentColorForReadOnly then
            if (Assigned(ds.DataSet) and not ds.DataSet.CanModify) or Field.ReadOnly then
              if isPublishedProp(Control, 'ParentColor') then
                SetOrdProp(Control, 'ParentColor', Ord(True));
          LabelControl := ADynControlEngineDB.DynControlEngine.CreateLabelControlPanel(AParentControl, AParentControl,
            '', '&' + Column.Title.Caption, Control, True, 0);
          if FieldWidthStep > 0 then
            if (LabelControl.Width mod FieldWidthStep) <> 0 then
              LabelControl.Width := ((LabelControl.Width div FieldWidthStep) + 1) * FieldWidthStep;
        end;
      end;
  end;
end;

function TJvDatabaseActionDBGridEngine.Supports(ADataComponent: TComponent): Boolean;
begin
  Result := Assigned(ADataComponent) and (ADataComponent is TCustomDBGrid);
end;

procedure TJvDatabaseActionDBGridEngine.ShowSingleRecordWindow(AOptions: TJvShowSingleRecordWindowOptions;
  ADataComponent: TComponent);
var
  Dialog: TJvDynControlDataSourceEditDialog;
begin
  Dialog := TJvDynControlDataSourceEditDialog.Create;
  try
    AOptions.SetOptionsToDialog(Dialog);
    FCurrentDataComponent := ADataComponent;
    if Dialog.DynControlEngineDB.SupportsDataComponent(ADataComponent) then
      Dialog.DataComponent := ADataComponent
    else
      Dialog.DataComponent := GetDataSource(ADataComponent);
    Dialog.OnCreateDataControlsEvent := OnCreateDataControls;
    Dialog.ShowDialog;
  finally
    Dialog.Free;
  end;
end;

//=== { TJvDatabaseActionDevExpCxGridEngine } ================================

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}

function TJvDatabaseActionDevExpCxGridEngine.GetGridView(ADataComponent: TComponent): TcxCustomGridTableView;
begin
  if Assigned(ADataComponent) then
    if ADataComponent is TcxGrid then
      if TcxGrid(ADataComponent).FocusedView is TcxCustomGridTableView then
        Result := TcxCustomGridTableView(TcxGrid(ADataComponent).FocusedView)
      else
        Result := nil
    else
    if ADataComponent is TcxCustomGridTableView then
      Result := TcxCustomGridTableView(ADataComponent)
    else
      Result := nil
  else
    Result := nil;
end;

function TJvDatabaseActionDevExpCxGridEngine.GetDataSource(ADataComponent: TComponent): TDataSource;
begin
  if Assigned(ADataComponent) then
    if ADataComponent is TcxGrid then
      if (TcxGrid(ADataComponent).FocusedView is TcxCustomGridTableView) and
        (TcxCustomGridTableView(TcxGrid(ADataComponent).FocusedView).DataController is TcxGridDBDataController) then
        Result := TcxGridDBDataController(TcxCustomGridTableView(
          TcxGrid(ADataComponent).FocusedView).DataController).DataSource
      else
        Result := nil
    else
    if ADataComponent is TcxCustomGridTableView then
      if TcxCustomGridTableView(ADataComponent).DataController is TcxGridDBDataController then
        Result := TcxGridDBDataController(TcxCustomGridTableView(ADataComponent).DataController).DataSource
      else
        Result := nil
    else
      Result := inherited GetDataSource(ADataComponent)
  else
    Result := nil;
end;

function TJvDatabaseActionDevExpCxGridEngine.Supports(ADataComponent: TComponent): Boolean;
begin
  Result := Assigned(GetGridView(ADataComponent));
end;

function TJvDatabaseActionDevExpCxGridEngine.Bof(ADataComponent: TComponent): Boolean;
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    Result := View.DataController.FocusedRowIndex = 0
  else
    Result := inherited Bof(ADataComponent);
end;

function TJvDatabaseActionDevExpCxGridEngine.RecNo(ADataComponent: TComponent): Integer;
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    Result := View.DataController.FocusedRowIndex+1
  else
    Result := inherited RecNo(ADataComponent);
end;

function TJvDatabaseActionDevExpCxGridEngine.RecordCount(ADataComponent: TComponent): Integer;
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    Result := View.DataController.RecordCount
  else
    Result := inherited RecordCount(ADataComponent);
end;


function TJvDatabaseActionDevExpCxGridEngine.CanInsert(ADataComponent: TComponent): Boolean;
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    Result := View.OptionsData.Inserting and inherited CanInsert(ADataComponent)
  else
    Result := inherited CanInsert(ADataComponent);
end;

function TJvDatabaseActionDevExpCxGridEngine.CanUpdate(ADataComponent: TComponent): Boolean;
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    Result := View.OptionsData.Editing and inherited CanUpdate(ADataComponent)
  else
    Result := inherited CanUpdate(ADataComponent);
end;

function TJvDatabaseActionDevExpCxGridEngine.CanDelete(ADataComponent: TComponent): Boolean;
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    Result := View.OptionsData.Deleting and inherited CanDelete(ADataComponent)
  else
    Result := inherited CanDelete(ADataComponent);
end;

procedure TJvDatabaseActionDevExpCxGridEngine.First(ADataComponent: TComponent);
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    View.DataController.GotoFirst;
end;

procedure TJvDatabaseActionDevExpCxGridEngine.Last(ADataComponent: TComponent);
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    View.DataController.GotoLast;
end;

procedure TJvDatabaseActionDevExpCxGridEngine.MoveBy(ADataComponent: TComponent; Distance: Integer);
var
  View: TcxCustomGridTableView;
begin
  View := GetGridView(ADataComponent);
  if Assigned(View) then
    View.DataController.MoveBy(Distance)
end;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}

//=== { TJvDatabaseBaseAction } ==============================================

constructor TJvDatabaseBaseAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if Assigned(AOwner) and (AOwner is TJvDatabaseActionList) then
    DataComponent := TJvDatabaseActionList(AOwner).DataComponent;
end;

function TJvDatabaseBaseAction.GetDataSet: TDataSet;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.GetDataSet(DataComponent)
  else
    Result := nil;
end;

function TJvDatabaseBaseAction.GetDataSource: TDataSource;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.GetDataSource(DataComponent)
  else
    Result := nil;
end;

procedure TJvDatabaseBaseAction.SetDataComponent(Value: TComponent);
begin
  FDataComponent := Value;
  if FDataComponent <> nil then
    FDataComponent.FreeNotification(Self);
  if Assigned(IntRegisteredActionEngineList) then
    FDataEngine := IntRegisteredActionEngineList.GetEngine(FDataComponent)
  else
    FDataEngine := nil;
end;

procedure TJvDatabaseBaseAction.SetEnabled(Value: Boolean);
begin
  if Enabled <> Value then
    Enabled := Value;
end;

function TJvDatabaseBaseAction.EngineIsActive: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.IsActive(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineHasData: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.HasData(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineFieldCount: Integer;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.FieldCount(DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.EngineRecordCount: Integer;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.RecordCount(DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.EngineRecNo: Integer;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.RecNo(DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.EngineCanInsert: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.CanInsert(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineCanUpdate: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.CanUpdate(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineCanDelete: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.CanDelete(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineEof: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.Eof(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineBof: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.Bof(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineControlsDisabled: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.ControlsDisabled(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineEditModeActive: Boolean;
begin
  if Assigned(DataEngine) then
    Result := DataEngine.EditModeActive(DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.HandlesTarget(Target: TObject): Boolean;
begin
  //  Result := inherited HandlesTarget(Target);
  Result := Assigned(DataEngine);
end;

procedure TJvDatabaseBaseAction.UpdateTarget(Target: TObject);
begin
  if Assigned(DataSet) and not EngineControlsDisabled then
    SetEnabled(True)
  else
    SetEnabled(False);
end;

procedure TJvDatabaseBaseAction.ExecuteTarget(Target: TObject);
begin
  if Assigned(FOnExecute) then
    FOnExecute(Self, DataEngine, DataComponent)
  else
  if Assigned(FOnExecuteDataSource) then
    FOnExecuteDataSource(Self, DataSource)
  else
    inherited ExecuteTarget(Target);
end;

procedure TJvDatabaseBaseAction.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

//=== { TJvDatabaseSimpleAction } ============================================

constructor TJvDatabaseSimpleAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsActive := True;
  FHasData := True;
  FCanInsert := False;
  FCanUpdate := False;
  FCanDelete := False;
  FEditModeActive := False;
end;

procedure TJvDatabaseSimpleAction.UpdateTarget(Target: TObject);
var
  Res: Boolean;
begin
  if Assigned(DataSet) and not EngineControlsDisabled then
  begin
    Res := False;
    if IsActive then
      Res := Res and EngineIsActive;
    if HasData then
      Res := Res and EngineHasData;
    if CanInsert then
      Res := Res and EngineCanInsert;
    if CanUpdate then
      Res := Res and EngineCanUpdate;
    if CanDelete then
      Res := Res and EngineCanDelete;
    if EditModeActive then
      Res := Res and EngineEditModeActive;
    SetEnabled(Res)
  end
  else
    SetEnabled(False);
end;

//=== { TJvDatabaseBaseActiveAction } ========================================

procedure TJvDatabaseBaseActiveAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive);
end;

//=== { TJvDatabaseBaseEditAction } ==========================================

procedure TJvDatabaseBaseEditAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and (EngineCanInsert or EngineCanUpdate or EngineCanDelete));
end;

//=== { TJvDatabaseFirstAction } =============================================

procedure TJvDatabaseFirstAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataEngine) and not EngineControlsDisabled and EngineIsActive and not EngineBof);
end;

procedure TJvDatabaseFirstAction.ExecuteTarget(Target: TObject);
begin
  DataEngine.First(DataComponent);
end;

//=== { TJvDatabaseLastAction } ==============================================

procedure TJvDatabaseLastAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataEngine) and not EngineControlsDisabled and EngineIsActive and not EngineEof);
end;

procedure TJvDatabaseLastAction.ExecuteTarget(Target: TObject);
begin
  DataEngine.Last(DataComponent);
end;

//=== { TJvDatabasePriorAction } =============================================

procedure TJvDatabasePriorAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataEngine) and not EngineControlsDisabled and EngineIsActive and not EngineBof);
end;

procedure TJvDatabasePriorAction.ExecuteTarget(Target: TObject);
begin
  DataEngine.MoveBy(DataComponent, -1);
end;

//=== { TJvDatabaseNextAction } ==============================================

procedure TJvDatabaseNextAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataEngine) and not EngineControlsDisabled and EngineIsActive and not EngineEof);
end;

procedure TJvDatabaseNextAction.ExecuteTarget(Target: TObject);
begin
  DataEngine.MoveBy(DataComponent, 1);
end;

//=== { TJvDatabasePriorBlockAction } ========================================

constructor TJvDatabasePriorBlockAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBlockSize := 50;
end;

procedure TJvDatabasePriorBlockAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataEngine) and not EngineControlsDisabled and EngineIsActive and not EngineBof);
end;

procedure TJvDatabasePriorBlockAction.ExecuteTarget(Target: TObject);
begin
  with DataEngine do
    try
      DisableControls(DataComponent);
      MoveBy(DataComponent, -BlockSize);
    finally
      EnableControls(DataComponent);
  end;
end;

//=== { TJvDatabaseNextBlockAction } =========================================

constructor TJvDatabaseNextBlockAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBlockSize := 50;
end;

procedure TJvDatabaseNextBlockAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataEngine) and not EngineControlsDisabled and EngineIsActive and not EngineEof);
end;

procedure TJvDatabaseNextBlockAction.ExecuteTarget(Target: TObject);
begin
  with DataEngine do
    try
      DisableControls(DataComponent);
      MoveBy(DataComponent, BlockSize);
    finally
      EnableControls(DataComponent);
    end;
end;

//=== { TJvDatabaseRefreshAction } ===========================================

constructor TJvDatabaseRefreshAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRefreshLastPosition := True;
  FRefreshAsOpenClose := False;
end;

procedure TJvDatabaseRefreshAction.ExecuteTarget(Target: TObject);
begin
  Refresh;
end;

procedure TJvDatabaseRefreshAction.Refresh;
var
  MyBookmark: TBookmark;
begin
  with DataEngine.GetDataSet(DataComponent) do
  begin
    MyBookmark := nil;
    if RefreshLastPosition then
      MyBookmark := GetBookmark;

    try
      if RefreshAsOpenClose then
      begin
        Close;
        Open;
      end
      else
        Refresh;

      if RefreshLastPosition then
        if Active then
          if Assigned(MyBookmark) then
            if BookmarkValid(MyBookmark) then
            try
              GotoBookmark(MyBookmark);
            except
            end;
    finally
      if RefreshLastPosition then
        FreeBookmark(MyBookmark);
    end;
  end;
end;

//=== { TJvDatabasePositionAction } ==========================================

procedure TJvDatabasePositionAction.UpdateTarget(Target: TObject);
const
  cFormat = ' %3d / %3d ';
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and EngineHasData);
  try
    if not EngineIsActive then
      Caption := Format(cFormat, [0, 0])
    else
    if EngineRecordCount = 0 then
      Caption := Format(cFormat, [0, 0])
    else
      Caption := Format(cFormat, [EngineRecNo, EngineRecordCount]);
  except
    Caption := Format(cFormat, [0, 0]);
  end;
end;

procedure TJvDatabasePositionAction.ExecuteTarget(Target: TObject);
begin
  ShowPositionDialog;
end;

procedure TJvDatabasePositionAction.ShowPositionDialog;
const
  cCurrentPosition = 'CurrentPosition';
  cNewPosition = 'NewPosition';
  cKind = 'Kind';
var
  ParameterList: TJvParameterList;
  Parameter: TJvBaseParameter;
  S: string;
  Kind: Integer;
begin
  if not Assigned(DataSet) then
    Exit;
  ParameterList := TJvParameterList.Create(Self);
  try
    Parameter := TJvBaseParameter(TJvEditParameter.Create(ParameterList));
    with TJvEditParameter(Parameter) do
    begin
      SearchName := cCurrentPosition;
      ReadOnly := True;
      Caption := RsDBPosCurrentPosition;
      AsString := IntToStr(EngineRecNo + 1) + ' / ' + IntToStr(EngineRecordCount);
      Width := 150;
      LabelWidth := 80;
      Enabled := False;
    end;
    ParameterList.AddParameter(Parameter);
    Parameter := TJvBaseParameter(TJvEditParameter.Create(ParameterList));
    with TJvEditParameter(Parameter) do
    begin
      Caption := RsDBPosNewPosition;
      SearchName := cNewPosition;
      // EditMask := '999999999;0;_';
      Width := 150;
      LabelWidth := 80;
    end;
    ParameterList.AddParameter(Parameter);
    Parameter := TJvBaseParameter(TJvRadioGroupParameter.Create(ParameterList));
    with TJvRadioGroupParameter(Parameter) do
    begin
      Caption := RsDBPosMovementType;
      SearchName := cKind;
      Width := 305;
      Height := 54;
      Columns := 2;
      ItemList.Add(RsDBPosAbsolute);
      ItemList.Add(RsDBPosForward);
      ItemList.Add(RsDBPosBackward);
      ItemList.Add(RsDBPosPercental);
      ItemIndex := 0;
    end;
    ParameterList.AddParameter(Parameter);
    ParameterList.ArrangeSettings.WrapControls := True;
    ParameterList.ArrangeSettings.MaxWidth := 350;
    ParameterList.Messages.Caption := RsDBPosDialogCaption;
    if ParameterList.ShowParameterDialog then
    begin
      S := ParameterList.ParameterByName(cNewPosition).AsString;
      if S = '' then
        Exit;
      Kind := TJvRadioGroupParameter(ParameterList.ParameterByName(cKind)).ItemIndex;
      DataSet.DisableControls;
      try
        case Kind of
          0:
            begin
              DataSet.First;
              DataSet.MoveBy(StrToInt(S) - 1);
            end;
          1:
            DataSet.MoveBy(StrToInt(S));
          2:
            DataSet.MoveBy(StrToInt(S) * -1);
          3:
            begin
              DataSet.First;
              DataSet.MoveBy(Round((EngineRecordCount / 100.0) * StrToInt(S)) - 1);
            end;
        end;
      finally
        DataSet.EnableControls;
      end;
    end;
  finally
    ParameterList.Free;
  end;
end;

//=== { TJvDatabaseInsertAction } ============================================

procedure TJvDatabaseInsertAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and
    EngineIsActive and EngineCanInsert and not EngineEditModeActive);
end;

procedure TJvDatabaseInsertAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Insert;
end;

//=== { TJvDatabaseCopyAction } ==============================================

procedure TJvDatabaseCopyAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    EngineCanInsert and EngineHasData and not EngineEditModeActive);
end;

procedure TJvDatabaseCopyAction.ExecuteTarget(Target: TObject);
begin
  CopyRecord;
end;

procedure TJvDatabaseCopyAction.CopyRecord;
var
  Values: array of Variant;
  I: Integer;
  Value: Variant;
  Allowed: Boolean;
begin
  with DataSet do
  begin
    if not Active then
      Exit;
    if State in [dsInsert, dsEdit] then
      Post;
    if State <> dsBrowse then
      Exit;
    Allowed := True;
  end;
  if Assigned(FBeforeCopyRecord) then
    FBeforeCopyRecord(DataSet, Allowed);
  with DataSet do
  begin
    // (rom) this suppresses AfterCopyRecord. Is that desired?
    if not Allowed then
      Exit;
    SetLength(Values, FieldCount);
    for I := 0 to FieldCount - 1 do
      Values[I] := Fields[I].AsVariant;
    Insert;
    if Assigned(FOnCopyRecord) then
      for I := 0 to FieldCount - 1 do
      begin
        Value := Values[I];
        FOnCopyRecord(Fields[I], Value);
      end
    else
      for I := 0 to FieldCount - 1 do
        Fields[I].AsVariant := Values[I];
  end;
  if Assigned(FAfterCopyRecord) then
    FAfterCopyRecord(DataSet);
end;

//=== { TJvDatabaseEditAction } ==============================================

procedure TJvDatabaseEditAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    EngineCanUpdate and EngineHasData and not EngineEditModeActive);
end;

procedure TJvDatabaseEditAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Edit;
end;

//=== { TJvDatabaseDeleteAction } ============================================

procedure TJvDatabaseDeleteAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    EngineCanDelete and EngineHasData and not EngineEditModeActive);
end;

procedure TJvDatabaseDeleteAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Delete;
end;

//=== { TJvDatabasePostAction } ==============================================

procedure TJvDatabasePostAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and EngineEditModeActive);
end;

procedure TJvDatabasePostAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Post;
end;

//=== { TJvDatabaseCancelAction } ============================================

procedure TJvDatabaseCancelAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and EngineEditModeActive);
end;

procedure TJvDatabaseCancelAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Cancel;
end;

//=== { TJvDatabaseSingleRecordWindowAction } ================================

constructor TJvDatabaseSingleRecordWindowAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := TJvShowSingleRecordWindowOptions.Create;
end;

destructor TJvDatabaseSingleRecordWindowAction.Destroy;
begin
  FOptions.Free;
  inherited Destroy;
end;

procedure TJvDatabaseSingleRecordWindowAction.ExecuteTarget(Target: TObject);
begin
  DataEngine.ShowSingleRecordWindow(Options, DataComponent);
end;

//=== { TJvDatabaseOpenAction } ==============================================

procedure TJvDatabaseOpenAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineIsActive);
end;

procedure TJvDatabaseOpenAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Open;
end;

//=== { TJvDatabaseCloseAction } =============================================

procedure TJvDatabaseCloseAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and EngineIsActive and not EngineEditModeActive);
end;

procedure TJvDatabaseCloseAction.ExecuteTarget(Target: TObject);
begin
  DataSet.Close;
end;

{$IFDEF USE_3RDPARTY_SMEXPORT}

//=== { TJvDatabaseSMExportOptions } =========================================

constructor TJvDatabaseSMExportOptions.Create;
var
  Fmt: TTableTypeExport;
  Option: TSMOption;
begin
  inherited Create;
  FFormats := [];
  for Fmt := Low(Fmt) to High(Fmt) do
    FFormats := FFormats + [Fmt];
  FOptions := [];
  for Option := Low(Option) to High(Option) do
    FOptions := FOptions + [Option];
  //  FDataFormats := TSMEDataFormats.Create;
end;

destructor TJvDatabaseSMExportOptions.Destroy;
begin
  //  FreeAndNil(FDataFormats);
  inherited Destroy;
end;

procedure TJvDatabaseSMExportOptions.SMEWizardDlgGetCellParams(Sender: TObject; Field: TField;
  var Text: string; AFont: TFont; var Alignment: TAlignment; var Background: TColor; var CellType: TCellType);
const
  SToDateFormatLong = 'TO_DATE(''%s'', ''DD.MM.YYYY HH24:MI:SS'')';
  SToDateFormatShort = 'TO_DATE(''%s'', ''DD.MM.YYYY'')';
  SFormatLong = 'dd.mm.yyyy hh:nn:ss';
  SFormatShort = 'dd.mm.yyyy';
  SNull = 'NULL';
var
  DT: TDateTime;
begin
  if Sender is TSMExportToSQL then
    if Assigned(Field) then
    begin
      if Field.IsNull or (Field.AsString = '') then
      begin
        Text := SNull;
        CellType := ctBlank;
      end
      else
      if Field.DataType in [ftFloat, ftBCD, ftCurrency] then
        Text := AnsiReplaceStr(Text, ',', '.')
      else
      if Field.DataType in [ftDate, ftDateTime] then
      begin
        DT := Field.AsDateTime;
        if DT <= 0 then
          Text := SNull
        else
        if DT = Trunc(DT) then
          Text := Format(SToDateFormatShort, [FormatDateTime(SFormatShort, DT)])
      else
        Text := Format(StoDateFormatLong, [FormatDateTime(SFormatLong, DT)]);
        CellType := ctBlank;
      end
      else
      if Field.DataType in [ftString, ftWideString] then
        Text := '''' + AnsiReplaceStr(Text, '''', '''''') + '''';
    end
    else
    if Text = '' then
    begin
      Text := SNull;
      CellType := ctBlank;
    end
    else
    if CellType in [ctDouble, ctCurrency] then
      Text := AnsiReplaceStr(Text, ',', '.')
    else
    if CellType in [ctDateTime, ctDate, ctTime] then
    begin
      DT := StrToDate(Text);
      if DT <= 0 then
        Text := SNull
      else
      if DT = Trunc(DT) then
        Text := Format(SToDateFormatShort, [FormatDateTime(SFormatShort, DT)])
      else
        Text := Format(StoDateFormatLong, [FormatDateTime(SFormatLong, DT)]);
      CellType := ctBlank;
    end
    else
    if CellType in [ctString] then
      Text := '''' + AnsiReplaceStr(Text, '''', '''''') + ''''
end;

procedure TJvDatabaseSMExportOptions.SMEWizardDlgOnBeforeExecute(Sender: TObject);
begin
  if Sender is TSMExportToSQL then
    TSMExportToSQL(Sender).SQLQuote := #0;
end;

//=== { TJvDatabaseSMExportAction } ==========================================

constructor TJvDatabaseSMExportAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := TJvDatabaseSMExportOptions.Create;
end;

destructor TJvDatabaseSMExportAction.Destroy;
begin
  FOptions.Free;
  inherited Destroy;
end;

procedure TJvDatabaseSMExportAction.ExecuteTarget(Target: TObject);
begin
  ExportData;
end;

procedure TJvDatabaseSMExportAction.ExportData;
var
  SMEWizardDlg: TSMEWizardDlg;
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEEngineCx: TSMEcxCustomGridTableViewDataEngine;
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
begin
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEEngineCx := nil;
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEWizardDlg := TSMEWizardDlg.Create(Self);
  try
    SMEWizardDlg.ColumnSource := csDataSet;
    SMEWizardDlg.OnGetCellParams := Options.SMEWizardDlgGetCellParams;
    SMEWizardDlg.OnBeforeExecute := Options.SMEWizardDlgOnBeforeExecute;
    SMEWizardDlg.DataSet := DataSource.DataSet;
    SMEWizardDlg.Title := Options.Title;
    SMEWizardDlg.KeyGenerator := Options.Title;
    SMEWizardDlg.WizardStyle := smewiz.wsWindows2000;
    SMEWizardDlg.SpecificationDir := Options.DefaultOptionsDirectory + '\';
    if DataComponent is TCustomDBGrid then
    begin
      SMEWizardDlg.DBGrid := TCustomControl(DataComponent);
      SMEWizardDlg.ColumnSource := csDBGrid;
    end
    {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    else
    if (DataComponent is TcxGrid) and (TcxGrid(DataComponent).FocusedView is TcxCustomGridTableView) then
    begin
      SMEEnginecx := TSMEcxCustomGridTableViewDataEngine.Create(Self);
      SMEEngineCx.cxCustomGridTableView := TcxCustomGridTableView(TcxGrid(DataComponent).FocusedView);
      SMEWizardDlg.DataEngine := SMEEngineCx;
      SMEWizardDlg.ColumnSource := csDataEngine;
    end
    else
    if DataComponent is TcxCustomGridTableView then
    begin
      SMEEnginecx := TSMEcxCustomGridTableViewDataEngine.Create(Self);
      SMEEngineCx.cxCustomGridTableView := TcxCustomGridTableView(DataComponent);
      SMEWizardDlg.DataEngine := SMEEngineCx;
      SMEWizardDlg.ColumnSource := csDataEngine;
    end
    {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    else
    begin
      SMEWizardDlg.DataSet := DataSet;
      SMEWizardDlg.ColumnSource := csDataSet;
    end;

    SMEWizardDlg.Formats := Options.Formats;
    SMEWizardDlg.Options := Options.Options;
    SMEWizardDlg.HelpContext := Options.HelpContext;
    if FileExists(Options.DefaultOptionsDirectory + '\Last Export.SME') then
      SMEWizardDlg.LoadSpecification(Options.DefaultOptionsDirectory + '\Last Export.SME');
    SMEWizardDlg.Execute;
    SMEWizardDlg.SaveSpecification('Last Export', Options.DefaultOptionsDirectory + '\Last Export.SME', False);
  finally
    {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    FreeAndNil(SMEEngineCx);
    {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    FreeAndNil(SMEWizardDlg);
  end;
end;

{$ENDIF USE_3RDPARTY_SMEXPORT}

{$IFDEF USE_3RDPARTY_SMIMPORT}

//=== { TJvDatabaseSMImportOptions } =========================================

constructor TJvDatabaseSMImportOptions.Create;
var
  Fmt: TTableTypeImport;
  Option: TSMIOption;
begin
  inherited Create;
  FFormats := [];
  for Fmt := Low(Fmt) to High(Fmt) do
    FFormats := FFormats + [Fmt];
  FOptions := [];
  for Option := Low(Option) to High(Option) do
    FOptions := FOptions + [Option];
end;

//=== { TJvDatabaseSMImportAction } ==========================================

constructor TJvDatabaseSMImportAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := TJvDatabaseSMImportOptions.Create;
end;

destructor TJvDatabaseSMImportAction.Destroy;
begin
  FOptions.Free;
  inherited Destroy;
end;

procedure TJvDatabaseSMImportAction.ExecuteTarget(Target: TObject);
begin
  ImportData;
end;

procedure TJvDatabaseSMImportAction.ImportData;
var
  SMIWizardDlg: TSMIWizardDlg;
begin
  SMIWizardDlg := TSMIWizardDlg.Create(Self);
  try
    //    SMIWizardDlg.OnGetSpecifications := Options.SMIWizardDlgGetSpecifications;
    SMIWizardDlg.SpecificationDir := Options.DefaultOptionsDirectory + '\';
    SMIWizardDlg.DataSet := DataSource.DataSet;
    SMIWizardDlg.Title := Options.Title;
    SMIWizardDlg.Formats := Options.Formats;
    SMIWizardDlg.HelpContext := Options.HelpContext;
    SMIWizardDlg.WizardStyle := Options.WizardStyle;
    SMIWizardDlg.Options := Options.Options;
    //    IF FileExists (Options.DefaultOptionsDirectory+'\Last Import.SMI') THEN
    //      SMIWizardDlg.LoadSpecification(Options.DefaultOptionsDirectory+'\Last Import.SMI');
    SMIWizardDlg.Execute;
    SMIWizardDlg.SaveSpecification('Last Import', Options.DefaultOptionsDirectory + '\Last Import.SMI', False);
  finally
    FreeAndNil(SMIWizardDlg);
  end;
end;

{$ENDIF USE_3RDPARTY_SMIMPORT}

//=== { TJvDatabaseActionEngineList } ========================================

destructor TJvDatabaseActionEngineList.Destroy;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    TJvDatabaseActionBaseEngine(Items[I]).Free;
    Items[I] := nil;
    Delete(I);
  end;
  inherited Destroy;
end;

procedure TJvDatabaseActionEngineList.RegisterEngine(AEngineClass: TJvDatabaseActionBaseEngineClass);
begin
  Add(AEngineClass.Create);
end;

function TJvDatabaseActionEngineList.GetEngine(AComponent: TComponent): TJvDatabaseActionBaseEngine;
var
  Ind: Integer;
begin
  Result := nil;
  for Ind := 0 to Count - 1 do
    if TJvDatabaseActionBaseEngine(Items[Ind]).Supports(AComponent) then
    begin
      Result := TJvDatabaseActionBaseEngine(Items[Ind]);
      Break;
    end;
end;

function TJvDatabaseActionEngineList.Supports(AComponent: TComponent): Boolean;
begin
  Result := Assigned(GetEngine(AComponent));
end;

//=== Global =================================================================

function RegisteredDatabaseActionEngineList: TJvDatabaseActionEngineList;
begin
  Result := IntRegisteredActionEngineList;
end;

procedure RegisterActionEngine(AEngineClass: TJvDatabaseActionBaseEngineClass);
begin
  if Assigned(IntRegisteredActionEngineList) then
    IntRegisteredActionEngineList.RegisterEngine(AEngineClass);
end;

procedure CreateActionEngineList;
begin
  IntRegisteredActionEngineList := TJvDatabaseActionEngineList.Create;
end;

procedure DestroyActionEngineList;
begin
  IntRegisteredActionEngineList.Free;
  IntRegisteredActionEngineList := nil;
end;

procedure ActionInit;
begin
  CreateActionEngineList;
  RegisterActionEngine(TJvDatabaseActionBaseEngine);
  RegisterActionEngine(TJvDatabaseActionDBGridEngine);
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  RegisterActionEngine(TJvDatabaseActionDevExpCxGridEngine);
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  ActionInit;

finalization
  DestroyActionEngineList;
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.

