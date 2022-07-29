unit Diario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, IniFiles;

type
  TFormDiario = class(TForm)
    PageDiario: TPageControl;
    TabModificacao: TTabSheet;
    TabLembrete: TTabSheet;
    TabDica: TTabSheet;
    TextoModificacao: TRichEdit;
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    TextoLembrete: TRichEdit;
    Panel3: TPanel;
    Label3: TLabel;
    TextoDica: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDiario: TFormDiario;
  IniFile: TIniFile;
  ArqIni: String;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormDiario.FormShow(Sender: TObject);
var Fundo,Letra : Integer;
begin
  PageDiario.ActivePageIndex := 0;
  TextoModificacao.Lines.Clear;
  TextoLembrete.Lines.Clear;
  TextoDica.Lines.Clear;
  if FileExists(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dmd') then
    TextoModificacao.Lines.LoadFromFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dmd');
  if FileExists(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dlm') then
    TextoLembrete.Lines.LoadFromFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dlm');
  if FileExists(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Ddc') then
    TextoDica.Lines.LoadFromFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Ddc');
  ArqIni  := DiretorioComBarra(DirWindows);
  IniFile := TInifile.Create(ArqIni + 'XMAKER.INI');
  if IniFile.readstring('DIARIO', 'Fundo', '') <> '' then
    Fundo := StrToInt(IniFile.readstring('DIARIO', 'Fundo', ''))
  else
    Fundo := clActiveCaption;
  if IniFile.readstring('DIARIO', 'Letra', '') <> '' then
    Letra := StrToInt(IniFile.readstring('DIARIO', 'Letra', ''))
  else
    Letra := clWhite;
  IniFile.Free;
  TextoModificacao.Color      := Fundo;
  TextoModificacao.Font.Name  := 'Courier New';
  TextoModificacao.Font.Size  := 10;
  TextoModificacao.Font.Color := Letra;
  TextoModificacao.Font.Style := [fsBold];

  TextoLembrete.Color      := Fundo;
  TextoLembrete.Font.Name  := 'Courier New';
  TextoLembrete.Font.Size  := 10;
  TextoLembrete.Font.Color := Letra;
  TextoLembrete.Font.Style := [fsBold];

  TextoDica.Color      := Fundo;
  TextoDica.Font.Name  := 'Courier New';
  TextoDica.Font.Size  := 10;
  TextoDica.Font.Color := Letra;
  TextoDica.Font.Style := [fsBold];
  TextoModificacao.SetFocus;
end;

procedure TFormDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TextoModificacao.Lines.SaveToFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dmd');
  TextoLembrete.Lines.SaveToFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dlm');
  TextoDica.Lines.SaveToFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Ddc');
end;

end.
