unit Milliseconds;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, ExtCtrls, StdCtrls, ComCtrls;

type
  TFormMilliseconds = class(TFormExpertWindow)
    Label1: TLabel;
    UpDownMilliseconds: TUpDown;
    EditMilliseconds: TEdit;
    procedure FormShow(Sender: TObject);
  private
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormMilliseconds: TFormMilliseconds;

implementation

uses TransExpert;

{$R *.DFM}

procedure TFormMilliseconds.Apply;
begin
  FormTransitionsExpert.Transition.Milliseconds := UpDownMilliseconds.Position;
end;

procedure TFormMilliseconds.GoToNext;
begin
  FormTransitionsExpert.GoTo2ndPassOptions;
end;

procedure TFormMilliseconds.FormShow(Sender: TObject);
begin
  inherited;

  UpDownMilliseconds.Position := FormTransitionsExpert.Transition.Milliseconds;
end;

end.
