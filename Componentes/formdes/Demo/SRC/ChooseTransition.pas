unit ChooseTransition;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, StdCtrls, ExtCtrls, FormCont, TransEff, teFuse, tePush,
  teSlide, teWipe, teDrip, teBlend;

type
  TFormChooseTransition = class(TFormExpertWindow)
    Panel2: TPanel;
    LabelTransition: TLabel;
    Panel3: TPanel;
    ListBoxTransition: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure ListBoxTransitionDblClick(Sender: TObject);
  protected
    SelectedOld: String;

    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormChooseTransition: TFormChooseTransition;

implementation

uses TransExpert, Expert, Navigator;

{$R *.DFM}

procedure TFormChooseTransition.FormShow(Sender: TObject);
begin
  inherited;

  FormTransitionsExpert.BitBtnBack.Enabled := False;
  FormTransitionsExpert.BitBtnHome.Enabled := False;

  if ListBoxTransition.ItemIndex = -1 then ListBoxTransition.ItemIndex := 0;
end;

procedure TFormChooseTransition.Apply;
var
  Selected: String;
begin
  Selected := ListBoxTransition.Items[ListBoxTransition.ItemIndex];
  if Selected <> SelectedOld then
  begin
    if Selected = 'No transition'
    then FormTransitionsExpert.Transition := nil
    else if Selected = 'TFlickerFreeTransition'
    then FormTransitionsExpert.Transition := TFlickerFreeTransition.Create
    else if Selected = 'TWipeTransition'
    then
    begin
      FormTransitionsExpert.Transition := TWipeTransition.Create;
      FormTransitionsExpert.Transition.Milliseconds := 500;
    end
    else if Selected = 'TSlideTransition'
    then
    begin
      FormTransitionsExpert.Transition := TSlideTransition.Create;
      FormTransitionsExpert.Transition.Milliseconds := 500;
    end
    else if Selected = 'TPushTransition'
    then
    begin
      FormTransitionsExpert.Transition := TPushTransition.Create;
      FormTransitionsExpert.Transition.Milliseconds := 500;
    end
    else if Selected = 'TDripTransition'
    then
    begin
      FormTransitionsExpert.Transition := TDripTransition.Create;
      FormTransitionsExpert.Transition.Milliseconds := 2000;
    end
    else if Selected = 'TFuseTransition'
    then
    begin
      FormTransitionsExpert.Transition := TFuseTransition.Create;
      FormTransitionsExpert.Transition.Milliseconds := 500;
    end
    else if Selected = 'TBlendTransition'
    then
    begin
      FormTransitionsExpert.Transition := TBlendTransition.Create;
      FormTransitionsExpert.Transition.Milliseconds := 1000;
    end;

    if FormTransitionsExpert.Transition <> nil
    then
    begin
      FormTransitionsExpert.Transition.OnStartTransition :=
        FormNavigator.OnStartTransition;
      FormTransitionsExpert.Transition.OnEndTransition   :=
        FormNavigator.OnEndTransition;
      FormTransitionsExpert.Transition.FlickerFreeWhenDisabled := True;
      FormTransitionsExpert.Transition.Enabled :=
        FormTransitionsExpert.CheckBoxApply.Checked;
      FormTransitionsExpert.FormContainerExpert.FlickerFree := False;
    end
    else FormTransitionsExpert.FormContainerExpert.FlickerFree :=
           not FormTransitionsExpert.CheckBoxApply.Checked;

    SelectedOld := Selected;
  end;
end;

procedure TFormChooseTransition.GoToNext;
begin
  if FormTransitionsExpert.Transition = nil
  then FormTransitionsExpert.GoToAlign
  else if FormTransitionsExpert.Transition is TFlickerFreeTransition
  then FormTransitionsExpert.GoTo2ndPassOptions
  else if FormTransitionsExpert.Transition is TWipeTransition
  then FormTransitionsExpert.GoToWipe
  else if FormTransitionsExpert.Transition is TSlideTransition
  then FormTransitionsExpert.GoToSlide
  else if FormTransitionsExpert.Transition is TPushTransition
  then FormTransitionsExpert.GoToPush
  else if FormTransitionsExpert.Transition    is TDripTransition
  then FormTransitionsExpert.GoToDrip
  else if FormTransitionsExpert.Transition    is TFuseTransition
  then FormTransitionsExpert.GoToFuse
  else if FormTransitionsExpert.Transition is TBlendTransition
  then FormTransitionsExpert.GoToMilliseconds;
end;

procedure TFormChooseTransition.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;

  with ListBoxTransition.Items do
  begin
    Add('No transition');
    Add('TFlickerFreeTransition');
    Add('TWipeTransition');
    Add('TSlideTransition');
    Add('TPushTransition');
    Add('TDripTransition');
    Add('TFuseTransition');
    Add('TBlendTransition');
  end;

  if FormTransitionsExpert.Transition = nil
  then
    ListBoxTransition.ItemIndex := 0
  else
  begin
    for i := 1 to ListBoxTransition.Items.Count-1 do
      if ListBoxTransition.Items[i] = FormTransitionsExpert.Transition.ClassName then
      begin
        ListBoxTransition.ItemIndex := i;
        break;
      end;
  end;

  SelectedOld := ListBoxTransition.Items[ListBoxTransition.ItemIndex];
end;

procedure TFormChooseTransition.ListBoxTransitionDblClick(Sender: TObject);
begin
  FormTransitionsExpert.BitBtnNext.Click;
end;

end.
