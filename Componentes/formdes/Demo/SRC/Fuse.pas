unit Fuse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExpertWindow,
  ComCtrls, StdCtrls, ExtCtrls;

type
  TFormFuse = class(TFormExpertWindow)
    Label1: TLabel;
    EditStyle: TEdit;
    UpDownStyle: TUpDown;
    procedure FormShow(Sender: TObject);
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  end;

var
  FormFuse: TFormFuse;

implementation

uses TransExpert, teFuse;

{$R *.DFM}

procedure TFormFuse.Apply;
begin
  (FormTransitionsExpert.Transition as TFuseTransition).Style :=
    UpDownStyle.Position;
end;

procedure TFormFuse.GoToNext;
begin
  FormTransitionsExpert.GoToMilliseconds;
end;

procedure TFormFuse.FormShow(Sender: TObject);
begin
  inherited;

  UpDownStyle.Max :=
    (FormTransitionsExpert.Transition as TFuseTransition).CountOfStyles;
  UpDownStyle.Position :=
    (FormTransitionsExpert.Transition as TFuseTransition).Style;
end;

end.
