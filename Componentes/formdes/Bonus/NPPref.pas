(*  GREATIS BONUS * NameProp                  *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit NPPref;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmPrefixEditor = class(TForm)
    lblClass: TLabel;
    edtClass: TEdit;
    lblPrefixTitle: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    edtPrefix: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure edtPrefixChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmPrefixEditor.FormActivate(Sender: TObject);
begin
  ActiveControl:=edtClass;
  EditChange(nil);
end;

function ValidPrefix(Prefix: string): Boolean;
begin
  Result:=
    (Length(Prefix)=3) and
    (Prefix[1] in ['a'..'z','_']) and
    (Prefix[2] in ['a'..'z','_','0'..'9']) and
    (Prefix[3] in ['a'..'z','_','0'..'9']);
end;

procedure TfrmPrefixEditor.EditChange(Sender: TObject);
begin
  btnOK.Enabled:=(edtClass.Text<>'') and ValidPrefix(edtPrefix.Text);
end;

procedure TfrmPrefixEditor.edtPrefixChange(Sender: TObject);
var
  OldSel: Integer;
begin
  with edtPrefix do
  begin
    OldSel:=SelStart;
    Text:=LowerCase(Text);
    SelStart:=OldSel;
  end;
  btnOK.Enabled:=(edtClass.Text<>'') and ValidPrefix(edtPrefix.Text);
end;

end.
