(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.003                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDCmpPal;

interface

uses Windows, Classes, Controls, Buttons, Graphics, ComCtrls, JvPageList;

type
  TPaletteButton = class(TSpeedButton)
  private
    FComponentClass: TComponentClass;
  public
    property ComponentClass: TComponentClass read FComponentClass write FComponentClass;
  end;

function CreatePaletteButton(AParent: TWinControl; AClass: TComponentClass; ALeft,ATop: Integer; ClickEvent: TNotifyEvent): TPaletteButton;
function CreatePalettePage(APageControl: TPageControl; ACaption: string; AClasses: array of TComponentClass; ClickEvent: TNotifyEvent): TTabSheet;
procedure CreatePalette(APageControl: TJvStandardPage; AClasses: array of TComponentClass; ClickEvent: TNotifyEvent);
procedure EditMode(APageControl: TPageControl);
procedure EditMode_P(APageControl: TJvPageList);

implementation

{$R *.RES}

{$R STDREG.DCR}
{$R SYSREG.DCR}
{$R DBREG.DCR}
{$R FR_REG.DCR}
{$R QREPORT.DCR}
{$R SMDBGRID.DCR}
// NOVO CMS

{$R xm_ACBr_SPEDPisCofins.DCR}
//{$R xm_ACBr_SPEDContabil.DCR}
//{$R xm_ACBr_SPEDFiscal.DCR}
//{$R xm_ACBrBoleto.DCR}
//{$R xm_ACBrBoletoFCFortes.DCR}
//{$R xm_ACBrBoletoFCQuick.DCR}
{$R xm_ACBrComum.DCR}
{$R xm_ACBrCte.DCR}
{$R xm_ACBrDiversos.DCR}
{$R xm_ACBrNFe.DCR}
//{$R xm_ACBrPAF.DCR}
{$R xm_ACBrSerial.DCR}
{$R xm_ACBrSintegra.DCR}
{$R xm_ACBrTCP.DCR}
//{$R xm_ACBrTEFD.DCR}
{$R xm_VDOPrint.DCR}

// 25/03/20210    // NOVO CMS
{$R JvDBReg.dcr}

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
    Width:=26;
    Height:=26;
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

procedure CreatePalette(APageControl: TJvStandardPage; AClasses: array of TComponentClass; ClickEvent: TNotifyEvent);
var
  i,W: Integer;
begin
  W:=CreatePaletteButton(APageControl,nil,0,0,ClickEvent).Width;
  for i:=Low(AClasses) to High(AClasses) do
    CreatePaletteButton(APageControl,AClasses[i],Succ(i)*W+4,0,ClickEvent);
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

procedure EditMode_P(APageControl: TJvPageList);
var
  i: Integer;
begin
  with APageControl do
    for i:=0 to Pred(PageCount) do
      if Pages[i].Controls[0] is TPaletteButton then
        TPaletteButton(Pages[i].Controls[0]).Down:=True;
end;

end.
