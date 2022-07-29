unit EdOrdenacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TFormOrdenacao = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Label21: TLabel;
    BtnInserirCmp: TSpeedButton;
    BtnExcluirCmp: TSpeedButton;
    Label22: TLabel;
    BtnMoveParaCima: TSpeedButton;
    BtnMoveParaBaixo: TSpeedButton;
    CamposOrigem: TListBox;
    CamposIndices: TListBox;
    EdDecrescente: TCheckBox;
    Panel1: TPanel;
    Image1: TImage;
    Image3: TImage;
    BtnOk: TButton;
    BtnFechar: TButton;
    procedure FormShow(Sender: TObject);
    procedure CamposOrigemDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnInserirCmpClick(Sender: TObject);
    procedure BtnExcluirCmpClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TabFiltro: Integer;
    TabNome: String;
  end;

var
  FormOrdenacao: TFormOrdenacao;

implementation

uses Tabela, Abertura;

{$R *.DFM}

procedure TFormOrdenacao.FormShow(Sender: TObject);
var
  qy_Tabela: TTabela;
begin
  CamposOrigem.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DCAMPOST.DataBase;
    Transaction := TabGlobal_i.DCAMPOST.Transaction;
    Sql.Text := 'Select Numero, Nome, Titulo_C, Sequencia, Tipo, Extra, Tab_Extra, Campo_Extra, Chave From CamposT Where Numero = '+IntToStr(TabFiltro)+' Order By Sequencia';
    Abrir;
    First;
    while not Eof do
    begin
      if (Trim(Fields[1].AsString) <> '') and (Fields[4].AsInteger <> 5) and
         (Fields[4].AsInteger <> 6) and (Fields[4].AsInteger <> 19) and
         (Fields[4].AsInteger <> 20) and (Fields[4].AsInteger <> 25) then
      begin
        if Fields[5].AsInteger = 1 then
          CamposOrigem.Items.AddObject(Fields[6].AsString + '.' + Fields[7].AsString,TObject(0))
        else
          CamposOrigem.Items.AddObject(TabNome + '.' + Fields[1].AsString,TObject(Fields[8].AsInteger));
      end;
      Next;
    end;
    Close;
    Free;
  end;
  if CamposOrigem.Items.Count > 0 then
    CamposOrigem.ItemIndex := 0;
  CamposOrigem.SetFocus;
end;

procedure TFormOrdenacao.CamposOrigemDrawItem(Control: TWinControl;
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
      Image := Image3
    else
      Image := Image1;
    Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormOrdenacao.BtnInserirCmpClick(Sender: TObject);
Var
  I: Integer;
begin
  if not BtnInserirCmp.Enabled then exit;
  if (CamposOrigem.ItemIndex > -1) and (CamposIndices.Enabled) then
  begin
    CamposIndices.Items.Add(CamposOrigem.Items[CamposOrigem.ItemIndex]);
    CamposIndices.ItemIndex := CamposIndices.Items.Count-1;
  end;
end;

procedure TFormOrdenacao.BtnExcluirCmpClick(Sender: TObject);
Var
  I, P: Integer;
begin
  if not BtnExcluirCmp.Enabled then exit;
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

procedure TFormOrdenacao.BtnMoveParaCimaClick(Sender: TObject);
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

procedure TFormOrdenacao.BtnMoveParaBaixoClick(Sender: TObject);
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

end.
