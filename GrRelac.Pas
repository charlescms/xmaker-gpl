unit GrRelac;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, IBQuery, Db, IBCustomDataSet;

type
  TFormGridRelac = class(TForm)
    BtnOk: TButton;
    BtnFechar: TButton;
    Bevel1: TBevel;
    Label6: TLabel;
    EdFormulario: TComboBox;
    FieldsLB_1: TListBox;
    Image1: TImage;
    EdEdicao: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FieldsLB_1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FieldsLB_1Click(Sender: TObject);
  private
    { Private declarations }
    NrTabela_Rel: Integer;
    procedure ListaFormFilho;
  public
    { Public declarations }
    NomeGrid: String;
  end;

var
  FormGridRelac: TFormGridRelac;

implementation

uses Princ, Rotinas, Abertura, Tabela, FDesigner;

{$R *.DFM}

procedure TFormGridRelac.ListaFormFilho;
var
  qy_Tabela: TTabela;
begin
  NrTabela_Rel := -1;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DTABELAS.DataBase;
    Transaction := TabGlobal_i.DTABELAS.Transaction;
    Sql.Text := 'Select Numero, Nome From Tabelas Where Upper(Nome) = '+#39+UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))+#39;
    Abrir;
    First;
    if not eof then
      NrTabela_Rel := Fields[0].AsInteger;
    Close;
    Free;
  end;
  
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    Database := TabGlobal_i.DFORMULARIO.DataBase;
    Transaction := TabGlobal_i.DFORMULARIO.Transaction;
    Sql.Text := 'Select Numero, Nome, Titulo_F From Formulario where (Tipo = 2) and (Tabela = '+IntToStr(NrTabela_Rel)+') order by Nome';
    Abrir;
    First;
    EdFormulario.Items.Clear;
    while not Eof do
    begin
      EdFormulario.Items.AddObject(Fields[1].AsString + ' - ' +Fields[2].AsString,TObject(Fields[0].AsInteger));
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TFormGridRelac.FormShow(Sender: TObject);
begin
  if FieldsLB_1.Items.Count > 0 then
    FieldsLB_1.ItemIndex := 0;
  FieldsLB_1Click(Self);
end;

procedure TFormGridRelac.FieldsLB_1DrawItem(Control: TWinControl;
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

procedure TFormGridRelac.FieldsLB_1Click(Sender: TObject);
var
  I: Integer;
begin
  if FieldsLB_1.ItemIndex = -1 then exit;
  ListaFormFilho;
  TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+FormDesigner_Net.CurrentForm_Avulso.NrTabela+' AND SEQUENCIA = '+IntToStr(Integer(FieldsLB_1.Items.Objects[FieldsLB_1.ItemIndex]));
  TabGlobal_i.DRELACIONA.AtualizaSql;
  if TabGlobal_i.DRELACIONA.EDICAO_DIRETA.Conteudo = 1 then
    EdEdicao.Checked := True
  else
    EdEdicao.Checked := False;
  for I:=0 to EdFormulario.Items.Count-1 do
    if UpperCase(Trim(Copy(Edformulario.Items[I],01,Pos('-',EdFormulario.Items[I])-1))) = UpperCase(Trim(TabGlobal_i.DRELACIONA.FORMULARIO.Conteudo)) then
    begin
      EdFormulario.ItemIndex := I;
      Break;
    end;
end;

end.
