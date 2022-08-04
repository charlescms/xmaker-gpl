(*  GREATIS BONUS * TClock                    *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Clock, ExtCtrls;

type
  TfrmMain = class(TForm)
    grcClock: TClock;
    pmnClock: TPopupMenu;
    mniShowFaceOnly: TMenuItem;
    mniStayOnTop: TMenuItem;
    mniSep: TMenuItem;
    mniExit: TMenuItem;
    mniProperties: TMenuItem;
    timClock: TTimer;
    mniShowTask: TMenuItem;
    procedure mniExitClick(Sender: TObject);
    procedure timClockTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mniPropertiesClick(Sender: TObject);
    procedure mniShowFaceOnlyClick(Sender: TObject);
    procedure grcClockDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure mniShowTaskClick(Sender: TObject);
    procedure mniStayOnTopClick(Sender: TObject);
  private
    { Private declarations }
    procedure WM_NCHITTEST(var Msg: TMessage); message WM_NCHITTEST;
    procedure UpdateShowMode;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Props;

{$R *.DFM}

procedure TfrmMain.WM_NCHITTEST(var Msg: TMessage);
begin
  if (mniShowFaceOnly.Checked) and (GetKeyState(VK_CONTROL) and $80 <> 0) then Msg.Result:=HTCAPTION
  else inherited;
end;

procedure TfrmMain.UpdateShowMode;
var
  Rgn: HRGN;
  Rect: TRect;
  W,H: Integer;
begin
  if mniShowFaceOnly.Checked then
  begin
    W:=grcClock.Width;
    H:=grcClock.Height;
    Left:=Left+GetSystemMetrics(SM_CXFRAME);
    Top:=Top+GetSystemMetrics(SM_CYFRAME)+GetSystemMetrics(SM_CYCAPTION);
    BorderStyle:=bsNone;
    ClientWidth:=W;
    ClientHeight:=H;
    with grcClock,Rect do
    begin
      Left:=0;
      Top:=0;
      if FaceShape in [stSquare,stRoundSquare,stCircle] then
        if ClientWidth>ClientHeight then
        begin
          Left:=(ClientWidth-ClientHeight) div 2;
          Right:=ClientWidth-(ClientWidth-ClientHeight) div 2;
          Top:=0;
          Bottom:=ClientHeight;
        end
        else
        begin
          Top:=(ClientHeight-ClientWidth) div 2;
          Bottom:=ClientHeight-(ClientHeight-ClientWidth) div 2;
          Left:=0;
          Right:=ClientWidth;
        end
      else Rect:=ClientRect;
      case FaceShape of
        stEllipse,stCircle: RGN:=CreateEllipticRgn(Left,Top,Right,Bottom);
        stRectangle,stSquare: RGN:=CreateRectRgn(Left,Top,Right,Bottom);
        stRoundRect,stRoundSquare: RGN:=CreateRoundRectRgn(Left,Top,Right,Bottom,(Bottom-Top) div 4,(Right-Left) div 4);
      else RGN:=0;
      end;
    end;
    SetWindowRgn(Handle,RGN,True);
  end
  else
  begin
    SetWindowRgn(Handle,0,True);
    Left:=Left-GetSystemMetrics(SM_CXFRAME);
    Top:=Top-GetSystemMetrics(SM_CYFRAME)-GetSystemMetrics(SM_CYCAPTION);
    W:=grcClock.Width;
    H:=grcClock.Height;
    BorderStyle:=bsSizeable;
    ClientWidth:=W;
    ClientHeight:=H;
  end;
  grcClock.Paint;
end;

procedure TfrmMain.mniExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.timClockTimer(Sender: TObject);
begin
  grcClock.Time:=Now;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  grcClock.Time:=Now;
  UpdateShowMode;
end;

procedure TfrmMain.mniPropertiesClick(Sender: TObject);
begin
  with frmClockProperties.grcClock do
  begin
    BackColor:=grcClock.BackColor;
    FaceColor:=grcClock.FaceColor;
    HandColor:=grcClock.HandColor;
    HandMode:=grcClock.HandMode;
    ShowSeconds:=grcClock.ShowSeconds;
    HoursVisible:=grcClock.HoursVisible;
    FaceShape:=grcClock.FaceShape;
    HandShape:=grcClock.HandShape;
  end;
  if frmClockProperties.ShowModal=mrOK then
    with frmClockProperties.grcClock do
    begin
      grcClock.BackColor:=BackColor;
      grcClock.FaceColor:=FaceColor;
      grcClock.HandColor:=HandColor;
      grcClock.HandMode:=HandMode;
      grcClock.ShowSeconds:=ShowSeconds;
      grcClock.HoursVisible:=HoursVisible;
      grcClock.FaceShape:=FaceShape;
      grcClock.HandShape:=HandShape;
      if mniShowFaceOnly.Checked then UpdateShowMode;
    end;
end;

procedure TfrmMain.mniShowFaceOnlyClick(Sender: TObject);
begin
  with mniShowFaceOnly do Checked:=not Checked;
  UpdateShowMode;
end;

procedure TfrmMain.grcClockDblClick(Sender: TObject);
begin
  with mniShowFaceOnly do Checked:=not Checked;
  UpdateShowMode;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_CONTROL then grcClock.Cursor:=crHandPoint;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_CONTROL then grcClock.Cursor:=crDefault;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  grcClock.Paint;
end;

procedure TfrmMain.mniShowTaskClick(Sender: TObject);
begin
  with mniShowTask do
  begin
    Checked:=not Checked;
    if Checked then ShowWindow(Application.Handle,SW_SHOW)
    else ShowWindow(Application.Handle,SW_HIDE);
  end;
end;

procedure TfrmMain.mniStayOnTopClick(Sender: TObject);
begin
  with mniStayOnTop do
  begin
    Checked:=not Checked;
    if Checked then FormStyle:=fsStayOnTop
    else FormStyle:=fsNormal;
  end;
end;

end.
