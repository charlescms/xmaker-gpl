unit ExpertEnd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, StdCtrls, ExtCtrls, Buttons;

type
  TFormEnd = class(TFormExpertWindow)
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  FormEnd: TFormEnd;

implementation

uses TransExpert;

{$R *.DFM}

procedure TFormEnd.FormShow(Sender: TObject);
begin
  inherited;

  FormTransitionsExpert.BitBtnNext.Enabled := False;
end;

end.
