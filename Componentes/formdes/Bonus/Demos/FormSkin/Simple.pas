(*  GREATIS BONUS * Form Skin                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Simple;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormSkin;

type
  TfrmSimple = class(TForm)
    cmpSkin: TSimpleFormSkin;
    procedure cmpSkinTransparency(Sender: TObject; X, Y: Integer;
      var Transparent: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSimple: TfrmSimple;

implementation

{$R *.DFM}

procedure TfrmSimple.cmpSkinTransparency(Sender: TObject; X,
  Y: Integer; var Transparent: Boolean);
begin
  Transparent:=Odd(X div 5+Y div 5);
end;

end.
