unit Wipe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, StdCtrls, ExtCtrls, ComCtrls;

type
  TFormWipe = class(TFormExpertWindow)
    RadioGroupDirection: TRadioGroup;
    Label1: TLabel;
    EditBandWidth: TEdit;
    UpDownBandWidth: TUpDown;
    procedure FormShow(Sender: TObject);
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormWipe: TFormWipe;

implementation

{$R *.DFM}

uses
  TransEff, TransExpert, teWipe;

procedure TFormWipe.Apply;
begin
  case RadioGroupDirection.ItemIndex of
    0: (FormTransitionsExpert.Transition as TWipeTransition).Direction := tedRight;
    1: (FormTransitionsExpert.Transition as TWipeTransition).Direction := tedLeft;
    2: (FormTransitionsExpert.Transition as TWipeTransition).Direction := tedDown;
    3: (FormTransitionsExpert.Transition as TWipeTransition).Direction := tedUp;
  end;
  (FormTransitionsExpert.Transition as TWipeTransition).BandWidth :=
    UpDownBandWidth.Position;
end;

procedure TFormWipe.GoToNext;
begin
  FormTransitionsExpert.GoToMilliseconds;
end;

procedure TFormWipe.FormShow(Sender: TObject);
begin
  inherited;

  case (FormTransitionsExpert.Transition as TWipeTransition).Direction of
    tedRight: RadioGroupDirection.ItemIndex := 0;
    tedLeft : RadioGroupDirection.ItemIndex := 1;
    tedDown : RadioGroupDirection.ItemIndex := 2;
    tedUp   : RadioGroupDirection.ItemIndex := 3;
  end;

  UpDownBandWidth.Position :=
    (FormTransitionsExpert.Transition as TWipeTransition).BandWidth;
end;

end.
