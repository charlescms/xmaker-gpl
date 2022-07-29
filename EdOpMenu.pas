unit EdOpMenu;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Mask, ToolEdit, XLookUp, XNum, Messages, DB;

type
  TFormEdOpMenu = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    BtnAtualizar: TButton;
    BtnCancelar: TButton;
    Label1: TLabel;
    EdTitulo: TEdit;
    Label7: TLabel;
    EdID: TXNumEdit;
    Label5: TLabel;
    ComboPrograma: TXDBLookUp;
    Label2: TLabel;
    EdEXE: TComboEdit;
    Label10: TLabel;
    EdImagem: TComboBox;
    Label3: TLabel;
    EdTitulo_1: TEdit;
    Label8: TLabel;
    EdID_1: TXNumEdit;
    Label6: TLabel;
    EdEXE_1: TComboEdit;
    Label9: TLabel;
    EdImagem_1: TComboBox;
    Label4: TLabel;
    EdTitulo_2: TEdit;
    Label11: TLabel;
    EdID_2: TXNumEdit;
    Label13: TLabel;
    EdImagem_2: TComboBox;
    BtnCodificar: TBitBtn;
    Label12: TLabel;
    EdEXE_2: TComboEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdImagemDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnCodificarClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdEXEButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Titulo: TEdit;
    ID: TXNumEdit;
    Programa: TXDBLookUp;
    EXE: TComboEdit;
    B_Imagem: TComboBox;
  end;

var
  FormEdOpMenu: TFormEdOpMenu;

implementation

uses ObjMenu, MiniEditor, Abertura, Rotinas;

{$R *.DFM}

procedure TFormEdOpMenu.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormEdOpMenu.EdImagemDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  Image: TImage;
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TComboBox(Control) do
  begin
    Canvas.FillRect(ARect);
    if Items[Index] <> '-1' then
    begin
      Image := TImage.Create(Self);
      FormMenuObject.TreeViewMenu_1.Images.GetBitmap(Index-1,Image.Picture.BitMap);
      if Image <> nil then
        Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
         Image.Picture.Bitmap.TransparentColor);
      Image.Free;
    end;
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormEdOpMenu.BtnCodificarClick(Sender: TObject);
begin
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.ExcluirEvento.Visible := False;
    if PageControl1.ActivePageIndex = 0 then
      FormMiniEditor.E_Cabecalho.Lines.Text := 'procedure TFormPrincipal.'+Trim(FormMenuObject.TabelaPrincipal.FieldByName('NOME').AsString)+'Click(Opcao: Integer);'
    else
      FormMiniEditor.E_Cabecalho.Lines.Text := 'procedure TFormPrincipal.'+Trim(FormMenuObject.TabelaPrincipal.FieldByName('NOME').AsString)+'Click(Sender: TObject);';
    if Trim(FormMenuObject.TabelaPrincipal.FieldByName('AVULSO').AsString) = '' then
    begin
      FormMiniEditor.E_Metodo.Lines.Clear;
      FormMiniEditor.E_Metodo.Lines.Add('// variáveis ...');
      FormMiniEditor.E_Metodo.Lines.Add('');
      FormMiniEditor.E_Metodo.Lines.Add('begin');
      if PageControl1.ActivePageIndex = 0 then
        FormMiniEditor.E_Metodo.Lines.Add('  if not LiberaAcesso(Opcao, 0) then  // usuário possui acesso ?')
      else if PageControl1.ActivePageIndex = 1 then
        FormMiniEditor.E_Metodo.Lines.Add('  if not LiberaAcesso(TMenuItem(Sender).Tag, 1) then  // usuário possui acesso ?')
      else
        FormMiniEditor.E_Metodo.Lines.Add('  if not LiberaAcesso(TToolButton(Sender).Tag, 2) then  // usuário possui acesso ?');
      FormMiniEditor.E_Metodo.Lines.Add('    Abort;  // acesso negado, retorna ...');
      FormMiniEditor.E_Metodo.Lines.Add('  ');
      FormMiniEditor.E_Metodo.Lines.Add('end;');
      FormMiniEditor.E_Metodo.Modified := True;
      FormMiniEditor.Posicao_Y := 6;
      FormMiniEditor.Posicao_X := 3;
    end
    else
      FormMiniEditor.E_Metodo.Lines.Text := FormMenuObject.TabelaPrincipal.FieldByName('AVULSO').AsString;
    if FormMiniEditor.ShowModal = mrOk then
    begin
      TBlobField(FormMenuObject.TabelaPrincipal.FieldByName('AVULSO')).AsString := FormMiniEditor.E_METODO.Lines.Text;
    end;
  Finally
    FormMiniEditor.Free;
  end;
  BtnAtualizar.SetFocus;
end;

procedure TFormEdOpMenu.BtnAtualizarClick(Sender: TObject);
var
  SubMenu: Boolean;
begin
  if Trim(Titulo.Text) = '' then
  begin
    Mensagem('Necessário informar Título !',ModAdvertencia, [ModOk]);
    Titulo.SetFocus;
    exit;
  end;
  if BtnCodificar.Enabled then
   if Trim(FormMenuObject.TabelaPrincipal.FieldByName('AVULSO').AsString) = '' then
   begin
     Mensagem('Necessário codificar !',ModAdvertencia, [ModOk]);
     BtnCodificar.SetFocus;
     exit;
   end;

  FormMenuObject.Arvore_c.Selected.Text := Titulo.Text;
  FormMenuObject.Arvore_c.Selected.Data := TObject(StrToInt(FloatToStr(ID.Value)));

  SubMenu := False;
  FormMenuObject.TabelaPrincipal.FieldByName('TITULO_M').AsString   := Titulo.Text;
  FormMenuObject.TabelaPrincipal.FieldByName('PROG_EXE').AsString   := EXE.Text;
  FormMenuObject.TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger := StrToIntDef(FloatToStr(ID.Value),0);
  FormMenuObject.TabelaPrincipal.FieldByName('IMAGEM').AsInteger := B_Imagem.ItemIndex - 1;
  FormMenuObject.TabelaPrincipal.Post;
  FormMenuObject.Arvore_c.Selected.ImageIndex    := B_Imagem.ItemIndex - 1;
  FormMenuObject.Arvore_c.Selected.SelectedIndex := B_Imagem.ItemIndex - 1;
  FormMenuObject.Modificou := True;

  FormMenuObject.Novo    := False;
  FormMenuObject.Arvore_c.SetFocus;
  FormMenuObject.AtualizaTree;
  Close;
end;

procedure TFormEdOpMenu.BtnCancelarClick(Sender: TObject);
begin
  FormMenuObject.TabelaPrincipal.Cancela;
  if FormMenuObject.Novo then
    FormMenuObject.BtnDeletarClick(Self);
  FormMenuObject.Novo  := False;
  FormMenuObject.Arvore_c.SetFocus;
  FormMenuObject.AtualizaTree;
end;

procedure TFormEdOpMenu.FormShow(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0 : begin
          Titulo   := EdTitulo;
          ID       := EdID;
          Programa := ComboPrograma;
          EXE      := EdEXE;
          B_Imagem := EdImagem;
          TabGlobal_i.DFORMULARIO.AssociaChaveEstrangeira(ComboPrograma, TabGlobal_i.DFORMULARIO.NUMERO.Nome,
                                   [TabGlobal_i.DFORMULARIO.NOME.Nome, TabGlobal_i.DFORMULARIO.TITULO_F.Nome]);
        end;
    1 : begin
          Titulo   := EdTitulo_1;
          ID       := EdID_1;
          EXE      := EdEXE_1;
          Programa := ComboPrograma;
          B_Imagem := EdImagem_1;
        end;
    2 : begin
          Titulo   := EdTitulo_2;
          ID       := EdID_2;
          EXE      := EdEXE_2;
          Programa := ComboPrograma;
          B_Imagem := EdImagem_2;
        end;
  end;
  B_Imagem.Items.Clear;
  B_Imagem.Items.AddStrings(FormMenuObject.EdImagem.Items);
  Titulo.Text := FormMenuObject.TabelaPrincipal.FieldByName('TITULO_M').AsString;
  ID.Value    := FormMenuObject.TabelaPrincipal.FieldByName('IDENTIFICACAO').AsInteger;
  EXE.Text    := FormMenuObject.TabelaPrincipal.FieldByName('PROG_EXE').AsString;
  B_Imagem.ItemIndex := FormMenuObject.TabelaPrincipal.FieldByName('IMAGEM').AsInteger + 1;

  if FormMenuObject.TabelaPrincipal.FieldByName('TIPO').AsInteger = 1 then
  begin
    Programa.Enabled := False;
    EXE.Enabled         := False;
    BtnCodificar.Enabled  := False;
  end;
  if FormMenuObject.TabelaPrincipal.FieldByName('TIPO').AsInteger = 2 then
    Programa.Enabled := True
  else if FormMenuObject.TabelaPrincipal.FieldByName('TIPO').AsInteger = 3 then
    BtnCodificar.Enabled := True
  else if FormMenuObject.TabelaPrincipal.FieldByName('TIPO').AsInteger = 4 then
  begin
    EXE.Enabled        := True;
  end;
  if PageControl1.ActivePageIndex = 1 then
    EXE.Enabled := True;
  Titulo.SelectAll;
  Titulo.SetFocus;
end;

procedure TFormEdOpMenu.EdEXEButtonClick(Sender: TObject);
begin
  if FormMenuObject.OpenExe.Execute then
  begin
    EXE.Text := '"'+FormMenuObject.OpenExe.FileName+'"';
    EXE.SelectAll;
    EXE.SetFocus;
  end;
end;

procedure TFormEdOpMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FormMenuObject.TabelaPrincipal.Modificacao or
     FormMenuObject.TabelaPrincipal.Inclusao then
    BtnCancelarClick(Self);
end;

end.

