unit Aguarde;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Gauges, ComCtrls, StdCtrls;

type
  TFormAguarde = class(TForm)
    LbTitulo: TLabel;
    GaugeProcesso: TProgressBar;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Incrementa(Qtde: Integer = 1);
  end;

var
  FormAguarde: TFormAguarde;

implementation

{$R *.DFM}

procedure TFormAguarde.Incrementa(Qtde: Integer = 1);
begin
  if Qtde = 0 then
    GaugeProcesso.Position := 0
  else
    GaugeProcesso.Position := GaugeProcesso.Position + 1;
  Application.ProcessMessages;
end;

procedure TFormAguarde.FormShow(Sender: TObject);
begin
  LbTitulo.Caption := Caption;
  Caption := '';
  Application.ProcessMessages;
end;

end.
