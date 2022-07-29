unit Mensagem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TFormMensagem = class(TForm)
    Fundo: TPanel;
    Divisao: TBevel;
    BtnOk: TBitBtn;
    BtnSim: TBitBtn;
    BtnNao: TBitBtn;
    BtnCancela: TBitBtn;
    BtnTodos: TBitBtn;
    LbMensagem: TMemo;
    Image: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    NrImagem: Integer;
    Botoes: Array[0..4] of Boolean;
  end;

var
  FormMensagem: TFormMensagem;

implementation

{$R *.DFM}
//{$R *.RES}

procedure TFormMensagem.FormShow(Sender: TObject);
Var
  QtBotoes, I: Integer;
  GrupoBotoes, X: Integer;
begin
  case NrImagem of
    0: Image.Picture.Icon.Handle := LoadIcon(0, IDI_INFORMATION);
    1: Image.Picture.Icon.Handle := LoadIcon(0, IDI_WARNING); // IDI_ASTERISK
    2: Image.Picture.Icon.Handle := LoadIcon(0, IDI_ERROR);
    3: Image.Picture.Icon.Handle := LoadIcon(0, IDI_INFORMATION);
    4: Image.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
  end;
  BtnOk.Visible      := Botoes[0];
  BtnSim.Visible     := Botoes[1];
  BtnNao.Visible     := Botoes[2];
  BtnCancela.Visible := Botoes[3];
  BtnTodos.Visible   := Botoes[4];
  QtBotoes := 0;
  For I := 0 to 4 do
    if Botoes[I] then Inc(QtBotoes);
  if QtBotoes > 3 then
  begin
    Width := Width + 30;
    LbMensagem.Width := LbMensagem.Width + 30;
  end;
  GrupoBotoes := (75 * QtBotoes)+ (3 * (QtBotoes - 1));
  //X := (ClientWidth - GrupoBotoes) div 2;
  X := ClientWidth - (QtBotoes * 80) - 3;
  if BtnOk.Visible then
  begin
    BtnOk.Left := X;
    Inc(X, 80);
  end;
  if BtnSim.Visible then
  begin
    BtnSim.Left := X;
    Inc(X, 80);
  end;
  if BtnNao.Visible then
  begin
    BtnNao.Left := X;
    Inc(X, 80);
  end;
  if BtnCancela.Visible then
  begin
    BtnCancela.Left := X;
    Inc(X, 80);
  end;
  if BtnTodos.Visible then
  begin
    BtnTodos.Left := X;
    Inc(X, 80);
  end;
  if Botoes[0] then BtnOk.Default := True else
    if Botoes[1] then BtnSim.Default := True else
      BtnCancela.Default := True;
  case NrImagem of
    0: begin
       end;
    1: begin
         Caption := 'Advertência';
         MessageBeep(mb_IconWarning);
       end;
    2: begin
         Caption := 'Erro';
         MessageBeep(mb_IconError);
       end;
    3: begin
         Caption := 'Informação';
         MessageBeep(mb_IconInformation);
       end;
    4: begin
         Caption := 'Confirme';
         MessageBeep(mb_IconAsterisk);
       end;
  end;
end;

procedure TFormMensagem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(27) then Close;
end;

end.
