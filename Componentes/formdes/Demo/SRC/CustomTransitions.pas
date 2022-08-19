unit CustomTransitions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormCustomTransitions = class(TForm)
    Panel: TPanel;
    MemoText: TMemo;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormCustomTransitions: TFormCustomTransitions;

implementation

{$R *.DFM}

procedure TFormCustomTransitions.FormCreate(Sender: TObject);
begin
  if Screen.PixelsPerInch > PixelsPerInch then
    MemoText.Font.Size := 8;
  MemoText.WordWrap := True;
end;

end.
