unit MComp;

interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, ExtCtrls, Controls, Graphics, Buttons, StdCtrls,
  ComCtrls, Grids;

type
  TMComp = class(TPanel)
   constructor Create(AComponent: TComponent); override;
   destructor destroy; override;
  private
    fmarge:integer;
    fOnPanelMoved:TNotifyEvent;
    fmoveable:boolean;
  protected
     procedure PanelMove(var Mover: TWMNCHitTest); message WM_NCHITTEST;
     procedure PanelMoved(var Mover: Tmessage); message WM_MOVE;

  public

  published
    property Moveable:boolean read fmoveable write fmoveable default false;

  end;

implementation

procedure TMComp.PanelMove(var Mover: TWMNCHitTest);
var Posicao : TPoint;
begin
  if csDesigning in ComponentState
  then begin
    parent.dispatch(Mover);
    exit;
  end;
  Posicao.x  :=  Mover.xpos;Posicao.y := Mover.ypos;
  Posicao := screentoclient(Posicao);
  if ((Posicao.x<fmarge) and (Posicao.y<fmarge))
  then begin
    Mover.result := httopleft; //TopA
  end else begin
    if ((Posicao.x<fmarge) and (height-Posicao.y<fmarge))
    then begin
      Mover.result := htbottomleft;  //HA
    end else begin
      if (Posicao.x<fmarge)
      then begin
        Mover.result := htleft; // CenterC
      end else begin
        if ((width- Posicao.x<fmarge) and (Posicao.y<fmarge))
        then begin
          Mover.result := httopright; //TopB
        end else begin
          if ((width- Posicao.x<fmarge) and (height-Posicao.y<fmarge))
          then begin
            Mover.result := htbottomright; //HB
          end else begin
            if (width- Posicao.x<fmarge)
            then begin
              Mover.result := htright;    // CenterD
            end else begin
              if (Posicao.y<fmarge)
              then begin
                Mover.result := httop;   //centerA
              end else begin
                if (height-Posicao.y<fmarge)
                then begin
                  Mover.result := htbottom; //CenterB
                end else begin
                  Mover.result := HTCAPTION;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Canvas.Brush.Color  :=  clActiveCaption;
  Canvas.Rectangle(0, 0, 6, 6);
  Canvas.Rectangle(Round(Width / 2) - 3, 0, Round(Width / 2) + 3, 6);
  Canvas.Rectangle(Width - 6, 0, Width, 6);

  Canvas.Rectangle(0, Round(Height / 2) - 3, 6, Round(Height / 2) + 3);
  Canvas.Rectangle(Width - 6, Round(Height / 2) - 3, Width, Round(Height / 2) + 3);

  Canvas.Rectangle(0, Height - 6, 6, Height);
  Canvas.Rectangle(Round(Width / 2) - 3, Height - 6, Round(Width / 2) + 3, Height);
  Canvas.Rectangle(Width - 6, Height - 6, Width, Height);
end;

procedure TMComp.PanelMoved(var Mover: Tmessage);
begin
  if assigned(FonPanelMoved)
  then begin
    FOnPanelMoved(self);
  end;
  inherited;
end;

constructor TMComp.Create(AComponent: TComponent);
begin
  inherited Create(AComponent);
  fmarge := 6;
  fmoveable := false;
end;

destructor TMComp.Destroy;
begin
   inherited destroy;
end;

end.
