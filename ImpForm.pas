unit ImpForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, CheckLst;

type
  TFormImpForm = class(TForm)
    FieldsLB: TCheckListBox;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    SelecionarTudo1: TMenuItem;
    DesmarcarTudo1: TMenuItem;
    Image1: TImage;
    procedure FieldsLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure SelecionarTudo1Click(Sender: TObject);
    procedure DesmarcarTudo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImpForm: TFormImpForm;

implementation

{$R *.DFM}

procedure TFormImpForm.FieldsLBDrawItem(Control: TWinControl;
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
    Image := Image1;
    Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormImpForm.SelecionarTudo1Click(Sender: TObject);
var
  i: Integer;
begin
  for I:=0 to FieldsLB.Items.Count-1 do FieldsLB.Checked[I] := True;
end;

procedure TFormImpForm.DesmarcarTudo1Click(Sender: TObject);
var
  i: Integer;
begin
  for I:=0 to FieldsLB.Items.Count-1 do FieldsLB.Checked[I] := False;
end;

end.
