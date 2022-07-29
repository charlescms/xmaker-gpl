unit Cores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ColorGrd, Buttons, ExtCtrls, IniFiles;

type
  TFormCores = class(TForm)
    TextoDemo: TRichEdit;
    GroupBox1: TGroupBox;
    CorFundo: TPanel;
    Label1: TLabel;
    CorLetra: TPanel;
    Label2: TLabel;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    ColorDialog: TColorDialog;
    TabEscolha: TTabControl;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CorFundoClick(Sender: TObject);
    procedure CorLetraClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure TabEscolhaChange(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCores: TFormCores;
  IniFile: TIniFile;
  ArqIni: String;
  Fundo1,Letra1 : Integer;
  Fundo2,Letra2 : Integer;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormCores.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCores.FormShow(Sender: TObject);
begin
  Fundo1 := clActiveCaption;
  Letra1 := clWhite;
  Fundo2 := clActiveCaption;
  Letra2 := clWhite;
  ArqIni  := DiretorioComBarra(DirWindows);
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  if IniFile.readstring('EDITOR', 'Fundo', '') <> '' then
    Fundo1 := StrToInt(IniFile.readstring('EDITOR', 'Fundo', ''));
  if IniFile.readstring('EDITOR', 'Letra', '') <> '' then
    Letra1 := StrToInt(IniFile.readstring('EDITOR', 'Letra', ''));
  if IniFile.readstring('DIARIO', 'Fundo', '') <> '' then
    Fundo2 := StrToInt(IniFile.readstring('DIARIO', 'Fundo', ''));
  if IniFile.readstring('DIARIO', 'Letra', '') <> '' then
    Letra2 := StrToInt(IniFile.readstring('DIARIO', 'Letra', ''));
  IniFile.Free;
  TabEscolha.TabIndex := 0;
  TabEscolhaChange(Self);
end;

procedure TFormCores.CorFundoClick(Sender: TObject);
begin
  if TabEscolha.TabIndex = 0 then
  begin
    ColorDialog.Color := Fundo1;
    if ColorDialog.Execute then
    begin
      CorFundo.Color := ColorDialog.Color;
      Fundo1 := ColorDialog.Color;
    end;
    TextoDemo.Color := Fundo1;
    TextoDemo.Font.Color := Letra1;
  end
  else if TabEscolha.TabIndex = 1 then
  begin
    ColorDialog.Color := Fundo2;
    if ColorDialog.Execute then
    begin
      CorFundo.Color := ColorDialog.Color;
      Fundo2 := ColorDialog.Color;
    end;
    TextoDemo.Color := Fundo2;
    TextoDemo.Font.Color := Letra2;
  end;
end;

procedure TFormCores.CorLetraClick(Sender: TObject);
begin
  if TabEscolha.TabIndex = 0 then
  begin
    ColorDialog.Color := Letra1;
    if ColorDialog.Execute then
    begin
      CorLetra.Color := ColorDialog.Color;
      Letra1 := ColorDialog.Color;
    end;
    TextoDemo.Color := Fundo1;
    TextoDemo.Font.Color := Letra1;
  end
  else if TabEscolha.TabIndex = 1 then
  begin
    ColorDialog.Color := Letra2;
    if ColorDialog.Execute then
    begin
      CorLetra.Color := ColorDialog.Color;
      Letra2 := ColorDialog.Color;
    end;
    TextoDemo.Color := Fundo2;
    TextoDemo.Font.Color := Letra2;
  end;
end;

procedure TFormCores.BtnGravarClick(Sender: TObject);
begin
  ArqIni  := DiretorioComBarra(DirWindows);
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  IniFile.WriteString('EDITOR', 'Fundo', IntToStr(Fundo1));
  IniFile.WriteString('EDITOR', 'Letra', IntToStr(Letra1));
  IniFile.WriteString('DIARIO', 'Fundo', IntToStr(Fundo2));
  IniFile.WriteString('DIARIO', 'Letra', IntToStr(Letra2));
  IniFile.Free;
  Close;
end;

procedure TFormCores.TabEscolhaChange(Sender: TObject);
begin
  if TabEscolha.TabIndex = 0 then  {Editor de Texto}
  begin
    TextoDemo.Lines.Clear;
    TextoDemo.Lines.Add('{ Processo ... }');
    TextoDemo.Lines.Add('');
    TextoDemo.Lines.Add('Begin');
    TextoDemo.Lines.Add(' If ... then');
    TextoDemo.Lines.Add('  ShowMessage('+ #39 + '...' + #39 + ');');
    TextoDemo.Lines.Add('End;');
    CorFundo.Color := Fundo1;
    CorLetra.Color := Letra1;
    TextoDemo.Color := Fundo1;
    TextoDemo.Font.Color := Letra1;
  end
  else if TabEscolha.TabIndex = 1 then {Diário de Bordo}
  begin
    TextoDemo.Lines.Clear;
    TextoDemo.Lines.Add('// Dica Importante...');
    TextoDemo.Lines.Add('');
    TextoDemo.Lines.Add('  Paradox em Rede :  ');
    TextoDemo.Lines.Add('Altere no BDE a opção');
    TextoDemo.Lines.Add('LOCAL SHARE para TRUE');
    TextoDemo.Lines.Add('no menu Configuration');
    TextoDemo.Lines.Add('System, Init.        ');
    CorFundo.Color := Fundo2;
    CorLetra.Color := Letra2;
    TextoDemo.Color := Fundo2;
    TextoDemo.Font.Color := Letra2;
  end;
end;

procedure TFormCores.BtnAjudaClick(Sender: TObject);
begin
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  //Application.HelpContext(BtnAjuda.HelpContext);
end;

end.
