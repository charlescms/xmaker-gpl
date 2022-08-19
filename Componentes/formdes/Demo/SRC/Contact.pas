unit Contact;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormContact = class(TForm)
    Panel: TPanel;
    MemoText: TMemo;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormContact: TFormContact;

implementation

{$R *.DFM}


procedure TFormContact.FormCreate(Sender: TObject);
begin
  if Screen.PixelsPerInch > PixelsPerInch then
    MemoText.Font.Size := 8;
  MemoText.WordWrap := True;
end;

end.
