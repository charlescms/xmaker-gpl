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
// $Id: JvDynControlEngineDBTools.pas,v 1.16 2005/02/17 10:20:27 marquardt Exp $

unit JvDynControlEngineDBTools;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Controls, DB, Classes,
  {$IFDEF MSWINDOWS}
  ActnList, Forms, Graphics,
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  QActnList, QForms, QGraphics,
  {$ENDIF UNIX}
  JvPanel, JvDynControlEngineTools, JvDynControlEngine, JvDynControlEngineDB;

type
  TJvCreateDataControlsEvent = procedure(ADynControlEngineDB: TJvDynControlEngineDB;
    AParentControl: TWinControl; AFieldCreateOptions: TJvCreateDBFieldsOnControlOptions) of object;

  TJvDynControlDataSourceEditDialog = class(TObject)
  private
    FForm: TCustomForm;
    FDynControlEngineDB: TJvDynControlEngineDB;
    FDataSource: TDataSource;
    FDataComponent: TComponent;
    FDialogCaption: string;
    FPostButtonCaption: string;
    FCancelButtonCaption: string;
    FCloseButtonCaption: string;
    FPostButtonGlyph: TBitmap;
    FCancelButtonGlyph: TBitmap;
    FCloseButtonGlyph: TBitmap;
    FIncludeNavigator: Boolean;
    FBorderStyle: TFormBorderStyle;
    FPosition: TPosition;
    FTop: Integer;
    FLeft: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FOnCreateDataControlsEvent: TJvCreateDataControlsEvent;
    FArrangeConstraints: TSizeConstraints;
    FArrangeSettings: TJvArrangeSettings;
    FFieldCreateOptions: TJvCreateDBFieldsOnControlOptions;
    FScrollBox: TScrollBox;
    FNavigatorPanel: TJvPanel;
    FButtonPanel: TWinControl;
    FPostAction: TCustomAction;
    FCancelAction: TCustomAction;
  protected
    function GetDynControlEngineDB: TJvDynControlEngineDB;
    procedure SetDataComponent(Value: TComponent);
    procedure OnPostButtonClick(Sender: TObject);
    procedure OnCancelButtonClick(Sender: TObject);
    procedure OnCloseButtonClick(Sender: TObject);
    function CreateDynControlDialog(var AMainPanel: TWinControl): TCustomForm;
    procedure SetArrangeSettings(Value: TJvArrangeSettings);
    procedure SetArrangeConstraints(Value: TSizeConstraints);
    procedure SetFieldCreateOptions(Value: TJvCreateDBFieldsOnControlOptions);
    procedure ArrangePanelChangedWidth(Sender: TObject; ChangedSize: Integer);
    procedure ArrangePanelChangedHeight(Sender: TObject; ChangedSize: Integer);
    property DataSource: TDataSource read FDataSource;
  public
    constructor Create;
    destructor Destroy; override;
    function ShowDialog: TModalResult;
  published
    property DataComponent: TComponent read FDataComponent write SetDataComponent;
    property PostButtonCaption: string read FPostButtonCaption write FPostButtonCaption;
    property CancelButtonCaption: string read FCancelButtonCaption write FCancelButtonCaption;
    property CloseButtonCaption: string read FCloseButtonCaption write FCloseButtonCaption;
    property PostButtonGlyph: TBitmap read FPostButtonGlyph write FPostButtonGlyph;
    property CancelButtonGlyph: TBitmap read FCancelButtonGlyph write FCancelButtonGlyph;
    property CloseButtonGlyph: TBitmap read FCloseButtonGlyph write FCloseButtonGlyph;
    property DialogCaption: string read FDialogCaption write FDialogCaption;
    property DynControlEngineDB: TJvDynControlEngineDB read GetDynControlEngineDB write FDynControlEngineDB;
    property IncludeNavigator: Boolean read FIncludeNavigator write FIncludeNavigator;
    property BorderStyle: TFormBorderStyle read FBorderStyle write FBorderStyle default bsDialog;
    property Position: TPosition read FPosition write FPosition default poScreenCenter;
    property Top: Integer read FTop write FTop default 0;
    property Left: Integer read FLeft write FLeft default 0;
    property Width: Integer read FWidth write FWidth default 0;
    property Height: Integer read FHeight write FHeight default 0;
    property OnCreateDataControlsEvent: TJvCreateDataControlsEvent read FOnCreateDataControlsEvent write
      FOnCreateDataControlsEvent;
    property ArrangeConstraints: TSizeConstraints read FArrangeConstraints write SetArrangeConstraints;
    property ArrangeSettings: TJvArrangeSettings read FArrangeSettings write SetArrangeSettings;
    property FieldCreateOptions: TJvCreateDBFieldsOnControlOptions read FFieldCreateOptions write SetFieldCreateOptions;
  end;

function ShowDataSourceEditDialog(ADataComponent: TComponent;
  const ADialogCaption, APostButtonCaption, ACancelButtonCaption, ACloseButtonCaption: string;
  AIncludeNavigator: Boolean;
  AFieldCreateOptions: TJvCreateDBFieldsOnControlOptions = nil;
  AArrangeConstraints: TSizeConstraints = nil;
  AArrangeSettings: TJvArrangeSettings = nil;
  ADynControlEngineDB: TJvDynControlEngineDB = nil): TModalResult;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvDynControlEngineDBTools.pas,v $';
    Revision: '$Revision: 1.16 $';
    Date: '$Date: 2005/02/17 10:20:27 $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  StdCtrls, SysUtils,
  JvDBActions, JvDynControlEngineIntf, JvResources;

procedure TJvDynControlDataSourceEditDialog.SetDataComponent(Value: TComponent);
begin
  FDataComponent := Value;
  FDataSource := DynControlengineDB.GetDataSourceFromDataComponent(Value);
end;

function TJvDynControlDataSourceEditDialog.GetDynControlEngineDB: TJvDynControlEngineDB;
begin
  if Assigned(FDynControlEngineDB) then
    Result := FDynControlEngineDB
  else
    Result := DefaultDynControlEngineDB;
end;

procedure TJvDynControlDataSourceEditDialog.OnPostButtonClick(Sender: TObject);
begin
  if DataSource.Dataset.State in [dsInsert, dsEdit] then
  try
    DataSource.Dataset.Post;
    FForm.ModalResult := mrOk;
  except
    FForm.ModalResult := mrNone;
  end;
end;

procedure TJvDynControlDataSourceEditDialog.OnCancelButtonClick(Sender: TObject);
begin
  if DataSource.Dataset.State in [dsInsert, dsEdit] then
    DataSource.Dataset.Cancel;
  FForm.ModalResult := mrCancel;
end;

procedure TJvDynControlDataSourceEditDialog.OnCloseButtonClick(Sender: TObject);
begin
  FForm.ModalResult := mrAbort;
end;

constructor TJvDynControlDataSourceEditDialog.Create;
begin
  inherited Create;
  FDialogCaption := '';
  FPostButtonCaption := RSSRWPostButtonCaption;
  FCancelButtonCaption := RSSRWCancelButtonCaption;
  FCloseButtonCaption := RSSRWCloseButtonCaption;
  FPostButtonGlyph := nil;
  FCancelButtonGlyph := nil;
  FCloseButtonGlyph := nil;
  FBorderStyle := bsDialog;
  FTop := 0;
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FPosition := poScreenCenter;
  FDynControlEngineDB := nil;
  FDataSource := nil;
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
  with FArrangeConstraints do
  begin
    MaxHeight := 480;
    MaxWidth := 640;
  end;
  FFieldCreateOptions := TJvCreateDBFieldsOnControlOptions.Create;
end;

destructor TJvDynControlDataSourceEditDialog.Destroy;
begin
  FFieldCreateOptions.Free;
  FArrangeConstraints.Free;
  FArrangeSettings.Free;
  inherited Destroy;
end;

procedure TJvDynControlDataSourceEditDialog.SetArrangeSettings(Value: TJvArrangeSettings);
begin
  FArrangeSettings.Assign(Value);
end;

procedure TJvDynControlDataSourceEditDialog.SetArrangeConstraints(Value: TSizeConstraints);
begin
  FArrangeConstraints.Assign(Value);
end;

procedure TJvDynControlDataSourceEditDialog.SetFieldCreateOptions(Value: TJvCreateDBFieldsOnControlOptions);
begin
  FFieldCreateOptions.Assign(Value);
end;

procedure TJvDynControlDataSourceEditDialog.ArrangePanelChangedWidth(Sender: TObject; ChangedSize: Integer);
begin
  FForm.ClientWidth := ChangedSize;
end;

procedure TJvDynControlDataSourceEditDialog.ArrangePanelChangedHeight(Sender: TObject; ChangedSize: Integer);
begin
  if Assigned(FNavigatorPanel) then
    FForm.ClientHeight := ChangedSize + FButtonPanel.Height + FNavigatorPanel.Height + 35
  else
    FForm.ClientHeight := ChangedSize + FButtonPanel.Height + 35;
end;

type
  TAccessControl = class(TControl);

function TJvDynControlDataSourceEditDialog.CreateDynControlDialog(var AMainPanel: TWinControl): TCustomForm;
var
  DynControlEngine: TJvDynControlEngine;
  Form: TCustomForm;
  PostButton, CancelButton, CloseButton: TButtonControl;
  LeftPos: Integer;
  DynCtrlButton: IJvDynControlButton;
  DynCtrlAction: IJvDynControlAction;

  function CalcButtonWidth (ACaptionWidth: Integer; AGlyph: TBitmap) : Integer;
  begin
    Result := 4;
    if Assigned(AGlyph) then
      Result := Result + AGlyph.Width;
    if ACaptionWidth > 0 then
    begin
      Result := Result + ACaptionWidth;
      if ACaptionWidth > 0 then
        Result := Result + 4;
    end;
  end;

begin
  DynControlEngine := DynControlEngineDB.DynControlEngine;
  Form := DynControlEngine.CreateForm(DialogCaption, '');
  TForm(Form).Position := Position;
  TForm(Form).BorderStyle := BorderStyle;
  TForm(Form).Top := Top;
  TForm(Form).Left := Left;
  TForm(Form).Height := Height;
  TForm(Form).Width := Width;
  with TForm(Form) do
  begin
    FormStyle := fsNormal;
    BorderIcons := [];
  end;

  FButtonPanel := DynControlEngine.CreatePanelControl(Form, Form, '', '', alBottom);
  FButtonPanel.Width := Form.ClientWidth;
  AMainPanel := DynControlEngine.CreatePanelControl(Form, Form, '', '', alClient);
  LeftPos := FButtonPanel.Width;
  if (CloseButtonCaption <> '') or Assigned(CloseButtonGlyph) then
  begin
    CloseButton := DynControlEngine.CreateButton(Form, FButtonPanel, '', CloseButtonCaption, '', OnCloseButtonClick,
      True, False);
    FButtonPanel.Height := CloseButton.Height + 6;
    CloseButton.Top := 3;
    CloseButton.Anchors := [akTop, akRight];
    CloseButton.Width := CalcButtonWidth(Form.Canvas.TextWidth(CloseButtonCaption), CloseButtonGlyph);
    CloseButton.Left := LeftPos - CloseButton.Width - 5;
    LeftPos := CloseButton.Left;
    CloseButton.TabOrder := 0;
    if Supports(CloseButton, IJvDynControlButton, DynCtrlButton) then
    begin
      DynCtrlButton.ControlSetDefault(True);
      DynCtrlButton.ControlSetCancel(True);
      if Assigned(CloseButtonGlyph) then
        DynCtrlButton.ControlSetGlyph(CloseButtonGlyph);
    end;
  end;
  if (CancelButtonCaption <> '') or Assigned(CancelButtonGlyph) then
  begin
    CancelButton := DynControlEngine.CreateButton(Form, FButtonPanel, '', CancelButtonCaption, '', OnCancelButtonClick,
      True, False);
    if Supports(CancelButton, IJvDynControlAction, DynCtrlAction) then
    begin
      FCancelAction := TJvDatabaseCancelAction.Create (Form);
      FCancelAction.Caption := CancelButtonCaption;
      DynCtrlAction.ControlSetAction(FCancelAction);
    end
    else
      FCancelAction := nil;
    FButtonPanel.Height := CancelButton.Height + 6;
    CancelButton.Top := 3;
    CancelButton.Anchors := [akTop, akRight];
    CancelButton.Width := CalcButtonWidth(Form.Canvas.TextWidth(CancelButtonCaption), CancelButtonGlyph);
    CancelButton.Left := LeftPos - CancelButton.Width - 5;
    LeftPos := CancelButton.Left;
    CancelButton.TabOrder := 0;
    if Supports(CancelButton, IJvDynControlButton, DynCtrlButton) then
    begin
      DynCtrlButton.ControlSetDefault (False);
      DynCtrlButton.ControlSetCancel(False);
      if Assigned(CancelButtonGlyph) then
        DynCtrlButton.ControlSetGlyph(CancelButtonGlyph);
    end;
  end;
  if (PostButtonCaption <> '') or Assigned(PostButtonGlyph) then
  begin
    PostButton := DynControlEngine.CreateButton(Form, FButtonPanel, '', PostButtonCaption, '', OnPostButtonClick, True,
      False);
    FButtonPanel.Height := PostButton.Height + 6;
    if Supports(PostButton, IJvDynControlAction, DynCtrlAction) then
    begin
      FPostAction := TJvDatabasePostAction.Create (Form);
      FPostAction.Caption := PostButtonCaption;
      DynCtrlAction.ControlSetAction(FPostAction);
    end
    else
      FPostAction := nil;
    PostButton.Top := 3;
    PostButton.Anchors := [akTop, akRight];
    PostButton.Width := CalcButtonWidth(Form.Canvas.TextWidth(PostButtonCaption), PostButtonGlyph);
    PostButton.Left := LeftPos - PostButton.Width - 5;
    PostButton.TabOrder := 0;
    if Supports(PostButton, IJvDynControlButton, DynCtrlButton) then
    begin
      DynCtrlButton.ControlSetDefault (False);
      DynCtrlButton.ControlSetCancel(False);
      if Assigned(PostButtonGlyph) then
        DynCtrlButton.ControlSetGlyph(PostButtonGlyph);
    end;
  end;
  Result := Form;
end;

function TJvDynControlDataSourceEditDialog.ShowDialog: TModalResult;
var
  MainPanel: TWinControl;
  ArrangePanel: TJvPanel;
  Navigator: TControl;
begin
  FForm := CreateDynControlDialog(MainPanel);
  try
    FScrollBox := TScrollBox.Create(FForm);
    FScrollBox.Parent := MainPanel;
    FScrollBox.Align := alClient;
    FScrollBox.BorderStyle := bsNone;
    FScrollBox.AutoScroll := True;
    FForm.Constraints := ArrangeConstraints;
    ArrangePanel := TJvPanel.Create(FForm);
    with ArrangePanel do
    begin
      Align := alTop;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      Parent := FScrollBox;
      OnChangedWidth := ArrangePanelChangedWidth;
      OnChangedHeight := ArrangePanelChangedHeight;
    end;
    ArrangePanel.ArrangeSettings := ArrangeSettings;
    if ArrangeSettings.MaxWidth = 0 then
      ArrangePanel.ArrangeSettings.MaxWidth := ArrangeConstraints.MaxWidth;
    if ArrangeSettings.MaxWidth = 0 then
      ArrangeSettings.MaxWidth := Screen.Width;
    if IncludeNavigator then
    begin
      FNavigatorPanel := TJvPanel.Create(FForm);
      Navigator := DynControlEngineDB.CreateDBNavigatorControl(FForm, FNavigatorPanel, '', DataSource);
      Navigator.Left := 3;
      Navigator.Top := 3;
      with FNavigatorPanel do
      begin
        Align := alBottom;
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Parent := MainPanel;
        Height := Navigator.Height + 6;
      end;
    end
    else
      FNavigatorPanel := nil;
    if Assigned(OnCreateDataControlsEvent) then
      OnCreateDataControlsEvent(DynControlEngineDB, ArrangePanel, FieldCreateOptions)
    else
      DynControlEngineDB.CreateControlsFromDataComponentOnControl(DataComponent, ArrangePanel, FieldCreateOptions);
    if Assigned (FCancelAction) then
      TJvDatabaseCancelAction(FCancelAction).DataComponent := DataComponent;
    if Assigned (FPostAction) then
      TJvDatabaseCancelAction(FPostAction).DataComponent := DataComponent;

//    ArrangePanel.ArrangeControls;
    ArrangePanel.ArrangeSettings.AutoArrange := True;
    MainPanel.TabOrder := 0;
    Result := FForm.ShowModal;
  finally
    FForm.Free;
  end;
end;

function ShowDataSourceEditDialog(ADataComponent: TComponent;
  const ADialogCaption, APostButtonCaption, ACancelButtonCaption, ACloseButtonCaption: string;
  AIncludeNavigator: Boolean;
  AFieldCreateOptions: TJvCreateDBFieldsOnControlOptions = nil;
  AArrangeConstraints: TSizeConstraints = nil;
  AArrangeSettings: TJvArrangeSettings = nil;
  ADynControlEngineDB: TJvDynControlEngineDB = nil): TModalResult;
var
  Dialog: TJvDynControlDataSourceEditDialog;
begin
  Dialog := TJvDynControlDataSourceEditDialog.Create;
  try
    Dialog.DataComponent := ADataComponent;
    Dialog.DialogCaption := ADialogCaption;
    Dialog.PostButtonCaption := APostButtonCaption;
    Dialog.CancelButtonCaption := ACancelButtonCaption;
    Dialog.CloseButtonCaption := ACloseButtonCaption;
    Dialog.IncludeNavigator := AIncludeNavigator;
    Dialog.DynControlEngineDB := ADynControlEngineDB;
    if Assigned(AFieldCreateOptions) then
      Dialog.FieldCreateOptions := AFieldCreateOptions;
    if Assigned(AArrangeSettings) then
      Dialog.ArrangeSettings := AArrangeSettings;
    if Assigned(AArrangeConstraints) then
      Dialog.ArrangeConstraints := AArrangeConstraints;
    Result := Dialog.ShowDialog;
  finally
    Dialog.Free;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

