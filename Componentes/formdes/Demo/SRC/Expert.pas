unit Expert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TFormExpertText = class(TForm)
    Panel: TPanel;
    MemoText: TMemo;
    BitBtnStart: TBitBtn;
    procedure BitBtnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormExpertText: TFormExpertText;

implementation

uses TransExpert, Navigator;

{$R *.DFM}

procedure TFormExpertText.BitBtnStartClick(Sender: TObject);
begin
  FormTransitionsExpert := TFormTransitionsExpert.Create(Application.MainForm);
  try
    FormTransitionsExpert.Navigator := Parent.Parent as TFormNavigator;
    FormTransitionsExpert.ShowModal;
  finally
    FormTransitionsExpert.Free;
  end;
end;

procedure TFormExpertText.FormCreate(Sender: TObject);
begin
  if Screen.PixelsPerInch > PixelsPerInch then
    MemoText.Font.Size := 8;
  MemoText.WordWrap := True;
end;

end.
