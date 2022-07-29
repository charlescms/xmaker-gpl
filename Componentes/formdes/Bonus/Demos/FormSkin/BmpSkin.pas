(*  GREATIS BONUS * Form Skin                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit BmpSkin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, FormSkin, Buttons, Menus;

type
  TfrmBitmapSkin = class(TForm)
    pmnSkinWindow: TPopupMenu;
    mniMove: TMenuItem;
    mniClose: TMenuItem;
    cmpSkin: TBitmapFormSkin;
    procedure cmpSkinHitArea(Sender: TObject; X, Y: Integer;
      var Area: THitArea);
    procedure mniMoveClick(Sender: TObject);
    procedure mniCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBitmapSkin: TfrmBitmapSkin;

implementation

{$R *.DFM}

procedure TfrmBitmapSkin.cmpSkinHitArea(Sender: TObject; X, Y: Integer;
  var Area: THitArea);
begin
  if Area in [haNone,haClient] then
    if Y<20 then
      case X of
        0..19: Area:=haSysMenu;
        23..156: Area:=haCaptionBar;
        160..180: Area:=haCloseButton;
      end;
end;

procedure TfrmBitmapSkin.mniMoveClick(Sender: TObject);
begin
  Perform(WM_SYSCOMMAND,SC_MOVE,0);
end;

procedure TfrmBitmapSkin.mniCloseClick(Sender: TObject);
begin
  Perform(WM_SYSCOMMAND,SC_CLOSE,0);
end;

end.
