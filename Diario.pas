unit Diario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, IniFiles, Buttons;

type
  TFormDiario = class(TForm)
    ImageAgenda: TImage;
    Label1: TLabel;
    TextoAnotacoes: TRichEdit;
    Label2: TLabel;
    TextoLembretes: TRichEdit;
    BtnFechar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure ImageAgendaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
  TextoAnotacoes.Lines.Clear;
  TextoLembretes.Lines.Clear;
  if FileExists(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dmd') then
    TextoAnotacoes.Lines.LoadFromFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dmd');
  if FileExists(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dlm') then
    TextoLembretes.Lines.LoadFromFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dlm');
  TextoAnotacoes.SetFocus;
end;

procedure TFormDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TextoAnotacoes.Lines.SaveToFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dmd');
  TextoLembretes.Lines.SaveToFile(Copy(Projeto.Nome,01,Length(Projeto.Nome)-3) + 'Dlm');
end;

procedure TFormDiario.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDiario.ImageAgendaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If button = mbleft then
  begin
    releasecapture;
    FormDiario.perform (WM_syscommand, $F012, 0);
  end;
end;

procedure TFormDiario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.
