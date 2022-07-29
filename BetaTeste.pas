unit BetaTeste;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type
  TFormBetaTeste = class(TForm)
    OKButton: TButton;
    Texto: TRichEdit;
    EdMostrar: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBetaTeste: TFormBetaTeste;

implementation

{$R *.DFM}

end.
 
