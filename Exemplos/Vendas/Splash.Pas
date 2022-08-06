{
   Programa.: Splash.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Jpeg, ComCtrls;

type
  TFormSplash = class(TForm)
    ImagemApresentacao: TImage;
    PanelGauge: TPanel;
    GaugeProcesso: TProgressBar;
    LbTitulo: TLabel;
    Moldura: TBevel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.DFM}

procedure TFormSplash.FormShow(Sender: TObject);
Var
  SemImagem: Boolean;
begin
  SemImagem := True;
  if (ImagemApresentacao.Picture.Graphic <> nil) then
    SemImagem := ImagemApresentacao.Picture.Graphic.Empty;
  if SemImagem then
  begin
    Moldura.Visible   := False;
    Height            := 92;
    PanelGauge.Top    := 08;
    GaugeProcesso.Top := 16;
    LbTitulo.Top      := 48;
  end;
end;

end.
