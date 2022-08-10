{
   Componente.: XDBNum.pas
   Copyright..: Modular Software - http://www.xmaker.com.br
   Data.......: 01/10/2003
}
unit XDBNum;

interface

{$I XMaker.inc}

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, DB, DBTables, Mask, DBCtrls, Dialogs, Buttons, ExtCtrls, Clipbrd;

const
  scF8 = vk_f8;

type
  TXDBNumEdit = class(TCustomMaskEdit)
  private
    FClickKey: TShortCut;
    FAlignment: TAlignment;
    FAutoHideCalculator: Boolean;
    FButton: TSpeedButton;
    FCanvas: TControlCanvas;
    FDataLink: TFieldDataLink;
    FDecimals: Byte;
    FZeroLength: Byte;
    FEnabledBtn: Boolean;
    FEnabledPesq: Boolean;
    FFocused: Boolean;
    FGlyph: TBitmap;
    FHintBtn: string;
    FKey: Char;
    FMaxValue: Extended;
    FMinValue: Extended;
    FShowButton: Boolean;
    FShowSeparator: Boolean;
    FWinBack: TWinControl;
    FOnBtnClick: TNotifyEvent;
    FOnOutOfRange: TNotifyEvent;
    procedure ButtonClick(Sender: TObject);
    procedure ChangeGlyph(Sender: TObject);
    procedure CheckLimitText;
    procedure CreateButton;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure EvalDecSeparator;
    procedure EvaluateKey;
    procedure InvertValue;
    procedure SetButtonSize;
    procedure SetClientRect;
    procedure SetZeroLength(Value: Byte);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetDecimals(Dec: Byte);
    procedure SetEnabledBtn(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetHintBtn(Value: string);
    procedure SetReadOnly(Value: Boolean);
    procedure SetShowButton(const Value: Boolean);
    procedure SetShowCaret;
    procedure SetShowSeparator(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure ValidateKey;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Msg: TMessage); message CM_GETDATALINK;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    function CheckRange: Boolean;
    function GetCursorHeight: Integer;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetEnabledBtn: Boolean;
    procedure SetEnabledPesq(Value: Boolean);
    function GetEnabledPesq: Boolean;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    function GetValue: Extended;
    function IsActive: Boolean;
    function StrToValue(S: string): Extended;
    function StrZero(Number: string; Len: Integer): string;
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
    procedure ShowCalculator;
    property Field: TField read GetField;
    property Value: Extended read GetValue;
  published
    property Anchors;
    property AutoHideCalculator: Boolean read FAutoHideCalculator write FAutoHideCalculator default True;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property ClickKey: TShortCut read FClickKey write FClickKey
      default scF8;
    property Color;
    property Ctl3D;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Decimals: Byte read FDecimals write SetDecimals default 2;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EnabledBtn: Boolean read GetEnabledBtn write SetEnabledBtn default False;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property HideSelection;
    property HintBtn: string read FHintBtn write SetHintBtn;
    property MaxLength;
    property MaxValue: Extended read FMaxValue write FMaxValue;
    property MinValue: Extended read FMinValue write FMinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Pesquisa: Boolean read GetEnabledPesq write SetEnabledPesq default False;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property ShowButton: Boolean read FShowButton write SetShowButton default False;
    property ShowSeparator: Boolean read FShowSeparator write SetShowSeparator default True;
    property TabOrder;
    property TabStop;
    property Visible;
    property ZeroLength: Byte read FZeroLength write SetZeroLength default 0;
    property OnBtnClick: TNotifyEvent read FOnBtnClick write FOnBtnClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
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
    property OnOutOfRange: TNotifyEvent read FOnOutOfRange write FOnOutOfRange;
    property OnStartDock;
    property OnStartDrag;
  end;

  TFrmXDBNumEdit = class(TForm)
    Btn0: TSpeedButton;
    Btn1: TSpeedButton;
    Btn2: TSpeedButton;
    Btn3: TSpeedButton;
    Btn4: TSpeedButton;
    Btn5: TSpeedButton;
    Btn6: TSpeedButton;
    Btn7: TSpeedButton;
    Btn8: TSpeedButton;
    Btn9: TSpeedButton;
    BtnSep: TSpeedButton;
    BtnAdd: TSpeedButton;
    BtnSub: TSpeedButton;
    BtnDiv: TSpeedButton;
    BtnMult: TSpeedButton;
    BtnPerc: TSpeedButton;
    BtnC: TSpeedButton;
    BtnCE: TSpeedButton;
    BtnRes: TSpeedButton;
    BtnSgn: TSpeedButton;
    BtnCancel: TSpeedButton;
    BtnOK: TSpeedButton;
    PanBack: TPanel;
    PanDisplay: TPanel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnNumClick(Sender: TObject);
    procedure BtnCEClick(Sender: TObject);
    procedure BtnCClick(Sender: TObject);
    procedure BtnBaseOpClick(Sender: TObject);
    procedure BtnResClick(Sender: TObject);
    procedure BtnSgnClick(Sender: TObject);
    procedure BtnPercClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure PanMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    FEnterChanged: Boolean;
    FLastEnter: string;
    FLastX: Integer;
    FLastY: Integer;
    FOnwerEdt: TXDBNumEdit;
    FOperator: Char;
    FValBuffer: Double;
    procedure CalcOperation;
    procedure EvalKey(Key: Char);
    procedure ResetCalc;
    procedure SendKeyToDiplay(Key: Char);
    procedure ShowResult;
    function GetDisplayValue: Double;
  end;

var
  FrmXDBNumEdit: TFrmXDBNumEdit;

procedure Register;

implementation

{$J+}
{$R *.RES}
{$R *.DFM}

const
  IMAGE_RES = 'DBNUMED_CALC';
  IMAGE_PESQ = 'DBNUMED_PESQ';

type
  TEvBtnDBNumEdit = class(TSpeedButton)
  private
    FCanvas: TControlCanvas;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TEvBtnDBNumEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
end;

destructor TEvBtnDBNumEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TEvBtnDBNumEdit.Paint;
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

constructor TXDBNumEdit.Create(AOwner: TComponent);
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
  FDecimals := 2;
  FZeroLength := 0;
  FShowSeparator := True;
  FShowButton := False;
  FClickKey := scF8;
  CreateButton;
end;

destructor TXDBNumEdit.Destroy;
begin
  FGlyph.Free;
  FButton.Free;
  FWinBack.Free;
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TXDBNumEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_AUTOHSCROLL or ES_MULTILINE or
    Alignments[FAlignment] or WS_CLIPCHILDREN;
end;

procedure TXDBNumEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetClientRect;
end;

procedure TXDBNumEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TXDBNumEdit.SetZeroLength(Value: Byte);
begin
  if FZeroLength <> Value then
    begin
      FZeroLength := Value;
      Invalidate;
    end;
end;

procedure TXDBNumEdit.KeyDown(var Key: Word; Shift: TShiftState);
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

procedure TXDBNumEdit.KeyPress(var Key: Char);
var
  Form: TCustomForm;
begin
  if Ord(Key) in [VK_ESCAPE, VK_RETURN]  then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
        PostMessage(Form.Handle, CN_KEYDOWN, Ord(Key), 1);
    end;
  inherited KeyPress(Key);
  if (Key in ['c', 'C']) and FButton.Enabled then
    begin
      FButton.OnClick(FButton);
      Key := #0;
    end
  else
    begin
      FKey := Key;
      CheckLimitText;
      if FKey <> #0 then
        ValidateKey;
      if FKey = '-' then
        InvertValue;
      if FKey = DecimalSeparator then
        EvalDecSeparator;
      if FKey <> #0 then
        EvaluateKey;
      Key := FKey;
    end;
end;

function TXDBNumEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TXDBNumEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TXDBNumEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
    begin
      FFocused := Value;
      if (FAlignment <> taLeftJustify) and not IsMasked then
        Invalidate;
      FDataLink.Reset;
    end;
end;

procedure TXDBNumEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TXDBNumEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TXDBNumEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

function TXDBNumEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TXDBNumEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TXDBNumEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TXDBNumEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TXDBNumEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TXDBNumEdit.SetShowSeparator(Value: Boolean);
begin
  if FShowSeparator <> Value then
    begin
      FShowSeparator := Value;
      Invalidate;
    end;
end;

procedure TXDBNumEdit.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES)
  else
    FGlyph.Assign(Value);
end;

procedure TXDBNumEdit.ChangeGlyph(Sender: TObject);
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

function TXDBNumEdit.GetEnabledBtn: Boolean;
begin
  Result := FEnabledBtn;
end;

function TXDBNumEdit.GetEnabledPesq: Boolean;
begin
  Result := FEnabledPesq;
end;

procedure TXDBNumEdit.SetEnabledPesq(Value: Boolean);
begin
  FEnabledPesq := Value;
  if Value then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_PESQ);
  Invalidate;
end;

procedure TXDBNumEdit.SetEnabledBtn(Value: Boolean);
begin
  FEnabledBtn := Value;
  Invalidate;
end;

procedure TXDBNumEdit.SetHintBtn(Value: string);
begin
  if FHintBtn <> Value then
    begin
      FHintBtn := Value;
      FButton.Hint := Value;
    end;
end;

procedure TXDBNumEdit.SetShowButton(const Value: Boolean);
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

procedure TXDBNumEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    begin
      if FAlignment <> FDataLink.Field.Alignment then
        begin
          EditText := '';
          FAlignment := FDataLink.Field.Alignment;
          RecreateWnd;
          if Focused then
            PostMessage(Handle, WM_SETFOCUS, 0, 0);
        end;
      if FFocused and FDataLink.CanModify then
      begin
        if FZeroLength > 0 then
          Text := StrZero(FloatToStr(FDataLink.Field.AsFloat), FZeroLength)
        else
          Text := FloatToStrF(FDataLink.Field.AsFloat, ffFixed, 20, FDecimals);
      end
      else
      begin
        if FZeroLength > 0 then
          EditText := StrZero(FloatToStr(FDataLink.Field.AsFloat), FZeroLength)
        else
          EditText := FloatToStrF(FDataLink.Field.AsFloat, ffNumber, 20, FDecimals);
      end;
    end
  else
    begin
      if csDesigning in ComponentState then
        begin
          EditText := Name;
          if FAlignment <> taLeftJustify then
            begin
              FAlignment := taLeftJustify;
              RecreateWnd;
            end
        end
      else
        EditText := '';
    end;
  if Focused and not FDataLink.Editing then
    SelectAll;
end;

procedure TXDBNumEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TXDBNumEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  if CheckRange then
  begin
    if FZeroLength > 0 then
      FDataLink.Field.Text := StrZero(FloatToStr(GetValue), FZeroLength)
    else
      FDataLink.Field.Text := FloatToStr(GetValue);
  end
  else
    Abort;
end;

procedure TXDBNumEdit.WMPaste(var Msg: TMessage);
var
  S: string;
  I: Integer;
  Key: Char;
begin
  if FDataLink.Editing and Clipboard.HasFormat(CF_TEXT) then
    begin
      S := FloatToStr(StrToValue(Clipboard.AsText));
      Text := '';
      for I := 1 to Length(S) do
        begin
          Key := S[I];
          KeyPress(Key);
          if Key <> #0 then
            Text := Text + Key;
        end;
      SelStart := Length(Text);
    end;
end;

procedure TXDBNumEdit.WMCut(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TXDBNumEdit.CMEnter(var Msg: TCMEnter);
begin
  SetFocused(True);
  SelectAll;
  inherited;
  Invalidate;
end;

procedure TXDBNumEdit.CMExit(var Msg: TCMExit);
begin
  if CheckRange then
    begin
      try
        FDataLink.UpdateRecord;
      except
        SelectAll;
        SetFocus;
        raise;
      end;
      SetFocused(False);
      SetCursor(0);
      DoExit;
    end;
end;

procedure TXDBNumEdit.WMPaint(var Msg: TWMPaint);
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
    ((FDataLink.Field <> nil) and FEnabledBtn);
  if FFocused and not (csPaintCopy in ControlState) then
    begin
      inherited;
      Exit;
    end;
  if (csDesigning in ComponentState) and (not IsActive) then
    S := Name
  else if (not IsActive) then
    S := ''
  else if FShowSeparator then
  begin
    if FZeroLength > 0 then
      S := StrZero(FloatToStr(GetValue), FZeroLength)
    else
      S := FloatToStrF(GetValue, ffNumber, 20, FDecimals);
  end
  else
  begin
    if FZeroLength > 0 then
      S := StrZero(FloatToStr(GetValue), FZeroLength)
    else
      S := FloatToStrF(GetValue, ffFixed, 20, FDecimals);
  end;
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
    begin
      if FShowSeparator then
      begin
        if FZeroLength > 0 then
          S := StrZero(FloatToStr(FDataLink.Field.AsFloat), FZeroLength)
        else
          S := FloatToStrF(FDataLink.Field.AsFloat, ffNumber, 20, FDecimals);
      end
      else
      begin
         if FZeroLength > 0 then
           S := StrZero(FloatToStr(FDataLink.Field.AsFloat), FZeroLength)
         else
           S := FloatToStrF(FDataLink.Field.AsFloat, ffFixed, 20, FDecimals);
      end;
    end;
  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    if not Enabled then
      FCanvas.Font.Color := clGray;
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

function TXDBNumEdit.StrZero(Number: string; Len: Integer): string;
begin
  if Length(Number) > Len then
    Number := Copy(Number, Length(Number) - Len + 1, Len)
  else
    while Length(Number) < Len do
      Number := '0' + Number;
  Result := Number;
end;

procedure TXDBNumEdit.CMGetDataLink(var Msg: TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;

procedure TXDBNumEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;

procedure TXDBNumEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
  SetButtonSize;
  SetClientRect;
end;

procedure TXDBNumEdit.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  SetShowCaret;
end;

procedure TXDBNumEdit.SetShowCaret;
begin
  CreateCaret(Handle, 0, 1, GetCursorHeight);
  ShowCaret(Handle);
end;

function TXDBNumEdit.GetCursorHeight: Integer;
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

function TXDBNumEdit.GetValue: Extended;
begin
  Result := StrToValue(Text);
end;

function TXDBNumEdit.StrToValue(S: string): Extended;
var
  N: string;
  I: Integer;
begin
  N := '0';
  for I := 1 to Length(S) do
    if ((S[I] = DecimalSeparator) and (Pos(DecimalSeparator, N) = 0))
      or (S[I] in ['0'..'9']) then
      N := N + S[I];
  Result := StrToFloat(N);
  if (N <> '0') and (Pos('-', S) = 1) then
    Result := -StrToFloat(N)
end;

procedure TXDBNumEdit.ValidateKey;
begin
  if FKey in ['.', ','] then
    FKey := DecimalSeparator;
  if not (FKey in ['0'..'9', '.', ',', '-', #08, #27, ^X, ^C, ^V])
    or ((GetValue < 0) and (SelStart = 0) and (SelLength = 0) and (FKey <> '-'))
    or ((FKey = DecimalSeparator) and (FDecimals = 0)) then
    begin
      MessageBeep(0);
      FKey := #0;
    end;
  if FKey in [^H, ^V, ^X, '0'..'9', DecimalSeparator] then
    FDataLink.Edit
  else if FKey = #27 then
    begin
      FDataLink.Reset;
      SelectAll;
      FKey := #0;
    end;
end;

procedure TXDBNumEdit.InvertValue;
var
  I, L: Integer;
begin
  L := Length(Text);
  if SelLength <> L then
    begin
      I := SelStart;
      if GetValue > 0 then
        Text := '-' + Text
      else if GetValue < 0 then
        Text := Copy(Text, 2, L);
      SelStart := I + Length(Text) - L;
      FKey := #0;
    end;
end;

procedure TXDBNumEdit.EvalDecSeparator;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(DecimalSeparator, Text );
  if (I > 0) and (SelLength <> L) then
    begin
      SelStart := I;
      FKey := #0;
    end
  else if (SelLength <> L) and ((SelStart + FDecimals) < L) then
    begin
      I := SelStart;
      Text := Copy(Text, 1, SelStart + FDecimals);
      SelStart := I;
    end;
end;

procedure TXDBNumEdit.EvaluateKey;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(DecimalSeparator, Text );
  if (I <> 0) and (SelStart >= I) and ((L - I) >= FDecimals) and (SelLength = 0) then
    begin
      if (SelStart < L) then
        begin
          I := SelStart;
          Text := Copy(Text, 1, L - 1 );
          SelStart := I;
        end
      else if (FKey <> #08) then
        begin
          MessageBeep(0);
          FKey := #0;
        end;
    end;
end;

procedure TXDBNumEdit.SetDecimals(Dec: Byte);
begin
  FDecimals := Dec;
  DataChange(Self);
end;

function TXDBNumEdit.IsActive: Boolean;
var
  DtSrc: TDataSource;
begin
  Result := False;
  DtSrc := GetDataSource;
  if (DtSrc <> nil) and (DtSrc.Dataset <> nil) then
    Result := DtSrc.Dataset.Active
end;

function TXDBNumEdit.CheckRange: Boolean;
begin
  Result := True;
  if IsActive and (((FMaxValue <> 0) and (GetValue > FMaxValue)) or
    ((FMinValue <> 0) and (GetValue < FMinValue))) then
    begin
      if Assigned(FOnOutOfRange) then
        FOnOutOfRange(Self)
      else
        MessageBeep(0);
      SelectAll;
      SetFocus;
      Result := False;
    end
end;

function TXDBNumEdit.GetTextMargins: TPoint;
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

procedure TXDBNumEdit.CreateButton;
begin
  FWinBack := TWinControl.Create(Self);
  FWinBack.Parent := Self;
  TEdit(FWinBack).Color := clBtnFace;
  FButton := TEvBtnDBNumEdit.Create(Self);
  FButton.Parent := FWinBack;
  FButton.OnClick := ButtonClick;
  FButton.Layout := blGlyphRight;
  FButton.Enabled := FEnabledBtn;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := ChangeGlyph;
  FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES);
end;

procedure TXDBNumEdit.SetClientRect;
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

procedure TXDBNumEdit.SetButtonSize;
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

procedure TXDBNumEdit.CheckLimitText;
var
  Margins: TPoint;
  I: Integer;
begin
  if FKey in ['0'..'9', '.', ',', '-'] then
    begin
      FCanvas.Font.Assign(Font);
      Margins := GetTextMargins;
      I := ClientWidth - FButton.Width - (Margins.X * 2) -
        FCanvas.TextWidth(Text) - 3;
      if (FCanvas.TextWidth(FKey) > I) and (SelLength = 0) and not
        ((GetValue < 0) and (FKey = '-')) then
        FKey := #0;
    end;
end;

procedure TXDBNumEdit.ButtonClick(Sender: TObject);
begin
  if FDataLink.ReadOnly = False then
    if Assigned(FOnBtnClick) then
      FOnBtnClick(Self)
    else
      ShowCalculator;
end;

procedure TXDBNumEdit.ShowCalculator;
var
  Pos: TPoint;
begin
  if not FDataLink.DataSource.AutoEdit and not
    (FDataLink.DataSource.State in [dsEdit, dsInsert]) then
    Exit;
  if FrmXDBNumEdit = nil then
    Application.CreateForm(TFrmXDBNumEdit, FrmXDBNumEdit);
  Pos := Point(0, 0);
  Pos := Self.ClientToScreen(Pos);
  if (Pos.X + 137) > Screen.DesktopWidth then
    FrmXDBNumEdit.Left := Pos.X - (FrmXDBNumEdit.Width - Width) - 2
  else
    FrmXDBNumEdit.Left := Pos.X - 2;
  if (Pos.Y + 205) > Screen.DesktopHeight then
    FrmXDBNumEdit.Top := Pos.Y - FrmXDBNumEdit.Height - 2
  else
    FrmXDBNumEdit.Top := Pos.Y + Height - 3;
  FrmXDBNumEdit.FOnwerEdt := Self;
  FrmXDBNumEdit.ResetCalc;
  FrmXDBNumEdit.FValBuffer := GetValue;
  FrmXDBNumEdit.PanDisplay.Caption := FloatToStr(GetValue);
  FrmXDBNumEdit.Show;
end;

procedure TFrmXDBNumEdit.FormCreate(Sender: TObject);
begin
  ResetCalc;
end;

procedure TFrmXDBNumEdit.FormDeactivate(Sender: TObject);
begin
  if FOnwerEdt.FAutoHideCalculator then
    Close;
end;

procedure TFrmXDBNumEdit.FormKeyPress(Sender: TObject; var Key: Char);
begin
  EvalKey(Key);
end;

procedure TFrmXDBNumEdit.BtnNumClick(Sender: TObject);
begin
  EvalKey(TSpeedButton(Sender).Caption[1]);
end;

procedure TFrmXDBNumEdit.EvalKey(Key: Char);
begin
  if Key in [',', '.', '·'] then
    Key := DecimalSeparator;
  if (Key in ['0'..'9', Chr(VK_BACK)]) or ((Key = DecimalSeparator) and
    (Pos(DecimalSeparator, FLastEnter) = 0)) then
    SendKeyToDiplay(Key)
  else if Key = '+' then
    BtnBaseOpClick(BtnAdd)
  else if Key = '-' then
    BtnBaseOpClick(BtnSub)
  else if Key = '/' then
    BtnBaseOpClick(BtnDiv)
  else if Key = '*' then
    BtnBaseOpClick(BtnMult)
  else if Key = '%' then
    BtnPercClick(BtnPerc)
  else if Key in ['=', Chr(VK_RETURN)] then
    BtnResClick(BtnRes)
  else if Key = Chr(VK_ESCAPE) then
    BtnCEClick(BtnCE)
  else if Key in ['c', 'C'] then
    BtnCClick(BtnC)
  else if Key in ['t', 'T'] then
    BtnSgnClick(BtnSgn)
  else if Key in ['c', 'C'] then
    BtnCancelClick(BtnCancel)
  else if Key in ['o', 'O'] then
    BtnOKClick(BtnOK);
end;

procedure TFrmXDBNumEdit.SendKeyToDiplay(Key: Char);
begin
  if (Key = Chr(VK_BACK)) and (FLastEnter <> '') then
    begin
      FLastEnter := Copy(FLastEnter, 1, Length(FLastEnter) - 1);
      if FLastEnter = '' then
        PanDisplay.Caption := '0'
      else
        PanDisplay.Caption := FLastEnter;
    end
  else if (Key <> Chr(VK_BACK)) and (Length(FLastEnter) < 14) then
    begin
      FEnterChanged := True;
      FLastEnter := FLastEnter + Key;
      PanDisplay.Caption := FLastEnter;
    end;
end;

procedure TFrmXDBNumEdit.ResetCalc;
begin
  FValBuffer := 0;
  FLastEnter := '';
  FOperator := #0;
  FEnterChanged := False;
end;

procedure TFrmXDBNumEdit.BtnCEClick(Sender: TObject);
begin
  ResetCalc;
  PanDisplay.Caption := '0';
end;

procedure TFrmXDBNumEdit.BtnCClick(Sender: TObject);
begin
  FLastEnter := '';
  PanDisplay.Caption := '0';
end;

function TFrmXDBNumEdit.GetDisplayValue: Double;
begin
  if FLastEnter <> '' then
    Result := StrToFloat(FLastEnter)
  else
    Result := 0;
end;

procedure TFrmXDBNumEdit.BtnBaseOpClick(Sender: TObject);
begin
  if FEnterChanged and (FOperator <> #0) then
    begin
      CalcOperation;
      ShowResult;
      FLastEnter := '';
    end
  else if (FValBuffer = 0) or (FLastEnter <> '') then
    begin
      FValBuffer := GetDisplayValue;
      FLastEnter := '';
    end;
  FOperator := TSpeedButton(Sender).Caption[1];
  FEnterChanged := False;
end;

procedure TFrmXDBNumEdit.CalcOperation;
var
  X: Double;
begin
  X := GetDisplayValue;
  if FOperator = '-' then
    FValBuffer := FValBuffer - X
  else if FOperator = '+' then
    FValBuffer := FValBuffer + X
  else if (FOperator = '÷') and (X = 0) then
    begin
      ResetCalc;
      PanDisplay.Caption := 'E';
    end
  else if FOperator = '÷' then
    FValBuffer := FValBuffer / X
  else if FOperator = '×' then
    FValBuffer := FValBuffer * X;
end;

procedure TFrmXDBNumEdit.BtnResClick(Sender: TObject);
begin
  if FEnterChanged and (FOperator <> #0) then
    begin
      CalcOperation;
      ShowResult;
      FLastEnter := '';
      FOperator := #0;
      FEnterChanged := False;
    end;
end;

procedure TFrmXDBNumEdit.ShowResult;
var
  S: string;
begin
  if PanDisplay.Caption <> 'E' then
    begin
      if Abs(FValBuffer) >= 1E+15 then
        S := 'E'
      else
        S := FloatToStr(FValBuffer);
      PanDisplay.Caption := S;
    end;
end;

procedure TFrmXDBNumEdit.BtnSgnClick(Sender: TObject);
begin
  if (FValBuffer <> 0) and (FLastEnter = '') then
    begin
      FValBuffer := -FValBuffer;
      ShowResult;
    end
  else if (FLastEnter <> '') then
    begin
      if (FLastEnter[1] = '-') then
        FLastEnter := Copy(FLastEnter, 2, Length(FLastEnter) - 1)
      else
        FLastEnter := '-' + FLastEnter;
      PanDisplay.Caption := FLastEnter;
    end;
end;

procedure TFrmXDBNumEdit.BtnPercClick(Sender: TObject);
var
  X: Double;
  S: string;
begin
  if FLastEnter <> '' then
    begin
      X := GetDisplayValue;
      S := FloatToStr(FValBuffer * (X / 100));
      if (Length(S) > 14) then
        S := Copy(S, 1, 14);
      PanDisplay.Caption := S;
      FLastEnter := S;
    end;
end;

procedure TFrmXDBNumEdit.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmXDBNumEdit.BtnOKClick(Sender: TObject);
begin
  if PanDisplay.Caption <> 'E' then
    begin
      FOnwerEdt.SetFocus;
      if FOnwerEdt.FDataLink.Editing then
        FOnwerEdt.Text := PanDisplay.Caption;
      FOnwerEdt.SelectAll;
    end;
  Close;
end;

procedure TFrmXDBNumEdit.PanMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastX := X;
  FLastY := Y;
end;

procedure TFrmXDBNumEdit.PanMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    begin
      Left := Left + (X - FLastX);
      Top := Top + (Y - FLastY);
    end;
end;

procedure Register;
begin
  RegisterComponents('X-Maker', [TXDBNumEdit]);
end;

end.
