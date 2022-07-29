unit UsrFirebird;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, IniFiles, ShellApi;

type
  TFormUsrFirebird = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    EdUsuario: TEdit;
    EdSenha: TEdit;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsrFirebird: TFormUsrFirebird;
  IniFile: TIniFile;
  ArqIni: String;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormUsrFirebird.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormUsrFirebird.BtnGravarClick(Sender: TObject);
begin
  ArqIni  := Projeto.PastaGerador; //DiretorioComBarra(DirWindows);
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  Projeto.usr_firebird := EdUsuario.Text;
  Projeto.pwd_firebird := EdSenha.Text;
  IniFile.WriteString('FIREBIRD', 'Usuario', Projeto.usr_firebird);
  IniFile.WriteString('FIREBIRD', 'Senha', Projeto.pwd_firebird);
  IniFile.Free;
  Close;
end;

procedure TFormUsrFirebird.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormUsrFirebird.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

procedure TFormUsrFirebird.FormShow(Sender: TObject);
begin
  EdUsuario.Text := Projeto.usr_firebird;
  EdSenha.Text   := Projeto.pwd_firebird;
end;

end.
