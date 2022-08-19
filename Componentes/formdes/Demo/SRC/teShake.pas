unit teShake;

interface

uses Classes, Windows, SysUtils, Graphics, TransEff;

type
  TShakeTransition = class(TTransitionEffect)
  protected
    procedure DoExecute(Data: TTETransitionData); override;
    function  NeedDstImage: Boolean; override;
  end;

implementation

uses
  teRender, teChrono;

function TShakeTransition.NeedDstImage: Boolean;
begin
  Result := False;
end;

procedure TShakeTransition.DoExecute(Data: TTETransitionData);
var
  Chrono: TTEChrono;
  PosX,
  PosY: Integer;
begin
  Chrono := TTEChrono.Create;
  try
    Randomize;
    Chrono.Start;
    while Chrono.Milliseconds < Milliseconds do
    begin
      PosX := Random(7);
      PosY := Random(7);

      BitBlt(Data.Canvas.Handle, PosX-3, PosY-3, Data.Width, Data.Height,
        Data.SrcBmp.Canvas.Handle, 0, 0, cmSrcCopy);

      Sleep(35);
    end;
    BitBlt(Data.Canvas.Handle, 0, 0, Data.Width, Data.Height,
      Data.SrcBmp.Canvas.Handle, 0, 0, cmSrcCopy);
  finally
    Chrono.Free;
  end;
end;

end.
