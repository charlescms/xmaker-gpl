unit Sobre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ShellAPI, OleCtrls, jpeg;

type
  TFormSobre = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    LbVersao: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    BtnOk: TButton;
    ImageSplash: TImage;
    Label1: TLabel;
    Serial1: TLabel;
    Serial2: TLabel;
    Registrado: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSobre: TFormSobre;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormSobre.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSobre.Label6Click(Sender: TObject);
begin
  Label1.Font.Color := clBlue;
  Label6.Font.Color := clBlue;
  Label6.Font.Color := clGray;
  ShellExecute(0, nil, pchar('http://www.xmaker.com.br'), nil, nil, SW_MAXIMIZE);
end;

procedure TFormSobre.Label1Click(Sender: TObject);
begin
  Label1.Font.Color := clBlue;
  Label6.Font.Color := clBlue;
  Label1.Font.Color := clGray;
  ShellExecute(0, nil, pchar('mailto:xmaker@xmaker.com.br'), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormSobre.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormSobre.FormShow(Sender: TObject);
begin
  if FREDT then
    lbVersao.Caption := 'Versão  '+Projeto.VersaoGerador + ' - FREE EDITION'
  else
  begin
    if Trim(Projeto.Beta_Versao) <> '' then
      lbVersao.Caption := 'Versão  '+Projeto.Beta_Versao + ' - PROFESSIONAL'
    else
      lbVersao.Caption := 'Versão  '+Projeto.VersaoGerador + ' - PROFESSIONAL';
  end;
  if Trim(Projeto.Beta_Versao) <> '' then
    lbVersao.Caption := lbVersao.Caption + ' - Release: ' + Projeto.Beta_Release
  else
    lbVersao.Caption := lbVersao.Caption + ' - Release: ' + Projeto.ReleaseGerador;
  Registrado.Caption := Copy(Projeto.Registro_usr,01,Pos('-',Projeto.Registro_usr)-1);
end;

procedure TFormSobre.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = ([ssShift,ssCtrl,ssAlt]) then
    if Key = 46 then
    begin
      Serial1.Caption := C_RGT_USR[01]+C_RGT_USR[03]+C_RGT_USR[05]+C_RGT_USR[07]+C_RGT_USR[09]+
                         C_RGT_USR[11]+C_RGT_USR[13]+C_RGT_USR[15]+C_RGT_USR[17]+C_RGT_USR[19]+
                         C_RGT_USR[21]+C_RGT_USR[23]+C_RGT_USR[25]+C_RGT_USR[27]+C_RGT_USR[29]+
                         C_RGT_USR[31]+C_RGT_USR[33];
      Serial2.Caption := Projeto.Registro_usr;
      Serial1.Visible := True;
      Serial2.Visible := True;
      if (Trim(Serial1.Caption) = Trim(Serial2.Caption)) and not C_CRACK then
      begin
        Serial1.Font.Color := clBlue;
        Serial2.Font.Color := clBlue;
      end
      else
      begin
        Serial1.Font.Color := clRed;
        Serial2.Font.Color := clRed;
      end;
    end;
end;

end.
