unit ObjProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, TypInfo, PopupLb, ComCtrls;

type
  TFormObjProp = class;

  TProp = class(TObject)
  private
    procedure SetValue(Value: Variant);
    function GetValue: Variant;
    function IsEnumNull: Boolean;
  public
    Text: String;
    Editor: TNotifyEvent;
    Enum: TStringList;
    EnumValues: Variant;
    constructor Create(PropValue: Variant;
      PropEnum: TStringList; PropEnumValues: Variant; PropEditor: TNotifyEvent); virtual;
    destructor Destroy; override;
    property Value: Variant read GetValue write SetValue;
  end;

  TFormObjProp = class(TForm)
    Box: TScrollBox;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    EditPanel: TPanel;
    ComboPanel: TPanel;
    EditBtn: TSpeedButton;
    ComboBtn: TSpeedButton;
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBtnClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBtnClick(Sender: TObject);
    procedure LB1Click(Sender: TObject);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    FItems: TStringList;
    FItemIndex: Integer;
    FRowHeight: Integer;
    w, w1: Integer;
    b: TBitmap;
    BusyFlag, BusyFlag1: Boolean;
    DefHeight: Integer;
    EditRect : TRect;
    LB1: TPopupListBox;
    FTickCount: Integer;
    Panel1: TPanel;
    FOnHeightChanged: TNotifyEvent;
    FDown: Boolean;
    LastProp: String;
    procedure SetItems(Value: TStringList);
    procedure SetItemIndex(Value: Integer);
    function GetCount: Integer;
    procedure DrawOneLine(i: Integer; a: Boolean);
    procedure SetItemValue(Value: String);
    function GetItemValue(i: Integer): String;
    function CurItem: TProp;
    procedure WMNCLButtonDblClk(var Message: TMessage); message WM_NCLBUTTONDBLCLK;
    function GetPropValue(Index: Integer): Variant;
    procedure SetPropValue(Index: Integer; Value: Variant);
    function GetClassName(ObjName: String): String;
  public
    { Public declarations }
    CurObject: TObject;
    ObjectName: String;
    HideProperties: Boolean;
    procedure Atribui(Sender: TObject; Tudo: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ClearProperties(Tudo: Boolean);
    procedure Inicializa(Sender: TObject);
    procedure AddProperty(PropName: String; PropValue: Variant;
     PropEnum: TStringList; PropEnumValues: Variant;
     PropEditor: TNotifyEvent);
    procedure InsertProperty(Index: Integer; PropName: String; PropValue: Variant;
     PropEnum: TStringList; PropEnumValues: Variant;
     PropEditor: TNotifyEvent);
    procedure ItemsChanged;
    procedure Grow;
    property PropValue[Index: Integer]: Variant read GetPropValue write SetPropValue;
    property Items: TStringList read FItems write SetItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Count: Integer read GetCount;
    property SplitterPos: Integer read w1 write w1;
  end;

var
  FormObjProp: TFormObjProp;

implementation

{$R *.DFM}

uses PicEdit, StrEdit, Rotinas, Abertura;

const
  tkProps = [tkUnknown,tkInteger,tkChar,tkEnumeration,tkFloat,tkString,tkSet,
             tkClass,tkMethod,tkWChar,tkLString,tkWString,tkVariant];

  frColors: Array[0..41] of TColor =
    (clWhite, clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal,
     clGray, clSilver, clRed, clLime, clYellow, clBlue, clFuchsia,
     clAqua, clNone,
     clScrollBar, clBackground, clActiveCaption, clInactiveCaption,
     clMenu, clWindow, clWindowFrame, clMenuText, clWindowText,
     clCaptionText, clActiveBorder, clInactiveBorder, clAppWorkSpace,
     clHighlight, clHighlightText, clBtnFace, clBtnShadow, clGrayText,
     clBtnText, clInactiveCaptionText, clBtnHighlight, cl3DDkShadow,
     cl3DLight, clInfoText, clInfoBk);

  frColorNames: Array[0..41] of String =
    ('clWhite', 'clBlack', 'clMaroon', 'clGreen', 'clOlive', 'clNavy',
     'clPurple', 'clTeal', 'clGray', 'clSilver', 'clRed', 'clLime',
     'clYellow', 'clBlue', 'clFuchsia', 'clAqua', 'clTransparent',
     'clScrollBar', 'clBackground', 'clActiveCaption', 'clInactiveCaption',
     'clMenu', 'clWindow', 'clWindowFrame', 'clMenuText', 'clWindowText',
     'clCaptionText', 'clActiveBorder', 'clInactiveBorder', 'clAppWorkSpace',
     'clHighlight', 'clHighlightText', 'clBtnFace', 'clBtnShadow', 'clGrayText',
     'clBtnText', 'clInactiveCaptionText', 'clBtnHighlight', 'cl3DDkShadow',
     'cl3DLight', 'clInfoText', 'clInfoBk');

type
  TInspPanel = class(TPanel)
  protected
    procedure WMEraseBackground(var Message: TMessage); message WM_ERASEBKGND;
    procedure Paint; override;
  end;

procedure TInspPanel.WMEraseBackground(var Message: TMessage);
begin
end;

procedure TInspPanel.Paint;
begin
end;

{----------------------------------------------------------------------------}
constructor TProp.Create(PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant; PropEditor: TNotifyEvent);
begin
  inherited Create;
  Editor := PropEditor;
  Enum := PropEnum;
  EnumValues := PropEnumValues;
  Value := PropValue;
end;

destructor TProp.Destroy;
begin
  EnumValues := 0;
  inherited Destroy;
end;

function TProp.IsEnumNull: Boolean;
begin
  Result := TVarData(EnumValues).VType < varArray;
end;

procedure TProp.SetValue(Value: Variant);
begin
  Text := Value;
end;

function TProp.GetValue: Variant;
begin
  Result := Null;
end;

{----------------------------------------------------------------------------}
procedure TFormObjProp.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.WndParent := frDesigner.Handle;
end;

function TFormObjProp.GetPropValue(Index: Integer): Variant;
begin
  Result := TProp(FItems.Objects[Index]).Value;
end;

procedure TFormObjProp.SetPropValue(Index: Integer; Value: Variant);
begin
  TProp(FItems.Objects[Index]).Value := Value;
end;

procedure TFormObjProp.ClearProperties(Tudo: Boolean);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TProp(FItems.Objects[i]).Free;
  FItems.Clear;
end;

procedure TFormObjProp.Inicializa(Sender: TObject);
begin
  //PropInspector.Update(Sender);
end;

procedure TFormObjProp.AddProperty(PropName: String; PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant;
  PropEditor: TNotifyEvent);
begin
  FItems.AddObject('   ' + PropName, TProp.Create(PropValue, PropEnum,
    PropEnumValues, PropEditor));
end;

procedure TFormObjProp.InsertProperty(Index: Integer; PropName: String; PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant;
  PropEditor: TNotifyEvent);
begin
  FItems.InsertObject(Index, '   ' + PropName, TProp.Create(PropValue, PropEnum,
    PropEnumValues, PropEditor));
end;

function TFormObjProp.CurItem: TProp;
begin
  Result := nil;
  if (FItemIndex <> -1) and (Count > 0) then
    Result := TProp(FItems.Objects[FItemIndex]);
end;

procedure TFormObjProp.SetItems(Value: TStringList);
begin
  FItems.Assign(Value);
  FItemIndex := -1;
  PaintBox1.Repaint;
  ItemIndex := 0;
end;

procedure TFormObjProp.SetItemValue(Value: String);
var
  p: TProp;
  Tipo, Nome: String;
  PValue,i, Posicao: Integer;
  ob: TObject;
  PropInfo:PPropInfo;
  S: TIntegerSet;
  achou: boolean;
begin
  if Edit1.ReadOnly then
    exit;
  if FItemIndex < 0 then
    exit;
  {Tipo := PropInspector.ListaValor[FItemIndex];
  Posicao := StrToIntDef(PropInspector.ListaPosicao[FItemIndex],0);
  Nome:=Trim(FItems[FItemIndex]);
  ob := TObject(PropInspector.ListaObject[FItemIndex]);
  if Tipo = 'String' then
    SetStrProp(ob,Nome,Edit1.Text)
  else if Tipo = 'Char' then
    SetOrdProp(ob,Nome,Ord(StrToIntDef(Edit1.Text,0)))
  else if Tipo = 'Integer' then
  begin
    if PropInspector.ListaTipos[FItemIndex] = 'Color' then
      SetOrdProp(ob,Nome,StringToColor(Edit1.Text))
    else if PropInspector.ListaTipos[FItemIndex] = 'Cursor' then
      SetOrdProp(ob,Nome,StringToCursor(Edit1.Text))
    else
      SetOrdProp(ob,Nome,StrToIntDef(Edit1.Text,0));
  end
  else if Tipo = 'Float' then
    SetFloatProp(ob,Nome,StrToFloat(Edit1.Text))
  else if Tipo = 'Boolean' then
  begin
    if Trim(UpperCase(Edit1.Text)) = 'TRUE' then
    begin
      PValue:=Ord(True);
      Edit1.Text := 'True';
    end
    else
    begin
      PValue:=Ord(False);
      Edit1.Text := 'False';
    end;
    SetOrdProp(ob,Nome,PValue);
  end
  else if Tipo = 'Set' then
  begin
    PropInfo:= GetPropInfo(ob.ClassInfo, Nome);
    SetOrdProp(ob,Nome,GetEnumValue(PropInfo^.PropType^,Edit1.Text));
  end
  else if Tipo = 'SetElement' then
  begin
    if Copy(FItems[FItemIndex],01,02) = '  ' then
    begin
      achou := false;
      i := 0;
      while not achou do
      begin
        inc(i);
        Nome := Trim(FItems[FItemIndex-I]);
        if Copy(Nome,01,01) = '-' then
        begin
          Nome := Copy(Nome,02,200);
          achou := True;
        end;
      end;
    end;
    ob := TObject(PropInspector.VControl);
    PropInfo:= GetPropInfo(ob.ClassInfo, Nome);
    Integer(S) := GetOrdProp(ob, PropInfo);
    if Trim(UpperCase(Edit1.Text)) = 'TRUE' then
     Include(S, Posicao)
    else
      Exclude(S, Posicao);
    SetOrdProp(ob,Nome,Integer(S));
  end;
  p := TProp(FItems.Objects[FItemIndex]);
  p.Text := Edit1.Text;
  PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
  }
end;

function TFormObjProp.GetItemValue(i: Integer): String;
var
  p: TProp;
begin
  Result := '';
  p := TProp(FItems.Objects[i]);
  if p = nil then Exit;
  Result := p.Text;
end;

procedure TFormObjProp.SetItemIndex(Value: Integer);
var
  ww, y: Integer;
  b1, b2: Boolean;
begin
  if BusyFlag1 then Exit;
  if Value > Count - 1 then
    Value := Count - 1;
  Edit1.Visible := (Count > 0) and not HideProperties;
  if Count = 0 then Exit;
  if FItemIndex <> -1 then
    if Edit1.Modified then
      SetItemValue(Edit1.Text);
  FItemIndex := Value;
  ComboPanel.Visible := False;
  EditPanel.Visible := False;
  if (FItemIndex > -1) then //and (FItemIndex <= PropInspector.ListaTipos.Count-1) then
  begin
    {Edit1.ReadOnly := False;
    if (PropInspector.ListaTipos[FItemIndex] = 'Edit') then
    else if (PropInspector.ListaTipos[FItemIndex] = 'Edit_R') then
      Edit1.ReadOnly := True
    else if (PropInspector.ListaTipos[FItemIndex] = 'Color') or
            (PropInspector.ListaTipos[FItemIndex] = 'Cursor') or
            (PropInspector.ListaTipos[FItemIndex] = 'Boolean') or
            (PropInspector.ListaTipos[FItemIndex] = 'Combo') then
      ComboPanel.Visible := True
    else
      EditPanel.Visible := True;
    if (PropInspector.ListaTipos[FItemIndex] = 'Font') or
       (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') or
       (PropInspector.ListaTipos[FItemIndex] = 'Picture') or
       (PropInspector.ListaTipos[FItemIndex] = 'StringList') then
      Edit1.ReadOnly := True;}
  end
  else
    Edit1.ReadOnly := True;
  if (ComboPanel.Visible) then
    Edit1.ReadOnly := True;
  //if (FItemIndex > PropInspector.ListaTipos.Count-1) then
  //  EditPanel.Visible := True;
  LB1.Visible := False;
  ww := w - w1 - 2;
  y := FItemIndex * FRowHeight + 1;
  if EditPanel.Visible then
  begin
    EditPanel.SetBounds(w - 14, y, 14, FRowHeight - 2);
    EditBtn.SetBounds(0, 0, EditPanel.Width, EditPanel.Height);
    Dec(ww, 15);
  end;
  if FItemIndex > -1 then
    Edit1.Text := GetItemValue(FItemIndex);
  if ComboPanel.Visible then
  begin
    ComboPanel.SetBounds(w - 14, y, 14, FRowHeight - 2);
    ComboBtn.SetBounds(0, 0, ComboPanel.Width, ComboPanel.Height);
    Dec(ww, 15);
  end;
  Edit1.SetBounds(w1 + 2, y, ww, FRowHeight - 2);
  Edit1.SelectAll;
  Edit1.Modified := False;

  if y + FRowHeight > Box.VertScrollBar.Position + Box.ClientHeight then
    Box.VertScrollBar.Position := y - Box.ClientHeight + FRowHeight;
  if y < Box.VertScrollBar.Position then
    Box.VertScrollBar.Position := y - 1;

  if FItemIndex > -1 then
    LastProp := FItems[FItemIndex];
  PaintBox1Paint(nil);
end;

function TFormObjProp.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TFormObjProp.ItemsChanged;
var
  LastIndex: Integer;
begin
  FItemIndex := -1;
  BusyFlag := True;
  Panel1.Height := Items.Count * FRowHeight;
  Panel1.Width := Box.ClientWidth;
  w := PaintBox1.Width;
  BusyFlag := False;

  LastIndex := FItems.IndexOf(LastProp);
  if LastIndex = -1 then
    LastIndex := 0;
  ItemIndex := LastIndex;
end;

procedure TFormObjProp.DrawOneLine(i: Integer; a: Boolean);
var
  R: TRect;

  procedure Line(x, y, dx, dy: Integer);
  begin
    b.Canvas.MoveTo(x, y);
    b.Canvas.LineTo(x + dx, y + dy);
  end;

  function GetPropName(Index: Integer): String;
  var
    i: Integer;
  begin
    Result := FItems[Index];
    if (Trim(Result)[1] = '+') or (Trim(Result)[1] = '-') then
      Result := '   ' +Copy(Trim(Result),02,200);
  end;

begin
  if Count > 0 then
  with b.Canvas do
  begin
    Brush.Color := clBtnFace;
    Pen.Color := clBtnShadow;
    Font.Name := 'MS Sans Serif';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    R := Rect(5, i * FRowHeight + 1, w1 - 2, i * FRowHeight + FRowHeight - 1);
    if a then
    begin
      Pen.Color := clBtnShadow;
      Line(0, -2 + i * FRowHeight, w, 0);
      Line(w1 - 1, 0 + i * FRowHeight, 0, FRowHeight);
      Pen.Color := clBlack;
      Line(0, -1 + i * FRowHeight, w, 0);
      Line(0, -1 + i * FRowHeight, 0, FRowHeight + 1);
      Pen.Color := clBtnHighlight;
      Line(1, FRowHeight + -1 + i * FRowHeight, w - 1, 0);
      Line(Edit1.Left, 0 + i * FRowHeight, Edit1.Width, 0);
      Line(w1, 0 + i * FRowHeight, 0, FRowHeight);
      Line(w1 + 1, 0 + i * FRowHeight, 0, FRowHeight);
      //if i >= PropInspector.FEventos then
      //  Font.Color := clMaroon
      //else
        Font.Color := clBlack;
      TextRect(R, 5, 1 + i * FRowHeight, GetPropName(i));
    end
    else
    begin
      Line(0, FRowHeight + -1 + i * FRowHeight, w, 0);
      Line(w1 - 1, 0 + i * FRowHeight, 0, FRowHeight);
      Pen.Color := clBtnHighlight;
      Line(w1, 0 + i * FRowHeight, 0, FRowHeight);
      //if i >= PropInspector.FEventos then
      //  Font.Color := clMaroon
      //else
        Font.Color := clBlack;
      TextRect(R, 5, 1 + i * FRowHeight, GetPropName(i));
      Font.Color := clNavy;
      TextOut(w1 + 2, 1 + i * FRowHeight, GetItemValue(i));
    end;
    if (Trim(FItems[i])[1] = '+') or (Trim(FItems[i])[1] = '-') then
    begin
      EditRect.Left   := R.Left-3;
      EditRect.Top    := R.Top+2;
      EditRect.Right  := R.Left+06;
      EditRect.Bottom := R.Top+11;
      Brush.Color := clWindow;
      Brush.Style := bsSolid;
      Pen.Style := psSolid;
      pen.Color := clBlack;
      Rectangle(R.Left-3, R.Top+2, R.Left+06, R.Top+11);
      Brush.Color := clBtnFace;
      Rectangle(R.Left-1, R.Top+6, R.Left+4, R.Top+7);
      if (Trim(FItems[i])[1] = '+') then
        Rectangle(R.Left+1, R.Top+4, R.Left+2, R.Top+9);
    end;
  end;
end;

procedure TFormObjProp.PaintBox1Paint(Sender: TObject);
var
  i: Integer;
  r: TRect;
begin
  if BusyFlag then Exit;
  LB1.Hide;
  r := PaintBox1.BoundsRect;
  b.Width := PaintBox1.Width;
  b.Height := PaintBox1.Height;
  b.Canvas.Brush.Color := clBtnFace;
  b.Canvas.FillRect(r);
  if not HideProperties then
  begin
    for i := 0 to Count - 1 do
      if i <> FItemIndex then
        DrawOneLine(i, False);
    if FItemIndex <> -1 then DrawOneLine(FItemIndex, True);
  end;
  PaintBox1.Canvas.Draw(0, 0, b);
end;

procedure TFormObjProp.FormCreate(Sender: TObject);
begin
  Panel1 := TInspPanel.Create(Self);
  Panel1.Parent := Box;
  Panel1.BevelInner := bvNone;
  Panel1.BevelOuter := bvNone;
  PaintBox1.Parent := Panel1;
  ComboPanel.Parent := Panel1;
  EditPanel.Parent := Panel1;
  Edit1.Parent := Panel1;
  w := PaintBox1.Width;
  b := TBitmap.Create;
  FItemIndex := -1;
  FItems := TStringList.Create;
  FRowHeight := Canvas.TextHeight('Wg') + 3;//-Font.Height + 5;
  Box.VertScrollBar.Increment := FRowHeight;
  Box.VertScrollBar.Tracking := True;
  LB1 := TPopupListBox.Create(nil);
  LB1.ListBox.OnClick := LB1Click;
  DefHeight := Height;
  FormResize(nil);
end;

procedure TFormObjProp.FormDestroy(Sender: TObject);
begin
  b.Free;
  LB1.Free;
  ClearProperties(False);
  FItems.Free;
end;

procedure TFormObjProp.FormActivate(Sender: TObject);
begin
  if Edit1.Enabled and Edit1.Visible then
    Edit1.SetFocus;
end;

procedure TFormObjProp.FormDeactivate(Sender: TObject);
begin
  if BusyFlag then Exit;
  LB1.Hide;
  if CurItem = nil then Exit;
end;

procedure TFormObjProp.WMNCLButtonDblClk(var Message: TMessage);
begin
  if Height > 30 then
  begin
    ClientHeight := 0;
  end
  else
  begin
    Height := DefHeight;
    ItemsChanged;
    Edit1.SelText := Edit1.Text;
    Edit1.Modified := False;
  end;
  if Assigned(FOnHeightChanged) then
    FOnHeightChanged(Self);
end;

procedure TFormObjProp.FormResize(Sender: TObject);
begin
  Box.Width := ClientWidth;
  Box.Height := ClientHeight - 28; //- CB1.Height - 7;

  Panel1.Height := Items.Count * FRowHeight;
  Panel1.Width := Box.ClientWidth;

  w := PaintBox1.Width;
  SetItemIndex(FItemIndex);
end;

procedure TFormObjProp.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if HideProperties then Exit;
  if PaintBox1.Cursor = crHSplit then
    FDown := True
  else
  begin
    ItemIndex := y div FRowHeight;
    Edit1.SetFocus;
    FTickCount := GetTickCount;
    if (X >= EditRect.left) and (X <= EditRect.Right) and
       (y >= EditRect.Top) and (Y <= EditRect.Bottom) then
      PaintBox1DblClick(Self);
  end;
end;

procedure TFormObjProp.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if HideProperties then Exit;
  if Key = vk_Escape then
  begin
    Edit1.Perform(EM_UNDO, 0, 0);
    Edit1.Modified := False;
  end;
  if Key = vk_Up then
  begin
    if ItemIndex > 0 then
      ItemIndex := ItemIndex - 1;
    Key := 0;
  end
  else if Key = vk_Down then
  begin
    if ItemIndex < Count - 1 then
      ItemIndex := ItemIndex + 1;
    Key := 0;
  end;
end;

procedure TFormObjProp.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Edit1.Modified then SetItemValue(Edit1.Text);
    Edit1.Modified := False;
    Edit1.SelectAll;
    Key := #0;
  end;
end;

procedure TFormObjProp.EditBtnClick(Sender: TObject);
var
  ob: TObject;
  PropName, StrEvento: String;
  PropInfo: PPropInfo;
  Data:PTypeData;
  I, Count, P, IntVal:Integer;
  TypeInfo:PTypeInfo;
  PropList:PPropList;
begin
  if HideProperties then Exit;
  {if (FItemIndex > PropInspector.ListaTipos.Count-1) then
  begin
    PropName := Trim(FItems[FItemIndex]);
    PropInfo:= GetPropInfo(TObject(PropInspector.VControl).ClassInfo, PropName);
    StrEvento := TControl(PropInspector.VControl).Name + Copy(PropName,03,40) + '(' + WriteMethodData(GetTypeData(PropInfo^.PropType^))+')';
    showmessage(StrEvento);
    exit;
  end;
  if PropInspector.ListaTipos[FItemIndex] = 'Font' then
  begin
    ob := TObject(PropInspector.ListaObject[FItemIndex]);
    PropName:=Trim(FItems[FItemIndex]);
    PropName:=Copy(PropName,02,20);
    PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
    FontDialog.Font := TFont(GetOrdProp(ob, PropInfo));
    if FontDialog.Execute then
    begin
      TypeInfo:= PropInfo^.PropType^;
      Count:=GetPropList(TypeInfo,tkProperties,nil);
      GetMem(PropList, Count*SizeOf(PPropInfo));
      GetPropInfos(TypeInfo, PropList);
      Data:=GetTypeData(PropInfo^.PropType^);
      for I:=0 to Data^.PropCount - 1 do
        SetOrdProp(ob, PropInfo, Longint(FontDialog.Font));
      FreeMem(PropList, Count*SizeOf(PPropInfo));
      if FItems[FItemIndex][1] = '-' then
        PaintBox1DblClick(Self);
      SetFocus;
    end;
  end
  else if (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') or
          (PropInspector.ListaTipos[FItemIndex] = 'Picture') then
  begin
    with TPictureEditorDlg.Create(nil) do
    begin
      try
        ob := TObject(PropInspector.ListaObject[FItemIndex]);
        PropName:=Trim(FItems[FItemIndex]);
        PropName:=Copy(PropName,01,200);
        PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
        Pic.Assign(TPicture(GetOrdProp(ob, PropInfo)));
        ImagePaintBox.Invalidate;
        Save.Enabled := (Pic.Graphic <> nil) and not Pic.Graphic.Empty;
        Clear.Enabled := (Pic.Graphic <> nil) and not Pic.Graphic.Empty;
        if (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') then
          OpenDialog.Filter := 'Bitmap (*.bmp)|*.bmp'
        else
          OpenDialog.Filter := 'All (*.bmp;*.jpg;*.ico;*.emf;*.wmf)|*.bmp;*.jpg;*.ico;*.emf;*.wmf|Bitmaps (*.bmp)|*.bmp|Jpeg (*.jpg)|*.jpg|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
        OpenDialog.InitialDir := Projeto.PastaGerador + 'Imagem';
        SaveDialog.InitialDir := Projeto.PastaGerador + 'Imagem';
        if ShowModal=mrOK then
        begin
          if (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') then
            SetOrdProp(ob, PropInfo, LongInt(Pic.Bitmap))
          else
            SetOrdProp(ob, PropInfo, LongInt(Pic.Graphic));
        end;
      finally
        Free;
      end;
    end;
  end
  else if PropInspector.ListaTipos[FItemIndex] = 'StringList' then
  begin
    with TStrEditDlg.Create(nil) do
    begin
      try
        ob := TObject(PropInspector.ListaObject[FItemIndex]);
        PropName:=Trim(FItems[FItemIndex]);
        PropName:=Copy(PropName,01,200);
        PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
        Memo.Lines := TStrings(GetOrdProp(ob, PropInfo));
        if ShowModal=mrOK then
          SetOrdProp(ob, PropInfo, LongInt(Memo.Lines));
      finally
        Free;
      end;
    end;
  end;}
  Edit1.SelectAll;
end;

procedure TFormObjProp.Edit1DblClick(Sender: TObject);
var
  p: TProp;

  function IndexOf(arr: Variant; val: Variant): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to varArrayHighBound(arr, 1) do
      if arr[i] = val then
      begin
        Result := i;
        break;
      end;
  end;

begin
  p := CurItem;
  {if (FItemIndex > PropInspector.ListaTipos.Count-1) then
  begin
    EditBtnClick(Self);
    exit;
  end;
  if PropInspector.ListaTipos[FItemIndex] = 'Color' then
  begin
    ColorDialog.Color := StringToColor(Trim(Edit1.Text));
    if ColorDialog.Execute then
    begin
      Edit1.Text := ColorToString(ColorDialog.Color);
      Edit1.ReadOnly := False;
      Edit1.SelectAll;
      SetItemValue(Edit1.Text);
      Edit1.ReadOnly := True;
    end;
  end
  else if PropInspector.ListaTipos[FItemIndex] = 'Boolean' then
  begin
    if UpperCase(Trim(Edit1.Text)) = 'TRUE' then
      Edit1.Text := 'False'
    else
      Edit1.Text := 'True';
    Edit1.ReadOnly := False;
    Edit1.SelectAll;
    SetItemValue(Edit1.Text);
    Edit1.ReadOnly := True;
  end
  else if PropInspector.ListaTipos[FItemIndex] = 'Font' then
    EditBtnClick(Self);}
end;

function TFormObjProp.GetClassName(ObjName: String): String;
begin
  if CurObject <> nil then
    Result := CurObject.ClassName else
    Result := '';
end;

procedure TFormObjProp.ComboBtnClick(Sender: TObject);
var
  i, x, wItems, nItems: Integer;
  p: TPoint;
  PropName: String;
  PropInfo: PPropInfo;
  ob: TObject;
  PTD : PTypeData;
begin
  BusyFlag := True;
  if LB1.Visible then
  begin
    LB1.Hide;
    Edit1.SetFocus;
  end
  else with LB1.ListBox do
  begin
    LB1.Cores := False;
    Style := lbStandard;
    Items.Clear;
    Sorted := False;
    {if PropInspector.ListaTipos[FItemIndex] = 'Boolean' then
    begin
      Items.Add('False');
      Items.Add('True');
    end
    else if PropInspector.ListaTipos[FItemIndex] = 'Color' then
    begin
      Style := lbOwnerDrawVariable;
      LB1.Cores := True;
      for i := 0 to 41 do
        Items.Add(frColorNames[i])
    end
    else if PropInspector.ListaTipos[FItemIndex] = 'Cursor' then
    begin
      Items.Add('crAppStart');
      Items.Add('crArrow');
      Items.Add('crCross');
      Items.Add('crDefault');
      Items.Add('crDrag');
      Items.Add('crHandPoint');
      Items.Add('crHelp');
      Items.Add('crHourGlass');
      Items.Add('crHSplit');
      Items.Add('crIBeam');
      Items.Add('crMultiDrag');
      Items.Add('crNo');
      Items.Add('crNoDrop');
      Items.Add('crSizeAll');
      Items.Add('crSizeNESW');
      Items.Add('crSizeNS');
      Items.Add('crSizeNWSE');
      Items.Add('crSizeWE');
      Items.Add('crSQLWait');
      Items.Add('crUpArrow');
      Items.Add('crVSplit');
    end
    else
    begin
      ob := TObject(PropInspector.ListaObject[FItemIndex]);
      PropName := Trim(FItems[FItemIndex]);
      PropInfo:= GetPropInfo(ob.ClassInfo, PropName);
      PTD := GetTypeData(PropInfo^.PropType^);
      for x := PTD^.MinValue to PTD^.maxValue do
        Items.Add(GetEnumname(PropInfo^.PropType^, X));
    end;

    if Items.Count > 0 then
    begin
      ItemIndex := Items.IndexOf(CurItem.Text);
      wItems := 0;
      for i := 0 to Items.Count - 1 do
      begin
        if Canvas.TextWidth(Items[i]) > wItems then
          wItems := Canvas.TextWidth(Items[i]);
      end;

      Inc(wItems, 8);
      nItems := Items.Count;
      if nItems > 8 then
      begin
        nItems := 8;
        Inc(wItems, 16);
      end;

      p := Edit1.ClientToScreen(Point(0, Edit1.Height));

      if wItems < w1 then
        LB1.SetBounds(w1 + 1, p.Y,
                  w - w1 + 1, nItems * (ItemHeight + 1) + 2)
      else
        LB1.SetBounds(w - wItems + 2, p.Y,
                  wItems, nItems * (ItemHeight + 1) + 2);

      Width := LB1.ClientWidth;
      Height := LB1.ClientHeight;
      LB1.Height := Height;
      p := Self.ClientToScreen(Point(0, 0));
      Inc(p.X, LB1.Left);
      if p.X < 0 then p.X := 0;
      LB1.Left := p.X;
      LB1.Show;
    end;}
  end;
  BusyFlag := False;
end;

procedure TFormObjProp.LB1Click(Sender: TObject);
begin
  Edit1.Text := LB1.ListBox.Items[LB1.ListBox.ItemIndex];
  LB1.Hide;
  Edit1.SetFocus;
  Edit1.ReadOnly := False;
  SetItemValue(Edit1.Text);
  Edit1.ReadOnly := True;
end;

{$WARNINGS OFF}
procedure TFormObjProp.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if GetTickCount - FTickCount < GetDoubleClickTime then
    Edit1DblClick(nil);
end;
{$WARNINGS ON}

procedure TFormObjProp.Grow;
begin
  Show;
  if ClientHeight < 20 then
  begin
    Height := DefHeight;
    ItemsChanged;
    Edit1.SelText := Edit1.Text;
    Edit1.Modified := False;
    if Assigned(FOnHeightChanged) then
      FOnHeightChanged(Self);
  end;
end;

procedure TFormObjProp.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FDown then
    if (X > w1 - 2) and (X < w1 + 2) then
      PaintBox1.Cursor := crHSplit else
      PaintBox1.Cursor := crDefault
  else
  begin
    if x > 5 then
      w1 := X;
    FormResize(nil);
  end;
end;

procedure TFormObjProp.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := False;
end;

procedure TFormObjProp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
  FormObjProp := Nil;
end;

procedure TFormObjProp.PaintBox1DblClick(Sender: TObject);
var
  PropName:string;
  PropInfo:PPropInfo;
  I:Integer;
begin
  if (Trim(FItems[FItemIndex])[1] = '+') then
  begin
    //PropInspector.ListaProp[FItemIndex] := '-'+Copy(PropInspector.ListaProp[FItemIndex],02,200);
    //PropName:=Copy(Trim(FItems[FItemIndex]),02,200);
    //PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
    //Inc(PropInspector.FEventos,InsertPropInfo(PropInfo,PropInspector.VControl,FItemIndex));
    //Atribui(PropInspector.VControl,False);
  end
  else if (Trim(FItems[FItemIndex])[1] = '-') then
  begin
    //PropInspector.ListaProp[FItemIndex] := '+'+Copy(PropInspector.ListaProp[FItemIndex],02,200);
    //PropName:=Copy(Trim(FItems[FItemIndex]),02,200);
    //PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
    //Dec(PropInspector.FEventos,DeletePropInfo(PropInfo,PropInspector.VControl,FItemIndex));
    //Atribui(PropInspector.VControl,False);
  end;
end;

procedure TFormObjProp.Atribui(Sender: TObject; Tudo: Boolean);
var
  I,Y: Integer;
begin
  ClearProperties(Tudo);
  Y := FItemIndex;
  FItemIndex := 0;
  if Sender <> Nil then
  begin
    TabGlobal_i.DPROJETO.First;
    AddProperty('Título', TabGlobal_i.DPROJETO.TITULO_P.Conteudo, nil, Null, nil);
    AddProperty('Empresa', TabGlobal_i.DPROJETO.EMPRESA.Conteudo, nil, Null, nil);
    AddProperty('Analista', TabGlobal_i.DPROJETO.ANALISTA.Conteudo, nil, Null, nil);
    AddProperty('Programador', TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo, nil, Null, nil);
    AddProperty('Versão', TabGlobal_i.DPROJETO.VERSAO_P.Conteudo, nil, Null, nil);
    AddProperty('Início', TabGlobal_i.DPROJETO.INICIO.Conteudo, nil, Null, nil);
    AddProperty('Ícone', TabGlobal_i.DPROJETO.ICONE.Conteudo, nil, Null, nil);
    AddProperty('Data Século', TabGlobal_i.DPROJETO.FORMATODATA.Conteudo, nil, Null, nil);
    AddProperty('Confirma Saída', TabGlobal_i.DPROJETO.CONFIRMASAIDA.Conteudo, nil, Null, nil);
    AddProperty('Múltiplas Intâncias', TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo, nil, Null, nil);
    AddProperty('Hint - Balão', TabGlobal_i.DPROJETO.HINTBALAO.Conteudo, nil, Null, nil);
    AddProperty('Controle de Acesso', TabGlobal_i.DPROJETO.CONTROLEACESSO.Conteudo, nil, Null, nil);
    AddProperty('Dicionário de Dados', TabGlobal_i.DPROJETO.DICIONARIO.Conteudo, nil, Null, nil);
    AddProperty('Localização Dic.', TabGlobal_i.DPROJETO.DICIONARIO.Conteudo, nil, Null, nil);
    AddProperty('Senha', TabGlobal_i.DPROJETO.SENHA.Conteudo, nil, Null, nil);
    AddProperty('Linguagem', TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo, nil, Null, nil);
    AddProperty('Banco de Dados', TabGlobal_i.DPROJETO.BDADOS.Conteudo, nil, Null, nil);
    AddProperty('Conexão', TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo, nil, Null, nil);
    AddProperty('Senha', TabGlobal_i.DPROJETO.SENHA.Conteudo, nil, Null, nil);
    AddProperty('Apresentação', TabGlobal_i.DPROJETO.APRESENTACAO.Conteudo, nil, Null, nil);
    AddProperty('Papel de Parede', TabGlobal_i.DPROJETO.FUNDO.Conteudo, nil, Null, nil);
    AddProperty('Ajustar Papel', TabGlobal_i.DPROJETO.AJUSTAR.Conteudo, nil, Null, nil);
    if Y > FItems.Count-1 then
      FItemIndex := FItems.Count-1
    else
      FItemIndex := Y;
    if FItemIndex > -1 then
      Edit1.Text := GetItemValue(FItemIndex);
  end;
  FormResize(Self);
end;

procedure TFormObjProp.Edit1Change(Sender: TObject);
var
  Tipo: String;
  ob: TObject;
  Nome: String;
begin
  if (Edit1.ReadOnly) or (not Edit1.Modified) or (FItemIndex < 0) or (ComboPanel.Visible) then
    exit;
  {Tipo := PropInspector.ListaValor[FItemIndex];
  ob := TObject(PropInspector.ListaObject[FItemIndex]);
  Nome := Trim(FItems[FItemIndex]);
  if Tipo = 'String' then
    SetItemValue(Edit1.Text);}
end;

end.
