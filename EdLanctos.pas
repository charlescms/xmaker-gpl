unit EdLanctos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Estrutura_Case,
  StdCtrls, Mask, ToolEdit, RXDBCtrl, DBCtrls, ExtCtrls, db;

type
  TFormLanctos = class(TForm)
    Bevel1: TBevel;
    BtnOk: TButton;
    BtnFechar: TButton;
    PR_EdTab_alvo: TDBComboBox;
    Label29: TLabel;
    Label3: TLabel;
    PR_EdCondicao_inclusao: TRxDBComboEdit;
    PnCampos: TPanel;
    GridCampos: TListBox;
    Panel1: TPanel;
    GridValores: TListBox;
    Image2: TImage;
    Image3: TImage;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PR_EdTab_alvoExit(Sender: TObject);
    procedure GridCamposDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure PR_EdCondicao_inclusaoButtonClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure GridValoresDblClick(Sender: TObject);
    procedure GridValoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridCamposClick(Sender: TObject);
    procedure GridValoresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLanctos: TFormLanctos;

implementation

uses Abertura, Rotinas, Tabela, Expressao;

{$R *.DFM}

procedure TFormLanctos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    {Atua como a tecla TAB}
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormLanctos.PR_EdTab_alvoExit(Sender: TObject);
var
  qy_Tabela: TTabela;
  I, P: Integer;
  Lst_1, Lst_2: TStringList;
begin
  GridCampos.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DCAMPOST.DataBase;
    Transaction := TabGlobal_i.DCAMPOST.Transaction;

    Sql.Text := 'Select Numero From Tabelas Where UPPER(Nome) = '+#39+Trim(UpperCase(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo))+#39;
    Abrir;
    First;

    if Trim(Fields[0].AsString) <> '' then
    begin
      Sql.Text := 'Select Numero, Nome, Titulo_C, Sequencia, Extra, Calculado, Chave From CamposT Where Numero = '+Fields[0].AsString+' Order By Sequencia';
      Close;
      Abrir;
      First;
      while not Eof do
      begin
        if (Trim(Fields[1].AsString) <> '') and
           (Fields[4].AsInteger = 0) and
           (Fields[5].AsInteger = 0) then
        begin
          if Fields[6].AsInteger = 1 then
            GridCampos.Items.AddObject(Trim(Fields[1].AsString),TObject(0))
          else
            GridCampos.Items.AddObject(Trim(Fields[1].AsString),TObject(1));
        end;
        Next;
      end;
    end;
    Close;
    Free;
  end;
  GridValores.Clear;
  Lst_1 := TStringList.Create;
  Lst_2 := TStringList.Create;
  Lst_1.AddStrings(TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo);
  Lst_2.AddStrings(TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo);
  for I:=0 to GridCampos.Items.Count-1 do
  begin
    P := TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo.IndexOf(GridCampos.Items[I]);
    if P < 0 then
    begin
      Lst_1.Add(GridCampos.Items[I]);
      Lst_2.Add('');
      GridValores.Items.Add('');
    end
    else
     GridValores.Items.Add(TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo[P]);
  end;
  //TabGlobal_i.DPROCESSOS.Modifica;
  TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_ALVO')).AsString := Lst_1.Text;
  TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_VALOR')).AsString := Lst_2.Text;
  Lst_1.Clear;
  Lst_2.Clear;
  for I:=0 to TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo.Count-1 do
    if GridCampos.Items.IndexOf(TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo[I]) > -1 then
    begin
      Lst_1.Add(TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo[I]);
      Lst_2.Add(TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo[I]);
    end;
  TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_ALVO')).AsString := Lst_1.Text;
  TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_VALOR')).AsString := Lst_2.Text;
  //TabGlobal_i.DPROCESSOS.Salva;
  Lst_1.Free;
  Lst_2.Free;
end;

procedure TFormLanctos.GridCamposDrawItem(Control: TWinControl;
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
    if Integer(Items.Objects[Index]) = 0 then
      Image := Image3
    else
      Image := Image2;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormLanctos.PR_EdCondicao_inclusaoButtonClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
  I: Integer;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    FormExpressao.ExprMemo.Text := PR_EdCondicao_inclusao.Text;
    if FormExpressao.ShowModal = mrOk then
    begin
      TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Conteudo := '';
      for I:=0 to FormExpressao.ExprMemo.Lines.Count-1 do
        if Trim(FormExpressao.ExprMemo.Lines[I]) <> '' then
          TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Conteudo := TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Conteudo +
          FormExpressao.ExprMemo.Lines[I];
      PR_EdCondicao_Inclusao.SetFocus;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

procedure TFormLanctos.BtnOkClick(Sender: TObject);
begin
  if Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo) = '' then
  begin
    Mensagem('Necessário informar a tabela alvo do processo !',ModAdvertencia,[modOk]);
    PR_EdTab_alvo.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TFormLanctos.GridValoresDblClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
  I: Integer;
begin
  if GridValores.ItemIndex > -1 then
  begin
    FormExpressao := TFormExpressao.Create(Application);
    Try
      FormExpressao.InsFuncBtn.Visible := False;
      FormExpressao.SQL := True;
      FormExpressao.Tab_Alvo := TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo;
      FormExpressao.ExprMemo.Text := GridValores.Items[GridValores.ItemIndex];
      if FormExpressao.ShowModal = mrOk then
      begin
        GridValores.Items[GridValores.ItemIndex] := '';
        for I:=0 to FormExpressao.ExprMemo.Lines.Count-1 do
          if Trim(FormExpressao.ExprMemo.Lines[I]) <> '' then
            GridValores.Items[GridValores.ItemIndex] := GridValores.Items[GridValores.ItemIndex] +
            FormExpressao.ExprMemo.Lines[I];
        GridValores.SetFocus;
      end;
    Finally
      FormExpressao.Free;
    end;
  end;
end;

procedure TFormLanctos.GridValoresKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then
    GridValoresDblClick(Self);
end;

procedure TFormLanctos.GridCamposClick(Sender: TObject);
begin
  GridCampos.Color := clWindow;
  GridValores.Color := clBtnFace;
  GridValores.ItemIndex := GridCampos.ItemIndex;
end;

procedure TFormLanctos.GridValoresClick(Sender: TObject);
begin
  GridValores.Color := clWindow;
  GridCampos.Color := clBtnFace;
  GridCampos.ItemIndex := GridValores.ItemIndex;
end;

end.
