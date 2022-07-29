unit TImagem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtDlgs, StdCtrls, Buttons, ComCtrls, ExtCtrls, IniFiles;

type
  TFormTabelaImagem = class(TForm)
    Panel1: TPanel;
    ListaImagens: TTreeView;
    BtnNovaImagem: TSpeedButton;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    OpenPictureBitmap: TOpenPictureDialog;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnNovaImagemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTabelaImagem: TFormTabelaImagem;
  IniFile : TIniFile;
  NovasImagens: Array[0..999] of String;
  PosicaoNova: Integer;

implementation

{$R *.DFM}

uses Rotinas, Princ, Aguarde, Gera_01;

procedure TFormTabelaImagem.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormTabelaImagem.BtnNovaImagemClick(Sender: TObject);
var
  BitMap : TBitMap;
begin
  if OpenPictureBitmap.Execute then
  begin
    if not (FileExists(Projeto.PastaGerador + 'Imagem\' + ExtractFileName(OpenPictureBitmap.FileName))) then
      CopiaArquivo(OpenPictureBitmap.FileName,
                   Projeto.PastaGerador + 'Imagem\' + ExtractFileName(OpenPictureBitmap.FileName));
    BitMap := TBitMap.Create;
    BitMap.LoadFromFile(Projeto.PastaGerador + 'Imagem\' + ExtractFileName(OpenPictureBitmap.FileName));
    FormPrincipal.ImagensProjeto.Add(BitMap,BitMap);
    BitMap.Free;
    ListaImagens.Items.Add(nil, StrZero(ListaImagens.Items.Count,04));
    ListaImagens.Items[ListaImagens.Items.Count-1].ImageIndex := FormPrincipal.ImagensProjeto.Count -1;
    ListaImagens.Items[ListaImagens.Items.Count-1].SelectedIndex := FormPrincipal.ImagensProjeto.Count -1;
    NovasImagens[PosicaoNova] := ExtractFileName(OpenPictureBitmap.FileName);
    Inc(PosicaoNova);
  end;
end;

procedure TFormTabelaImagem.FormShow(Sender: TObject);
var I : Integer;
begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Show;
  FormAguarde.Caption := 'Abrindo Tabela de Imagens...';

  PosicaoNova := 0;
  ListaImagens.Items.Clear;
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := FormPrincipal.ImagensProjeto.Count-1;
  for I := 0 to FormPrincipal.ImagensProjeto.Count-1 do
  begin
    ListaImagens.Items.Add(nil, StrZero(I,04));
    ListaImagens.Items[ListaImagens.Items.Count-1].ImageIndex := I;
    ListaImagens.Items[ListaImagens.Items.Count-1].SelectedIndex := I;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  end;
  FormAguarde.Free;
end;

procedure TFormTabelaImagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //ListaImagens.Items.Clear;
  {while ListaImagens.Items.Count-1 >= 0 do
   ListaImagens.Items[ListaImagens.Items.Count-1].Free;}
end;

procedure TFormTabelaImagem.BtnGravarClick(Sender: TObject);
var
  BitMap : TBitMap;
  I : Integer;
  NomeBmp : String;
begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Show;
  FormAguarde.Caption := 'Gravando Tabela de Imagens';

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto.Lines.LoadFromFile(Projeto.PastaGerador + 'Imagem.Lst');
  for I := 0 to 999 do
  begin
    NomeBmp := Trim(NovasImagens[I]) ;
    if NomeBmp <> '' then
      FormPrincipal.Texto.Lines.Add(NomeBmp);
  end;
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.PastaGerador + 'Imagem.Lst');
  FormPrincipal.ImagensProjeto.Clear;
  BitMap := TBitMap.Create;
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := FormPrincipal.Texto.Lines.Count-1;
  FormPrincipal.ImagensProjeto.Masked := True;
  for I := 0 to FormPrincipal.Texto.Lines.Count-1 do
  begin
    if Trim(FormPrincipal.Texto.Lines[I]) <> '' then
    begin
      if not (FileExists(Projeto.PastaGerador + 'Imagem\' + Trim(FormPrincipal.Texto.Lines[I]))) then
        CopiaArquivo(Projeto.PastaGerador + 'Imagem\' + Trim(FormPrincipal.Texto.Lines[I]),Projeto.PastaGerador + 'Imagem\' + Trim(FormPrincipal.Texto.Lines[I]));
      BitMap.LoadFromFile(Projeto.PastaGerador + 'Imagem\' + Trim(FormPrincipal.Texto.Lines[I]));
      FormPrincipal.ImagensProjeto.AddMasked(BitMap,clOlive);
      if BitMap.Width >= 32 then
        FormPrincipal.ImagensProjeto.Delete(FormPrincipal.ImagensProjeto.Count-1);
      FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
    end;
  end;
  BitMap.Free;
  FormPrincipal.Texto.Lines.Clear;
  FormAguarde.Free;
  if FormPrincipal.BtnDadosGenericos.Enabled then
    Gera_Princ_Res(False);
  Close;
end;

procedure TFormTabelaImagem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;

end;

end.
