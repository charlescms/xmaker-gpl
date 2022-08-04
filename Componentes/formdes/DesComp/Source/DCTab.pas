(*  GREATIS FORM DESIGNER COMPONENT PRO  *)
(*  unit version 0.00.001                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm   *)
(*  b-team@greatis.com                   *)

unit DCTab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmTabOrder = class(TForm)
    lblControls: TLabel;
    lsbControls: TListBox;
    bbtMoveUp: TBitBtn;
    bbtMoveDown: TBitBtn;
    btnOK: TButton;
    btnCancel: TButton;
    procedure bbtMoveUpClick(Sender: TObject);
    procedure bbtMoveDownClick(Sender: TObject);
    procedure lsbControlsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsbControlsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure lsbControlsDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
    FDragIndex: Integer;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmTabOrder.bbtMoveUpClick(Sender: TObject);
begin
  with lsbControls,Items do
  begin
    if ItemIndex>0 then
    begin
      Exchange(ItemIndex,Pred(ItemIndex));
      ItemIndex:=Pred(ItemIndex);
    end;
    SetFocus;
  end;
end;

procedure TfrmTabOrder.bbtMoveDownClick(Sender: TObject);
begin
  with lsbControls,Items do
  begin
    if ItemIndex<Pred(Count) then
    begin
      Exchange(ItemIndex,Succ(ItemIndex));
      ItemIndex:=Succ(ItemIndex);
    end;
    SetFocus;
  end;
end;

procedure TfrmTabOrder.lsbControlsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  NDragIndex: Integer;
begin
  with lsbControls do
  begin
    NDragIndex:=ItemAtPos(Point(X,Y),True);
    Accept:=(Sender=Source) and (NDragIndex<>ItemIndex) and (NDragIndex>-1) and (NDragIndex<Items.Count);
    if FDragIndex<>NDragIndex then
    begin
      if FDragIndex<>ItemIndex then Canvas.DrawFocusRect(ItemRect(FDragIndex));
      if NDragIndex<>ItemIndex then Canvas.DrawFocusRect(ItemRect(NDragIndex));
      FDragIndex:=NDragIndex;
    end;
  end;
end;

procedure TfrmTabOrder.lsbControlsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDragIndex:=lsbControls.ItemIndex;
end;

procedure TfrmTabOrder.lsbControlsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  with lsbControls,Items do
  begin
    Move(ItemIndex,FDragIndex);
    ItemIndex:=FDragIndex;
  end;
end;

end.
