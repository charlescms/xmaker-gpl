{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvThreadDialog.PAS, released on 2004-12-06.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudickar att oratool dott de]
All Rights Reserved.

Contributor(s): Jens Fudickar [jens dott fudickar att oratool dott de].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvThreadDialog.pas,v 1.11 2005/02/17 10:20:57 marquardt Exp $

unit JvThreadDialog;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes, Forms, ExtCtrls, Buttons, StdCtrls,
  {$IFDEF MSWINDOWS}
  Windows, Controls, ComCtrls,
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  QWindows, QControls,
  {$ENDIF UNIX}
  JvTypes, JvComponent;

type
  TJvCustomThreadDialog = class;

  TJvThreadBaseDialogOptions = class(TPersistent)
  private
    FEnableCancelButton: Boolean;
    FShowDialog: Boolean;
    FShowModal: Boolean;
    FShowCancelButton: Boolean;
    FShowElapsedTime: Boolean;
    FInfoText: string;
    FCaption: string;
    FCancelButtonCaption: string;
    FOwner: TJvCustomThreadDialog;
  protected
    procedure SetEnableCancelButton(Value: Boolean);
    procedure SetShowDialog(Value: Boolean);
    procedure SetShowModal(Value: Boolean);
    procedure SetShowCancelButton(Value: Boolean);
    procedure SetShowElapsedTime(Value: Boolean);
    procedure SetInfoText(Value: string);
    procedure SetCaption(Value: string);
    procedure SetCancelButtonCaption(Value: string);
  public
    constructor Create(AOwner: TJvCustomThreadDialog); virtual;
  published
    property EnableCancelButton: Boolean read FEnableCancelButton write SetEnableCancelButton default True;
    property ShowDialog: Boolean read FShowDialog write SetShowDialog default False;
    property ShowModal: Boolean read FShowModal write SetShowModal default True;
    property ShowCancelButton: Boolean read FShowCancelButton write SetShowCancelButton default True;
    property ShowElapsedTime: Boolean read FShowElapsedTime write SetShowElapsedTime default True;
    property InfoText: string read FInfoText write SetInfoText;
    property Caption: string read FCaption write SetCaption;
    property CancelButtonCaption: string read FCancelButtonCaption write SetCancelButtonCaption;
  end;

  TJvCustomThreadDialogForm = class(TForm)
  private
    FConnectedThread: TComponent;
  protected
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SetConnectedThread(Value: TComponent);
  public
    property ConnectedThread: TComponent read FConnectedThread write SetConnectedThread;
  end;

  TJvCustomThreadDialog = class(TJvComponent)
  private
    FDialogOptions: TJvThreadBaseDialogOptions;
    FThreadStatusDialog: TJvCustomThreadDialogForm;
  protected
    function CreateDialogOptions: TJvThreadBaseDialogOptions; virtual; abstract;
    procedure TransferThreadDialogOptions; virtual;
    property ThreadStatusDialog: TJvCustomThreadDialogForm read FThreadStatusDialog write FThreadStatusDialog;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    destructor Destroy; override;
    procedure CloseThreadDialogForm;
    function CreateThreadDialogForm(ConnectedThread: TComponent): TJvCustomThreadDialogForm; virtual; abstract;
  published
    property DialogOptions: TJvThreadBaseDialogOptions read FDialogOptions write FDialogOptions;
  end;

  TJvThreadSimpleDialog = class(TJvCustomThreadDialog)
  private
    FCancelButtonPanel: TPanel;
    FCancelBtn: TButton;
    FInfoTextPanel: TPanel;
    FInfoText: TStaticText;
    FTimeTextPanel: TPanel;
    FTimeText: TStaticText;
    FMainTimer: TTimer;
    FCounter: Integer;
    FStartTime: TDateTime;
  protected
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBtnClick(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);
    procedure SetFormData;
    procedure SetFormHeightWidth;
    procedure TransferThreadDialogOptions; override;
    function CreateDialogOptions: TJvThreadBaseDialogOptions; override;
  public
    function CreateThreadDialogForm(ConnectedThread: TComponent): TJvCustomThreadDialogForm; override;
  end;

  TJvThreadAnimateDialogOptions = class(TJvThreadBaseDialogOptions)
  private
    FCommonAVI: TCommonAVI;
    FFileName: string;
  published
    property CommonAVI: TCommonAVI read FCommonAVI write FCommonAVI;
    property FileName: string read FFileName write FFileName;
  end;

  TJvThreadAnimateDialog = class(TJvCustomThreadDialog)
  private
    FCancelButtonPanel: TPanel;
    FCancelBtn: TButton;
    FAnimatePanel: TPanel;
    FAnimate: TAnimate;
    FInfoTextPanel: TPanel;
    FInfoText: TStaticText;
    FTimeTextPanel: TPanel;
    FTimeText: TStaticText;
    FMainTimer: TTimer;
    FCounter: Integer;
    FStartTime: TDateTime;
  protected
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBtnClick(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);
    procedure SetFormData;
    procedure SetFormHeightWidth;
    procedure TransferThreadDialogOptions; override;
    function GetDialogOptions: TJvThreadAnimateDialogOptions;
    function CreateDialogOptions: TJvThreadBaseDialogOptions; override;
  public
    function CreateThreadDialogForm(ConnectedThread: TComponent): TJvCustomThreadDialogForm; override;
  published
    //property DialogOptions: TJvThreadAnimateDialogOptions read GetDialogOptions;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvThreadDialog.pas,v $';
    Revision: '$Revision: 1.11 $';
    Date: '$Date: 2005/02/17 10:20:57 $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  Dialogs,
  JvThread, JvResources;

function JvThreadComp(AComp: TComponent): TJvThread;
begin
  if AComp is TJvThread then
    Result := TJvThread(AComp)
  else
    Result := nil;
end;

//=== { TJvThreadBaseDialogOptions } =========================================

constructor TJvThreadBaseDialogOptions.Create(AOwner: TJvCustomThreadDialog);
begin
  inherited Create;
  FOwner := AOwner;
  FEnableCancelButton := True;
  FShowDialog := False;
  FShowModal := True;
  FShowCancelButton := True;
  FShowElapsedTime := True;
  FCancelButtonCaption := RsButtonCancelCaption;
end;

procedure TJvThreadBaseDialogOptions.SetEnableCancelButton(Value: Boolean);
begin
  FEnableCancelButton := Value;
  if Assigned(FOwner) then
    FOwner.TransferThreadDialogOptions;
end;

procedure TJvThreadBaseDialogOptions.SetShowDialog(Value: Boolean);
begin
  FShowDialog := Value;
end;

procedure TJvThreadBaseDialogOptions.SetShowModal(Value: Boolean);
begin
  FShowModal := Value;
end;

procedure TJvThreadBaseDialogOptions.SetShowCancelButton(Value: Boolean);
begin
  FShowCancelButton := Value;
  if Assigned(FOwner) then
    FOwner.TransferThreadDialogOptions;
end;

procedure TJvThreadBaseDialogOptions.SetShowElapsedTime(Value: Boolean);
begin
  FShowElapsedTime := Value;
  if Assigned(FOwner) then
    FOwner.TransferThreadDialogOptions;
end;

procedure TJvThreadBaseDialogOptions.SetInfoText(Value: string);
begin
  FInfoText := Value;
  if Assigned(FOwner) then
    FOwner.TransferThreadDialogOptions;
end;

procedure TJvThreadBaseDialogOptions.SetCaption(Value: string);
begin
  FCaption := Value;
  if Assigned(FOwner) then
    FOwner.TransferThreadDialogOptions;
end;

procedure TJvThreadBaseDialogOptions.SetCancelButtonCaption(Value: string);
begin
  FCancelButtonCaption := Value;
  if Assigned(FOwner) then
    FOwner.TransferThreadDialogOptions;
end;

//=== { TJvCustomThreadDialog } ==============================================

procedure TJvCustomThreadDialogForm.SetConnectedThread(Value: TComponent);
begin
  if not (Value is TJvThread) then
    raise EJVCLException.CreateRes(@RsENotATJvThread);
  FConnectedThread := Value;
end;

procedure TJvCustomThreadDialogForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := JvThreadComp(FConnectedThread).Terminated;
end;

//=== { TJvCustomThreadDialog } ==============================================

constructor TJvCustomThreadDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDialogOptions := CreateDialogOptions;
end;

destructor TJvCustomThreadDialog.Destroy;
begin
  FDialogOptions.Free;
  inherited Destroy;
end;

procedure TJvCustomThreadDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FThreadStatusDialog then
      FThreadStatusDialog := nil;
end;

procedure TJvCustomThreadDialog.TransferThreadDialogOptions;
begin
end;

procedure TJvCustomThreadDialog.CloseThreadDialogForm;
begin
  if Assigned(FThreadStatusDialog) and not (csDestroying in ComponentState) then
  begin
    FThreadStatusDialog.Close;
    Application.HandleMessage;
  end;
end;

//=== { TJvThreadSimpleDialog } ==============================================

function TJvThreadSimpleDialog.CreateDialogOptions: TJvThreadBaseDialogOptions;
begin
  Result := TJvThreadBaseDialogOptions.Create(Self);
end;

function TJvThreadSimpleDialog.CreateThreadDialogForm(ConnectedThread: TComponent): TJvCustomThreadDialogForm;
begin
  Result := nil;
  if DialogOptions.ShowDialog then
  begin
    ThreadStatusDialog := TJvCustomThreadDialogForm.CreateNew(Self);
    ThreadStatusDialog.ConnectedThread := ConnectedThread;
    Result := ThreadStatusDialog;
    FCancelButtonPanel := TPanel.Create(ThreadStatusDialog);
    FCancelBtn := TBitBtn.Create(ThreadStatusDialog);
    FInfoTextPanel := TPanel.Create(ThreadStatusDialog);
    FInfoText := TStaticText.Create(ThreadStatusDialog);
    FTimeTextPanel := TPanel.Create(ThreadStatusDialog);
    FTimeText := TStaticText.Create(ThreadStatusDialog);
    FMainTimer := TTimer.Create(ThreadStatusDialog);
    with ThreadStatusDialog do
    begin
      BorderIcons := [];
      BorderStyle := bsDialog;
      Caption := ' ';
      ClientHeight := 88;
      ClientWidth := 268;
      FormStyle := fsStayOnTop;
      OldCreateOrder := False;
      Position := poScreenCenter;
      OnClose := FormClose;
      OnCloseQuery := FormCloseQuery;
      OnShow := FormShow;
      PixelsPerInch := 96;
    end;
    with FInfoTextPanel do
    begin
      Top := 0;
      Caption := '';
      Parent := FThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
      BorderWidth := 3;
    end;
    with FInfoText do
    begin
      Parent := FInfoTextPanel;
      Height := 22;
      FInfoTextPanel.Height := FInfoText.Height + 6;
      Align := alClient;
      AutoSize := False;
      {$IFDEF COMPILER6_UP}
      BevelInner := bvNone;
      BevelOuter := bvNone;
      {$ENDIF COMPILER6_UP}
      ParentFont := False;
    end;
    with FTimeTextPanel do
    begin
      Top := FInfoTextPanel.Top + FInfoTextPanel.Height + 1;
      Parent := ThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
      BorderWidth := 3;
    end;
    with FTimeText do
    begin
      Height := 22;
      FTimeTextPanel.Height := FTimeText.Height + 6;
      Caption := '';
      Parent := FTimeTextPanel;
      Align := alClient;
      Alignment := taCenter;
      AutoSize := False;
      {$IFDEF COMPILER6_UP}
      BevelInner := bvLowered;
      {$ENDIF COMPILER6_UP}
      BorderStyle := sbsSunken;
      ParentFont := False;
    end;
    with FCancelButtonPanel do
    begin
      Top := FTimeTextPanel.Top + FTimeTextPanel.Height + 1;
      Caption := '';
      Parent := ThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
    end;
    with FCancelBtn do
    begin
      Parent := FCancelButtonPanel;
      Anchors := [akTop];
      Caption := DialogOptions.CancelButtonCaption;
      OnClick := CancelBtnClick;
      Top := 0;
      FCancelButtonPanel.Height := FCancelBtn.Height + 3;
    end;
    SetFormData;
    with FMainTimer do
    begin
      Interval := 500;
      OnTimer := MainTimerTimer;
    end;
    if Assigned(ThreadStatusDialog) then
      if DialogOptions.ShowModal then
        ThreadStatusDialog.ShowModal
      else
        ThreadStatusDialog.Show;
  end;
end;

procedure TJvThreadSimpleDialog.FormShow(Sender: TObject);
begin
  FStartTime := Now;
  FCounter := 0;
  MainTimerTimer(nil);
  SetFormData;
end;

procedure TJvThreadSimpleDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMainTimer.OnTimer := nil;
  FMainTimer.Enabled := False;
  Action := caFree;
end;

procedure TJvThreadSimpleDialog.CancelBtnClick(Sender: TObject);
begin
  if Assigned(JvThreadComp(ThreadStatusDialog.ConnectedThread)) then
    JvThreadComp(ThreadStatusDialog.ConnectedThread).Terminate;
end;

procedure TJvThreadSimpleDialog.MainTimerTimer(Sender: TObject);
begin
  if not (csDestroying in ComponentState) and Assigned(ThreadStatusDialog) then
    if Assigned(ThreadStatusDialog.ConnectedThread) and Assigned(DialogOptions) then
      if JvThreadComp(ThreadStatusDialog.ConnectedThread).Terminated then
        ThreadStatusDialog.Close
      else
      begin
        SetFormData;
        FCounter := FCounter + 1;
        case FCounter mod 4 of
          0:
            FInfoText.Caption := DialogOptions.FInfoText + ' | ';
          1:
            FInfoText.Caption := DialogOptions.FInfoText + ' / ';
          2:
            FInfoText.Caption := DialogOptions.FInfoText + ' --';
          3:
            FInfoText.Caption := DialogOptions.FInfoText + ' \ ';
        end;
        FTimeText.Caption := FormatDateTime('hh:nn:ss', Now - FStartTime);
      end
    else
      ThreadStatusDialog.Close;
end;

procedure TJvThreadSimpleDialog.TransferThreadDialogOptions;
begin
  SetFormData;
end;

procedure TJvThreadSimpleDialog.SetFormHeightWidth;
var
  H, W: Integer;
begin
  if Assigned(ThreadStatusDialog) then
  begin
    W := ThreadStatusDialog.Canvas.TextWidth(DialogOptions.FInfoText) + 80;
    if W < 200 then
      W := 200;
    ThreadStatusDialog.ClientWidth := W;
    FCancelBtn.Left := (FCancelButtonPanel.Width - FCancelBtn.Width) div 2;
    H := FInfoTextPanel.Height + 6;
    if FTimeTextPanel.Visible then
      H := H + FTimeTextPanel.Height;
    if FCancelButtonPanel.Visible then
      H := H + FCancelButtonPanel.Height;
    if ThreadStatusDialog.ClientHeight <> H then
      ThreadStatusDialog.ClientHeight := H;
  end;
end;

procedure TJvThreadSimpleDialog.SetFormData;
begin
  if Assigned(ThreadStatusDialog) and Assigned(DialogOptions) then
  begin
    ThreadStatusDialog.Caption := DialogOptions.Caption;
    FTimeTextPanel.Visible := DialogOptions.ShowElapsedTime;
    FCancelBtn.Enabled := DialogOptions.EnableCancelButton;
    FCancelButtonPanel.Visible := DialogOptions.ShowCancelButton;
    SetFormHeightWidth;
  end;
end;

//=== { TJvThreadAnimateDialog } =============================================

function TJvThreadAnimateDialog.CreateDialogOptions: TJvThreadBaseDialogOptions;
begin
  Result := TJvThreadAnimateDialogOptions.Create(Self);
end;

function TJvThreadAnimateDialog.GetDialogOptions: TJvThreadAnimateDialogOptions;
begin
  Result := TJvThreadAnimateDialogOptions(inherited DialogOptions);
end;

function TJvThreadAnimateDialog.CreateThreadDialogForm(ConnectedThread: TComponent): TJvCustomThreadDialogForm;
begin
  Result := nil;
  if DialogOptions.ShowDialog then
  begin
    ThreadStatusDialog := TJvCustomThreadDialogForm.CreateNew(Self);
    ThreadStatusDialog.ConnectedThread := ConnectedThread;
    Result := ThreadStatusDialog;
    FCancelButtonPanel := TPanel.Create(ThreadStatusDialog);
    FCancelBtn := TBitBtn.Create(ThreadStatusDialog);
    FAnimatePanel := TPanel.Create(ThreadStatusDialog);
    FAnimate := TAnimate.Create(ThreadStatusDialog);
    FInfoTextPanel := TPanel.Create(ThreadStatusDialog);
    FInfoText := TStaticText.Create(ThreadStatusDialog);
    FTimeTextPanel := TPanel.Create(ThreadStatusDialog);
    FTimeText := TStaticText.Create(ThreadStatusDialog);
    FMainTimer := TTimer.Create(ThreadStatusDialog);
    with ThreadStatusDialog do
    begin
      BorderIcons := [];
      BorderStyle := bsDialog;
      Caption := ' ';
      ClientHeight := 88;
      ClientWidth := 268;
      FormStyle := fsStayOnTop;
      OldCreateOrder := False;
      Position := poScreenCenter;
      OnClose := FormClose;
      OnCloseQuery := FormCloseQuery;
      OnShow := FormShow;
      PixelsPerInch := 96;
    end;
    with FInfoTextPanel do
    begin
      Top := 0;
      Parent := ThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
      BorderWidth := 3;
    end;
    with FInfoText do
    begin
      Height := 22;
      Parent := FInfoTextPanel;
      FInfoTextPanel.Height := FInfoText.Height + 6;
      Align := alClient;
      AutoSize := False;
      {$IFDEF COMPILER6_UP}
      BevelInner := bvNone;
      BevelOuter := bvNone;
      {$ENDIF COMPILER6_UP}
      ParentFont := False;
    end;
    with FAnimatePanel do
    begin
      Caption := '';
      Top := FInfoTextPanel.Height + 1;
      Parent := ThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
      BorderWidth := 3;
    end;
    with FAnimate do
    begin
      Parent := FAnimatePanel;
      Top := 0;
      Left := 0;
      AutoSize := True;
      CommonAVI := TJvThreadAnimateDialogOptions(DialogOptions).CommonAVI;
      FileName := TJvThreadAnimateDialogOptions(DialogOptions).FileName;
      FAnimatePanel.Height := Height + 6;
    end;
    with FTimeTextPanel do
    begin
      Top := FAnimatePanel.Top + FAnimatePanel.Height + 1;
      Caption := '';
      Parent := ThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
      BorderWidth := 3;
    end;
    with FTimeText do
    begin
      Height := 22;
      FTimeTextPanel.Height := FTimeText.Height + 6;
      Parent := FTimeTextPanel;
      Align := alClient;
      Alignment := taCenter;
      AutoSize := False;
      {$IFDEF COMPILER6_UP}
      BevelInner := bvLowered;
      {$ENDIF COMPILER6_UP}
      BorderStyle := sbsSunken;
      ParentFont := False;
    end;
    with FCancelButtonPanel do
    begin
      Top := FTimeTextPanel.Top + FTimeText.Height + 1;
      Caption := '';
      Parent := ThreadStatusDialog;
      Align := alTop;
      BevelOuter := bvNone;
    end;
    with FCancelBtn do
    begin
      Top := 0;
      Parent := FCancelButtonPanel;
      Anchors := [akTop];
      Caption := DialogOptions.CancelButtonCaption;
      OnClick := CancelBtnClick;
      FCancelButtonPanel.Height := FCancelBtn.Height + 3;
    end;
    SetFormData;
    with FMainTimer do
    begin
      Interval := 500;
      OnTimer := MainTimerTimer;
    end;
    if DialogOptions.ShowModal then
      ThreadStatusDialog.ShowModal
    else
      ThreadStatusDialog.Show;
  end;
end;

procedure TJvThreadAnimateDialog.FormShow(Sender: TObject);
begin
  FStartTime := Now;
  FCounter := 0;
  SetFormData;
  FAnimate.Active := True;
  MainTimerTimer(nil);
end;

procedure TJvThreadAnimateDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMainTimer.OnTimer := nil;
  FMainTimer.Enabled := False;
  Action := caFree;
end;

procedure TJvThreadAnimateDialog.CancelBtnClick(Sender: TObject);
begin
  if Assigned(JvThreadComp(ThreadStatusDialog.ConnectedThread)) then
    JvThreadComp(ThreadStatusDialog.ConnectedThread).Terminate;
end;

procedure TJvThreadAnimateDialog.MainTimerTimer(Sender: TObject);
begin
  if not (csDestroying in ComponentState) and Assigned(ThreadStatusDialog) then
    if Assigned(ThreadStatusDialog.ConnectedThread) and Assigned(DialogOptions) then
      if JvThreadComp(ThreadStatusDialog.ConnectedThread).Terminated then
        ThreadStatusDialog.Close
      else
      begin
        SetFormData;
        FTimeText.Caption := FormatDateTime('hh:nn:ss', Now - FStartTime);
      end
    else
      ThreadStatusDialog.Close
end;

procedure TJvThreadAnimateDialog.TransferThreadDialogOptions;
begin
  SetFormData;
end;

procedure TJvThreadAnimateDialog.SetFormHeightWidth;
var
  H, W: Integer;
begin
  H := 6;
  if Assigned(ThreadStatusDialog) then
  begin
    W := 200;
    if FInfoTextPanel.Visible then
    begin
      W := ThreadStatusDialog.Canvas.TextWidth(DialogOptions.FInfoText) + 80;
      if ThreadStatusDialog.Canvas.TextWidth(DialogOptions.FInfoText) + 80 > W then
        W := ThreadStatusDialog.Canvas.TextWidth(DialogOptions.FInfoText) + 80;
      H := H + FInfoTextPanel.Height;
    end;
    if FAnimatePanel.Visible then
    begin
      if FAnimate.Width + 20 > W then
        W := FAnimate.Width + 20;
      H := H + FAnimate.Height;
    end;
    FCancelBtn.Left := (W - FCancelBtn.Width) div 2;
    FAnimate.Left := (W - FAnimate.Width) div 2;
    if FTimeTextPanel.Visible then
      H := H + FTimeTextPanel.Height;
    if FCancelButtonPanel.Visible then
      H := H + FCancelButtonPanel.Height;
    if ThreadStatusDialog.ClientWidth <> W then
      ThreadStatusDialog.ClientWidth := W;
    if ThreadStatusDialog.ClientHeight <> H then
      ThreadStatusDialog.ClientHeight := H;
  end;
end;

procedure TJvThreadAnimateDialog.SetFormData;
begin
  if Assigned(ThreadStatusDialog) and Assigned(DialogOptions) then
  begin
    FInfoText.Caption := DialogOptions.FInfoText;
    ThreadStatusDialog.Caption := DialogOptions.Caption;
    FInfoTextPanel.Visible := DialogOptions.InfoText <> '';
    FAnimatePanel.Visible := FileExists(FAnimate.FileName) or (FAnimate.CommonAVI <> aviNone);
    FTimeTextPanel.Visible := DialogOptions.ShowElapsedTime;
    FCancelBtn.Enabled := DialogOptions.EnableCancelButton;
    FCancelButtonPanel.Visible := DialogOptions.ShowCancelButton;
    SetFormHeightWidth;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

