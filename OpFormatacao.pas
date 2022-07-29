unit OpFormatacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TFormAutoForma = class(TForm)
    Button1: TButton;
    Button2: TButton;
    FieldsLB: TListBox;
    Image2: TImage;
    Label1: TLabel;
    BtnMoveParaBaixo: TSpeedButton;
    BtnMoveParaCima: TSpeedButton;
    Image1: TImage;
    Titulo: TRadioGroup;
    Distribuicao: TRadioGroup;
    EdRXLib: TCheckBox;
    procedure FieldsLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAutoForma: TFormAutoForma;

implementation

{$R *.DFM}

procedure TFormAutoForma.FieldsLBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  Image: TImage;
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    if Integer(Items.Objects[Index]) = 1 then
      Image := Image2
    else
      Image := Image1;
    Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormAutoForma.BtnMoveParaBaixoClick(Sender: TObject);
var
  Pos_i,Pos_f: Integer;
  Atual: String;
  I_Atual: Integer;
begin
  if FieldsLB.ItemIndex < 0 then
    exit;
  Pos_i := FieldsLB.ItemIndex;
  Atual := FieldsLB.Items[Pos_i];
  I_Atual := Integer(FieldsLB.Items.Objects[Pos_i]);
  Pos_f := Pos_i + 1;
  if Pos_f > FieldsLB.Items.Count-1 then
    Pos_f := 0;
  FieldsLB.Items[Pos_i] := FieldsLB.Items[Pos_f];
  FieldsLB.Items.Objects[Pos_i] := FieldsLB.Items.Objects[Pos_f];
  FieldsLB.Items[Pos_f] := Atual;
  FieldsLB.Items.Objects[Pos_f] := TObject(I_Atual);
  FieldsLB.ItemIndex := Pos_f;
  FieldsLB.Selected[Pos_f] := True;
end;

procedure TFormAutoForma.BtnMoveParaCimaClick(Sender: TObject);
var
  Pos_i,Pos_f: Integer;
  Atual: String;
  I_Atual: Integer;
begin
  if FieldsLB.ItemIndex < 0 then
    exit;
  Pos_i := FieldsLB.ItemIndex;
  Atual := FieldsLB.Items[Pos_i];
  I_Atual := Integer(FieldsLB.Items.Objects[Pos_i]);
  Pos_f := Pos_i - 1;
  if Pos_f < 0 then
    Pos_f := FieldsLB.Items.Count-1;
  FieldsLB.Items[Pos_i] := FieldsLB.Items[Pos_f];
  FieldsLB.Items.Objects[Pos_i] := FieldsLB.Items.Objects[Pos_f];
  FieldsLB.Items[Pos_f] := Atual;
  FieldsLB.Items.Objects[Pos_f] := TObject(I_Atual);
  FieldsLB.ItemIndex := Pos_f;
  FieldsLB.Selected[Pos_f] := True;
end;

end.
