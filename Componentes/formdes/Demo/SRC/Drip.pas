unit Drip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, StdCtrls, ExtCtrls;

type
  TFormDrip = class(TFormExpertWindow)
    RadioGroupDirection: TRadioGroup;
    procedure FormShow(Sender: TObject);
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormDrip: TFormDrip;

implementation

{$R *.DFM}

uses
  TransEff, TransExpert, teDrip;

procedure TFormDrip.Apply;
begin
  case RadioGroupDirection.ItemIndex of
    0: (FormTransitionsExpert.Transition as TDripTransition).Direction := tedRight;
    1: (FormTransitionsExpert.Transition as TDripTransition).Direction := tedLeft;
    2: (FormTransitionsExpert.Transition as TDripTransition).Direction := tedDown;
    3: (FormTransitionsExpert.Transition as TDripTransition).Direction := tedUp;
  end;
end;

procedure TFormDrip.GoToNext;
begin
  FormTransitionsExpert.GoToMilliseconds;
end;

procedure TFormDrip.FormShow(Sender: TObject);
begin
  inherited;

  case (FormTransitionsExpert.Transition as TDripTransition).Direction of
    tedRight: RadioGroupDirection.ItemIndex := 0;
    tedLeft : RadioGroupDirection.ItemIndex := 1;
    tedDown : RadioGroupDirection.ItemIndex := 2;
    tedUp   : RadioGroupDirection.ItemIndex := 3;
  end;
end;

end.
