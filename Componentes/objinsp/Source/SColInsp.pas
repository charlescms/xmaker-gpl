(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.004                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit SColInsp;

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

interface

uses Windows, SysUtils, Classes, Graphics, StdCtrls, Dialogs, InspCtrl;

const
  {$IFDEF VERSION3}
  COLOR_GRADIENTACTIVECAPTION = 27;
  COLOR_GRADIENTINACTIVECAPTION = 28;
  {$ENDIF}

  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
  clMedGray = TColor($A4A0A0);

  STR_COLOR_3DDKSHADOW              = '3D dark shadow';
  STR_COLOR_3DFACE                  = '3D face';
  STR_COLOR_3DHILIGHT               = '3D highlight';
  STR_COLOR_3DLIGHT	                = '3D light';
  STR_COLOR_3DSHADOW                = '3D shadow';
  STR_COLOR_ACTIVEBORDER	          = 'Active window border';
  STR_COLOR_ACTIVECAPTION	          = 'Active window caption';
  STR_COLOR_GRADIENTACTIVECAPTION   = 'Active window caption gradient';
  STR_COLOR_APPWORKSPACE            =	'MDI background color';
  STR_COLOR_DESKTOP	                = 'Desktop';
  STR_COLOR_BTNTEXT	                = 'Text on push buttons';
  STR_COLOR_CAPTIONTEXT	            = 'Active window caption text';
  STR_COLOR_GRAYTEXT	              = 'Grayed text';
  STR_COLOR_HIGHLIGHT	              = 'Selected item';
  STR_COLOR_HIGHLIGHTTEXT	          = 'Text of selected item';
  STR_COLOR_INACTIVEBORDER	        = 'Inactive window border';
  STR_COLOR_INACTIVECAPTION	        = 'Inactive window caption';
  STR_COLOR_GRADIENTINACTIVECAPTION	= 'Inactive window caption gradient';
  STR_COLOR_INACTIVECAPTIONTEXT	    = 'Inactive window caption text';
  STR_COLOR_INFOBK                  = 'Tooltip background';
  STR_COLOR_INFOTEXT	              = 'Tooltip text';
  STR_COLOR_MENU	                  = 'Menu background';
  STR_COLOR_MENUTEXT	              = 'Menu text';
  STR_COLOR_SCROLLBAR	              = 'Scroll bar background';
  STR_COLOR_WINDOW	                = 'Window background';
  STR_COLOR_WINDOWFRAME	            = 'Window frame';
  STR_COLOR_WINDOWTEXT	            = 'Window text';

  strWhite      = 'White';
  strBlack      = 'Black';
  strSilver     = 'Silver';
  strGray       = 'Gray';
  strRed        = 'Red';
  strMaroon     = 'Maroon';
  strYellow     = 'Yellow';
  strOlive      = 'Olive';
  strLime       = 'Lime';
  strGreen      = 'Green';
  strAqua       = 'Aqua';
  strTeal       = 'Teal';
  strBlue       = 'Blue';
  strNavy       = 'Navy';
  strFuchsia    = 'Fuchsia';
  strPurple     = 'Purple';
  strMoneyGreen = 'Money Green';
  strSkyBlue    = 'Sky Blue';
  strCream      = 'Cream';
  strMedGray    = 'Medium Gray';

type
  TColorData = record
    ColorID: Integer;
    ColorName: ShortString;
  end;

const
  ColorCount = 27;
  ColorsData: array[0..Pred(ColorCount)] of TColorData = (
    (ColorID: COLOR_3DDKSHADOW; ColorName: STR_COLOR_3DDKSHADOW),
    (ColorID: COLOR_3DFACE; ColorName: STR_COLOR_3DFACE),
    (ColorID: COLOR_3DHILIGHT; ColorName: STR_COLOR_3DHILIGHT),
    (ColorID: COLOR_3DLIGHT; ColorName: STR_COLOR_3DLIGHT),
    (ColorID: COLOR_3DSHADOW; ColorName: STR_COLOR_3DSHADOW),
    (ColorID: COLOR_DESKTOP; ColorName: STR_COLOR_DESKTOP),
    (ColorID: COLOR_APPWORKSPACE; ColorName: STR_COLOR_APPWORKSPACE),
    (ColorID: COLOR_WINDOWFRAME; ColorName: STR_COLOR_WINDOWFRAME),
    (ColorID: COLOR_WINDOW; ColorName: STR_COLOR_WINDOW),
    (ColorID: COLOR_WINDOWTEXT; ColorName: STR_COLOR_WINDOWTEXT),
    (ColorID: COLOR_ACTIVEBORDER; ColorName: STR_COLOR_ACTIVEBORDER),
    (ColorID: COLOR_ACTIVECAPTION; ColorName: STR_COLOR_ACTIVECAPTION),
    (ColorID: COLOR_GRADIENTACTIVECAPTION; ColorName: STR_COLOR_GRADIENTACTIVECAPTION),
    (ColorID: COLOR_CAPTIONTEXT; ColorName: STR_COLOR_CAPTIONTEXT),
    (ColorID: COLOR_INACTIVEBORDER; ColorName: STR_COLOR_INACTIVEBORDER),
    (ColorID: COLOR_INACTIVECAPTION; ColorName: STR_COLOR_INACTIVECAPTION),
    (ColorID: COLOR_GRADIENTINACTIVECAPTION; ColorName: STR_COLOR_GRADIENTINACTIVECAPTION),
    (ColorID: COLOR_INACTIVECAPTIONTEXT; ColorName: STR_COLOR_INACTIVECAPTIONTEXT),
    (ColorID: COLOR_HIGHLIGHT; ColorName: STR_COLOR_HIGHLIGHT),
    (ColorID: COLOR_HIGHLIGHTTEXT; ColorName: STR_COLOR_HIGHLIGHTTEXT),
    (ColorID: COLOR_GRAYTEXT; ColorName: STR_COLOR_GRAYTEXT),
    (ColorID: COLOR_BTNTEXT; ColorName: STR_COLOR_BTNTEXT),
    (ColorID: COLOR_INFOBK; ColorName: STR_COLOR_INFOBK),
    (ColorID: COLOR_INFOTEXT; ColorName: STR_COLOR_INFOTEXT),
    (ColorID: COLOR_MENU; ColorName: STR_COLOR_MENU),
    (ColorID: COLOR_MENUTEXT; ColorName: STR_COLOR_MENUTEXT),
    (ColorID: COLOR_SCROLLBAR; ColorName: STR_COLOR_SCROLLBAR));

  StdColorCount = 20;
  StdColorsData: array[0..Pred(StdColorCount)] of TColorData = (
    (ColorID: clWhite; ColorName: strWhite),
    (ColorID: clBlack; ColorName: strBlack),
    (ColorID: clSilver; ColorName: strSilver),
    (ColorID: clGray; ColorName: strGray),
    (ColorID: clRed; ColorName: strRed),
    (ColorID: clMaroon; ColorName: strMaroon),
    (ColorID: clYellow; ColorName: strYellow),
    (ColorID: clOlive; ColorName: strOlive),
    (ColorID: clLime; ColorName: strLime),
    (ColorID: clGreen; ColorName: strGreen),
    (ColorID: clAqua; ColorName: strAqua),
    (ColorID: clteal; ColorName: strTeal),
    (ColorID: clBlue; ColorName: strBlue),
    (ColorID: clNavy; ColorName: strNavy),
    (ColorID: clFuchsia; ColorName: strFuchsia),
    (ColorID: clPurple; ColorName: strPurple),
    (ColorID: clMoneyGreen; ColorName: strMoneyGreen),
    (ColorID: clSkyBlue; ColorName: strSkyBlue),
    (ColorID: clCream; ColorName: strCream),
    (ColorID: clMedGray; ColorName: strMedGray));

type

  TCustomSystemColorsInspector = class(TCustomInspector)
  private
    function StdColorToName(C: TColor): string;
    function StdNameToColor(S: string; var C: TColor): Boolean;
  protected
    function GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer; override;
    procedure DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer); override;
    procedure DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetIndent: Integer; override;
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); override;
    function GetSelectedValue(TheIndex: Integer): string; override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSystemColorsInspector = class(TCustomSystemColorsInspector)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property IntegralHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property PaintStyle;
    property Splitter;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetInplaceEditorType;
    property OnGetMaxLength;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetReadOnly;
    property OnGetExpandState;
    property OnGetLevel;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetAutoApply;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
  end;

implementation

function TCustomSystemColorsInspector.StdColorToName(C: TColor): string;
var
  i: Integer;
begin
  for i:=0 to Pred(StdColorCount) do
    with StdColorsData[i] do
      if ColorID=C then
      begin
        Result:=ColorName;
        Exit;
      end;
  Result:=Format('%d,%d,%d',[GetRValue(C),GetGValue(C),GetBValue(C)]);
end;

function TCustomSystemColorsInspector.StdNameToColor(S: string; var C: TColor): Boolean;
var
  i,R,G,B,P: Integer;
begin
  S:=AnsiUpperCase(S);
  for i:=0 to Pred(StdColorCount) do
    with StdColorsData[i] do
      if AnsiUpperCase(ColorName)=S then
      begin
        C:=ColorID;
        Result:=True;
        Exit;
      end;
  Result:=False;
  try
    P:=Pos(',',S);
    if P<>0 then
    begin
      R:=StrToInt(Copy(S,1,Pred(P)));
      Delete(S,1,P);
      P:=Pos(',',S);
      if P<>0 then
      begin
        G:=StrToInt(Copy(S,1,Pred(P)));
        Delete(S,1,P);
        B:=StrToInt(S);
        C:=RGB(R,G,B);
        Result:=True;
      end;
    end;
  except
  end;
end;

function TCustomSystemColorsInspector.GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer;
begin
  Result:=inherited GetPopupItemWidth(ListBox,TheIndex)+ItemHeight-2;
end;

procedure TCustomSystemColorsInspector.DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer);
var
  IR: TRect;
  OldColor: TColor;
begin
  with ListBox,Canvas,R do
  begin
    FillRect(R);
    Pen.Color:=clWindowText;
    OldColor:=Brush.Color;
    Brush.Color:=StdColorsData[ListItemIndex].ColorID;
    IR:=R;
    InflateRect(IR,-2,-2);
    with IR do
    begin
      Dec(Bottom);
      Right:=Left+(Bottom-Top);
      Rectangle(Left,Top,Right,Bottom);
    end;
    Brush.Color:=OldColor;
    Inc(Left,ItemHeight-1);
    DrawText(Handle,PChar(Items[ListItemIndex]),-1,R,DT_SINGLELINE or DT_VCENTER);
  end;
end;

procedure TCustomSystemColorsInspector.DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  IR: TRect;
begin
  with TheCanvas,R do
  begin
    Pen.Color:=clWindowText;
    Brush.Color:=GetSysColor(ColorsData[TheIndex].ColorID);
    IR:=R;
    InflateRect(IR,-2,-2);
    with IR do
    begin
      Dec(Bottom);
      Right:=Left+(Bottom-Top);
      Rectangle(Left,Top,Right,Bottom);
    end;
    Inc(Left,ItemHeight-2);
  end;
  inherited;
end;

function TCustomSystemColorsInspector.GetName(TheIndex: Integer): string;
begin
  Result:=ColorsData[TheIndex].ColorName;
end;

function TCustomSystemColorsInspector.GetValue(TheIndex: Integer): string;
begin
  Result:=StdColorToName(GetSysColor(ColorsData[TheIndex].ColorID));
end;

procedure TCustomSystemColorsInspector.SetValue(TheIndex: Integer; const Value: string);
var
  C: TColor;
begin
  if StdNameToColor(Value,C) and (C<>GetSysColor(ColorsData[TheIndex].ColorID)) then
    SetSysColors(1,ColorsData[TheIndex].ColorID,C);
end;

function TCustomSystemColorsInspector.GetIndent: Integer;
begin
  Result:=0;
end;

procedure TCustomSystemColorsInspector.GetValuesList(TheIndex: Integer; const Strings: TStrings);
var
  i: Integer;
begin
  for i:=0 to Pred(StdColorCount) do Strings.Add(StdColorsData[i].ColorName);
end;

function TCustomSystemColorsInspector.GetSelectedValue(TheIndex: Integer): string;
begin
  Result:=GetValue(TheIndex);
end;

function TCustomSystemColorsInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  Result:=btDropDown;
end;

function TCustomSystemColorsInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  Result:=True;
end;

function TCustomSystemColorsInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  with TColorDialog.Create(Self) do
  try
    Color:=GetSysColor(ColorsData[TheIndex].ColorID);
    Result:=Execute;
    if Result and (Color<>GetSysColor(ColorsData[TheIndex].ColorID)) then
    begin
      SetSysColors(1,ColorsData[TheIndex].ColorID,Color);
      Update;
    end;
  finally
    Free;
  end;
end;

constructor TCustomSystemColorsInspector.Create(AOwner: TComponent);
begin
  inherited;
  ItemCount:=ColorCount;
end;

end.
