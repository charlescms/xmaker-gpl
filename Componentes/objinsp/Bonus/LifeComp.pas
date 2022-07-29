(*  GREATIS BONUS * Life                      *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit LifeComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const

  MinCellSize = 4;

  MaxX = 1600 div MinCellSize;
  MaxY = 1200 div MinCellSize;

type

  TCellState = (csDead,csLoneliness,csOvercrowding,csSurvive);

  TCellStates=record
    CurState,NextState: TCellState;
  end;

  TCellsArray = array[1..MaxX,1..MaxY] of TCellStates;
  PCellsArray = ^TCellsArray;

  TCellShape = (shSquare,shCircle,shOwnerDraw);

  TFieldMode = (fmBinary,fmString);

  TDrawLifeCell = procedure(Sender: TObject; X,Y: Integer; R: TRect) of object;

  TLife = class(TGraphicControl)
  private
    { Private declarations }
    FBackgroundColor,FGridColor,FLonelinessColor,FOvercrowdingColor,FSurviveColor: TColor;
    FCells: PCellsArray;
    FCellSize,FXRange,FYRange: Integer;
    FEnableRandomLife: Boolean;
    FRandomLife: Integer;
    FCellShape: TCellShape;
    FShowGrid: Boolean;
    FShowDying: Boolean;
    FClosed: Boolean;
    FFillDensity: Integer;
    FSurviveCellCount: Integer;
    FGeneration: Integer;
    FLocked: Boolean;
    FOnDrawCell: TDrawLifeCell;
    function NeighboursCount(X,Y: Integer): Integer;
    procedure ResetCells;
    procedure UpdateNext;
    procedure SetBackgroundColor(Value: TColor);
    procedure SetGridColor(Value: TColor);
    procedure SetLonelinessColor(Value: TColor);
    procedure SetOvercrowdingColor(Value: TColor);
    procedure SetSurviveColor(Value: TColor);
    procedure SetCellSize(Value: Integer);
    procedure SetRandomLife(Value: Integer);
    procedure SetCellShape(Value: TCellShape);
    procedure SetShowGrid(Value: Boolean);
    procedure SetShowDying(Value: Boolean);
    procedure SetFillDensity(Value: Integer);
    function GetCellState(X,Y: Integer): TCellState;
    procedure SetCellState(X,Y: Integer; Value: TCellState);
    procedure DrawCells(RedrawAll: Boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Lock;
    procedure Unlock;
    procedure Fill;
    procedure Clear;
    procedure NextGeneration;
    function CellFromPoint(P: TPoint): TPoint;
    function GetField(Mode: TFieldMode): string;
    procedure SetField(Field: string; Mode: TFieldMode);
    property SurviveCellCount: Integer read FSurviveCellCount;
    property XRange: Integer read FXRange;
    property YRange: Integer read FYRange;
    property Generation: Integer read FGeneration;
    property Cells[X,Y: Integer]: TCellState read GetCellState write SetCellState;
    property Locked: Boolean read FLocked write FLocked;
    property Canvas;
  published
    { Published declarations }
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor;
    property GridColor: TColor read FGridColor write SetGridColor;
    property LonelinessColor: TColor read FLonelinessColor write SetLonelinessColor;
    property OvercrowdingColor: TColor read FOvercrowdingColor write SetOvercrowdingColor;
    property SurviveColor: TColor read FSurviveColor write SetSurviveColor;
    property CellSize: Integer read FCellSize write SetCellSize;
    property EnableRandomLife: Boolean read FEnableRandomLife write FEnableRandomLife;
    property RandomLife: Integer read FRandomLife write SetRandomLife;
    property CellShape: TCellShape read FCellShape write SetCellShape;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid;
    property ShowDying: Boolean read FShowDying write SetShowDying;
    property Closed: Boolean read FClosed write FClosed;
    property FillDensity: Integer read FFillDensity write SetFillDensity;
    property OnDrawCell: TDrawLifeCell read FOnDrawCell write FOnDrawCell;
    property Align;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

constructor TLife.Create(AOwner: TComponent);
begin
  inherited;
  FBackgroundColor:=clBlack;
  FGridColor:=clGray;
  Color:=FBackgroundColor;
  FLonelinessColor:=clGray;
  FOvercrowdingColor:=clWhite;
  FSurviveColor:=clSilver;
  FCellSize:=16;
  New(FCells);
  FillChar(FCells^,SizeOf(FCells^),0);
  FFillDensity:=5;
  Width:=150;
  Height:=100;
end;

destructor TLife.Destroy;
begin
  if Assigned(FCells) then Dispose(FCells);
  inherited;
end;

procedure TLife.Paint;
begin
  FXRange:=Width div FCellSize;
  FYRange:=Height div FCellSize;
  DrawCells(True);
end;

procedure TLife.Lock;
begin
  FLocked:=True;
end;

procedure TLife.Unlock;
begin
  FLocked:=False;
  DrawCells(True);
end;

procedure TLife.DrawCells(RedrawAll: Boolean);
var
  X,Y,XPos,YPos: Integer;
  R: TRect;

  procedure DrawCell(X,Y,XPos,YPos: Integer);
  begin
    with Canvas,FCells^[X,Y] do
    begin
      if NextState=csSurvive then Inc(FSurviveCellCount);
      if (NextState<>CurState) or RedrawAll then
      begin
        with R do
        begin
          Left:=Succ(XPos);
          Top:=Succ(YPos);
          Right:=XPos+FCellSize;
          Bottom:=YPos+FCellSize;
        end;
        if CellShape=shOwnerDraw then
        begin
          if Assigned(FOnDrawCell) then FOnDrawCell(Self,X,Y,R);
        end
        else
        begin
          case NextState of
            csSurvive: Brush.Color:=FSurviveColor;
            csLoneliness:
              if not FShowDying then Brush.Color:=FBackgroundColor
              else Brush.Color:=FLonelinessColor;
            csOvercrowding:
              if not FShowDying then Brush.Color:=FBackgroundColor
              else Brush.Color:=FOvercrowdingColor;
          else Brush.Color:=FBackgroundColor;
          end;
          case FCellShape of
            shSquare: FillRect(R);
            shCircle: Ellipse(XPos,YPos,XPos+Succ(FCellSize),YPos+Succ(FCellSize));
          end;
        end;
      end;
    end;
  end;

begin
  if Assigned(Parent) and not FLocked then
    with Canvas do
    begin
      if RedrawAll then
      begin
        Brush.Color:=FBackgroundColor;
        FillRect(ClientRect);
        if FShowGrid then
        begin
          YPos:=0;
          for Y:=1 to Succ(FYRange) do
          begin
            XPos:=0;
            for X:=1 to Succ(FXRange) do
            begin
              Pixels[XPos,YPos]:=FGridColor;
              Inc(XPos,FCellSize);
            end;
            Inc(YPos,FCellSize);
          end;
        end;
      end;
      FSurviveCellCount:=0;
      YPos:=0;
      for Y:=1 to FYRange do
      begin
        XPos:=0;
        for X:=1 to FXRange do
        begin
          DrawCell(X,Y,XPos,YPos);
          Inc(XPos,FCellSize);
        end;
        Inc(YPos,FCellSize);
      end;
    end;
end;

function TLife.NeighboursCount(X,Y: Integer): Integer;
var
  xx,yy,XCell,YCell: Integer;
begin
  Result:=0;
  if FClosed then
    for yy:=Pred(Y) to Succ(Y) do
      for xx:=Pred(X) to Succ(X) do
      begin
        XCell:=xx;
        YCell:=yy;
        if XCell<1 then XCell:=FXRange;
        if XCell>FXRange then XCell:=1;
        if YCell<1 then YCell:=FYRange;
        if YCell>FYRange then YCell:=1;
        if (XCell>=1) and (YCell>=1) and
          (XCell<=FXRange) and (YCell<=FYRange) and
          ((XCell<>X) or (YCell<>Y)) then Inc(Result,Byte(FCells^[XCell,YCell].CurState=csSurvive));
      end
  else
    for yy:=Pred(Y) to Succ(Y) do
      for xx:=Pred(X) to Succ(X) do
        if (xx>=1) and (yy>=1) and
          (xx<=FXRange) and (yy<=FYRange) and
          ((xx<>X) or (yy<>Y)) then Inc(Result,Byte(FCells^[xx,yy].CurState=csSurvive));
end;

procedure TLife.ResetCells;
var
  X,Y: Integer;
begin
  for Y:=1 to FYRange do
    for X:=1 to FXRange do
      with FCells^[X,Y] do
      begin
        case NeighboursCount(X,Y) of
          0..1:
            if CurState=csSurvive then NextState:=csLoneliness
            else NextState:=csDead;
          4..8:
            if CurState=csSurvive then NextState:=csOvercrowding
            else NextState:=csDead;
          2:
            if CurState=csSurvive then NextState:=CurState
            else NextState:=csDead;
          3: NextState:=csSurvive;
        end;
        if EnableRandomLife and
          (Random(RandomLife)=0) then NextState:=csSurvive;
      end;
end;

procedure TLife.UpdateNext;
var
  X,Y: Integer;
begin
  for Y:=1 to FYRange do
    for X:=1 to FXRange do
      with FCells^[X,Y] do CurState:=NextState;
end;

procedure TLife.Fill;
var
  X,Y: Integer;
begin
  FXRange:=Width div FCellSize;
  FYRange:=Height div FCellSize;
  FillChar(FCells^,SizeOf(FCells^),0);
  for Y:=1 to FYRange do
    for X:=1 to FXRange do
    begin
      if Random(FillDensity)=0 then FCells^[X,Y].CurState:=csSurvive;
      FCells^[X,Y].NextState:=FCells^[X,Y].CurState;
    end;
  DrawCells(True);
  FGeneration:=0;
end;

procedure TLife.Clear;
begin
  FXRange:=Width div FCellSize;
  FYRange:=Height div FCellSize;
  FillChar(FCells^,SizeOf(FCells^),0);
  DrawCells(True);
  FGeneration:=0;
end;

procedure TLife.NextGeneration;
begin
  ResetCells;
  DrawCells(False);
  UpdateNext;
  Inc(FGeneration);
end;

function TLife.CellFromPoint(P: TPoint): TPoint;
begin
  Result.X:=Succ(P.X div FCellSize);
  Result.Y:=Succ(P.Y div FCellSize);
end;

function TLife.GetField(Mode: TFieldMode): string;
var
  X,Y,Bit: Integer;
  State8: Byte;

  function SwapTetr(X: Byte): Byte;
  begin
    Result:=X and $F shl 4 + X and $F0 shr 4;
  end;

begin
  Result:='';
  Bit:=1;
  State8:=0;
  for Y:=1 to YRange do
    for X:=1 to XRange do
    begin
      if FCells^[X,Y].CurState=csSurvive then State8:=State8 or Bit;
      Bit:=Bit shl 1;
      if Bit and $FF = 0 then
      begin
        if Mode=fmBinary then Result:=Result+Char(State8)
        else Result:=Result+Format('%2.2x',[SwapTetr(State8)]);
        State8:=0;
        Bit:=1;
      end;
    end;
end;

procedure TLife.SetField(Field: string; Mode: TFieldMode);
var
  X,Y,CharPos,Bit: Integer;
  State8: Byte;

  function HexToTetr(Hex: Char): Byte;
  begin
    case Hex of
      '0'..'9': Result:=Ord(Hex)-Ord('0');
    else Result:=Ord(Hex)-Ord('A')+10;
    end;
  end;

begin
  CharPos:=1;
  Bit:=1;
  State8:=0;
  FillChar(FCells^,SizeOf(FCells^),0);
  for Y:=1 to YRange do
    for X:=1 to XRange do
    begin
      if Mode=fmBinary then
      begin
        if Bit and $FF = 1 then State8:=Byte(Field[CharPos]);
        if Bit and State8 <> 0 then
        begin
          FCells^[X,Y].CurState:=csSurvive;
          FCells^[X,Y].NextState:=csSurvive;
        end;
        Bit:=Bit shl 1;
        if Bit and $FF = 0 then
        begin
          Inc(CharPos);
          Bit:=1;
        end;
      end
      else
      begin
        if Bit and $F = 1 then State8:=HexToTetr(Field[CharPos]);
        if Bit and State8 <> 0 then
        begin
          FCells^[X,Y].CurState:=csSurvive;
          FCells^[X,Y].NextState:=csSurvive;
        end;
        Bit:=Bit shl 1;
        if Bit and $F = 0 then
        begin
          Inc(CharPos);
          Bit:=1;
        end;
      end;
      If CharPos>Length(Field) then
      begin
        DrawCells(True);
        Exit;
      end;
    end;
  DrawCells(True);
end;

procedure TLife.SetBackgroundColor(Value: TColor);
begin
  if Value<>FBackgroundColor then
  begin
    FBackgroundColor:=Value;
    Color:=Value;
    Canvas.Pen.Color:=clWhite;
    Canvas.Pen.Style:=psClear;
    DrawCells(True);
  end;
end;

procedure TLife.SetGridColor(Value: TColor);
begin
  if Value<>FGridColor then
  begin
    FGridColor:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetLonelinessColor(Value: TColor);
begin
  if Value<>FLonelinessColor then
  begin
    FLonelinessColor:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetOvercrowdingColor(Value: TColor);
begin
  if Value<>FOvercrowdingColor then
  begin
    FOvercrowdingColor:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetSurviveColor(Value: TColor);
begin
  if Value<>FSurviveColor then
  begin
    FSurviveColor:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetCellSize(Value: Integer);
begin
  if Value<>FCellSize then
  begin
    if Value<4 then Value:=4;
    if Value>32 then Value:=32;
    FCellSize:=Value;
    Clear;
  end;
end;

procedure TLife.SetRandomLife(Value: Integer);
begin
  if Value<>FRandomLife then
  begin
    if Value<0 then Value:=0;
    if Value>100000 then Value:=100000;
    FRandomLife:=Value;
  end;
end;

procedure TLife.SetCellShape(Value: TCellShape);
begin
  if Value<>FCellShape then
  begin
    FCellShape:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetShowGrid(Value: Boolean);
begin
  if Value<>FShowGrid then
  begin
    FShowGrid:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetShowDying(Value: Boolean);
begin
  if Value<>FShowDying then
  begin
    FShowDying:=Value;
    DrawCells(True);
  end;
end;

procedure TLife.SetFillDensity(Value: Integer);
begin
  if Value<>FFillDensity then
  begin
    if Value>100 then Value:=100;
    if Value<2 then Value:=2;
    FFillDensity:=Value;
  end;
end;

function TLife.GetCellState(X,Y: Integer): TCellState;
begin
  Result:=FCells[X,Y].NextState;
end;

procedure TLife.SetCellState(X,Y: Integer; Value: TCellState);
begin
  FCells[X,Y].NextState:=Value;
  FCells[X,Y].CurState:=Value;
end;

procedure Register;
begin
  RegisterComponents('Greatis', [TLife]);
end;

end.
