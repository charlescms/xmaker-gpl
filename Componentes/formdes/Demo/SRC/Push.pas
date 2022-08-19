unit Push;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, StdCtrls, ExtCtrls;

type
  TFormPush = class(TFormExpertWindow)
    RadioGroupDirection: TRadioGroup;
    procedure FormShow(Sender: TObject);
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormPush: TFormPush;

implementation

{$R *.DFM}

uses
  TransEff, TransExpert, tePush;

procedure TFormPush.Apply;
begin
  case RadioGroupDirection.ItemIndex of
    0: (FormTransitionsExpert.Transition as TPushTransition).Direction := tedRight;
    1: (FormTransitionsExpert.Transition as TPushTransition).Direction := tedLeft;
    2: (FormTransitionsExpert.Transition as TPushTransition).Direction := tedDown;
    3: (FormTransitionsExpert.Transition as TPushTransition).Direction := tedUp;
  end;
end;

procedure TFormPush.GoToNext;
begin
  FormTransitionsExpert.GoToMilliseconds;
end;

procedure TFormPush.FormShow(Sender: TObject);
begin
  inherited;

  case (FormTransitionsExpert.Transition as TPushTransition).Direction of
    tedRight: RadioGroupDirection.ItemIndex := 0;
    tedLeft : RadioGroupDirection.ItemIndex := 1;
    tedDown : RadioGroupDirection.ItemIndex := 2;
    tedUp   : RadioGroupDirection.ItemIndex := 3;
  end;
end;

end.
