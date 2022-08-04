(*  GREATIS BONUS * NameProp                  *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit NPFind;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmFindPrefix = class(TForm)
    lblPrefix: TLabel;
    edtPrefix: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure edtPrefixChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmFindPrefix.edtPrefixChange(Sender: TObject);
var
  OldSel: Integer;
begin
  with edtPrefix do
  begin
    OldSel:=SelStart;
    Text:=LowerCase(Text);
    SelStart:=OldSel;
  end;
  btnOK.Enabled:=Length(edtPrefix.Text)=3;
end;

end.
