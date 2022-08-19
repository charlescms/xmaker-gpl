unit TransExpert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormCont, TransEff, StdCtrls, Buttons, ExtCtrls, ComCtrls, Navigator,
  teForm;

type
  TFormTransitionsExpert = class(TForm)
    PanelForms: TPanel;
    FormContainerExpert: TFormContainer;
    PanelButtons: TPanel;
    BitBtnBack: TBitBtn;
    BitBtnNext: TBitBtn;
    BitBtnClose: TBitBtn;
    BitBtnHome: TBitBtn;
    CheckBoxApply: TCheckBox;
    FormTransitions: TFormTransitions;
    procedure BitBtnBackClick(Sender: TObject);
    procedure BitBtnNextClick(Sender: TObject);
    procedure BitBtnHomeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure CheckBoxApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FTransition: TTransitionEffect;

    procedure SetTransition(NewTransition: TTransitionEffect);
  public
    Navigator: TFormNavigator;
    Align: TFCFormAlign;

    procedure GoToChooseTransition;
    procedure GoToMilliseconds;
    procedure GoTo2ndPassOptions;
    procedure GoToAlign;
    procedure GoToPicture;
    procedure GoToFuse;
    procedure GoToSlide;
    procedure GoToPush;
    procedure GoToWipe;
    procedure GoToDrip;
    procedure GoToEnd(Backgr: TFCBackgroundOptions);

    property Transition: TTransitionEffect read FTransition write SetTransition;
  end;

var
  FormTransitionsExpert: TFormTransitionsExpert;

implementation

uses ChooseTransition, Milliseconds, ExpertWindow, ExpertEnd, Picture, Fuse,
  Slide, Push, Wipe, Drip, Pass2, Align, teBlend;

{$R *.DFM}

procedure TFormTransitionsExpert.SetTransition(NewTransition: TTransitionEffect);
begin
  if NewTransition <> FTransition then
  begin
    FTransition.Free;
    FTransition := NewTransition;
  end;
end;

procedure TFormTransitionsExpert.BitBtnBackClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if Transition <> nil then
      Transition.Reversed := True;

    FormContainerExpert.ShowFormEx(
      FormContainerExpert.Forms[FormContainerExpert.FormCount-1], True,
      Transition, nil, FormTransitionsExpert.Align);

    if Transition <> nil then
      Transition.Reversed := False;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormTransitionsExpert.BitBtnNextClick(Sender: TObject);
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    (FormContainerExpert.Form as TFormExpertWindow).Next;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormTransitionsExpert.BitBtnHomeClick(Sender: TObject);
var
  i: Integer;
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    with FormContainerExpert do
    begin
      for i:=FormCount-1 downto 2 do
        DestroyForm(Forms[i]);

      if Transition <> nil then
        Transition.Reversed := True;

      FormContainerExpert.ShowFormEx(Forms[1], True, Transition, nil,
        FormTransitionsExpert.Align);

      if Transition <> nil then
        Transition.Reversed := False;
    end;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormTransitionsExpert.GoToChooseTransition;
begin
  FormChooseTransition :=
    TFormChooseTransition(FormContainerExpert.CreateForm(TFormChooseTransition));
  FormContainerExpert.ShowForm(FormChooseTransition, True);
end;

procedure TFormTransitionsExpert.GoToMilliseconds;
begin
  FormMilliseconds :=
    TFormMilliseconds(FormContainerExpert.CreateForm(TFormMilliseconds));
  FormContainerExpert.ShowFormEx(FormMilliseconds, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoTo2ndPassOptions;
begin
  Form2ndPass :=
    TForm2ndPass(FormContainerExpert.CreateForm(TForm2ndPass));
  FormContainerExpert.ShowFormEx(Form2ndPass, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToAlign;
begin
  FormAlign :=
    TFormAlign(FormContainerExpert.CreateForm(TFormAlign));
  FormContainerExpert.ShowFormEx(FormAlign, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToPicture;
begin
  FormPicture :=
    TFormPicture(FormContainerExpert.CreateForm(TFormPicture));
  FormContainerExpert.ShowFormEx(FormPicture, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToFuse;
begin
  FormFuse :=
    TFormFuse(FormContainerExpert.CreateForm(TFormFuse));
  FormContainerExpert.ShowFormEx(FormFuse, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToSlide;
begin
  FormSlide :=
    TFormSlide(FormContainerExpert.CreateForm(TFormSlide));
  FormContainerExpert.ShowFormEx(FormSlide, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToPush;
begin
  FormPush :=
    TFormPush(FormContainerExpert.CreateForm(TFormPush));
  FormContainerExpert.ShowFormEx(FormPush, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToWipe;
begin
  FormWipe :=
    TFormWipe(FormContainerExpert.CreateForm(TFormWipe));
  FormContainerExpert.ShowFormEx(FormWipe, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToDrip;
begin
  FormDrip :=
    TFormDrip(FormContainerExpert.CreateForm(TFormDrip));
  FormContainerExpert.ShowFormEx(FormDrip, False, Transition, nil,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.GoToEnd(Backgr: TFCBackgroundOptions);
begin
  FormEnd := TFormEnd(FormContainerExpert.CreateForm(TFormEnd));
  FormContainerExpert.ShowFormEx(FormEnd, False, Transition, Backgr,
    FormTransitionsExpert.Align);
end;

procedure TFormTransitionsExpert.FormShow(Sender: TObject);
begin
  FTransition := Navigator.TransEffct;
  FTransition.Enabled := False;

  Align       := Navigator.Align;
  FormContainerExpert.BackgroundOptions.Assign(
    Navigator.FormContainerNavigator.BackgroundOptions);

  GoToChooseTransition;
end;

procedure TFormTransitionsExpert.BitBtnCloseClick(Sender: TObject);
begin
  if not FormContainerExpert.CloseQuery then
    ModalResult := mrNone;

  if Transition <> nil then
    Transition.Enabled := True;
  Navigator.TransEffct := Transition;
  Navigator.Align      := Align;
  Navigator.FormContainerNavigator.BackgroundOptions.Assign(
    FormContainerExpert.BackgroundOptions);
end;

procedure TFormTransitionsExpert.CheckBoxApplyClick(Sender: TObject);
begin
  if Transition <> nil
  then Transition.Enabled := CheckBoxApply.Checked
  else FormContainerExpert.FlickerFree :=
         not FormTransitionsExpert.CheckBoxApply.Checked;
end;

procedure TFormTransitionsExpert.FormCreate(Sender: TObject);
begin
  FormTransitions.ShowTransition := TBlendTransition.Create;
  FormTransitions.ShowTransition.Milliseconds := 1500;
end;

end.
