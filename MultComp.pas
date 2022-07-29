unit MultComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, Dialogs, ExtDlgs, Grids;

type
  TTipos = (TpBevel, TpButton, TpCheckBox, TpComboBox, TpDBEdit, TpDBGrid,
            TpEdit, TpGroupBox, TpImage, TpLabel, TpMemo, TpPainel, TpProgressBar,
            TpRadioGroup, TpSpinEdit, TpListBox);

  TMultComp = class(TPanel)
  private
    { Private declarations }
    //Variáveis para teste
    FTipos      : TTipos;
    FSelecionado: Boolean;
    FCdTipo     : Integer;

    FLMinWidth  : Integer;
    FLMinHeight : Integer;
    FLMinTop    : Integer;
    FLMinLeft   : Integer;
    FLOrdem     : Integer;

    TopA        : TShape;
    TopB        : TShape;
    HeightA     : TShape;
    HeightB     : TShape;
    CenterA     : TShape;
    CenterB     : TShape;
    CenterC     : TShape;
    CenterD     : TShape;
    //Retangulo   : TShape;

    //Navegador da localização
    PainelPosit : TPanel;

    //Procedure de Consistências
    procedure SetTipo(Value: TTipos);
    procedure MontaCaraComp;
    procedure SnSelecionado(Value: Boolean);
    procedure AtualizaLocal(Sender: TObject);

    //Controle do tamanho do componente
    procedure ReziseTopA(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ReziseTopB(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure ReziseHeightA(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ReziseHeightB(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure ReziseCenterA(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ReziseCenterB(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ReziseCenterC(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ReziseCenterD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    //Controle para movimentação do componente
    procedure MoverAcima(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AoMover(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MoverAbaixo(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    //Evento de seleção
    procedure AoClicar(Sender: TObject);
    procedure DrawRec(Sender: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    ImageG : TImage;
    GroupG : TGroupBox ;
    GridG  : TStringGrid;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property CdTipo : Integer read FCdTipo write FCdTipo;
    property LMinWidth : Integer read FLMinWidth write FLMinWidth;
    property LMinHeight : Integer read FLMinHeight write FLMinHeight;
    property LMinTop : Integer read FLMinTop write FLMinTop;
    property LMinLeft : Integer read FLMinLeft write FLMinLeft;
    property Ordem : Integer read FLOrdem write FLOrdem;
    property Tipo : TTipos read FTipos write SetTipo default TpBevel;
    property Selecionado : Boolean read FSelecionado write SnSelecionado default False;
  end;

implementation
{$R *.RES}

uses DEntrada;

var SnMover : Boolean;
    xt      : Integer;
    yt      : Integer;
    TopIni  : Integer;
    LeftIni : Integer;
    xLeft   : Integer;
    xTop    : Integer;

constructor TMultComp.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Caption     := ' ';
  OnResize    := AtualizaLocal;
  OnMouseDown := MoverAbaixo;
  OnMouseMove := AoMover;
  OnMouseUp   := MoverAcima;
  OnClick     := AoClicar;

  PainelPosit := TPanel.Create(Nil);
  with PainelPosit do
  begin
    Height := 20;
    Width  := 58;
    Visible:= False;
    Color  := clInfoBk;
  end;

  FLMinWidth  := 15;
  FLMinHeight := 15;
  FLMinTop    :=  0;
  FLMinLeft   :=  0;

  TopIni      :=  0;
  LeftIni     :=  0;
  SnMover     := False;

  Color        := clSilver;
  BorderStyle  := bsNone;
  BevelInner   := bvLowered;
  BevelOuter   := bvNone;
  Height       := 040;
  Width        := 185;
  Alignment    := taLeftJustify;
  FCdTipo      := 0;

  GridG  := TStringGrid.Create(Nil);
  with GridG do
  begin
    ScrollBars      := ssBoth;
    Parent          := Self;
    Enabled         := False;
    FixedCols       := 0;
    RowCount        := 5;
    ColCount        := 5;
    DefaultColWidth := 75;
    DefaultRowHeight:= 17;
    Options         := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goColSizing,goThumbTracking];
    OnMouseDown     := Self.OnMouseDown;
    OnMouseMove     := Self.OnMouseMove;
    OnMouseUp       := Self.OnMouseUp;
    OnClick         := Self.OnClick;
    Visible         := False;
  end;

  ImageG := TImage.Create(Nil);
  with ImageG do
  begin
    Parent      := Self;
    OnMouseDown := Self.OnMouseDown;
    OnMouseMove := Self.OnMouseMove;
    OnMouseUp   := Self.OnMouseUp;
    OnClick     := Self.OnClick;
  end;

  GroupG := TGroupBox.Create(Nil);
  with GroupG do
  begin
    Parent      := Self;
    Align       := alClient;
    OnMouseDown := Self.OnMouseDown;
    OnMouseMove := Self.OnMouseMove;
    OnMouseUp   := Self.OnMouseUp;
    OnClick     := AoClicar;
    Visible     := False;
  end;

  {Retangulo     := TShape.Create(Nil);
  with Retangulo do
  begin
    Parent      := Self;
    Brush.Color := ClWhite;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crDefault;
    Pen.Style   := psSolid;
    Pen.Mode    := pmMergeNotPen;
    onMouseDown := MoverAbaixo;
    onMouseMove := AoMover;
    onMouseUp   := MoverAcima;
  end;}

  TopA    := TShape.Create(Nil);
  with TopA do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeNWSE;
    OnMouseUp   := ReziseTopA;
  end;

  TopB    := TShape.Create(Nil);
  with TopB do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeNESW;
    OnMouseUp   := ReziseTopB;
  end;

  HeightA := TShape.Create(Nil);
  with HeightA do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeNESW;
    OnMouseUp   := ReziseHeightA;
  end;

  HeightB := TShape.Create(Nil);
  with HeightB do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeNWSE;
    OnMouseUp   := ReziseHeightB;
  end;

  CenterA := TShape.Create(Nil);
  with CenterA do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeNS;
    OnMouseUp   := ReziseCenterA;
  end;

  CenterB := TShape.Create(Nil);
  with CenterB do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeNS;
    OnMouseUp   := ReziseCenterB;
  end;

  CenterC := TShape.Create(Nil);
  with CenterC do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeWE;
    OnMouseUp   := ReziseCenterC;
  end;

  CenterD := TShape.Create(Nil);
  with CenterD do
  begin
    Parent      := Self;
    Brush.Color := ClBlue;
    Height      := 5;
    Width       := 6;
    Visible     := False;
    Cursor      := crSizeWE;
    OnMouseUp   := ReziseCenterD;
  end;
end;

destructor TMultComp.Destroy;
begin
  {Retangulo.Parent := Self;}
  TopA.Parent      := Self;
  TopB.Parent      := Self;
  HeightA.Parent   := Self;
  HeightB.Parent   := Self;
  CenterA.Parent   := Self;
  CenterB.Parent   := Self;
  CenterC.Parent   := Self;
  CenterD.Parent   := Self;

  ImageG.Destroy;
  GroupG.Destroy;
  GridG.Destroy;
  {Retangulo.Destroy;}
  TopA.Destroy;
  TopB.Destroy;
  HeightA.Destroy;
  HeightB.Destroy;
  CenterA.Destroy;
  CenterB.Destroy;
  CenterC.Destroy;
  CenterD.Destroy;
  inherited
end;

procedure TMultComp.SetTipo(Value: TTipos);
begin
  if FTipos <> Value then
  begin
    FTipos := Value;
    MontaCaraComp;
  end;
end;

procedure TMultComp.MontaCaraComp;
var ResName : String;
    BmpRes  : tbitmap;
begin
  ImageG.Visible := False;
  GroupG.Visible := False;
  GridG.Visible  := False;

  {Retangulo.Parent := Self;}
  TopA.Parent      := Self;
  TopB.Parent      := Self;
  HeightA.Parent   := Self;
  HeightB.Parent   := Self;
  CenterA.Parent   := Self;
  CenterB.Parent   := Self;
  CenterC.Parent   := Self;
  CenterD.Parent   := Self;

  case FTipos of
    TpBevel  : begin
                 Color        := clSilver;
                 BorderStyle  := bsNone;
                 BevelInner   := bvLowered;
                 BevelOuter   := bvNone;
                 Height       := 040;
                 Width        := 185;
                 Alignment    := taLeftJustify;
                 FCdTipo      := 0;
               end;

    TpButton:begin
               Color          := clSilver;
               BorderStyle    := bsNone;
               BevelInner     := bvRaised;
               BevelOuter     := bvRaised;
               Alignment      := taCenter;
               Width          := 75;
               Height         := 25;
               FCdTipo        := 1;
             end;

    TpCheckBox: begin
                  Color          := clSilver;
                  BorderStyle    := bsNone;
                  BevelInner     := bvNone;
                  BevelOuter     := bvNone;
                  Alignment      := taCenter;
                  FCdTipo        := 2;

                  with ImageG do
                  begin
                    Stretch     := False;
                    Center      := True;
                    Align       := alLeft;
                    Visible     := True;
                    Width       := 14;
                    BmpRes      := TBitmap.Create;
                    FmtStr(ResName, 'TMS%s', ['CHECKBOX']);
                    BmpRes.LoadFromResourceName(HInstance, ResName);
                    Picture.Graphic := BmpRes;
                    BmpRes.Destroy;
                  end;
                end;

    TpComboBox: begin
                  Color        := clWhite;
                  BorderStyle  := bsNone;
                  BevelInner   := bvLowered;
                  BevelOuter   := bvNone;
                  Height       := 021;
                  Width        := 150;
                  Alignment    := taLeftJustify;
                  FCdTipo      := 3;

                  with ImageG do
                  begin
                    Stretch     := True;
                    Center      := True;
                    Align       := alRight;
                    Visible     := True;
                    Width       := 21;
                    BmpRes      := TBitmap.Create;
                    FmtStr(ResName, 'TMS%s', ['COMBOBOX']);
                    BmpRes.LoadFromResourceName(HInstance, ResName);
                    Picture.Graphic := BmpRes;
                    BmpRes.Destroy;
                  end;
                end;

     TpDBGrid :begin
                 Color          := clSilver;
                 BorderStyle    := bsNone;
                 BevelInner     := bvNone;
                 BevelOuter     := bvNone;
                 Height         := 150;
                 Width          := 200;
                 Alignment      := taLeftJustify;
                 GridG.Visible  := True;
                 FCdTipo        := 5;
               end;

     TpEdit, TpDBEdit :
               begin
                 Color        := clWhite;
                 BorderStyle  := bsNone;
                 BevelInner   := bvLowered;
                 BevelOuter   := bvLowered;
                 Height       := 021;
                 Width        := 150;
                 Alignment    := taLeftJustify;
                 if FTipos = TpEdit then
                   FCdTipo      := 6 else
                   FCdTipo      := 4;
               end;

     TpGroupBox, TpRadioGroup:
               begin
                 {Retangulo.Parent := GroupG;}
                 TopA.Parent    := GroupG;
                 TopB.Parent    := GroupG;
                 HeightA.Parent := GroupG;
                 HeightB.Parent := GroupG;
                 CenterA.Parent := GroupG;
                 CenterB.Parent := GroupG;
                 CenterC.Parent := GroupG;
                 CenterD.Parent := GroupG;

                 Color          := clSilver;
                 BorderStyle    := bsNone;
                 BevelInner     := bvNone;
                 BevelOuter     := bvNone;
                 Height         := 105;
                 Width          := 185;
                 GroupG.Visible := True;
                 GroupG.Caption := Caption;
                 if FTipos = TpGroupBox then
                   FCdTipo        := 7
                 else
                   FCdTipo        := 13;
               end;

    TpImage: begin
               Width          := 75;
               Height         := 75;
               FCdTipo        := 8;
             end;

    TpLabel :begin
               Height         := 21;
               Color          := clSilver;
               BorderStyle    := bsNone;
               BevelInner     := bvNone;
               BevelOuter     := bvNone;
               Alignment      := taLeftJustify;
               FCdTipo        := 9;
             end;

    TpMemo   : begin
                 Color        := clWhite;
                 BorderStyle  := bsNone;
                 BevelInner   := bvLowered;
                 BevelOuter   := bvLowered;
                 Height       := 100;
                 Width        := 300;
                 Alignment    := taLeftJustify;
                 FCdTipo      := 10;
               end;

    TpPainel:begin
               Color          := clSilver;
               BorderStyle    := bsNone;
               BevelInner     := bvNone;
               BevelOuter     := bvRaised;
               Height         := 040;
               Width          := 185;
               Alignment      := taCenter;
               FCdTipo        := 11;
             end;

    TpProgressBar:
               begin
                  Color        := clWhite;
                  BorderStyle  := bsNone;
                  BevelInner   := bvLowered;
                  BevelOuter   := bvNone;
                  Height       := 020;
                  Width        := 154;
                  Alignment    := taLeftJustify;
                  FCdTipo      := 12;

                  with ImageG do
                  begin
                    Stretch     := True;
                    Center      := False;
                    Align       := alClient;
                    Visible     := True;
                    BmpRes      := TBitmap.Create;
                    FmtStr(ResName, 'TMS%s', ['PROGRESSBAR']);
                    BmpRes.LoadFromResourceName(HInstance, ResName);
                    Picture.Graphic := BmpRes;
                    BmpRes.Destroy;
                  end;
                end;

    TpSpinEdit: begin
                  Color        := clWhite;
                  BorderStyle  := bsNone;
                  BevelInner   := bvLowered;
                  BevelOuter   := bvLowered;
                  Height       := 021;
                  Width        := 150;
                  Alignment    := taLeftJustify;
                  FCdTipo      := 14;

                  with ImageG do
                  begin
                    Stretch     := True;
                    Center      := False;
                    Align       := alRight;
                    Parent      := Self;
                    Visible     := True;
                    Width       := 21;
                    BmpRes      := TBitmap.Create;
                    FmtStr(ResName, 'TMS%s', ['SPINEDIT']);
                    BmpRes.LoadFromResourceName(HInstance, ResName);
                    Picture.Graphic := BmpRes;
                    BmpRes.Destroy;
                  end;
                end;

    TpListBox:  begin
                 Color        := clWhite;
                 BorderStyle  := bsNone;
                 BevelInner   := bvLowered;
                 BevelOuter   := bvLowered;
                 Height       := 100;
                 Width        := 300;
                 Alignment    := taLeftJustify;
                 FCdTipo      := 10;
               end;
  end;
end;

procedure TMultComp.SnSelecionado(Value: Boolean);
begin
  {Retangulo.Visible := Value;}
  TopA.Visible    := Value;
  TopB.Visible    := Value;
  HeightA.Visible := Value;
  HeightB.Visible := Value;
  CenterA.Visible := Value;
  CenterB.Visible := Value;
  CenterC.Visible := Value;
  CenterD.Visible := Value;
  FSelecionado    := Value;
end;

procedure TMultComp.AtualizaLocal(Sender: TObject);
begin
  {Retangulo.Left := 0;
  Retangulo.Top  := 0;
  Retangulo.Width := Width;
  Retangulo.Height:= Height;}

  TopA.top    := 0;
  TopA.left   := 0;

  CenterC.top    := Round(Height / 2) - 2;
  CenterC.left   := 0;

  TopB.top    := 0;
  TopB.left   := Width - 7;

  CenterA.top    := 0;
  CenterA.left   := Round(Width / 2) - 2;

  HeightA.left   := 0;
  HeightA.Top    := Height - 7;

  HeightB.left   := Width - 7;
  HeightB.top    := Height - 7;

  CenterB.Left   := Round(Width / 2) - 2;
  CenterB.top    := Height - 7;

  CenterD.top    := Round(Height / 2) - 2;
  CenterD.left   := Width - 7;

  if FTipos = TpDBGrid then
  begin
    GridG.Top   := 3;
    GridG.Left  := 3;
    GridG.Width := Width  - 10;
    GridG.Height:= Height - 10;
  end;
end;

procedure TMultComp.ReziseTopA(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseTopA');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Top   := top    + y;
    Width := Width  - x;
    Height:= Height - y;
    left  := left   + x;
  end;

  if Height < LMinHeight
  then begin
    Height := LMinHeight;
  end;

  if Width < LMinWidth
  then begin
    Width := LMinWidth;
  end;

  if Top < LMinTop
  then begin
    Top := LMinTop;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseTopB(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseTopB');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Top    := Top    + y;
    Width  := Width  + x;
    Height := Height - y;
  end;

  if Top < lminTop
  then begin
    Top := lminTop;
  end;

  if Width < lminWidth
  then begin
    Width := lminWidth;
  end;

  if Height < lminHeight
  then begin
    Height := lminHeight;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseHeightA(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseHeightA');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Height := Height + y;
    Width  := Width  - x;
    Left   := Left   + x;
  end;

  if Height < lminHeight
  then begin
    Height := lminHeight;
  end;

  if Width < lminWidth
  then begin
    Width := lminWidth;
  end;

  if Left < lminLeft
  then begin
    Left := lminLeft;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseHeightB(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseHeightB');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Height := Height + y;
    Width  := Width  + x;
  end;

  if Height < lminHeight
  then begin
    Height := lminHeight;
  end;

  if Width < lminWidth
  then begin
    Width := lminWidth;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseCenterA(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseCenterA');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Top   := top    + y;
    Height:= Height - y;
  end;

  if Height < LMinHeight
  then begin
    Height := LMinHeight;
  end;

  if Top < LMinTop
  then begin
    Top := LMinTop;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseCenterB(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseCenterB');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Height := Height + y;
  end;

  if Height < lminHeight
  then begin
    Height := lminHeight;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseCenterC(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseCenterC');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Width := Width - x;
    left  := left  + x;
  end;

  if Height < LMinHeight
  then begin
    Height := LMinHeight;
  end;

  if Width < LMinWidth
  then begin
    Width := LMinWidth;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

procedure TMultComp.ReziseCenterD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  {ShowMessage('ReziseCenterD');}
  xt := x;
  yt := y;
  if (Abs(xt) >= 1) and (Abs(yt) >= 1)
  then begin
    Width := Width + x;
  end;

  if Width < LMinWidth
  then begin
    Width := LMinWidth;
  end;

  if FTipos = TpComboBox then
    Height := 21;
end;

{  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TMultComp)
    then begin
      if ((Components[I] as TMultComp).Selecionado) then
      begin
        if Shift = ([ssCtrl]) then
        begin
          case Key of
            37: (Components[I] as TMultComp).Left := (Components[I] as TMultComp).Left - 1;
            38: (Components[I] as TMultComp).Top  := (Components[I] as TMultComp).Top  - 1;
            39: (Components[I] as TMultComp).Left := (Components[I] as TMultComp).Left + 1;
            40: (Components[I] as TMultComp).Top  := (Components[I] as TMultComp).Top  + 1;
          end;
        end else begin
          if Shift = ([ssShift])
          then begin
            case Key of
              37: (Components[I] as TMultComp).Width := (Components[I] as TMultComp).Width  - 1;
              38: (Components[I] as TMultComp).Height:= (Components[I] as TMultComp).Height - 1;
              39: (Components[I] as TMultComp).Width := (Components[I] as TMultComp).Width  + 1;
              40: (Components[I] as TMultComp).Height:= (Components[I] as TMultComp).Height + 1;
            end;
          end else begin
            if Shift = ([ssShift,ssCtrl])
            then begin
              case Key of
                37: (Components[I] as TMultComp).Left := (Components[I] as TMultComp).Left - 8;
                38: (Components[I] as TMultComp).Top  := (Components[I] as TMultComp).Top  - 8;
                39: (Components[I] as TMultComp).Left := (Components[I] as TMultComp).Left + 8;
                40: (Components[I] as TMultComp).Top  := (Components[I] as TMultComp).Top  + 8;
              end;
            end;
          end;
        end;
      end;
    end;
  end;}

procedure TMultComp.MoverAcima(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  snmover := False;
  PainelPosit.Visible:= False;
  ClipCursor(nil);
  TMultComp(Sender).Left := xLeft;
  TMultComp(Sender).Top  := xTop;
end;

procedure TMultComp.AoMover(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if snmover then
  begin
    PainelPosit.Top     := Top  + Height + 5;
    PainelPosit.Left    := Left + Width - PainelPosit.Width;
    {PainelPosit.Caption := FormatFloat('000', Left) + ', ' + FormatFloat('000', Top);}
    PainelPosit.Caption := IntToStr(Left) + ', ' + IntToStr(Top);
    {Left := Left+X-LeftIni;
    Top  := Top +Y-TopIni;}
    xLeft := TMultComp(Sender).Left+X-LeftIni;
    xtop  := TMultComp(Sender).Top +Y-TopIni;
    DrawRec(Sender);
  end;
end;

procedure TMultComp.MoverAbaixo(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Rect: TRect;
begin
  PainelPosit.Visible:= True;
  PainelPosit.Parent := Self.Parent;
  SnMover := True;
  TopIni  := Y;
  LeftIni := X;
  {Rect.TopLeft := FormEntradaDados.ClientToScreen(Point(0, 0));
  Rect.BottomRight := FormEntradaDados.ClientToScreen(Point(Width, ClientHeight));
  ClipCursor(@Rect);}
end;

procedure TMultComp.AoClicar(Sender: TObject);
var I : Integer;
begin
  for I:=0 to 999 do
  begin
    if FormEntradaDados.ListaComponente[I] <> nil then
      FormEntradaDados.ListaComponente[I].Selecionado := False;
  end;
  Selecionado := Not Selecionado;
  FSelecionado:= Selecionado;
  xLeft := TMultComp(Sender).Left;
  xtop  := TMultComp(Sender).Top;
  if snMover then
    DrawRec(Sender);
end;

procedure TMultComp.DrawRec(Sender: TObject);
begin
  {Retangulo.Left := XLeft;
  Retangulo.Top  := XTop;}
  {FormEntradaDados.Canvas.Brush.Color := clBtnFace;
  FormEntradaDados.Canvas.Brush.Style := bsSolid;
  FormEntradaDados.Canvas.FillRect(FormEntradaDados.ClientRect);
  with FormEntradaDados.Canvas do begin
     Pen.Color := clWhite;
     Pen.Style:= psDot;
     Pen.Width := 3;
     Brush.Style := bsClear;
     Rectangle(xLeft,                       xTop,
               xLeft+TMultComp(Sender).Width, xTop+TMultComp(Sender).Height);
  end;}
end;

end.
