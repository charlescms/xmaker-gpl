unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormCont, ExtCtrls, ComCtrls, teForm;

type
  TMainForm = class(TForm)
    MainFormContainer: TFormContainer;
    StatusBar: TStatusBar;
    FormTransitions: TFormTransitions;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure OnStartTransition(Sender: TObject);
    procedure OnEndTransition(Sender: TObject);
  protected
    procedure AppIdle(Sender: TObject; var Done: Boolean);
  end;

var
  MainForm: TMainForm;

implementation

uses Navigator, About, TransEff, teWipe, mmSystem;

{$R *.DFM}

procedure TMainForm.OnStartTransition(Sender: TObject);
begin
  sndPlaySound(PChar(ExtractFilePath(Application.ExeName) + 'Alienshp.wav'),
    SND_ASYNC);
end;

procedure TMainForm.OnEndTransition(Sender: TObject);
begin
  sndPlaySound(nil, 0);
end;

procedure TMainForm.AppIdle(Sender: TObject; var Done: Boolean);
var
  i,
  VisibleCount: Integer;
begin
  VisibleCount := 0;
  for i:=0 to Screen.FormCount-1 do
    if IsWindowVisible(Screen.Forms[i].Handle) then
      Inc(VisibleCount);

  StatusBar.SimpleText :=
    Format(
      'At this time there are created %d forms, of which %d are visible on screen',
      [Screen.FormCount, VisibleCount]);

  Done := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FormTransitions.ShowTransition := TWipeTransition.Create;
  with FormTransitions.ShowTransition as TWipeTransition do
  begin
    Milliseconds := 3000;
    BandWidth    :=  100;
    Direction    := tedDown;
  end;
  FormTransitions.ShowTransition.OnStartTransition := OnStartTransition;
  FormTransitions.ShowTransition.OnEndTransition   := OnEndTransition;
  
  FormAbout := TFormAbout.Create(Self);
  FormAbout.Show;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  FormNavigator := TFormNavigator(MainFormContainer.CreateForm(TFormNavigator));
  MainFormContainer.ShowForm(FormNavigator, True);

  Application.OnIdle:= AppIdle;

  repeat
    Application.ProcessMessages;
  until not FormAbout.Visible;
  FormAbout.Free;
end;

end.
