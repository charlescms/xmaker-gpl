{
   Programa.: Extras.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Extras;

interface

uses Classes, IniFiles, Dialogs, Forms, ComCtrls, SysUtils, WinTypes,
     Messages, Windows, Graphics, Controls, Menus, Commctrl;

// THintDesign

type
  THintPosition=(hiTopRight,hiTopLeft,hiBottomRight,hiBottomLeft);
  THintStyle=(hiRectangle,hiRoundrect,hiBubble,hiImage, hiTexture, hiText);
  TQuality=(quHi,quLow);
  TLinkStyle=(liNone,liArrow,liBubble);
  TFontData = record
    Color : TColor;
    Size : integer;
    Style : TFontStyles;
    Name : TFontName;
  end;

  THintDesign = class(TComponent)
  private
    FPicture : TPicture;
    FBorder : Boolean;
    FBorderColor : TColor;
    FColor : TColor;
    FFont : TFont;
    FPosition : THintPosition;
    FShadow : boolean;
    FShadowQuality : TQuality;
    FShadowIntensity : integer;
    FShadowWidth : integer;
    FDelay : Integer;
    FHintStyle : THintStyle;
    FlinkStyle : TLinkStyle;
    procedure SetFont(Value:TFont);
    procedure SetDelay(Value:Integer);
    procedure SetPicture(Value: TPicture);
    procedure SetShadowIntensity(Value: integer);
    procedure SetShadowWidth(Value: integer);
    procedure CMFontChanged(var Message:TMessage); message CM_FONTCHANGED;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Loaded;override;
    procedure Reset;
  published
    property Picture : TPicture read FPicture write SetPicture;
    property Font : TFont read FFont write SetFont;
    property Color : TColor read FColor write FColor;
    property Position : THintPosition read FPosition write FPosition;
    property Shadow : boolean read FShadow write FShadow;
    property ShadowQuality : TQuality read FShadowQuality write FShadowQuality;
    property ShadowIntensity : integer read FShadowIntensity write SetShadowIntensity;
    property ShadowWidth : integer read FShadowWidth write SetShadowWidth;
    property Delay : Integer read FDelay write SetDelay;
    property HintStyle : THintStyle read FHintStyle write FHintStyle;
    property linkStyle : TLinkStyle read FlinkStyle write FlinkStyle;
    property Border : Boolean read FBorder write FBorder;
    property BorderColor : TColor read FBorderColor write FBorderColor;
  end;

  TNewDesign = class(THintWindow)
  private
    LinkSize : integer;
    RealTextHeight : integer;
    FlinkStyle : TLinkStyle;
    FHintDesign : THintDesign;
    FPosition : THintPosition;
    FShadow : Boolean;
    Left,Top,Width,Height : integer;
    CanvasTmp : TBitmap;
    function CheckLeft : boolean;
    function CheckRight : boolean;
    function CheckTop : boolean;
    function CheckBottom : boolean;
    procedure IsTopRightValid;
    procedure IsBottomRightValid;
    procedure IsTopLeftValid;
    procedure IsBottomLeftValid;
    function Search : THintDesign;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
  protected
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure ActivateHint(Rect: TRect; const AHint: string);override;
  end;
  function PixelChanged(Color:TColor; value:integer) : TColor;
  procedure DrawBitmap(Handle : HDC; Left,Top : integer; Bitmap : HBitmap);
  procedure DrawMosaic(Handle : HDC; Left,Top,Width,Height : integer; Bitmap : HBitmap);
  procedure DrawHint(Handle : HDC;
                     HintFont : TFontData;
                     Left,Top,Width,Height : integer;
                     RealTextHeight : integer;
                     Color : TColor;
                     Caption : string;
                     Position : THintPosition;
                     HintStyle : THintStyle;
                     LinkStyle : TlinkStyle;
                     LinkSize : integer;
                     Shadow : Boolean;
                     ShadowQuality : TQuality;
                     ShadowWidth : integer;
                     ShadowIntensity : integer;
                     bitmap : HBitmap;
                     Border : boolean;
                     BorderColor : TColor);

// TMainMessenger

type
 TMainMessenger = Class;
 TSignalThread = class(TThread)
  private
    FMailSlot : TMainMessenger;
  protected
    procedure Execute; override;
  Public
    Constructor Create(MailSlot : TMainMessenger);
  end;
 TTimerThread = class(TThread)
  private
    FMailSlot : TMainMessenger;
  protected
    procedure Execute; override;
  Public
    Constructor Create(MailSlot : TMainMessenger);
  end;

  TNELineArrival = Procedure (Sender : TObject;Origin,Time,Line : string) of Object;
  TNEMemoArrival = Procedure (Sender : TObject;Origin,Time : string;MsgLines : TStrings) of Object;
  TNEUserListChange = Procedure (Sender : TObject; UserList : TStrings) of Object;
  TNEError = Procedure (Sender : TObject;ErrorMsg : string) of object;
  TNETimer = Procedure (Sender : TObject) of object;

  TMainMessenger = class(TComponent)
  private
   FWaitThread : TSignalThread;
   FTimerThread : TTimerThread;
   LocalHandle,RemoteHandle : THandle;
   ActiveFlag : Boolean;
   FComputer,FUser : string;
   Server,FBoxName,LocalPath,RemotePath : string;
   MaxMsgSize,MsgCount,NextMsgSize,MsgSize : DWORD;
   MsgType,MsgTime,MsgSender,MsgText : string;
   OutStrings,InStrings,UserList,MemoLines : TStringList;
   NewLine : String;
   FInterval : word;
   FTimerActive : boolean;
   FLineArrival : TNELineArrival;
   FMemoArrival : TNEMemoArrival;
   FUserListChange : TNEUserListChange;
   FError : TNEError;
   FTimer : TNETimer;
   Procedure SendOutStrings(Recipient : string);
   Procedure SendCommand(Recipient,Command : string);
   Procedure AddUser(Name : string);
   Procedure DeleteUser(Name : string);
  protected
   Procedure DoLineArrival(Const FMSender,FMTime,FMText : string); virtual;
   Procedure DoMemoArrival(const FMSender,FMTime : string;MLines : Tstrings); virtual;
   Procedure DoUserListChange(Const CompList : TStringList); virtual;
   Procedure DoErrorReport(const Error : string); virtual;
  public
    Constructor Create(AOwner : TComponent); Override;
    Destructor Destroy; override;
    Procedure Activate;
    Procedure DeActivate;
    Procedure SetName(const NewName : TComponentName); override;
    Procedure SetBoxName(NewName : string);
    Procedure SetInterval(time : word);
    Procedure ReadMessage;
    Procedure ProcessCommand;
    Procedure SendLine(Recipient,Text : string);
    Procedure SendMemo(Recipient : string;Lines : TStrings);
    Procedure Broadcast(text : string);
    procedure DoTimer;
    Property OnNewLine : TNELineArrival read FLineArrival write FLineArrival;
    Property OnNewMemo : TNEMemoArrival read FMemoArrival write FMemoArrival;
    Property OnUserListChange : TNEUserListChange Read FUserListChange Write FUserListChange;
    Property OnError : TNEError read FError write FError;
    Property OnTimer : TNETimer read FTimer write FTimer;
  published
  end;

 TMessenger = class(TMainMessenger)
  Published
   Property Computer : string read FComputer;
   Property User : string read FUser;
   Property BoxName : string read FBoxName write SetBoxName;
   Property Interval : word read FInterval write SetInterval;
   Property OnNewLine;
   Property OnNewMemo;
   Property OnUserListChange;
   Property OnError;
   Property OnTimer;
  end;


implementation

// THintDesign

constructor THintDesign.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FHintStyle := hiBubble;
  FLinkStyle := liArrow;
  FPosition := hiTopRight;
  FPicture := TPicture.Create;
  FFont:=TFont.Create;
  FFont.Name:='Arial';
  FFont.Size:=10;
  FFont.Color:=clBlack;
  FFont.Style:=[];
  FColor:=clwhite;
  FBorder := true;
  FBorderColor := clBlack;
  FShadow := true;
  FShadowQuality := quLow;
  FShadowIntensity := 70;
  FShadowWidth := 4;
  FDelay := 500;
  Application.HintPause:=FDelay;
  Reset;
end;

destructor THintDesign.Destroy;
begin
   FPicture.free;
   FFont.free;
   inherited Destroy;
end;

procedure THintDesign.Reset;
var
  i : integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    Application.ShowHint:=not Application.ShowHint;
    for i := 0 to 10 do Application.processmessages;
    Application.ShowHint:=not Application.ShowHint;
    for i := 0 to 10 do Application.processmessages;
    for i := 0 to Application.ComponentCount-1 do
    if Application.Components[I] is TNewDesign then
    begin
      TNewDesign(Application.Components[i]).Canvas.Font.Assign(FFont);
      Exit;
    end;
  end;
end;

procedure THintDesign.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then
    HintWindowClass:=TNewDesign;
  Reset;
end;

procedure THintDesign.CMFontChanged(var Message:TMessage);
begin
  inherited;
  Reset;
end;

procedure THintDesign.SetFont(Value:TFont);
begin
  FFont.Assign(Value);
  Reset;
end;

procedure THintDesign.SetDelay(Value:Integer);
begin
  FDelay := Value;
  Application.HintPause := Value;
end;

procedure THintDesign.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure THintDesign.SetShadowIntensity(Value: integer);
begin
  if ((value>=0) and (value<=255)) then FShadowIntensity := Value;
end;

procedure THintDesign.SetShadowWidth(Value: integer);
begin
  if ((value>=0) and (value<=10)) then FShadowWidth := Value;
end;

// Componente: TNewDesign

constructor TNewDesign.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  brush.style := bsClear;
  ctl3d := false;
  borderwidth := 0;
end;

destructor TNewDesign.Destroy;
begin
  inherited Destroy;
end;

procedure TNewDesign.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TNewDesign.WMNCPaint(var Message: TMessage);
begin
end;

procedure TNewDesign.Paint;
var
 CanvasTmp : TBitmap;
 HintFont : TFontData;
begin
  CanvasTmp := TBitmap.Create;
  CanvasTmp.Width := Width;
  CanvasTmp.height := height;
  BitBlt(CanvasTmp.Canvas.Handle,0,0,Width,height,CreateDC('DISPLAY',nil,nil,nil),left,top,SRCCOPY);
  CanvasTmp.Canvas.Font.Assign(FHintDesign.Font);
  with HintFont do
  begin
    Color := FHintDesign.Font.Color;
    size := FHintDesign.Font.size;
    Style:= FHintDesign.Font.Style;
    Name:= FHintDesign.Font.Name;
  end;
  DrawHint(CanvasTmp.canvas.handle,
            HintFont,
            left,
            top,
            Width,
            Height,
            RealTextHeight,
            FHintDesign.Color,
            Caption,
            FPosition,
            FHintDesign.HintStyle,
            FLinkStyle,
            LinkSize,
            FHintDesign.FShadow,
            FHintDesign.FShadowQuality,
            FHintDesign.ShadowWidth,
            FHintDesign.ShadowIntensity,
            FHintDesign.Picture.bitmap.handle,
            FHintDesign.Border,
            FHintDesign.BorderColor);
  with inherited Canvas do
  begin
    CopyMode:=cmSrcCopy;
    CopyRect(ClientRect,CanvasTmp.Canvas,ClientRect);
  end;
  CanvasTmp.Free;
end;

function TNewDesign.CheckLeft : boolean;
begin
  if Left-Width>0 then result := true else result := false;
end;

function TNewDesign.CheckRight : boolean;
begin
  if Left+Width<Screen.Width then result := true else result := false;
end;

function TNewDesign.CheckTop : boolean;
begin
  if Top-Height-10>0 then result := true else result := false;
end;

function TNewDesign.CheckBottom : boolean;
begin
  if Top+Height+10<Screen.Height then result := true else result := false;
end;

procedure TNewDesign.IsTopRightValid;
begin
  if not CheckRight and CheckLeft then
  begin
    IsTopLeftValid;
    exit;
  end;
  if  not CheckTop and CheckBottom then
  begin
    IsBottomRightValid;
    exit;
  end;
  if not CheckRight and not CheckLeft then Left := Screen.Width-Width;
  dec(Top,Height+10);
  FPosition := hiTopRight;
end;

procedure TNewDesign.IsBottomRightValid;
begin
  if  not CheckRight and CheckLeft then
  begin
    IsBottomLeftValid;
    exit;
  end;
  if  not CheckBottom and CheckTop then
  begin
    IsTopRightValid;
    exit;
  end;
  if not CheckRight and not CheckLeft then Left := Screen.Width-Width;
  inc(Top,10);
  FPosition := hiBottomRight;
end;

procedure TNewDesign.IsTopLeftValid;
begin
  if  not CheckLeft and CheckRight then
  begin
    IsTopRightValid;
    exit;
  end;
  if  not CheckTop and CheckBottom then
  begin
    IsBottomLeftValid;
    exit;
  end;
  if not CheckRight and not CheckLeft then Left := 0 else dec(Left,Width);
  dec(Top,Height+10);
  FPosition := hiTopLeft;
end;

procedure TNewDesign.IsBottomLeftValid;
begin
  if  not CheckLeft and CheckRight then
  begin
    IsBottomRightValid;
    exit;
  end;
  if  not CheckBottom and CheckTop then
  begin
    IsTopLeftValid;
    exit;
  end;
  if not CheckRight and not CheckLeft then Left := 0 else dec(Left,Width);
  inc(Top,10);
  FPosition := hiBottomLeft;
end;

function TNewDesign.Search : THintDesign;
var
  i:Integer;
begin
  Result:=nil;
  for I:=0 to Application.MainForm.ComponentCount-1 do
  if Application.MainForm.Components[I] is THintDesign then
  begin
    Result:=THintDesign(Application.MainForm.Components[I]);
    Exit;
  end;
end;

procedure TNewDesign.ActivateHint(Rect: TRect; const AHint: string);
var
  MousePos : TPoint;
  i : integer;
begin
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE);
  for i := 0 to 10 do application.processmessages;
  brush.style := bsClear;
  ctl3d := false;
  borderwidth := 0;
  GetCursorPos(MousePos);
  Caption := AHint;
  FHintDesign := Search;
  FShadow := FHintDesign.Shadow;
  FPosition := FHintDesign.Position;
  FLinkStyle := FHintDesign.LinkStyle;
  Left := MousePos.x;
  Top := MousePos.y;
  Width := Rect.Right-Rect.Left;
  Height := Rect.Bottom-Rect.Top;
  RealTextHeight := Rect.Bottom-Rect.Top;
  case FHintDesign.HintStyle of
    hiBubble:
    begin
      Width := trunc(Width+Height);
      Height := trunc(Height*2);
      if trunc(Width/Height)>4 then Height := trunc(Width/4);
    end;
    hiImage:
    begin
      Width := FHintDesign.Picture.width;
      Height := FHintDesign.Picture.height;
      if FHintDesign.Border then
      begin
        inc(Width,2);
        inc(Height,2);
      end;
      FLinkStyle := liNone;
    end;
    hiTexture:
    begin
      FLinkStyle := liNone;
    end;
    hiText:
    begin
      FLinkStyle := liNone;
      FShadow := false;
    end;
  end;
  if FLinkStyle<>liNone then
  begin
    if FHintDesign.LinkStyle=liArrow then LinkSize := 15 else LinkSize := 20;
    if width<35 then width := 35;
    inc(Height,LinkSize);
  end else
  begin
    LinkSize := 10;
    inc(Height,LinkSize);
  end;
  if FShadow then
  begin
    inc(Width,FHintDesign.ShadowWidth);
    inc(Height,FHintDesign.ShadowWidth);
  end;
  case FPosition of
    hiTopRight : IsTopRightValid;
    hiBottomRight : IsBottomRightValid;
    hiTopLeft : IsTopLeftValid;
    hiBottomLeft : IsBottomLeftValid;
  end;
  brush.style := bsClear;
  ctl3d := false;
  borderwidth := 0;
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, height, SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

function PixelChanged(Color:TColor; value:integer) : TColor;
var
  r,g,b : integer;
begin
  r := getrvalue(ColorToRGB(Color));
  g := getgvalue(ColorToRGB(Color));
  b := getbvalue(ColorToRGB(Color));
  if value>0 then
  begin
    if r+value>255 then r := 254 else inc(r,value);
    if g+value>255 then g := 254 else inc(g,value);
    if b+value>255 then b := 254 else inc(b,value);
  end else
  begin
    if r+value<0 then r := 1 else inc(r,value);
    if g+value<0 then g := 1 else inc(g,value);
    if b+value<0 then b := 1 else inc(b,value);
  end;
  result := rgb(r,g,b);
end;

procedure DrawBitmap(Handle : HDC; Left,Top : integer; Bitmap : HBitmap);
var
  Cv : TCanvas;
  Bmp : TBitmap;
begin
  Cv := TCanvas.create;
  Cv.handle := Handle;
  Bmp := TBitmap.create;
  Bmp.handle := Bitmap;
  Cv.Draw(Left,Top,Bmp);
  Bmp.releasehandle;
  Bmp.free;
  Cv.free;
end;

procedure DrawMosaic(Handle : HDC; Left,Top,Width,Height : integer; Bitmap : HBitmap);
var
  i,ii,nh,nw : integer;
  Cv : TCanvas;
  CvTmp : TBitmap;
  Bmp : TBitmap;
begin
  Cv := TCanvas.create;
  Cv.handle := Handle;
  Bmp := TBitmap.create;
  Bmp.handle := Bitmap;
  CvTmp := TBitmap.create;
  CvTmp.height := height;
  CvTmp.width := width;
  if ((Bmp.height>0) and (Bmp.width>0)) then
  begin
    nh := trunc(height/Bmp.height);
    nw := trunc(width/Bmp.width);
    for i := 0 to nh do for ii := 0 to nw do CvTmp.Canvas.Draw(ii*Bmp.width,i*Bmp.height,Bmp);
    Cv.Draw(Left,Top,CvTmp);
  end;
  Bmp.releasehandle;
  Bmp.free;
  CvTmp.free;
  Cv.free;
end;

procedure DrawHint(Handle : HDC;
                   HintFont : TFontData;
                   Left,Top,Width,Height : integer;
                   RealTextHeight : integer;
                   Color : TColor;
                   Caption : string;
                   Position : THintPosition;
                   HintStyle : THintStyle;
                   LinkStyle : TlinkStyle;
                   LinkSize : integer;
                   Shadow : Boolean;
                   ShadowQuality : TQuality;
                   ShadowWidth : integer;
                   ShadowIntensity : integer;
                   bitmap : HBitmap;
                   Border : boolean;
                   BorderColor : TColor); export;
var
  HintRect,ShadowRect : TRect;
  RectTmp : TRect;
  HintPoint : array[0..2] of TPoint;
  ShadowPoint : array[0..2] of TPoint;
  ShadowRgn,ShadowRgn_,b0s : HRgn;
  BRect : array[0..2] of TRect;
  BSRect : array[0..2] of TRect;
  text : array[0..255] of Char;
  TmpPicture : TPicture;
  i,ii,x,y,nh,nw : integer;
  Cv : Tcanvas;
  ColorTmp : TColor;
  procedure PaintShadow(Handle : HDC; Rect : TRect; Rgn : HRgn; ShadowQuality : TQuality; Intensity : integer);
  var
   x,y : integer;
  begin
    for x := Rect.left to Rect.right do
    for y := Rect.top to Rect.bottom do
    begin
      case ShadowQuality of
        quLow : if (odd(x)=odd(y)) and PtInRegion(Rgn,x,y) then
                setpixel(Handle,x,y,PixelChanged(getpixel(Handle,x,y),-Intensity));
        quHi  : if PtInRegion(Rgn,x,y) then
                setpixel(Handle,x,y,PixelChanged(getpixel(Handle,x,y),-Intensity));
      end;
    end;
  end;
  procedure PaintShadow_(Handle : HDC; Rect : TRect; Rgn,Rgnb : HRgn; ShadowQuality : TQuality; Intensity : integer);
  var
   x,y : integer;
  begin
    for x := Rect.left to Rect.right do
    for y := Rect.top to Rect.bottom do
    begin
      case ShadowQuality of
        quLow : if (odd(x)=odd(y)) and PtInRegion(Rgn,x,y) and not PtInRegion(Rgnb,x,y) then
                setpixel(Handle,x,y,PixelChanged(getpixel(Handle,x,y),-Intensity));
        quHi  : if PtInRegion(Rgn,x,y) and not PtInRegion(Rgnb,x,y) then
                setpixel(Handle,x,y,PixelChanged(getpixel(Handle,x,y),-Intensity));
      end;
    end;
  end;
begin
  Cv := Tcanvas.create;
  Cv.handle := Handle;
  if (not Shadow or (HintStyle=hiText)) then ShadowWidth := 0;
  case Position of
    hiTopRight :
    begin
      HintRect := Rect(0,0,Width-ShadowWidth, Height-ShadowWidth-LinkSize);
      ShadowRect := Rect(0+ShadowWidth,0+ShadowWidth,Width,Height-LinkSize);
      if HintStyle=hiBubble then
      begin
        HintPoint[0] := Point(trunc(width/3),
                              Height-ShadowWidth-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
        HintPoint[1] := Point(0,height-ShadowWidth);
        HintPoint[2] := Point(trunc(width/3)*2,
                              Height-ShadowWidth-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[0] := Point(trunc(width/3)+ShadowWidth,
                                Height-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[1] := Point(ShadowWidth,height);
        ShadowPoint[2] := Point(trunc(width/3)*2+ShadowWidth,
                                Height-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
      end else
      begin
        HintPoint[0] := Point(10,Height-ShadowWidth-LinkSize-2);
        HintPoint[1] := Point(0,height-ShadowWidth);
        HintPoint[2] := Point(30,Height-ShadowWidth-LinkSize-2);
        ShadowPoint[0] := Point(10+ShadowWidth,Height-LinkSize-1);
        ShadowPoint[1] := Point(0+ShadowWidth,height);
        ShadowPoint[2] := Point(30+ShadowWidth,Height-LinkSize-1);
      end;
      BRect[0] := Rect(0,height-ShadowWidth-6,6,height-ShadowWidth);
      BRect[1] := Rect(7,height-ShadowWidth-12,17,height-ShadowWidth-2);
      BRect[2] := Rect(15,height-ShadowWidth-25,30,height-ShadowWidth-10);
      x := 0;
      y := 1;
    end;
    hiBottomRight :
    begin
      HintRect := Rect(0,0+LinkSize,Width-ShadowWidth, Height-ShadowWidth);
      ShadowRect := Rect(0+ShadowWidth,0+LinkSize+ShadowWidth,Width,Height);
      if HintStyle=hiBubble then
      begin
        HintPoint[0] := Point(trunc(width/3),
                              LinkSize+trunc((Height-ShadowWidth-LinkSize)/2));
        HintPoint[1] := Point(0,0);
        HintPoint[2] := Point(trunc(width/3)*2,
                              LinkSize+trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[0] := Point(trunc(width/3)+ShadowWidth,
                                LinkSize+ShadowWidth+trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[1] := Point(ShadowWidth,ShadowWidth);
        ShadowPoint[2] := Point(trunc(width/3)*2+ShadowWidth,
                                LinkSize+ShadowWidth+trunc((Height-ShadowWidth-LinkSize)/2));
      end else
      begin
        HintPoint[0] := Point(10,LinkSize+1);
        HintPoint[1] := Point(0,0);
        HintPoint[2] := Point(30,LinkSize+1);
        ShadowPoint[0] := Point(10+ShadowWidth,LinkSize+ShadowWidth);
        ShadowPoint[1] := Point(0+ShadowWidth,ShadowWidth);
        ShadowPoint[2] := Point(30+ShadowWidth,LinkSize+ShadowWidth);
      end;
      BRect[0] := Rect(0,0,6,6);
      BRect[1] := Rect(7,2,17,12);
      BRect[2] := Rect(15,10,30,25);
      x := 0;
      y := -1;
    end;
    hiTopLeft :
    begin
      HintRect := Rect(0,0,Width-ShadowWidth, Height-ShadowWidth-LinkSize);
      ShadowRect := Rect(0+ShadowWidth,0+ShadowWidth,Width,Height-LinkSize);
      if HintStyle=hiBubble then
      begin
        HintPoint[0] := Point(width-trunc(width/3)-ShadowWidth,
                              Height-ShadowWidth-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
        HintPoint[1] := Point(width-ShadowWidth,height-ShadowWidth);
        HintPoint[2] := Point(width-trunc(width/3)-trunc(width/3)-ShadowWidth,
                              Height-ShadowWidth-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[0] := Point(width-trunc(width/3),
                                Height-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[1] := Point(width,height);
        ShadowPoint[2] := Point(width-trunc(width/3)-trunc(width/3),
                                Height-LinkSize-trunc((Height-ShadowWidth-LinkSize)/2));
      end else
      begin
        HintPoint[0] := Point(width-10-ShadowWidth,Height-ShadowWidth-LinkSize-2);
        HintPoint[1] := Point(width-ShadowWidth,height-ShadowWidth);
        HintPoint[2] := Point(width-30-ShadowWidth,Height-ShadowWidth-LinkSize-2);
        ShadowPoint[0] := Point(width-10,Height-LinkSize-1);
        ShadowPoint[1] := Point(width,height);
        ShadowPoint[2] := Point(width-30,Height-LinkSize-1);
      end;
      BRect[0] := Rect(width-ShadowWidth-6,height-ShadowWidth-6,width-ShadowWidth,height-ShadowWidth);
      BRect[1] := Rect(width-ShadowWidth-17,height-ShadowWidth-12,width-ShadowWidth-7,height-ShadowWidth-2);
      BRect[2] := Rect(width-ShadowWidth-30,height-ShadowWidth-25,width-ShadowWidth-15,height-ShadowWidth-10);
      x := -2;
      y := 1;
    end;
    hiBottomLeft :
    begin
      HintRect := Rect(0,0+LinkSize,Width-ShadowWidth, Height-ShadowWidth);
      ShadowRect := Rect(0+ShadowWidth,0+LinkSize+ShadowWidth,Width,Height);
      if HintStyle=hiBubble then
      begin
        HintPoint[0] := Point(width-trunc(width/3)-ShadowWidth,
                              LinkSize+trunc((Height-ShadowWidth-LinkSize)/2));
        HintPoint[1] := Point(width-ShadowWidth,0);
        HintPoint[2] := Point(width-trunc(width/3)-trunc(width/3)-ShadowWidth,
                              LinkSize+trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[0] := Point(width-trunc(width/3),
                                LinkSize+ShadowWidth+trunc((Height-ShadowWidth-LinkSize)/2));
        ShadowPoint[1] := Point(width,ShadowWidth);
        ShadowPoint[2] := Point(width-trunc(width/3)-trunc(width/3),
                                LinkSize+ShadowWidth+trunc((Height-ShadowWidth-LinkSize)/2));
      end else
      begin
        HintPoint[0] := Point(width-10-ShadowWidth,LinkSize+2);
        HintPoint[1] := Point(width-ShadowWidth,0);
        HintPoint[2] := Point(width-30-ShadowWidth,LinkSize+2);
        ShadowPoint[0] := Point(width-10,LinkSize+ShadowWidth);
        ShadowPoint[1] := Point(width,ShadowWidth);
        ShadowPoint[2] := Point(width-30,LinkSize+ShadowWidth);
      end;
      BRect[0] := Rect(width-ShadowWidth-6,0,width-ShadowWidth,6);
      BRect[1] := Rect(width-ShadowWidth-17,2,width-ShadowWidth-7,12);
      BRect[2] := Rect(width-ShadowWidth-30,10,width-ShadowWidth-15,25);
      x := -2;
      y := -1;
    end;
  end;
  with cv do
  begin
    Pen.Style := psSolid;
    Pen.Width := 1;
    Brush.Style := bsSolid;
    if ShadowWidth>0 then
    begin
      case HintStyle of
        hiRectangle : ShadowRgn := CreateRectRgn(ShadowRect.left,ShadowRect.top,ShadowRect.right,ShadowRect.bottom-1);
        hiRoundrect : ShadowRgn := CreateRoundRectRgn(ShadowRect.left,ShadowRect.top,ShadowRect.right,ShadowRect.bottom,15,15);
        hiBubble : ShadowRgn := CreateEllipticRgn(ShadowRect.left,ShadowRect.top,ShadowRect.right,ShadowRect.bottom);
        hiImage : ShadowRgn := CreateRectRgn(ShadowRect.left,ShadowRect.top,ShadowRect.right,ShadowRect.bottom);
        hiTexture : ShadowRgn := CreateRectRgn(ShadowRect.left,ShadowRect.top,ShadowRect.right,ShadowRect.bottom);
      end;
      PaintShadow(cv.handle,ShadowRect,ShadowRgn,ShadowQuality,ShadowIntensity);
      DeleteObject(ShadowRgn);
      case LinkStyle of
        liBubble:
        begin
          ShadowRgn := CreateEllipticRgn(BRect[0].left+ShadowWidth,BRect[0].top+ShadowWidth,
                                         BRect[0].right+ShadowWidth,BRect[0].bottom+ShadowWidth);
          RectTmp := Rect(BRect[0].left+ShadowWidth,BRect[0].top+ShadowWidth,
                          BRect[0].right+ShadowWidth,BRect[0].bottom+ShadowWidth);
          PaintShadow(cv.handle,RectTmp,ShadowRgn,ShadowQuality,ShadowIntensity);
          DeleteObject(ShadowRgn);
          ShadowRgn := CreateEllipticRgn(BRect[1].left+ShadowWidth,BRect[1].top+ShadowWidth,
                                         BRect[1].right+ShadowWidth,BRect[1].bottom+ShadowWidth);
          RectTmp := Rect(BRect[1].left+ShadowWidth,BRect[1].top+ShadowWidth,
                          BRect[1].right+ShadowWidth,BRect[1].bottom+ShadowWidth);
          PaintShadow(cv.handle,RectTmp,ShadowRgn,ShadowQuality,ShadowIntensity);
          DeleteObject(ShadowRgn);
          ShadowRgn := CreateEllipticRgn(BRect[2].left+ShadowWidth,BRect[2].top+ShadowWidth,
                                         BRect[2].right+ShadowWidth,BRect[2].bottom+ShadowWidth);
          RectTmp := Rect(BRect[2].left+ShadowWidth,BRect[2].top+ShadowWidth,
                          BRect[2].right+ShadowWidth,BRect[2].bottom+ShadowWidth);
          PaintShadow(cv.handle,RectTmp,ShadowRgn,ShadowQuality,ShadowIntensity);
          DeleteObject(ShadowRgn);
        end;
        liArrow:
        begin
          ShadowRgn := CreatePolygonRgn(ShadowPoint,3,Winding);
          ShadowRgn_ := CreateEllipticRgn(ShadowRect.left,ShadowRect.top,ShadowRect.right,ShadowRect.bottom);
          case Position of
            hiTopRight : RectTmp := Rect(ShadowPoint[1].x,ShadowPoint[0].y,ShadowPoint[2].x,ShadowPoint[1].y);
            hiBottomRight : RectTmp := Rect(ShadowPoint[1].x,ShadowPoint[1].y,ShadowPoint[2].x,ShadowPoint[0].y);
            hiTopLeft : RectTmp := Rect(ShadowPoint[2].x,ShadowPoint[0].y,ShadowPoint[1].x,ShadowPoint[1].y);
            hiBottomLeft : RectTmp := Rect(ShadowPoint[2].x,ShadowPoint[1].y,ShadowPoint[1].x,ShadowPoint[0].y);
          end;
          PaintShadow_(cv.handle,RectTmp,ShadowRgn,ShadowRgn_,ShadowQuality,ShadowIntensity);
          DeleteObject(ShadowRgn);
          DeleteObject(ShadowRgn_);
        end;
      end;
    end;
    Brush.Style := bsSolid;
    Pen.Color := Color;
    Brush.Color := Color;
    ColorTmp := BorderColor;
    if Border then Pen.Color := BorderColor;

    case HintStyle of
      hiRectangle : Rectangle(HintRect.left, HintRect.top, HintRect.right, HintRect.bottom);
      hiRoundrect : RoundRect(HintRect.left, HintRect.top, HintRect.right, HintRect.bottom,15,15);
      hiBubble : Ellipse(HintRect.left, HintRect.top, HintRect.right, HintRect.bottom);
      hiImage :
      begin
        if Border then
        begin
          Pen.Style := psSolid;
          Brush.Style := bsClear;
          Rectangle(HintRect.left, HintRect.top, HintRect.right, HintRect.bottom);
          DrawBitmap(handle,HintRect.left+1,HintRect.top+1,bitmap);
        end else DrawBitmap(handle,HintRect.left,HintRect.top,bitmap);
      end;
      hiTexture :
      begin
        Brush.Style := bsClear;
        if Border then
        begin
          Pen.Style := psSolid;
          Rectangle(HintRect.left, HintRect.top, HintRect.right, HintRect.bottom);
          DrawMosaic(handle,HintRect.left+1,HintRect.top+1,HintRect.right-2,HintRect.bottom-2,bitmap);
        end else DrawMosaic(handle,HintRect.left,HintRect.top,HintRect.right,HintRect.bottom,bitmap);
      end;
      hiText :
      if Shadow then
      begin
        ShadowRgn := CreateRectRgn(HintRect.left, HintRect.top, HintRect.right, HintRect.bottom);
        PaintShadow(cv.handle,HintRect,ShadowRgn,ShadowQuality,ShadowIntensity);
        DeleteObject(ShadowRgn);
      end;
    end;

    if LinkStyle=liArrow then
    begin
      Polygon(HintPoint);
    end;
    if LinkStyle=liBubble then
    begin
      Ellipse(BRect[0].left,BRect[0].top,BRect[0].right,BRect[0].bottom);
      Ellipse(BRect[1].left,BRect[1].top,BRect[1].right,BRect[1].bottom);
      Ellipse(BRect[2].left,BRect[2].top,BRect[2].right,BRect[2].bottom);
    end;
    Pen.Style := psClear;

    case HintStyle of
      hiRectangle : Rectangle(HintRect.left+1, HintRect.top+1, HintRect.right, HintRect.bottom);
      hiRoundrect : RoundRect(HintRect.left+1, HintRect.top+1, HintRect.right, HintRect.bottom,15,15);
      hiBubble : Ellipse(HintRect.left+1, HintRect.top+1, HintRect.right, HintRect.bottom);
    end;

    SetBkMode(Handle,Transparent);
    StrPCopy(Text, Caption);
    Case HintStyle of
      hiRectangle:
      begin
        inc(HintRect.left,2);
        dec(HintRect.right,2);
      end;
      hiRoundRect:
      begin
        inc(HintRect.left,3);
        dec(HintRect.right,3);
      end;
      hiBubble:
      begin
        inc(HintRect.left,trunc(RealTextHeight/2));
        dec(HintRect.right,trunc(RealTextHeight/2));
        inc(HintRect.top,trunc((HintRect.Bottom-HintRect.Top-RealTextHeight)/2));
      end;
      hiImage:
      begin
        inc(HintRect.left,5);
        dec(HintRect.right,5);
        inc(HintRect.top,5);
        dec(HintRect.bottom,5);
      end;
      hiTexture:
      begin
        inc(HintRect.left,2);
        dec(HintRect.right,2);
      end;
    end;
    Font.Color := HintFont.Color;
    if HintFont.size<=30 then Font.size := HintFont.size else Font.size := 30;
    Font.Style := HintFont.Style;
    Font.Name := HintFont.Name;
    DrawText(Handle, Text, StrLen(Text), HintRect, DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
  end;
  Cv.free;
end;

// TMainMessenger

Constructor TSignalThread.Create(MailSlot : TMainMessenger);
Begin
  Inherited Create(False);
  Priority := tpNormal;
  FMailSlot := MailSlot;
end;

Procedure TSignalThread.Execute;
Begin
  While Not Terminated do
  Begin
    GetMailSlotInfo(FMailSlot.LocalHandle,NIL, FMailSlot.NextMsgSize,
                    @FMailSlot.MsgCount, NIL);
    If FMailSLot.MsgCount > 0 Then
      Synchronize(FMailSLot.ReadMessage);
    Sleep(1);
  end;
end;

Constructor TTimerThread.Create(MailSlot : TMainMessenger);
Begin
  Inherited Create(False);
  Priority := tpNormal;
  FMailSlot := MailSlot;
end;

Procedure TTimerThread.Execute;
Begin
  While Not Terminated do begin
    Synchronize(FMailSLot.DoTimer);
    Sleep(FMailslot.FInterval);
  end;
end;

Procedure TMainMessenger.DoTimer;
begin
 if assigned(FTimer) then FTimer(Self);
end;

Constructor TMainMessenger.Create(AOwner : TComponent);
var
 temp : array[0..255] of char;
 len : DWord;//integer;
Begin
  Inherited Create(AOwner);
  FBoxName := 'SignalBox';
  FInterval := 1000;
  FWaitThread := NIL;
  FTimerThread := NIL;
  len := 255;
  GetComputerName(temp,len);
  FComputer := StrPas(temp);
  len := 255;
  GetUserName(temp,len);
  FUser := StrPas(temp);
  OutStrings := TStringList.Create;
  InStrings := TStringList.Create;
  UserList := TStringList.Create;
  MemoLines := TStringList.Create;
end;

Destructor TMainMessenger.Destroy;
begin
 if ActiveFlag = true then DeActivate;
 UserList.Free;
 OutStrings.Free;
 InStrings.Free;
 MemoLines.Free;
 inherited Destroy;
end;

Procedure TMainMessenger.Activate;
var
 i,j : integer;
begin
 If ActiveFlag = true then begin
  //DoErrorReport('You tried to Activate an active TMessenger component');
  exit;
 end;
 FWaitThread := TSignalThread.Create(Self);
 if FWaitThread = nil then begin
  DoErrorReport('Could not Start TMessenger Timer Thread');
  exit;
 end;
 FTimerThread := TTimerThread.Create(Self);
 Server := '.';
 LocalPath := '\\' + Server + '\mailslot\' + FBoxName;
 LocalHandle := CreateMailSlot(PChar(LocalPath),MaxMsgSize,0,nil);
 if LocalHandle = INVALID_HANDLE_VALUE then begin
  FWaitThread.Terminate;
  FWaitThread := nil;
  FTimerThread.Terminate;
  FTimerThread := nil;
  DoErrorReport('Could not Create Mail Slot');
  exit;
 end;
 SendCommand('*','ONLINE_NOTIFY');
 ActiveFlag := true;
end;

Procedure TMainMessenger.DeActivate;
begin
 if ActiveFlag = false then begin
  DoErrorReport('Cannot Deactivate an Inactive TMessenger Component');
  exit;
 end;
 if FWaitThread <> nil then begin
  FWaitThread.Terminate;
  FWaitThread := nil;
 end;
 if FTimerThread <> nil then begin
  FTimerThread.Terminate;
  FTimerThread := nil;
 end;
 CloseHandle(LocalHandle);
 SendCommand('*','OFFLINE_NOTIFY');
 ActiveFlag := False;
end;

Procedure TMainMessenger.SetName(const NewName: TComponentName);
Begin
  Inherited SetName(NewName);
end;

Procedure TMainMessenger.SetBoxName(NewName : string);
begin
 if FBoxName <> NewName then begin
  FBoxName := NewName;
  if ActiveFlag = true then begin
   DeActivate;
   Activate;
  end;
 end;
end;

Procedure TMainMessenger.SetInterval(Time : word);
begin
 if FInterval <> Time then  FInterval := Time;
end;

Procedure TMainMessenger.ReadMessage;
var
 i : integer;
begin
 Instrings.Clear;
 SetLength(NewLine,NextMsgSize);
 ReadFile(LocalHandle,PChar(NewLine)^,NextMsgSize,MsgSize,nil);
 Instrings.Text := NewLine;
 FWaitThread.Suspend;
 if Instrings.Count > 3 then begin
  MsgType := Instrings[0];
  MsgTime := Instrings[1];
  MsgSender := Instrings[2];
  MsgText := Instrings[3];
 end;
 if Instrings.Count > 5 then begin
  MemoLines.Clear;
  for i := 4 to Instrings.Count - 2 do begin
   MemoLines.Add(Instrings[i]);
  end;
 end;
 if MsgType = 'COMMAND_MSG' then ProcessCommand;
 if MsgType = 'LINE_MSG' then DoLineArrival(MsgSender,MsgTime,MsgText);
 if MsgType = 'MEMO_MSG' then DoMemoArrival(MsgSender,MsgTime,MemoLines);
 Instrings.Clear;
 FWaitThread.Resume;
end;

Procedure TMainMessenger.ProcessCommand;
begin
 if MsgSender = FComputer then exit;
 if MsgText = 'ONLINE_NOTIFY' then begin
  AddUser(MsgSender);
  SendCommand(MsgSender,'ONLINE_RESPONSE');
 end;
 if MsgText = 'ONLINE_RESPONSE' then AddUser(MsgSender);
 if MsgText = 'OFFLINE_NOTIFY' then DeleteUser(MsgSender);
end;

Procedure TMainMessenger.AddUser(Name : string);
var
 i : Integer;
 j : boolean;
begin
 j := false;
 if UserList.Count > 0 then begin
  for i := 0 to UserList.Count - 1 do begin
   if UserList[i] = Name then j := true;
  end;
 end;
 if j = true then exit;
 UserList.Add(Name);
 DoUserListChange(UserList);
end;

Procedure TMainMessenger.DeleteUser(Name : string);
var
 i,Num : Integer;
 j : boolean;
begin
 j := false;
 Num := 0;
 if UserList.Count > 0 then begin
  for i := 0 to UserList.Count - 1 do begin
   if UserList[i] = Name then begin
    j := true;
    Num := i;
   end;
  end;
 end;
 if j = false then exit;
 UserList.Delete(Num);
 DoUserListChange(UserList);
end;

Procedure TMainMessenger.SendOutStrings(Recipient : string);
var
 len : DWORD;
begin
 if OutStrings.Count > 0 then begin
  RemotePath := '\\' + Recipient + '\mailslot\' + FBoxName;
  RemoteHandle := CreateFile(PChar(RemotePath),GENERIC_WRITE,FILE_SHARE_READ,
                               nil,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
  if RemoteHandle = INVALID_HANDLE_VALUE then begin
   DoErrorReport('Could not Open a Remote Mail Slot');
   exit;
  end;
  WriteFile(RemoteHandle,Pointer(Outstrings.text)^,Length(OutStrings.text),len,nil);
  OutStrings.Clear;
 end;
end;

Procedure TMainMessenger.SendLine(Recipient,Text : string);
begin
 if Recipient = '*' then exit;
 Outstrings.Add('LINE_MSG');
 Outstrings.Add(TimeToStr(Time));
 OutStrings.Add(FComputer);
 OutStrings.Add(text);
 OutStrings.Add('END_MESSAGE');
 SendOutStrings(Recipient);
end;

Procedure TMainMessenger.Broadcast(text : string);
begin
 Outstrings.Add('LINE_MSG');
 Outstrings.Add(TimeToStr(Time));
 OutStrings.Add(FComputer);
 OutStrings.Add(text);
 OutStrings.Add('END_MESSAGE');
 SendOutStrings('*');
end;

Procedure TMainMessenger.SendMemo(Recipient : string;Lines : TStrings);
var
 i : integer;
begin
 if Recipient = '*' then exit;
 Outstrings.Add('MEMO_MSG');
 Outstrings.Add(TimeToStr(Time));
 OutStrings.Add(FComputer);
 OutStrings.Add('BEGIN_MEMO');
 if Lines.Count > 0 then begin
  for i := 0 to Lines.Count -1 do begin
    OutStrings.Add(Lines[i]);
  end;
 end;
 OutStrings.Add('END_MESSAGE');
 SendOutStrings(Recipient);
end;

Procedure TMainMessenger.SendCommand(Recipient,Command : string);
begin
 Outstrings.Add('COMMAND_MSG');
 Outstrings.Add(TimeToStr(Time));
 OutStrings.Add(FComputer);
 OutStrings.Add(Command);
 OutStrings.Add('END_MESSAGE');
 SendOutStrings(Recipient);
end;

Procedure TMainMessenger.DoLineArrival(const FMSender,FMTime,FMText : string);
begin
 if Assigned(FLineArrival) then FLineArrival(Self,MsgSender,MsgTime,MsgText);
end;

Procedure TMainMessenger.DoMemoArrival(const FMSender,FMTime : string;MLines : Tstrings);
begin
  if Assigned(FMemoArrival) then FMemoArrival(Self,MsgSender,MsgTime,MemoLines);
end;

Procedure TMainMessenger.DoUserListChange(Const CompList : TStringList);
begin
 If Assigned(FUserListChange) Then FUserListChange(Self,CompList);
end;

Procedure TMainMessenger.DoErrorReport(const Error : string);
begin
  If Assigned(FError) Then FError(Self,Error);
end;

end.
