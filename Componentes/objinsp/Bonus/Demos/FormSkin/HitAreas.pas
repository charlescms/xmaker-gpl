(*  GREATIS BONUS * Form Skin                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit HitAreas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, FormSkin;

type
  TfrmHitAreas = class(TForm)
    imgRightTop: TImage;
    imgRightCenter: TImage;
    imgRightBottom: TImage;
    imgLeftBottom: TImage;
    imgLeftCenter: TImage;
    imgLeftTop: TImage;
    imgCenterTop: TImage;
    imgCenterBottom: TImage;
    imgCenter: TImage;
    cmpSkin: TSimpleFormSkin;
    imgClose: TImage;
    procedure cmpSkinHitArea(Sender: TObject; X, Y: Integer;
      var Area: THitArea);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateButtons;
  public
    { Public declarations }
  end;

var
  frmHitAreas: TfrmHitAreas;

implementation

{$R *.DFM}

const
  TopOffset = 20;

procedure TfrmHitAreas.UpdateButtons;
begin
  imgLeftCenter.Top:=(ClientHeight-imgRightTop.Height-TopOffset) div 2+TopOffset;
  imgLeftBottom.Top:=ClientHeight-imgRightTop.Height;
  imgCenterTop.Left:=(ClientWidth-imgRightTop.Width) div 2;
  imgCenter.Left:=imgCenterTop.Left;
  imgCenter.Top:=imgLeftCenter.Top;
  imgCenterBottom.Left:=imgCenterTop.Left;
  imgCenterBottom.Top:=imgLeftBottom.Top;
  imgRightTop.Left:=ClientWidth-imgRightTop.Width;
  imgRightCenter.Left:=imgRightTop.Left;
  imgRightCenter.Top:=imgLeftCenter.Top;
  imgRightBottom.Left:=imgRightTop.Left;
  imgRightBottom.Top:=imgLeftBottom.Top;
end;

procedure TfrmHitAreas.cmpSkinHitArea(Sender: TObject; X,
  Y: Integer; var Area: THitArea);
var
  C: TControl;
begin
  C:=ControlAtPos(Point(X,Y),True);
  if Assigned(C) then Area:=THitArea(C.Tag);
end;

procedure TfrmHitAreas.FormResize(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TfrmHitAreas.FormShow(Sender: TObject);
begin
  UpdateButtons;
  cmpSkin.Update;
end;

end.
