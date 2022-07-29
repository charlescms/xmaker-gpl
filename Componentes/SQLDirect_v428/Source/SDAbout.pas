
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       SQLDirect About Box    				}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellApi,
{$IFDEF SD_CLR}
  System.ComponentModel, System.Runtime.InteropServices, WinUtils,
{$ENDIF}
  SDConsts, SDCommon;

type
  { TSDAboutDlg }
  TSDAboutDlg = class(TForm)
    imLogo: TImage;
    lblCopyright: TLabel;
    bvCopyright: TBevel;
    btOk: TButton;
    lblHome: TLabel;
    lblOrder: TLabel;
    lblProductName: TLabel;
    lblVersion: TLabel;
    lblSupport: TLabel;
    Label1: TLabel;
    lblOrderSQLDirectStd: TLabel;
    lblOrderSQLDirectPro: TLabel;
    procedure lblHomeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure lblOrderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblSupportMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SDAboutDlg: TSDAboutDlg;

procedure ShowAboutBox;

implementation

{$R *.DFM}

procedure ShowAboutBox;
var
  Dlg: TSDAboutDlg;
begin
  Application.CreateForm(TSDAboutDlg, Dlg);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

{ TSDAboutDlg }
procedure TSDAboutDlg.FormCreate(Sender: TObject);
var
{$IFNDEF SD_CLR}
  sFileName,
{$ENDIF}
  sProductName, sProductVers: string;
begin
  sProductName := SSQLDirectProductName;
{$IFDEF SD_CLR}
        // in Delphi 8 IDE GetModuleFileName returns an empty string and GetLastError returns 0
  sProductVers := SSQLDirectVersion;        
{$ELSE}
  sProductVers := '';

  sFileName := GetModuleFileNameStr( HInstance );

  ReadFileVersInfo( sFileName, sProductName, sProductVers );
{$ENDIF}
  lblProductName.Caption:= sProductName;
  lblVersion.Caption	:= Format('Version %s', [sProductVers]);
end;

procedure TSDAboutDlg.lblHomeMouseDown(Sender: TObject;
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

procedure TSDAboutDlg.lblOrderMouseDown(Sender: TObject;
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

procedure TSDAboutDlg.lblSupportMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Inst: THandle;
begin
  if mbLeft = Button then begin
    Inst := ShellExecute(0, 'open', {$IFDEF SD_CLR}SLinkSQLDirectSupport, '', ''{$ELSE}PChar(SLinkSQLDirectSupport), nil, nil{$ENDIF}, 0);
    if Inst <= 32 then
      MessageDlg( Format(SErrOpenWwwSite, [SLinkSQLDirectSupport]), mtError, [mbOK], 0 );
  end;
end;

end.
