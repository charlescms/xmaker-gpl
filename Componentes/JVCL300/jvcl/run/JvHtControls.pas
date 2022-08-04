{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvHTControls.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Andrei Prygounkov <a dott prygounkov att gmx dott de>
CopyRight (c) 1999, 2002 Andrei Prygounkov
All Rights Reserved.

Contributor(s):
  Maciej Kaczkowski

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Description:
  HT Controls

Known Issues:
Maciej Kaczkowski:
  [X] alignment not work correctly on JvHTButtonGlyph
  [X] not tested on BCB & Kylix
  [X] hyperlink work only whet alignment is left

Some information about coding:
  [?] If you want use few times function <ALIGN> you must use before next <ALIGN> function <BR>

Changes:
========
Peter Thornqvist:
  2004-01-279
    + Moved implementations to TJvCustomXXX classed
    + Now the registered controls only publish properties and events
Andr� Snepvangers:
  2004-01-06
      VisualCLX compatible version
Maciej Kaczkowski:
  2003-09-16
  [+] <BR> - new line
  [+] <HR> - horizontal line
  [+] <S> and </S> - StrikeOut
  [+] Multiline for JvHTListBox, JvHTComboBox, TJvHTButton
  [+] You can change Height of JvHTComboBox
  [+] Tags: &amp; &quot; &reg; &copy; &trade; &nbsp; &lt; &gt;
  [+] <ALIGN [CENTER, LEFT, Right]>
  [*] <C:color> was changed to ex.: <FONT COLOR="clRed" BGCOLOR="clWhite">
      </FONT>
  [*] procedure ItemHTDrawEx - rewrited
  [*] function ItemHTPlain - optimized

  2003-09-23
  [*] fixed problem with <hr><br> - just use <hr>
  [-] fixed problem with inserting htcombobox on form
  [-] variable height is not work in design time, to use this put in code ex.:
      htcombobox1.SetHeight(40)
    to read height
      Value := htcombobox1.GetItemHeight;
  [-] Removed (var PlainItem: string) from header ItemHTDrawEx;
  [-] Alignment from TJvHTLabel was removed
  [+] SelectedColor, SelectedTextColor from JvMultilineListBox was moved to
      JvHTListBox and JvHTComboBox as ColorHighlight and ColorHighlightText

  2003-09-27
  [-] fixed problem transparent color on JvHTlabel
  [-] fixed problem with layout on JvHTlabel
  [*] when TJvHTlabel is not enabled has pseudo 3D color
  [+] ColorDisabledText (JvHTcombobox, JvHTlistbox) was moved from
      jvmultilinelistbox
  [-] fixed vertical scroll on JvHTlistbox
  [-] minor bugs fixed

  2003-10-04
  [-] JVCL 3.0 compatibility

  2003-10-09
  [-] Removed +1 pixel from each line (place for <hr>) to save compatibility
      with other labels
  [*] reorganized <ALIGN> function
  [+] Added tag &euro; (non-standard but useful)
  [+] Added <A HREF="%s"> </A> for hyper link where %s is linkname
      but work only when alignment is left
  [+] Added to TJvHTLabel: OnHyperLinkClick(Sender; LinkText)
  [+] Added <IND="%d"> where %d is indention from left

  2003-10-11
  [*] fixed <A HREF> with alignment but work only when autosize=True
  [*] fixed probem with autosize when alignment not left
  [+] Added <A HREF> to JvHTListBox but the same problem with hyperlinks
      when alignement is not left (need to rebuild the ItemHTDrawEx draw
      function)
-----------------------------------------------------------------------------}
// $Id: JvHtControls.pas,v 1.47 2005/02/17 10:20:36 marquardt Exp $

unit JvHtControls;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes,
  {$IFDEF MSWINDOWS}
  ShellAPI,
  {$ENDIF MSWINDOWS}
  {$IFDEF VisualCLX}
  Qt,
  {$ENDIF VisualCLX}
  Windows, Messages, Graphics, Controls, StdCtrls, Dialogs,
  JvJVCLUtils, JvExStdCtrls;

type
  THyperLinkClick = procedure(Sender: TObject; LinkName: string) of object;

  TJvCustomHTListBox = class(TJvExCustomListBox)
  private
    FHyperLinkClick: THyperLinkClick;
    FHideSel: Boolean;
    FColorHighlight: TColor;         // <-+-- Kaczkowski: from JvMultiLineListBox
    FColorHighlightText: TColor;     // <-+
    FColorDisabledText: TColor;     // <-+
    procedure SetHideSel(Value: Boolean);
    function GetPlainItems(Index: Integer): string;
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure FontChanged; override;
    {$IFDEF VCL}
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    procedure Loaded; override;
    function DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState): Boolean; override;
    {$ENDIF VisualCLX}
  public
    constructor Create(AOwner: TComponent); override;
    property PlainItems[Index: Integer]: string read GetPlainItems;
  protected
    property HideSel: Boolean read FHideSel write SetHideSel;

    // Kaczkowski - moved from JvMultiLineListBox
    property ColorHighlight: TColor read FColorHighlight write FColorHighlight;
    property ColorHighlightText: TColor read FColorHighlightText write FColorHighlightText;
    property ColorDisabledText: TColor read FColorDisabledText write FColorDisabledText;
    // Kaczkowski - end
    property OnHyperLinkClick: THyperLinkClick read FHyperLinkClick write FHyperLinkClick;
  end;

  TJvHTListBox = class(TJvCustomHTListBox)
  published
    property HideSel;
    property OnHyperLinkClick;

    property Align;
    property BorderStyle;
    property Color;
    // Kaczkowski - moved from JvMultilineListBox
    property ColorHighlight;
    property ColorHighlightText;
    property ColorDisabledText;
    // Kaczkowski - end
    property Columns;
    {$IFDEF VCL}
    property DragCursor;
    property TabWidth;
    property ImeMode;
    property ImeName;
    property AutoSize;
    property BiDiMode;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
   {$ENDIF VCL}
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    //property IntegralHeight;
    //property ItemHeight;
    property Items;
    property MultiSelect;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    //property Style;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    //property OnDrawItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    //property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Anchors;
    property Constraints;
  end;

  TJvCustomHTComboBox = class(TJvExCustomComboBox)
  private
    FHideSel: Boolean;
    FDropWidth: Integer;
    FColorHighlight: TColor;         // <-+-- Kaczkowski: from JvMultilineListBox
    FColorHighlightText: TColor;     // <-+
    FColorDisabledText: TColor;     // <-+
    procedure SetHideSel(Value: Boolean);
    function GetPlainItems(Index: Integer): string;
    procedure SetDropWidth(ADropWidth: Integer);
  protected
    procedure CreateWnd; override;
    {$IFDEF VCL}
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    function DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState): Boolean; override;
    {$ENDIF VisualCLX}
  public
    constructor Create(AOwner: TComponent); override;
    property PlainItems[Index: Integer]: string read GetPlainItems;
    {$IFDEF VCL}
    procedure SetHeight(Value: Integer); // Kaczkowski
    function GetHeight: Integer; // Kaczkowski
    {$ENDIF VCL}
  protected
    property HideSel: Boolean read FHideSel write SetHideSel;
    property DropWidth: Integer read FDropWidth write SetDropWidth;
    // Kaczkowski - based on JvMultilineListBox
    property ColorHighlight: TColor read FColorHighlight write FColorHighlight;
    property ColorHighlightText: TColor read FColorHighlightText write FColorHighlightText;
    property ColorDisabledText: TColor read FColorDisabledText write FColorDisabledText;
    // Kaczkowski - end
  end;

  TJvHTComboBox = class(TJvCustomHTComboBox)
  published
    property Anchors;
    property HideSel;
    property DropWidth;
    // Kaczkowski - based on JvMultilineListBox
    property ColorHighlight;
    property ColorHighlightText;
    property ColorDisabledText;
    property Color;
    // property Style;
    {$IFDEF VCL}
    property AutoSize;
    property DragCursor;
    property ImeMode;
    property ImeName;
    property BiDiMode;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    // property ItemHeight;
    property Items;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    // property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    // property OnMeasureItem;
    property OnStartDrag;
    property Constraints;
  end;

  TJvCustomHTLabel = class(TJvExCustomLabel)
  private
    FHyperLinkClick: THyperLinkClick;
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure FontChanged; override;
    procedure AdjustBounds; {$IFDEF VCL} override; {$ENDIF}
    procedure SetAutoSize(Value: Boolean); override;
    procedure Paint; override;
    procedure Loaded; override;
    {$IFDEF VisualCLX}
    procedure TextChanged; override;  // handles autosize
    {$ENDIF VisualCLX}
    property OnHyperLinkClick: THyperLinkClick read FHyperLinkClick write FHyperLinkClick;
  end;

  TJvHTLabel = class(TJvCustomHTLabel)
  published
    property Align;
    // property Alignment;  // Kaczkowski
    property Anchors;
    property AutoSize;
    property Caption;
    property Color;
    {$IFDEF VCL}
    property DragCursor;
    property BiDiMode;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    // property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Visible;
    // property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Layout;
    property Constraints;
    property OnHyperLinkClick;
  end;

procedure ItemHTDrawEx(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; var Width: Integer;
  CalcType: TJvHTMLCalcType;  MouseX, MouseY: Integer; var MouseOnLink: Boolean;
  var LinkName: string; Scale: Integer = 100);
  { example for Text parameter : 'Item 1 <b>bold</b> <i>italic ITALIC <br><FONT COLOR="clRed">red <FONT COLOR="clgreen">green <FONT COLOR="clblue">blue </i>' }
function ItemHTDraw(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; Scale: Integer = 100): string;
function ItemHTWidth(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; Scale: Integer = 100): Integer;
function ItemHTPlain(const Text: string): string;
function ItemHTHeight(Canvas: TCanvas; const Text: string; Scale: Integer = 100): Integer;
function PrepareText(const A: string): string;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvHtControls.pas,v $';
    Revision: '$Revision: 1.47 $';
    Date: '$Date: 2005/02/17 10:20:36 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Math,
  JvConsts;

const
  cMAILTO = 'MAILTO:';
  cURLTYPE = '://';

function PrepareText(const A: string): string;
begin
  Result := HTMLPrepareText(A);
end;

procedure ItemHTDrawEx(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; var Width: Integer;
  CalcType: TJvHTMLCalcType; MouseX, MouseY: Integer; var MouseOnLink: Boolean;
  var LinkName: string; Scale: Integer = 100);
begin
  HTMLDrawTextEx(Canvas, Rect, State, Text, Width, CalcType, MouseX, MouseY, MouseOnLink, LinkName, Scale);
end;
// Kaczkowski - end

function ItemHTDraw(Canvas: TCanvas; Rect: TRect; const State: TOwnerDrawState;
  const Text: string; Scale: Integer = 100): string;
begin
  HTMLDrawText(Canvas, Rect, State, Text, Scale);
end;

function ItemHTPlain(const Text: string): string; // Kaczkowski: optimised
begin
  Result := HTMLPlainText(Text);
end;

function ItemHTWidth(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; Scale: Integer = 100): Integer;
begin
  Result := HTMLTextWidth(Canvas, Rect, State, Text, Scale);
end;

// Kaczkowski - begin
function ItemHTHeight(Canvas: TCanvas; const Text: string; Scale: Integer = 100): Integer;
begin
  Result := HTMLTextHeight(Canvas, Text, Scale);
end;

function IsHyperLink(Canvas: TCanvas; Rect: TRect; const State: TOwnerDrawState;
  const Text: string; MouseX, MouseY: Integer; var HyperLink: string): Boolean; overload;
var
  W: Integer;
begin
  ItemHTDrawEx(Canvas, Rect, State, Text, W, htmlShow, MouseX, MouseY, Result, HyperLink);
end;

function IsHyperLink(Canvas: TCanvas; Rect: TRect; const Text: string;
  MouseX, MouseY: Integer; var HyperLink: string): Boolean; overload;
var
  W: Integer;
begin
  ItemHTDrawEx(Canvas, Rect, [], Text, W, htmlShow, MouseX, MouseY, Result, HyperLink);
end;

// Kaczkowski - end

//=== { TJvCustomHTListBox } =================================================

constructor TJvCustomHTListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Kaczkowski
  {$IFDEF VCL}
  Style := lbOwnerDrawVariable;
  {$ENDIF VCL}
  FColorHighlight := clHighlight;
  FColorHighlightText := clHighlightText;
  FColorDisabledText := clGrayText;
  // Kaczkowski
end;

{$IFDEF VisualCLX}
procedure TJvCustomHTListBox.Loaded;
begin
  inherited Loaded;
  Style := lbOwnerDrawVariable;
end;
{$ENDIF VisualCLX}

{$IFDEF VCL}
procedure TJvCustomHTListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
{$ENDIF VCL}
{$IFDEF VisualCLX}
function TJvCustomHTListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState): Boolean;
{$ENDIF VisualCLX}
begin
  if odSelected in State then
  begin
   Canvas.Brush.Color := ColorHighlight;
   Canvas.Font.Color  := ColorHighlightText;
  end;
  if not Enabled then
    Canvas.Font.Color := ColorDisabledText;

  Canvas.FillRect(Rect);
  ItemHTDraw(Canvas, Rect, State, Items[Index]);
  {$IFDEF VisualCLX}
  Result := True;
  {$ENDIF VisualCLX}
end;

{$IFDEF VCL}
procedure TJvCustomHTListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Height := ItemHTHeight(Canvas, Items[Index]);
end;
{$ENDIF VCL}

procedure TJvCustomHTListBox.FontChanged;
begin
  inherited FontChanged;
  if not Assigned(Canvas) then
    Exit; // VisualCLX needs this
  Canvas.Font := Font;
  ItemHeight := CanvasMaxTextHeight(Canvas);
end;

procedure TJvCustomHTListBox.SetHideSel(Value: Boolean);
begin
  FHideSel := Value;
  Invalidate;
end;

function TJvCustomHTListBox.GetPlainItems(Index: Integer): string;
begin
  Result := ItemHTPlain(Items[Index]);
end;

procedure TJvCustomHTListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  LinkName: string;
  State: TOwnerDrawState;
  I: Integer;
begin
  inherited MouseMove(Shift,X,Y);
  I := Self.ItemAtPos(Point(X, Y), True);
  if I = -1 then
    Exit;
  R := Self.ItemRect(I);
  State := [];
  if Self.Selected[I] then
  begin
    State := [odSelected];
    Canvas.Font.Color := FColorHighlightText
  end
  else
    Canvas.Font.Color := Font.Color;
  if IsHyperLink(Canvas, R, State, Items[I], X, Y, LinkName) then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;

procedure TJvCustomHTListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  R: TRect;
  LinkName: string;
  State: TOwnerDrawState;
  I: Integer;
begin
  inherited MouseUp(Button,Shift, X, Y);
  I := Self.ItemAtPos(Point(X, Y), True);
  if I <> -1 then
  begin
    R := Self.ItemRect(I);
    State := [];
    if Self.Selected[I] then
    begin
      State := [odSelected];
      Canvas.Font.Color := ColorHighlightText
    end
    else
      Canvas.Font.Color := Font.Color;
    if IsHyperLink(Canvas, R, State, Items[I], X, Y, LinkName) then
    begin
      if (Pos(cURLTYPE, LinkName) > 0) or // ftp:// http:// e2k://
         (Pos(cMAILTO, UpperCase(LinkName)) > 0) then // ex: mailto:name@server.com
        ShellExecute(0, 'open', PChar(LinkName), nil, nil, SW_NORMAL);
      if Assigned(FHyperLinkClick) then
        FHyperLinkClick(Self, LinkName);
    end;
  end;
end;

//=== { TJvCustomHTComboBox } ================================================

constructor TJvCustomHTComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Kaczkowski
  Style := csOwnerDrawVariable;
  FColorHighlight := clHighlight;
  FColorHighlightText := clHighlightText;
  FColorDisabledText := clGrayText;
  // Kaczkowski
end;

{$IFDEF VCL}
procedure TJvCustomHTComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
{$ENDIF VCL}
{$IFDEF VisualCLX}
function TJvCustomHTComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState): Boolean;
{$ENDIF VisualCLX}
begin
  if odSelected in State then
  begin
    Canvas.Brush.Color := ColorHighlight;
    Canvas.Font.Color  := ColorHighlightText;
  end;
  if not Enabled then
    Canvas.Font.Color := ColorDisabledText;

  Canvas.FillRect(Rect);
  Inc(Rect.Left, 2);
  ItemHTDraw(Canvas, Rect, State, Items[Index]);
  {$IFDEF VCL}
//  SendMessage(Self.Handle, CB_SETITEMHEIGHT, Index, ItemHTHeight(Canvas, Items[Index])); // Kaczkowski
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Result := True;
  {$ENDIF VisualCLX}
end;

{$IFDEF VCL}

// Kaczkowski - begin
function TJvCustomHTComboBox.GetHeight: Integer;
begin
  Result := SendMessage(Self.Handle, CB_GETITEMHEIGHT, -1, 0);
end;

procedure TJvCustomHTComboBox.SetHeight(Value: Integer);
begin
  SendMessage(Self.Handle, CB_SETITEMHEIGHT, -1, Value);
end;
// Kaczkowski - end

{$ENDIF VCL}

procedure TJvCustomHTComboBox.SetHideSel(Value: Boolean);
begin
  FHideSel := Value;
  Invalidate;
end;

function TJvCustomHTComboBox.GetPlainItems(Index: Integer): string;
begin
  Result := ItemHTPlain(Items[Index]);
end;

procedure TJvCustomHTComboBox.CreateWnd;
var
  Tmp: Integer;
begin
  inherited CreateWnd;
  if DropWidth = 0 then
    DropWidth := Width
  else
  begin
    Tmp := DropWidth;
    DropWidth := 0;
    DropWidth := Tmp;
  end;
end;

procedure TJvCustomHTComboBox.SetDropWidth(ADropWidth: Integer);
begin
  if FDropWidth <> ADropWidth then
  begin
    FDropWidth := ADropWidth;
    {$IFDEF VCL}
    Perform(CB_SETDROPPEDWIDTH, FDropWidth, 0);
    {$ENDIF VCL}
  end;
end;

//=== { TJvCustomHTLabel } ===================================================

{$IFDEF VisualCLX}

procedure TJvCustomHTLabel.TextChanged;
begin
  if AutoSize then
  begin
    Height := ItemHTHeight(Canvas, Caption);
    Width := ItemHTWidth(Canvas, ClientRect, [], Caption) + 2;
  end;
  Invalidate;
end;

(*
procedure TJvCustomHTLabel.Painting(Sender: QObjectH; EventRegion: QRegionH);
begin
//  TControlCanvas(FCanvas).StartPaint;
  FCanvas.Start;
  try
    QPainter_setClipRegion(FCanvas.Handle, EventRegion);
    Paint;
  finally
  FCanvas.Stop;
//    TControlCanvas(FCanvas).StopPaint;
  end;
end;
*)

{$ENDIF VisualCLX}

procedure TJvCustomHTLabel.FontChanged;
begin
  inherited FontChanged;
  AdjustBounds;
end;

procedure TJvCustomHTLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TJvCustomHTLabel.AdjustBounds;
var
  {$IFDEF VCL}
  DC: HDC;
  {$ENDIF VCL}
  X: Integer;
  Rect: TRect;
  MaxWidth: Integer;
begin
  if not (csReading in ComponentState) and AutoSize then
  begin
    {$IFDEF VisualCLX}
    AdjustSize;
    {$ENDIF VisualCLX}
    Rect := ClientRect;
    {$IFDEF VCL}
    DC := GetDC(HWND_DESKTOP);
    try
      Canvas.Handle := DC;
      Canvas.Font.Assign(Font);
      Rect.Bottom := ItemHTHeight(Canvas, Caption);
      MaxWidth := ItemHTWidth(Canvas, Bounds(0, 0, 0, 0), [], Caption);
    finally
      Canvas.Handle := 0;
      ReleaseDC(HWND_DESKTOP, DC);
    end;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    Canvas.Font.Assign(Font);
    Rect.Bottom := ItemHTHeight(Canvas, Caption);
    MaxWidth := ItemHTWidth(Canvas, Bounds(0, 0, 0, 0), [], Caption) + 2;
    {$ENDIF VisualCLX}
    Rect.Right := Rect.Left + MaxWidth;
    X := Left;
    if Alignment = taRightJustify then
      Inc(X, Width - Rect.Right);
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TJvCustomHTLabel.SetAutoSize(Value: Boolean);
begin
  if AutoSize <> Value then
  begin
    inherited SetAutoSize(Value);
    AdjustBounds;
  end;
end;

procedure TJvCustomHTLabel.Paint;
var
  Rect: TRect;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  if Transparent then
    Canvas.Brush.Style := bsClear
  else
    Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ClientRect);
  Rect := ClientRect;
  case Layout of
    tlTop:
      ;
    tlBottom:
      Rect.Top := Rect.Bottom - ItemHTHeight(Canvas, Caption);
    tlCenter:
      Rect.Top := (Rect.Bottom - Rect.Top - ItemHTHeight(Canvas, Caption)) div 2;
  end;
  Canvas.Font.Style := []; // only font name and font size is important
  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    ItemHTDraw(Canvas, Rect, [odDisabled], Caption);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    ItemHTDraw(Canvas, Rect, [odDisabled], Caption);
  end
  else
    ItemHTDraw(Canvas, Rect, [], Caption);
end;

procedure TJvCustomHTLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  LinkName: string;
begin
  inherited MouseMove(Shift,X,Y);
  R := ClientRect;
  case Layout of
    tlTop:
      ;
    tlBottom:
      R.Top := R.Bottom - ItemHTHeight(Canvas, Caption);
    tlCenter:
      R.Top := (R.Bottom - R.Top - ItemHTHeight(Canvas, Caption)) div 2;
  end;
  if IsHyperLink(Canvas, R, Caption, X, Y, LinkName) then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;

procedure TJvCustomHTLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  R: TRect;
  LinkName: string;
begin
  inherited MouseUp(Button,Shift,X,Y);
  R := ClientRect;
  case Layout of
    tlTop:
      ;
    tlBottom:
      R.Top := R.Bottom - ItemHTHeight(Canvas, Caption);
    tlCenter:
      R.Top := (R.Bottom - R.Top - ItemHTHeight(Canvas, Caption)) div 2;
  end;
  if IsHyperLink(Canvas, R, Caption, X, Y, LinkName) then
  begin
    if (Pos(cURLTYPE, LinkName) > 0) or // ftp:// http:// e2k://
       (Pos(cMAILTO, UpperCase(LinkName)) > 0) then // ex: mailto:name@server.com
      ShellExecute(0, 'open', PChar(LinkName), nil, nil, SW_NORMAL);
    if Assigned(FHyperLinkClick) then
      FHyperLinkClick(Self, LinkName);
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
