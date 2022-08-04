(*  GREATIS BONUS * Form Skin                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellAPI;

type
  TfrmMain = class(TForm)
    pnlName: TPanel;
    lblInfo: TLabel;
    lblHomePage: TLabel;
    btnHitAreas: TButton;
    btnSimple: TButton;
    btnBitmapSkin: TButton;
    btnControlsSkin: TButton;
    pnlHint: TPanel;
    lblHint: TLabel;
    procedure btnBitmapSkinClick(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
    procedure btnControlsSkinClick(Sender: TObject);
    procedure btnHitAreasClick(Sender: TObject);
    procedure btnSimpleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ApplicationHint(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses BmpSkin, Dialog, HitAreas, Simple;

{$R *.DFM}

procedure TfrmMain.ApplicationHint(Sender: TObject);
begin
  lblHint.Caption:=GetLongHint(Application.Hint);
end;

procedure TfrmMain.lblLinkClick(Sender: TObject);
begin
  with Sender as TLabel do
    ShellExecute(Application.Handle,nil,PChar(GetShortHint(Hint)),nil,nil,SW_SHOWDEFAULT);
end;

procedure TfrmMain.btnBitmapSkinClick(Sender: TObject);
begin
  frmBitmapSkin.Show;
end;

procedure TfrmMain.btnControlsSkinClick(Sender: TObject);
begin
  frmDialog.Show;
end;

procedure TfrmMain.btnHitAreasClick(Sender: TObject);
begin
  frmHitAreas.Show;
end;

procedure TfrmMain.btnSimpleClick(Sender: TObject);
begin
  frmSimple.Show;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Application.OnHint:=ApplicationHint;
end;

end.
