unit dbGridColunas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, dbgrids, ComCtrls, ImgList, ToolWin, PropEdit;

type
  TFormdbGridColunas = class(TForm)
    lsbItems: TListBox;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    BtnNew: TToolButton;
    BtnDelete: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure lsbItemsClick(Sender: TObject);
    procedure lsbItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lsbItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsbItemsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FDragIndex: Integer;
    procedure Atualiza;
    procedure MoveUp(Target: Integer);
    procedure MoveDown(Target: Integer);
    procedure Reorder;
  public
    { Public declarations }
    dbGrid: TdbGrid;
    fecha: Boolean;
  end;

var
  FormdbGridColunas: TFormdbGridColunas;

implementation

uses ObjInsp, Rotinas;

{$R *.DFM}

procedure TFormdbGridColunas.FormShow(Sender: TObject);
begin
  Fecha := False;
  Atualiza;
  BtnDelete.Enabled := False;
  if lsbItems.Items.Count > 0 then
  begin
    lsbItems.ItemIndex := 0;
    lsbItems.Selected[0] := True;
    lsbItemsClick(Self);
    BtnDelete.Enabled := True;
  end;
end;

procedure TFormdbGridColunas.Atualiza;
var
  I: Integer;
begin
  lsbItems.Items.Clear;
  for I:=0 to dbGrid.Columns.Count-1 do
    lsbItems.Items.AddObject(IntToStr(I) + ' - TColumn', dbGrid.Columns[I]);
  lsbItemsClick(Self);
end;

procedure TFormdbGridColunas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not fecha then
  begin
    Action := caNone;
    Hide;
  end;
end;

procedure TFormdbGridColunas.BtnNewClick(Sender: TObject);
begin
  dbGrid.Columns.Add;
  Atualiza;
  lsbItems.ItemIndex := lsbItems.Items.Count-1;
  lsbItems.Selected[lsbItems.ItemIndex] := True;
  lsbItemsClick(Self);
end;

procedure TFormdbGridColunas.BtnDeleteClick(Sender: TObject);
begin
  if (lsbItems.ItemIndex > -1) and (lsbItems.SelCount > 0) then
    if Mensagem('Excluir coluna?', modConfirmacao, [modSim, modNao]) = mrYes then
    begin
      dbGrid.Columns.Delete(lsbItems.ItemIndex);
      Atualiza;
      if lsbItems.Items.Count > 0 then
      begin
        lsbItems.ItemIndex := 0;
        lsbItems.Selected[lsbItems.ItemIndex] := True;
        lsbItemsClick(Self);
      end;
    end;
end;

procedure TFormdbGridColunas.lsbItemsClick(Sender: TObject);
begin
  if (lsbItems.SelCount<1) or (lsbItems.ItemIndex=-1) then
  begin
    FormObjInsp.Atribui(Nil, True);
    BtnDelete.Enabled := False;
  end
  else
  begin
    FormObjInsp.Atribui(lsbItems.Items.Objects[lsbItems.ItemIndex], True);
    BtnDelete.Enabled := True;
  end;
end;

procedure TFormdbGridColunas.MoveUp(Target: Integer);
var
  i,OldSelCount: Integer;
begin
  with lsbItems,Items do
  begin
    OldSelCount:=SelCount;
    for i:=0 to Pred(Count) do
      if Selected[i] then
      begin
        Move(i,Target);
        Inc(Target);
      end;
    Reorder;
    for i:=Target-OldSelCount to Pred(Target) do Selected[i]:=True;
  end;
end;

procedure TFormdbGridColunas.MoveDown(Target: Integer);
var
  i,OldSelCount: Integer;
begin
  with lsbItems,Items do
  begin
    OldSelCount:=SelCount;
    i:=0;
    while (i<Count) and (SelCount>0) do
      if Selected[i] and (i<>Target) then Move(i,Target)
      else Inc(i);
    Reorder;
    for i:=Target-Pred(OldSelCount) to Target do Selected[i]:=True;
  end;
end;

procedure TFormdbGridColunas.Reorder;
var
  i: Integer;
  Sel: Boolean;
begin
  with lsbItems,Items do
    for i:=0 to Pred(Count) do
    begin
      Sel:=Selected[i];
      TCollectionItem(Objects[i]).Index:=i;
      Items[i]:=IntToStr(I) + ' - TColumn';
      if Sel then Selected[i]:=True;
    end;
end;

procedure TFormdbGridColunas.lsbItemsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Index: Integer;
begin
  with lsbItems do
  begin
    Index:=ItemAtPos(Point(X,Y),True);
    if Index<FDragIndex then MoveUp(Index)
    else MoveDown(Index);
  end;
end;

procedure TFormdbGridColunas.lsbItemsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  with lsbItems do
  begin
    Index:=ItemAtPos(Point(X,Y),True);
    Accept:=(Index>=0) and (Index<Items.Count) and not Selected[Index];
  end;
end;

procedure TFormdbGridColunas.lsbItemsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDragIndex:=lsbItems.ItemAtPos(Point(X,Y),True);
end;

end.
