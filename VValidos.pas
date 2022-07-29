unit VValidos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TFormVlValidos = class(TForm)
    Bevel1: TBevel;
    BtnOk: TButton;
    BtnCancelar: TButton;
    ListaSelecao: TListBox;
    EdValor: TEdit;
    EdDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BtnNovo: TBitBtn;
    BtnConfirma: TBitBtn;
    BtnMoveParaBaixo: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnMoveParaCima: TBitBtn;
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
    procedure ListaSelecaoClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnConfirmaClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure ListaSelecaoDblClick(Sender: TObject);
  private
    { Private declarations }
    HalfWay: Integer;
    EditRect: TRect;
    SplitDrag: Boolean;
  public
    { Public declarations }
    Atualizar: Boolean;
    TamanhoCmp: Integer;
  end;

var
  FormVlValidos: TFormVlValidos;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormVlValidos.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormVlValidos.BtnOkClick(Sender: TObject);
begin
  Atualizar := True;
  close;
end;

procedure TFormVlValidos.FormShow(Sender: TObject);
begin
  //HalfWay := ListaSelecao.Width div 2;
  HalfWay   := 70;
  Atualizar := False;
  if ListaSelecao.Items.Count > 0 then
  begin
    ListaSelecao.ItemIndex := 0;
    BtnExcluir.Enabled     := True;
  end;
  EdValor.MaxLength := TamanhoCmp;
  ListaSelecaoClick(Self);
  BtnNovo.SetFocus;
end;

procedure TFormVlValidos.ListaSelecaoDrawItem(Control: TWinControl;
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
    PropName:= Copy((Control as TListBox).Items[Index],1,TamanhoCmp);
    PropValue:= Copy((Control as TListBox).Items[Index],TamanhoCmp+01,255);
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

procedure TFormVlValidos.ListaSelecaoMouseDown(Sender: TObject;
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

procedure TFormVlValidos.ListaSelecaoMouseMove(Sender: TObject;
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

procedure TFormVlValidos.ListaSelecaoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SplitDrag := False;
end;

procedure TFormVlValidos.ListaSelecaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
  begin
    Key := 0;
    exit;
  end;
end;

procedure TFormVlValidos.FormResize(Sender: TObject);
begin
  EditRect.Right := ListaSelecao.ItemRect(ListaSelecao.ItemIndex).Right;
end;

procedure TFormVlValidos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormVlValidos.ListaSelecaoClick(Sender: TObject);
begin
  BtnMoveParaCima.Enabled  := True;
  BtnMoveParaBaixo.Enabled := True;
  if ListaSelecao.ItemIndex = 0 then
    BtnMoveParaCima.Enabled := False
  else if ListaSelecao.ItemIndex = ListaSelecao.Items.Count-1 then
    BtnMoveParaBaixo.Enabled := False;
  if ListaSelecao.Items.Count <= 1 then
  begin
    BtnMoveParaCima.Enabled  := False;
    BtnMoveParaBaixo.Enabled := False;
  end;
  EdValor.Text := '';
  EdDescricao.Text := '';
  if ListaSelecao.ItemIndex >= 0 then
  begin
    EdValor.Text     := Copy(ListaSelecao.Items[ListaSelecao.ItemIndex],01,TamanhoCmp);
    EdDescricao.Text := Copy(ListaSelecao.Items[ListaSelecao.ItemIndex],TamanhoCmp+01,255);
  end;
  if ListaSelecao.Items.Count < 1 then
    BtnExcluir.Enabled := False;
end;

procedure TFormVlValidos.BtnExcluirClick(Sender: TObject);
var
  P: Integer;
begin
  if ListaSelecao.ItemIndex < 0 then
  begin
    Mensagem('Valor não selecionado !',ModAdvertencia,[ModOk]);
    ListaSelecao.SetFocus;
    exit;
  end;
  if Mensagem(EdValor.Text + ' - ' +EdDescricao.Text+ ^M+^M + 'Excluir Valor ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
    exit;
  P := ListaSelecao.ItemIndex;
  ListaSelecao.Items.Delete(ListaSelecao.ItemIndex);
  if (P < ListaSelecao.Items.Count) and (ListaSelecao.Items.Count > 0) then
    ListaSelecao.ItemIndex := P;
  ListaSelecaoClick(Self);
end;

procedure TFormVlValidos.BtnNovoClick(Sender: TObject);
begin
  if TamanhoCmp <= 0 then
  begin
    Mensagem('Necessário informar o tamanho do campo!', modAdvertencia, [modOk]);
    exit;
  end;
  EdValor.Enabled := True;
  EdDescricao.Enabled := True;
  ListaSelecao.Items.Add(Format('%-'+Trim(IntToStr(TamanhoCmp))+'s',[''])+'');
  ListaSelecao.ItemIndex := ListaSelecao.Items.Count-1;
  ListaSelecaoClick(Self);
  EdValor.SetFocus;
end;

procedure TFormVlValidos.BtnConfirmaClick(Sender: TObject);
begin
  EdValor.Enabled := False;
  EdDescricao.Enabled := False;
  if ListaSelecao.ItemIndex < 0 then
    exit;
  ListaSelecao.Items[ListaSelecao.ItemIndex] := Format('%-'+Trim(IntToStr(TamanhoCmp))+'s',[EdValor.Text])+EdDescricao.Text;
  BtnNovo.SetFocus;
end;

procedure TFormVlValidos.BtnMoveParaCimaClick(Sender: TObject);
Var
  Origem_Valor,Origem_Descricao: String;
  Destino_Valor,Destino_Descricao: String;
begin
  if ListaSelecao.ItemIndex-1 < 0 then
    exit;
  Origem_Valor     := EdValor.Text;
  Origem_Descricao := EdDescricao.Text;

  Destino_Valor    := Copy(ListaSelecao.Items[ListaSelecao.ItemIndex-1],01,TamanhoCmp);
  Destino_Descricao:= Copy(ListaSelecao.Items[ListaSelecao.ItemIndex-1],TamanhoCmp+01,255);

  ListaSelecao.Items[ListaSelecao.ItemIndex-1] := Format('%-'+Trim(IntToStr(TamanhoCmp))+'s',[Origem_Valor])+Origem_Descricao;

  ListaSelecao.Items[ListaSelecao.ItemIndex]   := Format('%-'+Trim(IntToStr(TamanhoCmp))+'s',[Destino_Valor])+Destino_Descricao;

  ListaSelecao.ItemIndex := ListaSelecao.ItemIndex - 1;
  ListaSelecaoClick(Self);
end;

procedure TFormVlValidos.BtnMoveParaBaixoClick(Sender: TObject);
Var
  Origem_Valor,Origem_Descricao: String;
  Destino_Valor,Destino_Descricao: String;
begin
  if ListaSelecao.ItemIndex+1 > ListaSelecao.Items.Count-1 then
    exit;
  Origem_Valor     := EdValor.Text;
  Origem_Descricao := EdDescricao.Text;

  Destino_Valor    := Copy(ListaSelecao.Items[ListaSelecao.ItemIndex+1],01,TamanhoCmp);
  Destino_Descricao:= Copy(ListaSelecao.Items[ListaSelecao.ItemIndex+1],TamanhoCmp+01,255);

  ListaSelecao.Items[ListaSelecao.ItemIndex+1] := Format('%-'+Trim(IntToStr(TamanhoCmp))+'s',[Origem_Valor])+Origem_Descricao;

  ListaSelecao.Items[ListaSelecao.ItemIndex]   := Format('%-'+Trim(IntToStr(TamanhoCmp))+'s',[Destino_Valor])+Destino_Descricao;

  ListaSelecao.ItemIndex := ListaSelecao.ItemIndex + 1;
  ListaSelecaoClick(Self);
end;

procedure TFormVlValidos.ListaSelecaoDblClick(Sender: TObject);
begin
  EdValor.Enabled := True;
  EdDescricao.Enabled := True;
  EdValor.SelectAll;
  EdValor.SetFocus;
end;

end.
