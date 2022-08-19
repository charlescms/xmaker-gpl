unit Slide;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, StdCtrls, ExtCtrls;

type
  TFormSlide = class(TFormExpertWindow)
    RadioGroupDirection: TRadioGroup;
    CheckBoxElasticSrc: TCheckBox;
    CheckBoxElasticDst: TCheckBox;
    procedure FormShow(Sender: TObject);
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormSlide: TFormSlide;

implementation

{$R *.DFM}

uses
  TransEff, TransExpert, teSlide;

procedure TFormSlide.Apply;
begin
  case RadioGroupDirection.ItemIndex of
    0: (FormTransitionsExpert.Transition as TSlideTransition).Direction := tedRight;
    1: (FormTransitionsExpert.Transition as TSlideTransition).Direction := tedLeft;
    2: (FormTransitionsExpert.Transition as TSlideTransition).Direction := tedDown;
    3: (FormTransitionsExpert.Transition as TSlideTransition).Direction := tedUp;
  end;
  (FormTransitionsExpert.Transition as TSlideTransition).ElasticSrc :=
    CheckBoxElasticSrc.Checked;
  (FormTransitionsExpert.Transition as TSlideTransition).ElasticDst :=
    CheckBoxElasticDst.Checked;
end;

procedure TFormSlide.GoToNext;
begin
  FormTransitionsExpert.GoToMilliseconds;
end;

procedure TFormSlide.FormShow(Sender: TObject);
begin
  inherited;

  case (FormTransitionsExpert.Transition as TSlideTransition).Direction of
    tedRight: RadioGroupDirection.ItemIndex := 0;
    tedLeft : RadioGroupDirection.ItemIndex := 1;
    tedDown : RadioGroupDirection.ItemIndex := 2;
    tedUp   : RadioGroupDirection.ItemIndex := 3;
  end;

  CheckBoxElasticSrc.Checked :=
    (FormTransitionsExpert.Transition as TSlideTransition).ElasticSrc;
  CheckBoxElasticDst.Checked :=
    (FormTransitionsExpert.Transition as TSlideTransition).ElasticDst;
end;


end.
