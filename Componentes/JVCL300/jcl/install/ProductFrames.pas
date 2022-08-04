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

// $Id: ProductFrames.pas,v 1.22 2005/03/14 16:04:04 rrossmair Exp $

unit ProductFrames;

interface

{$I jcl.inc}
{$I crossplatform.inc}

uses
  SysUtils, Classes,
  Graphics, Forms, Controls, StdCtrls, ComCtrls, ExtCtrls,
  JclBorlandTools, JediInstall;

const
  // Feature masks
  FID_RadioButton          = $10000000;
  FID_Expandable           = $20000000;
  FID_StandaloneParent     = $40000000; // do not auto-uncheck when all child nodes are unchecked
  FID_Checked              = $80000000;
  FID_NumberMask           = $0FFFFFFF;

  // Icon indexes
  IcoProduct               = 0;
  IcoLevel1                = 1;
  IcoChecked               = 2;
  IcoUnchecked             = 3;

type
  TProductFrame = class(TFrame)
    ComponentsTreePanel: TPanel;
    Label1: TLabel;
    TreeView: TTreeView;
    Splitter: TSplitter;
    InfoPanel: TPanel;
    Label2: TLabel;
    InfoDisplay: TRichEdit;
    OptionsGroupBox: TGroupBox;
    BplPathLabel: TLabel;
    DcpPathLabel: TLabel;
    BplPathEdit: TEdit;
    Button1: TButton;
    Button2: TButton;
    DcpPathEdit: TEdit;
    procedure PathEditChange(Sender: TObject);
    procedure PathSelectBtnClick(Sender: TObject);
    procedure SplitterCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeViewKeyPress(Sender: TObject; var Key: Char);
    procedure TreeViewCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
    FInstallation: TJclBorRADToolInstallation;
    function GetNodeChecked(Node: TTreeNode): Boolean;
    function IsRadioButton(Node: TTreeNode): Boolean;
    function IsStandAloneParent(Node: TTreeNode): Boolean;
    procedure SetInstallation(Value: TJclBorRADToolInstallation);
    procedure SetNodeChecked(Node: TTreeNode; const Value: Boolean);
    procedure ToggleNodeChecked(Node: TTreeNode);
  public
    { Public declarations }
    class function GetName(Installation: TJclBorRADToolInstallation): string;
    function FeatureChecked(FeatureID: Cardinal): Boolean;
    procedure LogOutputLine(const Line: string);
    procedure UpdateTree;
    procedure StartCompilation(Installation: TJclBorRADToolInstallation);
    procedure StopCompilation(Installation: TJclBorRADToolInstallation);
    property NodeChecked[Node: TTreeNode]: Boolean read GetNodeChecked write SetNodeChecked;
    property Installation: TJclBorRADToolInstallation read FInstallation write SetInstallation;
  end;

function Collapsable(Node: TTreeNode): Boolean;

implementation

{$R *.dfm}

uses
  Windows, Messages,
  FileCtrl, FrmCompile,
  JclStrings,
  JclInstall;

resourcestring
  RsSelectPath      = 'Select path';
  RsEnterValidPath  = '(Enter valid path)';

function Collapsable(Node: TTreeNode): Boolean;
begin
  Result := (Cardinal(Node.Data) and FID_Expandable) <> 0;
end;

procedure TProductFrame.PathEditChange(Sender: TObject);
begin
  with (Sender as TEdit) do
    if DirectoryExists(Text) then
      Font.Color := clWindowText
    else
      Font.Color := clRed;
end;

function TProductFrame.FeatureChecked(FeatureID: Cardinal): Boolean;
var
  F: Cardinal;
  Node: TTreeNode;
begin
  Result := False;
  Node := TreeView.Items.GetFirstNode;
  while Node <> nil do
  begin
    F := Cardinal(Node.Data);
    if F and FID_NumberMask = FeatureID then
    begin
      Result := F and FID_Checked <> 0;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

class function TProductFrame.GetName(Installation: TJclBorRADToolInstallation): string;
begin
  Result := Format('%s%dProduct', [Prefixes[Installation.RADToolKind], Installation.VersionNumber]);
end;

function TProductFrame.GetNodeChecked(Node: TTreeNode): Boolean;
begin
  Result := Cardinal(Node.Data) and FID_Checked <> 0;
end;

function TProductFrame.IsRadioButton(Node: TTreeNode): Boolean;
begin
  Result := Cardinal(Node.Data) and FID_RadioButton <> 0;
end;

function TProductFrame.IsStandAloneParent(Node: TTreeNode): Boolean;
begin
  Result := Cardinal(Node.Data) and FID_StandAloneParent <> 0;
end;

procedure TProductFrame.LogOutputLine(const Line: string);

  function Cmp(const S: string): Boolean;
  begin
    Result := Copy(Line, 1, Length(S)) = S;
  end;

begin
  if FormCompile.HandleLine(Line) <> clFileProgress then
  begin
    if Cmp(AnsiLineBreak + 'Installing package ') then
      FormCompile.Linking(Copy(Line, 20, MaxInt))
    else if Cmp('Copying .hpp files...') then
      FormCompile.Done;

    InfoDisplay.Lines.Append(Line);
    InfoDisplay.Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

procedure TProductFrame.SetInstallation(Value: TJclBorRADToolInstallation);

  function GetPathForEdit(Path: string): string;
  begin
    if DirectoryExists(Path) then
      Result := Path
    else
      Result := RsEnterValidPath;
  end;

begin
  FInstallation := Value;
  Name := GetName(Value);
  if Value.RadToolKind = brCppBuilder then
    DcpPathLabel.Caption := '.bpi Path';
  BplPathEdit.Text := GetPathForEdit(Installation.BPLOutputPath);
  DcpPathEdit.Text := GetPathForEdit(Installation.DCPOutputPath);
end;

procedure TProductFrame.SetNodeChecked(Node: TTreeNode; const Value: Boolean);

  procedure UpdateNode(N: TTreeNode; C: Boolean);
  const
    CheckedState: array[Boolean] of Cardinal = (0, FID_Checked);
  begin
    N.Data := Pointer(Cardinal(N.Data) and (not FID_Checked) or CheckedState[C]);
    if C then
    begin
      N.ImageIndex := IcoChecked;
      N.SelectedIndex := IcoChecked;
    end
    else
    begin
      N.ImageIndex := IcoUnchecked;
      N.SelectedIndex := IcoUnchecked;
    end;
  end;

  procedure UpdateTreeDown(N: TTreeNode; C: Boolean);
  begin
    N := N.getFirstChild;
    while Assigned(N) do
    begin
      if not IsRadioButton(N) then
        UpdateNode(N, C);
      UpdateTreeDown(N, C);
      N := N.getNextSibling;
    end;
  end;

  procedure UpdateTreeUp(N: TTreeNode; C: Boolean);
  var
    ParentNode: TTreeNode;
    ParentChecked: Boolean;
  begin
    if C then
      while Assigned(N) do
      begin
        UpdateNode(N, True);
        N := N.Parent;
      end
    else
    begin
      ParentNode := N.Parent;
      while Assigned(ParentNode) do
      begin
        N := ParentNode.getFirstChild;
        ParentChecked := IsStandAloneParent(ParentNode);
        while Assigned(N) do
          if NodeChecked[N] and not IsRadioButton(N) then
          begin
            ParentChecked := True;
            Break;
          end
          else
            N := N.getNextSibling;
        UpdateNode(ParentNode, ParentChecked);
        ParentNode := ParentNode.Parent;
      end;
    end;
  end;

  procedure UpdateRadioButton(N: TTreeNode; C: Boolean);
  var
    Node: TTreeNode;
  begin
    if Value and not NodeChecked[N] then
    begin
      Node := N.Parent;
      if Node <> nil then
      begin
        Node := Node.getFirstChild;
        while Node <> nil do
        begin
          if IsRadioButton(Node) then
            UpdateNode(Node, Node = N);
          Node := Node.getNextSibling;
        end;
      end;
    end;
  end;

begin
  if IsRadioButton(Node) then
    UpdateRadioButton(Node, Value)
  else
  begin
    UpdateNode(Node, Value);
    UpdateTreeDown(Node, Value);
    UpdateTreeUp(Node, Value);
  end;
end;

procedure TProductFrame.ToggleNodeChecked(Node: TTreeNode);
begin
  if Assigned(Node) then
    NodeChecked[Node] := not NodeChecked[Node];
end;

procedure TProductFrame.PathSelectBtnClick(Sender: TObject);
var
  I: Integer;
  Button: TButton;
  Edit: TEdit;
  {$IFDEF USE_WIDESTRING}
  Directory: WideString;
  {$UNDEF USE_WIDESTRING}
  {$ELSE}
  Directory: string;
  {$ENDIF}
begin
  Button := Sender as TButton;
  Edit := nil;
  with Button.Parent do
    for I := 0 to ControlCount - 1 do
      if (Controls[I].Top = Button.Top) and (Controls[I] is TEdit) then
        Edit := TEdit(Controls[I]);
  if Assigned(Edit) and SelectDirectory(RsSelectPath, '', Directory) then
    Edit.Text := Directory;
end;

procedure TProductFrame.SplitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := NewSize > 150;
end;

procedure TProductFrame.TreeViewCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; 
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  case TTreeNode(Node).Level of
    0: begin
         Sender.Canvas.Font.Style := [fsBold, fsUnderline];
       end;
    1: begin
         Sender.Canvas.Font.Style := [fsBold];
       end;
  end;
end;

procedure TProductFrame.TreeViewKeyPress(Sender: TObject; var Key: Char);
begin
  with TTreeView(Sender) do
    case Key of
      #32:
        begin
          ToggleNodeChecked(Selected);
          Key := #0;
        end;
      '+':
        Selected.Expanded := True;
      '-':
        Selected.Expanded := False;
    end;
end;

function TreeNodeIconHit(TreeView: TTreeView; X, Y: Integer): Boolean;
begin
  Result := htOnIcon in TreeView.GetHitTestInfoAt(X, Y);
end;

procedure TProductFrame.TreeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
begin
  with TTreeView(Sender) do
  begin
    Node := GetNodeAt(X, Y);
    if (Button = mbLeft) and TreeNodeIconHit(TreeView, X, Y) then
      ToggleNodeChecked(Node);
  end;
end;

procedure TProductFrame.UpdateTree;
var
  Node: TTreeNode;
begin
  Node := TreeView.Items.GetFirstNode;
  while Node <> nil do
  begin
    if not Collapsable(Node) then
      Node.Expand(False);
    Node := Node.GetNext;
  end;
end;

procedure TProductFrame.StartCompilation(Installation: TJclBorRADToolInstallation);
begin
  if not Assigned(FormCompile) then
    FormCompile := TFormCompile.Create(Self);
  SetWindowLong(FormCompile.Handle, GWL_HWNDPARENT, Handle);
  FormCompile.Init(Installation.Name, True);
  FormCompile.Show;
  Application.ProcessMessages;
end;

procedure TProductFrame.StopCompilation(Installation: TJclBorRADToolInstallation);
begin
  if FormCompile.Errors > 0 then // do not make the dialog modal when no error occured
    FormCompile.Done(' ')
  else
    FormCompile.Done;
  FormCompile.Free;
  FormCompile := nil;
end;

end.
