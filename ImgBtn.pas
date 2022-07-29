unit ImgBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormImagensBotoes = class(TForm)
    PageGrupo: TPageControl;
    TabGrupo1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    BtnProcurar: TBitBtn;
    EdTituloProcurar: TEdit;
    ImagemProcurar: TComboBox;
    EdHintProcurar: TEdit;
    EdTituloExtras: TEdit;
    ImagemExtras: TComboBox;
    EdHintExtras: TEdit;
    EdTituloCancelar: TEdit;
    ImagemCancelar: TComboBox;
    EdHintCancelar: TEdit;
    BtnExtras: TBitBtn;
    BtnCancelar: TBitBtn;
    EdTituloGravar: TEdit;
    ImagemGravar: TComboBox;
    EdHintGravar: TEdit;
    BtnGravar: TBitBtn;
    TabGrupo2: TTabSheet;
    TabGrupo3: TTabSheet;
    Label16: TLabel;
    EdTituloFechar: TEdit;
    Label17: TLabel;
    ImagemFechar: TComboBox;
    Label18: TLabel;
    EdHintFechar: TEdit;
    BtnFechar: TBitBtn;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label30: TLabel;
    Label24: TLabel;
    BtnExcluir: TBitBtn;
    Label31: TLabel;
    EdTituloExcluir: TEdit;
    Label32: TLabel;
    ImagemExcluir: TComboBox;
    Label33: TLabel;
    EdHintExcluir: TEdit;
    Label7: TLabel;
    BtnPrimeiro: TBitBtn;
    Label8: TLabel;
    EdTituloPrimeiro: TEdit;
    Label9: TLabel;
    ImagemPrimeiro: TComboBox;
    Label21: TLabel;
    EdHintPrimeiro: TEdit;
    Label25: TLabel;
    BtnAnterior: TBitBtn;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    EdTituloAnterior: TEdit;
    ImagemAnterior: TComboBox;
    EdHintAnterior: TEdit;
    Label29: TLabel;
    BtnProximo: TBitBtn;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    EdTituloProximo: TEdit;
    ImagemProximo: TComboBox;
    EdHintProximo: TEdit;
    Label37: TLabel;
    BtnUltimo: TBitBtn;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    EdHintUltimo: TEdit;
    ImagemUltimo: TComboBox;
    EdTituloUltimo: TEdit;
    Label41: TLabel;
    BtnAjuda: TBitBtn;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    EdHintAjuda: TEdit;
    ImagemAjuda: TComboBox;
    EdTituloAjuda: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    BtnGravarDef: TBitBtn;
    BtnFecharDef: TBitBtn;
    BtnAjudaDef: TBitBtn;
    procedure ImagemProcurarDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure ImagemProcurarMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdTituloProcurarExit(Sender: TObject);
    procedure EdTituloExtrasExit(Sender: TObject);
    procedure EdTituloCancelarExit(Sender: TObject);
    procedure EdTituloGravarExit(Sender: TObject);
    procedure EdTituloExcluirExit(Sender: TObject);
    procedure EdTituloFecharExit(Sender: TObject);
    procedure ImagemProcurarExit(Sender: TObject);
    procedure ImagemExtrasExit(Sender: TObject);
    procedure ImagemCancelarExit(Sender: TObject);
    procedure ImagemGravarExit(Sender: TObject);
    procedure ImagemExcluirExit(Sender: TObject);
    procedure ImagemPrimeiroExit(Sender: TObject);
    procedure ImagemAnteriorExit(Sender: TObject);
    procedure ImagemProximoExit(Sender: TObject);
    procedure ImagemUltimoExit(Sender: TObject);
    procedure ImagemFecharExit(Sender: TObject);
    procedure EdHintProcurarExit(Sender: TObject);
    procedure EdHintExtrasExit(Sender: TObject);
    procedure EdHintCancelarExit(Sender: TObject);
    procedure EdHintGravarExit(Sender: TObject);
    procedure EdHintExcluirExit(Sender: TObject);
    procedure EdHintPrimeiroExit(Sender: TObject);
    procedure EdHintAnteriorExit(Sender: TObject);
    procedure EdHintProximoExit(Sender: TObject);
    procedure EdHintUltimoExit(Sender: TObject);
    procedure EdHintFecharExit(Sender: TObject);
    procedure EdTituloPrimeiroExit(Sender: TObject);
    procedure EdTituloAnteriorExit(Sender: TObject);
    procedure EdTituloProximoExit(Sender: TObject);
    procedure EdTituloUltimoExit(Sender: TObject);
    procedure ImagemAjudaExit(Sender: TObject);
    procedure EdHintAjudaExit(Sender: TObject);
    procedure BtnFecharDefClick(Sender: TObject);
    procedure BtnGravarDefClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtribuiImagem;
  public
    { Public declarations }
  end;

var
  FormImagensBotoes: TFormImagensBotoes;
  bitmap : tbitmap;

implementation

uses Princ, Rotinas;

{$R *.DFM}

procedure TFormImagensBotoes.ImagemProcurarDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  offset : integer;
begin
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect);
    Offset := 2;
    Bitmap:=TBitmap.Create;
    if FormPrincipal.ListaImagem <> nil then
       if index = 0 then
         BitMap := nil
       else
         FormPrincipal.ListaImagem.GetBitmap(LongInt((Control as TComboBox).Items.Objects[Index]),Bitmap);
    try
       if Bitmap <> nil then begin
         BrushCopy(Bounds(Rect.Left + 2, Rect.Top, Bitmap.Width, Bitmap.Height),
                   Bitmap,
                   Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                   clSilver); {clNavy}
         Offset := Bitmap.width + 8;
       end;
       TextOut(Rect.Left + Offset, Rect.Top, (Control as TComboBox).Items[Index])
    finally
       Bitmap.Free;
    end;
  end;
end;

procedure TFormImagensBotoes.FormShow(Sender: TObject);
var I: Integer;
begin
  ImagemProcurar.Items.Clear;
  ImagemProcurar.Items.AddObject('-1', Pointer(0));
  ImagemExtras.Items.Clear;
  ImagemExtras.Items.AddObject('-1', Pointer(0));
  ImagemGravar.Items.Clear;
  ImagemGravar.Items.AddObject('-1', Pointer(0));
  ImagemCancelar.Items.Clear;
  ImagemCancelar.Items.AddObject('-1', Pointer(0));
  ImagemExcluir.Items.Clear;
  ImagemExcluir.Items.AddObject('-1', Pointer(0));
  ImagemPrimeiro.Items.Clear;
  ImagemPrimeiro.Items.AddObject('-1', Pointer(0));
  ImagemAnterior.Items.Clear;
  ImagemAnterior.Items.AddObject('-1', Pointer(0));
  ImagemProximo.Items.Clear;
  ImagemProximo.Items.AddObject('-1', Pointer(0));
  ImagemUltimo.Items.Clear;
  ImagemUltimo.Items.AddObject('-1', Pointer(0));
  ImagemAjuda.Items.Clear;
  ImagemAjuda.Items.AddObject('-1', Pointer(0));
  ImagemFechar.Items.Clear;
  ImagemFechar.Items.AddObject('-1', Pointer(0));
  for I := 1 to FormPrincipal.ListaImagem.Count do
  begin
    ImagemProcurar.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemExtras.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemGravar.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemCancelar.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemExcluir.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemPrimeiro.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemAnterior.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemProximo.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemUltimo.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemAjuda.Items.AddObject(IntToStr(I-1), Pointer(I-1));
    ImagemFechar.Items.AddObject(IntToStr(I-1), Pointer(I-1));
  end;
  PageGrupo.ActivePageIndex := 0;
  EdTituloProcurar.SetFocus;
  FormPrincipal.Texto.Lines.Clear;
  if (FileExists(Projeto.PastaGerador + 'Botoes.Tpl')) then
    FormPrincipal.Texto.Lines.LoadFromFile(Projeto.PastaGerador + 'Botoes.Tpl');
  if FormPrincipal.Texto.Lines.Count < 33 then
  begin
    Mensagem('Não foi possível abrir o arquivo:'+^M+Projeto.PastaGerador + 'Botoes.Tpl',ModAdvertencia,[ModOk]);
  end;
  AtribuiImagem;
end;

procedure TFormImagensBotoes.AtribuiImagem;
var I,Pos,NrImagem:Integer;
    Titulo,Mensagem: String;
begin
  I := 1;
  Pos := 0;
  while I <= 33 do
  begin
    Bitmap:=TBitmap.Create;
    NrImagem := StrToInt(Trim(FormPrincipal.Texto.Lines[I]));
    FormPrincipal.ListaImagem.GetBitmap(NrImagem,Bitmap);
    Titulo := Trim(FormPrincipal.Texto.Lines[I-1]);
    Mensagem := Trim(FormPrincipal.Texto.Lines[I+1]);
    if Pos = 0 then
    begin
      BtnProcurar.Glyph := BitMap;
      BtnProcurar.Caption := Titulo;
      BtnProcurar.Hint := Mensagem;
      EdTituloProcurar.Text := Titulo;
      EdHintProcurar.Text := Mensagem;
      ImagemProcurar.ItemIndex := ImagemProcurar.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 1 then
    begin
      BtnExtras.Glyph := Bitmap;
      BtnExtras.Caption := Titulo;
      BtnExtras.Hint := Mensagem;
      EdTituloExtras.Text := Titulo;
      EdHintExtras.Text := Mensagem;
      ImagemExtras.ItemIndex := ImagemExtras.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 2 then
    begin
      BtnGravar.Glyph := Bitmap;
      BtnGravar.Caption := Titulo;
      BtnGravar.Hint := Mensagem;
      EdTituloGravar.Text := Titulo;
      EdHintGravar.Text := Mensagem;
      ImagemGravar.ItemIndex := ImagemGravar.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 3 then
    begin
      BtnCancelar.Glyph := Bitmap;
      BtnCancelar.Caption := Titulo;
      BtnCancelar.Hint := Mensagem;
      EdTituloCancelar.Text := Titulo;
      EdHintCancelar.Text := Mensagem;
      ImagemCancelar.ItemIndex := ImagemCancelar.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 4 then
    begin
      BtnExcluir.Glyph := Bitmap;
      BtnExcluir.Caption := Titulo;
      BtnExcluir.Hint := Mensagem;
      EdTituloExcluir.Text := Titulo;
      EdHintExcluir.Text := Mensagem;
      ImagemExcluir.ItemIndex := ImagemExcluir.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 5 then
    begin
      BtnPrimeiro.Glyph := Bitmap;
      BtnPrimeiro.Caption := Titulo;
      BtnPrimeiro.Hint := Mensagem;
      EdTituloPrimeiro.Text := Titulo;
      EdHintPrimeiro.Text := Mensagem;
      ImagemPrimeiro.ItemIndex := ImagemPrimeiro.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 6 then
    begin
      BtnAnterior.Glyph := Bitmap;
      BtnAnterior.Caption := Titulo;
      BtnAnterior.Hint := Mensagem;
      EdTituloAnterior.Text := Titulo;
      EdHintAnterior.Text := Mensagem;
      ImagemAnterior.ItemIndex := ImagemAnterior.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 7 then
    begin
      BtnProximo.Glyph := Bitmap;
      BtnProximo.Caption := Titulo;
      BtnProximo.Hint := Mensagem;
      EdTituloProximo.Text := Titulo;
      EdHintProximo.Text := Mensagem;
      ImagemProximo.ItemIndex := ImagemProximo.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 8 then
    begin
      BtnUltimo.Glyph := Bitmap;
      BtnUltimo.Caption := Titulo;
      BtnUltimo.Hint := Mensagem;
      EdTituloUltimo.Text := Titulo;
      EdHintUltimo.Text := Mensagem;
      ImagemUltimo.ItemIndex := ImagemUltimo.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 9 then
    begin
      BtnAjuda.Glyph := Bitmap;
      BtnAjuda.Caption := Titulo;
      BtnAjuda.Hint := Mensagem;
      EdTituloAjuda.Text := Titulo;
      EdHintAjuda.Text := Mensagem;
      ImagemAjuda.ItemIndex := ImagemAjuda.Items.IndexOf(IntToStr(NrImagem));
    end
    else if Pos = 10 then
    begin
      BtnFechar.Glyph := Bitmap;
      BtnFechar.Caption := Titulo;
      BtnFechar.Hint := Mensagem;
      EdTituloFechar.Text := Titulo;
      EdHintFechar.Text := Mensagem;
      ImagemFechar.ItemIndex := ImagemFechar.Items.IndexOf(IntToStr(NrImagem));
    end;
    BitMap.Free;
    Inc(Pos);
    I := I + 3;
  end;
end;

procedure TFormImagensBotoes.ImagemProcurarMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := 20;
end;

procedure TFormImagensBotoes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end
  else if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormImagensBotoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormPrincipal.Texto.Lines.Clear;
end;

procedure TFormImagensBotoes.EdTituloProcurarExit(Sender: TObject);
begin
  BtnProcurar.Caption := EdTituloProcurar.Text;
end;

procedure TFormImagensBotoes.EdTituloExtrasExit(Sender: TObject);
begin
  BtnExtras.Caption := EdTituloExtras.Text;

end;

procedure TFormImagensBotoes.EdTituloCancelarExit(Sender: TObject);
begin
  BtnCancelar.Caption := EdTituloCancelar.Text;

end;

procedure TFormImagensBotoes.EdTituloGravarExit(Sender: TObject);
begin
  BtnGravar.Caption := EdTituloGravar.Text;

end;

procedure TFormImagensBotoes.EdTituloExcluirExit(Sender: TObject);
begin
  BtnExcluir.Caption := EdTituloExcluir.Text;

end;

procedure TFormImagensBotoes.EdTituloFecharExit(Sender: TObject);
begin
  BtnFechar.Caption := EdTituloFechar.Text;

end;

procedure TFormImagensBotoes.ImagemProcurarExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemProcurar.Text),Bitmap);
  BtnProcurar.Glyph := Bitmap;
  BitMap.Free;
end;

procedure TFormImagensBotoes.ImagemExtrasExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemExtras.Text),Bitmap);
  BtnExtras.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemCancelarExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemCancelar.Text),Bitmap);
  BtnCancelar.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemGravarExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemGravar.Text),Bitmap);
  BtnGravar.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemExcluirExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemExcluir.Text),Bitmap);
  BtnExcluir.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemPrimeiroExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemPrimeiro.Text),Bitmap);
  BtnPrimeiro.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemAnteriorExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemAnterior.Text),Bitmap);
  BtnAnterior.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemProximoExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemProximo.Text),Bitmap);
  BtnProximo.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemUltimoExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemUltimo.Text),Bitmap);
  BtnUltimo.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.ImagemFecharExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemFechar.Text),Bitmap);
  BtnFechar.Glyph := Bitmap;
  BitMap.Free;

end;

procedure TFormImagensBotoes.EdHintProcurarExit(Sender: TObject);
begin
  BtnProcurar.Hint := EdHintProcurar.Text;

end;

procedure TFormImagensBotoes.EdHintExtrasExit(Sender: TObject);
begin
  BtnExtras.Hint := EdHintExtras.Text;

end;

procedure TFormImagensBotoes.EdHintCancelarExit(Sender: TObject);
begin
  BtnCancelar.Hint := EdHintCancelar.Text;

end;

procedure TFormImagensBotoes.EdHintGravarExit(Sender: TObject);
begin
  BtnGravar.Hint := EdHintGravar.Text;
end;

procedure TFormImagensBotoes.EdHintExcluirExit(Sender: TObject);
begin
  BtnExcluir.Hint := EdHintExcluir.Text;
  PageGrupo.ActivePageIndex := 1;
  EdTituloPrimeiro.SetFocus;

end;

procedure TFormImagensBotoes.EdHintPrimeiroExit(Sender: TObject);
begin
  BtnPrimeiro.Hint := EdHintPrimeiro.Text;

end;

procedure TFormImagensBotoes.EdHintAnteriorExit(Sender: TObject);
begin
  BtnAnterior.Hint := EdHintAnterior.Text;

end;

procedure TFormImagensBotoes.EdHintProximoExit(Sender: TObject);
begin
  BtnProximo.Hint := EdHintProximo.Text;

end;

procedure TFormImagensBotoes.EdHintUltimoExit(Sender: TObject);
begin
  BtnUltimo.Hint := EdHintUltimo.Text;

end;

procedure TFormImagensBotoes.EdHintFecharExit(Sender: TObject);
begin
  BtnFechar.Hint := EdHintFechar.Text;
  BtnGravarDef.SetFocus;
end;

procedure TFormImagensBotoes.EdTituloPrimeiroExit(Sender: TObject);
begin
  BtnPrimeiro.Caption := EdTituloPrimeiro.Text;

end;

procedure TFormImagensBotoes.EdTituloAnteriorExit(Sender: TObject);
begin
  BtnAnterior.Caption := EdTituloAnterior.Text;

end;

procedure TFormImagensBotoes.EdTituloProximoExit(Sender: TObject);
begin
  BtnProximo.Caption := EdTituloProximo.Text;

end;

procedure TFormImagensBotoes.EdTituloUltimoExit(Sender: TObject);
begin
  BtnUltimo.Caption := EdTituloUltimo.Text;

end;

procedure TFormImagensBotoes.ImagemAjudaExit(Sender: TObject);
begin
  Bitmap:=TBitmap.Create;
  FormPrincipal.ListaImagem.GetBitmap(StrToInt(ImagemAjuda.Text),Bitmap);
  BtnAjuda.Glyph := Bitmap;
  BitMap.Free;
end;

procedure TFormImagensBotoes.EdHintAjudaExit(Sender: TObject);
begin
  BtnExcluir.Hint := EdHintExcluir.Text;
  PageGrupo.ActivePageIndex := 2;
  EdTituloFechar.SetFocus;

end;

procedure TFormImagensBotoes.BtnFecharDefClick(Sender: TObject);
begin
  Close;
end;

procedure TFormImagensBotoes.BtnGravarDefClick(Sender: TObject);
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto.Lines.Add(EdTituloProcurar.Text);
  FormPrincipal.Texto.Lines.Add(ImagemProcurar.Text);
  FormPrincipal.Texto.Lines.Add(EdHintProcurar.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloExtras.Text);
  FormPrincipal.Texto.Lines.Add(ImagemExtras.Text);
  FormPrincipal.Texto.Lines.Add(EdHintExtras.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloGravar.Text);
  FormPrincipal.Texto.Lines.Add(ImagemGravar.Text);
  FormPrincipal.Texto.Lines.Add(EdHintGravar.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloCancelar.Text);
  FormPrincipal.Texto.Lines.Add(ImagemCancelar.Text);
  FormPrincipal.Texto.Lines.Add(EdHintCancelar.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloExcluir.Text);
  FormPrincipal.Texto.Lines.Add(ImagemExcluir.Text);
  FormPrincipal.Texto.Lines.Add(EdHintExcluir.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloPrimeiro.Text);
  FormPrincipal.Texto.Lines.Add(ImagemPrimeiro.Text);
  FormPrincipal.Texto.Lines.Add(EdHintPrimeiro.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloAnterior.Text);
  FormPrincipal.Texto.Lines.Add(ImagemAnterior.Text);
  FormPrincipal.Texto.Lines.Add(EdHintAnterior.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloProximo.Text);
  FormPrincipal.Texto.Lines.Add(ImagemProximo.Text);
  FormPrincipal.Texto.Lines.Add(EdHintProximo.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloUltimo.Text);
  FormPrincipal.Texto.Lines.Add(ImagemUltimo.Text);
  FormPrincipal.Texto.Lines.Add(EdHintUltimo.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloAjuda.Text);
  FormPrincipal.Texto.Lines.Add(ImagemAjuda.Text);
  FormPrincipal.Texto.Lines.Add(EdHintAjuda.Text);
  FormPrincipal.Texto.Lines.Add(EdTituloFechar.Text);
  FormPrincipal.Texto.Lines.Add(ImagemFechar.Text);
  FormPrincipal.Texto.Lines.Add(EdHintFechar.Text);
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.PastaGerador + 'Botoes.Tpl');
  Close;
end;

end.
