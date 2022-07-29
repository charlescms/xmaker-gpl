(*  GREATIS FORM DESIGNER DEMO                    *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit ToolForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, Clipbrd, Menus, FDMain, FDCmpPal,
  Mask;

type
  TfrmToolForm = class(TForm)
    pgcMain: TPageControl;
    sbtOpen: TSpeedButton;
    sbtSave: TSpeedButton;
    sbtAlignToGrid: TSpeedButton;
    sbtLock: TSpeedButton;
    sbtCut: TSpeedButton;
    sbtCopy: TSpeedButton;
    sbtPaste: TSpeedButton;
    sbtDelete: TSpeedButton;
    opdMain: TOpenDialog;
    svdMain: TSaveDialog;
    pmnMain: TPopupMenu;
    mniLock: TMenuItem;
    mniAlignToGrid: TMenuItem;
    mniCut: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniDelete: TMenuItem;
    mniSep1: TMenuItem;
    sbtSetup: TSpeedButton;
    sbtAbout: TSpeedButton;
    mniBringToFront: TMenuItem;
    mniSendToBack: TMenuItem;
    mniSep2: TMenuItem;
    sbtAlign: TSpeedButton;
    sbtSize: TSpeedButton;
    sbtAlignPalette: TSpeedButton;
    mniSelectAll: TMenuItem;
    sbtTabOrder: TSpeedButton;
    sbtSelectAll: TSpeedButton;
    sbtRelated: TSpeedButton;
    procedure sbtPaletteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eveLock(Sender: TObject);
    procedure eveAlign(Sender: TObject);
    procedure eveDelete(Sender: TObject);
    procedure eveCut(Sender: TObject);
    procedure evePaste(Sender: TObject);
    procedure eveCopy(Sender: TObject);
    procedure sbtOpenClick(Sender: TObject);
    procedure sbtSaveClick(Sender: TObject);
    procedure pmnMainPopup(Sender: TObject);
    procedure sbtSetupClick(Sender: TObject);
    procedure sbtAboutClick(Sender: TObject);
    procedure mniBringToFrontClick(Sender: TObject);
    procedure mniSendToBackClick(Sender: TObject);
    procedure sbtAlignClick(Sender: TObject);
    procedure sbtSizeClick(Sender: TObject);
    procedure eveSelectAll(Sender: TObject);
    procedure eveAlignPalette(Sender: TObject);
    procedure eveTabOrder(Sender: TObject);
    procedure sbtRelatedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ComponentClass: TComponentClass;
  end;

var
  frmToolForm: TfrmToolForm;

implementation

uses Design, Setup, About, Related;

{$R *.DFM}
{$R DB.RES}

procedure TfrmToolForm.sbtPaletteButtonClick(Sender: TObject);
begin
  {
  ComponentClass:=(Sender as TPaletteButton).ComponentClass;
  with frmDesign.cmpFormDesigner do
    if Assigned(ComponentClass) then
    begin
      if not Locked then Lock;
    end
    else Unlock;
  }
  ComponentClass:=(Sender as TPaletteButton).ComponentClass;
  if Assigned(ComponentClass) then frmDesign.cmpFormDesigner.PlaceComponentClass(ComponentClass)
  else frmDesign.cmpFormDesigner.CancelPlacing;
end;

procedure TfrmToolForm.FormShow(Sender: TObject);
begin
  frmDesign.Show;
  CreatePalettePage(pgcMain,'Standard',[TLabel,TEdit,TMemo,TButton,TCheckBox,TRadioButton,TListBox,TComboBox,TGroupBox,TRadioGroup,TPanel],sbtPaletteButtonClick);
  CreatePalettePage(pgcMain,'Additional',[TBitBtn,TSpeedButton,TMaskEdit,TImage,TShape,TBevel,TStaticText],sbtPaletteButtonClick);
  CreatePalettePage(pgcMain,'Dialogs',[TOpenDialog,TSaveDialog,TFontDialog,TColorDialog],sbtPaletteButtonClick);
end;

procedure TfrmToolForm.eveLock(Sender: TObject);
var
  i,IDX: Integer;
begin
  if Sender<>sbtLock then sbtLock.Down:=not sbtLock.Down;
  {$IFDEF TFD1COMPATIBLE}
  with frmDesign.cmpFormDesigner,FixedControls do
  {$ELSE}
  with frmDesign.cmpFormDesigner,LockedControls do
  {$ENDIF}
    for i:=0 to Pred(ControlCount) do
    begin
      IDX:=IndexOf(Controls[i].Name);
      if sbtLock.Down then
      begin
        if IDX=-1 then Add(Controls[i].Name);
      end
      else
        if IDX<>-1 then Delete(IDX);
    end;
end;

procedure TfrmToolForm.pmnMainPopup(Sender: TObject);
begin
  mniLock.Checked:=sbtLock.Down;
end;

procedure TfrmToolForm.eveAlign(Sender: TObject);
var
  i: Integer;
begin
  with frmDesign.cmpFormDesigner do
    for i:=0 to Pred(ControlCount) do
      if not IsLocked(Controls[i]) then
        AlignToGrid(Controls[i]);
end;

procedure TfrmToolForm.eveDelete(Sender: TObject);
var
  C: TControl;
begin
  if sbtDelete.Enabled then
    with frmDesign.cmpFormDesigner do
    begin
      while ControlCount>0 do
      begin
        C:=Controls[0];
        if C is TComponentContainer then
          TComponentContainer(C).Component.Free;
        C.Free;
      end;
    end;
end;

procedure TfrmToolForm.eveCut(Sender: TObject);
begin
  if sbtCut.Enabled then
    frmDesign.cmpFormDesigner.CutToClipboard;
end;

procedure TfrmToolForm.evePaste(Sender: TObject);
begin
  if sbtPaste.Enabled then
    frmDesign.cmpFormDesigner.PasteFromClipboard;
end;

procedure TfrmToolForm.eveCopy(Sender: TObject);
begin
  if sbtCopy.Enabled then
    frmDesign.cmpFormDesigner.CopyToClipboard;
end;

procedure TfrmToolForm.sbtOpenClick(Sender: TObject);
begin
  with opdMain do
    if Execute then
      frmDesign.cmpFormDesigner.LoadFromDFM(FileName,TDFMFormat(Pred(FilterIndex)));
end;

procedure TfrmToolForm.sbtSaveClick(Sender: TObject);
begin
  with svdMain do
    if Execute then
      frmDesign.cmpFormDesigner.SaveToDFM(FileName,TDFMFormat(Pred(FilterIndex)));
end;

procedure TfrmToolForm.sbtSetupClick(Sender: TObject);
begin
  frmSetup.ShowModal;
end;

procedure TfrmToolForm.sbtAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmToolForm.mniBringToFrontClick(Sender: TObject);
var
  i: Integer;
begin
  with frmDesign.cmpFormDesigner do
  begin
    for i:=Pred(ControlCount) downto 0 do Controls[i].BringToFront;
    Update;
  end;
end;

procedure TfrmToolForm.mniSendToBackClick(Sender: TObject);
var
  i: Integer;
begin
  with frmDesign.cmpFormDesigner do
  begin
    for i:=Pred(ControlCount) downto 0 do Controls[i].SendToBack;
    Update;
  end;
end;

procedure TfrmToolForm.sbtAlignClick(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.AlignDialog;
end;

procedure TfrmToolForm.sbtSizeClick(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.SizeDialog;
end;

procedure TfrmToolForm.eveSelectAll(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.SelectAll;
end;

procedure TfrmToolForm.eveAlignPalette(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.ShowAlignmentPalette;
end;

procedure TfrmToolForm.eveTabOrder(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.TabOrderDialog;
end;

procedure TfrmToolForm.sbtRelatedClick(Sender: TObject);
begin
  frmRelated.ShowModal;
end;

end.
