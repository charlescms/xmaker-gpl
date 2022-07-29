unit LstForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormListaForm = class(TForm)
    DatasetsLB: TListBox;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    procedure DatasetsLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure DatasetsLBDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormListaForm: TFormListaForm;

implementation

uses Abertura, Tabela;

{$R *.DFM}

procedure TFormListaForm.DatasetsLBDrawItem(Control: TWinControl;
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

procedure TFormListaForm.FormShow(Sender: TObject);
var
  i: integer;
  qy_Tabela: TTabela;
begin
  DatasetsLB.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DFORMULARIO.DataBase;
    Transaction := TabGlobal_i.DFORMULARIO.Transaction;
    Sql.Text := 'Select Numero, Nome, Tipo, Titulo_F From Formulario Order By Nome';
    Abrir;
    First;
    while not Eof do
    begin
      if Trim(FieldByName('NOME').AsString) <> '' then
        DatasetsLB.Items.AddObject(FieldByName('NOME').AsString + ' - ' + FieldByName('TITULO_F').AsString,TObject(FieldByName('TIPO').AsInteger));
      Next;
    end;
    qy_Tabela.Free;
  end;
end;

procedure TFormListaForm.DatasetsLBDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
