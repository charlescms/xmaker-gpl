{
   Programa.: Aguarde.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Aguarde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, ExtCtrls, StdCtrls, ComCtrls, Buttons;

type
  TFormAguarde = class(TForm)
    Panel1: TPanel;
    GaugeProcesso: TProgressBar;
    LbTitulo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAguarde: TFormAguarde;

implementation

{$R *.DFM}

end.
