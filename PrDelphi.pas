unit PrDelphi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, IniFiles, ShellApi;

type
  TFormDelphi = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    EdCompilador: TEdit;
    EdParametros: TEdit;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnIcone: TBitBtn;
    OpenCompilador: TOpenDialog;
    LbLinguagem: TLabel;
    Label3: TLabel;
    EdHelp: TEdit;
    BtnHelp: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnIconeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdHelpExit(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDelphi: TFormDelphi;
  IniFile: TIniFile;
  ArqIni: String;
  NrLinguagem: Integer;

implementation

{$R *.DFM}

uses Rotinas, Abertura, Princ;

procedure TFormDelphi.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDelphi.BtnGravarClick(Sender: TObject);
begin
  if not (FileExists(EdCompilador.Text)) then
  begin
    Mensagem('Compilador não Encontrado !',ModAdvertencia,[ModOk]);
    EdCompilador.SetFocus;
    abort;
  end;
  ArqIni  := Projeto.PastaGerador; //DiretorioComBarra(DirWindows);
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  if LbLinguagem.Caption = 'Delphi 5.0' then
  begin
    IniFile.WriteString('LINGUAGEM', 'Delphi50.Compilador', EdCompilador.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi50.Parametros', EdParametros.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi50.Help', EdHelp.Text);
  end
  else if LbLinguagem.Caption = 'Delphi 6.0' then
  begin
    IniFile.WriteString('LINGUAGEM', 'Delphi60.Compilador', EdCompilador.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi60.Parametros', EdParametros.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi60.Help', EdHelp.Text);
  end
  else if LbLinguagem.Caption = 'Delphi 7.0' then
  begin
    IniFile.WriteString('LINGUAGEM', 'Delphi70.Compilador', EdCompilador.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi70.Parametros', EdParametros.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi70.Help', EdHelp.Text);
  end
  else if LbLinguagem.Caption = 'Delphi 2005' then
  begin
    IniFile.WriteString('LINGUAGEM', 'Delphi2005.Compilador', EdCompilador.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi2005.Parametros', EdParametros.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi2005.Help', EdHelp.Text);
  end
  else if LbLinguagem.Caption = 'Delphi 2006' then
  begin
    IniFile.WriteString('LINGUAGEM', 'Delphi2006.Compilador', EdCompilador.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi2006.Parametros', EdParametros.Text);
    IniFile.WriteString('LINGUAGEM', 'Delphi2006.Help', EdHelp.Text);
  end
  else if LbLinguagem.Caption = 'Turbo Delphi 2006' then
  begin
    IniFile.WriteString('LINGUAGEM', 'TurboDelphi2006.Compilador', EdCompilador.Text);
    IniFile.WriteString('LINGUAGEM', 'TurboDelphi2006.Parametros', EdParametros.Text);
    IniFile.WriteString('LINGUAGEM', 'TurboDelphi2006.Help', EdHelp.Text);
  end;
  if FormPrincipal.BtnFecharProjeto.Enabled then
  begin
    if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo = 1 then
    begin
      Projeto.Compilador := IniFile.ReadString('LINGUAGEM', 'Delphi50.Compilador', '');
      Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi50.Help', '');
      Projeto.Parametro := IniFile.ReadString('LINGUAGEM', 'Delphi50.Parametros', '');
    end
    else if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo = 2 then
    begin
      Projeto.Compilador := IniFile.ReadString('LINGUAGEM', 'Delphi60.Compilador', '');
      Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi60.Help', '');
      Projeto.Parametro := IniFile.ReadString('LINGUAGEM', 'Delphi60.Parametros', '');
    end
    else if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo = 3 then
    begin
      Projeto.Compilador := IniFile.ReadString('LINGUAGEM', 'Delphi70.Compilador', '');
      Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi70.Help', '');
      Projeto.Parametro := IniFile.ReadString('LINGUAGEM', 'Delphi70.Parametros', '');
    end
    else if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo = 4 then
    begin
      Projeto.Compilador := IniFile.ReadString('LINGUAGEM', 'Delphi2005.Compilador', '');
      Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi2005.Help', '');
      Projeto.Parametro := IniFile.ReadString('LINGUAGEM', 'Delphi2005.Parametros', '');
    end
    else if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo = 5 then
    begin
      Projeto.Compilador := IniFile.ReadString('LINGUAGEM', 'Delphi2006.Compilador', '');
      Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'Delphi2006.Help', '');
      Projeto.Parametro := IniFile.ReadString('LINGUAGEM', 'Delphi2006.Parametros', '');
    end
    else if TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo = 6 then
    begin
      Projeto.Compilador := IniFile.ReadString('LINGUAGEM', 'TurboDelphi2006.Compilador', '');
      Projeto.AjudaLinguagem := IniFile.ReadString('LINGUAGEM', 'TurboDelphi2006.Help', '');
      Projeto.Parametro := IniFile.ReadString('LINGUAGEM', 'TurboDelphi2006.Parametros', '');
    end;
  end;
  IniFile.Free;
  Close;
end;

procedure TFormDelphi.BtnIconeClick(Sender: TObject);
begin
  OpenCompilador.FilterIndex := 1;
  if EdCompilador.Text <> '' then
    OpenCompilador.FileName := EdCompilador.Text;
  if OpenCompilador.Execute then
    EdCompilador.Text := OpenCompilador.FileName;
end;

procedure TFormDelphi.FormShow(Sender: TObject);
begin
  ArqIni  := Projeto.PastaGerador; //DiretorioComBarra(DirWindows);
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  if LbLinguagem.Caption = 'Delphi 5.0' then
  begin
    EdCompilador.Text := IniFile.readstring('LINGUAGEM', 'Delphi50.Compilador', '');
    EdParametros.Text := IniFile.readstring('LINGUAGEM', 'Delphi50.Parametros', '');
    EdHelp.Text       := IniFile.readstring('LINGUAGEM', 'Delphi50.Help', '');
    if EdHelp.Text = '' then
      EdHelp.Text := 'C:\Arquivos de programas\Borland\Delphi5\Help\delphi5.hlp';
    if EdCompilador.Text = '' then
      EdCompilador.Text := 'C:\Arquivos de programas\Borland\Delphi5\Bin\DCC32.EXE';
    if EdParametros.Text = '' then
      EdParametros.Text := '/U'+Projeto.PastaGerador + 'Comp\Delphi'
  end
  else if LbLinguagem.Caption = 'Delphi 6.0' then
  begin
    EdCompilador.Text := IniFile.readstring('LINGUAGEM', 'Delphi60.Compilador', '');
    EdParametros.Text := IniFile.readstring('LINGUAGEM', 'Delphi60.Parametros', '');
    EdHelp.Text       := IniFile.readstring('LINGUAGEM', 'Delphi60.Help', '');
    if EdHelp.Text = '' then
      EdHelp.Text := 'C:\Arquivos de programas\Borland\Delphi6\Help\delphi6.hlp';
    if EdCompilador.Text = '' then
      EdCompilador.Text := 'C:\Arquivos de programas\Borland\Delphi6\Bin\DCC32.EXE';
    if EdParametros.Text = '' then
      EdParametros.Text := '/U'+Projeto.PastaGerador + 'Comp\Delphi'
  end
  else if LbLinguagem.Caption = 'Delphi 7.0' then
  begin
    EdCompilador.Text := IniFile.readstring('LINGUAGEM', 'Delphi70.Compilador', '');
    EdParametros.Text := IniFile.readstring('LINGUAGEM', 'Delphi70.Parametros', '');
    EdHelp.Text       := IniFile.readstring('LINGUAGEM', 'Delphi70.Help', '');
    if EdHelp.Text = '' then
      EdHelp.Text := 'C:\Arquivos de programas\Borland\Delphi7\Help\d7.hlp';
    if EdCompilador.Text = '' then
      EdCompilador.Text := 'C:\Arquivos de programas\Borland\Delphi7\Bin\DCC32.EXE';
    if EdParametros.Text = '' then
      EdParametros.Text := '/U'+Projeto.PastaGerador + 'Comp\Delphi'
  end
  else if LbLinguagem.Caption = 'Delphi 2005' then
  begin
    EdCompilador.Text := IniFile.readstring('LINGUAGEM', 'Delphi2005.Compilador', '');
    EdParametros.Text := IniFile.readstring('LINGUAGEM', 'Delphi2005.Parametros', '');
    EdHelp.Text       := IniFile.readstring('LINGUAGEM', 'Delphi2005.Help', '');
    if EdHelp.Text = '' then
      EdHelp.Text := 'C:\Arquivos de programas\Borland\BDS\3.0\Help\Help.pdf';
    if EdCompilador.Text = '' then
      EdCompilador.Text := 'C:\Arquivos de programas\Borland\BDS\3.0\Bin\DCC32.EXE';
    if EdParametros.Text = '' then
      EdParametros.Text := '/U'+Projeto.PastaGerador + 'Comp\Delphi'
  end
  else if LbLinguagem.Caption = 'Delphi 2006' then
  begin
    EdCompilador.Text := IniFile.readstring('LINGUAGEM', 'Delphi2006.Compilador', '');
    EdParametros.Text := IniFile.readstring('LINGUAGEM', 'Delphi2006.Parametros', '');
    EdHelp.Text       := IniFile.readstring('LINGUAGEM', 'Delphi2006.Help', '');
    if EdHelp.Text = '' then
      EdHelp.Text := 'C:\Arquivos de programas\Borland\BDS\4.0\Help\Help.pdf';
    if EdCompilador.Text = '' then
      EdCompilador.Text := 'C:\Arquivos de programas\Borland\BDS\4.0\Bin\DCC32.EXE';
    if EdParametros.Text = '' then
      EdParametros.Text := '/U'+Projeto.PastaGerador + 'Comp\Delphi'
  end
  else if LbLinguagem.Caption = 'Turbo Delphi 2006' then
  begin
    EdCompilador.Text := IniFile.readstring('LINGUAGEM', 'TurboDelphi2006.Compilador', '');
    EdParametros.Text := IniFile.readstring('LINGUAGEM', 'TurboDelphi2006.Parametros', '');
    EdHelp.Text       := IniFile.readstring('LINGUAGEM', 'TurboDelphi2006.Help', '');
    if EdHelp.Text = '' then
      EdHelp.Text := 'C:\Arquivos de programas\Borland\BDS\4.0\Help\Help.pdf';
    if EdCompilador.Text = '' then
      EdCompilador.Text := 'C:\Arquivos de programas\Borland\BDS\4.0\Bin\bds.exe';
    if EdParametros.Text = '' then
      EdParametros.Text := '-b'; //'/NS /NP /B /SD /O%1'
  end;
  IniFile.Free;
  EdCompilador.SetFocus;
end;

procedure TFormDelphi.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormDelphi.EdHelpExit(Sender: TObject);
begin
  BtnGravar.SetFocus;
end;

procedure TFormDelphi.BtnHelpClick(Sender: TObject);
begin
  OpenCompilador.FilterIndex := 2;
  if EdHelp.Text <> '' then
    OpenCompilador.FileName := EdHelp.Text;
  if OpenCompilador.Execute then
    EdHelp.Text := OpenCompilador.FileName;
end;

procedure TFormDelphi.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

end.
