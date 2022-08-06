{
   Programa.: Ambiente.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Ambiente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, ExtDlgs, IniFiles, FileCtrl;

type
  TFormAmbiente = class(TForm)
    PanelInf: TPanel;
    BtnCancelar: TBitBtn;
    BtnGravar: TBitBtn;
    PageAmbiente: TPageControl;
    PagProp: TTabSheet;
    EdSaida: TCheckBox;
    EdBalao: TCheckBox;
    EdPastaBasica: TEdit;
    Label1: TLabel;
    EdPapelParede: TCheckBox;
    Label9: TLabel;
    EdImagem: TEdit;
    BtnImagem: TBitBtn;
    Bevel1: TBevel;
    ImagemFundo: TImage;
    OpenPictureImagem: TOpenPictureDialog;
    BtnPastaBasica: TBitBtn;
    EdAjustada: TCheckBox;
    EdRede: TCheckBox;
    EdIntegridade: TCheckBox;
    EdMenuXP: TCheckBox;
    EdSelecionar: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BtnImagemClick(Sender: TObject);
    procedure EdImagemExit(Sender: TObject);
    procedure BtnPastaBasicaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAmbiente: TFormAmbiente;
  IniFile : TIniFile;

implementation

{$R *.DFM}

uses Rotinas, Publicas, Princ;

procedure TFormAmbiente.FormShow(Sender: TObject);
begin
  IniFile := TInifile.Create(Sistema.Pasta +
             ChangeFileExt(ExtractFileName(Application.ExeName), '.ini'));
  EdPastaBasica.Text  := IniFile.readstring('AMBIENTE', 'PastaBasica', '');
  if IniFile.readstring('AMBIENTE', 'Rede', '') = '1' then
    EdRede.Checked := True
  else
    EdRede.Checked := False;
  if IniFile.readstring('AMBIENTE', 'Integridade', '') = '1' then
    EdIntegridade.Checked := True
  else
    EdIntegridade.Checked := False;
  if IniFile.readstring('AMBIENTE', 'ConfirmaSaida', '') = '1' then
    EdSaida.Checked := True
  else
    EdSaida.Checked := False;
  if IniFile.readstring('AMBIENTE', 'EstiloBalao', '') = '1' then
    EdBalao.Checked := True
  else
    EdBalao.Checked := False;
  if IniFile.readstring('AMBIENTE', 'MenuXP', '') = '1' then
    EdMenuXP.Checked := True
  else
    EdMenuXP.Checked := False;
  if IniFile.readstring('AMBIENTE', 'SelecionarEmpresa', '') = '1' then
    EdSelecionar.Checked := True
  else
    EdSelecionar.Checked := False;
  if IniFile.readstring('AMBIENTE', 'PapelParede', '') = '1' then
    EdPapelParede.Checked := True
  else
    EdPapelParede.Checked := False;
  if IniFile.readstring('AMBIENTE', 'Ajustada', '') = '1' then
    EdAjustada.Checked := True
  else
    EdAjustada.Checked := False;
  EdImagem.Text    := IniFile.readstring('AMBIENTE', 'Imagem', '');
  EdImagemExit(Self);
  EdPastaBasica.SelectAll;
  EdPastaBasica.SetFocus;
end;

procedure TFormAmbiente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  IniFile.Free;
end;

procedure TFormAmbiente.BtnImagemClick(Sender: TObject);
begin
  if OpenPictureImagem.Execute then
  begin
    EdImagem.Text := OpenPictureImagem.FileName;
    EdImagemExit(Self);
  end;
  EdAjustada.SetFocus;
end;

procedure TFormAmbiente.EdImagemExit(Sender: TObject);
begin
  if FileExists(EdImagem.Text) then
    ImagemFundo.Picture.LoadFromFile(EdImagem.Text)
  else
    ImagemFundo.Picture := FormPrincipal.ImagemFundo.Picture;
end;

procedure TFormAmbiente.BtnPastaBasicaClick(Sender: TObject);
Var
  S: String;
begin
  if (EdPastaBasica.Text <> '') and (DirectoryExists(EdPastaBasica.Text)) then
    S := EdPastaBasica.Text
  else
    S := '';
  if SelectDirectory('Selecione a Pasta - [Básica]', '', S) then
    EdPastaBasica.Text := S;
  EdRede.SetFocus;
end;

procedure TFormAmbiente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(27) then
  begin
    Key := #0;
    Close;
  end
  else if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormAmbiente.BtnGravarClick(Sender: TObject);
begin
  IniFile.WriteString('AMBIENTE', 'PastaBasica', EdPastaBasica.Text);
  if EdRede.Checked then
    IniFile.WriteString('AMBIENTE', 'Rede', '1')
  else
    IniFile.WriteString('AMBIENTE', 'Rede', '0');
  if EdIntegridade.Checked then
    IniFile.WriteString('AMBIENTE', 'Integridade', '1')
  else
    IniFile.WriteString('AMBIENTE', 'Integridade', '0');
  if EdSaida.Checked then
    IniFile.WriteString('AMBIENTE', 'ConfirmaSaida', '1')
  else
    IniFile.WriteString('AMBIENTE', 'ConfirmaSaida', '0');
  if EdBalao.Checked then
    IniFile.WriteString('AMBIENTE', 'EstiloBalao', '1')
  else
    IniFile.WriteString('AMBIENTE', 'EstiloBalao', '0');
  if EdMenuXP.Checked then
    IniFile.WriteString('AMBIENTE', 'MenuXP', '1')
  else
    IniFile.WriteString('AMBIENTE', 'MenuXP', '0');
  if EdSelecionar.Checked then
    IniFile.WriteString('AMBIENTE', 'SelecionarEmpresa', '1')
  else
    IniFile.WriteString('AMBIENTE', 'SelecionarEmpresa', '0');
  FormPrincipal.ImagemFundo.Stretch := EdAjustada.Checked;
  if EdPapelParede.Checked then
  begin
    IniFile.WriteString('AMBIENTE', 'PapelParede', '1');
    FormPrincipal.ImagemFundo.Visible := True;
    if FileExists(EdImagem.Text) then
      FormPrincipal.ImagemFundo.Picture.LoadFromFile(EdImagem.Text);
  end
  else
  begin
    IniFile.WriteString('AMBIENTE', 'PapelParede', '0');
    FormPrincipal.ImagemFundo.Visible := False;
  end;
  if EdAjustada.Checked then
    IniFile.WriteString('AMBIENTE', 'Ajustada', '1')
  else
    IniFile.WriteString('AMBIENTE', 'Ajustada', '0');
  IniFile.WriteString('AMBIENTE', 'Imagem', EdImagem.Text);
  Sistema.Rede          := EdRede.Checked;
  Sistema.Integridade   := EdIntegridade.Checked;
  Sistema.ConfirmaSaida := EdSaida.Checked;
  Close;
end;

end.
