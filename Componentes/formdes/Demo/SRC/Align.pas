unit Align;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, ExtCtrls, StdCtrls;

type
  TFormAlign = class(TFormExpertWindow)
    RadioButtonfaDefault: TRadioButton;
    RadioButtonfaCenter: TRadioButton;
    RadioButtonfaClient: TRadioButton;
    RadioButtonfaOrigin: TRadioButton;
    RadioButtonfaNone: TRadioButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormAlign: TFormAlign;

implementation

uses TransExpert, FormCont;

{$R *.DFM}

procedure TFormAlign.Apply;
begin
  if RadioButtonfaDefault.Checked
  then FormTransitionsExpert.Align := fcfaDefault
  else if RadioButtonfaCenter.Checked
  then FormTransitionsExpert.Align := fcfaCenter
  else if RadioButtonfaClient.Checked
  then FormTransitionsExpert.Align := fcfaClient
  else if RadioButtonfaOrigin.Checked
  then FormTransitionsExpert.Align := fcfaTopLeft
  else if RadioButtonfaNone  .Checked
  then FormTransitionsExpert.Align := fcfaNone;
end;

procedure TFormAlign.GoToNext;
begin
  FormTransitionsExpert.GoToPicture;
end;

procedure TFormAlign.FormShow(Sender: TObject);
begin
  inherited;

  case FormTransitionsExpert.Align of
    fcfaDefault : RadioButtonfaDefault.Checked := True;
    fcfaCenter  : RadioButtonfaCenter .Checked := True;
    fcfaClient  : RadioButtonfaClient .Checked := True;
    fcfaTopLeft : RadioButtonfaOrigin .Checked := True;
    fcfaNone    : RadioButtonfaNone   .Checked := True;
  end;
end;

end.
