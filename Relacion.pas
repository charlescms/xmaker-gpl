unit Relacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, IBQuery, Menus, ComCtrls;

type
  TFormRelacionamento = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdTabela: TEdit;
    ComboTab: TComboBox;
    CamposEdTabela: TListBox;
    CamposComboTab: TListBox;
    CamposRelacionados: TListBox;
    BtnInserir: TBitBtn;
    Panel1: TPanel;
    Image2: TImage;
    PopupMenu1: TPopupMenu;
    Excluir1: TMenuItem;
    BtnOk: TButton;
    BtnFechar: TButton;
    BtnExcluir: TSpeedButton;
    procedure BtnInserirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComboTabExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOkClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure CamposRelacionadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CamposEdTabelaDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CamposRelacionadosClick(Sender: TObject);
  private
    { Private declarations }
    ListaNrTab: TStringList;
    IndiceTab: Integer;
  public
    { Public declarations }
    Tipo: Integer;
    Tab_Estrangeira, Campo_Chave_1, Campo_Chave_2: String;
  end;

var
  FormRelacionamento: TFormRelacionamento;

implementation

uses Princ, Rotinas, Abertura, Tabela;

{$R *.DFM}

procedure TFormRelacionamento.FormShow(Sender: TObject);
var
  qy_Tabela: TTabela;
  Lst_Array, Lst_Array2: TStringList;
  I, P: Integer;
begin
  ListaNrTab := TStringList.Create;
  ComboTab.Items.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DTABELAS.DataBase;
    Transaction := TabGlobal_i.DTABELAS.Transaction;
    Sql.Text := 'Select Numero, Nome, Titulo_T From Tabelas Order By Nome';
    Abrir;
    First;
    while not Eof do
    begin
      if Trim(Fields[1].AsString) <> '' then
      begin
        ComboTab.Items.Add(Fields[1].AsString); //+ ' - ' + Fields[2].AsString);
        ListaNrTab.Add(IntToStr(Fields[0].AsInteger));
      end;
      Next;
    end;
    Close;
    Free;
  end;
  ComboTab.ItemIndex := ComboTab.Items.IndexOf(Tab_Estrangeira);
  IndiceTab := -1;
  if ComboTab.ItemIndex > -1 then
  begin
    ComboTabExit(Self);
    Lst_Array := TStringList.Create;
    Lst_Array2 := TStringList.Create;
    StringToArray(Campo_Chave_1,';',Lst_Array);
    StringToArray(Campo_Chave_2,';',Lst_Array2);
    if Lst_Array.Count = Lst_Array2.Count then
      for I:=0 to Lst_Array.Count-1 do
         CamposRelacionados.Items.Add(Lst_Array[I] + ' <-> ' + Lst_Array2[I]);
    Lst_Array.Free;
    Lst_Array2.Free;
  end;
  IndiceTab := ComboTab.ItemIndex;
  CamposEdTabela.SetFocus;
  CamposRelacionadosClick(Self);
end;

procedure TFormRelacionamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ListaNrTab.Free;
end;

procedure TFormRelacionamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormRelacionamento.BtnInserirClick(Sender: TObject);
begin
  if CamposEdTabela.ItemIndex < 0 then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia,[modOk]);
    CamposEdTabela.SetFocus;
    exit;
  end;
  if CamposComboTab.ItemIndex < 0 then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia,[modOk]);
    CamposComboTab.SetFocus;
    exit;
  end;
  CamposRelacionados.Items.Add(CamposEdTabela.Items[CamposEdTabela.ItemIndex] + ' <-> ' +CamposComboTab.Items[CamposComboTab.ItemIndex]);
end;

procedure TFormRelacionamento.ComboTabExit(Sender: TObject);
Var
  qy_Tabela: TTabela;
begin
  if ComboTab.ItemIndex = IndiceTab then exit;
  CamposComboTab.Items.Clear;
  CamposRelacionados.Items.Clear;
  if ComboTab.Text = '' then
    exit;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DCAMPOST.DataBase;
    Transaction := TabGlobal_i.DCAMPOST.Transaction;
    Sql.Text := 'Select Nome, Nome_Fisico, Extra From CamposT Where Numero = '+ListaNrTab[ComboTab.ItemIndex]+' Order By Sequencia';
    Abrir;
    First;
    while not Eof do
    begin
      if (Trim(Fields[0].AsString) <> '') and
         (Fields[2].AsInteger = 0) then
        CamposComboTab.Items.Add(IIF(Trim(Fields[1].AsString)<>'',Trim(Fields[1].AsString),Trim(Fields[0].AsString)));
      Next;
    end;
    Close;
    Free;
  end;
  CamposEdTabela.ItemIndex := 0;
  CamposComboTab.ItemIndex := 0;
  IndiceTab := ComboTab.ItemIndex;
end;

procedure TFormRelacionamento.BtnOkClick(Sender: TObject);
Var
  I: Integer;
begin
  if CamposRelacionados.Items.Count < 1 then
  begin
    Mensagem('Campo(s) não associados !',ModAdvertencia,[modOk]);
    CamposComboTab.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  if (Tipo = 3) and (CamposRelacionados.Items.Count <> CamposEdTabela.Items.Count) then
  begin
    Mensagem('Todos os campos chave deverão estar relacionados !',ModAdvertencia,[modOk]);
    CamposEdTabela.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TFormRelacionamento.Excluir1Click(Sender: TObject);
begin
  if CamposRelacionados.ItemIndex < 0 then
  begin
    Mensagem('Associação não selecionada !',ModAdvertencia,[modOk]);
    CamposRelacionados.SetFocus;
    exit;
  end;
  if Mensagem('Excluir Associação ?',ModConfirmacao,[modSim,modNao]) = mrYes then
  begin
    CamposRelacionados.Items.Delete(CamposRelacionados.ItemIndex);
    if CamposRelacionados.Items.Count > 0 then
      CamposRelacionados.ItemIndex := 0;
    CamposRelacionadosClick(Self);
  end;
end;

procedure TFormRelacionamento.CamposRelacionadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    Excluir1Click(Self);
end;

procedure TFormRelacionamento.CamposEdTabelaDrawItem(Control: TWinControl;
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
    Image := Image2;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormRelacionamento.CamposRelacionadosClick(Sender: TObject);
begin
  BtnExcluir.Enabled := CamposRelacionados.ItemIndex > -1;
end;

end.
