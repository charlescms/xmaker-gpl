unit ExpertWindow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TFormExpertWindow = class(TForm)
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  protected
    procedure Apply; virtual;
    procedure GoToNext; virtual; abstract;
  public
    InitialBounds: TRect;

    procedure Next;
  end;

var
  FormExpertWindow: TFormExpertWindow;

implementation

uses TransExpert;

{$R *.DFM}

procedure TFormExpertWindow.Apply;
begin
end;

procedure TFormExpertWindow.FormShow(Sender: TObject);
begin
  FormTransitionsExpert.BitBtnBack.Enabled := True;
  FormTransitionsExpert.BitBtnNext.Enabled := True;
  FormTransitionsExpert.BitBtnHome.Enabled := True;

  BoundsRect := InitialBounds;
end;

procedure TFormExpertWindow.Next;
begin
  if CloseQuery then
    GotoNext;
end;

procedure TFormExpertWindow.FormCreate(Sender: TObject);
begin
  InitialBounds := BoundsRect;
end;

procedure TFormExpertWindow.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  Apply;
end;

end.
