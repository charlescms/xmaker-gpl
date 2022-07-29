unit CamposSel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SynEdit, CheckLst, Menus, Buttons, ComCtrls;

type
  TFormCamposSel = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label21: TLabel;
    BtnInserirCmp: TSpeedButton;
    BtnExcluirCmp: TSpeedButton;
    Label22: TLabel;
    BtnMoveParaCima: TSpeedButton;
    BtnMoveParaBaixo: TSpeedButton;
    CamposOrigem: TListBox;
    CamposIndices: TListBox;
    Panel1: TPanel;
    Image2: TImage;
    Image3: TImage;
    Button1: TButton;
    Button2: TButton;
    procedure CamposOrigemDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnInserirCmpClick(Sender: TObject);
    procedure BtnExcluirCmpClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCamposSel: TFormCamposSel;

implementation

{$R *.DFM}

procedure TFormCamposSel.CamposOrigemDrawItem(Control: TWinControl;
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
    if Tag = 100  then
      Image := Image2
    else
    begin
      if Integer(Items.Objects[Index]) = 0 then
        Image := Image3
      else
        Image := Image2;
    end;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormCamposSel.BtnInserirCmpClick(Sender: TObject);
begin
  if (CamposOrigem.ItemIndex > -1) and (CamposIndices.Enabled) then
  begin
    CamposIndices.Items.Add(CamposOrigem.Items[CamposOrigem.ItemIndex]);
    CamposIndices.ItemIndex := CamposIndices.Items.Count-1;
  end;
end;

procedure TFormCamposSel.BtnExcluirCmpClick(Sender: TObject);
Var
  I, P: Integer;
begin
  if (CamposIndices.ItemIndex > -1) and (CamposIndices.Enabled) then
  begin
    P := CamposIndices.ItemIndex;
    CamposIndices.Items.Delete(CamposIndices.ItemIndex);
    if P-1 >= 0 then
      CamposIndices.ItemIndex := P-1
    else
      CamposIndices.ItemIndex := 0;
  end;
end;

procedure TFormCamposSel.BtnMoveParaCimaClick(Sender: TObject);
Var
  Atual, Anterior: String;
  I: Integer;
begin
  if not BtnMoveParaCima.Enabled then exit;
  if (CamposIndices.ItemIndex > -1) and (CamposIndices.Enabled) then
    if CamposIndices.ItemIndex - 1 >= 0 then
    begin
      Atual    := CamposIndices.Items[CamposIndices.ItemIndex];
      Anterior := CamposIndices.Items[CamposIndices.ItemIndex-1];
      CamposIndices.Items[CamposIndices.ItemIndex]   := Anterior;
      CamposIndices.Items[CamposIndices.ItemIndex-1] := Atual;
      CamposIndices.ItemIndex := CamposIndices.ItemIndex-1;
    end;
end;

procedure TFormCamposSel.BtnMoveParaBaixoClick(Sender: TObject);
Var
  Atual,Proximo: String;
  I: Integer;
begin
  if not BtnMoveParaBaixo.Enabled then exit;
  if (CamposIndices.ItemIndex > -1) and (CamposIndices.Enabled) then
    if CamposIndices.ItemIndex + 1 <= CamposIndices.Items.Count-1 then
    begin
      Atual   := CamposIndices.Items[CamposIndices.ItemIndex];
      Proximo := CamposIndices.Items[CamposIndices.ItemIndex+1];
      CamposIndices.Items[CamposIndices.ItemIndex]   := Proximo;
      CamposIndices.Items[CamposIndices.ItemIndex+1] := Atual;
      CamposIndices.ItemIndex := CamposIndices.ItemIndex+1;
    end;
end;

procedure TFormCamposSel.FormShow(Sender: TObject);
begin
  CamposOrigem.SetFocus;
end;

end.
