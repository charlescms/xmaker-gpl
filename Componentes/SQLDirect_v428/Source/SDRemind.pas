
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       SQLDirect Reminder Box	    			}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDRemind;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellApi,
{$IFDEF SD_CLR}
  System.ComponentModel, System.Runtime.InteropServices,
{$ENDIF}
  SDConsts;

type
  { TSDRemindDlg }
  TSDRemindDlg = class(TForm)
    lblThank: TLabel;
    btOk: TButton;
    imLogo: TImage;
    Bevel1: TBevel;
    lblHowRegister: TLabel;
    lblRegister: TLabel;
    lblHome: TLabel;
    Bevel2: TBevel;
    Label1: TLabel;
    lblOrderSQLDirectStd: TLabel;
    lblOrderSQLDirectPro: TLabel;
    procedure lblHomeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblOrderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SDRemindDlg: TSDRemindDlg;

procedure ShowReminderBox;

implementation

{$R *.DFM}

procedure ShowReminderBox;
var
  Dlg: TSDRemindDlg;
begin
  Application.CreateForm(TSDRemindDlg, Dlg);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

{ TSDRemindDlg }
procedure TSDRemindDlg.lblHomeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Inst: THandle;
begin
  if mbLeft = Button then begin
    Inst := ShellExecute(0, 'open', {$IFDEF SD_CLR}SLinkSQLDirectHome, '', ''{$ELSE}PChar(SLinkSQLDirectHome), nil, nil{$ENDIF}, 0);
    if Inst <= 32 then
      MessageDlg(Format(SErrOpenWwwSite, [SLinkSQLDirectHome]), mtError, [mbOK], 0);
  end;
end;

procedure TSDRemindDlg.lblOrderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Inst: THandle;
  sLink: string;
begin
  if mbLeft = Button then begin
    if Sender = lblOrderSQLDirectStd then
      sLink := SLinkSQLDirectStdOrder
    else
      sLink := SLinkSQLDirectProOrder;

    Inst := ShellExecute(0, 'open', {$IFDEF SD_CLR}sLink, '', ''{$ELSE}PChar(sLink), nil, nil{$ENDIF}, 0);
    if Inst <= 32 then
      MessageDlg(Format(SErrOpenWwwSite, [sLink]), mtError, [mbOK], 0);
  end;
end;

end.
