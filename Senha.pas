unit Senha;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons;

type
  TAcesso = class(TForm)
    Label1: TLabel;
    EdSenha: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    EdUsuario: TEdit;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Acesso: TAcesso;

implementation

{$R *.dfm}

end.
 
