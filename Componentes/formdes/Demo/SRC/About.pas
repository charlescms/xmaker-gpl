unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Product, ExtCtrls, StdCtrls, teFuse, ComCtrls, FormCont, teForm;

type
  TFormAbout = class(TFormProduct)
    Timer: TTimer;
    FormTransitions: TFormTransitions;
    procedure ImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure OnStartTransition(Sender: TObject);
    procedure OnEndTransition(Sender: TObject);
  public
  end;

var
  FormAbout: TFormAbout;

implementation

{$R *.DFM}

uses TransEff, teWipe, teRender, mmSystem;

procedure TFormAbout.ImageClick(Sender: TObject);
begin
  Timer.Enabled := False;
  Close;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  inherited;

  SetWindowRgn(Handle, CreateRoundRectRgn(0, 0, Width, Height, 100, 100), False);
  FormTransitions.ShowTransition := TFuseTransition.Create;
  FormTransitions.ShowTransition.Milliseconds               := 1600;
  (FormTransitions.ShowTransition as TFuseTransition).Style := 0;
  FormTransitions.ShowTransition.OnStartTransition := OnStartTransition;
  FormTransitions.ShowTransition.OnEndTransition   := OnEndTransition;
end;

procedure TFormAbout.OnStartTransition(Sender: TObject);
begin
  sndPlaySound(PChar(ExtractFilePath(Application.ExeName) + 'welcome.wav'),
    SND_ASYNC);
end;

procedure TFormAbout.OnEndTransition(Sender: TObject);
begin
  sndPlaySound(nil, 0);
end;

end.
