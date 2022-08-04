(*  GREATIS BONUS * TClock                    *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Props;
                               
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Clock, ExtCtrls;

type
  TfrmClockProperties = class(TForm)
    pnlClock: TPanel;
    grcClock: TClock;
    lblBackColor: TLabel;
    lblFaceColor: TLabel;
    lblHandColor: TLabel;
    chbShowSeconds: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    lblFaceShape: TLabel;
    cmbFaceShape: TComboBox;
    timClock: TTimer;
    lblHandMode: TLabel;
    cmbHandMode: TComboBox;
    lblHandShape: TLabel;
    cmbHandShape: TComboBox;
    chbHoursVisible: TCheckBox;
    pnlBackColor: TPanel;
    btnBackColor: TButton;
    cldMain: TColorDialog;
    pnlFaceColor: TPanel;
    btnFaceColor: TButton;
    pnlHandColor: TPanel;
    btnHandColor: TButton;
    procedure timClockTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnColorClick(Sender: TObject);
  private
    { Private declarations }
    EnableUpdate: Boolean;
  public
    { Public declarations }
  end;

var
  frmClockProperties: TfrmClockProperties;

implementation

{$R *.DFM}

procedure TfrmClockProperties.timClockTimer(Sender: TObject);
begin
  grcClock.Time:=Now;
end;

procedure TfrmClockProperties.FormShow(Sender: TObject);
begin
  btnBackColor.SetFocus;
  with grcClock do
  begin
    pnlBackColor.Color:=BackColor;
    pnlFaceColor.Color:=FaceColor;
    pnlHandColor.Color:=HandColor;
    cmbHandMode.ItemIndex:=Integer(HandMode);
    chbShowSeconds.Checked:=ShowSeconds;
    chbHoursVisible.Checked:=HoursVisible;
    cmbFaceShape.ItemIndex:=Integer(FaceShape);
    cmbHandShape.ItemIndex:=Integer(HandShape);
  end;
  EnableUpdate:=True;
end;

procedure TfrmClockProperties.eveClick(Sender: TObject);
begin
  if EnableUpdate then
  with grcClock do
  begin
    BackColor:=pnlBackColor.Color;
    FaceColor:=pnlFaceColor.Color;
    HandColor:=pnlHandColor.Color;
    with cmbHandMode do
      if ItemIndex>-1 then HandMode:=THandMode(ItemIndex);
    ShowSeconds:=chbShowSeconds.Checked;
    HoursVisible:=chbHoursVisible.Checked;
    with cmbFaceShape do
      if ItemIndex>-1 then FaceShape:=TShapeType(ItemIndex);
    with cmbHandShape do
      if ItemIndex>-1 then HandShape:=THandShape(ItemIndex);
  end;
end;

procedure TfrmClockProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  EnableUpdate:=False;
end;

procedure TfrmClockProperties.btnColorClick(Sender: TObject);

var
  Panel: TPanel;

  function FindPanel(ATag: Integer): TPanel;
  var
    i: Integer;
  begin
    for i:=0 to Pred(ComponentCount) do
      if (Components[i] is TPanel) and (TPanel(Components[i]).Tag=ATag) then
      begin
        Result:=TPanel(Components[i]);
        Exit;
      end;
    Result:=nil;
  end;

begin
  Panel:=FindPanel((Sender as TControl).Tag);
  if Assigned(Panel) then
    with cldMain do
    begin
      Color:=Panel.Color;
      if Execute then
      begin
        Panel.Color:=Color;
        with grcClock do
        begin
          BackColor:=pnlBackColor.Color;
          FaceColor:=pnlFaceColor.Color;
          HandColor:=pnlHandColor.Color;
        end;
      end;
    end;
end;

end.
