unit Paginas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls;

type
  TFormPaginas = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListPg: TListBox;
    ToolBar1: TToolBar;
    BtnIncluir: TToolButton;
    BtnExcluir: TToolButton;
    ToolButton1: TToolButton;
    BtnEditar: TToolButton;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure ListPgClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure ListPgDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPaginas: TFormPaginas;

implementation

{$R *.DFM}

uses Princ, Rotinas;

procedure TFormPaginas.BtnIncluirClick(Sender: TObject);
var
  NewString: String;
begin
  if ListPg.Items.Count = 11 then
  begin
    Mensagem('Limite Máximo de Páginas: 11',ModAdvertencia,[ModOk]);
    exit;
  end;
  NewString := 'Complemento';
  if InputQuery('Nova Página: "'+NewString+'"', 'Informe o nome da página ...', NewString) then
  begin
    ListPg.Items.Add(NewString);
    ListPg.ItemIndex := ListPg.Items.Count -1;
    ListPgClick(Self);
  end;
end;

procedure TFormPaginas.BtnExcluirClick(Sender: TObject);
var
  P: Integer;
begin
  P := ListPg.ItemIndex;
  if (P < 1) or (P < ListPg.Items.Count-1) then
  begin
    Mensagem('A Página "'+ListPg.Items[P]+'" não pode ser excluida !',ModAdvertencia,[ModOK]);
    exit;
  end;
  //if P < FormEntradaDados.TabPaginas.Tabs.Count then
  //begin
  //  FormEntradaDados.TabPaginas.TabIndex := P;
  //  FormEntradaDados.TabPaginasClick(Self);
  //  if FormEntradaDados.DsnRegister.DsnStage.ControlCount > 0 then
  //  begin
  //    Mensagem('A Página "'+ListPg.Items[P]+'" não está vazia !',ModAdvertencia,[ModOK]);
  //    exit;
  //  end;
  //end;
  if Mensagem('Excluir a Página "'+ListPg.Items[P]+'" ?' ,ModConfirmacao,[ModSim, ModNao]) = mrno then
    exit;
  ListPg.Items.Delete(P);
  if P - 1 > -1 then Dec(P) else P := 0;
  ListPg.ItemIndex := P;
  ListPgClick(Self);
end;

procedure TFormPaginas.ListPgClick(Sender: TObject);
begin
  if ListPg.ItemIndex > -1 then
    BtnEditar.Enabled := True
  else
    BtnEditar.Enabled := False;
  if (ListPg.ItemIndex > 0) and (ListPg.ItemIndex = ListPg.Items.Count-1) then
    BtnExcluir.Enabled := True
  else
    BtnExcluir.Enabled := False;
end;

procedure TFormPaginas.BtnEditarClick(Sender: TObject);
var
  P: Integer;
  NewString: String;
begin
  P := ListPg.ItemIndex;
  if P < 0 then
    exit;
  NewString := ListPg.Items[P];
  if InputQuery('Página: "'+NewString+'"', 'Informe o nome da página ...', NewString) then
    ListPg.Items[P] := NewString;
end;

procedure TFormPaginas.ListPgDblClick(Sender: TObject);
begin
  BtnEditarClick(Self);
end;

end.
