(*  GREATIS FORM DESIGNER DEMO                    *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Design;

interface

uses
  Windows, Messages, Forms, SysUtils, IniFiles, Classes, Controls,
  StdCtrls, ExtCtrls, Dialogs, FDMain, Menus;

type

  TfrmDesign = class(TForm)
    cmpFormDesigner: TFormDesigner;
    procedure FormShow(Sender: TObject);
    procedure cmpFormDesignerSelectControl(Sender: TObject;
      TheControl: TControl);
    procedure FormActivate(Sender: TObject);
    procedure cmpFormDesignerLoadControl(Sender: TObject;
      TheControl: TControl; IniFile: TIniFile);
    procedure cmpFormDesignerSaveControl(Sender: TObject;
      TheControl: TControl; IniFile: TIniFile);
    procedure FormCreate(Sender: TObject);
    procedure cmpFormDesignerControlDblClick(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmpFormDesignerMoveSizeControl(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerDeleteControl(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerPlaceComponent(Sender: TObject;
      TheComponent: TComponent);
  private
    { Private declarations }
    procedure UpdateInfo;
  public
    { Public declarations }
  end;

var
  frmDesign: TfrmDesign;

implementation

uses FDCmpPal, ToolForm;

{$R *.DFM}
//{$R XP.RES}

procedure TfrmDesign.UpdateInfo;
begin
  if Assigned(cmpFormDesigner.Control) then
    with cmpFormDesigner do
      with Control do
        Caption:=Format(
          'Name: %s; Class: %s; Left: %d; Top: %d; Width: %d; Height: %d',
          [Name,ClassName,Left,Top,Width,Height])
  else Caption:='[no selected components]';
end;

procedure TfrmDesign.FormShow(Sender: TObject);
begin
  cmpFormDesigner.Active:=True;
end;

procedure TfrmDesign.cmpFormDesignerSelectControl(Sender: TObject;
  TheControl: TControl);
var
  E: Boolean;
begin
  if Assigned(TheControl) then
    {$IFDEF TFD1COMPATIBLE}
    frmToolForm.sbtLock.Down:=cmpFormDesigner.FixedControls.IndexOf(TheControl.Name)<>-1;
    {$ELSE}
    frmToolForm.sbtLock.Down:=cmpFormDesigner.LockedControls.IndexOf(TheControl.Name)<>-1;
    {$ENDIF}
  UpdateInfo;
  E:=Assigned(cmpFormDesigner.Control);
  with frmToolForm do
  begin
    sbtLock.Enabled:=E;
    sbtAlignToGrid.Enabled:=E;
    sbtAlign.Enabled:=E;
    sbtSize.Enabled:=E;
    sbtDelete.Enabled:=E;
    mniLock.Enabled:=E;
    mniAlignToGrid.Enabled:=E;
    mniDelete.Enabled:=E;
    sbtCopy.Enabled:=E;
    sbtCut.Enabled:=E;
    mniCopy.Enabled:=E;
    mniCut.Enabled:=E;
  end;
end;

procedure TfrmDesign.FormActivate(Sender: TObject);
begin
  ActiveControl:=nil;
  cmpFormDesigner.Update;
end;

procedure TfrmDesign.cmpFormDesignerLoadControl(Sender: TObject;
  TheControl: TControl; IniFile: TIniFile);
begin
  if TheControl=Self then
    with IniFile do
    begin
      Left:=ReadInteger('@Form','Left',Left);
      Top:=ReadInteger('@Form','Top',Top);
      Width:=ReadInteger('@Form','Width',Width);
      Height:=ReadInteger('@Form','Height',Height);
    end;
end;

procedure TfrmDesign.cmpFormDesignerSaveControl(Sender: TObject;
  TheControl: TControl; IniFile: TIniFile);
begin
  if TheControl=Self then
    with IniFile do
    begin
      WriteInteger('@Form','Left',Left);
      WriteInteger('@Form','Top',Top);
      WriteInteger('@Form','Width',Width);
      WriteInteger('@Form','Height',Height);
    end;
  with IniFile do
    if TheControl is TButton then
      with TButton(TheControl) do
      begin
        WriteString(Name,'OnClick',Self.MethodName(@OnClick));
      end;
end;

procedure TfrmDesign.FormCreate(Sender: TObject);
begin
  cmpFormDesigner.PopupMenu:=frmToolForm.pmnMain;
end;

procedure TfrmDesign.cmpFormDesignerControlDblClick(Sender: TObject;
  TheControl: TControl);
begin
  if Assigned(TheControl) then
  begin
    if TheControl is TComponentContainer then
      ShowMessage('Double-click on '+TComponentContainer(TheControl).Component.Name)
    else ShowMessage('Double-click on '+TheControl.Name);
    ActiveControl:=nil;
  end;
end;

procedure TfrmDesign.cmpFormDesignerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  with frmToolForm do
    case Key of
      VK_INSERT:
        if Shift=[ssShift] then evePaste(nil)
        else
          if Shift=[ssCtrl] then eveCopy(nil);
      VK_DELETE:
        if Shift=[ssShift] then eveCut(nil)
        else
          if Shift=[] then eveDelete(nil);
    end;
end;

procedure TfrmDesign.cmpFormDesignerMoveSizeControl(Sender: TObject;
  TheControl: TControl);
begin
  UpdateInfo;
end;

procedure TfrmDesign.cmpFormDesignerDeleteControl(Sender: TObject;
  TheControl: TControl);
begin
  UpdateInfo;
end;

procedure TfrmDesign.cmpFormDesignerPlaceComponent(Sender: TObject;
  TheComponent: TComponent);
begin
  EditMode(frmToolForm.pgcMain);
end;

end.
