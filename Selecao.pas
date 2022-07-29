unit Selecao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormListaEscolha = class(TForm)
    Bevel1: TBevel;
    BtnOk: TButton;
    BtnCancelar: TButton;
    ListaSelecao: TListBox;
    Extra: TCheckBox;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListaSelecaoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListaSelecaoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListaSelecaoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListaSelecaoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListaSelecaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    HalfWay: Integer;
    EditRect: TRect;
    SplitDrag: Boolean;
  public
    { Public declarations }
    NumeroSelecao: Integer;
  end;

var
  FormListaEscolha: TFormListaEscolha;

implementation

{$R *.DFM}

procedure TFormListaEscolha.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormListaEscolha.BtnOkClick(Sender: TObject);
begin
  if ListaSelecao.ItemIndex <> -1 then
  begin
    NumeroSelecao := ListaSelecao.ItemIndex;
    close;
  end;
end;

procedure TFormListaEscolha.FormShow(Sender: TObject);
begin
  HalfWay := ListaSelecao.Width div 2;
  NumeroSelecao := -1;
  ListaSelecao.ItemIndex := 0;
end;

procedure TFormListaEscolha.ListaSelecaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  sr,dr: TRect;
  PropName,PropValue:string;
begin
  with (Control as TListBox).Canvas do
  begin
    Brush.Color := (Control as TListBox).Color;          {Won't use Windows Selected color.}
    FillRect(Rect);

    if (odSelected in State) then Pen.Color := clBtnHighLight else {for 3D look}
      Pen.Color := clBtnShadow;
    Pen.Mode  := pmCopy;
    Pen.Width := 1;
    Pen.Style := psSolid;
    MoveTo(Rect.Left, Rect.Bottom-1);
    LineTo(Rect.Right, Rect.Bottom-1);

    if (odFocused in State) then
    begin
      Pen.Color := clBtnHighLight;
      MoveTo(HalfWay + 2, Rect.Top+1);
      LineTo(Halfway + 2, Rect.Bottom);

      Pen.Color := clBtnShadow;
      MoveTo(Halfway+1, Rect.Top+2);
      LineTo(Halfway+1, Rect.Bottom);

      MoveTo(Rect.Right, Rect.Top);
      LineTo(Rect.Left, Rect.Top);
      LineTo(Rect.Left, Rect.Bottom);

      Pen.Color := clBlack;
      MoveTo(Rect.Right-1, Rect.Top+1);
      LineTo(Rect.Left+1, Rect.Top+1);
      LineTo(Rect.Left+1, Rect.Bottom-1);
    end
    else
    begin
      Pen.Color := clBtnShadow;
      MoveTo(Halfway, Rect.Top+1);
      LineTo(Halfway, Rect.Bottom);

      Pen.Color := clBtnHighLight;
      MoveTo(HalfWay + 1, Rect.Top+1);
      LineTo(Halfway + 1, Rect.Bottom);
    end;

    SR.Left := Rect.Left+2 ;  SR.Right := HalfWay;
    SR.Top := Rect.Top+1;  SR.Bottom := Rect.Bottom-1;

    if (odFocused in State) then
    begin
      Inc(SR.Left);
      Inc(SR.Top);
      Inc(SR.Right);
    end;
    Font.Color := clBlack;
    setbkMode((Control as TListBox).Canvas.Handle, Transparent);
    PropName:= Copy((Control as TListBox).Items[Index],1,40);
    PropValue:= Copy((Control as TListBox).Items[Index],41,255);
    if PropName[1] = '+' then
       TextRect(SR, Sr.Left, SR.Top+1, PropName )
    else  TextRect(SR, Sr.Left+10, SR.Top+1, PropName );
    Font.Color := clNavy;
    TextOut(HalfWay + 4, SR.Top+1, PropValue );

    DR.Left:= Rect.Left+2;  DR.Right := Rect.Left+13+2;  {DestRect}
    DR.Top := Rect.Top+1; DR.Bottom := Rect.Top+13+1;

    if (odSelected in State) then
    begin       { To give 3D look to inspector.}
      Inc(DR.Left); Inc(DR.Right);
      Inc(DR.Top); Inc(DR.Bottom);
    end;
  end;
  if odFocused in state then
  begin
      with (Control as TListBox).Canvas do
      begin
         EditRect := (Control as TListBox).ItemRect((Control as TListBox).ItemIndex);
         EditRect.Left := HalfWay + 4;
         Dec(EditRect.Bottom, 2);
         Inc(EditRect.Top,3);
      end;
  end;
end;

procedure TFormListaEscolha.ListaSelecaoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R,sr : TRect;
begin
  if Abs(X - Halfway) <= 3 then  SplitDrag := True
  else
  if (X >= EditRect.left) and (X <= EditRect.Right) and
     (y >= EditRect.Top) and (Y <= EditRect.Bottom) then
     begin
     (Sender as TListBox).Cursor := crDefault;
  end;
end;

procedure TFormListaEscolha.ListaSelecaoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  TempR : TRect;
  LB : TListBox;
begin
  lb := ListaSelecao;
  if SplitDrag then
  begin
    if X > Lb.ClientWidth - 20 then X := Lb.ClientWidth - 20;
    if X < 20 then X := 20;

    if Halfway < X then TempR:= Rect(Halfway, 0, lb.ClientWidth, lb.ClientHeight)
    else  TempR:= Rect(X, 0, lb.ClientWidth, lb.ClientHeight);
    HalfWay := X;

    InvalidateRect(lb.Handle, @TempR, False);
    InvalidateRect(lb.Handle, @EditRect, False);
    PostMessage(lb.Handle, WM_Paint, 0, 0);
    Exit;
  end;
  if Abs(x - Halfway) <= 3 then   lb.Cursor := crHSplit
  else
  if (X >= EditRect.left) and (X <= EditRect.Right) and
     (Y >= EditRect.Top) and (Y <= EditRect.Bottom) then
       lb.Cursor := crIBeam else lb.Cursor := crDefault;
end;

procedure TFormListaEscolha.ListaSelecaoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SplitDrag := False;
end;

procedure TFormListaEscolha.ListaSelecaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
  begin
    Key := 0;
    exit;
  end;
end;

procedure TFormListaEscolha.FormResize(Sender: TObject);
begin
  EditRect.Right := ListaSelecao.ItemRect(ListaSelecao.ItemIndex).Right;
end;

procedure TFormListaEscolha.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;

end;

end.
