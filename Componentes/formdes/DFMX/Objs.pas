(*  GREATIS FORM EXTRACTOR for                *)
(*  GREATIS FORM DESIGNER                     *)
(*  Copyright (C) 2002-2004 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

unit Objs;

interface

uses SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, Windows, Messages,
  ComCtrls;

type

  TFormPanel = class(TPanel)
  protected
    procedure Paint; override;
  end;

  TAbstractComponent = class(TPanel)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TParentStack = class(TList)
  public
    procedure Push(Control: TWinControl);
    function Pop: TWinControl;
    function Last: TWinControl;
  end;

implementation

procedure TFormPanel.Paint;
begin
  with Canvas do
  begin
    Brush.Color:=clBtnFace;
    Rectangle(0,0,Width,Height);
  end;
end;

constructor TAbstractComponent.Create(AOwner: TComponent);
begin
  inherited;
  Width:=27;
  Height:=27;
  Color:=clWhite;
end;

procedure TAbstractComponent.Paint;
var
  R: TRect;
begin
  with Canvas do
  begin
    Rectangle(0,0,Width,Height);
    R:=ClientRect;
    SetBkMode(Handle,TRANSPARENT);
    DrawText(Handle,PChar(Caption),-1,R,DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TParentStack.Push(Control: TWinControl);
begin
  Add(Control);
end;

function TParentStack.Pop: TWinControl;
begin
  Result:=Last;
  if Count>0 then Delete(Pred(Count));
end;

function TParentStack.Last: TWinControl;
begin
  if Count>0 then Result:=Items[Pred(Count)]
  else Result:=nil;
end;

end.
