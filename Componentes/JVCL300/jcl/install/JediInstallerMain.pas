{**************************************************************************************************}
{  WARNING:  JEDI preprocessor generated unit.  Do not edit.                                       }
{**************************************************************************************************}

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL) extension                                                        }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JediInstallerMain.pas.                                                      }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) of Petr Vones. All Rights Reserved.                                                }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Andreas Hausladen (ahuser)                                                                     }
{   Robert Rossmair (rrossmair) - crossplatform & BCB support, refactoring                         }
{                                                                                                  }
{**************************************************************************************************}

// $Id: JediInstallerMain.pas,v 1.29 2005/03/13 00:23:35 rrossmair Exp $

unit JediInstallerMain;

{$I jcl.inc}
{$I crossplatform.inc}

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Menus, Buttons, ComCtrls, ImgList,
  ProductFrames,
  JclBorlandTools, JediInstall;

const
  UM_CHECKUPDATES = WM_USER + $100;

type
  TMainForm = class(TForm, IJediInstallTool)
    InstallBtn: TBitBtn;
    UninstallBtn: TBitBtn;
    QuitBtn: TBitBtn;
    JediImage: TImage;
    TitlePanel: TPanel;
    Title: TLabel;
    ProductsPageControl: TPageControl;
    StatusBevel: TBevel;
    StatusLabel: TLabel;
    Bevel1: TBevel;
    ProgressBar: TProgressBar;
    ImageList: TImageList;
    ReadmePage: TTabSheet;
    ReadmePane: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure InstallBtnClick(Sender: TObject);
    procedure UninstallBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure JediImageClick(Sender: TObject);
    procedure TreeViewCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure BplPathEditChange(Sender: TObject);
  private
    FBorRADToolInstallations: TJclBorRADToolInstallations;
    FJclInstall: IJediInstall;
    FSystemPaths: TStringList;
    FFeatureNode: TTreeNode;
    FFeatureChanged: Boolean;
    FHintPos: TPoint;
    function ActiveView: TProductFrame;
    function CheckUpdatePack(Installation: TJclBorRADToolInstallation): Boolean;
    function CreateView(Installation: TJclBorRADToolInstallation): Boolean;
    function ExpandOptionTree(Installation: TJclBorRADToolInstallation): Boolean;
    procedure InstallationStarted(Installation: TJclBorRADToolInstallation);
    procedure InstallationFinished(Installation: TJclBorRADToolInstallation);
    procedure InstallationProgress(Percent: Cardinal);
    procedure ReadSystemPaths;
    function View(Installation: TJclBorRADToolInstallation): TProductFrame;
    procedure UMCheckUpdates(var Message: TMessage); message UM_CHECKUPDATES;
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewEnter(Sender: TObject);
    procedure TreeViewExit(Sender: TObject);
    procedure TreeViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure UpdateFeatureInfo(Node: TTreeNode);
  protected
    function InfoFile(Node: TTreeNode): string;
    function OptionGUI(Installation: TJclBorRADToolInstallation): TObject;
    function GUIAddOption(GUI, Parent: TObject; Option: TJediInstallOption; const Text: string;
      GUIOptions: TJediInstallGUIOptions): TObject;
    procedure HandleException(Sender: TObject; E: Exception);
    property JclDistribution: IJediInstall read FJclInstall;
    // IJediInstallTool
    function GetBPLPath(Installation: TJclBorRADToolInstallation): string;
    function GetDCPPath(Installation: TJclBorRADToolInstallation): string;
    procedure SetBPLPath(Installation: TJclBorRADToolInstallation; const Value: string);
    procedure SetDCPPath(Installation: TJclBorRADToolInstallation; const Value: string);
  public
    procedure ShowFeatureHint(var HintStr: string;
      var CanShow: Boolean; var HintInfo: THintInfo);
    function CheckRunningInstances: Boolean;
    procedure Install;
    procedure Uninstall;
    function SystemPathValid(const Path: string): Boolean;
    // IJediInstallTool
    function FeatureChecked(FeatureID: Cardinal; Installation: TJclBorRADToolInstallation): Boolean;
    function GetBorRADToolInstallations: TJclBorRADToolInstallations;
    function Dialog(const Text: string; DialogType: TDialogType = dtInformation;
      Options: TDialogResponses = [drOK]): TDialogResponse;
    procedure SetReadme(const FileName: string);
    procedure UpdateInfo(Installation: TJclBorRADToolInstallation; const InfoText: String);
    procedure UpdateStatus(const Text: string);
    procedure WriteInstallLog(Installation: TJclBorRADToolInstallation; const Text: string);
    property BorRADToolInstallations: TJclBorRADToolInstallations read FBorRADToolInstallations;
    property BPLPath[Installation: TJclBorRADToolInstallation]: string read GetBPLPath write SetBPLPath;
    property DCPPath[Installation: TJclBorRADToolInstallation]: string read GetDCPPath write SetDCPPath;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  FileCtrl,
  JclDebug, JclShell,
  JclBase, JclFileUtils, JclStrings, JclSysInfo, JclSysUtils,
  JclInstall;

const
  {$IFNDEF RTL140_UP}
  PathSep = ';';
  {$ENDIF RTL140_UP}
  SupportURLs: array[TJclBorRADToolKind] of string = (
                'http://www.borland.com/devsupport/delphi/',
                'http://www.borland.com/devsupport/bcppbuilder/');
  DelphiJediURL     = 'http://delphi-jedi.org';
  VersionSignature  = 'D%d';
  BCBTag            = $10000;
  VersionMask       = $FFFF;

function FeatureID(Node: TTreeNode): Cardinal;
begin
  Result := Cardinal(Node.Data) and FID_NumberMask;
end;

{ TMainForm }

function TMainForm.ActiveView: TProductFrame;
var
  Page: TTabSheet;
  Control: TControl;
begin
  Result := nil;
  Page := ProductsPageControl.ActivePage;
  Control := Page.Controls[0];
  if Control is TProductFrame then
    Result := TProductFrame(Control);
end;

function TMainForm.InfoFile(Node: TTreeNode): string;
begin
  if Assigned(Node) then
    Result := FJclInstall.FeatureInfoFileName(FeatureID(Node));
end;

function TMainForm.CreateView(Installation: TJclBorRADToolInstallation): Boolean;
var
  Page: TTabSheet;
  ProductFrame: TProductFrame;
begin
  Page := TTabSheet.Create(Self);
  with Installation do
  begin
    Page.Name := Format('%s%dPage', [Prefixes[RADToolKind], VersionNumber]);
    Page.Caption := Name;
  end;
  Page.PageControl := ProductsPageControl;
  ProductFrame := TProductFrame.Create(Self);
  ProductFrame.Installation := Installation;
  ProductFrame.TreeView.Images := ImageList;
  ProductFrame.TreeView.OnChange := TreeViewChange;
  ProductFrame.TreeView.OnCollapsing := TreeViewCollapsing;
  ProductFrame.TreeView.OnEnter := TreeViewEnter;
  ProductFrame.TreeView.OnExit := TreeViewExit;
  ProductFrame.TreeView.OnMouseMove := TreeViewMouseMove;
  ProductFrame.Align := alClient;
  ProductFrame.Parent := Page;
  FJclInstall.SetOnWriteLog(Installation, ProductFrame.LogOutputLine);
  Result := True;
end;

function TMainForm.CheckRunningInstances: Boolean;
begin
  Result := FBorRADToolInstallations.AnyInstanceRunning;
  if Result then
    Dialog(RsCloseRADTool, dtWarning);
end;

function TMainForm.CheckUpdatePack(Installation: TJclBorRADToolInstallation): Boolean;
var
  Msg: string;
begin
  Result := True;
  with Installation do
    if UpdateNeeded then
    begin
      Msg := Format(RsUpdateNeeded, [LatestUpdatePack, Name]);
      if Dialog(Msg, dtWarning, [drYes, drNo]) = drYes then
        ShellExecEx(SupportURLs[RadToolKind]);
    end;
end;

function TMainForm.GUIAddOption(GUI, Parent: TObject; Option: TJediInstallOption;
  const Text: string; GUIOptions: TJediInstallGUIOptions): TObject;
const
  Icon: array[Boolean] of Integer = (IcoUnchecked, IcoChecked);
  Flag: array[Boolean] of Cardinal = (0, FID_Checked);
var
  FeatureID: Cardinal;
  Nodes: TTreeNodes;
  Node, ParentNode: TTreeNode;
  Checked: Boolean;
begin
  ParentNode := TTreeNode(Parent);
  Checked := goChecked in GUIOptions;
  {
  if Assigned(Parent) and not (goRadioButton in GUIOptions) then
  begin
    Assert(Parent is TTreeNode);
    if Checked and Assigned(Parent) then
      if ParentNode.ImageIndex <> IcoChecked then
      begin
        Checked := False;
        Exclude(GUIOptions, goChecked);
      end;
  end;
  }
  FeatureID := Cardinal(Ord(Option)) + Flag[goChecked in GUIOptions];
  if goStandAloneParent in GUIOptions then
    FeatureID := FeatureID + FID_StandAloneParent;
  if goRadioButton in GUIOptions  then
    FeatureID := FeatureID + FID_RadioButton;
  if goExpandable in GUIOptions then
    FeatureID := FeatureID + FID_Expandable;
  Nodes := TTreeNodes(GUI);
  if Parent = nil then
    Node := Nodes.AddObject(nil, Text, Pointer(FeatureID))
  else
    Node := Nodes.AddChildObject(ParentNode, Text, Pointer(FeatureID));
  Node.ImageIndex := Icon[Checked];
  Node.SelectedIndex := Icon[Checked];
  Result := Node;
end;

procedure TMainForm.HandleException(Sender: TObject; E: Exception);
begin
  if E is EJediInstallInitFailure then
  begin
    Dialog(E.Message, dtError);
    Application.ShowMainForm := False;
    Application.Terminate;
  end
  else
    Application.ShowException(E);
end;

procedure TMainForm.Install;
var
  Res: Boolean;
begin
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  Screen.Cursor := crHourGlass;
  try
    Res := FJclInstall.Install;
    Screen.Cursor := crDefault;
    if Res then
      Dialog(RsInstallSuccess)
    else
      Dialog(RsInstallFailure);
  finally
    ProgressBar.Visible := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.Uninstall;
begin
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  Screen.Cursor := crHourGlass;
  try
    FJclInstall.Uninstall;
    Screen.Cursor := crDefault;
  finally
    ProgressBar.Visible := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.InstallationProgress(Percent: Cardinal);
begin
  ProgressBar.Position := Percent;
end;

function TMainForm.View(Installation: TJclBorRADToolInstallation): TProductFrame;
begin
  if not Assigned(Installation) then
    Result := nil
  else
    with Installation do
      Result := FindComponent(TProductFrame.GetName(Installation)) as TProductFrame;
end;

procedure TMainForm.ReadSystemPaths;
var
  PathVar: string;
  I: Integer;
begin
  if GetEnvironmentVar('PATH', PathVar, False) then
  begin
    StrToStrings(PathVar, PathSep, FSystemPaths, False);
    for I := 0 to FSystemPaths.Count - 1 do
    begin
      PathVar := StrTrimQuotes(FSystemPaths[I]);
      ExpandEnvironmentVar(PathVar);
      PathVar := AnsiUpperCase(PathRemoveSeparator(PathGetLongName(PathVar)));
      FSystemPaths[I] := PathVar;
    end;
    FSystemPaths.Sorted := True;
  end;
end;

function TMainForm.SystemPathValid(const Path: string): Boolean;
begin
  Result := FSystemPaths.IndexOf(AnsiUpperCase(Path)) <> -1;
end;

procedure TMainForm.UpdateInfo(Installation: TJclBorRADToolInstallation; const InfoText: String);
var
  P: TProductFrame;
begin
  P := View(Installation);
  if Assigned(P) then
  begin
    P.InfoDisplay.Text := InfoText;
  end;
end;

procedure TMainForm.UpdateStatus(const Text: string);
begin
  if Text = '' then
  begin
    StatusBevel.Visible := False;
    StatusLabel.Visible := False;
  end
  else
  begin
    StatusLabel.Caption := Text;
    StatusBevel.Visible := True;
    StatusLabel.Visible := True;
  end;
  Application.ProcessMessages;  //Update;
end;

procedure TMainForm.WriteInstallLog(Installation: TJclBorRADToolInstallation; const Text: string);
var
  P: TProductFrame;
begin
  P := View(Installation);
  if Assigned(P) then
    P.LogOutputLine(Text);
end;

function TMainForm.GetBPLPath(Installation: TJclBorRADToolInstallation): string;
var
  P: TProductFrame;
  Path: string;
begin
  P := View(Installation);
  if Assigned(P) then
    Path := P.BplPathEdit.Text;
  Result := PathRemoveSeparator(Installation.SubstitutePath(Path));
end;

function TMainForm.GetDCPPath(Installation: TJclBorRADToolInstallation): string;
var
  P: TProductFrame;
  Path: string;
begin
  P := View(Installation);
  if Assigned(P) then
    Path := P.DcpPathEdit.Text;
  Result := PathRemoveSeparator(Installation.SubstitutePath(Path));
end;

procedure TMainForm.BplPathEditChange(Sender: TObject);
begin
  with (Sender as TEdit) do
    if SystemPathValid(Text) then
      Font.Color := clWindowText
    else
      Font.Color := clRed;
end;

function TMainForm.FeatureChecked(FeatureID: Cardinal; Installation: TJclBorRADToolInstallation): Boolean;
var
  P: TProductFrame;
begin
  Result := False;
  P := View(Installation);
  if Assigned(P) then
    Result := P.FeatureChecked(FeatureID);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnException := HandleException;
  FBorRADToolInstallations := TJclBorRADToolInstallations.Create;
  FSystemPaths := TStringList.Create;
  JediImage.Hint := DelphiJediURL;
  FJclInstall := CreateJclInstall;
  FJclInstall.SetOnProgress(InstallationProgress);
  FJclInstall.SetOnStarting(InstallationStarted);
  FJclInstall.SetOnEnding(InstallationFinished);
  FJclInstall.SetTool(Self);
  BorRADToolInstallations.Iterate(ExpandOptionTree);

  UpdateStatus('');

  ReadSystemPaths;
  TitlePanel.DoubleBuffered := True;
  Application.HintPause := 50;
  Application.OnShowHint := ShowFeatureHint;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FBorRADToolInstallations);
  FreeAndNil(FSystemPaths);
end;


procedure TMainForm.UMCheckUpdates(var Message: TMessage);
begin
  BorRADToolInstallations.Iterate(CheckUpdatePack);
  Message.Result := 0;
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
  Close;
end;

function TMainForm.ExpandOptionTree(
  Installation: TJclBorRADToolInstallation): Boolean;
var
  P: TProductFrame;
begin
  Result := False;
  P := View(Installation);
  if Assigned(P) then
  begin
    P.UpdateTree;
    Result := True;
  end;
end;

procedure TMainForm.InstallBtnClick(Sender: TObject);
begin
  if ( IsDebuggerAttached or  not CheckRunningInstances) and
    (Dialog(RsConfirmInstall, dtConfirmation, [drYes, drNo]) = drYes) then
  begin
    Install;
    QuitBtn.SetFocus;
  end;
end;

procedure TMainForm.UninstallBtnClick(Sender: TObject);
begin
  if ( IsDebuggerAttached or  not CheckRunningInstances) then
  begin
    Uninstall;
    QuitBtn.SetFocus;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  PostMessage(Handle, UM_CHECKUPDATES, 0, 0);
end;

procedure TMainForm.JediImageClick(Sender: TObject);
begin
  { TODO : implement for Unix }
  ShellExecEx(DelphiJediURL);
end;

procedure TMainForm.TreeViewCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse := Collapsable(Node);
end;

function TMainForm.GetBorRADToolInstallations: TJclBorRADToolInstallations;
begin
  Result := FBorRADToolInstallations;
end;

procedure TMainForm.InstallationStarted(Installation: TJclBorRADToolInstallation);
var
  P: TProductFrame;
begin
  P := View(Installation);
  P.InfoDisplay.Lines.Clear;
  ProductsPageControl.ActivePage := P.Parent as TTabSheet;
  P.StartCompilation(Installation);
end;

procedure TMainForm.InstallationFinished(Installation: TJclBorRADToolInstallation);
var
  P: TProductFrame;
begin
  P := View(Installation);
  P.StopCompilation(Installation);
  P.InfoDisplay.Lines.SaveToFile(JclInstall.LogFileName(Installation));
end;

function TMainForm.Dialog(const Text: string; DialogType: TDialogType = dtInformation;
  Options: TDialogResponses = [drOK]): TDialogResponse;
const
  DlgType: array[TDialogType] of TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation);
  DlgButton: array[TDialogResponse] of TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel);
  DlgResult: array[TDialogResponse] of Word = (mrYes, mrNo, mrOK, mrCancel);
var
  Buttons: TMsgDlgButtons;
  Res: Integer;
begin
  Buttons := [];
  for Result := Low(TDialogResponse) to High(TDialogResponse) do
    if Result in Options then
      Include(Buttons, DlgButton[Result]);
  Res := MessageDlg(Text, DlgType[DialogType], Buttons, 0);
  for Result := Low(TDialogResponse) to High(TDialogResponse) do
    if DlgResult[Result] = Res then
      Break;
end;

procedure TMainForm.SetBPLPath(Installation: TJclBorRADToolInstallation; const Value: string);
var
  P: TProductFrame;
begin
  P := View(Installation);
  if Assigned(P) then
    P.BplPathEdit.Text := Value;
end;

procedure TMainForm.SetDCPPath(Installation: TJclBorRADToolInstallation; const Value: string);
var
  P: TProductFrame;
begin
  P := View(Installation);
  if Assigned(P) then
    P.DcpPathEdit.Text := Value;
end;

procedure TMainForm.SetReadme(const FileName: string);
begin
  ReadmePane.Lines.LoadFromFile(FileName);
  ShellExecEx('..\docs\Readme.html');
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  UpdateFeatureInfo(Node);
end;

procedure TMainForm.TreeViewEnter(Sender: TObject);
begin
  with ActiveView  do
    if InfoDisplay.ReadOnly then
      UpdateFeatureInfo(TreeView.Selected);
end;

procedure TMainForm.TreeViewExit(Sender: TObject);
begin
  //
end;

procedure TMainForm.TreeViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  UpdateFeatureInfo(ActiveView.TreeView.GetNodeAt(X, Y));
end;

procedure TMainForm.UpdateFeatureInfo(Node: TTreeNode);
begin
  if Assigned(Node) and (Node <> FFeatureNode) then
  begin
    FFeatureNode := Node;
    FFeatureChanged := True;
  end;
end;

procedure TMainForm.ShowFeatureHint;
var
  View: TProductFrame;
begin
  View := ActiveView;
  if Assigned(View) and (HintInfo.HintControl = View.TreeView) then
  begin
    if FFeatureChanged then
    begin
      HintInfo.HintStr := FJclInstall.GetHint(TJediInstallOption(FeatureID(FFeatureNode) and $FF));
      FHintPos := HintInfo.HintPos;
      FFeatureChanged := False;
    end                      
    else
      HintInfo.HintPos := FHintPos;
    HintInfo.ReshowTimeout := 500;
  end;
end;

function TMainForm.OptionGUI(
  Installation: TJclBorRADToolInstallation): TObject;
begin
  Result := View(Installation);
  if Result = nil then
    CreateView(Installation);
  Result := View(Installation).TreeView.Items;
end;

end.
