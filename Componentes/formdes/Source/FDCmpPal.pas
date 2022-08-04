(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.003                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDCmpPal;

interface

uses Windows, Classes, Controls, Buttons, Graphics, ComCtrls;

type
  TPaletteButton = class(TSpeedButton)
  private
    FComponentClass: TComponentClass;
  public
    property ComponentClass: TComponentClass read FComponentClass write FComponentClass;
  end;

function CreatePaletteButton(AParent: TWinControl; AClass: TComponentClass; ALeft,ATop: Integer; ClickEvent: TNotifyEvent): TPaletteButton;
function CreatePalettePage(APageControl: TPageControl; ACaption: string; AClasses: array of TComponentClass; ClickEvent: TNotifyEvent): TTabSheet;
procedure EditMode(APageControl: TPageControl);

implementation

{$R *.RES}

function CreatePaletteButton(AParent: TWinControl; AClass: TComponentClass; ALeft,ATop: Integer; ClickEvent: TNotifyEvent): TPaletteButton;
var
  AClassName: string;
begin
  Result:=TPaletteButton.Create(AParent);
  with Result do
  begin
    ComponentClass:=AClass;
    if Assigned(ComponentClass) then
    begin
      RegisterClass(ComponentClass);
      AClassName:=ComponentClass.ClassName;
      with Glyph do
      begin
        Handle:=LoadBitmap(HInstance,PChar(AClassName));
        if Handle=0 then Handle:=LoadBitmap(HInstance,'TCOMPONENT');
      end;
      Hint:=Copy(AClassName,2,Pred(Length(AClassName)));
    end
    else Glyph.Handle:=LoadBitmap(HInstance,'EDITMODE');
    Left:=ALeft;
    Top:=ATop;
    Width:=28;
    Height:=28;
    Flat:=True;
    GroupIndex:=1;
    if not Assigned(ComponentClass) then Down:=True;
    ShowHint:=True;
    Parent:=AParent;
    OnClick:=ClickEvent;
  end;
end;

function CreatePalettePage(APageControl: TPageControl; ACaption: string; AClasses: array of TComponentClass; ClickEvent: TNotifyEvent): TTabSheet;
var
  i,W: Integer;
begin
  Result:=TTabSheet.Create(APageControl);
  with Result do
  begin
    W:=CreatePaletteButton(Result,nil,0,0,ClickEvent).Width;
    for i:=Low(AClasses) to High(AClasses) do
      CreatePaletteButton(Result,AClasses[i],Succ(i)*W+4,0,ClickEvent);
    Caption:=ACaption;
    PageControl:=APageControl;
  end;
end;

procedure EditMode(APageControl: TPageControl);
var
  i: Integer;
begin
  with APageControl do
    for i:=0 to Pred(PageCount) do
      if Pages[i].Controls[0] is TPaletteButton then
        TPaletteButton(Pages[i].Controls[0]).Down:=True;
end;

end.
