{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvListComb.PAS, released on 2002-05-26.

The Initial Developer of the Original Code is Peter Th�rnqvist [peter3 at sourceforge dot net]
Portions created by Peter Th�rnqvist are Copyright (C) 2002 Peter Th�rnqvist.
All Rights Reserved.

This is a merging of the original TJvListBox3 and TJvImageListBox
TJvListBox3 has been renamed TJvImageListBox and the original TJvImageListBox has been moved to \archive

Contributor(s):
S�bastien Buysse [sbuysse att buypin dott com]
Michael Beck [mbeck att bigfoot dott com]
Olivier Sannier [obones att altern dott org]

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Description:
  A unit to allow display of bitmaps in TComboboxes and TListboxes

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvListComb.pas,v 1.43 2005/02/17 10:20:42 marquardt Exp $

unit JvListComb;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages,
  SysUtils, Classes, Graphics, Controls, ExtCtrls, StdCtrls, ImgList,
  {$IFDEF VisualCLX}
  Qt,
  {$ENDIF VisualCLX}
  {$IFDEF VCL}
  JvJCLUtils, JvComboBox,
  {$ENDIF VCL}
  JvComponent, JvExControls, JvExStdCtrls;

type
  TJvButtonColors = (fsLighter, fsLight, fsMedium, fsDark, fsDarker);
  TJvListPropertiesUsed = set of (puFont, puColorHighlight, puColorHighlightText);

const
  AllListPropertiesUsed = [puFont, puColorHighlight, puColorHighlightText];

type
  IJvResetItemHeight = interface
  ['{29F7C34D-F03C-41FE-8423-0388289A505B}']
    procedure ResetItemHeight;
  end;

  TJvImageItems = class;

  TJvImageItem = class(TCollectionItem)
  private
    FOwner: TJvImageItems;
    FImageIndex: Integer;
    FIndent: Integer;
    FListPropertiesUsed: TJvListPropertiesUsed;
    FFont: TFont;
    FColorHighlight: TColor;
    FColorHighlightText: TColor;
    FGlyph: TBitmap;
    FLinkedObject: TObject;
    FNoTextAssign: Boolean;
    procedure SetImageIndex(const Value: Integer);
    procedure SetText(const Value: string);
    procedure SetIndent(const Value: Integer);
    function GetWinControl: TWinControl;
    procedure Change;
    function GetText: string;
    function GetOwnerStrings: TStrings;
    function GetFont: TFont;
    function GetGlyph: TBitmap;
    procedure SetGlyph(const Value: TBitmap);
    procedure SetFont(const Value: TFont);
    function GetColorHighlight: TColor;
    function GetColorHighlightText: TColor;
    procedure SetColorHighlight(const Value: TColor);
    procedure SetColorHighlightText(const Value: TColor);
    function IsColorHighlightTextStored: Boolean;
    function IsColorHighlightStored: Boolean;
  protected
    procedure SetIndex(Value: Integer); override;
    function GetDisplayName: string; override;

    function IsFontStored: Boolean;
    procedure FontChange(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property LinkedObject: TObject read FLinkedObject write FLinkedObject;
  published
    // ListPropertiesUsed must come before properties named the same
    // as in the list or the component will not be created
    // correctly when restored from a DFM stream.
    property ListPropertiesUsed: TJvListPropertiesUsed read FListPropertiesUsed write FListPropertiesUsed default AllListPropertiesUsed;
    property ColorHighlight: TColor read GetColorHighlight write SetColorHighlight stored IsColorHighlightStored default clHighlight ;
    property ColorHighlightText: TColor read GetColorHighlightText write SetColorHighlightText stored IsColorHighlightTextStored default clHighlightText;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored True;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Indent: Integer read FIndent write SetIndent default 2;
    property Text: string read GetText write SetText;
  end;

  TJvImageItems = class(TOwnedCollection)
  private
    FStrings: TStrings;
    function GetItems(Index: Integer): TJvImageItem;
    procedure SetItems(Index: Integer; const Value: TJvImageItem);
    function GetObjects(Index: Integer): TObject;
    procedure SetObjects(Index: Integer; const Value: TObject);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: TJvImageItem; overload;
    function Add(const Text: string): Integer; overload;
    function Insert(Index: Integer): TJvImageItem; overload;
    procedure Insert(Index: Integer; const Text: string); overload;
    procedure Move(CurIndex, NewIndex: Integer);
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TJvImageItem read GetItems write SetItems; default;
    property Objects[Index: Integer]: TObject read GetObjects write SetObjects;
  end;

  {$IFDEF VCL}
  TJvImageComboBox = class(TJvCustomComboBox, IUnknown, IJvResetItemHeight)
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  TJvImageComboBox = class(TCustomComboBox, IUnknown, IJvResetItemHeight)
  {$ENDIF VisualCLX}
  private
    FItems: TJvImageItems;
    FImageList: TCustomImageList;
    FDefaultIndent: Integer;
    FChangeLink: TChangeLink;
    MouseInControl: Boolean;
    FImageWidth: Integer;
    FImageHeight: Integer;
    FColorHighlight: TColor;
    FColorHighlightText: TColor;
    FOnChange: TNotifyEvent;
    FButtonFrame: Boolean;
    FButtonStyle: TJvButtonColors;
    FIndentSelected: Boolean;
    FDroppedWidth: Integer;
    {$IFDEF VCL}
    FCanvas: TControlCanvas;
    function GetCanvas: TCanvas;
    {$ENDIF VCL}
    function GetDroppedWidth: Integer;
    procedure SetDroppedWidth(Value: Integer);
    procedure SetColorHighlight(Value: TColor);
    procedure SetColorHighlightText(Value: TColor);
    procedure SetImageList(Value: TCustomImageList);

    procedure ImageListChange(Sender: TObject);
    procedure SetDefaultIndent(const Value: Integer);
    procedure SetItems(const Value: TJvImageItems); reintroduce;
    procedure SetIndentSelected(const Value: Boolean);
    { IJvResetItemHeight }
    procedure ResetItemHeight;
  protected
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure FontChanged; override;
    procedure EnabledChanged; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$IFDEF VCL}
    procedure RecreateWnd;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure CNDrawItem(var Msg: TWMDrawItem); message CN_DRAWITEM;
    procedure CNCommand(var Msg: TWMCommand); message CN_COMMAND;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    procedure RecreateWidget;
    procedure CreateWidget; override;
    function DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState): Boolean; override;
    procedure MeasureItem(Control: TWinControl; Item: QClxListBoxItemH;
                          var Height, Width: Integer); override;
    procedure SetParent(const AParent: TWidgetControl); override;
    {$ENDIF VisualCLX}

    procedure Change; override;

    function GetImageWidth(Index: Integer): Integer;
    function GetImageHeight(Index: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF VCL}
    property Canvas: TCanvas read GetCanvas;
    {$ENDIF VCL}
    property Text;
  published
    property Align;
    property Color;
    {$IFDEF VCL}
    property DragCursor;
    {$ENDIF VCL}
    property DroppedWidth: Integer read GetDroppedWidth write SetDroppedWidth;
    property DragMode;
    property DropDownCount;
    property ImageHeight: Integer read FImageHeight write FImageHeight;
    property ImageWidth: Integer read FImageWidth write FImageWidth;
    property Items: TJvImageItems read FItems write SetItems;
    property IndentSelected: Boolean read FIndentSelected write SetIndentSelected default False;
    property ItemIndex;
    property DefaultIndent: Integer read FDefaultIndent write SetDefaultIndent default 0;
    property Enabled;
    property ButtonFrame: Boolean read FButtonFrame write FButtonFrame default False;
    property ButtonStyle: TJvButtonColors read FButtonStyle write FButtonStyle;
    property ColorHighlight: TColor read FColorHighlight write SetColorHighlight default clHighlight;
    property ColorHighlightText: TColor read FColorHighlightText write SetColorHighlightText default clHighlightText;
    property Font;
    property Images: TCustomImageList read FImageList write SetImageList;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Tag;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
  end;

  TJvImageListBox = class(TJvExCustomListBox, IUnknown, IJvResetItemHeight)
  private
    FImageList: TCustomImageList;
    FItems: TJvImageItems;
    FChangeLink: TChangeLink;
    FImageWidth: Integer;
    FImageHeight: Integer;
    FAlignment: TAlignment;
    FColorHighlight, FColorHighlightText: TColor;
    FButtonFrame: Boolean;
    FButtonStyle: TJvButtonColors;
    {$IFDEF VCL}
    FCanvas: TControlCanvas;
    function GetCanvas: TCanvas;
    {$ENDIF VCL}
    procedure SetColorHighlight(Value: TColor);
    procedure SetColorHighlightText(Value: TColor);
    procedure SetImageList(Value: TCustomImageList);
    procedure SetAlignment(Value: TAlignment);
    procedure DrawLeftGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
    procedure DrawRightGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
    procedure DrawCenteredGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
    procedure SetItems(const Value: TJvImageItems);
    { IJvResetItemHeight }
    procedure ResetItemHeight;
  protected
    procedure FontChanged; override;
    procedure ImageListChange(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$IFDEF VCL}
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure CNDrawItem(var Msg: TWMDrawItem); message CN_DRAWITEM;
    procedure CNCommand(var Msg: TWMCommand); message CN_COMMAND;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
//    procedure CreateWidget; override;
    function DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState):Boolean ; override;
    procedure MeasureItem(Control: TWinControl; Item: QClxListBoxItemH;
                          var Height, Width: Integer); override;
    procedure SetParent(const AParent: TWidgetControl); override;
    {$ENDIF VisualCLX}
    procedure Resize; override;

    function GetImageWidth(Index: Integer): Integer;
    function GetImageHeight(Index: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF VCL}
    property Canvas: TCanvas read GetCanvas;
    {$ENDIF VCL}
  published
    property Anchors;
    property Align;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property BorderStyle;
    property Color;
    property DragMode;
    {$IFDEF VCL}
    property DragCursor;
    property IntegralHeight;
    {$ENDIF VCL}
    property Enabled;
    property Font;
    property Items: TJvImageItems read FItems write SetItems;
    property ImageHeight: Integer read FImageHeight write FImageHeight;
    property ImageWidth: Integer read FImageWidth write FImageWidth;
    property ButtonFrame: Boolean read FButtonFrame write FButtonFrame default False;
    property ButtonStyle: TJvButtonColors read FButtonStyle write FButtonStyle;
    property ColorHighlight: TColor read FColorHighlight write SetColorHighlight default clHighlight;
    property ColorHighlightText: TColor read FColorHighlightText write SetColorHighlightText default clHighlightText;
    property Images: TCustomImageList read FImageList write SetImageList;
    property MultiSelect;
    property ItemHeight;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Sorted;
    property Tag;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvListComb.pas,v $';
    Revision: '$Revision: 1.43 $';
    Date: '$Date: 2005/02/17 10:20:42 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Math;

type
  TWinControlAccessProtected = class(TWinControl);

{ utility }

{
function DropArrowWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXVSCROLL);
end;
}


function GetItemHeight(Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(HWND_DESKTOP);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(HWND_DESKTOP, DC);
  Result := Metrics.tmHeight;
end;

// (rom) completely rewritten

procedure DrawBtnFrame(Canvas: TCanvas; ButtonStyle: TJvButtonColors; DefColor: TColor; Default: Boolean; R: TRect);
const
  TopStyles: array [TJvButtonColors] of TColor =
    (clBtnHighLight, clBtnHighLight, clBtnHighLight, clBtnFace, clBtnShadow);
  BottomStyles: array [TJvButtonColors] of TColor =
    (clBtnFace, clBtnShadow, cl3DDkShadow, cl3DDkShadow, cl3DDkShadow);
begin
  if Default then
    Frame3D(Canvas, R, DefColor, DefColor, 1)
  else
    Frame3D(Canvas, R, TopStyles[ButtonStyle], BottomStyles[ButtonStyle], 1);
end;

procedure TJvImageItem.Assign(Source: TPersistent);
begin
  if Source is TJvImageItem then
  begin
    if not FNoTextAssign then
      Text := TJvImageItem(Source).Text;
    FImageIndex := TJvImageItem(Source).ImageIndex;
    FIndent := TJvImageItem(Source).Indent;
    FLinkedObject := TJvImageItem(Source).LinkedObject;
    Glyph := TJvImageItem(Source).Glyph;
    FColorHighlight := TJvImageItem(Source).ColorHighlight;
    FColorHighlightText := TJvImageItem(Source).ColorHighlightText;
    if TJvImageItem(Source).FFont <> nil then
      Font := TJvImageItem(Source).Font
    else
      FreeAndNil(FFont);
    ListPropertiesUsed := TJvImageItem(Source).ListPropertiesUsed;
    Change;
  end
  else
    inherited Assign(Source);
end;

//=== { TJvImageItem } =======================================================

constructor TJvImageItem.Create(Collection: TCollection);
begin
  // FGlyph MUST be created before calling inherited or the
  // creation of the item from a stream (DFM for instance)
  // will not work correctly.
  FGlyph := TBitmap.Create;

  inherited Create(Collection);
  FOwner := Collection as TJvImageItems;
  FListPropertiesUsed := AllListPropertiesUsed;
  FFont := nil;
  FColorHighlight := clHighlight;
  FColorHighlightText := clHighlightText;
end;

destructor TJvImageItem.Destroy;
var
  S: TStrings;
begin
  S := GetOwnerStrings;
  // PRY 2002.06.04
  //if (S <> nil) and not (csDestroying in TComponent(FOwner.GetWinControl).ComponentState) then
  if (S <> nil) and not (csDestroying in GetWinControl.ComponentState) then
    S.Delete(Index);

  FFont.Free;
  FGlyph.Free;
  inherited Destroy;
end;

function TJvImageItem.GetDisplayName: string;
begin
  if Text = '' then
    Result := inherited GetDisplayName
  else
    Result := Text;
end;

procedure TJvImageItem.Change;
begin
  if Assigned(FOwner) then
    FOwner.Update(Self);
end;

procedure TJvImageItem.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Change;
  end;
end;

procedure TJvImageItem.SetIndent(const Value: Integer);
begin
  if FIndent <> Value then
  begin
    FIndent := Value;
    Change;
  end;
end;

function TJvImageItem.GetOwnerStrings: TStrings;
begin
  Result := nil;
  if Assigned(FOwner) then
    Result := FOwner.FStrings;
end;

procedure TJvImageItem.SetText(const Value: string);
var
  S: TStrings;
begin
  S := GetOwnerStrings;
  if S <> nil then
  begin
    while S.Count <= Index do
      S.Add('');
    if S[Index] <> Value then
    begin
      S[Index] := Value;
      Change;
    end;
  end;
end;

function TJvImageItem.GetText: string;
var
  S: TStrings;
begin
  Result := '';
  S := GetOwnerStrings;
  if S <> nil then
  begin
    while S.Count <= Index do
      S.Add('');
    Result := S[Index];
  end;
end;

procedure TJvImageItem.SetIndex(Value: Integer);
var
  I: Integer;
  S: TStrings;
begin
  I := Index;
  inherited SetIndex(Value);
  S := GetOwnerStrings;
  if (S <> nil) and (I >= 0) and (Value >= 0) and (I <> Value) then
  begin
    while I >= S.Count do
      S.Add('');
    S.Move(I, Value);
  end;
end;

//=== { TJvImageItems } ======================================================

constructor TJvImageItems.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TJvImageItem);
end;

function TJvImageItems.Add: TJvImageItem;
begin
  Result := TJvImageItem(inherited Add);
  while FStrings.Count < Count do
    FStrings.Add('');
end;

function TJvImageItems.Add(const Text: string): Integer;
var
  Item: TJvImageItem;
begin
  Item := Add;
  Item.Text := Text;
  Result := Item.Index;
end;

function TJvImageItems.Insert(Index: Integer): TJvImageItem;
begin
  Result := TJvImageItem(inherited Insert(Index));;
end;

procedure TJvImageItems.Insert(Index: Integer; const Text: string);
begin
  Insert(Index).Text := Text;
end;

procedure TJvImageItems.Move(CurIndex, NewIndex: Integer);
var
  Item, NewItem: TJvImageItem;
  ItemText: string;
  ItemObject: TObject;
begin
  if NewIndex < 0 then
    NewIndex := 0;
  if NewIndex > Count then
    NewIndex := Count;

  if CurIndex <> NewIndex then
  begin
    BeginUpdate;
    try
      while FStrings.Count < Count do
        FStrings.Add('');
      { Save object data }
      ItemText := FStrings.Strings[CurIndex];
      ItemObject := FStrings.Objects[CurIndex];
      Item := TJvImageItem.Create(nil);
      try
        Item.FNoTextAssign := True;
        Item.Assign(Items[CurIndex]);
        { Delete item }
        Delete(CurIndex);

        { Add new item on NewIndex }
        if NewIndex < Count then
          NewItem := Insert(NewIndex)
        else
          NewItem := Add;
        { restore data except property Text which is linked to FStrings[] }
        NewItem.FNoTextAssign := True;
        try
          NewItem.Assign(Item);
        finally
          NewItem.FNoTextAssign := False;
        end;

        { restore property Text } 
        NewItem.Text := ItemText;
        while FStrings.Count < Count do
          FStrings.Add('');
        FStrings.Objects[NewIndex] := ItemObject;
      finally
        Item.Free;
      end;
    finally
      EndUpdate;
    end;
    Changed;
  end;
end;

procedure TJvImageItems.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TJvImageItems then
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to TJvImageItems(Source).Count - 1 do
        Add.Assign(TJvImageItems(Source)[I]);
    finally
      EndUpdate;
    end;
  end
  else
  if Source is TStrings then
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to TStrings(Source).Count - 1 do
        Add.Text := TStrings(Source)[I];
      if FStrings <> nil then
        FStrings.Assign(Source);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TJvImageItems.GetItems(Index: Integer): TJvImageItem;
begin
  Result := TJvImageItem(inherited Items[Index])
end;

procedure TJvImageItems.SetItems(Index: Integer; const Value: TJvImageItem);
begin
  inherited Items[Index] := Value;
end;

procedure TJvImageItems.Update(Item: TCollectionItem);
var
  W: TPersistent;
  Obj: IJvResetItemHeight;
begin
  if UpdateCount <> 0 then
    Exit;
  inherited Update(Item);
  W := GetOwner;
  if Supports(W, IJvResetItemHeight, Obj) then
    Obj.ResetItemHeight
  else
  if W is TWinControl then
    TWinControl(W).Invalidate;
end;

//=== { TJvImageComboBox } ===================================================

constructor TJvImageComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TJvImageItems.Create(Self);
  FItems.FStrings := inherited Items;
  FImageWidth := 0;
  FImageHeight := 0;
  FImageList := nil;
  FDefaultIndent := 0;
  FButtonFrame := False;
  Style := csOwnerDrawVariable;
  Color := clWindow;
  FColorHighlight := clHighlight;
  FColorHighlightText := clHighlightText;
  {$IFDEF VCL}
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  ResetItemHeight;
  {$ENDIF VCL}
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImageListChange;
end;

destructor TJvImageComboBox.Destroy;
begin
  FItems.Free;
  FChangeLink.Free;
  inherited Destroy;
  {$IFDEF VCL}
  // (rom) destroy Canvas AFTER inherited Destroy
  FCanvas.Free;
  {$ENDIF VCL}
end;

{$IFDEF VCL}
function TJvImageComboBox.GetCanvas: TCanvas;
begin
  Result := FCanvas;
end;
{$ENDIF VCL}

procedure TJvImageComboBox.ImageListChange(Sender: TObject);
begin
  //  Invalidate;
end;

procedure TJvImageComboBox.SetImageList(Value: TCustomImageList);
begin
  if FImageList <> Value then
  begin
    if FImageList <> nil then
      FImageList.UnRegisterChanges(FChangeLink);
    FImageList := Value;

    if FImageList <> nil then
      FImageList.RegisterChanges(FChangeLink);

{    if Assigned(FImageList) then
    begin
      FWidth := FImageList.Width;
      FHeight := FImageList.Height;
    end
    else
    begin
      FWidth := 0;
      FHeight := 0;
    end; }
    {$IFDEF VCL}
    ResetItemHeight;
    RecreateWnd;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    RecreateWidget;
    {$ENDIF VisualCLX}
  end;
end;

{$IFDEF VCL}
procedure TJvImageComboBox.CreateWnd;
begin
  inherited CreateWnd;
  SetDroppedWidth(FDroppedWidth);
end;

procedure TJvImageComboBox.RecreateWnd;
begin
  inherited RecreateWnd;
  SetDroppedWidth(FDroppedWidth);
end;
{$ENDIF VCL}

{$IFDEF VisualCLX}
procedure TJvImageComboBox.CreateWidget;
begin
  inherited CreateWidget;
  SetDroppedWidth(FDroppedWidth);
end;

procedure TJvImageComboBox.RecreateWidget;
begin
  inherited RecreateWidget;
  SetDroppedWidth(FDroppedWidth);
end;
{$ENDIF VisualCLX}




procedure TJvImageComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImageList) then
    FImageList := nil;
end;

{$IFDEF VCL}
procedure TJvImageComboBox.CNDrawItem(var Msg: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  if csDestroying in ComponentState then
    Exit;
  with Msg.DrawItemStruct^ do
  begin
    State := [];
    if (itemState and ODS_CHECKED) <> 0 then
      Include(State, odChecked);
    if (itemState and ODS_COMBOBOXEDIT) <> 0 then
      Include(State, odComboBoxEdit);
    if (itemState and ODS_DEFAULT) <> 0 then
      Include(State, odDefault);
    if (itemState and ODS_DISABLED) <> 0 then
      Include(State, odDisabled);
    if (itemState and ODS_FOCUS) <> 0 then
      Include(State, odFocused);
    if (itemState and ODS_GRAYED) <> 0 then
      Include(State, odGrayed);
    if (itemState and ODS_SELECTED) <> 0 then
      Include(State, odSelected);

    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := FColorHighlight;
      FCanvas.Font.Color := FColorHighlightText;
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TJvImageComboBox.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState);
{$ENDIF VCL}
{$IFDEF VisualCLX}
function TJvImageComboBox.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState): Boolean;
{$ENDIF VisualCLX}
var
  Offset, Tmp: Integer;
  TmpCol: TColor;
  TmpR, OrigR: TRect;
  SavedColor: TColor;
begin
  {$IFDEF VisualCLX}
  Result := True;  // Handled
  {$ENDIF VisualCLX}
  if csDestroying in ComponentState then
    Exit;
  {$IFDEF VisualCLX}
  if odSelected in State then
  begin
    Canvas.Brush.Color := FColorHighlight;
    Canvas.Font.Color := FColorHighlightText;
  end;
  {$ENDIF VisualCLX}
  SavedColor := Canvas.Font.Color;
  Canvas.Font.Assign(Items[Index].Font);

  if odSelected in State then
  begin
    Canvas.Brush.Color := FColorHighlight;
    Canvas.Font.Color := FColorHighlightText;
  end;

  if State <> [] then
    Canvas.Font.Color := SavedColor;
  OrigR := R;
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if not (odComboBoxEdit in State) or IndentSelected then // (p3) don't draw indentation for edit item unless explicitly told to do so
      R.Left := R.Left + Items[Index].Indent;

    if not Items[Index].Glyph.Empty then
    begin
      Offset := ((R.Bottom - R.Top) - GetImageHeight(Index)) div 2;

      Canvas.Draw(R.Left + 2, R.Top + Offset, Items[Index].Glyph);

      if FButtonFrame then
      begin
        TmpR := Rect(R.Left, R.Top, R.Left + FImageList.Width + 4, R.Top + FImageList.Height + 4);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not ((odFocused in State) and
          not (odComboBoxEdit in State)), TmpR);
      end;

      Inc(R.Left, GetImageWidth(Index) + 8);
      OrigR.Left := R.Left;
    end
    else
    if Assigned(FImageList) then
    begin
      Tmp := Items[Index].ImageIndex;
      //      R.Left := R.Left + Items[Index].Indent;
      Offset := ((R.Bottom - R.Top) - GetImageHeight(Index)) div 2;
      {$IFDEF VCL}
      // PRY 2002.06.04
      //FImageList.Draw(FCanvas, R.Left + 2, R.Top + Offset, Tmp, dsTransparent, itImage);
      {$IFDEF COMPILER6_UP}
      FImageList.Draw(Canvas, R.Left + 2, R.Top + Offset, Tmp, dsTransparent, itImage);
      {$ELSE}
      FImageList.Draw(Canvas, R.Left + 2, R.Top + Offset, Tmp);
      {$ENDIF COMPILER6_UP}
      // PRY END
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      FImageList.Draw(Canvas, R.Left + 2, R.Top + Offset, Tmp);
      {$ENDIF VisualCLX}
      if FButtonFrame then
      begin
        TmpR := Rect(R.Left, R.Top, R.Left + FImageList.Width + 4, R.Top + FImageList.Height + 4);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not ((Tmp in [0..FImageList.Count - 1]) and (odFocused in State) and
          not (odComboBoxEdit in State)), TmpR);
      end;
      Inc(R.Left, GetImageWidth(Index) + 8);
      OrigR.Left := R.Left;
    end;

    R.Right := R.Left + TextWidth(Items[Index].Text);
    InflateRect(R, 2, -1);
    if Length(Items[Index].Text) > 0 then
    begin
      Inc(R.Right,2);
      FillRect(R);
      Inc(R.Left, 2);
      DrawText(Canvas, Items[Index].Text, Length(Items[Index].Text), R,
        DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER);
      Dec(R.Left, 2);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(R);
    end
    else
    begin
      FillRect(OrigR);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(OrigR);
    end;
  end;
end;

{$IFDEF VCL}
procedure TJvImageComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Height := Max(GetItemHeight(Font) + 4, GetImageHeight(Index) + (Ord(ButtonFrame) * 4));
//  if Assigned(FImageList) then
//    Height := Max(Height,FImageList.Height);
end;
{$ENDIF VCL}

{$IFDEF VisualCLX}
procedure TJvImageComboBox.MeasureItem(Control: TWinControl; Item: QClxListBoxItemH;
                          var Height, Width: Integer);
begin
  Height := Max(GetItemHeight(Font) + 4, GetImageHeight(Index) + (Ord(ButtonFrame) * 4));
//  Height := GetItemHeight(Font) + 4 ;
//  if Assigned(FImageList) then
//    Height := Max(Height, FImageList.Height + (Ord(ButtonFrame) * 4));
end;

procedure TJvImageComboBox.SetParent(const AParent: TWidgetControl);
begin
  inherited SetParent(AParent);
  ResetItemHeight;
end;
{$ENDIF VisualCLX}

procedure TJvImageComboBox.SetColorHighlight(Value: TColor);
begin
  if FColorHighlight <> Value then
  begin
    FColorHighlight := Value;
    Invalidate;
  end;
end;

procedure TJvImageComboBox.SetColorHighlightText(Value: TColor);
begin
  if FColorHighlightText <> Value then
  begin
    FColorHighlightText := Value;
    Invalidate;
  end;
end;

{$IFDEF VCL}
function TJvImageComboBox.GetDroppedWidth: Integer;
begin
  HandleNeeded;
  Result := SendMessage(Handle, CB_GETDROPPEDWIDTH, 0, 0);
end;

procedure TJvImageComboBox.SetDroppedWidth(Value: Integer);
begin
  HandleNeeded;
  FDroppedWidth := SendMessage(Handle, CB_SETDROPPEDWIDTH, Value, 0);
end;
{$ENDIF VCL}

{$IFDEF VisualCLX}
function TJvImageComboBox.GetDroppedWidth: Integer;
begin
  HandleNeeded;
  Result := QWidget_width(QCombobox_listBox(Handle));
end;

procedure TJvImageComboBox.SetDroppedWidth(Value: Integer);
begin
  HandleNeeded;
  QWidget_setFixedWidth(QCombobox_listBox(Handle), Value);
  FDroppedWidth := GetDroppedWidth;
end;
{$ENDIF VisualCLX}

procedure TJvImageComboBox.FontChanged;
begin
  inherited FontChanged;
  ResetItemHeight;
  {$IFDEF VCL}
  RecreateWnd;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  RecreateWidget;
  {$ENDIF VisualCLX}
end;

procedure TJvImageComboBox.ResetItemHeight;
var
  MaxImageHeight: Integer;
  I: Integer;
begin
  MaxImageHeight := GetImageHeight(-1);
  for I := 0 to FItems.Count-1 do
  begin
    if GetImageHeight(I) > MaxImageHeight then
      MaxImageHeight := GetImageHeight(I);
  end;
  ItemHeight := Max(GetItemHeight(Font) + 4, MaxImageHeight + Ord(ButtonFrame) * 4);
end;

procedure TJvImageComboBox.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{$IFDEF VCL}
procedure TJvImageComboBox.CNCommand(var Msg: TWMCommand);
begin
  inherited;
  case Msg.NotifyCode of
    CBN_SELCHANGE:
      Change;
  end;
end;
{$ENDIF VCL}

procedure TJvImageComboBox.EnabledChanged;
const
  EnableColors: array [Boolean] of TColor = (clBtnFace, clWindow);
begin
  inherited EnabledChanged;
  Color := EnableColors[Enabled];
end;

procedure TJvImageComboBox.MouseEnter(AControl: TControl);
begin
  inherited MouseEnter(AControl);
  MouseInControl := True;
end;

procedure TJvImageComboBox.MouseLeave(AControl: TControl);
begin
  inherited MouseLeave(AControl);
  MouseInControl := False;
end;

procedure TJvImageComboBox.SetDefaultIndent(const Value: Integer);
begin
  if FDefaultIndent <> Value then
  begin
    FDefaultIndent := Value;
    Invalidate;
  end;
end;

procedure TJvImageComboBox.SetItems(const Value: TJvImageItems);
begin
  FItems.Assign(Value);
  FItems.Update(nil);
end;

procedure TJvImageComboBox.SetIndentSelected(const Value: Boolean);
begin
  if FIndentSelected <> Value then
  begin
    FIndentSelected := Value;
    Invalidate;
  end;
end;

function TJvImageComboBox.GetImageWidth(Index: Integer): Integer;
begin
  if (Index > -1) and not Items[Index].Glyph.Empty then
    Result := Items[Index].Glyph.Width
  else
  if Assigned(FImageList) then
    Result := FImageList.Width
  else
    Result := FImageWidth;
end;

function TJvImageComboBox.GetImageHeight(Index: Integer): Integer;
begin
  if (Index > -1) and not Items[Index].Glyph.Empty then
    Result := Items[Index].Glyph.Height
  else
  if Assigned(FImageList) then
    Result := FImageList.Height
  else
    Result := FImageHeight;
end;

//=== { TJvImageListBox } ====================================================

constructor TJvImageListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // ControlStyle := ControlStyle + [csAcceptsControls];
  SetBounds(0, 0, 121, 97);
  FItems := TJvImageItems.Create(Self);
  FItems.FStrings := inherited Items;
  Color := clWindow;
  FColorHighlight := clHighlight;
  FColorHighlightText := clHighlightText;
  FImageWidth := 0;
  FImageHeight := 0;
  FAlignment := taLeftJustify;

  FButtonFrame := False;
  Style := lbOwnerDrawFixed;
  {$IFDEF VCL}
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  ResetItemHeight;
  {$ENDIF VCL}
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImageListChange;
end;

destructor TJvImageListBox.Destroy;
begin
  FItems.Free;
  FChangeLink.Free;
  inherited Destroy;
  {$IFDEF VCL}
  // (rom) destroy Canvas AFTER inherited Destroy
  FCanvas.Free;
  {$ENDIF VCL}
end;

{$IFDEF VCL}
function TJvImageListBox.GetCanvas: TCanvas;
begin
  Result := FCanvas;
end;
{$ENDIF VCL}

procedure TJvImageListBox.ImageListChange;
begin
  //  Invalidate;
end;

procedure TJvImageListBox.SetImageList(Value: TCustomImageList);
begin
  if FImageList <> Value then
  begin
    if FImageList <> nil then
      FImageList.UnRegisterChanges(FChangeLink);
    FImageList := Value;

    if FImageList <> nil then
      FImageList.RegisterChanges(FChangeLink);

{    if Assigned(FImageList) then
    begin
      FWidth := FImageList.Width;
      FHeight := FImageList.Height;
    end
    else
    begin
      FWidth := 0;
      FHeight := 0;
    end;}
    ResetItemHeight;
    {$IFDEF VCL}
    RecreateWnd;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    RecreateWidget;
    {$ENDIF VisualCLX}
  end;
end;

procedure TJvImageListBox.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    ResetItemHeight;
  end;
end;

{$IFDEF VCL}
procedure TJvImageListBox.CreateWnd;
begin
  inherited CreateWnd;
  SetBkMode(FCanvas.Handle, TRANSPARENT);
end;
{$ENDIF VCL}

procedure TJvImageListBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImageList) then
    FImageList := nil;
end;

procedure TJvImageListBox.SetColorHighlight(Value: TColor);
begin
  if FColorHighlight <> Value then
  begin
    FColorHighlight := Value;
    Invalidate;
  end;
end;

procedure TJvImageListBox.SetColorHighlightText(Value: TColor);
begin
  if FColorHighlightText <> Value then
  begin
    FColorHighlightText := Value;
    Invalidate;
  end;
end;

{$IFDEF VCL}
procedure TJvImageListBox.CNDrawItem(var Msg: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  if csDestroying in ComponentState then
    Exit;
  with Msg.DrawItemStruct^ do
  begin
    State := [];
    if (itemState and ODS_CHECKED) <> 0 then
      Include(State, odChecked);
    if (itemState and ODS_COMBOBOXEDIT) <> 0 then
      Include(State, odComboBoxEdit);
    if (itemState and ODS_DEFAULT) <> 0 then
      Include(State, odDefault);
    if (itemState and ODS_DISABLED) <> 0 then
      Include(State, odDisabled);
    if (itemState and ODS_FOCUS) <> 0 then
      Include(State, odFocused);
    if (itemState and ODS_GRAYED) <> 0 then
      Include(State, odGrayed);
    if (itemState and ODS_SELECTED) <> 0 then
      Include(State, odSelected);
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;

    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := Items[Integer(itemID)].ColorHighlight;
      FCanvas.Font.Color := Items[Integer(itemID)].ColorHighlightText;
    end;

    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TJvImageListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ENDIF VCL}
{$IFDEF VisualCLX}
function TJvImageListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState): Boolean;
{$ENDIF VisualCLX}
var
  SavedColor: TColor;
begin
  {$IFDEF VisualCLX}
  Result := True;
  {$ENDIF VisualCLX}
  if csDestroying in ComponentState then
    Exit;
  {$IFDEF VisualCLX}
  if odSelected in State then
  begin
    Canvas.Brush.Color := Items[Index].ColorHighlight;
    Canvas.Font.Color := Items[Index].ColorHighlightText;
  end;
  {$ENDIF VisualCLX}
  SavedColor := Canvas.Font.Color;
  Canvas.Font.Assign(Items[Index].Font);
  if State <> [] then
    Canvas.Font.Color := SavedColor;
  case FAlignment of
    taLeftJustify:
      DrawLeftGlyph(Index, Rect, State);
    taRightJustify:
      DrawRightGlyph(Index, Rect, State);
    taCenter:
      DrawCenteredGlyph(Index, Rect, State);
  end;
end;

procedure TJvImageListBox.DrawCenteredGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
var
  Tmp, Tmp2: Integer;
  TmpCol: TColor;
  TmpR, OrigR: TRect;
begin
  if csDestroying in ComponentState then
    Exit;
  OrigR := R;
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if not Items[Index].Glyph.Empty then
    begin
      Tmp := ((R.Right - R.Left) - GetImageWidth(Index)) div 2;

      Draw(R.Left + Tmp, R.Top + 2, Items[Index].Glyph);

      if FButtonFrame then
      begin
        TmpR := Rect(R.Left + Tmp - 2, R.Top + 2, R.Left + Tmp + FImageList.Width + 2, R.Top + FImageList.Height + 2);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not (odSelected in State), TmpR);
      end;
      InflateRect(R, 1, -4);
    end
    else
    if Assigned(FImageList) then
    begin
      Tmp := ((R.Right - R.Left) - GetImageWidth(Index)) div 2;
      Tmp2 := Items[Index].ImageIndex;
      {$IFDEF VCL}
      // PRY 2002.06.04
      //FImageList.Draw(FCanvas, R.Left + Tmp, R.Top + 2, Tmp2, dsTransparent, itImage);
      {$IFDEF COMPILER6_UP}
      FImageList.Draw(Canvas, R.Left + Tmp, R.Top + 2, Tmp2, dsTransparent, itImage);
      {$ELSE}
      FImageList.Draw(Canvas, R.Left + Tmp, R.Top + 2, Tmp2);
      {$ENDIF COMPILER6_UP}
      // PRY END
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      FImageList.Draw(Canvas, R.Left + Tmp, R.Top + 2, Tmp2);
      {$ENDIF VisualCLX}
      if FButtonFrame then
      begin
        TmpR := Rect(R.Left + Tmp - 2, R.Top + 2, R.Left + Tmp + FImageList.Width + 2, R.Top + FImageList.Height + 2);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not ((Tmp2 in [0..FImageList.Count - 1]) and (odSelected in State)), TmpR);
      end;
      InflateRect(R, 1, -4);
    end;
    R.Left := ((R.Right - R.Left) - TextWidth(Items[Index].Text)) div 2 - 1;
    R.Right := R.Left + TextWidth(Items[Index].Text) + 1;
    R.Top := R.Bottom - TextHeight(Items[Index].Text) - 1;
    if Length(Items[Index].Text) > 0 then
    begin
      FillRect(R);
      DrawText(Canvas, Items[Index].Text, Length(Items[Index].Text), R,
        DT_SINGLELINE or DT_NOPREFIX or DT_CENTER or DT_BOTTOM);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(R);
    end
    else
    begin
      FillRect(OrigR);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(OrigR);
    end;
  end;
end;

procedure TJvImageListBox.DrawLeftGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
var
  Offset, Tmp: Integer;
  TmpCol: TColor;
  TmpR, OrigR: TRect;
begin
  if csDestroying in ComponentState then
    Exit;
  OrigR := R;
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if not Items[Index].Glyph.Empty then
    begin
      Offset := ((R.Bottom - R.Top) - GetImageHeight(Index)) div 2;

      Draw(R.Left + 2, R.Top + Offset, Items[Index].Glyph);

      if FButtonFrame then
      begin
        TmpR := Rect(R.Left, R.Top, R.Left + FImageList.Width + 4, R.Top + FImageList.Height + 4);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not (odSelected in State), TmpR);
      end;

      Inc(R.Left, GetImageWidth(Index) + 8);
      OrigR.Left := R.Left;
    end
    else
    if Assigned(FImageList) then
    begin
      Offset := ((R.Bottom - R.Top) - GetImageHeight(Index)) div 2;
      Tmp := Items[Index].ImageIndex;
      {$IFDEF VCL}
      // PRY 2002.06.04
      //FImageList.Draw(FCanvas, R.Left + 2, R.Top + Offset, Tmp, dsTransparent, itImage);
      {$IFDEF COMPILER6_UP}
      FImageList.Draw(Canvas, R.Left + 2, R.Top + Offset, Tmp, dsTransparent, itImage);
      {$ELSE}
      FImageList.Draw(Canvas, R.Left + 2, R.Top + Offset, Tmp);
      {$ENDIF COMPILER6_UP}
      // PRY END
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      FImageList.Draw(Canvas, R.Left + 2, R.Top + Offset, Tmp);
      {$ENDIF VisualCLX}
      if FButtonFrame then
      begin
        TmpR := Rect(R.Left, R.Top, R.Left + FImageList.Width + 4, R.Top + FImageList.Height + 4);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not ((Tmp in [0..FImageList.Count - 1]) and (odSelected in State)), TmpR);
      end;
      Inc(R.Left, GetImageWidth(Index) + 8);
      OrigR.Left := R.Left;
    end;

    R.Right := R.Left + TextWidth(Items[Index].Text);
    InflateRect(R, 2, -1);
    if Length(Items[Index].Text) > 0 then
    begin
      Inc(R.Right, 2);
      FillRect(R);
      Inc(R.Left, 2);
      DrawText(Canvas, Items[Index].Text, Length(Items[Index].Text), R,
        DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER);
      Dec(R.Left, 2);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(R);
    end
    else
    begin
      FillRect(OrigR);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(OrigR);
    end;
  end;
end;

procedure TJvImageListBox.DrawRightGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
var
  Offset, Tmp: Integer;
  TmpCol: TColor;
  TmpR, OrigR: TRect;
begin
  if csDestroying in ComponentState then
    Exit;
  OrigR := R;
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if not Items[Index].Glyph.Empty then
    begin
      Offset := ((R.Bottom - R.Top) - GetImageHeight(Index)) div 2;

      Draw(R.Right - (GetImageWidth(Index) + 2), R.Top + Offset, Items[Index].Glyph);

      if FButtonFrame then
      begin
        TmpR := Rect(R.Right - (FImageList.Width + 2) - 2, R.Top + Offset - 2, R.Right - 2, R.Top + Offset + FImageList.Height + 2);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not (odSelected in State), TmpR);
      end;

      Dec(R.Right, FImageList.Width + 4);
      OrigR.Right := R.Right;
    end
    else
    if Assigned(FImageList) then
    begin
      Tmp := Items[Index].ImageIndex;

      Offset := ((R.Bottom - R.Top) - GetImageHeight(Index)) div 2;
      {$IFDEF VCL}
      // PRY 2002.06.04
      //FImageList.Draw(FCanvas, R.Right - (FWidth + 2), R.Top + Offset, Tmp, dsTransparent, itImage);
      {$IFDEF COMPILER6_UP}
      FImageList.Draw(Canvas, R.Right - (GetImageWidth(Index) + 2), R.Top + Offset, Tmp, dsTransparent, itImage);
      {$ELSE}
      FImageList.Draw(Canvas, R.Right - (GetImageWidth(Index) + 2), R.Top + Offset, Tmp);
      {$ENDIF COMPILER6_UP}
      // PRY END
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      FImageList.Draw(Canvas, R.Right - (GetImageWidth(Index) + 2), R.Top + Offset, Tmp);
      {$ENDIF VisualCLX}
      if FButtonFrame then
      begin
        TmpR := Rect(R.Right - (FImageList.Width + 2) - 2, R.Top + Offset - 2, R.Right - 2, R.Top + Offset + FImageList.Height + 2);
        DrawBtnFrame(Canvas, FButtonStyle, Color, not ((Tmp in [0..FImageList.Count - 1]) and (odSelected in State)), TmpR);
      end;
      Dec(R.Right, FImageList.Width + 4);
      OrigR.Right := R.Right;
    end;

    R.Left := R.Right - TextWidth(Items[Index].Text);
    //    R.Right := R.Left + TextWidth(Items[Index].Text);
    InflateRect(R, 2, -1);
    if Length(Items[Index].Text) > 0 then
    begin
      Dec(R.Right, 2);
      FillRect(R);
      DrawText(Canvas, Items[Index].Text, Length(Items[Index].Text), R,
        DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER or DT_RIGHT);
      Inc(R.Right, 2);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(R);
    end
    else
    begin
      FillRect(OrigR);
      if (odSelected in State) and (Color <> FColorHighlight) then
        DrawFocusRect(OrigR);
    end;
  end;
end;

{$IFDEF VCL}
procedure TJvImageListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Height := Max(GetItemHeight(Font) + 4, GetImageHeight(Index) + Ord(ButtonFrame) * 4);
end;
{$ENDIF VCL}

{$IFDEF VisualCLX}

procedure TJvImageListBox.MeasureItem(Control: TWinControl; Item: QClxListBoxItemH;
                          var Height, Width: Integer);
begin
  Height := Max(GetItemHeight(Font) + 4, GetImageHeight(Index) + Ord(ButtonFrame) * 4);
end;

procedure TJvImageListBox.SetParent(const AParent: TWidgetControl);
begin
  inherited SetParent(AParent);
  ResetItemHeight;
end;


{$ENDIF VisualCLX}

procedure TJvImageListBox.FontChanged;
begin
  inherited FontChanged;
  ResetItemHeight;
  {$IFDEF VCL}
  RecreateWnd;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  RecreateWidget;
  {$ENDIF VisualCLX}
end;

procedure TJvImageListBox.ResetItemHeight;
var
  MaxImageHeight: Integer;
  I: Integer;
begin
  MaxImageHeight := GetImageHeight(-1);
  for I := 0 to FItems.Count - 1 do
  begin
    if GetImageHeight(I) > MaxImageHeight then
      MaxImageHeight := GetImageHeight(I);
  end;
  case FAlignment of
    taLeftJustify, taRightJustify:
      ItemHeight := Max(ItemHeight, Max(GetItemHeight(Font) + 4, MaxImageHeight + Ord(ButtonFrame) * 4));
    taCenter:
      ItemHeight := Max(ItemHeight, Max(GetItemHeight(Font) + 4, MaxImageHeight + Ord(ButtonFrame) * 8));
  end;
  Invalidate;
end;

{$IFDEF VCL}
procedure TJvImageListBox.CNCommand(var Msg: TWMCommand);
begin
  inherited;
  case Msg.NotifyCode of
    LBN_SELCHANGE:
      begin
        inherited Changed;
        Click;
      end;
  end;
end;
{$ENDIF VCL}

procedure TJvImageListBox.Resize;
begin
  inherited Resize;
  Invalidate;
end;

procedure TJvImageListBox.SetItems(const Value: TJvImageItems);
begin
  FItems.Assign(Value);
  FItems.Update(nil);
end;

function TJvImageListBox.GetImageWidth(Index: Integer): Integer;
begin
  if (Index > -1) and not Items[Index].Glyph.Empty then
    Result := Items[Index].Glyph.Width
  else
  if Assigned(FImageList) then
    Result := FImageList.Width
  else
    Result := FImageWidth;
end;

function TJvImageListBox.GetImageHeight(Index: Integer): Integer;
begin
  if (Index > -1) and not Items[Index].Glyph.Empty then
    Result := Items[Index].Glyph.Height
  else
  if Assigned(FImageList) then
    Result := FImageList.Height
  else
    Result := FImageHeight;
end;

procedure TJvImageItem.SetFont(const Value: TFont);
begin
  if not (puFont in FListPropertiesUsed) then
    Font.Assign(Value);
end;

function TJvImageItem.GetFont: TFont;
begin
  if puFont in FListPropertiesUsed then
  begin
    Result := TWinControlAccessProtected(GetWinControl).Font
  end
  else
  begin
    if not Assigned(FFont) then
    begin
      FFont := TFont.Create;
      FFont.OnChange := FontChange;
      FFont.Assign(TWinControlAccessProtected(GetWinControl).Font);
    end;
    Result := FFont;
  end;
end;

function TJvImageItem.GetGlyph: TBitmap;
begin
  Result := FGlyph;
end;

procedure TJvImageItem.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  if FOwner <> nil then
    GetWinControl.Invalidate;
end;

procedure TJvImageItem.FontChange(Sender: TObject);
begin
  if not (puFont in FListPropertiesUsed) then
    if FOwner <> nil then
      GetWinControl.Invalidate;
end;

function TJvImageItems.GetObjects(Index: Integer): TObject;
begin
  Result := Items[Index].LinkedObject;
end;

procedure TJvImageItems.SetObjects(Index: Integer; const Value: TObject);
begin
  Items[Index].LinkedObject := Value;
end;

function TJvImageItem.GetWinControl: TWinControl;
begin
  Result := TWinControl(TJvImageItems(Collection).GetOwner);
end;

function TJvImageItem.GetColorHighlight: TColor;
begin
  if (puColorHighlight in FListPropertiesUsed) and (FOwner <> nil) then
  begin
    if GetWinControl is TJvImageListBox then
      Result := TJvImageListBox(GetWinControl).ColorHighlight
    else
      Result := TJvImageComboBox(GetWinControl).ColorHighlight;
  end
  else
    Result := FColorHighlight;
end;

function TJvImageItem.GetColorHighlightText: TColor;
begin
  if (puColorHighlightText in FListPropertiesUsed) and (FOwner <> nil) then
  begin
    if GetWinControl is TJvImageListBox then
      Result := TJvImageListBox(GetWinControl).ColorHighlightText
    else
      Result := TJvImageComboBox(GetWinControl).ColorHighlightText;
  end
  else
    Result := FColorHighlightText;
end;

procedure TJvImageItem.SetColorHighlight(const Value: TColor);
begin
  if (puColorHighlight in FListPropertiesUsed) and (FOwner <> nil) then
  begin
    if GetWinControl is TJvImageListBox then
      TJvImageListBox(GetWinControl).ColorHighlight := Value
    else
      TJvImageComboBox(GetWinControl).ColorHighlight := Value;
  end
  else
    FColorHighlight := Value;
end;

procedure TJvImageItem.SetColorHighlightText(const Value: TColor);
begin
  if (puColorHighlightText in FListPropertiesUsed) and (FOwner <> nil) then
  begin
    if GetWinControl is TJvImageListBox then
      TJvImageListBox(GetWinControl).ColorHighlightText := Value
    else
      TJvImageComboBox(GetWinControl).ColorHighlightText := Value
  end
  else
    FColorHighlightText := Value;
end;

function TJvImageItem.IsColorHighlightTextStored: Boolean;
begin
  Result := not (puColorHighlightText in FListPropertiesUsed);
end;

function TJvImageItem.IsFontStored: Boolean;
begin
  Result := not (puFont in FListPropertiesUsed);
end;

function TJvImageItem.IsColorHighlightStored: Boolean;
begin
  Result := not (puColorHighlight in FListPropertiesUsed);
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

