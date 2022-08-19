program Demo;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Intro in 'Intro.pas' {FormIntro},
  OneForm in 'OneForm.pas' {FormOneForm},
  AnOtherForm in 'AnOtherForm.pas' {FormAnotherForm},
  Expert in 'Expert.pas' {FormExpertText},
  TransExpert in 'TransExpert.pas' {FormTransitionsExpert},
  ExpertWindow in 'ExpertWindow.pas' {FormExpertWindow},
  ChooseTransition in 'ChooseTransition.pas' {FormChooseTransition},
  Product in 'Product.pas' {FormProduct},
  Milliseconds in 'Milliseconds.pas' {FormMilliseconds},
  ExpertEnd in 'ExpertEnd.pas' {FormEnd},
  Picture in 'Picture.pas' {FormPicture},
  Fuse in 'Fuse.pas' {FormFuse},
  Slide in 'Slide.pas' {FormSlide},
  Push in 'Push.pas' {FormPush},
  Wipe in 'Wipe.pas' {FormWipe},
  Drip in 'Drip.pas' {FormDrip},
  Navigator in 'Navigator.pas' {FormNavigator},
  Power in 'Power.pas' {FormPower},
  Pass2 in 'Pass2.pas' {Form2ndPass},
  Align in 'Align.pas' {FormAlign},
  Transitions in 'Transitions.pas' {FormTransitions},
  About in 'About.pas' {FormAbout},
  Contact in 'Contact.pas' {FormContact},
  teSimpleWipe in 'teSimpleWipe.pas',
  CustomTransitions in 'CustomTransitions.pas' {FormCustomTransitions},
  SimpleWipe in 'SimpleWipe.pas' {FormSimpleWipe},
  SimpleWipeExec in 'SimpleWipeExec.pas' {FormSimpleWipeExec},
  Shake in 'Shake.pas' {FormShake},
  ShakeExec in 'ShakeExec.pas' {FormShakeExec},
  teShake in 'teShake.pas',
  Disabling in 'Disabling.pas' {FormDisabling};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
