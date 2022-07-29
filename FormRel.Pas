unit FormRel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, Buttons, ExtCtrls, ComCtrls, IniFiles;

type
  TFormFormRel = class(TForm)
    Panel1: TPanel;
    BtnOk: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    Lista: TCheckListBox;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NrTab: String;
    NrTabOrigem: Integer;
    Seq: Integer;
    Relacionou: Boolean;
  end;

var
  FormFormRel: TFormFormRel;

implementation

{$R *.DFM}

uses Abertura;

procedure TFormFormRel.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormFormRel.BtnOkClick(Sender: TObject);
begin
  Relacionou := True;
  Close;
end;

procedure TFormFormRel.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormFormRel.FormShow(Sender: TObject);
begin
  Relacionou := False;
end;

end.
