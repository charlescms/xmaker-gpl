unit DefModelos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, Buttons, ExtCtrls, ComCtrls, IniFiles, ShellApi;

type
  TFormDefModelos = class(TForm)
    Panel1: TPanel;
    BtnEditar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnFechar: TBitBtn;
    BtnNovo: TBitBtn;
    Pagina: TPageControl;
    TabFontes: TTabSheet;
    TabForm: TTabSheet;
    Lista: TListBox;
    Lista_F: TListBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure ListaDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaClick(Sender: TObject);
    procedure PaginaChange(Sender: TObject);
  private
    { Private declarations }
    Lista_Tmp: TStringList;
  public
    { Public declarations }
  end;

var
  FormDefModelos: TFormDefModelos;

implementation

{$R *.DFM}
uses Rotinas, Gera_01, Princ, EdModelo;

procedure TFormDefModelos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormDefModelos.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDefModelos.FormShow(Sender: TObject);
var
  I, P: Integer;
begin
  Lista.Items.Clear;
  Lista_Tmp := TStringList.Create;
  if FileExists(Projeto.PastaGerador + 'Modelos.Lst') then
  begin
    Lista_Tmp.LoadFromFile(Projeto.PastaGerador + 'Modelos.Lst');
    for I:=0 to Lista_Tmp.Count-1 do
    begin
      P := Pos('~~', Lista_Tmp[I]);
      if P > 0 then
        Lista.Items.Add(Copy(Lista_Tmp[I], 01, P - 1));
    end;
  end;
  if Lista.Items.Count = 0 then
  begin
    Lista.Items.Add('Padrão X-Maker');
    Lista_Tmp.Add('Padrão X-Maker~~'+Projeto.PastaGerador + 'Delphi\');
  end;
  Lista.ItemIndex := 0;
  Pagina.ActivePageIndex := 0;
  ListaClick(Self);
end;

procedure TFormDefModelos.BtnNovoClick(Sender: TObject);
var
  I: Integer;
begin
  case Pagina.ActivePageIndex of
    0: begin
         FormEdModelo := TFormEdModelo.Create(Application);
         Try
           FormEdModelo.EdFile.Visible := False;
           if FormEdModelo.ShowModal = mrOk then
             if (Trim(FormEdModelo.EdTitulo.Text) <> '') and
                (Trim(FormEdModelo.EdPasta.Text) <> '') then
             begin
               Lista.Items.Add(FormEdModelo.EdTitulo.Text);
               Lista_Tmp.Add(FormEdModelo.EdTitulo.Text + '~~' + DiretorioComBarra(Trim(FormEdModelo.EdPasta.Text)));
               if Lista.Items.Count > 0 then
                 Lista.ItemIndex := Lista.Items.Count-1;
             end;
         Finally
           FormEdModelo.Free;
           Lista.SetFocus;
         end;
       end;
    1: begin
         FormEdModelo := TFormEdModelo.Create(Application);
         Try
           FormEdModelo.EdFile.Visible    := True;
           FormEdModelo.EdTitulo.Visible  := False;
           FormEdModelo.LbPasta.Visible   := False;
           FormEdModelo.EdPasta.Visible   := False;
           FormEdModelo.LbTitulo.Top      := 31;
           FormEdModelo.EdFile.Top        := 47;
           FormEdModelo.ListaFile.ApplyFilePath(Copy(Lista_Tmp[Lista.ItemIndex],Pos('~~',Lista_Tmp[Lista.ItemIndex])+2,Length(Lista_Tmp[Lista.ItemIndex])));
           FormEdModelo.EdFile.Items.Clear;
           for I:=0 to FormEdModelo.ListaFile.Items.Count-1 do
             FormEdModelo.EdFile.Items.Add(Copy(FormEdModelo.ListaFile.Items[I], 01, Pos('.', FormEdModelo.ListaFile.Items[I])-1));
           if FormEdModelo.ShowModal = mrOk then
             if (Trim(FormEdModelo.EdFile.Text) <> '') then
             begin
               Lista_F.Items.Add(FormEdModelo.EdFile.Text);
               Lista_F.ItemIndex := Lista.Items.Count-1;
               Lista_F.Items.SaveToFile(Projeto.PastaGerador + 'Modelos_'+IntToStr(Lista.ItemIndex)+'.Lst');
               if Lista_F.Items.Count > 0 then
                 Lista_F.ItemIndex := Lista_F.Items.Count-1;
             end;
         Finally
           FormEdModelo.Free;
           Lista_f.SetFocus;
         end;
       end;
  end;
end;

procedure TFormDefModelos.BtnEditarClick(Sender: TObject);
var
  I: Integer;
begin
  case Pagina.ActivePageIndex of
    0: begin
         if Lista.ItemIndex = -1 then
         begin
           Mensagem('Selecione um Modelo!', modAdvertencia, [modOk]);
           Lista.SetFocus;
           exit;
         end;
         FormEdModelo := TFormEdModelo.Create(Application);
         Try
           FormEdModelo.EdTitulo.Text := Lista.Items[Lista.ItemIndex];
           FormEdModelo.EdPasta.Text  := Copy(Lista_Tmp[Lista.ItemIndex],Pos('~~',Lista_Tmp[Lista.ItemIndex])+2,Length(Lista_Tmp[Lista.ItemIndex]));
           if FormEdModelo.ShowModal = mrOk then
             if (Trim(FormEdModelo.EdTitulo.Text) <> '') and
                (Trim(FormEdModelo.EdPasta.Text) <> '') then
             begin
               Lista.Items[Lista.ItemIndex] := FormEdModelo.EdTitulo.Text;
               Lista_Tmp[Lista.ItemIndex]   := FormEdModelo.EdTitulo.Text + '~~' + DiretorioComBarra(Trim(FormEdModelo.EdPasta.Text));
             end;
         Finally
           FormEdModelo.Free;
           Lista.SetFocus;
         end;
       end;
    1: begin
         if Lista_F.ItemIndex = -1 then
         begin
           Mensagem('Selecione um Formulário!', modAdvertencia, [modOk]);
           Lista_F.SetFocus;
           exit;
         end;
         FormEdModelo := TFormEdModelo.Create(Application);
         Try
           FormEdModelo.EdFile.Visible    := True;
           FormEdModelo.EdTitulo.Visible  := False;
           FormEdModelo.LbPasta.Visible   := False;
           FormEdModelo.EdPasta.Visible   := False;
           FormEdModelo.LbTitulo.Top      := 31;
           FormEdModelo.EdFile.Top        := 47;
           FormEdModelo.ListaFile.ApplyFilePath(Copy(Lista_Tmp[Lista.ItemIndex],Pos('~~',Lista_Tmp[Lista.ItemIndex])+2,Length(Lista_Tmp[Lista.ItemIndex])));
           FormEdModelo.EdFile.Items.Clear;
           for I:=0 to FormEdModelo.ListaFile.Items.Count-1 do
             FormEdModelo.EdFile.Items.Add(Copy(FormEdModelo.ListaFile.Items[I], 01, Pos('.', FormEdModelo.ListaFile.Items[I])-1));
           FormEdModelo.EdFile.ItemIndex  := FormEdModelo.EdFile.Items.IndexOf(Lista_F.Items[Lista_F.ItemIndex]);
           if FormEdModelo.ShowModal = mrOk then
             if (Trim(FormEdModelo.EdFile.Text) <> '') then
             begin
               Lista_F.Items[Lista_F.ItemIndex] := FormEdModelo.EdFile.Text;
               Lista_F.Items.SaveToFile(Projeto.PastaGerador + 'Modelos_'+IntToStr(Lista.ItemIndex)+'.Lst');
             end;
         Finally
           FormEdModelo.Free;
           Lista_f.SetFocus;
         end;
       end;
  end;
end;

procedure TFormDefModelos.BtnExcluirClick(Sender: TObject);
var
  P: Integer;
begin
  case Pagina.ActivePageIndex of
    0: begin
         if Lista.ItemIndex = -1 then
         begin
           Mensagem('Selecione um Modelo!', modAdvertencia, [modOk]);
           Lista.SetFocus;
           exit;
         end;
         if Mensagem(Lista.Items[Lista.ItemIndex] + ^M + ^M + 'Excluir Modelo?', modConfirmacao, [modSim, modNao]) = mrYes then
         begin
           P := Lista.ItemIndex;
           Lista.Items.Delete(P);
           Lista_Tmp.Delete(P);
         end;
       end;
    1: begin
         if Lista_F.ItemIndex = -1 then
         begin
           Mensagem('Selecione um Formulário!', modAdvertencia, [modOk]);
           Lista_F.SetFocus;
           exit;
         end;
         if Mensagem(Lista_F.Items[Lista_F.ItemIndex] + ^M + ^M + 'Excluir Formulário?', modConfirmacao, [modSim, modNao]) = mrYes then
         begin
           P := Lista_F.ItemIndex;
           Lista_F.Items.Delete(P);
           Lista_F.Items.SaveToFile(Projeto.PastaGerador + 'Modelos_'+IntToStr(Lista.ItemIndex)+'.Lst');
         end;
       end;
  end;
end;

procedure TFormDefModelos.ListaDblClick(Sender: TObject);
begin
  BtnEditarClick(Self);
end;

procedure TFormDefModelos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Lista_Tmp.SaveToFile(Projeto.PastaGerador + 'Modelos.Lst');
  Lista_Tmp.Free;
end;

procedure TFormDefModelos.ListaClick(Sender: TObject);
begin
  Lista_F.Items.Clear;
  if FileExists(Projeto.PastaGerador + 'Modelos_'+IntToStr(Lista.ItemIndex)+'.Lst') then
    Lista_F.Items.LoadFromFile(Projeto.PastaGerador + 'Modelos_'+IntToStr(Lista.ItemIndex)+'.Lst');
  if Lista_F.Items.Count > 0 then
    Lista_F.ItemIndex := 0;  
end;

procedure TFormDefModelos.PaginaChange(Sender: TObject);
begin
  case Pagina.ActivePageIndex of
    0: begin
         btnNovo.Enabled    := True;
         btnEditar.Enabled  := True;
         btnExcluir.Enabled := True;
       end;
    1: begin
         if Lista.ItemIndex > -1 then
         begin
           btnNovo.Enabled    := True;
           btnEditar.Enabled  := True;
           btnExcluir.Enabled := True;
         end
         else
         begin
           btnNovo.Enabled    := False;
           btnEditar.Enabled  := False;
           btnExcluir.Enabled := False;
         end;
       end;
  end;
end;

end.
