{
   Programa.: Sobre.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Sobre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, jpeg;

type
  TFormSobre = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    LbAnalista1: TLabel;
    LbAnalista2: TLabel;
    Bevel1: TBevel;
    LbEmpresa: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    LbTitulo1: TLabel;
    LbTitulo2: TLabel;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSobre: TFormSobre;

implementation

{$R *.DFM}

uses Publicas;

procedure TFormSobre.FormShow(Sender: TObject);

  function Nome_Projeto: String;
  begin
    Result := ExtractFileName(Application.ExeName);
    if Pos('.', Result) > 1 then
      Result := Copy(Result, 01, Pos('.', Result)-1);
  end;

begin
  LbTitulo1.Caption := Nome_Projeto + ' - Versão: ' + Sistema.Versao;
  LbTitulo2.Caption := Sistema.Titulo;
  LbAnalista1.Caption := Sistema.Analista;
  LbAnalista2.Caption := Sistema.Programador;
  LbEmpresa.Caption   := Sistema.Projetista;
end;

end.
