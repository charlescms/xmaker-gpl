unit AnOtherForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormAnotherForm = class(TForm)
    Image: TImage;
    LabelText: TLabel;
    TimerBlink: TTimer;
    procedure TimerBlinkTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormAnotherForm: TFormAnotherForm;

implementation

{$R *.DFM}

procedure TFormAnotherForm.TimerBlinkTimer(Sender: TObject);
begin
  LabelText.Visible := not LabelText.Visible;
end;

procedure TFormAnotherForm.FormShow(Sender: TObject);
begin
  TimerBlink.Enabled := True;
end;

procedure TFormAnotherForm.FormHide(Sender: TObject);
begin
  TimerBlink.Enabled := False;
end;

procedure TFormAnotherForm.FormCreate(Sender: TObject);
begin
  Image.Picture.Bitmap.LoadFromFile(
    ExtractFilePath(Application.ExeName) + 'HandShak.bmp');
end;

end.
