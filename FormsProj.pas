unit FormsProj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, JvDialogs;

type
  TFormsProjeto = class(TForm)
    EdPesquisa: TEdit;
    BtnOk: TButton;
    BtnCancela: TButton;
    FileListBox1: TFileListBox;
    Lista: TListBox;
    BtnLocalizar: TButton;
    DialogAbrir: TJvOpenDialog;
    BtnModelos: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EdPesquisaChange(Sender: TObject);
    procedure ListaDblClick(Sender: TObject);
    procedure EdPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListaClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Tipo: Integer;
  end;

var
  FormsProjeto: TFormsProjeto;

implementation

{$R *.DFM}

uses Rotinas, BaseD, FDesigner, Princ, Modelos;

procedure TFormsProjeto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TFormsProjeto.FormShow(Sender: TObject);
var
  I: Integer;
  Fonte: String;

  function Filtros_Fontes: String;
  var
    fHighlighters: TStringList;
  begin
    fHighlighters := TStringList.Create;
    BaseDados.GetHighlighters(BaseDados, fHighlighters, FALSE);
    Filtros_Fontes := BaseDados.GetHighlightersFilter(fHighlighters) + 'Todos Arquivos|*.*|';
    fHighlighters.Free;
  end;

begin
  DialogAbrir.DefaultExt  := '';
  DialogAbrir.FilterIndex := 13;
  DialogAbrir.Filter      := Filtros_Fontes;
  Lista.Items.Clear;
  if FormPrincipal.BtnFecharProjeto.Enabled then
  begin
    case Tipo of
      1: begin
           Caption := 'Fontes do Projeto';
           FileListBox1.Mask := '*.pas';
         end;
      2: begin
           Caption := 'Formulários do Projeto';
           FileListBox1.Mask := '*.dfm';
         end;
    end;
    FileListBox1.ApplyFilePath(Projeto.Pasta);
    for I:=0 to FileListBox1.Items.Count-1 do
    begin
      Fonte := TrocaString(FileListBox1.Items[I],'.dfm','.pas',[rfIgnoreCase]);
      if FileExists(Projeto.Pasta + Fonte) then
        Lista.Items.Add(Copy(Fonte,01,Pos('.',Fonte)-1));
    end;
    if Lista.Items.Count > 0 then
      Lista.ItemIndex := 0;
    ListaClick(Self);
    EdPesquisa.SetFocus;
  end
  else
    BtnLocalizar.SetFocus;
end;

procedure TFormsProjeto.EdPesquisaChange(Sender: TObject);
begin
  Lista.Perform(LB_SELECTSTRING,0,LongInt(PChar(EdPesquisa.Text)));
end;

procedure TFormsProjeto.ListaDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormsProjeto.EdPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 40 then
  begin
    if Lista.ItemIndex + 1 < Lista.Items.Count then
    begin
      Lista.ItemIndex := Lista.ItemIndex + 1;
      ListaClick(Self);
    end;
  end
  else if Key = 38 then
  begin
    if Lista.ItemIndex - 1 > -1 then
    begin
      Lista.ItemIndex := Lista.ItemIndex - 1;
      ListaClick(Self);
    end;
  end
  else if Key = VK_NEXT then
  begin
    if Lista.ItemIndex + 18 <= Lista.Items.Count-1 then
      Lista.ItemIndex := Lista.ItemIndex + 18
    else
      Lista.ItemIndex := Lista.Items.Count-1;
    ListaClick(Self);
  end
  else if Key = VK_PRIOR then
  begin
    if Lista.ItemIndex - 18 >= 0 then
      Lista.ItemIndex := Lista.ItemIndex - 18
    else
      Lista.ItemIndex := 0;
    ListaClick(Self);
  end
  else if Key = VK_HOME then
  begin
    if Lista.Items.Count > 0 then
    begin
      Lista.ItemIndex := 0;
      ListaClick(Self);
    end;
  end
  else if Key = VK_END then
  begin
    if Lista.Items.Count > 0 then
    begin
      Lista.ItemIndex := Lista.Items.Count-1;
      ListaClick(Self);
    end;
  end;
  {
    SendMessage(Lista.Handle, WM_VSCROLL, SB_PAGEUP, 0)
    SB_LINEDOWN - Uma linha para baixo.
    SB_LINEUP - Uma linha para cima.
    SB_PAGEDOWN - Uma página para baixo.
    SB_PAGEUP - Uma página para cima.
    SB_TOP - Topo da lista.
    SB_BOTTOM - Fim da lista.
  }
end;

procedure TFormsProjeto.ListaClick(Sender: TObject);
begin
 if Lista.ItemIndex < 0 then
   exit;
 EdPesquisa.Text := Lista.Items[Lista.ItemIndex];
 EdPesquisa.SetFocus;
 EdPesquisa.SelectAll;
end;

procedure TFormsProjeto.BtnLocalizarClick(Sender: TObject);
var
  I: Integer;
  Primeira: Boolean;
begin
  if TButton(Sender).Tag = 0 then
    DialogAbrir.InitialDir := Projeto.Pasta
  else
    DialogAbrir.InitialDir := Projeto.PastaFontes;
  if DialogAbrir.Execute then
  begin
    Primeira := True;
    for I:=0 to DialogAbrir.Files.Count-1 do
      if FileExists(DialogAbrir.Files[I]) then
      begin
        if Primeira then
        begin
          if FormDesigner_Net = Nil then
            ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
          Primeira := False;
        end;
        FormDesigner_Net.AbreForm(DialogAbrir.Files[I], 5, False);
      end;
    Close;
  end;
end;

end.
