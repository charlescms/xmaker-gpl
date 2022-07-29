(*  GREATIS FORM DESIGNER DEMO                    *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Setup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmSetup = class(TForm)
    lblGridStep: TLabel;
    lblDesignerColor: TLabel;
    lblGridColor: TLabel;
    chbDisplayGrid: TCheckBox;
    chbSnapToGrid: TCheckBox;
    edtGridStep: TEdit;
    udnGridStep: TUpDown;
    pnlDesignerColor: TPanel;
    btnDesignerColor: TButton;
    pnlGridColor: TPanel;
    btnGridColor: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    cldMain: TColorDialog;
    grbNormalGrabs: TGroupBox;
    pnlNBorder: TPanel;
    btnNBorder: TButton;
    lblNBorder: TLabel;
    pnlNFill: TPanel;
    btnNFill: TButton;
    lblNFill: TLabel;
    grbLockedGrabs: TGroupBox;
    lblLBorder: TLabel;
    lblLFill: TLabel;
    pnlLBorder: TPanel;
    btnLBorder: TButton;
    pnlLFill: TPanel;
    btnLFill: TButton;
    lblGrabSize: TLabel;
    edtGrabSize: TEdit;
    udnGrabSize: TUpDown;
    chbShowHint: TCheckBox;
    grbMultiGrabs: TGroupBox;
    lblMBorder: TLabel;
    lblMFill: TLabel;
    pnlMBorder: TPanel;
    btnMBorder: TButton;
    pnlMFill: TPanel;
    btnMFill: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDesignerColorClick(Sender: TObject);
    procedure btnGridColorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnNBorderClick(Sender: TObject);
    procedure btnNFillClick(Sender: TObject);
    procedure btnLBorderClick(Sender: TObject);
    procedure btnLFillClick(Sender: TObject);
    procedure btnMBorderClick(Sender: TObject);
    procedure btnMFillClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation

uses Design;

{$R *.DFM}

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  with frmDesign.cmpFormDesigner do
  begin
    if DesignerColor<>clNone then pnlDesignerColor.Color:=DesignerColor
    else pnlDesignerColor.Color:=clBtnFace;
    if GridColor<>clNone then pnlGridColor.Color:=GridColor
    else pnlGridColor.Color:=Font.Color;
    pnlNBorder.Color:=NormalGrabBorder;
    pnlNFill.Color:=NormalGrabFill;
    pnlLBorder.Color:=LockedGrabBorder;
    pnlLFill.Color:=LockedGrabFill;
    udnGridStep.Position:=GridStep;
    chbDisplayGrid.Checked:=DisplayGrid;
    chbSnapToGrid.Checked:=SnapToGrid;
    udnGrabSize.Position:=GrabSize;
    chbShowHint.Checked:=ShowMoveSizeHint;
  end;
end;

procedure TfrmSetup.btnDesignerColorClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.DesignerColor;
    if Execute then pnlDesignerColor.Color:=Color;
  end;
end;

procedure TfrmSetup.btnGridColorClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.GridColor;
    if Execute then pnlGridColor.Color:=Color;
  end;
end;

procedure TfrmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult=mrOk then
    with frmDesign.cmpFormDesigner do
    begin
      DisplayGrid:=chbDisplayGrid.Checked;
      SnapToGrid:=chbSnapToGrid.Checked;
      GridStep:=udnGridStep.Position;
      DesignerColor:=pnlDesignerColor.Color;
      GridColor:=pnlGridColor.Color;
      NormalGrabBorder:=pnlNBorder.Color;
      NormalGrabFill:=pnlNFill.Color;
      MultiGrabBorder:=pnlMBorder.Color;
      MultiGrabFill:=pnlMFill.Color;
      LockedGrabBorder:=pnlLBorder.Color;
      LockedGrabFill:=pnlLFill.Color;
      GrabSize:=udnGrabSize.Position;
      ShowMoveSizeHint:=chbShowHint.Checked;
    end;
end;

procedure TfrmSetup.FormShow(Sender: TObject);
begin
  btnDesignerColor.SetFocus;
end;

procedure TfrmSetup.btnNBorderClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.NormalGrabBorder;
    if Execute then pnlNBorder.Color:=Color;
  end;
end;

procedure TfrmSetup.btnNFillClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.NormalGrabFill;
    if Execute then pnlNFill.Color:=Color;
  end;
end;

procedure TfrmSetup.btnLBorderClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.LockedGrabBorder;
    if Execute then pnlLBorder.Color:=Color;
  end;
end;

procedure TfrmSetup.btnLFillClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.LockedGrabFill;
    if Execute then pnlLFill.Color:=Color;
  end;
end;

procedure TfrmSetup.btnMBorderClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.MultiGrabBorder;
    if Execute then pnlMBorder.Color:=Color;
  end;
end;

procedure TfrmSetup.btnMFillClick(Sender: TObject);
begin
  with cldMain do
  begin
    Color:=frmDesign.cmpFormDesigner.MultiGrabFill;
    if Execute then pnlMFill.Color:=Color;
  end;
end;

end.
