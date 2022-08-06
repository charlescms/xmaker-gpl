unit FR_Progress;

interface

{$I FR.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls;

type
  TFR_Progress = class(TForm)
    Bar: TProgressBar;
    CancelB: TButton;
    LMessage: TLabel;
    Panel1: TPanel;
    procedure WMNCHitTest(var Message :TWMNCHitTest); message WM_NCHITTEST;
    procedure FormCreate(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FActiveForm: TForm;
    FTerminated: Boolean;
    FPosition: Integer;
    FMessage: String;
    FProgress: Boolean;
    procedure SetPosition(Value: Integer);
    procedure SetMessage(const Value: String);
    procedure SetTerminated(Value: Boolean);
    procedure SetProgress(Value: Boolean);
  public
    procedure Reset;
    procedure Execute(MaxValue: Integer; const Msg: String;
      Canceled: Boolean; Progress: Boolean);
    procedure Tick;
    property Terminated: Boolean read FTerminated write SetTerminated;
    property Position: Integer read FPosition write SetPosition;
    property ShowProgress: Boolean read FProgress write SetProgress;
    property Message: String read FMessage write SetMessage;
  end;


implementation

{$R *.DFM}

procedure TFR_Progress.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if Message.Result = htClient then
    Message.Result := htCaption;
end;

procedure TFR_Progress.FormCreate(Sender: TObject);
begin
  FActiveForm := Screen.ActiveForm;
  if FActiveForm <> nil then
    FActiveForm.Enabled := False;

  Bar.Max := 100;
  Position := 0;
end;

procedure TFR_Progress.FormDestroy(Sender: TObject);
begin
  if FActiveForm <> nil then
    FActiveForm.Enabled := True;
end;

procedure TFR_Progress.FormHide(Sender: TObject);
begin
  if FActiveForm <> nil then
    FActiveForm.Enabled := True;
end;

procedure TFR_Progress.Reset;
begin
  Position := 0;
end;

procedure TFR_Progress.SetPosition(Value: Integer);
begin
  FPosition := Value;
  Bar.Position := Value;
  BringToFront;
  Application.ProcessMessages;
end;

procedure TFR_Progress.Execute(MaxValue: Integer; const Msg: String;
  Canceled: Boolean; Progress: Boolean);
begin
  Terminated := False;
  CancelB.Visible := Canceled;
  ShowProgress := Progress;
  Reset;
  Bar.Max := MaxValue;
  Message := Msg;

  Show;
  Application.ProcessMessages;
end;

procedure TFR_Progress.Tick;
begin
  Position := Position + 1;
end;

procedure TFR_Progress.SetMessage(const Value: String);
begin
  FMessage := Value;
  LMessage.Caption := Value;
  LMessage.Refresh;
end;

procedure TFR_Progress.CancelBClick(Sender: TObject);
begin
  Terminated := True;
end;

procedure TFR_Progress.SetTerminated(Value: boolean);
begin
  FTerminated := Value;
  if Value then Close;
end;

procedure TFR_Progress.SetProgress(Value: boolean);
begin
  Bar.Visible := Value;
  FProgress := Value;
  if Value then
    LMessage.Top := 15
  else
    LMessage.Top := 35;
end;

end.
