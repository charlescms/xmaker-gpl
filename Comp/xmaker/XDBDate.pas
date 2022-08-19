{
   Componente.: XDBDate.pas
   Copyright..: Modular Software - http://www.xmaker.com.br
   Data.......: 28/08/2006
}
unit XDBDate;

interface

{$I XMaker.inc}

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, Mask, DBTables, DB, DBCtrls, Dialogs, ComCtrls, Grids, ExtCtrls,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Buttons, Math;

const
  scF8 = vk_f8;

type
  TRangeCentury = 0..99;
  TXDBDateEdit = class(TMaskEdit)
  private
    FClickKey: TShortCut;
    FAlignment: TAlignment;
    FAssumeDefault: Boolean;
    FAutoHideCalendar: Boolean;
    FBaseChar: Char;
    FButton: TSpeedButton;
    FCanvas: TControlCanvas;
    FCentury: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FGlyph: TBitmap;
    FHintBtn: string;
    FShowButton: Boolean;
    FEnabledPesq: Boolean;
    FWinBack: TWinControl;
    FOverCentury: TRangeCentury;
    FOnBtnClick: TNotifyEvent;
    FOnDateError: TNotifyEvent;
    FHora: Boolean;
    procedure ButtonClick(Sender: TObject);
    procedure ChangeGlyph(Sender: TObject);
    procedure CreateButton;
    procedure DataChange(Sender: TObject);
    procedure DateError;
    procedure DecodeStrDate(Date: string; var Year, Month, Day: Word);
    procedure EditingChange(Sender: TObject);
    procedure SetBaseChar(C: Char);
    procedure SetButtonSize;
    procedure SetCentury(Bool: Boolean);
    procedure SetClientRect;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetEnabledBtn(Value: Boolean);
    function GetEnabledPesq: Boolean;
    procedure SetEnabledPesq(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetHintBtn(Value: string);
    procedure SetReadOnly(Value: Boolean);
    procedure SetShowCaret;
    procedure SetShowButton(const Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Msg: TMessage); message CM_GETDATALINK;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    function AssumeDefaultDate(ADate: string): string;
    function DaysInMonth(Month, Year: Integer): Integer;
    function ExtractInvalidChar(S: string): string;
    function FormatStrDate(S: string): string;
    function GetCursorHeight: Integer;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetDateInStr(S: string): TDateTime;
    function GetDateValue: TDateTime;
    function GetEnabledBtn: Boolean;
    function GetField: TField;
    function GetFormatMask: string;
    function GetMemberDate(S: string; Memb: Integer): string;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    function IsActive: Boolean;
    function IsEmptyDate(S: string): Boolean;
    function IsLeapYear(Year: Word): Boolean;
    function IsValidDate(S: string): Boolean;
    function NoSpaces(S: string): string;
    function Val(S: string): Integer;
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;
    function EditCanModify: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowCalendar;
    property DateValue: TDateTime read GetDateValue;
  published
    property Anchors;
    property AssumeDefault: Boolean read FAssumeDefault write FAssumeDefault default True;
    property AutoHideCalendar: Boolean read FAutoHideCalendar write FAutoHideCalendar default True;
    property AutoSelect;
    property AutoSize;
    property BaseChar: Char read FBaseChar write SetBaseChar default '_';
    property BorderStyle;
    property Century: Boolean read FCentury write SetCentury default True;
    property ClickKey: TShortCut read FClickKey write FClickKey
      default scF8;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EnabledBtn: Boolean read GetEnabledBtn write SetEnabledBtn default True;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property HideSelection;
    property HintBtn: string read FHintBtn write SetHintBtn;
    property OverCentury: TRangeCentury read FOverCentury write FOverCentury default 0;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Pesquisa: Boolean read GetEnabledPesq write SetEnabledPesq default False;
    property PopupMenu;
        // cms compatibilidade
    property Hora: Boolean read FHora write FHora default True;

    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property ShowButton: Boolean read FShowButton write SetShowButton default False;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnBtnClick: TNotifyEvent read FOnBtnClick write FOnBtnClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDateError: TNotifyEvent read FOnDateError write FOnDateError;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TFrmDBDateEdit = class(TForm)
    PanBack: TPanel;
    PanMonth: TPanel;
    StrGrid: TStringGrid;
    UpDownMonth: TUpDown;
    BtnClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure StrGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGridClick(Sender: TObject);
    procedure StrGridDblClick(Sender: TObject);
    procedure StrGridKeyPress(Sender: TObject; var Key: Char);
    procedure UpDownMonthClick(Sender: TObject; Button: TUDBtnType);
    procedure PanMonthMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanMonthMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    FActiveDate: TDate;
    FBackColor: TColor;
    FChangingCel: Boolean;
    FLastX: Integer;
    FLastY: Integer;
    FOnwerEdt: TXDBDateEdit;
    FTextColor: TColor;
    procedure MonthChanged;
    procedure SetColors(TextColor, BackColor: TColor);
    function BeginOfMonth(ADate: TDate): TDate;
    function Month(ADate: TDate): Word;
  end;

var
  FrmDBDateEdit: TFrmDBDateEdit;

procedure Register;

implementation

{$J+}
{$R *.RES}
{$R *.DFM}

const
  EMPTYDATE = -693594;
  IMAGE_RES = 'DBDATEED_CALEN';
  IMAGE_PESQ = 'DBDATEED_PESQ';

type
  TEvBtnDBDateEdit = class(TSpeedButton)
  private
    FCanvas: TControlCanvas;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TEvBtnDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
end;

destructor TEvBtnDBDateEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TEvBtnDBDateEdit.Paint;
var
  R: TRect;
begin
  inherited;
  if FState = bsUp then
    begin
      R := ClientRect;
      Frame3D(FCanvas, R, clBtnHighLight, clWindowFrame, 1);
      Frame3D(FCanvas, R, clBtnFace, clBtnShadow, 1);
    end;
end;

constructor TXDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FAssumeDefault := True;
  FAutoHideCalendar := True;
  FBaseChar := '_';
  FCentury := True;
  FFocused := False;
  FOverCentury := 0;
  FShowButton := False;
  FClickKey := scF8;
  CreateButton;
end;

destructor TXDBDateEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FGlyph.Free;
  FButton.Free;
  FWinBack.Free;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TXDBDateEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_AUTOHSCROLL or ES_MULTILINE or
    Alignments[FAlignment] or WS_CLIPCHILDREN;
end;

procedure TXDBDateEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetClientRect;
end;

procedure TXDBDateEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TXDBDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
  if not fDataLink.ReadOnly and fDataLink.Editing then
  begin
    inherited KeyDown(Key, Shift);
    if (FClickKey = ShortCut(Key, Shift)) then begin
      ButtonClick(Self);
      Key := 0;
    end;
  end;
end;

procedure TXDBDateEdit.KeyPress(var Key: Char);
var
  Form: TCustomForm;
begin
  if Ord(Key) in [VK_ESCAPE, VK_RETURN]  then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
        PostMessage(Form.Handle, CN_KEYDOWN, Ord(Key), 1);
    end
  else if (Key in ['c', 'C']) and FButton.Enabled then
    begin
      FButton.OnClick(FButton);
      Key := #0;
    end
  else if Key = '.' then
    Key := DateSeparator;
  inherited KeyPress(Key);
  if Key in [^H, ^V, ^X, '0'..'9', DateSeparator] then
    FDataLink.Edit
  else if Key = #27 then
    begin
      FDataLink.Reset;
      SelectAll;
      Key := #0;
    end;
end;

function TXDBDateEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TXDBDateEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TXDBDateEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
    begin
      FFocused := Value;
      if (FAlignment <> taLeftJustify) and (not IsMasked) then
        Invalidate;
      FDataLink.Reset;
    end;
end;

procedure TXDBDateEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TXDBDateEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TXDBDateEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

function TXDBDateEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TXDBDateEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TXDBDateEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TXDBDateEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TXDBDateEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TXDBDateEdit.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES)
  else
    FGlyph.Assign(Value);
end;

procedure TXDBDateEdit.ChangeGlyph(Sender: TObject);
var
  NG: Byte;
begin
  FButton.Glyph := FGlyph;
  NG := 1;
  if not FGlyph.Empty then
    if (FGlyph.Width mod FGlyph.Height) = 0 then
      begin
        NG := FGlyph.Width div FGlyph.Height;
        if NG > 4 then
          NG := 1;
      end;
  FButton.NumGlyphs := NG;
end;

function TXDBDateEdit.GetEnabledBtn: Boolean;
begin
  Result := (FButton <> nil) and FButton.Enabled;
end;

procedure TXDBDateEdit.SetEnabledBtn(Value: Boolean);
begin
  if FButton <> nil then
    FButton.Enabled := Value;
end;

function TXDBDateEdit.GetEnabledPesq: Boolean;
begin
  Result := FEnabledPesq;
end;

procedure TXDBDateEdit.SetEnabledPesq(Value: Boolean);
begin
  FEnabledPesq := Value;
  if Value then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_PESQ);
  Invalidate;
end;

procedure TXDBDateEdit.SetHintBtn(Value: string);
begin
  if FHintBtn <> Value then
    begin
      FHintBtn := Value;
      FButton.Hint := Value;
    end;
end;

procedure TXDBDateEdit.SetShowButton(const Value: Boolean);
begin
  FShowButton := Value;
  if not FShowButton then
    begin
      FWinBack.SetBounds(0, 0, 0, 0);
      FButton.SetBounds(0, 0, 0, 0);
      SetClientRect;
    end
  else
    begin
      SetButtonSize;
      SetClientRect;
    end;
  Invalidate;
end;

procedure TXDBDateEdit.DataChange(Sender: TObject);
var
  S: string;
begin
  if (fDataLink.Field = nil) or (FDataLink.Field.asVariant = NULL) then
    Text := ''
  else
  begin
    Text := FDataLink.Field.asString;
  end;
  if Focused and not FDataLink.Editing then
    SelectAll;
end;

procedure TXDBDateEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := (not FDataLink.Editing);
end;

procedure TXDBDateEdit.UpdateData(Sender: TObject);
var
  S: string;
begin
  ValidateEdit;
  S := FormatStrDate(Text);
  if IsEmptyDate(S) then
    FDataLink.Field.Text := ''
  else if (IsValidDate(S) or FAssumeDefault) then
    FDataLink.Field.Text := AssumeDefaultDate(S)
  else
    begin
      DateError;
      Abort;
    end;
end;

procedure TXDBDateEdit.WMPaste(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TXDBDateEdit.WMCut(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TXDBDateEdit.CMEnter(var Msg: TCMEnter);
begin
  SetFocused(True);
  inherited;
  SelectAll;
  Invalidate;
end;

procedure TXDBDateEdit.CMExit(var Msg: TCMExit);
var
  S: string;
begin
  S := FormatStrDate(Text);
  if (not IsValidDate(S)) and (not IsEmptyDate(S)) then
    begin
      if FAssumeDefault then
        Text := AssumeDefaultDate(S)
      else
        begin
          DateError;
          Exit;
        end;
    end
  else
    begin
      if not IsEmptyDate(S) then
        Text := AssumeDefaultDate(S);
    end;
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TXDBDateEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;

procedure TXDBDateEdit.WMPaint(var Msg: TWMPaint);
var
  X: Integer;
  Rect: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  Margins: TPoint;
begin
  SetClientRect;
  FButton.Enabled := (csDesigning in ComponentState) or
    (FDataLink.Field <> nil);
  if FFocused and not (csPaintCopy in ControlState) then
    begin
      inherited;
      Exit;
    end;
  if (csDesigning in ComponentState) and (not IsActive) then
    S := Name
  else if (GetDateInStr(FormatStrDate(Text)) = EMPTYDATE) then
    S := ''
  else
    S := Text;
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
    S := FormatDateTime(GetFormatMask, FDataLink.Field.AsDateTime);
  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    if not Enabled then
      FCanvas.Font.Color := clGrayText;
    SendMessage(Handle, EM_GETRECT, 0, Longint(@Rect));
    if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        FCanvas.Brush.Color := clWindowFrame;
        FCanvas.FrameRect(Rect);
        InflateRect(Rect, -1, -1);
      end;
    FCanvas.Brush.Color := Color;
    Margins := GetTextMargins;
    X := Margins.X;
    case FAlignment of
      taRightJustify: X := Rect.Right - FCanvas.TextWidth(S) - Margins.X;
      taCenter: X := (Rect.Left + Rect.Right - FCanvas.TextWidth(S)) div 2;
    end;
    FCanvas.TextRect(Rect, X, Margins.Y, S);
  finally
    FCanvas.Handle := 0;
    if Msg.DC = 0 then
      EndPaint(Handle, PS);
  end;
end;

procedure TXDBDateEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
  SetButtonSize;
  SetClientRect;
end;

procedure TXDBDateEdit.CMGetDataLink(var Msg: TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;

procedure TXDBDateEdit.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  SetShowCaret;
end;

procedure TXDBDateEdit.SetShowCaret;
begin
  CreateCaret(Handle, 0, 1, GetCursorHeight);
  ShowCaret(Handle);
end;

function TXDBDateEdit.GetCursorHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  Result := Metrics.tmHeight;
end;

procedure TXDBDateEdit.SetCentury(Bool: Boolean);
begin
  FCentury := Bool;
  DataChange(Self);
end;

procedure TXDBDateEdit.SetBaseChar(C: Char);
begin
  if (C <> #0) then
    begin
      FBaseChar := C;
      DataChange(Self);
    end;
end;

function TXDBDateEdit.FormatStrDate(S: string): string;
var
  D, M, Y: Word;
  Day, Month, Year: string;
begin
  S := ExtractInvalidChar(S) + DateSeparator + DateSeparator;
  Day := '00' + GetMemberDate(S, 1);
  Day := Copy(Day, Length(Day) - 1, 2);
  Month := '00' + GetMemberDate(S, 2);
  Month := Copy(Month, Length(Month) - 1, 2);
  Year := GetMemberDate(S, 3);
  if Year = '' then
    Year := '0000';
  DecodeDate(Date, Y, M, D);
  if (FOverCentury > 0) and (StrToInt(Year) > FOverCentury) and
    (Length(Year) < 3) then
    Y := Y - 100;
  Year := Copy(IntToStr(Y), 1, 4 - Length(Year)) + Year;
  Result := Day + DateSeparator + Month + DateSeparator + Year;
end;

function TXDBDateEdit.ExtractInvalidChar(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] in ['0'..'9', DateSeparator] then
      Result := Result + S[I];
end;

function TXDBDateEdit.GetMemberDate(S: string; Memb: Integer): string;
var
  I, F, M: Integer;
begin
  I := 1;
  F := 1;
  M := 0;
  while Memb > M do
    begin
      while (F <= Length(S)) and (S[F] <> DateSeparator) do
        Inc(F);
      Inc(M);
      if Memb > M then
        begin
          Inc(F);
          I := F;
        end;
    end;
  Result := Copy(S, I, F - I);
end;

function TXDBDateEdit.GetFormatMask: string;
begin
  Result := 'dd'+ DateSeparator + 'mm' + DateSeparator + 'yy';
  if FCentury then
    Result := Result + 'yy';
end;

function TXDBDateEdit.GetDateInStr(S: string): TDateTime;
var
  Day, Month, Year: Word;
begin
  if IsEmptyDate(S) then
    Result := EMPTYDATE
  else
    begin
      if not IsValidDate(S) then
        Result := EMPTYDATE
      else
        begin
          DecodeStrDate(S, Year, Month, Day);
          Result := EncodeDate(Year, Month, Day);
        end;
    end;
end;

function TXDBDateEdit.IsValidDate(S: string): Boolean;
var
  Day, Month, Year: Word;
begin
  DecodeStrDate(S, Year, Month, Day);
  if (Day = 0) or (Month = 0) or (Month > 12)
    or (Day > DaysInMonth(Month, Year)) or (Year = 0) then
    Result := False
  else
    Result := True;
end;

function TXDBDateEdit.DaysInMonth(Month, Year: Integer): Integer;
const
  Days = '312831303130313130313031';
begin
  Result := Val(Copy(Days, (Month * 2) -1, 2));
  if (Month = 2) and IsLeapYear(Year) then
    Result := 29;
end;

function TXDBDateEdit.IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function TXDBDateEdit.IsEmptyDate(S: string): Boolean;
var
  I: Integer;
  N: string;
begin
  N := '';
  for I := 1 to Length(S) do
    if S[I] in ['1'..'9'] then
      N := N + S[I];
  if N = '' then
    Result := True
  else
    Result := False;
end;

function TXDBDateEdit.AssumeDefaultDate(ADate: string): string;
var
  AtDay, AtMonth, AtYear: Word;
  Day, Month, Year: Word;
begin
  DecodeStrDate(ADate, Year, Month, Day);
  DecodeDate(Date, AtYear, AtMonth, AtDay);
  if Year = 0 then
    Year := AtYear;
  if Month = 0 then
    Month := AtMonth
  else if Month > 12 then
    Month := 12;
  if Day = 0 then
    Day := AtDay
  else if Day > DaysInMonth(Month, Year) then
    Day := DaysInMonth(Month, Year);
  Result := FormatDateTime(GetFormatMask, EncodeDate(Year, Month, Day))
end;

procedure TXDBDateEdit.DecodeStrDate(Date: string; var Year, Month, Day: Word);
begin
  Day := Val(Copy(Date, 1, 2));
  Month := Val(Copy(Date, 4, 2));
  Year := Val(Copy(Date, 7, 4));
end;

function TXDBDateEdit.Val(S: string): Integer;
begin
  S := NoSpaces(S);
  if S = '' then
    Result := 0
  else
    Result := StrToInt(S);
end;

function TXDBDateEdit.NoSpaces(S: string): string;
var
  I: Integer;
  N: string;
begin
  N := '';
  for I := 1 to Length(S) do
    if S[I] <> ' ' then
      N := N + S[I];
  Result := N;
end;

function TXDBDateEdit.IsActive: Boolean;
var
  DtSrc: TDataSource;
begin
  Result := False;
  DtSrc := GetDataSource;
  if (DtSrc <> nil) and (DtSrc.Dataset <> nil) then
    Result := DtSrc.Dataset.Active
end;

function TXDBDateEdit.GetDateValue: TDateTime;
var
  S: string;
begin
  S := FormatStrDate(Text);
  if (not IsValidDate(S)) or IsEmptyDate(S) then
    Result := EMPTYDATE
  else
    Result := GetDateInStr(S);
end;

procedure TXDBDateEdit.DateError;
begin
  if Assigned(FOnDateError) then
    FOnDateError(Self)
  else
    MessageBeep(0);
  SelectAll;
  SetFocus;
end;

function TXDBDateEdit.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
    begin
      if BorderStyle = bsNone then
        I := 0
      else if Ctl3D then
        I := 1
      else
        I := 2;
      Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
      Result.Y := I;
    end
  else
    begin
      if BorderStyle = bsNone then
        I := 0
      else
        begin
          DC := GetDC(0);
          GetTextMetrics(DC, SysMetrics);
          SaveFont := SelectObject(DC, Font.Handle);
          GetTextMetrics(DC, Metrics);
          SelectObject(DC, SaveFont);
          ReleaseDC(0, DC);
          I := SysMetrics.tmHeight;
          if I > Metrics.tmHeight then
            I := Metrics.tmHeight;
          I := I div 4;
        end;
      Result.X := I;
      Result.Y := I;
    end;
end;

procedure TXDBDateEdit.CreateButton;
begin
  FWinBack := TWinControl.Create(Self);
  FWinBack.Parent := Self;
  TEdit(FWinBack).Color := clBtnFace;
  FButton := TEvBtnDBDateEdit.Create(Self);
  FButton.Parent := FWinBack;
  FButton.OnClick := ButtonClick;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := ChangeGlyph;
  FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES);
end;

procedure TXDBDateEdit.SetClientRect;
var
  Rect: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, Longint(@Rect));
  Rect.Bottom := ClientHeight + 1;
  Rect.Right := ClientWidth - FButton.Width - 2;
  Rect.Top := 0;
  Rect.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Rect));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Rect));
end;

procedure TXDBDateEdit.SetButtonSize;
begin
  if FShowButton then
    begin
      FWinBack.SetBounds(ClientWidth - ClientHeight - 1, 0,
        ClientHeight + 1, ClientHeight);
      FButton.SetBounds(1, 0, ClientHeight, ClientHeight);
    end
  else
    begin
      FWinBack.SetBounds(0, 0, 0, 0);
      FButton.SetBounds(0, 0, 0, 0);
    end;
end;

procedure TXDBDateEdit.ButtonClick(Sender: TObject);
begin
  if FDataLink.ReadOnly = False then
    if Assigned(FOnBtnClick) then
      FOnBtnClick(Self)
    else
      ShowCalendar;
end;

procedure TXDBDateEdit.ShowCalendar;
var
  Pos: TPoint;
begin
  if not FDataLink.DataSource.AutoEdit and not
    (FDataLink.DataSource.State in [dsEdit, dsInsert]) then
    Exit;
  if FrmDBDateEdit = nil then
    Application.CreateForm(TFrmDBDateEdit, FrmDBDateEdit);
  Pos := Point(0, 0);
  Pos := Self.ClientToScreen(Pos);
  if (Pos.X + 179) > Screen.DesktopWidth then
    FrmDBDateEdit.Left := Pos.X - (FrmDBDateEdit.Width - Width) - 2
  else
    FrmDBDateEdit.Left := Pos.X - 2;
  if (Pos.Y + 131) > Screen.DesktopHeight then
    FrmDBDateEdit.Top := Pos.Y - FrmDBDateEdit.Height - 2
  else
    FrmDBDateEdit.Top := Pos.Y + Height - 3;
  FrmDBDateEdit.FOnwerEdt := Self;
  if GetDateValue = EMPTYDATE then
    FrmDBDateEdit.FActiveDate := Date
  else
    FrmDBDateEdit.FActiveDate := GetDateValue;
  FrmDBDateEdit.MonthChanged;
  FrmDBDateEdit.Show;
end;


procedure TFrmDBDateEdit.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FChangingCel := False;
  for I := 0 to 6 do
    StrGrid.Cells[I, 0] := ShortDayNames[I + 1];
end;

procedure TFrmDBDateEdit.FormActivate(Sender: TObject);
begin
  PanMonth.Color := clActiveCaption;
  PanMonth.Font.Color := clCaptionText;
end;

procedure TFrmDBDateEdit.FormDeactivate(Sender: TObject);
begin
  PanMonth.Color := clInactiveCaption;
  PanMonth.Font.Color := clInactiveCaptionText;
  if FOnwerEdt.AutoHideCalendar then
    Close;
end;

procedure TFrmDBDateEdit.SetColors(TextColor, BackColor: TColor);
begin
  FTextColor := TextColor;
  FBackColor := BackColor;
end;

procedure TFrmDBDateEdit.StrGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  X, Y: Integer;
begin
  if gdFixed in State then
    SetColors(clActiveCaption, clBtnFace)
  else if (gdSelected in State) then
    SetColors(clCaptionText, clActiveCaption)
  else
    SetColors(clWindowText, clWindow);
  if not (gdFixed in State ) and
    (Month(Integer(StrGrid.Objects[ACol, ARow])) <> Month(FActiveDate)) then
    SetColors(clGrayText, FBackColor);
  with StrGrid do
    begin
      S := Cells[ACol, ARow];
      X := Rect.Left + ((DefaultColWidth - Canvas.TextWidth(S)) div 2);
      Y := Rect.Top + ((DefaultRowHeight - Canvas.TextHeight(S)) div 2);
      Canvas.Brush.Color := FBackColor;
      Canvas.Font.Color := FTextColor;
      Canvas.TextRect(Rect, X, Y, S);
    end;
end;

function TFrmDBDateEdit.BeginOfMonth(ADate: TDate): TDate;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := EncodeDate(Y, M, 1);
end;

procedure TFrmDBDateEdit.MonthChanged;
var
  I, J, K: Integer;
  X, Y: Byte;
  S: string;
begin
  I := DayOfWeek(BeginOfMonth(FActiveDate));
  J := Trunc(BeginOfMonth(FActiveDate)) - I + 1;
  for K := 0 to 41 do
    begin
      X := K mod 7;
      Y := (K div 7) + 1;
      StrGrid.Cells[X, Y] := FormatDateTime('d', J + K);
      StrGrid.Objects[X, Y] := TObject(J + K);
    end;
  S := FormatDateTime('mmmm/yyyy', FActiveDate);
  S[1] := Char(Ord(S[1]) - 32);
  PanMonth.Caption := S;
  FChangingCel := True;
  K := Trunc(FActiveDate - J);
  StrGrid.Col := K mod 7;
  StrGrid.Row := (K div 7) + 1;
  FChangingCel := False;
end;

function TFrmDBDateEdit.Month(ADate: TDate): Word;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := M;
end;

procedure TFrmDBDateEdit.StrGridClick(Sender: TObject);
var
  I: Integer;
begin
  if not FChangingCel then
    begin
      I := Integer(StrGrid.Objects[StrGrid.Col, StrGrid.Row]);
      if Month(FActiveDate) <> Month(I) then
        begin
          FActiveDate := I;
          MonthChanged;
        end
      else
        FActiveDate := I;
    end;
end;

procedure TFrmDBDateEdit.UpDownMonthClick(Sender: TObject; Button: TUDBtnType);
var
  Y, M, D: Word;
const
  AInc: array[TUDBtnType] of Integer = (1, -1);
  KEY_PRESSED = 128;
begin
  DecodeDate(FActiveDate, Y, M, D);
  if (GetKeyState(VK_SHIFT) and KEY_PRESSED) = KEY_PRESSED then
    Y := Y + AInc[Button]
  else if (GetKeyState(VK_CONTROL) and KEY_PRESSED) = KEY_PRESSED then
    Y := Y + (AInc[Button] * 10)
  else
    begin
      M := M + AInc[Button];
      if M > 12 then
        begin
          M := 1;
          Inc(Y);
        end
      else if M < 1 then
        begin
          M := 12;
          Dec(Y);
        end;
    end;
  D := Min(D, MonthDays[IsLeapYear(Y), M]);
  FActiveDate := EncodeDate(Y, M, D);
  MonthChanged;
end;

procedure TFrmDBDateEdit.PanMonthMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastX := X;
  FLastY := Y;
end;

procedure TFrmDBDateEdit.PanMonthMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    begin
      Left := Left + (X - FLastX);
      Top := Top + (Y - FLastY);
    end;
end;

procedure TFrmDBDateEdit.StrGridDblClick(Sender: TObject);
begin
  FOnwerEdt.FDataLink.Edit;
  FOnwerEdt.SetFocus;
  FOnwerEdt.Text := FormatDateTime(FOnwerEdt.GetFormatMask, FActiveDate);
  FOnwerEdt.SelectAll;
  Close;
end;

procedure TFrmDBDateEdit.StrGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close
  else if Key = Chr(VK_RETURN) then
    StrGridDblClick(Self)
end;

procedure TFrmDBDateEdit.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure Register;
begin
  RegisterComponents('X-Maker', [TXDBDateEdit]);
end;

end.


