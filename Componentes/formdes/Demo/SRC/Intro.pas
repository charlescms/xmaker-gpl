unit Intro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormCont, StdCtrls, ExtCtrls;

type
  TFormIntro = class(TForm)
    Panel: TPanel;
    MemoText: TMemo;
    PanelTransition: TPanel;
    FormContainerTransition: TFormContainer;
    ButtonTransition: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonTransitionClick(Sender: TObject);
  private
  public
    procedure GotoForm1;
    procedure GotoForm2;
  end;

var
  FormIntro: TFormIntro;

implementation

uses TransEff, OneForm, AnOtherForm, teFuse, teDrip;

{$R *.DFM}

procedure TFormIntro.FormCreate(Sender: TObject);
begin
  if Screen.PixelsPerInch > PixelsPerInch then
    MemoText.Font.Size := 8;
  MemoText.WordWrap := True;
  GotoForm1;
end;

procedure TFormIntro.GotoForm1;
var
  Transition: TFuseTransition;
begin
  FormOneForm :=
    TFormOneForm(FormContainerTransition.CreateForm(TFormOneForm));

  Transition := TFuseTransition.Create;
  try
    Transition.Milliseconds := 500;
    Transition.Style        :=   2;
    FormContainerTransition.ShowFormEx(FormOneForm ,True, Transition, nil,
      fcfaDefault);
  finally
    Transition.Free;
  end;
end;

procedure TFormIntro.GotoForm2;
var
  Transition: TDripTransition;
begin
  FormAnotherForm :=
    TFormAnotherForm(FormContainerTransition.CreateForm(TFormAnotherForm));
  SetWindowRgn(FormAnotherForm.Handle, CreateEllipticRgn(10, 10,
    FormAnotherForm.Width-10, FormAnotherForm.Height-10), False);

  Transition := TDripTransition.Create;
  try
    Transition.Milliseconds := 2000;
    Transition.Direction := tedLeft;
    FormContainerTransition.ShowFormEx(FormAnotherForm, True, Transition, nil,
      fcfaCenter);
  finally
    Transition.Free;
  end;
end;

procedure TFormIntro.ButtonTransitionClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if FormContainerTransition.Form is TFormOneForm
    then GotoForm2
    else GotoForm1;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

end.
