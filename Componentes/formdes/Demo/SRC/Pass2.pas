unit Pass2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, ExtCtrls, StdCtrls, TransEff;

type
  TForm2ndPass = class(TFormExpertWindow)
    RadioButtonOnePass: TRadioButton;
    RadioButtonTwoPasses: TRadioButton;
    RadioButtonPalette: TRadioButton;
    GroupBoxPass2Options: TGroupBox;
    CheckBoxDistributedTime: TCheckBox;
    CheckBoxReversed: TCheckBox;
    CheckBoxUseSolidColor: TCheckBox;
    ComboBoxColor: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure RadioButtonOnePassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowPass2Options;
    procedure ProcessColor(const S: string);
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  end;

var
  Form2ndPass: TForm2ndPass;

implementation

uses TransExpert;

{$R *.DFM}

procedure TForm2ndPass.FormShow(Sender: TObject);
begin
  inherited;

  with FormTransitionsExpert.Transition do
  begin
    case PassSetting of
      teOnePass         : RadioButtonOnePass  .Checked := True;
      teTwoPasses       : RadioButtonTwoPasses.Checked := True;
      tePaletteDependent: RadioButtonPalette  .Checked := True;
    end;

    CheckBoxDistributedTime.Checked := Pass2Options.DistributedTime;
    CheckBoxReversed       .Checked := Pass2Options.Reversed;
    CheckBoxUseSolidColor  .Checked := Pass2Options.UseSolidColor;
    ComboBoxColor.ItemIndex :=
      ComboBoxColor.Items.IndexOf(ColorToString(Pass2Options.SolidColor));
  end;

  ShowPass2Options;
end;

procedure TForm2ndPass.ShowPass2Options;
begin
  GroupBoxPass2Options.Visible := not RadioButtonOnePass.Checked;
  ComboBoxColor       .Visible := CheckBoxUseSolidColor .Checked;
end;

procedure TForm2ndPass.RadioButtonOnePassClick(Sender: TObject);
begin
  ShowPass2Options;
end;

procedure TForm2ndPass.Apply;
begin
  with FormTransitionsExpert.Transition do
  begin
    if RadioButtonOnePass.Checked
    then PassSetting := teOnePass
    else if RadioButtonTwoPasses.Checked
    then PassSetting := teTwoPasses
    else PassSetting := tePaletteDependent;

    Pass2Options.DistributedTime := CheckBoxDistributedTime.Checked;
    Pass2Options.Reversed        := CheckBoxReversed       .Checked;
    Pass2Options.UseSolidColor   := CheckBoxUseSolidColor  .Checked;
    Pass2Options.SolidColor      := StringToColor(ComboBoxColor.Text);
  end;
end;

procedure TForm2ndPass.GoToNext;
begin
  FormTransitionsExpert.GoToAlign;
end;

procedure TForm2ndPass.ProcessColor(const S: string);
begin
  ComboBoxColor.Items.Add(S);
end;

procedure TForm2ndPass.FormCreate(Sender: TObject);
begin
  inherited;

  GetColorValues(ProcessColor);
end;

end.
