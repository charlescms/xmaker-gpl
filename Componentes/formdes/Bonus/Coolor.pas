(*  GREATIS BONUS * TCoolorDialog             *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Coolor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Colors, StdCtrls, Buttons, Clipbrd;

const
  UserColorCount = 32;

type

  TDialogPage = (pageVGA,pageInternet,pageHSB,pageRGB,pageCMY,pageCMYK,pageGray,pageWindows,pageInfo);
  TDialogPages = set of TDialogPage;

  TCoolorDialog = class;

  TfrmCoolorDialog = class(TForm)
    pgcSystems: TPageControl;
    tshHSB: TTabSheet;
    pnlHue: TPanel;
    pntHue: TPaintBox;
    trbHue: TTrackBar;
    pnlSaturation: TPanel;
    pntSaturation: TPaintBox;
    pnlBrightness: TPanel;
    pntBrightness: TPaintBox;
    trbSaturation: TTrackBar;
    trbBrightness: TTrackBar;
    tshVGA: TTabSheet;
    tshInternet: TTabSheet;
    lblHue: TLabel;
    edtHue: TEdit;
    udnHue: TUpDown;
    lblSaturation: TLabel;
    edtSaturation: TEdit;
    udnSaturation: TUpDown;
    lblBrightness: TLabel;
    edtBrightness: TEdit;
    udnBrightness: TUpDown;
    tshRGB: TTabSheet;
    tshGray: TTabSheet;
    tshCMY: TTabSheet;
    pnlCollection: TPanel;
    pnlCollectionBottom: TPanel;
    pnlCollectionTop: TPanel;
    pnl16: TPanel;
    pnl15: TPanel;
    pnl14: TPanel;
    pnl13: TPanel;
    pnl12: TPanel;
    pnl11: TPanel;
    pnl10: TPanel;
    pnl9: TPanel;
    pnl8: TPanel;
    pnl7: TPanel;
    pnl6: TPanel;
    pnl5: TPanel;
    pnl4: TPanel;
    pnl3: TPanel;
    pnl2: TPanel;
    pnl1: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    pnl19: TPanel;
    pnl20: TPanel;
    pnl21: TPanel;
    pnl22: TPanel;
    pnl23: TPanel;
    pnl24: TPanel;
    pnl25: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    pnl28: TPanel;
    pnl29: TPanel;
    pnl30: TPanel;
    pnl31: TPanel;
    pnl32: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    tshWindows: TTabSheet;
    pnlVGA: TPanel;
    pnlVGALight: TPanel;
    pnlVGAGray: TPanel;
    pnlVGARed: TPanel;
    pnlVGALime: TPanel;
    pnlVGAYellow: TPanel;
    pnlVGABlue: TPanel;
    pnlVGAFuchsia: TPanel;
    pnlVGAAqua: TPanel;
    pnlVGAWhite: TPanel;
    pnlVGADark: TPanel;
    pnlVGASilver: TPanel;
    pnlVGATeal: TPanel;
    pnlVGAPurple: TPanel;
    pnlVGANavy: TPanel;
    pnlVGAOlive: TPanel;
    pnlVGAGreen: TPanel;
    pnlVGAMaroon: TPanel;
    pnlVGABlack: TPanel;
    pnlColors: TPanel;
    pnlReferenceColor: TPanel;
    pnlColor: TPanel;
    tshInfo: TTabSheet;
    pnlInternet: TPanel;
    pntInternet: TPaintBox;
    lblRed: TLabel;
    lblGreen: TLabel;
    lblBlue: TLabel;
    pnlRed: TPanel;
    pntRed: TPaintBox;
    trbRed: TTrackBar;
    pnlGreen: TPanel;
    pntGreen: TPaintBox;
    pnlBlue: TPanel;
    pntBlue: TPaintBox;
    trbGreen: TTrackBar;
    trbBlue: TTrackBar;
    edtRed: TEdit;
    udnRed: TUpDown;
    edtGreen: TEdit;
    udnGreen: TUpDown;
    edtBlue: TEdit;
    udnBlue: TUpDown;
    lblCyan: TLabel;
    lblMagenta: TLabel;
    lblYellow: TLabel;
    pnlCyan: TPanel;
    pntCyan: TPaintBox;
    trbCyan: TTrackBar;
    pnlMagenta: TPanel;
    pntMagenta: TPaintBox;
    pnlYellow: TPanel;
    pntYellow: TPaintBox;
    trbMagenta: TTrackBar;
    trbYellow: TTrackBar;
    edtCyan: TEdit;
    udnCyan: TUpDown;
    edtMagenta: TEdit;
    udnMagenta: TUpDown;
    edtYellow: TEdit;
    udnYellow: TUpDown;
    lblGray: TLabel;
    pnlGray: TPanel;
    pntGray: TPaintBox;
    trbGray: TTrackBar;
    edtGray: TEdit;
    udnGray: TUpDown;
    lsbWindows: TListBox;
    rgrNumbers: TRadioGroup;
    lblHSB: TLabel;
    lblRGB: TLabel;
    lblCMY: TLabel;
    lblGrayTitle: TLabel;
    lblHSBValue: TLabel;
    lblRGBValue: TLabel;
    lblCMYValue: TLabel;
    lblGrayValue: TLabel;
    sbtHSB: TSpeedButton;
    sbtRGB: TSpeedButton;
    sbtCMY: TSpeedButton;
    sbtGray: TSpeedButton;
    grbFormat: TGroupBox;
    chbSpace: TCheckBox;
    chbComma: TCheckBox;
    chbNames: TCheckBox;
    btnHelp: TButton;
    sbtRound: TSpeedButton;
    sbtRoundGray: TSpeedButton;
    lblCMYK: TLabel;
    lblCMYKValue: TLabel;
    sbtCMYK: TSpeedButton;
    tshCMYK: TTabSheet;
    lblKCyan: TLabel;
    lblKMagenta: TLabel;
    lblKYellow: TLabel;
    pnlKCyan: TPanel;
    pntKCyan: TPaintBox;
    trbKCyan: TTrackBar;
    pnlKMagenta: TPanel;
    pntKMagenta: TPaintBox;
    pnlKYellow: TPanel;
    pntKYellow: TPaintBox;
    trbKMagenta: TTrackBar;
    trbKYellow: TTrackBar;
    edtKCyan: TEdit;
    udnKCyan: TUpDown;
    edtKMagenta: TEdit;
    udnKMagenta: TUpDown;
    edtKYellow: TEdit;
    udnKYellow: TUpDown;
    lblKBlack: TLabel;
    pnlKBlack: TPanel;
    pntKBlack: TPaintBox;
    trbKBlack: TTrackBar;
    edtKBlack: TEdit;
    udnKBlack: TUpDown;
    procedure pntHuePaint(Sender: TObject);
    procedure pntSaturationPaint(Sender: TObject);
    procedure pntBrightnessPaint(Sender: TObject);
    procedure trbHueChange(Sender: TObject);
    procedure trbSaturationChange(Sender: TObject);
    procedure trbBrightnessChange(Sender: TObject);
    procedure edtPress(Sender: TObject; var Key: Char);
    procedure udnHueChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udnSaturationChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure udnBrightnessChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure edtHueChange(Sender: TObject);
    procedure udnClick(Sender: TObject; Button: TUDBtnType);
    procedure edtSaturationChange(Sender: TObject);
    procedure edtBrightnessChange(Sender: TObject);
    procedure edtHueExit(Sender: TObject);
    procedure edtSaturationExit(Sender: TObject);
    procedure edtBrightnessExit(Sender: TObject);
    procedure pnlDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pnlDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure pntHueMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pntSaturationMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pntBrightnessMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlVGAClick(Sender: TObject);
    procedure pnlCollectionClick(Sender: TObject);
    procedure pgcSystemsChange(Sender: TObject);
    procedure pntInternetPaint(Sender: TObject);
    procedure pntInternetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pntRGBPaint(Sender: TObject);
    procedure pntRGBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtRedExit(Sender: TObject);
    procedure edtGreenExit(Sender: TObject);
    procedure edtBlueExit(Sender: TObject);
    procedure udnRedChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udnGreenChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udnBlueChanging(Sender: TObject; var AllowChange: Boolean);
    procedure trbRGBChange(Sender: TObject);
    procedure edtRedChange(Sender: TObject);
    procedure edtGreenChange(Sender: TObject);
    procedure edtBlueChange(Sender: TObject);
    procedure pntCyanPaint(Sender: TObject);
    procedure pntMagentaPaint(Sender: TObject);
    procedure pntYellowPaint(Sender: TObject);
    procedure trbCMYChange(Sender: TObject);
    procedure udnCyanChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udnMagentaChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure udnYellowChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edtCyanExit(Sender: TObject);
    procedure edtMagentaExit(Sender: TObject);
    procedure edtYellowExit(Sender: TObject);
    procedure edtCyanChange(Sender: TObject);
    procedure edtMagentaChange(Sender: TObject);
    procedure edtYellowChange(Sender: TObject);
    procedure pntCMYMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pntGrayPaint(Sender: TObject);
    procedure trbGrayChange(Sender: TObject);
    procedure edtGrayExit(Sender: TObject);
    procedure udnGrayChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pntGrayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtGrayChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lsbWindowsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lsbWindowsClick(Sender: TObject);
    procedure eveInfoClick(Sender: TObject);
    procedure sbtHSBClick(Sender: TObject);
    procedure sbtRGBClick(Sender: TObject);
    procedure sbtCMYClick(Sender: TObject);
    procedure sbtGrayClick(Sender: TObject);
    procedure chbNamesClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure sbtRoundClick(Sender: TObject);
    procedure sbtRoundGrayClick(Sender: TObject);
    procedure trbCMYKChange(Sender: TObject);
    procedure edtKCyanChange(Sender: TObject);
    procedure edtKMagentaChange(Sender: TObject);
    procedure edtKYellowChange(Sender: TObject);
    procedure edtKBlackChange(Sender: TObject);
    procedure edtKCyanExit(Sender: TObject);
    procedure edtKMagentaExit(Sender: TObject);
    procedure edtKYellowExit(Sender: TObject);
    procedure edtKBlackExit(Sender: TObject);
    procedure udnKCyanChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udnKMagentaChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure udnKYellowChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure udnKBlackChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pntCMYKMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pntKBlackPaint(Sender: TObject);
    procedure pgcSystemsChanging(Sender: TObject;
      var AllowChange: Boolean);
  private
    { Private declarations }
    FCoolorDialog: TCoolorDialog;
    FResultRGB: TRGB;
    InternetColor: TPoint;
    FAutoHelpContext: Boolean;
    function GetRGB: TRGB;
    procedure SetRGB(TheColor: TRGB);
    procedure UpdateColor;
    procedure UpdateSaturation;
    procedure UpdateBrightness;
    procedure UpdateHSBUpDown;
    function GetInternetColor(X,Y: Integer): TColor;
    procedure UpdateInternet;
    procedure UpdateRGBUpDown;
    procedure UpdateCMYUpDown;
    procedure UpdateCMYKUpDown;
    procedure UpdateGrayUpDown;
    procedure UpdateSysColors;
    function GetIndexColor(I: Integer): Integer;
    procedure WMSysColorChange(var Message: TMessage); message WM_SYSCOLORCHANGE;
    procedure UpdateInfo;
    procedure UpdateNamesCheckBox;
    function GetCollectedColor(Index: Integer): TColor;
    procedure SetCollectedColor(Index: Integer; Value: TColor);
    function GetResultColor: TColor;
    procedure SetResultColor(Value: TColor);
    function GetRefColor: TColor;
    procedure SetRefColor(Value: TColor);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

  TUserColors = array[1..UserColorCount] of TColor;

  {$IFDEF DIRECTCMYK}
  TCMYKEvent = procedure(Sender: TObject; var CMYKColor: TCMYKColor) of object;
  {$ENDIF}

  TCoolorDialog = class(TComponent)
  private
    { Private declarations }
    FAutoApply: Boolean;
    FStayOnTop: Boolean;
    FVisiblePages: TDialogPages;
    FActivePage: TDialogPage;
    FColor: TColor;
    RColor: TColor;
    FReferenceColor: TColor;
    RReferenceColor: TColor;
    FUserColors: TUserColors;
    RUserColors: TUserColors;
    FCtl3D: Boolean;
    FHelpButton: Boolean;
    FAutoHelpContext: Boolean;
    FHelpContext: THelpContext;
    FCaption: string;
    FDialog: TfrmCoolorDialog;
    FOnShow: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnApply: TNotifyEvent;
    {$IFDEF DIRECTCMYK}
    FOnSetCMYK: TCMYKEvent;
    FOnGetCMYK: TCMYKEvent;
    {$ENDIF}
    procedure OnDialogClose(Sender: TObject; var Action: TCloseAction);
    procedure OnApplyButton(Sender: TObject);
    procedure OnCloseButton(Sender: TObject);
    procedure SetColor(const Value: TColor);
    procedure SetReferenceColor(const Value: TColor);
    function GetRGBColor: TRGBColor;
    procedure SetRGBColor(const Value: TRGBColor);
    function GetRGBHex: TRGBHex;
    procedure SetRGBHex(const Value: TRGBHex);
    function GetCMYColor: TCMYColor;
    procedure SetCMYColor(const Value: TCMYColor);
    function GetCMYKColor: TCMYKColor;
    procedure SetCMYKColor(const Value: TCMYKColor);
    function GetHSBColor: THSBColor;
    procedure SetHSBColor(const Value: THSBColor);
    function GetHTMLColor: THTMLColor;
    procedure SetHTMLColor(const Value: THTMLColor);
    function GetUserColor(Index: Integer): TColor;
    procedure SetUserColor(Index: Integer; const Value: TColor);
    procedure SetAutoApply(const Value: Boolean);
    procedure SetStayOnTop(const Value: Boolean);
    procedure SetVisiblePages(const Value: TDialogPages);
    procedure SetActivePage(const Value: TDialogPage);
    procedure SetCtl3D(const Value: Boolean);
    procedure SetHelpButton(const Value: Boolean);
    procedure SetAutoHelpContext(const Value: Boolean);
    procedure SetHelpContext(const Value: THelpContext);
    procedure SetCaption(const Value: string);
    function GetDialog: TForm;
    function GetHandle: HWND;
    procedure SetProperties;
    procedure GetProperties;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean;
    procedure Show;
    procedure DoApply(ForSure: Boolean); virtual;
    property HSBColor: THSBColor read GetHSBColor write SetHSBColor;
    property RGBColor: TRGBColor read GetRGBColor write SetRGBColor;
    property RGBHex: TRGBHex read GetRGBHex write SetRGBHex;
    property CMYColor: TCMYColor read GetCMYColor write SetCMYColor;
    property CMYKColor: TCMYKColor read GetCMYKColor write SetCMYKColor;
    property HTMLColor: THTMLColor read GetHTMLColor write SetHTMLColor;
    property UserColors[Index: Integer]: TColor read GetUserColor write SetUserColor;
    property Dialog: TForm read GetDialog;
    property Handle: HWND read GetHandle;
  published
    { Published declarations }
    property AutoApply: Boolean read FAutoApply write SetAutoApply;
    property StayOnTop: Boolean read FStayOnTop write SetStayOnTop;
    property VisiblePages: TDialogPages read FVisiblePages write SetVisiblePages;
    property ActivePage: TDialogPage read FActivePage write SetActivePage;
    property Color: TColor read FColor write SetColor;
    property ReferenceColor: TColor read FReferenceColor write SetReferenceColor;
    property Ctl3D: Boolean read FCtl3D write SetCtl3D;
    property HelpButton: Boolean read FHelpButton write SetHelpButton;
    property AutoHelpContext: Boolean read FAutoHelpContext write SetAutoHelpContext;
    property HelpContext: THelpContext read FHelpContext write SetHelpContext;
    property Caption: string read FCaption write SetCaption;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnApply: TNotifyEvent read FOnApply write FOnApply;
    {$IFDEF DIRECTCMYK}
    property OnSetCMYK: TCMYKEvent read FOnSetCMYK write FOnSetCMYK;
    property OnGetCMYK: TCMYKEvent read FOnGetCMYK write FOnGetCMYK;
    {$ENDIF}
  end;

  ECoolorDialogException = class(Exception);

procedure Register;

implementation

{$R *.DFM}

procedure Register;
begin
  RegisterComponents('Greatis', [TCoolorDialog]);
end;

const
  chSelected = #159;
  LegalChars = ['0'..'9',Char(VK_BACK)];

procedure TfrmCoolorDialog.pntHuePaint(Sender: TObject);
var
  i: Integer;
begin
  with pntHue,Canvas do
    for i:=0 to 359 do
    begin
      Brush.Color:=HueToColor(i);
      FillRect(Rect(i*Width div 359,0,Succ(i)*Width div 359,Height));
    end;
end;

procedure TfrmCoolorDialog.pntSaturationPaint(Sender: TObject);
begin
  UpdateSaturation;
end;

procedure TfrmCoolorDialog.pntBrightnessPaint(Sender: TObject);
begin
  UpdateBrightness;
end;

procedure TfrmCoolorDialog.trbHueChange(Sender: TObject);
begin
  UpdateHSBUpDown;
  UpdateSaturation;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.trbSaturationChange(Sender: TObject);
begin
  UpdateHSBUpDown;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.trbBrightnessChange(Sender: TObject);
begin
  UpdateHSBUpDown;
  UpdateColor;
end;

function TfrmCoolorDialog.GetRGB: TRGB;
var
  i: Integer;
  HSB: THSB;
begin
  Result:=FResultRGB;
  case TDialogPage(pgcSystems.ActivePage.Tag) of
    pageVGA:
    begin
      with pnlVGADark do
        for i:=0 to Pred(ControlCount) do
          with Controls[i] as TPanel do
            if Caption<>'' then
            begin
              Result:=ColorToRGB(Color);
              Exit;
            end;
      with pnlVGALight do
        for i:=0 to Pred(ControlCount) do
          with Controls[i] as TPanel do
            if Caption<>'' then
            begin
              Result:=ColorToRGB(Color);
              Exit;
            end;
    end;
    pageInternet:
      with InternetColor do
        if (X<>-1) and (Y<>-1) then
          Result:=ColorToRGB(GetInternetColor(X,Y));
    pageHSB:
    begin
      with HSB do
      begin
        Hue:=trbHue.Position;
        Saturation:=trbSaturation.Position;
        Brightness:=trbBrightness.Position;
      end;
      Result:=HSBToRGB(HSB);
    end;
    pageRGB:
      Result:=MakeRGB(trbRed.Position,trbGreen.Position,trbBlue.Position);
    pageCMY:
      Result:=CMYToRGB(MakeCMY(trbCyan.Position,trbMagenta.Position,trbYellow.Position));
    pageCMYK:
      Result:=CMYKToRGB(MakeCMYK(trbKCyan.Position,trbKMagenta.Position,trbKYellow.Position,trbKBlack.Position));
    pageGray:
      Result:=MakeGrayRGB(trbGray.Position);
    pageWindows:
      with lsbWindows,Items do
        if (Perform(LB_GETCURSEL,0,0)<>LB_ERR) and (ItemIndex<Count) then
          Result:=ColorToRGB(GetSysColor(Integer(Objects[ItemIndex])));
  end;
end;

procedure TfrmCoolorDialog.SetRGB(TheColor: TRGB);
var
  i,X,Y: Integer;
  ICMYKColor: TCMYKColor;

  function EqualPoint(Point1,Point2: TPoint): Boolean;
  begin
    Result:=(Point1.X=Point2.X) and (Point1.Y=Point2.Y);
  end;

  function FMod(X1,X2: Real): Real;
  begin
    Result:=X1/X2;
    Result:=Result-Int(Result);
  end;

  function AboutColor(Color: TColor; RGB: TRGB; Error: Integer): Boolean;
  begin
    with ColorToRGB(Color) do
      Result:=
        (Abs(RGB.Red-Red)<=Error) and
        (Abs(RGB.Green-Green)<=Error) and
        (Abs(RGB.Blue-Blue)<=Error);
  end;

begin
  case TDialogPage(pgcSystems.ActivePage.Tag) of
    pageVGA:
    begin
      with pnlVGADark do
        for i:=0 to Pred(ControlCount) do
          with Controls[i] as TPanel do
            if AboutColor(Color,TheColor,1) then Caption:=chSelected
            else Caption:='';
      with pnlVGALight do
        for i:=0 to Pred(ControlCount) do
          with Controls[i] as TPanel do
            if AboutColor(Color,TheColor,1) then Caption:=chSelected
            else Caption:='';
    end;
    pageInternet:
    begin
      for Y:=0 to 11 do
        for X:=0 to 17 do
          if AboutColor(GetInternetColor(X,Y),TheColor,0) then
          begin
            if EqualPoint(InternetColor,Point(X,Y)) then Exit;
            InternetColor:=Point(X,Y);
            UpdateInternet;
            UpdateColor;
            Exit;
          end;
      if not EqualPoint(InternetColor,Point(-1,-1)) then
      begin
        InternetColor:=Point(-1,-1);
        UpdateInternet;
      end;
    end;
    pageHSB:
      if not RGBEqual(GetRGB,TheColor) then
        with RGBToHSB(TheColor) do
        begin
          trbHue.Position:=Round(Hue);
          trbSaturation.Position:=Round(Saturation);
          trbBrightness.Position:=Round(Brightness);
          UpdateHSBUpDown;
          UpdateSaturation;
          UpdateBrightness;
        end;
    pageRGB:
      if not RGBEqual(GetRGB,TheColor) then
        with TheColor do
        begin
          trbRed.Position:=Round(Red);
          trbGreen.Position:=Round(Green);
          trbBlue.Position:=Round(Blue);
          UpdateRGBUpDown;
        end;
    pageCMY:
      if not RGBEqual(GetRGB,TheColor) then
        with RGBToCMY(TheColor) do
        begin
          trbCyan.Position:=Round(Cyan);
          trbMagenta.Position:=Round(Magenta);
          trbYellow.Position:=Round(Yellow);
          UpdateCMYUpDown;
        end;
    pageCMYK:
    begin
      ICMYKColor:=CMYKToCMYKColor(RGBToCMYK(TheColor));
      {$IFDEF DIRECTCMYK}
      if Assigned(FCoolorDialog) then
        with FCoolorDialog do
          if Assigned(FOnSetCMYK) then FOnSetCMYK(Self,ICMYKColor);
      {$ENDIF}
      with ICMYKColor do
      begin
        trbKCyan.Position:=Cyan;
        trbKMagenta.Position:=Magenta;
        trbKYellow.Position:=Yellow;
        trbKBlack.Position:=Black;
        UpdateCMYKUpDown;
      end;
    end;
    pageGray:
      if not RGBEqual(GetRGB,TheColor) then
      begin
        trbGray.Position:=Round(255*RGBToHSB(TheColor).Brightness/100);
        UpdateGrayUpDown;
      end;
    pageWindows:
      with lsbWindows do
      begin
        if TopIndex>0 then TopIndex:=0;
        if Perform(LB_GETCURSEL,0,0)<>LB_ERR then
        begin
          Perform(LB_SETCURSEL,0,0);
          Perform(LB_SETCURSEL,-1,0);
        end;
        if Showing then SetFocus;
      end;
    pageInfo: UpdateInfo;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.UpdateColor;
begin
  with pnlColor do
  begin
    FResultRGB:=GetRGB;
    Color:=RGBToColor(FResultRGB);
    Update;
    if Assigned(FCoolorDialog) then
      with FCoolorDialog do
      begin
        if (FColor<>pnlColor.Color) or (FReferenceColor<>pnlReferenceColor.Color) then
        begin
          FReferenceColor:=pnlReferenceColor.Color;
          FColor:=pnlColor.Color;
          DoApply(False);
        end;
      end;
  end;
end;

procedure TfrmCoolorDialog.UpdateSaturation;
var
  i: Integer;
begin
  case TDialogPage(pgcSystems.ActivePage.Tag) of
    pageHSB:
      with pntSaturation,Canvas do
      begin
        for i:=0 to Pred(Width) do
        begin
          Pen.Color:=HSBToColor(MakeHSB(trbHue.Position,100*i div Width,100));
          MoveTo(i,0);
          LineTo(i,Height);
        end;
      end;
  end;
end;

procedure TfrmCoolorDialog.UpdateBrightness;
var
  i: Integer;
begin
  case TDialogPage(pgcSystems.ActivePage.Tag) of
    pageHSB:
      with pntBrightness,Canvas do
      begin
        for i:=0 to Pred(Width) do
        begin
          Pen.Color:=HSBToColor(MakeHSB(trbHue.Position,trbSaturation.Position,100*i div Width));
          MoveTo(i,0);
          LineTo(i,Height);
        end;
      end;
  end;
end;

procedure TfrmCoolorDialog.UpdateHSBUpDown;
begin
  udnHue.Position:=trbHue.Position;
  edtHue.Update;
  udnSaturation.Position:=trbSaturation.Position;
  edtSaturation.Update;
  udnBrightness.Position:=trbBrightness.Position;
  edtBrightness.Update;
end;

procedure TfrmCoolorDialog.edtPress(Sender: TObject; var Key: Char);
begin
  if not (Key in LegalChars) then
  begin
    Key:=#0;
    MessageBeep(0);
  end;
end;

procedure TfrmCoolorDialog.udnHueChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbHue.Position:=udnHue.Position;
  UpdateSaturation;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnSaturationChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbSaturation.Position:=udnSaturation.Position;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnBrightnessChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbBrightness.Position:=udnBrightness.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtHueChange(Sender: TObject);
begin
  try
    trbHue.Position:=StrToInt(edtHue.Text);
  except
    trbHue.Position:=0;
  end;
  UpdateSaturation;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnClick(Sender: TObject;
  Button: TUDBtnType);
begin
  with (Sender as TUpDown).Associate as TEdit do
  begin
    SetFocus;
    SelectAll;
  end;
end;

procedure TfrmCoolorDialog.edtSaturationChange(Sender: TObject);
begin
  try
    trbSaturation.Position:=StrToInt(edtSaturation.Text);
  except
    trbSaturation.Position:=0;
  end;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtBrightnessChange(Sender: TObject);
begin
  try
    trbBrightness.Position:=StrToInt(edtBrightness.Text);
  except
    trbBrightness.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtHueExit(Sender: TObject);
begin
  edtHue.Text:=IntToStr(trbHue.Position);
end;

procedure TfrmCoolorDialog.edtSaturationExit(Sender: TObject);
begin
  edtSaturation.Text:=IntToStr(trbSaturation.Position);
end;

procedure TfrmCoolorDialog.edtBrightnessExit(Sender: TObject);
begin
  edtBrightness.Text:=IntToStr(trbBrightness.Position);
end;

procedure TfrmCoolorDialog.pnlDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=Source=pnlColor;
end;

procedure TfrmCoolorDialog.pnlDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  (Sender as TPanel).Color:=(Source as TPanel).Color;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntHueMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  trbHue.Position:=359*X div (pntHue.Width);
  trbHue.SetFocus;
  UpdateHSBUpDown;
  UpdateSaturation;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntSaturationMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  trbSaturation.Position:=101*X div (pntSaturation.Width);
  trbSaturation.SetFocus;
  UpdateHSBUpDown;
  UpdateBrightness;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntBrightnessMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  trbBrightness.Position:=101*X div (pntBrightness.Width);
  trbBrightness.SetFocus;
  UpdateHSBUpDown;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pnlVGAClick(Sender: TObject);
var
  i: Integer;
begin
  with pnlVGADark do
    for i:=0 to Pred(ControlCount) do
      if Controls[i] is TPanel then
        with TPanel(Controls[i]) do Caption:='';
  with pnlVGALight do
    for i:=0 to Pred(ControlCount) do
      if Controls[i] is TPanel then
        with TPanel(Controls[i]) do Caption:='';
  (Sender as TPanel).Caption:=chSelected;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pnlCollectionClick(Sender: TObject);
begin
  with Sender as TPanel do
  begin
    SetRGB(ColorToRGB(Color));
    if pnlColor.Color<>Color then
    begin
      pnlColor.Color:=Color;
      FResultRGB:=ColorToRGB(Color);
    end;
  end;
  UpdateColor;
  UpdateInfo;
end;

procedure TfrmCoolorDialog.pgcSystemsChange(Sender: TObject);
{$IFDEF DIRECTCMYK}
var
  ICMYKColor: TCMYKColor;
{$ENDIF}
begin
  SetRGB(FResultRGB);
  {$IFDEF DIRECTCMYK}
  ICMYKColor:=CMYKToCMYKColor(ColorToCMYK(pnlColor.Color));
  if (TDialogPage(pgcSystems.ActivePage)=pageCMYK) and Assigned(FCoolorDialog) then
    with FCoolorDialog do
      if Assigned(FOnSetCMYK) then FOnSetCMYK(Self,ICMYKColor);
  {$ENDIF}
end;

function TfrmCoolorDialog.GetInternetColor(X,Y: Integer): TColor;
begin
  Result:=RGB($33*(2*(X div 6)+(Y div 6)),$33*(X mod 6),$33*(Y mod 6));
end;

procedure TfrmCoolorDialog.pntInternetPaint(Sender: TObject);
begin
  UpdateInternet;
end;

procedure TfrmCoolorDialog.pntInternetMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CX,CY: Integer;
begin
  with pntInternet do
  begin
    for CX:=0 to 17 do
      if CX*Pred(Width) div 18>X then Break;
    for CY:=0 to 11 do
      if CY*Pred(Height) div 12>Y then Break;
  end;
  InternetColor:=Point(Pred(CX),Pred(CY));
  UpdateInternet;
  UpdateColor;
end;

procedure TfrmCoolorDialog.UpdateInternet;
const
  ColorBorder = 192;
var
  X,Y: Integer;
  R: TRect;
begin
  with pntInternet,Canvas do
  begin
    Brush.Style:=bsClear;
    Rectangle(-1,-1,Width,Height);
    for Y:=0 to 11 do
      for X:=0 to 17 do
      begin
        Brush.Color:=GetInternetColor(X,Y);
        Rectangle(X*Pred(Width) div 18,Y*Pred(Height) div 12,Succ(X)*Pred(Width) div 18,Succ(Y)*Pred(Height) div 12);
        if (InternetColor.X=X) and (InternetColor.Y=Y) then
        begin
          with ColorToRGB(Brush.Color) do
            if Red+Green+Blue/4>ColorBorder then Font.Color:=clBlack
            else Font.Color:=clWhite;
          SetBkMode(Handle,TRANSPARENT);
          R:=Rect(X*Pred(Width) div 18,Y*Pred(Height) div 12,Succ(X)*Pred(Width) div 18,Succ(Y)*Pred(Height) div 12);
          DrawText(Handle,chSelected,1,R,DT_SINGLELINE or DT_CENTER or DT_VCENTER);
        end;
      end;
  end;
end;

procedure TfrmCoolorDialog.pntRGBPaint(Sender: TObject);

var
  i: Integer;

  function ScaleColor(C: TColor; Value: Integer): TColor;
  begin
    with ColorToRGB(C) do
      Result:=RGB(Round(Value*Red/255),Round(Value*Green/255),Round(Value*Blue/255));
  end;

begin
  with Sender as TPaintBox,Canvas do
    for i:=0 to Pred(Width) do
    begin
      Pen.Color:=ScaleColor(Color,255*i div Width);
      MoveTo(i,0);
      LineTo(i,Height);
    end;
end;

procedure TfrmCoolorDialog.UpdateRGBUpDown;
begin
  udnRed.Position:=trbRed.Position;
  edtRed.Update;
  udnGreen.Position:=trbGreen.Position;
  edtGreen.Update;
  udnBlue.Position:=trbBlue.Position;
  edtBlue.Update;
end;

procedure TfrmCoolorDialog.UpdateCMYUpDown;
begin
  udnCyan.Position:=trbCyan.Position;
  edtCyan.Update;
  udnMagenta.Position:=trbMagenta.Position;
  edtMagenta.Update;
  udnYellow.Position:=trbYellow.Position;
  edtYellow.Update;
end;

procedure TfrmCoolorDialog.UpdateCMYKUpDown;
begin
  udnKCyan.Position:=trbKCyan.Position;
  edtKCyan.Update;
  udnKMagenta.Position:=trbKMagenta.Position;
  edtKMagenta.Update;
  udnKYellow.Position:=trbKYellow.Position;
  edtKYellow.Update;
  udnKBlack.Position:=trbKBlack.Position;
  edtKBlack.Update;
end;

procedure TfrmCoolorDialog.pntRGBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TRB: TTrackBar;
begin
  with Sender as TPaintBox do
  begin
    case Tag of
      1: TRB:=trbRed;
      2: TRB:=trbGreen;
    else TRB:=trbBlue;
    end;
    TRB.Position:=255*X div Width;
    TRB.SetFocus;
    UpdateRGBUpDown;
    UpdateColor;
  end;
end;

procedure TfrmCoolorDialog.edtRedExit(Sender: TObject);
begin
  edtRed.Text:=IntToStr(trbRed.Position);
end;

procedure TfrmCoolorDialog.edtGreenExit(Sender: TObject);
begin
  edtGreen.Text:=IntToStr(trbGreen.Position);
end;

procedure TfrmCoolorDialog.edtBlueExit(Sender: TObject);
begin
  edtBlue.Text:=IntToStr(trbBlue.Position);
end;

procedure TfrmCoolorDialog.udnRedChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbRed.Position:=udnRed.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnGreenChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbGreen.Position:=udnGreen.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnBlueChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbBlue.Position:=udnBlue.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.trbRGBChange(Sender: TObject);
begin
  UpdateRGBUpDown;
end;

procedure TfrmCoolorDialog.edtRedChange(Sender: TObject);
begin
  try
    trbRed.Position:=StrToInt(edtRed.Text);
  except
    trbRed.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtGreenChange(Sender: TObject);
begin
  try
    trbGreen.Position:=StrToInt(edtGreen.Text);
  except
    trbGreen.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtBlueChange(Sender: TObject);
begin
  try
    trbBlue.Position:=StrToInt(edtBlue.Text);
  except
    trbBlue.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntCyanPaint(Sender: TObject);
var
  i: Integer;
begin
  with Sender as TPaintBox,Canvas do
    for i:=0 to Pred(Width) do
    begin
      Pen.Color:=RGB(255-255*i div Width,255,255);
      MoveTo(i,0);
      LineTo(i,Height);
    end;
end;

procedure TfrmCoolorDialog.pntMagentaPaint(Sender: TObject);
var
  i: Integer;
begin
  with Sender as TPaintBox,Canvas do
    for i:=0 to Pred(Width) do
    begin
      Pen.Color:=RGB(255,255-255*i div Width,255);
      MoveTo(i,0);
      LineTo(i,Height);
    end;
end;

procedure TfrmCoolorDialog.pntYellowPaint(Sender: TObject);
var
  i: Integer;
begin
  with Sender as TPaintBox,Canvas do
    for i:=0 to Pred(Width) do
    begin
      Pen.Color:=RGB(255,255,255-255*i div Width);
      MoveTo(i,0);
      LineTo(i,Height);
    end;
end;

procedure TfrmCoolorDialog.trbCMYChange(Sender: TObject);
begin
  UpdateCMYUpDown;
end;

procedure TfrmCoolorDialog.udnCyanChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbCyan.Position:=udnCyan.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnMagentaChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbMagenta.Position:=udnMagenta.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnYellowChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbYellow.Position:=udnYellow.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtCyanExit(Sender: TObject);
begin
  edtCyan.Text:=IntToStr(trbCyan.Position);
end;

procedure TfrmCoolorDialog.edtMagentaExit(Sender: TObject);
begin
  edtMagenta.Text:=IntToStr(trbMagenta.Position);
end;

procedure TfrmCoolorDialog.edtYellowExit(Sender: TObject);
begin
  edtYellow.Text:=IntToStr(trbYellow.Position);
end;

procedure TfrmCoolorDialog.edtCyanChange(Sender: TObject);
begin
  try
    trbCyan.Position:=StrToInt(edtCyan.Text);
  except
    trbCyan.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtMagentaChange(Sender: TObject);
begin
  try
    trbMagenta.Position:=StrToInt(edtMagenta.Text);
  except
    trbMagenta.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtYellowChange(Sender: TObject);
begin
  try
    trbYellow.Position:=StrToInt(edtYellow.Text);
  except
    trbYellow.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntCMYMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TRB: TTrackBar;
begin
  with Sender as TPaintBox do
  begin
    case Tag of
      1: TRB:=trbCyan;
      2: TRB:=trbMagenta;
    else TRB:=trbYellow;
    end;
    TRB.Position:=255*X div Width;
    TRB.SetFocus;
    UpdateCMYUpDown;
    UpdateColor;
  end;
end;

procedure TfrmCoolorDialog.pntGrayPaint(Sender: TObject);
var
  i: Integer;
begin
  with Sender as TPaintBox,Canvas do
    for i:=0 to Pred(Width) do
    begin
      Pen.Color:=MakeGrayColor(255*i div Width);
      MoveTo(i,0);
      LineTo(i,Height);
    end;
end;

procedure TfrmCoolorDialog.UpdateGrayUpDown;
begin
  udnGray.Position:=trbGray.Position;
  edtGray.Update;
end;

procedure TfrmCoolorDialog.trbGrayChange(Sender: TObject);
begin
  UpdateGrayUpDown;
end;

procedure TfrmCoolorDialog.edtGrayExit(Sender: TObject);
begin
  edtGray.Text:=IntToStr(trbGray.Position);
end;

procedure TfrmCoolorDialog.udnGrayChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbGray.Position:=udnGray.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntGrayMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TPaintBox do
  begin
    trbGray.Position:=255*X div Width;
    trbGray.SetFocus;
    UpdateGrayUpDown;
    UpdateColor;
  end;
end;

procedure TfrmCoolorDialog.edtGrayChange(Sender: TObject);
begin
  try
    trbGray.Position:=StrToInt(edtGray.Text);
  except
    trbGray.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.FormCreate(Sender: TObject);
begin
  UpdateSysColors;
  SetRGB(FResultRGB);
  UpdateNamesCheckBox;
end;

function TfrmCoolorDialog.GetIndexColor(I: Integer): Integer;
begin
  case I of
    0: Result:=COLOR_3DDKSHADOW;
    1: Result:=COLOR_3DFACE;
    2: Result:=COLOR_3DHIGHLIGHT;
    3: Result:=COLOR_3DLIGHT;
    4: Result:=COLOR_3DSHADOW;
    5: Result:=COLOR_ACTIVEBORDER;
    6: Result:=COLOR_ACTIVECAPTION;
    7: Result:=COLOR_APPWORKSPACE;
    8: Result:=COLOR_DESKTOP;
    9: Result:=COLOR_BTNTEXT;
    10: Result:=COLOR_CAPTIONTEXT;
    11: Result:=COLOR_GRAYTEXT;
    12: Result:=COLOR_HIGHLIGHT	;
    13: Result:=COLOR_HIGHLIGHTTEXT;
    14: Result:=COLOR_INACTIVEBORDER;
    15: Result:=COLOR_INACTIVECAPTION;
    16: Result:=COLOR_INACTIVECAPTIONTEXT;
    17: Result:=COLOR_INFOBK;
    18: Result:=COLOR_INFOTEXT;
    19: Result:=COLOR_MENU;
    20: Result:=COLOR_MENUTEXT;
    21: Result:=COLOR_SCROLLBAR;
    22: Result:=COLOR_WINDOW;
    23: Result:=COLOR_WINDOWFRAME;
    24: Result:=COLOR_WINDOWTEXT;
  else Result:=0;
  end;
end;

procedure TfrmCoolorDialog.lsbWindowsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  OldColor: TColor;
begin
  if not (odFocused in State) then
    with Control as TListBox,Items,Canvas,Rect do
    begin
      FillRect(Rect);
      TextOut(Left+ItemHeight+8,Top,Items[Index]);
      OldColor:=Brush.Color;
      Brush.Color:=GetSysColor(Integer(Objects[Index]));
      Pen.Color:=Font.Color;
      Rectangle(Left+2,Top+2,ItemHeight+2,Bottom-2);
      Brush.Color:=OldColor;
    end;
end;

procedure TfrmCoolorDialog.lsbWindowsClick(Sender: TObject);
begin
  UpdateColor;
end;

procedure TfrmCoolorDialog.WMSysColorChange(var Message: TMessage);
begin
  UpdateSysColors;
  UpdateColor;
end;

procedure TfrmCoolorDialog.UpdateSysColors;
var
  i: Integer;
begin
  with lsbWindows,Items do
    for i:=0 to Pred(Count) do Objects[i]:=Pointer(GetIndexColor(i));
end;

procedure TfrmCoolorDialog.UpdateInfo;

var
  GE: Boolean;

  function FormatColor(Names: array of string; Values: array of Real): string;
  var
    i: Integer;
  begin
    Result:='';
    for i:=0 to High(Names) do
    begin
      if chbNames.Checked then Result:=Result+Names[i]+'=';
      case rgrNumbers.ItemIndex of
        0: Result:=Result+IntToStr(Round(Values[i]));
        1: Result:=Result+IntToHex(Round(Values[i]),2);
      end;
      if i<>High(Names) then
      begin
        if chbComma.Checked then Result:=Result+',';
        if chbSpace.Checked then Result:=Result+' ';
      end;
    end;
  end;

begin
  with pnlColor do
  begin
    with ColorToHSB(Color) do lblHSBValue.Caption:=FormatColor(['Hue','Saturation','Brightness'],[Hue,Saturation,Brightness]);
    with ColorToRGB(Color) do lblRGBValue.Caption:=FormatColor(['Red','Green','Blue'],[Red,Green,Blue]);
    with ColorToCMY(Color) do lblCMYValue.Caption:=FormatColor(['Cyan','Magenta','Yellow'],[Cyan,Magenta,Yellow]);
    with ColorToCMYK(Color) do lblCMYKValue.Caption:=FormatColor(['Cyan','Magenta','Yellow','Black'],[Cyan,Magenta,Yellow,Black]);
    GE:=RGBGray(ColorToRGB(Color));
    sbtGray.Visible:=GE;
    lblGrayTitle.Visible:=GE;
    lblGrayValue.Visible:=GE;
    lblGrayValue.Caption:=FormatColor(['Brightness'],[FResultRGB.Red]);
  end;
end;

procedure TfrmCoolorDialog.UpdateNamesCheckBox;
var
  E: Boolean;
begin
  E:=chbSpace.Checked or chbComma.Checked;
  if not E then chbNames.Checked:=False;
  chbNames.Enabled:=E;
end;

procedure TfrmCoolorDialog.eveInfoClick(Sender: TObject);
begin
  UpdateNamesCheckBox;
  UpdateInfo;
end;

procedure TfrmCoolorDialog.chbNamesClick(Sender: TObject);
begin
  UpdateInfo;
end;

procedure TfrmCoolorDialog.sbtHSBClick(Sender: TObject);
begin
  Clipboard.AsText:=lblHSBValue.Caption;
end;

procedure TfrmCoolorDialog.sbtRGBClick(Sender: TObject);
begin
  Clipboard.AsText:=lblRGBValue.Caption;
end;

procedure TfrmCoolorDialog.sbtCMYClick(Sender: TObject);
begin
  Clipboard.AsText:=lblCMYValue.Caption;
end;

procedure TfrmCoolorDialog.sbtGrayClick(Sender: TObject);
begin
  Clipboard.AsText:=lblGrayValue.Caption;
end;

function TfrmCoolorDialog.GetCollectedColor(Index: Integer): TColor;
var
  PNL: TPanel;
begin
  PNL:=FindComponent('pnl'+IntToStr(Index)) as TPanel;
  Result:=PNL.Color;
end;

procedure TfrmCoolorDialog.SetCollectedColor(Index: Integer;
  Value: TColor);
var
  PNL: TPanel;
begin
  PNL:=FindComponent('pnl'+IntToStr(Index)) as TPanel;
  PNL.Color:=Value;
end;

function TfrmCoolorDialog.GetResultColor: TColor;
begin
  Result:=RGBToColor(GetRGB);
end;

procedure TfrmCoolorDialog.SetResultColor(Value: TColor);
begin
  FResultRGB:=ColorToRGB(Value);
  SetRGB(FResultRGB);
end;

procedure TfrmCoolorDialog.SetRefColor(Value: TColor);
begin
  if Value<>pnlReferenceColor.Color then
  begin
    pnlReferenceColor.Color:=Value;
    UpdateColor;
  end;
end;

function TfrmCoolorDialog.GetRefColor: TColor;
begin
  Result:=pnlReferenceColor.Color;
end;

procedure TfrmCoolorDialog.btnHelpClick(Sender: TObject);
begin
  if FAutoHelpContext then Application.HelpContext(Succ(HelpContext)+pgcSystems.ActivePage.Tag)
  else Application.HelpContext(HelpContext);
end;

function GetDelta(Color: TColor; RGB: TRGB): Real;
begin
  with ColorToRGB(Color) do
    Result:=RGB.Red*Abs(Red-RGB.Red)/255+RGB.Green*Abs(Green-RGB.Green)/255+RGB.Blue*Abs(Blue-RGB.Blue)/255;
end;

procedure TfrmCoolorDialog.sbtRoundClick(Sender: TObject);
var
  X,Y,XMin,YMin: Integer;
  Delta,DeltaMin: Real;
begin
  DeltaMin:=3*255;
  XMin:=-1;
  YMin:=-1;
  for Y:=0 to 11 do
    for X:=0 to 17 do
    begin
      Delta:=GetDelta(GetInternetColor(X,Y),FResultRGB);
      if Delta<DeltaMin then
      begin
        DeltaMin:=Delta;
        XMin:=X;
        YMin:=Y;
      end;
    end;
  SetRGB(ColorToRGB(GetInternetColor(XMin,YMin)));
end;

procedure TfrmCoolorDialog.sbtRoundGrayClick(Sender: TObject);
var
  X,Y,XMin,YMin: Integer;
  Delta,DeltaMin: Real;
  HSB: THSB;
begin
  DeltaMin:=3*255;
  XMin:=-1;
  YMin:=-1;
  for Y:=0 to 11 do
    for X:=0 to 17 do
    begin
      HSB:=RGBToHSB(FResultRGB);
      with HSB do HSB:=MakeHSB(Hue,0,Brightness);
      Delta:=GetDelta(GetInternetColor(X,Y),HSBToRGB(HSB));
      if Delta<DeltaMin then
      begin
        DeltaMin:=Delta;
        XMin:=X;
        YMin:=Y;
      end;
    end;
  SetRGB(ColorToRGB(GetInternetColor(XMin,YMin)));
end;

constructor TfrmCoolorDialog.Create(AOwner: TComponent);
begin
  inherited Create(Application);
  FCoolorDialog:=TCoolorDialog(AOwner);
end;

{ TCoolorDialog }

constructor TCoolorDialog.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);
  FVisiblePages:=[pageVGA,pageHSB,pageRGB,pageCMY,pageCMYK];
  FActivePage:=pageVGA;
  FCtl3D:=True;
  FReferenceColor:=clWhite;
  FCaption:='Color';
  for i:=1 to UserColorCount do FUserColors[i]:=clSilver;
end;

function TCoolorDialog.Execute: Boolean;
{$IFDEF DIRECTCMYK}
var
  ICMYKColor: TCMYKColor;
{$ENDIF}
begin
  if not Assigned(FDialog) then
  begin
    FDialog:=TfrmCoolorDialog.Create(Self);
    with FDialog do
    try
      btnOk.Caption:='OK';
      btnCancel.Caption:='Cancel';
      SetProperties;
      if Assigned(FOnShow) then FOnShow(Self);
      Result:=ShowModal=mrOk;
      if Assigned(FOnClose) then FOnClose(Self);
      if Result then
      begin
        {$IFDEF DIRECTCMYK}
        if Assigned(FDialog) then
          with FDialog do
          begin
            if TDialogPage(pgcSystems.ActivePage.Tag)=pageCMYK then
            begin
              ICMYKColor:=CMYKToCMYKColor(MakeCMYK(trbKCyan.Position,trbKMagenta.Position,trbKYellow.Position,trbKBlack.Position));
              with FCoolorDialog do
                if Assigned(FOnGetCMYK) then FOnGetCMYK(Self,ICMYKColor);
            end;
          end;
        {$ENDIF}
        GetProperties;
      end
      else
      begin
        FUserColors:=RUserColors;
        FColor:=RColor;
        FReferenceColor:=RReferenceColor;
      end;
      DoApply(True);
    finally
      Free;
      FDialog:=nil;
    end;
  end
  else
  begin
    raise ECoolorDialogException.Create('TCoolorDialog is already visible.');
    Result:=False;
  end;
end;

procedure TCoolorDialog.Show;
begin
  if not Assigned(FDialog) then
  begin
    FDialog:=TfrmCoolorDialog.Create(Self);
    with FDialog do
    begin
      ModalResult:=mrNone;
      if FAutoApply then
      begin
        btnOk.Caption:='O&K';
        btnCancel.Caption:='&Cancel'
      end
      else
      begin
        btnOk.Caption:='&Apply';
        btnCancel.Caption:='&Close';
      end;
      SetProperties;
      OnClose:=OnDialogClose;
      btnOk.OnClick:=OnApplyButton;
      btnCancel.OnClick:=OnCloseButton;
      if Assigned(FOnShow) then FOnShow(Self);
      Show;
    end;
  end
  else raise ECoolorDialogException.Create('TCoolorDialog is already visible.');
end;

procedure TCoolorDialog.DoApply(ForSure: Boolean);
begin
  if Assigned(FOnApply) and (ForSure or FAutoApply) then FOnApply(Self);
end;

procedure TCoolorDialog.OnDialogClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FDialog) then
  begin
    if Assigned(FOnClose) then FOnClose(Self);
    if FDialog.ModalResult<>mrOk then
    begin
      FUserColors:=RUserColors;
      FColor:=RColor;
      FReferenceColor:=RReferenceColor;
      DoApply(False);
    end;
    FDialog.Release;
    FDialog:=nil;
  end;
end;

procedure TCoolorDialog.OnApplyButton(Sender: TObject);
{$IFDEF DIRECTCMYK}
var
  ICMYKColor: TCMYKColor;
{$ENDIF}
begin
  if  FAutoApply and Assigned(FDialog) then FDialog.ModalResult:=mrOk;
  {$IFDEF DIRECTCMYK}
  if Assigned(FDialog) then
    with FDialog do
    begin
      if TDialogPage(pgcSystems.ActivePage.Tag)=pageCMYK then
      begin
        ICMYKColor:=CMYKToCMYKColor(MakeCMYK(trbKCyan.Position,trbKMagenta.Position,trbKYellow.Position,trbKBlack.Position));
        with FCoolorDialog do
          if Assigned(FOnGetCMYK) then FOnGetCMYK(Self,ICMYKColor);
      end;
  end;
  {$ENDIF}
  GetProperties;
  DoApply(True);
  if FAutoApply and Assigned(FDialog) then FDialog.Close;
end;

procedure TCoolorDialog.OnCloseButton(Sender: TObject);
begin
  if Assigned(FDialog) then FDialog.Close;
end;

procedure TCoolorDialog.SetColor(const Value: TColor);
begin
  FColor:=Value;
  if Assigned(FDialog) then FDialog.SetResultColor(Value);
  DoApply(False);
end;

procedure TCoolorDialog.SetReferenceColor(const Value: TColor);
begin
  FReferenceColor:=Value;
  if Assigned(FDialog) then FDialog.SetRefColor(Value);
end;

function TCoolorDialog.GetHSBColor: THSBColor;
begin
  Result:=HSBToHSBColor(ColorToHSB(Color));
end;

procedure TCoolorDialog.SetHSBColor(const Value: THSBColor);
begin
  Color:=HSBToColor(HSBColorToHSB(Value));
end;

function TCoolorDialog.GetRGBColor: TRGBColor;
begin
  Result:=RGBToRGBColor(ColorToRGB(Color));
end;

procedure TCoolorDialog.SetRGBColor(const Value: TRGBColor);
begin
  Color:=RGBToColor(RGBColorToRGB(Value));
end;

function TCoolorDialog.GetRGBHex: TRGBHex;
begin
  Result:=ColorToRGBHex(Color);
end;

procedure TCoolorDialog.SetRGBHex(const Value: TRGBHex);
begin
  Color:=RGBHexToColor(Value);
end;

function TCoolorDialog.GetCMYColor: TCMYColor;
begin
  Result:=CMYToCMYColor(ColorToCMY(Color));
end;

procedure TCoolorDialog.SetCMYColor(const Value: TCMYColor);
begin
  Color:=CMYToColor(CMYColorToCMY(Value));
end;

function TCoolorDialog.GetCMYKColor: TCMYKColor;
begin
  Result:=CMYKToCMYKColor(ColorToCMYK(Color));
end;

procedure TCoolorDialog.SetCMYKColor(const Value: TCMYKColor);
begin
  Color:=CMYKToColor(CMYKColorToCMYK(Value));
end;

function TCoolorDialog.GetHTMLColor: THTMLColor;
begin
  Result:=ColorToHTML(Color);
end;

procedure TCoolorDialog.SetHTMLColor(const Value: THTMLColor);
begin
  Color:=HTMLToColor(Value);
end;

function TCoolorDialog.GetUserColor(Index: Integer): TColor;
begin
  Result:=FUserColors[Index];
end;

procedure TCoolorDialog.SetUserColor(Index: Integer;
  const Value: TColor);
begin
  FUserColors[Index]:=Value;
end;

procedure TCoolorDialog.SetAutoApply(const Value: Boolean);
begin
  if Value<>FAutoApply then
  begin
    FAutoApply:=Value;
    if Assigned(FDialog) then
      with FDialog do
        if FAutoApply then
        begin
          btnOk.Caption:='O&K';
          btnCancel.Caption:='&Cancel'
        end
        else
        begin
          btnOk.Caption:='&Apply';
          btnCancel.Caption:='&Close';
        end;
  end;
end;

procedure TCoolorDialog.SetStayOnTop(const Value: Boolean);
begin
  if Value<>FStayOnTop then
  begin
    FStayOnTop:=Value;
    if Assigned(FDialog) then
      with FDialog do
        if FStayOnTop then FormStyle:=fsStayOnTop
        else FormStyle:=fsNormal;
  end;
end;

procedure TCoolorDialog.SetVisiblePages(const Value: TDialogPages);
begin
  if Value<>FVisiblePages then
  begin
    FVisiblePages:=Value;
    if Assigned(FDialog) then
      with FDialog do
      begin
        tshVGA.TabVisible:=pageVGA in VisiblePages;
        tshInternet.TabVisible:=pageInternet in VisiblePages;
        tshHSB.TabVisible:=pageHSB in VisiblePages;
        tshRGB.TabVisible:=pageRGB in VisiblePages;
        tshCMY.TabVisible:=pageCMY in VisiblePages;
        tshCMYK.TabVisible:=pageCMYK in VisiblePages;
        tshGray.TabVisible:=pageGray in VisiblePages;
        tshWindows.TabVisible:=pageWindows in VisiblePages;
        tshInfo.TabVisible:=pageInfo in VisiblePages;
      end;
  end;
end;

procedure TCoolorDialog.SetActivePage(const Value: TDialogPage);
begin
  if Value<>FActivePage then
  begin
    FActivePage:=Value;
    if Assigned(FDialog) then
      with FDialog,pgcSystems do
        case Self.ActivePage of
          pageVGA: if tshVGA.TabVisible then ActivePage:=tshVGA;
          pageInternet: if tshInternet.TabVisible then ActivePage:=tshInternet;
          pageHSB: if tshHSB.TabVisible then ActivePage:=tshHSB;
          pageRGB: if tshRGB.TabVisible then ActivePage:=tshRGB;
          pageCMY: if tshCMY.TabVisible then ActivePage:=tshCMY;
          pageCMYK: if tshCMYK.TabVisible then ActivePage:=tshCMYK;
          pageGray: if tshGray.TabVisible then ActivePage:=tshGray;
          pageWindows: if tshWindows.TabVisible then ActivePage:=tshWindows;
          pageInfo: if tshInfo.TabVisible then ActivePage:=tshInfo;
        end;
  end;
end;

procedure TCoolorDialog.SetCtl3D(const Value: Boolean);
begin
  if Value<>FCtl3D then
  begin
    FCtl3D:=Value;
    if Assigned(FDialog) then FDialog.Ctl3D:=FCtl3D;
  end;
end;

procedure TCoolorDialog.SetHelpButton(const Value: Boolean);
begin
  if Value<>FHelpButton then
  begin
    FHelpButton:=Value;
    if Assigned(FDialog) then FDialog.btnHelp.Visible:=FHelpButton;
  end;
end;

procedure TCoolorDialog.SetAutoHelpContext(const Value: Boolean);
begin
  if Value<>FAutoHelpContext then
  begin
    FAutoHelpContext:=Value;
    if Assigned(FDialog) then FDialog.FAutoHelpContext:=AutoHelpContext;
  end;
end;

procedure TCoolorDialog.SetHelpContext(const Value: THelpContext);
begin
  if Value<>FHelpContext then
  begin
    FHelpContext:=Value;
    if Assigned(FDialog) then FDialog.HelpContext:=FHelpContext;
  end;
end;

procedure TCoolorDialog.SetCaption(const Value: string);
begin
  if Value<>Caption then
  begin
    FCaption:=Value;
    if Assigned(FDialog) then FDialog.Caption:=FCaption;
  end;
end;

function TCoolorDialog.GetDialog: TForm;
begin
  Result:=FDialog;
end;

function TCoolorDialog.GetHandle: HWND;
begin
  if Assigned(FDialog) then Result:=FDialog.Handle
  else Result:=0;
end;

procedure TCoolorDialog.SetProperties;
var
  i: Integer;
begin
  if Assigned(FDialog) then
    with FDialog do
    begin
      if FStayOnTop then FormStyle:=fsStayOnTop
      else FormStyle:=fsNormal;
      HelpContext:=Self.HelpContext;
      FAutoHelpContext:=AutoHelpContext;
      Ctl3D:=FCtl3D;
      btnHelp.Visible:=HelpButton;
      for i:=1 to UserColorCount do
        SetCollectedColor(i,UserColors[i]);
      RUserColors:=FUserColors;
      tshVGA.TabVisible:=pageVGA in VisiblePages;
      tshInternet.TabVisible:=pageInternet in VisiblePages;
      tshHSB.TabVisible:=pageHSB in VisiblePages;
      tshRGB.TabVisible:=pageRGB in VisiblePages;
      tshCMY.TabVisible:=pageCMY in VisiblePages;
      tshCMYK.TabVisible:=pageCMYK in VisiblePages;
      tshGray.TabVisible:=pageGray in VisiblePages;
      tshWindows.TabVisible:=pageWindows in VisiblePages;
      tshInfo.TabVisible:=pageInfo in VisiblePages;
      with pgcSystems do
        case Self.ActivePage of
          pageVGA: if tshVGA.TabVisible then ActivePage:=tshVGA;
          pageInternet: if tshInternet.TabVisible then ActivePage:=tshInternet;
          pageHSB: if tshHSB.TabVisible then ActivePage:=tshHSB;
          pageRGB: if tshRGB.TabVisible then ActivePage:=tshRGB;
          pageCMY: if tshCMY.TabVisible then ActivePage:=tshCMY;
          pageCMYK: if tshCMYK.TabVisible then ActivePage:=tshCMYK;
          pageGray: if tshGray.TabVisible then ActivePage:=tshGray;
          pageWindows: if tshWindows.TabVisible then ActivePage:=tshWindows;
          pageInfo: if tshInfo.TabVisible then ActivePage:=tshInfo;
        end;
      pnlReferenceColor.Color:=FReferenceColor;
      pnlColor.Color:=FColor;
      SetResultColor(Self.Color);
      RColor:=Self.Color;
      RReferenceColor:=Self.ReferenceColor;
      SetRefColor(ReferenceColor);
      UpdateInfo;
      Caption:=FCaption;
    end;
end;

procedure TCoolorDialog.GetProperties;
var
  i: Integer;
begin
  if Assigned(FDialog) then
    with FDialog do
    begin
      Self.ActivePage:=TDialogPage(pgcSystems.ActivePage.Tag);
      for i:=1 to UserColorCount do
        UserColors[i]:=GetCollectedColor(i);
      Self.FColor:=GetResultColor;
      FReferenceColor:=GetRefColor;
    end;
end;

procedure TfrmCoolorDialog.trbCMYKChange(Sender: TObject);
begin
  UpdateCMYKUpDown;
end;

procedure TfrmCoolorDialog.edtKCyanChange(Sender: TObject);
begin
  try
    trbKCyan.Position:=StrToInt(edtKCyan.Text);
  except
    trbKCyan.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtKMagentaChange(Sender: TObject);
begin
  try
    trbKMagenta.Position:=StrToInt(edtKMagenta.Text);
  except
    trbKMagenta.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtKYellowChange(Sender: TObject);
begin
  try
    trbKYellow.Position:=StrToInt(edtKYellow.Text);
  except
    trbKYellow.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtKBlackChange(Sender: TObject);
begin
  try
    trbKBlack.Position:=StrToInt(edtKBlack.Text);
  except
    trbKBlack.Position:=0;
  end;
  UpdateColor;
end;

procedure TfrmCoolorDialog.edtKCyanExit(Sender: TObject);
begin
  edtKCyan.Text:=IntToStr(trbKCyan.Position);
end;

procedure TfrmCoolorDialog.edtKMagentaExit(Sender: TObject);
begin
  edtKMagenta.Text:=IntToStr(trbKMagenta.Position);
end;

procedure TfrmCoolorDialog.edtKYellowExit(Sender: TObject);
begin
  edtKYellow.Text:=IntToStr(trbKYellow.Position);
end;

procedure TfrmCoolorDialog.edtKBlackExit(Sender: TObject);
begin
  edtKBlack.Text:=IntToStr(trbKBlack.Position);
end;

procedure TfrmCoolorDialog.udnKCyanChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbKCyan.Position:=udnKCyan.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnKMagentaChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbKMagenta.Position:=udnKMagenta.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnKYellowChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbKYellow.Position:=udnKYellow.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.udnKBlackChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  trbKBlack.Position:=udnKBlack.Position;
  UpdateColor;
end;

procedure TfrmCoolorDialog.pntCMYKMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TRB: TTrackBar;
begin
  with Sender as TPaintBox do
  begin
    case Tag of
      1: TRB:=trbKCyan;
      2: TRB:=trbKMagenta;
      3: TRB:=trbKYellow;
    else TRB:=trbKBlack;
    end;
    TRB.Position:=100*X div Width;
    TRB.SetFocus;
    UpdateCMYKUpDown;
    UpdateColor;
  end;
end;

procedure TfrmCoolorDialog.pntKBlackPaint(Sender: TObject);
var
  i: Integer;
begin
  with Sender as TPaintBox,Canvas do
    for i:=0 to Pred(Width) do
    begin
      Pen.Color:=MakeGrayColor(255*(Width-i) div Width);
      MoveTo(i,0);
      LineTo(i,Height);
    end;
end;

procedure TfrmCoolorDialog.pgcSystemsChanging(Sender: TObject;
  var AllowChange: Boolean);
{$IFDEF DIRECTCMYK}
var
  ICMYKColor: TCMYKColor;
{$ENDIF}
begin
  {$IFDEF DIRECTCMYK}
  if Assigned(FCoolorDialog) then
  begin
    if TDialogPage(pgcSystems.ActivePage.Tag)=pageCMYK then
    begin
      ICMYKColor:=CMYKToCMYKColor(MakeCMYK(trbKCyan.Position,trbKMagenta.Position,trbKYellow.Position,trbKBlack.Position));
      with FCoolorDialog do
        if Assigned(FOnGetCMYK) then FOnGetCMYK(Self,ICMYKColor);
    end;
  end;
  {$ENDIF}
end;

end.
