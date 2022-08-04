(*  GREATIS BONUS * Life                      *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit LifeMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, LifeComp, Registry;

type
  TfrmMain = class(TForm)
    Life: TLife;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
    procedure ApplicationIdle(Sender: TObject; var Done: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Mouse: TPoint;
    NoDelay: Boolean;
    Delay: Integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

const
  RegName = 'SOFTWARE\Greatis';
  SecName = 'Life Screen Saver';

procedure TfrmMain.ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYDOWN,WM_LBUTTONDOWN,WM_MBUTTONDOWN,WM_RBUTTONDOWN: Close;
    WM_MOUSEMOVE:
      if (Mouse.X=-1) and (Mouse.Y=-1) then Mouse:=Msg.pt
      else
        if (Mouse.X<>Msg.pt.X) or (Mouse.Y<>Msg.pt.Y) then Close;
    WM_ACTIVATE:
      if Msg.wParam=0 then Close;
  end;
end;

procedure TfrmMain.ApplicationIdle(Sender: TObject; var Done: Boolean);
begin
  Life.NextGeneration;
  if not NoDelay then Sleep(Delay);
  Done:=False;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  with TRegIniFile.Create(RegName),Life do
  begin
    WriteString(SecName,'@Name','Life Screen Saver');
    WriteString(SecName,'@Path',ParamStr(0));
    WriteString(SecName,'@Version','3');
    case ReadInteger(SecName+'\Options','Color set',0) of
      0:
      begin
        LonelinessColor:=clNavy;
        SurviveColor:=clBlue;
        OvercrowdingColor:=clAqua;
      end;
      1:
      begin
        LonelinessColor:=clOlive;
        SurviveColor:=clYellow;
        OvercrowdingColor:=clWhite;
      end;
      2:
      begin
        LonelinessColor:=clMaroon;
        SurviveColor:=clRed;
        OvercrowdingColor:=clYellow;
      end;
      3:
      begin
        LonelinessColor:=clGreen;
        SurviveColor:=clLime;
        OvercrowdingColor:=clYellow;
      end;
    end;
    case ReadInteger(SecName+'\Options','Random',1) of
      0: RandomLife:=0;
      1: RandomLife:=500000;
      2: RandomLife:=100000;
      3: RandomLife:=50000;
      4: RandomLife:=10000;
      5: RandomLife:=5000;
      6: RandomLife:=1000;
    end;
    EnableRandomLife:=RandomLife>0;
    CellSize:=ReadInteger(SecName+'\Options','Cell size',10);
    CellShape:=TCellShape(ReadInteger(SecName+'\Options','Cell shape',0));
    NoDelay:=not ReadBool(SecName+'\Options','Delay',True);
    Delay:=ReadInteger(SecName+'\Options','Delay value',10);
    ShowDying:=not ReadBool(SecName+'\Options','Pure Conway',False);
    Closed:=ReadBool(SecName+'\Options','Closed',True);
  end;
  Cursor:=crNone;
  Randomize;
  Left:=0;
  Top:=0;
  Width:=Screen.Width;
  Height:=Screen.Height;
  with Life do
  begin
    Width:=Self.ClientWidth;
    Height:=Self.ClientHeight;
    Fill;
    NextGeneration;
    Paint;
  end;
  Mouse.X:=-1;
  Mouse.Y:=-1;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  Application.OnMessage:=ApplicationMessage;
  Application.OnIdle:=ApplicationIdle;
  Application.ProcessMessages;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WindowState:=wsNormal;
end;

end.
