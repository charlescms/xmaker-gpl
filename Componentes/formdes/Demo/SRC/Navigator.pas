unit Navigator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormCont, ExtCtrls, ComCtrls, StdCtrls, TransEff, teWipe;

type
  TFormNavigator = class(TForm)
    TreeViewNavigator: TTreeView;
    SplitterNavigator: TSplitter;
    FormContainerNavigator: TFormContainer;
    procedure FormCreate(Sender: TObject);
    procedure TreeViewNavigatorChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeViewNavigatorChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewNavigatorCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure TreeViewNavigatorExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    AllowNavigatorOperations: Boolean;

  public
    Align: TFCFormAlign;
    SoundFilename: String;
    TransEffct: TTransitionEffect;

    nProduct,
    nIntro,
    nPower,
    nTransitions,
    nDisabling,
    nCustomTransitions,
    nSimpleWipe,
    nShake,
    nContact,
    nTransitionExpert: TTreeNode;

    procedure OnStartTransition(Sender: TObject);
    procedure OnEndTransition(Sender: TObject);

    procedure Product;
    procedure Intro;
    procedure Power;
    procedure Transitions;
    procedure Disabling;
    procedure CustomTransitions;
    procedure SimpleWipe;
    procedure Shake;
    procedure Contact;
    procedure TransitionExpert;
  end;

var
  FormNavigator: TFormNavigator;

implementation

uses Intro, Expert, Product, Power, Transitions, Contact, CustomTransitions,
  SimpleWipe, Shake, teChrono, mmSystem, Disabling;

{$R *.DFM}

procedure TFormNavigator.FormCreate(Sender: TObject);
begin
  with TreeViewNavigator do
  begin
    nProduct           := Items.Add     (nil               , 'Product information');
    nIntro             := Items.AddChild(nProduct          , 'Introduction');
    nPower             := Items.AddChild(nProduct          , 'FormContainer''s power');
    nTransitions       := Items.AddChild(nProduct          , 'Transitions');
    nDisabling         := Items.AddChild(nProduct          , 'Disabling');
    nCustomTransitions := Items.AddChild(nProduct          , 'Custom transitions');
    nSimpleWipe        := Items.AddChild(nCustomTransitions, 'Simple wipe');
    nShake             := Items.AddChild(nCustomTransitions, 'Shake');
    nContact           := Items.AddChild(nProduct          , 'Contact');
    nTransitionExpert  := Items.Add     (nil               , 'Transitions expert');

    AllowNavigatorOperations := True;
    FullExpand;
    AllowNavigatorOperations := False;
  end;

  TransEffct := TWipeTransition.Create;
  TransEffct.FlickerFreeWhenDisabled := True;
  TransEffct.Milliseconds            := 500;
  TransEffct.OnStartTransition       := OnStartTransition;
  TransEffct.OnEndTransition         := OnEndTransition;
  (TransEffct as TWipeTransition).BandWidth := 50;
  Align := fcfaDefault;
  SoundFilename := ExtractFilePath(Application.ExeName) + 'loop.wav';
end;

procedure TFormNavigator.OnStartTransition(Sender: TObject);
begin
  sndPlaySound(PChar(SoundFilename), SND_ASYNC or SND_LOOP);
end;

procedure TFormNavigator.OnEndTransition(Sender: TObject);
begin
  sndPlaySound(nil, 0);
end;

procedure TFormNavigator.TreeViewNavigatorChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  AllowChange := FormContainerNavigator.CloseQuery;
end;

procedure TFormNavigator.TreeViewNavigatorChange(Sender: TObject;
  Node: TTreeNode);
begin
  Update;

  if Node = nProduct
  then Product
  else if Node = nIntro
  then Intro
  else if Node = nPower
  then Power
  else if Node = nTransitions
  then Transitions
  else if Node = nDisabling
  then Disabling
  else if Node = nCustomTransitions
  then CustomTransitions
  else if Node = nSimpleWipe
  then SimpleWipe
  else if Node = nShake
  then Shake
  else if Node = nContact
  then Contact
  else if Node = nTransitionExpert
  then TransitionExpert;
end;

procedure TFormNavigator.Product;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormProduct := TFormProduct(FormContainerNavigator.CreateForm(TFormProduct));
    FormContainerNavigator.ShowFormEx(FormProduct, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.Intro;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormIntro := TFormIntro(FormContainerNavigator.CreateForm(TFormIntro));
    FormContainerNavigator.ShowFormEx(FormIntro, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.Power;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormPower := TFormpower(FormContainerNavigator.CreateForm(TFormPower));
    FormContainerNavigator.ShowFormEx(FormPower, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.Transitions;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormTransitions := TFormTransitions(FormContainerNavigator.CreateForm(TFormTransitions));
    FormContainerNavigator.ShowFormEx(FormTransitions, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.Disabling;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormDisabling := TFormDisabling(FormContainerNavigator.CreateForm(TFormDisabling));
    FormContainerNavigator.ShowFormEx(FormDisabling, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.CustomTransitions;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormCustomTransitions := TFormCustomTransitions(FormContainerNavigator.CreateForm(TFormCustomTransitions));
    FormContainerNavigator.ShowFormEx(FormCustomTransitions, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.SimpleWipe;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormSimpleWipe := TFormSimpleWipe(FormContainerNavigator.CreateForm(TFormSimpleWipe));
    FormContainerNavigator.ShowFormEx(FormSimpleWipe, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.Shake;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormShake := TFormShake(FormContainerNavigator.CreateForm(TFormShake));
    FormContainerNavigator.ShowFormEx(FormShake, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.Contact;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormContact := TFormContact(FormContainerNavigator.CreateForm(TFormContact));
    FormContainerNavigator.ShowFormEx(FormContact, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.TransitionExpert;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FormExpertText := TFormExpertText(FormContainerNavigator.CreateForm(TFormExpertText));
    FormContainerNavigator.ShowFormEx(FormExpertText, True, TransEffct, nil, Align);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TFormNavigator.TreeViewNavigatorCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
begin
  AllowCollapse := AllowNavigatorOperations;
end;

procedure TFormNavigator.TreeViewNavigatorExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  AllowExpansion := AllowNavigatorOperations;
end;

procedure TFormNavigator.FormShow(Sender: TObject);
begin
  TreeViewNavigator.Selected := nProduct;
end;

procedure TFormNavigator.FormDestroy(Sender: TObject);
begin
  TransEffct.Free;
end;

end.
