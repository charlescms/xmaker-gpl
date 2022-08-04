(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.001                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDAlPal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Menus, FDMain;

type
  TfrmAlignmentPalette = class(TForm)
    sbtLeft: TSpeedButton;
    sbtHorCenter: TSpeedButton;
    sbtHorWinCenter: TSpeedButton;
    sbtHorSpace: TSpeedButton;
    sbtRight: TSpeedButton;
    sbtTop: TSpeedButton;
    sbtVerCenter: TSpeedButton;
    sbtVerSpace: TSpeedButton;
    sbtVerWinCenter: TSpeedButton;
    sbtBottom: TSpeedButton;
    pmnMain: TPopupMenu;
    mniStayOnTop: TMenuItem;
    mniShowHints: TMenuItem;
    mniHide: TMenuItem;
    procedure pmnMainPopup(Sender: TObject);
    procedure mniStayOnTopClick(Sender: TObject);
    procedure mniShowHintsClick(Sender: TObject);
    procedure mniHideClick(Sender: TObject);
    procedure sbtHorClick(Sender: TObject);
    procedure sbtVerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetFlatButtons(AFlat: Boolean);
  end;

implementation

{$R *.DFM}

procedure TfrmAlignmentPalette.SetFlatButtons(AFlat: Boolean);
var
  i: Integer;
begin
  for i:=0 to Pred(ControlCount) do
    if Controls[i] is TSpeedButton then
      TSpeedButton(Controls[i]).Flat:=AFlat;
end;

procedure TfrmAlignmentPalette.pmnMainPopup(Sender: TObject);
begin
  mniStayOnTop.Checked:=FormStyle=fsStayOnTop;
  mniShowHints.Checked:=ShowHint;
end;

procedure TfrmAlignmentPalette.mniStayOnTopClick(Sender: TObject);
begin
  with mniStayOnTop do
  begin
    Checked:=not Checked;
    if Checked then
    begin
      FormStyle:=fsStayOnTop;
      if Assigned(Self.Owner) then
        with Self.Owner as TCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette+[apStayOnTop];
    end
    else
    begin
      FormStyle:=fsNormal;
      if Assigned(Self.Owner) then
        with Self.Owner as TCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette-[apStayOnTop];
    end;
  end;
end;

procedure TfrmAlignmentPalette.mniShowHintsClick(Sender: TObject);
begin
  with mniShowHints do
  begin
    Checked:=not Checked;
    ShowHint:=Checked;
    if Checked then
    begin
      if Assigned(Self.Owner) then
        with Self.Owner as TCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette+[apShowHints];
    end
    else
    begin
      if Assigned(Self.Owner) then
        with Self.Owner as TCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette-[apShowHints];
    end;
  end;
end;

procedure TfrmAlignmentPalette.mniHideClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrmAlignmentPalette.sbtHorClick(Sender: TObject);
begin
  if Assigned(Owner) then
    (Owner as TCustomFormDesigner).AlignControls(TAlignMode((Sender as TSpeedButton).Tag),amNoChange);
end;

procedure TfrmAlignmentPalette.sbtVerClick(Sender: TObject);
begin
  if Assigned(Owner) then
    (Owner as TCustomFormDesigner).AlignControls(amNoChange,TAlignMode((Sender as TSpeedButton).Tag));
end;

end.
