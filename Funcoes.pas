unit Funcoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, ExtCtrls, ComCtrls, SynEdit;

type
  TFormFuncoes = class(TForm)
    Tree1: TTreeView;
    FuncLB: TListBox;
    FuncLabel: TLabel;
    DescrLabel: TLabel;
    Image1: TImage;
    ImageList1: TImageList;
    Button1: TButton;
    Button2: TButton;
    Memo1: TSynEdit;
    procedure FuncLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FuncLBClick(Sender: TObject);
    procedure FuncLBDblClick(Sender: TObject);
    procedure Tree1Change(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
    { Public declarations }
    Retorno: String;
  end;

var
  FormFuncoes: TFormFuncoes;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormFuncoes.FuncLBDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    Canvas.BrushCopy(r, Image1.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image1.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormFuncoes.FormCreate(Sender: TObject);
var
  i: Integer;
  ANode, TreeNode: TTreeNode;
  Ln_Funcao, Lista_Nomes: TStringList;
begin
  FuncLabel.Caption := '';
  DescrLabel.Caption := '';
  if not FileExists(Projeto.PastaGerador + 'Funcoes.Lst') then
  begin
    Mensagem('Arquivo: "'+Projeto.PastaGerador + 'Funcoes.Lst" não encontrado !',modErro,[modOk]);
    exit;
  end;
  Ln_Funcao := TStringList.Create;
  Lista_Nomes := TStringList.Create;
  TreeNode := Tree1.Items.Add(nil, 'Todas as Funções');
  TreeNode.ImageIndex := 0;
  TreeNode.SelectedIndex := 0;
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(Projeto.PastaGerador + 'Funcoes.Lst');
  for I:=0 to Memo1.Lines.Count-1 do
  begin
    if Trim(Memo1.Lines[i]) <> '' then
    begin
      Ln_Funcao.Clear;
      StringToArray(Memo1.Lines[i],'|',Ln_Funcao);
      if (Ln_Funcao.Count = 4) and (Lista_Nomes.IndexOf(Ln_Funcao[0]) < 0) then
      begin
        Lista_Nomes.Add(Ln_Funcao[0]);
        ANode := Tree1.Items.AddChild(TreeNode, Ln_Funcao[0]);
        ANode.ImageIndex := 1;
        ANode.SelectedIndex := 1;
      end;
    end;
  end;
  Ln_Funcao.Free;
  Lista_Nomes.Free;
  Tree1.FullExpand;
  if Tree1.Items.Count > 0 then
    Tree1.Selected := Tree1.Items[0];
end;

procedure TFormFuncoes.FuncLBClick(Sender: TObject);
var
  Ln_Funcao: TStringList;
begin
  Ln_Funcao := TStringList.Create;
  StringToArray(Memo1.Lines[Integer(FuncLB.Items.Objects[FuncLB.ItemIndex])],'|',Ln_Funcao);
  FuncLabel.Caption := Ln_Funcao[2];
  DescrLabel.Caption := Ln_Funcao[3];
  Retorno := Ln_Funcao[2];
  Ln_Funcao.Free;
end;

procedure TFormFuncoes.FuncLBDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormFuncoes.Tree1Change(Sender: TObject; Node: TTreeNode);
var
  Filtro: String;
  i: Integer;
  Ln_Funcao: TStringList;
begin
  Filtro := '';
  Ln_Funcao := TStringList.Create;
  FuncLB.Clear;
  if Tree1.Selected.AbsoluteIndex > 0 then
    Filtro := Node.Text;
  for I:=0 to Memo1.Lines.Count-1 do
  begin
    if Trim(Memo1.Lines[i]) <> '' then
    begin
      Ln_Funcao.Clear;
      StringToArray(Memo1.Lines[i],'|',Ln_Funcao);
      if (Ln_Funcao.Count = 4) and ((Ln_Funcao[0] = Filtro) or (Filtro = '')) then
        FuncLB.Items.AddObject(Ln_Funcao[1],TObject(i));
    end;
  end;
  Ln_Funcao.Free;
  FuncLB.ItemIndex := 0;
  FuncLBClick(nil);
end;

end.
